#pragma once
#include "../../shared/common/intrinsics.cuh"

// Instruction helpers used by this network stage in both precisions.
// The force-inline bodies and explicit PTX modifiers are preserved.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

// Take absolute value of an FP32 bit pattern with subnormal flushing.
__device__ __forceinline__ uint32_t NativeAbsFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("abs.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Add FP32 bit patterns with subnormal flushing.
__device__ __forceinline__ uint32_t NativeAddFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	asm("add.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Round an FP32 bit pattern toward negative infinity to an integral FP32 value, with FTZ.
__device__ __forceinline__ uint32_t NativeCvtRmiFtzF32F32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("cvt.rmi.ftz.f32.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Round an FP32 bit pattern to Half using round-to-nearest-even.
__device__ __forceinline__ uint16_t NativeCvtRnF16F32(uint32_t r_InputBits)
{
	uint16_t r_ResultBits;
	asm("cvt.rn.f16.f32 %0, %1;" : "=h"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Divide FP32 bit patterns with approximate division and subnormal flushing.
__device__ __forceinline__ uint32_t NativeDivApproxFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	asm("div.approx.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Compute approximate base-2 exponential from FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t NativeEx2ApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("ex2.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Perform a fused FP32 multiply-add with round-to-nearest-even and subnormal flushing.
__device__ __forceinline__ uint32_t NativeFmaRnFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits,
													  uint32_t r_AddendBits)
{
	uint32_t r_ResultBits;
	asm("fma.rn.ftz.f32 %0, %1, %2, %3;"
		: "=r"(r_ResultBits)
		: "r"(r_LhsBits), "r"(r_RhsBits), "r"(r_AddendBits));
	return r_ResultBits;
}

// Select the FP32 maximum using max.ftz semantics on raw bit patterns.
__device__ __forceinline__ uint32_t NativeMaxFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	asm("max.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Select the FP32 minimum using min.ftz semantics on raw bit patterns.
__device__ __forceinline__ uint32_t NativeMinFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	asm("min.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Multiply FP32 bit patterns with subnormal flushing.
__device__ __forceinline__ uint32_t NativeMulFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	asm("mul.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Compute approximate reciprocal on FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t NativeRcpApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("rcp.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Subtract FP32 bit patterns with subnormal flushing.
__device__ __forceinline__ uint32_t NativeSubFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	asm("sub.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Compare FP32 bits for equality or unordered operands, with FTZ; NaN yields true.
__device__ __forceinline__ bool NativeSetpEquFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t PredicateWord;
	asm("{ .reg .pred r_bEqualOrUnordered; setp.equ.ftz.f32 r_bEqualOrUnordered,%1,%2; selp.u32 %0,1,0,r_bEqualOrUnordered; }"
		: "=r"(PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return PredicateWord != 0;
}

// Sample four FP32 channels from a 2D texture using the handle's coordinate/filter policy.
__device__ __forceinline__ uint4 NativeTexture2d(uint64_t TextureHandle, uint32_t CoordinateXBits,
												 uint32_t CoordinateYBits)
{
	uint4 r_ResultLanes;
	asm volatile("tex.2d.v4.f32.f32 {%0,%1,%2,%3}, [%4,{%5,%6}];"
				 : "=r"(r_ResultLanes.x), "=r"(r_ResultLanes.y), "=r"(r_ResultLanes.z), "=r"(r_ResultLanes.w)
				 : "l"(TextureHandle), "r"(CoordinateXBits), "r"(CoordinateYBits)
				 : "memory");
	return r_ResultLanes;
}

// Write four words to a 2D surface; X is a byte offset and out-of-range writes are dropped.
__device__ __forceinline__ void NativeSurface2d(uint64_t SurfaceHandle, uint32_t ByteCoordinateX,
												uint32_t CoordinateY, uint4 r_ValueLanes)
{
	asm volatile("sust.p.2d.v4.b32.zero [%0,{%1,%2}],{%3,%4,%5,%6};"
				 :
				 : "l"(SurfaceHandle), "r"(ByteCoordinateX), "r"(CoordinateY), "r"(r_ValueLanes.x),
				   "r"(r_ValueLanes.y), "r"(r_ValueLanes.z), "r"(r_ValueLanes.w)
				 : "memory");
}

// Compute approximate cosine from FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t NativeCosApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("cos.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Compute approximate base-2 logarithm from FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t NativeLg2ApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("lg2.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Multiply Half bit patterns with Half rounding.
__device__ __forceinline__ uint16_t NativeMulF16(uint16_t r_LhsBits, uint16_t r_RhsBits)
{
	uint16_t r_ResultBits;
	asm("mul.f16 %0, %1, %2;" : "=h"(r_ResultBits) : "h"(r_LhsBits), "h"(r_RhsBits));
	return r_ResultBits;
}

// Compute approximate sine from FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t NativeSinApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("sin.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Compute approximate square root from FP32 bits with subnormal flushing.
__device__ __forceinline__ uint32_t NativeSqrtApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	asm("sqrt.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Subtract Half bit patterns with Half rounding.
__device__ __forceinline__ uint16_t NativeSubF16(uint16_t r_LhsBits, uint16_t r_RhsBits)
{
	uint16_t r_ResultBits;
	asm("sub.f16 %0, %1, %2;" : "=h"(r_ResultBits) : "h"(r_LhsBits), "h"(r_RhsBits));
	return r_ResultBits;
}

// Compare FP32 bits for ordered greater-or-equal, with FTZ; NaN yields false.
__device__ __forceinline__ bool NativeSetpGeFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t PredicateWord;
	asm("{ .reg .pred r_bGreaterEqual; setp.ge.ftz.f32 r_bGreaterEqual,%1,%2; selp.u32 %0,1,0,r_bGreaterEqual; }"
		: "=r"(PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return PredicateWord != 0;
}

// Compare FP32 bits for greater-or-equal or unordered operands, with FTZ; NaN yields true.
__device__ __forceinline__ bool NativeSetpGeuFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t PredicateWord;
	asm("{ .reg .pred r_bGreaterEqualOrUnordered; setp.geu.ftz.f32 r_bGreaterEqualOrUnordered,%1,%2; selp.u32 %0,1,0,r_bGreaterEqualOrUnordered; }"
		: "=r"(PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return PredicateWord != 0;
}

// Compare FP32 bits for less-or-equal or unordered operands, with FTZ; NaN yields true.
__device__ __forceinline__ bool NativeSetpLeuFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t PredicateWord;
	asm("{ .reg .pred r_bLessEqualOrUnordered; setp.leu.ftz.f32 r_bLessEqualOrUnordered,%1,%2; selp.u32 %0,1,0,r_bLessEqualOrUnordered; }"
		: "=r"(PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return PredicateWord != 0;
}

// Compare FP32 bits for less-than or unordered operands, with FTZ; NaN yields true.
__device__ __forceinline__ bool NativeSetpLtuFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t PredicateWord;
	asm("{ .reg .pred r_bLessOrUnordered; setp.ltu.ftz.f32 r_bLessOrUnordered,%1,%2; selp.u32 %0,1,0,r_bLessOrUnordered; }"
		: "=r"(PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return PredicateWord != 0;
}

#endif // SM80+ stage instruction helpers.
