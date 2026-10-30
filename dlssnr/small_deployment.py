"""Native Small31 checkpoint adapter and explicit legacy/Small model selection.

The 310.9.16 ``10/WEIGHTS_CC_SMALL_FP8/1033`` resource is a separately trained
31-role model whose packed records are named by raw DLL block ids ``0..30``.
Those raw ids are *not* legacy operation roles, and the extracted archive's own
manifest already carries the ``raw -> role`` map from
:data:`dlssnr.model_specs.SMALL31`.  This module is the deployment-side adapter
for that verified archive:

* :class:`SmallNativeCheckpoint` exposes a :class:`dlssnr.checkpoint.Checkpoint`
  compatible surface (``state_dict``, ``kernel_record``, ``decode_block``,
  ``create_plan_fp8``, ``create_plan_fp16``) but owns exactly the 31 operation
  roles in ``SMALL31.roles``.  It never fabricates the 71 legacy blocks to
  satisfy ``Checkpoint``'s 640-tensor roster validation, and it does not
  subclass or modify that class.
* FP8 records are returned from the extracted archive's original bytes.  No
  Half bytes are quantised into FP8 and no NVIDIA weight data is embedded here.
* FP16 records reuse :func:`dlssnr.checkpoint.pack_kernel_fp16` unchanged.
  The role-keyed state is stored in the same ``[out, in]`` orientation as
  ``Checkpoint._state`` so that helper's ``_natural`` transpose applies
  unchanged; the native Small roles are a subset of the legacy role layouts
  (pre ``0``, transition ``39``, post ``70``), so the proven packing branches
  are reused rather than copied.
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

from .checkpoint import (
    MATRIX_FIELDS,
    Checkpoint,
    NativeWeightArchive,
    load_checkpoint,
    pack_kernel_fp16,
    promote_tensor,
)
from .deployment import load_extension
from .geometry import block_channels
from .model_specs import SMALL31, ModelSpec, resolve_model
from .small_model import SmallWeightArchive
from .weights import WeightArchive

NATIVE_PRECISIONS = ("fp8", "fp16")

#: Public pre/post record byte extents compiled into ``frontend_dispatch.cpp``
#: (the ``InputContracts`` for the preprocess and postprocess exports).  They
#: are the same native ABI the real-video frontend consumes; the post record
#: contains the full 1024-byte 4x32 head (RGB plus the 32-half history gate).
PREPOST_RECORD_BYTES = {
    ("fp8", 0): 21_696,
    ("fp8", 70): 21_808,
    ("fp16", 0): 33_984,
    ("fp16", 70): 34_096,
}

_LAYER_FOR_C1024_KIND = {"expand": 0, "contract": 1, "qkv": 2, "projection": 4}
_LAYER_FOR_C512_KIND = {"ffn": 0, "ffn_projection": 1, "qkv": 2, "projection": 3, "down": 4}


def _require_precision(precision):
    if precision not in NATIVE_PRECISIONS:
        raise ValueError("deployment record precision must be fp8 or fp16")
    return precision


def _kind_for_layer(role: int, layer: int, spec: ModelSpec = SMALL31) -> str:
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


def _layer_for_kind(role: int, kind: str, spec: ModelSpec = SMALL31) -> int:
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

    def __init__(self, archive: SmallWeightArchive):
        self._archive = archive

    def tensor(self, *args, **kwargs):
        return self._archive.tensor(*args, **kwargs)


def _state_from_archive(archive: SmallWeightArchive) -> dict[str, torch.Tensor]:
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


class SmallNativeCheckpoint:
    """Checkpoint-like native weight owner for one verified Small31 archive.

    The archive is the extracted :data:`~dlssnr.model_specs.SMALL31` resource
    (FP8 storage).  FP16 deployment records are produced losslessly by
    promoting the decoded FP8 values through the existing shared packing
    helper; FP8 deployment records are the original native bytes.

    This object deliberately owns only 31 operation roles.  It is not a padded
    legacy checkpoint and does not call ``Checkpoint``'s 71-block/640-tensor
    validation; instead it validates the complete Small31 archive (77 records,
    pinned stages and sizes) and the exact 31-role state roster itself.
    """

    model = "small31"
    precision = "fp8"

    def __init__(self, archive_or_directory, *, verify_hashes: bool = True):
        if isinstance(archive_or_directory, SmallWeightArchive):
            archive = archive_or_directory
        elif isinstance(archive_or_directory, (str, PathLike)):
            archive = SmallWeightArchive(archive_or_directory, verify_hashes=verify_hashes)
        else:
            raise TypeError("SmallNativeCheckpoint requires a SmallWeightArchive or archive directory")
        spec = getattr(archive, "spec", None)
        if not isinstance(spec, ModelSpec) or spec.id != SMALL31.id:
            raise ValueError("SmallNativeCheckpoint requires the explicit small31 archive identity")
        archive.validate_complete()
        self.archive = archive
        self.spec = spec
        self.manifest_sha256 = getattr(archive, "manifest_sha256", "")
        self.dll_sha256 = getattr(archive, "dll_sha256", "")
        self._state = None

    def _ensure_state(self):
        """Build the role-keyed state once, for the 31 roles only.

        FP8 deployment reads original records and needs no decoded tensors, so
        the state is built lazily on the first FP16/full-state request.  When
        built it contains exactly ``SMALL31.roles`` and is validated by
        :func:`_state_from_archive`; no substitute legacy blocks are created.
        """
        if self._state is None:
            self._state = _state_from_archive(self.archive)
        return self._state

    # -- Checkpoint-compatible surface -------------------------------------

    def state_dict(self, *, dtype=torch.float32):
        """Return independent tensors in the legacy checkpoint orientation."""
        return {name: promote_tensor(value, dtype).clone() for name, value in self._ensure_state().items()}

    def decode_block(self, role: int):
        """Return the unmodified trusted decode for one operation role.

        The post role keeps the legacy 4x32 head (three RGB channels plus the
        32-half history gate); nothing is truncated to three channels.
        """
        if isinstance(role, bool) or not isinstance(role, int) or not self.spec.has_role(role):
            raise ValueError(f"role {role!r} is not present in Small31")
        return self.archive.decode_block(role)

    def blend_scale(self) -> torch.Tensor:
        """Read the native post blend scalar from raw record ``block30``.

        The scalar lives in ``block30.layer0.blend_scale`` (raw 30 is the post
        role 70).  It is returned as the original Float32 value promoted from
        the stored Half scalar; the legacy blend value is never substituted.
        """
        record = self.archive.tensor(self.spec.post_role, parameter="blend_scale")
        value = WeightArchive.vector(record, 0, 1)
        if value.numel() != 1 or not torch.isfinite(value).all().item():
            raise ValueError("Small31 post blend scalar is invalid")
        return value

    # -- Deployment records ------------------------------------------------

    def kernel_record(self, role: int, *, kind="window", precision=None, device="cpu"):
        """Supply one native record to the existing low-level family APIs.

        ``role`` is an operation role (never a raw block id).  ``kind`` follows
        the established ordinary-kernel family vocabulary (``window``,
        ``ffn``, ``qkv``, ``projection``, ``upsample``, ``preprocess``,
        ``postprocess``).  No kernel is selected here.
        """
        if isinstance(role, bool) or not isinstance(role, int) or not self.spec.has_role(role):
            raise ValueError(f"role {role!r} is not present in Small31")
        target = self.precision if precision is None else _require_precision(precision)
        if target == "fp16":
            raw = pack_kernel_fp16(self._ensure_state(), role, kind)
        else:
            layer = _layer_for_kind(role, kind)
            name = f"block{self.spec.raw_for_role(role)}.layer{layer}.layer"
            try:
                record = self.archive.records[name]
            except KeyError as exc:
                raise ValueError(f"Small31 archive has no record {name}") from exc
            expected = self.spec.record_spec(name).byte_length
            if len(record.data) != expected:
                raise ValueError(f"Small31 record size differs from the model identity: {name}")
            raw = bytes(record.data)
        if role in (self.spec.pre_role, self.spec.post_role):
            expected = PREPOST_RECORD_BYTES[(target, role)]
            if len(raw) != expected:
                raise ValueError(
                    f"Small31 role {role} {target} record is {len(raw)} bytes; "
                    f"the compiled frontend ABI requires {expected}")
        return torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy()).to(device)

    def _compiled_roster(self, ops, precision: str):
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
        expected = [record.name for record in _trunk_record_specs(self.spec)]
        if names != expected:
            raise ValueError(
                f"compiled Small31 {precision} roster differs from the pinned 66-record "
                f"native trunk order")
        return expected, sizes

    def _plan_records_fp8(self, names, sizes, *, device):
        records = []
        for name, size in zip(names, sizes):
            try:
                record = self.archive.records[name]
            except KeyError as exc:
                raise ValueError(f"compiled Small31 FP8 roster names an unknown record: {name}") from exc
            length = len(record.data)
            if length != size:
                raise ValueError(
                    f"Small31 FP8 record size differs: {name} is {length}, compiled {size}")
            if length != self.spec.record_spec(name).byte_length:
                raise ValueError(f"Small31 FP8 record size differs from the model identity: {name}")
            records.append(torch.from_numpy(np.frombuffer(record.data, dtype=np.uint8).copy()).to(device))
        return records

    def _plan_records_fp16(self, names, sizes, *, device):
        state = self._ensure_state()
        records = []
        for name, size in zip(names, sizes):
            record_spec = self.spec.record_spec(name)
            kind = _kind_for_layer(record_spec.role, record_spec.layer, self.spec)
            raw = pack_kernel_fp16(state, record_spec.role, kind)
            if len(raw) != size:
                raise ValueError(
                    f"Small31 FP16 record size differs: {name} packs to {len(raw)}, compiled {size}")
            records.append(torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy()).to(device))
        return records

    def create_plan_fp8(self, state, *, width=3840, height=2160):
        """Prepare the separate Small31 FP8 plan from original native records."""
        ops = load_extension(device=state.device)
        names, sizes = self._compiled_roster(ops, "fp8")
        records = self._plan_records_fp8(names, sizes, device=state.device)
        return ops.create_small_plan_for_resolution_fp8(state, records, width, height)

    def create_plan_fp16(self, state, *, width=3840, height=2160):
        """Prepare the separate Small31 Half plan from losslessly widened records."""
        ops = load_extension(device=state.device)
        names, sizes = self._compiled_roster(ops, "fp16")
        records = self._plan_records_fp16(names, sizes, device=state.device)
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
