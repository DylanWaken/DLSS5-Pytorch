#pragma once
// Reconstructed from module_5.ptx's four original 1024-channel repack entries.
// These are physical-layout bit copies, not BHWC conversions or FP arithmetic.
#include "../kernel_launcher/kernel_abi.h"
#include <cuda_runtime.h>
#include <cstdint>
#include <cstddef>

// PTX signed division/narrow-cast expressions reduce to these nonnegative
// dword offsets on the launcher-checked aligned geometry domain.
// The independently recovered FP8/Half layouts differ only in the 16-token
// group stride: 256/512 dwords per token. Keep the shared swizzle in one template.
template <uint32_t WordsPerToken>
__device__ __forceinline__ uint32_t GlobalRepackPhysicalWord(uint32_t g_TokenIndex, uint32_t g_ChannelWord)
{
	static_assert(WordsPerToken == 256u || WordsPerToken == 512u,
				  "Only recovered C1024 layouts are admitted");
	return (g_TokenIndex / 16u) * (16u * WordsPerToken) + (g_ChannelWord / 8u) * 128u +
		   (g_TokenIndex % 8u) * 16u + (g_ChannelWord % 4u) * 4u + ((g_ChannelWord % 8u) / 4u) * 2u +
		   (g_TokenIndex % 16u) / 8u;
}

__device__ __forceinline__ uint32_t GlobalRepackSpatialToken(uint32_t g_TokenIndex, uint32_t g_Width)
{
	const uint32_t g_Y = g_TokenIndex / g_Width, g_X = g_TokenIndex % g_Width;
	return ((g_Y / 4u) * (g_Width / 4u) + g_X / 4u) * 16u + (g_Y % 4u) * 4u + g_X % 4u;
}

template <bool bFp8, bool bToTokenLayout>
__device__ __forceinline__ void CopyGlobalRepackWords(FGlobalRepackParameters r_Parameters)
{
	constexpr uint32_t CONST_WORDS_PER_TOKEN = bFp8 ? 256u : 512u;
	constexpr uint32_t CONST_TOKEN_ALIGNMENT = bFp8 ? 32u : 16u;
	const uint32_t g_TokenCount = uint32_t(r_Parameters.Height) * uint32_t(r_Parameters.Width);
	const uint32_t g_PaddedTokenCount =
		(g_TokenCount + CONST_TOKEN_ALIGNMENT - 1u) / CONST_TOKEN_ALIGNMENT * CONST_TOKEN_ALIGNMENT;
	const uint32_t g_WordCount = (bToTokenLayout ? g_PaddedTokenCount : g_TokenCount) * CONST_WORDS_PER_TOKEN;
	const auto* g_Input = reinterpret_cast<const uint32_t*>(r_Parameters.g_Input);
	auto* g_Output = reinterpret_cast<uint32_t*>(r_Parameters.g_Output);
	const uint32_t g_WordStride = gridDim.x * blockDim.x;
	for (uint32_t g_WordIndex = blockIdx.x * blockDim.x + threadIdx.x; g_WordIndex < g_WordCount;
		 g_WordIndex += g_WordStride)
	{
		const uint32_t g_TokenIndex = g_WordIndex / CONST_WORDS_PER_TOKEN,
					   g_ChannelWord = g_WordIndex % CONST_WORDS_PER_TOKEN;
		const uint32_t g_TokenWord =
			GlobalRepackPhysicalWord<CONST_WORDS_PER_TOKEN>(g_TokenIndex, g_ChannelWord);
		if constexpr (bToTokenLayout)
		{
			uint32_t r_CopiedWord = 0;
			// Forward tail writes +0 bits and never reads the spatial input.
			if (g_TokenIndex < g_TokenCount)
			{
				const uint32_t g_SpatialToken =
					GlobalRepackSpatialToken(g_TokenIndex, uint32_t(r_Parameters.Width));
				r_CopiedWord =
					g_Input[GlobalRepackPhysicalWord<CONST_WORDS_PER_TOKEN>(g_SpatialToken, g_ChannelWord)];
			}
			g_Output[g_TokenWord] = r_CopiedWord;
		}
		else
		{
			// Inverse launched tail threads perform neither load nor store.
			const uint32_t g_SpatialToken =
				GlobalRepackSpatialToken(g_TokenIndex, uint32_t(r_Parameters.Width));
			g_Output[GlobalRepackPhysicalWord<CONST_WORDS_PER_TOKEN>(g_SpatialToken, g_ChannelWord)] =
				g_Input[g_TokenWord];
		}
	}
}
