"""CPU-owned Small31 packed-weight checkpoint surface.

:class:`SmallNativeCheckpoint` validates one canonical Small31 archive and owns
the role-keyed CPU state, decoded views and original/packed deployment record
bytes.  Native plan creation and compiled roster validation live in
:mod:`dlssnr.small_deployment`; the public convenience methods reach that owner
lazily, so importing serialization or this module never imports the native
deployment module.  :class:`dlssnr.portable_checkpoint.SmallCheckpoint` reuses
this single weight-owner implementation.
"""
from __future__ import annotations

from os import PathLike

import numpy as np
import torch

from .common.precision import NATIVE_PRECISIONS, resolve_precision
from .model_specs import SMALL31, ModelSpec
from .small_model import SmallWeightArchive
from .small_state import layer_for_kind, state_from_archive
from .weight_packing import pack_kernel_fp16, promote_tensor
from .weights import WeightArchive

#: Public compatibility re-export; the canonical owner is dlssnr.common.precision.

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


def _require_precision(precision):
    return resolve_precision(
        precision, error_message="deployment record precision must be fp8 or fp16")


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

    model = SMALL31.id
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
        :func:`dlssnr.small_state.state_from_archive`; no substitute legacy
        blocks are created.
        """
        if self._state is None:
            self._state = state_from_archive(self.archive)
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
            layer = layer_for_kind(role, kind)
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

    def create_plan_fp8(self, state, *, width=3840, height=2160):
        """Prepare the separate Small31 FP8 plan from original native records.

        Compiled-roster validation, record upload and native plan selection are
        owned by :mod:`dlssnr.small_deployment`; it is imported lazily so
        serialization does not depend on the deployment module at import time.
        """
        from .small_deployment import _create_small_plan

        return _create_small_plan(self, state, precision="fp8", width=width, height=height)

    def create_plan_fp16(self, state, *, width=3840, height=2160):
        """Prepare the separate Small31 Half plan from losslessly widened records."""
        from .small_deployment import _create_small_plan

        return _create_small_plan(self, state, precision="fp16", width=width, height=height)


#: Descriptive alias for the single CPU weight owner; the historical public
#: class name remains the canonical definition object.
SmallWeightCheckpoint = SmallNativeCheckpoint

__all__ = [
    "NATIVE_PRECISIONS",
    "PREPOST_RECORD_BYTES",
    "SmallNativeCheckpoint",
    "SmallWeightCheckpoint",
]
