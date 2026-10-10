#pragma once
#include "../../shared/common/memoryops.cuh"
#include "../../shared/common/kernel_helpers.cuh"
#include "../../shared/common/tiled_mma.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

// The native FFN expands 1024 channels to 4096. Four warps cover a
// 128-token x 128-channel CTA tile, arranged as two row groups by two columns.
// Both precisions stage 8192 bytes per K step: K64 FP8 or K32 Half.
template <bool bFp8> struct FGlobalFfnExpandProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionTile = bFp8 ? 64 : 32;
	static constexpr int ReductionSteps = 1024 / ReductionTile;
	static constexpr int TokenAlignment = bFp8 ? 32 : 16;
	static constexpr uint32_t s_StageBytes = 8192;
	static constexpr uint32_t s_StageCount = 3;
	static constexpr uint32_t s_BarrierBase = s_StageBytes * s_StageCount;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

#endif
