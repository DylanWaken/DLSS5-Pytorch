#include "prepared_kernel.h"
#include "split_launch.h"
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <algorithm>
#include <atomic>
#include <cstring>
#include <limits>
#include <mutex>
#include <unordered_map>

using namespace dlssnr::host;

struct FPreparedKernelRegistry
{
	std::mutex Mutex;
	std::atomic<int64_t> NextId{1};
	std::unordered_map<int64_t, std::weak_ptr<const FPreparedKernelDescriptor>> Descriptors;
};

static FPreparedKernelRegistry& GetPreparedKernelRegistry()
{
	// Avoid destructor ordering between Torch custom classes and registry teardown.
	static auto* Registry = new FPreparedKernelRegistry;
	return *Registry;
}

FPreparedKernelHandle::FPreparedKernelHandle(int64_t InputId,
											 std::shared_ptr<const FPreparedKernelDescriptor> InputDescriptor,
											 std::vector<at::Tensor> Inputs, std::vector<at::Tensor> Outputs)
	: HandleId(InputId), Descriptor(std::move(InputDescriptor)), BoundInputs(std::move(Inputs)),
	  BoundOutputs(std::move(Outputs))
{
}

FPreparedKernelHandle::~FPreparedKernelHandle()
{
	auto& Registry = GetPreparedKernelRegistry();
	std::lock_guard<std::mutex> Lock(Registry.Mutex);
	Registry.Descriptors.erase(HandleId);
}

c10::intrusive_ptr<FPreparedKernelHandle>
RegisterPreparedKernel(std::shared_ptr<const FPreparedKernelDescriptor> Descriptor,
					   std::vector<at::Tensor> Inputs, std::vector<at::Tensor> Outputs)
{
	Descriptor->Validate(Inputs, Outputs, false);
	c10::cuda::CUDAGuard DeviceGuard(c10::Device(c10::kCUDA, Descriptor->DeviceIndex));
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(Descriptor->DeviceIndex).stream(),
						  "prepare individual kernels outside CUDA graph capture");
	auto& Registry = GetPreparedKernelRegistry();
	const int64_t HandleId = Registry.NextId.fetch_add(1);
	TORCH_CHECK(HandleId > 0, "prepared kernel handle range exhausted");
	auto Owner = c10::make_intrusive<FPreparedKernelHandle>(HandleId, Descriptor, std::move(Inputs),
															std::move(Outputs));
	std::lock_guard<std::mutex> Lock(Registry.Mutex);
	Registry.Descriptors.emplace(HandleId, std::move(Descriptor));
	return Owner;
}

std::shared_ptr<const FPreparedKernelDescriptor> FindPreparedKernel(int64_t HandleId)
{
	auto& Registry = GetPreparedKernelRegistry();
	std::lock_guard<std::mutex> Lock(Registry.Mutex);
	const auto Found = Registry.Descriptors.find(HandleId);
	TORCH_CHECK(
		Found != Registry.Descriptors.end(),
		"prepared kernel handle is invalid or released; retain its owner through execution and graph lifetime");
	auto Descriptor = Found->second.lock();
	TORCH_CHECK(Descriptor, "prepared kernel owner was released");
	return Descriptor;
}

FPreparedKernelSequence::FPreparedKernelSequence(
	std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> InputOwners)
	: Owners(std::move(InputOwners))
{
	TORCH_CHECK(!Owners.empty(), "a prepared kernel sequence cannot be empty");
	const auto FirstDescriptor = FindPreparedKernel(Owners.front()->Id());
	c10::cuda::CUDAGuard DeviceGuard(c10::Device(c10::kCUDA, FirstDescriptor->DeviceIndex));
	RequireOutsideCapture(c10::cuda::getCurrentCUDAStream(FirstDescriptor->DeviceIndex).stream(),
						  "compose prepared kernel sequences outside CUDA graph capture");
	for (const auto& Owner : Owners)
	{
		const auto Descriptor = FindPreparedKernel(Owner->Id());
		TORCH_CHECK(Descriptor->DeviceIndex == FirstDescriptor->DeviceIndex,
					"a prepared kernel sequence must use one CUDA device");
		Descriptor->Validate(Owner->Inputs(), Owner->Outputs(), false);
	}
}

std::vector<at::Tensor> FPreparedKernelSequence::Run()
{
	// Validate the entire bound chain before the first launch can modify a tensor.
	std::vector<std::shared_ptr<const FPreparedKernelDescriptor>> Descriptors;
	Descriptors.reserve(Owners.size());
	for (const auto& Owner : Owners)
	{
		auto Descriptor = FindPreparedKernel(Owner->Id());
		Descriptor->Validate(Owner->Inputs(), Owner->Outputs(), false);
		Descriptors.push_back(std::move(Descriptor));
	}
	for (size_t KernelIndex = 0; KernelIndex < Owners.size(); ++KernelIndex)
		Descriptors[KernelIndex]->Launch(Owners[KernelIndex]->Inputs(), Owners[KernelIndex]->Outputs());
	return Owners.back()->Outputs();
}

c10::intrusive_ptr<FPreparedKernelSequence>
CreateKernelSequence(std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> Owners)
{
	return c10::make_intrusive<FPreparedKernelSequence>(std::move(Owners));
}

FPhysicalKernelDescriptor::FPhysicalKernelDescriptor(
	std::string InputName, int InputDeviceIndex, const void* InputFunction, dim3 InputGrid, dim3 InputBlock,
	std::array<unsigned char, 96> InputParameterBlock,
	std::vector<dlssnr::host::FPhysicalTensorBinding> InputBindings, std::vector<int64_t> InputExtents,
	std::vector<int64_t> OutputExtents, int InputSplitParameterOffset)
	: FPreparedKernelDescriptor(std::move(InputName), InputDeviceIndex), Function(InputFunction),
	  Grid(InputGrid), Block(InputBlock), SplitParameterOffset(InputSplitParameterOffset),
	  ParameterBlock(InputParameterBlock), Bindings(std::move(InputBindings)),
	  InputBytes(std::move(InputExtents)), OutputBytes(std::move(OutputExtents))
{
}

void FPhysicalKernelDescriptor::Validate(const std::vector<at::Tensor>& Inputs,
										 const std::vector<at::Tensor>& Outputs, bool bMeta) const
{
	TORCH_CHECK(Inputs.size() == InputBytes.size() && Outputs.size() == OutputBytes.size(), Name,
				": tensor argument count differs from prepared ABI");
	std::vector<FPhysicalRange> StorageRanges;
	const auto ValidateList = [&](const auto& Tensors, const auto& Bytes)
	{
		for (size_t TensorIndex = 0; TensorIndex < Tensors.size(); ++TensorIndex)
		{
			const auto& Tensor = Tensors[TensorIndex];
			RequirePreparedByteExtent(Tensor, Bytes[TensorIndex], Name);
			RequireInferenceOnly(Tensor, Name, ": deployment kernels are inference only");
			if (bMeta)
				continue;
			TORCH_CHECK(Tensor.is_cuda() && Tensor.get_device() == DeviceIndex, Name,
						": tensor device differs from prepared kernel");
			FPhysicalRange Range{};
			const auto Address = TensorByteAddress(Tensor);
			TORCH_CHECK(IsAligned16(Address) && TryPhysicalRange(Address, uintptr_t(Tensor.numel()), Range),
						Name, ": invalid or unaligned physical storage range");
			StorageRanges.push_back(Range);
		}
	};
	ValidateList(Inputs, InputBytes);
	ValidateList(Outputs, OutputBytes);
	// No undeclared aliases: functionalization may replace every mutable tensor.
	RequirePairwiseDisjoint(StorageRanges, Name, ": physical tensor arguments must be pairwise disjoint");
}

void FPhysicalKernelDescriptor::Launch(const std::vector<at::Tensor>& Inputs,
									   const std::vector<at::Tensor>& Outputs) const
{
	c10::cuda::CUDAGuard DeviceGuard(c10::Device(c10::kCUDA, DeviceIndex));
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (const auto* Tensors : {&Inputs, &Outputs})
		for (const auto& Tensor : *Tensors)
			c10::cuda::CUDACachingAllocator::recordStream(Tensor.storage().data_ptr(), Stream);
	alignas(8) auto Arguments = ParameterBlock;
	for (const auto& Binding : Bindings)
	{
		const auto& Tensor = (Binding.bMutable ? Outputs : Inputs).at(Binding.TensorIndex);
		BindPrevalidatedTensorAddress(Arguments, Binding.ParameterOffset, Tensor);
	}
	LaunchPhysicalKernel(Function, Grid, Block, Arguments, SplitParameterOffset, Stream.stream());
	C10_CUDA_KERNEL_LAUNCH_CHECK();
}
