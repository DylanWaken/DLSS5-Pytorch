// Grouped CUDA body emission only. Host dispatch lives in the shared C++ TU.
#include "kernel_impl/window_ffn_c512_fp16.cuh"
#include "kernel_impl/window_ffn_input_view_c512_fp8.cuh"
#include "kernel_impl/window_ffn_input_view_c512_fp16.cuh"
#include "kernel_impl/window_ffn_projection_c512_fp8.cuh"
#include "kernel_impl/window_ffn_projection_c512_fp16.cuh"
#include "kernel_impl/window_ffn_projection_input_view_c512_fp8.cuh"
#include "kernel_impl/window_ffn_projection_input_view_c512_fp16.cuh"
#include "kernel_impl/window_ffn_c512_fp8.cuh"
