#include "kernel_symbols.h"
#include "kernel_impl/common/kernel_abi.h"
#include <c10/cuda/CUDAException.h>
#include <cuda_runtime_api.h>
#include <array>

struct FKernelSymbolEntry
{
	const char* Name;
	const void* Function;
};

#include "kernel_symbols_generated.inl"

std::string KernelSymbol(const std::string& Name)
{
	// Resolve the current binary's stubs once, without allocating or launching.
	// Keeping address lookup on the host avoids dependencies on CUDA name mangling.
	for (const auto& Entry : GetKernelSymbolTable())
	{
		if (Name == Entry.Name)
		{
			const char* CompiledName = nullptr;
			C10_CUDA_CHECK(cudaFuncGetName(&CompiledName, Entry.Function));
			TORCH_CHECK(CompiledName != nullptr, "CUDA returned no compiled name for ", Name);
			return CompiledName;
		}
	}
	TORCH_CHECK(false, "unknown logical kernel name: ", Name);
}
