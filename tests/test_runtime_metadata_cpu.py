"""CPU-only contracts for canonical runtime metadata and generator consumers.

Covers the single precision/hash owners, model-registry-derived names, explicit
role/spatial-level semantics, the separate native-32 and training-64 token
policies, generator census strictness, direct-script imports and checkpoint
identity rejection.  No CUDA context, native extension load or file generation.
"""
from __future__ import annotations

import hashlib
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
TUNING = ROOT / "tuning"
for entry in (str(ROOT), str(TUNING)):
    if entry not in sys.path:
        sys.path.insert(0, entry)

import dlssnr.checkpoint as checkpoint
import dlssnr.common.hashing as hashing
import dlssnr.common.precision as precision
import dlssnr.common.weight_schema as weight_schema
import dlssnr.diagnostics.provenance as provenance
import dlssnr.frontend.layout as layout
import dlssnr.frontend.pipeline as pipeline
import dlssnr.geometry as geometry
import dlssnr.model_specs as model_specs
import dlssnr.portable_checkpoint as portable_checkpoint
import dlssnr.small_deployment as small_deployment
import dlssnr.small_state as small_state
import dlssnr.small_weights as small_weights
import generate_plan
import physical_schedule


class PrecisionOwnerTest(unittest.TestCase):
    def test_one_precision_owner_and_same_object_aliases(self):
        self.assertIs(layout.NATIVE_PRECISIONS, precision.NATIVE_PRECISIONS)
        self.assertIs(small_weights.NATIVE_PRECISIONS, precision.NATIVE_PRECISIONS)
        self.assertIs(small_deployment.NATIVE_PRECISIONS, precision.NATIVE_PRECISIONS)
        self.assertIs(layout.resolve_precision, precision.resolve_precision)
        self.assertIs(layout.element_bytes, precision.element_bytes)
        self.assertEqual(precision.NATIVE_PRECISIONS, ("fp8", "fp16"))
        self.assertEqual([precision.element_bytes(p) for p in precision.NATIVE_PRECISIONS],
                         [1, 2])
        for bad in ("fp32", "FP16", "", None, "bf16"):
            with self.assertRaisesRegex(ValueError, "unsupported precision"):
                precision.resolve_precision(bad)
            with self.assertRaisesRegex(ValueError, "unsupported precision"):
                layout.resolve_precision(bad)

    def test_public_validation_messages_are_preserved(self):
        with self.assertRaisesRegex(ValueError, "unsupported deployment precision"):
            physical_schedule.make(1280, 720, precision="fp32")
        with self.assertRaisesRegex(ValueError, "deployment record precision must be fp8 or fp16"):
            small_deployment._create_small_plan(
                None, SimpleNamespace(device=None), precision="fp32")
        owner = checkpoint.Checkpoint.__new__(checkpoint.Checkpoint)
        owner.precision = "fp8"
        with self.assertRaisesRegex(ValueError, "Deployment record precision must be fp8 or fp16"):
            owner.kernel_record(1, precision="fp32")
        with self.assertRaisesRegex(ValueError, "Expected DLSSNR checkpoint format 2"):
            checkpoint.Checkpoint({"format_version": 2, "weight_precision": "fp32"})
        with self.assertRaisesRegex(ValueError, "Small31 checkpoint precision must be fp8 or fp16"):
            portable_checkpoint.SmallCheckpoint({
                "format_version": 3,
                "model": portable_checkpoint.MODEL_ID,
                "model_class": portable_checkpoint.MODEL_CLASS,
                "weight_precision": "fp32",
            })

    def test_precision_metadata_imports_without_torch_or_numpy(self):
        code = ("import sys\n"
                "import dlssnr.common.precision, dlssnr.common.hashing\n"
                "assert 'torch' not in sys.modules, sorted(sys.modules)\n"
                "assert 'numpy' not in sys.modules, sorted(sys.modules)\n"
                "assert dlssnr.common.precision.element_bytes('fp16') == 2\n")
        completed = subprocess.run([sys.executable, "-B", "-c", code], cwd=ROOT,
                                   capture_output=True, text=True)
        self.assertEqual(completed.returncode, 0, completed.stderr)


class WeightSchemaOwnerTest(unittest.TestCase):
    def test_c1024_c512_layer_kinds_have_one_owner_and_derived_reverse_maps(self):
        # Expected values are independent literals, not imports from the table.
        self.assertEqual(weight_schema.LAYER_FOR_C1024_KIND,
                         {"expand": 0, "contract": 1, "qkv": 2, "projection": 4})
        self.assertEqual(weight_schema.LAYER_FOR_C512_KIND,
                         {"ffn": 0, "ffn_projection": 1, "qkv": 2,
                          "projection": 3, "down": 4})
        self.assertEqual(weight_schema.KIND_FOR_C1024_LAYER,
                         {0: "expand", 1: "contract", 2: "qkv", 4: "projection"})
        self.assertEqual(weight_schema.KIND_FOR_C512_LAYER,
                         {0: "ffn", 1: "ffn_projection", 2: "qkv",
                          3: "projection", 4: "down"})
        # Small's private compatibility aliases are the canonical objects.
        self.assertIs(small_state._LAYER_FOR_C1024_KIND,
                      weight_schema.LAYER_FOR_C1024_KIND)
        self.assertIs(small_state._LAYER_FOR_C512_KIND,
                      weight_schema.LAYER_FOR_C512_KIND)
        for layer, kind in weight_schema.KIND_FOR_C1024_LAYER.items():
            self.assertEqual(weight_schema.LAYER_FOR_C1024_KIND[kind], layer)
        for layer, kind in weight_schema.KIND_FOR_C512_LAYER.items():
            self.assertEqual(weight_schema.LAYER_FOR_C512_KIND[kind], layer)

    def test_weight_schema_imports_without_torch_or_numpy(self):
        code = ("import sys\n"
                "import dlssnr.common.weight_schema as schema\n"
                "assert 'torch' not in sys.modules, sorted(sys.modules)\n"
                "assert 'numpy' not in sys.modules, sorted(sys.modules)\n"
                "assert schema.MATRIX_FIELDS == frozenset(('w1', 'w2', 'w3', 'w4', "
                "'qkv', 'projection', 'input_adapter', 'head', 'up_projection', "
                "'down_projection'))\n"
                "assert schema.KIND_FOR_C512_LAYER[4] == 'down'\n")
        completed = subprocess.run([sys.executable, "-B", "-c", code], cwd=ROOT,
                                   capture_output=True, text=True)
        self.assertEqual(completed.returncode, 0, completed.stderr)


class HashingOwnerTest(unittest.TestCase):
    def test_one_hash_implementation_with_compatibility_reexports(self):
        self.assertIs(provenance.sha256_bytes, hashing.sha256_bytes)
        self.assertIs(provenance.sha256_array, hashing.sha256_array)
        self.assertIs(provenance.sha256_file, hashing.sha256_file)
        self.assertIs(layout.sha256_array, hashing.sha256_array)
        self.assertIs(checkpoint.file_sha256, hashing.sha256_file)
        self.assertIs(portable_checkpoint.file_sha256, hashing.sha256_file)
        self.assertEqual(hashing.sha256_bytes(b"abc"), hashlib.sha256(b"abc").hexdigest())
        self.assertEqual(hashing.sha256_array(np.array([[1, 2], [3, 4]], dtype=np.uint8)),
                         hashing.sha256_bytes(np.array([[1, 2], [3, 4]], dtype=np.uint8).tobytes()))

    def test_file_digest_is_chunk_independent(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "payload.bin"
            path.write_bytes(bytes(range(256)) * 37)
            expected = hashing.sha256_bytes(path.read_bytes())
            self.assertEqual(hashing.sha256_file(path), expected)
            self.assertEqual(hashing.sha256_file(path, chunk=7), expected)


class ModelRegistryTest(unittest.TestCase):
    def test_model_names_and_identity_consumers_derive_from_the_registry(self):
        self.assertEqual(model_specs.MODEL_NAMES, ("legacy71", "small31"))
        self.assertEqual(model_specs.MODEL_NAMES, tuple(model_specs.MODEL_SPECS))
        self.assertIs(pipeline.MODEL_NAMES, model_specs.MODEL_NAMES)
        self.assertEqual(portable_checkpoint.MODEL_ID, model_specs.SMALL31.id)
        self.assertEqual(checkpoint.Checkpoint.model, model_specs.LEGACY71.id)
        self.assertEqual(small_weights.SmallNativeCheckpoint.model, model_specs.SMALL31.id)
        self.assertEqual(portable_checkpoint.SmallCheckpoint.model, model_specs.SMALL31.id)
        self.assertEqual(model_specs.LEGACY71.retained_roles,
                         tuple(role for role in range(71) if role not in (0, 70)))
        with self.assertRaisesRegex(ValueError, "unknown model"):
            model_specs.resolve_model("legacy_71")

    def test_cross_model_payload_rejection(self):
        with self.assertRaisesRegex(ValueError, "expected 'small31'"):
            portable_checkpoint._payload_owner({"format_version": 3, "model": "legacy71"})
        with self.assertRaisesRegex(ValueError, "expected 'legacy71'"):
            portable_checkpoint._payload_owner({"format_version": 2, "model": "small31"})


class GeometryRoleLevelTest(unittest.TestCase):
    def test_role_levels_cover_every_retained_role(self):
        for role in range(1, 70):
            self.assertEqual(geometry.role_spatial_level(role),
                             geometry.level_for_channels(geometry.block_channels(role)))
            self.assertEqual(geometry.channels_for_level(geometry.role_spatial_level(role)),
                             geometry.block_channels(role))
        self.assertEqual(geometry.role_frame_level(0), geometry.FULL_FRAME_LEVEL)
        self.assertEqual(geometry.role_frame_level(70), geometry.FULL_FRAME_LEVEL)
        with self.assertRaisesRegex(ValueError, "retained spatial role"):
            geometry.role_spatial_level(0)

    def test_repack_and_transition_levels(self):
        self.assertEqual(geometry.repack_input_level(31), geometry.WINDOW_LEVEL)   # b30.down is 512/level 4
        self.assertEqual(geometry.repack_output_level(31), geometry.TOKEN_LEVEL)   # 1024 tokens/level 5
        self.assertEqual(geometry.repack_input_level(39), geometry.TOKEN_LEVEL)    # b38.output is 1024/level 5
        self.assertEqual(geometry.repack_output_level(39), geometry.TOKEN_LEVEL)   # repack field is still level 5
        self.assertEqual(geometry.role_spatial_level(39), geometry.WINDOW_LEVEL)   # transition record is 512/level 4
        with self.assertRaisesRegex(ValueError, "mandatory token repack"):
            geometry.repack_input_level(30)

    def test_graph_schedule_preserves_original_full_frame_and_phase_rows(self):
        shape = geometry.Geometry.from_valid(3840, 2160)
        rows = geometry.graph_schedule(shape)
        self.assertEqual(len(rows), 71)
        self.assertEqual((rows[0]["width"], rows[0]["height"]),
                         (shape.full_width, shape.full_height))
        self.assertEqual((rows[70]["width"], rows[70]["height"]),
                         (shape.full_width, shape.full_height))
        self.assertEqual(rows[39]["kind"], "transition")
        self.assertIsNone(rows[39]["phase"])
        self.assertEqual(rows[1]["phase"], 0)

    def test_token_policies_stay_separate(self):
        self.assertEqual(geometry.NATIVE_TOKEN_STORAGE_ALIGNMENT, 32)
        self.assertEqual(geometry.TRAINING_VIT_TOKEN_ALIGNMENT, 64)
        self.assertEqual(geometry.native_token_storage(96), 96)
        self.assertEqual(geometry.training_padded_vit_tokens(96), 128)
        self.assertEqual(geometry.native_token_storage(100), 128)
        shape = geometry.Geometry.from_valid(3840, 2160)
        self.assertEqual(shape.padded_vit_tokens,
                         geometry.training_padded_vit_tokens(shape.vit_tokens))
        self.assertEqual(shape.padded_vit_tokens, 2176)


class GeneratorConsumerTest(unittest.TestCase):
    def test_abi_source_is_the_public_kernel_parameters_header(self):
        self.assertEqual(generate_plan.ABI_HEADER,
                         ROOT / "csrc/include/dlssnr/abi/kernel_parameters.h")
        self.assertTrue(generate_plan.ABI_HEADER.is_file())
        fields, parameter_types = generate_plan.load_abi_fields()
        canonical = generate_plan.load("canonical_kernel_names.json")
        self.assertEqual(len(canonical), 81)
        self.assertEqual(len(fields), 81 + len(generate_plan.SAFE_ATTENTION_ALIASES))
        self.assertEqual(len(parameter_types), len(fields))
        self.assertTrue(generate_plan.load_template_resolvers())

    def test_block_level_derives_from_geometry_and_keeps_rejection(self):
        for role in range(1, 70):
            self.assertEqual(generate_plan.block_level(role), geometry.role_spatial_level(role))
        with self.assertRaisesRegex(ValueError, "unknown network block"):
            generate_plan.block_level(0)

    def test_schedule_missing_census_fails_clearly(self):
        schedule = physical_schedule.make(1280, 720, precision="fp8")
        missing_census = dict(schedule)
        missing_census.pop("census")
        with self.assertRaisesRegex(ValueError, "missing required census metadata"):
            generate_plan.build_plan(missing_census)
        partial = dict(schedule, census=dict(schedule["census"]))
        partial["census"].pop("unique_symbols")
        with self.assertRaisesRegex(ValueError, "missing required fields: \\['unique_symbols'\\]"):
            generate_plan.build_plan(partial)

    def test_direct_script_and_package_imports_do_not_write_outputs(self):
        direct = (
            "import sys\n"
            "import generate_plan, physical_schedule\n"
            "assert generate_plan.ABI_HEADER.is_file()\n"
            "assert generate_plan.block_level(1) == 0\n"
            "schedule = physical_schedule.make(1280, 720, precision='fp8')\n"
            "assert schedule['census']['compute_positions'] == 152\n")
        completed = subprocess.run([sys.executable, "-B", "-c", direct], cwd=TUNING,
                                   capture_output=True, text=True)
        self.assertEqual(completed.returncode, 0, completed.stderr)

        package = (
            "import tuning.generate_plan as plan, tuning.physical_schedule as schedule\n"
            "assert plan.block_level(69) == 0\n"
            "assert schedule.make(1280, 720, precision='fp8')['census']['calls'] == 185\n")
        completed = subprocess.run([sys.executable, "-B", "-c", package], cwd=ROOT,
                                   capture_output=True, text=True)
        self.assertEqual(completed.returncode, 0, completed.stderr)


if __name__ == "__main__":
    unittest.main()
