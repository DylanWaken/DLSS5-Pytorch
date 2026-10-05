"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct
from .vendor_window_benchmark import parameter_blob


BLOCKS = {32: 66, 64: 62, 128: 56, 256: 48}


def up_blob(pointers, height, width, channels, phase):
    if channels not in BLOCKS or min(height, width) < 16 or height % 4 or width % 4:
        raise ValueError("target dimensions must be multiples of four >=16")
    if len(pointers) != 4 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("four unsigned nonzero pointers required")
    blob = bytearray(parameter_blob(pointers[:3], height, width, channels, phase))
    if channels == 32:
        struct.pack_into("<Q2i", blob, 80, pointers[3], height, width)
    else:
        struct.pack_into("<Q", blob, 24, pointers[3])
    return bytes(blob)
