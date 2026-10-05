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
//   window_attention_projection_c512_fp8
//   window_attention_projection_output_view_c512_fp8
//   window_qkv_c512_fp8
//   global_attention_chained_c1024_fp8
//   global_projection_c1024_fp8
//   global_qkv_c1024_fp8

// -----------------------------------------------------------------------------
// window_attention_projection_c512_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_split_swin_16h_proj_512_fp8; not historical source.

extern "C" __global__ __maxnreg__(168) void window_attention_projection_c512_fp8(
	FWindowAttentionProjectionC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	RunSpatialProjection<true, 2>(Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_attention_projection_output_view_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_512_outview_fp8; not historical source.

extern "C" __global__ __maxnreg__(128) void window_attention_projection_output_view_c512_fp8(
	FWindowAttentionProjectionOutputViewC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	const FSpatialProjectionArguments Arguments{Parameters.g_Input,		Parameters.g_Residual,
												Parameters.g_Output,	Parameters.g_PackedWeights,
												int(Parameters.Height), int(Parameters.Width)};
	RunSpatialProjection<true, 4, false, true>(Arguments, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// window_qkv_c512_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_split_swin_16h_qkv_512_fp8; not historical source.

extern "C" __global__ __maxnreg__(168) void window_qkv_c512_fp8(FWindowQkvC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunWindowQkv<true>(Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_attention_chained_c1024_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_attention_chained_fp8.
// Not historical source; original scalar/control identities are retained for audit.

extern "C" __global__ __maxnreg__(168) void global_attention_chained_c1024_fp8(
	FGlobalAttentionChainedC1024Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunGlobalAttention<true>(Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_projection_c1024_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_projection_fp8.
// Not historical source; original scalar/control identities are retained for audit.

extern "C" __global__
	__maxnreg__(168) void global_projection_c1024_fp8(FGlobalProjectionC1024Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	using FProjectionProfile = FGlobalContractProfile<true, true>;
	RunGlobalContract<true, FGlobalProjectionC1024Fp8Parameters, FProjectionProfile>(Parameters, s_Storage);
#endif
}

// -----------------------------------------------------------------------------
// global_qkv_c1024_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_qkv_fp8.
// Not historical source; original scalar/control identities are retained for audit.

extern "C" __global__ __maxnreg__(168) void global_qkv_c1024_fp8(FGlobalQkvC1024Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	RunGlobalQkv<true>(Parameters, s_Storage);
#endif
}
