#include "split_launch.h"
#include "kernel_impl/shared/common/kernel_abi.h"
#include <c10/cuda/CUDAException.h>
#include <c10/util/Exception.h>
#include <cerrno>
#include <climits>
#include <cstdlib>
#include <cstring>

int OrderedSplitParameterOffset(const std::string& Name)
{
	// Only these reductions have dependencies between Z splits. Other kernels
	// use Z for independent work and must retain their original launch geometry.
#define SPLIT_CONTROL(Entry, Parameters)                                                                     \
	if (Name == #Entry)                                                                                      \
	return int(offsetof(Parameters, OrderedSplit))
	SPLIT_CONTROL(global_qkv_c1024_fp8, FGlobalQkvC1024Fp8Parameters);
	SPLIT_CONTROL(global_qkv_c1024_fp16, FGlobalQkvC1024Fp16Parameters);
	SPLIT_CONTROL(global_projection_c1024_fp8, FGlobalProjectionC1024Fp8Parameters);
	SPLIT_CONTROL(global_projection_c1024_fp16, FGlobalProjectionC1024Fp16Parameters);
	SPLIT_CONTROL(global_ffn_contract_c1024_fp8, FGlobalFfnContractC1024Fp8Parameters);
	SPLIT_CONTROL(global_ffn_contract_c1024_fp16, FGlobalFfnContractC1024Fp16Parameters);
	SPLIT_CONTROL(decoder_upsample_c1024_to_c512_fp8, FDecoderUpsampleC1024ToC512Fp8Parameters);
	SPLIT_CONTROL(decoder_upsample_c1024_to_c512_fp16, FDecoderUpsampleC1024ToC512Fp16Parameters);
#undef SPLIT_CONTROL
	TORCH_CHECK(false, "ordered split ABI is unknown for ", Name);
}

int ReadSplitSmCountLimit()
{
	const char* Value = std::getenv("DLSSNR_SM_COUNT_LIMIT");
	if (!Value)
		return 0;
	char* End = nullptr;
	errno = 0;
	const long Limit = std::strtol(Value, &End, 10);
	TORCH_CHECK(errno == 0 && End != Value && *End == '\0' && Limit > 0 && Limit <= INT_MAX,
				"DLSSNR_SM_COUNT_LIMIT must be a positive integer");
	return int(Limit);
}

void LaunchPhysicalKernel(const void* Function, dim3 Grid, dim3 Block,
						  const std::array<unsigned char, 96>& ParameterBlock, int SplitParameterOffset,
						  cudaStream_t Stream)
{
	if (SplitParameterOffset < 0)
	{
		void* Arguments[] = {const_cast<unsigned char*>(ParameterBlock.data())};
		C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, Block, Arguments, 0, Stream));
		return;
	}

	// Stream order (also recorded during CUDA Graph capture) completes the prior
	// split before the next reads scratch. A plane may occupy arbitrarily many
	// waves: no block in these launches waits on another block in its grid.
	alignas(8) auto PhaseParameters = ParameterBlock;
	const unsigned SplitCount = Grid.z;
	Grid.z = 1;
	for (unsigned Split = 0; Split < SplitCount; ++Split)
	{
		const uint64_t OrderedSplit = uint64_t(Split) + 1;
		std::memcpy(PhaseParameters.data() + SplitParameterOffset, &OrderedSplit, sizeof(OrderedSplit));
		void* Arguments[] = {PhaseParameters.data()};
		C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, Block, Arguments, 0, Stream));
	}
}
