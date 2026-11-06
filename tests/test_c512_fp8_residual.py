"""Opt-in GPU regression for the four corrected C512 FP8 residual paths.

Each record's projection matrix is zero, so the registered output is the E4M3
residual times its packed Half channel scale.  Entries 10 (attention), 4 (FFN),
14 (pooled projection) and 12 (output view) are exercised through the public
``prepare_c512_fp8`` / ``c512_out_fp8`` dispatcher at the admitted 68x120 field.

The test is opt-in and must run in a GPU-capable environment::

    .venv/Scripts/python.exe -m pytest -q tests/test_c512_fp8_residual.py

after setting ``DLSSNR_RUN_C512_FP8_RESIDUAL=1``.  Module import and the CPU
fixture never query CUDA, load the extension, or allocate device tensors.  A
missing/broken extension or operation fails; only an unavailable CUDA device or
an SM<89 native-FP8 capability is skipped, and only after explicit invocation.
"""
from __future__ import annotations

import os

import numpy as np
import pytest

OPT_IN = "DLSSNR_RUN_C512_FP8_RESIDUAL"
ENTRIES = (10, 4, 14, 12)  # attention, FFN, pooled projection, output view
HEIGHT, WIDTH, CHANNELS = 68, 120, 512
IMAGE_BYTES = HEIGHT * WIDTH * CHANNELS
POOL_HEIGHT, POOL_WIDTH = ((HEIGHT + 7) // 8) * 4, ((WIDTH + 7) // 8) * 4
POOL_BYTES = POOL_HEIGHT * POOL_WIDTH * CHANNELS
MATRIX_BYTES, SCALE_BYTES = 512 * 512, 512 * 2
RECORD_BYTES = MATRIX_BYTES + SCALE_BYTES
GUARD_BYTES, GUARD_VALUE = 4096, 0xA7
K_CYCLE = (9, 10, 11, 13, 15, 12, 16, 14)
SCALE_CYCLE = (0.5, 1.0, 2.0)
UNIT = 2.0 ** -5


def _pack(codes, offsets):
    """Scatter logical uint8 codes into an existing layout permutation."""
    flat_offsets = np.asarray(offsets).ravel()
    flat_codes = codes.reshape(-1).numpy()
    if flat_offsets.size != flat_codes.size or np.unique(flat_offsets).size != flat_codes.size:
        raise ValueError("layout is not a one-to-one map of the logical field")
    if flat_offsets.min() < 0 or flat_offsets.max() >= flat_codes.size:
        raise ValueError("layout offset outside the logical field")
    packed = np.empty(flat_codes.size, dtype=np.uint8)
    packed[flat_offsets] = flat_codes
    return packed


def _e4(torch, values):
    """Torch CPU Half -> E4M3 RNE codes, as the kernel publishes them."""
    return values.to(torch.float8_e4m3fn).view(torch.uint8)


def _fixture():
    """CPU-only golden; never queries CUDA or loads the extension."""
    import torch
    from tools.native_reference.vendor_downsample_probe import down_offsets
    from tools.native_reference.vendor_window_benchmark import image_offsets

    y, x, c = torch.meshgrid(torch.arange(HEIGHT, device="cpu"),
                             torch.arange(WIDTH, device="cpu"),
                             torch.arange(CHANNELS, device="cpu"), indexing="ij")
    cycle = torch.tensor(K_CYCLE, dtype=torch.float16, device="cpu")
    index = y + 2 * x + 5 * c + c // 16
    residual_values = cycle[index % 8] * torch.tensor(UNIT, dtype=torch.float16, device="cpu")
    state_values = cycle[(index + 3) % 8] * torch.tensor(UNIT, dtype=torch.float16, device="cpu")
    scales = torch.tensor(SCALE_CYCLE, dtype=torch.float16, device="cpu")[c % 3]
    products = residual_values * scales

    tile_offsets = np.asarray(image_offsets(HEIGHT, WIDTH, CHANNELS), dtype=np.int64)
    plane_offsets = np.asarray(down_offsets(HEIGHT, WIDTH, CHANNELS), dtype=np.int64)
    pool_offsets = np.asarray(image_offsets(POOL_HEIGHT, POOL_WIDTH, CHANNELS), dtype=np.int64)

    # Native tree: HalfMul(HalfAdd(HalfAdd(TL,TR),HalfAdd(BL,BR)),0.25), then
    # one E4 publication.  Products are positive multiples of 2**-6; every
    # partial sum is below 4 and the quarter below 1, so all three Half adds
    # and the quarter multiply are exact.
    block = products.reshape(HEIGHT // 2, 2, WIDTH // 2, 2, CHANNELS)
    pooled = ((block[:, 0, :, 0, :] + block[:, 0, :, 1, :])
              + (block[:, 1, :, 0, :] + block[:, 1, :, 1, :])
              ) * torch.tensor(0.25, dtype=torch.float16, device="cpu")
    pooled_values = torch.zeros((POOL_HEIGHT, POOL_WIDTH, CHANNELS),
                                dtype=torch.float16, device="cpu")
    pooled_values[:HEIGHT // 2, :WIDTH // 2] = pooled
    pooled_codes = _e4(torch, pooled_values)

    record = np.zeros(RECORD_BYTES, dtype=np.uint8)
    channel_scales = torch.tensor(SCALE_CYCLE, dtype=torch.float16,
                                  device="cpu")[torch.arange(CHANNELS, device="cpu") % 3]
    record[MATRIX_BYTES:] = channel_scales.view(torch.uint8).numpy()

    residual_codes = _e4(torch, residual_values)
    state_codes = _e4(torch, state_values)
    high_codes = _e4(torch, products)
    return dict(
        residual_tile=_pack(residual_codes, tile_offsets),
        state_tile=_pack(state_codes, tile_offsets),
        record=record,
        expected_tile=_pack(high_codes, tile_offsets),
        expected_plane=_pack(high_codes, plane_offsets),
        expected_pool=_pack(pooled_codes, pool_offsets),
        state_codes=state_codes, residual_codes=residual_codes,
        high_codes=high_codes, pooled_codes=pooled_codes,
        residual_values=residual_values, state_values=state_values,
        products=products, pooled_values=pooled_values,
        tile_offsets=tile_offsets, plane_offsets=plane_offsets, pool_offsets=pool_offsets,
    )


def _guarded(torch, payload, device):
    """Exact ABI extent inside a 4096-byte prefix/suffix guarded backing."""
    payload = torch.as_tensor(np.ascontiguousarray(payload, dtype=np.uint8))
    backing = torch.full((payload.numel() + 2 * GUARD_BYTES,), GUARD_VALUE,
                         dtype=torch.uint8, device=device)
    view = backing[GUARD_BYTES:GUARD_BYTES + payload.numel()]
    view.copy_(payload)
    assert view.data_ptr() % 16 == 0
    return backing, view


def test_c512_fp8_residual_four_entries():
    if os.environ.get(OPT_IN) != "1":
        pytest.skip(f"GPU regression is opt-in: set {OPT_IN}=1")
    import torch
    if not torch.cuda.is_available():
        pytest.skip("CUDA device unavailable")
    device = torch.cuda.current_device()
    major, minor = torch.cuda.get_device_capability(device)
    if 10 * major + minor < 89:
        pytest.skip(f"native FP8 requires SM89+, found SM{major}{minor}")
    from dlssnr import deployment
    torch.cuda.set_device(device)
    ops = deployment.load_extension(device=device)
    fixture = _fixture()

    anchor = torch.zeros(1, dtype=torch.uint8, device=device)
    rows = [int(value) for value in ops.prepare_c512_fp8(anchor, ENTRIES[0])]
    assert len(rows) == 63
    admitted = rows[::7]
    assert all(entry in admitted for entry in ENTRIES)

    launched = []
    for entry in ENTRIES:
        state_backing, state = _guarded(torch, fixture["state_tile"], device)
        residual_backing, residual = _guarded(torch, fixture["residual_tile"], device)
        record_backing, record = _guarded(torch, fixture["record"], device)
        high_backing, high = _guarded(torch, np.zeros(IMAGE_BYTES, np.uint8), device)
        outputs = [high]
        backings = [state_backing, residual_backing, record_backing, high_backing]
        if entry == 14:
            pool_backing, pool = _guarded(torch, np.zeros(POOL_BYTES, np.uint8), device)
            outputs = [high, pool]
            backings.append(pool_backing)
        inputs = [state, record, residual]
        snapshots = [tensor.clone() for tensor in inputs]

        returned = ops.c512_out_fp8(entry, inputs, outputs, HEIGHT, WIDTH, 0)
        torch.cuda.synchronize()
        launched.append(entry)
        assert len(returned) == len(outputs)
        assert [tensor.data_ptr() for tensor in returned] == [tensor.data_ptr() for tensor in outputs]
        for backing in backings:
            assert bool(torch.all(backing[:GUARD_BYTES] == GUARD_VALUE))
            assert bool(torch.all(backing[-GUARD_BYTES:] == GUARD_VALUE))
        assert all(torch.equal(tensor, snapshot) for tensor, snapshot in zip(inputs, snapshots))

        expected = fixture["expected_plane"] if entry == 12 else fixture["expected_tile"]
        observed = high.cpu().numpy()
        assert np.array_equal(observed, expected)
        assert np.all((observed & 0x7F) != 0x7F)
        if entry == 14:
            observed_pool = pool.cpu().numpy()
            assert np.array_equal(observed_pool, fixture["expected_pool"])
            assert np.all((observed_pool & 0x7F) != 0x7F)

    assert launched == list(ENTRIES)
