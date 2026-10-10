#pragma once
#include "../../shared/common/kernel_abi.h"
#include "../../shared/common/warp_window32.cuh"
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
// Shared record profiles and stage descriptors used by the six frontend entries.
template <bool bFp8> struct FPreprocessWindowProfile : FWindow32Profile<bFp8>
{
	// The adapter is always 16x32 Half, including the FP8 path. It is inserted
	// before the FFN skip scale; subsequent ordinary-record fields shift 1024B.
	static constexpr int AdapterBytes = 16 * 32 * sizeof(__half);
	static constexpr int AdapterOffset = FWindow32Profile<bFp8>::FfnScaleOffset;
	static constexpr int FfnScaleOffset = FWindow32Profile<bFp8>::FfnScaleOffset + AdapterBytes;
	static constexpr int QkvOffset = FWindow32Profile<bFp8>::QkvOffset + AdapterBytes;
	static constexpr int BiasOffset = FWindow32Profile<bFp8>::BiasOffset + AdapterBytes;
	static constexpr int HeadScaleOffset = FWindow32Profile<bFp8>::HeadScaleOffset + AdapterBytes;
	static constexpr int ProjectionOffset = FWindow32Profile<bFp8>::ProjectionOffset + AdapterBytes;
	static constexpr int AttentionScaleOffset = FWindow32Profile<bFp8>::AttentionScaleOffset + AdapterBytes;
};

struct FPreprocessWindowParameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int Height, Width, OriginX, OriginY;
	const FWindowAccumulatorTile<32>* r_Adapter;
};

constexpr uint32_t CONST_WARP_CLAMP = 31u;			 // All 32 lanes form one shuffle segment.
constexpr uint32_t CONST_WARP_MEMBERS = 0xffffffffu; // Every lane participates before boundary stores.

template <bool bFp8> struct FPostprocessWindowProfile : FWindow32Profile<bFp8>
{
	static constexpr int FfnScaleOffset = bFp8 ? 8208 : 16400;
	static constexpr int QkvOffset = bFp8 ? 8400 : 16592;
	static constexpr int BiasOffset = bFp8 ? 11472 : 22736;
	static constexpr int HeadScaleOffset = bFp8 ? 19664 : 30928;
	static constexpr int ProjectionOffset = bFp8 ? 19680 : 30944;
	static constexpr int AttentionScaleOffset = bFp8 ? 20704 : 32992;
	static constexpr int CONST_INPUT_SCALE_OFFSET = bFp8 ? 8272 : 16464;
	static constexpr int CONST_ADAPTER_SCALE_OFFSET = bFp8 ? 8336 : 16528;
	static constexpr int CONST_HEAD_OFFSET = bFp8 ? 20784 : 33072;
};

struct FPostprocessWindowParameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int Height, Width, OriginX, OriginY;
	const FWindowAccumulatorTile<32>* r_RawInput;
	uint32_t (*r_Head)[2];
};

#endif
