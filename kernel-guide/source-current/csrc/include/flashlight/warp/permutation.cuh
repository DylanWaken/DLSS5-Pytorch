#pragma once
// Recovered four-register permutation and packed shuffle compositions.
//
// The two-level conditional swap is the exact lane-ownership transpose used by
// PermuteRowSums, PermuteGlobalAttentionQuad and the float2 Small31 variant:
// Words[i] = Words[i XOR permutation]. Fixed array indices keep the quartet in
// registers. Distinct reduction/softmax schedules are not merged here.
#include <flashlight/core.cuh>
#include <flashlight/arch/warp.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace warp
{
// Exact two-level permutation for a four-value register quartet. Instantiated by
// the native call sites for uint32_t and float2; the copy logic is generic.
template <typename T> __device__ __forceinline__ void permute_quad(T (&words)[4], int permutation)
{
	// Level 0 swaps adjacent words for bit 0 of the permutation.
	#pragma unroll
	for (int pair = 0; pair < 2; ++pair)
	{
		const T even_word = words[pair * 2];
		const T odd_word = words[pair * 2 + 1];
		words[pair * 2] = (permutation & 1) ? odd_word : even_word;
		words[pair * 2 + 1] = (permutation & 1) ? even_word : odd_word;
	}

	// Level 1 swaps the two pairs for bit 1 of the permutation.
	#pragma unroll
	for (int pair = 0; pair < 2; ++pair)
	{
		const T even_word = words[pair];
		const T odd_word = words[pair + 2];
		words[pair] = (permutation & 2) ? odd_word : even_word;
		words[pair + 2] = (permutation & 2) ? even_word : odd_word;
	}
}

// Read both FP32 components from the same indexed lane. Sharing one source lane
// preserves the recovered transpose mapping; members/clamps stay caller-owned.
__device__ __forceinline__ float2 shuffle_index(float2 value, std::uint32_t source_lane,
												std::uint32_t clamp_bits, std::uint32_t member_mask)
{
	return make_float2(
		__uint_as_float(arch::shuffle_index(__float_as_uint(value.x), source_lane, clamp_bits, member_mask)),
		__uint_as_float(arch::shuffle_index(__float_as_uint(value.y), source_lane, clamp_bits, member_mask)));
}

// Indexed exchange of one packed Half2 word under the caller's masks.
__device__ __forceinline__ PackedHalf2 shuffle_index(PackedHalf2 value, std::uint32_t source_lane,
													 std::uint32_t clamp_bits, std::uint32_t member_mask)
{
	return PackedHalf2{arch::shuffle_index(value.bits, source_lane, clamp_bits, member_mask)};
}

} // namespace warp
} // namespace flashlight
#endif // SM80+
