#pragma once
#include <array>
#include <cuda_runtime_api.h>
#include <string>

// Negative offset selects the original all-resident launch. Otherwise this
// names the OrderedSplit control word in the unchanged by-value ABI record.
int OrderedSplitParameterOffset(const std::string& Name);
int ReadSplitSmCountLimit();
void LaunchPhysicalKernel(const void* Function, dim3 Grid, dim3 Block,
						  const std::array<unsigned char, 96>& ParameterBlock, int SplitParameterOffset,
						  cudaStream_t Stream);
