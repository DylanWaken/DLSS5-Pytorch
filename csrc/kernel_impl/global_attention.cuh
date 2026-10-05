#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_abi.h"
#include "warp_window32.cuh"

// Native streaming global attention: four warps own 256 queries for one
// 32-channel head, consuming 64 keys at a time through a two-stage K/V ring.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <bool bFp8> struct FGlobalAttentionProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int QueryChunks = bFp8 ? 1 : 2;
	static constexpr int ProbabilityChunks = bFp8 ? 2 : 4;
	static constexpr int s_StageBytes = 2048 * ElementBytes;
	static constexpr int s_ValueOffset = 2 * s_StageBytes;
	static constexpr int s_BarrierOffset = 4 * s_StageBytes;
};

struct FGlobalAttentionCoordinates
{
	int g_Tokens, g_PaddedTokens, g_Groups16, g_KeyTiles, g_QueryBlocks128;
	int g_Head, g_QueryBlock256, Lane, Warp;
};

// Used twice in the score-sum loop: before and after the cross-lane transpose.
// The same packed-register permutation serves both FP8 and Half paths.
__device__ __forceinline__ void PermuteGlobalAttentionQuad(uint32_t (&r_ProbabilitySums)[4],
														   int r_Permutation)
{
	// Two conditional swap levels implement Words[i] = Words[i XOR p].
	// Fixed indices keep the quartet in registers during the warp transpose.
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const uint32_t r_EvenWord = r_ProbabilitySums[r_Pair * 2],
					   r_OddWord = r_ProbabilitySums[r_Pair * 2 + 1];
		r_ProbabilitySums[r_Pair * 2] = (r_Permutation & 1) ? r_OddWord : r_EvenWord;
		r_ProbabilitySums[r_Pair * 2 + 1] = (r_Permutation & 1) ? r_EvenWord : r_OddWord;
	}
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const uint32_t r_EvenWord = r_ProbabilitySums[r_Pair], r_OddWord = r_ProbabilitySums[r_Pair + 2];
		r_ProbabilitySums[r_Pair] = (r_Permutation & 2) ? r_OddWord : r_EvenWord;
		r_ProbabilitySums[r_Pair + 2] = (r_Permutation & 2) ? r_EvenWord : r_OddWord;
	}
}

#endif
