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

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void RunGlobalQkv(TParameters Parameters)
{
	using Profile = FGlobalQkvProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::s_BarrierOffset + Profile::s_StageCount * 8];
	const int g_Tokens = Parameters.BatchCount * Parameters.TokensPerBatch;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_HeadPair = int(blockIdx.x) / g_TokenTiles;
	const int Lane = threadIdx.x, Warp = threadIdx.y;
	const FGlobalQkvTileCoordinates TileCoordinates{(int(blockIdx.x) % g_TokenTiles) * 8,
													g_HeadPair * 192 + (Warp & 1) * 96,
													bFp8 ? ((g_Tokens + 31) / 32) * 2 : (g_Tokens + 15) / 16,
													g_HeadPair,
													Lane,
													Warp,
													int(blockIdx.z),
													!bFp8 && uint32_t(g_Tokens + 14) < 31};
	// Visible K-slice staging preserves the contract/QKV shared physical layout.
	const auto StageInput = [&](int ReductionTile)
	{
		const int s_Stage = ReductionTile % Profile::s_StageCount;
		const int s_Barrier = Profile::s_BarrierOffset + s_Stage * 8;

		// Contraction coalesces both K fragments in each 16-token group. Half
		// attention projection instead assigns each K fragment to a separate warp.
#pragma unroll
		for (int Copy = 0; Copy < Profile::s_CopiesPerWarp; ++Copy)
		{
			const int g_Group = TileCoordinates.bBroadcastInput
									? 0
									: TileCoordinates.g_TokenGroupBase +
										  (TileCoordinates.Warp + Copy * 4) / Profile::s_ProducersPerGroup;
			const int s_Destination =
				s_Stage * Profile::s_StageBytes + (TileCoordinates.Warp + Copy * 4) * Profile::s_CopyBytes;
			if (g_Group < TileCoordinates.g_PaddedGroups)
			{
				if (Elected(0xffffffffu))
				{
					const uint64_t g_Source =
						Parameters.g_Input +
						uint64_t(g_Group * Profile::InputChannels +
								 TileCoordinates.Split * Profile::SplitChannels +
								 ReductionTile * Profile::ReductionStep) *
							16 * Profile::ElementBytes +
						(TileCoordinates.Warp % Profile::s_ProducersPerGroup) * Profile::s_CopyBytes;
					CopyBulk(s_Storage, s_Destination, g_Source, Profile::s_CopyBytes, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, Profile::s_CopyBytes);
				}
			}
			else
			{
#pragma unroll
				for (int s_Subtile = 0; s_Subtile < Profile::s_CopyBytes / 512; ++s_Subtile)
					*reinterpret_cast<uint4*>(s_Storage + s_Destination + s_Subtile * 512 +
											  TileCoordinates.Lane * 16) = make_uint4(0, 0, 0, 0);
			}
		}
	};

	// Wait before consuming each slice or recycling its shared ring slot.
	const auto WaitStage = [&](int ReductionTile)
	{
		const int s_Barrier = Profile::s_BarrierOffset + (ReductionTile % Profile::s_StageCount) * 8;
		ArriveAndWait(s_Storage, s_Barrier);
	};

	if (Lane == 0 && Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < 2; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::ReductionSubtiles][6];
	// Q/K/V weight panels remain adjacent in the native record.
	const auto LoadWeights = [&](int ReductionTile)
	{
		// The 128-byte header contains one FP32 scale per attention head. The
		// matrix following it interleaves Q32, K32, V32 within each head.
		const uint64_t g_WeightTileBase =
			Parameters.g_PackedWeights + 128 +
			uint64_t(TileCoordinates.Split * 512 + ReductionTile * 32) * 3072 * Profile::ElementBytes +
			TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 6; ++r_ChannelGroup)
				r_Weights[r_KSubtile][r_ChannelGroup] = __ldca(reinterpret_cast<const uint4*>(
					g_WeightTileBase + r_KSubtile * 98304 + r_ChannelGroup * 512));
	};
	LoadWeights(0);
	StageInput(0);
	WaitStage(0);
	FGlobalQkvAccumulator r_Accumulator{};
#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < 15; ++ReductionTile)
	{
		ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, ReductionTile,
												 TileCoordinates);
		StageInput(ReductionTile + 1);
		LoadWeights(ReductionTile + 1);
		WaitStage(ReductionTile + 1);
	}
	// The native loop leaves its last ready tile for an explicit pipeline drain.
	ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, 15, TileCoordinates);
	// One local store loop serves Q, K and V with their original compile-time layouts.
	const auto PublishComponent = [&](auto ComponentTag, auto PublicationTag)
	{
		constexpr int Component = decltype(ComponentTag)::value;
		constexpr auto Publication = decltype(PublicationTag)::value;
		const int g_Head = TileCoordinates.g_ChannelBlock * 2 + (TileCoordinates.Warp & 1);
		const uint64_t g_Output = Component == 0   ? Parameters.g_Query
								  : Component == 1 ? Parameters.g_Key
												   : Parameters.g_Value;
		const uint64_t g_PartialSums = bFp8 ? Parameters.g_SplitAccumulator +
												  uint64_t(Component) * TileCoordinates.g_PaddedGroups * 32768
											: g_Output;
		const bool bFirstSplit = Publication == EGlobalQkvSplitPublication::Runtime
									 ? TileCoordinates.Split == 0
									 : Publication == EGlobalQkvSplitPublication::First;

		// The first slice stores ordinary Half fragments. The second slice reads
		// and adds them before any normalization or storage-layout conversion.
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
		{
			const int g_LogicalGroup =
				TileCoordinates.g_TokenGroupBase + (TileCoordinates.Warp >> 1) * 4 + r_Spatial;
			const int g_ReadGroup = TileCoordinates.bBroadcastInput ? 0 : g_LogicalGroup;
#pragma unroll
			for (int r_N16 = 0; r_N16 < 2; ++r_N16)
			{
				auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + r_N16];
				if (bFirstSplit)
				{
					if (g_LogicalGroup < TileCoordinates.g_PaddedGroups)
						StoreNoAllocate(g_PartialSums + uint64_t(g_LogicalGroup) * 32768 + g_Head * 1024 +
											r_N16 * 512 + TileCoordinates.Lane * 16,
										make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
												   r_AccumulatorWords[2], r_AccumulatorWords[3]));
				}
				else
				{
					const uint64_t g_PartialAddress = g_PartialSums + uint64_t(g_ReadGroup) * 32768 +
													  g_Head * 1024 + r_N16 * 512 + TileCoordinates.Lane * 16;
					uint4 r_PreviousSplitWords;
					if constexpr (bFp8)
						r_PreviousSplitWords = LoadGlobalCaOrZero(
							g_PartialAddress, g_ReadGroup < TileCoordinates.g_PaddedGroups);
					else
						r_PreviousSplitWords = g_ReadGroup < TileCoordinates.g_PaddedGroups
												   ? __ldca(reinterpret_cast<const uint4*>(g_PartialAddress))
												   : make_uint4(0, 0, 0, 0);
					r_AccumulatorWords[0] = HalfAdd(r_PreviousSplitWords.x, r_AccumulatorWords[0]);
					r_AccumulatorWords[1] = HalfAdd(r_PreviousSplitWords.y, r_AccumulatorWords[1]);
					r_AccumulatorWords[2] = HalfAdd(r_PreviousSplitWords.z, r_AccumulatorWords[2]);
					r_AccumulatorWords[3] = HalfAdd(r_PreviousSplitWords.w, r_AccumulatorWords[3]);
				}
			}
		}
		if (bFirstSplit)
			return;
		if constexpr (Component < 2)
			NormalizeHead<bFp8, Component>(r_Accumulator, Parameters.g_PackedWeights, g_Head);
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
						auto& r_ValueChannelPair =
							r_Accumulator.r_AccumulatorWords[r_Spatial][4 + r_N16][r_Word];
						r_ValueChannelPair = TransposeM8n8(r_ValueChannelPair);
					}
		}

#pragma unroll
		for (int r_Publish = 0; r_Publish < (!bFp8 && Component == 1 ? 8 : 4); ++r_Publish)
		{
			const int r_Spatial = r_Publish % 4;
			const int g_Group =
				TileCoordinates.g_TokenGroupBase + (TileCoordinates.Warp >> 1) * 4 + r_Spatial;
			if (g_Group < TileCoordinates.g_PaddedGroups)
			{
				if constexpr (bFp8 && Component == 2)
				{
					const uint64_t g_OutputFragmentAddress = g_Output + uint64_t(g_Group / 2) * 32768 +
															 g_Head * 1024 + (g_Group & 1) * 512 +
															 TileCoordinates.Lane * 16;
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
					const auto& r_LowerChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2];
					const auto& r_UpperChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][Component * 2 + 1];
					const uint32_t r_HeadWords[4] = {
						PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
						PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
						PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
						PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3])};
					StoreNoAllocate(g_Output + uint64_t(g_Group) * 16384 + g_Head * 512 +
										TileCoordinates.Lane * 16,
									make_uint4(r_HeadWords[0], r_HeadWords[Component == 1 ? 2 : 1],
											   r_HeadWords[Component == 1 ? 1 : 2], r_HeadWords[3]));
				}
				else
				{
					const uint64_t g_OutputFragmentAddress =
						g_Output + uint64_t(g_Group) * 32768 + g_Head * 1024 + TileCoordinates.Lane * 16;
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
	};
	// Retain Q -> K -> V publication order for every split policy.
	const auto PublishComponents = [&](auto PublicationTag)
	{
		PublishComponent(std::integral_constant<int, 0>{}, PublicationTag);
		PublishComponent(std::integral_constant<int, 1>{}, PublicationTag);
		PublishComponent(std::integral_constant<int, 2>{}, PublicationTag);
	};

	const uint64_t g_SplitCounters =
		Parameters.g_SplitCounters + ((TileCoordinates.g_TokenGroupBase / 8) * 16 + g_HeadPair) * 4;
	if (TileCoordinates.Split != 0)
	{
		if (Lane == 0 && Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_SplitCounters)) < TileCoordinates.Split - 1)
				PollSleep(64);
		__syncthreads();
	}
	if constexpr (bFp8)
	{
		// Native FP8 selects its first-split stores once before publication.
		// Keep that uniform choice outside all unrolled fragment operations.
		if (TileCoordinates.Split == 0)
			PublishComponents(
				std::integral_constant<EGlobalQkvSplitPublication, EGlobalQkvSplitPublication::First>{});
		else
			PublishComponents(
				std::integral_constant<EGlobalQkvSplitPublication, EGlobalQkvSplitPublication::Final>{});
	}
	else
		PublishComponents(
			std::integral_constant<EGlobalQkvSplitPublication, EGlobalQkvSplitPublication::Runtime>{});
	__syncthreads();
	if (Lane == 0 && Warp == 0)
		CounterStoreRelease(g_SplitCounters, TileCoordinates.Split);
}
#endif
