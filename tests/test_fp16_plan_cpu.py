"""Offline FP16 ABI and schedule checks; no CUDA context is created."""
import json
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tuning"))
from physical_schedule import make
from generate_plan import build_plan, RESOLUTIONS


class FP16PlanCPUTest(unittest.TestCase):
    def test_four_shapes_share_native_half_kernel_sequence(self):
        sequence = None
        for width, height in RESOLUTIONS:
            schedule = make(width, height, precision="fp16")
            plan = build_plan(schedule)
            self.assertEqual(len(plan["calls"]), 185)
            self.assertEqual(len(plan["records"]), 142)
            current = [(call["symbol"], call["block"]) for call in plan["calls"]]
            if sequence is not None:
                self.assertEqual(current, sequence)
            sequence = current
            self.assertTrue(all(not call["symbol"].endswith("_fp8") for call in plan["calls"]))
            self.assertFalse(any(name.endswith("_scratch") for name in plan["buffers"]))

    def test_native_half_pointer_contracts(self):
        plan = build_plan(make(3840, 2160, precision="fp16"))
        for call in plan["calls"]:
            offsets = {offset for offset, size, value in call["fields"] if size == 8}
            if call["symbol"] in ("cc_vit_1d_ffn_contract", "cc_vit_1d_projection"):
                self.assertEqual(offsets, {0, 8, 16, 24, 32})
            elif call["symbol"] == "cc_vit_1d_qkv":
                self.assertEqual(offsets, {0, 8, 16, 24, 32, 40})
            elif call["symbol"] == "cc_dec_input_upsample_1024_512":
                self.assertEqual(offsets, {0, 8, 16, 24, 32, 56})

    def test_saved_plans_match_generator(self):
        for precision in ("fp8", "fp16"):
            for width, height in RESOLUTIONS:
                suffix = "" if precision == "fp8" else "_fp16"
                saved = json.loads((ROOT / f"tuning/plan{suffix}_{width}_{height}.json").read_text())
                # JSON converts tuple parameter fields to arrays.
                generated = json.loads(json.dumps(build_plan(make(width, height, precision=precision))))
                self.assertEqual(saved, generated)


if __name__ == "__main__":
    unittest.main()
