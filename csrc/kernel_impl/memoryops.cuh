#pragma once
#include "intrinsics.cuh"
#include <cuda_fp16.h>
#include <cstdint>

// Conversions between a caller-owned shared allocation, generic addresses and relative offsets.
namespace dlssnr::memoryops::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// Form the original generic shared pointer from the CTA allocation and relative byte offset.
__device__ __forceinline__ uint64_t SharedGeneric(unsigned char* s_SharedStorage, uint64_t s_ByteOffset)
{
	return reinterpret_cast<uint64_t>(s_SharedStorage) + s_ByteOffset;
}

// Recover a byte offset relative to the same shared allocation; do not treat it as a device pointer.
__device__ __forceinline__ uint64_t SharedOffset(unsigned char* s_SharedStorage, uint64_t s_GenericAddress)
{
	return uint64_t(__cvta_generic_to_shared(reinterpret_cast<void*>(s_GenericAddress))) -
		   uint64_t(__cvta_generic_to_shared(s_SharedStorage));
}
#endif
} // namespace dlssnr::memoryops::sm120
