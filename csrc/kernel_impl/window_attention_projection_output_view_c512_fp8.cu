// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "kernel_helpers.cuh"
#include "spatial_projection.cuh"

extern "C" __global__ __maxnreg__(128) void window_attention_projection_output_view_c512_fp8(
	FWindowAttentionProjectionOutputViewC512Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	const FSpatialProjectionArguments Arguments{Parameters.g_Input,		Parameters.g_Residual,
												Parameters.g_Output,	Parameters.g_PackedWeights,
												int(Parameters.Height), int(Parameters.Width)};

	constexpr bool bFp8 = true;
	constexpr int SpatialTiles = 4;
	constexpr bool bInputPlane = false;
	constexpr bool bOutputPlane = true;
	constexpr int StageCount = 3;
	constexpr bool bPool = false;
	using Profile = FSpatialProjectionProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[StageCount * (4096 + 8)];
	const int g_Columns = (Arguments.Width + 7) / 8;
	const FSpatialProjectionTileCoordinates TileCoordinates{Arguments.Height / 4,
															Arguments.Width / 4,
															int(blockIdx.y) * 2,
															int(blockIdx.x) % g_Columns * 2,
															int(blockIdx.x) / g_Columns * 256 +
																(int(threadIdx.y) % 4) * 64,
															int(threadIdx.x),
															int(threadIdx.y)};
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
		const uint64_t g_ReductionBase = Arguments.g_PackedWeights +
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
				const uint64_t g_Source = Arguments.g_Input +
										  uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X + blockIdx.z) *
											  Profile::SpatialTileBytes +
										  (ReductionTile * 2 + KSubtileIndex) * 512;
				if (Elected(0xffffffffu))
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
	const auto WaitInput = [&](int ReductionTile)
	{
		const int s_BarrierOffset = StageCount * 4096 + (ReductionTile % StageCount) * 8;
		ArriveAndWait(s_Storage, s_BarrierOffset);
	};

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
				*reinterpret_cast<const uint32_t*>(Arguments.g_PackedWeights + Profile::MatrixBytes +
												   (TileCoordinates.g_OutputChannel + r_ChannelGroup * 16 +
													r_N8 * 8 + (TileCoordinates.Lane & 3) * 2) *
													   2);

#pragma unroll
	for (int r_Spatial = 0; r_Spatial < SpatialTiles; ++r_Spatial)
	{
		{
			int g_Y = TileCoordinates.g_TileY + TileCoordinates.Warp / 4 + r_Spatial / 2;
			int g_X = TileCoordinates.g_TileX + r_Spatial % 2;
			const bool bValid = ResolveSpatialProjectionInputTile(g_Y, g_X, TileCoordinates);
			const uint64_t g_ResidualTileBase =
				Arguments.g_Residual +
				uint64_t(g_Y * TileCoordinates.g_TilesWide + g_X) * Profile::SpatialTileBytes +
				TileCoordinates.g_OutputChannel * 16 * Profile::ElementBytes + TileCoordinates.Lane * 16;
			{
#pragma unroll
				for (int r_ChannelPair = 0; r_ChannelPair < 2; ++r_ChannelPair)
				{
					const uint4 r_PackedResidual =
						bValid
							? __ldcg(reinterpret_cast<const uint4*>(g_ResidualTileBase + r_ChannelPair * 512))
							: make_uint4(0, 0, 0, 0);
					const uint32_t r_PackedResidualWords[4] = {r_PackedResidual.x, r_PackedResidual.y,
															   r_PackedResidual.z, r_PackedResidual.w};
#pragma unroll
					for (int r_GroupInPair = 0; r_GroupInPair < 2; ++r_GroupInPair)
					{
						const int r_ChannelGroup = r_ChannelPair * 2 + r_GroupInPair;
						auto& r_AccumulatorWords =
							r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
						// E4 storage interleaves the two N8 groups; restore MMA accumulator order.
						r_AccumulatorWords[0] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2])),
									r_ResidualScales[r_ChannelGroup][0]);
						r_AccumulatorWords[1] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2 + 1])),
									r_ResidualScales[r_ChannelGroup][0]);
						r_AccumulatorWords[2] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2] >> 16)),
									r_ResidualScales[r_ChannelGroup][1]);
						r_AccumulatorWords[3] =
							HalfMul(DecodeE4(uint16_t(r_PackedResidualWords[r_GroupInPair * 2 + 1] >> 16)),
									r_ResidualScales[r_ChannelGroup][1]);
					}
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
#pragma unroll
			for (int r_ChannelGroup = 0; r_ChannelGroup < 4; ++r_ChannelGroup)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int g_PixelY = g_Y * 4 + TileCoordinates.Lane / 16 + r_RowHalf * 2;
					const int g_PixelX = g_X * 4 + (TileCoordinates.Lane / 4) % 4;
					const auto& r_AccumulatorWords =
						r_Accumulator.r_AccumulatorWords[r_Spatial][r_ChannelGroup];
#pragma unroll
					for (int r_PanelHalf = 0; r_PanelHalf < (bFp8 ? 1 : 2); ++r_PanelHalf)
					{
						const int g_Panel =
							(TileCoordinates.g_OutputChannel + r_ChannelGroup * 16) / (bFp8 ? 16 : 8) +
							r_PanelHalf;
						const uint32_t r_OutputWord = bFp8
														  ? PackHalfPairsE4(r_AccumulatorWords[r_RowHalf],
																			r_AccumulatorWords[2 + r_RowHalf])
														  : r_AccumulatorWords[r_PanelHalf * 2 + r_RowHalf];
						*reinterpret_cast<uint32_t*>(SpatialProjectionPlaneWordAddress<bFp8>(
							Arguments.g_Output, g_Panel, g_PixelY, g_PixelX, TileCoordinates)) = r_OutputWord;
					}
				}
		}
	}
	{
	}
#endif
}
