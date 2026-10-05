#pragma once
#include "intrinsics.cuh"
#include "integer_math.cuh"
#include "packed_math.cuh"
#include "mma.cuh"
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Semantic primitives for the readable C512 FFN half reconstruction. No whole
// kernel PTX is embedded here. Half arithmetic uses native CUDA intrinsics;
// short PTX is limited to ISA operations or exact cache/shuffle controls.
namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint64_t g_Pointer32;
	uint8_t Reserved40[24];
	uint32_t Scalar64;
	uint32_t Scalar68;
	uint32_t Scalar72;
	uint32_t Scalar76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, g_Pointer32) == 32);
static_assert(offsetof(Parameters, Scalar64) == 64);
static_assert(offsetof(Parameters, Scalar68) == 68);
static_assert(offsetof(Parameters, Scalar72) == 72);
static_assert(offsetof(Parameters, Scalar76) == 76);

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::packed_math::sm120::HalfPair;
using dlssnr::packed_math::sm120::PairBits;
// Original per-entry shared regions: input [0,8192),
// barriers [8192,8208).
// Convert generic C++ pointers to CTA shared addresses only at ISA boundaries.
using dlssnr::intrinsics::sm120::SharedAddress;
using dlssnr::intrinsics::sm120::Elected;
using dlssnr::intrinsics::sm120::BarrierInit;
using dlssnr::intrinsics::sm120::CopyBulk;
using dlssnr::intrinsics::sm120::BarrierExpect;
using dlssnr::intrinsics::sm120::BarrierArrive;
using dlssnr::intrinsics::sm120::BarrierReady;
using dlssnr::integer_math::sm120::SignExtendWordBits;

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
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
