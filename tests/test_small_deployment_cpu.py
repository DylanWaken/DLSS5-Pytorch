"""Focused CPU checks for the native Small31 checkpoint adapter.

These tests do not load a CUDA module and do not execute any GPU kernel.  The
compiled Small31 rosters are read from the generated ``.inl`` tables and exposed
through a fake extension object so record order, byte extents and plan argument
forwarding are checked without a build.  When the locally extracted 310.9.16
Small31 archive is present, FP16 packing and the four-channel post head are
checked against the real weights; otherwise those cases skip cleanly.
"""
from __future__ import annotations

import re
from pathlib import Path

import numpy as np
import pytest
import torch

from dlssnr.checkpoint import Checkpoint, MATRIX_FIELDS, NativeWeightArchive, pack_kernel_fp16
from dlssnr.geometry import block_channels
from dlssnr.model_specs import SMALL31
from dlssnr.small_model import SmallWeightArchive
from dlssnr import small_deployment
from dlssnr.small_deployment import (
    PREPOST_RECORD_BYTES,
    SmallNativeCheckpoint,
    load_native_model,
)
from dlssnr.weights import WeightArchive, packed_f16_weight_index


ROOT = Path(__file__).resolve().parents[1]
SMALL_ARCHIVE = ROOT / "profile/dlss-update-20261029/implementation/runtime-assets-small31"
LEGACY_CHECKPOINT = ROOT / "ckpts/dlss5_nr_fp16.pt"
COMPILED_INL = {
    "fp8": ROOT / "csrc/kernel_launcher/small_plan_generated.inl",
    "fp16": ROOT / "csrc/kernel_launcher/small_plan_fp16_generated.inl",
}
EXPECTED_TRUNK_NAMES = [
    "block1.layer0.layer", "block2.layer0.layer", "block3.layer0.layer",
    "block4.layer0.layer", "block5.layer0.layer", "block6.layer0.layer",
    "block7.layer0.layer", "block8.layer0.layer", "block9.layer0.layer",
    "block9.layer1.layer", "block9.layer2.layer", "block9.layer3.layer",
    "block10.layer0.layer", "block10.layer1.layer", "block10.layer2.layer",
    "block10.layer3.layer", "block10.layer4.layer",
    "block11.layer0.layer", "block11.layer1.layer", "block11.layer2.layer",
    "block11.layer4.layer", "block12.layer0.layer", "block12.layer1.layer",
    "block12.layer2.layer", "block12.layer4.layer", "block13.layer0.layer",
    "block13.layer1.layer", "block13.layer2.layer", "block13.layer4.layer",
    "block14.layer0.layer", "block14.layer1.layer", "block14.layer2.layer",
    "block14.layer4.layer", "block15.layer0.layer", "block15.layer1.layer",
    "block15.layer2.layer", "block15.layer4.layer", "block16.layer0.layer",
    "block16.layer1.layer", "block16.layer2.layer", "block16.layer4.layer",
    "block17.layer0.layer", "block17.layer1.layer", "block17.layer2.layer",
    "block17.layer4.layer", "block18.layer0.layer", "block18.layer1.layer",
    "block18.layer2.layer", "block18.layer4.layer",
    "block19.layer0.layer", "block20.layer0.layer", "block20.layer1.layer",
    "block20.layer2.layer", "block20.layer3.layer", "block21.layer0.layer",
    "block21.layer1.layer", "block21.layer2.layer", "block21.layer3.layer",
    "block22.layer0.layer", "block23.layer0.layer", "block24.layer0.layer",
    "block25.layer0.layer", "block26.layer0.layer", "block27.layer0.layer",
    "block28.layer0.layer", "block29.layer0.layer",
]


# ---------------------------------------------------------------------------
# Fixtures and helpers


def _compiled_records(precision: str) -> list[tuple[str, int]]:
    """Parse one generated Small31 record table (raw block, layer, byte length)."""
    path = COMPILED_INL[precision]
    text = path.read_text(encoding="utf-8")
    table = f"SmallRecordSpecs_{precision}"
    match = re.search(rf"static const FBufferSpec {table}\[\] = \{{(.*?)\}};", text, re.S)
    assert match is not None, f"{table} is missing from {path}"
    pairs = re.findall(r'\{"([^"]+)", (\d+)LL\}', match.group(1))
    assert len(pairs) == 66
    return [(name, int(size)) for name, size in pairs]


@pytest.fixture(scope="module")
def archive():
    if not (SMALL_ARCHIVE / "manifest.json").is_file():
        pytest.skip("the extracted Small31 archive is not available")
    return SmallWeightArchive(SMALL_ARCHIVE)


@pytest.fixture(scope="module")
def checkpoint(archive):
    return SmallNativeCheckpoint(archive)


class _FakePlan:
    def __init__(self, precision, state, records, width, height):
        self.precision = precision
        self.state = state
        self.records = tuple(records)
        self.width = width
        self.height = height


class _FakeOps:
    """Small31 roster/plan surface only; legacy roster names must never be used."""

    def __init__(self, rosters):
        self.rosters = {key: list(value) for key, value in rosters.items()}
        self.plans = []

    def _names(self, precision):
        return [name for name, _ in self.rosters[precision]]

    def _bytes(self, precision):
        return [size for _, size in self.rosters[precision]]

    def record_names_small31_fp8(self):
        return self._names("fp8")

    def record_bytes_small31_fp8(self):
        return self._bytes("fp8")

    def record_names_small31_fp16(self):
        return self._names("fp16")

    def record_bytes_small31_fp16(self):
        return self._bytes("fp16")

    def create_small_plan_for_resolution_fp8(self, state, records, width, height):
        self.plans.append(_FakePlan("fp8", state, records, width, height))
        return self.plans[-1]

    def create_small_plan_for_resolution_fp16(self, state, records, width, height):
        self.plans.append(_FakePlan("fp16", state, records, width, height))
        return self.plans[-1]


def _install_fake_extension(monkeypatch, rosters):
    ops = _FakeOps(rosters)
    monkeypatch.setattr(small_deployment, "load_extension", lambda **kwargs: ops)
    return ops


def _unit_state():
    return torch.zeros(4, dtype=torch.uint8)


class _NativeView:
    """Test-local native decoder view (same public decoders, independent mapping)."""

    fp8_matrix = staticmethod(NativeWeightArchive.fp8_matrix)
    f16_matrix = staticmethod(NativeWeightArchive.f16_matrix)
    vector = staticmethod(NativeWeightArchive.vector)
    relative_bias = staticmethod(NativeWeightArchive.relative_bias)

    def __init__(self, archive):
        self.archive = archive

    def tensor(self, *args, **kwargs):
        return self.archive.tensor(*args, **kwargs)


def _mapped_state(archive: SmallWeightArchive, role: int) -> dict[str, torch.Tensor]:
    """Independent test mapping of the actual archive weights to packing state."""
    decoded = WeightArchive.decode_block(_NativeView(archive), role)
    state = {}
    for name, value in decoded.items():
        if name in MATRIX_FIELDS:
            value = value.transpose(-1, -2)
        state[f"blocks.{role}.{name}"] = value.contiguous()
    return state


def _expected_kind(role: int, layer: int) -> str:
    if role == SMALL31.pre_role:
        return "preprocess"
    if role == SMALL31.post_role:
        return "postprocess"
    if role == SMALL31.transition_role:
        return "upsample"
    c = block_channels(role)
    if c == 1024:
        return {0: "expand", 1: "contract", 2: "qkv", 4: "projection"}[layer]
    if c == 512:
        return {0: "ffn", 1: "ffn_projection", 2: "qkv", 3: "projection", 4: "down"}[layer]
    return "window"


# ---------------------------------------------------------------------------
# Compiled roster mapping


def test_compiled_rosters_are_the_pinned_native_trunk_order():
    for precision in ("fp8", "fp16"):
        records = _compiled_records(precision)
        assert [name for name, _ in records] == EXPECTED_TRUNK_NAMES

    fp8 = dict(_compiled_records("fp8"))
    fp16 = dict(_compiled_records("fp16"))
    assert set(fp8) == set(fp16) == set(EXPECTED_TRUNK_NAMES)
    # The native record names are raw-block names: raw 19 is the transition
    # role 39, and neither pre raw 0 nor post raw 30 belongs to the trunk.
    assert "block19.layer0.layer" in fp8 and "block30.layer0.layer" not in fp8
    assert "block0.layer0.layer" not in fp8


def test_create_plan_fp8_uses_compiled_raw_names_and_original_bytes(checkpoint, monkeypatch):
    ops = _install_fake_extension(monkeypatch, {
        "fp8": _compiled_records("fp8"),
        "fp16": _compiled_records("fp16"),
    })
    assert checkpoint._state is None  # FP8 deployment must not decode/conversion weights
    state = _unit_state()
    plan = checkpoint.create_plan_fp8(state, width=1920, height=1080)

    assert plan.precision == "fp8"
    assert plan.state is state
    assert (plan.width, plan.height) == (1920, 1080)
    assert len(ops.plans) == 1
    assert len(plan.records) == 66
    assert all(record.device == state.device for record in plan.records)
    assert checkpoint._state is None  # still no FP16/full-state materialisation

    for (name, size), record in zip(_compiled_records("fp8"), plan.records):
        assert record.dtype == torch.uint8 and record.ndim == 1
        assert record.numel() == size == SMALL31.record_spec(name).byte_length
        original = np.frombuffer(checkpoint.archive.records[name].data, dtype=np.uint8)
        assert np.array_equal(record.numpy(), original), name


def test_create_plan_fp16_packs_the_compiled_roster_exactly(checkpoint, monkeypatch):
    fp16 = _compiled_records("fp16")
    ops = _install_fake_extension(monkeypatch, {
        "fp8": _compiled_records("fp8"),
        "fp16": fp16,
    })
    plan = checkpoint.create_plan_fp16(_unit_state(), width=1234, height=777)

    assert plan.precision == "fp16"
    assert (plan.width, plan.height) == (1234, 777)
    assert len(plan.records) == 66
    for (name, size), record in zip(fp16, plan.records):
        spec = SMALL31.record_spec(name)
        kind = _expected_kind(spec.role, spec.layer)
        expected = checkpoint.kernel_record(spec.role, kind=kind, precision="fp16")
        assert record.dtype == torch.uint8 and record.ndim == 1
        assert record.numel() == size
        assert record.numpy().tobytes() == expected.numpy().tobytes(), name


def test_kernel_record_fp16_matches_the_shared_packer_on_mapped_actual_weights(
        checkpoint, archive):
    # Every legacy packing branch used by the Small role-subset is exercised.
    roles = (0, 4, 8, 14, 22, 23, 30, 31, 39, 47, 48, 56, 62, 66, 70)
    for role in roles:
        state = _mapped_state(archive, role)
        for spec in SMALL31.records_for_role(role):
            if spec.role in range(31, 39) and spec.layer == 3:
                continue  # native ViT layer-3 slot is unused by the plan
            kind = _expected_kind(role, spec.layer)
            expected = pack_kernel_fp16(state, role, kind)
            actual = checkpoint.kernel_record(role, kind=kind, precision="fp16")
            assert actual.dtype == torch.uint8 and actual.ndim == 1
            assert actual.numpy().tobytes() == expected, (role, spec.layer, kind)


# ---------------------------------------------------------------------------
# Pre/post records and the four-channel head


def test_pre_and_post_records_are_available_in_both_precisions(checkpoint):
    fp8_pre = checkpoint.kernel_record(0, kind="preprocess", precision="fp8")
    fp8_post = checkpoint.kernel_record(70, kind="postprocess", precision="fp8")
    fp16_pre = checkpoint.kernel_record(0, kind="preprocess", precision="fp16")
    fp16_post = checkpoint.kernel_record(70, kind="postprocess", precision="fp16")

    assert fp8_pre.numel() == PREPOST_RECORD_BYTES[("fp8", 0)] == 21_696
    assert fp8_post.numel() == PREPOST_RECORD_BYTES[("fp8", 70)] == 21_808
    assert fp16_pre.numel() == PREPOST_RECORD_BYTES[("fp16", 0)] == 33_984
    assert fp16_post.numel() == PREPOST_RECORD_BYTES[("fp16", 70)] == 34_096
    assert fp8_pre.numpy().tobytes() == bytes(checkpoint.archive.records["block0.layer0.layer"].data)
    assert fp8_post.numpy().tobytes() == bytes(checkpoint.archive.records["block30.layer0.layer"].data)
    # The ordinary-kernel alias and the explicit frontend kind are the same record.
    assert checkpoint.kernel_record(0, kind="window", precision="fp8").numpy().tobytes() == \
        fp8_pre.numpy().tobytes()
    assert checkpoint.kernel_record(70, kind="window", precision="fp16").numpy().tobytes() == \
        fp16_post.numpy().tobytes()


def test_post_head_keeps_all_four_channels_in_both_native_records(checkpoint):
    decoded = checkpoint.decode_block(70)
    assert decoded["head"].shape == (32, 4)  # RGB + 32-half history gate
    head = decoded["head"]
    assert (head != 0).sum(0).tolist() == [32, 32, 32, 32]
    assert float(head[:, 3].abs().max()) > 0

    # FP8: the post record's 1024-byte source region decodes to the same 4x32 head.
    post_fp8 = checkpoint.archive.records["block30.layer0.layer"]
    fp8_head = checkpoint.archive.f16_matrix(post_fp8, SMALL31.post_head.offset, 32, 4)
    assert fp8_head.shape == (32, 4)
    assert torch.equal(fp8_head, head)

    # FP16: independently unpack the tail head region of the packed post record.
    raw = checkpoint.kernel_record(70, kind="postprocess", precision="fp16").numpy()
    packed = raw[-1024:].view("<f2")
    rows = np.arange(32, dtype=np.int64)[:, None]
    columns = np.arange(4, dtype=np.int64)[None, :]
    recovered = np.zeros((32, 4), dtype="<f2")
    recovered[rows, columns] = packed[packed_f16_weight_index(rows, columns, 4)]
    assert torch.equal(torch.from_numpy(recovered.astype(np.float32)), head)


def test_blend_scalar_is_read_from_raw30(checkpoint):
    record = checkpoint.archive.tensor(SMALL31.post_role, parameter="blend_scale")
    assert record.name == "block30.layer0.blend_scale"
    assert len(record.data) == 2
    value = checkpoint.blend_scale()
    assert value.shape == (1,)
    assert float(value[0]) == pytest.approx(0.76708984375)
    assert float(value[0]) != pytest.approx(0.73974609375)  # legacy blend scalar


# ---------------------------------------------------------------------------
# Role-keyed state: no fake legacy blocks


def test_state_has_exactly_31_role_blocks_and_no_fake_legacy_roster(checkpoint):
    state = checkpoint._ensure_state()
    roles = {int(name.split(".", 2)[1]) for name in state}
    assert roles == set(SMALL31.roles)
    assert len(roles) == 31
    # Raw ids and roles are different namespaces: raw 2 is role 4, not role 2.
    assert "blocks.2.w1" not in state
    assert "blocks.4.w1" in state
    assert "blocks.3.w1" not in state  # raw 3 is role 5
    assert "blocks.11.w1" not in state  # raw 11 is role 31
    # The legacy 640-tensor roster is not padded in; only the Small roles exist.
    assert "blocks.39.up_projection" in state
    assert "blocks.70.head" in state
    assert checkpoint.decode_block(70)["head"].shape == (32, 4)
    assert not isinstance(checkpoint, Checkpoint)


# ---------------------------------------------------------------------------
# Corrupted rosters and explicit model selection


def _assert_roster_rejected(checkpoint, monkeypatch, rosters, precision):
    ops = _install_fake_extension(monkeypatch, rosters)
    create = getattr(checkpoint, f"create_plan_{precision}")
    with pytest.raises(ValueError):
        create(_unit_state())
    assert ops.plans == []


def test_corrupted_compiled_rosters_are_rejected(checkpoint, monkeypatch):
    fp8 = _compiled_records("fp8")
    fp16 = _compiled_records("fp16")

    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": fp8[:-1], "fp16": fp16}, "fp8")
    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": fp8, "fp16": fp16[:-1]}, "fp16")

    duplicate = list(fp8)
    duplicate[1] = duplicate[0]
    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": duplicate, "fp16": fp16}, "fp8")

    swapped = list(fp8)
    swapped[0], swapped[1] = swapped[1], swapped[0]
    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": swapped, "fp16": fp16}, "fp8")

    legacy_names = [(f"block{i}.layer0.layer", size) for i, (_, size) in enumerate(fp8, start=1)]
    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": legacy_names, "fp16": fp16}, "fp8")

    wrong_size = [(fp8[0][0], fp8[0][1] + 2)] + list(fp8[1:])
    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": wrong_size, "fp16": fp16}, "fp8")

    # The compiled Half roster must not accept FP8 byte extents.
    fp8_sizes = dict(fp8)
    mixed = [(name, fp8_sizes[name]) for name, _ in fp16]
    _assert_roster_rejected(checkpoint, monkeypatch,
                            {"fp8": fp8, "fp16": mixed}, "fp16")


def test_invalid_role_precision_and_kind_are_rejected(checkpoint):
    with pytest.raises(ValueError):
        checkpoint.kernel_record(2, kind="window", precision="fp8")  # raw id, not a role
    with pytest.raises(ValueError):
        checkpoint.kernel_record(4, kind="window", precision="int8")
    with pytest.raises(NotImplementedError):
        checkpoint.kernel_record(4, kind="qkv", precision="fp8")
    with pytest.raises(ValueError):
        checkpoint.decode_block(2)
    with pytest.raises(TypeError):
        SmallNativeCheckpoint(object())


def test_load_native_model_is_explicit_and_rejects_cross_model(archive, checkpoint):
    # Legacy default is the exact existing loader API (``load_checkpoint``).
    legacy = load_native_model(LEGACY_CHECKPOINT)
    assert isinstance(legacy, Checkpoint) and legacy.precision == "fp16"
    assert load_native_model(legacy) is legacy

    # Small must be selected explicitly; passing the adapter through is exact.
    assert load_native_model(checkpoint, model="small31") is checkpoint

    # Path construction is explicit too and never inferred from shape.
    from_path = load_native_model(SMALL_ARCHIVE, model="small31")
    assert isinstance(from_path, SmallNativeCheckpoint)
    assert from_path.spec.id == "small31"
    assert from_path.manifest_sha256 == archive.manifest_sha256

    with pytest.raises(ValueError):
        load_native_model(SMALL_ARCHIVE)  # default legacy must not guess Small
    with pytest.raises(ValueError):
        load_native_model(SMALL_ARCHIVE, model="legacy71")
    with pytest.raises(ValueError):
        load_native_model(LEGACY_CHECKPOINT, model="small31")
    with pytest.raises(ValueError):
        load_native_model(checkpoint, model="legacy71")
    with pytest.raises(ValueError):
        load_native_model(legacy, model="small31")
    with pytest.raises(ValueError):
        load_native_model(SMALL_ARCHIVE, model="small")
    with pytest.raises(ValueError):
        load_native_model(SMALL_ARCHIVE, model="")
    with pytest.raises(TypeError):
        load_native_model(object())
