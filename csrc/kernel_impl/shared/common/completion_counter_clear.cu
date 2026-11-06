#include <dlssnr/abi/kernel_parameters.h>

// Exact original kernel definition; only the public parameter record is required.

extern "C" __global__ void completion_counter_clear(FCompletionCounterParameters Parameters)
{
	// Reset each live counter to the not-ready sentinel expected by its producer/consumer protocol.
	const int32_t g_CounterIndex = int32_t(blockIdx.x * blockDim.x + threadIdx.x);
	if (g_CounterIndex >= Parameters.CounterCount)
		return;
	reinterpret_cast<int32_t*>(Parameters.g_Counters)[g_CounterIndex] = -1;
}
