"""Native ctypes ABI contract and RGB display patch/assertions.

This is the only owner of the Python mirror of the postprocess parameter block
and of the compiler-checked OutputScale/bDisplayOutput offsets.  Importing it
must not load Pillow, media rendering or a native extension.
"""
from __future__ import annotations

import ctypes

import numpy as np
import torch


PREPROCESS_NAMES = {
    "fp8": "input_preprocess_window_downsample_c32_fp8",
    "fp16": "input_preprocess_window_downsample_c32_fp16",
}
POSTPROCESS_NAMES = {
    "fp8": "output_window_postprocess_c32_fp8",
    "fp16": "output_window_postprocess_c32_fp16",
}

# FPostprocessParameters (csrc/kernel_impl/shared/common/kernel_abi.h:56-70) is
# 184 bytes.  These two fields are what make the native compositor emit RGB:
# OutputScale=1/32 and bDisplayOutput=1, i.e. clamp(c + head/4, 0, 1).
POST_ABI_BYTES = 184
POST_OUTPUT_SCALE_OFFSET = 48
POST_DISPLAY_OUTPUT_OFFSET = 52
POST_OUTPUT_SCALE = 1.0 / 32.0
POST_DISPLAY_OUTPUT = 1

PRE_ABI_BYTES = 264


class _FTextureTransform(ctypes.Structure):
    # kernel_abi.h: "bias/scale, then normalization, in this exact order".
    _fields_ = [
        ("BiasX", ctypes.c_float),
        ("BiasY", ctypes.c_float),
        ("ScaleX", ctypes.c_float),
        ("ScaleY", ctypes.c_float),
        ("NormalizeX", ctypes.c_float),
        ("NormalizeY", ctypes.c_float),
    ]


class _FPostprocessParameters(ctypes.Structure):
    """Mirror of the C++ postprocess ABI used only to assert field offsets."""

    _fields_ = [
        ("g_Input", ctypes.c_uint64),
        ("g_Adapter", ctypes.c_uint64),
        ("OutputSurface", ctypes.c_uint64),
        ("g_PackedWeights", ctypes.c_uint64),
        ("Height", ctypes.c_int32),
        ("Width", ctypes.c_int32),
        ("OriginX", ctypes.c_int32),
        ("OriginY", ctypes.c_int32),
        ("OutputScale", ctypes.c_float),
        ("bDisplayOutput", ctypes.c_uint32),
        ("ColorTexture", ctypes.c_uint64),
        ("ColorTransform", _FTextureTransform),
        ("HistoryTexture", ctypes.c_uint64),
        ("MotionTexture", ctypes.c_uint64),
        ("g_BlendScale", ctypes.c_uint64),
        ("bApplyMotion", ctypes.c_uint32),
        ("HistoryTransform", _FTextureTransform),
        ("MotionTransform", _FTextureTransform),
        ("MotionScaleX", ctypes.c_float),
        ("MotionScaleY", ctypes.c_float),
        ("ValidWidth", ctypes.c_int32),
        ("ValidHeight", ctypes.c_int32),
        ("ReservedPadding", ctypes.c_uint32),
    ]


# Source-checked layout invariants.  If the native ABI changes, importing this
# module fails loudly instead of silently writing the wrong display flags.
assert ctypes.sizeof(_FPostprocessParameters) == POST_ABI_BYTES
assert _FPostprocessParameters.OutputScale.offset == POST_OUTPUT_SCALE_OFFSET
assert _FPostprocessParameters.bDisplayOutput.offset == POST_DISPLAY_OUTPUT_OFFSET
assert POST_OUTPUT_SCALE == 0.03125


def _postprocess_array(configuration) -> np.ndarray:
    if isinstance(configuration, torch.Tensor):
        if (configuration.device.type != "cpu" or configuration.dtype != torch.uint8
                or configuration.dim() != 1):
            raise TypeError("postprocess ABI must be a CPU uint8 1-D tensor")
        array = configuration.numpy()
    else:
        array = np.frombuffer(configuration, dtype=np.uint8)
    if array.size != POST_ABI_BYTES:
        raise ValueError(
            f"postprocess ABI is {array.size} bytes; expected {POST_ABI_BYTES}")
    return array


def patch_postprocess_display(configuration):
    """Set the RGB display ABI in place and verify the written values.

    ``configuration`` is the CPU uint8 blob returned by
    :func:`dlssnr.deployment.frontend_configuration` for a postprocess name (or
    an equivalent writable 184-byte buffer).  The builder defaults are NOT RGB;
    this function is the only supported way to make the compositor emit RGB.
    """
    array = _postprocess_array(configuration)
    if not array.flags.writeable:
        raise ValueError("postprocess ABI patch requires a writable bytearray or CPU uint8 tensor")
    array[POST_OUTPUT_SCALE_OFFSET:POST_OUTPUT_SCALE_OFFSET + 4].view("<f4")[0] = POST_OUTPUT_SCALE
    array[POST_DISPLAY_OUTPUT_OFFSET:POST_DISPLAY_OUTPUT_OFFSET + 4].view("<u4")[0] = POST_DISPLAY_OUTPUT
    scale, display = postprocess_display_values(array)
    if scale != POST_OUTPUT_SCALE or display != POST_DISPLAY_OUTPUT:
        raise AssertionError("postprocess display ABI patch did not round-trip")
    return configuration


def postprocess_display_values(configuration) -> tuple[float, int]:
    """Read ``(OutputScale, bDisplayOutput)`` from a postprocess ABI blob."""
    array = _postprocess_array(configuration)
    scale = float(array[POST_OUTPUT_SCALE_OFFSET:POST_OUTPUT_SCALE_OFFSET + 4].view("<f4")[0])
    display = int(array[POST_DISPLAY_OUTPUT_OFFSET:POST_DISPLAY_OUTPUT_OFFSET + 4].view("<u4")[0])
    return scale, display


def assert_postprocess_display(configuration):
    """Require the RGB display ABI; used before every native post binding."""
    scale, display = postprocess_display_values(configuration)
    if scale != POST_OUTPUT_SCALE or display != POST_DISPLAY_OUTPUT:
        raise ValueError(
            "postprocess configuration is not RGB display: "
            f"OutputScale={scale!r}, bDisplayOutput={display!r}; "
            "expected 1/32 and 1")
    return configuration
