"""Extract one exact DLSS-NR runtime weight model from a local original DLL.

Usage (from the repository root)::

    .venv/Scripts/python.exe tools/extract_runtime_assets.py --dll assets/original/nvngx_dlssnr.dll --model legacy71 --output D:/fresh/legacy71
    .venv/Scripts/python.exe tools/extract_runtime_assets.py --dll D:/fresh/nvngx_dlssnr_310.9.16.dll --model small31 --output D:/fresh/small31

The DLL is opened read-only and parsed statically; it is never loaded or
executed.  No network access is performed.  ``--output`` must not exist: the
archive is written to a sibling temporary directory and renamed atomically, so
existing extracted data is never overwritten.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from dlssnr.model_specs import MODEL_SPECS, resolve_model
from dlssnr.runtime_assets import AssetError, extract_model


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--dll", type=Path, required=True, help="original DLSS-NR DLL (read-only, never loaded)")
    parser.add_argument("--model", required=True, choices=tuple(sorted(MODEL_SPECS)),
                        help="exact model identity: legacy71 (WEIGHTS_HT) or small31 (WEIGHTS_CC_SMALL_FP8)")
    parser.add_argument("--output", type=Path, required=True,
                        help="new output directory; must not exist (old assets are never overwritten)")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        spec = resolve_model(args.model)
        summary = extract_model(args.dll, spec, args.output)
    except (AssetError, OSError, ValueError, TypeError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    print(json.dumps(summary, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
