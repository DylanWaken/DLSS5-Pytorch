#pragma once
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Architecture-selected instruction helpers preserve explicit precision,
// rounding and FTZ qualifiers; callers own layouts, masks and barrier protocols.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

// Convert a generic shared pointer and byte offset to a 32-bit CTA-shared address.
__device__ __forceinline__ uint32_t SharedAddress(unsigned char* s_SharedStorage, uint32_t s_ByteOffset)
{
	return uint32_t(__cvta_generic_to_shared(s_SharedStorage + s_ByteOffset));
}

// Elect one lane from the member mask and return its predicate as a 0/1 word.
__device__ __forceinline__ uint32_t Elected(uint32_t MemberMask)
{
#if __CUDA_ARCH__ >= 900
	uint32_t ElectedWord;
	asm volatile(
		"{ .reg .pred r_bElectedLane; elect.sync _|r_bElectedLane,%1; selp.b32 %0,1,0,r_bElectedLane; }"
		: "=r"(ElectedWord)
		: "r"(MemberMask));
	return ElectedWord;
#else
	// Bulk-copy callers reach this point uniformly within each participating warp.
	// Ampere/Ada lack elect.sync. A synchronized ballot preserves its converged
	// member-mask contract; activemask alone could elect once per arriving subset.
	const uint32_t ActiveMask = __ballot_sync(MemberMask, true) & MemberMask;
	const uint32_t Lane = (threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z)) & 31;
	return ActiveMask != 0 && Lane == uint32_t(__ffs(ActiveMask) - 1);
#endif
}

// Load a GPU-scope relaxed completion counter without allocating an L1 line.
__device__ __forceinline__ uint32_t CounterLoadRelaxed(uint64_t g_CounterAddress)
{
	uint32_t r_CounterBits;
	asm volatile("ld.relaxed.gpu.global.L1::no_allocate.s32 %0,[%1];"
				 : "=r"(r_CounterBits)
				 : "l"(g_CounterAddress)
				 : "memory");
	return r_CounterBits;
}

// Publish a GPU-scope release counter without allocating an L1 line.
__device__ __forceinline__ void CounterStoreRelease(uint64_t g_CounterAddress, uint32_t r_CounterBits)
{
	asm volatile("st.release.gpu.global.L1::no_allocate.s32 [%0],%1;"
				 :
				 : "l"(g_CounterAddress), "r"(r_CounterBits)
				 : "memory");
}

// Add four Half2 words using global reduction without flushing subnormal Half values.
__device__ __forceinline__ void ReduceHalf4(uint64_t g_GlobalAddress, uint4 r_PackedHalfWords)
{
#if __CUDA_ARCH__ >= 900
	asm volatile("red.global.v4.f16x2.add.noftz [%0],{%1,%2,%3,%4};"
				 :
				 : "l"(g_GlobalAddress), "r"(r_PackedHalfWords.x), "r"(r_PackedHalfWords.y),
				   "r"(r_PackedHalfWords.z), "r"(r_PackedHalfWords.w)
				 : "memory");
#else
	// Vector reductions are SM90+. Four scalar Half2 reductions preserve the
	// element-wise atomicity, Half rounding and subnormal behavior of that vector.
	asm volatile("red.global.add.noftz.f16x2 [%0],%1;\n"
				 "red.global.add.noftz.f16x2 [%0+4],%2;\n"
				 "red.global.add.noftz.f16x2 [%0+8],%3;\n"
				 "red.global.add.noftz.f16x2 [%0+12],%4;"
				 :
				 : "l"(g_GlobalAddress), "r"(r_PackedHalfWords.x), "r"(r_PackedHalfWords.y),
				   "r"(r_PackedHalfWords.z), "r"(r_PackedHalfWords.w)
				 : "memory");
#endif
}

// Pause a polling lane for the requested nanoseconds.
__device__ __forceinline__ void PollSleep(uint32_t Nanoseconds)
{
	asm volatile("nanosleep.u32 %0;" : : "r"(Nanoseconds) : "memory");
}

// Round four Half values to E4M3 and join the pairs in low/high byte order.
// One PTX scope exposes the F2FP MERGE_C combine without an extra PRMT.
__device__ __forceinline__ uint32_t PublishFourE4(uint32_t r_LowHalfPair, uint32_t r_HighHalfPair)
{
#if __CUDA_ARCH__ >= 890
	uint32_t r_PackedE4Word;
	asm("{ .reg .b16 r_LowE4Pair, r_HighE4Pair;\n"
		"cvt.rn.satfinite.e4m3x2.f16x2 r_LowE4Pair, %1;\n"
		"cvt.rn.satfinite.e4m3x2.f16x2 r_HighE4Pair, %2;\n"
		"mov.b32 %0, {r_LowE4Pair, r_HighE4Pair}; }"
		: "=r"(r_PackedE4Word)
		: "r"(r_LowHalfPair), "r"(r_HighHalfPair));
	return r_PackedE4Word;
#else
	// FP8 entry points are rejected by host admission below SM89. Keep their
	// declarations visible to shared templates without emitting unsupported ISA.
	__trap();
	return 0;
#endif
}

// Decode two E4M3 bytes to packed Half values in the same lane order.
__device__ __forceinline__ uint32_t DecodeE4(uint16_t r_PackedE4Bytes)
{
#if __CUDA_ARCH__ >= 890
	uint32_t r_PackedHalfBits;
	asm("cvt.rn.f16x2.e4m3x2 %0, %1;" : "=r"(r_PackedHalfBits) : "h"(r_PackedE4Bytes));
	return r_PackedHalfBits;
#else
	__trap();
	return 0;
#endif
}

// Compute approximate FP32 reciprocal sqrt with subnormal flushing.
__device__ __forceinline__ float ApproxRsqrt(float r_Input)
{
	float r_Result;
	asm("rsqrt.approx.ftz.f32 %0, %1;" : "=f"(r_Result) : "f"(r_Input));
	return r_Result;
}

// Compute approximate FP32 reciprocal with subnormal flushing.
__device__ __forceinline__ float ApproxRcp(float r_Input)
{
	float r_Result;
	asm("rcp.approx.ftz.f32 %0, %1;" : "=f"(r_Result) : "f"(r_Input));
	return r_Result;
}

// Exchange a word with the XOR-selected lane under the supplied clamp and member masks.
__device__ __forceinline__ uint32_t ShuffleBfly(uint32_t r_InputBits, uint32_t r_LaneXorMask,
												uint32_t ClampBits, uint32_t MemberMask)
{
	uint32_t r_ResultBits;
	asm volatile("shfl.sync.bfly.b32 %0,%1,%2,%3,%4;"
				 : "=r"(r_ResultBits)
				 : "r"(r_InputBits), "r"(r_LaneXorMask), "r"(ClampBits), "r"(MemberMask));
	return r_ResultBits;
}

// Read a word from the indexed lane under the supplied clamp and member masks.
__device__ __forceinline__ uint32_t ShuffleIdx(uint32_t r_InputBits, uint32_t r_SourceLane,
											   uint32_t ClampBits, uint32_t MemberMask)
{
	uint32_t r_ResultBits;
	asm volatile("shfl.sync.idx.b32 %0,%1,%2,%3,%4;"
				 : "=r"(r_ResultBits)
				 : "r"(r_InputBits), "r"(r_SourceLane), "r"(ClampBits), "r"(MemberMask));
	return r_ResultBits;
}

// Transpose an 8x8 Half matrix held in warp registers into the complementary MMA layout.
__device__ __forceinline__ uint32_t TransposeM8n8(uint32_t r_FragmentWord)
{
	uint32_t r_TransposedWord;
	asm volatile("movmatrix.sync.trans.aligned.m8n8.b16 %0,%1;"
				 : "=r"(r_TransposedWord)
				 : "r"(r_FragmentWord));
	return r_TransposedWord;
}

// Accumulate an M16xN8xK32 E4M3 matrix product into two packed Half words.
__device__ __forceinline__ void MmaE4(uint32_t& r_OutputWord0, uint32_t& r_OutputWord1, uint32_t r_AFragment0,
									  uint32_t r_AFragment1, uint32_t r_AFragment2, uint32_t r_AFragment3,
									  uint32_t r_BFragment0, uint32_t r_BFragment1,
									  uint32_t r_AccumulatorWord0, uint32_t r_AccumulatorWord1)
{
#if __CUDA_ARCH__ >= 890
	asm volatile("mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16 {%0,%1},{%2,%3,%4,%5},{%6,%7},{%8,%9};"
				 : "=r"(r_OutputWord0), "=r"(r_OutputWord1)
				 : "r"(r_AFragment0), "r"(r_AFragment1), "r"(r_AFragment2), "r"(r_AFragment3),
				   "r"(r_BFragment0), "r"(r_BFragment1), "r"(r_AccumulatorWord0), "r"(r_AccumulatorWord1));
#else
	__trap();
#endif
}

// Store one aligned 16-byte vector without allocating an L1 line.
__device__ __forceinline__ void StoreNoAllocate(uint64_t g_GlobalAddress, uint4 r_PackedWords)
{
	asm volatile(
		"{ .reg .b128 r_StoreVector; mov.b128 r_StoreVector,{%1,%2,%3,%4}; st.global.L1::no_allocate.b128 [%0],r_StoreVector; }"
		:
		: "l"(g_GlobalAddress), "r"(r_PackedWords.x), "r"(r_PackedWords.y), "r"(r_PackedWords.z),
		  "r"(r_PackedWords.w)
		: "memory");
}

// Accumulate an M16xN8xK16 Half matrix product into two packed Half words.
__device__ __forceinline__ void MmaHalf(uint32_t& r_OutputWord0, uint32_t& r_OutputWord1,
										uint32_t r_AFragment0, uint32_t r_AFragment1, uint32_t r_AFragment2,
										uint32_t r_AFragment3, uint32_t r_BFragment0, uint32_t r_BFragment1,
										uint32_t r_AccumulatorWord0, uint32_t r_AccumulatorWord1)
{
	asm volatile("mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16 {%0,%1},{%2,%3,%4,%5},{%6,%7},{%8,%9};"
				 : "=r"(r_OutputWord0), "=r"(r_OutputWord1)
				 : "r"(r_AFragment0), "r"(r_AFragment1), "r"(r_AFragment2), "r"(r_AFragment3),
				   "r"(r_BFragment0), "r"(r_BFragment1), "r"(r_AccumulatorWord0), "r"(r_AccumulatorWord1));
}

// Initialize a CTA-shared mbarrier with the expected arrival count.
__device__ __forceinline__ void BarrierInit(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
											uint32_t ArrivalCount)
{
	asm volatile("mbarrier.init.shared.b64 [%0],%1;"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(ArrivalCount)
				 : "memory");
}

// Copy global bytes into CTA shared memory and complete bytes against the supplied mbarrier.
__device__ __forceinline__ void CopyBulk(unsigned char* s_SharedStorage, uint32_t s_DestinationOffset,
										 uint64_t g_GlobalSource, uint32_t ByteCount,
										 uint32_t s_BarrierOffset)
{
#if __CUDA_ARCH__ >= 900
	asm volatile("cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes [%0],[%1],%2,[%3];"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_DestinationOffset)), "l"(g_GlobalSource),
				   "r"(ByteCount), "r"(SharedAddress(s_SharedStorage, s_BarrierOffset))
				 : "memory");
#else
	// The elected producer copies the same aligned byte interval in 16-byte
	// pieces. SM80 cp.async needs no transaction-byte counter: its arrive-on
	// instruction increments pending arrivals before completion decrements them.
	// Thus BarrierInit still counts only the CTA's ordinary thread arrivals.
	for (uint32_t s_CopyByteOffset = 0; s_CopyByteOffset < ByteCount; s_CopyByteOffset += 16)
	{
		asm volatile("cp.async.cg.shared.global [%0],[%1],16;"
					 :
					 : "r"(SharedAddress(s_SharedStorage, s_DestinationOffset + s_CopyByteOffset)),
					   "l"(g_GlobalSource + s_CopyByteOffset)
					 : "memory");
	}

	asm volatile("cp.async.mbarrier.arrive.shared.b64 [%0];"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset))
				 : "memory");
#endif
}

// Add expected transaction bytes to the CTA-shared mbarrier with relaxed ordering.
__device__ __forceinline__ void BarrierExpect(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
											  uint32_t ExpectedBytes)
{
#if __CUDA_ARCH__ >= 900
	asm volatile("mbarrier.expect_tx.relaxed.cta.shared::cta.b64 [%0],%1;"
				 :
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(ExpectedBytes)
				 : "memory");
#else
	// CopyBulk already attaches completion to this barrier using arrive-on.
	// Adding an expected byte count would double-count an unsupported mechanism.
	(void)s_SharedStorage;
	(void)s_BarrierOffset;
	(void)ExpectedBytes;
#endif
}

// Arrive at the mbarrier with the supplied count and return its opaque phase token.
__device__ __forceinline__ uint64_t BarrierArrive(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
												  uint32_t ArrivalCount)
{
	uint64_t PhaseToken;
#if __CUDA_ARCH__ >= 900
	asm volatile("mbarrier.arrive.shared::cta.b64 %0,[%1],%2;"
				 : "=l"(PhaseToken)
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(ArrivalCount)
				 : "memory");
#else
	// SM80 permits an explicit count only on a non-completing arrival. Reserve
	// the final arrival for the ordinary instruction, which may complete a phase.
	// Current pipelines pass one, so the extra-count branch compiles away.
	if (ArrivalCount > 1)
	{
		asm volatile("mbarrier.arrive.noComplete.shared.b64 _,[%0],%1;"
					 :
					 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "r"(ArrivalCount - 1)
					 : "memory");
	}

	asm volatile("mbarrier.arrive.shared.b64 %0,[%1];"
				 : "=l"(PhaseToken)
				 : "r"(SharedAddress(s_SharedStorage, s_BarrierOffset))
				 : "memory");
#endif
	return PhaseToken;
}

// Test mbarrier phase completion using the arrival token; return a 0/1 readiness word.
__device__ __forceinline__ uint32_t BarrierReady(unsigned char* s_SharedStorage, uint32_t s_BarrierOffset,
												 uint64_t PhaseToken)
{
	uint32_t ReadyWord;
#if __CUDA_ARCH__ >= 900
	asm volatile(
		"{ .reg .pred r_bPhaseComplete; mbarrier.try_wait.shared::cta.b64 r_bPhaseComplete,[%1],%2; selp.b32 %0,1,0,r_bPhaseComplete; }"
		: "=r"(ReadyWord)
		: "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "l"(PhaseToken)
		: "memory");
#else
	// A successful test_wait has acquire visibility for copies attached with
	// cp.async.mbarrier.arrive, including copies issued by other CTA threads.
	asm volatile(
		"{ .reg .pred r_bPhaseComplete; mbarrier.test_wait.shared.b64 r_bPhaseComplete,[%1],%2; selp.b32 %0,1,0,r_bPhaseComplete; }"
		: "=r"(ReadyWord)
		: "r"(SharedAddress(s_SharedStorage, s_BarrierOffset)), "l"(PhaseToken)
		: "memory");
#endif
	return ReadyWord;
}

#endif // SM80+ device primitives; precision admission is enforced by the launcher.
