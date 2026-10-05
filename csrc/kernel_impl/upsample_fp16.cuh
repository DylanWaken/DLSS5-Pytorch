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

extern "C" __global__
	__maxnreg__(168) void window_block_c32_upsample_fp16(FWindowBlockC32UpsampleFp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments r_Arguments = MakeWindowUpsampleArguments<32>(r_Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<32, false>(r_Arguments, r_Merged);
	r_Arguments.r_Merged = r_Merged;
	RunWindow32<false, FWindowUpsampleArguments, FSmallWindowUpsampleIO<false>>(r_Arguments);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_upsample_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_upsample. Not the historical C++ source.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_upsample_fp16(FWindowBlockC64UpsampleFp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments r_Arguments = MakeWindowUpsampleArguments<64>(r_Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<64, false>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<64, false> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<false>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<64, false, FWindowUpsampleIO<64, false>>(r_Arguments, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_upsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_4h_128_4_upsample. Not historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c128_upsample_fp16(FWindowBlockC128UpsampleFp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments r_Arguments = MakeWindowUpsampleArguments<128>(r_Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<128, false>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<128, false> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<false>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<128, false, FWindowUpsampleIO<128, false>>(r_Arguments, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_upsample_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_upsample; not historical source.

extern "C" __global__
	__maxnreg__(192) void window_block_c256_upsample_fp16(FWindowBlockC256UpsampleFp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	FWindowUpsampleArguments r_Arguments = MakeWindowUpsampleArguments<256>(r_Parameters);
	FWindowAccumulatorTile<32> r_Merged[4];
	ProjectAndMergeUpsample<256, false>(r_Arguments, r_Merged);
	__shared__ FSharedWindow<256, false> s_Window;
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<false>(r_Merged[r_Tile]));
	__syncthreads();
	r_Arguments.s_Window = &s_Window;
	RunWindowWide<256, false, FWindowUpsampleIO<256, false>>(r_Arguments, s_Window);
#endif
}

// -----------------------------------------------------------------------------
// decoder_upsample_c1024_to_c512_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_dec_input_upsample_1024_512; not historical C++ source.

extern "C" __global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp16(
	FDecoderUpsampleC1024ToC512Fp16Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_Storage[2064];
	RunDecoder<false>(r_Parameters, s_Storage);
#endif
}
