#pragma once
#include <ATen/ATen.h>
#include <cstdint>
#include <vector>

std::vector<int64_t> PrepareC512_fp8(const at::Tensor& DeviceAnchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchC512_fp8(int64_t EntryIndex, std::vector<at::Tensor> Inputs,
									   std::vector<at::Tensor> Outputs, int64_t Height, int64_t Width,
									   int64_t WindowPhase);
std::vector<at::Tensor> C512BlockOut_fp8(int64_t BlockIndex, const at::Tensor& Input,
										 std::vector<at::Tensor> Records, std::vector<at::Tensor> Workspaces);
std::vector<int64_t> PrepareC512_fp16(const at::Tensor& DeviceAnchor, int64_t EntryIndex);
std::vector<at::Tensor> LaunchC512_fp16(int64_t EntryIndex, std::vector<at::Tensor> Inputs,
										std::vector<at::Tensor> Outputs, int64_t Height, int64_t Width,
										int64_t WindowPhase);
std::vector<at::Tensor> C512BlockOut_fp16(int64_t BlockIndex, const at::Tensor& Input,
										  std::vector<at::Tensor> Records,
										  std::vector<at::Tensor> Workspaces);
