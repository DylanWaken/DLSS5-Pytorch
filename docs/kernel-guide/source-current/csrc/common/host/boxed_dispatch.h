#pragma once
// One boxed CUDA/Meta invocation mechanism for prepared kernels. The dispatch
// table name, argument order, schema match, validation, launch and stack erase
// are unchanged; only the duplicated wrapper bodies live here.
#include "kernel_launcher/prepared_kernel.h"
#include <torch/library.h>

namespace dlssnr
{
namespace host
{

// Meta invocations validate the prepared descriptor but never touch a device.
// The bool is a compile-time parameter so the launch path is not present in the
// Meta specialization and no runtime branch is added to the CUDA call.
template <bool bMeta>
inline void InvokeBoxedPreparedKernel(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack)
{
	TORCH_CHECK(Stack->size() >= 3, "individual kernel requires inputs, outputs and handle");
	const auto Start = Stack->size() - 3;
	const auto Inputs = (*Stack)[Start].toTensorVector();
	const auto Outputs = (*Stack)[Start + 1].toTensorVector();
	const auto Descriptor = FindPreparedKernel((*Stack)[Start + 2].toInt());
	TORCH_CHECK(Operator.schema().name() == "dlssnr::" + Descriptor->Name,
				"prepared kernel descriptor does not match the named operator");
	Descriptor->Validate(Inputs, Outputs, bMeta);
	if constexpr (!bMeta)
		Descriptor->Launch(Inputs, Outputs);
	Stack->erase(Stack->begin() + Start, Stack->end());
}

template <bool bMeta, class TNameRange>
inline void RegisterBoxedPreparedImplementations(torch::Library& Library, const TNameRange& Names)
{
	for (const auto* Name : Names)
		Library.impl(Name, torch::CppFunction::makeFromBoxedFunction<&InvokeBoxedPreparedKernel<bMeta>>());
}

} // namespace host
} // namespace dlssnr
