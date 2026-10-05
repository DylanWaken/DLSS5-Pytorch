"""DLSS-NR: PyTorch training and reconstructed CUDA deployment."""
__all__ = ["DLSSNR", "Geometry", "WeightArchive", "create_plan_fp8", "inference_forward_fp8",
           "create_plan_fp16", "inference_forward_fp16", "load_checkpoint", "PreparedKernel",
           "PreparedSequence", "prepare_kernels", "prepare_output_view_fp8", "prepare_output_view_fp16",
           "prepare_frontend", "frontend_configuration", "compose_kernels"]

def __getattr__(name):
    from importlib import import_module
    modules = dict(DLSSNR="model", Geometry="geometry", WeightArchive="weights",
                   create_plan_fp16="deployment", inference_forward_fp16="deployment",
                   create_plan_fp8="deployment", inference_forward_fp8="deployment", load_checkpoint="checkpoint",
                   PreparedKernel="deployment", PreparedSequence="deployment", prepare_kernels="deployment",
                   prepare_output_view_fp8="deployment", prepare_output_view_fp16="deployment",
                   prepare_frontend="deployment", frontend_configuration="deployment", compose_kernels="deployment")
    if name not in modules:
        raise AttributeError(name)
    return getattr(import_module('.'+modules[name], __name__), name)
