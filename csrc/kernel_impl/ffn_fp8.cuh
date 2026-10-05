#pragma once
// Feed-forward expansion/projection paths for window and global stages.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_ffn.cuh"
#include "spatial_projection.cuh"
#include "global_ffn_expand.cuh"
#include "global_contract.cuh"

// Entry profiles in this file:
//   window_ffn_c512_fp8
//   window_ffn_input_view_c512_fp8
//   window_ffn_projection_c512_fp8
//   window_ffn_projection_input_view_c512_fp8
//   global_ffn_contract_c1024_fp8
//   global_ffn_expand_c1024_fp8

// -----------------------------------------------------------------------------
// window_ffn_c512_fp8
// -----------------------------------------------------------------------------
// Equivalent CUDA C++ reconstruction of the original C512 FFN fp8 entry.
// Original scalar/control spelling retained; this is not the historical C++ source.

extern "C" __global__ __maxnreg__(128) void window_ffn_c512_fp8(FWindowFfnC512Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunWindowFfn<true>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_ffn_input_view_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_ffwd_inpview_512_fp8; not historical source.

extern "C" __global__
	__maxnreg__(168) void window_ffn_input_view_c512_fp8(FWindowFfnInputViewC512Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunWindowFfn<true, true>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_ffn_projection_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_ffwd_proj_512_fp8; not historical source.

extern "C" __global__
	__maxnreg__(128) void window_ffn_projection_c512_fp8(FWindowFfnProjectionC512Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	RunSpatialProjection<true, 4>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_ffn_projection_input_view_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_ffwd_proj_inpview_512_fp8; not historical source.

extern "C" __global__ __maxnreg__(128) void window_ffn_projection_input_view_c512_fp8(
	FWindowFfnProjectionInputViewC512Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	RunSpatialProjection<true, 4, true, false>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_ffn_contract_c1024_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_vit_1d_ffn_contract_fp8; not the historical C++ file.

extern "C" __global__
	__maxnreg__(168) void global_ffn_contract_c1024_fp8(FGlobalFfnContractC1024Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[16400];
	RunGlobalContract<true>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_ffn_expand_c1024_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_vit_1d_ffn_expand_fp8; not the historical C++ file.

extern "C" __global__
	__maxnreg__(168) void global_ffn_expand_c1024_fp8(FGlobalFfnExpandC1024Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunGlobalFfnExpand<true>(r_Parameters);
#endif
}
