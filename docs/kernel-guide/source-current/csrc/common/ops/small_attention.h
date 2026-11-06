#pragma once
// DLSSNR Small31 attention policy: persistent-FP32 numerator and row denominator.
//
// The Small31 exports reuse the recovered chained-attention records and the
// native packed-Half score/probability precision, but accumulate the P x V
// numerator and the complete row denominator in FP32. These five functions own
// that model-required precision policy. They are project operations, not generic
// FlashLight primitives: the generic layer only supplies packed conversions, the
// four-value permutation and the typed MMA dispatch.
//
// Rounding points kept here:
//   * one `cvt.rn.f16.f32` per output column at publication (final Half rounding),
//   * each probability term widened from its native packed-Half pair before its
//     first FP32 addition, so the recovered add tree sees the same 16 terms,
//   * `max(denominator, epsilon)` reproduced as a NaN-selecting ordered compare.
#include <flashlight/core.cuh>
#include <flashlight/numeric/packed.cuh>
#include <cuda_fp16.h>
#include <cstdint>

namespace dlssnr
{
namespace ops
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
// Round one FP32 column pair once to the packed-Half order every publication
// helper consumes. This is the single Half rounding of a normalized result.
__device__ __forceinline__ std::uint32_t pack_float_columns_half2(float low_column, float high_column)
{
	return flashlight::numeric::join_halfwords(__half_as_ushort(__float2half_rn(low_column)),
											   __half_as_ushort(__float2half_rn(high_column)));
}

// Widen one packed native-Half pair into two independent FP32 components. The
// low word is the low lane, matching every recovered packed-Half reduction.
__device__ __forceinline__ float2 widen_half_pair_float2(std::uint32_t packed_half_bits)
{
	return make_float2(__half2float(__ushort_as_half(std::uint16_t(packed_half_bits))),
					   __half2float(__ushort_as_half(std::uint16_t(packed_half_bits >> 16))));
}

// Add corresponding FP32 components. The caller keeps the recovered packed-Half
// addition order, so each logical row sum sees the same terms in the same tree.
__device__ __forceinline__ float2 add_float2_componentwise(float2 lhs, float2 rhs)
{
	return make_float2(lhs.x + rhs.x, lhs.y + rhs.y);
}

// Finish one row sum exactly where the recovered reduction combines the low and
// high packed-Half lane totals, now as a single FP32 addition.
__device__ __forceinline__ float total_float2(float2 value)
{
	return value.x + value.y;
}

// Match the native max(denominator, epsilon) clamp for FP32 totals. A NaN total
// selects the positive epsilon exactly as the packed-Half maximum does; an
// ordered `>` compare keeps that behavior (do not rewrite as fmaxf).
__device__ __forceinline__ float clamp_denominator_float(float denominator, float epsilon)
{
	return denominator > epsilon ? denominator : epsilon;
}
#endif // SM80+
} // namespace ops
} // namespace dlssnr
