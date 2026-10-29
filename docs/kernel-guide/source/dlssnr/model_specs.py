"""Immutable identities for the legacy 71-block and opt-in Small31 graphs.

This module is deliberately standard-library only.  It is the single source of
truth for runtime DLL/resource pins and for the Small raw-record -> legacy
operation-role map.  Raw DLL record ids and operation roles are different
namespaces: Small31 stores 77 records named ``block0`` .. ``block30`` while the
operations they carry belong to legacy roles
``[0, 1, 4, 5, 8, 9, 14, 15, 22, 23, 30, 31, ..., 38, 39, 40, 47, ..., 69, 70]``.

Source basis (read-only research snapshot, not executed here):

* ``lmxxf/DLSS5-RTX-3080-laptop`` pinned commit
  ``fe3f91a2b0e02259b8beed80ae023da3e3ef09be`` (HIP port / PTX patcher v2).
* ``profile/dlss-update-20261029/semantics/mapping.json`` and the three review
  reports in ``profile/dlss-update-20261029``.

The Small graph is a research reconstruction of a separately trained model.  It
is not a vendor numerical oracle and the phase/role decisions marked
"source-derived" were not verified by executing the DLL host dispatch.  No
NVIDIA weights or executable bytes are embedded here.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable

from .records import expected_record_sizes as _legacy_record_sizes


class ModelSpecError(ValueError):
    """Raised when a model identity or roster is internally inconsistent."""


@dataclass(frozen=True)
class DllPin:
    """One accepted original runtime identity (exact SHA-256 and byte length)."""

    version: str
    sha256: str
    byte_length: int
    note: str = ""


@dataclass(frozen=True)
class ResourcePin:
    """Exact PE resource identity and envelope totals for one model."""

    type_id: int
    name: str
    language: int
    byte_length: int
    sha256: str
    record_count: int
    payload_bytes: int

    @property
    def path(self) -> str:
        return f"{self.type_id}/{self.name}/{self.language}"


@dataclass(frozen=True)
class StageSpec:
    """A packed stage.  ``roles`` are operation roles, never raw record ids."""

    id: str
    kind: str
    roles: tuple[int, ...]


@dataclass(frozen=True)
class RolePhase:
    """Small31 window phase and its provenance for one operation role."""

    role: int
    shift_mask: int | None
    phase: int | None
    provenance: str


@dataclass(frozen=True)
class StagePin:
    """Trusted canonical packed-stage byte length and SHA-256.

    These pins are the verification anchor for full Small31 archives.  They are
    taken from the locally verified original 310.9.16 resource, so a rehashed
    manifest cannot silently swap equal-sized record/stage payloads.  Record
    positions are independently anchored to :meth:`ModelSpec.stage_record_offsets`,
    which is derived from the immutable roster and the extractor's exact
    ``(raw_block, layer, parameter)`` packing order.
    """

    id: str
    byte_length: int
    sha256: str


@dataclass(frozen=True)
class PostHeadSpec:
    """Source-verified final post head layout.

    The post record stores 512 f16 values in a 16x32 region starting at
    ``offset``.  The HIP scatter selects storage rows ``used_rows`` in order;
    storage rows 0,2,4 are the 96 RGB values and storage row 6 is the 32-half
    history gate.  The resulting logical ``native_shape`` is 4x32, so logical
    rows 0..2 are RGB and logical row 3 is the history gate.  The PyTorch graph
    reuses the legacy ``head[32,4]`` decode (NRBlock transposes it to ``[4,32]``);
    this metadata documents the native scatter rather than defining a different
    natural basis.  ``history_row`` is the storage row; the logical gate column
    is ``used_rows.index(history_row) == 3``.
    """

    offset: int
    byte_length: int
    storage_shape: tuple[int, int]
    row_bits: tuple[int, ...]
    column_bits: tuple[int, ...]
    used_rows: tuple[int, ...]
    native_shape: tuple[int, int]
    history_row: int
    history_byte_length: int
    provenance: str


@dataclass(frozen=True)
class RecordSpec:
    """Expected raw record identity, role mapping and byte extent."""

    name: str
    raw_block: int
    role: int
    layer: int
    parameter: str
    byte_length: int
    stage: str


@dataclass(frozen=True)
class ModelSpec:
    """Frozen model identity and roster.  Construct through :func:`make_model_spec`."""

    id: str
    display_name: str
    runtime_version: str
    block_count: int
    record_count: int
    payload_bytes: int
    resource: ResourcePin
    dll_pins: tuple[DllPin, ...]
    roles: tuple[int, ...]
    raw_to_role: tuple[int, ...]
    role_to_raw: tuple[tuple[int, int], ...]
    stages: tuple[StageSpec, ...]
    records: tuple[RecordSpec, ...]
    pre_role: int
    post_role: int
    transition_role: int | None
    post_phase_default: int
    role_phases: tuple[RolePhase, ...]
    phase_provenance: str
    source_provenance: tuple[str, ...]
    post_head: PostHeadSpec | None
    notes: tuple[str, ...] = ()
    stage_pins: tuple[StagePin, ...] = ()

    def role_for_raw(self, raw_block: int) -> int:
        """Map a raw DLL record block id to its legacy operation role."""
        if isinstance(raw_block, bool) or not isinstance(raw_block, int):
            raise TypeError("raw_block must be an int")
        if not 0 <= raw_block < len(self.raw_to_role):
            raise ValueError(f"raw block {raw_block} is outside [0, {len(self.raw_to_role)})")
        return self.raw_to_role[raw_block]

    def raw_for_role(self, role: int) -> int:
        """Map a legacy operation role to the raw DLL record block id."""
        if isinstance(role, bool) or not isinstance(role, int):
            raise TypeError("role must be an int")
        for known, raw in self.role_to_raw:
            if known == role:
                return raw
        raise ValueError(f"role {role} is not present in model {self.id!r}")

    def has_role(self, role: int) -> bool:
        return any(known == role for known, _ in self.role_to_raw)

    def stage_for_role(self, role: int) -> StageSpec:
        for stage in self.stages:
            if role in stage.roles:
                return stage
        raise ValueError(f"role {role} is not assigned to a stage in model {self.id!r}")

    def phase_for_role(self, role: int) -> int | None:
        for item in self.role_phases:
            if item.role == role:
                return item.phase
        raise ValueError(f"role {role} has no phase entry in model {self.id!r}")

    def shift_mask_for_role(self, role: int) -> int | None:
        for item in self.role_phases:
            if item.role == role:
                return item.shift_mask
        raise ValueError(f"role {role} has no phase entry in model {self.id!r}")

    def expected_record_names(self) -> frozenset[str]:
        return frozenset(record.name for record in self.records)

    def expected_record_sizes(self) -> dict[str, int]:
        return {record.name: record.byte_length for record in self.records}

    def record_spec(self, name: str) -> RecordSpec:
        for record in self.records:
            if record.name == name:
                return record
        raise ValueError(f"record {name!r} is not part of model {self.id!r}")

    def stage_record_offsets(self) -> dict[str, dict[str, int]]:
        """Return canonical packed offsets for every record, keyed by stage.

        The versioned extractor packs each stage by sorting its records with
        ``(raw_block, layer, parameter)``.  This immutable roster is therefore
        the only trusted source for a record's byte position; a manifest cannot
        re-anchor equal-sized records by editing only ``stageOffset``.
        """
        result: dict[str, dict[str, int]] = {stage.id: {} for stage in self.stages}
        for stage in self.stages:
            cursor = 0
            records = sorted(
                (record for record in self.records if record.stage == stage.id),
                key=lambda record: (record.raw_block, record.layer, record.parameter),
            )
            for record in records:
                result[stage.id][record.name] = cursor
                cursor += record.byte_length
        return result

    def records_for_role(self, role: int) -> tuple[RecordSpec, ...]:
        return tuple(record for record in self.records if record.role == role)

    def next_role(self, role: int) -> int | None:
        for index, known in enumerate(self.roles):
            if known == role:
                return self.roles[index + 1] if index + 1 < len(self.roles) else None
        raise ValueError(f"role {role} is not present in model {self.id!r}")


def _records_for(raw_to_role: tuple[int, ...], stage_for_role: dict[int, str]) -> tuple[RecordSpec, ...]:
    """Rename legacy role records to raw DLL names without copying layout data."""
    legacy_sizes = _legacy_record_sizes()
    role_records: dict[int, list[tuple[int, str, str, int]]] = {}
    for name, size in legacy_sizes.items():
        head, remainder = name.split(".", 1)
        role = int(head[len("block"):])
        layer_text, parameter = remainder.split(".", 1)
        layer = int(layer_text[len("layer"):])
        role_records.setdefault(role, []).append((layer, parameter, name, size))

    records: list[RecordSpec] = []
    for raw_block, role in enumerate(raw_to_role):
        if role not in stage_for_role:
            raise ModelSpecError(f"role {role} has no stage assignment")
        for layer, parameter, legacy_name, size in sorted(role_records.get(role, []), key=lambda item: (item[0], item[1])):
            suffix = legacy_name[len(f"block{role}"):]
            records.append(RecordSpec(
                name=f"block{raw_block}{suffix}",
                raw_block=raw_block,
                role=role,
                layer=layer,
                parameter=parameter,
                byte_length=size,
                stage=stage_for_role[role],
            ))
    records.sort(key=lambda item: (item.raw_block, item.layer, item.parameter))
    return tuple(records)


def make_model_spec(
    *,
    id: str,
    display_name: str,
    runtime_version: str,
    resource: ResourcePin,
    dll_pins: Iterable[DllPin],
    roles: Iterable[int],
    raw_to_role: Iterable[int],
    stages: Iterable[StageSpec],
    pre_role: int,
    post_role: int,
    transition_role: int | None = None,
    post_phase_default: int = 0,
    role_phases: Iterable[RolePhase] = (),
    phase_provenance: str = "",
    source_provenance: Iterable[str] = (),
    post_head: PostHeadSpec | None = None,
    notes: Iterable[str] = (),
    stage_pins: Iterable[StagePin] = (),
    record_count: int | None = None,
    payload_bytes: int | None = None,
    block_count: int | None = None,
) -> ModelSpec:
    """Build and validate a frozen model spec, deriving the exact record roster."""
    stage_tuple = tuple(stages)
    stage_for_role: dict[int, str] = {}
    for stage in stage_tuple:
        for role in stage.roles:
            if role in stage_for_role:
                raise ModelSpecError(f"role {role} appears in more than one stage")
            stage_for_role[role] = stage.id
    raw_tuple = tuple(raw_to_role)
    records = _records_for(raw_tuple, stage_for_role)
    computed_payload = sum(record.byte_length for record in records)
    spec = ModelSpec(
        id=id,
        display_name=display_name,
        runtime_version=runtime_version,
        block_count=len(raw_tuple) if block_count is None else block_count,
        record_count=len(records) if record_count is None else record_count,
        payload_bytes=computed_payload if payload_bytes is None else payload_bytes,
        resource=resource,
        dll_pins=tuple(dll_pins),
        roles=tuple(roles),
        raw_to_role=raw_tuple,
        role_to_raw=tuple(sorted(((role, raw) for raw, role in enumerate(raw_tuple)), key=lambda item: item[0])),
        stages=stage_tuple,
        records=records,
        pre_role=pre_role,
        post_role=post_role,
        transition_role=transition_role,
        post_phase_default=post_phase_default,
        role_phases=tuple(role_phases),
        phase_provenance=phase_provenance,
        source_provenance=tuple(source_provenance),
        post_head=post_head,
        notes=tuple(notes),
        stage_pins=tuple(stage_pins),
    )
    _validate_spec(spec)
    return spec


def _validate_spec(spec: ModelSpec) -> None:
    if not spec.id or not isinstance(spec.id, str):
        raise ModelSpecError("model id must be a non-empty string")
    if spec.block_count < 1 or spec.record_count < 1:
        raise ModelSpecError("model must have at least one block and one record")
    if len(spec.raw_to_role) != spec.block_count:
        raise ModelSpecError("raw_to_role length differs from block_count")
    if len(spec.records) != spec.record_count:
        raise ModelSpecError("record roster length differs from record_count")
    if sum(record.byte_length for record in spec.records) != spec.payload_bytes:
        raise ModelSpecError("record byte lengths differ from the pinned payload total")
    if spec.resource.record_count != spec.record_count:
        raise ModelSpecError("resource record_count pin differs from the model roster")
    if spec.resource.payload_bytes != spec.payload_bytes:
        raise ModelSpecError("resource payload pin differs from the model roster")

    roles = tuple(spec.roles)
    if len(set(roles)) != len(roles):
        raise ModelSpecError("operation roles must be unique")
    if tuple(sorted(roles)) != roles:
        raise ModelSpecError("operation roles must be stored in ascending order")
    if sorted(spec.raw_to_role) != list(roles):
        raise ModelSpecError("raw_to_role must be a bijection onto the operation roles")
    inverse = dict(spec.role_to_raw)
    if len(inverse) != len(spec.role_to_raw):
        raise ModelSpecError("role_to_raw contains duplicate roles")
    if any(inverse.get(role) != raw for raw, role in enumerate(spec.raw_to_role)):
        raise ModelSpecError("role_to_raw is not the inverse of raw_to_role")

    stage_ids = [stage.id for stage in spec.stages]
    if len(set(stage_ids)) != len(stage_ids):
        raise ModelSpecError("stage ids must be unique")
    staged_roles = [role for stage in spec.stages for role in stage.roles]
    if sorted(staged_roles) != list(roles):
        raise ModelSpecError("stages must partition the operation roles")
    if spec.pre_role not in roles or spec.post_role not in roles:
        raise ModelSpecError("pre_role and post_role must be present")
    if spec.transition_role is not None and spec.transition_role not in roles:
        raise ModelSpecError("transition_role must be an operation role or None")
    if spec.post_phase_default not in range(4):
        raise ModelSpecError("post_phase_default must be 0..3")

    names = [record.name for record in spec.records]
    if len(set(names)) != len(names):
        raise ModelSpecError("record names must be unique")
    raw_ids = {record.raw_block for record in spec.records}
    if raw_ids != set(range(spec.block_count)):
        raise ModelSpecError("records must cover every raw block id exactly once")
    if {record.role for record in spec.records} != set(roles):
        raise ModelSpecError("records must cover every operation role")
    for record in spec.records:
        if record.role != spec.raw_to_role[record.raw_block]:
            raise ModelSpecError(f"record {record.name} disagrees with raw_to_role")
        if record.stage not in stage_ids:
            raise ModelSpecError(f"record {record.name} references an unknown stage")
        if record.byte_length < 1:
            raise ModelSpecError(f"record {record.name} has a non-positive byte length")

    if spec.role_phases:
        if len(spec.role_phases) != len(roles) or {item.role for item in spec.role_phases} != set(roles):
            raise ModelSpecError("role_phases must cover every operation role exactly once")
        for item in spec.role_phases:
            if item.phase is not None and item.phase not in range(4):
                raise ModelSpecError(f"role {item.role} has an invalid phase")
            if item.shift_mask is not None and item.shift_mask not in range(4):
                raise ModelSpecError(f"role {item.role} has an invalid shift mask")

    if spec.id == "legacy71" and spec.raw_to_role != tuple(range(71)):
        raise ModelSpecError("legacy71 must use identity raw -> role mapping")

    if spec.stage_pins:
        pinned_ids = [pin.id for pin in spec.stage_pins]
        if pinned_ids != stage_ids:
            raise ModelSpecError("stage_pins must list every stage once, in model stage order")
        pinned_bytes = 0
        for pin in spec.stage_pins:
            if type(pin.byte_length) is not int or pin.byte_length < 1:
                raise ModelSpecError(f"stage pin {pin.id} has an invalid byte length")
            if not isinstance(pin.sha256, str) or len(pin.sha256) != 64:
                raise ModelSpecError(f"stage pin {pin.id} has an invalid SHA-256")
            roster_bytes = sum(record.byte_length for record in spec.records if record.stage == pin.id)
            if roster_bytes != pin.byte_length:
                raise ModelSpecError(
                    f"stage pin {pin.id} byte length {pin.byte_length} differs from its "
                    f"canonical record roster {roster_bytes}")
            pinned_bytes += pin.byte_length
        if pinned_bytes != spec.payload_bytes:
            raise ModelSpecError("stage pin byte lengths differ from the model payload total")


# ---------------------------------------------------------------------------
# Exact pins from the 310.8.0.0 and 310.9.16 review evidence.

_W310_8 = DllPin(
    version="310.8.0.0",
    sha256="e16bcf15e16e13f527491cdf7845b2fe6521a738d8f7c9c721866a8496e1fc8e",
    byte_length=165_840_496,
    note="local original execution pin; WEIGHTS_HT resource is byte-identical in 310.9.16",
)
_W310_9_16 = DllPin(
    version="310.9.16.0",
    sha256="2bc19bc09a7b89dd44f73e2ac0108fcc586e2154bdd0830f242f4f040e28789f",
    byte_length=266_424_944,
    note="original signed 310.9.16 runtime; community-patched DLLs are not accepted",
)

_HT_RESOURCE = ResourcePin(
    type_id=10,
    name="WEIGHTS_HT",
    language=1033,
    byte_length=147_695_410,
    sha256="836f445d06ecd2e59bb9f17b84b91c143396fd76ccda1c9dc7fe81d5edd548f4",
    record_count=153,
    payload_bytes=147_683_778,
)
_SMALL_RESOURCE = ResourcePin(
    type_id=10,
    name="WEIGHTS_CC_SMALL_FP8",
    language=1033,
    byte_length=113_893_343,
    sha256="f743e8eb320f42bc9bdc992ee2bf51f7bb7c8688ced4ecf5ce6807ec4eef7962",
    record_count=77,
    payload_bytes=113_887_490,
)

_LEGACY_STAGES = (
    StageSpec("encoder32", "encoder", tuple(range(0, 5))),
    StageSpec("encoder64", "encoder", tuple(range(5, 9))),
    StageSpec("encoder128", "encoder", tuple(range(9, 15))),
    StageSpec("encoder256", "encoder", tuple(range(15, 23))),
    StageSpec("encoder512", "encoder", tuple(range(23, 31))),
    StageSpec("vit1024", "vit", tuple(range(31, 39))),
    StageSpec("decoder512", "decoder", tuple(range(39, 48))),
    StageSpec("decoder256", "decoder", tuple(range(48, 56))),
    StageSpec("decoder128", "decoder", tuple(range(56, 62))),
    StageSpec("decoder64", "decoder", tuple(range(62, 66))),
    StageSpec("decoder32", "decoder", tuple(range(66, 71))),
)

_SMALL_RAW_TO_ROLE = (
    0, 1, 4, 5, 8, 9, 14, 15, 22, 23, 30,
    31, 32, 33, 34, 35, 36, 37, 38, 39,
    40, 47, 48, 55, 56, 61, 62, 65, 66, 69, 70,
)

_SMALL_STAGES = (
    StageSpec("encoder32", "encoder", (0, 1, 4)),
    StageSpec("encoder64", "encoder", (5, 8)),
    StageSpec("encoder128", "encoder", (9, 14)),
    StageSpec("encoder256", "encoder", (15, 22)),
    StageSpec("encoder512", "encoder", (23, 30)),
    StageSpec("vit1024", "vit", tuple(range(31, 39))),
    StageSpec("decoder512", "decoder", (39, 40, 47)),
    StageSpec("decoder256", "decoder", (48, 55)),
    StageSpec("decoder128", "decoder", (56, 61)),
    StageSpec("decoder64", "decoder", (62, 65)),
    StageSpec("decoder32", "decoder", (66, 69, 70)),
)

_SMALL_PHASE_SOURCE = (
    "source-derived from the pinned HIP port (fe3f91a2): encoder pairs use shift "
    "masks 0 then 3, decoder first/last pairs use masks 1 then 2, with local "
    "phase = {0:0, 3:1, 1:2, 2:3}. Not verified against DLL host dispatch."
)


_SMALL_STAGE_PINS = (
    StagePin("encoder32", 65_088, "c6b7b9e2f51c1f7811627d12b682df7fbcde8800bb79d6ea701040c93ba78575"),
    StagePin("encoder64", 131_696, "9db6fe4d8d79aefcb73453c1361b1c6f06e63c491662d4a8203ac81a97ad62ff"),
    StagePin("encoder128", 427_120, "70b29d83f12b4d4cd9bedebb48a37954e6e8b0ce6a527400b01580a2bb67780e"),
    StagePin("encoder256", 1_509_520, "a59295a3469a6f883bbe443828e4234b2c9421ab81c642a2d13676f2130f0505"),
    StagePin("encoder512", 4_460_688, "229bf915d337c2a40143d168f7e49cf405972ab80bcad662b2a9263932ae48ed"),
    StagePin("vit1024", 100_697_232, "95547aa7413d17da9c1119cfb02d9fdd2f018c02d0f8a4f3ceafebc7627a041d"),
    StagePin("decoder512", 4_461_696, "d039e9a080812e6f1e31efea10186f96394d33411931dda8f0e3a3eca6b6d403"),
    StagePin("decoder256", 1_510_016, "0cadbfe30b1a716fbf25a03b8238395dc2bae266e418f3338ffd215760fffcf0"),
    StagePin("decoder128", 427_360, "6f07a2dfed60bbd2dec508164c6d64a26e71d8dcf553460e55ea9c8921e259c3"),
    StagePin("decoder64", 131_808, "951b3ae290b1cd17f6892abf01c0acfc0d5208c049b55c1402b96e823d4261c2"),
    StagePin("decoder32", 65_266, "f47ec694f183de2ab8157d02beb66eb9beca114b70133c56d26769c7b80068b2"),
)


def _small_role_phases() -> tuple[RolePhase, ...]:
    phases: dict[int, tuple[int | None, int | None, str]] = {}
    phases[0] = (0, 0, "input shift 0 (source-derived default; host descriptor unobserved)")
    encoder_pairs = ((1, 4), (5, 8), (9, 14), (15, 22), (23, 30))
    for first, last in encoder_pairs:
        phases[first] = (0, 0, "encoder first: source-derived HIP mask 0 -> phase 0")
        phases[last] = (3, 1, "encoder tail: source-derived HIP mask 3 -> phase 1")
    for role in range(31, 39):
        phases[role] = (None, None, "global attention; no window phase")
    phases[39] = (None, None, "transition-only record; no window phase")
    decoder_pairs = ((40, 47), (48, 55), (56, 61), (62, 65), (66, 69))
    for first, last in decoder_pairs:
        phases[first] = (1, 2, "decoder first: source-derived HIP mask 1 -> phase 2")
        phases[last] = (2, 3, "decoder last: source-derived HIP mask 2 -> phase 3")
    phases[70] = (0, 0, "post uses host post_shift replay; default 0 is configurable and unverified")
    return tuple(RolePhase(role=role, shift_mask=mask, phase=phase, provenance=provenance)
                 for role, (mask, phase, provenance) in sorted(phases.items()))


_LEGACY_PROVENANCE = (
    "Existing 310.8 71-block local path. Geometry phases come from "
    "dlssnr.geometry.graph_schedule and are intentionally unchanged.",
)
_SMALL_PROVENANCE = (
    "Record names/sizes and role order are from the pinned semantics mapping "
    "(profile/dlss-update-20261029/semantics/mapping.json).",
    "Small is a separately trained model, not a pruning of the 71-block weights.",
    "Raw DLL block ids 0..30 are not legacy operation roles; use raw_to_role.",
    "Window phases and geometry/ViT dispatch are source-derived research "
    "reconstructions awaiting DLL host evidence.",
    "The post head is the legacy 4x32 logical head (RGB plus a 32-half history "
    "gate); the HIP 16x32 scatter rows 0,2,4,6 are the same values in the native "
    "packing, so the Small graph reuses the unmodified legacy head decode.",
    "The grouped C64-C256 FFN expert indexing is equivalent to the HIP dense "
    "block-diagonal description per layout-review; full native FP16 FFN oracle "
    "parity remains unexecuted.",
    "This graph is a floating PyTorch training reconstruction, not a numerical oracle "
    "and not a native FP16/FP8 deployment path.",
)

_POST_HEAD = PostHeadSpec(
    offset=20784,
    byte_length=1024,
    storage_shape=(16, 32),
    row_bits=(2, 5, 6, 7),
    column_bits=(0, 1, 3, 4, 8),
    used_rows=(0, 2, 4, 6),
    native_shape=(4, 32),
    history_row=6,
    history_byte_length=64,
    provenance=(
        "Layout verified by layout-review against the original 310.9.16 Small "
        "record, the FP8 postprocess kernel and an FP16 cubin probe: the HIP "
        "16x32 scatter has nonzeros only in storage rows 0,2,4,6; rows 0,2,4 are "
        "the 96 RGB values and row 6 is the 32-half history gate, so the selected "
        "logical head is 4x32 (RGB + gate) and matches the local head[32,4] "
        "decode under the same packing permutation. PyTorch math remains a "
        "floating surrogate."
    ),
)


LEGACY71 = make_model_spec(
    id="legacy71",
    display_name="DLSS-NR 71-block legacy (WEIGHTS_HT)",
    runtime_version="310.8.0.0 or 310.9.16.0",
    resource=_HT_RESOURCE,
    dll_pins=(_W310_8, _W310_9_16),
    roles=tuple(range(71)),
    raw_to_role=tuple(range(71)),
    stages=_LEGACY_STAGES,
    pre_role=0,
    post_role=70,
    transition_role=39,
    post_phase_default=1,
    role_phases=(),
    phase_provenance=_LEGACY_PROVENANCE,
    source_provenance=(
        "Existing local 71-block roster and layouts are the default and are not modified.",
        "WEIGHTS_HT is byte-identical between 310.8.0.0 and 310.9.16.",
    ),
    post_head=None,
    notes=("Legacy extraction keeps the existing 11-stage manifest roster so the old "
           "dlssnr.weights.WeightArchive remains able to read it.",),
)

SMALL31 = make_model_spec(
    id="small31",
    display_name="DLSS-NR Small31 research reconstruction (WEIGHTS_CC_SMALL_FP8)",
    runtime_version="310.9.16.0",
    resource=_SMALL_RESOURCE,
    dll_pins=(_W310_9_16,),
    roles=tuple(sorted(_SMALL_RAW_TO_ROLE)),
    raw_to_role=_SMALL_RAW_TO_ROLE,
    stages=_SMALL_STAGES,
    pre_role=0,
    post_role=70,
    transition_role=39,
    post_phase_default=0,
    role_phases=_small_role_phases(),
    phase_provenance=_SMALL_PHASE_SOURCE,
    source_provenance=_SMALL_PROVENANCE,
    post_head=_POST_HEAD,
    stage_pins=_SMALL_STAGE_PINS,
    notes=(
        "Encoded by raw block ids 0..30; operation roles are a separate namespace.",
        "Only the original 310.9.16 DLL is accepted.",
        "The 11 packed stages mirror the live 310.9.16 extraction: encoder32 also "
        "carries the pre role and decoder32 also carries the post role, exactly like "
        "the legacy stage vocabulary. Pre/post roles remain explicit in the spec.",
        "Stage pins anchor full archives to the verified original 310.9.16 bytes.",
        "Native scheduling, sub-tensor layout and numerical equivalence are not claimed.",
    ),
)

MODEL_SPECS = {"legacy71": LEGACY71, "small31": SMALL31}


def resolve_model(model: str) -> ModelSpec:
    """Resolve one of the explicit known model names; never falls back."""
    if not isinstance(model, str):
        raise TypeError("model name must be a string")
    key = model.strip().lower()
    try:
        return MODEL_SPECS[key]
    except KeyError as exc:
        raise ValueError(f"unknown model {model!r}; expected one of {sorted(MODEL_SPECS)}") from exc


def expected_record_names(spec: ModelSpec = LEGACY71) -> frozenset[str]:
    return spec.expected_record_names()


def expected_record_sizes(spec: ModelSpec = LEGACY71) -> dict[str, int]:
    return spec.expected_record_sizes()
