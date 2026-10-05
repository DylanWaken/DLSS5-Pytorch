#pragma once
// QKV, attention, and attention projection paths for window and global stages.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "global_attention.cuh"
#include "spatial_projection.cuh"
#include "window_qkv.cuh"
#include "global_contract.cuh"
#include "global_qkv.cuh"

// Entry profiles in this file:
//   window_attention_projection_c512_fp16
//   window_attention_projection_output_view_c512_fp16
//   window_qkv_c512_fp16
//   global_attention_chained_c1024_fp16
//   global_projection_c1024_fp16
//   global_qkv_c1024_fp16

// -----------------------------------------------------------------------------
// window_attention_projection_c512_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_split_swin_16h_proj_512; not historical source.

extern "C" __global__ __maxnreg__(168) void window_attention_projection_c512_fp16(
	FWindowAttentionProjectionC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	RunSpatialProjection<false, 2>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_attention_projection_output_view_c512_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_512_outview; not historical source.

extern "C" __global__ __maxnreg__(128) void window_attention_projection_output_view_c512_fp16(
	FWindowAttentionProjectionOutputViewC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	const FSpatialProjectionArguments r_Arguments{r_Parameters.g_Input,		r_Parameters.g_Residual,
												  r_Parameters.g_Output,	r_Parameters.g_PackedWeights,
												  int(r_Parameters.Height), int(r_Parameters.Width)};
	RunSpatialProjection<false, 4, false, true>(r_Arguments, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_qkv_c512_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_split_swin_16h_qkv_512; not historical source.

extern "C" __global__ __maxnreg__(168) void window_qkv_c512_fp16(FWindowQkvC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[4112];
	RunWindowQkv<false>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_attention_chained_c1024_fp16
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_attention_chained.
// Not historical source; original scalar/control identities are retained for audit.

extern "C" __global__ __maxnreg__(168) void global_attention_chained_c1024_fp16(
	FGlobalAttentionChainedC1024Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[16400];
	RunGlobalAttention<false>(r_Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_projection_c1024_fp16
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_projection.
// Not historical source; original scalar/control identities are retained for audit.

extern "C" __global__
	__maxnreg__(168) void global_projection_c1024_fp16(FGlobalProjectionC1024Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[16400];
	using FProjectionProfile = FGlobalContractProfile<false, true>;
	RunGlobalContract<false, FGlobalProjectionC1024Fp16Parameters, FProjectionProfile>(r_Parameters,
																					   s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_qkv_c1024_fp16
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_qkv.
// Not historical source; original scalar/control identities are retained for audit.

extern "C" __global__ __maxnreg__(255) void global_qkv_c1024_fp16(FGlobalQkvC1024Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[16400];
	RunGlobalQkv<false>(r_Parameters, s_Storage);
#endif
}
