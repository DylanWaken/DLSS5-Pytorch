"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct


def launch_spec(tokens):
    if type(tokens) is not int or not 32 <= tokens <= 4096 or tokens % 16:
        raise ValueError("QKV token count requires a multiple of16 in32..4096")
    padded = (tokens + 31) // 32 * 32
    return {"grid": [16 * ((tokens + 127) // 128), 1, 2], "block": [32, 4, 1],
            "parameter_bytes": 80, "output_bytes_each": padded * 1024,
            "counter_bytes": 16 * ((tokens + 127) // 128) * 4,
            "scratch_bytes": 3 * padded * 1024 * 2}


def parameter_blob(pointers, tokens):
    launch_spec(tokens)
    if len(pointers) != 7 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("seven nonzero unsigned CUDA pointers required")
    return struct.pack("<9Q2i", *pointers, 0, 0, 1, tokens)


def physical_to_logical_mapping(name, tokens=32):
    """Address-bit permutation with identical higher bits for further32-token tiles."""
    import numpy as np
    permutations = {"Q": (0, 3, 13, 4, 1, 2, 10, 11, 12, 5, 6, 7, 8, 9, 14),
                    "K": (0, 3, 4, 13, 1, 2, 10, 11, 12, 5, 6, 7, 8, 9, 14),
                    "V": (10, 13, 14, 3, 11, 12, 0, 1, 2, 4, 5, 6, 7, 8, 9)}
    if name not in permutations:
        raise ValueError("Q, K, or V required")
    launch_spec(tokens)
    physical = np.arange((tokens + 31) // 32 * 32 * 1024, dtype=np.int64)
    logical = physical & ~32767
    for bit, destination in enumerate(permutations[name]):
        logical |= ((physical >> bit) & 1) << destination
    return logical
