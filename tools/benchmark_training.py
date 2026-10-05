"""Benchmark one full-71-block FP32/BF16 training case with optional checkpointing.

Times autograd forward and diagnostic scalar plus backward in each iteration.
No optimizer update, renderer input pipeline, or no-grad inference is measured.
"""
from pathlib import Path
import argparse
import hashlib
import importlib
import json
import math
import os
import statistics
import sys
import time
import traceback

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PROTOCOL = "full71-training-forward-backward-cli-v1"
TIMINGS = ("forward_autograd_ms", "forward_backward_ms", "backward_plus_scalar_ms",
           "host_forward_backward_ms")


def need(ok, message):
    if not ok:
        raise RuntimeError(message)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def source_snapshot():
    manifest = ROOT / "assets/nr/manifest.json"
    data = json.loads(manifest.read_text(encoding="utf-8"))
    paths = [Path(__file__).resolve(), manifest]
    paths += [ROOT / "dlssnr" / name for name in ("__init__.py", "model.py", "weights.py", "geometry.py")]
    for stage in data["stages"]:
        path = (ROOT / "assets/nr/model" / stage["file"]).resolve()
        need(path.is_relative_to(ROOT / "assets/nr/model"), "checkpoint path escapes model directory")
        need(sha(path) == stage["sha256"], "checkpoint stage hash differs: " + stage["id"])
        paths.append(path)
    return {p.relative_to(ROOT).as_posix(): sha(p) for p in sorted(paths)}


def summarize(samples):
    need(bool(samples), "no complete samples")
    result = {}
    for key in TIMINGS:
        values = [row[key] for row in samples]
        need(all(isinstance(x, (int, float)) and not isinstance(x, bool) and math.isfinite(x) and x > 0
                 for x in values), "invalid timing: " + key)
        result[key] = dict(median=statistics.median(values), min=min(values), max=max(values))
    return result


def measured_step(torch, model, features, geometry, stream, events):
    """Autograd forward and diagnostic backward share one iteration and input."""
    model.zero_grad(set_to_none=True)
    stream.synchronize()
    torch.cuda.reset_peak_memory_stats(features.device)
    start, forward_end, end = events
    wall_start = time.perf_counter()
    with torch.cuda.stream(stream), torch.enable_grad():
        need(torch.is_grad_enabled(), "training forward must have autograd enabled")
        start.record(stream)
        head = model.forward_train(features, geometry=geometry, return_boundaries=False, crop=False)
        need(head.requires_grad, "training output is detached")
        forward_end.record(stream)
        # A benchmark scalar only. No task loss, renderer objective, optimizer or update is proposed.
        loss = head.square().mean()
        loss.backward()
        end.record(stream)
    end.synchronize()
    wall_ms = (time.perf_counter() - wall_start) * 1000.0
    row = dict(forward_autograd_ms=float(start.elapsed_time(forward_end)),
               forward_backward_ms=float(start.elapsed_time(end)),
               backward_plus_scalar_ms=float(forward_end.elapsed_time(end)),
               host_forward_backward_ms=wall_ms,
               peak_allocated_bytes=int(torch.cuda.max_memory_allocated(features.device)),
               peak_reserved_bytes=int(torch.cuda.max_memory_reserved(features.device)))
    # Capture memory before validation adds temporary reductions. Validation stays outside events.
    return row, head, loss


def validate_outputs(torch, model, head, loss):
    need(head.dtype == torch.float32 and head.shape[-1] == 4, "head must be FP32 BHWC C4")
    need(bool(torch.isfinite(head).all().item()), "nonfinite training head")
    need(bool(torch.isfinite(loss).item()), "nonfinite diagnostic scalar")
    used, unused, total = [], [], 0
    for name, parameter in model.named_parameters():
        need(parameter.requires_grad and parameter.dtype == torch.float32, "all master parameters must be trainable FP32")
        total += parameter.numel()
        if parameter.grad is None:
            unused.append(name)
        else:
            need(parameter.grad.dtype == torch.float32, "master gradient dtype differs: " + name)
            need(bool(torch.isfinite(parameter.grad).all().item()), "nonfinite gradient: " + name)
            used.append(name)
    need(bool(used), "backward produced no parameter gradients")
    return dict(head_shape=list(head.shape), head_dtype=str(head.dtype), finite_head=True,
                diagnostic_scalar=float(loss.detach().cpu().item()), finite_used_gradients=True,
                parameter_elements=total, used_parameter_names=used, unused_parameter_names=unused,
                unused_scope="Head-only diagnostic may leave compose-only blend_scale unused; unused names are reported.")


def memory(torch):
    free, total = torch.cuda.mem_get_info()
    return dict(free_bytes=int(free), total_bytes=int(total),
                allocated_bytes=int(torch.cuda.memory_allocated()), reserved_bytes=int(torch.cuda.memory_reserved()))


def write_result(path, value):
    text = json.dumps(value, indent=2, allow_nan=False) + "\n"
    with path.open("x", encoding="utf-8", newline="\n") as output:
        output.write(text)
        output.flush()
        os.fsync(output.fileno())


def parse_args(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--precision", choices=("fp32", "bf16"), required=True)
    parser.add_argument("--width", type=int, required=True)
    parser.add_argument("--height", type=int, required=True)
    parser.add_argument("--warmups", type=int, default=2)
    parser.add_argument("--samples", type=int, default=7)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--checkpoint-blocks", action=argparse.BooleanOptionalAction, default=False,
                        help="Recompute bound stages during backward with non-reentrant checkpointing (default: off).")
    args = parser.parse_args(argv)
    need((args.width, args.height) in ((1280, 720), (1920, 1080), (2560, 1440), (3840, 2160)), "exact chart dimensions required")
    need(args.warmups >= 2 and args.samples >= 7, "at least two warmups and seven samples required")
    need(args.out.parent.is_dir() and not args.out.exists(), "fresh result inside prepared case directory required")
    return args


def main(argv=None):
    args = parse_args(argv)
    pins = source_snapshot()
    result = dict(protocol=PROTOCOL, completed=False, final_identity=False, status="failed",
                  case=dict(precision=args.precision, width=args.width, height=args.height, batch=1),
                  source_snapshot=pins, warmups=args.warmups, sample_count=args.samples,
                  samples=[], completed_samples=0, summary=None,
                  scope=dict(blocks=71, includes_input0_and_head70=True, prepared_feature_trunk=False,
                             grad_enabled_forward=True, master_dtype="torch.float32", trainable_all=True,
                             input_requires_grad=False, optimizer=False, checkpointing=args.checkpoint_blocks,
                             checkpoint_use_reentrant=False if args.checkpoint_blocks else None,
                             checkpoint_scope="bound-stage" if args.checkpoint_blocks else None, compile=False,
                             cuda_graphs=False, extension_loaded=False,
                             backward_scalar="head.square().mean(): benchmark diagnostic, not a proposed task loss",
                             excludes="checkpoint decoding/upload, input allocation/upload, zero_grad and validation checks"))
    stage = "import"
    torch = None
    error = None
    try:
        print("stage: import and checkpoint identity", flush=True)
        sys.path.insert(0, str(ROOT))
        import torch as torch_module
        torch = torch_module
        M = importlib.import_module("dlssnr.model")
        G = importlib.import_module("dlssnr.geometry")
        W = importlib.import_module("dlssnr.weights")
        for module, name in ((M, "model"), (G, "geometry"), (W, "weights")):
            need(Path(module.__file__).resolve() == ROOT / "dlssnr" / (name + ".py"), "unexpected training import origin")
        need(torch.cuda.is_available(), "CUDA device required")
        torch.cuda.set_device(0)
        properties = torch.cuda.get_device_properties(0)
        need((properties.major, properties.minor) == (12, 0), "benchmark expected SM120")
        if args.precision == "bf16":
            need(torch.cuda.is_bf16_supported(), "device lacks BF16 support")
        torch.set_float32_matmul_precision("highest")
        torch.backends.cuda.matmul.allow_tf32 = False
        torch.backends.cudnn.allow_tf32 = False
        torch.backends.cudnn.benchmark = False
        if hasattr(torch.backends.cuda.matmul, "allow_bf16_reduced_precision_reduction"):
            torch.backends.cuda.matmul.allow_bf16_reduced_precision_reduction = False
        result["software"] = dict(python=sys.version, torch=str(torch.__version__), cuda=torch.version.cuda,
                                  cudnn=torch.backends.cudnn.version(), float32_matmul_precision=torch.get_float32_matmul_precision(),
                                  matmul_tf32=bool(torch.backends.cuda.matmul.allow_tf32),
                                  cudnn_tf32=bool(torch.backends.cudnn.allow_tf32),
                                  bf16_reduced_precision_reduction=getattr(torch.backends.cuda.matmul, "allow_bf16_reduced_precision_reduction", None),
                                  deterministic_algorithms=torch.are_deterministic_algorithms_enabled())
        result["device"] = dict(name=properties.name, sm=properties.major * 10 + properties.minor,
                                multiprocessors=properties.multi_processor_count, total_memory_bytes=properties.total_memory)
        result["allocation_preflight"] = memory(torch)
        geometry = G.Geometry.from_valid(args.width, args.height)
        result["geometry"] = dict(valid_width=args.width, valid_height=args.height,
                                  full_width=geometry.full_width, full_height=geometry.full_height,
                                  levels=geometry.levels)
        stage = "model_cpu_decode"
        print("stage: decode all 153 records and create trainable FP32 masters", flush=True)
        model = M.DLSSNR.from_directory(ROOT / "assets/nr", device="cpu", dtype=torch.float32,
                                        precision=args.precision, trainable=True, verify_hashes=True,
                                        checkpoint_blocks=args.checkpoint_blocks)
        need(len(model.blocks) == 71, "full model census")
        need(model.checkpoint_blocks is args.checkpoint_blocks, "requested block checkpoint setting differs")
        need(all(p.requires_grad and p.dtype == torch.float32 for p in model.parameters()), "trainable FP32 master setup")
        result["parameter_bytes"] = sum(p.numel() * p.element_size() for p in model.parameters())
        stage = "model_cuda_upload"
        print("stage: allocate model on CUDA", flush=True)
        model = model.to(device="cuda", dtype=torch.float32).train()
        versions = {name: p._version for name, p in model.named_parameters()}
        stage = "input_cpu_allocation"
        generator = torch.Generator(device="cpu").manual_seed(1729)
        cpu_input = torch.randn((1, geometry.full_height, geometry.full_width, 16),
                                generator=generator, dtype=torch.float32).mul_(0.02)
        result["fixture"] = dict(seed=1729, scale=0.02, dtype="torch.float32", shape=list(cpu_input.shape),
                                 sha256=hashlib.sha256(memoryview(cpu_input.numpy()).cast("B")).hexdigest(),
                                 source="Synthetic prepared floating features; not renderer output or a training dataset")
        result["input_bytes"] = cpu_input.numel() * cpu_input.element_size()
        stage = "input_cuda_upload"
        print("stage: allocate identical seeded FP32 input on CUDA", flush=True)
        features = cpu_input.to(device="cuda")
        del cpu_input
        torch.cuda.synchronize()
        result["allocated_before_iterations"] = memory(torch)
        stream = torch.cuda.Stream()
        events = tuple(torch.cuda.Event(enable_timing=True) for _ in range(3))
        for event in events:
            event.record(stream)
        stream.synchronize()
        warmup_proof = None
        for index in range(args.warmups + args.samples):
            warmup = index < args.warmups
            number = index if warmup else index - args.warmups
            stage = ("warmup" if warmup else "sample") + "_" + str(number) + "_forward_backward"
            print("stage: " + stage, flush=True)
            row, head, loss = measured_step(torch, model, features, geometry, stream, events)
            if index == 0 or index == args.warmups + args.samples - 1:
                stage += "_validation"
                proof = validate_outputs(torch, model, head, loss)
                if index == 0:
                    warmup_proof = proof
                else:
                    result["last_sample_proof"] = proof
            if not warmup:
                row["sample"] = number
                result["samples"].append(row)
                result["completed_samples"] = len(result["samples"])
            del head, loss
        stream.synchronize()
        need(versions == {name: p._version for name, p in model.named_parameters()}, "master parameter mutated without optimizer")
        result.update(status="passed", first_warmup_proof=warmup_proof, parameter_versions_unchanged=True,
                      summary=summarize(result["samples"]),
                      memory_peak=dict(allocated_bytes=max(r["peak_allocated_bytes"] for r in result["samples"]),
                                       reserved_bytes=max(r["peak_reserved_bytes"] for r in result["samples"])))
        print("stage: all measurements and finite-gradient checks complete", flush=True)
    except BaseException as exc:
        error = exc
        is_oom = (torch is not None and isinstance(exc, torch.OutOfMemoryError)) or isinstance(exc, MemoryError)
        result.update(status="oom" if is_oom else "failed", error=repr(exc), failure_stage=stage,
                      traceback=traceback.format_exc(), summary=None)
        if is_oom:
            result["oom_stage"] = stage
            result["oom_kind"] = "cuda_or_torch_allocation" if torch is not None and isinstance(exc, torch.OutOfMemoryError) else "host_allocation"
        if torch is not None:
            try:
                result["memory_at_failure"] = memory(torch)
            except BaseException as secondary:
                result["memory_query_failure"] = repr(secondary)
        print("stage: " + result["status"] + " at " + stage + ": " + repr(exc), flush=True)
    try:
        need(source_snapshot() == pins, "training source or checkpoint changed")
        result.update(completed=True, final_identity=True)
    except BaseException as secondary:
        result.update(status="failed", identity_error=repr(secondary), summary=None)
        if error is None:
            error = secondary
    try:
        write_result(args.out, result)
    except BaseException as secondary:
        if error is not None and hasattr(error, "add_note"):
            error.add_note("result write failed: " + repr(secondary))
        primary = error if error is not None else secondary
        traceback.print_exception(primary, file=sys.stderr)
        sys.stdout.flush()
        sys.stderr.flush()
        os._exit(70)
    sys.stdout.flush()
    sys.stderr.flush()
    # An allocation/device failure ends this process; no allocator reuse or retry at a smaller shape.
    # Keep exception-held tensor owners alive until exit rather than unwinding a failed CUDA frame.
    if error is not None:
        os._exit(0 if result["status"] == "oom" and result["final_identity"] else 70)


if __name__ == "__main__":
    main()
