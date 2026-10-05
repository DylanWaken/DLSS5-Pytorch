#pragma once
#include "warp_window_wide.cuh"
#include "window_view_io.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <int Channels, bool bFp8> struct FWindowUpsampleBlockProfile : FWideWindowProfile<Channels, bFp8>
{
};

template <bool bFp8> struct FWindowUpsampleBlockProfile<32, bFp8> : FWindow32Profile<bFp8>
{
	static constexpr int Heads = 1;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
};

template <int Channels, bool bFp8> struct FWindowUpsampleProfile : FWindowUpsampleBlockProfile<Channels, bFp8>
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

struct FWindowUpsampleArguments
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int Height, Width, OriginX, OriginY, ResidualHeight, ResidualWidth;
	void* s_Window;
	const FWindowAccumulatorTile<32>* r_Merged;
};

template <int Channels, bool bFp8> struct FWindowUpsampleIO : FTiledWindowIO<Channels, bFp8>
{
	using FRecordProfile = FWindowUpsampleProfile<Channels, bFp8>;

	__device__ __forceinline__ static FWindowActivationTile<bFp8>
	Read(const FWindowUpsampleArguments& Parameters, int s_TileIndex, int s_PanelIndex)
	{
		return reinterpret_cast<FSharedWindow<Channels, bFp8>*>(Parameters.s_Window)
			->Load(s_TileIndex, s_PanelIndex);
	}
};

template <bool bFp8> struct FSmallWindowUpsampleIO : FOrdinaryWindowIO
{
	static constexpr bool bCustomInput = true;
	static constexpr bool bRawResidual = true;
	template <bool bPrecision> using FRecordProfile = FWindowUpsampleProfile<32, bPrecision>;

	__device__ __forceinline__ static FWindowActivationTile<bFp8>
	Read(const FWindowUpsampleArguments& Parameters, int r_Tile)
	{
		return PublishWindow32<bFp8>(Parameters.r_Merged[r_Tile]);
	}

	__device__ __forceinline__ static uint32_t Residual(const FWindowUpsampleArguments& Parameters,
														int r_Tile, int r_Column, int r_RowHalf)
	{
		return Parameters.r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf];
	}
};

template <int Channels, bool bFp8, typename TParameters>
__device__ __forceinline__ void RunWindowUpsample(const TParameters& Parameters)
{
	FWindowUpsampleArguments Arguments{Parameters.g_Input,
									   Parameters.g_Output,
									   Parameters.g_PackedWeights,
									   0,
									   Parameters.Height,
									   Parameters.Width,
									   Parameters.OriginX,
									   Parameters.OriginY,
									   Parameters.Height,
									   Parameters.Width,
									   nullptr,
									   nullptr};
	if constexpr (Channels == 32)
	{
		Arguments.g_Residual = Parameters.g_Residual;
		if (Parameters.ResidualHeight > 0)
			Arguments.ResidualHeight = Parameters.ResidualHeight;
		if (Parameters.ResidualWidth > 0)
			Arguments.ResidualWidth = Parameters.ResidualWidth;
	}
	else
		Arguments.g_Residual = Parameters.g_Residual;
	FWindowAccumulatorTile<32> r_Merged[4];
	using FConfig = FWindowUpsampleProfile<Channels, bFp8>;
	const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Arguments.g_PackedWeights);
	FWindowAccumulatorTile<32> r_LowProjection{};
#pragma unroll 1
	for (int PanelIndex = 0; PanelIndex < 2 * FConfig::Heads; ++PanelIndex)
	{
		const auto r_Weights = LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::UpProjectionOffset,
													   32 * threadIdx.y, 32 * PanelIndex, Channels);
		// Decoder input is the encoder's channel-plane publication. Read one 4x4
		// low-resolution region; upsampling its projection yields the 8x8 window.
		const int g_Height = Channels == 32 ? Arguments.Height / 2 : ((Arguments.Height + 1) / 2 + 3) & ~3;
		const int g_Width = Channels == 32 ? Arguments.Width / 2 : ((Arguments.Width + 1) / 2 + 3) & ~3;
		const int g_OriginX = (int(blockIdx.x) * 8 + Arguments.OriginX) / 2;
		const int g_OriginY = (int(blockIdx.y) * 8 + Arguments.OriginY) / 2;
		FWindowActivationTile<bFp8> r_LowResolutionInput;
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
			{
				const int g_X = g_Width == 1 ? 0 : g_OriginX + ((threadIdx.x / 4) & 3);
				const int g_Y = g_Height == 1 ? 0 : g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
				const int g_Plane =
					PanelIndex * 2 * FWindow32Profile<bFp8>::InputChunks + 2 * r_Chunk + r_Word / 2;
				const uint64_t g_InputWordAddress =
					Arguments.g_Input + ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
					4 * (threadIdx.x & 3);
				r_LowResolutionInput.r_Reduction[r_Chunk].r_Word[r_Word] =
					g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height
						? *reinterpret_cast<const uint32_t*>(g_InputWordAddress)
						: 0u;
			}
		LinearWindow32(r_LowResolutionInput, r_Weights, r_LowProjection);
	}
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		const int g_Columns = Arguments.ResidualWidth / 4, g_Rows = Arguments.ResidualHeight / 4;
		const int g_X = g_Columns == 1 ? 0 : (int(blockIdx.x) * 8 + Arguments.OriginX) / 4 + (r_Tile & 1);
		const int g_Y = g_Rows == 1 ? 0 : (int(blockIdx.y) * 8 + Arguments.OriginY) / 4 + (r_Tile >> 1);
		const bool bValid = g_X >= 0 && g_X < g_Columns && g_Y >= 0 && g_Y < g_Rows;
		FWindowActivationTile<bFp8> r_ResidualInput;
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
		{
			const uint64_t g_ResidualFragmentAddress =
				Arguments.g_Residual + uint64_t(g_Y * g_Columns + g_X) * Channels * 16 * (bFp8 ? 1 : 2) +
				threadIdx.y * FWindow32Profile<bFp8>::TileBytes + r_Chunk * 512 + threadIdx.x * 16;
			r_ResidualInput.r_Reduction[r_Chunk] =
				MakeWindowFragment(bValid ? __ldcg(reinterpret_cast<const uint4*>(g_ResidualFragmentAddress))
										  : make_uint4(0, 0, 0, 0));
		}
		r_Merged[r_Tile] = ScaledWindowResidual(
			r_ResidualInput, g_PackedWeights + FConfig::TransitionScaleOffset, 32 * threadIdx.y);
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
					int(blockIdx.x) * 8 + Arguments.OriginX + 4 * (r_Tile & 1) + ((threadIdx.x / 4) & 3);
				const int g_Y = int(blockIdx.y) * 8 + Arguments.OriginY + 4 * (r_Tile >> 1) +
								threadIdx.x / 16 + 2 * r_RowHalf;
				// Native merge rounds the skip multiplication before adding the
				// projection, then clears spatial padding before the FFN consumes it.
				const uint32_t r_Sum = HalfAdd(r_Repeated, r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf]);
				r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf] =
					g_X >= 0 && g_X < Arguments.Width && g_Y >= 0 && g_Y < Arguments.Height ? r_Sum : 0u;
			}
	}
	if constexpr (Channels == 32)
	{
		Arguments.r_Merged = r_Merged;
		RunWindow32<bFp8, FWindowUpsampleArguments, FSmallWindowUpsampleIO<bFp8>>(Arguments);
	}
	else
	{
		// Publish the merged input once; the block reuses this slab for FFN/attention.
		__shared__ FSharedWindow<Channels, bFp8> s_Window;
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<bFp8>(r_Merged[r_Tile]));
		__syncthreads();
		Arguments.s_Window = &s_Window;
		RunWindowWide<Channels, bFp8, FWindowUpsampleIO<Channels, bFp8>>(Arguments, s_Window);
	}
}
#endif
