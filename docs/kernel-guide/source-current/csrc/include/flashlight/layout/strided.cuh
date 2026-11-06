#pragma once
// Compile-time byte-stride coordinate arithmetic for explicit shared/global
// layouts.
//
// All strides are caller-supplied template arguments; this header defines no
// model, tile or pipeline defaults. `ByteStrides::offset` only folds integer
// coordinates into byte offsets and contains no swizzle. The tree has zero XOR
// shared/global address swizzles, so none is invented here. Callers own model
// and tensor coordinates.
#include <cuda_runtime.h>
#include <cstdint>

namespace flashlight
{
namespace layout
{
// Zipped compile-time stride pack. `offset(a, b, c, d)` is exactly
// a*S0 + b*S1 + c*S2 + d*S3 without runtime stride arrays. Coordinates are
// integer tile/panel/chunk/lane indices; strides and results are bytes.
template <std::uint32_t... Strides> struct ByteStrides;

template <> struct ByteStrides<>
{
	template <typename... Coordinates>
	__host__ __device__ static constexpr std::uint32_t offset(Coordinates...) noexcept
	{
		static_assert(sizeof...(Coordinates) == 0, "ByteStrides rank mismatch");
		return 0;
	}
};

template <std::uint32_t First, std::uint32_t... Rest> struct ByteStrides<First, Rest...>
{
	static constexpr std::uint32_t rank = 1 + sizeof...(Rest);

	template <typename FirstCoordinate, typename... Coordinates>
	__host__ __device__ static constexpr std::uint32_t offset(FirstCoordinate first,
															  Coordinates... rest) noexcept
	{
		static_assert(sizeof...(Coordinates) == sizeof...(Rest), "ByteStrides rank mismatch");
		return std::uint32_t(first) * First + ByteStrides<Rest...>::offset(rest...);
	}
};

} // namespace layout
} // namespace flashlight
