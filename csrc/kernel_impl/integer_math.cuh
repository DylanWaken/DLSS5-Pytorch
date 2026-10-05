#pragma once
#include "intrinsics.cuh"
#include <cuda_fp16.h>
#include <cstdint>

// Width-preserving integer shifts and sign-extension bit algebra; no floating-point arithmetic.
namespace dlssnr::integer_math::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// Produce the 64-bit two-complement sign extension using unsigned modular arithmetic.
__device__ __forceinline__ uint64_t SignExtendWordBits(uint32_t r_LowWordBits)
{
	return (uint64_t(r_LowWordBits) ^ 0x80000000ull) - 0x80000000ull;
}

// Sign-extend the low byte into a 32-bit word using unsigned modular arithmetic.
__device__ __forceinline__ uint32_t SignExtendByteBits(uint32_t r_LowByteBits)
{
	return ((r_LowByteBits & 0xffu) ^ 0x80u) - 0x80u;
}

// Sign-extend the low 16 bits into a 32-bit word using unsigned modular arithmetic.
__device__ __forceinline__ uint32_t SignExtendHalfBits(uint32_t r_LowHalfwordBits)
{
	return ((r_LowHalfwordBits & 0xffffu) ^ 0x8000u) - 0x8000u;
}

// Perform bounded unsigned left shifting; shifts at/above the source width return zero.
template <typename T> __device__ __forceinline__ T ShiftLeft(T r_Value, uint32_t r_Shift)
{
	return r_Shift >= sizeof(T) * 8 ? T(0) : T(r_Value << r_Shift);
}

// Perform bounded logical right shifting; shifts at/above the source width return zero.
template <typename T> __device__ __forceinline__ T ShiftRight(T r_Value, uint32_t r_Shift)
{
	return r_Shift >= sizeof(T) * 8 ? T(0) : T(r_Value >> r_Shift);
}

// Preserve arithmetic 32-bit right shift with the original clamped shift amount.
__device__ __forceinline__ uint32_t ShiftRightSigned(int32_t r_SignedValue, uint32_t r_Shift)
{
	return uint32_t(r_SignedValue >> (r_Shift < 32 ? r_Shift : 31));
}
#endif
} // namespace dlssnr::integer_math::sm120
