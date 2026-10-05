#pragma once
#include "kernel_impl/intrinsics.cuh"
#include "kernel_launcher/kernel_abi.h"

namespace dlssnr::kernels::frontend_math
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;

// Verified PTX values and roles, not inferred model hyperparameters.
constexpr float CONST_PIXEL_CENTER = 0.5f;			 // Sample texel centers.
constexpr float CONST_COLOR_RESIDUAL_SCALE = 0.125f; // Current-color texture -> neural range.
constexpr float CONST_COLOR_RESIDUAL_BIAS = -0.0625f;
constexpr float CONST_COLOR_DISPLAY_SCALE = 8.0f; // Neural range -> output code value.
constexpr float CONST_COLOR_DISPLAY_BIAS = 0.5f;
constexpr float CONST_CUBIC_OUTER_FACTOR = -0.5f; // Cubic outer tap polynomial.
constexpr float CONST_CUBIC_CUBE_FACTOR = 1.5f;
constexpr float CONST_CUBIC_SQUARE_FACTOR = 2.5f;
constexpr float CONST_CUBIC_FAR_DISTANCE = 2.0f;
constexpr float CONST_UNIT = 1.0f;
constexpr float CONST_ZERO = 0.0f;
constexpr uint32_t CONST_NEGATIVE_LOG2_E_BITS =
	0xbfb8aa3bu; // -1.4426950216293335, sigmoid's exp2 conversion.
constexpr uint32_t CONST_FP32_INFINITY_BITS = 0x7f800000u;

// Explicit native operations keep FTZ, approximate reciprocal/division and
// individual rounding points. These wrappers carry values, not PTX register IDs.
__device__ __forceinline__ float Add(float r_LeftOperand, float r_RightOperand)
{
	return __uint_as_float(NativeAddFtzF32(__float_as_uint(r_LeftOperand), __float_as_uint(r_RightOperand)));
}

__device__ __forceinline__ float Subtract(float r_LeftOperand, float r_RightOperand)
{
	return __uint_as_float(NativeSubFtzF32(__float_as_uint(r_LeftOperand), __float_as_uint(r_RightOperand)));
}

__device__ __forceinline__ float Multiply(float r_LeftOperand, float r_RightOperand)
{
	return __uint_as_float(NativeMulFtzF32(__float_as_uint(r_LeftOperand), __float_as_uint(r_RightOperand)));
}

__device__ __forceinline__ float Fma(float r_Multiplicand, float r_Multiplier, float r_Addend)
{
	return __uint_as_float(NativeFmaRnFtzF32(__float_as_uint(r_Multiplicand), __float_as_uint(r_Multiplier),
											 __float_as_uint(r_Addend)));
}

__device__ __forceinline__ float Divide(float r_Numerator, float r_Denominator)
{
	return __uint_as_float(
		NativeDivApproxFtzF32(__float_as_uint(r_Numerator), __float_as_uint(r_Denominator)));
}

__device__ __forceinline__ float Reciprocal(float r_InputValue)
{
	return __uint_as_float(NativeRcpApproxFtzF32(__float_as_uint(r_InputValue)));
}

__device__ __forceinline__ float Minimum(float r_LeftOperand, float r_RightOperand)
{
	return __uint_as_float(NativeMinFtzF32(__float_as_uint(r_LeftOperand), __float_as_uint(r_RightOperand)));
}

__device__ __forceinline__ float Maximum(float r_LeftOperand, float r_RightOperand)
{
	return __uint_as_float(NativeMaxFtzF32(__float_as_uint(r_LeftOperand), __float_as_uint(r_RightOperand)));
}

__device__ __forceinline__ float Floor(float r_InputValue)
{
	return __uint_as_float(NativeCvtRmiFtzF32F32(__float_as_uint(r_InputValue)));
}

__device__ __forceinline__ float ClampUnit(float r_InputValue)
{
	return Minimum(CONST_UNIT, Maximum(CONST_ZERO, r_InputValue));
}

using FTextureTransform = dlssnr::reconstructed::frontend_abi::FTextureTransform;

// The two affine transforms are applied before the texture descriptor's own
// filtering/address modes. Their order matches the native parameter contract.
__device__ __forceinline__ float2 Transform(const FTextureTransform& r_Transform, float r_InputX,
											float r_InputY)
{
	return make_float2(
		Multiply(r_Transform.r_NormalizeX, Fma(r_Transform.r_ScaleX, r_InputX, r_Transform.r_BiasX)),
		Multiply(r_Transform.r_NormalizeY, Fma(r_Transform.r_ScaleY, r_InputY, r_Transform.r_BiasY)));
}

__device__ __forceinline__ float4 Sample(uint64_t g_Texture, float r_TextureX, float r_TextureY)
{
	const uint4 r_SampleBits =
		NativeTexture2d(g_Texture, __float_as_uint(r_TextureX), __float_as_uint(r_TextureY));
	return make_float4(__uint_as_float(r_SampleBits.x), __uint_as_float(r_SampleBits.y),
					   __uint_as_float(r_SampleBits.z), __uint_as_float(r_SampleBits.w));
}

struct FCubicAxis
{
	float r_Weight[3]; // Outer left, merged middle pair, outer right.
	float r_Position[3];
};

__device__ __forceinline__ FCubicAxis CubicAxis(float r_PixelPosition, float r_Extent)
{
	const float r_Center = Add(Floor(Add(r_PixelPosition, -CONST_PIXEL_CENTER)), CONST_PIXEL_CENTER);
	const float r_Fraction = Minimum(Maximum(Subtract(r_PixelPosition, r_Center), CONST_ZERO), CONST_UNIT);
	const float r_Square = Multiply(r_Fraction, r_Fraction);
	const float r_Cube = Multiply(r_Fraction, r_Square);
	const float r_LeftWeight = Fma(Add(r_Fraction, r_Cube), CONST_CUBIC_OUTER_FACTOR, r_Square);
	const float r_MiddleLeftWeight = Add(
		Subtract(Multiply(r_Cube, CONST_CUBIC_CUBE_FACTOR), Multiply(r_Square, CONST_CUBIC_SQUARE_FACTOR)),
		CONST_UNIT);
	const float r_RightWeight = Multiply(Subtract(r_Cube, r_Square), CONST_PIXEL_CENTER);
	const float r_MiddleRightWeight =
		Subtract(Subtract(Subtract(CONST_UNIT, r_LeftWeight), r_MiddleLeftWeight), r_RightWeight);
	const float r_MiddleWeight = Add(r_MiddleLeftWeight, r_MiddleRightWeight);
	const float r_LastCenter = Add(r_Extent, -CONST_PIXEL_CENTER);
	FCubicAxis r_Filter;
	r_Filter.r_Weight[0] = r_LeftWeight;
	r_Filter.r_Weight[1] = r_MiddleWeight;
	r_Filter.r_Weight[2] = r_RightWeight;
	r_Filter.r_Position[0] = Minimum(Maximum(Add(r_Center, -CONST_UNIT), CONST_PIXEL_CENTER), r_LastCenter);
	r_Filter.r_Position[1] =
		Minimum(Maximum(Add(Divide(r_MiddleRightWeight, r_MiddleWeight), r_Center), CONST_PIXEL_CENTER),
				r_LastCenter);
	r_Filter.r_Position[2] =
		Minimum(Maximum(Add(r_Center, CONST_CUBIC_FAR_DISTANCE), CONST_PIXEL_CENTER), r_LastCenter);
	return r_Filter;
}

// Five filtered samples form a cross: left/top/center/bottom/right. The original
// omits four corner products and renormalizes the retained weights. The cubic
// coefficients match Catmull-Rom algebra; naming its intended filter is inferred.
__device__ __forceinline__ float3 ReconstructHistory(uint64_t g_History, const FTextureTransform& r_Transform,
													 float2 r_Uv, float r_Width, float r_Height)
{
	const FCubicAxis r_HorizontalFilter = CubicAxis(Multiply(r_Uv.x, r_Width), r_Width);
	const FCubicAxis r_VerticalFilter = CubicAxis(Multiply(r_Uv.y, r_Height), r_Height);
	const float r_InvWidth = Reciprocal(r_Width), r_InvHeight = Reciprocal(r_Height);
	float r_SampleX[3], r_SampleY[3];
#pragma unroll
	for (int r_Tap = 0; r_Tap < 3; ++r_Tap)
	{
		r_SampleX[r_Tap] =
			Multiply(r_Transform.r_NormalizeX,
					 Fma(r_Transform.r_ScaleX, Multiply(r_InvWidth, r_HorizontalFilter.r_Position[r_Tap]),
						 r_Transform.r_BiasX));
		r_SampleY[r_Tap] =
			Multiply(r_Transform.r_NormalizeY,
					 Fma(r_Transform.r_ScaleY, Multiply(r_InvHeight, r_VerticalFilter.r_Position[r_Tap]),
						 r_Transform.r_BiasY));
	}
	const float4 r_Left = Sample(g_History, r_SampleX[0], r_SampleY[1]);
	const float4 r_Top = Sample(g_History, r_SampleX[1], r_SampleY[0]);
	const float4 r_Center = Sample(g_History, r_SampleX[1], r_SampleY[1]);
	const float4 r_Bottom = Sample(g_History, r_SampleX[1], r_SampleY[2]);
	const float4 r_Right = Sample(g_History, r_SampleX[2], r_SampleY[1]);
	const float r_Weights[5] = {Multiply(r_HorizontalFilter.r_Weight[0], r_VerticalFilter.r_Weight[1]),
								Multiply(r_VerticalFilter.r_Weight[0], r_HorizontalFilter.r_Weight[1]),
								Multiply(r_HorizontalFilter.r_Weight[1], r_VerticalFilter.r_Weight[1]),
								Multiply(r_VerticalFilter.r_Weight[2], r_HorizontalFilter.r_Weight[1]),
								Multiply(r_HorizontalFilter.r_Weight[2], r_VerticalFilter.r_Weight[1])};
	const float r_InverseWeightSum =
		Reciprocal(Add(r_Weights[4], Add(r_Weights[3], Add(r_Weights[2], Add(r_Weights[0], r_Weights[1])))));
	float3 r_ReconstructedColor;
#pragma unroll
	for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
	{
		float r_WeightedChannelSum = Multiply((&r_Top.x)[r_Channel], r_Weights[1]);
		r_WeightedChannelSum = Fma((&r_Left.x)[r_Channel], r_Weights[0], r_WeightedChannelSum);
		r_WeightedChannelSum = Fma((&r_Center.x)[r_Channel], r_Weights[2], r_WeightedChannelSum);
		r_WeightedChannelSum = Fma((&r_Bottom.x)[r_Channel], r_Weights[3], r_WeightedChannelSum);
		r_WeightedChannelSum = Fma((&r_Right.x)[r_Channel], r_Weights[4], r_WeightedChannelSum);
		(&r_ReconstructedColor.x)[r_Channel] = Multiply(r_WeightedChannelSum, r_InverseWeightSum);
	}
	return r_ReconstructedColor;
}

#endif
} // namespace dlssnr::kernels::frontend_math
