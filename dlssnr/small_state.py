"""CPU-owned Small31 state, identity and role/kind metadata.

This module is deliberately below both serialization and native deployment.  It
owns the archive-to-role-state conversion, the expected state schema and the
canonical compatibility identity construction.  The shared native layer/kind
tables are imported from :mod:`dlssnr.common.weight_schema`.  It must not import
:mod:`dlssnr.small_deployment` or the native extension: archive type names are
imported only for type checking.
"""
from __future__ import annotations

from typing import TYPE_CHECKING

import torch

from .checkpoint import NativeWeightArchive, _SchemaArchive, native_state_dict
from .common.weight_schema import (
    LAYER_FOR_C1024_KIND,
    LAYER_FOR_C512_KIND,
    MATRIX_FIELDS,
)
from .geometry import block_channels
from .model_specs import SMALL31, ModelSpec
from .weights import WeightArchive

if TYPE_CHECKING:  # Avoid a runtime cycle: small_model imports this module.
    from .small_model import SmallWeightArchive

STATE_SCHEMA = "dlssnr-small31/1"
POST_HEAD_LAYOUT = "rgb+history_gate"

_LAYER_FOR_C1024_KIND = LAYER_FOR_C1024_KIND
_LAYER_FOR_C512_KIND = LAYER_FOR_C512_KIND


def small_identity(spec: ModelSpec = SMALL31, *, source_dll_sha256: str,
                   post_phase: int, block_count: int | None = None) -> dict:
    """Build the canonical Small31 compatibility identity dictionary.

    ``source_dll_sha256`` and ``post_phase`` are explicit because serialization
    uses the signed canonical pin/default phase while training preserves its
    actual source pin and deliberate non-default post phase.  Local manifest
    provenance is deliberately excluded.
    """
    post_head = spec.post_head
    if post_head is None:
        raise ValueError("canonical Small31 identity requires the native post head")
    return {
        "stateSchema": STATE_SCHEMA,
        "model": spec.id,
        "sourceDllSha256": source_dll_sha256,
        "resourcePath": spec.resource.path,
        "resourceSha256": spec.resource.sha256,
        "resourceByteLength": spec.resource.byte_length,
        "roles": list(spec.roles),
        "rawToRole": list(spec.raw_to_role),
        "blockCount": spec.block_count if block_count is None else block_count,
        "postPhase": post_phase,
        "postHead": "{}x{}".format(*post_head.native_shape),
        "postHeadLayout": POST_HEAD_LAYOUT,
    }


def record_kind_for_layer(role: int, layer: int, spec: ModelSpec = SMALL31) -> str:
    """Map an operation role + native layer slot to the shared packing kind.

    Raw DLL record ids never participate in this decision; only the operation
    role (which selects the channel width) and the record's layer slot do.
    """
    if role == spec.pre_role:
        if layer != 0:
            raise ValueError("Small31 pre role has only layer 0")
        return "preprocess"
    if role == spec.post_role:
        if layer != 0:
            raise ValueError("Small31 post role has only layer 0")
        return "postprocess"
    if role == spec.transition_role:
        if layer != 0:
            raise ValueError("Small31 transition role has only layer 0")
        return "upsample"
    c = block_channels(role)
    if c == 1024:
        table = _LAYER_FOR_C1024_KIND
    elif c == 512:
        table = _LAYER_FOR_C512_KIND
    elif c in (32, 64, 128, 256):
        table = {"window": 0}
    else:  # pragma: no cover - SMALL31.roles is a legacy-layout subset
        raise ValueError(f"unsupported Small31 role {role} with {c} channels")
    for kind, slot in table.items():
        if slot == layer:
            return kind
    raise ValueError(f"Small31 role {role} has no packing kind for native layer {layer}")


def layer_for_kind(role: int, kind: str, spec: ModelSpec = SMALL31) -> int:
    """Expose the same role/kind family selection as ``Checkpoint.kernel_record``."""
    if role == spec.pre_role:
        if kind not in ("window", "preprocess"):
            raise NotImplementedError("Use the preprocess record for the Small31 pre role")
        return 0
    if role == spec.post_role:
        if kind not in ("window", "postprocess"):
            raise NotImplementedError("Use the postprocess record for the Small31 post role")
        return 0
    if role == spec.transition_role:
        if kind != "upsample":
            raise NotImplementedError("Use the upsample record for the Small31 transition role")
        return 0
    c = block_channels(role)
    if c == 1024:
        table = _LAYER_FOR_C1024_KIND
    elif c == 512:
        table = _LAYER_FOR_C512_KIND
    elif c in (32, 64, 128, 256):
        table = {"window": 0}
    else:  # pragma: no cover - SMALL31.roles is a legacy-layout subset
        raise NotImplementedError(f"Unsupported FP8 record role: role={role}")
    try:
        return table[kind]
    except KeyError as exc:
        raise NotImplementedError(
            f"Unsupported FP8 record role: role={role}, kind={kind}") from exc


# Compatibility aliases retained while production consumers use the public names.
kind_for_layer = record_kind_for_layer
_kind_for_layer = record_kind_for_layer
_layer_for_kind = layer_for_kind


class _NativeSmallView:
    """Route ``WeightArchive.decode_block`` through the native bit decoders.

    ``SmallWeightArchive.decode_block`` deliberately uses the float32 legacy
    decoder for training/audit.  For deployment packing we must preserve the
    original FP8 matrix codes and Half ancillary storage: converting the
    archive's Half bytes into FP8 (or the float32 decode back into Half) would
    be lossy/ambiguous.  The proven native decoders are reused unchanged.
    """

    fp8_matrix = staticmethod(NativeWeightArchive.fp8_matrix)
    f16_matrix = staticmethod(NativeWeightArchive.f16_matrix)
    vector = staticmethod(NativeWeightArchive.vector)
    relative_bias = staticmethod(NativeWeightArchive.relative_bias)

    def __init__(self, archive: "SmallWeightArchive"):
        self._archive = archive

    def tensor(self, *args, **kwargs):
        return self._archive.tensor(*args, **kwargs)


def state_from_archive(archive: "SmallWeightArchive") -> dict[str, torch.Tensor]:
    """Build the 31-role state in ``Checkpoint``'s ``[out, in]`` matrix layout.

    Matrices keep their original native storage (E4M3 for Small), while Half
    ancillary tensors and Float head scales stay in their stored precision, so
    ``promote_tensor`` can losslessly widen them for ``pack_kernel_fp16``.
    ``NativeWeightArchive`` decoders are reused; no tensor is re-quantised.
    ``WeightArchive.decode_block`` returns natural ``[in, out]`` matrices, so
    the legacy checkpoint's transpose is applied to match ``Checkpoint._state``
    and its proven ``_natural`` packing path.  Keys use operation roles only:
    raw DLL ids are a different namespace and are never state keys.
    """
    spec = archive.spec
    view = _NativeSmallView(archive)
    state: dict[str, torch.Tensor] = {}
    for role in spec.roles:
        decoded = WeightArchive.decode_block(view, role)
        if not decoded:
            raise ValueError(f"Small31 role {role} decoded no learned tensors")
        for name, value in decoded.items():
            if not isinstance(value, torch.Tensor):
                raise ValueError(f"Small31 role {role} tensor {name} is not a torch.Tensor")
            if name in MATRIX_FIELDS:
                value = value.transpose(-1, -2)
            value = value.contiguous()
            if not torch.isfinite(value.float()).all().item():
                raise ValueError(f"Nonfinite Small31 checkpoint tensor: blocks.{role}.{name}")
            state[f"blocks.{role}.{name}"] = value
    roles = {int(name.split(".", 2)[1]) for name in state}
    if roles != set(spec.roles) or len(roles) != len(spec.roles):
        raise ValueError("Small31 state roster differs from the 31 declared operation roles")
    return state


# Compatibility alias for the former private deployment helper.
_state_from_archive = state_from_archive


def small31_state_schema() -> dict[str, torch.Tensor]:
    """Return ``blocks.<role>.<field>`` meta tensors with native mixed dtypes.

    The schema is derived from the existing native decoder by filtering
    :func:`dlssnr.checkpoint.native_state_dict` over the Small31 role roster;
    shapes and dtypes are never maintained in a second hand-written table.
    """
    roles = frozenset(SMALL31.roles)
    schema: dict[str, torch.Tensor] = {}
    for name, value in native_state_dict(_SchemaArchive()).items():
        if int(name.split(".", 2)[1]) in roles:
            schema[name] = value
    if not schema:
        raise ValueError("native Small31 schema derivation returned no tensors")
    decoded_roles = {int(name.split(".", 2)[1]) for name in schema}
    if decoded_roles != roles:
        raise ValueError("native Small31 schema roles differ from the canonical roster")
    return schema


__all__ = [
    "STATE_SCHEMA",
    "kind_for_layer",
    "layer_for_kind",
    "record_kind_for_layer",
    "small31_state_schema",
    "small_identity",
    "state_from_archive",
]
