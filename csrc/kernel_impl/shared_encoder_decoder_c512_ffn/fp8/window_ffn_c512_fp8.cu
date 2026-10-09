// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "../../shared/common/kernel_helpers.cuh"
#include "../common/window_ffn.cuh"

extern "C" __global__ __maxnreg__(128) void window_ffn_c512_fp8(FWindowFfnC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	constexpr bool bInputView = false;
	using Profile = FWindowFfnProfile<bFp8, bInputView>;
	__shared__ __align__(512) unsigned char s_Storage[8208];
	const FWindowFfnTileCoordinates TileCoordinates{Parameters.Height / 4,
													Parameters.Width / 4,
													int(blockIdx.y) * 2,
													int(blockIdx.x) * 2,
													(int(threadIdx.y) % 4) + int(blockIdx.z) * 4,
													int(threadIdx.x),
													int(threadIdx.y)};

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
	{
		BarrierInit(s_Storage, 8192, Profile::Warps * 32);
		BarrierInit(s_Storage, 8200, Profile::Warps * 32);
	}

	__syncthreads();

	uint4 r_Weights[2][4];

	// Prefill and refill share the same addressing and native copy protocol.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			Parameters.g_PackedWeights +
			uint64_t(ReductionTile * Profile::ReductionStep) * 512 * Profile::ElementBytes +
			TileCoordinates.g_ExpertGroup * 2048 + TileCoordinates.Lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weights[r_KSubtile][r_NTile] = __ldca(
					reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 16384 + r_NTile * 512));
	};

	// Stage bounded input tiles with async copies; reuse the same addressing on refill.
	const auto IssueInput = [&](int ReductionTile)
	{
		{
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
				const int s_CopyOffset =
					s_StageOffset + g_LocalY * 2048 + g_LocalX * 1024 + KSubtileIndex * 512;
				if (g_Y < TileCoordinates.g_TilesHigh && g_X < TileCoordinates.g_TilesWide)
				{
					const uint64_t g_Source =
						Parameters.g_Input +
						uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
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
	};

	// Wait for the selected shared-memory stage before its fragments are consumed.
	const auto WaitInput = [&](int ReductionTile)
	{
		const int s_BarrierOffset = 8192 + (ReductionTile % 2) * 8;
		{
		}

		ArriveAndWait(s_Storage, s_BarrierOffset);
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	IssueInput(0);
	WaitInput(0);
	FMmaAccumulatorTile<Profile::SpatialFragments, 4> r_Projected{};

	// Two-stage pipeline: issue the next input before current MMA work, then
	// fetch its weights and wait. The final iteration neither refills nor waits.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::ReductionTiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::ReductionTiles)
		{
			IssueInput(ReductionTile + 1);
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
			LoadWeights(ReductionTile + 1);
			WaitInput(ReductionTile + 1);
		}
	}

	FMmaAccumulatorTile<Profile::SpatialFragments, 4> r_Output{};

	// Grouped MLP keeps each hidden panel in registers through expansion and contraction.
	const uint64_t g_Expand = Parameters.g_PackedWeights +
							  (262144 + TileCoordinates.g_ExpertGroup * 16384) * Profile::ElementBytes +
							  TileCoordinates.Lane * 16;
	const uint64_t g_Contract = Parameters.g_PackedWeights +
								(393216 + TileCoordinates.g_ExpertGroup * 16384) * Profile::ElementBytes +
								TileCoordinates.Lane * 16;

	// Hidden activations stay in registers. Processing 32 hidden channels at a
	// time avoids materializing the 256-channel intermediate in shared/global memory.
	#pragma unroll 1
	for (int HiddenTileIndex = 0; HiddenTileIndex < 8; ++HiddenTileIndex)
	{
		FMmaAccumulatorTile<Profile::SpatialFragments, 2> r_Hidden{};
		#pragma unroll
		for (int r_KPair = 0; r_KPair < 2; ++r_KPair)
		{
			{
				uint4 r_Input[Profile::SpatialFragments], r_Weights[2];
				#pragma unroll
				for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
					r_Input[r_Spatial] = LoadWindowFfnInputFragment<true>(r_Projected, r_Spatial, r_KPair);
				#pragma unroll
				for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
					r_Weights[r_NTile] = __ldca(reinterpret_cast<const uint4*>(
						g_Expand + HiddenTileIndex * 1024 + r_KPair * 8192 + r_NTile * 512));
				AccumulateWindowFfnSingleFp8(r_Hidden, r_Input, r_Weights);
			}
		}

		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
				#pragma unroll
				for (int r_Word = 0; r_Word < 4; ++r_Word)
					r_Hidden.r_AccumulatorWords[r_Spatial][r_NTile][r_Word] =
						FfnActivation(r_Hidden.r_AccumulatorWords[r_Spatial][r_NTile][r_Word]);

		{
			uint4 r_Input[Profile::SpatialFragments], r_Weights[4];
			#pragma unroll
			for (int r_Spatial = 0; r_Spatial < Profile::SpatialFragments; ++r_Spatial)
				r_Input[r_Spatial] = LoadWindowFfnInputFragment<true>(r_Hidden, r_Spatial, 0);
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weights[r_NTile] = __ldca(
					reinterpret_cast<const uint4*>(g_Contract + HiddenTileIndex * 2048 + r_NTile * 512));
			AccumulateWindowFfnSingleFp8(r_Output, r_Input, r_Weights);
		}
	}

	// Publish contracted expert fragments only for valid spatial tiles.
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
#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
