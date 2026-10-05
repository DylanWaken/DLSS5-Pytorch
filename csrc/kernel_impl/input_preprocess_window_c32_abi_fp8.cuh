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
namespace dlssnr::reconstructed::input_preprocess_window_c32_fp8
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[66];
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

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

template <unsigned Offset> __device__ __forceinline__ uint32_t ParameterU32(const Parameters& r_P)
{
	static_assert(Offset % 4 == 0 && Offset + 4 <= 264);
	return r_P.Words[Offset / 4];
}

template <unsigned Offset> __device__ __forceinline__ uint64_t ParameterU64(const Parameters& r_P)
{
	static_assert(Offset % 8 == 0 && Offset + 8 <= 264);
	return uint64_t(r_P.Words[Offset / 4]) | (uint64_t(r_P.Words[Offset / 4 + 1]) << 32);
}

using dlssnr::intrinsics::sm120::NativeAddFtzF32;
using dlssnr::intrinsics::sm120::NativeCosApproxFtzF32;
using dlssnr::intrinsics::sm120::NativeCvtRmiFtzF32F32;
using dlssnr::intrinsics::sm120::NativeCvtRnF16F32;
using dlssnr::intrinsics::sm120::NativeCvtRnF32S32;
using dlssnr::intrinsics::sm120::NativeCvtRnF32U32;
using dlssnr::intrinsics::sm120::NativeDivApproxFtzF32;
using dlssnr::intrinsics::sm120::NativeFmaRnFtzF32;
using dlssnr::intrinsics::sm120::NativeLg2ApproxFtzF32;
using dlssnr::intrinsics::sm120::NativeMaxFtzF32;
using dlssnr::intrinsics::sm120::NativeMinFtzF32;
using dlssnr::intrinsics::sm120::NativeMulF16;
using dlssnr::intrinsics::sm120::NativeMulFtzF32;
using dlssnr::intrinsics::sm120::NativeNegFtzF32;
using dlssnr::intrinsics::sm120::NativeRcpApproxFtzF32;
using dlssnr::intrinsics::sm120::NativeSinApproxFtzF32;
using dlssnr::intrinsics::sm120::NativeSqrtApproxFtzF32;
using dlssnr::intrinsics::sm120::NativeSubF16;
using dlssnr::intrinsics::sm120::NativeSubFtzF32;
using dlssnr::intrinsics::sm120::NativeSetpGeFtzF32;
using dlssnr::intrinsics::sm120::NativeSetpGeuFtzF32;
using dlssnr::intrinsics::sm120::NativeSetpLeuFtzF32;
using dlssnr::intrinsics::sm120::NativeSetpLtuFtzF32;
// Runtime opaque handle and raw coordinate/result bits are passed unchanged.
// Texture format, normalized-coordinate mode, filters and address modes belong
// to the caller's descriptor and are not reconstructed by these kernel bodies.
using dlssnr::intrinsics::sm120::NativeTexture2d;
using dlssnr::mma::sm120::MmaHalf;
#endif // The private host launch rejects every architecture except SM120.
} // namespace dlssnr::reconstructed::input_preprocess_window_c32_fp8
