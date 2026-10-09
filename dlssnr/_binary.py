"""Locate an installed deployment library; kernel selection remains in C++."""
from importlib.util import find_spec
from pathlib import Path
import re


def compatible_targets(device_sm, installed):
    """Native cubins are forward-compatible within one major compute capability."""
    return sorted((sm for sm in installed if sm // 10 == device_sm // 10 and sm <= device_sm), reverse=True)


def extension_path(device=None):
    import torch
    if not torch.cuda.is_available():
        raise RuntimeError("CUDA deployment requires a CUDA device; training does not load this extension")
    major, minor = torch.cuda.get_device_capability(device)
    device_sm = major * 10 + minor
    installed = set()
    for path in Path(__file__).parent.glob('_C_sm*'):
        match = re.match(r'_C_sm(\d+)\.', path.name)
        if match:
            installed.add(int(match[1]))
    # Never select an SM80/86 image for FP8-capable Ada, which is the same major
    # architecture but requires a body compiled with the FP8 instruction set.
    if device_sm >= 89:
        installed = {sm for sm in installed if sm >= 89}
    candidates = [f'dlssnr._C_sm{sm}' for sm in compatible_targets(device_sm, installed)]
    # The legacy name now denotes a fat library. An exact split build takes
    # precedence over a stale _C from an earlier checkout/build configuration.
    candidates.append('dlssnr._C')
    for module in candidates:
        spec = find_spec(module)
        if spec is not None and spec.origin:
            return str(Path(spec.origin).resolve(strict=True))
    raise RuntimeError(
        f"No deployment binary for SM{device_sm}. Set TORCH_CUDA_ARCH_LIST='{major}.{minor}' "
        "and run python setup.py build_ext --inplace. Use DLSSNR_BUILD_MODE=fat for mixed GPUs.")
