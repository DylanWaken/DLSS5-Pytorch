// Grouped CUDA body emission only. Host dispatch lives in the shared C++ TU.
#include "kernel_impl/channel_projection_c512_to_c1024_fp8.cuh"
#include "kernel_impl/channel_projection_c512_to_c1024_fp16.cuh"
#include "kernel_impl/window_attention_projection_output_view_c512_fp8.cuh"
#include "kernel_impl/window_attention_projection_output_view_c512_fp16.cuh"
#include "kernel_impl/window_attention_projection_pool_c512_fp8.cuh"
#include "kernel_impl/window_attention_projection_pool_c512_fp16.cuh"
