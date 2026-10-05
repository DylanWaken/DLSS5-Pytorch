#pragma once
// All fused upsample paths: window blocks and the C1024-to-C512 decoder.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"

#include "window_upsample.cuh"
#include "decoder.cuh"

// Entry profiles in this file:
//   window_block_c32_upsample_fp16
//   window_block_c64_upsample_fp16
//   window_block_c128_upsample_fp16
//   window_block_c256_upsample_fp16
//   decoder_upsample_c1024_to_c512_fp16

// -----------------------------------------------------------------------------
// window_block_c32_upsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_1h_32_1_upsample. Not recovered historical source.

namespace dlssnr::reconstructed::window_block_c32_upsample_fp16
{
__global__ __maxnreg__(168) void window_block_c32_upsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<32>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<32, false>(r_Arguments, r_Merged);
	r_Arguments.r_Merged = r_Merged;
	RunWindow32<false, FArguments, FSmallUpIO<false>>(r_Arguments);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp16

// -----------------------------------------------------------------------------
// window_block_c64_upsample_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_upsample. Not the historical C++ source.

namespace dlssnr::reconstructed::window_block_c64_upsample_fp16
{
__global__ __maxnreg__(168) void window_block_c64_upsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<64>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<64, false>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<64, false> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, Publish<false>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<64, false, FUpIO<64, false>>(r_Arguments, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp16

// -----------------------------------------------------------------------------
// window_block_c128_upsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_4h_128_4_upsample. Not historical source.

namespace dlssnr::reconstructed::window_block_c128_upsample_fp16
{
__global__ __maxnreg__(168) void window_block_c128_upsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<128>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<128, false>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<128, false> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, Publish<false>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<128, false, FUpIO<128, false>>(r_Arguments, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp16

// -----------------------------------------------------------------------------
// window_block_c256_upsample_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_upsample; not historical source.

namespace dlssnr::reconstructed::window_block_c256_upsample_fp16
{
__global__ __maxnreg__(192) void window_block_c256_upsample_fp16(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	using namespace dlssnr::kernels::window_upsample;
	FArguments r_Arguments = Arguments<256>(r_Parameters);
	FAccumulatorTile<32> r_Merged[4];
	ProjectAndMerge<256, false>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<256, false> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, Publish<false>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<256, false, FUpIO<256, false>>(r_Arguments, s_Window);
#endif
}
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp16

// -----------------------------------------------------------------------------
// decoder_upsample_c1024_to_c512_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_dec_input_upsample_1024_512; not historical C++ source.

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16
{
__global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp16(Parameters ParameterBlock)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[2064];
	dlssnr::kernels::decoder::Forward<false>(ParameterBlock, s_Storage);
#endif
}
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16
