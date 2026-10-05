"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct
from .vendor_benchmark import output_offsets


KERNELS = {32: (0, "cc_tinlayout_fused_swin_1h_32_1_fp8", "feb368ff5279a7408b1e55554db6e468d7f114a24b18b2af8d7e6989a410c612"),
           64: (1, "cc_tinlayout_fused_swin_2h_64_2_fp8", "a10a8083b9489622fe290d669f05f38db7308c3c10771d0f0d6f22718e3cb1ae"),
           128: (2, "cc_tinlayout_fused_swin_4h_128_4_fp8", "9cba6bc0001a80c902ee20fd5638bf442bdf0674aaada676d67a6d1b89ca0aaa"),
           256: (3, "cc_tinlayout_fused_swin_8h_256_8_fp8", "46ad7753bfb3a70a92a3524a5e638bb2fe93edb37cf3389ad1fa524e4e19b084"),
           512: (4, "cc_split_swin_16h_qkv_512_fp8", "97bdf9a571dec8bff41975fe670610b0a3363b49885ada171e61229578ecf569")}


def launch_spec(height, width, channels, phase):
    if channels not in KERNELS or phase not in range(4):
        raise ValueError("reviewed C32/64/128/256/512 and phase0..3 required")
    if any(type(n) is not int or n < 8 or n > 8192 or n % 4 for n in (height, width)):
        raise ValueError("image dimensions must be multiples of4 in8..8192")
    if height * width * channels >= 2**31:
        raise ValueError("native image byte offsets must fit signed32-bit arithmetic")
    sx, sy = ((0, 0), (4, 4), (4, 0), (0, 4))[phase]
    return {"grid": [(width + sx + 7) // 8, (height + sy + 7) // 8, 4 if channels == 512 else 1],
            "block": [32, 4 if channels == 512 else channels // 32, 1],
            "parameter_bytes": 96 if channels == 32 else 56 if channels == 512 else 88,
            "origin": [-sx, -sy], "image_bytes": height * width * channels}


def parameter_blob(pointers, height, width, channels, phase, view="none"):
    spec = launch_spec(height, width, channels, phase)
    if len(pointers) != 3 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("three nonzero unsigned CUDA pointers required")
    if view not in ("none", "input", "output") or (view != "none" and channels == 512):
        raise ValueError("view adapters are reviewed for C32/64/128/256 only")
    if channels == 32:
        blob = bytearray(struct.pack("<3Q4i7Q", *pointers, height, width, *spec["origin"], *([0] * 7)))
    elif channels == 512:
        blob = bytearray(struct.pack("<3Q4i2Q", *pointers, height, width, *spec["origin"], 0, 0))
    else:
        blob = bytearray(struct.pack("<4Q4i5Q", *pointers, 0, height, width, *spec["origin"], *([0] * 5)))
    if view != "none":
        struct.pack_into("<2i", blob, 72 if channels == 32 else 80, height, width)
    return bytes(blob)


def image_offsets(height, width, channels):
    import numpy as np
    launch_spec(height, width, 512 if channels == 1024 else channels, 0)
    y, x = np.arange(height)[:, None], np.arange(width)[None, :]
    token = ((y // 4) * (width // 4) + x // 4) * 16 + (y % 4) * 4 + x % 4
    return output_offsets(height * width, channels)[token]
