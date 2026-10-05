"""Detect lost/duplicate CUDA exports and stale includes after source grouping."""
from pathlib import Path
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tools.kernel_sources import check_roster, collect, compare_exports, _without_comments_and_strings


class KernelSourcesCPUTest(unittest.TestCase):
    def make_fixture(self, root):
        (root / "kernel_impl").mkdir()
        (root / "kernel_launcher").mkdir()
        self.write_kernel(root / "kernel_impl/group.cuh")
        (root / "kernel_launcher/group.cu").write_text('#include "../kernel_impl/group.cuh"\n', encoding="utf-8")

    def write_kernel(self, path, name="example_fp8"):
        path.write_text(
            f"namespace dlssnr::reconstructed::{name} {{\n"
            f"__global__ __maxnreg__(192) void {name}(Parameters r_P) {{\n"
            "    SharedBody<64, false>(r_P);\n}\n}\n", encoding="utf-8"
        )

    def test_active_sources_have_complete_paired_exports_and_one_owner(self):
        check_roster(collect(ROOT / "csrc"))

    def test_algorithm_headers_do_not_reintroduce_register_transcripts(self):
        for path in (ROOT / "csrc/kernel_impl").glob("*.cuh"):
            with self.subTest(header=path.name):
                source = path.read_text(encoding="utf-8")
                code = _without_comments_and_strings(source)
                self.assertNotRegex(code, r"\b\w*(?:PtxRegister|AtPtx|PtxPredicate)\w*\b")
                self.assertNotRegex(code, r"\bgoto\b")
                if path.name != "intrinsics.cuh":
                    self.assertNotRegex(code, r"\basm\b")
                    # A broad ceiling catches a transcript moved into a helper;
                    # current algorithms remain compact shared tile/loop bodies.
                    self.assertLessEqual(len(source.splitlines()), 600)

    def test_numerical_bit_patterns_are_named_before_conversion(self):
        for path in (ROOT / "csrc/kernel_impl").glob("*.cuh"):
            with self.subTest(header=path.name):
                code = _without_comments_and_strings(path.read_text(encoding="utf-8"))
                self.assertNotRegex(code, r"\bFloatToHalf2\s*\(\s*(?:0x[0-9a-fA-F]{6,}|[0-9]{6,})[uUlL]*\s*\)")

    def test_grouped_header_maps_names_not_filenames(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            entry = collect(root)["entries"]["example_fp8"]
            self.assertEqual(entry["header"], "kernel_impl/group.cuh")
            self.assertEqual(entry["emission_unit"], "kernel_launcher/group.cu")
            self.assertEqual(entry["template_calls"], ["SharedBody<64, false>"])

    def test_missing_include_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            (root / "kernel_launcher/group.cu").write_text('#include "missing.cuh"\n', encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "missing local include"):
                collect(root)

    def test_duplicate_definition_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            self.write_kernel(root / "kernel_impl/duplicate.cuh")
            with self.assertRaisesRegex(ValueError, "duplicate CUDA entry"):
                collect(root)

    def test_duplicate_or_missing_emission_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            duplicate = root / "kernel_launcher/duplicate.cu"
            duplicate.write_text('#include "../kernel_impl/group.cuh"\n', encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "found 2"):
                collect(root)
            duplicate.unlink()
            (root / "kernel_launcher/group.cu").write_text("", encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "found 0"):
                collect(root)

    def test_export_comparison_rejects_rename(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            baseline = collect(root)
            self.write_kernel(root / "kernel_impl/group.cuh", "renamed_fp8")
            with self.assertRaisesRegex(ValueError, "exported entry roster changed"):
                compare_exports(collect(root), baseline)


if __name__ == "__main__":
    unittest.main()
