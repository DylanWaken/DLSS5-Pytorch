"""Physical frame layout, packed-field validation and final-output binding.

This module owns the ndarray/tensor shape and type contracts required by native
execution, the packed low-field checks, and the final C32 descriptor binding.
It is deliberately below the pipeline and has no image-file or presentation
dependency.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Iterable

import numpy as np
import torch

from ..deployment import (
    compose_kernels,
    prepare_output_view_fp8,
    prepare_output_view_fp16,
    prepare_kernels,
)
from ..common.hashing import sha256_array
from ..common.precision import NATIVE_PRECISIONS, element_bytes, resolve_precision
from ..geometry import Geometry, window_shift
from ..model_specs import resolve_model


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


# ``resolve_precision``/``element_bytes`` are compatibility re-exports of the
# canonical owner dlssnr.common.precision (same function objects).


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
