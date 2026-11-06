// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include <common/layout/window_profiles.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include <cstdint>

extern "C" __global__ __maxnreg__(168) void channel_projection_c512_to_c1024_fp8(
	FChannelProjectionC512ToC1024Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8Storage = true;
	using FProfile = dlssnr::layout::ChannelProjectionProfile<bFp8Storage>;
	__shared__ __align__(512) unsigned char s_Storage[FProfile::storage_bytes];
	const auto* g_Input = reinterpret_cast<const unsigned char*>(Parameters.g_Input);
	auto* g_Output = reinterpret_cast<unsigned char*>(Parameters.g_Output);
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights);
	const int g_Height = int(Parameters.Height), g_Width = int(Parameters.Width);
	const int Lane = threadIdx.x, Warp = threadIdx.y;
	const int g_SpatialTilesX = (g_Width + 7) / 8;
	const int g_OutputChannel =
		(int(blockIdx.x) / g_SpatialTilesX) * FProfile::tile_channels + (Warp & 3) * FProfile::warp_channels;
	const int g_TileX = (int(blockIdx.x) % g_SpatialTilesX) * 2;
	const int g_TileY = int(blockIdx.y) * 2 + (Warp >> 2);
	const int g_InputTileX = g_TileX + ((Warp >> 1) & 1);
	const int g_ReductionChannelBase = int(blockIdx.z) * FProfile::input_channels;

	// One physical three-stage ring: producer stripes, consumer fragments and
	// the transaction barriers at the recovered base + slot*8 offsets.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	using ProducerView =
		flashlight::memory::StagedSharedLayoutView<uint4, flashlight::layout::ByteStrides<512, 16>,
												   FProfile::stage_count, FProfile::stage_bytes>;
	using InputView =
		flashlight::memory::StagedSharedLayoutView<uint4,
												   flashlight::layout::ByteStrides<2048, 1024, 512, 16>,
												   FProfile::stage_count, FProfile::stage_bytes>;
	const ProducerView StageVectors(Shared);
	const InputView StageFragments(Shared);
	const flashlight::memory::TransactionBarrierRing<FProfile::stage_count> Barriers(
		Shared, FProfile::barrier_offset);

	// Initial fill and refill use the same bounded bulk-copy loop.
	const auto StageInput =
		[&](int s_StageIndex, int g_ReductionStart, int g_TileY, int g_TileX, int g_TilesY, int g_TilesX)
	{
		const int g_ReadY = g_TilesY == 1 ? 0 : g_TileY;
		const int g_ReadX = g_TilesX == 1 ? 0 : g_TileX;
		if (g_ReadY < g_TilesY && g_ReadX < g_TilesX)
		{
			if (flashlight::arch::is_copy_producer(0xffffffffu))
			{
				const int g_TileIndex = g_ReadY * g_TilesX + g_ReadX;
				const int g_Channel = g_ReductionStart + (Warp & 1) * (FProfile::reduction_step / 2);
				const int g_ByteOffset =
					(g_TileIndex * FProfile::input_channels + g_Channel) * 16 * FProfile::element_bytes;
				Barriers.at_slot(s_StageIndex)
					.copy_then_expect(StageVectors.byte_offset_slot(s_StageIndex, Warp, 0),
									  flashlight::memory::GlobalAddress(
										  reinterpret_cast<std::uint64_t>(g_Input + g_ByteOffset)),
									  512);
			}
		}
		else
		{
			// Out-of-domain tiles are zero; a one-tile dimension uses broadcast.
			StageVectors.store_slot(make_uint4(0, 0, 0, 0), s_StageIndex, Warp, Lane);
		}
	};

	// Wait on the selected slot before consuming or recycling its shared bytes.
	const auto WaitStage = [&](int s_StageIndex) { Barriers.at_slot(s_StageIndex).arrive_and_wait(); };

	// Native mbarrier arrival counts include every thread, including zero-fill warps.
	if (Lane == 0 && Warp == 0)
	{
		#pragma unroll
		for (int s_StageIndex = 0; s_StageIndex < FProfile::stage_count; ++s_StageIndex)
			Barriers.at_slot(s_StageIndex).initialize(blockDim.x * blockDim.y);
	}

	__syncthreads();

	uint4 r_WeightFragments[2][4];

	// Keep weight prefetch next to the register fragment storage it fills.
	const auto LoadWeights = [&](int g_ReductionStart)
	{
		const int g_WeightTileByteBase =
			g_ReductionStart * FProfile::output_channels * FProfile::element_bytes + g_OutputChannel * 32 +
			Lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
		{
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
			{
				const int g_WeightByteOffset = g_WeightTileByteBase +
											   r_KSubtile * (FProfile::reduction_step / 2) *
												   FProfile::output_channels * FProfile::element_bytes +
											   r_ChannelGroup * 512;
				r_WeightFragments[r_KSubtile][r_ChannelGroup] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(
							reinterpret_cast<std::uint64_t>(g_Weights + g_WeightByteOffset)));
			}
		}
	};

	LoadWeights(g_ReductionChannelBase);
	#pragma unroll
	for (int s_StageIndex = 0; s_StageIndex < FProfile::stage_count; ++s_StageIndex)
		StageInput(s_StageIndex, g_ReductionChannelBase + s_StageIndex * FProfile::reduction_step, g_TileY,
				   g_InputTileX, g_Height / 4, g_Width / 4);
	WaitStage(0);
	flashlight::tile::TiledMmaAccumulator<2, 4> r_Accumulator{};

	// Keep the reduction loop rolled as in the DLL. The fragment loops below
	// unroll, so tile coordinates select registers rather than local memory.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < FProfile::reduction_steps; ++ReductionTile)
	{
		const int s_StageIndex = ReductionTile % FProfile::stage_count;
		uint4 r_InputFragments[2][2];
		#pragma unroll
		for (int r_SpatialTile = 0; r_SpatialTile < 2; ++r_SpatialTile)
		{
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_InputFragments[r_SpatialTile][r_KSubtile] =
					StageFragments.load_slot(s_StageIndex, Warp >> 2, r_SpatialTile, r_KSubtile, Lane);
		}

		flashlight::tile::accumulate_tile<FProfile::precision>(r_Accumulator, r_InputFragments,
															   r_WeightFragments);

		// Prefetch weights before waiting for the next input stage. That wait
		// also proves all warps finished reading the stage about to be reused.
		if (ReductionTile + 1 < FProfile::reduction_steps)
		{
			LoadWeights(g_ReductionChannelBase + (ReductionTile + 1) * FProfile::reduction_step);
			WaitStage((ReductionTile + 1) % FProfile::stage_count);
		}

		if (ReductionTile + FProfile::stage_count < FProfile::reduction_steps)
			StageInput(s_StageIndex,
					   g_ReductionChannelBase +
						   (ReductionTile + FProfile::stage_count) * FProfile::reduction_step,
					   g_TileY, g_InputTileX, g_Height / 4, g_Width / 4);
	}

	// Physical output is a sequence of 4x4 spatial blocks. Half stores each
	// N16 fragment directly; FP8 merges adjacent N8 fragments after conversion.
	#pragma unroll
	for (int r_SpatialTile = 0; r_SpatialTile < 2; ++r_SpatialTile)
	{
		if (g_TileY < g_Height / 4 && g_TileX + r_SpatialTile < g_Width / 4)
		{
			const int g_TileIndex = g_TileY * (g_Width / 4) + g_TileX + r_SpatialTile;
			const int g_OutputTileByteBase =
				(g_TileIndex * FProfile::output_channels + g_OutputChannel) * 16 * FProfile::element_bytes +
				Lane * 16;
			{
				#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_Left = r_Accumulator.word[r_SpatialTile][r_ChannelPair * 2];
					const auto& r_Right = r_Accumulator.word[r_SpatialTile][r_ChannelPair * 2 + 1];
					const uint4 r_PackedOutputFragment =
						make_uint4(flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_Left[0]},
																	 flashlight::PackedHalf2{r_Left[2]})
									   .bits,
								   flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_Left[1]},
																	 flashlight::PackedHalf2{r_Left[3]})
									   .bits,
								   flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_Right[0]},
																	 flashlight::PackedHalf2{r_Right[2]})
									   .bits,
								   flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_Right[1]},
																	 flashlight::PackedHalf2{r_Right[3]})
									   .bits);
					flashlight::memory::store_no_allocate(
						flashlight::memory::GlobalAddress(reinterpret_cast<std::uint64_t>(
							g_Output + g_OutputTileByteBase + r_ChannelPair * 512)),
						r_PackedOutputFragment);
				}
			}
		}
	}

#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
