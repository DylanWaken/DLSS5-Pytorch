#pragma once
#include "warp_window_wide.cuh"
#include "window_pool.cuh"

namespace dlssnr::kernels::window_downsample
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::window_wide;

// This is an internal argument view, not an exported parameter ABI. Named
// adapters retain the byte contracts of the four existing native structures.
struct FArguments
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_DownsampledOutput;
	int Height, Width, OriginX, OriginY, DownsampledHeight, DownsampledWidth;
};

template <int Channels, bool bFp8, class FParameters>
__device__ __forceinline__ FArguments Arguments(const FParameters& r_Source)
{
	return {r_Source.g_Input,
			r_Source.g_Output,
			r_Source.g_PackedWeights,
			r_Source.g_DownsampledOutput,
			r_Source.Height,
			r_Source.Width,
			r_Source.OriginX,
			r_Source.OriginY,
			r_Source.DownsampledHeight,
			r_Source.DownsampledWidth};
}

template <int Channels, bool bFp8>
__device__ __forceinline__ void PublishDown(const FArguments& r_Parameters, int r_OutputPanel,
											const FAccumulatorTile<32>& r_Output)
{
	// C32 writes compact half extents. Wider native entries align those extents
	// to four. The separate clear operation uses the auxiliary target extents.
	const int g_ValidHeight = (r_Parameters.Height + 1) / 2;
	const int g_ValidWidth = (r_Parameters.Width + 1) / 2;
	const int g_Height = Channels == 32 ? r_Parameters.Height / 2 : (g_ValidHeight + 3) & ~3;
	const int g_Width = Channels == 32 ? r_Parameters.Width / 2 : (g_ValidWidth + 3) & ~3;
	const int g_OriginX = (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 2;
	const int g_OriginY = (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 2;
#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FProfile<bFp8>::InputChunks; ++r_Chunk)
	{
		const auto r_Fragment = PublishChunk<bFp8>(r_Output, r_Chunk);
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
			const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
			if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
			{
				const int g_Plane =
					r_OutputPanel * 2 * FProfile<bFp8>::InputChunks + 2 * r_Chunk + r_Word / 2;
				const uint64_t g_OutputWordAddress =
					r_Parameters.g_DownsampledOutput +
					((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) + 4 * (threadIdx.x & 3);
				// The native padding clear follows these projection stores. Emit
				// its zero immediately for our own padded cells to avoid a race.
				*reinterpret_cast<uint32_t*>(g_OutputWordAddress) =
					g_X < g_ValidWidth && g_Y < g_ValidHeight ? r_Fragment.r_Word[r_Word] : 0u;
			}
		}
	}
}

template <int Channels, int ClearPlanes = Channels / 4>
__device__ __forceinline__ void ClearPadding(const FArguments& r_Parameters)
{
	const int g_ValidHeight = (r_Parameters.Height + 1) / 2;
	const int g_ValidWidth = (r_Parameters.Width + 1) / 2;
	if (r_Parameters.g_DownsampledOutput == 0 ||
		(r_Parameters.DownsampledHeight <= g_ValidHeight && r_Parameters.DownsampledWidth <= g_ValidWidth))
		return;
	const int g_OriginX = (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 2;
	const int g_OriginY = (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 2;
	const int r_Thread = threadIdx.y * 32 + threadIdx.x;
	// The native clear footprint is a Half-sized C→2C allocation even for
	// FP8. Preserve that documented workspace contract, but only clear padding.
	for (int g_Index = r_Thread; g_Index < 16 * ClearPlanes; g_Index += Channels)
	{
		const int g_Plane = g_Index % ClearPlanes;
		const int g_X = g_OriginX + (g_Index / ClearPlanes) % 4;
		const int g_Y = g_OriginY + g_Index / (4 * ClearPlanes);
		if (g_X >= 0 && g_X < r_Parameters.DownsampledWidth && g_Y >= 0 &&
			g_Y < r_Parameters.DownsampledHeight && (g_X >= g_ValidWidth || g_Y >= g_ValidHeight))
		{
			const uint64_t g_PaddingVectorAddress =
				r_Parameters.g_DownsampledOutput +
				((uint64_t(g_Plane * r_Parameters.DownsampledHeight + g_Y) * r_Parameters.DownsampledWidth +
				  g_X) *
				 16);
			*reinterpret_cast<uint4*>(g_PaddingVectorAddress) = make_uint4(0, 0, 0, 0);
		}
	}
	// A larger caller-provided target may extend past every launched window.
	// CTA zero handles that uncovered border, as the native clear path does.
	if (blockIdx.x == 0 && blockIdx.y == 0 && blockIdx.z == 0)
	{
		const int g_CoveredHeight = max(g_ValidHeight, min(r_Parameters.DownsampledHeight,
														   (int(gridDim.y) * 8 + r_Parameters.OriginY) / 2));
		const int g_CoveredWidth = max(g_ValidWidth, min(r_Parameters.DownsampledWidth,
														 (int(gridDim.x) * 8 + r_Parameters.OriginX) / 2));
		const int g_BottomPixels =
			(r_Parameters.DownsampledHeight - g_CoveredHeight) * r_Parameters.DownsampledWidth;
		const int g_RightPixels = g_CoveredHeight * (r_Parameters.DownsampledWidth - g_CoveredWidth);
		for (int g_Index = r_Thread; g_Index < (g_BottomPixels + g_RightPixels) * ClearPlanes;
			 g_Index += Channels)
		{
			const int g_Plane = g_Index % ClearPlanes, g_Pixel = g_Index / ClearPlanes;
			const bool r_bBottom = g_Pixel < g_BottomPixels;
			const int g_RightWidth = r_Parameters.DownsampledWidth - g_CoveredWidth;
			const int g_Y = r_bBottom ? g_CoveredHeight + g_Pixel / r_Parameters.DownsampledWidth
									  : (g_Pixel - g_BottomPixels) / g_RightWidth;
			const int g_X = r_bBottom ? g_Pixel % r_Parameters.DownsampledWidth
									  : g_CoveredWidth + (g_Pixel - g_BottomPixels) % g_RightWidth;
			const uint64_t g_PaddingVectorAddress =
				r_Parameters.g_DownsampledOutput +
				((uint64_t(g_Plane * r_Parameters.DownsampledHeight + g_Y) * r_Parameters.DownsampledWidth +
				  g_X) *
				 16);
			*reinterpret_cast<uint4*>(g_PaddingVectorAddress) = make_uint4(0, 0, 0, 0);
		}
	}
}

template <int Channels, bool bFp8>
__device__ __forceinline__ void ProjectDown(const FArguments& r_Parameters,
											const FActivationTile<bFp8>& r_Pooled,
											FSharedWindow<Channels, bFp8>& s_Window)
{
	using FConfig = FWideProfile<Channels, bFp8>;
	s_Window.Store(0, threadIdx.y, r_Pooled);
	__syncthreads();
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(r_Parameters.g_PackedWeights) +
							FConfig::AttentionScaleOffset + 2 * Channels;
#pragma unroll 1
	for (int r_OutputHalf = 0; r_OutputHalf < 2; ++r_OutputHalf)
	{
		FAccumulatorTile<32> r_Output{};
#pragma unroll
		for (int r_Panel = 0; r_Panel < FConfig::Heads; ++r_Panel)
		{
			const auto r_Weights = LoadWeights<bFp8>(g_Weights, 32 * threadIdx.y + r_OutputHalf * Channels,
													 32 * r_Panel, 2 * Channels);
			Linear32(s_Window.Load(0, r_Panel), r_Weights, r_Output);
		}
		PublishDown<Channels, bFp8>(r_Parameters, threadIdx.y + r_OutputHalf * FConfig::Heads, r_Output);
	}
	__syncthreads();
	ClearPadding<Channels>(r_Parameters);
}

template <bool bFp8>
__device__ __forceinline__ void ProjectDown32(const FArguments& r_Parameters,
											  const FActivationTile<bFp8>& r_Pooled)
{
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(r_Parameters.g_PackedWeights) +
							FProfile<bFp8>::AttentionScaleOffset + 64;
#pragma unroll
	for (int r_OutputPanel = 0; r_OutputPanel < 2; ++r_OutputPanel)
	{
		FAccumulatorTile<32> r_Output{};
		Linear32(r_Pooled, LoadWeights<bFp8>(g_Weights, 32 * r_OutputPanel, 0, 64), r_Output);
		PublishDown<32, bFp8>(r_Parameters, r_OutputPanel, r_Output);
	}
	ClearPadding<32>(r_Parameters);
}
#endif
} // namespace dlssnr::kernels::window_downsample
