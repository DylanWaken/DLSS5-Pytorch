#pragma once
// All fused downsample paths: window blocks, frontend, and C512 pooling.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_preprocess.cuh"
#include "window_downsample.cuh"
#include "spatial_projection.cuh"

// Entry profiles in this file:
//   input_preprocess_window_downsample_c32_fp8
//   window_block_c32_downsample_fp8
//   window_block_c64_downsample_fp8
//   window_block_c128_downsample_fp8
//   window_block_c256_downsample_fp8
//   window_attention_projection_pool_c512_fp8

// -----------------------------------------------------------------------------
// input_preprocess_window_downsample_c32_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_pre_block_swin_1h_32_1_ds_fp8. Not recovered historical source.

extern "C" __global__ __maxnreg__(168) void input_preprocess_window_downsample_c32_fp8(
	FInputPreprocessWindowDownsampleC32Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FPreprocessParameters& InputParameters = Parameters;
	RunPreprocess<true, true>(InputParameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c32_downsample_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_ds_fp8. Not recovered historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c32_downsample_fp8(FWindowBlockC32DownsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowDownsample<32, true>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_downsample_fp8
// -----------------------------------------------------------------------------
// Reconstructed CUDA C++ from the original C64 down8 entry. NOT the historical source.
// Native scalar names and control edges deliberately retained for auditable first reconstruction.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_downsample_fp8(FWindowBlockC64DownsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowDownsample<64, true>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_downsample_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstructed from this exact original C128 entry.

extern "C" __global__
	__maxnreg__(168) void window_block_c128_downsample_fp8(FWindowBlockC128DownsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowDownsample<128, true>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_downsample_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_ds_fp8; not historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c256_downsample_fp8(FWindowBlockC256DownsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowDownsample<256, true>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_attention_projection_pool_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_pool_512_fp8; not historical source.

extern "C" __global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp8(
	FWindowAttentionProjectionPoolC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FSpatialProjectionArguments Arguments{Parameters.g_Input,
												Parameters.g_Residual,
												Parameters.g_Output,
												Parameters.g_PackedWeights,
												int(Parameters.Height),
												int(Parameters.Width),
												Parameters.g_DownsampledOutput,
												int(Parameters.DownsampledHeight),
												int(Parameters.DownsampledWidth)};
	RunSpatialProjection<true, 4, false, false, 2, true>(Arguments);
#endif
}
