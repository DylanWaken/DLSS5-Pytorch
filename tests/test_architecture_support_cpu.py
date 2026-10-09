"""Build-target and binary-discovery contracts without CUDA execution."""
from contextlib import ExitStack
from pathlib import Path
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tuning.build_config import parse_targets, library_targets
from dlssnr import _binary, deployment


class BuildTargets(unittest.TestCase):
    def test_explicit_targets_preserve_native_and_ptx_images(self):
        targets = parse_targets('12.0;8.9+PTX 8.6;8.0;8.9')
        self.assertEqual([target.sm for target in targets], [80, 86, 89, 120])
        self.assertEqual(targets[2].nvcc_flags, [
            '-gencode=arch=compute_89,code=sm_89',
            '-gencode=arch=compute_89,code=compute_89'])
        self.assertEqual(targets[0].torch_name, '8.0')
        self.assertEqual(targets[2].torch_name, '8.9+PTX')

    def test_unsupported_or_ambiguous_targets_fail(self):
        for value in ('', '7.5', '8.6,8.9', '8.90', 'Ada', '9.0a'):
            with self.subTest(value=value), self.assertRaises(ValueError):
                parse_targets(value)

    def test_split_and_fat_libraries(self):
        targets = parse_targets('8.0;8.6;8.9;12.0')
        split = library_targets(targets)
        self.assertEqual([name for name, _ in split],
                         ['dlssnr._C_sm80', 'dlssnr._C_sm86', 'dlssnr._C_sm89', 'dlssnr._C_sm120'])
        self.assertTrue(all(len(images) == 1 for _, images in split))
        self.assertEqual(library_targets(targets, 'fat'), [('dlssnr._C', targets)])
        with self.assertRaises(ValueError):
            library_targets(targets, 'invalid')


class BinaryDiscovery(unittest.TestCase):
    def discover(self, sm, available):
        with tempfile.TemporaryDirectory() as directory, ExitStack() as stack:
            paths = {}
            for module in available:
                path = Path(directory) / (module.rsplit('.', 1)[-1] + '.pyd')
                path.touch()
                paths[module] = path
            stack.enter_context(patch('torch.cuda.is_available', return_value=True))
            stack.enter_context(patch('torch.cuda.get_device_capability', return_value=divmod(sm, 10)))
            stack.enter_context(patch.object(Path, 'glob', return_value=list(paths.values())))
            finder = stack.enter_context(patch.object(_binary, 'find_spec', side_effect=lambda name:
                SimpleNamespace(origin=str(paths[name])) if name in paths else None))
            result = Path(_binary.extension_path()).name
            return result, [call.args[0] for call in finder.call_args_list]

    def test_exact_split_precedes_stale_legacy_name(self):
        result, queried = self.discover(120, ['dlssnr._C', 'dlssnr._C_sm120'])
        self.assertEqual(result, '_C_sm120.pyd')
        self.assertEqual(queried, ['dlssnr._C_sm120'])

    def test_ampere_minor_cubin_compatibility(self):
        result, _ = self.discover(86, ['dlssnr._C_sm80'])
        self.assertEqual(result, '_C_sm80.pyd')
        with self.assertRaisesRegex(RuntimeError, 'SM80'):
            self.discover(80, ['dlssnr._C_sm86'])

    def test_ada_does_not_select_ampere_fp8_traps(self):
        with self.assertRaisesRegex(RuntimeError, 'SM89'):
            self.discover(89, ['dlssnr._C_sm80', 'dlssnr._C_sm86'])
        result, _ = self.discover(89, ['dlssnr._C_sm89'])
        self.assertEqual(result, '_C_sm89.pyd')

    def test_fat_fallback_and_no_cross_major_cubin(self):
        result, _ = self.discover(90, ['dlssnr._C', 'dlssnr._C_sm89'])
        self.assertEqual(result, '_C.pyd')
        with self.assertRaisesRegex(RuntimeError, 'SM90'):
            self.discover(90, ['dlssnr._C_sm89'])

    def test_input_device_selects_library_before_plan_construction(self):
        state = SimpleNamespace(device='cuda:2')
        api = SimpleNamespace(create_plan_for_resolution_fp16=lambda *args: args)
        with patch.object(deployment, 'load_extension', return_value=api) as loader:
            result = deployment.create_plan_fp16(state, [], width=1300, height=732)
        loader.assert_called_once_with(device='cuda:2')
        self.assertEqual(result[2:], (1300, 732))

    def test_checkpoint_selects_input_device_before_querying_records(self):
        from dlssnr.checkpoint import Checkpoint

        state = SimpleNamespace(device='cuda:2')
        # An empty compiled roster isolates library selection from weight packing;
        # no checkpoint files, CUDA tensors or extension are loaded by this test.
        for precision in ('fp8', 'fp16'):
            with self.subTest(precision=precision):
                checkpoint = Checkpoint.__new__(Checkpoint)
                checkpoint.precision = precision
                checkpoint._records = {}
                api = SimpleNamespace(**{
                    'record_names_' + precision: lambda: [],
                    'record_bytes_' + precision: lambda: [],
                })
                expected_plan = object()
                with patch.object(deployment, 'load_extension', return_value=api) as loader, \
                        patch.object(deployment, 'create_plan_' + precision,
                                     return_value=expected_plan) as create_plan:
                    result = getattr(checkpoint, 'create_plan_' + precision)(
                        state, width=1300, height=732)
                loader.assert_called_once_with(device='cuda:2')
                create_plan.assert_called_once_with(state, [], width=1300, height=732)
                self.assertIs(result, expected_plan)

    def test_frontend_configuration_selects_intended_device(self):
        api = SimpleNamespace(frontend_configuration=lambda *args: args)
        with patch.object(deployment, 'load_extension', return_value=api) as loader:
            result = deployment.frontend_configuration(
                'input_preprocess_window_c32_fp16', height=732, width=1300, device='cuda:2')
        loader.assert_called_once_with(device='cuda:2')
        self.assertEqual(result, ('input_preprocess_window_c32_fp16', 732, 1300, 0, 0, 0, 0))


if __name__ == '__main__':
    unittest.main()
