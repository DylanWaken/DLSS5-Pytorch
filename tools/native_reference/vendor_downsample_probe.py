"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct
from .vendor_window_benchmark import parameter_blob


BLOCKS = {32: 4, 64: 8, 128: 14, 256: 22}


def half_extent(value):
    return ((value + 1) // 2 + 3) // 4 * 4


def down_storage_bytes(height, width, channels):
    """Reserve the original padding-clear footprint outside the logical bytes.

    The C64/128/256 PTX clear loop addresses twice the FP8 channel-plane
    extent. Ordinary projected bytes still occupy its first half. The second
    half is workspace, with an independent outer guard supplied by callers.
    Padded C32 has a different compact stride and is not mapped here.
    """
    padded = height != 2 * half_extent(height) or width != 2 * half_extent(width)
    if channels == 32 and padded:
        raise ValueError("padded C32 transition uses an unreviewed compact plane stride")
    return half_extent(height) * half_extent(width) * 2 * channels * (2 if padded else 1)


def down_offsets(height, width, channels):
    import numpy as np
    if channels not in (32, 64, 128, 256, 512) or min(height, width) < 8 or height % 4 or width % 4:
        raise ValueError("reviewed target dimensions require multiples of four >=8 and C32/64/128/256/512")
    y, x, c = np.arange(height)[:, None, None], np.arange(width)[None, :, None], np.arange(channels)[None, None, :]
    byte = ((c % 8) // 2) * 4 + ((c % 16) // 8) * 2 + c % 2
    return ((c // 16) * height * width + y * width + x) * 16 + byte


def down_blob(pointers, height, width, channels, phase):
    if channels not in BLOCKS or min(height, width) < 16 or height % 4 or width % 4:
        raise ValueError("source dimensions must be multiples of four >=16")
    if len(pointers) != 4 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("four unsigned nonzero pointers required")
    blob = bytearray(parameter_blob(pointers[:3], height, width, channels, phase))
    position = 64 if channels == 32 else 72
    struct.pack_into("<Q2i", blob, position, pointers[3], half_extent(height), half_extent(width))
    return bytes(blob)
