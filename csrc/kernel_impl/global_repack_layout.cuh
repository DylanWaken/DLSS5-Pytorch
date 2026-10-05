#pragma once
// Reconstructed from module_5.ptx's four original 1024-channel repack entries.
// These are physical-layout bit copies, not BHWC conversions or FP arithmetic.
#include "../kernel_launcher/kernel_abi.h"
#include <cuda_runtime.h>
#include <cstdint>
#include <cstddef>

namespace dlssnr::reconstructed::global_repack_layout
{
// PTX signed division/narrow-cast expressions reduce to these nonnegative
// dword offsets on the launcher-checked aligned geometry domain.
// The independently recovered FP8/Half layouts differ only in the 16-token
// group stride: 256/512 dwords per token. Keep the shared swizzle in one template.
template <uint32_t WordsPerToken>
__device__ __forceinline__ uint32_t PhysicalWord(uint32_t g_TokenIndex, uint32_t g_ChannelWord)
{
	static_assert(WordsPerToken == 256u || WordsPerToken == 512u,
				  "Only recovered C1024 layouts are admitted");
	return (g_TokenIndex / 16u) * (16u * WordsPerToken) + (g_ChannelWord / 8u) * 128u +
		   (g_TokenIndex % 8u) * 16u + (g_ChannelWord % 4u) * 4u + ((g_ChannelWord % 8u) / 4u) * 2u +
		   (g_TokenIndex % 16u) / 8u;
}

__device__ __forceinline__ uint32_t SpatialToken(uint32_t g_TokenIndex, uint32_t g_Width)
{
	const uint32_t g_Y = g_TokenIndex / g_Width, g_X = g_TokenIndex % g_Width;
	return ((g_Y / 4u) * (g_Width / 4u) + g_X / 4u) * 16u + (g_Y % 4u) * 4u + g_X % 4u;
}

template <bool r_bFP8, bool r_bTo1D> __device__ __forceinline__ void CopyWords(Parameters r_P)
{
	constexpr uint32_t r_Words = r_bFP8 ? 256u : 512u;
	constexpr uint32_t r_Alignment = r_bFP8 ? 32u : 16u;
	const uint32_t r_Tokens = uint32_t(r_P.Height) * uint32_t(r_P.Width);
	const uint32_t r_Padded = (r_Tokens + r_Alignment - 1u) / r_Alignment * r_Alignment;
	const uint32_t g_Limit = (r_bTo1D ? r_Padded : r_Tokens) * r_Words;
	const auto* g_Input = reinterpret_cast<const uint32_t*>(r_P.g_Input);
	auto* g_Output = reinterpret_cast<uint32_t*>(r_P.g_Output);
	const uint32_t g_Stride = gridDim.x * blockDim.x;
	for (uint32_t g_WordIndex = blockIdx.x * blockDim.x + threadIdx.x; g_WordIndex < g_Limit;
		 g_WordIndex += g_Stride)
	{
		const uint32_t g_TokenIndex = g_WordIndex / r_Words, g_ChannelWord = g_WordIndex % r_Words;
		const uint32_t g_TokenWord = PhysicalWord<r_Words>(g_TokenIndex, g_ChannelWord);
		if constexpr (r_bTo1D)
		{
			uint32_t r_Value = 0;
			// Forward tail writes +0 bits and never reads the spatial input.
			if (g_TokenIndex < r_Tokens)
			{
				const uint32_t g_SpatialToken = SpatialToken(g_TokenIndex, uint32_t(r_P.Width));
				r_Value = g_Input[PhysicalWord<r_Words>(g_SpatialToken, g_ChannelWord)];
			}
			g_Output[g_TokenWord] = r_Value;
		}
		else
		{
			// Inverse launched tail threads perform neither load nor store.
			const uint32_t g_SpatialToken = SpatialToken(g_TokenIndex, uint32_t(r_P.Width));
			g_Output[PhysicalWord<r_Words>(g_SpatialToken, g_ChannelWord)] = g_Input[g_TokenWord];
		}
	}
}

} // namespace dlssnr::reconstructed::global_repack_layout
