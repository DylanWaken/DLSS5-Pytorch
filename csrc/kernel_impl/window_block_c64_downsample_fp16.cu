// Reconstructed native window_block_c64_downsample_fp16 schedule.
// The exported entry owns its storage, tensor stages and final publication.
#include "kernel_helpers.cuh"
#include "window_downsample.cuh"

extern "C" __global__
	__maxnreg__(168) void window_block_c64_downsample_fp16(FWindowBlockC64DownsampleFp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = false;
	constexpr int Channels = 64;
	const FWindowDownsampleArguments Arguments{Parameters.g_Input,
											   Parameters.g_Output,
											   Parameters.g_PackedWeights,
											   Parameters.g_DownsampledOutput,
											   Parameters.Height,
											   Parameters.Width,
											   Parameters.OriginX,
											   Parameters.OriginY,
											   Parameters.DownsampledHeight,
											   Parameters.DownsampledWidth};
	FWindowAccumulatorTile<32> r_WindowOutput[4];
	{
		// The block output and downsample projection reuse the same shared slab.
		__shared__ FSharedWindow<Channels, bFp8> s_Window;
		{
			// Window FFN, attention and residual projection; retain raw Half tiles for pooling.
			using FConfig = FWideWindowProfile<Channels, bFp8>;
			const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Arguments.g_PackedWeights);

			// FFN: private C64 tiles, or cross-warp expert panels for C128/C256.
			const int Warp = threadIdx.y;
			{
				// C64 uses token parallelism in the FFN: one warp owns left/right tiles
				// in one window row, keeping both input channel panels in registers.
				FRegisterWindow<bFp8, 2, 2> r_Input;
				FWindowAccumulatorTile<32> r_Output[2][2];
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
					#pragma unroll
					for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
					{
						{
							// Read the physical input tile without a separate layout staging pass.
							using FConfig = FWideWindowProfile<Channels, bFp8>;
							const int g_TileColumns = Arguments.Width / 4, g_TileRows = Arguments.Height / 4;
							const int g_TileX = g_TileColumns == 1
													? 0
													: (int(blockIdx.x) * 8 + Arguments.OriginX) / 4 +
														  ((2 * Warp + r_Tile) & 1);
							const int g_TileY = g_TileRows == 1
													? 0
													: (int(blockIdx.y) * 8 + Arguments.OriginY) / 4 +
														  ((2 * Warp + r_Tile) >> 1);
							const bool bValid = g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 &&
												g_TileY < g_TileRows;
							FWindowActivationTile<bFp8> r_InputTile;
							#pragma unroll
							for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
							{
								const uint64_t g_InputFragmentAddress =
									Arguments.g_Input +
									uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
									(r_Panel)*FConfig::PanelBytes + r_Chunk * 512 + int(threadIdx.x) * 16;
								r_InputTile.r_Reduction[r_Chunk] = MakeWindowFragment(
									bValid ? __ldcg(reinterpret_cast<const uint4*>(g_InputFragmentAddress))
										   : make_uint4(0, 0, 0, 0));
							}
							r_Input.r_Tile[r_Tile][r_Panel] = r_InputTile;
						}
						r_Output[r_Tile][r_Panel] =
							ScaledWindowResidual(r_Input.r_Tile[r_Tile][r_Panel],
												 g_PackedWeights + FConfig::FfnScaleOffset, 32 * r_Panel);
					}

				// Accumulate the two expert contributions into the scaled FFN residual.
				#pragma unroll 1
				for (int ExpertIndex = 0; ExpertIndex < 2; ++ExpertIndex)
				{
					FWindowAccumulatorTile<32> r_Contracted[2]{};
					ComputeWindowExpert<Channels, bFp8>(r_Input, g_PackedWeights, ExpertIndex, r_Contracted);
					#pragma unroll
					for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
					{
						const auto r_Weights = LoadWindowWeights<bFp8>(
							g_PackedWeights + FConfig::MixOffset, r_Panel * 32, ExpertIndex * 32, Channels);
						#pragma unroll
						for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
							LinearWindow32(PublishWindow32<bFp8>(r_Contracted[r_Tile]), r_Weights,
										   r_Output[r_Tile][r_Panel]);
					}
				}
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
					#pragma unroll
					for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
						s_Window.Store(2 * Warp + r_Tile, r_Panel,
									   PublishWindow32<bFp8>(r_Output[r_Tile][r_Panel]));
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
					r_WindowOutput[r_FirstTile + r_LocalTile] = r_Output[r_LocalTile];
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

		const auto r_Pooled = PublishWindow32<bFp8>(PoolWindow(r_WindowOutput));
		using FConfig = FWideWindowProfile<Channels, bFp8>;
		s_Window.Store(0, threadIdx.y, r_Pooled);
		__syncthreads();
		const auto* g_Weights = reinterpret_cast<const unsigned char*>(Arguments.g_PackedWeights) +
								FConfig::AttentionScaleOffset + 2 * Channels;
		#pragma unroll 1
		for (int OutputHalf = 0; OutputHalf < 2; ++OutputHalf)
		{
			FWindowAccumulatorTile<32> r_Output{};
			#pragma unroll
			for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
			{
				const auto r_Weights = LoadWindowWeights<bFp8>(
					g_Weights, 32 * threadIdx.y + OutputHalf * Channels, 32 * PanelIndex, 2 * Channels);
				LinearWindow32(s_Window.Load(0, PanelIndex), r_Weights, r_Output);
			}
			{
				// Publish the projected pooled tile and its local padding.
				// C32 writes compact half extents. Wider native entries align those extents
				// to four. The separate clear operation uses the auxiliary target extents.
				const int g_ValidHeight = (Arguments.Height + 1) / 2;
				const int g_ValidWidth = (Arguments.Width + 1) / 2;
				const int g_Height = Channels == 32 ? Arguments.Height / 2 : (g_ValidHeight + 3) & ~3;
				const int g_Width = Channels == 32 ? Arguments.Width / 2 : (g_ValidWidth + 3) & ~3;
				const int g_OriginX = (int(blockIdx.x) * 8 + Arguments.OriginX) / 2;
				const int g_OriginY = (int(blockIdx.y) * 8 + Arguments.OriginY) / 2;
				#pragma unroll
				for (int r_Chunk = 0; r_Chunk < FWindow32Profile<bFp8>::InputChunks; ++r_Chunk)
				{
					const auto r_Fragment = PublishWindowChunk<bFp8>(r_Output, r_Chunk);
					#pragma unroll
					for (int r_Word = 0; r_Word < 4; ++r_Word)
					{
						const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
						const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
						if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
						{
							const int g_Plane = (threadIdx.y + OutputHalf * FConfig::Heads) * 2 *
													FWindow32Profile<bFp8>::InputChunks +
												2 * r_Chunk + r_Word / 2;
							const uint64_t g_OutputWordAddress =
								Arguments.g_DownsampledOutput +
								((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
								4 * (threadIdx.x & 3);

							// The native padding clear follows these projection stores. Emit
							// its zero immediately for our own padded cells to avoid a race.
							*reinterpret_cast<uint32_t*>(g_OutputWordAddress) =
								g_X < g_ValidWidth && g_Y < g_ValidHeight ? r_Fragment.r_Word[r_Word] : 0u;
						}
					}
				}
			}
		}

		__syncthreads();
		{
			// Clear the caller-provided padded border after final publication.
			const int g_ValidHeight = (Arguments.Height + 1) / 2;
			const int g_ValidWidth = (Arguments.Width + 1) / 2;
			if (Arguments.g_DownsampledOutput == 0 ||
				(Arguments.DownsampledHeight <= g_ValidHeight && Arguments.DownsampledWidth <= g_ValidWidth))
				return;
			const int g_OriginX = (int(blockIdx.x) * 8 + Arguments.OriginX) / 2;
			const int g_OriginY = (int(blockIdx.y) * 8 + Arguments.OriginY) / 2;
			const int ThreadIndex = threadIdx.y * 32 + threadIdx.x;

			// The native clear footprint is a Half-sized C→2C allocation even for
			// FP8. Preserve that documented workspace contract, but only clear padding.
			for (int g_Index = ThreadIndex; g_Index < 16 * (Channels / 4); g_Index += Channels)
			{
				const int g_Plane = g_Index % (Channels / 4);
				const int g_X = g_OriginX + (g_Index / (Channels / 4)) % 4;
				const int g_Y = g_OriginY + g_Index / (4 * (Channels / 4));
				if (g_X >= 0 && g_X < Arguments.DownsampledWidth && g_Y >= 0 &&
					g_Y < Arguments.DownsampledHeight && (g_X >= g_ValidWidth || g_Y >= g_ValidHeight))
				{
					const uint64_t g_PaddingVectorAddress =
						Arguments.g_DownsampledOutput +
						((uint64_t(g_Plane * Arguments.DownsampledHeight + g_Y) * Arguments.DownsampledWidth +
						  g_X) *
						 16);
					*reinterpret_cast<uint4*>(g_PaddingVectorAddress) = make_uint4(0, 0, 0, 0);
				}
			}

			// A larger caller-provided target may extend past every launched window.
			// CTA zero handles that uncovered border, as the native clear path does.
			if (blockIdx.x == 0 && blockIdx.y == 0 && blockIdx.z == 0)
			{
				const int g_CoveredHeight =
					max(g_ValidHeight,
						min(Arguments.DownsampledHeight, (int(gridDim.y) * 8 + Arguments.OriginY) / 2));
				const int g_CoveredWidth =
					max(g_ValidWidth,
						min(Arguments.DownsampledWidth, (int(gridDim.x) * 8 + Arguments.OriginX) / 2));
				const int g_BottomPixels =
					(Arguments.DownsampledHeight - g_CoveredHeight) * Arguments.DownsampledWidth;
				const int g_RightPixels = g_CoveredHeight * (Arguments.DownsampledWidth - g_CoveredWidth);
				for (int g_Index = ThreadIndex; g_Index < (g_BottomPixels + g_RightPixels) * (Channels / 4);
					 g_Index += Channels)
				{
					const int g_Plane = g_Index % (Channels / 4), g_Pixel = g_Index / (Channels / 4);
					const bool bBottom = g_Pixel < g_BottomPixels;
					const int g_RightWidth = Arguments.DownsampledWidth - g_CoveredWidth;
					const int g_Y = bBottom ? g_CoveredHeight + g_Pixel / Arguments.DownsampledWidth
											: (g_Pixel - g_BottomPixels) / g_RightWidth;
					const int g_X = bBottom ? g_Pixel % Arguments.DownsampledWidth
											: g_CoveredWidth + (g_Pixel - g_BottomPixels) % g_RightWidth;
					const uint64_t g_PaddingVectorAddress =
						Arguments.g_DownsampledOutput +
						((uint64_t(g_Plane * Arguments.DownsampledHeight + g_Y) * Arguments.DownsampledWidth +
						  g_X) *
						 16);
					*reinterpret_cast<uint4*>(g_PaddingVectorAddress) = make_uint4(0, 0, 0, 0);
				}
			}
		}
	}
#endif
}
