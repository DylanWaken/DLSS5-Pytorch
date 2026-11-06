#pragma once
// Typed writes into the fixed 96-byte by-value launch records. The public
// Python/Torch signatures, FKernelCall byte storage and recovered struct
// offsets are unchanged; these helpers only centralize the raw memcpy contract
// and its bounds check.
#include "common/host/physical_tensor.h"
#include <array>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <type_traits>

namespace dlssnr
{
namespace host
{

// Every prepared descriptor and plan call stores one complete native record.
using FParameterBlock = std::array<unsigned char, 96>;

// A descriptor binding names one pointer field and one argument-list index.
struct FPhysicalTensorBinding
{
	size_t ParameterOffset;
	size_t TensorIndex;
	bool bMutable;
};

template <class TValue>
inline void WriteParameterField(unsigned char* Block, size_t BlockBytes, size_t Offset, TValue Value,
								const char* Diagnostic)
{
	static_assert(std::is_trivially_copyable<TValue>::value, "parameter fields are raw ABI values");
	TORCH_CHECK(Offset <= BlockBytes && sizeof(TValue) <= BlockBytes - Offset, Diagnostic);
	std::memcpy(Block + Offset, &Value, sizeof(TValue));
}

template <class TValue>
inline void WriteParameterField(FParameterBlock& Block, size_t Offset, TValue Value, const char* Diagnostic)
{
	WriteParameterField(Block.data(), Block.size(), Offset, Value, Diagnostic);
}

// Launch/replay writes use this form after the binding offset was validated
// during preparation. It deliberately has no repeated bounds check, matching
// the original replay memcpy hot path.
template <class TValue>
inline void WritePrevalidatedParameterField(unsigned char* Block, size_t Offset, TValue Value)
{
	static_assert(std::is_trivially_copyable<TValue>::value, "parameter fields are raw ABI values");
	std::memcpy(Block + Offset, &Value, sizeof(TValue));
}

template <class TValue>
inline void WritePrevalidatedParameterField(FParameterBlock& Block, size_t Offset, TValue Value)
{
	WritePrevalidatedParameterField(Block.data(), Offset, Value);
}

inline void ClearParameterField(FParameterBlock& Block, size_t Offset, size_t Bytes, const char* Diagnostic)
{
	TORCH_CHECK(Offset <= Block.size() && Bytes <= Block.size() - Offset, Diagnostic);
	std::memset(Block.data() + Offset, 0, Bytes);
}

// Pointer fields in every prepared record are 64-bit physical byte addresses.
inline void BindTensorAddress(FParameterBlock& Block, size_t Offset, const at::Tensor& Tensor,
							  const char* Diagnostic)
{
	WriteParameterField<uint64_t>(Block, Offset, TensorAddress(Tensor), Diagnostic);
}

// Prepared-descriptor Launch only rebinds offsets that construction validated.
inline void BindPrevalidatedTensorAddress(FParameterBlock& Block, size_t Offset, const at::Tensor& Tensor)
{
	WritePrevalidatedParameterField<uint64_t>(Block, Offset, TensorAddress(Tensor));
}

} // namespace host
} // namespace dlssnr
