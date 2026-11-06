// Compile explicitly, then pass the cubin to tests/test_portable_intrinsics.py --module:
// nvcc --cubin -std=c++17 -I csrc/include -gencode arch=compute_80,code=sm_120 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.cubin
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/publication.cuh>
#include <flashlight/layout/strided.cuh>

namespace fl = flashlight;

extern "C" __global__ void ProbeSharedLayout(const uint4* g_Input, uint4* g_Output)
{
	// Nonzero origins and more logical phases than physical slots catch disagreement
	// between a copy destination's byte_offset and the consumer's at/load/store.
	constexpr int OriginBytes = 64, StageBytes = 2048, Stages = 3, Phases = 7;
	__shared__ __align__(16) unsigned char storage[OriginBytes + Stages * StageBytes];
	const fl::memory::SharedBytes shared(storage);
	using Layout = fl::layout::ByteStrides<512, 16>;
	const fl::memory::StagedSharedLayoutView<uint4, Layout, Stages, StageBytes> tile(shared, OriginBytes);
	const int thread = int(threadIdx.x), warp = thread / 32, lane = thread % 32;
	for (int phase = 0; phase < Phases; ++phase)
	{
		if (phase & 1)
			tile.store_slot(g_Input[phase * 128 + thread], phase % Stages, warp, lane);
		else
			tile.store(g_Input[phase * 128 + thread], phase, warp, lane);
		if (phase & 1)
			tile.at_slot(phase % Stages, warp, lane).w ^= 0x12345678u;
		else
			tile.at(phase, warp, lane).w ^= 0x12345678u;
		__syncthreads();
		const int reader = (thread + 32) % 128;
		const int expected_offset = OriginBytes + (phase % Stages) * StageBytes + reader * 16;
		// This direct address is the independent old-style oracle, not a view accessor.
		g_Output[phase * 128 + thread] = *reinterpret_cast<const uint4*>(storage + expected_offset);
		g_Output[(Phases + phase) * 128 + thread] = (phase & 1)
			? tile.load_slot(phase % Stages, reader / 32, reader % 32)
			: tile.load(phase, reader / 32, reader % 32);
		g_Output[(Phases * 2 + phase) * 128 + thread] = make_uint4(
			tile.byte_offset(phase, reader / 32, reader % 32),
			tile.byte_offset_slot(phase % Stages, reader / 32, reader % 32), phase, reader);
		__syncthreads();
	}
}

extern "C" __global__ void ProbeCopies(const uint4* g_Input, uint4* g_Output)
{
	__shared__ __align__(16) unsigned char s_Storage[2064];
	const fl::memory::SharedBytes shared(s_Storage);
	const int Thread = int(threadIdx.x);
	const int Warp = Thread / 32;
	if (Thread == 0)
		fl::memory::TransactionBarrier(shared, 2048).initialize(128);
	__syncthreads();

	// Four warps issue disjoint copies; all 128 threads must see those copies
	// before reading. Reuse the barrier across eight phase changes.
	for (int Phase = 0; Phase < 8; ++Phase)
	{
		if (fl::arch::is_copy_producer(0xffffffffu))
		{
			fl::memory::TransactionBarrier(shared, 2048).copy_then_expect(
				Warp * 512, fl::memory::GlobalAddress(uint64_t(g_Input + Phase * 128 + Warp * 32)), 512);
		}

		fl::memory::TransactionBarrier(shared, 2048).arrive_and_wait();
		g_Output[Phase * 128 + Thread] = reinterpret_cast<const uint4*>(s_Storage)[Thread];

		// Every reader finishes before the next phase reuses the shared tile.
		__syncthreads();
	}
}

extern "C" __global__ void ProbeCopyRing(const uint4* g_Input, uint4* g_Output)
{
	// Eight warps need 16 KiB per stage. The runner also launches four warps
	// against the same two-stage ring, changing the ordinary arrival count.
	constexpr int CopyBytes = 1024;
	constexpr int CopiesPerWarp = 2;
	constexpr int PhaseCount = 16;
	constexpr int s_BarrierBase = 32768;
	__shared__ __align__(16) unsigned char s_Storage[s_BarrierBase + 16];
	const fl::memory::SharedBytes shared(s_Storage);
	const int Thread = int(threadIdx.x);
	const int Lane = Thread & 31;
	const int Warp = Thread / 32;
	const int ThreadCount = int(blockDim.x);
	const int s_StageBytes = (ThreadCount / 32) * CopiesPerWarp * CopyBytes;
	const int s_StageVectors = s_StageBytes / int(sizeof(uint4));
	if (Thread == 0)
	{
		fl::memory::TransactionBarrier(shared, s_BarrierBase).initialize(ThreadCount);
		fl::memory::TransactionBarrier(shared, s_BarrierBase + 8).initialize(ThreadCount);
	}

	__syncthreads();

	// Each warp issues two copies before waiting. Rotate zero-filled slots
	// between phases to detect stale data when a ring slot is recycled.
	const auto IssueStage = [&](int Phase)
	{
		const int s_Stage = Phase & 1;
		const int s_Barrier = s_BarrierBase + s_Stage * 8;
		#pragma unroll
		for (int Copy = 0; Copy < CopiesPerWarp; ++Copy)
		{
			const int s_CopyOffset = (Warp * CopiesPerWarp + Copy) * CopyBytes;
			const int s_Destination = s_Stage * s_StageBytes + s_CopyOffset;
			if ((Warp + Copy + Phase) % 3 != 0)
			{
				if (fl::arch::is_copy_producer(0xffffffffu))
				{
					const uint64_t g_Source = uint64_t(g_Input) + Phase * s_StageBytes + s_CopyOffset;
					fl::memory::TransactionBarrier(shared, s_Barrier).copy_then_expect(
						s_Destination, fl::memory::GlobalAddress(g_Source), CopyBytes);
				}
			}
			else
			{
				#pragma unroll
				for (int s_CopyByteOffset = Lane * 16; s_CopyByteOffset < CopyBytes; s_CopyByteOffset += 512)
					*reinterpret_cast<uint4*>(s_Storage + s_Destination + s_CopyByteOffset) =
						make_uint4(0, 0, 0, 0);
			}
		}
	};

	IssueStage(0);
	IssueStage(1);

	for (int Phase = 0; Phase < PhaseCount; ++Phase)
	{
		const int s_Stage = Phase & 1;
		fl::memory::TransactionBarrier(shared, s_BarrierBase + s_Stage * 8).arrive_and_wait();
		const auto* s_ReadyStage = reinterpret_cast<const uint4*>(s_Storage + s_Stage * s_StageBytes);
		for (int s_Vector = Thread; s_Vector < s_StageVectors; s_Vector += ThreadCount)
			g_Output[Phase * s_StageVectors + s_Vector] = s_ReadyStage[s_Vector];

		// All readers release this slot before the refill for Phase + 2.
		__syncthreads();
		if (Phase + 2 < PhaseCount)
			IssueStage(Phase + 2);
	}
}

extern "C" __global__ void ProbePrefetchCopies(const uint4* g_Input, uint4* g_Output, int CopyBytes)
{
	// Size for eight warps, two copies per warp, 1024 bytes per copy and two
	// physical slots. The runner also exercises four warps and 512-byte copies.
	constexpr int CopiesPerWarp = 2;
	constexpr int PhaseCount = 8;
	constexpr int s_BarrierBase = 32768;
	__shared__ __align__(16) unsigned char s_Storage[s_BarrierBase + 16];
	const fl::memory::SharedBytes shared(s_Storage);
	const int Thread = int(threadIdx.x);
	const int Lane = Thread & 31;
	const int Warp = Thread / 32;
	const int ThreadCount = int(blockDim.x);
	const int WarpCount = ThreadCount / 32;
	const int s_StageBytes = WarpCount * CopiesPerWarp * CopyBytes;
	const int s_StageVectors = s_StageBytes / int(sizeof(uint4));
	if (Thread == 0)
	{
		fl::memory::TransactionBarrier(shared, s_BarrierBase).initialize(ThreadCount);
		fl::memory::TransactionBarrier(shared, s_BarrierBase + 8).initialize(ThreadCount);
	}

	__syncthreads();

	const auto IssueStage = [&](int Phase)
	{
		const int s_Stage = Phase & 1;
		const int s_Barrier = s_BarrierBase + s_Stage * 8;
		#pragma unroll
		for (int Copy = 0; Copy < CopiesPerWarp; ++Copy)
		{
			const int s_CopyOffset = (Warp * CopiesPerWarp + Copy) * CopyBytes;
			const int s_Destination = s_Stage * s_StageBytes + s_CopyOffset;
			if ((Warp + Copy + Phase) % 3 != 0)
			{
				if (fl::arch::is_copy_producer(0xffffffffu))
				{
					const uint64_t g_Source = uint64_t(g_Input) + Phase * s_StageBytes + s_CopyOffset;
					fl::memory::TransactionBarrier(shared, s_Barrier).copy_then_expect(
						s_Destination, fl::memory::GlobalAddress(g_Source), CopyBytes);
				}
			}
			else
			{
				for (int s_CopyByteOffset = Lane * 16; s_CopyByteOffset < CopyBytes; s_CopyByteOffset += 512)
					*reinterpret_cast<uint4*>(s_Storage + s_Destination + s_CopyByteOffset) =
						make_uint4(0, 0, 0, 0);
			}
		}
	};

	// Match the deployment prologue: one ready input stage, one empty slot.
	IssueStage(0);
	fl::memory::TransactionBarrier(shared, s_BarrierBase).arrive_and_wait();

	for (int Phase = 0; Phase < PhaseCount; ++Phase)
	{
		// Wait(Phase) includes every thread's arrival after reading Phase-1.
		// Its old slot is therefore free for Phase+1 before reading this phase.
		if (Phase + 1 < PhaseCount)
			IssueStage(Phase + 1);

		// Rotate readers by one warp so they consume other producers' copies.
		// A different slow reader each phase stresses inter-warp slot release.
		if (Warp == Phase % WarpCount)
			fl::arch::poll_sleep(128);
		const auto* s_ReadyStage = reinterpret_cast<const uint4*>(s_Storage + (Phase & 1) * s_StageBytes);
		for (int s_Vector = Thread; s_Vector < s_StageVectors; s_Vector += ThreadCount)
		{
			const int s_ReadVector = (s_Vector + 32) % s_StageVectors;
			g_Output[Phase * s_StageVectors + s_Vector] = s_ReadyStage[s_ReadVector];
		}

		// No after-read CTA barrier: the next stage's ordinary mbarrier arrivals
		// both complete its copies and release this slot for the next iteration.
		if (Phase + 1 < PhaseCount)
			fl::memory::TransactionBarrier(shared, s_BarrierBase + ((Phase + 1) & 1) * 8).arrive_and_wait();
	}
}

extern "C" __global__ void ProbeHalfReduction(const uint4* g_Input, uint4* g_Output)
{
	// A thread owns four independent Half2 words. Repeated launches check each
	// component's rounding without introducing nondeterministic inter-CTA order.
	const int g_Vector = int(blockIdx.x) * int(blockDim.x) + int(threadIdx.x);
	fl::arch::reduce_half4_add_noftz(uint64_t(g_Output + g_Vector), g_Input[g_Vector]);
}

extern "C" __global__ void ProbeExclusiveHalfReduction(const uint4* g_Input, uint4* g_Output)
{
	// Identical ownership and input layout to the atomic oracle above. Both
	// destinations are initialized by the host before these ordered launches.
	const int g_Vector = int(blockIdx.x) * int(blockDim.x) + int(threadIdx.x);
	const uint4 value = g_Input[g_Vector];
	fl::memory::accumulate_exclusive_half2x4(fl::memory::GlobalAddress(uint64_t(g_Output + g_Vector)),
		fl::PackedHalf2x4{{value.x, value.y, value.z, value.w}});
}

template <bool bExclusive>
__device__ __forceinline__ void RunSplitHandoff(const uint4* g_Input, uint4* g_Output, uint4* g_Scratch,
												int32_t* g_Counters)
{
	constexpr int SplitCount = 4;
	constexpr int PhaseCount = 8;
	const int Thread = int(threadIdx.x);
	const int Tile = int(blockIdx.x);
	const int Split = int(blockIdx.z);
	const int g_PhaseVectors = int(gridDim.x) * int(blockDim.x);
	const int g_Vector = Tile * int(blockDim.x) + Thread;
	const fl::memory::SplitPublication publication(fl::memory::GlobalAddress(uint64_t(g_Counters + Tile)));
	const uint64_t g_ScratchAddress = uint64_t(g_Scratch + g_Vector);

	// The runner admits the entire eight-CTA grid against measured occupancy.
	// A phase cannot recycle scratch until its preceding final split publishes.
	for (int Phase = 0; Phase < PhaseCount; ++Phase)
	{
		const int Publication = Phase * SplitCount + Split;
		if (Publication > 0)
		{
			if (Thread == 0)
			{
				while (int32_t(publication.load_relaxed()) < Publication - 1)
					fl::arch::poll_sleep(64);
				publication.acquire_fence();
			}

			__syncthreads();
		}

		const uint4 r_Contribution = g_Input[Publication * g_PhaseVectors + g_Vector];
		if (Split == 0)
			fl::memory::store_no_allocate(fl::memory::GlobalAddress(g_ScratchAddress), r_Contribution);
		else if (Split < SplitCount - 1)
		{
			if constexpr (bExclusive)
				fl::memory::accumulate_exclusive_half2x4(fl::memory::GlobalAddress(g_ScratchAddress),
					fl::PackedHalf2x4{{r_Contribution.x, r_Contribution.y, r_Contribution.z, r_Contribution.w}});
			else
				fl::arch::reduce_half4_add_noftz(g_ScratchAddress, r_Contribution);
		}
		else
		{
			// Match the deployment's last split: consume scratch and publish the
			// final sum elsewhere, leaving intermediate scratch unchanged.
			const fl::PackedHalf2x4 r_Previous = fl::memory::load_exclusive_half2x4(
				fl::memory::GlobalAddress(g_ScratchAddress));
			fl::memory::store_half2x4_no_allocate(
				fl::memory::GlobalAddress(uint64_t(g_Output + Phase * g_PhaseVectors + g_Vector)),
				fl::numeric::half2x4_add(r_Previous,
					fl::PackedHalf2x4{{r_Contribution.x, r_Contribution.y, r_Contribution.z, r_Contribution.w}}));
		}

		// Every lane finishes its write before the publishing lane releases the
		// next CTA; the next phase must also wait for all final-output readers.
		__syncthreads();
		if (Thread == 0)
			publication.store_release(Publication);
	}
}

extern "C" __global__ void ProbeAtomicSplitHandoff(const uint4* g_Input, uint4* g_Output, uint4* g_Scratch,
												   int32_t* g_Counters)
{
	RunSplitHandoff<false>(g_Input, g_Output, g_Scratch, g_Counters);
}

extern "C" __global__ void ProbeExclusiveSplitHandoff(const uint4* g_Input, uint4* g_Output, uint4* g_Scratch,
													  int32_t* g_Counters)
{
	RunSplitHandoff<true>(g_Input, g_Output, g_Scratch, g_Counters);
}
