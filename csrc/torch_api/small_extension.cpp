#include <torch/library.h>
#include "common/host/boxed_dispatch.h"
#include "common/host/deployment_runtime.h"
#include "../kernel_launcher/prepared_kernel.h"
#include "../kernel_launcher/small_deployment.h"

// The Small31 model is an additive, explicit API. These names never alias the
// legacy deployment classes or their creators, so a caller must select the
// model and precision deliberately instead of switching through a default.
//
// The two Small31-safe attention exports are the only operators outside the
// canonical81 prepared tables. They use the same boxed contract as the prepared
// registrations: schema name must match the prepared descriptor and Validate
// enforces device, layout, extent and disjointness before any launch. CUDA and
// Meta are explicit; there is no weak fallback.
static const char* SmallSafeAttentionNames[] = {
	"small_global_attention_chained_c1024_fp8",
	"small_global_attention_chained_c1024_fp16",
};

TORCH_LIBRARY_FRAGMENT(dlssnr, Library)
{
	dlssnr::host::RegisterDeploymentPlanClass<FSmallDeploymentPlan_fp8>(
		Library, "SmallDeploymentPlan_fp8", "run_fp8", &FSmallDeploymentPlan_fp8::Run_fp8);
	Library.def("create_small_plan_for_resolution_fp8", &CreateSmallPlanForResolution_fp8);
	Library.def("record_names_small31_fp8", &RecordNames_small31_fp8);
	Library.def("record_bytes_small31_fp8", &RecordBytes_small31_fp8);
	dlssnr::host::RegisterDeploymentPlanClass<FSmallDeploymentPlan_fp16>(
		Library, "SmallDeploymentPlan_fp16", "run_fp16", &FSmallDeploymentPlan_fp16::Run_fp16);
	Library.def("create_small_plan_for_resolution_fp16", &CreateSmallPlanForResolution_fp16);
	Library.def("record_names_small31_fp16", &RecordNames_small31_fp16);
	Library.def("record_bytes_small31_fp16", &RecordBytes_small31_fp16);
	for (const auto* Name : SmallSafeAttentionNames)
		Library.def(
			(std::string(Name) + "(Tensor[] inputs, Tensor(a!)[] outputs, int handle) -> ()").c_str());
}

TORCH_LIBRARY_IMPL(dlssnr, CUDA, Library)
{
	dlssnr::host::RegisterBoxedPreparedImplementations<false>(Library, SmallSafeAttentionNames);
}

TORCH_LIBRARY_IMPL(dlssnr, Meta, Library)
{
	dlssnr::host::RegisterBoxedPreparedImplementations<true>(Library, SmallSafeAttentionNames);
}
