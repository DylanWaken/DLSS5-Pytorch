#pragma once
// Reconstructed from module_5.ptx's four original 1024-channel repack entries.
// These are physical-layout bit copies, not BHWC conversions or FP arithmetic.
#include "kernel_abi.h"
#include <cuda_runtime.h>
#include <cstdint>
#include <cstddef>

// PTX signed division/narrow-cast expressions reduce to these nonnegative
// dword offsets on the launcher-checked aligned geometry domain.
// The independently recovered FP8/Half layouts differ only in the 16-token
// group stride: 256/512 dwords per token. Keep the shared swizzle in one template.
// Shared by both repack directions and both storage precisions; these two
// pure layout maps contain no allocations, synchronization or memory operations.
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
