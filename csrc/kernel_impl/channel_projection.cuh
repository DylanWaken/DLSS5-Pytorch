#pragma once
#include "kernel_impl/memoryops.cuh"
#include "intrinsics.cuh"
#include "packed_math.cuh"
#include "tiled_mma.cuh"
#include "../kernel_launcher/kernel_abi.h"
#include <cuda_runtime.h>

// Native-derived C512 -> C1024 pointwise projection. A CTA owns an 8x8 spatial
// tile and 256 output channels; eight warps each compute 32 tokens x 64 channels.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <bool bFp8Storage> struct FChannelProjectionProfile
{
	static constexpr int ElementBytes = bFp8Storage ? 1 : 2;
	static constexpr int InputChannels = 512;
	static constexpr int OutputChannels = 1024;
	static constexpr int TileChannels = 256;
	static constexpr int WarpChannels = 64;
	static constexpr int ReductionStep = bFp8Storage ? 64 : 32;
	static constexpr int ReductionSteps = InputChannels / ReductionStep;
	static constexpr int s_StageCount = 3;
	static constexpr int s_StageBytes = 4096;
	static constexpr int s_BarrierOffset = s_StageCount * s_StageBytes;
	static constexpr int s_StorageBytes = s_BarrierOffset + s_StageCount * 8;
	static constexpr auto Precision = bFp8Storage ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

// A stage contains two 4x4 tiles in each spatial direction. Each warp copies
// one contiguous 512-byte K subtile; the consumer warps reuse those bytes.
template <typename TProfile>
__device__ __forceinline__ void StageChannelProjectionInput(unsigned char* s_Storage,
															const unsigned char* g_Input, int s_StageIndex,
															int g_ReductionStart, int g_TileY, int g_TileX,
															int g_TilesY, int g_TilesX, int Warp, int Lane)
{
	const int g_ReadY = g_TilesY == 1 ? 0 : g_TileY;
	const int g_ReadX = g_TilesX == 1 ? 0 : g_TileX;
	const int s_DestinationByteOffset = s_StageIndex * TProfile::s_StageBytes + Warp * 512;
	if (g_ReadY < g_TilesY && g_ReadX < g_TilesX)
	{
		if (Elected(0xffffffffu))
		{
			const int g_TileIndex = g_ReadY * g_TilesX + g_ReadX;
			const int g_Channel = g_ReductionStart + (Warp & 1) * (TProfile::ReductionStep / 2);
			const int g_ByteOffset =
				(g_TileIndex * TProfile::InputChannels + g_Channel) * 16 * TProfile::ElementBytes;
			const int s_Barrier = TProfile::s_BarrierOffset + s_StageIndex * 8;
			CopyBulk(s_Storage, s_DestinationByteOffset, reinterpret_cast<uint64_t>(g_Input + g_ByteOffset),
					 512, s_Barrier);
			BarrierExpect(s_Storage, s_Barrier, 512);
		}
	}
	else
	{
		// Out-of-domain tiles are zero; a one-tile dimension uses broadcast.
		*reinterpret_cast<uint4*>(s_Storage + s_DestinationByteOffset + Lane * 16) = make_uint4(0, 0, 0, 0);
	}
}

template <typename TProfile>
__device__ __forceinline__ void WaitChannelProjectionStage(unsigned char* s_Storage, int s_StageIndex)
{
	const int s_Barrier = TProfile::s_BarrierOffset + s_StageIndex * 8;
	ArriveAndWait(s_Storage, s_Barrier);
}

template <typename TProfile>
__device__ __forceinline__ void LoadChannelProjectionWeights(const unsigned char* g_Weights,
															 int g_ReductionStart, int g_OutputChannel,
															 int Lane, uint4 (&r_WeightFragments)[2][4])
{
	const int g_WeightTileByteBase = g_ReductionStart * TProfile::OutputChannels * TProfile::ElementBytes +
									 g_OutputChannel * 32 + Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
	{
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
		{
			const int g_WeightByteOffset = g_WeightTileByteBase +
										   r_KSubtile * (TProfile::ReductionStep / 2) *
											   TProfile::OutputChannels * TProfile::ElementBytes +
										   r_ChannelGroup * 512;
			r_WeightFragments[r_KSubtile][r_ChannelGroup] =
				__ldca(reinterpret_cast<const uint4*>(g_Weights + g_WeightByteOffset));
		}
	}
}

template <bool bFp8Storage, typename TParameters>
__device__ __forceinline__ void RunChannelProjection(TParameters Parameters, unsigned char* s_Storage)
{
	using FProfile = FChannelProjectionProfile<bFp8Storage>;
	const auto* g_Input = reinterpret_cast<const unsigned char*>(Parameters.g_Input);
	auto* g_Output = reinterpret_cast<unsigned char*>(Parameters.g_Output);
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights);
	const int g_Height = int(Parameters.Height), g_Width = int(Parameters.Width);
	const int Lane = threadIdx.x, Warp = threadIdx.y;
	const int g_SpatialTilesX = (g_Width + 7) / 8;
	const int g_OutputChannel =
		(int(blockIdx.x) / g_SpatialTilesX) * FProfile::TileChannels + (Warp & 3) * FProfile::WarpChannels;
	const int g_TileX = (int(blockIdx.x) % g_SpatialTilesX) * 2;
	const int g_TileY = int(blockIdx.y) * 2 + (Warp >> 2);
	const int g_InputTileX = g_TileX + ((Warp >> 1) & 1);
	const int g_ReductionChannelBase = int(blockIdx.z) * FProfile::InputChannels;

	// Native mbarrier arrival counts include every thread, including zero-fill warps.
	if (Lane == 0 && Warp == 0)
	{
#pragma unroll
		for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
			BarrierInit(s_Storage, FProfile::s_BarrierOffset + s_StageIndex * 8, blockDim.x * blockDim.y);
	}
	__syncthreads();

	uint4 r_WeightFragments[2][4];
	LoadChannelProjectionWeights<FProfile>(g_Weights, g_ReductionChannelBase, g_OutputChannel, Lane,
										   r_WeightFragments);
#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
		StageChannelProjectionInput<FProfile>(s_Storage, g_Input, s_StageIndex,
											  g_ReductionChannelBase + s_StageIndex * FProfile::ReductionStep,
											  g_TileY, g_InputTileX, g_Height / 4, g_Width / 4, Warp, Lane);
	WaitChannelProjectionStage<FProfile>(s_Storage, 0);
	FMmaAccumulatorTile<2, 4> r_Accumulator{};

	// Keep the reduction loop rolled as in the DLL. The fragment loops below
	// unroll, so tile coordinates select registers rather than local memory.
#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < FProfile::ReductionSteps; ++ReductionTile)
	{
		const int s_StageIndex = ReductionTile % FProfile::s_StageCount;
		const int s_InputStageByteOffset =
			s_StageIndex * FProfile::s_StageBytes + (Warp >> 2) * 2048 + Lane * 16;
		uint4 r_InputFragments[2][2];
#pragma unroll
		for (int r_SpatialTile = 0; r_SpatialTile < 2; ++r_SpatialTile)
		{
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_InputFragments[r_SpatialTile][r_KSubtile] = *reinterpret_cast<const uint4*>(
					s_Storage + s_InputStageByteOffset + r_SpatialTile * 1024 + r_KSubtile * 512);
		}
		AccumulateTile<FProfile::Precision>(r_Accumulator, r_InputFragments, r_WeightFragments);

		// Prefetch weights before waiting for the next input stage. That wait
		// also proves all warps finished reading the stage about to be reused.
		if (ReductionTile + 1 < FProfile::ReductionSteps)
		{
			LoadChannelProjectionWeights<FProfile>(
				g_Weights, g_ReductionChannelBase + (ReductionTile + 1) * FProfile::ReductionStep,
				g_OutputChannel, Lane, r_WeightFragments);
			WaitChannelProjectionStage<FProfile>(s_Storage, (ReductionTile + 1) % FProfile::s_StageCount);
		}
		if (ReductionTile + FProfile::s_StageCount < FProfile::ReductionSteps)
			StageChannelProjectionInput<FProfile>(
				s_Storage, g_Input, s_StageIndex,
				g_ReductionChannelBase + (ReductionTile + FProfile::s_StageCount) * FProfile::ReductionStep,
				g_TileY, g_InputTileX, g_Height / 4, g_Width / 4, Warp, Lane);
	}

	// Physical output is a sequence of 4x4 spatial blocks. Half stores each
	// N16 fragment directly; FP8 merges adjacent N8 fragments after conversion.
#pragma unroll
	for (int r_SpatialTile = 0; r_SpatialTile < 2; ++r_SpatialTile)
	{
		if (g_TileY < g_Height / 4 && g_TileX + r_SpatialTile < g_Width / 4)
		{
			const int g_TileIndex = g_TileY * (g_Width / 4) + g_TileX + r_SpatialTile;
			const int g_OutputTileByteBase =
				(g_TileIndex * FProfile::OutputChannels + g_OutputChannel) * 16 * FProfile::ElementBytes +
				Lane * 16;
			if constexpr (bFp8Storage)
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_Left = r_Accumulator.r_AccumulatorWords[r_SpatialTile][r_ChannelPair * 2];
					const auto& r_Right =
						r_Accumulator.r_AccumulatorWords[r_SpatialTile][r_ChannelPair * 2 + 1];
					const uint4 r_PackedOutputFragment = make_uint4(
						PackHalfPairsE4(r_Left[0], r_Left[2]), PackHalfPairsE4(r_Left[1], r_Left[3]),
						PackHalfPairsE4(r_Right[0], r_Right[2]), PackHalfPairsE4(r_Right[1], r_Right[3]));
					StoreNoAllocate(
						reinterpret_cast<uint64_t>(g_Output + g_OutputTileByteBase + r_ChannelPair * 512),
						r_PackedOutputFragment);
				}
			}
			else
			{
#pragma unroll
				for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				{
					const auto& r_AccumulatorWords =
						r_Accumulator.r_AccumulatorWords[r_SpatialTile][r_ChannelGroup];
					StoreNoAllocate(
						reinterpret_cast<uint64_t>(g_Output + g_OutputTileByteBase + r_ChannelGroup * 512),
						make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1], r_AccumulatorWords[2],
								   r_AccumulatorWords[3]));
				}
			}
		}
	}
}
#endif
