"""Speed-test binary selection and build orchestration without a GPU or compiler."""
from contextlib import ExitStack
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch
from unittest.mock import Mock

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tools import speed_build


class SpeedBuild(unittest.TestCase):
    def setUp(self):
        self.stack = ExitStack()
        self.addCleanup(self.stack.close)
        self.directory = Path(self.stack.enter_context(tempfile.TemporaryDirectory())).resolve()
        self.torch = SimpleNamespace(cuda=SimpleNamespace(
            is_available=lambda: True,
            get_device_capability=lambda device: (12, 0)))
        self.stack.enter_context(patch.dict(sys.modules, {'torch': self.torch}))

    @staticmethod
    def probe_process(result):
        process = Mock(returncode=result.returncode)
        process.communicate.return_value = (result.stdout, result.stderr)
        return process

    def test_compatible_binary_is_reused_without_build_environment(self):
        path = str(self.directory / '_C_sm120.pyd')
        with patch.object(speed_build._binary, 'extension_path', return_value=path) as lookup, \
                patch.object(speed_build, '_probe_extension', return_value=[120]) as probe, \
                patch.object(speed_build, '_build_environment') as environment:
            result = speed_build.ensure_extension(2, root=self.directory, progress=None)
        self.assertFalse(result.built)
        self.assertEqual(result.binary_path, path)
        self.assertEqual(result.receipt['compiled_architectures'], [120])
        self.assertIsNone(result.log_path)
        lookup.assert_called_once_with(2)
        probe.assert_called_once_with(path, self.directory, 120)
        environment.assert_not_called()

    def test_missing_binary_builds_exact_target_and_keeps_receipt(self):
        path = str(self.directory / '_C_sm120.pyd')
        with patch.object(speed_build._binary, 'extension_path', side_effect=[RuntimeError('missing'), path]), \
                patch.object(speed_build, '_probe_extension', return_value=[120]), \
                patch.object(speed_build, '_build_environment', return_value=({'PATH': 'test'}, {'MAX_JOBS': '2'})) as env, \
                patch.object(speed_build, '_run_build', return_value=0) as build:
            result = speed_build.ensure_extension('cuda:2', root=self.directory, progress=None)
        self.assertTrue(result.built)
        env.assert_called_once_with(self.directory, '12.0')
        command = build.call_args.args[0]
        self.assertEqual(command[:5], [sys.executable, 'setup.py', 'build_ext', '--inplace', '--force'])
        self.assertIn('--build-temp', command)
        self.assertTrue(Path(result.log_path).is_file())
        receipt = json.loads(Path(result.receipt_path).read_text(encoding='utf-8'))
        self.assertEqual(receipt['status'], 'built')
        self.assertEqual(receipt['compiled_architectures'], [120])
        self.assertEqual(receipt['reuse_failure'], 'missing')

    def test_rebuild_skips_existing_probe(self):
        path = str(self.directory / '_C_sm120.pyd')
        with patch.object(speed_build._binary, 'extension_path', return_value=path) as lookup, \
                patch.object(speed_build, '_probe_extension', return_value=[120]) as probe, \
                patch.object(speed_build, '_build_environment', return_value=({}, {})), \
                patch.object(speed_build, '_run_build', return_value=0):
            result = speed_build.ensure_extension(root=self.directory, progress=None, rebuild=True)
        self.assertTrue(result.built)
        lookup.assert_called_once()
        probe.assert_called_once()
        self.assertNotIn('reuse_failure', result.receipt)

    def test_incompatible_fat_binary_is_replaced(self):
        path = str(self.directory / '_C_sm120.pyd')
        with patch.object(speed_build._binary, 'extension_path', side_effect=['old_fat.pyd', path]), \
                patch.object(speed_build, '_probe_extension', side_effect=[RuntimeError('incompatible'), [120]]), \
                patch.object(speed_build, '_build_environment', return_value=({}, {})), \
                patch.object(speed_build, '_run_build', return_value=0):
            result = speed_build.ensure_extension(root=self.directory, progress=None)
        self.assertTrue(result.built)
        self.assertEqual(result.receipt['reuse_failure'], 'incompatible')

    def test_build_failure_has_persistent_log_and_receipt(self):
        with patch.object(speed_build, '_build_environment', return_value=({}, {})), \
                patch.object(speed_build, '_run_build', return_value=1):
            with self.assertRaisesRegex(RuntimeError, 'Build log:'):
                speed_build.ensure_extension(root=self.directory, rebuild=True, progress=None)
        receipt_path, = self.directory.glob('build/speed/*/receipt.json')
        receipt = json.loads(receipt_path.read_text(encoding='utf-8'))
        self.assertEqual(receipt['status'], 'failed')
        self.assertEqual(receipt['returncode'], 1)
        self.assertIn('status 1', Path(receipt['log_path']).read_text(encoding='utf-8'))

    def test_build_rejects_wrong_architecture_metadata(self):
        with patch.object(speed_build._binary, 'extension_path', return_value='_C_sm120.pyd'), \
                patch.object(speed_build, '_probe_extension', return_value=[120, 121]), \
                patch.object(speed_build, '_build_environment', return_value=({}, {})), \
                patch.object(speed_build, '_run_build', return_value=0):
            with self.assertRaisesRegex(RuntimeError, 'differs from the requested native SM120'):
                speed_build.ensure_extension(root=self.directory, rebuild=True, progress=None)

    def test_cuda_and_unsupported_devices_fail_before_build(self):
        self.torch.cuda.is_available = lambda: False
        with self.assertRaisesRegex(RuntimeError, 'visible NVIDIA GPU'):
            speed_build.ensure_extension(root=self.directory, progress=None)
        self.torch.cuda.is_available = lambda: True
        self.torch.cuda.get_device_capability = lambda device: (7, 5)
        with self.assertRaisesRegex(RuntimeError, 'SM75 is unsupported'):
            speed_build.ensure_extension(root=self.directory, progress=None)
        self.assertFalse((self.directory / 'build').exists())

    def test_probe_is_isolated_and_checks_native_compatibility(self):
        for device, architectures, accepted in (
                (86, [80], True), (80, [86], False), (89, [86], False),
                (89, [89], True), (120, [89], False), (120, [89, 120], True)):
            output = speed_build.PROBE_PREFIX + json.dumps(architectures) + '\n'
            result = SimpleNamespace(returncode=0, stdout=output, stderr='')
            with self.subTest(device=device, architectures=architectures), \
                    patch.object(subprocess, 'Popen', return_value=self.probe_process(result)) as run:
                if accepted:
                    self.assertEqual(speed_build._probe_extension('library.pyd', self.directory, device), architectures)
                else:
                    with self.assertRaisesRegex(RuntimeError, 'incompatible'):
                        speed_build._probe_extension('library.pyd', self.directory, device)
                self.assertEqual(run.call_args.args[0][0], sys.executable)
                self.assertEqual(run.call_args.args[0][-1], 'library.pyd')
                self.assertEqual(run.call_args.kwargs['cwd'], self.directory)
                self.assertEqual(run.call_args.kwargs['start_new_session'], os.name != 'nt')

    def test_probe_errors_are_actionable(self):
        for result, message in (
                (SimpleNamespace(returncode=1, stdout='', stderr='DLL load failed'), 'DLL load failed'),
                (SimpleNamespace(returncode=0, stdout='', stderr=''), 'architecture metadata'),
                (SimpleNamespace(returncode=0, stdout=speed_build.PROBE_PREFIX + '[true]', stderr=''), 'architecture metadata')):
            with self.subTest(message=message), \
                    patch.object(subprocess, 'Popen', return_value=self.probe_process(result)):
                with self.assertRaisesRegex(RuntimeError, message):
                    speed_build._probe_extension('library.pyd', self.directory, 120)

    def test_probe_timeout_stops_child_interpreter_before_returning(self):
        process = Mock()
        process.communicate.side_effect = [subprocess.TimeoutExpired('probe', 1), ('', '')]
        with patch.object(subprocess, 'Popen', return_value=process), \
                patch.object(speed_build, '_stop_build') as stop:
            with self.assertRaisesRegex(RuntimeError, 'probe exceeded 1 seconds'):
                speed_build._probe_extension('library.pyd', self.directory, 120, timeout_seconds=1)
        stop.assert_called_once_with(process)
        self.assertEqual(process.communicate.call_count, 2)
        process.communicate.assert_called_with(timeout=30)

    def test_probe_interrupt_stops_child_interpreter(self):
        process = Mock()
        process.communicate.side_effect = [KeyboardInterrupt(), ('', '')]
        with patch.object(subprocess, 'Popen', return_value=process), \
                patch.object(speed_build, '_stop_build') as stop:
            with self.assertRaises(KeyboardInterrupt):
                speed_build._probe_extension('library.pyd', self.directory, 120)
        stop.assert_called_once_with(process)

    def test_uncertain_probe_cleanup_prevents_compilation(self):
        process = Mock()
        process.communicate.side_effect = subprocess.TimeoutExpired('probe', 1)
        with patch.object(speed_build._binary, 'extension_path', return_value='library.pyd'), \
                patch.object(subprocess, 'Popen', return_value=process), \
                patch.object(speed_build, '_stop_build', side_effect=RuntimeError('taskkill failed')), \
                patch.object(speed_build, '_build_environment') as environment:
            with self.assertRaisesRegex(speed_build.ProbeCleanupError, 'automatic replacement was cancelled'):
                speed_build.ensure_extension(root=self.directory, progress=None)
        environment.assert_not_called()
        self.assertFalse((self.directory / 'build').exists())

    def test_architecture_overrides_keep_toolchain_and_job_selections(self):
        toolkit = self.directory / 'chosen-cuda'
        (toolkit / 'bin').mkdir(parents=True)
        (toolkit / 'include').mkdir()
        (toolkit / 'bin' / ('nvcc.exe' if os.name == 'nt' else 'nvcc')).touch()
        (toolkit / 'include/cuda_runtime.h').touch()
        assembler = self.directory / 'custom-ptxas'
        assembler.touch()
        inherited = dict(PATH='caller-path', CUDA_HOME=str(toolkit),
                         DLSSNR_PTXAS_PATH=str(assembler), MAX_JOBS='7',
                         TORCH_CUDA_ARCH_LIST='8.0;8.9+PTX', DLSSNR_BUILD_MODE='fat')
        with patch.dict(os.environ, inherited, clear=True), \
                patch.object(speed_build, '_windows_build_environment', side_effect=lambda env: env), \
                patch.object(speed_build.shutil, 'which', return_value='compiler'):
            environment, receipt = speed_build._build_environment(self.directory, '12.0')
            self.assertEqual(os.environ['TORCH_CUDA_ARCH_LIST'], '8.0;8.9+PTX')
        self.assertEqual(environment['TORCH_CUDA_ARCH_LIST'], '12.0')
        self.assertEqual(environment['DLSSNR_BUILD_MODE'], 'split')
        self.assertEqual(environment['MAX_JOBS'], '7')
        self.assertEqual(environment['DLSSNR_PTXAS_PATH'], str(assembler.resolve()))
        self.assertEqual(environment['CUDA_HOME'], str(toolkit.resolve()))
        self.assertEqual(receipt['CUDA_HOME'], str(toolkit.resolve()))

    def test_windows_developer_environment_can_be_discovered(self):
        script = self.directory / 'Visual Studio/VC/Auxiliary/Build/vcvarsall.bat'
        result = SimpleNamespace(stdout='Path=compiler-bin\r\nINCLUDE=headers\r\nLIB=libraries\r\n'.encode('utf-16le'))
        with patch.object(speed_build, '_find_vcvarsall', return_value=script), \
                patch.object(speed_build.shutil, 'which', side_effect=[None, 'compiler-bin/cl.exe']), \
                patch.object(subprocess, 'run', return_value=result) as run:
            environment = speed_build._windows_build_environment({'Path': 'original', 'MAX_JOBS': '5'})
        self.assertEqual(environment['PATH'], 'compiler-bin')
        self.assertEqual(environment['INCLUDE'], 'headers')
        self.assertEqual(environment['DISTUTILS_USE_SDK'], '1')
        self.assertEqual(environment['MAX_JOBS'], '5')
        self.assertIn(str(script), run.call_args.args[0])
        self.assertEqual(run.call_args.kwargs['timeout'], 60)

    def test_windows_missing_compiler_has_installation_guidance(self):
        with patch.object(speed_build, '_find_vcvarsall', return_value=None), \
                patch.object(speed_build.shutil, 'which', return_value=None):
            with self.assertRaisesRegex(RuntimeError, 'Desktop development with C\\+\\+'):
                speed_build._windows_build_environment({'PATH': ''})

    def test_local_cuda_toolkit_is_preferred_to_global_path(self):
        toolkit = self.directory / '.cuda/Library'
        (toolkit / 'bin').mkdir(parents=True)
        (toolkit / 'include').mkdir()
        (toolkit / 'bin' / ('nvcc.exe' if os.name == 'nt' else 'nvcc')).touch()
        (toolkit / 'include/cuda_runtime.h').touch()
        with patch.dict(os.environ, {'CUDA_PATH': 'unrelated-toolkit'}, clear=True), \
                patch.object(speed_build, '_windows_build_environment', side_effect=lambda env: env), \
                patch.object(speed_build.shutil, 'which', return_value='compiler'):
            environment, _ = speed_build._build_environment(self.directory, '8.9')
        self.assertEqual(environment['CUDA_HOME'], str(toolkit.resolve()))
        self.assertEqual(environment['MAX_JOBS'], '2')
        self.assertEqual(environment['TORCH_CUDA_ARCH_LIST'], '8.9')

    def test_invalid_explicit_cuda_home_does_not_fall_back(self):
        with patch.dict(os.environ, {'CUDA_HOME': str(self.directory / 'missing')}, clear=True):
            with self.assertRaisesRegex(RuntimeError, 'CUDA_HOME is incomplete'):
                speed_build._build_environment(self.directory, '12.0')

    def test_build_timeout_stops_compiler_tree(self):
        process = Mock()
        process.wait.side_effect = subprocess.TimeoutExpired('build', 1)
        log = self.directory / 'build.log'
        with patch.object(subprocess, 'Popen', return_value=process), \
                patch.object(speed_build.time, 'monotonic', side_effect=[0, 0, 2]), \
                patch.object(speed_build, '_stop_build') as stop:
            with self.assertRaisesRegex(TimeoutError, 'exceeded 1 seconds'):
                speed_build._run_build(['python', 'setup.py'], self.directory, {}, log, 1, None)
        stop.assert_called_once_with(process)
        self.assertTrue(log.is_file())

    def test_invalid_timeout_fails_before_device_detection(self):
        for value in (0, -1, float('inf'), float('nan')):
            with self.subTest(value=value), self.assertRaisesRegex(ValueError, 'positive finite'):
                speed_build.ensure_extension(root=self.directory, timeout_seconds=value)


if __name__ == '__main__':
    unittest.main()
