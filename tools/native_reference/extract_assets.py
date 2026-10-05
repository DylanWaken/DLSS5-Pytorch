"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import hashlib
from pathlib import Path
import re


DLL_SHA256 = "e16bcf15e16e13f527491cdf7845b2fe6521a738d8f7c9c721866a8496e1fc8e"


RESOURCE_SHA256 = "836f445d06ecd2e59bb9f17b84b91c143396fd76ccda1c9dc7fe81d5edd548f4"


RESOURCE_OFFSET, RESOURCE_SIZE = 18_129_248, 147_695_410


def digest(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def parse_records(data: bytes, *, check_model: bool = True) -> list[dict]:
    """Validate all envelope bounds before returning offsets into the resource."""
    def integer(offset: int, width: int, limit: int) -> int:
        if offset < 0 or offset + width > limit:
            raise ValueError(f"Integer outside record bounds at {offset}")
        return int.from_bytes(data[offset:offset + width], "little")

    size = len(data)
    if integer(0, 8, size) != size:
        raise ValueError("Resource size header disagrees with resource length")
    cursor, records, names = 8, [], set()
    while cursor < size:
        count = integer(cursor, 8, size)
        cursor += 8
        if not 1 <= count <= 4096 or cursor + count > size:
            raise ValueError("Invalid record name length")
        name = data[cursor:cursor + count].decode("utf-8", errors="strict")
        match = re.fullmatch(r"block(\d+)\.layer(\d+)\.([A-Za-z0-9_]+)", name)
        if match is None or name in names:
            raise ValueError(f"Invalid or duplicate tensor name {name!r}")
        names.add(name)
        cursor += count
        record_size = integer(cursor, 8, size)
        record = cursor + 8
        end = record + record_size
        if record_size < 36 or end > size:
            raise ValueError(f"Invalid record extent for {name}")
        if integer(record, 8, end) != record_size:
            raise ValueError(f"Record length fields disagree for {name}")
        payload_size = integer(record + 8, 8, end)
        device = integer(record + 16, 4, end)
        payload = record + 20
        tail = payload + payload_size
        field0 = integer(tail, 4, end)
        field1 = integer(tail + 4, 4, end)
        rank = integer(tail + 8, 8, end)
        if rank > 32 or tail + 16 + rank * 4 != end:
            raise ValueError(f"Invalid tensor metadata extent for {name}")
        dimensions = [integer(tail + 16 + i * 4, 4, end) for i in range(rank)]
        records.append({"name": name, "block": int(match[1]), "layer": int(match[2]),
                        "parameter": match[3], "resourceOffset": payload,
                        "byteLength": payload_size, "deviceCode": device,
                        "storageDimensions": dimensions, "tailFields": [field0, field1]})
        cursor = end
    if check_model and (len(records) != 153 or {r["block"] for r in records} != set(range(71))):
        raise ValueError("Expected exactly 153 records across blocks 0 through 70")
    if check_model and sum(r["byteLength"] for r in records) != 147_683_778:
        raise ValueError("Unexpected total payload size")
    return records


def pinned_dll(path: Path) -> bytes:
    dll = path.read_bytes()
    if digest(dll) != DLL_SHA256:
        raise ValueError("DLL hash differs from the verified original 310.8.0 runtime")
    return dll
