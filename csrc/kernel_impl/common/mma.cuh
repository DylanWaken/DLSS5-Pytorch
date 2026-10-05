#pragma once
#include "intrinsics.cuh"
#include <cstdint>

// Tensor-fragment interface shared by both original MMA precisions.
// FP8 and FP16 still select independent, exact ISA operations and K dimensions.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
enum class EMmaInputPrecision
{
	Fp8,
	Fp16
};

// Left matrix operand A: four lane-owned packed words in mma.sync operand order.
struct FMmaAFragment
{
	uint32_t r_FragmentWord0, r_FragmentWord1, r_FragmentWord2, r_FragmentWord3;
};

// Right matrix operand B: two lane-owned packed words in mma.sync operand order.
struct FMmaBFragment
{
	uint32_t r_FragmentWord0, r_FragmentWord1;
};

// Input accumulator C: two packed Half2 words, updated as D = A*B + C.
struct FMmaAccumulator
{
	uint32_t r_FragmentWord0, r_FragmentWord1;
};

// Destination D aliases the caller's two packed Half2 accumulator words.
struct FMmaOutput
{
	uint32_t& r_FragmentWord0;
	uint32_t& r_FragmentWord1;
};

// Value-owned input fragments preserve argument evaluation before output writes.
// Output references are passed directly to the exact ISA wrapper; no repacking,
// accumulator conversion or extra assignment is introduced by this interface.
template <EMmaInputPrecision InputPrecision>
__device__ __forceinline__ void MMA(FMmaOutput r_Output, FMmaAFragment r_LeftOperand,
									FMmaBFragment r_RightOperand, FMmaAccumulator r_Accumulator)
{
	if constexpr (InputPrecision == EMmaInputPrecision::Fp8)
	{
		MmaE4(r_Output.r_FragmentWord0, r_Output.r_FragmentWord1, r_LeftOperand.r_FragmentWord0,
			  r_LeftOperand.r_FragmentWord1, r_LeftOperand.r_FragmentWord2, r_LeftOperand.r_FragmentWord3,
			  r_RightOperand.r_FragmentWord0, r_RightOperand.r_FragmentWord1, r_Accumulator.r_FragmentWord0,
			  r_Accumulator.r_FragmentWord1);
	}
	else
	{
		MmaHalf(r_Output.r_FragmentWord0, r_Output.r_FragmentWord1, r_LeftOperand.r_FragmentWord0,
				r_LeftOperand.r_FragmentWord1, r_LeftOperand.r_FragmentWord2, r_LeftOperand.r_FragmentWord3,
				r_RightOperand.r_FragmentWord0, r_RightOperand.r_FragmentWord1, r_Accumulator.r_FragmentWord0,
				r_Accumulator.r_FragmentWord1);
	}
}

#endif
