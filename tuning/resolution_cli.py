"""Compatibility facade for :mod:`dlssnr.build.cli`.

The canonical CPU-only resolution CLI lives in ``dlssnr.build.cli``. This module
keeps script-mode execution and direct-file loading working, and re-exports the
same functions and source-tree defaults (``tuning/sm_*.json`` policy files and
``dlssnr/geometry.py``).
"""
from __future__ import annotations

if __package__ in (None, ""):
    import sys
    from pathlib import Path

    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

try:
    from dlssnr.build import resolution as P
    from dlssnr.build.cli import (
        GEOMETRY,
        HERE,
        axis_runs,
        enumerate_plan,
        load_geometry,
        main,
        policy_files,
        read,
        resume_plan,
        write,
    )
except ModuleNotFoundError as error:
    if not (error.name or "").startswith("dlssnr"):
        raise
    import sys
    from pathlib import Path

    _ROOT = str(Path(__file__).resolve().parents[1])
    if _ROOT not in sys.path:
        sys.path.insert(0, _ROOT)
    from dlssnr.build import resolution as P
    from dlssnr.build.cli import (
        GEOMETRY,
        HERE,
        axis_runs,
        enumerate_plan,
        load_geometry,
        main,
        policy_files,
        read,
        resume_plan,
        write,
    )

__all__ = [
    "HERE", "GEOMETRY", "P", "read", "write", "policy_files", "load_geometry",
    "axis_runs", "enumerate_plan", "resume_plan", "main",
]

if __name__ == "__main__":
    main()
