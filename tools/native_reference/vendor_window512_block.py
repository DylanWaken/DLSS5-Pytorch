"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import struct
from .vendor_benchmark import GUARD_BYTES, GUARD_VALUE, VendorModule
from .vendor_window_benchmark import image_offsets, launch_spec as window_spec, parameter_blob as window_blob
from .vendor_downsample_probe import down_offsets, half_extent
from .vendor_head512_probe import KERNEL as HEAD_KERNEL, launch_spec as head_spec, parameter_blob as head_blob


KERNEL_NAMES = {"branches": "cc_split_swin_16h_ffwd_512_fp8",
                "ffn": "cc_split_swin_16h_ffwd_proj_512_fp8",
                "attended": "cc_split_swin_16h_qkv_512_fp8",
                "output": "cc_split_swin_16h_proj_512_fp8"}


def launch_specs(height, width, phase):
    attention = window_spec(height, width, 512, phase)
    nx, ny = (width + 7) // 8, (height + 7) // 8
    return {"branches": {"grid": [nx, ny, 2], "block": [32, 8, 1]},
            "ffn": {"grid": [2 * nx, ny, 1], "block": [32, 4, 1]},
            "attended": attention,
            "output": {"grid": [2 * nx, ny, 1], "block": [32, 8, 1]}}


def linear_blob(pointers, height, width):
    window_spec(height, width, 512, 0)
    if len(pointers) != 4 or any(type(p) is not int or not 0 < p < 2**64 for p in pointers):
        raise ValueError("four nonzero unsigned CUDA pointers required")
    return struct.pack("<4Q2i4Q", *pointers, height, width, 0, 0, 0, 0)


class NativeWindow512:
    def __init__(self, cubin, stream, device, codes, weights, phase, *, view="none", down=False, resources=None, layouts=None, borrowed=None):
        import numpy as np
        self.stream, self.shape = stream, codes.shape
        h, w, c = self.shape
        if c != 512:
            raise ValueError("C512 input required")
        if view not in ("none", "input", "output") or (down and (view != "none" or 4 not in weights)):
            raise ValueError("C512 view must be none/input/output; down requires ordinary view and layer4")
        from .vendor_resources import initialize_buffers
        self.borrowed={} if borrowed is None else dict(borrowed)
        layout=lambda kind,h,w,c:layouts.get(kind,h,w,c) if layouts is not None else (image_offsets if kind=="tile" else down_offsets)(h,w,c)
        self.offsets = layout("tile",h,w,c)
        self.input_offsets = layout("plane",h,w,c) if view == "input" else self.offsets
        self.output_offsets = {name: self.offsets for name in KERNEL_NAMES}
        if view == "output":
            self.output_offsets["output"] = layout("plane",h,w,c)
        input_data=None
        if "input" not in self.borrowed:
            packed = np.empty(codes.size, dtype=np.uint8)
            packed[self.input_offsets] = codes
            input_data=packed.tobytes()
        self.initial = {"input": input_data}
        self.initial.update({name: bytes([0x6A]) * codes.size for name in KERNEL_NAMES})
        self.kernel_names = dict(KERNEL_NAMES)
        if view == "input":
            self.kernel_names["branches"] = "cc_split_swin_16h_ffwd_inpview_512_fp8"
            self.kernel_names["ffn"] = "cc_split_swin_16h_ffwd_proj_inpview_512_fp8"
        elif view == "output":
            self.kernel_names["output"] = "cc_split_swin_16h_proj_512_outview_fp8"
        if down:
            dh, dw = half_extent(h), half_extent(w)
            self.kernel_names["output"] = "cc_split_swin_16h_proj_pool_512_fp8"
            self.kernel_names["down"] = HEAD_KERNEL
            self.initial.update(pool=bytes([0x6A]) * (dh*dw*512), down=bytes([0x6A]) * (dh*dw*1024))
            self.output_offsets.update(pool=layout("tile",dh,dw,512),down=layout("tile",dh,dw,1024))
        self.initial.update({"weight" + str(layer): value for layer, value in weights.items()})
        self.allocations = initialize_buffers(self.initial,device,resources=resources,borrowed=self.borrowed,expected_bytes={"input":int(codes.size)})
        self.modules = {}
        try:
            for stage, kernel in self.kernel_names.items():
                size=56 if stage in ("branches", "attended") else 40 if stage == "down" else 80 if down and stage == "output" else 72
                self.modules[stage] = resources.module(cubin,kernel,size) if resources is not None else VendorModule(cubin,stream.cuda_stream,kernel,size)
        except BaseException:
            self.close()
            raise
        p = lambda name: self.allocations[name][1]
        self.parameters = {
            "branches": window_blob([p("input"), p("branches"), p("weight0")], h, w, c, 0),
            "ffn": linear_blob([p("branches"), p("input"), p("ffn"), p("weight1")], h, w),
            "attended": window_blob([p("ffn"), p("attended"), p("weight2")], h, w, c, phase),
            "output": linear_blob([p("attended"), p("ffn"), p("output"), p("weight3")], h, w)}
        self.specs = launch_specs(h, w, phase)
        if view == "input":
            self.specs["branches"]["block"] = [32, 4, 1]
        elif view == "output":
            self.specs["output"]["block"] = [32, 4, 1]
        if down:
            self.parameters["output"] = struct.pack("<8Q4i", p("attended"), p("ffn"), p("output"), p("pool"), p("weight3"),
                                                     0, 0, 0, h, w, dh, dw)
            self.parameters["down"] = head_blob([p("pool"), p("down"), p("weight4")], dh, dw)
            self.specs["output"] = {"grid": [2*((w+7)//8), (h+7)//8, 1], "block": [32, 4, 1]}
            self.specs["down"] = head_spec(dh, dw)

    def __call__(self):
        for stage in self.kernel_names:
            self.modules[stage].launch(self.parameters[stage], self.specs[stage])
        return self.allocations["output"][0]

    def check_decode(self):
        import numpy as np
        self.stream.synchronize()
        decoded = {}
        for name, (allocation, _) in self.allocations.items():
            raw = allocation.cpu().numpy()
            if not (np.all(raw[:GUARD_BYTES] == GUARD_VALUE) and np.all(raw[-GUARD_BYTES:] == GUARD_VALUE)):
                raise AssertionError(f"original C512 replay modified {name} guard")
            payload = raw[GUARD_BYTES:-GUARD_BYTES]
            if (name == "input" and name not in self.borrowed) or name.startswith("weight"):
                if payload.tobytes() != self.initial[name]:
                    raise AssertionError(f"original C512 replay modified immutable {name}")
            elif name in self.output_offsets:
                decoded[name] = payload[self.output_offsets[name]].copy()
        return decoded

    def close(self):
        for module in self.modules.values():
            module.close()
        self.modules.clear()
