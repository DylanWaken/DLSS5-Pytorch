#include "deployment.h"
#include "windows_dispatch.inl"
#include "c512_dispatch.inl"
#include "kernel_abi.h"
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
#include "plan_geometry_fp16_generated.inl"
#include "plan_fp16_generated.inl"

template <bool bFp16> struct FPlanData;

template <> struct FPlanData<false>
{
	static constexpr auto& RecordSpecs = fp8::RecordSpecs;
	static constexpr auto& BufferNameTable = fp8::BufferNameTable;

	static const FGeometryPlanSpec& SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return fp8::SelectGeometryPlan(Width, Height);
	}
};

template <> struct FPlanData<true>
{
	static constexpr auto& RecordSpecs = fp16::RecordSpecs;
	static constexpr auto& BufferNameTable = fp16::BufferNameTable;

	static const FGeometryPlanSpec& SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return fp16::SelectGeometryPlan(Width, Height);
	}
};

namespace
{
constexpr int64_t CONST_GUARD_BYTES = 256;
constexpr uint8_t CONST_GUARD_PATTERN = 0xA5;

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
	cudaStreamCaptureStatus CaptureStatus{};
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream, &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"create deployment plan outside CUDA graph capture");
}
} // namespace

template <bool bFp16> uint64_t FDeploymentPlan<bFp16>::GetBufferAddress(size_t g_BufferIndex) const
{
	return GetTensorAddress(g_Buffers.at(g_BufferIndex));
}

template <bool bFp16> uint64_t FDeploymentPlan<bFp16>::GetRecordAddress(size_t g_RecordIndex) const
{
	return GetTensorAddress(g_PackedWeightRecords.at(g_RecordIndex));
}

template <bool bFp16>
FDeploymentPlan<bFp16>::FDeploymentPlan(at::Tensor g_Input,
										std::vector<at::Tensor> g_InputPackedWeightRecords, int64_t Width,
										int64_t Height)
	: g_PackedWeightRecords(std::move(g_InputPackedWeightRecords)),
	  DeviceIndex(g_Input.is_cuda() ? g_Input.get_device() : -1)
{
	TORCH_CHECK(DeviceIndex >= 0, "deployment input must be CUDA physical storage");
	Geometry = &FPlanData<bFp16>::SelectGeometryPlan(Width, Height);
	c10::cuda::CUDAGuard DeviceGuard(g_Input.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	RequireOutsideCapture(Stream.stream());
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	TORCH_CHECK(DeviceProperties.major == 12 && DeviceProperties.minor == 0,
				"this reconstructed schedule is currently admitted only on SM120");
	const auto Selection = resolution_policy::Select(int(Width), int(Height), 120,
													 bFp16 ? resolution_policy::EPrecision::Fp16
														   : resolution_policy::EPrecision::Fp8);
	TORCH_CHECK(Selection.ConfigId == -1 || Selection.ConfigId == 0,
				"policy selects a configuration absent from this compiled reconstruction");
	ValidatePhysicalBuffer(g_Input, Geometry->BufferBytes[0], DeviceIndex,
						   bFp16 ? "FP16 trunk input" : "FP8 trunk input");
	TORCH_CHECK(g_PackedWeightRecords.size() == std::size(FPlanData<bFp16>::RecordSpecs), "expected ",
				std::size(FPlanData<bFp16>::RecordSpecs), " native packed records");
	std::vector<std::pair<uint64_t, uint64_t>> g_StorageRanges;
	g_StorageRanges.emplace_back(GetTensorAddress(g_Input), GetTensorAddress(g_Input) + g_Input.numel());
	for (size_t g_RecordIndex = 0; g_RecordIndex < g_PackedWeightRecords.size(); ++g_RecordIndex)
	{
		ValidatePhysicalBuffer(g_PackedWeightRecords[g_RecordIndex],
							   FPlanData<bFp16>::RecordSpecs[g_RecordIndex].Bytes, DeviceIndex,
							   FPlanData<bFp16>::RecordSpecs[g_RecordIndex].Name);
		const auto g_RecordAddress = GetTensorAddress(g_PackedWeightRecords[g_RecordIndex]);
		g_StorageRanges.emplace_back(g_RecordAddress,
									 g_RecordAddress + g_PackedWeightRecords[g_RecordIndex].numel());
		g_PackedWeightAddresses.push_back(g_RecordAddress);
	}
	std::sort(g_StorageRanges.begin(), g_StorageRanges.end());
	for (size_t g_StorageRangeIndex = 1; g_StorageRangeIndex < g_StorageRanges.size(); ++g_StorageRangeIndex)
		TORCH_CHECK(g_StorageRanges[g_StorageRangeIndex - 1].second <=
						g_StorageRanges[g_StorageRangeIndex].first,
					"input and packed record ranges must be disjoint");
	// Guard each workspace so replay validation detects writes outside its physical extent.
	g_Buffers.reserve(std::size(FPlanData<bFp16>::BufferNameTable));
	g_Buffers.push_back(std::move(g_Input));
	for (size_t g_BufferIndex = 1; g_BufferIndex < std::size(FPlanData<bFp16>::BufferNameTable);
		 ++g_BufferIndex)
	{
		auto g_Backing = at::full({Geometry->BufferBytes[g_BufferIndex] + 2 * CONST_GUARD_BYTES},
								  CONST_GUARD_PATTERN, g_Buffers[0].options());
		g_Buffers.push_back(g_Backing.narrow(0, CONST_GUARD_BYTES, Geometry->BufferBytes[g_BufferIndex]));
		g_GuardedBackings.push_back(std::move(g_Backing));
	}
	for (const auto& g_Tensor : g_Buffers)
		g_BufferAddresses.push_back(GetTensorAddress(g_Tensor));
	BuildCalls();
	TORCH_CHECK(Calls.size() == 185, "reconstructed trunk schedule census");
	// FP8 retains its all-resident admission. Native Half uses ordered Z waves;
	// admit one complete XY partition plane on the qualified SM120 scheduler.
	// This is an empirically validated native protocol, not a portable guarantee
	// of arbitrary CUDA block scheduling. Keep other architectures excluded.
	std::set<const void*> UniqueKernels;
	for (const auto& KernelCall : Calls)
	{
		cudaFuncAttributes FunctionAttributes{};
		C10_CUDA_CHECK(cudaFuncGetAttributes(&FunctionAttributes, KernelCall.Function));
		const auto ThreadsPerBlock = KernelCall.Block.x * KernelCall.Block.y * KernelCall.Block.z;
		TORCH_CHECK(FunctionAttributes.binaryVersion == 120 &&
						FunctionAttributes.maxThreadsPerBlock >= int(ThreadsPerBlock),
					"linked reconstructed kernel architecture or block size differs");
		for (int Axis = 0; Axis < 3; ++Axis)
		{
			const unsigned GridDimensions[] = {KernelCall.Grid.x, KernelCall.Grid.y, KernelCall.Grid.z};
			TORCH_CHECK(GridDimensions[Axis] > 0 &&
							GridDimensions[Axis] <= unsigned(DeviceProperties.maxGridSize[Axis]),
						"grid outside device limits");
		}
		int ActiveBlocksPerSm = 0;
		C10_CUDA_CHECK(cudaOccupancyMaxActiveBlocksPerMultiprocessor(&ActiveBlocksPerSm, KernelCall.Function,
																	 int(ThreadsPerBlock), 0));
		const int64_t ResidentBlocksRequired =
			int64_t(KernelCall.Grid.x) * KernelCall.Grid.y * (bFp16 ? 1 : KernelCall.Grid.z);
		TORCH_CHECK(!KernelCall.bAllResident ||
						int64_t(ActiveBlocksPerSm) * DeviceProperties.multiProcessorCount >=
							ResidentBlocksRequired,
					"ordered split reduction exceeds compiled resident capacity");
		if (UniqueKernels.insert(KernelCall.Function).second)
		{
			const int64_t ResourceRow[] = {FunctionAttributes.numRegs,
										   int64_t(FunctionAttributes.sharedSizeBytes),
										   int64_t(FunctionAttributes.localSizeBytes),
										   FunctionAttributes.maxThreadsPerBlock, ActiveBlocksPerSm};
			ResourceRows.insert(ResourceRows.end(), std::begin(ResourceRow), std::end(ResourceRow));
		}
	}
	TORCH_CHECK(UniqueKernels.size() == 37, "36 compute/repack entries plus counter clear expected");
}

template <bool bFp16> at::Tensor FDeploymentPlan<bFp16>::Run()
{
	std::lock_guard<std::mutex> Lock(LaunchMutex);
	c10::cuda::CUDAGuard DeviceGuard(g_Buffers[0].device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (size_t g_BufferIndex = 0; g_BufferIndex < g_Buffers.size(); ++g_BufferIndex)
	{
		ValidatePhysicalBuffer(g_Buffers[g_BufferIndex], Geometry->BufferBytes[g_BufferIndex], DeviceIndex,
							   FPlanData<bFp16>::BufferNameTable[g_BufferIndex]);
		TORCH_CHECK(GetTensorAddress(g_Buffers[g_BufferIndex]) == g_BufferAddresses[g_BufferIndex],
					"plan buffer storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(g_Buffers[g_BufferIndex].storage().data_ptr(), Stream);
	}
	for (size_t g_RecordIndex = 0; g_RecordIndex < g_PackedWeightRecords.size(); ++g_RecordIndex)
	{
		ValidatePhysicalBuffer(g_PackedWeightRecords[g_RecordIndex],
							   FPlanData<bFp16>::RecordSpecs[g_RecordIndex].Bytes, DeviceIndex,
							   FPlanData<bFp16>::RecordSpecs[g_RecordIndex].Name);
		TORCH_CHECK(GetTensorAddress(g_PackedWeightRecords[g_RecordIndex]) ==
						g_PackedWeightAddresses[g_RecordIndex],
					"plan record storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(
			g_PackedWeightRecords[g_RecordIndex].storage().data_ptr(), Stream);
	}
	// Parameters and storage are prepared once; capture records these same kernel launches.
	for (auto& KernelCall : Calls)
	{
		void* KernelArguments[] = {KernelCall.ParameterBlock.data()};
		C10_CUDA_CHECK(cudaLaunchKernel(KernelCall.Function, KernelCall.Grid, KernelCall.Block,
										KernelArguments, 0, Stream.stream()));
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return g_Buffers.back();
}

template <bool bFp16> std::vector<std::string> FDeploymentPlan<bFp16>::GetBufferNames() const
{
	std::vector<std::string> Names;
	for (const auto* Name : FPlanData<bFp16>::BufferNameTable)
		Names.emplace_back(Name);
	return Names;
}

template <bool bFp16> bool FDeploymentPlan<bFp16>::GuardsIntact() const
{
	c10::cuda::CUDAGuard DeviceGuard(g_Buffers[0].device());
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (const auto& g_Backing : g_GuardedBackings)
		if (!g_Backing.narrow(0, 0, CONST_GUARD_BYTES).eq(CONST_GUARD_PATTERN).all().item<bool>() ||
			!g_Backing.narrow(0, g_Backing.numel() - CONST_GUARD_BYTES, CONST_GUARD_BYTES)
				 .eq(CONST_GUARD_PATTERN)
				 .all()
				 .item<bool>())
			return false;
	return true;
}

template <bool bFp16> void FDeploymentPlan<bFp16>::Poison(int64_t PoisonByte)
{
	TORCH_CHECK(PoisonByte >= 0 && PoisonByte <= 255, "poison requires byte value");
	c10::cuda::CUDAGuard DeviceGuard(g_Buffers[0].device());
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (size_t g_BufferIndex = 1; g_BufferIndex < g_Buffers.size(); ++g_BufferIndex)
		g_Buffers[g_BufferIndex].fill_(PoisonByte);
}

template <bool bFp16> at::Tensor FDeploymentPlan<bFp16>::GetBuffer(const std::string& Name) const
{
	for (size_t g_BufferIndex = 0; g_BufferIndex < std::size(FPlanData<bFp16>::BufferNameTable);
		 ++g_BufferIndex)
		if (Name == FPlanData<bFp16>::BufferNameTable[g_BufferIndex])
			return g_Buffers[g_BufferIndex];
	TORCH_CHECK(false, "unknown deployment buffer: ", Name);
}

template <bool bFp16> std::vector<std::string> FDeploymentPlan<bFp16>::GetBoundaryNames() const
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

template <bool bFp16> std::vector<at::Tensor> FDeploymentPlan<bFp16>::GetBoundaries() const
{
	std::vector<at::Tensor> g_BoundaryOutputs;
	for (const auto& Name : GetBoundaryNames())
		g_BoundaryOutputs.push_back(GetBuffer(Name));
	return g_BoundaryOutputs;
}

std::vector<std::string> RecordNames_fp8()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : fp8::RecordSpecs)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_fp8()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : fp8::RecordSpecs)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
}

std::vector<std::string> RecordNames_fp16()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : fp16::RecordSpecs)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_fp16()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : fp16::RecordSpecs)
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

c10::intrusive_ptr<FDeploymentPlan_fp8>
CreatePlanForResolution_fp8(at::Tensor g_Input, std::vector<at::Tensor> g_PackedWeightRecords, int64_t Width,
							int64_t Height)
{
	return c10::make_intrusive<FDeploymentPlan_fp8>(std::move(g_Input), std::move(g_PackedWeightRecords),
													Width, Height);
}

c10::intrusive_ptr<FDeploymentPlan_fp8> CreatePlan_fp8(at::Tensor g_Input,
													   std::vector<at::Tensor> g_PackedWeightRecords)
{
	return c10::make_intrusive<FDeploymentPlan_fp8>(std::move(g_Input), std::move(g_PackedWeightRecords));
}

c10::intrusive_ptr<FDeploymentPlan_fp16>
CreatePlanForResolution_fp16(at::Tensor g_Input, std::vector<at::Tensor> g_PackedWeightRecords, int64_t Width,
							 int64_t Height)
{
	return c10::make_intrusive<FDeploymentPlan_fp16>(std::move(g_Input), std::move(g_PackedWeightRecords),
													 Width, Height);
}

c10::intrusive_ptr<FDeploymentPlan_fp16> CreatePlan_fp16(at::Tensor g_Input,
														 std::vector<at::Tensor> g_PackedWeightRecords)
{
	return c10::make_intrusive<FDeploymentPlan_fp16>(std::move(g_Input), std::move(g_PackedWeightRecords));
}
template class FDeploymentPlan<false>;
template class FDeploymentPlan<true>;
} // namespace dlssnr::deployment
