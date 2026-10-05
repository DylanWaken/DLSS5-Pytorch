"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
import math
import struct
from .vendor_benchmark import GUARD_BYTES, GUARD_VALUE, VendorModule, output_offsets
from .vendor_linear_benchmark import launch_spec as linear_spec, packed_input
from .vendor_qkv_benchmark import launch_spec as qkv_spec, physical_to_logical_mapping


KERNELS = {"expand": "cc_vit_1d_ffn_expand_fp8", "contract": "cc_vit_1d_ffn_contract_fp8",
           "qkv": "cc_vit_1d_qkv_fp8", "attention": "cc_vit_1d_attention_fp8",
           "projection": "cc_vit_1d_projection_fp8"}


class NativeBlock:
    def __init__(self, cubin, stream, device, codes, payloads, *, token_alignment=32, attention_variant="plain", resources=None, borrowed=None):
        import numpy as np
        import torch
        self.stream, self.tokens = stream, codes.shape[0]
        self.reset_callback = None
        m = self.tokens
        if attention_variant not in ("plain","chained"):
            raise ValueError("native attention variant must be plain or chained")
        self.attention_variant=attention_variant
        if token_alignment not in (32,64,128,256):
            raise ValueError("diagnostic native token alignment must be32/64/128/256")
        self.padded_tokens = (m + token_alignment-1) // token_alignment * token_alignment
        from .vendor_resources import initialize_buffers
        self.borrowed={} if borrowed is None else dict(borrowed)
        input_data=None
        if "input" not in self.borrowed:
            padded_codes = np.zeros((self.padded_tokens, 1024), dtype=np.uint8)
            padded_codes[:m] = codes
            input_data=packed_input(padded_codes).tobytes()
        linear, qkv = linear_spec(m), qkv_spec(m)
        initial = {"input": input_data}
        initial.update({name: bytes([0x6A]) * self.padded_tokens * channels for name, channels in
                        (("expanded", 4096), ("contracted", 1024), ("Q", 1024), ("K", 1024),
                         ("V", 1024), ("attended", 1024), ("output", 1024))})
        written_tokens = (m + 31) // 32 * 32
        for name in ("Q","K","V"):
            initial[name] = bytes([0x6a]) * (written_tokens*1024) + bytes((self.padded_tokens-written_tokens)*1024)
        for stage, spec in (("contract", linear), ("qkv", qkv), ("projection", linear)):
            initial[stage + "_counter"] = bytes([0xff]) * spec["counter_bytes"]
            initial[stage + "_scratch"] = bytes([0x6A]) * spec["scratch_bytes"]
        if attention_variant=="chained":
            initial["attention_counter"]=bytes([0xff])*(32*((m+127)//128)*4)
        initial.update({"weight" + str(layer): data for layer, data in payloads.items()})
        self.initial = initial
        self.allocations = initialize_buffers(initial,device,resources=resources,borrowed=self.borrowed,expected_bytes={"input":self.padded_tokens*1024})
        self.modules = {}
        try:
            for name, kernel in KERNELS.items():
                if name=="attention" and attention_variant=="chained":
                    kernel="cc_vit_1d_attention_chained_fp8"
                size=80 if name == "qkv" else 64 if name == "attention" else 72
                self.modules[name] = resources.module(cubin,kernel,size) if resources is not None else VendorModule(cubin,stream.cuda_stream,kernel,size)
        except BaseException:
            self.close()
            raise
        p = lambda name: self.allocations[name][1]
        self.parameters = {
            "expand": struct.pack("<8Q2i", p("input"), 0, p("expanded"), p("weight0"), 0, 0, 0, 0, 1, m),
            "contract": struct.pack("<8Q2i", p("expanded"), p("input"), p("contracted"), p("weight1"),
                                    p("contract_counter"), p("contract_scratch"), 0, 0, 1, m),
            "qkv": struct.pack("<9Q2i", p("contracted"), p("Q"), p("K"), p("V"), p("weight2"),
                               p("qkv_counter"), p("qkv_scratch"), 0, 0, 1, m),
            "attention": struct.pack("<7Q2i", p("Q"), p("K"), p("V"), p("attended"), 0,
                                     p("qkv_counter") if attention_variant=="chained" else 0,
                                     p("attention_counter") if attention_variant=="chained" else 0, 1, m),
            "projection": struct.pack("<8Q2i", p("attended"), p("contracted"), p("output"), p("weight4"),
                                      p("projection_counter"), p("projection_scratch"), 0, 0, 1, m)}
        self.specs = {"expand": {"grid": [32 * ((m + 127) // 128), 1, 1], "block": [32, 4, 1]},
                      "contract": linear, "qkv": qkv,
                      "attention": {"grid": [32, (m + 255) // 256, 1], "block": [32, 4, 1]},
                      "projection": linear}
        # Ordered split-K uses inter-CTA progress. Conservatively require every
        # split CTA to fit simultaneously according to the actual original
        # function's occupancy, rather than assuming one block per SM.
        sms = torch.cuda.get_device_properties(device).multi_processor_count
        for stage in ("contract", "qkv", "projection"):
            active = self.modules[stage].active_blocks_per_sm(128)
            launched = math.prod(self.specs[stage]["grid"])
            self.modules[stage].attributes["active_blocks_per_sm"] = active
            if launched > active * sms:
                self.close()
                raise ValueError(f"{stage} requires {launched} simultaneous split CTAs, capacity is {active*sms}")

    def __call__(self):
        if self.reset_callback is not None:
            self.reset_callback()
        else:
            for stage in ("contract", "qkv", "projection"):
                self.allocations[stage + "_counter"][0][GUARD_BYTES:-GUARD_BYTES].fill_(255)
            if self.attention_variant=="chained":
                self.allocations["attention_counter"][0][GUARD_BYTES:-GUARD_BYTES].fill_(255)
        for stage in KERNELS:
            self.modules[stage].launch(self.parameters[stage], self.specs[stage])
        return self.allocations["output"][0]

    def check_and_decode(self):
        import numpy as np
        self.stream.synchronize()
        decoded = {}
        for name, (tensor, _) in self.allocations.items():
            raw = tensor.cpu().numpy()
            if not (np.all(raw[:GUARD_BYTES] == GUARD_VALUE) and np.all(raw[-GUARD_BYTES:] == GUARD_VALUE)):
                raise AssertionError(f"original block modified {name} guard")
            payload = raw[GUARD_BYTES:-GUARD_BYTES]
            if (name == "input" and name not in self.borrowed) or name.startswith("weight"):
                if payload.tobytes() != self.initial[name]:
                    raise AssertionError(f"original block modified immutable {name}")
            elif name in ("Q", "K", "V"):
                natural = np.empty_like(payload)
                natural[physical_to_logical_mapping(name, self.padded_tokens)] = payload
                decoded[name] = natural.reshape(self.padded_tokens, 32, 32)[:self.tokens]
            elif name in ("expanded", "contracted", "attended", "output"):
                decoded[name] = payload[output_offsets(self.tokens, 4096 if name == "expanded" else 1024)]
            elif name.endswith("_counter"):
                expected = 0 if name.startswith("attention") else 1 if name.startswith("qkv") else 3
                if not np.all(payload.view(np.int32) == expected):
                    raise AssertionError(f"incomplete {name}")
        return decoded

    def close(self):
        for module in self.modules.values():
            module.close()
        self.modules.clear()
