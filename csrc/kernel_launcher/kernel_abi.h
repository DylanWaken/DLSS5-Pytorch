#pragma once
#include <cstddef>
#include <cstdint>
#include <type_traits>

// The launch records are shared by host launchers and CUDA implementations.
// Each entry uses a descriptive global record type and an unmangled C symbol.
// Shared layouts retain one type where their fields and semantics are identical.
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

struct alignas(8) FWindowBlockC128Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC128Fp16Parameters) == 88 && alignof(FWindowBlockC128Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128Fp16Parameters>);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128Fp16Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_fp16(FWindowBlockC128Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC128Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC128Fp8Parameters) == 88 && alignof(FWindowBlockC128Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128Fp8Parameters>);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128Fp8Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_fp8(FWindowBlockC128Fp8Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC128InputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC128InputViewFp16Parameters) == 88 &&
			  alignof(FWindowBlockC128InputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128InputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128InputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC128InputViewFp16Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_input_view_fp16(FWindowBlockC128InputViewFp16Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC128InputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC128InputViewFp8Parameters) == 88 &&
			  alignof(FWindowBlockC128InputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128InputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128InputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC128InputViewFp8Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_input_view_fp8(FWindowBlockC128InputViewFp8Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC128OutputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC128OutputViewFp16Parameters) == 88 &&
			  alignof(FWindowBlockC128OutputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128OutputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128OutputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC128OutputViewFp16Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_output_view_fp16(FWindowBlockC128OutputViewFp16Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC128OutputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC128OutputViewFp8Parameters) == 88 &&
			  alignof(FWindowBlockC128OutputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128OutputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128OutputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC128OutputViewFp8Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_output_view_fp8(FWindowBlockC128OutputViewFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC256Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC256Fp16Parameters) == 88 && alignof(FWindowBlockC256Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256Fp16Parameters>);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256Fp16Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_fp16(FWindowBlockC256Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC256Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC256Fp8Parameters) == 88 && alignof(FWindowBlockC256Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256Fp8Parameters>);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256Fp8Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_fp8(FWindowBlockC256Fp8Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC256InputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC256InputViewFp16Parameters) == 88 &&
			  alignof(FWindowBlockC256InputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256InputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256InputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC256InputViewFp16Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_input_view_fp16(FWindowBlockC256InputViewFp16Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC256InputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC256InputViewFp8Parameters) == 88 &&
			  alignof(FWindowBlockC256InputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256InputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256InputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC256InputViewFp8Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_input_view_fp8(FWindowBlockC256InputViewFp8Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC256OutputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC256OutputViewFp16Parameters) == 88 &&
			  alignof(FWindowBlockC256OutputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256OutputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256OutputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC256OutputViewFp16Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_output_view_fp16(FWindowBlockC256OutputViewFp16Parameters r_Parameters);
#endif

// ViewHeight/ViewWidth are physical channel-plane pixel extents; zero uses Height/Width.
struct alignas(8) FWindowBlockC256OutputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedPointerPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[4];
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC256OutputViewFp8Parameters) == 88 &&
			  alignof(FWindowBlockC256OutputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256OutputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256OutputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, ReservedViewPadding) == 48);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC256OutputViewFp8Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_output_view_fp8(FWindowBlockC256OutputViewFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC32Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[7]; // Native ordinary C32 leaves bytes40..95 unused.
};

static_assert(sizeof(FWindowBlockC32Fp16Parameters) == 96 && alignof(FWindowBlockC32Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32Fp16Parameters>);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_fp16(FWindowBlockC32Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC32Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[7]; // Native ordinary C32 leaves bytes40..95 unused.
};

static_assert(sizeof(FWindowBlockC32Fp8Parameters) == 96 && alignof(FWindowBlockC32Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32Fp8Parameters>);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_fp8(FWindowBlockC32Fp8Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32InputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(FWindowBlockC32InputViewFp16Parameters) == 96 &&
			  alignof(FWindowBlockC32InputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32InputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32InputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ViewHeight) == 72);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ViewWidth) == 76);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(FWindowBlockC32InputViewFp16Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_input_view_fp16(FWindowBlockC32InputViewFp16Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32InputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(FWindowBlockC32InputViewFp8Parameters) == 96 &&
			  alignof(FWindowBlockC32InputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32InputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32InputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ViewHeight) == 72);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ViewWidth) == 76);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(FWindowBlockC32InputViewFp8Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_input_view_fp8(FWindowBlockC32InputViewFp8Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32OutputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(FWindowBlockC32OutputViewFp16Parameters) == 96 &&
			  alignof(FWindowBlockC32OutputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32OutputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32OutputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ViewHeight) == 72);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ViewWidth) == 76);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(FWindowBlockC32OutputViewFp16Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_output_view_fp16(FWindowBlockC32OutputViewFp16Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32OutputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(FWindowBlockC32OutputViewFp8Parameters) == 96 &&
			  alignof(FWindowBlockC32OutputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32OutputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32OutputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ViewHeight) == 72);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ViewWidth) == 76);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(FWindowBlockC32OutputViewFp8Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_output_view_fp8(FWindowBlockC32OutputViewFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC64Fp16Parameters) == 88 && alignof(FWindowBlockC64Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64Fp16Parameters>);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64Fp16Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_fp16(FWindowBlockC64Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC64Fp8Parameters) == 88 && alignof(FWindowBlockC64Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64Fp8Parameters>);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64Fp8Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_fp8(FWindowBlockC64Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64InputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC64InputViewFp16Parameters) == 88 &&
			  alignof(FWindowBlockC64InputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64InputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64InputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC64InputViewFp16Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_input_view_fp16(FWindowBlockC64InputViewFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64InputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC64InputViewFp8Parameters) == 88 &&
			  alignof(FWindowBlockC64InputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64InputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64InputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC64InputViewFp8Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_input_view_fp8(FWindowBlockC64InputViewFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64OutputViewFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC64OutputViewFp16Parameters) == 88 &&
			  alignof(FWindowBlockC64OutputViewFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64OutputViewFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64OutputViewFp16Parameters>);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC64OutputViewFp16Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_output_view_fp16(FWindowBlockC64OutputViewFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64OutputViewFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ViewHeight, ViewWidth;
};

static_assert(sizeof(FWindowBlockC64OutputViewFp8Parameters) == 88 &&
			  alignof(FWindowBlockC64OutputViewFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64OutputViewFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64OutputViewFp8Parameters>);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, ViewHeight) == 80);
static_assert(offsetof(FWindowBlockC64OutputViewFp8Parameters, ViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_output_view_fp8(FWindowBlockC64OutputViewFp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Downsampling
// -----------------------------------------------------------------------------

// Each named entry record shares the recovered frontend field layout.
struct alignas(8) FInputPreprocessWindowDownsampleC32Fp16Parameters : FPreprocessParameters
{
};

static_assert(sizeof(FInputPreprocessWindowDownsampleC32Fp16Parameters) == 264 &&
			  alignof(FInputPreprocessWindowDownsampleC32Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FInputPreprocessWindowDownsampleC32Fp16Parameters> &&
			  std::is_trivially_copyable_v<FInputPreprocessWindowDownsampleC32Fp16Parameters>);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_MotionTexture) == 16);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_DepthTexture) == 24);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, HistoryTransform) == 40);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, MotionTransform) == 64);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, DepthTransform) == 88);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, ConditioningTransform) == 112);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, CurrentTransform) == 136);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_ConditioningOverrideGreen) ==
			  184);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, bConditioningOverride) == 192);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, r_ColorScale) == 196);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, NoiseSeed) == 200);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, ReservedAlignment) == 204);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, ValidHeight) == 208);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, ValidWidth) == 212);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_Output) == 216);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_PackedWeights) == 224);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, FullHeight) == 240);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, FullWidth) == 244);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, g_PooledOutput) == 248);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, PooledHeight) == 256);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp16Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
input_preprocess_window_downsample_c32_fp16(FInputPreprocessWindowDownsampleC32Fp16Parameters r_Parameters);
#endif

// Each named entry record shares the recovered frontend field layout.
struct alignas(8) FInputPreprocessWindowDownsampleC32Fp8Parameters : FPreprocessParameters
{
};

static_assert(sizeof(FInputPreprocessWindowDownsampleC32Fp8Parameters) == 264 &&
			  alignof(FInputPreprocessWindowDownsampleC32Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FInputPreprocessWindowDownsampleC32Fp8Parameters> &&
			  std::is_trivially_copyable_v<FInputPreprocessWindowDownsampleC32Fp8Parameters>);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_MotionTexture) == 16);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_DepthTexture) == 24);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, HistoryTransform) == 40);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, MotionTransform) == 64);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, DepthTransform) == 88);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, ConditioningTransform) == 112);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, CurrentTransform) == 136);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, bConditioningOverride) == 192);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, r_ColorScale) == 196);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, NoiseSeed) == 200);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, ReservedAlignment) == 204);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, ValidHeight) == 208);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, ValidWidth) == 212);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_Output) == 216);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_PackedWeights) == 224);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, FullHeight) == 240);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, FullWidth) == 244);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, g_PooledOutput) == 248);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, PooledHeight) == 256);
static_assert(offsetof(FInputPreprocessWindowDownsampleC32Fp8Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
input_preprocess_window_downsample_c32_fp8(FInputPreprocessWindowDownsampleC32Fp8Parameters r_Parameters);
#endif

// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) FWindowAttentionProjectionPoolC512Fp16Parameters
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

static_assert(sizeof(FWindowAttentionProjectionPoolC512Fp16Parameters) == 80 &&
			  alignof(FWindowAttentionProjectionPoolC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowAttentionProjectionPoolC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowAttentionProjectionPoolC512Fp16Parameters>);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, g_DownsampledOutput) == 24);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, g_PackedWeights) == 32);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, Height) == 64);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, Width) == 68);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, DownsampledHeight) == 72);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp16Parameters, DownsampledWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
window_attention_projection_pool_c512_fp16(FWindowAttentionProjectionPoolC512Fp16Parameters r_Parameters);
#endif

// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) FWindowAttentionProjectionPoolC512Fp8Parameters
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

static_assert(sizeof(FWindowAttentionProjectionPoolC512Fp8Parameters) == 80 &&
			  alignof(FWindowAttentionProjectionPoolC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowAttentionProjectionPoolC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowAttentionProjectionPoolC512Fp8Parameters>);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, g_DownsampledOutput) == 24);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, g_PackedWeights) == 32);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, Height) == 64);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, Width) == 68);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, DownsampledHeight) == 72);
static_assert(offsetof(FWindowAttentionProjectionPoolC512Fp8Parameters, DownsampledWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
window_attention_projection_pool_c512_fp8(FWindowAttentionProjectionPoolC512Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC128DownsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(FWindowBlockC128DownsampleFp16Parameters) == 88 &&
			  alignof(FWindowBlockC128DownsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128DownsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128DownsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, DownsampledHeight) == 80);
static_assert(offsetof(FWindowBlockC128DownsampleFp16Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_downsample_fp16(FWindowBlockC128DownsampleFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC128DownsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(FWindowBlockC128DownsampleFp8Parameters) == 88 &&
			  alignof(FWindowBlockC128DownsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128DownsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128DownsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, DownsampledHeight) == 80);
static_assert(offsetof(FWindowBlockC128DownsampleFp8Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_downsample_fp8(FWindowBlockC128DownsampleFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC256DownsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(FWindowBlockC256DownsampleFp16Parameters) == 88 &&
			  alignof(FWindowBlockC256DownsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256DownsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256DownsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, DownsampledHeight) == 80);
static_assert(offsetof(FWindowBlockC256DownsampleFp16Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_downsample_fp16(FWindowBlockC256DownsampleFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC256DownsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(FWindowBlockC256DownsampleFp8Parameters) == 88 &&
			  alignof(FWindowBlockC256DownsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256DownsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256DownsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, DownsampledHeight) == 80);
static_assert(offsetof(FWindowBlockC256DownsampleFp8Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_downsample_fp8(FWindowBlockC256DownsampleFp8Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32DownsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(FWindowBlockC32DownsampleFp16Parameters) == 96 &&
			  alignof(FWindowBlockC32DownsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32DownsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32DownsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, g_DownsampledOutput) == 64);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, DownsampledHeight) == 72);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, DownsampledWidth) == 76);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(FWindowBlockC32DownsampleFp16Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_downsample_fp16(FWindowBlockC32DownsampleFp16Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32DownsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
	uint64_t ReservedTailPointer;
	int32_t ReservedTailWordLow, ReservedTailWordHigh;
};

static_assert(sizeof(FWindowBlockC32DownsampleFp8Parameters) == 96 &&
			  alignof(FWindowBlockC32DownsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32DownsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32DownsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, g_DownsampledOutput) == 64);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, DownsampledHeight) == 72);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, DownsampledWidth) == 76);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, ReservedTailPointer) == 80);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, ReservedTailWordLow) == 88);
static_assert(offsetof(FWindowBlockC32DownsampleFp8Parameters, ReservedTailWordHigh) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_downsample_fp8(FWindowBlockC32DownsampleFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64DownsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedResidualPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(FWindowBlockC64DownsampleFp16Parameters) == 88 &&
			  alignof(FWindowBlockC64DownsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64DownsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64DownsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, ReservedResidualPadding) == 24);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, DownsampledHeight) == 80);
static_assert(offsetof(FWindowBlockC64DownsampleFp16Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_downsample_fp16(FWindowBlockC64DownsampleFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64DownsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, ReservedLeadingPadding;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], g_DownsampledOutput;
	int32_t DownsampledHeight, DownsampledWidth;
};

static_assert(sizeof(FWindowBlockC64DownsampleFp8Parameters) == 88 &&
			  alignof(FWindowBlockC64DownsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64DownsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64DownsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, ReservedLeadingPadding) == 24);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, g_DownsampledOutput) == 72);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, DownsampledHeight) == 80);
static_assert(offsetof(FWindowBlockC64DownsampleFp8Parameters, DownsampledWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_downsample_fp8(FWindowBlockC64DownsampleFp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Upsampling
// -----------------------------------------------------------------------------

// Input/Output extents are pixels before/after nearest-neighbor 2x upsampling.
// Half and FP8 keep their distinct split-accumulator pointer offsets.
struct alignas(8) FDecoderUpsampleC1024ToC512Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_SplitAccumulator, g_CompletionCounters, ReservedPointerPadding,
		ReservedAlternateScratch, g_PackedWeights;
	int32_t InputHeight, InputWidth, OutputHeight, OutputWidth;
};

static_assert(sizeof(FDecoderUpsampleC1024ToC512Fp16Parameters) == 80 &&
			  alignof(FDecoderUpsampleC1024ToC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FDecoderUpsampleC1024ToC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FDecoderUpsampleC1024ToC512Fp16Parameters>);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, g_SplitAccumulator) == 24);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, g_CompletionCounters) == 32);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, ReservedPointerPadding) == 40);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, ReservedAlternateScratch) == 48);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, g_PackedWeights) == 56);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, InputHeight) == 64);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, InputWidth) == 68);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, OutputHeight) == 72);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp16Parameters, OutputWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void decoder_upsample_c1024_to_c512_fp16(FDecoderUpsampleC1024ToC512Fp16Parameters r_Parameters);
#endif

// Input/Output extents are pixels before/after nearest-neighbor 2x upsampling.
// Half and FP8 keep their distinct split-accumulator pointer offsets.
struct alignas(8) FDecoderUpsampleC1024ToC512Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, ReservedLegacyScratch, g_CompletionCounters,
		ReservedPointerPadding, g_SplitAccumulator, g_PackedWeights;
	int32_t InputHeight, InputWidth, OutputHeight, OutputWidth;
};

static_assert(sizeof(FDecoderUpsampleC1024ToC512Fp8Parameters) == 80 &&
			  alignof(FDecoderUpsampleC1024ToC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FDecoderUpsampleC1024ToC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FDecoderUpsampleC1024ToC512Fp8Parameters>);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, ReservedLegacyScratch) == 24);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, g_CompletionCounters) == 32);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, ReservedPointerPadding) == 40);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, g_SplitAccumulator) == 48);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, g_PackedWeights) == 56);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, InputHeight) == 64);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, InputWidth) == 68);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, OutputHeight) == 72);
static_assert(offsetof(FDecoderUpsampleC1024ToC512Fp8Parameters, OutputWidth) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void decoder_upsample_c1024_to_c512_fp8(FDecoderUpsampleC1024ToC512Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC128UpsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC128UpsampleFp16Parameters) == 88 &&
			  alignof(FWindowBlockC128UpsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128UpsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128UpsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, g_Residual) == 24);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128UpsampleFp16Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_upsample_fp16(FWindowBlockC128UpsampleFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC128UpsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC128UpsampleFp8Parameters) == 88 &&
			  alignof(FWindowBlockC128UpsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC128UpsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC128UpsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, g_Residual) == 24);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC128UpsampleFp8Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c128_upsample_fp8(FWindowBlockC128UpsampleFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC256UpsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC256UpsampleFp16Parameters) == 88 &&
			  alignof(FWindowBlockC256UpsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256UpsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256UpsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, g_Residual) == 24);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256UpsampleFp16Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_upsample_fp16(FWindowBlockC256UpsampleFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC256UpsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(FWindowBlockC256UpsampleFp8Parameters) == 88 &&
			  alignof(FWindowBlockC256UpsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC256UpsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC256UpsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, g_Residual) == 24);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC256UpsampleFp8Parameters, ReservedTailPadding) == 48);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c256_upsample_fp8(FWindowBlockC256UpsampleFp8Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32UpsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
	uint64_t g_Residual;
	int32_t ResidualHeight, ResidualWidth;
};

static_assert(sizeof(FWindowBlockC32UpsampleFp16Parameters) == 96 &&
			  alignof(FWindowBlockC32UpsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32UpsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32UpsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, ReservedViewHeight) == 72);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, ReservedViewWidth) == 76);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, g_Residual) == 80);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, ResidualHeight) == 88);
static_assert(offsetof(FWindowBlockC32UpsampleFp16Parameters, ResidualWidth) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_upsample_fp16(FWindowBlockC32UpsampleFp16Parameters r_Parameters);
#endif

// Native C32 transition dimensions are pixels. Unused native slots retain padding fields.
struct alignas(8) FWindowBlockC32UpsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedViewPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
	uint64_t g_Residual;
	int32_t ResidualHeight, ResidualWidth;
};

static_assert(sizeof(FWindowBlockC32UpsampleFp8Parameters) == 96 &&
			  alignof(FWindowBlockC32UpsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC32UpsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC32UpsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, Height) == 24);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, Width) == 28);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, ReservedViewPadding) == 40);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, ReservedViewPointer) == 64);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, ReservedViewHeight) == 72);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, ReservedViewWidth) == 76);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, g_Residual) == 80);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, ResidualHeight) == 88);
static_assert(offsetof(FWindowBlockC32UpsampleFp8Parameters, ResidualWidth) == 92);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c32_upsample_fp8(FWindowBlockC32UpsampleFp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64UpsampleFp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
};

static_assert(sizeof(FWindowBlockC64UpsampleFp16Parameters) == 88 &&
			  alignof(FWindowBlockC64UpsampleFp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64UpsampleFp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64UpsampleFp16Parameters>);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, g_Residual) == 24);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, ReservedViewHeight) == 80);
static_assert(offsetof(FWindowBlockC64UpsampleFp16Parameters, ReservedViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_upsample_fp16(FWindowBlockC64UpsampleFp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowBlockC64UpsampleFp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights, g_Residual;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[3], ReservedViewPointer;
	int32_t ReservedViewHeight, ReservedViewWidth;
};

static_assert(sizeof(FWindowBlockC64UpsampleFp8Parameters) == 88 &&
			  alignof(FWindowBlockC64UpsampleFp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowBlockC64UpsampleFp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowBlockC64UpsampleFp8Parameters>);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, g_Residual) == 24);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, Height) == 32);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, Width) == 36);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, OriginX) == 40);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, OriginY) == 44);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, ReservedTailPadding) == 48);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, ReservedViewPointer) == 72);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, ReservedViewHeight) == 80);
static_assert(offsetof(FWindowBlockC64UpsampleFp8Parameters, ReservedViewWidth) == 84);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_block_c64_upsample_fp8(FWindowBlockC64UpsampleFp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Attention and projections
// -----------------------------------------------------------------------------

struct alignas(8) FGlobalAttentionChainedC1024Fp16Parameters
{
	uint64_t g_Query, g_Key, g_Value, g_Output, ReservedTailPadding, g_PredecessorCounters,
		g_CompletionCounters;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalAttentionChainedC1024Fp16Parameters) == 64 &&
			  alignof(FGlobalAttentionChainedC1024Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalAttentionChainedC1024Fp16Parameters> &&
			  std::is_trivially_copyable_v<FGlobalAttentionChainedC1024Fp16Parameters>);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, g_Query) == 0);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, g_Key) == 8);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, g_Value) == 16);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, g_Output) == 24);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, ReservedTailPadding) == 32);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, g_PredecessorCounters) == 40);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, g_CompletionCounters) == 48);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, BatchCount) == 56);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp16Parameters, TokensPerBatch) == 60);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_attention_chained_c1024_fp16(FGlobalAttentionChainedC1024Fp16Parameters r_Parameters);
#endif

struct alignas(8) FGlobalAttentionChainedC1024Fp8Parameters
{
	uint64_t g_Query, g_Key, g_Value, g_Output, ReservedTailPadding, g_PredecessorCounters,
		g_CompletionCounters;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalAttentionChainedC1024Fp8Parameters) == 64 &&
			  alignof(FGlobalAttentionChainedC1024Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalAttentionChainedC1024Fp8Parameters> &&
			  std::is_trivially_copyable_v<FGlobalAttentionChainedC1024Fp8Parameters>);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, g_Query) == 0);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, g_Key) == 8);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, g_Value) == 16);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, g_Output) == 24);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, ReservedTailPadding) == 32);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, g_PredecessorCounters) == 40);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, g_CompletionCounters) == 48);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, BatchCount) == 56);
static_assert(offsetof(FGlobalAttentionChainedC1024Fp8Parameters, TokensPerBatch) == 60);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_attention_chained_c1024_fp8(FGlobalAttentionChainedC1024Fp8Parameters r_Parameters);
#endif

struct alignas(8) FGlobalProjectionC1024Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalProjectionC1024Fp16Parameters) == 72 &&
			  alignof(FGlobalProjectionC1024Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalProjectionC1024Fp16Parameters> &&
			  std::is_trivially_copyable_v<FGlobalProjectionC1024Fp16Parameters>);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, g_SplitCounters) == 32);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, BatchCount) == 64);
static_assert(offsetof(FGlobalProjectionC1024Fp16Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_projection_c1024_fp16(FGlobalProjectionC1024Fp16Parameters r_Parameters);
#endif

struct alignas(8) FGlobalProjectionC1024Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalProjectionC1024Fp8Parameters) == 72 &&
			  alignof(FGlobalProjectionC1024Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalProjectionC1024Fp8Parameters> &&
			  std::is_trivially_copyable_v<FGlobalProjectionC1024Fp8Parameters>);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, g_SplitCounters) == 32);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, BatchCount) == 64);
static_assert(offsetof(FGlobalProjectionC1024Fp8Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_projection_c1024_fp8(FGlobalProjectionC1024Fp8Parameters r_Parameters);
#endif

struct alignas(8) FGlobalQkvC1024Fp16Parameters
{
	uint64_t g_Input, g_Query, g_Key, g_Value, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalQkvC1024Fp16Parameters) == 80 && alignof(FGlobalQkvC1024Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalQkvC1024Fp16Parameters> &&
			  std::is_trivially_copyable_v<FGlobalQkvC1024Fp16Parameters>);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_Query) == 8);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_Key) == 16);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_Value) == 24);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_PackedWeights) == 32);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_SplitCounters) == 40);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, g_SplitAccumulator) == 48);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, ReservedLeadingPadding) == 56);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, ReservedTrailingPadding) == 64);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, BatchCount) == 72);
static_assert(offsetof(FGlobalQkvC1024Fp16Parameters, TokensPerBatch) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_qkv_c1024_fp16(FGlobalQkvC1024Fp16Parameters r_Parameters);
#endif

struct alignas(8) FGlobalQkvC1024Fp8Parameters
{
	uint64_t g_Input, g_Query, g_Key, g_Value, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalQkvC1024Fp8Parameters) == 80 && alignof(FGlobalQkvC1024Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalQkvC1024Fp8Parameters> &&
			  std::is_trivially_copyable_v<FGlobalQkvC1024Fp8Parameters>);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_Query) == 8);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_Key) == 16);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_Value) == 24);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_PackedWeights) == 32);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_SplitCounters) == 40);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, g_SplitAccumulator) == 48);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, ReservedLeadingPadding) == 56);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, ReservedTrailingPadding) == 64);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, BatchCount) == 72);
static_assert(offsetof(FGlobalQkvC1024Fp8Parameters, TokensPerBatch) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_qkv_c1024_fp8(FGlobalQkvC1024Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowAttentionProjectionC512Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(FWindowAttentionProjectionC512Fp16Parameters) == 72 &&
			  alignof(FWindowAttentionProjectionC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowAttentionProjectionC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowAttentionProjectionC512Fp16Parameters>);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowAttentionProjectionC512Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
window_attention_projection_c512_fp16(FWindowAttentionProjectionC512Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowAttentionProjectionC512Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(FWindowAttentionProjectionC512Fp8Parameters) == 72 &&
			  alignof(FWindowAttentionProjectionC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowAttentionProjectionC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowAttentionProjectionC512Fp8Parameters>);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowAttentionProjectionC512Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
window_attention_projection_c512_fp8(FWindowAttentionProjectionC512Fp8Parameters r_Parameters);
#endif

// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) FWindowAttentionProjectionOutputViewC512Fp16Parameters
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint32_t Height;
	uint32_t Width;
	uint8_t ReservedViewPadding[32];
};

static_assert(sizeof(FWindowAttentionProjectionOutputViewC512Fp16Parameters) == 72 &&
			  alignof(FWindowAttentionProjectionOutputViewC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowAttentionProjectionOutputViewC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowAttentionProjectionOutputViewC512Fp16Parameters>);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp16Parameters, ReservedViewPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_attention_projection_output_view_c512_fp16(
	FWindowAttentionProjectionOutputViewC512Fp16Parameters r_Parameters);
#endif

// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) FWindowAttentionProjectionOutputViewC512Fp8Parameters
{
	uint64_t g_Input;
	uint64_t g_Residual;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint32_t Height;
	uint32_t Width;
	uint8_t ReservedViewPadding[32];
};

static_assert(sizeof(FWindowAttentionProjectionOutputViewC512Fp8Parameters) == 72 &&
			  alignof(FWindowAttentionProjectionOutputViewC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowAttentionProjectionOutputViewC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowAttentionProjectionOutputViewC512Fp8Parameters>);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowAttentionProjectionOutputViewC512Fp8Parameters, ReservedViewPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_attention_projection_output_view_c512_fp8(
	FWindowAttentionProjectionOutputViewC512Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowQkvC512Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(FWindowQkvC512Fp16Parameters) == 56 && alignof(FWindowQkvC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowQkvC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowQkvC512Fp16Parameters>);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, Height) == 24);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, Width) == 28);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowQkvC512Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_qkv_c512_fp16(FWindowQkvC512Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowQkvC512Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(FWindowQkvC512Fp8Parameters) == 56 && alignof(FWindowQkvC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowQkvC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowQkvC512Fp8Parameters>);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, Height) == 24);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, Width) == 28);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowQkvC512Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_qkv_c512_fp8(FWindowQkvC512Fp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Feed-forward blocks
// -----------------------------------------------------------------------------

struct alignas(8) FGlobalFfnContractC1024Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalFfnContractC1024Fp16Parameters) == 72 &&
			  alignof(FGlobalFfnContractC1024Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalFfnContractC1024Fp16Parameters> &&
			  std::is_trivially_copyable_v<FGlobalFfnContractC1024Fp16Parameters>);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, g_SplitCounters) == 32);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, BatchCount) == 64);
static_assert(offsetof(FGlobalFfnContractC1024Fp16Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_ffn_contract_c1024_fp16(FGlobalFfnContractC1024Fp16Parameters r_Parameters);
#endif

struct alignas(8) FGlobalFfnContractC1024Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalFfnContractC1024Fp8Parameters) == 72 &&
			  alignof(FGlobalFfnContractC1024Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalFfnContractC1024Fp8Parameters> &&
			  std::is_trivially_copyable_v<FGlobalFfnContractC1024Fp8Parameters>);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, g_SplitCounters) == 32);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, BatchCount) == 64);
static_assert(offsetof(FGlobalFfnContractC1024Fp8Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_ffn_contract_c1024_fp8(FGlobalFfnContractC1024Fp8Parameters r_Parameters);
#endif

struct alignas(8) FGlobalFfnExpandC1024Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalFfnExpandC1024Fp16Parameters) == 72 &&
			  alignof(FGlobalFfnExpandC1024Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalFfnExpandC1024Fp16Parameters> &&
			  std::is_trivially_copyable_v<FGlobalFfnExpandC1024Fp16Parameters>);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, g_SplitCounters) == 32);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, BatchCount) == 64);
static_assert(offsetof(FGlobalFfnExpandC1024Fp16Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_ffn_expand_c1024_fp16(FGlobalFfnExpandC1024Fp16Parameters r_Parameters);
#endif

struct alignas(8) FGlobalFfnExpandC1024Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights, g_SplitCounters, g_SplitAccumulator,
		ReservedLeadingPadding, ReservedTrailingPadding;
	int32_t BatchCount, TokensPerBatch;
};

static_assert(sizeof(FGlobalFfnExpandC1024Fp8Parameters) == 72 &&
			  alignof(FGlobalFfnExpandC1024Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FGlobalFfnExpandC1024Fp8Parameters> &&
			  std::is_trivially_copyable_v<FGlobalFfnExpandC1024Fp8Parameters>);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, g_SplitCounters) == 32);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, g_SplitAccumulator) == 40);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, ReservedLeadingPadding) == 48);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, ReservedTrailingPadding) == 56);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, BatchCount) == 64);
static_assert(offsetof(FGlobalFfnExpandC1024Fp8Parameters, TokensPerBatch) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void global_ffn_expand_c1024_fp8(FGlobalFfnExpandC1024Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnC512Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(FWindowFfnC512Fp16Parameters) == 56 && alignof(FWindowFfnC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnC512Fp16Parameters>);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, Height) == 24);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, Width) == 28);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowFfnC512Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_ffn_c512_fp16(FWindowFfnC512Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnC512Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(FWindowFfnC512Fp8Parameters) == 56 && alignof(FWindowFfnC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnC512Fp8Parameters>);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, Height) == 24);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, Width) == 28);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowFfnC512Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_ffn_c512_fp8(FWindowFfnC512Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnInputViewC512Fp16Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(FWindowFfnInputViewC512Fp16Parameters) == 56 &&
			  alignof(FWindowFfnInputViewC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnInputViewC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnInputViewC512Fp16Parameters>);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, Height) == 24);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, Width) == 28);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, OriginX) == 32);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, OriginY) == 36);
static_assert(offsetof(FWindowFfnInputViewC512Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_ffn_input_view_c512_fp16(FWindowFfnInputViewC512Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnInputViewC512Fp8Parameters
{
	uint64_t g_Input, g_Output, g_PackedWeights;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t ReservedTailPadding[2];
};

static_assert(sizeof(FWindowFfnInputViewC512Fp8Parameters) == 56 &&
			  alignof(FWindowFfnInputViewC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnInputViewC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnInputViewC512Fp8Parameters>);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, Height) == 24);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, Width) == 28);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, OriginX) == 32);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, OriginY) == 36);
static_assert(offsetof(FWindowFfnInputViewC512Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_ffn_input_view_c512_fp8(FWindowFfnInputViewC512Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnProjectionC512Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(FWindowFfnProjectionC512Fp16Parameters) == 72 &&
			  alignof(FWindowFfnProjectionC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnProjectionC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnProjectionC512Fp16Parameters>);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowFfnProjectionC512Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_ffn_projection_c512_fp16(FWindowFfnProjectionC512Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnProjectionC512Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(FWindowFfnProjectionC512Fp8Parameters) == 72 &&
			  alignof(FWindowFfnProjectionC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnProjectionC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnProjectionC512Fp8Parameters>);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowFfnProjectionC512Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void window_ffn_projection_c512_fp8(FWindowFfnProjectionC512Fp8Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnProjectionInputViewC512Fp16Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(FWindowFfnProjectionInputViewC512Fp16Parameters) == 72 &&
			  alignof(FWindowFfnProjectionInputViewC512Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnProjectionInputViewC512Fp16Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnProjectionInputViewC512Fp16Parameters>);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, g_Output) == 16);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, Height) == 32);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, Width) == 36);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp16Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
window_ffn_projection_input_view_c512_fp16(FWindowFfnProjectionInputViewC512Fp16Parameters r_Parameters);
#endif

struct alignas(8) FWindowFfnProjectionInputViewC512Fp8Parameters
{
	uint64_t g_Input, g_Residual, g_Output, g_PackedWeights;
	int32_t Height, Width;
	uint64_t ReservedTailPadding[4];
};

static_assert(sizeof(FWindowFfnProjectionInputViewC512Fp8Parameters) == 72 &&
			  alignof(FWindowFfnProjectionInputViewC512Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FWindowFfnProjectionInputViewC512Fp8Parameters> &&
			  std::is_trivially_copyable_v<FWindowFfnProjectionInputViewC512Fp8Parameters>);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, g_Residual) == 8);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, g_Output) == 16);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, Height) == 32);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, Width) == 36);
static_assert(offsetof(FWindowFfnProjectionInputViewC512Fp8Parameters, ReservedTailPadding) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
window_ffn_projection_input_view_c512_fp8(FWindowFfnProjectionInputViewC512Fp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Channel projection
// -----------------------------------------------------------------------------

// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) FChannelProjectionC512ToC1024Fp16Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint8_t ReservedPointerPadding[8];
	uint32_t Height;
	uint32_t Width;
};

static_assert(sizeof(FChannelProjectionC512ToC1024Fp16Parameters) == 40 &&
			  alignof(FChannelProjectionC512ToC1024Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FChannelProjectionC512ToC1024Fp16Parameters> &&
			  std::is_trivially_copyable_v<FChannelProjectionC512ToC1024Fp16Parameters>);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp16Parameters, g_Output) == 8);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp16Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp16Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp16Parameters, Height) == 32);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp16Parameters, Width) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void
channel_projection_c512_to_c1024_fp16(FChannelProjectionC512ToC1024Fp16Parameters r_Parameters);
#endif

// Tensor roles follow the loads, residual merge, and publication in the shared algorithm.
struct alignas(8) FChannelProjectionC512ToC1024Fp8Parameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	uint64_t g_PackedWeights;
	uint8_t ReservedPointerPadding[8];
	uint32_t Height;
	uint32_t Width;
};

static_assert(sizeof(FChannelProjectionC512ToC1024Fp8Parameters) == 40 &&
			  alignof(FChannelProjectionC512ToC1024Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FChannelProjectionC512ToC1024Fp8Parameters> &&
			  std::is_trivially_copyable_v<FChannelProjectionC512ToC1024Fp8Parameters>);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp8Parameters, g_Output) == 8);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp8Parameters, g_PackedWeights) == 16);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp8Parameters, ReservedPointerPadding) == 24);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp8Parameters, Height) == 32);
static_assert(offsetof(FChannelProjectionC512ToC1024Fp8Parameters, Width) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void channel_projection_c512_to_c1024_fp8(FChannelProjectionC512ToC1024Fp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Input and output transforms
// -----------------------------------------------------------------------------

// Each named entry record shares the recovered frontend field layout.
struct alignas(8) FInputPreprocessWindowC32Fp16Parameters : FPreprocessParameters
{
};

static_assert(sizeof(FInputPreprocessWindowC32Fp16Parameters) == 264 &&
			  alignof(FInputPreprocessWindowC32Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FInputPreprocessWindowC32Fp16Parameters> &&
			  std::is_trivially_copyable_v<FInputPreprocessWindowC32Fp16Parameters>);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_MotionTexture) == 16);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_DepthTexture) == 24);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, HistoryTransform) == 40);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, MotionTransform) == 64);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, DepthTransform) == 88);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, ConditioningTransform) == 112);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, CurrentTransform) == 136);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, bConditioningOverride) == 192);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, r_ColorScale) == 196);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, NoiseSeed) == 200);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, ReservedAlignment) == 204);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, ValidHeight) == 208);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, ValidWidth) == 212);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_Output) == 216);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_PackedWeights) == 224);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, FullHeight) == 240);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, FullWidth) == 244);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, g_PooledOutput) == 248);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, PooledHeight) == 256);
static_assert(offsetof(FInputPreprocessWindowC32Fp16Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void input_preprocess_window_c32_fp16(FInputPreprocessWindowC32Fp16Parameters r_Parameters);
#endif

// Each named entry record shares the recovered frontend field layout.
struct alignas(8) FInputPreprocessWindowC32Fp8Parameters : FPreprocessParameters
{
};

static_assert(sizeof(FInputPreprocessWindowC32Fp8Parameters) == 264 &&
			  alignof(FInputPreprocessWindowC32Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FInputPreprocessWindowC32Fp8Parameters> &&
			  std::is_trivially_copyable_v<FInputPreprocessWindowC32Fp8Parameters>);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_CurrentTexture) == 0);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_HistoryTexture) == 8);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_MotionTexture) == 16);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_DepthTexture) == 24);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_ConditioningTexture) == 32);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, HistoryTransform) == 40);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, MotionTransform) == 64);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, DepthTransform) == 88);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, ConditioningTransform) == 112);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, CurrentTransform) == 136);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_MotionScaleX) == 160);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_MotionScaleY) == 164);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, bPreferGreaterDepth) == 168);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_ConditioningGreen) == 172);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_ConditioningBlue) == 176);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_ConstantConditioning) == 180);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_ConditioningOverrideGreen) == 184);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_ConditioningOverrideBlue) == 188);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, bConditioningOverride) == 192);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, r_ColorScale) == 196);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, NoiseSeed) == 200);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, ReservedAlignment) == 204);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, ValidHeight) == 208);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, ValidWidth) == 212);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_Output) == 216);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_PackedWeights) == 224);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, ReservedOutputPointer) == 232);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, FullHeight) == 240);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, FullWidth) == 244);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, g_PooledOutput) == 248);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, PooledHeight) == 256);
static_assert(offsetof(FInputPreprocessWindowC32Fp8Parameters, PooledWidth) == 260);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void input_preprocess_window_c32_fp8(FInputPreprocessWindowC32Fp8Parameters r_Parameters);
#endif

// Each named entry record shares the recovered frontend field layout.
struct alignas(8) FOutputWindowPostprocessC32Fp16Parameters : FPostprocessParameters
{
};

static_assert(sizeof(FOutputWindowPostprocessC32Fp16Parameters) == 184 &&
			  alignof(FOutputWindowPostprocessC32Fp16Parameters) == 8);
static_assert(std::is_standard_layout_v<FOutputWindowPostprocessC32Fp16Parameters> &&
			  std::is_trivially_copyable_v<FOutputWindowPostprocessC32Fp16Parameters>);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_Input) == 0);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_Adapter) == 8);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_OutputSurface) == 16);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, Height) == 32);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, Width) == 36);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, OriginX) == 40);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, OriginY) == 44);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, r_OutputScale) == 48);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, bDisplayOutput) == 52);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_ColorTexture) == 56);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, ColorTransform) == 64);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_HistoryTexture) == 88);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_MotionTexture) == 96);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, g_BlendScale) == 104);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, bApplyMotion) == 112);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, HistoryTransform) == 116);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, MotionTransform) == 140);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, r_MotionScaleX) == 164);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, r_MotionScaleY) == 168);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, ValidWidth) == 172);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, ValidHeight) == 176);
static_assert(offsetof(FOutputWindowPostprocessC32Fp16Parameters, ReservedPadding) == 180);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void output_window_postprocess_c32_fp16(FOutputWindowPostprocessC32Fp16Parameters r_Parameters);
#endif

// Each named entry record shares the recovered frontend field layout.
struct alignas(8) FOutputWindowPostprocessC32Fp8Parameters : FPostprocessParameters
{
};

static_assert(sizeof(FOutputWindowPostprocessC32Fp8Parameters) == 184 &&
			  alignof(FOutputWindowPostprocessC32Fp8Parameters) == 8);
static_assert(std::is_standard_layout_v<FOutputWindowPostprocessC32Fp8Parameters> &&
			  std::is_trivially_copyable_v<FOutputWindowPostprocessC32Fp8Parameters>);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_Input) == 0);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_Adapter) == 8);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_OutputSurface) == 16);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_PackedWeights) == 24);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, Height) == 32);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, Width) == 36);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, OriginX) == 40);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, OriginY) == 44);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, r_OutputScale) == 48);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, bDisplayOutput) == 52);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_ColorTexture) == 56);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, ColorTransform) == 64);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_HistoryTexture) == 88);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_MotionTexture) == 96);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, g_BlendScale) == 104);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, bApplyMotion) == 112);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, HistoryTransform) == 116);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, MotionTransform) == 140);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, r_MotionScaleX) == 164);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, r_MotionScaleY) == 168);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, ValidWidth) == 172);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, ValidHeight) == 176);
static_assert(offsetof(FOutputWindowPostprocessC32Fp8Parameters, ReservedPadding) == 180);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
extern "C" void output_window_postprocess_c32_fp8(FOutputWindowPostprocessC32Fp8Parameters r_Parameters);
#endif

// -----------------------------------------------------------------------------
// Layout copies and completion-counter reset
// -----------------------------------------------------------------------------
struct alignas(8) FGlobalRepackParameters
{
	uint64_t g_Input;
	uint64_t g_Output;
	int32_t Height;
	int32_t Width;
};

static_assert(sizeof(FGlobalRepackParameters) == 24 && alignof(FGlobalRepackParameters) == 8);
static_assert(offsetof(FGlobalRepackParameters, g_Input) == 0 &&
			  offsetof(FGlobalRepackParameters, g_Output) == 8);
static_assert(offsetof(FGlobalRepackParameters, Height) == 16 &&
			  offsetof(FGlobalRepackParameters, Width) == 20);

struct alignas(8) FCompletionCounterParameters
{
	uint64_t g_Counters;
	int32_t CounterCount;
	int32_t ReservedPadding;
};

static_assert(sizeof(FCompletionCounterParameters) == 16 && alignof(FCompletionCounterParameters) == 8);
static_assert(std::is_standard_layout_v<FCompletionCounterParameters> &&
			  std::is_trivially_copyable_v<FCompletionCounterParameters>);
static_assert(offsetof(FCompletionCounterParameters, g_Counters) == 0 &&
			  offsetof(FCompletionCounterParameters, CounterCount) == 8);
static_assert(offsetof(FCompletionCounterParameters, ReservedPadding) == 12);
// Repack: 1024 channels, H/W nonnegative multiples of4 <=16384; pad32 FP8,
// pad16 Half. words/token=256/512; padded_tokens*words <= INT32_MAX/2.
// Grid=(padded_tokens*words/256,1,1), block=(256,1,1), dynamic shared=0.
// Clear: count is int32 WORDS; grid=(ceil(count/256),1,1), block=(256,1,1).
// Zero extents return without launch. Clear writes -1, not zero.
// Same-stream ordering and disjoint repack buffers are caller obligations.

#if !defined(__CUDACC__)
extern "C" void repack_2d_to_1d_c1024_fp8(FGlobalRepackParameters r_Parameters);
#endif

#if !defined(__CUDACC__)
extern "C" void repack_1d_to_2d_c1024_fp8(FGlobalRepackParameters r_Parameters);
#endif

#if !defined(__CUDACC__)
extern "C" void repack_2d_to_1d_c1024_fp16(FGlobalRepackParameters r_Parameters);
#endif

#if !defined(__CUDACC__)
extern "C" void repack_1d_to_2d_c1024_fp16(FGlobalRepackParameters r_Parameters);
#endif

#if !defined(__CUDACC__)
extern "C" void completion_counter_clear(FCompletionCounterParameters r_Parameters);
#endif
