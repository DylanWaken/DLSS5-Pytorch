#pragma once
#include "intrinsics.cuh"
#include "integer_math.cuh"
#include "packed_math.cuh"
#include "mma.cuh"
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Semantic primitives for the readable ordinary C64 reconstruction. No whole
// kernel PTX is embedded here. Half arithmetic uses native CUDA intrinsics;
// short PTX is limited to ISA operations or exact cache/shuffle controls.
namespace dlssnr::reconstructed::window_block_c128_input_view_fp16
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::packed_math::sm120::HalfPair;
using dlssnr::packed_math::sm120::PairBits;
using dlssnr::packed_math::sm120::JoinHalfwords;
using dlssnr::packed_math::sm120::HalfAdd;
using dlssnr::packed_math::sm120::HalfMul;
using dlssnr::packed_math::sm120::HalfFma;
using dlssnr::packed_math::sm120::HalfAbs;
using dlssnr::packed_math::sm120::HalfMin;
using dlssnr::packed_math::sm120::HalfMax;
using dlssnr::packed_math::sm120::FloatToHalf2;

using dlssnr::integer_math::sm120::ShiftLeft;
using dlssnr::integer_math::sm120::ShiftRight;
using dlssnr::integer_math::sm120::ShiftRightSigned;

using dlssnr::intrinsics::sm120::ApproxRsqrt;
using dlssnr::intrinsics::sm120::ApproxRcp;
using dlssnr::packed_math::sm120::RsqrtHalf2;
using dlssnr::packed_math::sm120::RcpHalf2;
// PTX clamp/member masks are retained literally, including subgroup boundaries.
using dlssnr::intrinsics::sm120::ShuffleBfly;
using dlssnr::intrinsics::sm120::ShuffleIdx;
using dlssnr::intrinsics::sm120::ShuffleIdxPredicate;
using dlssnr::intrinsics::sm120::TransposeM8n8;
using dlssnr::mma::sm120::MmaHalf;
using dlssnr::intrinsics::sm120::StoreNoAllocate;
#endif // The private host launch rejects every architecture except SM120.
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp16
