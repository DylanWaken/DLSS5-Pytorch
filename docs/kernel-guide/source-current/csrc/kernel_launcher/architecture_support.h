#pragma once
#include <cuda_runtime.h>
#include <c10/cuda/CUDAException.h>
#include <c10/util/Exception.h>
#include <cstdint>

// Host admission is based on the current device and the function CUDA actually
// loaded. Compatible minor-version cubins and forward-JIT PTX remain usable.
inline int GetDeviceArchitecture(const cudaDeviceProp& Properties)
{
	return Properties.major * 10 + Properties.minor;
}

inline void RequireDevicePrecision(const cudaDeviceProp& Properties, bool bFp16, const char* Role)
{
	const int MinimumArchitecture = bFp16 ? 80 : 89;
	TORCH_CHECK(GetDeviceArchitecture(Properties) >= MinimumArchitecture, Role, ": ", bFp16 ? "FP16" : "FP8",
				" deployment requires SM", MinimumArchitecture, " or newer; selected device is SM",
				GetDeviceArchitecture(Properties));
}

struct FKernelDeviceAdmission
{
	cudaFuncAttributes Attributes{};
	int ActiveBlocksPerSm = 0;
};

inline FKernelDeviceAdmission ValidateKernelDevice(const void* Function, const cudaDeviceProp& Properties,
												   bool bFp16, dim3 Block, const char* Role)
{
	RequireDevicePrecision(Properties, bFp16, Role);
	FKernelDeviceAdmission Admission;
	// CUDA performs cubin compatibility selection or PTX JIT here. Do not require
	// binaryVersion == device SM: for example, an SM80 cubin can execute on SM86.
	C10_CUDA_CHECK(cudaFuncGetAttributes(&Admission.Attributes, Function));
	const auto& Attributes = Admission.Attributes;
	const int MinimumArchitecture = bFp16 ? 80 : 89;
	TORCH_CHECK(Attributes.binaryVersion >= MinimumArchitecture &&
					Attributes.binaryVersion <= GetDeviceArchitecture(Properties) &&
					Attributes.ptxVersion >= MinimumArchitecture,
				Role, ": the loaded kernel was not compiled with a supported ", bFp16 ? "FP16" : "FP8",
				" body (binary SM", Attributes.binaryVersion, ", virtual SM", Attributes.ptxVersion, ")");
	// The virtual target is essential: JIT can turn compute_80 PTX into an SM120
	// image while its unsupported FP8 entry still contains only a trap.
	const unsigned BlockDimensions[] = {Block.x, Block.y, Block.z};
	for (int Axis = 0; Axis < 3; ++Axis)
		TORCH_CHECK(BlockDimensions[Axis] > 0 &&
						BlockDimensions[Axis] <= unsigned(Properties.maxThreadsDim[Axis]),
					Role, ": block dimension exceeds the selected device limit");
	const uint64_t Threads = uint64_t(Block.x) * Block.y * Block.z;
	TORCH_CHECK(Threads <= uint64_t(Properties.maxThreadsPerBlock) &&
					Threads <= uint64_t(Attributes.maxThreadsPerBlock),
				Role, ": compiled function cannot launch the required block");
	TORCH_CHECK(Attributes.sharedSizeBytes <= Properties.sharedMemPerBlock, Role,
				": static shared storage exceeds the selected device limit");
	C10_CUDA_CHECK(cudaOccupancyMaxActiveBlocksPerMultiprocessor(&Admission.ActiveBlocksPerSm, Function,
																 int(Threads), 0));
	TORCH_CHECK(Admission.ActiveBlocksPerSm > 0, Role,
				": no block can reside on the selected device with the compiled resources");
	return Admission;
}

inline void ValidateKernelGrid(dim3 Grid, const cudaDeviceProp& Properties, const char* Role)
{
	const unsigned Dimensions[] = {Grid.x, Grid.y, Grid.z};
	for (int Axis = 0; Axis < 3; ++Axis)
		TORCH_CHECK(Dimensions[Axis] > 0 && Dimensions[Axis] <= unsigned(Properties.maxGridSize[Axis]), Role,
					": grid dimension exceeds the selected device limit");
}
