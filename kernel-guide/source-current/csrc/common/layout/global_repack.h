#pragma once
// Recovered 1024-channel global repack mapping.
//
// These are physical-layout bit copies, not BHWC conversions or FP arithmetic.
// The PTX signed division/narrow-cast expressions reduce to these nonnegative
// dword offsets on the launcher-checked aligned geometry domain. The FP8/Half
// layouts differ only in the 16-token group stride: 256/512 dwords per token.
// Both repack directions and both storage precisions share these two maps.
#include <cstdint>

namespace dlssnr
{
namespace layout
{
// Map one (token, channel word) pair to its physical dword offset. The caller
// supplies the storage-specific words-per-token value: 256 for FP8, 512 for Half.
template <std::uint32_t WordsPerToken>
__host__ __device__ constexpr std::uint32_t repack_physical_word(std::uint32_t token_index,
																 std::uint32_t channel_word)
{
	static_assert(WordsPerToken == 256u || WordsPerToken == 512u,
				  "Only recovered C1024 layouts are admitted");
	return (token_index / 16u) * (16u * WordsPerToken) + (channel_word / 8u) * 128u +
		   (token_index % 8u) * 16u + (channel_word % 4u) * 4u + ((channel_word % 8u) / 4u) * 2u +
		   (token_index % 16u) / 8u;
}

// Map a row-major token index to the recovered 4x4 physical tile position.
// Width is the spatial row length in tokens; caller guarantees width >= 1.
__host__ __device__ constexpr std::uint32_t repack_spatial_token(std::uint32_t token_index,
																 std::uint32_t width)
{
	const std::uint32_t y = token_index / width;
	const std::uint32_t x = token_index % width;
	return ((y / 4u) * (width / 4u) + x / 4u) * 16u + (y % 4u) * 4u + x % 4u;
}

} // namespace layout
} // namespace dlssnr
