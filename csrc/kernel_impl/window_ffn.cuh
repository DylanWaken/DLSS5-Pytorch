#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// Fused window FFN: dense 512->512, then eight independent 64->256->64 MLPs.
// Each CTA owns an 8x8 spatial tile and four groups; grid.z selects groups 0-3/4-7.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <bool bFp8, bool bInputView = false> struct FWindowFfnProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int Warps = bFp8 && !bInputView ? 8 : 4;
	static constexpr int SpatialFragments = bFp8 && !bInputView ? 2 : 4;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int SpatialTileBytes = 16 * 512 * ElementBytes;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

struct FWindowFfnTileCoordinates
{
	int g_TilesHigh, g_TilesWide, g_TileY, g_TileX, g_ExpertGroup;
	int Lane, Warp;
};

// MMA output words are already Half A-fragment order. E4 combines two N16
// groups into one K32 fragment and converts at the original quantization boundary.
template <bool bFp8, int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ uint4 LoadWindowFfnInputFragment(
	const FMmaAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator, int r_Spatial, int r_KSubtile)
{
	if constexpr (bFp8)
	{
		const auto& r_LowerChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_KSubtile * 2];
		const auto& r_UpperChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_KSubtile * 2 + 1];
		return make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
						  PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
						  PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
						  PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3]));
	}
	else
	{
		const auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_KSubtile];
		return make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1], r_AccumulatorWords[2],
						  r_AccumulatorWords[3]);
	}
}

// The grouped E4 GEMMs issue one K32 across all M/N tiles before the next K32.
// The dense GEMM and Half grouped GEMMs instead use the common two-K schedule.
template <int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ void
AccumulateWindowFfnSingleFp8(FMmaAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator,
							 const uint4 (&r_Input)[SpatialFragments],
							 const uint4 (&r_Weights)[ChannelGroups])
{
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
		#pragma unroll
		for (int r_NTile = 0; r_NTile < ChannelGroups; ++r_NTile)
		{
			auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_NTile];
			const uint4 r_InputFragment = r_Input[r_Spatial];
			const uint4 r_WeightFragment = r_Weights[r_NTile];
			MMA<EMmaInputPrecision::Fp8>(
				{r_AccumulatorWords[0], r_AccumulatorWords[1]},
				{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
				{r_WeightFragment.x, r_WeightFragment.y}, {r_AccumulatorWords[0], r_AccumulatorWords[1]});
			MMA<EMmaInputPrecision::Fp8>(
				{r_AccumulatorWords[2], r_AccumulatorWords[3]},
				{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
				{r_WeightFragment.z, r_WeightFragment.w}, {r_AccumulatorWords[2], r_AccumulatorWords[3]});
		}
}

#endif
