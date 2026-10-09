// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "../../shared/common/kernel_helpers.cuh"
#include "../common/global_ffn_expand.cuh"

extern "C" __global__
	__maxnreg__(168) void global_ffn_expand_c1024_fp8(FGlobalFfnExpandC1024Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	using FProfile = FGlobalFfnExpandProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[FProfile::s_BarrierBase + 24];
	const uint32_t Lane = threadIdx.x;
	const uint32_t Warp = threadIdx.y;
	const uint32_t g_TokenCount = Parameters.BatchCount * Parameters.TokensPerBatch;
	const uint32_t g_TokenTileCount = (g_TokenCount + 127) / 128;
	const uint32_t g_OutputBlock = blockIdx.x / g_TokenTileCount;
	const uint32_t g_FirstTokenGroup = (blockIdx.x % g_TokenTileCount) * 8;
	const uint32_t g_GroupCount = ((g_TokenCount + FProfile::TokenAlignment - 1) / FProfile::TokenAlignment) *
								  (FProfile::TokenAlignment / 16);
	const bool bBroadcastSmallHalf = !bFp8 && g_TokenCount <= 16;
	const uint64_t g_Input = Parameters.g_Input + uint64_t(blockIdx.z) * 16384 * FProfile::ElementBytes;
	const uint64_t g_PackedWeights =
		Parameters.g_PackedWeights + uint64_t(blockIdx.z) * (1024 * 4096) * FProfile::ElementBytes;

	// Packed storage groups 16 tokens together. Initial fill and refill copy
	// the same two 1024-byte K slabs; out-of-range groups contribute exact zero.
	const auto StageInput = [&](uint32_t ReductionTile, uint32_t s_StageIndex)
	{
		const uint32_t s_Barrier = FProfile::s_BarrierBase + s_StageIndex * 8;
		#pragma unroll
		for (int CopyGroup = 0; CopyGroup < 2; ++CopyGroup)
		{
			const uint32_t g_TokenGroup = g_FirstTokenGroup + Warp + CopyGroup * 4;
			const uint32_t s_Destination =
				s_StageIndex * FProfile::s_StageBytes + Warp * 1024 + CopyGroup * 4096;
			if (g_TokenGroup < g_GroupCount || bBroadcastSmallHalf)
			{
				const uint32_t g_InputGroup = bBroadcastSmallHalf ? 0 : g_TokenGroup;
				const uint64_t g_Source =
					g_Input + uint64_t(g_InputGroup) * 16384 * FProfile::ElementBytes + ReductionTile * 1024;

				// The original warp election publishes one bulk-copy transaction.
				if (Elected(0xffffffffu))
				{
					CopyBulk(s_Storage, s_Destination, g_Source, 1024, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, 1024);
				}
			}
			else
			{
				*reinterpret_cast<uint4*>(s_Storage + s_Destination + Lane * 16) = make_uint4(0, 0, 0, 0);
				*reinterpret_cast<uint4*>(s_Storage + s_Destination + 512 + Lane * 16) =
					make_uint4(0, 0, 0, 0);
			}
		}
	};

	// Every thread arrives. The mbarrier token retains parity when the
	// three-slot ring wraps; a CTA-wide barrier is not substituted.
	const auto WaitStage = [&](uint32_t s_StageIndex)
	{
		const uint32_t s_Barrier = 24576 + s_StageIndex * 8;
		ArriveAndWait(s_Storage, s_Barrier);
	};

	if ((Lane | Warp) == 0)
	{
		#pragma unroll
		for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
			BarrierInit(s_Storage, FProfile::s_BarrierBase + s_StageIndex * 8, blockDim.x * blockDim.y);
	}

	__syncthreads();

	uint4 r_Weight[2][4];

	// Each uint4 supplies two adjacent N8 fragments. Both precisions retain
	// the original 128-KiB weight-record stride between the two K subtiles.
	const auto LoadWeights = [&](uint32_t ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			g_PackedWeights + g_OutputBlock * 4096 + (threadIdx.y & 1) * 2048 + threadIdx.x * 16;
		#pragma unroll
		for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weight[r_KTile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
					g_WeightTileBase + uint64_t(ReductionTile * 2 + r_KTile) * 131072 + r_NTile * 512));
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
		StageInput(s_StageIndex, s_StageIndex);
	WaitStage(0);

	// One warp accumulates 64 tokens x 64 output channels in Half. Input values
	// are already stored in the native MMA A layout, so no transpose is needed.
	FMmaAccumulatorTile<4, 4> r_Accumulator{};
	#pragma unroll 1
	for (uint32_t ReductionTile = 0; ReductionTile < FProfile::ReductionSteps; ++ReductionTile)
	{
		const uint32_t s_StageIndex = ReductionTile % FProfile::s_StageCount;
		const uint32_t s_WarpInput = s_StageIndex * FProfile::s_StageBytes + (Warp / 2) * 4096 + Lane * 16;
		uint4 r_Input[4][2];
		#pragma unroll
		for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
			#pragma unroll
			for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
				r_Input[r_MTile][r_KTile] =
					*reinterpret_cast<const uint4*>(s_Storage + s_WarpInput + r_MTile * 1024 + r_KTile * 512);
		AccumulateTile<FProfile::Precision>(r_Accumulator, r_Input, r_Weight);

		// Match the native software pipeline: preload B, wait for the next A
		// stage, then recycle the consumed stage for the tile three steps ahead.
		if (ReductionTile + 1 < FProfile::ReductionSteps)
		{
			LoadWeights(ReductionTile + 1);
			WaitStage((ReductionTile + 1) % FProfile::s_StageCount);
		}

		if (ReductionTile + FProfile::s_StageCount < FProfile::ReductionSteps)
			StageInput(ReductionTile + FProfile::s_StageCount, s_StageIndex);
	}

	// Preserve the native clamped Half polynomial and all its rounding points.
	#pragma unroll
	for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
		#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
			#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
				r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile][r_Word] =
					FfnActivation(r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile][r_Word]);

	// Publish each valid 16-token group directly into the next layer's physical
	// tensor layout. FP8 pairs two N16 fragments into one 128-bit vector.
	#pragma unroll
	for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
	{
		const uint32_t g_TokenGroup = g_FirstTokenGroup + (Warp / 2) * 4 + r_MTile;
		if (g_TokenGroup >= g_GroupCount)
			continue;
		const uint64_t g_Output = Parameters.g_Output +
								  uint64_t(g_TokenGroup) * 65536 * FProfile::ElementBytes +
								  g_OutputBlock * 2048 * FProfile::ElementBytes +
								  (Warp & 1) * 1024 * FProfile::ElementBytes + Lane * 16;
		#pragma unroll
		for (int r_NTile = 0; r_NTile < (bFp8 ? 2 : 4); ++r_NTile)
		{
			uint4 r_OutputVector;
			{
				const auto& r_LowerChannelWords = r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile * 2];
				const auto& r_UpperChannelWords = r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile * 2 + 1];
				r_OutputVector = make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
											PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
											PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
											PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3]));
			}
			StoreNoAllocate(g_Output + r_NTile * 512, r_OutputVector);
		}
	}
#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
