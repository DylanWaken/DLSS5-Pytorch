#pragma once
// Both directions of the global physical-layout repack, using shared templates.
// Native entry names remain stable; repeated graph calls reuse these definitions.
#include "kernel_helpers.cuh"
#include "global_repack_layout.cuh"

// Entry profiles in this file:
//   repack_1d_to_2d_c1024_fp8
//   repack_2d_to_1d_c1024_fp8

// -----------------------------------------------------------------------------
// repack_1d_to_2d_c1024_fp8
// -----------------------------------------------------------------------------
// Exact original kernel definition; shared physical-layout algebra lives in the included header.
namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
using dlssnr::reconstructed::global_repack_layout::CopyWords;

__global__ void repack_1d_to_2d_c1024_fp8(Parameters r_Parameters)
{
	CopyWords<true, false>(r_Parameters);
}
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8

// -----------------------------------------------------------------------------
// repack_2d_to_1d_c1024_fp8
// -----------------------------------------------------------------------------
// Exact original kernel definition; shared physical-layout algebra lives in the included header.
namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
using dlssnr::reconstructed::global_repack_layout::CopyWords;

__global__ void repack_2d_to_1d_c1024_fp8(Parameters r_Parameters)
{
	CopyWords<true, true>(r_Parameters);
}
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8
