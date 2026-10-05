// Reconstructed native window_block_c256_upsample_fp16 schedule.
// The exported entry owns its storage, tensor stages and final publication.
#include "../common/kernel_helpers.cuh"
#include "../common/window_upsample.cuh"

extern "C" __global__
	__maxnreg__(192) void window_block_c256_upsample_fp16(FWindowBlockC256UpsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = false;
	constexpr int Channels = 256;
	FWindowUpsampleArguments Arguments{Parameters.g_Input,
									   Parameters.g_Output,
									   Parameters.g_PackedWeights,
									   0,
									   Parameters.Height,
									   Parameters.Width,
									   Parameters.OriginX,
									   Parameters.OriginY,
									   Parameters.Height,
									   Parameters.Width,
									   nullptr,
									   nullptr};
	Arguments.g_Residual = Parameters.g_Residual;
	FWindowAccumulatorTile<32> r_Merged[4];
	using FConfig = FWindowUpsampleProfile<Channels, bFp8>;
	const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Arguments.g_PackedWeights);
	FWindowAccumulatorTile<32> r_LowProjection{};
	#pragma unroll 1
	for (int PanelIndex = 0; PanelIndex < 2 * FConfig::Heads; ++PanelIndex)
	{
		const auto r_Weights = LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::UpProjectionOffset,
													   32 * threadIdx.y, 32 * PanelIndex, Channels);

		// Decoder input is the encoder's channel-plane publication. Read one 4x4
		// low-resolution region; upsampling its projection yields the 8x8 window.
		const int g_Height = Channels == 32 ? Arguments.Height / 2 : ((Arguments.Height + 1) / 2 + 3) & ~3;
		const int g_Width = Channels == 32 ? Arguments.Width / 2 : ((Arguments.Width + 1) / 2 + 3) & ~3;
		const int g_OriginX = (int(blockIdx.x) * 8 + Arguments.OriginX) / 2;
		const int g_OriginY = (int(blockIdx.y) * 8 + Arguments.OriginY) / 2;
		FWindowActivationTile<bFp8> r_LowResolutionInput;
		#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
			#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
			{
				const int g_X = g_Width == 1 ? 0 : g_OriginX + ((threadIdx.x / 4) & 3);
				const int g_Y = g_Height == 1 ? 0 : g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
				const int g_Plane =
					PanelIndex * 2 * FWindow32Profile<bFp8>::InputChunks + 2 * r_Chunk + r_Word / 2;
				const uint64_t g_InputWordAddress =
					Arguments.g_Input + ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
					4 * (threadIdx.x & 3);
				r_LowResolutionInput.r_Reduction[r_Chunk].r_Word[r_Word] =
					g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height
						? *reinterpret_cast<const uint32_t*>(g_InputWordAddress)
						: 0u;
			}

		LinearWindow32(r_LowResolutionInput, r_Weights, r_LowProjection);
	}

	#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		const int g_Columns = Arguments.ResidualWidth / 4, g_Rows = Arguments.ResidualHeight / 4;
		const int g_X = g_Columns == 1 ? 0 : (int(blockIdx.x) * 8 + Arguments.OriginX) / 4 + (r_Tile & 1);
		const int g_Y = g_Rows == 1 ? 0 : (int(blockIdx.y) * 8 + Arguments.OriginY) / 4 + (r_Tile >> 1);
		const bool bValid = g_X >= 0 && g_X < g_Columns && g_Y >= 0 && g_Y < g_Rows;
		FWindowActivationTile<bFp8> r_ResidualInput;
		#pragma unroll
		for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
		{
			const uint64_t g_ResidualFragmentAddress =
				Arguments.g_Residual + uint64_t(g_Y * g_Columns + g_X) * Channels * 16 * (bFp8 ? 1 : 2) +
				threadIdx.y * FWindow32Profile<bFp8>::TileBytes + r_Chunk * 512 + threadIdx.x * 16;
			r_ResidualInput.r_Reduction[r_Chunk] =
				MakeWindowFragment(bValid ? __ldcg(reinterpret_cast<const uint4*>(g_ResidualFragmentAddress))
										  : make_uint4(0, 0, 0, 0));
		}

		r_Merged[r_Tile] = ScaledWindowResidual(
			r_ResidualInput, g_PackedWeights + FConfig::TransitionScaleOffset, 32 * threadIdx.y);
		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
			#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				// Each low-resolution value repeats to a 2x2 high-resolution cell.
				// TileY chooses its MMA row half; TileX chooses two low columns.
				const int r_SourceLane =
					(threadIdx.x & 3) | ((threadIdx.x >> 1) & 4) | 8 * (r_Tile & 1) | 16 * r_RowHalf;
				const uint32_t r_Repeated =
					ShuffleIdx(r_LowProjection.r_Pair[r_Column][r_Tile >> 1], r_SourceLane, 31, 0xffffffffu);
				const int g_X =
					int(blockIdx.x) * 8 + Arguments.OriginX + 4 * (r_Tile & 1) + ((threadIdx.x / 4) & 3);
				const int g_Y = int(blockIdx.y) * 8 + Arguments.OriginY + 4 * (r_Tile >> 1) +
								threadIdx.x / 16 + 2 * r_RowHalf;

				// Native merge rounds the skip multiplication before adding the
				// projection, then clears spatial padding before the FFN consumes it.
				const uint32_t r_Sum = HalfAdd(r_Repeated, r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf]);
				r_Merged[r_Tile].r_Pair[r_Column][r_RowHalf] =
					g_X >= 0 && g_X < Arguments.Width && g_Y >= 0 && g_Y < Arguments.Height ? r_Sum : 0u;
			}
	}

	{
		// Publish the merged input once; the block reuses this slab for FFN/attention.
		__shared__ FSharedWindow<Channels, bFp8> s_Window;
		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, threadIdx.y, PublishWindow32<bFp8>(r_Merged[r_Tile]));
		__syncthreads();
		Arguments.s_Window = &s_Window;
		{
			// Consume the merged skip/projection with the complete window schedule.
			using FConfig = FWindowUpsampleProfile<Channels, bFp8>;
			const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Arguments.g_PackedWeights);

			// FFN: private C64 tiles, or cross-warp expert panels for C128/C256.
			const int Warp = threadIdx.y;
			{
				#pragma unroll
				for (int TileIndex = 0; TileIndex < 4; ++TileIndex)
					s_Window.Store(TileIndex, Warp, s_Window.Load(TileIndex, Warp));
				__syncthreads();
				FWindowAccumulatorTile<32> r_Contracted[4]{};
				ComputeWindowExpert<Channels, bFp8>(s_Window, g_PackedWeights, Warp, r_Contracted);
				FWindowAccumulatorTile<32> r_Output[4];
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
					r_Output[r_Tile] = ScaledWindowResidual(
						s_Window.Load(r_Tile, Warp), g_PackedWeights + FConfig::FfnScaleOffset, 32 * Warp);

				// All experts must finish reading X before their published outputs reuse
				// the same slab. This is a tensor lifetime barrier, not a warp shuffle.
				__syncthreads();
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
					s_Window.Store(r_Tile, Warp, PublishWindow32<bFp8>(r_Contracted[r_Tile]));
				__syncthreads();
				#pragma unroll 1
				for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
				{
					const auto r_Weights = LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::MixOffset,
																   32 * Warp, 32 * PanelIndex, Channels);
					#pragma unroll
					for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
						LinearWindow32(s_Window.Load(r_Tile, PanelIndex), r_Weights, r_Output[r_Tile]);
				}
				__syncthreads();
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
					s_Window.Store(r_Tile, Warp, PublishWindow32<bFp8>(r_Output[r_Tile]));
				__syncthreads();
			}

			// Project the FFN output into Q/K/V fragments and normalize the query/key rows.
			FWindowActivationTile<bFp8> r_Query[4], r_Key[4];
			FWindowValueTile<bFp8> r_Value[4];

			// Q/K/V projection and normalization keep the native shared-panel ownership.
			FWindowAccumulatorTile<32> r_Projected[3][4]{};
			#pragma unroll 1
			for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
				#pragma unroll
				for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
				{
					// The record interleaves Q/K/V within each head: [Head][Q,K,V][32].
					const auto r_Weights = LoadWindowWeights<bFp8>(
						g_PackedWeights + FConfig::QkvOffset, 96 * int(threadIdx.y) + 32 * r_QkvComponent,
						32 * PanelIndex, 3 * Channels);
					#pragma unroll
					for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
						LinearWindow32(s_Window.Load(r_Tile, PanelIndex), r_Weights,
									   r_Projected[r_QkvComponent][r_Tile]);
				}
			const uint32_t r_HeadScale = FloatToHalf2(*reinterpret_cast<const uint32_t*>(
				g_PackedWeights + FConfig::HeadScaleOffset + 4 * threadIdx.y));
			#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			{
				NormalizeWindow<true>(r_Projected[0][r_Tile], r_HeadScale);
				NormalizeWindow<false>(r_Projected[1][r_Tile], CONST_HALF2_ONE);
				r_Query[r_Tile] = PublishWindow32<bFp8>(r_Projected[0][r_Tile]);
				r_Key[r_Tile] = PublishWindow32<bFp8>(r_Projected[1][r_Tile]);
				#pragma unroll
				for (int r_Column = 0; r_Column < 4; ++r_Column)
				{
					// Transpose Half accumulators before E4 publication, exactly as the
					// DLL does, to obtain B fragments for probability times value.
					const uint32_t r_LowerValueRows =
						TransposeM8n8(r_Projected[2][r_Tile].r_Pair[r_Column][0]);
					const uint32_t r_UpperValueRows =
						TransposeM8n8(r_Projected[2][r_Tile].r_Pair[r_Column][1]);
					{
						r_Value[r_Tile].r_Column[r_Column][0] = r_LowerValueRows;
						r_Value[r_Tile].r_Column[r_Column][1] = r_UpperValueRows;
					}
				}
			}
			__syncthreads();

			// Evaluate attention in tile batches, then project each head back into the residual stream.
			#pragma unroll
			for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += FConfig::AttentionBatch)
			{
				FWindowActivationTile<bFp8> r_Attended[FConfig::AttentionBatch];
				FWindowAccumulatorTile<32> r_Output[FConfig::AttentionBatch];
				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
				{
					const int r_Tile = r_FirstTile + r_LocalTile;
					r_Attended[r_LocalTile] = AttendWithBias<bFp8>(
						r_Tile, g_PackedWeights + FConfig::BiasOffset + 8192 * threadIdx.y, r_Query, r_Key,
						r_Value);
					r_Output[r_LocalTile] = ScaledWindowResidual(
						s_Window.Load(r_Tile, threadIdx.y), g_PackedWeights + FConfig::AttentionScaleOffset,
						32 * threadIdx.y);
				}

				// Each warp has consumed its own published FFN residual; attention
				// output now occupies the same head panel for the cross-head projection.
				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
					s_Window.Store(r_FirstTile + r_LocalTile, threadIdx.y, r_Attended[r_LocalTile]);
				__syncthreads();
				#pragma unroll 1
				for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
				{
					const auto r_Weights =
						LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::ProjectionOffset, 32 * threadIdx.y,
												32 * PanelIndex, Channels);
					#pragma unroll
					for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
						LinearWindow32(s_Window.Load(r_FirstTile + r_LocalTile, PanelIndex), r_Weights,
									   r_Output[r_LocalTile]);
				}
				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
				{

					{
						// Publish final packed fragments directly to their physical output layout.
						using FConfig = FWideWindowProfile<Channels, bFp8>;
						const int g_TileColumns = Arguments.Width / 4, g_TileRows = Arguments.Height / 4;
						const int g_TileX =
							(int(blockIdx.x) * 8 + Arguments.OriginX) / 4 + ((r_FirstTile + r_LocalTile) & 1);
						const int g_TileY = (int(blockIdx.y) * 8 + Arguments.OriginY) / 4 +
											((r_FirstTile + r_LocalTile) >> 1);
						if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
							#pragma unroll
							for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
							{
								const auto r_Published =
									PublishWindowChunk<bFp8>(r_Output[r_LocalTile], r_Chunk);
								const uint64_t g_OutputFragmentAddress =
									Arguments.g_Output +
									uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
									threadIdx.y * FConfig::PanelBytes + r_Chunk * 512 + threadIdx.x * 16;
								StoreNoAllocate(g_OutputFragmentAddress,
												make_uint4(r_Published.r_Word[0], r_Published.r_Word[1],
														   r_Published.r_Word[2], r_Published.r_Word[3]));
							}
					}
				}
				__syncthreads();
			}
		}
	}
#endif
}
