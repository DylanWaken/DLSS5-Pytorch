"""Speed benchmark contracts using fake CUDA; no Torch or GPU is required."""
from contextlib import redirect_stderr, redirect_stdout
import csv
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import Mock, patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
SPEC = importlib.util.spec_from_file_location('_speed_benchmark', ROOT / 'test_speed.py')
B = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(B)


class FakeCuda:
    """Capture deferred operations and timestamp actual replayed work."""
    def __init__(self):
        self.clock = 0.0
        self.active = None
        self.graphs = []
        self.events = []
        self.log = []
        self.completed = -1.0
        self.elapsed_override = None
        self.torch = SimpleNamespace(cuda=SimpleNamespace(
            CUDAGraph=lambda: self.Graph(self), Event=lambda **kw: self.Event(self, kw),
            graph=lambda graph, stream: self.Capture(self, graph, stream)))

    def enqueue(self, operation):
        if self.active is None:
            operation()
        else:
            self.active.commands.append(operation)

    def synchronize(self):
        if self.active is not None:
            raise AssertionError('synchronized inside graph capture')
        self.completed = self.clock
        self.log.append('sync')

    class Graph:
        def __init__(self, owner):
            self.owner, self.commands, self.replays = owner, [], 0
            owner.graphs.append(self)

        def replay(self):
            self.replays += 1
            self.owner.log.append('replay')
            for command in self.commands:
                command()

        def reset(self):
            self.owner.log.append('reset')

    class Capture:
        def __init__(self, owner, graph, stream):
            if stream is not owner:
                raise AssertionError('capture uses wrong stream')
            self.owner, self.graph = owner, graph

        def __enter__(self):
            self.owner.active = self.graph

        def __exit__(self, *args):
            self.owner.active = None

    class Event:
        def __init__(self, owner, options):
            self.owner, self.options, self.timestamp = owner, options, None
            owner.events.append(self)

        def record(self, stream):
            if stream is not self.owner:
                raise AssertionError('timing uses wrong stream')
            self.owner.enqueue(lambda: setattr(self, 'timestamp', self.owner.clock))

        def synchronize(self):
            self.owner.synchronize()

        def elapsed_time(self, end):
            if self.owner.completed < end.timestamp:
                raise AssertionError('elapsed time read before synchronization')
            if self.owner.elapsed_override is not None:
                return self.owner.elapsed_override
            return end.timestamp - self.timestamp


class SummaryTests(unittest.TestCase):
    def test_precision_thresholds_and_default_resolution_contract(self):
        for sm, expected in ((75, []), (80, ['fp16']), (86, ['fp16']),
                             (89, ['fp16', 'fp8']), (90, ['fp16', 'fp8']),
                             (120, ['fp16', 'fp8'])):
            with self.subTest(sm=sm):
                self.assertEqual(B.supported_precisions(sm), expected)
        self.assertEqual(list(B.SIZES.values()),
                         [(1280, 720), (1920, 1080), (2560, 1440), (3840, 2160)])
        self.assertEqual(B.parser().parse_args([]).precision, 'auto')

    def test_statistics_interpolate_percentiles_and_preserve_samples(self):
        result = B.summarize([10.0, 1.0, 3.0, 2.0])
        self.assertEqual(result['median_ms'], 2.5)
        self.assertAlmostEqual(result['p10_ms'], 1.3)
        self.assertAlmostEqual(result['p90_ms'], 7.9)
        self.assertEqual(result['passes_per_second'], 400)
        self.assertEqual(result['samples_ms'], [10.0, 1.0, 3.0, 2.0])
        self.assertEqual(B.summarize([2.0])['p90_ms'], 2.0)
        for values in ([], [0], [-1], [float('nan')], [float('inf')]):
            with self.subTest(values=values), self.assertRaises(ValueError):
                B.summarize(values)


class TimingTests(unittest.TestCase):
    def test_graph_samples_are_per_pass_and_warmup_is_excluded(self):
        fake = FakeCuda()
        executed = []

        def execute():
            executed.append(1)
            fake.clock += 2.0

        result = B.time_graph(fake.torch, lambda: fake.enqueue(execute), fake,
                              warmup=2, samples=4, iterations=5)
        self.assertEqual(len(fake.graphs[0].commands), 3)
        self.assertEqual(fake.graphs[0].replays, 2 + 4 * 5)
        self.assertEqual(len(executed), (2 + 4 * 5) * 3)
        self.assertEqual(result['samples_ms'], [2.0] * 4)
        self.assertEqual(result['passes_per_second'], 500.0)
        self.assertEqual(fake.log[-2:], ['sync', 'reset'])

    def test_capture_replay_and_invalid_timing_failures_reset_graph(self):
        for failure in ('capture', 'replay', 'timing'):
            with self.subTest(failure=failure):
                fake = FakeCuda()

                def run():
                    if failure == 'capture':
                        raise RuntimeError('capture failed')

                    def execute():
                        if failure == 'replay':
                            raise RuntimeError('replay failed')
                        fake.clock += 2
                    fake.enqueue(execute)

                if failure == 'timing':
                    fake.elapsed_override = float('nan')
                with self.assertRaises((RuntimeError, ValueError)):
                    B.time_graph(fake.torch, run, fake, warmup=1, samples=1, iterations=1)
                self.assertEqual(fake.log[-2:], ['sync', 'reset'])

    def test_kernel_diagnostics_replay_resets_and_producer_dependencies(self):
        fake = FakeCuda()
        counters = {'qkv': 99, 'attention': 99}
        execution = []

        class Kernel:
            inputs, outputs = (), ()

            def __init__(self, name, duration, operation):
                self.name, self.duration, self.operation = name, duration, operation

            def __call__(self, inputs, outputs):
                def execute():
                    self.operation()
                    execution.append(self.name)
                    fake.clock += self.duration
                fake.enqueue(execute)

        def produce():
            self.assertEqual(counters['qkv'], -1, 'stale split producer counter')
            counters['qkv'] = 1

        def consume():
            self.assertEqual(counters, {'qkv': 1, 'attention': -1})
            counters['attention'] = 0

        kernels = [Kernel('clear_qkv', .1, lambda: counters.update(qkv=-1)),
                   Kernel('clear_attention', .1, lambda: counters.update(attention=-1)),
                   Kernel('qkv', .4, produce), Kernel('attention', .6, consume)]
        module = SimpleNamespace(prepare_kernels=lambda plan: SimpleNamespace(kernels=kernels))
        plan = SimpleNamespace(split_launch_counts=lambda: [1, 1, 2, 1])
        with patch.dict(sys.modules, {'dlssnr.deployment': module}):
            result = B.time_kernel_sequence(fake.torch, plan, fake, warmup=2, samples=3)
        self.assertEqual(execution, [k.name for k in kernels] * 5)
        self.assertEqual([row['physical_launches'] for row in result], [1, 1, 2, 1])
        for row, kernel in zip(result, kernels):
            self.assertAlmostEqual(row['median_ms'], kernel.duration)
        self.assertTrue(all(event.options == {'enable_timing': True, 'external': True}
                            for event in fake.events))
        self.assertEqual(fake.log[-2:], ['sync', 'reset'])


class ReportingTests(unittest.TestCase):
    def test_worker_classifies_oom_and_other_errors_without_losing_case_identity(self):
        class OutOfMemoryError(RuntimeError):
            pass
        fake_torch = SimpleNamespace(cuda=SimpleNamespace(OutOfMemoryError=OutOfMemoryError))
        with tempfile.TemporaryDirectory() as directory:
            args = SimpleNamespace(worker=['fp16', '4k'], result=Path(directory) / 'case.json')
            for error, status in ((OutOfMemoryError('allocation failed'), 'out_of_memory'),
                                  (ValueError('invalid checkpoint'), 'error')):
                with self.subTest(status=status), patch.dict(sys.modules, {'torch': fake_torch}), \
                        patch.object(B, 'benchmark_case', side_effect=error):
                    self.assertEqual(B.worker_main(args), 1)
                result = json.loads(args.result.read_text())
                self.assertEqual((result['status'], result['precision'], result['resolution']),
                                 (status, 'fp16', '4k'))
                self.assertEqual((result['width'], result['height']), (3840, 2160))
                self.assertIn(str(error), result['error'])

    def test_auto_sweep_continues_after_failure_and_writes_json_csv(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for precision in ('fp16', 'fp8'):
                (root / f'dlss5_nr_{precision}.pt').write_bytes(b'checkpoint')
                (root / f'dlss5_nr_{precision}.json').write_text('{}')
            binary = root / 'native.pyd'
            binary.write_bytes(b'native')
            build = SimpleNamespace(binary_path=str(binary), receipt={'built': False})
            cuda = SimpleNamespace(is_available=lambda: True, device_count=lambda: 1,
                set_device=Mock(), get_device_properties=lambda index: SimpleNamespace(
                    major=12, minor=0, name='Fake GPU', total_memory=16 * 2**30))
            fake_torch = SimpleNamespace(cuda=cuda, __version__='fake', version=SimpleNamespace(cuda='fake'))
            cases = []

            def run_case(args, extension, precision, size, environment):
                saved = json.loads((args.output / 'results.json').read_text())
                self.assertEqual(len(saved['cases']), len(cases))
                cases.append((precision, size))
                width, height = B.SIZES[size]
                result = dict(precision=precision, resolution=size, width=width, height=height)
                if len(cases) == 1:
                    return dict(result, status='out_of_memory', error='simulated OOM')
                return dict(result, status='ok', median_ms=2., p90_ms=3.,
                            passes_per_second=500., peak_allocated_bytes=2**30,
                            kernels=[dict(index=0, name='counter_clear', physical_launches=1,
                                          median_ms=.01, p10_ms=.01, p90_ms=.01)])

            with patch.dict(sys.modules, {'torch': fake_torch, 'tools.speed_build':
                    SimpleNamespace(ensure_extension=lambda *a, **kw: build)}), \
                    patch.dict(B.os.environ, {}, clear=True), patch.object(B, 'run_case', side_effect=run_case), \
                    redirect_stdout(io.StringIO()):
                exit_code = B.main(['--checkpoint-dir', str(root), '--output', str(root / 'report'), '--per-kernel'])
            self.assertEqual(exit_code, 1)
            self.assertEqual(cases, [(p, size) for size in B.SIZES for p in ('fp16', 'fp8')])
            report = json.loads((root / 'report/results.json').read_text())
            self.assertFalse(report['success'])
            self.assertEqual(len(report['cases']), 8)
            self.assertIn('completed_utc', report)
            with (root / 'report/results.csv').open(newline='') as stream:
                rows = list(csv.DictReader(stream))
            self.assertEqual(len(rows), 8)
            self.assertEqual(rows[0]['status'], 'out_of_memory')
            with (root / 'report/kernels.csv').open(newline='') as stream:
                self.assertEqual(len(list(csv.DictReader(stream))), 7)

    def test_sm86_auto_uses_only_fp16_and_does_not_require_fp8_checkpoint(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'dlss5_nr_fp16.pt').write_bytes(b'checkpoint')
            (root / 'dlss5_nr_fp16.json').write_text('{}')
            binary = root / 'native.pyd'
            binary.write_bytes(b'native')
            build = SimpleNamespace(binary_path=str(binary), receipt={'built': False})
            cuda = SimpleNamespace(is_available=lambda: True, device_count=lambda: 1,
                set_device=Mock(), get_device_properties=lambda index: SimpleNamespace(
                    major=8, minor=6, name='Fake Ampere', total_memory=12 * 2**30))
            fake_torch = SimpleNamespace(cuda=cuda, __version__='fake', version=SimpleNamespace(cuda='fake'))

            def run_case(args, extension, precision, size, environment):
                self.assertEqual(precision, 'fp16')
                width, height = B.SIZES[size]
                return dict(precision=precision, resolution=size, width=width, height=height,
                            status='ok', median_ms=2., p90_ms=3., passes_per_second=500.,
                            peak_allocated_bytes=2**30)

            with patch.dict(sys.modules, {'torch': fake_torch, 'tools.speed_build':
                    SimpleNamespace(ensure_extension=lambda *a, **kw: build)}), \
                    patch.dict(B.os.environ, {}, clear=True), \
                    patch.object(B, 'run_case', side_effect=run_case) as worker, \
                    redirect_stdout(io.StringIO()):
                self.assertEqual(B.main(['--checkpoint-dir', str(root), '--output', str(root / 'report')]), 0)
            self.assertEqual(worker.call_count, 4)
            report = json.loads((root / 'report/results.json').read_text())
            self.assertTrue(report['success'])
            self.assertEqual(report['tested_precisions'], ['fp16'])
            self.assertEqual(report['skipped_precisions'], [{'precision': 'fp8', 'reason': 'Requires SM89+'}])

    def test_sm86_explicit_fp8_fails_before_build_or_worker(self):
        cuda = SimpleNamespace(is_available=lambda: True, device_count=lambda: 1,
            set_device=Mock(), get_device_properties=lambda index: SimpleNamespace(major=8, minor=6))
        builder, worker, stderr = Mock(), Mock(), io.StringIO()
        with patch.dict(sys.modules, {'torch': SimpleNamespace(cuda=cuda),
                'tools.speed_build': SimpleNamespace(ensure_extension=builder)}), \
                patch.object(B, 'run_case', worker), redirect_stderr(stderr), \
                self.assertRaises(SystemExit) as caught:
            B.main(['--precision', 'fp8'])
        self.assertEqual(caught.exception.code, 2)
        self.assertIn('FP8 is unsupported on SM86', stderr.getvalue())
        builder.assert_not_called()
        worker.assert_not_called()

    def test_malformed_worker_json_becomes_error_and_next_case_can_succeed(self):
        with tempfile.TemporaryDirectory() as directory:
            args = SimpleNamespace(output=Path(directory), device=0, checkpoint_dir=Path(directory),
                                   warmup=1, samples=1, iterations=1, per_kernel=False, timeout=1)
            valid = dict(precision='fp8', resolution='720p', status='ok', median_ms=2.,
                         p90_ms=3., passes_per_second=500., peak_allocated_bytes=2**30)
            invalid = [('truncated', '{', 0), ('not an object', '[]', 0),
                       ('wrong case', json.dumps(dict(valid, precision='fp16')), 0),
                       ('partial result', json.dumps(dict(precision='fp8', resolution='720p', status='ok')), 0),
                       ('nonfinite time', json.dumps(dict(valid, median_ms=float('nan'))), 0),
                       ('failed exit', json.dumps(valid), 2)]
            process = Mock()
            module = SimpleNamespace(terminate_process_tree=Mock())
            with patch.dict(sys.modules, {'tools.benchmark_architectures': module}), \
                    patch.object(B.subprocess, 'Popen', return_value=process):
                for label, content, returncode in invalid:
                    with self.subTest(label=label):
                        (args.output / 'fp8_720p.json').write_text(content)
                        process.wait.return_value = returncode
                        result = B.run_case(args, 'native.pyd', 'fp8', '720p', {})
                        self.assertEqual(result['status'], 'error')
                        self.assertEqual((result['precision'], result['resolution']), ('fp8', '720p'))
                        self.assertIn('Invalid worker report:', result['error'])
                        self.assertEqual(result['returncode'], returncode)
                (args.output / 'fp8_1080p.json').write_text(json.dumps(dict(valid, resolution='1080p')))
                process.wait.return_value = 0
                result = B.run_case(args, 'native.pyd', 'fp8', '1080p', {})
                self.assertEqual(result['status'], 'ok')
                self.assertEqual(result['median_ms'], 2.)

    def test_worker_timeout_requires_confirmed_tree_cleanup(self):
        with tempfile.TemporaryDirectory() as directory:
            args = SimpleNamespace(output=Path(directory), device=0, checkpoint_dir=Path(directory),
                                   warmup=1, samples=1, iterations=1, per_kernel=False, timeout=1)
            for confirmed in (True, False):
                process = Mock()
                process.wait.side_effect = subprocess.TimeoutExpired('worker', 1)
                cleanup = {'tree_termination_confirmed': confirmed}
                module = SimpleNamespace(terminate_process_tree=lambda process: cleanup)
                with self.subTest(confirmed=confirmed), \
                        patch.dict(sys.modules, {'tools.benchmark_architectures': module}), \
                        patch.object(B.subprocess, 'Popen', return_value=process):
                    if confirmed:
                        result = B.run_case(args, 'native.pyd', 'fp8', '720p', {})
                        self.assertEqual(result['status'], 'timeout')
                    else:
                        with self.assertRaisesRegex(RuntimeError, 'Cannot confirm'):
                            B.run_case(args, 'native.pyd', 'fp8', '720p', {})


if __name__ == '__main__':
    unittest.main()
