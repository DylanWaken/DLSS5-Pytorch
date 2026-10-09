// Compile explicitly, then pass the cubin to tests/test_portable_intrinsics.py --module:
// nvcc --cubin -std=c++17 -gencode arch=compute_80,code=sm_120 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.cubin
#include "../../csrc/kernel_impl/shared/common/memoryops.cuh"
#include "../../csrc/kernel_impl/shared/common/packed_math.cuh"

extern "C" __global__ void ProbeCopies(const uint4* g_Input, uint4* g_Output)
{
	__shared__ __align__(16) unsigned char s_Storage[2064];
	const int Thread = int(threadIdx.x);
	const int Warp = Thread / 32;
	if (Thread == 0)
		BarrierInit(s_Storage, 2048, 128);
	__syncthreads();

	// Four warps issue disjoint copies; all 128 threads must see those copies
	// before reading. Reuse the barrier across eight phase changes.
	for (int Phase = 0; Phase < 8; ++Phase)
	{
		if (IsCopyProducer(0xffffffffu))
		{
			CopyBulk(s_Storage, Warp * 512, uint64_t(g_Input + Phase * 128 + Warp * 32), 512, 2048);
			BarrierExpect(s_Storage, 2048, 512);
		}

		ArriveAndWait(s_Storage, 2048);
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
	const int Thread = int(threadIdx.x);
	const int Lane = Thread & 31;
	const int Warp = Thread / 32;
	const int ThreadCount = int(blockDim.x);
	const int s_StageBytes = (ThreadCount / 32) * CopiesPerWarp * CopyBytes;
	const int s_StageVectors = s_StageBytes / int(sizeof(uint4));
	if (Thread == 0)
	{
		BarrierInit(s_Storage, s_BarrierBase, ThreadCount);
		BarrierInit(s_Storage, s_BarrierBase + 8, ThreadCount);
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
				if (IsCopyProducer(0xffffffffu))
				{
					const uint64_t g_Source = uint64_t(g_Input) + Phase * s_StageBytes + s_CopyOffset;
					CopyBulk(s_Storage, s_Destination, g_Source, CopyBytes, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, CopyBytes);
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
		ArriveAndWait(s_Storage, s_BarrierBase + s_Stage * 8);
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
	const int Thread = int(threadIdx.x);
	const int Lane = Thread & 31;
	const int Warp = Thread / 32;
	const int ThreadCount = int(blockDim.x);
	const int WarpCount = ThreadCount / 32;
	const int s_StageBytes = WarpCount * CopiesPerWarp * CopyBytes;
	const int s_StageVectors = s_StageBytes / int(sizeof(uint4));
	if (Thread == 0)
	{
		BarrierInit(s_Storage, s_BarrierBase, ThreadCount);
		BarrierInit(s_Storage, s_BarrierBase + 8, ThreadCount);
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
				if (IsCopyProducer(0xffffffffu))
				{
					const uint64_t g_Source = uint64_t(g_Input) + Phase * s_StageBytes + s_CopyOffset;
					CopyBulk(s_Storage, s_Destination, g_Source, CopyBytes, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, CopyBytes);
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
	ArriveAndWait(s_Storage, s_BarrierBase);

	for (int Phase = 0; Phase < PhaseCount; ++Phase)
	{
		// Wait(Phase) includes every thread's arrival after reading Phase-1.
		// Its old slot is therefore free for Phase+1 before reading this phase.
		if (Phase + 1 < PhaseCount)
			IssueStage(Phase + 1);

		// Rotate readers by one warp so they consume other producers' copies.
		// A different slow reader each phase stresses inter-warp slot release.
		if (Warp == Phase % WarpCount)
			PollSleep(128);
		const auto* s_ReadyStage = reinterpret_cast<const uint4*>(s_Storage + (Phase & 1) * s_StageBytes);
		for (int s_Vector = Thread; s_Vector < s_StageVectors; s_Vector += ThreadCount)
		{
			const int s_ReadVector = (s_Vector + 32) % s_StageVectors;
			g_Output[Phase * s_StageVectors + s_Vector] = s_ReadyStage[s_ReadVector];
		}

		// No after-read CTA barrier: the next stage's ordinary mbarrier arrivals
		// both complete its copies and release this slot for the next iteration.
		if (Phase + 1 < PhaseCount)
			ArriveAndWait(s_Storage, s_BarrierBase + ((Phase + 1) & 1) * 8);
	}
}

extern "C" __global__ void ProbeHalfReduction(const uint4* g_Input, uint4* g_Output)
{
	// A thread owns four independent Half2 words. Repeated launches check each
	// component's rounding without introducing nondeterministic inter-CTA order.
	const int g_Vector = int(blockIdx.x) * int(blockDim.x) + int(threadIdx.x);
	ReduceHalf4(uint64_t(g_Output + g_Vector), g_Input[g_Vector]);
}

extern "C" __global__ void ProbeExclusiveHalfReduction(const uint4* g_Input, uint4* g_Output)
{
	// Identical ownership and input layout to the atomic oracle above. Both
	// destinations are initialized by the host before these ordered launches.
	const int g_Vector = int(blockIdx.x) * int(blockDim.x) + int(threadIdx.x);
	AccumulateExclusiveHalf4(uint64_t(g_Output + g_Vector), g_Input[g_Vector]);
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
	const uint64_t g_CounterAddress = uint64_t(g_Counters + Tile);
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
				while (int32_t(CounterLoadRelaxed(g_CounterAddress)) < Publication - 1)
					PollSleep(64);
				AcquireSplitPublication();
			}

			__syncthreads();
		}

		const uint4 r_Contribution = g_Input[Publication * g_PhaseVectors + g_Vector];
		if (Split == 0)
			StoreNoAllocate(g_ScratchAddress, r_Contribution);
		else if (Split < SplitCount - 1)
		{
			if constexpr (bExclusive)
				AccumulateExclusiveHalf4(g_ScratchAddress, r_Contribution);
			else
				ReduceHalf4(g_ScratchAddress, r_Contribution);
		}
		else
		{
			// Match the deployment's last split: consume scratch and publish the
			// final sum elsewhere, leaving intermediate scratch unchanged.
			const uint4 r_Previous = LoadSplitAccumulatorHalf4(g_ScratchAddress);
			StoreNoAllocate(
				uint64_t(g_Output + Phase * g_PhaseVectors + g_Vector),
				make_uint4(HalfAdd(r_Previous.x, r_Contribution.x), HalfAdd(r_Previous.y, r_Contribution.y),
						   HalfAdd(r_Previous.z, r_Contribution.z), HalfAdd(r_Previous.w, r_Contribution.w)));
		}

		// Every lane finishes its write before the publishing lane releases the
		// next CTA; the next phase must also wait for all final-output readers.
		__syncthreads();
		if (Thread == 0)
			CounterStoreRelease(g_CounterAddress, Publication);
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
