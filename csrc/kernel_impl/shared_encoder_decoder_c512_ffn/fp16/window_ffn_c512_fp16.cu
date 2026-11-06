// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.

#include <common/layout/numerical_constants.h>
#include <common/layout/spatial_projection.h>
#include <common/layout/window_profiles.h>
#include <common/ops/activation.h>
#include <common/ops/frontend_texture.h>
#include <common/ops/window_attention.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/mma.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include <flashlight/warp/permutation.cuh>
#include <cstdint>

extern "C" __global__ __maxnreg__(255) void window_ffn_c512_fp16(FWindowFfnC512Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	constexpr bool bFp8 = false;
	constexpr bool bInputView = false;
	using Profile = dlssnr::layout::WindowFfnProfile<bFp8, bInputView>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::barrier_base + 16];
	const dlssnr::layout::WindowFfnTileCoordinates TileCoordinates{Parameters.Height / 4,
																   Parameters.Width / 4,
																   int(blockIdx.y) * 2,
																   int(blockIdx.x) * 2,
																   (int(threadIdx.y) % 4) +
																	   int(blockIdx.z) * 4,
																   int(threadIdx.x),
																   int(threadIdx.y)};

	// Two physical input stages with the barrier pair at the recovered base.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	using StageView =
		flashlight::memory::StagedSharedLayoutView<uint4,
												   flashlight::layout::ByteStrides<2048, 1024, 512, 16>,
												   Profile::stage_count, Profile::stage_bytes>;
	const StageView Stages(Shared);
	const flashlight::memory::TransactionBarrierRing<Profile::stage_count> Barriers(Shared,
																					Profile::barrier_base);

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
	{
		Barriers.at_slot(0).initialize(Profile::warps * 32);
		Barriers.at_slot(1).initialize(Profile::warps * 32);
	}

	__syncthreads();

	uint4 r_Weights[2][4];

	// Prefill and refill share the same addressing and native copy protocol.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			Parameters.g_PackedWeights +
			uint64_t(ReductionTile * Profile::reduction_step) * 512 * Profile::element_bytes +
			TileCoordinates.expert_group * 2048 + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
				r_Weights[r_KSubtile][r_NTile] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_WeightTileBase + r_KSubtile * 16384 +
														  r_NTile * 512));
	};

	// Stage bounded input tiles with async copies; reuse the same addressing on refill.
	const auto IssueInput = [&](int ReductionTile)
	{
		{
			const int KSubtileIndex = TileCoordinates.warp & 1;
			const int g_LocalX = (TileCoordinates.warp / 2) % 2;

			// Eight FP8 warps each transfer 512 bytes; four Half warps each transfer
			// two rows. Singleton dimensions broadcast, other incomplete edges zero-fill.
			#pragma unroll
			for (int CopyIndex = 0; CopyIndex < (bFp8 ? 1 : 2); ++CopyIndex)
			{
				const int g_LocalY = bFp8 ? TileCoordinates.warp / 4 : CopyIndex;
				const int g_Y = TileCoordinates.tiles_high == 1 ? 0 : TileCoordinates.tile_y + g_LocalY;
				const int g_X = TileCoordinates.tiles_wide == 1 ? 0 : TileCoordinates.tile_x + g_LocalX;
				if (g_Y < TileCoordinates.tiles_high && g_X < TileCoordinates.tiles_wide)
				{
					const uint64_t g_Source =
						Parameters.g_Input +
						uint64_t(g_Y * TileCoordinates.tiles_wide + g_X) * Profile::spatial_tile_bytes +
						(ReductionTile * 2 + KSubtileIndex) * 512;
					if (flashlight::arch::is_copy_producer(0xffffffffu))
					{
						Barriers.for_iteration(ReductionTile)
							.copy_then_expect(
								Stages.byte_offset(ReductionTile, g_LocalY, g_LocalX, KSubtileIndex, 0),
								flashlight::memory::GlobalAddress(g_Source), 512);
					}
				}
				else
					Stages.store(make_uint4(0, 0, 0, 0), ReductionTile, g_LocalY, g_LocalX, KSubtileIndex,
								 TileCoordinates.lane);
			}
		}
	};

	// Wait for the selected shared-memory stage before its fragments are consumed.
	const auto WaitInput = [&](int ReductionTile)
	{ Barriers.for_iteration(ReductionTile).arrive_and_wait(); };

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	IssueInput(0);
	WaitInput(0);
	flashlight::tile::TiledMmaAccumulator<Profile::spatial_fragments, 4> r_Projected{};

	// Two-stage pipeline: issue the next input before current MMA work, then
	// fetch its weights and wait. The final iteration neither refills nor waits.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::reduction_tiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::reduction_tiles)
		{
			IssueInput(ReductionTile + 1);
		}

		uint4 r_Input[Profile::spatial_fragments][2];
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < Profile::spatial_fragments; ++r_Spatial)
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] =
					Stages.load(ReductionTile, (bFp8 && !bInputView ? TileCoordinates.warp / 4 : 0),
								r_Spatial, r_KSubtile, TileCoordinates.lane);
		flashlight::tile::accumulate_tile<Profile::precision>(r_Projected, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::reduction_tiles)
		{
			LoadWeights(ReductionTile + 1);
			WaitInput(ReductionTile + 1);
		}
	}

	flashlight::tile::TiledMmaAccumulator<Profile::spatial_fragments, 4> r_Output{};

	// Grouped MLP keeps each hidden panel in registers through expansion and contraction.
	const uint64_t g_Expand = Parameters.g_PackedWeights +
							  (262144 + TileCoordinates.expert_group * 16384) * Profile::element_bytes +
							  TileCoordinates.lane * 16;
	const uint64_t g_Contract = Parameters.g_PackedWeights +
								(393216 + TileCoordinates.expert_group * 16384) * Profile::element_bytes +
								TileCoordinates.lane * 16;

	// Hidden activations stay in registers. Processing 32 hidden channels at a
	// time avoids materializing the 256-channel intermediate in shared/global memory.
	#pragma unroll 1
	for (int HiddenTileIndex = 0; HiddenTileIndex < 8; ++HiddenTileIndex)
	{
		flashlight::tile::TiledMmaAccumulator<Profile::spatial_fragments, 2> r_Hidden{};
		#pragma unroll
		for (int r_KPair = 0; r_KPair < 2; ++r_KPair)
		{
			{
				uint4 r_Input[Profile::spatial_fragments][2], r_Weights[2][2];
				#pragma unroll
				for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				{
					#pragma unroll
					for (int r_Spatial = 0; r_Spatial < Profile::spatial_fragments; ++r_Spatial)
						r_Input[r_Spatial][r_KSubtile] = dlssnr::ops::load_window_ffn_input_fragment<false>(
							r_Projected, r_Spatial, r_KPair * 2 + r_KSubtile);
					#pragma unroll
					for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
						r_Weights[r_KSubtile][r_NTile] =
							flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
								flashlight::memory::GlobalAddress(g_Expand + HiddenTileIndex * 1024 +
																  (r_KPair * 2 + r_KSubtile) * 8192 +
																  r_NTile * 512));
				}
				flashlight::tile::accumulate_tile<Profile::precision>(r_Hidden, r_Input, r_Weights);
			}
		}

		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < Profile::spatial_fragments; ++r_Spatial)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 2; ++r_NTile)
				#pragma unroll
				for (int r_Word = 0; r_Word < 4; ++r_Word)
					r_Hidden.word[r_Spatial][r_NTile][r_Word] =
						dlssnr::ops::activate_window(
							flashlight::PackedHalf2{r_Hidden.word[r_Spatial][r_NTile][r_Word]})
							.bits;

		{
			uint4 r_Input[Profile::spatial_fragments][2], r_Weights[2][4];
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			{
				#pragma unroll
				for (int r_Spatial = 0; r_Spatial < Profile::spatial_fragments; ++r_Spatial)
					r_Input[r_Spatial][r_KSubtile] =
						dlssnr::ops::load_window_ffn_input_fragment<false>(r_Hidden, r_Spatial, r_KSubtile);
				#pragma unroll
				for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
					r_Weights[r_KSubtile][r_NTile] =
						flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
							flashlight::memory::GlobalAddress(g_Contract + HiddenTileIndex * 4096 +
															  r_KSubtile * 2048 + r_NTile * 512));
			}
			flashlight::tile::accumulate_tile<Profile::precision>(r_Output, r_Input, r_Weights);
		}
	}

	// Publish contracted expert fragments only for valid spatial tiles.
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < Profile::spatial_fragments; ++r_Spatial)
	{
		const int g_Y =
			TileCoordinates.tile_y + (bFp8 && !bInputView ? TileCoordinates.warp / 4 : r_Spatial / 2);
		const int g_X = TileCoordinates.tile_x + (bFp8 && !bInputView ? r_Spatial : r_Spatial % 2);
		if (g_Y >= TileCoordinates.tiles_high || g_X >= TileCoordinates.tiles_wide)
			continue;
		const uint64_t g_OutputTileBase =
			Parameters.g_Output +
			uint64_t(g_Y * TileCoordinates.tiles_wide + g_X) * Profile::spatial_tile_bytes +
			TileCoordinates.expert_group * 1024 * Profile::element_bytes + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_NTile = 0; r_NTile < (bFp8 ? 2 : 4); ++r_NTile)
			flashlight::memory::store_no_allocate(
				flashlight::memory::GlobalAddress(g_OutputTileBase + r_NTile * 512),
				dlssnr::ops::load_window_ffn_input_fragment<bFp8>(r_Output, r_Spatial, r_NTile));
	}
#endif
}
