#pragma once
#include "../../shared/common/memoryops.cuh"
#include "../../shared/common/kernel_helpers.cuh"
#include "../../shared/common/tiled_mma.cuh"

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

// Shared by the global contraction/projection and QKV entries: consume the same native
// register-tile layout and MMA sequence. Synchronization and stores stay in
// those owning functions. ChannelGroups
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

enum class EGlobalContractSplitPublication
{
	Runtime,
	First,
	Intermediate,
	Final
};

#endif
