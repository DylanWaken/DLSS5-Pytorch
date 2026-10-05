#include "kernel_helpers.cuh"
#include "frontend_profiles.cuh"
#include "frontend_math.cuh"
#include "input_features.cuh"
#include "window_downsample.cuh"
#include "window_pool.cuh"

// Reconstructed native frontend schedule; storage, fused window and publication are visible below.
extern "C" __global__ __maxnreg__(168) void output_window_postprocess_c32_fp8(
	FOutputWindowPostprocessC32Fp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = true;
	FWindowAccumulatorTile<32> r_RawInput[4];
	uint32_t r_Head[4][2];
	FPostprocessWindowParameters WindowParameters = {Parameters.g_Input,
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
		using FConfig = FPostprocessWindowProfile<bFp8>;
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
					bValid ? *reinterpret_cast<const uint32_t*>(Parameters.g_Input + g_Offset) : 0;
				{
					r_LowResolutionPairs[2 * r_Plane][r_Row] = DecodeE4(uint16_t(r_InputWord));
					r_LowResolutionPairs[2 * r_Plane + 1][r_Row] = DecodeE4(uint16_t(r_InputWord >> 16));
				}
			}

		#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
		{
			const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
			const int g_X = g_TileColumns == 1 ? 0 : g_OriginX / 4 + (r_Tile & 1);
			const int g_Y = g_TileRows == 1 ? 0 : g_OriginY / 4 + (r_Tile >> 1);
			const bool bValid = g_X >= 0 && g_X < g_TileColumns && g_Y >= 0 && g_Y < g_TileRows;
			FWindowActivationTile<bFp8> r_Adapter;
			#pragma unroll
			for (int r_Chunk = 0; r_Chunk < FConfig::InputChunks; ++r_Chunk)
			{
				const int64_t g_Offset =
					int64_t(g_Y * g_TileColumns + g_X) * FConfig::TileBytes + r_Chunk * 512 + Lane * 16;
				r_Adapter.r_Reduction[r_Chunk] = MakeWindowFragment(
					bValid ? __ldcg(reinterpret_cast<const uint4*>(Parameters.g_Adapter + g_Offset))
						   : make_uint4(0, 0, 0, 0));
			}
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
			{
				const int g_ScaleByte = r_Column * 16 + (Lane & 3) * 4;
				const uint32_t r_InputScale = *reinterpret_cast<const uint32_t*>(
					Parameters.g_PackedWeights + FConfig::CONST_INPUT_SCALE_OFFSET + g_ScaleByte);
				const uint32_t r_AdapterScale = *reinterpret_cast<const uint32_t*>(
					Parameters.g_PackedWeights + FConfig::CONST_ADAPTER_SCALE_OFFSET + g_ScaleByte);
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					const int r_SourceLane =
						(Lane & 3) | ((Lane >> 1) & 4) | ((r_Tile & 1) * 8) | (r_RowHalf * 16);
					const uint32_t r_UpsampledPair =
						ShuffleIdx(r_LowResolutionPairs[r_Column][r_Tile >> 1], r_SourceLane,
								   CONST_WARP_CLAMP, CONST_WARP_MEMBERS);
					uint32_t r_AdapterPair;
					r_AdapterPair =
						DecodeE4(uint16_t(r_Adapter.r_Reduction[0].r_Word[2 * (r_Column / 2) + r_RowHalf] >>
										  (16 * (r_Column & 1))));

					// Native SASS rounds the low product, then fuses the adapter product
					// with its addition. An unfixed sum of products may fuse the other side.
					r_RawInput[r_Tile].r_Pair[r_Column][r_RowHalf] =
						HalfFma(r_AdapterPair, r_AdapterScale, HalfMul(r_UpsampledPair, r_InputScale));
				}
			}
		}
	}

	// The complete fused FFN/attention schedule remains in this entry.
	{
		using FConfig = FPostprocessWindowProfile<bFp8>;
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
			r_Input[r_Tile] = PublishWindow32<bFp8>(WindowParameters.r_RawInput[r_Tile]);
			#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
				#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
				{
					uint32_t r_ResidualPair;
					r_ResidualPair = WindowParameters.r_RawInput[r_Tile].r_Pair[r_Column][r_RowHalf];
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

				// Apply the output head here before advancing the attention tile.
				{
					uint32_t r_HeadAccumulator[2] = {0, 0};
					#pragma unroll
					for (int r_ReductionChunk = 0; r_ReductionChunk < 2; ++r_ReductionChunk)
					{
						const uint4 r_Weights = __ldca(reinterpret_cast<const uint4*>(
							WindowParameters.g_PackedWeights +
							FPostprocessWindowProfile<bFp8>::CONST_HEAD_OFFSET + r_ReductionChunk * 512 +
							threadIdx.x * 16));
						const uint32_t r_HeadWeightFragment[2] = {r_Weights.x, r_Weights.y};
						MmaWindowFragment<false>(PublishWindowChunk<false>(r_Ffn[r_Tile], r_ReductionChunk),
												 r_HeadWeightFragment, r_HeadAccumulator);
					}
					WindowParameters.r_Head[r_Tile][0] = r_HeadAccumulator[0];
					WindowParameters.r_Head[r_Tile][1] = r_HeadAccumulator[1];
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
			ShuffleIdx(r_Head[r_TileRow * 2 + r_LocalTile][r_LocalRowHalf], r_SourceLane, CONST_WARP_CLAMP,
					   CONST_WARP_MEMBERS),
			ShuffleIdx(r_Head[r_TileRow * 2 + r_LocalTile][1 - r_LocalRowHalf], r_SourceLane ^ 1,
					   CONST_WARP_CLAMP, CONST_WARP_MEMBERS),
			ShuffleIdx(r_Head[r_TileRow * 2 + 1 - r_LocalTile][r_LocalRowHalf], r_SourceLane ^ 2,
					   CONST_WARP_CLAMP, CONST_WARP_MEMBERS),
			ShuffleIdx(r_Head[r_TileRow * 2 + 1 - r_LocalTile][1 - r_LocalRowHalf], r_SourceLane ^ 3,
					   CONST_WARP_CLAMP, CONST_WARP_MEMBERS)};
		const int r_PixelWordIndex = ((Lane >> 3) & 1) | ((Lane >> 3) & 2);
		const uint2 r_Pixel =
			make_uint2(r_GatheredHeadWords[r_PixelWordIndex], r_GatheredHeadWords[r_PixelWordIndex ^ 1]);
		const int g_X =
			int(blockIdx.x) * 8 + WindowParameters.OriginX + (threadIdx.x / 16) * 4 + (threadIdx.x & 3);
		const int g_Y =
			int(blockIdx.y) * 8 + WindowParameters.OriginY + (threadIdx.x % 16) / 4 + r_TileRow * 4;

		// Color conversion, optional temporal blending and final surface publication stay together.
		if (g_X < 0 || g_Y < 0 || g_X >= Parameters.Width || g_Y >= Parameters.Height)
			continue;
		const float Width = __int2float_rn(Parameters.ValidWidth);
		const float Height = __int2float_rn(Parameters.ValidHeight);
		const float2 Uv =
			make_float2(NativeFloatDivide(NativeFloatAdd(__uint2float_rn(g_X), CONST_PIXEL_CENTER), Width),
						NativeFloatDivide(NativeFloatAdd(__uint2float_rn(g_Y), CONST_PIXEL_CENTER), Height));
		const float r_HeadChannels[4] = {__half2float(__ushort_as_half(uint16_t(r_Pixel.x))),
										 __half2float(__ushort_as_half(uint16_t(r_Pixel.x >> 16))),
										 __half2float(__ushort_as_half(uint16_t(r_Pixel.y))),
										 __half2float(__ushort_as_half(uint16_t(r_Pixel.y >> 16)))};
		const bool bValidPixel = g_X < Parameters.ValidWidth && g_Y < Parameters.ValidHeight;
		float4 r_Color;
		if (Parameters.ColorTexture && bValidPixel)
		{
			const float2 ColorUv = TransformTextureCoordinates(Parameters.ColorTransform, Uv.x, Uv.y);
			const float4 r_CurrentColor = SampleTexture(Parameters.ColorTexture, ColorUv.x, ColorUv.y);
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] =
					NativeFloatFma(Parameters.OutputScale, r_HeadChannels[r_Channel],
								   NativeFloatFma((&r_CurrentColor.x)[r_Channel], CONST_COLOR_RESIDUAL_SCALE,
												  CONST_COLOR_RESIDUAL_BIAS));
		}
		else
		{
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] =
					NativeFloatMultiply(Parameters.OutputScale, r_HeadChannels[r_Channel]);
		}

		r_Color.w = CONST_ZERO;
		if (Parameters.bDisplayOutput)
		{
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] = ClampUnit(NativeFloatFma(
					(&r_Color.x)[r_Channel], CONST_COLOR_DISPLAY_SCALE, CONST_COLOR_DISPLAY_BIAS));
			r_Color.w = CONST_UNIT;
		}

		float r_BlendScale = CONST_UNIT;
		if (Parameters.g_BlendScale)
		{
			const float r_LoadedScale =
				__half2float(__ushort_as_half(*reinterpret_cast<const uint16_t*>(Parameters.g_BlendScale)));
			const uint32_t r_BlendScaleAbsBits = NativeAbsFtzF32(__float_as_uint(r_LoadedScale));
			r_BlendScale = NativeSetpEquFtzF32(r_BlendScaleAbsBits, CONST_FP32_INFINITY_BITS)
							   ? CONST_ZERO
							   : ClampUnit(r_LoadedScale);
		}

		if (Parameters.bDisplayOutput && Parameters.HistoryTexture && Parameters.MotionTexture &&
			bValidPixel && r_BlendScale > CONST_ZERO)
		{
			const float2 MotionUv = TransformTextureCoordinates(Parameters.MotionTransform, Uv.x, Uv.y);
			const float4 r_Motion = SampleTexture(Parameters.MotionTexture, MotionUv.x, MotionUv.y);
			const float2 PreviousUv =
				Parameters.bApplyMotion
					? make_float2(NativeFloatFma(Parameters.MotionScaleX, r_Motion.x, Uv.x),
								  NativeFloatFma(Parameters.MotionScaleY, r_Motion.y, Uv.y))
					: Uv;
			const float3 r_History = ReconstructHistory(
				Parameters.HistoryTexture, Parameters.HistoryTransform, PreviousUv, Width, Height);
			const float r_GateExponential = __uint_as_float(NativeEx2ApproxFtzF32(__float_as_uint(
				NativeFloatMultiply(r_HeadChannels[3], __uint_as_float(CONST_NEGATIVE_LOG2_E_BITS)))));
			const float r_HistoryBlendWeight = ClampUnit(NativeFloatMultiply(
				NativeFloatReciprocal(NativeFloatAdd(r_GateExponential, CONST_UNIT)), r_BlendScale));
			#pragma unroll
			for (int r_Channel = 0; r_Channel < 3; ++r_Channel)
				(&r_Color.x)[r_Channel] =
					NativeFloatFma(r_HistoryBlendWeight,
								   NativeFloatSubtract((&r_History.x)[r_Channel], (&r_Color.x)[r_Channel]),
								   (&r_Color.x)[r_Channel]);
		}

		NativeSurface2d(Parameters.OutputSurface, g_X, g_Y,
						make_uint4(__float_as_uint(r_Color.x), __float_as_uint(r_Color.y),
								   __float_as_uint(r_Color.z), __float_as_uint(r_Color.w)));
	}
#endif
}
