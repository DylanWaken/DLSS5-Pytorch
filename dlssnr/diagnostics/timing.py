"""Timing statistics and CUDA/CPU measurement intervals."""
from __future__ import annotations

import time
from typing import Sequence

import numpy as np
import torch


def summarize_timings(samples_ms: Sequence[float], *, scope: str, warmup: int = 0) -> dict:
    """Return honest per-scope statistics; never merge GPU and CPU intervals."""
    values = np.asarray(list(samples_ms), dtype=np.float64)
    if values.size == 0:
        raise ValueError("no timing samples")
    if not np.isfinite(values).all() or (values < 0).any():
        raise ValueError("timing samples must be finite and non-negative")
    median = float(np.median(values))
    p10, p90 = (float(value) for value in np.percentile(values, (10, 90)))
    return {
        "scope": scope,
        "unit": "ms",
        "warmup": int(warmup),
        "iterations": int(values.size),
        "median_ms": median,
        "p10_ms": p10,
        "p90_ms": p90,
        "mean_ms": float(values.mean()),
        "min_ms": float(values.min()),
        "max_ms": float(values.max()),
        "fps_from_median": (1000.0 / median) if median > 0 else None,
        "samples_ms": [float(value) for value in values],
    }


def timed_cuda(fn, *, warmup: int, iterations: int, stream=None) -> list[float]:
    """Measure ``fn`` with CUDA events, one synchronized interval per call."""
    if warmup < 10 or iterations < 50:
        raise ValueError("benchmark protocol requires warmup>=10 and iterations>=50")
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()
    samples = []
    for _ in range(iterations):
        begin = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)
        begin.record(stream)
        fn()
        end.record(stream)
        end.synchronize()
        samples.append(float(begin.elapsed_time(end)))
    return samples


def timed_cpu(fn, *, warmup: int, iterations: int) -> list[float]:
    """Measure a synchronous host interval (all GPU boundaries synchronized)."""
    if warmup < 10 or iterations < 50:
        raise ValueError("benchmark protocol requires warmup>=10 and iterations>=50")
    for _ in range(warmup):
        fn()
    samples = []
    for _ in range(iterations):
        torch.cuda.synchronize()
        began = time.perf_counter()
        fn()
        torch.cuda.synchronize()
        samples.append((time.perf_counter() - began) * 1000.0)
    return samples
