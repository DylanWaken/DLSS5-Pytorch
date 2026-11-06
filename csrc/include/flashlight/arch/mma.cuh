#pragma once
// Canonical single-instruction matrix multiply-accumulate primitives.
//
// Exactly four forms exist in the recovered device code:
//   m16n8k16 FP16 x FP16 -> FP16 accumulator
//   m16n8k16 FP16 x FP16 -> FP32 accumulator
//   m16n8k32 E4M3 x E4M3 -> FP16 accumulator
//   m16n8k32 E4M3 x E4M3 -> FP32 accumulator
//
// Operand order, D/C aliasing and accumulator register class are preserved from
// the original wrappers. FP8 forms trap below SM89, matching host admission.
#include <flashlight/core.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace arch
{
// D = A*B + C with the original explicit output and C input registers.
__device__ __forceinline__ void mma_sync_f16_half_raw(std::uint32_t& output0, std::uint32_t& output1,
													  std::uint32_t a0, std::uint32_t a1, std::uint32_t a2,
													  std::uint32_t a3, std::uint32_t b0, std::uint32_t b1,
													  std::uint32_t c0, std::uint32_t c1)
{
	asm volatile("mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16 {%0,%1},{%2,%3,%4,%5},{%6,%7},{%8,%9};"
				 : "=r"(output0), "=r"(output1)
				 : "r"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(b0), "r"(b1), "r"(c0), "r"(c1));
}

// D = A*B + D in place with the original four FP32 registers and D-as-C alias.
__device__ __forceinline__ void mma_sync_f16_float_raw(float (&accumulator)[4], std::uint32_t a0,
													   std::uint32_t a1, std::uint32_t a2, std::uint32_t a3,
													   std::uint32_t b0, std::uint32_t b1)
{
	asm volatile("mma.sync.aligned.m16n8k16.row.col.f32.f16.f16.f32 "
				 "{%0,%1,%2,%3},{%4,%5,%6,%7},{%8,%9},{%0,%1,%2,%3};"
				 : "+f"(accumulator[0]), "+f"(accumulator[1]), "+f"(accumulator[2]), "+f"(accumulator[3])
				 : "r"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(b0), "r"(b1));
}

// D = A*B + C with the original explicit output and C input registers.
__device__ __forceinline__ void mma_sync_e4m3_half_raw(std::uint32_t& output0, std::uint32_t& output1,
													   std::uint32_t a0, std::uint32_t a1, std::uint32_t a2,
													   std::uint32_t a3, std::uint32_t b0, std::uint32_t b1,
													   std::uint32_t c0, std::uint32_t c1)
{
#if __CUDA_ARCH__ >= 890
	asm volatile("mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16 {%0,%1},{%2,%3,%4,%5},{%6,%7},{%8,%9};"
				 : "=r"(output0), "=r"(output1)
				 : "r"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(b0), "r"(b1), "r"(c0), "r"(c1));
#else
	// FP8 entries are rejected before SM89; keep the declaration visible to
	// shared templates without emitting unsupported ISA.
	__trap();
#endif
}

// D = A*B + D in place with the original four FP32 registers and D-as-C alias.
__device__ __forceinline__ void mma_sync_e4m3_float_raw(float (&accumulator)[4], std::uint32_t a0,
														std::uint32_t a1, std::uint32_t a2, std::uint32_t a3,
														std::uint32_t b0, std::uint32_t b1)
{
#if __CUDA_ARCH__ >= 890
	asm volatile("mma.sync.aligned.m16n8k32.row.col.f32.e4m3.e4m3.f32 "
				 "{%0,%1,%2,%3},{%4,%5,%6,%7},{%8,%9},{%0,%1,%2,%3};"
				 : "+f"(accumulator[0]), "+f"(accumulator[1]), "+f"(accumulator[2]), "+f"(accumulator[3])
				 : "r"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(b0), "r"(b1));
#else
	// FP8 entries are rejected before SM89; keep the declaration visible to
	// shared templates without emitting unsupported ISA.
	__trap();
#endif
}

// Typed precision dispatch. The accumulator is both destination and addend,
// matching every recovered call site; the raw primitives above remain available
// when a caller needs the explicit C input form.
template <InputPrecision Input, AccumulatorPrecision Accumulator>
__device__ __forceinline__ void mma_sync(MmaAccumulator<Accumulator>& accumulator,
										 const MmaAFragment<Input>& left, const MmaBFragment<Input>& right)
{
	if constexpr (Input == InputPrecision::Fp16 && Accumulator == AccumulatorPrecision::Half)
	{
		mma_sync_f16_half_raw(accumulator.word[0], accumulator.word[1], left.word[0], left.word[1],
							  left.word[2], left.word[3], right.word[0], right.word[1], accumulator.word[0],
							  accumulator.word[1]);
	}
	else if constexpr (Input == InputPrecision::Fp16 && Accumulator == AccumulatorPrecision::Float)
	{
		mma_sync_f16_float_raw(accumulator.value, left.word[0], left.word[1], left.word[2], left.word[3],
							   right.word[0], right.word[1]);
	}
	else if constexpr (Input == InputPrecision::E4M3 && Accumulator == AccumulatorPrecision::Half)
	{
		mma_sync_e4m3_half_raw(accumulator.word[0], accumulator.word[1], left.word[0], left.word[1],
							   left.word[2], left.word[3], right.word[0], right.word[1], accumulator.word[0],
							   accumulator.word[1]);
	}
	else
	{
		static_assert(Input == InputPrecision::E4M3 && Accumulator == AccumulatorPrecision::Float,
					  "Unsupported MMA precision/accumulator combination");
		mma_sync_e4m3_float_raw(accumulator.value, left.word[0], left.word[1], left.word[2], left.word[3],
								right.word[0], right.word[1]);
	}
}

} // namespace arch
} // namespace flashlight
#endif // SM80+
