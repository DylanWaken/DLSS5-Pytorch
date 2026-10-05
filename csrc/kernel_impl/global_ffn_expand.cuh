#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "kernel_impl/tiled_mma.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// The native FFN expands 1024 channels to 4096. Four warps cover a
// 128-token x 128-channel CTA tile, arranged as two row groups by two columns.
// Both precisions stage 8192 bytes per K step: K64 FP8 or K32 Half.
template <bool bFp8> struct FGlobalFfnExpandProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionTile = bFp8 ? 64 : 32;
	static constexpr int ReductionSteps = 1024 / ReductionTile;
	static constexpr int TokenAlignment = bFp8 ? 32 : 16;
	static constexpr uint32_t s_StageBytes = 8192;
	static constexpr uint32_t s_StageCount = 3;
	static constexpr uint32_t s_BarrierBase = s_StageBytes * s_StageCount;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

// Packed token storage groups 16 tokens together. Each warp copies a complete
// 1024-byte K slab from two groups; out-of-range groups contribute exact zero.
template <bool bFp8>
__device__ __forceinline__ void StageGlobalFfnInput(unsigned char* s_Storage, uint64_t g_Input,
													uint32_t g_FirstTokenGroup, uint32_t g_GroupCount,
													uint32_t ReductionTile, uint32_t s_StageIndex,
													bool bBroadcastSmallHalf)
{
	using FProfile = FGlobalFfnExpandProfile<bFp8>;
	const uint32_t Warp = threadIdx.y;
	const uint32_t Lane = threadIdx.x;
	const uint32_t s_Barrier = FProfile::s_BarrierBase + s_StageIndex * 8;
#pragma unroll
	for (int CopyGroup = 0; CopyGroup < 2; ++CopyGroup)
	{
		const uint32_t g_TokenGroup = g_FirstTokenGroup + Warp + CopyGroup * 4;
		const uint32_t s_Destination = s_StageIndex * FProfile::s_StageBytes + Warp * 1024 + CopyGroup * 4096;
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
			*reinterpret_cast<uint4*>(s_Storage + s_Destination + 512 + Lane * 16) = make_uint4(0, 0, 0, 0);
		}
	}
}

// All threads arrive once at the selected stage. Its token includes the parity
// needed when the three-slot ring wraps; a CTA-wide barrier is not substituted.
__device__ __forceinline__ void WaitGlobalFfnInput(unsigned char* s_Storage, uint32_t s_StageIndex)
{
	const uint32_t s_Barrier = 24576 + s_StageIndex * 8;
	ArriveAndWait(s_Storage, s_Barrier);
}

// Each uint4 supplies two adjacent N8 B fragments. The two K subtiles use the
// original 128-KiB record stride in both storage precisions.
__device__ __forceinline__ void LoadGlobalFfnExpandWeights(uint4 (&r_Weight)[2][4], uint64_t g_PackedWeights,
														   uint32_t g_OutputBlock, uint32_t ReductionTile)
{
	const uint64_t g_WeightTileBase =
		g_PackedWeights + g_OutputBlock * 4096 + (threadIdx.y & 1) * 2048 + threadIdx.x * 16;
#pragma unroll
	for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
			r_Weight[r_KTile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
				g_WeightTileBase + uint64_t(ReductionTile * 2 + r_KTile) * 131072 + r_NTile * 512));
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void RunGlobalFfnExpand(const TParameters& Parameters)
{
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
	if ((Lane | Warp) == 0)
	{
#pragma unroll
		for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
			BarrierInit(s_Storage, FProfile::s_BarrierBase + s_StageIndex * 8, blockDim.x * blockDim.y);
	}
	__syncthreads();

	uint4 r_Weight[2][4];
	LoadGlobalFfnExpandWeights(r_Weight, g_PackedWeights, g_OutputBlock, 0);
#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
		StageGlobalFfnInput<bFp8>(s_Storage, g_Input, g_FirstTokenGroup, g_GroupCount, s_StageIndex,
								  s_StageIndex, bBroadcastSmallHalf);
	WaitGlobalFfnInput(s_Storage, 0);

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
			LoadGlobalFfnExpandWeights(r_Weight, g_PackedWeights, g_OutputBlock, ReductionTile + 1);
			WaitGlobalFfnInput(s_Storage, (ReductionTile + 1) % FProfile::s_StageCount);
		}
		if (ReductionTile + FProfile::s_StageCount < FProfile::ReductionSteps)
			StageGlobalFfnInput<bFp8>(s_Storage, g_Input, g_FirstTokenGroup, g_GroupCount,
									  ReductionTile + FProfile::s_StageCount, s_StageIndex,
									  bBroadcastSmallHalf);
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
			if constexpr (bFp8)
			{
				const auto& r_LowerChannelWords = r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile * 2];
				const auto& r_UpperChannelWords = r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile * 2 + 1];
				r_OutputVector = make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
											PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
											PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
											PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3]));
			}
			else
			{
				const auto& r_OutputWords = r_Accumulator.r_AccumulatorWords[r_MTile][r_NTile];
				r_OutputVector =
					make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
			}
			StoreNoAllocate(g_Output + r_NTile * 512, r_OutputVector);
		}
	}
}
#endif
