#include <torch/library.h>
#include "../kernel_launcher/deployment.h"
#include "../kernel_launcher/windows_dispatch.h"
#include "../kernel_launcher/c512_dispatch.h"
#include "prepared_ops.h"
#include "../kernel_launcher/frontend_dispatch.h"

TORCH_LIBRARY(dlssnr, Library)
{
	RegisterPreparedKernelSchemas(Library);
	RegisterFrontendKernels(Library);
	Library.class_<FDeploymentPlan_fp8>("DeploymentPlan_fp8")
		.def("run_fp8", &FDeploymentPlan_fp8::Run_fp8)
		.def("buffer", &FDeploymentPlan_fp8::GetBuffer)
		.def("buffer_names", &FDeploymentPlan_fp8::GetBufferNames)
		.def("boundaries", &FDeploymentPlan_fp8::GetBoundaries)
		.def("boundary_names", &FDeploymentPlan_fp8::GetBoundaryNames)
		.def("guards_intact", &FDeploymentPlan_fp8::GuardsIntact)
		.def("poison", &FDeploymentPlan_fp8::Poison)
		.def("resources", &FDeploymentPlan_fp8::GetResources)
		.def("prepare_kernels", &FDeploymentPlan_fp8::PrepareKernels)
		.def("tensor_arguments", &FDeploymentPlan_fp8::GetTensorArguments)
		.def("kernel_tensor_indices", &FDeploymentPlan_fp8::GetKernelTensorIndices);
	Library.def("create_plan_fp8", &CreatePlan_fp8);
	Library.def("create_plan_for_resolution_fp8", &CreatePlanForResolution_fp8);
	Library.def("record_names_fp8", &RecordNames_fp8);
	Library.def("record_bytes_fp8", &RecordBytes_fp8);
	Library.class_<FDeploymentPlan_fp16>("DeploymentPlan_fp16")
		.def("run_fp16", &FDeploymentPlan_fp16::Run_fp16)
		.def("buffer", &FDeploymentPlan_fp16::GetBuffer)
		.def("buffer_names", &FDeploymentPlan_fp16::GetBufferNames)
		.def("boundaries", &FDeploymentPlan_fp16::GetBoundaries)
		.def("boundary_names", &FDeploymentPlan_fp16::GetBoundaryNames)
		.def("guards_intact", &FDeploymentPlan_fp16::GuardsIntact)
		.def("poison", &FDeploymentPlan_fp16::Poison)
		.def("resources", &FDeploymentPlan_fp16::GetResources)
		.def("prepare_kernels", &FDeploymentPlan_fp16::PrepareKernels)
		.def("tensor_arguments", &FDeploymentPlan_fp16::GetTensorArguments)
		.def("kernel_tensor_indices", &FDeploymentPlan_fp16::GetKernelTensorIndices);
	Library.def("create_plan_fp16", &CreatePlan_fp16);
	Library.def("create_plan_for_resolution_fp16", &CreatePlanForResolution_fp16);
	Library.def("record_names_fp16", &RecordNames_fp16);
	Library.def("record_bytes_fp16", &RecordBytes_fp16);
	Library.def("compiled_policy_version", &CompiledPolicyVersion);
	Library.def("resolution_selection", &ResolutionSelection);
	Library.def("prepare_window_fp8", &PrepareWindow_fp8);
	Library.def(
		"window_out_fp8(int entry, Tensor state, Tensor record, Tensor(a!) high, Tensor(a!)? down, Tensor? skip, int height, int width, int phase) -> Tensor(a!)[]",
		&LaunchWindow_fp8);
	Library.def("prepare_c512_fp8", &PrepareC512_fp8);
	Library.def(
		"c512_out_fp8(int entry, Tensor[] inputs, Tensor(a!)[] outputs, int height, int width, int phase) -> Tensor(a!)[]",
		&LaunchC512_fp8);
	Library.def(
		"c512_block_out_fp8(int block, Tensor state, Tensor[] records, Tensor(a!)[] workspaces) -> Tensor(a!)[]",
		&C512BlockOut_fp8);
	Library.def("prepare_window_fp16", &PrepareWindow_fp16);
	Library.def(
		"window_out_fp16(int entry, Tensor state, Tensor record, Tensor(a!) high, Tensor(a!)? down, Tensor? skip, int height, int width, int phase) -> Tensor(a!)[]",
		&LaunchWindow_fp16);
	Library.def("prepare_c512_fp16", &PrepareC512_fp16);
	Library.def(
		"c512_out_fp16(int entry, Tensor[] inputs, Tensor(a!)[] outputs, int height, int width, int phase) -> Tensor(a!)[]",
		&LaunchC512_fp16);
	Library.def(
		"c512_block_out_fp16(int block, Tensor state, Tensor[] records, Tensor(a!)[] workspaces) -> Tensor(a!)[]",
		&C512BlockOut_fp16);
}
