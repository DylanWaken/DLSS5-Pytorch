// Grouped CUDA body emission only. Host dispatch lives in the shared C++ TU.
#include "kernel_impl/decoder_upsample_c1024_to_c512_fp8.cuh"
#include "kernel_impl/decoder_upsample_c1024_to_c512_fp16.cuh"
#include "kernel_impl/repack_2d_to_1d_c1024_fp8.cuh"
#include "kernel_impl/repack_1d_to_2d_c1024_fp8.cuh"
#include "kernel_impl/repack_2d_to_1d_c1024_fp16.cuh"
#include "kernel_impl/repack_1d_to_2d_c1024_fp16.cuh"
#include "kernel_impl/completion_counter_clear.cuh"
