"""Native RGB frame pipeline preparation and execution.

Kernel sequencing, allocation, stream use, graph behavior and validation order
are the original implementations.  Image decoding and comparison rendering are
separate media owners, so importing this module never needs Pillow.
"""
from __future__ import annotations

import threading
import time

import numpy as np
import torch

from ..checkpoint import Checkpoint
from ..deployment import frontend_configuration, load_extension, prepare_frontend
from ..model_specs import MODEL_NAMES, resolve_model
from ..small_deployment import PREPOST_RECORD_BYTES, SmallNativeCheckpoint
from .abi import (
    POST_DISPLAY_OUTPUT,
    POST_DISPLAY_OUTPUT_OFFSET,
    POST_OUTPUT_SCALE,
    POST_OUTPUT_SCALE_OFFSET,
    POSTPROCESS_NAMES,
    PREPROCESS_NAMES,
    assert_postprocess_display,
    patch_postprocess_display,
)
from .layout import (
    PLAN_RUN_OUTPUT_LAYOUT,
    TRUNK_FINAL_ORIGIN,
    TRUNK_FINAL_PHASE_SOURCE,
    TRUNK_OUTPUT_LAYOUT,
    FrameLayout,
    _assert_disjoint,
    _require_contiguous_uint8,
    as_rgba_float32,
    build_rgb_trunk,
    resolve_precision,
    rgb_to_uint8,
    validate_low_features,
)


SMALL31_REBUILD_MESSAGE = (
    "Small31 native deployment ops are missing from the loaded extension. "
    "The checked-in .pyd predates csrc/kernel_launcher/small_deployment.cpp and "
    "csrc/torch_api/small_extension.cpp. Rebuild in place with "
    "`python setup.py build_ext --inplace` (setup.py globs both directories), "
    "then rerun. No legacy or surrogate fallback is used."
)


def post_phase_for_model(model: str) -> int:
    """The native model-schedule post phase (legacy 1, Small31 0).

    These are model-schedule choices from ``dlssnr.model_specs``.  Small31's
    host phase is source-derived and not verified against DLL dispatch.
    """
    return resolve_model(model).post_phase_default


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
