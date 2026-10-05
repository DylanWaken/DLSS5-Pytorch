#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// Fused window FFN: dense 512->512, then eight independent 64->256->64 MLPs.
// Each CTA owns an 8x8 spatial tile and four groups; grid.z selects groups 0-3/4-7.
namespace dlssnr::kernels::window_ffn
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
using namespace dlssnr::packed_math::sm120;
using dlssnr::tiles::sm120::FAccumulatorTile;

template <bool bFp8, bool bInputView = false> struct FProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int Warps = bFp8 && !bInputView ? 8 : 4;
	static constexpr int SpatialFragments = bFp8 && !bInputView ? 2 : 4;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int SpatialTileBytes = 16 * 512 * ElementBytes;
	static constexpr auto Precision =
		bFp8 ? dlssnr::mma::sm120::EInputPrecision::Fp8 : dlssnr::mma::sm120::EInputPrecision::Fp16;
};

struct FTileCoordinates
{
	int g_TilesHigh, g_TilesWide, g_TileY, g_TileX, g_Group;
	int r_Lane, r_Warp;
};

template <bool bFp8>
__device__ __forceinline__ void LoadDenseWeights(uint4 (&r_Weights)[2][4], uint64_t g_Record,
												 int r_ReductionTile, const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_Base = g_Record +
							uint64_t(r_ReductionTile * Profile::ReductionStep) * 512 * Profile::ElementBytes +
							Tile.g_Group * 2048 + Tile.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
			r_Weights[r_KSubtile][r_NTile] =
				__ldca(reinterpret_cast<const uint4*>(g_Base + r_KSubtile * 16384 + r_NTile * 512));
}

template <bool bFp8>
__device__ __forceinline__ void IssueInputStage(unsigned char* s_Storage, uint64_t g_Input,
												int r_ReductionTile, const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const int s_StageOffset = (r_ReductionTile % 2) * 4096;
	const int s_BarrierOffset = 8192 + (r_ReductionTile % 2) * 8;
	const int r_KSubtile = Tile.r_Warp & 1;
	const int g_LocalX = (Tile.r_Warp / 2) % 2;

	// Eight FP8 warps each transfer 512 bytes; four Half warps each transfer
	// two rows. Singleton dimensions broadcast, other incomplete edges zero-fill.
#pragma unroll
	for (int r_Copy = 0; r_Copy < (bFp8 ? 1 : 2); ++r_Copy)
	{
		const int g_LocalY = bFp8 ? Tile.r_Warp / 4 : r_Copy;
		const int g_Y = Tile.g_TilesHigh == 1 ? 0 : Tile.g_TileY + g_LocalY;
		const int g_X = Tile.g_TilesWide == 1 ? 0 : Tile.g_TileX + g_LocalX;
		const int s_CopyOffset = s_StageOffset + g_LocalY * 2048 + g_LocalX * 1024 + r_KSubtile * 512;
		if (g_Y < Tile.g_TilesHigh && g_X < Tile.g_TilesWide)
		{
			const uint64_t g_Source = g_Input +
									  uint64_t(g_Y * Tile.g_TilesWide + g_X) * Profile::SpatialTileBytes +
									  (r_ReductionTile * 2 + r_KSubtile) * 512;
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_CopyOffset, g_Source, 512, s_BarrierOffset);
				BarrierExpect(s_Storage, s_BarrierOffset, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_CopyOffset + Tile.r_Lane * 16) = make_uint4(0, 0, 0, 0);
	}
}

// Gather the external 16-byte channel-pack layout directly into MMA A layout.
// Logical shared words encode the 4x4 spatial tile, K subtile, lane and word.
// Eight words per thread cover the complete 4 KiB stage without a transpose pass.
template <typename TParameters>
__device__ __forceinline__ void IssueInputViewStage(unsigned char* s_Storage,
													const TParameters& ParameterBlock, int r_ReductionTile,
													const FTileCoordinates& Tile)
{
#pragma unroll
	for (int r_Copy = 0; r_Copy < 8; ++r_Copy)
	{
		const int sl_Word = Tile.r_Warp * 32 + Tile.r_Lane + r_Copy * 128;
		const int g_LocalY = (sl_Word / 512) * 4 + (sl_Word / 64) % 2 + (sl_Word % 2) * 2;
		const int g_LocalX = ((sl_Word / 256) % 2) * 4 + (sl_Word / 16) % 4;
		const int g_Y = ParameterBlock.Height == 1 ? 0 : Tile.g_TileY * 4 + g_LocalY;
		const int g_X = ParameterBlock.Width == 1 ? 0 : Tile.g_TileX * 4 + g_LocalX;
		const int g_ChannelPack = r_ReductionTile * 4 + ((sl_Word / 128) % 2) * 2 + (sl_Word / 2) % 2;
		const int g_Component = (sl_Word / 4) % 4;
		const int s_Destination = (r_ReductionTile % 2) * 4096 + sl_Word * 4;
		if (g_Y < ParameterBlock.Height && g_X < ParameterBlock.Width)
		{
			const uint64_t g_Source =
				ParameterBlock.g_State +
				uint64_t((g_ChannelPack * ParameterBlock.Height + g_Y) * ParameterBlock.Width + g_X) * 16 +
				g_Component * 4;
			CopyAsync4(s_Storage, s_Destination, g_Source);
		}
		else
			*reinterpret_cast<uint32_t*>(s_Storage + s_Destination) = 0;
	}
	CopyCommit();
}

template <bool bInputView = false>
__device__ __forceinline__ void WaitInputStage(unsigned char* s_Storage, int r_ReductionTile)
{
	const int s_BarrierOffset = 8192 + (r_ReductionTile % 2) * 8;
	if constexpr (bInputView)
		CopyWait0();
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_BarrierOffset);
}

// MMA output words are already Half A-fragment order. E4 combines two N16
// groups into one K32 fragment and converts at the original quantization boundary.
template <bool bFp8, int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ uint4 InputFragment(
	const FAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator, int r_Spatial, int r_KSubtile)
{
	if constexpr (bFp8)
	{
		const auto& r_Low = r_Accumulator.r_Words[r_Spatial][r_KSubtile * 2];
		const auto& r_High = r_Accumulator.r_Words[r_Spatial][r_KSubtile * 2 + 1];
		return make_uint4(PackHalfPairsE4(r_Low[0], r_Low[2]), PackHalfPairsE4(r_Low[1], r_Low[3]),
						  PackHalfPairsE4(r_High[0], r_High[2]), PackHalfPairsE4(r_High[1], r_High[3]));
	}
	else
	{
		const auto& r_C = r_Accumulator.r_Words[r_Spatial][r_KSubtile];
		return make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]);
	}
}

// The grouped E4 GEMMs issue one K32 across all M/N tiles before the next K32.
// The dense GEMM and Half grouped GEMMs instead use the common two-K schedule.
template <int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ void
AccumulateSingleFp8(FAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator,
					const uint4 (&r_Input)[SpatialFragments], const uint4 (&r_Weights)[ChannelGroups])
{
	using namespace dlssnr::mma::sm120;
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
#pragma unroll
		for (int r_NTile = 0; r_NTile < ChannelGroups; ++r_NTile)
		{
			auto& r_C = r_Accumulator.r_Words[r_Spatial][r_NTile];
			const uint4 r_A = r_Input[r_Spatial];
			const uint4 r_B = r_Weights[r_NTile];
			MultiplyAccumulate<EInputPrecision::Fp8>({r_C[0], r_C[1]}, {r_A.x, r_A.y, r_A.z, r_A.w},
													 {r_B.x, r_B.y}, {r_C[0], r_C[1]});
			MultiplyAccumulate<EInputPrecision::Fp8>({r_C[2], r_C[3]}, {r_A.x, r_A.y, r_A.z, r_A.w},
													 {r_B.z, r_B.w}, {r_C[2], r_C[3]});
		}
}

template <int SpatialFragments>
__device__ __forceinline__ void Activate(FAccumulatorTile<SpatialFragments, 2>& r_Hidden)
{
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
				r_Hidden.r_Words[r_Spatial][r_NTile][r_Word] =
					FfnActivation(r_Hidden.r_Words[r_Spatial][r_NTile][r_Word]);
}

template <bool bFp8, int SpatialFragments>
__device__ __forceinline__ void GroupedMlp(FAccumulatorTile<SpatialFragments, 4>& r_Output,
										   const FAccumulatorTile<SpatialFragments, 4>& r_Projected,
										   uint64_t g_Record, const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_Expand =
		g_Record + (262144 + Tile.g_Group * 16384) * Profile::ElementBytes + Tile.r_Lane * 16;
	const uint64_t g_Contract =
		g_Record + (393216 + Tile.g_Group * 16384) * Profile::ElementBytes + Tile.r_Lane * 16;

	// Hidden activations stay in registers. Processing 32 hidden channels at a
	// time avoids materializing the 256-channel intermediate in shared/global memory.
#pragma unroll 1
	for (int r_HiddenTile = 0; r_HiddenTile < 8; ++r_HiddenTile)
	{
		FAccumulatorTile<SpatialFragments, 2> r_Hidden{};
#pragma unroll
		for (int r_KPair = 0; r_KPair < 2; ++r_KPair)
		{
			if constexpr (bFp8)
			{
				uint4 r_Input[SpatialFragments], r_Weights[2];
#pragma unroll
				for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
					r_Input[r_Spatial] = InputFragment<true>(r_Projected, r_Spatial, r_KPair);
#pragma unroll
				for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
					r_Weights[r_NTile] = __ldca(reinterpret_cast<const uint4*>(
						g_Expand + r_HiddenTile * 1024 + r_KPair * 8192 + r_NTile * 512));
				AccumulateSingleFp8(r_Hidden, r_Input, r_Weights);
			}
			else
			{
				uint4 r_Input[SpatialFragments][2], r_Weights[2][2];
#pragma unroll
				for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				{
#pragma unroll
					for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
						r_Input[r_Spatial][r_KSubtile] =
							InputFragment<false>(r_Projected, r_Spatial, r_KPair * 2 + r_KSubtile);
#pragma unroll
					for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
						r_Weights[r_KSubtile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
							g_Expand + r_HiddenTile * 1024 + (r_KPair * 2 + r_KSubtile) * 8192 +
							r_NTile * 512));
				}
				dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Hidden, r_Input, r_Weights);
			}
		}
		Activate(r_Hidden);

		if constexpr (bFp8)
		{
			uint4 r_Input[SpatialFragments], r_Weights[4];
#pragma unroll
			for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
				r_Input[r_Spatial] = InputFragment<true>(r_Hidden, r_Spatial, 0);
#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weights[r_NTile] =
					__ldca(reinterpret_cast<const uint4*>(g_Contract + r_HiddenTile * 2048 + r_NTile * 512));
			AccumulateSingleFp8(r_Output, r_Input, r_Weights);
		}
		else
		{
			uint4 r_Input[SpatialFragments][2], r_Weights[2][4];
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			{
#pragma unroll
				for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
					r_Input[r_Spatial][r_KSubtile] = InputFragment<false>(r_Hidden, r_Spatial, r_KSubtile);
#pragma unroll
				for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
					r_Weights[r_KSubtile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
						g_Contract + r_HiddenTile * 4096 + r_KSubtile * 2048 + r_NTile * 512));
			}
			dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Output, r_Input, r_Weights);
		}
	}
}

template <bool bFp8, bool bInputView = false, typename TParameters>
__device__ __forceinline__ void Forward(const TParameters& ParameterBlock, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8, bInputView>;
	const FTileCoordinates Tile{ParameterBlock.Height / 4,
								ParameterBlock.Width / 4,
								int(blockIdx.y) * 2,
								int(blockIdx.x) * 2,
								(int(threadIdx.y) % 4) + int(blockIdx.z) * 4,
								int(threadIdx.x),
								int(threadIdx.y)};
	if (Tile.r_Lane == 0 && Tile.r_Warp == 0)
	{
		BarrierInit(s_Storage, 8192, Profile::Warps * 32);
		BarrierInit(s_Storage, 8200, Profile::Warps * 32);
	}
	__syncthreads();

	uint4 r_Weights[2][4];
	LoadDenseWeights<bFp8>(r_Weights, ParameterBlock.g_Record, 0, Tile);
	if constexpr (bInputView)
		IssueInputViewStage(s_Storage, ParameterBlock, 0, Tile);
	else
		IssueInputStage<bFp8>(s_Storage, ParameterBlock.g_State, 0, Tile);
	WaitInputStage<bInputView>(s_Storage, 0);
	FAccumulatorTile<Profile::SpatialFragments, 4> r_Projected{};

	// Two-stage pipeline: issue the next input before current MMA work, then
	// fetch its weights and wait. The final iteration neither refills nor waits.
#pragma unroll 1
	for (int r_ReductionTile = 0; r_ReductionTile < Profile::ReductionTiles; ++r_ReductionTile)
	{
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
		{
			if constexpr (bInputView)
				IssueInputViewStage(s_Storage, ParameterBlock, r_ReductionTile + 1, Tile);
			else
				IssueInputStage<bFp8>(s_Storage, ParameterBlock.g_State, r_ReductionTile + 1, Tile);
		}
		uint4 r_Input[Profile::SpatialFragments][2];
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] =
					*reinterpret_cast<const uint4*>(s_Storage + (r_ReductionTile % 2) * 4096 +
													(bFp8 && !bInputView ? (Tile.r_Warp / 4) * 2048 : 0) +
													r_Spatial * 1024 + r_KSubtile * 512 + Tile.r_Lane * 16);
		dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Projected, r_Input, r_Weights);
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadDenseWeights<bFp8>(r_Weights, ParameterBlock.g_Record, r_ReductionTile + 1, Tile);
			WaitInputStage<bInputView>(s_Storage, r_ReductionTile + 1);
		}
	}

	FAccumulatorTile<Profile::SpatialFragments, 4> r_Output{};
	GroupedMlp<bFp8>(r_Output, r_Projected, ParameterBlock.g_Record, Tile);
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
	{
		const int g_Y = Tile.g_TileY + (bFp8 && !bInputView ? Tile.r_Warp / 4 : r_Spatial / 2);
		const int g_X = Tile.g_TileX + (bFp8 && !bInputView ? r_Spatial : r_Spatial % 2);
		if (g_Y >= Tile.g_TilesHigh || g_X >= Tile.g_TilesWide)
			continue;
		const uint64_t g_Base = ParameterBlock.g_High +
								uint64_t(g_Y * Tile.g_TilesWide + g_X) * Profile::SpatialTileBytes +
								Tile.g_Group * 1024 * Profile::ElementBytes + Tile.r_Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < (bFp8 ? 2 : 4); ++r_NTile)
			StoreNoAllocate(g_Base + r_NTile * 512, InputFragment<bFp8>(r_Output, r_Spatial, r_NTile));
	}
}
#endif
} // namespace dlssnr::kernels::window_ffn
