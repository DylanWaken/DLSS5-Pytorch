#pragma once
// Input preprocessing and final output postprocessing with their fused windows.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_preprocess.cuh"
#include "postprocess.cuh"

// Entry profiles in this file:
//   input_preprocess_window_c32_fp16
//   output_window_postprocess_c32_fp16

// -----------------------------------------------------------------------------
// input_preprocess_window_c32_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_pre_block_swin_1h_32_1. Not recovered historical source.

namespace dlssnr::reconstructed::input_preprocess_window_c32_fp16
{
__global__ __maxnreg__(168) void input_preprocess_window_c32_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ dlssnr::kernels::input_features::FSharedFeatures s_Features;
	const auto& r_Input = reinterpret_cast<const dlssnr::kernels::input_features::FParameters&>(r_Parameters);
	dlssnr::kernels::window_preprocess::RunPreprocess<false, false>(r_Input, s_Features);
#endif
}
} // namespace dlssnr::reconstructed::input_preprocess_window_c32_fp16

// -----------------------------------------------------------------------------
// output_window_postprocess_c32_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_post_block_swin_1h_32. Not recovered historical source.

namespace dlssnr::reconstructed::output_window_postprocess_c32_fp16
{
__global__ __maxnreg__(168) void output_window_postprocess_c32_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	dlssnr::kernels::postprocess::RunPostprocess<false>(r_Parameters);
#endif
}
} // namespace dlssnr::reconstructed::output_window_postprocess_c32_fp16
