// The complete global template retains each native schedule and register limit.
// Only supported profiles are emitted; host launch selection remains in kernel_launcher.
// The K-slice input ring is addressed through typed coordinate views and its
// transaction barriers through the named lifecycle ring. FP8 entries are rejected
// below SM89, matching host admission.
#include <common/layout/global_profiles.h>
#include <common/ops/global_attention.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/math.cuh>
#include <flashlight/arch/memory.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/publication.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <cuda_runtime.h>
#include <cstdint>

template <bool bAttentionProjection, typename FParameters>
__global__ __maxnreg__(168) void global_contract_fp8(FParameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	using Profile = dlssnr::layout::GlobalContractProfile<bFp8, bAttentionProjection>;
	using Accumulator = flashlight::tile::TiledMmaAccumulator<4, 4>;
#if __CUDA_ARCH__ < 900
	static_assert(Profile::initial_stages == 1 && Profile::stage_count == 2,
				  "Early prefetch requires one initial stage and two alternating slots");
#endif
	__shared__ __align__(512) unsigned char s_Storage[Profile::barrier_offset + Profile::stage_count * 8];
	const int g_Tokens = Parameters.BatchCount * Parameters.TokensPerBatch;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_ChannelBlock = int(blockIdx.x) / g_TokenTiles;
	const int Warp = threadIdx.y, Lane = threadIdx.x;

	// Small devices execute one K split per stream-ordered launch. Zero keeps
	// the native grid-Z schedule; the launcher supplies Split + 1 otherwise.
	const int Split = Parameters.OrderedSplit ? int(Parameters.OrderedSplit) - 1 : int(blockIdx.z);
	const dlssnr::layout::GlobalContractTileCoordinates TileCoordinates{
		(int(blockIdx.x) % g_TokenTiles) * 8,
		g_ChannelBlock * 128 + (Warp & 1) * 64,
		bFp8 ? ((g_Tokens + 31) / 32) * 2 : (g_Tokens + 15) / 16,
		g_ChannelBlock,
		Lane,
		Warp,
		Split,
		!bFp8 && uint32_t(g_Tokens + 14) < 31};

	// Producer view names adjacent copies; consumer view names this warp row
	// group's spatial fragments over the identical ring bytes.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	const auto CopyStage = dlssnr::ops::make_global_contract_copy_view<Profile>(Shared);
	const auto InputStage =
		dlssnr::ops::make_global_contract_stage_view<Profile>(Shared, uint32_t(Warp), uint32_t(Lane));
	const flashlight::memory::TransactionBarrierRing<Profile::stage_count> BarrierRing(
		Shared, Profile::barrier_offset);

	// The initial fill and later refills share this exact staged input copy.
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

	// Only a completed stage can feed the register MMA tile.
	const auto WaitStage = [&](int ReductionTile)
	{ BarrierRing.for_iteration(ReductionTile).arrive_and_wait(); };

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (Lane == 0 && Warp == 0)
		#pragma unroll
		for (uint32_t s_Stage = 0; s_Stage < Profile::stage_count; ++s_Stage)
			BarrierRing.at_slot(s_Stage).initialize(blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::reduction_subtiles][4];

	// Prefetch weights without changing the ring dependency order.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase = Parameters.g_PackedWeights +
										  uint64_t(TileCoordinates.split * Profile::split_channels +
												   ReductionTile * Profile::reduction_step) *
											  1024 * Profile::element_bytes +
										  TileCoordinates.output_channel * 32 + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < Profile::reduction_subtiles; ++r_KSubtile)
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				r_Weights[r_KSubtile][r_ChannelGroup] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_WeightTileBase + r_KSubtile * 32768 +
														  r_ChannelGroup * 512));
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	#pragma unroll
	for (int s_InitialStage = 0; s_InitialStage < Profile::initial_stages; ++s_InitialStage)
		StageInput(s_InitialStage);
	WaitStage(0);
	Accumulator r_Accumulator{};

	// Only the first K split seeds the accumulator from the residual.
	if (TileCoordinates.split == 0)
	{
		// The record appends 1024 Half scales to the matrix. Lane's two adjacent
		// channels share a packed scale; words 0/1 and 2/3 belong to separate N8s.
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
						 .as_pointer<const uint32_t>();

		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
		{
			const int g_Group =
				TileCoordinates.broadcast_input
					? 0
					: TileCoordinates.token_group_base + (TileCoordinates.warp >> 1) * 4 + r_Spatial;
			const uint64_t g_ResidualTileBase =
				Parameters.g_Residual +
				uint64_t(g_Group * 1024 + TileCoordinates.output_channel) * 16 * Profile::element_bytes +
				TileCoordinates.lane * 16;
			#pragma unroll
			for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
			{
				const uint4 r_PackedResidual =
					flashlight::memory::load_vector_or_zero<flashlight::memory::CachePolicy::Cg, uint4>(
						flashlight::memory::GlobalAddress(g_ResidualTileBase + r_ChannelPair * 512),
						g_Group < TileCoordinates.padded_groups);
				const uint32_t r_PackedResidualWords[4] = {r_PackedResidual.x, r_PackedResidual.y,
														   r_PackedResidual.z, r_PackedResidual.w};
				#pragma unroll
				for (int r_InPair = 0; r_InPair < 2; ++r_InPair)
				{
					const int r_ChannelGroup = r_ChannelPair * 2 + r_InPair;
					auto& r_AccumulatorWords = r_Accumulator.word[r_Spatial][r_ChannelGroup];
					r_AccumulatorWords[0] = flashlight::packed_bits(flashlight::numeric::half2_multiply(
						flashlight::numeric::decode_e4x2(uint16_t(r_PackedResidualWords[r_InPair * 2])),
						flashlight::PackedHalf2{r_ResidualScales[r_ChannelGroup][0]}));
					r_AccumulatorWords[1] = flashlight::packed_bits(flashlight::numeric::half2_multiply(
						flashlight::numeric::decode_e4x2(uint16_t(r_PackedResidualWords[r_InPair * 2 + 1])),
						flashlight::PackedHalf2{r_ResidualScales[r_ChannelGroup][0]}));
					r_AccumulatorWords[2] = flashlight::packed_bits(flashlight::numeric::half2_multiply(
						flashlight::numeric::decode_e4x2(uint16_t(r_PackedResidualWords[r_InPair * 2] >> 16)),
						flashlight::PackedHalf2{r_ResidualScales[r_ChannelGroup][1]}));
					r_AccumulatorWords[3] = flashlight::packed_bits(flashlight::numeric::half2_multiply(
						flashlight::numeric::decode_e4x2(
							uint16_t(r_PackedResidualWords[r_InPair * 2 + 1] >> 16)),
						flashlight::PackedHalf2{r_ResidualScales[r_ChannelGroup][1]}));
				}
			}
		}
	}

	// Native two-stage code peels the final MMA tile out of the prefetch loop.
	// Keeping that drain explicit removes a per-iteration tail branch. The
	// three-stage Half contraction retains its distinct refill lifecycle.
	#pragma unroll 1
	for (int ReductionTile = 0;
		 ReductionTile < Profile::reduction_tiles - (Profile::initial_stages == 1 ? 1 : 0); ++ReductionTile)
	{
#if __CUDA_ARCH__ < 900
		// WaitStage(i) completed every thread's arrival after the previous
		// consume, releasing that old slot. Prefetch i+1 into it while i's MMA
		// runs in the other slot; the weight registers still hold i until use.
		StageInput(ReductionTile + 1);
#endif
		dlssnr::ops::consume_global_contract_input_stage<Profile>(r_Accumulator, r_Weights, InputStage,
																  ReductionTile);
		{
#if __CUDA_ARCH__ >= 900
			StageInput(ReductionTile + 1);
#endif
			LoadWeights(ReductionTile + 1);
			WaitStage(ReductionTile + 1);
		}
	}

	dlssnr::ops::consume_global_contract_input_stage<Profile>(r_Accumulator, r_Weights, InputStage,
															  Profile::reduction_tiles - 1);

	// Compile-time split policy keeps the native branch outside all store loops.
	const auto PublishFragments = [&](auto PublicationTag)
	{
		constexpr auto Publication = decltype(PublicationTag)::value;
		const bool bFirstSplit = Publication == dlssnr::layout::GlobalContractSplitPublication::Runtime
									 ? TileCoordinates.split == 0
									 : Publication == dlssnr::layout::GlobalContractSplitPublication::First;
		const bool bIntermediateSplit =
			Publication == dlssnr::layout::GlobalContractSplitPublication::Runtime
				? TileCoordinates.split < 3
				: Publication == dlssnr::layout::GlobalContractSplitPublication::Intermediate;

		// Serial publication preserves the DLL's Half rounding between K splits.
		// FP8 keeps partial sums in a separate Half buffer until the fourth split.
		const uint64_t g_PartialSums = bFp8 ? Parameters.g_SplitAccumulator : Parameters.g_Output;
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
		{
			const int g_Group =
				TileCoordinates.token_group_base + (TileCoordinates.warp >> 1) * 4 + r_Spatial;
			if (g_Group < TileCoordinates.padded_groups)
			{
				const uint64_t g_HalfBase = g_PartialSums +
											uint64_t(g_Group * 1024 + TileCoordinates.output_channel) * 32 +
											TileCoordinates.lane * 16;
				#pragma unroll
				for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				{
					auto& r_AccumulatorWords = r_Accumulator.word[r_Spatial][r_ChannelGroup];
					const uint64_t g_PartialSumAddress = g_HalfBase + r_ChannelGroup * 512;
					if (bFirstSplit)
						flashlight::memory::store_no_allocate(
							flashlight::memory::GlobalAddress(g_PartialSumAddress),
							make_uint4(r_AccumulatorWords[0], r_AccumulatorWords[1], r_AccumulatorWords[2],
									   r_AccumulatorWords[3]));
					else if (bIntermediateSplit)
						flashlight::memory::accumulate_exclusive_half2x4(
							flashlight::memory::GlobalAddress(g_PartialSumAddress),
							flashlight::PackedHalf2x4{{r_AccumulatorWords[0], r_AccumulatorWords[1],
													   r_AccumulatorWords[2], r_AccumulatorWords[3]}});
					else
					{
						const flashlight::PackedHalf2x4 r_PreviousSplitWords =
							flashlight::memory::load_exclusive_half2x4(
								flashlight::memory::GlobalAddress(g_PartialSumAddress));
						r_AccumulatorWords[0] = flashlight::packed_bits(flashlight::numeric::half2_add(
							flashlight::PackedHalf2{r_PreviousSplitWords.word[0]},
							flashlight::PackedHalf2{r_AccumulatorWords[0]}));
						r_AccumulatorWords[1] = flashlight::packed_bits(flashlight::numeric::half2_add(
							flashlight::PackedHalf2{r_PreviousSplitWords.word[1]},
							flashlight::PackedHalf2{r_AccumulatorWords[1]}));
						r_AccumulatorWords[2] = flashlight::packed_bits(flashlight::numeric::half2_add(
							flashlight::PackedHalf2{r_PreviousSplitWords.word[2]},
							flashlight::PackedHalf2{r_AccumulatorWords[2]}));
						r_AccumulatorWords[3] = flashlight::packed_bits(flashlight::numeric::half2_add(
							flashlight::PackedHalf2{r_PreviousSplitWords.word[3]},
							flashlight::PackedHalf2{r_AccumulatorWords[3]}));
					}
				}

				const bool bFinalSplit =
					Publication == dlssnr::layout::GlobalContractSplitPublication::Runtime
						? TileCoordinates.split == 3
						: Publication == dlssnr::layout::GlobalContractSplitPublication::Final;
				if (bFinalSplit)
				{
					const uint64_t g_OutputBase =
						Parameters.g_Output + uint64_t(g_Group * 1024 + TileCoordinates.output_channel) * 16 +
						TileCoordinates.lane * 16;
					#pragma unroll
					for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
					{
						const auto& r_LowerChannelWords = r_Accumulator.word[r_Spatial][r_ChannelPair * 2];
						const auto& r_UpperChannelWords =
							r_Accumulator.word[r_Spatial][r_ChannelPair * 2 + 1];
						flashlight::memory::store_no_allocate(
							flashlight::memory::GlobalAddress(g_OutputBase + r_ChannelPair * 512),
							make_uint4(flashlight::numeric::publish_e4x4(
										   flashlight::PackedHalf2{r_LowerChannelWords[0]},
										   flashlight::PackedHalf2{r_LowerChannelWords[2]})
										   .bits,
									   flashlight::numeric::publish_e4x4(
										   flashlight::PackedHalf2{r_LowerChannelWords[1]},
										   flashlight::PackedHalf2{r_LowerChannelWords[3]})
										   .bits,
									   flashlight::numeric::publish_e4x4(
										   flashlight::PackedHalf2{r_UpperChannelWords[0]},
										   flashlight::PackedHalf2{r_UpperChannelWords[2]})
										   .bits,
									   flashlight::numeric::publish_e4x4(
										   flashlight::PackedHalf2{r_UpperChannelWords[1]},
										   flashlight::PackedHalf2{r_UpperChannelWords[3]})
										   .bits));
					}
				}
			}
		}
	};

	const uint64_t g_SplitCounters =
		Parameters.g_SplitCounters + (TileCoordinates.token_group_base + TileCoordinates.channel_block) * 4;

	// Ordered launches complete their predecessor before entering this kernel,
	// so they never occupy an SM while polling an unscheduled producer.
	if (Parameters.OrderedSplit == 0 && TileCoordinates.split > 0)
	{
		if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
		{
			const flashlight::memory::SplitPublication SplitPublicationState{
				flashlight::memory::GlobalAddress(g_SplitCounters)};
			while (int32_t(SplitPublicationState.load_relaxed()) < TileCoordinates.split - 1)
				flashlight::arch::poll_sleep(64);

			// Acquire the completed split before any lane reads its Half scratch.
			flashlight::memory::SplitPublication::acquire_fence();
		}

		__syncthreads();
	}

	{
		// The native epilogue selects first-store, intermediate-reduction or
		// final-pack once. Keep that uniform choice outside fragment loops.
		if (TileCoordinates.split == 0)
			PublishFragments(std::integral_constant<dlssnr::layout::GlobalContractSplitPublication,
													dlssnr::layout::GlobalContractSplitPublication::First>{});
		else if (TileCoordinates.split < 3)
			PublishFragments(
				std::integral_constant<dlssnr::layout::GlobalContractSplitPublication,
									   dlssnr::layout::GlobalContractSplitPublication::Intermediate>{});
		else
			PublishFragments(std::integral_constant<dlssnr::layout::GlobalContractSplitPublication,
													dlssnr::layout::GlobalContractSplitPublication::Final>{});
	}

	__syncthreads();
	if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
		flashlight::memory::SplitPublication{flashlight::memory::GlobalAddress(g_SplitCounters)}
			.store_release(uint32_t(TileCoordinates.split));
#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}

// Host address resolver keeps the registered global_ffn_contract_c1024_fp8 specialization in this translation unit.
extern "C" const void* Resolve_global_ffn_contract_c1024_fp8()
{
	return reinterpret_cast<const void*>(global_contract_fp8<false, FGlobalFfnContractC1024Fp8Parameters>);
}

// Host address resolver keeps the registered global_projection_c1024_fp8 specialization in this translation unit.
extern "C" const void* Resolve_global_projection_c1024_fp8()
{
	return reinterpret_cast<const void*>(global_contract_fp8<true, FGlobalProjectionC1024Fp8Parameters>);
}
