"""Detect lost/duplicate CUDA exports and stale includes after source grouping."""
from pathlib import Path
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tools.kernel_sources import check_roster, check_entry_layout, collect, compare_exports, _without_comments_and_strings


class KernelSourcesCPUTest(unittest.TestCase):
    def make_fixture(self, root):
        (root / "kernel_impl").mkdir()
        (root / "kernel_launcher").mkdir()
        self.write_kernel(root / "kernel_impl/group.cuh")
        (root / "kernel_launcher/group.cu").write_text('#include "../kernel_impl/group.cuh"\n', encoding="utf-8")

    def write_kernel(self, path, name="example_fp8"):
        path.write_text(
            f'extern "C" __global__ __maxnreg__(192) void {name}(FExampleParameters Parameters) {{\n'
            "    SharedBody<64, false>(Parameters);\n}\n", encoding="utf-8"
        )

    def test_active_sources_have_complete_paired_exports_and_one_owner(self):
        inventory = collect(ROOT / "csrc")
        check_roster(inventory)
        check_entry_layout(inventory, ROOT / "csrc")

    def test_algorithm_headers_do_not_reintroduce_register_transcripts(self):
        for path in (ROOT / "csrc/kernel_impl").glob("*"):
            if path.suffix not in {".cu", ".cuh"}:
                continue
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
        for path in (ROOT / "csrc/kernel_impl").glob("*"):
            if path.suffix not in {".cu", ".cuh"}:
                continue
            with self.subTest(header=path.name):
                code = _without_comments_and_strings(path.read_text(encoding="utf-8"))
                self.assertNotRegex(code, r"\bFloatToHalf2\s*\(\s*(?:0x[0-9a-fA-F]{6,}|[0-9]{6,})[uUlL]*\s*\)")

    def test_grouped_historical_layout_is_not_admitted_as_current(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            with self.assertRaisesRegex(ValueError, "own named CUDA file"):
                check_entry_layout(collect(root), root)

    def test_interfaces_do_not_regress_to_offset_named_parameters(self):
        # Byte offsets belong in ABI assertions, not in the field's identity.
        # This catches the earlier Pointer0/Scalar32/Aux80 wrappers and raw
        # frontend word decoding across implementations, launchers and Torch.
        for path in (ROOT / "csrc").rglob("*"):
            if path.suffix not in {".cu", ".cuh", ".h", ".cpp", ".inl"}:
                continue
            with self.subTest(source=str(path.relative_to(ROOT))):
                code = _without_comments_and_strings(path.read_text(encoding="utf-8"))
                self.assertNotRegex(code, r"\b(?:g_)?(?:Pointer|Scalar|Aux|Parameter|Param|Temp|Tmp)[0-9]+\b")
                self.assertNotRegex(code, r"\bParameterU64\b|\b(?:r_)?Parameters\s*\.\s*Words\b")

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

    def test_namespaces_and_using_directives_are_rejected(self):
        for declaration in ("namespace Hidden { }", "namespace { }", "using namespace std;"):
            with self.subTest(declaration=declaration), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                self.make_fixture(root)
                path = root / "kernel_impl/group.cuh"
                path.write_text(declaration + "\n" + path.read_text(), encoding="utf-8")
                with self.assertRaisesRegex(ValueError, "namespaces and using namespace are forbidden"):
                    collect(root)

    def test_cuda_entries_require_c_linkage(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            path = root / "kernel_impl/group.cuh"
            path.write_text(path.read_text().replace('extern "C" ', ''), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, 'must use extern "C" linkage'):
                collect(root)

    def test_historical_namespace_migration_requires_explicit_flag(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_fixture(root)
            current = collect(root)
            path = root / "kernel_impl/group.cuh"
            original = path.read_text().replace('extern "C" ', '')
            path.write_text("namespace dlssnr::reconstructed::example_fp8 {\n" + original + "}\n", encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "namespaces and using namespace are forbidden"):
                collect(root)
            historical = collect(root, allow_legacy_namespaces=True)
            with self.assertRaisesRegex(ValueError, "exported entry roster changed"):
                compare_exports(current, historical)
            compare_exports(current, historical, allow_namespace_migration=True)

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
