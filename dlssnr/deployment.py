"""Thin entry points for the reconstructed C++ deployment plan.

Kernel choice, argument packing, layout and buffer scheduling live in C++.
Keep the returned plan alive until every CUDA graph using it is reset.
"""
from importlib.util import find_spec
from pathlib import Path
from threading import RLock

_loaded = None
_lock = RLock()

def load_extension(path=None):
    import torch
    global _loaded
    with _lock:
        if path is None and _loaded is not None:
            return torch.ops.dlssnr
        if path is None:
            spec = find_spec('dlssnr._C')
            if spec is None:
                raise RuntimeError('Build the CUDA extension with python setup.py build_ext --inplace')
            path = spec.origin
        resolved = str(Path(path).resolve(strict=True))
        if _loaded is not None and _loaded != resolved:
            raise RuntimeError('A different DLSSNR extension is already loaded in this process')
        if _loaded is None:
            torch.ops.load_library(resolved)
            _loaded = resolved
    return torch.ops.dlssnr

def create_plan_fp8(state, records, *, width=3840, height=2160):
    """Prepare the admitted physical FP8 trunk outside CUDA graph capture."""
    return load_extension().create_plan_for_resolution_fp8(state, records, width, height)

def inference_forward_fp8(plan):
    """Run an already prepared plan on the current PyTorch CUDA stream."""
    return plan.run_fp8()


def create_plan_fp16(state, records, *, width=3840, height=2160):
    """Prepare physical Half buffers outside CUDA graph capture."""
    return load_extension().create_plan_for_resolution_fp16(state, records, width, height)


def inference_forward_fp16(plan):
    """Run the prepared Half plan on the current PyTorch CUDA stream."""
    return plan.run_fp16()


class PreparedKernel:
    """One named, compile-visible native kernel with explicit tensor arguments.

    Preparation fixes the shape, scalar ABI, device and launch configuration.
    ``kernel(inputs, outputs)`` accepts new storage with those same contracts;
    ``outputs`` includes read-modify-write workspaces and counters. Retain this
    object until compiled calls finish and captured CUDA graphs are reset.
    """

    def __init__(self, owner):
        self._owner = owner
        self.name = owner.name()
        self.handle = owner.id()
        self.operation = getattr(load_extension(), self.name).default
        self.inputs = tuple(owner.inputs())
        self.outputs = tuple(owner.outputs())

    def __call__(self, inputs, outputs):
        self.operation(list(inputs), list(outputs), self.handle)
        return tuple(outputs)


class PreparedSequence:
    """A C++ selected schedule expanded into individually visible Torch ops.

    ``sequence(*sequence.tensors)`` is the eager call. Compile this callable with
    ``torch.compile(sequence, backend='aot_eager', fullgraph=True)`` and pass the
    same explicit tensor list (or tensors with matching physical extents).
    Each op declares its mutations, including synchronization counters. Kernel
    selection and pointer-role metadata come entirely from the C++ plan.

    This is an inference workspace: order invocations on the caller's stream.
    PyTorch functionalization may copy mutable buffers; the integrated C++ plan
    remains the low-overhead deployment path. Keep this sequence alive through
    compiled execution and CUDA graph lifetime.
    """

    def __init__(self, plan):
        self.kernels = tuple(PreparedKernel(owner) for owner in plan.prepare_kernels())
        self.tensors = tuple(plan.tensor_arguments())
        indices = tuple(tuple(row) for row in plan.kernel_tensor_indices())
        if len(indices) != 2 * len(self.kernels):
            raise RuntimeError('C++ kernel schedule has inconsistent tensor metadata')
        self.input_indices = indices[::2]
        self.output_indices = indices[1::2]
        self.output_index = len(plan.buffer_names()) - 1
        self.tensor_count = len(self.tensors)

        self.cpp_sequence = load_extension().create_kernel_sequence(
            [kernel._owner for kernel in self.kernels])

    def __call__(self, *tensors):
        if len(tensors) != self.tensor_count:
            raise ValueError('Supply every tensor from the prepared C++ schedule')
        for kernel, inputs, outputs in zip(self.kernels, self.input_indices, self.output_indices):
            kernel([tensors[index] for index in inputs], [tensors[index] for index in outputs])
        return tensors[self.output_index]

    def run_cpp(self):
        """Launch the bound chain entirely in C++; eager/CUDA capture entry point.

        This uses the original bound tensors. Use ``sequence(*tensors)`` for
        compiler-visible dependencies or to provide replacement storage.
        """
        return self.cpp_sequence.run()[0]


def prepare_kernels(plan):
    """Expose all 185 prepared trunk launches as named, composable Torch ops."""
    return PreparedSequence(plan)


def prepare_output_view_fp8(state, record, output, *, height, width, phase=0):
    """Prepare the individual C32 output-view export outside graph capture."""
    return PreparedKernel(load_extension().prepare_output_view_fp8(
        state, record, output, height, width, phase))


def prepare_output_view_fp16(state, record, output, *, height, width, phase=0):
    """Prepare the individual Half C32 output-view export outside graph capture."""
    return PreparedKernel(load_extension().prepare_output_view_fp16(
        state, record, output, height, width, phase))


def prepare_frontend(name, configuration, inputs, outputs, *, linear_filter=False):
    """Bind one renderer export to explicit tensors and owned CUDA resources.

    Prepare outside capture. The configuration is a CPU uint8 native ABI blob
    with pointer/texture/surface fields zero. Texture tensors are contiguous
    float32 HWC4; packed features/records are one-dimensional uint8. The C++
    frontend descriptor validates the exact role contracts for the named export.
    """
    return PreparedKernel(load_extension().prepare_frontend(
        name, configuration, list(inputs), list(outputs), linear_filter))


def frontend_configuration(name, *, height, width, valid_height=0, valid_width=0, phase=0, seed=0):
    """Build an owned, zero-pointer CPU ABI configuration through typed C++ fields."""
    return load_extension().frontend_configuration(
        name, height, width, valid_height, valid_width, phase, seed)


def compose_kernels(kernels):
    """Compose prepared renderer/trunk kernels in the given explicit order.

    Reuse the same tensor objects at adjacent producer/consumer edges. The
    returned object supports explicit-argument ``torch.compile`` and bound
    ``run_cpp()`` execution. Its result is the first output of the final kernel;
    additional outputs remain available as mutable tensor arguments.
    """
    kernels = tuple(kernels)
    if not kernels or not kernels[-1].outputs:
        raise ValueError('Composition requires kernels and a final output')
    sequence = PreparedSequence.__new__(PreparedSequence)
    tensors, tensor_indices = [], {}

    def indices(arguments):
        result = []
        for tensor in arguments:
            identity = id(tensor)
            if identity not in tensor_indices:
                tensor_indices[identity] = len(tensors)
                tensors.append(tensor)
            result.append(tensor_indices[identity])
        return tuple(result)

    sequence.kernels = kernels
    sequence.input_indices = tuple(indices(kernel.inputs) for kernel in kernels)
    sequence.output_indices = tuple(indices(kernel.outputs) for kernel in kernels)
    sequence.tensors = tuple(tensors)
    sequence.tensor_count = len(tensors)
    sequence.output_index = sequence.output_indices[-1][0]
    sequence.cpp_sequence = load_extension().create_kernel_sequence(
        [kernel._owner for kernel in kernels])
    return sequence
