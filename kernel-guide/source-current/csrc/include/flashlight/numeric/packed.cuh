#pragma once
// Packed numeric carriers and exact Half/E4M3 compositions.
//
// Every function here is a bit-preserving primitive or a composition whose
// rounding points are explicit. Model activation constants and formulas belong
// to dlssnr::ops, not to this header.
#include <flashlight/core.cuh>
#include <flashlight/arch/math.cuh>
#include <cuda_fp16.h>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace numeric
{
// Reinterpret one packed word as two native Half lanes; every bit is preserved.
__device__ __forceinline__ __half2 to_native_half2(std::uint32_t packed_bits)
{
	return *reinterpret_cast<__half2*>(&packed_bits);
}

// Reinterpret both native Half lanes as one word, including NaN payloads.
__device__ __forceinline__ std::uint32_t from_native_half2(__half2 packed_half)
{
	return *reinterpret_cast<std::uint32_t*>(&packed_half);
}

// Place low and high 16-bit values into one word. This is a raw join, not the
// converted E4 merge performed by publish_e4x4.
__device__ __forceinline__ std::uint32_t join_halfwords(std::uint16_t low_halfword,
														std::uint16_t high_halfword)
{
	return std::uint32_t(low_halfword) | (std::uint32_t(high_halfword) << 16);
}

// Convert an unsigned 32-bit integer to round-to-nearest FP32 and return its bits.
__device__ __forceinline__ std::uint32_t uint_to_float_rn_bits(std::uint32_t unsigned_value)
{
	return __float_as_uint(__uint2float_rn(unsigned_value));
}

// Convert an original Half bit pattern to FP32 without changing lane selection.
__device__ __forceinline__ std::uint32_t half_to_float_bits(std::uint16_t half_bits)
{
	return __float_as_uint(__half2float(__ushort_as_half(half_bits)));
}

// Decode one FP32 word and round/replicate it into both Half lanes.
__device__ __forceinline__ PackedHalf2 half2_from_float_bits(std::uint32_t float_bits)
{
	return PackedHalf2{from_native_half2(__float2half2_rn(__uint_as_float(float_bits)))};
}

// Subtract corresponding packed Half lanes with the native Half2 operation.
__device__ __forceinline__ PackedHalf2 half2_subtract(PackedHalf2 lhs, PackedHalf2 rhs)
{
	return PackedHalf2{from_native_half2(__hsub2(to_native_half2(lhs.bits), to_native_half2(rhs.bits)))};
}

// Add corresponding packed Half lanes with the native Half2 operation.
__device__ __forceinline__ PackedHalf2 half2_add(PackedHalf2 lhs, PackedHalf2 rhs)
{
	return PackedHalf2{from_native_half2(__hadd2(to_native_half2(lhs.bits), to_native_half2(rhs.bits)))};
}

// Multiply corresponding packed Half lanes; no wider intermediate is introduced.
__device__ __forceinline__ PackedHalf2 half2_multiply(PackedHalf2 lhs, PackedHalf2 rhs)
{
	return PackedHalf2{from_native_half2(__hmul2(to_native_half2(lhs.bits), to_native_half2(rhs.bits)))};
}

// Ordered fused Half2 multiply-add; accumulator is the third operand.
__device__ __forceinline__ PackedHalf2 half2_fma(PackedHalf2 multiplicand, PackedHalf2 multiplier,
												 PackedHalf2 accumulator)
{
	return PackedHalf2{
		from_native_half2(__hfma2(to_native_half2(multiplicand.bits), to_native_half2(multiplier.bits),
								  to_native_half2(accumulator.bits)))};
}

// Clear the sign of each Half lane with the native Half2 intrinsic.
__device__ __forceinline__ PackedHalf2 half2_absolute(PackedHalf2 input)
{
	return PackedHalf2{from_native_half2(__habs2(to_native_half2(input.bits)))};
}

// Native Half2 minimum semantics, including the existing NaN behavior.
__device__ __forceinline__ PackedHalf2 half2_minimum(PackedHalf2 lhs, PackedHalf2 rhs)
{
	return PackedHalf2{from_native_half2(__hmin2(to_native_half2(lhs.bits), to_native_half2(rhs.bits)))};
}

// Native Half2 maximum semantics, including the existing NaN behavior.
__device__ __forceinline__ PackedHalf2 half2_maximum(PackedHalf2 lhs, PackedHalf2 rhs)
{
	return PackedHalf2{from_native_half2(__hmax2(to_native_half2(lhs.bits), to_native_half2(rhs.bits)))};
}

// Exchange the low and high Half lanes with the native whole-word shift/or form.
// This is the final step of the recovered row-sum reductions.
__device__ __forceinline__ PackedHalf2 half2_swap_lanes(PackedHalf2 value)
{
	return PackedHalf2{(value.bits << 16) | (value.bits >> 16)};
}

// Widen each Half lane, apply approximate reciprocal square root, round and join
// in low/high order.
__device__ __forceinline__ PackedHalf2 half2_rsqrt_approx(PackedHalf2 packed_half)
{
	const float low_value = __half2float(__ushort_as_half(std::uint16_t(packed_half.bits)));
	const float high_value = __half2float(__ushort_as_half(std::uint16_t(packed_half.bits >> 16)));
	return PackedHalf2{join_halfwords(__half_as_ushort(__float2half_rn(arch::rsqrt_approx_ftz(low_value))),
									  __half_as_ushort(__float2half_rn(arch::rsqrt_approx_ftz(high_value))))};
}

// Widen each Half lane, apply approximate reciprocal, round and join in low/high order.
__device__ __forceinline__ PackedHalf2 half2_rcp_approx(PackedHalf2 packed_half)
{
	const float low_value = __half2float(__ushort_as_half(std::uint16_t(packed_half.bits)));
	const float high_value = __half2float(__ushort_as_half(std::uint16_t(packed_half.bits >> 16)));
	return PackedHalf2{
		join_halfwords(__half_as_ushort(__float2half_rn(arch::reciprocal_approx_ftz(low_value))),
					   __half_as_ushort(__float2half_rn(arch::reciprocal_approx_ftz(high_value))))};
}

// A sum with its swapped Half pair produces the same scalar in both lanes.
// Make that invariant explicit so conversion/SFU work is not performed twice.
template <bool SquareRoot> __device__ __forceinline__ PackedHalf2 invert_replicated_half(PackedHalf2 sum)
{
	const float replicated_sum = __half2float(__ushort_as_half(std::uint16_t(sum.bits)));
	const float inverse =
		SquareRoot ? arch::rsqrt_approx_ftz(replicated_sum) : arch::reciprocal_approx_ftz(replicated_sum);
	const std::uint16_t inverse_half = __half_as_ushort(__float2half_rn(inverse));
	return PackedHalf2{join_halfwords(inverse_half, inverse_half)};
}

// Add four packed Half2 words in element order; used by the exclusive split path.
__device__ __forceinline__ PackedHalf2x4 half2x4_add(PackedHalf2x4 lhs, PackedHalf2x4 rhs)
{
	return PackedHalf2x4{{half2_add(PackedHalf2{lhs.word[0]}, PackedHalf2{rhs.word[0]}).bits,
						  half2_add(PackedHalf2{lhs.word[1]}, PackedHalf2{rhs.word[1]}).bits,
						  half2_add(PackedHalf2{lhs.word[2]}, PackedHalf2{rhs.word[2]}).bits,
						  half2_add(PackedHalf2{lhs.word[3]}, PackedHalf2{rhs.word[3]}).bits}};
}

// Round four Half values to E4M3 and join the pairs in low/high byte order. One
// PTX scope exposes the F2FP MERGE_C combine without an extra PRMT.
__device__ __forceinline__ PackedE4x4 publish_e4x4(PackedHalf2 low_half_pair, PackedHalf2 high_half_pair)
{
#if __CUDA_ARCH__ >= 890
	std::uint32_t packed_e4_word;
	asm("{ .reg .b16 r_LowE4Pair, r_HighE4Pair;\n"
		"cvt.rn.satfinite.e4m3x2.f16x2 r_LowE4Pair, %1;\n"
		"cvt.rn.satfinite.e4m3x2.f16x2 r_HighE4Pair, %2;\n"
		"mov.b32 %0, {r_LowE4Pair, r_HighE4Pair}; }"
		: "=r"(packed_e4_word)
		: "r"(low_half_pair.bits), "r"(high_half_pair.bits));
	return PackedE4x4{packed_e4_word};
#else
	// FP8 entry points are rejected below SM89; keep declarations visible.
	__trap();
	return PackedE4x4{0};
#endif
}

// Decode two E4M3 bytes to packed Half values in the same lane order.
__device__ __forceinline__ PackedHalf2 decode_e4x2(std::uint16_t packed_e4_bytes)
{
#if __CUDA_ARCH__ >= 890
	std::uint32_t packed_half_bits;
	asm("cvt.rn.f16x2.e4m3x2 %0, %1;" : "=r"(packed_half_bits) : "h"(packed_e4_bytes));
	return PackedHalf2{packed_half_bits};
#else
	__trap();
	return PackedHalf2{0};
#endif
}

} // namespace numeric
} // namespace flashlight
#endif // SM80+
