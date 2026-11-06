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

extern "C" __global__ __maxnreg__(128) void window_ffn_projection_input_view_c512_fp8(
	FWindowFfnProjectionInputViewC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	constexpr int SpatialTiles = 4;
	constexpr bool bInputPlane = true;
	constexpr bool bOutputPlane = false;
	constexpr int StageCount = 3;
	constexpr bool bPool = false;
	using Profile = dlssnr::layout::SpatialProjectionProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[StageCount * (Profile::stage_bytes + 8)];
	const int g_Columns = (Parameters.Width + 7) / 8;
	const dlssnr::layout::SpatialProjectionTileCoordinates TileCoordinates{Parameters.Height / 4,
																		   Parameters.Width / 4,
																		   int(blockIdx.y) * 2,
																		   int(blockIdx.x) % g_Columns * 2,
																		   int(blockIdx.x) / g_Columns * 256 +
																			   (int(threadIdx.y) % 4) * 64,
																		   int(threadIdx.x),
																		   int(threadIdx.y)};

	// One physical three-stage ring shared by the producer stripes and the
	// consumer fragments; barriers at StageCount * stage_bytes.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	using StageView = flashlight::memory::StagedSharedLayoutView<
		uint4, flashlight::layout::ByteStrides<2048, 1024, 512, 16>, StageCount, Profile::stage_bytes>;
	const StageView Stages(Shared);
	const flashlight::memory::TransactionBarrierRing<StageCount> Barriers(Shared,
																		  StageCount * Profile::stage_bytes);

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
	{
		#pragma unroll
		for (int s_Stage = 0; s_Stage < StageCount; ++s_Stage)
			Barriers.at_slot(s_Stage).initialize(blockDim.x * blockDim.y);
	}

	__syncthreads();

	uint4 r_Weights[2][4];

	// Reuse the native prefill/refill addressing without hiding the pipeline loop.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_ReductionBase =
			Parameters.g_PackedWeights +
			uint64_t(blockIdx.z * 512 + ReductionTile * Profile::reduction_step) * 512 *
				Profile::element_bytes +
			TileCoordinates.output_channel * 32 + TileCoordinates.lane * 16;

		// The native matrix stores one warp's N16 fragment as a 512-byte vector stripe.
		// Both precisions consume two instruction-K subtiles, separated by16KiB.
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				r_Weights[r_KSubtile][r_ChannelGroup] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_ReductionBase + r_KSubtile * 16384 +
														  r_ChannelGroup * 512));
	};

	// Stage bounded input tiles with async copies; reuse the same addressing on refill.
	const auto IssueInput = [&](int ReductionTile)
	{
		const int KSubtileIndex = TileCoordinates.warp & 1;
		const int g_LocalX = (TileCoordinates.warp >> 1) & 1;

		// Every stage transfers eight 512-byte stripes across four spatial tiles.
		// The three-stage ring overlaps input transfers with the register-resident GEMM.
		#pragma unroll
		for (int g_LocalY = TileCoordinates.warp / 4; g_LocalY < TileCoordinates.warp / 4 + SpatialTiles / 2;
			 ++g_LocalY)
		{
			int g_Y = TileCoordinates.tile_y + g_LocalY;
			int g_X = TileCoordinates.tile_x + g_LocalX;
			const bool bValid =
				dlssnr::layout::resolve_spatial_projection_input_tile(g_Y, g_X, TileCoordinates);
			if (bValid)
			{
				const uint64_t g_Source = Parameters.g_Input +
										  uint64_t(g_Y * TileCoordinates.tiles_wide + g_X + blockIdx.z) *
											  Profile::spatial_tile_bytes +
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
			{
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
	#pragma unroll
	for (int StageIndex = 0; StageIndex < StageCount; ++StageIndex)
		IssueInput(StageIndex);
	WaitInput(0);
	flashlight::tile::TiledMmaAccumulator<SpatialTiles, 4> r_Accumulator;

	// Seed the GEMM with the scaled residual in accumulator order.
	uint32_t r_ResidualScales[4][2];
	#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
		#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_ResidualScales[r_ChannelGroup][r_N8] =
				*flashlight::memory::GlobalAddress(Parameters.g_PackedWeights + Profile::matrix_bytes +
												   (TileCoordinates.output_channel + r_ChannelGroup * 16 +
													r_N8 * 8 + (TileCoordinates.lane & 3) * 2) *
													   2)
					 .as_pointer<const std::uint32_t>();

	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		{
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY = (TileCoordinates.tile_y + r_Spatial / 2) * 4 +
										 TileCoordinates.lane / 16 + r_RowHalf * 2;
					const int g_PixelX =
						(TileCoordinates.tile_x + r_Spatial % 2) * 4 + (TileCoordinates.lane / 4) % 4;
					const bool bPixelValid = g_PixelY < TileCoordinates.tiles_high * 4 &&
											 g_PixelX < TileCoordinates.tiles_wide * 4;
					#pragma unroll
					for (int r_N8 = 0; r_N8 < 2; ++r_N8)
					{
						const int g_Panel =
							(TileCoordinates.output_channel + r_ChannelGroup * 16 + r_N8 * 8) /
							(bFp8 ? 16 : 8);
						const uint64_t g_ResidualWordAddress =
							dlssnr::layout::spatial_projection_plane_word_address<bFp8>(
								Parameters.g_Residual, g_Panel, g_PixelY, g_PixelX, TileCoordinates);
						uint32_t r_ResidualPair =
							bPixelValid ? flashlight::memory::load_vector<flashlight::memory::CachePolicy::Cg,
																		  uint32_t>(
											  flashlight::memory::GlobalAddress(g_ResidualWordAddress))
										: 0;
						r_ResidualPair =
							flashlight::numeric::decode_e4x2(uint16_t(r_ResidualPair >> (r_N8 * 16))).bits;
						r_Accumulator.word[r_Spatial][r_ChannelGroup][r_N8 * 2 + r_RowHalf] =
							flashlight::numeric::half2_multiply(
								flashlight::PackedHalf2{r_ResidualPair},
								flashlight::PackedHalf2{r_ResidualScales[r_ChannelGroup][r_N8]})
								.bits;
					}
				}
		}
	}

	// Keep K sequential to retain Half accumulation order and the native ring
	// lifecycle. Prefetch next weights before waiting, then recycle the old stage.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::reduction_tiles; ++ReductionTile)
	{
		uint4 r_Input[SpatialTiles][2];
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] =
					Stages.load(ReductionTile, 0, r_Spatial + TileCoordinates.warp / 4 * 2, r_KSubtile,
								TileCoordinates.lane);
		flashlight::tile::accumulate_tile<Profile::precision>(r_Accumulator, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::reduction_tiles)
		{
			LoadWeights(ReductionTile + 1);
			WaitInput(ReductionTile + 1);
		}

		if (ReductionTile + StageCount < Profile::reduction_tiles)
			IssueInput(ReductionTile + StageCount);
	}

	// Write each projected tile in its selected physical output layout.
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		const int g_Y = TileCoordinates.tile_y + TileCoordinates.warp / 4 + r_Spatial / 2;
		const int g_X = TileCoordinates.tile_x + r_Spatial % 2;
		if (g_Y >= TileCoordinates.tiles_high || g_X >= TileCoordinates.tiles_wide)
			continue;
		{
			const uint64_t g_OutputTileBase =
				Parameters.g_Output +
				uint64_t(g_Y * TileCoordinates.tiles_wide + g_X) * Profile::spatial_tile_bytes +
				TileCoordinates.output_channel * 16 * Profile::element_bytes + TileCoordinates.lane * 16;
			{
				#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_LowerChannelWords = r_Accumulator.word[r_Spatial][2 * r_ChannelPair];
					const auto& r_UpperChannelWords = r_Accumulator.word[r_Spatial][2 * r_ChannelPair + 1];
					const uint4 r_OutputVector = make_uint4(
						flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_LowerChannelWords[0]},
														  flashlight::PackedHalf2{r_LowerChannelWords[2]})
							.bits,
						flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_LowerChannelWords[1]},
														  flashlight::PackedHalf2{r_LowerChannelWords[3]})
							.bits,
						flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_UpperChannelWords[0]},
														  flashlight::PackedHalf2{r_UpperChannelWords[2]})
							.bits,
						flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_UpperChannelWords[1]},
														  flashlight::PackedHalf2{r_UpperChannelWords[3]})
							.bits);
					flashlight::memory::store_no_allocate(
						flashlight::memory::GlobalAddress(g_OutputTileBase + r_ChannelPair * 512),
						r_OutputVector);
				}
			}
		}
	}

	{
	}

#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
