#pragma once
#include <cstddef>
#include <cstdint>
#include <type_traits>

// The launch records are shared by host launchers and CUDA implementations.
// Keep each named Parameters type: its namespace is part of the exported CUDA
// entry signature, even when another entry has an identical field layout.
// Every launch passes one pointer to an entire zero-initialized record.
// Static assertions preserve the recovered DLL parameter offsets and extents.
// g_Input/g_Output are activation buffers; g_PackedWeights includes matrices,
// learned scales, and attention bias tables. g_Residual feeds residual addition.
// Height/Width and OriginX/OriginY use spatial pixels, not CTA/tile counts.
// Downsampled/View/Residual extents refer to their named physical buffer.
// Reserved fields are untouched ABI padding or fields unused by this entry;
// their names do not claim an unobserved renderer-level meaning.

// -----------------------------------------------------------------------------
// Window blocks and physical views
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::frontend_abi
{
// Texture coordinates apply bias/scale, then normalization, in this exact order.
struct FTextureTransform
{
	float r_BiasX, r_BiasY, r_ScaleX, r_ScaleY, r_NormalizeX, r_NormalizeY;
};

static_assert(sizeof(FTextureTransform) == 24 && alignof(FTextureTransform) == 4);

// Valid extents address the renderer image; Full extents include network padding.
// Pooled extents address the optional downsampled feature publication, in pixels.
struct alignas(8) FPreprocessParameters
{
	uint64_t g_CurrentTexture, g_HistoryTexture, g_MotionTexture, g_DepthTexture, g_ConditioningTexture;
	FTextureTransform HistoryTransform, MotionTransform, DepthTransform, ConditioningTransform,
		CurrentTransform;
	float r_MotionScaleX, r_MotionScaleY;
	uint32_t bPreferGreaterDepth;
	// Green/Blue name the sampled conditioning texture channels. The recovered
	// instructions do not establish what physical renderer quantities they mean.
	float r_ConditioningGreen, r_ConditioningBlue, r_ConstantConditioning;
	float r_ConditioningOverrideGreen, r_ConditioningOverrideBlue;
	uint32_t bConditioningOverride;
	float r_ColorScale;
	uint32_t NoiseSeed, ReservedAlignment;
	int32_t ValidHeight, ValidWidth;
	uint64_t g_Output, g_PackedWeights, ReservedOutputPointer;
	int32_t FullHeight, FullWidth;
	uint64_t g_PooledOutput;
	int32_t PooledHeight, PooledWidth;
};

// Height/Width cover the padded network field; Valid extents bound renderer texels.
// The output is a CUDA surface handle; texture fields are CUDA texture handles.
struct alignas(8) FPostprocessParameters
{
	uint64_t g_Input, g_Adapter, g_OutputSurface, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	float r_OutputScale;
	uint32_t bDisplayOutput;
	uint64_t g_ColorTexture;
	FTextureTransform ColorTransform;
	uint64_t g_HistoryTexture, g_MotionTexture, g_BlendScale;
	uint32_t bApplyMotion;
	FTextureTransform HistoryTransform, MotionTransform;
	float r_MotionScaleX, r_MotionScaleY;
	int32_t ValidWidth, ValidHeight;
	uint32_t ReservedPadding;
};
} // namespace dlssnr::reconstructed::frontend_abi

namespace dlssnr::reconstructed::window_block_c128_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_fp16

namespace dlssnr::reconstructed::window_block_c128_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_fp8

namespace dlssnr::reconstructed::window_block_c128_input_view_fp16
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_input_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp16

namespace dlssnr::reconstructed::window_block_c128_input_view_fp8
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_input_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp8

namespace dlssnr::reconstructed::window_block_c128_output_view_fp16
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_output_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp16

namespace dlssnr::reconstructed::window_block_c128_output_view_fp8
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_output_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp8

namespace dlssnr::reconstructed::window_block_c256_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_fp16

namespace dlssnr::reconstructed::window_block_c256_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_fp8

namespace dlssnr::reconstructed::window_block_c256_input_view_fp16
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_input_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp16

namespace dlssnr::reconstructed::window_block_c256_input_view_fp8
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_input_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp8

namespace dlssnr::reconstructed::window_block_c256_output_view_fp16
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_output_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp16

namespace dlssnr::reconstructed::window_block_c256_output_view_fp8
{
// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_output_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp8

namespace dlssnr::reconstructed::window_block_c32_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[7]; // Native ordinary C32 leaves bytes40..95 unused.
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_fp16

namespace dlssnr::reconstructed::window_block_c32_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[7]; // Native ordinary C32 leaves bytes40..95 unused.
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_fp8

namespace dlssnr::reconstructed::window_block_c32_input_view_fp16
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(Parameters, ViewHeight) == 72);
static_assert(offsetof(Parameters, ViewWidth) == 76);
static_assert(offsetof(Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_input_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp16

namespace dlssnr::reconstructed::window_block_c32_input_view_fp8
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(Parameters, ViewHeight) == 72);
static_assert(offsetof(Parameters, ViewWidth) == 76);
static_assert(offsetof(Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_input_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp8

namespace dlssnr::reconstructed::window_block_c32_output_view_fp16
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(Parameters, ViewHeight) == 72);
static_assert(offsetof(Parameters, ViewWidth) == 76);
static_assert(offsetof(Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_output_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_output_view_fp16

namespace dlssnr::reconstructed::window_block_c32_output_view_fp8
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(Parameters, ViewHeight) == 72);
static_assert(offsetof(Parameters, ViewWidth) == 76);
static_assert(offsetof(Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_output_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_output_view_fp8

namespace dlssnr::reconstructed::window_block_c64_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_fp16

namespace dlssnr::reconstructed::window_block_c64_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_fp8

namespace dlssnr::reconstructed::window_block_c64_input_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_input_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_input_view_fp16

namespace dlssnr::reconstructed::window_block_c64_input_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_input_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_input_view_fp8

namespace dlssnr::reconstructed::window_block_c64_output_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_output_view_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_output_view_fp16

namespace dlssnr::reconstructed::window_block_c64_output_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(Parameters, ViewHeight) == 80);
static_assert(offsetof(Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_output_view_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_output_view_fp8

// -----------------------------------------------------------------------------
// Downsampling
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp16
{
// A named exported record keeps the original entry signature and shared typed fields.
struct alignas(8) Parameters : dlssnr::reconstructed::frontend_abi::FPreprocessParameters
{
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(Parameters, g_MotionTexture) == 16);
static_assert(offsetof(Parameters, g_DepthTexture) == 24);
static_assert(offsetof(Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(Parameters, HistoryTransform) == 40);
static_assert(offsetof(Parameters, MotionTransform) == 64);
static_assert(offsetof(Parameters, DepthTransform) == 88);
static_assert(offsetof(Parameters, ConditioningTransform) == 112);
static_assert(offsetof(Parameters, CurrentTransform) == 136);
static_assert(offsetof(Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(Parameters, bConditioningOverride) == 192);
static_assert(offsetof(Parameters, r_ColorScale) == 196);
static_assert(offsetof(Parameters, NoiseSeed) == 200);
static_assert(offsetof(Parameters, ReservedAlignment) == 204);
static_assert(offsetof(Parameters, ValidHeight) == 208);
static_assert(offsetof(Parameters, ValidWidth) == 212);
static_assert(offsetof(Parameters, g_Output) == 216);
static_assert(offsetof(Parameters, g_PackedWeights) == 224);
static_assert(offsetof(Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(Parameters, FullHeight) == 240);
static_assert(offsetof(Parameters, FullWidth) == 244);
static_assert(offsetof(Parameters, g_PooledOutput) == 248);
static_assert(offsetof(Parameters, PooledHeight) == 256);
static_assert(offsetof(Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_downsample_c32_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp16

namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp8
{
// A named exported record keeps the original entry signature and shared typed fields.
struct alignas(8) Parameters : dlssnr::reconstructed::frontend_abi::FPreprocessParameters
{
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(Parameters, g_MotionTexture) == 16);
static_assert(offsetof(Parameters, g_DepthTexture) == 24);
static_assert(offsetof(Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(Parameters, HistoryTransform) == 40);
static_assert(offsetof(Parameters, MotionTransform) == 64);
static_assert(offsetof(Parameters, DepthTransform) == 88);
static_assert(offsetof(Parameters, ConditioningTransform) == 112);
static_assert(offsetof(Parameters, CurrentTransform) == 136);
static_assert(offsetof(Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(Parameters, bConditioningOverride) == 192);
static_assert(offsetof(Parameters, r_ColorScale) == 196);
static_assert(offsetof(Parameters, NoiseSeed) == 200);
static_assert(offsetof(Parameters, ReservedAlignment) == 204);
static_assert(offsetof(Parameters, ValidHeight) == 208);
static_assert(offsetof(Parameters, ValidWidth) == 212);
static_assert(offsetof(Parameters, g_Output) == 216);
static_assert(offsetof(Parameters, g_PackedWeights) == 224);
static_assert(offsetof(Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(Parameters, FullHeight) == 240);
static_assert(offsetof(Parameters, FullWidth) == 244);
static_assert(offsetof(Parameters, g_PooledOutput) == 248);
static_assert(offsetof(Parameters, PooledHeight) == 256);
static_assert(offsetof(Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_downsample_c32_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp8

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
{
// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_DownsampledOutput;
	uint64_t g_PackedWeights;
	uint8_t ReservedViewPadding[24];
	uint32_t Height;
	uint32_t Width;
	uint32_t DownsampledHeight;
	uint32_t DownsampledWidth;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 24);
static_assert(offsetof(Parameters, g_PackedWeights) == 32);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, Height) == 64);
static_assert(offsetof(Parameters, Width) == 68);
static_assert(offsetof(Parameters, DownsampledHeight) == 72);
static_assert(offsetof(Parameters, DownsampledWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_pool_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
{
// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_DownsampledOutput;
	uint64_t g_PackedWeights;
	uint8_t ReservedViewPadding[24];
	uint32_t Height;
	uint32_t Width;
	uint32_t DownsampledHeight;
	uint32_t DownsampledWidth;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 24);
static_assert(offsetof(Parameters, g_PackedWeights) == 32);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, Height) == 64);
static_assert(offsetof(Parameters, Width) == 68);
static_assert(offsetof(Parameters, DownsampledHeight) == 72);
static_assert(offsetof(Parameters, DownsampledWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_pool_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8

namespace dlssnr::reconstructed::window_block_c128_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(Parameters, DownsampledHeight) == 80);
static_assert(offsetof(Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_downsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp16

namespace dlssnr::reconstructed::window_block_c128_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(Parameters, DownsampledHeight) == 80);
static_assert(offsetof(Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_downsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp8

namespace dlssnr::reconstructed::window_block_c256_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(Parameters, DownsampledHeight) == 80);
static_assert(offsetof(Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_downsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp16

namespace dlssnr::reconstructed::window_block_c256_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(Parameters, DownsampledHeight) == 80);
static_assert(offsetof(Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_downsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp8

namespace dlssnr::reconstructed::window_block_c32_downsample_fp16
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 64);
static_assert(offsetof(Parameters, DownsampledHeight) == 72);
static_assert(offsetof(Parameters, DownsampledWidth) == 76);
static_assert(offsetof(Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_downsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp16

namespace dlssnr::reconstructed::window_block_c32_downsample_fp8
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 64);
static_assert(offsetof(Parameters, DownsampledHeight) == 72);
static_assert(offsetof(Parameters, DownsampledWidth) == 76);
static_assert(offsetof(Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_downsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp8

namespace dlssnr::reconstructed::window_block_c64_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(Parameters, DownsampledHeight) == 80);
static_assert(offsetof(Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_downsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp16

namespace dlssnr::reconstructed::window_block_c64_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(Parameters, DownsampledHeight) == 80);
static_assert(offsetof(Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_downsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp8

// -----------------------------------------------------------------------------
// Upsampling
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16
{
// Input/Output extents are pixels before/after nearest-neighbor 2x upsampling.
// Half and FP8 keep their distinct split-accumulator pointer offsets.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_SplitAccumulator, g_CompletionCounters, ReservedPointerPadding,
		ReservedAlternateScratch, g_PackedWeights;
	int32_t InputHeight, InputWidth, OutputHeight, OutputWidth;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 24);
static_assert(offsetof(Parameters, g_CompletionCounters) == 32);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 40);
static_assert(offsetof(Parameters, ReservedAlternateScratch) == 48);
static_assert(offsetof(Parameters, g_PackedWeights) == 56);
static_assert(offsetof(Parameters, InputHeight) == 64);
static_assert(offsetof(Parameters, InputWidth) == 68);
static_assert(offsetof(Parameters, OutputHeight) == 72);
static_assert(offsetof(Parameters, OutputWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void decoder_upsample_c1024_to_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8
{
// Input/Output extents are pixels before/after nearest-neighbor 2x upsampling.
// Half and FP8 keep their distinct split-accumulator pointer offsets.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, ReservedLegacyScratch, g_CompletionCounters,
		ReservedPointerPadding, g_SplitAccumulator, g_PackedWeights;
	int32_t InputHeight, InputWidth, OutputHeight, OutputWidth;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, ReservedLegacyScratch) == 24);
static_assert(offsetof(Parameters, g_CompletionCounters) == 32);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 40);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 48);
static_assert(offsetof(Parameters, g_PackedWeights) == 56);
static_assert(offsetof(Parameters, InputHeight) == 64);
static_assert(offsetof(Parameters, InputWidth) == 68);
static_assert(offsetof(Parameters, OutputHeight) == 72);
static_assert(offsetof(Parameters, OutputWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void decoder_upsample_c1024_to_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8

namespace dlssnr::reconstructed::window_block_c128_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, g_Residual) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_upsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp16

namespace dlssnr::reconstructed::window_block_c128_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, g_Residual) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_upsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp8

namespace dlssnr::reconstructed::window_block_c256_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, g_Residual) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_upsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp16

namespace dlssnr::reconstructed::window_block_c256_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, g_Residual) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_upsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp8

namespace dlssnr::reconstructed::window_block_c32_upsample_fp16
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
	uint64_t g_Residual;
	int32_t ResidualHeight, ResidualWidth;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(Parameters, ReservedViewHeight) == 72);
static_assert(offsetof(Parameters, ReservedViewWidth) == 76);
static_assert(offsetof(Parameters, g_Residual) == 80);
static_assert(offsetof(Parameters, ResidualHeight) == 88);
static_assert(offsetof(Parameters, ResidualWidth) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_upsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp16

namespace dlssnr::reconstructed::window_block_c32_upsample_fp8
{
// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
	uint64_t g_Residual;
	int32_t ResidualHeight, ResidualWidth;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(Parameters, ReservedViewHeight) == 72);
static_assert(offsetof(Parameters, ReservedViewWidth) == 76);
static_assert(offsetof(Parameters, g_Residual) == 80);
static_assert(offsetof(Parameters, ResidualHeight) == 88);
static_assert(offsetof(Parameters, ResidualWidth) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_upsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp8

namespace dlssnr::reconstructed::window_block_c64_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, g_Residual) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(Parameters, ReservedViewHeight) == 80);
static_assert(offsetof(Parameters, ReservedViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_upsample_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp16

namespace dlssnr::reconstructed::window_block_c64_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, g_Residual) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(Parameters, ReservedViewHeight) == 80);
static_assert(offsetof(Parameters, ReservedViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_upsample_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp8

// -----------------------------------------------------------------------------
// Attention and projections
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::global_attention_chained_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Query, g_Key, g_Value, g_Output, ReservedTailPadding, g_PredecessorCounters,
		g_CompletionCounters;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 64 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Query) == 0);
static_assert(offsetof(Parameters, g_Key) == 8);
static_assert(offsetof(Parameters, g_Value) == 16);
static_assert(offsetof(Parameters, g_Output) == 24);
static_assert(offsetof(Parameters, ReservedTailPadding) == 32);
static_assert(offsetof(Parameters, g_PredecessorCounters) == 40);
static_assert(offsetof(Parameters, g_CompletionCounters) == 48);
static_assert(offsetof(Parameters, BatchCount) == 56);
static_assert(offsetof(Parameters, TokensPerBatch) == 60);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_attention_chained_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp16

namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Query, g_Key, g_Value, g_Output, ReservedTailPadding, g_PredecessorCounters,
		g_CompletionCounters;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 64 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Query) == 0);
static_assert(offsetof(Parameters, g_Key) == 8);
static_assert(offsetof(Parameters, g_Value) == 16);
static_assert(offsetof(Parameters, g_Output) == 24);
static_assert(offsetof(Parameters, ReservedTailPadding) == 32);
static_assert(offsetof(Parameters, g_PredecessorCounters) == 40);
static_assert(offsetof(Parameters, g_CompletionCounters) == 48);
static_assert(offsetof(Parameters, BatchCount) == 56);
static_assert(offsetof(Parameters, TokensPerBatch) == 60);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_attention_chained_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8

namespace dlssnr::reconstructed::global_projection_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, g_SplitCounters) == 32);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(Parameters, BatchCount) == 64);
static_assert(offsetof(Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_projection_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_projection_c1024_fp16

namespace dlssnr::reconstructed::global_projection_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, g_SplitCounters) == 32);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(Parameters, BatchCount) == 64);
static_assert(offsetof(Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_projection_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_projection_c1024_fp8

namespace dlssnr::reconstructed::global_qkv_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Query, g_Key, g_Value, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Query) == 8);
static_assert(offsetof(Parameters, g_Key) == 16);
static_assert(offsetof(Parameters, g_Value) == 24);
static_assert(offsetof(Parameters, g_PackedWeights) == 32);
static_assert(offsetof(Parameters, g_SplitCounters) == 40);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 48);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 56);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 64);
static_assert(offsetof(Parameters, BatchCount) == 72);
static_assert(offsetof(Parameters, TokensPerBatch) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_qkv_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp16

namespace dlssnr::reconstructed::global_qkv_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Query, g_Key, g_Value, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Query) == 8);
static_assert(offsetof(Parameters, g_Key) == 16);
static_assert(offsetof(Parameters, g_Value) == 24);
static_assert(offsetof(Parameters, g_PackedWeights) == 32);
static_assert(offsetof(Parameters, g_SplitCounters) == 40);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 48);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 56);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 64);
static_assert(offsetof(Parameters, BatchCount) == 72);
static_assert(offsetof(Parameters, TokensPerBatch) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_qkv_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp8

namespace dlssnr::reconstructed::window_attention_projection_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp8

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16
{
// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint32_t Height;
	uint32_t Width;
	uint8_t ReservedViewPadding[32];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_output_view_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8
{
// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint32_t Height;
	uint32_t Width;
	uint8_t ReservedViewPadding[32];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedViewPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_output_view_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8

namespace dlssnr::reconstructed::window_qkv_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_qkv_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_qkv_c512_fp16

namespace dlssnr::reconstructed::window_qkv_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_qkv_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_qkv_c512_fp8

// -----------------------------------------------------------------------------
// Feed-forward blocks
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, g_SplitCounters) == 32);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(Parameters, BatchCount) == 64);
static_assert(offsetof(Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_contract_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16

namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, g_SplitCounters) == 32);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(Parameters, BatchCount) == 64);
static_assert(offsetof(Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_contract_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8

namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, g_SplitCounters) == 32);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(Parameters, BatchCount) == 64);
static_assert(offsetof(Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_expand_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16

namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, g_SplitCounters) == 32);
static_assert(offsetof(Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(Parameters, BatchCount) == 64);
static_assert(offsetof(Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_expand_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8

namespace dlssnr::reconstructed::window_ffn_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_c512_fp16

namespace dlssnr::reconstructed::window_ffn_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_c512_fp8

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_input_view_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp16

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, Height) == 24);
static_assert(offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32);
static_assert(offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_input_view_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_input_view_c512_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Residual) == 8);
static_assert(offsetof(Parameters, g_Output) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_input_view_c512_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8

// -----------------------------------------------------------------------------
// Channel projection
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
{
// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint8_t ReservedPointerPadding[8];
	uint32_t Height;
	uint32_t Width;
};

static_assert(sizeof(Parameters) == 40 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void channel_projection_c512_to_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8
{
// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint8_t ReservedPointerPadding[8];
	uint32_t Height;
	uint32_t Width;
};

static_assert(sizeof(Parameters) == 40 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, g_PackedWeights) == 16);
static_assert(offsetof(Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void channel_projection_c512_to_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8

// -----------------------------------------------------------------------------
// Input and output transforms
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::input_preprocess_window_c32_fp16
{
// A named exported record keeps the original entry signature and shared typed fields.
struct alignas(8) Parameters : dlssnr::reconstructed::frontend_abi::FPreprocessParameters
{
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(Parameters, g_MotionTexture) == 16);
static_assert(offsetof(Parameters, g_DepthTexture) == 24);
static_assert(offsetof(Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(Parameters, HistoryTransform) == 40);
static_assert(offsetof(Parameters, MotionTransform) == 64);
static_assert(offsetof(Parameters, DepthTransform) == 88);
static_assert(offsetof(Parameters, ConditioningTransform) == 112);
static_assert(offsetof(Parameters, CurrentTransform) == 136);
static_assert(offsetof(Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(Parameters, bConditioningOverride) == 192);
static_assert(offsetof(Parameters, r_ColorScale) == 196);
static_assert(offsetof(Parameters, NoiseSeed) == 200);
static_assert(offsetof(Parameters, ReservedAlignment) == 204);
static_assert(offsetof(Parameters, ValidHeight) == 208);
static_assert(offsetof(Parameters, ValidWidth) == 212);
static_assert(offsetof(Parameters, g_Output) == 216);
static_assert(offsetof(Parameters, g_PackedWeights) == 224);
static_assert(offsetof(Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(Parameters, FullHeight) == 240);
static_assert(offsetof(Parameters, FullWidth) == 244);
static_assert(offsetof(Parameters, g_PooledOutput) == 248);
static_assert(offsetof(Parameters, PooledHeight) == 256);
static_assert(offsetof(Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_c32_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_c32_fp16

namespace dlssnr::reconstructed::input_preprocess_window_c32_fp8
{
// A named exported record keeps the original entry signature and shared typed fields.
struct alignas(8) Parameters : dlssnr::reconstructed::frontend_abi::FPreprocessParameters
{
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(Parameters, g_MotionTexture) == 16);
static_assert(offsetof(Parameters, g_DepthTexture) == 24);
static_assert(offsetof(Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(Parameters, HistoryTransform) == 40);
static_assert(offsetof(Parameters, MotionTransform) == 64);
static_assert(offsetof(Parameters, DepthTransform) == 88);
static_assert(offsetof(Parameters, ConditioningTransform) == 112);
static_assert(offsetof(Parameters, CurrentTransform) == 136);
static_assert(offsetof(Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(Parameters, bConditioningOverride) == 192);
static_assert(offsetof(Parameters, r_ColorScale) == 196);
static_assert(offsetof(Parameters, NoiseSeed) == 200);
static_assert(offsetof(Parameters, ReservedAlignment) == 204);
static_assert(offsetof(Parameters, ValidHeight) == 208);
static_assert(offsetof(Parameters, ValidWidth) == 212);
static_assert(offsetof(Parameters, g_Output) == 216);
static_assert(offsetof(Parameters, g_PackedWeights) == 224);
static_assert(offsetof(Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(Parameters, FullHeight) == 240);
static_assert(offsetof(Parameters, FullWidth) == 244);
static_assert(offsetof(Parameters, g_PooledOutput) == 248);
static_assert(offsetof(Parameters, PooledHeight) == 256);
static_assert(offsetof(Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_c32_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_c32_fp8

namespace dlssnr::reconstructed::output_window_postprocess_c32_fp16
{
// A named exported record keeps the original entry signature and shared typed fields.
struct alignas(8) Parameters : dlssnr::reconstructed::frontend_abi::FPostprocessParameters
{
};

static_assert(sizeof(Parameters) == 184 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Adapter) == 8);
static_assert(offsetof(Parameters, g_OutputSurface) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, r_OutputScale) == 48);
static_assert(offsetof(Parameters, bDisplayOutput) == 52);
static_assert(offsetof(Parameters, g_ColorTexture) == 56);
static_assert(offsetof(Parameters, ColorTransform) == 64);
static_assert(offsetof(Parameters, g_HistoryTexture) == 88);
static_assert(offsetof(Parameters, g_MotionTexture) == 96);
static_assert(offsetof(Parameters, g_BlendScale) == 104);
static_assert(offsetof(Parameters, bApplyMotion) == 112);
static_assert(offsetof(Parameters, HistoryTransform) == 116);
static_assert(offsetof(Parameters, MotionTransform) == 140);
static_assert(offsetof(Parameters, r_MotionScaleX) == 164);
static_assert(offsetof(Parameters, r_MotionScaleY) == 168);
static_assert(offsetof(Parameters, ValidWidth) == 172);
static_assert(offsetof(Parameters, ValidHeight) == 176);
static_assert(offsetof(Parameters, ReservedPadding) == 180);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void output_window_postprocess_c32_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::output_window_postprocess_c32_fp16

namespace dlssnr::reconstructed::output_window_postprocess_c32_fp8
{
// A named exported record keeps the original entry signature and shared typed fields.
struct alignas(8) Parameters : dlssnr::reconstructed::frontend_abi::FPostprocessParameters
{
};

static_assert(sizeof(Parameters) == 184 && alignof(Parameters) == 8);
static_assert(std::is_standard_layout_v<Parameters> && std::is_trivially_copyable_v<Parameters>);
static_assert(offsetof(Parameters, g_Input) == 0);
static_assert(offsetof(Parameters, g_Adapter) == 8);
static_assert(offsetof(Parameters, g_OutputSurface) == 16);
static_assert(offsetof(Parameters, g_PackedWeights) == 24);
static_assert(offsetof(Parameters, Height) == 32);
static_assert(offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40);
static_assert(offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, r_OutputScale) == 48);
static_assert(offsetof(Parameters, bDisplayOutput) == 52);
static_assert(offsetof(Parameters, g_ColorTexture) == 56);
static_assert(offsetof(Parameters, ColorTransform) == 64);
static_assert(offsetof(Parameters, g_HistoryTexture) == 88);
static_assert(offsetof(Parameters, g_MotionTexture) == 96);
static_assert(offsetof(Parameters, g_BlendScale) == 104);
static_assert(offsetof(Parameters, bApplyMotion) == 112);
static_assert(offsetof(Parameters, HistoryTransform) == 116);
static_assert(offsetof(Parameters, MotionTransform) == 140);
static_assert(offsetof(Parameters, r_MotionScaleX) == 164);
static_assert(offsetof(Parameters, r_MotionScaleY) == 168);
static_assert(offsetof(Parameters, ValidWidth) == 172);
static_assert(offsetof(Parameters, ValidHeight) == 176);
static_assert(offsetof(Parameters, ReservedPadding) == 180);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void output_window_postprocess_c32_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::output_window_postprocess_c32_fp8

// -----------------------------------------------------------------------------
// Layout copies and completion-counter reset
// -----------------------------------------------------------------------------
namespace dlssnr::reconstructed::global_repack_layout
{
struct alignas(8) Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	int32_t Height;
	int32_t Width;
};

static_assert(sizeof(Parameters) == 24 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Input) == 0 && offsetof(Parameters, g_Output) == 8);
static_assert(offsetof(Parameters, Height) == 16 && offsetof(Parameters, Width) == 20);

struct alignas(8) ClearParameters
{
	uint64_t g_Counters;
	int32_t CounterCount;
	int32_t ReservedPadding;
};

static_assert(sizeof(ClearParameters) == 16 && alignof(ClearParameters) == 8);
static_assert(std::is_standard_layout_v<ClearParameters> && std::is_trivially_copyable_v<ClearParameters>);
static_assert(offsetof(ClearParameters, g_Counters) == 0 && offsetof(ClearParameters, CounterCount) == 8);
static_assert(offsetof(ClearParameters, ReservedPadding) == 12);
// Repack: 1024 channels, H/W nonnegative multiples of4 <=16384; pad32 FP8,
// pad16 Half. words/token=256/512; padded_tokens*words <= INT32_MAX/2.
// Grid=(padded_tokens*words/256,1,1), block=(256,1,1), dynamic shared=0.
// Clear: count is int32 WORDS; grid=(ceil(count/256),1,1), block=(256,1,1).
// Zero extents return without launch. Clear writes -1, not zero.
// Same-stream ordering and disjoint repack buffers are caller obligations.
} // namespace dlssnr::reconstructed::global_repack_layout

namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_2d_to_1d_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8

namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_1d_to_2d_c1024_fp8(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8

namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp16
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_2d_to_1d_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp16

namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp16
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_1d_to_2d_c1024_fp16(Parameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp16

namespace dlssnr::reconstructed::completion_counter_clear
{
using ClearParameters = dlssnr::reconstructed::global_repack_layout::ClearParameters;
#if !defined(__CUDACC__)
void completion_counter_clear(ClearParameters r_Parameters);
#endif
} // namespace dlssnr::reconstructed::completion_counter_clear
