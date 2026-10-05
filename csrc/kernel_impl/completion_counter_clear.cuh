#pragma once
#include "global_repack_layout.cuh"

// Exact original kernel definition; shared physical-layout algebra lives in the included header.

extern "C" __global__ void completion_counter_clear(FCompletionCounterParameters r_Parameters)
{
	const int32_t g_CounterIndex = int32_t(blockIdx.x * blockDim.x + threadIdx.x);
	if (g_CounterIndex >= r_Parameters.CounterCount)
		return;
	reinterpret_cast<int32_t*>(r_Parameters.g_Counters)[g_CounterIndex] = -1;
}
