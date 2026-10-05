#pragma once
#include <ATen/ATen.h>
#include <c10/util/Optional.h>
#include <array>
#include <cstdint>
#include <vector>

// Include windows_dispatch.inl once from the consolidated launcher C++ TU.
// This header is sufficient for the separate consolidated Torch API TU.
enum class EWindowPrecision : int
{
	Fp8 = 0,
	Fp16 = 1
};
enum class EWindowKind : int
{
	Ordinary = 0,
	InputView = 1,
	OutputView = 2,
	Down = 3,
	Up = 4
};

struct FWindowBufferRequirements
{
	int64_t InputBytes, RecordBytes, OutputBytes, DownsampledOutputBytes, ResidualBytes;
	int32_t DownsampledHeight, DownsampledWidth;
	std::array<unsigned, 3> Grid, Block;
};

int WindowEntryId(int Channels, EWindowPrecision PrecisionValue, EWindowKind KindValue);
const char* WindowOriginalSymbol(int EntryIndex);
const void* WindowKernelStub(int EntryIndex);
FWindowBufferRequirements WindowGetBufferRequirements(int EntryIndex, int64_t Height, int64_t Width,
													  int64_t WindowPhase);
std::vector<int64_t> PrepareWindow_fp8(const at::Tensor& DeviceAnchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchWindow_fp8(int64_t EntryIndex, const at::Tensor& Input,
										 const at::Tensor& PackedWeights, at::Tensor Output,
										 const c10::optional<at::Tensor>& DownsampledOutput,
										 const c10::optional<at::Tensor>& Residual, int64_t Height,
										 int64_t Width, int64_t WindowPhase);
std::vector<int64_t> PrepareWindow_fp16(const at::Tensor& DeviceAnchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchWindow_fp16(int64_t EntryIndex, const at::Tensor& Input,
										  const at::Tensor& PackedWeights, at::Tensor Output,
										  const c10::optional<at::Tensor>& DownsampledOutput,
										  const c10::optional<at::Tensor>& Residual, int64_t Height,
										  int64_t Width, int64_t WindowPhase);
