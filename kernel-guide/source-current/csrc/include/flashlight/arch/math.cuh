#pragma once
// Exact scalar math, rounding, conversion and compare instructions.
//
// Raw-bit entry points expose the historical integer-register constraint and
// return the result bit pattern. Native float entry points expose the same
// instruction with float-register constraints. Keeping both categories named
// explicitly avoids silently changing a caller's register class. FTZ, approx,
// rounding and ordered/unordered qualifiers are never dropped.
//
// Texture and surface instructions are project operations and intentionally do
// not live here.
#include <flashlight/core.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace arch
{
// --- Raw-bit scalar instructions (integer-register constraints) ---------------

// Absolute value with subnormal flushing.
__device__ __forceinline__ std::uint32_t absolute_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("abs.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Add with subnormal flushing.
__device__ __forceinline__ std::uint32_t add_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t result_bits;
	asm("add.ftz.f32 %0, %1, %2;" : "=r"(result_bits) : "r"(lhs_bits), "r"(rhs_bits));
	return result_bits;
}

// Round toward negative infinity to an integral FP32 value, with FTZ.
__device__ __forceinline__ std::uint32_t round_down_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("cvt.rmi.ftz.f32.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Round FP32 to Half using round-to-nearest-even.
__device__ __forceinline__ std::uint16_t convert_rn_f16_f32_bits(std::uint32_t input_bits)
{
	std::uint16_t result_bits;
	asm("cvt.rn.f16.f32 %0, %1;" : "=h"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Approximate division with subnormal flushing.
__device__ __forceinline__ std::uint32_t divide_approx_ftz_bits(std::uint32_t lhs_bits,
																std::uint32_t rhs_bits)
{
	std::uint32_t result_bits;
	asm("div.approx.ftz.f32 %0, %1, %2;" : "=r"(result_bits) : "r"(lhs_bits), "r"(rhs_bits));
	return result_bits;
}

// Approximate base-2 exponential with subnormal flushing.
__device__ __forceinline__ std::uint32_t exp2_approx_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("ex2.approx.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Fused multiply-add with round-to-nearest-even and subnormal flushing.
__device__ __forceinline__ std::uint32_t fma_rn_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits,
														 std::uint32_t addend_bits)
{
	std::uint32_t result_bits;
	asm("fma.rn.ftz.f32 %0, %1, %2, %3;"
		: "=r"(result_bits)
		: "r"(lhs_bits), "r"(rhs_bits), "r"(addend_bits));
	return result_bits;
}

// Maximum with max.ftz semantics on raw bit patterns.
__device__ __forceinline__ std::uint32_t maximum_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t result_bits;
	asm("max.ftz.f32 %0, %1, %2;" : "=r"(result_bits) : "r"(lhs_bits), "r"(rhs_bits));
	return result_bits;
}

// Minimum with min.ftz semantics on raw bit patterns.
__device__ __forceinline__ std::uint32_t minimum_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t result_bits;
	asm("min.ftz.f32 %0, %1, %2;" : "=r"(result_bits) : "r"(lhs_bits), "r"(rhs_bits));
	return result_bits;
}

// Multiply with subnormal flushing under the historical integer-register form.
__device__ __forceinline__ std::uint32_t multiply_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t result_bits;
	asm("mul.ftz.f32 %0, %1, %2;" : "=r"(result_bits) : "r"(lhs_bits), "r"(rhs_bits));
	return result_bits;
}

// Approximate reciprocal with subnormal flushing under the historical raw form.
__device__ __forceinline__ std::uint32_t reciprocal_approx_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("rcp.approx.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Subtract with subnormal flushing.
__device__ __forceinline__ std::uint32_t subtract_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t result_bits;
	asm("sub.ftz.f32 %0, %1, %2;" : "=r"(result_bits) : "r"(lhs_bits), "r"(rhs_bits));
	return result_bits;
}

// Compare equality or unordered operands, with FTZ; NaN yields true.
__device__ __forceinline__ bool compare_equal_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t predicate_word;
	asm("{ .reg .pred r_bEqualOrUnordered; setp.equ.ftz.f32 r_bEqualOrUnordered,%1,%2; selp.u32 %0,1,0,r_bEqualOrUnordered; }"
		: "=r"(predicate_word)
		: "r"(lhs_bits), "r"(rhs_bits));
	return predicate_word != 0;
}

// Compare ordered greater-or-equal, with FTZ; NaN yields false.
__device__ __forceinline__ bool compare_greater_equal_ftz_bits(std::uint32_t lhs_bits, std::uint32_t rhs_bits)
{
	std::uint32_t predicate_word;
	asm("{ .reg .pred r_bGreaterEqual; setp.ge.ftz.f32 r_bGreaterEqual,%1,%2; selp.u32 %0,1,0,r_bGreaterEqual; }"
		: "=r"(predicate_word)
		: "r"(lhs_bits), "r"(rhs_bits));
	return predicate_word != 0;
}

// Compare greater-or-equal or unordered, with FTZ; NaN yields true.
__device__ __forceinline__ bool compare_greater_equal_unordered_ftz_bits(std::uint32_t lhs_bits,
																		 std::uint32_t rhs_bits)
{
	std::uint32_t predicate_word;
	asm("{ .reg .pred r_bGreaterEqualOrUnordered; setp.geu.ftz.f32 r_bGreaterEqualOrUnordered,%1,%2; selp.u32 %0,1,0,r_bGreaterEqualOrUnordered; }"
		: "=r"(predicate_word)
		: "r"(lhs_bits), "r"(rhs_bits));
	return predicate_word != 0;
}

// Compare less-or-equal or unordered, with FTZ; NaN yields true.
__device__ __forceinline__ bool compare_less_equal_unordered_ftz_bits(std::uint32_t lhs_bits,
																	  std::uint32_t rhs_bits)
{
	std::uint32_t predicate_word;
	asm("{ .reg .pred r_bLessEqualOrUnordered; setp.leu.ftz.f32 r_bLessEqualOrUnordered,%1,%2; selp.u32 %0,1,0,r_bLessEqualOrUnordered; }"
		: "=r"(predicate_word)
		: "r"(lhs_bits), "r"(rhs_bits));
	return predicate_word != 0;
}

// Compare less-than or unordered, with FTZ; NaN yields true.
__device__ __forceinline__ bool compare_less_unordered_ftz_bits(std::uint32_t lhs_bits,
																std::uint32_t rhs_bits)
{
	std::uint32_t predicate_word;
	asm("{ .reg .pred r_bLessOrUnordered; setp.ltu.ftz.f32 r_bLessOrUnordered,%1,%2; selp.u32 %0,1,0,r_bLessOrUnordered; }"
		: "=r"(predicate_word)
		: "r"(lhs_bits), "r"(rhs_bits));
	return predicate_word != 0;
}

// Approximate cosine with subnormal flushing.
__device__ __forceinline__ std::uint32_t cos_approx_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("cos.approx.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Approximate base-2 logarithm with subnormal flushing.
__device__ __forceinline__ std::uint32_t log2_approx_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("lg2.approx.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Multiply Half bit patterns with Half rounding.
__device__ __forceinline__ std::uint16_t multiply_f16_bits(std::uint16_t lhs_bits, std::uint16_t rhs_bits)
{
	std::uint16_t result_bits;
	asm("mul.f16 %0, %1, %2;" : "=h"(result_bits) : "h"(lhs_bits), "h"(rhs_bits));
	return result_bits;
}

// Approximate sine with subnormal flushing.
__device__ __forceinline__ std::uint32_t sin_approx_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("sin.approx.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Approximate square root with subnormal flushing under the raw register form.
__device__ __forceinline__ std::uint32_t sqrt_approx_ftz_bits(std::uint32_t input_bits)
{
	std::uint32_t result_bits;
	asm("sqrt.approx.ftz.f32 %0, %1;" : "=r"(result_bits) : "r"(input_bits));
	return result_bits;
}

// Subtract Half bit patterns with Half rounding.
__device__ __forceinline__ std::uint16_t subtract_f16_bits(std::uint16_t lhs_bits, std::uint16_t rhs_bits)
{
	std::uint16_t result_bits;
	asm("sub.f16 %0, %1, %2;" : "=h"(result_bits) : "h"(lhs_bits), "h"(rhs_bits));
	return result_bits;
}

// --- Native float scalar instructions (float-register constraints) -----------

// Multiply with subnormal flushing.
__device__ __forceinline__ float multiply_ftz(float lhs, float rhs)
{
	float result;
	asm("mul.ftz.f32 %0,%1,%2;" : "=f"(result) : "f"(lhs), "f"(rhs));
	return result;
}

// Approximate reciprocal with subnormal flushing.
__device__ __forceinline__ float reciprocal_approx_ftz(float input)
{
	float result;
	asm("rcp.approx.ftz.f32 %0, %1;" : "=f"(result) : "f"(input));
	return result;
}

// Approximate reciprocal square root with subnormal flushing.
__device__ __forceinline__ float rsqrt_approx_ftz(float input)
{
	float result;
	asm("rsqrt.approx.ftz.f32 %0, %1;" : "=f"(result) : "f"(input));
	return result;
}

// Approximate square root with subnormal flushing.
__device__ __forceinline__ float sqrt_approx_ftz(float input)
{
	float result;
	asm("sqrt.approx.ftz.f32 %0,%1;" : "=f"(result) : "f"(input));
	return result;
}

// --- Float-valued compositions over the exact raw-bit instructions -----------

__device__ __forceinline__ float add_ftz(float lhs, float rhs)
{
	return __uint_as_float(add_ftz_bits(__float_as_uint(lhs), __float_as_uint(rhs)));
}

__device__ __forceinline__ float subtract_ftz(float lhs, float rhs)
{
	return __uint_as_float(subtract_ftz_bits(__float_as_uint(lhs), __float_as_uint(rhs)));
}

__device__ __forceinline__ float fma_rn_ftz(float multiplicand, float multiplier, float addend)
{
	return __uint_as_float(
		fma_rn_ftz_bits(__float_as_uint(multiplicand), __float_as_uint(multiplier), __float_as_uint(addend)));
}

__device__ __forceinline__ float divide_approx_ftz(float numerator, float denominator)
{
	return __uint_as_float(divide_approx_ftz_bits(__float_as_uint(numerator), __float_as_uint(denominator)));
}

__device__ __forceinline__ float minimum_ftz(float lhs, float rhs)
{
	return __uint_as_float(minimum_ftz_bits(__float_as_uint(lhs), __float_as_uint(rhs)));
}

__device__ __forceinline__ float maximum_ftz(float lhs, float rhs)
{
	return __uint_as_float(maximum_ftz_bits(__float_as_uint(lhs), __float_as_uint(rhs)));
}

__device__ __forceinline__ float floor_ftz(float input)
{
	return __uint_as_float(round_down_ftz_bits(__float_as_uint(input)));
}

} // namespace arch
} // namespace flashlight
#endif // SM80+
