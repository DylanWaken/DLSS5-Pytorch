#pragma once
#include "kernel_impl/intrinsics.cuh"

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
__device__ __forceinline__ float Add(float r_A, float r_B)
{
	return __uint_as_float(NativeAddFtzF32(__float_as_uint(r_A), __float_as_uint(r_B)));
}

__device__ __forceinline__ float Subtract(float r_A, float r_B)
{
	return __uint_as_float(NativeSubFtzF32(__float_as_uint(r_A), __float_as_uint(r_B)));
}

__device__ __forceinline__ float Multiply(float r_A, float r_B)
{
	return __uint_as_float(NativeMulFtzF32(__float_as_uint(r_A), __float_as_uint(r_B)));
}

__device__ __forceinline__ float Fma(float r_A, float r_B, float r_C)
{
	return __uint_as_float(
		NativeFmaRnFtzF32(__float_as_uint(r_A), __float_as_uint(r_B), __float_as_uint(r_C)));
}

__device__ __forceinline__ float Divide(float r_A, float r_B)
{
	return __uint_as_float(NativeDivApproxFtzF32(__float_as_uint(r_A), __float_as_uint(r_B)));
}

__device__ __forceinline__ float Reciprocal(float r_A)
{
	return __uint_as_float(NativeRcpApproxFtzF32(__float_as_uint(r_A)));
}

__device__ __forceinline__ float Minimum(float r_A, float r_B)
{
	return __uint_as_float(NativeMinFtzF32(__float_as_uint(r_A), __float_as_uint(r_B)));
}

__device__ __forceinline__ float Maximum(float r_A, float r_B)
{
	return __uint_as_float(NativeMaxFtzF32(__float_as_uint(r_A), __float_as_uint(r_B)));
}

__device__ __forceinline__ float Floor(float r_A)
{
	return __uint_as_float(NativeCvtRmiFtzF32F32(__float_as_uint(r_A)));
}

__device__ __forceinline__ float ClampUnit(float r_A)
{
	return Minimum(CONST_UNIT, Maximum(CONST_ZERO, r_A));
}

struct FTextureTransform
{
	float r_BiasX, r_BiasY, r_ScaleX, r_ScaleY, r_NormalizeX, r_NormalizeY;
};

// The two affine transforms are applied before the texture descriptor's own
// filtering/address modes. Their order matches the native parameter contract.
__device__ __forceinline__ float2 Transform(const FTextureTransform& r_Transform, float r_X, float r_Y)
{
	return make_float2(
		Multiply(r_Transform.r_NormalizeX, Fma(r_Transform.r_ScaleX, r_X, r_Transform.r_BiasX)),
		Multiply(r_Transform.r_NormalizeY, Fma(r_Transform.r_ScaleY, r_Y, r_Transform.r_BiasY)));
}

__device__ __forceinline__ float4 Sample(uint64_t g_Texture, float r_X, float r_Y)
{
	const uint4 r_Bits = NativeTexture2d(g_Texture, __float_as_uint(r_X), __float_as_uint(r_Y));
	return make_float4(__uint_as_float(r_Bits.x), __uint_as_float(r_Bits.y), __uint_as_float(r_Bits.z),
					   __uint_as_float(r_Bits.w));
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
	const float r_Left = Fma(Add(r_Fraction, r_Cube), CONST_CUBIC_OUTER_FACTOR, r_Square);
	const float r_MiddleLeft = Add(
		Subtract(Multiply(r_Cube, CONST_CUBIC_CUBE_FACTOR), Multiply(r_Square, CONST_CUBIC_SQUARE_FACTOR)),
		CONST_UNIT);
	const float r_Right = Multiply(Subtract(r_Cube, r_Square), CONST_PIXEL_CENTER);
	const float r_MiddleRight = Subtract(Subtract(Subtract(CONST_UNIT, r_Left), r_MiddleLeft), r_Right);
	const float r_Middle = Add(r_MiddleLeft, r_MiddleRight);
	const float r_LastCenter = Add(r_Extent, -CONST_PIXEL_CENTER);
	FCubicAxis r_Result;
	r_Result.r_Weight[0] = r_Left;
	r_Result.r_Weight[1] = r_Middle;
	r_Result.r_Weight[2] = r_Right;
	r_Result.r_Position[0] = Minimum(Maximum(Add(r_Center, -CONST_UNIT), CONST_PIXEL_CENTER), r_LastCenter);
	r_Result.r_Position[1] =
		Minimum(Maximum(Add(Divide(r_MiddleRight, r_Middle), r_Center), CONST_PIXEL_CENTER), r_LastCenter);
	r_Result.r_Position[2] =
		Minimum(Maximum(Add(r_Center, CONST_CUBIC_FAR_DISTANCE), CONST_PIXEL_CENTER), r_LastCenter);
	return r_Result;
}

// Five filtered samples form a cross: left/top/center/bottom/right. The original
// omits four corner products and renormalizes the retained weights. The cubic
// coefficients match Catmull-Rom algebra; naming its intended filter is inferred.
__device__ __forceinline__ float3 ReconstructHistory(uint64_t g_History, const FTextureTransform& r_Transform,
													 float2 r_Uv, float r_Width, float r_Height)
{
	const FCubicAxis r_X = CubicAxis(Multiply(r_Uv.x, r_Width), r_Width);
	const FCubicAxis r_Y = CubicAxis(Multiply(r_Uv.y, r_Height), r_Height);
	const float r_InvWidth = Reciprocal(r_Width), r_InvHeight = Reciprocal(r_Height);
	float r_SampleX[3], r_SampleY[3];
#pragma unroll
	for (int r_Tap = 0; r_Tap < 3; ++r_Tap)
	{
		r_SampleX[r_Tap] = Multiply(
			r_Transform.r_NormalizeX,
			Fma(r_Transform.r_ScaleX, Multiply(r_InvWidth, r_X.r_Position[r_Tap]), r_Transform.r_BiasX));
		r_SampleY[r_Tap] = Multiply(
			r_Transform.r_NormalizeY,
			Fma(r_Transform.r_ScaleY, Multiply(r_InvHeight, r_Y.r_Position[r_Tap]), r_Transform.r_BiasY));
	}
	const float4 r_Left = Sample(g_History, r_SampleX[0], r_SampleY[1]);
	const float4 r_Top = Sample(g_History, r_SampleX[1], r_SampleY[0]);
	const float4 r_Center = Sample(g_History, r_SampleX[1], r_SampleY[1]);
	const float4 r_Bottom = Sample(g_History, r_SampleX[1], r_SampleY[2]);
	const float4 r_Right = Sample(g_History, r_SampleX[2], r_SampleY[1]);
	const float r_Weights[5] = {
		Multiply(r_X.r_Weight[0], r_Y.r_Weight[1]), Multiply(r_Y.r_Weight[0], r_X.r_Weight[1]),
		Multiply(r_X.r_Weight[1], r_Y.r_Weight[1]), Multiply(r_Y.r_Weight[2], r_X.r_Weight[1]),
		Multiply(r_X.r_Weight[2], r_Y.r_Weight[1])};
	const float r_InverseSum =
		Reciprocal(Add(r_Weights[4], Add(r_Weights[3], Add(r_Weights[2], Add(r_Weights[0], r_Weights[1])))));
	float3 r_Result;
#pragma unroll
	for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
	{
		float r_Sum = Multiply((&r_Top.x)[r_Channel], r_Weights[1]);
		r_Sum = Fma((&r_Left.x)[r_Channel], r_Weights[0], r_Sum);
		r_Sum = Fma((&r_Center.x)[r_Channel], r_Weights[2], r_Sum);
		r_Sum = Fma((&r_Bottom.x)[r_Channel], r_Weights[3], r_Sum);
		r_Sum = Fma((&r_Right.x)[r_Channel], r_Weights[4], r_Sum);
		(&r_Result.x)[r_Channel] = Multiply(r_Sum, r_InverseSum);
	}
	return r_Result;
}

#endif
} // namespace dlssnr::kernels::frontend_math
