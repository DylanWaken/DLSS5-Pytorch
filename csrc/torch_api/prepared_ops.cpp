#include "prepared_ops.h"
#include "../kernel_launcher/prepared_kernel.h"
#include "../kernel_launcher/prepared_kernel_names_generated.inl"

static void InvokePreparedKernel(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack, bool bMeta)
{
	TORCH_CHECK(Stack->size() >= 3, "individual kernel requires inputs, outputs and handle");
	const auto Start = Stack->size() - 3;
	const auto Inputs = (*Stack)[Start].toTensorVector();
	const auto Outputs = (*Stack)[Start + 1].toTensorVector();
	const auto Descriptor = FindPreparedKernel((*Stack)[Start + 2].toInt());
	TORCH_CHECK(Operator.schema().name() == "dlssnr::" + Descriptor->Name,
				"prepared kernel descriptor does not match the named operator");
	Descriptor->Validate(Inputs, Outputs, bMeta);
	if (!bMeta)
		Descriptor->Launch(Inputs, Outputs);
	Stack->erase(Stack->begin() + Start, Stack->end());
}

static void InvokePreparedKernelCuda(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack)
{
	InvokePreparedKernel(Operator, Stack, false);
}

static void InvokePreparedKernelMeta(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack)
{
	InvokePreparedKernel(Operator, Stack, true);
}

void RegisterPreparedKernelSchemas(torch::Library& Library)
{
	Library.class_<FPreparedKernelHandle>("PreparedKernel")
		.def("id", &FPreparedKernelHandle::Id)
		.def("name", &FPreparedKernelHandle::Name)
		.def("inputs", &FPreparedKernelHandle::Inputs)
		.def("outputs", &FPreparedKernelHandle::Outputs);
	Library.class_<FPreparedKernelSequence>("PreparedKernelSequence")
		.def("run", &FPreparedKernelSequence::Run);
	Library.def("create_kernel_sequence", &CreateKernelSequence);
	// Mutable outputs also include read-modify-write scratch and counters. Returning
	// no aliased tensors lets PyTorch 2.8 functionalize each output list correctly.
	for (const auto* Name : PreparedKernelNames)
		Library.def(
			(std::string(Name) + "(Tensor[] inputs, Tensor(a!)[] outputs, int handle) -> ()").c_str());
	Library.def("prepare_output_view_fp8", &PrepareOutputView_fp8);
	Library.def("prepare_output_view_fp16", &PrepareOutputView_fp16);
}

TORCH_LIBRARY_IMPL(dlssnr, CUDA, Library)
{
	for (const auto* Name : PreparedKernelNames)
		Library.impl(Name, torch::CppFunction::makeFromBoxedFunction<&InvokePreparedKernelCuda>());
}

TORCH_LIBRARY_IMPL(dlssnr, Meta, Library)
{
	for (const auto* Name : PreparedKernelNames)
		Library.impl(Name, torch::CppFunction::makeFromBoxedFunction<&InvokePreparedKernelMeta>());
}
