"""CPU contracts for canonical build helpers, facades and packaging metadata.

No Torch import, CUDA query, compiler invocation or native load is performed by
these tests. Subprocesses only exercise import safety and standalone facades.
"""
import ast
import hashlib
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

try:
    import tomllib
except ModuleNotFoundError:  # Python 3.10 has no stdlib TOML reader.
    tomllib = None

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from dlssnr.build import cli as canonical_cli
from dlssnr.build import native as canonical_native
from dlssnr.build import resolution as canonical_resolution
from dlssnr.build import speed as canonical_speed
from dlssnr.build import targets as canonical_targets
from dlssnr.build import toolchain as canonical_toolchain
from tuning import build_config, cuda_toolchain, resolution_cli, resolution_policy


def write(path, text=""):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf8")
    return path


def write_resolution_policy(root, *, state="implementation_admitted", width=1280):
    root = Path(root).resolve()
    row = {"sm": 120, "precision": "fp8", "width": width, "height": 720,
           "receipt": "evidence.json", "state": state}
    receipt = {
        "schema_version": 1,
        "kind": "resolution_admission",
        "record": {key: value for key, value in row.items() if key != "receipt"},
    }
    raw = (json.dumps(receipt, indent=2, sort_keys=True) + "\n").encode("utf8")
    evidence = root / "evidence.json"
    evidence.parent.mkdir(parents=True, exist_ok=True)
    evidence.write_bytes(raw)
    row["receipt_sha256"] = hashlib.sha256(raw).hexdigest()
    policy = {
        "schema_version": 1,
        "device_sm": 120,
        "bounds": dict(canonical_resolution.BOUNDS),
        "distance": canonical_resolution.DISTANCE,
        "unmeasured_config_id": -1,
        "anchors": [],
        "admissions": [row],
    }
    write(root / "tuning/sm_120.json", json.dumps(policy, indent=2) + "\n")
    return policy


def make_native_tree(root):
    root = Path(root).resolve()
    write(root / "csrc/kernel_impl/a.cu", "// a\n")
    write(root / "csrc/kernel_impl/nested/b.cu", "// b\n")
    write(root / "csrc/kernel_launcher/launcher.cpp", "// launcher\n")
    write(root / "csrc/torch_api/extension.cpp", "// extension\n")
    write(root / "csrc/kernel_launcher/table.inl", "// generated table\n")
    write(root / "csrc/include/flashlight/arch/async.cuh", "// async\n")
    write(root / "csrc/include/flashlight/core.cuh", "// core\n")
    write(root / "csrc/include/dlssnr/abi/kernel_parameters.h", "// parameters\n")
    write(root / "csrc/include/dlssnr/abi/small_attention.h", "// attention\n")
    write(root / "csrc/common/layout/global_repack.h", "// layout\n")
    write(root / "csrc/common/ops/activation.hpp", "// ops\n")
    write(root / "csrc/common/host/physical_tensor.h", "// host\n")
    write(root / "csrc/kernel_impl/shared/common/kernel_templates.json",
          json.dumps({"entries": [
              {"source": "kernels/a.cu"},
              {"source": "kernels/a.cu"},
              {"source": "kernels/b.cu"},
          ]}))
    write(root / "setup.py", "# build entry point\n")
    write(root / "pyproject.toml", "[project]\nname = 'fixture'\n")
    write(root / "MANIFEST.in", "recursive-include csrc *.cuh\n")
    write(root / "dlssnr/build/native.py", "# build helper\n")
    write_resolution_policy(root)
    return root


def cache_key(root, *, architecture="12.0", build_mode="split", flags=None,
              environment=None):
    if flags is None:
        flags = (*canonical_native.cxx_standard_flags(os.name),
                 *canonical_native.nvcc_standard_flags())
    return canonical_native.build_cache_key(
        root, architecture=architecture, build_mode=build_mode,
        compile_flags=flags, build_environment=environment)


def speed_environment():
    return {name: os.environ[name] for name in ("CUDA_HOME", "DLSSNR_PTXAS_PATH")
            if os.environ.get(name)}


def speed_fingerprint(root):
    return canonical_native.build_cache_key(
        root, architecture="12.0", build_mode="split",
        compile_flags=(*canonical_native.cxx_standard_flags(os.name),
                       *canonical_native.nvcc_standard_flags()),
        build_environment=speed_environment())


def write_speed_receipt(root, binary, *, device_sm=120, fingerprint=None,
                        binary_sha256=None):
    directory = Path(root) / "build/speed/sm120-fixture"
    directory.mkdir(parents=True, exist_ok=True)
    receipt = dict(device_sm=device_sm, architecture="12.0", status="built",
                   built=True, binary_path=str(Path(binary).resolve()))
    if fingerprint is not None:
        receipt["build_fingerprint"] = fingerprint
    if binary_sha256 is not None:
        receipt["binary_sha256"] = binary_sha256
    (directory / "receipt.json").write_text(json.dumps(receipt), encoding="utf8")


class CanonicalCompatibilityTests(unittest.TestCase):
    def test_compatibility_names_bind_the_canonical_objects(self):
        self.assertIs(build_config.CudaTarget, canonical_targets.CudaTarget)
        self.assertIs(build_config.parse_targets, canonical_targets.parse_targets)
        self.assertIs(build_config.library_targets, canonical_targets.library_targets)
        self.assertIs(cuda_toolchain.CudaAssemblerSelection,
                      canonical_toolchain.CudaAssemblerSelection)
        self.assertIs(cuda_toolchain.prepare_cuda_assembler,
                      canonical_toolchain.prepare_cuda_assembler)
        self.assertIs(cuda_toolchain._sha256, canonical_toolchain._sha256)
        for name in ("canonical", "require", "integer", "digest", "key", "validate",
                     "combine", "verify_receipts", "version", "lookup", "cpp_header"):
            self.assertIs(getattr(resolution_policy, name),
                          getattr(canonical_resolution, name), name)
        self.assertEqual(resolution_policy.BOUNDS, canonical_resolution.BOUNDS)
        self.assertEqual(resolution_policy.CPP, canonical_resolution.CPP)
        for name in ("read", "write", "policy_files", "load_geometry", "axis_runs",
                     "enumerate_plan", "resume_plan", "main"):
            self.assertIs(getattr(resolution_cli, name),
                          getattr(canonical_cli, name), name)
        self.assertIs(resolution_cli.P, canonical_resolution)
        self.assertEqual(resolution_cli.HERE, canonical_cli.HERE)
        self.assertEqual(resolution_cli.GEOMETRY, canonical_cli.GEOMETRY)
        self.assertEqual(canonical_cli.HERE, ROOT / "tuning")
        self.assertEqual(canonical_cli.GEOMETRY, ROOT / "dlssnr/geometry.py")

    def test_speed_build_is_a_transparent_canonical_alias(self):
        legacy = importlib.import_module("tools.speed_build")
        canonical = importlib.import_module("dlssnr.build.speed")
        self.assertIs(legacy, canonical)
        for name in ("_probe_extension", "_find_vcvarsall", "_windows_build_environment",
                     "_build_environment", "_stop_build", "_run_build", "_print_progress"):
            self.assertIs(getattr(legacy, name), getattr(canonical, name), name)
        self.assertIs(legacy._binary, importlib.import_module("dlssnr._binary"))
        self.assertEqual(legacy.ROOT, ROOT)

    def test_canonical_modules_do_not_import_tuning_or_tools(self):
        for path in sorted((ROOT / "dlssnr/build").glob("*.py")):
            source = path.read_text(encoding="utf8")
            self.assertNotIn("sys.path", source, path.name)
            for node in ast.walk(ast.parse(source, filename=str(path))):
                if isinstance(node, ast.Import):
                    modules = [alias.name for alias in node.names]
                elif isinstance(node, ast.ImportFrom):
                    modules = [node.module or ""]
                else:
                    continue
                for module in modules:
                    self.assertFalse(module == "tuning" or module.startswith("tuning."),
                                     f"{path.name} imports {module}")
                    self.assertFalse(module == "tools" or module.startswith("tools."),
                                     f"{path.name} imports {module}")


class ImportSafetyTests(unittest.TestCase):
    def test_importing_dlssnr_build_has_no_side_effects(self):
        code = r'''
import os
import subprocess
import sys

before_environment = dict(os.environ)


def forbidden(*args, **kwargs):
    raise AssertionError("dlssnr.build imported a module that ran a subprocess")


subprocess.Popen = forbidden
subprocess.run = forbidden
subprocess.call = forbidden
subprocess.check_call = forbidden
subprocess.check_output = forbidden


class BlockTorch:
    def find_spec(self, name, path=None, target=None):
        if name == "torch" or name.startswith("torch."):
            raise AssertionError("dlssnr.build queried/imported torch")
        return None


sys.meta_path.insert(0, BlockTorch())
import dlssnr.build
from dlssnr.build import cli, native, resolution, speed, targets, toolchain

for name in dlssnr.build.__all__:
    getattr(dlssnr.build, name)

assert "tuning" not in sys.modules, "canonical build imported tuning"
assert "tools" not in sys.modules, "canonical build imported tools"
assert dict(os.environ) == before_environment, "canonical build changed the environment"
print("import-safe")
'''
        with tempfile.TemporaryDirectory() as directory:
            environment = dict(os.environ)
            environment["PYTHONPATH"] = os.pathsep.join(
                [str(ROOT), environment.get("PYTHONPATH", "")]).rstrip(os.pathsep)
            environment["PYTHONDONTWRITEBYTECODE"] = "1"
            result = subprocess.run(
                [sys.executable, "-B", "-c", code], cwd=directory, env=environment,
                capture_output=True, text=True, timeout=60)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("import-safe", result.stdout)
            self.assertEqual(list(Path(directory).iterdir()), [])


class NativeDiscoveryTests(unittest.TestCase):
    def test_nested_sources_headers_and_generated_tables_are_enumerated(self):
        with tempfile.TemporaryDirectory() as directory:
            root = make_native_tree(directory)
            relative = lambda paths: [path.relative_to(root).as_posix() for path in paths]
            self.assertEqual(relative(canonical_native.cuda_sources(root)),
                             ["csrc/kernel_impl/a.cu", "csrc/kernel_impl/nested/b.cu"])
            self.assertEqual(relative(canonical_native.host_sources(root)), [
                "csrc/kernel_launcher/launcher.cpp", "csrc/torch_api/extension.cpp"])
            self.assertEqual(canonical_native.expected_cuda_units(root), 82)
            self.assertEqual(canonical_native.include_directories(root),
                             (str(root / "csrc"), str(root / "csrc/include")))
            headers = relative(canonical_native.native_headers(root))
            for expected in (
                    "csrc/include/flashlight/arch/async.cuh",
                    "csrc/include/flashlight/core.cuh",
                    "csrc/include/dlssnr/abi/kernel_parameters.h",
                    "csrc/include/dlssnr/abi/small_attention.h",
                    "csrc/common/layout/global_repack.h",
                    "csrc/common/ops/activation.hpp",
                    "csrc/common/host/physical_tensor.h"):
                self.assertIn(expected, headers)
            self.assertNotIn("csrc/kernel_launcher/table.inl", headers)
            dependencies = relative(canonical_native.native_dependencies(root))
            self.assertIn("csrc/kernel_launcher/table.inl", dependencies)
            self.assertIn("csrc/kernel_impl/shared/common/kernel_templates.json", dependencies)
            inputs = relative(canonical_native.build_inputs(root))
            for expected in (
                    "setup.py", "pyproject.toml", "MANIFEST.in",
                    "dlssnr/build/native.py", "tuning/sm_120.json", "evidence.json"):
                self.assertIn(expected, inputs)
            self.assertFalse((root / "build").exists())

    def test_nested_header_source_and_configuration_changes_invalidate_cache_key(self):
        with tempfile.TemporaryDirectory() as directory:
            root = make_native_tree(directory)
            key = cache_key(root)
            for relative in (
                    "csrc/include/flashlight/arch/async.cuh",
                    "csrc/include/dlssnr/abi/kernel_parameters.h",
                    "csrc/common/layout/global_repack.h",
                    "csrc/kernel_impl/nested/b.cu",
                    "csrc/kernel_launcher/table.inl",
                    "csrc/kernel_impl/shared/common/kernel_templates.json",
                    "setup.py",
                    "dlssnr/build/native.py",
                    "tuning/sm_120.json",
                    "evidence.json"):
                with self.subTest(relative=relative):
                    path = root / relative
                    original = path.read_bytes()
                    path.write_bytes(original + b"\n// changed\n")
                    changed = cache_key(root)
                    self.assertNotEqual(changed, key)
                    path.write_bytes(original)
                    self.assertEqual(cache_key(root), key)
            self.assertNotEqual(cache_key(root, architecture="8.9"), key)
            self.assertNotEqual(cache_key(root, build_mode="fat"), key)
            self.assertNotEqual(cache_key(root, flags=("-std=c++20",)), key)
            self.assertNotEqual(cache_key(root, environment={"CUDA_HOME": "/a"}), key)
            self.assertNotEqual(cache_key(root, environment={"CUDA_HOME": "/a"}),
                                cache_key(root, environment={"CUDA_HOME": "/b"}))
            self.assertFalse((root / "build").exists())


class SpeedReuseProvenanceTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = make_native_tree(self.directory.name)
        self.binary = self.root / "_C_sm120.pyd"
        self.binary.write_bytes(b"fake native image")
        self.torch = SimpleNamespace(cuda=SimpleNamespace(
            is_available=lambda: True,
            get_device_capability=lambda device: (12, 0)))
        canonical_resolution.prepare_policy_header(self.root)
        self.fingerprint = speed_fingerprint(self.root)

    def _reuse(self):
        with patch.dict(sys.modules, {"torch": self.torch}), \
                patch.object(canonical_speed._binary, "extension_path",
                             return_value=str(self.binary)), \
                patch.object(canonical_speed, "_probe_extension",
                             return_value=[120]):
            return canonical_speed.ensure_extension(root=self.root, progress=None)

    def _rebuild(self, build=None, force=False):
        runner = (patch.object(canonical_speed, "_run_build", side_effect=build)
                  if build is not None else
                  patch.object(canonical_speed, "_run_build", return_value=0))
        with patch.dict(sys.modules, {"torch": self.torch}), \
                patch.object(canonical_speed._binary, "extension_path",
                             side_effect=[str(self.binary), str(self.binary)]), \
                patch.object(canonical_speed, "_probe_extension",
                             return_value=[120]), \
                patch.object(canonical_speed, "_build_environment",
                             return_value=({}, {})), \
                runner:
            return canonical_speed.ensure_extension(
                root=self.root, rebuild=force, progress=None)

    def test_matching_receipt_verifies_reuse_without_claiming_build(self):
        digest = hashlib.sha256(self.binary.read_bytes()).hexdigest()
        write_speed_receipt(self.root, self.binary, fingerprint=self.fingerprint,
                            binary_sha256=digest)
        result = self._reuse()
        self.assertFalse(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "verified")
        self.assertEqual(result.receipt["reuse"]["build_fingerprint"],
                         self.fingerprint)
        self.assertEqual(result.receipt["source_fingerprint"], self.fingerprint)
        self.assertNotIn("build_fingerprint", result.receipt)

    def test_stale_fingerprint_forces_rebuild(self):
        write_speed_receipt(self.root, self.binary, fingerprint="0" * 64)
        result = self._rebuild()
        self.assertTrue(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "stale")
        self.assertIn("different native sources", result.receipt["reuse_failure"])
        self.assertEqual(result.receipt["build_fingerprint"], self.fingerprint)
        self.assertEqual(result.receipt["source_fingerprint"], self.fingerprint)

    def test_binary_hash_mismatch_forces_rebuild(self):
        write_speed_receipt(self.root, self.binary, fingerprint=self.fingerprint,
                            binary_sha256="0" * 64)
        result = self._rebuild()
        self.assertTrue(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "stale")
        self.assertIn("binary SHA256 differs", result.receipt["reuse_failure"])

    def test_legacy_receipt_reuses_with_explicit_unknown_provenance(self):
        write_speed_receipt(self.root, self.binary)
        result = self._reuse()
        self.assertFalse(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "unverified")
        self.assertIn("legacy receipt", result.receipt["reuse"]["reason"])
        self.assertNotIn("build_fingerprint", result.receipt)

    def test_missing_receipt_reuses_with_explicit_unknown_provenance(self):
        result = self._reuse()
        self.assertFalse(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "unverified")
        self.assertIn("no persisted build receipt", result.receipt["reuse"]["reason"])
        self.assertNotIn("build_fingerprint", result.receipt)

    def test_no_sha_receipt_with_matching_fingerprint_is_unverified(self):
        write_speed_receipt(self.root, self.binary, fingerprint=self.fingerprint)
        result = self._reuse()
        self.assertFalse(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "unverified")
        self.assertIn("no binary SHA256", result.receipt["reuse"]["reason"])
        # The current checkout fingerprint stays on the current receipt, but the
        # reuse evidence must not present it as the binary's recorded build.
        self.assertNotIn("build_fingerprint", result.receipt["reuse"])
        self.assertNotIn("build_fingerprint", result.receipt)
        self.assertEqual(result.receipt["source_fingerprint"], self.fingerprint)

    def test_altered_binary_bytes_force_rebuild(self):
        original_digest = hashlib.sha256(self.binary.read_bytes()).hexdigest()
        write_speed_receipt(self.root, self.binary, fingerprint=self.fingerprint,
                            binary_sha256=original_digest)
        self.binary.write_bytes(b"altered native image")
        result = self._rebuild()
        self.assertTrue(result.built)
        self.assertEqual(result.receipt["reuse"]["status"], "stale")
        self.assertIn("binary SHA256 differs", result.receipt["reuse_failure"])

    def test_policy_changed_header_is_refreshed_before_fingerprint(self):
        header = self.root / canonical_resolution.POLICY_HEADER
        stale_header = header.read_bytes()
        write_resolution_policy(self.root, state="runtime_qualified")
        self.assertEqual(header.read_bytes(), stale_header)

        def refresh(*args, **kwargs):
            canonical_resolution.prepare_policy_header(self.root)
            return 0

        result = self._rebuild(refresh, force=True)

        self.assertTrue(result.built)
        self.assertNotEqual(header.read_bytes(), stale_header)
        self.assertEqual(result.receipt["build_fingerprint"],
                         result.receipt["source_fingerprint"])

    def test_unchanged_policy_header_keeps_its_timestamp(self):
        header = self.root / canonical_resolution.POLICY_HEADER
        first = header.stat().st_mtime_ns
        first_bytes = header.read_bytes()
        canonical_resolution.prepare_policy_header(self.root)
        self.assertEqual(header.stat().st_mtime_ns, first)
        self.assertEqual(header.read_bytes(), first_bytes)

    def test_unexpected_source_change_during_build_rejects_provenance(self):
        source = self.root / "csrc/kernel_impl/nested/b.cu"

        def mutate(*args, **kwargs):
            source.write_bytes(source.read_bytes() + b"// race\n")
            return 0
        with self.assertRaisesRegex(RuntimeError, "changed during the build"):
            self._rebuild(mutate, force=True)
        receipts = sorted((self.root / "build/speed").glob("*/receipt.json"))
        failed = [json.loads(path.read_text(encoding="utf8")) for path in receipts]
        failed = [receipt for receipt in failed if receipt.get("status") == "failed"]
        self.assertTrue(failed)
        self.assertNotIn("build_fingerprint", failed[-1])


class EmptyPolicySetTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name).resolve()

    def _remove_policies(self):
        policies = sorted((self.root / "tuning").glob("sm_*.json"))
        self.assertTrue(policies)
        for policy in policies:
            policy.unlink()

    def test_removing_last_policy_fails_loudly_and_keeps_stale_header(self):
        make_native_tree(self.root)
        header = canonical_resolution.prepare_policy_header(self.root)
        before_bytes = header.read_bytes()
        before_mtime = header.stat().st_mtime_ns
        self.assertIn(b"FResolutionAnchor", before_bytes)
        self._remove_policies()

        with self.assertRaisesRegex(ValueError, "at least one policy required"):
            canonical_resolution.prepare_policy_header(self.root)

        self.assertEqual(header.read_bytes(), before_bytes)
        self.assertEqual(header.stat().st_mtime_ns, before_mtime)
        self.assertFalse((self.root / "build").exists())

    def test_removing_last_policy_stops_reuse_and_build_before_binary_access(self):
        make_native_tree(self.root)
        canonical_resolution.prepare_policy_header(self.root)
        self._remove_policies()
        torch = SimpleNamespace(cuda=SimpleNamespace(
            is_available=lambda: True,
            get_device_capability=lambda device: (12, 0)))

        with patch.dict(sys.modules, {"torch": torch}), \
                patch.object(canonical_speed._binary, "extension_path") as extension_path, \
                patch.object(canonical_speed, "_run_build") as run_build:
            with self.assertRaisesRegex(ValueError, "at least one policy required"):
                canonical_speed.ensure_extension(root=self.root, progress=None)

        extension_path.assert_not_called()
        run_build.assert_not_called()

    def test_native_destination_without_policies_or_header_fails(self):
        (self.root / "csrc/kernel_launcher").mkdir(parents=True)

        with self.assertRaisesRegex(ValueError, "at least one policy required"):
            canonical_resolution.prepare_policy_header(self.root)

        self.assertFalse((self.root / canonical_resolution.POLICY_HEADER).exists())

    def test_root_without_native_destination_or_policies_is_a_noop(self):
        self.assertIsNone(canonical_resolution.prepare_policy_header(self.root))
        self.assertFalse((self.root / "csrc").exists())
        (self.root / "tuning").mkdir()
        self.assertIsNone(canonical_resolution.prepare_policy_header(self.root))
        self.assertFalse((self.root / "csrc").exists())


class SetupMetadataTests(unittest.TestCase):
    def test_pyproject_and_setup_share_dlssnr_pytorch_identity(self):
        pyproject_text = (ROOT / "pyproject.toml").read_text(encoding="utf8")
        if tomllib is None:
            self.assertIn('name = "dlssnr-pytorch"', pyproject_text)
            self.assertIn('version = "0.1.0"', pyproject_text)
            self.assertIn('include = ["dlssnr", "dlssnr.*"]', pyproject_text)
            self.assertIn('exclude = ["tests", "tests.*", "tuning", "tuning.*"]',
                          pyproject_text)
        else:
            project = tomllib.loads(pyproject_text)
            self.assertEqual(project["project"]["name"], "dlssnr-pytorch")
            self.assertEqual(project["project"]["version"], "0.1.0")
            find = project["tool"]["setuptools"]["packages"]["find"]
            self.assertEqual(find["include"], ["dlssnr", "dlssnr.*"])
            self.assertIn("tests", find["exclude"])
            self.assertIn("tuning", find["exclude"])

        source = (ROOT / "setup.py").read_text(encoding="utf8")
        tree = ast.parse(source, filename=str(ROOT / "setup.py"))
        call = next(node for node in ast.walk(tree)
                    if isinstance(node, ast.Call)
                    and isinstance(node.func, ast.Name) and node.func.id == "setup")
        keywords = {keyword.arg: keyword.value for keyword in call.keywords}
        self.assertEqual(ast.literal_eval(keywords["name"]), "dlssnr-pytorch")
        self.assertEqual(ast.literal_eval(keywords["version"]), "0.1.0")
        packages = keywords["packages"]
        self.assertIsInstance(packages, ast.Call)
        self.assertEqual(packages.func.id, "find_packages")
        include = next(keyword.value for keyword in packages.keywords
                       if keyword.arg == "include")
        self.assertEqual(ast.literal_eval(include), ["dlssnr", "dlssnr.*"])

        imported = set()
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                imported.update(alias.name for alias in node.names)
            elif isinstance(node, ast.ImportFrom):
                imported.add(node.module or "")
        self.assertIn("dlssnr.build.native", imported)
        self.assertIn("dlssnr.build.resolution", imported)
        self.assertIn("dlssnr.build.targets", imported)
        self.assertIn("dlssnr.build.toolchain", imported)
        self.assertFalse(any(name == "tuning" or name.startswith("tuning.")
                             for name in imported))

    def test_native_compile_configuration_preserves_cpp17_and_targets(self):
        self.assertEqual(canonical_native.cxx_standard_flags("nt"), ["/std:c++17"])
        self.assertEqual(canonical_native.cxx_standard_flags("posix"), ["-std=c++17"])
        self.assertEqual(canonical_native.nvcc_standard_flags(), ["-std=c++17"])
        target = canonical_targets.CudaTarget(120, True)
        self.assertEqual(target.nvcc_flags, [
            "-gencode=arch=compute_120,code=sm_120",
            "-gencode=arch=compute_120,code=compute_120",
        ])
        source = (ROOT / "setup.py").read_text(encoding="utf8")
        for fragment in ("cuda_sources(ROOT)", "host_sources(ROOT)",
                         "expected_cuda_units(ROOT)", "include_directories(ROOT)",
                         "depends=depends", "cxx_standard_flags(os.name)",
                         "nvcc_standard_flags()", "prepare_policy_header(ROOT)"):
            self.assertIn(fragment, source)

    def test_package_discovery_is_dlssnr_only(self):
        from setuptools import find_packages

        packages = find_packages(where=ROOT, include=["dlssnr", "dlssnr.*"])
        self.assertIn("dlssnr", packages)
        self.assertIn("dlssnr.build", packages)
        self.assertTrue(all(name == "dlssnr" or name.startswith("dlssnr.")
                            for name in packages))
        self.assertNotIn("tests", packages)
        self.assertNotIn("tuning", packages)

    def test_flashlight_and_abi_headers_are_on_the_compiler_path_and_shipped(self):
        include_dirs = canonical_native.include_directories(ROOT)
        self.assertEqual(include_dirs, (str(ROOT / "csrc"), str(ROOT / "csrc/include")))
        self.assertTrue((ROOT / "csrc/include/flashlight/core.cuh").is_file())
        self.assertTrue((ROOT / "csrc/include/dlssnr/abi/kernel_parameters.h").is_file())
        self.assertTrue((ROOT / "csrc/include/dlssnr/abi/small_attention.h").is_file())
        self.assertTrue((ROOT / "csrc/common/layout").is_dir())
        self.assertTrue((ROOT / "csrc/common/ops").is_dir())
        self.assertTrue((ROOT / "csrc/common/host").is_dir())

        manifest = (ROOT / "MANIFEST.in").read_text(encoding="utf8").splitlines()
        csrc_rule = next(line for line in manifest if line.startswith("recursive-include csrc"))
        for pattern in ("*.h", "*.hpp", "*.cuh", "*.inl", "*.cpp", "*.cu", "*.json"):
            self.assertIn(pattern, csrc_rule)
        self.assertIn("prune build", manifest)
        self.assertIn("prune profile", manifest)
        self.assertIn("global-exclude *.py[cod] *.pyd *.so *.obj *.lib *.exp", manifest)

        ignored = (ROOT / ".gitignore").read_text(encoding="utf8").splitlines()
        self.assertIn("!dlssnr/build/", ignored)
        self.assertIn("!dlssnr/build/**", ignored)
        self.assertLess(ignored.index("build/"), ignored.index("!dlssnr/build/"))
        # Cache exclusions must remain effective after the unignore rules.
        self.assertLess(ignored.index("!dlssnr/build/**"),
                        ignored.index("__pycache__/"))


class StandaloneFacadeTests(unittest.TestCase):
    def test_tuning_facades_load_directly_without_root_on_path(self):
        code = r'''
import importlib.util
import sys
from pathlib import Path

def load(name, path):
    spec = importlib.util.spec_from_file_location(name, Path(path))
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module

policy = load("_standalone_policy", sys.argv[1])
targets = load("_standalone_targets", sys.argv[2])
toolchain = load("_standalone_toolchain", sys.argv[3])
cli = load("_standalone_cli", sys.argv[4])
assert targets.parse_targets("12.0")[0].sm == 120
assert callable(toolchain.prepare_cuda_assembler)
empty = dict(schema_version=1, bounds=dict(policy.BOUNDS), distance=policy.DISTANCE,
             unmeasured_config_id=-1, anchors=[], admissions=[])
header = policy.cpp_header(empty)
assert "FResolutionAnchor" in header
assert "FResolutionAdmission" in header
assert cli.HERE.name == "tuning"
assert cli.GEOMETRY.name == "geometry.py"
assert "tuning" not in sys.modules
print("standalone-ok")
'''
        with tempfile.TemporaryDirectory() as directory:
            environment = dict(os.environ)
            environment.pop("PYTHONPATH", None)
            environment.pop("DLSSNR_PTXAS_PATH", None)
            environment["PYTHONDONTWRITEBYTECODE"] = "1"
            result = subprocess.run(
                [sys.executable, "-B", "-c", code,
                 str(ROOT / "tuning/resolution_policy.py"),
                 str(ROOT / "tuning/build_config.py"),
                 str(ROOT / "tuning/cuda_toolchain.py"),
                 str(ROOT / "tuning/resolution_cli.py")],
                cwd=directory, env=environment, capture_output=True, text=True,
                timeout=60)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("standalone-ok", result.stdout)


if __name__ == "__main__":
    unittest.main()
