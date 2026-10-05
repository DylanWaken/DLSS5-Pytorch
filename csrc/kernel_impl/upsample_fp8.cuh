#pragma once
// All fused upsample paths: window blocks and the C1024-to-C512 decoder.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_upsample.cuh"
#include "decoder.cuh"

// Entry profiles in this file:
//   window_block_c32_upsample_fp8
//   window_block_c64_upsample_fp8
//   window_block_c128_upsample_fp8
//   window_block_c256_upsample_fp8
//   decoder_upsample_c1024_to_c512_fp8

// -----------------------------------------------------------------------------
// window_block_c32_upsample_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_upsample_fp8. Not recovered historical source.

namespace dlssnr::reconstructed::window_block_c32_upsample_fp8
{
__global__ __maxnreg__(168) void window_block_c32_upsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<32>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<32, true>(r_Arguments, r_Merged);
	r_Arguments.r_Merged = r_Merged;
	RunWindow32<true, FArguments, FSmallUpIO<true>>(r_Arguments);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp8

// -----------------------------------------------------------------------------
// window_block_c64_upsample_fp8
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_upsample_fp8. Not the historical C++ source.

namespace dlssnr::reconstructed::window_block_c64_upsample_fp8
{
__global__ __maxnreg__(168) void window_block_c64_upsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<64>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<64, true>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<64, true> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, Publish<true>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<64, true, FUpIO<64, true>>(r_Arguments, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp8

// -----------------------------------------------------------------------------
// window_block_c128_upsample_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstructed from this exact original C128 entry.

namespace dlssnr::reconstructed::window_block_c128_upsample_fp8
{
__global__ __maxnreg__(168) void window_block_c128_upsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<128>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<128, true>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<128, true> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, Publish<true>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<128, true, FUpIO<128, true>>(r_Arguments, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp8

// -----------------------------------------------------------------------------
// window_block_c256_upsample_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_upsample_fp8; not historical source.

namespace dlssnr::reconstructed::window_block_c256_upsample_fp8
{
__global__ __maxnreg__(168) void window_block_c256_upsample_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<256>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<256, true>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<256, true> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, Publish<true>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<256, true, FUpIO<256, true>>(r_Arguments, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp8

// -----------------------------------------------------------------------------
// decoder_upsample_c1024_to_c512_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_dec_input_upsample_1024_512_fp8; not historical C++ source.

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8
{
__global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[2064];
	dlssnr::kernels::decoder::Forward<true>(r_Parameters, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8
