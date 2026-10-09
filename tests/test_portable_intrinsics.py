"""Explicit GPU smoke tests for the architecture-selected copy/barrier primitives.

Compile tests/cuda/portable_intrinsics.cu first; this test never compiles or
loads the deployment extension. Offline cubin example, from the repository root:

  nvcc --cubin -std=c++17 -gencode arch=compute_80,code=sm_120 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.cubin
  python tests/test_portable_intrinsics.py --module portable_intrinsics.cubin --report result.json

The existing --ptx argument remains available for explicit PTX JIT tests.
Compiling the SM80 source branch for a newer GPU does not establish execution
on physical SM80 hardware. Loaded function attributes record both targets.
"""
import argparse
import ctypes as C
import hashlib
import json
import os
from pathlib import Path
import re


class PortableModule:
    """Load only the explicit test module into Torch's existing CUDA context."""

    def __init__(self, module_bytes, stream):
        self.driver = (C.WinDLL(str(Path(os.environ["SystemRoot"]) / "System32/nvcuda.dll"))
                       if os.name == "nt" else C.CDLL("libcuda.so.1"))
        pointer = C.c_void_p
        declarations = {
            "cuGetErrorString": [C.c_int, C.POINTER(C.c_char_p)],
            "cuModuleLoadData": [C.POINTER(pointer), pointer],
            "cuModuleGetFunction": [C.POINTER(pointer), pointer, C.c_char_p],
            "cuFuncGetAttribute": [C.POINTER(C.c_int), C.c_int, pointer],
            "cuModuleUnload": [pointer],
            "cuLaunchKernel": [pointer, *([C.c_uint] * 7), pointer,
                               C.POINTER(pointer), C.POINTER(pointer)],
        }
        for name, arguments in declarations.items():
            function = getattr(self.driver, name)
            function.argtypes, function.restype = arguments, C.c_int
        self.module = pointer()
        self.stream = pointer(stream)
        self.call("cuModuleLoadData", C.byref(self.module), C.create_string_buffer(module_bytes))
        self.functions = {}
        self.attributes = {}
        try:
            for name in ("ProbeCopies", "ProbeCopyRing", "ProbeHalfReduction"):
                function = pointer()
                self.call("cuModuleGetFunction", C.byref(function), self.module, name.encode("ascii"))
                self.functions[name] = function
                attributes = {}
                for label, index in (("virtual_architecture", 5), ("binary_architecture", 6)):
                    value = C.c_int()
                    self.call("cuFuncGetAttribute", C.byref(value), index, function)
                    attributes[label] = value.value
                self.attributes[name] = attributes
        except BaseException:
            self.close()
            raise

    def call(self, name, *arguments):
        code = getattr(self.driver, name)(*arguments)
        if code:
            description = C.c_char_p()
            self.driver.cuGetErrorString(code, C.byref(description))
            raise RuntimeError(f"{name}: CUDA {code}: {(description.value or b'unknown').decode()}")

    def launch(self, name, source, destination, threads=128):
        arguments = [C.c_uint64(source.data_ptr()), C.c_uint64(destination.data_ptr())]
        pointers = (C.c_void_p * 2)(*(C.addressof(argument) for argument in arguments))
        self.call("cuLaunchKernel", self.functions[name], 1, 1, 1, threads, 1, 1, 0,
                  self.stream, pointers, None)

    def close(self):
        if self.module:
            self.call("cuModuleUnload", self.module)
            self.module = C.c_void_p()


def execute(args):
    import torch

    module_path = args.module or args.ptx
    module_bytes = module_path.read_bytes()
    is_cubin = module_bytes.startswith(b"\x7fELF")
    if args.ptx and is_cubin:
        raise ValueError("--ptx expects textual PTX; use --module for a compiled cubin")
    ptx_metadata = {}
    if not is_cubin:
        target = re.search(rb"\.target\s+(\w+)", module_bytes)
        version = re.search(rb"\.version\s+([\d.]+)", module_bytes)
        if target is None or version is None:
            raise ValueError("Expected an ELF cubin or textual PTX with .target and .version directives")
        ptx_metadata = {
            "ptx_path": str(module_path.resolve()),
            "ptx_sha256": hashlib.sha256(module_bytes).hexdigest(),
            "ptx_target": target[1].decode(),
            "ptx_version": version[1].decode(),
        }
    torch.cuda.set_device(args.device)
    torch.cuda.init()
    report = {
        "module_path": str(module_path.resolve()),
        "module_sha256": hashlib.sha256(module_bytes).hexdigest(),
        "module_format": "cubin" if is_cubin else "ptx",
        **ptx_metadata,
        "actual_device": torch.cuda.get_device_name(),
        "actual_compute_capability": list(torch.cuda.get_device_capability()),
        "scope": ("Offline cubin on the named actual GPU; no other hardware is emulated." if is_cubin else
                  "PTX-selected source path JIT on the named actual GPU; no other hardware is emulated."),
        "copy_replays": args.copy_replays,
        "half_reduction_replays": args.reduction_replays,
        "pass": False,
    }
    module = None
    try:
        module = PortableModule(module_bytes, torch.cuda.current_stream().cuda_stream)
        report["function_architectures"] = module.attributes
        guard_bytes = 32
        copy_cases = (
            dict(kernel="ProbeCopies", warps=4, phases=8, copy_bytes=512,
                 copies_per_warp=1, mixed_zero_fill=False),
            dict(kernel="ProbeCopyRing", warps=4, phases=16, copy_bytes=1024,
                 copies_per_warp=2, mixed_zero_fill=True),
            dict(kernel="ProbeCopyRing", warps=8, phases=16, copy_bytes=1024,
                 copies_per_warp=2, mixed_zero_fill=True),
        )
        report["copy_cases"] = []
        for case in copy_cases:
            case_report = {**case, "pass": False}
            report["copy_cases"].append(case_report)
            copy_bytes = (case["phases"] * case["warps"] * case["copies_per_warp"]
                          * case["copy_bytes"])
            offsets = torch.arange(copy_bytes, device="cuda", dtype=torch.int32)
            for replay in range(args.copy_replays):
                source_owner = torch.full((copy_bytes + 2 * guard_bytes,), 0xA7,
                                          device="cuda", dtype=torch.uint8)
                source = source_owner[guard_bytes:-guard_bytes]
                source.copy_(((offsets + replay * 13) % 251).to(torch.uint8))
                original = source_owner.clone()
                expected = source.clone()
                if case["mixed_zero_fill"]:
                    expected_slots = expected.view(case["phases"], case["warps"],
                                                   case["copies_per_warp"], case["copy_bytes"])
                    phases = torch.arange(case["phases"], device="cuda")[:, None, None]
                    warps = torch.arange(case["warps"], device="cuda")[None, :, None]
                    copies = torch.arange(case["copies_per_warp"], device="cuda")[None, None, :]
                    expected_slots[(phases + warps + copies) % 3 == 0] = 0
                destination_owner = torch.full_like(source_owner, 0xB9)
                destination = destination_owner[guard_bytes:-guard_bytes]
                module.launch(case["kernel"], source, destination, threads=case["warps"] * 32)
                torch.cuda.synchronize()
                assert torch.equal(expected, destination), ("copy mismatch", case, replay)
                assert torch.equal(source_owner, original), ("copy modified input", case, replay)
                assert bool(torch.all(destination_owner[:guard_bytes] == 0xB9))
                assert bool(torch.all(destination_owner[-guard_bytes:] == 0xB9))
            case_report["pass"] = True
        report["copy_bytes_equal"] = True

        # Half additions exercise signed zeros, subnormals, normal values and
        # overflow. The oracle rounds after each ordered addition, as CUDA does.
        source = torch.tensor([
            0., -0., 2**-24, -2**-24, 2**-14, -2**-14, 1., -1.,
            .33325, -.33325, 32752., -32752., .015625, -.015625, .0009765625, -.0009765625,
        ], device="cuda", dtype=torch.float16).repeat(64)
        destination_owner = torch.full((source.numel() * 2 + 2 * guard_bytes,), 0xB9,
                                       device="cuda", dtype=torch.uint8)
        destination = destination_owner[guard_bytes:-guard_bytes].view(torch.float16)
        destination.copy_(source)
        expected = destination.clone()
        original = source.view(torch.uint8).clone()
        for replay in range(args.reduction_replays):
            expected = (expected.float() + source.float()).half()
            module.launch("ProbeHalfReduction", source, destination)
            torch.cuda.synchronize()
            assert torch.equal(destination.view(torch.uint8), expected.view(torch.uint8)), (
                "Half reduction mismatch", replay)
            assert torch.equal(source.view(torch.uint8), original), ("reduction modified input", replay)
            assert bool(torch.all(destination_owner[:guard_bytes] == 0xB9))
            assert bool(torch.all(destination_owner[-guard_bytes:] == 0xB9))
        report.update(half_reduction_bytes_equal=True, guards_intact=True, inputs_immutable=True)
        report["pass"] = True
    except BaseException as error:
        report["error"] = str(error)
        raise
    finally:
        try:
            if module is not None:
                torch.cuda.synchronize()
                module.close()
        finally:
            args.report.parent.mkdir(parents=True, exist_ok=True)
            args.report.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    module_group = parser.add_mutually_exclusive_group(required=True)
    module_group.add_argument("--module", type=Path, help="Explicit ELF cubin or PTX test module")
    module_group.add_argument("--ptx", type=Path, help="Backward-compatible alias for textual PTX tests")
    parser.add_argument("--report", type=Path, required=True)
    parser.add_argument("--device", type=int, default=0)
    parser.add_argument("--copy-replays", type=int, default=20)
    parser.add_argument("--reduction-replays", type=int, default=16)
    args = parser.parse_args()
    if not 1 <= args.copy_replays <= 1000 or not 1 <= args.reduction_replays <= 1000:
        parser.error("replay counts must be between 1 and 1000")
    print(json.dumps(execute(args), indent=2))


if __name__ == "__main__":
    main()
