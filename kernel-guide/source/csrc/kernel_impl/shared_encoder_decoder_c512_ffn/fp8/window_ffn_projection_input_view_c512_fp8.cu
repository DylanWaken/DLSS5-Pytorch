// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "../../shared/common/kernel_helpers.cuh"
#include "../../shared_encoder_decoder_c512_attention_ffn_projection/common/spatial_projection.cuh"

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
	using Profile = FSpatialProjectionProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[StageCount * (4096 + 8)];
	const int g_Columns = (Parameters.Width + 7) / 8;
	const FSpatialProjectionTileCoordinates TileCoordinates{Parameters.Height / 4,
															Parameters.Width / 4,
															int(blockIdx.y) * 2,
															int(blockIdx.x) % g_Columns * 2,
															int(blockIdx.x) / g_Columns * 256 +
																(int(threadIdx.y) % 4) * 64,
															int(threadIdx.x),
															int(threadIdx.y)};

	// Initialize the shared copy barriers before any warp issues input transactions.
	if (TileCoordinates.Lane == 0 && TileCoordinates.Warp == 0)
	{
		#pragma unroll
		for (int s_Stage = 0; s_Stage < StageCount; ++s_Stage)
			BarrierInit(s_Storage, StageCount * 4096 + s_Stage * 8, blockDim.x * blockDim.y);
	}

	__syncthreads();

	uint4 r_Weights[2][4];

	// Reuse the native prefill/refill addressing without hiding the pipeline loop.
	const auto LoadWeights = [&](int ReductionTile)
	{
		const uint64_t g_ReductionBase = Parameters.g_PackedWeights +
										 uint64_t(blockIdx.z * 512 + ReductionTile * Profile::ReductionStep) *
											 512 * Profile::ElementBytes +
										 TileCoordinates.g_OutputChannel * 32 + TileCoordinates.Lane * 16;

		// The native matrix stores one warp's N16 fragment as a 512-byte vector stripe.
		// Both precisions consume two instruction-K subtiles, separated by16KiB.
		#pragma unroll
		for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				r_Weights[r_KSubtile][r_ChannelGroup] = __ldca(reinterpret_cast<const uint4*>(
					g_ReductionBase + r_KSubtile * 16384 + r_ChannelGroup * 512));
	};

	// Stage bounded input tiles with async copies; reuse the same addressing on refill.
	const auto IssueInput = [&](int ReductionTile)
	{
		const int s_StageOffset = (ReductionTile % StageCount) * 4096;
		const int s_BarrierOffset = StageCount * 4096 + (ReductionTile % StageCount) * 8;
		const int KSubtileIndex = TileCoordinates.Warp & 1;
		const int g_LocalX = (TileCoordinates.Warp >> 1) & 1;

		// Every stage transfers eight 512-byte stripes across four spatial tiles.
		// The three-stage ring overlaps input transfers with the register-resident GEMM.
		#pragma unroll
		for (int g_LocalY = TileCoordinates.Warp / 4; g_LocalY < TileCoordinates.Warp / 4 + SpatialTiles / 2;
			 ++g_LocalY)
		{
			int g_Y = TileCoordinates.g_TileY + g_LocalY;
			int g_X = TileCoordinates.g_TileX + g_LocalX;
			const bool bValid = ResolveSpatialProjectionInputTile(g_Y, g_X, TileCoordinates);
			const int s_CopyOffset = s_StageOffset + g_LocalY * 2048 + g_LocalX * 1024 + KSubtileIndex * 512;
			if (bValid)
			{
				const uint64_t g_Source = Parameters.g_Input +
										  uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X + blockIdx.z) *
											  Profile::SpatialTileBytes +
										  (ReductionTile * 2 + KSubtileIndex) * 512;
				if (IsCopyProducer(0xffffffffu))
				{
					CopyBulk(s_Storage, s_CopyOffset, g_Source, 512, s_BarrierOffset);
					BarrierExpect(s_Storage, s_BarrierOffset, 512);
				}
			}
			else
			{
				*reinterpret_cast<uint4*>(s_Storage + s_CopyOffset + TileCoordinates.Lane * 16) =
					make_uint4(0, 0, 0, 0);
			}
		}
	};

	// Wait for the selected shared-memory stage before its fragments are consumed.
	const auto WaitInput = [&](int ReductionTile)
	{
		const int s_BarrierOffset = StageCount * 4096 + (ReductionTile % StageCount) * 8;
		ArriveAndWait(s_Storage, s_BarrierOffset);
	};

	// Prime the weight registers and input pipeline before entering the reduction loop.
	LoadWeights(0);
	#pragma unroll
	for (int StageIndex = 0; StageIndex < StageCount; ++StageIndex)
		IssueInput(StageIndex);
	WaitInput(0);
	FSpatialProjectionAccumulator<SpatialTiles> r_Accumulator;

	// Seed the GEMM with the scaled residual in accumulator order.
	uint32_t r_ResidualScales[4][2];
	#pragma unroll
	for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
		#pragma unroll
		for (int r_N8 = 0; r_N8 < 2; ++r_N8)
			r_ResidualScales[r_ChannelGroup][r_N8] =
				*reinterpret_cast<const uint32_t*>(Parameters.g_PackedWeights + Profile::MatrixBytes +
												   (TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 +
													r_N8 * 8 + (TileCoordinates.Lane & 3) * 2) *
													   2);

	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		{
			#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY = (TileCoordinates.g_TileY + r_Spatial / 2) * 4 +
										 TileCoordinates.Lane / 16 + r_RowHalf * 2;
					const int g_PixelX =
						(TileCoordinates.g_TileX + r_Spatial % 2) * 4 + (TileCoordinates.Lane / 4) % 4;
					const bool bPixelValid = g_PixelY < TileCoordinates.g_TilesHigh * 4 &&
											 g_PixelX < TileCoordinates.g_TilesWide * 4;
					#pragma unroll
					for (int r_N8 = 0; r_N8 < 2; ++r_N8)
					{
						const int g_Panel =
							(TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 + r_N8 * 8) /
							(bFp8 ? 16 : 8);
						const uint64_t g_ResidualWordAddress = SpatialProjectionPlaneWordAddress<bFp8>(
							Parameters.g_Residual, g_Panel, g_PixelY, g_PixelX, TileCoordinates);
						uint32_t r_ResidualPair =
							bPixelValid ? __ldcg(reinterpret_cast<const uint32_t*>(g_ResidualWordAddress))
										: 0;
						r_ResidualPair = DecodeE4(uint16_t(r_ResidualPair >> (r_N8 * 16)));
						r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup][r_N8 * 2 + r_RowHalf] =
							HalfMul(r_ResidualPair, r_ResidualScales[r_ChannelGroup][r_N8]);
					}
				}
		}
	}

	// Keep K sequential to retain Half accumulation order and the native ring
	// lifecycle. Prefetch next weights before waiting, then recycle the old stage.
	#pragma unroll 1
	for (int ReductionTile = 0; ReductionTile < Profile::ReductionTiles; ++ReductionTile)
	{
		uint4 r_Input[SpatialTiles][2];
		#pragma unroll
		for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
			#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < 2; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] =
					*reinterpret_cast<const uint4*>(s_Storage + (ReductionTile % StageCount) * 4096 +
													(r_Spatial + TileCoordinates.Warp / 4 * 2) * 1024 +
													r_KSubtile * 512 + TileCoordinates.Lane * 16);
		AccumulateTile<Profile::Precision>(r_Accumulator, r_Input, r_Weights);
		if (ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights(ReductionTile + 1);
			WaitInput(ReductionTile + 1);
		}

		if (ReductionTile + StageCount < Profile::ReductionTiles)
			IssueInput(ReductionTile + StageCount);
	}

	// Write each projected tile in its selected physical output layout.
	#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		const int g_Y = TileCoordinates.g_TileY + TileCoordinates.Warp / 4 + r_Spatial / 2;
		const int g_X = TileCoordinates.g_TileX + r_Spatial % 2;
		if (g_Y >= TileCoordinates.g_TilesHigh || g_X >= TileCoordinates.g_TilesWide)
			continue;
		{
			const uint64_t g_OutputTileBase =
				Parameters.g_Output +
				uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
				TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes + TileCoordinates.Lane * 16;
			{
				#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const auto& r_LowerChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][2 * r_ChannelPair];
					const auto& r_UpperChannelWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][2 * r_ChannelPair + 1];
					const uint4 r_OutputVector =
						make_uint4(PackHalfPairsE4(r_LowerChannelWords[0], r_LowerChannelWords[2]),
								   PackHalfPairsE4(r_LowerChannelWords[1], r_LowerChannelWords[3]),
								   PackHalfPairsE4(r_UpperChannelWords[0], r_UpperChannelWords[2]),
								   PackHalfPairsE4(r_UpperChannelWords[1], r_UpperChannelWords[3]));
					StoreNoAllocate(g_OutputTileBase + r_ChannelPair * 512, r_OutputVector);
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
