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
												const FCoordinates& Tile)
{
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
		for (int g_Group = g_FirstGroup; g_Group < g_FirstGroup + g_Count && g_Group < Tile.g_QueryBlocks128;
			 ++g_Group)
			while (int32_t(CounterLoadRelaxed(g_Counters + (g_Group * 16 + Tile.g_Head / 2) * 4)) < 0)
				PollSleep(64);
	__syncthreads();
}

template <bool bFp8>
__device__ __forceinline__ void StageKeyValue(unsigned char* s_Storage, uint64_t g_Key, uint64_t g_Value,
											  int g_KeyTile, const FCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const int s_Stage = (g_KeyTile & 1) * Profile::s_StageBytes;
	const int s_Barrier = Profile::s_BarrierOffset + (g_KeyTile & 1) * 8;
#pragma unroll
	for (int r_Copy = 0; r_Copy < Profile::QueryChunks; ++r_Copy)
	{
		const int r_Slot = Tile.r_Warp + r_Copy * 4;
		int g_KeyGroup = g_KeyTile * 4 + r_Slot / Profile::QueryChunks;
		if constexpr (!bFp8)
			if (uint32_t(Tile.g_Tokens + 14) < 31)
				g_KeyGroup = 0;
		const int g_KeyChunk = r_Slot % Profile::QueryChunks;
		const uint64_t g_KeyAddress = g_Key + uint64_t(g_KeyGroup) * 16384 * Profile::ElementBytes +
									  Tile.g_Head * 512 * Profile::ElementBytes + g_KeyChunk * 512;
		const int s_Copy = s_Stage + r_Slot * 512;
		if (g_KeyGroup < Tile.g_Groups16)
		{
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_Copy, g_KeyAddress, 512, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_Copy + Tile.r_Lane * 16) = make_uint4(0, 0, 0, 0);
	}
#pragma unroll
	for (int r_Copy = 0; r_Copy < Profile::QueryChunks; ++r_Copy)
	{
		const int r_Slot = Tile.r_Warp + r_Copy * 4;
		int g_KeyGroup = g_KeyTile * 4 + r_Slot / Profile::QueryChunks;
		if constexpr (!bFp8)
			if (uint32_t(Tile.g_Tokens + 14) < 31)
				g_KeyGroup = 0;
		const int s_Copy = s_Stage + r_Slot * 512;
		// V has transposed fragments. FP8 stores two neighboring M16 tiles
		// in one M32 group; Half stores one M16 group with two N16 panels.
		int g_ValueGroup = bFp8 ? g_KeyTile * 2 + r_Slot / 2 : g_KeyGroup;
		const int g_ValueGroups = bFp8 ? Tile.g_Groups16 / 2 : Tile.g_Groups16;
		if constexpr (bFp8)
			if (g_ValueGroups == 1)
				g_ValueGroup = 0;
		const uint64_t g_ValueAddress =
			g_Value + uint64_t(g_ValueGroup) * 32768 + Tile.g_Head * 1024 + (r_Slot & 1) * 512;
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
			*reinterpret_cast<uint4*>(s_Storage + s_ValueCopy + Tile.r_Lane * 16) = make_uint4(0, 0, 0, 0);
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

__device__ __forceinline__ void PermuteQuad(uint32_t (&r_Words)[4], int r_Permutation)
{
	// Two conditional swap levels implement Words[i] = Words[i XOR p].
	// Fixed indices keep the quartet in registers during the warp transpose.
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const uint32_t r_Low = r_Words[r_Pair * 2], r_High = r_Words[r_Pair * 2 + 1];
		r_Words[r_Pair * 2] = (r_Permutation & 1) ? r_High : r_Low;
		r_Words[r_Pair * 2 + 1] = (r_Permutation & 1) ? r_Low : r_High;
	}
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const uint32_t r_Low = r_Words[r_Pair], r_High = r_Words[r_Pair + 2];
		r_Words[r_Pair] = (r_Permutation & 2) ? r_High : r_Low;
		r_Words[r_Pair + 2] = (r_Permutation & 2) ? r_Low : r_High;
	}
}

__device__ __forceinline__ uint32_t SumProbabilities(const Fragment::FAccumulatorTile<64> (&r_Probability)[4],
													 int r_Lane)
{
	uint32_t r_QuerySums[2];
#pragma unroll
	for (int r_QueryHalf = 0; r_QueryHalf < 2; ++r_QueryHalf)
	{
		uint32_t r_Local[4], r_Gathered[4];
#pragma unroll
		for (int r_Row = 0; r_Row < 4; ++r_Row)
		{
			const auto& r_Pairs = r_Probability[r_QueryHalf * 2 + r_Row / 2].r_Pair;
			const int r_Half = r_Row & 1;
			uint32_t r_Sum = HalfAdd(HalfAdd(r_Pairs[0][r_Half], r_Pairs[1][r_Half]),
									 HalfAdd(r_Pairs[2][r_Half], r_Pairs[3][r_Half]));
			r_Sum = HalfAdd(r_Sum, HalfAdd(r_Pairs[4][r_Half], r_Pairs[5][r_Half]));
			r_Local[r_Row] = HalfAdd(r_Sum, HalfAdd(r_Pairs[6][r_Half], r_Pairs[7][r_Half]));
		}
		// This warp transpose turns the MMA fragment's channel ownership
		// into one full query sum per lane, without changing Half add order.
		const int r_SourceLane = ((r_Lane & 7) << 2) + (r_Lane >> 3);
		PermuteQuad(r_Local, r_Lane & 3);
#pragma unroll
		for (int r_Row = 0; r_Row < 4; ++r_Row)
			r_Gathered[r_Row] = ShuffleIdx(r_Local[r_Row], r_SourceLane ^ r_Row, 31, 0xffffffffu);
		PermuteQuad(r_Gathered, r_Lane >> 3);
		uint32_t r_Sum = HalfAdd(r_Gathered[0], r_Gathered[1]);
		r_Sum = HalfAdd(r_Sum, r_Gathered[2]);
		r_Sum = HalfAdd(r_Sum, r_Gathered[3]);
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
__device__ __forceinline__ void RunGlobalAttention(TParameters Parameters, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8>;
	const int g_Tokens = Parameters.Batch * Parameters.Tokens;
	const int g_Alignment = bFp8 ? 32 : 16;
	const int g_PaddedTokens = ((g_Tokens + g_Alignment - 1) / g_Alignment) * g_Alignment;
	const FCoordinates Tile{
		g_Tokens,		 g_PaddedTokens,  g_PaddedTokens / 16, (g_Tokens + 63) / 64, (g_Tokens + 127) / 128,
		int(blockIdx.x), int(blockIdx.y), int(threadIdx.x),	   int(threadIdx.y)};
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < 2; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();
	WaitPredecessor(Parameters.g_PredecessorCounter, Tile.g_QueryBlock256 * 2, 2, Tile);

	Fragment::FAFragment r_Query[4][Profile::QueryChunks];
#pragma unroll
	for (int r_M = 0; r_M < 4; ++r_M)
#pragma unroll
		for (int r_K = 0; r_K < Profile::QueryChunks; ++r_K)
		{
			int g_Group = Tile.g_QueryBlock256 * 16 + Tile.r_Warp * 4 + r_M;
			if constexpr (!bFp8)
				if (uint32_t(g_Tokens + 14) < 31)
					g_Group = 0;
			const uint64_t g_Address = Parameters.g_Q + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
									   Tile.g_Head * 512 * Profile::ElementBytes + r_K * 512 +
									   Tile.r_Lane * 16;
			r_Query[r_M][r_K] = Fragment::Fragment(g_Group < Tile.g_Groups16
													   ? __ldca(reinterpret_cast<const uint4*>(g_Address))
													   : make_uint4(0, 0, 0, 0));
		}
#pragma unroll
	for (int g_KeyTile = 0; g_KeyTile < 2; ++g_KeyTile)
		if (g_KeyTile < Tile.g_KeyTiles)
		{
			WaitPredecessor(Parameters.g_PredecessorCounter, g_KeyTile / 2, 1, Tile);
			StageKeyValue<bFp8>(s_Storage, Parameters.g_K, Parameters.g_V, g_KeyTile, Tile);
		}
	if (Tile.g_KeyTiles > 0)
		WaitKeyValue<bFp8>(s_Storage, 0);
	Fragment::FAccumulatorTile<32> r_Output[4]{};
	uint32_t r_Denominator = 0;

#pragma unroll 1
	for (int g_KeyTile = 0; g_KeyTile < Tile.g_KeyTiles; ++g_KeyTile)
	{
		const int s_Base = (g_KeyTile & 1) * Profile::s_StageBytes + Tile.r_Lane * 16;
		uint4 r_Key[4][Profile::QueryChunks];
#pragma unroll
		for (int r_N = 0; r_N < 4; ++r_N)
#pragma unroll
			for (int r_K = 0; r_K < Profile::QueryChunks; ++r_K)
				r_Key[r_N][r_K] = *reinterpret_cast<const uint4*>(s_Storage + s_Base +
																  (r_N * Profile::QueryChunks + r_K) * 512);
		Fragment::FAccumulatorTile<64> r_Probability[4]{};
#pragma unroll
		for (int r_M = 0; r_M < 4; ++r_M)
#pragma unroll
			for (int r_N = 0; r_N < 8; ++r_N)
			{
#pragma unroll
				for (int r_K = 0; r_K < Profile::QueryChunks; ++r_K)
				{
					const uint4 r_Vector = r_Key[r_N / 2][r_K];
					const uint32_t r_B[2] = {r_N & 1 ? r_Vector.z : r_Vector.x,
											 r_N & 1 ? r_Vector.w : r_Vector.y};
					Fragment::Mma<bFp8>(r_Query[r_M][r_K], r_B, r_Probability[r_M].r_Pair[r_N]);
				}
#pragma unroll
				for (int r_Half = 0; r_Half < 2; ++r_Half)
					r_Probability[r_M].r_Pair[r_N][r_Half] =
						ExponentialSurrogate(r_Probability[r_M].r_Pair[r_N][r_Half]);
			}
		r_Denominator = HalfAdd(r_Denominator, SumProbabilities(r_Probability, Tile.r_Lane));

		uint4 r_Value[Profile::ProbabilityChunks][2];
#pragma unroll
		for (int r_K = 0; r_K < Profile::ProbabilityChunks; ++r_K)
#pragma unroll
			for (int r_N = 0; r_N < 2; ++r_N)
				r_Value[r_K][r_N] = *reinterpret_cast<const uint4*>(s_Storage + Profile::s_ValueOffset +
																	s_Base + (r_K * 2 + r_N) * 512);
#pragma unroll
		for (int r_M = 0; r_M < 4; ++r_M)
#pragma unroll
			for (int r_N = 0; r_N < 2; ++r_N)
#pragma unroll
				for (int r_K = 0; r_K < Profile::ProbabilityChunks; ++r_K)
				{
					const auto r_A = Fragment::PublishChunk<bFp8>(r_Probability[r_M], r_K);
					const uint4 r_Vector = r_Value[r_K][r_N];
					const uint32_t r_B0[2] = {r_Vector.x, r_Vector.y}, r_B1[2] = {r_Vector.z, r_Vector.w};
					Fragment::Mma<bFp8>(r_A, r_B0, r_Output[r_M].r_Pair[r_N * 2]);
					Fragment::Mma<bFp8>(r_A, r_B1, r_Output[r_M].r_Pair[r_N * 2 + 1]);
				}
		if (g_KeyTile + 2 < Tile.g_KeyTiles)
		{
			WaitPredecessor(Parameters.g_PredecessorCounter, (g_KeyTile + 2) / 2, 1, Tile);
			StageKeyValue<bFp8>(s_Storage, Parameters.g_K, Parameters.g_V, g_KeyTile + 2, Tile);
		}
		if (g_KeyTile + 1 < Tile.g_KeyTiles)
			WaitKeyValue<bFp8>(s_Storage, g_KeyTile + 1);
	}

	const uint32_t r_Inverse = CorrectDenominator(r_Denominator, Tile.g_KeyTiles * 64 - g_Tokens);
#pragma unroll
	for (int r_M = 0; r_M < 4; ++r_M)
	{
#pragma unroll
		for (int r_Half = 0; r_Half < 2; ++r_Half)
		{
			const int r_QueryRow = r_M * 16 + Tile.r_Lane / 4 + r_Half * 8;
			const uint32_t r_InvPair = ShuffleIdx(r_Inverse, r_QueryRow % 32, 31, 0xffffffffu);
			const uint16_t r_InvHalf = uint16_t(r_InvPair >> ((r_QueryRow / 32) * 16));
			const uint32_t r_Scale = JoinHalfwords(r_InvHalf, r_InvHalf);
#pragma unroll
			for (int r_N = 0; r_N < 4; ++r_N)
				r_Output[r_M].r_Pair[r_N][r_Half] = HalfMul(r_Output[r_M].r_Pair[r_N][r_Half], r_Scale);
		}
		const int g_Group = Tile.g_QueryBlock256 * 16 + Tile.r_Warp * 4 + r_M;
		if (g_Group < Tile.g_Groups16)
#pragma unroll
			for (int r_Chunk = 0; r_Chunk < Profile::QueryChunks; ++r_Chunk)
			{
				const auto r_Packed = Fragment::PublishChunk<bFp8>(r_Output[r_M], r_Chunk);
				StoreNoAllocate(Parameters.g_High + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
									Tile.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 +
									Tile.r_Lane * 16,
								make_uint4(r_Packed.r_Word[0], r_Packed.r_Word[1], r_Packed.r_Word[2],
										   r_Packed.r_Word[3]));
			}
	}
	// Native outputs include a padded last token group. Clear only its invalid
	// rows after all fragment stores, then release the completion counters.
	if (g_PaddedTokens != g_Tokens)
	{
		__syncthreads();
#pragma unroll
		for (int r_M = 0; r_M < 4; ++r_M)
#pragma unroll
			for (int r_Half = 0; r_Half < 2; ++r_Half)
			{
				const int g_Group = Tile.g_QueryBlock256 * 16 + Tile.r_Warp * 4 + r_M;
				const int g_Row = g_Group * 16 + Tile.r_Lane / 4 + r_Half * 8;
				if (g_Row >= g_Tokens && g_Row < g_PaddedTokens)
#pragma unroll
					for (int r_Chunk = 0; r_Chunk < Profile::QueryChunks; ++r_Chunk)
#pragma unroll
						for (int r_N = 0; r_N < 2; ++r_N)
							*reinterpret_cast<uint32_t*>(
								Parameters.g_High + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
								Tile.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 + Tile.r_Lane * 16 +
								(r_N * 2 + r_Half) * 4) = 0;
			}
	}
	__syncthreads();
	if (Parameters.g_CompletionCounter && Tile.r_Lane == 0 && Tile.r_Warp == 0)
#pragma unroll
		for (int g_LocalGroup = 0; g_LocalGroup < 2; ++g_LocalGroup)
		{
			const int g_Group = Tile.g_QueryBlock256 * 2 + g_LocalGroup;
			if (g_Group < Tile.g_QueryBlocks128)
				CounterStoreRelease(Parameters.g_CompletionCounter + (g_Group * 32 + Tile.g_Head) * 4, 0);
		}
}
#endif
} // namespace dlssnr::kernels::global_attention
