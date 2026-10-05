#pragma once
#include "windows_dispatch.h"
#include "windows_stubs.h"
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

const FKernelEntry& GetEntrySpec(int Index)
{
	TORCH_CHECK(Index >= 0 && Index < EntryCount, "reconstructed window entry outside catalog");
	return EntryTable[Index];
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
	static FPreparedEntries Value;
	return Value;
}

int GetCudaDeviceIndex(const at::Tensor& g_Anchor)
{
	TORCH_CHECK(g_Anchor.is_cuda(), "reconstructed windows require CUDA tensors");
	const int DeviceIndex = g_Anchor.get_device();
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

template <class TValue> void WriteParameterField(std::array<uint8_t, 96>& Bytes, size_t Offset, TValue Value)
{
	TORCH_CHECK(Offset + sizeof(TValue) <= Bytes.size(), "window parameter field overflow");
	std::memcpy(Bytes.data() + Offset, &Value, sizeof(Value));
}

// This is a byte representation of exactly one by-value Parameters argument.
// The generated stub header proves each accepted struct's size and offsets.
std::array<uint8_t, 96> BuildParameterBlock(const FKernelEntry& EntrySpec,
											const FBufferRequirements& BufferRequirements,
											uintptr_t g_StateAddress, uintptr_t g_RecordAddress,
											uintptr_t g_HighAddress, uintptr_t g_DownAddress,
											uintptr_t g_SkipAddress, int32_t Height, int32_t Width, int Phase)
{
	std::array<uint8_t, 96> ParameterBlock{};
	WriteParameterField<uint64_t>(ParameterBlock, 0, g_StateAddress);
	WriteParameterField<uint64_t>(ParameterBlock, 8, g_HighAddress);
	WriteParameterField<uint64_t>(ParameterBlock, 16, g_RecordAddress);
	const size_t DimensionOffset = EntrySpec.Channels == 32 ? 24 : 32;
	const int32_t ShiftX = (Phase == 1 || Phase == 2) ? 4 : 0;
	const int32_t ShiftY = (Phase == 1 || Phase == 3) ? 4 : 0;
	WriteParameterField<int32_t>(ParameterBlock, DimensionOffset, Height);
	WriteParameterField<int32_t>(ParameterBlock, DimensionOffset + 4, Width);
	WriteParameterField<int32_t>(ParameterBlock, DimensionOffset + 8, -ShiftX);
	WriteParameterField<int32_t>(ParameterBlock, DimensionOffset + 12, -ShiftY);
	if (EntrySpec.KindValue == EKind::InputView || EntrySpec.KindValue == EKind::OutputView)
	{
		const size_t AuxiliaryOffset = EntrySpec.Channels == 32 ? 72 : 80;
		WriteParameterField<int32_t>(ParameterBlock, AuxiliaryOffset, Height);
		WriteParameterField<int32_t>(ParameterBlock, AuxiliaryOffset + 4, Width);
	}
	else if (EntrySpec.KindValue == EKind::Down)
	{
		const size_t ExtraOffset = EntrySpec.Channels == 32 ? 64 : 72;
		WriteParameterField<uint64_t>(ParameterBlock, ExtraOffset, g_DownAddress);
		WriteParameterField<int32_t>(ParameterBlock, ExtraOffset + 8, BufferRequirements.LowHeight);
		WriteParameterField<int32_t>(ParameterBlock, ExtraOffset + 12, BufferRequirements.LowWidth);
	}
	else if (EntrySpec.KindValue == EKind::Up)
	{
		WriteParameterField<uint64_t>(ParameterBlock, EntrySpec.Channels == 32 ? 80 : 24, g_SkipAddress);
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
	for (int Index = 0; Index < detail::EntryCount; ++Index)
	{
		const auto& EntrySpec = detail::EntryTable[Index];
		if (EntrySpec.Channels == Channels && EntrySpec.PrecisionValue == PrecisionValue &&
			EntrySpec.KindValue == KindValue)
			return Index;
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

FBufferRequirements GetBufferRequirements(int EntryIndex, int64_t Height, int64_t Width, int64_t Phase)
{
	const auto& EntrySpec = detail::GetEntrySpec(EntryIndex);
	TORCH_CHECK(Height >= 8 && Height <= 8192 && Width >= 8 && Width <= 8192 && Height % 4 == 0 &&
					Width % 4 == 0,
				"reconstructed window dimensions require multiples of4 in[8,8192]");
	TORCH_CHECK(Phase >= 0 && Phase <= 3, "reconstructed window phase must be0..3");
	const int64_t ElementBytes = EntrySpec.PrecisionValue == EPrecision::Fp16 ? 2 : 1;
	const int64_t HighBytes = Height * Width * int64_t(EntrySpec.Channels) * ElementBytes;
	TORCH_CHECK(HighBytes < (int64_t(1) << 31),
				"reconstructed window byte address exceeds signed32 admission");
	const int64_t LowHeight = (((Height + 1) / 2) + 3) / 4 * 4, LowWidth = (((Width + 1) / 2) + 3) / 4 * 4;
	const int64_t LowBytes = LowHeight * LowWidth * int64_t(2 * EntrySpec.Channels) * ElementBytes;
	TORCH_CHECK(LowBytes < (int64_t(1) << 31),
				"reconstructed window low byte address exceeds signed32 admission");
	// Existing pilots and the complete4K chain use exact-half DS fields.
	// Original padded clear extents differ by precision/family; do not guess.
	TORCH_CHECK(EntrySpec.KindValue != EKind::Down || (Height == 2 * LowHeight && Width == 2 * LowWidth),
				"padded reconstructed window downsample is not yet admitted");
	const unsigned ShiftX = (Phase == 1 || Phase == 2) ? 4 : 0, ShiftY = (Phase == 1 || Phase == 3) ? 4 : 0;
	return {EntrySpec.KindValue == EKind::Up ? LowBytes : HighBytes,
			EntrySpec.RecordBytes,
			HighBytes,
			EntrySpec.KindValue == EKind::Down ? LowBytes : 0,
			EntrySpec.KindValue == EKind::Up ? HighBytes : 0,
			int32_t(LowHeight),
			int32_t(LowWidth),
			{unsigned((Width + ShiftX + 7) / 8), unsigned((Height + ShiftY + 7) / 8), 1},
			{32, unsigned(EntrySpec.Channels / 32), 1}};
}

std::vector<int64_t> PrepareEntry(const at::Tensor& g_Anchor, int EntryIndex)
{
	const auto& EntrySpec = detail::GetEntrySpec(EntryIndex);
	const int DeviceIndex = detail::GetCudaDeviceIndex(g_Anchor);
	c10::cuda::CUDAGuard DeviceGuard(g_Anchor.device());
	const auto Stream = c10::cuda::getCurrentCUDAStream(DeviceIndex);
	cudaStreamCaptureStatus Capture = cudaStreamCaptureStatusNone;
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream.stream(), &Capture));
	TORCH_CHECK(Capture == cudaStreamCaptureStatusNone,
				"window prepare is forbidden during capture including cache hits");
	cudaDeviceProp Properties{};
	C10_CUDA_CHECK(cudaGetDeviceProperties(&Properties, DeviceIndex));
	TORCH_CHECK(Properties.major == 12 && Properties.minor == 0,
				"reconstructed window device bodies require SM120");
	cudaFuncAttributes Attributes{};
	C10_CUDA_CHECK(cudaFuncGetAttributes(&Attributes, EntrySpec.Stub));
	TORCH_CHECK(Attributes.binaryVersion == 120, "reconstructed window stub did not resolve to SM120 code");
	TORCH_CHECK(Attributes.maxThreadsPerBlock >= EntrySpec.Channels,
				"reconstructed window function cannot launch required block");
	auto& Preparation = detail::GetPreparationState();
	std::lock_guard<std::mutex> Lock(Preparation.Mutex);
	auto& DevicePreparation = Preparation.Devices[DeviceIndex];
	DevicePreparation.MaxGrid = {unsigned(Properties.maxGridSize[0]), unsigned(Properties.maxGridSize[1]),
								 unsigned(Properties.maxGridSize[2])};
	DevicePreparation.bReady[EntryIndex] = true;
	return {EntryIndex,
			DeviceIndex,
			120,
			Attributes.numRegs,
			int64_t(Attributes.sharedSizeBytes),
			int64_t(Attributes.localSizeBytes),
			Attributes.maxThreadsPerBlock};
}

std::vector<at::Tensor> LaunchEntry(int EntryIndex, const at::Tensor& g_State, const at::Tensor& g_Record,
									at::Tensor g_High, const c10::optional<at::Tensor>& g_Down,
									const c10::optional<at::Tensor>& g_Skip, int64_t Height, int64_t Width,
									int64_t Phase)
{
	const auto& EntrySpec = detail::GetEntrySpec(EntryIndex);
	const auto BufferRequirements = GetBufferRequirements(EntryIndex, Height, Width, Phase);
	const int DeviceIndex = detail::GetCudaDeviceIndex(g_State);
	TORCH_CHECK(g_Down.has_value() == (EntrySpec.KindValue == EKind::Down),
				"down output role does not match reconstructed entry");
	TORCH_CHECK(g_Skip.has_value() == (EntrySpec.KindValue == EKind::Up),
				"skip input role does not match reconstructed entry");
	detail::ValidatePhysicalTensor(g_State, BufferRequirements.StateBytes, g_State.device(), "state");
	detail::ValidatePhysicalTensor(g_Record, BufferRequirements.RecordBytes, g_State.device(), "record");
	detail::ValidatePhysicalTensor(g_High, BufferRequirements.HighBytes, g_State.device(), "high");
	std::vector<const at::Tensor*> g_Buffers{&g_State, &g_Record, &g_High};
	if (g_Down)
	{
		detail::ValidatePhysicalTensor(*g_Down, BufferRequirements.DownBytes, g_State.device(), "down");
		g_Buffers.push_back(&*g_Down);
	}
	if (g_Skip)
	{
		detail::ValidatePhysicalTensor(*g_Skip, BufferRequirements.SkipBytes, g_State.device(), "skip");
		g_Buffers.push_back(&*g_Skip);
	}
	for (size_t Index = 0; Index < g_Buffers.size(); ++Index)
		for (size_t OtherIndex = Index + 1; OtherIndex < g_Buffers.size(); ++OtherIndex)
			detail::ValidateDisjoint(*g_Buffers[Index], *g_Buffers[OtherIndex]);
	c10::cuda::CUDAGuard DeviceGuard(g_State.device());
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
		EntrySpec, BufferRequirements, reinterpret_cast<uintptr_t>(g_State.data_ptr()),
		reinterpret_cast<uintptr_t>(g_Record.data_ptr()), reinterpret_cast<uintptr_t>(g_High.data_ptr()),
		g_Down ? reinterpret_cast<uintptr_t>(g_Down->data_ptr()) : 0,
		g_Skip ? reinterpret_cast<uintptr_t>(g_Skip->data_ptr()) : 0, int32_t(Height), int32_t(Width),
		int(Phase));
	void* Arguments[] = {ParameterBlock.data()};
	C10_CUDA_CHECK(cudaLaunchKernel(
		EntrySpec.Stub,
		dim3(BufferRequirements.Grid[0], BufferRequirements.Grid[1], BufferRequirements.Grid[2]),
		dim3(BufferRequirements.Block[0], BufferRequirements.Block[1], BufferRequirements.Block[2]),
		Arguments, 0, Stream.stream()));
	C10_CUDA_KERNEL_LAUNCH_CHECK();
	if (g_Down)
		return {g_High, *g_Down};
	return {g_High};
}

std::vector<int64_t> PrepareWindow_fp8(const at::Tensor& g_Anchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp8,
				"window precision does not match _fp8 binding");
	return PrepareEntry(g_Anchor, int(EntryIndex));
}

std::vector<at::Tensor> LaunchWindow_fp8(int64_t EntryIndex, const at::Tensor& g_State,
										 const at::Tensor& g_Record, at::Tensor g_High,
										 const c10::optional<at::Tensor>& g_Down,
										 const c10::optional<at::Tensor>& g_Skip, int64_t Height,
										 int64_t Width, int64_t Phase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp8,
				"window precision does not match _fp8 binding");
	return LaunchEntry(int(EntryIndex), g_State, g_Record, g_High, g_Down, g_Skip, Height, Width, Phase);
}

std::vector<int64_t> PrepareWindow_fp16(const at::Tensor& g_Anchor, int64_t EntryIndex)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp16,
				"window precision does not match _fp16 binding");
	return PrepareEntry(g_Anchor, int(EntryIndex));
}

std::vector<at::Tensor> LaunchWindow_fp16(int64_t EntryIndex, const at::Tensor& g_State,
										  const at::Tensor& g_Record, at::Tensor g_High,
										  const c10::optional<at::Tensor>& g_Down,
										  const c10::optional<at::Tensor>& g_Skip, int64_t Height,
										  int64_t Width, int64_t Phase)
{
	TORCH_CHECK(EntryIndex >= 0 && EntryIndex < 38, "window entry outside catalog");
	TORCH_CHECK(detail::GetEntrySpec(int(EntryIndex)).PrecisionValue == EPrecision::Fp16,
				"window precision does not match _fp16 binding");
	return LaunchEntry(int(EntryIndex), g_State, g_Record, g_High, g_Down, g_Skip, Height, Width, Phase);
}
} // namespace dlssnr::reconstructed_windows
