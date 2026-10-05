#pragma once
#include "intrinsics.cuh"
#include "numerical_constants.cuh"
#include <cuda_fp16.h>
#include <cstdint>

// Packed Half arithmetic, bit reinterpretation and per-lane approximate math composition.
namespace dlssnr::packed_math::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::intrinsics::sm120::ApproxRsqrt;
using dlssnr::intrinsics::sm120::ApproxRcp;

// Reinterpret one packed 32-bit word as two Half values without split/rejoin conversions.
__device__ __forceinline__ __half2 HalfPair(uint32_t r_PackedBits)
{
	return *reinterpret_cast<__half2*>(&r_PackedBits);
}

// Reinterpret both Half lanes as one word, preserving every bit including NaN payloads.
__device__ __forceinline__ uint32_t PairBits(__half2 r_PackedHalf)
{
	return *reinterpret_cast<uint32_t*>(&r_PackedHalf);
}

// Convert unsigned 32-bit integer to round-to-nearest FP32 and return its raw bits.
__device__ __forceinline__ uint32_t UintToFloatRnBits(uint32_t r_UnsignedValue)
{
	return __float_as_uint(__uint2float_rn(r_UnsignedValue));
}

// Convert the original Half bit pattern to FP32 without changing the call-site lane selection.
__device__ __forceinline__ uint32_t HalfToFloatBits(uint16_t r_HalfBits)
{
	return __float_as_uint(__half2float(__ushort_as_half(r_HalfBits)));
}

// Place the low and high 16-bit values into one word; this is not the converted-E4 merge helper.
__device__ __forceinline__ uint32_t JoinHalfwords(uint16_t r_LowHalfword, uint16_t r_HighHalfword)
{
	return uint32_t(r_LowHalfword) | (uint32_t(r_HighHalfword) << 16);
}

// Publish two packed-Half pairs to four E4 bytes, preserving each pair's native
// conversion and low/high byte placement while exposing conversion/merge fusion.
__device__ __forceinline__ uint32_t PackHalfPairsE4(uint32_t r_LowHalfPair, uint32_t r_HighHalfPair)
{
	return dlssnr::intrinsics::sm120::PublishFourE4(r_LowHalfPair, r_HighHalfPair);
}

// Subtract corresponding packed Half lanes with the original Half2 operation.
__device__ __forceinline__ uint32_t HalfSub(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	return PairBits(__hsub2(HalfPair(r_LhsBits), HalfPair(r_RhsBits)));
}

// Add corresponding packed Half lanes using the original CUDA Half2 operation.
__device__ __forceinline__ uint32_t HalfAdd(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	return PairBits(__hadd2(HalfPair(r_LhsBits), HalfPair(r_RhsBits)));
}

// Multiply corresponding packed Half lanes; do not introduce a wider intermediate.
__device__ __forceinline__ uint32_t HalfMul(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	return PairBits(__hmul2(HalfPair(r_LhsBits), HalfPair(r_RhsBits)));
}

// Apply the ordered fused Half2 multiply-add; accumulator is the third operand.
__device__ __forceinline__ uint32_t HalfFma(uint32_t r_MultiplicandBits, uint32_t r_MultiplierBits,
											uint32_t r_AccumulatorBits)
{
	return PairBits(
		__hfma2(HalfPair(r_MultiplicandBits), HalfPair(r_MultiplierBits), HalfPair(r_AccumulatorBits)));
}

// Clear the sign of each Half lane using the original Half2 intrinsic.
__device__ __forceinline__ uint32_t HalfAbs(uint32_t r_InputBits)
{
	return PairBits(__habs2(HalfPair(r_InputBits)));
}

// Use the original Half2 minimum semantics, including its existing NaN behavior.
__device__ __forceinline__ uint32_t HalfMin(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	return PairBits(__hmin2(HalfPair(r_LhsBits), HalfPair(r_RhsBits)));
}

// Use the original Half2 maximum semantics, including its existing NaN behavior.
__device__ __forceinline__ uint32_t HalfMax(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	return PairBits(__hmax2(HalfPair(r_LhsBits), HalfPair(r_RhsBits)));
}

// Decode the input FP32 word and round/replicate it into both Half lanes.
__device__ __forceinline__ uint32_t FloatToHalf2(uint32_t r_FloatBits)
{
	return PairBits(__float2half2_rn(__uint_as_float(r_FloatBits)));
}

// Widen each Half lane, apply the original approximate operation, round and join in low/high order.
__device__ __forceinline__ uint32_t RsqrtHalf2(uint32_t r_PackedHalfBits)
{
	const float r_LowValue = __half2float(__ushort_as_half(uint16_t(r_PackedHalfBits)));
	const float r_HighValue = __half2float(__ushort_as_half(uint16_t(r_PackedHalfBits >> 16)));
	return JoinHalfwords(__half_as_ushort(__float2half_rn(ApproxRsqrt(r_LowValue))),
						 __half_as_ushort(__float2half_rn(ApproxRsqrt(r_HighValue))));
}

// Widen each Half lane, apply approximate reciprocal, round and join in low/high order.
__device__ __forceinline__ uint32_t RcpHalf2(uint32_t r_PackedHalfBits)
{
	const float r_LowValue = __half2float(__ushort_as_half(uint16_t(r_PackedHalfBits)));
	const float r_HighValue = __half2float(__ushort_as_half(uint16_t(r_PackedHalfBits >> 16)));
	return JoinHalfwords(__half_as_ushort(__float2half_rn(ApproxRcp(r_LowValue))),
						 __half_as_ushort(__float2half_rn(ApproxRcp(r_HighValue))));
}

// Evaluate the original packed-Half clamped polynomial activation. Both storage
// precisions use this same Half arithmetic; preserve the six rounding points and
// the min/max order, including their NaN behavior. Coefficients remain caller-owned
// Half words, so sharing this sequence introduces no conversion or wider math.
__device__ __forceinline__ uint32_t ClampedHalfPolynomial(uint32_t r_Input, uint32_t r_UpperBound,
														  uint32_t r_LowerBound, uint32_t r_AbsoluteSlope,
														  uint32_t r_AbsoluteIntercept, uint32_t r_Offset)
{
	const uint32_t r_UpperClamped = HalfMin(r_Input, r_UpperBound);
	const uint32_t r_Clamped = HalfMax(r_UpperClamped, r_LowerBound);
	const uint32_t r_Absolute = HalfAbs(r_Clamped);
	const uint32_t r_Affine = HalfFma(r_AbsoluteSlope, r_Absolute, r_AbsoluteIntercept);
	const uint32_t r_Weight = HalfFma(r_Clamped, r_Affine, r_Offset);
	return HalfMul(r_Input, r_Weight);
}

// The recovered FFN gate shared by every window/global expansion. Its named
// coefficients and their decoded values/formula live in numerical_constants.cuh.
__device__ __forceinline__ uint32_t FfnActivation(uint32_t r_Input)
{
	using namespace dlssnr::numerical_constants;
	return ClampedHalfPolynomial(r_Input, CONST_FFN_CLAMP_UPPER_HALF2, CONST_FFN_CLAMP_LOWER_HALF2,
								 CONST_FFN_ABS_SLOPE_HALF2, CONST_FFN_ABS_INTERCEPT_HALF2,
								 CONST_FFN_GATE_OFFSET_HALF2);
}

#endif
} // namespace dlssnr::packed_math::sm120
