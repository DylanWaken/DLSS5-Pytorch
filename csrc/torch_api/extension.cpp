#include <torch/library.h>
#include "../kernel_launcher/deployment.h"
#include "../kernel_launcher/windows_dispatch.h"
#include "../kernel_launcher/c512_dispatch.h"

TORCH_LIBRARY(dlssnr, Library)
{
	using namespace dlssnr;
	Library.class_<deployment::FDeploymentPlan_fp8>("DeploymentPlan_fp8")
		.def("run_fp8", &deployment::FDeploymentPlan_fp8::Run_fp8)
		.def("buffer", &deployment::FDeploymentPlan_fp8::GetBuffer)
		.def("buffer_names", &deployment::FDeploymentPlan_fp8::GetBufferNames)
		.def("boundaries", &deployment::FDeploymentPlan_fp8::GetBoundaries)
		.def("boundary_names", &deployment::FDeploymentPlan_fp8::GetBoundaryNames)
		.def("guards_intact", &deployment::FDeploymentPlan_fp8::GuardsIntact)
		.def("poison", &deployment::FDeploymentPlan_fp8::Poison)
		.def("resources", &deployment::FDeploymentPlan_fp8::GetResources);
	Library.def("create_plan_fp8", &deployment::CreatePlan_fp8);
	Library.def("create_plan_for_resolution_fp8", &deployment::CreatePlanForResolution_fp8);
	Library.def("record_names_fp8", &deployment::RecordNames_fp8);
	Library.def("record_bytes_fp8", &deployment::RecordBytes_fp8);
	Library.def("compiled_policy_version", &deployment::CompiledPolicyVersion);
	Library.def("resolution_selection", &deployment::ResolutionSelection);
	Library.def("prepare_window_fp8", &reconstructed_windows::PrepareWindow_fp8);
	Library.def(
		"window_out_fp8(int entry, Tensor state, Tensor record, Tensor(a!) high, Tensor(a!)? down, Tensor? skip, int height, int width, int phase) -> Tensor(a!)[]",
		&reconstructed_windows::LaunchWindow_fp8);
	Library.def("prepare_c512_fp8", &reconstructed_c512::PrepareC512_fp8);
	Library.def(
		"c512_out_fp8(int entry, Tensor[] inputs, Tensor(a!)[] outputs, int height, int width, int phase) -> Tensor(a!)[]",
		&reconstructed_c512::LaunchC512_fp8);
	Library.def(
		"c512_block_out_fp8(int block, Tensor state, Tensor[] records, Tensor(a!)[] workspaces) -> Tensor(a!)[]",
		&reconstructed_c512::C512BlockOut_fp8);
	Library.def("prepare_window_fp16", &reconstructed_windows::PrepareWindow_fp16);
	Library.def(
		"window_out_fp16(int entry, Tensor state, Tensor record, Tensor(a!) high, Tensor(a!)? down, Tensor? skip, int height, int width, int phase) -> Tensor(a!)[]",
		&reconstructed_windows::LaunchWindow_fp16);
	Library.def("prepare_c512_fp16", &reconstructed_c512::PrepareC512_fp16);
	Library.def(
		"c512_out_fp16(int entry, Tensor[] inputs, Tensor(a!)[] outputs, int height, int width, int phase) -> Tensor(a!)[]",
		&reconstructed_c512::LaunchC512_fp16);
	Library.def(
		"c512_block_out_fp16(int block, Tensor state, Tensor[] records, Tensor(a!)[] workspaces) -> Tensor(a!)[]",
		&reconstructed_c512::C512BlockOut_fp16);
}
