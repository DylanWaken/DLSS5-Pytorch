#pragma once
#include "frontend_math.cuh"

namespace dlssnr::kernels::input_features
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::frontend_math;

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
// meanings of the three conditioning controls remain deliberately unspecified.
struct FParameters
{
	uint64_t g_CurrentTexture, g_HistoryTexture, g_MotionTexture, g_DepthTexture, g_ConditioningTexture;
	FTextureTransform HistoryTransform, MotionTransform, DepthTransform, ConditioningTransform,
		CurrentTransform;
	float r_MotionScaleX, r_MotionScaleY;
	uint32_t bPreferGreaterDepth;
	float r_ConditionA, r_ConditionB, r_ConditionConstant, r_OverrideA, r_OverrideB;
	uint32_t bConditioningOverride;
	float r_ColorScale;
	uint32_t NoiseSeed, Reserved;
	int ValidHeight, ValidWidth;
	uint64_t g_Output, g_Record, ReservedPointer;
	int FullHeight, FullWidth;
	uint64_t g_PooledOutput;
	int PooledHeight, PooledWidth;
};

static_assert(sizeof(FParameters) == 264, "Native preprocessing ABI must stay 264 bytes");
static_assert(offsetof(FParameters, CurrentTransform) == 136);
static_assert(offsetof(FParameters, ValidHeight) == 208);
static_assert(offsetof(FParameters, g_PooledOutput) == 248);

struct FSharedFeatures
{
	// Two 8-channel Half planes, each holding the row-major 8x8 window. The
	// adapter reads these exact planes directly into m16n8k16 A fragments.
	uint4 s_Plane[2][64];
};

__device__ __forceinline__ uint32_t PermuteNoise(uint32_t r_State)
{
	const uint32_t r_Shifted = r_State >> ((r_State >> 28) + 4);
	return (r_Shifted ^ r_State) * CONST_NOISE_PERMUTE_MULTIPLIER;
}

__device__ __forceinline__ float3 PixelNoise(uint32_t NoiseSeed, int g_X, int g_Y)
{
	// Local constexpr tables let the unrolled stream index become an immediate
	// in device code; namespace host arrays cannot be dynamically device-indexed.
	constexpr uint32_t CONST_NOISE_STREAM_MULTIPLIER[4] = {747796405u, 4201498105u, 3399858189u, 2200120369u};
	constexpr uint32_t CONST_NOISE_STREAM_ADDEND[4] = {2891336453u, 1192405134u, 568162667u, 878960812u};
	const uint32_t r_Hash =
		PermuteNoise(uint32_t(g_X) * CONST_NOISE_X_MULTIPLIER ^ uint32_t(g_Y) * CONST_NOISE_Y_MULTIPLIER ^
					 NoiseSeed * CONST_NOISE_FRAME_MULTIPLIER ^ CONST_NOISE_SEED_XOR);
	const uint32_t r_Base = (r_Hash >> 22) ^ r_Hash;
	float r_Uniform[4];
#pragma unroll
	for (int r_Stream = 0; r_Stream < 4; ++r_Stream)
	{
		const uint32_t r_Value = PermuteNoise(r_Base * CONST_NOISE_STREAM_MULTIPLIER[r_Stream] +
											  CONST_NOISE_STREAM_ADDEND[r_Stream]);
		const uint32_t r_UniformInteger = ((r_Value >> 30) ^ (r_Value >> 8)) + 1;
		r_Uniform[r_Stream] = Multiply(__uint2float_rn(r_UniformInteger), CONST_NOISE_UINT24_SCALE);
	}
	float r_Radius[2], r_Angle[2];
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const float r_Log2 = __uint_as_float(NativeLg2ApproxFtzF32(__float_as_uint(r_Uniform[2 * r_Pair])));
		const float r_Log = Multiply(r_Log2, __uint_as_float(CONST_NOISE_LN2_BITS));
		r_Radius[r_Pair] = __uint_as_float(
			NativeSqrtApproxFtzF32(__float_as_uint(Multiply(r_Log, CONST_NOISE_RADIUS_FACTOR))));
		r_Angle[r_Pair] = Multiply(r_Uniform[2 * r_Pair + 1], __uint_as_float(CONST_NOISE_TWO_PI_BITS));
	}
	// Only three of the four Gaussian coordinates are retained by the DLL.
	return make_float3(
		Multiply(r_Radius[0], __uint_as_float(NativeCosApproxFtzF32(__float_as_uint(r_Angle[0])))),
		Multiply(r_Radius[0], __uint_as_float(NativeSinApproxFtzF32(__float_as_uint(r_Angle[0])))),
		Multiply(r_Radius[1], __uint_as_float(NativeCosApproxFtzF32(__float_as_uint(r_Angle[1])))));
}

__device__ __forceinline__ float4 SampleTransformed(uint64_t g_Texture, const FTextureTransform& r_Transform,
													float2 r_Uv)
{
	const float2 r_Coordinates = Transform(r_Transform, r_Uv.x, r_Uv.y);
	return Sample(g_Texture, r_Coordinates.x, r_Coordinates.y);
}

__device__ __forceinline__ float2 SelectMotionOffset(const FParameters& r_Parameters, float2 r_Uv)
{
	float2 r_Selected = make_float2(CONST_ZERO, CONST_ZERO);
	if (!r_Parameters.g_DepthTexture)
		return r_Selected;
	const float r_StepX = Reciprocal(r_Parameters.DepthTransform.r_ScaleX);
	const float r_StepY = Reciprocal(r_Parameters.DepthTransform.r_ScaleY);
	float r_BestDepth = SampleTransformed(r_Parameters.g_DepthTexture, r_Parameters.DepthTransform, r_Uv).x;
// The four diagonal candidates are visited TL, TR, BL, BR. Ties and NaNs
// retain the prior sample, exactly as the native unordered comparisons do.
#pragma unroll
	for (int r_Corner = 0; r_Corner < 4; ++r_Corner)
	{
		const float r_OffsetX = (r_Corner & 1) ? r_StepX : -r_StepX;
		const float r_OffsetY = (r_Corner & 2) ? r_StepY : -r_StepY;
		const float2 r_CandidateUv =
			make_float2((r_Corner & 1) ? Add(r_Uv.x, r_StepX) : Subtract(r_Uv.x, r_StepX),
						(r_Corner & 2) ? Add(r_Uv.y, r_StepY) : Subtract(r_Uv.y, r_StepY));
		const float r_Depth =
			SampleTransformed(r_Parameters.g_DepthTexture, r_Parameters.DepthTransform, r_CandidateUv).x;
		const bool r_bKeep =
			r_Parameters.bPreferGreaterDepth
				? NativeSetpLeuFtzF32(__float_as_uint(r_Depth), __float_as_uint(r_BestDepth))
				: NativeSetpGeuFtzF32(__float_as_uint(r_Depth), __float_as_uint(r_BestDepth));
		if (!r_bKeep)
		{
			r_Selected = make_float2(r_OffsetX, r_OffsetY);
			r_BestDepth = r_Depth;
		}
	}
	r_Selected.x = Multiply(
		r_Selected.x, Divide(r_Parameters.DepthTransform.r_ScaleX, r_Parameters.MotionTransform.r_ScaleX));
	r_Selected.y = Multiply(
		r_Selected.y, Divide(r_Parameters.DepthTransform.r_ScaleY, r_Parameters.MotionTransform.r_ScaleY));
	return r_Selected;
}

__device__ __forceinline__ uint16_t ToHalf(float r_Value)
{
	return NativeCvtRnF16F32(__float_as_uint(r_Value));
}

__device__ __forceinline__ uint32_t HalfWords(uint16_t r_Low, uint16_t r_High)
{
	return uint32_t(r_Low) | uint32_t(r_High) << 16;
}

__device__ __forceinline__ uint16_t ConditionColor(float r_Value, uint16_t r_Scale)
{
	// Keep both Half rounding points: round(texture), subtract 1/2, multiply
	// rounded(2*ColorScale). A float affine transform is not equivalent.
	return NativeMulF16(NativeSubF16(ToHalf(r_Value), ToHalf(CONST_PIXEL_CENTER)), r_Scale);
}

__device__ __forceinline__ void FillFeatures(const FParameters& r_Parameters, FSharedFeatures& s_Features)
{
	const float r_Width = __int2float_rn(r_Parameters.ValidWidth);
	const float r_Height = __int2float_rn(r_Parameters.ValidHeight);
	const uint16_t r_ColorScale = ToHalf(Add(r_Parameters.r_ColorScale, r_Parameters.r_ColorScale));
	for (int s_Pixel = 32 * threadIdx.y + threadIdx.x; s_Pixel < 64; s_Pixel += 32 * blockDim.y)
	{
		const int g_X = 8 * blockIdx.x + (s_Pixel & 7), g_Y = 8 * blockIdx.y + s_Pixel / 8;
		// Image lookup reflects one border extension; noise still uses original
		// coordinates. This distinction matters in the padded network field.
		const int g_ReflectedX = g_X < r_Parameters.ValidWidth ? g_X : 2 * r_Parameters.ValidWidth - g_X - 2;
		const int g_ReflectedY =
			g_Y < r_Parameters.ValidHeight ? g_Y : 2 * r_Parameters.ValidHeight - g_Y - 2;
		const float2 r_Uv =
			make_float2(Divide(Add(__int2float_rn(g_ReflectedX), CONST_PIXEL_CENTER), r_Width),
						Divide(Add(__int2float_rn(g_ReflectedY), CONST_PIXEL_CENTER), r_Height));
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
			const float2 r_Offset = SelectMotionOffset(r_Parameters, r_Uv);
			const float4 r_Motion =
				SampleTransformed(r_Parameters.g_MotionTexture, r_Parameters.MotionTransform,
								  make_float2(Add(r_Uv.x, r_Offset.x), Add(r_Uv.y, r_Offset.y)));
			const float2 r_PreviousUv = make_float2(Fma(r_Motion.x, r_Parameters.r_MotionScaleX, r_Uv.x),
													Fma(r_Motion.y, r_Parameters.r_MotionScaleY, r_Uv.y));
			const float3 r_History =
				ReconstructHistory(r_Parameters.g_HistoryTexture, r_Parameters.HistoryTransform, r_PreviousUv,
								   r_Width, r_Height);
#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				r_HistoryHalf[r_Channel] = ConditionColor((&r_History.x)[r_Channel], r_ColorScale);
		}

		float r_ConditionA = r_Parameters.r_ConditionA, r_ConditionB = r_Parameters.r_ConditionB;
		float r_OverrideA = r_Parameters.bConditioningOverride ? -CONST_UNIT : CONST_ZERO;
		float r_OverrideB = r_OverrideA;
		if (r_Parameters.bConditioningOverride && !r_Parameters.g_ConditioningTexture)
		{
			const bool r_bExplicit = NativeSetpGeFtzF32(
				__float_as_uint(Maximum(r_Parameters.r_OverrideA, r_Parameters.r_OverrideB)),
				__float_as_uint(CONST_ZERO));
			if (r_bExplicit)
			{
				r_ConditionB = CONST_UNIT;
				r_OverrideA = NativeSetpLtuFtzF32(__float_as_uint(r_Parameters.r_OverrideA),
												  __float_as_uint(CONST_ZERO))
								  ? r_Parameters.r_ConditionB
								  : r_Parameters.r_OverrideA;
				r_OverrideB = NativeSetpLtuFtzF32(__float_as_uint(r_Parameters.r_OverrideB),
												  __float_as_uint(CONST_ZERO))
								  ? r_Parameters.r_ConditionB
								  : r_Parameters.r_OverrideB;
			}
		}
		else if (r_Parameters.g_ConditioningTexture)
		{
			const float4 r_Conditioning = SampleTransformed(r_Parameters.g_ConditioningTexture,
															r_Parameters.ConditioningTransform, r_Uv);
			r_ConditionA = Multiply(r_Conditioning.y, r_ConditionA);
			r_ConditionB = Multiply(r_Conditioning.z, r_ConditionB);
		}
		s_Features.s_Plane[0][s_Pixel] = make_uint4(
			HalfWords(ToHalf(r_Noise.x), ToHalf(r_Noise.y)), HalfWords(ToHalf(r_Noise.z), ToHalf(CONST_UNIT)),
			HalfWords(r_CurrentHalf[0], r_CurrentHalf[1]), HalfWords(r_CurrentHalf[2], r_HistoryHalf[0]));
		s_Features.s_Plane[1][s_Pixel] =
			make_uint4(HalfWords(r_HistoryHalf[1], r_HistoryHalf[2]),
					   HalfWords(ToHalf(r_Parameters.r_ConditionConstant), ToHalf(r_ConditionA)),
					   HalfWords(ToHalf(r_ConditionB), ToHalf(r_OverrideA)),
					   HalfWords(ToHalf(r_OverrideB), ToHalf(CONST_ZERO)));
	}
	__syncthreads();
}
#endif
} // namespace dlssnr::kernels::input_features
