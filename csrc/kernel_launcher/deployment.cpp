#include "deployment.h"
#include "windows_dispatch.inl"
#include "c512_dispatch.inl"
#include "global_compute_abi.h"
#include "global_connectors_abi.h"
#include "compiled_resolution_policy.h"
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <algorithm>
#include <map>
#include <set>

namespace dlssnr::deployment
{
#include "plan_geometry_generated.inl"
#include "plan_generated.inl"

namespace
{
constexpr int64_t GuardBytes = 256;
constexpr uint8_t GuardPattern = 0xA5;

uint64_t GetTensorAddress(const at::Tensor& g_Tensor)
{
	return reinterpret_cast<uint64_t>(g_Tensor.data_ptr());
}

void ValidatePhysicalBuffer(const at::Tensor& g_Tensor, int64_t Bytes, int DeviceIndex, const char* Role)
{
	TORCH_CHECK(g_Tensor.defined() && g_Tensor.is_cuda() && g_Tensor.get_device() == DeviceIndex &&
					g_Tensor.scalar_type() == at::kByte,
				Role, " must be raw uint8 on the plan's CUDA device");
	TORCH_CHECK(g_Tensor.dim() == 1 && g_Tensor.is_contiguous() && g_Tensor.numel() == Bytes, Role,
				" physical extent must be exactly ", Bytes, " bytes");
	TORCH_CHECK(GetTensorAddress(g_Tensor) % 16 == 0, "physical tensor must be 16-byte aligned: ", Role);
}

void RequireOutsideCapture(cudaStream_t Stream)
{
	cudaStreamCaptureStatus StatusValue{};
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream, &StatusValue));
	TORCH_CHECK(StatusValue == cudaStreamCaptureStatusNone,
				"create deployment plan outside CUDA graph capture");
}
} // namespace

uint64_t FDeploymentPlan_fp8::GetBufferAddress(size_t Index) const
{
	return GetTensorAddress(g_Buffers.at(Index));
}

uint64_t FDeploymentPlan_fp8::GetRecordAddress(size_t Index) const
{
	return GetTensorAddress(g_Records.at(Index));
}

FDeploymentPlan_fp8::FDeploymentPlan_fp8(at::Tensor g_Input, std::vector<at::Tensor> g_InputRecords,
										 int64_t Width, int64_t Height)
	: g_Records(std::move(g_InputRecords)), DeviceIndex(g_Input.is_cuda() ? g_Input.get_device() : -1)
{
	TORCH_CHECK(DeviceIndex >= 0, "deployment input must be CUDA physical storage");
	Geometry = &SelectGeometryPlan(Width, Height);
	c10::cuda::CUDAGuard DeviceGuard(g_Input.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	RequireOutsideCapture(Stream.stream());
	cudaDeviceProp Properties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&Properties, DeviceIndex));
	TORCH_CHECK(Properties.major == 12 && Properties.minor == 0,
				"this reconstructed schedule is currently admitted only on SM120");
	const auto Selection =
		resolution_policy::Select(int(Width), int(Height), 120, resolution_policy::EPrecision::Fp8);
	TORCH_CHECK(Selection.ConfigId == -1 || Selection.ConfigId == 0,
				"policy selects a configuration absent from this compiled reconstruction");
	ValidatePhysicalBuffer(g_Input, Geometry->BufferBytes[0], DeviceIndex, "FP8 trunk input");
	TORCH_CHECK(g_Records.size() == std::size(RecordSpecs), "expected ", std::size(RecordSpecs),
				" native packed records");
	std::vector<std::pair<uint64_t, uint64_t>> g_StorageRanges;
	g_StorageRanges.emplace_back(GetTensorAddress(g_Input), GetTensorAddress(g_Input) + g_Input.numel());
	for (size_t Index = 0; Index < g_Records.size(); ++Index)
	{
		ValidatePhysicalBuffer(g_Records[Index], RecordSpecs[Index].Bytes, DeviceIndex,
							   RecordSpecs[Index].Name);
		const auto g_RecordAddress = GetTensorAddress(g_Records[Index]);
		g_StorageRanges.emplace_back(g_RecordAddress, g_RecordAddress + g_Records[Index].numel());
		g_RecordAddresses.push_back(g_RecordAddress);
	}
	std::sort(g_StorageRanges.begin(), g_StorageRanges.end());
	for (size_t Index = 1; Index < g_StorageRanges.size(); ++Index)
		TORCH_CHECK(g_StorageRanges[Index - 1].second <= g_StorageRanges[Index].first,
					"input and packed record ranges must be disjoint");
	// Guard each workspace so replay validation detects writes outside its physical extent.
	g_Buffers.reserve(std::size(BufferNameTable));
	g_Buffers.push_back(std::move(g_Input));
	for (size_t Index = 1; Index < std::size(BufferNameTable); ++Index)
	{
		auto g_Backing =
			at::full({Geometry->BufferBytes[Index] + 2 * GuardBytes}, GuardPattern, g_Buffers[0].options());
		g_Buffers.push_back(g_Backing.narrow(0, GuardBytes, Geometry->BufferBytes[Index]));
		g_GuardedBackings.push_back(std::move(g_Backing));
	}
	for (const auto& g_Tensor : g_Buffers)
		g_Addresses.push_back(GetTensorAddress(g_Tensor));
	BuildCalls();
	TORCH_CHECK(Calls.size() == 185, "reconstructed trunk schedule census");
	// Ordered split reductions require every participating block to fit concurrently.
	std::set<const void*> UniqueKernels;
	for (const auto& KernelCall : Calls)
	{
		cudaFuncAttributes Attributes{};
		C10_CUDA_CHECK(cudaFuncGetAttributes(&Attributes, KernelCall.Function));
		const auto ThreadsPerBlock = KernelCall.Block.x * KernelCall.Block.y * KernelCall.Block.z;
		TORCH_CHECK(Attributes.binaryVersion == 120 && Attributes.maxThreadsPerBlock >= int(ThreadsPerBlock),
					"linked reconstructed kernel architecture or block size differs");
		for (int Axis = 0; Axis < 3; ++Axis)
		{
			const unsigned GridDimensions[] = {KernelCall.Grid.x, KernelCall.Grid.y, KernelCall.Grid.z};
			TORCH_CHECK(GridDimensions[Axis] > 0 &&
							GridDimensions[Axis] <= unsigned(Properties.maxGridSize[Axis]),
						"grid outside device limits");
		}
		int ActiveBlocksPerSm = 0;
		C10_CUDA_CHECK(cudaOccupancyMaxActiveBlocksPerMultiprocessor(&ActiveBlocksPerSm, KernelCall.Function,
																	 int(ThreadsPerBlock), 0));
		TORCH_CHECK(!KernelCall.bAllResident ||
						int64_t(ActiveBlocksPerSm) * Properties.multiProcessorCount >=
							int64_t(KernelCall.Grid.x) * KernelCall.Grid.y * KernelCall.Grid.z,
					"ordered split reduction exceeds compiled resident capacity");
		if (UniqueKernels.insert(KernelCall.Function).second)
		{
			const int64_t ResourceRow[] = {Attributes.numRegs, int64_t(Attributes.sharedSizeBytes),
										   int64_t(Attributes.localSizeBytes), Attributes.maxThreadsPerBlock,
										   ActiveBlocksPerSm};
			ResourceRows.insert(ResourceRows.end(), std::begin(ResourceRow), std::end(ResourceRow));
		}
	}
	TORCH_CHECK(UniqueKernels.size() == 37, "36 compute/repack entries plus counter clear expected");
}

at::Tensor FDeploymentPlan_fp8::Run_fp8()
{
	std::lock_guard<std::mutex> Lock(LaunchMutex);
	c10::cuda::CUDAGuard DeviceGuard(g_Buffers[0].device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (size_t Index = 0; Index < g_Buffers.size(); ++Index)
	{
		ValidatePhysicalBuffer(g_Buffers[Index], Geometry->BufferBytes[Index], DeviceIndex,
							   BufferNameTable[Index]);
		TORCH_CHECK(GetTensorAddress(g_Buffers[Index]) == g_Addresses[Index],
					"plan buffer storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(g_Buffers[Index].storage().data_ptr(), Stream);
	}
	for (size_t Index = 0; Index < g_Records.size(); ++Index)
	{
		ValidatePhysicalBuffer(g_Records[Index], RecordSpecs[Index].Bytes, DeviceIndex,
							   RecordSpecs[Index].Name);
		TORCH_CHECK(GetTensorAddress(g_Records[Index]) == g_RecordAddresses[Index],
					"plan record storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(g_Records[Index].storage().data_ptr(), Stream);
	}
	// Parameters and storage are prepared once; capture records these same kernel launches.
	for (auto& KernelCall : Calls)
	{
		void* Arguments[] = {KernelCall.ParameterBlock.data()};
		C10_CUDA_CHECK(cudaLaunchKernel(KernelCall.Function, KernelCall.Grid, KernelCall.Block, Arguments, 0,
										Stream.stream()));
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return g_Buffers.back();
}

std::vector<std::string> FDeploymentPlan_fp8::GetBufferNames() const
{
	std::vector<std::string> Names;
	for (const auto* Name : BufferNameTable)
		Names.emplace_back(Name);
	return Names;
}

bool FDeploymentPlan_fp8::GuardsIntact() const
{
	c10::cuda::CUDAGuard DeviceGuard(g_Buffers[0].device());
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (const auto& g_Backing : g_GuardedBackings)
		if (!g_Backing.narrow(0, 0, GuardBytes).eq(GuardPattern).all().item<bool>() ||
			!g_Backing.narrow(0, g_Backing.numel() - GuardBytes, GuardBytes)
				 .eq(GuardPattern)
				 .all()
				 .item<bool>())
			return false;
	return true;
}

void FDeploymentPlan_fp8::Poison(int64_t Value)
{
	TORCH_CHECK(Value >= 0 && Value <= 255, "poison requires byte value");
	c10::cuda::CUDAGuard DeviceGuard(g_Buffers[0].device());
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (size_t Index = 1; Index < g_Buffers.size(); ++Index)
		g_Buffers[Index].fill_(Value);
}

at::Tensor FDeploymentPlan_fp8::GetBuffer(const std::string& Name) const
{
	for (size_t Index = 0; Index < std::size(BufferNameTable); ++Index)
		if (Name == BufferNameTable[Index])
			return g_Buffers[Index];
	TORCH_CHECK(false, "unknown deployment buffer: ", Name);
}

std::vector<std::string> FDeploymentPlan_fp8::GetBoundaryNames() const
{
	std::vector<std::string> Names;
	for (int BlockIndex = 1; BlockIndex <= 69; ++BlockIndex)
	{
		Names.push_back("b" + std::to_string(BlockIndex) + ".output");
		if (BlockIndex == 4 || BlockIndex == 8 || BlockIndex == 14 || BlockIndex == 22 || BlockIndex == 30)
			Names.push_back("b" + std::to_string(BlockIndex) + ".down");
	}
	return Names;
}

std::vector<at::Tensor> FDeploymentPlan_fp8::GetBoundaries() const
{
	std::vector<at::Tensor> g_BoundaryOutputs;
	for (const auto& Name : GetBoundaryNames())
		g_BoundaryOutputs.push_back(GetBuffer(Name));
	return g_BoundaryOutputs;
}

std::vector<std::string> RecordNames_fp8()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : RecordSpecs)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_fp8()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : RecordSpecs)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
}

std::string CompiledPolicyVersion()
{
	return resolution_policy::Version;
}

std::vector<int64_t> ResolutionSelection(int64_t Width, int64_t Height, int64_t Sm, bool bFp16)
{
	TORCH_CHECK(Width > 0 && Width <= 2147483647 && Height > 0 && Height <= 2147483647 && Sm > 0 &&
					Sm <= 2147483647,
				"resolution policy expects positive bounded integers");
	const auto Selection = resolution_policy::Select(int(Width), int(Height), int(Sm),
													 bFp16 ? resolution_policy::EPrecision::Fp16
														   : resolution_policy::EPrecision::Fp8);
	return {Selection.ConfigId,
			int(Selection.StatusValue),
			Selection.QueryWidth,
			Selection.QueryHeight,
			Selection.bClamped,
			Selection.bActualResolutionMeasured,
			Selection.bActualShapeSupported,
			Selection.bRuntimeQualified,
			Selection.AnchorEvidence ? Selection.AnchorEvidence->Width : 0,
			Selection.AnchorEvidence ? Selection.AnchorEvidence->Height : 0};
}

c10::intrusive_ptr<FDeploymentPlan_fp8> CreatePlanForResolution_fp8(at::Tensor g_Input,
																	std::vector<at::Tensor> g_Records,
																	int64_t Width, int64_t Height)
{
	return c10::make_intrusive<FDeploymentPlan_fp8>(std::move(g_Input), std::move(g_Records), Width, Height);
}

c10::intrusive_ptr<FDeploymentPlan_fp8> CreatePlan_fp8(at::Tensor g_Input, std::vector<at::Tensor> g_Records)
{
	return c10::make_intrusive<FDeploymentPlan_fp8>(std::move(g_Input), std::move(g_Records));
}
} // namespace dlssnr::deployment
