// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
// The K-slice input ring is addressed through typed coordinate views and its
// transaction barriers through the named lifecycle ring.
#include <common/layout/global_profiles.h>
#include <common/ops/global_attention.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/math.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/publication.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <cuda_runtime.h>
#include <cstdint>

extern "C" __global__ __maxnreg__(255) void global_qkv_c1024_fp16(FGlobalQkvC1024Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	constexpr bool bFp8 = false;
	using Profile = dlssnr::layout::GlobalQkvProfile<bFp8>;
	using Accumulator = flashlight::tile::TiledMmaAccumulator<4, 6>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::barrier_offset + Profile::stage_count * 8];
	const int g_Tokens = Parameters.BatchCount * Parameters.TokensPerBatch;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_HeadPair = int(blockIdx.x) / g_TokenTiles;
	const int Lane = threadIdx.x, Warp = threadIdx.y;

	// Ordered launches carry one logical K split per stream-ordered XY grid.
	// Zero retains the native grid-Z protocol when residency permits it.
	const int Split = Parameters.OrderedSplit ? int(Parameters.OrderedSplit - 1) : int(blockIdx.z);
	const dlssnr::layout::GlobalContractTileCoordinates TileCoordinates{
		(int(blockIdx.x) % g_TokenTiles) * 8,
		g_HeadPair * 192 + (Warp & 1) * 96,
		bFp8 ? ((g_Tokens + 31) / 32) * 2 : (g_Tokens + 15) / 16,
		g_HeadPair,
		Lane,
		Warp,
		Split,
		!bFp8 && uint32_t(g_Tokens + 14) < 31};

	// Producer view names adjacent 512-byte copies; consumer view names this warp
	// row group's spatial fragments over the identical ring bytes.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	const auto CopyStage = dlssnr::ops::make_global_contract_copy_view<Profile>(Shared);
	const auto InputStage =
		dlssnr::ops::make_global_contract_stage_view<Profile>(Shared, uint32_t(Warp), uint32_t(Lane));
	const flashlight::memory::TransactionBarrierRing<Profile::stage_count> BarrierRing(
		Shared, Profile::barrier_offset);

	// Visible K-slice staging preserves the contract/QKV shared physical layout.
	const auto StageInput = [&](int ReductionTile)
	{
		const uint32_t s_Stage = uint32_t(ReductionTile % Profile::stage_count);
		const auto s_Barrier = BarrierRing.at_slot(s_Stage);

		// Contraction coalesces both K fragments in each 16-token group. Half
		// attention projection instead assigns each K fragment to a separate warp.
		#pragma unroll
		for (int Copy = 0; Copy < Profile::copies_per_warp; ++Copy)
		{
			const int CopySlot = Warp + Copy * 4;
			const int g_Group = TileCoordinates.broadcast_input ? 0
																: TileCoordinates.token_group_base +
																	  CopySlot / Profile::producers_per_group;
			if (g_Group < TileCoordinates.padded_groups)
			{
				if (flashlight::arch::is_copy_producer(0xffffffffu))
				{
					const uint64_t g_Source = Parameters.g_Input +
											  uint64_t(g_Group * Profile::input_channels +
													   TileCoordinates.split * Profile::split_channels +
													   ReductionTile * Profile::reduction_step) *
												  16 * Profile::element_bytes +
											  (Warp % Profile::producers_per_group) * Profile::copy_bytes;
					s_Barrier.copy_then_expect(CopyStage.byte_offset_slot(s_Stage, uint32_t(CopySlot), 0, 0),
											   flashlight::memory::GlobalAddress(g_Source),
											   Profile::copy_bytes);
				}
			}
			else
			{
				#pragma unroll
				for (int s_Subtile = 0; s_Subtile < Profile::copy_bytes / 512; ++s_Subtile)
					CopyStage.store_slot(make_uint4(0, 0, 0, 0), s_Stage, uint32_t(CopySlot),
										 uint32_t(s_Subtile), uint32_t(Lane));
			}
		}
	};

	// Wait before consuming each slice or recycling its shared ring slot.
	const auto WaitStage = [&](int ReductionTile)
	{ BarrierRing.for_iteration(ReductionTile).arrive_and_wait(); };

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (Lane == 0 && Warp == 0)
		#pragma unroll
		for (uint32_t s_Stage = 0; s_Stage < Profile::stage_count; ++s_Stage)
			BarrierRing.at_slot(s_Stage).initialize(blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::reduction_subtiles][6];

	// Q/K/V weight panels remain adjacent in the native record.
	const auto LoadWeights = [&](int ReductionTile)
	{
		// The 128-byte header contains one FP32 scale per attention head. The
		// matrix following it interleaves Q32, K32, V32 within each head.
		const uint64_t g_WeightTileBase =
			Parameters.g_PackedWeights + 128 +
			uint64_t(TileCoordinates.split * 512 + ReductionTile * 32) * 3072 * Profile::element_bytes +
			TileCoordinates.output_channel * 32 + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::reduction_subtiles; ++r_KSubtile)
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 6; ++r_ChannelGroup)
				r_Weights[r_KSubtile][r_ChannelGroup] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_WeightTileBase + r_KSubtile * 98304 +
														  r_ChannelGroup * 512));
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	StageInput(0);
	WaitStage(0);
	Accumulator r_Accumulator{};
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < 15; ++ReductionTile)
	{
		dlssnr::ops::consume_global_contract_input_stage<Profile>(r_Accumulator, r_Weights, InputStage,
																  ReductionTile);
		StageInput(ReductionTile + 1);
		LoadWeights(ReductionTile + 1);
		WaitStage(ReductionTile + 1);
	}

	// The native loop leaves its last ready tile for an explicit pipeline drain.
	dlssnr::ops::consume_global_contract_input_stage<Profile>(r_Accumulator, r_Weights, InputStage, 15);

	// One local store loop serves Q, K and V with their original compile-time layouts.
	const auto PublishComponent = [&](auto ComponentTag, auto PublicationTag)
	{
		constexpr int Component = decltype(ComponentTag)::value;
		constexpr auto Publication = decltype(PublicationTag)::value;
		const int g_Head = TileCoordinates.channel_block * 2 + (TileCoordinates.warp & 1);
		const uint64_t g_Output = Component == 0   ? Parameters.g_Query
								  : Component == 1 ? Parameters.g_Key
												   : Parameters.g_Value;
		const uint64_t g_PartialSums =
			bFp8 ? Parameters.g_SplitAccumulator + uint64_t(Component) * TileCoordinates.padded_groups * 32768
				 : g_Output;
		const bool bFirstSplit = Publication == dlssnr::layout::GlobalQkvSplitPublication::Runtime
									 ? TileCoordinates.split == 0
									 : Publication == dlssnr::layout::GlobalQkvSplitPublication::First;

		// The first slice stores ordinary Half fragments. The second slice reads
		// and adds them before any normalization or storage-layout conversion.
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
		{
			const int g_LogicalGroup =
				TileCoordinates.token_group_base + (TileCoordinates.warp >> 1) * 4 + r_Spatial;
			const int g_ReadGroup = TileCoordinates.broadcast_input ? 0 : g_LogicalGroup;
			#pragma unroll
			for (int r_N16 = 0; r_N16 < 2; ++r_N16)
			{
				auto& r_AccumulatorWords = r_Accumulator.word[r_Spatial][Component * 2 + r_N16];
				if (bFirstSplit)
				{
					if (g_LogicalGroup < TileCoordinates.padded_groups)
						flashlight::memory::store_no_allocate(
							flashlight::memory::GlobalAddress(
								g_PartialSums + uint64_t(g_LogicalGroup) * 32768 + g_Head * 1024 +
								r_N16 * 512 + TileCoordinates.lane * 16),
							make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1], r_AccumulatorWords[2],
									   r_AccumulatorWords[3]));
				}
				else
				{
					const uint64_t g_PartialAddress = g_PartialSums + uint64_t(g_ReadGroup) * 32768 +
													  g_Head * 1024 + r_N16 * 512 + TileCoordinates.lane * 16;
					const uint4 r_PreviousSplitWords =
						flashlight::memory::load_vector_or_zero<flashlight::memory::CachePolicy::Ca, uint4>(
							flashlight::memory::GlobalAddress(g_PartialAddress),
							g_ReadGroup < TileCoordinates.padded_groups);
					r_AccumulatorWords[0] = flashlight::packed_bits(
						flashlight::numeric::half2_add(flashlight::PackedHalf2{r_PreviousSplitWords.x},
													   flashlight::PackedHalf2{r_AccumulatorWords[0]}));
					r_AccumulatorWords[1] = flashlight::packed_bits(
						flashlight::numeric::half2_add(flashlight::PackedHalf2{r_PreviousSplitWords.y},
													   flashlight::PackedHalf2{r_AccumulatorWords[1]}));
					r_AccumulatorWords[2] = flashlight::packed_bits(
						flashlight::numeric::half2_add(flashlight::PackedHalf2{r_PreviousSplitWords.z},
													   flashlight::PackedHalf2{r_AccumulatorWords[2]}));
					r_AccumulatorWords[3] = flashlight::packed_bits(
						flashlight::numeric::half2_add(flashlight::PackedHalf2{r_PreviousSplitWords.w},
													   flashlight::PackedHalf2{r_AccumulatorWords[3]}));
				}
			}
		}

		if (bFirstSplit)
			return;
		if constexpr (Component < 2)
			dlssnr::ops::normalize_head<bFp8, Component>(r_Accumulator, Parameters.g_PackedWeights, g_Head);
		else
		{
			// Transpose all V fragments before combining neighboring M16 tiles
			// into the FP8 consumer's M32 storage groups.
			#pragma unroll
			for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
				#pragma unroll
				for (int r_N16 = 0; r_N16 < 2; ++r_N16)
					#pragma unroll
					for (int r_Word = 0; r_Word < 4; ++r_Word)
						r_Accumulator.word[r_Spatial][4 + r_N16][r_Word] = flashlight::arch::transpose_m8n8(
							r_Accumulator.word[r_Spatial][4 + r_N16][r_Word]);
		}

		#pragma unroll
		for (int r_Publish = 0; r_Publish < (!bFp8 && Component == 1 ? 8 : 4); ++r_Publish)
		{
			const int r_Spatial = r_Publish % 4;
			const int g_Group =
				TileCoordinates.token_group_base + (TileCoordinates.warp >> 1) * 4 + r_Spatial;
			if (g_Group < TileCoordinates.padded_groups)
			{
				const uint64_t g_OutputFragmentAddress =
					g_Output + uint64_t(g_Group) * 32768 + g_Head * 1024 + TileCoordinates.lane * 16;
				if constexpr (Component == 1)
				{
					// Half K interleaves N8s and publishes all M tiles of N0
					// before N1, retaining the native fragment-store schedule.
					const auto& r_KeyPanelWords = r_Accumulator.word[r_Spatial][2 + r_Publish / 4];
					flashlight::memory::store_no_allocate(
						flashlight::memory::GlobalAddress(g_OutputFragmentAddress + (r_Publish / 4) * 512),
						make_uint4(r_KeyPanelWords[0], r_KeyPanelWords[2], r_KeyPanelWords[1],
								   r_KeyPanelWords[3]));
				}
				else
				{
					const auto& r_LowerChannelWords = r_Accumulator.word[r_Spatial][Component * 2];
					const auto& r_UpperChannelWords = r_Accumulator.word[r_Spatial][Component * 2 + 1];
					flashlight::memory::store_no_allocate(
						flashlight::memory::GlobalAddress(g_OutputFragmentAddress),
						make_uint4(r_LowerChannelWords[0], r_LowerChannelWords[1], r_LowerChannelWords[2],
								   r_LowerChannelWords[3]));
					flashlight::memory::store_no_allocate(
						flashlight::memory::GlobalAddress(g_OutputFragmentAddress + 512),
						make_uint4(r_UpperChannelWords[0], r_UpperChannelWords[1], r_UpperChannelWords[2],
								   r_UpperChannelWords[3]));
				}
			}
		}
	};

	// Retain Q -> K -> V publication order for every split policy.
	const auto PublishComponents = [&](auto PublicationTag)
	{
		PublishComponent(std::integral_constant<int, 0>{}, PublicationTag);
		PublishComponent(std::integral_constant<int, 1>{}, PublicationTag);
		PublishComponent(std::integral_constant<int, 2>{}, PublicationTag);
	};

	const uint64_t g_SplitCounters =
		Parameters.g_SplitCounters + ((TileCoordinates.token_group_base / 8) * 16 + g_HeadPair) * 4;
	if (TileCoordinates.split != 0)
	{
		// A preceding launch completed the prior split in ordered mode; no CTA
		// may poll a predecessor that could still be waiting for a free SM.
		if (Parameters.OrderedSplit == 0 && Lane == 0 && Warp == 0)
		{
			const flashlight::memory::SplitPublication SplitPublicationState{
				flashlight::memory::GlobalAddress(g_SplitCounters)};
			while (int32_t(SplitPublicationState.load_relaxed()) < TileCoordinates.split - 1)
				flashlight::arch::poll_sleep(64);

			// GPU-scope acquire of the observed release before the CTA handoff.
			flashlight::memory::SplitPublication::acquire_fence();
		}

		__syncthreads();
	}

	PublishComponents(std::integral_constant<dlssnr::layout::GlobalQkvSplitPublication,
											 dlssnr::layout::GlobalQkvSplitPublication::Runtime>{});
	__syncthreads();
	if (Lane == 0 && Warp == 0)
		flashlight::memory::SplitPublication{flashlight::memory::GlobalAddress(g_SplitCounters)}
			.store_release(uint32_t(TileCoordinates.split));
#endif
}
