"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import math
import struct
from .vendor_benchmark import GUARD_BYTES, VendorModule, output_offsets
from .vendor_window_benchmark import image_offsets, launch_spec


UP512_SHA256 = "e67c8db5c29348f1650c532735b0d4740f6a003b7f932ae5c505a41ced082e7a"


def up512_spec(height, width, target_height, target_width):
    launch_spec(height, width, 512, 0)
    launch_spec(target_height, target_width, 512, 0)
    if not (2*height-4 <= target_height <= 2*height and 2*width-4 <= target_width <= 2*width):
        raise ValueError("target must be exactly doubled or a four-pixel crop of the aligned lower field")
    nx, ny = (width + 3)//4, (height + 3)//4
    return {"grid": [2*nx, ny, 4], "block": [32, 2, 1], "counter_bytes": 2*nx*ny*4,
            "scratch_bytes": height*width*512*2}


class NativeUp512:
    def __init__(self, cubin, stream, device, input_codes, skip_codes, weight, *, resources=None, layouts=None, borrowed=None):
        import numpy as np
        import torch
        h, w, _ = input_codes.shape
        th, tw, _ = skip_codes.shape
        self.stream, self.modules = stream, {}
        self.reset_callback = None
        self.spec = up512_spec(h, w, th, tw)
        from .vendor_resources import initialize_buffers
        self.borrowed={} if borrowed is None else dict(borrowed)
        image=lambda h,w,c:layouts.get("tile",h,w,c) if layouts is not None else image_offsets(h,w,c)
        self.input_offsets = {"input": image(h,w,1024), "skip": image(th,tw,512)}
        self.output_offsets = {"output": self.input_offsets["skip"]}
        initial = {}
        for name, codes in (("input", input_codes), ("skip", skip_codes)):
            initial[name]=None
            if name not in self.borrowed:
                packed = np.empty(codes.size, np.uint8)
                packed[self.input_offsets[name]] = codes
                initial[name] = packed.tobytes()
        initial.update(output=bytes([0x6a])*skip_codes.size, weight0=weight,
                       up_counter=bytes([0xff])*self.spec["counter_bytes"],
                       scratch=bytes([0x6a])*self.spec["scratch_bytes"])
        self.initial = initial
        self.allocations = initialize_buffers(initial,device,resources=resources,borrowed=self.borrowed,
                                              expected_bytes={"input":int(input_codes.size),"skip":int(skip_codes.size)})
        symbol="cc_dec_input_upsample_1024_512_fp8"
        module = resources.module(cubin,symbol,80) if resources is not None else VendorModule(cubin,stream.cuda_stream,symbol,80)
        self.modules["output"] = module
        active = module.active_blocks_per_sm(64)
        module.attributes["active_blocks_per_sm"] = active
        if math.prod(self.spec["grid"]) > active*torch.cuda.get_device_properties(device).multi_processor_count:
            self.close()
            raise ValueError("original decoder split CTAs exceed conservative concurrent residency capacity")
        p = lambda name: self.allocations[name][1]
        self.parameters = struct.pack("<8Q4i", p("input"), p("skip"), p("output"), 0, p("up_counter"), 0,
                                      p("scratch"), p("weight0"), h, w, th, tw)

    def __call__(self):
        if self.reset_callback is not None:
            self.reset_callback()
        else:
            self.allocations["up_counter"][0][GUARD_BYTES:-GUARD_BYTES].fill_(255)
        self.modules["output"].launch(self.parameters, self.spec)
        return self.allocations["output"][0]

    def close(self):
        for module in self.modules.values():
            module.close()
        self.modules.clear()


class NativeRepack:
    def __init__(self, cubin, stream, device, codes, direction, *, resources=None, layouts=None, borrowed=None):
        import numpy as np
        h, w, c = codes.shape
        if direction not in ("to1d", "to2d") or c != 1024:
            raise ValueError("repack requires1024 channels and to1d/to2d direction")
        self.stream, self.modules = stream, {}
        from .vendor_resources import initialize_buffers
        self.borrowed={} if borrowed is None else dict(borrowed)
        spatial = layouts.get("tile",h,w,c) if layouts is not None else image_offsets(h,w,c)
        tokens, padded = h*w, (h*w+31)//32*32
        token = layouts.get("token",h,w,c) if layouts is not None else output_offsets(tokens,c).reshape(h,w,c)
        self.input_offsets = {"input": spatial if direction == "to1d" else token}
        self.output_offsets = {"output": token if direction == "to1d" else spatial}
        input_bytes=tokens*c if direction=="to1d" else padded*c
        input_data=None
        if "input" not in self.borrowed:
            physical = np.zeros(input_bytes, dtype=np.uint8)
            physical[self.input_offsets["input"]] = codes
            input_data=physical.tobytes()
        self.initial = {"input":input_data,"output":bytes([0x6a])*(padded*c if direction=="to1d" else tokens*c)}
        self.allocations = initialize_buffers(self.initial,device,resources=resources,borrowed=self.borrowed,expected_bytes={"input":input_bytes})
        symbol = "cc_vit_1d_repack_" + ("2d_to_1d" if direction == "to1d" else "1d_to_2d") + "_fp8"
        self.modules["output"] = resources.module(cubin,symbol,24) if resources is not None else VendorModule(cubin,stream.cuda_stream,symbol,24)
        self.parameters = struct.pack("<2Q2i", self.allocations["input"][1], self.allocations["output"][1], h, w)
        self.spec = {"grid": [(padded*c//4+255)//256, 1, 1], "block": [256, 1, 1]}

    def __call__(self):
        self.modules["output"].launch(self.parameters, self.spec)

    def close(self):
        for module in self.modules.values():
            module.close()
        self.modules.clear()
