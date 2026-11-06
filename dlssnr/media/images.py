"""Image decode/encode and RGB/RGBA representation helpers.

Pillow stays an optional, lazy dependency owned by this module; importing the
native frontend never touches it.
"""
from __future__ import annotations

from pathlib import Path

import numpy as np


IMAGE_SUFFIXES = (".png", ".jpg", ".jpeg")


# -- frame decoding / conversion --------------------------------------------


def _pillow():
    try:
        from PIL import Image, ImageDraw, ImageFont
    except ImportError as error:  # pragma: no cover - environment guard
        raise RuntimeError(
            "PNG frame handling requires Pillow (pip install Pillow); "
            "the native chain itself has no imaging dependency") from error
    return Image, ImageDraw, ImageFont


def decode_rgb_image(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode an 8-bit PNG/JPEG to ``uint8 [H,W,3]`` exactly once.

    The image is display-referred coded RGB; the only conversion is the codec
    decode plus an optional RGB conversion for palette/RGBA/grayscale inputs.
    There is no resize, no model-input crop, no EOTF/OETF and no filtering.
    """
    Image, _, _ = _pillow()
    path = Path(path)
    if path.suffix.lower() not in IMAGE_SUFFIXES:
        raise ValueError(
            f"unsupported image {path.suffix!r}; expected one of {IMAGE_SUFFIXES}")
    with Image.open(path) as image:
        if image.mode != "RGB":
            image = image.convert("RGB")
        rgb = np.asarray(image, dtype=np.uint8)
    if rgb.ndim != 3 or rgb.shape[2] != 3:
        raise ValueError(f"{path} did not decode to RGB")
    if expected_width is not None and rgb.shape[1] != expected_width:
        raise ValueError(f"{path} width {rgb.shape[1]} != expected {expected_width}")
    if expected_height is not None and rgb.shape[0] != expected_height:
        raise ValueError(f"{path} height {rgb.shape[0]} != expected {expected_height}")
    return np.ascontiguousarray(rgb)


def decode_rgb_png(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode an 8-bit RGB PNG to ``uint8 [H,W,3]`` (no transfer-function work).

    Kept as the explicit PNG entry point used by the frame/video path; see
    :func:`decode_rgb_image` for the still-image JPEG/PNG entry point.
    """
    path = Path(path)
    if path.suffix.lower() != ".png":
        raise ValueError(f"decode_rgb_png requires a .png path, got {path.suffix!r}")
    return decode_rgb_image(path, expected_width=expected_width,
                            expected_height=expected_height)


def save_rgb_png(rgb: np.ndarray, path):
    """Write an 8-bit RGB PNG; the caller passes display-coded values."""
    Image, _, _ = _pillow()
    rgb = np.asarray(rgb)
    if rgb.dtype != np.uint8 or rgb.ndim != 3 or rgb.shape[2] != 3:
        raise ValueError("save_rgb_png requires uint8 [H,W,3]")
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    Image.fromarray(np.ascontiguousarray(rgb)).save(path, format="PNG")
    return path


def rgb_to_rgba(rgb: np.ndarray) -> np.ndarray:
    """RGB24 uint8 -> RGBA float32 in [0,1] with alpha 1 (no EOTF)."""
    rgb = np.asarray(rgb)
    if rgb.dtype != np.uint8 or rgb.ndim != 3 or rgb.shape[2] != 3:
        raise ValueError("rgb_to_rgba requires uint8 [H,W,3]")
    rgba = np.empty((rgb.shape[0], rgb.shape[1], 4), dtype=np.float32)
    rgba[:, :, :3] = rgb.astype(np.float32) / np.float32(255.0)
    rgba[:, :, 3] = 1.0
    return rgba


def load_frame_rgba(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode a PNG frame and return valid-size RGBA float32 coded RGB."""
    return rgb_to_rgba(decode_rgb_png(path, expected_width=expected_width,
                                      expected_height=expected_height))


def load_image_rgba(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode a PNG/JPEG still and return full-size RGBA float32 coded RGB."""
    return rgb_to_rgba(decode_rgb_image(path, expected_width=expected_width,
                                        expected_height=expected_height))
