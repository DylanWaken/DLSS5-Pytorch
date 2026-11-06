"""Strict, versioned acceptance evidence for the current FlashLight chapter.

The canonical future input is
``docs/kernel-guide/evidence-flashlight/acceptance.json``.  Root/build owns its
production; this module only defines the loader, the identity/artifact
validation and the derived display rows.  A small ptxas-only record is *not*
full runtime acceptance and is rejected by this schema.

Design rules:

* all public artifact links are safe repository/bundle-relative POSIX paths;
* no native binary, executable or checkpoint payload is published: a small
  build receipt records the binary filename/hash that a reader cannot inspect
  locally, and public validation never needs a private payload path;
* the acceptance file and every registered artifact are verified byte-for-byte
  against their recorded SHA-256 before any generated output is written;
* a build's input-manifest receipt is the canonical measured source-input
  representation; the acceptance rows must equal that manifest exactly, and
  the measured normalized-LF content of every row is re-read from the
  attributed implementation commit - a revision string is never trusted;
* raw file bytes, normalized content and Git's blob object id stay distinct;
* original build-time HEAD/worktree are recorded only as preserved receipts,
  explicit inference or honest unknowns; they are never forced to equal the
  frozen source-replay snapshot;
* the sixteen timing rows are the exact model/precision/resolution matrix and
  each arm carries exactly four process medians for the fixed eight-process
  protocol.  Displayed medians and speedups are derived, never stored twice;
* compiler/static ptxas data is kept separate from measured runtime data and
  from cuobjdump's separate SM120 reserved region.

Only the standard library is used.
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
import json
import math
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import statistics
import subprocess

from output_paths import repository_guide_root
from source_providers import (
    COMMIT_RE,
    ROOT,
    read_blob,
    require_commit,
    validated_commit,
)

SCHEMA_VERSION = 1
ACCEPTED_STATE = "accepted"

#: The frozen source-replay snapshot used by the original arm.  This commits the
#: replay inputs; it is *not* automatically the original binary's build checkout.
#: The two facts are recorded separately in ``original_build``.
ORIGINAL_SOURCE_REVISION = "e2741a72b390f830de810e6f1180369ed52eb325"

#: Explicit CLI > this environment variable > the canonical checked-in file.
ENVIRONMENT_VARIABLE = "DLSSNR_FLASHLIGHT_EVIDENCE"
EVIDENCE_ENVIRONMENT_VARIABLE = ENVIRONMENT_VARIABLE
CANONICAL_RELATIVE_PATH = PurePosixPath("evidence-flashlight/acceptance.json")

MODELS = ("legacy71", "small31")
PRECISIONS = ("fp16", "fp8")
SIZES = (
    ("720p", 1280, 720),
    ("1080p", 1920, 1080),
    ("2k", 2560, 1440),
    ("4k", 3840, 2160),
)
CASE_COUNT = 16
PROCESSES_PER_CASE = 8
ARM_PROCESSES = 4
#: The fixed balanced block orders from the accepted protocol: ABBA then BAAB,
#: or the reverse traversal.  Four process medians per arm are paired in this
#: order; an arbitrary 4+4 split is not the recorded protocol.
PROCESS_ORDERS = (
    ("original", "candidate", "candidate", "original",
     "candidate", "original", "original", "candidate"),
    ("candidate", "original", "original", "candidate",
     "original", "candidate", "candidate", "original"),
)

#: The fixed acceptance gates.  A compiler-only result cannot substitute for
#: any of these; every category must be a passing receipt-backed check.
REQUIRED_CHECK_CATEGORIES = (
    "cpu",
    "native-bitwise",
    "cuda-graphs",
    "guards",
    "checkpoint",
    "training",
    "rgb",
    "primitives",
)

CASE_DECISIONS = (
    "accepted",
    "no-detected-slowdown",
    "inconclusive",
    "reproducible-slowdown",
    "rejected",
)
#: An accepted timing report cannot simultaneously record an unresolved or
#: reproducible slowdown.  These are protocol decisions, not a pass threshold.
ACCEPTED_CASE_DECISIONS = ("accepted", "no-detected-slowdown")

ARTIFACT_KINDS = frozenset({
    "build-receipt",
    "input-manifest",
    "timing-receipt",
    "check-receipt",
    "ptxas-log",
    "cuobjdump",
    "ncu-report",
})
#: Public receipts/manifests are text artifacts.  Native payloads, tool
#: executables and checkpoint weights must never be copied into the guide.
FORBIDDEN_ARTIFACT_SUFFIXES = frozenset({
    ".pyd", ".so", ".dll", ".exe", ".pt", ".pth", ".ckpt", ".cubin",
    ".fatbin", ".bin",
})
PROVENANCE_BASES = ("preserved-receipt", "inferred", "unknown")
BUILD_RECEIPT_SCHEMA = "flashlight-build-receipt-v1"
MEASURED_MANIFEST_SCHEMA = "flashlight-measured-input-manifest-v1"
_IDENTITY_RE = re.compile(
    r"^(?:original|candidate|environment|timing|ptxas|ncu|source|check:[a-z0-9-]+)$")
_COMMIT_RE = re.compile(COMMIT_RE)
_SAFE_PATH_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._/-]*$")
_HEX64_RE = re.compile(r"[0-9a-f]{64}")
_ACCEPTANCE_ID_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]+$")
_ARCHITECTURES = ("SM80", "SM86", "SM89", "SM120")
_SM_TARGETS = ("sm_80", "sm_86", "sm_89", "sm_120")
_TOOLCHAIN_KEYS = (
    "nvcc_version",
    "nvcc_sha256",
    "ptxas_version",
    "ptxas_sha256",
    "cuda_version",
    "pytorch_version",
)


class EvidenceError(ValueError):
    """A supplied acceptance record is malformed, incomplete or misattributed."""


# ---------------------------------------------------------------------------
# Small strict parser helpers
# ---------------------------------------------------------------------------


def _object(value, label, required, optional=()):
    if not isinstance(value, dict):
        raise EvidenceError(f"{label} must be a JSON object")
    required = tuple(required)
    allowed = set(required) | set(optional)
    missing = [key for key in required if key not in value]
    if missing:
        raise EvidenceError(f"{label} is missing keys: {', '.join(missing)}")
    extra = sorted(set(value) - allowed)
    if extra:
        raise EvidenceError(f"{label} has unexpected keys: {', '.join(extra)}")
    return value


def _list(value, label, *, length=None, minimum=None):
    if not isinstance(value, list):
        raise EvidenceError(f"{label} must be a JSON array")
    if length is not None and len(value) != length:
        raise EvidenceError(f"{label} must have exactly {length} entries, found {len(value)}")
    if minimum is not None and len(value) < minimum:
        raise EvidenceError(f"{label} must have at least {minimum} entries, found {len(value)}")
    return value


def _string(value, label, *, minimum=1):
    if not isinstance(value, str) or len(value.strip()) < minimum:
        raise EvidenceError(f"{label} must be a non-empty string")
    return value


def _bool(value, label):
    if not isinstance(value, bool):
        raise EvidenceError(f"{label} must be a JSON boolean")
    return value


def _int(value, label, *, minimum=None):
    if isinstance(value, bool) or not isinstance(value, int):
        raise EvidenceError(f"{label} must be an integer")
    if minimum is not None and value < minimum:
        raise EvidenceError(f"{label} must be >= {minimum}, got {value}")
    return value


def _number(value, label, *, positive=False, nonnegative=False):
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise EvidenceError(f"{label} must be a finite number")
    number = float(value)
    if not math.isfinite(number):
        raise EvidenceError(f"{label} must be finite")
    if positive and number <= 0:
        raise EvidenceError(f"{label} must be > 0, got {number}")
    if nonnegative and number < 0:
        raise EvidenceError(f"{label} must be >= 0, got {number}")
    return number


def _enum(value, label, allowed):
    if value not in allowed:
        raise EvidenceError(f"{label} must be one of {allowed}, got {value!r}")
    return value


def _hex64(value, label):
    if not isinstance(value, str) or _HEX64_RE.fullmatch(value) is None:
        raise EvidenceError(f"{label} must be a lowercase 64-character SHA-256")
    return value


def _commit(value, label):
    if not isinstance(value, str) or _COMMIT_RE.fullmatch(value) is None:
        raise EvidenceError(f"{label} must be a full lowercase 40-character git SHA-1")
    return value


def _safe_path(value, label):
    if not isinstance(value, str) or not value:
        raise EvidenceError(f"{label} must be a non-empty relative POSIX path")
    if "\\" in value or ":" in value or value.startswith("/"):
        raise EvidenceError(f"{label} must be a relative POSIX path, got {value!r}")
    parts = value.split("/")
    if any(part in ("", ".", "..") for part in parts):
        raise EvidenceError(f"{label} escapes its bundle: {value!r}")
    if _SAFE_PATH_RE.fullmatch(value) is None:
        raise EvidenceError(f"{label} contains unsupported characters: {value!r}")
    return PurePosixPath(value)


def format_ms(value):
    """Stable display form shared by the renderer and independent validator."""
    return f"{float(value):.3f}"


def format_speedup(value):
    return f"{float(value):.3f}×"


def format_range(low, high):
    return f"{format_ms(low)}–{format_ms(high)}"


def _digest_rows(rows):
    payload = json.dumps(rows, sort_keys=True, separators=(",", ":"), ensure_ascii=False)
    return hashlib.sha256(payload.encode("utf-8")).hexdigest()


def _no_duplicate_keys(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise EvidenceError(f"acceptance JSON repeats the key {key!r}")
        result[key] = value
    return result


# ---------------------------------------------------------------------------
# Typed records
# ---------------------------------------------------------------------------


@dataclass(frozen=True)
class Artifact:
    path: str
    sha256: str
    kind: str
    identity: str


@dataclass(frozen=True)
class BuildIdentity:
    provenance_basis: str
    provenance_note: str
    build_time_head: str | None
    dirty: bool | None
    build_receipt: Artifact
    input_manifest: Artifact
    input_files: tuple
    binary_filename: str
    binary_sha256: str
    toolchain: dict

    def toolchain_pairs(self):
        return tuple((key, self.toolchain[key]) for key in _TOOLCHAIN_KEYS)


@dataclass(frozen=True)
class ProvenanceFile:
    path: str
    raw_file_sha256: str
    normalized_lf_sha256: str
    git_blob_oid: str | None


@dataclass(frozen=True)
class Environment:
    gpu_name: str
    gpu_uuid: str
    driver: str
    cuda: str
    pytorch: str
    timing_method: str
    seed: int
    warmup: int
    samples: int
    iterations: int
    rounds: int
    methodology: str


@dataclass(frozen=True)
class Protocol:
    child_processes_per_case: int
    original_processes: int
    candidate_processes: int
    process_order: tuple
    methodology: str


@dataclass(frozen=True)
class TimingCase:
    id: str
    model: str
    precision: str
    size: str
    width: int
    height: int
    original_process_medians_ms: tuple
    candidate_process_medians_ms: tuple
    original_range_ms: tuple
    candidate_range_ms: tuple
    uncertainty_method: str
    decision_status: str
    decision_rationale: str

    @property
    def original_median_ms(self):
        return float(statistics.median(self.original_process_medians_ms))

    @property
    def candidate_median_ms(self):
        return float(statistics.median(self.candidate_process_medians_ms))

    @property
    def speedup(self):
        return self.original_median_ms / self.candidate_median_ms

    def display_row(self):
        return {
            "id": self.id,
            "model": self.model,
            "precision": self.precision,
            "size": self.size,
            "width": self.width,
            "height": self.height,
            "original_process_medians_ms": list(self.original_process_medians_ms),
            "candidate_process_medians_ms": list(self.candidate_process_medians_ms),
            "original_median_ms": self.original_median_ms,
            "candidate_median_ms": self.candidate_median_ms,
            "speedup": self.speedup,
            "original_range_ms": list(self.original_range_ms),
            "candidate_range_ms": list(self.candidate_range_ms),
            "decision_status": self.decision_status,
        }


@dataclass(frozen=True)
class Timing:
    receipt: Artifact
    decision_status: str
    decision_methodology: str
    decision_rationale: str
    cases: tuple


@dataclass(frozen=True)
class GateCheck:
    category: str
    status: str
    covered_cases: tuple
    receipt: Artifact
    summary: str


@dataclass(frozen=True)
class PtxasRecord:
    """One compiler resource row in an accepted record.

    ``static_shared_bytes`` is the ptxas static shared-memory allocation.
    ``cuobjdump_reserved_bytes`` on :class:`PtxasEvidence` is a separate
    tool-reported SM120 reserved region and is never added to or subtracted
    from this value.
    """

    architecture: str
    kernel: str
    sm_target: str
    registers_per_thread: int
    static_shared_bytes: int
    spill_bytes: int
    log: Artifact


@dataclass(frozen=True)
class PtxasEvidence:
    rows: tuple
    cuobjdump: Artifact
    cuobjdump_reserved_bytes: int


@dataclass(frozen=True)
class NcuEvidence:
    state: str
    candidate_source_revision: str | None
    binary_sha256: str | None
    reports: tuple
    reason: str
    methodology: str


@dataclass(frozen=True)
class Acceptance:
    path: Path
    bundle_root: Path
    sha256: str
    schema_version: int
    state: str
    acceptance_id: str
    original_source_revision: str
    candidate_source_revision: str
    original_build: BuildIdentity
    candidate_build: BuildIdentity
    provenance_manifest: Artifact
    provenance_files: tuple
    environment: Environment
    protocol: Protocol
    timing: Timing
    checks: tuple
    ptxas: PtxasEvidence
    ncu: NcuEvidence
    limitations: tuple
    decision_status: str
    decision_rationale: str
    artifacts: tuple

    def artifact(self, path):
        for artifact in self.artifacts:
            if artifact.path == path:
                return artifact
        raise KeyError(path)

    @property
    def revision(self):
        """Compatibility name for the attributed implementation commit."""
        return self.candidate_source_revision

    def case_rows(self):
        return [case.display_row() for case in self.timing.cases]

    def case_rows_sha256(self):
        return _digest_rows(self.case_rows())

    def gate_rows(self):
        return [{
            "category": check.category,
            "status": check.status,
            "covered_cases": list(check.covered_cases),
            "receipt_path": check.receipt.path,
            "receipt_sha256": check.receipt.sha256,
        } for check in self.checks]

    def gate_rows_sha256(self):
        return _digest_rows(self.gate_rows())

    def ptxas_rows(self):
        return [{
            "architecture": row.architecture,
            "kernel": row.kernel,
            "sm_target": row.sm_target,
            "registers_per_thread": row.registers_per_thread,
            "static_shared_bytes": row.static_shared_bytes,
            "spill_bytes": row.spill_bytes,
            "log_path": row.log.path,
            "log_sha256": row.log.sha256,
            "cuobjdump_reserved_bytes": self.ptxas.cuobjdump_reserved_bytes,
        } for row in self.ptxas.rows]


# Backwards-compatible import name used by the chapter module.  It is the full
# acceptance record, not the old ptxas-only sketch.
FinalEvidence = Acceptance


# ---------------------------------------------------------------------------
# Artifact and identity parsing
# ---------------------------------------------------------------------------


def _parse_artifact_registry(value):
    entries = _list(value, "artifacts", minimum=1)
    registry = {}
    for index, item in enumerate(entries):
        item = _object(item, f"artifacts[{index}]",
                       ("path", "sha256", "kind", "identity"))
        path = _safe_path(item["path"], f"artifacts[{index}].path").as_posix()
        if path == "acceptance.json":
            raise EvidenceError("acceptance.json must not register itself as an artifact")
        if PurePosixPath(path).suffix.lower() in FORBIDDEN_ARTIFACT_SUFFIXES:
            raise EvidenceError(
                "the public registry must not contain a native/executable/checkpoint "
                f"payload: {path}")
        if path in registry:
            raise EvidenceError(f"duplicate artifact path: {path}")
        digest = _hex64(item["sha256"], f"artifacts[{index}].sha256")
        kind = _enum(item["kind"], f"artifacts[{index}].kind", ARTIFACT_KINDS)
        identity = item["identity"]
        if not isinstance(identity, str) or _IDENTITY_RE.fullmatch(identity) is None:
            raise EvidenceError(
                f"artifacts[{index}].identity must be original/candidate/environment/"
                f"timing/ptxas/ncu/source/check:<category>, got {identity!r}")
        registry[path] = Artifact(path, digest, kind, identity)
    return registry


def _artifact_ref(value, label, registry, expected_kind, expected_identity):
    item = _object(value, label, ("path", "sha256"))
    path = _safe_path(item["path"], f"{label}.path").as_posix()
    digest = _hex64(item["sha256"], f"{label}.sha256")
    if path not in registry:
        raise EvidenceError(f"{label} is not present in the public artifact registry: {path}")
    registered = registry[path]
    if registered.sha256 != digest:
        raise EvidenceError(f"{label} hash disagrees with the artifact registry: {path}")
    if registered.kind != expected_kind:
        raise EvidenceError(
            f"{label} must reference a {expected_kind} artifact, found {registered.kind!r}")
    if expected_identity is not None and registered.identity != expected_identity:
        raise EvidenceError(
            f"{label} must carry identity {expected_identity!r}, found "
            f"{registered.identity!r}")
    return registered


def _artifact_file(artifact, bundle_root, label):
    root = Path(bundle_root).resolve()
    target = (root / Path(*PurePosixPath(artifact.path).parts)).resolve()
    if not target.is_relative_to(root):
        raise EvidenceError(f"{label} escapes its bundle: {artifact.path}")
    if not target.is_file():
        raise EvidenceError(f"{label} is missing: {artifact.path}")
    return target


def _read_json_artifact(artifact, bundle_root, label):
    target = _artifact_file(artifact, bundle_root, label)
    raw = target.read_bytes()
    if hashlib.sha256(raw).hexdigest() != artifact.sha256:
        raise EvidenceError(f"{label} hash mismatch: {artifact.path}")
    try:
        return json.loads(raw.decode("utf-8"), object_pairs_hook=_no_duplicate_keys)
    except EvidenceError:
        raise
    except (UnicodeDecodeError, ValueError) as exc:
        raise EvidenceError(f"{label} is not valid JSON: {artifact.path}: {exc}") from exc


def _parse_toolchain(value, label, role):
    """Parse the shared toolchain identity object used by the receipt and acceptance.

    There is exactly one definition of the six tool fields.  The public build
    receipt and the acceptance record must both parse to the same mapping.

    The parser is role-aware because only an *original historical* toolchain may
    contain an honest unknown.  A null original field is accepted only when the
    same object carries a non-empty, field-specific qualification naming that
    exact field.  Candidate facts must always be concrete; a candidate null or a
    qualifications block is rejected rather than weakened.
    """
    toolchain = _object(value, label, _TOOLCHAIN_KEYS, ("qualifications",))
    qualifications = None
    if "qualifications" in toolchain:
        qualifications = dict(_object(toolchain["qualifications"],
                                      f"{label}.qualifications", (),
                                      _TOOLCHAIN_KEYS))
        for key, text in qualifications.items():
            _string(text, f"{label}.qualifications.{key}")
    parsed = {}
    for key in _TOOLCHAIN_KEYS:
        raw = toolchain[key]
        if raw is None:
            if role != "original":
                raise EvidenceError(
                    f"{label}.{key} must be concrete for the candidate build")
            if qualifications is None or key not in qualifications:
                raise EvidenceError(
                    f"{label}.{key} is null and requires an explicit field-specific "
                    f"qualification at {label}.qualifications.{key}")
            parsed[key] = None
        elif key.endswith("_sha256"):
            parsed[key] = _hex64(raw, f"{label}.{key}")
        else:
            parsed[key] = _string(raw, f"{label}.{key}")
    if qualifications is not None:
        if role != "original":
            raise EvidenceError(
                f"{label}.qualifications is only valid for the original historical "
                "toolchain; candidate facts must remain concrete")
        parsed["qualifications"] = qualifications
    return parsed


def _parse_build_receipt(artifact, bundle_root, label, role):
    payload = _read_json_artifact(artifact, bundle_root, label)
    item = _object(payload, label, ("schema", "provenance", "binary", "toolchain"))
    schema = _string(item["schema"], f"{label}.schema")
    if schema != BUILD_RECEIPT_SCHEMA:
        raise EvidenceError(
            f"{label}.schema must be {BUILD_RECEIPT_SCHEMA!r}, got {schema!r}")
    provenance = _object(item["provenance"], f"{label}.provenance",
                         ("basis", "note", "build_time_HEAD", "dirty"))
    basis = _enum(provenance["basis"], f"{label}.provenance.basis",
                  PROVENANCE_BASES)
    note = _string(provenance["note"], f"{label}.provenance.note")
    raw_head = provenance["build_time_HEAD"]
    head = None if raw_head is None else _commit(
        raw_head, f"{label}.provenance.build_time_HEAD")
    raw_dirty = provenance["dirty"]
    dirty = None if raw_dirty is None else _bool(
        raw_dirty, f"{label}.provenance.dirty")
    if basis == "unknown":
        if head is not None or dirty is not None:
            raise EvidenceError(
                f"{label}: an unknown provenance basis must leave build_time_HEAD and "
                "dirty null rather than inventing historical facts")
    elif basis == "preserved-receipt":
        if head is None or dirty is None:
            raise EvidenceError(
                f"{label}: a preserved receipt must record the actual build_time_HEAD "
                "and dirty state")
    elif head is None and dirty is None:
        raise EvidenceError(
            f"{label}: inferred provenance must record at least one inferred fact, or "
            "use the unknown basis")
    binary = _object(item["binary"], f"{label}.binary",
                     ("filename", "sha256"), ("bytes",))
    filename = _string(binary["filename"], f"{label}.binary.filename")
    sha256 = _hex64(binary["sha256"], f"{label}.binary.sha256")
    if "bytes" in binary:
        _int(binary["bytes"], f"{label}.binary.bytes", minimum=1)
    toolchain = _parse_toolchain(item["toolchain"], f"{label}.toolchain", role)
    return basis, note, head, dirty, filename, sha256, toolchain


def _parse_provenance_rows(value, label, *, require_ffn):
    files = _list(value, label, minimum=1)
    result = []
    seen = set()
    ffn_seen = False
    for index, item in enumerate(files):
        item = _object(item, f"{label}[{index}]",
                       ("path", "raw_file_sha256", "normalized_lf_sha256"),
                       ("git_blob_oid",))
        path = _safe_path(item["path"], f"{label}[{index}].path").as_posix()
        if path in seen:
            raise EvidenceError(f"duplicate source provenance path: {path}")
        seen.add(path)
        raw = _hex64(item["raw_file_sha256"], f"{label}[{index}].raw_file_sha256")
        norm = _hex64(item["normalized_lf_sha256"],
                      f"{label}[{index}].normalized_lf_sha256")
        oid = item.get("git_blob_oid")
        if oid is not None:
            oid = _commit(oid, f"{label}[{index}].git_blob_oid")
        if path.startswith("csrc/kernel_impl/bottleneck_c1024_ffn/"):
            ffn_seen = True
        result.append(ProvenanceFile(path, raw, norm, oid))
    if require_ffn and not ffn_seen:
        raise EvidenceError(
            "source provenance must include at least one measured C1024 FFN kernel file")
    return tuple(result)


def _parse_measured_manifest(artifact, bundle_root, label, *, require_ffn):
    payload = _read_json_artifact(artifact, bundle_root, label)
    item = _object(payload, label, ("schema", "files"))
    schema = _string(item["schema"], f"{label}.schema")
    if schema != MEASURED_MANIFEST_SCHEMA:
        raise EvidenceError(
            f"{label}.schema must be {MEASURED_MANIFEST_SCHEMA!r}, got {schema!r}")
    return _parse_provenance_rows(item["files"], f"{label}.files",
                                  require_ffn=require_ffn)


def _parse_build(value, label, registry, role, bundle_root):
    item = _object(value, label, (
        "provenance_basis", "provenance_note", "build_time_HEAD", "dirty",
        "build_receipt", "input_manifest", "binary_filename", "binary_sha256",
        "toolchain"))
    basis = _enum(item["provenance_basis"], f"{label}.provenance_basis",
                  PROVENANCE_BASES)
    note = _string(item["provenance_note"], f"{label}.provenance_note")
    raw_head = item["build_time_HEAD"]
    head = None if raw_head is None else _commit(raw_head, f"{label}.build_time_HEAD")
    raw_dirty = item["dirty"]
    dirty = None if raw_dirty is None else _bool(raw_dirty, f"{label}.dirty")
    if basis == "unknown":
        if head is not None or dirty is not None:
            raise EvidenceError(
                f"{label}: an unknown provenance basis must leave build_time_HEAD and "
                "dirty null rather than inventing historical facts")
    elif basis == "preserved-receipt":
        if head is None or dirty is None:
            raise EvidenceError(
                f"{label}: a preserved receipt must record the actual build_time_HEAD "
                "and dirty state")
    elif head is None and dirty is None:
        raise EvidenceError(
            f"{label}: inferred provenance must record at least one inferred fact, or "
            "use the unknown basis")
    if role == "candidate":
        if basis != "preserved-receipt" or head is None or dirty is None:
            raise EvidenceError(
                "candidate_build must be the actual preserved frozen checkout with a "
                "recorded build_time_HEAD and dirty state")
        if dirty is not True:
            raise EvidenceError(
                "candidate_build.dirty must be true: the candidate binary was built from "
                "a frozen dirty worktree before the later implementation commit")
    build_receipt = _artifact_ref(item["build_receipt"], f"{label}.build_receipt",
                                  registry, "build-receipt", role)
    manifest = _artifact_ref(item["input_manifest"], f"{label}.input_manifest",
                             registry, "input-manifest", role)
    input_files = _parse_measured_manifest(
        manifest, bundle_root, f"{label}.input_manifest",
        require_ffn=(role == "candidate"))
    (receipt_basis, receipt_note, receipt_head, receipt_dirty,
     receipt_filename, receipt_sha, receipt_toolchain) = _parse_build_receipt(
        build_receipt, bundle_root, f"{label}.build_receipt", role)
    filename = _string(item["binary_filename"], f"{label}.binary_filename")
    sha256 = _hex64(item["binary_sha256"], f"{label}.binary_sha256")
    if (receipt_basis != basis or receipt_note != note
            or receipt_head != head or receipt_dirty != dirty):
        raise EvidenceError(
            f"{label}: provenance_basis/provenance_note/build_time_HEAD/dirty disagree "
            "with the public build receipt")
    if receipt_filename != filename or receipt_sha != sha256:
        raise EvidenceError(
            f"{label}: binary_filename/binary_sha256 disagree with the public build "
            "receipt")
    parsed_toolchain = _parse_toolchain(item["toolchain"], f"{label}.toolchain", role)
    if receipt_toolchain != parsed_toolchain:
        mismatched = [key for key in _TOOLCHAIN_KEYS
                      if receipt_toolchain[key] != parsed_toolchain[key]]
        if receipt_toolchain.get("qualifications") != parsed_toolchain.get(
                "qualifications"):
            mismatched.append("qualifications")
        raise EvidenceError(
            f"{label}: toolchain identity ({', '.join(mismatched)}) disagrees with the "
            "public build receipt")
    return BuildIdentity(basis, note, head, dirty, build_receipt, manifest,
                         input_files, filename, sha256, parsed_toolchain)


def _parse_provenance_files(value):
    return _parse_provenance_rows(value, "source_provenance.files",
                                  require_ffn=True)


def _verify_provenance(files, revision):
    """Compare measured normalized content with the attributed commit's blobs."""
    for item in files:
        committed = read_blob(revision, item.path)
        if committed is None:
            raise EvidenceError(
                f"measured source input is absent at the attributed implementation "
                f"commit {revision}: {item.path}")
        actual_norm = hashlib.sha256(committed.encode("utf-8")).hexdigest()
        if actual_norm != item.normalized_lf_sha256:
            raise EvidenceError(
                f"measured normalized-LF content does not match {revision}: {item.path}")
        if item.git_blob_oid is not None:
            result = subprocess.run(
                ["git", "rev-parse", f"{revision}:{item.path}"],
                cwd=ROOT, capture_output=True, text=True,
            )
            actual_oid = result.stdout.strip() if result.returncode == 0 else None
            if actual_oid != item.git_blob_oid:
                raise EvidenceError(
                    f"git_blob_oid does not name the blob at {revision}: {item.path}")


def _parse_environment(value):
    item = _object(value, "environment", (
        "gpu_name", "gpu_uuid", "driver", "cuda", "pytorch", "timing_method",
        "seed", "warmup", "samples", "iterations", "rounds", "methodology"))
    return Environment(
        gpu_name=_string(item["gpu_name"], "environment.gpu_name"),
        gpu_uuid=_string(item["gpu_uuid"], "environment.gpu_uuid"),
        driver=_string(item["driver"], "environment.driver"),
        cuda=_string(item["cuda"], "environment.cuda"),
        pytorch=_string(item["pytorch"], "environment.pytorch"),
        timing_method=_string(item["timing_method"], "environment.timing_method"),
        seed=_int(item["seed"], "environment.seed", minimum=0),
        warmup=_int(item["warmup"], "environment.warmup", minimum=0),
        samples=_int(item["samples"], "environment.samples", minimum=1),
        iterations=_int(item["iterations"], "environment.iterations", minimum=1),
        rounds=_int(item["rounds"], "environment.rounds", minimum=1),
        methodology=_string(item["methodology"], "environment.methodology"),
    )


def _parse_protocol(value):
    item = _object(value, "protocol", (
        "child_processes_per_case", "original_processes", "candidate_processes",
        "process_order", "methodology"))
    children = _int(item["child_processes_per_case"],
                    "protocol.child_processes_per_case", minimum=1)
    original = _int(item["original_processes"], "protocol.original_processes", minimum=1)
    candidate = _int(item["candidate_processes"], "protocol.candidate_processes", minimum=1)
    if (children, original, candidate) != (PROCESSES_PER_CASE, ARM_PROCESSES, ARM_PROCESSES):
        raise EvidenceError(
            f"protocol requires {PROCESSES_PER_CASE} child processes per case with "
            f"{ARM_PROCESSES} original + {ARM_PROCESSES} candidate process medians")
    order = _list(item["process_order"], "protocol.process_order",
                  length=PROCESSES_PER_CASE)
    parsed_order = []
    for index, arm in enumerate(order):
        parsed_order.append(_enum(arm, f"protocol.process_order[{index}]",
                                  ("original", "candidate")))
    if (parsed_order.count("original"), parsed_order.count("candidate")) != (
            ARM_PROCESSES, ARM_PROCESSES):
        raise EvidenceError(
            "protocol.process_order must contain exactly four original and four "
            "candidate child positions")
    if tuple(parsed_order) not in PROCESS_ORDERS:
        raise EvidenceError(
            "protocol.process_order must preserve the fixed ABBA/BAAB balanced "
            "pairing, not an arbitrary 4+4 split")
    return Protocol(children, original, candidate, tuple(parsed_order),
                    _string(item["methodology"], "protocol.methodology"))


def _parse_arm(value, label):
    item = _object(value, label, ("process_medians_ms",))
    medians = _list(item["process_medians_ms"], f"{label}.process_medians_ms",
                    length=ARM_PROCESSES)
    parsed = tuple(
        _number(value, f"{label}.process_medians_ms[{index}]", positive=True)
        for index, value in enumerate(medians))
    return parsed


def _parse_case(value, index, case_ids):
    label = f"timing.cases[{index}]"
    item = _object(value, label, (
        "id", "model", "precision", "size", "width", "height", "original",
        "candidate", "uncertainty", "decision"))
    case_id = _string(item["id"], f"{label}.id", minimum=5)
    if case_id in case_ids:
        raise EvidenceError(f"duplicate timing case id: {case_id}")
    case_ids.add(case_id)
    model = _enum(item["model"], f"{label}.model", MODELS)
    precision = _enum(item["precision"], f"{label}.precision", PRECISIONS)
    size = _enum(item["size"], f"{label}.size", tuple(row[0] for row in SIZES))
    expected_size = next(row for row in SIZES if row[0] == size)
    width = _int(item["width"], f"{label}.width")
    height = _int(item["height"], f"{label}.height")
    if (width, height) != (expected_size[1], expected_size[2]):
        raise EvidenceError(
            f"{label}: size {size} must have exactly "
            f"{expected_size[1]}x{expected_size[2]}, got {width}x{height}")
    original = _parse_arm(item["original"], f"{label}.original")
    candidate = _parse_arm(item["candidate"], f"{label}.candidate")
    uncertainty = _object(item["uncertainty"], f"{label}.uncertainty",
                          ("method", "original_range_ms", "candidate_range_ms"))
    method = _string(uncertainty["method"], f"{label}.uncertainty.method")
    original_range = tuple(
        _number(value, f"{label}.uncertainty.original_range_ms[{pos}]")
        for pos, value in enumerate(_list(
            uncertainty["original_range_ms"],
            f"{label}.uncertainty.original_range_ms", length=2)))
    candidate_range = tuple(
        _number(value, f"{label}.uncertainty.candidate_range_ms[{pos}]")
        for pos, value in enumerate(_list(
            uncertainty["candidate_range_ms"],
            f"{label}.uncertainty.candidate_range_ms", length=2)))
    if original_range != (min(original), max(original)):
        raise EvidenceError(
            f"{label}.uncertainty.original_range_ms must be exactly the min/max of "
            "the four original process medians")
    if candidate_range != (min(candidate), max(candidate)):
        raise EvidenceError(
            f"{label}.uncertainty.candidate_range_ms must be exactly the min/max of "
            "the four candidate process medians")
    decision = _object(item["decision"], f"{label}.decision",
                       ("status", "rationale"))
    status = _enum(decision["status"], f"{label}.decision.status", CASE_DECISIONS)
    rationale = _string(decision["rationale"], f"{label}.decision.rationale")
    return TimingCase(case_id, model, precision, size, width, height,
                      original, candidate, original_range, candidate_range,
                      method, status, rationale)


def _parse_timing(value, registry):
    item = _object(value, "timing", ("receipt", "decision", "cases"))
    receipt = _artifact_ref(item["receipt"], "timing.receipt",
                            registry, "timing-receipt", "timing")
    decision = _object(item["decision"], "timing.decision",
                       ("status", "methodology", "rationale"))
    status = _enum(decision["status"], "timing.decision.status", ("accepted",))
    methodology = _string(decision["methodology"], "timing.decision.methodology")
    rationale = _string(decision["rationale"], "timing.decision.rationale")
    cases = _list(item["cases"], "timing.cases", length=CASE_COUNT)
    case_ids = set()
    parsed = tuple(_parse_case(case, index, case_ids)
                   for index, case in enumerate(cases))
    expected = {
        (model, precision, size)
        for model in MODELS for precision in PRECISIONS for size in (row[0] for row in SIZES)
    }
    actual = {(case.model, case.precision, case.size) for case in parsed}
    if len(actual) != CASE_COUNT or actual != expected:
        raise EvidenceError(
            "timing.cases must be the exact 16-case legacy71/small31 x fp16/fp8 x "
            "720p/1080p/2k/4k matrix with no duplicates or omissions")
    for case in parsed:
        if case.decision_status not in ACCEPTED_CASE_DECISIONS:
            raise EvidenceError(
                f"timing case {case.id} records {case.decision_status!r}; an accepted "
                "timing report may not contain an unresolved or reproducible slowdown")
    if len({case.uncertainty_method for case in parsed}) != 1:
        raise EvidenceError(
            "all timing cases must record the same fixed uncertainty method")
    return Timing(receipt, status, methodology, rationale, parsed)


def _parse_checks(value, case_ids, registry):
    items = _list(value, "checks", length=len(REQUIRED_CHECK_CATEGORIES))
    parsed = []
    seen = set()
    for index, item in enumerate(items):
        label = f"checks[{index}]"
        item = _object(item, label, (
            "category", "status", "covered_cases", "receipt", "summary"))
        category = _string(item["category"], f"{label}.category")
        if category in seen:
            raise EvidenceError(f"duplicate check category: {category}")
        seen.add(category)
        if category not in REQUIRED_CHECK_CATEGORIES:
            raise EvidenceError(f"unsupported acceptance check category: {category}")
        status = _enum(item["status"], f"{label}.status", ("pass", "fail"))
        if status != "pass":
            raise EvidenceError(f"required acceptance check failed: {category}")
        covered = tuple(
            _string(value, f"{label}.covered_cases[{position}]")
            for position, value in enumerate(_list(
                item["covered_cases"], f"{label}.covered_cases", minimum=1)))
        if len(set(covered)) != len(covered):
            raise EvidenceError(f"{label}.covered_cases contains duplicates")
        if "all" in covered and len(covered) != 1:
            raise EvidenceError(
                f"{label}.covered_cases must use either 'all' or explicit labels")
        if category == "native-bitwise":
            # Native bitwise resolution is the strict timing matrix: either the
            # established 'all' shorthand or every actual benchmark case id.
            unknown = [entry for entry in covered
                       if entry != "all" and entry not in case_ids]
            if unknown:
                raise EvidenceError(
                    f"{label}.covered_cases names unknown native cases: {unknown}")
        # Other categories name coverage in their own receipt vocabulary (CPU
        # suite, checkpoint row, small-fixture training, guard, primitive).  A
        # label need not resolve to a native benchmark case; it must be a
        # non-empty, unique, explicit string from the actual receipt.
        receipt = _artifact_ref(item["receipt"], f"{label}.receipt",
                                registry, "check-receipt",
                                f"check:{category}")
        parsed.append(GateCheck(category, status, covered, receipt,
                                _string(item["summary"], f"{label}.summary")))
    if seen != set(REQUIRED_CHECK_CATEGORIES):
        missing = sorted(set(REQUIRED_CHECK_CATEGORIES) - seen)
        raise EvidenceError(f"required acceptance check categories are missing: {missing}")
    native = next(check for check in parsed if check.category == "native-bitwise")
    if native.covered_cases != ("all",) and set(native.covered_cases) != set(case_ids):
        raise EvidenceError(
            "native-bitwise acceptance must cover all 16 timing cases")
    return tuple(parsed)


def _parse_ptxas(value, registry):
    item = _object(value, "ptxas", ("rows", "cuobjdump", "cuobjdump_reserved_bytes"))
    rows = _list(item["rows"], "ptxas.rows", minimum=1)
    parsed = []
    for index, row in enumerate(rows):
        label = f"ptxas.rows[{index}]"
        row = _object(row, label, (
            "architecture", "kernel", "sm_target", "registers_per_thread",
            "static_shared_bytes", "spill_bytes", "log"))
        architecture = _enum(row["architecture"], f"{label}.architecture", _ARCHITECTURES)
        sm_target = _enum(row["sm_target"], f"{label}.sm_target", _SM_TARGETS)
        if architecture.lower().replace("sm", "sm_") != sm_target:
            raise EvidenceError(
                f"{label}: architecture {architecture} disagrees with target {sm_target}")
        log = _artifact_ref(row["log"], f"{label}.log", registry, "ptxas-log", "ptxas")
        parsed.append(PtxasRecord(
            architecture=architecture,
            kernel=_string(row["kernel"], f"{label}.kernel"),
            sm_target=sm_target,
            registers_per_thread=_int(row["registers_per_thread"],
                                      f"{label}.registers_per_thread", minimum=1),
            static_shared_bytes=_int(row["static_shared_bytes"],
                                     f"{label}.static_shared_bytes", minimum=0),
            spill_bytes=_int(row["spill_bytes"], f"{label}.spill_bytes", minimum=0),
            log=log,
        ))
    cuobjdump = _artifact_ref(item["cuobjdump"], "ptxas.cuobjdump",
                              registry, "cuobjdump", "ptxas")
    reserved = _int(item["cuobjdump_reserved_bytes"],
                    "ptxas.cuobjdump_reserved_bytes", minimum=0)
    if reserved != 1024:
        raise EvidenceError(
            "ptxas.cuobjdump_reserved_bytes must record the separate SM120 "
            "driver-reserved region (1024 bytes), not a different or merged value")
    if not any("global_ffn_expand" in row.kernel and row.architecture == "SM120"
               for row in parsed):
        raise EvidenceError(
            "ptxas rows must include the final FFN expansion kernel for the actual "
            "SM120 target")
    return PtxasEvidence(tuple(parsed), cuobjdump, reserved)


def _parse_ncu(value, registry, candidate_revision, candidate_binary_sha):
    item = _object(value, "ncu", ("state", "reason"), (
        "candidate_source_revision", "binary_sha256", "reports", "methodology"))
    state = _enum(item["state"], "ncu.state", ("absent", "current"))
    reason = _string(item["reason"], "ncu.reason")
    if state == "absent":
        if item.get("reports") not in (None, []):
            raise EvidenceError("an absent NCU record must not link reports")
        if item.get("candidate_source_revision") is not None:
            raise EvidenceError("an absent NCU record must not claim a current revision")
        return NcuEvidence("absent", None, None, (), reason, "")
    methodology = _string(item.get("methodology", ""), "ncu.methodology")
    revision = _commit(item.get("candidate_source_revision"),
                       "ncu.candidate_source_revision")
    if revision != candidate_revision:
        raise EvidenceError("current NCU evidence names a different implementation commit")
    binary_sha = _hex64(item.get("binary_sha256"), "ncu.binary_sha256")
    if binary_sha != candidate_binary_sha:
        raise EvidenceError("current NCU evidence names a different candidate binary")
    reports = tuple(
        _artifact_ref(report, f"ncu.reports[{index}]", registry, "ncu-report", "ncu")
        for index, report in enumerate(_list(item.get("reports"), "ncu.reports",
                                             minimum=1)))
    return NcuEvidence("current", revision, binary_sha, reports, reason, methodology)


def _verify_artifacts(registry, bundle_root, verify_files):
    if not verify_files:
        return
    root = bundle_root.resolve()
    for artifact in registry.values():
        target = (root / Path(*PurePosixPath(artifact.path).parts)).resolve()
        if not target.is_relative_to(root):
            raise EvidenceError(f"artifact path escapes its bundle: {artifact.path}")
        if not target.is_file():
            raise EvidenceError(f"referenced acceptance artifact is missing: {artifact.path}")
        digest = hashlib.sha256(target.read_bytes()).hexdigest()
        if digest != artifact.sha256:
            raise EvidenceError(f"acceptance artifact hash mismatch: {artifact.path}")


def _parse_acceptance(payload, *, path, bundle_root, raw_sha256, expected_revision,
                      verify_files, verify_git):
    if not isinstance(payload, dict):
        raise EvidenceError("FlashLight acceptance evidence must be a JSON object")
    item = _object(payload, "acceptance", (
        "schema_version", "state", "acceptance_id", "original_source_revision",
        "candidate_source_revision", "original_build", "candidate_build",
        "source_provenance", "environment", "protocol", "timing", "checks",
        "ptxas", "limitations", "decision", "artifacts"), ("ncu",))

    if _int(item["schema_version"], "schema_version") != SCHEMA_VERSION:
        raise EvidenceError(
            f"unsupported acceptance schema_version {item['schema_version']!r}; "
            f"this guide understands {SCHEMA_VERSION}")
    state = _enum(item["state"], "state", (ACCEPTED_STATE,))
    acceptance_id = item["acceptance_id"]
    if not isinstance(acceptance_id, str) or _ACCEPTANCE_ID_RE.fullmatch(acceptance_id) is None:
        raise EvidenceError("acceptance_id must be a non-empty safe identifier")
    original_revision = _commit(item["original_source_revision"],
                                "original_source_revision")
    if original_revision != ORIGINAL_SOURCE_REVISION:
        raise EvidenceError(
            "original_source_revision must be the frozen source-replay snapshot "
            f"{ORIGINAL_SOURCE_REVISION}, not the historical lesson pin; it is not "
            "the original binary's build checkout")
    candidate_revision = _commit(item["candidate_source_revision"],
                                 "candidate_source_revision")
    if candidate_revision == original_revision:
        raise EvidenceError(
            "candidate_source_revision must be the later implementation commit, not "
            "the original baseline")
    if expected_revision is not None:
        try:
            expected_revision = validated_commit(
                expected_revision, "configured current revision")
        except ValueError as exc:
            raise EvidenceError(str(exc)) from exc
        if candidate_revision != expected_revision:
            raise EvidenceError(
                f"candidate_source_revision {candidate_revision} does not equal the "
                f"configured current provider revision {expected_revision}")
    if verify_git:
        try:
            require_commit(original_revision)
            require_commit(candidate_revision)
        except Exception as exc:  # SourceProviderError or validation error
            raise EvidenceError(f"acceptance names a non-existent commit: {exc}") from exc

    registry = _parse_artifact_registry(item["artifacts"])
    _verify_artifacts(registry, bundle_root, verify_files)
    original_build = _parse_build(item["original_build"], "original_build",
                                  registry, "original", bundle_root)
    candidate_build = _parse_build(item["candidate_build"], "candidate_build",
                                   registry, "candidate", bundle_root)
    if verify_git:
        for label, head in (("original_build.build_time_HEAD",
                             original_build.build_time_head),
                            ("candidate_build.build_time_HEAD",
                             candidate_build.build_time_head)):
            if head is None:
                continue
            try:
                require_commit(head)
            except Exception as exc:  # SourceProviderError or validation error
                raise EvidenceError(
                    f"{label} names a non-existent checkout: {exc}") from exc
    if candidate_build.build_time_head == candidate_revision:
        raise EvidenceError(
            "candidate_build.build_time_HEAD is the later implementation commit; the "
            "measured build checkout must be recorded separately")
    if original_build.build_time_head == candidate_revision:
        raise EvidenceError(
            "original_build.build_time_HEAD must not be the later implementation commit")
    if candidate_build.binary_sha256 == original_build.binary_sha256:
        raise EvidenceError("original and candidate binary hashes must be distinct")

    provenance = _object(item["source_provenance"], "source_provenance",
                         ("manifest", "files"))
    provenance_manifest = _artifact_ref(
        provenance["manifest"], "source_provenance.manifest",
        registry, "input-manifest", "candidate")
    if (provenance_manifest.path != candidate_build.input_manifest.path
            or provenance_manifest.sha256 != candidate_build.input_manifest.sha256):
        raise EvidenceError(
            "source_provenance.manifest must be the candidate build's complete public "
            "measured input manifest")
    provenance_files = _parse_provenance_files(provenance["files"])
    if provenance_files != candidate_build.input_files:
        raise EvidenceError(
            "source_provenance.files must equal the candidate input manifest exactly "
            "(coverage, order, raw/normalized hashes and blob ids)")
    if verify_git:
        _verify_provenance(provenance_files, candidate_revision)

    environment = _parse_environment(item["environment"])
    protocol = _parse_protocol(item["protocol"])
    timing = _parse_timing(item["timing"], registry)
    checks = _parse_checks(item["checks"], {case.id for case in timing.cases}, registry)
    ptxas = _parse_ptxas(item["ptxas"], registry)
    ncu = _parse_ncu(item.get("ncu", {"state": "absent", "reason": "not supplied"}),
                     registry, candidate_revision, candidate_build.binary_sha256)
    limitations = tuple(
        _string(value, f"limitations[{index}]")
        for index, value in enumerate(_list(item["limitations"], "limitations",
                                            minimum=1)))
    decision = _object(item["decision"], "decision", ("status", "rationale"))
    decision_status = _enum(decision["status"], "decision.status", ("accepted",))
    decision_rationale = _string(decision["rationale"], "decision.rationale")

    return Acceptance(
        path=Path(path),
        bundle_root=Path(bundle_root),
        sha256=raw_sha256,
        schema_version=SCHEMA_VERSION,
        state=state,
        acceptance_id=acceptance_id,
        original_source_revision=original_revision,
        candidate_source_revision=candidate_revision,
        original_build=original_build,
        candidate_build=candidate_build,
        provenance_manifest=provenance_manifest,
        provenance_files=provenance_files,
        environment=environment,
        protocol=protocol,
        timing=timing,
        checks=checks,
        ptxas=ptxas,
        ncu=ncu,
        limitations=limitations,
        decision_status=decision_status,
        decision_rationale=decision_rationale,
        artifacts=tuple(registry.values()),
    )


def load_acceptance(path, expected_revision=None, *, bundle_root=None,
                    verify_files=True, verify_git=True):
    """Load and fully validate one accepted evidence bundle.

    ``bundle_root`` defaults to the acceptance file's directory; artifact paths
    are resolved and confined below it.  A missing file, malformed schema,
    pending state, wrong commit, missing/corrupt artifact or mismatched
    normalized provenance raises :class:`EvidenceError` before any caller can
    write generated output.
    """
    target = Path(path)
    if not target.is_file():
        raise EvidenceError(f"FlashLight acceptance evidence does not exist: {target}")
    raw = target.read_bytes()
    raw_sha256 = hashlib.sha256(raw).hexdigest()
    try:
        payload = json.loads(raw.decode("utf-8"), object_pairs_hook=_no_duplicate_keys)
    except EvidenceError:
        raise
    except (UnicodeDecodeError, ValueError) as exc:
        raise EvidenceError(f"cannot parse FlashLight acceptance evidence: {exc}") from exc
    root = Path(bundle_root) if bundle_root is not None else target.parent
    return _parse_acceptance(
        payload, path=target, bundle_root=root, raw_sha256=raw_sha256,
        expected_revision=expected_revision, verify_files=verify_files,
        verify_git=verify_git)


def canonical_acceptance_path(guide_root=None):
    """Return the canonical checked-in acceptance path (which may not exist yet)."""
    root = Path(guide_root) if guide_root is not None else repository_guide_root()
    return root / Path(*CANONICAL_RELATIVE_PATH.parts)


def resolve_acceptance_path(explicit=None, *, guide_root=None, env=None):
    """Resolve explicit CLI > evidence environment > canonical checked-in file."""
    environment = os.environ if env is None else env
    if explicit not in (None, ""):
        return Path(explicit)
    value = environment.get(ENVIRONMENT_VARIABLE)
    if value not in (None, ""):
        return Path(value)
    canonical = canonical_acceptance_path(guide_root)
    return canonical if canonical.is_file() else None


def copy_acceptance_bundle(acceptance, destination_root):
    """Copy a verified acceptance file and its artifacts, never the reverse.

    The source bundle stays byte-identical.  Only the acceptance JSON and the
    artifact registry (safe relative paths) are copied into
    ``destination_root``; all copies are re-hashed after writing.
    """
    destination = Path(destination_root)
    destination.mkdir(parents=True, exist_ok=True)
    target = destination / "acceptance.json"
    raw = acceptance.path.read_bytes()
    if hashlib.sha256(raw).hexdigest() != acceptance.sha256:
        raise EvidenceError("acceptance source changed after validation")
    if target.resolve() != acceptance.path.resolve():
        target.write_bytes(raw)
    source_root = acceptance.bundle_root.resolve()
    destination_resolved = destination.resolve()
    for artifact in acceptance.artifacts:
        if artifact.kind in ("binary", "checkpoint"):
            raise EvidenceError(
                f"refusing to copy a native/checkpoint payload: {artifact.path}")
        source = (source_root / Path(*PurePosixPath(artifact.path).parts)).resolve()
        if not source.is_relative_to(source_root) or not source.is_file():
            raise EvidenceError(f"cannot copy missing acceptance artifact: {artifact.path}")
        output = (destination_resolved / Path(*PurePosixPath(artifact.path).parts)).resolve()
        if not output.is_relative_to(destination_resolved):
            raise EvidenceError(f"artifact copy escapes its destination: {artifact.path}")
        if output == source:
            continue
        output.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, output)
        if hashlib.sha256(output.read_bytes()).hexdigest() != artifact.sha256:
            raise EvidenceError(f"copied artifact hash mismatch: {artifact.path}")
    if hashlib.sha256(target.read_bytes()).hexdigest() != acceptance.sha256:
        raise EvidenceError("copied acceptance evidence hash mismatch")
    return target
