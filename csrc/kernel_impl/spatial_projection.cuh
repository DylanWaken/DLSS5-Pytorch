#pragma once
#include "kernel_impl/memoryops.cuh"
#include "window_pool.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// C512 residual projection shared by FFN and attention. The native schedules
// differ in warp ownership: FFN uses four warps with four spatial tiles each;
// attention uses eight warps with two tiles each. Both produce 8x8x256 per CTA.
// H/W are divisible by four; the launcher retains each original block shape.
namespace dlssnr::kernels::spatial_projection
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
using namespace dlssnr::packed_math::sm120;
template <int SpatialTiles> using FAccumulator = dlssnr::tiles::sm120::FAccumulatorTile<SpatialTiles, 4>;

struct FArguments
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int Height, Width;
	uint64_t g_Down = 0;
	int DownHeight = 0, DownWidth = 0;
};

template <bool bFp8> struct FProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int SpatialTileBytes = 16 * 512 * ElementBytes;
	static constexpr int MatrixBytes = 512 * 512 * ElementBytes;
	static constexpr auto Precision =
		bFp8 ? dlssnr::mma::sm120::EInputPrecision::Fp8 : dlssnr::mma::sm120::EInputPrecision::Fp16;
};

struct FTileCoordinates
{
	int g_TilesHigh, g_TilesWide;
	int g_TileY, g_TileX;
	int g_OutputChannel;
	int r_Lane, r_Warp;
};

// Channel-plane views store 16 bytes per pixel: N16 for FP8, N8 for Half.
// A warp lane owns a channel pair at x=(lane/4)%4 and y=lane/16.
template <bool bFp8>
__device__ __forceinline__ uint64_t PlaneWordAddress(uint64_t g_Base, int g_ChannelPanel, int g_Y, int g_X,
													 const FTileCoordinates& Tile)
{
	return g_Base +
		   ((uint64_t(g_ChannelPanel) * Tile.g_TilesHigh * 4 + g_Y) * Tile.g_TilesWide * 4 + g_X) * 16 +
		   (Tile.r_Lane & 3) * 4;
}

// Native OOB policy broadcasts a singleton 4x4 spatial dimension. Other
// incomplete 8x8 CTA edges read zeros; publication always clips to real tiles.
__device__ __forceinline__ bool ResolveInputTile(int& g_Y, int& g_X, const FTileCoordinates& Tile)
{
	if (Tile.g_TilesHigh == 1)
		g_Y = 0;
	if (Tile.g_TilesWide == 1)
		g_X = 0;
	return g_Y < Tile.g_TilesHigh && g_X < Tile.g_TilesWide;
}

template <bool bFp8>
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[2][4], uint64_t g_Record, int r_ReductionTile,
											const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_ReductionBase =
		g_Record +
		uint64_t(blockIdx.z * 512 + r_ReductionTile * Profile::ReductionStep) * 512 * Profile::ElementBytes +
		Tile.g_OutputChannel * 32 + Tile.r_Lane * 16;

	// The native matrix stores one warp's N16 fragment as a 512-byte vector stripe.
	// Both precisions consume two instruction-K subtiles, separated by16KiB.
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			r_Weights[r_KSubtile][r_ChannelGroup] = __ldca(
				reinterpret_cast<const uint4*>(g_ReductionBase + r_KSubtile * 16384 + r_ChannelGroup * 512));
}

template <bool bFp8, int SpatialTiles, int StageCount>
__device__ __forceinline__ void IssueInputStage(unsigned char* s_Storage, uint64_t g_Input,
												int r_ReductionTile, const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const int s_StageOffset = (r_ReductionTile % StageCount) * 4096;
	const int s_BarrierOffset = StageCount * 4096 + (r_ReductionTile % StageCount) * 8;
	const int r_KSubtile = Tile.r_Warp & 1;
	const int g_LocalX = (Tile.r_Warp >> 1) & 1;

	// Every stage transfers eight 512-byte stripes across four spatial tiles.
	// The three-stage ring overlaps input transfers with the register-resident GEMM.
#pragma unroll
	for (int g_LocalY = Tile.r_Warp / 4; g_LocalY < Tile.r_Warp / 4 + SpatialTiles / 2; ++g_LocalY)
	{
		int g_Y = Tile.g_TileY + g_LocalY;
		int g_X = Tile.g_TileX + g_LocalX;
		const bool r_bValid = ResolveInputTile(g_Y, g_X, Tile);
		const int s_CopyOffset = s_StageOffset + g_LocalY * 2048 + g_LocalX * 1024 + r_KSubtile * 512;
		if (r_bValid)
		{
			const uint64_t g_Source =
				g_Input + uint64_t(g_Y * Tile.g_TilesWide + g_X + blockIdx.z) * Profile::SpatialTileBytes +
				(r_ReductionTile * 2 + r_KSubtile) * 512;
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_CopyOffset, g_Source, 512, s_BarrierOffset);
				BarrierExpect(s_Storage, s_BarrierOffset, 512);
			}
		}
		else
		{
			*reinterpret_cast<uint4*>(s_Storage + s_CopyOffset + Tile.r_Lane * 16) = make_uint4(0, 0, 0, 0);
		}
	}
}

template <int StageCount>
__device__ __forceinline__ void WaitInputStage(unsigned char* s_Storage, int r_ReductionTile)
{
	const int s_BarrierOffset = StageCount * 4096 + (r_ReductionTile % StageCount) * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_BarrierOffset);
}

template <bool bFp8, int SpatialTiles, bool bInputPlane, typename TParameters>
__device__ __forceinline__ void InitializeResidual(FAccumulator<SpatialTiles>& r_Accumulator,
												   const TParameters& ParameterBlock,
												   const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	uint32_t r_Scales[4][2];
#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_Scales[r_ChannelGroup][r_N8] = *reinterpret_cast<const uint32_t*>(
				ParameterBlock.g_Record + Profile::MatrixBytes +
				(Tile.g_OutputChannel + r_ChannelGroup * 16 + r_N8 * 8 + (Tile.r_Lane & 3) * 2) * 2);

#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		if constexpr (bInputPlane)
		{
#pragma unroll
			for (int r_Group = 0; r_Group < 4; ++r_Group)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY =
						(Tile.g_TileY + r_Spatial / 2) * 4 + Tile.r_Lane / 16 + r_RowHalf * 2;
					const int g_PixelX = (Tile.g_TileX + r_Spatial % 2) * 4 + (Tile.r_Lane / 4) % 4;
					const bool r_bPixelValid =
						g_PixelY < Tile.g_TilesHigh * 4 && g_PixelX < Tile.g_TilesWide * 4;
#pragma unroll
					for (int r_N8 = 0; r_N8 < 2; ++r_N8)
					{
						const int g_Panel =
							(Tile.g_OutputChannel + r_Group * 16 + r_N8 * 8) / (bFp8 ? 16 : 8);
						const uint64_t g_Address =
							PlaneWordAddress<bFp8>(ParameterBlock.g_Skip, g_Panel, g_PixelY, g_PixelX, Tile);
						uint32_t r_Value =
							r_bPixelValid ? __ldcg(reinterpret_cast<const uint32_t*>(g_Address)) : 0;
						if constexpr (bFp8)
							r_Value = DecodeE4(uint16_t(r_Value >> (r_N8 * 16)));
						r_Accumulator.r_Words[r_Spatial][r_Group][r_N8 * 2 + r_RowHalf] =
							HalfMul(r_Value, r_Scales[r_Group][r_N8]);
					}
				}
		}
		else
		{
			int g_Y = Tile.g_TileY + Tile.r_Warp / 4 + r_Spatial / 2;
			int g_X = Tile.g_TileX + r_Spatial % 2;
			const bool r_bValid = ResolveInputTile(g_Y, g_X, Tile);
			const uint64_t g_Base = ParameterBlock.g_Skip +
									uint64_t(g_Y * Tile.g_TilesWide + g_X) * Profile::SpatialTileBytes +
									Tile.g_OutputChannel * 16 * Profile::ElementBytes + Tile.r_Lane * 16;
			if constexpr (bFp8)
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const uint4 r_Packed =
						r_bValid ? __ldcg(reinterpret_cast<const uint4*>(g_Base + r_ChannelPair * 512))
								 : make_uint4(0, 0, 0, 0);
					const uint32_t r_Pairs[4] = {r_Packed.x, r_Packed.y, r_Packed.z, r_Packed.w};
#pragma unroll
					for (int r_GroupInPair = 0; r_GroupInPair < 2; ++r_GroupInPair)
					{
						const int r_Group = r_ChannelPair * 2 + r_GroupInPair;
						auto& r_C = r_Accumulator.r_Words[r_Spatial][r_Group];
						// E4 storage interleaves the two N8 groups; restore MMA accumulator order.
						r_C[0] =
							HalfMul(DecodeE4(uint16_t(r_Pairs[r_GroupInPair * 2])), r_Scales[r_Group][0]);
						r_C[1] =
							HalfMul(DecodeE4(uint16_t(r_Pairs[r_GroupInPair * 2 + 1])), r_Scales[r_Group][0]);
						r_C[2] = HalfMul(DecodeE4(uint16_t(r_Pairs[r_GroupInPair * 2] >> 16)),
										 r_Scales[r_Group][1]);
						r_C[3] = HalfMul(DecodeE4(uint16_t(r_Pairs[r_GroupInPair * 2 + 1] >> 16)),
										 r_Scales[r_Group][1]);
					}
				}
			}
			else
			{
#pragma unroll
				for (int r_Group = 0; r_Group < 4; ++r_Group)
				{
					const uint4 r_Residual =
						r_bValid ? __ldcg(reinterpret_cast<const uint4*>(g_Base + r_Group * 512))
								 : make_uint4(0, 0, 0, 0);
					auto& r_C = r_Accumulator.r_Words[r_Spatial][r_Group];
					r_C[0] = HalfMul(r_Residual.x, r_Scales[r_Group][0]);
					r_C[1] = HalfMul(r_Residual.y, r_Scales[r_Group][0]);
					r_C[2] = HalfMul(r_Residual.z, r_Scales[r_Group][1]);
					r_C[3] = HalfMul(r_Residual.w, r_Scales[r_Group][1]);
				}
			}
		}
	}
}

template <bool bFp8, int SpatialTiles, bool bOutputPlane>
__device__ __forceinline__ void Publish(const FAccumulator<SpatialTiles>& r_Accumulator, uint64_t g_Output,
										const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		const int g_Y = Tile.g_TileY + Tile.r_Warp / 4 + r_Spatial / 2;
		const int g_X = Tile.g_TileX + r_Spatial % 2;
		if (g_Y >= Tile.g_TilesHigh || g_X >= Tile.g_TilesWide)
			continue;
		if constexpr (bOutputPlane)
		{
#pragma unroll
			for (int r_Group = 0; r_Group < 4; ++r_Group)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY = g_Y * 4 + Tile.r_Lane / 16 + r_RowHalf * 2;
					const int g_PixelX = g_X * 4 + (Tile.r_Lane / 4) % 4;
					const auto& r_C = r_Accumulator.r_Words[r_Spatial][r_Group];
#pragma unroll
					for (int r_PanelHalf = 0; r_PanelHalf < (bFp8 ? 1 : 2); ++r_PanelHalf)
					{
						const int g_Panel =
							(Tile.g_OutputChannel + r_Group * 16) / (bFp8 ? 16 : 8) + r_PanelHalf;
						const uint32_t r_Value = bFp8 ? PackHalfPairsE4(r_C[r_RowHalf], r_C[2 + r_RowHalf])
													  : r_C[r_PanelHalf * 2 + r_RowHalf];
						*reinterpret_cast<uint32_t*>(
							PlaneWordAddress<bFp8>(g_Output, g_Panel, g_PixelY, g_PixelX, Tile)) = r_Value;
					}
				}
		}
		else
		{
			const uint64_t g_Base = g_Output +
									uint64_t(g_Y * Tile.g_TilesWide + g_X) * Profile::SpatialTileBytes +
									Tile.g_OutputChannel * 16 * Profile::ElementBytes + Tile.r_Lane * 16;
			if constexpr (bFp8)
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_Low = r_Accumulator.r_Words[r_Spatial][2 * r_ChannelPair];
					const auto& r_High = r_Accumulator.r_Words[r_Spatial][2 * r_ChannelPair + 1];
					const uint4 r_Packed = make_uint4(
						PackHalfPairsE4(r_Low[0], r_Low[2]), PackHalfPairsE4(r_Low[1], r_Low[3]),
						PackHalfPairsE4(r_High[0], r_High[2]), PackHalfPairsE4(r_High[1], r_High[3]));
					StoreNoAllocate(g_Base + r_ChannelPair * 512, r_Packed);
				}
			}
			else
			{
#pragma unroll
				for (int r_Group = 0; r_Group < 4; ++r_Group)
				{
					const auto& r_C = r_Accumulator.r_Words[r_Spatial][r_Group];
					StoreNoAllocate(g_Base + r_Group * 512, make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]));
				}
			}
		}
	}
}

// Pool the unquantized projection accumulators. Four warp shuffles gather the
// 2x2 pixel neighborhood; the native rounded pair sums precede multiplication
// by 1/4. Quantization occurs only after this reduction.
template <bool bFp8, typename TParameters>
__device__ __forceinline__ void PublishPooled(const FAccumulator<4>& r_Accumulator,
											  const TParameters& ParameterBlock, const FTileCoordinates& Tile)
{
	FAccumulator<1> r_Pooled;
#pragma unroll
	for (int r_Group = 0; r_Group < 4; ++r_Group)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				const auto& r_Left = r_Accumulator.r_Words[r_RowHalf * 2][r_Group];
				const auto& r_Right = r_Accumulator.r_Words[r_RowHalf * 2 + 1][r_Group];
				r_Pooled.r_Words[0][r_Group][r_N8 * 2 + r_RowHalf] =
					dlssnr::kernels::window_pool::PoolHorizontalWords(
						r_Left[r_N8 * 2], r_Left[r_N8 * 2 + 1], r_Right[r_N8 * 2], r_Right[r_N8 * 2 + 1]);
			}
	FTileCoordinates DownTile = Tile;
	DownTile.g_TilesHigh = ParameterBlock.DownHeight / 4;
	DownTile.g_TilesWide = ParameterBlock.DownWidth / 4;
	DownTile.g_TileY /= 2;
	DownTile.g_TileX /= 2;
	Publish<bFp8, 1, false>(r_Pooled, ParameterBlock.g_Down, DownTile);
}

template <bool bFp8, int SpatialTiles, bool bInputPlane = false, bool bOutputPlane = false,
		  int StageCount = 3, bool bPool = false, typename TParameters>
__device__ __forceinline__ void Forward(const TParameters& ParameterBlock, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8>;
	const int g_Columns = (ParameterBlock.Width + 7) / 8;
	const FTileCoordinates Tile{ParameterBlock.Height / 4,
								ParameterBlock.Width / 4,
								int(blockIdx.y) * 2,
								int(blockIdx.x) % g_Columns * 2,
								int(blockIdx.x) / g_Columns * 256 + (int(threadIdx.y) % 4) * 64,
								int(threadIdx.x),
								int(threadIdx.y)};
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
	{
#pragma unroll
		for (int s_Stage = 0; s_Stage < StageCount; ++s_Stage)
			BarrierInit(s_Storage, StageCount * 4096 + s_Stage * 8, blockDim.x * blockDim.y);
	}
	__syncthreads();

	uint4 r_Weights[2][4];
	LoadWeights<bFp8>(r_Weights, ParameterBlock.g_Record, 0, Tile);
#pragma unroll
	for (int r_Stage = 0; r_Stage < StageCount; ++r_Stage)
		IssueInputStage<bFp8, SpatialTiles, StageCount>(s_Storage, ParameterBlock.g_State, r_Stage, Tile);
	WaitInputStage<StageCount>(s_Storage, 0);
	FAccumulator<SpatialTiles> r_Accumulator;
	InitializeResidual<bFp8, SpatialTiles, bInputPlane>(r_Accumulator, ParameterBlock, Tile);

	// Keep K sequential to retain Half accumulation order and the native ring
	// lifecycle. Prefetch next weights before waiting, then recycle the old stage.
#pragma unroll 1
	for (int r_ReductionTile = 0; r_ReductionTile < Profile::ReductionTiles; ++r_ReductionTile)
	{
		uint4 r_Input[SpatialTiles][2];
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] = *reinterpret_cast<const uint4*>(
					s_Storage + (r_ReductionTile % StageCount) * 4096 +
					(r_Spatial + Tile.r_Warp / 4 * 2) * 1024 + r_KSubtile * 512 + Tile.r_Lane * 16);
		dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights<bFp8>(r_Weights, ParameterBlock.g_Record, r_ReductionTile + 1, Tile);
			WaitInputStage<StageCount>(s_Storage, r_ReductionTile + 1);
		}
		if (r_ReductionTile + StageCount < Profile::ReductionTiles)
			IssueInputStage<bFp8, SpatialTiles, StageCount>(s_Storage, ParameterBlock.g_State,
															r_ReductionTile + StageCount, Tile);
	}
	Publish<bFp8, SpatialTiles, bOutputPlane>(r_Accumulator, ParameterBlock.g_High, Tile);
	if constexpr (bPool)
		PublishPooled<bFp8>(r_Accumulator, ParameterBlock, Tile);
}
#endif
} // namespace dlssnr::kernels::spatial_projection
