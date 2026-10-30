"""Focused portable-checkpoint acceptance runner for one explicit case.

This is not a benchmark sweep.  It executes exactly one requested case at one
geometry and writes scalar hashes/counts plus provenance:

* ``--mode native``: load a portable checkpoint from a fresh isolated copy,
  build the reconstructed model-specific native plan, run eager and graph
  replay, verify finite logical output, guards and repeatability, and optionally
  compare against an explicitly supplied archive/reference checkpoint.
* ``--mode training``: build a floating training model from the portable
  checkpoint, run a finite forward/backward and one real AdamW step, save and
  reload the master state, export explicit FP16 with the learned exporter, and
  compare the reloaded portable native FP16 output against the original
  in-memory Half baseline.  Learned FP8 export is rejected explicitly.

Importing this module performs no Torch/CUDA work, so ``--help`` and syntax
checks work with ``CUDA_VISIBLE_DEVICES=-1``.  The GPU modes require an explicit
invocation under a GPU lease.  No vendor DLL module is loaded here.
"""
from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
from pathlib import Path
import shutil
import sys
import traceback

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

MODES = ("native", "training")
NATIVE_PRECISIONS = ("fp16", "fp8")
TRAINING_PRECISIONS = ("fp32", "bf16")
DEFAULT_LEARNING_RATE = 1e-5
SEED = 320
INPUT_SCALE = 0.02
FEATURE_SCALE = 0.02


def positive_int(value):
    number = int(value)
    if number < 1:
        raise argparse.ArgumentTypeError("must be a positive integer")
    return number


def finite_positive_rate(value):
    """Accept only a finite, strictly positive AdamW step size."""
    try:
        number = float(value)
    except (TypeError, ValueError):
        raise argparse.ArgumentTypeError("must be a finite number") from None
    if not math.isfinite(number) or number <= 0.0:
        raise argparse.ArgumentTypeError("must be finite and strictly positive")
    return number


def sha256_file(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def tensor_sha256(value):
    import torch
    raw = value.detach().to(device="cpu").contiguous().view(torch.uint8)
    return hashlib.sha256(raw.numpy().tobytes()).hexdigest()


def write_json(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, allow_nan=False, default=str) + "\n", encoding="utf8")


def mark(report, phase):
    report["phase"] = phase
    print(f"[validate] {phase}", flush=True)


def parser():
    result = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    result.add_argument("--model", choices=("legacy71", "small31"), required=True,
                        help="Explicit checkpoint/model family; never inferred from the file")
    result.add_argument("--checkpoint", type=Path, required=True,
                        help="Portable .pt checkpoint to validate")
    result.add_argument("--mode", choices=MODES, required=True,
                        help="native deployment case or training/export case")
    result.add_argument("--native-precision", choices=NATIVE_PRECISIONS, default="fp16",
                        help="Native deployment precision for --mode native (default: fp16)")
    result.add_argument("--training-precision", choices=TRAINING_PRECISIONS, default="fp32",
                        help="Training compute precision for --mode training (default: fp32)")
    result.add_argument("--width", type=positive_int, default=320, help="Valid image width (default: 320)")
    result.add_argument("--height", type=positive_int, default=320, help="Valid image height (default: 320)")
    result.add_argument("--learning-rate", type=finite_positive_rate, default=str(DEFAULT_LEARNING_RATE),
                        help="Diagnostic AdamW step size for --mode training; not a recommended "
                             "training recipe (default: 1e-5)")
    result.add_argument("--seed", type=int, default=SEED, help="Deterministic synthetic-input seed")
    result.add_argument("--device", type=int, default=0, help="Local CUDA device index (default: 0)")
    result.add_argument("--extension", type=Path,
                        help="Existing reconstructed extension binary; never rebuilt by this runner")
    result.add_argument("--expected-extension-sha256",
                        help="Require this exact extension SHA-256 before loading it")
    result.add_argument("--archive", type=Path,
                        help="Optional explicit archive directory or reference checkpoint for the native comparison")
    result.add_argument("--output", type=Path,
                        help="New work/report directory (default: outputs/checkpoint-acceptance/<timestamp>)")
    return result


def isolated_checkpoint(args, payload, report):
    """Copy only the portable file and the sidecar the selected format needs."""
    source = args.checkpoint
    isolated = args.output / "isolated"
    isolated.mkdir(parents=True, exist_ok=True)
    checkpoint = isolated / source.name
    shutil.copyfile(source, checkpoint)
    sidecar_required = (payload.get("format_version") == 2 or
                        payload.get("model") == "legacy71")
    sidecar = source.with_suffix(".json")
    copied_sidecar = None
    if sidecar_required:
        if not sidecar.is_file():
            raise ValueError(f"selected format requires its SHA-256 sidecar: {sidecar}")
        shutil.copyfile(sidecar, checkpoint.with_suffix(".json"))
        copied_sidecar = str(checkpoint.with_suffix(".json"))
    report["isolation"] = dict(
        source=str(source), isolated=str(checkpoint), isolated_sha256=sha256_file(checkpoint),
        sidecar_required=sidecar_required, copied_sidecar=copied_sidecar,
        note="A fresh copy is loaded; the source path and archive/DLL are not consulted afterwards",
    )
    return checkpoint


def make_input(torch, elements, precision, device, seed):
    generator = torch.Generator(device="cpu").manual_seed(seed)
    values = torch.randn(elements, generator=generator, dtype=torch.float32) * INPUT_SCALE
    if precision == "fp16":
        typed = values.to(torch.float16)
    else:
        typed = values.clamp(-448.0, 448.0).to(torch.float8_e4m3fn)
    if not bool(torch.isfinite(typed.float()).all()):
        raise RuntimeError("synthetic input is nonfinite for the selected native precision")
    return typed.view(torch.uint8).to(device)


def finite_logical(output, output_bytes, dtype, torch):
    typed = output[:output_bytes].view(dtype)
    return bool(torch.isfinite(typed.float()).all().item()), int(typed.numel())


def load_reference(args, torch):
    if args.archive.is_dir():
        if args.model != "small31":
            raise ValueError(
                "legacy71 reference must be a checkpoint file; archive directories are "
                "only a public reference owner for small31")
        from dlssnr.small_deployment import load_native_model
        # The normal verified loader is authoritative for both formats.  A v3
        # checkpoint without a sidecar is valid under this same loader; a v2
        # checkpoint still requires its sidecar.
        return load_native_model(args.archive, model=args.model, verify_hash=True)
    from dlssnr.checkpoint import load_checkpoint
    return load_checkpoint(args.archive, model=args.model, verify_hash=True)


def tensor_bytes_equal(torch, left, right):
    """Bitwise equality including dtype/shape; no surrogate tolerance."""
    if left.dtype != right.dtype or tuple(left.shape) != tuple(right.shape):
        return False
    return bool(torch.equal(left.detach().to("cpu").contiguous().view(torch.uint8),
                            right.detach().to("cpu").contiguous().view(torch.uint8)))



def first_difference(torch, actual, expected):
    different = actual != expected
    count = int(different.sum().item())
    if count == 0:
        return dict(mismatches=0, first_byte=None)
    index = int(different.nonzero()[0].item())
    return dict(mismatches=count, first_byte=index)


def run_native(args, report, torch, checkpoint):
    from dlssnr.geometry import Geometry
    from dlssnr.model_specs import resolve_model
    from tuning.generate_plan import build_plan
    from tuning.physical_schedule import make

    precision = args.native_precision
    if precision == "fp8" and getattr(checkpoint, "precision", None) != "fp8":
        raise ValueError(f"FP8 native deployment requires an original FP8 checkpoint, not {checkpoint.precision}")
    geometry = Geometry.from_valid(args.width, args.height)
    schedule = make(args.width, args.height, precision=precision, model=args.model)
    spec = build_plan(schedule, resolve_model(args.model))
    input_bytes = spec["buffers"]["input"]["storage_bytes"]
    elements = input_bytes // (2 if precision == "fp16" else 1)
    output_bytes = spec["buffers"]["b69.output"]["logical_bytes"]
    dtype = torch.float16 if precision == "fp16" else torch.float8_e4m3fn
    report["geometry"] = dict(valid_width=args.width, valid_height=args.height,
                              full_width=geometry.full_width, full_height=geometry.full_height,
                              levels=list(geometry.levels), input_bytes=input_bytes,
                              input_elements=elements, input_scale=INPUT_SCALE,
                              input_seed=args.seed,
                              output_logical_bytes=output_bytes,
                              model_schedule_calls=schedule["census"]["calls"],
                              model_schedule_records=schedule["census"]["record_positions"])
    state = make_input(torch, elements, precision, f"cuda:{args.device}", args.seed)
    reference_state = state.clone() if args.archive is not None else None
    stream = torch.cuda.Stream(device=args.device)
    mark(report, "native-create-plan")
    with torch.inference_mode(), torch.cuda.stream(stream):
        plan = getattr(checkpoint, "create_plan_" + precision)(state, width=args.width, height=args.height)
        run = getattr(plan, "run_" + precision)
        counts = list(plan.split_launch_counts())
        if len(counts) != schedule["census"]["calls"]:
            raise RuntimeError(
                f"native plan has {len(counts)} logical calls; {args.model} {precision} "
                f"schedule requires {schedule['census']['calls']}")
        mark(report, "native-eager")
        first = run()
        stream.synchronize()
        eager = first[:output_bytes].clone()
        second = run()
        stream.synchronize()
        eager_again = second[:output_bytes].clone()
        report["native"] = dict(
            precision=precision, checkpoint_precision=checkpoint.precision,
            logical_calls=len(counts), physical_launches=int(sum(counts)),
            output_sha256=tensor_sha256(eager),
            eager_repeatable=bool(torch.equal(eager, eager_again)),
            guards_intact=bool(plan.guards_intact()),
        )
        if not report["native"]["eager_repeatable"]:
            raise RuntimeError("eager native output differs between two identical runs")
        if not report["native"]["guards_intact"]:
            raise RuntimeError("native plan guards were modified by eager execution")
        finite, numel = finite_logical(eager, output_bytes, dtype, torch)
        report["native"].update(logical_elements=numel, output_finite=finite)
        if not finite:
            raise RuntimeError("logical typed native output is nonfinite")
        mark(report, "native-graph")
        graph = torch.cuda.CUDAGraph()
        try:
            with torch.cuda.graph(graph, stream=stream):
                run()
            graph.replay()
            stream.synchronize()
            replay_a = first[:output_bytes].clone()
            graph.replay()
            stream.synchronize()
            replay_b = first[:output_bytes].clone()
        finally:
            stream.synchronize()
            graph.reset()
        replay_finite, _ = finite_logical(replay_b, output_bytes, dtype, torch)
        report["native"].update(
            graph_sha256=tensor_sha256(replay_b),
            graph_matches_eager=bool(torch.equal(eager, replay_a)),
            graph_repeatable=bool(torch.equal(replay_a, replay_b)),
            graph_output_finite=replay_finite,
            guards_intact_after_graph=bool(plan.guards_intact()),
        )
        if not (report["native"]["graph_matches_eager"] and report["native"]["graph_repeatable"]):
            raise RuntimeError("native graph replay differs from eager execution or itself")
        if not report["native"]["graph_output_finite"]:
            raise RuntimeError("graph-replayed logical typed native output is nonfinite")
        if not report["native"]["guards_intact_after_graph"]:
            raise RuntimeError("native plan guards were modified by graph execution")

        if args.archive is not None:
            mark(report, "native-reference")
            reference = load_reference(args, torch)
            if precision == "fp8" and getattr(reference, "precision", None) != "fp8":
                raise ValueError("reference checkpoint is not an original FP8 checkpoint")
            reference_plan = getattr(reference, "create_plan_" + precision)(
                reference_state, width=args.width, height=args.height)
            reference_run = getattr(reference_plan, "run_" + precision)
            reference_output = reference_run()
            stream.synchronize()
            compared = reference_output[:output_bytes].clone()
            difference = first_difference(torch, compared, eager)
            report["native_reference"] = dict(
                path=str(args.archive), kind="directory" if args.archive.is_dir() else "checkpoint",
                precision=getattr(reference, "precision", None),
                output_sha256=tensor_sha256(compared),
                equals_portable=bool(difference["mismatches"] == 0),
                mismatches=difference["mismatches"], first_byte=difference["first_byte"],
            )
            if difference["mismatches"]:
                raise RuntimeError(
                    f"portable output differs from explicit reference: {difference['mismatches']} bytes, "
                    f"first at {difference['first_byte']}")
            if not bool(reference_plan.guards_intact()):
                raise RuntimeError("reference native plan guards were modified")
        del plan
    return checkpoint


def master_state_equal(torch, left, right):
    if set(left) != set(right):
        return False, "state key roster differs"
    for name in left:
        a, b = left[name], right[name]
        if not isinstance(a, torch.Tensor):
            if a != b:
                return False, f"non-tensor state differs: {name}"
            continue
        if a.dtype != b.dtype or a.shape != b.shape:
            return False, f"state dtype/shape differs: {name}"
        if not torch.equal(a.detach().to("cpu").contiguous().view(torch.uint8),
                           b.detach().to("cpu").contiguous().view(torch.uint8)):
            return False, f"state bytes differ: {name}"
    return True, "bitwise equal"


def native_target_dtype(torch, expected):
    if expected.dtype in (torch.float8_e4m3fn, torch.float16):
        return torch.float16
    if expected.dtype == torch.float32:
        return torch.float32
    raise RuntimeError(f"native schema dtype is not FP8/Half/Float32: {expected.dtype}")


def quantized_post_step_state(torch, live_state, model_id):
    """Map the live post-step masters to native keys and quantize explicitly.

    Small role keys are only mapped after the canonical identity in
    ``_extra_state`` has been checked against the committed identity.
    """
    if model_id == "small31":
        from dlssnr.portable_checkpoint import canonical_small_identity, small31_state_schema
        identity = live_state.get("_extra_state")
        canonical = canonical_small_identity()
        if not isinstance(identity, dict):
            raise RuntimeError("post-step Small31 state has no _extra_state identity")
        for key, expected in canonical.items():
            if identity.get(key) != expected:
                raise RuntimeError(
                    f"post-step Small31 identity differs for {key!r}: "
                    f"{identity.get(key)!r} != {expected!r}")
        prefix = "blocks.by_role."
        mapped = {}
        for name, value in live_state.items():
            if name == "_extra_state":
                continue
            if not name.startswith(prefix):
                raise RuntimeError(f"unexpected post-step Small31 state key {name!r}")
            mapped["blocks." + name[len(prefix):]] = value
        schema = small31_state_schema()
    else:
        from dlssnr.checkpoint import _SchemaArchive, native_state_dict
        mapped = dict(live_state)
        schema = native_state_dict(_SchemaArchive())

    if set(mapped) != set(schema):
        missing = sorted(set(schema) - set(mapped))
        extra = sorted(set(mapped) - set(schema))
        raise RuntimeError(
            f"post-step state roster differs from the native schema: "
            f"missing={missing}, extra={extra}")
    quantized = {}
    for name, expected in schema.items():
        value = mapped[name]
        if not isinstance(value, torch.Tensor):
            raise RuntimeError(f"post-step state entry is not a tensor: {name}")
        if tuple(value.shape) != tuple(expected.shape):
            raise RuntimeError(
                f"post-step state shape differs for {name}: "
                f"{tuple(value.shape)} != {tuple(expected.shape)}")
        target = native_target_dtype(torch, expected)
        quantized[name] = value.detach().to(device="cpu").contiguous().to(dtype=target).clone()
    return quantized


def in_memory_checkpoint(torch, model_id, quantized_state):
    """Build the serialization target in memory from independently quantized state."""
    metadata = {"provenance": "trained",
                "source": {"kind": "post_step_master_quantized"}}
    if model_id == "small31":
        from dlssnr.portable_checkpoint import SmallCheckpoint, canonical_small_identity
        payload = dict(
            format_version=3, model="small31", model_class="dlssnr.SmallDLSSNR",
            weight_precision="fp16", storage="state_dict", state_dict=quantized_state,
            native_records={}, model_identity=canonical_small_identity(), metadata=metadata)
        return SmallCheckpoint(payload)
    from dlssnr.checkpoint import Checkpoint
    payload = dict(
        format_version=2, model="legacy71", model_class="dlssnr.DLSSNR",
        weight_precision="fp16", state_dict=quantized_state, native_records={},
        metadata=metadata)
    return Checkpoint(payload)


def run_training(args, report, torch, checkpoint):
    from dlssnr.geometry import Geometry

    precision = args.training_precision
    geometry = Geometry.from_valid(args.width, args.height)
    device = f"cuda:{args.device}"
    work = args.output / "training"
    work.mkdir(parents=True, exist_ok=True)
    report["geometry"] = dict(valid_width=args.width, valid_height=args.height,
                              full_width=geometry.full_width, full_height=geometry.full_height,
                              levels=list(geometry.levels), feature_seed=args.seed,
                              feature_scale=FEATURE_SCALE)
    mark(report, "training-construct")
    model = checkpoint.training_model(device=device, precision=precision, trainable=True)
    non_fp32 = [name for name, value in model.named_parameters() if value.dtype != torch.float32]
    if non_fp32:
        raise RuntimeError(f"training model does not keep FP32 masters: {non_fp32[:4]}")
    if getattr(model, "precision", None) != precision:
        raise RuntimeError(f"training model precision is {model.precision!r}, expected {precision!r}")
    total_parameters = sum(value.numel() for value in model.parameters())
    if total_parameters == 0:
        raise RuntimeError("training model has no parameters")
    before = {name: value.detach().to("cpu").clone() for name, value in model.named_parameters()}
    generator = torch.Generator(device="cpu").manual_seed(args.seed)
    features = (torch.randn((1, geometry.full_height, geometry.full_width, 16),
                            generator=generator, dtype=torch.float32) * FEATURE_SCALE).to(device)
    if not bool(torch.isfinite(features).all()):
        raise RuntimeError("synthetic training features are nonfinite")
    mark(report, "training-forward-backward")
    model.train()
    output = model.forward_train(features, geometry=geometry)
    if not bool(torch.isfinite(output.float()).all()):
        raise RuntimeError("training forward output is nonfinite")
    loss = output.float().square().mean()
    if not bool(torch.isfinite(loss)):
        raise RuntimeError("training loss is nonfinite")
    loss.backward()
    grads = []
    missing_gradients = []
    for name, value in model.named_parameters():
        if value.grad is None:
            missing_gradients.append(name)
        else:
            grads.append((name, value.grad))
    if not grads:
        raise RuntimeError("no parameter gradients were produced")
    nonfinite = [name for name, value in grads if not bool(torch.isfinite(value).all())]
    if nonfinite:
        raise RuntimeError(f"nonfinite parameter gradients: {nonfinite[:4]}")
    # Weight decay is applied later by the optimizer, so only a nonzero
    # backward gradient proves that the loss depended on a parameter.
    nonzero_gradients = [name for name, value in grads if bool((value != 0).any().item())]
    if not nonzero_gradients:
        raise RuntimeError(
            "backward produced no nonzero parameter gradient; weight decay alone is not learning")
    optimizer = torch.optim.AdamW(model.parameters(), lr=args.learning_rate)
    mark(report, "training-optimizer-step")
    optimizer.step()
    optimizer.zero_grad(set_to_none=True)
    changed = [name for name, original in before.items()
               if not torch.equal(model.get_parameter(name).detach().to("cpu").contiguous().view(torch.uint8),
                                  original.contiguous().view(torch.uint8))]
    if not changed:
        raise RuntimeError("optimizer step did not change any parameter")
    live_post_step = {
        name: (value.detach().to("cpu").contiguous().clone()
               if isinstance(value, torch.Tensor) else value)
        for name, value in model.state_dict().items()
    }
    report["training"] = dict(
        precision=precision, fp32_master_parameters=total_parameters,
        feature_seed=args.seed, feature_scale=FEATURE_SCALE,
        finite_forward=True, finite_loss=True, gradient_tensors=len(grads),
        missing_gradient_count=len(missing_gradients),
        missing_gradient_names=missing_gradients,
        nonzero_gradient_tensors=len(nonzero_gradients),
        finite_gradients=True, optimizer="AdamW", learning_rate=args.learning_rate,
        changed_parameter_tensors=len(changed), changed_parameter_examples=changed[:8],
        master_state_note=("FP32 master training state; not a directly deployable FP8 "
                           "checkpoint and not labelled as one"),
    )
    mark(report, "training-post-step-forward")
    model.eval()
    with torch.no_grad():
        post_step_output = model.forward_train(features, geometry=geometry)
    if not bool(torch.isfinite(post_step_output.float()).all()):
        raise RuntimeError("post-step trained output is nonfinite")
    del output, loss
    torch.cuda.empty_cache()

    mark(report, "training-save-master")
    master_path = work / "master_state_fp32.pt"
    torch.save(model.state_dict(), master_path)
    master_saved = torch.load(master_path, map_location="cpu", weights_only=True)
    mark(report, "training-reload-master")
    fresh = checkpoint.training_model(device=device, precision=precision, trainable=True)
    fresh.load_state_dict(master_saved, strict=True)
    equal, reason = master_state_equal(torch, master_saved, fresh.state_dict())
    if not equal:
        raise RuntimeError(f"fresh training instance differs from saved master state: {reason}")
    fresh.eval()
    with torch.no_grad():
        reload_output = fresh.forward_train(features, geometry=geometry)
    if not bool(torch.isfinite(reload_output.float()).all()):
        raise RuntimeError("fresh reloaded training instance produced nonfinite output")
    if not tensor_bytes_equal(torch, reload_output, post_step_output):
        raise RuntimeError(
            "fresh reloaded training output differs from the post-step live-model output")
    report["training"].update(
        master_state_path=str(master_path), master_state_sha256=sha256_file(master_path),
        master_state_bitwise_equal=True, fresh_forward_finite=True,
        post_step_output_sha256=tensor_sha256(post_step_output),
        reload_matches_post_step_output=True,
    )
    del reload_output, post_step_output, master_saved
    torch.cuda.empty_cache()

    mark(report, "export-reject-fp8")
    rejected_path = work / "rejected_fp8.pt"
    from dlssnr.trained_checkpoint import export_trained_checkpoint
    try:
        export_trained_checkpoint(fresh, rejected_path, model=args.model, precision="fp8")
    except ValueError as error:
        if "learned FP8 export is unsupported" not in str(error):
            raise RuntimeError(
                f"learned FP8 export raised an unrelated ValueError: {error}") from error
        rejection = f"{type(error).__name__}: {error}"
    except Exception as error:
        raise RuntimeError(
            f"learned FP8 export raised {type(error).__name__}, expected the intended "
            f"ValueError: {error}") from error
    else:
        rejection = None
    if rejected_path.exists() or rejected_path.with_suffix(".json").exists():
        raise RuntimeError("learned FP8 export created an output file despite being unsupported")
    if rejection is None:
        raise RuntimeError("learned FP8 export did not reject")
    report["training"]["learned_fp8_export"] = dict(
        rejected=True, error=rejection, error_type="ValueError",
        intended_message="learned FP8 export is unsupported")

    mark(report, "export-trained-fp16")
    export_path = work / "trained_fp16.pt"
    receipt = export_trained_checkpoint(fresh, export_path, model=args.model, precision="fp16")
    if not export_path.is_file():
        raise RuntimeError("trained FP16 export did not create a checkpoint file")
    mark(report, "export-reload-fp16")
    from dlssnr.checkpoint import load_checkpoint
    exported = load_checkpoint(export_path, model=args.model, verify_hash=True)
    if getattr(exported, "precision", None) != "fp16":
        raise RuntimeError("exported checkpoint does not declare FP16")
    exported_payload = torch.load(export_path, map_location="cpu", weights_only=True)
    exported_raw = exported_payload["state_dict"]
    if exported_payload.get("native_records"):
        raise RuntimeError("trained export carries stale native FP8 records")

    quantized_live = quantized_post_step_state(torch, live_post_step, args.model)
    if set(exported_raw) != set(quantized_live):
        raise RuntimeError(
            "exported state roster differs from the post-step native schema roster")
    export_mismatches = [name for name, expected in quantized_live.items()
                         if not tensor_bytes_equal(torch, exported_raw[name], expected)]
    if export_mismatches:
        raise RuntimeError(
            f"exported state differs from the independently quantized post-step master: "
            f"{export_mismatches[:8]}")

    baseline_state = checkpoint.state_dict(dtype=torch.float32)
    baseline_quantized = {}
    for name, value in quantized_live.items():
        if name not in baseline_state:
            raise RuntimeError(f"native state key is absent from the source checkpoint: {name}")
        baseline_quantized[name] = baseline_state[name].to(dtype=value.dtype)
    changed_state = [name for name, value in quantized_live.items()
                     if not tensor_bytes_equal(torch, value, baseline_quantized[name])]
    changed_half_state = [name for name in changed_state if quantized_live[name].dtype == torch.float16]
    if not changed_state:
        raise RuntimeError("no trained state change survived native FP16 quantization")
    if not changed_half_state:
        raise RuntimeError(
            "trained changes survived only in Float32 record fields; no Half field changed")
    report["training"].update(
        exported_checkpoint=str(export_path), exported_sha256=sha256_file(export_path),
        export_receipt=receipt, export_precision=exported.precision,
        export_native_records=0, export_state_tensors=len(exported_raw),
        export_state_matches_post_step_master=True,
        export_state_mismatch_count=0,
        changed_state_keys=len(changed_state),
        changed_half_state_keys=len(changed_half_state),
        changed_state_examples=changed_half_state[:8],
    )
    del exported_payload, exported_raw, baseline_state, baseline_quantized
    torch.cuda.empty_cache()

    mark(report, "compare-native-fp16")
    from dlssnr.geometry import Geometry as GeometryType
    from tuning.generate_plan import build_plan
    from tuning.physical_schedule import make
    from dlssnr.model_specs import resolve_model
    native_geometry = GeometryType.from_valid(args.width, args.height)
    schedule = make(args.width, args.height, precision="fp16", model=args.model)
    spec = build_plan(schedule, resolve_model(args.model))
    elements = spec["buffers"]["input"]["storage_bytes"] // 2
    output_bytes = spec["buffers"]["b69.output"]["logical_bytes"]
    native_state = make_input(torch, elements, "fp16", device, args.seed)
    in_memory = in_memory_checkpoint(torch, args.model, quantized_live)
    stream = torch.cuda.Stream(device=args.device)
    with torch.inference_mode(), torch.cuda.stream(stream):
        baseline_plan = checkpoint.create_plan_fp16(native_state.clone(), width=args.width, height=args.height)
        exported_plan = exported.create_plan_fp16(native_state.clone(), width=args.width, height=args.height)
        in_memory_plan = in_memory.create_plan_fp16(native_state.clone(), width=args.width, height=args.height)
        baseline_output = baseline_plan.run_fp16()
        stream.synchronize()
        baseline_bytes = baseline_output[:output_bytes].clone()
        exported_output = exported_plan.run_fp16()
        stream.synchronize()
        exported_bytes = exported_output[:output_bytes].clone()
        in_memory_output = in_memory_plan.run_fp16()
        stream.synchronize()
        in_memory_bytes = in_memory_output[:output_bytes].clone()
        difference = first_difference(torch, exported_bytes, baseline_bytes)
        serialization_difference = first_difference(torch, exported_bytes, in_memory_bytes)
        finite, numel = finite_logical(exported_bytes, output_bytes, torch.float16, torch)
        baseline_finite, _ = finite_logical(baseline_bytes, output_bytes, torch.float16, torch)
        in_memory_finite, _ = finite_logical(in_memory_bytes, output_bytes, torch.float16, torch)
        report["native_compare"] = dict(
            width=args.width, height=args.height,
            full_width=native_geometry.full_width, full_height=native_geometry.full_height,
            precision="fp16",
            baseline="original portable checkpoint Half baseline (in-memory quantized)",
            candidate="exported trained FP16 portable checkpoint reload",
            serialization_target="in-memory checkpoint built from independently quantized post-step state",
            baseline_output_sha256=tensor_sha256(baseline_bytes),
            exported_output_sha256=tensor_sha256(exported_bytes),
            in_memory_checkpoint_output_sha256=tensor_sha256(in_memory_bytes),
            native_outputs_differ=bool(difference["mismatches"] != 0),
            differing_bytes=difference["mismatches"], first_byte=difference["first_byte"],
            reloaded_matches_in_memory_quantized=bool(serialization_difference["mismatches"] == 0),
            serialization_mismatches=serialization_difference["mismatches"],
            serialization_first_byte=serialization_difference["first_byte"],
            logical_elements=numel, exported_output_finite=finite,
            baseline_output_finite=baseline_finite,
            in_memory_output_finite=in_memory_finite,
            baseline_guards_intact=bool(baseline_plan.guards_intact()),
            exported_guards_intact=bool(exported_plan.guards_intact()),
            in_memory_guards_intact=bool(in_memory_plan.guards_intact()),
            comparison_note=("Like-for-like reconstructed FP16 plans on the same deterministic "
                             "input; the serialization target is built from the independently "
                             "quantized post-step master, never from the FP32/BF16 surrogate"),
        )
        if not finite:
            raise RuntimeError("exported native FP16 logical output is nonfinite")
        if not baseline_finite:
            raise RuntimeError("original native FP16 baseline logical output is nonfinite")
        if not in_memory_finite:
            raise RuntimeError("in-memory quantized native FP16 output is nonfinite")
        if not (report["native_compare"]["baseline_guards_intact"] and
                report["native_compare"]["exported_guards_intact"] and
                report["native_compare"]["in_memory_guards_intact"]):
            raise RuntimeError("native FP16 plan guards were modified")
        if serialization_difference["mismatches"]:
            raise RuntimeError(
                "reloaded exported native output differs from the in-memory quantized "
                f"checkpoint: {serialization_difference['mismatches']} bytes, "
                f"first at {serialization_difference['first_byte']}")
        if difference["mismatches"] == 0:
            raise RuntimeError(
                "no native FP16 output change survived Half rounding; "
                f"Half state changes were {changed_half_state[:8]}")
        del baseline_plan, exported_plan, in_memory_plan
    return checkpoint



def execute(args, report):
    import torch

    mark(report, "checkpoint-inspect")
    payload = torch.load(args.checkpoint, map_location="cpu", weights_only=True, mmap=True)
    if not isinstance(payload, dict):
        raise ValueError("portable checkpoint payload is not a mapping")
    declared_model = payload.get("model")
    if declared_model not in (None, args.model):
        raise ValueError(f"checkpoint model {declared_model!r} does not match --model {args.model}")
    report["checkpoint"] = dict(
        source=str(args.checkpoint), sha256=sha256_file(args.checkpoint),
        format_version=payload.get("format_version"), model=declared_model,
        weight_precision=payload.get("weight_precision"), storage=payload.get("storage"),
        metadata=payload.get("metadata"),
    )
    identity = dict(format_version=payload.get("format_version"), model=declared_model)
    del payload

    if not torch.cuda.is_available():
        raise RuntimeError("CUDA is not available; this runner never falls back to CPU deployment")
    if args.device < 0 or args.device >= torch.cuda.device_count():
        raise ValueError(f"CUDA device {args.device} does not exist")
    torch.cuda.set_device(args.device)
    properties = torch.cuda.get_device_properties(args.device)
    report["device"] = dict(index=args.device, name=properties.name,
                            sm=properties.major * 10 + properties.minor,
                            total_memory=properties.total_memory)
    report["torch_version"] = torch.__version__
    report["cuda_version"] = torch.version.cuda

    mark(report, "extension-verify-and-load")
    from dlssnr.deployment import extension_path, load_extension
    binary = Path(args.extension or extension_path(args.device)).expanduser().resolve(strict=True)
    binary_sha256 = sha256_file(binary)
    expected_sha256 = (args.expected_extension_sha256.lower()
                       if args.expected_extension_sha256 else None)
    report["extension"] = dict(path=str(binary), sha256=binary_sha256,
                               expected_sha256=expected_sha256,
                               verified=(binary_sha256 == expected_sha256
                                         if expected_sha256 else None),
                               rebuilt=False)
    if expected_sha256 is not None and binary_sha256 != expected_sha256:
        raise ValueError("reconstructed extension SHA-256 differs from the requested binary")
    # The loader caches this exact path; later plan creation cannot silently
    # substitute a different library.  It raises rather than rebuilding.
    load_extension(binary, device=args.device)

    mark(report, "checkpoint-isolate")
    isolated = isolated_checkpoint(args, identity, report)
    mark(report, "checkpoint-load-isolated")
    from dlssnr.checkpoint import load_checkpoint
    checkpoint = load_checkpoint(isolated, model=args.model)
    if getattr(checkpoint, "model", args.model) != args.model:
        raise ValueError(f"loaded checkpoint model {getattr(checkpoint, 'model', None)!r} differs from --model")
    report["checkpoint"]["loaded_precision"] = getattr(checkpoint, "precision", None)

    if args.mode == "native":
        run_native(args, report, torch, checkpoint)
    else:
        if args.archive is not None:
            report["archive_reference"] = dict(path=str(args.archive), used=False,
                                               reason="archive/reference comparison applies to --mode native")
        run_training(args, report, torch, checkpoint)
    del checkpoint
    torch.cuda.empty_cache()


def main(argv=None):
    options = parser()
    args = options.parse_args(argv)
    args.checkpoint = args.checkpoint.expanduser().resolve()
    if not args.checkpoint.is_file():
        options.error(f"--checkpoint is not a file: {args.checkpoint}")
    if args.archive is not None:
        args.archive = args.archive.expanduser().resolve()
        if not (args.archive.is_file() or args.archive.is_dir()):
            options.error(f"--archive is not a file or directory: {args.archive}")
    if args.device < 0:
        options.error("--device must be nonnegative")
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S_%fZ")
    args.output = (args.output or ROOT / "outputs" / "checkpoint-acceptance" / timestamp).expanduser().resolve()
    if args.output.exists():
        options.error("--output already exists; choose a new work directory")
    args.output.mkdir(parents=True)
    report = dict(
        schema_version=1,
        started_utc=datetime.now(timezone.utc).isoformat(),
        accepted=False,
        mode=args.mode,
        model=args.model,
        native_precision=args.native_precision,
        training_precision=args.training_precision,
        learning_rate=args.learning_rate,
        width=args.width,
        height=args.height,
        seed=args.seed,
        scope=("One explicit portable-checkpoint acceptance case; no benchmark sweep, "
               "no performance claim and no vendor DLL modules"),
        limits=dict(one_case_per_invocation=True, vendor_dll_loaded=False,
                    graph_replays_in_native_mode=True,
                    archive_required_for_portable_load=False),
    )
    try:
        execute(args, report)
    except Exception as error:
        report.update(
            accepted=False,
            failed_phase=report.get("phase", "unknown"),
            error=f"{type(error).__name__}: {error}",
            error_type=type(error).__name__,
            traceback=traceback.format_exc(),
        )
        report["completed_utc"] = datetime.now(timezone.utc).isoformat()
        try:
            write_json(args.output / "report.json", report)
        except Exception as save_error:
            print(f"[validate] failed to write failure report: {save_error}", file=sys.stderr, flush=True)
        print(f"[validate] FAILED in phase {report.get('failed_phase')}: {error}", file=sys.stderr, flush=True)
        return 1
    report["accepted"] = True
    report["completed_utc"] = datetime.now(timezone.utc).isoformat()
    write_json(args.output / "report.json", report)
    print(f"[validate] accepted {args.mode} {args.model} at {args.width}x{args.height}; "
          f"report {args.output / 'report.json'}", flush=True)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        print("Portable checkpoint acceptance interrupted.", file=sys.stderr)
        raise SystemExit(130)
