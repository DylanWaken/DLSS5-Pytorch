#pragma once
#include "warp_window_wide.cuh"
#include "window_view_io.cuh"

namespace dlssnr::kernels::window_upsample
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::window_wide;

template <int Channels, bool bFp8> struct FBlockProfile : FWideProfile<Channels, bFp8>
{
};

template <bool bFp8> struct FBlockProfile<32, bFp8> : FProfile<bFp8>
{
	static constexpr int Heads = 1;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
};

template <int Channels, bool bFp8> struct FUpProfile : FBlockProfile<Channels, bFp8>
{
	static constexpr int Heads = Channels / 32;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int FfnMatricesBytes = Channels == 32 ? 8192 * ElementBytes
														   : Heads * Channels * 128 * ElementBytes +
																 Heads * 128 * 32 * ElementBytes +
																 Channels * Channels * ElementBytes;
	static constexpr int UpProjectionOffset = FfnMatricesBytes;
	static constexpr int Padding = Channels == 32 ? 16 : 0;
	static constexpr int FfnScaleOffset = FfnMatricesBytes + 2 * Channels * Channels * ElementBytes + Padding;
	static constexpr int TransitionScaleOffset = FfnScaleOffset + 2 * Channels + Padding;
	static constexpr int QkvOffset = TransitionScaleOffset + 2 * Channels;
	static constexpr int BiasOffset = QkvOffset + 3 * Channels * Channels * ElementBytes;
	static constexpr int HeadScaleOffset = BiasOffset + Heads * 8192;
	static constexpr int ProjectionOffset = HeadScaleOffset + ((Heads * 4 + 15) / 16) * 16;
	static constexpr int AttentionScaleOffset = ProjectionOffset + Channels * Channels * ElementBytes;
};

struct FArguments
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int Height, Width, OriginX, OriginY, SkipHeight, SkipWidth;
	void* s_Window;
	const FAccumulatorTile<32>* r_Merged;
};

template <int Channels, class FParameters>
__device__ __forceinline__ FArguments Arguments(const FParameters& r_Source)
{
	FArguments r_Result{r_Source.g_State, r_Source.g_High, r_Source.g_Record, 0,
						r_Source.Height,  r_Source.Width,  r_Source.OriginX,  r_Source.OriginY,
						r_Source.Height,  r_Source.Width,  nullptr,			  nullptr};
	if constexpr (Channels == 32)
	{
		r_Result.g_Skip = r_Source.g_Extra80;
		if (r_Source.Aux88 > 0)
			r_Result.SkipHeight = r_Source.Aux88;
		if (r_Source.Aux92 > 0)
			r_Result.SkipWidth = r_Source.Aux92;
	}
	else
		r_Result.g_Skip = r_Source.g_Skip;
	return r_Result;
}

template <int Channels, bool bFp8>
__device__ __forceinline__ FActivationTile<bFp8> ReadLowInput(const FArguments& r_Parameters, int r_Panel)
{
	// Decoder input is the encoder's channel-plane publication. Read one 4x4
	// low-resolution region; upsampling its projection yields the 8x8 window.
	const int g_Height = Channels == 32 ? r_Parameters.Height / 2 : ((r_Parameters.Height + 1) / 2 + 3) & ~3;
	const int g_Width = Channels == 32 ? r_Parameters.Width / 2 : ((r_Parameters.Width + 1) / 2 + 3) & ~3;
	const int g_OriginX = (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 2;
	const int g_OriginY = (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 2;
	FActivationTile<bFp8> r_Result;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			const int g_X = g_Width == 1 ? 0 : g_OriginX + ((threadIdx.x / 4) & 3);
			const int g_Y = g_Height == 1 ? 0 : g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
			const int g_Plane = r_Panel * 2 * FProfile<bFp8>::InputChunks + 2 * r_Chunk + r_Word / 2;
			const uint64_t g_Address = r_Parameters.g_State +
									   ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
									   4 * (threadIdx.x & 3);
			r_Result.r_Reduction[r_Chunk].r_Word[r_Word] =
				g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height
					? *reinterpret_cast<const uint32_t*>(g_Address)
					: 0u;
		}
	return r_Result;
}

template <int Channels, bool bFp8>
__device__ __forceinline__ FActivationTile<bFp8> ReadSkip(const FArguments& r_Parameters, int r_Tile)
{
	const int g_Columns = r_Parameters.SkipWidth / 4, g_Rows = r_Parameters.SkipHeight / 4;
	const int g_X = g_Columns == 1 ? 0 : (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 4 + (r_Tile & 1);
	const int g_Y = g_Rows == 1 ? 0 : (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 4 + (r_Tile >> 1);
	const bool r_bValid = g_X >= 0 && g_X < g_Columns && g_Y >= 0 && g_Y < g_Rows;
	FActivationTile<bFp8> r_Result;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
	{
		const uint64_t g_Address = r_Parameters.g_Skip +
								   uint64_t(g_Y * g_Columns + g_X) * Channels * 16 * (bFp8 ? 1 : 2) +
								   threadIdx.y * FProfile<bFp8>::TileBytes + r_Chunk * 512 + threadIdx.x * 16;
		r_Result.r_Reduction[r_Chunk] =
			Fragment(r_bValid ? __ldcg(reinterpret_cast<const uint4*>(g_Address)) : make_uint4(0, 0, 0, 0));
	}
	return r_Result;
}

template <int Channels, bool bFp8>
__device__ __forceinline__ void ProjectAndMerge(const FArguments& r_Parameters,
												FAccumulatorTile<32> (&r_Merged)[4])
{
	using FConfig = FUpProfile<Channels, bFp8>;
	const auto* g_Record = reinterpret_cast<const unsigned char*>(r_Parameters.g_Record);
	FAccumulatorTile<32> r_LowProjection{};
#pragma unroll 1
	for (int r_Panel = 0; r_Panel < 2 * FConfig::Heads; ++r_Panel)
	{
		const auto r_Weights = LoadWeights<bFp8>(g_Record + FConfig::UpProjectionOffset, 32 * threadIdx.y,
												 32 * r_Panel, Channels);
		Linear32(ReadLowInput<Channels, bFp8>(r_Parameters, r_Panel), r_Weights, r_LowProjection);
	}
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		r_Merged[r_Tile] = ScaledResidual(ReadSkip<Channels, bFp8>(r_Parameters, r_Tile),
										  g_Record + FConfig::TransitionScaleOffset, 32 * threadIdx.y);
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				// Each low-resolution value repeats to a 2x2 high-resolution cell.
				// TileY chooses its MMA row half; TileX chooses two low columns.
				const int r_SourceLane =
					(threadIdx.x & 3) | ((threadIdx.x >> 1) & 4) | 8 * (r_Tile & 1) | 16 * r_RowHalf;
				const uint32_t r_Repeated =
					ShuffleIdx(r_LowProjection.r_Pair[r_Column][r_Tile >> 1], r_SourceLane, 31, 0xffffffffu);
				const int g_X =
					int(blockIdx.x) * 8 + r_Parameters.OriginX + 4 * (r_Tile & 1) + ((threadIdx.x / 4) & 3);
				const int g_Y = int(blockIdx.y) * 8 + r_Parameters.OriginY + 4 * (r_Tile >> 1) +
								threadIdx.x / 16 + 2 * r_RowHalf;
				// Native merge rounds the skip multiplication before adding the
				// projection, then clears spatial padding before the FFN consumes it.
				const uint32_t r_Sum = HalfAdd(r_Repeated, r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf]);
				r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf] =
					g_X >= 0 && g_X < r_Parameters.Width && g_Y >= 0 && g_Y < r_Parameters.Height ? r_Sum
																								  : 0u;
			}
	}
}

template <int Channels, bool bFp8> struct FUpIO : FTiledIO<Channels, bFp8>
{
	using FRecordProfile = FUpProfile<Channels, bFp8>;

	__device__ __forceinline__ static FActivationTile<bFp8> Read(const FArguments& r_Parameters, int r_Tile,
																 int r_Panel)
	{
		return reinterpret_cast<FSharedWindow<Channels, bFp8>*>(r_Parameters.s_Window)->Load(r_Tile, r_Panel);
	}
};

template <bool bFp8> struct FSmallUpIO : FOrdinaryIO
{
	static constexpr bool bCustomInput = true;
	static constexpr bool bRawResidual = true;
	template <bool bPrecision> using FRecordProfile = FUpProfile<32, bPrecision>;

	__device__ __forceinline__ static FActivationTile<bFp8> Read(const FArguments& r_Parameters, int r_Tile)
	{
		return Publish<bFp8>(r_Parameters.r_Merged[r_Tile]);
	}

	__device__ __forceinline__ static uint32_t Residual(const FArguments& r_Parameters, int r_Tile,
														int r_Column, int r_RowHalf)
	{
		return r_Parameters.r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf];
	}
};
#endif
} // namespace dlssnr::kernels::window_upsample
