#include "deployment.h"
#include "windows_dispatch.inl"
#include "c512_dispatch.inl"
#include "kernel_impl/kernel_abi.h"
#include "compiled_resolution_policy.h"
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

template <bool bFp16> struct FPlanData;

template <> struct FPlanData<false>
{
	static constexpr auto& RecordSpecs = RecordSpecs_fp8;
	static constexpr auto& BufferNameTable = BufferNameTable_fp8;

	static const FGeometryPlanSpec& SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return SelectGeometryPlan_fp8(Width, Height);
	}
};

template <> struct FPlanData<true>
{
	static constexpr auto& RecordSpecs = RecordSpecs_fp16;
	static constexpr auto& BufferNameTable = BufferNameTable_fp16;

	static const FGeometryPlanSpec& SelectGeometryPlan(int64_t Width, int64_t Height)
	{
		return SelectGeometryPlan_fp16(Width, Height);
	}
};

constexpr int64_t CONST_GUARD_BYTES = 256;
constexpr uint8_t CONST_GUARD_PATTERN = 0xA5;

static uint64_t GetDeploymentTensorAddress(const at::Tensor& Tensor)
{
	return reinterpret_cast<uint64_t>(Tensor.data_ptr());
}

static void ValidateDeploymentPhysicalBuffer(const at::Tensor& Tensor, int64_t Bytes, int DeviceIndex,
											 const char* Role)
{
	TORCH_CHECK(Tensor.defined() && Tensor.is_cuda() && Tensor.get_device() == DeviceIndex &&
					Tensor.scalar_type() == at::kByte,
				Role, " must be raw uint8 on the plan's CUDA device");
	TORCH_CHECK(Tensor.dim() == 1 && Tensor.is_contiguous() && Tensor.numel() == Bytes, Role,
				" physical extent must be exactly ", Bytes, " bytes");
	TORCH_CHECK(GetDeploymentTensorAddress(Tensor) % 16 == 0,
				"physical tensor must be 16-byte aligned: ", Role);
}

static void RequireDeploymentOutsideCapture(cudaStream_t Stream)
{
	cudaStreamCaptureStatus CaptureStatus{};
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream, &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"create deployment plan outside CUDA graph capture");
}

template <bool bFp16> uint64_t FDeploymentPlan<bFp16>::GetBufferAddress(size_t BufferIndex) const
{
	return GetDeploymentTensorAddress(Buffers.at(BufferIndex));
}

template <bool bFp16> uint64_t FDeploymentPlan<bFp16>::GetRecordAddress(size_t RecordIndex) const
{
	return GetDeploymentTensorAddress(PackedWeightRecords.at(RecordIndex));
}

template <bool bFp16>
FDeploymentPlan<bFp16>::FDeploymentPlan(at::Tensor Input, std::vector<at::Tensor> InputPackedWeightRecords,
										int64_t Width, int64_t Height)
	: PackedWeightRecords(std::move(InputPackedWeightRecords)),
	  DeviceIndex(Input.is_cuda() ? Input.get_device() : -1)
{
	TORCH_CHECK(DeviceIndex >= 0, "deployment input must be CUDA physical storage");
	Geometry = &FPlanData<bFp16>::SelectGeometryPlan(Width, Height);
	c10::cuda::CUDAGuard DeviceGuard(Input.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	RequireDeploymentOutsideCapture(Stream.stream());
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	TORCH_CHECK(DeviceProperties.major == 12 && DeviceProperties.minor == 0,
				"this reconstructed schedule is currently admitted only on SM120");
	const auto Selection = SelectResolutionPolicy(
		int(Width), int(Height), 120, bFp16 ? EResolutionPrecision::Fp16 : EResolutionPrecision::Fp8);
	TORCH_CHECK(Selection.ConfigId == -1 || Selection.ConfigId == 0,
				"policy selects a configuration absent from this compiled reconstruction");
	ValidateDeploymentPhysicalBuffer(Input, Geometry->BufferBytes[0], DeviceIndex,
									 bFp16 ? "FP16 trunk input" : "FP8 trunk input");
	TORCH_CHECK(PackedWeightRecords.size() == std::size(FPlanData<bFp16>::RecordSpecs), "expected ",
				std::size(FPlanData<bFp16>::RecordSpecs), " native packed records");
	std::vector<std::pair<uint64_t, uint64_t>> StorageRanges;
	StorageRanges.emplace_back(GetDeploymentTensorAddress(Input),
							   GetDeploymentTensorAddress(Input) + Input.numel());
	for (size_t RecordIndex = 0; RecordIndex < PackedWeightRecords.size(); ++RecordIndex)
	{
		ValidateDeploymentPhysicalBuffer(PackedWeightRecords[RecordIndex],
										 FPlanData<bFp16>::RecordSpecs[RecordIndex].Bytes, DeviceIndex,
										 FPlanData<bFp16>::RecordSpecs[RecordIndex].Name);
		const auto g_RecordAddress = GetDeploymentTensorAddress(PackedWeightRecords[RecordIndex]);
		StorageRanges.emplace_back(g_RecordAddress,
								   g_RecordAddress + PackedWeightRecords[RecordIndex].numel());
		PackedWeightAddresses.push_back(g_RecordAddress);
	}
	std::sort(StorageRanges.begin(), StorageRanges.end());
	for (size_t StorageRangeIndex = 1; StorageRangeIndex < StorageRanges.size(); ++StorageRangeIndex)
		TORCH_CHECK(StorageRanges[StorageRangeIndex - 1].second <= StorageRanges[StorageRangeIndex].first,
					"input and packed record ranges must be disjoint");
	// Guard each workspace so replay validation detects writes outside its physical extent.
	Buffers.reserve(std::size(FPlanData<bFp16>::BufferNameTable));
	Buffers.push_back(std::move(Input));
	for (size_t BufferIndex = 1; BufferIndex < std::size(FPlanData<bFp16>::BufferNameTable); ++BufferIndex)
	{
		auto Backing = at::full({Geometry->BufferBytes[BufferIndex] + 2 * CONST_GUARD_BYTES},
								CONST_GUARD_PATTERN, Buffers[0].options());
		Buffers.push_back(Backing.narrow(0, CONST_GUARD_BYTES, Geometry->BufferBytes[BufferIndex]));
		GuardedBackings.push_back(std::move(Backing));
	}
	for (const auto& Tensor : Buffers)
		BufferAddresses.push_back(GetDeploymentTensorAddress(Tensor));
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

template <bool bFp16>
std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> FDeploymentPlan<bFp16>::PrepareKernels() const
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
			std::move(InputBytes), std::move(OutputBytes));
		Prepared.push_back(
			RegisterPreparedKernel(std::move(Descriptor), std::move(Inputs), std::move(Outputs)));
	}
	return Prepared;
}

template <bool bFp16> std::vector<at::Tensor> FDeploymentPlan<bFp16>::GetTensorArguments() const
{
	auto Arguments = Buffers;
	Arguments.insert(Arguments.end(), PackedWeightRecords.begin(), PackedWeightRecords.end());
	return Arguments;
}

template <bool bFp16> std::vector<std::vector<int64_t>> FDeploymentPlan<bFp16>::GetKernelTensorIndices() const
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
	cudaFuncAttributes Attributes{};
	C10_CUDA_CHECK(cudaFuncGetAttributes(&Attributes, Entry.Stub));
	TORCH_CHECK(Attributes.binaryVersion == 120 && Attributes.maxThreadsPerBlock >= 32,
				"C32 output-view entry requires the admitted SM120 block");
	const auto Requirements = WindowGetBufferRequirements(EntryIndex, Height, Width, Phase);
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
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (size_t BufferIndex = 0; BufferIndex < Buffers.size(); ++BufferIndex)
	{
		ValidateDeploymentPhysicalBuffer(Buffers[BufferIndex], Geometry->BufferBytes[BufferIndex],
										 DeviceIndex, FPlanData<bFp16>::BufferNameTable[BufferIndex]);
		TORCH_CHECK(GetDeploymentTensorAddress(Buffers[BufferIndex]) == BufferAddresses[BufferIndex],
					"plan buffer storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(Buffers[BufferIndex].storage().data_ptr(), Stream);
	}
	for (size_t RecordIndex = 0; RecordIndex < PackedWeightRecords.size(); ++RecordIndex)
	{
		ValidateDeploymentPhysicalBuffer(PackedWeightRecords[RecordIndex],
										 FPlanData<bFp16>::RecordSpecs[RecordIndex].Bytes, DeviceIndex,
										 FPlanData<bFp16>::RecordSpecs[RecordIndex].Name);
		TORCH_CHECK(GetDeploymentTensorAddress(PackedWeightRecords[RecordIndex]) ==
						PackedWeightAddresses[RecordIndex],
					"plan record storage was replaced");
		c10::cuda::CUDACachingAllocator::recordStream(PackedWeightRecords[RecordIndex].storage().data_ptr(),
													  Stream);
	}
	// Parameters and storage are prepared once; capture records these same kernel launches.
	for (auto& KernelCall : Calls)
	{
		void* KernelArguments[] = {KernelCall.ParameterBlock.data()};
		C10_CUDA_CHECK(cudaLaunchKernel(KernelCall.Function, KernelCall.Grid, KernelCall.Block,
										KernelArguments, 0, Stream.stream()));
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return Buffers.back();
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
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	RequireDeploymentOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (const auto& Backing : GuardedBackings)
		if (!Backing.narrow(0, 0, CONST_GUARD_BYTES).eq(CONST_GUARD_PATTERN).all().item<bool>() ||
			!Backing.narrow(0, Backing.numel() - CONST_GUARD_BYTES, CONST_GUARD_BYTES)
				 .eq(CONST_GUARD_PATTERN)
				 .all()
				 .item<bool>())
			return false;
	return true;
}

template <bool bFp16> void FDeploymentPlan<bFp16>::Poison(int64_t PoisonByte)
{
	TORCH_CHECK(PoisonByte >= 0 && PoisonByte <= 255, "poison requires byte value");
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	RequireDeploymentOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream());
	for (size_t BufferIndex = 1; BufferIndex < Buffers.size(); ++BufferIndex)
		Buffers[BufferIndex].fill_(PoisonByte);
}

template <bool bFp16> at::Tensor FDeploymentPlan<bFp16>::GetBuffer(const std::string& Name) const
{
	for (size_t BufferIndex = 0; BufferIndex < std::size(FPlanData<bFp16>::BufferNameTable); ++BufferIndex)
		if (Name == FPlanData<bFp16>::BufferNameTable[BufferIndex])
			return Buffers[BufferIndex];
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
	std::vector<at::Tensor> BoundaryOutputs;
	for (const auto& Name : GetBoundaryNames())
		BoundaryOutputs.push_back(GetBuffer(Name));
	return BoundaryOutputs;
}

std::vector<std::string> RecordNames_fp8()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : RecordSpecs_fp8)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_fp8()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : RecordSpecs_fp8)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
}

std::vector<std::string> RecordNames_fp16()
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : RecordSpecs_fp16)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

std::vector<int64_t> RecordBytes_fp16()
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : RecordSpecs_fp16)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
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
