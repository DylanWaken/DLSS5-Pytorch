#pragma once
#include "windows_dispatch.h"
#include "kernel_abi.h"
#include <cuda_runtime_api.h>
#include <c10/cuda/CUDAGuard.h>
#include <c10/cuda/CUDAStream.h>
#include <c10/cuda/CUDAException.h>
#include <c10/cuda/CUDACachingAllocator.h>
#include <cstring>
#include <limits>
#include <mutex>

namespace dlssnr::reconstructed_windows
{
namespace detail
{
struct FKernelEntry
{
	int Channels;
	EPrecision PrecisionValue;
	EKind KindValue;
	int ParameterBytes;
	int64_t RecordBytes;
	const char* Symbol;
	const void* Stub;
};

#include "windows_entries.inl"
constexpr int EntryCount = sizeof(EntryTable) / sizeof(EntryTable[0]);
static_assert(EntryCount == 38);

const FKernelEntry& GetEntrySpec(int EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < EntryCount, "reconstructed window entry outside catalog");
	return EntryTable[EntryIndex];
}

struct FDeviceState
{
	std::array<bool, EntryCount> bReady{};
	std::array<unsigned, 3> MaxGrid{};
};

struct FPreparedEntries
{
	std::mutex Mutex;
	std::array<FDeviceState, 64> Devices{};
};

FPreparedEntries& GetPreparationState()
{
	static FPreparedEntries PreparationState;
	return PreparationState;
}

int GetCudaDeviceIndex(const at::Tensor& g_DeviceAnchor)
{
	TORCH_CHECK(g_DeviceAnchor.is_cuda(), "reconstructed windows require CUDA tensors");
	const int DeviceIndex = g_DeviceAnchor.get_device();
	TORCH_CHECK(DeviceIndex >= 0 && DeviceIndex < 64,
				"reconstructed windows device index outside preparation table");
	return DeviceIndex;
}

void ValidatePhysicalTensor(const at::Tensor& g_Tensor, int64_t Bytes, const at::Device& TensorDevice,
							const char* Name)
{
	TORCH_CHECK(g_Tensor.is_cuda() && g_Tensor.device() == TensorDevice &&
					g_Tensor.scalar_type() == at::kByte,
				Name, " requires uint8 physical storage on the selected CUDA device");
	TORCH_CHECK(g_Tensor.dim() == 1 && g_Tensor.is_contiguous() && g_Tensor.numel() == Bytes, Name,
				" requires exact contiguous physical extent ", Bytes);
	TORCH_CHECK(reinterpret_cast<uintptr_t>(g_Tensor.data_ptr()) % 16 == 0, Name,
				" requires 16-byte alignment");
	TORCH_CHECK(!g_Tensor.requires_grad(), "reconstructed windows are inference only");
}

void ValidateDisjoint(const at::Tensor& g_FirstTensor, const at::Tensor& g_SecondTensor)
{
	const auto g_FirstAddress = reinterpret_cast<uintptr_t>(g_FirstTensor.data_ptr()),
			   g_SecondAddress = reinterpret_cast<uintptr_t>(g_SecondTensor.data_ptr());
	const auto FirstByteCount = uintptr_t(g_FirstTensor.numel()),
			   SecondByteCount = uintptr_t(g_SecondTensor.numel());
	TORCH_CHECK(g_FirstAddress <= std::numeric_limits<uintptr_t>::max() - FirstByteCount &&
					g_SecondAddress <= std::numeric_limits<uintptr_t>::max() - SecondByteCount,
				"reconstructed window physical range overflow");
	TORCH_CHECK(g_FirstAddress + FirstByteCount <= g_SecondAddress ||
					g_SecondAddress + SecondByteCount <= g_FirstAddress,
				"reconstructed window buffers must be pairwise disjoint");
}

template <class TValue>
void WriteParameterField(std::array<uint8_t, 96>& ParameterBlock, size_t FieldOffset, TValue FieldValue)
{
	TORCH_CHECK(FieldOffset + sizeof(TValue) <= ParameterBlock.size(), "window parameter field overflow");
	std::memcpy(ParameterBlock.data() + FieldOffset, &FieldValue, sizeof(FieldValue));
}

// This is a byte representation of exactly one by-value Parameters argument.
// The generated stub header proves each accepted struct's size and offsets.
std::array<uint8_t, 96> BuildParameterBlock(const FKernelEntry& EntrySpec,
											const FBufferRequirements& BufferRequirements,
											uintptr_t g_InputAddress, uintptr_t g_PackedWeightsAddress,
											uintptr_t g_OutputAddress, uintptr_t g_DownsampledOutputAddress,
											uintptr_t g_ResidualAddress, int32_t Height, int32_t Width,
											int WindowPhase)
{
	std::array<uint8_t, 96> ParameterBlock{};
	WriteParameterField<uint64_t>(ParameterBlock, 0, g_InputAddress);
	WriteParameterField<uint64_t>(ParameterBlock, 8, g_OutputAddress);
	WriteParameterField<uint64_t>(ParameterBlock, 16, g_PackedWeightsAddress);
	const size_t InputDimensionsOffset = EntrySpec.Channels == 32 ? 24 : 32;
	const int32_t ShiftX = (WindowPhase == 1 || WindowPhase == 2) ? 4 : 0;
	const int32_t ShiftY = (WindowPhase == 1 || WindowPhase == 3) ? 4 : 0;
	WriteParameterField<int32_t>(ParameterBlock, InputDimensionsOffset, Height);
	WriteParameterField<int32_t>(ParameterBlock, InputDimensionsOffset + 4, Width);
	WriteParameterField<int32_t>(ParameterBlock, InputDimensionsOffset + 8, -ShiftX);
	WriteParameterField<int32_t>(ParameterBlock, InputDimensionsOffset + 12, -ShiftY);
	if (EntrySpec.KindValue == EKind::InputView || EntrySpec.KindValue == EKind::OutputView)
	{
		const size_t ViewDimensionsOffset = EntrySpec.Channels == 32 ? 72 : 80;
		WriteParameterField<int32_t>(ParameterBlock, ViewDimensionsOffset, Height);
		WriteParameterField<int32_t>(ParameterBlock, ViewDimensionsOffset + 4, Width);
	}
	else if (EntrySpec.KindValue == EKind::Down)
	{
		const size_t DownsampledOutputOffset = EntrySpec.Channels == 32 ? 64 : 72;
		WriteParameterField<uint64_t>(ParameterBlock, DownsampledOutputOffset, g_DownsampledOutputAddress);
		WriteParameterField<int32_t>(ParameterBlock, DownsampledOutputOffset + 8,
									 BufferRequirements.DownsampledHeight);
		WriteParameterField<int32_t>(ParameterBlock, DownsampledOutputOffset + 12,
									 BufferRequirements.DownsampledWidth);
	}
	else if (EntrySpec.KindValue == EKind::Up)
	{
		WriteParameterField<uint64_t>(ParameterBlock, EntrySpec.Channels == 32 ? 80 : 24, g_ResidualAddress);
		if (EntrySpec.Channels == 32)
		{
			WriteParameterField<int32_t>(ParameterBlock, 88, Height);
			WriteParameterField<int32_t>(ParameterBlock, 92, Width);
		}
	}
	return ParameterBlock;
}
} // namespace detail

int EntryId(int Channels, EPrecision PrecisionValue, EKind KindValue)
{
	for (int EntryIndex = 0; EntryIndex < detail::EntryCount; ++EntryIndex)
	{
		const auto& EntrySpec = detail::EntryTable[EntryIndex];
		if (EntrySpec.Channels == Channels && EntrySpec.PrecisionValue == PrecisionValue &&
			EntrySpec.KindValue == KindValue)
			return EntryIndex;
	}
	TORCH_CHECK(false, "no selected reconstructed window entry for requested family/configuration");
}

const char* OriginalSymbol(int EntryIndex)
{
	return detail::GetEntrySpec(EntryIndex).Symbol;
}

const void* KernelStub(int EntryIndex)
{
	return detail::GetEntrySpec(EntryIndex).Stub;
}

FBufferRequirements GetBufferRequirements(int EntryIndex, int64_t Height, int64_t Width, int64_t WindowPhase)
{
	const auto& EntrySpec = detail::GetEntrySpec(EntryIndex);
	TORCH_CHECK(Height >= 8 && Height <= 8192 && Width >= 8 && Width <= 8192 && Height % 4 == 0 &&
					Width % 4 == 0,
				"reconstructed window dimensions require multiples of4 in[8,8192]");
	TORCH_CHECK(WindowPhase >= 0 && WindowPhase <= 3, "reconstructed window phase must be0..3");
	const int64_t ElementBytes = EntrySpec.PrecisionValue == EPrecision::Fp16 ? 2 : 1;
	const int64_t OutputBytes = Height * Width * int64_t(EntrySpec.Channels) * ElementBytes;
	TORCH_CHECK(OutputBytes < (int64_t(1) << 31),
				"reconstructed window byte address exceeds signed32 admission");
	const int64_t DownsampledHeight = (((Height + 1) / 2) + 3) / 4 * 4,
				  DownsampledWidth = (((Width + 1) / 2) + 3) / 4 * 4;
	const int64_t DownsampledBytes =
		DownsampledHeight * DownsampledWidth * int64_t(2 * EntrySpec.Channels) * ElementBytes;
	TORCH_CHECK(DownsampledBytes < (int64_t(1) << 31),
				"reconstructed window low byte address exceeds signed32 admission");
	// Existing pilots and the complete4K chain use exact-half DS fields.
	// Original padded clear extents differ by precision/family; do not guess.
	TORCH_CHECK(EntrySpec.KindValue != EKind::Down ||
					(Height == 2 * DownsampledHeight && Width == 2 * DownsampledWidth),
				"padded reconstructed window downsample is not yet admitted");
	const unsigned ShiftX = (WindowPhase == 1 || WindowPhase == 2) ? 4 : 0,
				   ShiftY = (WindowPhase == 1 || WindowPhase == 3) ? 4 : 0;
	return {EntrySpec.KindValue == EKind::Up ? DownsampledBytes : OutputBytes,
			EntrySpec.RecordBytes,
			OutputBytes,
			EntrySpec.KindValue == EKind::Down ? DownsampledBytes : 0,
			EntrySpec.KindValue == EKind::Up ? OutputBytes : 0,
			int32_t(DownsampledHeight),
			int32_t(DownsampledWidth),
			{unsigned((Width + ShiftX + 7) / 8), unsigned((Height + ShiftY + 7) / 8), 1},
			{32, unsigned(EntrySpec.Channels / 32), 1}};
}

std::vector<int64_t> PrepareEntry(const at::Tensor& g_DeviceAnchor, int EntryIndex)
{
	const auto& EntrySpec = detail::GetEntrySpec(EntryIndex);
	const int DeviceIndex = detail::GetCudaDeviceIndex(g_DeviceAnchor);
	c10::cuda::CUDAGuard DeviceGuard(g_DeviceAnchor.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	cudaStreamCaptureStatus CaptureStatus = cudaStreamCaptureStatusNone;
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream.stream(), &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone,
				"window prepare is forbidden during capture including cache hits");
	cudaDeviceProp DeviceProperties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&DeviceProperties, DeviceIndex));
	TORCH_CHECK(DeviceProperties.major == 12 && DeviceProperties.minor == 0,
				"reconstructed window device bodies require SM120");
	cudaFuncAttributes FunctionAttributes{};
	C10_CUDA_CHECK(cudaFuncGetAttributes(&FunctionAttributes, EntrySpec.Stub));
	TORCH_CHECK(FunctionAttributes.binaryVersion == 120,
				"reconstructed window stub did not resolve to SM120 code");
	TORCH_CHECK(FunctionAttributes.maxThreadsPerBlock >= EntrySpec.Channels,
				"reconstructed window function cannot launch required block");
	auto& Preparation = detail::GetPreparationState();
	std::lock_guard<std::mutex> Lock(Preparation.Mutex);
	auto& DevicePreparation = Preparation.Devices[DeviceIndex];
	DevicePreparation.MaxGrid = {unsigned(DeviceProperties.maxGridSize[0]),
								 unsigned(DeviceProperties.maxGridSize[1]),
								 unsigned(DeviceProperties.maxGridSize[2])};
	DevicePreparation.bReady[EntryIndex] = true;
	return {EntryIndex,
			DeviceIndex,
			120,
			FunctionAttributes.numRegs,
			int64_t(FunctionAttributes.sharedSizeBytes),
			int64_t(FunctionAttributes.localSizeBytes),
			FunctionAttributes.maxThreadsPerBlock};
}

std::vector<at::Tensor> LaunchEntry(int EntryIndex, const at::Tensor& g_Input,
									const at::Tensor& g_PackedWeights, at::Tensor g_Output,
									const c10::optional<at::Tensor>& g_DownsampledOutput,
									const c10::optional<at::Tensor>& g_Residual, int64_t Height,
									int64_t Width, int64_t WindowPhase)
{
	const auto& EntrySpec = detail::GetEntrySpec(EntryIndex);
	const auto BufferRequirements = GetBufferRequirements(EntryIndex, Height, Width, WindowPhase);
	const int DeviceIndex = detail::GetCudaDeviceIndex(g_Input);
	TORCH_CHECK(g_DownsampledOutput.has_value() == (EntrySpec.KindValue == EKind::Down),
				"down output role does not match reconstructed entry");
	TORCH_CHECK(g_Residual.has_value() == (EntrySpec.KindValue == EKind::Up),
				"skip input role does not match reconstructed entry");
	detail::ValidatePhysicalTensor(g_Input, BufferRequirements.InputBytes, g_Input.device(), "state");
	detail::ValidatePhysicalTensor(g_PackedWeights, BufferRequirements.RecordBytes, g_Input.device(),
								   "record");
	detail::ValidatePhysicalTensor(g_Output, BufferRequirements.OutputBytes, g_Input.device(), "high");
	std::vector<const at::Tensor*> g_Buffers{&g_Input, &g_PackedWeights, &g_Output};
	if (g_DownsampledOutput)
	{
		detail::ValidatePhysicalTensor(*g_DownsampledOutput, BufferRequirements.DownsampledOutputBytes,
									   g_Input.device(), "down");
		g_Buffers.push_back(&*g_DownsampledOutput);
	}
	if (g_Residual)
	{
		detail::ValidatePhysicalTensor(*g_Residual, BufferRequirements.ResidualBytes, g_Input.device(),
									   "skip");
		g_Buffers.push_back(&*g_Residual);
	}
	for (size_t g_BufferIndex = 0; g_BufferIndex < g_Buffers.size(); ++g_BufferIndex)
		for (size_t g_OtherBufferIndex = g_BufferIndex + 1; g_OtherBufferIndex < g_Buffers.size();
			 ++g_OtherBufferIndex)
			detail::ValidateDisjoint(*g_Buffers[g_BufferIndex], *g_Buffers[g_OtherBufferIndex]);
	c10::cuda::CUDAGuard DeviceGuard(g_Input.device());
	{
		auto& Preparation = detail::GetPreparationState();
		std::lock_guard<std::mutex> Lock(Preparation.Mutex);
		const auto& DevicePreparation = Preparation.Devices[DeviceIndex];
		TORCH_CHECK(DevicePreparation.bReady[EntryIndex],
					"call reconstructed window prepare outside capture first");
		for (int Axis = 0; Axis < 3; ++Axis)
			TORCH_CHECK(BufferRequirements.Grid[Axis] <= DevicePreparation.MaxGrid[Axis],
						"reconstructed window grid exceeds selected device axis");
	}
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	for (const auto* g_Tensor : g_Buffers)
		c10::cuda::CUDACachingAllocator::recordStream(g_Tensor->storage().data_ptr(), Stream);
	alignas(8) auto ParameterBlock = detail::BuildParameterBlock(
		EntrySpec, BufferRequirements, reinterpret_cast<uintptr_t>(g_Input.data_ptr()),
		reinterpret_cast<uintptr_t>(g_PackedWeights.data_ptr()),
		reinterpret_cast<uintptr_t>(g_Output.data_ptr()),
		g_DownsampledOutput ? reinterpret_cast<uintptr_t>(g_DownsampledOutput->data_ptr()) : 0,
		g_Residual ? reinterpret_cast<uintptr_t>(g_Residual->data_ptr()) : 0, int32_t(Height), int32_t(Width),
		int(WindowPhase));
	void* KernelArguments[] = {ParameterBlock.data()};
	C10_CUDA_CHECK(cudaLaunchKernel(
		EntrySpec.Stub,
		dim3(BufferRequirements.Grid[0], BufferRequirements.Grid[1], BufferRequirements.Grid[2]),
		dim3(BufferRequirements.Block[0], BufferRequirements.Block[1], BufferRequirements.Block[2]),
		KernelArguments, 0, Stream.stream()));
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	if (g_DownsampledOutput)
		return {g_Output, *g_DownsampledOutput};
	return {g_Output};
}

std::vector<int64_t> PrepareWindow_fp8(const at::Tensor& g_DeviceAnchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp8,
				"window precision does not match _fp8 binding");
	return PrepareEntry(g_DeviceAnchor, int(EntryIndex));
}

std::vector<at::Tensor> LaunchWindow_fp8(int64_t EntryIndex, const at::Tensor& g_Input,
										 const at::Tensor& g_PackedWeights, at::Tensor g_Output,
										 const c10::optional<at::Tensor>& g_DownsampledOutput,
										 const c10::optional<at::Tensor>& g_Residual, int64_t Height,
										 int64_t Width, int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp8,
				"window precision does not match _fp8 binding");
	return LaunchEntry(int(EntryIndex), g_Input, g_PackedWeights, g_Output, g_DownsampledOutput, g_Residual,
					   Height, Width, WindowPhase);
}

std::vector<int64_t> PrepareWindow_fp16(const at::Tensor& g_DeviceAnchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp16,
				"window precision does not match _fp16 binding");
	return PrepareEntry(g_DeviceAnchor, int(EntryIndex));
}

std::vector<at::Tensor> LaunchWindow_fp16(int64_t EntryIndex, const at::Tensor& g_Input,
										  const at::Tensor& g_PackedWeights, at::Tensor g_Output,
										  const c10::optional<at::Tensor>& g_DownsampledOutput,
										  const c10::optional<at::Tensor>& g_Residual, int64_t Height,
										  int64_t Width, int64_t WindowPhase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp16,
				"window precision does not match _fp16 binding");
	return LaunchEntry(int(EntryIndex), g_Input, g_PackedWeights, g_Output, g_DownsampledOutput, g_Residual,
					   Height, Width, WindowPhase);
}
} // namespace dlssnr::reconstructed_windows
