"""CPU boundary contracts for the P4 video facade and its responsibility owners.

These checks pin the compatibility surface, canonical object identity and the
independent ABI/media/command expectations.  They never create a CUDA context,
load a native extension or invoke the GPU harness.
"""
from __future__ import annotations

import ast
import importlib
import subprocess
import sys
import threading
from pathlib import Path
from types import SimpleNamespace

import numpy as np
import pytest
import torch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from dlssnr import video  # noqa: E402

EXPECTED_PUBLIC_NAMES = (
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
)

CANONICAL_OWNERS = {
    "dlssnr.frontend.abi": (
        "PREPROCESS_NAMES", "POSTPROCESS_NAMES", "POST_ABI_BYTES",
        "POST_OUTPUT_SCALE_OFFSET", "POST_DISPLAY_OUTPUT_OFFSET",
        "POST_OUTPUT_SCALE", "POST_DISPLAY_OUTPUT", "PRE_ABI_BYTES",
        "patch_postprocess_display", "postprocess_display_values",
        "assert_postprocess_display",
    ),
    "dlssnr.frontend.layout": (
        "NATIVE_PRECISIONS", "TRUNK_OUTPUT_LAYOUT", "TRUNK_FINAL_PHASE",
        "TRUNK_FINAL_ORIGIN", "TRUNK_FINAL_RECORD_BYTES",
        "TRUNK_FINAL_PHASE_SOURCE", "FinalC32Binding", "FrameLayout",
        "resolve_precision", "element_bytes", "build_rgb_trunk",
        "trunk_final_phase", "validate_packed_low", "validate_low_features",
        "as_rgba_float32", "rgb_to_uint8", "validate_rgba_output",
    ),
    "dlssnr.frontend.pipeline": (
        "MODEL_NAMES", "SMALL31_REBUILD_MESSAGE", "FramePipeline",
        "post_phase_for_model",
    ),
    "dlssnr.media.images": (
        "IMAGE_SUFFIXES", "decode_rgb_image", "decode_rgb_png", "save_rgb_png",
        "rgb_to_rgba", "load_frame_rgba", "load_image_rgba",
    ),
    "dlssnr.media.comparison": (
        "DEFAULT_FOOTER", "PANEL_WIDTH", "PANEL_HEIGHT", "PANEL_DISPLAY_WIDTH",
        "PANEL_FILTER_NAME", "PANEL_FILTER_DESCRIPTION", "PANEL_HEADER_HEIGHT",
        "PANEL_FOOTER_HEIGHT", "PANEL_GAP", "PANEL_TOTAL_WIDTH",
        "PANEL_TOTAL_HEIGHT", "display_panel_geometry", "panel_regions",
        "resize_rgb_for_display", "compose_comparison_panel",
        "compose_full_resolution_panel", "validate_roi", "crop_rgb",
        "crop_same_roi", "comparison_captions",
    ),
    "dlssnr.media.ffmpeg": (
        "encode_png_sequence_command", "decode_video_frames_command", "fps_text",
        "run_command", "ffmpeg_version", "iter_frame_paths",
    ),
    "dlssnr.diagnostics.provenance": (
        "sha256_bytes", "sha256_array", "sha256_file", "utc_now",
        "plan_table_hashes", "load_source_metadata", "manifest_document",
        "write_json",
    ),
    "dlssnr.diagnostics.timing": (
        "summarize_timings", "timed_cuda", "timed_cpu",
    ),
    "dlssnr.diagnostics.environment": (
        "gpu_environment", "nvidia_smi_snapshot",
    ),
    "dlssnr.small_deployment": ("load_native_model",),
}


def test_video_is_a_thin_facade_with_the_original_public_surface():
    text = (ROOT / "dlssnr" / "video.py").read_text(encoding="utf-8")
    tree = ast.parse(text)
    assert not [node for node in tree.body
                if isinstance(node, (ast.FunctionDef, ast.ClassDef))]
    assert tuple(video.__all__) == EXPECTED_PUBLIC_NAMES
    assert all(hasattr(video, name) for name in EXPECTED_PUBLIC_NAMES)


def test_every_facade_export_is_the_canonical_owner_object():
    seen = set()
    for module_name, names in CANONICAL_OWNERS.items():
        owner = importlib.import_module(module_name)
        for name in names:
            assert name not in seen, f"duplicate owner declaration: {name}"
            seen.add(name)
            facade_value = getattr(video, name)
            owner_value = getattr(owner, name)
            if callable(owner_value) or isinstance(owner_value, type):
                assert facade_value is owner_value, name
            else:
                assert facade_value == owner_value, name
    assert seen == set(EXPECTED_PUBLIC_NAMES)
    assert video.FrameLayout is importlib.import_module(
        "dlssnr.frontend.layout").FrameLayout
    assert video.FramePipeline is importlib.import_module(
        "dlssnr.frontend.pipeline").FramePipeline


def test_native_frontend_import_does_not_need_pillow_or_media():
    # A fresh interpreter makes the lazy-import boundary observable without
    # depending on what other test modules already imported.
    script = (
        "import sys\n"
        "import dlssnr.frontend.pipeline\n"
        "bad = [name for name in sys.modules if name == 'PIL' or "
        "name.startswith('PIL.') or name == 'dlssnr.media' or "
        "name.startswith('dlssnr.media.')]\n"
        "print(bad)\n"
        "raise SystemExit(1 if bad else 0)\n"
    )
    result = subprocess.run([sys.executable, "-B", "-c", script], cwd=ROOT,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            text=True)
    assert result.returncode == 0, result.stdout


def test_abi_mirror_keeps_independent_size_and_offset_values():
    from dlssnr.frontend.abi import _FPostprocessParameters

    assert _FPostprocessParameters is video._FPostprocessParameters
    assert _FPostprocessParameters is not None
    assert video.POST_ABI_BYTES == 184
    assert video.PRE_ABI_BYTES == 264
    assert _FPostprocessParameters.OutputScale.offset == 48
    assert _FPostprocessParameters.bDisplayOutput.offset == 52
    assert video.POST_OUTPUT_SCALE_OFFSET == 48
    assert video.POST_DISPLAY_OUTPUT_OFFSET == 52
    assert video.POST_OUTPUT_SCALE == 0.03125
    assert video.POST_DISPLAY_OUTPUT == 1


def test_media_fixture_pixels_panel_regions_and_ffmpeg_argv_are_deterministic(tmp_path):
    pytest.importorskip("PIL")
    image = np.array([
        [[255, 0, 0], [0, 255, 0]],
        [[0, 0, 255], [12, 34, 56]],
    ], dtype=np.uint8)
    path = video.save_rgb_png(image, tmp_path / "fixed.png")
    assert np.array_equal(video.decode_rgb_png(path), image)
    rgba = video.rgb_to_rgba(image)
    assert rgba[0, 0].tolist() == [1.0, 0.0, 0.0, 1.0]
    assert rgba[1, 1, 2] == np.float32(56 / 255)

    regions = video.panel_regions(width=10, height=6, header_height=4, gap=2)
    assert regions == (
        {"name": "original", "x0": 0, "y0": 4, "x1": 10, "y1": 10},
        {"name": "legacy71", "x0": 12, "y0": 4, "x1": 22, "y1": 10},
        {"name": "small31", "x0": 24, "y0": 4, "x1": 34, "y1": 10},
    )

    assert video.encode_png_sequence_command(
        "ffmpeg", "frames/frame_%04d.png", 30, "out.mp4", crf=16) == [
        "ffmpeg", "-hide_banner", "-loglevel", "error", "-y", "-framerate",
        "30", "-start_number", "0", "-i", "frames/frame_%04d.png", "-an",
        "-c:v", "libx264", "-preset", "medium", "-crf", "16", "-pix_fmt",
        "yuv420p", "-movflags", "+faststart", "out.mp4"]
    assert video.decode_video_frames_command(
        "ffmpeg", "clip.webm", "frames/frame_%04d.png") == [
        "ffmpeg", "-hide_banner", "-loglevel", "error", "-y", "-i", "clip.webm",
        "-map", "0:v:0", "-an", "-fps_mode", "passthrough", "-start_number",
        "0", "frames/frame_%04d.png"]
    assert video.fps_text(30) == "30"
    assert video.fps_text(29.97) == "29.97"


def test_manifest_and_plan_hashes_resolve_from_the_repository_root():
    owner = importlib.import_module("dlssnr.diagnostics.provenance")
    assert video.sha256_array is owner.sha256_array
    assert video.sha256_file is owner.sha256_file
    document = video.manifest_document(
        mode="unit", command=["python", "-B"], environment={}, models=[],
        frame_source={}, methodology={}, source_metadata={})
    assert document["reproduction"]["cwd"] == str(ROOT)
    assert set(document["plan_tables"]) == {
        "plan_generated.inl", "plan_fp16_generated.inl",
        "plan_geometry_generated.inl", "plan_geometry_fp16_generated.inl",
        "small_plan_generated.inl", "small_plan_fp16_generated.inl",
        "small_plan_geometry_generated.inl",
        "small_plan_geometry_fp16_generated.inl",
    }
    assert all(isinstance(value, str) and len(value) == 64
               for value in document["plan_tables"].values())


def test_sequence_pipeline_keeps_validation_between_trunk_and_post(monkeypatch):
    import contextlib

    monkeypatch.setattr(
        "torch.cuda.device", lambda *args, **kwargs: contextlib.nullcontext())
    events = []
    pipeline = object.__new__(video.FramePipeline)
    pipeline.device = torch.device("cuda", 0)
    pipeline._launch_lock = threading.RLock()
    pipeline.output = object()
    pipeline.low = object()
    pipeline.pre_inputs = pipeline.pre_outputs = ()
    pipeline.post_inputs = pipeline.post_outputs = ()
    pipeline.upload = lambda frame: events.append("upload")
    pipeline.pre = lambda inputs, outputs: events.append("pre")
    pipeline.trunk = SimpleNamespace(run_cpp=lambda: events.append("trunk"))
    pipeline.validate_low = lambda: events.append("validate")
    pipeline.post = lambda inputs, outputs: events.append("post")
    assert pipeline.run("frame") is pipeline.output
    assert events == ["upload", "pre", "trunk", "validate", "post"]
