#pragma once
// Fused window attention/FFN blocks, including input and output layout views.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "warp_window_wide.cuh"
#include "window_view_io.cuh"

// Entry profiles in this file:
//   window_block_c32_fp8
//   window_block_c32_input_view_fp8
//   window_block_c32_output_view_fp8
//   window_block_c64_fp8
//   window_block_c64_input_view_fp8
//   window_block_c64_output_view_fp8
//   window_block_c128_fp8
//   window_block_c128_input_view_fp8
//   window_block_c128_output_view_fp8
//   window_block_c256_fp8
//   window_block_c256_input_view_fp8
//   window_block_c256_output_view_fp8

// -----------------------------------------------------------------------------
// window_block_c32_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of the separate original C32 ordinary fp8 entry.
// Native scalar/control/physical ownership retained; not the historical CUDA source.

extern "C" __global__ __maxnreg__(168) void window_block_c32_fp8(FWindowBlockC32Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindow32<true>(r_Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c32_input_view_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_inpview_fp8. Not recovered historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c32_input_view_fp8(FWindowBlockC32InputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FSmallWindowViewIO<true, true, false>;
	RunWindow32<true, decltype(r_Parameters), FWindowIO>(r_Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c32_output_view_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_outview_fp8. Not recovered historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c32_output_view_fp8(
	FWindowBlockC32OutputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FSmallWindowViewIO<true, false, true>;
	RunWindow32<true, decltype(r_Parameters), FWindowIO>(r_Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_fp8
// -----------------------------------------------------------------------------
// Equivalent CUDA C++ reconstruction of the original ordinary C64 FP8 entry.
// Native scalar names and control edges retained; this is not the historical source file.

extern "C" __global__ __maxnreg__(168) void window_block_c64_fp8(FWindowBlockC64Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ FSharedWindow<64, true> s_Window;
	RunWindowWide<64, true>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_input_view_fp8
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_inpview_fp8. Not the historical C++ source.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_input_view_fp8(FWindowBlockC64InputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FWindowViewIO<64, true, true, false>;
	__shared__ FSharedWindow<64, true> s_Window;
	RunWindowWide<64, true, FWindowIO>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_output_view_fp8
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_outview_fp8. Not the historical C++ source.

extern "C" __global__ __maxnreg__(168) void window_block_c64_output_view_fp8(
	FWindowBlockC64OutputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FWindowViewIO<64, true, false, true>;
	__shared__ FSharedWindow<64, true> s_Window;
	RunWindowWide<64, true, FWindowIO>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_fp8
// -----------------------------------------------------------------------------
// Readable CUDA reconstruction from exact original C128 ordinary FP8 PTX.
// Native scalar names/control retained; not claimed to be the historical CUDA source.

extern "C" __global__ __maxnreg__(168) void window_block_c128_fp8(FWindowBlockC128Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ FSharedWindow<128, true> s_Window;
	RunWindowWide<128, true>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_input_view_fp8
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_4h_128_4_inpview_fp8. Not historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c128_input_view_fp8(
	FWindowBlockC128InputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FWindowViewIO<128, true, true, false>;
	__shared__ FSharedWindow<128, true> s_Window;
	RunWindowWide<128, true, FWindowIO>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_output_view_fp8
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_4h_128_4_outview_fp8. Not historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c128_output_view_fp8(
	FWindowBlockC128OutputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FWindowViewIO<128, true, false, true>;
	__shared__ FSharedWindow<128, true> s_Window;
	RunWindowWide<128, true, FWindowIO>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_fp8
// -----------------------------------------------------------------------------
// Equivalent readable CUDA C++ reconstruction of the original ordinary C256 FP8 entry.
// Native scalar names and control edges retained; not a recovered historical source file.

extern "C" __global__ __maxnreg__(168) void window_block_c256_fp8(FWindowBlockC256Fp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ FSharedWindow<256, true> s_Window;
	RunWindowWide<256, true>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_input_view_fp8
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_8h_256_8_inpview_fp8. Not historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c256_input_view_fp8(
	FWindowBlockC256InputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FWindowViewIO<256, true, true, false>;
	__shared__ FSharedWindow<256, true> s_Window;
	RunWindowWide<256, true, FWindowIO>(r_Parameters, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_output_view_fp8
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_8h_256_8_outview_fp8. Not historical source.

extern "C" __global__ __maxnreg__(168) void window_block_c256_output_view_fp8(
	FWindowBlockC256OutputViewFp8Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = FWindowViewIO<256, true, false, true>;
	__shared__ FSharedWindow<256, true> s_Window;
	RunWindowWide<256, true, FWindowIO>(r_Parameters, s_Window);
#endif
}
