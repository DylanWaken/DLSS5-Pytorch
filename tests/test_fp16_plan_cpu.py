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

    def test_nonpreset_shapes_preserve_native_schedule_and_records(self):
        # Odd, portrait, ultrawide and above-4K fields need exact geometry;
        # a nearest-preset lookup cannot produce these physical input extents.
        cases = ((1279, 719, 672, 384), (1234, 777, 640, 416),
                 (1537, 865, 832, 448), (1080, 1920, 576, 960),
                 (3440, 1440, 1728, 736), (3841, 2161, 1984, 1088),
                 (33, 33, 160, 160))
        for precision in ("fp8", "fp16"):
            reference = build_plan(make(1280, 720, precision=precision))
            for width, height, padded_width, padded_height in cases:
                with self.subTest(precision=precision, width=width, height=height):
                    plan = build_plan(make(width, height, precision=precision))
                    element_bytes = 2 if precision == "fp16" else 1
                    self.assertEqual(plan["buffers"]["input"]["storage_bytes"],
                                     padded_width * padded_height * 32 * element_bytes)
                    self.assertEqual(list(plan["buffers"]), list(reference["buffers"]))
                    self.assertEqual(plan["records"], reference["records"])
                    self.assertEqual(len(plan["calls"]), 185)
                    for actual, expected in zip(plan["calls"], reference["calls"]):
                        for field in ("symbol", "fn", "abi", "block", "all_resident", "mutable_offsets"):
                            self.assertEqual(actual[field], expected[field])
                        self.assertEqual([(offset, size) for offset, size, _ in actual["fields"]],
                                         [(offset, size) for offset, size, _ in expected["fields"]])

    def test_odd_downsample_retains_padding_clear_workspace(self):
        # 1234x777 yields a C256 field80x52 and padded lower field40x28.
        # This native kernel clears a second backing region beyond logical data.
        for precision, element_bytes in (("fp8", 1), ("fp16", 2)):
            plan = build_plan(make(1234, 777, precision=precision))
            downsample = plan["buffers"]["b22.down"]
            self.assertEqual(downsample["shape_hwc"], [28, 40, 512])
            self.assertEqual(downsample["logical_bytes"], 28 * 40 * 512 * element_bytes)
            self.assertEqual(downsample["storage_bytes"], 2 * downsample["logical_bytes"])

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
