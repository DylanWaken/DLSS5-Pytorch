"""Opt-in GPU integration test for named operators and fullgraph composition.

This compares the new API to the already validated integrated C++ schedule.
It does not substitute for the separate DLL numerical/performance benchmarks.
Run in a fresh process, for example:
  python tests/test_prepared_kernel_api.py --execute --precision fp8
"""
import argparse
import gc
import json
from pathlib import Path
import sys
import traceback

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))


def compile_route(function, backend):
    import torch
    if backend == 'default':
        return torch.compile(function, fullgraph=True)
    return torch.compile(function, backend=backend, fullgraph=True)


def missing_triton(error):
    """Only an actual missing Triton compiler permits an optional backend skip."""
    from torch._inductor.exc import TritonMissing
    pending, seen = [error], set()
    while pending:
        current = pending.pop()
        if id(current) in seen:
            continue
        seen.add(id(current))
        if isinstance(current, TritonMissing):
            return True
        if isinstance(current, ModuleNotFoundError) and (current.name or '').split('.')[0] == 'triton':
            return True
        pending.extend(nested for nested in (current.__cause__, current.__context__,
                       getattr(current, 'inner_exception', None)) if isinstance(nested, BaseException))
    return False


def execute(args):
    import torch
    from dlssnr.checkpoint import load_checkpoint
    from dlssnr.deployment import load_extension, prepare_kernels

    torch.set_num_threads(8)
    torch.cuda.set_device(args.device)
    load_extension(args.extension)
    suffix = '_fp16' if args.precision == 'fp16' else ''
    shape = json.loads((ROOT / f'tuning/plan{suffix}_{args.width}_{args.height}.json').read_text(encoding='utf-8'))
    input_bytes = next(iter(shape['buffers'].values()))['storage_bytes']
    dtype = torch.float16 if args.precision == 'fp16' else torch.float8_e4m3fn
    element_bytes = 2 if args.precision == 'fp16' else 1
    state = (torch.randn(input_bytes // element_bytes, device='cuda', dtype=torch.float16) * .025).to(dtype).view(torch.uint8)
    archive = load_checkpoint(ROOT / f'ckpts/dlss5_nr_{args.precision}.pt')
    plan = getattr(archive, f'create_plan_{args.precision}')(state, width=args.width, height=args.height)
    integrated = getattr(plan, f'run_{args.precision}')
    sequence = prepare_kernels(plan)
    assert len(sequence.kernels) == 185
    report = dict(precision=args.precision, width=args.width, height=args.height,
                  torch_version=torch.__version__, calls=185, routes=[], pass_=False)

    golden_output = integrated().clone()
    golden_boundaries = [tensor.clone() for tensor in plan.boundaries()]
    original_state = state.clone()
    changed_state = (torch.randn(input_bytes // element_bytes, device='cuda', dtype=torch.float16) * .03125).to(dtype).view(torch.uint8)
    torch.cuda.synchronize()
    plan.poison(0xA5)
    cpp_output = sequence.run_cpp()
    torch.cuda.synchronize()
    assert torch.equal(cpp_output, golden_output)
    assert all(torch.equal(actual, expected) for actual, expected in zip(plan.boundaries(), golden_boundaries))
    report['cpp_chain_equal'] = True
    successful_backends = []
    for backend in [None, *args.backend]:
        plan.poison(0xA5)
        try:
            run = sequence if backend is None else compile_route(sequence, backend)
            output = run(*sequence.tensors)
        except Exception as error:
            if backend == 'default' and missing_triton(error):
                report['routes'].append(dict(backend=backend, status='unsupported',
                    reason='Actual default-backend compilation failed because no working Triton compiler is installed.',
                    error=f'{type(error).__name__}: {error}'))
                continue
            raise
        if backend is not None:
            successful_backends.append(backend)
        torch.cuda.synchronize()
        checks = dict(backend=backend or 'eager',
                      output_equal=torch.equal(output, golden_output),
                      boundaries_equal=all(torch.equal(actual, expected) for actual, expected in zip(plan.boundaries(), golden_boundaries)),
                      guards_intact=plan.guards_intact())
        report['routes'].append(checks)
        assert all(checks[key] for key in ('output_equal', 'boundaries_equal', 'guards_intact')), checks
        state.copy_(changed_state)
        plan.poison(0xA5)
        changed_output = integrated().clone()
        changed_boundaries = [tensor.clone() for tensor in plan.boundaries()]
        plan.poison(0xA5)
        result = run(*sequence.tensors)
        torch.cuda.synchronize()
        checks['changed_input_equal'] = torch.equal(result, changed_output)
        checks['changed_boundaries_equal'] = all(torch.equal(actual, expected) for actual, expected in zip(plan.boundaries(), changed_boundaries))
        assert checks['changed_input_equal'] and checks['changed_boundaries_equal'], checks
        if backend == 'default':
            capture_stream = torch.cuda.Stream()
            capture_stream.wait_stream(torch.cuda.current_stream())
            compiled_graph = torch.cuda.CUDAGraph()
            try:
                with torch.cuda.stream(capture_stream):
                    with torch.cuda.graph(compiled_graph, stream=capture_stream):
                        run(*sequence.tensors)
                    compiled_graph.replay()
                capture_stream.synchronize()
                assert torch.equal(plan.boundaries()[-1], changed_output)
                state.copy_(original_state)
                capture_stream.wait_stream(torch.cuda.current_stream())
                with torch.cuda.stream(capture_stream):
                    compiled_graph.replay()
                capture_stream.synchronize()
                assert torch.equal(plan.boundaries()[-1], golden_output)
                checks['compiled_graph_changed_input_equal'] = True
            finally:
                capture_stream.synchronize()
                compiled_graph.reset()
        state.copy_(original_state)

    # A single export accepts independent storage and exposes its writeback.
    kernel = sequence.kernels[0]
    inputs = [tensor.clone() for tensor in kernel.inputs]
    outputs = [tensor.clone() for tensor in kernel.outputs]
    expected = [tensor.clone() for tensor in outputs]
    kernel(inputs, expected)
    for backend in successful_backends:
        compiled = compile_route(kernel, backend)
        compiled(inputs, outputs)
        torch.cuda.synchronize()
        assert all(torch.equal(actual, wanted) for actual, wanted in zip(outputs, expected))
    report['individual_rebinding_equal'] = True

    # Wrong export, extent, alias, and expired owner must fail before launch.
    api = load_extension()
    failures = 0
    for action in (
        lambda: api.completion_counter_clear(list(kernel.inputs), list(kernel.outputs), kernel.handle),
        lambda: kernel([kernel.inputs[0][:-1], *kernel.inputs[1:]], kernel.outputs),
        lambda: kernel(kernel.inputs, [kernel.inputs[0], *kernel.outputs[1:]]),
    ):
        try:
            action()
        except RuntimeError:
            failures += 1
        else:
            raise AssertionError('invalid individual kernel invocation was accepted')
    disposable = plan.prepare_kernels()
    handle = disposable[0].id()
    operation = getattr(api, disposable[0].name())
    del disposable
    gc.collect()
    try:
        operation(list(kernel.inputs), list(kernel.outputs), handle)
    except RuntimeError:
        failures += 1
    else:
        raise AssertionError('released prepared kernel handle was accepted')
    report['rejected_invalid_calls'] = failures

    # Capture only launches; all descriptor creation and compiler warmup is outside.
    stream = torch.cuda.Stream()
    stream.wait_stream(torch.cuda.current_stream())
    graph = torch.cuda.CUDAGraph()
    try:
        with torch.cuda.stream(stream):
            plan.poison(0xA5)
            with torch.cuda.graph(graph, stream=stream):
                sequence(*sequence.tensors)
            graph.replay()
        stream.synchronize()
        assert torch.equal(plan.boundaries()[-1], golden_boundaries[-1])
        assert plan.guards_intact()
        report['cuda_graph_equal'] = True
        state.copy_(changed_state)
        plan.poison(0xA5)
        changed_output = integrated().clone()
        stream.wait_stream(torch.cuda.current_stream())
        with torch.cuda.stream(stream):
            plan.poison(0xA5)
            graph.replay()
        stream.synchronize()
        assert torch.equal(plan.boundaries()[-1], changed_output)
        report['cuda_graph_changed_input_equal'] = True
    finally:
        stream.synchronize()
        graph.reset()
    cpp_graph = torch.cuda.CUDAGraph()
    try:
        state.copy_(original_state)
        stream.wait_stream(torch.cuda.current_stream())
        with torch.cuda.stream(stream):
            plan.poison(0xA5)
            with torch.cuda.graph(cpp_graph, stream=stream):
                sequence.run_cpp()
            cpp_graph.replay()
        stream.synchronize()
        assert torch.equal(plan.boundaries()[-1], golden_output)
        state.copy_(changed_state)
        stream.wait_stream(torch.cuda.current_stream())
        with torch.cuda.stream(stream):
            cpp_graph.replay()
        stream.synchronize()
        assert torch.equal(plan.boundaries()[-1], changed_output)
        report['cpp_graph_changed_input_equal'] = True
    finally:
        stream.synchronize()
        cpp_graph.reset()
    report['c32_output_view'] = test_output_view(args, archive, successful_backends)
    report['pass'] = True
    report.pop('pass_')
    return report


def test_output_view(args, archive, backends):
    """Compare the two out-of-trunk named exports to the independent DLL fixture."""
    import torch
    from dlssnr import deployment
    from tools.native_reference.session import NativeArtifacts
    from tools.native_reference.vendor_benchmark import VendorModule
    from tools.native_reference.lifetime import NativeGraphOwner
    from test_window_output_view import parameters

    precision = args.precision
    case = dict(height=16, width=24, view_height=16, view_width=24, phase=1)
    dtype = torch.float16 if precision == 'fp16' else torch.float8_e4m3fn
    state = (torch.randn(16 * 24 * 32, device='cuda', dtype=torch.float16) * .025).to(dtype).view(torch.uint8)
    record = archive.kernel_record(1, kind='window', precision=precision, device='cuda')
    native_output = torch.full_like(state, 0xA5)
    output = torch.full_like(state, 0xA5)
    kernel = getattr(deployment, f'prepare_output_view_{precision}')(
        state, record, output, height=16, width=24, phase=1)
    blob, launch = parameters([state.data_ptr(), native_output.data_ptr(), record.data_ptr()], case)
    stream = torch.cuda.current_stream()
    original = 'cc_tinlayout_fused_swin_1h_32_1_outview' + ('_fp8' if precision == 'fp8' else '')
    artifacts = NativeArtifacts(ROOT / 'assets')
    results = []
    with NativeGraphOwner(stream.synchronize, label='individual C32 output-view API') as owner:
        module = owner.own(VendorModule(artifacts.modules[32], stream.cuda_stream, original, 96))
        module.launch(blob, launch)
        for backend in [None, *backends]:
            run = kernel if backend is None else compile_route(kernel, backend)
            # Distinct output allocation proves argument rebinding after compilation.
            actual = torch.full_like(output, 0xA5)
            run([state, record], [actual])
            stream.synchronize()
            equal = torch.equal(actual, native_output)
            results.append(dict(backend=backend or 'eager', dll_bytes_equal=equal))
            assert equal, results[-1]
    return results


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--execute', action='store_true')
    parser.add_argument('--precision', choices=['fp8', 'fp16'], default='fp8')
    parser.add_argument('--width', type=int, default=1280)
    parser.add_argument('--height', type=int, default=720)
    parser.add_argument('--device', type=int, default=0)
    parser.add_argument('--extension', type=Path)
    parser.add_argument('--backend', nargs='+', default=['eager', 'aot_eager', 'default'],
                        help='Use default to exercise torch.compile without overriding its backend')
    parser.add_argument('--report', '--output', dest='report', type=Path)
    args = parser.parse_args()
    if not args.execute:
        parser.error('GPU integration is opt-in; pass --execute in an isolated process')
    try:
        report = execute(args)
    except Exception as error:
        report = {'pass': False, 'precision': args.precision,
                  'error': f'{type(error).__name__}: {error}', 'traceback': traceback.format_exc()}
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, indent=2))
    if not report['pass']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
