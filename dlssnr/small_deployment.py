"""Native Small31 plan adapter and explicit legacy/Small model selection.

The 310.9.16 ``10/WEIGHTS_CC_SMALL_FP8/1033`` resource is a separately trained
31-role model whose packed records are named by raw DLL block ids ``0..30``.
Those raw ids are *not* legacy operation roles, and the extracted archive's own
manifest already carries the ``raw -> role`` map from
:data:`dlssnr.model_specs.SMALL31`.

Ownership is deliberately layered:

* :mod:`dlssnr.small_state` owns CPU archive-to-role-state conversion, the
  expected state schema, canonical Small identity construction and the shared
  role/layer packing kinds.
* :mod:`dlssnr.small_weights` owns the single CPU weight/record class
  :class:`SmallNativeCheckpoint`; its public plan methods delegate here lazily.
* this module owns compiled roster validation, record upload/native plan
  selection and :func:`load_native_model` selection.  It may import the CPU
  state/weight owners, while serialization imports this module only lazily.

* FP8 records are returned from the extracted archive's original bytes.  No
  Half bytes are quantised into FP8 and no NVIDIA weight data is embedded here.
* FP16 records reuse :func:`dlssnr.weight_packing.pack_kernel_fp16` unchanged.
* ``create_plan_fp8`` / ``create_plan_fp16`` iterate the *compiled* Small31
  rosters (``record_names_small31_*`` / ``record_bytes_small31_*``) in order and
  reject any name, order, duplicate or byte count that differs from the pinned
  :data:`SMALL31` roster before calling the separate Small host plan.
* With ``model='small31'``, :func:`load_native_model` also accepts a
  self-contained format-3 ``.pt`` checkpoint through
  :mod:`dlssnr.portable_checkpoint`; the extracted archive directory path stays
  supported and the legacy default is unchanged.

The legacy 71-block path is unchanged: :func:`load_native_model` defaults to
``model='legacy71'`` and delegates to the existing
:func:`dlssnr.checkpoint.load_checkpoint` (there is no ``Checkpoint.load``
classmethod in this repository).  Model choice is always explicit; it is never
guessed from a file name, tensor shape or archive size.
"""
from __future__ import annotations

from os import PathLike
from pathlib import Path

import numpy as np
import torch

from .checkpoint import Checkpoint, load_checkpoint
# NATIVE_PRECISIONS remains a compatibility re-export of the canonical owner.
from .common.precision import NATIVE_PRECISIONS, resolve_precision
from .deployment import load_extension
from .model_specs import SMALL31, ModelSpec, resolve_model
from .small_model import SmallWeightArchive
# Canonical CPU state/kind owners; the underscore names below remain
# compatibility aliases for existing tools and tests.
from .small_state import kind_for_layer, layer_for_kind, state_from_archive
from .small_weights import (
    PREPOST_RECORD_BYTES,
    SmallNativeCheckpoint,
)
from .weight_packing import pack_kernel_fp16

_state_from_archive = state_from_archive
_kind_for_layer = kind_for_layer
_layer_for_kind = layer_for_kind


def _trunk_record_specs(spec: ModelSpec = SMALL31):
    """The native 66-record trunk roster, in compiled raw-block order.

    The trunk excludes the pre/post roles (including the post ``blend_scale``
    scalar) and the eight unused ViT native layer-3 slots, exactly like the
    generated Small31 tables.  These are raw record names, not operation roles.
    """
    vit_roles = {role for stage in spec.stages if stage.kind == "vit" for role in stage.roles}
    return tuple(
        record for record in spec.records
        if record.role not in (spec.pre_role, spec.post_role)
        and not (record.role in vit_roles and record.layer == 3)
    )


def _compiled_roster(owner: SmallNativeCheckpoint, ops, precision: str):
    """Read and fully validate one compiled Small31 native roster."""
    name_fn = getattr(ops, f"record_names_small31_{precision}", None)
    byte_fn = getattr(ops, f"record_bytes_small31_{precision}", None)
    if name_fn is None or byte_fn is None:
        raise RuntimeError(
            f"the loaded extension does not expose the Small31 {precision} record roster")
    names, sizes = list(name_fn()), list(byte_fn())
    if len(names) != len(sizes):
        raise ValueError(f"compiled Small31 {precision} name/size rosters differ in length")
    if not names:
        raise ValueError(f"compiled Small31 {precision} record roster is empty")
    if len(set(names)) != len(names):
        raise ValueError(f"compiled Small31 {precision} record roster contains duplicates")
    for name, size in zip(names, sizes):
        if not isinstance(name, str) or not name:
            raise ValueError(f"compiled Small31 {precision} record name is invalid")
        if isinstance(size, bool) or not isinstance(size, int) or size < 1:
            raise ValueError(f"compiled Small31 {precision} record size is invalid: {name}")
    expected = [record.name for record in _trunk_record_specs(owner.spec)]
    if names != expected:
        raise ValueError(
            f"compiled Small31 {precision} roster differs from the pinned 66-record "
            f"native trunk order")
    return expected, sizes


def _plan_records_fp8(owner: SmallNativeCheckpoint, names, sizes, *, device):
    records = []
    for name, size in zip(names, sizes):
        try:
            record = owner.archive.records[name]
        except KeyError as exc:
            raise ValueError(f"compiled Small31 FP8 roster names an unknown record: {name}") from exc
        length = len(record.data)
        if length != size:
            raise ValueError(
                f"Small31 FP8 record size differs: {name} is {length}, compiled {size}")
        if length != owner.spec.record_spec(name).byte_length:
            raise ValueError(f"Small31 FP8 record size differs from the model identity: {name}")
        records.append(torch.from_numpy(np.frombuffer(record.data, dtype=np.uint8).copy()).to(device))
    return records


def _plan_records_fp16(owner: SmallNativeCheckpoint, names, sizes, *, device):
    state = owner._ensure_state()
    records = []
    for name, size in zip(names, sizes):
        record_spec = owner.spec.record_spec(name)
        kind = kind_for_layer(record_spec.role, record_spec.layer, owner.spec)
        raw = pack_kernel_fp16(state, record_spec.role, kind)
        if len(raw) != size:
            raise ValueError(
                f"Small31 FP16 record size differs: {name} packs to {len(raw)}, compiled {size}")
        records.append(torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy()).to(device))
    return records


def _create_small_plan(owner: SmallNativeCheckpoint, state, *, precision,
                       width: int = 3840, height: int = 2160):
    """Validate the compiled roster, upload records and select the Small plan.

    This is the single native-plan implementation used by the CPU weight
    owner's public convenience methods.  Call ordering is unchanged:
    extension load, roster validation, record upload, native plan creation.
    """
    precision = resolve_precision(
        precision, error_message="deployment record precision must be fp8 or fp16")
    ops = load_extension(device=state.device)
    names, sizes = _compiled_roster(owner, ops, precision)
    if precision == "fp8":
        records = _plan_records_fp8(owner, names, sizes, device=state.device)
        return ops.create_small_plan_for_resolution_fp8(state, records, width, height)
    records = _plan_records_fp16(owner, names, sizes, device=state.device)
    return ops.create_small_plan_for_resolution_fp16(state, records, width, height)


def load_native_model(checkpoint_or_archive, model="legacy71", *, verify_hash=True):
    """Explicitly select the legacy71 checkpoint path or the Small31 adapter.

    ``model`` is required to be one of the names in
    :data:`dlssnr.model_specs.MODEL_SPECS`; an unknown name raises
    :class:`ValueError`.  The default stays ``legacy71`` and hands the path to
    the existing :func:`dlssnr.checkpoint.load_checkpoint` (the old public load
    API; ``Checkpoint`` has no ``load`` classmethod).  ``model='small31'``
    accepts either a self-contained format-3 ``.pt`` checkpoint or an extracted
    archive directory; the two are distinguished only by the explicit path
    type, never by file size, tensor shape or name.  Nothing is inferred from a
    file's contents.
    """
    spec = resolve_model(model)
    if spec.id == "legacy71":
        if isinstance(checkpoint_or_archive, Checkpoint):
            return checkpoint_or_archive
        if isinstance(checkpoint_or_archive, SmallNativeCheckpoint):
            raise ValueError("SmallNativeCheckpoint cannot be selected as the legacy71 checkpoint")
        if isinstance(checkpoint_or_archive, SmallWeightArchive):
            raise ValueError("a Small31 archive cannot be selected as the legacy71 checkpoint")
        if not isinstance(checkpoint_or_archive, (str, PathLike)):
            raise TypeError("legacy71 requires a checkpoint path or a loaded Checkpoint")
        path = Path(checkpoint_or_archive)
        if not path.is_file():
            raise ValueError("legacy71 requires an existing .pt checkpoint file")
        return load_checkpoint(path, verify_hash=verify_hash)

    if isinstance(checkpoint_or_archive, Checkpoint):
        raise ValueError("a legacy71 Checkpoint cannot be selected as small31")
    if isinstance(checkpoint_or_archive, SmallNativeCheckpoint):
        if checkpoint_or_archive.spec.id != spec.id:
            raise ValueError("SmallNativeCheckpoint identity differs from the selected model")
        return checkpoint_or_archive
    if isinstance(checkpoint_or_archive, SmallWeightArchive):
        return SmallNativeCheckpoint(checkpoint_or_archive)
    if not isinstance(checkpoint_or_archive, (str, PathLike)):
        raise TypeError("small31 requires an extracted archive directory or a SmallWeightArchive")
    path = Path(checkpoint_or_archive)
    if path.is_file():
        # A self-contained format-3 Small31 checkpoint; the legacy default and
        # the archive-directory branch below remain unchanged.
        return load_checkpoint(path, model="small31", verify_hash=verify_hash)
    if not path.is_dir():
        raise ValueError("small31 requires an existing extracted archive directory")
    return SmallNativeCheckpoint(path, verify_hashes=verify_hash)
