#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"

// Fused window FFN: dense 512->512, then eight independent 64->256->64 MLPs.
// Each CTA owns an 8x8 spatial tile and four groups; grid.z selects groups 0-3/4-7.
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <bool bFp8, bool bInputView = false> struct FWindowFfnProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int Warps = bFp8 && !bInputView ? 8 : 4;
	static constexpr int SpatialFragments = bFp8 && !bInputView ? 2 : 4;
	static constexpr int ReductionStep = bFp8 ? 64 : 32;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int SpatialTileBytes = 16 * 512 * ElementBytes;
	static constexpr auto Precision = bFp8 ? EMmaInputPrecision::Fp8 : EMmaInputPrecision::Fp16;
};

struct FWindowFfnTileCoordinates
{
	int g_TilesHigh, g_TilesWide, g_TileY, g_TileX, g_ExpertGroup;
	int Lane, Warp;
};

template <bool bFp8>
__device__ __forceinline__ void LoadWindowFfnDenseWeights(uint4 (&r_Weights)[2][4], uint64_t g_PackedWeights,
														  int ReductionTile,
														  const FWindowFfnTileCoordinates& TileCoordinates)
{
	using Profile = FWindowFfnProfile<bFp8>;
	const uint64_t g_WeightTileBase =
		g_PackedWeights + uint64_t(ReductionTile * Profile::ReductionStep) * 512 * Profile::ElementBytes +
		TileCoordinates.g_ExpertGroup * 2048 + TileCoordinates.Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
			r_Weights[r_KSubtile][r_NTile] =
				__ldca(reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 16384 + r_NTile * 512));
}

template <bool bFp8>
__device__ __forceinline__ void IssueWindowFfnInputStage(unsigned char* s_Storage, uint64_t g_Input,
														 int ReductionTile,
														 const FWindowFfnTileCoordinates& TileCoordinates)
{
	using Profile = FWindowFfnProfile<bFp8>;
	const int s_StageOffset = (ReductionTile % 2) * 4096;
	const int s_BarrierOffset = 8192 + (ReductionTile % 2) * 8;
	const int KSubtileIndex = TileCoordinates.Warp & 1;
	const int g_LocalX = (TileCoordinates.Warp / 2) % 2;

	// Eight FP8 warps each transfer 512 bytes; four Half warps each transfer
	// two rows. Singleton dimensions broadcast, other incomplete edges zero-fill.
#pragma unroll
	for (int CopyIndex = 0; CopyIndex < (bFp8 ? 1 : 2); ++CopyIndex)
	{
		const int g_LocalY = bFp8 ? TileCoordinates.Warp / 4 : CopyIndex;
		const int g_Y = TileCoordinates.g_TilesHigh == 1 ? 0 : TileCoordinates.g_TileY + g_LocalY;
		const int g_X = TileCoordinates.g_TilesWide == 1 ? 0 : TileCoordinates.g_TileX + g_LocalX;
		const int s_CopyOffset = s_StageOffset + g_LocalY * 2048 + g_LocalX * 1024 + KSubtileIndex * 512;
		if (g_Y < TileCoordinates.g_TilesHigh && g_X < TileCoordinates.g_TilesWide)
		{
			const uint64_t g_Source =
				g_Input + uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
				(ReductionTile * 2 + KSubtileIndex) * 512;
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_CopyOffset, g_Source, 512, s_BarrierOffset);
				BarrierExpect(s_Storage, s_BarrierOffset, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_CopyOffset + TileCoordinates.Lane * 16) =
				make_uint4(0, 0, 0, 0);
	}
}

// Gather the external 16-byte channel-pack layout directly into MMA A layout.
// Logical shared words encode the 4x4 spatial tile, K subtile, lane and word.
// Eight words per thread cover the complete 4 KiB stage without a transpose pass.
template <typename TParameters>
__device__ __forceinline__ void IssueWindowFfnInputViewStage(unsigned char* s_Storage,
															 const TParameters& Parameters, int ReductionTile,
															 const FWindowFfnTileCoordinates& TileCoordinates)
{
#pragma unroll
	for (int CopyIndex = 0; CopyIndex < 8; ++CopyIndex)
	{
		const int sl_Word = TileCoordinates.Warp * 32 + TileCoordinates.Lane + CopyIndex * 128;
		const int g_LocalY = (sl_Word / 512) * 4 + (sl_Word / 64) % 2 + (sl_Word % 2) * 2;
		const int g_LocalX = ((sl_Word / 256) % 2) * 4 + (sl_Word / 16) % 4;
		const int g_Y = Parameters.Height == 1 ? 0 : TileCoordinates.g_TileY * 4 + g_LocalY;
		const int g_X = Parameters.Width == 1 ? 0 : TileCoordinates.g_TileX * 4 + g_LocalX;
		const int g_ChannelPack = ReductionTile * 4 + ((sl_Word / 128) % 2) * 2 + (sl_Word / 2) % 2;
		const int g_Component = (sl_Word / 4) % 4;
		const int s_Destination = (ReductionTile % 2) * 4096 + sl_Word * 4;
		if (g_Y < Parameters.Height && g_X < Parameters.Width)
		{
			const uint64_t g_Source =
				Parameters.g_Input +
				uint64_t((g_ChannelPack * Parameters.Height + g_Y) * Parameters.Width + g_X) * 16 +
				g_Component * 4;
			CopyAsync4(s_Storage, s_Destination, g_Source);
		}
		else
			*reinterpret_cast<uint32_t*>(s_Storage + s_Destination) = 0;
	}
	CopyCommit();
}

template <bool bInputView = false>
__device__ __forceinline__ void WaitWindowFfnInputStage(unsigned char* s_Storage, int ReductionTile)
{
	const int s_BarrierOffset = 8192 + (ReductionTile % 2) * 8;
	if constexpr (bInputView)
		CopyWait0();
	ArriveAndWait(s_Storage, s_BarrierOffset);
}

// MMA output words are already Half A-fragment order. E4 combines two N16
// groups into one K32 fragment and converts at the original quantization boundary.
template <bool bFp8, int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ uint4 LoadWindowFfnInputFragment(
	const FMmaAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator, int r_Spatial, int r_KSubtile)
{
	if constexpr (bFp8)
	{
		const auto& r_LowerChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_KSubtile * 2];
		const auto& r_UpperChannelWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_KSubtile * 2 + 1];
		return make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
						  PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
						  PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
						  PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3]));
	}
	else
	{
		const auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_KSubtile];
		return make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1], r_AccumulatorWords[2],
						  r_AccumulatorWords[3]);
	}
}

// The grouped E4 GEMMs issue one K32 across all M/N tiles before the next K32.
// The dense GEMM and Half grouped GEMMs instead use the common two-K schedule.
template <int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ void
AccumulateWindowFfnSingleFp8(FMmaAccumulatorTile<SpatialFragments, ChannelGroups>& r_Accumulator,
							 const uint4 (&r_Input)[SpatialFragments],
							 const uint4 (&r_Weights)[ChannelGroups])
{
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
#pragma unroll
		for (int r_NTile = 0; r_NTile < ChannelGroups; ++r_NTile)
		{
			auto& r_AccumulatorWords = r_Accumulator.r_AccumulatorWords[r_Spatial][r_NTile];
			const uint4 r_InputFragment = r_Input[r_Spatial];
			const uint4 r_WeightFragment = r_Weights[r_NTile];
			MultiplyAccumulate<EMmaInputPrecision::Fp8>(
				{r_AccumulatorWords[0], r_AccumulatorWords[1]},
				{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
				{r_WeightFragment.x, r_WeightFragment.y}, {r_AccumulatorWords[0], r_AccumulatorWords[1]});
			MultiplyAccumulate<EMmaInputPrecision::Fp8>(
				{r_AccumulatorWords[2], r_AccumulatorWords[3]},
				{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
				{r_WeightFragment.z, r_WeightFragment.w}, {r_AccumulatorWords[2], r_AccumulatorWords[3]});
		}
}

template <int SpatialFragments>
__device__ __forceinline__ void ActivateWindowFfn(FMmaAccumulatorTile<SpatialFragments, 2>& r_Hidden)
{
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
				r_Hidden.r_AccumulatorWords[r_Spatial][r_NTile][r_Word] =
					FfnActivation(r_Hidden.r_AccumulatorWords[r_Spatial][r_NTile][r_Word]);
}

template <bool bFp8, int SpatialFragments>
__device__ __forceinline__ void
ComputeGroupedWindowMlp(FMmaAccumulatorTile<SpatialFragments, 4>& r_Output,
						const FMmaAccumulatorTile<SpatialFragments, 4>& r_Projected, uint64_t g_PackedWeights,
						const FWindowFfnTileCoordinates& TileCoordinates)
{
	using Profile = FWindowFfnProfile<bFp8>;
	const uint64_t g_Expand = g_PackedWeights +
							  (262144 + TileCoordinates.g_ExpertGroup * 16384) * Profile::ElementBytes +
							  TileCoordinates.Lane * 16;
	const uint64_t g_Contract = g_PackedWeights +
								(393216 + TileCoordinates.g_ExpertGroup * 16384) * Profile::ElementBytes +
								TileCoordinates.Lane * 16;

	// Hidden activations stay in registers. Processing 32 hidden channels at a
	// time avoids materializing the 256-channel intermediate in shared/global memory.
#pragma unroll 1
	for (int HiddenTileIndex = 0; HiddenTileIndex < 8; ++HiddenTileIndex)
	{
		FMmaAccumulatorTile<SpatialFragments, 2> r_Hidden{};
#pragma unroll
		for (int r_KPair = 0; r_KPair < 2; ++r_KPair)
		{
			if constexpr (bFp8)
			{
				uint4 r_Input[SpatialFragments], r_Weights[2];
#pragma unroll
				for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
					r_Input[r_Spatial] = LoadWindowFfnInputFragment<true>(r_Projected, r_Spatial, r_KPair);
#pragma unroll
				for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
					r_Weights[r_NTile] = __ldca(reinterpret_cast<const uint4*>(
						g_Expand + HiddenTileIndex * 1024 + r_KPair * 8192 + r_NTile * 512));
				AccumulateWindowFfnSingleFp8(r_Hidden, r_Input, r_Weights);
			}
			else
			{
				uint4 r_Input[SpatialFragments][2], r_Weights[2][2];
#pragma unroll
				for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				{
#pragma unroll
					for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
						r_Input[r_Spatial][r_KSubtile] = LoadWindowFfnInputFragment<false>(
							r_Projected, r_Spatial, r_KPair * 2 + r_KSubtile);
#pragma unroll
					for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
						r_Weights[r_KSubtile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
							g_Expand + HiddenTileIndex * 1024 + (r_KPair * 2 + r_KSubtile) * 8192 +
							r_NTile * 512));
				}
				AccumulateTile<Profile::Precision>(r_Hidden, r_Input, r_Weights);
			}
		}
		ActivateWindowFfn(r_Hidden);

		if constexpr (bFp8)
		{
			uint4 r_Input[SpatialFragments], r_Weights[4];
#pragma unroll
			for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
				r_Input[r_Spatial] = LoadWindowFfnInputFragment<true>(r_Hidden, r_Spatial, 0);
#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weights[r_NTile] = __ldca(
					reinterpret_cast<const uint4*>(g_Contract + HiddenTileIndex * 2048 + r_NTile * 512));
			AccumulateWindowFfnSingleFp8(r_Output, r_Input, r_Weights);
		}
		else
		{
			uint4 r_Input[SpatialFragments][2], r_Weights[2][4];
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			{
#pragma unroll
				for (int r_Spatial = 0; r_Spatial < SpatialFragments; ++r_Spatial)
					r_Input[r_Spatial][r_KSubtile] =
						LoadWindowFfnInputFragment<false>(r_Hidden, r_Spatial, r_KSubtile);
#pragma unroll
				for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
					r_Weights[r_KSubtile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
						g_Contract + HiddenTileIndex * 4096 + r_KSubtile * 2048 + r_NTile * 512));
			}
			AccumulateTile<Profile::Precision>(r_Output, r_Input, r_Weights);
		}
	}
}

template <bool bFp8, bool bInputView = false, typename TParameters>
__device__ __forceinline__ void RunWindowFfn(const TParameters& Parameters, unsigned char* s_Storage)
{
	using Profile = FWindowFfnProfile<bFp8, bInputView>;
	const FWindowFfnTileCoordinates TileCoordinates{Parameters.Height / 4,
													Parameters.Width / 4,
													int(blockIdx.y) * 2,
													int(blockIdx.x) * 2,
													(int(threadIdx.y) % 4) + int(blockIdx.z) * 4,
													int(threadIdx.x),
													int(threadIdx.y)};
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
	{
		BarrierInit(s_Storage, 8192, Profile::Warps * 32);
		BarrierInit(s_Storage, 8200, Profile::Warps * 32);
	}
	__syncthreads();

	uint4 r_Weights[2][4];
	LoadWindowFfnDenseWeights<bFp8>(r_Weights, Parameters.g_PackedWeights, 0, TileCoordinates);
	if constexpr (bInputView)
		IssueWindowFfnInputViewStage(s_Storage, Parameters, 0, TileCoordinates);
	else
		IssueWindowFfnInputStage<bFp8>(s_Storage, Parameters.g_Input, 0, TileCoordinates);
	WaitWindowFfnInputStage<bInputView>(s_Storage, 0);
	FMmaAccumulatorTile<Profile::SpatialFragments, 4> r_Projected{};

	// Two-stage pipeline: issue the next input before current MMA work, then
	// fetch its weights and wait. The final iteration neither refills nor waits.
#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::ReductionTiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::ReductionTiles)
		{
			if constexpr (bInputView)
				IssueWindowFfnInputViewStage(s_Storage, Parameters, ReductionTile + 1, TileCoordinates);
			else
				IssueWindowFfnInputStage<bFp8>(s_Storage, Parameters.g_Input, ReductionTile + 1,
											   TileCoordinates);
		}
		uint4 r_Input[Profile::SpatialFragments][2];
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] = *reinterpret_cast<const uint4*>(
					s_Storage + (ReductionTile % 2) * 4096 +
					(bFp8 && !bInputView ? (TileCoordinates.Warp / 4) * 2048 : 0) + r_Spatial * 1024 +
					r_KSubtile * 512 + TileCoordinates.Lane * 16);
		AccumulateTile<Profile::Precision>(r_Projected, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWindowFfnDenseWeights<bFp8>(r_Weights, Parameters.g_PackedWeights, ReductionTile + 1,
											TileCoordinates);
			WaitWindowFfnInputStage<bInputView>(s_Storage, ReductionTile + 1);
		}
	}

	FMmaAccumulatorTile<Profile::SpatialFragments, 4> r_Output{};
	ComputeGroupedWindowMlp<bFp8>(r_Output, r_Projected, Parameters.g_PackedWeights, TileCoordinates);
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
	{
		const int g_Y =
			TileCoordinates.g_TileY + (bFp8 && !bInputView ? TileCoordinates.Warp / 4 : r_Spatial / 2);
		const int g_X = TileCoordinates.g_TileX + (bFp8 && !bInputView ? r_Spatial : r_Spatial % 2);
		if (g_Y >= TileCoordinates.g_TilesHigh || g_X >= TileCoordinates.g_TilesWide)
			continue;
		const uint64_t g_OutputTileBase =
			Parameters.g_Output +
			uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
			TileCoordinates.g_ExpertGroup * 1024 * Profile::ElementBytes + TileCoordinates.Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < (bFp8 ? 2 : 4); ++r_NTile)
			StoreNoAllocate(g_OutputTileBase + r_NTile * 512,
							LoadWindowFfnInputFragment<bFp8>(r_Output, r_Spatial, r_NTile));
	}
}
#endif
