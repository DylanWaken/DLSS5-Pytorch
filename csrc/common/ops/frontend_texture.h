#pragma once
// DLSSNR frontend texture/surface and feature-composition operations.
//
// Texture and surface instructions are model/renderer operations, not generic
// FlashLight math primitives, so their raw PTX lives here. Scalar arithmetic
// still delegates to the exact FlashLight FTZ/approx instructions; the local
// multiply/reciprocal helpers intentionally retain the frontend's original
// integer-register ("r") constraint for those two operations.
#include <flashlight/core.cuh>
#include <flashlight/arch/math.cuh>
#include <flashlight/numeric/packed.cuh>
#include <dlssnr/abi/kernel_parameters.h>
#include "../layout/numerical_constants.h"
#include <cstdint>

namespace dlssnr
{
namespace ops
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
// Frontend arithmetic helpers over the native integer-register form. These keep
// the exact operations used by the recovered frontend wrappers.
__device__ __forceinline__ float native_float_multiply(float lhs, float rhs)
{
	return __uint_as_float(flashlight::arch::multiply_ftz_bits(__float_as_uint(lhs), __float_as_uint(rhs)));
}

__device__ __forceinline__ float native_float_reciprocal(float input)
{
	return __uint_as_float(flashlight::arch::reciprocal_approx_ftz_bits(__float_as_uint(input)));
}

// Sample four FP32 channels from a 2D texture using the descriptor's own
// coordinate/filter policy.
__device__ __forceinline__ uint4 native_texture_2d(std::uint64_t texture_handle,
												   std::uint32_t coordinate_x_bits,
												   std::uint32_t coordinate_y_bits)
{
	uint4 result_lanes;
	asm volatile("tex.2d.v4.f32.f32 {%0,%1,%2,%3}, [%4,{%5,%6}];"
				 : "=r"(result_lanes.x), "=r"(result_lanes.y), "=r"(result_lanes.z), "=r"(result_lanes.w)
				 : "l"(texture_handle), "r"(coordinate_x_bits), "r"(coordinate_y_bits)
				 : "memory");
	return result_lanes;
}

// Write four words to a 2D surface; X is a byte offset and out-of-range writes
// are dropped by the surface instruction.
__device__ __forceinline__ void native_surface_2d(std::uint64_t surface_handle,
												  std::uint32_t byte_coordinate_x, std::uint32_t coordinate_y,
												  uint4 value_lanes)
{
	asm volatile("sust.p.2d.v4.b32.zero [%0,{%1,%2}],{%3,%4,%5,%6};"
				 :
				 : "l"(surface_handle), "r"(byte_coordinate_x), "r"(coordinate_y), "r"(value_lanes.x),
				   "r"(value_lanes.y), "r"(value_lanes.z), "r"(value_lanes.w)
				 : "memory");
}

__device__ __forceinline__ float4 sample_texture(std::uint64_t texture, float texture_x, float texture_y)
{
	const uint4 sample_bits =
		native_texture_2d(texture, __float_as_uint(texture_x), __float_as_uint(texture_y));
	return make_float4(__uint_as_float(sample_bits.x), __uint_as_float(sample_bits.y),
					   __uint_as_float(sample_bits.z), __uint_as_float(sample_bits.w));
}

// The two affine transforms are applied before the texture descriptor's own
// filtering/address modes. Their order matches the native parameter contract.
__device__ __forceinline__ float2 transform_texture_coordinates(const FTextureTransform& transform,
																float input_x, float input_y)
{
	return make_float2(
		native_float_multiply(transform.NormalizeX,
							  flashlight::arch::fma_rn_ftz(transform.ScaleX, input_x, transform.BiasX)),
		native_float_multiply(transform.NormalizeY,
							  flashlight::arch::fma_rn_ftz(transform.ScaleY, input_y, transform.BiasY)));
}

// Reused for current/depth/motion/conditioning texture samples in the
// preprocessing loop.
__device__ __forceinline__ float4 sample_transformed(std::uint64_t texture,
													 const FTextureTransform& transform, float2 uv)
{
	const float2 coordinates = transform_texture_coordinates(transform, uv.x, uv.y);
	return sample_texture(texture, coordinates.x, coordinates.y);
}

__device__ __forceinline__ float clamp_unit(float input)
{
	return flashlight::arch::minimum_ftz(layout::unit, flashlight::arch::maximum_ftz(layout::zero, input));
}

struct CubicAxis
{
	float weight[3]; // Outer left, merged middle pair, outer right.
	float position[3];
};

// Both horizontal and vertical axes in reconstruct_history share this rounded
// polynomial.
__device__ __forceinline__ CubicAxis compute_cubic_axis(float pixel_position, float extent)
{
	const float center = flashlight::arch::add_ftz(
		flashlight::arch::floor_ftz(flashlight::arch::add_ftz(pixel_position, -layout::pixel_center)),
		layout::pixel_center);
	const float fraction = flashlight::arch::minimum_ftz(
		flashlight::arch::maximum_ftz(flashlight::arch::subtract_ftz(pixel_position, center), layout::zero),
		layout::unit);
	const float square = native_float_multiply(fraction, fraction);
	const float cube = native_float_multiply(fraction, square);
	const float left_weight = flashlight::arch::fma_rn_ftz(flashlight::arch::add_ftz(fraction, cube),
														   layout::cubic_outer_factor, square);
	const float middle_left_weight = flashlight::arch::add_ftz(
		flashlight::arch::subtract_ftz(native_float_multiply(cube, layout::cubic_cube_factor),
									   native_float_multiply(square, layout::cubic_square_factor)),
		layout::unit);
	const float right_weight =
		native_float_multiply(flashlight::arch::subtract_ftz(cube, square), layout::pixel_center);
	const float middle_right_weight = flashlight::arch::subtract_ftz(
		flashlight::arch::subtract_ftz(flashlight::arch::subtract_ftz(layout::unit, left_weight),
									   middle_left_weight),
		right_weight);
	const float middle_weight = flashlight::arch::add_ftz(middle_left_weight, middle_right_weight);
	const float last_center = flashlight::arch::add_ftz(extent, -layout::pixel_center);
	CubicAxis filter;
	filter.weight[0] = left_weight;
	filter.weight[1] = middle_weight;
	filter.weight[2] = right_weight;
	filter.position[0] = flashlight::arch::minimum_ftz(
		flashlight::arch::maximum_ftz(flashlight::arch::add_ftz(center, -layout::unit), layout::pixel_center),
		last_center);
	filter.position[1] = flashlight::arch::minimum_ftz(
		flashlight::arch::maximum_ftz(
			flashlight::arch::add_ftz(flashlight::arch::divide_approx_ftz(middle_right_weight, middle_weight),
									  center),
			layout::pixel_center),
		last_center);
	filter.position[2] = flashlight::arch::minimum_ftz(
		flashlight::arch::maximum_ftz(flashlight::arch::add_ftz(center, layout::cubic_far_distance),
									  layout::pixel_center),
		last_center);
	return filter;
}

// Called by both preprocessing and postprocessing entries; keep one
// implementation of the temporal filter. Five filtered samples form a cross:
// left/top/center/bottom/right. The original omits four corner products and
// renormalizes the retained weights.
__device__ __forceinline__ float3 reconstruct_history(std::uint64_t history_texture,
													  const FTextureTransform& transform, float2 uv,
													  float width, float height)
{
	const CubicAxis horizontal_filter = compute_cubic_axis(native_float_multiply(uv.x, width), width);
	const CubicAxis vertical_filter = compute_cubic_axis(native_float_multiply(uv.y, height), height);
	const float inv_width = native_float_reciprocal(width);
	const float inv_height = native_float_reciprocal(height);
	float sample_x[3], sample_y[3];
	#pragma unroll
	for (int tap = 0; tap < 3; ++tap)
	{
		sample_x[tap] = native_float_multiply(
			transform.NormalizeX,
			flashlight::arch::fma_rn_ftz(transform.ScaleX,
										 native_float_multiply(inv_width, horizontal_filter.position[tap]),
										 transform.BiasX));
		sample_y[tap] = native_float_multiply(
			transform.NormalizeY,
			flashlight::arch::fma_rn_ftz(transform.ScaleY,
										 native_float_multiply(inv_height, vertical_filter.position[tap]),
										 transform.BiasY));
	}

	const float4 left = sample_texture(history_texture, sample_x[0], sample_y[1]);
	const float4 top = sample_texture(history_texture, sample_x[1], sample_y[0]);
	const float4 center = sample_texture(history_texture, sample_x[1], sample_y[1]);
	const float4 bottom = sample_texture(history_texture, sample_x[1], sample_y[2]);
	const float4 right = sample_texture(history_texture, sample_x[2], sample_y[1]);
	const float weights[5] = {native_float_multiply(horizontal_filter.weight[0], vertical_filter.weight[1]),
							  native_float_multiply(vertical_filter.weight[0], horizontal_filter.weight[1]),
							  native_float_multiply(horizontal_filter.weight[1], vertical_filter.weight[1]),
							  native_float_multiply(vertical_filter.weight[2], horizontal_filter.weight[1]),
							  native_float_multiply(horizontal_filter.weight[2], vertical_filter.weight[1])};
	const float inverse_weight_sum = native_float_reciprocal(flashlight::arch::add_ftz(
		weights[4], flashlight::arch::add_ftz(
						weights[3], flashlight::arch::add_ftz(
										weights[2], flashlight::arch::add_ftz(weights[0], weights[1])))));
	const float* top_channels = &top.x;
	const float* left_channels = &left.x;
	const float* center_channels = &center.x;
	const float* bottom_channels = &bottom.x;
	const float* right_channels = &right.x;
	float3 reconstructed_color;
	#pragma unroll
	for (int channel = 0; channel < 3; ++channel)
	{
		float weighted_channel_sum = native_float_multiply(top_channels[channel], weights[1]);
		weighted_channel_sum =
			flashlight::arch::fma_rn_ftz(left_channels[channel], weights[0], weighted_channel_sum);
		weighted_channel_sum =
			flashlight::arch::fma_rn_ftz(center_channels[channel], weights[2], weighted_channel_sum);
		weighted_channel_sum =
			flashlight::arch::fma_rn_ftz(bottom_channels[channel], weights[3], weighted_channel_sum);
		weighted_channel_sum =
			flashlight::arch::fma_rn_ftz(right_channels[channel], weights[4], weighted_channel_sum);
		(&reconstructed_color.x)[channel] = native_float_multiply(weighted_channel_sum, inverse_weight_sum);
	}

	return reconstructed_color;
}

__device__ __forceinline__ std::uint16_t convert_feature_to_half(float input_value)
{
	return flashlight::arch::convert_rn_f16_f32_bits(__float_as_uint(input_value));
}

__device__ __forceinline__ std::uint32_t pack_feature_half_words(std::uint16_t lower_halfword,
																 std::uint16_t upper_halfword)
{
	return flashlight::numeric::join_halfwords(lower_halfword, upper_halfword);
}

__device__ __forceinline__ std::uint16_t condition_color(float color_sample, std::uint16_t color_scale_half)
{
	// Keep both Half rounding points: round(texture), subtract 1/2, multiply
	// rounded(2*ColorScale). A float affine transform is not equivalent.
	return flashlight::arch::multiply_f16_bits(
		flashlight::arch::subtract_f16_bits(convert_feature_to_half(color_sample),
											convert_feature_to_half(layout::pixel_center)),
		color_scale_half);
}

__device__ __forceinline__ std::uint32_t permute_noise(std::uint32_t hash_state)
{
	const std::uint32_t shifted_hash = hash_state >> ((hash_state >> 28) + 4);
	return (shifted_hash ^ hash_state) * layout::noise_permute_multiplier;
}

// Independent per-pixel noise transform; kept separate from feature staging to
// expose its hash/Gaussian math. Local constexpr tables let the unrolled stream
// index become an immediate in device code; host-scope arrays cannot be
// dynamically device-indexed.
__device__ __forceinline__ float3 pixel_noise(std::uint32_t noise_seed, int pixel_x, int pixel_y)
{
	constexpr std::uint32_t noise_stream_multiplier[4] = {747796405u, 4201498105u, 3399858189u, 2200120369u};
	constexpr std::uint32_t noise_stream_addend[4] = {2891336453u, 1192405134u, 568162667u, 878960812u};
	const std::uint32_t hash_state =
		permute_noise(std::uint32_t(pixel_x) * layout::noise_x_multiplier ^
					  std::uint32_t(pixel_y) * layout::noise_y_multiplier ^
					  noise_seed * layout::noise_frame_multiplier ^ layout::noise_seed_xor);
	const std::uint32_t pixel_hash = (hash_state >> 22) ^ hash_state;
	float uniform[4];
	#pragma unroll
	for (int stream = 0; stream < 4; ++stream)
	{
		const std::uint32_t stream_hash =
			permute_noise(pixel_hash * noise_stream_multiplier[stream] + noise_stream_addend[stream]);
		const std::uint32_t uniform_integer = ((stream_hash >> 30) ^ (stream_hash >> 8)) + 1;
		uniform[stream] = native_float_multiply(
			__uint_as_float(flashlight::numeric::uint_to_float_rn_bits(uniform_integer)),
			layout::noise_uint24_scale);
	}

	float radius[2], angle[2];
	#pragma unroll
	for (int pair = 0; pair < 2; ++pair)
	{
		const float log2_value =
			__uint_as_float(flashlight::arch::log2_approx_ftz_bits(__float_as_uint(uniform[2 * pair])));
		const float log_value = native_float_multiply(log2_value, __uint_as_float(layout::noise_ln2_bits));
		radius[pair] = __uint_as_float(flashlight::arch::sqrt_approx_ftz_bits(
			__float_as_uint(native_float_multiply(log_value, layout::noise_radius_factor))));
		angle[pair] =
			native_float_multiply(uniform[2 * pair + 1], __uint_as_float(layout::noise_two_pi_bits));
	}

	// Only three of the four Gaussian coordinates are retained by the DLL.
	return make_float3(
		native_float_multiply(
			radius[0], __uint_as_float(flashlight::arch::cos_approx_ftz_bits(__float_as_uint(angle[0])))),
		native_float_multiply(
			radius[0], __uint_as_float(flashlight::arch::sin_approx_ftz_bits(__float_as_uint(angle[0])))),
		native_float_multiply(
			radius[1], __uint_as_float(flashlight::arch::cos_approx_ftz_bits(__float_as_uint(angle[1])))));
}

#endif // SM80+
} // namespace ops
} // namespace dlssnr
