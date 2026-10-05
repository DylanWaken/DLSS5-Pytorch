#pragma once
#include "intrinsics.cuh"
#include <cstdint>

// Tensor-fragment interface shared by both original MMA precisions.
// FP8 and FP16 still select independent, exact ISA operations and K dimensions.
namespace dlssnr::mma::sm120
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
enum class EInputPrecision
{
	Fp8,
	Fp16
};

struct FAFragment
{
	uint32_t Word0, Word1, Word2, Word3;
};

struct FBFragment
{
	uint32_t Word0, Word1;
};

struct FAccumulator
{
	uint32_t Word0, Word1;
};

struct FOutput
{
	uint32_t& Word0;
	uint32_t& Word1;
};

// Value-owned input fragments preserve argument evaluation before output writes.
// Output references are passed directly to the exact ISA wrapper; no repacking,
// accumulator conversion or extra assignment is introduced by this interface.
template <EInputPrecision r_Precision>
__device__ __forceinline__ void MultiplyAccumulate(FOutput r_Output, FAFragment r_A, FBFragment r_B,
												   FAccumulator r_Accumulator)
{
	if constexpr (r_Precision == EInputPrecision::Fp8)
	{
		dlssnr::intrinsics::sm120::MmaE4(r_Output.Word0, r_Output.Word1, r_A.Word0, r_A.Word1, r_A.Word2,
										 r_A.Word3, r_B.Word0, r_B.Word1, r_Accumulator.Word0,
										 r_Accumulator.Word1);
	}
	else
	{
		dlssnr::intrinsics::sm120::MmaHalf(r_Output.Word0, r_Output.Word1, r_A.Word0, r_A.Word1, r_A.Word2,
										   r_A.Word3, r_B.Word0, r_B.Word1, r_Accumulator.Word0,
										   r_Accumulator.Word1);
	}
}

#endif
} // namespace dlssnr::mma::sm120
