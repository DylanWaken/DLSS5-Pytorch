#pragma once
// FlashLight core contracts: precision tags, packed carriers and the exact
// register fragments consumed by mma.sync. This header is intentionally free of
// Torch, project and model dependencies; it is the common prerequisite for the
// arch, numeric, memory, layout and tile layers.
#include <cuda_runtime.h>
#include <cuda_fp16.h>
#include <cstddef>
#include <cstdint>
#include <type_traits>

namespace flashlight
{
// Input operand encoding. K follows the recovered PTX forms: FP16 m16n8k16 and
// E4M3 m16n8k32. These are accuracy/instruction classes, not model parameters.
enum class InputPrecision : std::uint8_t
{
	Fp16,
	E4M3
};

// Destination/accumulator register class. Half accumulation keeps two packed
// Half2 words; float accumulation keeps four scalar FP32 registers.
enum class AccumulatorPrecision : std::uint8_t
{
	Half,
	Float
};

// One packed pair of IEEE binary16 values. No conversion is implied by the
// carrier; `bits` is the exact 32-bit register payload.
struct PackedHalf2
{
	std::uint32_t bits;
};

// Four E4M3 bytes in the byte order produced by the native packing instruction.
struct PackedE4x4
{
	std::uint32_t bits;
};

// Four packed Half2 words (eight Half values): the carrier used by the
// split-publication path. Storage stays four scalar 32-bit registers.
struct PackedHalf2x4
{
	std::uint32_t word[4];
};

static_assert(sizeof(PackedHalf2) == 4 && alignof(PackedHalf2) == 4,
			  "PackedHalf2 must remain one 32-bit register");
static_assert(sizeof(PackedE4x4) == 4 && alignof(PackedE4x4) == 4,
			  "PackedE4x4 must remain one 32-bit register");
static_assert(sizeof(PackedHalf2x4) == 16 && alignof(PackedHalf2x4) == 4,
			  "PackedHalf2x4 must remain four scalar 32-bit registers");
static_assert(std::is_standard_layout_v<PackedHalf2> && std::is_trivially_copyable_v<PackedHalf2>);
static_assert(std::is_standard_layout_v<PackedE4x4> && std::is_trivially_copyable_v<PackedE4x4>);
static_assert(std::is_standard_layout_v<PackedHalf2x4> && std::is_trivially_copyable_v<PackedHalf2x4>);

__host__ __device__ constexpr std::uint32_t packed_bits(PackedHalf2 value) noexcept
{
	return value.bits;
}

__host__ __device__ constexpr std::uint32_t packed_bits(PackedE4x4 value) noexcept
{
	return value.bits;
}

// Per-precision instruction traits. `k` is the single-instruction reduction
// extent and the operand word counts are the recovered fragment contracts.
template <InputPrecision Precision> struct MmaInputTraits;

template <> struct MmaInputTraits<InputPrecision::Fp16>
{
	static constexpr int k = 16;
	static constexpr int a_words = 4;
	static constexpr int b_words = 2;
};

template <> struct MmaInputTraits<InputPrecision::E4M3>
{
	static constexpr int k = 32;
	static constexpr int a_words = 4;
	static constexpr int b_words = 2;
};

// Left operand A: four lane-owned packed words in mma.sync operand order.
template <InputPrecision Precision> struct MmaAFragment
{
	std::uint32_t word[MmaInputTraits<Precision>::a_words];
};

// Right operand B: two lane-owned packed words in mma.sync operand order.
template <InputPrecision Precision> struct MmaBFragment
{
	std::uint32_t word[MmaInputTraits<Precision>::b_words];
};

// Accumulator/result register contract. The primary template is intentionally
// undefined so a new accumulator class cannot appear by accident.
template <AccumulatorPrecision Precision> struct MmaAccumulator;

template <> struct MmaAccumulator<AccumulatorPrecision::Half>
{
	std::uint32_t word[2];
};

template <> struct MmaAccumulator<AccumulatorPrecision::Float>
{
	float value[4];
};

static_assert(sizeof(MmaAFragment<InputPrecision::Fp16>) == 16 &&
				  alignof(MmaAFragment<InputPrecision::Fp16>) == 4,
			  "FP16 A fragment must remain four scalar 32-bit words");
static_assert(sizeof(MmaAFragment<InputPrecision::E4M3>) == 16 &&
				  alignof(MmaAFragment<InputPrecision::E4M3>) == 4,
			  "E4M3 A fragment must remain four scalar 32-bit words");
static_assert(sizeof(MmaBFragment<InputPrecision::Fp16>) == 8 &&
				  alignof(MmaBFragment<InputPrecision::Fp16>) == 4,
			  "FP16 B fragment must remain two scalar 32-bit words");
static_assert(sizeof(MmaBFragment<InputPrecision::E4M3>) == 8 &&
				  alignof(MmaBFragment<InputPrecision::E4M3>) == 4,
			  "E4M3 B fragment must remain two scalar 32-bit words");
static_assert(sizeof(MmaAccumulator<AccumulatorPrecision::Half>) == 8 &&
				  alignof(MmaAccumulator<AccumulatorPrecision::Half>) == 4,
			  "Half accumulator must remain two packed Half2 words");
static_assert(sizeof(MmaAccumulator<AccumulatorPrecision::Float>) == 16 &&
				  alignof(MmaAccumulator<AccumulatorPrecision::Float>) == 4,
			  "Float accumulator must remain four scalar FP32 registers");
static_assert(std::is_standard_layout_v<MmaAFragment<InputPrecision::Fp16>> &&
			  std::is_trivially_copyable_v<MmaAFragment<InputPrecision::Fp16>>);
static_assert(std::is_standard_layout_v<MmaAFragment<InputPrecision::E4M3>> &&
			  std::is_trivially_copyable_v<MmaAFragment<InputPrecision::E4M3>>);
static_assert(std::is_standard_layout_v<MmaBFragment<InputPrecision::Fp16>> &&
			  std::is_trivially_copyable_v<MmaBFragment<InputPrecision::Fp16>>);
static_assert(std::is_standard_layout_v<MmaBFragment<InputPrecision::E4M3>> &&
			  std::is_trivially_copyable_v<MmaBFragment<InputPrecision::E4M3>>);
static_assert(std::is_standard_layout_v<MmaAccumulator<AccumulatorPrecision::Half>> &&
			  std::is_trivially_copyable_v<MmaAccumulator<AccumulatorPrecision::Half>>);
static_assert(std::is_standard_layout_v<MmaAccumulator<AccumulatorPrecision::Float>> &&
			  std::is_trivially_copyable_v<MmaAccumulator<AccumulatorPrecision::Float>>);

} // namespace flashlight
