#pragma once
// Recovered numerical constants belonging to the DLSSNR network model.
//
// HALF2 suffixes denote two identical IEEE binary16 bit patterns, not integer
// coefficients. Keeping the bits explicit preserves native rounding and avoids
// decimal transcription changing the network. Values describe the observed
// computation; the original authors' fitting/training procedure is unavailable.
// These constants are model data and therefore deliberately live outside the
// generic FlashLight library.
#include <cstdint>

namespace dlssnr
{
namespace layout
{
inline constexpr std::uint32_t half2_one = 0x3c003c00u;		// (1, 1): identity scale.
inline constexpr std::uint32_t half2_quarter = 0x34003400u; // (0.25, 0.25): 2x2 pool mean.

// FFN activation: t = clamp(x, -4, 4),
// y = x * (t * (Slope * abs(t) + Intercept) + Offset).
// The affine operations are Half FMAs and the final multiply is Half rounded.
// Clipping bounds the polynomial's gate while retaining x in the final product.
// Slope = -Intercept/8 and Offset = 2*Intercept; the gate is zero at t=-4 and
// 4*Intercept at t=4. These relationships explain the saturated branches but do
// not establish how the coefficients were selected/fitted.
inline constexpr std::uint32_t ffn_clamp_upper_half2 = 0x44004400u;	  // +4.
inline constexpr std::uint32_t ffn_clamp_lower_half2 = 0xc400c400u;	  // -4.
inline constexpr std::uint32_t ffn_abs_slope_half2 = 0xab28ab28u;	  // -0.055908203125.
inline constexpr std::uint32_t ffn_abs_intercept_half2 = 0x37283728u; // 0.447265625.
inline constexpr std::uint32_t ffn_gate_offset_half2 = 0x3b283b28u;	  // 0.89453125.

// Normalization and softmax clamp their denominator before reciprocal operations.
// Native FP32 0x388205ff is approximately 6.2e-5 and rounds to the Half value
// 6.198883056640625e-5, just above Half's smallest normal (2^-14). This keeps
// zero/small denominators finite. The exact epsilon's design origin is unknown.
inline constexpr std::uint32_t normalization_epsilon_half2 = 0x04100410u;
inline constexpr std::uint32_t attention_head_dimension_fp32_bits = 0x42000000u; // 32.0.

// Window attention exponent surrogate: clamp(a*x+b, lo, hi), then reinterpret
// the Half encoding through a whole-word shift and offset. The bounds constrain
// the generated exponent range. The offset also accounts for carries between
// packed lanes; replacing this with exp() changes results.
inline constexpr std::uint32_t window_exp_slope_half2 = 0x29c029c0u;	 // 0.044921875.
inline constexpr std::uint32_t window_exp_intercept_half2 = 0x3d343d34u; // 1.30078125.
inline constexpr std::uint32_t window_exp_lower_half2 = 0x3c203c20u;	 // 1.03125.
inline constexpr std::uint32_t window_exp_upper_half2 = 0x3e473e47u;	 // 1.5693359375.
inline constexpr int window_exp_encoding_shift = 5;
inline constexpr std::uint32_t window_exp_encoding_offset = 0x7ff88000u;

// Global attention uses a different affine approximation/encoding than windows.
// These are the rounded Half values of native FP32 sources 0x3db76078,
// 0x3fdacc5b, 0x3fb84000 and 0x3ffd2000, respectively.
inline constexpr std::uint32_t global_exp_slope_half2 = 0x2dbb2dbbu;	 // 0.08953857421875.
inline constexpr std::uint32_t global_exp_intercept_half2 = 0x3ed63ed6u; // 1.708984375.
inline constexpr std::uint32_t global_exp_lower_half2 = 0x3dc23dc2u;	 // 1.439453125.
inline constexpr std::uint32_t global_exp_upper_half2 = 0x3fe93fe9u;	 // 1.9775390625.
inline constexpr int global_exp_encoding_shift = 4;
inline constexpr std::uint32_t global_exp_encoding_offset = 0x3ffc4000u;
inline constexpr std::uint16_t global_exp_scalar_offset = 0x4000u; // Padded-score correction.

// Frontend texture/filter constants. Verified PTX values and roles, not inferred
// model hyperparameters.
inline constexpr float pixel_center = 0.5f;
inline constexpr float color_residual_scale = 0.125f; // Current color -> neural range.
inline constexpr float color_residual_bias = -0.0625f;
inline constexpr float color_display_scale = 8.0f; // Neural range -> output code value.
inline constexpr float color_display_bias = 0.5f;
inline constexpr float cubic_outer_factor = -0.5f; // Cubic outer tap polynomial.
inline constexpr float cubic_cube_factor = 1.5f;
inline constexpr float cubic_square_factor = 2.5f;
inline constexpr float cubic_far_distance = 2.0f;
inline constexpr float unit = 1.0f;
inline constexpr float zero = 0.0f;
inline constexpr std::uint32_t negative_log2_e_bits = 0xbfb8aa3bu; // -1.4426950216293335.
inline constexpr std::uint32_t fp32_infinity_bits = 0x7f800000u;

// Recovered per-frame/pixel noise arithmetic. These unsigned constants reproduce
// the native hash and its four decorrelated streams; they are recovered
// arithmetic, not an assertion about the original generator or seed policy.
inline constexpr std::uint32_t noise_frame_multiplier = 2654435769u;
inline constexpr std::uint32_t noise_x_multiplier = 2376512323u;
inline constexpr std::uint32_t noise_y_multiplier = 3625334849u;
inline constexpr std::uint32_t noise_seed_xor = 608135816u;
inline constexpr std::uint32_t noise_permute_multiplier = 277803737u;
inline constexpr float noise_uint24_scale = 0x1p-24f;
inline constexpr std::uint32_t noise_ln2_bits = 0x3f317218u;	// 0.6931471824645996.
inline constexpr std::uint32_t noise_two_pi_bits = 0x40c90fdbu; // 6.2831854820251465.
inline constexpr float noise_radius_factor = -2.0f;				// Box-Muller radius sqrt(-2 ln u).

// All 32 lanes participate in one shuffle segment before boundary stores.
inline constexpr std::uint32_t warp_clamp = 31u;
inline constexpr std::uint32_t warp_members = 0xffffffffu;

} // namespace layout
} // namespace dlssnr
