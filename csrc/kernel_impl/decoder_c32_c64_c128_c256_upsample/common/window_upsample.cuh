#pragma once
#include "../../shared/common/warp_window_wide.cuh"

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200

template <int Channels, bool bFp8> struct FWindowUpsampleBlockProfile : FWideWindowProfile<Channels, bFp8>
{
};

template <bool bFp8> struct FWindowUpsampleBlockProfile<32, bFp8> : FWindow32Profile<bFp8>
{
	static constexpr int Heads = 1;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
};

template <int Channels, bool bFp8> struct FWindowUpsampleProfile : FWindowUpsampleBlockProfile<Channels, bFp8>
{
	static constexpr int Heads = Channels / 32;
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int FfnMatricesBytes = Channels == 32 ? 8192 * ElementBytes
														   : Heads * Channels * 128 * ElementBytes +
																 Heads * 128 * 32 * ElementBytes +
																 Channels * Channels * ElementBytes;
	static constexpr int UpProjectionOffset = FfnMatricesBytes;
	static constexpr int Padding = Channels == 32 ? 16 : 0;
	static constexpr int FfnScaleOffset = FfnMatricesBytes + 2 * Channels * Channels * ElementBytes + Padding;
	static constexpr int TransitionScaleOffset = FfnScaleOffset + 2 * Channels + Padding;
	static constexpr int QkvOffset = TransitionScaleOffset + 2 * Channels;
	static constexpr int BiasOffset = QkvOffset + 3 * Channels * Channels * ElementBytes;
	static constexpr int HeadScaleOffset = BiasOffset + Heads * 8192;
	static constexpr int ProjectionOffset = HeadScaleOffset + ((Heads * 4 + 15) / 16) * 16;
	static constexpr int AttentionScaleOffset = ProjectionOffset + Channels * Channels * ElementBytes;
};

struct FWindowUpsampleArguments
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int Height, Width, OriginX, OriginY, ResidualHeight, ResidualWidth;
	void* s_Window;
	const FWindowAccumulatorTile<32>* r_Merged;
};

#endif
