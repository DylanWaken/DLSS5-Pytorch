"""Portable native-precision checkpoints and upward-only weight loading.

FP8 means original mixed storage: E4M3 matrices, Half ancillary tensors and
Float head scales. FP16 promotes only the E4M3 tensors; Float scales stay Float.
"""
import json
from pathlib import Path

import numpy as np
import torch

from .common.hashing import sha256_bytes, sha256_file
from .common.precision import resolve_precision
from .common.weight_schema import (
    KIND_FOR_C1024_LAYER,
    KIND_FOR_C512_LAYER,
    MATRIX_FIELDS,  # compatibility re-export
)
from .geometry import align_up, block_channels
from .model_specs import LEGACY71
# Compatibility re-exports: the numerical owner is dlssnr.weight_packing.
from .weight_packing import (
    FP8,
    _bias_indices,
    _half_bias,
    _half_matrix,
    _natural,
    pack_kernel_fp16,
    promote_tensor,
)
from .weights import (
    WeightArchive,
    inverse_packed_input_index,
    packed_f16_weight_index,
    packed_weight_index,
)


# Compatibility name: the shared streaming file-digest owner is common.hashing.
file_sha256 = sha256_file


class NativeWeightArchive(WeightArchive):
    """Reuse strict archive validation, but unpack original bits without FP32 re-encoding."""
    @staticmethod
    def fp8_matrix(record, offset, k, n):
        raw = np.frombuffer(record.slice(offset, k * n), dtype=np.uint8)
        rows = inverse_packed_input_index(np.arange(k, dtype=np.int64))[:, None]
        cols = np.arange(n, dtype=np.int64)[None, :]
        codes = raw[packed_weight_index(rows, cols, n)].copy()
        if np.any((codes & 127) == 127):
            raise ValueError("Nonfinite E4M3 codes require an explicit source decoding policy")
        return torch.from_numpy(codes).view(FP8)

    @staticmethod
    def f16_matrix(record, offset, k, n):
        raw = np.frombuffer(record.slice(offset, k * align_up(n, 16) * 2), dtype="<f2")
        rows, cols = np.arange(k, dtype=np.int64)[:, None], np.arange(n, dtype=np.int64)[None, :]
        return torch.from_numpy(raw[packed_f16_weight_index(rows, cols, n)].copy())

    @staticmethod
    def vector(record, offset, count, *, f32=False):
        dtype = np.dtype("<f4" if f32 else "<f2")
        return torch.from_numpy(np.frombuffer(record.slice(offset, count * dtype.itemsize), dtype=dtype).copy())

    @staticmethod
    def relative_bias(record, offset, heads):
        raw = np.frombuffer(record.slice(offset, heads * 8192), dtype="<f2").reshape(heads, 4096)
        return torch.from_numpy(raw[:, _bias_indices()].copy())


class _SchemaArchive(NativeWeightArchive):
    """Derive tensor shapes/dtypes from the existing decoder without loading assets."""
    def __init__(self):
        pass

    def tensor(self, *args, **kwargs):
        return None

    @staticmethod
    def fp8_matrix(record, offset, k, n):
        return torch.empty((k, n), dtype=FP8, device="meta")

    @staticmethod
    def f16_matrix(record, offset, k, n):
        return torch.empty((k, n), dtype=torch.float16, device="meta")

    @staticmethod
    def vector(record, offset, count, *, f32=False):
        return torch.empty(count, dtype=torch.float32 if f32 else torch.float16, device="meta")

    @staticmethod
    def relative_bias(record, offset, heads):
        return torch.empty((heads, 64, 64), dtype=torch.float16, device="meta")


def native_state_dict(archive):
    state = {}
    for block in range(71):
        for name, value in archive.decode_block(block).items():
            if name in MATRIX_FIELDS:
                value = value.transpose(-1, -2)
            state[f"blocks.{block}.{name}"] = value.contiguous()
    return state


class Checkpoint:
    """Validated CPU weight owner. Packing/loading occurs outside CUDA graph capture."""
    model = LEGACY71.id

    def __init__(self, payload):
        if not isinstance(payload, dict):
            raise TypeError("checkpoint payload must be a dict")
        declared = payload.get("model")
        if declared is not None and declared != LEGACY71.id:
            raise ValueError(
                f"Legacy Checkpoint accepts only the legacy71 model, got {declared!r}")
        if payload.get("format_version") != 2:
            raise ValueError("Expected DLSSNR checkpoint format 2, precision fp8 or fp16")
        self.precision = resolve_precision(
            payload.get("weight_precision"),
            error_message="Expected DLSSNR checkpoint format 2, precision fp8 or fp16")
        self.metadata = payload["metadata"]
        self._state = payload["state_dict"]
        self._records = payload.get("native_records", {})
        schema = native_state_dict(_SchemaArchive())
        if set(self._state) != set(schema):
            raise ValueError("Checkpoint tensor roster differs from the 71-record model")
        for name, expected in schema.items():
            actual = self._state[name]
            dtype = torch.float16 if self.precision == "fp16" and expected.dtype == FP8 else expected.dtype
            if (not isinstance(actual, torch.Tensor) or actual.shape != expected.shape or actual.dtype != dtype or
                    actual.device.type != "cpu" or not actual.is_contiguous()):
                raise ValueError("Checkpoint tensor shape/dtype/storage differs: " + name)
            if not torch.isfinite(actual.float()).all().item():
                raise ValueError("Nonfinite checkpoint tensor: " + name)
        if self.precision == "fp8":
            from .records import expected_record_sizes
            sizes = expected_record_sizes()
            if set(self._records) != set(sizes):
                raise ValueError("Native packed-record roster differs")
            for name, size in sizes.items():
                record = self._records[name]
                if (not isinstance(record, torch.Tensor) or record.dtype != torch.uint8 or
                        record.device.type != "cpu" or record.ndim != 1 or
                        record.numel() != size or not record.is_contiguous()):
                    raise ValueError("Invalid native record: " + name)
                if sha256_bytes(record.numpy().tobytes()) != self.metadata["native_record_sha256"][name]:
                    raise ValueError("Native record hash mismatch: " + name)
        elif self._records:
            raise ValueError("FP16 checkpoint must not carry a silent FP8 deployment fallback")

    def state_dict(self, *, dtype=torch.float32):
        """Return independent tensors; reject any requested downward conversion."""
        return {name: promote_tensor(value, dtype).clone() for name, value in self._state.items()}

    def training_model(self, *, device="cpu", precision="fp32", checkpoint_blocks=False, trainable=True):
        """Construct directly from this file, with FP32 masters and explicit compute precision."""
        from .model import DLSSNR
        state = self.state_dict(dtype=torch.float32)

        class DecodedArchive:
            def validate_complete(self):
                # The owning Checkpoint already validated all names, shapes and dtypes.
                pass

            def decode_block(self, index):
                prefix = f"blocks.{index}."
                return {name[len(prefix):]: _natural(state, index, name[len(prefix):])
                        for name in state if name.startswith(prefix)}

        return DLSSNR(DecodedArchive(), precision=precision, trainable=trainable,
                      checkpoint_blocks=checkpoint_blocks).to(device=device)

    def kernel_record(self, block, *, kind="window", precision=None, device="cpu"):
        """Supply a record to existing low-level family APIs; never choose a kernel."""
        target = self.precision if precision is None else precision
        target = resolve_precision(
            target, error_message="Deployment record precision must be fp8 or fp16")
        if self.precision == "fp16" and target == "fp8":
            raise ValueError("FP16 to FP8 requires explicit quantization")
        if target == "fp16":
            raw = pack_kernel_fp16(self._state, block, kind)
            return torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy()).to(device)
        c = block_channels(block)
        if (block == 0 and kind in ("window", "preprocess")) or (block == 70 and kind in ("window", "postprocess")):
            layer = 0
        elif kind == "window" and c in (32, 64, 128, 256) and block not in (0, 70):
            layer = 0
        elif c == 512 and block != 39 and kind in ("ffn", "qkv"):
            layer = 0 if kind == "ffn" else 2
        else:
            raise NotImplementedError("Use the complete FP8 plan or a supported ordinary kernel family")
        return self._records[f"block{block}.layer{layer}.layer"].clone().to(device)

    def create_plan_fp16(self, state, *, width=3840, height=2160):
        """Prepare the Half trunk at the requested valid image resolution.

        Accept native FP8 or widened FP16 weights. Weight packing is independent
        of image shape; the C++ plan computes the exact padded runtime geometry.
        """
        from .deployment import load_extension, create_plan_fp16
        ops = load_extension(device=state.device)
        names, sizes = list(ops.record_names_fp16()), list(ops.record_bytes_fp16())
        if len(names) != len(sizes) or len(set(names)) != len(names):
            raise ValueError("Invalid compiled FP16 record roster")
        records = []
        for name, size in zip(names, sizes):
            block, layer = (int(part.removeprefix(prefix)) for part, prefix in
                            zip(name.split(".")[:2], ("block", "layer")))
            if block == 39:
                kind = "upsample"
            elif 31 <= block <= 38:
                kind = KIND_FOR_C1024_LAYER[layer]
            elif block_channels(block) == 512:
                kind = KIND_FOR_C512_LAYER[layer]
            else:
                kind = "window"
            record = self.kernel_record(block, kind=kind, precision="fp16", device=state.device)
            if record.numel() != size:
                raise ValueError("Checkpoint/extension record size differs: " + name)
            records.append(record)
        return create_plan_fp16(state, records, width=width, height=height)

    def create_plan_fp8(self, state, *, width=3840, height=2160):
        """Prepare the FP8 trunk at the requested valid image resolution.

        Packed checkpoint records are independent of image shape. The C++ plan
        computes the exact padded runtime geometry without per-shape JSON files.
        """
        if self.precision != "fp8":
            raise ValueError("FP16 to FP8 requires explicit quantization; no fallback to original weights")
        from .deployment import load_extension, create_plan_fp8
        ops = load_extension(device=state.device)
        names, sizes = list(ops.record_names_fp8()), list(ops.record_bytes_fp8())
        if len(names) != len(sizes) or len(set(names)) != len(names):
            raise ValueError("Invalid compiled record roster")
        records = []
        for name, size in zip(names, sizes):
            value = self._records[name]
            if value.numel() != size:
                raise ValueError("Checkpoint/extension record size differs: " + name)
            records.append(value.to(device=state.device, copy=True))
        return create_plan_fp8(state, records, width=width, height=height)


def load_checkpoint(path, *, model="legacy71", verify_hash=True):
    """Load one explicitly selected checkpoint owner without archive access.

    ``model='legacy71'`` (the default) keeps the existing format-2 behavior,
    including the adjacent SHA-256 sidecar requirement.  ``model='small31'``
    loads a self-contained format-3 Small31 payload; its sidecar is optional at
    load and verified when present.  The safe ``weights_only=True`` payload is
    inspected before any sidecar policy is applied so cross-model selection
    fails with an explicit identity error even when no sidecar exists.
    """
    from .model_specs import resolve_model

    spec = resolve_model(model)
    path = Path(path)
    if not path.is_file():
        raise ValueError(f"checkpoint file does not exist: {path}")
    payload = torch.load(path, map_location="cpu", weights_only=True)
    if not isinstance(payload, dict):
        raise ValueError("Checkpoint payload must be a dict")
    version = payload.get("format_version")
    declared = payload.get("model")

    if version == 3:
        if declared != "small31":
            raise ValueError(
                f"Checkpoint format 3 declares model {declared!r}; only 'small31' is supported")
        if spec.id != "small31":
            raise ValueError(
                "this checkpoint is a self-contained small31 checkpoint; "
                "select model='small31' explicitly")
        if verify_hash:
            sidecar = path.with_suffix(".json")
            if sidecar.is_file():
                manifest = json.loads(sidecar.read_text(encoding="utf-8"))
                if not isinstance(manifest, dict) or manifest.get("sha256") is None:
                    raise ValueError("Small31 checkpoint sidecar has no sha256 entry")
                if file_sha256(path) != manifest["sha256"]:
                    raise ValueError("Checkpoint file SHA-256 mismatch")
        from .portable_checkpoint import SmallCheckpoint
        return SmallCheckpoint(payload)

    if version == 2:
        if declared is not None and declared != "legacy71":
            raise ValueError(
                f"Checkpoint format 2 declares model {declared!r}; expected 'legacy71'")
        if spec.id != "legacy71":
            raise ValueError(
                "this checkpoint is a legacy71 format-2 checkpoint; "
                "select model='legacy71' explicitly")
        if verify_hash:
            manifest = json.loads(path.with_suffix(".json").read_text(encoding="utf-8"))
            if file_sha256(path) != manifest["sha256"]:
                raise ValueError("Checkpoint file SHA-256 mismatch")
        return Checkpoint(payload)

    raise ValueError(
        f"Unsupported checkpoint format_version {version!r}; expected 2 (legacy71) or 3 (small31)")
