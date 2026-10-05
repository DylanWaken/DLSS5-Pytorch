#pragma once
#include <ATen/ATen.h>
#include <cstdint>
#include <vector>

std::vector<int64_t> PrepareC512_fp8(const at::Tensor& g_DeviceAnchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchC512_fp8(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
									   std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
									   int64_t WindowPhase);
std::vector<at::Tensor> C512BlockOut_fp8(int64_t BlockIndex, const at::Tensor& g_Input,
										 std::vector<at::Tensor> g_Records,
										 std::vector<at::Tensor> g_Workspaces);
std::vector<int64_t> PrepareC512_fp16(const at::Tensor& g_DeviceAnchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchC512_fp16(int64_t EntryIndex, std::vector<at::Tensor> g_Inputs,
										std::vector<at::Tensor> g_Outputs, int64_t Height, int64_t Width,
										int64_t WindowPhase);
std::vector<at::Tensor> C512BlockOut_fp16(int64_t BlockIndex, const at::Tensor& g_Input,
										  std::vector<at::Tensor> g_Records,
										  std::vector<at::Tensor> g_Workspaces);
