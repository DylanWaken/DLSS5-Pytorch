#pragma once
#include "warp_window32.cuh"

// The wide blocks share tensor operations, but not one ownership schedule.
// C64 computes its FFN over two token tiles per warp. C128/C256 distribute
// FFN experts between warps and exchange published C32 panels through shared.
namespace dlssnr::kernels::window_wide
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::window32;

template <int Channels, bool bFp8> struct FWideProfile
{
	static_assert(Channels == 64 || Channels == 128 || Channels == 256);
	static constexpr int Heads = Channels / 32;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int Chunks = FProfile<bFp8>::InputChunks;
	static constexpr int PanelBytes = FProfile<bFp8>::TileBytes;
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
	using FConfig = FWideProfile<Channels, bFp8>;
	// A vector is exactly one lane's native A fragment. No BHWC conversion or
	// bank swizzle occurs in the FP8 ordinary block's exchange layout.
	uint4 s_Tile[4][FConfig::Heads][FConfig::Chunks][32];

	__device__ __forceinline__ FActivationTile<bFp8> Load(int r_Tile, int r_Panel) const
	{
		FActivationTile<bFp8> r_ActivationTile;
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
			r_ActivationTile.r_Reduction[r_Chunk] = Fragment(s_Tile[r_Tile][r_Panel][r_Chunk][threadIdx.x]);
		return r_ActivationTile;
	}

	__device__ __forceinline__ void Store(int r_Tile, int r_Panel, const FActivationTile<bFp8>& r_Activation)
	{
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
		{
			const auto& r_Fragment = r_Activation.r_Reduction[r_Chunk];
			s_Tile[r_Tile][r_Panel][r_Chunk][threadIdx.x] = make_uint4(
				r_Fragment.r_Word[0], r_Fragment.r_Word[1], r_Fragment.r_Word[2], r_Fragment.r_Word[3]);
		}
	}
};

template <bool bFp8, int Tiles, int Panels> struct FRegisterWindow
{
	FActivationTile<bFp8> r_Tile[Tiles][Panels];

	__device__ __forceinline__ FActivationTile<bFp8> Load(int r_TileIndex, int r_Panel) const
	{
		return r_Tile[r_TileIndex][r_Panel];
	}
};

template <bool bFp8>
__device__ __forceinline__ FAccumulatorTile<32>
ScaledResidual(const FActivationTile<bFp8>& r_Input, const unsigned char* g_Scale, int g_ChannelBase)
{
	FAccumulatorTile<32> r_ScaledResidual;
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

template <int Channels, bool bFp8, class FParameters>
__device__ __forceinline__ FActivationTile<bFp8> ReadTile(const FParameters& r_Parameters, int r_Tile,
														  int r_Panel)
{
	using FConfig = FWideProfile<Channels, bFp8>;
	const int g_TileColumns = r_Parameters.Width / 4, g_TileRows = r_Parameters.Height / 4;
	const int g_TileX =
		g_TileColumns == 1 ? 0 : (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 4 + (r_Tile & 1);
	const int g_TileY =
		g_TileRows == 1 ? 0 : (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 4 + (r_Tile >> 1);
	const bool r_bValid = g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows;
	FActivationTile<bFp8> r_InputTile;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
	{
		const uint64_t g_InputFragmentAddress =
			r_Parameters.g_Input + uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
			r_Panel * FConfig::PanelBytes + r_Chunk * 512 + int(threadIdx.x) * 16;
		r_InputTile.r_Reduction[r_Chunk] =
			Fragment(r_bValid ? __ldcg(reinterpret_cast<const uint4*>(g_InputFragmentAddress))
							  : make_uint4(0, 0, 0, 0));
	}
	return r_InputTile;
}

template <int Channels, bool bFp8, int Tiles, class FInputSource>
__device__ __forceinline__ void Expert(const FInputSource& r_Input, const unsigned char* g_PackedWeights,
									   int r_Expert, FAccumulatorTile<32> (&r_Contracted)[Tiles])
{
	using FConfig = FWideProfile<Channels, bFp8>;
	const unsigned char* g_Expansion = g_PackedWeights + r_Expert * FConfig::ExpertExpandBytes;
	const unsigned char* g_Contraction =
		g_PackedWeights + FConfig::ContractOffset + r_Expert * FConfig::ExpertContractBytes;
// Each expert is C→128→32. Stream one hidden C32 panel and preserve all
// Half MMA rounding points; the four contractions accumulate in K order.
#pragma unroll 1
	for (int r_Hidden = 0; r_Hidden < 4; ++r_Hidden)
	{
		FAccumulatorTile<32> r_Expanded[Tiles]{};
#pragma unroll
		for (int r_Panel = 0; r_Panel < FConfig::Heads; ++r_Panel)
		{
			const auto r_Weights = LoadWeights<bFp8>(g_Expansion, r_Hidden * 32, r_Panel * 32, 128);
#pragma unroll
			for (int r_Tile = 0; r_Tile < Tiles; ++r_Tile)
				Linear32(r_Input.Load(r_Tile, r_Panel), r_Weights, r_Expanded[r_Tile]);
		}
		const auto r_Weights = LoadWeights<bFp8>(g_Contraction, 0, r_Hidden * 32, 32);
#pragma unroll
		for (int r_Tile = 0; r_Tile < Tiles; ++r_Tile)
		{
#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Expanded[r_Tile].r_Pair[r_Column][r_RowHalf] =
						Activate(r_Expanded[r_Tile].r_Pair[r_Column][r_RowHalf]);
			Linear32(Publish<bFp8>(r_Expanded[r_Tile]), r_Weights, r_Contracted[r_Tile]);
		}
	}
}

template <int Channels, bool bFp8> struct FTiledIO;

template <int Channels, bool bFp8, class FIO = FTiledIO<Channels, bFp8>, class FParameters>
__device__ __forceinline__ void FeedForward(const FParameters& r_Parameters,
											FSharedWindow<Channels, bFp8>& s_Window)
{
	using FConfig = typename FIO::FRecordProfile;
	const int r_Warp = threadIdx.y;
	const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(r_Parameters.g_PackedWeights);
	if constexpr (Channels == 64)
	{
		// C64 uses token parallelism in the FFN: one warp owns left/right tiles
		// in one window row, keeping both input channel panels in registers.
		FRegisterWindow<bFp8, 2, 2> r_Input;
		FAccumulatorTile<32> r_Output[2][2];
#pragma unroll
		for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
#pragma unroll
			for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
			{
				r_Input.r_Tile[r_Tile][r_Panel] = FIO::Read(r_Parameters, 2 * r_Warp + r_Tile, r_Panel);
				r_Output[r_Tile][r_Panel] = ScaledResidual(
					r_Input.r_Tile[r_Tile][r_Panel], g_PackedWeights + FConfig::FfnScaleOffset, 32 * r_Panel);
			}
#pragma unroll 1
		for (int r_Expert = 0; r_Expert < 2; ++r_Expert)
		{
			FAccumulatorTile<32> r_Contracted[2]{};
			Expert<Channels, bFp8>(r_Input, g_PackedWeights, r_Expert, r_Contracted);
#pragma unroll
			for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
			{
				const auto r_Weights = LoadWeights<bFp8>(g_PackedWeights + FConfig::MixOffset, r_Panel * 32,
														 r_Expert * 32, Channels);
#pragma unroll
				for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
					Linear32(Publish<bFp8>(r_Contracted[r_Tile]), r_Weights, r_Output[r_Tile][r_Panel]);
			}
		}
#pragma unroll
		for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
#pragma unroll
			for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
				s_Window.Store(2 * r_Warp + r_Tile, r_Panel, Publish<bFp8>(r_Output[r_Tile][r_Panel]));
		__syncthreads();
	}
	else
	{
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, r_Warp, FIO::Read(r_Parameters, r_Tile, r_Warp));
		__syncthreads();
		FAccumulatorTile<32> r_Contracted[4]{};
		Expert<Channels, bFp8>(s_Window, g_PackedWeights, r_Warp, r_Contracted);
		FAccumulatorTile<32> r_Output[4];
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			r_Output[r_Tile] = ScaledResidual(s_Window.Load(r_Tile, r_Warp),
											  g_PackedWeights + FConfig::FfnScaleOffset, 32 * r_Warp);
		// All experts must finish reading X before their published outputs reuse
		// the same slab. This is a tensor lifetime barrier, not a warp shuffle.
		__syncthreads();
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, r_Warp, Publish<bFp8>(r_Contracted[r_Tile]));
		__syncthreads();
#pragma unroll 1
		for (int r_Panel = 0; r_Panel < FConfig::Heads; ++r_Panel)
		{
			const auto r_Weights =
				LoadWeights<bFp8>(g_PackedWeights + FConfig::MixOffset, 32 * r_Warp, 32 * r_Panel, Channels);
#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
				Linear32(s_Window.Load(r_Tile, r_Panel), r_Weights, r_Output[r_Tile]);
		}
		__syncthreads();
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, r_Warp, Publish<bFp8>(r_Output[r_Tile]));
		__syncthreads();
	}
}

template <int Channels, bool bFp8, class FConfig = FWideProfile<Channels, bFp8>>
__device__ __forceinline__ void ProjectQkv(const FSharedWindow<Channels, bFp8>& s_Window,
										   const unsigned char* g_PackedWeights,
										   FActivationTile<bFp8> (&r_Query)[4],
										   FActivationTile<bFp8> (&r_Key)[4], FValueTile<bFp8> (&r_Value)[4])
{
	FAccumulatorTile<32> r_Projected[3][4]{};
#pragma unroll 1
	for (int r_Panel = 0; r_Panel < FConfig::Heads; ++r_Panel)
#pragma unroll
		for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
		{
			// The record interleaves Q/K/V within each head: [Head][Q,K,V][32].
			const auto r_Weights =
				LoadWeights<bFp8>(g_PackedWeights + FConfig::QkvOffset,
								  96 * int(threadIdx.y) + 32 * r_QkvComponent, 32 * r_Panel, 3 * Channels);
#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
				Linear32(s_Window.Load(r_Tile, r_Panel), r_Weights, r_Projected[r_QkvComponent][r_Tile]);
		}
	const uint32_t r_HeadScale = FloatToHalf2(
		*reinterpret_cast<const uint32_t*>(g_PackedWeights + FConfig::HeadScaleOffset + 4 * threadIdx.y));
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		Normalize<true>(r_Projected[0][r_Tile], r_HeadScale);
		Normalize<false>(r_Projected[1][r_Tile], CONST_HALF2_ONE);
		r_Query[r_Tile] = Publish<bFp8>(r_Projected[0][r_Tile]);
		r_Key[r_Tile] = Publish<bFp8>(r_Projected[1][r_Tile]);
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			// Transpose Half accumulators before E4 publication, exactly as the
			// DLL does, to obtain B fragments for probability times value.
			const uint32_t r_LowerValueRows = TransposeM8n8(r_Projected[2][r_Tile].r_Pair[r_Column][0]);
			const uint32_t r_UpperValueRows = TransposeM8n8(r_Projected[2][r_Tile].r_Pair[r_Column][1]);
			if constexpr (bFp8)
				r_Value[r_Tile].r_Column[r_Column][0] = PackHalfPairsE4(r_LowerValueRows, r_UpperValueRows);
			else
			{
				r_Value[r_Tile].r_Column[r_Column][0] = r_LowerValueRows;
				r_Value[r_Tile].r_Column[r_Column][1] = r_UpperValueRows;
			}
		}
	}
}

template <bool bFp8>
__device__ __forceinline__ FActivationTile<bFp8>
AttendWithBias(int r_Tile, const unsigned char* g_HeadBias, const FActivationTile<bFp8> (&r_Query)[4],
			   const FActivationTile<bFp8> (&r_Key)[4], const FValueTile<bFp8> (&r_Value)[4])
{
	FAccumulatorTile<64> r_Probabilities;
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
		for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
		{
			const auto& r_Fragment = r_Key[r_Column / 2].r_Reduction[r_Chunk];
			const uint32_t r_KeyFragment[2] = {r_Fragment.r_Word[r_Column & 1],
											   r_Fragment.r_Word[2 + (r_Column & 1)]};
			Mma<bFp8>(r_Query[r_Tile].r_Reduction[r_Chunk], r_KeyFragment, r_Probabilities.r_Pair[r_Column]);
		}
	Softmax(r_Probabilities);
	FAccumulatorTile<32> r_Attended{};
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < 64 / FProfile<bFp8>::Reduction; ++r_Chunk)
	{
		const auto r_Probability = PublishChunk<bFp8>(r_Probabilities, r_Chunk);
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
			Mma<bFp8>(r_Probability, r_ValueFragment, r_Attended.r_Pair[r_Column]);
		}
	}
	return Publish<bFp8>(r_Attended);
}

template <bool bFp8>
__device__ __forceinline__ void
AttendPairWithBias(int r_FirstTile, const unsigned char* g_HeadBias,
				   const FActivationTile<bFp8> (&r_Query)[4], const FActivationTile<bFp8> (&r_Key)[4],
				   const FValueTile<bFp8> (&r_Value)[4], FActivationTile<bFp8> (&r_Attended)[2])
{
	// Two adjacent query tiles share one warp transpose for their four
	// row-half denominator vectors, matching the recovered native schedule.
	FAccumulatorTile<64> r_Probabilities[2];
#pragma unroll
	for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
		r_Probabilities[r_LocalTile] =
			QueryKeyScores<bFp8>(r_FirstTile + r_LocalTile, g_HeadBias, r_Query, r_Key);
	SoftmaxPair(r_Probabilities);
#pragma unroll
	for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
		r_Attended[r_LocalTile] =
			Publish<bFp8>(ProbabilityValues<bFp8>(r_Probabilities[r_LocalTile], r_Value));
}

template <int Channels, bool bFp8, class FParameters>
__device__ __forceinline__ void WriteTile(const FParameters& r_Parameters, int r_Tile,
										  const FAccumulatorTile<32>& r_Output)
{
	using FConfig = FWideProfile<Channels, bFp8>;
	const int g_TileColumns = r_Parameters.Width / 4, g_TileRows = r_Parameters.Height / 4;
	const int g_TileX = (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 4 + (r_Tile & 1);
	const int g_TileY = (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 4 + (r_Tile >> 1);
	if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
		{
			const auto r_Published = PublishChunk<bFp8>(r_Output, r_Chunk);
			const uint64_t g_OutputFragmentAddress =
				r_Parameters.g_Output + uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
				threadIdx.y * FConfig::PanelBytes + r_Chunk * 512 + threadIdx.x * 16;
			StoreNoAllocate(g_OutputFragmentAddress,
							make_uint4(r_Published.r_Word[0], r_Published.r_Word[1], r_Published.r_Word[2],
									   r_Published.r_Word[3]));
		}
}

template <int Channels, bool bFp8> struct FTiledIO
{
	using FRecordProfile = FWideProfile<Channels, bFp8>;

	template <class FParameters>
	__device__ __forceinline__ static FActivationTile<bFp8> Read(const FParameters& r_Parameters, int r_Tile,
																 int r_Panel)
	{
		return ReadTile<Channels, bFp8>(r_Parameters, r_Tile, r_Panel);
	}

	template <class FParameters>
	__device__ __forceinline__ static void Write(const FParameters& r_Parameters, int r_Tile,
												 const FAccumulatorTile<32>& r_Output)
	{
		WriteTile<Channels, bFp8>(r_Parameters, r_Tile, r_Output);
	}
};

template <int Channels, bool bFp8, class FIO = FTiledIO<Channels, bFp8>, bool bCaptureRaw = false,
		  class FParameters>
__device__ __forceinline__ void RunWindowWide(const FParameters& r_Parameters,
											  FSharedWindow<Channels, bFp8>& s_Window,
											  FAccumulatorTile<32>* r_RawTiles = nullptr)
{
	using FConfig = typename FIO::FRecordProfile;
	const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(r_Parameters.g_PackedWeights);
	FeedForward<Channels, bFp8, FIO>(r_Parameters, s_Window);
	FActivationTile<bFp8> r_Query[4], r_Key[4];
	FValueTile<bFp8> r_Value[4];
	ProjectQkv<Channels, bFp8, FConfig>(s_Window, g_PackedWeights, r_Query, r_Key, r_Value);
	__syncthreads();
#pragma unroll
	for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += FConfig::AttentionBatch)
	{
		FActivationTile<bFp8> r_Attended[FConfig::AttentionBatch];
		FAccumulatorTile<32> r_Output[FConfig::AttentionBatch];
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
		{
			const int r_Tile = r_FirstTile + r_LocalTile;
			r_Attended[r_LocalTile] = AttendWithBias<bFp8>(
				r_Tile, g_PackedWeights + FConfig::BiasOffset + 8192 * threadIdx.y, r_Query, r_Key, r_Value);
			r_Output[r_LocalTile] =
				ScaledResidual(s_Window.Load(r_Tile, threadIdx.y),
							   g_PackedWeights + FConfig::AttentionScaleOffset, 32 * threadIdx.y);
		}
// Each warp has consumed its own published FFN residual; attention
// output now occupies the same head panel for the cross-head projection.
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
			s_Window.Store(r_FirstTile + r_LocalTile, threadIdx.y, r_Attended[r_LocalTile]);
		__syncthreads();
#pragma unroll 1
		for (int r_Panel = 0; r_Panel < FConfig::Heads; ++r_Panel)
		{
			const auto r_Weights = LoadWeights<bFp8>(g_PackedWeights + FConfig::ProjectionOffset,
													 32 * threadIdx.y, 32 * r_Panel, Channels);
#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
				Linear32(s_Window.Load(r_FirstTile + r_LocalTile, r_Panel), r_Weights, r_Output[r_LocalTile]);
		}
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
		{
			if constexpr (bCaptureRaw)
				r_RawTiles[r_FirstTile + r_LocalTile] = r_Output[r_LocalTile];
			FIO::Write(r_Parameters, r_FirstTile + r_LocalTile, r_Output[r_LocalTile]);
		}
		__syncthreads();
	}
}
#endif
} // namespace dlssnr::kernels::window_wide
