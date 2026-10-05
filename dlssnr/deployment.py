"""Thin entry points for the reconstructed C++ deployment plan.

Kernel choice, argument packing, layout and buffer scheduling live in C++.
Keep the returned plan alive until every CUDA graph using it is reset.
"""
from importlib.util import find_spec
from pathlib import Path
from threading import RLock

_loaded = None
_lock = RLock()

def load_extension(path=None):
    import torch
    global _loaded
    with _lock:
        if path is None and _loaded is not None:
            return torch.ops.dlssnr
        if path is None:
            spec = find_spec('dlssnr._C')
            if spec is None:
                raise RuntimeError('Build the CUDA extension with python setup.py build_ext --inplace')
            path = spec.origin
        resolved = str(Path(path).resolve(strict=True))
        if _loaded is not None and _loaded != resolved:
            raise RuntimeError('A different DLSSNR extension is already loaded in this process')
        if _loaded is None:
            torch.ops.load_library(resolved)
            _loaded = resolved
    return torch.ops.dlssnr

def create_plan_fp8(state, records, *, width=3840, height=2160):
    """Prepare the admitted physical FP8 trunk outside CUDA graph capture."""
    return load_extension().create_plan_for_resolution_fp8(state, records, width, height)

def inference_forward_fp8(plan):
    """Run an already prepared plan on the current PyTorch CUDA stream."""
    return plan.run_fp8()


def create_plan_fp16(state, records, *, width=3840, height=2160):
    """Prepare physical Half buffers outside CUDA graph capture."""
    return load_extension().create_plan_for_resolution_fp16(state, records, width, height)


def inference_forward_fp16(plan):
    """Run the prepared Half plan on the current PyTorch CUDA stream."""
    return plan.run_fp16()
