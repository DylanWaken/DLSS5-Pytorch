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
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[2][8], uint64_t g_Record, int r_Step,
											const FCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_Base =
		g_Record +
		uint64_t(Tile.r_Split * 256 + r_Step * Profile::ReductionStep) * 512 * Profile::ElementBytes +
		Tile.g_OutputChannel * 32 + Tile.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			r_Weights[r_KSubtile][r_NTile] =
				__ldca(reinterpret_cast<const uint4*>(g_Base + r_KSubtile * 16384 + r_NTile * 512));
}

template <bool bFp8>
__device__ __forceinline__ void IssueStage(unsigned char* s_Storage, uint64_t g_Input, int r_Step,
										   const FCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const int g_Y = Tile.g_LowTilesHigh == 1 ? 0 : Tile.g_TileY;
	const int g_X = Tile.g_LowTilesWide == 1 ? 0 : Tile.g_TileX;
	const int s_Destination = (r_Step % 2) * 1024 + Tile.r_Warp * 512;
	const int s_Barrier = 2048 + (r_Step % 2) * 8;
	if (g_Y < Tile.g_LowTilesHigh && g_X < Tile.g_LowTilesWide)
	{
		const uint64_t g_Source =
			g_Input + uint64_t(g_Y * Tile.g_LowTilesWide + g_X) * 16384 * Profile::ElementBytes +
			Tile.r_Split * 4096 * Profile::ElementBytes + (r_Step * 2 + Tile.r_Warp) * 512;
		if (Elected(0xffffffffu))
		{
			CopyBulk(s_Storage, s_Destination, g_Source, 512, s_Barrier);
			BarrierExpect(s_Storage, s_Barrier, 512);
		}
	}
	else
		*reinterpret_cast<uint4*>(s_Storage + s_Destination + Tile.r_Lane * 16) = make_uint4(0, 0, 0, 0);
}

__device__ __forceinline__ void WaitStage(unsigned char* s_Storage, int r_Step)
{
	const int s_Barrier = 2048 + (r_Step % 2) * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

template <bool bFp8>
__device__ __forceinline__ void Project(FAccumulator& r_Accumulator, unsigned char* s_Storage,
										uint64_t g_Input, uint64_t g_Record, const FCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	uint4 r_Weights[2][8];
	LoadWeights<bFp8>(r_Weights, g_Record, 0, Tile);
	IssueStage<bFp8>(s_Storage, g_Input, 0, Tile);
	WaitStage(s_Storage, 0);
#pragma unroll 1
	for (int r_Step = 0; r_Step < Profile::ReductionTiles; ++r_Step)
	{
		if (r_Step + 1 < Profile::ReductionTiles)
			IssueStage<bFp8>(s_Storage, g_Input, r_Step + 1, Tile);
		uint4 r_Input[1][2];
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			r_Input[0][r_KSubtile] = *reinterpret_cast<const uint4*>(s_Storage + (r_Step % 2) * 1024 +
																	 r_KSubtile * 512 + Tile.r_Lane * 16);
		dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
		if (r_Step + 1 < Profile::ReductionTiles)
		{
			LoadWeights<bFp8>(r_Weights, g_Record, r_Step + 1, Tile);
			WaitStage(s_Storage, r_Step + 1);
		}
	}
}

// Scratch is Half in both precisions. Split 0 stores, splits 1/2 reduce, and
// split 3 adds the prior sum in registers. Scratch never receives split 3.
__device__ __forceinline__ void ReduceSplit(FAccumulator& r_Accumulator, uint64_t g_Scratch,
											const FCoordinates& Tile)
{
	if (Tile.r_Split < 3)
	{
		if (Tile.g_TileY >= Tile.g_LowTilesHigh || Tile.g_TileX >= Tile.g_LowTilesWide)
			return;
		const uint64_t g_Base = g_Scratch +
								uint64_t(Tile.g_TileY * Tile.g_LowTilesWide + Tile.g_TileX) * 16384 +
								Tile.g_OutputChannel * 32 + Tile.r_Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			const auto& r_C = r_Accumulator.r_Words[0][r_NTile];
			const uint4 r_Words = make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]);
			if (Tile.r_Split == 0)
				StoreNoAllocate(g_Base + r_NTile * 512, r_Words);
			else
				ReduceHalf4(g_Base + r_NTile * 512, r_Words);
		}
	}
	else
	{
		const int g_Y = Tile.g_LowTilesHigh == 1 ? 0 : Tile.g_TileY;
		const int g_X = Tile.g_LowTilesWide == 1 ? 0 : Tile.g_TileX;
		const bool r_bValid = g_Y < Tile.g_LowTilesHigh && g_X < Tile.g_LowTilesWide;
		const uint64_t g_Base = g_Scratch + uint64_t(g_Y * Tile.g_LowTilesWide + g_X) * 16384 +
								Tile.g_OutputChannel * 32 + Tile.r_Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			const uint4 r_Previous = r_bValid ? __ldca(reinterpret_cast<const uint4*>(g_Base + r_NTile * 512))
											  : make_uint4(0, 0, 0, 0);
			auto& r_C = r_Accumulator.r_Words[0][r_NTile];
			r_C[0] = HalfAdd(r_Previous.x, r_C[0]);
			r_C[1] = HalfAdd(r_Previous.y, r_C[1]);
			r_C[2] = HalfAdd(r_Previous.z, r_C[2]);
			r_C[3] = HalfAdd(r_Previous.w, r_C[3]);
		}
	}
}

template <bool bFp8>
__device__ __forceinline__ void UpsampleAndMerge(const FAccumulator& r_Projected, uint64_t g_Skip,
												 uint64_t g_Output, uint64_t g_Record,
												 const FCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	uint32_t r_Scale[8][2];
#pragma unroll
	for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_Scale[r_NTile][r_N8] = *reinterpret_cast<const uint32_t*>(
				g_Record + Profile::MatrixBytes +
				(Tile.g_OutputChannel + r_NTile * 16 + r_N8 * 8 + (Tile.r_Lane & 3) * 2) * 2);

	// A low 4x4 tile expands into four high 4x4 tiles. Indexed lane shuffles
	// duplicate each low pixel in X/Y while preserving packed channel ownership.
#pragma unroll
	for (int r_Quadrant = 0; r_Quadrant < 4; ++r_Quadrant)
	{
		const int g_OffsetY = r_Quadrant / 2, g_OffsetX = r_Quadrant % 2;
		const int g_OutputY = Tile.g_TileY * 2 + g_OffsetY, g_OutputX = Tile.g_TileX * 2 + g_OffsetX;
		const int g_SkipY = Tile.g_HighTilesHigh == 1 ? 0 : g_OutputY;
		const int g_SkipX = Tile.g_HighTilesWide == 1 ? 0 : g_OutputX;
		const bool r_bValidSkip = g_SkipY < Tile.g_HighTilesHigh && g_SkipX < Tile.g_HighTilesWide;
		const uint64_t g_SkipBase =
			g_Skip + uint64_t(g_SkipY * Tile.g_HighTilesWide + g_SkipX) * 8192 * Profile::ElementBytes +
			Tile.g_OutputChannel * 16 * Profile::ElementBytes + Tile.r_Lane * 16;
		uint32_t r_Output[8][4];
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			uint32_t r_Skip[4];
			if constexpr (bFp8)
			{
				const uint4 r_Packed =
					r_bValidSkip ? __ldca(reinterpret_cast<const uint4*>(g_SkipBase + (r_NTile / 2) * 512))
								 : make_uint4(0, 0, 0, 0);
				const uint32_t r_Pairs[4] = {r_Packed.x, r_Packed.y, r_Packed.z, r_Packed.w};
				const uint32_t r_Low = r_Pairs[(r_NTile % 2) * 2], r_High = r_Pairs[(r_NTile % 2) * 2 + 1];
				r_Skip[0] = DecodeE4(uint16_t(r_Low));
				r_Skip[1] = DecodeE4(uint16_t(r_High));
				r_Skip[2] = DecodeE4(uint16_t(r_Low >> 16));
				r_Skip[3] = DecodeE4(uint16_t(r_High >> 16));
			}
			else
			{
				const uint4 r_Packed =
					r_bValidSkip ? __ldca(reinterpret_cast<const uint4*>(g_SkipBase + r_NTile * 512))
								 : make_uint4(0, 0, 0, 0);
				r_Skip[0] = r_Packed.x;
				r_Skip[1] = r_Packed.y;
				r_Skip[2] = r_Packed.z;
				r_Skip[3] = r_Packed.w;
			}
#pragma unroll
			for (int r_N8 = 0; r_N8 < 2; ++r_N8)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int r_SourceLane =
						(Tile.r_Lane & 3) | ((Tile.r_Lane >> 1) & 4) | (g_OffsetX * 8) | (r_RowHalf * 16);
					const uint32_t r_Nearest = ShuffleIdx(
						r_Projected.r_Words[0][r_NTile][r_N8 * 2 + g_OffsetY], r_SourceLane, 31, 0xffffffffu);
					r_Output[r_NTile][r_N8 * 2 + r_RowHalf] =
						HalfAdd(r_Nearest, HalfMul(r_Skip[r_N8 * 2 + r_RowHalf], r_Scale[r_NTile][r_N8]));
				}
		}
		if (g_OutputY >= Tile.g_HighTilesHigh || g_OutputX >= Tile.g_HighTilesWide)
			continue;
		const uint64_t g_OutputBase =
			g_Output + uint64_t(g_OutputY * Tile.g_HighTilesWide + g_OutputX) * 8192 * Profile::ElementBytes +
			Tile.g_OutputChannel * 16 * Profile::ElementBytes + Tile.r_Lane * 16;
#pragma unroll
		for (int r_Panel = 0; r_Panel < (bFp8 ? 4 : 8); ++r_Panel)
		{
			uint4 r_Published;
			if constexpr (bFp8)
			{
				const auto& r_Low = r_Output[r_Panel * 2];
				const auto& r_High = r_Output[r_Panel * 2 + 1];
				r_Published =
					make_uint4(PackHalfPairsE4(r_Low[0], r_Low[2]), PackHalfPairsE4(r_Low[1], r_Low[3]),
							   PackHalfPairsE4(r_High[0], r_High[2]), PackHalfPairsE4(r_High[1], r_High[3]));
			}
			else
			{
				const auto& r_C = r_Output[r_Panel];
				r_Published = make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]);
			}
			StoreNoAllocate(g_OutputBase + r_Panel * 512, r_Published);
		}
	}
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void Forward(const TParameters& ParameterBlock, unsigned char* s_Storage)
{
	const int g_Columns = (ParameterBlock.I68 + 3) / 4;
	const FCoordinates Tile{ParameterBlock.I64 / 4,
							ParameterBlock.I68 / 4,
							ParameterBlock.I72 / 4,
							ParameterBlock.I76 / 4,
							int(blockIdx.y),
							int(blockIdx.x) % g_Columns,
							(int(blockIdx.x) / g_Columns) * 256 + int(threadIdx.y) * 128,
							g_Columns,
							int(blockIdx.z),
							int(threadIdx.x),
							int(threadIdx.y)};
	uint64_t g_Scratch;
	if constexpr (bFp8)
		g_Scratch = ParameterBlock.g_P48;
	else
		g_Scratch = ParameterBlock.g_P24;
	const uint64_t g_Counter = ParameterBlock.g_P32 + (Tile.g_TileY * 2 * g_Columns + blockIdx.x) * 4;
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
	{
		BarrierInit(s_Storage, 2048, 64);
		BarrierInit(s_Storage, 2056, 64);
	}
	__syncthreads();
	FAccumulator r_Accumulator{};
	Project<bFp8>(r_Accumulator, s_Storage, ParameterBlock.g_P0, ParameterBlock.g_P56, Tile);
	if (Tile.r_Split > 0)
	{
		if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_Counter)) < Tile.r_Split - 1)
				PollSleep(64);
		__syncthreads();
	}
	ReduceSplit(r_Accumulator, g_Scratch, Tile);
	if (Tile.r_Split == 3)
		UpsampleAndMerge<bFp8>(r_Accumulator, ParameterBlock.g_P8, ParameterBlock.g_P16, ParameterBlock.g_P56,
							   Tile);
	__syncthreads();
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
		CounterStoreRelease(g_Counter, Tile.r_Split);
}
#endif
} // namespace dlssnr::kernels::decoder
