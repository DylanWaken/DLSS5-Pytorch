#pragma once
// Channel projection between the window and global stages.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "channel_projection.cuh"

// Entry profiles in this file:
//   channel_projection_c512_to_c1024_fp16

// -----------------------------------------------------------------------------
// channel_projection_c512_to_c1024_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_final_head_512; not historical source.

extern "C" __global__ __maxnreg__(168) void channel_projection_c512_to_c1024_fp16(
	FChannelProjectionC512ToC1024Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunChannelProjection<false>(Parameters);
#endif
}
