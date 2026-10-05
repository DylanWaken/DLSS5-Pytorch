#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"
#include "warp_window_wide.cuh"

// Split C512 QKV and attention. Four warps each own one 32-channel head;
// grid.z partitions all sixteen heads. The separate projection kernel follows.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using FWindowQkvDenseTile = FMmaAccumulatorTile<4, 6>;

template <bool bFp8> struct FWindowQkvProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionStep = bFp8 ? 64 : 16;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int KSubtiles = bFp8 ? 2 : 1;
	static constexpr int s_StageBytes = bFp8 ? 4096 : 2048;
	static constexpr int s_BarrierBase = 2 * s_StageBytes;
	static constexpr int BiasOffset = 3 * 512 * 512 * ElementBytes;
	static constexpr int HeadScaleOffset = BiasOffset + 16 * 8192;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

struct FWindowQkvCoordinates
{
	int g_TilesHigh, g_TilesWide, g_TileY, g_TileX, g_Head;
	int Lane, Warp;
};

#endif
