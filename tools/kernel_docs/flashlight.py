"""Additive FlashLight chapter built from one real implementation commit.

The module deliberately does nothing at import time.  In particular it does not
read a source tree, materialize a provider, emit an excerpt, or touch the two
documentation registries.  ``build_chapter(provider, evidence=None)`` is called
by the builder only after ``current_provider()`` has returned a provider for an
existing implementation commit.

Every excerpt is anchored by an exact source substring that must occur exactly
once in the provider's committed text.  A missing or ambiguous anchor is a build
error; there is no line-number guess and no working-tree fallback.  The same
source path may be quoted several times, which is why the current excerpts live
in their own manifest namespace (``CURRENT_SNIPPETS``) rather than in the frozen
1,570-entry historical registry.

The chapter uses the six sections in this teaching order:

1. ``problem``       - the whole C1024 FFN model operation and its physical contract
2. ``cta``           - the 128x128 CTA subproblem and four 64x64 warp tiles
3. ``warp``          - lane-owned fragments and thread duties
4. ``resources``     - the resource budget: shared bytes, declared registers, ptxas
5. ``schedule``      - the three-slot pipeline and explicit synchronization
6. ``trace``         - one token's contribution traced through the committed source
"""
from __future__ import annotations

from html import escape
from pathlib import Path
import re
import xml.etree.ElementTree as ET

from common import CURRENT_SNIPPETS, code, note, source_url
from common import svg
from flashlight_evidence import (
    Acceptance,
    EvidenceError,
    FinalEvidence,
    PtxasRecord,
    format_ms,
    format_range,
    format_speedup,
    load_acceptance,
)
from source_providers import Provider, SourceProviderError, require_commit

#: The exact public commit shape accepted for a current implementation provider.
_COMMIT = re.compile(r"[0-9a-f]{40}")

#: The six forward-design section identifiers, in reading order.
SECTION_IDS = ("problem", "cta", "warp", "resources", "schedule", "trace")

#: Minimum number of bespoke inline SVG figures in the chapter.
MIN_DIAGRAMS = 6

#: Content the resource-budget section must actually carry.  These are teaching
#: contracts (static shared bytes, declared register payload, compiler ptxas
#: allocation), not a mirror of a particular paragraph or line count.
RESOURCE_BUDGET_MARKERS = ("24,600", "shared", "register", "ptxas")

#: Environment variable for an optional accepted measurement record.
EVIDENCE_ENVIRONMENT_VARIABLE = "DLSSNR_FLASHLIGHT_EVIDENCE"

#: Fixed model/FFN geometry used by the worked trace.  These are recovered
#: source constants, not benchmark inputs.
TOKENS_PER_CTA = 128
CHANNELS_PER_CTA = 128
TOKENS_PER_WARP = 64
CHANNELS_PER_WARP = 64
INPUT_CHANNELS = 1024
OUTPUT_CHANNELS = 4096
REDUCTION_STEP = 32
MMA_K = 16
STAGE_BYTES = 8192
STAGE_COUNT = 3
BARRIER_BYTES = 8
SHARED_BYTES = STAGE_COUNT * STAGE_BYTES + STAGE_COUNT * BARRIER_BYTES
BARRIER_BASE = STAGE_COUNT * STAGE_BYTES
TOKEN_GROUP = 16
ELEMENT_BYTES = 2

#: One worked trace: first token tile / output block, batch-head slice 0.
TRACE_TOKEN = 37
TRACE_K = 146
TRACE_OUTPUT = 81
TRACE_ITERATION = 4
TRACE_SLOT = 1


class ChapterError(ValueError):
    """The current chapter cannot be built from the supplied provider."""


# ``FinalEvidence``/``PtxasRecord``/``EvidenceError`` are imported from the
# shared typed acceptance module.  The chapter consumes the validated record;
# it never defines a second schema and it never treats a ptxas-only sketch as
# runtime acceptance.


# ---------------------------------------------------------------------------
# Pure token/address math (also exercised by the focused CPU tests)
# ---------------------------------------------------------------------------


def mma_a_lane_map(lane: int) -> dict:
    """Return the m16n8k16 A-fragment rows and K columns owned by ``lane``."""
    if not 0 <= lane < 32:
        raise ValueError(f"lane must be in 0..31, got {lane}")
    group, thread = divmod(lane, 4)
    return dict(group=group, thread=thread, rows=(group, group + 8),
                k=(thread * 2, thread * 2 + 1, thread * 2 + 8, thread * 2 + 9))


def mma_b_lane_map(lane: int) -> dict:
    """Return the m16n8k16 B-fragment column and K rows owned by ``lane``."""
    if not 0 <= lane < 32:
        raise ValueError(f"lane must be in 0..31, got {lane}")
    group, thread = divmod(lane, 4)
    return dict(group=group, thread=thread, column=group,
                k=(thread * 2, thread * 2 + 1, thread * 2 + 8, thread * 2 + 9))


def mma_c_lane_map(lane: int) -> dict:
    """Return the two output rows and columns of the C fragment for ``lane``."""
    if not 0 <= lane < 32:
        raise ValueError(f"lane must be in 0..31, got {lane}")
    group, thread = divmod(lane, 4)
    return dict(group=group, thread=thread, rows=(group, group + 8),
                columns=(thread * 2, thread * 2 + 1))


def a_uint4_coordinates(lane: int, token_base: int, k_base: int) -> list[tuple]:
    """Return ``(word, token, channel_low, channel_high)`` for one A uint4.

    ``token_base`` is the first token of the 16-token fragment and ``k_base`` is
    the first channel of the K16 subtile.  This mirrors the m16n8k16 A layout:
    x/y carry the low K8 half, z/w the high K8 half; rows are group and group+8.
    """
    group, thread = divmod(lane, 4)
    k0 = k_base + thread * 2
    rows = (token_base + group, token_base + group + 8)
    return [
        ("x", rows[0], k0, k0 + 1),
        ("y", rows[1], k0, k0 + 1),
        ("z", rows[0], k0 + 8, k0 + 9),
        ("w", rows[1], k0 + 8, k0 + 9),
    ]


def b_uint4_coordinates(lane: int, n8_base: int, k_base: int) -> list[tuple]:
    """Return ``(word, output, channel_low, channel_high)`` for one B uint4.

    x/y are the low N8 fragment; z/w are the adjacent high N8 fragment.  All
    four words use the same column offsets inside their own N8 tile.
    """
    group, thread = divmod(lane, 4)
    k0 = k_base + thread * 2
    low_column = n8_base + group
    high_column = low_column + 8
    return [
        ("x", low_column, k0, k0 + 1),
        ("y", low_column, k0 + 8, k0 + 9),
        ("z", high_column, k0, k0 + 1),
        ("w", high_column, k0 + 8, k0 + 9),
    ]


def ffn_input_fragment(token: int, channel: int, *, token_tile: int = 0,
                       iteration: int | None = None) -> dict:
    """Return the exact A-fragment/address location of ``X[token, channel]``.

    The token tile is the first tile and the batch/head slice is zero, matching
    the worked trace.  Global and shared offsets are bytes.
    """
    if not 0 <= token < TOKENS_PER_CTA:
        raise ValueError(f"token must be in the first {TOKENS_PER_CTA}-token tile")
    if not 0 <= channel < INPUT_CHANNELS:
        raise ValueError(f"channel must be in 0..{INPUT_CHANNELS - 1}")
    token_group, local_row = divmod(token, TOKEN_GROUP)
    expected_iteration, local_k32 = divmod(channel, REDUCTION_STEP)
    if iteration is None:
        iteration = expected_iteration
    elif iteration != expected_iteration:
        raise ValueError("channel and reduction iteration disagree")
    k_sub, local_k = divmod(local_k32, MMA_K)
    lane = (local_row % 8) * 4 + (local_k % 8) // 2
    word = ("x" if local_k < 8 else "z") if local_row < 8 else (
        "y" if local_k < 8 else "w")
    half = "low" if local_k % 2 == 0 else "high"
    word_index = ("x", "y", "z", "w").index(word)
    half_index = 0 if half == "low" else 1
    relative = k_sub * 512 + lane * 16 + word_index * 4 + half_index * 2
    producer_warp = token_group % 4
    copy_group = token_group // 4
    global_slab = token_group * TOKEN_GROUP * INPUT_CHANNELS * ELEMENT_BYTES \
        + iteration * 1024
    shared_slab = (iteration % STAGE_COUNT) * STAGE_BYTES \
        + producer_warp * 1024 + copy_group * 4096
    return dict(token=token, channel=channel, token_group=token_group,
                local_row=local_row, iteration=iteration, k_sub=k_sub,
                local_k=local_k, lane=lane, word=word, half=half,
                relative=relative, global_slab=global_slab,
                shared_slab=shared_slab, global_byte=global_slab + relative,
                shared_byte=shared_slab + relative,
                producer_warp=producer_warp, copy_group=copy_group,
                uint4=a_uint4_coordinates(lane, token_group * TOKEN_GROUP, k_sub * MMA_K + iteration * REDUCTION_STEP))


def ffn_weight_fragment(k: int, output: int) -> dict:
    """Return the exact B-fragment/address location of ``W[k, output]``."""
    if not 0 <= k < INPUT_CHANNELS:
        raise ValueError(f"k must be in 0..{INPUT_CHANNELS - 1}")
    if not 0 <= output < OUTPUT_CHANNELS:
        raise ValueError(f"output must be in 0..{OUTPUT_CHANNELS - 1}")
    panel, local_k = divmod(k, MMA_K)
    output_block, rem = divmod(output, 128)
    column_half, rem = divmod(rem, 64)
    n16_group, local_n = divmod(rem, 16)
    n8_group, column = divmod(local_n, 8)
    lane = column * 4 + (local_k % 8) // 2
    if local_k < 8:
        word = "x" if n8_group == 0 else "z"
    else:
        word = "y" if n8_group == 0 else "w"
    half = "low" if local_k % 2 == 0 else "high"
    word_index = ("x", "y", "z", "w").index(word)
    half_index = 0 if half == "low" else 1
    relative = lane * 16 + word_index * 4 + half_index * 2
    n8_base = output_block * 128 + column_half * 64 + n16_group * 16
    global_byte = panel * 131072 + output_block * 4096 + column_half * 2048 \
        + n16_group * 512 + relative
    return dict(k=k, output=output, panel=panel, local_k=local_k,
                output_block=output_block, column_half=column_half,
                n16_group=n16_group, local_n=local_n, n8_group=n8_group,
                column=column, lane=lane, word=word, half=half,
                relative=relative, global_byte=global_byte,
                uint4=b_uint4_coordinates(lane, n8_base, panel * MMA_K))


def ffn_output_location(token: int, output: int) -> dict:
    """Return the exact accumulator and byte location of ``Y[token, output]``."""
    if not 0 <= token < TOKENS_PER_CTA:
        raise ValueError(f"token must be in the first {TOKENS_PER_CTA}-token tile")
    if not 0 <= output < OUTPUT_CHANNELS:
        raise ValueError(f"output must be in 0..{OUTPUT_CHANNELS - 1}")
    token_group, local_row = divmod(token, TOKEN_GROUP)
    row_group = token // TOKENS_PER_WARP
    within_warp = token % TOKENS_PER_WARP
    output_block, rem = divmod(output, CHANNELS_PER_CTA)
    column_half, rem = divmod(rem, 64)
    n16_group, local_n = divmod(rem, 16)
    n8_group, column = divmod(local_n, 8)
    lane = (within_warp % 8) * 4 + column // 2
    word = n8_group * 2 + (1 if within_warp % 16 >= 8 else 0)
    half = "low" if column % 2 == 0 else "high"
    half_index = 0 if half == "low" else 1
    warp = row_group * 2 + column_half
    start = token_group * 131072 + output_block * 4096 \
        + column_half * 2048 + lane * 16 + n16_group * 512
    return dict(token=token, output=output, token_group=token_group,
                local_row=local_row, row_group=row_group,
                within_warp=within_warp, output_block=output_block,
                warp=warp, m_fragment=within_warp // 16,
                n16_group=n16_group, n8_group=n8_group, column=column,
                lane=lane, word=word, half=half, uint4_start=start,
                byte=start + word * 4 + half_index * 2)


def shared_slot_base(slot: int) -> int:
    return slot * STAGE_BYTES


def shared_slab_base(slot: int, producer_warp: int, copy_group: int) -> int:
    return shared_slot_base(slot) + producer_warp * 1024 + copy_group * 4096


def shared_lane_byte(slot: int, producer_warp: int, copy_group: int,
                     k_sub: int, lane: int) -> int:
    return shared_slab_base(slot, producer_warp, copy_group) + k_sub * 512 + lane * 16


# ---------------------------------------------------------------------------
# Anchored excerpts, tables and evidence
# ---------------------------------------------------------------------------


def _anchor_span(text: str, anchor: str) -> tuple[int, int]:
    """Return the 1-based inclusive line span of a unique exact anchor."""
    if not anchor:
        raise ChapterError("empty source anchor")
    occurrences = text.count(anchor)
    if occurrences != 1:
        preview = anchor.strip().splitlines()[0][:80]
        raise ChapterError(
            f"source anchor must occur exactly once, found {occurrences}: {preview!r}")
    index = text.index(anchor)
    start = text.count("\n", 0, index) + 1
    lines = anchor.count("\n")
    if anchor.endswith("\n"):
        lines -= 1
    return start, start + lines


def _require_current_provider(provider) -> str:
    """Validate a real current provider and its commit before reading source.

    A duck-typed object with a plausible ``name`` and 40-hex ``revision`` is not
    enough: the provider must be the actual immutable source-provider class, it
    must be the ``current`` namespace, and its commit must exist in the
    repository.  This rejects a worktree-backed stand-in even when it carries an
    arbitrary 40-hex revision.
    """
    if provider is None:
        raise ChapterError(
            "FlashLight chapter needs a current provider for a real implementation "
            "commit; no chapter may be generated from the working tree")
    if not isinstance(provider, Provider):
        raise ChapterError(
            "FlashLight chapter requires an actual source_providers.Provider "
            f"instance for the current namespace, got {type(provider).__name__}")
    if getattr(provider, "name", None) != "current":
        raise ChapterError(
            f"FlashLight chapter requires the current provider, got "
            f"{getattr(provider, 'name', None)!r}")
    revision = getattr(provider, "revision", None)
    if not isinstance(revision, str) or _COMMIT.fullmatch(revision) is None:
        raise ChapterError(
            "current provider revision must be a full lowercase 40-character commit")
    try:
        require_commit(revision)
    except (SourceProviderError, ValueError, OSError) as exc:
        raise ChapterError(
            f"current provider commit {revision} is not a real repository commit: {exc}"
        ) from exc
    return revision


def preflight_worktree_anchors(root=None, anchors=None) -> list[str]:
    """Check anchors against uncommitted worktree text only as a preflight.

    This deliberately constructs no provider and emits no excerpt.  A clean
    result means only that the current editing tree still contains each exact
    substring once; it is not source provenance and never authorizes a current
    page.  Committed generation still uses :func:`build_chapter` with a real
    ``Provider("current", ...)``.
    """
    base = Path(root) if root is not None else Path(__file__).resolve().parents[2]
    table = ANCHORS if anchors is None else anchors
    problems = []
    for key, (path, anchor) in table.items():
        target = base / path
        if not target.is_file():
            problems.append(f"{key}: {path} is absent from the worktree preflight")
            continue
        text = target.read_text(encoding="utf-8")
        text = text.replace("\r\n", "\n").replace("\r", "\n")
        occurrences = text.count(anchor)
        if occurrences != 1:
            problems.append(
                f"{key}: worktree anchor occurs {occurrences} times in {path}")
    return problems


def _require_path(provider, path: str) -> str:
    """Return provider text and fail clearly when a declared path is absent."""
    if not provider.exists(path):
        raise ChapterError(f"{path} is absent at current implementation commit "
                           f"{provider.revision}")
    return provider.text(path)


#: Exact, unique source anchors.  Values are ``(path, exact substring)``.
#: A path may appear many times; each entry is checked independently.
ANCHORS: dict[str, tuple[str, str]] = {
    "ffn_signature": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "__shared__ __align__(512) unsigned char s_Storage[FProfile::barrier_base + 24];"),
    "ffn_views": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "using StageInputSharedView ="),
    "ffn_fragment_view": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "const FragmentSharedView StageFragments(Shared);"),
    "ffn_barrier_ring": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "const flashlight::memory::TransactionBarrierRing<FProfile::stage_count> BarrierRing("),
    "ffn_input_address": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "g_Input + uint64_t(g_InputGroup) * 16384 * FProfile::element_bytes + ReductionTile * 1024;"),
    "ffn_producer": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "if (flashlight::arch::is_copy_producer(0xffffffffu))"),
    "ffn_copy_expect": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "s_Barrier.copy_then_expect("),
    "ffn_barrier_init": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "BarrierRing.at_slot(s_StageIndex).initialize(blockDim.x * blockDim.y);"),
    "ffn_wait_stage": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "BarrierRing.for_iteration(Iteration).arrive_and_wait();"),
    "ffn_weight_registers": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "uint4 r_Weight[2][4];"),
    "ffn_weight_base": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "g_PackedWeights + g_OutputBlock * 4096 + (threadIdx.y & 1) * 2048 + threadIdx.x * 16;"),
    "ffn_weight_load": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "flashlight::memory::load_vector<"),
    "ffn_prime": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "LoadWeights(0);"),
    "ffn_accumulator": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "flashlight::tile::TiledMmaAccumulator<4, 4> r_Accumulator{};"),
    "ffn_fragment_load": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "StageFragments.load_slot(s_StageIndex, Warp / 2, r_MTile, r_KTile, Lane);"),
    "ffn_tiled_mma": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "flashlight::tile::accumulate_tile<FProfile::precision>(r_Accumulator, r_Input, r_Weight);"),
    "ffn_refill": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "StageInput(ReductionTile + FProfile::stage_count, s_StageIndex);"),
    "ffn_activation": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "dlssnr::ops::ffn_activation("),
    "ffn_output": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "const uint64_t g_Output = Parameters.g_Output +"),
    "ffn_store": (
        "csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
        "flashlight::memory::store_no_allocate(flashlight::memory::GlobalAddress(g_Output + r_NTile * 512),"),
    "profile": (
        "csrc/common/layout/global_profiles.h",
        "template <bool Fp8Storage> struct GlobalFfnExpandProfile"),
    "constants": (
        "csrc/common/layout/numerical_constants.h",
        "inline constexpr std::uint32_t ffn_clamp_upper_half2"),
    "activation": (
        "csrc/common/ops/activation.h",
        "const flashlight::PackedHalf2 upper_clamped ="),
    "small_policy": (
        "csrc/common/ops/small_attention.h",
        "__device__ __forceinline__ float clamp_denominator_float(float denominator, float epsilon)"),
    "core_traits": (
        "csrc/include/flashlight/core.cuh",
        "template <InputPrecision Precision> struct MmaAFragment"),
    "core_accumulator": (
        "csrc/include/flashlight/core.cuh",
        "template <> struct MmaAccumulator<AccumulatorPrecision::Half>"),
    "mma_ptx": (
        "csrc/include/flashlight/arch/mma.cuh",
        'asm volatile("mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16'),
    "warp_election": (
        "csrc/include/flashlight/arch/warp.cuh",
        "__device__ __forceinline__ std::uint32_t is_copy_producer(std::uint32_t member_mask)"),
    "async_bulk": (
        "csrc/include/flashlight/arch/async.cuh",
        'asm volatile("cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes'),
    "async_fallback": (
        "csrc/include/flashlight/arch/async.cuh",
        "const std::uint32_t lane = warp_lane();"),
    "async_expect": (
        "csrc/include/flashlight/arch/async.cuh",
        "asm volatile(\"mbarrier.expect_tx.relaxed.cta.shared::cta.b64 [%0],%1;\""),
    "memory_store": (
        "csrc/include/flashlight/arch/memory.cuh",
        '"{ .reg .b128 r_StoreVector; mov.b128 r_StoreVector,{%1,%2,%3,%4}; st.global.L1::no_allocate.b128 [%0],r_StoreVector; }"'),
    "packed_fma": (
        "csrc/include/flashlight/numeric/packed.cuh",
        "__device__ __forceinline__ PackedHalf2 half2_fma("),
    "strided_layout": (
        "csrc/include/flashlight/layout/strided.cuh",
        "template <std::uint32_t... Strides> struct ByteStrides;"),
    "views_slot": (
        "csrc/include/flashlight/memory/views.cuh",
        "__device__ __forceinline__ std::uint32_t byte_offset_slot(std::uint32_t slot,"),
    "pipeline_group": (
        "csrc/include/flashlight/memory/pipeline.cuh",
        "class AsyncCopyGroup"),
    "pipeline_barrier": (
        "csrc/include/flashlight/memory/pipeline.cuh",
        "class TransactionBarrier\n{"),
    "pipeline_copy_expect": (
        "csrc/include/flashlight/memory/pipeline.cuh",
        "__device__ __forceinline__ void copy_then_expect("),
    "pipeline_poll": (
        "csrc/include/flashlight/memory/pipeline.cuh",
        "__device__ __forceinline__ void arrive_and_wait(std::uint32_t arrival_count = 1) const"),
    "publication_split": (
        "csrc/include/flashlight/memory/publication.cuh",
        "class SplitPublication"),
    "publication_acquire": (
        "csrc/include/flashlight/memory/publication.cuh",
        "Issue once after polling, then perform the caller-owned CTA barrier."),
    "memory_acquire": (
        "csrc/include/flashlight/arch/memory.cuh",
        "Complete the acquire pattern after observing a predecessor's release counter."),
    "publication_accumulate": (
        "csrc/include/flashlight/memory/publication.cuh",
        "__device__ __forceinline__ void accumulate_exclusive_half2x4("),
    "tile_storage": (
        "csrc/include/flashlight/tile/mma.cuh",
        "template <int SpatialFragments, int ChannelGroups> struct TiledMmaAccumulator"),
    "tile_loop": (
        "csrc/include/flashlight/tile/mma.cuh",
        "for (int reduction_subtile = 0; reduction_subtile < ReductionSubtiles;"),
    "permutation": (
        "csrc/include/flashlight/warp/permutation.cuh",
        "template <typename T> __device__ __forceinline__ void permute_quad(T (&words)[4], int permutation)"),
    "abi_record": (
        "csrc/include/dlssnr/abi/kernel_parameters.h",
        "struct alignas(8) FGlobalFfnExpandC1024Fp16Parameters"),
    "host_validation": (
        "csrc/common/host/physical_tensor.h",
        "inline bool IsAligned16(uintptr_t Address)"),
    "host_binding": (
        "csrc/common/host/parameter_binding.h",
        "inline void BindTensorAddress(FParameterBlock& Block, size_t Offset, const at::Tensor& Tensor,"),
    "host_prepare": (
        "csrc/common/host/deployment_runtime.h",
        "PreparePlanKernels(const std::vector<TKernelCall>& Calls, int DeviceIndex,"),
    "host_boxed": (
        "csrc/common/host/boxed_dispatch.h",
        "InvokeBoxedPreparedKernel(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack)"),
    "repack": (
        "csrc/common/layout/global_repack.h",
        "return (token_index / 16u) * (16u * WordsPerToken) + (channel_word / 8u) * 128u +"),
    "spatial": (
        "csrc/common/layout/spatial_projection.h",
        "spatial_projection_plane_word_address(std::uint64_t base, int channel_panel, int y, int x,"),
}

#: ``(path, layer, responsibility, representative names)`` for the current
#: implementation.  Build-time verification requires every path to exist at the
#: provider commit and every representative name to occur in that file.
MODULES: tuple[tuple[str, str, str, tuple[str, ...]], ...] = (
    ("csrc/include/flashlight/core.cuh", "core carriers / traits",
     "precision tags, packed carriers, fragment size and alignment contracts",
     ("InputPrecision", "MmaAFragment", "MmaBFragment", "MmaAccumulator")),
    ("csrc/include/flashlight/arch/mma.cuh", "canonical raw MMA owner",
     "the four recovered mma.sync forms and typed dispatch",
     ("mma_sync_f16_half_raw", "mma_sync_f16_float_raw", "mma_sync_e4m3_half_raw", "mma_sync")),
    ("csrc/include/flashlight/arch/warp.cuh", "warp-control ISA",
     "election, shuffles and movmatrix; no ldmatrix path",
     ("is_copy_producer", "elect_one", "shuffle_index", "transpose_m8n8")),
    ("csrc/include/flashlight/arch/async.cuh", "async-copy / barrier ISA",
     "bulk copy, lane-striped cp.async fallback, barrier init/expect/arrive/ready",
     ("copy_bulk_transaction", "barrier_init", "barrier_expect", "barrier_arrive", "barrier_ready")),
    ("csrc/include/flashlight/arch/memory.cuh", "memory / ordering ISA",
     "cache-qualified loads, no-allocate stores, counter and fence primitives",
     ("load_global_ca", "store_no_allocate", "load_relaxed_counter_bits", "acquire_split_publication_fence")),
    ("csrc/include/flashlight/arch/math.cuh", "scalar exact math",
     "FTZ/approx/rounding/compare instructions with explicit register class",
     ("multiply_ftz", "rsqrt_approx_ftz", "convert_rn_f16_f32_bits", "compare_less_unordered_ftz_bits")),
    ("csrc/include/flashlight/numeric/packed.cuh", "packed numeric composition",
     "bit-preserving Half2 and E4M3 carriers, ordered arithmetic",
     ("half2_fma", "half2_minimum", "half2_multiply", "publish_e4x4", "decode_e4x2")),
    ("csrc/include/flashlight/layout/strided.cuh", "compile-time byte layout",
     "caller-supplied byte-stride packs folded at compile time; zero swizzle",
     ("ByteStrides",)),
    ("csrc/include/flashlight/memory/views.cuh", "typed views",
     "byte-origin views, slot vs iteration APIs, cache-policy loads and stores",
     ("SharedBytes", "SharedLayoutView", "StagedSharedLayoutView", "byte_offset_slot", "store_no_allocate")),
    ("csrc/include/flashlight/memory/pipeline.cuh", "async lifecycles",
     "distinct copy-group and transaction-barrier lifecycles; opaque tokens",
     ("AsyncCopyGroup", "TransactionBarrier", "copy_then_expect", "arrive_and_wait")),
    ("csrc/include/flashlight/memory/publication.cuh", "split publication",
     "counter ordering and exclusive Half4 accumulation",
     ("SplitPublication", "accumulate_exclusive_half2x4")),
    ("csrc/include/flashlight/tile/mma.cuh", "ordered tile accumulation",
     "compile-time fragment arrays and fixed low-N8/high-N8 issue order",
     ("TiledMmaAccumulator", "accumulate_tile")),
    ("csrc/include/flashlight/warp/permutation.cuh", "register permutations",
     "four-value in-register permutation and packed shuffle",
     ("permute_quad", "shuffle_index")),
    ("csrc/common/layout/global_profiles.h", "project layout profiles",
     "FFN/attention/connector tile, stage and barrier constants",
     ("GlobalFfnExpandProfile", "GlobalContractProfile", "GlobalAttentionProfile")),
    ("csrc/common/layout/numerical_constants.h", "project numerical data",
     "exact activation and normalization constants",
     ("ffn_clamp_upper_half2", "ffn_abs_slope_half2", "normalization_epsilon_half2")),
    ("csrc/common/layout/global_repack.h", "project physical repack",
     "recovered 16-token dword map and 4x4 spatial token map",
     ("repack_physical_word", "repack_spatial_token")),
    ("csrc/common/layout/spatial_projection.h", "project spatial layout",
     "C512 plane addressing and incomplete-edge policy",
     ("spatial_projection_plane_word_address", "resolve_spatial_projection_input_tile")),
    ("csrc/common/ops/activation.h", "project activation",
     "clamped packed-Half FFN polynomial with exact rounding order",
     ("clamped_half_polynomial", "ffn_activation")),
    ("csrc/common/ops/global_attention.h", "project attention",
     "global key/value staging, head sums and normalization",
     ("GlobalAttentionKeyView", "sum_head_channels", "normalize_head")),
    ("csrc/common/ops/window_attention.h", "project window attention",
     "window experts, softmax, pooling and FFN compositions",
     ("compute_window_expert", "softmax_window", "normalize_window")),
    ("csrc/common/ops/frontend_texture.h", "project frontend / texture PTX owner",
     "texture and surface instructions plus model-neutral pixel composition",
     ("native_texture_2d", "native_surface_2d", "sample_texture", "pixel_noise")),
    ("csrc/common/ops/small_attention.h", "project Small31 policy",
     "persistent FP32 PV numerator and denominator; not a generic primitive",
     ("pack_float_columns_half2", "widen_half_pair_float2", "clamp_denominator_float")),
    ("csrc/common/host/physical_tensor.h", "host physical contracts",
     "dtype/device/extent/alignment/disjointness/capture validation",
     ("IsAligned16", "ValidatePlanPhysicalBuffer", "RequireOutsideCapture")),
    ("csrc/common/host/parameter_binding.h", "host raw-ABI binding",
     "typed writes into the fixed launch record",
     ("FParameterBlock", "BindTensorAddress", "WriteParameterField")),
    ("csrc/common/host/deployment_runtime.h", "host deployment runtime",
     "plan preparation, verification, introspection and replay",
     ("PreparePlanKernels", "RunPlanCalls", "PlanGuardsIntact")),
    ("csrc/common/host/boxed_dispatch.h", "host boxed registration",
     "one CUDA/Meta boxed invocation mechanism",
     ("InvokeBoxedPreparedKernel", "RegisterBoxedPreparedImplementations")),
    ("csrc/include/dlssnr/abi/kernel_parameters.h", "public ABI",
     "recovered parameter records with fixed size and offsets",
     ("FGlobalFfnExpandC1024Fp16Parameters", "FGlobalFfnExpandC1024Fp8Parameters")),
    ("csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu",
     "exported kernel",
     "launch, storage, schedule, accumulation, activation and publication",
     ("global_ffn_expand_c1024_fp16", "StageInput", "LoadWeights", "accumulate_tile")),
)

#: Python/build paths cited as ownership links but not quoted as C++ excerpts.
LINKED_PATHS = (
    "dlssnr/model_specs.py",
    "dlssnr/runtime_assets.py",
    "dlssnr/small_model.py",
    "tuning/generate_plan.py",
    "tuning/physical_schedule.py",
    "tools/kernel_sources.py",
    "setup.py",
)

#: The seven resident split consumer translation units that now issue the GPU
#: acquire after successful relaxed counter polling and before the existing CTA
#: barrier.  This is a deliberate memory-ordering correctness change, not a
#: wrapper rename; it closes a pre-existing gap and adds no measured claim.
SYNCHRONIZATION_TUS = (
    "csrc/kernel_impl/bottleneck_c1024_attention/fp16/global_qkv_c1024_fp16.cu",
    "csrc/kernel_impl/bottleneck_c1024_attention/fp8/global_qkv_c1024_fp8.cu",
    "csrc/kernel_impl/bottleneck_c1024_attention_ffn_projection/fp16/"
    "global_ffn_contract_c1024_fp16.cu",
    "csrc/kernel_impl/bottleneck_c1024_attention_ffn_projection/fp16/"
    "global_projection_c1024_fp16.cu",
    "csrc/kernel_impl/bottleneck_c1024_attention_ffn_projection/fp8/"
    "global_contract_fp8.cu",
    "csrc/kernel_impl/decoder_c1024_to_c512_upsample/fp16/"
    "decoder_upsample_c1024_to_c512_fp16.cu",
    "csrc/kernel_impl/decoder_c1024_to_c512_upsample/fp8/"
    "decoder_upsample_c1024_to_c512_fp8.cu",
)

#: Primary PTX memory-model references already recorded in root PLAN.md.
PTX_MEMORY_MODEL_URLS = (
    ("release/acquire patterns",
     "https://docs.nvidia.com/cuda/parallel-thread-execution/"
     "#memory-consistency-model-release-and-acquire-patterns"),
    ("memory synchronization",
     "https://docs.nvidia.com/cuda/parallel-thread-execution/"
     "#memory-consistency-model-memory-synchronization"),
)


def _quote(provider, key: str, caption: str, *, before: int = 0, after: int = 0) -> str:
    """Emit one excerpt for a named anchor, extending whole lines as requested."""
    path, anchor = ANCHORS[key]
    text = provider.text(path)
    start, end = _anchor_span(text, anchor)
    line_count = len(text.splitlines())
    start = max(1, start - before)
    end = min(line_count, end + after)
    return code(path, start, end, caption, provider=provider,
                registry=CURRENT_SNIPPETS)


def _table(headers, rows, *, klass="inventory") -> str:
    head = "".join(f"<th>{header}</th>" for header in headers)
    body = "".join(
        "<tr>" + "".join(f"<td>{cell}</td>" for cell in row) + "</tr>"
        for row in rows)
    return (f'<div class="table-scroll"><table class="{klass}"><thead><tr>{head}'
            f'</tr></thead><tbody>{body}</tbody></table></div>')


def _h3(ident: str, title: str) -> str:
    return f'<h3 id="{ident}">{title}</h3>'


def _p(text: str) -> str:
    return f"<p>{text}</p>"


def _lead(text: str) -> str:
    return f'<p class="lede">{text}</p>'


def _ul(items) -> str:
    return "<ul>" + "".join(f"<li>{item}</li>" for item in items) + "</ul>"


# ---------------------------------------------------------------------------
# Evidence loading and validation
# ---------------------------------------------------------------------------


def _validated_evidence(evidence, revision: str) -> FinalEvidence | None:
    """Validate the optional full acceptance record for this exact commit.

    ``None`` is the development state and renders an explicit pending note.
    A mapping is not implicitly a record: only the shared typed loader may
    produce :class:`Acceptance`, so a small ptxas-only sketch can never be
    mistaken for full runtime acceptance.
    """
    if evidence is None:
        return None
    if not isinstance(evidence, Acceptance):
        raise EvidenceError(
            "FlashLight evidence must be the full versioned acceptance record loaded "
            "by flashlight_evidence.load_acceptance; a ptxas-only sketch is not "
            "runtime acceptance")
    if evidence.candidate_source_revision != revision:
        raise EvidenceError(
            f"evidence names candidate {evidence.candidate_source_revision!r}, but the "
            f"current provider is {revision}")
    if evidence.state != "accepted":
        raise EvidenceError(
            f"FlashLight evidence state is {evidence.state!r}; final publication "
            "requires an accepted record")
    return evidence


def load_evidence(path, revision=None) -> FinalEvidence | None:
    """Load the full acceptance bundle; a missing path is an error."""
    if path is None:
        return None
    return load_acceptance(path, revision)


# ---------------------------------------------------------------------------
# Bespoke SVG figures
# ---------------------------------------------------------------------------

_NEUTRAL_FILL = "#14212b"
_NEUTRAL_STROKE = "#8fb3c9"
_GLOBAL_FILL = "#0d2f3a"
_GLOBAL_STROKE = "#69d7f5"
_SHARED_FILL = "#3a2410"
_SHARED_STROKE = "#ffb35c"
_REGISTER_FILL = "#2a1f3d"
_REGISTER_STROKE = "#c9a7ff"
_MMA_FILL = "#123a24"
_MMA_STROKE = "#7ee2a8"
_TEXT = "#e8f1f5"
_MUTED = "#a9c3d1"
_MONO = "ui-monospace,SFMono-Regular,Menlo,Consolas,monospace"
_SANS = "system-ui,-apple-system,Segoe UI,sans-serif"


def _rect(x, y, w, h, fill, stroke, rx=7):
    return (f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}" '
            f'fill="{fill}" stroke="{stroke}" stroke-width="1.5"/>')


def _text(x, y, label, *, fill=_TEXT, size=13, mono=False, anchor="start", weight="normal"):
    family = _MONO if mono else _SANS
    return (f'<text x="{x}" y="{y}" fill="{fill}" font-family="{family}" '
            f'font-size="{size}" text-anchor="{anchor}" font-weight="{weight}">'
            f'{escape(str(label))}</text>')


def _edge(x1, y1, x2, y2, stroke=_NEUTRAL_STROKE):
    return (f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" '
            f'stroke="{stroke}" stroke-width="1.6" class="edge"/>')


def _polyedge(points, stroke=_NEUTRAL_STROKE):
    joined = " ".join(f"{x},{y}" for x, y in points)
    return (f'<polyline points="{joined}" fill="none" '
            f'stroke="{stroke}" stroke-width="1.6" class="edge"/>')


def _svg1() -> str:
    title = "From the logical C1024 FFN problem to one CTA and four warp tiles"
    desc = ("The dense expansion Y equals activation of X times W. One CTA owns a "
            "128-token by 128-channel output tile, split into four 64 by 64 warp tiles; "
            "one scalar contribution is one product in a 1024-term dot product, while "
            "a token owns all 1024 input channels and 4096 output channels.")
    parts = [f"<desc>{escape(desc)}</desc>"]
    boxes = [
        (20, "Logical problem", ("Y = act(X·W)", "X: T×1024", "W: 1024×4096")),
        (265, "Model operation", ("dense expansion", "then clamped", "Half activation")),
        (510, "CTA output tile", ("128 tokens ×", "128 output channels", "one of 32 blocks")),
        (755, "Four warp tiles", ("2×2 warps", "each 64 tokens ×", "64 channels")),
    ]
    for x, heading, lines in boxes:
        parts.append(_rect(x, 24, 215 if x < 755 else 225, 88, _NEUTRAL_FILL, _NEUTRAL_STROKE))
        parts.append(_text(x + 12, 46, heading, size=14, weight="bold"))
        for index, line in enumerate(lines):
            parts.append(_text(x + 12, 68 + index * 17, line, fill=_MUTED, size=12))
    for x in (235, 480, 725):
        parts.append(_edge(x, 68, x + 28, 68))
    parts.append(_text(40, 150, "One CTA: 128 tokens × 128 output channels", size=14, weight="bold"))
    parts.append(_rect(60, 168, 420, 250, _NEUTRAL_FILL, _NEUTRAL_STROKE))
    warp_cells = [
        (80, 192, "warp0", "tokens 0–63", "channels 0–63"),
        (280, 192, "warp1", "tokens 0–63", "channels 64–127"),
        (80, 306, "warp2", "tokens 64–127", "channels 0–63"),
        (280, 306, "warp3", "tokens 64–127", "channels 64–127"),
    ]
    for x, y, name, tokens, channels in warp_cells:
        parts.append(_rect(x, y, 180, 96, _MMA_FILL, _MMA_STROKE))
        parts.append(_text(x + 12, y + 24, name, size=14, weight="bold"))
        parts.append(_text(x + 12, y + 48, tokens, fill=_MUTED, size=12))
        parts.append(_text(x + 12, y + 68, channels, fill=_MUTED, size=12))
        parts.append(_text(x + 12, y + 86, "K loop: 32 × K32", fill=_MUTED, size=11))
    parts.append(_rect(520, 168, 460, 92, _GLOBAL_FILL, _GLOBAL_STROKE))
    parts.append(_text(534, 190, "One scalar contribution", size=14, weight="bold"))
    parts.append(_text(534, 212, "X[37,146] · W[146,81] → one product", mono=True, size=12))
    parts.append(_text(534, 232, "in the 1024-term dot product for Y[37,81]", fill=_MUTED, size=12))
    parts.append(_text(534, 250, "It is not the whole token and not the whole tile.", fill=_MUTED, size=12))
    parts.append(_rect(520, 286, 460, 132, _REGISTER_FILL, _REGISTER_STROKE))
    parts.append(_text(534, 308, "A whole token", size=14, weight="bold"))
    parts.append(_text(534, 330, "token37 owns 1024 input channels", fill=_MUTED, size=12))
    parts.append(_text(534, 350, "and produces 4096 output channels.", fill=_MUTED, size=12))
    parts.append(_text(534, 372, "One CTA supplies 128 of those outputs;", fill=_MUTED, size=12))
    parts.append(_text(534, 392, "one warp supplies 64 of them.", fill=_MUTED, size=12))
    parts.append(_text(40, 444, "All four warps run the same K loop; they differ in token row group and channel band.", fill=_MUTED, size=12))
    return svg(title, "0 0 1000 460", "".join(parts),
               "The logical problem, the 128×128 CTA tile and the four 64×64 warp tiles.")


def _svg2() -> str:
    title = "FlashLight responsibility layers and the FFN plug-in"
    desc = ("One-way dependency layers from core carriers through arch, numeric, "
            "layout, memory, tile and warp primitives to the DLSSNR project layouts, "
            "ops, host helpers and the exported FFN expansion kernel. Generic FlashLight "
            "has no Torch, Python, DLSSNR, CUTLASS or ThunderKittens dependency.")
    parts = [f"<desc>{escape(desc)}</desc>"]
    layers = [
        ("core.cuh", "carriers / traits", "PackedHalf2 · MmaAFragment · MmaAccumulator"),
        ("arch/mma.cuh", "canonical raw MMA", "mma_sync_f16_half_raw · mma_sync"),
        ("arch/warp.cuh", "election / shuffle", "is_copy_producer · transpose_m8n8"),
        ("numeric/packed.cuh", "packed Half / E4 conversions", "half2_fma · publish_e4x4 · decode_e4x2"),
        ("layout/strided.cuh", "compile-time byte strides", "ByteStrides"),
        ("memory/views.cuh", "typed staged views", "StagedSharedLayoutView · byte_offset_slot"),
        ("memory/pipeline.cuh", "async lifecycles", "TransactionBarrier · copy_then_expect"),
        ("tile/mma.cuh", "ordered accumulation", "TiledMmaAccumulator · accumulate_tile"),
    ]
    y = 22
    for index, (name, role, names) in enumerate(layers):
        parts.append(_rect(20, y, 330, 58, _NEUTRAL_FILL, _NEUTRAL_STROKE))
        parts.append(_text(32, y + 19, name, mono=True, size=12, fill=_GLOBAL_STROKE))
        parts.append(_text(32, y + 37, role, size=12, weight="bold"))
        parts.append(_text(32, y + 52, names, mono=True, size=10, fill=_MUTED))
        if index < len(layers) - 1:
            parts.append(_edge(185, y + 58, 185, y + 68))
        y += 68
    parts.append(_rect(390, 22, 626, 152, _SHARED_FILL, _SHARED_STROKE))
    parts.append(_text(404, 44, "DLSSNR project layouts and ops", size=14, weight="bold"))
    for index, line in enumerate((
            "common/layout/global_profiles.h · GlobalFfnExpandProfile",
            "common/layout/numerical_constants.h · ffn_clamp_upper_half2",
            "common/ops/activation.h · clamped_half_polynomial, ffn_activation",
            "common/ops/small_attention.h · clamp_denominator_float",
            "common/ops/global_attention.h · normalize_head")):
        parts.append(_text(404, 68 + index * 20, line, mono=True, size=11, fill=_MUTED))
    parts.append(_rect(390, 190, 626, 112, _SHARED_FILL, _SHARED_STROKE))
    parts.append(_text(404, 212, "DLSSNR host layer (not a FlashLight dependency)", size=14, weight="bold"))
    for index, line in enumerate((
            "physical_tensor.h · ValidatePlanPhysicalBuffer, RequireOutsideCapture",
            "parameter_binding.h · BindTensorAddress, FParameterBlock",
            "deployment_runtime.h · PreparePlanKernels, RunPlanCalls",
            "boxed_dispatch.h · InvokeBoxedPreparedKernel")):
        parts.append(_text(404, 236 + index * 18, line, mono=True, size=11, fill=_MUTED))
    parts.append(_rect(390, 318, 626, 132, _MMA_FILL, _MMA_STROKE))
    parts.append(_text(404, 340, "Exported kernel: the FFN plug-in", size=14, weight="bold"))
    for index, line in enumerate((
            "kernel_impl/bottleneck_c1024_ffn/fp16/",
            "  global_ffn_expand_c1024_fp16.cu",
            "StageInput · LoadWeights · accumulate_tile",
            "ffn_activation · store_no_allocate")):
        parts.append(_text(404, 364 + index * 19, line, mono=True, size=11, fill=_MUTED))
    parts.append(_rect(390, 466, 626, 126, _NEUTRAL_FILL, _NEUTRAL_STROKE))
    parts.append(_text(404, 488, "Not dependencies of generic FlashLight", size=14, weight="bold"))
    parts.append(_text(404, 512, "Torch · Python · DLSSNR · CUTLASS · ThunderKittens", fill=_MUTED, size=12))
    parts.append(_text(404, 534, "Generic headers include only CUDA/C++ facilities.", fill=_MUTED, size=12))
    parts.append(_text(404, 556, "Project code may include FlashLight; never the reverse.", fill=_MUTED, size=12))
    parts.append(_edge(350, 132, 390, 110, _SHARED_STROKE))
    parts.append(_edge(350, 268, 390, 350, _MMA_STROKE))
    parts.append(_edge(350, 472, 390, 380, _MMA_STROKE))
    parts.append(_text(20, 618, "Canonical instruction definitions: arch wrappers · numeric/packed.cuh E4 conversions · project texture/surface.", fill=_MUTED, size=12))
    parts.append(_text(20, 640, "The FFN kernel composes these layers; it does not add a second instruction or address implementation.", fill=_MUTED, size=12))
    return svg(title, "0 0 1040 660", "".join(parts),
               "One-way responsibility layers with actual paths, representative APIs and the FFN plug-in.")


def _svg3() -> str:
    title = "Shared-memory byte ruler: three 8192-byte slots, barriers and the selected K sub-slab"
    desc = ("Physical shared memory is slot0 at byte 0, slot1 at 8192 and slot2 at "
            "16384. Barriers sit at 24576, 24584 and 24592. Slot1 expands into eight "
            "1024-byte producer slabs; producer warp 2 copy group 0 selects the third. "
            "Its two 512-byte K subtiles and 16-byte lane vectors lead to relative "
            "byte 848 for A lane 21. There is no XOR address swizzle.")
    parts = [f"<desc>{escape(desc)}</desc>"]
    parts.append(_text(30, 22, "Shared bytes: 3 × 8192-byte slots + 3 × 8-byte barriers = 24600", size=13, weight="bold"))
    scale = 960 / (STAGE_COUNT * STAGE_BYTES)
    for slot in range(STAGE_COUNT):
        x = 70 + slot * STAGE_BYTES * scale
        fill = _SHARED_FILL if slot == 1 else _NEUTRAL_FILL
        stroke = _SHARED_STROKE if slot == 1 else _NEUTRAL_STROKE
        parts.append(_rect(x, 44, STAGE_BYTES * scale, 52, fill, stroke, rx=4))
        parts.append(_text(x + 10, 65, f"slot{slot}", size=13, weight="bold"))
        parts.append(_text(x + 10, 84, f"{slot * STAGE_BYTES}–{slot * STAGE_BYTES + STAGE_BYTES - 1}", mono=True, size=10, fill=_MUTED))
    parts.append(_text(70, 120, "24576", mono=True, size=10, fill=_MUTED))
    parts.append(_text(1024, 120, "24600", mono=True, size=10, fill=_MUTED, anchor="end"))
    parts.append(_rect(70, 128, 960, 34, _REGISTER_FILL, _REGISTER_STROKE, rx=4))
    parts.append(_text(80, 150, "barrier strip (magnified): three 8-byte barriers occupy [24576, 24600); source barrier bytes, not a compiler/runtime reserved allocation", mono=True, size=10, fill=_MUTED))
    parts.append(_text(30, 190, "Slot1 expanded: eight 1024-byte producer slabs (warp × copy-group)", size=13, weight="bold"))
    slab_width = 960 / 8
    for slab in range(8):
        x = 70 + slab * slab_width
        selected = slab == 2
        parts.append(_rect(x, 202, slab_width, 62, _SHARED_FILL if selected else _NEUTRAL_FILL,
                           _SHARED_STROKE if selected else _NEUTRAL_STROKE, rx=4))
        parts.append(_text(x + 8, 222, f"slab{slab}", size=11, weight="bold"))
        parts.append(_text(x + 8, 240, f"+{slab * 1024}", mono=True, size=10, fill=_MUTED))
        if selected:
            parts.append(_text(x + 8, 256, "warp2 copy0", fill=_SHARED_STROKE, size=10))
    parts.append(_text(30, 292, "Selected 1024-byte slab: two 512-byte K16 subtiles", size=13, weight="bold"))
    parts.append(_rect(310, 304, 120, 54, _NEUTRAL_FILL, _SHARED_STROKE, rx=4))
    parts.append(_text(318, 324, "Ksub0", mono=True, size=11))
    parts.append(_text(318, 344, "K128–143", mono=True, size=10, fill=_MUTED))
    parts.append(_rect(430, 304, 120, 54, _SHARED_FILL, _SHARED_STROKE, rx=4))
    parts.append(_text(438, 324, "Ksub1", mono=True, size=11, weight="bold"))
    parts.append(_text(438, 344, "K144–159", mono=True, size=10, fill=_MUTED))
    parts.append(_text(30, 390, "Ksub1 expanded: 32 lane vectors × 16 bytes; A lane21 highlighted", size=13, weight="bold"))
    lane_width = 960 / 32
    for lane in range(32):
        x = 70 + lane * lane_width
        selected = lane == 21
        parts.append(_rect(x, 402, lane_width - 1, 42, _REGISTER_FILL if selected else _NEUTRAL_FILL,
                           _REGISTER_STROKE if selected else _NEUTRAL_STROKE, rx=2))
        if lane in (0, 5, 20, 21, 31):
            parts.append(_text(x + lane_width / 2, 430, str(lane), mono=True,
                               size=9, fill=_REGISTER_STROKE if selected else _MUTED, anchor="middle"))
    parts.append(_text(70, 466, "+0", mono=True, size=9, fill=_MUTED))
    parts.append(_text(1030, 466, "+512", mono=True, size=9, fill=_MUTED, anchor="end"))
    parts.append(_text(30, 506, "A lane21 owns bytes +336…+351 in Ksub1; the trace scalar is the low Half of word x.", size=12))
    parts.append(_text(30, 532, "relative = 1·512 + 21·16 = 848   →   shared = 1·8192 + 2·1024 + 848 = 11088", mono=True, size=12, fill=_SHARED_STROKE))
    parts.append(_text(30, 570, "No XOR shared/global address swizzle exists anywhere in this tree.", size=12, weight="bold"))
    parts.append(_text(30, 592, "Striding is plain: slot·8192 + slab·1024 + ksub·512 + lane·16.", mono=True, size=11, fill=_MUTED))
    parts.append(_text(30, 614, "Lane permutation is a separate register concept (permute_quad, shuffle_index); it does not change an address.", size=11, fill=_MUTED))
    parts.append(_text(30, 642, "Bank mapping follows only from exact access width and addresses; no conflict count is measured or claimed here.", size=11, fill=_MUTED))
    return svg(title, "0 0 1120 660", "".join(parts),
               "Physical shared-memory ruler with the selected producer slab, K subtiles and lane vectors.")


def _svg4() -> str:
    title = "Lane fragments for the worked token: A lane21, B lane5 and C lane20"
    desc = ("All 32 lanes cooperate in one m16n8k16 mma.sync. A lane21 supplies "
            "four packed words covering rows 5 and 13 and K 2,3,10,11; B lane5 supplies "
            "two words for column 1 and the adjacent N8 fragment; C lane20 receives "
            "output row 5, columns 0 and 1. The scalar is formed collectively, not "
            "moved from lane 21 to lane 20 by a shuffle.")
    parts = [f"<desc>{escape(desc)}</desc>"]
    panels = [
        (20, "A lane21  (group5, thread1)", (
            ("word", "tokens", "K", "half"),
            ("x", "37", "146,147", "low=146"),
            ("y", "45", "146,147", "low=146"),
            ("z", "37", "154,155", "low=154"),
            ("w", "45", "154,155", "low=154"))),
        (390, "B lane5  (col-group1, thread1)", (
            ("word", "N8", "column", "K"),
            ("x", "low", "81", "146,147"),
            ("y", "low", "81", "154,155"),
            ("z", "high", "89", "146,147"),
            ("w", "high", "89", "154,155"))),
        (760, "C lane20  (group5, thread0)", (
            ("word", "half", "row", "column"),
            ("word0", "low", "37 (5)", "80 (0)"),
            ("word0", "high", "37 (5)", "81 (1)"),
            ("word1", "low", "45 (13)", "80 (0)"),
            ("word1", "high", "45 (13)", "81 (1)"))),
    ]
    for x, heading, rows in panels:
        parts.append(_rect(x, 24, 340, 250, _REGISTER_FILL if x != 390 else _GLOBAL_FILL,
                           _REGISTER_STROKE if x != 390 else _GLOBAL_STROKE))
        parts.append(_text(x + 12, 46, heading, size=13, weight="bold"))
        for row_index, row in enumerate(rows):
            y = 70 + row_index * 36
            if row_index == 0:
                parts.append(_text(x + 12, y, row[0], size=11, fill=_MUTED, weight="bold"))
                parts.append(_text(x + 122, y, row[1], size=11, fill=_MUTED, weight="bold"))
                parts.append(_text(x + 202, y, row[2], size=11, fill=_MUTED, weight="bold"))
                parts.append(_text(x + 282, y, row[3], size=11, fill=_MUTED, weight="bold"))
            else:
                highlight = (x == 20 and row[0] == "x" and row[3] == "low=146") or \
                            (x == 390 and row[0] == "x" and row[2] == "81") or \
                            (x == 760 and row[0] == "word0" and row[1] == "high")
                parts.append(_text(x + 12, y, row[0], mono=True, size=11,
                                   fill=_MMA_STROKE if highlight else _TEXT))
                parts.append(_text(x + 122, y, row[1], mono=True, size=11,
                                   fill=_MMA_STROKE if highlight else _TEXT))
                parts.append(_text(x + 202, y, row[2], mono=True, size=11,
                                   fill=_MMA_STROKE if highlight else _TEXT))
                parts.append(_text(x + 282, y, row[3], mono=True, size=11,
                                   fill=_MMA_STROKE if highlight else _TEXT))
    # Each caption is wrapped inside its own 340-px column so the A caption can
    # never spill into the B caption.
    for x, lines, colour in (
            (32, ("Selected A uint4: tokens 37/45", "× channels 146/147/154/155"),
             _REGISTER_STROKE),
            (400, ("x/y feed the low N8;", "z/w the adjacent high N8."),
             _GLOBAL_STROKE),
            (770, ("First accumulator word high half", "= Y[37,81]."),
             _MMA_STROKE)):
        for index, line in enumerate(lines):
            parts.append(_text(x, 292 + index * 15, line, mono=x == 32, size=10,
                               fill=colour))
    parts.append(_rect(330, 324, 440, 58, _MMA_FILL, _MMA_STROKE))
    parts.append(_text(550, 346, "one mma.sync.m16n8k16", size=13, weight="bold", anchor="middle"))
    parts.append(_text(550, 368, "all 32 lanes supply A/B and receive C", fill=_MUTED, size=11, anchor="middle"))
    parts.append(_edge(280, 352, 330, 352))
    parts.append(_edge(770, 352, 820, 352))
    parts.append(_text(30, 420, "32-lane collective", size=13, weight="bold"))
    for lane in range(32):
        x = 70 + lane * 29
        selected = lane in (5, 20, 21)
        parts.append(_rect(x, 432, 22, 30, _REGISTER_FILL if selected else _NEUTRAL_FILL,
                           _MMA_STROKE if selected else _NEUTRAL_STROKE, rx=2))
        if lane in (5, 20, 21):
            parts.append(_text(x + 11, 452, str(lane), mono=True, size=9,
                               fill=_MMA_STROKE, anchor="middle"))
    parts.append(_text(30, 492, "A lane21 contributes to several output columns of the warp; it is not transported to lane20.", fill=_MUTED, size=12))
    parts.append(_text(30, 514, "The MMA collective forms each dot product from every lane's A/B fragments. No scalar shuffle is inserted.", fill=_MUTED, size=12))
    parts.append(_text(30, 548, "m16n8k16 fragment mapping: NVIDIA PTX documentation; the tile, lane and address math here is repository-derived.", fill=_MUTED, size=10))
    return svg(title, "0 0 1100 570", "".join(parts),
               "A, B and C lane-fragment maps with the 32-lane collective; no lane-to-lane scalar transport.")


def _svg5() -> str:
    title = ("Three-slot pipeline: initial preload, iteration-local read/refill and the "
             "two copy protocols")
    desc = ("StageInput(0), StageInput(1) and StageInput(2) fill the ring in initial "
            "preloading. Columns are loop iterations i, a logical execution order and "
            "not a measured time axis. In iteration i the kernel reads slot i%3, issues "
            "two K16 MMAs, preloads weights i+1, waits for stage i+1 and then refills "
            "that same slot with StageInput(i+3). SM90+ uses one elected bulk issuer; "
            "SM80/86/89 use two rounds of 32 x 16-byte lane-striped cp.async copies.")
    parts = [f"<desc>{escape(desc)}</desc>"]
    init = [
        (20, "3 barriers", "128 arrivals"),
        (222, "__syncthreads", "publish init"),
        (424, "LoadWeights(0)", "prime B"),
        (626, "StageInput(0..2)", "initial preload"),
        (828, "WaitStage(0)", "arrive + poll"),
    ]
    for x, heading, sub in init:
        parts.append(_rect(x, 22, 174, 66, _NEUTRAL_FILL, _NEUTRAL_STROKE))
        parts.append(_text(x + 10, 44, heading, size=12, weight="bold"))
        parts.append(_text(x + 10, 64, sub, mono=True, size=10, fill=_MUTED))
    for x in (194, 396, 598, 800):
        parts.append(_edge(x, 55, x + 28, 55))
    parts.append(_text(20, 108, "Initial preloading happens before iteration 0; every "
                     "StageInput(0..2) name below is an actual stage index.", size=10,
                     fill=_MUTED))
    columns = ["i0", "i1", "i2", "i3", "i4", "i5"]
    for index, label in enumerate(columns):
        x = 230 + index * 140
        parts.append(_text(x, 134, label, mono=True, size=12, fill=_MUTED))
    parts.append(_text(20, 134, "iteration i", mono=True, size=10, fill=_MUTED))
    rows = [
        (152, "slot0", (0, 3)),
        (202, "slot1", (1, 4)),
        (252, "slot2", (2, 5)),
    ]
    for y, label, iterations in rows:
        parts.append(_text(20, y + 24, label, mono=True, size=12, weight="bold"))
        parts.append(_rect(100, y, 960, 38, _NEUTRAL_FILL, _NEUTRAL_STROKE, rx=3))
        for index in iterations:
            x = 230 + index * 140 - 60
            parts.append(_rect(x, y + 6, 58, 26, _SHARED_FILL, _SHARED_STROKE, rx=3))
            parts.append(_text(x + 29, y + 23, f"read {index}", size=9,
                               fill=_TEXT, anchor="middle"))
            parts.append(_rect(x + 62, y + 6, 58, 26, _GLOBAL_FILL, _GLOBAL_STROKE, rx=3))
            parts.append(_text(x + 91, y + 23, f"refill {index + 3}", size=9,
                               fill=_TEXT, anchor="middle"))
    parts.append(_rect(100, 296, 960, 38, _MMA_FILL, _MMA_STROKE, rx=3))
    for index in range(6):
        x = 230 + index * 140 - 60
        parts.append(_text(x + 58, 320, "2×K16 MMA", size=10, fill=_TEXT, anchor="middle"))
    parts.append(_text(20, 320, "compute", size=11, weight="bold"))
    parts.append(_rect(100, 346, 960, 38, _GLOBAL_FILL, _GLOBAL_STROKE, rx=3))
    for index in range(6):
        x = 230 + index * 140 - 60
        parts.append(_text(x + 58, 370, "LoadWeights(i+1)", size=10, fill=_TEXT,
                           anchor="middle"))
    parts.append(_text(20, 370, "preload B", size=11, weight="bold"))
    parts.append(_rect(100, 396, 960, 38, _REGISTER_FILL, _REGISTER_STROKE, rx=3))
    for index in range(6):
        x = 230 + index * 140 - 60
        parts.append(_text(x + 58, 420, "Wait(i+1) → refill i+3", size=9, fill=_TEXT,
                           anchor="middle"))
    parts.append(_text(20, 420, "wait/refill", size=10, weight="bold"))
    parts.append(_text(20, 456, "Columns are loop iterations i in logical execution "
                     "order, not a measured time axis. Orange cells are reads; blue "
                     "cells are same-iteration refills.", size=11, weight="bold"))
    parts.append(_text(20, 476, "StageInput(0..2) happen in initial preloading. During "
                     "iteration i, slot i%3 is consumed, then StageInput(i+3) refills that "
                     "slot after Wait(i+1) in the SAME iteration.", size=11, fill=_MUTED))
    parts.append(_text(20, 496, "The diagram does not move a stage's first issue to "
                     "iteration i+3; read and refill phases are labelled explicitly.",
                       size=11, fill=_MUTED))
    parts.append(_text(20, 510, "Protocol semantics stay distinct: issue → expected "
                     "bytes → arrive(token) → poll(token).", size=11, weight="bold"))
    parts.append(_rect(20, 516, 520, 190, _SHARED_FILL, _SHARED_STROKE))
    parts.append(_text(34, 538, "SM90+ native bulk path", size=13, weight="bold"))
    parts.append(_text(34, 562, "one elected issuer: is_copy_producer(...)", mono=True, size=10, fill=_MUTED))
    parts.append(_text(34, 582, "cp.async.bulk.shared::cta.global", mono=True, size=10, fill=_MUTED))
    parts.append(_text(34, 602, "mbarrier::complete_tx::bytes", mono=True, size=10, fill=_MUTED))
    parts.append(_text(34, 622, "expect_tx adds the byte count", size=11, fill=_MUTED))
    parts.append(_edge(120, 640, 420, 640, _SHARED_STROKE))
    parts.append(_text(34, 664, "single elected 1024-byte transfer", size=10, fill=_MUTED))
    parts.append(_rect(560, 516, 540, 190, _REGISTER_FILL, _REGISTER_STROKE))
    parts.append(_text(574, 538, "SM80/86/89 lane-striped fallback", size=13, weight="bold"))
    parts.append(_text(574, 558, "each producer lane copies 16 bytes; 1024 B needs two rounds",
                       size=10, fill=_MUTED))
    parts.append(_text(574, 578, "round 0 · dst +0 … +496", size=10, fill=_MUTED))
    for lane in range(32):
        x = 574 + lane * 16
        parts.append(_rect(x, 582, 12, 13, _REGISTER_FILL, _REGISTER_STROKE, rx=1))
    parts.append(_text(574, 612, "round 1 · dst +512 … +1008", size=10, fill=_MUTED))
    for lane in range(32):
        x = 574 + lane * 16
        parts.append(_rect(x, 616, 12, 13, _REGISTER_FILL, _REGISTER_STROKE, rx=1))
    parts.append(_text(574, 640, "cp.async.cg.shared.global [dst],[src],16", mono=True, size=10, fill=_MUTED))
    parts.append(_text(574, 658, "each producer attaches cp.async.mbarrier.arrive", size=10, fill=_MUTED))
    parts.append(_text(574, 676, "barrier_expect is a preserved no-op (no double count)", size=10, fill=_MUTED))
    parts.append(_text(574, 694, "two rounds × 32 × 16-byte copies, not one elected transfer", size=10, fill=_MUTED))
    return svg(title, "0 0 1120 726", "".join(parts),
               "Initial preload, three-slot same-iteration read/refill order and the two copy protocols.")


def _svg6() -> str:
    title = "Worked trace: independent A and B load branches join at the MMA"
    desc = ("Activation A follows a global async bulk copy (SM90+) or a lane-striped "
            "cp.async.cg copy (SM80/86/89) into shared slot1 and then a lane-owned A "
            "register. Weight B is an independent ld.ca global-to-register branch with "
            "no shared-memory stage. The two branches join only at the 32-lane "
            "m16n8k16 MMA. The accumulation is written to Y[37,81] after the complete "
            "reduction; there are no serial A-to-B transformation arrows.")
    parts = [f"<desc>{escape(desc)}</desc>"]
    parts.append(_text(54, 20, "A path: async bulk / cp.async.cg → shared slot1 → A register",
                       size=12, weight="bold", fill=_SHARED_STROKE))
    parts.append(_text(620, 20, "B path: ld.ca global → B register (independent)",
                       size=12, weight="bold", fill=_GLOBAL_STROKE))

    def row(x, y, number, heading, fill, stroke, equation, detail, source):
        parts.append(_rect(x, y, 520, 86, fill, stroke))
        parts.append(_text(x + 14, y + 24, number, mono=True, size=14, fill=stroke,
                           weight="bold"))
        parts.append(_text(x + 50, y + 24, heading, size=12, weight="bold"))
        parts.append(_text(x + 50, y + 45, equation, mono=True, size=9.5, fill=_TEXT))
        parts.append(_text(x + 50, y + 63, detail, size=10, fill=_MUTED))
        parts.append(_text(x + 50, y + 79, source, mono=True, size=9, fill=_MUTED))

    row(54, 34, "A1", "global X", _GLOBAL_FILL, _GLOBAL_STROKE,
        "g_Input + group2·16384·2 + iter4·1024 + ksub1·512 + lane21·16 = 70480",
        "X[37,146] is the low Half of A lane21 word x.",
        "source: StageInput / ffn_input_address")
    row(54, 134, "A2", "cache policy", _NEUTRAL_FILL, _NEUTRAL_STROKE,
        "cp.async.bulk (SM90+) / cp.async.cg 16 B (SM80/86/89)",
        "A uses the native bulk transfer or the lane-striped cp.async.cg fallback.",
        "no cache-hit or counter claim is made")
    row(54, 234, "A3", "shared slot1", _SHARED_FILL, _SHARED_STROKE,
        "1·8192 + 2·1024 + 1·512 + 21·16 = 11088",
        "slot1 + producer slab2 + Ksub1 + lane21 = relative 848.",
        "source: StageFragments.load_slot")
    row(54, 334, "A4", "A register", _REGISTER_FILL, _REGISTER_STROKE,
        "uint4 = tokens 37/45 × channels 146/147/154/155",
        "word x low = X[37,146]; y = token45; z/w = channels 154/155.",
        "lane21 group5/thread1: rows 5,13; K 2,3,10,11")
    row(620, 34, "B1", "weight B", _GLOBAL_FILL, _GLOBAL_STROKE,
        "0·4096 + 1·2048 + 5·16 + 9·131072 + 1·512 = 1182288",
        "B lane5 word x low Half = W[146,81]; z/w carry the adjacent N8.",
        "source: LoadWeights / ffn_weight_base")
    row(620, 134, "B2", "B register", _REGISTER_FILL, _REGISTER_STROKE,
        "ld.ca → register · two K16 subtiles × four N16 groups",
        "No shared-memory stage for B; it is an independent global load branch.",
        "source: LoadWeights / load_vector")
    for y in (134, 234, 334):
        parts.append(_edge(314, y - 14, 314, y))
    # B leaves its register box, elbows left and enters the MMA's actual top edge.
    parts.append(_polyedge(((880, 220), (880, 438), (500, 438), (500, 454))))
    parts.append(_edge(314, 420, 314, 454))
    row(54, 454, "7", "MMA + accumulator", _MMA_FILL, _MMA_STROKE,
        "all 32 lanes: m16n8k16 → C lane20 word0 high Half",
        "A register and B register meet only at MMA; there is no A-to-B transform.",
        "activation runs after the complete sum, before the store")
    row(54, 554, "8", "output Y", _SHARED_FILL, _SHARED_STROKE,
        "2·131072 + 0 + 1·2048 + 20·16 + 1·512 = 265024 (uint4 start)",
        "Y[37,81] is at +2 = 265026 inside that uint4.",
        "source: store_no_allocate / ffn_store")
    parts.append(_edge(314, 540, 314, 554))
    parts.append(_text(20, 664, "The two branches are independent load paths that join "
                     "at the MMA; the arrows are not a serial A→B row chain.", size=11,
                     fill=_MUTED))
    parts.append(_text(20, 684, "Primarily supported by NVIDIA PTX m16n8k16 fragment "
                     "documentation; CUTLASS docs inform only the separation of "
                     "responsibilities.", size=9, fill=_MUTED))
    return svg(title, "0 0 1180 700", "".join(parts),
               "Independent A (cp.async/shared/register) and B (ld.ca/register) branches converging at the MMA.")


# ---------------------------------------------------------------------------
# Source-free diagram preview
# ---------------------------------------------------------------------------

#: The six figure renderers, in teaching order.  The preview never emits source.
_SVG_FIGURES = (_svg1, _svg2, _svg3, _svg4, _svg5, _svg6)

DIAGRAM_PREVIEW_LABEL = "Diagram draft"


def diagram_preview_html(css: str = "") -> str:
    """Return a source-free HTML draft of only the six pure SVG figures.

    The result carries a visible draft label, no source excerpts, no commit
    hash and no provenance assertion.  It is a composition check only.
    """
    figures = "".join(figure() for figure in _SVG_FIGURES)
    return (
        '<!doctype html>\n<html lang="en"><head><meta charset="utf-8">'
        '<meta name="viewport" content="width=device-width,initial-scale=1">'
        f'<title>{DIAGRAM_PREVIEW_LABEL}: FlashLight chapter figures</title>'
        f'<style>{css}</style>'
        '<style>'
        'body{margin:0;background:#0b1218;color:#e8f1f5;'
        'font-family:system-ui,-apple-system,Segoe UI,sans-serif}'
        '.preview{max-width:1240px;margin:0 auto;padding:24px 24px 64px}'
        '.draft-label{position:sticky;top:0;z-index:2;margin:0 0 18px;padding:12px 16px;'
        'border:2px solid #ffb35c;border-radius:8px;background:#3a2410;color:#ffe1b8}'
        '.draft-note{color:#a9c3d1;max-width:80ch}'
        'h1{font-size:1.5rem}'
        '</style></head><body><main class="preview">'
        f'<aside class="draft-label" role="note"><strong>{DIAGRAM_PREVIEW_LABEL}</strong> '
        '&mdash; source-free composition check. No code excerpts, no commit assertion. '
        'Visual inspection is still pending.</aside>'
        '<h1>FlashLight chapter diagrams (draft)</h1>'
        '<p class="draft-note">This file renders only the six pure <code>_svg*</code> '
        'figure functions with the real site stylesheet. It is not a published chapter '
        'and does not establish current-page provenance.</p>'
        f'{figures}</main></body></html>\n')


def write_diagram_preview(path, css_path=None) -> Path:
    """Write the diagram draft, inlining the real site CSS when available."""
    css = ""
    source = Path(css_path) if css_path is not None else Path(__file__).with_name("site.css")
    if source.is_file():
        css = source.read_text(encoding="utf-8")
    target = Path(path)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(diagram_preview_html(css), encoding="utf-8", newline="\n")
    return target


# ---------------------------------------------------------------------------
# Chapter body
# ---------------------------------------------------------------------------


def _module_table(provider) -> str:
    rows = []
    for path, layer, responsibility, names in MODULES:
        text = _require_path(provider, path)
        missing = [name for name in names if name not in text]
        if missing:
            raise ChapterError(f"{path}: representative names absent: {missing}")
        rows.append((
            f'<a href="source-current/{escape(path)}"><code>{escape(path)}</code></a>',
            escape(layer), escape(responsibility),
            "<br>".join(f"<code>{escape(name)}</code>" for name in names)))
    return _table(("Path", "Layer", "Responsibility", "Representative API names"), rows)


def _source_bundle_table(source_paths, provider) -> str:
    rows = []
    for path in source_paths:
        rows.append((
            f'<a href="source-current/{escape(path)}"><code>{escape(path)}</code></a>',
            f'<a href="{source_url(path, provider=provider)}">commit copy ↗</a>'))
    return _table(("Current source file", "Pinned link"), rows)


def _artifact_link(artifact, label=None):
    return (f'<a href="evidence-flashlight/{escape(artifact.path)}">'
            f'<code>{escape(label or artifact.path)}</code></a>')


def _evidence_html(record: FinalEvidence | None, *,
                   anchor_id: str | None = "accepted-allocations") -> str:
    if record is None:
        return note(
            "No accepted allocation or paired measurement record is attached to this "
            "implementation commit. The page therefore makes no performance claim. "
            "The register and shared-memory numbers in this budget are source "
            "declarations and static byte arithmetic, not measured allocations or "
            "throughput. Only the full versioned acceptance record for this exact "
            "commit can add compiler or runtime evidence; a ptxas-only sketch is not "
            "runtime acceptance.")
    rows = []
    for row in record.ptxas.rows:
        rows.append((
            escape(row.architecture),
            escape(row.kernel),
            escape(row.sm_target),
            str(row.registers_per_thread),
            f'{row.static_shared_bytes:,}',
            str(row.spill_bytes),
            _artifact_link(row.log, "log"),
        ))
    body = _table(("Architecture", "Kernel", "SM target", "Registers / thread",
                   "PTXAS static shared bytes", "Spill bytes", "Log"), rows)
    opening = f'<div id="{anchor_id}">' if anchor_id else '<div>'
    return (f'{opening}{body}'
            f'<p>Compiler/static ptxas rows from the accepted candidate build. '
            f'These are not runtime timing or counter results. cuobjdump separately '
            f'reports the SM120 driver-reserved region as '
            f'<code>{record.ptxas.cuobjdump_reserved_bytes:,}</code> bytes; it is a '
            f'different tool field and is neither added to nor subtracted from the '
            f'ptxas static shared allocation. '
            f'See {_artifact_link(record.ptxas.cuobjdump, "cuobjdump receipt")}.</p>'
            f'<p>Acceptance bundle <code>{escape(record.acceptance_id)}</code>, '
            f'report SHA-256 <code>{record.sha256}</code>.</p></div>')


_MODEL_ORDER = {"legacy71": 0, "small31": 1}
_PRECISION_ORDER = {"fp16": 0, "fp8": 1}
_SIZE_ORDER = {"720p": 0, "1080p": 1, "2k": 2, "4k": 3}


def _sorted_cases(record):
    return sorted(
        record.timing.cases,
        key=lambda case: (_MODEL_ORDER[case.model], _PRECISION_ORDER[case.precision],
                          _SIZE_ORDER[case.size]))


def _acceptance_timing_html(record):
    rows = []
    for case in _sorted_cases(record):
        label = (f'<span data-case="{escape(case.id)}"><code>{escape(case.model)}</code> '
                 f'{escape(case.precision.upper())} · '
                 f'{case.width}×{case.height} ({escape(case.size)})</span>')
        rows.append((
            label,
            ", ".join(format_ms(value) for value in case.original_process_medians_ms),
            format_ms(case.original_median_ms),
            ", ".join(format_ms(value) for value in case.candidate_process_medians_ms),
            format_ms(case.candidate_median_ms),
            format_speedup(case.speedup),
            (format_range(*case.original_range_ms) + "<br>"
             + format_range(*case.candidate_range_ms)),
            escape(case.decision_status),
            _artifact_link(record.timing.receipt, "timing receipt"),
        ))
    table = _table(("Case (model / precision / resolution)", "Original process medians (ms)",
                    "Original median (ms)", "Candidate process medians (ms)",
                    "Candidate median (ms)", "Derived speedup",
                    "Process-median range (ms)<br>original / candidate", "Decision",
                    "Timing receipt"),
                   rows)
    rationales = "".join(
        f'<li><code>{escape(case.id)}</code>: {escape(case.decision_rationale)}</li>'
        for case in _sorted_cases(record))
    protocol = record.protocol
    order = " → ".join(protocol.process_order)
    return (
        '<h3 id="trace-acceptance">Accepted runtime evidence: paired arms, gates and '
        'provenance</h3>'
        f'<p><strong>Measured runtime acceptance.</strong> Acceptance bundle '
        f'<code>{escape(record.acceptance_id)}</code> is bound to the implementation '
        f'commit <code>{escape(record.candidate_source_revision)}</code> and report '
        f'SHA-256 <code>{record.sha256}</code> '
        f'(<a href="evidence-flashlight/acceptance.json"><code>acceptance.json</code></a>). '
        f'Here <em>original</em> is the kernel-'
        f'implementation baseline and <em>candidate</em> is the FlashLight refactor; '
        f'<code>legacy71</code>/<code>small31</code> remains the model axis. That is '
        f'not the old/new DLSS model comparison.</p>'
        f'<p>The fixed protocol uses <code>{protocol.child_processes_per_case}</code> '
        f'fresh child processes per case: <code>{protocol.original_processes}</code> '
        f'original and <code>{protocol.candidate_processes}</code> candidate process '
        f'medians. Process order: <code>{escape(order)}</code>. '
        f'{escape(protocol.methodology)} Displayed medians and speedups are derived '
        f'from the four recorded process medians per arm; the recorded uncertainty '
        f'ranges and per-case decisions are preserved rather than recomputed against '
        f'an invented threshold. Recorded uncertainty method: '
        f'<code>{escape(record.timing.cases[0].uncertainty_method)}</code>.</p>'
        + table
        + '<p>Overall timing decision: <code>'
        + escape(record.timing.decision_status)
        + '</code>. ' + escape(record.timing.decision_methodology)
        + ' ' + escape(record.timing.decision_rationale) + '</p>'
        + '<ul>' + rationales + '</ul>')


def _acceptance_checks_html(record):
    rows = [(
        f'<span data-check="{escape(check.category)}"><code>{escape(check.category)}</code></span>',
        escape(check.status),
        escape(", ".join(check.covered_cases)),
        _artifact_link(check.receipt, "receipt"),
        escape(check.summary),
    ) for check in record.checks]
    return (
        '<h3 id="trace-checks">Receipt-backed acceptance checks</h3>'
        '<p>These are the required runtime, numerical, graph, guard, checkpoint, '
        'training, RGB and primitive categories. Compiler success is reported '
        'separately above as static ptxas evidence and is never substituted for a '
        'runtime or numerical pass. Coverage is recorded from each receipt: '
        '<code>native-bitwise</code> resolves to the full timing matrix, while other '
        'categories name their own CPU suite, checkpoint, small-fixture training, '
        'guard or primitive coverage and are not implied to be native cases.</p>'
        + _table(("Category", "Status", "Recorded coverage", "Receipt", "Summary"), rows))


def _acceptance_identity_html(record):
    def head_text(build):
        if build.build_time_head is None:
            return "unknown (not recorded)"
        return f'<code>{escape(build.build_time_head)}</code>'

    def dirty_text(build):
        if build.dirty is None:
            return "unknown (not recorded)"
        return "dirty" if build.dirty else "clean"

    builds = []
    for role, build in (("original", record.original_build),
                        ("candidate", record.candidate_build)):
        builds.append((
            escape(role),
            f'<code>{escape(build.provenance_basis)}</code>',
            head_text(build),
            dirty_text(build),
            f'<code>{escape(build.binary_filename)}</code>',
            f'<code>{escape(build.binary_sha256)}</code>',
            _artifact_link(build.build_receipt, "receipt"),
            _artifact_link(build.input_manifest, "manifest"),
            escape(build.toolchain["nvcc_version"]),
            escape(build.toolchain["ptxas_version"]),
            escape(build.toolchain["cuda_version"]),
            escape(build.toolchain["pytorch_version"]),
        ))
    build_table = _table(("Role", "Provenance basis", "Build-time HEAD", "Worktree",
                          "Binary filename", "Binary SHA-256", "Build receipt",
                          "Measured input manifest", "nvcc", "ptxas", "CUDA",
                          "PyTorch"), builds)
    basis_notes = " ".join(
        f'<strong>{escape(role)}</strong> '
        f'(<code>{escape(build.provenance_basis)}</code>): '
        f'{escape(build.provenance_note)}.'
        for role, build in (("original", record.original_build),
                            ("candidate", record.candidate_build)))
    toolchain = record.candidate_build.toolchain
    toolchain_table = _table(
        ("Tool identity", "Version", "Recorded SHA-256"),
        (("nvcc", escape(toolchain['nvcc_version']),
          f"<code>{escape(toolchain['nvcc_sha256'])}</code>"),
         ("ptxas", escape(toolchain['ptxas_version']),
          f"<code>{escape(toolchain['ptxas_sha256'])}</code>"),
         ("CUDA", escape(toolchain['cuda_version']), "—"),
         ("PyTorch", escape(toolchain['pytorch_version']), "—")))
    environment = record.environment
    environment_table = _table(
        ("Measured environment", "Value"),
        (("GPU", f'{escape(environment.gpu_name)} (<code>{escape(environment.gpu_uuid)}</code>)'),
         ("Driver", escape(environment.driver)),
         ("CUDA", escape(environment.cuda)),
         ("PyTorch", escape(environment.pytorch)),
         ("Timing method", escape(environment.timing_method)),
         ("Seed", str(environment.seed)),
         ("Warmup / samples / iterations / rounds",
          f'{environment.warmup} / {environment.samples} / {environment.iterations} / '
          f'{environment.rounds}'),
         ("Methodology", escape(environment.methodology))))
    provenance_rows = [(
        f'<code>{escape(item.path)}</code>',
        f'<code>{escape(item.raw_file_sha256)}</code>',
        f'<code>{escape(item.normalized_lf_sha256)}</code>',
        (f'<code>{escape(item.git_blob_oid)}</code>' if item.git_blob_oid else "—"),
    ) for item in record.provenance_files]
    provenance_table = _table(
        ("Measured source input", "raw_file_sha256 (recorded raw bytes)",
         "normalized_lf_sha256 (LF content)", "git_blob_oid (optional)"),
        provenance_rows)
    artifact_rows = [(
        _artifact_link(artifact),
        escape(artifact.kind),
        escape(artifact.identity),
        f'<code>{escape(artifact.sha256)}</code>',
    ) for artifact in record.artifacts]
    artifact_table = _table(("Public artifact", "Kind", "Identity", "SHA-256"),
                            artifact_rows)
    if record.ncu.state == "current":
        ncu = ('<p>Current NCU evidence is attached to the same candidate revision and '
               'binary: '
               + ", ".join(_artifact_link(report, "report") for report in record.ncu.reports)
               + f'. {escape(record.ncu.methodology)}</p>')
    else:
        ncu = ('<p>No current NCU evidence is attached to this acceptance bundle. The '
               'page therefore makes no current counter claim; historical NCU evidence '
               'remains pinned to its own original sources and is not relabelled here. '
               f'{escape(record.ncu.reason)}</p>')
    limitations = _ul(escape(value) for value in record.limitations)
    return (
        '<h3 id="trace-provenance">Source, binary, tool, device and artifact identity'
        '</h3>'
        f'<p><code>original_source_revision</code> '
        f'<code>{escape(record.original_source_revision)}</code> is the frozen '
        'source-replay snapshot; it is not automatically the original binary\'s build '
        'checkout. Original build-time HEAD and worktree are reported only as preserved '
        'receipts, explicit inference or honest unknowns, and are never forced to equal '
        'that snapshot. The candidate build is the actual preserved frozen dirty '
        'checkout. Neither recorded build-time HEAD is relabelled as the later '
        f'implementation commit <code>{escape(record.candidate_source_revision)}</code>, '
        'which is the commit used to re-read every measured normalized source row. No '
        'native binary, tool executable or checkpoint payload is published: the public '
        'build receipt records the binary filename and SHA-256 identity.</p>'
        + build_table
        + f'<p>{basis_notes}</p>'
        + '<h4>Toolchain identity</h4>' + toolchain_table
        + f'<p>Source provenance receipt: '
        + _artifact_link(record.provenance_manifest, "candidate input manifest")
        + '. This canonical manifest is the complete measured candidate input '
        'representation. The source rows below must equal its files exactly: path, raw '
        'digest, normalized digest and optional Git blob OID. Every normalized digest is '
        'recomputed from the attributed implementation commit.</p>'
        + provenance_table
        + '<h4>Measurement environment</h4>' + environment_table
        + '<h4>Public artifact registry</h4>' + artifact_table
        + '<h4>Optional NCU evidence</h4>' + ncu
        + '<h4>Explicit limitations</h4>' + limitations
        + f'<p>Acceptance decision: <code>{escape(record.decision_status)}</code>. '
        + escape(record.decision_rationale) + '</p>')


def _acceptance_html(record: FinalEvidence | None) -> str:
    if record is None:
        return note(
            "No full accepted runtime record is attached to this implementation "
            "commit. The page makes no runtime, speedup or counter claim. The "
            "source-free diagram draft is the development path until a real "
            "implementation commit, accepted paired evidence and final receipts exist.")
    return (_acceptance_timing_html(record)
            + _acceptance_checks_html(record)
            + _acceptance_identity_html(record))


def _body(provider, record: FinalEvidence | None, revision: str,
          source_paths) -> str:
    q = lambda key, caption, **kw: _quote(provider, key, caption, **kw)
    parts = []

    # 1 -------------------------------------------------------------------
    parts.append('<h2 id="problem">1. The whole model problem: dense C1024 FFN expansion</h2>')
    parts.append(_lead(
        'The dense C1024 FFN expansion computes <code>Y = act(X·W)</code> for '
        '<code>X[T,1024]</code> and <code>W[1024,4096]</code>, then applies the exact '
        'recovered clamped Half polynomial. The '
        '<a href="architecture.html">network architecture guide</a> places this operation '
        'inside the decoder bottleneck; the historical '
        '<a href="global_ffn_expand_c1024_fp16.html">FP16 FFN expansion lesson</a> keeps '
        'its own revision and evidence.'))
    parts.append(_p(
        'The input is the existing physical tensor contract, not a fresh row-major matrix: '
        'the globally padded tensor is not ordinary row-major. One model operation '
        'expands every token from 1024 input channels to 4096 output channels. The next '
        'sections derive the CTA tile, the warp duties, the resource budget and the '
        'execution schedule before following one token through the committed source.'))
    parts.append(_svg1())
    parts.append(_p(
        'The left-to-right figure separates three scales that are easy to conflate. One '
        'scalar contribution is a single product inside a 1024-term dot product. A token '
        'owns all 1024 input channels and all 4096 output channels. One CTA owns only a '
        '128×128 tile of one token tile, and one warp owns a 64×64 quadrant of that tile.'))
    parts.append(note(
        f'<strong>Source pin.</strong> This chapter quotes the implementation commit '
        f'<code>{revision[:12]}</code>. The 81 legacy lessons and the two additive '
        f'Small31 lessons remain owned by their existing pins in the '
        f'<a href="source-atlas.html#provenance">mixed-provenance atlas</a>. Every '
        f'excerpt is read from that committed tree, never from the working tree.'))
    parts.append(_h3("problem-contract", "The physical tensor contract is not row-major"))
    parts.append(_p(
        'The physical input groups 16 tokens together and stores a K32 slab as 1024 '
        'bytes. The global address is <code>g_Input + input_group·16384·element_bytes + '
        'ReductionTile·1024</code>; it is not <code>token·1024 + channel</code>. The '
        'output similarly groups 16 tokens: a token group contributes 131,072 bytes, '
        'an output block contributes 4096 bytes, and the lane/column terms select the '
        'exact vector. These equations are the contract the kernel actually reads.'))
    parts.append(_h3("problem-activation", "The recovered activation is part of the contract"))
    parts.append(_p(
        'The activation is evaluated in packed Half arithmetic: <code>t = min(x, upper)</code>, '
        'then <code>max(t, lower)</code>; the gate is '
        '<code>fma(t, fma(slope, |t|, intercept), offset)</code> and the final multiply is '
        'Half-rounded. The constants are model data in '
        '<code>csrc/common/layout/numerical_constants.h</code>, while the composition lives '
        'in <code>dlssnr::ops</code>. Reordering or widening any of these steps changes the '
        'network result, so the generic library does not decide this policy.'))
    parts.append(q("profile", "Project profile: FFN geometry and stage bytes", before=3, after=12))
    parts.append(q("activation", "Project activation: clamped packed-Half polynomial", before=4, after=18))
    parts.append(q("constants", "Exact model constants for the activation gate", before=3, after=12))

    # 2 -------------------------------------------------------------------
    parts.append('<h2 id="cta">2. The CTA subproblem: one 128×128 output tile</h2>')
    parts.append(_lead(
        'The CTA shape follows from the existing thread block: 128 threads in four warps. '
        'A 2×2 warp arrangement covers 128 tokens by 128 output channels, with each warp '
        'owning 64 tokens and 64 channels. The reduction then divides into 32 K32 '
        'software iterations, each with two K16 MMA subtiles.'))
    parts.append(_p(
        'A token tile is 128 tokens; 32 output blocks cover the 4096 expanded channels. '
        'The accumulator is distributed in registers rather than shared memory; section 4 '
        'accounts for the shared bytes and the per-thread register payload separately.'))
    parts.append(_h3("cta-grid", "Grid coordinates and the representative tile"))
    parts.append(_p(
        'For the trace, <code>blockIdx.z = 0</code> selects the first batch/head slice, '
        '<code>blockIdx.x</code> decodes to token tile 0 and output block 0, and at least '
        '128 valid tokens make every group in the first tile real. The CTA reads the same '
        '16-token input group through two consumer row groups: warps 0 and 1 share token '
        'row group 0, while warps 2 and 3 share row group 1. Each warp pair differs only '
        'in its 64-channel band.'))
    parts.append(q("ffn_signature", "Exported entry declares the shared storage reservation", before=5, after=12))
    parts.append(_h3("cta-ownership", "Warp ownership and the reduction loop"))
    parts.append(_p(
        'Warp <code>w</code> owns token rows <code>64·(w/2)</code> and channel columns '
        '<code>64·(w&amp;1)</code> of the CTA tile. Within a warp, four M fragments cover '
        'the 64 tokens in 16-row pieces, and four N16 channel groups cover the 64 columns. '
        'That gives <code>4 × 4 × 4 = 64</code> accumulator words per thread for the Half '
        'path. Each N16 group holds two independent N8 MMA fragments, so one K16 subtile '
        'issues a low-N8 MMA and then a high-N8 MMA.'))
    parts.append(q("ffn_accumulator", "Per-thread accumulator storage for four M fragments and four N16 groups", before=3, after=3))
    parts.append(q("tile_storage", "Tile accumulator keeps four words per spatial/channel cell", before=3, after=12))
    parts.append(q("tile_loop", "Fixed spatial → channel-group → K-subtile order; low N8 before high N8", before=8, after=22))

    # 3 -------------------------------------------------------------------
    parts.append('<h2 id="warp">3. Warp and thread duties: lane-owned fragments</h2>')
    parts.append(_lead(
        'An MMA fragment is a register contract, not a per-lane copy of a matrix. A lane '
        'owns four packed A words, two packed B words and, for the Half accumulator, two '
        'packed C words. All 32 lanes cooperate in a single <code>mma.sync</code>; the dot '
        'product is formed collectively.'))
    parts.append(_h3("warp-fragments", "The exact A, B and C mappings"))
    parts.append(_p(
        'For <code>m16n8k16</code>, A lane 21 has <code>group = 21/4 = 5</code> and '
        '<code>thread = 21%4 = 1</code>. It owns rows 5 and 13, and K columns 2, 3, 10 '
        'and 11 of the K16 subtile. Its four words are x = (row5, K2/3), y = (row13, '
        'K2/3), z = (row5, K10/11) and w = (row13, K10/11). For the trace K16 subtile '
        'starting at K144, those are channels 146/147 and 154/155; with the 16-token '
        'group based at token 32, the rows are tokens 37 and 45.'))
    parts.append(_p(
        'B lane 5 has <code>group = 5/4 = 1</code> and <code>thread = 5%4 = 1</code>. '
        'It owns column 1 inside its N8 tile and K rows 2, 3, 10 and 11. The selected '
        'weight <code>uint4</code> carries two adjacent N8 fragments: x and y are the '
        'low N8 fragment, z and w the high N8 fragment. For output 81 the low N8 base is '
        '80, so column 1 is exactly 81; the high fragment is columns 88–95 with its '
        'column 1 at 89.'))
    parts.append(_p(
        'C lane 20 has <code>group = 5</code> and <code>thread = 0</code>, so it owns '
        'output rows 5 and 13 and columns 0 and 1 of the N8 fragment. The first '
        'accumulator word holds row 5, columns 0 (low Half) and 1 (high Half); therefore '
        'Y[37,81] is the high Half of that first word. This is a collective result, not '
        'a value shipped from lane 21 to lane 20.'))
    parts.append(_table(
        ("Lane", "A rows", "A K columns", "B column", "B K rows", "C rows / columns"),
        (("21", "5, 13", "2, 3, 10, 11", "—", "—", "—"),
         ("5", "—", "—", "1 (low N8)", "2, 3, 10, 11", "—"),
         ("20", "—", "—", "—", "—", "5, 13 / 0, 1")),
        klass="inventory"))
    parts.append(_svg4())
    parts.append(q("core_traits", "A four-word and B two-word fragment contracts", before=2, after=12))
    parts.append(q("core_accumulator", "Half accumulator keeps two packed words", before=2, after=5))
    parts.append(q("mma_ptx", "One canonical m16n8k16 FP16→FP16 instruction form", before=8, after=8))
    parts.append(_h3("warp-collective", "The collective move and the separate register permutation"))
    parts.append(_p(
        'The MMA is a warp-wide collective: every lane supplies its own A and B fragment '
        'and receives its own C fragment. A lane contributes to several output columns, '
        'but there is no lane-to-lane scalar transport. The separate '
        '<code>permute_quad</code> and <code>shuffle_index</code> operations reorder '
        'registers for a caller; they do not change a shared or global address and are not '
        'part of the MMA result.'))
    parts.append(q("permutation", "Register permutation is separate from address formation", before=4, after=20))

    # 4 -------------------------------------------------------------------
    parts.append('<h2 id="resources">4. Resource budget: shared bytes, declared registers and ptxas</h2>')
    parts.append(_lead(
        'The kernel has two separate resource budgets. The first is a fixed shared-memory '
        'allocation of <code>24,600</code> bytes that stages A tiles and transaction '
        'barriers. The second is the per-thread register payload: source-declared word '
        'counts that the compiler may reuse, and a separate ptxas allocation when an '
        'accepted record is available. Neither is an occupancy or throughput claim.'))
    parts.append(_h3("resources-shared", "Shared-memory byte allocation"))
    parts.append(_p(
        f'The source reserves <code>{SHARED_BYTES:,}</code> bytes: three 8192-byte stages '
        f'(<code>3·8192 = 24576</code>) plus three 8-byte transaction barriers '
        f'(<code>3·8 = 24</code>). The barriers are at byte offsets 24576, 24584 and '
        f'24592. The slot bytes are 0, 8192 and 16384. This is a source-derived static '
        f'allocation; no occupancy or achieved-bandwidth claim follows from it.'))
    parts.append(q("strided_layout", "Compile-time byte strides: the caller supplies every stride; there are no hidden defaults", before=2, after=20))
    parts.append(q("views_slot", "Slot API requires an already-reduced slot; the iteration API owns the modulo", before=5, after=22))
    parts.append(_p(
        'The slot form is a caller contract: the slot must already be reduced into '
        '<code>0..StageCount-1</code>, and the caller owns pointer alignment and validity. '
        'The iteration form is the one API that owns the modulo. The view adds no runtime '
        'bounds check and no implicit alignment repair.'))
    parts.append(q("ffn_views", "The two physical views name the same three-slot ring with different coordinates", before=2, after=12))
    parts.append(q("ffn_fragment_view", "Consumer view: stage, warp row group, M fragment, K subtile, lane", before=1, after=8))
    parts.append(_p(
        'The addresses are plain byte striding. There is no XOR shared/global address '
        'swizzle in this tree, and the chapter does not invent one. The separate lane '
        'permutation utilities reorder registers; they do not change a shared or global '
        'address. Bank mapping is derivable only from the exact access width and address '
        'equations, and this page makes no conflict-count claim.'))
    parts.append(_svg3())
    parts.append(_h3("resources-registers", "Declared register payload versus compiler allocation"))
    parts.append(_p(
        'The CTA\'s 128×128 Half output tile is 32,768 bytes of logical accumulator state, '
        'but it is distributed across threads rather than allocated in shared memory. '
        'The source payload declares 64 accumulator words, 32 A words and 32 B words per '
        'thread: <code>64 + 32 + 32 = 128</code> scalar 32-bit slots. The A payload is '
        '<code>r_Input[4][2]</code> (eight <code>uint4</code> = 32 words); the B payload '
        'is <code>r_Weight[2][4]</code> (also eight <code>uint4</code> = 32 words). This '
        'is a declared payload count, not a guaranteed physical-register lower bound and '
        'not proof that every value stays simultaneously live after compiler scheduling '
        'and reuse. The actual ptxas allocation is reported separately below; the '
        'source-declared <code>__maxnreg__</code> cap is not an allocation measurement.'))
    parts.append(q("ffn_weight_registers", "Declared B payload: eight uint4 words-pairs in registers", before=2, after=3))
    parts.append(q("ffn_fragment_load", "Declared A payload: four M fragments × two K16 subtiles", before=7, after=5))
    parts.append(_evidence_html(record))
    parts.append(_h3("resources-owners", "Where the instructions, bytes and policies are owned"))
    parts.append(_p(
        'Each instruction form has one canonical definition. <code>flashlight/arch</code> '
        'owns the instruction wrappers for MMA, async copy, barriers, memory ordering and '
        'scalar math. <code>flashlight/numeric/packed.cuh</code> owns the E4M3 conversion '
        'PTX and its packed Half/E4 composition. <code>csrc/common/ops/frontend_texture.h</code> '
        'owns the model texture/surface PTX. Higher layers add typed fragment, storage and '
        'lifecycle contracts; they do not re-spell the same instruction. The generic '
        'FlashLight headers depend only on CUDA, the C++ standard library or other '
        'FlashLight headers, and have no Torch, Python, DLSSNR, CUTLASS or ThunderKittens '
        'dependency.'))
    parts.append(_module_table(provider))
    parts.append(_svg2())
    parts.append(_h3("resources-rules", "The boundary rules that make the hierarchy real"))
    parts.append(_ul((
        'Generic FlashLight headers depend only on CUDA, the C++ standard library or other '
        'FlashLight headers. They have no Torch, Python, DLSSNR, CUTLASS or ThunderKittens '
        'dependency.',
        'Every primitive has one canonical definition: <code>flashlight/arch</code> for '
        'instruction wrappers, <code>flashlight/numeric/packed.cuh</code> for E4M3 '
        'conversions, and <code>csrc/common/ops/frontend_texture.h</code> for model '
        'texture/surface operations. Higher layers add typed contracts; they do not '
        're-spell the same instruction.',
        'C++17 is the language baseline. FP16 MMA requires SM80+, FP8 requires SM89+, the '
        'CTA bulk-copy path requires SM90+, and SM80/86/89 retain the lane-striped '
        '<code>cp.async</code> fallback.',
        'The tree uses no tcgen05, TMA, <code>ldmatrix</code> or address swizzle. The only '
        'matrix-adjacent warp move is <code>movmatrix.sync.trans</code> in '
        '<code>arch/warp.cuh</code>; do not describe a mechanism the source does not use.',
        'Election, memory ordering, group waits and CTA synchronization stay visible at '
        'the call site. The library supplies named operations, not an automatic scheduler '
        'or an invented barrier.',
        'Numerical policy stays with the model: the FFN activation is in '
        '<code>dlssnr::ops</code>; the Small31 Float PV/denominator policy is in '
        '<code>csrc/common/ops/small_attention.h</code>; Half accumulation remains the '
        'legacy/tile path.')))
    parts.append(q("small_policy", "Small31 FP32 denominator policy belongs to project common ops", before=10, after=7))
    parts.append(q("pipeline_group", "Copy-group lifecycle: commit and wait are separate named operations", before=5, after=24))
    parts.append(q("pipeline_barrier", "Transaction-barrier lifecycle: initialize, expect, arrive, ready", before=5, after=44))
    parts.append(q("warp_election", "One elected bulk issuer on SM90+, every member lane on earlier targets", before=8, after=12))
    parts.append(q("async_bulk", "SM90+ bulk copy retains CTA shared memory and byte accounting", before=4, after=10))
    parts.append(q("async_fallback", "Pre-SM90 fallback remains lane-striped 16-byte cp.async", before=4, after=18))
    parts.append(q("async_expect", "Expected-byte accounting is a real SM90+ operation and a preserved no-op earlier", before=3, after=14))
    parts.append(_h3("resources-host", "Host, Python and build ownership"))
    parts.append(_p(
        'Validation, raw-ABI binding, deployment preparation, replay and boxed registration '
        'have one owner under <code>csrc/common/host</code>. Python model selection, '
        'record decoding, asset resolution and plan generation have their own owners; '
        'build/packaging is separate again. These layers consume the committed FlashLight '
        'and DLSSNR headers rather than duplicating them. The chapter links the exact '
        'files at the implementation commit, but it does not retell their implementation '
        'history.'))
    for path in LINKED_PATHS:
        _require_path(provider, path)
    parts.append(_table(
        ("Ownership", "Current file", "Role"),
        (("host physical contract", f'<a href="{source_url("csrc/common/host/physical_tensor.h", provider=provider)}"><code>csrc/common/host/physical_tensor.h</code></a>', "dtype/device/extent/alignment/disjointness/capture checks"),
         ("host raw ABI", f'<a href="{source_url("csrc/common/host/parameter_binding.h", provider=provider)}"><code>csrc/common/host/parameter_binding.h</code></a>', "typed writes into the fixed launch record"),
         ("host deployment", f'<a href="{source_url("csrc/common/host/deployment_runtime.h", provider=provider)}"><code>csrc/common/host/deployment_runtime.h</code></a>', "prepare, introspect, replay and guard plan buffers"),
         ("host boxed dispatch", f'<a href="{source_url("csrc/common/host/boxed_dispatch.h", provider=provider)}"><code>csrc/common/host/boxed_dispatch.h</code></a>', "one CUDA/Meta boxed invocation"),
         ("model selectors", f'<a href="{source_url("dlssnr/model_specs.py", provider=provider)}"><code>dlssnr/model_specs.py</code></a>', "explicit legacy71 / Small31 selection; not a FlashLight concern"),
         ("Small31 model facade", f'<a href="{source_url("dlssnr/small_model.py", provider=provider)}"><code>dlssnr/small_model.py</code></a>', "Small31 model entry and checkpoint-facing facade"),
         ("record/asset decoding", f'<a href="{source_url("dlssnr/runtime_assets.py", provider=provider)}"><code>dlssnr/runtime_assets.py</code></a>', "runtime record and asset resolution"),
         ("plan generation", f'<a href="{source_url("tuning/generate_plan.py", provider=provider)}"><code>tuning/generate_plan.py</code></a>', "generated plan metadata and physical schedule"),
         ("physical schedule", f'<a href="{source_url("tuning/physical_schedule.py", provider=provider)}"><code>tuning/physical_schedule.py</code></a>', "schedule/placement metadata owned separately from device code"),
         ("inventory/build tooling", f'<a href="{source_url("tools/kernel_sources.py", provider=provider)}"><code>tools/kernel_sources.py</code></a>', "roster and source-ownership audit; no device execution"),
         ("packaging/build", f'<a href="{source_url("setup.py", provider=provider)}"><code>setup.py</code></a>', "packaging and extension build ownership; not a FlashLight dependency")),
        klass="inventory"))
    parts.append(_p(
        'The explicit model selection remains legacy71 / Small31 with their existing '
        'checkpoints and public entry names. Independent oracles, golden benchmark lists '
        'and evidence records are not shared configuration; this chapter neither duplicates '
        'nor relabels them. Counts and reductions appear here only when they are accepted '
        'static source results or bytes derived from the committed constants.'))
    parts.append(q("host_validation", "Host physical contract: alignment is a caller-visible requirement", before=4, after=8))
    parts.append(q("host_binding", "Raw-ABI binding keeps the 96-byte record and offset checks", before=10, after=8))
    parts.append(q("host_prepare", "Deployment preparation clears every bound pointer before replay", before=6, after=14))
    parts.append(q("host_boxed", "Boxed CUDA/Meta invocation is one mechanism", before=8, after=10))
    parts.append(q("abi_record", "The FFN expansion parameter record remains 72 bytes with fixed offsets", before=1, after=20))

    # 5 -------------------------------------------------------------------
    parts.append('<h2 id="schedule">5. The three-slot schedule and explicit synchronization</h2>')
    parts.append(_lead(
        'The kernel initializes three transaction barriers with 128 arrivals, publishes '
        'the initialization with <code>__syncthreads</code>, primes the weight registers, '
        'fills slots 0, 1 and 2, and waits on slot 0. Each iteration reads the current '
        'A fragments from shared memory, issues the typed accumulation, preloads the next '
        'B tile, waits for the next A stage, and refills the consumed slot with iteration '
        'i+3 when it is still in range.'))
    parts.append(_h3("schedule-init", "Initialization and first fill"))
    parts.append(_p(
        'Only thread (0,0) initializes the three barrier slots; the following '
        '<code>__syncthreads</code> is the publication point for every consumer. The '
        'producer lambda issues one 1024-byte copy per selected token group with '
        '<code>copy_then_expect</code>, or writes exact zero vectors for an out-of-range '
        'group. The wait lambda arrives with the caller\'s count and polls the opaque '
        'arrival token; it does not substitute a CTA barrier.'))
    parts.append(q("ffn_barrier_init", "Initialize each slot with blockDim.x·blockDim.y arrivals", before=5, after=6))
    parts.append(q("ffn_producer", "Producer election and the copy/expect composition", before=8, after=12))
    parts.append(q("ffn_copy_expect", "Issue the bulk copy, then add the exact expected bytes", before=2, after=3))
    parts.append(q("ffn_prime", "Prime weights, fill all three slots, then wait for slot 0", before=2, after=7))
    parts.append(_h3("schedule-loop", "The ordered iteration and refill"))
    parts.append(_p(
        'The loop order is fixed: load A fragments for the current slot, run the typed '
        'tile accumulation, then preload the next B tile, wait for the next A stage, and '
        'finally refill the consumed slot for iteration <code>i+3</code>. The A fragments '
        'are already in registers before the refill overwrites the slot, so the refill '
        'does not need an extra consumer barrier. The ring has exactly three live slots; '
        'the stage index is reduced modulo three before any slot API is used.'))
    parts.append(q("ffn_tiled_mma", "Typed tiled MMA: four M fragments, two K16 subtiles, four N16 groups", before=4, after=3))
    parts.append(q("ffn_refill", "Recycle the consumed slot for the tile three steps ahead", before=6, after=4))
    parts.append(q("ffn_wait_stage", "Wait on the exact iteration token; no implicit CTA barrier", before=4, after=4))
    parts.append(_h3("schedule-protocol", "Issue, expected bytes, arrival token and poll are distinct"))
    parts.append(_p(
        'The library deliberately separates <code>AsyncCopyGroup</code> from '
        '<code>TransactionBarrier</code>. A copy-group wait is not a transaction wait, and '
        'an arrival token is an opaque 64-bit value, not a phase-parity bit. On SM90+ the '
        'bulk copy is a single elected issuer with <code>expect_tx</code> byte accounting. '
        'On SM80/86/89 each member lane copies 16 bytes, attaches completion with '
        '<code>cp.async.mbarrier.arrive</code>, and <code>expect_tx</code> is a preserved '
        'no-op so the mechanism is not double-counted. No implicit commit, zero fill, '
        'sleep, <code>syncwarp</code> or CTA barrier is added by the library.'))
    parts.append(q("pipeline_copy_expect", "copy_then_expect is an explicit composition, not an automatic lifecycle", before=4, after=8))
    parts.append(q("pipeline_poll", "Per-thread arrive, then tight polling of the exact token", before=4, after=8))
    parts.append(_svg5())
    parts.append(_p(
        'The figure shows the stage lifecycle rather than an occupancy model: in '
        'iteration i the kernel reads slot i%3, issues two K16 MMAs, preloads weights '
        'i+1, waits for stage i+1 and then refills the same slot with StageInput(i+3). '
        'Columns are loop iterations in logical execution order, not a measured time '
        'axis. The two copy protocols share the barrier contract but not the issuing '
        'mechanism, and the chapter makes no claim that the fallback serializes through '
        'one lane.'))
    parts.append(_h3("schedule-acquire",
                     "The resident split acquire is a deliberate correctness change"))
    parts.append(_p(
        'Seven resident split consumer translation units now issue the GPU acquire after '
        'successful relaxed counter polling and before the existing CTA barrier. This '
        'closes a pre-existing memory-ordering gap: the observing lane saw the relaxed '
        'counter, but the CTA barrier alone did not order the predecessor\'s release '
        'before consumers read its scratch. No corruption was observed. The change is a '
        'deliberate correctness fix alongside the wrapper migration, not merely renamed '
        'wrappers.'))
    for path in SYNCHRONIZATION_TUS:
        _require_path(provider, path)
    parts.append(_ul(
        f'<a href="{source_url(path, provider=provider)}"><code>{escape(path)}</code>'
        f'</a> — resident poll → acquire fence → existing CTA barrier'
        for path in SYNCHRONIZATION_TUS))
    parts.append(_p(
        'The fence is the existing <code>SplitPublication::acquire_fence()</code> API, '
        'which spells <code>fence.acq_rel.gpu</code>. It is issued once after the '
        'successful poll, not on every unsuccessful read, and the caller-owned CTA '
        'barrier still publishes the data to the other consumer threads. The predicate, '
        '64 ns backoff, observed count, publication, cache choices, launch guards and '
        'arithmetic are unchanged. This is source-level evidence only; no fresh NCU, '
        'runtime or performance measurement is claimed for the change.'))
    parts.append(_p(
        'Primary memory-model references: '
        + ', '.join(
            f'<a href="{url}">NVIDIA PTX {escape(label)}</a>'
            for label, url in PTX_MEMORY_MODEL_URLS)
        + '. A strong read followed by an acquire fence forms an acquire pattern; a '
        'compatible GPU-scope producer release plus that pattern supplies ordering, and '
        'the existing CTA barrier then shares it with every consumer thread. A CTA '
        'barrier alone cannot supply the missing producer-to-observer acquire.'))
    parts.append(q("publication_acquire",
                   "The public acquire fence: issue once after polling, before the caller's CTA barrier",
                   before=3, after=5))
    parts.append(q("memory_acquire",
                   "The exact PTX acquire form and the ownership split with the caller",
                   before=3, after=5))

    # 6 -------------------------------------------------------------------
    parts.append('<h2 id="trace">6. One token through the committed source</h2>')
    parts.append(_lead(
        'Use the first token tile and output block, batch/head slice 0, at least 128 valid '
        'tokens, reduction iteration 4 (K128–159) and ring slot 1. Follow '
        '<code>X[token37, k146]</code> into its contribution to '
        '<code>Y[token37, n81]</code>.'))
    parts.append(_h3("trace-coordinates", "Coordinate arithmetic before any source excerpt"))
    parts.append(_table(
        ("Quantity", "Exact derivation", "Value"),
        (("Token group / local row", "37 / 16 = 2 remainder 5", "group 2, row 5"),
         ("K iteration / submit / local K", "146 / 32 = 4 remainder 18; 18 / 16 = 1 remainder 2", "iteration 4, Ksub 1, local K 2"),
         ("Producer", "group offset 2 → warp 2, copy group 0", "warp 2, copy 0"),
         ("Global slab", "2·16384·2 + 4·1024", "69632"),
         ("Shared slab", "1·8192 + 2·1024", "10240"),
         ("A lane", "(5%8)·4 + (2%8)/2", "21"),
         ("A relative byte", "1·512 + 21·16", "848"),
         ("Global X byte", "69632 + 848", "70480"),
         ("Shared X byte", "10240 + 848", "11088"),
         ("Consumer M fragment", "37 mod 64 = 37; 37 / 16", "2"),
         ("Weight panel / N16 group", "146 / 16 = 9 remainder 2; 81 → block0, half1, N16 group1", "panel 9, N16 group 1"),
         ("B lane / word", "column 81 is low N8 column 1; local K2", "lane 5, word x"),
         ("Weight byte", "0·4096 + 1·2048 + 5·16 + 9·131072 + 1·512", "1182288"),
         ("C lane / word / half", "row5, column1 → group5/thread0", "lane 20, word0, high"),
         ("Output uint4 start", "2·131072 + 0 + 1·2048 + 20·16 + 1·512", "265024"),
         ("Y[37,81] byte", "265024 + 0·4 + 1·2", "265026")),
        klass="inventory"))
    parts.append(_svg6())
    parts.append(_h3("trace-input", "1. Declare the views and the ring, then copy the selected slabs"))
    parts.append(_p(
        'The producer writes the selected 1024-byte slab into slot1 at shared byte 10240 '
        'and the barrier expects exactly those bytes. The same physical ring is later read '
        'as the consumer fragment layout; only the coordinate names change. The two '
        '<code>uint4</code> stores in the out-of-range branch are explicit zero fill, not '
        'an implicit copy semantic.'))
    parts.append(q("ffn_views", "Declare the two physical views over the same shared ring", before=2, after=20))
    parts.append(q("ffn_barrier_ring", "Name the three-slot barrier ring once", before=2, after=4))
    parts.append(q("ffn_input_address", "Global slab address for token group 2 and iteration 4", before=7, after=6))
    parts.append(_p(
        'The selected A <code>uint4</code> is not eight adjacent logical channels of one '
        'token. It packs x = token37/K146,147, y = token45/K146,147, z = token37/K154,155 '
        'and w = token45/K154,155. That is exactly the m16n8k16 A layout, and it is why '
        'the producer can copy the physical slab without a transpose.'))
    parts.append(q("ffn_fragment_load", "Consumer warps 0 and 1 read M fragment 2 from the same slot", before=6, after=8))
    parts.append(_h3("trace-b", "2. Obtain the B fragments and their adjacent N8 pair"))
    parts.append(_p(
        'The weight tile base selects output block 0, channel half 1 (columns 64–127), '
        'lane 5 and the 128-KiB panel stride. The panel for K146 is 9, so the address is '
        '1182288. The loaded <code>uint4</code> carries x/y for the low N8 fragment '
        '(columns 80–87) and z/w for the adjacent high N8 fragment (columns 88–95); '
        '<code>x</code> low Half is W[146,81], while <code>z</code> low Half is W[146,89].'))
    parts.append(q("ffn_weight_base", "Weight tile base: output block, channel half and lane", before=4, after=10))
    parts.append(q("ffn_weight_load", "One uint4 supplies two adjacent N8 fragments", before=10, after=8))
    parts.append(q("ffn_weight_registers", "Eight uint4 registers hold two K16 subtiles × four N16 groups", before=2, after=6))
    parts.append(_h3("trace-mma", "3. Call the typed tiled MMA and preserve the collective"))
    parts.append(_p(
        'All 32 lanes issue one <code>mma.sync.m16n8k16</code> for the low N8 fragment and '
        'then one for the high N8 fragment. The A fragment contributes to several output '
        'columns of the warp; the scalar is not transported from lane 21 to lane 20. '
        'Lane 20 receives C row 5, columns 0 and 1, and the high Half of its first '
        'accumulator word is exactly Y[37,81]. The accumulator stays resident across every '
        'ordered K subtile and iteration.'))
    parts.append(q("ffn_tiled_mma", "Typed accumulation preserves the low-N8 / high-N8 order", before=3, after=4))
    parts.append(q("tile_loop", "The tile loop keeps spatial → channel-group → K-subtile order", before=8, after=24))
    parts.append(_h3("trace-activation", "4. Finish all 1024 contributions, then apply activation"))
    parts.append(_p(
        'The activation runs after the complete reduction and before the store. Every one '
        'of the 64 accumulator words is passed through the same packed-Half polynomial, '
        'with its six original rounding points and min/max order. Slot1 is a reuse buffer, '
        'not a persistent token store: it is recycled for iterations 1, 4, 7, … only after '
        'the pipeline\'s reader has the fragments it needs. Y[37,81] still includes all '
        '1024 input-channel products.'))
    parts.append(q("ffn_activation", "Exact recovered activation applied to every accumulator word", before=6, after=12))
    parts.append(_h3("trace-store", "5. Publish the no-allocate vector at the exact output byte"))
    parts.append(_p(
        'The output vector starts at byte 265024; Y[37,81] is its high Half at 265026. The '
        'store is a 16-byte <code>st.global.L1::no_allocate.b128</code>, distinct from an '
        'ordinary aligned store. The cache qualifiers on the input load and the output '
        'store are policies: the figure labels the hardware-managed cache stage as '
        'potential caching, not a guaranteed hit.'))
    parts.append(q("ffn_output", "Output address: token group, output block, channel half, lane", before=2, after=10))
    parts.append(q("ffn_store", "No-allocate 16-byte publication of the four accumulator words", before=4, after=6))
    parts.append(q("memory_store", "The exact no-allocate store instruction", before=3, after=8))
    parts.append(q("ffn_refill", "Slot1 is recycled only through the reader-release/wait protocol", before=5, after=5))
    parts.append(_h3("trace-milestones", "Implementation milestones in the committed source"))
    milestones = (
        ("Declare the view strides and the ring", "The two `StagedSharedLayoutView` declarations name the same three physical slots with producer and consumer coordinates; `TransactionBarrierRing` names the barrier base.", q("ffn_views", "Milestone 1: view strides and barrier ring", before=2, after=20)),
        ("Prime the copies", "Initialize three barriers with 128 arrivals, publish with `__syncthreads`, load weight tile 0, fill slots 0–2 and wait for slot 0.", q("ffn_prime", "Milestone 2: barrier initialization, first fill and wait", before=8, after=7)),
        ("Obtain the fragments", "Each thread loads its eight A `uint4`s from the current slot with the consumer layout; the B payload is already resident.", q("ffn_fragment_load", "Milestone 3: load the lane-owned A fragments", before=6, after=8)),
        ("Call the typed tiled MMA", "`accumulate_tile` consumes the four-word A fragment and the two-word low/high B fragments in the fixed order.", q("ffn_tiled_mma", "Milestone 4: typed tiled MMA", before=3, after=4)),
        ("Preserve activation and rounding", "Apply the project polynomial after the final K contribution; do not fold it into the accumulator early or widen it to FP32.", q("ffn_activation", "Milestone 5: exact activation and rounding", before=6, after=12)),
        ("Publish", "Form the four-word output vector and issue the no-allocate store at the physical output address.", q("ffn_store", "Milestone 6: no-allocate publication", before=4, after=6)),
    )
    for index, (heading, text, excerpt) in enumerate(milestones, 1):
        parts.append(_h3(f"milestone-{index}", f"Milestone {index}. {heading}"))
        parts.append(_p(text))
        parts.append(excerpt)
    parts.append(_h3("trace-extension", "Practical rules for extending the library"))
    parts.append(_ul((
        'Give each primitive one canonical definition. Instruction wrappers live in '
        '<code>flashlight/arch</code>, E4M3 conversions in '
        '<code>flashlight/numeric/packed.cuh</code>, and model texture/surface operations '
        'in <code>csrc/common/ops/frontend_texture.h</code>. If a second caller needs the '
        'same instruction, add a typed contract above it, not a second PTX spelling.',
        'Type the fragment and storage contract explicitly: word count, alignment, byte '
        'units, ownership and cache policy. Do not hide a layout conversion in an accessor.',
        'Compose the schedule at kernel scope. The library may name copy, expect, arrive, '
        'wait and publication operations, but the caller keeps election, ordering, bounds '
        'and the numerical policy.',
        'Verify four things before adopting a change: the source and roster audit, the '
        'C++17 compile for every supported target, the numerical/rounding behavior, and '
        'the accepted measured performance. A compile-only result is not performance '
        'acceptance.')))
    parts.append(_acceptance_html(record))
    parts.append(_h3("trace-sources", "Current source bundle and primary references"))
    parts.append(_p(
        'Every current path below is copied under <code>source-current/</code> from the '
        'implementation commit; the pinned link points at that exact full SHA. The '
        'historical <code>source/</code> tree is untouched and still belongs to the '
        'original snapshot.'))
    parts.append(_source_bundle_table(source_paths, provider))
    parts.append(_p(
        'Primary mapping support: <a href="https://docs.nvidia.com/cuda/archive/11.5.1/'
        'parallel-thread-execution/index.html#warp-level-matrix-fragment-mma-16816-float">'
        'NVIDIA PTX warp-level matrix fragment documentation for m16n8k16</a>. The CUTLASS '
        '<a href="https://docs.nvidia.com/cutlass/media/docs/cpp/gemm_api.html">GEMM API '
        'design documentation</a> is cited only as inspiration for separating '
        'responsibilities; no vendor diagram or CUTLASS code is copied, and CUTLASS is not '
        'a dependency.'))
    parts.append(_p(
        'The source bundle above is the complete set of files this chapter quotes, all '
        'resolved at the implementation commit. Compiler/static allocation numbers '
        'appear only from the accepted candidate ptxas rows; runtime rows and category '
        'checks appear only from the same full acceptance bundle. The page never infers '
        'performance from source declarations or from a related benchmark, and a '
        'ptxas-only record is rejected as incomplete runtime acceptance.'))
    return "".join(parts)


def required_sections() -> tuple[str, ...]:
    """Return the exact forward-design section identifiers checked by the builder."""
    return SECTION_IDS


def validate_chapter_body(body: str) -> None:
    """Reject a chapter that is structurally incomplete or mislabelled.

    This is intentionally a pure HTML check so it can be exercised without a
    provider, a Git commit, CUDA or a documentation build.
    """
    headings = re.findall(r'<h2 id="([^"]+)">(.*?)</h2>', body, re.S)
    found = tuple(ident for ident, _ in headings)
    if found != SECTION_IDS:
        raise ChapterError(
            f"FlashLight chapter must have exactly the six forward-design sections "
            f"{SECTION_IDS}, found {found}")
    split = re.split(r'<h2 id="[^"]+">.*?</h2>', body)
    fragments = dict(zip(SECTION_IDS, split[1:]))
    for identifier, fragment in fragments.items():
        if "<h3" not in fragment:
            raise ChapterError(f"section {identifier} has no real subheading")
        if "<p" not in fragment:
            raise ChapterError(f"section {identifier} has no narrative paragraph")
    resource_heading = dict(headings)["resources"]
    if "resource budget" not in resource_heading.lower():
        raise ChapterError(
            "section 4 must be the resource budget; it currently says "
            f"{resource_heading!r}")
    resource_section = fragments["resources"].lower()
    missing = [marker for marker in RESOURCE_BUDGET_MARKERS
               if marker.lower() not in resource_section]
    if missing:
        raise ChapterError(
            "section 4 is missing resource-budget content: " + ", ".join(missing))
    if "<aside" in body and "<svg" in body and body.index("<aside") < body.index("<svg"):
        raise ChapterError(
            "the provenance sidebar must follow the model-context diagram, not open the body")
    figures = re.findall(r"<svg\b.*?</svg>", body, re.S)
    if len(figures) < MIN_DIAGRAMS:
        raise ChapterError(
            f"FlashLight chapter needs at least {MIN_DIAGRAMS} bespoke SVGs, "
            f"found {len(figures)}")
    titles = set()
    for figure in figures:
        try:
            root = ET.fromstring(figure)
        except ET.ParseError as exc:
            raise ChapterError(f"malformed inline SVG: {exc}") from exc
        if not root.get("viewBox"):
            raise ChapterError("inline SVG is missing viewBox")
        title = root.find("{http://www.w3.org/2000/svg}title")
        desc = root.find("{http://www.w3.org/2000/svg}desc")
        if title is None or not (title.text or "").strip():
            raise ChapterError("inline SVG is missing a title")
        if desc is None or not (desc.text or "").strip():
            raise ChapterError("inline SVG is missing a desc")
        if title.text in titles:
            raise ChapterError(f"duplicate SVG title: {title.text!r}")
        titles.add(title.text)
    for target in ("architecture.html", "global_ffn_expand_c1024_fp16.html"):
        if f'href="{target}"' not in body:
            raise ChapterError(f"FlashLight chapter must link {target}")
    if "<!--" in body:
        raise ChapterError("FlashLight chapter contains an unfilled HTML placeholder")


def _source_paths(provider) -> list[str]:
    """Return the current csrc dependency closure used by the chapter bundle."""
    from publishing import current_dependencies
    found = set()
    for path, _ in ANCHORS.values():
        if path.startswith("csrc/"):
            found.add(path)
    for path, _, _, _ in MODULES:
        if path.startswith("csrc/"):
            found.add(path)
    pending = list(found)
    while pending:
        path = pending.pop()
        for candidate in current_dependencies(path, provider):
            if candidate not in found:
                found.add(candidate)
                pending.append(candidate)
    return sorted(found)


def build_chapter(provider, evidence=None) -> dict:
    """Build the additive FlashLight chapter for one real current provider.

    This function is the only public entry point that reads source.  It fails on
    an absent/misattributed provider, a missing or ambiguous anchor, a missing
    module name, a malformed evidence record, or an incomplete chapter body.
    On failure it removes only the current excerpts it appended; the historical
    ``SNIPPETS`` registry and any pre-existing entries are never reset.
    """
    revision = _require_current_provider(provider)
    record = _validated_evidence(evidence, revision)
    registry_start = len(CURRENT_SNIPPETS)
    try:
        # Fail before emitting anything if the bundle cannot be resolved.
        source_paths = _source_paths(provider)
        for path in LINKED_PATHS:
            _require_path(provider, path)
        body = _body(provider, record, revision, source_paths)
        validate_chapter_body(body)
        for path in source_paths:
            if not provider.exists(path):
                raise ChapterError(f"current source bundle path is absent: {path}")
        return dict(
            slug="flashlight",
            title="FlashLight: the C1024 FP16 FFN expansion from contract to source",
            summary=("The independent FlashLight hierarchy and one worked FP16 C1024 FFN "
                     "expansion tile: physical layout, warp fragments, byte budget, "
                     "responsibility boundaries, explicit pipeline and a full contribution "
                     "trace at the current implementation commit."),
            body=body,
            source_provider="current",
            source_revision=revision,
            source_paths=source_paths,
            linked_paths=list(LINKED_PATHS),
            sections=list(SECTION_IDS),
            evidence_state=("accepted" if record is not None else "pending"),
            evidence_sha256=(record.sha256 if record is not None else None),
            evidence_acceptance_id=(record.acceptance_id if record is not None else None),
            evidence_case_rows_sha256=(record.case_rows_sha256()
                                       if record is not None else None),
            evidence_gate_rows_sha256=(record.gate_rows_sha256()
                                       if record is not None else None),
            evidence_artifacts=([dict(path=artifact.path, sha256=artifact.sha256,
                                      kind=artifact.kind, identity=artifact.identity)
                                 for artifact in record.artifacts]
                                if record is not None else []),
        )
    except BaseException:
        del CURRENT_SNIPPETS[registry_start:]
        raise
