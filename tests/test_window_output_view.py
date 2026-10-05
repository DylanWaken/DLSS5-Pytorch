"""CPU ABI tests and opt-in native comparison for the unused C32 output view.

Run without arguments for CPU checks. With --execute, the harness requires the
cached DLL assets/checkpoints and a candidate cubin, and tests both eager calls
and CUDA graph replay. Missing assets are reported as a skip, never a pass.
"""
from pathlib import Path
import argparse
import hashlib
import json
import struct
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tools.native_reference.lifetime import NativeGraphOwner, cli


def cases():
    # Four pixels are one packed input tile: a single tile dimension exercises
    # native broadcast reads. The 1-pixel output views independently exercise
    # scalar store bounds. All input strides remain complete 4x4 tiles.
    shapes = [(4, 4, 4, 4), (4, 12, 4, 12), (12, 4, 12, 4),
              (8, 8, 1, 1), (8, 12, 1, 9), (12, 8, 7, 1),
              (12, 20, 9, 17), (12, 20, 12, 20), (16, 24, 16, 24)]
    return [dict(height=h, width=w, view_height=vh, view_width=vw, phase=phase)
            for h, w, vh, vw in shapes for phase in range(4)]


def parameters(pointers, case):
    if len(pointers) != 3 or any(type(value) is not int or not 0 < value < 2**64 for value in pointers):
        raise ValueError("Three nonzero unsigned CUDA pointers required")
    h, w, vh, vw, phase = (case[name] for name in ("height", "width", "view_height", "view_width", "phase"))
    if any(type(value) is not int or value < 4 or value > 8192 or value % 4 for value in (h, w)):
        raise ValueError("Input dimensions must contain complete 4x4 tiles")
    if not 1 <= vh <= h or not 1 <= vw <= w or phase not in range(4):
        raise ValueError("View must be a nonempty clipped input field; phase must be 0..3")
    sx, sy = ((0, 0), (4, 4), (4, 0), (0, 4))[phase]
    blob = bytearray(96)
    struct.pack_into("<3Q4i", blob, 0, *pointers, h, w, -sx, -sy)
    struct.pack_into("<2i", blob, 72, vh, vw)
    return bytes(blob), dict(grid=[(w + sx + 7) // 8, (h + sy + 7) // 8, 1], block=[32, 1, 1])


def execute(args, report):
    import torch
    from dlssnr.checkpoint import load_checkpoint
    from tools.native_reference.session import NativeArtifacts
    from tools.native_reference.vendor_benchmark import VendorModule, guarded_tensor, GUARD_BYTES, GUARD_VALUE
    torch.set_num_threads(8)
    torch.cuda.set_device(args.device)
    stream = torch.cuda.Stream()
    torch.cuda.set_stream(stream)
    artifacts = NativeArtifacts(ROOT / "assets")
    report["native_cubin_sha256"] = hashlib.sha256(artifacts.modules[32]).hexdigest()
    candidate_code = args.cubin.read_bytes()
    report["candidate_cubin_sha256"] = hashlib.sha256(candidate_code).hexdigest()
    for precision in args.precision:
        checkpoint = load_checkpoint(ROOT / f"ckpts/dlss5_nr_{precision}.pt")
        record = checkpoint.kernel_record(1, kind="window", precision=precision).numpy().tobytes()
        dtype = torch.float8_e4m3fn if precision == "fp8" else torch.float16
        element_bytes = 1 if precision == "fp8" else 2
        original = "cc_tinlayout_fused_swin_1h_32_1_outview" + ("_fp8" if precision == "fp8" else "")
        entry = "window_block_c32_output_view_" + precision
        symbol = "semantic_window_c32_output_view_" + precision if args.standalone else f"_ZN6dlssnr13reconstructed{len(entry)}{entry}{len(entry)}{entry}ENS1_10ParametersE"
        with NativeGraphOwner(stream.synchronize, label="C32 output-view comparison") as owner:
            native = owner.own(VendorModule(artifacts.modules[32], stream.cuda_stream, original, 96))
            candidate = owner.own(VendorModule(candidate_code, stream.cuda_stream, symbol, 96))
            weight, weight_pointer = owner.retain(guarded_tensor(record, args.device))
            weight_golden = owner.retain(weight.clone())
            for case in cases():
                h, w, vh, vw = (case[name] for name in ("height", "width", "view_height", "view_width"))
                # Bounded finite Half values before publication avoid arbitrary
                # NaN input codes while exercising every physical channel lane.
                torch.manual_seed(1000 + case["phase"] + h * 31 + w)
                values = (torch.randn(h * w * 32, dtype=torch.float16, device="cuda") * .025).to(dtype)
                physical_input = values.view(torch.uint8).cpu().numpy().tobytes()
                state, state_pointer = owner.retain(guarded_tensor(physical_input, args.device))
                state_golden = owner.retain(state.clone())
                outputs = [owner.retain(guarded_tensor(bytes([0x6a]) * (vh * vw * 32 * element_bytes), args.device)) for _ in range(2)]
                blobs = [parameters([state_pointer, output[1], weight_pointer], case)[0] for output in outputs]
                launch = parameters([state_pointer, outputs[0][1], weight_pointer], case)[1]
                row = dict(precision=precision, **case, eager={}, graph_replays=[], native_resources=native.attributes,
                           candidate_resources=candidate.attributes)
                report["comparisons"].append(row)

                def compare():
                    stream.synchronize()
                    left, right = (output[0][GUARD_BYTES:-GUARD_BYTES] for output in outputs)
                    different = int(torch.count_nonzero(left != right))
                    guards = all(bool(torch.all(tensor[:GUARD_BYTES] == GUARD_VALUE)) and
                                 bool(torch.all(tensor[-GUARD_BYTES:] == GUARD_VALUE))
                                 for tensor in [state, weight] + [output[0] for output in outputs])
                    result = dict(different_bytes=different, guards_intact=guards,
                                  inputs_immutable=torch.equal(state, state_golden), weights_immutable=torch.equal(weight, weight_golden))
                    if different: result["first_differences"] = torch.nonzero(left != right).flatten()[:16].tolist()
                    result["pass"] = different == 0 and guards and result["inputs_immutable"] and result["weights_immutable"]
                    return result

                native.launch(blobs[0], launch)
                candidate.launch(blobs[1], launch)
                row["eager"] = compare()
                if not row["eager"]["pass"]:
                    report["pass"] = False
                    return
                graphs = []
                for module, blob in ((native, blobs[0]), (candidate, blobs[1])):
                    graph = owner.graph(torch.cuda.CUDAGraph())
                    with owner.capture(graph, torch.cuda.graph(graph, stream=stream)):
                        module.launch(blob, launch)
                    graphs.append(graph)
                for replay in range(3):
                    for output, _ in outputs: output[GUARD_BYTES:-GUARD_BYTES].fill_(0x6b + replay)
                    for graph in graphs: graph.replay()
                    result = compare()
                    result["replay"] = replay
                    row["graph_replays"].append(result)
                    if not result["pass"]:
                        report["pass"] = False
                        return
                row["pass"] = True
                print(json.dumps(row), flush=True)
                args.output.write_text(json.dumps(report, indent=2))
    report["pass"] = bool(report["comparisons"]) and all(row["pass"] for row in report["comparisons"])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--execute", action="store_true")
    parser.add_argument("--cubin", type=Path, required=True)
    parser.add_argument("--precision", choices=["fp8", "fp16"], nargs="+", default=["fp8", "fp16"])
    parser.add_argument("--standalone", action="store_true")
    parser.add_argument("--device", type=int, default=0)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    report = dict(executed=False, prepared_cases=len(cases()) * len(args.precision), comparisons=[],
                  scope="C32 output view, four phases, single input tiles, scalar clipped view edges, eager and CUDA graph replay")
    required = [args.cubin, ROOT / "assets/original/nvngx_dlssnr.dll"]
    required += [ROOT / f"assets/vendor_modules/module_{index}.cubin" for index in range(7)]
    required += [ROOT / f"ckpts/dlss5_nr_{precision}.pt" for precision in args.precision]
    args.output.parent.mkdir(parents=True, exist_ok=True)
    try:
        missing = [str(path) for path in required if not path.is_file()]
        if args.execute and missing:
            report.update(skipped=True, missing_assets=missing)
            print("SKIP: Native output-view comparison requires cached DLL assets, checkpoint and candidate cubin.")
        elif args.execute:
            report["executed"] = True
            execute(args, report)
    except BaseException as error:
        report["failure"] = f"{type(error).__name__}: {error}"
        raise
    finally:
        args.output.write_text(json.dumps(report, indent=2))
    return 0 if not args.execute or report.get("skipped") or report.get("pass") else 1


class OutputViewAbiTests(unittest.TestCase):
    def test_four_phase_launches_and_auxiliary_dimensions(self):
        for phase, origin in enumerate(((0, 0), (-4, -4), (-4, 0), (0, -4))):
            case = dict(height=12, width=20, view_height=9, view_width=17, phase=phase)
            blob, launch = parameters([11, 22, 33], case)
            self.assertEqual(len(blob), 96)
            self.assertEqual(struct.unpack_from("<3Q4i", blob), (11, 22, 33, 12, 20, *origin))
            self.assertEqual(struct.unpack_from("<2i", blob, 72), (9, 17))
            self.assertEqual(launch["block"], [32, 1, 1])
            self.assertEqual(launch["grid"], [(20 - origin[0] + 7) // 8, (12 - origin[1] + 7) // 8, 1])

    def test_cases_cover_single_tile_and_single_pixel_boundaries(self):
        self.assertEqual(len(cases()), 36)
        self.assertEqual({case["phase"] for case in cases()}, {0, 1, 2, 3})
        for case in cases():
            parameters([11, 22, 33], case)
        self.assertTrue(any(case["height"] == 4 for case in cases()))
        self.assertTrue(any(case["width"] == 4 for case in cases()))
        self.assertTrue(any(case["view_height"] == case["view_width"] == 1 for case in cases()))


if __name__ == "__main__":
    if len(sys.argv) == 1: unittest.main()
    else: raise SystemExit(cli(main))
