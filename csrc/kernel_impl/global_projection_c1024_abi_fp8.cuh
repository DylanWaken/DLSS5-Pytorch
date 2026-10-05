#pragma once
#include "intrinsics.cuh"
#include "integer_math.cuh"
#include "memoryops.cuh"
#include "packed_math.cuh"
#include "mma.cuh"
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstdint>
#include <cstddef>

// Semantic primitives for the readable C1024 projection fp8 reconstruction. No whole
// kernel PTX is embedded here. Half arithmetic uses native CUDA intrinsics;
// short PTX is limited to ISA operations or exact cache/shuffle controls.
namespace dlssnr::reconstructed::global_projection_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::packed_math::sm120::HalfPair;
using dlssnr::packed_math::sm120::PairBits;
// Exact original named shared regions within one aligned allocation:
// [0,8192) 20shared_input_storage
// [8192,8208) 27shared_copy_barrier_storage
// Convert generic C++ pointers to CTA shared addresses only at ISA boundaries.
using dlssnr::intrinsics::sm120::SharedAddress;
using dlssnr::intrinsics::sm120::Elected;
using dlssnr::intrinsics::sm120::BarrierInit;
using dlssnr::intrinsics::sm120::CopyBulk;
using dlssnr::intrinsics::sm120::BarrierExpect;
using dlssnr::intrinsics::sm120::BarrierArrive;
using dlssnr::intrinsics::sm120::BarrierReady;
using dlssnr::integer_math::sm120::SignExtendWordBits;

// Carry native generic shared pointers as real generic pointers. Convert back
// to an offset at cvta.to.shared so shared_address() rebases exactly once.
using dlssnr::memoryops::sm120::SharedGeneric;
using dlssnr::memoryops::sm120::SharedOffset;
// Original device-scope polling/publication qualifiers are preserved literally.
// This does not upgrade relaxed polling to acquire or add a new fence.
using dlssnr::intrinsics::sm120::CounterLoadRelaxed;
using dlssnr::intrinsics::sm120::CounterStoreRelease;
using dlssnr::intrinsics::sm120::ReduceHalf4;
using dlssnr::intrinsics::sm120::PollSleep;

// Defined low-width signed conversion, independent of host char signedness.
using dlssnr::integer_math::sm120::SignExtendByteBits;
using dlssnr::integer_math::sm120::SignExtendHalfBits;
// Explicit original scalar floating opcodes; never multiply their bit patterns.
using dlssnr::intrinsics::sm120::FloatMulFtzBits;
using dlssnr::intrinsics::sm120::FloatSqrtApproxFtzBits;
using dlssnr::packed_math::sm120::UintToFloatRnBits;
using dlssnr::packed_math::sm120::HalfToFloatBits;
using dlssnr::packed_math::sm120::HalfSub;

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
} // namespace dlssnr::reconstructed::global_projection_c1024_fp8
