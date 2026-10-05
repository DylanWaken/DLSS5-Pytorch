#pragma once
// Feed-forward expansion/projection paths for window and global stages.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_ffn.cuh"
#include "spatial_projection.cuh"
#include "global_ffn_expand.cuh"
#include "global_contract.cuh"

// Entry profiles in this file:
//   window_ffn_c512_fp16
//   window_ffn_input_view_c512_fp16
//   window_ffn_projection_c512_fp16
//   window_ffn_projection_input_view_c512_fp16
//   global_ffn_contract_c1024_fp16
//   global_ffn_expand_c1024_fp16

// -----------------------------------------------------------------------------
// window_ffn_c512_fp16
// -----------------------------------------------------------------------------
// Equivalent CUDA C++ reconstruction of the original C512 FFN half entry.
// Original scalar/control spelling retained; this is not the historical C++ source.

extern "C" __global__ __maxnreg__(255) void window_ffn_c512_fp16(FWindowFfnC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunWindowFfn<false>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_ffn_input_view_c512_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_ffwd_inpview_512; not historical source.

extern "C" __global__
	__maxnreg__(255) void window_ffn_input_view_c512_fp16(FWindowFfnInputViewC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunWindowFfn<false, true>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_ffn_projection_c512_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_ffwd_proj_512; not historical source.

extern "C" __global__
	__maxnreg__(128) void window_ffn_projection_c512_fp16(FWindowFfnProjectionC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	RunSpatialProjection<false, 4>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_ffn_projection_input_view_c512_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_ffwd_proj_inpview_512; not historical source.

extern "C" __global__ __maxnreg__(128) void window_ffn_projection_input_view_c512_fp16(
	FWindowFfnProjectionInputViewC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	RunSpatialProjection<false, 4, true, false>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_ffn_contract_c1024_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_vit_1d_ffn_contract; not the historical C++ file.

extern "C" __global__
	__maxnreg__(168) void global_ffn_contract_c1024_fp16(FGlobalFfnContractC1024Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[24600];
	RunGlobalContract<false>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_ffn_expand_c1024_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_vit_1d_ffn_expand; not the historical C++ file.

extern "C" __global__
	__maxnreg__(168) void global_ffn_expand_c1024_fp16(FGlobalFfnExpandC1024Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunGlobalFfnExpand<false>(r_Parameters);
#endif
}
