#pragma once
#include "deployment.h"

// A separate Small31 plan. It shares only the ABI records and prepared-kernel
// interfaces with FDeploymentPlan; state, generated tables and registration
// stay distinct so callers cannot switch models implicitly.
template <bool bFp16> class FSmallDeploymentPlan : public torch::CustomClassHolder
{
  public:
	FSmallDeploymentPlan(at::Tensor Input, std::vector<at::Tensor> InputPackedWeightRecords,
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
	std::vector<c10::intrusive_ptr<FPreparedKernelHandle>> PrepareKernels() const;
	std::vector<at::Tensor> GetTensorArguments() const;
	std::vector<std::vector<int64_t>> GetKernelTensorIndices() const;

	std::vector<int64_t> GetResources() const
	{
		return ResourceRows;
	}

	// One entry per logical call: 1 for a resident launch, 2/4 for ordered splits.
	std::vector<int64_t> GetSplitLaunchCounts() const;

  private:
	uint64_t GetBufferAddress(size_t BufferIndex) const;
	uint64_t GetRecordAddress(size_t RecordIndex) const;
	void BuildCalls();
	std::vector<at::Tensor> Buffers, PackedWeightRecords, GuardedBackings;
	std::vector<uint64_t> BufferAddresses, PackedWeightAddresses;
	std::vector<FKernelCall> Calls;
	std::vector<int64_t> ResourceRows;
	int DeviceIndex;
	std::unique_ptr<const FGeometryPlanSpec> Geometry;
	std::mutex LaunchMutex;
};

using FSmallDeploymentPlan_fp8 = FSmallDeploymentPlan<false>;
using FSmallDeploymentPlan_fp16 = FSmallDeploymentPlan<true>;

std::vector<std::string> RecordNames_small31_fp8();
std::vector<int64_t> RecordBytes_small31_fp8();
std::vector<std::string> RecordNames_small31_fp16();
std::vector<int64_t> RecordBytes_small31_fp16();

c10::intrusive_ptr<FSmallDeploymentPlan_fp8>
CreateSmallPlanForResolution_fp8(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
								 int64_t Height);
c10::intrusive_ptr<FSmallDeploymentPlan_fp16>
CreateSmallPlanForResolution_fp16(at::Tensor Input, std::vector<at::Tensor> PackedWeightRecords, int64_t Width,
								  int64_t Height);
