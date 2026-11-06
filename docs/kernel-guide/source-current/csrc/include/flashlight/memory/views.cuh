#pragma once
// Minimal typed address/view layer over the exact memory primitives.
//
// SharedBytes and GlobalAddress carry byte addresses with explicit units.
// Accessors do not synchronize: a shared load is only as safe as the caller's
// preceding CTA/warp protocol, and a global load assumes caller-validated
// alignment. `load_vector_or_zero` never dereferences an invalid address.
#include <flashlight/core.cuh>
#include <flashlight/arch/memory.cuh>
#include <flashlight/layout/strided.cuh>
#include <cstddef>
#include <cstdint>
#include <type_traits>

namespace flashlight
{
namespace memory
{
// Cache qualifier applied by the global load APIs. It is a policy tag, not a
// persistence hint and not a substitute for a memory-ordering operation.
enum class CachePolicy : std::uint8_t
{
	Ca,
	Cg
};

// 64-bit global address carrier. A null value is a valid "no object" sentinel;
// it must be checked before any dereference.
class GlobalAddress
{
  public:
	__host__ __device__ constexpr GlobalAddress() noexcept : value_(0) {}

	__host__ __device__ explicit constexpr GlobalAddress(std::uint64_t value) noexcept : value_(value) {}

	__host__ __device__ constexpr std::uint64_t value() const noexcept
	{
		return value_;
	}

	__host__ __device__ constexpr GlobalAddress offset(std::uint64_t byte_offset) const noexcept
	{
		return GlobalAddress(value_ + byte_offset);
	}

	template <typename T> __device__ __forceinline__ T* as_pointer() const
	{
		return reinterpret_cast<T*>(value_);
	}

  private:
	std::uint64_t value_;
};

static_assert(sizeof(GlobalAddress) == 8 && alignof(GlobalAddress) == 8,
			  "GlobalAddress must remain one 64-bit carrier");

#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 800
// View over a generic shared pointer. Offsets are always bytes. This type adds
// no synchronization and no implicit alignment repair.
class SharedBytes
{
  public:
	__device__ __forceinline__ explicit SharedBytes(void* shared_base)
		: base_(static_cast<unsigned char*>(shared_base))
	{
	}

	__device__ __forceinline__ unsigned char* data() const
	{
		return base_;
	}

	__device__ __forceinline__ std::uint32_t address(std::uint32_t byte_offset) const
	{
		return arch::shared_address(base_, byte_offset);
	}

	template <typename T> __device__ __forceinline__ T* pointer(std::size_t byte_offset) const
	{
		static_assert(std::is_trivially_copyable_v<T>, "Shared view requires trivially copyable T");
		return reinterpret_cast<T*>(base_ + byte_offset);
	}

	template <typename T> __device__ __forceinline__ T& at(std::size_t byte_offset) const
	{
		return *pointer<T>(byte_offset);
	}

	template <typename T> __device__ __forceinline__ T load(std::size_t byte_offset) const
	{
		return *pointer<T>(byte_offset);
	}

	template <typename T> __device__ __forceinline__ void store(std::size_t byte_offset, T value) const
	{
		*pointer<T>(byte_offset) = value;
	}

  private:
	unsigned char* base_;
};

// Typed shared view with a byte origin and a compile-time stride pack. Layout is
// expected to provide a static constexpr `offset(coordinates...)` in bytes, for
// example `layout::ByteStrides<TileBytes, PanelBytes, ChunkBytes, LaneBytes>`.
// No synchronization is added.
template <typename T, typename Layout> class SharedLayoutView
{
  public:
	__device__ __forceinline__ SharedLayoutView(SharedBytes shared, std::uint32_t origin_bytes = 0)
		: shared_(shared), origin_bytes_(origin_bytes)
	{
	}

	__device__ __forceinline__ T& byte_at(std::uint32_t absolute_byte_offset) const
	{
		return shared_.at<T>(absolute_byte_offset);
	}

	// Absolute byte offset from the SharedBytes base, including this view's
	// origin. Bulk-copy destinations use this same coordinate math.
	template <typename... Coordinates>
	__device__ __forceinline__ std::uint32_t byte_offset(Coordinates... coordinates) const
	{
		return origin_bytes_ + Layout::offset(coordinates...);
	}

	template <typename... Coordinates> __device__ __forceinline__ T* pointer(Coordinates... coordinates) const
	{
		return shared_.pointer<T>(byte_offset(coordinates...));
	}

	template <typename... Coordinates> __device__ __forceinline__ T& at(Coordinates... coordinates) const
	{
		return *pointer(coordinates...);
	}

	template <typename... Coordinates> __device__ __forceinline__ T load(Coordinates... coordinates) const
	{
		return *pointer(coordinates...);
	}

	template <typename... Coordinates>
	__device__ __forceinline__ void store(T value, Coordinates... coordinates) const
	{
		*pointer(coordinates...) = value;
	}

  private:
	SharedBytes shared_;
	std::uint32_t origin_bytes_;
};

// Staged ring view: the stage coordinate is reduced modulo StageCount and scaled
// by StageBytes before the within-stage Layout offset. This preserves the native
// `(stage % count) * bytes + chunk*stride + lane*stride` arithmetic without
// rebuilding it at each call site.
template <typename T, typename Layout, std::uint32_t StageCount, std::uint32_t StageBytes>
class StagedSharedLayoutView
{
  public:
	static_assert(StageCount > 0, "Stage ring must contain at least one stage");
	static_assert(StageBytes > 0, "Stage bytes must be non-zero");

	__device__ __forceinline__ StagedSharedLayoutView(SharedBytes shared, std::uint32_t origin_bytes = 0)
		: view_(shared, origin_bytes)
	{
	}

	// Absolute byte offset for an already-reduced slot. The caller guarantees
	// slot < StageCount; no extra modulo or runtime bounds check is generated.
	// The origin is included exactly once, just as in the wrapping API below.
	template <typename... Coordinates>
	__device__ __forceinline__ std::uint32_t byte_offset_slot(std::uint32_t slot,
															  Coordinates... coordinates) const
	{
		return view_.byte_offset(coordinates...) + slot * StageBytes;
	}

	// Absolute byte offset from the SharedBytes base for a raw stage iteration.
	// This wrapping API owns the modulo; callers with a slot use *_slot instead.
	template <typename... Coordinates>
	__device__ __forceinline__ std::uint32_t byte_offset(std::uint32_t stage,
														 Coordinates... coordinates) const
	{
		return byte_offset_slot(stage % StageCount, coordinates...);
	}

	template <typename... Coordinates>
	__device__ __forceinline__ T& at_slot(std::uint32_t slot, Coordinates... coordinates) const
	{
		return view_.byte_at(byte_offset_slot(slot, coordinates...));
	}

	template <typename... Coordinates>
	__device__ __forceinline__ T load_slot(std::uint32_t slot, Coordinates... coordinates) const
	{
		return at_slot(slot, coordinates...);
	}

	template <typename... Coordinates>
	__device__ __forceinline__ void store_slot(T value, std::uint32_t slot, Coordinates... coordinates) const
	{
		at_slot(slot, coordinates...) = value;
	}

	template <typename... Coordinates>
	__device__ __forceinline__ T& at(std::uint32_t stage, Coordinates... coordinates) const
	{
		return at_slot(stage % StageCount, coordinates...);
	}

	template <typename... Coordinates>
	__device__ __forceinline__ T load(std::uint32_t stage, Coordinates... coordinates) const
	{
		return load_slot(stage % StageCount, coordinates...);
	}

	template <typename... Coordinates>
	__device__ __forceinline__ void store(T value, std::uint32_t stage, Coordinates... coordinates) const
	{
		store_slot(value, stage % StageCount, coordinates...);
	}

  private:
	SharedLayoutView<T, Layout> view_;
};

// Cache-qualified global vector/scalar load. The caller owns alignment/validity.
template <CachePolicy Policy, typename T> __device__ __forceinline__ T load_vector(GlobalAddress address)
{
	if constexpr (Policy == CachePolicy::Ca)
		return arch::load_global_ca(address.as_pointer<const T>());
	else
		return arch::load_global_cg(address.as_pointer<const T>());
}

template <CachePolicy Policy, typename T> struct GlobalLoadOrZero
{
	__device__ __forceinline__ static T load(GlobalAddress address, bool valid)
	{
		if (!valid)
			return T{};
		return load_vector<Policy, T>(address);
	}
};

// The 16-byte cache-all form keeps the original predicated PTX so an invalid
// address is never dereferenced or speculated.
template <CachePolicy Policy> struct GlobalLoadOrZero<Policy, uint4>
{
	__device__ __forceinline__ static uint4 load(GlobalAddress address, bool valid)
	{
		if constexpr (Policy == CachePolicy::Ca)
		{
			return arch::load_global_ca_or_zero(address.value(), valid);
		}
		else
		{
			if (!valid)
				return make_uint4(0, 0, 0, 0);
			return arch::load_global_cg(address.as_pointer<const uint4>());
		}
	}
};

// Conditional load returning a zero carrier when `valid` is false. The invalid
// branch performs no memory access.
template <CachePolicy Policy, typename T>
__device__ __forceinline__ T load_vector_or_zero(GlobalAddress address, bool valid)
{
	return GlobalLoadOrZero<Policy, T>::load(address, valid);
}

// Plain aligned global store. Distinct from the no-allocate API below.
template <typename T> __device__ __forceinline__ void store_vector(GlobalAddress address, T value)
{
	*address.as_pointer<T>() = value;
}

// Aligned 16-byte store that does not allocate an L1 line.
__device__ __forceinline__ void store_no_allocate(GlobalAddress address, uint4 packed_words)
{
	arch::store_no_allocate(address.value(), packed_words);
}

#endif // SM80+
} // namespace memory
} // namespace flashlight
