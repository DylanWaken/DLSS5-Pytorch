#pragma once
#include <ATen/ATen.h>
#include <torch/custom_class.h>
#include <cuda_runtime_api.h>
#include <array>
#include <cstring>
#include <mutex>
#include <string>
#include <vector>
#include "plan_geometry.h"
#include "prepared_kernel.h"

struct FBufferSpec
{
	const char* Name;
	int64_t Bytes;
};

struct FKernelCall
{
	const void* Function;
	dim3 Grid, Block;
	int AbiBytes;
	bool bAllResident;
	alignas(8) std::array<unsigned char, 96> ParameterBlock{};
	const char* Name = nullptr;

	struct FBinding
	{
		size_t ParameterOffset, SourceIndex;
		bool bRecord, bMutable;
	};

	std::vector<FBinding> Bindings;

	void Bind(size_t ParameterOffset, size_t SourceIndex, bool bRecord, bool bMutable)
	{
		Bindings.push_back({ParameterOffset, SourceIndex, bRecord, bMutable});
	}

	template <class TValue> void Set(size_t FieldOffset, TValue FieldValue)
	{
		TORCH_CHECK(FieldOffset + sizeof(TValue) <= size_t(AbiBytes), "parameter outside native ABI");
		std::memcpy(ParameterBlock.data() + FieldOffset, &FieldValue, sizeof(FieldValue));
	}
};

// A plan owns its input, weights, intermediates and prepacked launch arguments.
// Create outside capture; run can be captured. A plan is a mutable workspace:
// its executions must be ordered on the caller's stream, like an out operator.
template <bool bFp16> class FDeploymentPlan : public torch::CustomClassHolder
{
  public:
	FDeploymentPlan(at::Tensor Input, std::vector<at::Tensor> InputPackedWeightRecords, int64_t Width = 3840,
					int64_t Height = 2160);
	at::Tensor Run();

	at::Tensor Run_fp8()
	{
		return Run();
	}

	at::Tensor Run_fp16()
	{
		return Run();
	}

	std::vector<at::Tensor> GetBoundaries() const;
	std::vector<std::string> GetBoundaryNames() const;
	std::vector<std::string> GetBufferNames() const;
	at::Tensor GetBuffer(const std::string& Name) const;
	bool GuardsIntact() const;
	void Poison(int64_t PoisonByte);
	std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> PrepareKernels() const;
	std::vector<at::Tensor> GetTensorArguments() const;
	std::vector<std::vector<int64_t>> GetKernelTensorIndices() const;

	std::vector<int64_t> GetResources() const
	{
		return ResourceRows;
	}

  private:
	uint64_t GetBufferAddress(size_t BufferIndex) const;
	uint64_t GetRecordAddress(size_t RecordIndex) const;
	void BuildCalls();
	std::vector<at::Tensor> Buffers, PackedWeightRecords, GuardedBackings;
	std::vector<uint64_t> BufferAddresses, PackedWeightAddresses;
	std::vector<FKernelCall> Calls;
	std::vector<int64_t> ResourceRows;
	int DeviceIndex;
	const FGeometryPlanSpec* Geometry;
	std::mutex LaunchMutex;
};

using FDeploymentPlan_fp8 = FDeploymentPlan<false>;
using FDeploymentPlan_fp16 = FDeploymentPlan<true>;

std::vector<std::string> RecordNames_fp16();
std::vector<int64_t> RecordBytes_fp16();
std::vector<std::string> RecordNames_fp8();
std::vector<int64_t> RecordBytes_fp8();
std::string CompiledPolicyVersion();
std::vector<int64_t> ResolutionSelection(int64_t Width, int64_t Height, int64_t Sm, bool bFp16);
c10::intrusive_ptr<FDeploymentPlan_fp8>
CreatePlanForResolution_fp8(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
							int64_t Height);
c10::intrusive_ptr<FDeploymentPlan_fp8> CreatePlan_fp8(at::Tensor Input,
													   std::vector<at::Tensor> PackedWeightRecords);
c10::intrusive_ptr<FDeploymentPlan_fp16>
CreatePlanForResolution_fp16(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
							 int64_t Height);
c10::intrusive_ptr<FDeploymentPlan_fp16> CreatePlan_fp16(at::Tensor Input,
														 std::vector<at::Tensor> PackedWeightRecords);
