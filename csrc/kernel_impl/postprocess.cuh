#pragma once
#include "kernel_launcher/kernel_abi.h"
#include "warp_window32.cuh"
#include "composite.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
constexpr uint32_t CONST_WARP_CLAMP = 31u;			 // All 32 lanes form one shuffle segment.
constexpr uint32_t CONST_WARP_MEMBERS = 0xffffffffu; // Every lane participates before boundary stores.

template <bool bFp8> struct FPostprocessWindowProfile : FWindow32Profile<bFp8>
{
	static constexpr int FfnScaleOffset = bFp8 ? 8208 : 16400;
	static constexpr int QkvOffset = bFp8 ? 8400 : 16592;
	static constexpr int BiasOffset = bFp8 ? 11472 : 22736;
	static constexpr int HeadScaleOffset = bFp8 ? 19664 : 30928;
	static constexpr int ProjectionOffset = bFp8 ? 19680 : 30944;
	static constexpr int AttentionScaleOffset = bFp8 ? 20704 : 32992;
	static constexpr int CONST_INPUT_SCALE_OFFSET = bFp8 ? 8272 : 16464;
	static constexpr int CONST_ADAPTER_SCALE_OFFSET = bFp8 ? 8336 : 16528;
	static constexpr int CONST_HEAD_OFFSET = bFp8 ? 20784 : 33072;
};

struct FPostprocessWindowParameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int Height, Width, OriginX, OriginY;
	const FWindowAccumulatorTile<32>* r_RawInput;
	uint32_t (*r_Head)[2];
};

// The decoder publishes channel planes of 16 bytes/pixel. One warp loads a
// 4x4 low-resolution patch, then broadcasts each pixel to a 2x2 high patch.
// This preserves native scalar loads and avoids materializing an upsampled map.
template <bool bFp8>
__device__ __forceinline__ void
MergePostprocessInput(uint64_t g_Input, uint64_t g_Adapter, uint64_t g_PackedWeights, int Height, int Width,
					  int OriginX, int OriginY, FWindowAccumulatorTile<32> (&r_Merged)[4])
{
	using FConfig = FPostprocessWindowProfile<bFp8>;
	const int Lane = threadIdx.x;
	const int g_LowHeight = Height / 2, g_LowWidth = Width / 2;
	const int g_OriginX = int(blockIdx.x) * 8 + OriginX;
	const int g_OriginY = int(blockIdx.y) * 8 + OriginY;
	uint32_t r_LowResolutionPairs[4][2];
#pragma unroll
	for (int r_Plane = 0; r_Plane < (bFp8 ? 2 : 4); ++r_Plane)
#pragma unroll
		for (int r_Row = 0; r_Row < 2; ++r_Row)
		{
			const int g_X = g_LowWidth == 1 ? 0 : g_OriginX / 2 + (Lane / 4) % 4;
			const int g_Y = g_LowHeight == 1 ? 0 : g_OriginY / 2 + Lane / 16 + r_Row * 2;
			const bool bValid = g_X >= 0 && g_X < g_LowWidth && g_Y >= 0 && g_Y < g_LowHeight;
			const int64_t g_Offset =
				((int64_t(r_Plane) * g_LowHeight + g_Y) * g_LowWidth + g_X) * 16 + (Lane & 3) * 4;
			const uint32_t r_InputWord = bValid ? *reinterpret_cast<const uint32_t*>(g_Input + g_Offset) : 0;
			if constexpr (bFp8)
			{
				r_LowResolutionPairs[2 * r_Plane][r_Row] = DecodeE4(uint16_t(r_InputWord));
				r_LowResolutionPairs[2 * r_Plane + 1][r_Row] = DecodeE4(uint16_t(r_InputWord >> 16));
			}
			else
				r_LowResolutionPairs[r_Plane][r_Row] = r_InputWord;
		}

#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		const int g_TileColumns = Width / 4, g_TileRows = Height / 4;
		const int g_X = g_TileColumns == 1 ? 0 : g_OriginX / 4 + (r_Tile & 1);
		const int g_Y = g_TileRows == 1 ? 0 : g_OriginY / 4 + (r_Tile >> 1);
		const bool bValid = g_X >= 0 && g_X < g_TileColumns && g_Y >= 0 && g_Y < g_TileRows;
		FWindowActivationTile<bFp8> r_Adapter;
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
		{
			const int64_t g_Offset =
				int64_t(g_Y * g_TileColumns + g_X) * FConfig::TileBytes + r_Chunk * 512 + Lane * 16;
			r_Adapter.r_Reduction[r_Chunk] =
				MakeWindowFragment(bValid ? __ldcg(reinterpret_cast<const uint4*>(g_Adapter + g_Offset))
										  : make_uint4(0, 0, 0, 0));
		}
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			const int g_ScaleByte = r_Column * 16 + (Lane & 3) * 4;
			const uint32_t r_InputScale = *reinterpret_cast<const uint32_t*>(
				g_PackedWeights + FConfig::CONST_INPUT_SCALE_OFFSET + g_ScaleByte);
			const uint32_t r_AdapterScale = *reinterpret_cast<const uint32_t*>(
				g_PackedWeights + FConfig::CONST_ADAPTER_SCALE_OFFSET + g_ScaleByte);
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				const int SourceLane = (Lane & 3) | ((Lane >> 1) & 4) | ((r_Tile & 1) * 8) | (r_RowHalf * 16);
				const uint32_t r_UpsampledPair = ShuffleIdx(r_LowResolutionPairs[r_Column][r_Tile >> 1],
															SourceLane, CONST_WARP_CLAMP, CONST_WARP_MEMBERS);
				uint32_t r_AdapterPair;
				if constexpr (bFp8)
					r_AdapterPair =
						DecodeE4(uint16_t(r_Adapter.r_Reduction[0].r_Word[2 * (r_Column / 2) + r_RowHalf] >>
										  (16 * (r_Column & 1))));
				else
					r_AdapterPair =
						r_Adapter.r_Reduction[r_Column / 2].r_Word[2 * (r_Column & 1) + r_RowHalf];
				// Native SASS rounds the low product, then fuses the adapter product
				// with its addition. An unfixed sum of products may fuse the other side.
				r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf] =
					HalfFma(r_AdapterPair, r_AdapterScale, HalfMul(r_UpsampledPair, r_InputScale));
			}
		}
	}
}

template <bool bFp8> struct FPostprocessWindowIO : FOrdinaryWindowIO
{
	static constexpr bool bCustomInput = true;
	static constexpr bool bCustomOutput = true;
	static constexpr bool bRawResidual = true;
	template <bool bPrecision> using FRecordProfile = FPostprocessWindowProfile<bPrecision>;

	__device__ __forceinline__ static FWindowActivationTile<bFp8>
	Read(const FPostprocessWindowParameters& Parameters, int r_Tile)
	{
		return PublishWindow32<bFp8>(Parameters.r_RawInput[r_Tile]);
	}

	__device__ __forceinline__ static uint32_t Residual(const FPostprocessWindowParameters& Parameters,
														int r_Tile, int r_Column, int r_RowHalf)
	{
		return Parameters.r_RawInput[r_Tile].r_Pair[r_Column][r_RowHalf];
	}

	// The physical head record pads four useful output channels to sixteen.
	// Native PTX issues both N8 tiles but never consumes N8 tile 1. The surviving
	// first N8 tile is sufficient; GPU qualification checks all surface pixels.
	__device__ __forceinline__ static void Write(const FPostprocessWindowParameters& Parameters, int r_Tile,
												 const FWindowAccumulatorTile<32>& r_WindowOutput)
	{
		uint32_t r_HeadAccumulator[2] = {0, 0};
#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < 2; ++r_ReductionChunk)
		{
			const uint4 r_Weights = __ldca(reinterpret_cast<const uint4*>(
				Parameters.g_PackedWeights + FPostprocessWindowProfile<bFp8>::CONST_HEAD_OFFSET +
				r_ReductionChunk * 512 + threadIdx.x * 16));
			const uint32_t r_HeadWeightFragment[2] = {r_Weights.x, r_Weights.y};
			MmaWindowFragment<false>(PublishWindowChunk<false>(r_WindowOutput, r_ReductionChunk),
									 r_HeadWeightFragment, r_HeadAccumulator);
		}
		Parameters.r_Head[r_Tile][0] = r_HeadAccumulator[0];
		Parameters.r_Head[r_Tile][1] = r_HeadAccumulator[1];
	}
};

// Transpose two adjacent 16-token MMA tiles to 32 lanes of RGBA pixels. Each
// packed result gathers channels [0,1] and [2,3]; padded head channels stay dead.
__device__ __forceinline__ uint2 HeadOutputPixel(const uint32_t (&r_Head)[4][2], int r_TileRow)
{
	const int Lane = threadIdx.x;
	const int r_LocalRowHalf = Lane & 1, r_LocalTile = (Lane >> 1) & 1;
	const int SourceLane = ((Lane & 7) << 2) | (Lane >> 3);
	const uint32_t r_GatheredHeadWords[4] = {
		ShuffleIdx(r_Head[r_TileRow * 2 + r_LocalTile][r_LocalRowHalf], SourceLane, CONST_WARP_CLAMP,
				   CONST_WARP_MEMBERS),
		ShuffleIdx(r_Head[r_TileRow * 2 + r_LocalTile][1 - r_LocalRowHalf], SourceLane ^ 1, CONST_WARP_CLAMP,
				   CONST_WARP_MEMBERS),
		ShuffleIdx(r_Head[r_TileRow * 2 + 1 - r_LocalTile][r_LocalRowHalf], SourceLane ^ 2, CONST_WARP_CLAMP,
				   CONST_WARP_MEMBERS),
		ShuffleIdx(r_Head[r_TileRow * 2 + 1 - r_LocalTile][1 - r_LocalRowHalf], SourceLane ^ 3,
				   CONST_WARP_CLAMP, CONST_WARP_MEMBERS)};
	const int r_PixelWordIndex = ((Lane >> 3) & 1) | ((Lane >> 3) & 2);
	return make_uint2(r_GatheredHeadWords[r_PixelWordIndex], r_GatheredHeadWords[r_PixelWordIndex ^ 1]);
}

template <class FParameters>
__device__ __forceinline__ FCompositeParameters MakeCompositeParameters(const FParameters& Parameters)
{
	return {Parameters.OutputSurface,	 Parameters.ColorTexture,
			Parameters.HistoryTexture,	 Parameters.MotionTexture,
			Parameters.g_BlendScale,	 Parameters.ColorTransform,
			Parameters.HistoryTransform, Parameters.MotionTransform,
			Parameters.OutputScale,		 Parameters.MotionScaleX,
			Parameters.MotionScaleY,	 Parameters.Width,
			Parameters.Height,			 Parameters.ValidWidth,
			Parameters.ValidHeight,		 Parameters.bDisplayOutput != 0,
			Parameters.bApplyMotion != 0};
}

template <bool bFp8, class FParameters>
__device__ __forceinline__ void RunPostprocess(const FParameters& Parameters)
{
	FWindowAccumulatorTile<32> r_RawInput[4];
	uint32_t r_Head[4][2];
	FPostprocessWindowParameters WindowParameters = {Parameters.g_Input,
													 0,
													 Parameters.g_PackedWeights,
													 Parameters.Height,
													 Parameters.Width,
													 Parameters.OriginX,
													 Parameters.OriginY,
													 r_RawInput,
													 r_Head};
	MergePostprocessInput<bFp8>(WindowParameters.g_Input, Parameters.g_Adapter,
								WindowParameters.g_PackedWeights, WindowParameters.Height,
								WindowParameters.Width, WindowParameters.OriginX, WindowParameters.OriginY,
								r_RawInput);
	RunWindow32<bFp8, FPostprocessWindowParameters, FPostprocessWindowIO<bFp8>>(WindowParameters);
	const FCompositeParameters CompositeParameters = MakeCompositeParameters(Parameters);
#pragma unroll
	for (int r_TileRow = 0; r_TileRow < 2; ++r_TileRow)
	{
		const uint2 r_Pixel = HeadOutputPixel(r_Head, r_TileRow);
		const int g_X =
			int(blockIdx.x) * 8 + WindowParameters.OriginX + (threadIdx.x / 16) * 4 + (threadIdx.x & 3);
		const int g_Y =
			int(blockIdx.y) * 8 + WindowParameters.OriginY + (threadIdx.x % 16) / 4 + r_TileRow * 4;
		CompositePixel(CompositeParameters, g_X, g_Y, r_Pixel.x, r_Pixel.y);
	}
}
#endif
