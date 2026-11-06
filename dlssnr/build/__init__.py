"""Import-safe build support for the DLSS-NR native deployment libraries.

Importing this package has no compiler, CUDA or filesystem side effects.  Public
helpers are resolved lazily so ``import dlssnr.build`` stays cheap; import the
individual modules when a caller needs a concrete API.
"""
from importlib import import_module

__all__ = [
    "CudaTarget",
    "CudaAssemblerSelection",
    "parse_targets",
    "library_targets",
    "prepare_cuda_assembler",
    "BOUNDS",
    "DISTANCE",
    "PRECISIONS",
    "RESOLVER_VERSION",
    "CPP",
    "canonical",
    "require",
    "integer",
    "digest",
    "key",
    "validate",
    "combine",
    "verify_receipts",
    "version",
    "lookup",
    "cpp_header",
    "cuda_sources",
    "host_sources",
    "translation_units",
    "native_headers",
    "native_dependencies",
    "build_inputs",
    "include_directories",
    "kernel_templates",
    "expected_cuda_units",
    "build_cache_key",
    "cxx_standard_flags",
    "nvcc_standard_flags",
]

_ATTRIBUTES = {
    "CudaTarget": ("targets", "CudaTarget"),
    "CudaAssemblerSelection": ("toolchain", "CudaAssemblerSelection"),
    "parse_targets": ("targets", "parse_targets"),
    "library_targets": ("targets", "library_targets"),
    "prepare_cuda_assembler": ("toolchain", "prepare_cuda_assembler"),
    "BOUNDS": ("resolution", "BOUNDS"),
    "DISTANCE": ("resolution", "DISTANCE"),
    "PRECISIONS": ("resolution", "PRECISIONS"),
    "RESOLVER_VERSION": ("resolution", "RESOLVER_VERSION"),
    "CPP": ("resolution", "CPP"),
    "canonical": ("resolution", "canonical"),
    "require": ("resolution", "require"),
    "integer": ("resolution", "integer"),
    "digest": ("resolution", "digest"),
    "key": ("resolution", "key"),
    "validate": ("resolution", "validate"),
    "combine": ("resolution", "combine"),
    "verify_receipts": ("resolution", "verify_receipts"),
    "version": ("resolution", "version"),
    "lookup": ("resolution", "lookup"),
    "cpp_header": ("resolution", "cpp_header"),
    "cuda_sources": ("native", "cuda_sources"),
    "host_sources": ("native", "host_sources"),
    "translation_units": ("native", "translation_units"),
    "native_headers": ("native", "native_headers"),
    "native_dependencies": ("native", "native_dependencies"),
    "build_inputs": ("native", "build_inputs"),
    "include_directories": ("native", "include_directories"),
    "kernel_templates": ("native", "kernel_templates"),
    "expected_cuda_units": ("native", "expected_cuda_units"),
    "build_cache_key": ("native", "build_cache_key"),
    "cxx_standard_flags": ("native", "cxx_standard_flags"),
    "nvcc_standard_flags": ("native", "nvcc_standard_flags"),
}


def __getattr__(name):
    try:
        module, attribute = _ATTRIBUTES[name]
    except KeyError:
        raise AttributeError(name) from None
    return getattr(import_module("." + module, __name__), attribute)
