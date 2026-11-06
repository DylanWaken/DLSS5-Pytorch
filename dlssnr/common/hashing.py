"""Generic SHA-256 helpers shared by runtime layers.

This module owns the byte/file/array digest loops.  Normalized-source and
provenance digest *algorithms* (source manifests, plan-table pins, archive
schema digests) remain with their own owners; they use these primitives and keep
their independent expected values.
"""
from __future__ import annotations

import hashlib


def sha256_bytes(data) -> str:
    """SHA-256 of a bytes-like object."""
    return hashlib.sha256(bytes(data)).hexdigest()


def sha256_array(array) -> str:
    """SHA-256 of a contiguous array's raw bytes."""
    import numpy as np

    return sha256_bytes(np.ascontiguousarray(array).tobytes())


def sha256_file(path, chunk=1 << 20) -> str:
    """Stream a file through SHA-256 without loading it whole."""
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for block in iter(lambda: handle.read(chunk), b""):
            digest.update(block)
    return digest.hexdigest()


__all__ = ["sha256_array", "sha256_bytes", "sha256_file"]
