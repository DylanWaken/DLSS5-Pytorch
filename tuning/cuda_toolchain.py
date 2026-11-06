"""Compatibility facade for :mod:`dlssnr.build.toolchain`.

The canonical implementation lives in ``dlssnr.build.toolchain``; this module
re-exports the same objects, including the private digest helper some callers
may still reference.
"""
try:
    from dlssnr.build.toolchain import (
        CudaAssemblerSelection,
        _sha256,
        prepare_cuda_assembler,
    )
except ModuleNotFoundError as error:
    if not (error.name or "").startswith("dlssnr"):
        raise
    import sys
    from pathlib import Path

    _ROOT = str(Path(__file__).resolve().parents[1])
    if _ROOT not in sys.path:
        sys.path.insert(0, _ROOT)
    from dlssnr.build.toolchain import (
        CudaAssemblerSelection,
        _sha256,
        prepare_cuda_assembler,
    )

__all__ = ["CudaAssemblerSelection", "prepare_cuda_assembler"]
