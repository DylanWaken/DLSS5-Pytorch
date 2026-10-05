#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_launcher/kernel_abi.h"
#include "warp_window32.cuh"

// Native streaming global attention: four warps own 256 queries for one
// 32-channel head, consuming 64 keys at a time through a two-stage K/V ring.
namespace dlssnr::kernels::global_attention
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
using namespace dlssnr::packed_math::sm120;
using namespace dlssnr::numerical_constants;
namespace Fragment = dlssnr::kernels::window32;

template <bool bFp8> struct FProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int QueryChunks = bFp8 ? 1 : 2;
	static constexpr int ProbabilityChunks = bFp8 ? 2 : 4;
	static constexpr int s_StageBytes = 2048 * ElementBytes;
	static constexpr int s_ValueOffset = 2 * s_StageBytes;
	static constexpr int s_BarrierOffset = 4 * s_StageBytes;
};

struct FCoordinates
{
	int g_Tokens, g_PaddedTokens, g_Groups16, g_KeyTiles, g_QueryBlocks128;
	int g_Head, g_QueryBlock256, r_Lane, r_Warp;
};

__device__ __forceinline__ void WaitPredecessor(uint64_t g_Counters, int g_FirstGroup, int g_Count,
												const FCoordinates& r_TileCoordinates)
{
	if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
		for (int g_Group = g_FirstGroup;
			 g_Group < g_FirstGroup + g_Count && g_Group < r_TileCoordinates.g_QueryBlocks128; ++g_Group)
			while (int32_t(CounterLoadRelaxed(g_Counters +
											  (g_Group * 16 + r_TileCoordinates.g_Head / 2) * 4)) < 0)
				PollSleep(64);
	__syncthreads();
}

template <bool bFp8>
__device__ __forceinline__ void StageKeyValue(unsigned char* s_Storage, uint64_t g_Key, uint64_t g_Value,
											  int g_KeyTile, const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const int s_Stage = (g_KeyTile & 1) * Profile::s_StageBytes;
	const int s_Barrier = Profile::s_BarrierOffset + (g_KeyTile & 1) * 8;
#pragma unroll
	for (int r_Copy = 0; r_Copy < Profile::QueryChunks; ++r_Copy)
	{
		const int r_Slot = r_TileCoordinates.r_Warp + r_Copy * 4;
		int g_KeyGroup = g_KeyTile * 4 + r_Slot / Profile::QueryChunks;
		if constexpr (!bFp8)
			if (uint32_t(r_TileCoordinates.g_Tokens + 14) < 31)
				g_KeyGroup = 0;
		const int g_KeyChunk = r_Slot % Profile::QueryChunks;
		const uint64_t g_KeyAddress = g_Key + uint64_t(g_KeyGroup) * 16384 * Profile::ElementBytes +
									  r_TileCoordinates.g_Head * 512 * Profile::ElementBytes +
									  g_KeyChunk * 512;
		const int s_Copy = s_Stage + r_Slot * 512;
		if (g_KeyGroup < r_TileCoordinates.g_Groups16)
		{
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_Copy, g_KeyAddress, 512, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_Copy + r_TileCoordinates.r_Lane * 16) =
				make_uint4(0, 0, 0, 0);
	}
#pragma unroll
	for (int r_Copy = 0; r_Copy < Profile::QueryChunks; ++r_Copy)
	{
		const int r_Slot = r_TileCoordinates.r_Warp + r_Copy * 4;
		int g_KeyGroup = g_KeyTile * 4 + r_Slot / Profile::QueryChunks;
		if constexpr (!bFp8)
			if (uint32_t(r_TileCoordinates.g_Tokens + 14) < 31)
				g_KeyGroup = 0;
		const int s_Copy = s_Stage + r_Slot * 512;
		// V has transposed fragments. FP8 stores two neighboring M16 tiles
		// in one M32 group; Half stores one M16 group with two N16 panels.
		int g_ValueGroup = bFp8 ? g_KeyTile * 2 + r_Slot / 2 : g_KeyGroup;
		const int g_ValueGroups = bFp8 ? r_TileCoordinates.g_Groups16 / 2 : r_TileCoordinates.g_Groups16;
		if constexpr (bFp8)
			if (g_ValueGroups == 1)
				g_ValueGroup = 0;
		const uint64_t g_ValueAddress =
			g_Value + uint64_t(g_ValueGroup) * 32768 + r_TileCoordinates.g_Head * 1024 + (r_Slot & 1) * 512;
		const int s_ValueCopy = Profile::s_ValueOffset + s_Copy;
		if (g_ValueGroup < g_ValueGroups)
		{
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_ValueCopy, g_ValueAddress, 512, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_ValueCopy + r_TileCoordinates.r_Lane * 16) =
				make_uint4(0, 0, 0, 0);
	}
}

template <bool bFp8> __device__ __forceinline__ void WaitKeyValue(unsigned char* s_Storage, int g_KeyTile)
{
	const int s_Barrier = FProfile<bFp8>::s_BarrierOffset + (g_KeyTile & 1) * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

__device__ __forceinline__ uint32_t ExponentialSurrogate(uint32_t r_Score)
{
	const uint32_t r_Affine =
		HalfFma(r_Score, CONST_GLOBAL_EXP_SLOPE_HALF2, CONST_GLOBAL_EXP_INTERCEPT_HALF2);
	const uint32_t r_Clamped =
		HalfMin(HalfMax(r_Affine, CONST_GLOBAL_EXP_LOWER_HALF2), CONST_GLOBAL_EXP_UPPER_HALF2);
	return (r_Clamped << CONST_GLOBAL_EXP_ENCODING_SHIFT) + CONST_GLOBAL_EXP_ENCODING_OFFSET;
}

__device__ __forceinline__ void PermuteQuad(uint32_t (&r_ProbabilitySums)[4], int r_Permutation)
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

__device__ __forceinline__ uint32_t SumProbabilities(const Fragment::FAccumulatorTile<64> (&r_Probability)[4],
													 int r_Lane)
{
	uint32_t r_QuerySums[2];
#pragma unroll
	for (int r_QueryHalf = 0; r_QueryHalf < 2; ++r_QueryHalf)
	{
		uint32_t r_LocalProbabilitySums[4], r_GatheredProbabilitySums[4];
#pragma unroll
		for (int r_Row = 0; r_Row < 4; ++r_Row)
		{
			const auto& r_Pairs = r_Probability[r_QueryHalf * 2 + r_Row / 2].r_Pair;
			const int r_QueryRowHalf = r_Row & 1;
			uint32_t r_Sum = HalfAdd(HalfAdd(r_Pairs[0][r_QueryRowHalf], r_Pairs[1][r_QueryRowHalf]),
									 HalfAdd(r_Pairs[2][r_QueryRowHalf], r_Pairs[3][r_QueryRowHalf]));
			r_Sum = HalfAdd(r_Sum, HalfAdd(r_Pairs[4][r_QueryRowHalf], r_Pairs[5][r_QueryRowHalf]));
			r_LocalProbabilitySums[r_Row] =
				HalfAdd(r_Sum, HalfAdd(r_Pairs[6][r_QueryRowHalf], r_Pairs[7][r_QueryRowHalf]));
		}
		// This warp transpose turns the MMA fragment's channel ownership
		// into one full query sum per lane, without changing Half add order.
		const int r_SourceLane = ((r_Lane & 7) << 2) + (r_Lane >> 3);
		PermuteQuad(r_LocalProbabilitySums, r_Lane & 3);
#pragma unroll
		for (int r_Row = 0; r_Row < 4; ++r_Row)
			r_GatheredProbabilitySums[r_Row] =
				ShuffleIdx(r_LocalProbabilitySums[r_Row], r_SourceLane ^ r_Row, 31, 0xffffffffu);
		PermuteQuad(r_GatheredProbabilitySums, r_Lane >> 3);
		uint32_t r_Sum = HalfAdd(r_GatheredProbabilitySums[0], r_GatheredProbabilitySums[1]);
		r_Sum = HalfAdd(r_Sum, r_GatheredProbabilitySums[2]);
		r_Sum = HalfAdd(r_Sum, r_GatheredProbabilitySums[3]);
		r_QuerySums[r_QueryHalf] = HalfAdd(JoinHalfwords(uint16_t(r_Sum), uint16_t(r_Sum)),
										   JoinHalfwords(uint16_t(r_Sum >> 16), uint16_t(r_Sum >> 16)));
	}
	return JoinHalfwords(uint16_t(r_QuerySums[0]), uint16_t(r_QuerySums[1]));
}

__device__ __forceinline__ uint32_t CorrectDenominator(uint32_t r_Denominator, int g_PaddingKeys)
{
	if (g_PaddingKeys > 0)
	{
		// Padded keys produce the surrogate's nonzero value at score zero.
		// Remove that mass in FP32 before one Half-rounded subtraction.
		const uint32_t r_AffineZero =
			HalfFma(0, CONST_GLOBAL_EXP_SLOPE_HALF2, CONST_GLOBAL_EXP_INTERCEPT_HALF2);
		const uint32_t r_ClampedZero =
			HalfMin(HalfMax(r_AffineZero, CONST_GLOBAL_EXP_LOWER_HALF2), CONST_GLOBAL_EXP_UPPER_HALF2);
		const uint16_t r_ZeroScore = uint16_t((uint16_t(r_ClampedZero) << CONST_GLOBAL_EXP_ENCODING_SHIFT) +
											  CONST_GLOBAL_EXP_SCALAR_OFFSET);
		const uint32_t r_Correction =
			FloatToHalf2(FloatMulFtzBits(HalfToFloatBits(r_ZeroScore), UintToFloatRnBits(g_PaddingKeys)));
		r_Denominator = HalfSub(r_Denominator, r_Correction);
	}
	return RcpHalf2(HalfMax(r_Denominator, CONST_NORMALIZATION_EPSILON_HALF2));
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void RunGlobalAttention(TParameters r_Parameters, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8>;
	const int g_Tokens = r_Parameters.BatchCount * r_Parameters.TokensPerBatch;
	const int g_Alignment = bFp8 ? 32 : 16;
	const int g_PaddedTokens = ((g_Tokens + g_Alignment - 1) / g_Alignment) * g_Alignment;
	const FCoordinates r_TileCoordinates{
		g_Tokens,		 g_PaddedTokens,  g_PaddedTokens / 16, (g_Tokens + 63) / 64, (g_Tokens + 127) / 128,
		int(blockIdx.x), int(blockIdx.y), int(threadIdx.x),	   int(threadIdx.y)};
	if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < 2; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();
	WaitPredecessor(r_Parameters.g_PredecessorCounters, r_TileCoordinates.g_QueryBlock256 * 2, 2,
					r_TileCoordinates);

	Fragment::FAFragment r_Query[4][Profile::QueryChunks];
#pragma unroll
	for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::QueryChunks; ++r_ReductionChunk)
		{
			int g_Group = r_TileCoordinates.g_QueryBlock256 * 16 + r_TileCoordinates.r_Warp * 4 + r_QueryTile;
			if constexpr (!bFp8)
				if (uint32_t(g_Tokens + 14) < 31)
					g_Group = 0;
			const uint64_t g_QueryFragmentAddress = r_Parameters.g_Query +
													uint64_t(g_Group) * 16384 * Profile::ElementBytes +
													r_TileCoordinates.g_Head * 512 * Profile::ElementBytes +
													r_ReductionChunk * 512 + r_TileCoordinates.r_Lane * 16;
			r_Query[r_QueryTile][r_ReductionChunk] =
				Fragment::Fragment(g_Group < r_TileCoordinates.g_Groups16
									   ? __ldca(reinterpret_cast<const uint4*>(g_QueryFragmentAddress))
									   : make_uint4(0, 0, 0, 0));
		}
#pragma unroll
	for (int g_KeyTile = 0; g_KeyTile < 2; ++g_KeyTile)
		if (g_KeyTile < r_TileCoordinates.g_KeyTiles)
		{
			WaitPredecessor(r_Parameters.g_PredecessorCounters, g_KeyTile / 2, 1, r_TileCoordinates);
			StageKeyValue<bFp8>(s_Storage, r_Parameters.g_Key, r_Parameters.g_Value, g_KeyTile,
								r_TileCoordinates);
		}
	if (r_TileCoordinates.g_KeyTiles > 0)
		WaitKeyValue<bFp8>(s_Storage, 0);
	Fragment::FAccumulatorTile<32> r_Output[4]{};
	uint32_t r_Denominator = 0;

#pragma unroll 1
	for (int g_KeyTile = 0; g_KeyTile < r_TileCoordinates.g_KeyTiles; ++g_KeyTile)
	{
		const int s_Base = (g_KeyTile & 1) * Profile::s_StageBytes + r_TileCoordinates.r_Lane * 16;
		uint4 r_Key[4][Profile::QueryChunks];
#pragma unroll
		for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
#pragma unroll
			for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::QueryChunks; ++r_ReductionChunk)
				r_Key[r_ColumnTile][r_ReductionChunk] = *reinterpret_cast<const uint4*>(
					s_Storage + s_Base + (r_ColumnTile * Profile::QueryChunks + r_ReductionChunk) * 512);
		Fragment::FAccumulatorTile<64> r_Probability[4]{};
#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 8; ++r_ColumnTile)
			{
#pragma unroll
				for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::QueryChunks; ++r_ReductionChunk)
				{
					const uint4 r_KeyVector = r_Key[r_ColumnTile / 2][r_ReductionChunk];
					const uint32_t r_KeyFragment[2] = {r_ColumnTile & 1 ? r_KeyVector.z : r_KeyVector.x,
													   r_ColumnTile & 1 ? r_KeyVector.w : r_KeyVector.y};
					Fragment::Mma<bFp8>(r_Query[r_QueryTile][r_ReductionChunk], r_KeyFragment,
										r_Probability[r_QueryTile].r_Pair[r_ColumnTile]);
				}
#pragma unroll
				for (int r_Half = 0; r_Half < 2; ++r_Half)
					r_Probability[r_QueryTile].r_Pair[r_ColumnTile][r_Half] =
						ExponentialSurrogate(r_Probability[r_QueryTile].r_Pair[r_ColumnTile][r_Half]);
			}
		r_Denominator = HalfAdd(r_Denominator, SumProbabilities(r_Probability, r_TileCoordinates.r_Lane));

		uint4 r_Value[Profile::ProbabilityChunks][2];
#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::ProbabilityChunks; ++r_ReductionChunk)
#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
				r_Value[r_ReductionChunk][r_ColumnTile] =
					*reinterpret_cast<const uint4*>(s_Storage + Profile::s_ValueOffset + s_Base +
													(r_ReductionChunk * 2 + r_ColumnTile) * 512);
#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
#pragma unroll
				for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::ProbabilityChunks;
					 ++r_ReductionChunk)
				{
					const auto r_ProbabilityFragment =
						Fragment::PublishChunk<bFp8>(r_Probability[r_QueryTile], r_ReductionChunk);
					const uint4 r_ValueVector = r_Value[r_ReductionChunk][r_ColumnTile];
					const uint32_t r_LowerValueFragment[2] = {r_ValueVector.x, r_ValueVector.y},
								   r_UpperValueFragment[2] = {r_ValueVector.z, r_ValueVector.w};
					Fragment::Mma<bFp8>(r_ProbabilityFragment, r_LowerValueFragment,
										r_Output[r_QueryTile].r_Pair[r_ColumnTile * 2]);
					Fragment::Mma<bFp8>(r_ProbabilityFragment, r_UpperValueFragment,
										r_Output[r_QueryTile].r_Pair[r_ColumnTile * 2 + 1]);
				}
		if (g_KeyTile + 2 < r_TileCoordinates.g_KeyTiles)
		{
			WaitPredecessor(r_Parameters.g_PredecessorCounters, (g_KeyTile + 2) / 2, 1, r_TileCoordinates);
			StageKeyValue<bFp8>(s_Storage, r_Parameters.g_Key, r_Parameters.g_Value, g_KeyTile + 2,
								r_TileCoordinates);
		}
		if (g_KeyTile + 1 < r_TileCoordinates.g_KeyTiles)
			WaitKeyValue<bFp8>(s_Storage, g_KeyTile + 1);
	}

	const uint32_t r_InverseDenominator =
		CorrectDenominator(r_Denominator, r_TileCoordinates.g_KeyTiles * 64 - g_Tokens);
#pragma unroll
	for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
	{
#pragma unroll
		for (int r_Half = 0; r_Half < 2; ++r_Half)
		{
			const int r_QueryRow = r_QueryTile * 16 + r_TileCoordinates.r_Lane / 4 + r_Half * 8;
			const uint32_t r_InverseDenominatorPair =
				ShuffleIdx(r_InverseDenominator, r_QueryRow % 32, 31, 0xffffffffu);
			const uint16_t r_InverseDenominatorHalf =
				uint16_t(r_InverseDenominatorPair >> ((r_QueryRow / 32) * 16));
			const uint32_t r_QueryNormalization =
				JoinHalfwords(r_InverseDenominatorHalf, r_InverseDenominatorHalf);
#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
				r_Output[r_QueryTile].r_Pair[r_ColumnTile][r_Half] =
					HalfMul(r_Output[r_QueryTile].r_Pair[r_ColumnTile][r_Half], r_QueryNormalization);
		}
		const int g_Group =
			r_TileCoordinates.g_QueryBlock256 * 16 + r_TileCoordinates.r_Warp * 4 + r_QueryTile;
		if (g_Group < r_TileCoordinates.g_Groups16)
#pragma unroll
			for (int r_Chunk = 0; r_Chunk < Profile::QueryChunks; ++r_Chunk)
			{
				const auto r_OutputFragment = Fragment::PublishChunk<bFp8>(r_Output[r_QueryTile], r_Chunk);
				StoreNoAllocate(r_Parameters.g_Output + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
									r_TileCoordinates.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 +
									r_TileCoordinates.r_Lane * 16,
								make_uint4(r_OutputFragment.r_Word[0], r_OutputFragment.r_Word[1],
										   r_OutputFragment.r_Word[2], r_OutputFragment.r_Word[3]));
			}
	}
	// Native outputs include a padded last token group. Clear only its invalid
	// rows after all fragment stores, then release the completion counters.
	if (g_PaddedTokens != g_Tokens)
	{
		__syncthreads();
#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
#pragma unroll
			for (int r_Half = 0; r_Half < 2; ++r_Half)
			{
				const int g_Group =
					r_TileCoordinates.g_QueryBlock256 * 16 + r_TileCoordinates.r_Warp * 4 + r_QueryTile;
				const int g_Row = g_Group * 16 + r_TileCoordinates.r_Lane / 4 + r_Half * 8;
				if (g_Row >= g_Tokens && g_Row < g_PaddedTokens)
#pragma unroll
					for (int r_Chunk = 0; r_Chunk < Profile::QueryChunks; ++r_Chunk)
#pragma unroll
						for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
							*reinterpret_cast<uint32_t*>(
								r_Parameters.g_Output + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
								r_TileCoordinates.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 +
								r_TileCoordinates.r_Lane * 16 + (r_ColumnTile * 2 + r_Half) * 4) = 0;
			}
	}
	__syncthreads();
	if (r_Parameters.g_CompletionCounters && r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
#pragma unroll
		for (int g_LocalGroup = 0; g_LocalGroup < 2; ++g_LocalGroup)
		{
			const int g_Group = r_TileCoordinates.g_QueryBlock256 * 2 + g_LocalGroup;
			if (g_Group < r_TileCoordinates.g_QueryBlocks128)
				CounterStoreRelease(
					r_Parameters.g_CompletionCounters + (g_Group * 32 + r_TileCoordinates.g_Head) * 4, 0);
		}
}
#endif
} // namespace dlssnr::kernels::global_attention
