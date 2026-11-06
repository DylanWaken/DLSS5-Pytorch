#pragma once
// Exact warp-control primitives recovered from the native code.
//
// The multidimensional fallback for lane election deliberately preserves the
// original linear-thread expression: threadIdx.x + blockDim.x * (threadIdx.y +
// blockDim.y * threadIdx.z). Shuffle clamp and member-mask operands are explicit
// at every call site; no default mask is assumed here.
#include <flashlight/core.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace arch
{
// Linear CTA thread index used by the native lane fallback.
__device__ __forceinline__ std::uint32_t linear_thread_index()
{
	return threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z);
}

// Warp lane under the same multidimensional block shapes used by the fallback.
__device__ __forceinline__ std::uint32_t warp_lane()
{
	return linear_thread_index() & 31u;
}

// Elect one lane from the member mask and return its predicate as a 0/1 word.
// SM90+ uses elect.sync. Earlier targets use a synchronized ballot so a
// converged member-mask contract is preserved even when arrivals are subsets.
__device__ __forceinline__ std::uint32_t elect_one(std::uint32_t member_mask)
{
#if __CUDA_ARCH__ >= 900
	std::uint32_t elected_word;
	asm volatile(
		"{ .reg .pred r_bElectedLane; elect.sync _|r_bElectedLane,%1; selp.b32 %0,1,0,r_bElectedLane; }"
		: "=r"(elected_word)
		: "r"(member_mask));
	return elected_word;
#else
	const std::uint32_t active_mask = __ballot_sync(member_mask, true) & member_mask;
	const std::uint32_t lane = warp_lane();
	return active_mask != 0 && lane == std::uint32_t(__ffs(active_mask) - 1);
#endif
}

// Select one issuer per bulk transfer on SM90+, or every lane in the member
// mask on earlier targets where each lane contributes a 16-byte copy.
__device__ __forceinline__ std::uint32_t is_copy_producer(std::uint32_t member_mask)
{
#if __CUDA_ARCH__ >= 900
	return elect_one(member_mask);
#else
	const std::uint32_t lane = warp_lane();
	return (member_mask >> lane) & 1u;
#endif
}

// Exchange a word with the XOR-selected lane under the supplied clamp and member masks.
__device__ __forceinline__ std::uint32_t shuffle_xor(std::uint32_t input_bits, std::uint32_t lane_xor_mask,
													 std::uint32_t clamp_bits, std::uint32_t member_mask)
{
	std::uint32_t result_bits;
	asm volatile("shfl.sync.bfly.b32 %0,%1,%2,%3,%4;"
				 : "=r"(result_bits)
				 : "r"(input_bits), "r"(lane_xor_mask), "r"(clamp_bits), "r"(member_mask));
	return result_bits;
}

// Read a word from the indexed lane under the supplied clamp and member masks.
__device__ __forceinline__ std::uint32_t shuffle_index(std::uint32_t input_bits, std::uint32_t source_lane,
													   std::uint32_t clamp_bits, std::uint32_t member_mask)
{
	std::uint32_t result_bits;
	asm volatile("shfl.sync.idx.b32 %0,%1,%2,%3,%4;"
				 : "=r"(result_bits)
				 : "r"(input_bits), "r"(source_lane), "r"(clamp_bits), "r"(member_mask));
	return result_bits;
}

// Transpose an 8x8 Half matrix held in warp registers into the complementary
// MMA layout. This is MOVM only; the tree contains no ldmatrix/stmatrix path.
__device__ __forceinline__ std::uint32_t transpose_m8n8(std::uint32_t fragment_word)
{
	std::uint32_t transposed_word;
	asm volatile("movmatrix.sync.trans.aligned.m8n8.b16 %0,%1;" : "=r"(transposed_word) : "r"(fragment_word));
	return transposed_word;
}

// Pause a polling lane for the requested nanoseconds.
__device__ __forceinline__ void poll_sleep(std::uint32_t nanoseconds)
{
	asm volatile("nanosleep.u32 %0;" : : "r"(nanoseconds) : "memory");
}

} // namespace arch
} // namespace flashlight
#endif // SM80+
