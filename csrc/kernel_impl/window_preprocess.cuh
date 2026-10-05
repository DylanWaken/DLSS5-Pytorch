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

// Input/residual policies let preprocessing reuse the complete window block without duplicating its tensor math.
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

template <bool bFp8, bool bDownsample>
__device__ __forceinline__ void RunPreprocess(const FPreprocessParameters& Parameters)
{
	// Stage one 8x8 window of renderer features before the Half adapter consumes it.
	__shared__ FSharedFeatures s_Features;
	const float Width = __int2float_rn(Parameters.ValidWidth);
	const float Height = __int2float_rn(Parameters.ValidHeight);
	const uint16_t r_ColorScale =
		ConvertFeatureToHalf(NativeFloatAdd(Parameters.ColorScale, Parameters.ColorScale));
	for (int s_Pixel = 32 * threadIdx.y + threadIdx.x; s_Pixel < 64; s_Pixel += 32 * blockDim.y)
	{
		const int g_X = 8 * blockIdx.x + (s_Pixel & 7), g_Y = 8 * blockIdx.y + s_Pixel / 8;
		// Image lookup reflects one border extension; noise still uses original
		// coordinates. This distinction matters in the padded network field.
		const int g_ReflectedX = g_X < Parameters.ValidWidth ? g_X : 2 * Parameters.ValidWidth - g_X - 2;
		const int g_ReflectedY = g_Y < Parameters.ValidHeight ? g_Y : 2 * Parameters.ValidHeight - g_Y - 2;
		const float2 Uv = make_float2(
			NativeFloatDivide(NativeFloatAdd(__int2float_rn(g_ReflectedX), CONST_PIXEL_CENTER), Width),
			NativeFloatDivide(NativeFloatAdd(__int2float_rn(g_ReflectedY), CONST_PIXEL_CENTER), Height));
		const float3 r_Noise = PixelNoise(Parameters.NoiseSeed, g_X, g_Y);
		const float4 r_Current =
			SampleTransformed(Parameters.CurrentTexture, Parameters.CurrentTransform, Uv);
		uint16_t r_CurrentHalf[3], r_HistoryHalf[3];
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			r_HistoryHalf[r_Channel] = r_CurrentHalf[r_Channel] =
				ConditionColor((&r_Current.x)[r_Channel], r_ColorScale);
		if (Parameters.HistoryTexture && Parameters.MotionTexture)
		{
			// Visit the original depth candidates here so motion selection stays with feature staging.
			float2 MotionSampleOffset = make_float2(CONST_ZERO, CONST_ZERO);
			if (Parameters.DepthTexture)
			{
				const float DepthTexelWidth = NativeFloatReciprocal(Parameters.DepthTransform.ScaleX);
				const float DepthTexelHeight = NativeFloatReciprocal(Parameters.DepthTransform.ScaleY);
				float r_BestDepth =
					SampleTransformed(Parameters.DepthTexture, Parameters.DepthTransform, Uv).x;
// The four diagonal candidates are visited TL, TR, BL, BR. Ties and NaNs
// retain the prior sample, exactly as the native unordered comparisons do.
#pragma unroll
				for (int Corner = 0; Corner < 4; ++Corner)
				{
					const float OffsetX = (Corner & 1) ? DepthTexelWidth : -DepthTexelWidth;
					const float OffsetY = (Corner & 2) ? DepthTexelHeight : -DepthTexelHeight;
					const float2 CandidateUv =
						make_float2((Corner & 1) ? NativeFloatAdd(Uv.x, DepthTexelWidth)
												 : NativeFloatSubtract(Uv.x, DepthTexelWidth),
									(Corner & 2) ? NativeFloatAdd(Uv.y, DepthTexelHeight)
												 : NativeFloatSubtract(Uv.y, DepthTexelHeight));
					const float r_CandidateDepth =
						SampleTransformed(Parameters.DepthTexture, Parameters.DepthTransform, CandidateUv).x;
					const bool bKeepPreviousDepth =
						Parameters.bPreferGreaterDepth
							? NativeSetpLeuFtzF32(__float_as_uint(r_CandidateDepth),
												  __float_as_uint(r_BestDepth))
							: NativeSetpGeuFtzF32(__float_as_uint(r_CandidateDepth),
												  __float_as_uint(r_BestDepth));
					if (!bKeepPreviousDepth)
					{
						MotionSampleOffset = make_float2(OffsetX, OffsetY);
						r_BestDepth = r_CandidateDepth;
					}
				}
				MotionSampleOffset.x = NativeFloatMultiply(
					MotionSampleOffset.x,
					NativeFloatDivide(Parameters.DepthTransform.ScaleX, Parameters.MotionTransform.ScaleX));
				MotionSampleOffset.y = NativeFloatMultiply(
					MotionSampleOffset.y,
					NativeFloatDivide(Parameters.DepthTransform.ScaleY, Parameters.MotionTransform.ScaleY));
			}
			const float4 r_Motion =
				SampleTransformed(Parameters.MotionTexture, Parameters.MotionTransform,
								  make_float2(NativeFloatAdd(Uv.x, MotionSampleOffset.x),
											  NativeFloatAdd(Uv.y, MotionSampleOffset.y)));
			const float2 PreviousUv = make_float2(NativeFloatFma(r_Motion.x, Parameters.MotionScaleX, Uv.x),
												  NativeFloatFma(r_Motion.y, Parameters.MotionScaleY, Uv.y));
			const float3 r_History = ReconstructHistory(
				Parameters.HistoryTexture, Parameters.HistoryTransform, PreviousUv, Width, Height);
#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				r_HistoryHalf[r_Channel] = ConditionColor((&r_History.x)[r_Channel], r_ColorScale);
		}

		float r_ConditioningGreen = Parameters.ConditioningGreen,
			  r_ConditioningBlue = Parameters.ConditioningBlue;
		float r_ConditioningOverrideGreen = Parameters.bConditioningOverride ? -CONST_UNIT : CONST_ZERO;
		float r_ConditioningOverrideBlue = r_ConditioningOverrideGreen;
		if (Parameters.bConditioningOverride && !Parameters.ConditioningTexture)
		{
			const bool bExplicitConditioningOverride =
				NativeSetpGeFtzF32(__float_as_uint(NativeFloatMaximum(Parameters.ConditioningOverrideGreen,
																	  Parameters.ConditioningOverrideBlue)),
								   __float_as_uint(CONST_ZERO));
			if (bExplicitConditioningOverride)
			{
				r_ConditioningBlue = CONST_UNIT;
				r_ConditioningOverrideGreen =
					NativeSetpLtuFtzF32(__float_as_uint(Parameters.ConditioningOverrideGreen),
										__float_as_uint(CONST_ZERO))
						? Parameters.ConditioningBlue
						: Parameters.ConditioningOverrideGreen;
				r_ConditioningOverrideBlue =
					NativeSetpLtuFtzF32(__float_as_uint(Parameters.ConditioningOverrideBlue),
										__float_as_uint(CONST_ZERO))
						? Parameters.ConditioningBlue
						: Parameters.ConditioningOverrideBlue;
			}
		}
		else if (Parameters.ConditioningTexture)
		{
			const float4 r_Conditioning =
				SampleTransformed(Parameters.ConditioningTexture, Parameters.ConditioningTransform, Uv);
			r_ConditioningGreen = NativeFloatMultiply(r_Conditioning.y, r_ConditioningGreen);
			r_ConditioningBlue = NativeFloatMultiply(r_Conditioning.z, r_ConditioningBlue);
		}
		s_Features.s_Plane[0][s_Pixel] = make_uint4(
			PackFeatureHalfWords(ConvertFeatureToHalf(r_Noise.x), ConvertFeatureToHalf(r_Noise.y)),
			PackFeatureHalfWords(ConvertFeatureToHalf(r_Noise.z), ConvertFeatureToHalf(CONST_UNIT)),
			PackFeatureHalfWords(r_CurrentHalf[0], r_CurrentHalf[1]),
			PackFeatureHalfWords(r_CurrentHalf[2], r_HistoryHalf[0]));
		s_Features.s_Plane[1][s_Pixel] =
			make_uint4(PackFeatureHalfWords(r_HistoryHalf[1], r_HistoryHalf[2]),
					   PackFeatureHalfWords(ConvertFeatureToHalf(Parameters.ConstantConditioning),
											ConvertFeatureToHalf(r_ConditioningGreen)),
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_ConditioningBlue),
											ConvertFeatureToHalf(r_ConditioningOverrideGreen)),
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_ConditioningOverrideBlue),
											ConvertFeatureToHalf(CONST_ZERO)));
	}
	__syncthreads();
	FWindowAccumulatorTile<32> r_Adapter[4];
	// The 16-to-32 adapter consumes the same two shared Half planes directly.
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
			r_Adapter[r_Tile].r_Pair[r_Column][0] = 0;
			r_Adapter[r_Tile].r_Pair[r_Column][1] = 0;
			MmaWindowFragment<false>(r_Input, r_WeightFragments[r_Column],
									 r_Adapter[r_Tile].r_Pair[r_Column]);
		}
	}
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
