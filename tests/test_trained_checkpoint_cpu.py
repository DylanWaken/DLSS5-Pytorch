"""Focused CPU contract tests for explicit trained FP16 export.

The tests use small synthetic schemas and model shells so no 71-block network,
archive, CUDA extension or checkpoint asset is allocated.  Positive export
tests exercise the real conversion/payload path with only schema discovery and
the owning checkpoint constructor stubbed.
"""
import sys
from pathlib import Path
import unittest
from unittest.mock import Mock, patch

import torch
from torch import nn

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from dlssnr.model import DLSSNR
from dlssnr.small_model import SmallDLSSNR
from dlssnr.trained_checkpoint import export_trained_checkpoint

SCHEMA = {
    "blocks.0.w1": torch.empty((2, 3), dtype=torch.float8_e4m3fn, device="meta"),
    "blocks.0.head_scale": torch.empty((1,), dtype=torch.float32, device="meta"),
}
SMALL_SCHEMA = {
    "blocks.0.w1": torch.empty((2, 3), dtype=torch.float8_e4m3fn, device="meta"),
    "blocks.70.head_scale": torch.empty((1,), dtype=torch.float32, device="meta"),
}
SMALL_IDENTITY = {"stateSchema": "dlssnr-small31/1", "model": "small31", "postPhase": 0}


def legacy_shell(state, precision="fp32"):
    model = DLSSNR.__new__(DLSSNR)
    nn.Module.__init__(model)
    model.precision = precision
    model.state_dict = lambda *args, **kwargs: dict(state)
    return model


def small_shell(state, precision="fp32"):
    model = SmallDLSSNR.__new__(SmallDLSSNR)
    nn.Module.__init__(model)
    model.precision = precision
    model.state_dict = lambda *args, **kwargs: dict(state)
    return model


def legacy_state(weight=None, head_scale=None):
    if weight is None:
        weight = torch.tensor([[0.25, -2.5, 3.0], [-0.125, 4.0, 5.5]], dtype=torch.float32)
    if head_scale is None:
        head_scale = torch.tensor([0.123456789123], dtype=torch.float32)
    weight.requires_grad_(True)
    head_scale.requires_grad_(True)
    weight.grad = torch.ones_like(weight)
    return {"blocks.0.w1": weight, "blocks.0.head_scale": head_scale}


class RecordingCheckpoint:
    payloads = []

    def __init__(self, payload):
        self.__class__.payloads.append(payload)


class RecordingSmallCheckpoint(RecordingCheckpoint):
    pass


class TrainedCheckpointCPUTest(unittest.TestCase):
    def setUp(self):
        RecordingCheckpoint.payloads.clear()
        RecordingSmallCheckpoint.payloads.clear()

    def test_unknown_model_is_not_inferred(self):
        with self.assertRaisesRegex(ValueError, "unknown model"):
            export_trained_checkpoint(legacy_shell(legacy_state()), "unused.pt", model="tiny")

    def test_wrong_model_family_is_rejected_before_state_copy(self):
        small = small_shell({})
        small.state_dict = Mock(side_effect=AssertionError("state copied before family check"))
        with self.assertRaisesRegex(ValueError, "actual dlssnr.DLSSNR"):
            export_trained_checkpoint(small, "unused.pt", model="legacy71")
        small.state_dict.assert_not_called()

        legacy = legacy_shell({})
        legacy.state_dict = Mock(side_effect=AssertionError("state copied before family check"))
        with self.assertRaisesRegex(ValueError, "actual dlssnr.SmallDLSSNR"):
            export_trained_checkpoint(legacy, "unused.pt", model="small31")
        legacy.state_dict.assert_not_called()

    def test_learned_fp8_and_other_precisions_reject_explicitly(self):
        for precision in ("fp8", "bf16", "fp32", None):
            with self.subTest(precision=precision):
                with self.assertRaisesRegex(ValueError, "precision|FP8"):
                    export_trained_checkpoint(object(), "unused.pt", precision=precision)
        with self.assertRaisesRegex(ValueError, "learned FP8 export is unsupported"):
            export_trained_checkpoint(object(), "unused.pt", precision="fp8")

    def test_legacy_nonfinite_overflow_and_shape_errors_precede_save(self):
        with patch("dlssnr.checkpoint.native_state_dict", return_value=SCHEMA):
            for value, message in (
                    (torch.tensor([[float("nan"), 0.0, 0.0], [0.0, 0.0, 0.0]]), "nonfinite"),
                    (torch.tensor([[float("inf"), 0.0, 0.0], [0.0, 0.0, 0.0]]), "nonfinite"),
                    (torch.tensor([[70000.0, 0.0, 0.0], [0.0, 0.0, 0.0]]), "finite.*range")):
                with self.subTest(message=message):
                    state = legacy_state(weight=value)
                    with self.assertRaisesRegex(ValueError, message):
                        export_trained_checkpoint(legacy_shell(state), "unused.pt")
                    self.assertTrue(torch.isnan(state["blocks.0.w1"]).any().item() or
                                    torch.isinf(state["blocks.0.w1"]).any().item() or
                                    state["blocks.0.w1"].max().item() > 65504)

        bad_shape = legacy_state(weight=torch.zeros(3, 2))
        with patch("dlssnr.checkpoint.native_state_dict", return_value=SCHEMA):
            with self.assertRaisesRegex(ValueError, "shape differs"):
                export_trained_checkpoint(legacy_shell(bad_shape), "unused.pt")

        extra = legacy_state()
        extra["blocks.0.unexpected"] = torch.zeros(1)
        with patch("dlssnr.checkpoint.native_state_dict", return_value=SCHEMA):
            with self.assertRaisesRegex(ValueError, "roster differs"):
                export_trained_checkpoint(legacy_shell(extra), "unused.pt")

        integer = legacy_state()
        integer["blocks.0.w1"] = torch.ones(2, 3, dtype=torch.int64)
        with patch("dlssnr.checkpoint.native_state_dict", return_value=SCHEMA):
            with self.assertRaisesRegex(TypeError, "not floating point"):
                export_trained_checkpoint(legacy_shell(integer), "unused.pt")

    def test_legacy_exports_explicit_fp16_preserving_float32_and_source(self):
        state = legacy_state()
        weight_before = state["blocks.0.w1"].detach().clone()
        head_before = state["blocks.0.head_scale"].detach().clone()
        grad_before = state["blocks.0.w1"].grad.clone()
        receipt = {"path": "trained.pt", "sha256": "abc"}

        def save(payload, path, *, overwrite=False):
            self.assertEqual(path, "trained.pt")
            self.assertIs(overwrite, False)
            RecordingCheckpoint.payloads.append(payload)
            return receipt

        model = legacy_shell(state)
        with patch("dlssnr.checkpoint.native_state_dict", return_value=SCHEMA), \
                patch("dlssnr.checkpoint.Checkpoint", RecordingCheckpoint), \
                patch("dlssnr.portable_checkpoint.save_checkpoint_payload", side_effect=save):
            self.assertIs(export_trained_checkpoint(model, "trained.pt"), receipt)

        payload = RecordingCheckpoint.payloads[0]
        self.assertEqual(payload["format_version"], 2)
        self.assertEqual(payload["model"], "legacy71")
        self.assertEqual(payload["model_class"], "dlssnr.DLSSNR")
        self.assertEqual(payload["weight_precision"], "fp16")
        self.assertEqual(payload["native_records"], {})
        self.assertEqual(set(payload["state_dict"]), set(SCHEMA))
        self.assertEqual(payload["state_dict"]["blocks.0.w1"].dtype, torch.float16)
        self.assertEqual(payload["state_dict"]["blocks.0.head_scale"].dtype, torch.float32)
        self.assertTrue(torch.equal(payload["state_dict"]["blocks.0.w1"],
                                    weight_before.to(torch.float16)))
        self.assertTrue(torch.equal(payload["state_dict"]["blocks.0.head_scale"], head_before))
        self.assertNotEqual(payload["state_dict"]["blocks.0.head_scale"].item(),
                            head_before.to(torch.float16).float().item())
        self.assertTrue(payload["metadata"]["provenance"] == "trained")
        self.assertFalse(payload["metadata"]["quantization"]["lossless_original_export"])
        for tensor in payload["state_dict"].values():
            self.assertEqual(tensor.device.type, "cpu")
            self.assertTrue(tensor.is_contiguous())
        self.assertTrue(torch.equal(state["blocks.0.w1"].detach(), weight_before))
        self.assertTrue(torch.equal(state["blocks.0.head_scale"].detach(), head_before))
        self.assertTrue(torch.equal(state["blocks.0.w1"].grad, grad_before))
        self.assertTrue(state["blocks.0.w1"].requires_grad)
        self.assertIsNot(payload["state_dict"]["blocks.0.w1"].untyped_storage(),
                         state["blocks.0.w1"].untyped_storage())

    def test_legacy_export_is_deterministic(self):
        state = legacy_state()
        payloads = []

        def save(payload, path, *, overwrite=False):
            payloads.append(payload)
            return {"path": str(path)}

        with patch("dlssnr.checkpoint.native_state_dict", return_value=SCHEMA), \
                patch("dlssnr.checkpoint.Checkpoint", RecordingCheckpoint), \
                patch("dlssnr.portable_checkpoint.save_checkpoint_payload", side_effect=save):
            export_trained_checkpoint(legacy_shell(state), "a.pt")
            export_trained_checkpoint(legacy_shell(state), "b.pt")
        for name in SCHEMA:
            self.assertTrue(torch.equal(payloads[0][name] if name in payloads[0] else
                                        payloads[0]["state_dict"][name],
                                        payloads[1]["state_dict"][name]))
        self.assertEqual(payloads[0]["metadata"], payloads[1]["metadata"])

    def test_small_identity_is_validated_before_block_mapping(self):
        schema = Mock(return_value=SMALL_SCHEMA)
        canonical = Mock(return_value=SMALL_IDENTITY)
        with patch("dlssnr.portable_checkpoint.canonical_small_identity", canonical), \
                patch("dlssnr.portable_checkpoint.small31_state_schema", schema), \
                patch("dlssnr.portable_checkpoint.SmallCheckpoint", RecordingSmallCheckpoint), \
                patch("dlssnr.portable_checkpoint.save_checkpoint_payload"):
            without = small_shell({"blocks.by_role.0.w1": torch.zeros(2, 3)})
            with self.assertRaisesRegex(ValueError, "missing its _extra_state"):
                export_trained_checkpoint(without, "unused.pt", model="small31")
            schema.assert_not_called()

            mismatched = small_shell({
                "_extra_state": {**SMALL_IDENTITY, "postPhase": 1},
                "blocks.by_role.0.w1": torch.zeros(2, 3),
            })
            with self.assertRaisesRegex(ValueError, "identity mismatch.*postPhase"):
                export_trained_checkpoint(mismatched, "unused.pt", model="small31")
            schema.assert_not_called()

    def test_small_export_maps_actual_by_role_keys_and_quantizes_schema(self):
        weight = torch.tensor([[0.5, -1.5, 2.25], [3.0, -4.0, 5.0]], dtype=torch.bfloat16)
        head = torch.tensor([0.123456789123], dtype=torch.float32)
        state = {
            "_extra_state": {**SMALL_IDENTITY, "archiveManifestSha256": "provenance"},
            "blocks.by_role.0.w1": weight,
            "blocks.by_role.70.head_scale": head,
        }
        payloads = []

        def save(payload, path, *, overwrite=False):
            payloads.append(payload)
            return {"path": str(path), "model": "small31"}

        with patch("dlssnr.portable_checkpoint.canonical_small_identity",
                   return_value=SMALL_IDENTITY), \
                patch("dlssnr.portable_checkpoint.small31_state_schema",
                      return_value=SMALL_SCHEMA), \
                patch("dlssnr.portable_checkpoint.SmallCheckpoint", RecordingSmallCheckpoint), \
                patch("dlssnr.portable_checkpoint.save_checkpoint_payload", side_effect=save):
            receipt = export_trained_checkpoint(small_shell(state), "small.pt", model="small31")

        payload = payloads[0]
        self.assertEqual(receipt["model"], "small31")
        self.assertEqual(payload["format_version"], 3)
        self.assertEqual(payload["model"], "small31")
        self.assertEqual(payload["model_class"], "dlssnr.SmallDLSSNR")
        self.assertEqual(payload["weight_precision"], "fp16")
        self.assertEqual(payload["storage"], "state_dict")
        self.assertEqual(payload["native_records"], {})
        self.assertEqual(payload["model_identity"], SMALL_IDENTITY)
        self.assertEqual(set(payload["state_dict"]), set(SMALL_SCHEMA))
        self.assertEqual(payload["state_dict"]["blocks.0.w1"].dtype, torch.float16)
        self.assertEqual(payload["state_dict"]["blocks.70.head_scale"].dtype, torch.float32)
        self.assertTrue(torch.equal(payload["state_dict"]["blocks.0.w1"], weight.float().half()))
        self.assertTrue(torch.equal(payload["state_dict"]["blocks.70.head_scale"], head))
        self.assertEqual(payload["metadata"]["provenance"], "trained")
        self.assertFalse(payload["metadata"]["lineage"]["original_resource_bytes"])

    def test_small_exact_roster_and_shape_are_enforced(self):
        with patch("dlssnr.portable_checkpoint.canonical_small_identity",
                   return_value=SMALL_IDENTITY), \
                patch("dlssnr.portable_checkpoint.small31_state_schema",
                      return_value=SMALL_SCHEMA), \
                patch("dlssnr.portable_checkpoint.SmallCheckpoint", RecordingSmallCheckpoint), \
                patch("dlssnr.portable_checkpoint.save_checkpoint_payload") as save:
            extra = {
                "_extra_state": dict(SMALL_IDENTITY),
                "blocks.by_role.0.w1": torch.zeros(2, 3),
                "blocks.by_role.70.head_scale": torch.zeros(1),
                "blocks.by_role.99.head_scale": torch.zeros(1),
            }
            with self.assertRaisesRegex(ValueError, "roster differs"):
                export_trained_checkpoint(small_shell(extra), "unused.pt", model="small31")

            bad_shape = {
                "_extra_state": dict(SMALL_IDENTITY),
                "blocks.by_role.0.w1": torch.zeros(3, 2),
                "blocks.by_role.70.head_scale": torch.zeros(1),
            }
            with self.assertRaisesRegex(ValueError, "shape differs"):
                export_trained_checkpoint(small_shell(bad_shape), "unused.pt", model="small31")
            save.assert_not_called()


if __name__ == "__main__":
    unittest.main()
