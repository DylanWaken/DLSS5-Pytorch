"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
from .vendor_benchmark import GUARD_BYTES, GUARD_VALUE, VendorModule
from .vendor_window_benchmark import KERNELS, image_offsets, launch_spec, parameter_blob
from .vendor_downsample_probe import down_blob, down_offsets, half_extent, down_storage_bytes
from .vendor_upsample_probe import up_blob


class NativeFused:
    """One reviewed original fused window/transition with guarded storage."""
    def __init__(self, cubin, stream, device, case, inputs, weight, *, resources=None, layouts=None, borrowed=None):
        import numpy as np
        self.stream, self.modules = stream, {}
        self.case, self.output_offsets = case, {}
        h, w, c, phase = (case[n] for n in ("height", "width", "channels", "phase"))
        family, view = case["family"], case.get("view", "none")
        from .vendor_resources import initialize_buffers
        self.borrowed={} if borrowed is None else dict(borrowed)
        layout=lambda kind,h,w,c:layouts.get(kind,h,w,c) if layouts is not None else (image_offsets if kind=="tile" else down_offsets)(h,w,c)
        normal = layout("tile",h,w,c)
        if family == "up":
            if c == 32 and (h != half_extent(h)*2 or w != half_extent(w)*2):
                raise ValueError("padded C32 decoder compact plane stride is not mapped")
            input_index = layout("plane",half_extent(h),half_extent(w),2*c)
        else:
            input_index = layout("plane",h,w,c) if view == "input" else normal
        input_data=None
        if "input" not in self.borrowed:
            physical = np.empty(inputs["input"].size, dtype=np.uint8)
            physical[input_index] = inputs["input"]
            input_data=physical.tobytes()
        self.input_offsets = {"input": input_index}
        self.output_offsets["output"] = layout("plane",h,w,c) if view == "output" else normal
        initial = {"input": input_data, "output": bytes([0x6a]) * (h*w*c), "weight0": weight}
        suffix = {"down": "_ds_fp8", "up": "_upsample_fp8"}.get(family)
        if suffix is None:
            suffix = {"none": "_fp8", "input": "_inpview_fp8", "output": "_outview_fp8"}[view]
        symbol = KERNELS[c][1].removesuffix("_fp8") + suffix
        if family == "down":
            self.output_offsets["down"] = layout("plane",half_extent(h),half_extent(w),2*c)
            initial["down"] = bytes([0x6a]) * down_storage_bytes(h, w, c)
        elif family == "up":
            initial["skip"]=None
            if "skip" not in self.borrowed:
                physical_skip = np.empty(inputs["skip"].size, dtype=np.uint8)
                physical_skip[normal] = inputs["skip"]
                initial["skip"] = physical_skip.tobytes()
            self.input_offsets["skip"] = normal
        self.initial = initial
        self.allocations = initialize_buffers(initial,device,resources=resources,borrowed=self.borrowed,
                                              expected_bytes={name:int(value.size) for name,value in inputs.items()})
        size=96 if c == 32 else 88
        self.modules["output"] = resources.module(cubin,symbol,size) if resources is not None else VendorModule(cubin,stream.cuda_stream,symbol,size)
        pointers = [self.allocations[name][1] for name in initial]
        self.parameters = down_blob(pointers, h, w, c, phase) if family == "down" else up_blob(pointers, h, w, c, phase) if family == "up" else parameter_blob(pointers, h, w, c, phase, view)
        self.spec = launch_spec(h, w, c, phase)

    def __call__(self):
        self.modules["output"].launch(self.parameters, self.spec)
        return self.allocations["output"][0]

    def close(self):
        for module in self.modules.values():
            module.close()
        self.modules.clear()
