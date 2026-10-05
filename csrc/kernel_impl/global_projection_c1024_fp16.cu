// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "kernel_helpers.cuh"
#include "global_contract.cuh"

extern "C" __global__
	__maxnreg__(168) void global_projection_c1024_fp16(FGlobalProjectionC1024Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FProjectionProfile = FGlobalContractProfile<false, true>;

	constexpr bool bFp8 = false;
	using Profile = FProjectionProfile;
	__shared__ __align__(512) unsigned char s_Storage[Profile::s_BarrierOffset + Profile::s_StageCount * 8];
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

	// The initial fill and later refills share this exact staged input copy.
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

	// Only a completed stage can feed the register MMA tile.
	const auto WaitStage = [&](int ReductionTile)
	{
		const int s_Barrier = Profile::s_BarrierOffset + (ReductionTile % Profile::s_StageCount) * 8;
		ArriveAndWait(s_Storage, s_Barrier);
	};

	if (Lane == 0 && Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < Profile::s_StageCount; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::ReductionSubtiles][4];
	// Prefetch weights without changing the ring dependency order.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase = Parameters.g_PackedWeights +
										  uint64_t(TileCoordinates.Split * Profile::SplitChannels +
												   ReductionTile * Profile::ReductionStep) *
											  1024 * Profile::ElementBytes +
										  TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				r_Weights[r_KSubtile][r_ChannelGroup] = __ldca(reinterpret_cast<const uint4*>(
					g_WeightTileBase + r_KSubtile * 32768 + r_ChannelGroup * 512));
	};
	LoadWeights(0);
#pragma unroll
	for (int s_InitialStage = 0; s_InitialStage < Profile::s_InitialStages; ++s_InitialStage)
		StageInput(s_InitialStage);
	WaitStage(0);
	FGlobalContractAccumulator r_Accumulator{};
	// Only the first K split seeds the accumulator from the residual.
	if (TileCoordinates.Split == 0)
	{
		// The record appends 1024 Half scales to the matrix. Lane's two adjacent
		// channels share a packed scale; words 0/1 and 2/3 belong to separate N8s.
		uint32_t r_ResidualScales[4][2];
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
			for (int r_N8 = 0; r_N8 < 2; ++r_N8)
				r_ResidualScales[r_ChannelGroup][r_N8] = *reinterpret_cast<const uint32_t*>(
					Parameters.g_PackedWeights + Profile::MatrixBytes +
					(TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 + r_N8 * 8 +
					 (TileCoordinates.Lane & 3) * 2) *
						2);

#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
		{
			const int g_Group =
				TileCoordinates.bBroadcastInput
					? 0
					: TileCoordinates.g_TokenGroupBase + (TileCoordinates.Warp >> 1) * 4 + r_Spatial;
			const uint64_t g_ResidualTileBase =
				Parameters.g_Residual +
				uint64_t(g_Group * 1024 + TileCoordinates.g_OutputChannel) * 16 * Profile::ElementBytes +
				TileCoordinates.Lane * 16;
			{
#pragma unroll
				for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				{
					const uint4 r_PackedResidual = g_Group < TileCoordinates.g_PaddedGroups
													   ? __ldcg(reinterpret_cast<const uint4*>(
															 g_ResidualTileBase + r_ChannelGroup * 512))
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

	// Native two-stage code peels the final MMA tile out of the prefetch loop.
	// Keeping that drain explicit removes a per-iteration tail branch. The
	// three-stage Half contraction retains its distinct refill lifecycle.
#pragma unroll 1
	for (int ReductionTile = 0;
		 ReductionTile < Profile::ReductionTiles - (Profile::s_InitialStages == 1 ? 1 : 0); ++ReductionTile)
	{
		ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, ReductionTile,
												 TileCoordinates);
		{
			StageInput(ReductionTile + 1);
			LoadWeights(ReductionTile + 1);
			WaitStage(ReductionTile + 1);
		}
	}
	ConsumeGlobalContractInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, Profile::ReductionTiles - 1,
											 TileCoordinates);
	// Compile-time split policy keeps the native branch outside all store loops.
	const auto PublishFragments = [&](auto PublicationTag)
	{
		constexpr auto Publication = decltype(PublicationTag)::value;
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
			const int g_Group =
				TileCoordinates.g_TokenGroupBase + (TileCoordinates.Warp >> 1) * 4 + r_Spatial;
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
						StoreNoAllocate(g_PartialSumAddress,
										make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
												   r_AccumulatorWords[2], r_AccumulatorWords[3]));
					}
				}
				{
				}
			}
		}
	};

	const uint64_t g_SplitCounters =
		Parameters.g_SplitCounters + (TileCoordinates.g_TokenGroupBase + TileCoordinates.g_ChannelBlock) * 4;
	if (TileCoordinates.Split > 0)
	{
		if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_SplitCounters)) < TileCoordinates.Split - 1)
				PollSleep(64);
		__syncthreads();
	}

	PublishFragments(
		std::integral_constant<EGlobalContractSplitPublication, EGlobalContractSplitPublication::Runtime>{});
	__syncthreads();
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
		CounterStoreRelease(g_SplitCounters, TileCoordinates.Split);
#endif
}
