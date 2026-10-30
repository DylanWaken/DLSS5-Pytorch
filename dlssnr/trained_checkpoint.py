"""Explicit export of trained FP32/BF16 models to deployment FP16 checkpoints.

This is deliberately not the lossless original-weight widening path.  Learned
values are narrowed to the native FP16 schema, Float32 fields are retained, and
no original packed FP8 records are carried over.  Learned FP8 export has no
inverse writer and is rejected rather than reusing stale source records.
"""
from __future__ import annotations

import torch

_HALF_MAX = 65504.0
_FLOAT32_MAX = torch.finfo(torch.float32).max


def _model_and_state(training_model, model):
    """Resolve the explicit model and prove the live object is that family."""
    from .model_specs import resolve_model

    spec = resolve_model(model)
    if spec.id == "legacy71":
        from .model import DLSSNR
        from .small_model import SmallDLSSNR

        if isinstance(training_model, SmallDLSSNR) or not isinstance(training_model, DLSSNR):
            raise ValueError("legacy71 export requires an actual dlssnr.DLSSNR training model")
    elif spec.id == "small31":
        from .small_model import SmallDLSSNR

        if not isinstance(training_model, SmallDLSSNR):
            raise ValueError("small31 export requires an actual dlssnr.SmallDLSSNR training model")
    else:  # resolve_model already restricts this, kept explicit for safety.
        raise ValueError(f"unsupported export model {spec.id!r}")
    return spec.id, training_model.state_dict()


def _target_dtype(name, expected):
    """Map the native checkpoint schema dtype to the deployment FP16 dtype."""
    if not isinstance(expected, torch.Tensor):
        raise TypeError(f"schema entry {name!r} is not a tensor")
    if expected.dtype in (torch.float8_e4m3fn, torch.float16):
        return torch.float16
    if expected.dtype == torch.float32:
        return torch.float32
    raise ValueError(f"unsupported native schema dtype for {name!r}: {expected.dtype}")


def _quantize_state(state, schema, model_id):
    """Validate and explicitly narrow one model state to the native schema."""
    missing = set(schema) - set(state)
    extra = set(state) - set(schema)
    if missing or extra:
        raise ValueError(
            f"{model_id} trained state roster differs from the checkpoint schema: "
            f"missing={sorted(missing)}, unexpected={sorted(extra)}")
    quantized = {}
    for name, expected in schema.items():
        value = state[name]
        if not isinstance(value, torch.Tensor):
            raise TypeError(f"trained state entry {name!r} is not a tensor")
        if value.shape != expected.shape:
            raise ValueError(
                f"trained state shape differs for {name!r}: {tuple(value.shape)} != {tuple(expected.shape)}")
        if not value.is_floating_point():
            raise TypeError(f"trained state entry {name!r} is not floating point: {value.dtype}")
        if not bool(torch.isfinite(value.detach()).all().item()):
            raise ValueError(f"trained state entry {name!r} is nonfinite")
        target_dtype = _target_dtype(name, expected)
        # Detach and copy before conversion so no source parameter, gradient or
        # shared storage is observed or mutated by export.
        source = value.detach().to(device="cpu").contiguous().clone()
        limit = _HALF_MAX if target_dtype == torch.float16 else _FLOAT32_MAX
        if source.numel() and bool((source.abs() > limit).any().item()):
            raise ValueError(
                f"trained state entry {name!r} exceeds the finite {target_dtype} range")
        converted = source.to(dtype=target_dtype).contiguous()
        if not bool(torch.isfinite(converted).all().item()):
            raise ValueError(f"trained state entry {name!r} became nonfinite after FP16 conversion")
        quantized[name] = converted.clone()
    return quantized


def _metadata(model_id, training_model):
    """Record trained lineage and the deliberate lossy FP16 quantization."""
    return {
        "provenance": "trained",
        "source": {
            "kind": "trained_model",
            "model": model_id,
            "model_class": ("dlssnr.SmallDLSSNR" if model_id == "small31" else "dlssnr.DLSSNR"),
            "training_precision": str(getattr(training_model, "precision", "unknown")),
        },
        "lineage": {
            "weight_origin": "trained",
            "original_resource_bytes": False,
        },
        "quantization": {
            "scheme": "explicit-fp16",
            "lossless_original_export": False,
            "policy": ("native FP8 and Half fields narrowed to float16; "
                       "native Float32 fields retained"),
        },
        "native_records": "omitted",
    }


def export_trained_checkpoint(training_model, path, *, model="legacy71", precision="fp16"):
    """Export one trained model to a state-only native FP16 portable checkpoint.

    ``model`` is explicit, never inferred.  Only FP16 is supported: learned FP8
    has no inverse writer and must not re-label original records as trained.
    The returned value is the ``save_checkpoint_payload`` receipt dictionary.
    """
    if precision == "fp8":
        raise ValueError(
            "learned FP8 export is unsupported: no inverse learned-FP8 writer exists "
            "and original packed records cannot represent trained values")
    if precision != "fp16":
        raise ValueError(f"trained export supports only precision 'fp16', got {precision!r}")

    model_id, full_state = _model_and_state(training_model, model)
    if model_id == "small31":
        from .portable_checkpoint import (
            SmallCheckpoint,
            canonical_small_identity,
            save_checkpoint_payload,
            small31_state_schema,
        )

        # Identity is checked before any block key is mapped or copied.
        identity = full_state.get("_extra_state")
        if not isinstance(identity, dict):
            raise ValueError("small31 trained state is missing its _extra_state model identity")
        canonical = canonical_small_identity()
        if not isinstance(canonical, dict):
            raise TypeError("canonical_small_identity() must return a dict")
        for key, expected in canonical.items():
            if key not in identity:
                raise ValueError(f"small31 state identity is missing {key!r}")
            if identity[key] != expected:
                raise ValueError(
                    f"small31 state identity mismatch for {key!r}: {identity[key]!r} != {expected!r}")

        prefix = "blocks.by_role."
        mapped = {}
        for key, value in full_state.items():
            if key == "_extra_state":
                continue
            if not key.startswith(prefix):
                raise ValueError(f"unexpected small31 trained state key {key!r}")
            mapped["blocks." + key[len(prefix):]] = value
        state = _quantize_state(mapped, small31_state_schema(), "small31")
        payload = {
            "format_version": 3,
            "model": "small31",
            "model_class": "dlssnr.SmallDLSSNR",
            "weight_precision": "fp16",
            "storage": "state_dict",
            "state_dict": state,
            "native_records": {},
            "model_identity": canonical,
            "metadata": _metadata("small31", training_model),
        }
        SmallCheckpoint(payload)
        return save_checkpoint_payload(payload, path, overwrite=False)

    from .checkpoint import Checkpoint, _SchemaArchive, native_state_dict

    schema = native_state_dict(_SchemaArchive())
    state = _quantize_state(full_state, schema, "legacy71")
    payload = {
        "format_version": 2,
        "model": "legacy71",
        "model_class": "dlssnr.DLSSNR",
        "weight_precision": "fp16",
        "state_dict": state,
        "native_records": {},
        "metadata": _metadata("legacy71", training_model),
    }
    Checkpoint(payload)
    from .portable_checkpoint import save_checkpoint_payload

    return save_checkpoint_payload(payload, path, overwrite=False)
