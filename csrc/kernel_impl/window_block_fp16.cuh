#pragma once
// Fused window attention/FFN blocks, including input and output layout views.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "warp_window_wide.cuh"
#include "window_view_io.cuh"

// Entry profiles in this file:
//   window_block_c32_fp16
//   window_block_c32_input_view_fp16
//   window_block_c32_output_view_fp16
//   window_block_c64_fp16
//   window_block_c64_input_view_fp16
//   window_block_c64_output_view_fp16
//   window_block_c128_fp16
//   window_block_c128_input_view_fp16
//   window_block_c128_output_view_fp16
//   window_block_c256_fp16
//   window_block_c256_input_view_fp16
//   window_block_c256_output_view_fp16

// -----------------------------------------------------------------------------
// window_block_c32_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of the separate original C32 ordinary half entry.
// Native scalar/control/physical ownership retained; not the historical CUDA source.

namespace dlssnr::reconstructed::window_block_c32_fp16
{
__global__ __maxnreg__(168) void window_block_c32_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	dlssnr::kernels::window32::RunWindow32<false>(r_Parameters);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_fp16

// -----------------------------------------------------------------------------
// window_block_c32_input_view_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_inpview. Not recovered historical source.

namespace dlssnr::reconstructed::window_block_c32_input_view_fp16
{
__global__ __maxnreg__(168) void window_block_c32_input_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FSmallViewIO<false, true, false>;
	dlssnr::kernels::window32::RunWindow32<false, decltype(r_Parameters), FWindowIO>(r_Parameters);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp16

// -----------------------------------------------------------------------------
// window_block_c32_output_view_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_outview. Not recovered historical source.

namespace dlssnr::reconstructed::window_block_c32_output_view_fp16
{
__global__ __maxnreg__(168) void window_block_c32_output_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FSmallViewIO<false, false, true>;
	dlssnr::kernels::window32::RunWindow32<false, decltype(r_Parameters), FWindowIO>(r_Parameters);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_output_view_fp16

// -----------------------------------------------------------------------------
// window_block_c64_fp16
// -----------------------------------------------------------------------------
// CUDA/C++ reconstruction of the original ordinary C64 Half entry.
// Native source register names retained for PTX/source review.

namespace dlssnr::reconstructed::window_block_c64_fp16
{
__global__ __maxnreg__(168) void window_block_c64_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<64, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<64, false>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_fp16

// -----------------------------------------------------------------------------
// window_block_c64_input_view_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_inpview. Not the historical C++ source.

namespace dlssnr::reconstructed::window_block_c64_input_view_fp16
{
__global__ __maxnreg__(168) void window_block_c64_input_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FViewIO<64, false, true, false>;
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<64, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<64, false, FWindowIO>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_input_view_fp16

// -----------------------------------------------------------------------------
// window_block_c64_output_view_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_outview. Not the historical C++ source.

namespace dlssnr::reconstructed::window_block_c64_output_view_fp16
{
__global__ __maxnreg__(168) void window_block_c64_output_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FViewIO<64, false, false, true>;
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<64, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<64, false, FWindowIO>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_output_view_fp16

// -----------------------------------------------------------------------------
// window_block_c128_fp16
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstructed from this exact original C128 entry.

namespace dlssnr::reconstructed::window_block_c128_fp16
{
__global__ __maxnreg__(168) void window_block_c128_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<128, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<128, false>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_fp16

// -----------------------------------------------------------------------------
// window_block_c128_input_view_fp16
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_4h_128_4_inpview. Not historical source.

namespace dlssnr::reconstructed::window_block_c128_input_view_fp16
{
__global__ __maxnreg__(168) void window_block_c128_input_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FViewIO<128, false, true, false>;
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<128, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<128, false, FWindowIO>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp16

// -----------------------------------------------------------------------------
// window_block_c128_output_view_fp16
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_4h_128_4_outview. Not historical source.

namespace dlssnr::reconstructed::window_block_c128_output_view_fp16
{
__global__ __maxnreg__(168) void window_block_c128_output_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FViewIO<128, false, false, true>;
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<128, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<128, false, FWindowIO>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp16

// -----------------------------------------------------------------------------
// window_block_c256_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8; not historical source.

namespace dlssnr::reconstructed::window_block_c256_fp16
{
__global__ __maxnreg__(192) void window_block_c256_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<256, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<256, false>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_fp16

// -----------------------------------------------------------------------------
// window_block_c256_input_view_fp16
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_8h_256_8_inpview. Not historical source.

namespace dlssnr::reconstructed::window_block_c256_input_view_fp16
{
__global__ __maxnreg__(192) void window_block_c256_input_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FViewIO<256, false, true, false>;
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<256, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<256, false, FWindowIO>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp16

// -----------------------------------------------------------------------------
// window_block_c256_output_view_fp16
// -----------------------------------------------------------------------------
// Equivalent readable CUDA lowering of cc_tinlayout_fused_swin_8h_256_8_outview. Not historical source.

namespace dlssnr::reconstructed::window_block_c256_output_view_fp16
{
__global__ __maxnreg__(192) void window_block_c256_output_view_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using FWindowIO = dlssnr::kernels::window_wide::FViewIO<256, false, false, true>;
	__shared__ dlssnr::kernels::window_wide::FSharedWindow<256, false> s_Window;
	dlssnr::kernels::window_wide::RunWindowWide<256, false, FWindowIO>(r_Parameters, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp16
