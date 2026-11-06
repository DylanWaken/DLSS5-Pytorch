"""Opt-in SM120 regression for all four fused C32 preprocess entries.

Run ``python -m pytest -q tests/test_frontend_preprocess_regression.py`` with
``DLSSNR_RUN_FRONTEND_PREPROCESS=1`` after installing the default extension.
The synthetic RGBA image and real checkpoint records exercise the first adapter
MMA and the complete fused block. Full-output goldens must come from the original
reference binary, independently of the corrected candidate. SM120 goldens are pinned.

Importing this module never imports Torch, discovers CUDA, or loads an extension.
``run_preprocess_cases`` accepts an already loaded public ops namespace so the
same fixture can collect reference/candidate outputs in separate fresh processes.
"""
from __future__ import annotations

import hashlib
import os
from pathlib import Path

import pytest

OPT_IN = "DLSSNR_RUN_FRONTEND_PREPROCESS"
HEIGHT, WIDTH, SEED = 16, 32, 20261006
GUARD_BYTES, GUARD_VALUE = 256, 0xA7
CHECKPOINT_SHA256 = {
    "fp16": "1d9d2b667a61a770bc4525f40e09ce04b62b737bec88804d3150274785193d11",
    "fp8": "f950c36d699572866f54b880e615302809060b7c02364db11e71c07f8d0f9e2d",
}
# Original f0d reference observations only; never populate from candidate output.
ORIGINAL_SHA256 = {
    "input_preprocess_window_c32_fp16/full": "44f2bba9bf926d377e7a34ae78e81aee3711a8fb50fa66ac79bacf016691cf6c",
    "input_preprocess_window_downsample_c32_fp16/full": "44f2bba9bf926d377e7a34ae78e81aee3711a8fb50fa66ac79bacf016691cf6c",
    "input_preprocess_window_downsample_c32_fp16/pooled": "64f5cce4da803c52f76508b808d21c2995bbda4a315b32a122d5b01c514bc2e5",
    "input_preprocess_window_c32_fp8/full": "0e97772bc57dc02a75a1b8f3546315bee600faeb908e60322eb87f72d34450bd",
    "input_preprocess_window_downsample_c32_fp8/full": "0e97772bc57dc02a75a1b8f3546315bee600faeb908e60322eb87f72d34450bd",
    "input_preprocess_window_downsample_c32_fp8/pooled": "24894974f711b4b8013e57805f1f85b586fdb5c7fc606be936f850680d385510",
}


def rgba_fixture():
    """CPU-only dyadic gradients: every channel value is exactly representable."""
    import numpy as np
    y, x = np.indices((HEIGHT, WIDTH), dtype=np.int32)
    return np.stack((x % 16, y % 16, (x + 3 * y) % 16,
                     np.full_like(x, 16)), axis=-1).astype(np.float32) / np.float32(16)


def _file_sha256(path):
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def _guarded(torch, size, device):
    backing = torch.full((size + 2 * GUARD_BYTES,), GUARD_VALUE,
                         dtype=torch.uint8, device=device)
    view = backing[GUARD_BYTES:GUARD_BYTES + size]
    assert view.is_contiguous() and view.data_ptr() % 16 == 0
    return backing, view


def run_preprocess_cases(ops, *, checkpoint_root, device=0):
    """Execute four entries; return six hashes after real numerical/guard checks.

    The caller owns extension selection and the GPU lease. This helper neither
    loads an extension nor accepts expected hashes; it cannot bless a candidate.
    """
    import torch
    from dlssnr.checkpoint import load_checkpoint

    device = torch.device("cuda", device)
    checkpoint_root = Path(checkpoint_root)
    hashes = {}
    with torch.cuda.device(device), torch.inference_mode():
        image_backing, image_bytes = _guarded(torch, HEIGHT * WIDTH * 4 * 4, device)
        image = image_bytes.view(torch.float32).reshape(HEIGHT, WIDTH, 4)
        image.copy_(torch.from_numpy(rgba_fixture()).to(device))
        image_before = image_bytes.clone()
        empty = torch.empty(0, dtype=torch.float32, device=device)
        for precision in ("fp16", "fp8"):
            path = checkpoint_root / f"dlss5_nr_{precision}.pt"
            assert _file_sha256(path) == CHECKPOINT_SHA256[precision], "checkpoint changed"
            checkpoint = load_checkpoint(path)
            raw = checkpoint.kernel_record(0, kind="preprocess", precision=precision, device="cpu")
            record_size = 33984 if precision == "fp16" else 21696
            assert raw.dtype == torch.uint8 and tuple(raw.shape) == (record_size,)
            record_backing, record = _guarded(torch, record_size, device)
            record.copy_(raw.to(device))
            record_before = record.clone()
            dtype = torch.float16 if precision == "fp16" else torch.float8_e4m3fn
            itemsize = 2 if precision == "fp16" else 1
            for downsample in (False, True):
                name = "input_preprocess_window" + ("_downsample" if downsample else "")
                name += "_c32_" + precision
                sizes = [HEIGHT * WIDTH * 32 * itemsize]
                if downsample:
                    sizes.append(HEIGHT * WIDTH * 8 * itemsize)
                guarded = [_guarded(torch, size, device) for size in sizes]
                outputs = [view for _, view in guarded]
                inputs = [record, image, empty, empty, empty, empty]
                config = ops.frontend_configuration(name, HEIGHT, WIDTH, HEIGHT, WIDTH, 0, SEED)
                assert config.device.type == "cpu" and config.dtype == torch.uint8
                assert tuple(config.shape) == (264,)
                owner = ops.prepare_frontend(name, config, inputs, outputs, False)
                operation = getattr(ops, name).default
                first = None
                for poison in (0x6A, 0x6B):
                    for output in outputs:
                        output.fill_(poison)
                    operation(inputs, outputs, owner.id())
                    torch.cuda.synchronize(device)
                    observed = {}
                    for label, output, size in zip(("full", "pooled"), outputs, sizes):
                        assert output.numel() == size
                        assert bool(torch.isfinite(output.view(dtype).float()).all()), name
                        observed[name + "/" + label] = hashlib.sha256(
                            output.cpu().numpy().tobytes()).hexdigest()
                    for backing in [image_backing, record_backing, *(b for b, _ in guarded)]:
                        assert bool((backing[:GUARD_BYTES] == GUARD_VALUE).all()), name
                        assert bool((backing[-GUARD_BYTES:] == GUARD_VALUE).all()), name
                    assert torch.equal(image_bytes, image_before), "RGBA input mutated"
                    assert torch.equal(record, record_before), "packed record mutated"
                    if first is not None:
                        assert observed == first, "output depends on poison or replay"
                    first = observed
                hashes.update(first)
                del owner  # All work is joined before owned CUDA textures are released.
    assert set(hashes) == set(ORIGINAL_SHA256)
    return hashes


def test_fused_preprocess_four_entries():
    if os.environ.get(OPT_IN) != "1":
        pytest.skip(f"GPU regression is opt-in: set {OPT_IN}=1")
    assert all(isinstance(value, str) and len(value) == 64
               for value in ORIGINAL_SHA256.values()), "original reference goldens pending"
    import torch
    if not torch.cuda.is_available():
        pytest.skip("CUDA device unavailable")
    device = torch.cuda.current_device()
    if tuple(torch.cuda.get_device_capability(device)) != (12, 0):
        pytest.skip("these independent bitwise goldens are qualified only on SM120")
    from dlssnr.deployment import load_extension
    ops = load_extension(None, device=device)
    observed = run_preprocess_cases(ops, checkpoint_root=Path(__file__).resolve().parents[1] / "ckpts",
                                    device=device)
    assert observed == ORIGINAL_SHA256, "fused preprocess differs from original reference"
