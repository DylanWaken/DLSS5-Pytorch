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

namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp16
{
__global__ __maxnreg__(168) void input_preprocess_window_downsample_c32_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ dlssnr::kernels::input_features::FSharedFeatures s_Features;
	const auto& r_Input = reinterpret_cast<const dlssnr::kernels::input_features::FParameters&>(r_Parameters);
	dlssnr::kernels::window_preprocess::RunPreprocess<false, true>(r_Input, s_Features);
#endif
}
} // namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp16

// -----------------------------------------------------------------------------
// window_block_c32_downsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_ds. Not recovered historical source.

namespace dlssnr::reconstructed::window_block_c32_downsample_fp16
{
__global__ __maxnreg__(168) void window_block_c32_downsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<32, false>(r_Parameters);
	FAccumulatorTile<32> r_Raw[4];
	RunWindow32<false, FArguments, FOrdinaryIO, true>(r_Arguments, r_Raw);
	ProjectDown32<false>(r_Arguments, Publish<false>(dlssnr::kernels::window_pool::PoolWindow(r_Raw)));
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp16

// -----------------------------------------------------------------------------
// window_block_c64_downsample_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_ds. Not the historical C++ source.

namespace dlssnr::reconstructed::window_block_c64_downsample_fp16
{
__global__ __maxnreg__(168) void window_block_c64_downsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<64, false>(r_Parameters);
	FAccumulatorTile<32> r_Raw[4];
	__shared__ FSharedWindow<64, false> s_Window;
	RunWindowWide<64, false, FTiledIO<64, false>, true>(r_Arguments, s_Window, r_Raw);
	ProjectDown<64, false>(r_Arguments, Publish<false>(dlssnr::kernels::window_pool::PoolWindow(r_Raw)),
						   s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp16

// -----------------------------------------------------------------------------
// window_block_c128_downsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_4h_128_4_ds. Not historical source.

namespace dlssnr::reconstructed::window_block_c128_downsample_fp16
{
__global__ __maxnreg__(168) void window_block_c128_downsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<128, false>(r_Parameters);
	FAccumulatorTile<32> r_Raw[4];
	__shared__ FSharedWindow<128, false> s_Window;
	RunWindowWide<128, false, FTiledIO<128, false>, true>(r_Arguments, s_Window, r_Raw);
	ProjectDown<128, false>(r_Arguments, Publish<false>(dlssnr::kernels::window_pool::PoolWindow(r_Raw)),
							s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp16

// -----------------------------------------------------------------------------
// window_block_c256_downsample_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_ds; not historical source.

namespace dlssnr::reconstructed::window_block_c256_downsample_fp16
{
__global__ __maxnreg__(192) void window_block_c256_downsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_downsample;
	const FArguments r_Arguments = Arguments<256, false>(r_Parameters);
	FAccumulatorTile<32> r_Raw[4];
	__shared__ FSharedWindow<256, false> s_Window;
	RunWindowWide<256, false, FTiledIO<256, false>, true>(r_Arguments, s_Window, r_Raw);
	ProjectDown<256, false>(r_Arguments, Publish<false>(dlssnr::kernels::window_pool::PoolWindow(r_Raw)),
							s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp16

// -----------------------------------------------------------------------------
// window_attention_projection_pool_c512_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_split_swin_16h_proj_pool_512; not historical source.

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
{
__global__ __maxnreg__(168) void window_attention_projection_pool_c512_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[8208];
	const dlssnr::kernels::spatial_projection::FArguments r_Arguments{
		r_Parameters.g_Pointer0,  r_Parameters.g_Pointer8,	  r_Parameters.g_Pointer16,
		r_Parameters.g_Pointer32, int(r_Parameters.Scalar64), int(r_Parameters.Scalar68),
		r_Parameters.g_Pointer24, int(r_Parameters.Scalar72), int(r_Parameters.Scalar76)};
	dlssnr::kernels::spatial_projection::Forward<false, 4, false, false, 2, true>(r_Arguments, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
