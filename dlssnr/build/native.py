"""Native source/header discovery and deterministic build-cache identity.

The module is standard-library only.  Importing it reads nothing and starts no
process; every helper reads the source tree only when it is called.  The source
layout and the 83-kernel translation-unit gate remain the ones setup.py used
before this package existed.
"""
from __future__ import annotations

from hashlib import sha256
import json
import os
from pathlib import Path

# Both roots are required: csrc resolves the established tree, while
# csrc/include resolves <flashlight/...> and <dlssnr/abi/...>.
NATIVE_INCLUDE_ROOTS = ("csrc", "csrc/include")
HEADER_SUFFIXES = frozenset({".h", ".hpp", ".cuh"})
DEPENDENCY_SUFFIXES = frozenset({".h", ".hpp", ".cuh", ".inl"})
TEMPLATE_MANIFEST = "csrc/kernel_impl/shared/common/kernel_templates.json"
LOGICAL_KERNEL_COUNT = 83
CACHE_KEY_FORMAT = "dlssnr-native-cache-v2"
CPP_STANDARD = "c++17"
# Setup/build inputs that are consumed by code generation or target selection
# rather than by the compiler's include graph.
BUILD_INPUT_FILES = (
    "MANIFEST.in",
    "pyproject.toml",
    "setup.py",
    "dlssnr/build/native.py",
    "dlssnr/build/resolution.py",
    "dlssnr/build/targets.py",
    "dlssnr/build/toolchain.py",
)
POLICY_GLOB = "tuning/sm_*.json"

__all__ = [
    "NATIVE_INCLUDE_ROOTS",
    "HEADER_SUFFIXES",
    "DEPENDENCY_SUFFIXES",
    "TEMPLATE_MANIFEST",
    "LOGICAL_KERNEL_COUNT",
    "CPP_STANDARD",
    "BUILD_INPUT_FILES",
    "POLICY_GLOB",
    "cuda_sources",
    "host_sources",
    "translation_units",
    "native_headers",
    "native_dependencies",
    "build_inputs",
    "include_directories",
    "kernel_templates",
    "expected_cuda_units",
    "cxx_standard_flags",
    "nvcc_standard_flags",
    "build_cache_key",
]


def _root(root):
    return Path(root).resolve()


def cuda_sources(root):
    """CUDA translation units, in the stable order setup.py has always used."""
    return tuple(sorted((_root(root) / "csrc/kernel_impl").rglob("*.cu")))


def host_sources(root):
    """Host translation units: launchers first, then Torch registration."""
    csrc = _root(root) / "csrc"
    return tuple(sorted((csrc / "kernel_launcher").glob("*.cpp")) +
                 sorted((csrc / "torch_api").glob("*.cpp")))


def translation_units(root):
    """All compiled native sources in extension source-list order."""
    return cuda_sources(root) + host_sources(root)


def native_headers(root):
    """Every C/C++ header under csrc, including nested FlashLight/ABI headers."""
    csrc = _root(root) / "csrc"
    return tuple(sorted(path for path in csrc.rglob("*")
                        if path.is_file() and path.suffix in HEADER_SUFFIXES))


def native_dependencies(root):
    """Headers, generated launch tables and template metadata for invalidation."""
    root = _root(root)
    paths = {path for path in (root / "csrc").rglob("*")
             if path.is_file() and path.suffix in DEPENDENCY_SUFFIXES}
    template = root / TEMPLATE_MANIFEST
    if template.is_file():
        paths.add(template)
    return tuple(sorted(paths))


def build_inputs(root):
    """Non-compiler inputs consumed by setup/build helper configuration.

    This adds the packaging/helper modules, every per-device policy file and
    the receipt bytes referenced by those policies. Missing optional inputs are
    skipped so the helper also works with a minimal source fixture.
    """
    root = _root(root)
    paths = {root / relative for relative in BUILD_INPUT_FILES
             if (root / relative).is_file()}
    policies = sorted((root / "tuning").glob("sm_*.json"))
    paths.update(policies)
    for policy_path in policies:
        try:
            policy = json.loads(policy_path.read_text(encoding="utf8"))
        except (OSError, ValueError):
            continue
        if not isinstance(policy, dict):
            continue
        for collection in ("anchors", "admissions"):
            rows = policy.get(collection)
            if not isinstance(rows, list):
                continue
            for row in rows:
                if not isinstance(row, dict):
                    continue
                receipt = row.get("receipt")
                if not isinstance(receipt, str) or not receipt:
                    continue
                path = (root / receipt).resolve()
                if path.is_relative_to(root) and path.is_file():
                    paths.add(path)
    return tuple(sorted(paths))


def include_directories(root):
    """The established csrc root plus the FlashLight/ABI include root."""
    root = _root(root)
    return tuple(str(root / relative) for relative in NATIVE_INCLUDE_ROOTS)


def kernel_templates(root):
    return json.loads((_root(root) / TEMPLATE_MANIFEST).read_text(encoding="utf8"))["entries"]


def expected_cuda_units(root):
    """Preserve setup.py's logical-kernel translation-unit census gate."""
    entries = kernel_templates(root)
    return LOGICAL_KERNEL_COUNT - len(entries) + len({entry["source"] for entry in entries})


def cxx_standard_flags(platform_name=None):
    """C++17 flags for the host compiler; an explicit nvcc flag is separate."""
    platform_name = os.name if platform_name is None else platform_name
    return ["/std:c++17"] if platform_name == "nt" else ["-std=c++17"]


def nvcc_standard_flags():
    """nvcc's own C++17 selection; PyTorch otherwise supplies its default."""
    return ["-std=c++17"]


def build_cache_key(root, *, architecture=None, build_mode=None, compile_flags=(),
                    build_environment=None):
    """Digest sources, nested headers, generated tables and helper configuration.

    Content bytes, not mtimes, define identity, so touching a file does not
    invalidate work while changing a FlashLight, ABI or common header does.
    build_environment records the selected toolchain overrides that are not
    already represented by architecture/build mode/flags.
    """
    root = _root(root)
    configuration = dict(
        architecture=architecture,
        build_mode=build_mode,
        include_roots=list(NATIVE_INCLUDE_ROOTS),
        compile_flags=[str(flag) for flag in compile_flags],
        build_environment={str(key): str(value)
                           for key, value in (build_environment or {}).items()
                           if value is not None},
    )
    digest = sha256()
    digest.update(CACHE_KEY_FORMAT.encode("ascii") + b"\0")
    digest.update(json.dumps(configuration, sort_keys=True, separators=(",", ":"),
                             ensure_ascii=False).encode("utf8"))
    inputs = {*translation_units(root), *native_dependencies(root), *build_inputs(root)}
    for path in sorted(inputs):
        digest.update(b"\0file\0")
        digest.update(path.relative_to(root).as_posix().encode("utf8"))
        digest.update(b"\0")
        digest.update(path.read_bytes())
    return digest.hexdigest()
