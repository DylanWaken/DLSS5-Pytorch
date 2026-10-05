#pragma once
// Input preprocessing and final output postprocessing with their fused windows.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_preprocess.cuh"
#include "postprocess.cuh"

// Entry profiles in this file:
//   input_preprocess_window_c32_fp8
//   output_window_postprocess_c32_fp8

// -----------------------------------------------------------------------------
// input_preprocess_window_c32_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_pre_block_swin_1h_32_1_fp8. Not recovered historical source.

extern "C" __global__
	__maxnreg__(168) void input_preprocess_window_c32_fp8(FInputPreprocessWindowC32Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ FSharedFeatures s_Features;
	const FPreprocessParameters& r_Input = r_Parameters;
	RunPreprocess<true, false>(r_Input, s_Features);
#endif
}

// -----------------------------------------------------------------------------
// output_window_postprocess_c32_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_post_block_swin_1h_32_fp8. Not recovered historical source.

extern "C" __global__ __maxnreg__(168) void output_window_postprocess_c32_fp8(
	FOutputWindowPostprocessC32Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunPostprocess<true>(r_Parameters);
#endif
}
