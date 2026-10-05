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
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int Height, Width;
	uint64_t g_DownsampledOutput = 0;
	int DownsampledHeight = 0, DownsampledWidth = 0;
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
													 const FTileCoordinates& r_TileCoordinates)
{
	return g_Base +
		   ((uint64_t(g_ChannelPanel) * r_TileCoordinates.g_TilesHigh * 4 + g_Y) *
				r_TileCoordinates.g_TilesWide * 4 +
			g_X) *
			   16 +
		   (r_TileCoordinates.r_Lane & 3) * 4;
}

// Native OOB policy broadcasts a singleton 4x4 spatial dimension. Other
// incomplete 8x8 CTA edges read zeros; publication always clips to real tiles.
__device__ __forceinline__ bool ResolveInputTile(int& g_Y, int& g_X,
												 const FTileCoordinates& r_TileCoordinates)
{
	if (r_TileCoordinates.g_TilesHigh == 1)
		g_Y = 0;
	if (r_TileCoordinates.g_TilesWide == 1)
		g_X = 0;
	return g_Y < r_TileCoordinates.g_TilesHigh && g_X < r_TileCoordinates.g_TilesWide;
}

template <bool bFp8>
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[2][4], uint64_t g_PackedWeights,
											int r_ReductionTile, const FTileCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_ReductionBase =
		g_PackedWeights +
		uint64_t(blockIdx.z * 512 + r_ReductionTile * Profile::ReductionStep) * 512 * Profile::ElementBytes +
		r_TileCoordinates.g_OutputChannel * 32 + r_TileCoordinates.r_Lane * 16;

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
												int r_ReductionTile,
												const FTileCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const int s_StageOffset = (r_ReductionTile % StageCount) * 4096;
	const int s_BarrierOffset = StageCount * 4096 + (r_ReductionTile % StageCount) * 8;
	const int r_KSubtile = r_TileCoordinates.r_Warp & 1;
	const int g_LocalX = (r_TileCoordinates.r_Warp >> 1) & 1;

	// Every stage transfers eight 512-byte stripes across four spatial tiles.
	// The three-stage ring overlaps input transfers with the register-resident GEMM.
#pragma unroll
	for (int g_LocalY = r_TileCoordinates.r_Warp / 4;
		 g_LocalY < r_TileCoordinates.r_Warp / 4 + SpatialTiles / 2; ++g_LocalY)
	{
		int g_Y = r_TileCoordinates.g_TileY + g_LocalY;
		int g_X = r_TileCoordinates.g_TileX + g_LocalX;
		const bool r_bValid = ResolveInputTile(g_Y, g_X, r_TileCoordinates);
		const int s_CopyOffset = s_StageOffset + g_LocalY * 2048 + g_LocalX * 1024 + r_KSubtile * 512;
		if (r_bValid)
		{
			const uint64_t g_Source =
				g_Input +
				uint64_t(g_Y * r_TileCoordinates.g_TilesWide + g_X + blockIdx.z) * Profile::SpatialTileBytes +
				(r_ReductionTile * 2 + r_KSubtile) * 512;
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_CopyOffset, g_Source, 512, s_BarrierOffset);
				BarrierExpect(s_Storage, s_BarrierOffset, 512);
			}
		}
		else
		{
			*reinterpret_cast<uint4*>(s_Storage + s_CopyOffset + r_TileCoordinates.r_Lane * 16) =
				make_uint4(0, 0, 0, 0);
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
												   const TParameters& r_Parameters,
												   const FTileCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	uint32_t r_ResidualScales[4][2];
#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_ResidualScales[r_ChannelGroup][r_N8] =
				*reinterpret_cast<const uint32_t*>(r_Parameters.g_PackedWeights + Profile::MatrixBytes +
												   (r_TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 +
													r_N8 * 8 + (r_TileCoordinates.r_Lane & 3) * 2) *
													   2);

#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		if constexpr (bInputPlane)
		{
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY = (r_TileCoordinates.g_TileY + r_Spatial / 2) * 4 +
										 r_TileCoordinates.r_Lane / 16 + r_RowHalf * 2;
					const int g_PixelX =
						(r_TileCoordinates.g_TileX + r_Spatial % 2) * 4 + (r_TileCoordinates.r_Lane / 4) % 4;
					const bool r_bPixelValid = g_PixelY < r_TileCoordinates.g_TilesHigh * 4 &&
											   g_PixelX < r_TileCoordinates.g_TilesWide * 4;
#pragma unroll
					for (int r_N8 = 0; r_N8 < 2; ++r_N8)
					{
						const int g_Panel =
							(r_TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 + r_N8 * 8) /
							(bFp8 ? 16 : 8);
						const uint64_t g_ResidualWordAddress = PlaneWordAddress<bFp8>(
							r_Parameters.g_Residual, g_Panel, g_PixelY, g_PixelX, r_TileCoordinates);
						uint32_t r_ResidualPair =
							r_bPixelValid ? __ldcg(reinterpret_cast<const uint32_t*>(g_ResidualWordAddress))
										  : 0;
						if constexpr (bFp8)
							r_ResidualPair = DecodeE4(uint16_t(r_ResidualPair >> (r_N8 * 16)));
						r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup][r_N8 * 2 + r_RowHalf] =
							HalfMul(r_ResidualPair, r_ResidualScales[r_ChannelGroup][r_N8]);
					}
				}
		}
		else
		{
			int g_Y = r_TileCoordinates.g_TileY + r_TileCoordinates.r_Warp / 4 + r_Spatial / 2;
			int g_X = r_TileCoordinates.g_TileX + r_Spatial % 2;
			const bool r_bValid = ResolveInputTile(g_Y, g_X, r_TileCoordinates);
			const uint64_t g_ResidualTileBase =
				r_Parameters.g_Residual +
				uint64_t(g_Y * r_TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
				r_TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes +
				r_TileCoordinates.r_Lane * 16;
			if constexpr (bFp8)
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const uint4 r_PackedResidual =
						r_bValid
							? __ldcg(reinterpret_cast<const uint4*>(g_ResidualTileBase + r_ChannelPair * 512))
							: make_uint4(0, 0, 0, 0);
					const uint32_t r_PackedResidualWords[4] = {r_PackedResidual.x, r_PackedResidual.y,
															   r_PackedResidual.z, r_PackedResidual.w};
#pragma unroll
					for (int r_GroupInPair = 0; r_GroupInPair < 2; ++r_GroupInPair)
					{
						const int r_ChannelGroup = r_ChannelPair * 2 + r_GroupInPair;
						auto& r_AccumulatorWords =
							r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
						// E4 storage interleaves the two N8 groups; restore MMA accumulator order.
						r_AccumulatorWords[0] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2])),
									r_ResidualScales[r_ChannelGroup][0]);
						r_AccumulatorWords[1] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2 + 1])),
									r_ResidualScales[r_ChannelGroup][0]);
						r_AccumulatorWords[2] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2] >> 16)),
									r_ResidualScales[r_ChannelGroup][1]);
						r_AccumulatorWords[3] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2 + 1] >> 16)),
									r_ResidualScales[r_ChannelGroup][1]);
					}
				}
			}
			else
			{
#pragma unroll
				for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				{
					const uint4 r_Residual = r_bValid ? __ldcg(reinterpret_cast<const uint4*>(
															g_ResidualTileBase + r_ChannelGroup * 512))
													  : make_uint4(0, 0, 0, 0);
					auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
					r_AccumulatorWords[0] = HalfMul(r_Residual.x, r_ResidualScales[r_ChannelGroup][0]);
					r_AccumulatorWords[1] = HalfMul(r_Residual.y, r_ResidualScales[r_ChannelGroup][0]);
					r_AccumulatorWords[2] = HalfMul(r_Residual.z, r_ResidualScales[r_ChannelGroup][1]);
					r_AccumulatorWords[3] = HalfMul(r_Residual.w, r_ResidualScales[r_ChannelGroup][1]);
				}
			}
		}
	}
}

template <bool bFp8, int SpatialTiles, bool bOutputPlane>
__device__ __forceinline__ void Publish(const FAccumulator<SpatialTiles>& r_Accumulator, uint64_t g_Output,
										const FTileCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		const int g_Y = r_TileCoordinates.g_TileY + r_TileCoordinates.r_Warp / 4 + r_Spatial / 2;
		const int g_X = r_TileCoordinates.g_TileX + r_Spatial % 2;
		if (g_Y >= r_TileCoordinates.g_TilesHigh || g_X >= r_TileCoordinates.g_TilesWide)
			continue;
		if constexpr (bOutputPlane)
		{
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY = g_Y * 4 + r_TileCoordinates.r_Lane / 16 + r_RowHalf * 2;
					const int g_PixelX = g_X * 4 + (r_TileCoordinates.r_Lane / 4) % 4;
					const auto& r_AccumulatorWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
#pragma unroll
					for (int r_PanelHalf = 0; r_PanelHalf < (bFp8 ? 1 : 2); ++r_PanelHalf)
					{
						const int g_Panel =
							(r_TileCoordinates.g_OutputChannel + r_ChannelGroup * 16) / (bFp8 ? 16 : 8) +
							r_PanelHalf;
						const uint32_t r_OutputWord = bFp8
														  ? PackHalfPairsE4(r_AccumulatorWords[r_RowHalf],
																			r_AccumulatorWords[2 + r_RowHalf])
														  : r_AccumulatorWords[r_PanelHalf * 2 + r_RowHalf];
						*reinterpret_cast<uint32_t*>(PlaneWordAddress<bFp8>(
							g_Output, g_Panel, g_PixelY, g_PixelX, r_TileCoordinates)) = r_OutputWord;
					}
				}
		}
		else
		{
			const uint64_t g_OutputTileBase =
				g_Output + uint64_t(g_Y * r_TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
				r_TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes +
				r_TileCoordinates.r_Lane * 16;
			if constexpr (bFp8)
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_LowerChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][2 * r_ChannelPair];
					const auto& r_UpperChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][2 * r_ChannelPair + 1];
					const uint4 r_OutputVector =
						make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
								   PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
								   PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
								   PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3]));
					StoreNoAllocate(g_OutputTileBase + r_ChannelPair * 512, r_OutputVector);
				}
			}
			else
			{
#pragma unroll
				for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				{
					const auto& r_AccumulatorWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
					StoreNoAllocate(g_OutputTileBase + r_ChannelGroup * 512,
									make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1],
											   r_AccumulatorWords[2], r_AccumulatorWords[3]));
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
											  const TParameters& r_Parameters,
											  const FTileCoordinates& r_TileCoordinates)
{
	FAccumulator<1> r_Pooled;
#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				const auto& r_LeftTileWords = r_Accumulator.r_AccumulatorWords[r_RowHalf * 2][r_ChannelGroup];
				const auto& r_RightTileWords =
					r_Accumulator.r_AccumulatorWords[r_RowHalf * 2 + 1][r_ChannelGroup];
				r_Pooled.r_AccumulatorWords[0][r_ChannelGroup][r_N8 * 2 + r_RowHalf] =
					dlssnr::kernels::window_pool::PoolHorizontalWords(
						r_LeftTileWords[r_N8 * 2], r_LeftTileWords[r_N8 * 2 + 1], r_RightTileWords[r_N8 * 2],
						r_RightTileWords[r_N8 * 2 + 1]);
			}
	FTileCoordinates r_DownsampledCoordinates = r_TileCoordinates;
	r_DownsampledCoordinates.g_TilesHigh = r_Parameters.DownsampledHeight / 4;
	r_DownsampledCoordinates.g_TilesWide = r_Parameters.DownsampledWidth / 4;
	r_DownsampledCoordinates.g_TileY /= 2;
	r_DownsampledCoordinates.g_TileX /= 2;
	Publish<bFp8, 1, false>(r_Pooled, r_Parameters.g_DownsampledOutput, r_DownsampledCoordinates);
}

template <bool bFp8, int SpatialTiles, bool bInputPlane = false, bool bOutputPlane = false,
		  int StageCount = 3, bool bPool = false, typename TParameters>
__device__ __forceinline__ void Forward(const TParameters& r_Parameters, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8>;
	const int g_Columns = (r_Parameters.Width + 7) / 8;
	const FTileCoordinates r_TileCoordinates{r_Parameters.Height / 4,
											 r_Parameters.Width / 4,
											 int(blockIdx.y) * 2,
											 int(blockIdx.x) % g_Columns * 2,
											 int(blockIdx.x) / g_Columns * 256 + (int(threadIdx.y) % 4) * 64,
											 int(threadIdx.x),
											 int(threadIdx.y)};
	if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
	{
#pragma unroll
		for (int s_Stage = 0; s_Stage < StageCount; ++s_Stage)
			BarrierInit(s_Storage, StageCount * 4096 + s_Stage * 8, blockDim.x * blockDim.y);
	}
	__syncthreads();

	uint4 r_Weights[2][4];
	LoadWeights<bFp8>(r_Weights, r_Parameters.g_PackedWeights, 0, r_TileCoordinates);
#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < StageCount; ++s_StageIndex)
		IssueInputStage<bFp8, SpatialTiles, StageCount>(s_Storage, r_Parameters.g_Input, s_StageIndex,
														r_TileCoordinates);
	WaitInputStage<StageCount>(s_Storage, 0);
	FAccumulator<SpatialTiles> r_Accumulator;
	InitializeResidual<bFp8, SpatialTiles, bInputPlane>(r_Accumulator, r_Parameters, r_TileCoordinates);

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
				r_Input[r_Spatial][r_KSubtile] =
					*reinterpret_cast<const uint4*>(s_Storage + (r_ReductionTile % StageCount) * 4096 +
													(r_Spatial + r_TileCoordinates.r_Warp / 4 * 2) * 1024 +
													r_KSubtile * 512 + r_TileCoordinates.r_Lane * 16);
		dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights<bFp8>(r_Weights, r_Parameters.g_PackedWeights, r_ReductionTile + 1,
							  r_TileCoordinates);
			WaitInputStage<StageCount>(s_Storage, r_ReductionTile + 1);
		}
		if (r_ReductionTile + StageCount < Profile::ReductionTiles)
			IssueInputStage<bFp8, SpatialTiles, StageCount>(s_Storage, r_Parameters.g_Input,
															r_ReductionTile + StageCount, r_TileCoordinates);
	}
	Publish<bFp8, SpatialTiles, bOutputPlane>(r_Accumulator, r_Parameters.g_Output, r_TileCoordinates);
	if constexpr (bPool)
		PublishPooled<bFp8>(r_Accumulator, r_Parameters, r_TileCoordinates);
}
#endif
} // namespace dlssnr::kernels::spatial_projection
