#pragma once
#include "mma.cuh"
#include <cuda_runtime.h>

// Native Conv2d1x1 tile: M16 spatial fragments, N16 output groups, and a
// compile-time count of K subtiles. FP8 uses K32; Half uses K16 instructions.
namespace dlssnr::tiles::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <int SpatialFragments, int ChannelGroups> struct FAccumulatorTile
{
	// Each N16 group contains two N8 MMA fragments, each with two Half2 words.
	uint32_t r_Words[SpatialFragments][ChannelGroups][4];
};

template <mma::sm120::EInputPrecision Precision, int SpatialFragments, int ChannelGroups,
		  int ReductionSubtiles>
__device__ __forceinline__ void
AccumulateTile(FAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator,
			   const uint4 (&r_Input)[SpatialFragments][ReductionSubtiles],
			   const uint4 (&r_Weight)[ReductionSubtiles][ChannelGroups])
{
	using namespace mma::sm120;

	// Each accumulator consumes K0 before K1, preserving Half rounding. The
	// independent N8 fragments also retain the native instruction issue order.
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
	{
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < ChannelGroups; ++r_ChannelGroup)
		{
			auto& r_Output = r_Accumulator.r_Words[r_Spatial][r_ChannelGroup];
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < ReductionSubtiles; ++r_KSubtile)
			{
				const uint4 r_A = r_Input[r_Spatial][r_KSubtile];
				const uint4 r_B = r_Weight[r_KSubtile][r_ChannelGroup];
				MultiplyAccumulate<Precision>({r_Output[0], r_Output[1]}, {r_A.x, r_A.y, r_A.z, r_A.w},
											  {r_B.x, r_B.y}, {r_Output[0], r_Output[1]});
				MultiplyAccumulate<Precision>({r_Output[2], r_Output[3]}, {r_A.x, r_A.y, r_A.z, r_A.w},
											  {r_B.z, r_B.w}, {r_Output[2], r_Output[3]});
			}
		}
	}
}
#endif
} // namespace dlssnr::tiles::sm120
