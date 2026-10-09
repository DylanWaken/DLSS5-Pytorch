// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "../../shared/common/kernel_helpers.cuh"
#include "../common/window_qkv.cuh"

extern "C" __global__ __maxnreg__(168) void window_qkv_c512_fp8(FWindowQkvC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	using Profile = FWindowQkvProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::s_BarrierBase + 16];
	const FWindowQkvCoordinates TileCoordinates{Parameters.Height / 4,
												Parameters.Width / 4,
												(int(blockIdx.y) * 8 + Parameters.OriginY) / 4,
												(int(blockIdx.x) * 8 + Parameters.OriginX) / 4,
												int(blockIdx.z) * 4 + int(threadIdx.y),
												int(threadIdx.x),
												int(threadIdx.y)};

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
	{
		BarrierInit(s_Storage, Profile::s_BarrierBase, 128);
		BarrierInit(s_Storage, Profile::s_BarrierBase + 8, 128);
	}

	__syncthreads();
	FWindowQkvDenseTile r_Projected{};
	uint4 r_Weights[Profile::KSubtiles][6];

	// Load this head's adjacent Q, K and V weight panels into register fragments.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			Parameters.g_PackedWeights +
			uint64_t(ReductionTile * Profile::ReductionStep) * 1536 * Profile::ElementBytes +
			TileCoordinates.g_Head * 3072 + TileCoordinates.Lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::KSubtiles; ++r_KSubtile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 6; ++r_NTile)
				r_Weights[r_KSubtile][r_NTile] = __ldca(
					reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 49152 + r_NTile * 512));
	};

	// Stage bounded input tiles with async copies; reuse the same addressing on refill.
	const auto IssueInput = [&](int ReductionTile)
	{
		const int s_Barrier = Profile::s_BarrierBase + (ReductionTile % 2) * 8;
		#pragma unroll
		for (int CopyIndex = 0; CopyIndex < (bFp8 ? 2 : 1); ++CopyIndex)
		{
			const int g_LocalY = bFp8 ? CopyIndex : TileCoordinates.Warp / 2;
			const int g_LocalX = bFp8 ? TileCoordinates.Warp / 2 : TileCoordinates.Warp % 2;
			const int KSubtileIndex = bFp8 ? TileCoordinates.Warp % 2 : 0;
			const int g_Y = TileCoordinates.g_TilesHigh == 1 ? 0 : TileCoordinates.g_TileY + g_LocalY;
			const int g_X = TileCoordinates.g_TilesWide == 1 ? 0 : TileCoordinates.g_TileX + g_LocalX;
			const int s_Destination = (ReductionTile % 2) * Profile::s_StageBytes +
									  ((g_LocalY * 2 + g_LocalX) * Profile::KSubtiles + KSubtileIndex) * 512;
			if (g_Y >= 0 && g_Y < TileCoordinates.g_TilesHigh && g_X >= 0 &&
				g_X < TileCoordinates.g_TilesWide)
			{
				const uint64_t g_Source =
					Parameters.g_Input +
					uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * 8192 * Profile::ElementBytes +
					(ReductionTile * Profile::KSubtiles + KSubtileIndex) * 512;
				if (Elected(0xffffffffu))
				{
					CopyBulk(s_Storage, s_Destination, g_Source, 512, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, 512);
				}
			}
			else
				*reinterpret_cast<uint4*>(s_Storage + s_Destination + TileCoordinates.Lane * 16) =
					make_uint4(0, 0, 0, 0);
		}
	};

	// Wait for the selected shared-memory stage before its fragments are consumed.
	const auto WaitInput = [&](int ReductionTile)
	{
		const int s_Barrier = FWindowQkvProfile<bFp8>::s_BarrierBase + (ReductionTile % 2) * 8;
		ArriveAndWait(s_Storage, s_Barrier);
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	IssueInput(0);
	WaitInput(0);

	// Native Half uses K16 and a 2 KiB stage. FP8 uses two K32 instructions
	// and a 4 KiB stage. Both schedules ping-pong between two input stages.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::ReductionTiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::ReductionTiles)
			IssueInput(ReductionTile + 1);
		uint4 r_Input[4][Profile::KSubtiles];
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < Profile::KSubtiles; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] = *reinterpret_cast<const uint4*>(
					s_Storage + (ReductionTile % 2) * Profile::s_StageBytes +
					(r_Spatial * Profile::KSubtiles + r_KSubtile) * 512 + TileCoordinates.Lane * 16);
		AccumulateTile<Profile::Precision>(r_Projected, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights(ReductionTile + 1);
			WaitInput(ReductionTile + 1);
		}
	}

	// Project the FFN output into Q/K/V fragments and normalize the query/key rows.
	FWindowActivationTile<bFp8> r_Query[4], r_Key[4];
	FWindowValueTile<bFp8> r_Value[4];
	const uint32_t r_HeadScale = FloatToHalf2(*reinterpret_cast<const uint32_t*>(
		Parameters.g_PackedWeights + Profile::HeadScaleOffset + TileCoordinates.g_Head * 4));
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		FWindowAccumulatorTile<32> r_Qkv[3];
		#pragma unroll
		for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Qkv[r_QkvComponent].r_Pair[r_Column][r_RowHalf] =
						r_Projected.r_AccumulatorWords[r_Spatial][r_QkvComponent * 2 + r_Column / 2]
													  [(r_Column % 2) * 2 + r_RowHalf];
		NormalizeWindow<true>(r_Qkv[0], r_HeadScale);
		NormalizeWindow<false>(r_Qkv[1], CONST_HALF2_ONE);
		r_Query[r_Spatial] = PublishWindow32<bFp8>(r_Qkv[0]);
		r_Key[r_Spatial] = PublishWindow32<bFp8>(r_Qkv[1]);
		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			const uint32_t r_LowerValueRows = TransposeM8n8(r_Qkv[2].r_Pair[r_Column][0]);
			const uint32_t r_UpperValueRows = TransposeM8n8(r_Qkv[2].r_Pair[r_Column][1]);
			r_Value[r_Spatial].r_Column[r_Column][0] = PackHalfPairsE4(r_LowerValueRows, r_UpperValueRows);
		}
	}

	// Q/K normalization and the affine-exponent softmax use the same exact
	// packed-Half operations as the smaller window blocks. Attention stays in registers.
	const auto* g_HeadBias = reinterpret_cast<const unsigned char*>(
		Parameters.g_PackedWeights + Profile::BiasOffset + TileCoordinates.g_Head * 8192);
	{
		// The native softmax transposes two adjacent query tiles together:
		// one inverse per logical row replaces four identical lane copies.
		#pragma unroll
		for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += 2)
		{
			FWindowActivationTile<true> r_Attended[2];

			// Two adjacent query tiles share one warp transpose for their four
			// row-half denominator vectors, matching the recovered native schedule.
			FWindowAccumulatorTile<64> r_Probabilities[2];
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
				r_Probabilities[r_LocalTile] =
					QueryKeyScores<true>(r_FirstTile + r_LocalTile, g_HeadBias, r_Query, r_Key);
			SoftmaxWindowPair(r_Probabilities);
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
				r_Attended[r_LocalTile] =
					PublishWindow32<true>(ProbabilityValues<true>(r_Probabilities[r_LocalTile], r_Value));
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
			{
				const int r_Spatial = r_FirstTile + r_LocalTile;
				const int g_Y = TileCoordinates.g_TileY + r_Spatial / 2,
						  g_X = TileCoordinates.g_TileX + r_Spatial % 2;
				if (g_Y < 0 || g_Y >= TileCoordinates.g_TilesHigh || g_X < 0 ||
					g_X >= TileCoordinates.g_TilesWide)
					continue;
				const auto& r_AttendedFragment = r_Attended[r_LocalTile].r_Reduction[0];
				const uint64_t g_OutputFragmentAddress =
					Parameters.g_Output + uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * 8192 +
					TileCoordinates.g_Head * 512 + TileCoordinates.Lane * 16;
				StoreNoAllocate(g_OutputFragmentAddress,
								make_uint4(r_AttendedFragment.r_Word[0], r_AttendedFragment.r_Word[1],
										   r_AttendedFragment.r_Word[2], r_AttendedFragment.r_Word[3]));
			}
		}
	}
#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
