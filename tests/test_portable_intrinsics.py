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
            "cuOccupancyMaxActiveBlocksPerMultiprocessor": [C.POINTER(C.c_int), pointer,
                                                           C.c_int, C.c_size_t],
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
            for name in ("ProbeCopies", "ProbeCopyRing", "ProbePrefetchCopies", "ProbeHalfReduction",
                         "ProbeExclusiveHalfReduction", "ProbeAtomicSplitHandoff",
                         "ProbeExclusiveSplitHandoff"):
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

    def launch(self, name, source, destination, threads=128, grid=(1, 1, 1), extra=(), scalars=()):
        arguments = [C.c_uint64(tensor.data_ptr()) for tensor in (source, destination, *extra)]
        arguments.extend(C.c_int(value) for value in scalars)
        pointers = (C.c_void_p * len(arguments))(*(C.addressof(argument) for argument in arguments))
        self.call("cuLaunchKernel", self.functions[name], *grid, threads, 1, 1, 0,
                  self.stream, pointers, None)

    def active_blocks_per_sm(self, name, threads):
        result = C.c_int()
        self.call("cuOccupancyMaxActiveBlocksPerMultiprocessor", C.byref(result),
                  self.functions[name], threads, 0)
        return result.value

    def close(self):
        if self.module:
            self.call("cuModuleUnload", self.module)
            self.module = C.c_void_p()


def guarded_buffer(torch, byte_count, guard_bytes=32):
    owner = torch.full((byte_count + guard_bytes * 2,), 0xB9, device="cuda", dtype=torch.uint8)
    return owner, owner[guard_bytes:-guard_bytes]


def check_guards(torch, owners, guard_bytes=32):
    for name, owner in owners.items():
        if not (bool(torch.all(owner[:guard_bytes] == 0xB9))
                and bool(torch.all(owner[-guard_bytes:] == 0xB9))):
            raise AssertionError(f"Exclusive-reduction test changed the {name} guard")


def check_exclusive_arithmetic(torch, module):
    """Compare against actual atomics, including every Half encoding and NaN payload."""
    # Cross every 16-bit Half pattern with representative zeros, subnormals,
    # normals, infinities and several quiet/signaling NaNs, in both operand orders.
    edge_bits = (0x0000, 0x8000, 0x0001, 0x8001, 0x03FF, 0x0400, 0x3C00, 0xBC00,
                 0x7BFF, 0xFBFF, 0x7C00, 0xFC00, 0x7E00, 0x7FFF, 0x7C01, 0xFC01)
    all_encodings = torch.arange(65536, device="cuda", dtype=torch.int32)
    left = all_encodings.repeat_interleave(len(edge_bits)).to(torch.uint16).view(torch.uint8)
    right = torch.tensor(edge_bits, device="cuda", dtype=torch.int32).repeat(65536)
    right = right.to(torch.uint16).view(torch.uint8)
    byte_count = left.numel()
    vector_count = byte_count // 16
    if vector_count % 128:
        raise AssertionError("Arithmetic test vectors must exactly cover their launch grid")
    owners, views = {}, {}
    for name in ("input", "atomic", "exclusive"):
        owners[name], views[name] = guarded_buffer(torch, byte_count)

    for order, (initial, contribution) in enumerate(((left, right), (right, left))):
        views["input"].copy_(contribution)
        views["atomic"].copy_(initial)
        views["exclusive"].copy_(initial)
        original = owners["input"].clone()
        module.launch("ProbeHalfReduction", views["input"], views["atomic"],
                      grid=(vector_count // 128, 1, 1))
        module.launch("ProbeExclusiveHalfReduction", views["input"], views["exclusive"],
                      grid=(vector_count // 128, 1, 1))
        torch.cuda.synchronize()
        if not torch.equal(views["atomic"], views["exclusive"]):
            differences = torch.nonzero(views["atomic"] != views["exclusive"]).flatten()
            raise AssertionError(f"Exclusive Half arithmetic differs from atomic: order {order}, "
                                 f"first byte {differences[0].item()}, {differences.numel()} bytes")
        if not torch.equal(owners["input"], original):
            raise AssertionError("Exclusive Half arithmetic modified its input")
        check_guards(torch, owners)
    return dict(half_encodings=65536, edge_operands=[hex(value) for value in edge_bits],
                operand_orders=2, comparisons=65536 * len(edge_bits) * 2,
                bytes_equal=True, guards_intact=True, inputs_immutable=True)


def check_exclusive_handoff(torch, module, replays):
    """Exercise ordered split ownership across resident CTAs and reused scratch."""
    phases, splits, tiles, threads = 8, 4, 2, 128
    grid = (tiles, 1, splits)
    sm_count = torch.cuda.get_device_properties(torch.cuda.current_device()).multi_processor_count
    occupancy = {}
    for name in ("ProbeAtomicSplitHandoff", "ProbeExclusiveSplitHandoff"):
        active_blocks = module.active_blocks_per_sm(name, threads)
        occupancy[name] = active_blocks
        if active_blocks * sm_count < tiles * splits:
            raise RuntimeError(f"Refusing a dependent grid that cannot all reside: {name}, "
                               f"{active_blocks} blocks/SM x {sm_count} SMs")
    phase_vectors = tiles * threads
    input_bytes = phases * splits * phase_vectors * 16
    output_bytes = phases * phase_vectors * 16
    owners, views = {}, {}
    owners["input"], views["input"] = guarded_buffer(torch, input_bytes)
    for route in ("atomic", "exclusive"):
        for name, size in (("output", output_bytes), ("scratch", phase_vectors * 16),
                           ("counters", tiles * 4)):
            key = f"{route}_{name}"
            owners[key], views[key] = guarded_buffer(torch, size)
    indices = torch.arange(input_bytes // 2, device="cuda", dtype=torch.int32)
    for replay in range(replays):
        # Odd-stride permutations visit every Half encoding. A changed phase
        # and replay pattern makes stale scratch distinguishable from fresh data.
        values = ((indices * 23 + replay * 101) % 65536).to(torch.uint16).view(torch.uint8)
        views["input"].copy_(values)
        original = owners["input"].clone()
        for route, kernel in (("atomic", "ProbeAtomicSplitHandoff"),
                              ("exclusive", "ProbeExclusiveSplitHandoff")):
            views[f"{route}_output"].fill_(0xA7)
            views[f"{route}_scratch"].fill_(0xD1)
            views[f"{route}_counters"].view(torch.int32).fill_(-1)
            module.launch(kernel, views["input"], views[f"{route}_output"], threads=threads,
                          grid=grid, extra=(views[f"{route}_scratch"], views[f"{route}_counters"]))
        torch.cuda.synchronize()
        for name in ("output", "scratch", "counters"):
            if not torch.equal(views[f"atomic_{name}"], views[f"exclusive_{name}"]):
                raise AssertionError(f"Exclusive split {name} differs from atomics, replay {replay}")
        if not bool(torch.all(views["exclusive_counters"].view(torch.int32) == phases * splits - 1)):
            raise AssertionError("A split handoff did not publish every phase")
        if not torch.equal(owners["input"], original):
            raise AssertionError("Split handoff modified its input")
        check_guards(torch, owners)
    return dict(phases=phases, splits=splits, independent_tiles=tiles, grid=list(grid),
                threads=threads, replays=replays, active_blocks_per_sm=occupancy, sm_count=sm_count,
                bytes_equal=True, guards_intact=True, inputs_immutable=True)


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
            *(dict(kernel="ProbePrefetchCopies", warps=warps, phases=8, copy_bytes=copy_bytes,
                   copies_per_warp=2, mixed_zero_fill=True, read_vector_rotation=32,
                   prefetch_before_read=True, after_read_cta_barrier=False)
              for warps in (4, 8) for copy_bytes in (512, 1024)),
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
                if case.get("read_vector_rotation"):
                    # Each thread writes its own vector index after reading a
                    # vector 32 places ahead within the current physical slot.
                    expected = expected.view(case["phases"], -1, 16).roll(
                        -case["read_vector_rotation"], dims=1).flatten()
                destination_owner = torch.full_like(source_owner, 0xB9)
                destination = destination_owner[guard_bytes:-guard_bytes]
                scalars = (case["copy_bytes"],) if case["kernel"] == "ProbePrefetchCopies" else ()
                module.launch(case["kernel"], source, destination, threads=case["warps"] * 32,
                              scalars=scalars)
                torch.cuda.synchronize()
                if not torch.equal(expected, destination):
                    raise AssertionError(("copy mismatch", case, replay))
                if not torch.equal(source_owner, original):
                    raise AssertionError(("copy modified input", case, replay))
                if not (bool(torch.all(destination_owner[:guard_bytes] == 0xB9))
                        and bool(torch.all(destination_owner[-guard_bytes:] == 0xB9))):
                    raise AssertionError(("copy changed an output guard", case, replay))
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
        report["exclusive_arithmetic"] = check_exclusive_arithmetic(torch, module)
        report["exclusive_handoff"] = check_exclusive_handoff(torch, module, args.reduction_replays)
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
