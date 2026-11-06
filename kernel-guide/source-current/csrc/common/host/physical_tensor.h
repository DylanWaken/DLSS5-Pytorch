#pragma once
// Raw physical-tensor contracts shared by deployment plans, prepared kernels,
// reconstructed window/C512 entries and frontend texture adapters.
//
// Every helper here is a static inline C++17 operation on caller-owned tensors.
// No helper allocates device storage, inspects values or launches work. The
// role-specific wording stays at the call site so unrelated users keep their
// existing diagnostics, while the accepted dtype/layout/device/extent,
// alignment, overflow, disjointness and capture rules live in one place.
#include <ATen/ATen.h>
#include <c10/cuda/CUDAException.h>
#include <c10/util/Exception.h>
#include <cuda_runtime_api.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <string>
#include <vector>

namespace dlssnr
{
namespace host
{

// The native ABI stores pointer fields as 64-bit unsigned byte addresses.
inline uint64_t TensorAddress(const at::Tensor& Tensor)
{
	return reinterpret_cast<uint64_t>(Tensor.data_ptr());
}

inline uintptr_t TensorByteAddress(const at::Tensor& Tensor)
{
	return reinterpret_cast<uintptr_t>(Tensor.data_ptr());
}

inline bool HasTensorContract(const at::Tensor& Tensor, at::ScalarType Type, int64_t Dimensions)
{
	return Tensor.defined() && Tensor.scalar_type() == Type && Tensor.dim() == Dimensions &&
		   Tensor.is_contiguous();
}

inline bool HasPhysicalByteContract(const at::Tensor& Tensor)
{
	return HasTensorContract(Tensor, at::kByte, 1);
}

inline bool IsAligned16(uintptr_t Address)
{
	return Address % 16 == 0;
}

// Half-open physical byte interval. Disjointness uses the same sorted adjacent
// interval test as the original validators: a zero-length range is accepted
// only when that ordering also proves no overlap, so a zero-length interval
// nested inside a non-empty range is still rejected.
struct FPhysicalRange
{
	uintptr_t Begin, End;
};

inline bool TryPhysicalRange(uintptr_t Address, uintptr_t Bytes, FPhysicalRange& Range)
{
	if (Address > std::numeric_limits<uintptr_t>::max() - Bytes)
		return false;
	Range = {Address, Address + Bytes};
	return true;
}

inline bool TryPhysicalTensorRange(const at::Tensor& Tensor, uintptr_t Bytes, FPhysicalRange& Range)
{
	return TryPhysicalRange(TensorByteAddress(Tensor), Bytes, Range);
}

template <class... TMessage>
inline void AppendTensorRange(std::vector<FPhysicalRange>& Ranges, const at::Tensor& Tensor, uintptr_t Bytes,
							  TMessage&&... Message)
{
	FPhysicalRange Range{};
	TORCH_CHECK(TryPhysicalTensorRange(Tensor, Bytes, Range), Message...);
	Ranges.push_back(Range);
}

// Byte tensors use numel() as the physical extent. Typed adapter tensors pass
// their byte count explicitly through AppendTensorRange above.
template <class... TMessage>
inline void AppendTensorByteRange(std::vector<FPhysicalRange>& Ranges, const at::Tensor& Tensor,
								  TMessage&&... Message)
{
	AppendTensorRange(Ranges, Tensor, uintptr_t(Tensor.numel()), Message...);
}

template <class... TMessage>
inline void RequirePairwiseDisjoint(std::vector<FPhysicalRange>& Ranges, TMessage&&... Message)
{
	std::sort(
		Ranges.begin(), Ranges.end(), [](const FPhysicalRange& First, const FPhysicalRange& Second)
		{ return First.Begin < Second.Begin || (First.Begin == Second.Begin && First.End < Second.End); });
	for (size_t RangeIndex = 1; RangeIndex < Ranges.size(); ++RangeIndex)
		TORCH_CHECK(Ranges[RangeIndex - 1].End <= Ranges[RangeIndex].Begin, Message...);
}

// Launch paths that already own a pointer container use the original O(n^2)
// pair test without materializing an interval vector. It keeps the original
// overflow/disjointness diagnostics and adds no allocation.
template <class TPointerRange, class... TDisjointMessage>
inline void RequirePairwiseDisjointTensorPointers(const TPointerRange& Tensors,
												  const char* OverflowDiagnostic,
												  TDisjointMessage&&... DisjointMessage)
{
	for (size_t FirstIndex = 0; FirstIndex < Tensors.size(); ++FirstIndex)
		for (size_t SecondIndex = FirstIndex + 1; SecondIndex < Tensors.size(); ++SecondIndex)
		{
			FPhysicalRange First{}, Second{};
			TORCH_CHECK(TryPhysicalTensorRange(*Tensors[FirstIndex], uintptr_t(Tensors[FirstIndex]->numel()),
											   First) &&
							TryPhysicalTensorRange(*Tensors[SecondIndex],
												   uintptr_t(Tensors[SecondIndex]->numel()), Second),
						OverflowDiagnostic);
			TORCH_CHECK(First.End <= Second.Begin || Second.End <= First.Begin, DisjointMessage...);
		}
}

template <class... TMessage> inline void RequireInferenceOnly(const at::Tensor& Tensor, TMessage&&... Message)
{
	TORCH_CHECK(!Tensor.requires_grad(), Message...);
}

// Plan creation and individual kernel preparation must not record into a graph.
inline void RequireOutsideCapture(cudaStream_t Stream, const char* Diagnostic)
{
	cudaStreamCaptureStatus CaptureStatus{};
	C10_CUDA_CHECK(cudaStreamIsCapturing(Stream, &CaptureStatus));
	TORCH_CHECK(CaptureStatus == cudaStreamCaptureStatusNone, Diagnostic);
}

// Deployment and Small31 plan buffers share this exact contract and wording.
inline void ValidatePlanPhysicalBuffer(const at::Tensor& Tensor, int64_t Bytes, int DeviceIndex,
									   const char* Role)
{
	TORCH_CHECK(Tensor.defined() && Tensor.is_cuda() && Tensor.get_device() == DeviceIndex &&
					Tensor.scalar_type() == at::kByte,
				Role, " must be raw uint8 on the plan's CUDA device");
	TORCH_CHECK(Tensor.dim() == 1 && Tensor.is_contiguous() && Tensor.numel() == Bytes, Role,
				" physical extent must be exactly ", Bytes, " bytes");
	TORCH_CHECK(IsAligned16(TensorByteAddress(Tensor)), "physical tensor must be 16-byte aligned: ", Role);
}

// Reconstructed window and C512 launches share this exact caller-owned buffer
// contract. The two family callers retain their own inference-only diagnostic.
inline void ValidateLaunchedPhysicalBuffer(const at::Tensor& Tensor, int64_t Bytes,
										   const at::Device& TensorDevice, const char* Role,
										   const char* InferenceDiagnostic)
{
	TORCH_CHECK(Tensor.is_cuda() && Tensor.device() == TensorDevice && Tensor.scalar_type() == at::kByte,
				Role, " requires uint8 physical storage on the selected CUDA device");
	TORCH_CHECK(Tensor.dim() == 1 && Tensor.is_contiguous() && Tensor.numel() == Bytes, Role,
				" requires exact contiguous physical extent ", Bytes);
	RequireInferenceOnly(Tensor, InferenceDiagnostic);
	TORCH_CHECK(IsAligned16(TensorByteAddress(Tensor)), Role, " requires 16-byte alignment");
}

// A prepared descriptor always owns exactly one byte extent. Dynamo can present
// a symbolic numel while tracing another entry, so guard the equality instead
// of requesting a concrete size.
inline void RequirePreparedByteExtent(const at::Tensor& Tensor, int64_t Bytes, const std::string& Name)
{
	TORCH_CHECK(HasPhysicalByteContract(Tensor), Name,
				": requires exact contiguous one-dimensional uint8 physical extents");
	TORCH_CHECK(Tensor.sym_numel().sym_eq(c10::SymInt(Bytes)).guard_bool(__FILE__, __LINE__), Name,
				": physical byte extent differs from the prepared kernel");
}

// Frontend adapters use a fixed dtype/shape contract, again guarded rather than
// materialized because Dynamo may initially present symbolic dimensions.
inline void RequireTensorShapeContract(const at::Tensor& Tensor, at::ScalarType Type,
									   const std::vector<int64_t>& Shape, const std::string& Name,
									   size_t RoleIndex)
{
	TORCH_CHECK(Tensor.defined() && Tensor.scalar_type() == Type && Tensor.dim() == int64_t(Shape.size()) &&
					Tensor.is_contiguous(),
				Name, ": tensor dtype/shape differs from prepared physical or HWC4 layout at role ",
				RoleIndex);
	for (int64_t Dimension = 0; Dimension < Tensor.dim(); ++Dimension)
		TORCH_CHECK(Tensor.sym_size(Dimension)
						.sym_eq(c10::SymInt(Shape[size_t(Dimension)]))
						.guard_bool(__FILE__, __LINE__),
					Name, ": tensor dtype/shape differs from prepared physical or HWC4 layout at role ",
					RoleIndex);
}

} // namespace host
} // namespace dlssnr
