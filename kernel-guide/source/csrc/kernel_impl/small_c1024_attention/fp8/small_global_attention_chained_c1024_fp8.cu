// Additive Small31 safety variant of the recovered chained FP8 attention entry.
// It keeps the native E4M3 score MMA, surrogate, P publication, K/V staging,
// masks, counters and Half-to-E4M3 output contract; the P times V numerator and
// the whole row denominator reduction/normalization are FP32.
#include "../../shared/common/kernel_helpers.cuh"
#include "../../bottleneck_c1024_attention/common/global_attention.cuh"
#include "../common/small_attention_abi.h"
#include "../common/intrinsics.cuh"

extern "C" __global__ __maxnreg__(208) void small_global_attention_chained_c1024_fp8(
	FGlobalAttentionChainedC1024Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	using Profile = FGlobalAttentionProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[Profile::s_BarrierOffset + 16];
	const int g_Tokens = Parameters.BatchCount * Parameters.TokensPerBatch;
	const int g_Alignment = bFp8 ? 32 : 16;
	const int g_PaddedTokens = ((g_Tokens + g_Alignment - 1) / g_Alignment) * g_Alignment;
	const FGlobalAttentionCoordinates TileCoordinates{
		g_Tokens,		 g_PaddedTokens,  g_PaddedTokens / 16, (g_Tokens + 63) / 64, (g_Tokens + 127) / 128,
		int(blockIdx.x), int(blockIdx.y), int(threadIdx.x),	   int(threadIdx.y)};

	// Wait only for the Q/K/V token groups needed by the next copy.
	const auto WaitPredecessor = [&](int g_FirstGroup, int g_Count)
	{
		if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
			for (int g_Group = g_FirstGroup;
				 g_Group < g_FirstGroup + g_Count && g_Group < TileCoordinates.g_QueryBlocks128; ++g_Group)
				while (int32_t(CounterLoadRelaxed(Parameters.g_PredecessorCounters +
												  (g_Group * 16 + TileCoordinates.g_Head / 2) * 4)) < 0)
					PollSleep(64);
		__syncthreads();
	};

	// Both initial fills and ring refills execute this exact K/V copy layout.
	const auto StageKeyValue = [&](int g_KeyTile)
	{
		const int s_Stage = (g_KeyTile & 1) * Profile::s_StageBytes;
		const int s_Barrier = Profile::s_BarrierOffset + (g_KeyTile & 1) * 8;
		#pragma unroll
		for (int Copy = 0; Copy < Profile::QueryChunks; ++Copy)
		{
			const int CopySlot = TileCoordinates.Warp + Copy * 4;
			int g_KeyGroup = g_KeyTile * 4 + CopySlot / Profile::QueryChunks;
			const int g_KeyChunk = CopySlot % Profile::QueryChunks;
			const uint64_t g_KeyAddress =
				Parameters.g_Key + uint64_t(g_KeyGroup) * 16384 * Profile::ElementBytes +
				TileCoordinates.g_Head * 512 * Profile::ElementBytes + g_KeyChunk * 512;
			const int s_Copy = s_Stage + CopySlot * 512;
			if (g_KeyGroup < TileCoordinates.g_Groups16)
			{
				if (IsCopyProducer(0xffffffffu))
				{
					CopyBulk(s_Storage, s_Copy, g_KeyAddress, 512, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, 512);
				}
			}
			else
				*reinterpret_cast<uint4*>(s_Storage + s_Copy + TileCoordinates.Lane * 16) =
					make_uint4(0, 0, 0, 0);
		}

		#pragma unroll
		for (int Copy = 0; Copy < Profile::QueryChunks; ++Copy)
		{
			const int CopySlot = TileCoordinates.Warp + Copy * 4;
			int g_KeyGroup = g_KeyTile * 4 + CopySlot / Profile::QueryChunks;
			const int s_Copy = s_Stage + CopySlot * 512;

			// V has transposed fragments. FP8 stores two neighboring M16 tiles
			// in one M32 group; Half stores one M16 group with two N16 panels.
			int g_ValueGroup = bFp8 ? g_KeyTile * 2 + CopySlot / 2 : g_KeyGroup;
			const int g_ValueGroups = bFp8 ? TileCoordinates.g_Groups16 / 2 : TileCoordinates.g_Groups16;
			if (g_ValueGroups == 1)
				g_ValueGroup = 0;
			const uint64_t g_ValueAddress = Parameters.g_Value + uint64_t(g_ValueGroup) * 32768 +
											TileCoordinates.g_Head * 1024 + (CopySlot & 1) * 512;
			const int s_ValueCopy = Profile::s_ValueOffset + s_Copy;
			if (g_ValueGroup < g_ValueGroups)
			{
				if (IsCopyProducer(0xffffffffu))
				{
					CopyBulk(s_Storage, s_ValueCopy, g_ValueAddress, 512, s_Barrier);
					BarrierExpect(s_Storage, s_Barrier, 512);
				}
			}
			else
				*reinterpret_cast<uint4*>(s_Storage + s_ValueCopy + TileCoordinates.Lane * 16) =
					make_uint4(0, 0, 0, 0);
		}
	};

	// A ring slot is readable only after its K and V transactions complete.
	const auto WaitStage = [&](int g_KeyTile)
	{
		const int s_Barrier = FGlobalAttentionProfile<bFp8>::s_BarrierOffset + (g_KeyTile & 1) * 8;
		ArriveAndWait(s_Storage, s_Barrier);
	};

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
		#pragma unroll
		for (int s_Stage = 0; s_Stage < 2; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();
	WaitPredecessor(TileCoordinates.g_QueryBlock256 * 2, 2);

	// Keep the query tile in registers while successive K/V tiles stream through shared memory.
	FWindowAFragment r_Query[4][Profile::QueryChunks];
	#pragma unroll
	for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
		#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::QueryChunks; ++r_ReductionChunk)
		{
			int g_Group = TileCoordinates.g_QueryBlock256 * 16 + TileCoordinates.Warp * 4 + r_QueryTile;
			const uint64_t g_QueryFragmentAddress = Parameters.g_Query +
													uint64_t(g_Group) * 16384 * Profile::ElementBytes +
													TileCoordinates.g_Head * 512 * Profile::ElementBytes +
													r_ReductionChunk * 512 + TileCoordinates.Lane * 16;
			r_Query[r_QueryTile][r_ReductionChunk] =
				MakeWindowFragment(g_Group < TileCoordinates.g_Groups16
									   ? __ldca(reinterpret_cast<const uint4*>(g_QueryFragmentAddress))
									   : make_uint4(0, 0, 0, 0));
		}

	#pragma unroll
	for (int g_KeyTile = 0; g_KeyTile < 2; ++g_KeyTile)
		if (g_KeyTile < TileCoordinates.g_KeyTiles)
		{
			WaitPredecessor(g_KeyTile / 2, 1);
			StageKeyValue(g_KeyTile);
		}

	if (TileCoordinates.g_KeyTiles > 0)
		WaitStage(0);
	// Persistent FP32 numerator: query tile, output column tile, native D register.
	// D0/D1 are the two lane-owned columns of row Lane/4; D2/D3 are row Lane/4+8.
	float r_Output[4][4][4]{};
	// Two FP32 row denominators per lane, replacing the low/high packed-Half lanes.
	float r_Denominator[2] = {0.0f, 0.0f};

	// Accumulate unnormalized attention and its row sums while rotating the two K/V stages.
	#pragma unroll 1
	for (int g_KeyTile = 0; g_KeyTile < TileCoordinates.g_KeyTiles; ++g_KeyTile)
	{
		const int s_Base = (g_KeyTile & 1) * Profile::s_StageBytes + TileCoordinates.Lane * 16;
		uint4 r_Key[4][Profile::QueryChunks];
		#pragma unroll
		for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
			#pragma unroll
			for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::QueryChunks; ++r_ReductionChunk)
				r_Key[r_ColumnTile][r_ReductionChunk] = *reinterpret_cast<const uint4*>(
					s_Storage + s_Base + (r_ColumnTile * Profile::QueryChunks + r_ReductionChunk) * 512);

		// Form Q times K-transpose scores and apply the native packed-Half exponent surrogate.
		FWindowAccumulatorTile<64> r_Probability[4]{};
		#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 8; ++r_ColumnTile)
			{
				#pragma unroll
				for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::QueryChunks; ++r_ReductionChunk)
				{
					const uint4 r_KeyVector = r_Key[r_ColumnTile / 2][r_ReductionChunk];
					const uint32_t r_KeyFragment[2] = {r_ColumnTile & 1 ? r_KeyVector.z : r_KeyVector.x,
													   r_ColumnTile & 1 ? r_KeyVector.w : r_KeyVector.y};
					MmaWindowFragment<bFp8>(r_Query[r_QueryTile][r_ReductionChunk], r_KeyFragment,
											r_Probability[r_QueryTile].r_Pair[r_ColumnTile]);
				}
				#pragma unroll
				for (int r_Half = 0; r_Half < 2; ++r_Half)
				{
					const uint32_t r_Score = r_Probability[r_QueryTile].r_Pair[r_ColumnTile][r_Half];
					const uint32_t r_Affine =
						HalfFma(r_Score, CONST_GLOBAL_EXP_SLOPE_HALF2, CONST_GLOBAL_EXP_INTERCEPT_HALF2);
					const uint32_t r_Clamped = HalfMin(HalfMax(r_Affine, CONST_GLOBAL_EXP_LOWER_HALF2),
													   CONST_GLOBAL_EXP_UPPER_HALF2);
					r_Probability[r_QueryTile].r_Pair[r_ColumnTile][r_Half] =
						(r_Clamped << CONST_GLOBAL_EXP_ENCODING_SHIFT) + CONST_GLOBAL_EXP_ENCODING_OFFSET;
				}
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
					const auto& r_Pairs = r_Probability[r_QueryHalf * 2 + r_Row / 2].r_Pair;
					const int r_QueryRowHalf = r_Row & 1;
					const float2 r_Pair01 =
						AddFloat2Componentwise(WidenHalfPairFloat2(r_Pairs[0][r_QueryRowHalf]),
											   WidenHalfPairFloat2(r_Pairs[1][r_QueryRowHalf]));
					const float2 r_Pair23 =
						AddFloat2Componentwise(WidenHalfPairFloat2(r_Pairs[2][r_QueryRowHalf]),
											   WidenHalfPairFloat2(r_Pairs[3][r_QueryRowHalf]));
					const float2 r_Pair45 =
						AddFloat2Componentwise(WidenHalfPairFloat2(r_Pairs[4][r_QueryRowHalf]),
											   WidenHalfPairFloat2(r_Pairs[5][r_QueryRowHalf]));
					const float2 r_Pair67 =
						AddFloat2Componentwise(WidenHalfPairFloat2(r_Pairs[6][r_QueryRowHalf]),
											   WidenHalfPairFloat2(r_Pairs[7][r_QueryRowHalf]));
					float2 r_Sum = AddFloat2Componentwise(r_Pair01, r_Pair23);
					r_Sum = AddFloat2Componentwise(r_Sum, r_Pair45);
					r_LocalProbabilitySums[r_Row] = AddFloat2Componentwise(r_Sum, r_Pair67);
				}

				// This warp transpose turns the MMA fragment's channel ownership
				// into one full query sum per lane. It permutes and shuffles whole
				// FP32 component pairs, so the recovered lane mapping is unchanged.
				const int r_SourceLane = ((TileCoordinates.Lane & 7) << 2) + (TileCoordinates.Lane >> 3);
				PermuteGlobalAttentionQuadFloat2(r_LocalProbabilitySums, TileCoordinates.Lane & 3);
				#pragma unroll
				for (int r_Row = 0; r_Row < 4; ++r_Row)
					r_GatheredProbabilitySums[r_Row] = ShuffleFloat2Idx(
						r_LocalProbabilitySums[r_Row], r_SourceLane ^ r_Row, 31, 0xffffffffu);
				PermuteGlobalAttentionQuadFloat2(r_GatheredProbabilitySums, TileCoordinates.Lane >> 3);
				float2 r_Sum = AddFloat2Componentwise(r_GatheredProbabilitySums[0],
													  r_GatheredProbabilitySums[1]);
				r_Sum = AddFloat2Componentwise(r_Sum, r_GatheredProbabilitySums[2]);
				r_Sum = AddFloat2Componentwise(r_Sum, r_GatheredProbabilitySums[3]);
				// The recovered reduction finishes by adding the low and high lane
				// halves; keep that final logical step in FP32 as well.
				r_QuerySums[r_QueryHalf] = TotalFloat2(r_Sum);
			}
			// The score terms stay the original Half probabilities and the FP8
			// P operand below is their E4M3 conversion; the whole row reduction
			// and its running cross-key-tile carry are now FP32.
			r_Denominator[0] += r_QuerySums[0];
			r_Denominator[1] += r_QuerySums[1];
		}

		// Multiply the current probability tile by V into persistent FP32 numerators.
		uint4 r_Value[Profile::ProbabilityChunks][2];
		#pragma unroll
		for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::ProbabilityChunks; ++r_ReductionChunk)
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
				r_Value[r_ReductionChunk][r_ColumnTile] =
					*reinterpret_cast<const uint4*>(s_Storage + Profile::s_ValueOffset + s_Base +
													(r_ReductionChunk * 2 + r_ColumnTile) * 512);
		#pragma unroll
		for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
				#pragma unroll
				for (int r_ReductionChunk = 0; r_ReductionChunk < Profile::ProbabilityChunks;
					 ++r_ReductionChunk)
				{
					const auto r_ProbabilityFragment =
						PublishWindowChunk<bFp8>(r_Probability[r_QueryTile], r_ReductionChunk);
					const uint4 r_ValueVector = r_Value[r_ReductionChunk][r_ColumnTile];
					const uint32_t r_LowerValueFragment[2] = {r_ValueVector.x, r_ValueVector.y},
								   r_UpperValueFragment[2] = {r_ValueVector.z, r_ValueVector.w};
					MmaWindowFragmentF32<bFp8>(r_ProbabilityFragment, r_LowerValueFragment,
											   r_Output[r_QueryTile][r_ColumnTile * 2]);
					MmaWindowFragmentF32<bFp8>(r_ProbabilityFragment, r_UpperValueFragment,
											   r_Output[r_QueryTile][r_ColumnTile * 2 + 1]);
				}

		if (g_KeyTile + 2 < TileCoordinates.g_KeyTiles)
		{
			WaitPredecessor((g_KeyTile + 2) / 2, 1);
			StageKeyValue(g_KeyTile + 2);
		}

		if (g_KeyTile + 1 < TileCoordinates.g_KeyTiles)
			WaitStage(g_KeyTile + 1);
	}

	// Remove padded-key probability mass in FP32, then clamp and invert the
	// denominator without the intermediate packed-Half round trip.
	uint32_t r_InverseDenominatorLow, r_InverseDenominatorHigh;
	{
		const int PaddingKeys = TileCoordinates.g_KeyTiles * 64 - g_Tokens;
		if (PaddingKeys > 0)
		{
			// Padded keys produce the surrogate's nonzero value at score zero.
			// The correction is the exact product of that Half value and the
			// padded-key count, subtracted from both FP32 row totals.
			const uint32_t r_AffineZero =
				HalfFma(0, CONST_GLOBAL_EXP_SLOPE_HALF2, CONST_GLOBAL_EXP_INTERCEPT_HALF2);
			const uint32_t r_ClampedZero =
				HalfMin(HalfMax(r_AffineZero, CONST_GLOBAL_EXP_LOWER_HALF2), CONST_GLOBAL_EXP_UPPER_HALF2);
			const uint16_t r_ZeroScore =
				uint16_t((uint16_t(r_ClampedZero) << CONST_GLOBAL_EXP_ENCODING_SHIFT) +
						 CONST_GLOBAL_EXP_SCALAR_OFFSET);
			const uint32_t r_CorrectionBits =
				FloatMulFtzBits(HalfToFloatBits(r_ZeroScore), UintToFloatRnBits(PaddingKeys));
			r_Denominator[0] -= __uint_as_float(r_CorrectionBits);
			r_Denominator[1] -= __uint_as_float(r_CorrectionBits);
		}

		// The epsilon is replicated in its native word; widen the low Half so the
		// clamp value and the NaN choice stay those of the recovered kernel.
		const float r_Epsilon =
			__uint_as_float(HalfToFloatBits(uint16_t(CONST_NORMALIZATION_EPSILON_HALF2)));
		r_InverseDenominatorLow =
			__float_as_uint(ApproxRcp(ClampDenominatorFloat(r_Denominator[0], r_Epsilon)));
		r_InverseDenominatorHigh =
			__float_as_uint(ApproxRcp(ClampDenominatorFloat(r_Denominator[1], r_Epsilon)));
	}

	// Apply row normalization in FP32, round each column pair once to packed
	// Half, then publish through the unchanged Half-to-E4M3 contract.
	#pragma unroll
	for (int r_QueryTile = 0; r_QueryTile < 4; ++r_QueryTile)
	{
		FWindowAccumulatorTile<32> r_NormalizedOutput;
		#pragma unroll
		for (int r_Half = 0; r_Half < 2; ++r_Half)
		{
			const int QueryRow = r_QueryTile * 16 + TileCoordinates.Lane / 4 + r_Half * 8;
			const uint32_t r_LocalInverse =
				r_QueryTile < 2 ? r_InverseDenominatorLow : r_InverseDenominatorHigh;
			const float r_QueryNormalization = __uint_as_float(
				ShuffleIdx(r_LocalInverse, QueryRow % 32, 31, 0xffffffffu));
			#pragma unroll
			for (int r_ColumnTile = 0; r_ColumnTile < 4; ++r_ColumnTile)
				r_NormalizedOutput.r_Pair[r_ColumnTile][r_Half] = PackFloatColumnsHalf2(
					r_Output[r_QueryTile][r_ColumnTile][2 * r_Half] * r_QueryNormalization,
					r_Output[r_QueryTile][r_ColumnTile][2 * r_Half + 1] * r_QueryNormalization);
		}

		const int g_Group = TileCoordinates.g_QueryBlock256 * 16 + TileCoordinates.Warp * 4 + r_QueryTile;
		if (g_Group < TileCoordinates.g_Groups16)
			#pragma unroll
			for (int r_Chunk = 0; r_Chunk < Profile::QueryChunks; ++r_Chunk)
			{
				const auto r_OutputFragment = PublishWindowChunk<bFp8>(r_NormalizedOutput, r_Chunk);
				StoreNoAllocate(Parameters.g_Output + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
									TileCoordinates.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 +
									TileCoordinates.Lane * 16,
								make_uint4(r_OutputFragment.r_Word[0], r_OutputFragment.r_Word[1],
										   r_OutputFragment.r_Word[2], r_OutputFragment.r_Word[3]));
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
					TileCoordinates.g_QueryBlock256 * 16 + TileCoordinates.Warp * 4 + r_QueryTile;
				const int g_Row = g_Group * 16 + TileCoordinates.Lane / 4 + r_Half * 8;
				if (g_Row >= g_Tokens && g_Row < g_PaddedTokens)
					#pragma unroll
					for (int r_Chunk = 0; r_Chunk < Profile::QueryChunks; ++r_Chunk)
						#pragma unroll
						for (int r_ColumnTile = 0; r_ColumnTile < 2; ++r_ColumnTile)
							*reinterpret_cast<uint32_t*>(
								Parameters.g_Output + uint64_t(g_Group) * 16384 * Profile::ElementBytes +
								TileCoordinates.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 +
								TileCoordinates.Lane * 16 + (r_ColumnTile * 2 + r_Half) * 4) = 0;
			}
	}

	__syncthreads();
	if (Parameters.g_CompletionCounters && TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
		#pragma unroll
		for (int g_LocalGroup = 0; g_LocalGroup < 2; ++g_LocalGroup)
		{
			const int g_Group = TileCoordinates.g_QueryBlock256 * 2 + g_LocalGroup;
			if (g_Group < TileCoordinates.g_QueryBlocks128)
				CounterStoreRelease(
					Parameters.g_CompletionCounters + (g_Group * 32 + TileCoordinates.g_Head) * 4, 0);
		}
#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
