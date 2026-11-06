#pragma once
// Recovered DLSSNR window/block profiles, register tile contracts and the wide
// shared exchange layout.
//
// The byte offsets are recovered record layouts, not a generic model-layout
// framework. They are project data and therefore stay outside FlashLight. The
// 16-byte lane vector is the native A fragment; no BHWC conversion or bank
// swizzle is introduced by the exchange view.
#include <flashlight/core.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/views.cuh>
#include <cstdint>

namespace dlssnr
{
namespace layout
{
// Precision tag used by the recovered window tile contracts.
template <bool Fp8Storage>
inline constexpr flashlight::InputPrecision window_precision =
	Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;

// Ordinary one-warp C32 record layout. Every 16-token tile is one physical 4x4
// tile; fragment row order is the recovered DLL order.
template <bool Fp8Storage> struct Window32Profile
{
	static constexpr int reduction = Fp8Storage ? 32 : 16;
	static constexpr int input_chunks = 32 / reduction;
	static constexpr int tile_bytes = Fp8Storage ? 512 : 1024;
	static constexpr int contract_offset = Fp8Storage ? 4096 : 8192;
	static constexpr int ffn_scale_offset = Fp8Storage ? 8208 : 16400;
	static constexpr int qkv_offset = Fp8Storage ? 8288 : 16480;
	static constexpr int bias_offset = Fp8Storage ? 11360 : 22624;
	static constexpr int head_scale_offset = Fp8Storage ? 19552 : 30816;
	static constexpr int projection_offset = Fp8Storage ? 19568 : 30832;
	static constexpr int attention_scale_offset = Fp8Storage ? 20592 : 32880;
};

// Each word holds channels [8*column + 2*(lane%4), +1]. `row_half` selects
// physical rows lane/4 or lane/4+8 within the tile's 16 tokens.
template <int Columns> struct WindowAccumulatorTile
{
	static_assert(Columns % 8 == 0, "Window column count must contain whole N8 fragments");
	std::uint32_t pair[Columns / 8][2];
};

template <bool Fp8Storage> struct WindowActivationTile
{
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
	flashlight::MmaAFragment<precision> reduction[Window32Profile<Fp8Storage>::input_chunks];
};

template <bool Fp8Storage> struct WindowWeightTile
{
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
	flashlight::MmaBFragment<precision> pair[Window32Profile<Fp8Storage>::input_chunks][4];
};

template <bool Fp8Storage> struct WindowValueTile
{
	// FP8 pairs the two K8 halves into one word; Half keeps both words.
	std::uint32_t word[4][Fp8Storage ? 1 : 2];
};

// Fused window FFN: dense 512->512, then independent 64->256->64 MLPs.
template <bool Fp8Storage, bool InputView = false> struct WindowFfnProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int warps = Fp8Storage && !InputView ? 8 : 4;
	static constexpr int spatial_fragments = Fp8Storage && !InputView ? 2 : 4;
	static constexpr int reduction_step = Fp8Storage ? 64 : 32;
	static constexpr int reduction_tiles = 512 / reduction_step;
	static constexpr int spatial_tile_bytes = 16 * 512 * element_bytes;

	// Two-stage input ring: 4096-byte stage followed by two transaction barriers.
	static constexpr int stage_count = 2;
	static constexpr int stage_bytes = 4096;
	static constexpr int barrier_base = 2 * stage_bytes;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

// Split C512 QKV and attention record layout.
template <bool Fp8Storage> struct WindowQkvProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int reduction_step = Fp8Storage ? 64 : 16;
	static constexpr int reduction_tiles = 512 / reduction_step;
	static constexpr int k_subtiles = Fp8Storage ? 2 : 1;
	static constexpr int stage_count = 2;
	static constexpr int stage_bytes = Fp8Storage ? 4096 : 2048;
	static constexpr int barrier_base = 2 * stage_bytes;
	static constexpr int bias_offset = 3 * 512 * 512 * element_bytes;
	static constexpr int head_scale_offset = bias_offset + 16 * 8192;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

struct WindowQkvCoordinates
{
	int tiles_high;
	int tiles_wide;
	int tile_y;
	int tile_x;
	int head;
	int lane;
	int warp;
};

struct WindowFfnTileCoordinates
{
	int tiles_high;
	int tiles_wide;
	int tile_y;
	int tile_x;
	int expert_group;
	int lane;
	int warp;
};

// C512 -> C1024 pointwise projection owner layout.
template <bool Fp8Storage> struct ChannelProjectionProfile
{
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int input_channels = 512;
	static constexpr int output_channels = 1024;
	static constexpr int tile_channels = 256;
	static constexpr int warp_channels = 64;
	static constexpr int reduction_step = Fp8Storage ? 64 : 32;
	static constexpr int reduction_steps = input_channels / reduction_step;
	static constexpr int stage_count = 3;
	static constexpr int stage_bytes = 4096;
	static constexpr int barrier_offset = stage_count * stage_bytes;
	static constexpr int storage_bytes = barrier_offset + stage_count * 8;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;
};

// Wide blocks share tensor operations but not one ownership schedule. C64
// computes its FFN over two token tiles per warp; C128/C256 distribute FFN
// experts between warps and exchange published C32 panels through shared memory.
template <int Channels, bool Fp8Storage> struct WideWindowProfile
{
	static_assert(Channels == 64 || Channels == 128 || Channels == 256,
				  "Only recovered C64/C128/C256 wide profiles are admitted");
	static constexpr int heads = Channels / 32;
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int chunks = Window32Profile<Fp8Storage>::input_chunks;
	static constexpr int panel_bytes = Window32Profile<Fp8Storage>::tile_bytes;
	static constexpr int tile_bytes = heads * panel_bytes;
	static constexpr int expert_expand_bytes = Channels * 128 * element_bytes;
	static constexpr int expert_contract_bytes = 128 * 32 * element_bytes;
	static constexpr int contract_offset = heads * expert_expand_bytes;
	static constexpr int mix_offset = contract_offset + heads * expert_contract_bytes;
	static constexpr int ffn_scale_offset = mix_offset + Channels * Channels * element_bytes + 16;
	static constexpr int qkv_offset = ffn_scale_offset + 2 * Channels + 16;
	static constexpr int bias_offset = qkv_offset + 3 * Channels * Channels * element_bytes;
	static constexpr int head_scale_offset = bias_offset + heads * 8192;
	static constexpr int projection_offset = head_scale_offset + ((heads * 4 + 15) / 16) * 16;
	static constexpr int attention_scale_offset = projection_offset + Channels * Channels * element_bytes;

	// Native C256 keeps all four query tiles until the projection exchange;
	// C64/C128 reuse the shared slab twice, for two query tiles at a time.
	static constexpr int attention_batch = Channels == 256 ? 4 : 2;
};

// Block-level base for upsample profiles. Channels=32 is the ordinary one-warp
// record; wider channels use the wide-window record.
template <int Channels, bool Fp8Storage>
struct WindowUpsampleBlockProfile : WideWindowProfile<Channels, Fp8Storage>
{
};

template <bool Fp8Storage> struct WindowUpsampleBlockProfile<32, Fp8Storage> : Window32Profile<Fp8Storage>
{
	static constexpr int heads = 1;
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
};

template <int Channels, bool Fp8Storage>
struct WindowUpsampleProfile : WindowUpsampleBlockProfile<Channels, Fp8Storage>
{
	static constexpr int heads = Channels / 32;
	static constexpr int element_bytes = Fp8Storage ? 1 : 2;
	static constexpr int ffn_matrices_bytes = Channels == 32 ? 8192 * element_bytes
															 : heads * Channels * 128 * element_bytes +
																   heads * 128 * 32 * element_bytes +
																   Channels * Channels * element_bytes;
	static constexpr int up_projection_offset = ffn_matrices_bytes;
	static constexpr int padding = Channels == 32 ? 16 : 0;
	static constexpr int ffn_scale_offset =
		ffn_matrices_bytes + 2 * Channels * Channels * element_bytes + padding;
	static constexpr int transition_scale_offset = ffn_scale_offset + 2 * Channels + padding;
	static constexpr int qkv_offset = transition_scale_offset + 2 * Channels;
	static constexpr int bias_offset = qkv_offset + 3 * Channels * Channels * element_bytes;
	static constexpr int head_scale_offset = bias_offset + heads * 8192;
	static constexpr int projection_offset = head_scale_offset + ((heads * 4 + 15) / 16) * 16;
	static constexpr int attention_scale_offset = projection_offset + Channels * Channels * element_bytes;
};

// Preprocessing inserts a 16x32 Half adapter before the FFN skip scale. The
// adapter is always Half-sized, including the FP8 path, and shifts every later
// ordinary-record field by 1024 bytes.
template <bool Fp8Storage> struct PreprocessWindowProfile : Window32Profile<Fp8Storage>
{
	static constexpr int adapter_bytes = 16 * 32 * sizeof(__half);
	static constexpr int adapter_offset = Window32Profile<Fp8Storage>::ffn_scale_offset;
	static constexpr int ffn_scale_offset = Window32Profile<Fp8Storage>::ffn_scale_offset + adapter_bytes;
	static constexpr int qkv_offset = Window32Profile<Fp8Storage>::qkv_offset + adapter_bytes;
	static constexpr int bias_offset = Window32Profile<Fp8Storage>::bias_offset + adapter_bytes;
	static constexpr int head_scale_offset = Window32Profile<Fp8Storage>::head_scale_offset + adapter_bytes;
	static constexpr int projection_offset = Window32Profile<Fp8Storage>::projection_offset + adapter_bytes;
	static constexpr int attention_scale_offset =
		Window32Profile<Fp8Storage>::attention_scale_offset + adapter_bytes;
};

// Postprocessing record layout. These offsets are explicit recovered values and
// intentionally differ from the ordinary Window32Profile where the DLL says so.
template <bool Fp8Storage> struct PostprocessWindowProfile : Window32Profile<Fp8Storage>
{
	static constexpr int ffn_scale_offset = Fp8Storage ? 8208 : 16400;
	static constexpr int qkv_offset = Fp8Storage ? 8400 : 16592;
	static constexpr int bias_offset = Fp8Storage ? 11472 : 22736;
	static constexpr int head_scale_offset = Fp8Storage ? 19664 : 30928;
	static constexpr int projection_offset = Fp8Storage ? 19680 : 30944;
	static constexpr int attention_scale_offset = Fp8Storage ? 20704 : 32992;
	static constexpr int input_scale_offset = Fp8Storage ? 8272 : 16464;
	static constexpr int adapter_scale_offset = Fp8Storage ? 8336 : 16528;
	static constexpr int head_offset = Fp8Storage ? 20784 : 33072;
};

// One lane's native A fragment occupies one uint4 in the wide exchange. The
// array is a shared-memory tile, not a register allocation. Accessors perform
// no synchronization.
template <int Channels, bool Fp8Storage> struct SharedWindowExchange
{
	using Config = WideWindowProfile<Channels, Fp8Storage>;
	static constexpr flashlight::InputPrecision precision =
		Fp8Storage ? flashlight::InputPrecision::E4M3 : flashlight::InputPrecision::Fp16;

	uint4 tile[4][Config::heads][Config::chunks][32];

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
	// [tile][panel][chunk][lane] in 16-byte vectors. The exchange view owns the
	// repeated panel/chunk/lane arithmetic; it adds no synchronization.
	using ExchangeView = flashlight::memory::SharedLayoutView<
		uint4, flashlight::layout::ByteStrides<Config::heads * Config::chunks * 32 * 16,
											   Config::chunks * 32 * 16, 32 * 16, 16>>;

	__device__ __forceinline__ ExchangeView view()
	{
		return ExchangeView(flashlight::memory::SharedBytes(&tile[0][0][0][0]));
	}

	__device__ __forceinline__ ExchangeView view() const
	{
		return ExchangeView(flashlight::memory::SharedBytes(const_cast<uint4*>(&tile[0][0][0][0])));
	}

	__device__ __forceinline__ WindowActivationTile<Fp8Storage> load(int tile_index, int panel_index) const
	{
		const ExchangeView exchange = view();
		WindowActivationTile<Fp8Storage> activation;
		#pragma unroll
		for (int chunk = 0; chunk < Config::chunks; ++chunk)
		{
			const uint4 vector = exchange.load(tile_index, panel_index, chunk, threadIdx.x);
			activation.reduction[chunk] = {{vector.x, vector.y, vector.z, vector.w}};
		}

		return activation;
	}

	__device__ __forceinline__ void store(int tile_index, int panel_index,
										  const WindowActivationTile<Fp8Storage>& activation)
	{
		const ExchangeView exchange = view();
		#pragma unroll
		for (int chunk = 0; chunk < Config::chunks; ++chunk)
		{
			const auto& fragment = activation.reduction[chunk];
			exchange.store(make_uint4(fragment.word[0], fragment.word[1], fragment.word[2], fragment.word[3]),
						   tile_index, panel_index, chunk, threadIdx.x);
		}
	}
#endif // SM80+
};

// Register-resident window panels. This is a value container only.
template <bool Fp8Storage, int Tiles, int Panels> struct RegisterWindow
{
	WindowActivationTile<Fp8Storage> tile[Tiles][Panels];

	__device__ __forceinline__ WindowActivationTile<Fp8Storage> load(int tile_index, int panel) const
	{
		return tile[tile_index][panel];
	}
};

// Two 8-channel Half planes, each holding the row-major 8x8 window. The adapter
// reads these exact planes directly into m16n8k16 A fragments.
struct SharedFeatures
{
	uint4 plane[2][64];

	// One packed channel-pair word from a staged feature pixel. This is a shared
	// reinterpretation, not a tensor conversion; the call site keeps the lane
	// selection.
	__device__ __forceinline__ std::uint32_t word(int plane_index, int pixel, int word_index) const
	{
		return reinterpret_cast<const std::uint32_t*>(&plane[plane_index][pixel])[word_index];
	}
};

// Internal argument views shared by fused window downsampling and the frontend
// downsample adapter. These are not exported parameter ABIs.
struct WindowDownsampleArguments
{
	std::uint64_t input, output, packed_weights, downsampled_output;
	int height, width, origin_x, origin_y, downsampled_height, downsampled_width;
};

struct WindowUpsampleArguments
{
	std::uint64_t input, output, packed_weights, residual;
	int height, width, origin_x, origin_y, residual_height, residual_width;
	void* shared_window;
	const WindowAccumulatorTile<32>* merged;
};

// Preprocessing inserts the always-Half 16x32 adapter between feature staging
// and the fused window block.
struct PreprocessWindowArguments
{
	std::uint64_t input, output, packed_weights;
	int height, width, origin_x, origin_y;
	const WindowAccumulatorTile<32>* adapter;
};

struct PostprocessWindowArguments
{
	std::uint64_t input, output, packed_weights;
	int height, width, origin_x, origin_y;
	const WindowAccumulatorTile<32>* raw_input;
	std::uint32_t (*head)[2];
};

} // namespace layout
} // namespace dlssnr
