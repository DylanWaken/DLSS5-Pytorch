#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// Native global projections share M128 x N128 tiles and four resident K splits.
// The profiles retain each operation's input width, K fragments, and pipeline.
namespace dlssnr::kernels::global_contract
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
using namespace dlssnr::packed_math::sm120;
using FAccumulator = dlssnr::tiles::sm120::FAccumulatorTile<4, 4>;

template <bool bFp8, bool bAttentionProjection = false> struct FProfile
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
	static constexpr auto Precision =
		bFp8 ? dlssnr::mma::sm120::EInputPrecision::Fp8 : dlssnr::mma::sm120::EInputPrecision::Fp16;
};

struct FTileCoordinates
{
	int g_TokenGroupBase, g_OutputChannel, g_PaddedGroups, g_ChannelBlock;
	int r_Lane, r_Warp, r_Split;
	bool bBroadcastInput;
};

template <typename Profile>
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[Profile::ReductionSubtiles][4],
											uint64_t g_Record, int r_ReductionTile,
											const FTileCoordinates& Tile)
{
	const uint64_t g_Base =
		g_Record +
		uint64_t(Tile.r_Split * Profile::SplitChannels + r_ReductionTile * Profile::ReductionStep) * 1024 *
			Profile::ElementBytes +
		Tile.g_OutputChannel * 32 + Tile.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			r_Weights[r_KSubtile][r_ChannelGroup] =
				__ldca(reinterpret_cast<const uint4*>(g_Base + r_KSubtile * 32768 + r_ChannelGroup * 512));
}

template <typename Profile>
__device__ __forceinline__ void IssueInputStage(unsigned char* s_Storage, uint64_t g_Input,
												int r_ReductionTile, const FTileCoordinates& Tile)
{
	const int s_Stage = r_ReductionTile % Profile::s_StageCount;
	const int s_Barrier = Profile::s_BarrierOffset + s_Stage * 8;

	// Contraction coalesces both K fragments in each 16-token group. Half
	// attention projection instead assigns each K fragment to a separate warp.
#pragma unroll
	for (int g_Copy = 0; g_Copy < Profile::s_CopiesPerWarp; ++g_Copy)
	{
		const int g_Group = Tile.bBroadcastInput ? 0
												 : Tile.g_TokenGroupBase + (Tile.r_Warp + g_Copy * 4) /
																			   Profile::s_ProducersPerGroup;
		const int s_Destination =
			s_Stage * Profile::s_StageBytes + (Tile.r_Warp + g_Copy * 4) * Profile::s_CopyBytes;
		if (g_Group < Tile.g_PaddedGroups)
		{
			if (Elected(0xffffffffu))
			{
				const uint64_t g_Source =
					g_Input +
					uint64_t(g_Group * Profile::InputChannels + Tile.r_Split * Profile::SplitChannels +
							 r_ReductionTile * Profile::ReductionStep) *
						16 * Profile::ElementBytes +
					(Tile.r_Warp % Profile::s_ProducersPerGroup) * Profile::s_CopyBytes;
				CopyBulk(s_Storage, s_Destination, g_Source, Profile::s_CopyBytes, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, Profile::s_CopyBytes);
			}
		}
		else
		{
#pragma unroll
			for (int s_Subtile = 0; s_Subtile < Profile::s_CopyBytes / 512; ++s_Subtile)
				*reinterpret_cast<uint4*>(s_Storage + s_Destination + s_Subtile * 512 + Tile.r_Lane * 16) =
					make_uint4(0, 0, 0, 0);
		}
	}
}

template <typename Profile>
__device__ __forceinline__ void WaitInputStage(unsigned char* s_Storage, int r_ReductionTile)
{
	const int s_Barrier = Profile::s_BarrierOffset + (r_ReductionTile % Profile::s_StageCount) * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

// Consume a register tile from the ready shared-memory stage. ChannelGroups
// distinguishes the N128 projection from the N192 fused Q/K/V projection.
template <typename Profile, int ChannelGroups>
__device__ __forceinline__ void
ConsumeInputStage(dlssnr::tiles::sm120::FAccumulatorTile<4, ChannelGroups>& r_Accumulator,
				  const uint4 (&r_Weights)[Profile::ReductionSubtiles][ChannelGroups],
				  unsigned char* s_Storage, int r_ReductionTile, const FTileCoordinates& Tile)
{
	const int s_Base = (r_ReductionTile % Profile::s_StageCount) * Profile::s_StageBytes +
					   (Tile.r_Warp >> 1) * 4 * Profile::s_GroupBytes + Tile.r_Lane * 16;
	uint4 r_Input[4][Profile::ReductionSubtiles];
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
			r_Input[r_Spatial][r_KSubtile] = *reinterpret_cast<const uint4*>(
				s_Storage + s_Base + r_Spatial * Profile::s_GroupBytes + r_KSubtile * 512);
	dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
}

template <bool bFp8, typename TParameters, typename Profile>
__device__ __forceinline__ void InitializeResidual(FAccumulator& r_Accumulator, const TParameters& Parameters,
												   const FTileCoordinates& Tile)
{
	if (Tile.r_Split != 0)
		return;

	// The record appends 1024 Half scales to the matrix. Lane's two adjacent
	// channels share a packed scale; words 0/1 and 2/3 belong to separate N8s.
	uint32_t r_Scale[4][2];
#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_Scale[r_ChannelGroup][r_N8] = *reinterpret_cast<const uint32_t*>(
				Parameters.g_Record + Profile::MatrixBytes +
				(Tile.g_OutputChannel + r_ChannelGroup * 16 + r_N8 * 8 + (Tile.r_Lane & 3) * 2) * 2);

#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		const int g_Group =
			Tile.bBroadcastInput ? 0 : Tile.g_TokenGroupBase + (Tile.r_Warp >> 1) * 4 + r_Spatial;
		const uint64_t g_Base = Parameters.g_Skip +
								uint64_t(g_Group * 1024 + Tile.g_OutputChannel) * 16 * Profile::ElementBytes +
								Tile.r_Lane * 16;
		if constexpr (bFp8)
		{
#pragma unroll
			for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
			{
				const uint4 r_Packed =
					g_Group < Tile.g_PaddedGroups
						? __ldcg(reinterpret_cast<const uint4*>(g_Base + r_ChannelPair * 512))
						: make_uint4(0, 0, 0, 0);
				const uint32_t r_Words[4] = {r_Packed.x, r_Packed.y, r_Packed.z, r_Packed.w};
#pragma unroll
				for (int r_InPair = 0; r_InPair < 2; ++r_InPair)
				{
					const int r_Group = r_ChannelPair * 2 + r_InPair;
					auto& r_C = r_Accumulator.r_Words[r_Spatial][r_Group];
					r_C[0] = HalfMul(DecodeE4(uint16_t(r_Words[r_InPair * 2])), r_Scale[r_Group][0]);
					r_C[1] = HalfMul(DecodeE4(uint16_t(r_Words[r_InPair * 2 + 1])), r_Scale[r_Group][0]);
					r_C[2] = HalfMul(DecodeE4(uint16_t(r_Words[r_InPair * 2] >> 16)), r_Scale[r_Group][1]);
					r_C[3] =
						HalfMul(DecodeE4(uint16_t(r_Words[r_InPair * 2 + 1] >> 16)), r_Scale[r_Group][1]);
				}
			}
		}
		else
		{
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			{
				const uint4 r_Packed =
					g_Group < Tile.g_PaddedGroups
						? __ldcg(reinterpret_cast<const uint4*>(g_Base + r_ChannelGroup * 512))
						: make_uint4(0, 0, 0, 0);
				auto& r_C = r_Accumulator.r_Words[r_Spatial][r_ChannelGroup];
				r_C[0] = HalfMul(r_Packed.x, r_Scale[r_ChannelGroup][0]);
				r_C[1] = HalfMul(r_Packed.y, r_Scale[r_ChannelGroup][0]);
				r_C[2] = HalfMul(r_Packed.z, r_Scale[r_ChannelGroup][1]);
				r_C[3] = HalfMul(r_Packed.w, r_Scale[r_ChannelGroup][1]);
			}
		}
	}
}

enum class ESplitPublication
{
	Runtime,
	First,
	Intermediate,
	Final
};

template <bool bFp8, ESplitPublication Publication, typename TParameters>
__device__ __forceinline__ void PublishFragments(FAccumulator& r_Accumulator, const TParameters& Parameters,
												 const FTileCoordinates& Tile)
{
	const bool r_bFirstSplit = Publication == ESplitPublication::Runtime
								   ? Tile.r_Split == 0
								   : Publication == ESplitPublication::First;
	const bool r_bIntermediateSplit = Publication == ESplitPublication::Runtime
										  ? Tile.r_Split < 3
										  : Publication == ESplitPublication::Intermediate;

	// Serial publication preserves the DLL's Half rounding between K splits.
	// FP8 keeps partial sums in a separate Half buffer until the fourth split.
	const uint64_t g_Partial = bFp8 ? Parameters.g_Scratch : Parameters.g_High;
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		const int g_Group = Tile.g_TokenGroupBase + (Tile.r_Warp >> 1) * 4 + r_Spatial;
		if (g_Group < Tile.g_PaddedGroups)
		{
			const uint64_t g_HalfBase =
				g_Partial + uint64_t(g_Group * 1024 + Tile.g_OutputChannel) * 32 + Tile.r_Lane * 16;
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			{
				auto& r_C = r_Accumulator.r_Words[r_Spatial][r_ChannelGroup];
				const uint64_t g_Address = g_HalfBase + r_ChannelGroup * 512;
				if (r_bFirstSplit)
					StoreNoAllocate(g_Address, make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]));
				else if (r_bIntermediateSplit)
					ReduceHalf4(g_Address, make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]));
				else
				{
					const uint4 r_Previous = __ldca(reinterpret_cast<const uint4*>(g_Address));
					r_C[0] = HalfAdd(r_Previous.x, r_C[0]);
					r_C[1] = HalfAdd(r_Previous.y, r_C[1]);
					r_C[2] = HalfAdd(r_Previous.z, r_C[2]);
					r_C[3] = HalfAdd(r_Previous.w, r_C[3]);
					if constexpr (!bFp8)
						StoreNoAllocate(g_Address, make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]));
				}
			}
			if constexpr (bFp8)
			{
				const bool r_bFinalSplit = Publication == ESplitPublication::Runtime
											   ? Tile.r_Split == 3
											   : Publication == ESplitPublication::Final;
				if (r_bFinalSplit)
				{
					const uint64_t g_OutputBase = Parameters.g_High +
												  uint64_t(g_Group * 1024 + Tile.g_OutputChannel) * 16 +
												  Tile.r_Lane * 16;
#pragma unroll
					for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
					{
						const auto& r_Left = r_Accumulator.r_Words[r_Spatial][r_ChannelPair * 2];
						const auto& r_Right = r_Accumulator.r_Words[r_Spatial][r_ChannelPair * 2 + 1];
						StoreNoAllocate(g_OutputBase + r_ChannelPair * 512,
										make_uint4(PackHalfPairsE4(r_Left[0], r_Left[2]),
												   PackHalfPairsE4(r_Left[1], r_Left[3]),
												   PackHalfPairsE4(r_Right[0], r_Right[2]),
												   PackHalfPairsE4(r_Right[1], r_Right[3])));
					}
				}
			}
		}
	}
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void PublishSplit(FAccumulator& r_Accumulator, const TParameters& Parameters,
											 const FTileCoordinates& Tile)
{
	const uint64_t g_Counter = Parameters.g_Counter + (Tile.g_TokenGroupBase + Tile.g_ChannelBlock) * 4;
	if (Tile.r_Split > 0)
	{
		if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_Counter)) < Tile.r_Split - 1)
				PollSleep(64);
		__syncthreads();
	}

	if constexpr (bFp8)
	{
		// The native epilogue selects first-store, intermediate-reduction or
		// final-pack once. Keep that uniform choice outside fragment loops.
		if (Tile.r_Split == 0)
			PublishFragments<true, ESplitPublication::First>(r_Accumulator, Parameters, Tile);
		else if (Tile.r_Split < 3)
			PublishFragments<true, ESplitPublication::Intermediate>(r_Accumulator, Parameters, Tile);
		else
			PublishFragments<true, ESplitPublication::Final>(r_Accumulator, Parameters, Tile);
	}
	else
		PublishFragments<false, ESplitPublication::Runtime>(r_Accumulator, Parameters, Tile);
	__syncthreads();
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
		CounterStoreRelease(g_Counter, Tile.r_Split);
}

template <bool bFp8, typename TParameters, typename Profile = FProfile<bFp8>>
__device__ __forceinline__ void RunGlobalContract(TParameters Parameters, unsigned char* s_Storage)
{
	const int g_Tokens = Parameters.Batch * Parameters.Tokens;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_ChannelBlock = int(blockIdx.x) / g_TokenTiles;
	const int r_Warp = threadIdx.y, r_Lane = threadIdx.x;
	const FTileCoordinates Tile{(int(blockIdx.x) % g_TokenTiles) * 8,
								g_ChannelBlock * 128 + (r_Warp & 1) * 64,
								bFp8 ? ((g_Tokens + 31) / 32) * 2 : (g_Tokens + 15) / 16,
								g_ChannelBlock,
								r_Lane,
								r_Warp,
								int(blockIdx.z),
								!bFp8 && uint32_t(g_Tokens + 14) < 31};

	if (r_Lane == 0 && r_Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < Profile::s_StageCount; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::ReductionSubtiles][4];
	LoadWeights<Profile>(r_Weights, Parameters.g_Record, 0, Tile);
#pragma unroll
	for (int s_InitialStage = 0; s_InitialStage < Profile::s_InitialStages; ++s_InitialStage)
		IssueInputStage<Profile>(s_Storage, Parameters.g_State, s_InitialStage, Tile);
	WaitInputStage<Profile>(s_Storage, 0);
	FAccumulator r_Accumulator{};
	InitializeResidual<bFp8, TParameters, Profile>(r_Accumulator, Parameters, Tile);

	// Native two-stage code peels the final MMA tile out of the prefetch loop.
	// Keeping that drain explicit removes a per-iteration tail branch. The
	// three-stage Half contraction retains its distinct refill lifecycle.
#pragma unroll 1
	for (int r_ReductionTile = 0;
		 r_ReductionTile < Profile::ReductionTiles - (Profile::s_InitialStages == 1 ? 1 : 0);
		 ++r_ReductionTile)
	{
		ConsumeInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, r_ReductionTile, Tile);
		if constexpr (Profile::s_InitialStages == 1)
		{
			IssueInputStage<Profile>(s_Storage, Parameters.g_State, r_ReductionTile + 1, Tile);
			LoadWeights<Profile>(r_Weights, Parameters.g_Record, r_ReductionTile + 1, Tile);
			WaitInputStage<Profile>(s_Storage, r_ReductionTile + 1);
		}
		else
		{
			if (r_ReductionTile + 1 < Profile::ReductionTiles)
			{
				LoadWeights<Profile>(r_Weights, Parameters.g_Record, r_ReductionTile + 1, Tile);
				WaitInputStage<Profile>(s_Storage, r_ReductionTile + 1);
			}
			if (r_ReductionTile + 3 < Profile::ReductionTiles)
				IssueInputStage<Profile>(s_Storage, Parameters.g_State, r_ReductionTile + 3, Tile);
		}
	}
	if constexpr (Profile::s_InitialStages == 1)
		ConsumeInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, Profile::ReductionTiles - 1, Tile);
	PublishSplit<bFp8>(r_Accumulator, Parameters, Tile);
}
#endif
} // namespace dlssnr::kernels::global_contract
