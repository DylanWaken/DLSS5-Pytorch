#pragma once
// Canonical asynchronous-copy and transaction-barrier instructions.
//
// Protocol ownership stays with the caller: no implicit group commit, wait,
// zero fill, sleep, syncwarp or CTA barrier is added here. The pre-SM90 bulk
// fallback retains its lane-striped 16-byte cg copies and cp.async barrier
// attachment, and BarrierExpect remains a no-op where the hardware would
// double-count an unsupported mechanism.
#include <flashlight/core.cuh>
#include <flashlight/arch/memory.cuh>
#include <flashlight/arch/warp.cuh>
#include <cstdint>

namespace flashlight
{
// Opaque 64-bit mbarrier arrival token. It is not a phase-parity bit and has no
// arithmetic interpretation outside the barrier that produced it.
class ArrivalToken
{
  public:
	__host__ __device__ constexpr ArrivalToken() noexcept : value_(0) {}

	__host__ __device__ explicit constexpr ArrivalToken(std::uint64_t value) noexcept : value_(value) {}

	__host__ __device__ constexpr std::uint64_t value() const noexcept
	{
		return value_;
	}

  private:
	std::uint64_t value_;
};

static_assert(sizeof(ArrivalToken) == 8 && alignof(ArrivalToken) == 8,
			  "ArrivalToken must remain one opaque 64-bit value");
static_assert(std::is_trivially_copyable_v<ArrivalToken>);

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace arch
{
// Issue a cache-all four-byte global-to-shared copy. The caller owns predicates
// and zero fill; this is the only 4-byte ca producer in the native pipeline.
__device__ __forceinline__ void copy_async_ca_4(unsigned char* shared_storage,
												std::uint32_t destination_byte_offset,
												std::uint64_t global_source)
{
	asm volatile("cp.async.ca.shared.global [%0],[%1],4;"
				 :
				 : "r"(shared_address(shared_storage, destination_byte_offset)), "l"(global_source)
				 : "memory");
}

// Issue a cache-global 16-byte global-to-shared copy. This is the pre-SM90 bulk
// building block; it carries no mbarrier attachment of its own.
__device__ __forceinline__ void copy_async_cg_16(unsigned char* shared_storage,
												 std::uint32_t destination_byte_offset,
												 std::uint64_t global_source)
{
	asm volatile("cp.async.cg.shared.global [%0],[%1],16;"
				 :
				 : "r"(shared_address(shared_storage, destination_byte_offset)), "l"(global_source)
				 : "memory");
}

// Commit this thread's outstanding cp.async transfers as one group.
__device__ __forceinline__ void commit_copy_group()
{
	asm volatile("cp.async.commit_group;" : : : "memory");
}

// Wait for all previously committed cp.async groups of this thread.
__device__ __forceinline__ void wait_copy_group0()
{
	asm volatile("cp.async.wait_group 0;" : : : "memory");
}

// Copy global bytes into CTA shared memory and complete against the supplied
// mbarrier. is_copy_producer selects one bulk issuer on SM90+ or all 32 striped
// producers below SM90; this primitive itself does not elect.
__device__ __forceinline__ void copy_bulk_transaction(unsigned char* shared_storage,
													  std::uint32_t destination_byte_offset,
													  std::uint64_t global_source, std::uint32_t byte_count,
													  std::uint32_t barrier_byte_offset)
{
#if __CUDA_ARCH__ >= 900
	asm volatile("cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes [%0],[%1],%2,[%3];"
				 :
				 : "r"(shared_address(shared_storage, destination_byte_offset)), "l"(global_source),
				   "r"(byte_count), "r"(shared_address(shared_storage, barrier_byte_offset))
				 : "memory");
#else
	// Adjacent lanes copy adjacent 16-byte vectors, keeping the warp's memory
	// requests coalesced. The 512/1024-byte callers issue one/two copies per lane
	// instead of serializing 32/64 copy instructions through one elected lane.
	const std::uint32_t lane = warp_lane();
	for (std::uint32_t copy_byte_offset = lane * 16; copy_byte_offset < byte_count; copy_byte_offset += 512)
	{
		copy_async_cg_16(shared_storage, destination_byte_offset + copy_byte_offset,
						 global_source + copy_byte_offset);
	}

	// Each producer attaches its own copies. The implicit pending-count
	// increment is essential: ordinary CTA arrivals alone cannot track them.
	asm volatile("cp.async.mbarrier.arrive.shared.b64 [%0];"
				 :
				 : "r"(shared_address(shared_storage, barrier_byte_offset))
				 : "memory");
#endif
}

// Initialize a CTA-shared mbarrier with the expected arrival count.
__device__ __forceinline__ void barrier_init(unsigned char* shared_storage, std::uint32_t barrier_byte_offset,
											 std::uint32_t arrival_count)
{
	asm volatile("mbarrier.init.shared.b64 [%0],%1;"
				 :
				 : "r"(shared_address(shared_storage, barrier_byte_offset)), "r"(arrival_count)
				 : "memory");
}

// Add expected transaction bytes to the CTA-shared mbarrier with relaxed ordering.
__device__ __forceinline__ void
barrier_expect(unsigned char* shared_storage, std::uint32_t barrier_byte_offset, std::uint32_t expected_bytes)
{
#if __CUDA_ARCH__ >= 900
	asm volatile("mbarrier.expect_tx.relaxed.cta.shared::cta.b64 [%0],%1;"
				 :
				 : "r"(shared_address(shared_storage, barrier_byte_offset)), "r"(expected_bytes)
				 : "memory");
#else
	// The pre-SM90 copies attach completion with cp.async.mbarrier.arrive.
	// Adding an expected byte count would double-count that mechanism.
	(void)shared_storage;
	(void)barrier_byte_offset;
	(void)expected_bytes;
#endif
}

// Arrive at the mbarrier with the supplied count and return its opaque phase token.
__device__ __forceinline__ ArrivalToken barrier_arrive(unsigned char* shared_storage,
													   std::uint32_t barrier_byte_offset,
													   std::uint32_t arrival_count)
{
	std::uint64_t phase_token;
#if __CUDA_ARCH__ >= 900
	asm volatile("mbarrier.arrive.shared::cta.b64 %0,[%1],%2;"
				 : "=l"(phase_token)
				 : "r"(shared_address(shared_storage, barrier_byte_offset)), "r"(arrival_count)
				 : "memory");
#else
	// SM80 permits an explicit count only on a non-completing arrival. Reserve
	// the final arrival for the ordinary instruction, which may complete a phase.
	// Current pipelines pass one, so the extra-count branch compiles away.
	if (arrival_count > 1)
	{
		asm volatile("mbarrier.arrive.noComplete.shared.b64 _,[%0],%1;"
					 :
					 : "r"(shared_address(shared_storage, barrier_byte_offset)), "r"(arrival_count - 1)
					 : "memory");
	}

	asm volatile("mbarrier.arrive.shared.b64 %0,[%1];"
				 : "=l"(phase_token)
				 : "r"(shared_address(shared_storage, barrier_byte_offset))
				 : "memory");
#endif
	return ArrivalToken(phase_token);
}

// Test mbarrier phase completion using the arrival token; return a 0/1 readiness
// word. SM90+ uses try_wait; earlier targets use test_wait, whose success has
// acquire visibility for copies attached with cp.async.mbarrier.arrive.
__device__ __forceinline__ std::uint32_t
barrier_ready(unsigned char* shared_storage, std::uint32_t barrier_byte_offset, ArrivalToken phase_token)
{
	std::uint32_t ready_word;
#if __CUDA_ARCH__ >= 900
	asm volatile(
		"{ .reg .pred r_bPhaseComplete; mbarrier.try_wait.shared::cta.b64 r_bPhaseComplete,[%1],%2; selp.b32 %0,1,0,r_bPhaseComplete; }"
		: "=r"(ready_word)
		: "r"(shared_address(shared_storage, barrier_byte_offset)), "l"(phase_token.value())
		: "memory");
#else
	asm volatile(
		"{ .reg .pred r_bPhaseComplete; mbarrier.test_wait.shared.b64 r_bPhaseComplete,[%1],%2; selp.b32 %0,1,0,r_bPhaseComplete; }"
		: "=r"(ready_word)
		: "r"(shared_address(shared_storage, barrier_byte_offset)), "l"(phase_token.value())
		: "memory");
#endif
	return ready_word;
}

} // namespace arch
#endif // SM80+
} // namespace flashlight
