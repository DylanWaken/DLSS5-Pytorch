#pragma once
// Split-publication lifecycle and exclusive Half4 accumulator update.
//
// The counter operations carry their original relaxed/acq_rel/no-allocate
// qualifiers. Acquire ordering is only the GPU fence; the caller still owns the
// following CTA barrier that publishes the predecessor's data to all consumers.
// The exclusive update assumes each address belongs to exactly one lane in the
// current split and preserves one Half rounding per split.
#include <flashlight/core.cuh>
#include <flashlight/arch/memory.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace memory
{
// One GPU-scope completion counter used to order split publications.
class SplitPublication
{
  public:
	__host__ __device__ constexpr explicit SplitPublication(GlobalAddress counter) noexcept
		: counter_(counter)
	{
	}

	// Relaxed observation without allocating an L1 line.
	__device__ __forceinline__ std::uint32_t load_relaxed() const
	{
		return arch::load_relaxed_counter_bits(counter_.value());
	}

	// Release publication without allocating an L1 line.
	__device__ __forceinline__ void store_release(std::uint32_t counter_bits) const
	{
		arch::store_release_counter_bits(counter_.value(), counter_bits);
	}

	// Complete the acquire pattern after observing a predecessor release.
	// Issue once after polling, then perform the caller-owned CTA barrier.
	__device__ __forceinline__ static void acquire_fence()
	{
		arch::acquire_split_publication_fence();
	}

  private:
	GlobalAddress counter_;
};

// Read the scratch words published by a predecessor split. Pre-SM90 reads
// through L2 so a previous phase's L1 line cannot supply stale data; SM90+
// retains the native cache-all form.
__device__ __forceinline__ PackedHalf2x4 load_exclusive_half2x4(GlobalAddress address)
{
#if __CUDA_ARCH__ < 900
	const uint4 loaded = arch::load_global_cg(address.as_pointer<const uint4>());
#else
	const uint4 loaded = arch::load_global_ca(address.as_pointer<const uint4>());
#endif
	return PackedHalf2x4{{loaded.x, loaded.y, loaded.z, loaded.w}};
}

// First-split publication: aligned 16-byte no-allocate store of four Half2 words.
__device__ __forceinline__ void store_half2x4_no_allocate(GlobalAddress address, PackedHalf2x4 value)
{
	arch::store_no_allocate(address.value(),
							make_uint4(value.word[0], value.word[1], value.word[2], value.word[3]));
}

// Exclusive accumulated publication. SM90+ retains the native vector reduction;
// older GPUs perform the exclusive load/add/store sequence with one rounded
// Half addition per word and a no-allocate store.
__device__ __forceinline__ void accumulate_exclusive_half2x4(GlobalAddress address, PackedHalf2x4 value)
{
#if __CUDA_ARCH__ < 900
	const PackedHalf2x4 previous = load_exclusive_half2x4(address);
	store_half2x4_no_allocate(address, numeric::half2x4_add(previous, value));
#else
	arch::reduce_half4_add_noftz(address.value(),
								 make_uint4(value.word[0], value.word[1], value.word[2], value.word[3]));
#endif
}

} // namespace memory
} // namespace flashlight
#endif // SM80+
