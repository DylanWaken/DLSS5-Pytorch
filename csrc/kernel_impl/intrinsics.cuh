#pragma once
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Low-level ISA boundary for the reconstructed SM120 kernels.
// Operation tokens are accepted-source copies; only local names, comments and whitespace change.
// The complete identifier inverse is recorded in the staged transformation ledger.
// ABI readers and storage sizes stay family-local.
// Each caller still owns lane masks, barrier protocol, texture descriptors and layout.
// Scope factoring is a staged source refactor, not a claim of identical emitted SASS.
namespace dlssnr::intrinsics::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

// Convert a generic pointer plus byte offset to a 32-bit CTA-shared address at the ISA boundary.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:33
__device__ __forceinline__ uint32_t SharedAddress(unsigned char* s_SharedStorage, uint32_t s_ByteOffset)
{
	return uint32_t(__cvta_generic_to_shared(s_SharedStorage + s_ByteOffset));
}

// Elect one participating lane and return its predicate as 0/1; preserve the caller member mask.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:36
__device__ __forceinline__ uint32_t Elected(uint32_t r_MemberMask)
{
	uint32_t r_ElectedWord;
	// Declare a local predicate, elect a participating lane, then materialize that predicate as a 0/1 word.
	// PTX sequence: .reg .pred -> elect.sync -> selp.b32.
	asm volatile("{ .reg .pred p; elect.sync _|p,%1; selp.b32 %0,1,0,p; }"
				 : "=r"(r_ElectedWord)
				 : "r"(r_MemberMask));
	return r_ElectedWord;
}

// Read the original GPU-scope relaxed completion counter, retaining its memory clobber.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:78
__device__ __forceinline__ uint32_t CounterLoadRelaxed(uint64_t g_CounterAddress)
{
	uint32_t r_CounterBits;
	// Read the original GPU-scope relaxed completion counter, retaining its memory clobber.
	// PTX sequence: ld.relaxed.gpu.global.L1::no_allocate.s32.
	asm volatile("ld.relaxed.gpu.global.L1::no_allocate.s32 %0,[%1];"
				 : "=r"(r_CounterBits)
				 : "l"(g_CounterAddress)
				 : "memory");
	return r_CounterBits;
}

// Publish the completion counter with the original GPU-scope release ordering.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:84
__device__ __forceinline__ void CounterStoreRelease(uint64_t g_CounterAddress, uint32_t r_CounterBits)
{
	// Publish the completion counter with the original GPU-scope release ordering.
	// PTX sequence: st.release.gpu.global.L1::no_allocate.s32.
	asm volatile("st.release.gpu.global.L1::no_allocate.s32 [%0],%1;"
				 :
				 : "l"(g_CounterAddress), "r"(r_CounterBits)
				 : "memory");
}

// Reduce four packed Half2 words into global memory with unchanged word and lane order.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:88
__device__ __forceinline__ void ReduceHalf4(uint64_t g_GlobalAddress, uint4 r_PackedHalfWords)
{
	// Reduce four packed Half2 words into global memory with unchanged word and lane order.
	// PTX sequence: red.global.v4.f16x2.add.noftz.
	asm volatile("red.global.v4.f16x2.add.noftz [%0],{%1,%2,%3,%4};"
				 :
				 : "l"(g_GlobalAddress), "r"(r_PackedHalfWords.x), "r"(r_PackedHalfWords.y),
				   "r"(r_PackedHalfWords.z), "r"(r_PackedHalfWords.w)
				 : "memory");
}

// Keep the explicit short nanosleep in the original polling loop; this does not prove progress.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:92
__device__ __forceinline__ void PollSleep(uint32_t r_Nanoseconds)
{
	// Keep the explicit short nanosleep in the original polling loop; this does not prove progress.
	// PTX sequence: nanosleep.u32.
	asm volatile("nanosleep.u32 %0;" : : "r"(r_Nanoseconds) : "memory");
}

// Multiply FP32 bit patterns using the original FTZ operation and return the result bits.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:104
__device__ __forceinline__ uint32_t FloatMulFtzBits(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	float r_Result;
	// Multiply FP32 bit patterns using the original FTZ operation and return the result bits.
	// PTX sequence: mul.ftz.f32.
	asm("mul.ftz.f32 %0,%1,%2;"
		: "=f"(r_Result)
		: "f"(__uint_as_float(r_LhsBits)), "f"(__uint_as_float(r_RhsBits)));
	return __float_as_uint(r_Result);
}

// Apply the original approximate FTZ FP32 square root to a raw FP32 word.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:108
__device__ __forceinline__ uint32_t FloatSqrtApproxFtzBits(uint32_t r_InputBits)
{
	float r_Result;
	// Apply the original approximate FTZ FP32 square root to a raw FP32 word.
	// PTX sequence: sqrt.approx.ftz.f32.
	asm("sqrt.approx.ftz.f32 %0,%1;" : "=f"(r_Result) : "f"(__uint_as_float(r_InputBits)));
	return __float_as_uint(r_Result);
}

// Round packed Half lanes to satfinite E4M3x2 with the original direct conversion; no NaN cleanup mask.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:138
__device__ __forceinline__ uint16_t PublishE4(uint32_t r_PackedHalfBits)
{
	uint16_t r_PackedE4Bytes;
	// Round packed Half lanes to satfinite E4M3x2 with the original direct conversion; no NaN cleanup mask.
	// PTX sequence: cvt.rn.satfinite.e4m3x2.f16x2.
	asm("cvt.rn.satfinite.e4m3x2.f16x2 %0, %1;" : "=h"(r_PackedE4Bytes) : "r"(r_PackedHalfBits));
	return r_PackedE4Bytes;
}

// Decode the two E4M3 bytes into packed Half lanes, preserving the original byte order.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:141
__device__ __forceinline__ uint32_t DecodeE4(uint16_t r_PackedE4Bytes)
{
	uint32_t r_PackedHalfBits;
	// Decode the two E4M3 bytes into packed Half lanes, preserving the original byte order.
	// PTX sequence: cvt.rn.f16x2.e4m3x2.
	asm("cvt.rn.f16x2.e4m3x2 %0, %1;" : "=r"(r_PackedHalfBits) : "h"(r_PackedE4Bytes));
	return r_PackedHalfBits;
}

// Issue the exact approximate FP32 reciprocal-square-root with FTZ; not a precise sqrt/divide.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:144
__device__ __forceinline__ float ApproxRsqrt(float r_Input)
{
	float r_Result;
	// Issue the exact approximate FP32 reciprocal-square-root with FTZ; not a precise sqrt/divide.
	// PTX sequence: rsqrt.approx.ftz.f32.
	asm("rsqrt.approx.ftz.f32 %0, %1;" : "=f"(r_Result) : "f"(r_Input));
	return r_Result;
}

// Issue the exact approximate FP32 reciprocal with FTZ; not precise division.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:147
__device__ __forceinline__ float ApproxRcp(float r_Input)
{
	float r_Result;
	// Issue the exact approximate FP32 reciprocal with FTZ; not precise division.
	// PTX sequence: rcp.approx.ftz.f32.
	asm("rcp.approx.ftz.f32 %0, %1;" : "=f"(r_Result) : "f"(r_Input));
	return r_Result;
}

// Exchange a word with the XOR-selected lane using exact clamp and participation masks.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:163
__device__ __forceinline__ uint32_t ShuffleBfly(uint32_t r_InputBits, uint32_t r_LaneXorMask,
												uint32_t r_ClampBits, uint32_t r_MemberMask)
{
	uint32_t r_ResultBits;
	// Exchange a word with the XOR-selected lane using exact clamp and participation masks.
	// PTX sequence: shfl.sync.bfly.b32.
	asm volatile("shfl.sync.bfly.b32 %0,%1,%2,%3,%4;"
				 : "=r"(r_ResultBits)
				 : "r"(r_InputBits), "r"(r_LaneXorMask), "r"(r_ClampBits), "r"(r_MemberMask));
	return r_ResultBits;
}

// Read the caller-selected lane using exact clamp and participation masks.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:166
__device__ __forceinline__ uint32_t ShuffleIdx(uint32_t r_InputBits, uint32_t r_SourceLane,
											   uint32_t r_ClampBits, uint32_t r_MemberMask)
{
	uint32_t r_ResultBits;
	// Read the caller-selected lane using exact clamp and participation masks.
	// PTX sequence: shfl.sync.idx.b32.
	asm volatile("shfl.sync.idx.b32 %0,%1,%2,%3,%4;"
				 : "=r"(r_ResultBits)
				 : "r"(r_InputBits), "r"(r_SourceLane), "r"(r_ClampBits), "r"(r_MemberMask));
	return r_ResultBits;
}

// Return the selected word and the original valid-lane predicate; preserve both outputs.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:169
__device__ __forceinline__ uint32_t ShuffleIdxPredicate(bool& r_bValidLane, uint32_t r_InputBits,
														uint32_t r_SourceLane, uint32_t r_ClampBits,
														uint32_t r_MemberMask)
{
	uint32_t r_ResultBits, r_ValidLaneWord;
	// Shuffle the requested lane and capture its valid predicate, then materialize that predicate as a 0/1 word.
	// PTX sequence: .reg .pred -> shfl.sync.idx.b32 -> selp.u32.
	asm volatile("{ .reg .pred p; shfl.sync.idx.b32 %0|p,%2,%3,%4,%5; selp.u32 %1,1,0,p; }"
				 : "=r"(r_ResultBits), "=r"(r_ValidLaneWord)
				 : "r"(r_InputBits), "r"(r_SourceLane), "r"(r_ClampBits), "r"(r_MemberMask));
	r_bValidLane = r_ValidLaneWord != 0;
	return r_ResultBits;
}

// Transpose the packed 8x8 b16 fragment using the original warp-wide matrix move.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:175
__device__ __forceinline__ uint32_t TransposeM8n8(uint32_t r_FragmentWord)
{
	uint32_t r_TransposedWord;
	// Transpose the packed 8x8 b16 fragment using the original warp-wide matrix move.
	// PTX sequence: movmatrix.sync.trans.aligned.m8n8.b16.
	asm volatile("movmatrix.sync.trans.aligned.m8n8.b16 %0,%1;"
				 : "=r"(r_TransposedWord)
				 : "r"(r_FragmentWord));
	return r_TransposedWord;
}

// M16N8K32 E4M3 MMA: four A words, two B words and two ordered Half accumulator/output words.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:178
__device__ __forceinline__ void MmaE4(uint32_t& r_OutputWord0, uint32_t& r_OutputWord1, uint32_t r_AFragment0,
									  uint32_t r_AFragment1, uint32_t r_AFragment2, uint32_t r_AFragment3,
									  uint32_t r_BFragment0, uint32_t r_BFragment1,
									  uint32_t r_AccumulatorWord0, uint32_t r_AccumulatorWord1)
{
	// M16N8K32 E4M3 MMA: four A words, two B words and two ordered Half accumulator/output words.
	// PTX sequence: mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16.
	asm volatile("mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16 {%0,%1},{%2,%3,%4,%5},{%6,%7},{%8,%9};"
				 : "=r"(r_OutputWord0), "=r"(r_OutputWord1)
				 : "r"(r_AFragment0), "r"(r_AFragment1), "r"(r_AFragment2), "r"(r_AFragment3),
				   "r"(r_BFragment0), "r"(r_BFragment1), "r"(r_AccumulatorWord0), "r"(r_AccumulatorWord1));
}

// Store 128 bits with the original L1 no-allocate hint and memory clobber.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:183
__device__ __forceinline__ void StoreNoAllocate(uint64_t g_GlobalAddress, uint4 r_PackedWords)
{
	// CUDA lacks a typed intrinsic for this precise original L1 hint.
	// Assemble the four ordered words into a 128-bit PTX register, then store with the original L1 no-allocate policy.
	// PTX sequence: .reg .b128 -> mov.b128 -> st.global.L1::no_allocate.b128.
	asm volatile("{ .reg .b128 v; mov.b128 v,{%1,%2,%3,%4}; st.global.L1::no_allocate.b128 [%0],v; }"
				 :
				 : "l"(g_GlobalAddress), "r"(r_PackedWords.x), "r"(r_PackedWords.y), "r"(r_PackedWords.z),
				   "r"(r_PackedWords.w)
				 : "memory");
}

// M16N8K16 Half MMA: preserve four A words, two B words and the two-word ordered accumulator.
// Source: csrc/kernel_impl/c1024_attention_chained_half_reconstructed_ops.cuh:171
__device__ __forceinline__ void MmaHalf(uint32_t& r_OutputWord0, uint32_t& r_OutputWord1,
										uint32_t r_AFragment0, uint32_t r_AFragment1, uint32_t r_AFragment2,
										uint32_t r_AFragment3, uint32_t r_BFragment0, uint32_t r_BFragment1,
										uint32_t r_AccumulatorWord0, uint32_t r_AccumulatorWord1)
{
	// M16N8K16 Half MMA: preserve four A words, two B words and the two-word ordered accumulator.
	// PTX sequence: mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16.
	asm volatile("mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16 {%0,%1},{%2,%3,%4,%5},{%6,%7},{%8,%9};"
				 : "=r"(r_OutputWord0), "=r"(r_OutputWord1)
				 : "r"(r_AFragment0), "r"(r_AFragment1), "r"(r_AFragment2), "r"(r_AFragment3),
				   "r"(r_BFragment0), "r"(r_BFragment1), "r"(r_AccumulatorWord0), "r"(r_AccumulatorWord1));
}

// Join already-converted low/high E4 pairs using mov.b32; retain the original conversion sites.
// Source: csrc/kernel_impl/c128_ordinary_reconstructed_ops.cuh:34
__device__ __forceinline__ uint32_t JoinConvertedE4(uint16_t r_LowE4Pair, uint16_t r_HighE4Pair)
{
	uint32_t r_PackedE4Word;
	// Place low_e4_pair in bits 0..15 and high_e4_pair in bits 16..31; conversion happens before this helper.
	// PTX sequence: mov.b32.
	asm("mov.b32 %0, {%1,%2};" : "=r"(r_PackedE4Word) : "h"(r_LowE4Pair), "h"(r_HighE4Pair));
	return r_PackedE4Word;
}

// Preserve the original abs.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:97
__device__ __forceinline__ uint32_t NativeAbsFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original abs.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: abs.ftz.f32.
	asm("abs.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original add.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:100
__device__ __forceinline__ uint32_t NativeAddFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original add.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: add.ftz.f32.
	asm("add.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original cvt.f32.f16 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:103
__device__ __forceinline__ uint32_t NativeCvtF32F16(uint16_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original cvt.f32.f16 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: cvt.f32.f16.
	asm("cvt.f32.f16 %0, %1;" : "=r"(r_ResultBits) : "h"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original cvt.rmi.ftz.f32.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:106
__device__ __forceinline__ uint32_t NativeCvtRmiFtzF32F32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original cvt.rmi.ftz.f32.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: cvt.rmi.ftz.f32.f32.
	asm("cvt.rmi.ftz.f32.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original cvt.rn.f16.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:109
__device__ __forceinline__ uint16_t NativeCvtRnF16F32(uint32_t r_InputBits)
{
	uint16_t r_ResultBits;
	// Preserve the original cvt.rn.f16.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: cvt.rn.f16.f32.
	asm("cvt.rn.f16.f32 %0, %1;" : "=h"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original cvt.rn.f32.s32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:112
__device__ __forceinline__ uint32_t NativeCvtRnF32S32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original cvt.rn.f32.s32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: cvt.rn.f32.s32.
	asm("cvt.rn.f32.s32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original cvt.rn.f32.u32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:115
__device__ __forceinline__ uint32_t NativeCvtRnF32U32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original cvt.rn.f32.u32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: cvt.rn.f32.u32.
	asm("cvt.rn.f32.u32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original div.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:118
__device__ __forceinline__ uint32_t NativeDivApproxFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original div.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: div.approx.ftz.f32.
	asm("div.approx.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original ex2.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:121
__device__ __forceinline__ uint32_t NativeEx2ApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original ex2.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: ex2.approx.ftz.f32.
	asm("ex2.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original fma.rn.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:124
__device__ __forceinline__ uint32_t NativeFmaRnFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits,
													  uint32_t r_AddendBits)
{
	uint32_t r_ResultBits;
	// Preserve the original fma.rn.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: fma.rn.ftz.f32.
	asm("fma.rn.ftz.f32 %0, %1, %2, %3;"
		: "=r"(r_ResultBits)
		: "r"(r_LhsBits), "r"(r_RhsBits), "r"(r_AddendBits));
	return r_ResultBits;
}

// Preserve the original max.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:127
__device__ __forceinline__ uint32_t NativeMaxFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original max.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: max.ftz.f32.
	asm("max.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original min.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:130
__device__ __forceinline__ uint32_t NativeMinFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original min.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: min.ftz.f32.
	asm("min.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original mul.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:133
__device__ __forceinline__ uint32_t NativeMulFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original mul.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: mul.ftz.f32.
	asm("mul.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original rcp.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:136
__device__ __forceinline__ uint32_t NativeRcpApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original rcp.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: rcp.approx.ftz.f32.
	asm("rcp.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original sub.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:139
__device__ __forceinline__ uint32_t NativeSubFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original sub.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: sub.ftz.f32.
	asm("sub.ftz.f32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve setp.equ.ftz.f32 comparison semantics and return its predicate; unordered qualifiers are intentional.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:142
__device__ __forceinline__ bool NativeSetpEquFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_PredicateWord;
	// Declare a predicate, perform the exact ordered/unordered FP32 comparison, then select a 0/1 result word.
	// PTX sequence: .reg .pred -> setp.equ.ftz.f32 -> selp.u32.
	asm("{ .reg .pred p; setp.equ.ftz.f32 p,%1,%2; selp.u32 %0,1,0,p; }"
		: "=r"(r_PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return r_PredicateWord != 0;
}

// Preserve setp.gt.ftz.f32 comparison semantics and return its predicate; unordered qualifiers are intentional.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:147
__device__ __forceinline__ bool NativeSetpGtFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_PredicateWord;
	// Declare a predicate, perform the exact ordered/unordered FP32 comparison, then select a 0/1 result word.
	// PTX sequence: .reg .pred -> setp.gt.ftz.f32 -> selp.u32.
	asm("{ .reg .pred p; setp.gt.ftz.f32 p,%1,%2; selp.u32 %0,1,0,p; }"
		: "=r"(r_PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return r_PredicateWord != 0;
}

// Read the original texture object with unchanged handle, coordinate bits and result lanes. Filtering, address modes and format remain caller descriptor responsibilities.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:155
__device__ __forceinline__ uint4 NativeTexture2d(uint64_t r_TextureHandle, uint32_t r_CoordinateXBits,
												 uint32_t r_CoordinateYBits)
{
	uint4 r_ResultLanes;
	// Read the original texture object with unchanged handle, coordinate bits and result lanes. Filtering, address modes and format remain caller descriptor responsibilities.
	// PTX sequence: tex.2d.v4.f32.f32.
	asm volatile("tex.2d.v4.f32.f32 {%0,%1,%2,%3}, [%4,{%5,%6}];"
				 : "=r"(r_ResultLanes.x), "=r"(r_ResultLanes.y), "=r"(r_ResultLanes.z), "=r"(r_ResultLanes.w)
				 : "l"(r_TextureHandle), "r"(r_CoordinateXBits), "r"(r_CoordinateYBits)
				 : "memory");
	return r_ResultLanes;
}

// Store through the original surface object with its unchanged zero-boundary behavior. The opaque handle and byte-coordinate contract are not reconstructed here.
// Source: csrc/kernel_impl/c32_post_fp8_reconstructed_ops.cuh:163
__device__ __forceinline__ void NativeSurface2d(uint64_t r_SurfaceHandle, uint32_t r_ByteCoordinateX,
												uint32_t r_CoordinateY, uint4 r_ValueLanes)
{
	// Store through the original surface object with its unchanged zero-boundary behavior. The opaque handle and byte-coordinate contract are not reconstructed here.
	// PTX sequence: sust.p.2d.v4.b32.zero.
	asm volatile("sust.p.2d.v4.b32.zero [%0,{%1,%2}],{%3,%4,%5,%6};"
				 :
				 : "l"(r_SurfaceHandle), "r"(r_ByteCoordinateX), "r"(r_CoordinateY), "r"(r_ValueLanes.x),
				   "r"(r_ValueLanes.y), "r"(r_ValueLanes.z), "r"(r_ValueLanes.w)
				 : "memory");
}

// Preserve the original cos.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:100
__device__ __forceinline__ uint32_t NativeCosApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original cos.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: cos.approx.ftz.f32.
	asm("cos.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original div.s32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:118
__device__ __forceinline__ uint32_t NativeDivS32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original div.s32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: div.s32.
	asm("div.s32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original div.u32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:121
__device__ __forceinline__ uint32_t NativeDivU32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_ResultBits;
	// Preserve the original div.u32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: div.u32.
	asm("div.u32 %0, %1, %2;" : "=r"(r_ResultBits) : "r"(r_LhsBits), "r"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original lg2.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:127
__device__ __forceinline__ uint32_t NativeLg2ApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original lg2.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: lg2.approx.ftz.f32.
	asm("lg2.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original mul.f16 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:136
__device__ __forceinline__ uint16_t NativeMulF16(uint16_t r_LhsBits, uint16_t r_RhsBits)
{
	uint16_t r_ResultBits;
	// Preserve the original mul.f16 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: mul.f16.
	asm("mul.f16 %0, %1, %2;" : "=h"(r_ResultBits) : "h"(r_LhsBits), "h"(r_RhsBits));
	return r_ResultBits;
}

// Preserve the original neg.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:142
__device__ __forceinline__ uint32_t NativeNegFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original neg.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: neg.ftz.f32.
	asm("neg.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original sin.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:148
__device__ __forceinline__ uint32_t NativeSinApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original sin.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: sin.approx.ftz.f32.
	asm("sin.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original sqrt.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:151
__device__ __forceinline__ uint32_t NativeSqrtApproxFtzF32(uint32_t r_InputBits)
{
	uint32_t r_ResultBits;
	// Preserve the original sqrt.approx.ftz.f32 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: sqrt.approx.ftz.f32.
	asm("sqrt.approx.ftz.f32 %0, %1;" : "=r"(r_ResultBits) : "r"(r_InputBits));
	return r_ResultBits;
}

// Preserve the original sub.f16 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:154
__device__ __forceinline__ uint16_t NativeSubF16(uint16_t r_LhsBits, uint16_t r_RhsBits)
{
	uint16_t r_ResultBits;
	// Preserve the original sub.f16 operation and raw-bit operand types. Rounding, FTZ and approximate qualifiers remain exactly as written below.
	// PTX sequence: sub.f16.
	asm("sub.f16 %0, %1, %2;" : "=h"(r_ResultBits) : "h"(r_LhsBits), "h"(r_RhsBits));
	return r_ResultBits;
}

// Preserve setp.ge.ftz.f32 comparison semantics and return its predicate; unordered qualifiers are intentional.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:160
__device__ __forceinline__ bool NativeSetpGeFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_PredicateWord;
	// Declare a predicate, perform the exact ordered/unordered FP32 comparison, then select a 0/1 result word.
	// PTX sequence: .reg .pred -> setp.ge.ftz.f32 -> selp.u32.
	asm("{ .reg .pred p; setp.ge.ftz.f32 p,%1,%2; selp.u32 %0,1,0,p; }"
		: "=r"(r_PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return r_PredicateWord != 0;
}

// Preserve setp.geu.ftz.f32 comparison semantics and return its predicate; unordered qualifiers are intentional.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:165
__device__ __forceinline__ bool NativeSetpGeuFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_PredicateWord;
	// Declare a predicate, perform the exact ordered/unordered FP32 comparison, then select a 0/1 result word.
	// PTX sequence: .reg .pred -> setp.geu.ftz.f32 -> selp.u32.
	asm("{ .reg .pred p; setp.geu.ftz.f32 p,%1,%2; selp.u32 %0,1,0,p; }"
		: "=r"(r_PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return r_PredicateWord != 0;
}

// Preserve setp.leu.ftz.f32 comparison semantics and return its predicate; unordered qualifiers are intentional.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:170
__device__ __forceinline__ bool NativeSetpLeuFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_PredicateWord;
	// Declare a predicate, perform the exact ordered/unordered FP32 comparison, then select a 0/1 result word.
	// PTX sequence: .reg .pred -> setp.leu.ftz.f32 -> selp.u32.
	asm("{ .reg .pred p; setp.leu.ftz.f32 p,%1,%2; selp.u32 %0,1,0,p; }"
		: "=r"(r_PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return r_PredicateWord != 0;
}

// Preserve setp.ltu.ftz.f32 comparison semantics and return its predicate; unordered qualifiers are intentional.
// Source: csrc/kernel_impl/c32_pre_ds_fp8_reconstructed_ops.cuh:175
__device__ __forceinline__ bool NativeSetpLtuFtzF32(uint32_t r_LhsBits, uint32_t r_RhsBits)
{
	uint32_t r_PredicateWord;
	// Declare a predicate, perform the exact ordered/unordered FP32 comparison, then select a 0/1 result word.
	// PTX sequence: .reg .pred -> setp.ltu.ftz.f32 -> selp.u32.
	asm("{ .reg .pred p; setp.ltu.ftz.f32 p,%1,%2; selp.u32 %0,1,0,p; }"
		: "=r"(r_PredicateWord)
		: "r"(r_LhsBits), "r"(r_RhsBits));
	return r_PredicateWord != 0;
}

// Commit the original async-copy group at the caller statement location.
// Source: csrc/kernel_impl/c512_ffn_inpview_fp8_reconstructed_ops.cuh:80
__device__ __forceinline__ void CopyCommit()
{
	// Commit the original async-copy group at the caller statement location.
	// PTX sequence: cp.async.commit_group.
	asm volatile("cp.async.commit_group;" : : : "memory");
}

// Wait for all prior async-copy groups using the original wait_group 0 operation.
// Source: csrc/kernel_impl/c512_ffn_inpview_fp8_reconstructed_ops.cuh:83
__device__ __forceinline__ void CopyWait0()
{
	// Wait for all prior async-copy groups using the original wait_group 0 operation.
	// PTX sequence: cp.async.wait_group.
	asm volatile("cp.async.wait_group 0;" : : : "memory");
}

// Preserve the ISA signed division semantics used by the original coordinate calculation.
// Source: csrc/kernel_impl/decoder_up512_fp8_reconstructed_ops.cuh:99
__device__ __forceinline__ uint32_t DivideSignedWord(uint32_t r_DividendBits, uint32_t r_DivisorBits)
{
	uint32_t r_QuotientBits;
	// Preserve the ISA signed division semantics used by the original coordinate calculation.
	// PTX sequence: div.s32.
	asm("div.s32 %0,%1,%2;" : "=r"(r_QuotientBits) : "r"(r_DividendBits), "r"(r_DivisorBits));
	return r_QuotientBits;
}

// Initialize a CTA-shared mbarrier with the caller arrival count; memory clobber is intentional.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:41
__device__ __forceinline__ void BarrierInit(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
											uint32_t r_ArrivalCount)
{
	// Initialize a CTA-shared mbarrier with the caller arrival count; memory clobber is intentional.
	// PTX sequence: mbarrier.init.shared.b64.
	asm volatile("mbarrier.init.shared.b64 [%0],%1;"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(r_ArrivalCount)
				 : "memory");
}

// Copy global bytes to CTA shared storage and complete the specified mbarrier transaction count.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:44
__device__ __forceinline__ void CopyBulk(unsigned char* s_SharedStorage, uint32_t s_DestinationOffset,
										 uint64_t g_GlobalSource, uint32_t r_ByteCount,
										 uint32_t s_BarrierOffset)
{
	// Copy global bytes to CTA shared storage and complete the specified mbarrier transaction count.
	// PTX sequence: cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes.
	asm volatile("cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes [%0],[%1],%2,[%3];"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_DestinationOffset)), "l"(g_GlobalSource),
				   "r"(r_ByteCount), "r"(SharedAddress(s_SharedStorage, s_BarrierOffset))
				 : "memory");
}

// Add expected transaction bytes using the original relaxed CTA-shared barrier operation.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:48
__device__ __forceinline__ void BarrierExpect(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
											  uint32_t r_ExpectedBytes)
{
	// Add expected transaction bytes using the original relaxed CTA-shared barrier operation.
	// PTX sequence: mbarrier.expect_tx.relaxed.cta.shared::cta.b64.
	asm volatile("mbarrier.expect_tx.relaxed.cta.shared::cta.b64 [%0],%1;"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(r_ExpectedBytes)
				 : "memory");
}

// Arrive at the caller barrier with its original count and return the opaque 64-bit phase token.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:52
__device__ __forceinline__ uint64_t BarrierArrive(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
												  uint32_t r_ArrivalCount)
{
	uint64_t r_PhaseToken;
	// Arrive at the caller barrier with its original count and return the opaque 64-bit phase token.
	// PTX sequence: mbarrier.arrive.shared::cta.b64.
	asm volatile("mbarrier.arrive.shared::cta.b64 %0,[%1],%2;"
				 : "=l"(r_PhaseToken)
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(r_ArrivalCount)
				 : "memory");
	return r_PhaseToken;
}

// Test the original 64-bit phase token; return readiness without changing wait/poll control.
// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh:57
__device__ __forceinline__ uint32_t BarrierReady(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
												 uint64_t r_PhaseToken)
{
	uint32_t r_ReadyWord;
	// Test the mbarrier phase token into a local predicate, then materialize readiness as a 0/1 word.
	// PTX sequence: .reg .pred -> mbarrier.try_wait.shared::cta.b64 -> selp.b32.
	asm volatile("{ .reg .pred p; mbarrier.try_wait.shared::cta.b64 p,[%1],%2; selp.b32 %0,1,0,p; }"
				 : "=r"(r_ReadyWord)
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "l"(r_PhaseToken)
				 : "memory");
	return r_ReadyWord;
}

// Issue the exact four-byte cp.async shared/global transfer; source predicate and zero fill stay at the caller.
// Source: csrc/kernel_impl/c512_ffn_inpview_fp8_reconstructed_ops.cuh:76
__device__ __forceinline__ void CopyAsync4(unsigned char* s_SharedStorage, uint32_t s_DestinationOffset,
										   uint64_t g_GlobalSource)
{
	// Issue the exact four-byte cp.async shared/global transfer; source predicate and zero fill stay at the caller.
	// PTX sequence: cp.async.ca.shared.global.
	asm volatile("cp.async.ca.shared.global [%0],[%1],4;"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_DestinationOffset)), "l"(g_GlobalSource)
				 : "memory");
}

// Compiler directive only: this is not a memory fence or synchronization operation.
// Keep the call at each original QKV PTX anchor; verify emitted placement after compilation.
__device__ __forceinline__ void EmitFenceInterferencePragma()
{
	// Emit the original compiler pragma at this call site. This directive performs no memory operation.
	// PTX sequence: .pragma.
	asm volatile(".pragma \"next knob FenceInterference\";");
}
#endif // SM120-only device primitives; host admission is enforced by the launcher.
} // namespace dlssnr::intrinsics::sm120
