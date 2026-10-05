#pragma once
#include <cstdint>
#include <cstddef>

// Exact accepted-source ABI declarations. No device bodies or helpers.
namespace dlssnr::reconstructed::window_block_c32_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[7]; // Native ordinary C32 leaves bytes40..95 unused.
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);
void window_block_c32_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_fp16

namespace dlssnr::reconstructed::window_block_c32_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved40[3], g_Extra64;
	int32_t Aux72, Aux76;
	uint64_t Extra80;
	int32_t Aux88, Aux92;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28 &&
			  offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved40) == 40 && offsetof(Parameters, g_Extra64) == 64);
static_assert(offsetof(Parameters, Aux72) == 72 && offsetof(Parameters, Aux76) == 76 &&
			  offsetof(Parameters, Extra80) == 80);
static_assert(offsetof(Parameters, Aux88) == 88 && offsetof(Parameters, Aux92) == 92);
void window_block_c32_downsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp16

namespace dlssnr::reconstructed::window_block_c32_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved40[3], g_Extra64;
	int32_t Aux72, Aux76;
	uint64_t Extra80;
	int32_t Aux88, Aux92;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28 &&
			  offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved40) == 40 && offsetof(Parameters, g_Extra64) == 64);
static_assert(offsetof(Parameters, Aux72) == 72 && offsetof(Parameters, Aux76) == 76 &&
			  offsetof(Parameters, Extra80) == 80);
static_assert(offsetof(Parameters, Aux88) == 88 && offsetof(Parameters, Aux92) == 92);
void window_block_c32_downsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp8

namespace dlssnr::reconstructed::window_block_c32_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[7]; // Native ordinary C32 leaves bytes40..95 unused.
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);
void window_block_c32_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_fp8

namespace dlssnr::reconstructed::window_block_c32_input_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved40[3], Extra64;
	int32_t Aux72, Aux76;
	uint64_t Extra80;
	int32_t Aux88, Aux92;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28 &&
			  offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved40) == 40 && offsetof(Parameters, Extra64) == 64);
static_assert(offsetof(Parameters, Aux72) == 72 && offsetof(Parameters, Aux76) == 76 &&
			  offsetof(Parameters, Extra80) == 80);
static_assert(offsetof(Parameters, Aux88) == 88 && offsetof(Parameters, Aux92) == 92);
void window_block_c32_input_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp16

namespace dlssnr::reconstructed::window_block_c32_input_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved40[3], Extra64;
	int32_t Aux72, Aux76;
	uint64_t Extra80;
	int32_t Aux88, Aux92;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28 &&
			  offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved40) == 40 && offsetof(Parameters, Extra64) == 64);
static_assert(offsetof(Parameters, Aux72) == 72 && offsetof(Parameters, Aux76) == 76 &&
			  offsetof(Parameters, Extra80) == 80);
static_assert(offsetof(Parameters, Aux88) == 88 && offsetof(Parameters, Aux92) == 92);
void window_block_c32_input_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp8

namespace dlssnr::reconstructed::window_block_c32_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved40[3], Extra64;
	int32_t Aux72, Aux76;
	uint64_t g_Extra80;
	int32_t Aux88, Aux92;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28 &&
			  offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved40) == 40 && offsetof(Parameters, Extra64) == 64);
static_assert(offsetof(Parameters, Aux72) == 72 && offsetof(Parameters, Aux76) == 76 &&
			  offsetof(Parameters, g_Extra80) == 80);
static_assert(offsetof(Parameters, Aux88) == 88 && offsetof(Parameters, Aux92) == 92);
void window_block_c32_upsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp16

namespace dlssnr::reconstructed::window_block_c32_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved40[3], Extra64;
	int32_t Aux72, Aux76;
	uint64_t g_Extra80;
	int32_t Aux88, Aux92;
};

static_assert(sizeof(Parameters) == 96 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28 &&
			  offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved40) == 40 && offsetof(Parameters, Extra64) == 64);
static_assert(offsetof(Parameters, Aux72) == 72 && offsetof(Parameters, Aux76) == 76 &&
			  offsetof(Parameters, g_Extra80) == 80);
static_assert(offsetof(Parameters, Aux88) == 88 && offsetof(Parameters, Aux92) == 92);
void window_block_c32_upsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp8

namespace dlssnr::reconstructed::window_block_c64_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c64_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_fp16

namespace dlssnr::reconstructed::window_block_c64_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], g_Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, g_Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_downsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp16

namespace dlssnr::reconstructed::window_block_c64_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], g_Down;
	int32_t DownHeight, DownWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, g_Down) == 72 && offsetof(Parameters, DownHeight) == 80 &&
			  offsetof(Parameters, DownWidth) == 84);
void window_block_c64_downsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp8

namespace dlssnr::reconstructed::window_block_c64_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c64_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_fp8

namespace dlssnr::reconstructed::window_block_c64_input_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_input_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_input_view_fp16

namespace dlssnr::reconstructed::window_block_c64_input_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_input_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_input_view_fp8

namespace dlssnr::reconstructed::window_block_c64_output_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_output_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_output_view_fp16

namespace dlssnr::reconstructed::window_block_c64_output_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_output_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_output_view_fp8

namespace dlssnr::reconstructed::window_block_c64_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, g_Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_upsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp16

namespace dlssnr::reconstructed::window_block_c64_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], Extra;
	int32_t AuxHeight, AuxWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16 && offsetof(Parameters, g_Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Extra) == 72 && offsetof(Parameters, AuxHeight) == 80 &&
			  offsetof(Parameters, AuxWidth) == 84);
void window_block_c64_upsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp8

namespace dlssnr::reconstructed::window_block_c128_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c128_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_fp16

namespace dlssnr::reconstructed::window_block_c128_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], g_Down;
	int32_t DownHeight, DownWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, g_Down) == 72 && offsetof(Parameters, DownHeight) == 80 &&
			  offsetof(Parameters, DownWidth) == 84);
void window_block_c128_downsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp16

namespace dlssnr::reconstructed::window_block_c128_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], g_Down;
	int32_t DownHeight, DownWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, g_Down) == 72 && offsetof(Parameters, DownHeight) == 80 &&
			  offsetof(Parameters, DownWidth) == 84);
void window_block_c128_downsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp8

namespace dlssnr::reconstructed::window_block_c128_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c128_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_fp8

namespace dlssnr::reconstructed::window_block_c128_input_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c128_input_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp16

namespace dlssnr::reconstructed::window_block_c128_input_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c128_input_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp8

namespace dlssnr::reconstructed::window_block_c128_output_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c128_output_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp16

namespace dlssnr::reconstructed::window_block_c128_output_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c128_output_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp8

namespace dlssnr::reconstructed::window_block_c128_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, g_Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c128_upsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp16

namespace dlssnr::reconstructed::window_block_c128_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, g_Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c128_upsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp8

namespace dlssnr::reconstructed::window_block_c256_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c256_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_fp16

namespace dlssnr::reconstructed::window_block_c256_downsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], g_Down;
	int32_t DownHeight, DownWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, g_Down) == 72 && offsetof(Parameters, DownHeight) == 80 &&
			  offsetof(Parameters, DownWidth) == 84);
void window_block_c256_downsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp16

namespace dlssnr::reconstructed::window_block_c256_downsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[3], g_Down;
	int32_t DownHeight, DownWidth;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, g_Down) == 72 && offsetof(Parameters, DownHeight) == 80 &&
			  offsetof(Parameters, DownWidth) == 84);
void window_block_c256_downsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp8

namespace dlssnr::reconstructed::window_block_c256_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved0;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c256_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_fp8

namespace dlssnr::reconstructed::window_block_c256_input_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c256_input_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp16

namespace dlssnr::reconstructed::window_block_c256_input_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c256_input_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp8

namespace dlssnr::reconstructed::window_block_c256_output_view_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c256_output_view_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp16

namespace dlssnr::reconstructed::window_block_c256_output_view_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, Reserved24;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved48[4];
	int32_t Aux80, Aux84;
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Reserved24) == 24 && offsetof(Parameters, Height) == 32 &&
			  offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44 &&
			  offsetof(Parameters, Reserved48) == 48);
static_assert(offsetof(Parameters, Aux80) == 80 && offsetof(Parameters, Aux84) == 84);
void window_block_c256_output_view_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp8

namespace dlssnr::reconstructed::window_block_c256_upsample_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, g_Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c256_upsample_fp16(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp16

namespace dlssnr::reconstructed::window_block_c256_upsample_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record, g_Skip;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[5]; // Original ordinary entry leaves bytes48..87 unused.
};

static_assert(sizeof(Parameters) == 88 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, g_Skip) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36);
static_assert(offsetof(Parameters, OriginX) == 40 && offsetof(Parameters, OriginY) == 44);
static_assert(offsetof(Parameters, Reserved) == 48);
void window_block_c256_upsample_fp8(Parameters ParameterBlock);
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp8
