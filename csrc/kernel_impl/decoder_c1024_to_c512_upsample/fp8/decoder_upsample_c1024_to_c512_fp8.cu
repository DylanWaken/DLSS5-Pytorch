// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
// The double-buffered input ring is addressed through typed coordinate views and
// its transaction barriers through the named lifecycle ring. FP8 entries are
// rejected below SM89, matching host admission.
#include <common/layout/global_profiles.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/math.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/publication.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include <cuda_runtime.h>
#include <cstdint>

extern "C" __global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp8(
	FDecoderUpsampleC1024ToC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	using Profile = dlssnr::layout::DecoderProfile<bFp8>;
	using Accumulator = flashlight::tile::TiledMmaAccumulator<1, 8>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::barrier_base + Profile::stage_count * 8];
	const uint64_t g_Input = Parameters.g_Input;
	const uint64_t g_PackedWeights = Parameters.g_PackedWeights;
	const uint64_t g_Residual = Parameters.g_Residual;
	const uint64_t g_Output = Parameters.g_Output;
	const int g_Columns = (Parameters.InputWidth + 3) / 4;

	// Small devices execute one K split per stream-ordered launch. Zero keeps
	// the native grid-Z schedule; the launcher supplies Split + 1 otherwise.
	const int Split = Parameters.OrderedSplit ? int(Parameters.OrderedSplit) - 1 : int(blockIdx.z);
	const dlssnr::layout::DecoderCoordinates TileCoordinates{Parameters.InputHeight / 4,
															 Parameters.InputWidth / 4,
															 Parameters.OutputHeight / 4,
															 Parameters.OutputWidth / 4,
															 int(blockIdx.y),
															 int(blockIdx.x) % g_Columns,
															 (int(blockIdx.x) / g_Columns) * 256 +
																 int(threadIdx.y) * 128,
															 g_Columns,
															 Split,
															 int(threadIdx.x),
															 int(threadIdx.y)};
	const uint64_t g_SplitAccumulator = Parameters.g_SplitAccumulator;
	const uint64_t g_SplitCounters =
		Parameters.g_CompletionCounters + (TileCoordinates.tile_y * 2 * g_Columns + blockIdx.x) * 4;

	// Producer view starts at this warp's 512-byte half of a stage; consumer view
	// names the identical bytes as (stage, K subtile, lane).
	const flashlight::memory::SharedBytes Shared(s_Storage);
	using CopyStageView = flashlight::memory::StagedSharedLayoutView<
		uint4, flashlight::layout::ByteStrides<Profile::copy_bytes, Profile::lane_bytes>,
		Profile::stage_count, Profile::stage_bytes>;
	using InputStageView = flashlight::memory::StagedSharedLayoutView<
		uint4, flashlight::layout::ByteStrides<Profile::copy_bytes, Profile::lane_bytes>,
		Profile::stage_count, Profile::stage_bytes>;
	const CopyStageView CopyStage(Shared, uint32_t(TileCoordinates.warp * Profile::copy_bytes));
	const InputStageView InputStage(Shared);
	const flashlight::memory::TransactionBarrierRing<Profile::stage_count> BarrierRing(Shared,
																					   Profile::barrier_base);

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
	{
		BarrierRing.at_slot(0).initialize(64);
		BarrierRing.at_slot(1).initialize(64);
	}

	__syncthreads();
	Accumulator r_Accumulator{};

	// Keep the double-buffered async input pipeline and weight loads next to the MMA loop.
	uint4 r_Weights[2][8];
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			g_PackedWeights +
			uint64_t(TileCoordinates.split * 256 + ReductionTile * Profile::reduction_step) * 512 *
				Profile::element_bytes +
			TileCoordinates.output_channel * 32 + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
				r_Weights[r_KSubtile][r_NTile] =
					flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
						flashlight::memory::GlobalAddress(g_WeightTileBase + r_KSubtile * 16384 +
														  r_NTile * 512));
	};

	const auto IssueStage = [&](int ReductionTile)
	{
		const uint32_t s_Stage = uint32_t(ReductionTile % Profile::stage_count);
		const auto s_Barrier = BarrierRing.at_slot(s_Stage);
		const int g_Y = TileCoordinates.low_tiles_high == 1 ? 0 : TileCoordinates.tile_y;
		const int g_X = TileCoordinates.low_tiles_wide == 1 ? 0 : TileCoordinates.tile_x;
		if (g_Y < TileCoordinates.low_tiles_high && g_X < TileCoordinates.low_tiles_wide)
		{
			const uint64_t g_Source =
				g_Input +
				uint64_t(g_Y * TileCoordinates.low_tiles_wide + g_X) * 16384 * Profile::element_bytes +
				TileCoordinates.split * 4096 * Profile::element_bytes +
				(ReductionTile * 2 + TileCoordinates.warp) * 512;
			if (flashlight::arch::is_copy_producer(0xffffffffu))
			{
				s_Barrier.copy_then_expect(CopyStage.byte_offset_slot(s_Stage, 0, 0),
										   flashlight::memory::GlobalAddress(g_Source), Profile::copy_bytes);
			}
		}
		else
			CopyStage.store_slot(make_uint4(0, 0, 0, 0), s_Stage, 0, uint32_t(TileCoordinates.lane));
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	IssueStage(0);
	BarrierRing.at_slot(0).arrive_and_wait();
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::reduction_tiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::reduction_tiles)
			IssueStage(ReductionTile + 1);
		uint4 r_Input[1][2];
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			r_Input[0][r_KSubtile] =
				InputStage.load_slot(uint32_t(ReductionTile % Profile::stage_count), uint32_t(r_KSubtile),
									 uint32_t(TileCoordinates.lane));
		flashlight::tile::accumulate_tile<Profile::precision>(r_Accumulator, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::reduction_tiles)
		{
			LoadWeights(ReductionTile + 1);
			BarrierRing.for_iteration(ReductionTile + 1).arrive_and_wait();
		}
	}

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

			// GPU-scope acquire of the observed release before the CTA handoff.
			flashlight::memory::SplitPublication::acquire_fence();
		}

		__syncthreads();
	}

	// Split 0 stores Half scratch; splits 1/2 reduce, and split 3 loads without overwriting scratch.
	if (TileCoordinates.split < 3)
	{
		if (TileCoordinates.tile_y < TileCoordinates.low_tiles_high &&
			TileCoordinates.tile_x < TileCoordinates.low_tiles_wide)
		{
			const uint64_t g_SplitAccumulatorTile =
				g_SplitAccumulator +
				uint64_t(TileCoordinates.tile_y * TileCoordinates.low_tiles_wide + TileCoordinates.tile_x) *
					16384 +
				TileCoordinates.output_channel * 32 + TileCoordinates.lane * 16;
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			{
				const auto& r_OutputWords = r_Accumulator.word[0][r_NTile];
				const uint4 r_SplitAccumulatorVector =
					make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
				if (TileCoordinates.split == 0)
					flashlight::memory::store_no_allocate(
						flashlight::memory::GlobalAddress(g_SplitAccumulatorTile + r_NTile * 512),
						r_SplitAccumulatorVector);
				else
					flashlight::arch::reduce_half4_add_noftz(g_SplitAccumulatorTile + r_NTile * 512,
															 r_SplitAccumulatorVector);
			}
		}
	}
	else
	{
		const int g_Y = TileCoordinates.low_tiles_high == 1 ? 0 : TileCoordinates.tile_y;
		const int g_X = TileCoordinates.low_tiles_wide == 1 ? 0 : TileCoordinates.tile_x;
		const bool bValid = g_Y < TileCoordinates.low_tiles_high && g_X < TileCoordinates.low_tiles_wide;
		const uint64_t g_SplitAccumulatorTile =
			g_SplitAccumulator + uint64_t(g_Y * TileCoordinates.low_tiles_wide + g_X) * 16384 +
			TileCoordinates.output_channel * 32 + TileCoordinates.lane * 16;
		#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			const uint4 r_PreviousSplitWords =
				flashlight::memory::load_vector_or_zero<flashlight::memory::CachePolicy::Ca, uint4>(
					flashlight::memory::GlobalAddress(g_SplitAccumulatorTile + r_NTile * 512), bValid);
			auto& r_OutputWords = r_Accumulator.word[0][r_NTile];
			r_OutputWords[0] = flashlight::packed_bits(flashlight::numeric::half2_add(
				flashlight::PackedHalf2{r_PreviousSplitWords.x}, flashlight::PackedHalf2{r_OutputWords[0]}));
			r_OutputWords[1] = flashlight::packed_bits(flashlight::numeric::half2_add(
				flashlight::PackedHalf2{r_PreviousSplitWords.y}, flashlight::PackedHalf2{r_OutputWords[1]}));
			r_OutputWords[2] = flashlight::packed_bits(flashlight::numeric::half2_add(
				flashlight::PackedHalf2{r_PreviousSplitWords.z}, flashlight::PackedHalf2{r_OutputWords[2]}));
			r_OutputWords[3] = flashlight::packed_bits(flashlight::numeric::half2_add(
				flashlight::PackedHalf2{r_PreviousSplitWords.w}, flashlight::PackedHalf2{r_OutputWords[3]}));
		}
	}

	// Only the final split expands low pixels, adds the scaled residual, and publishes.
	if (TileCoordinates.split == 3)
	{
		uint32_t r_ResidualScales[8][2];
		#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			#pragma unroll
			for (int r_N8 = 0; r_N8 < 2; ++r_N8)
				r_ResidualScales[r_NTile][r_N8] =
					*flashlight::memory::GlobalAddress(g_PackedWeights + Profile::matrix_bytes +
													   (TileCoordinates.output_channel + r_NTile * 16 +
														r_N8 * 8 + (TileCoordinates.lane & 3) * 2) *
														   2)
						 .as_pointer<const uint32_t>();

		// A low 4x4 tile expands into four high 4x4 tiles. Indexed lane shuffles
		// duplicate each low pixel in X/Y while preserving packed channel ownership.
		#pragma unroll
		for (int QuadrantIndex = 0; QuadrantIndex < 4; ++QuadrantIndex)
		{
			const int g_OffsetY = QuadrantIndex / 2, g_OffsetX = QuadrantIndex % 2;
			const int g_OutputY = TileCoordinates.tile_y * 2 + g_OffsetY,
					  g_OutputX = TileCoordinates.tile_x * 2 + g_OffsetX;
			const int g_SkipY = TileCoordinates.high_tiles_high == 1 ? 0 : g_OutputY;
			const int g_SkipX = TileCoordinates.high_tiles_wide == 1 ? 0 : g_OutputX;
			const bool bValidSkip =
				g_SkipY < TileCoordinates.high_tiles_high && g_SkipX < TileCoordinates.high_tiles_wide;
			const uint64_t g_SkipBase = g_Residual +
										uint64_t(g_SkipY * TileCoordinates.high_tiles_wide + g_SkipX) * 8192 *
											Profile::element_bytes +
										TileCoordinates.output_channel * 16 * Profile::element_bytes +
										TileCoordinates.lane * 16;
			uint32_t r_Output[8][4];
			#pragma unroll
			for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			{
				uint32_t r_ResidualPairs[4];
				{
					const uint4 r_PackedResidual =
						flashlight::memory::load_vector_or_zero<flashlight::memory::CachePolicy::Ca, uint4>(
							flashlight::memory::GlobalAddress(g_SkipBase + (r_NTile / 2) * 512), bValidSkip);
					const uint32_t r_PackedResidualWords[4] = {r_PackedResidual.x, r_PackedResidual.y,
															   r_PackedResidual.z, r_PackedResidual.w};
					const uint32_t r_LowerWords = r_PackedResidualWords[(r_NTile % 2) * 2],
								   r_UpperWords = r_PackedResidualWords[(r_NTile % 2) * 2 + 1];
					r_ResidualPairs[0] = flashlight::numeric::decode_e4x2(uint16_t(r_LowerWords)).bits;
					r_ResidualPairs[1] = flashlight::numeric::decode_e4x2(uint16_t(r_UpperWords)).bits;
					r_ResidualPairs[2] = flashlight::numeric::decode_e4x2(uint16_t(r_LowerWords >> 16)).bits;
					r_ResidualPairs[3] = flashlight::numeric::decode_e4x2(uint16_t(r_UpperWords >> 16)).bits;
				}
				#pragma unroll
				for (int r_N8 = 0; r_N8 < 2; ++r_N8)
					#pragma unroll
					for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					{
						const int r_SourceLane = (TileCoordinates.lane & 3) |
												 ((TileCoordinates.lane >> 1) & 4) | (g_OffsetX * 8) |
												 (r_RowHalf * 16);
						const uint32_t r_Nearest = flashlight::arch::shuffle_index(
							r_Accumulator.word[0][r_NTile][r_N8 * 2 + g_OffsetY], uint32_t(r_SourceLane), 31u,
							0xffffffffu);
						r_Output[r_NTile][r_N8 * 2 + r_RowHalf] =
							flashlight::packed_bits(flashlight::numeric::half2_add(
								flashlight::PackedHalf2{r_Nearest},
								flashlight::numeric::half2_multiply(
									flashlight::PackedHalf2{r_ResidualPairs[r_N8 * 2 + r_RowHalf]},
									flashlight::PackedHalf2{r_ResidualScales[r_NTile][r_N8]})));
					}
			}
			if (g_OutputY >= TileCoordinates.high_tiles_high || g_OutputX >= TileCoordinates.high_tiles_wide)
				continue;
			const uint64_t g_OutputBase = g_Output +
										  uint64_t(g_OutputY * TileCoordinates.high_tiles_wide + g_OutputX) *
											  8192 * Profile::element_bytes +
										  TileCoordinates.output_channel * 16 * Profile::element_bytes +
										  TileCoordinates.lane * 16;
			#pragma unroll
			for (int r_Panel = 0; r_Panel < (bFp8 ? 4 : 8); ++r_Panel)
			{
				const auto& r_LowerWords = r_Output[r_Panel * 2];
				const auto& r_UpperWords = r_Output[r_Panel * 2 + 1];
				const uint4 r_Published =
					make_uint4(flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_LowerWords[0]},
																 flashlight::PackedHalf2{r_LowerWords[2]})
								   .bits,
							   flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_LowerWords[1]},
																 flashlight::PackedHalf2{r_LowerWords[3]})
								   .bits,
							   flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_UpperWords[0]},
																 flashlight::PackedHalf2{r_UpperWords[2]})
								   .bits,
							   flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_UpperWords[1]},
																 flashlight::PackedHalf2{r_UpperWords[3]})
								   .bits);
				flashlight::memory::store_no_allocate(
					flashlight::memory::GlobalAddress(g_OutputBase + r_Panel * 512), r_Published);
			}
		}
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
