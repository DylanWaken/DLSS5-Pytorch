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

template <int Channels, bool bInputView, typename FParameters>
__global__ __maxnreg__(168) void window_block_compact_fp16(FParameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	constexpr bool bFp8 = false;
	using FConfig = dlssnr::layout::Window32Profile<bFp8>;
	const unsigned char* g_PackedWeights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights);
	dlssnr::layout::WindowActivationTile<bFp8> r_Input[4];
	dlssnr::layout::WindowAccumulatorTile<32> r_Ffn[4];

	// Load the per-channel residual scales used by the FFN and attention branches.
	uint32_t r_FfnScale[4], r_AttentionScale[4];
	#pragma unroll
	for (int r_Column = 0; r_Column < 4; ++r_Column)
	{
		const int g_ChannelByte = 16 * r_Column + 4 * (threadIdx.x & 3);
		r_FfnScale[r_Column] =
			*flashlight::memory::GlobalAddress(
				 reinterpret_cast<std::uint64_t>(g_PackedWeights + FConfig::ffn_scale_offset + g_ChannelByte))
				 .as_pointer<const std::uint32_t>();
		r_AttentionScale[r_Column] =
			*flashlight::memory::GlobalAddress(
				 reinterpret_cast<std::uint64_t>(g_PackedWeights + FConfig::attention_scale_offset +
												 g_ChannelByte))
				 .as_pointer<const std::uint32_t>();
	}

	// Coalesced physical-tile input. Singleton dimensions broadcast the one
	// available tile for reads, as the native entry does; writes remain bounded.
	#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		if constexpr (bInputView)
		{
			// Read the physical input tile without a separate layout staging pass.
			constexpr int Chunks = dlssnr::layout::Window32Profile<bFp8>::input_chunks;
			const int g_Height = Parameters.ViewHeight > 0 ? Parameters.ViewHeight : Parameters.Height;
			const int g_Width = Parameters.ViewWidth > 0 ? Parameters.ViewWidth : Parameters.Width;
			const int g_OriginX = int(blockIdx.x) * 8 + Parameters.OriginX + ((r_Tile) & 1) * 4;
			const int g_OriginY = int(blockIdx.y) * 8 + Parameters.OriginY + ((r_Tile) >> 1) * 4;
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
					const int g_Plane = (0) * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
					const uint64_t g_InputWordAddress =
						Parameters.g_Input + ((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
						4 * (threadIdx.x & 3);
					r_InputTile.reduction[r_Chunk].word[r_Word] =
						g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height
							? *flashlight::memory::GlobalAddress(g_InputWordAddress)
								   .as_pointer<const std::uint32_t>()
							: 0u;
				}
			r_Input[r_Tile] = r_InputTile;
		}
		else
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
			for (int r_Chunk = 0; r_Chunk < FConfig::input_chunks; ++r_Chunk)
			{
				const int64_t g_Offset = int64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::tile_bytes +
										 r_Chunk * 512 + int(threadIdx.x) * 16;
				r_Input[r_Tile].reduction[r_Chunk] = dlssnr::ops::make_window_fragment<bFp8>(
					bValid ? flashlight::memory::load_vector<flashlight::memory::CachePolicy::Cg, uint4>(
								 flashlight::memory::GlobalAddress(
									 reinterpret_cast<std::uint64_t>(g_Input + g_Offset)))
						   : make_uint4(0, 0, 0, 0));
			}
		}

		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
			#pragma unroll
			for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
			{
				uint32_t r_ResidualPair;
				r_ResidualPair = r_Input[r_Tile].reduction[r_Column / 2].word[2 * (r_Column & 1) + r_RowHalf];
				r_Ffn[r_Tile].pair[r_Column][r_RowHalf] =
					flashlight::numeric::half2_multiply(flashlight::PackedHalf2{r_ResidualPair},
														flashlight::PackedHalf2{r_FfnScale[r_Column]})
						.bits;
			}
	}

	// Stream four 32-channel hidden panels through 32→128→32; the contraction
	// seed is the scaled input, and its reduction chunks stay in native order.
	#pragma unroll
	for (int HiddenPanel = 0; HiddenPanel < 4; ++HiddenPanel)
	{
		const dlssnr::layout::WindowWeightTile<bFp8> r_Expand =
			dlssnr::ops::load_window_weights<bFp8>(g_PackedWeights, 32 * HiddenPanel, 0, 128);
		const dlssnr::layout::WindowWeightTile<bFp8> r_Contract = dlssnr::ops::load_window_weights<bFp8>(
			g_PackedWeights + FConfig::contract_offset, 0, 32 * HiddenPanel, 32);
		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			dlssnr::layout::WindowAccumulatorTile<32> r_HiddenTile{};
			dlssnr::ops::linear_window32(r_Input[r_Tile], r_Expand, r_HiddenTile);
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_HiddenTile.pair[r_Column][r_RowHalf] =
						dlssnr::ops::activate_window(
							flashlight::PackedHalf2{r_HiddenTile.pair[r_Column][r_RowHalf]})
							.bits;
			dlssnr::ops::linear_window32(dlssnr::ops::publish_window32<bFp8>(r_HiddenTile), r_Contract,
										 r_Ffn[r_Tile]);
		}
	}

	#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		r_Input[r_Tile] = dlssnr::ops::publish_window32<bFp8>(r_Ffn[r_Tile]);

	// Project the FFN output into Q/K/V fragments and normalize the query/key rows.
	dlssnr::layout::WindowActivationTile<bFp8> r_Query[4], r_Key[4];
	dlssnr::layout::WindowValueTile<bFp8> r_Value[4];
	const uint32_t r_HeadScale =
		flashlight::numeric::half2_from_float_bits(
			*flashlight::memory::GlobalAddress(
				 reinterpret_cast<std::uint64_t>(g_PackedWeights + FConfig::head_scale_offset))
				 .as_pointer<const std::uint32_t>())
			.bits;
	#pragma unroll
	for (int ProjectionComponent = 0; ProjectionComponent < 3; ++ProjectionComponent)
	{
		const dlssnr::layout::WindowWeightTile<bFp8> r_Weights = dlssnr::ops::load_window_weights<bFp8>(
			g_PackedWeights + FConfig::qkv_offset, 32 * ProjectionComponent, 0, 96);
		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			dlssnr::layout::WindowAccumulatorTile<32> r_Projected{};
			dlssnr::ops::linear_window32(r_Input[r_Tile], r_Weights, r_Projected);
			if (ProjectionComponent < 2)
			{
				if (ProjectionComponent == 0)
					dlssnr::ops::normalize_window<true>(r_Projected, flashlight::PackedHalf2{r_HeadScale});
				else
					dlssnr::ops::normalize_window<false>(r_Projected,
														 flashlight::PackedHalf2{dlssnr::layout::half2_one});
				if (ProjectionComponent == 0)
					r_Query[r_Tile] = dlssnr::ops::publish_window32<bFp8>(r_Projected);
				else
					r_Key[r_Tile] = dlssnr::ops::publish_window32<bFp8>(r_Projected);
			}
			else
				#pragma unroll
				for (int r_Column = 0; r_Column < 4; ++r_Column)
				{
					const uint32_t r_LowRows =
						flashlight::arch::transpose_m8n8(r_Projected.pair[r_Column][0]);
					const uint32_t r_HighRows =
						flashlight::arch::transpose_m8n8(r_Projected.pair[r_Column][1]);
					{
						r_Value[r_Tile].word[r_Column][0] = r_LowRows;
						r_Value[r_Tile].word[r_Column][1] = r_HighRows;
					}
				}
		}
	}

	const dlssnr::layout::WindowWeightTile<bFp8> r_OutputWeights =
		dlssnr::ops::load_window_weights<bFp8>(g_PackedWeights + FConfig::projection_offset, 0, 0, 32);

	// FP8 follows the native two-query-tile softmax schedule. Keep the tested
	// FP16 schedule independent until its register pressure is measured.
	constexpr int CONST_QUERY_TILE_BATCH = bFp8 ? 2 : 1;
	#pragma unroll
	for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += CONST_QUERY_TILE_BATCH)
	{
		dlssnr::layout::WindowAccumulatorTile<64> r_Probabilities[CONST_QUERY_TILE_BATCH];
		#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
			r_Probabilities[r_LocalTile] = dlssnr::ops::query_key_scores<bFp8>(
				r_FirstTile + r_LocalTile, g_PackedWeights + FConfig::bias_offset, r_Query, r_Key);
		dlssnr::ops::softmax_window(r_Probabilities[0]);

		#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
		{
			const int r_Tile = r_FirstTile + r_LocalTile;
			const auto r_Attended =
				dlssnr::ops::probability_values<bFp8>(r_Probabilities[r_LocalTile], r_Value);
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Ffn[r_Tile].pair[r_Column][r_RowHalf] =
						flashlight::numeric::half2_multiply(
							flashlight::PackedHalf2{r_Ffn[r_Tile].pair[r_Column][r_RowHalf]},
							flashlight::PackedHalf2{r_AttentionScale[r_Column]})
							.bits;
			dlssnr::ops::linear_window32(dlssnr::ops::publish_window32<bFp8>(r_Attended), r_OutputWeights,
										 r_Ffn[r_Tile]);

			{
				const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
				const int g_OriginTileX = (int(blockIdx.x) * 8 + Parameters.OriginX) / 4;
				const int g_OriginTileY = (int(blockIdx.y) * 8 + Parameters.OriginY) / 4;
				const int g_TileX = g_OriginTileX + (r_Tile & 1), g_TileY = g_OriginTileY + (r_Tile >> 1);
				if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
				{
					#pragma unroll
					for (int r_Chunk = 0; r_Chunk < FConfig::input_chunks; ++r_Chunk)
					{
						const dlssnr::ops::WindowAFragment<bFp8> r_Output =
							dlssnr::ops::publish_window_chunk<bFp8>(r_Ffn[r_Tile], r_Chunk);
						const uint64_t g_OutputAddress =
							Parameters.g_Output +
							uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::tile_bytes +
							r_Chunk * 512 + int(threadIdx.x) * 16;
						flashlight::memory::store_no_allocate(
							flashlight::memory::GlobalAddress(g_OutputAddress),
							make_uint4(r_Output.word[0], r_Output.word[1], r_Output.word[2],
									   r_Output.word[3]));
					}
				}
			}
		}
	}
#endif
}

// Host dispatch resolves the 32-channel specialization.
extern "C" const void* Resolve_window_block_c32_fp16()
{
	return reinterpret_cast<const void*>(window_block_compact_fp16<32, false, FWindowBlockC32Fp16Parameters>);
}

// Host dispatch resolves the 32-channel specialization.
extern "C" const void* Resolve_window_block_c32_input_view_fp16()
{
	return reinterpret_cast<const void*>(
		window_block_compact_fp16<32, true, FWindowBlockC32InputViewFp16Parameters>);
}
