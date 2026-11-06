// Reconstructed native frontend schedule; storage, fused window and publication are visible below.
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

extern "C" __global__ __maxnreg__(168) void output_window_postprocess_c32_fp16(
	FOutputWindowPostprocessC32Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	constexpr bool bFp8 = false;
	dlssnr::layout::WindowAccumulatorTile<32> r_RawInput[4];
	uint32_t r_Head[4][2];
	dlssnr::layout::PostprocessWindowArguments WindowParameters = {Parameters.g_Input,
																   0,
																   Parameters.g_PackedWeights,
																   Parameters.Height,
																   Parameters.Width,
																   Parameters.OriginX,
																   Parameters.OriginY,
																   r_RawInput,
																   r_Head};

	// Load low channel planes, expand pixels, and preserve the native rounded residual merge.
	{
		using FConfig = dlssnr::layout::PostprocessWindowProfile<bFp8>;
		const int Lane = threadIdx.x;
		const int g_LowHeight = Parameters.Height / 2, g_LowWidth = Parameters.Width / 2;
		const int g_OriginX = int(blockIdx.x) * 8 + Parameters.OriginX;
		const int g_OriginY = int(blockIdx.y) * 8 + Parameters.OriginY;
		uint32_t r_LowResolutionPairs[4][2];
		#pragma unroll
		for (int r_Plane = 0; r_Plane < (bFp8 ? 2 : 4); ++r_Plane)
			#pragma unroll
			for (int r_Row = 0; r_Row < 2; ++r_Row)
			{
				const int g_X = g_LowWidth == 1 ? 0 : g_OriginX / 2 + (Lane / 4) % 4;
				const int g_Y = g_LowHeight == 1 ? 0 : g_OriginY / 2 + Lane / 16 + r_Row * 2;
				const bool bValid = g_X >= 0 && g_X < g_LowWidth && g_Y >= 0 && g_Y < g_LowHeight;
				const int64_t g_Offset =
					((int64_t(r_Plane) * g_LowHeight + g_Y) * g_LowWidth + g_X) * 16 + (Lane & 3) * 4;
				const uint32_t r_InputWord =
					bValid ? *flashlight::memory::GlobalAddress(Parameters.g_Input + g_Offset)
								  .as_pointer<const std::uint32_t>()
						   : 0;
				r_LowResolutionPairs[r_Plane][r_Row] = r_InputWord;
			}

		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
			const int g_X = g_TileColumns == 1 ? 0 : g_OriginX / 4 + (r_Tile & 1);
			const int g_Y = g_TileRows == 1 ? 0 : g_OriginY / 4 + (r_Tile >> 1);
			const bool bValid = g_X >= 0 && g_X < g_TileColumns && g_Y >= 0 && g_Y < g_TileRows;
			dlssnr::layout::WindowActivationTile<bFp8> r_Adapter;
			#pragma unroll
			for (int r_Chunk = 0; r_Chunk < FConfig::input_chunks; ++r_Chunk)
			{
				const int64_t g_Offset =
					int64_t(g_Y * g_TileColumns + g_X) * FConfig::tile_bytes + r_Chunk * 512 + Lane * 16;
				r_Adapter.reduction[r_Chunk] = dlssnr::ops::make_window_fragment<bFp8>(
					bValid ? flashlight::memory::load_vector<flashlight::memory::CachePolicy::Cg, uint4>(
								 flashlight::memory::GlobalAddress(Parameters.g_Adapter + g_Offset))
						   : make_uint4(0, 0, 0, 0));
			}
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
			{
				const int g_ScaleByte = r_Column * 16 + (Lane & 3) * 4;
				const uint32_t r_InputScale =
					*flashlight::memory::GlobalAddress(Parameters.g_PackedWeights +
													   FConfig::input_scale_offset + g_ScaleByte)
						 .as_pointer<const std::uint32_t>();
				const uint32_t r_AdapterScale =
					*flashlight::memory::GlobalAddress(Parameters.g_PackedWeights +
													   FConfig::adapter_scale_offset + g_ScaleByte)
						 .as_pointer<const std::uint32_t>();
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int r_SourceLane =
						(Lane & 3) | ((Lane >> 1) & 4) | ((r_Tile & 1) * 8) | (r_RowHalf * 16);
					const uint32_t r_UpsampledPair = flashlight::arch::shuffle_index(
						r_LowResolutionPairs[r_Column][r_Tile >> 1], r_SourceLane, dlssnr::layout::warp_clamp,
						dlssnr::layout::warp_members);
					uint32_t r_AdapterPair;
					r_AdapterPair = r_Adapter.reduction[r_Column / 2].word[2 * (r_Column & 1) + r_RowHalf];

					// Native SASS rounds the low product, then fuses the adapter product
					// with its addition. An unfixed sum of products may fuse the other side.
					r_RawInput[r_Tile].pair[r_Column][r_RowHalf] =
						flashlight::numeric::half2_fma(
							flashlight::PackedHalf2{r_AdapterPair}, flashlight::PackedHalf2{r_AdapterScale},
							flashlight::PackedHalf2{
								flashlight::numeric::half2_multiply(flashlight::PackedHalf2{r_UpsampledPair},
																	flashlight::PackedHalf2{r_InputScale})
									.bits})
							.bits;
				}
			}
		}
	}

	// The complete fused FFN/attention schedule remains in this entry.
	{
		using FConfig = dlssnr::layout::PostprocessWindowProfile<bFp8>;
		const unsigned char* g_PackedWeights =
			reinterpret_cast<const unsigned char*>(WindowParameters.packed_weights);
		dlssnr::layout::WindowActivationTile<bFp8> r_Input[4];
		dlssnr::layout::WindowAccumulatorTile<32> r_Ffn[4];

		// Load the per-channel residual scales used by the FFN and attention branches.
		uint32_t r_FfnScale[4], r_AttentionScale[4];
		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			const int g_ChannelByte = 16 * r_Column + 4 * (threadIdx.x & 3);
			r_FfnScale[r_Column] = *flashlight::memory::GlobalAddress(
										reinterpret_cast<std::uint64_t>(
											g_PackedWeights + FConfig::ffn_scale_offset + g_ChannelByte))
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
			r_Input[r_Tile] = dlssnr::ops::publish_window32<bFp8>(WindowParameters.raw_input[r_Tile]);
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					uint32_t r_ResidualPair;
					r_ResidualPair = WindowParameters.raw_input[r_Tile].pair[r_Column][r_RowHalf];
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
						dlssnr::ops::normalize_window<true>(r_Projected,
															flashlight::PackedHalf2{r_HeadScale});
					else
						dlssnr::ops::normalize_window<false>(
							r_Projected, flashlight::PackedHalf2{dlssnr::layout::half2_one});
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

				// Apply the output head here before advancing the attention tile.
				{
					flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> r_HeadAccumulator{};
					#pragma unroll
					for (int r_ReductionChunk = 0; r_ReductionChunk < 2; ++r_ReductionChunk)
					{
						const uint4 r_Weights =
							flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
								flashlight::memory::GlobalAddress(
									WindowParameters.packed_weights +
									dlssnr::layout::PostprocessWindowProfile<bFp8>::head_offset +
									r_ReductionChunk * 512 + threadIdx.x * 16));
						dlssnr::ops::mma_window_fragment<false>(
							dlssnr::ops::publish_window_chunk<false>(r_Ffn[r_Tile], r_ReductionChunk),
							flashlight::MmaBFragment<flashlight::InputPrecision::Fp16>{
								{r_Weights.x, r_Weights.y}},
							r_HeadAccumulator);
					}
					WindowParameters.head[r_Tile][0] = r_HeadAccumulator.word[0];
					WindowParameters.head[r_Tile][1] = r_HeadAccumulator.word[1];
				}
			}
		}
	}

	// Decode the learned head, blend renderer inputs, and write valid output pixels to the surface.
	#pragma unroll
	for (int r_TileRow = 0; r_TileRow < 2; ++r_TileRow)
	{
		// Gather the four Half head channels into one RGBA pixel per lane.
		const int Lane = threadIdx.x;
		const int r_LocalRowHalf = Lane & 1, r_LocalTile = (Lane >> 1) & 1;
		const int r_SourceLane = ((Lane & 7) << 2) | (Lane >> 3);
		const uint32_t r_GatheredHeadWords[4] = {
			flashlight::arch::shuffle_index(r_Head[r_TileRow * 2 + r_LocalTile][r_LocalRowHalf], r_SourceLane,
											dlssnr::layout::warp_clamp, dlssnr::layout::warp_members),
			flashlight::arch::shuffle_index(r_Head[r_TileRow * 2 + r_LocalTile][1 - r_LocalRowHalf],
											r_SourceLane ^ 1, dlssnr::layout::warp_clamp,
											dlssnr::layout::warp_members),
			flashlight::arch::shuffle_index(r_Head[r_TileRow * 2 + 1 - r_LocalTile][r_LocalRowHalf],
											r_SourceLane ^ 2, dlssnr::layout::warp_clamp,
											dlssnr::layout::warp_members),
			flashlight::arch::shuffle_index(r_Head[r_TileRow * 2 + 1 - r_LocalTile][1 - r_LocalRowHalf],
											r_SourceLane ^ 3, dlssnr::layout::warp_clamp,
											dlssnr::layout::warp_members)};
		const int r_PixelWordIndex = ((Lane >> 3) & 1) | ((Lane >> 3) & 2);
		const uint2 r_Pixel =
			make_uint2(r_GatheredHeadWords[r_PixelWordIndex], r_GatheredHeadWords[r_PixelWordIndex ^ 1]);
		const int g_X =
			int(blockIdx.x) * 8 + WindowParameters.origin_x + (threadIdx.x / 16) * 4 + (threadIdx.x & 3);
		const int g_Y =
			int(blockIdx.y) * 8 + WindowParameters.origin_y + (threadIdx.x % 16) / 4 + r_TileRow * 4;

		// Color conversion, optional temporal blending and final surface publication stay together.
		if (g_X < 0 || g_Y < 0 || g_X >= Parameters.Width || g_Y >= Parameters.Height)
			continue;
		const float Width = __int2float_rn(Parameters.ValidWidth);
		const float Height = __int2float_rn(Parameters.ValidHeight);
		const float2 Uv = make_float2(
			flashlight::arch::divide_approx_ftz(
				flashlight::arch::add_ftz(__uint2float_rn(g_X), dlssnr::layout::pixel_center), Width),
			flashlight::arch::divide_approx_ftz(
				flashlight::arch::add_ftz(__uint2float_rn(g_Y), dlssnr::layout::pixel_center), Height));
		const float r_HeadChannels[4] = {__half2float(__ushort_as_half(uint16_t(r_Pixel.x))),
										 __half2float(__ushort_as_half(uint16_t(r_Pixel.x >> 16))),
										 __half2float(__ushort_as_half(uint16_t(r_Pixel.y))),
										 __half2float(__ushort_as_half(uint16_t(r_Pixel.y >> 16)))};
		const bool bValidPixel = g_X < Parameters.ValidWidth && g_Y < Parameters.ValidHeight;
		float4 r_Color;
		if (Parameters.ColorTexture && bValidPixel)
		{
			const float2 ColorUv =
				dlssnr::ops::transform_texture_coordinates(Parameters.ColorTransform, Uv.x, Uv.y);
			const float4 r_CurrentColor =
				dlssnr::ops::sample_texture(Parameters.ColorTexture, ColorUv.x, ColorUv.y);
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] = flashlight::arch::fma_rn_ftz(
					Parameters.OutputScale, r_HeadChannels[r_Channel],
					flashlight::arch::fma_rn_ftz((&r_CurrentColor.x)[r_Channel],
												 dlssnr::layout::color_residual_scale,
												 dlssnr::layout::color_residual_bias));
		}
		else
		{
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] =
					dlssnr::ops::native_float_multiply(Parameters.OutputScale, r_HeadChannels[r_Channel]);
		}

		r_Color.w = dlssnr::layout::zero;
		if (Parameters.bDisplayOutput)
		{
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] = dlssnr::ops::clamp_unit(
					flashlight::arch::fma_rn_ftz((&r_Color.x)[r_Channel], dlssnr::layout::color_display_scale,
												 dlssnr::layout::color_display_bias));
			r_Color.w = dlssnr::layout::unit;
		}

		float r_BlendScale = dlssnr::layout::unit;
		if (Parameters.g_BlendScale)
		{
			const float r_LoadedScale =
				__half2float(__ushort_as_half(*reinterpret_cast<const uint16_t*>(Parameters.g_BlendScale)));
			const uint32_t r_BlendScaleAbsBits =
				flashlight::arch::absolute_ftz_bits(__float_as_uint(r_LoadedScale));
			r_BlendScale = flashlight::arch::compare_equal_ftz_bits(r_BlendScaleAbsBits,
																	dlssnr::layout::fp32_infinity_bits)
							   ? dlssnr::layout::zero
							   : dlssnr::ops::clamp_unit(r_LoadedScale);
		}

		if (Parameters.bDisplayOutput && Parameters.HistoryTexture && Parameters.MotionTexture &&
			bValidPixel && r_BlendScale > dlssnr::layout::zero)
		{
			const float2 MotionUv =
				dlssnr::ops::transform_texture_coordinates(Parameters.MotionTransform, Uv.x, Uv.y);
			const float4 r_Motion =
				dlssnr::ops::sample_texture(Parameters.MotionTexture, MotionUv.x, MotionUv.y);
			const float2 PreviousUv =
				Parameters.bApplyMotion
					? make_float2(flashlight::arch::fma_rn_ftz(Parameters.MotionScaleX, r_Motion.x, Uv.x),
								  flashlight::arch::fma_rn_ftz(Parameters.MotionScaleY, r_Motion.y, Uv.y))
					: Uv;
			const float3 r_History = dlssnr::ops::reconstruct_history(
				Parameters.HistoryTexture, Parameters.HistoryTransform, PreviousUv, Width, Height);
			const float r_GateExponential = __uint_as_float(
				flashlight::arch::exp2_approx_ftz_bits(__float_as_uint(dlssnr::ops::native_float_multiply(
					r_HeadChannels[3], __uint_as_float(dlssnr::layout::negative_log2_e_bits)))));
			const float r_HistoryBlendWeight = dlssnr::ops::clamp_unit(dlssnr::ops::native_float_multiply(
				dlssnr::ops::native_float_reciprocal(
					flashlight::arch::add_ftz(r_GateExponential, dlssnr::layout::unit)),
				r_BlendScale));
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] = flashlight::arch::fma_rn_ftz(
					r_HistoryBlendWeight,
					flashlight::arch::subtract_ftz((&r_History.x)[r_Channel], (&r_Color.x)[r_Channel]),
					(&r_Color.x)[r_Channel]);
		}

		dlssnr::ops::native_surface_2d(Parameters.OutputSurface, g_X, g_Y,
									   make_uint4(__float_as_uint(r_Color.x), __float_as_uint(r_Color.y),
												  __float_as_uint(r_Color.z), __float_as_uint(r_Color.w)));
	}
#endif
}
