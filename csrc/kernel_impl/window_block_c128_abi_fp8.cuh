#pragma once
#include "intrinsics.cuh"
#include "integer_math.cuh"
#include "packed_math.cuh"
#include "mma.cuh"
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Semantic primitives for the readable ordinary C128 reconstruction. No whole
// kernel PTX is embedded here. Half arithmetic uses native CUDA intrinsics;
// short PTX is limited to ISA operations or exact cache/shuffle controls.
namespace dlssnr::reconstructed::window_block_c128_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::packed_math::sm120::HalfPair;
using dlssnr::packed_math::sm120::PairBits;
using dlssnr::packed_math::sm120::JoinHalfwords;
// Same-lane word assembly of two already converted E4 pairs. No conversion,
// rounding, saturation or byte/lane permutation occurs inside this helper.
using dlssnr::intrinsics::sm120::JoinConvertedE4;
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

// Original direct conversion: no NaN-cleaning mask, identical low/high order.
using dlssnr::intrinsics::sm120::PublishE4;
using dlssnr::intrinsics::sm120::DecodeE4;
using dlssnr::intrinsics::sm120::ApproxRsqrt;
using dlssnr::intrinsics::sm120::ApproxRcp;
using dlssnr::packed_math::sm120::RsqrtHalf2;
using dlssnr::packed_math::sm120::RcpHalf2;
// PTX clamp/member masks are retained literally, including subgroup boundaries.
using dlssnr::intrinsics::sm120::ShuffleBfly;
using dlssnr::intrinsics::sm120::ShuffleIdx;
using dlssnr::intrinsics::sm120::ShuffleIdxPredicate;
using dlssnr::intrinsics::sm120::TransposeM8n8;
using dlssnr::mma::sm120::MmaE4;
using dlssnr::intrinsics::sm120::StoreNoAllocate;
#endif // The private host launch rejects every architecture except SM120.
} // namespace dlssnr::reconstructed::window_block_c128_fp8
