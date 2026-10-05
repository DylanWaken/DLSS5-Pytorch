#pragma once
// Reconstructed from module_5.ptx's four original 1024-channel repack entries.
// These are physical-layout bit copies, not BHWC conversions or FP arithmetic.
#include <cuda_runtime.h>
#include <cstdint>
#include <cstddef>

namespace dlssnr::reconstructed::global_repack_layout
{
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	int32_t Height;
	int32_t Width;
};

static_assert(sizeof(Parameters) == 24 && offsetof(Parameters, g_Output) == 8 &&
				  offsetof(Parameters, Height) == 16 && offsetof(Parameters, Width) == 20,
			  "original global repack ABI");

// PTX signed division/narrow-cast expressions reduce to these nonnegative
// dword offsets on the launcher-checked aligned geometry domain.
// FP8 has 256 dwords/token and 4096 dwords/16-token group.
__device__ __forceinline__ uint32_t Fp8Word(uint32_t g_TokenIndex, uint32_t g_ChannelWord)
{
	return (g_TokenIndex / 16u) * 4096u + (g_ChannelWord / 8u) * 128u + (g_TokenIndex % 8u) * 16u +
		   (g_ChannelWord % 4u) * 4u + ((g_ChannelWord % 8u) / 4u) * 2u + (g_TokenIndex % 16u) / 8u;
}

// Half is independently derived: 512 dwords/token,8192 dwords/group.
// One dword carries two unchanged consecutive Half channel bit patterns.
__device__ __forceinline__ uint32_t HalfWord(uint32_t g_TokenIndex, uint32_t g_ChannelWord)
{
	return (g_TokenIndex / 16u) * 8192u + (g_ChannelWord / 8u) * 128u + (g_TokenIndex % 8u) * 16u +
		   (g_ChannelWord % 4u) * 4u + ((g_ChannelWord % 8u) / 4u) * 2u + (g_TokenIndex % 16u) / 8u;
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
		const uint32_t g_TokenWord =
			r_bFP8 ? Fp8Word(g_TokenIndex, g_ChannelWord) : HalfWord(g_TokenIndex, g_ChannelWord);
		if constexpr (r_bTo1D)
		{
			uint32_t r_Value = 0;
			// Forward tail writes +0 bits and never reads the spatial input.
			if (g_TokenIndex < r_Tokens)
			{
				const uint32_t g_SpatialToken = SpatialToken(g_TokenIndex, uint32_t(r_P.Width));
				r_Value = g_Input[r_bFP8 ? Fp8Word(g_SpatialToken, g_ChannelWord)
										 : HalfWord(g_SpatialToken, g_ChannelWord)];
			}
			g_Output[g_TokenWord] = r_Value;
		}
		else
		{
			// Inverse launched tail threads perform neither load nor store.
			const uint32_t g_SpatialToken = SpatialToken(g_TokenIndex, uint32_t(r_P.Width));
			g_Output[r_bFP8 ? Fp8Word(g_SpatialToken, g_ChannelWord)
							: HalfWord(g_SpatialToken, g_ChannelWord)] = g_Input[g_TokenWord];
		}
	}
}

// Original module_6 cc_cb_clear, lines 29534-29557. The final four ABI bytes
// are padding; this kernel writes -1, not zero, to each completion counter.
struct alignas(8) ClearParameters
{
	uint64_t g_Counters;
	int32_t Count;
	int32_t Reserved;
};

static_assert(sizeof(ClearParameters) == 16 && offsetof(ClearParameters, Count) == 8,
			  "original cc_cb_clear ABI");

} // namespace dlssnr::reconstructed::global_repack_layout
