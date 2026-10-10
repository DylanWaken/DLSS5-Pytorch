#pragma once
#include "../../shared/common/memoryops.cuh"
#include "../../shared/common/window_pool.cuh"
#include "../../shared/common/kernel_helpers.cuh"
#include "../../shared/common/tiled_mma.cuh"

// C512 residual projection shared by FFN and attention. The native schedules
// differ in warp ownership: FFN uses four warps with four spatial tiles each;
// attention uses eight warps with two tiles each. Both produce 8x8x256 per CTA.
// H/W are divisible by four; the launcher retains each original block shape.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
template <int SpatialTiles> using FSpatialProjectionAccumulator = FMmaAccumulatorTile<SpatialTiles, 4>;

struct FSpatialProjectionArguments
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int Height, Width;
	uint64_t g_DownsampledOutput = 0;
	int DownsampledHeight = 0, DownsampledWidth = 0;
};

template <bool bFp8> struct FSpatialProjectionProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int SpatialTileBytes = 16 * 512 * ElementBytes;
	static constexpr int MatrixBytes = 512 * 512 * ElementBytes;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

struct FSpatialProjectionTileCoordinates
{
	int g_TilesHigh, g_TilesWide;
	int g_TileY, g_TileX;
	int g_OutputChannel;
	int Lane, Warp;
};

// Channel-plane views store 16 bytes per pixel: N16 for FP8, N8 for Half.
// A warp lane owns a channel pair at x=(lane/4)%4 and y=lane/16.
template <bool bFp8>
__device__ __forceinline__ uint64_t
SpatialProjectionPlaneWordAddress(uint64_t g_Base, int g_ChannelPanel, int g_Y, int g_X,
								  const FSpatialProjectionTileCoordinates& TileCoordinates)
{
	return g_Base +
		   ((uint64_t(g_ChannelPanel) * TileCoordinates.g_TilesHigh * 4 + g_Y) * TileCoordinates.g_TilesWide *
				4 +
			g_X) *
			   16 +
		   (TileCoordinates.Lane & 3) * 4;
}

// Native OOB policy broadcasts a singleton 4x4 spatial dimension. Other
// incomplete 8x8 CTA edges read zeros; publication always clips to real tiles.
__device__ __forceinline__ bool
ResolveSpatialProjectionInputTile(int& g_Y, int& g_X,
								  const FSpatialProjectionTileCoordinates& TileCoordinates)
{
	if (TileCoordinates.g_TilesHigh == 1)
		g_Y = 0;
	if (TileCoordinates.g_TilesWide == 1)
		g_X = 0;
	return g_Y < TileCoordinates.g_TilesHigh && g_X < TileCoordinates.g_TilesWide;
}

#endif
