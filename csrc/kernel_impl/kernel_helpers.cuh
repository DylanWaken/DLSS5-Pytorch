#pragma once
#include "../kernel_launcher/kernel_abi.h"
#include "intrinsics.cuh"
#include "memoryops.cuh"
#include "mma.cuh"
#include "packed_math.cuh"
#include <cuda_runtime.h>
#include <cuda_fp16.h>

namespace dlssnr::reconstructed
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
// Renderer records contain little-endian words. Compile-time offsets keep each
// 64-bit resource handle inside the native record without changing its ABI.
template <unsigned Offset, typename TParameters>
__device__ __forceinline__ uint64_t ParameterU64(const TParameters& r_Parameters)
{
	static_assert(Offset % 8 == 0 && Offset + 8 <= sizeof(TParameters));
	return uint64_t(r_Parameters.Words[Offset / 4]) | (uint64_t(r_Parameters.Words[Offset / 4 + 1]) << 32);
}
#endif
} // namespace dlssnr::reconstructed
