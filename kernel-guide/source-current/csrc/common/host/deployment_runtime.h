#pragma once
// Static plan runtime shared by the legacy trunk and Small31 deployments.
//
// The two model tables stay separate data. These templates only remove the
// identical preparation, introspection, guard, buffer and replay plumbing. All
// helpers are compile-time parameterized over the existing call/table types, so
// there is no virtual dispatch, std::function or added allocation in Run().
#include "common/host/parameter_binding.h"
#include "common/host/physical_tensor.h"
#include "kernel_launcher/architecture_support.h"
#include "kernel_launcher/prepared_kernel.h"
#include "kernel_launcher/split_launch.h"
#include "kernel_launcher/split_launch_policy.h"
#include <c10/cuda/CUDACachingAllocator.h>
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDAStream.h>
#include <torch/library.h>
#include <cstdint>
#include <cstring>
#include <iterator>
#include <memory>
#include <set>
#include <string>
#include <utility>
#include <vector>

namespace dlssnr
{
namespace host
{

template <class TRecordSpecs> inline std::vector<std::string> PlanRecordNames(const TRecordSpecs& RecordSpecs)
{
	std::vector<std::string> Names;
	for (const auto& RecordSpec : RecordSpecs)
		Names.emplace_back(RecordSpec.Name);
	return Names;
}

template <class TRecordSpecs> inline std::vector<int64_t> PlanRecordBytes(const TRecordSpecs& RecordSpecs)
{
	std::vector<int64_t> RecordByteExtents;
	for (const auto& RecordSpec : RecordSpecs)
		RecordByteExtents.emplace_back(RecordSpec.Bytes);
	return RecordByteExtents;
}

// Guarded workspace buffers retain the caller's first (input) tensor and place
// one guard-sized pattern region on either side of every allocated workspace.
inline void AllocateGuardedWorkspace(std::vector<at::Tensor>& Buffers,
									 std::vector<at::Tensor>& GuardedBackings, at::Tensor Input,
									 const std::vector<int64_t>& BufferBytes, size_t BufferCount,
									 int64_t GuardBytes, uint8_t GuardPattern)
{
	Buffers.reserve(BufferCount);
	Buffers.push_back(std::move(Input));
	for (size_t BufferIndex = 1; BufferIndex < BufferCount; ++BufferIndex)
	{
		auto Backing =
			at::full({BufferBytes[BufferIndex] + 2 * GuardBytes}, GuardPattern, Buffers[0].options());
		Buffers.push_back(Backing.narrow(0, GuardBytes, BufferBytes[BufferIndex]));
		GuardedBackings.push_back(std::move(Backing));
	}
}

// Call-shaped concept: Function, Grid, Block, AbiBytes, bAllResident,
// ParameterBlock, Name and SplitParameterOffset. The generated call tables own
// the values; this function only performs the identical admission pass.
template <class TKernelCall>
inline void AdmitPlanCalls(std::vector<TKernelCall>& Calls, const cudaDeviceProp& DeviceProperties,
						   bool bFp16, int EffectiveSmCount, std::vector<int64_t>& ResourceRows,
						   size_t ExpectedUniqueKernels, const char* UniqueDiagnostic)
{
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

	TORCH_CHECK(UniqueKernels.size() == ExpectedUniqueKernels, UniqueDiagnostic);
}

// Build one prepared descriptor per logical call. Descriptor bindings never
// retain a hidden device address: every bound pointer field is cleared and the
// caller supplies the replacement tensors on invocation.
template <class TKernelCall>
inline std::vector<c10::intrusive_ptr<FPreparedKernelHandle>>
PreparePlanKernels(const std::vector<TKernelCall>& Calls, int DeviceIndex,
				   const std::vector<at::Tensor>& Buffers, const std::vector<at::Tensor>& Records)
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
			const auto& Tensor = (Binding.bRecord ? Records : Buffers).at(Binding.SourceIndex);
			auto& Tensors = Binding.bMutable ? Outputs : Inputs;
			auto& Extents = Binding.bMutable ? OutputBytes : InputBytes;
			Bindings.push_back({Binding.ParameterOffset, Tensors.size(), Binding.bMutable});
			Tensors.push_back(Tensor);
			Extents.push_back(Tensor.numel());
			ClearParameterField(ParameterBlock, Binding.ParameterOffset, sizeof(uint64_t),
								"prepared binding outside parameter block");
		}

		auto Descriptor = std::make_shared<FPhysicalKernelDescriptor>(
			Call.Name, DeviceIndex, Call.Function, Call.Grid, Call.Block, ParameterBlock, std::move(Bindings),
			std::move(InputBytes), std::move(OutputBytes), Call.SplitParameterOffset);
		Prepared.push_back(
			RegisterPreparedKernel(std::move(Descriptor), std::move(Inputs), std::move(Outputs)));
	}

	return Prepared;
}

inline std::vector<at::Tensor> PlanTensorArguments(const std::vector<at::Tensor>& Buffers,
												   const std::vector<at::Tensor>& Records)
{
	auto Arguments = Buffers;
	Arguments.insert(Arguments.end(), Records.begin(), Records.end());
	return Arguments;
}

template <class TKernelCall>
inline std::vector<std::vector<int64_t>> PlanKernelTensorIndices(const std::vector<TKernelCall>& Calls,
																 size_t BufferCount)
{
	std::vector<std::vector<int64_t>> Indices;
	for (const auto& Call : Calls)
	{
		std::vector<int64_t> Inputs, Outputs;
		for (const auto& Binding : Call.Bindings)
			(Binding.bMutable ? Outputs : Inputs)
				.push_back(int64_t(Binding.SourceIndex + (Binding.bRecord ? BufferCount : 0)));
		Indices.push_back(std::move(Inputs));
		Indices.push_back(std::move(Outputs));
	}

	return Indices;
}

template <class TKernelCall>
inline std::vector<int64_t> PlanSplitLaunchCounts(const std::vector<TKernelCall>& Calls)
{
	std::vector<int64_t> Counts;
	Counts.reserve(Calls.size());
	for (const auto& Call : Calls)
		Counts.push_back(Call.SplitParameterOffset < 0 ? 1 : Call.Grid.z);
	return Counts;
}

template <class TNameTable> inline std::vector<std::string> PlanBufferNames(const TNameTable& BufferNames)
{
	std::vector<std::string> Names;
	for (const auto* Name : BufferNames)
		Names.emplace_back(Name);
	return Names;
}

template <class TBoundaryNames>
inline std::vector<std::string> PlanBoundaryNames(const TBoundaryNames& BoundaryNames)
{
	std::vector<std::string> Names;
	for (const auto* Name : BoundaryNames)
		Names.emplace_back(Name);
	return Names;
}

template <class TNameTable>
inline size_t FindPlanBufferIndex(const TNameTable& BufferNames, const std::string& Name,
								  const char* UnknownDiagnostic)
{
	for (size_t BufferIndex = 0; BufferIndex < std::size(BufferNames); ++BufferIndex)
		if (Name == BufferNames[BufferIndex])
			return BufferIndex;
	TORCH_CHECK(false, UnknownDiagnostic, Name);
}

template <class TNameTable>
inline at::Tensor FindPlanBuffer(const std::vector<at::Tensor>& Buffers, const TNameTable& BufferNames,
								 const std::string& Name, const char* UnknownDiagnostic)
{
	return Buffers[FindPlanBufferIndex(BufferNames, Name, UnknownDiagnostic)];
}

template <class TNameTable>
inline std::vector<at::Tensor>
ResolveBoundaryBuffers(const std::vector<at::Tensor>& Buffers, const TNameTable& BufferNames,
					   const std::vector<std::string>& BoundaryNames, const char* UnknownDiagnostic)
{
	std::vector<at::Tensor> BoundaryOutputs;
	BoundaryOutputs.reserve(BoundaryNames.size());
	for (const auto& Name : BoundaryNames)
		BoundaryOutputs.push_back(FindPlanBuffer(Buffers, BufferNames, Name, UnknownDiagnostic));
	return BoundaryOutputs;
}

inline bool PlanGuardsIntact(const std::vector<at::Tensor>& Buffers,
							 const std::vector<at::Tensor>& GuardedBackings, int DeviceIndex,
							 int64_t GuardBytes, uint8_t GuardPattern, const char* CaptureDiagnostic)
{
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream(), CaptureDiagnostic);
	for (const auto& Backing : GuardedBackings)
		if (!Backing.narrow(0, 0, GuardBytes).eq(GuardPattern).all().item<bool>() ||
			!Backing.narrow(0, Backing.numel() - GuardBytes, GuardBytes).eq(GuardPattern).all().item<bool>())
			return false;
	return true;
}

inline void PoisonPlanWorkspaces(std::vector<at::Tensor>& Buffers, int DeviceIndex, int64_t PoisonByte,
								 const char* CaptureDiagnostic)
{
	TORCH_CHECK(PoisonByte >= 0 && PoisonByte <= 255, "poison requires byte value");
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(DeviceIndex).stream(), CaptureDiagnostic);
	for (size_t BufferIndex = 1; BufferIndex < Buffers.size(); ++BufferIndex)
		Buffers[BufferIndex].fill_(PoisonByte);
}

// Revalidate the cached physical storage, record the caller stream on every
// tensor, then replay the cached launches in generated order. The lock and the
// launch check remain with the owning plan class.
template <class TKernelCall, class TBufferNames, class TRecordSpecs>
inline void RunPlanCalls(const std::vector<TKernelCall>& Calls, const std::vector<at::Tensor>& Buffers,
						 const std::vector<int64_t>& BufferBytes, const TBufferNames& BufferNames,
						 const std::vector<uint64_t>& BufferAddresses, const std::vector<at::Tensor>& Records,
						 const TRecordSpecs& RecordSpecs, const std::vector<uint64_t>& RecordAddresses,
						 int DeviceIndex, const char* BufferReplacedDiagnostic,
						 const char* RecordReplacedDiagnostic)
{
	c10::cuda::CUDAGuard DeviceGuard(Buffers[0].device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (size_t BufferIndex = 0; BufferIndex < Buffers.size(); ++BufferIndex)
	{
		ValidatePlanPhysicalBuffer(Buffers[BufferIndex], BufferBytes[BufferIndex], DeviceIndex,
								   BufferNames[BufferIndex]);
		TORCH_CHECK(TensorAddress(Buffers[BufferIndex]) == BufferAddresses[BufferIndex],
					BufferReplacedDiagnostic);
		c10::cuda::CUDACachingAllocator::recordStream(Buffers[BufferIndex].storage().data_ptr(), Stream);
	}

	for (size_t RecordIndex = 0; RecordIndex < Records.size(); ++RecordIndex)
	{
		ValidatePlanPhysicalBuffer(Records[RecordIndex], RecordSpecs[RecordIndex].Bytes, DeviceIndex,
								   RecordSpecs[RecordIndex].Name);
		TORCH_CHECK(TensorAddress(Records[RecordIndex]) == RecordAddresses[RecordIndex],
					RecordReplacedDiagnostic);
		c10::cuda::CUDACachingAllocator::recordStream(Records[RecordIndex].storage().data_ptr(), Stream);
	}

	for (const auto& KernelCall : Calls)
		LaunchPhysicalKernel(KernelCall.Function, KernelCall.Grid, KernelCall.Block,
							 KernelCall.ParameterBlock, KernelCall.SplitParameterOffset, Stream.stream());
}

// Both deployment classes expose the same member surface; only the public
// class name, run alias and owning type differ.
template <class TPlan>
inline void RegisterDeploymentPlanClass(torch::Library& Library, const char* ClassName, const char* RunName,
										at::Tensor (TPlan::*RunMethod)())
{
	Library.class_<TPlan>(ClassName)
		.def(RunName, static_cast<at::Tensor (TPlan::*)()>(RunMethod))
		.def("buffer", &TPlan::GetBuffer)
		.def("buffer_names", &TPlan::GetBufferNames)
		.def("boundaries", &TPlan::GetBoundaries)
		.def("boundary_names", &TPlan::GetBoundaryNames)
		.def("guards_intact", &TPlan::GuardsIntact)
		.def("poison", &TPlan::Poison)
		.def("resources", &TPlan::GetResources)
		.def("split_launch_counts", &TPlan::GetSplitLaunchCounts)
		.def("prepare_kernels", &TPlan::PrepareKernels)
		.def("tensor_arguments", &TPlan::GetTensorArguments)
		.def("kernel_tensor_indices", &TPlan::GetKernelTensorIndices);
}

} // namespace host
} // namespace dlssnr
