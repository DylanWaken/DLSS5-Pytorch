#pragma once
#include "intrinsics.cuh"
#include "../../shared/common/kernel_abi.h"
#include "../../bottleneck_c1024_attention_ffn_projection/common/global_contract.cuh"

// Two K512 slices form Q/K/V for two 32-channel heads. Each four-warp CTA
// owns M128 x N192; normalization and V transposition fuse into the final slice.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
using FGlobalQkvAccumulator = FMmaAccumulatorTile<4, 6>;
using FGlobalQkvTileCoordinates = FGlobalContractTileCoordinates;

template <bool bFp8> struct FGlobalQkvProfile : FGlobalContractProfile<bFp8, true>
{
	static constexpr int SplitChannels = 512;
	static constexpr int ReductionTiles = 16;
};

__device__ __forceinline__ uint32_t SumHeadChannels(uint32_t r_Sum)
{
	// Four lane groups cover the 32 head channels. Keep the Half sum order,
	// including the final exchange of the low and high packed Half values.
	r_Sum = HalfAdd(r_Sum, ShuffleBfly(r_Sum, 2, 31, 0xffffffffu));
	r_Sum = HalfAdd(r_Sum, ShuffleBfly(r_Sum, 1, 31, 0xffffffffu));
	return HalfAdd(r_Sum, (r_Sum >> 16) | (r_Sum << 16));
}

template <bool bFp8> __device__ __forceinline__ uint32_t InvertHeadSum(uint32_t r_Sum)
{
	if constexpr (bFp8)
	{
		// SumHeadChannels adds a pair to its swapped pair. After the epsilon
		// max, both Half lanes are identical, including NaN -> epsilon.
		// One conversion/SFU path therefore supplies both normalization lanes.
		const float r_SquaredNorm = __half2float(__ushort_as_half(uint16_t(r_Sum)));
		const uint16_t r_InverseNormHalf = __half_as_ushort(__float2half_rn(ApproxRsqrt(r_SquaredNorm)));
		return JoinHalfwords(r_InverseNormHalf, r_InverseNormHalf);
	}
	else
		return RsqrtHalf2(r_Sum);
}

// Shared arithmetic for the Q and K components: exact packed-Half reduction
// and normalization. Their distinct head-scale rule is a compile-time choice.
template <bool bFp8, int Component>
__device__ __forceinline__ void NormalizeHead(FGlobalQkvAccumulator& r_Accumulator, uint64_t g_PackedWeights,
											  int g_Head)
{
	const uint32_t r_Epsilon = CONST_NORMALIZATION_EPSILON_HALF2;
	const uint32_t r_SqrtHeadDimension =
		FloatToHalf2(FloatSqrtApproxFtzBits(CONST_ATTENTION_HEAD_DIM_FP32_BITS));
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		auto& r_LowerChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2];
		auto& r_UpperChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + 1];
		uint32_t r_SquaredPairs[4];
		#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
			r_SquaredPairs[r_Word] =
				HalfAdd(HalfMul(r_LowerChannelWords[r_Word], r_LowerChannelWords[r_Word]),
						HalfMul(r_UpperChannelWords[r_Word], r_UpperChannelWords[r_Word]));
		const uint32_t r_InverseNorm[2] = {
			InvertHeadSum<bFp8>(
				HalfMax(SumHeadChannels(HalfAdd(r_SquaredPairs[2], r_SquaredPairs[0])), r_Epsilon)),
			InvertHeadSum<bFp8>(
				HalfMax(SumHeadChannels(HalfAdd(r_SquaredPairs[3], r_SquaredPairs[1])), r_Epsilon))};
		#pragma unroll
		for (int r_N16 = 0; r_N16 < 2; ++r_N16)
			#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
			{
				auto& r_HeadChannelPair =
					r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + r_N16][r_Word];
				r_HeadChannelPair = HalfMul(r_HeadChannelPair, r_InverseNorm[r_Word & 1]);
				if constexpr (Component == 0)
				{
					const uint32_t r_HeadScale =
						FloatToHalf2(*reinterpret_cast<const uint32_t*>(g_PackedWeights + g_Head * 4));
					r_HeadChannelPair = HalfMul(HalfMul(r_HeadChannelPair, r_SqrtHeadDimension), r_HeadScale);
				}
			}
	}
}

enum class EGlobalQkvSplitPublication
{
	Runtime,
	First,
	Final
};

#endif
