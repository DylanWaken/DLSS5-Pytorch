#pragma once
#include "../../shared/common/memoryops.cuh"
#include "../../shared/common/kernel_helpers.cuh"
#include "../../shared/common/tiled_mma.cuh"

// Decoder connector: split-K4 projection 1024->512, nearest 2x upsample, scaled skip.
// CTA computes one 4x4 low-resolution tile and 256 output channels in two warps.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using FDecoderAccumulator = FMmaAccumulatorTile<1, 8>;

template <bool bFp8> struct FDecoderProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 256 / ReductionStep;
	static constexpr int MatrixBytes = 1024 * 512 * ElementBytes;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

struct FDecoderCoordinates
{
	int g_LowTilesHigh, g_LowTilesWide, g_HighTilesHigh, g_HighTilesWide;
	int g_TileY, g_TileX, g_OutputChannel, GridColumns;
	int Split, Lane, Warp;
};

#endif
