#pragma once
#include "intrinsics.cuh"
#include "integer_math.cuh"
#include "packed_math.cuh"
#include "mma.cuh"
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Semantic primitives for the readable C512 FFN fp8 reconstruction. No whole
// kernel PTX is embedded here. Half arithmetic uses native CUDA intrinsics;
// short PTX is limited to ISA operations or exact cache/shuffle controls.
namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::packed_math::sm120::HalfPair;
using dlssnr::packed_math::sm120::PairBits;
// Original per-entry shared regions: input [0,12288),
// barriers [12288,12312).
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
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
