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
	FInputPreprocessWindowDownsampleC32Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ FSharedFeatures s_Features;
	const FPreprocessParameters& r_Input = r_Parameters;
	RunPreprocess<true, true>(r_Input, s_Features);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c32_downsample_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_ds_fp8. Not recovered historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c32_downsample_fp8(FWindowBlockC32DownsampleFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments r_Arguments = MakeWindowDownsampleArguments<32, true>(r_Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	RunWindow32<true, FWindowDownsampleArguments, FOrdinaryWindowIO, true>(r_Arguments, r_WindowOutput);
	ProjectWindowDownsample32<true>(r_Arguments, PublishWindow32<true>(PoolWindow(r_WindowOutput)));
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_downsample_fp8
// -----------------------------------------------------------------------------
// Reconstructed CUDA C++ from the original C64 down8 entry. NOT the historical source.
// Native scalar names and control edges deliberately retained for auditable first reconstruction.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_downsample_fp8(FWindowBlockC64DownsampleFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments r_Arguments = MakeWindowDownsampleArguments<64, true>(r_Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<64, true> s_Window;
	RunWindowWide<64, true, FTiledWindowIO<64, true>, true>(r_Arguments, s_Window, r_WindowOutput);
	ProjectWindowDownsample<64, true>(r_Arguments, PublishWindow32<true>(PoolWindow(r_WindowOutput)),
									  s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_downsample_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstructed from this exact original C128 entry.

extern "C" __global__ __maxnreg__(168) void window_block_c128_downsample_fp8(
	FWindowBlockC128DownsampleFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments r_Arguments = MakeWindowDownsampleArguments<128, true>(r_Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<128, true> s_Window;
	RunWindowWide<128, true, FTiledWindowIO<128, true>, true>(r_Arguments, s_Window, r_WindowOutput);
	ProjectWindowDownsample<128, true>(r_Arguments, PublishWindow32<true>(PoolWindow(r_WindowOutput)),
									   s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_downsample_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_ds_fp8; not historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c256_downsample_fp8(
	FWindowBlockC256DownsampleFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments r_Arguments = MakeWindowDownsampleArguments<256, true>(r_Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<256, true> s_Window;
	RunWindowWide<256, true, FTiledWindowIO<256, true>, true>(r_Arguments, s_Window, r_WindowOutput);
	ProjectWindowDownsample<256, true>(r_Arguments, PublishWindow32<true>(PoolWindow(r_WindowOutput)),
									   s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_attention_projection_pool_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_pool_512_fp8; not historical source.

extern "C" __global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp8(
	FWindowAttentionProjectionPoolC512Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	const FSpatialProjectionArguments r_Arguments{r_Parameters.g_Input,
												  r_Parameters.g_Residual,
												  r_Parameters.g_Output,
												  r_Parameters.g_PackedWeights,
												  int(r_Parameters.Height),
												  int(r_Parameters.Width),
												  r_Parameters.g_DownsampledOutput,
												  int(r_Parameters.DownsampledHeight),
												  int(r_Parameters.DownsampledWidth)};
	RunSpatialProjection<true, 4, false, false, 2, true>(r_Arguments, s_Storage);
#endif
}
