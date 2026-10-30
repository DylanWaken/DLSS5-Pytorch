"""Portable self-contained Small31 checkpoints and the shared checkpoint saver.

Two format-version-3 payloads exist for the same canonical
:data:`~dlssnr.model_specs.SMALL31` model:

``storage='native_records'`` / ``weight_precision='fp8'``
    The original 77 packed records exactly as extracted from the signed DLL
    resource.  Decoded state is derived lazily in memory, so the file is about
    the size of the original resource and never duplicates training tensors.

``storage='state_dict'`` / ``weight_precision='fp16'``
    A learned, explicitly quantized state-only payload (native E4M3/Half fields
    narrowed to Half, native Float32 fields retained).  It carries no original
    records and therefore rejects every FP8 deployment request instead of
    silently reusing stale vendor bytes.

Everything stored in the payload is a tensor or an ordinary builtin so that
``torch.load(..., weights_only=True)`` is always sufficient; no archive, DLL or
sidecar is required to decode a loaded checkpoint.
"""
from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import tempfile

import numpy as np
import torch

from .checkpoint import (
    MATRIX_FIELDS,
    Checkpoint,
    _SchemaArchive,
    file_sha256,
    native_state_dict,
    promote_tensor,
)
from .model_specs import SMALL31, ModelSpec
from .records import TensorRecord
from .runtime_assets import ManifestError, verify_stage_pins
from .small_deployment import SmallNativeCheckpoint, _state_from_archive
from .small_model import SmallWeightArchive
from .weights import WeightArchive

__all__ = [
    "SmallCheckpoint",
    "canonical_small_identity",
    "save_checkpoint_payload",
    "small31_checkpoint_payload",
    "small31_state_schema",
]

FORMAT_VERSION = 3
MODEL_ID = "small31"
MODEL_CLASS = "dlssnr.SmallDLSSNR"
NATIVE_STORAGE = "native_records"
STATE_STORAGE = "state_dict"


def canonical_small_identity() -> dict:
    """Return the canonical Small31 compatibility identity as plain builtins.

    These are exactly the keys compared by
    :meth:`dlssnr.small_model.SmallDLSSNR._compat_identity` at the canonical
    default post phase.  The archive manifest hash is provenance only and is
    deliberately absent here.
    """
    spec = SMALL31
    if len(spec.dll_pins) != 1:
        raise ValueError("canonical Small31 identity requires exactly one signed DLL pin")
    post_head = spec.post_head
    if post_head is None:
        raise ValueError("canonical Small31 identity requires the native post head")
    return {
        "stateSchema": "dlssnr-small31/1",
        "model": spec.id,
        "sourceDllSha256": spec.dll_pins[0].sha256,
        "resourcePath": spec.resource.path,
        "resourceSha256": spec.resource.sha256,
        "resourceByteLength": spec.resource.byte_length,
        "roles": list(spec.roles),
        "rawToRole": list(spec.raw_to_role),
        "blockCount": spec.block_count,
        "postPhase": spec.post_phase_default,
        "postHead": "{}x{}".format(*post_head.native_shape),
        "postHeadLayout": "rgb+history_gate",
    }


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


def _record_bytes(value: torch.Tensor, name: str, expected: int) -> bytes:
    if not isinstance(value, torch.Tensor):
        raise TypeError(f"Small31 record {name!r} is not a torch.Tensor")
    if value.dtype != torch.uint8:
        raise ValueError(f"Small31 record {name!r} must be uint8, got {value.dtype}")
    if value.device.type != "cpu":
        raise ValueError(f"Small31 record {name!r} is not on CPU")
    if value.ndim != 1 or value.numel() != expected:
        raise ValueError(
            f"Small31 record {name!r} has shape {tuple(value.shape)}, expected ({expected},)")
    if not value.is_contiguous():
        raise ValueError(f"Small31 record {name!r} is not contiguous")
    return value.numpy().tobytes()


def _stage_payloads(records: dict[str, bytes]) -> dict[str, bytes]:
    """Rebuild canonical stage bytes from records in roster order.

    ``ModelSpec.stage_record_offsets`` is the only trusted source of record
    positions.  Records must gaplessly cover each stage; the caller verifies the
    reconstructed payloads against the trusted canonical stage pins.
    """
    stages: dict[str, bytes] = {}
    canonical_offsets = SMALL31.stage_record_offsets()
    for stage in SMALL31.stages:
        ordered = sorted(
            (record for record in SMALL31.records if record.stage == stage.id),
            key=lambda record: (record.raw_block, record.layer, record.parameter),
        )
        expected_offsets = canonical_offsets[stage.id]
        payload = bytearray()
        for record in ordered:
            if expected_offsets[record.name] != len(payload):
                raise ValueError(
                    f"Small31 record {record.name!r} is not at its canonical stage offset")
            data = records[record.name]
            if len(data) != record.byte_length:
                raise ValueError(
                    f"Small31 record {record.name!r} is {len(data)} bytes, "
                    f"expected {record.byte_length}")
            payload.extend(data)
        stages[stage.id] = bytes(payload)
    verify_stage_pins(SMALL31, stages)
    if sum(len(data) for data in stages.values()) != SMALL31.payload_bytes:
        raise ValueError("rebuilt Small31 stage payloads differ from the canonical payload total")
    return stages


def small31_checkpoint_payload(archive: SmallWeightArchive) -> dict:
    """Build the original record-centric format-3 payload for one archive.

    ``archive`` must be a fully validated :class:`SmallWeightArchive` whose spec
    *equals* canonical :data:`~dlssnr.model_specs.SMALL31`; an id-only match is
    not sufficient because a replaced spec could drop stage pins or reorder
    roles.  All 77 records, including pre/post, blend and unused ViT layer-3
    records, are hashed and the rebuilt stages are checked against the 11
    canonical stage pins.
    """
    if not isinstance(archive, SmallWeightArchive):
        raise TypeError("small31_checkpoint_payload requires a SmallWeightArchive")
    spec = getattr(archive, "spec", None)
    if not isinstance(spec, ModelSpec) or spec != SMALL31:
        raise ValueError(
            "small31_checkpoint_payload requires the canonical SMALL31 model identity, "
            "not merely a matching model id")
    archive.validate_complete()

    records: dict[str, torch.Tensor] = {}
    record_bytes: dict[str, bytes] = {}
    record_hashes: dict[str, str] = {}
    for record in SMALL31.records:
        try:
            source = archive.records[record.name]
        except KeyError as exc:
            raise ValueError(f"Small31 archive is missing record {record.name!r}") from exc
        data = bytes(source.data)
        if len(data) != record.byte_length:
            raise ValueError(
                f"Small31 archive record {record.name!r} is {len(data)} bytes, "
                f"expected {record.byte_length}")
        digest = hashlib.sha256(data).hexdigest()
        record_hashes[record.name] = digest
        record_bytes[record.name] = data
        records[record.name] = torch.from_numpy(
            np.frombuffer(data, dtype=np.uint8).copy())

    stages = _stage_payloads(record_bytes)
    del stages  # Only the pins and payload total are required here.
    if sum(record.byte_length for record in SMALL31.records) != SMALL31.payload_bytes:
        raise ValueError("Small31 record roster is not the canonical payload total")

    manifest = archive.manifest
    if not isinstance(manifest, dict):
        raise TypeError("Small31 archive manifest must be a dict")
    manifest_sha256 = getattr(archive, "manifest_sha256", None)
    dll_sha256 = getattr(archive, "dll_sha256", None)
    if not isinstance(manifest_sha256, str) or len(manifest_sha256) != 64:
        raise ValueError("Small31 archive has no valid manifest SHA-256 provenance")
    if dll_sha256 != canonical_small_identity()["sourceDllSha256"]:
        raise ValueError("Small31 archive DLL identity differs from the signed canonical pin")

    return {
        "format_version": FORMAT_VERSION,
        "model": MODEL_ID,
        "model_class": MODEL_CLASS,
        "weight_precision": "fp8",
        "storage": NATIVE_STORAGE,
        "native_records": records,
        "state_dict": {},
        "model_identity": canonical_small_identity(),
        "metadata": {
            "native_record_sha256": record_hashes,
            "archive_manifest": manifest,
            "archive_manifest_sha256": manifest_sha256,
            "source_dll_sha256": dll_sha256,
            "origin": "dll-extracted",
        },
    }


class _PortableRecordArchive(SmallWeightArchive):
    """In-memory archive adapter over validated format-3 native records.

    It deliberately does not call :meth:`SmallWeightArchive.__init__`: the
    embedded manifest and reconstructed stages already live in memory, so the
    inherited strict identity/source/totals/complete validators run without
    reopening an archive directory or the DLL.  The adapter exposes only the
    surface used by the existing native decoders and plan methods.
    """

    def __init__(self, records: dict[str, TensorRecord], manifest: dict,
                 stages: dict[str, bytes], manifest_sha256: str, dll_sha256: str):
        if manifest.get("schemaVersion") != 2 or manifest.get("format") != "dlssnr-runtime-assets":
            raise ManifestError("unsupported Small31 manifest schema")
        self.spec = SMALL31
        self.records = records
        self.stages = stages
        self.manifest = manifest
        self.manifest_sha256 = manifest_sha256
        self.dll_sha256 = dll_sha256
        self.resource_sha256 = SMALL31.resource.sha256
        self._validate_identity(manifest)
        self._validate_source(manifest)
        self._validate_totals(manifest, stages, require_complete=True)
        self.validate_complete()

    def tensor(self, role: int, layer: int = 0, parameter: str = "layer") -> TensorRecord:
        if isinstance(role, bool) or not isinstance(role, int):
            raise TypeError("role must be an int")
        raw_block = self.spec.raw_for_role(role)
        name = f"block{raw_block}.layer{layer}.{parameter}"
        try:
            return self.records[name]
        except KeyError as exc:
            raise ValueError(f"role {role} (raw block {raw_block}) has no record {name}") from exc

    def decode_block(self, role: int) -> dict[str, torch.Tensor]:
        return WeightArchive.decode_block(self, role)


class SmallCheckpoint(SmallNativeCheckpoint):
    """Self-contained CPU owner for one validated Small31 format-3 payload.

    Original record payloads keep the native dtype state lazily decoded in
    memory.  Learned FP16 payloads own their state tensors and reject any FP8
    kernel/plan request before the CUDA extension is loaded or records are
    consulted.
    """

    model = MODEL_ID

    def __init__(self, payload):
        if not isinstance(payload, dict):
            raise TypeError("SmallCheckpoint payload must be a dict")
        if payload.get("format_version") != FORMAT_VERSION:
            raise ValueError(
                f"Expected DLSSNR Small31 checkpoint format {FORMAT_VERSION}, "
                f"got {payload.get('format_version')!r}")
        if payload.get("model") != MODEL_ID:
            raise ValueError(
                f"Small31 checkpoint declares model {payload.get('model')!r}, expected {MODEL_ID!r}")
        if payload.get("model_class") != MODEL_CLASS:
            raise ValueError(f"Small31 checkpoint model_class must be {MODEL_CLASS!r}")
        precision = payload.get("weight_precision")
        if precision not in ("fp8", "fp16"):
            raise ValueError("Small31 checkpoint precision must be fp8 or fp16")
        storage = payload.get("storage")
        expected_storage = NATIVE_STORAGE if precision == "fp8" else STATE_STORAGE
        if storage != expected_storage:
            raise ValueError(
                f"Small31 {precision} checkpoint storage must be {expected_storage!r}, "
                f"got {storage!r}")
        identity = payload.get("model_identity")
        canonical = canonical_small_identity()
        if not isinstance(identity, dict) or identity != canonical:
            raise ValueError("Small31 checkpoint model identity differs from the canonical identity")

        metadata = payload.get("metadata")
        if not isinstance(metadata, dict):
            raise TypeError("Small31 checkpoint metadata must be a dict")
        state = payload.get("state_dict")
        native_records = payload.get("native_records")
        if not isinstance(state, dict):
            raise TypeError("Small31 checkpoint state_dict must be a dict")
        if not isinstance(native_records, dict):
            raise TypeError("Small31 checkpoint native_records must be a dict")

        self.precision = precision
        self.spec = SMALL31
        self.metadata = metadata
        self._state = None

        if precision == "fp8":
            if state:
                raise ValueError(
                    "Original Small31 checkpoint must not duplicate decoded state tensors")
            self.archive = self._validated_portable_archive(native_records, metadata)
            self.manifest_sha256 = self.archive.manifest_sha256
            self.dll_sha256 = self.archive.dll_sha256
        else:
            if native_records:
                raise ValueError(
                    "Trained FP16 Small31 checkpoint must not carry original FP8 records; "
                    "there is no stale-record deployment fallback")
            self._state = self._validated_state(state)
            self.archive = None
            self.manifest_sha256 = str(metadata.get("archive_manifest_sha256", ""))
            self.dll_sha256 = canonical["sourceDllSha256"]

    @staticmethod
    def _validated_state(state: dict) -> dict[str, torch.Tensor]:
        schema = small31_state_schema()
        if set(state) != set(schema):
            missing = sorted(set(schema) - set(state))
            extra = sorted(set(state) - set(schema))
            raise ValueError(
                f"Small31 checkpoint tensor roster differs from the model schema: "
                f"missing={missing}, extra={extra}")
        for name, expected in schema.items():
            actual = state[name]
            target = torch.float16 if expected.dtype == torch.float8_e4m3fn else expected.dtype
            if (not isinstance(actual, torch.Tensor) or tuple(actual.shape) != tuple(expected.shape)
                    or actual.dtype != target or actual.device.type != "cpu"
                    or not actual.is_contiguous()):
                raise ValueError("Small31 checkpoint tensor shape/dtype/storage differs: " + name)
            if not torch.isfinite(actual.float()).all().item():
                raise ValueError("Nonfinite Small31 checkpoint tensor: " + name)
        return state

    @staticmethod
    def _validated_portable_archive(native_records: dict, metadata: dict) -> _PortableRecordArchive:
        roster = {record.name: record for record in SMALL31.records}
        if set(native_records) != set(roster):
            missing = sorted(set(roster) - set(native_records))
            extra = sorted(set(native_records) - set(roster))
            raise ValueError(
                f"Small31 native record roster differs: missing={missing}, extra={extra}")
        record_hashes = metadata.get("native_record_sha256")
        if not isinstance(record_hashes, dict) or set(record_hashes) != set(roster):
            raise ValueError("Small31 metadata native_record_sha256 roster differs from the model")
        source_dll = metadata.get("source_dll_sha256")
        if source_dll != canonical_small_identity()["sourceDllSha256"]:
            raise ValueError("Small31 metadata source DLL hash differs from the signed canonical pin")
        archive_manifest = metadata.get("archive_manifest")
        if not isinstance(archive_manifest, dict):
            raise TypeError("Small31 metadata archive_manifest must be a dict")
        manifest_sha256 = metadata.get("archive_manifest_sha256")
        if not isinstance(manifest_sha256, str) or len(manifest_sha256) != 64:
            raise ValueError("Small31 metadata archive_manifest_sha256 is not a SHA-256")

        records: dict[str, TensorRecord] = {}
        record_bytes: dict[str, bytes] = {}
        for name, record in roster.items():
            data = _record_bytes(native_records[name], name, record.byte_length)
            digest = hashlib.sha256(data).hexdigest()
            if record_hashes[name] != digest:
                raise ValueError("Small31 native record hash mismatch: " + name)
            record_bytes[name] = data
        stages = _stage_payloads(record_bytes)
        del record_bytes
        canonical = SMALL31.stage_record_offsets()
        for name, record in roster.items():
            offset = canonical[record.stage][name]
            data = memoryview(stages[record.stage])[offset:offset + record.byte_length]
            if len(data) != record.byte_length:
                raise ValueError("Small31 record does not fit its canonical stage span: " + name)
            records[name] = TensorRecord(
                name=name,
                block=record.raw_block,
                layer=record.layer,
                parameter=record.parameter,
                stage=record.stage,
                stage_offset=offset,
                data=data,
            )
        if sum(len(data) for data in stages.values()) != SMALL31.payload_bytes:
            raise ValueError("Small31 native records do not cover the canonical payload total")
        return _PortableRecordArchive(
            records, archive_manifest, stages, manifest_sha256, source_dll)

    # -- Checkpoint-compatible surface -------------------------------------

    def _ensure_state(self):
        if self.precision == "fp16":
            return self._state
        return super()._ensure_state()

    def decode_block(self, role: int):
        """Decode one operation role to natural float32 tensors.

        This matches the proven :class:`SmallWeightArchive` training decode: the
        state is stored as checkpoint ``[out, in]`` matrices, and the returned
        matrices are natural ``[in, out]`` float32 values.  No kernel is chosen.
        """
        if isinstance(role, bool) or not isinstance(role, int) or not self.spec.has_role(role):
            raise ValueError(f"role {role!r} is not present in Small31")
        prefix = f"blocks.{role}."
        result: dict[str, torch.Tensor] = {}
        for name, value in self._ensure_state().items():
            if not name.startswith(prefix):
                continue
            field = name[len(prefix):]
            promoted = promote_tensor(value, torch.float32)
            if field in MATRIX_FIELDS:
                promoted = promoted.transpose(-1, -2).contiguous()
            result[field] = promoted
        if not result:
            raise ValueError(f"Small31 role {role} decoded no learned tensors")
        return result

    def blend_scale(self) -> torch.Tensor:
        """Return the blend scalar from the current state, never an archive copy."""
        value = self._ensure_state().get(f"blocks.{self.spec.post_role}.blend_scale")
        if value is None:
            raise ValueError("Small31 checkpoint state has no post blend scalar")
        value = promote_tensor(value, torch.float32).reshape(-1)
        if value.numel() != 1 or not torch.isfinite(value).all().item():
            raise ValueError("Small31 post blend scalar is invalid")
        return value

    # -- Deployment records ------------------------------------------------

    def kernel_record(self, role: int, *, kind="window", precision=None, device="cpu"):
        """Reject FP8 requests for learned FP16 state before records/CUDA."""
        target = self.precision if precision is None else precision
        if self.precision == "fp16" and target == "fp8":
            raise ValueError(
                "Trained FP16 Small31 checkpoint has no original FP8 records; "
                "FP16 to FP8 requires explicit quantization")
        return super().kernel_record(role, kind=kind, precision=precision, device=device)

    def create_plan_fp8(self, state, *, width=3840, height=2160):
        """Reject FP8 deployment for state-only learned FP16 checkpoints."""
        if self.precision != "fp8":
            raise ValueError(
                "Trained FP16 Small31 checkpoint has no original FP8 records; "
                "there is no stale-record deployment fallback")
        return super().create_plan_fp8(state, width=width, height=height)

    # -- Training ----------------------------------------------------------

    def training_model(self, *, device="cpu", precision="fp32", checkpoint_blocks=False,
                       trainable=True):
        """Build a Small31 training graph from independent cloned FP32 masters."""
        from .small_model import SmallDLSSNR

        state = self.state_dict(dtype=torch.float32)
        _spec = self.spec
        _manifest_sha256 = self.manifest_sha256
        _dll_sha256 = self.dll_sha256

        class DecodedArchive:
            spec = _spec
            manifest_sha256 = _manifest_sha256
            dll_sha256 = _dll_sha256

            def validate_complete(self):
                # SmallCheckpoint already validated names, shapes, dtypes and
                # the native records/stage pins.
                pass

            def decode_block(self, role):
                prefix = f"blocks.{role}."
                result = {}
                for name, value in state.items():
                    if not name.startswith(prefix):
                        continue
                    field = name[len(prefix):]
                    natural = value.transpose(-1, -2).contiguous() if field in MATRIX_FIELDS else value
                    result[field] = natural
                return result

        return SmallDLSSNR(DecodedArchive(), precision=precision, trainable=trainable,
                           checkpoint_blocks=checkpoint_blocks).to(device=device)


def _payload_owner(payload: dict):
    """Validate one payload through its owning checkpoint class and label it."""
    if not isinstance(payload, dict):
        raise TypeError("checkpoint payload must be a dict")
    version = payload.get("format_version")
    declared = payload.get("model")
    if version == FORMAT_VERSION:
        if declared != MODEL_ID:
            raise ValueError(
                f"format {FORMAT_VERSION} checkpoint declares model {declared!r}, "
                f"expected {MODEL_ID!r}")
        SmallCheckpoint(payload)
        return MODEL_ID
    if version == 2:
        if declared is not None and declared != "legacy71":
            raise ValueError(
                f"format 2 checkpoint declares model {declared!r}, expected 'legacy71'")
        Checkpoint(payload)
        return "legacy71"
    raise ValueError(
        f"unsupported checkpoint format_version {version!r}; expected 2 (legacy71) or 3 (small31)")


def save_checkpoint_payload(payload, path, *, overwrite=False):
    """Validate and atomically write one checkpoint plus its adjacent JSON receipt.

    The payload is validated by its owning class before any file is created.
    Both temporary files are created in the destination directory and atomically
    replaced only after they are complete.  Only this call's own temporary files
    are removed on failure; existing user files are never touched unless
    ``overwrite=True``.  The JSON sidecar is the established
    ``path.with_suffix('.json')`` convention and may later receive additional
    extraction provenance.
    """
    if not isinstance(overwrite, bool):
        raise TypeError("overwrite must be a bool")
    model = _payload_owner(payload)

    path = Path(path)
    sidecar = path.with_suffix(".json")
    if path.suffix.lower() == ".json" or os.path.normcase(os.path.abspath(path)) == os.path.normcase(
            os.path.abspath(sidecar)):
        raise ValueError(
            f"checkpoint path collides with its JSON sidecar: {path}")
    parent = path.parent if path.parent != Path("") else Path(".")
    if not parent.is_dir():
        raise FileNotFoundError(f"checkpoint destination directory does not exist: {parent}")
    if path.exists() and path.is_dir():
        raise IsADirectoryError(f"checkpoint path is a directory: {path}")
    if sidecar.exists() and sidecar.is_dir():
        raise IsADirectoryError(f"checkpoint sidecar path is a directory: {sidecar}")
    if not overwrite:
        if path.exists() or path.is_symlink():
            raise FileExistsError(
                f"checkpoint already exists: {path} (pass overwrite=True to replace it)")
        if sidecar.exists() or sidecar.is_symlink():
            raise FileExistsError(
                f"checkpoint sidecar already exists: {sidecar} (pass overwrite=True to replace it)")

    precision = payload.get("weight_precision")
    storage = payload.get("storage")
    if storage is None:
        storage = NATIVE_STORAGE if precision == "fp8" else STATE_STORAGE
    version = payload.get("format_version")

    payload_temp = sidecar_temp = None
    try:
        fd, name = tempfile.mkstemp(dir=parent, prefix=f".{path.name}.", suffix=".tmp")
        payload_temp = Path(name)
        with os.fdopen(fd, "wb") as stream:
            torch.save(payload, stream)
            stream.flush()
            os.fsync(stream.fileno())
        digest = file_sha256(payload_temp)
        byte_length = payload_temp.stat().st_size

        receipt = {
            "path": str(path),
            "sidecar": str(sidecar),
            "sha256": digest,
            "byte_length": byte_length,
            "model": model,
            "format_version": version,
            "weight_precision": precision,
            "storage": storage,
        }
        sidecar_payload = dict(receipt)
        sidecar_payload["file"] = path.name
        sidecar_payload["bytes"] = byte_length

        fd, name = tempfile.mkstemp(dir=parent, prefix=f".{sidecar.name}.", suffix=".tmp")
        sidecar_temp = Path(name)
        with os.fdopen(fd, "w", encoding="utf-8") as stream:
            json.dump(sidecar_payload, stream, indent=2, sort_keys=True)
            stream.write("\n")
            stream.flush()
            os.fsync(stream.fileno())

        os.replace(payload_temp, path)
        payload_temp = None
        os.replace(sidecar_temp, sidecar)
        sidecar_temp = None
        return receipt
    finally:
        for temporary in (payload_temp, sidecar_temp):
            if temporary is not None:
                try:
                    temporary.unlink()
                except FileNotFoundError:
                    pass
