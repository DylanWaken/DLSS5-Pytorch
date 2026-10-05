#pragma once
#include "frontend_math.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// These unsigned constants reproduce the native per-frame/pixel hash and its
// four decorrelated streams. They are recovered arithmetic, not an assertion
// about the original author's choice of generator or random seed policy.
constexpr uint32_t CONST_NOISE_FRAME_MULTIPLIER = 2654435769u;
constexpr uint32_t CONST_NOISE_X_MULTIPLIER = 2376512323u;
constexpr uint32_t CONST_NOISE_Y_MULTIPLIER = 3625334849u;
constexpr uint32_t CONST_NOISE_SEED_XOR = 608135816u;
constexpr uint32_t CONST_NOISE_PERMUTE_MULTIPLIER = 277803737u;
constexpr float CONST_NOISE_UINT24_SCALE = 0x1p-24f;
constexpr uint32_t CONST_NOISE_LN2_BITS = 0x3f317218u;	  // 0.6931471824645996.
constexpr uint32_t CONST_NOISE_TWO_PI_BITS = 0x40c90fdbu; // 6.2831854820251465.
constexpr float CONST_NOISE_RADIUS_FACTOR = -2.0f;		  // Box-Muller radius sqrt(-2 ln u).

// ABI names describe how the native code uses each field. Renderer-level
// meanings of the conditioning controls remain deliberately unspecified. Green/Blue
// identify the texture channels used in the feature product, not renderer labels.

static_assert(sizeof(FPreprocessParameters) == 264, "Native preprocessing ABI must stay 264 bytes");
static_assert(offsetof(FPreprocessParameters, CurrentTransform) == 136);
static_assert(offsetof(FPreprocessParameters, ValidHeight) == 208);
static_assert(offsetof(FPreprocessParameters, g_PooledOutput) == 248);

struct FSharedFeatures
{
	// Two 8-channel Half planes, each holding the row-major 8x8 window. The
	// adapter reads these exact planes directly into m16n8k16 A fragments.
	uint4 s_Plane[2][64];
};

__device__ __forceinline__ uint32_t PermuteNoise(uint32_t r_HashState)
{
	const uint32_t r_ShiftedHash = r_HashState >> ((r_HashState >> 28) + 4);
	return (r_ShiftedHash ^ r_HashState) * CONST_NOISE_PERMUTE_MULTIPLIER;
}

__device__ __forceinline__ float3 PixelNoise(uint32_t NoiseSeed, int g_X, int g_Y)
{
	// Local constexpr tables let the unrolled stream index become an immediate
	// in device code; host-scope arrays cannot be dynamically device-indexed.
	constexpr uint32_t CONST_NOISE_STREAM_MULTIPLIER[4] = {747796405u, 4201498105u, 3399858189u, 2200120369u};
	constexpr uint32_t CONST_NOISE_STREAM_ADDEND[4] = {2891336453u, 1192405134u, 568162667u, 878960812u};
	const uint32_t r_Hash =
		PermuteNoise(uint32_t(g_X) * CONST_NOISE_X_MULTIPLIER ^ uint32_t(g_Y) * CONST_NOISE_Y_MULTIPLIER ^
					 NoiseSeed * CONST_NOISE_FRAME_MULTIPLIER ^ CONST_NOISE_SEED_XOR);
	const uint32_t r_PixelHash = (r_Hash >> 22) ^ r_Hash;
	float r_Uniform[4];
#pragma unroll
	for (int r_Stream = 0; r_Stream < 4; ++r_Stream)
	{
		const uint32_t r_StreamHash = PermuteNoise(r_PixelHash * CONST_NOISE_STREAM_MULTIPLIER[r_Stream] +
												   CONST_NOISE_STREAM_ADDEND[r_Stream]);
		const uint32_t r_UniformInteger = ((r_StreamHash >> 30) ^ (r_StreamHash >> 8)) + 1;
		r_Uniform[r_Stream] =
			NativeFloatMultiply(__uint2float_rn(r_UniformInteger), CONST_NOISE_UINT24_SCALE);
	}
	float r_Radius[2], r_Angle[2];
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const float r_Log2 = __uint_as_float(NativeLg2ApproxFtzF32(__float_as_uint(r_Uniform[2 * r_Pair])));
		const float r_Log = NativeFloatMultiply(r_Log2, __uint_as_float(CONST_NOISE_LN2_BITS));
		r_Radius[r_Pair] = __uint_as_float(
			NativeSqrtApproxFtzF32(__float_as_uint(NativeFloatMultiply(r_Log, CONST_NOISE_RADIUS_FACTOR))));
		r_Angle[r_Pair] =
			NativeFloatMultiply(r_Uniform[2 * r_Pair + 1], __uint_as_float(CONST_NOISE_TWO_PI_BITS));
	}
	// Only three of the four Gaussian coordinates are retained by the DLL.
	return make_float3(
		NativeFloatMultiply(r_Radius[0], __uint_as_float(NativeCosApproxFtzF32(__float_as_uint(r_Angle[0])))),
		NativeFloatMultiply(r_Radius[0], __uint_as_float(NativeSinApproxFtzF32(__float_as_uint(r_Angle[0])))),
		NativeFloatMultiply(r_Radius[1],
							__uint_as_float(NativeCosApproxFtzF32(__float_as_uint(r_Angle[1])))));
}

__device__ __forceinline__ float4 SampleTransformed(uint64_t g_Texture, const FTextureTransform& r_Transform,
													float2 r_Uv)
{
	const float2 r_Coordinates = TransformTextureCoordinates(r_Transform, r_Uv.x, r_Uv.y);
	return SampleTexture(g_Texture, r_Coordinates.x, r_Coordinates.y);
}

__device__ __forceinline__ float2 SelectMotionOffset(const FPreprocessParameters& r_Parameters, float2 r_Uv)
{
	float2 r_SelectedMotionOffset = make_float2(CONST_ZERO, CONST_ZERO);
	if (!r_Parameters.g_DepthTexture)
		return r_SelectedMotionOffset;
	const float r_DepthTexelWidth = NativeFloatReciprocal(r_Parameters.DepthTransform.r_ScaleX);
	const float r_DepthTexelHeight = NativeFloatReciprocal(r_Parameters.DepthTransform.r_ScaleY);
	float r_BestDepth = SampleTransformed(r_Parameters.g_DepthTexture, r_Parameters.DepthTransform, r_Uv).x;
// The four diagonal candidates are visited TL, TR, BL, BR. Ties and NaNs
// retain the prior sample, exactly as the native unordered comparisons do.
#pragma unroll
	for (int r_Corner = 0; r_Corner < 4; ++r_Corner)
	{
		const float r_OffsetX = (r_Corner & 1) ? r_DepthTexelWidth : -r_DepthTexelWidth;
		const float r_OffsetY = (r_Corner & 2) ? r_DepthTexelHeight : -r_DepthTexelHeight;
		const float2 r_CandidateUv =
			make_float2((r_Corner & 1) ? NativeFloatAdd(r_Uv.x, r_DepthTexelWidth)
									   : NativeFloatSubtract(r_Uv.x, r_DepthTexelWidth),
						(r_Corner & 2) ? NativeFloatAdd(r_Uv.y, r_DepthTexelHeight)
									   : NativeFloatSubtract(r_Uv.y, r_DepthTexelHeight));
		const float r_CandidateDepth =
			SampleTransformed(r_Parameters.g_DepthTexture, r_Parameters.DepthTransform, r_CandidateUv).x;
		const bool r_bKeepPreviousDepth =
			r_Parameters.bPreferGreaterDepth
				? NativeSetpLeuFtzF32(__float_as_uint(r_CandidateDepth), __float_as_uint(r_BestDepth))
				: NativeSetpGeuFtzF32(__float_as_uint(r_CandidateDepth), __float_as_uint(r_BestDepth));
		if (!r_bKeepPreviousDepth)
		{
			r_SelectedMotionOffset = make_float2(r_OffsetX, r_OffsetY);
			r_BestDepth = r_CandidateDepth;
		}
	}
	r_SelectedMotionOffset.x = NativeFloatMultiply(
		r_SelectedMotionOffset.x,
		NativeFloatDivide(r_Parameters.DepthTransform.r_ScaleX, r_Parameters.MotionTransform.r_ScaleX));
	r_SelectedMotionOffset.y = NativeFloatMultiply(
		r_SelectedMotionOffset.y,
		NativeFloatDivide(r_Parameters.DepthTransform.r_ScaleY, r_Parameters.MotionTransform.r_ScaleY));
	return r_SelectedMotionOffset;
}

__device__ __forceinline__ uint16_t ConvertFeatureToHalf(float r_InputValue)
{
	return NativeCvtRnF16F32(__float_as_uint(r_InputValue));
}

__device__ __forceinline__ uint32_t PackFeatureHalfWords(uint16_t r_LowerHalfword, uint16_t r_UpperHalfword)
{
	return uint32_t(r_LowerHalfword) | uint32_t(r_UpperHalfword) << 16;
}

__device__ __forceinline__ uint16_t ConditionColor(float r_ColorSample, uint16_t r_ColorScaleHalf)
{
	// Keep both Half rounding points: round(texture), subtract 1/2, multiply
	// rounded(2*ColorScale). A float affine transform is not equivalent.
	return NativeMulF16(
		NativeSubF16(ConvertFeatureToHalf(r_ColorSample), ConvertFeatureToHalf(CONST_PIXEL_CENTER)),
		r_ColorScaleHalf);
}

__device__ __forceinline__ void FillFeatures(const FPreprocessParameters& r_Parameters,
											 FSharedFeatures& s_Features)
{
	const float r_Width = __int2float_rn(r_Parameters.ValidWidth);
	const float r_Height = __int2float_rn(r_Parameters.ValidHeight);
	const uint16_t r_ColorScale =
		ConvertFeatureToHalf(NativeFloatAdd(r_Parameters.r_ColorScale, r_Parameters.r_ColorScale));
	for (int s_Pixel = 32 * threadIdx.y + threadIdx.x; s_Pixel < 64; s_Pixel += 32 * blockDim.y)
	{
		const int g_X = 8 * blockIdx.x + (s_Pixel & 7), g_Y = 8 * blockIdx.y + s_Pixel / 8;
		// Image lookup reflects one border extension; noise still uses original
		// coordinates. This distinction matters in the padded network field.
		const int g_ReflectedX = g_X < r_Parameters.ValidWidth ? g_X : 2 * r_Parameters.ValidWidth - g_X - 2;
		const int g_ReflectedY =
			g_Y < r_Parameters.ValidHeight ? g_Y : 2 * r_Parameters.ValidHeight - g_Y - 2;
		const float2 r_Uv = make_float2(
			NativeFloatDivide(NativeFloatAdd(__int2float_rn(g_ReflectedX), CONST_PIXEL_CENTER), r_Width),
			NativeFloatDivide(NativeFloatAdd(__int2float_rn(g_ReflectedY), CONST_PIXEL_CENTER), r_Height));
		const float3 r_Noise = PixelNoise(r_Parameters.NoiseSeed, g_X, g_Y);
		const float4 r_Current =
			SampleTransformed(r_Parameters.g_CurrentTexture, r_Parameters.CurrentTransform, r_Uv);
		uint16_t r_CurrentHalf[3], r_HistoryHalf[3];
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			r_HistoryHalf[r_Channel] = r_CurrentHalf[r_Channel] =
				ConditionColor((&r_Current.x)[r_Channel], r_ColorScale);
		if (r_Parameters.g_HistoryTexture && r_Parameters.g_MotionTexture)
		{
			const float2 r_MotionSampleOffset = SelectMotionOffset(r_Parameters, r_Uv);
			const float4 r_Motion =
				SampleTransformed(r_Parameters.g_MotionTexture, r_Parameters.MotionTransform,
								  make_float2(NativeFloatAdd(r_Uv.x, r_MotionSampleOffset.x),
											  NativeFloatAdd(r_Uv.y, r_MotionSampleOffset.y)));
			const float2 r_PreviousUv =
				make_float2(NativeFloatFma(r_Motion.x, r_Parameters.r_MotionScaleX, r_Uv.x),
							NativeFloatFma(r_Motion.y, r_Parameters.r_MotionScaleY, r_Uv.y));
			const float3 r_History =
				ReconstructHistory(r_Parameters.g_HistoryTexture, r_Parameters.HistoryTransform, r_PreviousUv,
								   r_Width, r_Height);
#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				r_HistoryHalf[r_Channel] = ConditionColor((&r_History.x)[r_Channel], r_ColorScale);
		}

		float r_ConditioningGreen = r_Parameters.r_ConditioningGreen,
			  r_ConditioningBlue = r_Parameters.r_ConditioningBlue;
		float r_ConditioningOverrideGreen = r_Parameters.bConditioningOverride ? -CONST_UNIT : CONST_ZERO;
		float r_ConditioningOverrideBlue = r_ConditioningOverrideGreen;
		if (r_Parameters.bConditioningOverride && !r_Parameters.g_ConditioningTexture)
		{
			const bool r_bExplicitConditioningOverride = NativeSetpGeFtzF32(
				__float_as_uint(NativeFloatMaximum(r_Parameters.r_ConditioningOverrideGreen,
												   r_Parameters.r_ConditioningOverrideBlue)),
				__float_as_uint(CONST_ZERO));
			if (r_bExplicitConditioningOverride)
			{
				r_ConditioningBlue = CONST_UNIT;
				r_ConditioningOverrideGreen =
					NativeSetpLtuFtzF32(__float_as_uint(r_Parameters.r_ConditioningOverrideGreen),
										__float_as_uint(CONST_ZERO))
						? r_Parameters.r_ConditioningBlue
						: r_Parameters.r_ConditioningOverrideGreen;
				r_ConditioningOverrideBlue =
					NativeSetpLtuFtzF32(__float_as_uint(r_Parameters.r_ConditioningOverrideBlue),
										__float_as_uint(CONST_ZERO))
						? r_Parameters.r_ConditioningBlue
						: r_Parameters.r_ConditioningOverrideBlue;
			}
		}
		else if (r_Parameters.g_ConditioningTexture)
		{
			const float4 r_Conditioning = SampleTransformed(r_Parameters.g_ConditioningTexture,
															r_Parameters.ConditioningTransform, r_Uv);
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
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_Parameters.r_ConstantConditioning),
											ConvertFeatureToHalf(r_ConditioningGreen)),
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_ConditioningBlue),
											ConvertFeatureToHalf(r_ConditioningOverrideGreen)),
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_ConditioningOverrideBlue),
											ConvertFeatureToHalf(CONST_ZERO)));
	}
	__syncthreads();
}
#endif
