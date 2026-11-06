#pragma once
// DLSSNR model activation compositions.
//
// The polynomial is evaluated entirely in packed Half arithmetic with the
// original six rounding points and min/max order, including their NaN behavior.
// Coefficients remain named model constants; generic Half primitives come from
// FlashLight.
#include <flashlight/numeric/packed.cuh>
#include "../layout/numerical_constants.h"

namespace dlssnr
{
namespace ops
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
// Evaluate the recovered packed-Half clamped polynomial:
//   t = min(x, upper), then max(t, lower)
//   y = x * fma(t, fma(slope, |t|, intercept), offset)
__device__ __forceinline__ flashlight::PackedHalf2
clamped_half_polynomial(flashlight::PackedHalf2 input, flashlight::PackedHalf2 upper_bound,
						flashlight::PackedHalf2 lower_bound, flashlight::PackedHalf2 absolute_slope,
						flashlight::PackedHalf2 absolute_intercept, flashlight::PackedHalf2 gate_offset)
{
	const flashlight::PackedHalf2 upper_clamped = flashlight::numeric::half2_minimum(input, upper_bound);
	const flashlight::PackedHalf2 clamped = flashlight::numeric::half2_maximum(upper_clamped, lower_bound);
	const flashlight::PackedHalf2 absolute = flashlight::numeric::half2_absolute(clamped);
	const flashlight::PackedHalf2 absolute_affine =
		flashlight::numeric::half2_fma(absolute_slope, absolute, absolute_intercept);
	const flashlight::PackedHalf2 activation_gate =
		flashlight::numeric::half2_fma(clamped, absolute_affine, gate_offset);
	return flashlight::numeric::half2_multiply(input, activation_gate);
}

// The recovered FFN gate shared by every window/global expansion. Its named
// coefficients and decoded formula live in dlssnr/layout/numerical_constants.h.
__device__ __forceinline__ flashlight::PackedHalf2 ffn_activation(flashlight::PackedHalf2 input)
{
	return clamped_half_polynomial(input, flashlight::PackedHalf2{layout::ffn_clamp_upper_half2},
								   flashlight::PackedHalf2{layout::ffn_clamp_lower_half2},
								   flashlight::PackedHalf2{layout::ffn_abs_slope_half2},
								   flashlight::PackedHalf2{layout::ffn_abs_intercept_half2},
								   flashlight::PackedHalf2{layout::ffn_gate_offset_half2});
}

#endif // SM80+
} // namespace ops
} // namespace dlssnr
