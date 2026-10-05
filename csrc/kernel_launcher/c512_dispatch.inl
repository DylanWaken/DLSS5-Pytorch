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

#include "kernel_abi.h"

namespace dlssnr::reconstructed_c512
{
namespace detail
{
constexpr int EntryCount = 18;

// Distinguish the physical buffer contract of each C512 operation explicitly.
enum class EKernelRole
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

struct FKernelEntry
{
	EKernelRole Role;
	int ElementBytes, AbiBytes, Warps;
	int64_t RecordBytes;
	const void* Function;
};

const std::array<FKernelEntry, EntryCount>& GetEntryTable()
{
	static const std::array<FKernelEntry, EntryCount> Table{{
		{EKernelRole::FfnExpansion, 1, 56, 8, 524288,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_c512_fp8::window_ffn_c512_fp8)}, // 0: ffn/fp8
		{EKernelRole::FfnExpansion, 2, 56, 4, 1048576,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_c512_fp16::window_ffn_c512_fp16)}, // 1: ffn/half
		{EKernelRole::FfnExpansionInputView, 1, 56, 4, 524288,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_input_view_c512_fp8::
										   window_ffn_input_view_c512_fp8)}, // 2: ffn_input_view/fp8
		{EKernelRole::FfnExpansionInputView, 2, 56, 4, 1048576,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_input_view_c512_fp16::
										   window_ffn_input_view_c512_fp16)}, // 3: ffn_input_view/half
		{EKernelRole::FfnProjection, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_projection_c512_fp8::
										   window_ffn_projection_c512_fp8)}, // 4: ffn_projection/fp8
		{EKernelRole::FfnProjection, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(&dlssnr::reconstructed::window_ffn_projection_c512_fp16::
										   window_ffn_projection_c512_fp16)}, // 5: ffn_projection/half
		{EKernelRole::FfnProjectionInputView, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8::
				 window_ffn_projection_input_view_c512_fp8)}, // 6: ffn_projection_input_view/fp8
		{EKernelRole::FfnProjectionInputView, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16::
				 window_ffn_projection_input_view_c512_fp16)}, // 7: ffn_projection_input_view/half
		{EKernelRole::QkvAttention, 1, 56, 4, 917568,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_qkv_c512_fp8::window_qkv_c512_fp8)}, // 8: qkv_attention/fp8
		{EKernelRole::QkvAttention, 2, 56, 4, 1704000,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_qkv_c512_fp16::window_qkv_c512_fp16)}, // 9: qkv_attention/half
		{EKernelRole::AttentionProjection, 1, 72, 8, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_c512_fp8::
				 window_attention_projection_c512_fp8)}, // 10: attention_projection/fp8
		{EKernelRole::AttentionProjection, 2, 72, 8, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_c512_fp16::
				 window_attention_projection_c512_fp16)}, // 11: attention_projection/half
		{EKernelRole::AttentionProjectionOutputView, 1, 72, 4, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8::
				 window_attention_projection_output_view_c512_fp8)}, // 12: attention_projection_output_view/fp8
		{EKernelRole::AttentionProjectionOutputView, 2, 72, 4, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16::
				 window_attention_projection_output_view_c512_fp16)}, // 13: attention_projection_output_view/half
		{EKernelRole::AttentionProjectionPool, 1, 80, 4, 263168,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_pool_c512_fp8::
				 window_attention_projection_pool_c512_fp8)}, // 14: attention_projection_pool/fp8
		{EKernelRole::AttentionProjectionPool, 2, 80, 4, 525312,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::window_attention_projection_pool_c512_fp16::
				 window_attention_projection_pool_c512_fp16)}, // 15: attention_projection_pool/half
		{EKernelRole::ChannelExpansion, 1, 40, 8, 524304,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8::
				 channel_projection_c512_to_c1024_fp8)}, // 16: adapter_512_to_1024/fp8
		{EKernelRole::ChannelExpansion, 2, 40, 8, 1048592,
		 reinterpret_cast<const void*>(
			 &dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16::
				 channel_projection_c512_to_c1024_fp16)}, // 17: adapter_512_to_1024/half
	}};
	return Table;
}

struct FPreparedEntries
{
	std::mutex Mutex;
	std::array<bool, 64> Devices{};
};

FPreparedEntries& GetPreparationState()
{
	static FPreparedEntries PreparationState;
	return PreparationState;
}

void ValidatePhysicalTensor(const at::Tensor& g_Tensor, int64_t Bytes, const at::Device& TensorDevice,
							const char* Role)
{
	TORCH_CHECK(g_Tensor.defined() && g_Tensor.is_cuda() && g_Tensor.device() == TensorDevice &&
					g_Tensor.scalar_type() == at::kByte,
				Role, " requires a physical uint8 tensor on the selected CUDA device");
	TORCH_CHECK(g_Tensor.dim() == 1 && g_Tensor.is_contiguous() && g_Tensor.numel() == Bytes, Role,
				" requires exact contiguous physical extent ", Bytes);
	TORCH_CHECK(!g_Tensor.requires_grad(), "reconstructed C512 execution is inference only");
	TORCH_CHECK(reinterpret_cast<uintptr_t>(g_Tensor.data_ptr()) % 16 == 0, Role,
				" requires 16-byte alignment");
}

void ValidateDisjoint(const at::Tensor& g_FirstTensor, const at::Tensor& g_SecondTensor)
{
	const uintptr_t g_FirstAddress = reinterpret_cast<uintptr_t>(g_FirstTensor.data_ptr()),
					g_SecondAddress = reinterpret_cast<uintptr_t>(g_SecondTensor.data_ptr());
	const uintptr_t FirstByteCount = uintptr_t(g_FirstTensor.numel()),
					SecondByteCount = uintptr_t(g_SecondTensor.numel());
	TORCH_CHECK(g_FirstAddress <= std::numeric_limits<uintptr_t>::max() - FirstByteCount &&
					g_SecondAddress <= std::numeric_limits<uintptr_t>::max() - SecondByteCount,
				"C512 physical range overflow");
	TORCH_CHECK(g_FirstAddress + FirstByteCount <= g_SecondAddress ||
					g_SecondAddress + SecondByteCount <= g_FirstAddress,
				"C512 supplied physical buffers must be pairwise disjoint");
}

void ValidateAllDisjoint(const std::vector<const at::Tensor*>& g_Buffers)
{
	for (size_t g_BufferIndex = 0; g_BufferIndex < g_Buffers.size(); ++g_BufferIndex)
		for (size_t g_OtherBufferIndex = g_BufferIndex + 1; g_OtherBufferIndex < g_Buffers.size();
			 ++g_OtherBufferIndex)
			ValidateDisjoint(*g_Buffers[g_BufferIndex], *g_Buffers[g_OtherBufferIndex]);
}

int GetDeviceIndex(const at::Tensor& g_Tensor)
{
	const int DeviceIndex = g_Tensor.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64, "C512 device outside preparation table");
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	TORCH_CHECK(DeviceProperties.major == 12 && DeviceProperties.minor == 0,
				"reconstructed C512 requires SM120");
	return DeviceIndex;
}

// Named host bindings describe the operation; Parameters remains the exact native ABI.
struct FLaunchArguments
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

template <class TParameters, EKernelRole KernelRole>
void LaunchWithParameters(const void* Function, dim3 Grid, dim3 Block, cudaStream_t Stream,
						  const FLaunchArguments& Bindings, int AbiBytes)
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

	constexpr bool bHasResidual = KernelRole == EKernelRole::FfnProjection ||
								  KernelRole == EKernelRole::FfnProjectionInputView ||
								  KernelRole == EKernelRole::AttentionProjection ||
								  KernelRole == EKernelRole::AttentionProjectionOutputView ||
								  KernelRole == EKernelRole::AttentionProjectionPool;
	if constexpr (bHasResidual)
		ParameterBlock.g_Residual = Bindings.g_Residual;
	if constexpr (KernelRole == EKernelRole::FfnExpansion ||
				  KernelRole == EKernelRole::FfnExpansionInputView || KernelRole == EKernelRole::QkvAttention)
	{
		ParameterBlock.OriginX = Bindings.OriginX;
		ParameterBlock.OriginY = Bindings.OriginY;
	}
	if constexpr (KernelRole == EKernelRole::AttentionProjectionPool)
	{
		ParameterBlock.g_DownsampledOutput = Bindings.g_DownsampledOutput;
		ParameterBlock.DownsampledHeight = Bindings.DownsampledHeight;
		ParameterBlock.DownsampledWidth = Bindings.DownsampledWidth;
	}
	void* KernelArguments[] = {&ParameterBlock};
	C10_CUDA_CHECK(cudaLaunchKernel(Function, Grid, Block, KernelArguments, 0, Stream));
}
} // namespace detail

// Returns 18 rows of [entry,device,SM,registers,shared,local,maxThreads].
// Explicit loading/admission is outside capture even when already prepared.
std::vector<int64_t> PrepareEntries(const at::Tensor& g_DeviceAnchor)
{
	TORCH_CHECK(g_DeviceAnchor.is_cuda(), "C512 preparation requires CUDA");
	c10::cuda::CUDAGuard DeviceGuard(g_DeviceAnchor.device());
	const int DeviceIndex = detail::GetDeviceIndex(g_DeviceAnchor);
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	cudaStreamCaptureStatus CaptureStatus = cudaStreamCaptureStatusNone;
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream.stream(), &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"C512 preparation forbidden during capture, including cache hits");
	std::vector<int64_t> ResourceRows;
	ResourceRows.reserve(18 * 7);
	for (int EntryIndex = 0; EntryIndex < 18; ++EntryIndex)
	{
		const auto& EntrySpec = detail::GetEntryTable()[EntryIndex];
		cudaFuncAttributes FunctionAttributes{};
		C10_CUDA_CHECK(cudaFuncGetAttributes(&FunctionAttributes, EntrySpec.Function));
		TORCH_CHECK(FunctionAttributes.binaryVersion == 120,
					"C512 stub must resolve to the accepted SM120 device body");
		TORCH_CHECK(FunctionAttributes.maxThreadsPerBlock >= 32 * EntrySpec.Warps,
					"compiled C512 block admission");
		const int64_t ResourceRow[] = {EntryIndex,
									   DeviceIndex,
									   120,
									   FunctionAttributes.numRegs,
									   int64_t(FunctionAttributes.sharedSizeBytes),
									   int64_t(FunctionAttributes.localSizeBytes),
									   FunctionAttributes.maxThreadsPerBlock};
		ResourceRows.insert(ResourceRows.end(), std::begin(ResourceRow), std::end(ResourceRow));
	}
	auto& Preparation = detail::GetPreparationState();
	std::lock_guard<std::mutex> Lock(Preparation.Mutex);
	Preparation.Devices[DeviceIndex] = true;
	return ResourceRows;
}

// Inputs use public order state,record[,skip]; outputs high[,pool].
// All memory is caller-owned. No preparation, allocation, conversion, native
// module lookup, legacy computation, or fallback is performed by this route.
std::vector<at::Tensor> LaunchEntry(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
									std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
									int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry 0..17");
	const auto& EntrySpec = detail::GetEntryTable()[EntryIndex];
	const bool bChannelExpansion = EntrySpec.Role == detail::EKernelRole::ChannelExpansion,
			   bPooledOutput = EntrySpec.Role == detail::EKernelRole::AttentionProjectionPool,
			   bResidualInput = EntrySpec.Role == detail::EKernelRole::FfnProjection ||
								EntrySpec.Role == detail::EKernelRole::FfnProjectionInputView ||
								EntrySpec.Role == detail::EKernelRole::AttentionProjection ||
								EntrySpec.Role == detail::EKernelRole::AttentionProjectionOutputView ||
								bPooledOutput;
	TORCH_CHECK(g_Inputs.size() == size_t(bResidualInput ? 3 : 2) &&
					g_Outputs.size() == size_t(bPooledOutput ? 2 : 1),
				"C512 exact input/output roles");
	const auto& g_Input = g_Inputs[0];
	TORCH_CHECK(g_Input.is_cuda(), "C512 requires CUDA state");
	const bool bQualified4KField =
		Height == (bChannelExpansion ? 36 : 68) && Width == (bChannelExpansion ? 60 : 120);
	const bool bBoundedFp16 = EntrySpec.ElementBytes == 2 && Height == 16 && Width == 24;
	TORCH_CHECK(bQualified4KField || bBoundedFp16,
				"C512 fixed 4K field or separate bounded Half field required");
	TORCH_CHECK(WindowPhase >= 0 && WindowPhase <= 3 &&
					(EntrySpec.Role == detail::EKernelRole::QkvAttention || WindowPhase == 0),
				"phase belongs only to fused QKV/attention");
	const int64_t ImageBytes = Height * Width * 512 * EntrySpec.ElementBytes,
				  PoolHeight = ((Height + 7) / 8) * 4, PoolWidth = ((Width + 7) / 8) * 4;
	detail::ValidatePhysicalTensor(g_Input, ImageBytes, g_Input.device(), "state");
	detail::ValidatePhysicalTensor(g_Inputs[1], EntrySpec.RecordBytes, g_Input.device(), "record");
	if (bResidualInput)
		detail::ValidatePhysicalTensor(g_Inputs[2], ImageBytes, g_Input.device(), "skip");
	detail::ValidatePhysicalTensor(g_Outputs[0], bChannelExpansion ? 2 * ImageBytes : ImageBytes,
								   g_Input.device(), "high");
	if (bPooledOutput)
		detail::ValidatePhysicalTensor(g_Outputs[1], PoolHeight * PoolWidth * 512 * EntrySpec.ElementBytes,
									   g_Input.device(), "pool");
	std::vector<const at::Tensor*> g_Buffers;
	for (const auto& g_Tensor : g_Inputs)
		g_Buffers.push_back(&g_Tensor);
	for (const auto& g_Tensor : g_Outputs)
		g_Buffers.push_back(&g_Tensor);
	detail::ValidateAllDisjoint(g_Buffers);
	c10::cuda::CUDAGuard DeviceGuard(g_Input.device());
	const int DeviceIndex = g_Input.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64, "C512 device outside preparation table");
	{
		auto& Preparation = detail::GetPreparationState();
		std::lock_guard<std::mutex> Lock(Preparation.Mutex);
		TORCH_CHECK(Preparation.Devices[DeviceIndex],
					"prepare all reconstructed C512 entries outside capture first");
	}
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (const auto* g_Tensor : g_Buffers)
		c10::cuda::CUDACachingAllocator::recordStream(g_Tensor->storage().data_ptr(), Stream);
	const auto GetTensorAddress = [](const at::Tensor& g_Tensor)
	{ return uint64_t(reinterpret_cast<uintptr_t>(g_Tensor.data_ptr())); };
	const int ShiftX = (WindowPhase == 1 || WindowPhase == 2) ? 4 : 0;
	const int ShiftY = (WindowPhase == 1 || WindowPhase == 3) ? 4 : 0;
	const bool bQkvAttention = EntrySpec.Role == detail::EKernelRole::QkvAttention;
	const detail::FLaunchArguments Bindings{GetTensorAddress(g_Input),
											bResidualInput ? GetTensorAddress(g_Inputs[2]) : 0,
											GetTensorAddress(g_Outputs[0]),
											bPooledOutput ? GetTensorAddress(g_Outputs[1]) : 0,
											GetTensorAddress(g_Inputs[1]),
											int32_t(Height),
											int32_t(Width),
											bQkvAttention ? -ShiftX : 0,
											bQkvAttention ? -ShiftY : 0,
											bPooledOutput ? int32_t(PoolHeight) : 0,
											bPooledOutput ? int32_t(PoolWidth) : 0};
	const unsigned TilesX = unsigned((Width + 7) / 8), TilesY = unsigned((Height + 7) / 8);
	dim3 Grid(EntrySpec.Role == detail::EKernelRole::QkvAttention
				  ? unsigned((Width + ShiftX + 7) / 8)
				  : (bChannelExpansion ? 4 * TilesX
					 : (EntrySpec.Role == detail::EKernelRole::FfnExpansion ||
						EntrySpec.Role == detail::EKernelRole::FfnExpansionInputView)
						 ? TilesX
						 : 2 * TilesX),
			  EntrySpec.Role == detail::EKernelRole::QkvAttention ? unsigned((Height + ShiftY + 7) / 8)
																  : TilesY,
			  EntrySpec.Role == detail::EKernelRole::QkvAttention ? 4
			  : (EntrySpec.Role == detail::EKernelRole::FfnExpansion ||
				 EntrySpec.Role == detail::EKernelRole::FfnExpansionInputView)
				  ? 2
				  : 1);
	const dim3 Block(32, EntrySpec.Warps, 1);
	switch (EntryIndex)
	{
	case 0:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_c512_fp8::Parameters,
									 detail::EKernelRole::FfnExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 1:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_c512_fp16::Parameters,
									 detail::EKernelRole::FfnExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 2:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_input_view_c512_fp8::Parameters,
									 detail::EKernelRole::FfnExpansionInputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 3:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_input_view_c512_fp16::Parameters,
									 detail::EKernelRole::FfnExpansionInputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 4:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_projection_c512_fp8::Parameters,
									 detail::EKernelRole::FfnProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 5:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_ffn_projection_c512_fp16::Parameters,
									 detail::EKernelRole::FfnProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 6:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8::Parameters,
			detail::EKernelRole::FfnProjectionInputView>(EntrySpec.Function, Grid, Block, Stream.stream(),
														 Bindings, EntrySpec.AbiBytes);
		break;
	case 7:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16::Parameters,
			detail::EKernelRole::FfnProjectionInputView>(EntrySpec.Function, Grid, Block, Stream.stream(),
														 Bindings, EntrySpec.AbiBytes);
		break;
	case 8:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_qkv_c512_fp8::Parameters,
									 detail::EKernelRole::QkvAttention>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 9:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_qkv_c512_fp16::Parameters,
									 detail::EKernelRole::QkvAttention>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 10:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_attention_projection_c512_fp8::Parameters,
									 detail::EKernelRole::AttentionProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 11:
		detail::LaunchWithParameters<dlssnr::reconstructed::window_attention_projection_c512_fp16::Parameters,
									 detail::EKernelRole::AttentionProjection>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 12:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8::Parameters,
			detail::EKernelRole::AttentionProjectionOutputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 13:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16::Parameters,
			detail::EKernelRole::AttentionProjectionOutputView>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 14:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_pool_c512_fp8::Parameters,
			detail::EKernelRole::AttentionProjectionPool>(EntrySpec.Function, Grid, Block, Stream.stream(),
														  Bindings, EntrySpec.AbiBytes);
		break;
	case 15:
		detail::LaunchWithParameters<
			dlssnr::reconstructed::window_attention_projection_pool_c512_fp16::Parameters,
			detail::EKernelRole::AttentionProjectionPool>(EntrySpec.Function, Grid, Block, Stream.stream(),
														  Bindings, EntrySpec.AbiBytes);
		break;
	case 16:
		detail::LaunchWithParameters<dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8::Parameters,
									 detail::EKernelRole::ChannelExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	case 17:
		detail::LaunchWithParameters<dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16::Parameters,
									 detail::EKernelRole::ChannelExpansion>(
			EntrySpec.Function, Grid, Block, Stream.stream(), Bindings, EntrySpec.AbiBytes);
		break;
	default:
		TORCH_CHECK(false, "unreachable C512 entry");
	}
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	return g_Outputs;
}

// All 16 real C512 blocks, including the input/pooled/output boundaries.
// Records are layer0..3 (plus4 at block30). Workspaces are branches,FFN,
// attended,high (plus pool,down at block30); all are retained and returned.
std::vector<at::Tensor> BlockOutEntry(int64_t BlockIndex, bool bFp16, const at::Tensor& g_Input,
									  std::vector<at::Tensor> g_Records, std::vector<at::Tensor> g_Workspaces)
{
	TORCH_CHECK((BlockIndex >= 23 && BlockIndex <= 30) || (BlockIndex >= 40 && BlockIndex <= 47),
				"C512 actual blocks23..30/40..47 only");
	const bool bInputView = BlockIndex == 23, bDownsample = BlockIndex == 30, bOutputView = BlockIndex == 47;
	const int PrecisionOffset = bFp16 ? 1 : 0;
	TORCH_CHECK(g_Records.size() == size_t(bDownsample ? 5 : 4) &&
					g_Workspaces.size() == size_t(bDownsample ? 6 : 4),
				"C512 block complete retained roles");
	TORCH_CHECK(g_Input.is_cuda(), "C512 block state CUDA");
	const int64_t ImageBytes = 68 * 120 * 512 * (bFp16 ? 2 : 1);
	detail::ValidatePhysicalTensor(g_Input, ImageBytes, g_Input.device(), "block state");
	const std::array<int64_t, 5> RecordByteExtents{{bFp16 ? 1048576 : 524288, bFp16 ? 525312 : 263168,
													bFp16 ? 1704000 : 917568, bFp16 ? 525312 : 263168,
													bFp16 ? 1048592 : 524304}};
	std::vector<const at::Tensor*> g_Buffers{&g_Input};
	for (size_t g_RecordIndex = 0; g_RecordIndex < g_Records.size(); ++g_RecordIndex)
	{
		detail::ValidatePhysicalTensor(g_Records[g_RecordIndex], RecordByteExtents[g_RecordIndex],
									   g_Input.device(), "block record");
		g_Buffers.push_back(&g_Records[g_RecordIndex]);
	}
	for (size_t g_WorkspaceIndex = 0; g_WorkspaceIndex < g_Workspaces.size(); ++g_WorkspaceIndex)
	{
		const int64_t Bytes = g_WorkspaceIndex < 4
								  ? ImageBytes
								  : 36 * 60 * 512 * (bFp16 ? 2 : 1) * (g_WorkspaceIndex == 5 ? 2 : 1);
		detail::ValidatePhysicalTensor(g_Workspaces[g_WorkspaceIndex], Bytes, g_Input.device(),
									   "block workspace");
		g_Buffers.push_back(&g_Workspaces[g_WorkspaceIndex]);
	}
	detail::ValidateAllDisjoint(g_Buffers);
	LaunchEntry((bInputView ? 2 : 0) + PrecisionOffset, {g_Input, g_Records[0]}, {g_Workspaces[0]}, 68, 120,
				0);
	LaunchEntry((bInputView ? 6 : 4) + PrecisionOffset, {g_Workspaces[0], g_Records[1], g_Input},
				{g_Workspaces[1]}, 68, 120, 0);
	const int WindowPhase = int(BlockIndex < 31 ? (BlockIndex - 23) % 4 : (BlockIndex - 40) % 4);
	LaunchEntry(8 + PrecisionOffset, {g_Workspaces[1], g_Records[2]}, {g_Workspaces[2]}, 68, 120,
				WindowPhase);
	if (bDownsample)
	{
		LaunchEntry(14 + PrecisionOffset, {g_Workspaces[2], g_Records[3], g_Workspaces[1]},
					{g_Workspaces[3], g_Workspaces[4]}, 68, 120, 0);
		LaunchEntry(16 + PrecisionOffset, {g_Workspaces[4], g_Records[4]}, {g_Workspaces[5]}, 36, 60, 0);
	}
	else
		LaunchEntry((bOutputView ? 12 : 10) + PrecisionOffset,
					{g_Workspaces[2], g_Records[3], g_Workspaces[1]}, {g_Workspaces[3]}, 68, 120, 0);
	return g_Workspaces;
}

std::vector<int64_t> PrepareC512_fp8(const at::Tensor& g_DeviceAnchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 1,
				"C512 precision does not match _fp8 binding");
	return PrepareEntries(g_DeviceAnchor);
}

std::vector<at::Tensor> LaunchC512_fp8(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
									   std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
									   int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 1,
				"C512 precision does not match _fp8 binding");
	return LaunchEntry(EntryIndex, std::move(g_Inputs), std::move(g_Outputs), Height, Width, WindowPhase);
}

std::vector<at::Tensor> C512BlockOut_fp8(int64_t BlockIndex, const at::Tensor& g_Input,
										 std::vector<at::Tensor> g_Records,
										 std::vector<at::Tensor> g_Workspaces)
{
	return BlockOutEntry(BlockIndex, false, g_Input, std::move(g_Records), std::move(g_Workspaces));
}

std::vector<int64_t> PrepareC512_fp16(const at::Tensor& g_DeviceAnchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 2,
				"C512 precision does not match _fp16 binding");
	return PrepareEntries(g_DeviceAnchor);
}

std::vector<at::Tensor> LaunchC512_fp16(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
										std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
										int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 18, "C512 entry outside catalog");
	TORCH_CHECK(detail::GetEntryTable()[EntryIndex].ElementBytes == 2,
				"C512 precision does not match _fp16 binding");
	return LaunchEntry(EntryIndex, std::move(g_Inputs), std::move(g_Outputs), Height, Width, WindowPhase);
}

std::vector<at::Tensor> C512BlockOut_fp16(int64_t BlockIndex, const at::Tensor& g_Input,
										  std::vector<at::Tensor> g_Records,
										  std::vector<at::Tensor> g_Workspaces)
{
	return BlockOutEntry(BlockIndex, true, g_Input, std::move(g_Records), std::move(g_Workspaces));
}
} // namespace dlssnr::reconstructed_c512
