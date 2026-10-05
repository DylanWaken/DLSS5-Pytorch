#pragma once
#include "global_repack_layout.cuh"

// Exact original kernel definition; shared physical-layout algebra lives in the included header.
namespace dlssnr::reconstructed::completion_counter_clear
{
using ClearParameters = dlssnr::reconstructed::global_repack_layout::ClearParameters;

__global__ void completion_counter_clear(ClearParameters r_P)
{
	const int32_t g_CounterIndex = int32_t(blockIdx.x * blockDim.x + threadIdx.x);
	if (g_CounterIndex >= r_P.Count)
		return;
	reinterpret_cast<int32_t*>(r_P.g_Counters)[g_CounterIndex] = -1;
}
} // namespace dlssnr::reconstructed::completion_counter_clear
