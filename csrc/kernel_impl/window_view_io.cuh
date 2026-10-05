#pragma once
#include "warp_window_wide.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
// Native view storage is [ChannelPlane][Y][X][16 bytes]. A plane holds 16
// E4 channels or eight Half channels. The fragment's existing packed word is
// already in that plane's channel order; no transpose or numeric conversion.
template <bool bFp8, class FParameters>
__device__ __forceinline__ FWindowActivationTile<bFp8> ReadWindowViewTile(const FParameters& r_Parameters,
																		  int r_Tile, int r_Panel)
{
	constexpr int Chunks = FWindow32Profile<bFp8>::InputChunks;
	const int g_Height = r_Parameters.ViewHeight > 0 ? r_Parameters.ViewHeight : r_Parameters.Height;
	const int g_Width = r_Parameters.ViewWidth > 0 ? r_Parameters.ViewWidth : r_Parameters.Width;
	const int g_OriginX = int(blockIdx.x) * 8 + r_Parameters.OriginX + (r_Tile & 1) * 4;
	const int g_OriginY = int(blockIdx.y) * 8 + r_Parameters.OriginY + (r_Tile >> 1) * 4;
	FWindowActivationTile<bFp8> r_InputTile;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			// Row-half words differ by two physical image rows inside a 4x4
			// tile. Singleton dimensions broadcast; all other OOB reads zero.
			const int g_X = g_Width == 1 ? 0 : g_OriginX + ((threadIdx.x / 4) & 3);
			const int g_Y = g_Height == 1 ? 0 : g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
			const int g_Plane = r_Panel * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
			const uint64_t g_InputWordAddress = r_Parameters.g_Input +
												((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
												4 * (threadIdx.x & 3);
			r_InputTile.r_Reduction[r_Chunk].r_Word[r_Word] =
				g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height
					? *reinterpret_cast<const uint32_t*>(g_InputWordAddress)
					: 0u;
		}
	return r_InputTile;
}

template <bool bFp8, class FParameters>
__device__ __forceinline__ void WriteWindowViewTile(const FParameters& r_Parameters, int r_Tile, int r_Panel,
													const FWindowAccumulatorTile<32>& r_Output)
{
	constexpr int Chunks = FWindow32Profile<bFp8>::InputChunks;
	const int g_Height = r_Parameters.ViewHeight > 0 ? r_Parameters.ViewHeight : r_Parameters.Height;
	const int g_Width = r_Parameters.ViewWidth > 0 ? r_Parameters.ViewWidth : r_Parameters.Width;
	const int g_OriginX = int(blockIdx.x) * 8 + r_Parameters.OriginX + (r_Tile & 1) * 4;
	const int g_OriginY = int(blockIdx.y) * 8 + r_Parameters.OriginY + (r_Tile >> 1) * 4;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
	{
		const auto r_Fragment = PublishWindowChunk<bFp8>(r_Output, r_Chunk);
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
			const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
			if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
			{
				const int g_Plane = r_Panel * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
				const uint64_t g_OutputWordAddress =
					r_Parameters.g_Output + ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
					4 * (threadIdx.x & 3);
				*reinterpret_cast<uint32_t*>(g_OutputWordAddress) = r_Fragment.r_Word[r_Word];
			}
		}
	}
}

template <int Channels, bool bFp8, bool bInputView, bool bOutputView> struct FWindowViewIO
{
	using FRecordProfile = FWideWindowProfile<Channels, bFp8>;

	template <class FParameters>
	__device__ __forceinline__ static FWindowActivationTile<bFp8> Read(const FParameters& r_Parameters,
																	   int r_Tile, int r_Panel)
	{
		if constexpr (bInputView)
			return ReadWindowViewTile<bFp8>(r_Parameters, r_Tile, r_Panel);
		else
			return FTiledWindowIO<Channels, bFp8>::Read(r_Parameters, r_Tile, r_Panel);
	}

	template <class FParameters>
	__device__ __forceinline__ static void Write(const FParameters& r_Parameters, int r_Tile,
												 const FWindowAccumulatorTile<32>& r_Output)
	{
		if constexpr (bOutputView)
			WriteWindowViewTile<bFp8>(r_Parameters, r_Tile, threadIdx.y, r_Output);
		else
			FTiledWindowIO<Channels, bFp8>::Write(r_Parameters, r_Tile, r_Output);
	}
};

// Each native ABI exposes ViewHeight/ViewWidth at its verified byte positions.
template <bool bFp8, bool bInputView, bool bOutputView> struct FSmallWindowViewIO : FOrdinaryWindowIO
{
	static constexpr bool bCustomInput = bInputView;
	static constexpr bool bCustomOutput = bOutputView;

	template <class FParameters>
	__device__ __forceinline__ static FWindowActivationTile<bFp8> Read(const FParameters& r_Parameters,
																	   int r_Tile)
	{
		return ReadWindowViewTile<bFp8>(r_Parameters, r_Tile, 0);
	}

	template <class FParameters>
	__device__ __forceinline__ static void Write(const FParameters& r_Parameters, int r_Tile,
												 const FWindowAccumulatorTile<32>& r_Output)
	{
		WriteWindowViewTile<bFp8>(r_Parameters, r_Tile, 0, r_Output);
	}
};
#endif
