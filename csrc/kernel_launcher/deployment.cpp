#include "deployment.h"
#include "architecture_support.h"
#include "common/host/deployment_runtime.h"
#include "windows_dispatch.inl"
#include "c512_dispatch.inl"
#include <dlssnr/abi/kernel_parameters.h>
#include "compiled_resolution_policy.h"
#include "split_launch.h"
#include "split_launch_policy.h"
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <algorithm>
#include <map>
#include <set>

#include "plan_geometry_generated.inl"
#include "plan_generated.inl"
#include "plan_geometry_fp16_generated.inl"
#include "plan_fp16_generated.inl"

using namespace dlssnr::host;

template <bool bFp16> struct FPlanData;

template <> struct FPlanData<false>
{
	static constexpr auto& RecordSpecs = RecordSpecs_fp8;
	static constexpr auto& BufferNameTable = BufferNameTable_fp8;

	static FGeometryPlanSpec SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return SelectGeometryPlan_fp8(Width, Height);
	}
};

template <> struct FPlanData<true>
{
	static constexpr auto& RecordSpecs = RecordSpecs_fp16;
	static constexpr auto& BufferNameTable = BufferNameTable_fp16;

	static FGeometryPlanSpec SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return SelectGeometryPlan_fp16(Width, Height);
	}
};

constexpr int64_t CONST_GUARD_BYTES = 256;
constexpr uint8_t CONST_GUARD_PATTERN = 0xA5;

template <bool bFp16> uint64_t FDeploymentPlan<bFp16>::GetBufferAddress(size_t BufferIndex) const
{
	return TensorAddress(Buffers.at(BufferIndex));
}

template <bool bFp16> uint64_t FDeploymentPlan<bFp16>::GetRecordAddress(size_t RecordIndex) const
{
	return TensorAddress(PackedWeightRecords.at(RecordIndex));
}

template <bool bFp16>
FDeploymentPlan<bFp16>::FDeploymentPlan(at::Tensor Input, std::vector<at::Tensor> InputPackedWeightRecords,
										int64_t Width, int64_t Height)
	: PackedWeightRecords(std::move(InputPackedWeightRecords)),
	  DeviceIndex(Input.is_cuda() ? Input.get_device() : -1)
{
	TORCH_CHECK(DeviceIndex >= 0, "deployment input must be CUDA physical storage");
	Geometry = std::make_unique<FGeometryPlanSpec>(FPlanData<bFp16>::SelectGeometryPlan(Width, Height));
	c10::cuda::CUDAGuard DeviceGuard(Input.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	RequireOutsideCapture(Stream.stream(), "create deployment plan outside CUDA graph capture");
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	RequireDevicePrecision(DeviceProperties, bFp16, "deployment plan");
	const auto Selection =
		SelectResolutionPolicy(int(Width), int(Height), GetDeviceArchitecture(DeviceProperties),
							   bFp16 ? EResolutionPrecision::Fp16 : EResolutionPrecision::Fp8);
	TORCH_CHECK(Selection.ConfigId == -1 || Selection.ConfigId == 0,
				"policy selects a configuration absent from this compiled reconstruction");
	ValidatePlanPhysicalBuffer(Input, Geometry->BufferBytes[0], DeviceIndex,
							   bFp16 ? "FP16 trunk input" : "FP8 trunk input");
	TORCH_CHECK(PackedWeightRecords.size() == std::size(FPlanData<bFp16>::RecordSpecs), "expected ",
				std::size(FPlanData<bFp16>::RecordSpecs), " native packed records");
	std::vector<FPhysicalRange> StorageRanges;
	AppendTensorByteRange(StorageRanges, Input, "plan physical storage range overflow");
	for (size_t RecordIndex = 0; RecordIndex < PackedWeightRecords.size(); ++RecordIndex)
	{
		ValidatePlanPhysicalBuffer(PackedWeightRecords[RecordIndex],
								   FPlanData<bFp16>::RecordSpecs[RecordIndex].Bytes, DeviceIndex,
								   FPlanData<bFp16>::RecordSpecs[RecordIndex].Name);
		const auto g_RecordAddress = TensorAddress(PackedWeightRecords[RecordIndex]);
		AppendTensorByteRange(StorageRanges, PackedWeightRecords[RecordIndex],
							  "plan physical storage range overflow");
		PackedWeightAddresses.push_back(g_RecordAddress);
	}
	RequirePairwiseDisjoint(StorageRanges, "input and packed record ranges must be disjoint");
	// Guard each workspace so replay validation detects writes outside its physical extent.
	AllocateGuardedWorkspace(Buffers, GuardedBackings, std::move(Input), Geometry->BufferBytes,
							 std::size(FPlanData<bFp16>::BufferNameTable), CONST_GUARD_BYTES,
							 CONST_GUARD_PATTERN);
	for (const auto& Tensor : Buffers)
		BufferAddresses.push_back(TensorAddress(Tensor));
	BuildCalls();
	TORCH_CHECK(Calls.size() == 185, "reconstructed trunk schedule census");
	// Cache the choice before capture. If the complete dependent grid cannot fit,
	// stream-ordered Z launches let each independent XY plane run in any number
	// of waves, without relying on the scheduler to start predecessors first.
	const int EffectiveSmCount =
		EffectiveSplitSmCount(DeviceProperties.multiProcessorCount, ReadSplitSmCountLimit());
	AdmitPlanCalls(Calls, DeviceProperties, bFp16, EffectiveSmCount, ResourceRows, 37,
				   "36 compute/repack entries plus counter clear expected");
}

template <bool bFp16>
std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> FDeploymentPlan<bFp16>::PrepareKernels() const
{
	return PreparePlanKernels(Calls, DeviceIndex, Buffers, PackedWeightRecords);
}

template <bool bFp16> std::vector<at::Tensor> FDeploymentPlan<bFp16>::GetTensorArguments() const
{
	return PlanTensorArguments(Buffers, PackedWeightRecords);
}

template <bool bFp16> std::vector<std::vector<int64_t>> FDeploymentPlan<bFp16>::GetKernelTensorIndices() const
{
	return PlanKernelTensorIndices(Calls, Buffers.size());
}

// Output-view C32 is an individual export outside the prepared-feature trunk.
// Reuse the existing validated window geometry/ABI packer without launching it.
static c10::intrusive_ptr<FPreparedKernelHandle> PrepareOutputView(bool bFp16, at::Tensor Input,
																   at::Tensor PackedWeights,
																   at::Tensor Output, int64_t Height,
																   int64_t Width, int64_t Phase)
{
	const int EntryIndex =
		WindowEntryId(32, bFp16 ? EWindowPrecision::Fp16 : EWindowPrecision::Fp8, EWindowKind::Ordinary);
	WindowPrepareEntry(Input, EntryIndex);
	auto Entry = WindowGetEntrySpec(EntryIndex);
	Entry.KindValue = EWindowKind::OutputView;
	Entry.Stub = bFp16 ? reinterpret_cast<const void*>(&window_block_c32_output_view_fp16)
					   : reinterpret_cast<const void*>(&window_block_c32_output_view_fp8);
	c10::cuda::CUDAGuard DeviceGuard(Input.device());
	cudaDeviceProp Properties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&Properties, Input.get_device()));
	ValidateKernelDevice(Entry.Stub, Properties, bFp16, dim3(32), "C32 output-view");
	const auto Requirements = WindowGetBufferRequirements(EntryIndex, Height, Width, Phase);
	ValidateKernelGrid(dim3(Requirements.Grid[0], Requirements.Grid[1], Requirements.Grid[2]), Properties,
					   "C32 output-view");
	auto ParameterBlock = WindowBuildParameterBlock(Entry, Requirements, 0, 0, 0, 0, 0, int32_t(Height),
													int32_t(Width), int(Phase));
	const std::vector<FPhysicalTensorBinding> Bindings{{0, 0, false}, {16, 1, false}, {8, 0, true}};
	auto Descriptor = std::make_shared<FPhysicalKernelDescriptor>(
		bFp16 ? "window_block_c32_output_view_fp16" : "window_block_c32_output_view_fp8", Input.get_device(),
		Entry.Stub, dim3(Requirements.Grid[0], Requirements.Grid[1], Requirements.Grid[2]),
		dim3(Requirements.Block[0], Requirements.Block[1], Requirements.Block[2]), ParameterBlock, Bindings,
		std::vector<int64_t>{Requirements.InputBytes, Requirements.RecordBytes},
		std::vector<int64_t>{Requirements.OutputBytes});
	return RegisterPreparedKernel(std::move(Descriptor), {Input, PackedWeights}, {Output});
}

c10::intrusive_ptr<FPreparedKernelHandle> PrepareOutputView_fp8(at::Tensor Input, at::Tensor PackedWeights,
																at::Tensor Output, int64_t Height,
																int64_t Width, int64_t Phase)
{
	return PrepareOutputView(false, Input, PackedWeights, Output, Height, Width, Phase);
}

c10::intrusive_ptr<FPreparedKernelHandle> PrepareOutputView_fp16(at::Tensor Input, at::Tensor PackedWeights,
																 at::Tensor Output, int64_t Height,
																 int64_t Width, int64_t Phase)
{
	return PrepareOutputView(true, Input, PackedWeights, Output, Height, Width, Phase);
}

template <bool bFp16> at::Tensor FDeploymentPlan<bFp16>::Run()
{
	std::lock_guard<std::mutex> Lock(LaunchMutex);
	RunPlanCalls(Calls, Buffers, Geometry->BufferBytes, FPlanData<bFp16>::BufferNameTable, BufferAddresses,
				 PackedWeightRecords, FPlanData<bFp16>::RecordSpecs, PackedWeightAddresses, DeviceIndex,
				 "plan buffer storage was replaced", "plan record storage was replaced");
	// Parameters and storage are prepared once; capture records these same kernel launches.
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return Buffers.back();
}

template <bool bFp16> std::vector<int64_t> FDeploymentPlan<bFp16>::GetSplitLaunchCounts() const
{
	return PlanSplitLaunchCounts(Calls);
}

template <bool bFp16> std::vector<std::string> FDeploymentPlan<bFp16>::GetBufferNames() const
{
	return PlanBufferNames(FPlanData<bFp16>::BufferNameTable);
}

template <bool bFp16> bool FDeploymentPlan<bFp16>::GuardsIntact() const
{
	return PlanGuardsIntact(Buffers, GuardedBackings, DeviceIndex, CONST_GUARD_BYTES, CONST_GUARD_PATTERN,
							"create deployment plan outside CUDA graph capture");
}

template <bool bFp16> void FDeploymentPlan<bFp16>::Poison(int64_t PoisonByte)
{
	PoisonPlanWorkspaces(Buffers, DeviceIndex, PoisonByte,
						 "create deployment plan outside CUDA graph capture");
}

template <bool bFp16> at::Tensor FDeploymentPlan<bFp16>::GetBuffer(const std::string& Name) const
{
	return FindPlanBuffer(Buffers, FPlanData<bFp16>::BufferNameTable, Name, "unknown deployment buffer: ");
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
	return ResolveBoundaryBuffers(Buffers, FPlanData<bFp16>::BufferNameTable, GetBoundaryNames(),
								  "unknown deployment buffer: ");
}

std::vector<std::string> RecordNames_fp8()
{
	return PlanRecordNames(RecordSpecs_fp8);
}

std::vector<int64_t> RecordBytes_fp8()
{
	return PlanRecordBytes(RecordSpecs_fp8);
}

std::vector<std::string> RecordNames_fp16()
{
	return PlanRecordNames(RecordSpecs_fp16);
}

std::vector<int64_t> RecordBytes_fp16()
{
	return PlanRecordBytes(RecordSpecs_fp16);
}

std::string CompiledPolicyVersion()
{
	return CONST_RESOLUTION_POLICY_VERSION;
}

std::vector<int64_t> ResolutionSelection(int64_t Width, int64_t Height, int64_t Sm, bool bFp16)
{
	TORCH_CHECK(Width > 0 && Width <= 2147483647 && Height > 0 && Height <= 2147483647 && Sm > 0 &&
					Sm <= 2147483647,
				"resolution policy expects positive bounded integers");
	const auto Selection = SelectResolutionPolicy(
		int(Width), int(Height), int(Sm), bFp16 ? EResolutionPrecision::Fp16 : EResolutionPrecision::Fp8);
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
CreatePlanForResolution_fp8(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
							int64_t Height)
{
	return c10::make_intrusive<FDeploymentPlan_fp8>(std::move(Input), std::move(PackedWeightRecords), Width,
													Height);
}

c10::intrusive_ptr<FDeploymentPlan_fp8> CreatePlan_fp8(at::Tensor Input,
													   std::vector<at::Tensor> PackedWeightRecords)
{
	return c10::make_intrusive<FDeploymentPlan_fp8>(std::move(Input), std::move(PackedWeightRecords));
}

c10::intrusive_ptr<FDeploymentPlan_fp16>
CreatePlanForResolution_fp16(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
							 int64_t Height)
{
	return c10::make_intrusive<FDeploymentPlan_fp16>(std::move(Input), std::move(PackedWeightRecords), Width,
													 Height);
}

c10::intrusive_ptr<FDeploymentPlan_fp16> CreatePlan_fp16(at::Tensor Input,
														 std::vector<at::Tensor> PackedWeightRecords)
{
	return c10::make_intrusive<FDeploymentPlan_fp16>(std::move(Input), std::move(PackedWeightRecords));
}
template class FDeploymentPlan<false>;
template class FDeploymentPlan<true>;
