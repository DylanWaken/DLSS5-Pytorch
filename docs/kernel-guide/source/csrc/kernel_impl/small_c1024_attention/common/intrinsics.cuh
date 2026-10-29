#pragma once
#include "../../shared/common/warp_window32.cuh"

// Narrow arithmetic helpers shared by the two Small31 attention exports.
// Scores, the exponent surrogate, probability precision and publication stay
// native; probability-times-value accumulation and every row-denominator
// addition are widened. Keeping these bodies here avoids duplicating the lane
// mapping.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800

// Accumulate one M16xN8xK16 Half product into four persistent FP32 D registers.
// The D order is the native C fragment: d0/d1 hold the two columns owned by the
// lane for row Lane/4, and d2/d3 hold those columns for row Lane/4+8.
__device__ __forceinline__ void MmaHalfF32(float (&r_Output)[4], const FWindowAFragment& r_LeftOperand,
										   const uint32_t (&r_RightOperand)[2])
{
	asm volatile("mma.sync.aligned.m16n8k16.row.col.f32.f16.f16.f32 "
				 "{%0,%1,%2,%3},{%4,%5,%6,%7},{%8,%9},{%0,%1,%2,%3};"
				 : "+f"(r_Output[0]), "+f"(r_Output[1]), "+f"(r_Output[2]), "+f"(r_Output[3])
				 : "r"(r_LeftOperand.r_Word[0]), "r"(r_LeftOperand.r_Word[1]),
				   "r"(r_LeftOperand.r_Word[2]), "r"(r_LeftOperand.r_Word[3]),
				   "r"(r_RightOperand[0]), "r"(r_RightOperand[1]));
}

// Accumulate one M16xN8xK32 E4M3 product into four persistent FP32 D registers.
// The operand and D layouts match MmaHalfF32, so the P/V lane map is unchanged.
__device__ __forceinline__ void MmaE4F32(float (&r_Output)[4], const FWindowAFragment& r_LeftOperand,
										 const uint32_t (&r_RightOperand)[2])
{
#if __CUDA_ARCH__ >= 890
	asm volatile("mma.sync.aligned.m16n8k32.row.col.f32.e4m3.e4m3.f32 "
				 "{%0,%1,%2,%3},{%4,%5,%6,%7},{%8,%9},{%0,%1,%2,%3};"
				 : "+f"(r_Output[0]), "+f"(r_Output[1]), "+f"(r_Output[2]), "+f"(r_Output[3])
				 : "r"(r_LeftOperand.r_Word[0]), "r"(r_LeftOperand.r_Word[1]),
				   "r"(r_LeftOperand.r_Word[2]), "r"(r_LeftOperand.r_Word[3]),
				   "r"(r_RightOperand[0]), "r"(r_RightOperand[1]));
#else
	// FP8 entries are rejected before SM89; keep the shared declaration visible.
	__trap();
#endif
}

// Dispatch the PV product to the precision's native FP32-accumulating MMA.
template <bool bFp8>
__device__ __forceinline__ void MmaWindowFragmentF32(const FWindowAFragment& r_LeftOperand,
													 const uint32_t (&r_RightOperand)[2],
													 float (&r_Accumulator)[4])
{
	if constexpr (bFp8)
		MmaE4F32(r_Accumulator, r_LeftOperand, r_RightOperand);
	else
		MmaHalfF32(r_Accumulator, r_LeftOperand, r_RightOperand);
}

// Round one FP32 column pair to the packed-Half order every publication helper
// consumes. This is the single Half rounding of the normalized result.
__device__ __forceinline__ uint32_t PackFloatColumnsHalf2(float r_LowColumn, float r_HighColumn)
{
	return JoinHalfwords(__half_as_ushort(__float2half_rn(r_LowColumn)),
						 __half_as_ushort(__float2half_rn(r_HighColumn)));
}

// Widen one packed native-Half probability pair into two independent FP32
// components. Every probability term enters the denominator reduction through
// this conversion, so no Half addition precedes the FP32 row sums.
__device__ __forceinline__ float2 WidenHalfPairFloat2(uint32_t r_PackedHalfBits)
{
	return make_float2(__half2float(__ushort_as_half(uint16_t(r_PackedHalfBits))),
					   __half2float(__ushort_as_half(uint16_t(r_PackedHalfBits >> 16))));
}

// Add corresponding FP32 components. The caller keeps the recovered packed-Half
// addition order, so each logical row sum sees the same 16 terms in the same tree.
__device__ __forceinline__ float2 AddFloat2Componentwise(float2 r_Lhs, float2 r_Rhs)
{
	return make_float2(r_Lhs.x + r_Rhs.x, r_Lhs.y + r_Rhs.y);
}

// Apply the same four-word permutation as PermuteGlobalAttentionQuad to FP32
// component pairs, preserving the recovered two-level warp transpose mapping.
__device__ __forceinline__ void PermuteGlobalAttentionQuadFloat2(float2 (&r_ProbabilitySums)[4],
																 int r_Permutation)
{
	// Two conditional swap levels implement Words[i] = Words[i XOR p].
	// Fixed indices keep the quartet in registers during the warp transpose.
	#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const float2 r_EvenWord = r_ProbabilitySums[r_Pair * 2],
					 r_OddWord = r_ProbabilitySums[r_Pair * 2 + 1];
		r_ProbabilitySums[r_Pair * 2] = (r_Permutation & 1) ? r_OddWord : r_EvenWord;
		r_ProbabilitySums[r_Pair * 2 + 1] = (r_Permutation & 1) ? r_EvenWord : r_OddWord;
	}

	#pragma unroll
	for (int r_Pair = 0; r_Pair < 2; ++r_Pair)
	{
		const float2 r_EvenWord = r_ProbabilitySums[r_Pair], r_OddWord = r_ProbabilitySums[r_Pair + 2];
		r_ProbabilitySums[r_Pair] = (r_Permutation & 2) ? r_OddWord : r_EvenWord;
		r_ProbabilitySums[r_Pair + 2] = (r_Permutation & 2) ? r_EvenWord : r_OddWord;
	}
}

// Read the indexed lane's two FP32 components under the recovered clamp/member
// masks. Both components come from the same source lane, so the lane transpose
// mapping is unchanged.
__device__ __forceinline__ float2 ShuffleFloat2Idx(float2 r_Input, uint32_t r_SourceLane,
												   uint32_t ClampBits, uint32_t MemberMask)
{
	return make_float2(
		__uint_as_float(ShuffleIdx(__float_as_uint(r_Input.x), r_SourceLane, ClampBits, MemberMask)),
		__uint_as_float(ShuffleIdx(__float_as_uint(r_Input.y), r_SourceLane, ClampBits, MemberMask)));
}

// Finish one row sum exactly where the recovered reduction combines the low and
// high packed-Half lane totals, now as a single FP32 addition.
__device__ __forceinline__ float TotalFloat2(float2 r_Value)
{
	return r_Value.x + r_Value.y;
}

// Match the native max(denominator, epsilon) clamp for FP32 totals. A NaN total
// selects the positive epsilon exactly as the packed-Half maximum does.
__device__ __forceinline__ float ClampDenominatorFloat(float r_Denominator, float r_Epsilon)
{
	return r_Denominator > r_Epsilon ? r_Denominator : r_Epsilon;
}

#endif // SM80+ Small31 attention helpers.
