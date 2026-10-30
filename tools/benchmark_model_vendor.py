"""Dual-model vendor replay harness (legacy71 vs small31) with portable paths.

CPU-importable and CPU-syntax-checkable: Torch/CUDA and the compiled extension
are imported only inside ``main``.  This is a tracked reproduction CLI adapted
from the accepted profile harness; only path configuration and command-line
portability differ.

Reference arms:
  * legacy71 -> seven pinned 310.8.0.0 cubins under ``assets/vendor_modules``
  * small31  -> seven statically re-extracted signed 310.9.16 cubins under
                ``profile/readme-dual-model-20261030/dll-speed/vendor_modules_310_9_16``

All artifact paths are explicit CLI arguments.  The measured extension hash is
enforced; ``--expected-extension-sha256`` defaults to the published f0d51404
build and any other value must be an explicitly supplied rebuilt binary.  The
DLL pins stay fixed regardless of path.  Actual GPU execution requires Windows
and SM120 because ``VendorModule`` supports only that target; path portability
is not a cross-platform runtime claim.

Vendor symbols come from schedule ``original_symbol`` values, never from the
reconstructed Small-only export aliases.  Aliases are resolved only through an
unambiguous schedule mapping; anything else fails.
"""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import statistics
import struct
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
HERE = Path(__file__).resolve().parent
PROFILE_DIR = ROOT / "profile/readme-dual-model-20261030/dll-speed"
sys.path.insert(0, str(ROOT))
EXT_PIN = "f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938"
DLL_310_8_PIN = "e16bcf15e16e13f527491cdf7845b2fe6521a738d8f7c9c721866a8496e1fc8e"
DLL_310_9_16_PIN = "2bc19bc09a7b89dd44f73e2ac0108fcc586e2154bdd0830f242f4f040e28789f"
DLL_310_8 = ROOT / "assets/original/nvngx_dlssnr_310.8.0/nvngx_dlssnr.dll"
DLL_310_9_16 = ROOT / "profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll"
NEW_DIR = PROFILE_DIR / "vendor_modules_310_9_16"
OLD_DIR = ROOT / "assets/vendor_modules"
SMALL_ARCHIVE = ROOT / "profile/dlss-update-20261029/implementation/runtime-assets-small31"
DEFAULT_EXTENSION = ROOT / "dlssnr/_C_sm120.cp311-win_amd64.pyd"
DEFAULT_CHECKPOINT_DIR = ROOT / "ckpts"
DEFAULT_OUTPUT_DIR = PROFILE_DIR / "results"
SOURCES = ("tuning/physical_schedule.py", "tuning/generate_plan.py",
           "dlssnr/checkpoint.py", "dlssnr/small_deployment.py",
           "dlssnr/geometry.py")


def sha(data):
    return hashlib.sha256(data).hexdigest()


def display_path(path):
    """Render a path relative to the repository when possible, else absolute."""
    path = Path(path).resolve()
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)


def sha_file(path):
    return sha(Path(path).read_bytes())


def query_driver_version():
    """Capture the installed driver once, before any experiment is launched."""
    try:
        completed = subprocess.run(
            ["nvidia-smi", "--query-gpu=driver_version", "--format=csv,noheader"],
            capture_output=True, text=True, timeout=20, check=False)
    except OSError as exc:
        return f"unavailable: {exc}"
    if completed.returncode != 0:
        return f"unavailable: exit {completed.returncode}: {completed.stderr.strip()}"
    lines = [line.strip() for line in completed.stdout.splitlines() if line.strip()]
    return lines[0] if lines else "unavailable: empty nvidia-smi output"


def manifest_entries(path, source_pin):
    """Read one extraction manifest, verifying its source DLL pin.

    Returns the manifest, the PTX kernel roster as ``{symbol: {module ids}}``
    and the cubin entry hash map ``{module id: sha256}``.
    """
    manifest = json.loads(Path(path).read_text(encoding="utf-8"))
    if manifest["sourceDllSha256"] != source_pin:
        raise ValueError(f"extraction manifest DLL pin mismatch: {path}")
    ptx, cubins = {}, {}
    for module in manifest["modules"]:
        module_id = module["id"]
        for entry in module["entries"]:
            if entry["kind"] == 1:
                for kernel in entry["kernels"]:
                    ptx.setdefault(kernel, set()).add(module_id)
            elif entry["kind"] == 2:
                cubins[module_id] = entry["sha256"]
    return manifest, ptx, cubins


def verify_cubins(cubin_dir, numbers, cubin_hashes):
    """Verify every cubin this run will load against its manifest entry hash."""
    verified = {}
    for module_id in sorted(set(numbers.values())):
        expected = cubin_hashes.get(module_id)
        if expected is None:
            raise ValueError(f"manifest has no cubin entry hash for module {module_id}")
        path = Path(cubin_dir) / f"module_{module_id}.cubin"
        actual = sha_file(path)
        if actual != expected:
            raise ValueError(f"cubin {path.name} sha256 {actual} != manifest {expected}")
        verified[str(module_id)] = actual
    return verified


def missing_symbols(spec, schedule, roster):
    """Return the exact vendor symbols this plan needs but the roster lacks."""
    aliases = {}
    for row in schedule["positions"]:
        safe = row.get("safe_export")
        if safe:
            aliases.setdefault(safe, set()).add(row["original_symbol"])
    missing = set()
    for call in spec["calls"]:
        symbol = call["symbol"]
        if symbol not in roster and symbol in aliases:
            candidates = aliases[symbol]
            if len(candidates) == 1:
                symbol = next(iter(candidates))
        if symbol not in roster:
            missing.add(symbol)
    for row in schedule["positions"]:
        if row["original_symbol"] not in roster:
            missing.add(row["original_symbol"])
    return sorted(missing)


def percentile(values, fraction):
    ordered = sorted(values)
    if len(ordered) == 1:
        return ordered[0]
    position = fraction * (len(ordered) - 1)
    low = int(position)
    high = min(low + 1, len(ordered) - 1)
    return ordered[low] + (ordered[high] - ordered[low]) * (position - low)


def module_roster(model, schedule, legacy_modules=OLD_DIR, new_modules=NEW_DIR):
    """Return (symbol -> module id, cubin dir, provenance, cubin entry hashes).

    ``cc_cb_clear`` is resolved from the extraction manifest's PTX roster (the
    310.9.16 manifest lists it under module 6) and is asserted to be module 6.
    """
    if model == "legacy71":
        manifest_path = Path(legacy_modules) / "manifest.json"
        manifest, ptx, cubins = manifest_entries(manifest_path, DLL_310_8_PIN)
        numbers = {row["original_symbol"]: row["module"] for row in schedule["positions"]}
        cubin_dir = Path(legacy_modules)
        provenance = {"source": "310.8.0.0 pinned extraction", "dll_sha256": DLL_310_8_PIN,
                      "manifest": display_path(manifest_path),
                      "manifest_sha256": sha_file(manifest_path),
                      "executedDllOrGpuCode": manifest["executedDllOrGpuCode"]}
    else:
        manifest_path = Path(new_modules) / "manifest.json"
        if not manifest_path.is_file():
            raise FileNotFoundError("run extract_vendor_kernels_310_9_16.py first")
        manifest, ptx, cubins = manifest_entries(manifest_path, DLL_310_9_16_PIN)
        numbers = {}
        for symbol, ids in ptx.items():
            if len(ids) != 1:
                raise ValueError(f"ambiguous vendor module for {symbol}: {sorted(ids)}")
            numbers[symbol] = next(iter(ids))
        cubin_dir = Path(new_modules)
        provenance = {"source": "signed 310.9.16 static extraction",
                      "dll_sha256": manifest["sourceDllSha256"],
                      "extraction_manifest_sha256": sha_file(manifest_path),
                      "executedDllOrGpuCode": manifest["executedDllOrGpuCode"]}
    clear_modules = ptx.get("cc_cb_clear", set())
    if clear_modules != {6}:
        raise ValueError(
            f"cc_cb_clear must resolve to manifest module 6, got {sorted(clear_modules)}")
    numbers["cc_cb_clear"] = 6
    for symbol, ids in list(numbers.items()):
        if not isinstance(ids, int):
            if len(ids) != 1:
                raise ValueError(f"ambiguous vendor module for {symbol}: {sorted(ids)}")
            numbers[symbol] = next(iter(ids))
    return numbers, cubin_dir, provenance, cubins


def resolve_symbols(spec, schedule, numbers):
    """Map each plan call to its vendor original_symbol, failing ambiguity."""
    aliases = {}
    for row in schedule["positions"]:
        safe = row.get("safe_export")
        if safe:
            aliases.setdefault(safe, set()).add(row["original_symbol"])
    resolved = []
    for call in spec["calls"]:
        symbol = call["symbol"]
        if symbol not in numbers and symbol in aliases:
            candidates = aliases[symbol]
            if len(candidates) != 1:
                raise ValueError(f"ambiguous original_symbol alias {symbol}: {sorted(candidates)}")
            symbol = next(iter(candidates))
        if symbol not in numbers:
            raise ValueError(f"vendor roster has no unique module for {call['symbol']} -> {symbol}")
        resolved.append((symbol, numbers[symbol]))
    return resolved


def build_state(torch, spec, precision):
    dtype = torch.float16 if precision == "fp16" else torch.float8_e4m3fn
    elements = spec["buffers"]["input"]["storage_bytes"] // (2 if precision == "fp16" else 1)
    return (torch.randn(elements, device="cuda", dtype=torch.float16) * .02).to(dtype).view(torch.uint8)


def build_records(torch, checkpoint, spec, schedule, precision, model, model_spec):
    if model == "legacy71":
        # Match the established legacy reference harness: the FP8 checkpoint
        # already owns complete packed records, including global operators.
        if precision == "fp8":
            return [checkpoint._records[name].to("cuda", copy=True)
                    for name in spec["records"]]
        records = []
        for name in spec["records"]:
            b, layer = (int(v.removeprefix(prefix)) for v, prefix in zip(name.split(".")[:2], ("block", "layer")))
            kind = ("upsample" if b == 39 else
                    {0: "expand", 1: "contract", 2: "qkv", 4: "projection"}[layer] if 31 <= b <= 38 else
                    {0: "ffn", 1: "ffn_projection", 2: "qkv", 3: "projection", 4: "down"}[layer]
                    if 23 <= b <= 30 or 40 <= b <= 47 else "window")
            records.append(checkpoint.kernel_record(b, kind=kind, precision=precision, device="cuda"))
        return records
    from dlssnr.small_deployment import _kind_for_layer
    records = []
    for name in spec["records"]:
        head, layer_head = name.split(".")[:2]
        raw, layer = int(head.removeprefix("block")), int(layer_head.removeprefix("layer"))
        role = model_spec.role_for_raw(raw)
        kind = _kind_for_layer(role, layer, model_spec)
        records.append(checkpoint.kernel_record(role, kind=kind, precision=precision, device="cuda"))
    return records


def comparison_rows(torch, candidate, buffers, names, spec, precision_dtype, model):
    stream = torch.cuda.current_stream()
    stream.synchronize()
    rows, failures, semantic = [], [], []
    for name in candidate.boundary_names():
        extent = spec["buffers"][name]
        # ``.down`` is the only boundary whose padded storage is not compared;
        # every numeric statistic below is restricted to logical floats.
        size = extent["logical_bytes"] if name.endswith(".down") else extent["storage_bytes"]
        a = candidate.buffer(name)[:size]
        b = buffers[names.index(name)][:size]
        equal = bool(torch.equal(a, b))
        logical = extent["logical_bytes"]
        logical_elements = logical // precision_dtype.itemsize
        af = a.view(precision_dtype)[:logical_elements].float()
        bf = b.view(precision_dtype)[:logical_elements].float()
        a_logical = a[:logical]
        b_logical = b[:logical]
        finite_a = torch.isfinite(af)
        finite_b = torch.isfinite(bf)
        finite_count = int(finite_a.sum())
        native_finite_count = int(finite_b.sum())
        different = int((a != b).sum())
        different_logical = int((a_logical != b_logical).sum())
        both_finite = finite_a & finite_b
        if bool(both_finite.any()):
            difference = (af[both_finite].double() - bf[both_finite].double()).abs()
            raw_max = float(difference.max())
        else:
            raw_max = 0.0 if different_logical == 0 else float("nan")
        max_abs = raw_max if math.isfinite(raw_max) else None
        if bool(both_finite.any()):
            diff = af[both_finite].double() - bf[both_finite].double()
            denom = float((bf[both_finite].double() ** 2).sum())
            raw_rel = float(((diff ** 2).sum() / denom) ** .5) if denom else (
                0.0 if different_logical == 0 else float("inf"))
        else:
            raw_rel = 0.0 if different_logical == 0 else float("inf")
        rel_l2 = raw_rel if math.isfinite(raw_rel) else None
        candidate_abs_max = (float(af[finite_a].abs().max())
                             if bool(finite_a.any()) else None)
        native_abs_max = (float(bf[finite_b].abs().max())
                          if bool(finite_b.any()) else None)
        row = dict(name=name, bytes=size, logical_bytes=logical, equal=equal,
                   different_bytes=different, different_logical_bytes=different_logical,
                   exact_ratio=1.0 - different / size,
                   max_abs=max_abs, relative_l2=rel_l2,
                   candidate_finite=finite_count, native_finite=native_finite_count,
                   candidate_nonfinite=logical_elements - finite_count,
                   native_nonfinite=logical_elements - native_finite_count,
                   candidate_abs_max=candidate_abs_max, native_abs_max=native_abs_max)
        semantic_difference = bool(not equal)
        row["semantic_difference"] = semantic_difference
        if semantic_difference:
            semantic.append(name)
        if model == "legacy71" and (not equal or finite_count != logical_elements
                                    or native_finite_count != logical_elements):
            failures.append(row)
        rows.append(row)
    return rows, failures, semantic


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", choices=("legacy71", "small31"), default="legacy71")
    parser.add_argument("--precision", choices=("fp8", "fp16"), default="fp16")
    parser.add_argument("--width", type=int, default=1280)
    parser.add_argument("--height", type=int, default=720)
    parser.add_argument("--extension", type=Path, default=DEFAULT_EXTENSION)
    parser.add_argument("--expected-extension-sha256", default=EXT_PIN,
                        help="accepted extension SHA-256; defaults to the measured "
                             "f0d51404 published build")
    parser.add_argument("--checkpoint", type=Path, default=DEFAULT_CHECKPOINT_DIR,
                        help="legacy checkpoint file, or directory containing "
                             "dlss5_nr_{fp8,fp16}.pt")
    parser.add_argument("--small-archive", type=Path, default=SMALL_ARCHIVE)
    parser.add_argument("--legacy-dll", type=Path, default=DLL_310_8)
    parser.add_argument("--new-dll", type=Path, default=DLL_310_9_16)
    parser.add_argument("--legacy-modules", type=Path, default=OLD_DIR)
    parser.add_argument("--new-modules", type=Path, default=NEW_DIR)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--timing", action="store_true")
    parser.add_argument("--smoke", action="store_true")
    parser.add_argument("--candidate-only", action="store_true")
    parser.add_argument("--driver-version", default=None,
                        help="pre-captured nvidia-smi driver version; queried once if omitted")
    args = parser.parse_args()
    candidate_only = args.candidate_only or (args.model == "small31" and args.precision == "fp16")
    # Capture the installed driver once, before any experiment is launched.
    driver = args.driver_version or query_driver_version()
    import numpy as np
    import torch
    from dlssnr.model_specs import resolve_model
    from dlssnr.checkpoint import load_checkpoint
    from dlssnr.deployment import load_extension
    from dlssnr.small_deployment import load_native_model
    from tools.native_reference.vendor_benchmark import VendorModule
    from tuning.physical_schedule import make
    from tuning.generate_plan import build_plan

    torch.set_num_threads(8)
    torch.manual_seed(3108)
    stream = torch.cuda.Stream()
    torch.cuda.set_stream(stream)
    if torch.cuda.current_stream().cuda_stream != stream.cuda_stream:
        raise AssertionError("failed to select the dedicated capture stream")
    model_spec = resolve_model(args.model)
    extension = args.extension.resolve()
    extension_sha = sha_file(extension)
    expected_extension_sha = args.expected_extension_sha256.lower()
    if extension_sha != expected_extension_sha:
        raise ValueError(f"extension sha256 {extension_sha} != expected "
                         f"{expected_extension_sha}")
    extension_identity = dict(
        path=display_path(extension), sha256=extension_sha,
        expected_sha256=expected_extension_sha, published_pin=EXT_PIN,
        exact_published_build=extension_sha == EXT_PIN,
        explicit_rebuilt_binary_override=extension_sha != EXT_PIN)
    legacy_dll = args.legacy_dll.resolve()
    new_dll = args.new_dll.resolve()
    dll_sha = {"310.8.0.0": sha_file(legacy_dll), "310.9.16.0": sha_file(new_dll)}
    for label, actual, pin in (("310.8.0.0", dll_sha["310.8.0.0"], DLL_310_8_PIN),
                               ("310.9.16.0", dll_sha["310.9.16.0"], DLL_310_9_16_PIN)):
        if actual != pin:
            raise ValueError(f"vendor DLL {label} sha256 {actual} != pin {pin}")
    ops = load_extension(extension)
    if args.model == "legacy71":
        checkpoint_path = args.checkpoint.resolve()
        if checkpoint_path.is_dir():
            checkpoint_path = checkpoint_path / f"dlss5_nr_{args.precision}.pt"
        checkpoint = load_checkpoint(checkpoint_path)
        checkpoint_identity = {"path": display_path(checkpoint_path),
                               "sha256": sha_file(checkpoint_path)}
    else:
        small_archive = args.small_archive.resolve()
        checkpoint = load_native_model(small_archive, "small31")
        checkpoint_identity = {"path": display_path(small_archive),
                               "manifest_sha256": sha_file(small_archive / "manifest.json")}
    schedule = make(args.width, args.height, precision=args.precision, model=args.model)
    spec = build_plan(schedule, spec=model_spec)
    spec_json = json.dumps(spec, indent=2) + "\n"
    schedule_json = json.dumps(schedule, indent=2) + "\n"
    output = args.output or (DEFAULT_OUTPUT_DIR / f"{args.model}_{args.precision}_{args.width}x{args.height}.json")
    output.parent.mkdir(parents=True, exist_ok=True)
    (output.with_name(output.stem + ".plan.json")).write_text(spec_json, encoding="utf-8")
    (output.with_name(output.stem + ".schedule.json")).write_text(schedule_json, encoding="utf-8")
    names = list(spec["buffers"])
    state = build_state(torch, spec, args.precision)
    candidate = getattr(checkpoint, "create_plan_" + args.precision)(state, width=args.width, height=args.height)
    candidate_run = getattr(candidate, "run_" + args.precision)
    if list(candidate.buffer_names()) != names:
        raise ValueError("candidate buffer roster differs from the rebuilt plan")
    for name, extent in spec["buffers"].items():
        if candidate.buffer(name).numel() != extent["storage_bytes"]:
            raise ValueError(f"candidate buffer extent differs: {name}")
    precision_dtype = torch.float16 if args.precision == "fp16" else torch.float8_e4m3fn
    records = build_records(torch, checkpoint, spec, schedule, args.precision, args.model, model_spec)
    backings = [torch.full((extent["storage_bytes"] + 512,), 0xA5, dtype=torch.uint8, device="cuda")
                for extent in spec["buffers"].values()]
    buffers = [backing[256:-256] for backing in backings]
    buffers[0].copy_(state)
    addresses = [buffer.data_ptr() for buffer in buffers]
    record_addresses = [record.data_ptr() for record in records]

    def runtime_metadata():
        capability = torch.cuda.get_device_capability()
        properties = torch.cuda.get_device_properties(0)
        current = torch.cuda.current_stream()
        return dict(
            driver_version=driver,
            driver_source=("cli --driver-version" if args.driver_version
                           else "nvidia-smi --query-gpu=driver_version"),
            device=torch.cuda.get_device_name(),
            device_sm=10 * capability[0] + capability[1],
            device_sm_count=properties.multi_processor_count,
            torch_version=torch.__version__,
            torch_cuda_version=torch.version.cuda,
            cudnn_version=(torch.backends.cudnn.version()
                           if torch.backends.cudnn.is_available() else None),
            cuda_memory_allocated_bytes=int(torch.cuda.memory_allocated()),
            cuda_memory_reserved_bytes=int(torch.cuda.memory_reserved()),
            cuda_max_memory_allocated_bytes=int(torch.cuda.max_memory_allocated()),
            stream_validation=dict(
                capture_stream_pointer=int(stream.cuda_stream),
                current_stream_pointer=int(current.cuda_stream),
                current_stream_is_capture_stream=current.cuda_stream == stream.cuda_stream,
                stream_synchronized=True),
        )

    def base_evidence():
        evidence = dict(
            model=args.model, precision=args.precision, width=args.width, height=args.height,
            extension_sha256=extension_sha, extension_pin=EXT_PIN,
            extension_expected_sha256=expected_extension_sha,
            extension_pin_verified=extension_sha == EXT_PIN,
            extension_expected_sha256_verified=True,
            extension_exact_published_build=extension_identity["exact_published_build"],
            extension_explicit_rebuilt_binary_override=(
                extension_identity["explicit_rebuilt_binary_override"]),
            extension_path=extension_identity["path"],
            harness_sha256=sha_file(Path(__file__)),
            checkpoint=checkpoint_identity,
            schedule_sha256=sha(schedule_json.encode()),
            physical_schedule_sha256=sha(schedule_json.encode()),
            plan_sha256=sha(spec_json.encode()),
            dll_sha256=dll_sha, dll_pins_verified=True,
            source_sha256={path: sha_file(ROOT / path) for path in SOURCES},
            input_fixture=("torch.manual_seed(3108); torch.randn(elements, device='cuda', "
                           "dtype=float16) * 0.02, then cast to the precision dtype"),
            input_scale=0.02, input_seed=3108,
            compiled_architectures=(list(ops.deployment_build_architectures())
                                    if hasattr(ops, "deployment_build_architectures") else None),
            scope="prepared feature trunk only; no RGB preprocessing/postprocessing, no CPU timing",
        )
        evidence.update(runtime_metadata())
        return evidence

    if candidate_only:
        reason = ("signed 310.9.16 has no Small31 FP16 vendor symbols"
                  if args.model == "small31" and args.precision == "fp16"
                  else "explicit --candidate-only")
        initial_input = state.clone()
        initial_input_sha = sha(initial_input.cpu().numpy().tobytes())
        out_name = schedule["output_buffer"]
        out_logical = spec["buffers"][out_name]["logical_bytes"] // precision_dtype.itemsize

        def output_logical_view():
            return candidate.buffer(out_name).view(precision_dtype)[:out_logical]

        def candidate_ranges():
            ranges = {}
            for name in candidate.boundary_names():
                extent = spec["buffers"][name]
                logical_elements = extent["logical_bytes"] // precision_dtype.itemsize
                values = candidate.buffer(name).view(precision_dtype)[:logical_elements].float()
                finite = torch.isfinite(values)
                ranges[name] = dict(
                    logical_elements=logical_elements,
                    finite=int(finite.sum()),
                    nonfinite=logical_elements - int(finite.sum()),
                    abs_max=(float(values[finite].abs().max()) if bool(finite.any()) else None))
            return ranges

        def candidate_checks(expect_initial_input=True):
            if not candidate.guards_intact():
                raise AssertionError("candidate guard corruption")
            for name in candidate.boundary_names():
                extent = spec["buffers"][name]
                logical_elements = extent["logical_bytes"] // precision_dtype.itemsize
                values = candidate.buffer(name).view(precision_dtype)[:logical_elements].float()
                if not bool(torch.isfinite(values).all()):
                    raise AssertionError(f"candidate non-finite output: {name}")
            for name in names:
                if name.endswith("_counter"):
                    expected = 1 if ".qkv_" in name else 0 if ".attention_" in name else 3
                    if not bool((candidate.buffer(name).view(torch.int32) == expected).all()):
                        raise AssertionError("incomplete split publication: " + name)
            if expect_initial_input and not torch.equal(initial_input, state):
                raise AssertionError("candidate input mutation")

        candidate.poison(0x6A)
        candidate_run()
        torch.cuda.synchronize()
        candidate_checks()

        evidence = base_evidence()
        evidence.update(candidate_only=True, candidate_only_reason=reason,
                        initial_input_sha256=initial_input_sha,
                        candidate_buffer_ranges=candidate_ranges(),
                        vendor_arm="N/A (no vendor module loaded)",
                        numerical_contract=("candidate FP32-safe Small only; no vendor equality "
                                            "claim and no numerical tolerance"))
        if args.model == "small31" and args.precision == "fp16":
            _, half_roster, _ = manifest_entries(
                Path(args.new_modules).resolve() / "manifest.json", DLL_310_9_16_PIN)
            missing = missing_symbols(spec, schedule, half_roster)
            evidence["vendor_half_absence"] = dict(
                structural=True,
                source_dll_sha256=DLL_310_9_16_PIN,
                manifest_sha256=sha_file(Path(args.new_modules).resolve() / "manifest.json"),
                requested_symbols=len(set(call["symbol"] for call in spec["calls"])),
                missing_symbols=missing,
                missing_symbol_count=len(missing),
                non_fp8_attention_entries_in_manifest=sorted(
                    symbol for symbol in half_roster
                    if "attention" in symbol and not symbol.endswith("_fp8")),
                finding=("signed 310.9.16 PTX/cubin roster contains only *_fp8 vendor "
                         "kernels; no non-FP8 Half attention entry exists"),
            )
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            for _ in range(3):
                candidate_run()
        graph.replay()
        torch.cuda.synchronize()
        candidate_checks()
        previous = output_logical_view().clone()
        transformed = state.view(precision_dtype).float().mul_(0.5).add_(0.003).to(precision_dtype)
        state.copy_(transformed.view(torch.uint8))
        graph.replay()
        torch.cuda.synchronize()
        if torch.equal(previous, output_logical_view()):
            raise AssertionError("changed input did not change candidate output")
        candidate_checks(expect_initial_input=False)
        evidence["changed_input_response_pass"] = True
        state.copy_(initial_input)
        graph.replay()
        torch.cuda.synchronize()
        if sha(state.cpu().numpy().tobytes()) != initial_input_sha:
            raise AssertionError("timed candidate input differs from seeded fixture")
        candidate_checks()
        deterministic = output_logical_view().clone()
        poison_records = []
        mutation_ok = True
        for value in (0x35, 0x7E):
            before_poison = output_logical_view().clone()
            candidate.poison(value)
            mutated = not torch.equal(before_poison, output_logical_view())
            mutation_ok = mutation_ok and mutated
            graph.replay()
            torch.cuda.synchronize()
            if not torch.equal(deterministic, output_logical_view()):
                raise AssertionError(
                    f"candidate-only poisoned graph replay is not deterministic: {value:#x}")
            candidate_checks()
            poison_records.append(dict(value=value, output_mutated_before_replay=mutated,
                                       replay_deterministic=True))
        evidence["changed_input_replay_pass"] = True
        evidence["poisoned_replays_pass"] = True
        evidence["poisoned_replay_values"] = poison_records
        evidence["output_mutation_pass"] = mutation_ok
        evidence["post_capture_validation_pass"] = True
        evidence["timed_input_sha256"] = sha(state.cpu().numpy().tobytes())
        evidence["candidate_buffer_ranges"] = candidate_ranges()
        if args.smoke or not args.timing:
            evidence["smoke"] = bool(args.smoke)
            evidence["post_timing_validation_pass"] = "N/A: smoke preflight has no timing"
            output.write_text(json.dumps(evidence, indent=2), encoding="utf-8")
            graph.reset()
            return
        for _ in range(20):
            graph.replay()
        torch.cuda.synchronize()
        samples = []
        for _ in range(64):
            start, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            start.record(stream)
            for _ in range(10):
                graph.replay()
            end.record(stream)
            end.synchronize()
            samples.append(start.elapsed_time(end) / 30)
        evidence["timing_protocol"] = dict(calls_per_graph=3, warmup_replays=20, samples=64,
                                           replays_per_sample=10, passes_per_sample=30,
                                           scope="candidate-only trunk, CUDA events")
        evidence["timing"] = dict(candidate_ms=statistics.median(samples),
                                  candidate_p10=percentile(samples, .1),
                                  candidate_p90=percentile(samples, .9), samples=samples)
        # Post-timing validation is mandatory: guards/counters/finiteness/input.
        candidate_checks()
        evidence["post_timing_validation_pass"] = True
        evidence["candidate_buffer_ranges"] = candidate_ranges()
        output.write_text(json.dumps(evidence, indent=2), encoding="utf-8")
        graph.reset()
        return

    numbers, cubin_dir, provenance, cubin_hashes = module_roster(
        args.model, schedule, args.legacy_modules, args.new_modules)
    cubin_verified = verify_cubins(cubin_dir, numbers, cubin_hashes)
    resolved = resolve_symbols(spec, schedule, numbers)
    modules, calls = {}, []
    for call, (symbol, module_id) in zip(spec["calls"], resolved):
        if symbol not in modules:
            cubin_path = cubin_dir / f"module_{module_id}.cubin"
            cubin_bytes = cubin_path.read_bytes()
            actual_cubin_sha = sha(cubin_bytes)
            if actual_cubin_sha != cubin_hashes[module_id]:
                raise ValueError(
                    f"cubin {cubin_path.name} sha256 {actual_cubin_sha} != "
                    f"manifest {cubin_hashes[module_id]}")
            modules[symbol] = VendorModule(cubin_bytes, stream.cuda_stream, symbol, call["abi"])
        # Ordered split grids must fit the actual extracted module's residency.
        # Recompiled vendor kernels can have different register/shared budgets.
        if call["all_resident"]:
            active = modules[symbol].active_blocks_per_sm(int(np.prod(call["block"])))
            required = int(np.prod(call["grid"][:2]))
            capacity = active * torch.cuda.get_device_properties(0).multi_processor_count
            if capacity < required:
                raise ValueError(f"Native resident capacity exceeded: {symbol}: "
                                 f"required={required}, capacity={capacity}")
        parameters = bytearray(call["abi"])
        for offset, size, value in call["fields"]:
            if size == 4:
                struct.pack_into("<i", parameters, offset, int(value))
            else:
                index = int(value[value.index("(") + 1:-1])
                pointer = record_addresses[index] if value.startswith("record_address") else addresses[index]
                struct.pack_into("<Q", parameters, offset, pointer)
        calls.append((modules[symbol], bytes(parameters), call, symbol))

    def native():
        for module, parameters, row, symbol in calls:
            module.launch(parameters, row)

    def launch_roster():
        return [dict(symbol=symbol, module=numbers[symbol], grid=list(row["grid"]),
                     block=list(row["block"]), abi_bytes=int(row["abi"]),
                     all_resident=bool(row.get("all_resident", False)))
                for _, _, row, symbol in calls]

    def output_buffer():
        return candidate.buffer(schedule["output_buffer"])

    candidate.poison(0x6A)
    for buffer in buffers[1:]:
        buffer.fill_(0x6A)
    initial_input = state.clone()
    initial_input_sha = sha(initial_input.cpu().numpy().tobytes())
    expected_input = initial_input.clone()

    def invariants(rows, failures, semantic):
        if not candidate.guards_intact():
            raise AssertionError("candidate guard corruption")
        for row in rows:
            if row["candidate_nonfinite"]:
                raise AssertionError("candidate non-finite boundary: " + row["name"])
        for name, backing in zip(names, backings):
            if not bool((backing[:256] == 0xA5).all()) or not bool((backing[-256:] == 0xA5).all()):
                raise AssertionError("native guard corruption: " + name)
            if name.endswith("_counter"):
                expected = 1 if ".qkv_" in name else 0 if ".attention_" in name else 3
                for buffer in (candidate.buffer(name), buffers[names.index(name)]):
                    if not bool((buffer.view(torch.int32) == expected).all()):
                        raise AssertionError("incomplete split publication: " + name)
        if not torch.equal(state, expected_input) or not torch.equal(buffers[0], expected_input):
            raise AssertionError("native or candidate input differs from expected fixture")
        return dict(compared=rows, failures=failures, semantic_difference=semantic)

    def compare():
        return comparison_rows(torch, candidate, buffers, names, spec, precision_dtype, args.model)

    def vendor_evidence():
        result = base_evidence()
        result.update(
            vendor=provenance, cubin_sha256=cubin_verified,
            cubin_manifest_verified=True,
            launch_roster=launch_roster(),
            initial_input_sha256=initial_input_sha,
            input_scale=0.02, input_seed=3108,
            precision_terminology=(
                "activation/kernel family: Small31 FP8 vendor kernels are *_fp8 "
                "activation/weight kernels; extracted SASS shows QMMA.16832.F16.E4M3.E4M3 "
                "plus HADD2/HFMA2/HMUL2, so FP8 macrotiles may contain Half intermediate "
                "arithmetic; this is not an FP32-accumulator contract"),
            numerical_contract=(
                "legacy71: all 74 boundaries must be byte-exact and finite; small31: "
                "FP32-safe candidate intentionally differs from the extracted 310.9.16 "
                "vendor arithmetic, so equality is not claimed and no tolerance is invented"))
        return result

    def accumulation_range(rows):
        return dict(
            candidate_abs_max=max((row["candidate_abs_max"] for row in rows
                                   if row["candidate_abs_max"] is not None), default=None),
            native_abs_max=max((row["native_abs_max"] for row in rows
                                if row["native_abs_max"] is not None), default=None),
            max_abs_difference=max((row["max_abs"] for row in rows
                                    if row["max_abs"] is not None), default=None),
            max_relative_l2=max((row["relative_l2"] for row in rows
                                 if row["relative_l2"] is not None), default=None),
            boundaries_with_candidate_nonfinite=[row["name"] for row in rows
                                                 if row["candidate_nonfinite"]],
            boundaries_with_native_nonfinite=[row["name"] for row in rows
                                              if row["native_nonfinite"]])

    def differing_boundaries(rows):
        return [row["name"] for row in rows if row["semantic_difference"]]

    def stop_nonfinite(phase, rows, evidence_obj, withhold_timing=False):
        nonfinite = [row for row in rows if row["native_nonfinite"]]
        if not nonfinite:
            return False
        evidence_obj["phase"] = phase
        evidence_obj["vendor_nonfinite_boundaries"] = [row["name"] for row in nonfinite]
        evidence_obj["first_nonfinite_boundary"] = nonfinite[0]["name"]
        evidence_obj["per_boundary_nonfinite_counts"] = {
            row["name"]: dict(candidate_nonfinite=row["candidate_nonfinite"],
                              native_nonfinite=row["native_nonfinite"],
                              logical_elements=(row["logical_bytes"]
                                                // precision_dtype.itemsize))
            for row in rows}
        evidence_obj["launch_roster"] = launch_roster()
        evidence_obj["input_scale"] = 0.02
        evidence_obj["input_sha256"] = initial_input_sha
        if withhold_timing:
            evidence_obj.pop("timing", None)
            evidence_obj["timing_withheld_reason"] = "post-timing vendor non-finite output"
        evidence_obj["timing_skipped_reason"] = (
            f"vendor produced non-finite values at {phase}; native timing withheld")
        evidence_obj["native_timing_withheld"] = True
        output.write_text(json.dumps(evidence_obj, indent=2), encoding="utf-8")
        print(f"Vendor non-finite output recorded at {phase}; timing skipped", flush=True)
        return True

    def legacy_gate(phase, rows, failures, evidence_obj):
        if args.model != "legacy71":
            return
        native_nonfinite = [row["name"] for row in rows if row["native_nonfinite"]]
        if not failures and not native_nonfinite:
            return
        evidence_obj["phase"] = phase
        evidence_obj["legacy_gate_failed"] = True
        evidence_obj["legacy_failures"] = failures
        evidence_obj["legacy_native_nonfinite"] = native_nonfinite
        output.write_text(json.dumps(evidence_obj, indent=2), encoding="utf-8")
        raise AssertionError(f"legacy byte-exact/finite gate failed at {phase}")

    def finalize(evidence_obj, graphs, modules):
        for graph in graphs:
            graph.reset()
        for module in modules.values():
            module.close()

    native()
    stream.synchronize()
    candidate_run()
    rows, failures, semantic = compare()
    evidence = vendor_evidence()
    evidence.update(invariants(rows, failures, semantic))
    evidence["phase"] = "initial_eager"
    evidence["accumulation_range"] = accumulation_range(rows)
    evidence["initial_differing_boundaries"] = differing_boundaries(rows)
    evidence["first_differing_boundary"] = (
        evidence["initial_differing_boundaries"][0]
        if evidence["initial_differing_boundaries"] else None)
    legacy_gate("initial_eager", rows, failures, evidence)
    if stop_nonfinite("initial_eager", rows, evidence):
        finalize(evidence, [], modules)
        return
    graphs = []
    try:
        for run in (native, candidate_run):
            graph = torch.cuda.CUDAGraph()
            with torch.cuda.graph(graph, stream=stream):
                for _ in range(3):
                    run()
            graphs.append(graph)
    except BaseException:
        finalize(evidence, graphs, modules)
        raise

    def poison(value):
        candidate.poison(value)
        for buffer in buffers[1:]:
            buffer.fill_(value)

    output_name = schedule["output_buffer"]
    output_logical = spec["buffers"][output_name]["logical_bytes"] // precision_dtype.itemsize
    poison_records = []
    for value in (0x35, 0x7E):
        candidate_before = output_buffer().view(precision_dtype)[:output_logical].clone()
        native_before = buffers[names.index(output_name)].view(precision_dtype)[:output_logical].clone()
        poison(value)
        candidate_mutated = not torch.equal(
            candidate_before, output_buffer().view(precision_dtype)[:output_logical])
        native_mutated = not torch.equal(
            native_before, buffers[names.index(output_name)].view(precision_dtype)[:output_logical])
        for graph in graphs:
            graph.replay()
        rows, failures, semantic = compare()
        evidence = vendor_evidence()
        evidence.update(invariants(rows, failures, semantic))
        evidence["phase"] = f"poisoned_replay_{value:#x}"
        evidence["accumulation_range"] = accumulation_range(rows)
        differing = differing_boundaries(rows)
        evidence["first_differing_boundary"] = differing[0] if differing else None
        legacy_gate(evidence["phase"], rows, failures, evidence)
        if stop_nonfinite(evidence["phase"], rows, evidence):
            finalize(evidence, graphs, modules)
            return
        if not torch.equal(candidate_before, output_buffer().view(precision_dtype)[:output_logical]):
            raise AssertionError("candidate graph replay is not deterministic")
        if not torch.equal(native_before,
                           buffers[names.index(output_name)].view(precision_dtype)[:output_logical]):
            raise AssertionError("native graph replay is not deterministic")
        poison_records.append(dict(value=value, candidate_output_mutated=candidate_mutated,
                                   native_output_mutated=native_mutated,
                                   replay_deterministic=True))
    evidence["poisoned_replays_pass"] = True
    evidence["poisoned_replay_values"] = poison_records
    evidence["output_mutation_pass"] = all(
        record["candidate_output_mutated"] and record["native_output_mutated"]
        for record in poison_records)

    previous = output_buffer().view(precision_dtype)[:output_logical].clone()
    transformed = state.view(precision_dtype).float().mul_(0.5).add_(0.003).to(precision_dtype)
    state.copy_(transformed.view(torch.uint8))
    buffers[0].copy_(state)
    expected_input = state.clone()
    for graph in graphs:
        graph.replay()
    rows, failures, semantic = compare()
    evidence = vendor_evidence()
    evidence.update(invariants(rows, failures, semantic))
    evidence["phase"] = "changed_input_replay"
    evidence["accumulation_range"] = accumulation_range(rows)
    differing = differing_boundaries(rows)
    evidence["first_differing_boundary"] = differing[0] if differing else None
    legacy_gate("changed_input_replay", rows, failures, evidence)
    if stop_nonfinite("changed_input_replay", rows, evidence):
        finalize(evidence, graphs, modules)
        return
    if torch.equal(previous, output_buffer().view(precision_dtype)[:output_logical]):
        raise AssertionError("changed input did not change the candidate trunk output")
    evidence["changed_input_response_pass"] = True

    state.copy_(initial_input)
    buffers[0].copy_(state)
    expected_input = initial_input.clone()
    for graph in graphs:
        graph.replay()
    rows, failures, semantic = compare()
    evidence = vendor_evidence()
    evidence.update(invariants(rows, failures, semantic))
    evidence["phase"] = "restored_input_replay"
    evidence["accumulation_range"] = accumulation_range(rows)
    evidence["initial_differing_boundaries"] = differing_boundaries(rows)
    evidence["first_differing_boundary"] = (
        evidence["initial_differing_boundaries"][0]
        if evidence["initial_differing_boundaries"] else None)
    legacy_gate("restored_input_replay", rows, failures, evidence)
    if stop_nonfinite("restored_input_replay", rows, evidence):
        finalize(evidence, graphs, modules)
        return
    evidence["changed_input_replay_pass"] = True
    evidence["changed_input_response_pass"] = True
    evidence["poisoned_replays_pass"] = True
    evidence["poisoned_replay_values"] = poison_records
    evidence["output_mutation_pass"] = all(
        record["candidate_output_mutated"] and record["native_output_mutated"]
        for record in poison_records)
    evidence["post_capture_validation_pass"] = True
    evidence["timed_input_sha256"] = sha(state.cpu().numpy().tobytes())
    evidence["input_transform"] = (
        "seeded randn*0.02 restored before timing after 0.5*x+0.003 freshness check")
    evidence["smoke"] = bool(args.smoke)
    evidence["semantic_difference"] = bool(semantic)
    if args.smoke or not args.timing:
        evidence["post_timing_validation_pass"] = "N/A: smoke preflight has no timing"
        output.write_text(json.dumps(evidence, indent=2), encoding="utf-8")
        print("Smoke comparison written", flush=True)
        finalize(evidence, graphs, modules)
        return
    for _ in range(20):
        for graph in graphs:
            graph.replay()
    stream.synchronize()
    pairs = []
    for pair in range(64):
        order = (0, 1) if pair % 2 == 0 else (1, 0)
        times = {}
        for role in order:
            start, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            start.record(stream)
            for _ in range(10):
                graphs[role].replay()
            end.record(stream)
            end.synchronize()
            times[role] = start.elapsed_time(end) / 30
        pairs.append(dict(order=list(order), native_ms=times[0], candidate_ms=times[1],
                          ratio=times[1] / times[0]))
    evidence["timing_protocol"] = dict(calls_per_graph=3, warmup_replays=20, pairs=64,
                                       replays_per_sample=10, passes_per_sample=30,
                                       scope="trunk only, CUDA events, stream-synchronized")
    evidence["timing"] = dict(
        pairs=pairs,
        native_ms=statistics.median(x["native_ms"] for x in pairs),
        candidate_ms=statistics.median(x["candidate_ms"] for x in pairs),
        median_ratio=statistics.median(x["ratio"] for x in pairs),
        by_order=[statistics.median(x["ratio"] for x in pairs if x["order"][0] == i) for i in (0, 1)],
        native_p10=percentile([x["native_ms"] for x in pairs], .1),
        native_p90=percentile([x["native_ms"] for x in pairs], .9),
        candidate_p10=percentile([x["candidate_ms"] for x in pairs], .1),
        candidate_p90=percentile([x["candidate_ms"] for x in pairs], .9))
    rows, failures, semantic = compare()
    evidence["compared_post_timing"] = rows
    evidence["failures_post_timing"] = failures
    evidence["semantic_difference_post_timing"] = semantic
    evidence["accumulation_range_post_timing"] = accumulation_range(rows)
    invariants(rows, failures, semantic)
    legacy_gate("post_timing", rows, failures, evidence)
    if stop_nonfinite("post_timing", rows, evidence, withhold_timing=True):
        finalize(evidence, graphs, modules)
        return
    evidence["post_timing_validation_pass"] = True
    output.write_text(json.dumps(evidence, indent=2), encoding="utf-8")
    print(json.dumps({k: evidence["timing"][k] for k in
                      ("native_ms", "candidate_ms", "median_ratio", "by_order")}), flush=True)
    finalize(evidence, graphs, modules)


if __name__ == "__main__":
    main()
