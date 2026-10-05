#pragma once
#include "mma.cuh"
#include <cuda_runtime.h>

// Native Conv2d1x1 tile: M16 spatial fragments, N16 output groups, and a
// compile-time count of K subtiles. FP8 uses K32; Half uses K16 instructions.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <int SpatialFragments, int ChannelGroups> struct FMmaAccumulatorTile
{
	// Each N16 group contains two N8 MMA fragments, each with two Half2 words.
	uint32_t r_AccumulatorWords[SpatialFragments][ChannelGroups][4];
};

template <EMmaInputPrecision Precision, int SpatialFragments, int ChannelGroups, int ReductionSubtiles>
__device__ __forceinline__ void
AccumulateTile(FMmaAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator,
			   const uint4 (&r_InputFragments)[SpatialFragments][ReductionSubtiles],
			   const uint4 (&r_WeightFragments)[ReductionSubtiles][ChannelGroups])
{

	// Each accumulator consumes K0 before K1, preserving Half rounding. The
	// independent N8 fragments also retain the native instruction issue order.
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
	{
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < ChannelGroups; ++r_ChannelGroup)
		{
			auto& r_OutputFragment = r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < ReductionSubtiles; ++r_KSubtile)
			{
				const uint4 r_InputFragment = r_InputFragments[r_Spatial][r_KSubtile];
				const uint4 r_WeightFragment = r_WeightFragments[r_KSubtile][r_ChannelGroup];
				MultiplyAccumulate<Precision>(
					{r_OutputFragment[0], r_OutputFragment[1]},
					{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
					{r_WeightFragment.x, r_WeightFragment.y}, {r_OutputFragment[0], r_OutputFragment[1]});
				MultiplyAccumulate<Precision>(
					{r_OutputFragment[2], r_OutputFragment[3]},
					{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
					{r_WeightFragment.z, r_WeightFragment.w}, {r_OutputFragment[2], r_OutputFragment[3]});
			}
		}
	}
}
#endif
