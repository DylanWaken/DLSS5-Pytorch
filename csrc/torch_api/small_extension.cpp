#include <torch/library.h>
#include "../kernel_launcher/prepared_kernel.h"
#include "../kernel_launcher/small_deployment.h"

// The Small31 model is an additive, explicit API. These names never alias the
// legacy deployment classes or their creators, so a caller must select the
// model and precision deliberately instead of switching through a default.
//
// The two Small31-safe attention exports are the only operators outside the
// canonical81 prepared tables. They are registered here, with the same strict
// boxed contract as prepared_ops.cpp (which keeps its static entry points
// private to that translation unit): schema name must match the prepared
// descriptor and Validate enforces device, layout, extent and disjointness
// before any launch. CUDA and Meta are explicit; there is no weak fallback.
static const char* SmallSafeAttentionNames[] = {
	"small_global_attention_chained_c1024_fp8",
	"small_global_attention_chained_c1024_fp16",
};

static void InvokeSmallSafeAttention(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack, bool bMeta)
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

static void InvokeSmallSafeAttentionCuda(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack)
{
	InvokeSmallSafeAttention(Operator, Stack, false);
}

static void InvokeSmallSafeAttentionMeta(const c10::OperatorHandle& Operator, torch::jit::Stack* Stack)
{
	InvokeSmallSafeAttention(Operator, Stack, true);
}

TORCH_LIBRARY_FRAGMENT(dlssnr, Library)
{
	Library.class_<FSmallDeploymentPlan_fp8>("SmallDeploymentPlan_fp8")
		.def("run_fp8", &FSmallDeploymentPlan_fp8::Run_fp8)
		.def("buffer", &FSmallDeploymentPlan_fp8::GetBuffer)
		.def("buffer_names", &FSmallDeploymentPlan_fp8::GetBufferNames)
		.def("boundaries", &FSmallDeploymentPlan_fp8::GetBoundaries)
		.def("boundary_names", &FSmallDeploymentPlan_fp8::GetBoundaryNames)
		.def("guards_intact", &FSmallDeploymentPlan_fp8::GuardsIntact)
		.def("poison", &FSmallDeploymentPlan_fp8::Poison)
		.def("resources", &FSmallDeploymentPlan_fp8::GetResources)
		.def("split_launch_counts", &FSmallDeploymentPlan_fp8::GetSplitLaunchCounts)
		.def("prepare_kernels", &FSmallDeploymentPlan_fp8::PrepareKernels)
		.def("tensor_arguments", &FSmallDeploymentPlan_fp8::GetTensorArguments)
		.def("kernel_tensor_indices", &FSmallDeploymentPlan_fp8::GetKernelTensorIndices);
	Library.def("create_small_plan_for_resolution_fp8", &CreateSmallPlanForResolution_fp8);
	Library.def("record_names_small31_fp8", &RecordNames_small31_fp8);
	Library.def("record_bytes_small31_fp8", &RecordBytes_small31_fp8);
	Library.class_<FSmallDeploymentPlan_fp16>("SmallDeploymentPlan_fp16")
		.def("run_fp16", &FSmallDeploymentPlan_fp16::Run_fp16)
		.def("buffer", &FSmallDeploymentPlan_fp16::GetBuffer)
		.def("buffer_names", &FSmallDeploymentPlan_fp16::GetBufferNames)
		.def("boundaries", &FSmallDeploymentPlan_fp16::GetBoundaries)
		.def("boundary_names", &FSmallDeploymentPlan_fp16::GetBoundaryNames)
		.def("guards_intact", &FSmallDeploymentPlan_fp16::GuardsIntact)
		.def("poison", &FSmallDeploymentPlan_fp16::Poison)
		.def("resources", &FSmallDeploymentPlan_fp16::GetResources)
		.def("split_launch_counts", &FSmallDeploymentPlan_fp16::GetSplitLaunchCounts)
		.def("prepare_kernels", &FSmallDeploymentPlan_fp16::PrepareKernels)
		.def("tensor_arguments", &FSmallDeploymentPlan_fp16::GetTensorArguments)
		.def("kernel_tensor_indices", &FSmallDeploymentPlan_fp16::GetKernelTensorIndices);
	Library.def("create_small_plan_for_resolution_fp16", &CreateSmallPlanForResolution_fp16);
	Library.def("record_names_small31_fp16", &RecordNames_small31_fp16);
	Library.def("record_bytes_small31_fp16", &RecordBytes_small31_fp16);
	for (const auto* Name : SmallSafeAttentionNames)
		Library.def(
			(std::string(Name) + "(Tensor[] inputs, Tensor(a!)[] outputs, int handle) -> ()").c_str());
}

TORCH_LIBRARY_IMPL(dlssnr, CUDA, Library)
{
	for (const auto* Name : SmallSafeAttentionNames)
		Library.impl(Name, torch::CppFunction::makeFromBoxedFunction<&InvokeSmallSafeAttentionCuda>());
}

TORCH_LIBRARY_IMPL(dlssnr, Meta, Library)
{
	for (const auto* Name : SmallSafeAttentionNames)
		Library.impl(Name, torch::CppFunction::makeFromBoxedFunction<&InvokeSmallSafeAttentionMeta>());
}
