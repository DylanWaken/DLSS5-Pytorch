"""Minimal original-only asset and guarded trunk owner.

No candidate extension, model, decode helpers, selectors, or policy imports.
Caller-supplied raw WeightArchive is optional and is checked byte-for-byte.
Keep this owner alive until all registered graphs have reset. Use lifetime.cli
in a disposable worker so uncertain CUDA teardown exits without finalization.
"""
from __future__ import annotations
from pathlib import Path
import struct
from .extract_assets import DLL_SHA256, RESOURCE_OFFSET, RESOURCE_SIZE, RESOURCE_SHA256, parse_records, pinned_dll
from .vendor_benchmark import CUBIN_SHA256, GUARD_BYTES, GUARD_VALUE, sha256
from .vendor_window_benchmark import KERNELS
from .vendor_connectors import UP512_SHA256
from .vendor_resources import NativeResources
from .trunk import NativeTrunk
from .lifetime import NativeGraphOwner


class OriginalCounterReset:
    """Retained original module6 cc_cb_clear launches for one fixed block.

    One 16-byte by-value parameter blob: pointer, signed word count, zero
    ignored slot. No candidate operator or Torch fill participates in replay.
    """
    def __init__(self, module, allocations, word_counts):
        self.module = module
        self.entries = []
        for name, words in word_counts:
            tensor, pointer = allocations[name]
            if type(words) is not int or not 0 < words < 2**31:
                raise ValueError("original clear needs positive signed32 word count")
            if tensor.numel() != words * 4 + 2 * GUARD_BYTES:
                raise ValueError("original clear word count differs from guarded payload")
            if type(pointer) is not int or not 0 < pointer < 2**64 or pointer % 4 or pointer != tensor.data_ptr() + GUARD_BYTES:
                raise ValueError("original clear pointer differs from guarded payload")
            parameters = struct.pack("<Qii", pointer, words, 0)
            spec = {"grid": [(words + 255)//256, 1, 1], "block": [256, 1, 1]}
            self.entries.append((name, tensor, pointer, words, parameters, spec))

    def __call__(self):
        for name, tensor, pointer, words, parameters, spec in self.entries:
            if tensor.data_ptr() + GUARD_BYTES != pointer or tensor.numel() != words * 4 + 2 * GUARD_BYTES:
                raise ValueError("original counter storage changed before launch: " + name)
            self.module.launch(parameters, spec)


def install_original_counter_resets(trunk, resources, decoder_module):
    """Install 33 original clears in the same order as the compiled plan."""
    clear = resources.module(decoder_module, "cc_cb_clear", 16)
    retained = []
    for block in range(31, 39):
        node = trunk.blocks[block]
        if node.attention_variant != "chained":
            raise ValueError("original clear adapter requires chained attention")
        callback = OriginalCounterReset(clear, node.allocations,
            tuple((name, (node.allocations[name][0].numel() - 2 * GUARD_BYTES) // 4)
                  for name in ("contract_counter", "qkv_counter", "attention_counter", "projection_counter")))
        node.reset_callback = callback
        retained.append(callback)
    node = trunk.blocks[39]
    callback = OriginalCounterReset(clear, node.allocations, (("up_counter", node.spec["counter_bytes"] // 4),))
    node.reset_callback = callback
    retained.append(callback)
    trunk.original_counter_resets = tuple(retained)
    return trunk.original_counter_resets


class NativeArtifacts:
    """CPU-only pinned original DLL resource, cubins, and raw record slices."""
    def __init__(self, asset_root, *, dll=None, archive=None):
        root = Path(asset_root).resolve()
        data = pinned_dll(Path(dll) if dll is not None else root / "original/nvngx_dlssnr.dll")
        self.resource = data[RESOURCE_OFFSET:RESOURCE_OFFSET + RESOURCE_SIZE]
        if len(self.resource) != RESOURCE_SIZE or sha256(self.resource) != RESOURCE_SHA256:
            raise ValueError("original resource identity mismatch")
        self.records = {row["name"]: row for row in parse_records(self.resource)}
        self.modules, self.module_hashes = {}, {}
        for channels, (module_id, _, digest) in KERNELS.items():
            code = (root / "vendor_modules" / f"module_{module_id}.cubin").read_bytes()
            if sha256(code) != digest:
                raise ValueError(f"original module_{module_id} identity mismatch")
            self.modules[channels] = code
            self.module_hashes[str(module_id)] = digest
        self.modules[1024] = (root / "vendor_modules/module_5.cubin").read_bytes()
        self.decoder_module = (root / "vendor_modules/module_6.cubin").read_bytes()
        if sha256(self.modules[1024]) != CUBIN_SHA256 or sha256(self.decoder_module) != UP512_SHA256:
            raise ValueError("original global/decoder module identity mismatch")
        self.module_hashes.update({"5": CUBIN_SHA256, "6": UP512_SHA256})
        self._weight_payloads = {}
        self.archive_checked = archive is not None
        if archive is not None:
            if set(archive.records) != set(self.records):
                raise ValueError("raw archive names differ from original resource")
            for name, row in self.records.items():
                actual = archive.tensor(row["block"], row["layer"], row["parameter"])
                if bytes(actual.data) != self.record(name):
                    raise ValueError(f"raw archive differs from original resource: {name}")

    def record(self, name):
        row = self.records[name]
        offset = row["resourceOffset"]
        return self.resource[offset:offset + row["byteLength"]]

    def weights(self, index, layers):
        result = {}
        for layer in layers:
            key = (index, layer)
            if key not in self._weight_payloads:
                self._weight_payloads[key] = self.record(f"block{index}.layer{layer}.layer")
            result[layer] = self._weight_payloads[key]
        return result

    def identity(self):
        return {"dll_sha256": DLL_SHA256, "resource_sha256": RESOURCE_SHA256,
                "module_sha256": dict(self.module_hashes), "record_count": len(self.records),
                "raw_archive_matches_original": self.archive_checked,
                "native_attention": "chained", "token_alignment": 32,
                "counter_reset": "original_module6_cc_cb_clear",
                "compute_repack_calls": 152, "original_counter_clear_calls": 33,
                "original_only": True, "complete_dll_comparison": False}


class NativeReference(NativeArtifacts):
    """Eager original trunk owner, with explicit reusable graph ownership.

    Constructor reads pinned CPU assets only. build_trunk initializes CUDA and
    retains all original nodes, physical layouts and buffers. No GPU operation
    occurs merely by importing this module. The public admission is the four explicit benchmark resolutions.
    """
    def __init__(self, asset_root, *, dll=None, device=0, archive=None):
        super().__init__(asset_root, dll=dll, archive=archive)
        if type(device) is not int or device < 0:
            raise ValueError("device must be a nonnegative integer")
        self.device = device
        self.native_attention = "chained"
        self.native_token_alignment = 32
        self.stream = None
        self.resources = None
        self._trunks = []
        self._input_snapshots = {}
        self.lifetime = NativeGraphOwner(self._synchronize, label="original-only native reference")

    def _synchronize(self):
        if self.stream is not None:
            self.stream.synchronize()

    def _open(self):
        if self.lifetime.closed or self.lifetime.quarantined:
            raise RuntimeError("native reference is closed or quarantined")
        if self.resources is not None:
            self.resources.require_open()
            return
        import torch
        torch.cuda.set_device(self.device)
        if torch.cuda.get_device_capability(self.device) != (12, 0):
            raise RuntimeError("pinned original cubins require SM120")
        self.stream = torch.cuda.Stream(device=self.device)
        self.stream.wait_stream(torch.cuda.current_stream(self.device))
        self.resources = NativeResources(self.device, self.stream)
        self.lifetime.own(self.resources, self._close_resources)

    def _close_resources(self):
        import torch
        with torch.cuda.device(self.device):
            self.resources.close()

    def build_trunk(self, geometry, input_codes):
        import numpy as np
        if (geometry.valid_width, geometry.valid_height) not in ((1280, 720), (1920, 1080), (2560, 1440), (3840, 2160)):
            raise ValueError("reference admits B1 FP8 at 720p, 1080p, 1440p, and 2160p")
        w, h = geometry.levels[0]
        if input_codes.dtype != np.uint8 or input_codes.shape != (h, w, 32):
            raise ValueError("input_codes must be logical uint8 [level0_height,level0_width,32]")
        self._open()
        import torch
        with self.lifetime.stream(torch.cuda.stream(self.stream)):
            trunk = NativeTrunk(self, geometry, input_codes)
            self.lifetime.retain(trunk)
            self._trunks.append(trunk)
            self.lifetime.retain(install_original_counter_resets(trunk, self.resources, self.decoder_module))
            first = trunk.blocks[1].allocations["input"][0]
            self._input_snapshots[id(trunk)] = first[GUARD_BYTES:-GUARD_BYTES].clone()
        return trunk

    def physical_input(self, trunk):
        """The original plane-layout block1 input, excluding guards."""
        self._require_trunk(trunk)
        return trunk.blocks[1].allocations["input"][0][GUARD_BYTES:-GUARD_BYTES]

    def _require_trunk(self, trunk):
        if not any(value is trunk for value in self._trunks):
            raise ValueError("trunk is not owned by this reference")
        if self.lifetime.closed or self.lifetime.quarantined:
            raise RuntimeError("native reference is closed or quarantined")

    def physical_boundaries(self, trunk):
        """74 borrowed tensor views. Retain this owner throughout their use.

        Downsample allocation padding is preserved. Each corresponding index
        map in trunk.boundaries identifies the logical bytes for comparison.
        """
        self._require_trunk(trunk)
        return {name: node.allocations[key][0][GUARD_BYTES:-GUARD_BYTES]
                for name, (node, key, _) in trunk.boundaries.items()}

    def deployment_boundaries(self, trunk):
        """Use compiled-plan names for the same 74 physical boundary views.

        No layout conversion or padding truncation occurs. Global token output
        allocations include the original padded rows; graph proof may compare
        logical positions separately when padding is outside the contract.
        """
        result = {}
        for name, value in self.physical_boundaries(trunk).items():
            parts = name.split("-")
            if len(parts) == 2 and parts[0] == "block":
                key = "b" + parts[1] + ".output"
            elif len(parts) == 3 and parts[0] == "transition" and int(parts[2]) == int(parts[1]) + 1:
                key = "b" + parts[1] + ".down"
            else:
                raise ValueError("unrecognized native boundary " + name)
            if key in result:
                raise ValueError("duplicate deployment boundary " + key)
            result[key] = value
        return result

    def check(self, trunk):
        self._require_trunk(trunk)
        import torch
        self._synchronize()
        seen = set()
        for _, node in trunk.nodes:
            for name, (allocation, _) in node.allocations.items():
                if id(allocation) not in seen:
                    if not bool(torch.all(allocation[:GUARD_BYTES] == GUARD_VALUE)) or not bool(torch.all(allocation[-GUARD_BYTES:] == GUARD_VALUE)):
                        raise AssertionError(f"original reference modified {name} guard")
                    seen.add(id(allocation))
                payload = allocation[GUARD_BYTES:-GUARD_BYTES]
                if name.startswith("weight") and not torch.equal(payload, self.resources.immutable_reference(allocation)):
                    raise AssertionError("original reference modified a weight")
                if name.endswith("_counter"):
                    expected = 0 if name.startswith("attention") else 1 if name.startswith("qkv") else 3
                    if not bool(torch.all(payload.view(torch.int32) == expected)):
                        raise AssertionError(f"original reference incomplete {name}")
        if not torch.equal(self.physical_input(trunk), self._input_snapshots[id(trunk)]):
            raise AssertionError("original reference modified initial input")

    def run_trunk(self, trunk):
        self._require_trunk(trunk)
        import torch
        with self.lifetime.stream(torch.cuda.stream(self.stream)):
            trunk()
        self.check(trunk)
        return self.physical_boundaries(trunk)

    def close(self):
        if not self.lifetime.closed:
            self.lifetime.__exit__(None, None, None)

    def __enter__(self):
        return self

    def __exit__(self, kind, error, tb):
        return self.lifetime.__exit__(kind, error, tb)
