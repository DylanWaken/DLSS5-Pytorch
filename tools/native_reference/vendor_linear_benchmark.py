"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct
from .vendor_benchmark import output_offsets


def launch_spec(tokens):
    if type(tokens) is not int or not 32 <= tokens <= 4096 or tokens % 16:
        raise ValueError("linear token count requires a multiple of16 in32..4096")
    padded = (tokens + 31) // 32 * 32
    return {"grid": [8 * ((tokens + 127) // 128), 1, 4], "block": [32, 4, 1],
            "parameter_bytes": 72, "counter_bytes": 8 * ((tokens + 127) // 128) * 4,
            "scratch_bytes": padded * 1024 * 2, "output_bytes": padded * 1024}


def parameter_blob(pointers, tokens):
    launch_spec(tokens)
    if len(pointers) != 6 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("six nonzero unsigned CUDA pointers required")
    return struct.pack("<8Q2i", *pointers, 0, 0, 1, tokens)


def packed_input(codes):
    import numpy as np
    if codes.ndim != 2 or codes.shape[1] not in (1024, 4096) or codes.dtype != np.uint8:
        raise ValueError("uint8 token-by1024/4096 input required")
    launch_spec(codes.shape[0])
    packed = np.empty(codes.size, dtype=np.uint8)
    # The original FFN expansion output is exactly the canonical packed input
    # for the following contraction; this equals input_offsets + natural-K swizzle.
    packed[output_offsets(*codes.shape)] = codes
    return packed
