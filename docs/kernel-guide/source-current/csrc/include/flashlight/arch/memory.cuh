#pragma once
// Canonical memory and ordering instruction primitives.
//
// Layout formation, predicates and synchronization ownership stay with callers.
// In particular, the counter/fence helpers below do not imply a CTA barrier.
#include <flashlight/core.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace arch
{
// Convert a generic shared pointer and byte offset to a 32-bit CTA-shared address.
__device__ __forceinline__ std::uint32_t shared_address(unsigned char* shared_storage,
														std::uint32_t byte_offset)
{
	return std::uint32_t(__cvta_generic_to_shared(shared_storage + byte_offset));
}

// Cache-all vector/scalar global load. The caller owns alignment and validity.
template <typename T> __device__ __forceinline__ T load_global_ca(const T* address)
{
	return __ldca(address);
}

// Cache-global vector/scalar global load. The caller owns alignment and validity.
template <typename T> __device__ __forceinline__ T load_global_cg(const T* address)
{
	return __ldcg(address);
}

// Read an aligned cache-all 16-byte vector only when valid; otherwise retain four
// zeros. The predicate suppresses the memory access, and +r constraints preserve
// the zero initialization.
__device__ __forceinline__ uint4 load_global_ca_or_zero(std::uint64_t global_address, bool valid)
{
	uint4 result = make_uint4(0, 0, 0, 0);
	asm volatile("{ .reg .pred r_bLoadEnabled; setp.ne.u32 r_bLoadEnabled, %5, 0; "
				 "@r_bLoadEnabled ld.global.ca.v4.u32 {%0,%1,%2,%3}, [%4]; }"
				 : "+r"(result.x), "+r"(result.y), "+r"(result.z), "+r"(result.w)
				 : "l"(global_address), "r"(std::uint32_t(valid))
				 : "memory");
	return result;
}

// Store one aligned 16-byte vector without allocating an L1 line.
__device__ __forceinline__ void store_no_allocate(std::uint64_t global_address, uint4 packed_words)
{
	asm volatile(
		"{ .reg .b128 r_StoreVector; mov.b128 r_StoreVector,{%1,%2,%3,%4}; st.global.L1::no_allocate.b128 [%0],r_StoreVector; }"
		:
		: "l"(global_address), "r"(packed_words.x), "r"(packed_words.y), "r"(packed_words.z),
		  "r"(packed_words.w)
		: "memory");
}

// Add four Half2 words using global reduction without flushing subnormal Half
// values. SM90+ retains the native vector atomic; earlier targets preserve the
// same element-wise atomicity and rounding through four scalar reductions.
__device__ __forceinline__ void reduce_half4_add_noftz(std::uint64_t global_address, uint4 packed_half_words)
{
#if __CUDA_ARCH__ >= 900
	asm volatile("red.global.v4.f16x2.add.noftz [%0],{%1,%2,%3,%4};"
				 :
				 : "l"(global_address), "r"(packed_half_words.x), "r"(packed_half_words.y),
				   "r"(packed_half_words.z), "r"(packed_half_words.w)
				 : "memory");
#else
	asm volatile("red.global.add.noftz.f16x2 [%0],%1;\n"
				 "red.global.add.noftz.f16x2 [%0+4],%2;\n"
				 "red.global.add.noftz.f16x2 [%0+8],%3;\n"
				 "red.global.add.noftz.f16x2 [%0+12],%4;"
				 :
				 : "l"(global_address), "r"(packed_half_words.x), "r"(packed_half_words.y),
				   "r"(packed_half_words.z), "r"(packed_half_words.w)
				 : "memory");
#endif
}

// Load a GPU-scope relaxed completion counter without allocating an L1 line.
__device__ __forceinline__ std::uint32_t load_relaxed_counter_bits(std::uint64_t global_counter_address)
{
	std::uint32_t counter_bits;
	asm volatile("ld.relaxed.gpu.global.L1::no_allocate.s32 %0,[%1];"
				 : "=r"(counter_bits)
				 : "l"(global_counter_address)
				 : "memory");
	return counter_bits;
}

// Publish a GPU-scope release counter without allocating an L1 line.
__device__ __forceinline__ void store_release_counter_bits(std::uint64_t global_counter_address,
														   std::uint32_t counter_bits)
{
	asm volatile("st.release.gpu.global.L1::no_allocate.s32 [%0],%1;"
				 :
				 : "l"(global_counter_address), "r"(counter_bits)
				 : "memory");
}

// Complete the acquire pattern after observing a predecessor's release counter.
// The caller's following CTA barrier carries that visibility to every consumer;
// issue this once after the polling loop, not on every unsuccessful read.
__device__ __forceinline__ void acquire_split_publication_fence()
{
	asm volatile("fence.acq_rel.gpu;" : : : "memory");
}

} // namespace arch
} // namespace flashlight
#endif // SM80+
