"""Focused CPU regressions for portable Small31 checkpoint metadata integrity.

These tests do not allocate a training/deployment model and do not touch CUDA.
Tests whose docstring says ``real artifact`` load the genuine committed
``ckpts/dlss5_nr_small31.pt`` and skip only when that artifact is absent.  The
selection, save-path, and learned-FP8 contracts always run without any asset.
"""
from __future__ import annotations

import copy
import hashlib
import importlib.util
import shutil
import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

import torch

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from dlssnr.checkpoint import load_checkpoint
from dlssnr.model_specs import SMALL31
from dlssnr.portable_checkpoint import SmallCheckpoint, save_checkpoint_payload
from dlssnr.trained_checkpoint import export_trained_checkpoint

REAL_CHECKPOINT = ROOT / "ckpts" / "dlss5_nr_small31.pt"
REAL_CHECKPOINT_PRESENT = REAL_CHECKPOINT.is_file()
needs_real_checkpoint = unittest.skipUnless(
    REAL_CHECKPOINT_PRESENT,
    "genuine ckpts/dlss5_nr_small31.pt is absent; resource-dependent test skipped")


def real_payload():
    if not REAL_CHECKPOINT_PRESENT:
        raise unittest.SkipTest("genuine ckpts/dlss5_nr_small31.pt is absent")
    return torch.load(REAL_CHECKPOINT, map_location="cpu", weights_only=True, mmap=True)


def with_copied_metadata(payload):
    """Copy only metadata; the immutable record tensors are shared and untouched."""
    mutated = dict(payload)
    mutated["metadata"] = copy.deepcopy(payload["metadata"])
    return mutated


class SelectionAndSaveContractCPUTest(unittest.TestCase):
    """No-asset tests; these must run on every CPU checkout."""

    def test_reference_loader_always_verifies_hashes(self):
        spec = importlib.util.spec_from_file_location(
            "_validate_portable_checkpoint", ROOT / "tools" / "validate_portable_checkpoint.py")
        runner = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(runner)

        checkpoint = ROOT / "reference.pt"
        args = SimpleNamespace(archive=checkpoint, model="legacy71")
        with patch("dlssnr.checkpoint.load_checkpoint", return_value=object()) as loader:
            runner.load_reference(args, torch)
        loader.assert_called_once_with(checkpoint, model="legacy71", verify_hash=True)

        with tempfile.TemporaryDirectory() as directory:
            args = SimpleNamespace(archive=Path(directory), model="small31")
            with patch("dlssnr.small_deployment.load_native_model",
                       return_value=object()) as loader:
                runner.load_reference(args, torch)
            loader.assert_called_once_with(Path(directory), model="small31", verify_hash=True)

    def test_wrong_and_default_model_selection_is_explicit(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            small = root / "small31.pt"
            torch.save({"format_version": 3, "model": "small31"}, small)
            for model in ("legacy71",):
                with self.subTest(version=3, model=model), self.assertRaisesRegex(
                        ValueError, "select model='small31'"):
                    load_checkpoint(small, model=model, verify_hash=True)
            with self.assertRaisesRegex(ValueError, "select model='small31'"):
                load_checkpoint(small, verify_hash=True)

            legacy = root / "legacy71.pt"
            torch.save({"format_version": 2, "model": "legacy71"}, legacy)
            with self.assertRaisesRegex(ValueError, "select model='legacy71'"):
                load_checkpoint(legacy, model="small31", verify_hash=True)

            wrong = root / "wrong.pt"
            torch.save({"format_version": 3, "model": "legacy71"}, wrong)
            with self.assertRaisesRegex(ValueError, "small31"):
                load_checkpoint(wrong, model="small31", verify_hash=True)

    def test_save_to_json_sidecar_path_rejects_without_files(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "checkpoint.json"
            # No model allocation: the destination policy is independent of the
            # payload owner.  The patched owner only proves the path check fires
            # before any serialization work.
            with patch("dlssnr.portable_checkpoint._payload_owner", return_value="small31"):
                with self.assertRaises(ValueError):
                    save_checkpoint_payload({"format_version": 3}, target)
            self.assertFalse(target.exists())
            self.assertEqual(list(Path(directory).iterdir()), [])

    def test_learned_fp8_rejection_is_the_intended_value_error(self):
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "learned_fp8.pt"
            with self.assertRaisesRegex(ValueError, "learned FP8 export is unsupported"):
                export_trained_checkpoint(object(), target, precision="fp8")
            self.assertFalse(target.exists())
            self.assertFalse(target.with_suffix(".json").exists())
            self.assertEqual(list(Path(directory).iterdir()), [])


@needs_real_checkpoint
class PortableMetadataIntegrityCPUTest(unittest.TestCase):
    """Real-artifact tests; each loads only validated records/state, no model."""

    def test_nonzero_canonical_stage_offsets_are_preserved(self):
        """real artifact: TensorRecord.stage_offset is the canonical stage position."""
        checkpoint = SmallCheckpoint(real_payload())
        self.assertEqual(len(checkpoint.archive.records), SMALL31.record_count)
        canonical = SMALL31.stage_record_offsets()
        for name in ("block1.layer0.layer", "block30.layer0.blend_scale",
                     "block30.layer0.layer"):
            with self.subTest(name=name):
                record = checkpoint.archive.records[name]
                self.assertGreater(record.stage_offset, 0)
                self.assertEqual(record.stage_offset, canonical[record.stage][name])

    def test_embedded_source_resource_and_roster_metadata_is_checked(self):
        """real artifact: every canonical manifest edit is rejected before decode."""
        mutations = {
            "source dll hash": ("source", "dllSha256", "0" * 64),
            "resource hash": ("source-resource", "sha256", "0" * 64),
        }
        for label, (section, key, value) in mutations.items():
            with self.subTest(label=label):
                payload = with_copied_metadata(real_payload())
                manifest = payload["metadata"]["archive_manifest"]
                target = manifest["source"]["resource"] if section == "source-resource" else manifest[section]
                target[key] = value
                with self.assertRaises(ValueError):
                    SmallCheckpoint(payload)

        payload = with_copied_metadata(real_payload())
        payload["metadata"]["archive_manifest"]["model"]["roles"][0] = 999
        with self.assertRaises(ValueError):
            SmallCheckpoint(payload)

        payload = with_copied_metadata(real_payload())
        payload["metadata"]["archive_manifest"]["stages"][0]["roles"][0] = 999
        with self.assertRaises(ValueError):
            SmallCheckpoint(payload)

        payload = with_copied_metadata(real_payload())
        tensors = payload["metadata"]["archive_manifest"]["tensors"]
        self.assertEqual(tensors[1]["stageOffset"], 21696)
        tensors[1]["stageOffset"] = 0
        with self.assertRaises(ValueError):
            SmallCheckpoint(payload)

        payload = with_copied_metadata(real_payload())
        payload["metadata"]["archive_manifest"]["tensors"][0]["role"] = 999
        with self.assertRaises(ValueError):
            SmallCheckpoint(payload)

    def test_native_record_bytes_are_consistent_with_hash_and_stage_pins(self):
        """real artifact: record bytes are anchored by both hashes and stage pins."""
        name = "block1.layer0.layer"
        original = real_payload()
        record = original["native_records"][name]
        mutated_bytes = record.clone()
        mutated_bytes[0] ^= 0xFF

        payload = dict(original)
        payload["native_records"] = dict(original["native_records"])
        payload["native_records"][name] = mutated_bytes
        with self.assertRaisesRegex(ValueError, "hash mismatch"):
            SmallCheckpoint(payload)

        # Updating the per-record hash cannot hide changed bytes: the rebuilt
        # stage must still match the trusted canonical stage pin.
        payload = dict(original)
        payload["native_records"] = dict(original["native_records"])
        payload["native_records"][name] = mutated_bytes
        payload["metadata"] = copy.deepcopy(original["metadata"])
        payload["metadata"]["native_record_sha256"][name] = hashlib.sha256(
            mutated_bytes.numpy().tobytes()).hexdigest()
        with self.assertRaises(ValueError):
            SmallCheckpoint(payload)

    def test_public_load_from_fresh_copy_never_opens_an_archive(self):
        """real artifact: a fresh .pt copy loads without archive/DLL access."""
        with tempfile.TemporaryDirectory() as directory:
            copied = Path(directory) / "fresh_copy.pt"
            shutil.copyfile(REAL_CHECKPOINT, copied)
            with patch("dlssnr.small_model.SmallWeightArchive.__init__",
                       side_effect=AssertionError("archive opened for a self-contained .pt")):
                loaded = load_checkpoint(copied, model="small31", verify_hash=True)
            self.assertIsInstance(loaded, SmallCheckpoint)
            self.assertEqual(loaded.precision, "fp8")
            self.assertEqual(len(loaded.archive.records), SMALL31.record_count)

    def test_public_load_verifies_a_present_sidecar(self):
        """real artifact: the normal verified loader still rejects a bad sidecar."""
        sidecar = REAL_CHECKPOINT.with_suffix(".json")
        if not sidecar.is_file():
            self.skipTest("genuine checkpoint sidecar is absent")
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            copied = root / REAL_CHECKPOINT.name
            shutil.copyfile(REAL_CHECKPOINT, copied)
            shutil.copyfile(sidecar, copied.with_suffix(".json"))
            self.assertIsInstance(load_checkpoint(copied, model="small31", verify_hash=True),
                                  SmallCheckpoint)
            manifest = copied.with_suffix(".json")
            manifest.write_text('{"sha256": "' + "0" * 64 + '"}\n', encoding="utf8")
            with self.assertRaisesRegex(ValueError, "SHA-256 mismatch"):
                load_checkpoint(copied, model="small31", verify_hash=True)


if __name__ == "__main__":
    unittest.main()
