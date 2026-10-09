"""Six frontend Torch operators: native DLL parity, live tensors, graphs and compile.

Run with --execute after building the extension. Preparation owns CUDA images;
all six named operators expose their tensor reads/writes to torch.compile. This
worker retains handles and image resources through graph reset. It compares the
actual pinned native DLL cubins, not a second copy of the reconstruction.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import struct
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))


def abi_template(blob, offsets):
    """Keep scalar configuration while removing every native address/handle."""
    result = bytearray(blob)
    for offset in offsets:
        struct.pack_into("<Q", result, offset, 0)
    return result


class NativeFrontendFixture:
    """Own independent native CUDA textures plus one exported DLL function."""

    def __init__(self, precision, downsample, postprocess, case, height, width, linear, stream):
        import torch
        from dlssnr.checkpoint import load_checkpoint
        from tests.native_cuda_image import CudaImage
        from tests.test_frontend_preprocess import fp16_pre_record, parameters as pre_parameters
        from tests.test_frontend_postprocess import native_assets, parameters as post_parameters
        from tools.native_reference.session import NativeArtifacts
        from tools.native_reference.vendor_benchmark import VendorModule

        self.torch, self.stream = torch, stream
        self.images, self.surface, self.native = [], None, None
        self.owner = None
        self.postprocess, self.downsample = postprocess, downsample
        self.case, self.height, self.width = case, height, width
        self.name = ("output_window_postprocess" if postprocess else
                     "input_preprocess_window" + ("_downsample" if downsample else "")) + "_c32_" + precision
        dtype = torch.float8_e4m3fn if precision == "fp8" else torch.float16
        element_bytes = 1 if precision == "fp8" else 2
        generator = torch.Generator(device="cpu").manual_seed(20261006)
        to_bytes = lambda raw: torch.tensor(list(raw), dtype=torch.uint8, device="cuda")
        empty_texture = lambda: torch.empty(0, dtype=torch.float32, device="cuda")
        y, x = torch.meshgrid(torch.arange(height, device="cuda", dtype=torch.float32),
                              torch.arange(width, device="cuda", dtype=torch.float32), indexing="ij")
        textures = [torch.stack((x / width, y / height, (x + y) / (width + height), torch.ones_like(x)), -1),
                    torch.stack((y / height, 1 - x / width, .2 + x / (2 * width), torch.ones_like(x)), -1),
                    torch.stack((torch.sin(x) * .7, torch.cos(y) * .9, torch.zeros_like(x), torch.ones_like(x)), -1),
                    torch.stack((torch.sin(x * 1.7) + torch.cos(y * 1.3), x / width, y / height, torch.ones_like(x)), -1),
                    torch.stack((torch.ones_like(x), .25 + x / width, .125 + y / height, torch.ones_like(x)), -1)]
        try:
            checkpoint = load_checkpoint(ROOT / f"ckpts/dlss5_nr_{precision}.pt")
            if postprocess:
                code, record = native_assets(precision)
                symbol = "cc_tinlayout_fused_post_block_swin_1h_32" + ("_fp8" if precision == "fp8" else "")
            else:
                record = fp16_pre_record(checkpoint) if precision == "fp16" else checkpoint._records["block0.layer0.layer"].numpy().tobytes()
                code = NativeArtifacts(ROOT / "assets").modules[32]
                symbol = "cc_tinlayout_fused_pre_block_swin_1h_32_1" + ("_ds" if downsample else "") + ("_fp8" if precision == "fp8" else "")
            public_record = checkpoint.kernel_record(70 if postprocess else 0,
                kind="postprocess" if postprocess else "preprocess", precision=precision, device="cuda")
            record_bytes = {(False, "fp8"): 21696, (False, "fp16"): 33984,
                            (True, "fp8"): 21808, (True, "fp16"): 34096}[postprocess, precision]
            assert public_record.dtype == torch.uint8 and public_record.shape == (record_bytes,) and public_record.is_contiguous(), "public frontend record byte ABI changed"
            assert public_record.cpu().numpy().tobytes() == record, "public checkpoint record differs from independent native fixture packing"
            self.native = VendorModule(code, stream.cuda_stream, symbol, 184 if postprocess else 264)
            self.provenance = {"native_sha256": hashlib.sha256(code).hexdigest(),
                               "record_sha256": hashlib.sha256(record).hexdigest(), "record_bytes": len(record),
                               "public_checkpoint_record_exact": True}
            for _ in range(3 if postprocess else 5):
                self.images.append(CudaImage(self.native, height, width, torch.cuda.current_device(), linear=linear))
            if postprocess:
                self.surface = CudaImage(self.native, height, width, torch.cuda.current_device(), texture=False)
                state = (torch.randn(height * width * 8, generator=generator) * .02).to(dtype).view(torch.uint8).cuda()
                adapter = (torch.randn(height * width * 32, generator=generator) * .02).to(dtype).view(torch.uint8).cuda()
                self.inputs = [state, adapter, public_record, *textures[:3], to_bytes(struct.pack("<e", .625))]
                self.outputs = [torch.full((height, width, 4), -123.25, device="cuda", dtype=torch.float32)]
                images = dict(zip(("color", "history", "motion"), self.images))
                valid = (width - 3, height - 5) if case == "history_padded" else (width, height)
                blob, self.launch = post_parameters(state.data_ptr(), adapter.data_ptr(), self.surface.surface.value,
                    self.inputs[2].data_ptr(), height, width, 3, case, images, self.inputs[6].data_ptr(), valid)
                self.texture_slots = (3, 4, 5)
                self.texture_offsets = (56, 88, 96)
                if not struct.unpack_from("<Q", blob, 104)[0]:
                    self.inputs[6] = torch.empty(0, dtype=torch.uint8, device="cuda")
                self.configuration = abi_template(blob, (0, 8, 16, 24, 56, 88, 96, 104))
            else:
                self.inputs = [public_record, *textures]
                self.outputs = [torch.full((height * width * 32 * element_bytes,), 0x6a, device="cuda", dtype=torch.uint8)]
                if downsample:
                    self.outputs.append(torch.full((height * width * 8 * element_bytes,), 0x6a, device="cuda", dtype=torch.uint8))
                blob, self.launch = pre_parameters([image.texture.value for image in self.images],
                    self.outputs[0].data_ptr(), self.inputs[0].data_ptr(), self.outputs[1].data_ptr() if downsample else 0,
                    height, width, 20261006, case)
                self.texture_slots = (1, 2, 3, 4, 5)
                self.texture_offsets = (0, 8, 16, 24, 32)
                self.configuration = abi_template(blob, (0, 8, 16, 24, 32, 216, 224, 232, 248))
            for slot, offset in zip(self.texture_slots, self.texture_offsets):
                if not struct.unpack_from("<Q", blob, offset)[0]:
                    self.inputs[slot] = empty_texture()
            self.config_tensor = torch.tensor(list(self.configuration), dtype=torch.uint8)
        except BaseException:
            self.close()
            raise

    def reference(self, inputs, initial_outputs):
        torch = self.torch
        outputs = [value.clone() for value in initial_outputs]
        blob = bytearray(self.configuration)
        for slot, offset, image in zip(self.texture_slots, self.texture_offsets, self.images):
            if inputs[slot].numel():
                image.copy_from(inputs[slot])
                struct.pack_into("<Q", blob, offset, image.texture.value)
        if self.postprocess:
            self.surface.copy_from(outputs[0])
            struct.pack_into("<4Q", blob, 0, inputs[0].data_ptr(), inputs[1].data_ptr(),
                             self.surface.surface.value, inputs[2].data_ptr())
            struct.pack_into("<Q", blob, 104, inputs[6].data_ptr() if inputs[6].numel() else 0)
        else:
            struct.pack_into("<2Q", blob, 216, outputs[0].data_ptr(), inputs[0].data_ptr())
            struct.pack_into("<Q", blob, 248, outputs[1].data_ptr() if self.downsample else 0)
        self.native.launch(bytes(blob), self.launch)
        if self.postprocess:
            self.surface.copy_to(outputs[0])
        self.stream.synchronize()
        return outputs

    def change_inputs(self, inputs):
        if self.postprocess:
            # Alter low state in its native precision without changing byte extent.
            dtype = self.torch.float8_e4m3fn if self.name.endswith("_fp8") else self.torch.float16
            values = inputs[0].view(dtype).float()
            inputs[0].copy_((values * .5 + .03125).to(dtype).view(self.torch.uint8))
        else:
            inputs[1][..., :3].mul_(.5).add_(.125)

    def close(self):
        if getattr(self, "stream", None) is not None:
            self.stream.synchronize()
        self.owner = None
        if self.surface is not None:
            self.surface.close()
            self.surface = None
        for image in reversed(self.images):
            image.close()
        self.images.clear()
        if self.native is not None:
            self.native.close()
            self.native = None


def assert_exact(actual, expected, label):
    import torch
    assert len(actual) == len(expected), label
    for index, (left, right) in enumerate(zip(actual, expected)):
        assert torch.equal(left.view(torch.uint8), right.view(torch.uint8)), f"{label}: output {index} differs from DLL"


def expected_prepare_failure(ops, fixture, configuration, outputs, fragment):
    try:
        ops.prepare_frontend(fixture.name, configuration, fixture.inputs, outputs, False)
    except RuntimeError as error:
        assert fragment in str(error), str(error)
    else:
        raise AssertionError("invalid frontend contract was admitted")


def qualify_fixture(ops, fixture, linear, compile_case):
    import torch
    builder_default = fixture.case in ("no_history", "raw")
    if builder_default:
        fixture.config_tensor = ops.frontend_configuration(fixture.name, fixture.height, fixture.width,
            0, 0, 3 if fixture.postprocess else 0, 20261006)
        assert fixture.config_tensor.device.type == "cpu" and fixture.config_tensor.dtype == torch.uint8
        assert fixture.config_tensor.numel() == (184 if fixture.postprocess else 264)
        fixture.configuration = bytearray(fixture.config_tensor.tolist())
        offsets = (0, 8, 16, 24, 56, 88, 96, 104) if fixture.postprocess else (0, 8, 16, 24, 32, 216, 224, 232, 248)
        assert all(struct.unpack_from("<Q", fixture.configuration, offset)[0] == 0 for offset in offsets)
    fixture.owner = ops.prepare_frontend(fixture.name, fixture.config_tensor, fixture.inputs, fixture.outputs, linear)
    operation = getattr(ops, fixture.name).default
    handle_id = fixture.owner.id()
    expected = fixture.reference(fixture.inputs, fixture.outputs)
    operation(fixture.inputs, fixture.outputs, handle_id)
    fixture.stream.synchronize()
    assert_exact(fixture.outputs, expected, "eager")
    row = {"entry": fixture.name, **fixture.provenance, "eager_native_exact": True,
           "typed_default_configuration": builder_default}

    # Passing new storages must use those arguments rather than preparation-time pointers.
    live_inputs, live_outputs = [x.clone() for x in fixture.inputs], [x.clone() for x in fixture.outputs]
    fixture.change_inputs(live_inputs)
    expected_changed = fixture.reference(live_inputs, live_outputs)
    assert any(not torch.equal(a.view(torch.uint8), b.view(torch.uint8)) for a, b in zip(expected, expected_changed)), "fixture must expose a changed input"
    operation(live_inputs, live_outputs, handle_id)
    fixture.stream.synchronize()
    assert_exact(live_outputs, expected_changed, "rebound input storage")
    row["rebound_storage_exact"] = True

    graph = torch.cuda.CUDAGraph()
    try:
        for _ in range(2):
            operation(live_inputs, live_outputs, handle_id)
        fixture.stream.synchronize()
        with torch.cuda.graph(graph, stream=fixture.stream):
            operation(live_inputs, live_outputs, handle_id)
        fixture.change_inputs(live_inputs)
        expected_replay = fixture.reference(live_inputs, live_outputs)
        graph.replay()
        fixture.stream.synchronize()
        assert_exact(live_outputs, expected_replay, "graph changed texture/state")
        row["capture_live_input_exact"] = True
    finally:
        fixture.stream.synchronize()
        graph.reset()

    bad_config = fixture.config_tensor.clone()
    bad_config[0] = 1
    expected_prepare_failure(ops, fixture, bad_config, fixture.outputs, "zero pointers")
    bad_outputs = list(fixture.outputs)
    bad_outputs[0] = bad_outputs[0].reshape(-1)[:-1]
    expected_prepare_failure(ops, fixture, fixture.config_tensor, bad_outputs, "dtype/shape")
    row["invalid_address_and_extent_rejected"] = True

    if compile_case:
        # These are six different prepared programs tested with two backends.
        # Isolate their compiler caches: the shared fixture closure is otherwise
        # mistaken for one application recompiling past Dynamo's eight-entry limit.
        torch.compiler.reset()
        input_count = len(live_inputs)
        def invoke(*tensors):
            operation(list(tensors[:input_count]), list(tensors[input_count:]), handle_id)
            # Explicit tensor consumers exercise dispatcher mutation/dependency visibility.
            return tuple(value.clone() for value in tensors[input_count:])
        compile_inputs, compile_outputs = [x.clone() for x in live_inputs], [x.clone() for x in live_outputs]
        fixture.change_inputs(compile_inputs)
        expected_compile = fixture.reference(compile_inputs, compile_outputs)
        try:
            compiled = torch.compile(invoke, fullgraph=True)
            returned = compiled(*(compile_inputs + compile_outputs))
            fixture.stream.synchronize()
            assert_exact(returned, expected_compile, "default torch.compile returned output")
            assert_exact(compile_outputs, expected_compile, "default torch.compile mutations")
            fixture.change_inputs(compile_inputs)
            expected_compile = fixture.reference(compile_inputs, compile_outputs)
            returned = compiled(*(compile_inputs + compile_outputs))
            fixture.stream.synchronize()
            assert_exact(returned, expected_compile, "default torch.compile changed input")
            row["compile_default"] = "passed"
        except Exception as error:
            message = str(error)
            cause, seen, unsupported = error, set(), False
            while cause is not None and id(cause) not in seen:
                seen.add(id(cause))
                unsupported |= type(cause).__name__ == "TritonMissing" or (
                    isinstance(cause, ModuleNotFoundError) and cause.name == "triton")
                cause = cause.__cause__ or cause.__context__
            if not unsupported:
                raise
            row["compile_default"] = "unsupported_windows_inductor"
            row["compile_default_reason"] = type(error).__name__ + ": " + message[:1500]
        # AOT eager is also a fullgraph compiler and exercises functionalization.
        compiled_eager = torch.compile(invoke, backend="aot_eager", fullgraph=True)
        returned = compiled_eager(*(compile_inputs + compile_outputs))
        fixture.stream.synchronize()
        assert_exact(returned, expected_compile, "AOT eager returned output")
        assert_exact(compile_outputs, expected_compile, "AOT eager mutations")
        row["compile_aot_eager"] = "passed"
    return row


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--execute", action="store_true")
    parser.add_argument("--extension", type=Path)
    parser.add_argument("--precision", nargs='+', choices=("fp8", "fp16"), default=["fp8", "fp16"])
    parser.add_argument("--height", type=int, default=32)
    parser.add_argument("--width", type=int, default=40)
    parser.add_argument("--output", type=Path, default=ROOT / "outputs/frontend-torch/qualification.json")
    args = parser.parse_args()
    if not (16 <= args.height <= 256 and 16 <= args.width <= 256 and args.height % 8 == args.width % 8 == 0):
        parser.error("native fixture requires dimensions 16..256 divisible by 8")
    report = {"executed": args.execute, "pass": False, "cases": [],
              "height": args.height, "width": args.width}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    try:
        if args.execute:
            import torch
            from dlssnr.deployment import load_extension
            torch.cuda.init()
            if torch.cuda.get_device_capability() != (12, 0):
                raise RuntimeError("pinned native frontend cubins require SM120")
            ops = load_extension(args.extension)
            stream = torch.cuda.Stream()
            stream.wait_stream(torch.cuda.current_stream())
            with torch.cuda.stream(stream), torch.inference_mode():
                for precision in args.precision:
                    for postprocess, downsample in ((False, False), (False, True), (True, False)):
                        cases = ("raw", "motion", "history_padded") if postprocess else ("no_history", "depth_max", "conditioning_override")
                        for case_index, case in enumerate(cases):
                            linear = case_index == 1
                            fixture = NativeFrontendFixture(precision, downsample, postprocess, case,
                                                            args.height, args.width, linear, stream)
                            try:
                                row = qualify_fixture(ops, fixture, linear, case_index == 0)
                                row.update(case=case, linear_filter=linear)
                                report["cases"].append(row)
                                args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
                                print(json.dumps(row), flush=True)
                            finally:
                                fixture.close()
                stream.synchronize()
            report["pass"] = len(report["cases"]) == 9 * len(args.precision)
    except BaseException as error:
        report["error"] = type(error).__name__ + ": " + str(error)
        raise
    finally:
        args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    if not args.execute:
        print("GPU qualification not executed; pass --execute after building the extension.")


if __name__ == "__main__":
    main()
