#pragma once
#include "../../shared/common/kernel_abi.h"

// Additive Small31 attention entries. They reuse the recovered chained
// attention records unchanged, so a host selects the persistent-FP32 variant
// only by symbol name and never by a different parameter layout.
#if !defined(__CUDACC__)
// NVCC provides this translation unit's entry stubs; device definitions retain
// their attributes. Host launchers include this header for the exact signatures.
extern "C" void small_global_attention_chained_c1024_fp16(FGlobalAttentionChainedC1024Fp16Parameters Parameters);
extern "C" void small_global_attention_chained_c1024_fp8(FGlobalAttentionChainedC1024Fp8Parameters Parameters);
#endif
