"""Opt-in Small31 DLSS-NR research graph and strict archive reader.

Small31 is the 310.9.16 ``10/WEIGHTS_CC_SMALL_FP8/1033`` resource.  It stores
77 raw records named ``block0`` .. ``block30``; those raw ids are *not* legacy
operation roles.  This module maps every raw record through
:data:`dlssnr.model_specs.SMALL31` and builds exactly 31 ``NRBlock`` modules
keyed by role.  It is an additive, opt-in research/training implementation:

* floating PyTorch only (FP32/BF16); no native FP16/FP8 deployment path,
* the source-derived phases and 4x32 logical post head (RGB + 32-half history
  gate) are pinned to ``lmxxf/DLSS5-RTX-3080-laptop`` commit
  ``fe3f91a2b0e02259b8beed80ae023da3e3ef09be`` and verified against the original
  310.9.16 artifact; PyTorch math remains a floating surrogate,
* sub-tensor layouts and grouped C64-C256 FFN indexing reuse the existing
  decoder; full native FP16 FFN oracle parity remains unexecuted.

The existing 71-block :class:`dlssnr.model.DLSSNR`, checkpoints and decoder are
not modified.  Numerical helpers are reused explicitly through the legacy
``WeightArchive.decode_block`` role view and ``Numerics``; no legacy class is
initialised with substitute state.
"""
from __future__ import annotations

from dataclasses import dataclass
import json
from pathlib import Path

import numpy as np
import torch
from torch import nn

from .geometry import Geometry, block_layout
from .model import DLSSNR, NRBlock, Numerics
from .model_specs import ModelSpec, PostHeadSpec, SMALL31
from .runtime_assets import AssetIdentityError, ManifestError, sha256_bytes, validate_manifest_tensors, verify_stage_pins
from .weights import TensorRecord, WeightArchive


def _bit_permutation(count: int, positions: tuple[int, ...]) -> np.ndarray:
    """Map each flat index to a row/column coordinate by bit selection."""
    index = np.arange(count, dtype=np.int64)
    result = np.zeros(count, dtype=np.int64)
    for bit, position in enumerate(positions):
        result |= ((index >> position) & 1) << bit
    return result


def decode_native_rgb_head_data(data: bytes | memoryview, post_head: PostHeadSpec) -> torch.Tensor:
    """Decode the native 16x32 scatter into the logical 4x32 post head for audit.

    The 1024-byte region is 512 f16 values.  The pinned HIP reference
    (``fe3f91a2b0e02259b8beed80ae023da3e3ef09be``) scatters them with row bits
    ``(2,5,6,7)`` and column bits ``(0,1,3,4,8)``; rows ``(0,2,4,6)`` are the
    96 RGB values plus the 32-half history gate.  This matches the local
    ``head[32,4]`` decode under a consistent packing permutation.  The helper
    is inspection-only: the model reuses the unmodified legacy head decode and
    never feeds this alternate channel basis into ``NRBlock``.
    """
    if not isinstance(post_head, PostHeadSpec):
        raise TypeError("post_head must be a PostHeadSpec")
    rows, columns = post_head.storage_shape
    if rows < 1 or columns < 1 or len(data) != post_head.byte_length:
        raise ValueError("post head region does not match the declared byte length")
    count = rows * columns
    flat = np.frombuffer(data, dtype="<f2")
    if flat.size != count:
        raise ValueError("post head region does not contain the declared f16 count")
    row_index = _bit_permutation(count, post_head.row_bits)
    column_index = _bit_permutation(count, post_head.column_bits)
    if row_index.max(initial=0) >= rows or column_index.max(initial=0) >= columns:
        raise ValueError("post head bit permutations exceed the storage shape")
    if len(set(zip(row_index.tolist(), column_index.tolist()))) != count:
        raise ValueError("post head bit permutations do not define a bijection")
    storage = np.empty((rows, columns), dtype=np.float16)
    storage[row_index, column_index] = flat
    used = np.asarray(post_head.used_rows, dtype=np.int64)
    if used.size != post_head.native_shape[0] or np.any(used < 0) or np.any(used >= rows):
        raise ValueError("post head used rows do not match the native shape")
    selected = storage[used]
    if selected.shape != tuple(post_head.native_shape):
        raise ValueError("logical post head shape differs from the declared shape")
    if post_head.history_row not in post_head.used_rows:
        raise ValueError("post head history row is not part of the logical head")
    return torch.from_numpy(np.ascontiguousarray(selected.astype(np.float32)))


@dataclass(frozen=True)
class SmallScheduleStep:
    """One ordered step of the explicit Small31 forward schedule."""

    kind: str
    role: int
    phase: int | None
    level: int | None = None
    target: tuple[int, int] | None = None
    skip_level: int | None = None
    skip_role: int | None = None


class SmallWeightArchive:
    """Strict reader for a Small31 archive produced by the versioned extractor.

    This class intentionally does not inherit or call ``WeightArchive.__init__``:
    the Small manifest is 31 blocks / 77 records / 11 stages, so legacy totals
    must not be faked.  It does reuse the trusted decoder through the explicit
    role view ``WeightArchive.decode_block(self, role)``; ``tensor()`` accepts
    operation roles and maps them to raw DLL record ids.

    ``require_complete=False`` is a deliberately narrow fixture escape hatch
    (mirroring the legacy archive): model identity, source pins, stage paths,
    sizes and hashes are still checked, but a subset roster is allowed.  The
    model constructor calls ``validate_complete()`` so production construction
    still requires all 77 records.
    """

    fp8_matrix = staticmethod(WeightArchive.fp8_matrix)
    f16_matrix = staticmethod(WeightArchive.f16_matrix)
    vector = staticmethod(WeightArchive.vector)
    relative_bias = staticmethod(WeightArchive.relative_bias)

    def __init__(self, directory, *, verify_hashes: bool = True, require_complete: bool = True,
                 spec: ModelSpec = SMALL31):
        if not isinstance(spec, ModelSpec) or spec.id != "small31":
            raise ValueError("SmallWeightArchive requires the explicit small31 ModelSpec")
        self.spec = spec
        self.directory = Path(directory).resolve()
        manifest_path = self.directory / "manifest.json"
        if not manifest_path.is_file():
            raise FileNotFoundError(f"expected extracted Small31 archive at {manifest_path}")
        manifest_bytes = manifest_path.read_bytes()
        try:
            manifest = json.loads(manifest_bytes.decode("utf-8"))
        except (UnicodeDecodeError, json.JSONDecodeError) as exc:
            raise ManifestError("manifest.json is not valid UTF-8 JSON") from exc
        if not isinstance(manifest, dict):
            raise ManifestError("manifest root must be an object")
        if manifest.get("schemaVersion") != 2 or manifest.get("format") != "dlssnr-runtime-assets":
            raise ManifestError("unsupported Small31 manifest schema")
        self.manifest = manifest
        self.manifest_sha256 = sha256_bytes(manifest_bytes)
        self._validate_identity(manifest)
        self._validate_source(manifest)
        stage_entries = manifest.get("stages")
        tensor_entries = manifest.get("tensors")
        if not isinstance(stage_entries, (list, tuple)):
            raise ManifestError("manifest stages must be an array")
        if not isinstance(tensor_entries, (list, tuple)):
            raise ManifestError("manifest tensors must be an array")
        stages = self._load_stages(stage_entries, require_complete=require_complete,
                                   verify_hashes=verify_hashes)
        self.stages = stages
        self._validate_totals(manifest, stages, require_complete=require_complete)
        self.records: dict[str, TensorRecord] = {}
        self._load_tensors(tensor_entries, stages, verify_hashes=verify_hashes,
                           require_complete=require_complete)
        self.dll_sha256 = manifest["source"]["dllSha256"]
        self.resource_sha256 = manifest["source"]["resource"]["sha256"]
        if require_complete:
            self.validate_complete()

    def _validate_identity(self, manifest: dict) -> None:
        model = manifest.get("model")
        if not isinstance(model, dict):
            raise ManifestError("manifest model section is missing")
        if model.get("id") != self.spec.id:
            raise ManifestError(f"manifest model {model.get('id')!r} is not {self.spec.id!r}")
        if model.get("blockCount") != self.spec.block_count:
            raise ManifestError("manifest blockCount differs from the Small31 identity")
        if model.get("roles") != list(self.spec.roles):
            raise ManifestError("manifest roles differ from the Small31 role order")
        if model.get("rawToRole") != list(self.spec.raw_to_role):
            raise ManifestError("manifest rawToRole differs from the Small31 raw -> role map")
        if model.get("postRole") != self.spec.post_role or model.get("preRole") != self.spec.pre_role:
            raise ManifestError("manifest pre/post roles differ from the Small31 identity")
        if model.get("postPhaseDefault") != self.spec.post_phase_default:
            raise ManifestError("manifest post phase default differs from the Small31 identity")
        if self.spec.post_head is not None:
            head = model.get("postHead")
            if not isinstance(head, dict):
                raise ManifestError("manifest is missing the Small31 native post head")
            expected = {
                "offset": self.spec.post_head.offset,
                "byteLength": self.spec.post_head.byte_length,
                "storageShape": list(self.spec.post_head.storage_shape),
                "rowBits": list(self.spec.post_head.row_bits),
                "columnBits": list(self.spec.post_head.column_bits),
                "usedRows": list(self.spec.post_head.used_rows),
                "nativeShape": list(self.spec.post_head.native_shape),
                "historyRow": self.spec.post_head.history_row,
                "historyByteLength": self.spec.post_head.history_byte_length,
            }
            for key, value in expected.items():
                if head.get(key) != value:
                    raise ManifestError(f"manifest post head {key} differs from the Small31 identity")

    def _validate_source(self, manifest: dict) -> None:
        source = manifest.get("source")
        if not isinstance(source, dict):
            raise ManifestError("manifest source section is missing")
        pins = [pin for pin in self.spec.dll_pins]
        matching = [pin for pin in pins
                    if pin.sha256 == source.get("dllSha256") and pin.byte_length == source.get("dllByteLength")]
        if len(matching) != 1:
            raise ManifestError("manifest DLL identity is not an accepted original Small31 runtime")
        resource = source.get("resource")
        if not isinstance(resource, dict):
            raise ManifestError("manifest resource identity is missing")
        if resource.get("path") != self.spec.resource.path:
            raise ManifestError("manifest resource path differs from the Small31 identity")
        if resource.get("sha256") != self.spec.resource.sha256:
            raise ManifestError("manifest resource SHA-256 differs from the Small31 identity")
        if resource.get("byteLength") != self.spec.resource.byte_length:
            raise ManifestError("manifest resource byte length differs from the Small31 identity")
        if source.get("runtimeExecuted") is not False or source.get("networkUsed") is not False:
            raise ManifestError("manifest was not produced by the offline static extractor")

    def _validate_totals(self, manifest: dict, stages: dict[str, bytes], *, require_complete: bool) -> None:
        totals = manifest.get("totals")
        if not isinstance(totals, dict):
            raise ManifestError("manifest totals section is missing")
        tensors = manifest.get("tensors")
        if not isinstance(tensors, (list, tuple)):
            raise ManifestError("manifest tensors must be an array")
        if totals.get("blockCount") != self.spec.block_count or totals.get("roleCount") != len(self.spec.roles):
            raise ManifestError("manifest totals do not describe the Small31 block/role identity")
        if totals.get("tensorCount") != len(tensors) or totals.get("stageCount") != len(stages):
            raise ManifestError("manifest totals disagree with the listed tensors/stages")
        if totals.get("packedByteLength") != sum(len(data) for data in stages.values()):
            raise ManifestError("manifest packed byte total disagrees with the stage payloads")
        if require_complete:
            model = manifest["model"]
            if model.get("recordCount") != self.spec.record_count:
                raise ManifestError("manifest recordCount differs from the Small31 identity")
            if model.get("payloadBytes") != self.spec.payload_bytes:
                raise ManifestError("manifest payloadBytes differs from the Small31 identity")
            if totals.get("tensorCount") != self.spec.record_count:
                raise ManifestError("manifest tensorCount differs from the Small31 identity")
            if totals.get("stageCount") != len(self.spec.stages):
                raise ManifestError("manifest stageCount differs from the Small31 identity")
            if totals.get("packedByteLength") != self.spec.payload_bytes:
                raise ManifestError("manifest packedByteLength differs from the Small31 identity")
            if totals.get("resourceByteLength") != self.spec.resource.byte_length:
                raise ManifestError("manifest resourceByteLength differs from the Small31 identity")
            expected_overhead = self.spec.resource.byte_length - self.spec.payload_bytes
            if totals.get("envelopeOverheadBytes") != expected_overhead:
                raise ManifestError("manifest envelope overhead differs from the Small31 identity")

    def _load_stages(self, entries, *, require_complete: bool, verify_hashes: bool) -> dict[str, bytes]:
        if not isinstance(entries, (list, tuple)):
            raise ManifestError("manifest stages must be an array")
        known = {stage.id for stage in self.spec.stages}
        stages: dict[str, bytes] = {}
        seen_paths: set[Path] = set()
        model_root = (self.directory / "model").resolve()
        for entry in entries:
            if not isinstance(entry, dict):
                raise ManifestError("each stage entry must be an object")
            stage_id = entry.get("id")
            if not isinstance(stage_id, str) or stage_id not in known:
                raise ManifestError(f"unknown Small31 stage id {stage_id!r}")
            if stage_id in stages:
                raise ManifestError(f"duplicate Small31 stage {stage_id!r}")
            file_name = entry.get("file")
            if not isinstance(file_name, str) or not file_name:
                raise ManifestError(f"stage {stage_id} has no file name")
            path = (model_root / file_name).resolve()
            if not path.is_relative_to(model_root):
                raise ManifestError(f"stage path escapes the model directory: {file_name}")
            if path in seen_paths:
                raise ManifestError(f"two stages reference the same file: {file_name}")
            seen_paths.add(path)
            size = entry.get("packedByteLength")
            digest = entry.get("sha256")
            if type(size) is not int or size < 0:
                raise ManifestError(f"stage {stage_id} has an invalid byte length")
            if not isinstance(digest, str) or len(digest) != 64:
                raise ManifestError(f"stage {stage_id} has an invalid SHA-256")
            if not path.is_file():
                raise FileNotFoundError(f"stage file is missing: {path}")
            data = path.read_bytes()
            if len(data) != size:
                raise ManifestError(f"stage size mismatch: {stage_id}")
            if verify_hashes and sha256_bytes(data) != digest.lower():
                raise ManifestError(f"stage SHA-256 mismatch: {stage_id}")
            stages[stage_id] = data
        if require_complete:
            expected = [stage.id for stage in self.spec.stages]
            if [entry.get("id") for entry in entries] != expected:
                raise ManifestError("Small31 manifest stages differ from the declared stage order")
            if self.spec.stage_pins:
                try:
                    verify_stage_pins(self.spec, stages)
                except AssetIdentityError as exc:
                    raise ManifestError(f"Small31 stage payloads differ from the trusted pins: {exc}") from exc
        return stages

    def _load_tensors(self, entries, stages: dict[str, bytes], *, verify_hashes: bool,
                      require_complete: bool) -> None:
        validate_manifest_tensors(self.spec, entries, require_complete=require_complete)
        intervals: dict[str, list[tuple[int, int, str]]] = {stage_id: [] for stage_id in stages}
        total_payload = 0
        for entry in entries:
            name = entry["name"]
            stage_id = entry["stage"]
            if stage_id not in stages:
                raise ManifestError(f"tensor {name} references an unknown or unloaded stage {stage_id!r}")
            offset = entry.get("stageOffset")
            length = entry["byteLength"]
            if type(offset) is not int or offset < 0 or offset + length > len(stages[stage_id]):
                raise ManifestError(f"tensor {name} exceeds its stage")
            raw_block = entry.get("rawBlock", entry.get("block"))
            role = entry["role"]
            data = memoryview(stages[stage_id])[offset:offset + length]
            digest = entry.get("sha256")
            if not isinstance(digest, str) or len(digest) != 64:
                raise ManifestError(f"tensor {name} has an invalid SHA-256")
            if verify_hashes and sha256_bytes(data) != digest.lower():
                raise ManifestError(f"tensor SHA-256 mismatch: {name}")
            intervals[stage_id].append((offset, offset + length, name))
            total_payload += length
            self.records[name] = TensorRecord(
                name=name,
                block=raw_block,
                layer=entry["layer"],
                parameter=entry["parameter"],
                stage=stage_id,
                stage_offset=offset,
                data=data,
            )
        for stage_id, spans in intervals.items():
            spans.sort()
            for left, right in zip(spans, spans[1:]):
                if left[1] > right[0]:
                    raise ManifestError(f"overlapping tensor records in stage {stage_id}: {left[2]} and {right[2]}")
            if require_complete:
                cursor = 0
                for start, end, name in spans:
                    if start != cursor:
                        raise ManifestError(
                            f"tensor records do not exactly cover stage {stage_id} at {name}: "
                            f"expected offset {cursor}, found {start}")
                    cursor = end
                if cursor != len(stages[stage_id]):
                    raise ManifestError(
                        f"tensor records do not cover the full payload of stage {stage_id}: "
                        f"covered {cursor} of {len(stages[stage_id])} bytes")
        if require_complete:
            if total_payload != self.spec.payload_bytes:
                raise ManifestError("Small31 payload total differs from the pinned 113887490 bytes")
            if sum(len(data) for data in stages.values()) != self.spec.payload_bytes:
                raise ManifestError("Small31 stage payload total differs from the pinned value")
            for stage in self.spec.stages:
                expected_roles = list(stage.roles)
                entry = next(item for item in self.manifest["stages"] if item["id"] == stage.id)
                if entry.get("roles") != expected_roles:
                    raise ManifestError(f"stage {stage.id} roles differ from the model identity")
                expected_raw = sorted(self.spec.raw_for_role(role) for role in stage.roles)
                if entry.get("rawBlocks") != expected_raw:
                    raise ManifestError(f"stage {stage.id} raw ids differ from the model identity")

    def validate_complete(self) -> None:
        """Require the full trusted Small31 identity.

        Model construction always calls this method, so a full-roster archive
        opened through the ``require_complete=False`` fixture escape cannot skip
        the trusted stage pins or the canonical record layout.  The checks cover
        the 77-record roster, exact byte totals, stage roster/roles/raw ids,
        pinned stage payload hashes, canonical per-record offsets and exact
        gapless stage coverage.
        """
        expected = self.spec.expected_record_names()
        actual = set(self.records)
        if actual != expected:
            raise ManifestError(
                f"Small31 archive requires {self.spec.record_count} records; "
                f"missing={sorted(expected - actual)}, unexpected={sorted(actual - expected)}")
        expected_sizes = self.spec.expected_record_sizes()
        for name, size in expected_sizes.items():
            if len(self.records[name].data) != size:
                raise ManifestError(
                    f"record layout mismatch for {name}: expected {size} bytes, found {len(self.records[name].data)}")
        if sum(len(record.data) for record in self.records.values()) != self.spec.payload_bytes:
            raise ManifestError("decoded record payload total differs from the pinned value")

        stages = getattr(self, "stages", None)
        if not isinstance(stages, dict) or set(stages) != {stage.id for stage in self.spec.stages}:
            raise ManifestError("Small31 archive does not contain the complete stage roster")
        entries = self.manifest.get("stages")
        if not isinstance(entries, (list, tuple)):
            raise ManifestError("manifest stages must be an array")
        if [entry.get("id") for entry in entries] != [stage.id for stage in self.spec.stages]:
            raise ManifestError("Small31 manifest stages differ from the declared stage order")
        if self.spec.stage_pins:
            try:
                verify_stage_pins(self.spec, stages)
            except AssetIdentityError as exc:
                raise ManifestError(f"Small31 stage payloads differ from the trusted pins: {exc}") from exc
        for stage in self.spec.stages:
            entry = next(item for item in entries if item.get("id") == stage.id)
            if entry.get("roles") != list(stage.roles):
                raise ManifestError(f"stage {stage.id} roles differ from the model identity")
            expected_raw = sorted(self.spec.raw_for_role(role) for role in stage.roles)
            if entry.get("rawBlocks") != expected_raw:
                raise ManifestError(f"stage {stage.id} raw ids differ from the model identity")
            expected_bytes = sum(
                record.byte_length for record in self.spec.records if record.stage == stage.id)
            if entry.get("packedByteLength") != expected_bytes or len(stages[stage.id]) != expected_bytes:
                raise ManifestError(f"stage {stage.id} byte extent differs from the canonical roster")

        tensors = self.manifest.get("tensors")
        validate_manifest_tensors(self.spec, tensors, require_complete=True)
        canonical = self.spec.stage_record_offsets()
        spans: dict[str, list[tuple[int, int, str]]] = {stage.id: [] for stage in self.spec.stages}
        for tensor in tensors:
            name = tensor["name"]
            expected_offset = canonical[tensor["stage"]][name]
            if tensor.get("stageOffset") != expected_offset:
                raise ManifestError(
                    f"{name}: stage offset {tensor.get('stageOffset')!r} != canonical "
                    f"packed offset {expected_offset} for stage {tensor['stage']!r}")
            spans[tensor["stage"]].append(
                (expected_offset, expected_offset + tensor["byteLength"], name))
        for stage in self.spec.stages:
            cursor = 0
            for start, end, name in sorted(spans[stage.id]):
                if start != cursor:
                    raise ManifestError(
                        f"tensor records do not exactly cover stage {stage.id} at {name}: "
                        f"expected offset {cursor}, found {start}")
                cursor = end
            if cursor != len(stages[stage.id]):
                raise ManifestError(
                    f"tensor records do not cover the full payload of stage {stage.id}: "
                    f"covered {cursor} of {len(stages[stage.id])} bytes")

    def tensor(self, role: int, layer: int = 0, parameter: str = "layer") -> TensorRecord:
        """Return a raw record through the explicit operation-role view."""
        if isinstance(role, bool) or not isinstance(role, int):
            raise TypeError("role must be an int")
        raw_block = self.spec.raw_for_role(role)
        name = f"block{raw_block}.layer{layer}.{parameter}"
        try:
            return self.records[name]
        except KeyError as exc:
            raise ValueError(f"role {role} (raw block {raw_block}) has no record {name}") from exc

    def record_for_raw(self, raw_block: int, layer: int = 0, parameter: str = "layer") -> TensorRecord:
        """Return a record by raw DLL id; kept separate from the role view."""
        if isinstance(raw_block, bool) or not isinstance(raw_block, int):
            raise TypeError("raw_block must be an int")
        return self.tensor(self.spec.role_for_raw(raw_block), layer=layer, parameter=parameter)

    def decode_native_rgb_head(self) -> torch.Tensor:
        """Decode the native 16x32 scatter to the logical 4x32 head for audit."""
        post_head = self.spec.post_head
        if post_head is None:
            raise ValueError("model identity has no post head metadata")
        record = self.tensor(self.spec.post_role)
        return decode_native_rgb_head_data(record.slice(post_head.offset, post_head.byte_length), post_head)

    def decode_block(self, role: int) -> dict[str, torch.Tensor]:
        """Decode learned tensors by operation role through the trusted decoder.

        Returns the unmodified :meth:`WeightArchive.decode_block` result for the
        role, including the post role's ``head[32,4]``.  ``NRBlock`` transposes
        the matrix-shaped tensors, so the post head becomes ``[4,32]`` and both
        ``_post_head`` and ``compose`` consume all four channels (RGB + history
        gate) exactly as the legacy graph does.  No missing or no-op fallback is
        supplied.
        """
        if isinstance(role, bool) or not isinstance(role, int) or not self.spec.has_role(role):
            raise ValueError(f"role {role!r} is not present in Small31")
        return WeightArchive.decode_block(self, role)


class _RoleBlocks(nn.Module):
    """Integer role -> NRBlock adapter used by the reused DLSSNR stage helpers."""

    def __init__(self, blocks: dict[int, nn.Module]):
        super().__init__()
        self.by_role = nn.ModuleDict({str(role): module for role, module in blocks.items()})

    def __getitem__(self, role: int) -> nn.Module:
        if isinstance(role, bool) or not isinstance(role, int):
            raise TypeError("block role must be an int")
        key = str(role)
        if key not in self.by_role:
            raise KeyError(f"role {role} is not present in Small31")
        return self.by_role[key]

    def __len__(self) -> int:
        return len(self.by_role)

    def __iter__(self):
        return iter(self.roles())

    def roles(self) -> tuple[int, ...]:
        return tuple(sorted(int(key) for key in self.by_role.keys()))


class SmallDLSSNR(nn.Module):
    """Opt-in 31-role Small31 PyTorch research graph.

    This is a floating training reconstruction, not a vendor numerical oracle
    and not a native FP16/FP8 deployment implementation.  Input features are
    caller-prepared padded BHWC ``[B,H,W,16]`` tensors.  The model returns the
    four-channel post head ``[B,H,W,4]``: channels 0..2 are the RGB residual and
    channel 3 is the history gate.  ``compose(head, proxy, reprojected_history)``
    is the unmodified legacy helper and uses ``head[:3]`` plus ``head[3]``.

    The legacy 71-block class, decoder, checkpoints and native plans are
    untouched.  Stage/rounding/skip behavior reuses the explicit
    :class:`~dlssnr.model.DLSSNR` helpers through an integer role-indexed block
    adapter.
    """

    _run_stage = DLSSNR._run_stage
    _input_block = DLSSNR._input_block
    _input_stage = DLSSNR._input_stage
    _encoder_stage = DLSSNR._encoder_stage
    _decoder_stage = DLSSNR._decoder_stage
    _bottleneck_stage = DLSSNR._bottleneck_stage
    _post_head = DLSSNR._post_head
    compose = DLSSNR.compose

    def __init__(self, archive, *, precision: str = "fp32", trainable: bool = False,
                 checkpoint_blocks: bool = False, post_phase: int | None = None):
        super().__init__()
        spec = getattr(archive, "spec", None)
        if not isinstance(spec, ModelSpec) or spec.id != "small31":
            raise ValueError("SmallDLSSNR requires a SmallWeightArchive for the explicit small31 model")
        if not isinstance(trainable, bool):
            raise TypeError("trainable must be a bool")
        if not isinstance(checkpoint_blocks, bool):
            raise TypeError("checkpoint_blocks must be a bool")
        archive.validate_complete()
        self.spec = spec
        self.numerics = Numerics(precision)
        self.precision = precision
        self.checkpoint_blocks = checkpoint_blocks
        self.post_phase = self._validated_post_phase(post_phase)
        self.archive_manifest_sha256 = str(getattr(archive, "manifest_sha256", ""))
        self.source_dll_sha256 = str(getattr(archive, "dll_sha256", ""))
        blocks: dict[int, nn.Module] = {}
        for role in spec.roles:
            decoded = dict(archive.decode_block(role))
            if role == spec.post_role and "head" not in decoded:
                raise ValueError("Small31 post role did not decode the 4x32 logical head")
            blocks[role] = NRBlock(role, decoded, self.numerics, trainable=trainable)
        self.blocks = _RoleBlocks(blocks)

    def _validated_post_phase(self, post_phase: int | None) -> int:
        value = self.spec.post_phase_default if post_phase is None else post_phase
        if isinstance(value, bool) or not isinstance(value, int) or value not in range(4):
            raise ValueError("post_phase must be an integer in 0..3")
        return value

    @classmethod
    def from_directory(cls, directory: str | Path, *, device=None, dtype=torch.float32,
                       verify_hashes: bool = True, precision: str = "fp32",
                       trainable: bool = False, checkpoint_blocks: bool = False,
                       post_phase: int | None = None, spec: ModelSpec = SMALL31):
        """Load the strict 77-record archive and build the opt-in Small31 graph."""
        if dtype not in (torch.float32, torch.bfloat16):
            raise ValueError("training storage must be float32 or bfloat16; FP16/FP8 deployment is out of scope")
        archive = SmallWeightArchive(directory, verify_hashes=verify_hashes, spec=spec)
        model = cls(archive, precision=precision, trainable=trainable,
                    checkpoint_blocks=checkpoint_blocks, post_phase=post_phase)
        return model.to(device=device, dtype=dtype)

    @staticmethod
    def schedule_plan(geometry: Geometry, *, post_phase: int | None = None,
                      spec: ModelSpec = SMALL31) -> tuple[SmallScheduleStep, ...]:
        """Return the explicit ordered Small31 schedule without allocating tensors.

        This is the single ordering source used by ``forward`` and the focused
        CPU schedule tests.  Encoder tails are roles ``4,8,14,22,30``; the
        bottleneck consumes skip ``30``; decoder entries consume
        ``22,14,8,4``.  A raw-index implementation would instead produce
        ``2,4,6,8,10`` and is rejected by the tests.
        """
        if not isinstance(geometry, Geometry):
            raise TypeError("geometry must be a Geometry")
        if len(geometry.levels) != 6:
            raise ValueError("Small31 geometry must expose six spatial levels")
        value = SMALL31.post_phase_default if post_phase is None else post_phase
        if isinstance(value, bool) or not isinstance(value, int) or value not in range(4):
            raise ValueError("post_phase must be an integer in 0..3")
        if spec.id != "small31":
            raise ValueError("schedule_plan is defined only for the Small31 identity")
        stages = {stage.kind: [] for stage in spec.stages}
        for stage in spec.stages:
            stages.setdefault(stage.kind, []).append(stage)
        encoder_stages = stages.get("encoder", [])
        decoder_stages = stages.get("decoder", [])
        vit_stages = stages.get("vit", [])
        if len(encoder_stages) != 5 or len(decoder_stages) != 5 or len(vit_stages) != 1:
            raise ValueError("Small31 stage identity is incomplete")
        if spec.transition_role is None:
            raise ValueError("Small31 requires an explicit transition role")
        vit_stage = vit_stages[0]

        steps: list[SmallScheduleStep] = [
            SmallScheduleStep("input", spec.pre_role, spec.phase_for_role(spec.pre_role),
                              level=0, target=geometry.levels[0]),
        ]
        encoder_skip_role: dict[int, int] = {}
        for level, stage in enumerate(encoder_stages):
            pair = tuple(role for role in stage.roles if role != spec.pre_role)
            if len(pair) != 2:
                raise ValueError(f"Small31 encoder stage {stage.id} must contain one pre role and one pair")
            first, last = pair
            steps.append(SmallScheduleStep("block", first, spec.phase_for_role(first), level=level))
            encoder_skip_role[level] = last
            steps.append(SmallScheduleStep(
                "encoder_tail", last, spec.phase_for_role(last), level=level,
                target=geometry.levels[level + 1], skip_level=level, skip_role=last))
        for role in vit_stage.roles:
            steps.append(SmallScheduleStep("block", role, spec.phase_for_role(role), level=5))
        steps.append(SmallScheduleStep(
            "transition", spec.transition_role, spec.phase_for_role(spec.transition_role),
            level=4, target=geometry.levels[4], skip_level=4, skip_role=encoder_skip_role[4]))
        for index, stage in enumerate(decoder_stages):
            level = 4 - index
            if index == 0:
                pair = tuple(role for role in stage.roles if role != spec.transition_role)
            else:
                pair = tuple(role for role in stage.roles if role != spec.post_role)
            if len(pair) != 2:
                raise ValueError(f"Small31 decoder stage {stage.id} must contain one pair plus its boundary role")
            first, last = pair
            if index == 0:
                steps.append(SmallScheduleStep("block", first, spec.phase_for_role(first), level=level))
                steps.append(SmallScheduleStep("block", last, spec.phase_for_role(last), level=level))
            else:
                steps.append(SmallScheduleStep(
                    "decoder_entry", first, spec.phase_for_role(first), level=level,
                    target=geometry.levels[level], skip_level=level,
                    skip_role=encoder_skip_role[level]))
                steps.append(SmallScheduleStep("block", last, spec.phase_for_role(last), level=level))
        steps.append(SmallScheduleStep(
            "post", spec.post_role, value, level=6,
            target=(geometry.full_width, geometry.full_height)))

        scheduled = [spec.pre_role] + [step.role for step in steps if step.kind in (
            "block", "encoder_tail", "transition", "decoder_entry", "post")]
        if sorted(scheduled) != list(spec.roles) or len(scheduled) != len(spec.roles):
            raise AssertionError("Small31 schedule does not visit each operation role exactly once")
        return tuple(steps)

    def block_by_role(self, role: int) -> nn.Module:
        return self.blocks[role]

    def _compat_identity(self) -> dict:
        """Return canonical checkpoint compatibility keys.

        These keys describe the verified model/resource/role/post-phase/head
        contract.  Local manifest provenance (archive path, extractor timestamp,
        manifest SHA-256) is deliberately excluded, so two independently
        extracted copies of the same verified source remain interchangeable.
        """
        return {
            "stateSchema": "dlssnr-small31/1",
            "model": self.spec.id,
            "sourceDllSha256": self.source_dll_sha256,
            "resourcePath": self.spec.resource.path,
            "resourceSha256": self.spec.resource.sha256,
            "resourceByteLength": self.spec.resource.byte_length,
            "roles": list(self.spec.roles),
            "rawToRole": list(self.spec.raw_to_role),
            "blockCount": len(self.blocks),
            "postPhase": self.post_phase,
            "postHead": "4x32",
            "postHeadLayout": "rgb+history_gate",
        }

    def descriptor(self) -> dict:
        """Identity useful for checkpoint/provenance cross-checks.

        ``archiveManifestSha256`` is provenance metadata only; checkpoint
        compatibility uses :meth:`_compat_identity` instead.
        """
        identity = self._compat_identity()
        identity.update({
            "archiveManifestSha256": self.archive_manifest_sha256,
            "precision": self.precision,
        })
        return identity

    def get_extra_state(self) -> dict:
        """Serialize the canonical compatibility identity plus manifest provenance.

        A same-shaped legacy/other-model state dict must not silently replace the
        Small31 identity.  ``load_state_dict`` therefore requires these keys even
        when ``strict=False``.  ``archiveManifestSha256`` is retained only as
        provenance and is not compared on load.
        """
        state = self._compat_identity()
        state["archiveManifestSha256"] = self.archive_manifest_sha256
        return state

    def _validate_extra_state(self, state) -> None:
        if not isinstance(state, dict):
            raise ValueError("Small31 state identity must be a dict")
        for key, value in self._compat_identity().items():
            if key not in state:
                raise ValueError(f"Small31 state identity is missing {key!r}")
            if state[key] != value:
                raise ValueError(
                    f"Small31 state identity mismatch for {key!r}: {state[key]!r} != {value!r}")

    def set_extra_state(self, state) -> None:
        self._validate_extra_state(state)

    def load_state_dict(self, state_dict, strict: bool = True, assign: bool = False):
        if "_extra_state" not in state_dict:
            raise ValueError("Small31 state_dict is missing its model/profile identity")
        self._validate_extra_state(state_dict["_extra_state"])
        return super().load_state_dict(state_dict, strict=strict, assign=assign)

    def forward_train(self, features, **kwargs):
        return self.forward(features, **kwargs)

    def _phase(self, role: int, post_phase: int) -> int | None:
        if role == self.spec.post_role:
            return post_phase
        return self.spec.phase_for_role(role)

    def forward(self, features, *, valid_size=None, geometry=None, return_boundaries=False,
                crop=False, post_phase: int | None = None):
        """Run the floating Small31 graph on caller-prepared padded BHWC features."""
        storage_dtype = self.blocks[self.spec.pre_role].input_adapter.dtype
        if storage_dtype not in (torch.float32, torch.bfloat16):
            raise ValueError("training model storage must be float32 or bfloat16; FP16/FP8 deployment is out of scope")
        if features.ndim != 4 or features.shape[-1] != 16 or features.dtype not in (torch.float32, torch.bfloat16):
            raise ValueError("features must be [batch, padded_height, padded_width, 16] with float32 or bfloat16 dtype")
        if features.device != self.blocks[self.spec.pre_role].input_adapter.device:
            raise ValueError("features and model must be on the same device")
        if geometry is None:
            if valid_size is None:
                raise ValueError("provide valid_size=(width,height) or Geometry; padded size does not determine valid size")
            geometry = Geometry.from_valid(*valid_size)
        if not isinstance(geometry, Geometry):
            raise TypeError("geometry must be a Geometry")
        if features.shape[1:3] != (geometry.full_height, geometry.full_width):
            raise ValueError(f"features must cover padded field {geometry.full_width}x{geometry.full_height}")
        active_post_phase = self.post_phase if post_phase is None else self._validated_post_phase(post_phase)
        plan = self.schedule_plan(geometry, post_phase=active_post_phase)
        n, boundaries, skips = self.numerics, {}, {}
        adapter = state = None

        def capture(name, value):
            if return_boundaries:
                boundaries[name] = value
            return value

        for step in plan:
            phase = self._phase(step.role, active_post_phase)
            if step.kind == "input":
                adapter, state = self._run_stage(self._input_stage, features, phase, step.target)
                capture("block-0", adapter)
                next_role = self.spec.next_role(step.role)
                capture(f"transition-{step.role}-{next_role}", state)
            elif step.kind == "block":
                state, _ = self._run_stage(self.blocks[step.role], state, phase, skip_override=None)
                capture(f"block-{step.role}", state)
            elif step.kind == "encoder_tail":
                high, state = self._run_stage(self._encoder_stage, state, step.role, phase, step.target)
                skips[step.skip_level] = capture(f"block-{step.role}", high)
                next_role = self.spec.next_role(step.role)
                capture(f"transition-{step.role}-{next_role}", state)
            elif step.kind == "transition":
                state = capture(f"block-{step.role}",
                                self._run_stage(self._bottleneck_stage, state,
                                                skips[step.skip_level], step.target))
            elif step.kind == "decoder_entry":
                state, _ = self._run_stage(self._decoder_stage, state, skips[step.skip_level],
                                           step.role, phase, step.target)
                capture(f"block-{step.role}", state)
            elif step.kind == "post":
                head, post_boundary = self._run_stage(
                    self._post_head, state, adapter, geometry, phase,
                    return_boundary=return_boundaries)
                if return_boundaries:
                    boundaries[f"block-{step.role}"] = post_boundary
            else:  # pragma: no cover - schedule_plan is explicit
                raise AssertionError(f"unexpected Small31 schedule step {step.kind!r}")
        if head.shape[-1] != self.spec.post_head.native_shape[0]:
            raise ValueError("Small31 post head did not produce RGB plus the history gate")
        if crop:
            head = head[:, :geometry.valid_height, :geometry.valid_width]
        return (head, boundaries) if return_boundaries else head
