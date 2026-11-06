"""CPU-only public ownership and import contracts for the Python modularity split.

These checks exercise public identity, orientation and malformed-archive
behavior; they do not mirror private helper implementations, query CUDA, load a
native extension or allocate model-scale tensors.
"""
from __future__ import annotations

import hashlib
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

import torch

import dlssnr.checkpoint as checkpoint
import dlssnr.common.weight_schema as weight_schema
import dlssnr.model as model
import dlssnr.portable_checkpoint as portable_checkpoint
import dlssnr.records as records
import dlssnr.small_deployment as small_deployment
import dlssnr.small_state as small_state
import dlssnr.small_weights as small_weights
import dlssnr.weight_packing as weight_packing
import dlssnr.weights as weights


def _entry(name: str, block: int, layer: int, parameter: str, *, offset: int, length: int) -> dict:
    return dict(name=name, block=block, layer=layer, parameter=parameter,
                stage="s", stageOffset=offset, byteLength=length)


class PackedRecordOwnershipTest(unittest.TestCase):
    def test_one_pure_wire_reader_with_compatibility_alias(self):
        self.assertIs(records.WeightArchive, records.PackedRecordArchive)
        self.assertTrue(issubclass(weights.WeightArchive, records.PackedRecordArchive))
        self.assertIsNot(weights.WeightArchive, records.PackedRecordArchive)
        self.assertFalse(hasattr(records.PackedRecordArchive, "decode_block"))
        self.assertTrue(hasattr(weights.WeightArchive, "decode_block"))

    def test_compatibility_exports_are_the_same_objects(self):
        self.assertIs(weights.TensorRecord, records.TensorRecord)
        self.assertIs(weights.expected_record_names, records.expected_record_names)
        self.assertIs(weights.expected_record_sizes, records.expected_record_sizes)

    def test_shared_reader_rejects_overlapping_records_through_decode_subclass(self):
        payload = b"abcdefgh"
        tensors = [_entry("block1.layer0.layer", 1, 0, "layer", offset=0, length=4),
                   _entry("block2.layer0.layer", 2, 0, "layer", offset=2, length=4)]
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "model").mkdir()
            (root / "model/stage.bin").write_bytes(payload)
            (root / "manifest.json").write_text(json.dumps(dict(
                totals=dict(blockCount=71),
                stages=[dict(id="s", file="stage.bin", packedByteLength=len(payload),
                             sha256=hashlib.sha256(payload).hexdigest())],
                tensors=tensors)), encoding="utf-8")
            for archive_type in (records.PackedRecordArchive, weights.WeightArchive):
                with self.assertRaisesRegex(ValueError, "overlapping"):
                    archive_type(root, require_complete=False)


class MatrixSchemaOwnershipTest(unittest.TestCase):
    def test_one_matrix_field_definition(self):
        self.assertIs(checkpoint.MATRIX_FIELDS, weight_schema.MATRIX_FIELDS)
        self.assertIs(model.MATRIX_FIELDS, weight_schema.MATRIX_FIELDS)

    def test_block_orientation_uses_the_shared_matrix_fields(self):
        for name in weight_schema.MATRIX_FIELDS:
            block = model.NRBlock(0, {name: torch.zeros(2, 3)}, model.Numerics())
            self.assertEqual(tuple(block.get_buffer(name).shape), (3, 2), name)
        block = model.NRBlock(0, {"ffn_scale": torch.zeros(2, 3)}, model.Numerics())
        self.assertEqual(tuple(block.get_buffer("ffn_scale").shape), (2, 3))


class SmallOwnerLayeringTest(unittest.TestCase):
    def test_packing_helpers_have_one_owner_and_checkpoint_aliases(self):
        self.assertIs(checkpoint.FP8, weight_packing.FP8)
        self.assertIs(checkpoint.promote_tensor, weight_packing.promote_tensor)
        self.assertIs(checkpoint.pack_kernel_fp16, weight_packing.pack_kernel_fp16)
        self.assertIs(checkpoint._natural, weight_packing._natural)
        self.assertIs(checkpoint._half_matrix, weight_packing._half_matrix)
        self.assertIs(checkpoint._half_bias, weight_packing._half_bias)
        self.assertIs(checkpoint._bias_indices, weight_packing._bias_indices)

    def test_small_state_and_weight_owners_are_single_objects(self):
        self.assertIs(small_deployment.SmallNativeCheckpoint, small_weights.SmallNativeCheckpoint)
        self.assertIs(portable_checkpoint.SmallNativeCheckpoint, small_weights.SmallNativeCheckpoint)
        self.assertIs(small_state._state_from_archive, small_state.state_from_archive)
        self.assertIs(small_deployment._state_from_archive, small_state.state_from_archive)
        self.assertIs(small_deployment._kind_for_layer, small_state.record_kind_for_layer)
        self.assertIs(small_deployment._layer_for_kind, small_state.layer_for_kind)
        self.assertIs(portable_checkpoint.small31_state_schema,
                      small_state.small31_state_schema)

    def test_portable_import_does_not_import_deployment_or_probe_cuda(self):
        code = (
            "import sys\n"
            "import torch\n"
            "def probe(*args, **kwargs):\n"
            "    raise AssertionError('CUDA probe during serialization import')\n"
            "for name in ('is_available', 'get_device_capability', 'device',\n"
            "             'current_device', 'set_device', 'init', '_lazy_init'):\n"
            "    setattr(torch.cuda, name, probe)\n"
            "import dlssnr.portable_checkpoint\n"
            "assert 'dlssnr.small_deployment' not in sys.modules, sorted(sys.modules)\n"
            "assert 'dlssnr.deployment' not in sys.modules, sorted(sys.modules)\n"
            "assert not [name for name in sys.modules if name.startswith('dlssnr._C')], "
            "sorted(sys.modules)\n"
        )
        completed = subprocess.run([sys.executable, "-B", "-c", code], cwd=ROOT,
                                   capture_output=True, text=True)
        self.assertEqual(completed.returncode, 0, completed.stderr)


class LightCommonImportTest(unittest.TestCase):
    def test_records_and_common_import_without_torch(self):
        code = ("import sys\n"
                "import dlssnr.records, dlssnr.common, dlssnr.common.weight_schema\n"
                "assert 'torch' not in sys.modules, sorted(sys.modules)\n")
        completed = subprocess.run([sys.executable, "-B", "-c", code], cwd=ROOT,
                                   capture_output=True, text=True)
        self.assertEqual(completed.returncode, 0, completed.stderr)


if __name__ == "__main__":
    unittest.main()
