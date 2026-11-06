// Reconstructed native window_block_c64_downsample_fp8 schedule.
// The exported entry owns its storage, tensor stages and final publication.

#include <common/layout/numerical_constants.h>
#include <common/layout/spatial_projection.h>
#include <common/layout/window_profiles.h>
#include <common/ops/activation.h>
#include <common/ops/frontend_texture.h>
#include <common/ops/window_attention.h>
#include <dlssnr/abi/kernel_parameters.h>
#include <flashlight/arch/mma.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/core.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include <flashlight/warp/permutation.cuh>
#include <cstdint>

extern "C" __global__
	__maxnreg__(168) void window_block_c64_downsample_fp8(FWindowBlockC64DownsampleFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;
	constexpr int Channels = 64;
	const dlssnr::layout::WindowDownsampleArguments Arguments{Parameters.g_Input,
															  Parameters.g_Output,
															  Parameters.g_PackedWeights,
															  Parameters.g_DownsampledOutput,
															  Parameters.Height,
															  Parameters.Width,
															  Parameters.OriginX,
															  Parameters.OriginY,
															  Parameters.DownsampledHeight,
															  Parameters.DownsampledWidth};
	dlssnr::layout::WindowAccumulatorTile<32> r_WindowOutput[4];
	{
		// The block output and downsample projection reuse the same shared slab.
		__shared__ dlssnr::layout::SharedWindowExchange<Channels, bFp8> s_Window;
		{
			// Window FFN, attention and residual projection; retain raw Half tiles for pooling.
			using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
			const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Arguments.packed_weights);

			// FFN: each warp retains two token tiles and both channel panels.
			const int Warp = threadIdx.y;
			{
				// C64 uses token parallelism in the FFN: one warp owns left/right tiles
				// in one window row, keeping both input channel panels in registers.
				dlssnr::layout::RegisterWindow<bFp8, 2, 2> r_Input;
				dlssnr::layout::WindowAccumulatorTile<32> r_Output[2][2];
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
					#pragma unroll
					for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
					{
						{
							// Read the physical input tile without a separate layout staging pass.
							using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
							const int g_TileColumns = Arguments.width / 4, g_TileRows = Arguments.height / 4;
							const int g_TileX = g_TileColumns == 1
													? 0
													: (int(blockIdx.x) * 8 + Arguments.origin_x) / 4 +
														  ((2 * Warp + r_Tile) & 1);
							const int g_TileY = g_TileRows == 1
													? 0
													: (int(blockIdx.y) * 8 + Arguments.origin_y) / 4 +
														  ((2 * Warp + r_Tile) >> 1);
							const bool bValid = g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 &&
												g_TileY < g_TileRows;
							dlssnr::layout::WindowActivationTile<bFp8> r_InputTile;
							#pragma unroll
							for (int r_Chunk = 0; r_Chunk < FConfig::chunks; ++r_Chunk)
							{
								const uint64_t g_InputFragmentAddress =
									Arguments.input +
									uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::tile_bytes +
									(r_Panel)*FConfig::panel_bytes + r_Chunk * 512 + int(threadIdx.x) * 16;
								r_InputTile.reduction[r_Chunk] = dlssnr::ops::make_window_fragment<bFp8>(
									bValid
										? flashlight::memory::load_vector<flashlight::memory::CachePolicy::Cg,
																		  uint4>(
											  flashlight::memory::GlobalAddress(g_InputFragmentAddress))
										: make_uint4(0, 0, 0, 0));
							}
							r_Input.tile[r_Tile][r_Panel] = r_InputTile;
						}
						r_Output[r_Tile][r_Panel] = dlssnr::ops::scaled_window_residual(
							r_Input.tile[r_Tile][r_Panel], g_PackedWeights + FConfig::ffn_scale_offset,
							32 * r_Panel);
					}

				// Accumulate the two expert contributions into the scaled FFN residual.
				#pragma unroll 1
				for (int ExpertIndex = 0; ExpertIndex < 2; ++ExpertIndex)
				{
					dlssnr::layout::WindowAccumulatorTile<32> r_Contracted[2]{};
					dlssnr::ops::compute_window_expert<Channels, bFp8>(r_Input, g_PackedWeights, ExpertIndex,
																	   r_Contracted);
					#pragma unroll
					for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
					{
						const auto r_Weights = dlssnr::ops::load_window_weights<bFp8>(
							g_PackedWeights + FConfig::mix_offset, r_Panel * 32, ExpertIndex * 32, Channels);
						#pragma unroll
						for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
							dlssnr::ops::linear_window32(
								dlssnr::ops::publish_window32<bFp8>(r_Contracted[r_Tile]), r_Weights,
								r_Output[r_Tile][r_Panel]);
					}
				}
				#pragma unroll
				for (int r_Tile = 0; r_Tile < 2; ++r_Tile)
					#pragma unroll
					for (int r_Panel = 0; r_Panel < 2; ++r_Panel)
						s_Window.store(2 * Warp + r_Tile, r_Panel,
									   dlssnr::ops::publish_window32<bFp8>(r_Output[r_Tile][r_Panel]));
				__syncthreads();
			}

			// Project the FFN output into Q/K/V fragments and normalize the query/key rows.
			dlssnr::layout::WindowActivationTile<bFp8> r_Query[4], r_Key[4];
			dlssnr::layout::WindowValueTile<bFp8> r_Value[4];

			// Q/K/V projection and normalization keep the native shared-panel ownership.
			dlssnr::layout::WindowAccumulatorTile<32> r_Projected[3][4]{};
			#pragma unroll 1
			for (int PanelIndex = 0; PanelIndex < FConfig::heads; ++PanelIndex)
				#pragma unroll
				for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
				{
					// The record interleaves Q/K/V within each head: [Head][Q,K,V][32].
					const auto r_Weights = dlssnr::ops::load_window_weights<bFp8>(
						g_PackedWeights + FConfig::qkv_offset, 96 * int(threadIdx.y) + 32 * r_QkvComponent,
						32 * PanelIndex, 3 * Channels);
					#pragma unroll
					for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
						dlssnr::ops::linear_window32(s_Window.load(r_Tile, PanelIndex), r_Weights,
													 r_Projected[r_QkvComponent][r_Tile]);
				}
			const uint32_t r_HeadScale =
				flashlight::numeric::half2_from_float_bits(
					*flashlight::memory::GlobalAddress(
						 reinterpret_cast<std::uint64_t>(g_PackedWeights + FConfig::head_scale_offset +
														 4 * threadIdx.y))
						 .as_pointer<const std::uint32_t>())
					.bits;
			#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			{
				dlssnr::ops::normalize_window<true>(r_Projected[0][r_Tile],
													flashlight::PackedHalf2{r_HeadScale});
				dlssnr::ops::normalize_window<false>(r_Projected[1][r_Tile],
													 flashlight::PackedHalf2{dlssnr::layout::half2_one});
				r_Query[r_Tile] = dlssnr::ops::publish_window32<bFp8>(r_Projected[0][r_Tile]);
				r_Key[r_Tile] = dlssnr::ops::publish_window32<bFp8>(r_Projected[1][r_Tile]);
				#pragma unroll
				for (int r_Column = 0; r_Column < 4; ++r_Column)
				{
					// Transpose Half accumulators before E4 publication, exactly as the
					// DLL does, to obtain B fragments for probability times value.
					const uint32_t r_LowerValueRows =
						flashlight::arch::transpose_m8n8(r_Projected[2][r_Tile].pair[r_Column][0]);
					const uint32_t r_UpperValueRows =
						flashlight::arch::transpose_m8n8(r_Projected[2][r_Tile].pair[r_Column][1]);
					r_Value[r_Tile].word[r_Column][0] =
						flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_LowerValueRows},
														  flashlight::PackedHalf2{r_UpperValueRows})
							.bits;
				}
			}
			__syncthreads();

			// Evaluate attention in tile batches, then project each head back into the residual stream.
			#pragma unroll
			for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += FConfig::attention_batch)
			{
				dlssnr::layout::WindowActivationTile<bFp8> r_Attended[FConfig::attention_batch];
				dlssnr::layout::WindowAccumulatorTile<32> r_Output[FConfig::attention_batch];
				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < FConfig::attention_batch; ++r_LocalTile)
				{
					const int r_Tile = r_FirstTile + r_LocalTile;
					r_Attended[r_LocalTile] = dlssnr::ops::attend_with_bias<bFp8>(
						r_Tile, g_PackedWeights + FConfig::bias_offset + 8192 * threadIdx.y, r_Query, r_Key,
						r_Value);
					r_Output[r_LocalTile] = dlssnr::ops::scaled_window_residual(
						s_Window.load(r_Tile, threadIdx.y), g_PackedWeights + FConfig::attention_scale_offset,
						32 * threadIdx.y);
				}

				// Each warp has consumed its own published FFN residual; attention
				// output now occupies the same head panel for the cross-head projection.
				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < FConfig::attention_batch; ++r_LocalTile)
					s_Window.store(r_FirstTile + r_LocalTile, threadIdx.y, r_Attended[r_LocalTile]);
				__syncthreads();
				#pragma unroll 1
				for (int PanelIndex = 0; PanelIndex < FConfig::heads; ++PanelIndex)
				{
					const auto r_Weights =
						dlssnr::ops::load_window_weights<bFp8>(g_PackedWeights + FConfig::projection_offset,
															   32 * threadIdx.y, 32 * PanelIndex, Channels);
					#pragma unroll
					for (int r_LocalTile = 0; r_LocalTile < FConfig::attention_batch; ++r_LocalTile)
						dlssnr::ops::linear_window32(s_Window.load(r_FirstTile + r_LocalTile, PanelIndex),
													 r_Weights, r_Output[r_LocalTile]);
				}
				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < FConfig::attention_batch; ++r_LocalTile)
				{
					r_WindowOutput[r_FirstTile + r_LocalTile] = r_Output[r_LocalTile];
					{
						// Publish final packed fragments directly to their physical output layout.
						using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
						const int g_TileColumns = Arguments.width / 4, g_TileRows = Arguments.height / 4;
						const int g_TileX = (int(blockIdx.x) * 8 + Arguments.origin_x) / 4 +
											((r_FirstTile + r_LocalTile) & 1);
						const int g_TileY = (int(blockIdx.y) * 8 + Arguments.origin_y) / 4 +
											((r_FirstTile + r_LocalTile) >> 1);
						if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
							#pragma unroll
							for (int r_Chunk = 0; r_Chunk < FConfig::chunks; ++r_Chunk)
							{
								const auto r_Published =
									dlssnr::ops::publish_window_chunk<bFp8>(r_Output[r_LocalTile], r_Chunk);
								const uint64_t g_OutputFragmentAddress =
									Arguments.output +
									uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::tile_bytes +
									threadIdx.y * FConfig::panel_bytes + r_Chunk * 512 + threadIdx.x * 16;
								flashlight::memory::store_no_allocate(
									flashlight::memory::GlobalAddress(g_OutputFragmentAddress),
									make_uint4(r_Published.word[0], r_Published.word[1], r_Published.word[2],
											   r_Published.word[3]));
							}
					}
				}
				__syncthreads();
			}
		}

		const auto r_Pooled = dlssnr::ops::publish_window32<bFp8>(dlssnr::ops::pool_window(r_WindowOutput));
		using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
		s_Window.store(0, threadIdx.y, r_Pooled);
		__syncthreads();
		const auto* g_Weights = reinterpret_cast<const unsigned char*>(Arguments.packed_weights) +
								FConfig::attention_scale_offset + 2 * Channels;
		#pragma unroll 1
		for (int OutputHalf = 0; OutputHalf < 2; ++OutputHalf)
		{
			dlssnr::layout::WindowAccumulatorTile<32> r_Output{};
			#pragma unroll
			for (int PanelIndex = 0; PanelIndex < FConfig::heads; ++PanelIndex)
			{
				const auto r_Weights = dlssnr::ops::load_window_weights<bFp8>(
					g_Weights, 32 * threadIdx.y + OutputHalf * Channels, 32 * PanelIndex, 2 * Channels);
				dlssnr::ops::linear_window32(s_Window.load(0, PanelIndex), r_Weights, r_Output);
			}
			dlssnr::ops::publish_window_downsample<Channels, bFp8>(
				Arguments,
				int(threadIdx.y) + OutputHalf * dlssnr::layout::WideWindowProfile<Channels, bFp8>::heads,
				r_Output);
		}

		__syncthreads();
		dlssnr::ops::clear_window_downsample_padding<Channels>(Arguments);
	}

#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
