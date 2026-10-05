"""Raw OpenDLSS-NR checkpoint records for the reconstructed-only route.

Parsing/record validation retained from the prior strict reader. No Torch,
NumPy, model, decode_block, or compute-operator imports. Layout attribution:
OpenDLSS-NR, Copyright (c) 2026 maan, MIT; see third_party notice.
"""
from dataclasses import dataclass
import hashlib
import json
from pathlib import Path
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
    """Strict raw packed-record reader; no tensor decoding or compute selection."""
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

