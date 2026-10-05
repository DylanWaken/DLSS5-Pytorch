// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "kernel_helpers.cuh"
#include "decoder.cuh"

extern "C" __global__ __maxnreg__(168) void decoder_upsample_c1024_to_c512_fp16(
	FDecoderUpsampleC1024ToC512Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = false;
	using Profile = FDecoderProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[2064];
	const uint64_t g_Input = Parameters.g_Input;
	const uint64_t g_PackedWeights = Parameters.g_PackedWeights;
	const uint64_t g_Residual = Parameters.g_Residual;
	const uint64_t g_Output = Parameters.g_Output;
	const int g_Columns = (Parameters.InputWidth + 3) / 4;
	const FDecoderCoordinates TileCoordinates{Parameters.InputHeight / 4,
											  Parameters.InputWidth / 4,
											  Parameters.OutputHeight / 4,
											  Parameters.OutputWidth / 4,
											  int(blockIdx.y),
											  int(blockIdx.x) % g_Columns,
											  (int(blockIdx.x) / g_Columns) * 256 + int(threadIdx.y) * 128,
											  g_Columns,
											  int(blockIdx.z),
											  int(threadIdx.x),
											  int(threadIdx.y)};
	const uint64_t g_SplitAccumulator = Parameters.g_SplitAccumulator;
	const uint64_t g_SplitCounters =
		Parameters.g_CompletionCounters + (TileCoordinates.g_TileY * 2 * g_Columns + blockIdx.x) * 4;
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
	{
		BarrierInit(s_Storage, 2048, 64);
		BarrierInit(s_Storage, 2056, 64);
	}
	__syncthreads();
	FDecoderAccumulator r_Accumulator{};
	// Keep the double-buffered async input pipeline and weight loads next to the MMA loop.
	uint4 r_Weights[2][8];
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_WeightTileBase =
			g_PackedWeights +
			uint64_t(TileCoordinates.Split * 256 + ReductionTile * Profile::ReductionStep) * 512 *
				Profile::ElementBytes +
			TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
#pragma unroll
			for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
				r_Weights[r_KSubtile][r_NTile] = __ldca(
					reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 16384 + r_NTile * 512));
	};
	const auto IssueStage = [&](int ReductionTile)
	{
		const int g_Y = TileCoordinates.g_LowTilesHigh == 1 ? 0 : TileCoordinates.g_TileY;
		const int g_X = TileCoordinates.g_LowTilesWide == 1 ? 0 : TileCoordinates.g_TileX;
		const int s_Destination = (ReductionTile % 2) * 1024 + TileCoordinates.Warp * 512;
		const int s_Barrier = 2048 + (ReductionTile % 2) * 8;
		if (g_Y < TileCoordinates.g_LowTilesHigh && g_X < TileCoordinates.g_LowTilesWide)
		{
			const uint64_t g_Source =
				g_Input +
				uint64_t(g_Y * TileCoordinates.g_LowTilesWide + g_X) * 16384 * Profile::ElementBytes +
				TileCoordinates.Split * 4096 * Profile::ElementBytes +
				(ReductionTile * 2 + TileCoordinates.Warp) * 512;
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_Destination, g_Source, 512, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_Destination + TileCoordinates.Lane * 16) =
				make_uint4(0, 0, 0, 0);
	};
	LoadWeights(0);
	IssueStage(0);
	ArriveAndWait(s_Storage, 2048);
#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::ReductionTiles; ++ReductionTile)
	{
		if (ReductionTile + 1 < Profile::ReductionTiles)
			IssueStage(ReductionTile + 1);
		uint4 r_Input[1][2];
#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			r_Input[0][r_KSubtile] = *reinterpret_cast<const uint4*>(
				s_Storage + (ReductionTile % 2) * 1024 + r_KSubtile * 512 + TileCoordinates.Lane * 16);
		AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights(ReductionTile + 1);
			ArriveAndWait(s_Storage, 2048 + ((ReductionTile + 1) % 2) * 8);
		}
	}
	if (TileCoordinates.Split > 0)
	{
		if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_SplitCounters)) < TileCoordinates.Split - 1)
				PollSleep(64);
		__syncthreads();
	}
	// Split 0 stores Half scratch; splits 1/2 reduce, and split 3 loads without overwriting scratch.
	if (TileCoordinates.Split < 3)
	{
		if (TileCoordinates.g_TileY < TileCoordinates.g_LowTilesHigh &&
			TileCoordinates.g_TileX < TileCoordinates.g_LowTilesWide)
		{
			const uint64_t g_SplitAccumulatorTile =
				g_SplitAccumulator +
				uint64_t(TileCoordinates.g_TileY * TileCoordinates.g_LowTilesWide + TileCoordinates.g_TileX) *
					16384 +
				TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;
#pragma unroll
			for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			{
				const auto& r_OutputWords = r_Accumulator.r_AccumulatorWords[0][r_NTile];
				const uint4 r_SplitAccumulatorVector =
					make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
				if (TileCoordinates.Split == 0)
					StoreNoAllocate(g_SplitAccumulatorTile + r_NTile * 512, r_SplitAccumulatorVector);
				else
					ReduceHalf4(g_SplitAccumulatorTile + r_NTile * 512, r_SplitAccumulatorVector);
			}
		}
	}
	else
	{
		const int g_Y = TileCoordinates.g_LowTilesHigh == 1 ? 0 : TileCoordinates.g_TileY;
		const int g_X = TileCoordinates.g_LowTilesWide == 1 ? 0 : TileCoordinates.g_TileX;
		const bool bValid = g_Y < TileCoordinates.g_LowTilesHigh && g_X < TileCoordinates.g_LowTilesWide;
		const uint64_t g_SplitAccumulatorTile =
			g_SplitAccumulator + uint64_t(g_Y * TileCoordinates.g_LowTilesWide + g_X) * 16384 +
			TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
		{
			const uint4 r_PreviousSplitWords =
				bValid ? __ldca(reinterpret_cast<const uint4*>(g_SplitAccumulatorTile + r_NTile * 512))
					   : make_uint4(0, 0, 0, 0);
			auto& r_OutputWords = r_Accumulator.r_AccumulatorWords[0][r_NTile];
			r_OutputWords[0] = HalfAdd(r_PreviousSplitWords.x, r_OutputWords[0]);
			r_OutputWords[1] = HalfAdd(r_PreviousSplitWords.y, r_OutputWords[1]);
			r_OutputWords[2] = HalfAdd(r_PreviousSplitWords.z, r_OutputWords[2]);
			r_OutputWords[3] = HalfAdd(r_PreviousSplitWords.w, r_OutputWords[3]);
		}
	}
	// Only the final split expands low pixels, adds the scaled residual, and publishes.
	if (TileCoordinates.Split == 3)
	{
		uint32_t r_ResidualScales[8][2];
#pragma unroll
		for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
#pragma unroll
			for (int r_N8 = 0; r_N8 < 2; ++r_N8)
				r_ResidualScales[r_NTile][r_N8] =
					*reinterpret_cast<const uint32_t*>(g_PackedWeights + Profile::MatrixBytes +
													   (TileCoordinates.g_OutputChannel + r_NTile * 16 +
														r_N8 * 8 + (TileCoordinates.Lane & 3) * 2) *
														   2);

		// A low 4x4 tile expands into four high 4x4 tiles. Indexed lane shuffles
		// duplicate each low pixel in X/Y while preserving packed channel ownership.
#pragma unroll
		for (int QuadrantIndex = 0; QuadrantIndex < 4; ++QuadrantIndex)
		{
			const int g_OffsetY = QuadrantIndex / 2, g_OffsetX = QuadrantIndex % 2;
			const int g_OutputY = TileCoordinates.g_TileY * 2 + g_OffsetY,
					  g_OutputX = TileCoordinates.g_TileX * 2 + g_OffsetX;
			const int g_SkipY = TileCoordinates.g_HighTilesHigh == 1 ? 0 : g_OutputY;
			const int g_SkipX = TileCoordinates.g_HighTilesWide == 1 ? 0 : g_OutputX;
			const bool bValidSkip =
				g_SkipY < TileCoordinates.g_HighTilesHigh && g_SkipX < TileCoordinates.g_HighTilesWide;
			const uint64_t g_SkipBase =
				g_Residual +
				uint64_t(g_SkipY * TileCoordinates.g_HighTilesWide + g_SkipX) * 8192 * Profile::ElementBytes +
				TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes + TileCoordinates.Lane * 16;
			uint32_t r_Output[8][4];
#pragma unroll
			for (int r_NTile = 0; r_NTile < 8; ++r_NTile)
			{
				uint32_t r_ResidualPairs[4];
				{
					const uint4 r_PackedResidual =
						bValidSkip ? __ldca(reinterpret_cast<const uint4*>(g_SkipBase + r_NTile * 512))
								   : make_uint4(0, 0, 0, 0);
					r_ResidualPairs[0] = r_PackedResidual.x;
					r_ResidualPairs[1] = r_PackedResidual.y;
					r_ResidualPairs[2] = r_PackedResidual.z;
					r_ResidualPairs[3] = r_PackedResidual.w;
				}
#pragma unroll
				for (int r_N8 = 0; r_N8 < 2; ++r_N8)
#pragma unroll
					for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					{
						const int r_SourceLane = (TileCoordinates.Lane & 3) |
												 ((TileCoordinates.Lane >> 1) & 4) | (g_OffsetX * 8) |
												 (r_RowHalf * 16);
						const uint32_t r_Nearest =
							ShuffleIdx(r_Accumulator.r_AccumulatorWords[0][r_NTile][r_N8 * 2 + g_OffsetY],
									   r_SourceLane, 31, 0xffffffffu);
						r_Output[r_NTile][r_N8 * 2 + r_RowHalf] =
							HalfAdd(r_Nearest, HalfMul(r_ResidualPairs[r_N8 * 2 + r_RowHalf],
													   r_ResidualScales[r_NTile][r_N8]));
					}
			}
			if (g_OutputY >= TileCoordinates.g_HighTilesHigh || g_OutputX >= TileCoordinates.g_HighTilesWide)
				continue;
			const uint64_t g_OutputBase = g_Output +
										  uint64_t(g_OutputY * TileCoordinates.g_HighTilesWide + g_OutputX) *
											  8192 * Profile::ElementBytes +
										  TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes +
										  TileCoordinates.Lane * 16;
#pragma unroll
			for (int r_Panel = 0; r_Panel < (bFp8 ? 4 : 8); ++r_Panel)
			{
				uint4 r_Published;
				{
					const auto& r_OutputWords = r_Output[r_Panel];
					r_Published =
						make_uint4(r_OutputWords[0], r_OutputWords[1], r_OutputWords[2], r_OutputWords[3]);
				}
				StoreNoAllocate(g_OutputBase + r_Panel * 512, r_Published);
			}
		}
	}
	__syncthreads();
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
		CounterStoreRelease(g_SplitCounters, TileCoordinates.Split);
#endif
}
