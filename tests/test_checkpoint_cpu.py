"""Portable checkpoint conversion rules, independent of downloaded weights/CUDA."""
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

import torch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from dlssnr.checkpoint import Checkpoint, FP8, promote_tensor


class CheckpointCPUTest(unittest.TestCase):
    def test_every_finite_fp8_code_widens_exactly(self):
        codes = torch.arange(256, dtype=torch.int16).to(torch.uint8)
        codes = codes[(codes & 127) != 127]
        values = codes.view(FP8)
        for dtype in (torch.float16, torch.bfloat16, torch.float32, torch.float64):
            widened = promote_tensor(values, dtype)
            self.assertTrue(torch.equal(widened.double(), values.double()))
            self.assertTrue(torch.equal(widened.to(FP8).view(torch.uint8), codes))

    def test_downward_and_incomparable_formats_are_rejected(self):
        for source, target in ((torch.float32, torch.float16), (torch.float16, FP8),
                               (torch.float16, torch.bfloat16), (torch.bfloat16, torch.float16)):
            with self.assertRaisesRegex(ValueError, "quantization"):
                promote_tensor(torch.ones(1, dtype=source), target)

    def test_missing_tensor_roster_rejected(self):
        with self.assertRaisesRegex(ValueError, "roster"):
            Checkpoint(dict(format_version=2, weight_precision="fp16", metadata={}, state_dict={}))

    def test_no_silent_fp8_deployment_from_fp16(self):
        checkpoint = Checkpoint.__new__(Checkpoint)
        checkpoint.precision = "fp16"
        with patch("dlssnr.deployment.load_extension") as extension:
            with self.assertRaisesRegex(ValueError, "quantization"):
                checkpoint.create_plan_fp8(torch.empty(0))
            with self.assertRaisesRegex(ValueError, "quantization"):
                checkpoint.kernel_record(1, precision="fp8")
            extension.assert_not_called()


if __name__ == "__main__":
    unittest.main()
