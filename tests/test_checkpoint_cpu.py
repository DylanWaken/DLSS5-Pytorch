"""Portable checkpoint conversion rules, independent of downloaded weights/CUDA."""
from pathlib import Path
import re
import sys
import unittest
from unittest.mock import patch

import torch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from dlssnr.checkpoint import Checkpoint, FP8, promote_tensor, _half_matrix, pack_kernel_fp16, _SchemaArchive, native_state_dict
from dlssnr.geometry import block_channels


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

    def test_frontend_head_padding_is_zero_and_packing_is_deterministic(self):
        import numpy as np
        from dlssnr.weights import packed_f16_weight_index
        values = torch.arange(128, dtype=torch.float16).reshape(32, 4)
        raw = np.frombuffer(_half_matrix(values, 32, 4), dtype='<f2')
        indices = packed_f16_weight_index(np.arange(32)[:, None], np.arange(4)[None, :], 4)
        self.assertTrue(np.array_equal(raw[indices], values.numpy()))
        padding = np.ones(raw.size, dtype=bool)
        padding[indices] = False
        self.assertTrue(np.all(raw[padding] == 0))
        schema = native_state_dict(_SchemaArchive())
        state = {name: torch.full(value.shape, .25).to(value.dtype) for name, value in schema.items()
                 if name.startswith(('blocks.0.', 'blocks.70.'))}
        for block, kind, size in ((0, 'preprocess', 33984), (70, 'postprocess', 34096)):
            first = pack_kernel_fp16(state, block, kind)
            self.assertEqual(len(first), size)
            self.assertEqual(first, pack_kernel_fp16(state, block, 'window'))

    def test_create_plan_fp16_dispatches_independent_kinds_for_compiled_roster(self):
        roster_path = (Path(__file__).resolve().parents[1]
                       / "csrc/kernel_launcher/plan_fp16_generated.inl")
        text = roster_path.read_text(encoding="utf-8")
        body = re.search(r"static const FBufferSpec RecordSpecs_fp16\[\] = \{(.*?)\};",
                         text, re.S)
        self.assertIsNotNone(body)
        roster = [(name, int(size)) for name, size in
                  re.findall(r'\{"([^"]+)", (\d+)LL\}', body.group(1))]
        self.assertEqual(len(roster), 142)

        def expected_kind(block, layer):
            if block == 39:
                return "upsample"
            if 31 <= block <= 38:
                return {0: "expand", 1: "contract", 2: "qkv", 4: "projection"}[layer]
            if block_channels(block) == 512:
                return {0: "ffn", 1: "ffn_projection", 2: "qkv",
                        3: "projection", 4: "down"}[layer]
            return "window"

        expected = []
        for name, _ in roster:
            block, layer = (int(part.removeprefix(prefix)) for part, prefix in
                            zip(name.split(".")[:2], ("block", "layer")))
            expected.append((block, expected_kind(block, layer)))

        class _Ops:
            def record_names_fp16(self):
                return [name for name, _ in roster]

            def record_bytes_fp16(self):
                return [size for _, size in roster]

        calls = []
        sizes = iter(size for _, size in roster)
        checkpoint = Checkpoint.__new__(Checkpoint)

        def fake_kernel_record(block, *, kind="window", precision=None, device="cpu"):
            calls.append((block, kind, precision))
            return torch.zeros(next(sizes), dtype=torch.uint8)

        checkpoint.kernel_record = fake_kernel_record
        with patch("dlssnr.deployment.load_extension", return_value=_Ops()), \
                patch("dlssnr.deployment.create_plan_fp16",
                      side_effect=lambda state, records, **kwargs: (records, kwargs)):
            records, kwargs = checkpoint.create_plan_fp16(
                torch.empty(0, dtype=torch.uint8), width=1234, height=777)

        self.assertEqual([(block, kind) for block, kind, _ in calls], expected)
        self.assertTrue(all(precision == "fp16" for _, _, precision in calls))
        self.assertEqual(len(records), len(roster))
        self.assertEqual(kwargs, {"width": 1234, "height": 777})


if __name__ == "__main__":
    unittest.main()
