// Included once by the common launcher .cpp. No CUDA body is compiled here.
// Accepted reconstructed CUDA TUs own all 18 registered host stubs below.
#include <ATen/ATen.h>
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <cuda_runtime_api.h>
#include <array>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <limits>
#include <iterator>
#include <mutex>
#include <type_traits>
#include <vector>

#include "kernel_impl/shared/common/kernel_abi.h"
#include "architecture_support.h"

constexpr int C512EntryCount = 18;

// Distinguish the physical buffer contract of each C512 operation explicitly.
enum class EC512KernelRole
{
	FfnExpansion,
	FfnExpansionInputView,
	FfnProjection,
	FfnProjectionInputView,
	QkvAttention,
	AttentionProjection,
	AttentionProjectionOutputView,
	AttentionProjectionPool,
	ChannelExpansion
};

struct FC512KernelEntry
{
	EC512KernelRole Role;
	int ElementBytes, AbiBytes, Warps;
	int64_t RecordBytes;
	const void* Function;
};

const std::array<FC512KernelEntry, C512EntryCount>& C512GetEntryTable()
{
	static const std::array<FC512KernelEntry, C512EntryCount> Table{{
		{EC512KernelRole::FfnExpansion, 1, 56, 8, 524288,
		 reinterpret_cast<const void*>(&window_ffn_c512_fp8)}, // 0: ffn/fp8
		{EC512KernelRole::FfnExpansion, 2, 56, 4, 1048576,
		 reinterpret_cast<const void*>(&window_ffn_c512_fp16)}, // 1: ffn/half
		{EC512KernelRole::FfnExpansionInputView, 1, 56, 4, 524288,
		 reinterpret_cast<const void*>(&window_ffn_input_view_c512_fp8)}, // 2: ffn_input_view/fp8
		{EC512KernelRole::FfnExpansionInputView, 2, 56, 4, 1048576,
		 reinterpret_cast<const void*>(&window_ffn_input_view_c512_fp16)}, // 3: ffn_input_view/half
		{EC512KernelRole::FfnProjection, 1, 72, 4, 263168,
		 Resolve_window_ffn_projection_c512_fp8()}, // 4: ffn_projection/fp8
		{EC512KernelRole::FfnProjection, 2, 72, 4, 525312,
		 Resolve_window_ffn_projection_c512_fp16()}, // 5: ffn_projection/half
		{EC512KernelRole::FfnProjectionInputView, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(
			 &window_ffn_projection_input_view_c512_fp8)}, // 6: ffn_projection_input_view/fp8
		{EC512KernelRole::FfnProjectionInputView, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(
			 &window_ffn_projection_input_view_c512_fp16)}, // 7: ffn_projection_input_view/half
		{EC512KernelRole::QkvAttention, 1, 56, 4, 917568,
		 reinterpret_cast<const void*>(&window_qkv_c512_fp8)}, // 8: qkv_attention/fp8
		{EC512KernelRole::QkvAttention, 2, 56, 4, 1704000,
		 reinterpret_cast<const void*>(&window_qkv_c512_fp16)}, // 9: qkv_attention/half
		{EC512KernelRole::AttentionProjection, 1, 72, 8, 263168,
		 Resolve_window_attention_projection_c512_fp8()}, // 10: attention_projection/fp8
		{EC512KernelRole::AttentionProjection, 2, 72, 8, 525312,
		 Resolve_window_attention_projection_c512_fp16()}, // 11: attention_projection/half
		{EC512KernelRole::AttentionProjectionOutputView, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(
			 &window_attention_projection_output_view_c512_fp8)}, // 12: attention_projection_output_view/fp8
		{EC512KernelRole::AttentionProjectionOutputView, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(
			 &window_attention_projection_output_view_c512_fp16)}, // 13: attention_projection_output_view/half
		{EC512KernelRole::AttentionProjectionPool, 1, 80, 4, 263168,
		 reinterpret_cast<const void*>(
			 &window_attention_projection_pool_c512_fp8)}, // 14: attention_projection_pool/fp8
		{EC512KernelRole::AttentionProjectionPool, 2, 80, 4, 525312,
		 reinterpret_cast<const void*>(
			 &window_attention_projection_pool_c512_fp16)}, // 15: attention_projection_pool/half
		{EC512KernelRole::ChannelExpansion, 1, 40, 8, 524304,
		 reinterpret_cast<const void*>(&channel_projection_c512_to_c1024_fp8)}, // 16: adapter_512_to_1024/fp8
		{EC512KernelRole::ChannelExpansion, 2, 40, 8, 1048592,
		 reinterpret_cast<const void*>(
			 &channel_projection_c512_to_c1024_fp16)}, // 17: adapter_512_to_1024/half
	}};
	return Table;
}

struct FC512PreparedEntries
{
	std::mutex Mutex;
	std::array<std::array<bool, 2>, 64> Devices{};
};

FC512PreparedEntries& C512GetPreparationState()
{
	static FC512PreparedEntries PreparationState;
	return PreparationState;
}

void C512ValidatePhysicalTensor(const at::Tensor& Tensor, int64_t Bytes, const at::Device& TensorDevice,
								const char* Role)
{
	TORCH_CHECK(Tensor.defined() && Tensor.is_cuda() && Tensor.device() == TensorDevice &&
					Tensor.scalar_type() == at::kByte,
				Role, " requires a physical uint8 tensor on the selected CUDA device");
	TORCH_CHECK(Tensor.dim() == 1 && Tensor.is_contiguous() && Tensor.numel() == Bytes, Role,
				" requires exact contiguous physical extent ", Bytes);
	TORCH_CHECK(!Tensor.requires_grad(), "reconstructed C512 execution is inference only");
	TORCH_CHECK(reinterpret_cast<uintptr_t>(Tensor.data_ptr()) % 16 == 0, Role,
				" requires 16-byte alignment");
}

void C512ValidateDisjoint(const at::Tensor& FirstTensor, const at::Tensor& SecondTensor)
{
	const uintptr_t g_FirstAddress = reinterpret_cast<uintptr_t>(FirstTensor.data_ptr()),
					g_SecondAddress = reinterpret_cast<uintptr_t>(SecondTensor.data_ptr());
	const uintptr_t FirstByteCount = uintptr_t(FirstTensor.numel()),
					SecondByteCount = uintptr_t(SecondTensor.numel());
	TORCH_CHECK(g_FirstAddress <= std::numeric_limits<uintptr_t>::max() - FirstByteCount &&
					g_SecondAddress <= std::numeric_limits<uintptr_t>::max() - SecondByteCount,
				"C512 physical range overflow");
	TORCH_CHECK(g_FirstAddress + FirstByteCount <= g_SecondAddress ||
					g_SecondAddress + SecondByteCount <= g_FirstAddress,
				"C512 supplied physical buffers must be pairwise disjoint");
}

void C512ValidateAllDisjoint(const std::vector<const at::Tensor*>& Buffers)
{
	for (size_t BufferIndex = 0; BufferIndex < Buffers.size(); ++BufferIndex)
		for (size_t OtherBufferIndex = BufferIndex + 1; OtherBufferIndex < Buffers.size(); ++OtherBufferIndex)
			C512ValidateDisjoint(*Buffers[BufferIndex], *Buffers[OtherBufferIndex]);
}

int C512GetDeviceIndex(const at::Tensor& Tensor)
{
	const int DeviceIndex = Tensor.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64, "C512 device outside preparation table");
	return DeviceIndex;
}

// Named host bindings describe the operation; Parameters remains the exact native ABI.
struct FC512LaunchArguments
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_DownsampledOutput;
	uint64_t g_PackedWeights;
	int32_t Height;
	int32_t Width;
	int32_t OriginX;
	int32_t OriginY;
	int32_t DownsampledHeight;
	int32_t DownsampledWidth;
};

template <class TParameters, EC512KernelRole KernelRole>
void C512LaunchWithParameters(const void* Function, dim3 Grid, dim3 Block, cudaStream_t Stream,
							  const FC512LaunchArguments& Bindings, int AbiBytes)
{
	static_assert(std::is_standard_layout<TParameters>::value &&
				  std::is_trivially_copyable<TParameters>::value);
	TORCH_CHECK(sizeof(TParameters) == size_t(AbiBytes) && alignof(TParameters) == 8,
				"exact compiled Parameters ABI");
	TParameters ParameterBlock{};
	ParameterBlock.g_Input = Bindings.g_Input;
	ParameterBlock.g_Output = Bindings.g_Output;
	ParameterBlock.g_PackedWeights = Bindings.g_PackedWeights;
	ParameterBlock.Height = Bindings.Height;
	ParameterBlock.Width = Bindings.Width;

	constexpr bool bHasResidual = KernelRole == EC512KernelRole::FfnProjection ||
								  KernelRole == EC512KernelRole::FfnProjectionInputView ||
								  KernelRole == EC512KernelRole::AttentionProjection ||
								  KernelRole == EC512KernelRole::AttentionProjectionOutputView ||
								  KernelRole == EC512KernelRole::AttentionProjectionPool;
	if constexpr (bHasResidual)
		ParameterBlock.g_Residual = Bindings.g_Residual;
	if constexpr (KernelRole == EC512KernelRole::FfnExpansion ||
				  KernelRole == EC512KernelRole::FfnExpansionInputView ||
				  KernelRole == EC512KernelRole::QkvAttention)
	{
		ParameterBlock.OriginX = Bindings.OriginX;
		ParameterBlock.OriginY = Bindings.OriginY;
	}
	if constexpr (KernelRole == EC512KernelRole::AttentionProjectionPool)
	{
		ParameterBlock.g_DownsampledOutput = Bindings.g_DownsampledOutput;
		ParameterBlock.DownsampledHeight = Bindings.DownsampledHeight;
		ParameterBlock.DownsampledWidth = Bindings.DownsampledWidth;
	}
	void* KernelArguments[] = {&ParameterBlock};
	C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, Block, KernelArguments, 0, Stream));
}

// Returns nine rows of [entry,device,SM,registers,shared,local,maxThreads].
// Load only the requested precision: Ampere must never prepare FP8 trap stubs.
// Explicit loading/admission is outside capture even when already prepared.
std::vector<int64_t> C512PrepareEntries(const at::Tensor& DeviceAnchor, bool bFp16)
{
	TORCH_CHECK(DeviceAnchor.is_cuda(), "C512 preparation requires CUDA");
	c10::cuda::CUDAGuard DeviceGuard(DeviceAnchor.device());
	const int DeviceIndex = C512GetDeviceIndex(DeviceAnchor);
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	cudaStreamCaptureStatus CaptureStatus = cudaStreamCaptureStatusNone;
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream.stream(), &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"C512 preparation forbidden during capture, including cache hits");
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	RequireDevicePrecision(DeviceProperties, bFp16, "C512 preparation");
	std::vector<int64_t> ResourceRows;
	ResourceRows.reserve(9 * 7);
	for (int EntryIndex = 0; EntryIndex < 18; ++EntryIndex)
	{
		const auto& EntrySpec = C512GetEntryTable()[EntryIndex];
		if ((EntrySpec.ElementBytes == 2) != bFp16)
			continue;
		const auto Admission = ValidateKernelDevice(EntrySpec.Function, DeviceProperties, bFp16,
													dim3(32, EntrySpec.Warps), "C512 preparation");
		const auto& FunctionAttributes = Admission.Attributes;
		const int64_t ResourceRow[] = {EntryIndex,
									   DeviceIndex,
									   GetDeviceArchitecture(DeviceProperties),
									   FunctionAttributes.numRegs,
									   int64_t(FunctionAttributes.sharedSizeBytes),
									   int64_t(FunctionAttributes.localSizeBytes),
									   FunctionAttributes.maxThreadsPerBlock};
		ResourceRows.insert(ResourceRows.end(), std::begin(ResourceRow), std::end(ResourceRow));
	}
	auto& Preparation = C512GetPreparationState();
	std::lock_guard<std::mutex> Lock(Preparation.Mutex);
	Preparation.Devices[DeviceIndex][bFp16 ? 1 : 0] = true;
	return ResourceRows;
}

// Inputs use public order state,record[,skip]; outputs high[,pool].
// All memory is caller-owned. No preparation, allocation, conversion, native
// module lookup, legacy computation, or fallback is performed by this route.
std::vector<at::Tensor> C512LaunchEntry(int64_t EntryIndex, std::vector<at::Tensor> Inputs,
										std::vector<at::Tensor> Outputs, int64_t Height, int64_t Width,
										int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry 0..17");
	const auto& EntrySpec = C512GetEntryTable()[EntryIndex];
	const bool bChannelExpansion = EntrySpec.Role == EC512KernelRole::ChannelExpansion,
			   bPooledOutput = EntrySpec.Role == EC512KernelRole::AttentionProjectionPool,
			   bResidualInput = EntrySpec.Role == EC512KernelRole::FfnProjection ||
								EntrySpec.Role == EC512KernelRole::FfnProjectionInputView ||
								EntrySpec.Role == EC512KernelRole::AttentionProjection ||
								EntrySpec.Role == EC512KernelRole::AttentionProjectionOutputView ||
								bPooledOutput;
	TORCH_CHECK(Inputs.size() == size_t(bResidualInput ? 3 : 2) &&
					Outputs.size() == size_t(bPooledOutput ? 2 : 1),
				"C512 exact input/output roles");
	const auto& Input = Inputs[0];
	TORCH_CHECK(Input.is_cuda(), "C512 requires CUDA state");
	const bool bQualified4KField =
		Height == (bChannelExpansion ? 36 : 68) && Width == (bChannelExpansion ? 60 : 120);
	const bool bBoundedFp16 = EntrySpec.ElementBytes == 2 && Height == 16 && Width == 24;
	TORCH_CHECK(bQualified4KField || bBoundedFp16,
				"C512 fixed 4K field or separate bounded Half field required");
	TORCH_CHECK(WindowPhase >= 0 && WindowPhase <= 3 &&
					(EntrySpec.Role == EC512KernelRole::QkvAttention || WindowPhase == 0),
				"phase belongs only to fused QKV/attention");
	const int64_t ImageBytes = Height * Width * 512 * EntrySpec.ElementBytes,
				  PoolHeight = ((Height + 7) / 8) * 4, PoolWidth = ((Width + 7) / 8) * 4;
	C512ValidatePhysicalTensor(Input, ImageBytes, Input.device(), "state");
	C512ValidatePhysicalTensor(Inputs[1], EntrySpec.RecordBytes, Input.device(), "record");
	if (bResidualInput)
		C512ValidatePhysicalTensor(Inputs[2], ImageBytes, Input.device(), "skip");
	C512ValidatePhysicalTensor(Outputs[0], bChannelExpansion ? 2 * ImageBytes : ImageBytes, Input.device(),
							   "high");
	if (bPooledOutput)
		C512ValidatePhysicalTensor(Outputs[1], PoolHeight * PoolWidth * 512 * EntrySpec.ElementBytes,
								   Input.device(), "pool");
	std::vector<const at::Tensor*> Buffers;
	for (const auto& Tensor : Inputs)
		Buffers.push_back(&Tensor);
	for (const auto& Tensor : Outputs)
		Buffers.push_back(&Tensor);
	C512ValidateAllDisjoint(Buffers);
	c10::cuda::CUDAGuard DeviceGuard(Input.device());
	const int DeviceIndex = Input.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64, "C512 device outside preparation table");
	{
		auto& Preparation = C512GetPreparationState();
		std::lock_guard<std::mutex> Lock(Preparation.Mutex);
		TORCH_CHECK(Preparation.Devices[DeviceIndex][EntrySpec.ElementBytes == 2 ? 1 : 0],
					"prepare reconstructed C512 entries of the requested precision outside capture first");
	}
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (const auto* Tensor : Buffers)
		c10::cuda::CUDACachingAllocator::recordStream(Tensor->storage().data_ptr(), Stream);
	const auto GetTensorAddress = [](const at::Tensor& Tensor)
	{ return uint64_t(reinterpret_cast<uintptr_t>(Tensor.data_ptr())); };
	const int ShiftX = (WindowPhase == 1 || WindowPhase == 2) ? 4 : 0;
	const int ShiftY = (WindowPhase == 1 || WindowPhase == 3) ? 4 : 0;
	const bool bQkvAttention = EntrySpec.Role == EC512KernelRole::QkvAttention;
	const FC512LaunchArguments Bindings{GetTensorAddress(Input),
										bResidualInput ? GetTensorAddress(Inputs[2]) : 0,
										GetTensorAddress(Outputs[0]),
										bPooledOutput ? GetTensorAddress(Outputs[1]) : 0,
										GetTensorAddress(Inputs[1]),
										int32_t(Height),
										int32_t(Width),
										bQkvAttention ? -ShiftX : 0,
										bQkvAttention ? -ShiftY : 0,
										bPooledOutput ? int32_t(PoolHeight) : 0,
										bPooledOutput ? int32_t(PoolWidth) : 0};
	const unsigned TilesX = unsigned((Width + 7) / 8), TilesY = unsigned((Height + 7) / 8);
	dim3 Grid(EntrySpec.Role == EC512KernelRole::QkvAttention
				  ? unsigned((Width + ShiftX + 7) / 8)
				  : (bChannelExpansion ? 4 * TilesX
					 : (EntrySpec.Role == EC512KernelRole::FfnExpansion ||
						EntrySpec.Role == EC512KernelRole::FfnExpansionInputView)
						 ? TilesX
						 : 2 * TilesX),
			  EntrySpec.Role == EC512KernelRole::QkvAttention ? unsigned((Height + ShiftY + 7) / 8) : TilesY,
			  EntrySpec.Role == EC512KernelRole::QkvAttention ? 4
			  : (EntrySpec.Role == EC512KernelRole::FfnExpansion ||
				 EntrySpec.Role == EC512KernelRole::FfnExpansionInputView)
				  ? 2
				  : 1);
	const dim3 Block(32, EntrySpec.Warps, 1);
	switch (EntryIndex)
	{
	case 0:
		C512LaunchWithParameters<FWindowFfnC512Fp8Parameters, EC512KernelRole::FfnExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 1:
		C512LaunchWithParameters<FWindowFfnC512Fp16Parameters, EC512KernelRole::FfnExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 2:
		C512LaunchWithParameters<FWindowFfnInputViewC512Fp8Parameters,
								 EC512KernelRole::FfnExpansionInputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 3:
		C512LaunchWithParameters<FWindowFfnInputViewC512Fp16Parameters,
								 EC512KernelRole::FfnExpansionInputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 4:
		C512LaunchWithParameters<FWindowFfnProjectionC512Fp8Parameters, EC512KernelRole::FfnProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 5:
		C512LaunchWithParameters<FWindowFfnProjectionC512Fp16Parameters, EC512KernelRole::FfnProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 6:
		C512LaunchWithParameters<FWindowFfnProjectionInputViewC512Fp8Parameters,
								 EC512KernelRole::FfnProjectionInputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 7:
		C512LaunchWithParameters<FWindowFfnProjectionInputViewC512Fp16Parameters,
								 EC512KernelRole::FfnProjectionInputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 8:
		C512LaunchWithParameters<FWindowQkvC512Fp8Parameters, EC512KernelRole::QkvAttention>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 9:
		C512LaunchWithParameters<FWindowQkvC512Fp16Parameters, EC512KernelRole::QkvAttention>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 10:
		C512LaunchWithParameters<FWindowAttentionProjectionC512Fp8Parameters,
								 EC512KernelRole::AttentionProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 11:
		C512LaunchWithParameters<FWindowAttentionProjectionC512Fp16Parameters,
								 EC512KernelRole::AttentionProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 12:
		C512LaunchWithParameters<FWindowAttentionProjectionOutputViewC512Fp8Parameters,
								 EC512KernelRole::AttentionProjectionOutputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 13:
		C512LaunchWithParameters<FWindowAttentionProjectionOutputViewC512Fp16Parameters,
								 EC512KernelRole::AttentionProjectionOutputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 14:
		C512LaunchWithParameters<FWindowAttentionProjectionPoolC512Fp8Parameters,
								 EC512KernelRole::AttentionProjectionPool>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 15:
		C512LaunchWithParameters<FWindowAttentionProjectionPoolC512Fp16Parameters,
								 EC512KernelRole::AttentionProjectionPool>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 16:
		C512LaunchWithParameters<FChannelProjectionC512ToC1024Fp8Parameters,
								 EC512KernelRole::ChannelExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 17:
		C512LaunchWithParameters<FChannelProjectionC512ToC1024Fp16Parameters,
								 EC512KernelRole::ChannelExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	default:
		TORCH_CHECK(false, "unreachable C512 entry");
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return Outputs;
}

// All 16 real C512 blocks, including the input/pooled/output boundaries.
// Records are layer0..3 (plus4 at block30). Workspaces are branches,FFN,
// attended,high (plus pool,down at block30); all are retained and returned.
std::vector<at::Tensor> C512BlockOutEntry(int64_t BlockIndex, bool bFp16, const at::Tensor& Input,
										  std::vector<at::Tensor> Records, std::vector<at::Tensor> Workspaces)
{
	TORCH_CHECK((BlockIndex >= 23 && BlockIndex <= 30) || (BlockIndex >= 40 && BlockIndex <= 47),
				"C512 actual blocks23..30/40..47 only");
	const bool bInputView = BlockIndex == 23, bDownsample = BlockIndex == 30, bOutputView = BlockIndex == 47;
	const int PrecisionOffset = bFp16 ? 1 : 0;
	TORCH_CHECK(Records.size() == size_t(bDownsample ? 5 : 4) &&
					Workspaces.size() == size_t(bDownsample ? 6 : 4),
				"C512 block complete retained roles");
	TORCH_CHECK(Input.is_cuda(), "C512 block state CUDA");
	const int64_t ImageBytes = 68 * 120 * 512 * (bFp16 ? 2 : 1);
	C512ValidatePhysicalTensor(Input, ImageBytes, Input.device(), "block state");
	const std::array<int64_t, 5> RecordByteExtents{{bFp16 ? 1048576 : 524288, bFp16 ? 525312 : 263168,
													bFp16 ? 1704000 : 917568, bFp16 ? 525312 : 263168,
													bFp16 ? 1048592 : 524304}};
	std::vector<const at::Tensor*> Buffers{&Input};
	for (size_t RecordIndex = 0; RecordIndex < Records.size(); ++RecordIndex)
	{
		C512ValidatePhysicalTensor(Records[RecordIndex], RecordByteExtents[RecordIndex], Input.device(),
								   "block record");
		Buffers.push_back(&Records[RecordIndex]);
	}
	for (size_t WorkspaceIndex = 0; WorkspaceIndex < Workspaces.size(); ++WorkspaceIndex)
	{
		const int64_t Bytes =
			WorkspaceIndex < 4 ? ImageBytes : 36 * 60 * 512 * (bFp16 ? 2 : 1) * (WorkspaceIndex == 5 ? 2 : 1);
		C512ValidatePhysicalTensor(Workspaces[WorkspaceIndex], Bytes, Input.device(), "block workspace");
		Buffers.push_back(&Workspaces[WorkspaceIndex]);
	}
	C512ValidateAllDisjoint(Buffers);
	C512LaunchEntry((bInputView ? 2 : 0) + PrecisionOffset, {Input, Records[0]}, {Workspaces[0]}, 68, 120, 0);
	C512LaunchEntry((bInputView ? 6 : 4) + PrecisionOffset, {Workspaces[0], Records[1], Input},
					{Workspaces[1]}, 68, 120, 0);
	const int WindowPhase = int(BlockIndex < 31 ? (BlockIndex - 23) % 4 : (BlockIndex - 40) % 4);
	C512LaunchEntry(8 + PrecisionOffset, {Workspaces[1], Records[2]}, {Workspaces[2]}, 68, 120, WindowPhase);
	if (bDownsample)
	{
		C512LaunchEntry(14 + PrecisionOffset, {Workspaces[2], Records[3], Workspaces[1]},
						{Workspaces[3], Workspaces[4]}, 68, 120, 0);
		C512LaunchEntry(16 + PrecisionOffset, {Workspaces[4], Records[4]}, {Workspaces[5]}, 36, 60, 0);
	}
	else
		C512LaunchEntry((bOutputView ? 12 : 10) + PrecisionOffset, {Workspaces[2], Records[3], Workspaces[1]},
						{Workspaces[3]}, 68, 120, 0);
	return Workspaces;
}

std::vector<int64_t> PrepareC512_fp8(const at::Tensor& DeviceAnchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(C512GetEntryTable()[EntryIndex].ElementBytes == 1,
				"C512 precision does not match _fp8 binding");
	return C512PrepareEntries(DeviceAnchor, false);
}

std::vector<at::Tensor> LaunchC512_fp8(int64_t EntryIndex, std::vector<at::Tensor> Inputs,
									   std::vector<at::Tensor> Outputs, int64_t Height, int64_t Width,
									   int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(C512GetEntryTable()[EntryIndex].ElementBytes == 1,
				"C512 precision does not match _fp8 binding");
	return C512LaunchEntry(EntryIndex, std::move(Inputs), std::move(Outputs), Height, Width, WindowPhase);
}

std::vector<at::Tensor> C512BlockOut_fp8(int64_t BlockIndex, const at::Tensor& Input,
										 std::vector<at::Tensor> Records, std::vector<at::Tensor> Workspaces)
{
	return C512BlockOutEntry(BlockIndex, false, Input, std::move(Records), std::move(Workspaces));
}

std::vector<int64_t> PrepareC512_fp16(const at::Tensor& DeviceAnchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(C512GetEntryTable()[EntryIndex].ElementBytes == 2,
				"C512 precision does not match _fp16 binding");
	return C512PrepareEntries(DeviceAnchor, true);
}

std::vector<at::Tensor> LaunchC512_fp16(int64_t EntryIndex, std::vector<at::Tensor> Inputs,
										std::vector<at::Tensor> Outputs, int64_t Height, int64_t Width,
										int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(C512GetEntryTable()[EntryIndex].ElementBytes == 2,
				"C512 precision does not match _fp16 binding");
	return C512LaunchEntry(EntryIndex, std::move(Inputs), std::move(Outputs), Height, Width, WindowPhase);
}

std::vector<at::Tensor> C512BlockOut_fp16(int64_t BlockIndex, const at::Tensor& Input,
										  std::vector<at::Tensor> Records, std::vector<at::Tensor> Workspaces)
{
	return C512BlockOutEntry(BlockIndex, true, Input, std::move(Records), std::move(Workspaces));
}
