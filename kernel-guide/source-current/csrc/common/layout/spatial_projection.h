#pragma once
// Recovered C512 spatial-projection profile, coordinate type and plane addressing.
//
// Channel-plane views store 16 bytes per pixel: N16 for FP8, N8 for Half. A warp
// lane owns a channel pair at x=(lane/4)%4 and y=lane/16. Addresses are byte
// addresses; channel panels and spatial tiles are integer counts.
#include <flashlight/core.cuh>
#include <cstdint>

namespace dlssnr
{
namespace layout
{
template <bool Fp8Storage> struct SpatialProjectionProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int reduction_step = Fp8Storage ? 64 : 32;
	static constexpr int reduction_tiles = 512 / reduction_step;
	static constexpr int spatial_tile_bytes = 16 * 512 * element_bytes;
	static constexpr int matrix_bytes = 512 * 512 * element_bytes;

	// Ring stage geometry. The launched entry selects 2 or 3 live stages; the
	// physical stage/barrier strides stay fixed.
	static constexpr int stage_bytes = 4096;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

struct SpatialProjectionTileCoordinates
{
	int tiles_high;
	int tiles_wide;
	int tile_y;
	int tile_x;
	int output_channel;
	int lane;
	int warp;
};

// Internal argument view shared by the projection, attention-projection and
// pooling entries. This is not an exported parameter ABI.
struct SpatialProjectionArguments
{
	std::uint64_t input, residual, output, packed_weights;
	int height, width;
	std::uint64_t downsampled_output = 0;
	int downsampled_height = 0, downsampled_width = 0;
};

// Map a plane/channel-pair word to its 64-bit global byte address. `base` and the
// returned value are byte addresses; `y`/`x` are pixel coordinates and the lane
// term selects one 4-byte word inside the 16-byte pixel record.
template <bool Fp8Storage>
__host__ __device__ constexpr std::uint64_t
spatial_projection_plane_word_address(std::uint64_t base, int channel_panel, int y, int x,
									  const SpatialProjectionTileCoordinates& coordinates)
{
	return base +
		   ((std::uint64_t(channel_panel) * coordinates.tiles_high * 4 + y) * coordinates.tiles_wide * 4 +
			x) *
			   16 +
		   (coordinates.lane & 3) * 4;
}

// Native out-of-bounds policy broadcasts a singleton 4x4 spatial dimension.
// Other incomplete 8x8 CTA edges read zeros; publication always clips to real tiles.
__host__ __device__ constexpr bool
resolve_spatial_projection_input_tile(int& y, int& x, const SpatialProjectionTileCoordinates& coordinates)
{
	if (coordinates.tiles_high == 1)
		y = 0;
	if (coordinates.tiles_wide == 1)
		x = 0;
	return y < coordinates.tiles_high && x < coordinates.tiles_wide;
}

} // namespace layout
} // namespace dlssnr
