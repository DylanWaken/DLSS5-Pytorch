#pragma once
#include "warp_window32.cuh"

// The wide blocks share tensor operations, but not one ownership schedule.
// C64 computes its FFN over two token tiles per warp. C128/C256 distribute
// FFN experts between warps and exchange published C32 panels through shared.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

template <int Channels, bool bFp8> struct FWideWindowProfile
{
	static_assert(Channels == 64 || Channels == 128 || Channels == 256);
	static constexpr int Heads = Channels / 32;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int Chunks = FWindow32Profile<bFp8>::InputChunks;
	static constexpr int PanelBytes = FWindow32Profile<bFp8>::TileBytes;
	static constexpr int TileBytes = Heads * PanelBytes;
	static constexpr int ExpertExpandBytes = Channels * 128 * ElementBytes;
	static constexpr int ExpertContractBytes = 128 * 32 * ElementBytes;
	static constexpr int ContractOffset = Heads * ExpertExpandBytes;
	static constexpr int MixOffset = ContractOffset + Heads * ExpertContractBytes;
	static constexpr int FfnScaleOffset = MixOffset + Channels * Channels * ElementBytes + 16;
	static constexpr int QkvOffset = FfnScaleOffset + 2 * Channels + 16;
	static constexpr int BiasOffset = QkvOffset + 3 * Channels * Channels * ElementBytes;
	static constexpr int HeadScaleOffset = BiasOffset + Heads * 8192;
	static constexpr int ProjectionOffset = HeadScaleOffset + ((Heads * 4 + 15) / 16) * 16;
	static constexpr int AttentionScaleOffset = ProjectionOffset + Channels * Channels * ElementBytes;

	// Native C256 keeps all four query tiles until the projection exchange;
	// C64/C128 reuse the shared slab twice, for two query tiles at a time.
	static constexpr int AttentionBatch = Channels == 256 ? 4 : 2;
};

template <int Channels, bool bFp8> struct FSharedWindow
{
	using FConfig = FWideWindowProfile<Channels, bFp8>;

	// A vector is exactly one lane's native A fragment. No BHWC conversion or
	// bank swizzle occurs in the FP8 ordinary block's exchange layout.
	uint4 s_Tile[4][FConfig::Heads][FConfig::Chunks][32];

	__device__ __forceinline__ FWindowActivationTile<bFp8> Load(int s_TileIndex, int s_PanelIndex) const
	{
		FWindowActivationTile<bFp8> r_ActivationTile;
		#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
			r_ActivationTile.r_Reduction[r_Chunk] =
				MakeWindowFragment(s_Tile[s_TileIndex][s_PanelIndex][r_Chunk][threadIdx.x]);
		return r_ActivationTile;
	}

	__device__ __forceinline__ void Store(int s_TileIndex, int s_PanelIndex,
										  const FWindowActivationTile<bFp8>& r_Activation)
	{
		#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
		{
			const auto& r_Fragment = r_Activation.r_Reduction[r_Chunk];
			s_Tile[s_TileIndex][s_PanelIndex][r_Chunk][threadIdx.x] = make_uint4(
				r_Fragment.r_Word[0], r_Fragment.r_Word[1], r_Fragment.r_Word[2], r_Fragment.r_Word[3]);
		}
	}
};

template <bool bFp8, int Tiles, int Panels> struct FRegisterWindow
{
	FWindowActivationTile<bFp8> r_Tile[Tiles][Panels];

	__device__ __forceinline__ FWindowActivationTile<bFp8> Load(int r_TileIndex, int r_Panel) const
	{
		return r_Tile[r_TileIndex][r_Panel];
	}
};

template <bool bFp8>
__device__ __forceinline__ FWindowAccumulatorTile<32>
ScaledWindowResidual(const FWindowActivationTile<bFp8>& r_Input, const unsigned char* g_Scale,
					 int g_ChannelBase)
{
	FWindowAccumulatorTile<32> r_ScaledResidual;
	#pragma unroll
	for (int r_Column = 0; r_Column < 4; ++r_Column)
	{
		const int g_Offset = 2 * g_ChannelBase + 16 * r_Column + 4 * (threadIdx.x & 3);
		const uint32_t r_Scale = *reinterpret_cast<const uint32_t*>(g_Scale + g_Offset);
		#pragma unroll
		for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
		{
			uint32_t r_ResidualPair;
			if constexpr (bFp8)
				r_ResidualPair = DecodeE4(uint16_t(
					r_Input.r_Reduction[0].r_Word[2 * (r_Column / 2) + r_RowHalf] >> (16 * (r_Column & 1))));
			else
				r_ResidualPair = r_Input.r_Reduction[r_Column / 2].r_Word[2 * (r_Column & 1) + r_RowHalf];
			r_ScaledResidual.r_Pair[r_Column][r_RowHalf] = HalfMul(r_ResidualPair, r_Scale);
		}
	}

	return r_ScaledResidual;
}

template <int Channels, bool bFp8, int Tiles, class FInputSource>
__device__ __forceinline__ void ComputeWindowExpert(const FInputSource& InputSource,
													const unsigned char* g_PackedWeights, int ExpertIndex,
													FWindowAccumulatorTile<32> (&r_Contracted)[Tiles])
{
	using FConfig = FWideWindowProfile<Channels, bFp8>;
	const unsigned char* g_Expansion = g_PackedWeights + ExpertIndex * FConfig::ExpertExpandBytes;
	const unsigned char* g_Contraction =
		g_PackedWeights + FConfig::ContractOffset + ExpertIndex * FConfig::ExpertContractBytes;

	// Each expert is C→128→32. Stream one hidden C32 panel and preserve all
	// Half MMA rounding points; the four contractions accumulate in K order.
	#pragma unroll 1
	for (int HiddenPanel = 0; HiddenPanel < 4; ++HiddenPanel)
	{
		FWindowAccumulatorTile<32> r_Expanded[Tiles]{};
		#pragma unroll
		for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
		{
			const auto r_Weights =
				LoadWindowWeights<bFp8>(g_Expansion, HiddenPanel * 32, PanelIndex * 32, 128);
			#pragma unroll
			for (int r_Tile = 0; r_Tile < Tiles; ++r_Tile)
				LinearWindow32(InputSource.Load(r_Tile, PanelIndex), r_Weights, r_Expanded[r_Tile]);
		}

		const auto r_Weights = LoadWindowWeights<bFp8>(g_Contraction, 0, HiddenPanel * 32, 32);
		#pragma unroll
		for (int r_Tile = 0; r_Tile < Tiles; ++r_Tile)
		{
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Expanded[r_Tile].r_Pair[r_Column][r_RowHalf] =
						ActivateWindow(r_Expanded[r_Tile].r_Pair[r_Column][r_RowHalf]);
			LinearWindow32(PublishWindow32<bFp8>(r_Expanded[r_Tile]), r_Weights, r_Contracted[r_Tile]);
		}
	}
}

template <bool bFp8>
__device__ __forceinline__ FWindowActivationTile<bFp8>
AttendWithBias(int r_Tile, const unsigned char* g_HeadBias, const FWindowActivationTile<bFp8> (&r_Query)[4],
			   const FWindowActivationTile<bFp8> (&r_Key)[4], const FWindowValueTile<bFp8> (&r_Value)[4])
{
	FWindowAccumulatorTile<64> r_Probabilities;
	#pragma unroll
	for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
	{
		const int g_BiasOffset = 2048 * r_Tile + 512 * r_ColumnTile + 16 * threadIdx.x;
		const uint4 r_Bias = __ldca(reinterpret_cast<const uint4*>(g_HeadBias + g_BiasOffset));
		r_Probabilities.r_Pair[2 * r_ColumnTile][0] = r_Bias.x;
		r_Probabilities.r_Pair[2 * r_ColumnTile][1] = r_Bias.y;
		r_Probabilities.r_Pair[2 * r_ColumnTile + 1][0] = r_Bias.z;
		r_Probabilities.r_Pair[2 * r_ColumnTile + 1][1] = r_Bias.w;
	}

	#pragma unroll
	for (int r_Column = 0; r_Column < 8; ++r_Column)
		#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
		{
			const auto& r_Fragment = r_Key[r_Column / 2].r_Reduction[r_Chunk];
			const uint32_t r_KeyFragment[2] = {r_Fragment.r_Word[r_Column & 1],
											   r_Fragment.r_Word[2 + (r_Column & 1)]};
			MmaWindowFragment<bFp8>(r_Query[r_Tile].r_Reduction[r_Chunk], r_KeyFragment,
									r_Probabilities.r_Pair[r_Column]);
		}

	SoftmaxWindow(r_Probabilities);
	FWindowAccumulatorTile<32> r_Attended{};
	#pragma unroll
	for (int r_Chunk = 0; r_Chunk < 64 / FWindow32Profile<bFp8>::Reduction; ++r_Chunk)
	{
		const auto r_Probability = PublishWindowChunk<bFp8>(r_Probabilities, r_Chunk);
		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			uint32_t r_ValueFragment[2];
			if constexpr (bFp8)
			{
				r_ValueFragment[0] = r_Value[2 * r_Chunk].r_Column[r_Column][0];
				r_ValueFragment[1] = r_Value[2 * r_Chunk + 1].r_Column[r_Column][0];
			}
			else
			{
				r_ValueFragment[0] = r_Value[r_Chunk].r_Column[r_Column][0];
				r_ValueFragment[1] = r_Value[r_Chunk].r_Column[r_Column][1];
			}
			MmaWindowFragment<bFp8>(r_Probability, r_ValueFragment, r_Attended.r_Pair[r_Column]);
		}
	}

	return PublishWindow32<bFp8>(r_Attended);
}

#endif
