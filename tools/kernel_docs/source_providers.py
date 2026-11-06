"""Explicit, immutable source providers for the kernel documentation.

Two namespaces exist and must never be confused:

``ORIGINAL``
    The exact historical source tree materialized from the accepted immutable
    reference ``e2741a72b390f830de810e6f1180369ed52eb325`` with
    ``git archive``.  Every historical lesson, anchor, inventory, dependency and
    evidence-source read uses this provider.  It is never the working tree.

``current_provider()``
    An optional provider for a later, real FlashLight implementation commit.
    There is no default and no working-tree mode: the commit must be a full
    lowercase 40-character SHA-1 whose tree really contains every path the
    current chapter quotes.  Until root supplies such a commit, current
    documentation simply is not published.

Per-file provenance for the original provider is explicit, never inferred from
worktree equality:

* checkpoint API paths first (``checkpoint-api-commit``),
* runtime paths second (``runtime-commit``),
* every remaining path that exists at ``fc32764`` is ``legacy-commit``,
* anything else fails.

Only the standard library is used.  Materialized trees live outside the
repository and are removed at interpreter exit.
"""
from __future__ import annotations

import atexit
import hashlib
import io
import re
import shutil
import subprocess
import tarfile
import tempfile
import threading
from pathlib import Path, PurePosixPath

from runtime_source_revision import (
    CHECKPOINT_API_SOURCE_PATHS,
    RUNTIME_SOURCE_PATHS,
    configured_checkpoint_api_revision,
    configured_refactor_revision,
    configured_runtime_revision,
)

ROOT = Path(__file__).resolve().parents[2]

#: The accepted immutable original-source reference.
ORIGINAL_REFERENCE = "e2741a72b390f830de810e6f1180369ed52eb325"
#: Historical 310.8 ownership pin recorded per legacy file.
LEGACY_REVISION = "fc3276497f866bdad639cd443e75743f5d19b749"

#: Roof directories materialized from the immutable commit.  ``csrc`` supplies
#: the inventory, ``dlssnr``/``setup.py``/``tools``/``tuning`` supply runtime
#: sources and the canonical roster.
ARCHIVE_PATHS = ("csrc", "dlssnr", "setup.py", "tools", "tuning")

COMMIT_RE = re.compile(r"[0-9a-f]{40}")


class SourceProviderError(RuntimeError):
    """Raised when an immutable source cannot be materialized or attributed."""


def normalized_lf(text: str) -> str:
    """Return the canonical text form used for hashes and excerpts."""
    return text.replace("\r\n", "\n").replace("\r", "\n")


def validated_commit(value: str, label: str = "revision") -> str:
    """Return a validated full lowercase 40-character commit SHA-1."""
    if not isinstance(value, str) or COMMIT_RE.fullmatch(value) is None:
        raise ValueError(f"{label} must be a full lowercase 40-character git SHA-1, got {value!r}")
    return value


def _validated_path(path: str) -> PurePosixPath:
    """Validate a repository-relative POSIX path without duplicating parsers."""
    if not isinstance(path, str) or not path:
        raise ValueError(f"invalid source path: {path!r}")
    if "\\" in path or ":" in path or path.startswith("/"):
        raise ValueError(f"source path must be repository-relative POSIX: {path!r}")
    candidate = PurePosixPath(path)
    if any(part in ("", ".", "..") for part in path.rstrip("/").split("/")):
        raise ValueError(f"source path escapes its provider: {path!r}")
    return candidate


def _git_bytes(*args: str) -> bytes:
    result = subprocess.run(
        ["git", *args], cwd=ROOT, capture_output=True,
    )
    if result.returncode != 0:
        stderr = result.stderr.decode("utf-8", "replace").strip()
        raise SourceProviderError(f"git {' '.join(args)} failed: {stderr}")
    return result.stdout


def require_commit(revision: str) -> None:
    """Verify an actual commit even when no excerpts will be requested."""
    validated_commit(revision)
    _git_bytes("cat-file", "-e", f"{revision}^{{commit}}")


def _remove_materialized_tree(root: Path) -> None:
    """Delete only a resolved provider directory directly under the temp root."""
    resolved = root.resolve()
    temporary = Path(tempfile.gettempdir()).resolve()
    if resolved != root or resolved.parent != temporary or not re.fullmatch(
            r"dlssnr-(original|current)-source-[^/\\]+", resolved.name):
        raise SourceProviderError(f"refusing to delete unexpected source directory: {root}")
    shutil.rmtree(resolved, ignore_errors=True)


_BLOB_CACHE: dict[tuple[str, str], str | None] = {}
_BLOB_LOCK = threading.Lock()


def read_blob(revision: str, path: str) -> str | None:
    """Read one committed blob as normalized-LF text, or ``None`` if absent.

    This is deliberately blob-based: it never consults the working tree.  It is
    used for evidence pins that are recorded against an older revision than the
    original snapshot.
    """
    validated_commit(revision)
    _validated_path(path)
    key = (revision, path)
    with _BLOB_LOCK:
        if key in _BLOB_CACHE:
            return _BLOB_CACHE[key]
    result = subprocess.run(
        ["git", "cat-file", "blob", f"{revision}:{path}"],
        cwd=ROOT, capture_output=True,
    )
    text = None
    if result.returncode == 0:
        text = normalized_lf(result.stdout.decode("utf-8"))
    else:
        # Distinguish an absent path from an invalid commit.
        present = subprocess.run(
            ["git", "cat-file", "-e", f"{revision}^{{commit}}"],
            cwd=ROOT, capture_output=True,
        )
        if present.returncode != 0:
            raise SourceProviderError(f"unknown commit {revision}")
    with _BLOB_LOCK:
        _BLOB_CACHE[key] = text
    return text


def blob_sha256(revision: str, path: str) -> str | None:
    """Return the normalized-LF SHA-256 of a committed blob, or ``None``."""
    text = read_blob(revision, path)
    return None if text is None else hashlib.sha256(text.encode("utf-8")).hexdigest()


class Provider:
    """A read-only source tree materialized from one immutable commit."""

    def __init__(self, name: str, revision: str, *, paths=ARCHIVE_PATHS,
                 required_paths=()):
        if name not in ("original", "current"):
            raise ValueError(f"unknown source provider: {name!r}")
        self.name = name
        self.revision = validated_commit(revision, f"{name} provider revision")
        self.paths = tuple(paths)
        self.required_paths = tuple(required_paths)
        self._root: Path | None = None
        self._lock = threading.Lock()
        self._atexit_registered = False

    @property
    def root(self) -> Path:
        """The materialized read-only tree, materializing it on first use."""
        self.materialize()
        assert self._root is not None
        return self._root

    @property
    def materialized(self) -> bool:
        return self._root is not None

    def materialize(self) -> Path:
        with self._lock:
            if self._root is not None:
                return self._root
            if not self.paths:
                raise SourceProviderError("provider has no source roots")
            data = _git_bytes("archive", "--format=tar", self.revision, "--", *self.paths)
            if not data:
                raise SourceProviderError(f"git archive produced no data for {self.revision}")
            root = Path(tempfile.mkdtemp(prefix=f"dlssnr-{self.name}-source-")).resolve()
            if root.is_relative_to(ROOT):
                _remove_materialized_tree(root)
                raise SourceProviderError("materialized source tree must live outside the repository")
            try:
                self._extract(data, root)
                missing = [path for path in self.required_paths
                           if not (root / path).is_file()]
                if missing:
                    raise SourceProviderError(
                        f"{self.name} provider at {self.revision} is missing required "
                        f"paths: {', '.join(missing)}")
            except BaseException:
                _remove_materialized_tree(root)
                raise
            self._root = root
            if not self._atexit_registered:
                atexit.register(self.cleanup)
                self._atexit_registered = True
            return root

    @staticmethod
    def _extract(data: bytes, root: Path) -> None:
        """Safely extract a git archive without path traversal or links."""
        with tarfile.open(fileobj=io.BytesIO(data), mode="r:") as archive:
            for member in archive:
                relative = _validated_path(member.name)
                target = (root / Path(*relative.parts)).resolve()
                if not target.is_relative_to(root):
                    raise SourceProviderError(f"archive member escapes provider root: {member.name}")
                if member.isdir():
                    target.mkdir(parents=True, exist_ok=True)
                    continue
                if not member.isfile():
                    raise SourceProviderError(f"archive member is not a regular file: {member.name}")
                handle = archive.extractfile(member)
                if handle is None:
                    raise SourceProviderError(f"cannot read archive member: {member.name}")
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(handle.read())

    def text(self, path: str) -> str:
        """Return normalized-LF committed text for ``path``."""
        _validated_path(path)
        target = self.root / Path(*PurePosixPath(path).parts)
        if not target.is_file():
            raise FileNotFoundError(
                f"{path} is not present in the {self.name} source at {self.revision}")
        return normalized_lf(target.read_bytes().decode("utf-8"))

    def sha256(self, path: str) -> str:
        return hashlib.sha256(self.text(path).encode("utf-8")).hexdigest()

    def exists(self, path: str) -> bool:
        try:
            _validated_path(path)
        except ValueError:
            return False
        return (self.root / Path(*PurePosixPath(path).parts)).is_file()

    def provenance(self, path: str) -> dict:
        """Classify one source path explicitly for this provider."""
        _validated_path(path)
        text = self.text(path)
        digest = hashlib.sha256(text.encode("utf-8")).hexdigest()
        if self.name != "original":
            return dict(kind="refactor-commit", revision=self.revision, sha256=digest)
        if path in CHECKPOINT_API_SOURCE_PATHS:
            revision = configured_checkpoint_api_revision()
            if revision is None:
                raise ValueError(
                    f"{path} belongs to the checkpoint API and has no configured "
                    "full 40-character implementation commit")
            committed = read_blob(revision, path)
            if committed is None:
                raise ValueError(
                    f"{path} is not present at checkpoint API revision {revision}")
            if committed != text:
                raise ValueError(
                    f"{path} differs between the immutable original snapshot "
                    f"{self.revision} and checkpoint API revision {revision}")
            return dict(kind="checkpoint-api-commit", revision=revision, sha256=digest)
        if path in RUNTIME_SOURCE_PATHS:
            revision = configured_runtime_revision()
            if revision is None:
                raise ValueError(
                    f"{path} belongs to the runtime implementation but no full "
                    "40-character runtime commit is configured")
            committed = read_blob(revision, path)
            if committed is None:
                raise ValueError(f"{path} is not present at runtime revision {revision}")
            if committed != text:
                raise ValueError(
                    f"{path} differs between the immutable original snapshot "
                    f"{self.revision} and runtime revision {revision}")
            return dict(kind="runtime-commit", revision=revision, sha256=digest)
        committed = read_blob(LEGACY_REVISION, path)
        if committed is None:
            raise ValueError(
                f"{path} is not owned by the checkpoint API, the runtime revision or "
                f"the legacy pin {LEGACY_REVISION}; refusing to attribute it")
        if committed != text:
            raise ValueError(
                f"{path} differs between the immutable original snapshot "
                f"{self.revision} and legacy revision {LEGACY_REVISION}")
        return dict(kind="legacy-commit", revision=LEGACY_REVISION, sha256=digest)

    def cleanup(self) -> None:
        with self._lock:
            root, self._root = self._root, None
        if root is not None:
            _remove_materialized_tree(root)


ORIGINAL = Provider(
    "original",
    ORIGINAL_REFERENCE,
    required_paths=RUNTIME_SOURCE_PATHS + CHECKPOINT_API_SOURCE_PATHS,
)

_CURRENT_LOCK = threading.Lock()
_CURRENT: Provider | None = None


def current_provider() -> Provider | None:
    """Return the optional current provider for the configured real commit.

    ``None`` means no implementation commit has been supplied.  A malformed
    value raises; there is no working-tree fallback.
    """
    revision = configured_refactor_revision()
    if revision is None:
        return None
    global _CURRENT
    with _CURRENT_LOCK:
        if _CURRENT is None or _CURRENT.revision != revision:
            require_commit(revision)
            _CURRENT = Provider("current", revision)
        return _CURRENT


def provider_text(path: str, provider: Provider = ORIGINAL) -> str:
    """Return normalized-LF text from ``provider`` (historical by default)."""
    return provider.text(path)


def provider_relpath(path: str) -> str:
    """Return the validated repository-relative POSIX form of ``path``."""
    return _validated_path(path).as_posix()
