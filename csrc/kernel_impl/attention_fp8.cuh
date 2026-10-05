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

namespace dlssnr::reconstructed::window_attention_projection_c512_fp8
{
__global__ __maxnreg__(168) void window_attention_projection_c512_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	dlssnr::kernels::spatial_projection::Forward<true, 2>(r_Parameters, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp8

// -----------------------------------------------------------------------------
// window_attention_projection_output_view_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_512_outview_fp8; not historical source.

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8
{
__global__ __maxnreg__(128) void window_attention_projection_output_view_c512_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[12312];
	const dlssnr::kernels::spatial_projection::FArguments r_Arguments{
		r_Parameters.g_Pointer0,  r_Parameters.g_Pointer8,	  r_Parameters.g_Pointer16,
		r_Parameters.g_Pointer24, int(r_Parameters.Scalar32), int(r_Parameters.Scalar36)};
	dlssnr::kernels::spatial_projection::Forward<true, 4, false, true>(r_Arguments, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8

// -----------------------------------------------------------------------------
// window_qkv_c512_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_split_swin_16h_qkv_512_fp8; not historical source.

namespace dlssnr::reconstructed::window_qkv_c512_fp8
{
__global__ __maxnreg__(168) void window_qkv_c512_fp8(Parameters ParameterBlock)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	dlssnr::kernels::window_qkv::Forward<true>(ParameterBlock, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::window_qkv_c512_fp8

// -----------------------------------------------------------------------------
// global_attention_chained_c1024_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_attention_chained_fp8.
// Not historical source; original scalar/control identities are retained for audit.

namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8
{
__global__ __maxnreg__(168) void global_attention_chained_c1024_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	dlssnr::kernels::global_attention::RunGlobalAttention<true>(r_Parameters, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8

// -----------------------------------------------------------------------------
// global_projection_c1024_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_projection_fp8.
// Not historical source; original scalar/control identities are retained for audit.

namespace dlssnr::reconstructed::global_projection_c1024_fp8
{
__global__ __maxnreg__(168) void global_projection_c1024_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	using Profile = dlssnr::kernels::global_contract::FProfile<true, true>;
	dlssnr::kernels::global_contract::RunGlobalContract<true, Parameters, Profile>(r_Parameters, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::global_projection_c1024_fp8

// -----------------------------------------------------------------------------
// global_qkv_c1024_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstruction of cc_vit_1d_qkv_fp8.
// Not historical source; original scalar/control identities are retained for audit.

namespace dlssnr::reconstructed::global_qkv_c1024_fp8
{
__global__ __maxnreg__(168) void global_qkv_c1024_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	dlssnr::kernels::global_qkv::RunGlobalQkv<true>(r_Parameters, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp8
