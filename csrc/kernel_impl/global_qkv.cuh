#pragma once
#include "kernel_launcher/kernel_abi.h"
#include "global_contract.cuh"

// Two K512 slices form Q/K/V for two 32-channel heads. Each four-warp CTA
// owns M128 x N192; normalization and V transposition fuse into the final slice.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using FGlobalQkvAccumulator = FMmaAccumulatorTile<4, 6>;
using FGlobalQkvTileCoordinates = FGlobalContractTileCoordinates;

template <bool bFp8> struct FGlobalQkvProfile : FGlobalContractProfile<bFp8, true>
{
	static constexpr int SplitChannels = 512;
	static constexpr int ReductionTiles = 16;
};

template <typename Profile>
__device__ __forceinline__ void LoadGlobalQkvWeights(uint4 (&r_Weights)[Profile::ReductionSubtiles][6],
													 uint64_t g_PackedWeights, int r_ReductionTile,
													 const FGlobalQkvTileCoordinates& r_TileCoordinates)
{
	// The 128-byte header contains one FP32 scale per attention head. The
	// matrix following it interleaves Q32, K32, V32 within each head.
	const uint64_t g_WeightTileBase =
		g_PackedWeights + 128 +
		uint64_t(r_TileCoordinates.r_Split * 512 + r_ReductionTile * 32) * 3072 * Profile::ElementBytes +
		r_TileCoordinates.g_OutputChannel * 32 + r_TileCoordinates.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 6; ++r_ChannelGroup)
			r_Weights[r_KSubtile][r_ChannelGroup] = __ldca(
				reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 98304 + r_ChannelGroup * 512));
}

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

template <bool bFp8, int Component, EGlobalQkvSplitPublication Publication, typename TParameters>
__device__ __forceinline__ void PublishGlobalQkvComponent(FGlobalQkvAccumulator& r_Accumulator,
														  const TParameters& r_Parameters,
														  const FGlobalQkvTileCoordinates& r_TileCoordinates)
{
	using Profile = FGlobalQkvProfile<bFp8>;
	const int g_Head = r_TileCoordinates.g_ChannelBlock * 2 + (r_TileCoordinates.r_Warp & 1);
	const uint64_t g_Output = Component == 0   ? r_Parameters.g_Query
							  : Component == 1 ? r_Parameters.g_Key
											   : r_Parameters.g_Value;
	const uint64_t g_PartialSums = bFp8 ? r_Parameters.g_SplitAccumulator +
											  uint64_t(Component) * r_TileCoordinates.g_PaddedGroups * 32768
										: g_Output;
	const bool r_bFirstSplit = Publication == EGlobalQkvSplitPublication::Runtime
								   ? r_TileCoordinates.r_Split == 0
								   : Publication == EGlobalQkvSplitPublication::First;

	// The first slice stores ordinary Half fragments. The second slice reads
	// and adds them before any normalization or storage-layout conversion.
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		const int g_LogicalGroup =
			r_TileCoordinates.g_TokenGroupBase + (r_TileCoordinates.r_Warp >> 1) * 4 + r_Spatial;
		const int g_ReadGroup = r_TileCoordinates.bBroadcastInput ? 0 : g_LogicalGroup;
#pragma unroll
		for (int r_N16 = 0; r_N16 < 2; ++r_N16)
		{
			auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + r_N16];
			if (r_bFirstSplit)
			{
				if (g_LogicalGroup < r_TileCoordinates.g_PaddedGroups)
					StoreNoAllocate(g_PartialSums + uint64_t(g_LogicalGroup) * 32768 + g_Head * 1024 +
										r_N16 * 512 + r_TileCoordinates.r_Lane * 16,
									make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
											   r_AccumulatorWords[2], r_AccumulatorWords[3]));
			}
			else
			{
				const uint64_t g_PartialAddress = g_PartialSums + uint64_t(g_ReadGroup) * 32768 +
												  g_Head * 1024 + r_N16 * 512 + r_TileCoordinates.r_Lane * 16;
				uint4 r_PreviousSplitWords;
				if constexpr (bFp8)
					r_PreviousSplitWords =
						LoadGlobalCaOrZero(g_PartialAddress, g_ReadGroup < r_TileCoordinates.g_PaddedGroups);
				else
					r_PreviousSplitWords = g_ReadGroup < r_TileCoordinates.g_PaddedGroups
											   ? __ldca(reinterpret_cast<const uint4*>(g_PartialAddress))
											   : make_uint4(0, 0, 0, 0);
				r_AccumulatorWords[0] = HalfAdd(r_PreviousSplitWords.x, r_AccumulatorWords[0]);
				r_AccumulatorWords[1] = HalfAdd(r_PreviousSplitWords.y, r_AccumulatorWords[1]);
				r_AccumulatorWords[2] = HalfAdd(r_PreviousSplitWords.z, r_AccumulatorWords[2]);
				r_AccumulatorWords[3] = HalfAdd(r_PreviousSplitWords.w, r_AccumulatorWords[3]);
			}
		}
	}
	if (r_bFirstSplit)
		return;
	if constexpr (Component < 2)
		NormalizeHead<bFp8, Component>(r_Accumulator, r_Parameters.g_PackedWeights, g_Head);
	else
	{
		// Transpose all V fragments before combining neighboring M16 tiles
		// into the FP8 consumer's M32 storage groups.
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
#pragma unroll
			for (int r_N16 = 0; r_N16 < 2; ++r_N16)
#pragma unroll
				for (int r_Word = 0; r_Word < 4; ++r_Word)
				{
					auto& r_ValueChannelPair = r_Accumulator.r_AccumulatorWords[r_Spatial][4 + r_N16][r_Word];
					r_ValueChannelPair = TransposeM8n8(r_ValueChannelPair);
				}
	}

#pragma unroll
	for (int r_Publish = 0; r_Publish < (!bFp8 && Component == 1 ? 8 : 4); ++r_Publish)
	{
		const int r_Spatial = r_Publish % 4;
		const int g_Group =
			r_TileCoordinates.g_TokenGroupBase + (r_TileCoordinates.r_Warp >> 1) * 4 + r_Spatial;
		if (g_Group < r_TileCoordinates.g_PaddedGroups)
		{
			if constexpr (bFp8 && Component == 2)
			{
				const uint64_t g_OutputFragmentAddress = g_Output + uint64_t(g_Group / 2) * 32768 +
														 g_Head * 1024 + (g_Group & 1) * 512 +
														 r_TileCoordinates.r_Lane * 16;
				const auto& r_EvenTokenGroupWords =
					r_Accumulator.r_AccumulatorWords[(r_Spatial / 2) * 2][4 + (r_Spatial & 1)];
				const auto& r_OddTokenGroupWords =
					r_Accumulator.r_AccumulatorWords[(r_Spatial / 2) * 2 + 1][4 + (r_Spatial & 1)];
				StoreNoAllocate(
					g_OutputFragmentAddress,
					make_uint4(PackHalfPairsE4(r_EvenTokenGroupWords[0], r_EvenTokenGroupWords[1]),
							   PackHalfPairsE4(r_OddTokenGroupWords[0], r_OddTokenGroupWords[1]),
							   PackHalfPairsE4(r_EvenTokenGroupWords[2], r_EvenTokenGroupWords[3]),
							   PackHalfPairsE4(r_OddTokenGroupWords[2], r_OddTokenGroupWords[3])));
			}
			else if constexpr (bFp8)
			{
				const auto& r_LowerChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2];
				const auto& r_UpperChannelWords =
					r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + 1];
				const uint32_t r_HeadWords[4] = {
					PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
					PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
					PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
					PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3])};
				StoreNoAllocate(g_Output + uint64_t(g_Group) * 16384 + g_Head * 512 +
									r_TileCoordinates.r_Lane * 16,
								make_uint4(r_HeadWords[0], r_HeadWords[Component == 1 ? 2 : 1],
										   r_HeadWords[Component == 1 ? 1 : 2], r_HeadWords[3]));
			}
			else
			{
				const uint64_t g_OutputFragmentAddress =
					g_Output + uint64_t(g_Group) * 32768 + g_Head * 1024 + r_TileCoordinates.r_Lane * 16;
				if constexpr (Component == 1)
				{
					// Half K interleaves N8s and publishes all M tiles of N0
					// before N1, retaining the native fragment-store schedule.
					const auto& r_KeyPanelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][2 + r_Publish / 4];
					StoreNoAllocate(g_OutputFragmentAddress + (r_Publish / 4) * 512,
									make_uint4(r_KeyPanelWords[0], r_KeyPanelWords[2], r_KeyPanelWords[1],
											   r_KeyPanelWords[3]));
				}
				else
				{
					const auto& r_LowerChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2];
					const auto& r_UpperChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + 1];
					StoreNoAllocate(g_OutputFragmentAddress,
									make_uint4(r_LowerChannelWords[0], r_LowerChannelWords[1],
											   r_LowerChannelWords[2], r_LowerChannelWords[3]));
					StoreNoAllocate(g_OutputFragmentAddress + 512,
									make_uint4(r_UpperChannelWords[0], r_UpperChannelWords[1],
											   r_UpperChannelWords[2], r_UpperChannelWords[3]));
				}
			}
		}
	}
}

template <bool bFp8, EGlobalQkvSplitPublication Publication, typename TParameters>
__device__ __forceinline__ void PublishGlobalQkv(FGlobalQkvAccumulator& r_Accumulator,
												 const TParameters& r_Parameters,
												 const FGlobalQkvTileCoordinates& r_TileCoordinates)
{
	PublishGlobalQkvComponent<bFp8, 0, Publication>(r_Accumulator, r_Parameters, r_TileCoordinates);
	PublishGlobalQkvComponent<bFp8, 1, Publication>(r_Accumulator, r_Parameters, r_TileCoordinates);
	PublishGlobalQkvComponent<bFp8, 2, Publication>(r_Accumulator, r_Parameters, r_TileCoordinates);
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void RunGlobalQkv(TParameters r_Parameters, unsigned char* s_Storage)
{
	using Profile = FGlobalQkvProfile<bFp8>;
	const int g_Tokens = r_Parameters.BatchCount * r_Parameters.TokensPerBatch;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_HeadPair = int(blockIdx.x) / g_TokenTiles;
	const int r_Lane = threadIdx.x, r_Warp = threadIdx.y;
	const FGlobalQkvTileCoordinates r_TileCoordinates{(int(blockIdx.x) % g_TokenTiles) * 8,
													  g_HeadPair * 192 + (r_Warp & 1) * 96,
													  bFp8 ? ((g_Tokens + 31) / 32) * 2
														   : (g_Tokens + 15) / 16,
													  g_HeadPair,
													  r_Lane,
													  r_Warp,
													  int(blockIdx.z),
													  !bFp8 && uint32_t(g_Tokens + 14) < 31};
	if (r_Lane == 0 && r_Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < 2; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::ReductionSubtiles][6];
	LoadGlobalQkvWeights<Profile>(r_Weights, r_Parameters.g_PackedWeights, 0, r_TileCoordinates);
	IssueGlobalContractInputStage<Profile>(s_Storage, r_Parameters.g_Input, 0, r_TileCoordinates);
	WaitGlobalContractInputStage<Profile>(s_Storage, 0);
	FGlobalQkvAccumulator r_Accumulator{};
#pragma unroll 1
	for (int r_ReductionTile = 0; r_ReductionTile < 15; ++r_ReductionTile)
	{
		ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, r_ReductionTile,
												 r_TileCoordinates);
		IssueGlobalContractInputStage<Profile>(s_Storage, r_Parameters.g_Input, r_ReductionTile + 1,
											   r_TileCoordinates);
		LoadGlobalQkvWeights<Profile>(r_Weights, r_Parameters.g_PackedWeights, r_ReductionTile + 1,
									  r_TileCoordinates);
		WaitGlobalContractInputStage<Profile>(s_Storage, r_ReductionTile + 1);
	}
	// The native loop leaves its last ready tile for an explicit pipeline drain.
	ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, 15, r_TileCoordinates);
	const uint64_t g_SplitCounters =
		r_Parameters.g_SplitCounters + ((r_TileCoordinates.g_TokenGroupBase / 8) * 16 + g_HeadPair) * 4;
	if (r_TileCoordinates.r_Split != 0)
	{
		if (r_Lane == 0 && r_Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_SplitCounters)) < r_TileCoordinates.r_Split - 1)
				PollSleep(64);
		__syncthreads();
	}
	if constexpr (bFp8)
	{
		// Native FP8 selects its first-split stores once before publication.
		// Keep that uniform choice outside all unrolled fragment operations.
		if (r_TileCoordinates.r_Split == 0)
			PublishGlobalQkv<true, EGlobalQkvSplitPublication::First>(r_Accumulator, r_Parameters,
																	  r_TileCoordinates);
		else
			PublishGlobalQkv<true, EGlobalQkvSplitPublication::Final>(r_Accumulator, r_Parameters,
																	  r_TileCoordinates);
	}
	else
		PublishGlobalQkv<false, EGlobalQkvSplitPublication::Runtime>(r_Accumulator, r_Parameters,
																	 r_TileCoordinates);
	__syncthreads();
	if (r_Lane == 0 && r_Warp == 0)
		CounterStoreRelease(g_SplitCounters, r_TileCoordinates.r_Split);
}
#endif
