"""Portable native-precision checkpoints and upward-only weight loading.

FP8 means original mixed storage: E4M3 matrices, Half ancillary tensors and
Float head scales. FP16 promotes only the E4M3 tensors; Float scales stay Float.
"""
import hashlib
import json
from pathlib import Path

import numpy as np
import torch

from .geometry import align_up, block_channels
from .weights import WeightArchive, inverse_packed_input_index, packed_weight_index, packed_f16_weight_index, tiled_token

MATRIX_FIELDS = frozenset(("w1", "w2", "w3", "w4", "qkv", "projection", "input_adapter", "head", "up_projection", "down_projection"))
FP8 = torch.float8_e4m3fn


def file_sha256(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for chunk in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def promote_tensor(value, dtype):
    """Only equal storage or lossless widening formats; BF16 and Half are not ordered."""
    allowed = {
        FP8: (FP8, torch.float16, torch.bfloat16, torch.float32, torch.float64),
        torch.float16: (torch.float16, torch.float32, torch.float64),
        torch.bfloat16: (torch.bfloat16, torch.float32, torch.float64),
        torch.float32: (torch.float32, torch.float64),
        torch.float64: (torch.float64,),
    }
    if dtype not in allowed.get(value.dtype, ()):
        raise ValueError(f"{value.dtype} → {dtype} requires explicit quantization; automatic down-conversion is disabled")
    return value.to(dtype=dtype)


def _bias_indices():
    q = tiled_token(np.arange(64, dtype=np.int64))[:, None]
    k = np.arange(64, dtype=np.int64)[None, :]
    m, n = q & 15, k & 15
    lane = ((m & 7) << 2) | ((n & 7) >> 1)
    return (q >> 4) * 1024 + (k >> 4) * 256 + lane * 8 + (n >> 3) * 4 + (m >= 8) * 2 + (n & 1)


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


def _natural(state, block, name):
    value = state[f"blocks.{block}.{name}"]
    return value.transpose(-1, -2).contiguous() if name in MATRIX_FIELDS else value


def _half_matrix(value, k, n):
    value = promote_tensor(value, torch.float16).reshape(k, n).cpu().numpy()
    rows, cols = np.arange(k, dtype=np.int64)[:, None], np.arange(n, dtype=np.int64)[None, :]
    output = np.empty(k * align_up(n, 16), dtype="<f2")
    output[packed_f16_weight_index(rows, cols, n)] = value
    return output.tobytes()


def _half_bias(value):
    value = promote_tensor(value, torch.float16).cpu().numpy()
    output = np.empty((value.shape[0], 4096), dtype="<f2")
    output[:, _bias_indices()] = value
    return output.tobytes()


def pack_kernel_fp16(state, block, kind):
    """K16 layouts for the six measured kernel families; not a full FP16 graph packer."""
    c = block_channels(block)
    get = lambda name: _natural(state, block, name)
    if kind == "window" and c in (32, 64, 128, 256) and block not in (0, 70):
        if c == 32:
            layout = dict(w1=0, w2=8192, ffn_scale=16400, qkv=16480, relative=22624,
                          head_scale=30816, projection=30832, attn_scale=32880, size=32960)
            matrices = [("w1", c, 128), ("w2", 128, c)]
        else:
            w2 = 8 * c * c
            w3 = w2 + 256 * c
            ffn = w3 + 2 * c * c + 16
            qkv = ffn + 2 * c + 16
            bias = qkv + 6 * c * c
            head = bias + c // 32 * 8192
            projection = head + align_up(c // 32 * 4, 16)
            attention = projection + 2 * c * c
            layout = dict(w1=0, w2=w2, w3=w3, ffn_scale=ffn, qkv=qkv, relative=bias,
                          head_scale=head, projection=projection, attn_scale=attention,
                          size=align_up(attention + 2 * c, 64))
            matrices = [("w1", c // 32 * c, 128), ("w2", c // 32 * 128, 32), ("w3", c, c)]
        output = bytearray(layout["size"])
        for name, k, n in matrices + [("qkv", c, 3 * c), ("projection", c, c)]:
            raw = _half_matrix(get(name), k, n)
            output[layout[name]:layout[name] + len(raw)] = raw
        for name in ("ffn_scale", "attn_scale", "head_scale"):
            dtype = torch.float32 if name == "head_scale" else torch.float16
            raw = promote_tensor(get(name), dtype).cpu().numpy().tobytes()
            output[layout[name]:layout[name] + len(raw)] = raw
        raw = _half_bias(get("bias"))
        output[layout["relative"]:layout["relative"] + len(raw)] = raw
        return bytes(output)
    if c == 512 and block != 39 and kind == "ffn":
        return b"".join(_half_matrix(get(name), k, n) for name, k, n in
                        (("w1", 512, 512), ("w2", 512, 256), ("w3", 2048, 64)))
    if c == 512 and block != 39 and kind == "qkv":
        return (_half_matrix(get("qkv"), 512, 1536) + _half_bias(get("bias")) +
                promote_tensor(get("head_scale"), torch.float32).cpu().numpy().tobytes())
    raise NotImplementedError("FP16 record packing currently covers ordinary C32–C256, C512 FFN and C512 QKV")


class Checkpoint:
    """Validated CPU weight owner. Packing/loading occurs outside CUDA graph capture."""
    def __init__(self, payload):
        if payload.get("format_version") != 2 or payload.get("weight_precision") not in ("fp8", "fp16"):
            raise ValueError("Expected DLSSNR checkpoint format 2, precision fp8 or fp16")
        self.precision = payload["weight_precision"]
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
                if hashlib.sha256(record.numpy().tobytes()).hexdigest() != self.metadata["native_record_sha256"][name]:
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
        if target not in ("fp8", "fp16"):
            raise ValueError("Deployment record precision must be fp8 or fp16")
        if self.precision == "fp16" and target == "fp8":
            raise ValueError("FP16 → FP8 requires explicit quantization")
        if target == "fp16":
            raw = pack_kernel_fp16(self._state, block, kind)
            return torch.from_numpy(np.frombuffer(raw, dtype=np.uint8).copy()).to(device)
        c = block_channels(block)
        if kind == "window" and c in (32, 64, 128, 256) and block not in (0, 70):
            layer = 0
        elif c == 512 and block != 39 and kind in ("ffn", "qkv"):
            layer = 0 if kind == "ffn" else 2
        else:
            raise NotImplementedError("Use the complete FP8 plan or a supported ordinary kernel family")
        return self._records[f"block{block}.layer{layer}.layer"].clone().to(device)

    def create_plan_fp8(self, state, *, width=3840, height=2160):
        """Prepare the existing FP8 trunk directly from original packed checkpoint records."""
        if self.precision != "fp8":
            raise ValueError("FP16 → FP8 requires explicit quantization; no fallback to original weights")
        from .deployment import load_extension, create_plan_fp8
        ops = load_extension()
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


def load_checkpoint(path, *, verify_hash=True):
    """Load tensors and plain metadata only, without any extracted archive dependency."""
    path = Path(path)
    if verify_hash:
        manifest = json.loads(path.with_suffix(".json").read_text(encoding="utf-8"))
        if file_sha256(path) != manifest["sha256"]:
            raise ValueError("Checkpoint file SHA-256 mismatch")
    return Checkpoint(torch.load(path, map_location="cpu", weights_only=True))
