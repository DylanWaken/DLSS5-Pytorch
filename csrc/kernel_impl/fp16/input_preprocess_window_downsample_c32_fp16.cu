#include "../common/kernel_helpers.cuh"
#include "../common/frontend_profiles.cuh"
#include "../common/frontend_math.cuh"
#include "../common/input_features.cuh"
#include "../common/window_downsample.cuh"
#include "../common/window_pool.cuh"

// Reconstructed native frontend schedule; storage, fused window and publication are visible below.
extern "C" __global__ __maxnreg__(168) void input_preprocess_window_downsample_c32_fp16(
	FInputPreprocessWindowDownsampleC32Fp16Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = false;

	// Stage one 8x8 window of renderer features before the Half adapter consumes it.
	__shared__ FSharedFeatures s_Features;
	const float Width = __int2float_rn(Parameters.ValidWidth);
	const float Height = __int2float_rn(Parameters.ValidHeight);
	const uint16_t r_ColorScale =
		ConvertFeatureToHalf(NativeFloatAdd(Parameters.ColorScale, Parameters.ColorScale));
	for (int s_Pixel = 32 * threadIdx.y + threadIdx.x; s_Pixel < 64; s_Pixel += 32 * blockDim.y)
	{
		const int g_X = 8 * blockIdx.x + (s_Pixel & 7), g_Y = 8 * blockIdx.y + s_Pixel / 8;

		// Image lookup reflects one border extension; noise still uses original
		// coordinates. This distinction matters in the padded network field.
		const int g_ReflectedX = g_X < Parameters.ValidWidth ? g_X : 2 * Parameters.ValidWidth - g_X - 2;
		const int g_ReflectedY = g_Y < Parameters.ValidHeight ? g_Y : 2 * Parameters.ValidHeight - g_Y - 2;
		const float2 Uv = make_float2(
			NativeFloatDivide(NativeFloatAdd(__int2float_rn(g_ReflectedX), CONST_PIXEL_CENTER), Width),
			NativeFloatDivide(NativeFloatAdd(__int2float_rn(g_ReflectedY), CONST_PIXEL_CENTER), Height));
		const float3 r_Noise = PixelNoise(Parameters.NoiseSeed, g_X, g_Y);
		const float4 r_Current =
			SampleTransformed(Parameters.CurrentTexture, Parameters.CurrentTransform, Uv);
		uint16_t r_CurrentHalf[3], r_HistoryHalf[3];
		#pragma unroll
		for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
			r_HistoryHalf[r_Channel] = r_CurrentHalf[r_Channel] =
				ConditionColor((&r_Current.x)[r_Channel], r_ColorScale);
		if (Parameters.HistoryTexture && Parameters.MotionTexture)
		{
			// Visit the original depth candidates here so motion selection stays with feature staging.
			float2 MotionSampleOffset = make_float2(CONST_ZERO, CONST_ZERO);
			if (Parameters.DepthTexture)
			{
				const float DepthTexelWidth = NativeFloatReciprocal(Parameters.DepthTransform.ScaleX);
				const float DepthTexelHeight = NativeFloatReciprocal(Parameters.DepthTransform.ScaleY);
				float r_BestDepth =
					SampleTransformed(Parameters.DepthTexture, Parameters.DepthTransform, Uv).x;

				// The four diagonal candidates are visited TL, TR, BL, BR. Ties and NaNs
				// retain the prior sample, exactly as the native unordered comparisons do.
				#pragma unroll
				for (int Corner = 0; Corner < 4; ++Corner)
				{
					const float OffsetX = (Corner & 1) ? DepthTexelWidth : -DepthTexelWidth;
					const float OffsetY = (Corner & 2) ? DepthTexelHeight : -DepthTexelHeight;
					const float2 CandidateUv =
						make_float2((Corner & 1) ? NativeFloatAdd(Uv.x, DepthTexelWidth)
												 : NativeFloatSubtract(Uv.x, DepthTexelWidth),
									(Corner & 2) ? NativeFloatAdd(Uv.y, DepthTexelHeight)
												 : NativeFloatSubtract(Uv.y, DepthTexelHeight));
					const float r_CandidateDepth =
						SampleTransformed(Parameters.DepthTexture, Parameters.DepthTransform, CandidateUv).x;
					const bool bKeepPreviousDepth =
						Parameters.bPreferGreaterDepth
							? NativeSetpLeuFtzF32(__float_as_uint(r_CandidateDepth),
												  __float_as_uint(r_BestDepth))
							: NativeSetpGeuFtzF32(__float_as_uint(r_CandidateDepth),
												  __float_as_uint(r_BestDepth));
					if (!bKeepPreviousDepth)
					{
						MotionSampleOffset = make_float2(OffsetX, OffsetY);
						r_BestDepth = r_CandidateDepth;
					}
				}
				MotionSampleOffset.x = NativeFloatMultiply(
					MotionSampleOffset.x,
					NativeFloatDivide(Parameters.DepthTransform.ScaleX, Parameters.MotionTransform.ScaleX));
				MotionSampleOffset.y = NativeFloatMultiply(
					MotionSampleOffset.y,
					NativeFloatDivide(Parameters.DepthTransform.ScaleY, Parameters.MotionTransform.ScaleY));
			}
			const float4 r_Motion =
				SampleTransformed(Parameters.MotionTexture, Parameters.MotionTransform,
								  make_float2(NativeFloatAdd(Uv.x, MotionSampleOffset.x),
											  NativeFloatAdd(Uv.y, MotionSampleOffset.y)));
			const float2 PreviousUv = make_float2(NativeFloatFma(r_Motion.x, Parameters.MotionScaleX, Uv.x),
												  NativeFloatFma(r_Motion.y, Parameters.MotionScaleY, Uv.y));
			const float3 r_History = ReconstructHistory(
				Parameters.HistoryTexture, Parameters.HistoryTransform, PreviousUv, Width, Height);
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				r_HistoryHalf[r_Channel] = ConditionColor((&r_History.x)[r_Channel], r_ColorScale);
		}

		float r_ConditioningGreen = Parameters.ConditioningGreen,
			  r_ConditioningBlue = Parameters.ConditioningBlue;
		float r_ConditioningOverrideGreen = Parameters.bConditioningOverride ? -CONST_UNIT : CONST_ZERO;
		float r_ConditioningOverrideBlue = r_ConditioningOverrideGreen;
		if (Parameters.bConditioningOverride && !Parameters.ConditioningTexture)
		{
			const bool bExplicitConditioningOverride =
				NativeSetpGeFtzF32(__float_as_uint(NativeFloatMaximum(Parameters.ConditioningOverrideGreen,
																	  Parameters.ConditioningOverrideBlue)),
								   __float_as_uint(CONST_ZERO));
			if (bExplicitConditioningOverride)
			{
				r_ConditioningBlue = CONST_UNIT;
				r_ConditioningOverrideGreen =
					NativeSetpLtuFtzF32(__float_as_uint(Parameters.ConditioningOverrideGreen),
										__float_as_uint(CONST_ZERO))
						? Parameters.ConditioningBlue
						: Parameters.ConditioningOverrideGreen;
				r_ConditioningOverrideBlue =
					NativeSetpLtuFtzF32(__float_as_uint(Parameters.ConditioningOverrideBlue),
										__float_as_uint(CONST_ZERO))
						? Parameters.ConditioningBlue
						: Parameters.ConditioningOverrideBlue;
			}
		}
		else if (Parameters.ConditioningTexture)
		{
			const float4 r_Conditioning =
				SampleTransformed(Parameters.ConditioningTexture, Parameters.ConditioningTransform, Uv);
			r_ConditioningGreen = NativeFloatMultiply(r_Conditioning.y, r_ConditioningGreen);
			r_ConditioningBlue = NativeFloatMultiply(r_Conditioning.z, r_ConditioningBlue);
		}

		s_Features.s_Plane[0][s_Pixel] = make_uint4(
			PackFeatureHalfWords(ConvertFeatureToHalf(r_Noise.x), ConvertFeatureToHalf(r_Noise.y)),
			PackFeatureHalfWords(ConvertFeatureToHalf(r_Noise.z), ConvertFeatureToHalf(CONST_UNIT)),
			PackFeatureHalfWords(r_CurrentHalf[0], r_CurrentHalf[1]),
			PackFeatureHalfWords(r_CurrentHalf[2], r_HistoryHalf[0]));
		s_Features.s_Plane[1][s_Pixel] =
			make_uint4(PackFeatureHalfWords(r_HistoryHalf[1], r_HistoryHalf[2]),
					   PackFeatureHalfWords(ConvertFeatureToHalf(Parameters.ConstantConditioning),
											ConvertFeatureToHalf(r_ConditioningGreen)),
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_ConditioningBlue),
											ConvertFeatureToHalf(r_ConditioningOverrideGreen)),
					   PackFeatureHalfWords(ConvertFeatureToHalf(r_ConditioningOverrideBlue),
											ConvertFeatureToHalf(CONST_ZERO)));
	}

	__syncthreads();
	FWindowAccumulatorTile<32> r_Adapter[4];

	// The 16-to-32 adapter consumes the same two shared Half planes directly.
	const auto* g_Weights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights) +
							FPreprocessWindowProfile<bFp8>::AdapterOffset;
	uint32_t r_WeightFragments[4][2];
	#pragma unroll
	for (int r_ColumnPair = 0; r_ColumnPair < 2; ++r_ColumnPair)
	{
		const uint4 r_WeightVector =
			*reinterpret_cast<const uint4*>(g_Weights + r_ColumnPair * 512 + threadIdx.x * 16);
		r_WeightFragments[2 * r_ColumnPair][0] = r_WeightVector.x;
		r_WeightFragments[2 * r_ColumnPair][1] = r_WeightVector.y;
		r_WeightFragments[2 * r_ColumnPair + 1][0] = r_WeightVector.z;
		r_WeightFragments[2 * r_ColumnPair + 1][1] = r_WeightVector.w;
	}

	#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		FWindowAFragment r_Input;
		#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
		{
			// A word has two adjacent feature channels; its row maps directly
			// into a 4x4 physical tile, with the row-half distance of two pixels.
			const int s_Pixel = 4 * (r_Tile & 1) + 32 * (r_Tile >> 1) + ((threadIdx.x / 4) & 3) +
								8 * (threadIdx.x / 16) + 16 * (r_Word & 1);
			const uint4& s_Channels = s_Features.s_Plane[r_Word / 2][s_Pixel];
			r_Input.r_Word[r_Word] = reinterpret_cast<const uint32_t*>(&s_Channels)[threadIdx.x & 3];
		}

		#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			r_Adapter[r_Tile].r_Pair[r_Column][0] = 0;
			r_Adapter[r_Tile].r_Pair[r_Column][1] = 0;
			MmaWindowFragment<false>(r_Input, r_WeightFragments[r_Column],
									 r_Adapter[r_Tile].r_Pair[r_Column]);
		}
	}

	FPreprocessWindowParameters WindowParameters{0,
												 Parameters.g_Output,
												 Parameters.g_PackedWeights,
												 Parameters.FullHeight,
												 Parameters.FullWidth,
												 0,
												 0,
												 r_Adapter};
	{
		FWindowAccumulatorTile<32> r_Output[4];

		// The complete fused FFN/attention schedule remains in this entry.
		{
			using FConfig = FPreprocessWindowProfile<bFp8>;
			const unsigned char* g_PackedWeights =
				reinterpret_cast<const unsigned char*>(WindowParameters.g_PackedWeights);
			FWindowActivationTile<bFp8> r_Input[4];
			FWindowAccumulatorTile<32> r_Ffn[4];

			// Load the per-channel residual scales used by the FFN and attention branches.
			uint32_t r_FfnScale[4], r_AttentionScale[4];
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
			{
				const int g_ChannelByte = 16 * r_Column + 4 * (threadIdx.x & 3);
				r_FfnScale[r_Column] = *reinterpret_cast<const uint32_t*>(
					g_PackedWeights + FConfig::FfnScaleOffset + g_ChannelByte);
				r_AttentionScale[r_Column] = *reinterpret_cast<const uint32_t*>(
					g_PackedWeights + FConfig::AttentionScaleOffset + g_ChannelByte);
			}

			// Coalesced physical-tile input. Singleton dimensions broadcast the one
			// available tile for reads, as the native entry does; writes remain bounded.
			#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			{
				r_Input[r_Tile] = PublishWindow32<bFp8>(WindowParameters.r_Adapter[r_Tile]);
				#pragma unroll
				for (int r_Column = 0; r_Column < 4; ++r_Column)
					#pragma unroll
					for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					{
						uint32_t r_ResidualPair;
						r_ResidualPair = WindowParameters.r_Adapter[r_Tile].r_Pair[r_Column][r_RowHalf];
						r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf] =
							HalfMul(r_ResidualPair, r_FfnScale[r_Column]);
					}
			}

			// Stream four 32-channel hidden panels through 32→128→32; the contraction
			// seed is the scaled input, and its reduction chunks stay in native order.
			#pragma unroll
			for (int HiddenPanel = 0; HiddenPanel < 4; ++HiddenPanel)
			{
				const FWindowWeightTile<bFp8> r_Expand =
					LoadWindowWeights<bFp8>(g_PackedWeights, 32 * HiddenPanel, 0, 128);
				const FWindowWeightTile<bFp8> r_Contract = LoadWindowWeights<bFp8>(
					g_PackedWeights + FConfig::ContractOffset, 0, 32 * HiddenPanel, 32);
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

			// Project the FFN output into Q/K/V fragments and normalize the query/key rows.
			FWindowActivationTile<bFp8> r_Query[4], r_Key[4];
			FWindowValueTile<bFp8> r_Value[4];
			const uint32_t r_HeadScale =
				FloatToHalf2(*reinterpret_cast<const uint32_t*>(g_PackedWeights + FConfig::HeadScaleOffset));
			#pragma unroll
			for (int ProjectionComponent = 0; ProjectionComponent < 3; ++ProjectionComponent)
			{
				const FWindowWeightTile<bFp8> r_Weights = LoadWindowWeights<bFp8>(
					g_PackedWeights + FConfig::QkvOffset, 32 * ProjectionComponent, 0, 96);
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
							{
								r_Value[r_Tile].r_Column[r_Column][0] = r_LowRows;
								r_Value[r_Tile].r_Column[r_Column][1] = r_HighRows;
							}
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
				SoftmaxWindow(r_Probabilities[0]);

				#pragma unroll
				for (int r_LocalTile = 0; r_LocalTile < CONST_QUERY_TILE_BATCH; ++r_LocalTile)
				{
					const int r_Tile = r_FirstTile + r_LocalTile;
					const auto r_Attended = ProbabilityValues<bFp8>(r_Probabilities[r_LocalTile], r_Value);
					#pragma unroll
					for (int r_Column = 0; r_Column < 4; ++r_Column)
						#pragma unroll
						for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
							r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf] = HalfMul(
								r_Ffn[r_Tile].r_Pair[r_Column][r_RowHalf], r_AttentionScale[r_Column]);
					LinearWindow32(PublishWindow32<bFp8>(r_Attended), r_OutputWeights, r_Ffn[r_Tile]);
					r_Output[r_Tile] = r_Ffn[r_Tile];

					{
						const int g_TileColumns = WindowParameters.Width / 4,
								  g_TileRows = WindowParameters.Height / 4;
						const int g_OriginTileX = (int(blockIdx.x) * 8 + WindowParameters.OriginX) / 4;
						const int g_OriginTileY = (int(blockIdx.y) * 8 + WindowParameters.OriginY) / 4;
						const int g_TileX = g_OriginTileX + (r_Tile & 1),
								  g_TileY = g_OriginTileY + (r_Tile >> 1);
						if (g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows)
						{
							#pragma unroll
							for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
							{
								const FWindowAFragment r_Output =
									PublishWindowChunk<bFp8>(r_Ffn[r_Tile], r_Chunk);
								const uint64_t g_OutputAddress =
									WindowParameters.g_Output +
									uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
									r_Chunk * 512 + int(threadIdx.x) * 16;
								StoreNoAllocate(g_OutputAddress,
												make_uint4(r_Output.r_Word[0], r_Output.r_Word[1],
														   r_Output.r_Word[2], r_Output.r_Word[3]));
							}
						}
					}
				}
			}
		}

		const auto r_Pooled = PoolWindow(r_Output);
		const FWindowDownsampleArguments DownsampledParameters{0,
															   Parameters.g_Output,
															   Parameters.g_PackedWeights,
															   Parameters.g_PooledOutput,
															   Parameters.FullHeight,
															   Parameters.FullWidth,
															   0,
															   0,
															   Parameters.PooledHeight,
															   Parameters.PooledWidth};

		// The input stage pools C32 directly. Later encoder stages additionally
		// project C -> 2C, which would be an incorrect extra operation here.
		PublishWindowDownsample<32, bFp8>(DownsampledParameters, 0, r_Pooled);
		ClearDownsamplePadding<32, 4>(DownsampledParameters);
	}
#endif
}
