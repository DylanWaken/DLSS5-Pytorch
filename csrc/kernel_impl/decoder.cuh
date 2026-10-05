#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// Decoder connector: split-K4 projection 1024->512, nearest 2x upsample, scaled skip.
// CTA computes one 4x4 low-resolution tile and 256 output channels in two warps.
namespace dlssnr::kernels::decoder
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
using namespace dlssnr::packed_math::sm120;
using FAccumulator = dlssnr::tiles::sm120::FAccumulatorTile<1, 8>;

template <bool bFp8> struct FProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 256 / ReductionStep;
	static constexpr int MatrixBytes = 1024 * 512 * ElementBytes;
	static constexpr auto Precision =
		bFp8 ? dlssnr::mma::sm120::EInputPrecision::Fp8 : dlssnr::mma::sm120::EInputPrecision::Fp16;
};

struct FCoordinates
{
	int g_LowTilesHigh, g_LowTilesWide, g_HighTilesHigh, g_HighTilesWide;
	int g_TileY, g_TileX, g_OutputChannel, g_GridColumns;
	int r_Split, r_Lane, r_Warp;
};

template <bool bFp8>
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[2][8], uint64_t g_PackedWeights,
											int r_ReductionTile, const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_WeightTileBase =
		g_PackedWeights +
		uint64_t(r_TileCoordinates.r_Split * 256 + r_ReductionTile * Profile::ReductionStep) * 512 *
			Profile::ElementBytes +
		r_TileCoordinates.g_OutputChannel * 32 + r_TileCoordinates.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			r_Weights[r_KSubtile][r_NTile] =
				__ldca(reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 16384 + r_NTile * 512));
}

template <bool bFp8>
__device__ __forceinline__ void IssueStage(unsigned char* s_Storage, uint64_t g_Input, int r_ReductionTile,
										   const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const int g_Y = r_TileCoordinates.g_LowTilesHigh == 1 ? 0 : r_TileCoordinates.g_TileY;
	const int g_X = r_TileCoordinates.g_LowTilesWide == 1 ? 0 : r_TileCoordinates.g_TileX;
	const int s_Destination = (r_ReductionTile % 2) * 1024 + r_TileCoordinates.r_Warp * 512;
	const int s_Barrier = 2048 + (r_ReductionTile % 2) * 8;
	if (g_Y < r_TileCoordinates.g_LowTilesHigh && g_X < r_TileCoordinates.g_LowTilesWide)
	{
		const uint64_t g_Source =
			g_Input + uint64_t(g_Y * r_TileCoordinates.g_LowTilesWide + g_X) * 16384 * Profile::ElementBytes +
			r_TileCoordinates.r_Split * 4096 * Profile::ElementBytes +
			(r_ReductionTile * 2 + r_TileCoordinates.r_Warp) * 512;
		if (Elected(0xffffffffu))
		{
			CopyBulk(s_Storage, s_Destination, g_Source, 512, s_Barrier);
			BarrierExpect(s_Storage, s_Barrier, 512);
		}
	}
	else
		*reinterpret_cast<uint4*>(s_Storage + s_Destination + r_TileCoordinates.r_Lane * 16) =
			make_uint4(0, 0, 0, 0);
}

__device__ __forceinline__ void WaitStage(unsigned char* s_Storage, int r_ReductionTile)
{
	const int s_Barrier = 2048 + (r_ReductionTile % 2) * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

template <bool bFp8>
__device__ __forceinline__ void Project(FAccumulator& r_Accumulator, unsigned char* s_Storage,
										uint64_t g_Input, uint64_t g_PackedWeights,
										const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	uint4 r_Weights[2][8];
	LoadWeights<bFp8>(r_Weights, g_PackedWeights, 0, r_TileCoordinates);
	IssueStage<bFp8>(s_Storage, g_Input, 0, r_TileCoordinates);
	WaitStage(s_Storage, 0);
#pragma unroll 1
	for (int r_ReductionTile = 0; r_ReductionTile < Profile::ReductionTiles; ++r_ReductionTile)
	{
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
			IssueStage<bFp8>(s_Storage, g_Input, r_ReductionTile + 1, r_TileCoordinates);
		uint4 r_Input[1][2];
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			r_Input[0][r_KSubtile] = *reinterpret_cast<const uint4*>(
				s_Storage + (r_ReductionTile % 2) * 1024 + r_KSubtile * 512 + r_TileCoordinates.r_Lane * 16);
		dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights<bFp8>(r_Weights, g_PackedWeights, r_ReductionTile + 1, r_TileCoordinates);
			WaitStage(s_Storage, r_ReductionTile + 1);
		}
	}
}

// Scratch is Half in both precisions. Split 0 stores, splits 1/2 reduce, and
// split 3 adds the prior sum in registers. Scratch never receives split 3.
__device__ __forceinline__ void ReduceSplit(FAccumulator& r_Accumulator, uint64_t g_SplitAccumulator,
											const FCoordinates& r_TileCoordinates)
{
	if (r_TileCoordinates.r_Split < 3)
	{
		if (r_TileCoordinates.g_TileY >= r_TileCoordinates.g_LowTilesHigh ||
			r_TileCoordinates.g_TileX >= r_TileCoordinates.g_LowTilesWide)
			return;
		const uint64_t g_SplitAccumulatorTile =
			g_SplitAccumulator +
			uint64_t(r_TileCoordinates.g_TileY * r_TileCoordinates.g_LowTilesWide +
					 r_TileCoordinates.g_TileX) *
				16384 +
			r_TileCoordinates.g_OutputChannel * 32 + r_TileCoordinates.r_Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			const auto& r_OutputWords = r_Accumulator.r_AccumulatorWords[0][r_NTile];
			const uint4 r_SplitAccumulatorVector =
				make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
			if (r_TileCoordinates.r_Split == 0)
				StoreNoAllocate(g_SplitAccumulatorTile + r_NTile * 512, r_SplitAccumulatorVector);
			else
				ReduceHalf4(g_SplitAccumulatorTile + r_NTile * 512, r_SplitAccumulatorVector);
		}
	}
	else
	{
		const int g_Y = r_TileCoordinates.g_LowTilesHigh == 1 ? 0 : r_TileCoordinates.g_TileY;
		const int g_X = r_TileCoordinates.g_LowTilesWide == 1 ? 0 : r_TileCoordinates.g_TileX;
		const bool r_bValid =
			g_Y < r_TileCoordinates.g_LowTilesHigh && g_X < r_TileCoordinates.g_LowTilesWide;
		const uint64_t g_SplitAccumulatorTile =
			g_SplitAccumulator + uint64_t(g_Y * r_TileCoordinates.g_LowTilesWide + g_X) * 16384 +
			r_TileCoordinates.g_OutputChannel * 32 + r_TileCoordinates.r_Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			const uint4 r_PreviousSplitWords =
				r_bValid ? __ldca(reinterpret_cast<const uint4*>(g_SplitAccumulatorTile + r_NTile * 512))
						 : make_uint4(0, 0, 0, 0);
			auto& r_OutputWords = r_Accumulator.r_AccumulatorWords[0][r_NTile];
			r_OutputWords[0] = HalfAdd(r_PreviousSplitWords.x, r_OutputWords[0]);
			r_OutputWords[1] = HalfAdd(r_PreviousSplitWords.y, r_OutputWords[1]);
			r_OutputWords[2] = HalfAdd(r_PreviousSplitWords.z, r_OutputWords[2]);
			r_OutputWords[3] = HalfAdd(r_PreviousSplitWords.w, r_OutputWords[3]);
		}
	}
}

template <bool bFp8>
__device__ __forceinline__ void UpsampleAndMerge(const FAccumulator& r_Projected, uint64_t g_Residual,
												 uint64_t g_Output, uint64_t g_PackedWeights,
												 const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	uint32_t r_ResidualScales[8][2];
#pragma unroll
	for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_ResidualScales[r_NTile][r_N8] =
				*reinterpret_cast<const uint32_t*>(g_PackedWeights + Profile::MatrixBytes +
												   (r_TileCoordinates.g_OutputChannel + r_NTile * 16 +
													r_N8 * 8 + (r_TileCoordinates.r_Lane & 3) * 2) *
													   2);

	// A low 4x4 tile expands into four high 4x4 tiles. Indexed lane shuffles
	// duplicate each low pixel in X/Y while preserving packed channel ownership.
#pragma unroll
	for (int r_Quadrant = 0; r_Quadrant < 4; ++r_Quadrant)
	{
		const int g_OffsetY = r_Quadrant / 2, g_OffsetX = r_Quadrant % 2;
		const int g_OutputY = r_TileCoordinates.g_TileY * 2 + g_OffsetY,
				  g_OutputX = r_TileCoordinates.g_TileX * 2 + g_OffsetX;
		const int g_SkipY = r_TileCoordinates.g_HighTilesHigh == 1 ? 0 : g_OutputY;
		const int g_SkipX = r_TileCoordinates.g_HighTilesWide == 1 ? 0 : g_OutputX;
		const bool r_bValidSkip =
			g_SkipY < r_TileCoordinates.g_HighTilesHigh && g_SkipX < r_TileCoordinates.g_HighTilesWide;
		const uint64_t g_SkipBase =
			g_Residual +
			uint64_t(g_SkipY * r_TileCoordinates.g_HighTilesWide + g_SkipX) * 8192 * Profile::ElementBytes +
			r_TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes + r_TileCoordinates.r_Lane * 16;
		uint32_t r_Output[8][4];
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			uint32_t r_ResidualPairs[4];
			if constexpr (bFp8)
			{
				const uint4 r_PackedResidual =
					r_bValidSkip ? __ldca(reinterpret_cast<const uint4*>(g_SkipBase + (r_NTile / 2) * 512))
								 : make_uint4(0, 0, 0, 0);
				const uint32_t r_PackedResidualWords[4] = {r_PackedResidual.x, r_PackedResidual.y,
														   r_PackedResidual.z, r_PackedResidual.w};
				const uint32_t r_LowerWords = r_PackedResidualWords[(r_NTile % 2) * 2],
							   r_UpperWords = r_PackedResidualWords[(r_NTile % 2) * 2 + 1];
				r_ResidualPairs[0] = DecodeE4(uint16_t(r_LowerWords));
				r_ResidualPairs[1] = DecodeE4(uint16_t(r_UpperWords));
				r_ResidualPairs[2] = DecodeE4(uint16_t(r_LowerWords >> 16));
				r_ResidualPairs[3] = DecodeE4(uint16_t(r_UpperWords >> 16));
			}
			else
			{
				const uint4 r_PackedResidual =
					r_bValidSkip ? __ldca(reinterpret_cast<const uint4*>(g_SkipBase + r_NTile * 512))
								 : make_uint4(0, 0, 0, 0);
				r_ResidualPairs[0] = r_PackedResidual.x;
				r_ResidualPairs[1] = r_PackedResidual.y;
				r_ResidualPairs[2] = r_PackedResidual.z;
				r_ResidualPairs[3] = r_PackedResidual.w;
			}
#pragma unroll
			for (int r_N8 = 0; r_N8 < 2; ++r_N8)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int r_SourceLane = (r_TileCoordinates.r_Lane & 3) |
											 ((r_TileCoordinates.r_Lane >> 1) & 4) | (g_OffsetX * 8) |
											 (r_RowHalf * 16);
					const uint32_t r_Nearest =
						ShuffleIdx(r_Projected.r_AccumulatorWords[0][r_NTile][r_N8 * 2 + g_OffsetY],
								   r_SourceLane, 31, 0xffffffffu);
					r_Output[r_NTile][r_N8 * 2 + r_RowHalf] =
						HalfAdd(r_Nearest, HalfMul(r_ResidualPairs[r_N8 * 2 + r_RowHalf],
												   r_ResidualScales[r_NTile][r_N8]));
				}
		}
		if (g_OutputY >= r_TileCoordinates.g_HighTilesHigh || g_OutputX >= r_TileCoordinates.g_HighTilesWide)
			continue;
		const uint64_t g_OutputBase = g_Output +
									  uint64_t(g_OutputY * r_TileCoordinates.g_HighTilesWide + g_OutputX) *
										  8192 * Profile::ElementBytes +
									  r_TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes +
									  r_TileCoordinates.r_Lane * 16;
#pragma unroll
		for (int r_Panel = 0; r_Panel < (bFp8 ? 4 : 8); ++r_Panel)
		{
			uint4 r_Published;
			if constexpr (bFp8)
			{
				const auto& r_LowerWords = r_Output[r_Panel * 2];
				const auto& r_UpperWords = r_Output[r_Panel * 2 + 1];
				r_Published = make_uint4(PackHalfPairsE4(r_LowerWords[0], r_LowerWords[2]),
										 PackHalfPairsE4(r_LowerWords[1], r_LowerWords[3]),
										 PackHalfPairsE4(r_UpperWords[0], r_UpperWords[2]),
										 PackHalfPairsE4(r_UpperWords[1], r_UpperWords[3]));
			}
			else
			{
				const auto& r_OutputWords = r_Output[r_Panel];
				r_Published =
					make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
			}
			StoreNoAllocate(g_OutputBase + r_Panel * 512, r_Published);
		}
	}
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void Forward(const TParameters& r_Parameters, unsigned char* s_Storage)
{
	const int g_Columns = (r_Parameters.InputWidth + 3) / 4;
	const FCoordinates r_TileCoordinates{r_Parameters.InputHeight / 4,
										 r_Parameters.InputWidth / 4,
										 r_Parameters.OutputHeight / 4,
										 r_Parameters.OutputWidth / 4,
										 int(blockIdx.y),
										 int(blockIdx.x) % g_Columns,
										 (int(blockIdx.x) / g_Columns) * 256 + int(threadIdx.y) * 128,
										 g_Columns,
										 int(blockIdx.z),
										 int(threadIdx.x),
										 int(threadIdx.y)};
	const uint64_t g_SplitAccumulator = r_Parameters.g_SplitAccumulator;
	const uint64_t g_SplitCounters =
		r_Parameters.g_CompletionCounters + (r_TileCoordinates.g_TileY * 2 * g_Columns + blockIdx.x) * 4;
	if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
	{
		BarrierInit(s_Storage, 2048, 64);
		BarrierInit(s_Storage, 2056, 64);
	}
	__syncthreads();
	FAccumulator r_Accumulator{};
	Project<bFp8>(r_Accumulator, s_Storage, r_Parameters.g_Input, r_Parameters.g_PackedWeights,
				  r_TileCoordinates);
	if (r_TileCoordinates.r_Split > 0)
	{
		if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_SplitCounters)) < r_TileCoordinates.r_Split - 1)
				PollSleep(64);
		__syncthreads();
	}
	ReduceSplit(r_Accumulator, g_SplitAccumulator, r_TileCoordinates);
	if (r_TileCoordinates.r_Split == 3)
		UpsampleAndMerge<bFp8>(r_Accumulator, r_Parameters.g_Residual, r_Parameters.g_Output,
							   r_Parameters.g_PackedWeights, r_TileCoordinates);
	__syncthreads();
	if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
		CounterStoreRelease(g_SplitCounters, r_TileCoordinates.r_Split);
}
#endif
} // namespace dlssnr::kernels::decoder
