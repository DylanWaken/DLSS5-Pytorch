#pragma once
// Recovered DLSSNR window attention/pooling algorithms.
//
// These compositions retain the original Half rounding order, lane ownership and
// distinct reduction schedules. Generic primitives (MMA, packed Half arithmetic,
// shuffles and the four-register permutation) come from FlashLight. The two
// softmax schedules remain separate because they use different lane ownership;
// they are not one mathematical helper.
#include <flashlight/core.cuh>
#include <flashlight/arch/mma.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include <flashlight/warp/permutation.cuh>
#include "../layout/numerical_constants.h"
#include "../layout/window_profiles.h"
#include "activation.h"
#include <cstdint>

namespace dlssnr
{
namespace ops
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
template <bool Fp8Storage>
using WindowAFragment = flashlight::MmaAFragment<layout::window_precision<Fp8Storage>>;

// MMA computes accumulator += left * right. Call sites pass activation/weight,
// query/key, or probability/value fragments in these roles.
template <bool Fp8Storage>
__device__ __forceinline__ void
mma_window_fragment(const WindowAFragment<Fp8Storage>& left,
					const flashlight::MmaBFragment<layout::window_precision<Fp8Storage>>& right,
					flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half>& accumulator)
{
	flashlight::arch::mma_sync(accumulator, left, right);
}

// Load one lane's native A fragment from its 16-byte vector representation. No
// lane reordering or conversion is performed.
template <bool Fp8Storage>
__device__ __forceinline__ WindowAFragment<Fp8Storage> make_window_fragment(uint4 vector)
{
	return {{vector.x, vector.y, vector.z, vector.w}};
}

// Publish one accumulator chunk into the native A-fragment word order. E4
// combines two N16 groups into one K32 fragment at the original quantization
// boundary; Half copies the accumulator words directly.
template <bool Fp8Storage, int Columns>
__device__ __forceinline__ WindowAFragment<Fp8Storage>
publish_window_chunk(const layout::WindowAccumulatorTile<Columns>& accumulator, int chunk)
{
	WindowAFragment<Fp8Storage> published;
	#pragma unroll
	for (int half = 0; half < 2; ++half)
	{
		#pragma unroll
		for (int row_half = 0; row_half < 2; ++row_half)
		{
			if constexpr (Fp8Storage)
			{
				published.word[2 * half + row_half] =
					flashlight::numeric::publish_e4x4(
						flashlight::PackedHalf2{accumulator.pair[4 * chunk + 2 * half][row_half]},
						flashlight::PackedHalf2{accumulator.pair[4 * chunk + 2 * half + 1][row_half]})
						.bits;
			}
			else
			{
				published.word[2 * half + row_half] = accumulator.pair[2 * chunk + half][row_half];
			}
		}
	}

	return published;
}

template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowActivationTile<Fp8Storage>
publish_window32(const layout::WindowAccumulatorTile<32>& accumulator)
{
	layout::WindowActivationTile<Fp8Storage> published;
	#pragma unroll
	for (int chunk = 0; chunk < layout::Window32Profile<Fp8Storage>::input_chunks; ++chunk)
		published.reduction[chunk] = publish_window_chunk<Fp8Storage>(accumulator, chunk);
	return published;
}

// Load the per-chunk N16 weight fragments. Both K32 E4 and K16 Half panels
// contain 32 bytes per output column; the 512-byte stripe is the native vector.
template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowWeightTile<Fp8Storage>
load_window_weights(const unsigned char* matrix, int output_base, int reduction_base, int output_channels)
{
	layout::WindowWeightTile<Fp8Storage> weights;
	#pragma unroll
	for (int chunk = 0; chunk < layout::Window32Profile<Fp8Storage>::input_chunks; ++chunk)
	{
		#pragma unroll
		for (int column_tile = 0; column_tile < 2; ++column_tile)
		{
			const int weight_byte_offset =
				(reduction_base / layout::Window32Profile<Fp8Storage>::reduction + chunk) * output_channels *
					32 +
				(output_base / 16 + column_tile) * 512 + int(threadIdx.x) * 16;
			const uint4 weight_vector =
				flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
					flashlight::memory::GlobalAddress(
						reinterpret_cast<std::uint64_t>(matrix + weight_byte_offset)));
			weights.pair[chunk][2 * column_tile].word[0] = weight_vector.x;
			weights.pair[chunk][2 * column_tile].word[1] = weight_vector.y;
			weights.pair[chunk][2 * column_tile + 1].word[0] = weight_vector.z;
			weights.pair[chunk][2 * column_tile + 1].word[1] = weight_vector.w;
		}
	}

	return weights;
}

// Dense window linear layer. Column outer, chunk inner, preserving the recovered
// MMA issue order and Half accumulator rounding.
template <bool Fp8Storage>
__device__ __forceinline__ void linear_window32(const layout::WindowActivationTile<Fp8Storage>& input,
												const layout::WindowWeightTile<Fp8Storage>& weights,
												layout::WindowAccumulatorTile<32>& output)
{
	#pragma unroll
	for (int column = 0; column < 4; ++column)
	{
		#pragma unroll
		for (int chunk = 0; chunk < layout::Window32Profile<Fp8Storage>::input_chunks; ++chunk)
		{
			flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> accumulator{
				{output.pair[column][0], output.pair[column][1]}};
			mma_window_fragment<Fp8Storage>(input.reduction[chunk], weights.pair[chunk][column], accumulator);
			output.pair[column][0] = accumulator.word[0];
			output.pair[column][1] = accumulator.word[1];
		}
	}
}

// Project the V accumulator into the native value-fragment order. Both
// precisions transpose the two Half row halves first; E4 then merges the pair
// at the original quantization boundary.
template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowValueTile<Fp8Storage>
publish_window_value(const layout::WindowAccumulatorTile<32>& projected)
{
	layout::WindowValueTile<Fp8Storage> value;
	#pragma unroll
	for (int column = 0; column < 4; ++column)
	{
		const std::uint32_t lower_rows = flashlight::arch::transpose_m8n8(projected.pair[column][0]);
		const std::uint32_t upper_rows = flashlight::arch::transpose_m8n8(projected.pair[column][1]);
		if constexpr (Fp8Storage)
		{
			value.word[column][0] = flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{lower_rows},
																	  flashlight::PackedHalf2{upper_rows})
										.bits;
		}
		else
		{
			value.word[column][0] = lower_rows;
			value.word[column][1] = upper_rows;
		}
	}

	return value;
}

// Query/key score accumulation with the per-query-tile attention bias. The
// bias vector is loaded cache-all and the key word order is the recovered B
// fragment order.
template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowAccumulatorTile<64>
query_key_scores(int tile, const unsigned char* head_bias,
				 const layout::WindowActivationTile<Fp8Storage> (&query)[4],
				 const layout::WindowActivationTile<Fp8Storage> (&key)[4])
{
	layout::WindowAccumulatorTile<64> scores;
	#pragma unroll
	for (int column_tile = 0; column_tile < 4; ++column_tile)
	{
		const int bias_offset = 2048 * tile + 512 * column_tile + int(threadIdx.x) * 16;
		const uint4 bias = flashlight::memory::load_vector<flashlight::memory::CachePolicy::Ca, uint4>(
			flashlight::memory::GlobalAddress(reinterpret_cast<std::uint64_t>(head_bias + bias_offset)));
		scores.pair[2 * column_tile][0] = bias.x;
		scores.pair[2 * column_tile][1] = bias.y;
		scores.pair[2 * column_tile + 1][0] = bias.z;
		scores.pair[2 * column_tile + 1][1] = bias.w;
	}

	#pragma unroll
	for (int column = 0; column < 8; ++column)
	{
		#pragma unroll
		for (int chunk = 0; chunk < layout::Window32Profile<Fp8Storage>::input_chunks; ++chunk)
		{
			const auto& keys = key[column / 2].reduction[chunk];
			const flashlight::MmaBFragment<layout::window_precision<Fp8Storage>> key_fragment{
				{keys.word[column & 1], keys.word[2 + (column & 1)]}};
			flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> accumulator{
				{scores.pair[column][0], scores.pair[column][1]}};
			flashlight::arch::mma_sync(accumulator, query[tile].reduction[chunk], key_fragment);
			scores.pair[column][0] = accumulator.word[0];
			scores.pair[column][1] = accumulator.word[1];
		}
	}

	return scores;
}

// Probability times value. The probability fragment is published once per
// reduction chunk; the value fragment word order differs between K16 Half and
// K32 E4 exactly as the recovered source does.
template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowAccumulatorTile<32>
probability_values(const layout::WindowAccumulatorTile<64>& probabilities,
				   const layout::WindowValueTile<Fp8Storage> (&value)[4])
{
	layout::WindowAccumulatorTile<32> attended{};
	#pragma unroll
	for (int chunk = 0; chunk < 64 / layout::Window32Profile<Fp8Storage>::reduction; ++chunk)
	{
		const WindowAFragment<Fp8Storage> probability =
			publish_window_chunk<Fp8Storage>(probabilities, chunk);
		#pragma unroll
		for (int column = 0; column < 4; ++column)
		{
			std::uint32_t value_word[2];
			if constexpr (Fp8Storage)
			{
				value_word[0] = value[2 * chunk].word[column][0];
				value_word[1] = value[2 * chunk + 1].word[column][0];
			}
			else
			{
				value_word[0] = value[chunk].word[column][0];
				value_word[1] = value[chunk].word[column][1];
			}
			const flashlight::MmaBFragment<layout::window_precision<Fp8Storage>> right{
				{value_word[0], value_word[1]}};
			flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> accumulator{
				{attended.pair[column][0], attended.pair[column][1]}};
			flashlight::arch::mma_sync(accumulator, probability, right);
			attended.pair[column][0] = accumulator.word[0];
			attended.pair[column][1] = accumulator.word[1];
		}
	}

	return attended;
}

// Learned-network activation. The call-site alias ActivateWindow map to this
// single canonical composition.
__device__ __forceinline__ flashlight::PackedHalf2 activate_window(flashlight::PackedHalf2 input)
{
	return ffn_activation(input);
}

// Scale a published activation tile into the FFN/attention residual seed. E4
// decodes the stored byte pair first; Half reuses the native words directly.
template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowAccumulatorTile<32>
scaled_window_residual(const layout::WindowActivationTile<Fp8Storage>& input, const unsigned char* scale,
					   int channel_base)
{
	layout::WindowAccumulatorTile<32> scaled;
	#pragma unroll
	for (int column = 0; column < 4; ++column)
	{
		const int offset = 2 * channel_base + 16 * column + 4 * (threadIdx.x & 3);
		const std::uint32_t residual_scale =
			*flashlight::memory::GlobalAddress(reinterpret_cast<std::uint64_t>(scale + offset))
				 .as_pointer<const std::uint32_t>();
		#pragma unroll
		for (int row_half = 0; row_half < 2; ++row_half)
		{
			std::uint32_t residual_pair;
			if constexpr (Fp8Storage)
			{
				residual_pair = flashlight::numeric::decode_e4x2(
									std::uint16_t(input.reduction[0].word[2 * (column / 2) + row_half] >>
												  (16 * (column & 1))))
									.bits;
			}
			else
			{
				residual_pair = input.reduction[column / 2].word[2 * (column & 1) + row_half];
			}
			scaled.pair[column][row_half] =
				flashlight::numeric::half2_multiply(flashlight::PackedHalf2{residual_pair},
													flashlight::PackedHalf2{residual_scale})
					.bits;
		}
	}

	return scaled;
}

// One grouped expert: C -> 128 -> 32, streamed one hidden C32 panel at a time.
// The four contractions accumulate in K order and every Half MMA rounding point
// is retained.
template <int Channels, bool Fp8Storage, int Tiles, class InputSource>
__device__ __forceinline__ void compute_window_expert(const InputSource& input_source,
													  const unsigned char* packed_weights, int expert_index,
													  layout::WindowAccumulatorTile<32> (&contracted)[Tiles])
{
	using Config = layout::WideWindowProfile<Channels, Fp8Storage>;
	const unsigned char* expansion = packed_weights + expert_index * Config::expert_expand_bytes;
	const unsigned char* contraction =
		packed_weights + Config::contract_offset + expert_index * Config::expert_contract_bytes;

	#pragma unroll 1
	for (int hidden_panel = 0; hidden_panel < 4; ++hidden_panel)
	{
		layout::WindowAccumulatorTile<32> expanded[Tiles]{};
		#pragma unroll
		for (int panel = 0; panel < Config::heads; ++panel)
		{
			const auto weights =
				load_window_weights<Fp8Storage>(expansion, hidden_panel * 32, panel * 32, 128);
			#pragma unroll
			for (int tile = 0; tile < Tiles; ++tile)
				linear_window32(input_source.load(tile, panel), weights, expanded[tile]);
		}

		const auto weights = load_window_weights<Fp8Storage>(contraction, 0, hidden_panel * 32, 32);
		#pragma unroll
		for (int tile = 0; tile < Tiles; ++tile)
		{
			#pragma unroll
			for (int column = 0; column < 4; ++column)
				#pragma unroll
				for (int row_half = 0; row_half < 2; ++row_half)
					expanded[tile].pair[column][row_half] =
						activate_window(flashlight::PackedHalf2{expanded[tile].pair[column][row_half]}).bits;
			linear_window32(publish_window32<Fp8Storage>(expanded[tile]), weights, contracted[tile]);
		}
	}
}

// Window attention's native exponential surrogate: clamped Half affine map and a
// packed exponent-bit shift. The whole-word carry is required.
__device__ __forceinline__ flashlight::PackedHalf2
window_attention_exponential(flashlight::PackedHalf2 scores)
{
	const flashlight::PackedHalf2 affine =
		flashlight::numeric::half2_fma(scores, flashlight::PackedHalf2{layout::window_exp_slope_half2},
									   flashlight::PackedHalf2{layout::window_exp_intercept_half2});
	const flashlight::PackedHalf2 bounded = flashlight::numeric::half2_minimum(
		flashlight::numeric::half2_maximum(affine, flashlight::PackedHalf2{layout::window_exp_lower_half2}),
		flashlight::PackedHalf2{layout::window_exp_upper_half2});
	return flashlight::PackedHalf2{(bounded.bits << layout::window_exp_encoding_shift) +
								   layout::window_exp_encoding_offset};
}

// Row normalization with the recovered contracted square tree: channels 16..31
// round before channels 0..15 are fused into them. XOR shuffles reduce the four
// lanes of one token without exchanging tokens.
template <bool ApplyScale>
__device__ __forceinline__ void normalize_window(layout::WindowAccumulatorTile<32>& channels,
												 flashlight::PackedHalf2 scale)
{
	#pragma unroll
	for (int row_half = 0; row_half < 2; ++row_half)
	{
		const auto& pair = channels.pair;
		const flashlight::PackedHalf2 even_column_squares = flashlight::numeric::half2_fma(
			flashlight::PackedHalf2{pair[0][row_half]}, flashlight::PackedHalf2{pair[0][row_half]},
			flashlight::numeric::half2_multiply(flashlight::PackedHalf2{pair[2][row_half]},
												flashlight::PackedHalf2{pair[2][row_half]}));
		const flashlight::PackedHalf2 odd_column_squares = flashlight::numeric::half2_fma(
			flashlight::PackedHalf2{pair[1][row_half]}, flashlight::PackedHalf2{pair[1][row_half]},
			flashlight::numeric::half2_multiply(flashlight::PackedHalf2{pair[3][row_half]},
												flashlight::PackedHalf2{pair[3][row_half]}));
		flashlight::PackedHalf2 squared_norm =
			flashlight::numeric::half2_add(odd_column_squares, even_column_squares);
		squared_norm = flashlight::numeric::half2_add(
			squared_norm, flashlight::PackedHalf2{flashlight::arch::shuffle_xor(
							  squared_norm.bits, 2, layout::warp_clamp, layout::warp_members)});
		squared_norm = flashlight::numeric::half2_add(
			squared_norm, flashlight::PackedHalf2{flashlight::arch::shuffle_xor(
							  squared_norm.bits, 1, layout::warp_clamp, layout::warp_members)});
		squared_norm =
			flashlight::numeric::half2_add(squared_norm, flashlight::numeric::half2_swap_lanes(squared_norm));
		const flashlight::PackedHalf2 inverse_norm =
			flashlight::numeric::invert_replicated_half<true>(flashlight::numeric::half2_maximum(
				squared_norm, flashlight::PackedHalf2{layout::normalization_epsilon_half2}));
		#pragma unroll
		for (int column = 0; column < 4; ++column)
		{
			channels.pair[column][row_half] =
				flashlight::numeric::half2_multiply(flashlight::PackedHalf2{channels.pair[column][row_half]},
													inverse_norm)
					.bits;
			if constexpr (ApplyScale)
				channels.pair[column][row_half] =
					flashlight::numeric::half2_multiply(
						flashlight::PackedHalf2{channels.pair[column][row_half]}, scale)
						.bits;
		}
	}
}

// Softmax schedule for one query tile. The native reduction order is lane 0+1,
// then +2, then +3, then the two Half components; a butterfly would change
// Half rounding.
__device__ __forceinline__ void softmax_window(layout::WindowAccumulatorTile<64>& scores)
{
	#pragma unroll
	for (int row_half = 0; row_half < 2; ++row_half)
	{
		#pragma unroll
		for (int column = 0; column < 8; ++column)
			scores.pair[column][row_half] =
				window_attention_exponential(flashlight::PackedHalf2{scores.pair[column][row_half]}).bits;
		flashlight::PackedHalf2 local_probability_sum =
			flashlight::numeric::half2_add(flashlight::PackedHalf2{scores.pair[0][row_half]},
										   flashlight::PackedHalf2{scores.pair[1][row_half]});
		#pragma unroll
		for (int column = 2; column < 8; column += 2)
			local_probability_sum = flashlight::numeric::half2_add(
				local_probability_sum,
				flashlight::numeric::half2_add(flashlight::PackedHalf2{scores.pair[column][row_half]},
											   flashlight::PackedHalf2{scores.pair[column + 1][row_half]}));

		const std::uint32_t group_base = threadIdx.x & ~3u;
		flashlight::PackedHalf2 probability_sum = flashlight::warp::shuffle_index(
			local_probability_sum, group_base, layout::warp_clamp, layout::warp_members);
		#pragma unroll
		for (int lane = 1; lane < 4; ++lane)
			probability_sum = flashlight::numeric::half2_add(
				probability_sum, flashlight::warp::shuffle_index(local_probability_sum, group_base + lane,
																 layout::warp_clamp, layout::warp_members));
		probability_sum = flashlight::numeric::half2_add(
			probability_sum, flashlight::numeric::half2_swap_lanes(probability_sum));
		const flashlight::PackedHalf2 inverse_denominator =
			flashlight::numeric::invert_replicated_half<false>(flashlight::numeric::half2_maximum(
				probability_sum, flashlight::PackedHalf2{layout::normalization_epsilon_half2}));
		#pragma unroll
		for (int column = 0; column < 8; ++column)
			scores.pair[column][row_half] =
				flashlight::numeric::half2_multiply(flashlight::PackedHalf2{scores.pair[column][row_half]},
													inverse_denominator)
					.bits;
	}
}

// One query tile's complete attention: bias-seeded scores, the single-tile
// softmax schedule, probability times value and A-fragment publication.
template <bool Fp8Storage>
__device__ __forceinline__ layout::WindowActivationTile<Fp8Storage>
attend_with_bias(int tile, const unsigned char* head_bias,
				 const layout::WindowActivationTile<Fp8Storage> (&query)[4],
				 const layout::WindowActivationTile<Fp8Storage> (&key)[4],
				 const layout::WindowValueTile<Fp8Storage> (&value)[4])
{
	layout::WindowAccumulatorTile<64> probabilities =
		query_key_scores<Fp8Storage>(tile, head_bias, query, key);
	softmax_window(probabilities);
	return publish_window32<Fp8Storage>(probability_values<Fp8Storage>(probabilities, value));
}

// Paired two-query-tile softmax. Four row halves fill all 32 lanes with one
// complete row sum each; independent tiles would repeat the same denominator in
// four lanes. This schedule intentionally stays separate from softmax_window.
__device__ __forceinline__ void softmax_window_pair(layout::WindowAccumulatorTile<64> (&scores)[2])
{
	const int lane = threadIdx.x;
	std::uint32_t local_probability_sums[4];
	#pragma unroll
	for (int row = 0; row < 4; ++row)
	{
		auto& pairs = scores[row / 2].pair;
		const int row_half = row & 1;
		#pragma unroll
		for (int column = 0; column < 8; ++column)
			pairs[column][row_half] =
				window_attention_exponential(flashlight::PackedHalf2{pairs[column][row_half]}).bits;
		flashlight::PackedHalf2 sum = flashlight::numeric::half2_add(
			flashlight::PackedHalf2{pairs[0][row_half]}, flashlight::PackedHalf2{pairs[1][row_half]});
		#pragma unroll
		for (int column = 2; column < 8; column += 2)
			sum = flashlight::numeric::half2_add(
				sum, flashlight::numeric::half2_add(flashlight::PackedHalf2{pairs[column][row_half]},
													flashlight::PackedHalf2{pairs[column + 1][row_half]}));
		local_probability_sums[row] = sum.bits;
	}

	// Lane L owns row L: its original MMA row group is L%8 and its row-half
	// index is L/8. Transpose with four shuffles, then restore source lanes
	// 0,1,2,3 before adding so the native Half rounding order is unchanged.
	flashlight::warp::permute_quad(local_probability_sums, lane & 3);
	const int source_lane = ((lane & 7) << 2) | (lane >> 3);
	std::uint32_t gathered_probability_sums[4];
	#pragma unroll
	for (int row = 0; row < 4; ++row)
		gathered_probability_sums[row] = flashlight::arch::shuffle_index(
			local_probability_sums[row], source_lane ^ row, layout::warp_clamp, layout::warp_members);
	flashlight::warp::permute_quad(gathered_probability_sums, lane >> 3);
	flashlight::PackedHalf2 probability_sum =
		flashlight::numeric::half2_add(flashlight::PackedHalf2{gathered_probability_sums[0]},
									   flashlight::PackedHalf2{gathered_probability_sums[1]});
	probability_sum = flashlight::numeric::half2_add(probability_sum,
													 flashlight::PackedHalf2{gathered_probability_sums[2]});
	probability_sum = flashlight::numeric::half2_add(probability_sum,
													 flashlight::PackedHalf2{gathered_probability_sums[3]});
	probability_sum = flashlight::numeric::half2_add(probability_sum,
													 flashlight::numeric::half2_swap_lanes(probability_sum));
	const flashlight::PackedHalf2 inverse_denominator =
		flashlight::numeric::invert_replicated_half<false>(flashlight::numeric::half2_maximum(
			probability_sum, flashlight::PackedHalf2{layout::normalization_epsilon_half2}));

	#pragma unroll
	for (int row = 0; row < 4; ++row)
	{
		// One inverse per query row returns to all four MMA column lanes.
		const flashlight::PackedHalf2 row_inverse = flashlight::warp::shuffle_index(
			inverse_denominator, row * 8 + lane / 4, layout::warp_clamp, layout::warp_members);
		#pragma unroll
		for (int column = 0; column < 8; ++column)
			scores[row / 2].pair[column][row & 1] =
				flashlight::numeric::half2_multiply(
					flashlight::PackedHalf2{scores[row / 2].pair[column][row & 1]}, row_inverse)
					.bits;
	}
}

// Half-window pooling. Pooling two adjacent 4x4 tiles yields two rows of a 4x4
// destination. Swapping lane bits 2 and 3 changes the token grid from 4-wide to
// 2-wide; XOR 4/16 then selects the horizontal/vertical neighbours of each 2x2 cell.
__device__ __forceinline__ flashlight::PackedHalf2 pool_horizontal_words(flashlight::PackedHalf2 left_low,
																		 flashlight::PackedHalf2 left_high,
																		 flashlight::PackedHalf2 right_low,
																		 flashlight::PackedHalf2 right_high)
{
	const int lane = threadIdx.x;
	if (lane & 4)
	{
		const std::uint32_t saved_left_lower_rows = left_low.bits;
		const std::uint32_t saved_left_upper_rows = left_high.bits;
		left_low.bits = right_low.bits;
		right_low.bits = saved_left_lower_rows;
		left_high.bits = right_high.bits;
		right_high.bits = saved_left_upper_rows;
	}

	if (lane & 16)
	{
		const std::uint32_t saved_left_word = left_low.bits;
		const std::uint32_t saved_right_word = right_low.bits;
		left_low.bits = left_high.bits;
		right_low.bits = right_high.bits;
		left_high.bits = saved_left_word;
		right_high.bits = saved_right_word;
	}

	const int source_lane = (lane & 19) | ((lane << 1) & 8) | ((lane >> 1) & 4);
	const flashlight::PackedHalf2 top_left =
		flashlight::warp::shuffle_index(left_low, source_lane, layout::warp_clamp, layout::warp_members);
	const flashlight::PackedHalf2 top_right =
		flashlight::warp::shuffle_index(right_low, source_lane ^ 4, layout::warp_clamp, layout::warp_members);
	const flashlight::PackedHalf2 bottom_left = flashlight::warp::shuffle_index(
		left_high, source_lane ^ 16, layout::warp_clamp, layout::warp_members);
	const flashlight::PackedHalf2 bottom_right = flashlight::warp::shuffle_index(
		right_high, source_lane ^ 20, layout::warp_clamp, layout::warp_members);

	// Keep three rounded Half additions and a rounded quarter multiply; neither
	// FP32 averaging nor pooling an already published E4 image is equivalent.
	return flashlight::numeric::half2_multiply(
		flashlight::numeric::half2_add(flashlight::numeric::half2_add(top_left, top_right),
									   flashlight::numeric::half2_add(bottom_left, bottom_right)),
		flashlight::PackedHalf2{layout::half2_quarter});
}

__device__ __forceinline__ layout::WindowAccumulatorTile<32>
pool_window(const layout::WindowAccumulatorTile<32> (&input_tiles)[4])
{
	layout::WindowAccumulatorTile<32> pooled;
	#pragma unroll
	for (int column = 0; column < 4; ++column)
	{
		pooled.pair[column][0] =
			pool_horizontal_words(flashlight::PackedHalf2{input_tiles[0].pair[column][0]},
								  flashlight::PackedHalf2{input_tiles[0].pair[column][1]},
								  flashlight::PackedHalf2{input_tiles[1].pair[column][0]},
								  flashlight::PackedHalf2{input_tiles[1].pair[column][1]})
				.bits;
		pooled.pair[column][1] =
			pool_horizontal_words(flashlight::PackedHalf2{input_tiles[2].pair[column][0]},
								  flashlight::PackedHalf2{input_tiles[2].pair[column][1]},
								  flashlight::PackedHalf2{input_tiles[3].pair[column][0]},
								  flashlight::PackedHalf2{input_tiles[3].pair[column][1]})
				.bits;
	}

	return pooled;
}

// MMA output words are already Half A-fragment order. E4 combines two N16
// groups into one K32 fragment and converts at the original quantization boundary.
template <bool Fp8Storage, int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ uint4 load_window_ffn_input_fragment(
	const flashlight::tile::TiledMmaAccumulator<SpatialFragments, ChannelGroups>& accumulator, int spatial,
	int k_subtile)
{
	if constexpr (Fp8Storage)
	{
		const auto& lower = accumulator.word[spatial][k_subtile * 2];
		const auto& upper = accumulator.word[spatial][k_subtile * 2 + 1];
		return make_uint4(flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{lower[0]},
															flashlight::PackedHalf2{lower[2]})
							  .bits,
						  flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{lower[1]},
															flashlight::PackedHalf2{lower[3]})
							  .bits,
						  flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{upper[0]},
															flashlight::PackedHalf2{upper[2]})
							  .bits,
						  flashlight::numeric::publish_e4x4(flashlight::PackedHalf2{upper[1]},
															flashlight::PackedHalf2{upper[3]})
							  .bits);
	}
	else
	{
		const auto& words = accumulator.word[spatial][k_subtile];
		return make_uint4(words[0], words[1], words[2], words[3]);
	}
}

// Grouped E4 GEMMs issue one K32 across all M/N tiles before the next K32. The
// dense and Half grouped GEMMs use the common two-K schedule instead.
template <int SpatialFragments, int ChannelGroups>
__device__ __forceinline__ void accumulate_window_ffn_single_fp8(
	flashlight::tile::TiledMmaAccumulator<SpatialFragments, ChannelGroups>& accumulator,
	const uint4 (&input)[SpatialFragments], const uint4 (&weights)[ChannelGroups])
{
	#pragma unroll
	for (int spatial = 0; spatial < SpatialFragments; ++spatial)
		#pragma unroll
		for (int n_tile = 0; n_tile < ChannelGroups; ++n_tile)
		{
			auto& words = accumulator.word[spatial][n_tile];
			const uint4 input_fragment = input[spatial];
			const uint4 weight_fragment = weights[n_tile];
			const flashlight::MmaAFragment<flashlight::InputPrecision::E4M3> left{
				{input_fragment.x, input_fragment.y, input_fragment.z, input_fragment.w}};
			flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> low{{words[0], words[1]}};
			flashlight::arch::mma_sync(low, left,
									   flashlight::MmaBFragment<flashlight::InputPrecision::E4M3>{
										   {weight_fragment.x, weight_fragment.y}});
			words[0] = low.word[0];
			words[1] = low.word[1];
			flashlight::MmaAccumulator<flashlight::AccumulatorPrecision::Half> high{{words[2], words[3]}};
			flashlight::arch::mma_sync(high, left,
									   flashlight::MmaBFragment<flashlight::InputPrecision::E4M3>{
										   {weight_fragment.z, weight_fragment.w}});
			words[2] = high.word[0];
			words[3] = high.word[1];
		}
}

// Publish one projected pooled tile into the downsampled channel planes. C32
// writes compact half extents; wider entries round those extents to four. The
// native padding clear follows these stores, so our own padded word is zeroed
// here to avoid the same-cell race.
template <int Channels, bool Fp8Storage>
__device__ __forceinline__ void publish_window_downsample(const layout::WindowDownsampleArguments& parameters,
														  int output_panel,
														  const layout::WindowAccumulatorTile<32>& output)
{
	const int valid_height = (parameters.height + 1) / 2;
	const int valid_width = (parameters.width + 1) / 2;
	const int height = Channels == 32 ? parameters.height / 2 : (valid_height + 3) & ~3;
	const int width = Channels == 32 ? parameters.width / 2 : (valid_width + 3) & ~3;
	const int origin_x = (int(blockIdx.x) * 8 + parameters.origin_x) / 2;
	const int origin_y = (int(blockIdx.y) * 8 + parameters.origin_y) / 2;
	#pragma unroll
	for (int chunk = 0; chunk < layout::Window32Profile<Fp8Storage>::input_chunks; ++chunk)
	{
		const auto fragment = publish_window_chunk<Fp8Storage>(output, chunk);
		#pragma unroll
		for (int word = 0; word < 4; ++word)
		{
			const int x = origin_x + ((threadIdx.x / 4) & 3);
			const int y = origin_y + threadIdx.x / 16 + 2 * (word & 1);
			if (x >= 0 && x < width && y >= 0 && y < height)
			{
				const int plane = output_panel * 2 * layout::Window32Profile<Fp8Storage>::input_chunks +
								  2 * chunk + word / 2;
				const std::uint64_t address = parameters.downsampled_output +
											  ((std::uint64_t(plane * height + y) * width + x) * 16) +
											  4 * (threadIdx.x & 3);
				flashlight::memory::store_vector<std::uint32_t>(
					flashlight::memory::GlobalAddress(address),
					x < valid_width && y < valid_height ? fragment.word[word] : 0u);
			}
		}
	}
}

// Clear only the padded cells of the caller-provided downsampled target. A
// larger target may extend past every launched window; CTA zero owns that
// uncovered border, exactly as the native clear path does.
template <int Channels, int ClearPlanes = Channels / 4>
__device__ __forceinline__ void
clear_window_downsample_padding(const layout::WindowDownsampleArguments& parameters)
{
	const int valid_height = (parameters.height + 1) / 2;
	const int valid_width = (parameters.width + 1) / 2;
	if (parameters.downsampled_output == 0 ||
		(parameters.downsampled_height <= valid_height && parameters.downsampled_width <= valid_width))
		return;
	const int origin_x = (int(blockIdx.x) * 8 + parameters.origin_x) / 2;
	const int origin_y = (int(blockIdx.y) * 8 + parameters.origin_y) / 2;
	const int thread_index = threadIdx.y * 32 + threadIdx.x;

	for (int index = thread_index; index < 16 * ClearPlanes; index += Channels)
	{
		const int plane = index % ClearPlanes;
		const int x = origin_x + (index / ClearPlanes) % 4;
		const int y = origin_y + index / (4 * ClearPlanes);
		if (x >= 0 && x < parameters.downsampled_width && y >= 0 && y < parameters.downsampled_height &&
			(x >= valid_width || y >= valid_height))
		{
			const std::uint64_t address =
				parameters.downsampled_output +
				((std::uint64_t(plane * parameters.downsampled_height + y) * parameters.downsampled_width +
				  x) *
				 16);
			flashlight::memory::store_vector<uint4>(flashlight::memory::GlobalAddress(address),
													make_uint4(0, 0, 0, 0));
		}
	}

	if (blockIdx.x == 0 && blockIdx.y == 0 && blockIdx.z == 0)
	{
		const int covered_height = max(
			valid_height, min(parameters.downsampled_height, (int(gridDim.y) * 8 + parameters.origin_y) / 2));
		const int covered_width = max(
			valid_width, min(parameters.downsampled_width, (int(gridDim.x) * 8 + parameters.origin_x) / 2));
		const int bottom_pixels =
			(parameters.downsampled_height - covered_height) * parameters.downsampled_width;
		const int right_pixels = covered_height * (parameters.downsampled_width - covered_width);
		for (int index = thread_index; index < (bottom_pixels + right_pixels) * ClearPlanes;
			 index += Channels)
		{
			const int plane = index % ClearPlanes, pixel = index / ClearPlanes;
			const bool bottom = pixel < bottom_pixels;
			const int right_width = parameters.downsampled_width - covered_width;
			const int y = bottom ? covered_height + pixel / parameters.downsampled_width
								 : (pixel - bottom_pixels) / right_width;
			const int x = bottom ? pixel % parameters.downsampled_width
								 : covered_width + (pixel - bottom_pixels) % right_width;
			const std::uint64_t address =
				parameters.downsampled_output +
				((std::uint64_t(plane * parameters.downsampled_height + y) * parameters.downsampled_width +
				  x) *
				 16);
			flashlight::memory::store_vector<uint4>(flashlight::memory::GlobalAddress(address),
													make_uint4(0, 0, 0, 0));
		}
	}
}

#endif // SM80+
} // namespace ops
} // namespace dlssnr
