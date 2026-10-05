#pragma once
// Both directions of the global physical-layout repack, using shared templates.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"
#include "global_repack_layout.cuh"

// Entry profiles in this file:
//   repack_1d_to_2d_c1024_fp16
//   repack_2d_to_1d_c1024_fp16

// -----------------------------------------------------------------------------
// repack_1d_to_2d_c1024_fp16
// -----------------------------------------------------------------------------
// Exact original kernel definition; shared physical-layout algebra lives in the included header.

extern "C" __global__ void repack_1d_to_2d_c1024_fp16(FGlobalRepackParameters Parameters)
{
	CopyGlobalRepackWords<false, false>(Parameters);
}

// -----------------------------------------------------------------------------
// repack_2d_to_1d_c1024_fp16
// -----------------------------------------------------------------------------
// Exact original kernel definition; shared physical-layout algebra lives in the included header.

extern "C" __global__ void repack_2d_to_1d_c1024_fp16(FGlobalRepackParameters Parameters)
{
	CopyGlobalRepackWords<false, true>(Parameters);
}
