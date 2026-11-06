"""Compatibility facade for :mod:`dlssnr.build.targets`.

The canonical implementation lives in ``dlssnr.build.targets``. This module
binds those same objects rather than copying code so callers that import the
historical tuning name keep coherent identities and monkeypatches.
"""
try:
    from dlssnr.build.targets import CudaTarget, library_targets, parse_targets
except ModuleNotFoundError as error:
    if not (error.name or "").startswith("dlssnr"):
        raise
    # Direct-file loading (for example by a CPU test) may not have the source
    # root on sys.path yet. Bootstrap only this compatibility import.
    import sys
    from pathlib import Path

    _ROOT = str(Path(__file__).resolve().parents[1])
    if _ROOT not in sys.path:
        sys.path.insert(0, _ROOT)
    from dlssnr.build.targets import CudaTarget, library_targets, parse_targets

__all__ = ["CudaTarget", "parse_targets", "library_targets"]
