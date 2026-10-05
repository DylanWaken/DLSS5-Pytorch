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

// Semantic primitives for the readable C1024 contract_half reconstruction. No whole
// kernel PTX is embedded here. Half arithmetic uses native CUDA intrinsics;
// short PTX is limited to ISA operations or exact cache/shuffle controls.
namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
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
// Original staged-copy protocol. Offsets are relative to one aligned allocation:
// input [0,24576), barriers [24576,24600).
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
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
