"""Select the exact commit used for new or modified runtime source excerpts.

The historical 81 kernel lessons stay pinned to ``common.REVISION``.  The
310.9.16 / Small31 chapter also quotes files that did not exist at that pin
(for example ``dlssnr/small_model.py`` and ``csrc/kernel_launcher/
small_plan_generated.inl``).  Those files must never be attributed to the old
revision.

Until the root committer supplies the implementation commit, ``RUNTIME_REVISION``
is ``None``.  In that state the documentation build copies the exact normalized
LF working-tree files under ``docs/kernel-guide/source/`` and links to those
copies with an explicit working-tree/hash provenance.  Once a commit is
supplied, either by editing the constant below or by setting
``DLSSNR_RUNTIME_REVISION`` to the full 40-character SHA-1, every runtime
excerpt is verified against that committed blob before the link is emitted.

The checkpoint API is a separate source change, committed at
``8d2e104518df3f7cc993acad1edac93dbd5c3c9d``.  It modifies
``dlssnr/small_deployment.py`` (quoted by three runtime-page excerpts) and the
two historically pinned public-API companions ``dlssnr/__init__.py`` and
``dlssnr/checkpoint.py``.  Those three paths must not be attributed to
``RUNTIME_REVISION``.  They are pinned by ``CHECKPOINT_API_REVISION`` to that
accepted checkpoint implementation commit.  There is no fallback: a missing,
short or malformed pin is an error, and the guide must not be generated.
"""
from __future__ import annotations

import os
import re

#: Set by the root committer after the Small31 implementation is committed.
RUNTIME_REVISION = "266d69acf52dda413df3a874572f1156461f89ff"

#: The accepted checkpoint API implementation commit.  The changed loader and
#: its two public-API companions are pinned here and must never fall back to
#: ``RUNTIME_REVISION``.
CHECKPOINT_API_REVISION = "8d2e104518df3f7cc993acad1edac93dbd5c3c9d"

#: Every new or modified runtime/generation/source file the 310.9.16 chapter and
#: the two additive Small31 lessons rely on.  These paths are added to the
#: manifest even when a chapter does not quote an excerpt from them, so each file
#: gets its own hash and provenance classification.  The inventory scans the
#: real ``csrc`` tree without an exclusion list.
RUNTIME_SOURCE_PATHS = (
    # Additive Small31 attention entries and their exact local helpers.
    "csrc/kernel_impl/small_c1024_attention/fp16/small_global_attention_chained_c1024_fp16.cu",
    "csrc/kernel_impl/small_c1024_attention/fp8/small_global_attention_chained_c1024_fp8.cu",
    "csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh",
    "csrc/kernel_impl/small_c1024_attention/common/small_attention_abi.h",
    # Additive Small31 host and generated plan sources.
    "csrc/kernel_launcher/small_deployment.cpp",
    "csrc/kernel_launcher/small_deployment.h",
    "csrc/kernel_launcher/small_plan_generated.inl",
    "csrc/kernel_launcher/small_plan_fp16_generated.inl",
    "csrc/kernel_launcher/small_plan_geometry_generated.inl",
    "csrc/kernel_launcher/small_plan_geometry_fp16_generated.inl",
    "csrc/torch_api/small_extension.cpp",
    # Runtime model, extraction and schedule/generation sources.
    "dlssnr/model_specs.py",
    "dlssnr/runtime_assets.py",
    "dlssnr/small_model.py",
    "dlssnr/small_deployment.py",
    "dlssnr/video.py",
    "tools/extract_runtime_assets.py",
    "tools/compare_gameplay.py",
    "tools/kernel_sources.py",
    "setup.py",
    "tuning/physical_schedule.py",
    "tuning/generate_plan.py",
    "tuning/generate_small_plan.py",
)

#: Every path changed by the checkpoint API implementation commit.  All three
#: receive the distinct per-file provenance kind and an explicit manifest entry:
#: ``dlssnr/small_deployment.py`` is quoted by three runtime-page source excerpts,
#: while the two public-API companions are still listed, hashed and classified.
CHECKPOINT_API_SOURCE_PATHS = (
    "dlssnr/__init__.py",
    "dlssnr/checkpoint.py",
    "dlssnr/small_deployment.py",
)

#: The two-file subset of ``CHECKPOINT_API_SOURCE_PATHS`` that exists at the
#: historical pin.  The 122-path historical drift gate compares these against the
#: checkpoint API revision instead of rejecting the build; the loader is additive
#: at that pin and is covered by its explicit manifest provenance instead.
CHECKPOINT_API_HISTORICAL_PATHS = (
    "dlssnr/__init__.py",
    "dlssnr/checkpoint.py",
)
CHECKPOINT_API_CHANGED_PATHS = CHECKPOINT_API_SOURCE_PATHS

ENVIRONMENT_VARIABLE = "DLSSNR_RUNTIME_REVISION"
CHECKPOINT_API_ENVIRONMENT_VARIABLE = "DLSSNR_CHECKPOINT_API_REVISION"
_COMMIT_RE = re.compile(r"[0-9a-f]{40}")


def _validated_commit(value: str, variable: str) -> str:
    if not isinstance(value, str) or _COMMIT_RE.fullmatch(value) is None:
        raise ValueError(
            f"{variable} must be a full lowercase 40-character git SHA-1, "
            f"got {value!r}")
    return value


def configured_runtime_revision() -> str | None:
    """Return a validated runtime commit, or ``None`` for working-tree mode."""
    value = os.environ.get(ENVIRONMENT_VARIABLE, RUNTIME_REVISION)
    if value is None or value == "":
        return None
    return _validated_commit(value, ENVIRONMENT_VARIABLE)


def configured_checkpoint_api_revision() -> str | None:
    """Return the validated checkpoint API commit, or ``None`` when explicitly unset.

    The module constant defaults to the accepted checkpoint implementation
    commit, so the environment variable normally only overrides it.  ``None`` is
    never permission to attribute the changed loader to any older revision:
    consumers must refuse to generate or validate final documentation without a
    full 40-character commit.
    """
    value = os.environ.get(CHECKPOINT_API_ENVIRONMENT_VARIABLE, CHECKPOINT_API_REVISION)
    if value is None or value == "":
        return None
    return _validated_commit(value, CHECKPOINT_API_ENVIRONMENT_VARIABLE)


def revision_for(path: str) -> str | None:
    """Return the one revision that owns ``path``.

    Checkpoint-API sources take precedence and require the explicit pin; every
    other runtime source keeps the existing runtime-revision behavior.
    """
    if path in CHECKPOINT_API_SOURCE_PATHS:
        revision = configured_checkpoint_api_revision()
        if revision is None:
            raise ValueError(
                f"{path} belongs to the checkpoint API, which has no configured source "
                f"revision. Set {CHECKPOINT_API_ENVIRONMENT_VARIABLE} to the accepted full "
                "40-character checkpoint implementation commit before building the guide.")
        return revision
    return configured_runtime_revision()
