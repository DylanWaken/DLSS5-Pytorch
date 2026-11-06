"""Three-way display panels, captions and shared-ROI comparison helpers.

These are presentation-only artifacts; they never resize a native model input
or an arm artifact.  Pillow is reached through the lazy loader in media.images.
"""
from __future__ import annotations

import math
from typing import Sequence

import numpy as np

from .images import _pillow


# -- three-way panel --------------------------------------------------------

PANEL_WIDTH = 1024
PANEL_HEIGHT = 600
PANEL_DISPLAY_WIDTH = 1280
PANEL_HEADER_HEIGHT = 46
PANEL_FOOTER_HEIGHT = 34
PANEL_GAP = 8
PANEL_TOTAL_WIDTH = PANEL_WIDTH * 3 + PANEL_GAP * 2
PANEL_TOTAL_HEIGHT = PANEL_HEADER_HEIGHT + PANEL_HEIGHT + PANEL_FOOTER_HEIGHT
PANEL_FILTER_NAME = "LANCZOS"
PANEL_FILTER_DESCRIPTION = "Pillow Image.Resampling.LANCZOS"

DEFAULT_FOOTER = (
    "RGB-only stateless mode: empty history/motion/depth/conditioning/blend; "
    "fixed session noise seed; coded RGB [0,1], no EOTF. Original panel is the "
    "unchanged decoded frame. No quality or vendor-parity claim.")


def _positive_int(value, role: str) -> int:
    if isinstance(value, bool) or not isinstance(value, int) or value < 1:
        raise ValueError(f"{role} must be a positive integer, got {value!r}")
    return value


def _aspect_ratio_text(width: int, height: int) -> str:
    divisor = math.gcd(int(width), int(height))
    return f"{width // divisor}:{height // divisor}"


def display_panel_geometry(source_width: int, source_height: int,
                           panel_width: int = PANEL_DISPLAY_WIDTH, *,
                           header_height: int = PANEL_HEADER_HEIGHT,
                           footer_height: int = PANEL_FOOTER_HEIGHT,
                           gap: int = PANEL_GAP,
                           allow_upscale: bool = False) -> dict:
    """Describe the display-only three-way panel for one source geometry.

    ``source_width``/``source_height`` are the decoded source (native model
    input) dimensions.  ``panel_width`` is the requested display width of ONE
    panel; the other two panels are identical.  Scaling is aspect-preserving and
    downscale-only unless ``allow_upscale`` is explicitly requested.  The native
    model input and the per-arm original/legacy71/small31 artifacts are never
    resized by this description.
    """
    source_width = _positive_int(source_width, "source width")
    source_height = _positive_int(source_height, "source height")
    panel_width = _positive_int(panel_width, "panel width")
    header_height = _positive_int(header_height, "panel header height")
    footer_height = _positive_int(footer_height, "panel footer height")
    gap = _positive_int(gap, "panel gap")
    if not isinstance(allow_upscale, bool):
        raise TypeError("allow_upscale must be a boolean")

    effective_width = panel_width if (allow_upscale or panel_width <= source_width) else source_width
    # Preserve the source aspect ratio exactly at the chosen width.  The panel
    # height is the single rounded dimension; no independent x/y scaling is
    # performed anywhere in the composer.
    panel_height = max(1, int(round(source_height * effective_width / source_width)))
    total_width = effective_width * 3 + gap * 2
    total_height = header_height + panel_height + footer_height
    scale = effective_width / source_width
    return {
        "source": {
            "width": source_width,
            "height": source_height,
            "aspect_ratio": _aspect_ratio_text(source_width, source_height),
            "aspect_decimal": source_width / source_height,
        },
        "native_arm_output": {
            "width": source_width,
            "height": source_height,
            "resize": False,
            "note": "original/legacy71/small31 PNGs and videos keep the decoded source extent",
        },
        "panel": {
            "width": effective_width,
            "height": panel_height,
            "requested_width": panel_width,
            "aspect_ratio": _aspect_ratio_text(effective_width, panel_height),
            "aspect_decimal": effective_width / panel_height,
            "downscaled": effective_width < source_width,
            "upscaled": effective_width > source_width,
            "scale": scale,
        },
        "layout": {
            "header_height": header_height,
            "footer_height": footer_height,
            "gap": gap,
            "total_width": total_width,
            "total_height": total_height,
        },
        "output_dimensions": {"width": total_width, "height": total_height},
        "filter": PANEL_FILTER_DESCRIPTION,
        "filter_name": PANEL_FILTER_NAME,
        "allow_upscale": allow_upscale,
        "display_only": True,
        "inference_resize": False,
        "model_input_resize": False,
        "source_pixels_unchanged": True,
    }


def panel_regions(width: int = PANEL_WIDTH, height: int = PANEL_HEIGHT, *,
                  header_height: int = PANEL_HEADER_HEIGHT,
                  gap: int = PANEL_GAP) -> tuple[dict, ...]:
    """Pixel regions of the three equal ``width`` by ``height`` display panels."""
    width = _positive_int(width, "panel width")
    height = _positive_int(height, "panel height")
    header_height = _positive_int(header_height, "panel header height")
    gap = _positive_int(gap, "panel gap")
    return tuple({
        "name": name,
        "x0": index * (width + gap),
        "y0": header_height,
        "x1": index * (width + gap) + width,
        "y1": header_height + height,
    } for index, name in enumerate(("original", "legacy71", "small31")))


def _pillow_lanczos():
    _, _, _ = _pillow()
    from PIL import Image
    resampling = getattr(Image, "Resampling", None)
    return resampling.LANCZOS if resampling is not None else Image.LANCZOS


def resize_rgb_for_display(rgb: np.ndarray, width: int, height: int) -> np.ndarray:
    """Resize one display panel with LANCZOS (aspect handled by the caller)."""
    Image, _, _ = _pillow()
    array = np.asarray(rgb)
    if array.dtype != np.uint8 or array.ndim != 3 or array.shape[2] != 3:
        raise ValueError("display resize requires uint8 [H,W,3]")
    width = _positive_int(width, "display width")
    height = _positive_int(height, "display height")
    if array.shape[:2] == (height, width):
        return np.ascontiguousarray(array)
    resized = Image.fromarray(np.ascontiguousarray(array)).resize(
        (width, height), _pillow_lanczos())
    return np.asarray(resized, dtype=np.uint8)


def _panel_font(size: int):
    _, _, ImageFont = _pillow()
    for name in ("seguisb.ttf", "arial.ttf", "DejaVuSans.ttf"):
        try:
            return ImageFont.truetype(name, size)
        except OSError:
            continue
    try:
        return ImageFont.load_default(size=size)
    except TypeError:  # pragma: no cover - old Pillow
        return ImageFont.load_default()


def compose_comparison_panel(original_rgb, legacy_rgb, small_rgb, *, captions=None,
                             footer=DEFAULT_FOOTER,
                             panel_width: int = PANEL_DISPLAY_WIDTH,
                             allow_upscale: bool = False,
                             header_height: int = PANEL_HEADER_HEIGHT,
                             footer_height: int = PANEL_FOOTER_HEIGHT,
                             gap: int = PANEL_GAP) -> np.ndarray:
    """Compose three equal RGB frames as an explicitly display-scaled panel.

    Any equal ``HxWx3`` uint8 inputs are accepted.  The source extent determines
    the aspect ratio; each panel is rendered at the requested display width
    (downscale-only by default, so an explicit width larger than the source is
    clamped rather than upscaled).  The three display panels, headers, gaps and
    footer are derived from the actual geometry.  Inputs are never modified and
    no per-arm artifact is resized by this function.
    """
    Image, ImageDraw, _ = _pillow()
    panels = [np.asarray(value) for value in (original_rgb, legacy_rgb, small_rgb)]
    shapes = [panel.shape[:2] for panel in panels]
    for name, panel in zip(("original", "legacy71", "small31"), panels):
        if panel.dtype != np.uint8 or panel.ndim != 3 or panel.shape[2] != 3:
            raise ValueError(f"{name} panel must be uint8 [H,W,3]")
        if panel.shape[0] < 1 or panel.shape[1] < 1:
            raise ValueError(f"{name} panel is empty")
    if any(shape != shapes[0] for shape in shapes):
        raise ValueError(
            "three-way panels must share one size (no individual upscale), got "
            f"{[(width, height) for height, width in shapes]}")
    source_height, source_width = shapes[0]
    geometry = display_panel_geometry(
        source_width, source_height, panel_width, header_height=header_height,
        footer_height=footer_height, gap=gap, allow_upscale=allow_upscale)
    panel_size = (geometry["panel"]["width"], geometry["panel"]["height"])
    layout = geometry["layout"]
    captions = dict(captions or {})
    header_font = _panel_font(17)
    footer_font = _panel_font(14)
    canvas = Image.new("RGB", (layout["total_width"], layout["total_height"]), (0, 0, 0))
    display_panels = [resize_rgb_for_display(panel, *panel_size) for panel in panels]
    regions = panel_regions(panel_size[0], panel_size[1], header_height=header_height,
                            gap=gap)
    for region, panel in zip(regions, display_panels):
        canvas.paste(Image.fromarray(np.ascontiguousarray(panel)),
                     (region["x0"], region["y0"]))
    draw = ImageDraw.Draw(canvas)
    for region, key in zip(regions, ("original", "legacy71", "small31")):
        text = str(captions.get(key, key.upper()))
        draw.text((region["x0"] + 6, 6), text, fill=(235, 235, 235), font=header_font)
    draw.text((6, header_height + panel_size[1] + 8), str(footer),
              fill=(190, 190, 190), font=footer_font)
    return np.asarray(canvas, dtype=np.uint8)


def compose_full_resolution_panel(original_rgb, legacy_rgb, small_rgb, *, captions=None,
                                  footer=DEFAULT_FOOTER, header_height=PANEL_HEADER_HEIGHT,
                                  footer_height=PANEL_FOOTER_HEIGHT,
                                  gap=PANEL_GAP) -> np.ndarray:
    """Compose three unchanged full-resolution RGB images side by side.

    Unlike :func:`compose_comparison_panel`, this entry point does not require a
    1024x600 frame: each input is pasted at its own native size with no resize.
    Labels are drawn horizontally above each panel.  The returned image is
    ``header + max(height) + (footer if footer else 0)`` tall.
    """
    Image, ImageDraw, _ = _pillow()
    panels = [np.asarray(value) for value in (original_rgb, legacy_rgb, small_rgb)]
    shapes = [panel.shape[:2] for panel in panels]
    for name, panel in zip(("original", "legacy71", "small31"), panels):
        if panel.dtype != np.uint8 or panel.ndim != 3 or panel.shape[2] != 3:
            raise ValueError(f"{name} panel must be uint8 [H,W,3]")
        if panel.shape[0] < 1 or panel.shape[1] < 1:
            raise ValueError(f"{name} panel is empty")
    height = max(shape[0] for shape in shapes)
    width = max(shape[1] for shape in shapes)
    if any(shape != (height, width) for shape in shapes):
        raise ValueError(
            f"three-way panels must share one size, got {[(w, h) for h, w in shapes]}")
    captions = dict(captions or {})
    header_height = int(header_height)
    gap = int(gap)
    footer_height = int(footer_height) if footer else 0
    total_width = width * 3 + gap * 2
    total_height = header_height + height + footer_height
    canvas = Image.new("RGB", (total_width, total_height), (0, 0, 0))
    regions = []
    for index, panel in enumerate(panels):
        x0 = index * (width + gap)
        regions.append((x0, header_height, x0 + width, header_height + height))
        canvas.paste(Image.fromarray(np.ascontiguousarray(panel)), (x0, header_height))
    draw = ImageDraw.Draw(canvas)
    header_font = _panel_font(max(12, min(24, header_height - 22)))
    for (x0, _, _, _), key in zip(regions, ("original", "legacy71", "small31")):
        draw.text((x0 + 6, 6), str(captions.get(key, key.upper())),
                  fill=(235, 235, 235), font=header_font)
    if footer:
        footer_font = _panel_font(14)
        draw.text((6, header_height + height + 8), str(footer),
                  fill=(190, 190, 190), font=footer_font)
    return np.asarray(canvas, dtype=np.uint8)


def validate_roi(roi, width: int, height: int) -> tuple[int, int, int, int] | None:
    """Validate an explicit ``(x, y, width, height)`` ROI in source pixels."""
    if roi is None:
        return None
    values = tuple(roi)
    if len(values) != 4:
        raise ValueError("ROI must be exactly x y width height")
    if any(isinstance(value, bool) or not isinstance(value, int) for value in values):
        raise TypeError("ROI values must be integers")
    x, y, w, h = values
    if x < 0 or y < 0 or w < 1 or h < 1:
        raise ValueError("ROI requires x,y >= 0 and width,height >= 1")
    if x + w > width or y + h > height:
        raise ValueError(
            f"ROI {values} is outside the {width}x{height} decoded source image")
    return values


def crop_rgb(rgb: np.ndarray, roi) -> np.ndarray:
    """Crop one RGB/RGBA image with an already validated ROI (same coordinates)."""
    array = np.asarray(rgb)
    if array.ndim != 3 or array.shape[2] not in (3, 4):
        raise ValueError("crop_rgb requires HxWx3 or HxWx4")
    x, y, w, h = validate_roi(roi, array.shape[1], array.shape[0])
    return np.ascontiguousarray(array[y:y + h, x:x + w])


def crop_same_roi(images: Sequence[np.ndarray], roi) -> dict:
    """Crop three same-sized native arms with one source-pixel ROI.

    The coordinates are validated against the shared decoded source extent and
    applied verbatim to every arm.  This is a separate analysis artifact only:
    the ROI is never used as a model-input crop and the cropped arms are never
    rescaled here.
    """
    arrays = [np.asarray(image) for image in images]
    if len(arrays) != 3:
        raise ValueError("ROI crop requires exactly three RGB arms")
    names = ("original", "legacy71", "small31")
    for name, array in zip(names, arrays):
        if array.ndim != 3 or array.shape[2] not in (3, 4):
            raise ValueError(f"{name} arm must be HxWx3 or HxWx4")
    shapes = [array.shape[:2] for array in arrays]
    if any(shape != shapes[0] for shape in shapes):
        raise ValueError(
            f"ROI arms must share one size, got {[(w, h) for h, w in shapes]}")
    height, width = shapes[0]
    x, y, w, h = validate_roi(roi, width, height)
    return {
        name: np.ascontiguousarray(array[y:y + h, x:x + w])
        for name, array in zip(names, arrays)
    }


def comparison_captions(model_descriptions: Sequence[dict], *, width=None,
                        height=None) -> dict:
    """Exact version/model/precision headers for the three-way panel."""
    by_model = {item["model"]: item for item in model_descriptions}
    legacy = by_model.get("legacy71", {})
    small = by_model.get("small31", {})
    dimensions = f"{width}x{height} " if width and height else ""
    return {
        "original": f"ORIGINAL - decoded {dimensions}source frame (unchanged)",
        "legacy71": (
            f"LEGACY71 - {legacy.get('runtime_version', '310.8/310.9.16')} - "
            f"{str(legacy.get('precision', '?')).upper()} - post phase "
            f"{legacy.get('post_phase', 1)}"),
        "small31": (
            f"SMALL31 - {small.get('runtime_version', '310.9.16')} - "
            f"{str(small.get('precision', '?')).upper()} - post phase "
            f"{small.get('post_phase', 0)}"),
    }
