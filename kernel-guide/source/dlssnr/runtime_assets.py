"""Offline, bounded extraction of DLSS-NR packed PE resources.

The parser reads bytes only.  It never maps, loads or executes the DLL, never
calls a Windows API, and never downloads anything.  Two independent layers are
validated:

1. The exact original DLL SHA-256/byte length from :mod:`dlssnr.model_specs`.
2. The exact ``10/WEIGHTS_HT/1033`` or ``10/WEIGHTS_CC_SMALL_FP8/1033`` resource
   SHA-256/byte length, parsed as a bounded length-prefixed record envelope and
   checked against the model roster (names, raw ids, roles, sizes, stages and
   metadata).

Extraction writes a new directory through a sibling temporary directory and an
atomic rename.  An existing output path is always rejected, so old extracted
assets are never overwritten.

Source basis: the envelope/layout facts come from the read-only research
snapshots cited in :mod:`dlssnr.model_specs`.  No executable bytes are copied
into this repository by this module.
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import struct
import tempfile

from .model_specs import (
    DllPin,
    ModelSpec,
    PostHeadSpec,
    resolve_model,
)

MAX_PE_SECTIONS = 256
MAX_RESOURCE_ENTRIES = 4096
MAX_RESOURCE_NAME = 4096
MAX_RESOURCE_DEPTH = 3
MAX_RECORD_NAME = 4096
MAX_RECORD_RANK = 32
MAX_RECORDS = 4096
_RECORD_NAME_RE = re.compile(r"block(\d+)\.layer(\d+)\.([A-Za-z0-9_]+)\Z")
_SHA256_RE = re.compile(r"[0-9a-f]{64}\Z")


class AssetError(ValueError):
    """Base class for malformed or untrusted runtime asset data."""


class AssetIdentityError(AssetError):
    """The DLL or resource identity is not the exact accepted pin."""


class ResourceFormatError(AssetError):
    """The PE resource tree or packed envelope is malformed."""


class ManifestError(AssetError):
    """An extracted manifest is malformed or inconsistent with its model."""


def sha256_bytes(data: bytes | memoryview) -> str:
    return hashlib.sha256(data).hexdigest()


def file_sha256(path: str | Path) -> str:
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for chunk in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _u32(data: bytes | memoryview, offset: int, limit: int, what: str) -> int:
    if offset < 0 or offset + 4 > limit:
        raise ResourceFormatError(f"{what} is outside the bounded region")
    return struct.unpack_from("<I", data, offset)[0]


def _u64(data: bytes | memoryview, offset: int, limit: int, what: str) -> int:
    if offset < 0 or offset + 8 > limit:
        raise ResourceFormatError(f"{what} is outside the bounded region")
    return struct.unpack_from("<Q", data, offset)[0]


def _read_at(stream, offset: int, size: int, file_size: int, what: str) -> bytes:
    if offset < 0 or size < 0 or offset + size > file_size:
        raise ResourceFormatError(f"{what} is outside the file")
    stream.seek(offset)
    data = stream.read(size)
    if len(data) != size:
        raise ResourceFormatError(f"short read for {what}")
    return data


@dataclass(frozen=True)
class PeSection:
    name: str
    virtual_address: int
    virtual_size: int
    raw_size: int
    raw_pointer: int


@dataclass(frozen=True)
class PeResourceInfo:
    """A leaf PE resource with the file offset needed for a bounded read."""

    type_id: int
    name: str
    language: int
    rva: int
    file_offset: int
    byte_length: int
    pe_machine: int
    pe_time_date_stamp: int

    @property
    def path(self) -> str:
        return f"{self.type_id}/{self.name}/{self.language}"


@dataclass(frozen=True)
class DllIdentity:
    sha256: str
    byte_length: int
    pin: DllPin


@dataclass(frozen=True)
class ParsedRecord:
    name: str
    raw_block: int
    layer: int
    parameter: str
    resource_offset: int
    byte_length: int
    device_code: int
    storage_dimensions: tuple[int, ...]
    tail_fields: tuple[int, int]


@dataclass(frozen=True)
class ParsedResource:
    byte_length: int
    records: tuple[ParsedRecord, ...]
    payload_bytes: int
    overhead_bytes: int


class PeImage:
    """Minimal bounded PE reader: DOS/NT headers, sections and .rsrc only."""

    def __init__(self, path: str | Path):
        self.path = Path(path)
        if not self.path.is_file():
            raise FileNotFoundError(f"runtime DLL not found: {self.path}")
        self.file_size = self.path.stat().st_size
        if self.file_size < 0x40:
            raise ResourceFormatError("file is too small to be a PE image")
        with self.path.open("rb") as stream:
            dos = _read_at(stream, 0, 0x40, self.file_size, "DOS header")
            if dos[:2] != b"MZ":
                raise ResourceFormatError("missing DOS MZ signature")
            e_lfanew = struct.unpack_from("<I", dos, 0x3C)[0]
            if e_lfanew < 0x40 or e_lfanew + 24 > self.file_size:
                raise ResourceFormatError("invalid PE header offset")
            nt = _read_at(stream, e_lfanew, 24, self.file_size, "NT signature/COFF header")
            if nt[:4] != b"PE\0\0":
                raise ResourceFormatError("missing PE signature")
            self.pe_machine = struct.unpack_from("<H", nt, 4)[0]
            self.pe_time_date_stamp = struct.unpack_from("<I", nt, 8)[0]
            self.section_count = struct.unpack_from("<H", nt, 6)[0]
            optional_size = struct.unpack_from("<H", nt, 20)[0]
            if not 1 <= self.section_count <= MAX_PE_SECTIONS:
                raise ResourceFormatError("unreasonable PE section count")
            if optional_size < 96:
                raise ResourceFormatError("optional header is too small")
            optional = _read_at(stream, e_lfanew + 24, optional_size, self.file_size, "optional header")
            magic = struct.unpack_from("<H", optional, 0)[0]
            if magic == 0x10B:
                directory_offset, count_offset = 96, 92
            elif magic == 0x20B:
                directory_offset, count_offset = 112, 108
            else:
                raise ResourceFormatError("unsupported PE optional-header magic")
            if optional_size < directory_offset + 24:
                raise ResourceFormatError("optional header has no resource data directory")
            self.directory_count = struct.unpack_from("<I", optional, count_offset)[0]
            if self.directory_count <= 2:
                raise ResourceFormatError("PE image does not declare a resource data directory")
            resource_rva, resource_size = struct.unpack_from("<II", optional, directory_offset + 16)
            if resource_rva == 0 or resource_size < 16:
                raise ResourceFormatError("PE resource directory is absent or empty")
            self.resource_rva = resource_rva
            self.resource_size = resource_size

            section_table = _read_at(
                stream, e_lfanew + 24 + optional_size,
                self.section_count * 40, self.file_size, "section table")
            self.sections = []
            for index in range(self.section_count):
                base = index * 40
                name = section_table[base:base + 8].split(b"\0", 1)[0].decode("ascii", "replace")
                virtual_size, virtual_address, raw_size, raw_pointer = struct.unpack_from(
                    "<IIII", section_table, base + 8)
                self.sections.append(PeSection(name, virtual_address, virtual_size, raw_size, raw_pointer))
            self.resource_offset = self.rva_to_offset(self.resource_rva, self.resource_size)
            self.resource_end = self.resource_offset + self.resource_size

    def rva_to_offset(self, rva: int, size: int) -> int:
        if rva < 0 or size < 0:
            raise ResourceFormatError("negative RVA or size")
        for section in self.sections:
            span = max(section.virtual_size, section.raw_size)
            if section.virtual_address <= rva and rva + size <= section.virtual_address + span:
                delta = rva - section.virtual_address
                if delta + size > section.raw_size:
                    raise ResourceFormatError("RVA is not backed by raw section bytes")
                offset = section.raw_pointer + delta
                if offset < 0 or offset + size > self.file_size:
                    raise ResourceFormatError("mapped resource exceeds the file")
                return offset
        raise ResourceFormatError(f"RVA {rva:#x} is not mapped by any PE section")

    def _resource_bytes(self, offset: int, size: int, what: str) -> bytes:
        if offset < self.resource_offset or offset + size > self.resource_end:
            raise ResourceFormatError(f"{what} is outside the resource section")
        with self.path.open("rb") as stream:
            return _read_at(stream, offset, size, self.file_size, what)

    def enumerate_resources(self) -> tuple[PeResourceInfo, ...]:
        """Walk the resource tree, bounded by depth, entry count and region size."""
        results: list[PeResourceInfo] = []
        seen_directories: set[int] = set()

        def read_directory(offset: int, depth: int) -> list[tuple[int | str, int]]:
            if depth > MAX_RESOURCE_DEPTH:
                raise ResourceFormatError("resource tree is deeper than the supported 3 levels")
            if offset in seen_directories:
                raise ResourceFormatError("resource tree contains a directory cycle")
            seen_directories.add(offset)
            header = self._resource_bytes(offset, 16, "resource directory")
            named, ids = struct.unpack_from("<HH", header, 12)
            count = named + ids
            if count > MAX_RESOURCE_ENTRIES:
                raise ResourceFormatError("resource directory has too many entries")
            raw = self._resource_bytes(offset + 16, count * 8, "resource directory entries")
            entries: list[tuple[int | str, int]] = []
            for index in range(count):
                name_field, offset_field = struct.unpack_from("<II", raw, index * 8)
                if name_field & 0x80000000:
                    string_offset = self.resource_offset + (name_field & 0x7FFFFFFF)
                    if string_offset + 2 > self.resource_end:
                        raise ResourceFormatError("resource name offset is outside the resource section")
                    length = struct.unpack_from("<H", self._resource_bytes(string_offset, 2, "resource name length"))[0]
                    if length == 0 or length > MAX_RESOURCE_NAME:
                        raise ResourceFormatError("resource name has an invalid length")
                    encoded = self._resource_bytes(string_offset + 2, length * 2, "resource name")
                    name: int | str = encoded.decode("utf-16-le", errors="strict")
                    if not name:
                        raise ResourceFormatError("resource name is empty")
                else:
                    name = name_field & 0xFFFF
                entries.append((name, offset_field))
            return entries

        def walk(offset: int, path: tuple[int | str, ...], depth: int) -> None:
            for name, offset_field in read_directory(offset, depth):
                if offset_field & 0x80000000:
                    child = self.resource_offset + (offset_field & 0x7FFFFFFF)
                    if child >= self.resource_end:
                        raise ResourceFormatError("resource subdirectory is outside the resource section")
                    walk(child, path + (name,), depth + 1)
                    continue
                data_offset = self.resource_offset + offset_field
                entry = self._resource_bytes(data_offset, 16, "resource data entry")
                data_rva, size, _codepage, _reserved = struct.unpack_from("<IIII", entry, 0)
                if size == 0:
                    raise ResourceFormatError("resource data entry is empty")
                file_offset = self.rva_to_offset(data_rva, size)
                # Resource trees in the wild may put the language data entry
                # directly under the name directory (path has 2 components and
                # the entry name is the language id) or use a third directory.
                if len(path) == 2:
                    type_name, resource_name = path
                    language = name
                elif len(path) == 3:
                    type_name, resource_name, language = path
                else:
                    raise ResourceFormatError("resource leaf is not at type/name/language depth")
                if not isinstance(type_name, int) or not isinstance(resource_name, (str, int)) or not isinstance(language, int):
                    raise ResourceFormatError("resource path does not have numeric type/language and a string or numeric name")
                resource_name = str(resource_name)
                results.append(PeResourceInfo(
                    type_id=type_name,
                    name=resource_name,
                    language=language,
                    rva=data_rva,
                    file_offset=file_offset,
                    byte_length=size,
                    pe_machine=self.pe_machine,
                    pe_time_date_stamp=self.pe_time_date_stamp,
                ))

        walk(self.resource_offset, (), 0)
        return tuple(results)

    def read_resource(self, info: PeResourceInfo) -> bytes:
        return self._resource_bytes(info.file_offset, info.byte_length, f"resource {info.path}")


def find_pe_resource(path: str | Path, type_id: int, name: str, language: int) -> PeResourceInfo:
    """Find exactly one leaf resource by numeric type, string name and language."""
    image = PeImage(path)
    matches = [item for item in image.enumerate_resources()
               if item.type_id == type_id and item.name == name and item.language == language]
    if len(matches) != 1:
        available = sorted(item.path for item in image.enumerate_resources())
        raise ResourceFormatError(
            f"expected exactly one resource {type_id}/{name}/{language}, found {len(matches)}; "
            f"available={available}")
    return matches[0]


def read_pe_resource(path: str | Path, type_id: int, name: str, language: int) -> tuple[PeResourceInfo, bytes]:
    image = PeImage(path)
    matches = [item for item in image.enumerate_resources()
               if item.type_id == type_id and item.name == name and item.language == language]
    if len(matches) != 1:
        available = sorted(item.path for item in image.enumerate_resources())
        raise ResourceFormatError(
            f"expected exactly one resource {type_id}/{name}/{language}, found {len(matches)}; "
            f"available={available}")
    return matches[0], image.read_resource(matches[0])


def validate_dll_identity(path: str | Path, spec: ModelSpec) -> DllIdentity:
    """Hash the file and require one of the exact original DLL pins."""
    path = Path(path)
    if not path.is_file():
        raise FileNotFoundError(f"runtime DLL not found: {path}")
    size = path.stat().st_size
    digest = file_sha256(path)
    for pin in spec.dll_pins:
        if pin.sha256 == digest and pin.byte_length == size:
            return DllIdentity(digest, size, pin)
    accepted = ", ".join(f"{pin.version}:{pin.sha256}({pin.byte_length}B)" for pin in spec.dll_pins)
    raise AssetIdentityError(
        f"DLL identity {digest} ({size} bytes) is not accepted for {spec.id}; accepted originals: {accepted}. "
        "Patched, community and unknown DLLs are rejected.")


def validate_resource_identity(data: bytes | memoryview, spec: ModelSpec) -> None:
    """Require the exact pinned resource byte length and SHA-256."""
    pin = spec.resource
    if len(data) != pin.byte_length:
        raise AssetIdentityError(
            f"resource byte length {len(data)} differs from pinned {pin.byte_length} for {pin.path}")
    digest = sha256_bytes(data)
    if digest != pin.sha256:
        raise AssetIdentityError(
            f"resource SHA-256 {digest} differs from pinned {pin.sha256} for {pin.path}")


def parse_envelope(data: bytes | memoryview) -> ParsedResource:
    """Parse the bounded length-prefixed weight envelope without trusting sizes."""
    view = memoryview(data)
    size = len(view)
    if size < 8:
        raise ResourceFormatError("resource is too small for an envelope header")
    if _u64(view, 0, size, "resource size header") != size:
        raise ResourceFormatError("resource size header disagrees with the resource length")
    cursor = 8
    records: list[ParsedRecord] = []
    names: set[str] = set()
    while cursor < size:
        if len(records) >= MAX_RECORDS:
            raise ResourceFormatError("resource has too many records")
        name_length = _u64(view, cursor, size, "record name length")
        cursor += 8
        if not 1 <= name_length <= MAX_RECORD_NAME or cursor + name_length > size:
            raise ResourceFormatError("record name length is outside the bounded region")
        name = bytes(view[cursor:cursor + name_length]).decode("utf-8", errors="strict")
        cursor += name_length
        match = _RECORD_NAME_RE.fullmatch(name)
        if match is None:
            raise ResourceFormatError(f"invalid tensor name {name!r}")
        if name in names:
            raise ResourceFormatError(f"duplicate tensor name {name!r}")
        names.add(name)
        record_size = _u64(view, cursor, size, "record size")
        cursor += 8
        record_start = cursor
        record_end = record_start + record_size
        if record_size < 36 or record_end > size:
            raise ResourceFormatError(f"invalid record extent for {name!r}")
        if _u64(view, record_start, record_end, "record self-size") != record_size:
            raise ResourceFormatError(f"record length fields disagree for {name!r}")
        payload_size = _u64(view, record_start + 8, record_end, "payload size")
        device_code = _u32(view, record_start + 16, record_end, "device code")
        payload = record_start + 20
        tail = payload + payload_size
        if tail + 16 > record_end:
            raise ResourceFormatError(f"payload/tail extent exceeds record {name!r}")
        field0 = _u32(view, tail, record_end, "tail field 0")
        field1 = _u32(view, tail + 4, record_end, "tail field 1")
        rank = _u64(view, tail + 8, record_end, "storage rank")
        if rank > MAX_RECORD_RANK:
            raise ResourceFormatError(f"record {name!r} has an unreasonable rank")
        if tail + 16 + rank * 4 != record_end:
            raise ResourceFormatError(f"record {name!r} metadata extent disagrees with its size")
        dimensions = tuple(_u32(view, tail + 16 + index * 4, record_end, "storage dimension")
                           for index in range(rank))
        records.append(ParsedRecord(
            name=name,
            raw_block=int(match.group(1)),
            layer=int(match.group(2)),
            parameter=match.group(3),
            resource_offset=payload,
            byte_length=payload_size,
            device_code=device_code,
            storage_dimensions=dimensions,
            tail_fields=(field0, field1),
        ))
        cursor = record_end
    if cursor != size:
        raise ResourceFormatError("resource has trailing bytes")
    payload_bytes = sum(record.byte_length for record in records)
    return ParsedResource(
        byte_length=size,
        records=tuple(records),
        payload_bytes=payload_bytes,
        overhead_bytes=size - payload_bytes,
    )


def _expected_metadata(byte_length: int) -> tuple[int, tuple[int, ...], tuple[int, int]]:
    """Metadata invariant observed across all 153 original 310.8 records.

    Rank 1, device code 1, dimensions ``[byteLength/2]`` and zero tail fields are
    enforced for the mapped Small records too.  A differing real Small artifact
    fails extraction instead of being silently accepted.
    """
    if byte_length % 2:
        raise ResourceFormatError(f"record byte length {byte_length} is not an even f16 extent")
    return 1, (byte_length // 2,), (0, 0)


def validate_records(spec: ModelSpec, parsed: ParsedResource) -> dict[str, ParsedRecord]:
    """Validate a parsed envelope against the exact model roster and metadata."""
    if len(parsed.records) != spec.record_count:
        raise AssetIdentityError(
            f"resource has {len(parsed.records)} records, expected {spec.record_count} for {spec.id}")
    actual = {record.name: record for record in parsed.records}
    if len(actual) != len(parsed.records):
        raise AssetIdentityError("resource contains duplicate record names")
    expected_names = spec.expected_record_names()
    if set(actual) != set(expected_names):
        missing = sorted(expected_names - set(actual))
        unexpected = sorted(set(actual) - expected_names)
        raise AssetIdentityError(f"record roster mismatch for {spec.id}: missing={missing}, unexpected={unexpected}")
    for name in sorted(expected_names):
        expected = spec.record_spec(name)
        record = actual[name]
        if record.raw_block != expected.raw_block:
            raise AssetIdentityError(f"{name}: raw block {record.raw_block} != {expected.raw_block}")
        if record.layer != expected.layer or record.parameter != expected.parameter:
            raise AssetIdentityError(f"{name}: layer/parameter metadata disagrees with the roster")
        if record.raw_block >= spec.block_count:
            raise AssetIdentityError(f"{name}: raw block is outside the model block range")
        if spec.role_for_raw(record.raw_block) != expected.role:
            raise AssetIdentityError(f"{name}: raw id {record.raw_block} does not map to role {expected.role}")
        if record.byte_length != expected.byte_length:
            raise AssetIdentityError(
                f"{name}: byte length {record.byte_length} != role-mapped {expected.byte_length} for role {expected.role}")
        if spec.stage_for_role(expected.role).id != expected.stage:
            raise AssetIdentityError(f"{name}: stage assignment is inconsistent")
        rank, dimensions, tails = _expected_metadata(record.byte_length)
        if record.device_code != 1:
            raise AssetIdentityError(f"{name}: device code {record.device_code} != 1")
        if len(record.storage_dimensions) != rank:
            raise AssetIdentityError(f"{name}: storage rank {len(record.storage_dimensions)} != {rank}")
        if record.storage_dimensions != dimensions:
            raise AssetIdentityError(
                f"{name}: storage dimensions {record.storage_dimensions} != expected {dimensions}")
        if record.tail_fields != tails:
            raise AssetIdentityError(f"{name}: tail fields {record.tail_fields} != {tails}")
    if parsed.payload_bytes != spec.payload_bytes:
        raise AssetIdentityError(
            f"resource payload {parsed.payload_bytes} != pinned {spec.payload_bytes} for {spec.id}")
    if parsed.byte_length != spec.resource.byte_length:
        raise AssetIdentityError(
            f"resource length {parsed.byte_length} != pinned {spec.resource.byte_length} for {spec.id}")
    expected_overhead = spec.resource.byte_length - spec.payload_bytes
    if parsed.overhead_bytes != expected_overhead:
        raise AssetIdentityError(
            f"resource envelope overhead {parsed.overhead_bytes} != pinned {expected_overhead}")
    return actual


def verify_stage_pins(spec: ModelSpec, stages: dict[str, bytes]) -> None:
    """Compare complete stage payloads with the model's trusted canonical pins.

    Small31 carries 11 stage hashes derived from the locally verified original
    310.9.16 resource.  This anchors full-archive verification to fixed bytes, so
    editing a manifest and re-hashing equal-sized swapped payloads is rejected.
    Models without stage pins (for example LEGACY71) are not anchored here.
    """
    if not spec.stage_pins:
        return
    expected = {pin.id: pin for pin in spec.stage_pins}
    if set(stages) != set(expected):
        raise AssetIdentityError(
            f"stage roster {sorted(stages)} differs from pinned stages {sorted(expected)}")
    for stage_id, pin in expected.items():
        data = stages[stage_id]
        if len(data) != pin.byte_length:
            raise AssetIdentityError(
                f"stage {stage_id} length {len(data)} differs from pinned {pin.byte_length}")
        digest = sha256_bytes(data)
        if digest != pin.sha256:
            raise AssetIdentityError(
                f"stage {stage_id} SHA-256 {digest} differs from trusted pin {pin.sha256}")


def validate_manifest_tensors(spec: ModelSpec, tensors, *, require_complete: bool = True) -> None:
    """Validate manifest tensor entries without reading stage payloads.

    Every entry must agree with the immutable :class:`ModelSpec` roster on name,
    ``raw_block``/``block``, role, layer, parameter, stage and byte length.  A
    complete manifest additionally requires every ``stageOffset`` to equal the
    canonical packed position derived from the roster and the extractor's exact
    ``(raw_block, layer, parameter)`` ordering, so rehashing an equal-sized
    record-offset swap cannot re-anchor the model to the wrong weights.

    ``require_complete=False`` is a fixture escape hatch, mirroring the legacy
    archive; it still rejects unknown roles, wrong sizes, identity/name
    disagreements and bad metadata.
    """
    if not isinstance(tensors, (list, tuple)):
        raise ManifestError("manifest tensors must be an array")
    names: set[str] = set()
    expected_names = spec.expected_record_names()
    for entry in tensors:
        if not isinstance(entry, dict):
            raise ManifestError("each tensor entry must be an object")
        try:
            name = entry["name"]
            raw_block = entry.get("rawBlock", entry.get("block"))
            role = entry["role"]
            layer = entry["layer"]
            parameter = entry["parameter"]
            stage = entry["stage"]
            byte_length = entry["byteLength"]
            device_code = entry["deviceCode"]
            dimensions = entry["storageDimensions"]
            tails = entry["tailFields"]
        except KeyError as exc:
            raise ManifestError(f"tensor entry is missing {exc.args[0]!r}") from exc
        if not isinstance(name, str) or name in names:
            raise ManifestError(f"duplicate or invalid tensor name {name!r}")
        names.add(name)
        if type(raw_block) is not int or not 0 <= raw_block < spec.block_count:
            raise ManifestError(f"{name}: invalid raw block id")
        if name not in expected_names:
            raise ManifestError(f"{name}: unexpected record for model {spec.id}")
        expected = spec.record_spec(name)
        if raw_block != expected.raw_block:
            raise ManifestError(
                f"{name}: raw block {raw_block!r} != roster raw block {expected.raw_block}")
        if type(role) is not int or role != expected.role:
            raise ManifestError(f"{name}: role {role!r} != roster role {expected.role}")
        if layer != expected.layer or parameter != expected.parameter:
            raise ManifestError(f"{name}: layer/parameter metadata disagrees with the roster")
        if stage != expected.stage:
            raise ManifestError(f"{name}: stage {stage!r} != {expected.stage!r}")
        if type(byte_length) is not int or byte_length != expected.byte_length:
            raise ManifestError(
                f"{name}: byte length {byte_length!r} != role-mapped {expected.byte_length} for role {expected.role}")
        if "block" in entry and entry["block"] != expected.raw_block:
            raise ManifestError(f"{name}: block and rawBlock disagree with the roster")
        try:
            rank, expected_dimensions, expected_tails = _expected_metadata(expected.byte_length)
        except AssetError as exc:
            raise ManifestError(f"{name}: invalid byte extent: {exc}") from exc
        if type(device_code) is not int or device_code != 1:
            raise ManifestError(f"{name}: device code {device_code!r} != 1")
        if not isinstance(dimensions, (list, tuple)) or len(dimensions) != rank:
            raise ManifestError(f"{name}: storage dimensions {dimensions!r} do not have rank {rank}")
        if tuple(dimensions) != expected_dimensions:
            raise ManifestError(f"{name}: storage dimensions {dimensions!r} != {expected_dimensions}")
        if not isinstance(tails, (list, tuple)) or tuple(tails) != expected_tails:
            raise ManifestError(f"{name}: tail fields {tails!r} != {expected_tails}")
        if "stageOffset" in entry and (type(entry["stageOffset"]) is not int or entry["stageOffset"] < 0):
            raise ManifestError(f"{name}: invalid stage offset")
        if "sha256" in entry and (not isinstance(entry["sha256"], str) or _SHA256_RE.fullmatch(entry["sha256"]) is None):
            raise ManifestError(f"{name}: invalid payload hash")
    if require_complete and (len(names) != spec.record_count or names != set(expected_names)):
        raise ManifestError(
            f"manifest requires {spec.record_count} records for {spec.id}; "
            f"missing={sorted(set(expected_names) - names)}, unexpected={sorted(names - set(expected_names))}")
    if require_complete:
        canonical = spec.stage_record_offsets()
        for entry in tensors:
            name = entry["name"]
            expected = spec.record_spec(name)
            if "stageOffset" not in entry:
                raise ManifestError(f"{name}: complete manifest is missing a canonical stage offset")
            expected_offset = canonical[expected.stage][expected.name]
            if entry["stageOffset"] != expected_offset:
                raise ManifestError(
                    f"{name}: stage offset {entry['stageOffset']!r} != canonical packed "
                    f"offset {expected_offset} for stage {expected.stage!r}")


def _preflight_output(output: str | Path) -> Path:
    raw = Path(output).expanduser()
    if raw.exists() or raw.is_symlink():
        raise FileExistsError(f"output already exists and will not be overwritten: {raw}")
    path = raw.resolve()
    if path.exists() or path.is_symlink():
        raise FileExistsError(f"output already exists and will not be overwritten: {path}")
    parent = path.parent
    if not parent.is_dir():
        raise FileNotFoundError(f"output parent directory does not exist: {parent}")
    if path.name in ("", ".", ".."):
        raise ValueError("output must name a new directory")
    return path


def build_manifest(
    spec: ModelSpec,
    parsed: ParsedResource,
    resource: bytes | memoryview,
    *,
    dll_identity: DllIdentity,
    resource_info: PeResourceInfo,
    dll_file_name: str,
) -> tuple[dict, dict[str, bytes]]:
    """Build the self-describing manifest and packed stage payloads in memory."""
    actual = validate_records(spec, parsed)
    stage_payloads: dict[str, bytes] = {}
    tensors: list[dict] = []
    stages: list[dict] = []
    for stage in spec.stages:
        stage_records = sorted(
            (actual[record.name] for record in spec.records if record.stage == stage.id),
            key=lambda item: (item.raw_block, item.layer, item.parameter),
        )
        if not stage_records:
            raise ManifestError(f"stage {stage.id} would be empty")
        packed = bytearray()
        for record in stage_records:
            offset = len(packed)
            payload = bytes(resource[record.resource_offset:record.resource_offset + record.byte_length])
            if len(payload) != record.byte_length:
                raise ResourceFormatError(f"short payload slice for {record.name}")
            packed.extend(payload)
            expected = spec.record_spec(record.name)
            tensors.append({
                "name": record.name,
                "block": record.raw_block,
                "rawBlock": record.raw_block,
                "role": expected.role,
                "layer": record.layer,
                "parameter": record.parameter,
                "stage": stage.id,
                "stageOffset": offset,
                "byteLength": record.byte_length,
                "deviceCode": record.device_code,
                "storageDimensions": list(record.storage_dimensions),
                "tailFields": list(record.tail_fields),
                "sha256": sha256_bytes(payload),
            })
        stage_payloads[stage.id] = bytes(packed)
        stages.append({
            "id": stage.id,
            "kind": stage.kind,
            "file": f"stages/{stage.id}.bin",
            "roles": list(stage.roles),
            "rawBlocks": sorted({record.raw_block for record in stage_records}),
            "recordCount": len(stage_records),
            "packedByteLength": len(packed),
            "sha256": sha256_bytes(packed),
        })
    tensors.sort(key=lambda item: (item["rawBlock"], item["layer"], item["parameter"]))
    post_head = spec.post_head
    manifest = {
        "schemaVersion": 2,
        "format": "dlssnr-runtime-assets",
        "model": {
            "id": spec.id,
            "displayName": spec.display_name,
            "runtimeVersion": spec.runtime_version,
            "blockCount": spec.block_count,
            "recordCount": spec.record_count,
            "payloadBytes": spec.payload_bytes,
            "roles": list(spec.roles),
            "rawToRole": list(spec.raw_to_role),
            "preRole": spec.pre_role,
            "postRole": spec.post_role,
            "postPhaseDefault": spec.post_phase_default,
            "phaseProvenance": spec.phase_provenance,
            "sourceProvenance": list(spec.source_provenance),
            "postHead": _post_head_dict(post_head) if post_head is not None else None,
            "notes": list(spec.notes),
        },
        "source": {
            "dllFileName": dll_file_name,
            "dllSha256": dll_identity.sha256,
            "dllByteLength": dll_identity.byte_length,
            "dllVersion": dll_identity.pin.version,
            "dllPinNote": dll_identity.pin.note,
            "peMachine": resource_info.pe_machine,
            "peTimeDateStamp": resource_info.pe_time_date_stamp,
            "resource": {
                "path": f"{resource_info.type_id}/{resource_info.name}/{resource_info.language}",
                "typeId": resource_info.type_id,
                "name": resource_info.name,
                "language": resource_info.language,
                "rva": resource_info.rva,
                "fileOffset": resource_info.file_offset,
                "byteLength": resource_info.byte_length,
                "sha256": sha256_bytes(resource),
            },
            "runtimeExecuted": False,
            "dllLoaded": False,
            "networkUsed": False,
            "extractor": "tools/extract_runtime_assets.py",
        },
        "totals": {
            "blockCount": spec.block_count,
            "roleCount": len(spec.roles),
            "tensorCount": len(tensors),
            "stageCount": len(stages),
            "packedByteLength": sum(len(payload) for payload in stage_payloads.values()),
            "resourceByteLength": parsed.byte_length,
            "envelopeOverheadBytes": parsed.overhead_bytes,
        },
        "stages": stages,
        "tensors": tensors,
    }
    verify_stage_pins(spec, stage_payloads)
    validate_manifest_tensors(spec, tensors, require_complete=True)
    return manifest, stage_payloads


def _post_head_dict(post_head: PostHeadSpec) -> dict:
    return {
        "offset": post_head.offset,
        "byteLength": post_head.byte_length,
        "storageShape": list(post_head.storage_shape),
        "rowBits": list(post_head.row_bits),
        "columnBits": list(post_head.column_bits),
        "usedRows": list(post_head.used_rows),
        "nativeShape": list(post_head.native_shape),
        "historyRow": post_head.history_row,
        "historyByteLength": post_head.history_byte_length,
        "provenance": post_head.provenance,
    }


def write_archive(spec: ModelSpec, manifest: dict, stage_payloads: dict[str, bytes], output: str | Path) -> Path:
    """Write a complete archive through a sibling temp directory and atomic rename."""
    output_path = _preflight_output(output)
    temp_dir = Path(tempfile.mkdtemp(prefix=f".{output_path.name}.extract-", dir=str(output_path.parent)))
    try:
        model_dir = temp_dir / "model" / "stages"
        model_dir.mkdir(parents=True, exist_ok=False)
        for stage in manifest["stages"]:
            stage_id = stage["id"]
            payload = stage_payloads[stage_id]
            if len(payload) != stage["packedByteLength"] or sha256_bytes(payload) != stage["sha256"]:
                raise ManifestError(f"stage payload changed before writing: {stage_id}")
            destination = (temp_dir / "model" / stage["file"]).resolve()
            model_root = (temp_dir / "model").resolve()
            if not destination.is_relative_to(model_root):
                raise ManifestError(f"stage path escapes the archive: {stage['file']}")
            destination.write_bytes(payload)
        manifest_bytes = (json.dumps(manifest, indent=2, sort_keys=False) + "\n").encode("utf-8")
        (temp_dir / "manifest.json").write_bytes(manifest_bytes)
        if output_path.exists() or output_path.is_symlink():
            raise FileExistsError(f"output appeared during extraction and will not be overwritten: {output_path}")
        os.replace(temp_dir, output_path)
    except Exception:
        shutil.rmtree(temp_dir, ignore_errors=True)
        raise
    return output_path


def extract_model(dll_path: str | Path, model: str | ModelSpec, output: str | Path) -> dict:
    """Validate one exact original DLL/resource and extract the requested model.

    ``model`` is normally ``"legacy71"`` or ``"small31"``; a validated
    :class:`~dlssnr.model_specs.ModelSpec` is accepted for focused fixtures.
    No network access is performed and the DLL is never loaded.
    """
    spec = resolve_model(model) if isinstance(model, str) else model
    if not isinstance(spec, ModelSpec):
        raise TypeError("model must be a model name or ModelSpec")
    dll_path = Path(dll_path).expanduser().resolve()
    output_path = _preflight_output(output)
    dll_identity = validate_dll_identity(dll_path, spec)
    image = PeImage(dll_path)
    matches = [item for item in image.enumerate_resources()
               if item.type_id == spec.resource.type_id and item.name == spec.resource.name
               and item.language == spec.resource.language]
    if len(matches) != 1:
        available = sorted(item.path for item in image.enumerate_resources())
        raise ResourceFormatError(
            f"expected exactly one resource {spec.resource.path} in {dll_path.name}, "
            f"found {len(matches)}; available={available}")
    resource_info = matches[0]
    if resource_info.byte_length != spec.resource.byte_length:
        raise AssetIdentityError(
            f"resource {spec.resource.path} length {resource_info.byte_length} != pinned "
            f"{spec.resource.byte_length}")
    resource = image.read_resource(resource_info)
    validate_resource_identity(resource, spec)
    parsed = parse_envelope(resource)
    manifest, stage_payloads = build_manifest(
        spec, parsed, resource,
        dll_identity=dll_identity,
        resource_info=resource_info,
        dll_file_name=dll_path.name,
    )
    write_archive(spec, manifest, stage_payloads, output_path)
    manifest_bytes = (json.dumps(manifest, indent=2, sort_keys=False) + "\n").encode("utf-8")
    return {
        "output": str(output_path),
        "model": spec.id,
        "totals": manifest["totals"],
        "source": {
            "dllSha256": dll_identity.sha256,
            "resourceSha256": spec.resource.sha256,
            "resourcePath": spec.resource.path,
        },
        "manifestSha256": sha256_bytes(manifest_bytes),
    }
