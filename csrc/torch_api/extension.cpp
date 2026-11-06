#include <torch/library.h>
#include "common/host/deployment_runtime.h"
#include "../kernel_launcher/deployment.h"
#include "../kernel_launcher/windows_dispatch.h"
#include "../kernel_launcher/c512_dispatch.h"
#include "prepared_ops.h"
#include "../kernel_launcher/frontend_dispatch.h"
#include "../kernel_launcher/kernel_symbols.h"

// setup.py records virtual targets, not runtime qualification or tuning claims.
static std::vector<int64_t> DeploymentBuildArchitectures()
{
	return {DLSSNR_BUILD_ARCHITECTURES};
}

TORCH_LIBRARY(dlssnr, Library)
{
	Library.def("deployment_build_architectures", &DeploymentBuildArchitectures);
	RegisterPreparedKernelSchemas(Library);
	RegisterFrontendKernels(Library);
	Library.def("kernel_symbol", &KernelSymbol);
	dlssnr::host::RegisterDeploymentPlanClass<FDeploymentPlan_fp8>(Library, "DeploymentPlan_fp8", "run_fp8",
																   &FDeploymentPlan_fp8::Run_fp8);
	Library.def("create_plan_fp8", &CreatePlan_fp8);
	Library.def("create_plan_for_resolution_fp8", &CreatePlanForResolution_fp8);
	Library.def("record_names_fp8", &RecordNames_fp8);
	Library.def("record_bytes_fp8", &RecordBytes_fp8);
	dlssnr::host::RegisterDeploymentPlanClass<FDeploymentPlan_fp16>(
		Library, "DeploymentPlan_fp16", "run_fp16", &FDeploymentPlan_fp16::Run_fp16);
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
