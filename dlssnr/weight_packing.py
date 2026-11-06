"""Native FP16 record packing and lossless promotion helpers.

These are the numerical ownership point for converting a decoded checkpoint
state into the original packed record layouts.  Serialization, deployment and
the CPU Small weight owner all consume the same functions here; the historical
:mod:`dlssnr.checkpoint` names remain explicit same-object re-exports.
"""
from __future__ import annotations

import numpy as np
import torch

from .common.weight_schema import MATRIX_FIELDS
from .geometry import align_up, block_channels
from .weights import packed_f16_weight_index, tiled_token

__all__ = [
    "FP8",
    "pack_kernel_fp16",
    "promote_tensor",
]

FP8 = torch.float8_e4m3fn


def promote_tensor(value, dtype):
    """Only equal storage or lossless widening formats; BF16 and Half are not ordered."""
    allowed = {
        FP8: (FP8, torch.float16, torch.bfloat16, torch.float32, torch.float64),
        torch.float16: (torch.float16, torch.float32, torch.float64),
        torch.bfloat16: (torch.bfloat16, torch.float32, torch.float64),
        torch.float32: (torch.float32, torch.float64),
        torch.float64: (torch.float64,),
    }
    if dtype not in allowed.get(value.dtype, ()):
        raise ValueError(f"{value.dtype} to {dtype} requires explicit quantization; automatic down-conversion is disabled")
    return value.to(dtype=dtype)


def _bias_indices():
    q = tiled_token(np.arange(64, dtype=np.int64))[:, None]
    k = np.arange(64, dtype=np.int64)[None, :]
    m, n = q & 15, k & 15
    lane = ((m & 7) << 2) | ((n & 7) >> 1)
    return (q >> 4) * 1024 + (k >> 4) * 256 + lane * 8 + (n >> 3) * 4 + (m >= 8) * 2 + (n & 1)


def _natural(state, block, name):
    value = state[f"blocks.{block}.{name}"]
    return value.transpose(-1, -2).contiguous() if name in MATRIX_FIELDS else value


def _half_matrix(value, k, n):
    value = promote_tensor(value, torch.float16).reshape(k, n).cpu().numpy()
    rows, cols = np.arange(k, dtype=np.int64)[:, None], np.arange(n, dtype=np.int64)[None, :]
    # Native records pad narrow heads to N16; unused channels must be deterministic.
    output = np.zeros(k * align_up(n, 16), dtype="<f2")
    output[packed_f16_weight_index(rows, cols, n)] = value
    return output.tobytes()


def _half_bias(value):
    value = promote_tensor(value, torch.float16).cpu().numpy()
    output = np.empty((value.shape[0], 4096), dtype="<f2")
    output[:, _bias_indices()] = value
    return output.tobytes()


def pack_kernel_fp16(state, block, kind):
    """Pack original K16 records from losslessly widened checkpoint tensors."""
    c = block_channels(block)
    get = lambda name: _natural(state, block, name)
    if (block == 0 and kind in ("window", "preprocess")) or (block == 70 and kind in ("window", "postprocess")):
        if block == 0:
            layout = dict(w1=0, w2=8192, input_adapter=16400, ffn_scale=17424,
                          qkv=17504, bias=23648, head_scale=31840, projection=31856, attn_scale=33904)
            matrices = [("w1", 32, 128), ("w2", 128, 32), ("input_adapter", 16, 32),
                        ("qkv", 32, 96), ("projection", 32, 32)]
            vectors = ("ffn_scale", "head_scale", "attn_scale")
            output = bytearray(33984)
        else:
            layout = dict(w1=0, w2=8192, ffn_scale=16400, input_scale=16464, adapter_scale=16528,
                          qkv=16592, bias=22736, head_scale=30928, projection=30944,
                          attn_scale=32992, head=33072)
            matrices = [("w1", 32, 128), ("w2", 128, 32), ("qkv", 32, 96),
                        ("projection", 32, 32), ("head", 32, 4)]
            vectors = ("ffn_scale", "input_scale", "adapter_scale", "head_scale", "attn_scale")
            output = bytearray(34096)
        # The input adapter and output head stay Half in both native precisions.
        for name, rows, columns in matrices:
            raw = _half_matrix(get(name), rows, columns)
            output[layout[name]:layout[name] + len(raw)] = raw
        for name in vectors:
            dtype = torch.float32 if name == "head_scale" else torch.float16
            raw = promote_tensor(get(name), dtype).cpu().numpy().tobytes()
            output[layout[name]:layout[name] + len(raw)] = raw
        raw = _half_bias(get("bias"))
        output[layout["bias"]:layout["bias"] + len(raw)] = raw
        return bytes(output)
    if kind == "window" and c in (32, 64, 128, 256) and block not in (0, 70):
        if c == 32:
            layout = dict(w1=0, w2=8192, ffn_scale=16400, qkv=16480, relative=22624,
                          head_scale=30816, projection=30832, attn_scale=32880, size=32960)
            matrices = [("w1", c, 128), ("w2", 128, c)]
        else:
            w2 = 8 * c * c
            w3 = w2 + 256 * c
            ffn = w3 + 2 * c * c + 16
            qkv = ffn + 2 * c + 16
            bias = qkv + 6 * c * c
            head = bias + c // 32 * 8192
            projection = head + align_up(c // 32 * 4, 16)
            attention = projection + 2 * c * c
            layout = dict(w1=0, w2=w2, w3=w3, ffn_scale=ffn, qkv=qkv, relative=bias,
                          head_scale=head, projection=projection, attn_scale=attention,
                          size=align_up(attention + 2 * c, 64))
            matrices = [("w1", c // 32 * c, 128), ("w2", c // 32 * 128, 32), ("w3", c, c)]
        end = layout["attn_scale"] + 2 * c
        if block in (48, 56, 62, 66):
            total = 16384 if c == 32 else layout["w3"] + 2 * c * c
            padding = 16 if c == 32 else 0
            layout["up_projection"] = total
            layout["ffn_scale"] = total + 4 * c * c + padding
            layout["transition_scale"] = layout["ffn_scale"] + 2 * c + padding
            layout["qkv"] = layout["transition_scale"] + 2 * c
            layout["relative"] = layout["qkv"] + 6 * c * c
            layout["head_scale"] = layout["relative"] + c // 32 * 8192
            layout["projection"] = layout["head_scale"] + align_up(c // 32 * 4, 16)
            layout["attn_scale"] = layout["projection"] + 2 * c * c
            end = layout["attn_scale"] + 2 * c
            matrices.append(("up_projection", 2 * c, c))
        elif block in (4, 8, 14, 22):
            layout["down_projection"] = end
            matrices.append(("down_projection", c, 2 * c))
            end += 4 * c * c
        output = bytearray(align_up(end, 64))
        for name, k, n in matrices + [("qkv", c, 3 * c), ("projection", c, c)]:
            raw = _half_matrix(get(name), k, n)
            output[layout[name]:layout[name] + len(raw)] = raw
        for name in ("ffn_scale", "attn_scale", "head_scale", "transition_scale"):
            if name not in layout:
                continue
            dtype = torch.float32 if name == "head_scale" else torch.float16
            raw = promote_tensor(get(name), dtype).cpu().numpy().tobytes()
            output[layout[name]:layout[name] + len(raw)] = raw
        raw = _half_bias(get("bias"))
        output[layout["relative"]:layout["relative"] + len(raw)] = raw
        return bytes(output)
    if c == 512 and block != 39 and kind == "ffn":
        return b"".join(_half_matrix(get(name), k, n) for name, k, n in
                        (("w1", 512, 512), ("w2", 512, 256), ("w3", 2048, 64)))
    if c == 512 and block != 39 and kind == "qkv":
        return (_half_matrix(get("qkv"), 512, 1536) + _half_bias(get("bias")) +
                promote_tensor(get("head_scale"), torch.float32).cpu().numpy().tobytes())
    vector = lambda name, dtype=torch.float16: promote_tensor(get(name), dtype).cpu().numpy().tobytes()
    if block == 39 and kind == "upsample":
        return _half_matrix(get("up_projection"), 1024, 512) + vector("transition_scale")
    if c == 512 and block != 39:
        if kind in ("ffn_projection", "projection"):
            return _half_matrix(get("w4" if kind == "ffn_projection" else "projection"), c, c) + vector("ffn_scale" if kind == "ffn_projection" else "attn_scale")
        if block == 30 and kind == "down":
            return _half_matrix(get("down_projection"), 512, 1024) + bytes(16)
    if c == 1024:
        if kind == "expand":
            return _half_matrix(get("w1"), 1024, 4096)
        if kind == "contract":
            return _half_matrix(get("w2"), 4096, 1024) + vector("ffn_scale")
        if kind == "qkv":
            return vector("head_scale", torch.float32) + _half_matrix(get("qkv"), 1024, 3072)
        if kind == "projection":
            return _half_matrix(get("projection"), 1024, 1024) + vector("attn_scale")
    raise ValueError(f"Unsupported FP16 record role: block={block}, kind={kind}")
