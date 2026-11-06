"""Best-effort runtime environment and clock snapshots."""
from __future__ import annotations

import subprocess

import torch


def gpu_environment(device=0) -> dict:
    info = {
        "torch": torch.__version__,
        "torch_cuda": torch.version.cuda,
        "cuda_available": bool(torch.cuda.is_available()),
        "device_index": int(device),
    }
    if not torch.cuda.is_available():
        return info
    capability = torch.cuda.get_device_capability(device)
    info.update({
        "device_name": torch.cuda.get_device_name(device),
        "capability": f"sm_{capability[0]}{capability[1]}",
        "capability_tuple": [int(capability[0]), int(capability[1])],
        "total_memory_bytes": int(torch.cuda.get_device_properties(device).total_memory),
        "cuda_runtime": torch.version.cuda,
    })
    return info


def nvidia_smi_snapshot() -> dict:
    """Best-effort clock/power snapshot; absence is not an error."""
    query = "name,clocks.sm,clocks.mem,temperature.gpu,power.draw,pstate"
    try:
        result = subprocess.run(
            ["nvidia-smi", f"--query-gpu={query}", "--format=csv,noheader,nounits"],
            check=True, capture_output=True, text=True, timeout=15)
    except (OSError, subprocess.SubprocessError) as error:
        return {"available": False, "error": type(error).__name__}
    rows = [line.strip() for line in result.stdout.splitlines() if line.strip()]
    return {"available": True, "query": query, "rows": rows}
