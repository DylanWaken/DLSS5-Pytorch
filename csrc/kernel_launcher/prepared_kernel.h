#pragma once
#include <ATen/ATen.h>
#include <torch/custom_class.h>
#include <array>
#include <memory>
#include <string>
#include <vector>
#include <cuda_runtime_api.h>

// Prepared descriptors contain immutable launch metadata. Tensor addresses are
// supplied again on every invocation so AOT functionalization can replace them.
struct FPreparedKernelDescriptor
{
	const std::string Name;
	const int DeviceIndex;

	FPreparedKernelDescriptor(std::string InputName, int InputDeviceIndex)
		: Name(std::move(InputName)), DeviceIndex(InputDeviceIndex)
	{
	}

	virtual ~FPreparedKernelDescriptor() = default;
	virtual void Validate(const std::vector<at::Tensor>& Inputs, const std::vector<at::Tensor>& Outputs,
						  bool bMeta) const = 0;
	virtual void Launch(const std::vector<at::Tensor>& Inputs,
						const std::vector<at::Tensor>& Outputs) const = 0;
};

class FPreparedKernelHandle : public torch::CustomClassHolder
{
  public:
	FPreparedKernelHandle(int64_t InputId, std::shared_ptr<const FPreparedKernelDescriptor> InputDescriptor,
						  std::vector<at::Tensor> Inputs, std::vector<at::Tensor> Outputs);
	~FPreparedKernelHandle() override;

	int64_t Id() const
	{
		return HandleId;
	}

	std::string Name() const
	{
		return Descriptor->Name;
	}

	std::vector<at::Tensor> Inputs() const
	{
		return BoundInputs;
	}

	std::vector<at::Tensor> Outputs() const
	{
		return BoundOutputs;
	}

  private:
	const int64_t HandleId;
	const std::shared_ptr<const FPreparedKernelDescriptor> Descriptor;
	const std::vector<at::Tensor> BoundInputs, BoundOutputs;
};

c10::intrusive_ptr<FPreparedKernelHandle>
RegisterPreparedKernel(std::shared_ptr<const FPreparedKernelDescriptor> Descriptor,
					   std::vector<at::Tensor> Inputs, std::vector<at::Tensor> Outputs);
std::shared_ptr<const FPreparedKernelDescriptor> FindPreparedKernel(int64_t HandleId);

// An eager/capturable integrated route for any prepared chain, including renderer
// textures. The named Torch operators remain the route for torch.compile.
class FPreparedKernelSequence : public torch::CustomClassHolder
{
  public:
	explicit FPreparedKernelSequence(std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> InputOwners);
	std::vector<at::Tensor> Run();

  private:
	const std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> Owners;
};

c10::intrusive_ptr<FPreparedKernelSequence>
CreateKernelSequence(std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> Owners);

struct FPhysicalTensorBinding
{
	size_t ParameterOffset;
	size_t TensorIndex;
	bool bMutable;
};

// All extents are exact physical byte counts; layouts are the native packed ABI.
struct FPhysicalKernelDescriptor final : FPreparedKernelDescriptor
{
	const void* const Function;
	const dim3 Grid, Block;
	const int SplitParameterOffset;
	const std::array<unsigned char, 96> ParameterBlock;
	const std::vector<FPhysicalTensorBinding> Bindings;
	const std::vector<int64_t> InputBytes, OutputBytes;
	FPhysicalKernelDescriptor(std::string Name, int DeviceIndex, const void* Function, dim3 Grid, dim3 Block,
							  std::array<unsigned char, 96> ParameterBlock,
							  std::vector<FPhysicalTensorBinding> Bindings, std::vector<int64_t> InputBytes,
							  std::vector<int64_t> OutputBytes, int SplitParameterOffset = -1);
	void Validate(const std::vector<at::Tensor>& Inputs, const std::vector<at::Tensor>& Outputs,
				  bool bMeta) const override;
	void Launch(const std::vector<at::Tensor>& Inputs, const std::vector<at::Tensor>& Outputs) const override;
};

c10::intrusive_ptr<FPreparedKernelHandle> PrepareOutputView_fp8(at::Tensor Input, at::Tensor PackedWeights,
																at::Tensor Output, int64_t Height,
																int64_t Width, int64_t Phase);
c10::intrusive_ptr<FPreparedKernelHandle> PrepareOutputView_fp16(at::Tensor Input, at::Tensor PackedWeights,
																 at::Tensor Output, int64_t Height,
																 int64_t Width, int64_t Phase);
