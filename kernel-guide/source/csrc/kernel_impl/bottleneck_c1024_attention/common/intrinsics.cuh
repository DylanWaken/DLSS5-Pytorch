#pragma once
#include "../../shared/common/intrinsics.cuh"

// Instruction helpers used by this network stage in both precisions.
// The force-inline bodies and explicit PTX modifiers are preserved.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

// Multiply raw FP32 bit patterns with subnormal flushing and return the result bits.
__device__ __forceinline__ uint32_t FloatMulFtzBits(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	float r_Result;
	asm("mul.ftz.f32 %0,%1,%2;"
		: "=f"(r_Result)
		: "f"(__uint_as_float(r_LhsBits)), "f"(__uint_as_float(r_RhsBits)));
	return __float_as_uint(r_Result);
}

// Compute approximate sqrt on FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t FloatSqrtApproxFtzBits(uint32_t r_InputBits)
{
	float r_Result;
	asm("sqrt.approx.ftz.f32 %0,%1;" : "=f"(r_Result) : "f"(__uint_as_float(r_InputBits)));
	return __float_as_uint(r_Result);
}

// Read an aligned cache-all 16-byte vector only when valid; otherwise retain four zeros.
// The predicate suppresses the memory access, and +r constraints preserve the zero initialization.
__device__ __forceinline__ uint4 LoadGlobalCaOrZero(uint64_t g_Address, bool bValid)
{
	uint4 r_Result = make_uint4(0, 0, 0, 0);
	asm volatile("{ .reg .pred r_bLoadEnabled; setp.ne.u32 r_bLoadEnabled, %5, 0; "
				 "@r_bLoadEnabled ld.global.ca.v4.u32 {%0,%1,%2,%3}, [%4]; }"
				 : "+r"(r_Result.x), "+r"(r_Result.y), "+r"(r_Result.z), "+r"(r_Result.w)
				 : "l"(g_Address), "r"(uint32_t(bValid))
				 : "memory");
	return r_Result;
}

#endif // SM80+ stage instruction helpers.
