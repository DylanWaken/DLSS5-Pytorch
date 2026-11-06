// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
// The three-stage input ring is addressed through typed coordinate views, and the
// transaction barriers through their named lifecycle ring.
#include <common/layout/global_profiles.h>
#include <common/ops/activation.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/tile/mma.cuh>
#include <cuda_runtime.h>
#include <cstdint>

extern "C" __global__
	__maxnreg__(168) void global_ffn_expand_c1024_fp16(FGlobalFfnExpandC1024Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	using FProfile = dlssnr::layout::GlobalFfnExpandProfile<false>;
	__shared__ __align__(512) unsigned char s_Storage[FProfile::barrier_base + 24];
	const uint32_t Lane = threadIdx.x;
	const uint32_t Warp = threadIdx.y;
	const uint32_t g_TokenCount = Parameters.BatchCount * Parameters.TokensPerBatch;
	const uint32_t g_TokenTileCount = (g_TokenCount + 127) / 128;
	const uint32_t g_OutputBlock = blockIdx.x / g_TokenTileCount;
	const uint32_t g_FirstTokenGroup = (blockIdx.x % g_TokenTileCount) * 8;
	const uint32_t g_GroupCount =
		((g_TokenCount + FProfile::token_alignment - 1) / FProfile::token_alignment) *
		(FProfile::token_alignment / 16);
	const bool bBroadcastSmallHalf = g_TokenCount <= 16;
	const uint64_t g_Input = Parameters.g_Input + uint64_t(blockIdx.z) * 16384 * FProfile::element_bytes;
	const uint64_t g_PackedWeights =
		Parameters.g_PackedWeights + uint64_t(blockIdx.z) * (1024 * 4096) * FProfile::element_bytes;

	// Both staged views name the same physical ring. The producer writes
	// (stage, warp, copy-group) chunks; the consumer reads the identical bytes as
	// (stage, warp-row-group, spatial fragment, K subtile, lane). All view calls
	// below use the reduced-slot forms: s_StageIndex is already in 0..2.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	using StageInputSharedView =
		flashlight::memory::StagedSharedLayoutView<uint4,
												   flashlight::layout::ByteStrides<1024, 4096, 512, 16>,
												   FProfile::stage_count, FProfile::stage_bytes>;
	using FragmentSharedView =
		flashlight::memory::StagedSharedLayoutView<uint4,
												   flashlight::layout::ByteStrides<4096, 1024, 512, 16>,
												   FProfile::stage_count, FProfile::stage_bytes>;
	const StageInputSharedView StageInputView(Shared);
	const FragmentSharedView StageFragments(Shared);
	const flashlight::memory::TransactionBarrierRing<FProfile::stage_count> BarrierRing(
		Shared, FProfile::barrier_base);

	// Packed storage groups 16 tokens together. Initial fill and refill copy
	// the same two 1024-byte K slabs; out-of-range groups contribute exact zero.
	const auto StageInput = [&](uint32_t ReductionTile, uint32_t s_StageIndex)
	{
		const auto s_Barrier = BarrierRing.at_slot(s_StageIndex);
		#pragma unroll
		for (int CopyGroup = 0; CopyGroup < 2; ++CopyGroup)
		{
			const uint32_t g_TokenGroup = g_FirstTokenGroup + Warp + CopyGroup * 4;
			if (g_TokenGroup < g_GroupCount || bBroadcastSmallHalf)
			{
				const uint32_t g_InputGroup = bBroadcastSmallHalf ? 0 : g_TokenGroup;
				const uint64_t g_Source =
					g_Input + uint64_t(g_InputGroup) * 16384 * FProfile::element_bytes + ReductionTile * 1024;

				// Native bulk copies use one producer; portable copies use all lanes.
				if (flashlight::arch::is_copy_producer(0xffffffffu))
				{
					s_Barrier.copy_then_expect(
						StageInputView.byte_offset_slot(s_StageIndex, Warp, CopyGroup, 0, 0),
						flashlight::memory::GlobalAddress(g_Source), 1024);
				}
			}
			else
			{
				StageInputView.store_slot(make_uint4(0, 0, 0, 0), s_StageIndex, Warp, CopyGroup, 0, Lane);
				StageInputView.store_slot(make_uint4(0, 0, 0, 0), s_StageIndex, Warp, CopyGroup, 1, Lane);
			}
		}
	};

	// Every thread arrives. The mbarrier token retains parity when the
	// three-slot ring wraps; a CTA-wide barrier is not substituted.
	const auto WaitStage = [&](uint32_t Iteration)
	{ BarrierRing.for_iteration(Iteration).arrive_and_wait(); };

	if ((Lane | Warp) == 0)
	{
		#pragma unroll
		for (int s_StageIndex = 0; s_StageIndex < FProfile::stage_count; ++s_StageIndex)
			BarrierRing.at_slot(s_StageIndex).initialize(blockDim.x * blockDim.y);
	}

	__syncthreads();

	uint4 r_Weight[2][4];

	// Each uint4 supplies two adjacent N8 fragments. FP16 retains the original
	// 128-KiB weight-record stride between the two K subtiles.
	const auto LoadWeights = [&](uint32_t ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			g_PackedWeights + g_OutputBlock * 4096 + (threadIdx.y & 1) * 2048 + threadIdx.x * 16;
		#pragma unroll
		for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weight[r_KTile][r_NTile] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_WeightTileBase +
														  uint64_t(ReductionTile * 2 + r_KTile) * 131072 +
														  r_NTile * 512));
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < FProfile::stage_count; ++s_StageIndex)
		StageInput(s_StageIndex, s_StageIndex);
	WaitStage(0);

	// One warp accumulates 64 tokens x 64 output channels in Half. Input values
	// are already stored in the native MMA A layout, so no transpose is needed.
	flashlight::tile::TiledMmaAccumulator<4, 4> r_Accumulator{};
	#pragma unroll 1
	for (uint32_t ReductionTile = 0; ReductionTile < FProfile::reduction_steps; ++ReductionTile)
	{
		const uint32_t s_StageIndex = ReductionTile % FProfile::stage_count;
		uint4 r_Input[4][2];
		#pragma unroll
		for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
			#pragma unroll
			for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
				r_Input[r_MTile][r_KTile] =
					StageFragments.load_slot(s_StageIndex, Warp / 2, r_MTile, r_KTile, Lane);
		flashlight::tile::accumulate_tile<FProfile::precision>(r_Accumulator, r_Input, r_Weight);

		// Match the native software pipeline: preload B, wait for the next A
		// stage, then recycle the consumed stage for the tile three steps ahead.
		if (ReductionTile + 1 < FProfile::reduction_steps)
		{
			LoadWeights(ReductionTile + 1);
			WaitStage(ReductionTile + 1);
		}

		if (ReductionTile + FProfile::stage_count < FProfile::reduction_steps)
			StageInput(ReductionTile + FProfile::stage_count, s_StageIndex);
	}

	// Preserve the native clamped Half polynomial and all its rounding points.
	#pragma unroll
	for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
		#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
			#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
				r_Accumulator.word[r_MTile][r_NTile][r_Word] =
					flashlight::packed_bits(dlssnr::ops::ffn_activation(
						flashlight::PackedHalf2{r_Accumulator.word[r_MTile][r_NTile][r_Word]}));

	// Publish each valid 16-token group directly into the next layer's physical
	// tensor layout. Word order is the recovered four-Half2 vector order.
	#pragma unroll
	for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
	{
		const uint32_t g_TokenGroup = g_FirstTokenGroup + (Warp / 2) * 4 + r_MTile;
		if (g_TokenGroup >= g_GroupCount)
			continue;
		const uint64_t g_Output = Parameters.g_Output +
								  uint64_t(g_TokenGroup) * 65536 * FProfile::element_bytes +
								  g_OutputBlock * 2048 * FProfile::element_bytes +
								  (Warp & 1) * 1024 * FProfile::element_bytes + Lane * 16;
		#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
		{
			const auto& r_OutputWords = r_Accumulator.word[r_MTile][r_NTile];
			const uint4 r_OutputVector =
				make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
			flashlight::memory::store_no_allocate(flashlight::memory::GlobalAddress(g_Output + r_NTile * 512),
												  r_OutputVector);
		}
	}
#endif
}
