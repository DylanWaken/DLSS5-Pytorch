#pragma once
#include "warp_window_wide.cuh"

namespace dlssnr::kernels::window_wide
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
// Native view storage is [ChannelPlane][Y][X][16 bytes]. A plane holds 16
// E4 channels or eight Half channels. The fragment's existing packed word is
// already in that plane's channel order; no transpose or numeric conversion.
template <bool bFp8, class FParameters>
__device__ __forceinline__ FActivationTile<bFp8> ReadViewTile(const FParameters& r_Parameters, int r_Tile,
															  int r_Panel)
{
	constexpr int Chunks = FProfile<bFp8>::InputChunks;
	const int g_Height = r_Parameters.Aux80 > 0 ? r_Parameters.Aux80 : r_Parameters.Height;
	const int g_Width = r_Parameters.Aux84 > 0 ? r_Parameters.Aux84 : r_Parameters.Width;
	const int g_OriginX = int(blockIdx.x) * 8 + r_Parameters.OriginX + (r_Tile & 1) * 4;
	const int g_OriginY = int(blockIdx.y) * 8 + r_Parameters.OriginY + (r_Tile >> 1) * 4;
	FActivationTile<bFp8> r_Result;
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

template <bool bFp8, class FParameters>
__device__ __forceinline__ void WriteViewTile(const FParameters& r_Parameters, int r_Tile, int r_Panel,
											  const FAccumulatorTile<32>& r_Output)
{
	constexpr int Chunks = FProfile<bFp8>::InputChunks;
	const int g_Height = r_Parameters.Aux80 > 0 ? r_Parameters.Aux80 : r_Parameters.Height;
	const int g_Width = r_Parameters.Aux84 > 0 ? r_Parameters.Aux84 : r_Parameters.Width;
	const int g_OriginX = int(blockIdx.x) * 8 + r_Parameters.OriginX + (r_Tile & 1) * 4;
	const int g_OriginY = int(blockIdx.y) * 8 + r_Parameters.OriginY + (r_Tile >> 1) * 4;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
	{
		const auto r_Fragment = PublishChunk<bFp8>(r_Output, r_Chunk);
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
			const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
			if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
			{
				const int g_Plane = r_Panel * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
				const uint64_t g_Address = r_Parameters.g_High +
										   ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
										   4 * (threadIdx.x & 3);
				*reinterpret_cast<uint32_t*>(g_Address) = r_Fragment.r_Word[r_Word];
			}
		}
	}
}

template <class FParameters> struct FMediumViewParameters : FParameters
{
	int Aux80, Aux84;

	__device__ __forceinline__ explicit FMediumViewParameters(const FParameters& r_Source)
		: FParameters(r_Source), Aux80(r_Source.AuxHeight), Aux84(r_Source.AuxWidth)
	{
	}
};

template <int Channels, bool bFp8, bool bInputView, bool bOutputView> struct FViewIO
{
	using FRecordProfile = FWideProfile<Channels, bFp8>;

	template <class FParameters>
	__device__ __forceinline__ static FActivationTile<bFp8> Read(const FParameters& r_Parameters, int r_Tile,
																 int r_Panel)
	{
		if constexpr (bInputView)
		{
			if constexpr (Channels == 64)
				return ReadViewTile<bFp8>(FMediumViewParameters<FParameters>(r_Parameters), r_Tile, r_Panel);
			else
				return ReadViewTile<bFp8>(r_Parameters, r_Tile, r_Panel);
		}
		else
			return FTiledIO<Channels, bFp8>::Read(r_Parameters, r_Tile, r_Panel);
	}

	template <class FParameters>
	__device__ __forceinline__ static void Write(const FParameters& r_Parameters, int r_Tile,
												 const FAccumulatorTile<32>& r_Output)
	{
		if constexpr (bOutputView)
		{
			if constexpr (Channels == 64)
				WriteViewTile<bFp8>(FMediumViewParameters<FParameters>(r_Parameters), r_Tile, threadIdx.y,
									r_Output);
			else
				WriteViewTile<bFp8>(r_Parameters, r_Tile, threadIdx.y, r_Output);
		}
		else
			FTiledIO<Channels, bFp8>::Write(r_Parameters, r_Tile, r_Output);
	}
};

// The C32 native parameter block carries view dimensions at 72/76, whereas
// wider entries use 80/84. Adapt names locally without altering either ABI.
template <class FParameters> struct FSmallViewParameters : FParameters
{
	int Aux80, Aux84;

	__device__ __forceinline__ explicit FSmallViewParameters(const FParameters& r_Source)
		: FParameters(r_Source), Aux80(r_Source.Aux72), Aux84(r_Source.Aux76)
	{
	}
};

template <bool bFp8, bool bInputView, bool bOutputView> struct FSmallViewIO : FOrdinaryIO
{
	static constexpr bool bCustomInput = bInputView;
	static constexpr bool bCustomOutput = bOutputView;

	template <class FParameters>
	__device__ __forceinline__ static FActivationTile<bFp8> Read(const FParameters& r_Parameters, int r_Tile)
	{
		return ReadViewTile<bFp8>(FSmallViewParameters<FParameters>(r_Parameters), r_Tile, 0);
	}

	template <class FParameters>
	__device__ __forceinline__ static void Write(const FParameters& r_Parameters, int r_Tile,
												 const FAccumulatorTile<32>& r_Output)
	{
		WriteViewTile<bFp8>(FSmallViewParameters<FParameters>(r_Parameters), r_Tile, 0, r_Output);
	}
};
#endif
} // namespace dlssnr::kernels::window_wide
