// Compile explicitly, then pass the PTX to tests/test_portable_intrinsics.py:
// nvcc --ptx -std=c++17 -arch=compute_80 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.ptx
#include "../../csrc/kernel_impl/shared/common/memoryops.cuh"

extern "C" __global__ void ProbeCopies(const uint4* g_Input, uint4* g_Output)
{
	__shared__ __align__(16) unsigned char s_Storage[2064];
	const int Thread = int(threadIdx.x);
	const int Warp = Thread / 32;
	if (Thread == 0)
		BarrierInit(s_Storage, 2048, 128);
	__syncthreads();

	// Four elected warp leaders issue disjoint copies; all 128 threads must see
	// those copies before reading. Reuse the barrier across eight phase changes.
	for (int Phase = 0; Phase < 8; ++Phase)
	{
		if (Elected(0xffffffffu))
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

extern "C" __global__ void ProbeHalfReduction(const uint4* g_Input, uint4* g_Output)
{
	// A thread owns four independent Half2 words. Repeated launches check each
	// component's rounding without introducing nondeterministic inter-CTA order.
	ReduceHalf4(uint64_t(g_Output + threadIdx.x), g_Input[threadIdx.x]);
}
