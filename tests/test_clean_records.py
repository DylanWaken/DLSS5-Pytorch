"""CPU-only checks for raw records and the compiled-roster benchmark adapter."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
import types
import unittest

ROOT = Path(__file__).resolve().parents[1]


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


# Test the raw modules without invoking the deployment package initializer or
# loading its extension. This does not spoof any GPU result.
package = types.ModuleType("_clean_records")
package.__path__ = [str(ROOT / "dlssnr")]
sys.modules[package.__name__] = package
G = load("_clean_records.geometry", ROOT / "dlssnr/geometry.py")
W = load("_clean_records.records", ROOT / "dlssnr/records.py")
C = load("_candidate_adapter", ROOT / "tools/reconstructed_candidate.py")


class Tests(unittest.TestCase):
    def fixture(self, root, *, offset=0, length=4, filename="stage.bin", digest=None):
        (root / "model").mkdir()
        (root / "model/stage.bin").write_bytes(b"abcd")
        manifest = dict(totals=dict(blockCount=71), stages=[dict(id="s", file=filename,
            packedByteLength=4, sha256=digest or hashlib.sha256(b"abcd").hexdigest())],
            tensors=[dict(name="block1.layer0.layer", block=1, layer=0, parameter="layer",
                stage="s", stageOffset=offset, byteLength=length)])
        (root / "manifest.json").write_text(json.dumps(manifest))

    def test_pure_import_and_complete_layout(self):
        self.assertNotIn("torch", sys.modules)
        self.assertEqual(len(W.expected_record_names()), 153)
        self.assertEqual(set(W.expected_record_sizes()), W.expected_record_names())
        self.assertFalse(hasattr(W.WeightArchive, "decode_block"))
        self.assertEqual(G.Geometry.from_valid(3840, 2160).levels[5], (60, 36))

    def test_raw_record_and_hash(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); self.fixture(root)
            archive = W.WeightArchive(root, require_complete=False)
            self.assertEqual(bytes(archive.tensor(1).data), b"abcd")
            self.assertTrue(archive.tensor(1).data.readonly)
            (root / "model/stage.bin").write_bytes(b"abce")
            with self.assertRaisesRegex(ValueError, "SHA-256"):
                W.WeightArchive(root, require_complete=False)

    def test_bounds_and_path_escape(self):
        for kwargs in (dict(offset=2), dict(filename="../stage.bin")):
            with tempfile.TemporaryDirectory() as tmp:
                root = Path(tmp); self.fixture(root, **kwargs)
                with self.assertRaises(ValueError):W.WeightArchive(root, require_complete=False)

    def test_complete_required(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); self.fixture(root)
            with self.assertRaises(ValueError):W.WeightArchive(root)

    def test_compiled_order_retention_and_no_early_allocation(self):
        archive = types.SimpleNamespace(records={"a":types.SimpleNamespace(data=b"ab"), "b":types.SimpleNamespace(data=b"xyz")})
        state = types.SimpleNamespace(device="fake")
        calls = []
        class Plan:
            def run_fp8(self):return b"output"
            def boundary_names(self):return ["block-1", "block-2"]
            def boundaries(self):return [b"a", b"b"]
        class API:
            def record_names_fp8(self):return ["b", "a"]
            def record_bytes_fp8(self):return [3, 2]
            def create_plan_fp8(self, given, records):
                if given is not state or records != [b"xyz", b"ab"]:raise AssertionError("order")
                return Plan()
        api = API()
        candidate = C.create_candidate(api, archive, state, lambda raw, device:(calls.append(raw) or raw))
        self.assertEqual(calls, [b"xyz", b"ab"])
        self.assertEqual(candidate.run(), b"output")
        self.assertEqual(candidate.retained_outputs, [b"output"])
        for _ in range(100):candidate.run()
        self.assertEqual(candidate.retained_outputs, [b"output"])
        self.assertTrue(candidate.compare({"block-1":b"a", "block-2":b"b"}, lambda a,b:a==b)["all_byte_exact"])
        with self.assertRaises(AssertionError):candidate.compare({"block-1":b"a", "block-2":b"stale"}, lambda a,b:a==b)
        calls.clear();api.record_bytes_fp8 = lambda:[3, 4]
        with self.assertRaises(ValueError):C.create_candidate(api, archive, state, lambda raw, device:calls.append(raw))
        self.assertEqual(calls, [])

    def test_duplicate_compiled_roster_rejected(self):
        api=types.SimpleNamespace(record_names_fp8=lambda:["a", "a"], record_bytes_fp8=lambda:[1, 1])
        with self.assertRaises(ValueError):C.packed_records(api, types.SimpleNamespace(records={}))


if __name__ == "__main__":unittest.main()
