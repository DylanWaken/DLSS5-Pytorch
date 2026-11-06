#pragma once
// Recovered DLSSNR global / connector profiles and coordinate records.
//
// These are model layouts, not reusable FlashLight primitives. K splits, stage
// counts and byte offsets are exact recovered values; no generic pipeline
// framework is implied.
#include <flashlight/core.cuh>
#include <cstdint>

namespace dlssnr
{
namespace layout
{
// Streaming global attention: four warps own 256 queries for one 32-channel
// head, consuming 64 keys at a time through a two-stage K/V ring.
template <bool Fp8Storage> struct GlobalAttentionProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int query_chunks = Fp8Storage ? 1 : 2;
	static constexpr int probability_chunks = Fp8Storage ? 2 : 4;
	static constexpr std::uint32_t stage_count = 2;
	static constexpr std::uint32_t stage_bytes = 2048 * element_bytes;
	static constexpr std::uint32_t value_offset = 2 * stage_bytes;
	static constexpr std::uint32_t barrier_offset = 4 * stage_bytes;

	// The K and V rings are 512-byte copies; a lane owns one 16-byte vector.
	static constexpr std::uint32_t copy_bytes = 512;
	static constexpr std::uint32_t lane_bytes = 16;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

struct GlobalAttentionCoordinates
{
	int tokens;
	int padded_tokens;
	int groups16;
	int key_tiles;
	int query_blocks128;
	int head;
	int query_block256;
	int lane;
	int warp;
};

// Native global projections share M128 x N128 tiles and four resident K splits.
// The profiles retain each operation's input width, K fragments, and pipeline.
template <bool Fp8Storage, bool AttentionProjection = false> struct GlobalContractProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int input_channels = AttentionProjection ? 1024 : 4096;
	static constexpr int split_channels = input_channels / 4;
	static constexpr int reduction_step = Fp8Storage && !AttentionProjection ? 64 : 32;
	static constexpr int reduction_subtiles = reduction_step / (Fp8Storage ? 32 : 16);
	static constexpr int reduction_tiles = split_channels / reduction_step;
	static constexpr int matrix_bytes = input_channels * 1024 * element_bytes;
	static constexpr int group_bytes = reduction_step * 16 * element_bytes;
	static constexpr int copy_bytes = AttentionProjection ? 512 : group_bytes;
	static constexpr int producers_per_group = group_bytes / copy_bytes;
	static constexpr int copies_per_warp = 2 * producers_per_group;
	static constexpr int stage_count = Fp8Storage || AttentionProjection ? 2 : 3;
	static constexpr int initial_stages = stage_count == 3 ? 3 : 1;
	static constexpr int stage_bytes = 8 * group_bytes;
	static constexpr int barrier_offset = stage_count * stage_bytes;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

// Two K512 slices form Q/K/V for two 32-channel heads. Each four-warp CTA owns
// M128 x N192; normalization and V transposition fuse into the final slice.
template <bool Fp8Storage> struct GlobalQkvProfile : GlobalContractProfile<Fp8Storage, true>
{
	static constexpr int split_channels = 512;
	static constexpr int reduction_tiles = 16;
};

// Native FFN expands 1024 channels to 4096. Four warps cover a 128-token x
// 128-channel CTA tile, arranged as two row groups by two columns. Both
// precisions stage 8192 bytes per K step: K64 FP8 or K32 Half.
template <bool Fp8Storage> struct GlobalFfnExpandProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int reduction_tile = Fp8Storage ? 64 : 32;
	static constexpr int reduction_steps = 1024 / reduction_tile;
	static constexpr int token_alignment = Fp8Storage ? 32 : 16;
	static constexpr std::uint32_t stage_bytes = 8192;
	static constexpr std::uint32_t stage_count = 3;
	static constexpr std::uint32_t barrier_base = stage_bytes * stage_count;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

// Decoder connector: split-K4 projection 1024->512, nearest 2x upsample, scaled
// skip. A CTA computes one 4x4 low-resolution tile and 256 output channels in
// two warps.
template <bool Fp8Storage> struct DecoderProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int reduction_step = Fp8Storage ? 64 : 32;
	static constexpr int reduction_tiles = 256 / reduction_step;
	static constexpr int matrix_bytes = 1024 * 512 * element_bytes;

	// Two 1024-byte input stages, one 512-byte copy per warp and lane vector.
	static constexpr std::uint32_t stage_count = 2;
	static constexpr std::uint32_t stage_bytes = 1024;
	static constexpr std::uint32_t copy_bytes = 512;
	static constexpr std::uint32_t lane_bytes = 16;
	static constexpr std::uint32_t barrier_base = 2 * stage_bytes;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

struct DecoderCoordinates
{
	int low_tiles_high;
	int low_tiles_wide;
	int high_tiles_high;
	int high_tiles_wide;
	int tile_y;
	int tile_x;
	int output_channel;
	int grid_columns;
	int split;
	int lane;
	int warp;
};

struct GlobalContractTileCoordinates
{
	int token_group_base;
	int output_channel;
	int padded_groups;
	int channel_block;
	int lane;
	int warp;
	int split;
	bool broadcast_input;
};

enum class GlobalContractSplitPublication
{
	Runtime,
	First,
	Intermediate,
	Final
};

enum class GlobalQkvSplitPublication
{
	Runtime,
	First,
	Final
};

} // namespace layout
} // namespace dlssnr
