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
	RunWindowUpsample<32, true>(Parameters);
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
	RunWindowUpsample<64, true>(Parameters);
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
	RunWindowUpsample<128, true>(Parameters);
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
	RunWindowUpsample<256, true>(Parameters);
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
	RunDecoder<true>(Parameters);
#endif
}
