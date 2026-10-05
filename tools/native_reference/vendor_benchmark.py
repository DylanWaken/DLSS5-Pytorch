"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import ctypes as C
import hashlib
import os
from pathlib import Path


KERNEL = "cc_vit_1d_ffn_expand_fp8"


CUBIN_SHA256 = "bfb2ebe117b7c4d92a78e1885412acbb80233f2d9b11af1e854430eb3cc0a2a1"


GUARD_BYTES = 4096


GUARD_VALUE = 0xA7


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def input_offsets(tokens, channels=1024):
    import numpy as np
    m, k = np.arange(tokens, dtype=np.int64)[:, None], np.arange(channels, dtype=np.int64)[None, :]
    return ((m // 16) * channels * 16 + (k // 32) * 512 + (m % 8) * 64
            + ((k % 16) // 4) * 16 + ((k % 32) // 16) * 8 + ((m % 16) // 8) * 4 + k % 4)


def output_offsets(tokens, channels=4096):
    import numpy as np
    m, n = np.arange(tokens, dtype=np.int64)[:, None], np.arange(channels, dtype=np.int64)[None, :]
    return ((m // 16) * channels * 16 + (n // 32) * 512 + (m % 8) * 64
            + ((n % 8) // 2) * 16 + ((n % 32) // 16) * 8 + ((m % 16) // 8) * 4
            + ((n % 16) // 8) * 2 + n % 2)


def natural_channel_index(physical):
    """OpenDLSS packedInputIndex: map the vendor's K lane to graph channels."""
    within = physical & 31
    quarter = within & 15
    return (physical & ~31) + (within & 16) + (quarter >> 2) * 2 + (quarter & 1) + ((quarter & 2) != 0) * 8


class VendorModule:
    """Own one verified CUDA module; use Torch's existing context and stream."""
    def __init__(self, cubin, stream, kernel=KERNEL, parameter_bytes=72, *, shared_module=None):
        if os.name != "nt":
            raise RuntimeError("this harness currently targets the Windows NVIDIA driver")
        self.lib = C.WinDLL(str(Path(os.environ["SystemRoot"]) / "System32" / "nvcuda.dll"))
        self.module, self.function = C.c_void_p(), C.c_void_p()
        self._shared_owner = shared_module
        self._owns_module = shared_module is None
        self.stream = C.c_void_p(stream)
        ptr = C.c_void_p
        declarations = {
            "cuGetErrorString": [C.c_int, C.POINTER(C.c_char_p)],
            "cuCtxGetCurrent": [C.POINTER(ptr)],
            "cuModuleLoadData": [C.POINTER(ptr), ptr],
            "cuModuleUnload": [ptr],
            "cuModuleGetFunction": [C.POINTER(ptr), ptr, C.c_char_p],
            "cuFuncGetParamInfo": [ptr, C.c_size_t, C.POINTER(C.c_size_t), C.POINTER(C.c_size_t)],
            "cuFuncGetAttribute": [C.POINTER(C.c_int), C.c_int, ptr],
            "cuOccupancyMaxActiveBlocksPerMultiprocessor": [C.POINTER(C.c_int), ptr, C.c_int, C.c_size_t],
            "cuLaunchKernel": [ptr, C.c_uint, C.c_uint, C.c_uint, C.c_uint, C.c_uint, C.c_uint,
                               C.c_uint, ptr, C.POINTER(ptr), C.POINTER(ptr)],
        }
        for name, args in declarations.items():
            function = getattr(self.lib, name)
            function.argtypes, function.restype = args, C.c_int
        current = ptr()
        self.call("cuCtxGetCurrent", C.byref(current))
        if not current:
            raise RuntimeError("Torch must initialize the current CUDA context before loading vendor code")
        if shared_module is None:
            data = C.create_string_buffer(cubin)
            self.call("cuModuleLoadData", C.byref(self.module), data)
        else:
            if not shared_module.module or current.value != shared_module.context:
                raise ValueError("shared original module must belong to the current live CUDA context")
            self.module = C.c_void_p(shared_module.module.value)
        self.context = current.value
        try:
            self.call("cuModuleGetFunction", C.byref(self.function), self.module, kernel.encode("ascii"))
            offset, size = C.c_size_t(), C.c_size_t()
            self.call("cuFuncGetParamInfo", self.function, 0, C.byref(offset), C.byref(size))
            if (offset.value, size.value) != (0, parameter_bytes):
                raise ValueError(f"original kernel ABI differs from the reviewed {parameter_bytes}-byte contract")
            self.attributes = {"parameter_offset": offset.value, "parameter_bytes": size.value}
            for label, index in (("max_threads", 0), ("static_shared_bytes", 1), ("registers_per_thread", 4)):
                value = C.c_int()
                self.call("cuFuncGetAttribute", C.byref(value), index, self.function)
                self.attributes[label] = value.value
        except BaseException:
            self.close()
            raise

    def call(self, name, *args):
        code = getattr(self.lib, name)(*args)
        if code:
            message = C.c_char_p()
            self.lib.cuGetErrorString(code, C.byref(message))
            raise RuntimeError(f"{name}: CUDA error {code}: {(message.value or b'unknown').decode()}")

    def launch(self, parameters, spec):
        storage = C.create_string_buffer(parameters)
        arguments = (C.c_void_p * 1)(C.addressof(storage))
        self.call("cuLaunchKernel", self.function, *spec["grid"], *spec["block"], 0,
                  self.stream, arguments, None)

    def active_blocks_per_sm(self, threads, dynamic_shared_bytes=0):
        result = C.c_int()
        self.call("cuOccupancyMaxActiveBlocksPerMultiprocessor", C.byref(result), self.function,
                  threads, dynamic_shared_bytes)
        return result.value

    def close(self):
        if self.module:
            if self._owns_module:
                self.call("cuModuleUnload", self.module)
            self.module = C.c_void_p()


def guarded_tensor(data, device):
    import numpy as np
    import torch
    raw = np.frombuffer(data, dtype=np.uint8).copy()
    tensor = torch.full((len(raw) + 2 * GUARD_BYTES,), GUARD_VALUE, dtype=torch.uint8, device=device)
    tensor[GUARD_BYTES:-GUARD_BYTES].copy_(torch.from_numpy(raw).to(device))
    return tensor, tensor.data_ptr() + GUARD_BYTES
