#pragma once
#include "prepared_kernel.h"
#include <torch/library.h>

// Preparation is outside graph capture. Keep the owner alive through every graph
// using it; order invocations on the caller's CUDA streams. Textures are float32
// contiguous HWC4 tensors. Physical records/features are one-dimensional uint8.
// Preprocess inputs: [record, current, history, motion, depth, conditioning].
// Preprocess outputs: [features], or [features, pooled_features] for downsample.
// Postprocess inputs: [low_state, adapter, record, color, history, motion, blend_scale].
// Postprocess outputs: [rgba]. Optional textures are empty float32 tensors;
// optional blend_scale is an empty uint8 tensor or exactly two Half payload bytes.
// Configuration is a CPU uint8 copy of FPreprocessParameters/FPostprocessParameters
// with every pointer/handle zero; scalar fields remain fixed for the owner lifetime.
c10::intrusive_ptr<FPreparedKernelHandle> PrepareFrontend(std::string Name, at::Tensor Configuration,
														  std::vector<at::Tensor> Inputs,
														  std::vector<at::Tensor> Outputs,
														  bool bLinearFilter);
// Construct zero-pointer configuration with identity sampling and explicit geometry.
at::Tensor FrontendConfiguration(std::string Name, int64_t Height, int64_t Width, int64_t ValidHeight,
								 int64_t ValidWidth, int64_t Phase, int64_t Seed);
void RegisterFrontendKernels(torch::Library& Library);
