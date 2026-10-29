#include "small_deployment.h"
#include "architecture_support.h"
#include "kernel_impl/shared/common/kernel_abi.h"
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

constexpr int64_t SMALL_GUARD_BYTES = 256;
constexpr uint8_t SMALL_GUARD_PATTERN = 0xA5;

static uint64_t SmallDeploymentTensorAddress(const at::Tensor& Tensor)
{
	return reinterpret_cast<uint64_t>(Tensor.data_ptr());
}

static void ValidateSmallDeploymentPhysicalBuffer(const at::Tensor& Tensor, int64_t Bytes, int DeviceIndex,
												  const char* Role)
{
	TORCH_CHECK(Tensor.defined() && Tensor.is_cuda() && Tensor.get_device() == DeviceIndex &&
					Tensor.scalar_type() == at::kByte,
				Role, " must be raw uint8 on the plan's CUDA device");
	TORCH_CHECK(Tensor.dim() == 1 && Tensor.is_contiguous() && Tensor.numel() == Bytes, Role,
				" physical extent must be exactly ", Bytes, " bytes");
	TORCH_CHECK(SmallDeploymentTensorAddress(Tensor) % 16 == 0,
				"physical tensor must be 16-byte aligned: ", Role);
}

static void RequireSmallDeploymentOutsideCapture(cudaStream_t Stream)
{
	cudaStreamCaptureStatus CaptureStatus{};
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream, &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"create Small31 deployment plan outside CUDA graph capture");
}

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
	return SmallDeploymentTensorAddress(Buffers.at(BufferIndex));
}

template <bool bFp16> uint64_t FSmallDeploymentPlan<bFp16>::GetRecordAddress(size_t RecordIndex) const
{
	return SmallDeploymentTensorAddress(PackedWeightRecords.at(RecordIndex));
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
	RequireSmallDeploymentOutsideCapture(Stream.stream());
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	RequireDevicePrecision(DeviceProperties, bFp16, "Small31 deployment plan");
	ValidateSmallDeploymentPhysicalBuffer(Input, Geometry->BufferBytes[0], DeviceIndex,
										  bFp16 ? "Small31 FP16 trunk input" : "Small31 FP8 trunk input");
	TORCH_CHECK(PackedWeightRecords.size() == std::size(FSmallPlanData<bFp16>::RecordSpecs), "expected ",
				std::size(FSmallPlanData<bFp16>::RecordSpecs), " native Small31 packed records");
	TORCH_CHECK(Geometry->BufferBytes.size() == std::size(FSmallPlanData<bFp16>::BufferNameTable),
				"Small31 geometry and buffer-name tables disagree");
	std::vector<std::pair<uint64_t, uint64_t>> StorageRanges;
	StorageRanges.emplace_back(SmallDeploymentTensorAddress(Input),
							   SmallDeploymentTensorAddress(Input) + Input.numel());
	for (size_t RecordIndex = 0; RecordIndex < PackedWeightRecords.size(); ++RecordIndex)
	{
		ValidateSmallDeploymentPhysicalBuffer(PackedWeightRecords[RecordIndex],
											  FSmallPlanData<bFp16>::RecordSpecs[RecordIndex].Bytes,
											  DeviceIndex,
											  FSmallPlanData<bFp16>::RecordSpecs[RecordIndex].Name);
		const auto g_RecordAddress = SmallDeploymentTensorAddress(PackedWeightRecords[RecordIndex]);
		StorageRanges.emplace_back(g_RecordAddress,
								   g_RecordAddress + PackedWeightRecords[RecordIndex].numel());
		PackedWeightAddresses.push_back(g_RecordAddress);
	}
	std::sort(StorageRanges.begin(), StorageRanges.end());
	for (size_t StorageRangeIndex = 1; StorageRangeIndex < StorageRanges.size(); ++StorageRangeIndex)
		TORCH_CHECK(StorageRanges[StorageRangeIndex - 1].second <= StorageRanges[StorageRangeIndex].first,
					"input and packed record ranges must be disjoint");
	// Guard each workspace so replay validation detects writes outside its physical extent.
	Buffers.reserve(std::size(FSmallPlanData<bFp16>::BufferNameTable));
	Buffers.push_back(std::move(Input));
	for (size_t BufferIndex = 1; BufferIndex < std::size(FSmallPlanData<bFp16>::BufferNameTable);
		 ++BufferIndex)
	{
		auto Backing = at::full({Geometry->BufferBytes[BufferIndex] + 2 * SMALL_GUARD_BYTES},
								SMALL_GUARD_PATTERN, Buffers[0].options());
		Buffers.push_back(Backing.narrow(0, SMALL_GUARD_BYTES, Geometry->BufferBytes[BufferIndex]));
		GuardedBackings.push_back(std::move(Backing));
	}
	for (const auto& Tensor : Buffers)
		BufferAddresses.push_back(SmallDeploymentTensorAddress(Tensor));
	BuildCalls();
	TORCH_CHECK(Calls.size() == 109, "native Small31 schedule census");
	// Cache the choice before capture. If the complete dependent grid cannot fit,
	// stream-ordered Z launches let each independent XY plane run in any number
	// of waves, without relying on the scheduler to start predecessors first.
	const int EffectiveSmCount =
		EffectiveSplitSmCount(DeviceProperties.multiProcessorCount, ReadSplitSmCountLimit());
	std::set<const void*> UniqueKernels;
	for (auto& KernelCall : Calls)
	{
		const auto Admission = ValidateKernelDevice(KernelCall.Function, DeviceProperties, bFp16,
													KernelCall.Block, KernelCall.Name);
		const auto& FunctionAttributes = Admission.Attributes;
		const int ActiveBlocksPerSm = Admission.ActiveBlocksPerSm;
		ValidateKernelGrid(KernelCall.Grid, DeviceProperties, KernelCall.Name);
		const unsigned LaunchCount =
			SelectSplitLaunchCount(KernelCall.bAllResident, uint64_t(KernelCall.Grid.x) * KernelCall.Grid.y,
								   KernelCall.Grid.z, ActiveBlocksPerSm, EffectiveSmCount);
		if (LaunchCount > 1)
		{
			KernelCall.SplitParameterOffset = OrderedSplitParameterOffset(KernelCall.Name);
			TORCH_CHECK(KernelCall.SplitParameterOffset >= 0 &&
							KernelCall.SplitParameterOffset + int(sizeof(uint64_t)) <= KernelCall.AbiBytes,
						"ordered split control outside parameter block: ", KernelCall.Name);
		}
		if (UniqueKernels.insert(KernelCall.Function).second)
		{
			const int64_t ResourceRow[] = {FunctionAttributes.numRegs,
										   int64_t(FunctionAttributes.sharedSizeBytes),
										   int64_t(FunctionAttributes.localSizeBytes),
										   FunctionAttributes.maxThreadsPerBlock, ActiveBlocksPerSm};
			ResourceRows.insert(ResourceRows.end(), std::begin(ResourceRow), std::end(ResourceRow));
		}
	}
	TORCH_CHECK(UniqueKernels.size() == 34, "33 Small31 compute/repack entries plus counter clear expected");
}

template <bool bFp16>
std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> FSmallDeploymentPlan<bFp16>::PrepareKernels() const
{
	std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> Prepared;
	Prepared.reserve(Calls.size());
	for (const auto& Call : Calls)
	{
		std::vector<at::Tensor> Inputs, Outputs;
		std::vector<int64_t> InputBytes, OutputBytes;
		std::vector<FPhysicalTensorBinding> Bindings;
		auto ParameterBlock = Call.ParameterBlock;
		for (const auto& Binding : Call.Bindings)
		{
			const auto& Tensor = (Binding.bRecord ? PackedWeightRecords : Buffers).at(Binding.SourceIndex);
			auto& Tensors = Binding.bMutable ? Outputs : Inputs;
			auto& Extents = Binding.bMutable ? OutputBytes : InputBytes;
			Bindings.push_back({Binding.ParameterOffset, Tensors.size(), Binding.bMutable});
			Tensors.push_back(Tensor);
			Extents.push_back(Tensor.numel());
			// Descriptors must never retain hidden device addresses from the plan.
			std::memset(ParameterBlock.data() + Binding.ParameterOffset, 0, sizeof(uint64_t));
		}
		auto Descriptor = std::make_shared<FPhysicalKernelDescriptor>(
			Call.Name, DeviceIndex, Call.Function, Call.Grid, Call.Block, ParameterBlock, std::move(Bindings),
			std::move(InputBytes), std::move(OutputBytes), Call.SplitParameterOffset);
		Prepared.push_back(
			RegisterPreparedKernel(std::move(Descriptor), std::move(Inputs), std::move(Outputs)));
	}
	return Prepared;
}

template <bool bFp16> std::vector<at::Tensor> FSmallDeploymentPlan<bFp16>::GetTensorArguments() const
{
	auto Arguments = Buffers;
	Arguments.insert(Arguments.end(), PackedWeightRecords.begin(), PackedWeightRecords.end());
	return Arguments;
}

template <bool bFp16> std::vector<std::vector<int64_t>> FSmallDeploymentPlan<bFp16>::GetKernelTensorIndices() const
{
	std::vector<std::vector<int64_t>> Indices;
	for (const auto& Call : Calls)
	{
		std::vector<int64_t> Inputs, Outputs;
		for (const auto& Binding : Call.Bindings)
			(Binding.bMutable ? Outputs : Inputs)
				.push_back(int64_t(Binding.SourceIndex + (Binding.bRecord ? Buffers.size() : 0)));
		Indices.push_back(std::move(Inputs));
		Indices.push_back(std::move(Outputs));
	}
	return Indices;
}

template <bool bFp16> at::Tensor FSmallDeploymentPlan<bFp16>::Run()
{
	std::lock_guard<std::mutex> Lock(LaunchMutex);
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (size_t BufferIndex = 0; BufferIndex < Buffers.size(); ++BufferIndex)
	{
		ValidateSmallDeploymentPhysicalBuffer(Buffers[BufferIndex], Geometry->BufferBytes[BufferIndex],
											  DeviceIndex, FSmallPlanData<bFp16>::BufferNameTable[BufferIndex]);
		TORCH_CHECK(SmallDeploymentTensorAddress(Buffers[BufferIndex]) == BufferAddresses[BufferIndex],
					"Small31 plan buffer storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(Buffers[BufferIndex].storage().data_ptr(), Stream);
	}
	for (size_t RecordIndex = 0; RecordIndex < PackedWeightRecords.size(); ++RecordIndex)
	{
		ValidateSmallDeploymentPhysicalBuffer(PackedWeightRecords[RecordIndex],
											  FSmallPlanData<bFp16>::RecordSpecs[RecordIndex].Bytes,
											  DeviceIndex,
											  FSmallPlanData<bFp16>::RecordSpecs[RecordIndex].Name);
		TORCH_CHECK(SmallDeploymentTensorAddress(PackedWeightRecords[RecordIndex]) ==
						PackedWeightAddresses[RecordIndex],
					"Small31 plan record storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(PackedWeightRecords[RecordIndex].storage().data_ptr(),
													  Stream);
	}
	// Parameters and storage are prepared once; capture records these same kernel launches.
	for (auto& KernelCall : Calls)
	{
		LaunchPhysicalKernel(KernelCall.Function, KernelCall.Grid, KernelCall.Block,
							 KernelCall.ParameterBlock, KernelCall.SplitParameterOffset, Stream.stream());
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return Buffers.back();
}

template <bool bFp16> std::vector<int64_t> FSmallDeploymentPlan<bFp16>::GetSplitLaunchCounts() const
{
	std::vector<int64_t> Counts;
	Counts.reserve(Calls.size());
	for (const auto& Call : Calls)
		Counts.push_back(Call.SplitParameterOffset < 0 ? 1 : Call.Grid.z);
	return Counts;
}

template <bool bFp16> std::vector<std::string> FSmallDeploymentPlan<bFp16>::GetBufferNames() const
{
	std::vector<std::string> Names;
	for (const auto* Name : FSmallPlanData<bFp16>::BufferNameTable)
		Names.emplace_back(Name);
	return Names;
}

template <bool bFp16> bool FSmallDeploymentPlan<bFp16>::GuardsIntact() const
{
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	RequireSmallDeploymentOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (const auto& Backing : GuardedBackings)
		if (!Backing.narrow(0, 0, SMALL_GUARD_BYTES).eq(SMALL_GUARD_PATTERN).all().item<bool>() ||
			!Backing.narrow(0, Backing.numel() - SMALL_GUARD_BYTES, SMALL_GUARD_BYTES)
				 .eq(SMALL_GUARD_PATTERN)
				 .all()
				 .item<bool>())
			return false;
	return true;
}

template <bool bFp16> void FSmallDeploymentPlan<bFp16>::Poison(int64_t PoisonByte)
{
	TORCH_CHECK(PoisonByte >= 0 && PoisonByte <= 255, "poison requires byte value");
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	RequireSmallDeploymentOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (size_t BufferIndex = 1; BufferIndex < Buffers.size(); ++BufferIndex)
		Buffers[BufferIndex].fill_(PoisonByte);
}

template <bool bFp16> at::Tensor FSmallDeploymentPlan<bFp16>::GetBuffer(const std::string& Name) const
{
	for (size_t BufferIndex = 0; BufferIndex < std::size(FSmallPlanData<bFp16>::BufferNameTable);
		 ++BufferIndex)
		if (Name == FSmallPlanData<bFp16>::BufferNameTable[BufferIndex])
			return Buffers[BufferIndex];
	TORCH_CHECK(false, "unknown Small31 deployment buffer: ", Name);
}

template <bool bFp16> std::vector<std::string> FSmallDeploymentPlan<bFp16>::GetBoundaryNames() const
{
	std::vector<std::string> Names;
	for (const auto* Name : FSmallPlanData<bFp16>::BoundaryNames)
		Names.emplace_back(Name);
	return Names;
}

template <bool bFp16> std::vector<at::Tensor> FSmallDeploymentPlan<bFp16>::GetBoundaries() const
{
	std::vector<at::Tensor> BoundaryOutputs;
	for (const auto& Name : GetBoundaryNames())
		BoundaryOutputs.push_back(GetBuffer(Name));
	return BoundaryOutputs;
}

std::vector<std::string> RecordNames_small31_fp8()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : SmallRecordSpecs_fp8)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_small31_fp8()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : SmallRecordSpecs_fp8)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
}

std::vector<std::string> RecordNames_small31_fp16()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : SmallRecordSpecs_fp16)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_small31_fp16()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : SmallRecordSpecs_fp16)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
}

c10::intrusive_ptr<FSmallDeploymentPlan_fp8>
CreateSmallPlanForResolution_fp8(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
								 int64_t Height)
{
	return c10::make_intrusive<FSmallDeploymentPlan_fp8>(std::move(Input), std::move(PackedWeightRecords), Width,
														 Height);
}

c10::intrusive_ptr<FSmallDeploymentPlan_fp16>
CreateSmallPlanForResolution_fp16(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
								  int64_t Height)
{
	return c10::make_intrusive<FSmallDeploymentPlan_fp16>(std::move(Input), std::move(PackedWeightRecords),
														 Width, Height);
}

template class FSmallDeploymentPlan<false>;
template class FSmallDeploymentPlan<true>;
