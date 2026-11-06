"""Provenance, source metadata and manifests.

The generic byte/file/array SHA-256 helpers are re-exported from
:mod:`dlssnr.common.hashing`; provenance keeps its own manifest/source-metadata
algorithms and plan-table pins so expected values stay independent.
"""
from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Sequence

from ..common.hashing import sha256_array, sha256_bytes, sha256_file


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat()


def plan_table_hashes(repository_root=None) -> dict:
    root = Path(repository_root) if repository_root else Path(__file__).resolve().parents[2]
    names = (
        "plan_generated.inl", "plan_fp16_generated.inl",
        "plan_geometry_generated.inl", "plan_geometry_fp16_generated.inl",
        "small_plan_generated.inl", "small_plan_fp16_generated.inl",
        "small_plan_geometry_generated.inl", "small_plan_geometry_fp16_generated.inl",
    )
    result = {}
    for name in names:
        path = root / "csrc/kernel_launcher" / name
        result[name] = sha256_file(path) if path.is_file() else None
    return result


def _first_present(container: dict, *keys):
    for key in keys:
        value = container.get(key)
        if value is not None:
            return value
    return None


def load_source_metadata(path=None, *, input_path=None) -> dict:
    """Read optional generic source metadata; never invent credits or a license.

    ``path`` is an explicit metadata JSON file.  When it is omitted and
    ``input_path`` is given, a sibling ``source.json`` is used if present.
    Two supplied schemas are preserved:

    * a flat ``{"source": {...}}`` document (legacy media step), whose known
      fields are surfaced directly;
    * an official nested document (``official_sources``, ``rights``, ``image``,
      ``clip``, ...), whose sections are copied verbatim.

    In both cases the whole supplied document is retained under ``"document"``.
    A missing document is reported as unavailable; no license, endorsement or
    attribution is made up.
    """
    candidate = Path(path) if path is not None else None
    if candidate is None and input_path is not None:
        candidate = Path(input_path).with_name("source.json")
    if candidate is None or not candidate.is_file():
        return {
            "path": str(candidate) if candidate is not None else None,
            "available": False,
            "notice": (
                "No source metadata supplied. Pass --source-metadata to record "
                "credits, copyright, license and a source URL; nothing is inferred."),
        }
    data = json.loads(candidate.read_text(encoding="utf-8"))
    attribution = {
        "path": str(candidate),
        "available": True,
        "sha256": sha256_file(candidate),
        "document": data,
    }
    source = data.get("source")
    field_map = {
        "title": ("title",),
        "artist": ("artist", "creator", "author"),
        "copyright": ("copyright", "copyright_notice"),
        "license": ("license",),
        "license_url": ("license_url",),
        "page_url": ("page_url",),
        "page_revision_url": ("page_revision_url",),
        "source_url": ("source_url", "original_media_url"),
        "credit": ("credit",),
        "attribution_line": ("attribution_line",),
        "derivative_notice": ("derivative_notice",),
    }
    if isinstance(source, dict):
        for output_key, keys in field_map.items():
            value = _first_present(source, *keys)
            if value is not None:
                attribution[output_key] = value
    else:
        # Official nested schema: keep every supplied section byte-exact rather
        # than flattening it into assumed flat keys.
        for key, value in data.items():
            attribution.setdefault(key, value)
        # Only surface convenience keys that actually exist at top level.
        for output_key, keys in field_map.items():
            value = _first_present(data, *keys)
            if value is not None:
                attribution[output_key] = value
    excerpt = data.get("excerpt")
    rgb_frames = excerpt.get("rgb_frames") if isinstance(excerpt, dict) else None
    if isinstance(rgb_frames, dict):
        attribution["excerpt_rgb_frames"] = {
            "count": rgb_frames.get("count"),
            "width": rgb_frames.get("width"),
            "height": rgb_frames.get("height"),
            "pattern": rgb_frames.get("pattern"),
        }
    still = data.get("still")
    if isinstance(still, dict):
        attribution["still_metadata"] = dict(still)
    canonical_frames = data.get("canonical_frames")
    if isinstance(canonical_frames, dict):
        # Flat video source schema: preserve the section verbatim so frame
        # geometry/count checks use the supplied values, never guessed ones.
        attribution["canonical_frames"] = dict(canonical_frames)
    return attribution


def manifest_document(*, mode: str, command, environment: dict, models: Sequence[dict],
                      frame_source: dict, methodology: dict, source_metadata: dict,
                      extra: dict | None = None) -> dict:
    """Assemble the machine-readable harness manifest."""
    argv = [str(value) for value in command]
    document = {
        "schema": "dlssnr.video-harness.v1",
        "created_utc": utc_now(),
        "mode": mode,
        "command": argv,
        "environment": environment,
        "models": list(models),
        "frame_source": frame_source,
        "attribution": source_metadata,
        "methodology": methodology,
        "support_limits": [
            "RGB-only stateless mode: history, motion, depth, conditioning and blend are empty for every frame; the native preprocess copies current colour into its history feature lanes.",
            "No motion, depth or conditioning G-buffer is reconstructed; the constant conditioning and fixed session noise are neutral defaults, not renderer inputs.",
            "No temporal, zero-motion quality or optical-flow mode is implemented or claimed.",
            "Original is the decoded source frame, not an NVIDIA DLL/vendor reference.",
            "No vendor parity, no image-quality score and no claim that either model is closer to the original.",
            "Small31 post phase 0 is the model-spec default; its host dispatch is source-derived and not verified against DLL host descriptors.",
            "The benchmark measures this reconstructed native host, not an original NGX/DLSS execution.",
            "Media is published only from the approved profile output; third-party media is not redistributed by this harness.",
            "No license, endorsement, copyright or source URL is inferred; only values supplied to --source-metadata are recorded.",
            "A still-image run is a single decoded frame, not a video; it never encodes or publishes an MP4.",
        ],
        "reproduction": {
            "argv": argv,
            "cwd": str(Path(__file__).resolve().parents[2]),
            "render": (
                "Re-run the exact 'argv' list above with --mode render; for a "
                "single still this writes PNGs only and never invokes ffmpeg."),
            "benchmark": (
                "Re-run the exact 'argv' list above with --mode benchmark on the "
                "SM120 lease; a still benchmark replays the same decoded frame."),
            "source_of_truth": "argv (no shell command is stored or reconstructed)",
        },
        "plan_tables": plan_table_hashes(),
    }
    if extra:
        document.update(extra)
    return document


def write_json(path, document) -> Path:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(document, indent=2, sort_keys=False), encoding="utf-8")
    return path
