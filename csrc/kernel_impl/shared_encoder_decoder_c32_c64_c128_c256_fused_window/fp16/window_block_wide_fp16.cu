// Compile-time window schedule; each specialization retains its native launch profile.
// Storage, tensor stages, layout reads and final publication remain in this global body.

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

template <int Channels, bool bInputView, bool bOutputView, typename FParameters>
__global__ __maxnreg__((Channels == 256 ? 192 : 168)) void window_block_wide_fp16(FParameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	constexpr bool bFp8 = false;
	__shared__ dlssnr::layout::SharedWindowExchange<Channels, bFp8> s_Window;
	using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
	const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights);

	// FFN: compute per-warp experts, then mix their shared channel panels.
	const int Warp = threadIdx.y;
	{
		#pragma unroll
		for (int TileIndex = 0; TileIndex < 4; ++TileIndex)
			if constexpr (bInputView)
			{
				// Read the physical input tile without a separate layout staging pass.
				constexpr int Chunks = dlssnr::layout::Window32Profile<bFp8>::input_chunks;
				const int g_Height = Parameters.ViewHeight > 0 ? Parameters.ViewHeight : Parameters.Height;
				const int g_Width = Parameters.ViewWidth > 0 ? Parameters.ViewWidth : Parameters.Width;
				const int g_OriginX = int(blockIdx.x) * 8 + Parameters.OriginX + ((TileIndex) & 1) * 4;
				const int g_OriginY = int(blockIdx.y) * 8 + Parameters.OriginY + ((TileIndex) >> 1) * 4;
				dlssnr::layout::WindowActivationTile<bFp8> r_InputTile;
				#pragma unroll
				for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
					#pragma unroll
					for (int r_Word = 0; r_Word < 4; ++r_Word)
					{
						// Row-half words differ by two physical image rows inside a 4x4
						// tile. Singleton dimensions broadcast; all other OOB reads zero.
						const int g_X = g_Width == 1 ? 0 : g_OriginX + ((threadIdx.x / 4) & 3);
						const int g_Y = g_Height == 1 ? 0 : g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
						const int g_Plane = (Warp) * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
						const uint64_t g_InputWordAddress =
							Parameters.g_Input + ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
							4 * (threadIdx.x & 3);
						r_InputTile.reduction[r_Chunk].word[r_Word] =
							g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height
								? *flashlight::memory::GlobalAddress(g_InputWordAddress)
									   .as_pointer<const std::uint32_t>()
								: 0u;
					}
				s_Window.store(TileIndex, Warp, r_InputTile);
			}
			else
			{
				// Read the physical input tile without a separate layout staging pass.
				using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
				const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
				const int g_TileX = g_TileColumns == 1
										? 0
										: (int(blockIdx.x) * 8 + Parameters.OriginX) / 4 + ((TileIndex) & 1);
				const int g_TileY =
					g_TileRows == 1 ? 0 : (int(blockIdx.y) * 8 + Parameters.OriginY) / 4 + ((TileIndex) >> 1);
				const bool bValid =
					g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows;
				dlssnr::layout::WindowActivationTile<bFp8> r_InputTile;
				#pragma unroll
				for (int r_Chunk = 0; r_Chunk < FConfig::chunks; ++r_Chunk)
				{
					const uint64_t g_InputFragmentAddress =
						Parameters.g_Input +
						uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::tile_bytes +
						(Warp)*FConfig::panel_bytes + r_Chunk * 512 + int(threadIdx.x) * 16;
					r_InputTile.reduction[r_Chunk] = dlssnr::ops::make_window_fragment<bFp8>(
						bValid ? flashlight::memory::load_vector<flashlight::memory::CachePolicy::Cg, uint4>(
									 flashlight::memory::GlobalAddress(g_InputFragmentAddress))
							   : make_uint4(0, 0, 0, 0));
				}
				s_Window.store(TileIndex, Warp, r_InputTile);
			}

		__syncthreads();
		dlssnr::layout::WindowAccumulatorTile<32> r_Contracted[4]{};
		dlssnr::ops::compute_window_expert<Channels, bFp8>(s_Window, g_PackedWeights, Warp, r_Contracted);
		dlssnr::layout::WindowAccumulatorTile<32> r_Output[4];
		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			r_Output[r_Tile] = dlssnr::ops::scaled_window_residual(
				s_Window.load(r_Tile, Warp), g_PackedWeights + FConfig::ffn_scale_offset, 32 * Warp);

		// All experts must finish reading X before their published outputs reuse
		// the same slab. This is a tensor lifetime barrier, not a warp shuffle.
		__syncthreads();
		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.store(r_Tile, Warp, dlssnr::ops::publish_window32<bFp8>(r_Contracted[r_Tile]));
		__syncthreads();
		#pragma unroll 1
		for (int PanelIndex = 0; PanelIndex < FConfig::heads; ++PanelIndex)
		{
			const auto r_Weights = dlssnr::ops::load_window_weights<bFp8>(
				g_PackedWeights + FConfig::mix_offset, 32 * Warp, 32 * PanelIndex, Channels);
			#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
				dlssnr::ops::linear_window32(s_Window.load(r_Tile, PanelIndex), r_Weights, r_Output[r_Tile]);
		}

		__syncthreads();
		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.store(r_Tile, Warp, dlssnr::ops::publish_window32<bFp8>(r_Output[r_Tile]));
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

	const uint32_t r_HeadScale = flashlight::numeric::half2_from_float_bits(
									 *flashlight::memory::GlobalAddress(
										  reinterpret_cast<std::uint64_t>(
											  g_PackedWeights + FConfig::head_scale_offset + 4 * threadIdx.y))
										  .as_pointer<const std::uint32_t>())
									 .bits;
	#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		dlssnr::ops::normalize_window<true>(r_Projected[0][r_Tile], flashlight::PackedHalf2{r_HeadScale});
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
			{
				r_Value[r_Tile].word[r_Column][0] = r_LowerValueRows;
				r_Value[r_Tile].word[r_Column][1] = r_UpperValueRows;
			}
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
				r_Tile, g_PackedWeights + FConfig::bias_offset + 8192 * threadIdx.y, r_Query, r_Key, r_Value);
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
			const auto r_Weights = dlssnr::ops::load_window_weights<bFp8>(
				g_PackedWeights + FConfig::projection_offset, 32 * threadIdx.y, 32 * PanelIndex, Channels);
			#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < FConfig::attention_batch; ++r_LocalTile)
				dlssnr::ops::linear_window32(s_Window.load(r_FirstTile + r_LocalTile, PanelIndex), r_Weights,
											 r_Output[r_LocalTile]);
		}

		#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::attention_batch; ++r_LocalTile)
		{

			if constexpr (bOutputView)
			{
				// Publish final packed fragments directly to their physical output layout.
				constexpr int Chunks = dlssnr::layout::Window32Profile<bFp8>::input_chunks;
				const int g_Height = Parameters.ViewHeight > 0 ? Parameters.ViewHeight : Parameters.Height;
				const int g_Width = Parameters.ViewWidth > 0 ? Parameters.ViewWidth : Parameters.Width;
				const int g_OriginX =
					int(blockIdx.x) * 8 + Parameters.OriginX + ((r_FirstTile + r_LocalTile) & 1) * 4;
				const int g_OriginY =
					int(blockIdx.y) * 8 + Parameters.OriginY + ((r_FirstTile + r_LocalTile) >> 1) * 4;
				#pragma unroll
				for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
				{
					const auto r_Fragment =
						dlssnr::ops::publish_window_chunk<bFp8>(r_Output[r_LocalTile], r_Chunk);
					#pragma unroll
					for (int r_Word = 0; r_Word < 4; ++r_Word)
					{
						const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
						const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
						if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
						{
							const int g_Plane = (threadIdx.y) * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
							const uint64_t g_OutputWordAddress =
								Parameters.g_Output +
								((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
								4 * (threadIdx.x & 3);
							flashlight::memory::store_vector<std::uint32_t>(
								flashlight::memory::GlobalAddress(g_OutputWordAddress),
								r_Fragment.word[r_Word]);
						}
					}
				}
			}
			else
			{
				// Publish final packed fragments directly to their physical output layout.
				using FConfig = dlssnr::layout::WideWindowProfile<Channels, bFp8>;
				const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
				const int g_TileX =
					(int(blockIdx.x) * 8 + Parameters.OriginX) / 4 + ((r_FirstTile + r_LocalTile) & 1);
				const int g_TileY =
					(int(blockIdx.y) * 8 + Parameters.OriginY) / 4 + ((r_FirstTile + r_LocalTile) >> 1);
				if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
					#pragma unroll
					for (int r_Chunk = 0; r_Chunk < FConfig::chunks; ++r_Chunk)
					{
						const auto r_Published =
							dlssnr::ops::publish_window_chunk<bFp8>(r_Output[r_LocalTile], r_Chunk);
						const uint64_t g_OutputFragmentAddress =
							Parameters.g_Output +
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
#endif
}

// Host dispatch resolves the 128-channel specialization.
extern "C" const void* Resolve_window_block_c128_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_wide_fp16<128, false, false, FWindowBlockC128Fp16Parameters>);
}

// Host dispatch resolves the 128-channel specialization.
extern "C" const void* Resolve_window_block_c128_input_view_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_wide_fp16<128, true, false, FWindowBlockC128InputViewFp16Parameters>);
}

// Host dispatch resolves the 128-channel specialization.
extern "C" const void* Resolve_window_block_c128_output_view_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_wide_fp16<128, false, true, FWindowBlockC128OutputViewFp16Parameters>);
}

// Host dispatch resolves the 256-channel specialization.
extern "C" const void* Resolve_window_block_c256_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_wide_fp16<256, false, false, FWindowBlockC256Fp16Parameters>);
}

// Host dispatch resolves the 256-channel specialization.
extern "C" const void* Resolve_window_block_c256_input_view_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_wide_fp16<256, true, false, FWindowBlockC256InputViewFp16Parameters>);
}

// Host dispatch resolves the 256-channel specialization.
extern "C" const void* Resolve_window_block_c256_output_view_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_wide_fp16<256, false, true, FWindowBlockC256OutputViewFp16Parameters>);
}
