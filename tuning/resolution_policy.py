"""Compatibility facade for :mod:`dlssnr.build.resolution`.

The canonical policy validation and C++ code generation live in
``dlssnr.build.resolution``. This module remains loadable directly by file path
for CPU tests and exports the same objects by identity.
"""
try:
    from dlssnr.build.resolution import (
        BOUNDS,
        CPP,
        DISTANCE,
        PRECISIONS,
        RESOLVER_VERSION,
        canonical,
        combine,
        cpp_header,
        digest,
        integer,
        key,
        lookup,
        require,
        validate,
        verify_receipts,
        version,
    )
except ModuleNotFoundError as error:
    if not (error.name or "").startswith("dlssnr"):
        raise
    import sys
    from pathlib import Path

    _ROOT = str(Path(__file__).resolve().parents[1])
    if _ROOT not in sys.path:
        sys.path.insert(0, _ROOT)
    from dlssnr.build.resolution import (
        BOUNDS,
        CPP,
        DISTANCE,
        PRECISIONS,
        RESOLVER_VERSION,
        canonical,
        combine,
        cpp_header,
        digest,
        integer,
        key,
        lookup,
        require,
        validate,
        verify_receipts,
        version,
    )

__all__ = [
    "BOUNDS", "DISTANCE", "PRECISIONS", "RESOLVER_VERSION", "CPP",
    "canonical", "require", "integer", "digest", "key", "validate", "combine",
    "verify_receipts", "version", "lookup", "cpp_header",
]
