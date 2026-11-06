#pragma once
// Recovered DLSSNR global-attention numeric compositions.
//
// The global exponential surrogate, head-channel sum order and Q/K normalization
// are model behavior. Generic packed Half arithmetic, shuffles and tiled MMA
// storage come from FlashLight. Distinct window/global schedules remain separate.
#include <flashlight/core.cuh>
#include <flashlight/arch/math.cuh>
#include <flashlight/arch/warp.cuh>
#include <flashlight/layout/strided.cuh>
#include <flashlight/memory/pipeline.cuh>
#include <flashlight/memory/views.cuh>
#include <flashlight/numeric/packed.cuh>
#include <flashlight/tile/mma.cuh>
#include "../layout/global_profiles.h"
#include "../layout/numerical_constants.h"
#include <cstdint>

namespace dlssnr
{
namespace ops
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
// ---------------------------------------------------------------------------
// Streaming global-attention K/V ring.
//
// Two stages of K then two stages of V occupy the CTA shared array. A producer
// writes 512-byte chunks at (stage, copy slot, lane); the consumer reads the same
// bytes at (stage, column tile * query chunks + reduction chunk, lane). The value
// ring is the same geometry at Profile::value_offset. The exporting entries own
// the shared array, the copy election and every barrier.
// ---------------------------------------------------------------------------
template <bool Fp8Storage>
using GlobalAttentionKeyView = flashlight::memory::StagedSharedLayoutView<
	uint4,
	flashlight::layout::ByteStrides<layout::GlobalAttentionProfile<Fp8Storage>::copy_bytes,
									layout::GlobalAttentionProfile<Fp8Storage>::lane_bytes>,
	layout::GlobalAttentionProfile<Fp8Storage>::stage_count,
	layout::GlobalAttentionProfile<Fp8Storage>::stage_bytes>;

template <bool Fp8Storage>
using GlobalAttentionValueView = flashlight::memory::StagedSharedLayoutView<
	uint4,
	flashlight::layout::ByteStrides<layout::GlobalAttentionProfile<Fp8Storage>::copy_bytes,
									layout::GlobalAttentionProfile<Fp8Storage>::lane_bytes>,
	layout::GlobalAttentionProfile<Fp8Storage>::stage_count,
	layout::GlobalAttentionProfile<Fp8Storage>::stage_bytes>;

template <bool Fp8Storage>
using GlobalAttentionBarrierRing =
	flashlight::memory::TransactionBarrierRing<layout::GlobalAttentionProfile<Fp8Storage>::stage_count>;

template <bool Fp8Storage>
__device__ __forceinline__ GlobalAttentionKeyView<Fp8Storage>
global_attention_key_view(flashlight::memory::SharedBytes shared)
{
	return GlobalAttentionKeyView<Fp8Storage>(shared);
}

template <bool Fp8Storage>
__device__ __forceinline__ GlobalAttentionValueView<Fp8Storage>
global_attention_value_view(flashlight::memory::SharedBytes shared)
{
	return GlobalAttentionValueView<Fp8Storage>(shared,
												layout::GlobalAttentionProfile<Fp8Storage>::value_offset);
}

template <bool Fp8Storage>
__device__ __forceinline__ GlobalAttentionBarrierRing<Fp8Storage>
global_attention_barrier_ring(flashlight::memory::SharedBytes shared)
{
	return GlobalAttentionBarrierRing<Fp8Storage>(shared,
												  layout::GlobalAttentionProfile<Fp8Storage>::barrier_offset);
}

// ---------------------------------------------------------------------------
// Global contraction/projection input ring.
//
// One staged ring is produced as adjacent 512-byte copies and consumed as a row
// group of spatial fragments plus K subtiles. The two views below name the
// identical bytes: the producer origin is the copy slot, the consumer origin is
// the warp row group plus the lane vector. Only recovered model strides live
// here; the copies/barriers stay owned by each exporting kernel.
// ---------------------------------------------------------------------------
template <typename Profile>
using GlobalContractStageView = flashlight::memory::StagedSharedLayoutView<
	uint4, flashlight::layout::ByteStrides<static_cast<std::uint32_t>(Profile::group_bytes), 512u>,
	static_cast<std::uint32_t>(Profile::stage_count), static_cast<std::uint32_t>(Profile::stage_bytes)>;

template <typename Profile>
using GlobalContractCopyView = flashlight::memory::StagedSharedLayoutView<
	uint4, flashlight::layout::ByteStrides<static_cast<std::uint32_t>(Profile::copy_bytes), 512u, 16u>,
	static_cast<std::uint32_t>(Profile::stage_count), static_cast<std::uint32_t>(Profile::stage_bytes)>;

// Producer view over the whole staged ring (origin 0).
template <typename Profile>
__device__ __forceinline__ GlobalContractCopyView<Profile>
make_global_contract_copy_view(flashlight::memory::SharedBytes shared)
{
	return GlobalContractCopyView<Profile>(shared);
}

// Consumer view: this warp row group's four spatial fragments start at
// (warp >> 1) * 4 * group_bytes, and the lane owns one 16-byte A vector.
template <typename Profile>
__device__ __forceinline__ GlobalContractStageView<Profile>
make_global_contract_stage_view(flashlight::memory::SharedBytes shared, std::uint32_t warp,
								std::uint32_t lane)
{
	return GlobalContractStageView<Profile>(
		shared, (warp >> 1) * 4 * static_cast<std::uint32_t>(Profile::group_bytes) + lane * 16);
}

// Consume one ready staged input slice: load the four spatial A fragments and
// their K subtiles for this lane, then run the recovered MMA tile order. The
// stage argument is a raw reduction iteration, so the wrapping view owns the
// ring modulo; producer election and barrier waits stay with the caller.
template <typename Profile, int ChannelGroups>
__device__ __forceinline__ void
consume_global_contract_input_stage(flashlight::tile::TiledMmaAccumulator<4, ChannelGroups>& accumulator,
									const uint4 (&weights)[Profile::reduction_subtiles][ChannelGroups],
									const GlobalContractStageView<Profile>& stage, int reduction_tile)
{
	uint4 input[4][Profile::reduction_subtiles];
	#pragma unroll
	for (int spatial = 0; spatial < 4; ++spatial)
		#pragma unroll
		for (int k_subtile = 0; k_subtile < Profile::reduction_subtiles; ++k_subtile)
			input[spatial][k_subtile] = stage.load(reduction_tile, spatial, k_subtile);
	flashlight::tile::accumulate_tile<Profile::precision>(accumulator, input, weights);
}

// Global attention uses a different affine approximation/encoding than windows.
__device__ __forceinline__ flashlight::PackedHalf2
global_attention_exponential(flashlight::PackedHalf2 scores)
{
	const flashlight::PackedHalf2 affine =
		flashlight::numeric::half2_fma(scores, flashlight::PackedHalf2{layout::global_exp_slope_half2},
									   flashlight::PackedHalf2{layout::global_exp_intercept_half2});
	const flashlight::PackedHalf2 bounded = flashlight::numeric::half2_minimum(
		flashlight::numeric::half2_maximum(affine, flashlight::PackedHalf2{layout::global_exp_lower_half2}),
		flashlight::PackedHalf2{layout::global_exp_upper_half2});
	return flashlight::PackedHalf2{(bounded.bits << layout::global_exp_encoding_shift) +
								   layout::global_exp_encoding_offset};
}

// Four lane groups cover the 32 head channels. Keep the Half sum order, including
// the final exchange of the low and high packed Half values.
__device__ __forceinline__ flashlight::PackedHalf2 sum_head_channels(flashlight::PackedHalf2 sum)
{
	sum = flashlight::numeric::half2_add(sum, flashlight::PackedHalf2{flashlight::arch::shuffle_xor(
												  sum.bits, 2, layout::warp_clamp, layout::warp_members)});
	sum = flashlight::numeric::half2_add(sum, flashlight::PackedHalf2{flashlight::arch::shuffle_xor(
												  sum.bits, 1, layout::warp_clamp, layout::warp_members)});
	return flashlight::numeric::half2_add(sum, flashlight::numeric::half2_swap_lanes(sum));
}

// Invert the replicated head sum. The FP8 path exploits the fact that both Half
// lanes are identical and performs one conversion/SFU path; the Half path keeps
// the native per-lane reciprocal-square-root composition.
template <bool Fp8Storage>
__device__ __forceinline__ flashlight::PackedHalf2 invert_head_sum(flashlight::PackedHalf2 sum)
{
	if constexpr (Fp8Storage)
	{
		const float squared_norm = __half2float(__ushort_as_half(std::uint16_t(sum.bits)));
		const std::uint16_t inverse_norm_half =
			__half_as_ushort(__float2half_rn(flashlight::arch::rsqrt_approx_ftz(squared_norm)));
		return flashlight::PackedHalf2{
			flashlight::numeric::join_halfwords(inverse_norm_half, inverse_norm_half)};
	}
	else
	{
		return flashlight::numeric::half2_rsqrt_approx(sum);
	}
}

// Shared arithmetic for the Q and K components: exact packed-Half reduction and
// normalization. Their distinct head-scale rule is a compile-time choice.
template <bool Fp8Storage, int Component>
__device__ __forceinline__ void normalize_head(flashlight::tile::TiledMmaAccumulator<4, 6>& accumulator,
											   std::uint64_t packed_weights, int head)
{
	const flashlight::PackedHalf2 epsilon{layout::normalization_epsilon_half2};
	const flashlight::PackedHalf2 sqrt_head_dimension =
		flashlight::numeric::half2_from_float_bits(__float_as_uint(
			flashlight::arch::sqrt_approx_ftz(__uint_as_float(layout::attention_head_dimension_fp32_bits))));
	#pragma unroll
	for (int spatial = 0; spatial < 4; ++spatial)
	{
		auto& lower_channel_words = accumulator.word[spatial][Component * 2];
		auto& upper_channel_words = accumulator.word[spatial][Component * 2 + 1];
		std::uint32_t squared_pairs[4];
		#pragma unroll
		for (int word = 0; word < 4; ++word)
			squared_pairs[word] =
				flashlight::numeric::half2_add(
					flashlight::numeric::half2_multiply(flashlight::PackedHalf2{lower_channel_words[word]},
														flashlight::PackedHalf2{lower_channel_words[word]}),
					flashlight::numeric::half2_multiply(flashlight::PackedHalf2{upper_channel_words[word]},
														flashlight::PackedHalf2{upper_channel_words[word]}))
					.bits;
		const flashlight::PackedHalf2 squared_sum_low = flashlight::numeric::half2_add(
			flashlight::PackedHalf2{squared_pairs[2]}, flashlight::PackedHalf2{squared_pairs[0]});
		const flashlight::PackedHalf2 squared_sum_high = flashlight::numeric::half2_add(
			flashlight::PackedHalf2{squared_pairs[3]}, flashlight::PackedHalf2{squared_pairs[1]});
		const flashlight::PackedHalf2 inverse_norm[2] = {
			invert_head_sum<Fp8Storage>(
				flashlight::numeric::half2_maximum(sum_head_channels(squared_sum_low), epsilon)),
			invert_head_sum<Fp8Storage>(
				flashlight::numeric::half2_maximum(sum_head_channels(squared_sum_high), epsilon))};
		#pragma unroll
		for (int n16 = 0; n16 < 2; ++n16)
		{
			#pragma unroll
			for (int word = 0; word < 4; ++word)
			{
				auto& head_channel_pair = accumulator.word[spatial][Component * 2 + n16][word];
				head_channel_pair = flashlight::numeric::half2_multiply(
										flashlight::PackedHalf2{head_channel_pair}, inverse_norm[word & 1])
										.bits;
				if constexpr (Component == 0)
				{
					const flashlight::PackedHalf2 head_scale = flashlight::numeric::half2_from_float_bits(
						*reinterpret_cast<const std::uint32_t*>(packed_weights + head * 4));
					head_channel_pair =
						flashlight::numeric::half2_multiply(
							flashlight::numeric::half2_multiply(flashlight::PackedHalf2{head_channel_pair},
																sqrt_head_dimension),
							head_scale)
							.bits;
				}
			}
		}
	}
}

#endif // SM80+
} // namespace ops
} // namespace dlssnr
