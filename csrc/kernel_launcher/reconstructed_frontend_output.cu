// Grouped CUDA body emission only. Host dispatch lives in the shared C++ TU.
#include "kernel_impl/window_block_c32_output_view_fp8.cuh"
#include "kernel_impl/window_block_c32_output_view_fp16.cuh"
#include "kernel_impl/output_window_postprocess_c32_fp8.cuh"
#include "kernel_impl/output_window_postprocess_c32_fp16.cuh"
#include "kernel_impl/input_preprocess_window_downsample_c32_fp8.cuh"
#include "kernel_impl/input_preprocess_window_downsample_c32_fp16.cuh"
#include "kernel_impl/input_preprocess_window_c32_fp8.cuh"
#include "kernel_impl/input_preprocess_window_c32_fp16.cuh"
