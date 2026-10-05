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

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
{
__global__ __maxnreg__(168) void channel_projection_c512_to_c1024_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	dlssnr::projection::sm120::RunChannelProjection<false>(r_Parameters, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
