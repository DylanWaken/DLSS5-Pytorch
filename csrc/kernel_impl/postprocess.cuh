#pragma once
#include "kernel_launcher/kernel_abi.h"
#include "warp_window32.cuh"
#include "composite.cuh"

namespace dlssnr::kernels::postprocess
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::window32;
using namespace dlssnr::packed_math::sm120;
constexpr uint32_t CONST_WARP_CLAMP = 31u;			 // All 32 lanes form one shuffle segment.
constexpr uint32_t CONST_WARP_MEMBERS = 0xffffffffu; // Every lane participates before boundary stores.

template <bool bFp8> struct FPostProfile : FProfile<bFp8>
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

struct FWindowParameters
{
	uint64_t g_State, g_High, g_Record;
	int Height, Width, OriginX, OriginY;
	const FAccumulatorTile<32>* r_RawInput;
	uint32_t (*r_Head)[2];
};

// The decoder publishes channel planes of 16 bytes/pixel. One warp loads a
// 4x4 low-resolution patch, then broadcasts each pixel to a 2x2 high patch.
// This preserves native scalar loads and avoids materializing an upsampled map.
template <bool bFp8>
__device__ __forceinline__ void MergeInput(uint64_t g_State, uint64_t g_Adapter, uint64_t g_Record,
										   int Height, int Width, int OriginX, int OriginY,
										   FAccumulatorTile<32> (&r_Merged)[4])
{
	using FConfig = FPostProfile<bFp8>;
	const int r_Lane = threadIdx.x;
	const int g_LowHeight = Height / 2, g_LowWidth = Width / 2;
	const int g_OriginX = int(blockIdx.x) * 8 + OriginX;
	const int g_OriginY = int(blockIdx.y) * 8 + OriginY;
	uint32_t r_Low[4][2];
#pragma unroll
	for (int r_Plane = 0; r_Plane < (bFp8 ? 2 : 4); ++r_Plane)
#pragma unroll
		for (int r_Row = 0; r_Row < 2; ++r_Row)
		{
			const int g_X = g_LowWidth == 1 ? 0 : g_OriginX / 2 + (r_Lane / 4) % 4;
			const int g_Y = g_LowHeight == 1 ? 0 : g_OriginY / 2 + r_Lane / 16 + r_Row * 2;
			const bool r_bValid = g_X >= 0 && g_X < g_LowWidth && g_Y >= 0 && g_Y < g_LowHeight;
			const int64_t g_Offset =
				((int64_t(r_Plane) * g_LowHeight + g_Y) * g_LowWidth + g_X) * 16 + (r_Lane & 3) * 4;
			const uint32_t r_Packed = r_bValid ? *reinterpret_cast<const uint32_t*>(g_State + g_Offset) : 0;
			if constexpr (bFp8)
			{
				r_Low[2 * r_Plane][r_Row] = DecodeE4(uint16_t(r_Packed));
				r_Low[2 * r_Plane + 1][r_Row] = DecodeE4(uint16_t(r_Packed >> 16));
			}
			else
				r_Low[r_Plane][r_Row] = r_Packed;
		}

#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		const int g_TileColumns = Width / 4, g_TileRows = Height / 4;
		const int g_X = g_TileColumns == 1 ? 0 : g_OriginX / 4 + (r_Tile & 1);
		const int g_Y = g_TileRows == 1 ? 0 : g_OriginY / 4 + (r_Tile >> 1);
		const bool r_bValid = g_X >= 0 && g_X < g_TileColumns && g_Y >= 0 && g_Y < g_TileRows;
		FActivationTile<bFp8> r_Adapter;
#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
		{
			const int64_t g_Offset =
				int64_t(g_Y * g_TileColumns + g_X) * FConfig::TileBytes + r_Chunk * 512 + r_Lane * 16;
			r_Adapter.r_Reduction[r_Chunk] =
				Fragment(r_bValid ? __ldcg(reinterpret_cast<const uint4*>(g_Adapter + g_Offset))
								  : make_uint4(0, 0, 0, 0));
		}
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			const int g_ScaleByte = r_Column * 16 + (r_Lane & 3) * 4;
			const uint32_t r_InputScale = *reinterpret_cast<const uint32_t*>(
				g_Record + FConfig::CONST_INPUT_SCALE_OFFSET + g_ScaleByte);
			const uint32_t r_AdapterScale = *reinterpret_cast<const uint32_t*>(
				g_Record + FConfig::CONST_ADAPTER_SCALE_OFFSET + g_ScaleByte);
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				const int r_SourceLane =
					(r_Lane & 3) | ((r_Lane >> 1) & 4) | ((r_Tile & 1) * 8) | (r_RowHalf * 16);
				const uint32_t r_Up = ShuffleIdx(r_Low[r_Column][r_Tile >> 1], r_SourceLane, CONST_WARP_CLAMP,
												 CONST_WARP_MEMBERS);
				uint32_t r_Skip;
				if constexpr (bFp8)
					r_Skip =
						DecodeE4(uint16_t(r_Adapter.r_Reduction[0].r_Word[2 * (r_Column / 2) + r_RowHalf] >>
										  (16 * (r_Column & 1))));
				else
					r_Skip = r_Adapter.r_Reduction[r_Column / 2].r_Word[2 * (r_Column & 1) + r_RowHalf];
				// Native SASS rounds the low product, then fuses the adapter product
				// with its addition. An unfixed sum of products may fuse the other side.
				r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf] =
					HalfFma(r_Skip, r_AdapterScale, HalfMul(r_Up, r_InputScale));
			}
		}
	}
}

template <bool bFp8> struct FPostIO : FOrdinaryIO
{
	static constexpr bool bCustomInput = true;
	static constexpr bool bCustomOutput = true;
	static constexpr bool bRawResidual = true;
	template <bool bPrecision> using FRecordProfile = FPostProfile<bPrecision>;

	__device__ __forceinline__ static FActivationTile<bFp8> Read(const FWindowParameters& r_Parameters,
																 int r_Tile)
	{
		return Publish<bFp8>(r_Parameters.r_RawInput[r_Tile]);
	}

	__device__ __forceinline__ static uint32_t Residual(const FWindowParameters& r_Parameters, int r_Tile,
														int r_Column, int r_RowHalf)
	{
		return r_Parameters.r_RawInput[r_Tile].r_Pair[r_Column][r_RowHalf];
	}

	// The physical head record pads four useful output channels to sixteen.
	// Native PTX issues both N8 tiles but never consumes N8 tile 1. The surviving
	// first N8 tile is sufficient; GPU qualification checks all surface pixels.
	__device__ __forceinline__ static void Write(const FWindowParameters& r_Parameters, int r_Tile,
												 const FAccumulatorTile<32>& r_Raw)
	{
		uint32_t r_Result[2] = {0, 0};
#pragma unroll
		for (int r_K = 0; r_K < 2; ++r_K)
		{
			const uint4 r_Weights = __ldca(
				reinterpret_cast<const uint4*>(r_Parameters.g_Record + FPostProfile<bFp8>::CONST_HEAD_OFFSET +
											   r_K * 512 + threadIdx.x * 16));
			const uint32_t r_B[2] = {r_Weights.x, r_Weights.y};
			Mma<false>(PublishChunk<false>(r_Raw, r_K), r_B, r_Result);
		}
		r_Parameters.r_Head[r_Tile][0] = r_Result[0];
		r_Parameters.r_Head[r_Tile][1] = r_Result[1];
	}
};

// Transpose two adjacent 16-token MMA tiles to 32 lanes of RGBA pixels. Each
// packed result gathers channels [0,1] and [2,3]; padded head channels stay dead.
__device__ __forceinline__ uint2 HeadPixel(const uint32_t (&r_Head)[4][2], int r_TileRow)
{
	const int r_Lane = threadIdx.x;
	const int r_LocalRowHalf = r_Lane & 1, r_LocalTile = (r_Lane >> 1) & 1;
	const int r_SourceLane = ((r_Lane & 7) << 2) | (r_Lane >> 3);
	const uint32_t r_Gather[4] = {ShuffleIdx(r_Head[r_TileRow * 2 + r_LocalTile][r_LocalRowHalf],
											 r_SourceLane, CONST_WARP_CLAMP, CONST_WARP_MEMBERS),
								  ShuffleIdx(r_Head[r_TileRow * 2 + r_LocalTile][1 - r_LocalRowHalf],
											 r_SourceLane ^ 1, CONST_WARP_CLAMP, CONST_WARP_MEMBERS),
								  ShuffleIdx(r_Head[r_TileRow * 2 + 1 - r_LocalTile][r_LocalRowHalf],
											 r_SourceLane ^ 2, CONST_WARP_CLAMP, CONST_WARP_MEMBERS),
								  ShuffleIdx(r_Head[r_TileRow * 2 + 1 - r_LocalTile][1 - r_LocalRowHalf],
											 r_SourceLane ^ 3, CONST_WARP_CLAMP, CONST_WARP_MEMBERS)};
	const int r_Select = ((r_Lane >> 3) & 1) | ((r_Lane >> 3) & 2);
	return make_uint2(r_Gather[r_Select], r_Gather[r_Select ^ 1]);
}

__device__ __forceinline__ float FloatParameter(const uint32_t* r_Words, int Offset)
{
	return __uint_as_float(r_Words[Offset / 4]);
}

template <class FParameters>
__device__ __forceinline__ FCompositeParameters CompositeParameters(const FParameters& r_Parameters)
{
	using dlssnr::reconstructed::ParameterU64;
	const uint32_t* r_Words = r_Parameters.Words;
	FCompositeParameters r_Result;
	r_Result.g_Surface = ParameterU64<16>(r_Parameters);
	r_Result.g_Color = ParameterU64<56>(r_Parameters);
	r_Result.g_History = ParameterU64<88>(r_Parameters);
	r_Result.g_Motion = ParameterU64<96>(r_Parameters);
	r_Result.g_BlendScale = ParameterU64<104>(r_Parameters);
	r_Result.ColorTransform = {FloatParameter(r_Words, 64), FloatParameter(r_Words, 68),
							   FloatParameter(r_Words, 72), FloatParameter(r_Words, 76),
							   FloatParameter(r_Words, 80), FloatParameter(r_Words, 84)};
	r_Result.HistoryTransform = {FloatParameter(r_Words, 116), FloatParameter(r_Words, 120),
								 FloatParameter(r_Words, 124), FloatParameter(r_Words, 128),
								 FloatParameter(r_Words, 132), FloatParameter(r_Words, 136)};
	r_Result.MotionTransform = {FloatParameter(r_Words, 140), FloatParameter(r_Words, 144),
								FloatParameter(r_Words, 148), FloatParameter(r_Words, 152),
								FloatParameter(r_Words, 156), FloatParameter(r_Words, 160)};
	r_Result.r_MotionScaleX = FloatParameter(r_Words, 164);
	r_Result.r_MotionScaleY = FloatParameter(r_Words, 168);
	r_Result.r_OutputScale = FloatParameter(r_Words, 48);
	r_Result.bDisplayOutput = r_Words[52 / 4] != 0;
	r_Result.bApplyMotion = r_Words[112 / 4] != 0;
	r_Result.Height = int(r_Words[32 / 4]);
	r_Result.Width = int(r_Words[36 / 4]);
	r_Result.ValidWidth = int(r_Words[172 / 4]);
	r_Result.ValidHeight = int(r_Words[176 / 4]);
	return r_Result;
}

template <bool bFp8, class FParameters>
__device__ __forceinline__ void RunPostprocess(const FParameters& r_Parameters)
{
	using dlssnr::reconstructed::ParameterU64;
	FAccumulatorTile<32> r_RawInput[4];
	uint32_t r_Head[4][2];
	FWindowParameters r_Window = {ParameterU64<0>(r_Parameters),
								  0,
								  ParameterU64<24>(r_Parameters),
								  int(r_Parameters.Words[8]),
								  int(r_Parameters.Words[9]),
								  int(r_Parameters.Words[10]),
								  int(r_Parameters.Words[11]),
								  r_RawInput,
								  r_Head};
	MergeInput<bFp8>(r_Window.g_State, ParameterU64<8>(r_Parameters), r_Window.g_Record, r_Window.Height,
					 r_Window.Width, r_Window.OriginX, r_Window.OriginY, r_RawInput);
	RunWindow32<bFp8, FWindowParameters, FPostIO<bFp8>>(r_Window);
	const FCompositeParameters r_Composite = CompositeParameters(r_Parameters);
#pragma unroll
	for (int r_TileRow = 0; r_TileRow < 2; ++r_TileRow)
	{
		const uint2 r_Pixel = HeadPixel(r_Head, r_TileRow);
		const int g_X = int(blockIdx.x) * 8 + r_Window.OriginX + (threadIdx.x / 16) * 4 + (threadIdx.x & 3);
		const int g_Y = int(blockIdx.y) * 8 + r_Window.OriginY + (threadIdx.x % 16) / 4 + r_TileRow * 4;
		CompositePixel(r_Composite, g_X, g_Y, r_Pixel.x, r_Pixel.y);
	}
}
#endif
} // namespace dlssnr::kernels::postprocess
