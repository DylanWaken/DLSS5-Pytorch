"""Explicit GPU smoke tests for the architecture-selected copy/barrier primitives.

Compile tests/cuda/portable_intrinsics.cu to PTX first; this test never compiles
or loads the deployment extension. Example, from the repository root:

  nvcc --ptx -std=c++17 -arch=compute_80 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.ptx
  python tests/test_portable_intrinsics.py --ptx portable_intrinsics.ptx --report result.json

A compute_80 PTX module can be JIT-compiled on a newer GPU. That exercises the
SM80 source branch, but does not establish execution on physical SM80 hardware.
"""
import argparse
import ctypes as C
import hashlib
import json
import os
from pathlib import Path
import re


class PortableModule:
    """Load only the explicit test PTX into Torch's existing CUDA context."""

    def __init__(self, ptx, stream):
        self.driver = (C.WinDLL(str(Path(os.environ["SystemRoot"]) / "System32/nvcuda.dll"))
                       if os.name == "nt" else C.CDLL("libcuda.so.1"))
        pointer = C.c_void_p
        declarations = {
            "cuGetErrorString": [C.c_int, C.POINTER(C.c_char_p)],
            "cuModuleLoadData": [C.POINTER(pointer), pointer],
            "cuModuleGetFunction": [C.POINTER(pointer), pointer, C.c_char_p],
            "cuModuleUnload": [pointer],
            "cuLaunchKernel": [pointer, *([C.c_uint] * 7), pointer,
                               C.POINTER(pointer), C.POINTER(pointer)],
        }
        for name, arguments in declarations.items():
            function = getattr(self.driver, name)
            function.argtypes, function.restype = arguments, C.c_int
        self.module = pointer()
        self.stream = pointer(stream)
        self.call("cuModuleLoadData", C.byref(self.module), C.create_string_buffer(ptx))
        self.functions = {}
        try:
            for name in ("ProbeCopies", "ProbeHalfReduction"):
                function = pointer()
                self.call("cuModuleGetFunction", C.byref(function), self.module, name.encode("ascii"))
                self.functions[name] = function
        except BaseException:
            self.close()
            raise

    def call(self, name, *arguments):
        code = getattr(self.driver, name)(*arguments)
        if code:
            description = C.c_char_p()
            self.driver.cuGetErrorString(code, C.byref(description))
            raise RuntimeError(f"{name}: CUDA {code}: {(description.value or b'unknown').decode()}")

    def launch(self, name, source, destination):
        arguments = [C.c_uint64(source.data_ptr()), C.c_uint64(destination.data_ptr())]
        pointers = (C.c_void_p * 2)(*(C.addressof(argument) for argument in arguments))
        self.call("cuLaunchKernel", self.functions[name], 1, 1, 1, 128, 1, 1, 0,
                  self.stream, pointers, None)

    def close(self):
        if self.module:
            self.call("cuModuleUnload", self.module)
            self.module = C.c_void_p()


def execute(args):
    import torch

    ptx = args.ptx.read_bytes()
    target = re.search(rb"\.target\s+(\w+)", ptx)
    version = re.search(rb"\.version\s+([\d.]+)", ptx)
    if target is None or version is None:
        raise ValueError("--ptx must be textual PTX with .target and .version directives")
    torch.cuda.set_device(args.device)
    torch.cuda.init()
    report = {
        "ptx_path": str(args.ptx.resolve()),
        "ptx_sha256": hashlib.sha256(ptx).hexdigest(),
        "ptx_target": target[1].decode(),
        "ptx_version": version[1].decode(),
        "actual_device": torch.cuda.get_device_name(),
        "actual_compute_capability": list(torch.cuda.get_device_capability()),
        "scope": "PTX-selected source path JIT on the named actual GPU; no other hardware is emulated.",
        "copy_phases_per_launch": 8,
        "copy_replays": args.copy_replays,
        "half_reduction_replays": args.reduction_replays,
        "pass": False,
    }
    module = None
    try:
        module = PortableModule(ptx, torch.cuda.current_stream().cuda_stream)
        guard_bytes, copy_bytes = 32, 16384
        offsets = torch.arange(copy_bytes, device="cuda", dtype=torch.int32)
        for replay in range(args.copy_replays):
            source_owner = torch.full((copy_bytes + 2 * guard_bytes,), 0xA7,
                                      device="cuda", dtype=torch.uint8)
            source = source_owner[guard_bytes:-guard_bytes]
            source.copy_(((offsets + replay * 13) % 251).to(torch.uint8))
            original = source_owner.clone()
            destination_owner = torch.full_like(source_owner, 0xB9)
            destination = destination_owner[guard_bytes:-guard_bytes]
            module.launch("ProbeCopies", source, destination)
            torch.cuda.synchronize()
            assert torch.equal(source, destination), ("copy mismatch", replay)
            assert torch.equal(source_owner, original), ("copy modified input", replay)
            assert bool(torch.all(destination_owner[:guard_bytes] == 0xB9))
            assert bool(torch.all(destination_owner[-guard_bytes:] == 0xB9))
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
    parser.add_argument("--ptx", type=Path, required=True)
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
