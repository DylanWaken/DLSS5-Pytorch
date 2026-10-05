#pragma once
#include "warp_window_wide.cuh"
#include "window_pool.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// This is an internal argument view, not an exported parameter ABI. Named
// adapters retain the byte contracts of the four existing native structures.
struct FWindowDownsampleArguments
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_DownsampledOutput;
	int Height, Width, OriginX, OriginY, DownsampledHeight, DownsampledWidth;
};

// Shared by fused window downsampling and the frontend downsample adapter.
// Both publish the same physical channel planes and clear the same padded cells.
template <int Channels, bool bFp8>
__device__ __forceinline__ void PublishWindowDownsample(const FWindowDownsampleArguments& Parameters,
														int OutputPanel,
														const FWindowAccumulatorTile<32>& r_Output)
{
	// C32 writes compact half extents. Wider native entries align those extents
	// to four. The separate clear operation uses the auxiliary target extents.
	const int g_ValidHeight = (Parameters.Height + 1) / 2;
	const int g_ValidWidth = (Parameters.Width + 1) / 2;
	const int g_Height = Channels == 32 ? Parameters.Height / 2 : (g_ValidHeight + 3) & ~3;
	const int g_Width = Channels == 32 ? Parameters.Width / 2 : (g_ValidWidth + 3) & ~3;
	const int g_OriginX = (int(blockIdx.x) * 8 + Parameters.OriginX) / 2;
	const int g_OriginY = (int(blockIdx.y) * 8 + Parameters.OriginY) / 2;
	#pragma unroll
	for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
	{
		const auto r_Fragment = PublishWindowChunk<bFp8>(r_Output, r_Chunk);
		#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
			const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
			if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
			{
				const int g_Plane =
					OutputPanel * 2 * FWindow32Profile<bFp8>::InputChunks + 2 * r_Chunk + r_Word / 2;
				const uint64_t g_OutputWordAddress =
					Parameters.g_DownsampledOutput +
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
__device__ __forceinline__ void ClearDownsamplePadding(const FWindowDownsampleArguments& Parameters)
{
	const int g_ValidHeight = (Parameters.Height + 1) / 2;
	const int g_ValidWidth = (Parameters.Width + 1) / 2;
	if (Parameters.g_DownsampledOutput == 0 ||
		(Parameters.DownsampledHeight <= g_ValidHeight && Parameters.DownsampledWidth <= g_ValidWidth))
		return;
	const int g_OriginX = (int(blockIdx.x) * 8 + Parameters.OriginX) / 2;
	const int g_OriginY = (int(blockIdx.y) * 8 + Parameters.OriginY) / 2;
	const int ThreadIndex = threadIdx.y * 32 + threadIdx.x;

	// The native clear footprint is a Half-sized C→2C allocation even for
	// FP8. Preserve that documented workspace contract, but only clear padding.
	for (int g_Index = ThreadIndex; g_Index < 16 * ClearPlanes; g_Index += Channels)
	{
		const int g_Plane = g_Index % ClearPlanes;
		const int g_X = g_OriginX + (g_Index / ClearPlanes) % 4;
		const int g_Y = g_OriginY + g_Index / (4 * ClearPlanes);
		if (g_X >= 0 && g_X < Parameters.DownsampledWidth && g_Y >= 0 && g_Y < Parameters.DownsampledHeight &&
			(g_X >= g_ValidWidth || g_Y >= g_ValidHeight))
		{
			const uint64_t g_PaddingVectorAddress =
				Parameters.g_DownsampledOutput +
				((uint64_t(g_Plane * Parameters.DownsampledHeight + g_Y) * Parameters.DownsampledWidth +
				  g_X) *
				 16);
			*reinterpret_cast<uint4*>(g_PaddingVectorAddress) = make_uint4(0, 0, 0, 0);
		}
	}

	// A larger caller-provided target may extend past every launched window.
	// CTA zero handles that uncovered border, as the native clear path does.
	if (blockIdx.x == 0 && blockIdx.y == 0 && blockIdx.z == 0)
	{
		const int g_CoveredHeight = max(
			g_ValidHeight, min(Parameters.DownsampledHeight, (int(gridDim.y) * 8 + Parameters.OriginY) / 2));
		const int g_CoveredWidth = max(
			g_ValidWidth, min(Parameters.DownsampledWidth, (int(gridDim.x) * 8 + Parameters.OriginX) / 2));
		const int g_BottomPixels =
			(Parameters.DownsampledHeight - g_CoveredHeight) * Parameters.DownsampledWidth;
		const int g_RightPixels = g_CoveredHeight * (Parameters.DownsampledWidth - g_CoveredWidth);
		for (int g_Index = ThreadIndex; g_Index < (g_BottomPixels + g_RightPixels) * ClearPlanes;
			 g_Index += Channels)
		{
			const int g_Plane = g_Index % ClearPlanes, g_Pixel = g_Index / ClearPlanes;
			const bool bBottom = g_Pixel < g_BottomPixels;
			const int g_RightWidth = Parameters.DownsampledWidth - g_CoveredWidth;
			const int g_Y = bBottom ? g_CoveredHeight + g_Pixel / Parameters.DownsampledWidth
									: (g_Pixel - g_BottomPixels) / g_RightWidth;
			const int g_X = bBottom ? g_Pixel % Parameters.DownsampledWidth
									: g_CoveredWidth + (g_Pixel - g_BottomPixels) % g_RightWidth;
			const uint64_t g_PaddingVectorAddress =
				Parameters.g_DownsampledOutput +
				((uint64_t(g_Plane * Parameters.DownsampledHeight + g_Y) * Parameters.DownsampledWidth +
				  g_X) *
				 16);
			*reinterpret_cast<uint4*>(g_PaddingVectorAddress) = make_uint4(0, 0, 0, 0);
		}
	}
}

#endif
