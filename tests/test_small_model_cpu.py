"""Focused CPU checks for the opt-in Small31 PyTorch research graph.

Heavy tensor allocation is mocked: schedule/phase/skip ordering, role-keyed block
construction, the native 4x32 (RGB + history gate) head indexing and
archive/model identity are tested without a GPU or a full 145M-parameter model.
The real 310.9.16 artifact validation lives in ``test_runtime_assets_cpu.py`` and
the implementation report.
"""
from __future__ import annotations

from dataclasses import replace
import hashlib
import json
from pathlib import Path
import struct

import numpy as np
import pytest
import torch
from torch import nn

from dlssnr.geometry import Geometry, block_layout
from dlssnr.model_specs import SMALL31
from dlssnr import small_model
from dlssnr.small_model import (
    SmallDLSSNR,
    SmallWeightArchive,
    decode_native_rgb_head_data,
)
from dlssnr.weights import WeightArchive


def _geometry() -> Geometry:
    return Geometry(
        valid_width=45,
        valid_height=37,
        full_width=48,
        full_height=40,
        levels=((24, 20), (12, 10), (6, 6), (4, 4), (2, 2), (1, 1)),
    )


class _FakeNumerics:
    """Shape-only arithmetic; never allocates real model parameters."""

    precision = "fp32"
    working_dtype = torch.float32

    def round(self, value):
        return value

    def publish(self, value):
        return value

    def linear(self, x, weight, residual=None, scale=None, partition=0, *, f16_weights=False):
        output = torch.zeros(*x.shape[:-1], weight.shape[0], dtype=x.dtype, device=x.device)
        return output + residual if residual is not None else output

    def pool(self, x, target):
        width, height = target
        return torch.zeros(x.shape[0], height, width, x.shape[-1], dtype=x.dtype, device=x.device)

    def upsample(self, x, target):
        width, height = target
        return torch.zeros(x.shape[0], height, width, x.shape[-1], dtype=x.dtype, device=x.device)

    def upsample_residual(self, x, skip, scale, target, input_scale=None):
        width, height = target
        return torch.zeros(x.shape[0], height, width, skip.shape[-1], dtype=x.dtype, device=x.device)


class _FakeBlock(nn.Module):
    matrix_keys = {"w1", "w2", "w3", "w4", "qkv", "projection", "input_adapter", "head",
                   "up_projection", "down_projection"}

    def __init__(self, index, tensors, numerics, *, trainable=False):
        super().__init__()
        self.index = index
        self.channels = 32
        self.numerics = numerics
        for name, value in tensors.items():
            value = value.transpose(-1, -2).contiguous() if name in self.matrix_keys else value.contiguous()
            if trainable:
                self.register_parameter(name, nn.Parameter(value))
            else:
                self.register_buffer(name, value)

    def forward(self, state, phase=0, *, skip_override=None):
        return state, state


class _MarkerBlock(_FakeBlock):
    def __init__(self, index, tensors, numerics, published, raw):
        super().__init__(index, tensors, numerics)
        self.published = published
        self.raw = raw

    def forward(self, state, phase=0, *, skip_override=None):
        return torch.full_like(state, self.published), torch.full_like(state, self.raw)


class _RecordingNumerics(_FakeNumerics):
    def __init__(self):
        self.pool_inputs = []

    def pool(self, x, target):
        self.pool_inputs.append(x.detach().clone())
        return super().pool(x, target)


def _tensor(value: float, shape=(1, 1)):
    return torch.full(shape, value, dtype=torch.float32)


def _fake_decoded(role: int) -> dict[str, torch.Tensor]:
    result = {
        "w1": _tensor(role), "w2": _tensor(role), "w3": _tensor(role), "w4": _tensor(role),
        "qkv": _tensor(role), "projection": _tensor(role), "ffn_scale": _tensor(role),
        "attn_scale": _tensor(role), "head_scale": _tensor(role), "bias": _tensor(role),
    }
    if role == 0:
        result["input_adapter"] = _tensor(role, (1, 16))
    if role in (4, 8, 14, 22, 30):
        result["down_projection"] = _tensor(role)
    if role == 39:
        result.update(up_projection=_tensor(role), transition_scale=_tensor(role))
    if role in (48, 56, 62, 66):
        result.update(up_projection=_tensor(role), transition_scale=_tensor(role))
    if role == 70:
        result.update(head=_tensor(role, (32, 4)), adapter_scale=_tensor(role),
                      input_scale=_tensor(role), blend_scale=torch.tensor([0.76708984375]))
    return result


class _FakeArchive:
    spec = SMALL31

    def __init__(self, manifest_sha256: str = "b" * 64, *, spec=SMALL31,
                 dll_sha256: str | None = None):
        self.spec = spec
        self.manifest_sha256 = manifest_sha256
        self.dll_sha256 = SMALL31.dll_pins[0].sha256 if dll_sha256 is None else dll_sha256
        self.validated = False

    def validate_complete(self):
        self.validated = True

    def decode_block(self, role):
        return _fake_decoded(role)


@pytest.fixture
def fake_model(monkeypatch):
    monkeypatch.setattr(small_model, "NRBlock", _FakeBlock)
    model = SmallDLSSNR(_FakeArchive())
    model.numerics = _FakeNumerics()
    return model


# ---------------------------------------------------------------------------
# Schedule, phases and head indexing


def test_schedule_plan_is_role_based_with_distinct_skip_order():
    geometry = _geometry()
    plan = SmallDLSSNR.schedule_plan(geometry)
    assert len(plan) == 31
    executed = [step.role for step in plan if step.kind != "input"]
    assert sorted(executed + [SMALL31.pre_role]) == list(SMALL31.roles)
    assert plan[0].kind == "input" and plan[0].role == 0 and plan[0].phase == 0
    assert plan[-1].kind == "post" and plan[-1].role == 70 and plan[-1].phase == 0

    skip_roles = [step.skip_role for step in plan if step.skip_role is not None]
    assert skip_roles[:5] == [4, 8, 14, 22, 30]
    assert skip_roles[5:] == [30, 22, 14, 8, 4]
    # A raw-index implementation would produce 2,4,6,8,10 instead.
    assert [SMALL31.raw_for_role(role) for role in skip_roles[:5]] == [2, 4, 6, 8, 10]
    assert skip_roles[:5] != [2, 4, 6, 8, 10]

    by_role = {step.role: step for step in plan}
    assert by_role[4].phase == 1 and by_role[4].skip_level == 0
    assert by_role[8].phase == 1 and by_role[8].skip_level == 1
    assert by_role[30].phase == 1 and by_role[30].skip_level == 4
    assert by_role[39].kind == "transition" and by_role[39].skip_role == 30
    assert by_role[39].target == geometry.levels[4]
    assert by_role[40].phase == 2 and by_role[47].phase == 3
    assert by_role[48].kind == "decoder_entry" and by_role[48].skip_role == 22
    assert by_role[48].target == geometry.levels[3]
    assert by_role[66].kind == "decoder_entry" and by_role[66].skip_role == 4
    assert by_role[66].target == geometry.levels[0]
    for role in range(31, 39):
        assert by_role[role].phase is None

    post_two = SmallDLSSNR.schedule_plan(geometry, post_phase=2)
    assert post_two[-1].phase == 2
    with pytest.raises(ValueError):
        SmallDLSSNR.schedule_plan(geometry, post_phase=4)
    with pytest.raises(TypeError):
        SmallDLSSNR.schedule_plan("not geometry")  # type: ignore[arg-type]


def test_native_head_scatter_selects_rows_0_2_4_6_including_history_gate():
    raw = np.arange(512, dtype="<f2")
    decoded = decode_native_rgb_head_data(raw.tobytes(), SMALL31.post_head)
    assert decoded.shape == (4, 32)
    assert decoded.dtype == torch.float32
    # Row 0, columns 0/1 come from flat 0/1; selected storage rows 2,4,6
    # start at flat 32, 64 and 96 because of the source bit permutation.
    assert decoded[0, 0].item() == 0
    assert decoded[0, 1].item() == 1
    assert decoded[1, 0].item() == 32
    assert decoded[2, 0].item() == 64
    assert decoded[3, 0].item() == 96
    # A naive reshape(16,32)[[0,2,4,6]] would use flat 64,128,192.
    naive = raw.reshape(16, 32)[[0, 2, 4, 6]].astype(np.float32)
    assert decoded[1, 0].item() != naive[1, 0]
    assert decoded[2, 0].item() != naive[2, 0]
    assert decoded[3, 0].item() != naive[3, 0]
    assert SMALL31.post_head.used_rows == (0, 2, 4, 6)
    assert SMALL31.post_head.native_shape == (4, 32)
    assert SMALL31.post_head.history_row == 6
    assert SMALL31.post_head.used_rows[3] == SMALL31.post_head.history_row
    assert SMALL31.post_head.history_byte_length == 64
    assert SMALL31.post_head.offset == block_layout(70)["head"] == 20784
    assert SMALL31.post_head.offset + SMALL31.post_head.byte_length == 21808
    with pytest.raises(ValueError):
        decode_native_rgb_head_data(b"\x00" * 1022, SMALL31.post_head)


# ---------------------------------------------------------------------------
# Strict archive role view and real-format post decode


def _base_small_manifest(stage: dict, tensors: list[dict]) -> dict:
    return {
        "schemaVersion": 2,
        "format": "dlssnr-runtime-assets",
        "model": {
            "id": "small31", "blockCount": 31, "roles": list(SMALL31.roles),
            "rawToRole": list(SMALL31.raw_to_role), "preRole": 0, "postRole": 70,
            "postPhaseDefault": 0,
            "postHead": {
                "offset": 20784, "byteLength": 1024, "storageShape": [16, 32],
                "rowBits": [2, 5, 6, 7], "columnBits": [0, 1, 3, 4, 8],
                "usedRows": [0, 2, 4, 6], "nativeShape": [4, 32],
                "historyRow": 6, "historyByteLength": 64,
            },
        },
        "source": {
            "dllFileName": "fixture.dll",
            "dllSha256": SMALL31.dll_pins[0].sha256,
            "dllByteLength": SMALL31.dll_pins[0].byte_length,
            "runtimeExecuted": False,
            "networkUsed": False,
            "resource": {
                "path": SMALL31.resource.path,
                "sha256": SMALL31.resource.sha256,
                "byteLength": SMALL31.resource.byte_length,
            },
        },
        "totals": {
            "blockCount": 31, "roleCount": 31, "tensorCount": len(tensors),
            "stageCount": 1, "packedByteLength": stage["packedByteLength"],
        },
        "stages": [stage],
        "tensors": tensors,
    }


def _tensor_entry(name, raw, stage, offset, length, parameter="layer"):
    return {
        "name": name, "block": raw, "rawBlock": raw,
        "role": SMALL31.role_for_raw(raw), "layer": 0, "parameter": parameter,
        "stage": stage, "stageOffset": offset, "byteLength": length,
        "deviceCode": 1, "storageDimensions": [length // 2], "tailFields": [0, 0],
        "sha256": "0" * 64,
    }


def _write_archive(tmp_path: Path, stage: dict, tensors: list[dict], payload: bytes) -> Path:
    directory = tmp_path / "archive"
    model_dir = directory / "model" / "stages"
    model_dir.mkdir(parents=True)
    (directory / "model" / stage["file"]).write_bytes(payload)
    stage["sha256"] = hashlib.sha256(payload).hexdigest()
    for tensor in tensors:
        data = payload[tensor["stageOffset"]:tensor["stageOffset"] + tensor["byteLength"]]
        tensor["sha256"] = hashlib.sha256(data).hexdigest()
    manifest = _base_small_manifest(stage, tensors)
    (directory / "manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
    return directory


def _post_only_archive(tmp_path: Path) -> Path:
    layer = bytearray(21808)
    layer[20784:20784 + 1024] = struct.pack("<512e", *range(512))
    payload = b"\x00\x00" + bytes(layer)
    stage = {"id": "decoder32", "kind": "decoder", "file": "stages/decoder32.bin",
             "roles": [66, 69, 70], "rawBlocks": [30], "recordCount": 2,
             "packedByteLength": len(payload), "sha256": ""}
    tensors = [
        _tensor_entry("block30.layer0.blend_scale", 30, "decoder32", 0, 2, "blend_scale"),
        _tensor_entry("block30.layer0.layer", 30, "decoder32", 2, 21808),
    ]
    return _write_archive(tmp_path, stage, tensors, payload)


def test_post_archive_keeps_four_channel_head_and_history_gate(tmp_path):
    archive = SmallWeightArchive(_post_only_archive(tmp_path), require_complete=False)
    decoded = archive.decode_block(70)
    assert decoded["head"].shape == (32, 4)
    # The Small archive returns the unmodified trusted decode, not a 3-row view.
    trusted = WeightArchive.decode_block(archive, 70)
    assert set(decoded) == set(trusted)
    for key in trusted:
        assert torch.equal(decoded[key], trusted[key])
    assert "native_rgb_head" not in decoded and "training_head_surrogate" not in decoded
    native = archive.decode_native_rgb_head()
    assert native.shape == (4, 32)
    assert native[1, 0].item() == 32
    assert native[2, 0].item() == 64
    assert native[3, 0].item() == 96
    assert decoded["blend_scale"].shape == (1,)


def test_role_view_maps_raw_two_to_role_four(tmp_path):
    payload = b"\x00" * 22_720
    stage = {"id": "encoder32", "kind": "encoder", "file": "stages/encoder32.bin",
             "roles": [1, 4], "rawBlocks": [2], "recordCount": 1,
             "packedByteLength": len(payload), "sha256": ""}
    tensors = [_tensor_entry("block2.layer0.layer", 2, "encoder32", 0, 22_720)]
    archive = SmallWeightArchive(_write_archive(tmp_path, stage, tensors, payload), require_complete=False)
    assert archive.tensor(4).name == "block2.layer0.layer"
    assert archive.record_for_raw(2).name == "block2.layer0.layer"
    with pytest.raises(ValueError):
        archive.tensor(2)
    decoded = archive.decode_block(4)
    assert decoded["w1"].shape == (32, 128)
    assert decoded["w2"].shape == (128, 32)
    assert decoded["down_projection"].shape == (32, 64)


# ---------------------------------------------------------------------------
# Model construction and explicit forward contract


def test_model_builds_exactly_31_role_keyed_blocks(fake_model):
    assert len(fake_model.blocks) == 31
    assert tuple(fake_model.blocks) == SMALL31.roles
    assert fake_model.blocks[4].index == 4
    with pytest.raises(KeyError):
        fake_model.blocks[2]
    modules = [module for _, module in fake_model.named_modules() if isinstance(module, _FakeBlock)]
    assert len(modules) == 31
    assert len({id(module) for module in modules}) == 31
    assert "native_rgb_head" not in fake_model.blocks[70]._buffers
    assert "training_head_surrogate" not in fake_model.blocks[70]._buffers
    assert fake_model.blocks[70].head.shape == (4, 32)
    descriptor = fake_model.descriptor()
    assert descriptor["model"] == "small31"
    assert descriptor["blockCount"] == 31
    assert descriptor["archiveManifestSha256"] == "b" * 64
    assert descriptor["postHead"] == "4x32"
    assert descriptor["postHeadLayout"] == "rgb+history_gate"


def test_model_identity_is_exactly_the_archive_decode(fake_model):
    for role in SMALL31.roles:
        assert torch.equal(fake_model.blocks[role].w1, _tensor(role))
    assert torch.equal(fake_model.blocks[70].head, _tensor(70, (32, 4)).transpose(-1, -2))


def test_forward_shapes_boundaries_and_crop(fake_model):
    geometry = _geometry()
    features = torch.zeros(1, geometry.full_height, geometry.full_width, 16, dtype=torch.float32)
    head, boundaries = fake_model(features, geometry=geometry, return_boundaries=True)
    assert head.shape == (1, 40, 48, 4)
    # Every scheduled operation role exposes its block boundary, exactly like
    # the legacy graph; transition tensors are additional named boundaries.
    expected = {f"block-{role}" for role in SMALL31.roles}
    for role in (0, 4, 8, 14, 22, 30):
        expected.add(f"transition-{role}-{SMALL31.next_role(role)}")
    assert set(boundaries) == expected
    assert "block-2" not in boundaries
    assert "block-31" in boundaries and "block-38" in boundaries
    assert "block-40" in boundaries and "block-47" in boundaries
    assert "block-70" in boundaries

    cropped = fake_model(features, geometry=geometry, crop=True)
    assert cropped.shape == (1, geometry.valid_height, geometry.valid_width, 4)
    assert fake_model(features, geometry=geometry, post_phase=2).shape == (1, 40, 48, 4)


def test_encoder_tail_pools_raw_and_post_consumes_input_adapter(monkeypatch):
    monkeypatch.setattr(small_model, "NRBlock", _FakeBlock)
    model = SmallDLSSNR(_FakeArchive())
    recording = _RecordingNumerics()
    model.numerics = recording
    model.blocks.by_role["0"] = _MarkerBlock(0, _fake_decoded(0), recording, published=3.0, raw=4.0)
    model.blocks.by_role["4"] = _MarkerBlock(4, _fake_decoded(4), recording, published=1.0, raw=2.0)
    captured = {}
    original = model._post_head

    def wrapper(state, adapter, geometry, phase, *, return_boundary=False):
        captured["adapter"] = adapter.detach().clone()
        return original(state, adapter, geometry, phase, return_boundary=return_boundary)

    model._post_head = wrapper
    features = torch.zeros(1, 40, 48, 16)
    model(features, geometry=_geometry())
    pooled = recording.pool_inputs
    assert any(torch.allclose(value, torch.full_like(value, 4.0)) for value in pooled)
    assert any(torch.allclose(value, torch.full_like(value, 2.0)) for value in pooled)
    assert "adapter" in captured
    assert torch.allclose(captured["adapter"], torch.full_like(captured["adapter"], 3.0))


def test_forward_rejects_bad_geometry_device_storage_and_post_phase(fake_model):
    geometry = _geometry()
    good = torch.zeros(1, 40, 48, 16)
    with pytest.raises(ValueError):
        fake_model(good.half(), geometry=geometry)
    with pytest.raises(ValueError):
        fake_model(torch.zeros(1, 40, 48, 15), geometry=geometry)
    with pytest.raises(ValueError):
        fake_model(torch.zeros(1, 41, 48, 16), geometry=geometry)
    with pytest.raises(ValueError):
        fake_model(torch.zeros(1, 40, 48, 16, device="meta"), geometry=geometry)
    with pytest.raises(TypeError):
        fake_model(good, geometry="geometry")  # type: ignore[arg-type]
    with pytest.raises(ValueError):
        fake_model(good, geometry=geometry, post_phase=4)

    fake_model.blocks[0].input_adapter = fake_model.blocks[0].input_adapter.half()
    with pytest.raises(ValueError):
        fake_model(good, geometry=geometry)


def test_checkpoint_blocks_recompute_path(monkeypatch):
    monkeypatch.setattr(small_model, "NRBlock", _FakeBlock)
    model = SmallDLSSNR(_FakeArchive(), checkpoint_blocks=True)
    model.numerics = _FakeNumerics()
    assert model.checkpoint_blocks is True
    value = torch.ones(2, requires_grad=True)
    with torch.enable_grad():
        output = model._run_stage(lambda argument: argument * 2, value)
        output.sum().backward()
    assert torch.equal(value.grad, torch.full((2,), 2.0))


def test_trainable_flag_registers_parameters(monkeypatch):
    monkeypatch.setattr(small_model, "NRBlock", _FakeBlock)
    model = SmallDLSSNR(_FakeArchive(), trainable=True)
    assert model.blocks[0].w1.requires_grad
    assert model.blocks[70].head.requires_grad
    assert "native_rgb_head" not in dict(model.blocks[70].named_parameters())


def test_compose_uses_fourth_channel_history_gate(fake_model):
    head = torch.zeros(1, 4, 4, 4)
    proxy = torch.ones(1, 4, 4, 3)
    fake_model.blocks[70].blend_scale = torch.tensor([0.5])
    assert torch.equal(fake_model.compose(head, proxy), proxy)
    with pytest.raises(ValueError):
        fake_model.compose(torch.zeros(1, 4, 4, 3), proxy)
    composed = fake_model.compose(head, proxy, reprojected_history=torch.zeros_like(proxy))
    # sigmoid(head[...,3]=0) * blend_scale(0.5) = 0.25.
    assert torch.allclose(composed, torch.full_like(proxy, 0.75))


def test_state_dict_identity_rejects_cross_model_even_strict_false(fake_model):
    state = fake_model.state_dict()
    assert state["_extra_state"]["model"] == "small31"
    assert state["_extra_state"]["postHead"] == "4x32"
    assert state["_extra_state"]["postPhase"] == 0

    fresh = SmallDLSSNR(_FakeArchive())
    fresh.numerics = _FakeNumerics()
    fresh.load_state_dict(state)
    assert fresh.get_extra_state()["archiveManifestSha256"] == "b" * 64

    missing = dict(state)
    missing.pop("_extra_state")
    with pytest.raises(ValueError):
        fresh.load_state_dict(missing, strict=False)

    wrong_model = dict(state)
    wrong_model["_extra_state"] = dict(state["_extra_state"], model="legacy71")
    with pytest.raises(ValueError):
        fresh.load_state_dict(wrong_model, strict=False)
    assert fresh.get_extra_state()["model"] == "small31"

    swapped = list(state["_extra_state"]["roles"])
    swapped[0], swapped[1] = swapped[1], swapped[0]
    wrong_roles = dict(state)
    wrong_roles["_extra_state"] = dict(state["_extra_state"], roles=swapped)
    with pytest.raises(ValueError):
        fresh.load_state_dict(wrong_roles, strict=False)
    assert fresh.get_extra_state()["roles"] == list(SMALL31.roles)

    other_phase = SmallDLSSNR(_FakeArchive(), post_phase=2)
    other_phase.numerics = _FakeNumerics()
    with pytest.raises(ValueError):
        other_phase.load_state_dict(state, strict=False)
    assert other_phase.post_phase == 2 and other_phase.get_extra_state()["postPhase"] == 2
    with pytest.raises(ValueError):
        other_phase.set_extra_state(dict(state["_extra_state"], postPhase=3))
    assert other_phase.post_phase == 2


def test_equivalent_verified_archives_are_checkpoint_portable(monkeypatch):
    """Local manifest provenance must not block restoring the same verified source."""
    monkeypatch.setattr(small_model, "NRBlock", _FakeBlock)
    source = SmallDLSSNR(_FakeArchive(manifest_sha256="a" * 64))
    source.numerics = _FakeNumerics()
    with torch.no_grad():
        source.blocks[4].w1.fill_(12.5)
        source.blocks[70].head.fill_(-3.0)
    state = source.state_dict()

    # A second equally verified archive with a different manifest SHA/provenance.
    target = SmallDLSSNR(_FakeArchive(manifest_sha256="c" * 64))
    target.numerics = _FakeNumerics()
    target.load_state_dict(state)
    assert torch.equal(target.blocks[4].w1, torch.full_like(target.blocks[4].w1, 12.5))
    assert torch.equal(target.blocks[70].head, torch.full_like(target.blocks[70].head, -3.0))
    assert target.archive_manifest_sha256 == "c" * 64
    assert target.get_extra_state()["archiveManifestSha256"] == "c" * 64
    assert target.get_extra_state()["model"] == "small31"


def test_state_dict_identity_rejects_wrong_resource_and_rolemap(monkeypatch):
    monkeypatch.setattr(small_model, "NRBlock", _FakeBlock)
    source = SmallDLSSNR(_FakeArchive())
    source.numerics = _FakeNumerics()
    with torch.no_grad():
        source.blocks[4].w1.fill_(99.0)
    state = source.state_dict()

    wrong_resource_spec = replace(SMALL31, resource=replace(SMALL31.resource, sha256="f" * 64))
    wrong_resource = SmallDLSSNR(_FakeArchive(spec=wrong_resource_spec))
    with pytest.raises(ValueError, match="resourceSha256"):
        wrong_resource.load_state_dict(state, strict=False)
    # Rejected before any tensor copy: the target keeps its own values.
    assert torch.equal(wrong_resource.blocks[4].w1, _tensor(4))

    swapped = list(SMALL31.raw_to_role)
    swapped[20], swapped[21] = swapped[21], swapped[20]
    wrong_map_spec = replace(SMALL31, raw_to_role=tuple(swapped))
    wrong_map = SmallDLSSNR(_FakeArchive(spec=wrong_map_spec))
    with pytest.raises(ValueError, match="rawToRole"):
        wrong_map.load_state_dict(state, strict=False)
    assert torch.equal(wrong_map.blocks[4].w1, _tensor(4))
    assert wrong_map.get_extra_state()["rawToRole"] == swapped


def test_from_directory_rejects_fp16_storage(tmp_path):
    with pytest.raises(ValueError):
        SmallDLSSNR.from_directory(tmp_path, dtype=torch.float16)
