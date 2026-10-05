#pragma once
// Plain C++ declarations of retained NVCC host stubs. No kernel definitions,
// CUDA/Torch includes, new translation unit, or changed device code.
// A cudaLaunchKernel argument array contains ONE pointer to the whole record:
//     Parameters p{}; void* args[] = {&p};
// Do not include these declarations together with the original device headers.
#include <cstddef>
#include <cstdint>

namespace dlssnr::reconstructed::global_repack_layout
{
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	int32_t Height;
	int32_t Width;
};

static_assert(sizeof(Parameters) == 24 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Input) == 0 && offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, Height) == 16 && offsetof(Parameters, Width) == 20);

struct alignas(8) ClearParameters
{
	uint64_t g_Counters;
	int32_t Count;
	int32_t Reserved;
};

static_assert(sizeof(ClearParameters) == 16 && alignof(ClearParameters) == 8);
static_assert(offsetof(ClearParameters, g_Counters) == 0 && offsetof(ClearParameters, Count) == 8);
static_assert(offsetof(ClearParameters, Reserved) == 12);
// Repack: 1024 channels, H/W nonnegative multiples of4 <=16384; pad32 FP8,
// pad16 Half. words/token=256/512; padded_tokens*words <= INT32_MAX/2.
// Grid=(padded_tokens*words/256,1,1), block=(256,1,1), dynamic shared=0.
// Clear: count is int32 WORDS; grid=(ceil(count/256),1,1), block=(256,1,1).
// Zero extents return without launch. Clear writes -1, not zero.
// Same-stream ordering and disjoint repack buffers are caller obligations.
} // namespace dlssnr::reconstructed::global_repack_layout

namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
void repack_2d_to_1d_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8

namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
void repack_1d_to_2d_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8

namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp16
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
void repack_2d_to_1d_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp16

namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp16
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
void repack_1d_to_2d_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp16

namespace dlssnr::reconstructed::completion_counter_clear
{
using ClearParameters = dlssnr::reconstructed::global_repack_layout::ClearParameters;
void completion_counter_clear(ClearParameters ParameterBlock);
} // namespace dlssnr::reconstructed::completion_counter_clear

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_P0, g_P8, g_P16, P24, g_P32, P40, g_P48, g_P56;
	int32_t I64, I68, I72, I76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_P0) == 0 && offsetof(Parameters, g_P8) == 8);
static_assert(offsetof(Parameters, g_P16) == 16 && offsetof(Parameters, P24) == 24);
static_assert(offsetof(Parameters, g_P32) == 32 && offsetof(Parameters, P40) == 40);
static_assert(offsetof(Parameters, g_P48) == 48 && offsetof(Parameters, g_P56) == 56);
static_assert(offsetof(Parameters, I64) == 64 && offsetof(Parameters, I68) == 68);
static_assert(offsetof(Parameters, I72) == 72 && offsetof(Parameters, I76) == 76);
void decoder_upsample_c1024_to_c512_fp8(Parameters ParameterBlock);
// p0 low, p8 skip, p16 high, p32 counter, p48 scratch, p56 record.
// p24/p40 unread: zero initialize. i64/i68/i72/i76 =36/60/68/120.
// Grid=(30,9,4), block=(32,2,1), dynamic shared=0; SM120 only.
// Reset270 int32 counter words to -1 before EVERY invocation/replay.
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_P0, g_P8, g_P16, g_P24, g_P32, P40, P48, g_P56;
	int32_t I64, I68, I72, I76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_P0) == 0 && offsetof(Parameters, g_P8) == 8);
static_assert(offsetof(Parameters, g_P16) == 16 && offsetof(Parameters, g_P24) == 24);
static_assert(offsetof(Parameters, g_P32) == 32 && offsetof(Parameters, P40) == 40);
static_assert(offsetof(Parameters, P48) == 48 && offsetof(Parameters, g_P56) == 56);
static_assert(offsetof(Parameters, I64) == 64 && offsetof(Parameters, I68) == 68);
static_assert(offsetof(Parameters, I72) == 72 && offsetof(Parameters, I76) == 76);
void decoder_upsample_c1024_to_c512_fp16(Parameters ParameterBlock);
// p0 low, p8 skip, p16 high, p24 scratch, p32 counter, p56 record.
// p40/p48 unread: zero initialize. Fixed pilot i64/i68/i72/i76=8/8/16/16.
// Grid=(4,2,4), block=(32,2,1), dynamic shared=0; SM120 only.
// Reset8 int32 counter words to -1 before EVERY invocation/replay.
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16

// Both up512 kernels: all six allocations pairwise disjoint; input/skip/record
// immutable, high/counter/scratch mutable. Data/record/scratch alignment16,
// counter alignment4. Before capture query the EXACT retained function's
// cudaFuncGetAttributes and cudaOccupancyMaxActiveBlocksPerMultiprocessor at
// block64/dynamic0: maxThreads>=64 and activeBlocks*SMcount >=1080 FP8 or32 Half.
// Requery for a newly linked artifact; source caps are not capacity evidence.
// No hidden reset or predecessor pointer. Final counter3; scratch retains only
// z0+z1+z2. Keep every backing allocation alive through stream/graph completion.
// Half remains an independent bounded pilot, not full-field deployment evidence.
