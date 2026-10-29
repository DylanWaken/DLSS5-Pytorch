"""CPU contracts for the native RGB video harness.

These tests exercise the frame/ABI/encoding contracts only.  No CUDA context is
created, no extension is loaded and no GPU workload is measured.  The tests do
not mirror the large pipeline implementation; they pin the small, checkable
interfaces that protect the GPU step.
"""
from __future__ import annotations

import contextlib
import json
import struct
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
from dlssnr.model_specs import resolve_model  # noqa: E402
from tools import compare_gameplay  # noqa: E402


def _rgb_image():
    # Distinct channel values make RGB-order mistakes visible.
    image = np.zeros((2, 2, 3), dtype=np.uint8)
    image[0, 0] = (255, 0, 0)      # red
    image[0, 1] = (0, 255, 0)      # green
    image[1, 0] = (0, 0, 255)      # blue
    image[1, 1] = (12, 34, 56)     # arbitrary coded RGB
    return image


def test_rgb_channel_order_and_no_transfer_function(tmp_path):
    pytest.importorskip("PIL")
    image = _rgb_image()
    path = video.save_rgb_png(image, tmp_path / "rgb.png")

    decoded = video.decode_rgb_png(path)
    assert np.array_equal(decoded, image)
    # R/G/B stay in lane order: no BGR swap.
    assert tuple(decoded[0, 0]) == (255, 0, 0)
    assert tuple(decoded[0, 1]) == (0, 255, 0)
    assert tuple(decoded[1, 0]) == (0, 0, 255)

    rgba = video.rgb_to_rgba(image)
    assert rgba.dtype == np.float32 and rgba.shape == (2, 2, 4)
    assert np.allclose(rgba[..., :3], image.astype(np.float32) / 255.0)
    assert np.array_equal(rgba[..., 3], np.ones((2, 2), dtype=np.float32))
    # Coded values are used directly: 255 -> 1.0, 128 -> 128/255, no EOTF.
    assert rgba[0, 0, 0] == np.float32(1.0)
    assert rgba[1, 1, 0] == np.float32(12 / 255)
    assert rgba[1, 1, 2] == np.float32(56 / 255)

    frame = video.load_frame_rgba(path, expected_width=2, expected_height=2)
    assert np.array_equal(frame, rgba)
    with pytest.raises(ValueError):
        video.decode_rgb_png(path, expected_width=3)
    with pytest.raises(ValueError):
        video.decode_rgb_png(path, expected_height=1)


def test_still_image_decode_keeps_native_dimensions_and_never_resizes(tmp_path):
    pytest.importorskip("PIL")
    from PIL import Image

    image = np.zeros((5, 7, 3), dtype=np.uint8)
    image[..., 0] = np.arange(7, dtype=np.uint8)[None, :] * 30
    image[..., 1] = np.arange(5, dtype=np.uint8)[:, None] * 40
    image[2, 3] = (11, 22, 33)
    png = video.save_rgb_png(image, tmp_path / "still.png")
    assert np.array_equal(video.decode_rgb_image(png), image)

    jpeg = tmp_path / "still.jpeg"
    Image.fromarray(image).save(jpeg, format="JPEG", quality=95)
    decoded = video.decode_rgb_image(jpeg)
    assert decoded.shape == (5, 7, 3)   # height, width unchanged: no resize
    assert decoded.dtype == np.uint8
    # JPEG is lossy, so only the geometry/lane contract is asserted here.
    assert decoded.shape[1] == 7 and decoded.shape[0] == 5
    rgba = video.load_image_rgba(jpeg)
    assert rgba.shape == (5, 7, 4) and rgba.dtype == np.float32
    assert np.array_equal(rgba[..., 3], np.ones((5, 7), dtype=np.float32))

    with pytest.raises(ValueError, match="requires a .png"):
        video.decode_rgb_png(jpeg)
    unsupported = tmp_path / "still.bmp"
    unsupported.write_bytes(b"not an image")
    with pytest.raises(ValueError, match="unsupported image"):
        video.decode_rgb_image(unsupported)


def test_verified_cyberpunk_still_decodes_at_its_native_size():
    pytest.importorskip("PIL")
    from PIL import Image

    path = compare_gameplay.DEFAULT_INPUT_IMAGE
    if not path.is_file():
        pytest.skip(f"verified still is not present: {path}")
    with Image.open(path) as image:
        declared = image.size
    rgb = video.decode_rgb_image(path)
    assert (rgb.shape[1], rgb.shape[0]) == declared
    assert rgb.shape[2] == 3 and rgb.dtype == np.uint8


def test_source_metadata_is_optional_source_neutral_and_never_invented(tmp_path):
    pytest.importorskip("PIL")
    image_path = video.save_rgb_png(_rgb_image(), tmp_path / "still.png")

    missing = video.load_source_metadata(None, input_path=image_path)
    assert missing["available"] is False
    assert missing["path"] == str(tmp_path / "source.json")
    assert "license" not in missing and "attribution_line" not in missing
    assert "GPL" not in json.dumps(missing)
    assert "Wikimedia" not in json.dumps(missing)

    (tmp_path / "source.json").write_text(json.dumps({
        "source": {
            "title": "Explicit supplied still",
            "creator": "Named creator",
            "copyright": "(c) 2026 Named creator",
            "license": "CC-BY-4.0",
            "license_url": "https://example.test/license",
            "source_url": "https://example.test/source",
            "credit": "Courtesy of Named creator",
            "derivative_notice": "Supplied derivative notice.",
        }
    }), encoding="utf-8")
    sibling = video.load_source_metadata(None, input_path=image_path)
    assert sibling["available"] is True
    assert sibling["title"] == "Explicit supplied still"
    assert sibling["artist"] == "Named creator"
    assert sibling["copyright"] == "(c) 2026 Named creator"
    assert sibling["license"] == "CC-BY-4.0"
    assert sibling["source_url"] == "https://example.test/source"
    assert sibling["credit"] == "Courtesy of Named creator"
    assert sibling["derivative_notice"] == "Supplied derivative notice."
    # Nothing beyond the supplied document is synthesized.
    assert "endorsement" not in json.dumps(sibling).lower()

    explicit = video.load_source_metadata(tmp_path / "source.json")
    assert explicit["available"] is True
    absent = video.load_source_metadata(tmp_path / "absent.json")
    assert absent["available"] is False and "license" not in absent


def test_valid_extents_differ_from_physical_texture():
    layout = video.FrameLayout.for_frame(1024, 600, "fp16")
    assert (layout.valid_width, layout.valid_height) == (1024, 600)
    assert (layout.full_width, layout.full_height) == (1024, 640)
    assert layout.current_shape == (600, 1024, 4)   # valid-size texture
    assert layout.output_shape == (640, 1024, 4)    # physical surface
    assert layout.pooled_shape == (320, 512)
    assert layout.adapter_full_bytes == 640 * 1024 * 32 * 2
    assert layout.pooled_bytes == 320 * 512 * 32 * 2

    fp8 = video.FrameLayout.for_frame(1024, 600, "fp8")
    assert fp8.element_bytes == 1
    assert fp8.adapter_full_bytes * 2 == layout.adapter_full_bytes
    assert fp8.pooled_bytes * 2 == layout.pooled_bytes

    valid = np.zeros((600, 1024, 4), dtype=np.float32)
    assert video.as_rgba_float32(valid, layout).shape == (600, 1024, 4)
    physical = np.zeros((640, 1024, 4), dtype=np.float32)
    with pytest.raises(ValueError, match="valid extents"):
        video.as_rgba_float32(physical, layout)
    rgb = np.zeros((600, 1024, 3), dtype=np.uint8)
    assert video.as_rgba_float32(rgb, layout).shape == (600, 1024, 4)


def test_postprocess_display_abi_is_rgb_not_builder_defaults():
    assert video.POST_ABI_BYTES == 184
    assert video.POST_OUTPUT_SCALE_OFFSET == 48
    assert video.POST_DISPLAY_OUTPUT_OFFSET == 52
    assert video.POST_OUTPUT_SCALE == 0.03125
    assert video.POST_DISPLAY_OUTPUT == 1

    blob = bytearray(video.POST_ABI_BYTES)
    # The builder defaults are explicitly not RGB: OutputScale=1.0 and display=0.
    struct.pack_into("<f", blob, video.POST_OUTPUT_SCALE_OFFSET, 1.0)
    struct.pack_into("<I", blob, video.POST_DISPLAY_OUTPUT_OFFSET, 0)
    assert video.postprocess_display_values(blob) == (1.0, 0)
    with pytest.raises(ValueError, match="not RGB display"):
        video.assert_postprocess_display(blob)

    video.patch_postprocess_display(blob)
    scale, display = video.postprocess_display_values(blob)
    assert scale == np.float32(1.0 / 32.0)
    assert display == 1
    video.assert_postprocess_display(blob)

    with pytest.raises(ValueError, match="expected 184"):
        video.patch_postprocess_display(bytearray(183))
    with pytest.raises(ValueError, match="writable"):
        video.patch_postprocess_display(bytes(video.POST_ABI_BYTES))

    # The builder returns a CPU uint8 tensor; the patch must work in place there.
    import torch
    config = torch.zeros(video.POST_ABI_BYTES, dtype=torch.uint8)
    video.patch_postprocess_display(config)
    assert video.postprocess_display_values(config) == (np.float32(1.0 / 32.0), 1)


def test_precision_and_model_rejections():
    assert video.resolve_precision("fp16") == "fp16"
    assert video.resolve_precision("fp8") == "fp8"
    for bad in ("fp32", "FP16", "", None, "bf16"):
        with pytest.raises(ValueError):
            video.resolve_precision(bad)
    assert video.element_bytes("fp16") == 2
    assert video.element_bytes("fp8") == 1

    assert video.post_phase_for_model("legacy71") == 1
    assert video.post_phase_for_model("small31") == 0
    with pytest.raises(ValueError):
        video.post_phase_for_model("legacy_71")
    with pytest.raises(ValueError):
        video.FrameLayout.for_frame(1024, 600, "fp32")
    with pytest.raises(ValueError):
        video.FramePipeline(model="legacy_71", precision="fp16", weights=None,
                            valid_width=1024, valid_height=600, seed=0)
    with pytest.raises(ValueError):
        video.FramePipeline(model="legacy71", precision="fp32", weights=None,
                            valid_width=1024, valid_height=600, seed=0)
    with pytest.raises(ValueError):
        video.FramePipeline(model="legacy71", precision="fp16", weights=None,
                            valid_width=1024, valid_height=600, seed=-1)


def test_original_panel_is_byte_identical_and_unmodified():
    pytest.importorskip("PIL")
    generator = np.random.default_rng(20261029)
    original = generator.integers(0, 256, size=(600, 1024, 3), dtype=np.uint8)
    legacy = np.full((600, 1024, 3), 7, dtype=np.uint8)
    small = np.full((600, 1024, 3), 9, dtype=np.uint8)
    before = original.copy()

    panel = video.compose_comparison_panel(
        original, legacy, small,
        captions={"original": "ORIGINAL", "legacy71": "LEGACY71 - FP16",
                  "small31": "SMALL31 - FP16"},
        footer="stateless")
    assert panel.shape == (video.PANEL_TOTAL_HEIGHT, video.PANEL_TOTAL_WIDTH, 3)
    assert panel.dtype == np.uint8
    regions = {region["name"]: region for region in video.panel_regions()}
    original_region = regions["original"]
    pasted = panel[original_region["y0"]:original_region["y1"],
                   original_region["x0"]:original_region["x1"]]
    assert np.array_equal(pasted, original)
    legacy_region = regions["legacy71"]
    assert np.array_equal(
        panel[legacy_region["y0"]:legacy_region["y1"],
              legacy_region["x0"]:legacy_region["x1"]], legacy)
    # The panel composer never modifies its inputs.
    assert np.array_equal(original, before)

    with pytest.raises(ValueError, match="no individual upscale"):
        video.compose_comparison_panel(
            original[:599], legacy, small, footer="x")


def test_display_geometry_4k_keeps_native_extent_and_scales_overview_only():
    geometry = video.display_panel_geometry(3840, 2160, 1280)
    assert geometry["source"]["width"] == 3840
    assert geometry["source"]["height"] == 2160
    assert geometry["source"]["aspect_ratio"] == "16:9"
    assert geometry["native_arm_output"] == {
        "width": 3840, "height": 2160, "resize": False,
        "note": geometry["native_arm_output"]["note"]}
    assert geometry["panel"]["width"] == 1280
    assert geometry["panel"]["height"] == 720
    assert geometry["panel"]["aspect_ratio"] == "16:9"
    assert geometry["panel"]["downscaled"] is True
    assert geometry["panel"]["upscaled"] is False
    assert geometry["panel"]["scale"] == pytest.approx(1280 / 3840)
    assert geometry["layout"]["total_width"] == 1280 * 3 + video.PANEL_GAP * 2
    assert geometry["layout"]["total_height"] == 46 + 720 + 34
    assert geometry["output_dimensions"] == {"width": 3856, "height": 800}
    assert geometry["filter_name"] == "LANCZOS"
    assert "LANCZOS" in geometry["filter"]
    assert geometry["inference_resize"] is False
    assert geometry["model_input_resize"] is False

    regions = video.panel_regions(width=1280, height=720)
    assert [(region["x0"], region["y1"]) for region in regions] == [
        (0, 766), (1288, 766), (2576, 766)]
    assert regions[-1]["x1"] == geometry["layout"]["total_width"]

    # Existing 1024x600 still geometry is untouched: a larger requested panel
    # width is clamped, never upscaled, so the legacy defaults are preserved.
    legacy = video.display_panel_geometry(1024, 600, 1280)
    assert (legacy["panel"]["width"], legacy["panel"]["height"]) == (1024, 600)
    assert legacy["panel"]["upscaled"] is False
    assert legacy["output_dimensions"] == {
        "width": video.PANEL_TOTAL_WIDTH, "height": video.PANEL_TOTAL_HEIGHT}


def test_comparison_panel_accepts_arbitrary_16x9_and_scales_only_display():
    pytest.importorskip("PIL")
    generator = np.random.default_rng(20261029)
    original = generator.integers(0, 256, size=(216, 384, 3), dtype=np.uint8)
    legacy = generator.integers(0, 256, size=(216, 384, 3), dtype=np.uint8)
    small = generator.integers(0, 256, size=(216, 384, 3), dtype=np.uint8)
    before = [image.copy() for image in (original, legacy, small)]

    panel = video.compose_comparison_panel(
        original, legacy, small, footer="display", panel_width=192)
    geometry = video.display_panel_geometry(384, 216, 192)
    assert panel.shape == (
        geometry["output_dimensions"]["height"],
        geometry["output_dimensions"]["width"], 3)
    assert geometry["panel"]["width"] == 192
    assert geometry["panel"]["height"] == 108
    assert geometry["panel"]["aspect_ratio"] == "16:9"  # no aspect stretch
    for region, source in zip(
            video.panel_regions(width=192, height=108),
            (original, legacy, small)):
        pasted = panel[region["y0"]:region["y1"], region["x0"]:region["x1"]]
        expected = video.resize_rgb_for_display(source, 192, 108)
        assert np.array_equal(pasted, expected)
    for image, snapshot in zip((original, legacy, small), before):
        assert np.array_equal(image, snapshot)  # inputs are never modified

    # At native display width each panel is pasted byte-for-byte unchanged.
    native = video.compose_comparison_panel(
        original, legacy, small, footer="native", panel_width=384)
    assert native.shape == (46 + 216 + 34, 384 * 3 + video.PANEL_GAP * 2, 3)
    region = video.panel_regions(width=384, height=216)[0]
    assert np.array_equal(
        native[region["y0"]:region["y1"], region["x0"]:region["x1"]], original)

    # An oversize request is clamped (downscale-only) rather than upscaled.
    clamped = video.display_panel_geometry(384, 216, 1280)
    assert (clamped["panel"]["width"], clamped["panel"]["height"]) == (384, 216)
    assert clamped["panel"]["upscaled"] is False


def test_comparison_panel_rejects_mismatched_arm_shapes():
    pytest.importorskip("PIL")
    generator = np.random.default_rng(5)
    original = generator.integers(0, 256, size=(216, 384, 3), dtype=np.uint8)
    legacy = generator.integers(0, 256, size=(216, 384, 3), dtype=np.uint8)
    small = generator.integers(0, 256, size=(216, 384, 3), dtype=np.uint8)
    with pytest.raises(ValueError, match="share one size"):
        video.compose_comparison_panel(
            original, legacy[:215], small, panel_width=192)
    with pytest.raises(ValueError, match="share one size"):
        video.compose_comparison_panel(
            original, legacy, small[:, :383], panel_width=192)
    with pytest.raises(ValueError, match="uint8"):
        video.compose_comparison_panel(
            original.astype(np.float32) / 255.0, legacy, small, panel_width=192)


def test_video_geometry_manifest_separates_source_native_and_display():
    document = compare_gameplay.video_geometry_document(
        3840, 2160, 1280, roi=(1240, 560, 1024, 1024))
    assert document["source"]["width"] == 3840
    assert document["source"]["height"] == 2160
    assert document["native_arm_output"]["width"] == 3840
    assert document["native_arm_output"]["height"] == 2160
    assert document["native_arm_output"]["resize"] is False
    assert document["comparison_panel"]["width"] == 1280
    assert document["comparison_panel"]["height"] == 720
    assert document["comparison_panel"]["downscaled"] is True
    assert document["aspect_ratio"] == "16:9"
    assert document["output_dimensions"] == {"width": 3856, "height": 800}
    assert document["filter_name"] == "LANCZOS"
    assert document["inference_resize"] is False
    assert document["model_input_resize"] is False

    roi = document["roi"]
    assert (roi["x"], roi["y"], roi["width"], roi["height"]) == (
        1240, 560, 1024, 1024)
    assert roi["same_coordinates_all_arms"] is True
    assert roi["arms"] == ["original", "legacy71", "small31"]
    assert roi["source_pixels"] is True
    assert roi["model_input_crop"] is False and roi["inference_crop"] is False
    assert roi["per_arm_native_pixels"] is True
    assert roi["display_scaled"] is False           # 1024 <= 1280: kept 1:1
    assert roi["display_scale"] == 1.0
    assert roi["display_geometry"]["panel"]["width"] == 1024
    assert roi["display_geometry"]["panel"]["height"] == 1024


def test_video_roi_crops_all_three_native_arms_with_one_source_rectangle():
    shape = (2160, 3840, 3)
    original = np.zeros(shape, dtype=np.uint8)
    legacy = np.full(shape, 7, dtype=np.uint8)
    small = np.full(shape, 9, dtype=np.uint8)
    original[560:1584, 1240:2264] = (12, 34, 56)
    roi = (1240, 560, 1024, 1024)
    crops = video.crop_same_roi([original, legacy, small], roi)
    assert set(crops) == {"original", "legacy71", "small31"}
    for name in crops:
        assert crops[name].shape == (1024, 1024, 3)
    assert np.array_equal(crops["original"], original[560:1584, 1240:2264])
    assert np.array_equal(crops["legacy71"], legacy[560:1584, 1240:2264])
    assert np.array_equal(crops["small31"], small[560:1584, 1240:2264])
    assert np.all(crops["original"] == np.array([12, 34, 56], dtype=np.uint8))
    with pytest.raises(ValueError, match="share one size"):
        video.crop_same_roi([original, legacy, small[:-1]], roi)
    with pytest.raises(ValueError, match="outside"):
        video.crop_same_roi([original, legacy, small], (3000, 560, 1024, 1024))


    pytest.importorskip("PIL")
    generator = np.random.default_rng(20261029)
    original = generator.integers(0, 256, size=(48, 64, 3), dtype=np.uint8)
    legacy = generator.integers(0, 256, size=(48, 64, 3), dtype=np.uint8)
    small = generator.integers(0, 256, size=(48, 64, 3), dtype=np.uint8)
    before = original.copy()
    captions = {"original": "ORIGINAL", "legacy71": "LEGACY71 - FP16",
                "small31": "SMALL31 - FP16"}
    panel = video.compose_full_resolution_panel(
        original, legacy, small, captions=captions, footer="still")
    assert panel.shape == (
        video.PANEL_HEADER_HEIGHT + 48 + video.PANEL_FOOTER_HEIGHT,
        64 * 3 + video.PANEL_GAP * 2, 3)
    top = video.PANEL_HEADER_HEIGHT
    for index, source in enumerate((original, legacy, small)):
        x0 = index * (64 + video.PANEL_GAP)
        pasted = panel[top:top + 48, x0:x0 + 64]
        assert np.array_equal(pasted, source)
    assert np.array_equal(original, before)

    with pytest.raises(ValueError, match="share one size"):
        video.compose_full_resolution_panel(
            original, legacy[:, :32], small, footer=None)

    roi = (9, 7, 20, 11)
    assert video.validate_roi(roi, 64, 48) == roi
    assert np.array_equal(video.crop_rgb(original, roi), original[7:18, 9:29])
    for bad in ((60, 0, 5, 5), (-1, 0, 2, 2), (0, 0, 0, 5), (1, 2, 3)):
        with pytest.raises((ValueError, TypeError)):
            video.validate_roi(bad, 64, 48)


def test_still_artifacts_are_png_only_with_matching_roi(tmp_path):
    pytest.importorskip("PIL")
    generator = np.random.default_rng(7)
    original = generator.integers(0, 256, size=(40, 56, 3), dtype=np.uint8)
    legacy = np.clip(original.astype(np.int16) + 3, 0, 255).astype(np.uint8)
    small = np.clip(original.astype(np.int16) - 3, 0, 255).astype(np.uint8)
    rendered = {"legacy71": legacy, "small31": small}
    captions = video.comparison_captions([
        {"model": "legacy71", "runtime_version": "310.9.16.0",
         "precision": "fp16", "post_phase": 1},
        {"model": "small31", "runtime_version": "310.9.16.0",
         "precision": "fp16", "post_phase": 0},
    ], width=56, height=40)
    still_dir, outputs, roi_info = compare_gameplay.save_still_artifacts(
        tmp_path, original, rendered, captions=captions, footer="still",
        roi=(5, 4, 17, 13))

    assert still_dir == tmp_path / "still"
    expected = {"original", "legacy71", "small31", "comparison_3way",
                "comparison_3way_roi"}
    assert set(outputs) == expected
    for record in outputs.values():
        assert Path(record["path"]).is_file()
        assert Path(record["path"]).suffix == ".png"
    assert not list(tmp_path.rglob("*.mp4"))
    assert roi_info["x"] == 5 and roi_info["y"] == 4
    assert roi_info["width"] == 17 and roi_info["height"] == 13
    assert roi_info["same_coordinates_all_arms"] is True
    assert set(roi_info["per_arm_crop_png"]) == {"original", "legacy71", "small31"}

    full = video.decode_rgb_image(outputs["comparison_3way"]["path"])
    top = video.PANEL_HEADER_HEIGHT
    original_region = full[top:top + 40, 0:56]
    assert np.array_equal(original_region, original)
    roi_panel = video.decode_rgb_image(outputs["comparison_3way_roi"]["path"])
    assert roi_panel.shape[0] == (
        video.PANEL_HEADER_HEIGHT + 13 + video.PANEL_FOOTER_HEIGHT)
    assert np.array_equal(roi_panel[top:top + 13, 0:17], original[4:17, 5:22])
    assert np.array_equal(roi_panel[top:top + 13, 17 + video.PANEL_GAP:
                                     17 + video.PANEL_GAP + 17],
                          legacy[4:17, 5:22])


def test_ffmpeg_commands_are_argv_and_keep_paths_verbatim(tmp_path):
    ffmpeg = r"C:\Program Files\ffmpeg tools\ffmpeg.exe"
    pattern = tmp_path / "frame dir" / "frame_%04d.png"
    output = tmp_path / "encode out" / "comparison.mp4"
    argv = video.encode_png_sequence_command(ffmpeg, pattern, 30, output, crf=16)
    assert isinstance(argv, list) and all(isinstance(item, str) for item in argv)
    assert argv[0] == ffmpeg
    assert str(pattern) in argv
    assert str(output) in argv
    assert "-an" in argv
    assert "-c:v" in argv and "libx264" in argv
    assert "-pix_fmt" in argv and "yuv420p" in argv
    # No scale filter: each lane keeps its native dimensions.
    assert "-vf" not in argv
    assert not any("scale=" in item for item in argv)
    assert video.fps_text(30) == "30"
    assert video.fps_text(29.97) == "29.97"

    video_path = tmp_path / "input video (final).webm"
    extraction = video.decode_video_frames_command(ffmpeg, video_path, pattern)
    assert video_path.as_posix() not in extraction
    assert str(video_path) in extraction
    assert "passthrough" in extraction
    assert "-fps_mode" in extraction

    with pytest.raises(ValueError):
        video.encode_png_sequence_command(ffmpeg, pattern, 0, output)
    with pytest.raises(ValueError):
        video.encode_png_sequence_command(ffmpeg, pattern, 30, output, crf=99)


def test_native_output_validation_and_timing_statistics():
    rgba = np.zeros((8, 8, 4), dtype=np.float32)
    rgba[..., 3] = 1.0
    rgba[0, 0, :3] = (0.25, 0.5, 1.0)
    stats = video.validate_rgba_output(rgba)
    assert stats["rgb_min"] == 0.0 and stats["rgb_max"] == 1.0
    assert stats["alpha_min"] == 1.0 and stats["alpha_max"] == 1.0
    out_of_range = rgba.copy()
    out_of_range[0, 0, 0] = 1.01
    with pytest.raises(ValueError, match="outside"):
        video.validate_rgba_output(out_of_range)
    bad_alpha = rgba.copy()
    bad_alpha[..., 3] = 0.5
    with pytest.raises(ValueError, match="alpha"):
        video.validate_rgba_output(bad_alpha)
    nonfinite = rgba.copy()
    nonfinite[1, 1, 1] = np.nan
    with pytest.raises(ValueError, match="non-finite"):
        video.validate_rgba_output(nonfinite)

    summary = video.summarize_timings(list(range(1, 101)), scope="unit_scope", warmup=10)
    assert summary["iterations"] == 100
    assert summary["median_ms"] == 50.5
    assert summary["mean_ms"] == 50.5
    assert summary["min_ms"] == 1.0 and summary["max_ms"] == 100.0
    assert summary["p10_ms"] == pytest.approx(10.9)
    assert summary["p90_ms"] == pytest.approx(90.1)
    assert summary["fps_from_median"] == pytest.approx(1000 / 50.5)
    assert summary["scope"] == "unit_scope"
    with pytest.raises(ValueError):
        video.summarize_timings([], scope="empty")
    with pytest.raises(ValueError):
        video.timed_cuda(lambda: None, warmup=1, iterations=50)


def test_frame_order_limit_and_manifest_document(tmp_path):
    for index in (2, 0, 1):
        (tmp_path / f"frame_{index:04d}.png").write_bytes(b"x")
    (tmp_path / "notes.txt").write_text("not a frame")
    paths = video.iter_frame_paths(tmp_path)
    assert [path.name for path in paths] == [
        "frame_0000.png", "frame_0001.png", "frame_0002.png"]
    assert [path.name for path in video.iter_frame_paths(tmp_path, limit=2)] == [
        "frame_0000.png", "frame_0001.png"]
    with pytest.raises(ValueError):
        video.iter_frame_paths(tmp_path, limit=0)

    attribution_path = tmp_path / "source.json"
    attribution_path.write_text(json.dumps({"source": {
        "title": "Supplied title",
        "artist": "Supplied artist",
        "license": "CC-BY-4.0",
        "license_url": "https://example.test/license",
        "source_url": "https://example.test/source",
        "credit": "Supplied credit",
    }}), encoding="utf-8")
    attribution = video.load_source_metadata(attribution_path)
    assert attribution["available"] is True
    assert attribution["license"] == "CC-BY-4.0"
    assert attribution["artist"] == "Supplied artist"
    assert attribution["credit"] == "Supplied credit"
    assert "derivative_notice" not in attribution

    document = video.manifest_document(
        mode="unit",
        command=["python", "-B", "tools/compare_gameplay.py"],
        environment={"torch": "cpu"},
        models=[{"model": "legacy71", "precision": "fp16"}],
        frame_source={"count": 1},
        methodology={"stateless": True},
        source_metadata=attribution)
    assert document["schema"] == "dlssnr.video-harness.v1"
    assert document["attribution"]["license_url"].startswith("https://")
    assert any("RGB-only stateless" in item for item in document["support_limits"])
    assert "render" in document["reproduction"]
    assert "benchmark" in document["reproduction"]
    assert document["command"][:2] == ["python", "-B"]
    assert document["reproduction"]["argv"] == document["command"]
    assert "183 s" not in json.dumps(document)
    json.dumps(document)  # the manifest is emitted as machine-readable JSON


def test_captions_name_version_model_precision_and_phase():
    captions = video.comparison_captions([
        {"model": "legacy71", "runtime_version": "310.8.0.0 or 310.9.16.0",
         "precision": "fp16", "post_phase": 1},
        {"model": "small31", "runtime_version": "310.9.16.0",
         "precision": "fp16", "post_phase": 0},
    ])
    assert "LEGACY71" in captions["legacy71"]
    assert "310.8.0.0 or 310.9.16.0" in captions["legacy71"]
    assert "FP16" in captions["legacy71"] and "phase 1" in captions["legacy71"]
    assert "SMALL31" in captions["small31"]
    assert "310.9.16.0" in captions["small31"]
    assert "FP16" in captions["small31"] and "phase 0" in captions["small31"]
    assert "unchanged" in captions["original"]

    sized = video.comparison_captions(
        [{"model": "legacy71", "precision": "fp16", "post_phase": 1},
         {"model": "small31", "precision": "fp16", "post_phase": 0}],
        width=1920, height=1080)
    assert "1920x1080" in sized["original"]


def test_official_nested_source_metadata_is_preserved_verbatim():
    path = compare_gameplay.DEFAULT_INPUT_IMAGE.with_name("source.json")
    if not path.is_file():
        pytest.skip(f"official metadata is not present: {path}")
    supplied = json.loads(path.read_text(encoding="utf-8"))
    attribution = video.load_source_metadata(path)
    assert attribution["available"] is True
    for section in ("official_sources", "rights", "image", "clip",
                    "canonical_frames", "transformations", "verification"):
        if section in supplied:
            assert attribution[section] == supplied[section]
    assert attribution["document"] == supplied
    assert attribution["sha256"] == video.sha256_file(path)

    # The nested official schema is not flattened into a fabricated license.
    assert "license" not in attribution
    assert attribution["rights"]["relicensed_as_gpl_or_cc0"] is False
    assert attribution["rights"]["endorsement_claimed"] is False
    assert attribution["official_sources"]["publisher"] == "CD PROJEKT RED"
    selected = attribution["image"]["selected"]
    assert selected["path"].endswith("selected_character_native.jpeg")
    assert selected["sha256"] == video.sha256_file(compare_gameplay.DEFAULT_INPUT_IMAGE)


def test_still_cli_is_mutually_exclusive_and_source_neutral_by_default():
    parser = compare_gameplay.build_parser()
    default = parser.parse_args(["--output", "out"])
    assert default.input_image is None
    assert default.frames is None and default.input_video is None
    assert default.source_metadata is None

    default_path = compare_gameplay.DEFAULT_INPUT_IMAGE
    assert default_path.name == "selected_character_native.jpeg"
    assert "cyberpunk-source" in default_path.as_posix()
    assert "video-source" not in default_path.as_posix()
    assert compare_gameplay.DEFAULT_FRAMES is None
    assert "small31-extracted-final" not in (
        compare_gameplay.DEFAULT_SMALL_ARCHIVE.as_posix())

    for conflicting in (
            ["--input-image", "a.jpg", "--frames", "frames"],
            ["--input-image", "a.jpg", "--input-video", "clip.mp4"],
            ["--frames", "frames", "--input-video", "clip.mp4"]):
        with pytest.raises(SystemExit):
            parser.parse_args(["--output", "out", *conflicting])

    args = parser.parse_args([
        "--output", "out", "--input-image", "still.png",
        "--roi", "10", "20", "30", "40"])
    assert args.roi == [10, 20, 30, 40]

    video_args = parser.parse_args([
        "--output", "out", "--frames", "frames",
        "--video-panel-width", "1280",
        "--video-roi", "1240", "560", "1024", "1024"])
    assert video_args.video_panel_width == video.PANEL_DISPLAY_WIDTH
    assert video_args.roi is None
    assert video_args.video_roi == [1240, 560, 1024, 1024]
    for conflicting in (
            ["--input-image", "a.jpg", "--video-roi", "1", "2", "3", "4"],
            ["--frames", "frames", "--roi", "1", "2", "3", "4"],
            ["--frames", "frames", "--roi", "1", "2", "3", "4",
             "--video-roi", "1", "2", "3", "4"]):
        parsed = parser.parse_args(["--output", "out", *conflicting])
        with pytest.raises(SystemExit):
            compare_gameplay.resolve_source(parsed)

    for module in ("dlssnr/video.py", "tools/compare_gameplay.py"):
        text = (ROOT / module).read_text(encoding="utf-8")
        assert "Xonotic" not in text
        assert "Wikimedia" not in text
        assert "GPL-3.0" not in text
        assert "183 s" not in text


def test_still_render_runs_each_mock_arm_once_on_one_shared_decode(
        tmp_path, monkeypatch):
    pytest.importorskip("PIL")
    generator = np.random.default_rng(11)
    original = generator.integers(0, 256, size=(24, 32, 3), dtype=np.uint8)
    legacy = np.clip(original.astype(np.int16) + 5, 0, 255).astype(np.uint8)
    small = np.clip(original.astype(np.int16) - 5, 0, 255).astype(np.uint8)
    image_path = video.save_rgb_png(original, tmp_path / "source.png")
    # The CLI path is --input-image; the PNG bytes keep this test lossless.
    args = SimpleNamespace(output=tmp_path / "run", roi=(3, 2, 11, 9))

    calls = []

    def fake_arm(pipeline, rgba):
        calls.append((pipeline.name, id(rgba), rgba.shape, rgba.dtype))
        image = {"legacy71": legacy, "small31": small}[pipeline.name]
        return {
            "sha256": video.sha256_array(image),
            "rgb_min": 0.0, "rgb_max": 1.0,
            "alpha_min": 1.0, "alpha_max": 1.0,
        }, image

    monkeypatch.setattr(compare_gameplay, "_render_still_arm", fake_arm)

    class FakePipeline:
        def __init__(self, name):
            self.name = name
            self.model = name

    pipelines = {"legacy71": FakePipeline("legacy71"),
                 "small31": FakePipeline("small31")}
    descriptions = [
        {"model": "legacy71", "runtime_version": "310.9.16.0",
         "precision": "fp16", "post_phase": 1,
         "post_phase_source": "model_specs.post_phase_default"},
        {"model": "small31", "runtime_version": "310.9.16.0",
         "precision": "fp16", "post_phase": 0,
         "post_phase_source": "model_specs.post_phase_default"},
    ]
    source_metadata = {"available": False, "notice": "no metadata"}
    manifest = compare_gameplay.render_still_comparison(
        args=args, image_path=image_path, original_u8=original,
        pipelines=pipelines, descriptions=descriptions,
        source_metadata=source_metadata,
        model_records={"legacy71": {"weights": "mock"},
                       "small31": {"archive": "mock"}},
        environment={"torch": "cpu"})

    assert len(calls) == 2
    assert calls[0][1] == calls[1][1]          # one RGB decode shared by both arms
    assert calls[0][2] == (24, 32, 4) and calls[0][3] == np.float32
    assert manifest["mode"] == "still"
    assert manifest["models"] == descriptions
    source = manifest["frame_source"]
    assert source["still"] is True and source["video_encoding"] is False
    assert source["frame_count"] == 1
    assert source["width"] == 32 and source["height"] == 24
    assert source["model_input_crop"]["applied"] is False
    assert source["roi"]["x"] == 3 and source["roi"]["y"] == 2
    assert source["roi"]["same_coordinates_all_arms"] is True
    assert manifest["methodology"]["encode"]["performed"] is False
    assert manifest["methodology"]["still"] is True
    assert manifest["methodology"]["post_phases"]["legacy71"]["post_phase"] == 1
    assert manifest["methodology"]["post_phases"]["small31"]["post_phase"] == 0
    assert manifest["same_frame_replay"] is False
    assert manifest["command"] == [str(value) for value in sys.argv]

    outputs = manifest["outputs"]
    assert set(outputs) == {"original", "legacy71", "small31",
                            "comparison_3way", "comparison_3way_roi"}
    for record in outputs.values():
        assert Path(record["path"]).is_file()
    assert np.array_equal(video.decode_rgb_image(outputs["original"]["path"]), original)
    assert np.array_equal(video.decode_rgb_image(outputs["legacy71"]["path"]), legacy)
    assert np.array_equal(video.decode_rgb_image(outputs["small31"]["path"]), small)
    assert not list((tmp_path / "run").rglob("*.mp4"))

    roi_panel = video.decode_rgb_image(outputs["comparison_3way_roi"]["path"])
    top = video.PANEL_HEADER_HEIGHT
    assert np.array_equal(roi_panel[top:top + 9, 0:11], original[2:11, 3:14])
    assert np.array_equal(
        roi_panel[top:top + 9, 11 + video.PANEL_GAP:11 + video.PANEL_GAP + 11],
        legacy[2:11, 3:14])


# -- RGB bridge / typed packed-low CPU contracts ----------------------------


def _trunk_layout(full_width=64, full_height=64, precision="fp16"):
    element = 2 if precision == "fp16" else 1
    return video.FrameLayout(
        valid_width=full_width, valid_height=full_height,
        full_width=full_width, full_height=full_height,
        precision=precision, element_bytes=element,
        adapter_full_bytes=full_width * full_height * 32 * element,
        pooled_bytes=full_width * full_height * 8 * element)


def _rgb_bridge_fixture(*, precision="fp16", buffer_count=4, state_index=2,
                        output_index=3, record_offset=0, final_name=None,
                        inputs=None, outputs=None, record_bytes=None,
                        state_bytes=None, output_bytes=None, split_last=1,
                        extra_split=None, spec=None, low=None, view_name=None):
    """Build CPU-only prepared-plan metadata with actual tensor identities."""
    layout = _trunk_layout(precision=precision)
    buffers = [torch.zeros(4, dtype=torch.uint8) for _ in range(buffer_count)]
    buffers[state_index] = torch.zeros(
        layout.pooled_bytes if state_bytes is None else state_bytes,
        dtype=torch.uint8)
    buffers[output_index] = torch.zeros(
        layout.pooled_bytes if output_bytes is None else output_bytes,
        dtype=torch.uint8)
    record = torch.zeros(
        video.TRUNK_FINAL_RECORD_BYTES[precision] if record_bytes is None else record_bytes,
        dtype=torch.uint8)
    tensors = tuple(buffers) + (record,)
    record_index = buffer_count + record_offset
    last_inputs = ([state_index, record_index] if inputs is None else list(inputs))
    last_outputs = ([output_index] if outputs is None else list(outputs))
    kernels = (SimpleNamespace(name="clear_completion_counter"),
               SimpleNamespace(name="compute_block"),
               SimpleNamespace(name=final_name or f"window_block_c32_{precision}"))
    sequence = SimpleNamespace(
        kernels=kernels,
        tensors=tensors,
        input_indices=((0,), (1,), tuple(last_inputs)),
        output_indices=((1,), (0,), tuple(last_outputs)),
        output_index=output_index)
    split = [1, 1, split_last] if extra_split is None else [1, 1, split_last] + list(extra_split)
    plan = SimpleNamespace(
        buffer_names=lambda: [f"buffer{index}" for index in range(buffer_count)],
        split_launch_counts=lambda: list(split))
    if spec is None:
        spec = SimpleNamespace(roles=(0, 69), phase_for_role=lambda role: 3)
    calls = {}
    composed = {}

    def prepare_view(state, record, output, *, height, width, phase):
        calls.update(state=state, record=record, output=output,
                     height=height, width=width, phase=phase)
        return SimpleNamespace(
            name=view_name or f"window_block_c32_output_view_{precision}",
            inputs=(state, record), outputs=(output,))

    def compose(kernels):
        composed["kernels"] = tuple(kernels)
        return SimpleNamespace(
            kernels=tuple(kernels), tensors=(kernels[-1].outputs[0],), output_index=0)

    return SimpleNamespace(
        layout=layout, plan=plan, sequence=sequence,
        low=buffers[output_index] if low is None else low,
        buffers=buffers, record=record, tensors=tensors, spec=spec,
        precision=precision, calls=calls, composed=composed,
        prepare_view=prepare_view, compose=compose)


def _run_rgb_bridge(fixture):
    return video.build_rgb_trunk(
        fixture.plan, model="legacy71", precision=fixture.precision,
        layout=fixture.layout, low=fixture.low, spec=fixture.spec,
        prepare_sequence=lambda plan: fixture.sequence,
        prepare_view_fp16=fixture.prepare_view,
        prepare_view_fp8=fixture.prepare_view,
        compose=fixture.compose)


@pytest.mark.parametrize("precision,buffer_count,state_index,output_index", [
    ("fp16", 4, 2, 3),
    ("fp8", 5, 3, 1),
])
def test_rgb_bridge_selects_actual_final_binding_and_only_replaces_last_call(
        precision, buffer_count, state_index, output_index):
    fixture = _rgb_bridge_fixture(
        precision=precision, buffer_count=buffer_count,
        state_index=state_index, output_index=output_index)
    trunk, binding, sequence = _run_rgb_bridge(fixture)

    # The predecessor/record namespaces come from plan metadata, not b68/b66.
    assert binding.state is fixture.tensors[state_index]
    assert binding.record is fixture.tensors[buffer_count]
    assert binding.output is fixture.buffers[output_index]
    assert (binding.state_index, binding.record_index, binding.output_index) == (
        state_index, buffer_count, output_index)
    assert binding.plan_final_kernel == f"window_block_c32_{precision}"
    assert binding.output_view_kernel == f"window_block_c32_output_view_{precision}"
    assert binding.height == fixture.layout.full_height // 2
    assert binding.width == fixture.layout.full_width // 2
    # Phase 3 is the generated level0 origin, never the model post phase.
    assert binding.phase == 3 and binding.origin == (0, -4)
    assert binding.phase != video.post_phase_for_model("legacy71")  # post phase 1

    assert fixture.calls["state"] is binding.state
    assert fixture.calls["record"] is binding.record
    assert fixture.calls["output"] is binding.output
    assert (fixture.calls["height"], fixture.calls["width"],
            fixture.calls["phase"]) == (binding.height, binding.width, 3)

    # Every prefix descriptor keeps its identity; exactly the last one changes.
    assert len(trunk.kernels) == len(sequence.kernels)
    assert all(new is old for new, old in
               zip(trunk.kernels[:-1], sequence.kernels[:-1]))
    assert trunk.kernels[-1] is not sequence.kernels[-1]
    assert fixture.composed["kernels"][-1] is trunk.kernels[-1]
    # The replacement reuses the same b69 allocation and adds no repack launch.
    assert trunk.tensors[trunk.output_index] is fixture.low
    assert trunk.tensors[trunk.output_index].data_ptr() == binding.output.data_ptr()


@pytest.mark.parametrize("overrides,match", [
    ({"final_name": "window_block_c32_fp8"}, "unexpected final trunk kernel"),
    ({"inputs": [2, 4, 5]}, "state\\+record"),
    ({"outputs": []}, "state\\+record"),
    ({"inputs": [2, 2]}, "tensor roles"),
    ({"outputs": [4]}, "tensor roles"),
    ({"inputs": [2, 99]}, "outside the prepared tensor list"),
    ({"state_bytes": 16}, "state extent"),
    ({"record_bytes": 16}, "record extent"),
    ({"output_bytes": 16}, "b69 extent"),
    ({"split_last": 2}, "unexpectedly split"),
    ({"extra_split": [1]}, "prepared call count"),
    ({"low": torch.zeros(64 * 64 * 8 * 2, dtype=torch.uint8)},
     "not the bound b69.output"),
    ({"view_name": "not_the_output_view"}, "unexpected output-view kernel"),
    ({"spec": SimpleNamespace(roles=(69,), phase_for_role=lambda role: 0)},
     "publishes phase 0"),
])
def test_rgb_bridge_rejects_malformed_final_metadata(overrides, match):
    fixture = _rgb_bridge_fixture(**overrides)
    with pytest.raises(RuntimeError, match=match):
        _run_rgb_bridge(fixture)
    assert fixture.composed == {}  # no malformed sequence is ever composed
    if "view_name" not in overrides:
        assert fixture.calls == {}  # metadata failures never prepare a view


def test_rgb_bridge_requires_role_69_in_the_current_roster():
    fixture = _rgb_bridge_fixture(
        spec=SimpleNamespace(roles=(0, 70), phase_for_role=lambda role: 3))
    with pytest.raises(RuntimeError, match="role 69"):
        _run_rgb_bridge(fixture)


def test_typed_packed_low_rejects_hidden_half_and_e4m3_nonfinite():
    # FP16: reinterpret the packed bytes as Half, never convert uint8 to float.
    finite_half = torch.tensor(
        [0x0000, 0x3C00, 0x7BFF, 0x8000], dtype=torch.uint16).view(torch.uint8)
    assert video.validate_packed_low(
        finite_half, precision="fp16", expected_bytes=8)["nonfinite"] == 0
    for code in (0x7E00, 0x7C00, 0xFC00):  # NaN, +Inf, -Inf
        bad = torch.tensor([0x0000, code], dtype=torch.uint16).view(torch.uint8)
        with pytest.raises(ValueError, match="1 non-finite Half"):
            video.validate_packed_low(bad, precision="fp16")
    for values in ([0x7E00, 0x7C00], [0x7E00, 0xFC00]):
        bad = torch.tensor(values, dtype=torch.uint16).view(torch.uint8)
        with pytest.raises(ValueError, match="2 non-finite Half"):
            video.validate_packed_low(bad, precision="fp16")

    # E4M3: 0x7f and 0xff are the only NaN codes; 0x7e/0xfe are finite 448.
    finite_fp8 = torch.tensor([0x00, 0x38, 0x7E, 0xFE, 0xB8], dtype=torch.uint8)
    assert video.validate_packed_low(finite_fp8, precision="fp8")["nonfinite"] == 0
    for code in (0x7F, 0xFF):
        with pytest.raises(ValueError, match="1 non-finite FP8 E4M3"):
            video.validate_packed_low(torch.tensor([0x00, code], dtype=torch.uint8),
                                      precision="fp8")
    with pytest.raises(ValueError, match="2 non-finite FP8 E4M3"):
        video.validate_packed_low(torch.tensor([0x7F, 0xFF], dtype=torch.uint8),
                                  precision="fp8")


def test_typed_packed_low_rejects_malformed_packed_type_and_length():
    with pytest.raises(TypeError, match="uint8"):
        video.validate_packed_low(torch.zeros(4, dtype=torch.float32), precision="fp16")
    with pytest.raises(ValueError, match="1-D"):
        video.validate_packed_low(torch.zeros((2, 2), dtype=torch.uint8), precision="fp16")
    with pytest.raises(ValueError, match="whole fp16"):
        video.validate_packed_low(torch.zeros(3, dtype=torch.uint8), precision="fp16")
    with pytest.raises(ValueError, match="requires 8"):
        video.validate_packed_low(torch.zeros(4, dtype=torch.uint8),
                                  precision="fp16", expected_bytes=8)
    with pytest.raises(ValueError):
        video.validate_packed_low(torch.zeros(2, dtype=torch.uint8), precision="fp32")


def test_low_feature_binding_keeps_the_production_cuda_contract():
    layout = _trunk_layout()
    packed = torch.zeros(layout.pooled_bytes, dtype=torch.uint8)
    with pytest.raises(ValueError, match="legacy71/fp16") as error:
        video.validate_low_features(
            packed, model="legacy71", precision="fp16", layout=layout)
    assert "CUDA storage" in str(error.value)
    assert f"{layout.pooled_bytes} packed bytes" in str(error.value)


def test_pipeline_run_validates_before_post_and_allows_timed_disable(monkeypatch):
    # CPU-only fixture: replace the CUDA device context; never create a context.
    monkeypatch.setattr(torch.cuda, "device", lambda *args, **kwargs: contextlib.nullcontext())
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
    events.clear()
    pipeline.run(None, validate=False)
    assert events == ["pre", "trunk", "post"]
    events.clear()
    assert pipeline.run_trunk(validate=False) is pipeline.low
    assert events == ["trunk"]
    events.clear()
    pipeline.run_trunk()
    assert events == ["trunk", "validate"]


def test_benchmark_arm_times_rgb_trunk_with_validation_outside_events(
        tmp_path, monkeypatch):
    calls = []
    timed = []

    class FakePipeline:
        model = "legacy71"
        precision = "fp16"
        prepare_seconds = 0.0
        layout = SimpleNamespace(valid_width=4, valid_height=4)

        def __init__(self):
            self.plan = SimpleNamespace(guards_intact=lambda: True)
            self.output = torch.zeros(4, 4, 4)
            self.low = torch.zeros(4, 4, 4)

        def run(self, frame=None, *, validate=True):
            calls.append(("run", frame is not None, validate))
            return self.output

        def run_trunk(self, *, validate=True):
            calls.append(("run_trunk", validate))
            return self.low

        def valid_rgba(self):
            surface = torch.zeros(4, 4, 4)
            surface[..., 3] = 1.0
            return surface

        def download_rgb(self):
            return np.zeros((4, 4, 3), dtype=np.float32)

        def describe(self):
            return {"model": self.model, "precision": self.precision}

    def timed_cuda(fn, *, warmup, iterations, stream=None):
        timed.append("cuda")
        fn()
        return [1.0]

    def timed_cpu(fn, *, warmup, iterations):
        timed.append("cpu")
        fn()
        return [1.0]

    monkeypatch.setattr(compare_gameplay.video, "timed_cuda", timed_cuda)
    monkeypatch.setattr(compare_gameplay.video, "timed_cpu", timed_cpu)
    monkeypatch.setattr(compare_gameplay.video, "save_rgb_png",
                        lambda rgb, path: Path(path).write_bytes(b"png"))
    monkeypatch.setattr(compare_gameplay.video, "sha256_file", lambda path: "sha256")

    pipeline = FakePipeline()
    frame_path = tmp_path / "frame.png"
    frame_path.write_bytes(b"png")
    decoded = np.zeros((4, 4, 4), dtype=np.float32)
    decoded[..., 3] = 1.0
    fake_torch = SimpleNamespace(cuda=SimpleNamespace(synchronize=lambda: None))
    args = SimpleNamespace(output=tmp_path, warmup=1, iterations=1)

    arm = compare_gameplay._benchmark_arm(
        fake_torch, pipeline, frame_path, [frame_path], args, decoded=decoded)

    # Three validating preflight runs happen before the first timed closure.
    assert [call[0] for call in calls[:3]] == ["run", "run", "run"]
    assert all(call[2] is True for call in calls[:3])
    assert calls[3] == ("run_trunk", False)
    assert calls[4] == ("run", False, False)
    assert calls[5] == ("run", True, False)
    assert timed == ["cuda", "cuda", "cpu"]
    assert arm["measurements"]["trunk_only"]["scope"] == (
        "trunk_only_b69_plane16_on_precomputed_pooled")
    assert arm["validation_timing"]["preflight"].startswith("typed packed-low validation enabled")
    assert arm["validation_timing"]["timed_closures"] == (
        "typed packed-low validation disabled after preflight")
    assert arm["validation_timing"]["graph_capture"] == (
        "requires validation=False after a successful preflight")
    assert arm["guards_intact_after_timing"] is True


def test_describe_reports_plane16_trunk_and_tile4_plan_diagnostic():
    layout = _trunk_layout()
    pipeline = object.__new__(video.FramePipeline)
    pipeline.model = "legacy71"
    pipeline.spec = resolve_model("legacy71")
    pipeline.precision = "fp16"
    pipeline.seed = 0
    pipeline.post_phase = 1
    pipeline.layout = layout
    pipeline.pre_record = torch.zeros(1, dtype=torch.uint8)
    pipeline.post_record = torch.zeros(1, dtype=torch.uint8)
    pipeline.trunk_final = "window_block_c32_output_view_fp16"
    pipeline._plan_final_kernel = "window_block_c32_fp16"
    pipeline._trunk_height = layout.full_height // 2
    pipeline._trunk_width = layout.full_width // 2
    pipeline._trunk_phase = 3
    pipeline._trunk_logical_calls = 3
    pipeline._trunk_split_launches = 4
    pipeline.prepare_seconds = 0.0
    pipeline.plan = SimpleNamespace(
        buffer_names=lambda: ["input", "scratch", "b69.output"],
        split_launch_counts=lambda: [1, 2, 1])

    document = pipeline.describe()
    assert document["plan_final_kernel"] == "window_block_c32_fp16"
    assert document["plan_run_output_layout"] == "tile4"
    assert document["plan_run_is_diagnostic"] is True
    assert document["trunk_final_kernel"] == "window_block_c32_output_view_fp16"
    assert document["trunk_output_layout"] == "plane16"
    assert document["trunk_final_geometry"] == {
        "height": layout.full_height // 2,
        "width": layout.full_width // 2,
        "phase": 3,
        "origin": [0, -4],
        "grid": [(layout.full_width // 2 + 7) // 8,
                 (layout.full_height // 2 + 4 + 7) // 8, 1],
    }
    assert document["trunk_logical_calls"] == document["plan_logical_calls"] == 3
    assert document["trunk_split_launches"] == document["plan_split_launches"] == 4
    assert document["trunk_extra_repack"] is False
    assert document["trunk_launch_census_matches_plan"] is True
    assert document["trunk_final_kernel"] != document["plan_final_kernel"]
