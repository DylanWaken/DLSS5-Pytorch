#pragma once
#include "frontend_math.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// These unsigned constants reproduce the native per-frame/pixel hash and its
// four decorrelated streams. They are recovered arithmetic, not an assertion
// about the original author's choice of generator or random seed policy.
constexpr uint32_t CONST_NOISE_FRAME_MULTIPLIER = 2654435769u;
constexpr uint32_t CONST_NOISE_X_MULTIPLIER = 2376512323u;
constexpr uint32_t CONST_NOISE_Y_MULTIPLIER = 3625334849u;
constexpr uint32_t CONST_NOISE_SEED_XOR = 608135816u;
constexpr uint32_t CONST_NOISE_PERMUTE_MULTIPLIER = 277803737u;
constexpr float CONST_NOISE_UINT24_SCALE = 0x1p-24f;
constexpr uint32_t CONST_NOISE_LN2_BITS = 0x3f317218u;	  // 0.6931471824645996.
constexpr uint32_t CONST_NOISE_TWO_PI_BITS = 0x40c90fdbu; // 6.2831854820251465.
constexpr float CONST_NOISE_RADIUS_FACTOR = -2.0f;		  // Box-Muller radius sqrt(-2 ln u).

// ABI names describe how the native code uses each field. Renderer-level
// meanings of the conditioning controls remain deliberately unspecified. Green/Blue
// identify the texture channels used in the feature product, not renderer labels.

static_assert(sizeof(FPreprocessParameters) == 264, "Native preprocessing ABI must stay 264 bytes");
static_assert(offsetof(FPreprocessParameters, CurrentTransform) == 136);
static_assert(offsetof(FPreprocessParameters, ValidHeight) == 208);
static_assert(offsetof(FPreprocessParameters, g_PooledOutput) == 248);

struct FSharedFeatures
{
	// Two 8-channel Half planes, each holding the row-major 8x8 window. The
	// adapter reads these exact planes directly into m16n8k16 A fragments.
	uint4 s_Plane[2][64];
};

__device__ __forceinline__ uint32_t PermuteNoise(uint32_t r_HashState)
{
	const uint32_t r_ShiftedHash = r_HashState >> ((r_HashState >> 28) + 4);
	return (r_ShiftedHash ^ r_HashState) * CONST_NOISE_PERMUTE_MULTIPLIER;
}

// Independent per-pixel noise transform; kept separate from feature staging to expose its hash/Gaussian math.
__device__ __forceinline__ float3 PixelNoise(uint32_t NoiseSeed, int PixelX, int PixelY)
{
	// Local constexpr tables let the unrolled stream index become an immediate
	// in device code; host-scope arrays cannot be dynamically device-indexed.
	constexpr uint32_t CONST_NOISE_STREAM_MULTIPLIER[4] = {747796405u, 4201498105u, 3399858189u, 2200120369u};
	constexpr uint32_t CONST_NOISE_STREAM_ADDEND[4] = {2891336453u, 1192405134u, 568162667u, 878960812u};
	const uint32_t r_Hash = PermuteNoise(uint32_t(PixelX) * CONST_NOISE_X_MULTIPLIER ^
										 uint32_t(PixelY) * CONST_NOISE_Y_MULTIPLIER ^
										 NoiseSeed * CONST_NOISE_FRAME_MULTIPLIER ^ CONST_NOISE_SEED_XOR);
	const uint32_t r_PixelHash = (r_Hash >> 22) ^ r_Hash;
	float r_Uniform[4];
#pragma unroll
	for (int r_Stream = 0; r_Stream < 4; ++r_Stream)
	{
		const uint32_t r_StreamHash = PermuteNoise(r_PixelHash * CONST_NOISE_STREAM_MULTIPLIER[r_Stream] +
												   CONST_NOISE_STREAM_ADDEND[r_Stream]);
		const uint32_t r_UniformInteger = ((r_StreamHash >> 30) ^ (r_StreamHash >> 8)) + 1;
		r_Uniform[r_Stream] =
			NativeFloatMultiply(__uint2float_rn(r_UniformInteger), CONST_NOISE_UINT24_SCALE);
	}
	float r_Radius[2], r_Angle[2];
#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const float r_Log2 = __uint_as_float(NativeLg2ApproxFtzF32(__float_as_uint(r_Uniform[2 * r_Pair])));
		const float r_Log = NativeFloatMultiply(r_Log2, __uint_as_float(CONST_NOISE_LN2_BITS));
		r_Radius[r_Pair] = __uint_as_float(
			NativeSqrtApproxFtzF32(__float_as_uint(NativeFloatMultiply(r_Log, CONST_NOISE_RADIUS_FACTOR))));
		r_Angle[r_Pair] =
			NativeFloatMultiply(r_Uniform[2 * r_Pair + 1], __uint_as_float(CONST_NOISE_TWO_PI_BITS));
	}
	// Only three of the four Gaussian coordinates are retained by the DLL.
	return make_float3(
		NativeFloatMultiply(r_Radius[0], __uint_as_float(NativeCosApproxFtzF32(__float_as_uint(r_Angle[0])))),
		NativeFloatMultiply(r_Radius[0], __uint_as_float(NativeSinApproxFtzF32(__float_as_uint(r_Angle[0])))),
		NativeFloatMultiply(r_Radius[1],
							__uint_as_float(NativeCosApproxFtzF32(__float_as_uint(r_Angle[1])))));
}

// Reused for current/depth/motion/conditioning texture samples in the preprocessing loop.
__device__ __forceinline__ float4 SampleTransformed(uint64_t Texture, const FTextureTransform& Transform,
													float2 Uv)
{
	const float2 Coordinates = TransformTextureCoordinates(Transform, Uv.x, Uv.y);
	return SampleTexture(Texture, Coordinates.x, Coordinates.y);
}

__device__ __forceinline__ uint16_t ConvertFeatureToHalf(float r_InputValue)
{
	return NativeCvtRnF16F32(__float_as_uint(r_InputValue));
}

__device__ __forceinline__ uint32_t PackFeatureHalfWords(uint16_t r_LowerHalfword, uint16_t r_UpperHalfword)
{
	return uint32_t(r_LowerHalfword) | uint32_t(r_UpperHalfword) << 16;
}

__device__ __forceinline__ uint16_t ConditionColor(float r_ColorSample, uint16_t r_ColorScaleHalf)
{
	// Keep both Half rounding points: round(texture), subtract 1/2, multiply
	// rounded(2*ColorScale). A float affine transform is not equivalent.
	return NativeMulF16(
		NativeSubF16(ConvertFeatureToHalf(r_ColorSample), ConvertFeatureToHalf(CONST_PIXEL_CENTER)),
		r_ColorScaleHalf);
}

#endif
