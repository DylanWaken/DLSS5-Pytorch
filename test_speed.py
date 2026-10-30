"""Benchmark checkpoint-backed deployment at 720p, 1080p, 1440p and 4K.

The headline measures CUDA-graph execution of the prepared blocks 1-69 feature
trunk, excluding weight loading, packing, preparation and renderer input/output.
No original DLL assets are required. Missing native extensions are built for the
selected local GPU. Each case runs in a fresh process to release its workspace.
"""
import argparse
import csv
from datetime import datetime, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import statistics
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent
SIZES = {"720p": (1280, 720), "1080p": (1920, 1080),
         "2k": (2560, 1440), "4k": (3840, 2160)}
MODELS = ("legacy71", "small31")
SMALL_CHECKPOINT_NAME = "dlss5_nr_small31.pt"
SCOPE = "Prepared feature trunk, blocks 1-69; batch one; CUDA graph; no renderer preprocessing/composition"
SMALL_SCOPE = ("Prepared Small31 feature trunk, 31 operation roles (the Legacy71 blocks 1-69 "
               "trunk is not used); batch one; CUDA graph; no renderer preprocessing/composition")
ENV_OVERRIDES = ("CUDA_FORCE_PTX_JIT", "CUDA_DISABLE_PTX_JIT", "CUDA_FORCE_JIT",
                 "CUDA_DISABLE_JIT", "CUDA_LAUNCH_BLOCKING", "DLSSNR_SM_COUNT_LIMIT")


def scope_text(model):
    """Describe the trunk actually selected, not only the Legacy71 blocks."""
    return SMALL_SCOPE if model == "small31" else SCOPE


def selected_checkpoint_path(args, precision):
    """One selected file, explicit override first, otherwise the established default."""
    if getattr(args, "checkpoint", None):
        return Path(args.checkpoint)
    model = getattr(args, "model", "legacy71")
    checkpoint_dir = getattr(args, "checkpoint_dir", ROOT / "ckpts")
    return default_checkpoint_path(checkpoint_dir, model, precision)



def supported_precisions(sm):
    return [name for name, minimum in (("fp16", 80), ("fp8", 89)) if sm >= minimum]


def default_checkpoint_path(checkpoint_dir, model, precision):
    """Default file names: legacy is precision-specific, Small is one resource."""
    name = SMALL_CHECKPOINT_NAME if model == "small31" else f"dlss5_nr_{precision}.pt"
    return Path(checkpoint_dir) / name


def checkpoint_manifest(path):
    sidecar = Path(path).with_suffix(".json")
    if not sidecar.is_file():
        return None
    value = json.loads(sidecar.read_text(encoding="utf8"))
    if not isinstance(value, dict):
        raise ValueError(f"Checkpoint manifest is not an object: {sidecar}")
    return value


def checkpoint_precision(path):
    """Read the declared storage precision without building a deployment plan."""
    manifest = checkpoint_manifest(path)
    if manifest is not None and manifest.get("weight_precision") in ("fp16", "fp8"):
        return manifest["weight_precision"]
    import torch
    payload = torch.load(Path(path), map_location="cpu", weights_only=True, mmap=True)
    precision = payload.get("weight_precision") if isinstance(payload, dict) else None
    if precision not in ("fp16", "fp8"):
        raise ValueError(f"Checkpoint does not declare weight_precision fp16 or fp8: {path}")
    return precision


def case_plan(width, height, precision, model):
    """Build the model-specific physical schedule and native call roster."""
    from dlssnr.model_specs import resolve_model
    from tuning.generate_plan import build_plan
    from tuning.physical_schedule import make
    schedule = make(width, height, precision=precision, model=model)
    return schedule, build_plan(schedule, resolve_model(model))


def positive_int(value):
    number = int(value)
    if number < 1:
        raise argparse.ArgumentTypeError("must be a positive integer")
    return number


def sha256(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def summarize(samples):
    if not samples or any(not math.isfinite(value) or value <= 0 for value in samples):
        raise ValueError("CUDA timings must be finite, positive and nonempty")
    ordered = sorted(samples)

    def percentile(fraction):
        position = (len(ordered) - 1) * fraction
        lower = int(position)
        upper = min(lower + 1, len(ordered) - 1)
        return ordered[lower] + (ordered[upper] - ordered[lower]) * (position - lower)

    median = statistics.median(samples)
    return dict(median_ms=median, p10_ms=percentile(.1), p90_ms=percentile(.9),
                min_ms=min(samples), max_ms=max(samples), passes_per_second=1000 / median,
                samples_ms=samples)


def time_graph(torch, run, stream, *, warmup, samples, iterations, passes=3):
    """Own the graph until all replays finish; the caller retains the plan."""
    graph = torch.cuda.CUDAGraph()
    try:
        with torch.cuda.graph(graph, stream=stream):
            for _ in range(passes):
                run()
        for _ in range(warmup):
            graph.replay()
        stream.synchronize()
        start = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)
        timings = []
        for _ in range(samples):
            start.record(stream)
            for _ in range(iterations):
                graph.replay()
            end.record(stream)
            end.synchronize()
            timings.append(start.elapsed_time(end) / (passes * iterations))
        return summarize(timings)
    finally:
        # A graph contains raw pointers into its plan. Never release the plan
        # before the graph is idle and reset, including a failed timing check.
        stream.synchronize()
        graph.reset()


def time_kernel_sequence(torch, plan, stream, *, warmup, samples):
    """Diagnostic events around every call in the complete dependent schedule."""
    from dlssnr.deployment import prepare_kernels
    sequence = prepare_kernels(plan)
    counts = list(plan.split_launch_counts())
    events = [torch.cuda.Event(enable_timing=True, external=True)
              for _ in range(len(sequence.kernels) + 1)]
    # Initialize event handles before capture. External nodes keep event
    # timestamps observable when the captured sequence is replayed.
    for event in events:
        event.record(stream)
    stream.synchronize()
    graph = torch.cuda.CUDAGraph()
    try:
        with torch.cuda.graph(graph, stream=stream):
            events[0].record(stream)
            for index, kernel in enumerate(sequence.kernels):
                kernel(kernel.inputs, kernel.outputs)
                events[index + 1].record(stream)
        for _ in range(warmup):
            graph.replay()
        stream.synchronize()
        timings = [[] for _ in sequence.kernels]
        for _ in range(samples):
            graph.replay()
            stream.synchronize()
            for index, values in enumerate(timings):
                values.append(events[index].elapsed_time(events[index + 1]))
        return [dict(index=index, name=kernel.name, physical_launches=counts[index],
                     **summarize(timings[index]))
                for index, kernel in enumerate(sequence.kernels)]
    finally:
        stream.synchronize()
        graph.reset()


def benchmark_case(args):
    import torch
    from dlssnr.checkpoint import load_checkpoint
    from dlssnr.deployment import load_extension
    from dlssnr.geometry import Geometry

    precision, size = args.worker
    model = args.model
    width, height = SIZES[size]
    torch.set_num_threads(4)
    torch.cuda.set_device(args.device)
    torch.manual_seed(3108)
    ops = load_extension(args.extension, device=args.device)
    # Small31 has its own record roster, phases and call sequence. Select the
    # schedule explicitly so a Legacy plan cannot supply Small buffer extents.
    schedule, spec = case_plan(width, height, precision, model)
    geometry = Geometry.from_valid(width, height)
    dtype = torch.float16 if precision == "fp16" else torch.float8_e4m3fn
    elements = spec["buffers"]["input"]["storage_bytes"] // (2 if precision == "fp16" else 1)
    checkpoint_path = selected_checkpoint_path(args, precision)
    checkpoint = load_checkpoint(checkpoint_path, model=model)
    if precision == "fp8" and checkpoint.precision != "fp8":
        raise ValueError(
            f"{model} checkpoint {checkpoint_path} is {checkpoint.precision}; "
            "FP8 deployment requires an original FP8 checkpoint")
    stream = torch.cuda.Stream(device=args.device)
    with torch.inference_mode(), torch.cuda.stream(stream):
        state = (torch.randn(elements, device=f"cuda:{args.device}", dtype=torch.float16) * .02)
        state = state.to(dtype).view(torch.uint8)
        plan = getattr(checkpoint, "create_plan_" + precision)(state, width=width, height=height)
        run = getattr(plan, "run_" + precision)
        for _ in range(5):
            output = run()
        stream.synchronize()
        output_bytes = spec["buffers"]["b69.output"]["logical_bytes"]
        expected = output[:output_bytes].cpu()
        for chunk in expected.view(dtype).split(1 << 20):
            if not bool(torch.isfinite(chunk.float()).all()):
                raise RuntimeError("Nonfinite eager output; speed result rejected")
        torch.cuda.reset_peak_memory_stats(args.device)
        timing = time_graph(torch, run, stream, warmup=args.warmup,
                            samples=args.samples, iterations=args.iterations)
        peak_bytes = torch.cuda.max_memory_allocated(args.device)
        if not torch.equal(output[:output_bytes].cpu(), expected) or not plan.guards_intact():
            raise RuntimeError("Graph output differs from eager execution or damaged a buffer guard")
        per_kernel = None
        if args.per_kernel:
            per_kernel = time_kernel_sequence(torch, plan, stream, warmup=args.warmup, samples=args.samples)
            if not torch.equal(output[:output_bytes].cpu(), expected) or not plan.guards_intact():
                raise RuntimeError("Instrumented kernel sequence differs from integrated execution")
        counts = list(plan.split_launch_counts())
        return dict(status="ok", model=model, precision=precision, resolution=size,
                    width=width, height=height,
                    padded_image=[geometry.full_width, geometry.full_height],
                    feature_field=list(geometry.levels[0]), **timing,
                    peak_allocated_bytes=peak_bytes, logical_calls=len(counts),
                    physical_launches=sum(counts), split_launch_counts=counts,
                    output_finite=True, graph_matches_eager=True, guards_intact=True,
                    checkpoint=str(checkpoint_path), checkpoint_precision=checkpoint.precision,
                    checkpoint_sha256=sha256(checkpoint_path),
                    extension_sha256=sha256(args.extension),
                    compiled_architectures=list(ops.deployment_build_architectures()),
                    kernels=per_kernel)


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + "\n", encoding="utf8")


def worker_main(args):
    precision, size = args.worker
    model = getattr(args, "model", "legacy71")
    checkpoint_path = selected_checkpoint_path(args, precision)
    result = dict(model=model, precision=precision, resolution=size,
                  width=SIZES[size][0], height=SIZES[size][1],
                  checkpoint=str(checkpoint_path))
    try:
        result = benchmark_case(args)
    except Exception as error:
        import torch
        result.update(status="out_of_memory" if isinstance(error, torch.cuda.OutOfMemoryError) else "error",
                      error=f"{type(error).__name__}: {error}")
    result.setdefault("model", model)
    result.setdefault("checkpoint", str(checkpoint_path))
    write_json(args.result, result)
    return 0 if result["status"] == "ok" else 1


def run_case(args, extension, precision, size, environment):
    from tools.benchmark_architectures import terminate_process_tree
    model = getattr(args, "model", "legacy71")
    selected_checkpoint = selected_checkpoint_path(args, precision)
    result_path = args.output / f"{precision}_{size}.json"
    log_path = args.output / f"{precision}_{size}.log"
    command = [sys.executable, "-B", str(Path(__file__).resolve()), "--worker", precision, size,
               "--model", model,
               "--extension", str(extension), "--result", str(result_path),
               "--device", str(args.device), "--checkpoint-dir", str(args.checkpoint_dir),
               "--warmup", str(args.warmup), "--samples", str(args.samples),
               "--iterations", str(args.iterations)]
    if getattr(args, "checkpoint", None) is not None:
        command.extend(("--checkpoint", str(selected_checkpoint)))
    if args.per_kernel:
        command.append("--per-kernel")
    started = time.monotonic()
    with log_path.open("w", encoding="utf8") as log:
        process = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT,
                                   start_new_session=os.name != "nt")
        try:
            returncode = process.wait(timeout=args.timeout)
        except subprocess.TimeoutExpired:
            cleanup = terminate_process_tree(process)
            if not cleanup.get("tree_termination_confirmed"):
                raise RuntimeError(f"Cannot confirm timed-out worker stopped: {cleanup}")
            return dict(model=model, precision=precision, resolution=size,
                        width=SIZES[size][0], height=SIZES[size][1], status="timeout",
                        checkpoint=str(selected_checkpoint),
                        error=f"Exceeded {args.timeout}s", cleanup=cleanup, log=str(log_path))
        except BaseException:
            # In particular, Ctrl-C must not leave a CUDA worker running after
            # its coordinator exits. Each subprocess owns its CUDA context.
            terminate_process_tree(process)
            raise
    if result_path.is_file():
        try:
            result = json.loads(result_path.read_text(encoding="utf8"))
            if (not isinstance(result, dict) or result.get("precision") != precision
                    or result.get("resolution") != size
                    or result.get("model") not in (None, model)
                    or result.get("checkpoint") not in (None, str(selected_checkpoint))
                    or result.get("status") not in ("ok", "error", "out_of_memory")):
                raise ValueError("Worker returned invalid case identity or status")
            if result["status"] == "ok":
                if returncode != 0:
                    raise ValueError(f"Worker exited with status {returncode}")
                # A partial/malformed worker report is a failed case, never a
                # fabricated zero latency or a reason to discard other cases.
                for key in ("median_ms", "p90_ms", "passes_per_second", "peak_allocated_bytes"):
                    if not isinstance(result.get(key), (int, float)) or not math.isfinite(result[key]) or result[key] <= 0:
                        raise ValueError(f"Worker returned invalid {key}")
        except (ValueError, OSError) as error:
            result = dict(model=model, precision=precision, resolution=size,
                          width=SIZES[size][0], height=SIZES[size][1],
                          checkpoint=str(selected_checkpoint),
                          status="error", error=f"Invalid worker report: {error}")
    else:
        result = dict(model=model, precision=precision, resolution=size,
                      width=SIZES[size][0], height=SIZES[size][1],
                      checkpoint=str(selected_checkpoint),
                      status="error", error=f"Worker exited with status {returncode}; see {log_path}")
    result.setdefault("model", model)
    result.setdefault("checkpoint", str(selected_checkpoint))
    result.update(elapsed_seconds=time.monotonic() - started, log=str(log_path), returncode=returncode)
    return result


def save_report(args, report):
    write_json(args.output / "results.json", report)
    columns = ("model", "checkpoint", "checkpoint_precision", "precision", "resolution", "width", "height",
               "status", "median_ms", "p10_ms", "p90_ms",
               "passes_per_second", "peak_allocated_bytes", "logical_calls", "physical_launches", "error")
    with (args.output / "results.csv").open("w", encoding="utf8", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=columns, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(report["cases"])
    if args.per_kernel:
        with (args.output / "kernels.csv").open("w", encoding="utf8", newline="") as stream:
            writer = csv.DictWriter(stream, fieldnames=("model", "checkpoint", "precision", "resolution",
                                    "index", "name", "physical_launches", "median_ms", "p10_ms", "p90_ms"),
                                    extrasaction="ignore")
            writer.writeheader()
            for case in report["cases"]:
                for kernel in case.get("kernels") or []:
                    writer.writerow(dict(kernel, model=case.get("model"), checkpoint=case.get("checkpoint"),
                                         precision=case["precision"], resolution=case["resolution"]))


def parser():
    result = argparse.ArgumentParser(description=__doc__)
    result.add_argument("--device", type=int, default=0, help="Local CUDA device index (default: 0)")
    result.add_argument("--model", choices=MODELS, default="legacy71",
                        help="Explicit checkpoint/model family (default: legacy71)")
    result.add_argument("--precision", choices=("auto", "fp16", "fp8"), default="auto")
    result.add_argument("--checkpoint-dir", type=Path, default=ROOT / "ckpts")
    result.add_argument("--checkpoint", type=Path,
                        help="Explicit portable checkpoint used for every tested precision")
    result.add_argument("--output", type=Path, help="New report directory (default: outputs/speed/<timestamp>)")
    result.add_argument("--rebuild", action="store_true", help="Recompile even when a compatible binary exists")
    result.add_argument("--warmup", type=positive_int, default=20, help="Graph warmup replays per case")
    result.add_argument("--samples", type=positive_int, default=30, help="CUDA-event timing samples per case")
    result.add_argument("--iterations", type=positive_int, default=10, help="Replays per sample, 3 passes per replay")
    result.add_argument("--timeout", type=positive_int, default=600, help="Maximum seconds per benchmark case")
    result.add_argument("--per-kernel", action="store_true",
                        help="Also measure each logical call in a separate instrumented complete graph")
    result.add_argument("--worker", nargs=2, metavar=("PRECISION", "SIZE"), help=argparse.SUPPRESS)
    result.add_argument("--extension", type=Path, help=argparse.SUPPRESS)
    result.add_argument("--result", type=Path, help=argparse.SUPPRESS)
    return result


def main(argv=None):
    options = parser()
    args = options.parse_args(argv)
    if args.device < 0:
        options.error("--device must be nonnegative")
    args.checkpoint_dir = args.checkpoint_dir.expanduser().resolve()
    args.checkpoint = args.checkpoint.expanduser().resolve() if args.checkpoint else None
    if args.worker:
        if (args.worker[0] not in ("fp16", "fp8") or args.worker[1] not in SIZES
                or args.model not in MODELS or not args.extension or not args.result):
            options.error("invalid internal worker arguments")
        return worker_main(args)
    import torch
    if not torch.cuda.is_available():
        options.error("A CUDA-capable PyTorch installation and an NVIDIA GPU are required")
    if args.device >= torch.cuda.device_count():
        options.error(f"CUDA device {args.device} does not exist")
    torch.cuda.set_device(args.device)
    properties = torch.cuda.get_device_properties(args.device)
    sm = properties.major * 10 + properties.minor
    supported = supported_precisions(sm)
    if not supported:
        options.error(f"SM{sm} is unsupported; FP16 requires SM80+, FP8 requires SM89+")
    if args.precision != "auto" and args.precision not in supported:
        options.error(f"{args.precision.upper()} is unsupported on SM{sm}")
    precisions = supported if args.precision == "auto" else [args.precision]
    declared_precision = None
    if args.checkpoint is not None:
        if not args.checkpoint.is_file():
            options.error(f"Checkpoint does not exist: {args.checkpoint}")
        if args.model == "legacy71" and not args.checkpoint.with_suffix(".json").is_file():
            options.error(f"legacy71 checkpoint requires its SHA-256 sidecar: {args.checkpoint}")
        with args.checkpoint.open("rb") as stream:
            if stream.read(64).startswith(b"version https://git-lfs.github.com/spec"):
                options.error(f"{args.checkpoint} is a Git LFS pointer; run git lfs pull first")
        manifest = checkpoint_manifest(args.checkpoint)
        if manifest is not None and manifest.get("model") not in (None, args.model):
            options.error(f"Checkpoint model {manifest['model']!r} does not match --model {args.model}")
        try:
            declared_precision = checkpoint_precision(args.checkpoint)
        except (OSError, RuntimeError, ValueError) as error:
            options.error(f"Cannot establish checkpoint precision: {error}")
        if declared_precision == "fp16":
            # A trained/state-only FP16 checkpoint has no original FP8 records.
            if args.precision == "fp8":
                options.error(
                    f"Checkpoint {args.checkpoint} is FP16; FP8 deployment requires an "
                    "original FP8 checkpoint and explicit quantization is not implicit")
            precisions = [name for name in precisions if name == "fp16"]
    else:
        for precision in precisions:
            checkpoint = default_checkpoint_path(args.checkpoint_dir, args.model, precision)
            if not checkpoint.is_file():
                options.error(f"Missing checkpoint: {checkpoint}. Retrieve checkpoints with git lfs pull.")
            if args.model == "legacy71" and not checkpoint.with_suffix(".json").is_file():
                options.error(f"Missing checkpoint manifest: {checkpoint}. Retrieve checkpoints with git lfs pull.")
            with checkpoint.open("rb") as stream:
                if stream.read(64).startswith(b"version https://git-lfs.github.com/spec"):
                    options.error(f"{checkpoint} is a Git LFS pointer; run git lfs pull first")
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S_%fZ")
    args.output = (args.output or ROOT / "outputs" / "speed" / timestamp).expanduser().resolve()
    if args.output.exists():
        options.error("--output already exists; choose a new report directory")
    args.output.mkdir(parents=True)
    cleared = {name: os.environ.pop(name) for name in ENV_OVERRIDES if name in os.environ}
    from tools.speed_build import ensure_extension
    print(f"{properties.name} | SM{sm} | {properties.total_memory / 2**30:.1f} GiB", flush=True)
    print("Prepared feature trunk, batch one; setup and renderer processing excluded.", flush=True)
    build = ensure_extension(args.device, rebuild=args.rebuild)
    skipped = []
    for name in ("fp16", "fp8"):
        if name in precisions:
            continue
        if name not in supported:
            reason = "Requires SM89+"
        elif args.precision != "auto":
            continue
        else:
            reason = f"Checkpoint {args.checkpoint} is FP16-only; FP8 is not selected implicitly"
        skipped.append(dict(precision=name, reason=reason))
    checkpoint_paths = {name: str(selected_checkpoint_path(args, name)) for name in precisions}
    report = dict(schema_version=1, started_utc=datetime.now(timezone.utc).isoformat(), scope=scope_text(args.model),
                  benchmark_sha256=sha256(Path(__file__).resolve()), model=args.model,
                  checkpoint=dict(selection="explicit" if args.checkpoint else "default",
                                  selected=str(args.checkpoint) if args.checkpoint else None,
                                  declared_precision=declared_precision,
                                  paths=checkpoint_paths),
                  device=dict(index=args.device, name=properties.name, sm=sm, total_memory=properties.total_memory),
                  torch_version=torch.__version__, cuda_version=torch.version.cuda,
                  extension=build.binary_path, extension_sha256=sha256(build.binary_path), build=build.receipt,
                  supported_precisions=supported, tested_precisions=precisions,
                  skipped_precisions=skipped,
                  timing=dict(warmup=args.warmup, samples=args.samples, iterations=args.iterations, passes_per_graph=3,
                              distribution="Percentiles of batched per-pass averages"),
                  kernel_timing_scope="Separate graph with per-call timing events; diagnostic, not additive to headline latency",
                  cleared_environment=cleared, cases=[])
    save_report(args, report)
    for entry in report["skipped_precisions"]:
        print(f"Skipping {entry['precision'].upper()}: {entry['reason']}", flush=True)
    print(f"Selected model {args.model}; scope: {scope_text(args.model)}", flush=True)
    for precision in precisions:
        print(f"Checkpoint {precision.upper()}: {checkpoint_paths[precision]}", flush=True)
    print(f"{'Type':<6} {'Input':<17} {'Median ms':>10} {'p90 ms':>10} {'Passes/s':>10} {'VRAM GiB':>10}", flush=True)
    for size, (width, height) in SIZES.items():
        for precision in precisions:
            print(f"Testing {precision.upper()} {size} ({width}x{height}) with {args.model} "
                  f"checkpoint {checkpoint_paths[precision]} ...", flush=True)
            case = run_case(args, build.binary_path, precision, size, os.environ.copy())
            report["cases"].append(case)
            save_report(args, report)
            if case["status"] == "ok":
                print(f"{precision.upper():<6} {f'{width}x{height}':<17} {case['median_ms']:>10.3f} "
                      f"{case['p90_ms']:>10.3f} {case['passes_per_second']:>10.1f} "
                      f"{case['peak_allocated_bytes'] / 2**30:>10.2f}", flush=True)
            else:
                print(f"{precision.upper()} {width}x{height}: {case['status']} - {case.get('error', '')}", flush=True)
    report["completed_utc"] = datetime.now(timezone.utc).isoformat()
    report["success"] = all(case["status"] == "ok" for case in report["cases"])
    save_report(args, report)
    print(f"Reports: {args.output / 'results.json'} and results.csv", flush=True)
    if args.per_kernel:
        print(f"Per-kernel diagnostics: {args.output / 'kernels.csv'} (includes counter resets and split launches)", flush=True)
    return 0 if report["success"] else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("Speed test interrupted; any completed results remain in the report directory.", file=sys.stderr)
        sys.exit(130)
    except (RuntimeError, OSError, ValueError) as error:
        print(f"Speed test failed: {error}", file=sys.stderr)
        sys.exit(1)
