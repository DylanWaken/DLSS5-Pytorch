#pragma once
#include <cstdint>
#include <cstddef>

// Host-only declarations for retained CUDA translation units.
// Do not include reconstructed device implementation headers here.
// cudaLaunchKernel receives &kernel and a pointer to one Parameters value.
// Parameter zero initialization, launch admission, pointer lifetime, counter
// resets and producer readiness remain responsibilities of the caller.

// Source: csrc/kernel_impl/c1024_ffn_expand_fp8_reconstructed_ops.cuh.draft
// SHA256: c284023fc5f2df3b25c7c549f2ec9848a9290894168bb7ae35cbda08d6543e76
namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);
void global_ffn_expand_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8

// Source: csrc/kernel_impl/c1024_ffn_expand_half_reconstructed_ops.cuh.draft
// SHA256: c49cbadb862cda2fc99ae7dcd2709461f913790e073db544343d99cc60622fac
namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);
void global_ffn_expand_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16

// Source: csrc/kernel_impl/c1024_ffn_contract_fp8_reconstructed_ops.cuh.draft
// SHA256: c7d3571f02410104fc513590006b67d93cf3da7a93e049aae9eb6a19103777d3
namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);
void global_ffn_contract_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8

// Source: csrc/kernel_impl/c1024_ffn_contract_half_reconstructed_ops.cuh.draft
// SHA256: 21b941d4160cb7d320c306b7b0b7d5ae248e10c1fb15be1be4b9872a7f4105eb
namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);
void global_ffn_contract_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16

// Source: csrc/kernel_impl/c1024_qkv_fp8_reconstructed_ops.cuh.draft
// SHA256: 526198825a49b231c1ae417a870bceb69a8093f4d25e63f8c0e98cbf38846b4c
namespace dlssnr::reconstructed::global_qkv_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Q, g_K, g_V, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Q) == 8 &&
			  offsetof(Parameters, g_K) == 16);
static_assert(offsetof(Parameters, g_V) == 24 && offsetof(Parameters, g_Record) == 32 &&
			  offsetof(Parameters, g_Counter) == 40);
static_assert(offsetof(Parameters, g_Scratch) == 48 && offsetof(Parameters, Reserved0) == 56 &&
			  offsetof(Parameters, Reserved1) == 64);
static_assert(offsetof(Parameters, Batch) == 72 && offsetof(Parameters, Tokens) == 76);
void global_qkv_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp8

// Source: csrc/kernel_impl/c1024_qkv_half_reconstructed_ops.cuh.draft
// SHA256: f208471e154d7dd2cfad53c19ffec1d3299475d577b3d140c015984434f274b6
namespace dlssnr::reconstructed::global_qkv_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Q, g_K, g_V, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Q) == 8 &&
			  offsetof(Parameters, g_K) == 16);
static_assert(offsetof(Parameters, g_V) == 24 && offsetof(Parameters, g_Record) == 32 &&
			  offsetof(Parameters, g_Counter) == 40);
static_assert(offsetof(Parameters, g_Scratch) == 48 && offsetof(Parameters, Reserved0) == 56 &&
			  offsetof(Parameters, Reserved1) == 64);
static_assert(offsetof(Parameters, Batch) == 72 && offsetof(Parameters, Tokens) == 76);
void global_qkv_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp16

// Source: csrc/kernel_impl/c1024_attention_chained_fp8_reconstructed_ops.cuh.draft
// SHA256: 8aee43ac1f5fd1d0c68bf29c878cd77eed19c54fec011227465647caf8fa2199
namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Q, g_K, g_V, g_High, Reserved, g_PredecessorCounter, g_CompletionCounter;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 64 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Q) == 0 && offsetof(Parameters, g_K) == 8 &&
			  offsetof(Parameters, g_V) == 16);
static_assert(offsetof(Parameters, g_High) == 24 && offsetof(Parameters, Reserved) == 32);
static_assert(offsetof(Parameters, g_PredecessorCounter) == 40 &&
			  offsetof(Parameters, g_CompletionCounter) == 48);
static_assert(offsetof(Parameters, Batch) == 56 && offsetof(Parameters, Tokens) == 60);
void global_attention_chained_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8

// Source: csrc/kernel_impl/c1024_attention_chained_half_reconstructed_ops.cuh.draft
// SHA256: 183318d68513686878967976c29667d4000d9b18efe43aa5ae46abf0370e06f2
namespace dlssnr::reconstructed::global_attention_chained_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Q, g_K, g_V, g_High, Reserved, g_PredecessorCounter, g_CompletionCounter;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 64 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Q) == 0 && offsetof(Parameters, g_K) == 8 &&
			  offsetof(Parameters, g_V) == 16);
static_assert(offsetof(Parameters, g_High) == 24 && offsetof(Parameters, Reserved) == 32);
static_assert(offsetof(Parameters, g_PredecessorCounter) == 40 &&
			  offsetof(Parameters, g_CompletionCounter) == 48);
static_assert(offsetof(Parameters, Batch) == 56 && offsetof(Parameters, Tokens) == 60);
void global_attention_chained_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp16

// Source: csrc/kernel_impl/c1024_projection_fp8_reconstructed_ops.cuh.draft
// SHA256: 2bc14b24d8159c9e493985bf1a716050161e8842236f0562ef05619b53cbec00
namespace dlssnr::reconstructed::global_projection_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);
void global_projection_c1024_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_projection_c1024_fp8

// Source: csrc/kernel_impl/c1024_projection_half_reconstructed_ops.cuh.draft
// SHA256: 24cb6a67767fa77c12a5ab07430b75d0ea37d5ce6815ba982c1396ba015b83da
namespace dlssnr::reconstructed::global_projection_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);
void global_projection_c1024_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::global_projection_c1024_fp16
