#pragma once
// Typed asynchronous-copy lifecycles over the exact arch primitives.
//
// AsyncCopyGroup is the per-thread cp.async commit/wait protocol.
// TransactionBarrier is the mbarrier byte-accounting protocol. They are
// deliberately separate types: a phase token is not a group counter and a group
// wait is not a transaction wait. Neither type inserts an implicit commit,
// zero fill, sleep, syncwarp or CTA barrier, and neither elects a producer.
#include <flashlight/core.cuh>
#include <flashlight/arch/async.cuh>
#include <flashlight/memory/views.cuh>
#include <cstdint>

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
namespace flashlight
{
namespace memory
{
// Per-thread cp.async group lifecycle. Copies are issued in caller order; commit
// closes the current group and wait_group0 waits for every committed group.
class AsyncCopyGroup
{
  public:
	// Issue one cache-all four-byte global-to-shared copy. Predicates and zero
	// fill remain outside the instruction.
	__device__ __forceinline__ static void
	copy_ca_4(SharedBytes shared, std::uint32_t destination_byte_offset, GlobalAddress global_source)
	{
		arch::copy_async_ca_4(shared.data(), destination_byte_offset, global_source.value());
	}

	__device__ __forceinline__ static void commit()
	{
		arch::commit_copy_group();
	}

	// The original wait_group 0, exposed distinctly from transaction waits.
	__device__ __forceinline__ static void wait_group0()
	{
		arch::wait_copy_group0();
	}
};

// CTA-shared transaction barrier. The caller initializes it, owns the arrival
// count and any CTA synchronization that publishes the completed stage.
class TransactionBarrier
{
  public:
	__device__ __forceinline__ TransactionBarrier(SharedBytes shared, std::uint32_t barrier_byte_offset)
		: shared_(shared), barrier_byte_offset_(barrier_byte_offset)
	{
	}

	__device__ __forceinline__ void initialize(std::uint32_t arrival_count) const
	{
		arch::barrier_init(shared_.data(), barrier_byte_offset_, arrival_count);
	}

	// Add expected transaction bytes. On pre-SM90 this is a preserved no-op
	// because the copies attach completion through cp.async.mbarrier.arrive.
	__device__ __forceinline__ void expect_bytes(std::uint32_t expected_bytes) const
	{
		arch::barrier_expect(shared_.data(), barrier_byte_offset_, expected_bytes);
	}

	// Arrive with the supplied count and return the opaque 64-bit phase token.
	__device__ __forceinline__ ArrivalToken arrive(std::uint32_t arrival_count = 1) const
	{
		return arch::barrier_arrive(shared_.data(), barrier_byte_offset_, arrival_count);
	}

	// Non-blocking phase test using the arrival token.
	__device__ __forceinline__ bool ready(ArrivalToken phase_token) const
	{
		return arch::barrier_ready(shared_.data(), barrier_byte_offset_, phase_token) != 0;
	}

	// Per-thread arrival followed by tight polling of that exact token. No CTA
	// barrier, sleep or extra memory-ordering operation is added.
	__device__ __forceinline__ void arrive_and_wait(std::uint32_t arrival_count = 1) const
	{
		const ArrivalToken phase_token = arrive(arrival_count);
		while (!ready(phase_token))
		{
		}
	}

	// Issue the bulk copy body. Producer election stays with the caller:
	// SM90+ needs one issuer (is_copy_producer), while the pre-SM90 fallback is
	// lane-striped for every member of the mask.
	__device__ __forceinline__ void copy_bulk(std::uint32_t destination_byte_offset,
											  GlobalAddress global_source, std::uint32_t byte_count) const
	{
		arch::copy_bulk_transaction(shared_.data(), destination_byte_offset, global_source.value(),
									byte_count, barrier_byte_offset_);
	}

	// Exact recovered composition: issue the copy body, then add its expected
	// bytes. Order is deliberately copy-then-expect; no commit or barrier is added.
	__device__ __forceinline__ void copy_then_expect(std::uint32_t destination_byte_offset,
													 GlobalAddress global_source,
													 std::uint32_t byte_count) const
	{
		copy_bulk(destination_byte_offset, global_source, byte_count);
		expect_bytes(byte_count);
	}

  private:
	SharedBytes shared_;
	std::uint32_t barrier_byte_offset_;
};

// Compact ring of 8-byte transaction barriers at a shared barrier base. The
// caller still initializes every slot and owns all CTA synchronization. Slot
// addressing is the recovered base + slot*8; `for_iteration` applies the
// compile-time stage modulo.
template <std::uint32_t StageCount> class TransactionBarrierRing
{
  public:
	static_assert(StageCount > 0, "Barrier ring must contain at least one slot");
	static constexpr std::uint32_t slot_bytes = 8;

	__device__ __forceinline__ TransactionBarrierRing(SharedBytes shared,
													  std::uint32_t barrier_base_byte_offset)
		: shared_(shared), barrier_base_byte_offset_(barrier_base_byte_offset)
	{
	}

	__device__ __forceinline__ TransactionBarrier at_slot(std::uint32_t slot) const
	{
		return TransactionBarrier(shared_, barrier_base_byte_offset_ + slot * slot_bytes);
	}

	__device__ __forceinline__ TransactionBarrier for_iteration(std::uint32_t iteration) const
	{
		return at_slot(iteration % StageCount);
	}

  private:
	SharedBytes shared_;
	std::uint32_t barrier_base_byte_offset_;
};

// Explicitly requested composition: finish this thread's committed cp.async
// groups, then arrive and poll the transaction barrier. No extra commit, sleep,
// warp or CTA barrier is inserted between the two named operations.
__device__ __forceinline__ void wait_group0_then_arrive_and_wait(const TransactionBarrier& barrier,
																 std::uint32_t arrival_count = 1)
{
	AsyncCopyGroup::wait_group0();
	barrier.arrive_and_wait(arrival_count);
}

} // namespace memory
} // namespace flashlight
#endif // SM80+
