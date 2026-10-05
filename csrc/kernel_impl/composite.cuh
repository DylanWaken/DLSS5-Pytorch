#pragma once
#include "frontend_math.cuh"

namespace dlssnr::kernels::postprocess
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::frontend_math;

struct FCompositeParameters
{
	uint64_t g_Surface, g_Color, g_History, g_Motion, g_BlendScale;
	FTextureTransform ColorTransform, HistoryTransform, MotionTransform;
	float r_OutputScale, r_MotionScaleX, r_MotionScaleY;
	int Width, Height, ValidWidth, ValidHeight;
	bool bDisplayOutput, bApplyMotion;
};

// One lane writes one RGBA pixel. Color conversion and temporal blending stay
// after the Half head: widening earlier changes the learned residual path.
__device__ __forceinline__ void CompositePixel(const FCompositeParameters& r_Parameters, int g_X, int g_Y,
											   uint32_t r_RedGreen, uint32_t r_BlueGate)
{
	if (g_X < 0 || g_Y < 0 || g_X >= r_Parameters.Width || g_Y >= r_Parameters.Height)
		return;
	const float r_Width = __int2float_rn(r_Parameters.ValidWidth);
	const float r_Height = __int2float_rn(r_Parameters.ValidHeight);
	const float2 r_Uv = make_float2(Divide(Add(__uint2float_rn(g_X), CONST_PIXEL_CENTER), r_Width),
									Divide(Add(__uint2float_rn(g_Y), CONST_PIXEL_CENTER), r_Height));
	const float r_Head[4] = {__half2float(__ushort_as_half(uint16_t(r_RedGreen))),
							 __half2float(__ushort_as_half(uint16_t(r_RedGreen >> 16))),
							 __half2float(__ushort_as_half(uint16_t(r_BlueGate))),
							 __half2float(__ushort_as_half(uint16_t(r_BlueGate >> 16)))};
	const bool r_bValid = g_X < r_Parameters.ValidWidth && g_Y < r_Parameters.ValidHeight;
	float4 r_Color;
	if (r_Parameters.g_Color && r_bValid)
	{
		const float2 r_ColorUv = Transform(r_Parameters.ColorTransform, r_Uv.x, r_Uv.y);
		const float4 r_Current = Sample(r_Parameters.g_Color, r_ColorUv.x, r_ColorUv.y);
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] =
				Fma(r_Parameters.r_OutputScale, r_Head[r_Channel],
					Fma((&r_Current.x)[r_Channel], CONST_COLOR_RESIDUAL_SCALE, CONST_COLOR_RESIDUAL_BIAS));
	}
	else
	{
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] = Multiply(r_Parameters.r_OutputScale, r_Head[r_Channel]);
	}
	r_Color.w = CONST_ZERO;
	if (r_Parameters.bDisplayOutput)
	{
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] =
				ClampUnit(Fma((&r_Color.x)[r_Channel], CONST_COLOR_DISPLAY_SCALE, CONST_COLOR_DISPLAY_BIAS));
		r_Color.w = CONST_UNIT;
	}
	float r_BlendScale = CONST_UNIT;
	if (r_Parameters.g_BlendScale)
	{
		const float r_LoadedScale =
			__half2float(__ushort_as_half(*reinterpret_cast<const uint16_t*>(r_Parameters.g_BlendScale)));
		const uint32_t r_AbsBits = NativeAbsFtzF32(__float_as_uint(r_LoadedScale));
		r_BlendScale =
			NativeSetpEquFtzF32(r_AbsBits, CONST_FP32_INFINITY_BITS) ? CONST_ZERO : ClampUnit(r_LoadedScale);
	}
	if (r_Parameters.bDisplayOutput && r_Parameters.g_History && r_Parameters.g_Motion && r_bValid &&
		r_BlendScale > CONST_ZERO)
	{
		const float2 r_MotionUv = Transform(r_Parameters.MotionTransform, r_Uv.x, r_Uv.y);
		const float4 r_Motion = Sample(r_Parameters.g_Motion, r_MotionUv.x, r_MotionUv.y);
		const float2 r_PreviousUv = r_Parameters.bApplyMotion
										? make_float2(Fma(r_Parameters.r_MotionScaleX, r_Motion.x, r_Uv.x),
													  Fma(r_Parameters.r_MotionScaleY, r_Motion.y, r_Uv.y))
										: r_Uv;
		const float3 r_History = ReconstructHistory(r_Parameters.g_History, r_Parameters.HistoryTransform,
													r_PreviousUv, r_Width, r_Height);
		const float r_Exponential = __uint_as_float(NativeEx2ApproxFtzF32(
			__float_as_uint(Multiply(r_Head[3], __uint_as_float(CONST_NEGATIVE_LOG2_E_BITS)))));
		const float r_Blend = ClampUnit(Multiply(Reciprocal(Add(r_Exponential, CONST_UNIT)), r_BlendScale));
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] =
				Fma(r_Blend, Subtract((&r_History.x)[r_Channel], (&r_Color.x)[r_Channel]),
					(&r_Color.x)[r_Channel]);
	}
	NativeSurface2d(r_Parameters.g_Surface, g_X, g_Y,
					make_uint4(__float_as_uint(r_Color.x), __float_as_uint(r_Color.y),
							   __float_as_uint(r_Color.z), __float_as_uint(r_Color.w)));
}
#endif
} // namespace dlssnr::kernels::postprocess
