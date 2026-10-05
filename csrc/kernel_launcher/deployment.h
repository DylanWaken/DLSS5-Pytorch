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
	FDeploymentPlan(at::Tensor g_Input, std::vector<at::Tensor> g_InputPackedWeightRecords,
					int64_t Width = 3840, int64_t Height = 2160);
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

	std::vector<int64_t> GetResources() const
	{
		return ResourceRows;
	}

  private:
	uint64_t GetBufferAddress(size_t g_BufferIndex) const;
	uint64_t GetRecordAddress(size_t g_RecordIndex) const;
	void BuildCalls();
	std::vector<at::Tensor> g_Buffers, g_PackedWeightRecords, g_GuardedBackings;
	std::vector<uint64_t> g_BufferAddresses, g_PackedWeightAddresses;
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
CreatePlanForResolution_fp8(at::Tensor g_Input, std::vector<at::Tensor> g_PackedWeightRecords, int64_t Width,
							int64_t Height);
c10::intrusive_ptr<FDeploymentPlan_fp8> CreatePlan_fp8(at::Tensor g_Input,
													   std::vector<at::Tensor> g_PackedWeightRecords);
c10::intrusive_ptr<FDeploymentPlan_fp16>
CreatePlanForResolution_fp16(at::Tensor g_Input, std::vector<at::Tensor> g_PackedWeightRecords, int64_t Width,
							 int64_t Height);
c10::intrusive_ptr<FDeploymentPlan_fp16> CreatePlan_fp16(at::Tensor g_Input,
														 std::vector<at::Tensor> g_PackedWeightRecords);
