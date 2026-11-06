"""Resolve the documentation output root independently of the source tree.

The default production output remains ``docs/kernel-guide``.  A caller may
override it with ``--output`` or ``DLSSNR_DOCS_OUTPUT``; this is how a temporary
validation site is generated without touching public documentation.  Existing
templates, measurements and public evidence remain inputs rooted at the
repository.
"""
from __future__ import annotations

import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = (ROOT / "docs" / "kernel-guide").resolve()
ENVIRONMENT_VARIABLE = "DLSSNR_DOCS_OUTPUT"

_CONFIGURED: Path | None = None


def resolve_output_root(argument=None) -> Path:
    """Return the explicit, environment or default output root as absolute."""
    value = argument if argument is not None else os.environ.get(ENVIRONMENT_VARIABLE)
    path = Path(value) if value not in (None, "") else DEFAULT_OUTPUT
    return path.expanduser().resolve()


def configure_output_root(argument=None) -> Path:
    """Configure and return the process output root."""
    global _CONFIGURED
    _CONFIGURED = resolve_output_root(argument)
    return _CONFIGURED


def output_root() -> Path:
    """Return the configured output root, defaulting to the production guide."""
    return _CONFIGURED if _CONFIGURED is not None else DEFAULT_OUTPUT


def repository_guide_root() -> Path:
    """Return the tracked repository guide used as an input/evidence root."""
    return DEFAULT_OUTPUT
