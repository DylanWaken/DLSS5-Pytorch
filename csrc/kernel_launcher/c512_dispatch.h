#pragma once
#include <ATen/ATen.h>
#include <cstdint>
#include <vector>

namespace dlssnr::reconstructed_c512
{
std::vector<int64_t> PrepareC512_fp8(const at::Tensor& g_Anchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchC512_fp8(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
									   std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
									   int64_t Phase);
std::vector<at::Tensor> C512BlockOut_fp8(int64_t Block, const at::Tensor& g_State,
										 std::vector<at::Tensor> g_Records,
										 std::vector<at::Tensor> g_Workspaces);
std::vector<int64_t> PrepareC512_fp16(const at::Tensor& g_Anchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchC512_fp16(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
										std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
										int64_t Phase);
std::vector<at::Tensor> C512BlockOut_fp16(int64_t Block, const at::Tensor& g_State,
										  std::vector<at::Tensor> g_Records,
										  std::vector<at::Tensor> g_Workspaces);
} // namespace dlssnr::reconstructed_c512
