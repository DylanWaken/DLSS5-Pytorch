#pragma once
#include "input_features.cuh"
#include "warp_window32.cuh"
#include "window_downsample.cuh"
#include "window_pool.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <bool bFp8> struct FPreprocessWindowProfile : FWindow32Profile<bFp8>
{
	// The adapter is always 16x32 Half, including the FP8 path. It is inserted
	// before the FFN skip scale; subsequent ordinary-record fields shift 1024B.
	static constexpr int AdapterBytes = 16 * 32 * sizeof(__half);
	static constexpr int AdapterOffset = FWindow32Profile<bFp8>::FfnScaleOffset;
	static constexpr int FfnScaleOffset = FWindow32Profile<bFp8>::FfnScaleOffset + AdapterBytes;
	static constexpr int QkvOffset = FWindow32Profile<bFp8>::QkvOffset + AdapterBytes;
	static constexpr int BiasOffset = FWindow32Profile<bFp8>::BiasOffset + AdapterBytes;
	static constexpr int HeadScaleOffset = FWindow32Profile<bFp8>::HeadScaleOffset + AdapterBytes;
	static constexpr int ProjectionOffset = FWindow32Profile<bFp8>::ProjectionOffset + AdapterBytes;
	static constexpr int AttentionScaleOffset = FWindow32Profile<bFp8>::AttentionScaleOffset + AdapterBytes;
};

struct FPreprocessWindowParameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int Height, Width, OriginX, OriginY;
	const FWindowAccumulatorTile<32>* r_Adapter;
};

template <bool bFp8> struct FPreprocessWindowIO : FOrdinaryWindowIO
{
	static constexpr bool bCustomInput = true;
	static constexpr bool bRawResidual = true;
	template <bool bPrecision> using FRecordProfile = FPreprocessWindowProfile<bPrecision>;

	__device__ __forceinline__ static FWindowActivationTile<bFp8>
	Read(const FPreprocessWindowParameters& Parameters, int r_Tile)
	{
		return PublishWindow32<bFp8>(Parameters.r_Adapter[r_Tile]);
	}

	__device__ __forceinline__ static uint32_t Residual(const FPreprocessWindowParameters& Parameters,
														int r_Tile, int r_Column, int r_RowHalf)
	{
		return Parameters.r_Adapter[r_Tile].r_Pair[r_Column][r_RowHalf];
	}
};

template <bool bFp8>
__device__ __forceinline__ void ProjectInputAdapter(const FPreprocessParameters& Parameters,
													const FSharedFeatures& s_Features,
													FWindowAccumulatorTile<32> (&r_Output)[4])
{
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights) +
							FPreprocessWindowProfile<bFp8>::AdapterOffset;
	uint32_t r_WeightFragments[4][2];
#pragma unroll
	for (int r_ColumnPair = 0; r_ColumnPair < 2; ++r_ColumnPair)
	{
		const uint4 r_WeightVector =
			*reinterpret_cast<const uint4*>(g_Weights + r_ColumnPair * 512 + threadIdx.x * 16);
		r_WeightFragments[2 * r_ColumnPair][0] = r_WeightVector.x;
		r_WeightFragments[2 * r_ColumnPair][1] = r_WeightVector.y;
		r_WeightFragments[2 * r_ColumnPair + 1][0] = r_WeightVector.z;
		r_WeightFragments[2 * r_ColumnPair + 1][1] = r_WeightVector.w;
	}
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		FWindowAFragment r_Input;
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			// A word has two adjacent feature channels; its row maps directly
			// into a 4x4 physical tile, with the row-half distance of two pixels.
			const int s_Pixel = 4 * (r_Tile & 1) + 32 * (r_Tile >> 1) + ((threadIdx.x / 4) & 3) +
								8 * (threadIdx.x / 16) + 16 * (r_Word & 1);
			const uint4& s_Channels = s_Features.s_Plane[r_Word / 2][s_Pixel];
			r_Input.r_Word[r_Word] = reinterpret_cast<const uint32_t*>(&s_Channels)[threadIdx.x & 3];
		}
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			r_Output[r_Tile].r_Pair[r_Column][0] = 0;
			r_Output[r_Tile].r_Pair[r_Column][1] = 0;
			MmaWindowFragment<false>(r_Input, r_WeightFragments[r_Column], r_Output[r_Tile].r_Pair[r_Column]);
		}
	}
}

template <bool bFp8, bool bDownsample>
__device__ __forceinline__ void RunPreprocess(const FPreprocessParameters& Parameters,
											  FSharedFeatures& s_Features)
{
	FillFeatures(Parameters, s_Features);
	FWindowAccumulatorTile<32> r_Adapter[4];
	ProjectInputAdapter<bFp8>(Parameters, s_Features, r_Adapter);
	FPreprocessWindowParameters WindowParameters{0,
												 Parameters.g_Output,
												 Parameters.g_PackedWeights,
												 Parameters.FullHeight,
												 Parameters.FullWidth,
												 0,
												 0,
												 r_Adapter};
	if constexpr (bDownsample)
	{
		FWindowAccumulatorTile<32> r_Output[4];
		RunWindow32<bFp8, FPreprocessWindowParameters, FPreprocessWindowIO<bFp8>, true>(WindowParameters,
																						r_Output);
		const auto r_Pooled = PoolWindow(r_Output);
		const FWindowDownsampleArguments DownsampledParameters{0,
															   Parameters.g_Output,
															   Parameters.g_PackedWeights,
															   Parameters.g_PooledOutput,
															   Parameters.FullHeight,
															   Parameters.FullWidth,
															   0,
															   0,
															   Parameters.PooledHeight,
															   Parameters.PooledWidth};
		// The input stage pools C32 directly. Later encoder stages additionally
		// project C -> 2C, which would be an incorrect extra operation here.
		PublishWindowDownsample<32, bFp8>(DownsampledParameters, 0, r_Pooled);
		ClearDownsamplePadding<32, 4>(DownsampledParameters);
	}
	else
		RunWindow32<bFp8, FPreprocessWindowParameters, FPreprocessWindowIO<bFp8>>(WindowParameters);
}
#endif
