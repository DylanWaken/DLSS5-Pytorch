"""Private one-frame RGB smoke; default CPU mode never constructs a CUDA pipeline."""
import argparse
import gc
import hashlib
import json
from pathlib import Path
import sys
import traceback

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
BASE = ROOT / "profile/checkpoint-model-selection-20261030"
CASES = {
    "legacy71": ("01-training-legacy71-fp32", "9f9a8f1b5446b4d9a2f261aa29301b137e268d029628c720fa5f77c126174ccf"),
    "small31": ("03-training-small31-fp32", "a7a395c769003b2bb46a61e5de00c69a114ad9061de606a27c5f436a0187225c"),
}
EXTENSION_SHA = "f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938"


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def sha(path):
    result = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            result.update(chunk)
    return result.hexdigest()


def tensor_bytes(value):
    return value.detach().cpu().contiguous().view(__import__("torch").uint8).numpy().tobytes()


def equal(left, right):
    return left.dtype == right.dtype and left.shape == right.shape and tensor_bytes(left) == tensor_bytes(right)


def cpu_checks(model, report):
    import torch
    from dlssnr import load_checkpoint
    from dlssnr.checkpoint import _SchemaArchive, native_state_dict, pack_kernel_fp16
    from dlssnr.portable_checkpoint import canonical_small_identity, small31_state_schema

    case_name, accepted_export_sha = CASES[model]
    case_path = BASE / "acceptance/gpu-lr1e-5" / case_name / "report.json"
    case = json.loads(case_path.read_text(encoding="utf-8-sig"))
    require(case["accepted"] and case["model"] == model, "wrong/unaccepted case")
    require(case["training_precision"] == "fp32" and case["native_precision"] == "fp16", "wrong precision")
    require(case["training"]["learning_rate"] == 1e-5, "wrong accepted learning rate")
    training = case["training"]
    exported = Path(training["exported_checkpoint"])
    master_path = Path(training["master_state_path"])
    original_path = Path(case["checkpoint"]["source"])
    require(sha(exported) == training["exported_sha256"] == accepted_export_sha, "trained checkpoint hash mismatch")
    require(sha(master_path) == training["master_state_sha256"], "master hash mismatch")
    require(sha(original_path) == case["checkpoint"]["sha256"], "original checkpoint hash mismatch")
    report["provenance"] = {"accepted_case": str(case_path), "accepted_case_sha256": sha(case_path),
                            "trained_checkpoint": str(exported), "trained_sha256": accepted_export_sha,
                            "master_sha256": training["master_state_sha256"],
                            "original_sha256": case["checkpoint"]["sha256"], "learning_rate": 1e-5}
    weights = load_checkpoint(exported, model=model)
    original = load_checkpoint(original_path, model=model)
    payload = torch.load(exported, weights_only=True, map_location="cpu")
    master = torch.load(master_path, weights_only=True, map_location="cpu")
    require(payload["weight_precision"] == "fp16" and not payload["native_records"], "stale native records")
    if model == "small31":
        identity = master.get("_extra_state")
        require(isinstance(identity, dict), "missing Small identity")
        for key, value in canonical_small_identity().items():
            require(identity.get(key) == value, "Small identity mismatch: " + key)
        schema = small31_state_schema()
        prefix = "blocks.by_role."
    else:
        schema = native_state_dict(_SchemaArchive())
        prefix = "blocks."
    expected = {}
    changed_fields = []
    original_state = original.state_dict(dtype=torch.float32)
    for key, spec in schema.items():
        if not key.startswith(("blocks.0.", "blocks.70.")):
            continue
        master_key = prefix + key[len("blocks."):]
        value = master[master_key]
        require(value.dtype == torch.float32 and value.shape == spec.shape, "master shape/dtype: " + key)
        dtype = torch.float32 if spec.dtype == torch.float32 else torch.float16
        converted = value.to(dtype=dtype).contiguous()
        require(bool(torch.isfinite(converted).all()), "nonfinite quantized pre/post: " + key)
        require(equal(converted, payload["state_dict"][key]), "export pre/post differs from quantized master: " + key)
        expected[key] = converted
        if not equal(converted, original_state[key].to(dtype=dtype)):
            changed_fields.append(key)
    records = {}
    record_receipts = {}
    for role, kind in ((0, "preprocess"), (70, "postprocess")):
        actual = weights.kernel_record(role, kind=kind, precision="fp16", device="cpu")
        expected_bytes = pack_kernel_fp16(expected, role, kind)
        require(tensor_bytes(actual) == expected_bytes, "loaded pre/post packing differs from quantized master")
        old = original.kernel_record(role, kind=kind, precision="fp16", device="cpu")
        changed = not equal(actual, old)
        consumed_changes = [key for key in changed_fields if key.startswith(f"blocks.{role}.") and not key.endswith(".blend_scale")]
        require(consumed_changes and changed, "accepted learned pre/post record did not change")
        records[kind] = actual
        record_receipts[kind] = {"role": role, "bytes": actual.numel(), "sha256": hashlib.sha256(expected_bytes).hexdigest(),
                                 "matches_quantized_master": True, "differs_from_original": changed,
                                 "changed_fields": consumed_changes}
    blend_key = "blocks.70.blend_scale"
    blend = expected[blend_key].float().reshape(-1)
    loaded_blend = weights.blend_scale() if model == "small31" else payload["state_dict"][blend_key].float().reshape(-1)
    require(equal(blend, loaded_blend), "loaded blend differs from quantized master")
    report["cpu"] = {"prepost_tensors_checked": len(expected), "records": record_receipts,
                     "blend": {"value": blend.tolist(), "matches_quantized_master": True,
                               "differs_from_original": blend_key in changed_fields,
                               "executed": False, "reason": "stateless FramePipeline passes empty_blend"},
                     "no_stale_native_records": True, "passed": True}
    del original, original_state, payload, master, expected
    gc.collect()
    return weights, records


def gpu_smoke(model, weights, records, output_dir, report):
    # Only this explicit --mode gpu branch may construct CUDA objects.
    import numpy as np
    import torch
    from dlssnr.video import FramePipeline, validate_rgba_output, save_rgb_png

    extension = ROOT / "dlssnr/_C_sm120.cp311-win_amd64.pyd"
    require(sha(extension) == EXTENSION_SHA, "frozen native extension hash mismatch")
    from dlssnr.deployment import load_extension
    load_extension(extension, device=0)
    y, x = np.indices((320, 320), dtype=np.uint32)
    fixture = np.stack(((x * 255 // 319), (y * 255 // 319),
                        ((x // 20 + y // 20) % 2) * 255), axis=-1).astype(np.uint8)
    report["fixture"] = {"shape": list(fixture.shape), "dtype": "uint8", "range": [0, 255],
                         "sha256": hashlib.sha256(fixture.tobytes()).hexdigest(), "seed": 320}
    report["phase"] = "construct-full-pipeline"
    pipeline = FramePipeline(model=model, precision="fp16", weights=weights,
                             valid_width=320, valid_height=320, seed=320, device=0)
    require(equal(pipeline.pre_record.cpu(), records["preprocess"]), "GPU preprocess record mismatch")
    require(equal(pipeline.post_record.cpu(), records["postprocess"]), "GPU postprocess record mismatch")
    require(pipeline.empty_blend.numel() == 0, "stateless blend contract changed")
    report["phase"] = "full-rgb-run"
    pipeline.run(fixture, validate=True)
    # run(validate=True) already checks packed-low before launching the display post.
    low = pipeline.validate_low()
    rgba = pipeline.valid_rgba().detach().cpu().numpy()
    output = validate_rgba_output(rgba)
    require(bool(pipeline.plan.guards_intact()), "trunk plan guard corruption")
    description = pipeline.describe()
    description.pop("prepare_seconds", None)
    save_rgb_png(fixture, output_dir / "fixture.png")
    from dlssnr.video import rgb_to_uint8
    save_rgb_png(rgb_to_uint8(rgba[..., :3]), output_dir / "output.png")
    report["gpu"] = {"pipeline": description, "extension_path": str(extension), "extension_sha256": EXTENSION_SHA,
                     "prepost_gpu_records_match": True, "full_pipeline_runs": 1,
                     "packed_low": low, "rgba": output, "plan_guards_intact": True,
                     "guard_scope": "native trunk plan only; no separate frontend output guards exposed",
                     "coverage": "learned preprocess + RGB trunk + postprocess; temporal blend excluded",
                     "parity_claim": "none; no vendor or training-surrogate comparison", "passed": True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", choices=tuple(CASES), required=True)
    parser.add_argument("--mode", choices=("cpu", "gpu"), default="cpu")
    parser.add_argument("--output-dir", type=Path, required=True)
    args = parser.parse_args()
    args.output_dir.mkdir(parents=True, exist_ok=False)
    report = {"schema_version": 1, "model": args.model, "mode": args.mode, "accepted": False,
              "width": 320, "height": 320, "native_precision": "fp16", "phase": "cpu-provenance",
              "helper_sha256": sha(__file__), "benchmark": False}
    status = 1
    try:
        weights, records = cpu_checks(args.model, report)
        if args.mode == "gpu":
            gpu_smoke(args.model, weights, records, args.output_dir, report)
        report.update(accepted=True, phase="complete")
        status = 0
    except Exception as error:
        report.update(error=f"{type(error).__name__}: {error}", traceback=traceback.format_exc())
    finally:
        (args.output_dir / "report.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        print(json.dumps({"model": args.model, "mode": args.mode, "accepted": report["accepted"],
                          "phase": report["phase"], "report": str(args.output_dir / "report.json")}, indent=2))
    return status


if __name__ == "__main__":
    raise SystemExit(main())
