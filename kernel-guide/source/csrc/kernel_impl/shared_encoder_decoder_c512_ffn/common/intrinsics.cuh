#pragma once
#include "../../shared/common/intrinsics.cuh"

// Instruction helpers used by this network stage in both precisions.
// The force-inline bodies and explicit PTX modifiers are preserved.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

// Commit this thread's outstanding cp.async transfers as one group.
__device__ __forceinline__ void CopyCommit()
{
	asm volatile("cp.async.commit_group;" : : : "memory");
}

// Wait for all previously committed cp.async groups of this thread.
__device__ __forceinline__ void CopyWait0()
{
	asm volatile("cp.async.wait_group 0;" : : : "memory");
}

// Issue a cache-all four-byte global-to-shared copy; the caller owns predicates and zero fill.
__device__ __forceinline__ void CopyAsync4(unsigned char* s_SharedStorage, uint32_t s_DestinationOffset,
										   uint64_t g_GlobalSource)
{
	asm volatile("cp.async.ca.shared.global [%0],[%1],4;"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_DestinationOffset)), "l"(g_GlobalSource)
				 : "memory");
}

#endif // SM80+ stage instruction helpers.
