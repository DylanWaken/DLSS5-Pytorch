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

extern "C" __global__
	__maxnreg__(168) void input_preprocess_window_c32_fp8(FInputPreprocessWindowC32Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 890
	constexpr bool bFp8 = true;

	// Stage one 8x8 window of renderer features before the Half adapter consumes it.
	__shared__ dlssnr::layout::SharedFeatures s_Features;
	const float Width = __int2float_rn(Parameters.ValidWidth);
	const float Height = __int2float_rn(Parameters.ValidHeight);
	const uint16_t r_ColorScale = dlssnr::ops::convert_feature_to_half(
		flashlight::arch::add_ftz(Parameters.ColorScale, Parameters.ColorScale));
	for (int s_Pixel = 32 * threadIdx.y + threadIdx.x; s_Pixel < 64; s_Pixel += 32 * blockDim.y)
	{
		const int g_X = 8 * blockIdx.x + (s_Pixel & 7), g_Y = 8 * blockIdx.y + s_Pixel / 8;

		// Image lookup reflects one border extension; noise still uses original
		// coordinates. This distinction matters in the padded network field.
		const int g_ReflectedX = g_X < Parameters.ValidWidth ? g_X : 2 * Parameters.ValidWidth - g_X - 2;
		const int g_ReflectedY = g_Y < Parameters.ValidHeight ? g_Y : 2 * Parameters.ValidHeight - g_Y - 2;
		const float2 Uv = make_float2(
			flashlight::arch::divide_approx_ftz(
				flashlight::arch::add_ftz(__int2float_rn(g_ReflectedX), dlssnr::layout::pixel_center), Width),
			flashlight::arch::divide_approx_ftz(
				flashlight::arch::add_ftz(__int2float_rn(g_ReflectedY), dlssnr::layout::pixel_center),
				Height));
		const float3 r_Noise = dlssnr::ops::pixel_noise(Parameters.NoiseSeed, g_X, g_Y);
		const float4 r_Current =
			dlssnr::ops::sample_transformed(Parameters.CurrentTexture, Parameters.CurrentTransform, Uv);
		uint16_t r_CurrentHalf[3], r_HistoryHalf[3];
		#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			r_HistoryHalf[r_Channel] = r_CurrentHalf[r_Channel] =
				dlssnr::ops::condition_color((&r_Current.x)[r_Channel], r_ColorScale);
		if (Parameters.HistoryTexture && Parameters.MotionTexture)
		{
			// Visit the original depth candidates here so motion selection stays with feature staging.
			float2 MotionSampleOffset = make_float2(dlssnr::layout::zero, dlssnr::layout::zero);
			if (Parameters.DepthTexture)
			{
				const float DepthTexelWidth =
					dlssnr::ops::native_float_reciprocal(Parameters.DepthTransform.ScaleX);
				const float DepthTexelHeight =
					dlssnr::ops::native_float_reciprocal(Parameters.DepthTransform.ScaleY);
				float r_BestDepth =
					dlssnr::ops::sample_transformed(Parameters.DepthTexture, Parameters.DepthTransform, Uv).x;

				// The four diagonal candidates are visited TL, TR, BL, BR. Ties and NaNs
				// retain the prior sample, exactly as the native unordered comparisons do.
				#pragma unroll
				for (int Corner = 0; Corner < 4; ++Corner)
				{
					const float OffsetX = (Corner & 1) ? DepthTexelWidth : -DepthTexelWidth;
					const float OffsetY = (Corner & 2) ? DepthTexelHeight : -DepthTexelHeight;
					const float2 CandidateUv =
						make_float2((Corner & 1) ? flashlight::arch::add_ftz(Uv.x, DepthTexelWidth)
												 : flashlight::arch::subtract_ftz(Uv.x, DepthTexelWidth),
									(Corner & 2) ? flashlight::arch::add_ftz(Uv.y, DepthTexelHeight)
												 : flashlight::arch::subtract_ftz(Uv.y, DepthTexelHeight));
					const float r_CandidateDepth =
						dlssnr::ops::sample_transformed(Parameters.DepthTexture, Parameters.DepthTransform,
														CandidateUv)
							.x;
					const bool bKeepPreviousDepth =
						Parameters.bPreferGreaterDepth
							? flashlight::arch::compare_less_equal_unordered_ftz_bits(
								  __float_as_uint(r_CandidateDepth), __float_as_uint(r_BestDepth))
							: flashlight::arch::compare_greater_equal_unordered_ftz_bits(
								  __float_as_uint(r_CandidateDepth), __float_as_uint(r_BestDepth));
					if (!bKeepPreviousDepth)
					{
						MotionSampleOffset = make_float2(OffsetX, OffsetY);
						r_BestDepth = r_CandidateDepth;
					}
				}
				MotionSampleOffset.x = dlssnr::ops::native_float_multiply(
					MotionSampleOffset.x,
					flashlight::arch::divide_approx_ftz(Parameters.DepthTransform.ScaleX,
														Parameters.MotionTransform.ScaleX));
				MotionSampleOffset.y = dlssnr::ops::native_float_multiply(
					MotionSampleOffset.y,
					flashlight::arch::divide_approx_ftz(Parameters.DepthTransform.ScaleY,
														Parameters.MotionTransform.ScaleY));
			}
			const float4 r_Motion = dlssnr::ops::sample_transformed(
				Parameters.MotionTexture, Parameters.MotionTransform,
				make_float2(flashlight::arch::add_ftz(Uv.x, MotionSampleOffset.x),
							flashlight::arch::add_ftz(Uv.y, MotionSampleOffset.y)));
			const float2 PreviousUv =
				make_float2(flashlight::arch::fma_rn_ftz(r_Motion.x, Parameters.MotionScaleX, Uv.x),
							flashlight::arch::fma_rn_ftz(r_Motion.y, Parameters.MotionScaleY, Uv.y));
			const float3 r_History = dlssnr::ops::reconstruct_history(
				Parameters.HistoryTexture, Parameters.HistoryTransform, PreviousUv, Width, Height);
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				r_HistoryHalf[r_Channel] =
					dlssnr::ops::condition_color((&r_History.x)[r_Channel], r_ColorScale);
		}

		float r_ConditioningGreen = Parameters.ConditioningGreen,
			  r_ConditioningBlue = Parameters.ConditioningBlue;
		float r_ConditioningOverrideGreen =
			Parameters.bConditioningOverride ? -dlssnr::layout::unit : dlssnr::layout::zero;
		float r_ConditioningOverrideBlue = r_ConditioningOverrideGreen;
		if (Parameters.bConditioningOverride && !Parameters.ConditioningTexture)
		{
			const bool bExplicitConditioningOverride = flashlight::arch::compare_greater_equal_ftz_bits(
				__float_as_uint(flashlight::arch::maximum_ftz(Parameters.ConditioningOverrideGreen,
															  Parameters.ConditioningOverrideBlue)),
				__float_as_uint(dlssnr::layout::zero));
			if (bExplicitConditioningOverride)
			{
				r_ConditioningBlue = dlssnr::layout::unit;
				r_ConditioningOverrideGreen = flashlight::arch::compare_less_unordered_ftz_bits(
												  __float_as_uint(Parameters.ConditioningOverrideGreen),
												  __float_as_uint(dlssnr::layout::zero))
												  ? Parameters.ConditioningBlue
												  : Parameters.ConditioningOverrideGreen;
				r_ConditioningOverrideBlue = flashlight::arch::compare_less_unordered_ftz_bits(
												 __float_as_uint(Parameters.ConditioningOverrideBlue),
												 __float_as_uint(dlssnr::layout::zero))
												 ? Parameters.ConditioningBlue
												 : Parameters.ConditioningOverrideBlue;
			}
		}
		else if (Parameters.ConditioningTexture)
		{
			const float4 r_Conditioning = dlssnr::ops::sample_transformed(
				Parameters.ConditioningTexture, Parameters.ConditioningTransform, Uv);
			r_ConditioningGreen = dlssnr::ops::native_float_multiply(r_Conditioning.y, r_ConditioningGreen);
			r_ConditioningBlue = dlssnr::ops::native_float_multiply(r_Conditioning.z, r_ConditioningBlue);
		}

		s_Features.plane[0][s_Pixel] = make_uint4(
			dlssnr::ops::pack_feature_half_words(dlssnr::ops::convert_feature_to_half(r_Noise.x),
												 dlssnr::ops::convert_feature_to_half(r_Noise.y)),
			dlssnr::ops::pack_feature_half_words(dlssnr::ops::convert_feature_to_half(r_Noise.z),
												 dlssnr::ops::convert_feature_to_half(dlssnr::layout::unit)),
			dlssnr::ops::pack_feature_half_words(r_CurrentHalf[0], r_CurrentHalf[1]),
			dlssnr::ops::pack_feature_half_words(r_CurrentHalf[2], r_HistoryHalf[0]));
		s_Features.plane[1][s_Pixel] =
			make_uint4(dlssnr::ops::pack_feature_half_words(r_HistoryHalf[1], r_HistoryHalf[2]),
					   dlssnr::ops::pack_feature_half_words(
						   dlssnr::ops::convert_feature_to_half(Parameters.ConstantConditioning),
						   dlssnr::ops::convert_feature_to_half(r_ConditioningGreen)),
					   dlssnr::ops::pack_feature_half_words(
						   dlssnr::ops::convert_feature_to_half(r_ConditioningBlue),
						   dlssnr::ops::convert_feature_to_half(r_ConditioningOverrideGreen)),
					   dlssnr::ops::pack_feature_half_words(
						   dlssnr::ops::convert_feature_to_half(r_ConditioningOverrideBlue),
						   dlssnr::ops::convert_feature_to_half(dlssnr::layout::zero)));
	}

	__syncthreads();
	dlssnr::layout::WindowAccumulatorTile<32> r_Adapter[4];

	// The 16-to-32 adapter consumes the same two shared Half planes directly.
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights) +
							dlssnr::layout::PreprocessWindowProfile<bFp8>::adapter_offset;
	uint32_t r_WeightFragments[4][2];
	#pragma unroll
	for (int r_ColumnPair = 0; r_ColumnPair < 2; ++r_ColumnPair)
	{
		const uint4 r_WeightVector =
			flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
				flashlight::memory::GlobalAddress(
					reinterpret_cast<std::uint64_t>(g_Weights + r_ColumnPair * 512 + threadIdx.x * 16)));
		r_WeightFragments[2 * r_ColumnPair][0] = r_WeightVector.x;
		r_WeightFragments[2 * r_ColumnPair][1] = r_WeightVector.y;
		r_WeightFragments[2 * r_ColumnPair + 1][0] = r_WeightVector.z;
		r_WeightFragments[2 * r_ColumnPair + 1][1] = r_WeightVector.w;
	}

	#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		dlssnr::ops::WindowAFragment<false> r_Input;
		#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			// A word has two adjacent feature channels; its row maps directly
			// into a 4x4 physical tile, with the row-half distance of two pixels.
			const int s_Pixel = 4 * (r_Tile & 1) + 32 * (r_Tile >> 1) + ((threadIdx.x / 4) & 3) +
								8 * (threadIdx.x / 16) + 16 * (r_Word & 1);
			r_Input.word[r_Word] = s_Features.word(r_Word / 2, s_Pixel, threadIdx.x & 3);
		}

		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> accumulator{
				{r_Adapter[r_Tile].pair[r_Column][0], r_Adapter[r_Tile].pair[r_Column][1]}};
			dlssnr::ops::mma_window_fragment<false>(
				r_Input,
				flashlight::MmaBFragment<flashlight::InputPrecision::Fp16>{
					{r_WeightFragments[r_Column][0], r_WeightFragments[r_Column][1]}},
				accumulator);
			r_Adapter[r_Tile].pair[r_Column][0] = accumulator.word[0];
			r_Adapter[r_Tile].pair[r_Column][1] = accumulator.word[1];
		}
	}

	dlssnr::layout::PreprocessWindowArguments WindowParameters{0,
															   Parameters.g_Output,
															   Parameters.g_PackedWeights,
															   Parameters.FullHeight,
															   Parameters.FullWidth,
															   0,
															   0,
															   r_Adapter};

	// The complete fused FFN/attention schedule remains in this entry.
	{
		using FConfig = dlssnr::layout::PreprocessWindowProfile<bFp8>;
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
			r_Input[r_Tile] = dlssnr::ops::publish_window32<bFp8>(WindowParameters.adapter[r_Tile]);
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					uint32_t r_ResidualPair;
					r_ResidualPair = WindowParameters.adapter[r_Tile].pair[r_Column][r_RowHalf];
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
						r_Value[r_Tile].word[r_Column][0] =
							flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{r_LowRows},
															  flashlight::PackedHalf2{r_HighRows})
								.bits;
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
			dlssnr::ops::softmax_window_pair(r_Probabilities);

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
					const int g_TileColumns = WindowParameters.width / 4,
							  g_TileRows = WindowParameters.height / 4;
					const int g_OriginTileX = (int(blockIdx.x) * 8 + WindowParameters.origin_x) / 4;
					const int g_OriginTileY = (int(blockIdx.y) * 8 + WindowParameters.origin_y) / 4;
					const int g_TileX = g_OriginTileX + (r_Tile & 1), g_TileY = g_OriginTileY + (r_Tile >> 1);
					if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
					{
						#pragma unroll
						for (int r_Chunk = 0; r_Chunk < FConfig::input_chunks; ++r_Chunk)
						{
							const dlssnr::ops::WindowAFragment<bFp8> r_Output =
								dlssnr::ops::publish_window_chunk<bFp8>(r_Ffn[r_Tile], r_Chunk);
							const uint64_t g_OutputAddress =
								WindowParameters.output +
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
	}

#else
	// Keep the exported entry on older targets, but never silently skip FP8 work.
	__trap();
#endif
}
