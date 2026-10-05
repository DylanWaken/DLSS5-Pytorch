#pragma once
#include "frontend_math.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

struct FCompositeParameters
{
	uint64_t OutputSurface, ColorTexture, HistoryTexture, MotionTexture, g_BlendScale;
	FTextureTransform ColorTransform, HistoryTransform, MotionTransform;
	float OutputScale, MotionScaleX, MotionScaleY;
	int Width, Height, ValidWidth, ValidHeight;
	bool bDisplayOutput, bApplyMotion;
};

// One lane writes one RGBA pixel. Color conversion and temporal blending stay
// after the Half head: widening earlier changes the learned residual path.
__device__ __forceinline__ void CompositePixel(const FCompositeParameters& Parameters, int g_X, int g_Y,
											   uint32_t r_RedGreen, uint32_t r_BlueGate)
{
	if (g_X < 0 || g_Y < 0 || g_X >= Parameters.Width || g_Y >= Parameters.Height)
		return;
	const float Width = __int2float_rn(Parameters.ValidWidth);
	const float Height = __int2float_rn(Parameters.ValidHeight);
	const float2 Uv =
		make_float2(NativeFloatDivide(NativeFloatAdd(__uint2float_rn(g_X), CONST_PIXEL_CENTER), Width),
					NativeFloatDivide(NativeFloatAdd(__uint2float_rn(g_Y), CONST_PIXEL_CENTER), Height));
	const float r_HeadChannels[4] = {__half2float(__ushort_as_half(uint16_t(r_RedGreen))),
									 __half2float(__ushort_as_half(uint16_t(r_RedGreen >> 16))),
									 __half2float(__ushort_as_half(uint16_t(r_BlueGate))),
									 __half2float(__ushort_as_half(uint16_t(r_BlueGate >> 16)))};
	const bool bValidPixel = g_X < Parameters.ValidWidth && g_Y < Parameters.ValidHeight;
	float4 r_Color;
	if (Parameters.ColorTexture && bValidPixel)
	{
		const float2 ColorUv = TransformTextureCoordinates(Parameters.ColorTransform, Uv.x, Uv.y);
		const float4 r_CurrentColor = SampleTexture(Parameters.ColorTexture, ColorUv.x, ColorUv.y);
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] =
				NativeFloatFma(Parameters.OutputScale, r_HeadChannels[r_Channel],
							   NativeFloatFma((&r_CurrentColor.x)[r_Channel], CONST_COLOR_RESIDUAL_SCALE,
											  CONST_COLOR_RESIDUAL_BIAS));
	}
	else
	{
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] = NativeFloatMultiply(Parameters.OutputScale, r_HeadChannels[r_Channel]);
	}
	r_Color.w = CONST_ZERO;
	if (Parameters.bDisplayOutput)
	{
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] = ClampUnit(
				NativeFloatFma((&r_Color.x)[r_Channel], CONST_COLOR_DISPLAY_SCALE, CONST_COLOR_DISPLAY_BIAS));
		r_Color.w = CONST_UNIT;
	}
	float r_BlendScale = CONST_UNIT;
	if (Parameters.g_BlendScale)
	{
		const float r_LoadedScale =
			__half2float(__ushort_as_half(*reinterpret_cast<const uint16_t*>(Parameters.g_BlendScale)));
		const uint32_t r_BlendScaleAbsBits = NativeAbsFtzF32(__float_as_uint(r_LoadedScale));
		r_BlendScale = NativeSetpEquFtzF32(r_BlendScaleAbsBits, CONST_FP32_INFINITY_BITS)
						   ? CONST_ZERO
						   : ClampUnit(r_LoadedScale);
	}
	if (Parameters.bDisplayOutput && Parameters.HistoryTexture && Parameters.MotionTexture && bValidPixel &&
		r_BlendScale > CONST_ZERO)
	{
		const float2 MotionUv = TransformTextureCoordinates(Parameters.MotionTransform, Uv.x, Uv.y);
		const float4 r_Motion = SampleTexture(Parameters.MotionTexture, MotionUv.x, MotionUv.y);
		const float2 PreviousUv = Parameters.bApplyMotion
									  ? make_float2(NativeFloatFma(Parameters.MotionScaleX, r_Motion.x, Uv.x),
													NativeFloatFma(Parameters.MotionScaleY, r_Motion.y, Uv.y))
									  : Uv;
		const float3 r_History = ReconstructHistory(Parameters.HistoryTexture, Parameters.HistoryTransform,
													PreviousUv, Width, Height);
		const float r_GateExponential = __uint_as_float(NativeEx2ApproxFtzF32(__float_as_uint(
			NativeFloatMultiply(r_HeadChannels[3], __uint_as_float(CONST_NEGATIVE_LOG2_E_BITS)))));
		const float r_HistoryBlendWeight = ClampUnit(NativeFloatMultiply(
			NativeFloatReciprocal(NativeFloatAdd(r_GateExponential, CONST_UNIT)), r_BlendScale));
#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			(&r_Color.x)[r_Channel] = NativeFloatFma(
				r_HistoryBlendWeight, NativeFloatSubtract((&r_History.x)[r_Channel], (&r_Color.x)[r_Channel]),
				(&r_Color.x)[r_Channel]);
	}
	NativeSurface2d(Parameters.OutputSurface, g_X, g_Y,
					make_uint4(__float_as_uint(r_Color.x), __float_as_uint(r_Color.y),
							   __float_as_uint(r_Color.z), __float_as_uint(r_Color.w)));
}
#endif
