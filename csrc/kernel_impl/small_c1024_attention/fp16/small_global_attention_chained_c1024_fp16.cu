// Additive Small31 safety variant of the recovered chained attention entry.
// It keeps the native score MMA, surrogate, P precision, K/V staging, masks,
// counters and publication; the P times V numerator and the whole row
// denominator reduction/normalization are FP32.
#include <common/layout/global_profiles.h>
#include <common/layout/numerical_constants.h>
#include <common/ops/global_attention.h>
#include <common/ops/small_attention.h>
#include <common/ops/window_attention.h>
#include <dlssnr/abi/small_attention.h>
#include <flashlight/arch/math.cuh>
#include <flashlight/arch/mma.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/publication.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/warp/permutation.cuh>
#include <cuda_runtime.h>
#include <cstdint>

extern "C" __global__ __maxnreg__(208) void small_global_attention_chained_c1024_fp16(
	FGlobalAttentionChainedC1024Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	constexpr bool bFp8 = false;
	using Profile = dlssnr::layout::GlobalAttentionProfile<bFp8>;
	using QueryFragment = flashlight::MmaAFragment<Profile::precision>;
	using HalfAccumulator = flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half>;
	using FloatAccumulator = flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Float>;
	using ValueFragment = flashlight::MmaBFragment<Profile::precision>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::barrier_offset + 16];
	const int g_Tokens = Parameters.BatchCount * Parameters.TokensPerBatch;
	const int g_Alignment = bFp8 ? 32 : 16;
	const int g_PaddedTokens = ((g_Tokens + g_Alignment - 1) / g_Alignment) * g_Alignment;
	const dlssnr::layout::GlobalAttentionCoordinates TileCoordinates{
		g_Tokens,		 g_PaddedTokens,  g_PaddedTokens / 16, (g_Tokens + 63) / 64, (g_Tokens + 127) / 128,
		int(blockIdx.x), int(blockIdx.y), int(threadIdx.x),	   int(threadIdx.y)};

	// Both precision rings share one physical layout: K then V, two stages each.
	const flashlight::memory::SharedBytes Shared(s_Storage);
	const auto KeyStage = dlssnr::ops::global_attention_key_view<bFp8>(Shared);
	const auto ValueStage = dlssnr::ops::global_attention_value_view<bFp8>(Shared);
	const auto BarrierRing = dlssnr::ops::global_attention_barrier_ring<bFp8>(Shared);

	// Wait only for the Q/K/V token groups needed by the next copy.
	const auto WaitPredecessor = [&](int g_FirstGroup, int g_Count)
	{
		if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
			for (int g_Group = g_FirstGroup;
				 g_Group < g_FirstGroup + g_Count && g_Group < TileCoordinates.query_blocks128; ++g_Group)
			{
				const flashlight::memory::SplitPublication Predecessor{flashlight::memory::GlobalAddress(
					Parameters.g_PredecessorCounters + (g_Group * 16 + TileCoordinates.head / 2) * 4)};
				while (int32_t(Predecessor.load_relaxed()) < 0)
					flashlight::arch::poll_sleep(64);
			}

		__syncthreads();
	};

	// Both initial fills and ring refills execute this exact K/V copy layout.
	const auto StageKeyValue = [&](int g_KeyTile)
	{
		const uint32_t s_Stage = uint32_t(g_KeyTile & 1);
		const auto s_Barrier = BarrierRing.at_slot(s_Stage);
		#pragma unroll
		for (int Copy = 0; Copy < Profile::query_chunks; ++Copy)
		{
			const int CopySlot = TileCoordinates.warp + Copy * 4;
			int g_KeyGroup = g_KeyTile * 4 + CopySlot / Profile::query_chunks;
			if (uint32_t(TileCoordinates.tokens + 14) < 31)
				g_KeyGroup = 0;
			const int g_KeyChunk = CopySlot % Profile::query_chunks;
			const uint64_t g_KeyAddress =
				Parameters.g_Key + uint64_t(g_KeyGroup) * 16384 * Profile::element_bytes +
				TileCoordinates.head * 512 * Profile::element_bytes + g_KeyChunk * 512;
			if (g_KeyGroup < TileCoordinates.groups16)
			{
				if (flashlight::arch::is_copy_producer(0xffffffffu))
				{
					s_Barrier.copy_then_expect(KeyStage.byte_offset_slot(s_Stage, uint32_t(CopySlot), 0),
											   flashlight::memory::GlobalAddress(g_KeyAddress), 512);
				}
			}
			else
				KeyStage.store_slot(make_uint4(0, 0, 0, 0), s_Stage, uint32_t(CopySlot),
									TileCoordinates.lane);
		}

		#pragma unroll
		for (int Copy = 0; Copy < Profile::query_chunks; ++Copy)
		{
			const int CopySlot = TileCoordinates.warp + Copy * 4;
			int g_KeyGroup = g_KeyTile * 4 + CopySlot / Profile::query_chunks;
			if (uint32_t(TileCoordinates.tokens + 14) < 31)
				g_KeyGroup = 0;

			// V has transposed fragments. FP8 stores two neighboring M16 tiles
			// in one M32 group; Half stores one M16 group with two N16 panels.
			const int g_ValueGroup = bFp8 ? g_KeyTile * 2 + CopySlot / 2 : g_KeyGroup;
			const int g_ValueGroups = bFp8 ? TileCoordinates.groups16 / 2 : TileCoordinates.groups16;
			const uint64_t g_ValueAddress = Parameters.g_Value + uint64_t(g_ValueGroup) * 32768 +
											TileCoordinates.head * 1024 + (CopySlot & 1) * 512;
			if (g_ValueGroup < g_ValueGroups)
			{
				if (flashlight::arch::is_copy_producer(0xffffffffu))
				{
					s_Barrier.copy_then_expect(ValueStage.byte_offset_slot(s_Stage, uint32_t(CopySlot), 0),
											   flashlight::memory::GlobalAddress(g_ValueAddress), 512);
				}
			}
			else
				ValueStage.store_slot(make_uint4(0, 0, 0, 0), s_Stage, uint32_t(CopySlot),
									  TileCoordinates.lane);
		}
	};

	// A ring slot is readable only after its K and V transactions complete.
	const auto WaitStage = [&](int g_KeyTile)
	{ BarrierRing.at_slot(uint32_t(g_KeyTile & 1)).arrive_and_wait(); };

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
		#pragma unroll
		for (uint32_t s_Stage = 0; s_Stage < Profile::stage_count; ++s_Stage)
			BarrierRing.at_slot(s_Stage).initialize(blockDim.x * blockDim.y);
	__syncthreads();
	WaitPredecessor(TileCoordinates.query_block256 * 2, 2);

	// Keep the query tile in registers while successive K/V tiles stream through shared memory.
	QueryFragment r_Query[4][Profile::query_chunks];
	#pragma unroll
	for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
		#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::query_chunks; ++r_ReductionChunk)
		{
			int g_Group = TileCoordinates.query_block256 * 16 + TileCoordinates.warp * 4 + r_QueryTile;
			if (uint32_t(g_Tokens + 14) < 31)
				g_Group = 0;
			const uint64_t g_QueryFragmentAddress = Parameters.g_Query +
													uint64_t(g_Group) * 16384 * Profile::element_bytes +
													TileCoordinates.head * 512 * Profile::element_bytes +
													r_ReductionChunk * 512 + TileCoordinates.lane * 16;
			const uint4 r_QueryVector =
				flashlight::memory::load_vector_or_zero<flashlight::memory::CachePolicy::Ca, uint4>(
					flashlight::memory::GlobalAddress(g_QueryFragmentAddress),
					g_Group < TileCoordinates.groups16);
			r_Query[r_QueryTile][r_ReductionChunk] =
				QueryFragment{{r_QueryVector.x, r_QueryVector.y, r_QueryVector.z, r_QueryVector.w}};
		}

	#pragma unroll
	for (int g_KeyTile = 0; g_KeyTile < 2; ++g_KeyTile)
		if (g_KeyTile < TileCoordinates.key_tiles)
		{
			WaitPredecessor(g_KeyTile / 2, 1);
			StageKeyValue(g_KeyTile);
		}

	if (TileCoordinates.key_tiles > 0)
		WaitStage(0);

	// Persistent FP32 numerator: query tile, output column tile, native D register.
	// D0/D1 are the two lane-owned columns of row Lane/4; D2/D3 are row Lane/4+8.
	FloatAccumulator r_Output[4][4]{};

	// Two FP32 row denominators per lane, replacing the low/high packed-Half lanes.
	float r_Denominator[2] = {0.0f, 0.0f};

	// Accumulate unnormalized attention and its row sums while rotating the two K/V stages.
	#pragma unroll 1
	for (int g_KeyTile = 0; g_KeyTile < TileCoordinates.key_tiles; ++g_KeyTile)
	{
		const uint32_t s_Stage = uint32_t(g_KeyTile & 1);
		uint4 r_Key[4][Profile::query_chunks];
		#pragma unroll
		for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
			#pragma unroll
			for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::query_chunks; ++r_ReductionChunk)
				r_Key[r_ColumnTile][r_ReductionChunk] = KeyStage.load_slot(
					s_Stage, uint32_t(r_ColumnTile * Profile::query_chunks + r_ReductionChunk),
					TileCoordinates.lane);

		// Form Q times K-transpose scores and apply the native packed-Half exponent surrogate.
		dlssnr::layout::WindowAccumulatorTile<64> r_Probability[4]{};
		#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 8; ++r_ColumnTile)
			{
				HalfAccumulator r_ProbabilityAccumulator{{r_Probability[r_QueryTile].pair[r_ColumnTile][0],
														  r_Probability[r_QueryTile].pair[r_ColumnTile][1]}};
				#pragma unroll
				for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::query_chunks; ++r_ReductionChunk)
				{
					const uint4 r_KeyVector = r_Key[r_ColumnTile / 2][r_ReductionChunk];
					const uint32_t r_KeyFragment[2] = {r_ColumnTile & 1 ? r_KeyVector.z : r_KeyVector.x,
													   r_ColumnTile & 1 ? r_KeyVector.w : r_KeyVector.y};
					dlssnr::ops::mma_window_fragment<bFp8>(
						r_Query[r_QueryTile][r_ReductionChunk],
						ValueFragment{{r_KeyFragment[0], r_KeyFragment[1]}}, r_ProbabilityAccumulator);
				}
				r_Probability[r_QueryTile].pair[r_ColumnTile][0] = r_ProbabilityAccumulator.word[0];
				r_Probability[r_QueryTile].pair[r_ColumnTile][1] = r_ProbabilityAccumulator.word[1];
				#pragma unroll
				for (int r_Half = 0; r_Half < 2; ++r_Half)
					r_Probability[r_QueryTile].pair[r_ColumnTile][r_Half] =
						flashlight::packed_bits(dlssnr::ops::global_attention_exponential(
							flashlight::PackedHalf2{r_Probability[r_QueryTile].pair[r_ColumnTile][r_Half]}));
			}

		// Sum the current score tile. Every packed native-Half probability term is
		// widened to two FP32 components before its first addition, so the local
		// tree, the warp transpose and the cross-key-tile carry share one FP32
		// reduction with the recovered add order.
		{
			float r_QuerySums[2];
			#pragma unroll
			for (int r_QueryHalf = 0; r_QueryHalf < 2; ++r_QueryHalf)
			{
				float2 r_LocalProbabilitySums[4], r_GatheredProbabilitySums[4];
				#pragma unroll
				for (int r_Row = 0; r_Row < 4; ++r_Row)
				{
					const auto& r_Pairs = r_Probability[r_QueryHalf * 2 + r_Row / 2].pair;
					const int r_QueryRowHalf = r_Row & 1;
					const float2 r_Pair01 = dlssnr::ops::add_float2_componentwise(
						dlssnr::ops::widen_half_pair_float2(r_Pairs[0][r_QueryRowHalf]),
						dlssnr::ops::widen_half_pair_float2(r_Pairs[1][r_QueryRowHalf]));
					const float2 r_Pair23 = dlssnr::ops::add_float2_componentwise(
						dlssnr::ops::widen_half_pair_float2(r_Pairs[2][r_QueryRowHalf]),
						dlssnr::ops::widen_half_pair_float2(r_Pairs[3][r_QueryRowHalf]));
					const float2 r_Pair45 = dlssnr::ops::add_float2_componentwise(
						dlssnr::ops::widen_half_pair_float2(r_Pairs[4][r_QueryRowHalf]),
						dlssnr::ops::widen_half_pair_float2(r_Pairs[5][r_QueryRowHalf]));
					const float2 r_Pair67 = dlssnr::ops::add_float2_componentwise(
						dlssnr::ops::widen_half_pair_float2(r_Pairs[6][r_QueryRowHalf]),
						dlssnr::ops::widen_half_pair_float2(r_Pairs[7][r_QueryRowHalf]));
					float2 r_Sum = dlssnr::ops::add_float2_componentwise(r_Pair01, r_Pair23);
					r_Sum = dlssnr::ops::add_float2_componentwise(r_Sum, r_Pair45);
					r_LocalProbabilitySums[r_Row] = dlssnr::ops::add_float2_componentwise(r_Sum, r_Pair67);
				}

				// This warp transpose turns the MMA fragment's channel ownership
				// into one full query sum per lane. It permutes and shuffles whole
				// FP32 component pairs, so the recovered lane mapping is unchanged.
				const int r_SourceLane = ((TileCoordinates.lane & 7) << 2) + (TileCoordinates.lane >> 3);
				flashlight::warp::permute_quad(r_LocalProbabilitySums, TileCoordinates.lane & 3);
				#pragma unroll
				for (int r_Row = 0; r_Row < 4; ++r_Row)
					r_GatheredProbabilitySums[r_Row] = flashlight::warp::shuffle_index(
						r_LocalProbabilitySums[r_Row], uint32_t(r_SourceLane ^ r_Row),
						dlssnr::layout::warp_clamp, dlssnr::layout::warp_members);
				flashlight::warp::permute_quad(r_GatheredProbabilitySums, TileCoordinates.lane >> 3);
				float2 r_Sum = dlssnr::ops::add_float2_componentwise(r_GatheredProbabilitySums[0],
																	 r_GatheredProbabilitySums[1]);
				r_Sum = dlssnr::ops::add_float2_componentwise(r_Sum, r_GatheredProbabilitySums[2]);
				r_Sum = dlssnr::ops::add_float2_componentwise(r_Sum, r_GatheredProbabilitySums[3]);

				// The recovered reduction finishes by adding the low and high lane
				// halves; keep that final logical step in FP32 as well.
				r_QuerySums[r_QueryHalf] = dlssnr::ops::total_float2(r_Sum);
			}

			// The score terms stay the original Half probabilities; the whole row
			// reduction and its running cross-key-tile carry are now FP32.
			r_Denominator[0] += r_QuerySums[0];
			r_Denominator[1] += r_QuerySums[1];
		}

		// Multiply the current probability tile by V into persistent FP32 numerators.
		uint4 r_Value[Profile::probability_chunks][2];
		#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::probability_chunks; ++r_ReductionChunk)
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
				r_Value[r_ReductionChunk][r_ColumnTile] = ValueStage.load_slot(
					s_Stage, uint32_t(r_ReductionChunk * 2 + r_ColumnTile), TileCoordinates.lane);
		#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
				#pragma unroll
				for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::probability_chunks;
					 ++r_ReductionChunk)
				{
					const auto r_ProbabilityFragment =
						dlssnr::ops::publish_window_chunk<bFp8>(r_Probability[r_QueryTile], r_ReductionChunk);
					const uint4 r_ValueVector = r_Value[r_ReductionChunk][r_ColumnTile];
					flashlight::arch::mma_sync<Profile::precision, flashlight::AccumulatorPrecision::Float>(
						r_Output[r_QueryTile][r_ColumnTile * 2], r_ProbabilityFragment,
						ValueFragment{{r_ValueVector.x, r_ValueVector.y}});
					flashlight::arch::mma_sync<Profile::precision, flashlight::AccumulatorPrecision::Float>(
						r_Output[r_QueryTile][r_ColumnTile * 2 + 1], r_ProbabilityFragment,
						ValueFragment{{r_ValueVector.z, r_ValueVector.w}});
				}

		if (g_KeyTile + 2 < TileCoordinates.key_tiles)
		{
			WaitPredecessor((g_KeyTile + 2) / 2, 1);
			StageKeyValue(g_KeyTile + 2);
		}

		if (g_KeyTile + 1 < TileCoordinates.key_tiles)
			WaitStage(g_KeyTile + 1);
	}

	// Remove padded-key probability mass in FP32, then clamp and invert the
	// denominator without the intermediate packed-Half round trip.
	uint32_t r_InverseDenominatorLow, r_InverseDenominatorHigh;
	{
		const int PaddingKeys = TileCoordinates.key_tiles * 64 - g_Tokens;
		if (PaddingKeys > 0)
		{
			// Padded keys produce the surrogate's nonzero value at score zero.
			// The correction is the exact product of that Half value and the
			// padded-key count, subtracted from both FP32 row totals.
			const uint32_t r_AffineZero = flashlight::packed_bits(flashlight::numeric::half2_fma(
				flashlight::PackedHalf2{0}, flashlight::PackedHalf2{dlssnr::layout::global_exp_slope_half2},
				flashlight::PackedHalf2{dlssnr::layout::global_exp_intercept_half2}));
			const uint32_t r_ClampedZero = flashlight::packed_bits(flashlight::numeric::half2_minimum(
				flashlight::numeric::half2_maximum(
					flashlight::PackedHalf2{r_AffineZero},
					flashlight::PackedHalf2{dlssnr::layout::global_exp_lower_half2}),
				flashlight::PackedHalf2{dlssnr::layout::global_exp_upper_half2}));
			const uint16_t r_ZeroScore =
				uint16_t((uint16_t(r_ClampedZero) << dlssnr::layout::global_exp_encoding_shift) +
						 dlssnr::layout::global_exp_scalar_offset);
			const float r_Correction = flashlight::arch::multiply_ftz(
				__uint_as_float(flashlight::numeric::half_to_float_bits(r_ZeroScore)),
				__uint_as_float(flashlight::numeric::uint_to_float_rn_bits(uint32_t(PaddingKeys))));
			r_Denominator[0] -= r_Correction;
			r_Denominator[1] -= r_Correction;
		}

		// The epsilon is replicated in its native word; widen the low Half so the
		// clamp value and the NaN choice stay those of the recovered kernel.
		const float r_Epsilon = __uint_as_float(
			flashlight::numeric::half_to_float_bits(uint16_t(dlssnr::layout::normalization_epsilon_half2)));
		r_InverseDenominatorLow = __float_as_uint(flashlight::arch::reciprocal_approx_ftz(
			dlssnr::ops::clamp_denominator_float(r_Denominator[0], r_Epsilon)));
		r_InverseDenominatorHigh = __float_as_uint(flashlight::arch::reciprocal_approx_ftz(
			dlssnr::ops::clamp_denominator_float(r_Denominator[1], r_Epsilon)));
	}

	// Apply row normalization in FP32, round each column pair once to packed
	// Half, then reuse the native publication mapping.
	#pragma unroll
	for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
	{
		dlssnr::layout::WindowAccumulatorTile<32> r_NormalizedOutput;
		#pragma unroll
		for (int r_Half = 0; r_Half < 2; ++r_Half)
		{
			const int QueryRow = r_QueryTile * 16 + TileCoordinates.lane / 4 + r_Half * 8;
			const uint32_t r_LocalInverse =
				r_QueryTile < 2 ? r_InverseDenominatorLow : r_InverseDenominatorHigh;
			const float r_QueryNormalization = __uint_as_float(
				flashlight::arch::shuffle_index(r_LocalInverse, uint32_t(QueryRow % 32),
												dlssnr::layout::warp_clamp, dlssnr::layout::warp_members));
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
				r_NormalizedOutput.pair[r_ColumnTile][r_Half] = dlssnr::ops::pack_float_columns_half2(
					r_Output[r_QueryTile][r_ColumnTile].value[2 * r_Half] * r_QueryNormalization,
					r_Output[r_QueryTile][r_ColumnTile].value[2 * r_Half + 1] * r_QueryNormalization);
		}

		const int g_Group = TileCoordinates.query_block256 * 16 + TileCoordinates.warp * 4 + r_QueryTile;
		if (g_Group < TileCoordinates.groups16)
			#pragma unroll
			for (int r_Chunk = 0; r_Chunk < Profile::query_chunks; ++r_Chunk)
			{
				const auto r_OutputFragment =
					dlssnr::ops::publish_window_chunk<bFp8>(r_NormalizedOutput, r_Chunk);
				flashlight::memory::store_no_allocate(
					flashlight::memory::GlobalAddress(Parameters.g_Output +
													  uint64_t(g_Group) * 16384 * Profile::element_bytes +
													  TileCoordinates.head * 512 * Profile::element_bytes +
													  r_Chunk * 512 + TileCoordinates.lane * 16),
					make_uint4(r_OutputFragment.word[0], r_OutputFragment.word[1], r_OutputFragment.word[2],
							   r_OutputFragment.word[3]));
			}
	}

	// Native outputs include a padded last token group. Clear only its invalid
	// rows after all fragment stores, then release the completion counters.
	if (g_PaddedTokens != g_Tokens)
	{
		__syncthreads();
		#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
			#pragma unroll
			for (int r_Half = 0; r_Half < 2; ++r_Half)
			{
				const int g_Group =
					TileCoordinates.query_block256 * 16 + TileCoordinates.warp * 4 + r_QueryTile;
				const int g_Row = g_Group * 16 + TileCoordinates.lane / 4 + r_Half * 8;
				if (g_Row >= g_Tokens && g_Row < g_PaddedTokens)
					#pragma unroll
					for (int r_Chunk = 0; r_Chunk < Profile::query_chunks; ++r_Chunk)
						#pragma unroll
						for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
							flashlight::memory::store_vector<uint32_t>(
								flashlight::memory::GlobalAddress(
									Parameters.g_Output + uint64_t(g_Group) * 16384 * Profile::element_bytes +
									TileCoordinates.head * 512 * Profile::element_bytes + r_Chunk * 512 +
									TileCoordinates.lane * 16 + (r_ColumnTile * 2 + r_Half) * 4),
								0u);
			}
	}

	__syncthreads();
	if (Parameters.g_CompletionCounters && TileCoordinates.lane == 0 && TileCoordinates.warp == 0)
		#pragma unroll
		for (int g_LocalGroup = 0; g_LocalGroup < 2; ++g_LocalGroup)
		{
			const int g_Group = TileCoordinates.query_block256 * 2 + g_LocalGroup;
			if (g_Group < TileCoordinates.query_blocks128)
				flashlight::memory::SplitPublication{
					flashlight::memory::GlobalAddress(Parameters.g_CompletionCounters +
													  (g_Group * 32 + TileCoordinates.head) * 4)}
					.store_release(0);
		}
#endif
}
