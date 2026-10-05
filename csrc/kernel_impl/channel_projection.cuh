#pragma once
#include "kernel_impl/memoryops.cuh"
#include "intrinsics.cuh"
#include "packed_math.cuh"
#include "tiled_mma.cuh"
#include "../kernel_launcher/kernel_abi.h"
#include <cuda_runtime.h>

// Native-derived C512 -> C1024 pointwise projection. A CTA owns an 8x8 spatial
// tile and 256 output channels; eight warps each compute 32 tokens x 64 channels.
namespace dlssnr::projection::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <bool Fp8Storage> struct FChannelProjectionProfile
{
	static constexpr int ElementBytes = Fp8Storage ? 1 : 2;
	static constexpr int InputChannels = 512;
	static constexpr int OutputChannels = 1024;
	static constexpr int TileChannels = 256;
	static constexpr int WarpChannels = 64;
	static constexpr int ReductionStep = Fp8Storage ? 64 : 32;
	static constexpr int ReductionSteps = InputChannels / ReductionStep;
	static constexpr int s_StageCount = 3;
	static constexpr int s_StageBytes = 4096;
	static constexpr int s_BarrierOffset = s_StageCount * s_StageBytes;
	static constexpr int s_StorageBytes = s_BarrierOffset + s_StageCount * 8;
	static constexpr auto Precision =
		Fp8Storage ? mma::sm120::EInputPrecision::Fp8 : mma::sm120::EInputPrecision::Fp16;
};

// A stage contains two 4x4 tiles in each spatial direction. Each warp copies
// one contiguous 512-byte K subtile; the consumer warps reuse those bytes.
template <typename TProfile>
__device__ __forceinline__ void StageInput(unsigned char* s_Storage, const unsigned char* g_Input,
										   int s_StageIndex, int g_ReductionStart, int g_TileY, int g_TileX,
										   int g_TilesY, int g_TilesX, int r_Warp, int r_Lane)
{
	const int g_ReadY = g_TilesY == 1 ? 0 : g_TileY;
	const int g_ReadX = g_TilesX == 1 ? 0 : g_TileX;
	const int s_Destination = s_StageIndex * TProfile::s_StageBytes + r_Warp * 512;
	if (g_ReadY < g_TilesY && g_ReadX < g_TilesX)
	{
		if (intrinsics::sm120::Elected(0xffffffffu))
		{
			const int g_TileIndex = g_ReadY * g_TilesX + g_ReadX;
			const int g_Channel = g_ReductionStart + (r_Warp & 1) * (TProfile::ReductionStep / 2);
			const int g_ByteOffset =
				(g_TileIndex * TProfile::InputChannels + g_Channel) * 16 * TProfile::ElementBytes;
			const int s_Barrier = TProfile::s_BarrierOffset + s_StageIndex * 8;
			intrinsics::sm120::CopyBulk(s_Storage, s_Destination,
										reinterpret_cast<uint64_t>(g_Input + g_ByteOffset), 512, s_Barrier);
			intrinsics::sm120::BarrierExpect(s_Storage, s_Barrier, 512);
		}
	}
	else
	{
		// Out-of-domain tiles are zero; a one-tile dimension uses broadcast.
		*reinterpret_cast<uint4*>(s_Storage + s_Destination + r_Lane * 16) = make_uint4(0, 0, 0, 0);
	}
}

template <typename TProfile>
__device__ __forceinline__ void WaitStage(unsigned char* s_Storage, int s_StageIndex)
{
	const int s_Barrier = TProfile::s_BarrierOffset + s_StageIndex * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

template <typename TProfile>
__device__ __forceinline__ void LoadWeights(const unsigned char* g_Weights, int g_ReductionStart,
											int g_OutputChannel, int r_Lane, uint4 (&r_Weight)[2][4])
{
	const int g_Base = g_ReductionStart * TProfile::OutputChannels * TProfile::ElementBytes +
					   g_OutputChannel * 32 + r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
	{
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
		{
			const int g_Offset = g_Base +
								 r_KSubtile * (TProfile::ReductionStep / 2) * TProfile::OutputChannels *
									 TProfile::ElementBytes +
								 r_ChannelGroup * 512;
			r_Weight[r_KSubtile][r_ChannelGroup] =
				__ldca(reinterpret_cast<const uint4*>(g_Weights + g_Offset));
		}
	}
}

template <bool Fp8Storage, typename TParameters>
__device__ __forceinline__ void RunChannelProjection(TParameters r_Parameters, unsigned char* s_Storage)
{
	using FProfile = FChannelProjectionProfile<Fp8Storage>;
	const auto* g_Input = reinterpret_cast<const unsigned char*>(r_Parameters.g_Pointer0);
	auto* g_Output = reinterpret_cast<unsigned char*>(r_Parameters.g_Pointer8);
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(r_Parameters.g_Pointer16);
	const int g_Height = int(r_Parameters.Scalar32), g_Width = int(r_Parameters.Scalar36);
	const int r_Lane = threadIdx.x, r_Warp = threadIdx.y;
	const int g_SpatialTilesX = (g_Width + 7) / 8;
	const int g_OutputChannel =
		(int(blockIdx.x) / g_SpatialTilesX) * FProfile::TileChannels + (r_Warp & 3) * FProfile::WarpChannels;
	const int g_TileX = (int(blockIdx.x) % g_SpatialTilesX) * 2;
	const int g_TileY = int(blockIdx.y) * 2 + (r_Warp >> 2);
	const int g_InputTileX = g_TileX + ((r_Warp >> 1) & 1);
	const int g_ReductionBase = int(blockIdx.z) * FProfile::InputChannels;

	// Native mbarrier arrival counts include every thread, including zero-fill warps.
	if (r_Lane == 0 && r_Warp == 0)
	{
#pragma unroll
		for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
			intrinsics::sm120::BarrierInit(s_Storage, FProfile::s_BarrierOffset + s_StageIndex * 8,
										   blockDim.x * blockDim.y);
	}
	__syncthreads();

	uint4 r_Weight[2][4];
	LoadWeights<FProfile>(g_Weights, g_ReductionBase, g_OutputChannel, r_Lane, r_Weight);
#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < FProfile::s_StageCount; ++s_StageIndex)
		StageInput<FProfile>(s_Storage, g_Input, s_StageIndex,
							 g_ReductionBase + s_StageIndex * FProfile::ReductionStep, g_TileY, g_InputTileX,
							 g_Height / 4, g_Width / 4, r_Warp, r_Lane);
	WaitStage<FProfile>(s_Storage, 0);
	tiles::sm120::FAccumulatorTile<2, 4> r_Accumulator{};

	// Keep the reduction loop rolled as in the DLL. The fragment loops below
	// unroll, so tile coordinates select registers rather than local memory.
#pragma unroll 1
	for (int r_Step = 0; r_Step < FProfile::ReductionSteps; ++r_Step)
	{
		const int s_StageIndex = r_Step % FProfile::s_StageCount;
		const int s_Base = s_StageIndex * FProfile::s_StageBytes + (r_Warp >> 2) * 2048 + r_Lane * 16;
		uint4 r_InputFragment[2][2];
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 2; ++r_Spatial)
		{
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_InputFragment[r_Spatial][r_KSubtile] =
					*reinterpret_cast<const uint4*>(s_Storage + s_Base + r_Spatial * 1024 + r_KSubtile * 512);
		}
		tiles::sm120::AccumulateTile<FProfile::Precision>(r_Accumulator, r_InputFragment, r_Weight);

		// Prefetch weights before waiting for the next input stage. That wait
		// also proves all warps finished reading the stage about to be reused.
		if (r_Step + 1 < FProfile::ReductionSteps)
		{
			LoadWeights<FProfile>(g_Weights, g_ReductionBase + (r_Step + 1) * FProfile::ReductionStep,
								  g_OutputChannel, r_Lane, r_Weight);
			WaitStage<FProfile>(s_Storage, (r_Step + 1) % FProfile::s_StageCount);
		}
		if (r_Step + FProfile::s_StageCount < FProfile::ReductionSteps)
			StageInput<FProfile>(s_Storage, g_Input, s_StageIndex,
								 g_ReductionBase +
									 (r_Step + FProfile::s_StageCount) * FProfile::ReductionStep,
								 g_TileY, g_InputTileX, g_Height / 4, g_Width / 4, r_Warp, r_Lane);
	}

	// Physical output is a sequence of 4x4 spatial blocks. Half stores each
	// N16 fragment directly; FP8 merges adjacent N8 fragments after conversion.
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 2; ++r_Spatial)
	{
		if (g_TileY < g_Height / 4 && g_TileX + r_Spatial < g_Width / 4)
		{
			const int g_TileIndex = g_TileY * (g_Width / 4) + g_TileX + r_Spatial;
			const int g_Base =
				(g_TileIndex * FProfile::OutputChannels + g_OutputChannel) * 16 * FProfile::ElementBytes +
				r_Lane * 16;
			if constexpr (Fp8Storage)
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_Left = r_Accumulator.r_Words[r_Spatial][r_ChannelPair * 2];
					const auto& r_Right = r_Accumulator.r_Words[r_Spatial][r_ChannelPair * 2 + 1];
					const uint4 r_Published =
						make_uint4(packed_math::sm120::PackHalfPairsE4(r_Left[0], r_Left[2]),
								   packed_math::sm120::PackHalfPairsE4(r_Left[1], r_Left[3]),
								   packed_math::sm120::PackHalfPairsE4(r_Right[0], r_Right[2]),
								   packed_math::sm120::PackHalfPairsE4(r_Right[1], r_Right[3]));
					intrinsics::sm120::StoreNoAllocate(
						reinterpret_cast<uint64_t>(g_Output + g_Base + r_ChannelPair * 512), r_Published);
				}
			}
			else
			{
#pragma unroll
				for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				{
					const auto& r_Words = r_Accumulator.r_Words[r_Spatial][r_ChannelGroup];
					intrinsics::sm120::StoreNoAllocate(
						reinterpret_cast<uint64_t>(g_Output + g_Base + r_ChannelGroup * 512),
						make_uint4(r_Words[0], r_Words[1], r_Words[2], r_Words[3]));
				}
			}
		}
	}
}
#endif
} // namespace dlssnr::projection::sm120
