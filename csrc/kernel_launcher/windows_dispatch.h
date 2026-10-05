#pragma once
#include <ATen/ATen.h>
#include <c10/util/Optional.h>
#include <array>
#include <cstdint>
#include <vector>

// Include windows_dispatch.inl once from the consolidated launcher C++ TU.
// This header is sufficient for the separate consolidated Torch API TU.
namespace dlssnr::reconstructed_windows
{
enum class EPrecision : int
{
	Fp8 = 0,
	Fp16 = 1
};
enum class EKind : int
{
	Ordinary = 0,
	InputView = 1,
	OutputView = 2,
	Down = 3,
	Up = 4
};

struct FBufferRequirements
{
	int64_t StateBytes, RecordBytes, HighBytes, DownBytes, SkipBytes;
	int32_t LowHeight, LowWidth;
	std::array<unsigned, 3> Grid, Block;
};

int EntryId(int Channels, EPrecision PrecisionValue, EKind KindValue);
const char* OriginalSymbol(int EntryIndex);
const void* KernelStub(int EntryIndex);
FBufferRequirements GetBufferRequirements(int EntryIndex, int64_t Height, int64_t Width, int64_t Phase);
std::vector<int64_t> PrepareWindow_fp8(const at::Tensor& g_Anchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchWindow_fp8(int64_t EntryIndex, const at::Tensor& g_State,
										 const at::Tensor& g_Record, at::Tensor g_High,
										 const c10::optional<at::Tensor>& g_Down,
										 const c10::optional<at::Tensor>& g_Skip, int64_t Height,
										 int64_t Width, int64_t Phase);
std::vector<int64_t> PrepareWindow_fp16(const at::Tensor& g_Anchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchWindow_fp16(int64_t EntryIndex, const at::Tensor& g_State,
										  const at::Tensor& g_Record, at::Tensor g_High,
										  const c10::optional<at::Tensor>& g_Down,
										  const c10::optional<at::Tensor>& g_Skip, int64_t Height,
										  int64_t Width, int64_t Phase);
} // namespace dlssnr::reconstructed_windows
