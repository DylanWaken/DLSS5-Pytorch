"""Focused CPU checks for the versioned runtime extractor and model identities.

These tests use synthetic PE/envelope fixtures for the complete extraction path
and, when present, the local original 310.8 DLL for real PE discovery.  They do
not load or execute any DLL, do not use a GPU, and do not require the 310.9.16
artifact to be present.
"""
from __future__ import annotations

from dataclasses import replace
import json
import os
from pathlib import Path
import struct

import pytest

from dlssnr.model_specs import (
    DllPin,
    LEGACY71,
    SMALL31,
    ResourcePin,
    StagePin,
    StageSpec,
    make_model_spec,
    resolve_model,
)
from dlssnr.runtime_assets import (
    AssetIdentityError,
    ManifestError,
    PeImage,
    ResourceFormatError,
    extract_model,
    find_pe_resource,
    parse_envelope,
    sha256_bytes,
    validate_dll_identity,
    validate_manifest_tensors,
    validate_records,
    verify_stage_pins,
)


# ---------------------------------------------------------------------------
# Fixture builders


def _envelope(records, *, rank_override=None, device_override=None, tails_override=None):
    """Build a structurally valid bounded envelope.

    ``records`` items are ``(name, payload_bytes)``.  Rank-1 dimensions default
    to ``[len(payload)//2]`` and the device code defaults to 1.
    """
    body = bytearray()
    for name, payload in records:
        name_bytes = name.encode("utf-8")
        rank = 1 if rank_override is None else rank_override
        dims = [len(payload) // 2] if rank == 1 else [1, len(payload) // 2]
        device = 1 if device_override is None else device_override
        tails = (0, 0) if tails_override is None else tails_override
        record_size = 20 + len(payload) + 16 + rank * 4
        body += struct.pack("<Q", len(name_bytes))
        body += name_bytes
        body += struct.pack("<Q", record_size)
        body += struct.pack("<Q", record_size)
        body += struct.pack("<Q", len(payload))
        body += struct.pack("<I", device)
        body += payload
        body += struct.pack("<II", *tails)
        body += struct.pack("<Q", rank)
        body += b"".join(struct.pack("<I", dimension) for dimension in dims)
    total = 8 + len(body)
    return struct.pack("<Q", total) + bytes(body)


def _small_tensor(name, raw_block, stage, offset, length, **overrides):
    entry = {
        "name": name,
        "block": raw_block,
        "rawBlock": raw_block,
        "role": SMALL31.role_for_raw(raw_block),
        "layer": 0,
        "parameter": "blend_scale" if name.endswith(".blend_scale") else "layer",
        "stage": stage,
        "stageOffset": offset,
        "byteLength": length,
        "deviceCode": 1,
        "storageDimensions": [length // 2],
        "tailFields": [0, 0],
        "sha256": "0" * 64,
    }
    entry.update(overrides)
    return entry


def _base_small_manifest(stage_entries, tensor_entries, *, totals=None):
    model = {
        "id": "small31",
        "blockCount": SMALL31.block_count,
        "roles": list(SMALL31.roles),
        "rawToRole": list(SMALL31.raw_to_role),
        "preRole": SMALL31.pre_role,
        "postRole": SMALL31.post_role,
        "postPhaseDefault": SMALL31.post_phase_default,
        "postHead": {
            "offset": SMALL31.post_head.offset,
            "byteLength": SMALL31.post_head.byte_length,
            "storageShape": list(SMALL31.post_head.storage_shape),
            "rowBits": list(SMALL31.post_head.row_bits),
            "columnBits": list(SMALL31.post_head.column_bits),
            "usedRows": list(SMALL31.post_head.used_rows),
            "nativeShape": list(SMALL31.post_head.native_shape),
            "historyRow": SMALL31.post_head.history_row,
            "historyByteLength": SMALL31.post_head.history_byte_length,
        },
    }
    source = {
        "dllFileName": "fixture.dll",
        "dllSha256": SMALL31.dll_pins[0].sha256,
        "dllByteLength": SMALL31.dll_pins[0].byte_length,
        "runtimeExecuted": False,
        "networkUsed": False,
        "resource": {
            "path": SMALL31.resource.path,
            "sha256": SMALL31.resource.sha256,
            "byteLength": SMALL31.resource.byte_length,
        },
    }
    payload_total = sum(stage["packedByteLength"] for stage in stage_entries)
    default_totals = {
        "blockCount": SMALL31.block_count,
        "roleCount": len(SMALL31.roles),
        "tensorCount": len(tensor_entries),
        "stageCount": len(stage_entries),
        "packedByteLength": payload_total,
        "resourceByteLength": SMALL31.resource.byte_length,
        "envelopeOverheadBytes": SMALL31.resource.byte_length - SMALL31.payload_bytes,
    }
    if totals:
        default_totals.update(totals)
    return {
        "schemaVersion": 2,
        "format": "dlssnr-runtime-assets",
        "model": model,
        "source": source,
        "totals": default_totals,
        "stages": stage_entries,
        "tensors": tensor_entries,
    }


def _write_small_archive(tmp_path: Path, manifest: dict, stage_payloads: dict[str, bytes]) -> Path:
    directory = tmp_path / "small-archive"
    model_dir = directory / "model" / "stages"
    model_dir.mkdir(parents=True)
    for stage in manifest["stages"]:
        payload = stage_payloads[stage["id"]]
        stage["packedByteLength"] = len(payload)
        stage["sha256"] = sha256_bytes(payload)
        (directory / "model" / stage["file"]).parent.mkdir(parents=True, exist_ok=True)
        (directory / "model" / stage["file"]).write_bytes(payload)
    for tensor in manifest["tensors"]:
        payload = stage_payloads[tensor["stage"]][tensor["stageOffset"]:tensor["stageOffset"] + tensor["byteLength"]]
        tensor["sha256"] = sha256_bytes(payload)
    manifest["totals"]["tensorCount"] = len(manifest["tensors"])
    manifest["totals"]["stageCount"] = len(manifest["stages"])
    manifest["totals"]["packedByteLength"] = sum(len(data) for data in stage_payloads.values())
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    return directory


def _post_only_small_archive(tmp_path: Path) -> Path:
    from dlssnr.model_specs import SMALL31 as spec

    post_layer = bytearray(21808)
    # The source-derived head lives at offset 20784 in the post record.
    post_layer[20784:20784 + 1024] = struct.pack("<512e", *range(512))
    stage_payload = b"\x00\x00" + bytes(post_layer)
    stage = {
        "id": "decoder32",
        "kind": "decoder",
        "file": "stages/decoder32.bin",
        "roles": [66, 69, 70],
        "rawBlocks": [30],
        "recordCount": 2,
        "packedByteLength": 0,
        "sha256": "0" * 64,
    }
    tensors = [
        _small_tensor("block30.layer0.blend_scale", 30, "decoder32", 0, 2),
        _small_tensor("block30.layer0.layer", 30, "decoder32", 2, 21808),
    ]
    del spec
    return _write_small_archive(tmp_path, _base_small_manifest([stage], tensors), {"decoder32": stage_payload})


def _full_small_tensors() -> list[dict]:
    canonical = SMALL31.stage_record_offsets()
    entries = []
    for record in SMALL31.records:
        entries.append({
            "name": record.name,
            "block": record.raw_block,
            "rawBlock": record.raw_block,
            "role": record.role,
            "layer": record.layer,
            "parameter": record.parameter,
            "stage": record.stage,
            "stageOffset": canonical[record.stage][record.name],
            "byteLength": record.byte_length,
            "deviceCode": 1,
            "storageDimensions": [record.byte_length // 2],
            "tailFields": [0, 0],
            "sha256": "0" * 64,
        })
    return entries


def _fixture_spec(envelope: bytes, pe_bytes: bytes, *, roles=(0, 4), raw=(0, 4)):
    payload = sum(record.byte_length for role in roles for record in LEGACY71.records_for_role(role))
    stages = []
    for role in roles:
        stages.append(StageSpec(f"stage-{role}", "pre" if role == 0 else "encoder", (role,)))
    spec = make_model_spec(
        id="fixture",
        display_name="fixture",
        runtime_version="test",
        resource=ResourcePin(
            type_id=10,
            name="WEIGHTS_HT",
            language=1033,
            byte_length=len(envelope),
            sha256=sha256_bytes(envelope),
            record_count=len(roles),
            payload_bytes=payload,
        ),
        dll_pins=(DllPin("test", sha256_bytes(pe_bytes), len(pe_bytes)),),
        roles=roles,
        raw_to_role=raw,
        stages=stages,
        pre_role=0,
        post_role=roles[-1],
        role_phases=(),
    )
    return spec


def _make_pe(resource_data: bytes, *, type_id: int = 10, name: str = "WEIGHTS_HT", language: int = 1033) -> bytes:
    """Build a minimal PE32+ image with a single type/name/language resource."""
    resource_base_rva = 0x1000
    resource = bytearray(0x1000 + len(resource_data))
    struct.pack_into("<IIHHHH", resource, 0x00, 0, 0, 0, 0, 0, 1)
    struct.pack_into("<II", resource, 0x10, type_id, 0x80000020)
    struct.pack_into("<IIHHHH", resource, 0x20, 0, 0, 0, 0, 0, 1)
    struct.pack_into("<II", resource, 0x30, 0x800000A0, 0x80000050)
    struct.pack_into("<IIHHHH", resource, 0x50, 0, 0, 0, 0, 0, 1)
    struct.pack_into("<II", resource, 0x60, language, 0x80)
    struct.pack_into("<IIII", resource, 0x80, resource_base_rva + 0x1000, len(resource_data), 0, 0)
    encoded = name.encode("utf-16-le")
    struct.pack_into("<H", resource, 0xA0, len(name))
    resource[0xA2:0xA2 + len(encoded)] = encoded
    resource[0x1000:] = resource_data

    e_lfanew, optional_size, raw_pointer = 0x80, 0xF0, 0x200
    raw_size = (len(resource) + 0x1FF) // 0x200 * 0x200
    image = bytearray(raw_pointer + raw_size)
    image[0:2] = b"MZ"
    struct.pack_into("<I", image, 0x3C, e_lfanew)
    image[e_lfanew:e_lfanew + 4] = b"PE\0\0"
    struct.pack_into("<HHIIIHH", image, e_lfanew + 4, 0x8664, 1, 0, 0, 0, optional_size, 0x2022)
    optional = e_lfanew + 24
    struct.pack_into("<H", image, optional, 0x20B)
    struct.pack_into("<I", image, optional + 108, 16)
    struct.pack_into("<II", image, optional + 112 + 16, resource_base_rva, len(resource))
    section = optional + optional_size
    image[section:section + 8] = b".rsrc\0\0\0"
    struct.pack_into("<IIII", image, section + 8, len(resource), resource_base_rva, raw_size, raw_pointer)
    image[raw_pointer:raw_pointer + len(resource)] = resource
    return bytes(image)


# ---------------------------------------------------------------------------
# Identity and mapping tests


def test_known_model_pins_and_explicit_resolver():
    assert resolve_model("legacy71") is LEGACY71
    assert resolve_model("small31") is SMALL31
    for name in ("small", "31", "small_31", ""):
        with pytest.raises(ValueError):
            resolve_model(name)
    with pytest.raises(TypeError):
        resolve_model(None)  # type: ignore[arg-type]

    assert LEGACY71.resource.sha256 == "836f445d06ecd2e59bb9f17b84b91c143396fd76ccda1c9dc7fe81d5edd548f4"
    assert LEGACY71.resource.byte_length == 147_695_410
    assert SMALL31.resource.sha256 == "f743e8eb320f42bc9bdc992ee2bf51f7bb7c8688ced4ecf5ce6807ec4eef7962"
    assert SMALL31.resource.byte_length == 113_893_343
    assert [pin.version for pin in LEGACY71.dll_pins] == ["310.8.0.0", "310.9.16.0"]
    assert [pin.version for pin in SMALL31.dll_pins] == ["310.9.16.0"]
    assert SMALL31.runtime_version == "310.9.16.0"
    assert LEGACY71.raw_to_role == tuple(range(71))


def test_small_roster_maps_77_raw_records_to_31_roles():
    assert SMALL31.block_count == 31
    assert SMALL31.record_count == 77
    assert SMALL31.payload_bytes == 113_887_490
    assert len(SMALL31.roles) == 31
    assert set(record.raw_block for record in SMALL31.records) == set(range(31))
    assert set(record.role for record in SMALL31.records) == set(SMALL31.roles)
    assert len({record.name for record in SMALL31.records}) == 77
    for role in SMALL31.roles:
        raw = SMALL31.raw_for_role(role)
        assert SMALL31.role_for_raw(raw) == role
        assert SMALL31.records_for_role(role)

    # This is the critical renumbering check: raw block 2 is legacy role 4
    # (22720 bytes), not legacy role 2 (20672 bytes).
    collision = SMALL31.record_spec("block2.layer0.layer")
    assert (collision.raw_block, collision.role, collision.byte_length) == (2, 4, 22_720)
    assert SMALL31.record_spec("block4.layer0.layer").byte_length == 69_936  # role 8
    assert SMALL31.record_spec("block10.layer4.layer").role == 30
    assert SMALL31.record_spec("block10.layer4.layer").byte_length == 524_304
    assert SMALL31.record_spec("block19.layer0.layer").role == 39
    assert SMALL31.record_spec("block19.layer0.layer").byte_length == 525_312
    assert SMALL31.record_spec("block30.layer0.layer").role == 70
    assert SMALL31.record_spec("block30.layer0.layer").byte_length == 21_808
    assert SMALL31.record_spec("block30.layer0.blend_scale").byte_length == 2


def test_small_stages_phases_and_skip_identity():
    assert [stage.id for stage in SMALL31.stages] == [
        "encoder32", "encoder64", "encoder128", "encoder256", "encoder512",
        "vit1024", "decoder512", "decoder256", "decoder128", "decoder64", "decoder32",
    ]
    assert SMALL31.stage_for_role(0).id == "encoder32"
    assert SMALL31.stage_for_role(4).id == "encoder32"
    assert SMALL31.stage_for_role(30).id == "encoder512"
    assert SMALL31.stage_for_role(39).id == "decoder512"
    assert SMALL31.stage_for_role(70).id == "decoder32"
    assert SMALL31.transition_role == 39
    assert SMALL31.post_head.used_rows == (0, 2, 4, 6)
    assert SMALL31.post_head.native_shape == (4, 32)
    assert SMALL31.post_head.history_row == 6
    assert SMALL31.post_head.history_byte_length == 64
    assert SMALL31.post_head.offset == 20784
    assert SMALL31.post_head.offset + SMALL31.post_head.byte_length == 21808
    assert len(SMALL31.stage_pins) == 11
    assert SMALL31.phase_for_role(0) == 0
    assert SMALL31.phase_for_role(1) == 0
    assert SMALL31.phase_for_role(4) == 1
    assert SMALL31.phase_for_role(8) == 1
    assert SMALL31.phase_for_role(14) == 1
    assert SMALL31.phase_for_role(22) == 1
    assert SMALL31.phase_for_role(30) == 1
    assert SMALL31.phase_for_role(40) == 2
    assert SMALL31.phase_for_role(47) == 3
    assert SMALL31.phase_for_role(48) == 2
    assert SMALL31.phase_for_role(55) == 3
    assert SMALL31.phase_for_role(56) == 2
    assert SMALL31.phase_for_role(61) == 3
    assert SMALL31.phase_for_role(62) == 2
    assert SMALL31.phase_for_role(65) == 3
    assert SMALL31.phase_for_role(66) == 2
    assert SMALL31.phase_for_role(69) == 3
    assert SMALL31.phase_for_role(70) == 0
    for role in range(31, 39):
        assert SMALL31.phase_for_role(role) is None
    assert SMALL31.phase_for_role(39) is None
    assert SMALL31.shift_mask_for_role(4) == 3
    assert SMALL31.shift_mask_for_role(40) == 1
    assert SMALL31.shift_mask_for_role(47) == 2
    assert SMALL31.shift_mask_for_role(31) is None
    assert "source-derived" in SMALL31.phase_provenance.lower()


# ---------------------------------------------------------------------------
# Bounded envelope and roster validation


def test_bounded_envelope_roundtrip_and_rejections():
    data = _envelope([
        ("block0.layer0.layer", b"\x00" * 21_696),
        ("block10.layer4.layer", b"\x00" * 524_304),
    ])
    parsed = parse_envelope(data)
    assert len(parsed.records) == 2
    assert parsed.payload_bytes == 21_696 + 524_304
    assert parsed.overhead_bytes == len(data) - parsed.payload_bytes
    assert parsed.records[0].storage_dimensions == (10_848,)
    assert parsed.records[0].device_code == 1
    assert parsed.records[0].tail_fields == (0, 0)

    bad = bytearray(data)
    bad[0] ^= 1
    with pytest.raises(ResourceFormatError):
        parse_envelope(bad)

    with pytest.raises(ResourceFormatError):
        parse_envelope(_envelope([("block0.layer0.layer", b"\x00" * 2), ("block0.layer0.layer", b"\x00" * 2)]))
    with pytest.raises(ResourceFormatError):
        parse_envelope(_envelope([("../escape", b"\x00" * 2)]))
    # device_override=2 parses structurally; metadata is rejected by roster validation.
    parsed_device = parse_envelope(_envelope([("block0.layer0.layer", b"\x00" * 2)], device_override=2))
    assert parsed_device.records[0].device_code == 2

    # Locate the record self-size field and corrupt it.
    name_length = struct.unpack_from("<Q", data, 8)[0]
    self_size_offset = 8 + 8 + name_length + 8
    corrupted = bytearray(data)
    struct.pack_into("<Q", corrupted, self_size_offset, parsed.records[0].byte_length)
    with pytest.raises(ResourceFormatError):
        parse_envelope(corrupted)

    # Rank says 2 but the metadata has only one dimension.
    rank_offset = self_size_offset + 20 + parsed.records[0].byte_length + 8
    bad_rank = bytearray(data)
    struct.pack_into("<Q", bad_rank, rank_offset, 2)
    with pytest.raises(ResourceFormatError):
        parse_envelope(bad_rank)

    # Payload length that runs past the record end.
    oversized = bytearray(data)
    payload_size_offset = self_size_offset + 8
    struct.pack_into("<Q", oversized, payload_size_offset, 1 << 30)
    with pytest.raises(ResourceFormatError):
        parse_envelope(oversized)


def test_full_small_manifest_roster_is_strict():
    tensors = _full_small_tensors()
    validate_manifest_tensors(SMALL31, tensors, require_complete=True)

    wrong_size = json.loads(json.dumps(tensors))
    next(item for item in wrong_size if item["name"] == "block2.layer0.layer")["byteLength"] = 20_672
    with pytest.raises(ManifestError):
        validate_manifest_tensors(SMALL31, wrong_size, require_complete=True)

    wrong_role = json.loads(json.dumps(tensors))
    next(item for item in wrong_role if item["name"] == "block2.layer0.layer")["role"] = 2
    with pytest.raises(ManifestError):
        validate_manifest_tensors(SMALL31, wrong_role, require_complete=True)

    missing = json.loads(json.dumps(tensors))[:-1]
    with pytest.raises(ManifestError):
        validate_manifest_tensors(SMALL31, missing, require_complete=True)

    duplicate = json.loads(json.dumps(tensors))
    duplicate[1]["name"] = duplicate[0]["name"]
    with pytest.raises(ManifestError):
        validate_manifest_tensors(SMALL31, duplicate, require_complete=True)

    unexpected = json.loads(json.dumps(tensors))
    unexpected[-1]["name"] = "block31.layer0.layer"
    with pytest.raises(ManifestError):
        validate_manifest_tensors(SMALL31, unexpected, require_complete=True)

    for field, value in (("deviceCode", 2), ("storageDimensions", [1]), ("tailFields", [1, 0])):
        broken = json.loads(json.dumps(tensors))
        broken[0][field] = value
        with pytest.raises(ManifestError):
            validate_manifest_tensors(SMALL31, broken, require_complete=True)


def test_validate_records_uses_role_mapped_sizes_and_metadata():
    records = [
        ("block0.layer0.layer", b"\x00" * 21_696),
        ("block1.layer0.layer", b"\x00" * 22_720),
    ]
    envelope = _envelope(records)
    pe = _make_pe(envelope)
    spec = _fixture_spec(envelope, pe)
    parsed = parse_envelope(envelope)
    validate_records(spec, parsed)

    wrong = parse_envelope(_envelope([
        ("block0.layer0.layer", b"\x00" * 21_696),
        ("block1.layer0.layer", b"\x00" * 20_672),
    ]))
    with pytest.raises(AssetIdentityError):
        validate_records(spec, wrong)

    bad_meta = parse_envelope(_envelope(records, device_override=2))
    with pytest.raises(AssetIdentityError):
        validate_records(spec, bad_meta)

    bad_tail = parse_envelope(_envelope(records, tails_override=(1, 0)))
    with pytest.raises(AssetIdentityError):
        validate_records(spec, bad_tail)

    wrong_resource = replace(spec, resource=replace(spec.resource, byte_length=len(envelope) + 1))
    with pytest.raises(AssetIdentityError):
        validate_records(wrong_resource, parse_envelope(envelope))


# ---------------------------------------------------------------------------
# Small archive strictness


def test_small_archive_role_view_and_strict_rejections(tmp_path):
    from dlssnr.small_model import SmallWeightArchive

    archive = SmallWeightArchive(_post_only_small_archive(tmp_path), require_complete=False)
    assert archive.tensor(70).name == "block30.layer0.layer"
    assert archive.tensor(70, parameter="blend_scale").name == "block30.layer0.blend_scale"
    with pytest.raises(ValueError):
        archive.tensor(2)  # raw id 2 is not an operation role
    assert archive.record_for_raw(30).name == "block30.layer0.layer"
    assert archive.manifest_sha256 == sha256_bytes((tmp_path / "small-archive" / "manifest.json").read_bytes())

    with pytest.raises(ManifestError):
        SmallWeightArchive(tmp_path / "small-archive", require_complete=True)

    # Wrong stage hash.
    directory = _post_only_small_archive(tmp_path / "hash")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["stages"][0]["sha256"] = "f" * 64
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)

    # Path escape.
    directory = _post_only_small_archive(tmp_path / "escape")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["stages"][0]["file"] = "../escape.bin"
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)

    # Duplicate stage file.
    directory = _post_only_small_archive(tmp_path / "dupe")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["stages"].append(dict(manifest["stages"][0], id="encoder32"))
    manifest["tensors"][0]["name"] = "block1.layer0.layer"
    manifest["tensors"][0]["block"] = 1
    manifest["tensors"][0]["rawBlock"] = 1
    manifest["tensors"][0]["role"] = 1
    manifest["tensors"][0]["stage"] = "encoder32"
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)

    # Cross-model identity and wrong source pins.
    directory = _post_only_small_archive(tmp_path / "legacy")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["model"]["id"] = "legacy71"
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)

    directory = _post_only_small_archive(tmp_path / "dll")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["source"]["dllSha256"] = LEGACY71.dll_pins[0].sha256
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)


def test_small_archive_rejects_overlap_size_and_duplicate_names(tmp_path):
    from dlssnr.small_model import SmallWeightArchive

    # Overlap: both records claim offset 0 in one stage.
    stage_payload = b"\x00" * (20_672 + 22_720)
    stage = {
        "id": "encoder32", "kind": "encoder", "file": "stages/encoder32.bin",
        "roles": [1, 4], "rawBlocks": [1, 2], "recordCount": 2,
        "packedByteLength": len(stage_payload), "sha256": "0" * 64,
    }
    tensors = [
        _small_tensor("block1.layer0.layer", 1, "encoder32", 0, 20_672),
        _small_tensor("block2.layer0.layer", 2, "encoder32", 0, 22_720),
    ]
    directory = _write_small_archive(tmp_path / "overlap", _base_small_manifest([stage], tensors),
                                    {"encoder32": stage_payload})
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)

    # Wrong size.
    directory = _post_only_small_archive(tmp_path / "size")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["tensors"][1]["byteLength"] = 21_807
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)

    # Duplicate tensor name.
    directory = _post_only_small_archive(tmp_path / "names")
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["tensors"][1]["name"] = manifest["tensors"][0]["name"]
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(directory, require_complete=False)


# ---------------------------------------------------------------------------
# PE discovery and atomic extraction


def test_stage_pin_anchor_rejects_rehashed_equal_size_payload():
    payload = b"\x00" * 21_696
    envelope = _envelope([("block0.layer0.layer", payload)])
    pe = _make_pe(envelope)
    spec = _fixture_spec(envelope, pe, roles=(0,), raw=(0,))
    pinned = replace(spec, stage_pins=(StagePin("stage-0", len(payload), sha256_bytes(payload)),))
    verify_stage_pins(pinned, {"stage-0": payload})
    with pytest.raises(AssetIdentityError):
        verify_stage_pins(pinned, {"stage-0": payload[:-1] + b"\x01"})
    with pytest.raises(AssetIdentityError):
        verify_stage_pins(pinned, {"other-stage": payload})
    assert SMALL31.stage_pins[0].id == "encoder32"
    assert SMALL31.stage_pins[0].sha256 == "c6b7b9e2f51c1f7811627d12b682df7fbcde8800bb79d6ea701040c93ba78575"


def test_complete_archive_rejects_rehashed_payload_via_trusted_pins(tmp_path):
    """The default (complete) archive path must not trust editable manifest hashes.

    A pinned mini-identity keeps this cheap: the stage pin is the only remaining
    anchor once the tampered stage and every affected tensor entry are rehashed
    into an internally consistent manifest.
    """
    from dlssnr.small_model import SmallWeightArchive

    post_layer = bytearray(21808)
    post_layer[20784:20784 + 1024] = struct.pack("<512e", *range(512))
    stage_payload = b"\x00\x00" + bytes(post_layer)
    stage = {
        "id": "decoder32", "kind": "decoder", "file": "stages/decoder32.bin",
        "roles": [66, 69, 70], "rawBlocks": [28, 29, 30], "recordCount": 2,
        "packedByteLength": len(stage_payload), "sha256": "0" * 64,
    }
    tensors = [
        _small_tensor("block30.layer0.blend_scale", 30, "decoder32", 0, 2),
        _small_tensor("block30.layer0.layer", 30, "decoder32", 2, 21808),
    ]
    payload_bytes = len(stage_payload)
    mini_resource = replace(SMALL31.resource, record_count=2, payload_bytes=payload_bytes)
    mini_spec = replace(
        SMALL31,
        stages=(SMALL31.stages[-1],),
        records=tuple(record for record in SMALL31.records if record.role == 70),
        record_count=2,
        payload_bytes=payload_bytes,
        resource=mini_resource,
        stage_pins=(StagePin("decoder32", payload_bytes, sha256_bytes(stage_payload)),),
    )
    manifest = _base_small_manifest([stage], tensors, totals={
        "resourceByteLength": mini_resource.byte_length,
        "envelopeOverheadBytes": mini_resource.byte_length - payload_bytes,
    })
    manifest["model"].update(recordCount=2, payloadBytes=payload_bytes)
    directory = _write_small_archive(tmp_path, manifest, {"decoder32": stage_payload})
    archive = SmallWeightArchive(directory, spec=mini_spec)
    assert archive.tensor(70).name == "block30.layer0.layer"
    assert archive.decode_block(70)["head"].shape == (32, 4)

    # Tamper one byte, then rehash the stage file, its manifest stage entry and
    # every tensor entry so only the static trusted pin can detect the change.
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    tampered = bytearray(stage_payload)
    tampered[0] ^= 0x01
    stage_entry = manifest["stages"][0]
    (directory / "model" / stage_entry["file"]).write_bytes(bytes(tampered))
    stage_entry["sha256"] = sha256_bytes(tampered)
    for tensor in manifest["tensors"]:
        chunk = tampered[tensor["stageOffset"]:tensor["stageOffset"] + tensor["byteLength"]]
        tensor["sha256"] = sha256_bytes(chunk)
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError, match="trusted pin"):
        SmallWeightArchive(directory, spec=mini_spec)

    # Production model construction re-runs validate_complete, so the fixture
    # escape cannot bypass the trusted stage pins either.
    from dlssnr.small_model import SmallDLSSNR

    fixture_archive = SmallWeightArchive(directory, spec=mini_spec, require_complete=False)
    with pytest.raises(ManifestError, match="trusted pin"):
        SmallDLSSNR(fixture_archive)


def _offset_swap_fixture(tmp_path: Path):
    """Two equal-sized records inside one pinned stage, as in the review repro."""
    records = tuple(record for record in SMALL31.records
                    if record.name in ("block20.layer0.layer", "block21.layer0.layer"))
    assert len(records) == 2 and records[0].byte_length == records[1].byte_length
    stage_payload = b"\x11" * records[0].byte_length + b"\x22" * records[1].byte_length
    mini_resource = replace(SMALL31.resource, byte_length=len(stage_payload),
                            record_count=2, payload_bytes=len(stage_payload))
    mini_spec = replace(
        SMALL31,
        stages=(SMALL31.stages[6],),
        records=records,
        record_count=2,
        payload_bytes=len(stage_payload),
        resource=mini_resource,
        stage_pins=(StagePin("decoder512", len(stage_payload), sha256_bytes(stage_payload)),),
    )
    stage = {
        "id": "decoder512", "kind": "decoder", "file": "stages/decoder512.bin",
        "roles": [39, 40, 47], "rawBlocks": [19, 20, 21], "recordCount": 2,
        "packedByteLength": len(stage_payload), "sha256": "0" * 64,
    }
    tensors = [
        _small_tensor("block20.layer0.layer", 20, "decoder512", 0, 524_288),
        _small_tensor("block21.layer0.layer", 21, "decoder512", 524_288, 524_288),
    ]
    manifest = _base_small_manifest([stage], tensors, totals={
        "resourceByteLength": mini_resource.byte_length,
        "envelopeOverheadBytes": 0,
    })
    manifest["model"].update(recordCount=2, payloadBytes=len(stage_payload))
    manifest["source"]["resource"]["byteLength"] = mini_resource.byte_length
    directory = _write_small_archive(tmp_path, manifest, {"decoder512": stage_payload})
    return directory, mini_spec, stage_payload


def test_rehashed_equal_size_record_offset_swap_is_rejected(tmp_path):
    """A canonical roster offset, not an editable manifest hash, anchors a record."""
    from dlssnr.small_model import SmallDLSSNR, SmallWeightArchive

    directory, mini_spec, stage_payload = _offset_swap_fixture(tmp_path / "swap")
    assert SmallWeightArchive(directory, spec=mini_spec).tensor(40).name == "block20.layer0.layer"

    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    first, second = manifest["tensors"]
    first["stageOffset"], second["stageOffset"] = second["stageOffset"], first["stageOffset"]
    for tensor in manifest["tensors"]:
        chunk = stage_payload[tensor["stageOffset"]:tensor["stageOffset"] + tensor["byteLength"]]
        tensor["sha256"] = sha256_bytes(chunk)
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")

    # The stage file and its pin are unchanged and every entry hash is recomputed.
    with pytest.raises(ManifestError, match="canonical packed offset"):
        SmallWeightArchive(directory, spec=mini_spec)

    # Fixture mode accepts the roster for cheap tests, but production model
    # construction re-runs validate_complete and must reject the same archive.
    fixture_archive = SmallWeightArchive(directory, spec=mini_spec, require_complete=False)
    with pytest.raises(ManifestError, match="canonical packed offset"):
        SmallDLSSNR(fixture_archive)


@pytest.mark.skipif(not Path("profile/dlss-update-20261029/implementation/runtime-assets-small31/manifest.json").is_file(),
                    reason="the extracted Small31 archive is not available")
def test_real_archive_rehashed_offset_swap_is_rejected(tmp_path):
    """Real-archive counterexample from implementation-review §6.

    The two 524,288-byte decoder512 layer records (raw 20/21, roles 40/47) are
    swapped by editing only ``stageOffset``; stage data, stage pins and the
    recomputed entry hashes are otherwise untouched.
    """
    import shutil

    from dlssnr.small_model import SmallDLSSNR, SmallWeightArchive

    source = Path("profile/dlss-update-20261029/implementation/runtime-assets-small31")
    directory = tmp_path / "swapped"
    shutil.copytree(source, directory)
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    by_name = {entry["name"]: entry for entry in manifest["tensors"]}
    first, second = by_name["block20.layer0.layer"], by_name["block21.layer0.layer"]
    assert first["stage"] == second["stage"] == "decoder512"
    assert first["byteLength"] == second["byteLength"] == 524_288
    first["stageOffset"], second["stageOffset"] = second["stageOffset"], first["stageOffset"]
    stage_data = (directory / "model" / "stages" / "decoder512.bin").read_bytes()
    for tensor in (first, second):
        chunk = stage_data[tensor["stageOffset"]:tensor["stageOffset"] + tensor["byteLength"]]
        tensor["sha256"] = sha256_bytes(chunk)
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")

    with pytest.raises(ManifestError, match="canonical packed offset"):
        SmallWeightArchive(directory)
    fixture_archive = SmallWeightArchive(directory, require_complete=False)
    with pytest.raises(ManifestError, match="canonical packed offset"):
        SmallDLSSNR(fixture_archive)


@pytest.mark.skipif(not Path("profile/dlss-update-20261029/implementation/runtime-assets-small31/manifest.json").is_file(),
                    reason="the extracted Small31 archive is not available")
def test_real_archive_provenance_variants_are_equally_verified(tmp_path):
    """Different local provenance must not change the verified source identity."""
    import shutil

    from dlssnr.small_model import SmallWeightArchive

    source = Path("profile/dlss-update-20261029/implementation/runtime-assets-small31")
    original = SmallWeightArchive(source)
    directory = tmp_path / "provenance"
    shutil.copytree(source, directory)
    manifest = json.loads((directory / "manifest.json").read_text(encoding="utf-8"))
    manifest["source"]["dllFileName"] = "moved/local/nvngx_dlssnr.dll"
    manifest["source"]["peTimeDateStamp"] = int(manifest["source"].get("peTimeDateStamp", 0)) + 1
    manifest["source"]["extractor"] = "tools/extract_runtime_assets.py@different-output-dir"
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")

    relocated = SmallWeightArchive(directory)
    assert relocated.manifest_sha256 != original.manifest_sha256
    assert relocated.spec is original.spec
    assert relocated.dll_sha256 == original.dll_sha256
    assert relocated.resource_sha256 == original.resource_sha256
    assert set(relocated.records) == set(original.records) == SMALL31.expected_record_names()


def test_pe_fixture_discovery_and_atomic_extraction(tmp_path):
    envelope = _envelope([("block0.layer0.layer", b"\x00" * 21_696)])
    pe = _make_pe(envelope)
    pe_path = tmp_path / "fixture.dll"
    pe_path.write_bytes(pe)

    info = find_pe_resource(pe_path, 10, "WEIGHTS_HT", 1033)
    assert info.file_offset == 0x200 + 0x1000
    assert info.byte_length == len(envelope)
    assert PeImage(pe_path).read_resource(info) == envelope

    spec = _fixture_spec(envelope, pe, roles=(0,), raw=(0,))
    output = tmp_path / "out"
    summary = extract_model(pe_path, spec, output)
    assert summary["model"] == "fixture"
    assert summary["totals"]["tensorCount"] == 1
    manifest_path = output / "manifest.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    assert manifest["model"]["id"] == "fixture"
    assert manifest["totals"]["packedByteLength"] == 21_696
    assert manifest["tensors"][0]["role"] == 0
    assert (output / "model" / "stages" / "stage-0.bin").stat().st_size == 21_696

    before = manifest_path.read_bytes()
    with pytest.raises(FileExistsError):
        extract_model(pe_path, spec, output)
    assert manifest_path.read_bytes() == before

    # A different DLL byte invalidates the exact identity before any write.
    tampered = bytearray(pe)
    tampered[0x200 + 0x1000] ^= 0xFF
    tampered_path = tmp_path / "tampered.dll"
    tampered_path.write_bytes(tampered)
    with pytest.raises(AssetIdentityError):
        validate_dll_identity(tampered_path, spec)


def test_extraction_reports_unique_stage_raw_blocks(tmp_path):
    envelope = _envelope([
        ("block0.layer0.layer", b"\x00" * 20_672),  # role 1
        ("block1.layer0.layer", b"\x00" * 22_720),  # role 4
    ])
    pe = _make_pe(envelope)
    pe_path = tmp_path / "multi.dll"
    pe_path.write_bytes(pe)
    spec = make_model_spec(
        id="fixture-multi",
        display_name="fixture-multi",
        runtime_version="test",
        resource=ResourcePin(10, "WEIGHTS_HT", 1033, len(envelope), sha256_bytes(envelope), 2, 43_392),
        dll_pins=(DllPin("test", sha256_bytes(pe), len(pe)),),
        roles=(1, 4),
        raw_to_role=(1, 4),
        stages=(StageSpec("encoder32", "encoder", (1, 4)),),
        pre_role=1,
        post_role=4,
        role_phases=(),
    )
    output = tmp_path / "multi-out"
    extract_model(pe_path, spec, output)
    manifest = json.loads((output / "manifest.json").read_text(encoding="utf-8"))
    assert manifest["stages"][0]["rawBlocks"] == [0, 1]
    assert manifest["stages"][0]["recordCount"] == 2


def test_local_3108_pe_discovery_if_present():
    dll = Path("assets/original/nvngx_dlssnr.dll")
    if not dll.is_file() or dll.stat().st_size != LEGACY71.dll_pins[0].byte_length:
        pytest.skip("local original 310.8 DLL is not available")
    identity = validate_dll_identity(dll, LEGACY71)
    assert identity.pin.version == "310.8.0.0"
    info = find_pe_resource(dll, 10, "WEIGHTS_HT", 1033)
    assert info.file_offset == 18_129_248
    assert info.byte_length == 147_695_410
    resource = PeImage(dll).read_resource(info)
    assert sha256_bytes(resource) == LEGACY71.resource.sha256
    with pytest.raises(AssetIdentityError):
        validate_dll_identity(dll, SMALL31)


def test_310_9_16_artifact_if_present():
    root = Path("profile/dlss-update-20261029/artifacts")
    candidates = []
    if root.is_dir():
        candidates = [path for path in root.rglob("*.dll")
                      if path.is_file() and path.stat().st_size == 266_424_944]
    if not candidates:
        pytest.skip("original 310.9.16 DLL is not available")
    dll = candidates[0]
    identity = validate_dll_identity(dll, SMALL31)
    assert identity.pin.version == "310.9.16.0"
    info = find_pe_resource(dll, 10, "WEIGHTS_CC_SMALL_FP8", 1033)
    assert info.byte_length == 113_893_343
    resource = PeImage(dll).read_resource(info)
    assert sha256_bytes(resource) == SMALL31.resource.sha256
    parsed = parse_envelope(resource)
    validate_records(SMALL31, parsed)


@pytest.mark.skipif(os.environ.get("DLSSNR_RUN_REAL_SMALL_EXTRACT") != "1",
                    reason="set DLSSNR_RUN_REAL_SMALL_EXTRACT=1 to write the 113.9 MB extracted archive")
def test_real_small_extraction_and_full_archive_load(tmp_path):
    dll = Path("profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll")
    if not dll.is_file():
        pytest.skip("original 310.9.16 DLL is not available")
    from dlssnr.small_model import SmallWeightArchive

    output = tmp_path / "small31"
    summary = extract_model(dll, "small31", output)
    assert summary["totals"] == {
        "blockCount": 31, "roleCount": 31, "tensorCount": 77, "stageCount": 11,
        "packedByteLength": 113_887_490, "resourceByteLength": 113_893_343,
        "envelopeOverheadBytes": 5_853,
    }
    archive = SmallWeightArchive(output)
    assert len(archive.records) == 77
    decoded = archive.decode_block(70)
    assert decoded["head"].shape == (32, 4)
    assert "native_rgb_head" not in decoded and "training_head_surrogate" not in decoded
    assert archive.decode_native_rgb_head().shape == (4, 32)
    assert float(decoded["blend_scale"][0]) == pytest.approx(0.76708984375)

    # Rehash a corrupted equal-sized stage and all its tensor entries.  The
    # manifest is now internally consistent, but the embedded trusted stage pin
    # must still reject it.
    manifest_path = output / "manifest.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    stage = manifest["stages"][0]
    stage_path = output / "model" / stage["file"]
    stage_data = bytearray(stage_path.read_bytes())
    stage_data[0] ^= 0x01
    stage_path.write_bytes(stage_data)
    stage["sha256"] = sha256_bytes(stage_data)
    for tensor in manifest["tensors"]:
        if tensor["stage"] == stage["id"]:
            payload = stage_data[tensor["stageOffset"]:tensor["stageOffset"] + tensor["byteLength"]]
            tensor["sha256"] = sha256_bytes(payload)
    manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
    with pytest.raises(ManifestError):
        SmallWeightArchive(output)
