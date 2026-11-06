"""Compatibility CLI surface for :mod:`dlssnr.build.speed`.

The reusable implementation now lives in ``dlssnr.build.speed``. This file is a
deliberate transparent alias: importing ``tools.speed_build`` replaces itself in
``sys.modules`` with the canonical module object, preserving the historical
import path, entry point and private monkeypatch identities (``_run_build``,
``_probe_extension``, ``_build_environment`` and friends) used by CPU tests.
"""
import sys

from dlssnr.build import speed as _canonical

sys.modules[__name__] = _canonical
