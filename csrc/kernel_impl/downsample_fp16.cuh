#pragma once
// All fused downsample paths: window blocks, frontend, and C512 pooling.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_preprocess.cuh"
#include "window_downsample.cuh"
#include "spatial_projection.cuh"

// Entry profiles in this file:
//   input_preprocess_window_downsample_c32_fp16
//   window_block_c32_downsample_fp16
//   window_block_c64_downsample_fp16
//   window_block_c128_downsample_fp16
//   window_block_c256_downsample_fp16
//   window_attention_projection_pool_c512_fp16

// -----------------------------------------------------------------------------
// input_preprocess_window_downsample_c32_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_pre_block_swin_1h_32_1_ds. Not recovered historical source.

extern "C" __global__ __maxnreg__(168) void input_preprocess_window_downsample_c32_fp16(
	FInputPreprocessWindowDownsampleC32Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ FSharedFeatures s_Features;
	const FPreprocessParameters& InputParameters = Parameters;
	RunPreprocess<false, true>(InputParameters, s_Features);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c32_downsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_ds. Not recovered historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c32_downsample_fp16(FWindowBlockC32DownsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments Arguments = MakeWindowDownsampleArguments<32, false>(Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	RunWindow32<false, FWindowDownsampleArguments, FOrdinaryWindowIO, true>(Arguments, r_WindowOutput);
	ProjectWindowDownsample32<false>(Arguments, PublishWindow32<false>(PoolWindow(r_WindowOutput)));
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_downsample_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_ds. Not the historical C++ source.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_downsample_fp16(FWindowBlockC64DownsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments Arguments = MakeWindowDownsampleArguments<64, false>(Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<64, false> s_Window;
	RunWindowWide<64, false, FTiledWindowIO<64, false>, true>(Arguments, s_Window, r_WindowOutput);
	ProjectWindowDownsample<64, false>(Arguments, PublishWindow32<false>(PoolWindow(r_WindowOutput)),
									   s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_downsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_4h_128_4_ds. Not historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c128_downsample_fp16(
	FWindowBlockC128DownsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments Arguments = MakeWindowDownsampleArguments<128, false>(Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<128, false> s_Window;
	RunWindowWide<128, false, FTiledWindowIO<128, false>, true>(Arguments, s_Window, r_WindowOutput);
	ProjectWindowDownsample<128, false>(Arguments, PublishWindow32<false>(PoolWindow(r_WindowOutput)),
										s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_downsample_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_ds; not historical source.

extern "C" __global__ __maxnreg__(192) void window_block_c256_downsample_fp16(
	FWindowBlockC256DownsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FWindowDownsampleArguments Arguments = MakeWindowDownsampleArguments<256, false>(Parameters);
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<256, false> s_Window;
	RunWindowWide<256, false, FTiledWindowIO<256, false>, true>(Arguments, s_Window, r_WindowOutput);
	ProjectWindowDownsample<256, false>(Arguments, PublishWindow32<false>(PoolWindow(r_WindowOutput)),
										s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_attention_projection_pool_c512_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_pool_512; not historical source.

extern "C" __global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp16(
	FWindowAttentionProjectionPoolC512Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	const FSpatialProjectionArguments Arguments{Parameters.g_Input,
												Parameters.g_Residual,
												Parameters.g_Output,
												Parameters.g_PackedWeights,
												int(Parameters.Height),
												int(Parameters.Width),
												Parameters.g_DownsampledOutput,
												int(Parameters.DownsampledHeight),
												int(Parameters.DownsampledWidth)};
	RunSpatialProjection<false, 4, false, false, 2, true>(Arguments, s_Storage);
#endif
}
