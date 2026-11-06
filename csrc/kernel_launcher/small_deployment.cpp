#include "small_deployment.h"
#include "architecture_support.h"
#include "common/host/deployment_runtime.h"
// Small31-only safe attention exports; they reuse the unchanged canonical
// FGlobalAttentionChainedC1024Fp16/Fp8Parameters ABI structs.
#include <dlssnr/abi/small_attention.h>
#include "split_launch.h"
#include "split_launch_policy.h"
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <algorithm>
#include <iterator>
#include <set>
#include <utility>

// The Small31 generator emits its own tables and member specializations. The
// legacy plan_generated.inl files are deliberately never included here.
#include "small_plan_geometry_generated.inl"
#include "small_plan_generated.inl"
#include "small_plan_geometry_fp16_generated.inl"
#include "small_plan_fp16_generated.inl"

using namespace dlssnr::host;

constexpr int64_t SMALL_GUARD_BYTES = 256;
constexpr uint8_t SMALL_GUARD_PATTERN = 0xA5;

template <bool bFp16> struct FSmallPlanData;

template <> struct FSmallPlanData<false>
{
	static constexpr auto& RecordSpecs = SmallRecordSpecs_fp8;
	static constexpr auto& BufferNameTable = SmallBufferNameTable_fp8;
	static constexpr auto& BoundaryNames = SmallBoundaryNames_fp8;

	static FGeometryPlanSpec SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return SelectSmallGeometryPlan_fp8(Width, Height);
	}
};

template <> struct FSmallPlanData<true>
{
	static constexpr auto& RecordSpecs = SmallRecordSpecs_fp16;
	static constexpr auto& BufferNameTable = SmallBufferNameTable_fp16;
	static constexpr auto& BoundaryNames = SmallBoundaryNames_fp16;

	static FGeometryPlanSpec SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return SelectSmallGeometryPlan_fp16(Width, Height);
	}
};

template <bool bFp16> uint64_t FSmallDeploymentPlan<bFp16>::GetBufferAddress(size_t BufferIndex) const
{
	return TensorAddress(Buffers.at(BufferIndex));
}

template <bool bFp16> uint64_t FSmallDeploymentPlan<bFp16>::GetRecordAddress(size_t RecordIndex) const
{
	return TensorAddress(PackedWeightRecords.at(RecordIndex));
}

template <bool bFp16>
FSmallDeploymentPlan<bFp16>::FSmallDeploymentPlan(at::Tensor Input,
												  std::vector<at::Tensor> InputPackedWeightRecords,
												  int64_t Width, int64_t Height)
	: PackedWeightRecords(std::move(InputPackedWeightRecords)),
	  DeviceIndex(Input.is_cuda() ? Input.get_device() : -1)
{
	TORCH_CHECK(DeviceIndex >= 0, "Small31 deployment input must be CUDA physical storage");
	Geometry = std::make_unique<FGeometryPlanSpec>(FSmallPlanData<bFp16>::SelectGeometryPlan(Width, Height));
	c10::cuda::CUDAGuard DeviceGuard(Input.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	RequireOutsideCapture(Stream.stream(), "create Small31 deployment plan outside CUDA graph capture");
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	RequireDevicePrecision(DeviceProperties, bFp16, "Small31 deployment plan");
	ValidatePlanPhysicalBuffer(Input, Geometry->BufferBytes[0], DeviceIndex,
							   bFp16 ? "Small31 FP16 trunk input" : "Small31 FP8 trunk input");
	TORCH_CHECK(PackedWeightRecords.size() == std::size(FSmallPlanData<bFp16>::RecordSpecs), "expected ",
				std::size(FSmallPlanData<bFp16>::RecordSpecs), " native Small31 packed records");
	TORCH_CHECK(Geometry->BufferBytes.size() == std::size(FSmallPlanData<bFp16>::BufferNameTable),
				"Small31 geometry and buffer-name tables disagree");
	std::vector<FPhysicalRange> StorageRanges;
	AppendTensorByteRange(StorageRanges, Input, "plan physical storage range overflow");
	for (size_t RecordIndex = 0; RecordIndex < PackedWeightRecords.size(); ++RecordIndex)
	{
		ValidatePlanPhysicalBuffer(PackedWeightRecords[RecordIndex],
								   FSmallPlanData<bFp16>::RecordSpecs[RecordIndex].Bytes, DeviceIndex,
								   FSmallPlanData<bFp16>::RecordSpecs[RecordIndex].Name);
		const auto g_RecordAddress = TensorAddress(PackedWeightRecords[RecordIndex]);
		AppendTensorByteRange(StorageRanges, PackedWeightRecords[RecordIndex],
							  "plan physical storage range overflow");
		PackedWeightAddresses.push_back(g_RecordAddress);
	}
	RequirePairwiseDisjoint(StorageRanges, "input and packed record ranges must be disjoint");
	// Guard each workspace so replay validation detects writes outside its physical extent.
	AllocateGuardedWorkspace(Buffers, GuardedBackings, std::move(Input), Geometry->BufferBytes,
							 std::size(FSmallPlanData<bFp16>::BufferNameTable), SMALL_GUARD_BYTES,
							 SMALL_GUARD_PATTERN);
	for (const auto& Tensor : Buffers)
		BufferAddresses.push_back(TensorAddress(Tensor));
	BuildCalls();
	TORCH_CHECK(Calls.size() == 109, "native Small31 schedule census");
	// Cache the choice before capture. If the complete dependent grid cannot fit,
	// stream-ordered Z launches let each independent XY plane run in any number
	// of waves, without relying on the scheduler to start predecessors first.
	const int EffectiveSmCount =
		EffectiveSplitSmCount(DeviceProperties.multiProcessorCount, ReadSplitSmCountLimit());
	AdmitPlanCalls(Calls, DeviceProperties, bFp16, EffectiveSmCount, ResourceRows, 34,
				   "33 Small31 compute/repack entries plus counter clear expected");
}

template <bool bFp16>
std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> FSmallDeploymentPlan<bFp16>::PrepareKernels() const
{
	return PreparePlanKernels(Calls, DeviceIndex, Buffers, PackedWeightRecords);
}

template <bool bFp16> std::vector<at::Tensor> FSmallDeploymentPlan<bFp16>::GetTensorArguments() const
{
	return PlanTensorArguments(Buffers, PackedWeightRecords);
}

template <bool bFp16>
std::vector<std::vector<int64_t>> FSmallDeploymentPlan<bFp16>::GetKernelTensorIndices() const
{
	return PlanKernelTensorIndices(Calls, Buffers.size());
}

template <bool bFp16> at::Tensor FSmallDeploymentPlan<bFp16>::Run()
{
	std::lock_guard<std::mutex> Lock(LaunchMutex);
	RunPlanCalls(Calls, Buffers, Geometry->BufferBytes, FSmallPlanData<bFp16>::BufferNameTable,
				 BufferAddresses, PackedWeightRecords, FSmallPlanData<bFp16>::RecordSpecs,
				 PackedWeightAddresses, DeviceIndex, "Small31 plan buffer storage was replaced",
				 "Small31 plan record storage was replaced");
	// Parameters and storage are prepared once; capture records these same kernel launches.
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return Buffers.back();
}

template <bool bFp16> std::vector<int64_t> FSmallDeploymentPlan<bFp16>::GetSplitLaunchCounts() const
{
	return PlanSplitLaunchCounts(Calls);
}

template <bool bFp16> std::vector<std::string> FSmallDeploymentPlan<bFp16>::GetBufferNames() const
{
	return PlanBufferNames(FSmallPlanData<bFp16>::BufferNameTable);
}

template <bool bFp16> bool FSmallDeploymentPlan<bFp16>::GuardsIntact() const
{
	return PlanGuardsIntact(Buffers, GuardedBackings, DeviceIndex, SMALL_GUARD_BYTES, SMALL_GUARD_PATTERN,
							"create Small31 deployment plan outside CUDA graph capture");
}

template <bool bFp16> void FSmallDeploymentPlan<bFp16>::Poison(int64_t PoisonByte)
{
	PoisonPlanWorkspaces(Buffers, DeviceIndex, PoisonByte,
						 "create Small31 deployment plan outside CUDA graph capture");
}

template <bool bFp16> at::Tensor FSmallDeploymentPlan<bFp16>::GetBuffer(const std::string& Name) const
{
	return FindPlanBuffer(Buffers, FSmallPlanData<bFp16>::BufferNameTable, Name,
						  "unknown Small31 deployment buffer: ");
}

template <bool bFp16> std::vector<std::string> FSmallDeploymentPlan<bFp16>::GetBoundaryNames() const
{
	return PlanBoundaryNames(FSmallPlanData<bFp16>::BoundaryNames);
}

template <bool bFp16> std::vector<at::Tensor> FSmallDeploymentPlan<bFp16>::GetBoundaries() const
{
	return ResolveBoundaryBuffers(Buffers, FSmallPlanData<bFp16>::BufferNameTable, GetBoundaryNames(),
								  "unknown Small31 deployment buffer: ");
}

std::vector<std::string> RecordNames_small31_fp8()
{
	return PlanRecordNames(SmallRecordSpecs_fp8);
}

std::vector<int64_t> RecordBytes_small31_fp8()
{
	return PlanRecordBytes(SmallRecordSpecs_fp8);
}

std::vector<std::string> RecordNames_small31_fp16()
{
	return PlanRecordNames(SmallRecordSpecs_fp16);
}

std::vector<int64_t> RecordBytes_small31_fp16()
{
	return PlanRecordBytes(SmallRecordSpecs_fp16);
}

c10::intrusive_ptr<FSmallDeploymentPlan_fp8>
CreateSmallPlanForResolution_fp8(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
								 int64_t Height)
{
	return c10::make_intrusive<FSmallDeploymentPlan_fp8>(std::move(Input), std::move(PackedWeightRecords),
														 Width, Height);
}

c10::intrusive_ptr<FSmallDeploymentPlan_fp16>
CreateSmallPlanForResolution_fp16(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords,
								  int64_t Width, int64_t Height)
{
	return c10::make_intrusive<FSmallDeploymentPlan_fp16>(std::move(Input), std::move(PackedWeightRecords),
														  Width, Height);
}

template class FSmallDeploymentPlan<false>;
template class FSmallDeploymentPlan<true>;
