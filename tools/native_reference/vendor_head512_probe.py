"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct
from .vendor_window_benchmark import launch_spec as window_spec


KERNEL = "cc_split_swin_16h_final_head_512_fp8"


def launch_spec(height, width):
    window_spec(height, width, 512, 0)
    return {"grid": [4 * ((width + 7) // 8), (height + 7) // 8, 1], "block": [32, 8, 1]}


def parameter_blob(pointers, height, width):
    launch_spec(height, width)
    if len(pointers) != 3 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("three nonzero unsigned pointers required")
    return struct.pack("<4Q2i", *pointers, 0, height, width)
