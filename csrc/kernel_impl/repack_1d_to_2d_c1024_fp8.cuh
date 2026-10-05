#pragma once
#include "global_repack_layout.cuh"

// Exact original kernel definition; shared physical-layout algebra lives in the included header.
namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
using dlssnr::reconstructed::global_repack_layout::CopyWords;

__global__ void repack_1d_to_2d_c1024_fp8(Parameters r_P)
{
	CopyWords<true, false>(r_P);
}
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8
