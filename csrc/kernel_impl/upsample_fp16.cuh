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
	__maxnreg__(168) void window_block_c32_upsample_fp16(FWindowBlockC32UpsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowUpsample<32, false>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c64_upsample_fp16
// -----------------------------------------------------------------------------
// Source reconstruction from cc_tinlayout_fused_swin_2h_64_2_upsample. Not the historical C++ source.

extern "C" __global__
	__maxnreg__(168) void window_block_c64_upsample_fp16(FWindowBlockC64UpsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowUpsample<64, false>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c128_upsample_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_tinlayout_fused_swin_4h_128_4_upsample. Not historical source.

extern "C" __global__
	__maxnreg__(168) void window_block_c128_upsample_fp16(FWindowBlockC128UpsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowUpsample<128, false>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// window_block_c256_upsample_fp16
// -----------------------------------------------------------------------------
// Readable equivalent of cc_tinlayout_fused_swin_8h_256_8_upsample; not historical source.

extern "C" __global__
	__maxnreg__(192) void window_block_c256_upsample_fp16(FWindowBlockC256UpsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunWindowUpsample<256, false>(Parameters);
#endif
}

// -----------------------------------------------------------------------------
// decoder_upsample_c1024_to_c512_fp16
// -----------------------------------------------------------------------------
// Recovered tensor algorithm of cc_dec_input_upsample_1024_512; not historical C++ source.

extern "C" __global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp16(
	FDecoderUpsampleC1024ToC512Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	RunDecoder<false>(Parameters);
#endif
}
