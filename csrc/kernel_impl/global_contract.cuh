#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// Native global projections share M128 x N128 tiles and four resident K splits.
// The profiles retain each operation's input width, K fragments, and pipeline.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using FGlobalContractAccumulator = FMmaAccumulatorTile<4, 4>;

template <bool bFp8, bool bAttentionProjection = false> struct FGlobalContractProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int InputChannels = bAttentionProjection ? 1024 : 4096;
	static constexpr int SplitChannels = InputChannels / 4;
	static constexpr int ReductionStep = bFp8 && !bAttentionProjection ? 64 : 32;
	static constexpr int ReductionSubtiles = ReductionStep / (bFp8 ? 32 : 16);
	static constexpr int ReductionTiles = SplitChannels / ReductionStep;
	static constexpr int MatrixBytes = InputChannels * 1024 * ElementBytes;
	static constexpr int s_GroupBytes = ReductionStep * 16 * ElementBytes;
	static constexpr int s_CopyBytes = bAttentionProjection ? 512 : s_GroupBytes;
	static constexpr int s_ProducersPerGroup = s_GroupBytes / s_CopyBytes;
	static constexpr int s_CopiesPerWarp = 2 * s_ProducersPerGroup;
	static constexpr int s_StageCount = bFp8 || bAttentionProjection ? 2 : 3;
	static constexpr int s_InitialStages = s_StageCount == 3 ? 3 : 1;
	static constexpr int s_StageBytes = 8 * s_GroupBytes;
	static constexpr int s_BarrierOffset = s_StageCount * s_StageBytes;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

struct FGlobalContractTileCoordinates
{
	int g_TokenGroupBase, g_OutputChannel, g_PaddedGroups, g_ChannelBlock;
	int Lane, Warp, Split;
	bool bBroadcastInput;
};

template <typename Profile>
__device__ __forceinline__ void
LoadGlobalContractWeights(uint4 (&r_Weights)[Profile::ReductionSubtiles][4], uint64_t g_PackedWeights,
						  int ReductionTile, const FGlobalContractTileCoordinates& TileCoordinates)
{
	const uint64_t g_WeightTileBase =
		g_PackedWeights +
		uint64_t(TileCoordinates.Split * Profile::SplitChannels + ReductionTile * Profile::ReductionStep) *
			1024 * Profile::ElementBytes +
		TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			r_Weights[r_KSubtile][r_ChannelGroup] = __ldca(
				reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 32768 + r_ChannelGroup * 512));
}

template <typename Profile>
__device__ __forceinline__ void
IssueGlobalContractInputStage(unsigned char* s_Storage, uint64_t g_Input, int ReductionTile,
							  const FGlobalContractTileCoordinates& TileCoordinates)
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
					g_Input +
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
}

template <typename Profile>
__device__ __forceinline__ void WaitGlobalContractInputStage(unsigned char* s_Storage, int ReductionTile)
{
	const int s_Barrier = Profile::s_BarrierOffset + (ReductionTile % Profile::s_StageCount) * 8;
	ArriveAndWait(s_Storage, s_Barrier);
}

// Consume a register tile from the ready shared-memory stage. ChannelGroups
// distinguishes the N128 projection from the N192 fused Q/K/V projection.
template <typename Profile, int ChannelGroups>
__device__ __forceinline__ void
ConsumeGlobalContractInputStage(FMmaAccumulatorTile<4, ChannelGroups>& r_Accumulator,
								const uint4 (&r_Weights)[Profile::ReductionSubtiles][ChannelGroups],
								unsigned char* s_Storage, int ReductionTile,
								const FGlobalContractTileCoordinates& TileCoordinates)
{
	const int s_Base = (ReductionTile % Profile::s_StageCount) * Profile::s_StageBytes +
					   (TileCoordinates.Warp >> 1) * 4 * Profile::s_GroupBytes + TileCoordinates.Lane * 16;
	uint4 r_Input[4][Profile::ReductionSubtiles];
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
			r_Input[r_Spatial][r_KSubtile] = *reinterpret_cast<const uint4*>(
				s_Storage + s_Base + r_Spatial * Profile::s_GroupBytes + r_KSubtile * 512);
	AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
}

template <bool bFp8, typename TParameters, typename Profile>
__device__ __forceinline__ void
InitializeGlobalContractResidual(FGlobalContractAccumulator& r_Accumulator, const TParameters& Parameters,
								 const FGlobalContractTileCoordinates& TileCoordinates)
{
	if (TileCoordinates.Split != 0)
		return;

	// The record appends 1024 Half scales to the matrix. Lane's two adjacent
	// channels share a packed scale; words 0/1 and 2/3 belong to separate N8s.
	uint32_t r_ResidualScales[4][2];
#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_ResidualScales[r_ChannelGroup][r_N8] =
				*reinterpret_cast<const uint32_t*>(Parameters.g_PackedWeights + Profile::MatrixBytes +
												   (TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 +
													r_N8 * 8 + (TileCoordinates.Lane & 3) * 2) *
													   2);

#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		const int g_Group = TileCoordinates.bBroadcastInput ? 0
															: TileCoordinates.g_TokenGroupBase +
																  (TileCoordinates.Warp >> 1) * 4 + r_Spatial;
		const uint64_t g_ResidualTileBase =
			Parameters.g_Residual +
			uint64_t(g_Group * 1024 + TileCoordinates.g_OutputChannel) * 16 * Profile::ElementBytes +
			TileCoordinates.Lane * 16;
		if constexpr (bFp8)
		{
#pragma unroll
			for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
			{
				const uint4 r_PackedResidual =
					g_Group < TileCoordinates.g_PaddedGroups
						? __ldcg(reinterpret_cast<const uint4*>(g_ResidualTileBase + r_ChannelPair * 512))
						: make_uint4(0, 0, 0, 0);
				const uint32_t r_PackedResidualWords[4] = {r_PackedResidual.x, r_PackedResidual.y,
														   r_PackedResidual.z, r_PackedResidual.w};
#pragma unroll
				for (int r_InPair = 0; r_InPair < 2; ++r_InPair)
				{
					const int r_ChannelGroup = r_ChannelPair * 2 + r_InPair;
					auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
					r_AccumulatorWords[0] = HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_InPair * 2])),
													r_ResidualScales[r_ChannelGroup][0]);
					r_AccumulatorWords[1] =
						HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_InPair * 2 + 1])),
								r_ResidualScales[r_ChannelGroup][0]);
					r_AccumulatorWords[2] =
						HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_InPair * 2] >> 16)),
								r_ResidualScales[r_ChannelGroup][1]);
					r_AccumulatorWords[3] =
						HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_InPair * 2 + 1] >> 16)),
								r_ResidualScales[r_ChannelGroup][1]);
				}
			}
		}
		else
		{
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			{
				const uint4 r_PackedResidual =
					g_Group < TileCoordinates.g_PaddedGroups
						? __ldcg(reinterpret_cast<const uint4*>(g_ResidualTileBase + r_ChannelGroup * 512))
						: make_uint4(0, 0, 0, 0);
				auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
				r_AccumulatorWords[0] = HalfMul(r_PackedResidual.x, r_ResidualScales[r_ChannelGroup][0]);
				r_AccumulatorWords[1] = HalfMul(r_PackedResidual.y, r_ResidualScales[r_ChannelGroup][0]);
				r_AccumulatorWords[2] = HalfMul(r_PackedResidual.z, r_ResidualScales[r_ChannelGroup][1]);
				r_AccumulatorWords[3] = HalfMul(r_PackedResidual.w, r_ResidualScales[r_ChannelGroup][1]);
			}
		}
	}
}

enum class EGlobalContractSplitPublication
{
	Runtime,
	First,
	Intermediate,
	Final
};

template <bool bFp8, EGlobalContractSplitPublication Publication, typename TParameters>
__device__ __forceinline__ void
PublishGlobalContractFragments(FGlobalContractAccumulator& r_Accumulator, const TParameters& Parameters,
							   const FGlobalContractTileCoordinates& TileCoordinates)
{
	const bool bFirstSplit = Publication == EGlobalContractSplitPublication::Runtime
								 ? TileCoordinates.Split == 0
								 : Publication == EGlobalContractSplitPublication::First;
	const bool bIntermediateSplit = Publication == EGlobalContractSplitPublication::Runtime
										? TileCoordinates.Split < 3
										: Publication == EGlobalContractSplitPublication::Intermediate;

	// Serial publication preserves the DLL's Half rounding between K splits.
	// FP8 keeps partial sums in a separate Half buffer until the fourth split.
	const uint64_t g_PartialSums = bFp8 ? Parameters.g_SplitAccumulator : Parameters.g_Output;
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		const int g_Group = TileCoordinates.g_TokenGroupBase + (TileCoordinates.Warp >> 1) * 4 + r_Spatial;
		if (g_Group < TileCoordinates.g_PaddedGroups)
		{
			const uint64_t g_HalfBase = g_PartialSums +
										uint64_t(g_Group * 1024 + TileCoordinates.g_OutputChannel) * 32 +
										TileCoordinates.Lane * 16;
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			{
				auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
				const uint64_t g_PartialSumAddress = g_HalfBase + r_ChannelGroup * 512;
				if (bFirstSplit)
					StoreNoAllocate(g_PartialSumAddress,
									make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
											   r_AccumulatorWords[2], r_AccumulatorWords[3]));
				else if (bIntermediateSplit)
					ReduceHalf4(g_PartialSumAddress,
								make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
										   r_AccumulatorWords[2], r_AccumulatorWords[3]));
				else
				{
					const uint4 r_PreviousSplitWords =
						__ldca(reinterpret_cast<const uint4*>(g_PartialSumAddress));
					r_AccumulatorWords[0] = HalfAdd(r_PreviousSplitWords.x, r_AccumulatorWords[0]);
					r_AccumulatorWords[1] = HalfAdd(r_PreviousSplitWords.y, r_AccumulatorWords[1]);
					r_AccumulatorWords[2] = HalfAdd(r_PreviousSplitWords.z, r_AccumulatorWords[2]);
					r_AccumulatorWords[3] = HalfAdd(r_PreviousSplitWords.w, r_AccumulatorWords[3]);
					if constexpr (!bFp8)
						StoreNoAllocate(g_PartialSumAddress,
										make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
												   r_AccumulatorWords[2], r_AccumulatorWords[3]));
				}
			}
			if constexpr (bFp8)
			{
				const bool bFinalSplit = Publication == EGlobalContractSplitPublication::Runtime
											 ? TileCoordinates.Split == 3
											 : Publication == EGlobalContractSplitPublication::Final;
				if (bFinalSplit)
				{
					const uint64_t g_OutputBase =
						Parameters.g_Output +
						uint64_t(g_Group * 1024 + TileCoordinates.g_OutputChannel) * 16 +
						TileCoordinates.Lane * 16;
#pragma unroll
					for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
					{
						const auto& r_LowerChannelWords =
							r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelPair * 2];
						const auto& r_UpperChannelWords =
							r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelPair * 2 + 1];
						StoreNoAllocate(
							g_OutputBase + r_ChannelPair * 512,
							make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
									   PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
									   PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
									   PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3])));
					}
				}
			}
		}
	}
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void
PublishGlobalContractSplit(FGlobalContractAccumulator& r_Accumulator, const TParameters& Parameters,
						   const FGlobalContractTileCoordinates& TileCoordinates)
{
	const uint64_t g_SplitCounters =
		Parameters.g_SplitCounters + (TileCoordinates.g_TokenGroupBase + TileCoordinates.g_ChannelBlock) * 4;
	if (TileCoordinates.Split > 0)
	{
		if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_SplitCounters)) < TileCoordinates.Split - 1)
				PollSleep(64);
		__syncthreads();
	}

	if constexpr (bFp8)
	{
		// The native epilogue selects first-store, intermediate-reduction or
		// final-pack once. Keep that uniform choice outside fragment loops.
		if (TileCoordinates.Split == 0)
			PublishGlobalContractFragments<true, EGlobalContractSplitPublication::First>(
				r_Accumulator, Parameters, TileCoordinates);
		else if (TileCoordinates.Split < 3)
			PublishGlobalContractFragments<true, EGlobalContractSplitPublication::Intermediate>(
				r_Accumulator, Parameters, TileCoordinates);
		else
			PublishGlobalContractFragments<true, EGlobalContractSplitPublication::Final>(
				r_Accumulator, Parameters, TileCoordinates);
	}
	else
		PublishGlobalContractFragments<false, EGlobalContractSplitPublication::Runtime>(
			r_Accumulator, Parameters, TileCoordinates);
	__syncthreads();
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
		CounterStoreRelease(g_SplitCounters, TileCoordinates.Split);
}

template <bool bFp8, typename TParameters, typename Profile = FGlobalContractProfile<bFp8>>
__device__ __forceinline__ void RunGlobalContract(TParameters Parameters, unsigned char* s_Storage)
{
	const int g_Tokens = Parameters.BatchCount * Parameters.TokensPerBatch;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_ChannelBlock = int(blockIdx.x) / g_TokenTiles;
	const int Warp = threadIdx.y, Lane = threadIdx.x;
	const FGlobalContractTileCoordinates TileCoordinates{(int(blockIdx.x) % g_TokenTiles) * 8,
														 g_ChannelBlock * 128 + (Warp & 1) * 64,
														 bFp8 ? ((g_Tokens + 31) / 32) * 2
															  : (g_Tokens + 15) / 16,
														 g_ChannelBlock,
														 Lane,
														 Warp,
														 int(blockIdx.z),
														 !bFp8 && uint32_t(g_Tokens + 14) < 31};

	if (Lane == 0 && Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < Profile::s_StageCount; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::ReductionSubtiles][4];
	LoadGlobalContractWeights<Profile>(r_Weights, Parameters.g_PackedWeights, 0, TileCoordinates);
#pragma unroll
	for (int s_InitialStage = 0; s_InitialStage < Profile::s_InitialStages; ++s_InitialStage)
		IssueGlobalContractInputStage<Profile>(s_Storage, Parameters.g_Input, s_InitialStage,
											   TileCoordinates);
	WaitGlobalContractInputStage<Profile>(s_Storage, 0);
	FGlobalContractAccumulator r_Accumulator{};
	InitializeGlobalContractResidual<bFp8, TParameters, Profile>(r_Accumulator, Parameters, TileCoordinates);

	// Native two-stage code peels the final MMA tile out of the prefetch loop.
	// Keeping that drain explicit removes a per-iteration tail branch. The
	// three-stage Half contraction retains its distinct refill lifecycle.
#pragma unroll 1
	for (int ReductionTile = 0;
		 ReductionTile < Profile::ReductionTiles - (Profile::s_InitialStages == 1 ? 1 : 0); ++ReductionTile)
	{
		ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, ReductionTile,
												 TileCoordinates);
		if constexpr (Profile::s_InitialStages == 1)
		{
			IssueGlobalContractInputStage<Profile>(s_Storage, Parameters.g_Input, ReductionTile + 1,
												   TileCoordinates);
			LoadGlobalContractWeights<Profile>(r_Weights, Parameters.g_PackedWeights, ReductionTile + 1,
											   TileCoordinates);
			WaitGlobalContractInputStage<Profile>(s_Storage, ReductionTile + 1);
		}
		else
		{
			if (ReductionTile + 1 < Profile::ReductionTiles)
			{
				LoadGlobalContractWeights<Profile>(r_Weights, Parameters.g_PackedWeights, ReductionTile + 1,
												   TileCoordinates);
				WaitGlobalContractInputStage<Profile>(s_Storage, ReductionTile + 1);
			}
			if (ReductionTile + 3 < Profile::ReductionTiles)
				IssueGlobalContractInputStage<Profile>(s_Storage, Parameters.g_Input, ReductionTile + 3,
													   TileCoordinates);
		}
	}
	if constexpr (Profile::s_InitialStages == 1)
		ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage,
												 Profile::ReductionTiles - 1, TileCoordinates);
	PublishGlobalContractSplit<bFp8>(r_Accumulator, Parameters, TileCoordinates);
}
#endif
