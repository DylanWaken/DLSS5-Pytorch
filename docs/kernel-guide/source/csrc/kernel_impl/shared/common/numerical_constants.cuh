#pragma once
#include <cstdint>

// Numerical constants recovered from the DLL. HALF2 suffixes denote two
// identical IEEE binary16 bit patterns, not integer coefficients. Keeping the
// bits explicit preserves the native rounding and avoids decimal transcription
// changing the network. Values below describe the observed computation; the
// original authors' fitting/training procedure is not available.
constexpr uint32_t CONST_HALF2_ONE = 0x3c003c00u;	  // (1, 1): identity scale.
constexpr uint32_t CONST_HALF2_QUARTER = 0x34003400u; // (0.25, 0.25): mean of a 2x2 pool.

// FFN activation: t = clamp(x, -4, 4),
// y = x * (t * (Slope * abs(t) + Intercept) + Offset).
// The affine operations are Half FMAs and the final multiply is Half rounded.
// Clipping bounds the polynomial's gate while retaining x in the final product.
// Slope = -Intercept/8 and Offset = 2*Intercept; hence the gate is zero
// at t=-4 and 4*Intercept at t=4. These relationships explain the saturated
// branches, but do not establish how NVIDIA selected/fitted the coefficients.
constexpr uint32_t CONST_FFN_CLAMP_UPPER_HALF2 = 0x44004400u;	// +4; FP32 source 0x40800000.
constexpr uint32_t CONST_FFN_CLAMP_LOWER_HALF2 = 0xc400c400u;	// -4; FP32 source 0xc0800000.
constexpr uint32_t CONST_FFN_ABS_SLOPE_HALF2 = 0xab28ab28u;		// -0.055908203125; source 0xbd650000.
constexpr uint32_t CONST_FFN_ABS_INTERCEPT_HALF2 = 0x37283728u; // 0.447265625; source 0x3ee50000.
constexpr uint32_t CONST_FFN_GATE_OFFSET_HALF2 = 0x3b283b28u;	// 0.89453125; source 0x3f650000.

// Normalization and softmax clamp their denominator before rsqrt/reciprocal.
// Native FP32 0x388205ff is approximately 6.2e-5 and rounds to the Half value
// 6.198883056640625e-5, just above Half's smallest normal (2^-14). This keeps
// zero/small denominators finite. The exact epsilon's design origin is unknown.
constexpr uint32_t CONST_NORMALIZATION_EPSILON_HALF2 = 0x04100410u;
constexpr uint32_t CONST_ATTENTION_HEAD_DIM_FP32_BITS = 0x42000000u; // 32.0; sqrt scales Q/K normalization.

// Window attention's native exponential surrogate: clamp(a*x+b, lo, hi),
// then reinterpret the Half encoding through a whole-word shift and offset.
// The bounds constrain the generated exponent range. The offset also accounts
// for carries between packed lanes; replacing this with exp() changes results.
constexpr uint32_t CONST_WINDOW_EXP_SLOPE_HALF2 = 0x29c029c0u;	   // 0.044921875.
constexpr uint32_t CONST_WINDOW_EXP_INTERCEPT_HALF2 = 0x3d343d34u; // 1.30078125.
constexpr uint32_t CONST_WINDOW_EXP_LOWER_HALF2 = 0x3c203c20u;	   // 1.03125.
constexpr uint32_t CONST_WINDOW_EXP_UPPER_HALF2 = 0x3e473e47u;	   // 1.5693359375.
constexpr int CONST_WINDOW_EXP_ENCODING_SHIFT = 5;
constexpr uint32_t CONST_WINDOW_EXP_ENCODING_OFFSET = 0x7ff88000u;

// Global attention uses a different affine approximation/encoding than windows.
// These are the rounded Half values of native FP32 sources 0x3db76078,
// 0x3fdacc5b, 0x3fb84000 and 0x3ffd2000, respectively.
constexpr uint32_t CONST_GLOBAL_EXP_SLOPE_HALF2 = 0x2dbb2dbbu;	   // 0.08953857421875.
constexpr uint32_t CONST_GLOBAL_EXP_INTERCEPT_HALF2 = 0x3ed63ed6u; // 1.708984375.
constexpr uint32_t CONST_GLOBAL_EXP_LOWER_HALF2 = 0x3dc23dc2u;	   // 1.439453125.
constexpr uint32_t CONST_GLOBAL_EXP_UPPER_HALF2 = 0x3fe93fe9u;	   // 1.9775390625.
constexpr int CONST_GLOBAL_EXP_ENCODING_SHIFT = 4;
constexpr uint32_t CONST_GLOBAL_EXP_ENCODING_OFFSET = 0x3ffc4000u;
constexpr uint16_t CONST_GLOBAL_EXP_SCALAR_OFFSET = 0x4000u; // Single-lane form for padded-score correction.
