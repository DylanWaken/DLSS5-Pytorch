"""Render and benchmark the native DLSS-NR RGB comparison.

Two source modes are supported:

* frames/video: the original decoded frames, the legacy71 native 71-block chain
  and the Small31 native chain, encoded as separate MP4s plus a three-way panel;
* a single PNG/JPEG still (``--input-image``): decode once, run the same native
  chains, and write only full-resolution PNGs.  A still run never encodes MP4
  and never describes a repeated still as video.

Every frame is RGB-only and stateless: the native preprocess receives empty
history/motion/depth/conditioning, the postprocess receives empty
history/motion/blend, and the four-channel head is displayed with the RGB
``OutputScale=1/32``/``bDisplayOutput=1`` ABI.

No GPU workload is executed by this source file at import time.  The GPU step
is documented in ``--help`` and the emitted manifest contains the exact argv.
"""
from __future__ import annotations

import argparse
import json
import sys
import time
import traceback
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from dlssnr import video  # noqa: E402

DEFAULT_INPUT_IMAGE = (
    ROOT / "profile/dlss-update-20261029/cyberpunk-source/"
           "selected_character_native.jpeg")
DEFAULT_FRAMES = None
DEFAULT_SOURCE_METADATA = None
DEFAULT_FFMPEG = (
    ROOT / "profile/dlss-update-20261029/video-source/tools/ffmpeg/"
    "ffmpeg-9.0.2-essentials_build/bin/ffmpeg.exe")
DEFAULT_SMALL_ARCHIVE = (
    ROOT / "profile/dlss-update-20261029/implementation/runtime-assets-small31")
DEFAULT_FP16_CHECKPOINT = ROOT / "ckpts/dlss5_nr_fp16.pt"
DEFAULT_FP8_CHECKPOINT = ROOT / "ckpts/dlss5_nr_fp8.pt"

RENDER_FOLDERS = ("original", "legacy71", "small31", "comparison")
STILL_FOOTER = (
    "Single decoded still: RGB-only stateless, empty history/motion/depth/"
    "conditioning/blend; fixed session noise seed; coded RGB [0,1], no EOTF. "
    "No video encoding and no quality/vendor-parity claim.")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--mode", choices=("render", "benchmark"), default="render",
                        help="render the three-way output or measure the four native arms")
    source = parser.add_mutually_exclusive_group()
    source.add_argument("--input-image", type=Path,
                        help="single PNG/JPEG still; renders PNG-only comparison")
    source.add_argument("--frames", type=Path,
                        help="RGB24 PNG frame directory (in order)")
    source.add_argument("--input-video", type=Path,
                        help="alternatively extract frames with ffmpeg (passthrough, no retiming)")
    parser.add_argument("--roi", type=int, nargs=4, default=None,
                        metavar=("X", "Y", "WIDTH", "HEIGHT"),
                        help="optional still-only ROI in original decoded pixels")
    parser.add_argument("--video-roi", type=int, nargs=4, default=None,
                        metavar=("X", "Y", "WIDTH", "HEIGHT"),
                        help="optional frame/video-only source-pixel ROI for a "
                             "separate three-arm comparison artifact; never a "
                             "model-input crop")
    parser.add_argument("--video-panel-width", type=int,
                        default=video.PANEL_DISPLAY_WIDTH,
                        help="display-only width of one panel in the video "
                             "three-way overview (default 1280; downscale-only, "
                             "native outputs are not resized)")
    parser.add_argument("--ffmpeg", type=Path, default=DEFAULT_FFMPEG,
                        help="pinned ffmpeg executable used only for video extraction/encoding")
    parser.add_argument("--fps", type=float, default=30.0,
                        help="shared frame rate; must match the source frames")
    parser.add_argument("--legacy-checkpoint", type=Path,
                        help="legacy71 checkpoint for --mode render (precision must match)")
    parser.add_argument("--legacy-fp16-checkpoint", type=Path,
                        default=DEFAULT_FP16_CHECKPOINT,
                        help="legacy71 FP16 checkpoint for --mode benchmark")
    parser.add_argument("--legacy-fp8-checkpoint", type=Path,
                        default=DEFAULT_FP8_CHECKPOINT,
                        help="legacy71 FP8 checkpoint for --mode benchmark")
    parser.add_argument("--small-archive", type=Path,
                        default=DEFAULT_SMALL_ARCHIVE,
                        help="extracted Small31 native archive directory")
    parser.add_argument("--output", type=Path, required=True,
                        help="output directory under the requested profile")
    parser.add_argument("--precision", choices=video.NATIVE_PRECISIONS, default="fp16",
                        help="render precision (benchmark always runs both)")
    parser.add_argument("--seed", type=int, default=20261029,
                        help="fixed session noise seed, identical for both models")
    parser.add_argument("--max-frames", type=int,
                        help="render/measure only the first N frames in order")
    parser.add_argument("--preview", type=int, nargs="?", const=8, default=None,
                        help="short preview render of N frames (default 8)")
    parser.add_argument("--device", type=int, default=0, help="CUDA device index")
    parser.add_argument("--warmup", type=int, default=10,
                        help="benchmark warmup iterations (>=10)")
    parser.add_argument("--iterations", type=int, default=50,
                        help="benchmark timed iterations (>=50)")
    parser.add_argument("--crf", type=int, default=16,
                        help="H.264 CRF; the same setting is used for all lanes")
    parser.add_argument("--source-metadata", type=Path, default=DEFAULT_SOURCE_METADATA,
                        help="optional generic metadata JSON; only supplied credits/"
                             "copyright/license/URLs are recorded (still mode also "
                             "auto-detects a sibling source.json)")
    parser.add_argument("--no-verify-hashes", action="store_true",
                        help="skip checkpoint/archive hash verification (not recommended)")
    return parser


def resolve_source(args) -> tuple[str, Path | None]:
    """Return ``(kind, path)``; the default source is the verified still."""
    if args.roi is not None and args.video_roi is not None:
        raise SystemExit("--roi is still-only and --video-roi is frame/video-only; "
                         "pass at most one")
    if args.input_image is not None:
        if args.video_roi is not None:
            raise SystemExit("--video-roi is only valid with --frames/--input-video")
        _require_file(args.input_image, "input image")
        if Path(args.input_image).suffix.lower() not in video.IMAGE_SUFFIXES:
            raise SystemExit(
                f"unsupported image suffix {Path(args.input_image).suffix!r}; "
                f"expected one of {video.IMAGE_SUFFIXES}")
        return "still", Path(args.input_image)
    if args.input_video is not None:
        if args.roi is not None:
            raise SystemExit("--roi is only valid with --input-image")
        return "video", Path(args.input_video)
    if args.frames is not None:
        if args.roi is not None:
            raise SystemExit("--roi is only valid with --input-image")
        return "frames", Path(args.frames)
    if args.roi is not None:
        raise SystemExit("--roi is only valid with --input-image")
    if args.video_roi is not None:
        raise SystemExit("--video-roi requires --frames or --input-video")
    if not DEFAULT_INPUT_IMAGE.is_file():
        raise SystemExit(
            "no --input-image/--frames/--input-video supplied and the verified "
            f"Cyberpunk still is missing: {DEFAULT_INPUT_IMAGE}")
    print(f"no source argument; using verified Cyberpunk still {DEFAULT_INPUT_IMAGE}",
          file=sys.stderr, flush=True)
    return "still", DEFAULT_INPUT_IMAGE


def _source_metadata(args, *, input_path=None) -> dict:
    if args.source_metadata is not None:
        _require_file(args.source_metadata, "source metadata")
    return video.load_source_metadata(args.source_metadata, input_path=input_path)


def _require_file(path: Path, role: str) -> Path:
    path = Path(path)
    if not path.is_file():
        raise SystemExit(f"{role} does not exist: {path}")
    return path


def _require_dir(path: Path, role: str) -> Path:
    path = Path(path)
    if not path.is_dir():
        raise SystemExit(f"{role} does not exist: {path}")
    return path


def _effective_limit(args) -> int | None:
    limit = args.max_frames
    if args.preview is not None:
        if args.preview < 1:
            raise SystemExit("--preview must be positive")
        limit = min(limit, args.preview) if limit else args.preview
    if limit is not None and limit < 1:
        raise SystemExit("--max-frames must be positive")
    return limit


def resolve_frame_directory(args) -> tuple[Path, list[Path]]:
    """Return the verified frame directory and ordered frame paths."""
    if args.input_video is not None:
        _require_file(args.input_video, "input video")
        _require_file(args.ffmpeg, "ffmpeg")
        directory = args.output / "source_frames"
        directory.mkdir(parents=True, exist_ok=True)
        argv = video.decode_video_frames_command(
            args.ffmpeg, args.input_video, directory / "frame_%04d.png")
        video.run_command(argv)
        frame_dir = directory
    else:
        frame_dir = _require_dir(args.frames, "frame directory")
    paths = video.iter_frame_paths(frame_dir, limit=_effective_limit(args))
    return frame_dir, paths


def _declared_frame_geometry(source_metadata: dict) -> dict:
    """Return supplied frame geometry/count without inferring any value."""
    excerpt = source_metadata.get("excerpt_rgb_frames")
    if isinstance(excerpt, dict) and excerpt:
        return excerpt
    canonical = source_metadata.get("canonical_frames")
    if not isinstance(canonical, dict):
        document = source_metadata.get("document")
        canonical = document.get("canonical_frames") if isinstance(document, dict) else None
    return canonical if isinstance(canonical, dict) else {}


def frame_header(paths: list[Path], source_metadata: dict) -> tuple[int, int]:
    """Read the first frame and cross-check against supplied source metadata."""
    first = video.decode_rgb_png(paths[0])
    height, width = first.shape[:2]
    declared_frames = _declared_frame_geometry(source_metadata)
    if declared_frames:
        if declared_frames.get("width") != width or declared_frames.get("height") != height:
            raise SystemExit(
                f"frame size {width}x{height} differs from source metadata "
                f"{declared_frames.get('width')}x{declared_frames.get('height')}")
        declared = declared_frames.get("count")
        if declared is not None and len(paths) > declared:
            raise SystemExit(
                f"{len(paths)} frames requested but source metadata declares {declared}")
    return width, height


def _check_full_frame_set(paths: list[Path], source_metadata: dict, args):
    """Default runs consume the complete declared excerpt, in order."""
    if _effective_limit(args) is not None:
        return
    declared = _declared_frame_geometry(source_metadata).get("count")
    if declared is not None and len(paths) != declared:
        raise SystemExit(
            f"this run must consume all {declared} excerpt frames in order, "
            f"found {len(paths)}; pass --max-frames/--preview for a short run")


def frame_source_document(frame_dir: Path, paths: list[Path], width: int, height: int,
                          fps: float, source_metadata: dict,
                          display: dict | None = None) -> dict:
    metadata_path = frame_dir / "frames_metadata.jsonl"
    document = {
        "directory": str(frame_dir),
        "count": len(paths),
        "first": paths[0].name,
        "last": paths[-1].name,
        "width": width,
        "height": height,
        "fps": fps,
        "pixel_format": "RGB24 8-bit, display-coded full range, no EOTF/OETF",
        "order": "exact filesystem order (zero-padded frame numbers)",
        "resize": "none",
        "inference_resize": False,
        "native_arm_output_size": {"width": width, "height": height},
        "interpolation": "none",
        "frames_metadata_jsonl": str(metadata_path) if metadata_path.is_file() else None,
        "frames_metadata_sha256": (
            video.sha256_file(metadata_path) if metadata_path.is_file() else None),
    }
    if display is not None:
        document["display_geometry"] = display
    if source_metadata.get("available"):
        document["source_json"] = source_metadata["path"]
        for key in ("title", "artist", "copyright", "license", "license_url",
                    "page_url", "source_url", "credit", "attribution_line",
                    "derivative_notice"):
            if source_metadata.get(key) is not None:
                document[key] = source_metadata[key]
    return document


def video_geometry_document(width: int, height: int, panel_width: int, *,
                            roi=None) -> dict:
    """Machine-readable source/native/display distinction for a video render.

    ``source`` and ``native_arm_output`` are the unchanged decoded geometry;
    ``comparison_panel``/``output_dimensions`` describe the explicit display
    overview only.  An optional ``roi`` is a source-pixel crop shared by all
    three arms for a separate artifact, never a model-input crop.
    """
    geometry = video.display_panel_geometry(width, height, panel_width)
    document = {
        "source": geometry["source"],
        "native_arm_output": geometry["native_arm_output"],
        "comparison_panel": geometry["panel"],
        "panel_layout": geometry["layout"],
        "output_dimensions": geometry["output_dimensions"],
        "filter": geometry["filter"],
        "filter_name": geometry["filter_name"],
        "aspect_ratio": geometry["source"]["aspect_ratio"],
        "display_only": True,
        "inference_resize": False,
        "model_input_resize": False,
        "note": (
            "Only the three-way overview is resized for display; model inputs "
            "and the original/legacy71/small31 PNG+video artifacts keep the "
            "decoded source extent."),
    }
    if roi is not None:
        x, y, roi_width, roi_height = video.validate_roi(roi, width, height)
        roi_geometry = video.display_panel_geometry(roi_width, roi_height, panel_width)
        document["roi"] = {
            "x": x,
            "y": y,
            "width": roi_width,
            "height": roi_height,
            "coordinate_system": "decoded source pixels, origin top-left",
            "source_pixels": True,
            "source_width": width,
            "source_height": height,
            "same_coordinates_all_arms": True,
            "arms": ["original", "legacy71", "small31"],
            "per_arm_native_pixels": True,
            "inference_crop": False,
            "model_input_crop": False,
            "display_geometry": roi_geometry,
            "display_scaled": roi_geometry["panel"]["downscaled"],
            "display_scale": roi_geometry["panel"]["scale"],
            "note": (
                "The same source-pixel rectangle is cropped from all three "
                "native arms only for a separate comparison ROI artifact; it "
                "does not crop the model input or resize the per-arm outputs."),
        }
    return document


def _extension_identity(device: int) -> tuple[str | None, str | None, str | None]:
    """Best-effort extension binary identity; never required for a run."""
    try:
        from dlssnr._binary import extension_path
        binary = str(extension_path(device))
        return binary, video.sha256_file(binary), None
    except Exception as error:  # provenance is optional
        return None, None, f"{type(error).__name__}: {error}"


def _load_small(args):
    return video.load_native_model(
        args.small_archive, model="small31", verify_hash=not args.no_verify_hashes)


def _load_legacy(path: Path, args):
    return video.load_native_model(
        _require_file(path, "legacy checkpoint"), model="legacy71",
        verify_hash=not args.no_verify_hashes)


def _build_pipeline(model: str, precision: str, weights, width: int, height: int,
                    args) -> video.FramePipeline:
    try:
        return video.FramePipeline(
            model=model, precision=precision, weights=weights,
            valid_width=width, valid_height=height, seed=args.seed, device=args.device)
    except RuntimeError as error:
        if model == "small31" and video.SMALL31_REBUILD_MESSAGE in str(error):
            raise SystemExit(str(error)) from error
        raise


def _render_totals(torch, pipeline: video.FramePipeline, rgba: np.ndarray) -> tuple[dict, np.ndarray]:
    """Run one frame, validate the native RGBA surface and return display RGB."""
    pipeline.run(rgba)
    torch.cuda.synchronize()
    surface = np.ascontiguousarray(pipeline.valid_rgba().cpu().numpy())
    stats = video.validate_rgba_output(surface)
    rgb = video.rgb_to_uint8(surface[..., :3])
    return stats, rgb


def run_render(args) -> dict:
    import torch

    torch.cuda.set_device(args.device)
    legacy_checkpoint = args.legacy_checkpoint or (
        DEFAULT_FP16_CHECKPOINT if args.precision == "fp16" else DEFAULT_FP8_CHECKPOINT)
    legacy_checkpoint = _require_file(legacy_checkpoint, "legacy checkpoint")
    _require_dir(args.small_archive, "Small31 archive")
    _require_file(args.ffmpeg, "ffmpeg")
    if not 0 <= args.seed <= 0xFFFFFFFF:
        raise SystemExit("--seed must be a uint32")
    source_metadata = _source_metadata(args)
    frame_dir, paths = resolve_frame_directory(args)
    width, height = frame_header(paths, source_metadata)
    _check_full_frame_set(paths, source_metadata, args)
    video_panel_width = getattr(args, "video_panel_width", video.PANEL_DISPLAY_WIDTH)
    if isinstance(video_panel_width, bool) or video_panel_width < 1:
        raise SystemExit("--video-panel-width must be a positive integer")
    video_roi = None
    if getattr(args, "video_roi", None) is not None:
        video_roi = tuple(video.validate_roi(args.video_roi, width, height))
    display_document = video_geometry_document(
        width, height, video_panel_width, roi=video_roi)
    panel_width = display_document["comparison_panel"]["width"]
    panel_height = display_document["comparison_panel"]["height"]
    args.output.mkdir(parents=True, exist_ok=True)
    render_dir = args.output / "render"
    render_folders = list(RENDER_FOLDERS)
    if video_roi is not None:
        render_folders.append("comparison_roi")
    for folder in render_folders:
        (render_dir / folder).mkdir(parents=True, exist_ok=True)

    models_started = time.perf_counter()
    legacy = _load_legacy(legacy_checkpoint, args)
    small = _load_small(args)
    model_load_seconds = time.perf_counter() - models_started
    extension_binary, extension_sha, extension_error = _extension_identity(args.device)
    legacy_pipeline = _build_pipeline("legacy71", args.precision, legacy, width, height, args)
    small_pipeline = _build_pipeline("small31", args.precision, small, width, height, args)
    pipelines = {"legacy71": legacy_pipeline, "small31": small_pipeline}
    descriptions = [pipeline.describe() for pipeline in pipelines.values()]
    captions = video.comparison_captions(descriptions, width=width, height=height)
    footer = (
        f"RGB-only stateless: empty history/motion/depth/conditioning/blend; fixed "
        f"seed {args.seed}; coded RGB [0,1], no EOTF. Original panel is the "
        f"unchanged decoded {width}x{height} frame; overview displayed at "
        f"{panel_width}x{panel_height} per panel (LANCZOS, display only). "
        "No quality or vendor-parity claim.")
    roi_footer = None
    if video_roi is not None:
        roi_doc = display_document["roi"]
        roi_footer = (
            f"{footer} ROI x={roi_doc['x']} y={roi_doc['y']} "
            f"width={roi_doc['width']} height={roi_doc['height']} in decoded "
            f"source pixels; same crop for all three arms; displayed at "
            f"{roi_doc['display_geometry']['panel']['width']}x"
            f"{roi_doc['display_geometry']['panel']['height']}.")

    frame_records = []
    for index, path in enumerate(paths):
        rendered = {}
        original_u8 = video.decode_rgb_png(
            path, expected_width=width, expected_height=height)
        original_rgba = video.rgb_to_rgba(original_u8)
        row = {
            "index": index,
            "source_file": path.name,
            "source_sha256": video.sha256_file(path),
            "frame_period_s": float(1.0 / args.fps),
            "pts_s": float(index / args.fps),
        }
        for name, pipeline in pipelines.items():
            stats, rgb = _render_totals(torch, pipeline, original_rgba)
            if rgb.shape[:2] != (height, width):
                raise RuntimeError(
                    f"{name} returned {rgb.shape[1]}x{rgb.shape[0]}; the native "
                    f"arm must keep the unchanged {width}x{height} source extent")
            rendered[name] = rgb
            output_png = render_dir / name / f"frame_{index:04d}.png"
            video.save_rgb_png(rgb, output_png)
            row[name] = {
                "float32_sha256": stats["sha256"],
                "png_sha256": video.sha256_file(output_png),
                "width": width,
                "height": height,
                "rgb_min": stats["rgb_min"],
                "rgb_max": stats["rgb_max"],
                "alpha_min": stats["alpha_min"],
                "alpha_max": stats["alpha_max"],
            }
        panel = video.compose_comparison_panel(
            original_u8, rendered["legacy71"], rendered["small31"],
            captions=captions, footer=footer, panel_width=video_panel_width)
        panel_path = render_dir / "comparison" / f"frame_{index:04d}.png"
        video.save_rgb_png(panel, panel_path)
        row["comparison_png_sha256"] = video.sha256_file(panel_path)
        row["comparison_width"] = int(panel.shape[1])
        row["comparison_height"] = int(panel.shape[0])
        if video_roi is not None:
            crops = video.crop_same_roi(
                (original_u8, rendered["legacy71"], rendered["small31"]), video_roi)
            roi_panel = video.compose_comparison_panel(
                crops["original"], crops["legacy71"], crops["small31"],
                captions=captions, footer=roi_footer,
                panel_width=video_panel_width)
            roi_panel_path = render_dir / "comparison_roi" / f"frame_{index:04d}.png"
            video.save_rgb_png(roi_panel, roi_panel_path)
            row["comparison_roi_png_sha256"] = video.sha256_file(roi_panel_path)
            row["comparison_roi_crop_pixels"] = {
                "x": video_roi[0], "y": video_roi[1],
                "width": video_roi[2], "height": video_roi[3],
            }
            row["comparison_roi_arms_sha256"] = {
                name: video.sha256_array(crop) for name, crop in crops.items()}
        original_png = render_dir / "original" / f"frame_{index:04d}.png"
        video.save_rgb_png(original_u8, original_png)
        row["original_png_sha256"] = video.sha256_file(original_png)
        frame_records.append(row)
        if index == 0 or (index + 1) % 30 == 0 or index + 1 == len(paths):
            print(f"rendered {index + 1}/{len(paths)} frames", file=sys.stderr, flush=True)

    _require_file(args.ffmpeg, "ffmpeg")
    encode_dir = args.output / "encode"
    encode_dir.mkdir(parents=True, exist_ok=True)
    encodes = {}
    for name in render_folders:
        pattern = render_dir / name / "frame_%04d.png"
        output = encode_dir / f"{name}.mp4"
        argv = video.encode_png_sequence_command(
            args.ffmpeg, pattern, args.fps, output, crf=args.crf)
        video.run_command(argv)
        if name == "comparison":
            encoded_width = display_document["output_dimensions"]["width"]
            encoded_height = display_document["output_dimensions"]["height"]
            lane_role = "display-only three-way overview"
        elif name == "comparison_roi":
            roi_geometry = display_document["roi"]["display_geometry"]
            encoded_width = roi_geometry["output_dimensions"]["width"]
            encoded_height = roi_geometry["output_dimensions"]["height"]
            lane_role = "display-only three-arm ROI overview"
        else:
            encoded_width = width
            encoded_height = height
            lane_role = "native source extent"
        encodes[name] = {
            "path": str(output),
            "sha256": video.sha256_file(output),
            "command": argv,
            "frames": len(paths),
            "fps": args.fps,
            "width": encoded_width,
            "height": encoded_height,
            "lane_role": lane_role,
            "codec": "libx264",
            "crf": args.crf,
            "pix_fmt": "yuv420p",
            "audio": False,
            "scale_filter": None,
        }

    methodology = {
        "primary_mode": "RGB-only stateless",
        "history": "empty for every frame; native preprocess copies current into history lanes",
        "motion": "empty", "depth": "empty", "conditioning": "empty", "blend": "empty",
        "color": "valid-size RGBA float32, coded RGB [0,1], no EOTF/OETF",
        "noise": "fixed session seed, identical for both models",
        "post_head": "four-channel native head: RGB residual + history gate; gate unused without history",
        "post_abi": dict(descriptions[0]["display_abi"]),
        "models": {
            "legacy71": {**descriptions[0],
                         "weights_path": str(legacy_checkpoint),
                         "weights_sha256": video.sha256_file(legacy_checkpoint),
                         "checkpoint_precision": legacy.precision},
            "small31": {**descriptions[1],
                        "archive_path": str(args.small_archive),
                        "archive_manifest_sha256": getattr(small, "manifest_sha256", None),
                        "dll_sha256": getattr(small, "dll_sha256", None),
                        "resource_sha256": getattr(small.archive, "resource_sha256", None)},
        },
        "frame_order": "single pass, ascending frame number, no interpolation or frame drop",
        "display_geometry": display_document,
        "encode": {
            "same_settings_all_lanes": True,
            "codec": "libx264",
            "crf": args.crf,
            "pix_fmt": "yuv420p",
            "audio": False,
            "individual_upscale": False,
            "panel": (
                f"three display-only {panel_width}x{panel_height} panels "
                f"(LANCZOS downscale from {width}x{height}), headers, gaps and "
                "one footer; no enhancement, sharpen or per-arm resize"),
        },
    }
    manifest = video.manifest_document(
        mode="render",
        command=sys.argv,
        environment={
            **video.gpu_environment(args.device),
            "extension_binary": extension_binary,
            "extension_sha256": extension_sha,
            "extension_binary_error": extension_error,
            "model_load_seconds": model_load_seconds,
            "python": sys.version.split()[0],
            "source_metadata": str(args.source_metadata),
        },
        models=descriptions,
        frame_source=frame_source_document(
            frame_dir, paths, width, height, args.fps, source_metadata,
            display=display_document),
        methodology=methodology,
        source_metadata=source_metadata,
        extra={
            "outputs": encodes,
            "render_folders": {name: str(render_dir / name) for name in render_folders},
            "display_geometry": display_document,
            "roi": display_document.get("roi", {"applied": False}),
            "frame_manifest": str(args.output / "frames.json"),
            "note": "Actual native outputs were rendered before encoding; the original lane is the decoded source frame.",
        },
    )
    video.write_json(args.output / "manifest.json", manifest)
    video.write_json(args.output / "frames.json", {
        "schema": "dlssnr.video-harness.frames.v1",
        "count": len(frame_records),
        "frames": frame_records,
    })
    return manifest


def _png_record(path: Path, image: np.ndarray) -> dict:
    return {
        "path": str(path),
        "sha256": video.sha256_file(path),
        "width": int(image.shape[1]),
        "height": int(image.shape[0]),
        "pixel_format": "RGB24 PNG",
    }


def save_still_artifacts(output, original_u8: np.ndarray, rendered: dict, *,
                         captions: dict, footer: str, roi=None):
    """Write the original + two native PNGs and the labeled three-way panels.

    No MP4 is produced.  The ROI crop uses the exact same original-image
    coordinates for all three arms.
    """
    still_dir = Path(output) / "still"
    still_dir.mkdir(parents=True, exist_ok=True)
    outputs = {}
    for name, image in (("original", original_u8),
                        ("legacy71", rendered["legacy71"]),
                        ("small31", rendered["small31"])):
        path = still_dir / f"{name}.png"
        video.save_rgb_png(image, path)
        outputs[name] = _png_record(path, image)

    panel = video.compose_full_resolution_panel(
        original_u8, rendered["legacy71"], rendered["small31"],
        captions=captions, footer=footer)
    panel_path = still_dir / "comparison_3way.png"
    video.save_rgb_png(panel, panel_path)
    outputs["comparison_3way"] = _png_record(panel_path, panel)

    roi_info = None
    if roi is not None:
        x, y, width, height = video.validate_roi(
            roi, original_u8.shape[1], original_u8.shape[0])
        crops = {
            "original": video.crop_rgb(original_u8, (x, y, width, height)),
            "legacy71": video.crop_rgb(rendered["legacy71"], (x, y, width, height)),
            "small31": video.crop_rgb(rendered["small31"], (x, y, width, height)),
        }
        roi_footer = (
            f"{footer} ROI x={x} y={y} width={width} height={height} in original "
            "decoded pixels; identical crop coordinates for all three arms.")
        roi_panel = video.compose_full_resolution_panel(
            crops["original"], crops["legacy71"], crops["small31"],
            captions=captions, footer=roi_footer)
        roi_path = still_dir / "comparison_3way_roi.png"
        video.save_rgb_png(roi_panel, roi_path)
        outputs["comparison_3way_roi"] = _png_record(roi_path, roi_panel)
        roi_info = {
            "x": x, "y": y, "width": width, "height": height,
            "coordinate_system": "original decoded image pixels, origin top-left",
            "same_coordinates_all_arms": True,
            "arms": ["original", "legacy71", "small31"],
            "per_arm_crop_png": {
                name: {
                    "width": int(crop.shape[1]), "height": int(crop.shape[0]),
                    "sha256": video.sha256_array(crop),
                } for name, crop in crops.items()
            },
        }
    return still_dir, outputs, roi_info


def still_source_document(image_path: Path, original_u8: np.ndarray, *,
                          roi_info: dict | None) -> dict:
    height, width = original_u8.shape[:2]
    document = {
        "kind": "still_image",
        "still": True,
        "frame_count": 1,
        "video_encoding": False,
        "path": str(image_path),
        "sha256": video.sha256_file(image_path),
        "format": image_path.suffix.lower().lstrip("."),
        "width": width,
        "height": height,
        "decoded_rgb_sha256": video.sha256_array(original_u8),
        "pixel_format": "RGB24 8-bit display-coded full range",
        "pixel_transform": (
            "single Pillow decode to RGB; no resize, no crop and no EOTF/OETF; "
            "values divided by 255 into float32 RGBA with alpha=1"),
        "model_input_crop": {
            "x": 0, "y": 0, "width": width, "height": height, "applied": False,
            "note": ("the full decoded frame is the model-input valid extent; "
                     "only native physical output padding is cropped"),
        },
        "roi": roi_info if roi_info is not None else {"applied": False},
        "stateless_inputs": {
            "history": "empty", "motion": "empty", "depth": "empty",
            "conditioning": "empty", "blend": "empty",
        },
        "no_interpolation": True,
        "no_frame_repetition": True,
    }
    return document


def _render_still_arm(pipeline, rgba: np.ndarray):
    """Run one native arm once and validate its full valid-size RGBA surface."""
    pipeline.run(rgba)
    surface = np.ascontiguousarray(pipeline.valid_rgba().detach().cpu().numpy())
    stats = video.validate_rgba_output(surface)
    return stats, video.rgb_to_uint8(surface[..., :3])


def render_still_comparison(*, args, image_path: Path, original_u8: np.ndarray,
                            pipelines: dict, descriptions: list,
                            source_metadata: dict, model_records: dict,
                            environment: dict) -> dict:
    """Execute both native arms on the one decoded still and write PNGs only."""
    width, height = original_u8.shape[1], original_u8.shape[0]
    roi_info = None
    if args.roi is not None:
        x, y, w, h = video.validate_roi(args.roi, width, height)
        roi_info = {
            "x": x, "y": y, "width": w, "height": h,
            "coordinate_system": "original decoded image pixels, origin top-left",
            "same_coordinates_all_arms": True,
        }
    rgba = video.rgb_to_rgba(original_u8)  # decoded once, converted once
    rendered = {}
    arm_records = {}
    for name in ("legacy71", "small31"):
        stats, rgb = _render_still_arm(pipelines[name], rgba)
        if rgb.shape[:2] != (height, width):
            raise RuntimeError(
                f"{name} returned {rgb.shape[1]}x{rgb.shape[0]}; the still "
                f"requires the unchanged {width}x{height} source extent")
        rendered[name] = rgb
        arm_records[name] = {
            "float32_sha256": stats["sha256"],
            "rgb_min": stats["rgb_min"], "rgb_max": stats["rgb_max"],
            "alpha_min": stats["alpha_min"], "alpha_max": stats["alpha_max"],
        }

    captions = video.comparison_captions(
        descriptions, width=width, height=height)
    still_dir, outputs, saved_roi = save_still_artifacts(
        args.output, original_u8, rendered, captions=captions,
        footer=STILL_FOOTER, roi=args.roi)
    if roi_info is not None:
        roi_info.update(saved_roi)

    source = still_source_document(image_path, original_u8, roi_info=roi_info)
    by_model = {item["model"]: item for item in descriptions}
    methodology = {
        "primary_mode": "single still image (RGB-only stateless)",
        "still": True,
        "video": False,
        "frame_count": 1,
        "decode_count": 1,
        "frame_repetition": "none; each native arm is executed once for the render",
        "history": "empty for the still; native preprocess copies current into history lanes",
        "motion": "empty", "depth": "empty", "conditioning": "empty", "blend": "empty",
        "color": "valid-size RGBA float32, coded RGB [0,1], no EOTF/OETF",
        "noise": "one fixed session seed, identical for both models",
        "post_head": "four-channel native head: RGB residual + history gate; gate unused without history",
        "post_phases": {
            name: {"post_phase": by_model[name]["post_phase"],
                   "source": by_model[name]["post_phase_source"]}
            for name in ("legacy71", "small31")
        },
        "encode": {
            "performed": False,
            "reason": "a still image is never encoded as an MP4 or described as video",
            "outputs": "PNGs only",
        },
        "roi": roi_info if roi_info is not None else {"applied": False},
        "model_identities": model_records,
    }
    manifest = video.manifest_document(
        mode="still",
        command=sys.argv,
        environment=environment,
        models=descriptions,
        frame_source=source,
        methodology=methodology,
        source_metadata=source_metadata,
        extra={
            "outputs": outputs,
            "still_directory": str(still_dir),
            "same_frame_replay": False,
            "note": ("The original lane is the unchanged decoded still; the "
                     "legacy71/small31 lanes are actual native runs of that "
                     "same single input. No video is encoded."),
        },
    )
    video.write_json(args.output / "manifest.json", manifest)
    return manifest


def run_still_render(args, image_path: Path) -> dict:
    import torch

    if not 0 <= args.seed <= 0xFFFFFFFF:
        raise SystemExit("--seed must be a uint32")
    original_u8 = video.decode_rgb_image(image_path)  # decoded exactly once
    width, height = original_u8.shape[1], original_u8.shape[0]
    if args.roi is not None:
        video.validate_roi(args.roi, width, height)
    source_metadata = _source_metadata(args, input_path=image_path)
    legacy_checkpoint = args.legacy_checkpoint or (
        DEFAULT_FP16_CHECKPOINT if args.precision == "fp16" else DEFAULT_FP8_CHECKPOINT)
    legacy_checkpoint = _require_file(legacy_checkpoint, "legacy checkpoint")
    _require_dir(args.small_archive, "Small31 archive")
    args.output.mkdir(parents=True, exist_ok=True)
    torch.cuda.set_device(args.device)

    models_started = time.perf_counter()
    legacy = _load_legacy(legacy_checkpoint, args)
    small = _load_small(args)
    model_load_seconds = time.perf_counter() - models_started
    extension_binary, extension_sha, extension_error = _extension_identity(args.device)
    legacy_pipeline = _build_pipeline("legacy71", args.precision, legacy, width, height, args)
    small_pipeline = _build_pipeline("small31", args.precision, small, width, height, args)
    pipelines = {"legacy71": legacy_pipeline, "small31": small_pipeline}
    descriptions = [pipeline.describe() for pipeline in pipelines.values()]
    model_records = {
        "legacy71": {
            "weights_path": str(legacy_checkpoint),
            "weights_sha256": video.sha256_file(legacy_checkpoint),
            "checkpoint_precision": legacy.precision,
        },
        "small31": {
            "archive_path": str(args.small_archive),
            "archive_manifest_sha256": getattr(small, "manifest_sha256", None),
            "dll_sha256": getattr(small, "dll_sha256", None),
            "resource_sha256": getattr(small.archive, "resource_sha256", None),
        },
    }
    environment = {
        **video.gpu_environment(args.device),
        "extension_binary": extension_binary,
        "extension_sha256": extension_sha,
        "extension_binary_error": extension_error,
        "model_load_seconds": model_load_seconds,
        "python": sys.version.split()[0],
        "source_metadata": str(args.source_metadata) if args.source_metadata else None,
    }
    return render_still_comparison(
        args=args, image_path=image_path, original_u8=original_u8,
        pipelines=pipelines, descriptions=descriptions,
        source_metadata=source_metadata, model_records=model_records,
        environment=environment)


def _still_plan_memory_census(width: int, height: int) -> dict:
    """CPU census of the four native plan buffer allocations at this geometry."""
    from tuning.physical_schedule import make

    arms = {}
    total = 0
    for model in ("legacy71", "small31"):
        for precision in ("fp16", "fp8"):
            plan = make(width, height, precision=precision, model=model)
            buffers = plan.get("buffers", {})
            storage = sum(int(info.get("storage_bytes", 0))
                          for info in buffers.values())
            total += storage
            arms[f"{model}/{precision}"] = {
                "buffers": len(buffers),
                "storage_bytes": storage,
                "storage_gib": round(storage / (1 << 30), 4),
            }
    lease_gib = 95.59
    return {
        "arms": arms,
        "total_plan_storage_bytes": total,
        "total_plan_storage_gib": round(total / (1 << 30), 4),
        "device_lease_gib": lease_gib,
        "fits_device_lease": total <= lease_gib * (1 << 30),
        "note": ("plan storage census only; frontends, textures and weights add "
                 "to real usage, so this is a lower bound"),
    }


def run_still_benchmark(args, image_path: Path) -> dict:
    import torch

    if not torch.cuda.is_available():
        raise SystemExit("benchmark requires a CUDA device (this step only runs CPU checks)")
    torch.cuda.set_device(args.device)
    capability = tuple(torch.cuda.get_device_capability(args.device))
    if capability != (12, 0):
        raise SystemExit(
            f"benchmark requires SM120, found sm_{capability[0]}{capability[1]}; "
            "the four-arm native comparison is pinned to the published SM120 lease")
    if args.warmup < 10 or args.iterations < 50:
        raise SystemExit("benchmark requires --warmup>=10 and --iterations>=50")
    if not 0 <= args.seed <= 0xFFFFFFFF:
        raise SystemExit("--seed must be a uint32")
    decode_began = time.perf_counter()
    original_u8 = video.decode_rgb_image(image_path)  # decoded exactly once
    decode_seconds = time.perf_counter() - decode_began
    width, height = original_u8.shape[1], original_u8.shape[0]
    roi_info = None
    if args.roi is not None:
        x, y, w, h = video.validate_roi(args.roi, width, height)
        roi_info = {
            "x": x, "y": y, "width": w, "height": h,
            "coordinate_system": "original decoded image pixels, origin top-left",
            "same_coordinates_all_arms": True,
        }
    for path, role in ((args.legacy_fp16_checkpoint, "legacy FP16 checkpoint"),
                       (args.legacy_fp8_checkpoint, "legacy FP8 checkpoint")):
        _require_file(path, role)
    _require_dir(args.small_archive, "Small31 archive")
    source_metadata = _source_metadata(args, input_path=image_path)
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output / "benchmark").mkdir(parents=True, exist_ok=True)

    environment_before = video.gpu_environment(args.device)
    clocks_before = video.nvidia_smi_snapshot()
    decoded_rgba = video.rgb_to_rgba(original_u8)

    loaded = {}
    load_seconds = {}
    for precision, path in (("fp16", args.legacy_fp16_checkpoint),
                            ("fp8", args.legacy_fp8_checkpoint)):
        began = time.perf_counter()
        loaded[("legacy71", precision)] = _load_legacy(path, args)
        load_seconds[("legacy71", precision)] = time.perf_counter() - began
    began = time.perf_counter()
    small = _load_small(args)
    load_seconds[("small31", None)] = time.perf_counter() - began

    prepared = {}
    construct_seconds = {}
    for precision in ("fp16", "fp8"):
        for model in ("legacy71", "small31"):
            weights = small if model == "small31" else loaded[(model, precision)]
            began = time.perf_counter()
            prepared[(model, precision)] = _build_pipeline(
                model, precision, weights, width, height, args)
            construct_seconds[(model, precision)] = time.perf_counter() - began

    arms = {}
    model_docs = []
    for (model, precision), pipeline in prepared.items():
        weights = small if model == "small31" else loaded[(model, precision)]
        arm = _benchmark_arm(torch, pipeline, image_path, [image_path], args,
                             decoded=decoded_rgba)
        arm["preparation_seconds"]["model_load"] = load_seconds[
            (model, precision) if model == "legacy71" else (model, None)]
        arm["preparation_seconds"]["pipeline_construct"] = construct_seconds[(model, precision)]
        if model == "legacy71":
            arm["weights"] = {
                "path": str(args.legacy_fp16_checkpoint if precision == "fp16"
                            else args.legacy_fp8_checkpoint),
                "sha256": video.sha256_file(
                    args.legacy_fp16_checkpoint if precision == "fp16"
                    else args.legacy_fp8_checkpoint),
                "checkpoint_precision": weights.precision,
            }
        else:
            arm["weights"] = {
                "archive": str(args.small_archive),
                "manifest_sha256": getattr(small, "manifest_sha256", None),
                "dll_sha256": getattr(small, "dll_sha256", None),
                "resource_sha256": getattr(small.archive, "resource_sha256", None),
                "checkpoint_precision": getattr(small, "precision", "fp8"),
            }
        arms[f"{model}/{precision}"] = arm
        model_docs.append(pipeline.describe())

    binary, binary_sha, binary_error = _extension_identity(args.device)
    clocks_after = video.nvidia_smi_snapshot()
    source = still_source_document(image_path, original_u8, roi_info=roi_info)
    manifest = video.manifest_document(
        mode="still-benchmark",
        command=sys.argv,
        environment={
            **environment_before,
            "python": sys.version.split()[0],
            "extension_binary": binary,
            "extension_sha256": binary_sha,
            "clock_power_before": clocks_before,
            "clock_power_after": clocks_after,
        },
        models=model_docs,
        frame_source=source,
        methodology={
            "device_requirement": "SM120 (12.0) explicit check; the four arms are pinned to that lease",
            "still": True,
            "video": False,
            "decode_count": 1,
            "decode": {
                "included_in_cpu_wall": False,
                "single_decode_seconds": decode_seconds,
                "note": ("the still is decoded and converted once before every "
                         "timer; the CPU wall scope starts at H2D, so do not read "
                         "it as decode-inclusive end-to-end time"),
            },
            "all_four_arms_prepared_before_timing": True,
            "preparation_memory": _still_plan_memory_census(width, height),
            "same_frame_replay": True,
            "frame_repetition": (
                "the one decoded still is replayed for every timed iteration; this "
                "is explicitly a same-frame replay, not a video or new-frame workload"),
            "arms": "legacy71/fp16, legacy71/fp8, small31/fp16, small31/fp8",
            "shared": "same valid geometry, same decoded still for every arm, same fixed noise seed",
            "stateless": "empty history/motion/depth/conditioning/blend for every replay",
            "trunk_only": (
                "prepared RGB trunk sequence (185 legacy / 109 Small logical calls; "
                "all plan descriptors reused except the final phase-3 C32 output view) "
                "on precomputed real pooled input; b69 is plane16, NOT a video FPS. "
                "plan.run_* remains a separate tile4 diagnostic and is not timed"),
            "full_gpu": "preprocess + RGB plane16 trunk + postprocess on the current stream, including native per-launch texture/surface D2D copies; excludes H2D/D2H and encoder",
            "validation": "typed packed-low FP16 Half / FP8 E4M3 non-finite check runs before post in renderer paths and in each arm's preflight; every timed closure disables it after that preflight; CUDA graph capture requires it disabled",
            "cpu_wall": "host wall from H2D of the already-decoded still through full GPU, synchronize and valid RGB D2H; decode excluded, encoder excluded",
            "timing": "CUDA events with end.synchronize() per interval; CPU perf_counter across explicit synchronize boundaries",
            "warmup": args.warmup,
            "iterations": args.iterations,
            "statistics": "median/p10/p90/mean/min/max plus FPS derived from the median within each scope",
            "allocation": "plan, records, records packing, frontends, the RGB sequence and buffers are prepared outside every timed loop; no repack kernel or second field",
            "before_timing": "two validating replays hashed equal, finite [0,1] RGB, alpha 1, typed low state finite, plan guards intact; a lossless validation PNG is written",
            "guards": "plan.guards_intact() checked before and after every timed arm",
            "encode": {"performed": False, "reason": "still input, no video"},
            "roi": roi_info if roi_info is not None else {"applied": False},
        },
        source_metadata=source_metadata,
        extra={
            "arms": arms,
            "same_frame_replay": True,
            "benchmark_support_limits": [
                "These are reconstructed native host timings, not an original NGX/DLSS benchmark.",
                "No vendor parity, quality score or close-to-original claim is made.",
                "Every timed iteration replays the same decoded still; do not read these numbers as video FPS.",
                "The CPU wall scope excludes decode/encode and includes H2D/D2H plus full GPU.",
                "The frontend's hidden D2D texture/surface copies are included in full GPU and excluded from trunk-only.",
                "trunk_only is the prepared RGB plane16 sequence (final phase-3 C32 output view); the untouched plan.run_* tile4 layout is a separate diagnostic and is never the timed path.",
                "Typed packed-low validation is a diagnostic failure path, not output repair; it runs before post in renderer paths and before each arm's timing, and is disabled inside every timed closure after that preflight.",
                "Small31 post phase 0 is the model-spec default; its host dispatch is source-derived and not DLL-verified.",
                "Clock/power sampling is best-effort and has no hard dependency.",
            ],
            "extension_binary_error": binary_error,
        },
    )
    video.write_json(args.output / "manifest.json", manifest)
    return manifest


def _benchmark_arm(torch, pipeline: video.FramePipeline, frame_path: Path,
                   frames: list[Path], args, *, decoded=None) -> dict:
    """Validate one arm's identities, then measure three separate scopes."""
    frame_rgba = decoded if decoded is not None else video.load_frame_rgba(
        frame_path, expected_width=pipeline.layout.valid_width,
        expected_height=pipeline.layout.valid_height)
    validation_dir = args.output / "benchmark" / "validation"
    validation_dir.mkdir(parents=True, exist_ok=True)
    validation_began = time.perf_counter()

    def once():
        pipeline.run(frame_rgba)
        torch.cuda.synchronize()
        return np.ascontiguousarray(pipeline.valid_rgba().cpu().numpy())

    first = once()
    second = once()
    stats = video.validate_rgba_output(first)
    first_sha = video.sha256_array(first)
    second_sha = video.sha256_array(second)
    if first_sha != second_sha:
        raise RuntimeError(
            f"{pipeline.model}/{pipeline.precision}: two stateless replays differ; "
            "refusing to time a non-deterministic pipeline")
    if not pipeline.plan.guards_intact():
        raise RuntimeError(
            f"{pipeline.model}/{pipeline.precision}: native plan guards are not intact")
    validation_png = validation_dir / f"{pipeline.model}_{pipeline.precision}.png"
    video.save_rgb_png(video.rgb_to_uint8(first[..., :3]), validation_png)
    validation_seconds = time.perf_counter() - validation_began

    # Trunk-only: one real preprocess call fills the pooled field, then the
    # prepared RGB sequence (every plan call, final phase-3 C32 output view)
    # runs alone on the precomputed device input.  Validation is disabled here
    # only after the validating preflight above; the typed host read stays out
    # of the timed interval.
    pipeline.run(frame_rgba)
    torch.cuda.synchronize()
    trunk_samples = video.timed_cuda(
        lambda: pipeline.run_trunk(validate=False),
        warmup=args.warmup, iterations=args.iterations)
    trunk = video.summarize_timings(
        trunk_samples, scope="trunk_only_b69_plane16_on_precomputed_pooled",
        warmup=args.warmup)

    # Full GPU: pre + RGB trunk + post on the current stream.  The native
    # frontends recopy their CUDA textures/surfaces each launch, so these D2D
    # copies are included.  Typed low-state validation was completed in the
    # preflight and is disabled in this timed closure.  No H2D/D2H and no encoder.
    full_samples = video.timed_cuda(
        lambda: pipeline.run(None, validate=False),
        warmup=args.warmup, iterations=args.iterations)
    full = video.summarize_timings(
        full_samples, scope="full_gpu_pre_trunk_post_with_d2d_copies", warmup=args.warmup)

    # CPU wall: H2D + full GPU + synchronize + valid RGB D2H.  For a still the
    # decoded frame is reused; no per-iteration decode is hidden in the wall and
    # validation stays outside the timed closure.
    state = {"index": 0}

    def cpu_once():
        index = state["index"]
        state["index"] = index + 1
        if decoded is not None:
            frame = decoded
        else:
            path = frames[index % len(frames)]
            frame = video.load_frame_rgba(
                path, expected_width=pipeline.layout.valid_width,
                expected_height=pipeline.layout.valid_height)
        pipeline.run(frame, validate=False)
        torch.cuda.synchronize()
        pipeline.download_rgb()

    cpu_scope = (
        "cpu_wall_same_frame_replay_h2d_fullgpu_d2h_no_decode_no_encode"
        if decoded is not None else
        "cpu_wall_decode_convert_h2d_fullgpu_d2h_no_encode")
    cpu_samples = video.timed_cpu(
        cpu_once, warmup=args.warmup, iterations=args.iterations)
    cpu = video.summarize_timings(
        cpu_samples, scope=cpu_scope, warmup=args.warmup)
    if not pipeline.plan.guards_intact():
        raise RuntimeError(
            f"{pipeline.model}/{pipeline.precision}: guards failed after timing")

    return {
        "model": pipeline.model,
        "precision": pipeline.precision,
        "pipeline": pipeline.describe(),
        "source_frame": str(frame_path),
        "source_frame_sha256": video.sha256_file(frame_path),
        "same_frame_replay": decoded is not None,
        "validation": {
            "deterministic": True,
            "float32_sha256": first_sha,
            "png": str(validation_png),
            "png_sha256": video.sha256_file(validation_png),
            "output": stats,
        },
        "preparation_seconds": {
            "pipeline_prepare": pipeline.prepare_seconds,
            "validation_and_guards": validation_seconds,
        },
        "validation_timing": {
            "preflight": "typed packed-low validation enabled before every timed scope",
            "timed_closures": "typed packed-low validation disabled after preflight",
            "graph_capture": "requires validation=False after a successful preflight",
            "scope": "FP16 Half / FP8 E4M3 non-finite check; diagnostic failure, not output repair",
        },
        "measurements": {"trunk_only": trunk, "full_gpu": full, "cpu_wall": cpu},
        "guards_intact_after_timing": True,
        "cpu_wall_frame_order": (
            "one already-decoded still replayed for every arm"
            if decoded is not None else
            "same frame list for every arm, cycling from index 0"),
    }


def run_benchmark(args) -> dict:
    import torch

    if getattr(args, "video_roi", None) is not None:
        raise SystemExit(
            "--video-roi writes a render-only comparison artifact; use --mode render")
    if not torch.cuda.is_available():
        raise SystemExit("benchmark requires a CUDA device (this step only runs CPU checks)")
    torch.cuda.set_device(args.device)
    capability = tuple(torch.cuda.get_device_capability(args.device))
    if capability != (12, 0):
        raise SystemExit(
            f"benchmark requires SM120, found sm_{capability[0]}{capability[1]}; "
            "the four-arm native comparison is pinned to the published SM120 lease")
    if args.warmup < 10 or args.iterations < 50:
        raise SystemExit("benchmark requires --warmup>=10 and --iterations>=50")
    if not 0 <= args.seed <= 0xFFFFFFFF:
        raise SystemExit("--seed must be a uint32")
    for path, role in ((args.legacy_fp16_checkpoint, "legacy FP16 checkpoint"),
                       (args.legacy_fp8_checkpoint, "legacy FP8 checkpoint")):
        _require_file(path, role)
    _require_dir(args.small_archive, "Small31 archive")
    source_metadata = _source_metadata(args)
    frame_dir, paths = resolve_frame_directory(args)
    width, height = frame_header(paths, source_metadata)
    _check_full_frame_set(paths, source_metadata, args)
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output / "benchmark").mkdir(parents=True, exist_ok=True)

    environment_before = video.gpu_environment(args.device)
    clocks_before = video.nvidia_smi_snapshot()

    loaded = {}
    load_seconds = {}
    for precision, path in (("fp16", args.legacy_fp16_checkpoint),
                            ("fp8", args.legacy_fp8_checkpoint)):
        began = time.perf_counter()
        loaded[("legacy71", precision)] = _load_legacy(path, args)
        load_seconds[("legacy71", precision)] = time.perf_counter() - began
    began = time.perf_counter()
    small = _load_small(args)
    load_seconds[("small31", None)] = time.perf_counter() - began

    # Load and prepare all four native arms before timing any of them.  A
    # missing Small31 op aborts here instead of after a partial benchmark.
    prepared = {}
    construct_seconds = {}
    for precision in ("fp16", "fp8"):
        for model in ("legacy71", "small31"):
            weights = small if model == "small31" else loaded[(model, precision)]
            began = time.perf_counter()
            prepared[(model, precision)] = _build_pipeline(
                model, precision, weights, width, height, args)
            construct_seconds[(model, precision)] = time.perf_counter() - began

    arms = {}
    model_docs = []
    for (model, precision), pipeline in prepared.items():
        weights = small if model == "small31" else loaded[(model, precision)]
        arm = _benchmark_arm(torch, pipeline, paths[0], paths, args)
        arm["preparation_seconds"]["model_load"] = load_seconds[
            (model, precision) if model == "legacy71" else (model, None)]
        arm["preparation_seconds"]["pipeline_construct"] = construct_seconds[(model, precision)]
        if model == "legacy71":
            arm["weights"] = {
                "path": str(args.legacy_fp16_checkpoint if precision == "fp16"
                            else args.legacy_fp8_checkpoint),
                "sha256": video.sha256_file(
                    args.legacy_fp16_checkpoint if precision == "fp16"
                    else args.legacy_fp8_checkpoint),
                "checkpoint_precision": weights.precision,
            }
        else:
            arm["weights"] = {
                "archive": str(args.small_archive),
                "manifest_sha256": getattr(small, "manifest_sha256", None),
                "dll_sha256": getattr(small, "dll_sha256", None),
                "resource_sha256": getattr(small.archive, "resource_sha256", None),
                "checkpoint_precision": getattr(small, "precision", "fp8"),
            }
        arms[f"{model}/{precision}"] = arm
        model_docs.append(pipeline.describe())

    binary, binary_sha, binary_error = _extension_identity(args.device)

    clocks_after = video.nvidia_smi_snapshot()
    manifest = video.manifest_document(
        mode="benchmark",
        command=sys.argv,
        environment={
            **environment_before,
            "python": sys.version.split()[0],
            "extension_binary": binary,
            "extension_sha256": binary_sha,
            "clock_power_before": clocks_before,
            "clock_power_after": clocks_after,
        },
        models=model_docs,
        frame_source=frame_source_document(
            frame_dir, paths, width, height, args.fps, source_metadata),
        methodology={
            "device_requirement": "SM120 (12.0) explicit check; the four arms are pinned to that lease",
            "arms": "legacy71/fp16, legacy71/fp8, small31/fp16, small31/fp8",
            "shared": "same valid geometry, same source frame for GPU scopes, same fixed noise seed for both models",
            "stateless": "empty history/motion/depth/conditioning/blend for every measured frame",
            "trunk_only": (
                "prepared RGB trunk sequence (185 legacy / 109 Small logical calls; "
                "all plan descriptors reused except the final phase-3 C32 output view) "
                "on precomputed real pooled input; b69 is plane16, NOT a video FPS. "
                "plan.run_* remains a separate tile4 diagnostic and is not timed"),
            "full_gpu": "preprocess + RGB plane16 trunk + postprocess on the current stream, including native per-launch texture/surface D2D copies; excludes H2D/D2H and encoder",
            "validation": "typed packed-low FP16 Half / FP8 E4M3 non-finite check runs before post in renderer paths and in each arm's preflight; every timed closure disables it after that preflight; CUDA graph capture requires it disabled",
            "cpu_wall": "host wall from RGB PNG decode/convert through upload, full GPU, synchronize and valid RGB D2H; encoder excluded",
            "timing": "CUDA events with end.synchronize() per interval; CPU perf_counter across explicit synchronize boundaries",
            "warmup": args.warmup,
            "iterations": args.iterations,
            "statistics": "median/p10/p90/mean/min/max plus FPS derived from the median within each scope",
            "allocation": "plan, records, records packing, frontends, the RGB sequence and buffers are prepared outside every timed loop; no repack kernel or second field",
            "before_timing": "two validating replays hashed equal, finite [0,1] RGB, alpha 1, typed low state finite, plan guards intact; a lossless validation PNG is written",
            "guards": "plan.guards_intact() checked before and after every timed arm",
        },
        source_metadata=source_metadata,
        extra={
            "arms": arms,
            "benchmark_support_limits": [
                "These are reconstructed native host timings, not an original NGX/DLSS benchmark.",
                "No vendor parity, quality score or close-to-original claim is made.",
                "The CPU wall scope includes decode/convert/H2D/D2H; the GPU scopes exclude them.",
                "The frontend's hidden D2D texture/surface copies are included in full GPU and excluded from trunk-only.",
                "trunk_only is the prepared RGB plane16 sequence (final phase-3 C32 output view); the untouched plan.run_* tile4 layout is a separate diagnostic and is never the timed path.",
                "Typed packed-low validation is a diagnostic failure path, not output repair; it runs before post in renderer paths and before each arm's timing, and is disabled inside every timed closure after that preflight.",
                "Small31 post phase 0 is the model-spec default; its host dispatch is source-derived and not DLL-verified.",
                "Clock/power sampling is best-effort and has no hard dependency.",
            ],
            "extension_binary_error": binary_error,
        },
    )
    video.write_json(args.output / "manifest.json", manifest)
    return manifest


def main(argv=None) -> int:
    args = build_parser().parse_args(argv)
    kind, source = resolve_source(args)
    try:
        if kind == "still":
            if args.mode == "render":
                manifest = run_still_render(args, source)
            else:
                manifest = run_still_benchmark(args, source)
        elif args.mode == "render":
            manifest = run_render(args)
        else:
            manifest = run_benchmark(args)
    except (ValueError, RuntimeError, OSError) as error:
        print(f"error: {error}", file=sys.stderr)
        if args.mode == "benchmark":
            traceback.print_exc()
        return 1
    print(json.dumps({
        "mode": manifest["mode"],
        "source": kind,
        "output": str(args.output),
        "manifest": str(args.output / "manifest.json"),
        "models": [{"model": item["model"], "precision": item["precision"]}
                   for item in manifest["models"]],
    }, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
