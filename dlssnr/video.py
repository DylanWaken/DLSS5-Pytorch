"""Compatibility facade for the native RGB pipeline, media and diagnostics.

The canonical implementation owners are :mod:`dlssnr.frontend`,
:mod:`dlssnr.media` and :mod:`dlssnr.diagnostics`.  Every public name below is
re-exported from its owner, so classes and functions keep object identity with
their canonical definitions.
"""
from __future__ import annotations

from .diagnostics.environment import gpu_environment, nvidia_smi_snapshot
from .diagnostics.provenance import (
    _first_present,
    load_source_metadata,
    manifest_document,
    plan_table_hashes,
    sha256_array,
    sha256_bytes,
    sha256_file,
    utc_now,
    write_json,
)
from .diagnostics.timing import summarize_timings, timed_cpu, timed_cuda
from .frontend.abi import (
    POST_ABI_BYTES,
    POST_DISPLAY_OUTPUT,
    POST_DISPLAY_OUTPUT_OFFSET,
    POST_OUTPUT_SCALE,
    POST_OUTPUT_SCALE_OFFSET,
    POSTPROCESS_NAMES,
    PRE_ABI_BYTES,
    PREPROCESS_NAMES,
    _FPostprocessParameters,
    _FTextureTransform,
    _postprocess_array,
    assert_postprocess_display,
    patch_postprocess_display,
    postprocess_display_values,
)
from .frontend.layout import (
    NATIVE_PRECISIONS,
    TRUNK_FINAL_ORIGIN,
    TRUNK_FINAL_PHASE,
    TRUNK_FINAL_PHASE_SOURCE,
    TRUNK_FINAL_RECORD_BYTES,
    TRUNK_OUTPUT_LAYOUT,
    FinalC32Binding,
    FrameLayout,
    _assert_disjoint,
    _require_contiguous_uint8,
    as_rgba_float32,
    build_rgb_trunk,
    element_bytes,
    resolve_precision,
    rgb_to_uint8,
    trunk_final_phase,
    validate_low_features,
    validate_packed_low,
    validate_rgba_output,
)
from .frontend.pipeline import (
    MODEL_NAMES,
    SMALL31_REBUILD_MESSAGE,
    FramePipeline,
    post_phase_for_model,
)
from .media.comparison import (
    DEFAULT_FOOTER,
    PANEL_DISPLAY_WIDTH,
    PANEL_FILTER_DESCRIPTION,
    PANEL_FILTER_NAME,
    PANEL_FOOTER_HEIGHT,
    PANEL_GAP,
    PANEL_HEADER_HEIGHT,
    PANEL_HEIGHT,
    PANEL_TOTAL_HEIGHT,
    PANEL_TOTAL_WIDTH,
    PANEL_WIDTH,
    _aspect_ratio_text,
    _panel_font,
    _pillow_lanczos,
    _positive_int,
    comparison_captions,
    compose_comparison_panel,
    compose_full_resolution_panel,
    crop_rgb,
    crop_same_roi,
    display_panel_geometry,
    panel_regions,
    resize_rgb_for_display,
    validate_roi,
)
from .media.ffmpeg import (
    decode_video_frames_command,
    encode_png_sequence_command,
    ffmpeg_version,
    fps_text,
    iter_frame_paths,
    run_command,
)
from .media.images import (
    IMAGE_SUFFIXES,
    _pillow,
    decode_rgb_image,
    decode_rgb_png,
    load_frame_rgba,
    load_image_rgba,
    rgb_to_rgba,
    save_rgb_png,
)
from .small_deployment import load_native_model


__all__ = [
    "MODEL_NAMES", "NATIVE_PRECISIONS", "PREPROCESS_NAMES", "POSTPROCESS_NAMES",
    "POST_ABI_BYTES", "POST_OUTPUT_SCALE_OFFSET", "POST_DISPLAY_OUTPUT_OFFSET",
    "POST_OUTPUT_SCALE", "POST_DISPLAY_OUTPUT", "PRE_ABI_BYTES",
    "SMALL31_REBUILD_MESSAGE", "FrameLayout", "FramePipeline",
    "TRUNK_OUTPUT_LAYOUT", "TRUNK_FINAL_PHASE", "TRUNK_FINAL_ORIGIN",
    "TRUNK_FINAL_RECORD_BYTES", "TRUNK_FINAL_PHASE_SOURCE",
    "FinalC32Binding", "build_rgb_trunk", "trunk_final_phase",
    "validate_packed_low", "validate_low_features",
    "IMAGE_SUFFIXES", "resolve_precision", "element_bytes", "post_phase_for_model",
    "patch_postprocess_display", "postprocess_display_values",
    "assert_postprocess_display", "decode_rgb_image", "decode_rgb_png",
    "save_rgb_png", "rgb_to_rgba", "load_frame_rgba", "load_image_rgba",
    "as_rgba_float32", "rgb_to_uint8", "validate_rgba_output", "sha256_bytes",
    "sha256_array", "sha256_file", "utc_now", "PANEL_WIDTH", "PANEL_HEIGHT",
    "PANEL_DISPLAY_WIDTH", "PANEL_FILTER_NAME", "PANEL_FILTER_DESCRIPTION",
    "PANEL_HEADER_HEIGHT", "PANEL_FOOTER_HEIGHT", "PANEL_GAP",
    "PANEL_TOTAL_WIDTH", "PANEL_TOTAL_HEIGHT", "DEFAULT_FOOTER",
    "display_panel_geometry", "panel_regions", "resize_rgb_for_display",
    "compose_comparison_panel", "compose_full_resolution_panel", "validate_roi",
    "crop_rgb", "crop_same_roi", "comparison_captions", "encode_png_sequence_command",
    "decode_video_frames_command", "fps_text", "run_command", "ffmpeg_version",
    "summarize_timings", "timed_cuda", "timed_cpu", "gpu_environment",
    "nvidia_smi_snapshot", "plan_table_hashes", "load_source_metadata",
    "manifest_document", "write_json", "iter_frame_paths",
    "load_native_model",
]
