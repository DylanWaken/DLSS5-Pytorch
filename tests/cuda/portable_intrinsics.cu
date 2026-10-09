// Compile explicitly, then pass the cubin to tests/test_portable_intrinsics.py --module:
// nvcc --cubin -std=c++17 -gencode arch=compute_80,code=sm_120 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.cubin
#include "../../csrc/kernel_impl/shared/common/memoryops.cuh"

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

extern "C" __global__ void ProbeHalfReduction(const uint4* g_Input, uint4* g_Output)
{
	// A thread owns four independent Half2 words. Repeated launches check each
	// component's rounding without introducing nondeterministic inter-CTA order.
	ReduceHalf4(uint64_t(g_Output + threadIdx.x), g_Input[threadIdx.x]);
}
