"""Detect lost/duplicate CUDA exports and stale includes after source grouping."""
from pathlib import Path
import json
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

    def make_template_fixture(self, root):
        (root / "kernel_impl/example_stage/fp8").mkdir(parents=True)
        (root / "kernel_impl/shared/common").mkdir(parents=True)
        (root / "kernel_launcher").mkdir()
        path = root / "kernel_impl/example_stage/fp8/example_fp8.cu"
        path.write_text(
            "template <int Channels, typename FParameters>\n"
            "__global__ __maxnreg__(168) void example_fp8(FParameters Parameters)\n"
            "{\n"
            "    const int ThreadIndex = threadIdx.x;\n"
            "    int Value = Parameters.Input[ThreadIndex];\n"
            "    for (int Channel = 0; Channel < Channels; ++Channel)\n"
            "    {\n"
            "        if (Channel < Parameters.ValidChannels)\n"
            "        {\n"
            "            Value += Parameters.Weights[Channel];\n"
            "        }\n"
            "        else\n"
            "        {\n"
            "            Value += 0;\n"
            "        }\n"
            "    }\n"
            "    if (ThreadIndex < Parameters.OutputCount)\n"
            "    {\n"
            "        Parameters.Output[ThreadIndex] = Value;\n"
            "    }\n"
            "    else\n"
            "    {\n"
            "        return;\n"
            "    }\n"
            "}\n"
            'extern "C" const void* Resolve_example_c32_fp8()\n'
            "{\n"
            "    return reinterpret_cast<const void*>(example_fp8<32, FExampleParameters>);\n"
            "}\n"
            'extern "C" const void* Resolve_example_c64_fp8()\n'
            "{\n"
            "    return reinterpret_cast<const void*>(example_fp8<64, FExampleParameters>);\n"
            "}\n",
            encoding="utf-8",
        )
        entries = [{
            "name": f"example_c{channels}_fp8",
            "template_function": "example_fp8",
            "source": "kernel_impl/example_stage/fp8/example_fp8.cu",
            "parameters": "FExampleParameters",
            "template_arguments": f"{channels}, FExampleParameters",
            "resolver": f"Resolve_example_c{channels}_fp8",
        } for channels in (32, 64)]
        manifest = root / "kernel_impl/shared/common/kernel_templates.json"
        manifest.write_text(json.dumps({"entries": entries}), encoding="utf-8")
        return path, manifest, entries

    def test_active_sources_have_complete_paired_exports_and_one_owner(self):
        inventory = collect(ROOT / "csrc")
        check_roster(inventory)
        check_entry_layout(inventory, ROOT / "csrc")
        self.assertEqual(inventory["entry_count"], 81)
        self.assertEqual(inventory["definition_count"], 56)
        self.assertEqual(inventory["emission_unit_count"], 56)
        self.assertEqual(inventory["template_entry_count"], 40)

    def test_replaced_entry_files_do_not_survive_beside_templates(self):
        manifest = ROOT / "csrc/kernel_impl/shared/common/kernel_templates.json"
        entries = json.loads(manifest.read_text(encoding="utf-8"))["entries"]
        for entry in entries:
            with self.subTest(entry=entry["name"]):
                # Search every stage, including accidentally retained old folders.
                # Testing only the removed precision folder would pass vacuously.
                obsolete = list((ROOT / "csrc/kernel_impl").rglob(entry["name"] + ".cu"))
                self.assertFalse(obsolete, f"obsolete standalone entries remain: {obsolete}")
                self.assertTrue((ROOT / "csrc" / entry["source"]).is_file())

    def test_registered_template_has_one_definition_and_two_logical_entries(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_template_fixture(root)
            inventory = collect(root)
            check_entry_layout(inventory, root)
            self.assertEqual(inventory["entry_count"], 2)
            self.assertEqual(inventory["definition_count"], 1)
            self.assertEqual(inventory["emission_unit_count"], 1)
            self.assertEqual(inventory["template_entry_count"], 2)
            self.assertEqual(set(inventory["entries"]), {"example_c32_fp8", "example_c64_fp8"})
            for entry in inventory["entries"].values():
                self.assertEqual(entry["definition"], "example_fp8")
                self.assertEqual(entry["emission_unit"], "kernel_impl/example_stage/fp8/example_fp8.cu")

    def test_historical_manifest_remains_readable_but_old_layout_is_not_active(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path, manifest, entries = self.make_template_fixture(root)
            current = collect(root)
            historical_path = root / "kernel_impl/fp8/example_fp8.cu"
            historical_path.parent.mkdir()
            historical_path.write_bytes(path.read_bytes())
            path.unlink()
            historical_manifest = root / "kernel_impl/common/kernel_templates.json"
            historical_manifest.parent.mkdir()
            for entry in entries:
                entry["source"] = historical_path.relative_to(root).as_posix()
            historical_manifest.write_text(json.dumps({"entries": entries}), encoding="utf-8")
            manifest.unlink()
            historical = collect(root)
            compare_exports(current, historical)
            self.assertEqual(historical["entry_count"], 2)
            with self.assertRaisesRegex(ValueError, "own named CUDA file"):
                check_entry_layout(historical, root)

    def test_current_and_obsolete_template_catalogs_cannot_coexist(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            _, manifest, _ = self.make_template_fixture(root)
            obsolete = root / "kernel_impl/common/kernel_templates.json"
            obsolete.parent.mkdir()
            obsolete.write_bytes(manifest.read_bytes())
            with self.assertRaisesRegex(ValueError, "multiple template manifests"):
                collect(root)

    def test_stage_owned_helpers_and_intrinsics_are_admitted(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_template_fixture(root)
            helpers = root / "kernel_impl/example_stage/common"
            helpers.mkdir()
            (helpers / "tile_helpers.cuh").write_text("#pragma once\n", encoding="utf-8")
            (helpers / "intrinsics.cuh").write_text("#pragma once\n", encoding="utf-8")
            check_entry_layout(collect(root), root)

    def test_helpers_outside_stage_precision_folders_are_rejected(self):
        for relative in ("kernel_impl/common/helper.cuh", "kernel_impl/example_stage/helper.cuh",
                         "kernel_impl/example_stage/misc/helper.cuh"):
            with self.subTest(path=relative), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                self.make_template_fixture(root)
                misplaced = root / relative
                misplaced.parent.mkdir(parents=True, exist_ok=True)
                misplaced.write_text("#pragma once\n", encoding="utf-8")
                with self.assertRaisesRegex(ValueError, "device sources belong"):
                    check_entry_layout(collect(root), root)

    def test_precision_label_cannot_disagree_with_the_global_export(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path, manifest, entries = self.make_template_fixture(root)
            wrong = root / "kernel_impl/example_stage/fp16/example_fp8.cu"
            wrong.parent.mkdir()
            wrong.write_bytes(path.read_bytes())
            path.unlink()
            for entry in entries:
                entry["source"] = wrong.relative_to(root).as_posix()
            manifest.write_text(json.dumps({"entries": entries}), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "own named CUDA file"):
                check_entry_layout(collect(root), root)

    def test_unmapped_cpp_template_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            _, manifest, _ = self.make_template_fixture(root)
            manifest.unlink()
            with self.assertRaisesRegex(ValueError, 'must use extern "C" linkage'):
                collect(root)

    def test_missing_template_resolver_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path, _, _ = self.make_template_fixture(root)
            path.write_text(path.read_text(encoding="utf-8").replace(
                "Resolve_example_c32_fp8", "RemovedResolver"), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "resolver does not reference its exact specialization"):
                collect(root)

    def test_template_resolver_cannot_silently_select_another_channel_profile(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path, _, _ = self.make_template_fixture(root)
            path.write_text(path.read_text(encoding="utf-8").replace(
                "example_fp8<32, FExampleParameters>", "example_fp8<64, FExampleParameters>"),
                encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "resolver does not reference its exact specialization"):
                collect(root)

    def test_duplicate_logical_template_entry_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            _, manifest, entries = self.make_template_fixture(root)
            manifest.write_text(json.dumps({"entries": entries + [entries[0]]}), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "duplicate logical entry"):
                collect(root)

    def test_missing_owning_global_template_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path, _, _ = self.make_template_fixture(root)
            path.write_text("// The owning global definition was removed.\n", encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "missing owning global template"):
                collect(root)

    def test_template_and_surviving_original_c_entry_are_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.make_template_fixture(root)
            self.write_kernel(root / "kernel_impl/example_stage/fp8/example_c32_fp8.cu", "example_c32_fp8")
            with self.assertRaisesRegex(ValueError, "duplicate CUDA entry.*template and direct definition"):
                collect(root)

    def test_unrelated_template_helper_does_not_authorize_non_template_global(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path, _, _ = self.make_template_fixture(root)
            path.write_text(path.read_text(encoding="utf-8").replace(
                "template <int Channels, typename FParameters>\n",
                "template <typename TValue> void Helper(TValue Value) {}\n", 1), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, r"registered template must be a C\+\+ global template"):
                collect(root)

    def test_template_resolver_requires_c_linkage_and_const_pointer_signature(self):
        for signature in ("const void*", 'extern "C" void*'):
            with self.subTest(signature=signature), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                path, _, _ = self.make_template_fixture(root)
                path.write_text(path.read_text(encoding="utf-8").replace(
                    'extern "C" const void* Resolve_example_c32_fp8',
                    signature + " Resolve_example_c32_fp8", 1), encoding="utf-8")
                with self.assertRaisesRegex(ValueError, r"resolver must have extern C const void\* signature"):
                    collect(root)

    def test_template_migration_requires_explicit_flag_and_preserves_typed_abi(self):
        with tempfile.TemporaryDirectory() as current_dir, tempfile.TemporaryDirectory() as baseline_dir:
            current_root, baseline_root = Path(current_dir), Path(baseline_dir)
            self.make_template_fixture(current_root)
            (baseline_root / "kernel_impl").mkdir()
            for channels in (32, 64):
                self.write_kernel(baseline_root / f"kernel_impl/example_c{channels}_fp8.cu",
                                  f"example_c{channels}_fp8")
            current, baseline = collect(current_root), collect(baseline_root)
            with self.assertRaisesRegex(ValueError, "exported entry roster changed"):
                compare_exports(current, baseline)
            compare_exports(current, baseline, allow_template_migration=True)

            path = baseline_root / "kernel_impl/example_c64_fp8.cu"
            path.write_text(path.read_text(encoding="utf-8").replace(
                "FExampleParameters", "FChangedAbiParameters"), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "exported entry roster changed"):
                compare_exports(current, collect(baseline_root), allow_template_migration=True)

    def test_algorithm_headers_do_not_reintroduce_register_transcripts(self):
        for path in (ROOT / "csrc/kernel_impl").rglob("*"):
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
        for path in (ROOT / "csrc/kernel_impl").rglob("*"):
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
