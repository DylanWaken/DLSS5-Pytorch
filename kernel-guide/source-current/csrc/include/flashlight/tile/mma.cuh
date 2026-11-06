#pragma once
// Typed compile-time tiled accumulation over the canonical MMA primitives.
//
// The tile keeps the recovered scalarized register storage: four words per
// (spatial fragment, channel group) cell, two independent N8 fragments per cell.
// Loop order is spatial, then channel group, then K subtile, and each K subtile
// issues the low N8 fragment before the high N8 fragment. No layout conversion
// or accumulator repacking is introduced.
#include <flashlight/core.cuh>
#include <flashlight/arch/mma.cuh>
#include <cuda_runtime.h>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace tile
{
// Each N16 channel group contains two N8 MMA fragments, each with two packed
// Half2 accumulator words. This is register storage, not a shared allocation.
template <int SpatialFragments, int ChannelGroups> struct TiledMmaAccumulator
{
	static_assert(SpatialFragments > 0, "At least one spatial fragment is required");
	static_assert(ChannelGroups > 0, "At least one channel group is required");

	std::uint32_t word[SpatialFragments][ChannelGroups][4];
};

// Accumulate one tile of input and weight fragments. `input_fragments` holds one
// A fragment (four words) per spatial/K cell; `weight_fragments` holds one N8 B
// operand (two words) per K/group cell in the low/high word pairs of a uint4.
template <InputPrecision Precision, int SpatialFragments, int ChannelGroups, int ReductionSubtiles>
__device__ __forceinline__ void
accumulate_tile(TiledMmaAccumulator<SpatialFragments, ChannelGroups>& accumulator,
				const uint4 (&input_fragments)[SpatialFragments][ReductionSubtiles],
				const uint4 (&weight_fragments)[ReductionSubtiles][ChannelGroups])
{
	static_assert(ReductionSubtiles > 0, "At least one K subtile is required");

	// Each accumulator consumes K0 before K1, preserving Half rounding. The
	// independent N8 fragments also retain the native instruction issue order.
	#pragma unroll
	for (int spatial = 0; spatial < SpatialFragments; ++spatial)
	{
		#pragma unroll
		for (int channel_group = 0; channel_group < ChannelGroups; ++channel_group)
		{
			auto& output_word = accumulator.word[spatial][channel_group];
			#pragma unroll
			for (int reduction_subtile = 0; reduction_subtile < ReductionSubtiles; ++reduction_subtile)
			{
				const uint4 input_fragment = input_fragments[spatial][reduction_subtile];
				const uint4 weight_fragment = weight_fragments[reduction_subtile][channel_group];

				const MmaAFragment<Precision> left{
					{input_fragment.x, input_fragment.y, input_fragment.z, input_fragment.w}};

				MmaAccumulator<AccumulatorPrecision::Half> low_accumulator{{output_word[0], output_word[1]}};
				const MmaBFragment<Precision> low_right{{weight_fragment.x, weight_fragment.y}};
				arch::mma_sync(low_accumulator, left, low_right);
				output_word[0] = low_accumulator.word[0];
				output_word[1] = low_accumulator.word[1];

				MmaAccumulator<AccumulatorPrecision::Half> high_accumulator{{output_word[2], output_word[3]}};
				const MmaBFragment<Precision> high_right{{weight_fragment.z, weight_fragment.w}};
				arch::mma_sync(high_accumulator, left, high_right);
				output_word[2] = high_accumulator.word[0];
				output_word[3] = high_accumulator.word[1];
			}
		}
	}
}

} // namespace tile
} // namespace flashlight
#endif // SM80+
