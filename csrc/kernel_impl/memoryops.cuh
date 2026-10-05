#pragma once
#include "intrinsics.cuh"
#include <cuda_fp16.h>
#include <cstdint>

// Shared asynchronous-copy synchronization used by the tiled pipelines.
namespace dlssnr::memoryops::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// Arrive once at the caller's shared mbarrier and wait for that exact phase.
// The pipeline owns initialization and expected-copy byte counts. This helper
// preserves the original per-thread arrival and tight polling sequence; it does
// not add a CTA barrier, sleep, or another memory-ordering operation.
__device__ __forceinline__ void ArriveAndWait(unsigned char* s_Storage, uint32_t s_BarrierByteOffset)
{
	const uint64_t r_Phase = intrinsics::sm120::BarrierArrive(s_Storage, s_BarrierByteOffset, 1);
	while (!intrinsics::sm120::BarrierReady(s_Storage, s_BarrierByteOffset, r_Phase))
	{
	}
}
#endif
} // namespace dlssnr::memoryops::sm120
