#pragma once
#include <cstddef>
#include <cstdint>

// The launch records are shared by host launchers and CUDA implementations.
// Keep each named Parameters type: its namespace is part of the exported CUDA
// entry signature, even when another entry has an identical field layout.
// Every launch passes one pointer to an entire zero-initialized record.
// Static assertions preserve the recovered DLL parameter offsets and extents.

// -----------------------------------------------------------------------------
// Window blocks and physical views
// -----------------------------------------------------------------------------

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_fp16

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_fp8

namespace dlssnr::reconstructed::window_block_c128_input_view_fp16
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_input_view_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp16

namespace dlssnr::reconstructed::window_block_c128_input_view_fp8
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_input_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_input_view_fp8

namespace dlssnr::reconstructed::window_block_c128_output_view_fp16
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_output_view_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp16

namespace dlssnr::reconstructed::window_block_c128_output_view_fp8
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_output_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_output_view_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_fp16

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_fp8

namespace dlssnr::reconstructed::window_block_c256_input_view_fp16
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_input_view_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp16

namespace dlssnr::reconstructed::window_block_c256_input_view_fp8
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_input_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_input_view_fp8

namespace dlssnr::reconstructed::window_block_c256_output_view_fp16
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_output_view_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp16

namespace dlssnr::reconstructed::window_block_c256_output_view_fp8
{
// Exact 88-byte native view ABI. Extra dimensions retain offset names until
// the separate physical host contract is proved for each view and precision.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_output_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_output_view_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_fp16

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_fp8

namespace dlssnr::reconstructed::window_block_c32_input_view_fp16
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_input_view_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp16

namespace dlssnr::reconstructed::window_block_c32_input_view_fp8
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_input_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_input_view_fp8

namespace dlssnr::reconstructed::window_block_c32_output_view_fp16
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_output_view_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_output_view_fp16

namespace dlssnr::reconstructed::window_block_c32_output_view_fp8
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_output_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_output_view_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_fp16

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_fp8(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_input_view_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_input_view_fp8(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_output_view_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_output_view_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_output_view_fp8

// -----------------------------------------------------------------------------
// Downsampling
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp16
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[66];
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_downsample_c32_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp16

namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp8
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[66];
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_downsample_c32_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_downsample_c32_fp8

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint64_t g_Pointer32;
	uint8_t Reserved40[24];
	uint32_t Scalar64;
	uint32_t Scalar68;
	uint32_t Scalar72;
	uint32_t Scalar76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, g_Pointer32) == 32);
static_assert(offsetof(Parameters, Scalar64) == 64);
static_assert(offsetof(Parameters, Scalar68) == 68);
static_assert(offsetof(Parameters, Scalar72) == 72);
static_assert(offsetof(Parameters, Scalar76) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_pool_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint64_t g_Pointer32;
	uint8_t Reserved40[24];
	uint32_t Scalar64;
	uint32_t Scalar68;
	uint32_t Scalar72;
	uint32_t Scalar76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, g_Pointer32) == 32);
static_assert(offsetof(Parameters, Scalar64) == 64);
static_assert(offsetof(Parameters, Scalar68) == 68);
static_assert(offsetof(Parameters, Scalar72) == 72);
static_assert(offsetof(Parameters, Scalar76) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_pool_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_pool_c512_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_downsample_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_downsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_downsample_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_downsample_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_downsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_downsample_fp8

namespace dlssnr::reconstructed::window_block_c32_downsample_fp16
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_downsample_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp16

namespace dlssnr::reconstructed::window_block_c32_downsample_fp8
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_downsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_downsample_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_downsample_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_downsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_downsample_fp8

// -----------------------------------------------------------------------------
// Upsampling
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16
{
// Field names retain byte offsets until the independent host/pilot audit.
// In particular, Half and FP8 load different counter/scratch pointer slots.
struct alignas(8) Parameters
{
	uint64_t g_P0, g_P8, g_P16, g_P24, g_P32, P40, P48, g_P56;
	int32_t I64, I68, I72, I76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_P0) == 0 && offsetof(Parameters, g_P8) == 8);
static_assert(offsetof(Parameters, g_P16) == 16 && offsetof(Parameters, g_P24) == 24);
static_assert(offsetof(Parameters, g_P32) == 32 && offsetof(Parameters, P40) == 40);
static_assert(offsetof(Parameters, P48) == 48 && offsetof(Parameters, g_P56) == 56);
static_assert(offsetof(Parameters, I64) == 64 && offsetof(Parameters, I68) == 68);
static_assert(offsetof(Parameters, I72) == 72 && offsetof(Parameters, I76) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void decoder_upsample_c1024_to_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp16

namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8
{
// Field names retain byte offsets until the independent host/pilot audit.
// In particular, Half and FP8 load different counter/scratch pointer slots.
struct alignas(8) Parameters
{
	uint64_t g_P0, g_P8, g_P16, P24, g_P32, P40, g_P48, g_P56;
	int32_t I64, I68, I72, I76;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_P0) == 0 && offsetof(Parameters, g_P8) == 8);
static_assert(offsetof(Parameters, g_P16) == 16 && offsetof(Parameters, P24) == 24);
static_assert(offsetof(Parameters, g_P32) == 32 && offsetof(Parameters, P40) == 40);
static_assert(offsetof(Parameters, g_P48) == 48 && offsetof(Parameters, g_P56) == 56);
static_assert(offsetof(Parameters, I64) == 64 && offsetof(Parameters, I68) == 68);
static_assert(offsetof(Parameters, I72) == 72 && offsetof(Parameters, I76) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void decoder_upsample_c1024_to_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::decoder_upsample_c1024_to_c512_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_upsample_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c128_upsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c128_upsample_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_upsample_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c256_upsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c256_upsample_fp8

namespace dlssnr::reconstructed::window_block_c32_upsample_fp16
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_upsample_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp16

namespace dlssnr::reconstructed::window_block_c32_upsample_fp8
{
// Native C32 transition ABI. Offset-named extra fields deliberately avoid
// importing the different C64/C128/C256 transition host interpretation.
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c32_upsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c32_upsample_fp8

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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_upsample_fp16(Parameters ParameterBlock);
#endif
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

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_block_c64_upsample_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_block_c64_upsample_fp8

// -----------------------------------------------------------------------------
// Attention and projections
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::global_attention_chained_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_Q, g_K, g_V, g_High, Reserved, g_PredecessorCounter, g_CompletionCounter;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 64 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Q) == 0 && offsetof(Parameters, g_K) == 8 &&
			  offsetof(Parameters, g_V) == 16);
static_assert(offsetof(Parameters, g_High) == 24 && offsetof(Parameters, Reserved) == 32);
static_assert(offsetof(Parameters, g_PredecessorCounter) == 40 &&
			  offsetof(Parameters, g_CompletionCounter) == 48);
static_assert(offsetof(Parameters, Batch) == 56 && offsetof(Parameters, Tokens) == 60);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_attention_chained_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp16

namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_Q, g_K, g_V, g_High, Reserved, g_PredecessorCounter, g_CompletionCounter;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 64 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Q) == 0 && offsetof(Parameters, g_K) == 8 &&
			  offsetof(Parameters, g_V) == 16);
static_assert(offsetof(Parameters, g_High) == 24 && offsetof(Parameters, Reserved) == 32);
static_assert(offsetof(Parameters, g_PredecessorCounter) == 40 &&
			  offsetof(Parameters, g_CompletionCounter) == 48);
static_assert(offsetof(Parameters, Batch) == 56 && offsetof(Parameters, Tokens) == 60);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_attention_chained_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_attention_chained_c1024_fp8

namespace dlssnr::reconstructed::global_projection_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_projection_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_projection_c1024_fp16

namespace dlssnr::reconstructed::global_projection_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_projection_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_projection_c1024_fp8

namespace dlssnr::reconstructed::global_qkv_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Q, g_K, g_V, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Q) == 8 &&
			  offsetof(Parameters, g_K) == 16);
static_assert(offsetof(Parameters, g_V) == 24 && offsetof(Parameters, g_Record) == 32 &&
			  offsetof(Parameters, g_Counter) == 40);
static_assert(offsetof(Parameters, g_Scratch) == 48 && offsetof(Parameters, Reserved0) == 56 &&
			  offsetof(Parameters, Reserved1) == 64);
static_assert(offsetof(Parameters, Batch) == 72 && offsetof(Parameters, Tokens) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_qkv_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp16

namespace dlssnr::reconstructed::global_qkv_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Q, g_K, g_V, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 80 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Q) == 8 &&
			  offsetof(Parameters, g_K) == 16);
static_assert(offsetof(Parameters, g_V) == 24 && offsetof(Parameters, g_Record) == 32 &&
			  offsetof(Parameters, g_Counter) == 40);
static_assert(offsetof(Parameters, g_Scratch) == 48 && offsetof(Parameters, Reserved0) == 56 &&
			  offsetof(Parameters, Reserved1) == 64);
static_assert(offsetof(Parameters, Batch) == 72 && offsetof(Parameters, Tokens) == 76);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_qkv_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_qkv_c1024_fp8

namespace dlssnr::reconstructed::window_attention_projection_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_c512_fp8

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint32_t Scalar32;
	uint32_t Scalar36;
	uint8_t Reserved40[32];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_output_view_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint64_t g_Pointer24;
	uint32_t Scalar32;
	uint32_t Scalar36;
	uint8_t Reserved40[32];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, g_Pointer24) == 24);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_attention_projection_output_view_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8

namespace dlssnr::reconstructed::window_qkv_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_qkv_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_qkv_c512_fp16

namespace dlssnr::reconstructed::window_qkv_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_qkv_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_qkv_c512_fp8

// -----------------------------------------------------------------------------
// Feed-forward blocks
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_contract_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp16

namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_contract_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_ffn_contract_c1024_fp8

namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_expand_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp16

namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record, g_Counter, g_Scratch, Reserved0, Reserved1;
	int32_t Batch, Tokens;
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8 &&
			  offsetof(Parameters, g_High) == 16);
static_assert(offsetof(Parameters, g_Record) == 24 && offsetof(Parameters, g_Counter) == 32 &&
			  offsetof(Parameters, g_Scratch) == 40);
static_assert(offsetof(Parameters, Reserved0) == 48 && offsetof(Parameters, Reserved1) == 56);
static_assert(offsetof(Parameters, Batch) == 64 && offsetof(Parameters, Tokens) == 68);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void global_ffn_expand_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::global_ffn_expand_c1024_fp8

namespace dlssnr::reconstructed::window_ffn_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_c512_fp16

namespace dlssnr::reconstructed::window_ffn_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_c512_fp8

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_input_view_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp16

namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_High, g_Record;
	int32_t Height, Width, OriginX, OriginY;
	uint64_t Reserved[2];
};

static_assert(sizeof(Parameters) == 56 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_High) == 8 &&
			  offsetof(Parameters, g_Record) == 16);
static_assert(offsetof(Parameters, Height) == 24 && offsetof(Parameters, Width) == 28);
static_assert(offsetof(Parameters, OriginX) == 32 && offsetof(Parameters, OriginY) == 36);
static_assert(offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_input_view_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_input_view_c512_fp8

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp16

namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_c512_fp8

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_input_view_c512_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp16

namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8
{
struct alignas(8) Parameters
{
	uint64_t g_State, g_Skip, g_High, g_Record;
	int32_t Height, Width;
	uint64_t Reserved[4];
};

static_assert(sizeof(Parameters) == 72 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_State) == 0 && offsetof(Parameters, g_Skip) == 8);
static_assert(offsetof(Parameters, g_High) == 16 && offsetof(Parameters, g_Record) == 24);
static_assert(offsetof(Parameters, Height) == 32 && offsetof(Parameters, Width) == 36 &&
			  offsetof(Parameters, Reserved) == 40);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void window_ffn_projection_input_view_c512_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::window_ffn_projection_input_view_c512_fp8

// -----------------------------------------------------------------------------
// Channel projection
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint8_t Reserved24[8];
	uint32_t Scalar32;
	uint32_t Scalar36;
};

static_assert(sizeof(Parameters) == 40 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void channel_projection_c512_to_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8
{
// Exact native parameter byte positions. Host tensor roles remain unqualified.
struct alignas(8) Parameters
{
	uint64_t g_Pointer0;
	uint64_t g_Pointer8;
	uint64_t g_Pointer16;
	uint8_t Reserved24[8];
	uint32_t Scalar32;
	uint32_t Scalar36;
};

static_assert(sizeof(Parameters) == 40 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, g_Pointer0) == 0);
static_assert(offsetof(Parameters, g_Pointer8) == 8);
static_assert(offsetof(Parameters, g_Pointer16) == 16);
static_assert(offsetof(Parameters, Scalar32) == 32);
static_assert(offsetof(Parameters, Scalar36) == 36);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void channel_projection_c512_to_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8

// -----------------------------------------------------------------------------
// Input and output transforms
// -----------------------------------------------------------------------------

namespace dlssnr::reconstructed::input_preprocess_window_c32_fp16
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[66];
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_c32_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_c32_fp16

namespace dlssnr::reconstructed::input_preprocess_window_c32_fp8
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[66];
};

static_assert(sizeof(Parameters) == 264 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void input_preprocess_window_c32_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::input_preprocess_window_c32_fp8

namespace dlssnr::reconstructed::output_window_postprocess_c32_fp16
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[46];
};

static_assert(sizeof(Parameters) == 184 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void output_window_postprocess_c32_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::output_window_postprocess_c32_fp16

namespace dlssnr::reconstructed::output_window_postprocess_c32_fp8
{
// Exact byte extent of this entry's opaque parameter block. No guessed host
// field names or renderer semantics. GPU little-endian words preserve all bits.
struct alignas(8) Parameters
{
	uint32_t Words[46];
};

static_assert(sizeof(Parameters) == 184 && alignof(Parameters) == 8);
static_assert(offsetof(Parameters, Words) == 0);

#if !defined(__CUDACC__)
// NVCC provides this entry's host stub; device definitions retain their attributes.
void output_window_postprocess_c32_fp8(Parameters ParameterBlock);
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
	int32_t Count;
	int32_t Reserved;
};

static_assert(sizeof(ClearParameters) == 16 && alignof(ClearParameters) == 8);
static_assert(offsetof(ClearParameters, g_Counters) == 0 && offsetof(ClearParameters, Count) == 8);
static_assert(offsetof(ClearParameters, Reserved) == 12);
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
void repack_2d_to_1d_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp8

namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_1d_to_2d_c1024_fp8(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp8

namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp16
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_2d_to_1d_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::repack_2d_to_1d_c1024_fp16

namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp16
{
using Parameters = dlssnr::reconstructed::global_repack_layout::Parameters;
#if !defined(__CUDACC__)
void repack_1d_to_2d_c1024_fp16(Parameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::repack_1d_to_2d_c1024_fp16

namespace dlssnr::reconstructed::completion_counter_clear
{
using ClearParameters = dlssnr::reconstructed::global_repack_layout::ClearParameters;
#if !defined(__CUDACC__)
void completion_counter_clear(ClearParameters ParameterBlock);
#endif
} // namespace dlssnr::reconstructed::completion_counter_clear
