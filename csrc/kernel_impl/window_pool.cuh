#pragma once
#include "warp_window32.cuh"

namespace dlssnr::kernels::window_pool
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::kernels::window32;

__device__ __forceinline__ uint32_t PoolHorizontalWords(uint32_t r_LeftLow, uint32_t r_LeftHigh,
														uint32_t r_RightLow, uint32_t r_RightHigh)
{
	// Pooling two adjacent 4x4 tiles yields two rows of a 4x4 destination.
	// Route tile-X and source-row-half into the lanes used by four gathers.
	// Swapping lane bits 2 and 3 changes the token grid from 4-wide to 2-wide;
	// XOR 4/16 then selects the horizontal/vertical neighbors of each 2x2 cell.
	const int r_Lane = threadIdx.x;
	if (r_Lane & 4)
	{
		const uint32_t r_SavedLeftLowerRows = r_LeftLow, r_SavedLeftUpperRows = r_LeftHigh;
		r_LeftLow = r_RightLow;
		r_RightLow = r_SavedLeftLowerRows;
		r_LeftHigh = r_RightHigh;
		r_RightHigh = r_SavedLeftUpperRows;
	}
	if (r_Lane & 16)
	{
		const uint32_t r_SavedLeftWord = r_LeftLow, r_SavedRightWord = r_RightLow;
		r_LeftLow = r_LeftHigh;
		r_RightLow = r_RightHigh;
		r_LeftHigh = r_SavedLeftWord;
		r_RightHigh = r_SavedRightWord;
	}
	const int r_SourceLane = (r_Lane & 19) | ((r_Lane << 1) & 8) | ((r_Lane >> 1) & 4);
	const uint32_t r_TopLeft = ShuffleIdx(r_LeftLow, r_SourceLane, 31, 0xffffffffu);
	const uint32_t r_TopRight = ShuffleIdx(r_RightLow, r_SourceLane ^ 4, 31, 0xffffffffu);
	const uint32_t r_BottomLeft = ShuffleIdx(r_LeftHigh, r_SourceLane ^ 16, 31, 0xffffffffu);
	const uint32_t r_BottomRight = ShuffleIdx(r_RightHigh, r_SourceLane ^ 20, 31, 0xffffffffu);
	// Keep three rounded Half additions and a rounded quarter multiply; neither
	// FP32 averaging nor pooling an already published E4 image is equivalent.
	return HalfMul(HalfAdd(HalfAdd(r_TopLeft, r_TopRight), HalfAdd(r_BottomLeft, r_BottomRight)),
				   CONST_HALF2_QUARTER);
}

__device__ __forceinline__ uint32_t PoolHorizontalTiles(const FAccumulatorTile<32>& r_Left,
														const FAccumulatorTile<32>& r_Right, int r_Column)
{
	return PoolHorizontalWords(r_Left.r_Pair[r_Column][0], r_Left.r_Pair[r_Column][1],
							   r_Right.r_Pair[r_Column][0], r_Right.r_Pair[r_Column][1]);
}

__device__ __forceinline__ FAccumulatorTile<32> PoolWindow(const FAccumulatorTile<32> (&r_InputTiles)[4])
{
	FAccumulatorTile<32> r_Pooled;
#pragma unroll
	for (int r_Column = 0; r_Column < 4; ++r_Column)
	{
		r_Pooled.r_Pair[r_Column][0] = PoolHorizontalTiles(r_InputTiles[0], r_InputTiles[1], r_Column);
		r_Pooled.r_Pair[r_Column][1] = PoolHorizontalTiles(r_InputTiles[2], r_InputTiles[3], r_Column);
	}
	return r_Pooled;
}
#endif
} // namespace dlssnr::kernels::window_pool
