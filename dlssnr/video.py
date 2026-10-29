"""Shared native RGB gameplay frame pipeline and comparison/benchmark support.

The comparison is deliberately **RGB-only and stateless**.  Every frame is
rendered with empty history, motion, depth, conditioning and blend tensors, so
the native preprocess takes its source-backed no-history branch (it copies the
current colour into the history feature lanes) and the native postprocess takes
the current colour plus the four-channel head.  No temporal, optical-flow or
zero-motion quality mode is invented here.

Both model selectors execute the real native chain::

    input_preprocess_window_downsample_c32_<precision>
        -> prepared RGB trunk sequence (185 legacy / 109 Small logical calls)
        -> window_block_c32_output_view_<precision>  (phase 3, plane16 b69)
        -> output_window_postprocess_c32_<precision>

Every descriptor of the base plan is reused verbatim except the final C32
ordinary producer, which is replaced by the existing C32 output-view kernel on
the same b69 allocation.  The base ``plan.run_*`` methods stay untouched and
still write the legacy tile4 layout; they are a separate diagnostic path, never
the RGB pipeline.  A typed packed-low check rejects hidden non-finite FP16/FP8
trunk fields before the post display clamp.

``legacy71`` uses the existing :class:`dlssnr.checkpoint.Checkpoint` plan and
``small31`` uses :class:`dlssnr.small_deployment.SmallNativeCheckpoint`.  The
module never falls back to a surrogate when the Small31 native ops are absent;
it raises :data:`SMALL31_REBUILD_MESSAGE`.

The display ABI trap is handled explicitly: the native builder leaves
``OutputScale=1.0`` and ``bDisplayOutput=0``, which is **not** RGB.  The post
configuration is patched at compiler-checked offsets 48 (float ``1/32``) and
52 (uint32 ``1``) before binding.
"""
from __future__ import annotations

import ctypes
import hashlib
import json
import math
import struct
import subprocess
import threading
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable, Sequence

import numpy as np
import torch

from .checkpoint import Checkpoint
from .deployment import (
    compose_kernels,
    frontend_configuration,
    load_extension,
    prepare_frontend,
    prepare_kernels,
    prepare_output_view_fp8,
    prepare_output_view_fp16,
)
from .geometry import Geometry, window_shift
from .model_specs import resolve_model
from .small_deployment import (
    PREPOST_RECORD_BYTES,
    SmallNativeCheckpoint,
    load_native_model,
)

MODEL_NAMES = ("legacy71", "small31")
NATIVE_PRECISIONS = ("fp8", "fp16")
IMAGE_SUFFIXES = (".png", ".jpg", ".jpeg")

PREPROCESS_NAMES = {
    "fp8": "input_preprocess_window_downsample_c32_fp8",
    "fp16": "input_preprocess_window_downsample_c32_fp16",
}
POSTPROCESS_NAMES = {
    "fp8": "output_window_postprocess_c32_fp8",
    "fp16": "output_window_postprocess_c32_fp16",
}

# FPostprocessParameters (csrc/kernel_impl/shared/common/kernel_abi.h:56-70) is
# 184 bytes.  These two fields are what make the native compositor emit RGB:
# OutputScale=1/32 and bDisplayOutput=1, i.e. clamp(c + head/4, 0, 1).
POST_ABI_BYTES = 184
POST_OUTPUT_SCALE_OFFSET = 48
POST_DISPLAY_OUTPUT_OFFSET = 52
POST_OUTPUT_SCALE = 1.0 / 32.0
POST_DISPLAY_OUTPUT = 1

PRE_ABI_BYTES = 264

# The base plan's final producer is the ordinary C32 call for b69.  Its record
# is the C32 packed window record; the output view reuses the same record and
# writes the level0 plane16 field into the same b69 allocation.
TRUNK_FINAL_ORDINARY = "window_block_c32"
TRUNK_FINAL_OUTPUT_VIEW = "window_block_c32_output_view"
TRUNK_OUTPUT_LAYOUT = "plane16"
PLAN_RUN_OUTPUT_LAYOUT = "tile4"
TRUNK_FINAL_PHASE = 3
TRUNK_FINAL_ORIGIN = (0, -4)
TRUNK_FINAL_RECORD_BYTES = {"fp16": 32960, "fp8": 20672}
TRUNK_FINAL_PHASE_SOURCE = (
    "Generated final C32 calls use Shape.Height(0)/Shape.Width(0) with origin "
    "(0,-4) and grid ceil(W0/8) x ceil((H0+4)/8); dlssnr.geometry.window_shift(3) "
    "is (0,4), so phase 3 is the generated origin. Small31 "
    "spec.phase_for_role(69) is 3; legacy71 phase tables are generated only.")
FP8_E4M3_NAN_MASK = 0x7F

SMALL31_REBUILD_MESSAGE = (
    "Small31 native deployment ops are missing from the loaded extension. "
    "The checked-in .pyd predates csrc/kernel_launcher/small_deployment.cpp and "
    "csrc/torch_api/small_extension.cpp. Rebuild in place with "
    "`python setup.py build_ext --inplace` (setup.py globs both directories), "
    "then rerun. No legacy or surrogate fallback is used."
)


class _FTextureTransform(ctypes.Structure):
    # kernel_abi.h: "bias/scale, then normalization, in this exact order".
    _fields_ = [
        ("BiasX", ctypes.c_float),
        ("BiasY", ctypes.c_float),
        ("ScaleX", ctypes.c_float),
        ("ScaleY", ctypes.c_float),
        ("NormalizeX", ctypes.c_float),
        ("NormalizeY", ctypes.c_float),
    ]


class _FPostprocessParameters(ctypes.Structure):
    """Mirror of the C++ postprocess ABI used only to assert field offsets."""

    _fields_ = [
        ("g_Input", ctypes.c_uint64),
        ("g_Adapter", ctypes.c_uint64),
        ("OutputSurface", ctypes.c_uint64),
        ("g_PackedWeights", ctypes.c_uint64),
        ("Height", ctypes.c_int32),
        ("Width", ctypes.c_int32),
        ("OriginX", ctypes.c_int32),
        ("OriginY", ctypes.c_int32),
        ("OutputScale", ctypes.c_float),
        ("bDisplayOutput", ctypes.c_uint32),
        ("ColorTexture", ctypes.c_uint64),
        ("ColorTransform", _FTextureTransform),
        ("HistoryTexture", ctypes.c_uint64),
        ("MotionTexture", ctypes.c_uint64),
        ("g_BlendScale", ctypes.c_uint64),
        ("bApplyMotion", ctypes.c_uint32),
        ("HistoryTransform", _FTextureTransform),
        ("MotionTransform", _FTextureTransform),
        ("MotionScaleX", ctypes.c_float),
        ("MotionScaleY", ctypes.c_float),
        ("ValidWidth", ctypes.c_int32),
        ("ValidHeight", ctypes.c_int32),
        ("ReservedPadding", ctypes.c_uint32),
    ]


# Source-checked layout invariants.  If the native ABI changes, importing this
# module fails loudly instead of silently writing the wrong display flags.
assert ctypes.sizeof(_FPostprocessParameters) == POST_ABI_BYTES
assert _FPostprocessParameters.OutputScale.offset == POST_OUTPUT_SCALE_OFFSET
assert _FPostprocessParameters.bDisplayOutput.offset == POST_DISPLAY_OUTPUT_OFFSET
assert POST_OUTPUT_SCALE == 0.03125


def resolve_precision(precision: str) -> str:
    """Return a supported native precision or raise for anything else."""
    if not isinstance(precision, str) or precision not in NATIVE_PRECISIONS:
        raise ValueError(
            f"unsupported precision {precision!r}; expected one of {NATIVE_PRECISIONS}")
    return precision


def element_bytes(precision: str) -> int:
    return 1 if resolve_precision(precision) == "fp8" else 2


def post_phase_for_model(model: str) -> int:
    """The native model-schedule post phase (legacy 1, Small31 0).

    These are model-schedule choices from ``dlssnr.model_specs``.  Small31's
    host phase is source-derived and not verified against DLL dispatch.
    """
    return resolve_model(model).post_phase_default


def _postprocess_array(configuration) -> np.ndarray:
    if isinstance(configuration, torch.Tensor):
        if (configuration.device.type != "cpu" or configuration.dtype != torch.uint8
                or configuration.dim() != 1):
            raise TypeError("postprocess ABI must be a CPU uint8 1-D tensor")
        array = configuration.numpy()
    else:
        array = np.frombuffer(configuration, dtype=np.uint8)
    if array.size != POST_ABI_BYTES:
        raise ValueError(
            f"postprocess ABI is {array.size} bytes; expected {POST_ABI_BYTES}")
    return array


def patch_postprocess_display(configuration):
    """Set the RGB display ABI in place and verify the written values.

    ``configuration`` is the CPU uint8 blob returned by
    :func:`dlssnr.deployment.frontend_configuration` for a postprocess name (or
    an equivalent writable 184-byte buffer).  The builder defaults are NOT RGB;
    this function is the only supported way to make the compositor emit RGB.
    """
    array = _postprocess_array(configuration)
    if not array.flags.writeable:
        raise ValueError("postprocess ABI patch requires a writable bytearray or CPU uint8 tensor")
    array[POST_OUTPUT_SCALE_OFFSET:POST_OUTPUT_SCALE_OFFSET + 4].view("<f4")[0] = POST_OUTPUT_SCALE
    array[POST_DISPLAY_OUTPUT_OFFSET:POST_DISPLAY_OUTPUT_OFFSET + 4].view("<u4")[0] = POST_DISPLAY_OUTPUT
    scale, display = postprocess_display_values(array)
    if scale != POST_OUTPUT_SCALE or display != POST_DISPLAY_OUTPUT:
        raise AssertionError("postprocess display ABI patch did not round-trip")
    return configuration


def postprocess_display_values(configuration) -> tuple[float, int]:
    """Read ``(OutputScale, bDisplayOutput)`` from a postprocess ABI blob."""
    array = _postprocess_array(configuration)
    scale = float(array[POST_OUTPUT_SCALE_OFFSET:POST_OUTPUT_SCALE_OFFSET + 4].view("<f4")[0])
    display = int(array[POST_DISPLAY_OUTPUT_OFFSET:POST_DISPLAY_OUTPUT_OFFSET + 4].view("<u4")[0])
    return scale, display


def assert_postprocess_display(configuration):
    """Require the RGB display ABI; used before every native post binding."""
    scale, display = postprocess_display_values(configuration)
    if scale != POST_OUTPUT_SCALE or display != POST_DISPLAY_OUTPUT:
        raise ValueError(
            "postprocess configuration is not RGB display: "
            f"OutputScale={scale!r}, bDisplayOutput={display!r}; "
            "expected 1/32 and 1")
    return configuration


@dataclass(frozen=True)
class FrameLayout:
    """Valid/physical extents and packed-buffer sizes for one resolution."""

    valid_width: int
    valid_height: int
    full_width: int
    full_height: int
    precision: str
    element_bytes: int
    adapter_full_bytes: int
    pooled_bytes: int

    @classmethod
    def for_frame(cls, width: int, height: int, precision: str) -> "FrameLayout":
        if (isinstance(width, bool) or isinstance(height, bool)
                or not isinstance(width, int) or not isinstance(height, int)):
            raise TypeError("frame width and height must be integers")
        if width < 1 or height < 1:
            raise ValueError("frame width and height must be positive")
        p = resolve_precision(precision)
        geometry = Geometry.from_valid(width, height)
        full_width, full_height = geometry.full_width, geometry.full_height
        if full_width % 8 or full_height % 8:
            raise ValueError("native frontends require physical extents divisible by 8")
        eb = element_bytes(p)
        full_pixels = full_width * full_height
        return cls(
            valid_width=width,
            valid_height=height,
            full_width=full_width,
            full_height=full_height,
            precision=p,
            element_bytes=eb,
            adapter_full_bytes=full_pixels * 32 * eb,
            pooled_bytes=full_pixels * 8 * eb,
        )

    @property
    def current_shape(self) -> tuple[int, int, int]:
        return (self.valid_height, self.valid_width, 4)

    @property
    def output_shape(self) -> tuple[int, int, int]:
        return (self.full_height, self.full_width, 4)

    @property
    def pooled_shape(self) -> tuple[int, int]:
        return (self.full_height // 2, self.full_width // 2)

    def as_dict(self) -> dict:
        return {
            "valid": {"width": self.valid_width, "height": self.valid_height},
            "physical": {"width": self.full_width, "height": self.full_height},
            "level0": {"width": self.full_width // 2, "height": self.full_height // 2},
            "precision": self.precision,
            "element_bytes": self.element_bytes,
            "current_texture_shape": list(self.current_shape),
            "output_shape": list(self.output_shape),
            "adapter_full_bytes": self.adapter_full_bytes,
            "pooled_bytes": self.pooled_bytes,
        }


def _require_contiguous_uint8(tensor: torch.Tensor, numel: int, role: str):
    if (not isinstance(tensor, torch.Tensor) or tensor.device.type != "cuda"
            or tensor.dtype != torch.uint8 or tensor.dim() != 1
            or not tensor.is_contiguous() or tensor.numel() != numel):
        raise ValueError(f"{role} must be contiguous 1-D uint8 CUDA storage of {numel} bytes")
    return tensor


def _assert_disjoint(tensors: Iterable[tuple[torch.Tensor, str]]):
    ranges = []
    for tensor, role in tensors:
        if tensor is None or tensor.numel() == 0:
            continue
        start = tensor.data_ptr()
        end = start + tensor.numel() * tensor.element_size()
        ranges.append((start, end, role))
    ranges.sort()
    for (_, previous_end, previous_role), (start, _, role) in zip(ranges, ranges[1:]):
        if start < previous_end:
            raise ValueError(f"native binding storage overlaps: {previous_role} / {role}")


def validate_packed_low(tensor, *, precision, expected_bytes=None,
                        role="packed low state"):
    """Reject malformed or non-finite packed trunk features before display.

    ``tensor`` is the packed level0 field in its deployed byte representation:
    little-endian IEEE Half for ``fp16`` or E4M3 for ``fp8``.  FP16 bytes are
    reinterpreted as Half and checked with ``isfinite``; FP8 bytes are checked
    against the only two E4M3 NaN codes, ``0x7f`` and ``0xff``.  The byte
    representation is never converted to float first.  The check is
    device-agnostic so CPU fixtures exercise the exact typed path, while
    :func:`validate_low_features` adds the production CUDA binding contract.
    """
    p = resolve_precision(precision)
    if not isinstance(tensor, torch.Tensor):
        raise TypeError(f"{role} must be a packed torch.uint8 tensor, got {type(tensor).__name__}")
    if tensor.dtype != torch.uint8:
        raise TypeError(f"{role} must be packed torch.uint8 bytes, got {tensor.dtype}")
    if tensor.dim() != 1:
        raise ValueError(f"{role} must be a 1-D packed byte tensor, got shape {tuple(tensor.shape)}")
    if not tensor.is_contiguous():
        raise ValueError(f"{role} must be contiguous packed bytes")
    byte_count = int(tensor.numel())
    element = element_bytes(p)
    if byte_count < element or byte_count % element:
        raise ValueError(
            f"{role} has {byte_count} packed bytes, not a whole {p} element sequence")
    if expected_bytes is not None:
        if isinstance(expected_bytes, bool) or not isinstance(expected_bytes, int) or expected_bytes < 1:
            raise ValueError("expected_bytes must be a positive integer")
        if byte_count != expected_bytes:
            raise ValueError(
                f"{role} is {byte_count} packed bytes; the {p} layout requires {expected_bytes}")

    if p == "fp16":
        try:
            # Typed reinterpretation: the stored bytes are the Half values.
            values = tensor.view(torch.float16)
        except RuntimeError as error:
            raise ValueError(f"{role} is not a valid packed fp16 byte sequence: {error}") from error
        nonfinite = ~torch.isfinite(values)
        label = "Half (float16 NaN/Inf)"
    else:
        # E4M3 has exactly two NaN encodings: S.1111.111 -> 0x7f / 0xff.
        nonfinite = (tensor & FP8_E4M3_NAN_MASK) == FP8_E4M3_NAN_MASK
        label = "FP8 E4M3 (NaN codes 0x7f/0xff)"

    count = int(nonfinite.sum().item())
    if count:
        raise ValueError(
            f"{role} contains {count} non-finite {label} values in {byte_count} packed "
            "bytes; this is a diagnostic failure, not a display clamp or output repair")
    return {"precision": p, "bytes": byte_count, "nonfinite": 0,
            "element_bytes": element, "role": role}


def validate_low_features(tensor, *, model, precision, layout, role="b69.output"):
    """Production binding check for the plane16 trunk field before post.

    The standalone :func:`validate_packed_low` is intentionally CPU-callable;
    this wrapper additionally requires the exact contiguous CUDA uint8
    level0 extent that the native post will consume.  It raises with the model,
    precision, level0 layout and non-finite count so a hidden numerical failure
    is never silently clamped to black.
    """
    p = resolve_precision(precision)
    if not isinstance(layout, FrameLayout):
        raise TypeError("layout must be a dlssnr.video.FrameLayout")
    if layout.precision != p:
        raise ValueError(
            f"{model}/{p}: layout precision {layout.precision!r} differs from {p!r}")
    if layout.element_bytes != element_bytes(p):
        raise ValueError(
            f"{model}/{p}: layout element size {layout.element_bytes} differs from "
            f"{element_bytes(p)}")
    try:
        _require_contiguous_uint8(tensor, layout.pooled_bytes, role)
        return validate_packed_low(
            tensor, precision=p, expected_bytes=layout.pooled_bytes, role=role)
    except (TypeError, ValueError) as error:
        message = (
            f"{model}/{p}: {role} at level0 "
            f"{layout.full_width // 2}x{layout.full_height // 2} "
            f"({layout.pooled_bytes} packed bytes): {error}")
        raise type(error)(message) from error


def trunk_final_phase(spec) -> int:
    """Return the generated final-C32 phase and cross-check the model roster.

    The scalar ABI of the final plan call is not exposed to Python, so the
    phase is source-derived: all four generated tables use origin ``(0,-4)``,
    which is phase 3.  Small31 publishes ``phase_for_role(69) == 3``; legacy71
    has no Python phase table and keeps the generated value.
    """
    roles = tuple(getattr(spec, "roles", ()))
    if 69 not in roles:
        raise RuntimeError("model roster does not publish role 69 for the final C32 block")
    try:
        published = spec.phase_for_role(69)
    except (AttributeError, ValueError):
        published = None
    if published is not None and published != TRUNK_FINAL_PHASE:
        raise RuntimeError(
            f"model roster publishes phase {published} for role 69; the generated "
            f"final C32 call requires phase {TRUNK_FINAL_PHASE}")
    if window_shift(TRUNK_FINAL_PHASE) != (0, 4):
        raise RuntimeError("phase 3 no longer maps to the generated final C32 origin")
    return TRUNK_FINAL_PHASE


@dataclass(frozen=True)
class FinalC32Binding:
    """The plan tensors and geometry selected for the RGB final C32 call."""

    plan_final_kernel: str
    output_view_kernel: str
    state: torch.Tensor
    record: torch.Tensor
    output: torch.Tensor
    state_index: int
    record_index: int
    output_index: int
    height: int
    width: int
    phase: int
    origin: tuple[int, int]


def build_rgb_trunk(plan, *, model, precision, layout, low, spec=None,
                    prepare_sequence=prepare_kernels,
                    prepare_view_fp16=prepare_output_view_fp16,
                    prepare_view_fp8=prepare_output_view_fp8,
                    compose=compose_kernels):
    """Compose the RGB trunk: every base-plan descriptor except the last C32 call.

    The final binding is read from the prepared plan metadata
    (``kernel_tensor_indices`` through ``sequence.input_indices`` /
    ``sequence.output_indices`` and ``plan.tensor_arguments`` through
    ``sequence.tensors``); the predecessor and record namespaces are never
    hardcoded, so legacy71 (b68 predecessor) and Small31 (b66 predecessor) use
    their actual plan buffers.  Only the last descriptor is replaced; the same
    b69 allocation and the same physical split counts are reused, and no repack
    kernel or extra allocation is introduced.
    """
    p = resolve_precision(precision)
    if not isinstance(layout, FrameLayout):
        raise TypeError("layout must be a dlssnr.video.FrameLayout")
    if layout.precision != p:
        raise ValueError(f"layout precision {layout.precision!r} differs from {p!r}")
    if layout.element_bytes != element_bytes(p):
        raise ValueError("layout element size differs from the requested precision")
    if not isinstance(low, torch.Tensor):
        raise TypeError("bound b69.output must be a tensor")

    phase = trunk_final_phase(spec) if spec is not None else TRUNK_FINAL_PHASE

    sequence = prepare_sequence(plan)
    split_counts = tuple(int(value) for value in plan.split_launch_counts())
    buffer_count = len(plan.buffer_names())
    if len(sequence.kernels) != len(split_counts):
        raise RuntimeError("prepared call count differs from the base plan")
    if split_counts[-1] != 1:
        raise RuntimeError("the final C32 call is unexpectedly split")

    final = sequence.kernels[-1]
    expected_final = f"{TRUNK_FINAL_ORDINARY}_{p}"
    if final.name != expected_final:
        raise RuntimeError(f"unexpected final trunk kernel: {final.name}")

    last_inputs = tuple(int(index) for index in sequence.input_indices[-1])
    last_outputs = tuple(int(index) for index in sequence.output_indices[-1])
    if len(last_inputs) != 2 or len(last_outputs) != 1:
        raise RuntimeError("final C32 ABI is not state+record -> b69")
    (output_index,) = last_outputs
    tensor_count = len(sequence.tensors)
    if any(index < 0 or index >= tensor_count
           for index in last_inputs + last_outputs):
        raise RuntimeError("final C32 tensor indices are outside the prepared tensor list")
    if output_index >= buffer_count:
        raise RuntimeError("final C32 tensor roles differ from the prepared plan")
    state_indices = [index for index in last_inputs if index < buffer_count]
    record_indices = [index for index in last_inputs if index >= buffer_count]
    if len(state_indices) != 1 or len(record_indices) != 1:
        raise RuntimeError("final C32 tensor roles differ from the prepared plan")
    state_index = state_indices[0]
    record_index = record_indices[0]
    state = sequence.tensors[state_index]
    record = sequence.tensors[record_index]
    output = sequence.tensors[output_index]

    if (output.data_ptr() != low.data_ptr() or output.numel() != low.numel()
            or output.dtype != low.dtype):
        raise RuntimeError("plan's final output is not the bound b69.output")
    if state.numel() != layout.pooled_bytes:
        raise RuntimeError("final C32 state extent is not the level0 field")
    if record.numel() != TRUNK_FINAL_RECORD_BYTES[p]:
        raise RuntimeError("final C32 record extent differs from the C32 ABI")

    height = layout.full_height // 2
    width = layout.full_width // 2
    if (layout.full_height % 2 or layout.full_width % 2 or height < 8 or width < 8
            or height > 8192 or width > 8192 or height % 4 or width % 4):
        raise RuntimeError("level0 extent is not a complete 4-pixel window")
    if height * width * 32 * layout.element_bytes != output.numel():
        raise RuntimeError("b69 extent does not match the level0 plane16 field")

    prepare_view = prepare_view_fp16 if p == "fp16" else prepare_view_fp8
    view = prepare_view(state, record, output, height=height, width=width, phase=phase)
    expected_view = f"{TRUNK_FINAL_OUTPUT_VIEW}_{p}"
    if getattr(view, "name", None) != expected_view:
        raise RuntimeError(
            f"unexpected output-view kernel: {getattr(view, 'name', None)}")

    kernels = tuple(sequence.kernels[:-1]) + (view,)
    trunk = compose(kernels)
    if len(trunk.kernels) != len(kernels) or trunk.kernels[-1] is not view:
        raise RuntimeError("RGB trunk composition did not end at the prepared output view")
    if any(composed is not original
           for composed, original in zip(trunk.kernels[:-1], sequence.kernels[:-1])):
        raise RuntimeError("RGB trunk composition replaced a preceding descriptor")
    if trunk.output_index >= len(trunk.tensors):
        raise RuntimeError("RGB trunk composition has no final output tensor")
    final_output = trunk.tensors[trunk.output_index]
    if (final_output.data_ptr() != low.data_ptr()
            or final_output.numel() != low.numel()):
        raise RuntimeError("RGB trunk composition changed the bound b69.output allocation")

    binding = FinalC32Binding(
        plan_final_kernel=final.name,
        output_view_kernel=view.name,
        state=state,
        record=record,
        output=output,
        state_index=state_index,
        record_index=record_index,
        output_index=output_index,
        height=height,
        width=width,
        phase=phase,
        origin=TRUNK_FINAL_ORIGIN,
    )
    return trunk, binding, sequence



class FramePipeline:
    """One native model/precision chain prepared for stateless RGB frames.

    Preparation owns the weights, the pre/post records, the full adapter and
    pooled buffers, the trunk plan and the valid-size current texture.  Every
    call uploads the current frame, launches pre -> prepared RGB trunk
    (final phase-3 C32 output view) -> post on the current CUDA stream and
    returns the full RGBA surface (crop with :meth:`valid_rgb`).  Frontend CUDA
    arrays are copied per launch by the native host; that device-to-device work
    is part of the full-GPU interval.  The pipeline-level re-entrant lock only
    serializes host-side access to the mutable plan workspace; it does not merge
    or synchronize independent caller streams.
    """

    def __init__(self, *, model: str, precision: str, weights, valid_width: int,
                 valid_height: int, seed: int, device=0):
        model = str(model).strip().lower()
        if model not in MODEL_NAMES:
            raise ValueError(f"unknown model {model!r}; expected one of {MODEL_NAMES}")
        resolve_model(model)  # validates the published identity
        self.model = model
        self.spec = resolve_model(model)
        self.precision = resolve_precision(precision)
        if isinstance(seed, bool) or not isinstance(seed, int) or not 0 <= seed <= 0xFFFFFFFF:
            raise ValueError("noise seed must be a uint32")
        self.seed = seed
        self.device = torch.device("cuda", int(device))
        self.layout = FrameLayout.for_frame(valid_width, valid_height, self.precision)
        self.post_phase = post_phase_for_model(model)
        if model == "legacy71":
            if not isinstance(weights, Checkpoint):
                raise TypeError("legacy71 requires a loaded dlssnr.checkpoint.Checkpoint")
            if self.precision == "fp8" and weights.precision != "fp8":
                raise ValueError("FP8 legacy execution requires the FP8 checkpoint")
        elif not isinstance(weights, SmallNativeCheckpoint):
            raise TypeError("small31 requires dlssnr.small_deployment.SmallNativeCheckpoint")
        self.weights = weights
        # The prepared sequence does not take the plan's LaunchMutex, so the
        # pipeline serializes every use of its mutable plan workspace itself.
        self._launch_lock = threading.RLock()

        started = time.perf_counter()
        with torch.cuda.device(self.device):
            self._prepare()
        self.prepare_seconds = time.perf_counter() - started

    # -- preparation -------------------------------------------------------

    def _record(self, role: int, kind: str):
        return self.weights.kernel_record(
            role, kind=kind, precision=self.precision, device=self.device)

    def _check_small_ops(self):
        if self.model != "small31":
            return
        ops = load_extension(device=self.device)
        required = (
            f"record_names_small31_{self.precision}",
            f"record_bytes_small31_{self.precision}",
            f"create_small_plan_for_resolution_{self.precision}",
        )
        missing = [name for name in required if not hasattr(ops, name)]
        if missing:
            raise RuntimeError(SMALL31_REBUILD_MESSAGE + " Missing: " + ", ".join(missing))

    def _create_plan(self):
        self._check_small_ops()
        create = getattr(self.weights, f"create_plan_{self.precision}")
        try:
            return create(self.pooled, width=self.layout.valid_width,
                          height=self.layout.valid_height)
        except (AttributeError, RuntimeError) as error:
            text = str(error)
            if self.model == "small31" and (
                    "record_names_small31" in text or "record_bytes_small31" in text
                    or "create_small_plan_for_resolution" in text):
                raise RuntimeError(SMALL31_REBUILD_MESSAGE) from error
            raise

    def _prepare(self):
        layout = self.layout
        self.pre_record = self._record(self.spec.pre_role, "preprocess")
        self.post_record = self._record(self.spec.post_role, "postprocess")
        for role, record in ((self.spec.pre_role, self.pre_record),
                             (self.spec.post_role, self.post_record)):
            expected = PREPOST_RECORD_BYTES[(self.precision, role)]
            if record.numel() != expected:
                raise ValueError(
                    f"{self.model} role {role} {self.precision} record is "
                    f"{record.numel()} bytes; the compiled frontend ABI requires {expected}")

        # Packed feature field input (level-zero, 32 lanes) is the plan's input
        # buffer itself; C++ aliases this exact tensor.
        self.pooled = _require_contiguous_uint8(
            torch.empty(layout.pooled_bytes, dtype=torch.uint8, device=self.device),
            layout.pooled_bytes, "pooled trunk input")
        self.adapter_full = _require_contiguous_uint8(
            torch.empty(layout.adapter_full_bytes, dtype=torch.uint8, device=self.device),
            layout.adapter_full_bytes, "adapter_full")
        self.current = torch.empty(layout.current_shape, dtype=torch.float32, device=self.device)
        self.output = torch.empty(layout.output_shape, dtype=torch.float32, device=self.device)
        self.empty_texture = torch.empty(0, dtype=torch.float32, device=self.device)
        self.empty_blend = torch.empty(0, dtype=torch.uint8, device=self.device)

        self.pre_configuration = frontend_configuration(
            PREPROCESS_NAMES[self.precision],
            height=layout.full_height, width=layout.full_width,
            valid_height=layout.valid_height, valid_width=layout.valid_width,
            phase=0, seed=self.seed, device=self.device)
        self.post_configuration = frontend_configuration(
            POSTPROCESS_NAMES[self.precision],
            height=layout.full_height, width=layout.full_width,
            valid_height=layout.valid_height, valid_width=layout.valid_width,
            phase=self.post_phase, seed=0, device=self.device)
        patch_postprocess_display(self.post_configuration)
        assert_postprocess_display(self.post_configuration)

        # Stateless frame: every optional texture and the blend scalar are empty.
        self.pre_inputs = (self.pre_record, self.current, self.empty_texture,
                           self.empty_texture, self.empty_texture, self.empty_texture)
        self.pre_outputs = (self.adapter_full, self.pooled)
        self.pre = prepare_frontend(PREPROCESS_NAMES[self.precision],
                                    self.pre_configuration,
                                    list(self.pre_inputs), list(self.pre_outputs))
        _assert_disjoint(((self.pre_record, "pre_record"), (self.current, "current"),
                          (self.adapter_full, "adapter_full"), (self.pooled, "pooled")))

        self.plan = self._create_plan()
        if self.plan.buffer(self.plan.buffer_names()[0]).data_ptr() != self.pooled.data_ptr():
            raise RuntimeError("native trunk plan did not alias the pooled preprocess output")
        self.low = self.plan.buffer("b69.output")
        _require_contiguous_uint8(self.low, self.layout.pooled_bytes, "b69.output")

        # RGB bridge: reuse every base-plan descriptor except the final C32
        # ordinary producer, which is replaced by the existing phase-3 C32
        # output view on the same b69 allocation.  Preparation never allocates a
        # second field and never launches a repack kernel.
        self.trunk, final_binding, self._plan_sequence = build_rgb_trunk(
            self.plan, model=self.model, precision=self.precision,
            layout=self.layout, low=self.low, spec=self.spec)
        self.trunk_final = final_binding.output_view_kernel
        self._plan_final_kernel = final_binding.plan_final_kernel
        self._trunk_height = final_binding.height
        self._trunk_width = final_binding.width
        self._trunk_phase = final_binding.phase
        self._trunk_logical_calls = len(self.trunk.kernels)
        self._trunk_split_launches = int(sum(self.plan.split_launch_counts()))
        if self._trunk_logical_calls != len(self.plan.split_launch_counts()):
            raise RuntimeError("RGB trunk call census differs from the base plan")
        if (self.trunk.tensors[self.trunk.output_index].data_ptr()
                != self.low.data_ptr()):
            raise RuntimeError("RGB trunk did not retain the plan's b69.output allocation")

        # Post color is the CURRENT frame; history/motion/blend stay empty, so
        # the compositor has no history branch.
        self.post_inputs = (self.low, self.adapter_full, self.post_record, self.current,
                            self.empty_texture, self.empty_texture, self.empty_blend)
        self.post_outputs = (self.output,)
        self.post = prepare_frontend(POSTPROCESS_NAMES[self.precision],
                                     self.post_configuration,
                                     list(self.post_inputs), list(self.post_outputs))
        _assert_disjoint(((self.low, "b69.output"), (self.adapter_full, "adapter_full"),
                          (self.post_record, "post_record"), (self.current, "current"),
                          (self.output, "output")))

    # -- execution ---------------------------------------------------------

    def prepare_frame(self, frame) -> np.ndarray:
        """Validate/convert one decoded frame to contiguous RGBA float32."""
        return as_rgba_float32(frame, self.layout)

    def upload(self, frame) -> np.ndarray:
        """Copy a decoded frame into the valid-size current texture tensor."""
        rgba = self.prepare_frame(frame)
        with torch.cuda.device(self.device):
            self.current.copy_(torch.from_numpy(rgba))
        return rgba

    def validate_low(self) -> dict:
        """Validate the packed plane16 b69 field before the display post.

        This is a typed byte-level check: FP16 bytes are reinterpreted as Half
        and FP8 uses the E4M3 NaN encodings.  It performs one host read of the
        device field, so callers must keep it outside CUDA graph capture and
        timed intervals; a non-finite field is reported, never repaired.
        """
        return validate_low_features(
            self.low, model=self.model, precision=self.precision, layout=self.layout)

    def run(self, frame=None, *, validate=True):
        """Upload ``frame`` (if given) then launch pre -> RGB trunk -> post.

        The calls are ordered on the caller's current stream.  ``_launch_lock``
        serializes pipeline calls that share the mutable plan workspace; it does
        not synchronize GPU work across independent CUDA streams.  ``validate``
        runs the typed packed-low check between the RGB trunk and the post, so a
        hidden non-finite FP16/FP8 field fails before display clamping.  Disable
        it only after a successful preflight, for CUDA graph capture or timed
        intervals.
        """
        if not isinstance(validate, bool):
            raise TypeError("validate must be a boolean")
        with self._launch_lock:
            with torch.cuda.device(self.device):
                if frame is not None:
                    self.upload(frame)
                self.pre(list(self.pre_inputs), list(self.pre_outputs))
                self.trunk.run_cpp()
                if validate:
                    self.validate_low()
                self.post(list(self.post_inputs), list(self.post_outputs))
        return self.output

    def run_trunk(self, *, validate=True):
        """Run only the prepared RGB trunk (plane16 b69) on the current pooled field.

        This is the trunk-timing entry point: it deliberately skips preprocess
        and post.  Preparation keeps ``pooled`` filled from a previous validated
        ``run``.  ``validate`` applies the same typed packed-low check as
        :meth:`run`; benchmark loops disable it after their preflight so the
        host read stays outside the timed interval.  The lock covers this
        standalone call for the same reason as :meth:`run`.
        """
        if not isinstance(validate, bool):
            raise TypeError("validate must be a boolean")
        with self._launch_lock, torch.cuda.device(self.device):
            self.trunk.run_cpp()
            if validate:
                self.validate_low()
        return self.low

    def valid_rgba(self) -> torch.Tensor:
        """Return the valid-size RGBA view of the last output (no copy)."""
        return self.output[:self.layout.valid_height, :self.layout.valid_width, :]

    def valid_rgb(self) -> torch.Tensor:
        """Return the valid-size three-channel RGB view (crop padding columns/rows)."""
        return self.output[:self.layout.valid_height, :self.layout.valid_width, :3]

    def download_rgb(self) -> np.ndarray:
        """Synchronously download the valid RGB crop as float32 ``[H,W,3]``."""
        return np.ascontiguousarray(self.valid_rgb().detach().cpu().numpy())

    def render_rgb_u8(self, frame=None) -> np.ndarray:
        """Run one frame and return the valid RGB crop quantized for display."""
        self.run(frame)
        return rgb_to_uint8(self.download_rgb())

    def describe(self) -> dict:
        split = [int(value) for value in self.plan.split_launch_counts()]
        buffers = list(self.plan.buffer_names())
        return {
            "model": self.model,
            "display_name": self.spec.display_name,
            "runtime_version": self.spec.runtime_version,
            "precision": self.precision,
            "noise_seed": self.seed,
            "post_phase": self.post_phase,
            "post_phase_source": "model_specs.post_phase_default",
            "post_phase_note": (
                "legacy71 uses graph_schedule phase 1; small31 uses the model-spec "
                "phase 0 (source-derived host choice, not verified against DLL dispatch)"),
            "layout": self.layout.as_dict(),
            "preprocess": PREPROCESS_NAMES[self.precision],
            "postprocess": POSTPROCESS_NAMES[self.precision],
            "pre_record_bytes": int(self.pre_record.numel()),
            "post_record_bytes": int(self.post_record.numel()),
            "plan_buffers": len(buffers),
            "plan_split_launch_counts": split,
            "plan_logical_calls": len(split),
            "plan_split_launches": int(sum(split)),
            "plan_final_kernel": self._plan_final_kernel,
            "plan_run_output_layout": PLAN_RUN_OUTPUT_LAYOUT,
            "plan_run_is_diagnostic": True,
            "trunk_final_kernel": self.trunk_final,
            "trunk_output_layout": TRUNK_OUTPUT_LAYOUT,
            "trunk_final_geometry": {
                "height": self._trunk_height,
                "width": self._trunk_width,
                "phase": self._trunk_phase,
                "origin": list(TRUNK_FINAL_ORIGIN),
                "grid": [
                    (self._trunk_width + 7) // 8,
                    (self._trunk_height + 4 + 7) // 8,
                    1,
                ],
            },
            "trunk_final_phase_source": TRUNK_FINAL_PHASE_SOURCE,
            "trunk_logical_calls": self._trunk_logical_calls,
            "trunk_split_launches": self._trunk_split_launches,
            "trunk_extra_repack": False,
            "trunk_launch_census_matches_plan": (
                self._trunk_logical_calls == len(split)
                and self._trunk_split_launches == int(sum(split))),
            "display_abi": {
                "output_scale": POST_OUTPUT_SCALE,
                "display_output": POST_DISPLAY_OUTPUT,
                "output_scale_offset": POST_OUTPUT_SCALE_OFFSET,
                "display_output_offset": POST_DISPLAY_OUTPUT_OFFSET,
            },
            "stateless": True,
            "history": "empty",
            "motion": "empty",
            "depth": "empty",
            "conditioning": "empty",
            "blend": "empty",
            "prepare_seconds": self.prepare_seconds,
        }


# -- frame decoding / conversion --------------------------------------------


def _pillow():
    try:
        from PIL import Image, ImageDraw, ImageFont
    except ImportError as error:  # pragma: no cover - environment guard
        raise RuntimeError(
            "PNG frame handling requires Pillow (pip install Pillow); "
            "the native chain itself has no imaging dependency") from error
    return Image, ImageDraw, ImageFont


def decode_rgb_image(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode an 8-bit PNG/JPEG to ``uint8 [H,W,3]`` exactly once.

    The image is display-referred coded RGB; the only conversion is the codec
    decode plus an optional RGB conversion for palette/RGBA/grayscale inputs.
    There is no resize, no model-input crop, no EOTF/OETF and no filtering.
    """
    Image, _, _ = _pillow()
    path = Path(path)
    if path.suffix.lower() not in IMAGE_SUFFIXES:
        raise ValueError(
            f"unsupported image {path.suffix!r}; expected one of {IMAGE_SUFFIXES}")
    with Image.open(path) as image:
        if image.mode != "RGB":
            image = image.convert("RGB")
        rgb = np.asarray(image, dtype=np.uint8)
    if rgb.ndim != 3 or rgb.shape[2] != 3:
        raise ValueError(f"{path} did not decode to RGB")
    if expected_width is not None and rgb.shape[1] != expected_width:
        raise ValueError(f"{path} width {rgb.shape[1]} != expected {expected_width}")
    if expected_height is not None and rgb.shape[0] != expected_height:
        raise ValueError(f"{path} height {rgb.shape[0]} != expected {expected_height}")
    return np.ascontiguousarray(rgb)


def decode_rgb_png(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode an 8-bit RGB PNG to ``uint8 [H,W,3]`` (no transfer-function work).

    Kept as the explicit PNG entry point used by the frame/video path; see
    :func:`decode_rgb_image` for the still-image JPEG/PNG entry point.
    """
    path = Path(path)
    if path.suffix.lower() != ".png":
        raise ValueError(f"decode_rgb_png requires a .png path, got {path.suffix!r}")
    return decode_rgb_image(path, expected_width=expected_width,
                            expected_height=expected_height)


def save_rgb_png(rgb: np.ndarray, path):
    """Write an 8-bit RGB PNG; the caller passes display-coded values."""
    Image, _, _ = _pillow()
    rgb = np.asarray(rgb)
    if rgb.dtype != np.uint8 or rgb.ndim != 3 or rgb.shape[2] != 3:
        raise ValueError("save_rgb_png requires uint8 [H,W,3]")
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    Image.fromarray(np.ascontiguousarray(rgb)).save(path, format="PNG")
    return path


def rgb_to_rgba(rgb: np.ndarray) -> np.ndarray:
    """RGB24 uint8 -> RGBA float32 in [0,1] with alpha 1 (no EOTF)."""
    rgb = np.asarray(rgb)
    if rgb.dtype != np.uint8 or rgb.ndim != 3 or rgb.shape[2] != 3:
        raise ValueError("rgb_to_rgba requires uint8 [H,W,3]")
    rgba = np.empty((rgb.shape[0], rgb.shape[1], 4), dtype=np.float32)
    rgba[:, :, :3] = rgb.astype(np.float32) / np.float32(255.0)
    rgba[:, :, 3] = 1.0
    return rgba


def load_frame_rgba(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode a PNG frame and return valid-size RGBA float32 coded RGB."""
    return rgb_to_rgba(decode_rgb_png(path, expected_width=expected_width,
                                      expected_height=expected_height))


def load_image_rgba(path, *, expected_width=None, expected_height=None) -> np.ndarray:
    """Decode a PNG/JPEG still and return full-size RGBA float32 coded RGB."""
    return rgb_to_rgba(decode_rgb_image(path, expected_width=expected_width,
                                        expected_height=expected_height))


def as_rgba_float32(frame, layout: FrameLayout) -> np.ndarray:
    """Validate a decoded frame against the layout and return contiguous RGBA."""
    array = np.asarray(frame)
    if array.ndim != 3 or array.shape[2] not in (3, 4):
        raise ValueError("frame must be HxWx3 or HxWx4")
    if array.shape[0] != layout.valid_height or array.shape[1] != layout.valid_width:
        raise ValueError(
            f"frame is {array.shape[1]}x{array.shape[0]}; expected "
            f"{layout.valid_width}x{layout.valid_height} (valid extents, not physical)")
    if array.dtype == np.uint8:
        rgba = np.empty(layout.current_shape, dtype=np.float32)
        rgba[:, :, :3] = array[:, :, :3].astype(np.float32) / np.float32(255.0)
        rgba[:, :, 3] = 1.0 if array.shape[2] == 3 else array[:, :, 3].astype(np.float32) / np.float32(255.0)
        return np.ascontiguousarray(rgba)
    if array.dtype != np.float32:
        raise TypeError("frame must be uint8 or float32")
    rgba = np.empty(layout.current_shape, dtype=np.float32)
    rgba[:, :, :3] = array[:, :, :3]
    rgba[:, :, 3] = 1.0 if array.shape[2] == 3 else array[:, :, 3]
    if not np.isfinite(rgba).all():
        raise ValueError("frame contains non-finite values")
    return np.ascontiguousarray(rgba)


def rgb_to_uint8(rgb) -> np.ndarray:
    """Quantize float RGB in [0,1] to display-coded RGB24 (round, clamp)."""
    array = np.asarray(rgb)
    if array.ndim != 3 or array.shape[2] not in (3, 4):
        raise ValueError("rgb_to_uint8 requires HxWx3 or HxWx4")
    array = array[:, :, :3]
    return np.clip(np.rint(array.astype(np.float32) * np.float32(255.0)), 0, 255).astype(np.uint8)


def validate_rgba_output(rgba: np.ndarray, *, alpha_one: bool = True) -> dict:
    """Validate a native RGBA float32 surface and return descriptive evidence."""
    array = np.asarray(rgba)
    if array.dtype != np.float32 or array.ndim != 3 or array.shape[2] != 4:
        raise ValueError("native output must be float32 HxWx4")
    if not np.isfinite(array).all():
        raise ValueError("native output contains non-finite values")
    low, high = float(array[..., :3].min()), float(array[..., :3].max())
    if low < 0.0 or high > 1.0:
        raise ValueError(f"native RGB is outside [0,1]: min={low}, max={high}")
    alpha_min, alpha_max = float(array[..., 3].min()), float(array[..., 3].max())
    if alpha_one and (alpha_min != 1.0 or alpha_max != 1.0):
        raise ValueError(f"native alpha is not 1: [{alpha_min}, {alpha_max}]")
    return {"shape": list(array.shape), "rgb_min": low, "rgb_max": high,
            "alpha_min": alpha_min, "alpha_max": alpha_max,
            "sha256": sha256_array(array)}


# -- hashing ----------------------------------------------------------------


def sha256_bytes(data) -> str:
    return hashlib.sha256(bytes(data)).hexdigest()


def sha256_array(array: np.ndarray) -> str:
    return sha256_bytes(np.ascontiguousarray(array).tobytes())


def sha256_file(path, chunk=1 << 20) -> str:
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for block in iter(lambda: handle.read(chunk), b""):
            digest.update(block)
    return digest.hexdigest()


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat()


# -- three-way panel --------------------------------------------------------

PANEL_WIDTH = 1024
PANEL_HEIGHT = 600
PANEL_DISPLAY_WIDTH = 1280
PANEL_HEADER_HEIGHT = 46
PANEL_FOOTER_HEIGHT = 34
PANEL_GAP = 8
PANEL_TOTAL_WIDTH = PANEL_WIDTH * 3 + PANEL_GAP * 2
PANEL_TOTAL_HEIGHT = PANEL_HEADER_HEIGHT + PANEL_HEIGHT + PANEL_FOOTER_HEIGHT
PANEL_FILTER_NAME = "LANCZOS"
PANEL_FILTER_DESCRIPTION = "Pillow Image.Resampling.LANCZOS"

DEFAULT_FOOTER = (
    "RGB-only stateless mode: empty history/motion/depth/conditioning/blend; "
    "fixed session noise seed; coded RGB [0,1], no EOTF. Original panel is the "
    "unchanged decoded frame. No quality or vendor-parity claim.")


def _positive_int(value, role: str) -> int:
    if isinstance(value, bool) or not isinstance(value, int) or value < 1:
        raise ValueError(f"{role} must be a positive integer, got {value!r}")
    return value


def _aspect_ratio_text(width: int, height: int) -> str:
    divisor = math.gcd(int(width), int(height))
    return f"{width // divisor}:{height // divisor}"


def display_panel_geometry(source_width: int, source_height: int,
                           panel_width: int = PANEL_DISPLAY_WIDTH, *,
                           header_height: int = PANEL_HEADER_HEIGHT,
                           footer_height: int = PANEL_FOOTER_HEIGHT,
                           gap: int = PANEL_GAP,
                           allow_upscale: bool = False) -> dict:
    """Describe the display-only three-way panel for one source geometry.

    ``source_width``/``source_height`` are the decoded source (native model
    input) dimensions.  ``panel_width`` is the requested display width of ONE
    panel; the other two panels are identical.  Scaling is aspect-preserving and
    downscale-only unless ``allow_upscale`` is explicitly requested.  The native
    model input and the per-arm original/legacy71/small31 artifacts are never
    resized by this description.
    """
    source_width = _positive_int(source_width, "source width")
    source_height = _positive_int(source_height, "source height")
    panel_width = _positive_int(panel_width, "panel width")
    header_height = _positive_int(header_height, "panel header height")
    footer_height = _positive_int(footer_height, "panel footer height")
    gap = _positive_int(gap, "panel gap")
    if not isinstance(allow_upscale, bool):
        raise TypeError("allow_upscale must be a boolean")

    effective_width = panel_width if (allow_upscale or panel_width <= source_width) else source_width
    # Preserve the source aspect ratio exactly at the chosen width.  The panel
    # height is the single rounded dimension; no independent x/y scaling is
    # performed anywhere in the composer.
    panel_height = max(1, int(round(source_height * effective_width / source_width)))
    total_width = effective_width * 3 + gap * 2
    total_height = header_height + panel_height + footer_height
    scale = effective_width / source_width
    return {
        "source": {
            "width": source_width,
            "height": source_height,
            "aspect_ratio": _aspect_ratio_text(source_width, source_height),
            "aspect_decimal": source_width / source_height,
        },
        "native_arm_output": {
            "width": source_width,
            "height": source_height,
            "resize": False,
            "note": "original/legacy71/small31 PNGs and videos keep the decoded source extent",
        },
        "panel": {
            "width": effective_width,
            "height": panel_height,
            "requested_width": panel_width,
            "aspect_ratio": _aspect_ratio_text(effective_width, panel_height),
            "aspect_decimal": effective_width / panel_height,
            "downscaled": effective_width < source_width,
            "upscaled": effective_width > source_width,
            "scale": scale,
        },
        "layout": {
            "header_height": header_height,
            "footer_height": footer_height,
            "gap": gap,
            "total_width": total_width,
            "total_height": total_height,
        },
        "output_dimensions": {"width": total_width, "height": total_height},
        "filter": PANEL_FILTER_DESCRIPTION,
        "filter_name": PANEL_FILTER_NAME,
        "allow_upscale": allow_upscale,
        "display_only": True,
        "inference_resize": False,
        "model_input_resize": False,
        "source_pixels_unchanged": True,
    }


def panel_regions(width: int = PANEL_WIDTH, height: int = PANEL_HEIGHT, *,
                  header_height: int = PANEL_HEADER_HEIGHT,
                  gap: int = PANEL_GAP) -> tuple[dict, ...]:
    """Pixel regions of the three equal ``width`` by ``height`` display panels."""
    width = _positive_int(width, "panel width")
    height = _positive_int(height, "panel height")
    header_height = _positive_int(header_height, "panel header height")
    gap = _positive_int(gap, "panel gap")
    return tuple({
        "name": name,
        "x0": index * (width + gap),
        "y0": header_height,
        "x1": index * (width + gap) + width,
        "y1": header_height + height,
    } for index, name in enumerate(("original", "legacy71", "small31")))


def _pillow_lanczos():
    _, _, _ = _pillow()
    from PIL import Image
    resampling = getattr(Image, "Resampling", None)
    return resampling.LANCZOS if resampling is not None else Image.LANCZOS


def resize_rgb_for_display(rgb: np.ndarray, width: int, height: int) -> np.ndarray:
    """Resize one display panel with LANCZOS (aspect handled by the caller)."""
    Image, _, _ = _pillow()
    array = np.asarray(rgb)
    if array.dtype != np.uint8 or array.ndim != 3 or array.shape[2] != 3:
        raise ValueError("display resize requires uint8 [H,W,3]")
    width = _positive_int(width, "display width")
    height = _positive_int(height, "display height")
    if array.shape[:2] == (height, width):
        return np.ascontiguousarray(array)
    resized = Image.fromarray(np.ascontiguousarray(array)).resize(
        (width, height), _pillow_lanczos())
    return np.asarray(resized, dtype=np.uint8)


def _panel_font(size: int):
    _, _, ImageFont = _pillow()
    for name in ("seguisb.ttf", "arial.ttf", "DejaVuSans.ttf"):
        try:
            return ImageFont.truetype(name, size)
        except OSError:
            continue
    try:
        return ImageFont.load_default(size=size)
    except TypeError:  # pragma: no cover - old Pillow
        return ImageFont.load_default()


def compose_comparison_panel(original_rgb, legacy_rgb, small_rgb, *, captions=None,
                             footer=DEFAULT_FOOTER,
                             panel_width: int = PANEL_DISPLAY_WIDTH,
                             allow_upscale: bool = False,
                             header_height: int = PANEL_HEADER_HEIGHT,
                             footer_height: int = PANEL_FOOTER_HEIGHT,
                             gap: int = PANEL_GAP) -> np.ndarray:
    """Compose three equal RGB frames as an explicitly display-scaled panel.

    Any equal ``HxWx3`` uint8 inputs are accepted.  The source extent determines
    the aspect ratio; each panel is rendered at the requested display width
    (downscale-only by default, so an explicit width larger than the source is
    clamped rather than upscaled).  The three display panels, headers, gaps and
    footer are derived from the actual geometry.  Inputs are never modified and
    no per-arm artifact is resized by this function.
    """
    Image, ImageDraw, _ = _pillow()
    panels = [np.asarray(value) for value in (original_rgb, legacy_rgb, small_rgb)]
    shapes = [panel.shape[:2] for panel in panels]
    for name, panel in zip(("original", "legacy71", "small31"), panels):
        if panel.dtype != np.uint8 or panel.ndim != 3 or panel.shape[2] != 3:
            raise ValueError(f"{name} panel must be uint8 [H,W,3]")
        if panel.shape[0] < 1 or panel.shape[1] < 1:
            raise ValueError(f"{name} panel is empty")
    if any(shape != shapes[0] for shape in shapes):
        raise ValueError(
            "three-way panels must share one size (no individual upscale), got "
            f"{[(width, height) for height, width in shapes]}")
    source_height, source_width = shapes[0]
    geometry = display_panel_geometry(
        source_width, source_height, panel_width, header_height=header_height,
        footer_height=footer_height, gap=gap, allow_upscale=allow_upscale)
    panel_size = (geometry["panel"]["width"], geometry["panel"]["height"])
    layout = geometry["layout"]
    captions = dict(captions or {})
    header_font = _panel_font(17)
    footer_font = _panel_font(14)
    canvas = Image.new("RGB", (layout["total_width"], layout["total_height"]), (0, 0, 0))
    display_panels = [resize_rgb_for_display(panel, *panel_size) for panel in panels]
    regions = panel_regions(panel_size[0], panel_size[1], header_height=header_height,
                            gap=gap)
    for region, panel in zip(regions, display_panels):
        canvas.paste(Image.fromarray(np.ascontiguousarray(panel)),
                     (region["x0"], region["y0"]))
    draw = ImageDraw.Draw(canvas)
    for region, key in zip(regions, ("original", "legacy71", "small31")):
        text = str(captions.get(key, key.upper()))
        draw.text((region["x0"] + 6, 6), text, fill=(235, 235, 235), font=header_font)
    draw.text((6, header_height + panel_size[1] + 8), str(footer),
              fill=(190, 190, 190), font=footer_font)
    return np.asarray(canvas, dtype=np.uint8)


def compose_full_resolution_panel(original_rgb, legacy_rgb, small_rgb, *, captions=None,
                                  footer=DEFAULT_FOOTER, header_height=PANEL_HEADER_HEIGHT,
                                  footer_height=PANEL_FOOTER_HEIGHT,
                                  gap=PANEL_GAP) -> np.ndarray:
    """Compose three unchanged full-resolution RGB images side by side.

    Unlike :func:`compose_comparison_panel`, this entry point does not require a
    1024x600 frame: each input is pasted at its own native size with no resize.
    Labels are drawn horizontally above each panel.  The returned image is
    ``header + max(height) + (footer if footer else 0)`` tall.
    """
    Image, ImageDraw, _ = _pillow()
    panels = [np.asarray(value) for value in (original_rgb, legacy_rgb, small_rgb)]
    shapes = [panel.shape[:2] for panel in panels]
    for name, panel in zip(("original", "legacy71", "small31"), panels):
        if panel.dtype != np.uint8 or panel.ndim != 3 or panel.shape[2] != 3:
            raise ValueError(f"{name} panel must be uint8 [H,W,3]")
        if panel.shape[0] < 1 or panel.shape[1] < 1:
            raise ValueError(f"{name} panel is empty")
    height = max(shape[0] for shape in shapes)
    width = max(shape[1] for shape in shapes)
    if any(shape != (height, width) for shape in shapes):
        raise ValueError(
            f"three-way panels must share one size, got {[(w, h) for h, w in shapes]}")
    captions = dict(captions or {})
    header_height = int(header_height)
    gap = int(gap)
    footer_height = int(footer_height) if footer else 0
    total_width = width * 3 + gap * 2
    total_height = header_height + height + footer_height
    canvas = Image.new("RGB", (total_width, total_height), (0, 0, 0))
    regions = []
    for index, panel in enumerate(panels):
        x0 = index * (width + gap)
        regions.append((x0, header_height, x0 + width, header_height + height))
        canvas.paste(Image.fromarray(np.ascontiguousarray(panel)), (x0, header_height))
    draw = ImageDraw.Draw(canvas)
    header_font = _panel_font(max(12, min(24, header_height - 22)))
    for (x0, _, _, _), key in zip(regions, ("original", "legacy71", "small31")):
        draw.text((x0 + 6, 6), str(captions.get(key, key.upper())),
                  fill=(235, 235, 235), font=header_font)
    if footer:
        footer_font = _panel_font(14)
        draw.text((6, header_height + height + 8), str(footer),
                  fill=(190, 190, 190), font=footer_font)
    return np.asarray(canvas, dtype=np.uint8)


def validate_roi(roi, width: int, height: int) -> tuple[int, int, int, int] | None:
    """Validate an explicit ``(x, y, width, height)`` ROI in source pixels."""
    if roi is None:
        return None
    values = tuple(roi)
    if len(values) != 4:
        raise ValueError("ROI must be exactly x y width height")
    if any(isinstance(value, bool) or not isinstance(value, int) for value in values):
        raise TypeError("ROI values must be integers")
    x, y, w, h = values
    if x < 0 or y < 0 or w < 1 or h < 1:
        raise ValueError("ROI requires x,y >= 0 and width,height >= 1")
    if x + w > width or y + h > height:
        raise ValueError(
            f"ROI {values} is outside the {width}x{height} decoded source image")
    return values


def crop_rgb(rgb: np.ndarray, roi) -> np.ndarray:
    """Crop one RGB/RGBA image with an already validated ROI (same coordinates)."""
    array = np.asarray(rgb)
    if array.ndim != 3 or array.shape[2] not in (3, 4):
        raise ValueError("crop_rgb requires HxWx3 or HxWx4")
    x, y, w, h = validate_roi(roi, array.shape[1], array.shape[0])
    return np.ascontiguousarray(array[y:y + h, x:x + w])


def crop_same_roi(images: Sequence[np.ndarray], roi) -> dict:
    """Crop three same-sized native arms with one source-pixel ROI.

    The coordinates are validated against the shared decoded source extent and
    applied verbatim to every arm.  This is a separate analysis artifact only:
    the ROI is never used as a model-input crop and the cropped arms are never
    rescaled here.
    """
    arrays = [np.asarray(image) for image in images]
    if len(arrays) != 3:
        raise ValueError("ROI crop requires exactly three RGB arms")
    names = ("original", "legacy71", "small31")
    for name, array in zip(names, arrays):
        if array.ndim != 3 or array.shape[2] not in (3, 4):
            raise ValueError(f"{name} arm must be HxWx3 or HxWx4")
    shapes = [array.shape[:2] for array in arrays]
    if any(shape != shapes[0] for shape in shapes):
        raise ValueError(
            f"ROI arms must share one size, got {[(w, h) for h, w in shapes]}")
    height, width = shapes[0]
    x, y, w, h = validate_roi(roi, width, height)
    return {
        name: np.ascontiguousarray(array[y:y + h, x:x + w])
        for name, array in zip(names, arrays)
    }


def comparison_captions(model_descriptions: Sequence[dict], *, width=None,
                        height=None) -> dict:
    """Exact version/model/precision headers for the three-way panel."""
    by_model = {item["model"]: item for item in model_descriptions}
    legacy = by_model.get("legacy71", {})
    small = by_model.get("small31", {})
    dimensions = f"{width}x{height} " if width and height else ""
    return {
        "original": f"ORIGINAL - decoded {dimensions}source frame (unchanged)",
        "legacy71": (
            f"LEGACY71 - {legacy.get('runtime_version', '310.8/310.9.16')} - "
            f"{str(legacy.get('precision', '?')).upper()} - post phase "
            f"{legacy.get('post_phase', 1)}"),
        "small31": (
            f"SMALL31 - {small.get('runtime_version', '310.9.16')} - "
            f"{str(small.get('precision', '?')).upper()} - post phase "
            f"{small.get('post_phase', 0)}"),
    }


# -- ffmpeg commands (argv lists, never shell strings) ----------------------


def encode_png_sequence_command(ffmpeg, pattern, fps, output, *, crf=16,
                                preset="medium") -> list[str]:
    """Build a lossless-input H.264 encode of a numbered PNG sequence.

    No scale filter is inserted: the panels/streams keep their native pixel
    dimensions.  Audio is disabled.  The result is an argv list, so paths with
    spaces, quotes or parentheses need no shell escaping.
    """
    if not isinstance(fps, (int, float)) or isinstance(fps, bool) or not 0 < fps <= 240:
        raise ValueError("fps must be a positive number <= 240")
    if not isinstance(crf, int) or isinstance(crf, bool) or not 0 <= crf <= 51:
        raise ValueError("crf must be an integer 0..51")
    return [
        str(ffmpeg), "-hide_banner", "-loglevel", "error", "-y",
        "-framerate", fps_text(fps), "-start_number", "0", "-i", str(pattern),
        "-an", "-c:v", "libx264", "-preset", str(preset), "-crf", str(crf),
        "-pix_fmt", "yuv420p", "-movflags", "+faststart", str(output),
    ]


def decode_video_frames_command(ffmpeg, input_video, output_pattern) -> list[str]:
    """Build the passthrough frame extraction used for ``--input-video``.

    ``-fps_mode passthrough`` keeps one output per decoded source frame; there
    is no ``fps`` filter, duplication, drop or interpolation.
    """
    return [
        str(ffmpeg), "-hide_banner", "-loglevel", "error", "-y",
        "-i", str(input_video), "-map", "0:v:0", "-an",
        "-fps_mode", "passthrough", "-start_number", "0", str(output_pattern),
    ]


def fps_text(fps) -> str:
    if isinstance(fps, int) or float(fps).is_integer():
        return str(int(fps))
    return f"{float(fps):.6g}"


def run_command(argv: Sequence[str], *, cwd=None) -> subprocess.CompletedProcess:
    """Run an argv list with no shell, inheriting stdio; raise on failure.

    Stdio is inherited deliberately: the harness may run under a sandbox that
    denies cross-process pipes.  The exact argv is recorded in the manifest, so
    missing output is never hidden from the reproduction record.
    """
    try:
        return subprocess.run([str(value) for value in argv], cwd=cwd, check=True)
    except subprocess.CalledProcessError as error:
        raise RuntimeError(
            f"command failed with exit code {error.returncode}: {argv[0]}") from error


def ffmpeg_version(ffmpeg) -> str | None:
    try:
        result = subprocess.run([str(ffmpeg), "-version"], check=True,
                                capture_output=True, text=True, timeout=30)
    except (OSError, subprocess.SubprocessError):
        return None
    first = result.stdout.splitlines()[0] if result.stdout else ""
    return first.strip() or None


# -- timing -----------------------------------------------------------------


def summarize_timings(samples_ms: Sequence[float], *, scope: str, warmup: int = 0) -> dict:
    """Return honest per-scope statistics; never merge GPU and CPU intervals."""
    values = np.asarray(list(samples_ms), dtype=np.float64)
    if values.size == 0:
        raise ValueError("no timing samples")
    if not np.isfinite(values).all() or (values < 0).any():
        raise ValueError("timing samples must be finite and non-negative")
    median = float(np.median(values))
    p10, p90 = (float(value) for value in np.percentile(values, (10, 90)))
    return {
        "scope": scope,
        "unit": "ms",
        "warmup": int(warmup),
        "iterations": int(values.size),
        "median_ms": median,
        "p10_ms": p10,
        "p90_ms": p90,
        "mean_ms": float(values.mean()),
        "min_ms": float(values.min()),
        "max_ms": float(values.max()),
        "fps_from_median": (1000.0 / median) if median > 0 else None,
        "samples_ms": [float(value) for value in values],
    }


def timed_cuda(fn, *, warmup: int, iterations: int, stream=None) -> list[float]:
    """Measure ``fn`` with CUDA events, one synchronized interval per call."""
    if warmup < 10 or iterations < 50:
        raise ValueError("benchmark protocol requires warmup>=10 and iterations>=50")
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()
    samples = []
    for _ in range(iterations):
        begin = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)
        begin.record(stream)
        fn()
        end.record(stream)
        end.synchronize()
        samples.append(float(begin.elapsed_time(end)))
    return samples


def timed_cpu(fn, *, warmup: int, iterations: int) -> list[float]:
    """Measure a synchronous host interval (all GPU boundaries synchronized)."""
    if warmup < 10 or iterations < 50:
        raise ValueError("benchmark protocol requires warmup>=10 and iterations>=50")
    for _ in range(warmup):
        fn()
    samples = []
    for _ in range(iterations):
        torch.cuda.synchronize()
        began = time.perf_counter()
        fn()
        torch.cuda.synchronize()
        samples.append((time.perf_counter() - began) * 1000.0)
    return samples


# -- environment / provenance ----------------------------------------------


def gpu_environment(device=0) -> dict:
    info = {
        "torch": torch.__version__,
        "torch_cuda": torch.version.cuda,
        "cuda_available": bool(torch.cuda.is_available()),
        "device_index": int(device),
    }
    if not torch.cuda.is_available():
        return info
    capability = torch.cuda.get_device_capability(device)
    info.update({
        "device_name": torch.cuda.get_device_name(device),
        "capability": f"sm_{capability[0]}{capability[1]}",
        "capability_tuple": [int(capability[0]), int(capability[1])],
        "total_memory_bytes": int(torch.cuda.get_device_properties(device).total_memory),
        "cuda_runtime": torch.version.cuda,
    })
    return info


def nvidia_smi_snapshot() -> dict:
    """Best-effort clock/power snapshot; absence is not an error."""
    query = "name,clocks.sm,clocks.mem,temperature.gpu,power.draw,pstate"
    try:
        result = subprocess.run(
            ["nvidia-smi", f"--query-gpu={query}", "--format=csv,noheader,nounits"],
            check=True, capture_output=True, text=True, timeout=15)
    except (OSError, subprocess.SubprocessError) as error:
        return {"available": False, "error": type(error).__name__}
    rows = [line.strip() for line in result.stdout.splitlines() if line.strip()]
    return {"available": True, "query": query, "rows": rows}


def plan_table_hashes(repository_root=None) -> dict:
    root = Path(repository_root) if repository_root else Path(__file__).resolve().parents[1]
    names = (
        "plan_generated.inl", "plan_fp16_generated.inl",
        "plan_geometry_generated.inl", "plan_geometry_fp16_generated.inl",
        "small_plan_generated.inl", "small_plan_fp16_generated.inl",
        "small_plan_geometry_generated.inl", "small_plan_geometry_fp16_generated.inl",
    )
    result = {}
    for name in names:
        path = root / "csrc/kernel_launcher" / name
        result[name] = sha256_file(path) if path.is_file() else None
    return result


def _first_present(container: dict, *keys):
    for key in keys:
        value = container.get(key)
        if value is not None:
            return value
    return None


def load_source_metadata(path=None, *, input_path=None) -> dict:
    """Read optional generic source metadata; never invent credits or a license.

    ``path`` is an explicit metadata JSON file.  When it is omitted and
    ``input_path`` is given, a sibling ``source.json`` is used if present.
    Two supplied schemas are preserved:

    * a flat ``{"source": {...}}`` document (legacy media step), whose known
      fields are surfaced directly;
    * an official nested document (``official_sources``, ``rights``, ``image``,
      ``clip``, ...), whose sections are copied verbatim.

    In both cases the whole supplied document is retained under ``"document"``.
    A missing document is reported as unavailable; no license, endorsement or
    attribution is made up.
    """
    candidate = Path(path) if path is not None else None
    if candidate is None and input_path is not None:
        candidate = Path(input_path).with_name("source.json")
    if candidate is None or not candidate.is_file():
        return {
            "path": str(candidate) if candidate is not None else None,
            "available": False,
            "notice": (
                "No source metadata supplied. Pass --source-metadata to record "
                "credits, copyright, license and a source URL; nothing is inferred."),
        }
    data = json.loads(candidate.read_text(encoding="utf-8"))
    attribution = {
        "path": str(candidate),
        "available": True,
        "sha256": sha256_file(candidate),
        "document": data,
    }
    source = data.get("source")
    field_map = {
        "title": ("title",),
        "artist": ("artist", "creator", "author"),
        "copyright": ("copyright", "copyright_notice"),
        "license": ("license",),
        "license_url": ("license_url",),
        "page_url": ("page_url",),
        "page_revision_url": ("page_revision_url",),
        "source_url": ("source_url", "original_media_url"),
        "credit": ("credit",),
        "attribution_line": ("attribution_line",),
        "derivative_notice": ("derivative_notice",),
    }
    if isinstance(source, dict):
        for output_key, keys in field_map.items():
            value = _first_present(source, *keys)
            if value is not None:
                attribution[output_key] = value
    else:
        # Official nested schema: keep every supplied section byte-exact rather
        # than flattening it into assumed flat keys.
        for key, value in data.items():
            attribution.setdefault(key, value)
        # Only surface convenience keys that actually exist at top level.
        for output_key, keys in field_map.items():
            value = _first_present(data, *keys)
            if value is not None:
                attribution[output_key] = value
    excerpt = data.get("excerpt")
    rgb_frames = excerpt.get("rgb_frames") if isinstance(excerpt, dict) else None
    if isinstance(rgb_frames, dict):
        attribution["excerpt_rgb_frames"] = {
            "count": rgb_frames.get("count"),
            "width": rgb_frames.get("width"),
            "height": rgb_frames.get("height"),
            "pattern": rgb_frames.get("pattern"),
        }
    still = data.get("still")
    if isinstance(still, dict):
        attribution["still_metadata"] = dict(still)
    canonical_frames = data.get("canonical_frames")
    if isinstance(canonical_frames, dict):
        # Flat video source schema: preserve the section verbatim so frame
        # geometry/count checks use the supplied values, never guessed ones.
        attribution["canonical_frames"] = dict(canonical_frames)
    return attribution


def manifest_document(*, mode: str, command, environment: dict, models: Sequence[dict],
                      frame_source: dict, methodology: dict, source_metadata: dict,
                      extra: dict | None = None) -> dict:
    """Assemble the machine-readable harness manifest."""
    argv = [str(value) for value in command]
    document = {
        "schema": "dlssnr.video-harness.v1",
        "created_utc": utc_now(),
        "mode": mode,
        "command": argv,
        "environment": environment,
        "models": list(models),
        "frame_source": frame_source,
        "attribution": source_metadata,
        "methodology": methodology,
        "support_limits": [
            "RGB-only stateless mode: history, motion, depth, conditioning and blend are empty for every frame; the native preprocess copies current colour into its history feature lanes.",
            "No motion, depth or conditioning G-buffer is reconstructed; the constant conditioning and fixed session noise are neutral defaults, not renderer inputs.",
            "No temporal, zero-motion quality or optical-flow mode is implemented or claimed.",
            "Original is the decoded source frame, not an NVIDIA DLL/vendor reference.",
            "No vendor parity, no image-quality score and no claim that either model is closer to the original.",
            "Small31 post phase 0 is the model-spec default; its host dispatch is source-derived and not verified against DLL host descriptors.",
            "The benchmark measures this reconstructed native host, not an original NGX/DLSS execution.",
            "Media is published only from the approved profile output; third-party media is not redistributed by this harness.",
            "No license, endorsement, copyright or source URL is inferred; only values supplied to --source-metadata are recorded.",
            "A still-image run is a single decoded frame, not a video; it never encodes or publishes an MP4.",
        ],
        "reproduction": {
            "argv": argv,
            "cwd": str(Path(__file__).resolve().parents[1]),
            "render": (
                "Re-run the exact 'argv' list above with --mode render; for a "
                "single still this writes PNGs only and never invokes ffmpeg."),
            "benchmark": (
                "Re-run the exact 'argv' list above with --mode benchmark on the "
                "SM120 lease; a still benchmark replays the same decoded frame."),
            "source_of_truth": "argv (no shell command is stored or reconstructed)",
        },
        "plan_tables": plan_table_hashes(),
    }
    if extra:
        document.update(extra)
    return document


def write_json(path, document) -> Path:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(document, indent=2, sort_keys=False), encoding="utf-8")
    return path


def iter_frame_paths(directory, *, limit=None, suffix=".png") -> list[Path]:
    """Return frame files in deterministic numeric/lexicographic order."""
    directory = Path(directory)
    if not directory.is_dir():
        raise ValueError(f"frame directory does not exist: {directory}")
    paths = sorted(path for path in directory.iterdir()
                   if path.is_file() and path.suffix.lower() == suffix.lower())
    if not paths:
        raise ValueError(f"no {suffix} frames in {directory}")
    if limit is not None:
        if isinstance(limit, bool) or not isinstance(limit, int) or limit < 1:
            raise ValueError("frame limit must be a positive integer")
        paths = paths[:limit]
    return paths


__all__ = [
    "MODEL_NAMES", "NATIVE_PRECISIONS", "PREPROCESS_NAMES", "POSTPROCESS_NAMES",
    "POST_ABI_BYTES", "POST_OUTPUT_SCALE_OFFSET", "POST_DISPLAY_OUTPUT_OFFSET",
    "POST_OUTPUT_SCALE", "POST_DISPLAY_OUTPUT", "PRE_ABI_BYTES",
    "SMALL31_REBUILD_MESSAGE", "FrameLayout", "FramePipeline",
    "TRUNK_OUTPUT_LAYOUT", "TRUNK_FINAL_PHASE", "TRUNK_FINAL_ORIGIN",
    "TRUNK_FINAL_RECORD_BYTES", "TRUNK_FINAL_PHASE_SOURCE",
    "FinalC32Binding", "build_rgb_trunk", "trunk_final_phase",
    "validate_packed_low", "validate_low_features",
    "IMAGE_SUFFIXES", "resolve_precision", "element_bytes", "post_phase_for_model",
    "patch_postprocess_display", "postprocess_display_values",
    "assert_postprocess_display", "decode_rgb_image", "decode_rgb_png",
    "save_rgb_png", "rgb_to_rgba", "load_frame_rgba", "load_image_rgba",
    "as_rgba_float32", "rgb_to_uint8", "validate_rgba_output", "sha256_bytes",
    "sha256_array", "sha256_file", "utc_now", "PANEL_WIDTH", "PANEL_HEIGHT",
    "PANEL_DISPLAY_WIDTH", "PANEL_FILTER_NAME", "PANEL_FILTER_DESCRIPTION",
    "PANEL_HEADER_HEIGHT", "PANEL_FOOTER_HEIGHT", "PANEL_GAP",
    "PANEL_TOTAL_WIDTH", "PANEL_TOTAL_HEIGHT", "DEFAULT_FOOTER",
    "display_panel_geometry", "panel_regions", "resize_rgb_for_display",
    "compose_comparison_panel", "compose_full_resolution_panel", "validate_roi",
    "crop_rgb", "crop_same_roi", "comparison_captions", "encode_png_sequence_command",
    "decode_video_frames_command", "fps_text", "run_command", "ffmpeg_version",
    "summarize_timings", "timed_cuda", "timed_cpu", "gpu_environment",
    "nvidia_smi_snapshot", "plan_table_hashes", "load_source_metadata",
    "manifest_document", "write_json", "iter_frame_paths",
    "load_native_model",
]
