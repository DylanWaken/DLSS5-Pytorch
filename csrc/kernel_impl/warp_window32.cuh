#pragma once
#include "kernel_impl/intrinsics.cuh"
#include "kernel_impl/packed_math.cuh"

// Algorithmic reconstruction of the ordinary one-warp C32 block. Arrays name
// tensor axes, not PTX registers. Every 16-token tile is one physical 4x4 tile;
// its fragment row order is the DLL's order, not a BHWC staging allocation.
namespace dlssnr::kernels::window32
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::packed_math::sm120;
using namespace dlssnr::numerical_constants;
using dlssnr::intrinsics::sm120::DecodeE4;
using dlssnr::intrinsics::sm120::MmaE4;
using dlssnr::intrinsics::sm120::MmaHalf;
using dlssnr::intrinsics::sm120::ShuffleBfly;
using dlssnr::intrinsics::sm120::ShuffleIdx;
using dlssnr::intrinsics::sm120::StoreNoAllocate;
using dlssnr::intrinsics::sm120::TransposeM8n8;

struct FAFragment
{
	uint32_t r_Word[4];
};

// Each word holds channels [8*Column + 2*(Lane%4), +1]. RowHalf selects
// physical rows Lane/4 or Lane/4+8 within the tile's 16 tokens.
template <int Columns> struct FAccumulatorTile
{
	uint32_t r_Pair[Columns / 8][2];
};

template <bool bFp8> struct FProfile
{
	static constexpr int Reduction = bFp8 ? 32 : 16;
	static constexpr int InputChunks = 32 / Reduction;
	static constexpr int TileBytes = bFp8 ? 512 : 1024;
	static constexpr int ContractOffset = bFp8 ? 4096 : 8192;
	static constexpr int FfnScaleOffset = bFp8 ? 8208 : 16400;
	static constexpr int QkvOffset = bFp8 ? 8288 : 16480;
	static constexpr int BiasOffset = bFp8 ? 11360 : 22624;
	static constexpr int HeadScaleOffset = bFp8 ? 19552 : 30816;
	static constexpr int ProjectionOffset = bFp8 ? 19568 : 30832;
	static constexpr int AttentionScaleOffset = bFp8 ? 20592 : 32880;
};

template <bool bFp8> struct FActivationTile
{
	FAFragment r_Reduction[FProfile<bFp8>::InputChunks];
};

template <bool bFp8> struct FWeightTile
{
	uint32_t r_Pair[FProfile<bFp8>::InputChunks][4][2];
};

template <bool bFp8> struct FValueTile
{
	// FP8 pairs the two K8 halves into one word; Half keeps both words.
	uint32_t r_Column[4][bFp8 ? 1 : 2];
};

__device__ __forceinline__ FAFragment Fragment(uint4 r_Words)
{
	return {{r_Words.x, r_Words.y, r_Words.z, r_Words.w}};
}

template <bool bFp8>
__device__ __forceinline__ void Mma(const FAFragment& r_A, const uint32_t (&r_B)[2], uint32_t (&r_C)[2])
{
	if constexpr (bFp8)
		MmaE4(r_C[0], r_C[1], r_A.r_Word[0], r_A.r_Word[1], r_A.r_Word[2], r_A.r_Word[3], r_B[0], r_B[1],
			  r_C[0], r_C[1]);
	else
		MmaHalf(r_C[0], r_C[1], r_A.r_Word[0], r_A.r_Word[1], r_A.r_Word[2], r_A.r_Word[3], r_B[0], r_B[1],
				r_C[0], r_C[1]);
}

template <bool bFp8, int Columns>
__device__ __forceinline__ FAFragment PublishChunk(const FAccumulatorTile<Columns>& r_C, int r_Chunk)
{
	FAFragment r_Result;
#pragma unroll
	for (int r_Half = 0; r_Half < 2; ++r_Half)
#pragma unroll
		for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
		{
			if constexpr (bFp8)
				r_Result.r_Word[2 * r_Half + r_RowHalf] =
					PackHalfPairsE4(r_C.r_Pair[4 * r_Chunk + 2 * r_Half][r_RowHalf],
									r_C.r_Pair[4 * r_Chunk + 2 * r_Half + 1][r_RowHalf]);
			else
				r_Result.r_Word[2 * r_Half + r_RowHalf] = r_C.r_Pair[2 * r_Chunk + r_Half][r_RowHalf];
		}
	return r_Result;
}

template <bool bFp8> __device__ __forceinline__ FActivationTile<bFp8> Publish(const FAccumulatorTile<32>& r_C)
{
	FActivationTile<bFp8> r_Result;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
		r_Result.r_Reduction[r_Chunk] = PublishChunk<bFp8>(r_C, r_Chunk);
	return r_Result;
}

template <bool bFp8>
__device__ __forceinline__ FWeightTile<bFp8> LoadWeights(const unsigned char* g_Matrix, int g_OutputBase,
														 int g_ReductionBase, int r_OutputChannels)
{
	FWeightTile<bFp8> r_Weights;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
#pragma unroll
		for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
		{
			// Both K32 E4 and K16 Half panels contain 32 bytes per output column.
			const int g_Offset =
				(g_ReductionBase / FProfile<bFp8>::Reduction + r_Chunk) * r_OutputChannels * 32 +
				(g_OutputBase / 16 + r_ColumnTile) * 512 + int(threadIdx.x) * 16;
			const uint4 r_Words = __ldca(reinterpret_cast<const uint4*>(g_Matrix + g_Offset));
			r_Weights.r_Pair[r_Chunk][2 * r_ColumnTile][0] = r_Words.x;
			r_Weights.r_Pair[r_Chunk][2 * r_ColumnTile][1] = r_Words.y;
			r_Weights.r_Pair[r_Chunk][2 * r_ColumnTile + 1][0] = r_Words.z;
			r_Weights.r_Pair[r_Chunk][2 * r_ColumnTile + 1][1] = r_Words.w;
		}
	return r_Weights;
}

template <bool bFp8>
__device__ __forceinline__ void Linear32(const FActivationTile<bFp8>& r_Input,
										 const FWeightTile<bFp8>& r_Weights, FAccumulatorTile<32>& r_Output)
{
#pragma unroll
	for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
			Mma<bFp8>(r_Input.r_Reduction[r_Chunk], r_Weights.r_Pair[r_Chunk][r_Column],
					  r_Output.r_Pair[r_Column]);
}

__device__ __forceinline__ uint32_t Activate(uint32_t r_Input)
{
	// Learned-network activation: Half arithmetic and six native rounding points.
	return FfnActivation(r_Input);
}

// A sum with its swapped Half pair produces the same scalar in both lanes.
// Make that invariant explicit so conversion/SFU work is not performed twice.
template <bool bSquareRoot> __device__ __forceinline__ uint32_t InvertReplicatedHalf(uint32_t r_Sum)
{
	const float r_Value = __half2float(__ushort_as_half(uint16_t(r_Sum)));
	const float r_Inverse = bSquareRoot ? dlssnr::intrinsics::sm120::ApproxRsqrt(r_Value)
										: dlssnr::intrinsics::sm120::ApproxRcp(r_Value);
	const uint16_t r_Half = __half_as_ushort(__float2half_rn(r_Inverse));
	return JoinHalfwords(r_Half, r_Half);
}

template <bool bApplyScale>
__device__ __forceinline__ void Normalize(FAccumulatorTile<32>& r_Channels, uint32_t r_Scale)
{
#pragma unroll
	for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
	{
		// Preserve the native contracted square tree: channels 16..31 round
		// before channels 0..15 are fused into them. XORs reduce the four lanes
		// of one token without exchanging tokens or using shared memory.
		const uint32_t r_Low =
			HalfFma(r_Channels.r_Pair[0][r_RowHalf], r_Channels.r_Pair[0][r_RowHalf],
					HalfMul(r_Channels.r_Pair[2][r_RowHalf], r_Channels.r_Pair[2][r_RowHalf]));
		const uint32_t r_High =
			HalfFma(r_Channels.r_Pair[1][r_RowHalf], r_Channels.r_Pair[1][r_RowHalf],
					HalfMul(r_Channels.r_Pair[3][r_RowHalf], r_Channels.r_Pair[3][r_RowHalf]));
		uint32_t r_Sum = HalfAdd(r_High, r_Low);
		r_Sum = HalfAdd(r_Sum, ShuffleBfly(r_Sum, 2, 31, 0xffffffffu));
		r_Sum = HalfAdd(r_Sum, ShuffleBfly(r_Sum, 1, 31, 0xffffffffu));
		r_Sum = HalfAdd(r_Sum, (r_Sum << 16) | (r_Sum >> 16));
		const uint32_t r_Inverse =
			InvertReplicatedHalf<true>(HalfMax(r_Sum, CONST_NORMALIZATION_EPSILON_HALF2));
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			r_Channels.r_Pair[r_Column][r_RowHalf] =
				HalfMul(r_Channels.r_Pair[r_Column][r_RowHalf], r_Inverse);
			if constexpr (bApplyScale)
				r_Channels.r_Pair[r_Column][r_RowHalf] =
					HalfMul(r_Channels.r_Pair[r_Column][r_RowHalf], r_Scale);
		}
	}
}

__device__ __forceinline__ uint32_t AttentionExponential(uint32_t r_Scores)
{
	// The DLL uses a clamped Half affine map and a packed exponent-bit shift.
	// Keeping the whole-word carry is necessary: independently shifting Half
	// lanes changes the high lane unless the native carry compensation is kept.
	const uint32_t r_Affine =
		HalfFma(r_Scores, CONST_WINDOW_EXP_SLOPE_HALF2, CONST_WINDOW_EXP_INTERCEPT_HALF2);
	const uint32_t r_Bounded =
		HalfMin(HalfMax(r_Affine, CONST_WINDOW_EXP_LOWER_HALF2), CONST_WINDOW_EXP_UPPER_HALF2);
	return (r_Bounded << CONST_WINDOW_EXP_ENCODING_SHIFT) + CONST_WINDOW_EXP_ENCODING_OFFSET;
}

__device__ __forceinline__ void Softmax(FAccumulatorTile<64>& r_Scores)
{
#pragma unroll
	for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
	{
#pragma unroll
		for (int r_Column = 0; r_Column < 8; ++r_Column)
			r_Scores.r_Pair[r_Column][r_RowHalf] = AttentionExponential(r_Scores.r_Pair[r_Column][r_RowHalf]);
		uint32_t r_Local = HalfAdd(r_Scores.r_Pair[0][r_RowHalf], r_Scores.r_Pair[1][r_RowHalf]);
#pragma unroll
		for (int r_Column = 2; r_Column < 8; r_Column += 2)
			r_Local = HalfAdd(r_Local, HalfAdd(r_Scores.r_Pair[r_Column][r_RowHalf],
											   r_Scores.r_Pair[r_Column + 1][r_RowHalf]));
		// Native reduction order is lane 0+1, then +2, then +3, then the two
		// Half components. A butterfly here would change Half rounding.
		const uint32_t r_GroupBase = threadIdx.x & ~3u;
		uint32_t r_Total = ShuffleIdx(r_Local, r_GroupBase, 31, 0xffffffffu);
#pragma unroll
		for (int r_Lane = 1; r_Lane < 4; ++r_Lane)
			r_Total = HalfAdd(r_Total, ShuffleIdx(r_Local, r_GroupBase + r_Lane, 31, 0xffffffffu));
		r_Total = HalfAdd(r_Total, (r_Total << 16) | (r_Total >> 16));
		const uint32_t r_Inverse =
			InvertReplicatedHalf<false>(HalfMax(r_Total, CONST_NORMALIZATION_EPSILON_HALF2));
#pragma unroll
		for (int r_Column = 0; r_Column < 8; ++r_Column)
			r_Scores.r_Pair[r_Column][r_RowHalf] = HalfMul(r_Scores.r_Pair[r_Column][r_RowHalf], r_Inverse);
	}
}

__device__ __forceinline__ void PermuteRowSums(uint32_t (&r_Sums)[4], int r_Permutation)
{
// XOR permutation in two swap levels: retain fixed array indices so all
// four partial sums stay in registers during the lane-ownership transpose.
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const uint32_t r_Low = r_Sums[2 * r_Pair], r_High = r_Sums[2 * r_Pair + 1];
		r_Sums[2 * r_Pair] = (r_Permutation & 1) ? r_High : r_Low;
		r_Sums[2 * r_Pair + 1] = (r_Permutation & 1) ? r_Low : r_High;
	}
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const uint32_t r_Low = r_Sums[r_Pair], r_High = r_Sums[r_Pair + 2];
		r_Sums[r_Pair] = (r_Permutation & 2) ? r_High : r_Low;
		r_Sums[r_Pair + 2] = (r_Permutation & 2) ? r_Low : r_High;
	}
}

__device__ __forceinline__ void SoftmaxPair(FAccumulatorTile<64> (&r_Scores)[2])
{
	// Native window32.ptx lines 10665..10855 reduce two adjacent query tiles
	// together. Four row halves fill all 32 lanes with one complete row sum
	// each; independent tiles would repeat the same denominator in four lanes.
	const int r_Lane = threadIdx.x;
	uint32_t r_Local[4];
#pragma unroll
	for (int r_Row = 0; r_Row < 4; ++r_Row)
	{
		auto& r_Pairs = r_Scores[r_Row / 2].r_Pair;
		const int r_RowHalf = r_Row & 1;
#pragma unroll
		for (int r_Column = 0; r_Column < 8; ++r_Column)
			r_Pairs[r_Column][r_RowHalf] = AttentionExponential(r_Pairs[r_Column][r_RowHalf]);
		uint32_t r_Sum = HalfAdd(r_Pairs[0][r_RowHalf], r_Pairs[1][r_RowHalf]);
#pragma unroll
		for (int r_Column = 2; r_Column < 8; r_Column += 2)
			r_Sum = HalfAdd(r_Sum, HalfAdd(r_Pairs[r_Column][r_RowHalf], r_Pairs[r_Column + 1][r_RowHalf]));
		r_Local[r_Row] = r_Sum;
	}

	// Lane L owns row L: its original MMA row group is L%8 and its row-half
	// index is L/8. Transpose with four shuffles, then restore source lanes
	// 0,1,2,3 before adding so the native Half rounding order is unchanged.
	PermuteRowSums(r_Local, r_Lane & 3);
	const int r_SourceLane = ((r_Lane & 7) << 2) | (r_Lane >> 3);
	uint32_t r_Gathered[4];
#pragma unroll
	for (int r_Row = 0; r_Row < 4; ++r_Row)
		r_Gathered[r_Row] = ShuffleIdx(r_Local[r_Row], r_SourceLane ^ r_Row, 31, 0xffffffffu);
	PermuteRowSums(r_Gathered, r_Lane >> 3);
	uint32_t r_Total = HalfAdd(r_Gathered[0], r_Gathered[1]);
	r_Total = HalfAdd(r_Total, r_Gathered[2]);
	r_Total = HalfAdd(r_Total, r_Gathered[3]);
	r_Total = HalfAdd(r_Total, (r_Total << 16) | (r_Total >> 16));
	const uint32_t r_Inverse =
		InvertReplicatedHalf<false>(HalfMax(r_Total, CONST_NORMALIZATION_EPSILON_HALF2));

#pragma unroll
	for (int r_Row = 0; r_Row < 4; ++r_Row)
	{
		// One inverse per query row returns to all four MMA column lanes.
		const uint32_t r_RowInverse = ShuffleIdx(r_Inverse, r_Row * 8 + r_Lane / 4, 31, 0xffffffffu);
#pragma unroll
		for (int r_Column = 0; r_Column < 8; ++r_Column)
			r_Scores[r_Row / 2].r_Pair[r_Column][r_Row & 1] =
				HalfMul(r_Scores[r_Row / 2].r_Pair[r_Column][r_Row & 1], r_RowInverse);
	}
}

template <bool bFp8>
__device__ __forceinline__ FAccumulatorTile<64> QueryKeyScores(int r_Tile, const unsigned char* g_HeadBias,
															   const FActivationTile<bFp8> (&r_Query)[4],
															   const FActivationTile<bFp8> (&r_Key)[4])
{
	FAccumulatorTile<64> r_Scores;
#pragma unroll
	for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
	{
		const int g_BiasOffset = 2048 * r_Tile + 512 * r_ColumnTile + int(threadIdx.x) * 16;
		const uint4 r_Bias = __ldca(reinterpret_cast<const uint4*>(g_HeadBias + g_BiasOffset));
		r_Scores.r_Pair[2 * r_ColumnTile][0] = r_Bias.x;
		r_Scores.r_Pair[2 * r_ColumnTile][1] = r_Bias.y;
		r_Scores.r_Pair[2 * r_ColumnTile + 1][0] = r_Bias.z;
		r_Scores.r_Pair[2 * r_ColumnTile + 1][1] = r_Bias.w;
	}
#pragma unroll
	for (int r_Column = 0; r_Column < 8; ++r_Column)
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
		{
			const auto& r_Keys = r_Key[r_Column / 2].r_Reduction[r_Chunk];
			const uint32_t r_B[2] = {r_Keys.r_Word[r_Column & 1], r_Keys.r_Word[2 + (r_Column & 1)]};
			Mma<bFp8>(r_Query[r_Tile].r_Reduction[r_Chunk], r_B, r_Scores.r_Pair[r_Column]);
		}
	return r_Scores;
}

template <bool bFp8>
__device__ __forceinline__ FAccumulatorTile<32> ProbabilityValues(const FAccumulatorTile<64>& r_Probabilities,
																  const FValueTile<bFp8> (&r_Value)[4])
{
	FAccumulatorTile<32> r_Attended{};
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < 64 / FProfile<bFp8>::Reduction; ++r_Chunk)
	{
		const auto r_Probability = PublishChunk<bFp8>(r_Probabilities, r_Chunk);
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			uint32_t r_B[2];
			if constexpr (bFp8)
			{
				r_B[0] = r_Value[2 * r_Chunk].r_Column[r_Column][0];
				r_B[1] = r_Value[2 * r_Chunk + 1].r_Column[r_Column][0];
			}
			else
			{
				r_B[0] = r_Value[r_Chunk].r_Column[r_Column][0];
				r_B[1] = r_Value[r_Chunk].r_Column[r_Column][1];
			}
			Mma<bFp8>(r_Probability, r_B, r_Attended.r_Pair[r_Column]);
		}
	}
	return r_Attended;
}

struct FOrdinaryIO
{
	static constexpr bool bCustomInput = false;
	static constexpr bool bCustomOutput = false;
	static constexpr bool bRawResidual = false;
	template <bool bPrecision> using FRecordProfile = FProfile<bPrecision>;
};

template <bool bFp8, class FParameters, class FIO = FOrdinaryIO, bool bCaptureRaw = false>
__device__ __forceinline__ void RunWindow32(const FParameters& r_Parameters,
											FAccumulatorTile<32>* r_RawTiles = nullptr)
{
	using FConfig = typename FIO::template FRecordProfile<bFp8>;
	const unsigned char* g_Record = reinterpret_cast<const unsigned char*>(r_Parameters.g_Record);
	FActivationTile<bFp8> r_Input[4];
	FAccumulatorTile<32> r_Ffn[4];
	uint32_t r_FfnScale[4], r_AttentionScale[4];
#pragma unroll
	for (int r_Column = 0; r_Column < 4; ++r_Column)
	{
		const int g_ChannelByte = 16 * r_Column + 4 * (threadIdx.x & 3);
		r_FfnScale[r_Column] =
			*reinterpret_cast<const uint32_t*>(g_Record + FConfig::FfnScaleOffset + g_ChannelByte);
		r_AttentionScale[r_Column] =
			*reinterpret_cast<const uint32_t*>(g_Record + FConfig::AttentionScaleOffset + g_ChannelByte);
	}

// Coalesced physical-tile input. Singleton dimensions broadcast the one
// available tile for reads, as the native entry does; writes remain bounded.
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		if constexpr (FIO::bCustomInput)
			r_Input[r_Tile] = FIO::Read(r_Parameters, r_Tile);
		else
		{
			const unsigned char* g_State = reinterpret_cast<const unsigned char*>(r_Parameters.g_State);
			const int g_TileColumns = r_Parameters.Width / 4, g_TileRows = r_Parameters.Height / 4;
			const int g_OriginTileX = (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 4;
			const int g_OriginTileY = (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 4;
			const int g_TileX = g_TileColumns == 1 ? 0 : g_OriginTileX + (r_Tile & 1);
			const int g_TileY = g_TileRows == 1 ? 0 : g_OriginTileY + (r_Tile >> 1);
			const bool r_bValid =
				g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows;
#pragma unroll
			for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
			{
				const int64_t g_Offset = int64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
										 r_Chunk * 512 + int(threadIdx.x) * 16;
				r_Input[r_Tile].r_Reduction[r_Chunk] =
					Fragment(r_bValid ? __ldcg(reinterpret_cast<const uint4*>(g_State + g_Offset))
									  : make_uint4(0, 0, 0, 0));
			}
		}
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				uint32_t r_Value;
				if constexpr (FIO::bRawResidual)
					r_Value = FIO::Residual(r_Parameters, r_Tile, r_Column, r_RowHalf);
				else if constexpr (bFp8)
					r_Value = DecodeE4(
						uint16_t(r_Input[r_Tile].r_Reduction[0].r_Word[2 * (r_Column / 2) + r_RowHalf] >>
								 (16 * (r_Column & 1))));
				else
					r_Value =
						r_Input[r_Tile].r_Reduction[r_Column / 2].r_Word[2 * (r_Column & 1) + r_RowHalf];
				r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf] = HalfMul(r_Value, r_FfnScale[r_Column]);
			}
	}

// Stream four 32-channel hidden panels through 32→128→32; the contraction
// seed is the scaled input, and its reduction chunks stay in native order.
#pragma unroll
	for (int r_Hidden = 0; r_Hidden < 4; ++r_Hidden)
	{
		const FWeightTile<bFp8> r_Expand = LoadWeights<bFp8>(g_Record, 32 * r_Hidden, 0, 128);
		const FWeightTile<bFp8> r_Contract =
			LoadWeights<bFp8>(g_Record + FConfig::ContractOffset, 0, 32 * r_Hidden, 32);
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			FAccumulatorTile<32> r_HiddenTile{};
			Linear32(r_Input[r_Tile], r_Expand, r_HiddenTile);
#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_HiddenTile.r_Pair[r_Column][r_RowHalf] =
						Activate(r_HiddenTile.r_Pair[r_Column][r_RowHalf]);
			Linear32(Publish<bFp8>(r_HiddenTile), r_Contract, r_Ffn[r_Tile]);
		}
	}
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		r_Input[r_Tile] = Publish<bFp8>(r_Ffn[r_Tile]);

	FActivationTile<bFp8> r_Query[4], r_Key[4];
	FValueTile<bFp8> r_Value[4];
	const uint32_t r_HeadScale =
		FloatToHalf2(*reinterpret_cast<const uint32_t*>(g_Record + FConfig::HeadScaleOffset));
#pragma unroll
	for (int r_Projection = 0; r_Projection < 3; ++r_Projection)
	{
		const FWeightTile<bFp8> r_Weights =
			LoadWeights<bFp8>(g_Record + FConfig::QkvOffset, 32 * r_Projection, 0, 96);
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			FAccumulatorTile<32> r_Projected{};
			Linear32(r_Input[r_Tile], r_Weights, r_Projected);
			if (r_Projection < 2)
			{
				if (r_Projection == 0)
					Normalize<true>(r_Projected, r_HeadScale);
				else
					Normalize<false>(r_Projected, CONST_HALF2_ONE);
				if (r_Projection == 0)
					r_Query[r_Tile] = Publish<bFp8>(r_Projected);
				else
					r_Key[r_Tile] = Publish<bFp8>(r_Projected);
			}
			else
#pragma unroll
				for (int r_Column = 0; r_Column < 4; ++r_Column)
				{
					const uint32_t r_LowRows = TransposeM8n8(r_Projected.r_Pair[r_Column][0]);
					const uint32_t r_HighRows = TransposeM8n8(r_Projected.r_Pair[r_Column][1]);
					if constexpr (bFp8)
						r_Value[r_Tile].r_Column[r_Column][0] = PackHalfPairsE4(r_LowRows, r_HighRows);
					else
					{
						r_Value[r_Tile].r_Column[r_Column][0] = r_LowRows;
						r_Value[r_Tile].r_Column[r_Column][1] = r_HighRows;
					}
				}
		}
	}

	const FWeightTile<bFp8> r_OutputWeights =
		LoadWeights<bFp8>(g_Record + FConfig::ProjectionOffset, 0, 0, 32);
	// FP8 follows the native two-query-tile softmax schedule. Keep the tested
	// FP16 schedule independent until its register pressure is measured.
	constexpr int CONST_QUERY_TILE_BATCH = bFp8 ? 2 : 1;
#pragma unroll
	for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += CONST_QUERY_TILE_BATCH)
	{
		FAccumulatorTile<64> r_Probabilities[CONST_QUERY_TILE_BATCH];
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
			r_Probabilities[r_LocalTile] = QueryKeyScores<bFp8>(
				r_FirstTile + r_LocalTile, g_Record + FConfig::BiasOffset, r_Query, r_Key);
		if constexpr (bFp8)
			SoftmaxPair(r_Probabilities);
		else
			Softmax(r_Probabilities[0]);

#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
		{
			const int r_Tile = r_FirstTile + r_LocalTile;
			const auto r_Attended = ProbabilityValues<bFp8>(r_Probabilities[r_LocalTile], r_Value);
#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf] =
						HalfMul(r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf], r_AttentionScale[r_Column]);
			Linear32(Publish<bFp8>(r_Attended), r_OutputWeights, r_Ffn[r_Tile]);
			if constexpr (bCaptureRaw)
				r_RawTiles[r_Tile] = r_Ffn[r_Tile];

			if constexpr (FIO::bCustomOutput)
				FIO::Write(r_Parameters, r_Tile, r_Ffn[r_Tile]);
			else
			{
				const int g_TileColumns = r_Parameters.Width / 4, g_TileRows = r_Parameters.Height / 4;
				const int g_OriginTileX = (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 4;
				const int g_OriginTileY = (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 4;
				const int g_TileX = g_OriginTileX + (r_Tile & 1), g_TileY = g_OriginTileY + (r_Tile >> 1);
				if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
				{
#pragma unroll
					for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
					{
						const FAFragment r_Output = PublishChunk<bFp8>(r_Ffn[r_Tile], r_Chunk);
						const uint64_t g_OutputAddress =
							r_Parameters.g_High +
							uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes + r_Chunk * 512 +
							int(threadIdx.x) * 16;
						StoreNoAllocate(g_OutputAddress, make_uint4(r_Output.r_Word[0], r_Output.r_Word[1],
																	r_Output.r_Word[2], r_Output.r_Word[3]));
					}
				}
			}
		}
	}
}
#endif
} // namespace dlssnr::kernels::window32
