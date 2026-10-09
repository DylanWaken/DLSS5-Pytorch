"""Architecture targets for registration-only CUDA deployment libraries.

This module does not import Torch or initialize CUDA, so packaging and CPU
tests can inspect a requested build on machines without a GPU.
"""
from dataclasses import dataclass
import re


@dataclass(frozen=True)
class CudaTarget:
    sm: int
    ptx: bool = False

    @property
    def torch_name(self):
        return f"{self.sm // 10}.{self.sm % 10}" + ("+PTX" if self.ptx else "")

    @property
    def nvcc_flags(self):
        flags = [f"-gencode=arch=compute_{self.sm},code=sm_{self.sm}"]
        if self.ptx:
            flags.append(f"-gencode=arch=compute_{self.sm},code=compute_{self.sm}")
        return flags


def parse_targets(value):
    """Accept explicit TORCH_CUDA_ARCH_LIST numbers; never silently drop a target."""
    tokens = re.split(r"[;\s]+", value.strip())
    if not value.strip():
        raise ValueError("TORCH_CUDA_ARCH_LIST must contain explicit targets, e.g. 8.0;8.6;8.9;12.0")
    targets = {}
    for token in tokens:
        match = re.fullmatch(r"(\d+)\.(\d)(\+PTX)?", token)
        if not match:
            raise ValueError(f"Invalid CUDA target {token!r}; use numeric targets such as 8.6 or 8.9+PTX")
        sm = int(match[1]) * 10 + int(match[2])
        if sm < 80:
            raise ValueError(f"SM{sm} is unsupported: deployment FP16 requires SM80+, FP8 requires SM89+")
        targets[sm] = CudaTarget(sm, bool(match[3]) or (sm in targets and targets[sm].ptx))
    return tuple(targets[sm] for sm in sorted(targets))


def library_targets(targets, mode="split"):
    """Split libraries have independent object trees; fat mode supports mixed GPUs."""
    if mode == "split":
        return [(f"dlssnr._C_sm{target.sm}", (target,)) for target in targets]
    if mode == "fat":
        return [("dlssnr._C", tuple(targets))]
    raise ValueError("DLSSNR_BUILD_MODE must be 'split' (one library per SM) or 'fat' (one multi-SM library)")
