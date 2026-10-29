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
"""
from __future__ import annotations

import os
import re

#: Set by the root committer after the Small31 implementation is committed.
RUNTIME_REVISION = "266d69acf52dda413df3a874572f1156461f89ff"

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

ENVIRONMENT_VARIABLE = "DLSSNR_RUNTIME_REVISION"
_COMMIT_RE = re.compile(r"[0-9a-f]{40}")


def configured_runtime_revision() -> str | None:
    """Return a validated runtime commit, or ``None`` for working-tree mode."""
    value = os.environ.get(ENVIRONMENT_VARIABLE, RUNTIME_REVISION)
    if value is None or value == "":
        return None
    if not isinstance(value, str) or _COMMIT_RE.fullmatch(value) is None:
        raise ValueError(
            f"{ENVIRONMENT_VARIABLE} must be a full lowercase 40-character git SHA-1, "
            f"got {value!r}")
    return value
