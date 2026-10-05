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

extern "C" __global__
	__maxnreg__(168) void window_block_c32_upsample_fp8(FWindowBlockC32UpsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments Arguments = MakeWindowUpsampleArguments<32>(Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<32, true>(Arguments, r_Merged);
	Arguments.r_Merged = r_Merged;
	RunWindow32<true, FWindowUpsampleArguments, FSmallWindowUpsampleIO<true>>(Arguments);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_upsample_fp8
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_upsample_fp8. Not the historical C++ source.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_upsample_fp8(FWindowBlockC64UpsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments Arguments = MakeWindowUpsampleArguments<64>(Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<64, true>(Arguments, r_Merged);
	__shared__ FSharedWindow<64, true> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<true>(r_Merged[r_Tile]));
	__syncthreads();
	Arguments.s_Window = &s_Window;
	RunWindowWide<64, true, FWindowUpsampleIO<64, true>>(Arguments, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_upsample_fp8
// -----------------------------------------------------------------------------
// Readable CUDA C++ reconstructed from this exact original C128 entry.

extern "C" __global__
	__maxnreg__(168) void window_block_c128_upsample_fp8(FWindowBlockC128UpsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments Arguments = MakeWindowUpsampleArguments<128>(Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<128, true>(Arguments, r_Merged);
	__shared__ FSharedWindow<128, true> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<true>(r_Merged[r_Tile]));
	__syncthreads();
	Arguments.s_Window = &s_Window;
	RunWindowWide<128, true, FWindowUpsampleIO<128, true>>(Arguments, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_upsample_fp8
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_upsample_fp8; not historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c256_upsample_fp8(FWindowBlockC256UpsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments Arguments = MakeWindowUpsampleArguments<256>(Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<256, true>(Arguments, r_Merged);
	__shared__ FSharedWindow<256, true> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<true>(r_Merged[r_Tile]));
	__syncthreads();
	Arguments.s_Window = &s_Window;
	RunWindowWide<256, true, FWindowUpsampleIO<256, true>>(Arguments, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// decoder_upsample_c1024_to_c512_fp8
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_dec_input_upsample_1024_512_fp8; not historical C++ source.

extern "C" __global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp8(
	FDecoderUpsampleC1024ToC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[2064];
	RunDecoder<true>(Parameters, s_Storage);
#endif
}
