"""Canonical native deployment precision names and element-byte metadata.

Importing this module must stay free of Torch, CUDA, NumPy and native-extension
imports: the generators and ordinary package metadata consumers use it.  It only
names the two supported native storage precisions and validates a caller's
request; native/device architecture admission remains a build-owner concern.
"""
from __future__ import annotations

NATIVE_PRECISIONS = ("fp8", "fp16")

#: Stored bytes per native element.  This is storage width, not a compute dtype.
ELEMENT_BYTES = {"fp8": 1, "fp16": 2}


def resolve_precision(precision, *, error_message: str | None = None) -> str:
    """Return one of :data:`NATIVE_PRECISIONS` or raise ``ValueError``.

    Callers with a long-standing public message pass ``error_message`` so the
    one validation implementation keeps that contract.
    """
    if not isinstance(precision, str) or precision not in NATIVE_PRECISIONS:
        raise ValueError(error_message or (
            f"unsupported precision {precision!r}; expected one of {NATIVE_PRECISIONS}"))
    return precision


def element_bytes(precision: str) -> int:
    """Return native storage bytes per element for a validated precision."""
    return ELEMENT_BYTES[resolve_precision(precision)]


__all__ = ["ELEMENT_BYTES", "NATIVE_PRECISIONS", "element_bytes", "resolve_precision"]
