"""Canonical matrix-field names shared by model orientation and checkpoint packing.

This module is pure metadata: no Torch, NumPy, CUDA or runtime imports. A field
listed here is stored transposed by the training model and is transposed back
when decoding or packing native records.

It also owns the native layer-slot tables for the 1024- and 512-channel packing
families.  ``*_LAYER_FOR_*`` maps a packing kind to its record layer slot; the
``*_KIND_FOR_*_LAYER`` reverse maps are derived from those single declarations so
checkpoint planning and Small state cannot drift apart.
"""

MATRIX_FIELDS = frozenset((
    "w1",
    "w2",
    "w3",
    "w4",
    "qkv",
    "projection",
    "input_adapter",
    "head",
    "up_projection",
    "down_projection",
))

# C1024 transformer roles: FFN expand/contract, then attention qkv/projection.
LAYER_FOR_C1024_KIND = {
    "expand": 0,
    "contract": 1,
    "qkv": 2,
    "projection": 4,
}

# C512 decoder roles: FFN expand/projection, attention qkv/projection, downsample.
LAYER_FOR_C512_KIND = {
    "ffn": 0,
    "ffn_projection": 1,
    "qkv": 2,
    "projection": 3,
    "down": 4,
}

KIND_FOR_C1024_LAYER = {
    layer: kind for kind, layer in LAYER_FOR_C1024_KIND.items()
}
KIND_FOR_C512_LAYER = {
    layer: kind for kind, layer in LAYER_FOR_C512_KIND.items()
}

__all__ = [
    "KIND_FOR_C1024_LAYER",
    "KIND_FOR_C512_LAYER",
    "LAYER_FOR_C1024_KIND",
    "LAYER_FOR_C512_KIND",
    "MATRIX_FIELDS",
]
