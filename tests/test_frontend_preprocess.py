"""Compare full preprocessing CUDA against unchanged DLL cubins in a worker.

With no arguments this runs CPU ABI tests. CLI arguments prepare a comparison;
--execute explicitly enables Driver calls and requires the cached DLL assets,
native cubins, checkpoint and candidate cubin. Missing assets produce a recorded
skip rather than a false correctness result.
Fixtures use reviewed RGBA CUDA arrays and include history/depth/conditioning
branches with bounded transforms. They do not claim renderer integration.
"""
from pathlib import Path
import argparse
import hashlib
import json
import statistics
import struct
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tools.native_reference.lifetime import NativeGraphOwner, cli


def no_history_parameters(texture,output,weight,height,width,*,capture=0,seed=20261003):
    """Reviewed bounded fixture ABI; nonzero capture applies only to instrumentation.

    The unchanged pre0 entry does not read slot232. Constant proxy textures
    make sampling independent of unresolved renderer transform conventions.
    This fixture does not establish the renderer's ordinary conditioning ABI.
    """
    if any(type(value) is not int or not 0<value<2**64 for value in (texture,output,weight)):
        raise ValueError("nonzero texture, output and weight handles required")
    if type(capture) is not int or not 0<=capture<2**64:raise ValueError("invalid capture pointer")
    if any(type(value) is not int or value<8 or value>256 or value%8 for value in (height,width)):
        raise ValueError("pre0 fixture fields must be8..256 multiples8")
    if type(seed) is not int or not 0<=seed<2**32:raise ValueError("uint32 seed required")
    blob=bytearray(264)
    struct.pack_into("<Q",blob,0,texture)
    # Identity pixel-space proxy transform followed by inverse texture extent.
    struct.pack_into("<6f",blob,136,0.,0.,float(width),float(height),1./width,1./height)
    struct.pack_into("<4f",blob,168,0.,.25,.5,.25)
    struct.pack_into("<2fifI",blob,184,-1.,-1.,1,.0625,seed)
    struct.pack_into("<2i3Q2i",blob,208,height,width,output,weight,capture,height,width)
    return bytes(blob),{"block":[32,1,1],"grid":[width//8,height//8,1]}


def fp16_pre_record(checkpoint):
    """The input adapter stays Half; all former E4 matrices widen losslessly."""
    import torch
    from dlssnr.checkpoint import _natural, _half_matrix, _half_bias, promote_tensor
    layout = dict(w1=0, w2=8192, input_adapter=16400, ffn_scale=17424,
                  qkv=17504, bias=23648, head_scale=31840, projection=31856, attn_scale=33904)
    output = bytearray(33984)
    for name, rows, columns in (("w1", 32, 128), ("w2", 128, 32), ("input_adapter", 16, 32),
                               ("qkv", 32, 96), ("projection", 32, 32)):
        raw = _half_matrix(_natural(checkpoint._state, 0, name), rows, columns)
        output[layout[name]:layout[name] + len(raw)] = raw
    for name in ("ffn_scale", "attn_scale", "head_scale"):
        dtype = torch.float32 if name == "head_scale" else torch.float16
        raw = promote_tensor(_natural(checkpoint._state, 0, name), dtype).numpy().tobytes()
        output[layout[name]:layout[name] + len(raw)] = raw
    raw = _half_bias(_natural(checkpoint._state, 0, "bias"))
    output[layout["bias"]:layout["bias"] + len(raw)] = raw
    return bytes(output)


def parameters(handles, output, weight, pooled, height, width, seed, case):
    blob, launch = no_history_parameters(handles[0], output, weight, height, width, seed=seed)
    blob = bytearray(blob)
    # Every transform is identity in normalized coordinates. Spatial gradients
    # make corner selection, mirror borders and history coordinates observable.
    for offset in (40, 64, 88, 112, 136):
        struct.pack_into("<6f", blob, offset, 0., 0., float(width), float(height), 1. / width, 1. / height)
    struct.pack_into("<2f", blob, 160, 1. / width, 1. / height)
    if case in ("history", "depth_min", "depth_max", "conditioning", "conditioning_override", "mirror"):
        struct.pack_into("<2Q", blob, 8, handles[1], handles[2])
    if case in ("depth_min", "depth_max", "mirror"):
        struct.pack_into("<Q", blob, 24, handles[3])
        struct.pack_into("<I", blob, 168, int(case != "depth_min"))
    if case in ("conditioning", "conditioning_override"):
        struct.pack_into("<Q", blob, 32, handles[4])
        struct.pack_into("<I", blob, 192, int(case == "conditioning_override"))
    if case == "explicit_override":
        struct.pack_into("<2f", blob, 184, -.5, .375)
    if case == "mirror":
        struct.pack_into("<2i", blob, 208, height - 3, width - 5)
    if pooled:
        struct.pack_into("<Q2i", blob, 248, pooled, height // 2, width // 2)
    return bytes(blob), launch


def execute(args, report):
    import numpy as np
    import torch
    from dlssnr.checkpoint import load_checkpoint
    from tools.native_reference.vendor_benchmark import VendorModule, guarded_tensor, GUARD_BYTES, GUARD_VALUE
    from tools.native_reference.session import NativeArtifacts
    torch.set_num_threads(8)
    torch.cuda.set_device(args.device)
    stream = torch.cuda.Stream()
    torch.cuda.set_stream(stream)
    artifacts = NativeArtifacts(ROOT / "assets")
    checkpoint = load_checkpoint(ROOT / f"ckpts/dlss5_nr_{args.precision}.pt")
    raw_record = fp16_pre_record(checkpoint) if args.precision == "fp16" else checkpoint._records["block0.layer0.layer"].numpy().tobytes()
    report["weight_sha256"] = hashlib.sha256(raw_record).hexdigest()
    report["native_cubin_sha256"] = hashlib.sha256(artifacts.modules[32]).hexdigest()
    report["candidate_cubin_sha256"] = hashlib.sha256(args.cubin.read_bytes()).hexdigest()
    element_bytes = 1 if args.precision == "fp8" else 2
    height, width = args.height, args.width
    with NativeGraphOwner(stream.synchronize, label="preprocess semantic comparison") as owner:
        allocation = lambda raw: owner.retain(guarded_tensor(raw, args.device))
        weights = allocation(raw_record)
        golden_weights = owner.retain(weights[0].clone())
        full_bytes, pool_bytes = height * width * 32 * element_bytes, height * width * 8 * element_bytes
        outputs = [allocation(bytes([0x6a]) * full_bytes) for _ in range(2)]
        pools = [allocation(bytes([0x6a]) * pool_bytes) for _ in range(2)]
        probe = owner.own(VendorModule(artifacts.modules[32], stream.cuda_stream,
            "cc_tinlayout_fused_pre_block_swin_1h_32_1" + ("_fp8" if args.precision == "fp8" else ""), 264))
        from tests.native_cuda_image import CudaImage
        images = [owner.own(CudaImage(probe, height, width, args.device, linear=args.linear)) for _ in range(5)]
        y, x = np.mgrid[:height, :width].astype(np.float32)
        pixel_values = [np.stack((x / width, y / height, (x + y) / (width + height), np.ones_like(x)), -1),
                        np.stack((y / height, 1 - x / width, .2 + x / (2 * width), np.ones_like(x)), -1),
                        np.stack((np.sin(x) * .7, np.cos(y) * .9, np.zeros_like(x), np.ones_like(x)), -1),
                        np.stack((np.sin(x * 1.7) + np.cos(y * 1.3), x / width, y / height, np.ones_like(x)), -1),
                        np.stack((np.ones_like(x), .25 + x / width, .125 + y / height, np.ones_like(x)), -1)]
        image_tensors = [owner.retain(torch.from_numpy(value).to(device="cuda", dtype=torch.float32)) for value in pixel_values]
        for image, values in zip(images, image_tensors): image.copy_from(values)
        handles = [image.texture.value for image in images]
        for downsample in (False, True):
            native_name = "cc_tinlayout_fused_pre_block_swin_1h_32_1" + ("_ds" if downsample else "") + ("_fp8" if args.precision == "fp8" else "")
            candidate_name = "input_preprocess_window" + ("_downsample" if downsample else "") + "_c32_" + args.precision
            candidate_symbol = "semantic_" + candidate_name if args.standalone else candidate_name
            native = owner.own(VendorModule(artifacts.modules[32], stream.cuda_stream, native_name, 264))
            candidate = owner.own(VendorModule(args.cubin.read_bytes(), stream.cuda_stream, candidate_symbol, 264))
            for case in args.cases:
                for seed in args.seeds:
                    blobs = [parameters(handles, outputs[role][1], weights[1], pools[role][1] if downsample else 0,
                                        height, width, seed, case)[0] for role in range(2)]
                    launch = dict(grid=[width // 8, height // 8, 1], block=[32, 1, 1])
                    row = dict(entry=candidate_name, case=case, seed=seed, downsample=downsample,
                               native_resources=native.attributes, candidate_resources=candidate.attributes, replays=[])
                    report["comparisons"].append(row)
                    for replay in range(3):
                        for value, _ in outputs + pools: value[GUARD_BYTES:-GUARD_BYTES].fill_(0x6a + replay)
                        native.launch(blobs[0], launch)
                        candidate.launch(blobs[1], launch)
                        stream.synchronize()
                        payloads = [outputs] + ([pools] if downsample else [])
                        different = [int(torch.count_nonzero(pair[0][0][GUARD_BYTES:-GUARD_BYTES] != pair[1][0][GUARD_BYTES:-GUARD_BYTES])) for pair in payloads]
                        guards = all(bool(torch.all(value[:GUARD_BYTES] == GUARD_VALUE)) and bool(torch.all(value[-GUARD_BYTES:] == GUARD_VALUE)) for value, _ in outputs + pools + [weights])
                        immutable = torch.equal(weights[0], golden_weights)
                        item = dict(replay=replay, different_output_bytes=different[0], different_pool_bytes=different[1] if downsample else 0,
                                    guards_intact=guards, weights_immutable=immutable)
                        row["replays"].append(item)
                        if any(different) or not guards or not immutable:
                            row["equal"] = False
                            report["pass"] = False
                            return
                    row["equal"] = True
                    if args.timing and case == args.cases[0] and seed == args.seeds[0]:
                        graphs = []
                        for module, blob in ((native, blobs[0]), (candidate, blobs[1])):
                            graph = owner.graph(torch.cuda.CUDAGraph())
                            with owner.capture(graph, torch.cuda.graph(graph, stream=stream)):
                                for _ in range(64): module.launch(blob, launch)
                            graphs.append(graph)
                        for _ in range(6):
                            for graph in graphs: graph.replay()
                        times = [[], []]
                        for repeat in range(16):
                            for role in ((0, 1) if repeat % 2 else (1, 0)):
                                begin, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
                                begin.record(stream); graphs[role].replay(); end.record(stream); end.synchronize()
                                times[role].append(begin.elapsed_time(end) * 1000 / 64)
                        row["native_us"], row["candidate_us"] = map(statistics.median, times)
                        row["ratio"] = row["candidate_us"] / row["native_us"]
                    print(json.dumps(row), flush=True)
                    args.output.write_text(json.dumps(report, indent=2))
        report["pass"] = all(row["equal"] for row in report["comparisons"])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--execute", action="store_true")
    parser.add_argument("--cubin", type=Path, required=True)
    parser.add_argument("--precision", choices=["fp8", "fp16"], required=True)
    parser.add_argument("--standalone", action="store_true", help="Use semantic_* extern-C entry names")
    parser.add_argument("--height", type=int, default=24)
    parser.add_argument("--width", type=int, default=32)
    parser.add_argument("--device", type=int, default=0)
    parser.add_argument("--seeds", type=int, nargs="+", default=[0, 20261003])
    parser.add_argument("--cases", nargs="+", default=["current", "history", "depth_min", "depth_max", "conditioning", "conditioning_override", "explicit_override", "mirror"])
    parser.add_argument("--timing", action="store_true")
    parser.add_argument("--linear", action="store_true", help="Use linear texture filtering instead of point sampling")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    parameters([1, 2, 3, 4, 5], 6, 7, 8, args.height, args.width, args.seeds[0], args.cases[0])
    report = dict(executed=args.execute, precision=args.precision, height=args.height, width=args.width, linear=args.linear,
                  comparisons=[], scope="Unchanged DLL pre/pre-downsample against semantic CUDA with texture fixtures; renderer integration not claimed")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    try:
        required = [args.cubin, ROOT / f"ckpts/dlss5_nr_{args.precision}.pt", ROOT / "assets/original/nvngx_dlssnr.dll"]
        required.extend(ROOT / f"assets/vendor_modules/module_{index}.cubin" for index in range(7))
        missing = [str(path) for path in required if not path.is_file()]
        if args.execute and missing:
            report.update(executed=False, skipped=True, missing_assets=missing)
            print("SKIP: Native frontend comparison requires cached DLL assets, checkpoint and candidate cubin.")
        elif args.execute: execute(args, report)
        else: report["prepared_cases"] = len(args.cases) * len(args.seeds) * 2
    except BaseException as error:
        report["failure"] = f"{type(error).__name__}: {error}"
        raise
    finally:
        args.output.write_text(json.dumps(report, indent=2))
    return 0 if not args.execute or report.get("pass") or report.get("skipped") else 1


class FrontendPreprocessAbiTests(unittest.TestCase):
    def test_native_parameter_offsets_and_unused_slot(self):
        blob, launch = no_history_parameters(11, 22, 33, 16, 24, capture=44, seed=123)
        self.assertEqual(len(blob), 264)
        self.assertEqual(struct.unpack_from("<5Q", blob), (11, 0, 0, 0, 0))
        self.assertEqual(struct.unpack_from("<2i3Q2i", blob, 208), (16, 24, 22, 33, 44, 16, 24))
        self.assertEqual(struct.unpack_from("<2fifI", blob, 184), (-1., -1., 1, .0625, 123))
        self.assertEqual(launch, {"block": [32, 1, 1], "grid": [3, 2, 1]})
        ordinary, _ = no_history_parameters(11, 22, 33, 16, 24)
        self.assertEqual(struct.unpack_from("<Q", ordinary, 232), (0,))
        with self.assertRaises(ValueError): no_history_parameters(11, 22, 33, 7, 24)

    def test_history_depth_and_pool_fields_remain_disjoint(self):
        blob, _ = parameters([11, 12, 13, 14, 15], 22, 33, 44, 24, 32, 7, "depth_max")
        self.assertEqual(struct.unpack_from("<5Q", blob), (11, 12, 13, 14, 0))
        self.assertEqual(struct.unpack_from("<I", blob, 168), (1,))
        self.assertEqual(struct.unpack_from("<Q2i", blob, 248), (44, 12, 16))
        self.assertEqual(struct.unpack_from("<2i", blob, 240), (24, 32))
        mirror, _ = parameters([11, 12, 13, 14, 15], 22, 33, 44, 24, 32, 7, "mirror")
        self.assertEqual(struct.unpack_from("<2i", mirror, 208), (21, 27))
        self.assertEqual(struct.unpack_from("<2i", mirror, 240), (24, 32))

    def test_reviewed_x64_cuda_driver_image_abi(self):
        import ctypes as C
        from tests.native_cuda_image import ArrayDescriptor, ResourceDescriptor, TextureDescriptor, Copy2D
        if C.sizeof(C.c_void_p) != 8: self.skipTest("Reviewed CUDA Driver image ABI is 64-bit")
        self.assertEqual(C.sizeof(ArrayDescriptor), 40)
        self.assertEqual(C.sizeof(ResourceDescriptor), 144)
        self.assertEqual(ResourceDescriptor.res.offset, 8)
        self.assertEqual(ResourceDescriptor.flags.offset, 136)
        self.assertEqual(C.sizeof(TextureDescriptor), 104)
        self.assertEqual(C.sizeof(Copy2D), 128)
        self.assertEqual(Copy2D.srcArray.offset, 40)
        self.assertEqual(Copy2D.dstArray.offset, 96)
        self.assertEqual(Copy2D.WidthInBytes.offset, 112)


if __name__ == "__main__":
    if len(sys.argv) == 1: unittest.main()
    else: raise SystemExit(cli(main))
