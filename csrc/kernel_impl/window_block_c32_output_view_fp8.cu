// Reconstructed native window_block_c32_output_view_fp8 schedule.
// The exported entry owns its storage, tensor stages and final publication.
#include "kernel_helpers.cuh"
#include "warp_window32.cuh"

extern "C" __global__
	__maxnreg__(168) void window_block_c32_output_view_fp8(FWindowBlockC32OutputViewFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = true;
	constexpr int Channels = 32;
	using FConfig = FWindow32Profile<bFp8>;
	const unsigned char* g_PackedWeights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights);
	FWindowActivationTile<bFp8> r_Input[4];
	FWindowAccumulatorTile<32> r_Ffn[4];
	uint32_t r_FfnScale[4], r_AttentionScale[4];
#pragma unroll
	for (int r_Column = 0; r_Column < 4; ++r_Column)
	{
		const int g_ChannelByte = 16 * r_Column + 4 * (threadIdx.x & 3);
		r_FfnScale[r_Column] =
			*reinterpret_cast<const uint32_t*>(g_PackedWeights + FConfig::FfnScaleOffset + g_ChannelByte);
		r_AttentionScale[r_Column] = *reinterpret_cast<const uint32_t*>(
			g_PackedWeights + FConfig::AttentionScaleOffset + g_ChannelByte);
	}

// Coalesced physical-tile input. Singleton dimensions broadcast the one
// available tile for reads, as the native entry does; writes remain bounded.
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		{
			const unsigned char* g_Input = reinterpret_cast<const unsigned char*>(Parameters.g_Input);
			const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
			const int g_OriginTileX = (int(blockIdx.x) * 8 + Parameters.OriginX) / 4;
			const int g_OriginTileY = (int(blockIdx.y) * 8 + Parameters.OriginY) / 4;
			const int g_TileX = g_TileColumns == 1 ? 0 : g_OriginTileX + (r_Tile & 1);
			const int g_TileY = g_TileRows == 1 ? 0 : g_OriginTileY + (r_Tile >> 1);
			const bool bValid =
				g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows;
#pragma unroll
			for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
			{
				const int64_t g_Offset = int64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
										 r_Chunk * 512 + int(threadIdx.x) * 16;
				r_Input[r_Tile].r_Reduction[r_Chunk] =
					MakeWindowFragment(bValid ? __ldcg(reinterpret_cast<const uint4*>(g_Input + g_Offset))
											  : make_uint4(0, 0, 0, 0));
			}
		}
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				uint32_t r_ResidualPair;
				r_ResidualPair =
					DecodeE4(uint16_t(r_Input[r_Tile].r_Reduction[0].r_Word[2 * (r_Column / 2) + r_RowHalf] >>
									  (16 * (r_Column & 1))));
				r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf] = HalfMul(r_ResidualPair, r_FfnScale[r_Column]);
			}
	}

// Stream four 32-channel hidden panels through 32→128→32; the contraction
// seed is the scaled input, and its reduction chunks stay in native order.
#pragma unroll
	for (int HiddenPanel = 0; HiddenPanel < 4; ++HiddenPanel)
	{
		const FWindowWeightTile<bFp8> r_Expand =
			LoadWindowWeights<bFp8>(g_PackedWeights, 32 * HiddenPanel, 0, 128);
		const FWindowWeightTile<bFp8> r_Contract =
			LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::ContractOffset, 0, 32 * HiddenPanel, 32);
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			FWindowAccumulatorTile<32> r_HiddenTile{};
			LinearWindow32(r_Input[r_Tile], r_Expand, r_HiddenTile);
#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_HiddenTile.r_Pair[r_Column][r_RowHalf] =
						ActivateWindow(r_HiddenTile.r_Pair[r_Column][r_RowHalf]);
			LinearWindow32(PublishWindow32<bFp8>(r_HiddenTile), r_Contract, r_Ffn[r_Tile]);
		}
	}
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		r_Input[r_Tile] = PublishWindow32<bFp8>(r_Ffn[r_Tile]);

	FWindowActivationTile<bFp8> r_Query[4], r_Key[4];
	FWindowValueTile<bFp8> r_Value[4];
	const uint32_t r_HeadScale =
		FloatToHalf2(*reinterpret_cast<const uint32_t*>(g_PackedWeights + FConfig::HeadScaleOffset));
#pragma unroll
	for (int ProjectionComponent = 0; ProjectionComponent < 3; ++ProjectionComponent)
	{
		const FWindowWeightTile<bFp8> r_Weights =
			LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::QkvOffset, 32 * ProjectionComponent, 0, 96);
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			FWindowAccumulatorTile<32> r_Projected{};
			LinearWindow32(r_Input[r_Tile], r_Weights, r_Projected);
			if (ProjectionComponent < 2)
			{
				if (ProjectionComponent == 0)
					NormalizeWindow<true>(r_Projected, r_HeadScale);
				else
					NormalizeWindow<false>(r_Projected, CONST_HALF2_ONE);
				if (ProjectionComponent == 0)
					r_Query[r_Tile] = PublishWindow32<bFp8>(r_Projected);
				else
					r_Key[r_Tile] = PublishWindow32<bFp8>(r_Projected);
			}
			else
#pragma unroll
				for (int r_Column = 0; r_Column < 4; ++r_Column)
				{
					const uint32_t r_LowRows = TransposeM8n8(r_Projected.r_Pair[r_Column][0]);
					const uint32_t r_HighRows = TransposeM8n8(r_Projected.r_Pair[r_Column][1]);
					r_Value[r_Tile].r_Column[r_Column][0] = PackHalfPairsE4(r_LowRows, r_HighRows);
				}
		}
	}

	const FWindowWeightTile<bFp8> r_OutputWeights =
		LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::ProjectionOffset, 0, 0, 32);
	// FP8 follows the native two-query-tile softmax schedule. Keep the tested
	// FP16 schedule independent until its register pressure is measured.
	constexpr int CONST_QUERY_TILE_BATCH = bFp8 ? 2 : 1;
#pragma unroll
	for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += CONST_QUERY_TILE_BATCH)
	{
		FWindowAccumulatorTile<64> r_Probabilities[CONST_QUERY_TILE_BATCH];
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
			r_Probabilities[r_LocalTile] = QueryKeyScores<bFp8>(
				r_FirstTile + r_LocalTile, g_PackedWeights + FConfig::BiasOffset, r_Query, r_Key);
		SoftmaxWindowPair(r_Probabilities);

#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
		{
			const int r_Tile = r_FirstTile + r_LocalTile;
			const auto r_Attended = ProbabilityValues<bFp8>(r_Probabilities[r_LocalTile], r_Value);
#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf] =
						HalfMul(r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf], r_AttentionScale[r_Column]);
			LinearWindow32(PublishWindow32<bFp8>(r_Attended), r_OutputWeights, r_Ffn[r_Tile]);

			{
				// Publish final packed fragments directly to their physical output layout.
				constexpr int Chunks = FWindow32Profile<bFp8>::InputChunks;
				const int g_Height = Parameters.ViewHeight > 0 ? Parameters.ViewHeight : Parameters.Height;
				const int g_Width = Parameters.ViewWidth > 0 ? Parameters.ViewWidth : Parameters.Width;
				const int g_OriginX = int(blockIdx.x) * 8 + Parameters.OriginX + ((r_Tile) & 1) * 4;
				const int g_OriginY = int(blockIdx.y) * 8 + Parameters.OriginY + ((r_Tile) >> 1) * 4;
#pragma unroll
				for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
				{
					const auto r_Fragment = PublishWindowChunk<bFp8>(r_Ffn[r_Tile], r_Chunk);
#pragma unroll
					for (int r_Word = 0; r_Word < 4; ++r_Word)
					{
						const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
						const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
						if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
						{
							const int g_Plane = (0) * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
							const uint64_t g_OutputWordAddress =
								Parameters.g_Output +
								((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
								4 * (threadIdx.x & 3);
							*reinterpret_cast<uint32_t*>(g_OutputWordAddress) = r_Fragment.r_Word[r_Word];
						}
					}
				}
			}
		}
	}
#endif
}
