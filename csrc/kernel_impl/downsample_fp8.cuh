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

namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp8
{
__global__ __maxnreg__(168) void input_preprocess_window_downsample_c32_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ dlssnr::kernels::input_features::FSharedFeatures s_Features;
	const dlssnr::kernels::input_features::FParameters& r_Input = r_Parameters;
	dlssnr::kernels::window_preprocess::RunPreprocess<true, true>(r_Input, s_Features);
#endif
}
} // namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp8

// -----------------------------------------------------------------------------
// window_block_c32_downsample_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_ds_fp8. Not recovered historical source.

namespace dlssnr::reconstructed::window_block_c32_downsample_fp8
{
__global__ __maxnreg__(168) void window_block_c32_downsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<32, true>(r_Parameters);
	FAccumulatorTile<32> r_WindowOutput[4];
	RunWindow32<true, FArguments, FOrdinaryIO, true>(r_Arguments, r_WindowOutput);
	ProjectDown32<true>(r_Arguments, Publish<true>(dlssnr::kernels::window_pool::PoolWindow(r_WindowOutput)));
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp8

// -----------------------------------------------------------------------------
// window_block_c64_downsample_fp8
// -----------------------------------------------------------------------------
// Reconstructed CUDA C++ from the original C64 down8 entry. NOT the historical source.
// Native scalar names and control edges deliberately retained for auditable first reconstruction.

namespace dlssnr::reconstructed::window_block_c64_downsample_fp8
{
__global__ __maxnreg__(168) void window_block_c64_downsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<64, true>(r_Parameters);
	FAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<64, true> s_Window;
	RunWindowWide<64, true, FTiledIO<64, true>, true>(r_Arguments, s_Window, r_WindowOutput);
	ProjectDown<64, true>(r_Arguments,
						  Publish<true>(dlssnr::kernels::window_pool::PoolWindow(r_WindowOutput)), s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp8

// -----------------------------------------------------------------------------
// window_block_c128_downsample_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstructed from this exact original C128 entry.

namespace dlssnr::reconstructed::window_block_c128_downsample_fp8
{
__global__ __maxnreg__(168) void window_block_c128_downsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<128, true>(r_Parameters);
	FAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<128, true> s_Window;
	RunWindowWide<128, true, FTiledIO<128, true>, true>(r_Arguments, s_Window, r_WindowOutput);
	ProjectDown<128, true>(r_Arguments,
						   Publish<true>(dlssnr::kernels::window_pool::PoolWindow(r_WindowOutput)), s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp8

// -----------------------------------------------------------------------------
// window_block_c256_downsample_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_ds_fp8; not historical source.

namespace dlssnr::reconstructed::window_block_c256_downsample_fp8
{
__global__ __maxnreg__(168) void window_block_c256_downsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<256, true>(r_Parameters);
	FAccumulatorTile<32> r_WindowOutput[4];
	__shared__ FSharedWindow<256, true> s_Window;
	RunWindowWide<256, true, FTiledIO<256, true>, true>(r_Arguments, s_Window, r_WindowOutput);
	ProjectDown<256, true>(r_Arguments,
						   Publish<true>(dlssnr::kernels::window_pool::PoolWindow(r_WindowOutput)), s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp8

// -----------------------------------------------------------------------------
// window_attention_projection_pool_c512_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_pool_512_fp8; not historical source.

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
{
__global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	const dlssnr::kernels::spatial_projection::FArguments r_Arguments{r_Parameters.g_Input,
																	  r_Parameters.g_Residual,
																	  r_Parameters.g_Output,
																	  r_Parameters.g_PackedWeights,
																	  int(r_Parameters.Height),
																	  int(r_Parameters.Width),
																	  r_Parameters.g_DownsampledOutput,
																	  int(r_Parameters.DownsampledHeight),
																	  int(r_Parameters.DownsampledWidth)};
	dlssnr::kernels::spatial_projection::Forward<true, 4, false, false, 2, true>(r_Arguments, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
