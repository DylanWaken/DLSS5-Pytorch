"""Strict, non-executable OpenDLSS-NR checkpoint reader and fragment unpacker.

Layouts adapted from OpenDLSS-NR, Copyright (c) 2026 maan, MIT;
see third_party/OpenDLSS-NR/LICENSE and NOTICE. No NVIDIA weights are embedded.
"""
from dataclasses import dataclass
import hashlib
import json
from pathlib import Path

import numpy as np
import torch

from .geometry import block_channels, block_layout


def expected_record_names() -> frozenset[str]:
    names = set()
    for block in range(71):
        layers = range(5) if 31 <= block <= 38 else range(4) if 23 <= block <= 30 or 40 <= block <= 47 else range(1)
        names.update(f"block{block}.layer{layer}.layer" for layer in layers)
    names.add("block30.layer4.layer")
    names.add("block70.layer0.blend_scale")
    return frozenset(names)


def expected_record_sizes() -> dict[str, int]:
    """All 153 fused-record byte lengths, including native padding bytes."""
    sizes = {}
    for block in range(71):
        c = block_channels(block)
        if block == 39:
            lengths = (1024 * 512 + 512 * 2,)
        elif c == 1024:
            lengths = (1024 * 4096 + 16, 4096 * 1024 + 2048, 128 + 3 * 1024 * 1024, 2,
                       1024 * 1024 + 2048)
        elif c == 512:
            lengths = (512 * 512 + 8 * 64 * 256 + 8 * 256 * 64, 512 * 512 + 1024,
                       3 * 512 * 512 + 16 * 8192 + 64, 512 * 512 + 1024)
        else:
            size = block_layout(block)["end"]
            if block in (4, 8, 14, 22):
                size += 2 * c * c + (16 if c == 32 else 0)
            elif block != 70:
                size += 16
            lengths = (size,)
        sizes.update({f"block{block}.layer{layer}.layer": size for layer, size in enumerate(lengths)})
    sizes["block30.layer4.layer"] = 512 * 1024 + 16
    sizes["block70.layer0.blend_scale"] = 2
    return sizes


def packed_input_index(k):
    within = k & 31
    quarter = within & 15
    return (k & ~31) + (within & 16) + (quarter >> 2) * 2 + (quarter & 1) + ((quarter & 2) != 0) * 8


def inverse_packed_input_index(k):
    within = k & 31
    return (k & ~31) + (within & 17) + ((within & 2) << 1) + ((within & 4) << 1) + ((within & 8) >> 2)


def packed_weight_index(k, n, output_channels):
    ki, ni = k & 31, n & 127
    lane = ((ni & 7) << 2) | ((ki & 15) >> 2)
    byte = (((ni & 15) >> 3) << 3) | ((ki >> 4) << 2) | (ki & 3)
    return (k >> 5) * output_channels * 32 + (n >> 7) * 4096 + (ni >> 6) * 2048 + ((ni & 63) >> 4) * 512 + lane * 16 + byte


def packed_f16_weight_index(k, n, output_channels):
    tile = (k >> 4) * ((output_channels + 15) // 16) + (n >> 4)
    ki, ni = k & 15, n & 15
    lane = ((ni & 7) << 2) | ((ki & 7) >> 1)
    fragment = (ki >= 8) * 2 + (ki & 1)
    return tile * 256 + lane * 8 + ((ni >> 3) & 1) * 4 + fragment


def tiled_token(t):
    x, y = t & 7, t >> 3
    return (y >> 2) * 32 + (x >> 2) * 16 + (y & 3) * 4 + (x & 3)


def decode_e4m3(codes: np.ndarray) -> np.ndarray:
    """Decode saturating FN bytes; the reference maps both NaN codes to zero."""
    bits = np.asarray(codes, dtype=np.uint8)
    exp, mant = (bits >> 3) & 15, bits & 7
    magnitude = np.where(exp == 0, mant.astype(np.float32) / 512,
                         np.ldexp(1 + mant.astype(np.float32) / 8, exp.astype(np.int32) - 7))
    magnitude = np.where((bits & 127) == 127, np.float32(0), magnitude).astype(np.float32)
    return np.copysign(magnitude, np.where((bits & 128) != 0, np.float32(-1), np.float32(1)))


@dataclass(frozen=True)
class TensorRecord:
    name: str
    block: int
    layer: int
    parameter: str
    stage: str
    stage_offset: int
    data: memoryview

    def slice(self, offset: int, count: int) -> memoryview:
        if offset < 0 or count < 0 or offset + count > len(self.data):
            raise ValueError(f"slice [{offset}, {offset + count}) exceeds {self.name} ({len(self.data)} bytes)")
        return self.data[offset:offset + count]


class WeightArchive:
    """Read manifest.json and model/<stage.file>; validate before allocating GPU tensors.

    ``require_complete=False`` exists for unpacker fixtures only. Production model
    construction still requires all 153 names. SHA-256 verification defaults on.
    """
    def __init__(self, directory, *, verify_hashes: bool = True, require_complete: bool = True):
        self.directory = Path(directory).resolve()
        manifest_path = self.directory / "manifest.json"
        if not manifest_path.is_file():
            raise FileNotFoundError(f"expected extracted OpenDLSS-NR checkpoint at {manifest_path}")
        self.manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        m = self.manifest
        if m.get("totals", {}).get("blockCount") != 71:
            raise ValueError("checkpoint must describe the 71-block DLSS-NR graph")
        if not isinstance(m.get("stages"), list) or not isinstance(m.get("tensors"), list):
            raise ValueError("manifest must contain stages and tensors arrays")
        if require_complete and len(m["stages"]) != 11:
            raise ValueError("checkpoint must have 11 packed stages")
        stages = {}
        model_root = (self.directory / "model").resolve()
        for stage in m["stages"]:
            sid = stage["id"]
            if sid in stages:
                raise ValueError(f"duplicate stage {sid}")
            path = (model_root / stage["file"]).resolve()
            if not path.is_relative_to(model_root):
                raise ValueError(f"stage path escapes model directory: {stage['file']}")
            data = path.read_bytes()
            if len(data) != stage["packedByteLength"]:
                raise ValueError(f"stage size mismatch: {sid}")
            if verify_hashes and hashlib.sha256(data).hexdigest() != str(stage.get("sha256", "")).lower():
                raise ValueError(f"stage SHA-256 mismatch: {sid}")
            stages[sid] = data
        self.records = {}
        stage_intervals = {sid: [] for sid in stages}
        for entry in m["tensors"]:
            name = entry["name"]
            if name in self.records:
                raise ValueError(f"duplicate tensor {name}")
            block, layer, parameter = entry["block"], entry["layer"], entry["parameter"]
            if name != f"block{block}.layer{layer}.{parameter}":
                raise ValueError(f"inconsistent tensor name {name}")
            sid, offset, length = entry["stage"], entry["stageOffset"], entry["byteLength"]
            if sid not in stages:
                raise ValueError(f"tensor {name} references unknown stage {sid}")
            if type(offset) is not int or type(length) is not int or offset < 0 or length <= 0 or offset + length > len(stages[sid]):
                raise ValueError(f"tensor exceeds stage: {name}")
            stage_intervals[sid].append((offset, offset + length, name))
            self.records[name] = TensorRecord(name, block, layer, parameter, sid, offset, memoryview(stages[sid])[offset:offset + length])
        for intervals in stage_intervals.values():
            intervals.sort()
            for left, right in zip(intervals, intervals[1:]):
                if left[1] > right[0]:
                    raise ValueError(f"overlapping tensor records: {left[2]} and {right[2]}")
        if require_complete:
            self.validate_complete()

    def validate_complete(self):
        expected, actual = expected_record_names(), set(self.records)
        if actual != expected:
            raise ValueError(f"checkpoint requires 153 records; missing={sorted(expected - actual)}, unexpected={sorted(actual - expected)}")
        for name, size in expected_record_sizes().items():
            actual_size = len(self.records[name].data)
            if actual_size != size:
                raise ValueError(f"record layout mismatch for {name}: expected {size} bytes, found {actual_size}")

    def tensor(self, block: int, layer: int = 0, parameter: str = "layer") -> TensorRecord:
        name = f"block{block}.layer{layer}.{parameter}"
        try:
            return self.records[name]
        except KeyError as exc:
            raise ValueError(f"missing tensor {name}") from exc

    @staticmethod
    def vector(record: TensorRecord, offset: int, count: int, *, f32=False) -> torch.Tensor:
        dtype = np.dtype("<f4" if f32 else "<f2")
        array = np.frombuffer(record.slice(offset, count * dtype.itemsize), dtype=dtype)
        return torch.from_numpy(array.astype(np.float32, copy=True))

    @staticmethod
    def fp8_matrix(record: TensorRecord, offset: int, k: int, n: int) -> torch.Tensor:
        if k <= 0 or n <= 0 or k % 32 or n % 16:
            raise ValueError("FP8 matrix requires positive K%32 == 0 and N%16 == 0")
        source = np.frombuffer(record.slice(offset, k * n), dtype=np.uint8)
        rows = inverse_packed_input_index(np.arange(k, dtype=np.int64))[:, None]
        cols = np.arange(n, dtype=np.int64)[None, :]
        return torch.from_numpy(decode_e4m3(source[packed_weight_index(rows, cols, n)]))

    @staticmethod
    def f16_matrix(record: TensorRecord, offset: int, k: int, n: int) -> torch.Tensor:
        if k <= 0 or n <= 0 or k % 16 or offset % 2:
            raise ValueError("f16 matrix requires K%16 == 0 and aligned byte offset")
        source = np.frombuffer(record.slice(offset, k * ((n + 15) // 16 * 16) * 2), dtype="<f2")
        rows, cols = np.arange(k, dtype=np.int64)[:, None], np.arange(n, dtype=np.int64)[None, :]
        return torch.from_numpy(source[packed_f16_weight_index(rows, cols, n)].astype(np.float32))

    @staticmethod
    def relative_bias(record: TensorRecord, offset: int, heads: int) -> torch.Tensor:
        """Return [head, natural query, physical key] f32 values of f16 priors."""
        source = np.frombuffer(record.slice(offset, heads * 8192), dtype="<f2").reshape(heads, 4096)
        q = tiled_token(np.arange(64, dtype=np.int64))[:, None]
        k = np.arange(64, dtype=np.int64)[None, :]
        m, n = q & 15, k & 15
        lane = ((m & 7) << 2) | ((n & 7) >> 1)
        index = (q >> 4) * 1024 + (k >> 4) * 256 + lane * 8 + (n >> 3) * 4 + (m >= 8) * 2 + (n & 1)
        return torch.from_numpy(source[:, index].astype(np.float32))

    def decode_block(self, block: int) -> dict[str, torch.Tensor]:
        """Decode learned tensors to natural-channel matrices; no device kernels run."""
        c = block_channels(block)
        r = self.tensor(block)
        matrix, vec, prior = self.fp8_matrix, self.vector, self.relative_bias
        result = {}
        if block == 39:
            result.update(up_projection=matrix(r, 0, 1024, 512), transition_scale=vec(r, 1024 * 512, 512))
            return result
        if c <= 256:
            layout = block_layout(block)
            if c == 32:
                result.update(w1=matrix(r, layout["expand"], c, 128), w2=matrix(r, layout["contract"], 128, c))
            else:
                e = c // 32
                result.update(w1=matrix(r, 0, e * c, 128).reshape(e, c, 128),
                              w2=matrix(r, e * c * 128, e * 128, 32).reshape(e, 128, 32),
                              w3=matrix(r, e * c * 128 + e * 128 * 32, c, c))
            result.update(qkv=matrix(r, layout["qkv"], c, c * 3), projection=matrix(r, layout["projection"], c, c),
                          ffn_scale=vec(r, layout["ffn_scale"], c), attn_scale=vec(r, layout["attn_scale"], c),
                          head_scale=vec(r, layout["head_scale"], c // 32, f32=True),
                          bias=prior(r, layout["relative"], c // 32))
            if block in (4, 8, 14, 22):
                result["down_projection"] = matrix(r, layout["end"], c, 2 * c)
            for key in ("transition_scale", "input_scale", "adapter_scale"):
                if key in layout:
                    result[key] = vec(r, layout[key], c)
            if "up_projection" in layout:
                result["up_projection"] = matrix(r, layout["up_projection"], 2 * c, c)
            if block == 0:
                result["input_adapter"] = self.f16_matrix(r, layout["input_adapter"], 16, 32)
            if block == 70:
                result["head"] = self.f16_matrix(r, layout["head"], 32, 4)
                result["blend_scale"] = vec(self.tensor(70, parameter="blend_scale"), 0, 1)
            return result
        contract, qkv = self.tensor(block, 1), self.tensor(block, 2)
        projection = self.tensor(block, 4 if c == 1024 else 3)
        if c == 512:
            result.update(w1=matrix(r, 0, 512, 512), w2=matrix(r, 262144, 512, 256).reshape(8, 64, 256),
                          w3=matrix(r, 393216, 2048, 64).reshape(8, 256, 64), w4=matrix(contract, 0, 512, 512),
                          qkv=matrix(qkv, 0, 512, 1536), bias=prior(qkv, 786432, 16),
                          head_scale=vec(qkv, 917504, 16, f32=True), ffn_scale=vec(contract, 262144, 512))
            if block == 30:
                result["down_projection"] = matrix(self.tensor(30, 4), 0, 512, 1024)
        else:
            result.update(w1=matrix(r, 0, 1024, 4096), w2=matrix(contract, 0, 4096, 1024),
                          qkv=matrix(qkv, 128, 1024, 3072), head_scale=vec(qkv, 0, 32, f32=True),
                          ffn_scale=vec(contract, 4194304, 1024))
        result.update(projection=matrix(projection, 0, c, c), attn_scale=vec(projection, c * c, c))
        return result
