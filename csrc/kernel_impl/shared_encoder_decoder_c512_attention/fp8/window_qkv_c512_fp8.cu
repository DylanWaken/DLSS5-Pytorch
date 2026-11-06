// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include <common/layout/window_profiles.h>
#include <common/ops/window_attention.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include <cstdint>

extern "C" __global__ __maxnreg__(168) void window_qkv_c512_fp8(FWindowQkvC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	using Profile = dlssnr::layout::WindowQkvProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::barrier_base + 16];
	const dlssnr::layout::WindowQkvCoordinates TileCoordinates{Parameters.Height / 4,
															   Parameters.Width / 4,
															   (int(blockIdx.y) * 8 + Parameters.OriginY) / 4,
															   (int(blockIdx.x) * 8 + Parameters.OriginX) / 4,
															   int(blockIdx.z) * 4 + int(threadIdx.y),
															   int(threadIdx.x),
															   int(threadIdx.y)};

	// Two physical input stages with this head's barrier pair at the recovered
	// base. The view owns the spatial/K/lane stage arithmetic for both sides.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	using StageView = flashlight::memory::StagedSharedLayoutView<
		uint4, flashlight::layout::ByteStrides<Profile::k_subtiles * 512, 512, 16>, Profile::stage_count,
		Profile::stage_bytes>;
	const StageView Stages(Shared);
	const flashlight::memory::TransactionBarrierRing<Profile::stage_count> Barriers(Shared,
																					Profile::barrier_base);

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
	{
		Barriers.at_slot(0).initialize(128);
		Barriers.at_slot(1).initialize(128);
	}

	__syncthreads();
	flashlight::tile::TiledMmaAccumulator<4, 6> r_Projected{};
	uint4 r_Weights[Profile::k_subtiles][6];

	// Load this head's adjacent Q, K and V weight panels into register fragments.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			Parameters.g_PackedWeights +
			uint64_t(ReductionTile * Profile::reduction_step) * 1536 * Profile::element_bytes +
			TileCoordinates.head * 3072 + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::k_subtiles; ++r_KSubtile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 6; ++r_NTile)
				r_Weights[r_KSubtile][r_NTile] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_WeightTileBase + r_KSubtile * 49152 +
														  r_NTile * 512));
	};

	// Stage bounded input tiles with async copies; reuse the same addressing on refill.
	const auto IssueInput = [&](int ReductionTile)
	{
		#pragma unroll
		for (int CopyIndex = 0; CopyIndex < (bFp8 ? 2 : 1); ++CopyIndex)
		{
			const int g_LocalY = bFp8 ? CopyIndex : TileCoordinates.warp / 2;
			const int g_LocalX = bFp8 ? TileCoordinates.warp / 2 : TileCoordinates.warp % 2;
			const int KSubtileIndex = bFp8 ? TileCoordinates.warp % 2 : 0;
			const int g_Y = TileCoordinates.tiles_high == 1 ? 0 : TileCoordinates.tile_y + g_LocalY;
			const int g_X = TileCoordinates.tiles_wide == 1 ? 0 : TileCoordinates.tile_x + g_LocalX;
			const int s_Spatial = g_LocalY * 2 + g_LocalX;
			if (g_Y >= 0 && g_Y < TileCoordinates.tiles_high && g_X >= 0 && g_X < TileCoordinates.tiles_wide)
			{
				const uint64_t g_Source =
					Parameters.g_Input +
					uint64_t(g_Y * TileCoordinates.tiles_wide + g_X) * 8192 * Profile::element_bytes +
					(ReductionTile * Profile::k_subtiles + KSubtileIndex) * 512;
				if (flashlight::arch::is_copy_producer(0xffffffffu))
				{
					Barriers.for_iteration(ReductionTile)
						.copy_then_expect(Stages.byte_offset(ReductionTile, s_Spatial, KSubtileIndex, 0),
										  flashlight::memory::GlobalAddress(g_Source), 512);
				}
			}
			else
				Stages.store(make_uint4(0, 0, 0, 0), ReductionTile, s_Spatial, KSubtileIndex,
							 TileCoordinates.lane);
		}
	};

	// Wait for the selected shared-memory stage before its fragments are consumed.
	const auto WaitInput = [&](int ReductionTile)
	{ Barriers.for_iteration(ReductionTile).arrive_and_wait(); };

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	IssueInput(0);
	WaitInput(0);

	// Native Half uses K16 and a 2 KiB stage. FP8 uses two K32 instructions
	// and a 4 KiB stage. Both schedules ping-pong between two input stages.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::reduction_tiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::reduction_tiles)
			IssueInput(ReductionTile + 1);
		uint4 r_Input[4][Profile::k_subtiles];
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < Profile::k_subtiles; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] =
					Stages.load(ReductionTile, r_Spatial, r_KSubtile, TileCoordinates.lane);
		flashlight::tile::accumulate_tile<Profile::precision>(r_Projected, r_Input, r_Weights);

		if (ReductionTile + 1 < Profile::reduction_tiles)
		{
			LoadWeights(ReductionTile + 1);
			WaitInput(ReductionTile + 1);
		}
	}

	// Project the FFN output into Q/K/V fragments and normalize the query/key rows.
	dlssnr::layout::WindowActivationTile<bFp8> r_Query[4], r_Key[4];
	dlssnr::layout::WindowValueTile<bFp8> r_Value[4];
	const uint32_t r_HeadScale =
		flashlight::numeric::half2_from_float_bits(
			*flashlight::memory::GlobalAddress(Parameters.g_PackedWeights + Profile::head_scale_offset +
											   TileCoordinates.head * 4)
				 .as_pointer<const std::uint32_t>())
			.bits;
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		dlssnr::layout::WindowAccumulatorTile<32> r_Qkv[3];
		#pragma unroll
		for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Qkv[r_QkvComponent].pair[r_Column][r_RowHalf] =
						r_Projected.word[r_Spatial][r_QkvComponent * 2 + r_Column / 2]
										[(r_Column % 2) * 2 + r_RowHalf];
		dlssnr::ops::normalize_window<true>(r_Qkv[0], flashlight::PackedHalf2{r_HeadScale});
		dlssnr::ops::normalize_window<false>(r_Qkv[1], flashlight::PackedHalf2{dlssnr::layout::half2_one});
		r_Query[r_Spatial] = dlssnr::ops::publish_window32<bFp8>(r_Qkv[0]);
		r_Key[r_Spatial] = dlssnr::ops::publish_window32<bFp8>(r_Qkv[1]);
		r_Value[r_Spatial] = dlssnr::ops::publish_window_value<bFp8>(r_Qkv[2]);
	}

	// Q/K normalization and the affine-exponent softmax use the same exact
	// packed-Half operations as the smaller window blocks. Attention stays in registers.
	const auto* g_HeadBias = reinterpret_cast<const unsigned char*>(
		Parameters.g_PackedWeights + Profile::bias_offset + TileCoordinates.head * 8192);
	{
		// The native FP8 softmax transposes two adjacent query tiles together:
		// one inverse per logical row replaces four identical lane copies.
		#pragma unroll
		for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += 2)
		{
			dlssnr::layout::WindowActivationTile<bFp8> r_Attended[2];

			// Two adjacent query tiles share one warp transpose for their four
			// row-half denominator vectors, matching the recovered native schedule.
			dlssnr::layout::WindowAccumulatorTile<64> r_Probabilities[2];
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
				r_Probabilities[r_LocalTile] = dlssnr::ops::query_key_scores<true>(
					r_FirstTile + r_LocalTile, g_HeadBias, r_Query, r_Key);
			dlssnr::ops::softmax_window_pair(r_Probabilities);
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
				r_Attended[r_LocalTile] = dlssnr::ops::publish_window32<true>(
					dlssnr::ops::probability_values<true>(r_Probabilities[r_LocalTile], r_Value));
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
			{
				const int r_Spatial = r_FirstTile + r_LocalTile;
				const int g_Y = TileCoordinates.tile_y + r_Spatial / 2,
						  g_X = TileCoordinates.tile_x + r_Spatial % 2;
				if (g_Y < 0 || g_Y >= TileCoordinates.tiles_high || g_X < 0 ||
					g_X >= TileCoordinates.tiles_wide)
					continue;
				const auto& r_AttendedFragment = r_Attended[r_LocalTile].reduction[0];
				const uint64_t g_OutputFragmentAddress =
					Parameters.g_Output +
					uint64_t(g_Y * TileCoordinates.tiles_wide + g_X) * 8192 * Profile::element_bytes +
					TileCoordinates.head * 512 * Profile::element_bytes + TileCoordinates.lane * 16;
				flashlight::memory::store_no_allocate(
					flashlight::memory::GlobalAddress(g_OutputFragmentAddress),
					make_uint4(r_AttendedFragment.word[0], r_AttendedFragment.word[1],
							   r_AttendedFragment.word[2], r_AttendedFragment.word[3]));
			}
		}
	}

#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
