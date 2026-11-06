#include "prepared_ops.h"
#include "common/host/boxed_dispatch.h"
#include "../kernel_launcher/prepared_kernel.h"
#include "../kernel_launcher/prepared_kernel_names_generated.inl"

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
	dlssnr::host::RegisterBoxedPreparedImplementations<false>(Library, PreparedKernelNames);
}

TORCH_LIBRARY_IMPL(dlssnr, Meta, Library)
{
	dlssnr::host::RegisterBoxedPreparedImplementations<true>(Library, PreparedKernelNames);
}
