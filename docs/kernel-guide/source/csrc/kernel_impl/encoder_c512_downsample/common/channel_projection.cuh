#pragma once
#include "../../shared/common/memoryops.cuh"
#include "../../shared/common/intrinsics.cuh"
#include "../../shared/common/packed_math.cuh"
#include "../../shared/common/tiled_mma.cuh"
#include "../../shared/common/kernel_abi.h"
#include <cuda_runtime.h>

// Native-derived C512 -> C1024 pointwise projection. A CTA owns an 8x8 spatial
// tile and 256 output channels; eight warps each compute 32 tokens x 64 channels.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

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

#endif
