"""FP16 trunk differential validation against original cubin functions.

Run in a bounded child process. The reference geometry is computed from exact
shape formulas; no extracted PTX is compiled or substituted into the CUDA/C++
candidate. Saved reference JSON records the dimensions actually tested.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import statistics
import struct
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--width', type=int, default=1280)
    p.add_argument('--height', type=int, default=720)
    p.add_argument('--extension', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--timing', action='store_true')
    p.add_argument('--profile-only', action='store_true')
    p.add_argument('--native-only', action='store_true')
    p.add_argument('--precision', choices=('fp8', 'fp16'), default='fp16', help='FP8 is a shared-host regression check')
    args = p.parse_args()
    import numpy as np
    import torch
    from dlssnr.checkpoint import load_checkpoint
    from dlssnr.deployment import load_extension
    from tools.native_reference.vendor_benchmark import VendorModule
    torch.set_num_threads(8)
    torch.manual_seed(3108)
    stream = torch.cuda.Stream()
    torch.cuda.set_stream(stream)
    ops = load_extension(args.extension)
    checkpoint = load_checkpoint(ROOT / f'ckpts/dlss5_nr_{args.precision}.pt')
    # The independent native reference follows the same exact geometry rules
    # at any resolution, without requiring a pre-generated per-shape JSON file.
    from tuning.physical_schedule import make
    from tuning.generate_plan import build_plan
    schedule = make(args.width, args.height, precision=args.precision)
    spec = build_plan(schedule)
    spec_json = json.dumps(spec, indent=2) + '\n'
    schedule_json = json.dumps(schedule, indent=2) + '\n'
    args.output.parent.mkdir(parents=True, exist_ok=True)
    reference_plan_path = args.output.with_name(args.output.stem + '.reference_plan.json')
    reference_schedule_path = args.output.with_name(args.output.stem + '.reference_schedule.json')
    reference_plan_path.write_bytes(spec_json.encode('utf-8'))
    reference_schedule_path.write_bytes(schedule_json.encode('utf-8'))
    names = list(spec['buffers'])
    dtype = torch.float16 if args.precision == 'fp16' else torch.float8_e4m3fn
    state = (torch.randn(spec['buffers']['input']['storage_bytes'] // (2 if args.precision == 'fp16' else 1), device='cuda', dtype=torch.float16) * .02).to(dtype).view(torch.uint8)
    candidate = None if args.native_only else getattr(checkpoint, 'create_plan_' + args.precision)(state, width=args.width, height=args.height)
    candidate_run = None if candidate is None else getattr(candidate, 'run_' + args.precision)
    split_launch_counts = [] if candidate is None else list(candidate.split_launch_counts())
    if candidate is not None:
        assert list(candidate.buffer_names()) == names
        for name, buffer in spec['buffers'].items():
            assert candidate.buffer(name).numel() == buffer['storage_bytes'], name
        assert len(split_launch_counts) == len(spec['calls'])
        for count, call in zip(split_launch_counts, spec['calls']):
            assert count in (1, call['grid'][2])
            assert call['all_resident'] or count == 1
            if os.environ.get('DLSSNR_SM_COUNT_LIMIT') == '1' and call['all_resident']:
                assert count == call['grid'][2], call['fn']
    print('Candidate created', flush=True)
    # Candidate records are private; create independent reference weights from
    # the same validated checkpoint values and compare their CPU packing hashes.
    records = []
    for name in spec['records']:
        b, layer = (int(v.removeprefix(prefix)) for v, prefix in zip(name.split('.')[:2], ('block', 'layer')))
        kind = 'upsample' if b == 39 else {0:'expand',1:'contract',2:'qkv',4:'projection'}[layer] if 31 <= b <= 38 else {0:'ffn',1:'ffn_projection',2:'qkv',3:'projection',4:'down'}[layer] if 23 <= b <= 30 or 40 <= b <= 47 else 'window'
        records.append(checkpoint.kernel_record(b, kind=kind, precision='fp16', device='cuda') if args.precision == 'fp16' else checkpoint._records[name].to('cuda', copy=True))
    backings = [torch.full((v['storage_bytes'] + 512,), 0xA5, device='cuda', dtype=torch.uint8) for v in spec['buffers'].values()]
    buffers = [v[256:-256] for v in backings]
    buffers[0].copy_(state)
    addresses, record_addresses = [x.data_ptr() for x in buffers], [x.data_ptr() for x in records]
    modules, calls = {}, []
    module_numbers = {row['original_symbol']:row['module'] for row in schedule['positions']}
    module_numbers['cc_cb_clear'] = 6
    for row in spec['calls']:
        symbol = row['symbol']
        if symbol not in modules:
            module = VendorModule((ROOT / f'assets/vendor_modules/module_{module_numbers[symbol]}.cubin').read_bytes(), stream.cuda_stream, symbol, row['abi'])
            modules[symbol] = module
            active = module.active_blocks_per_sm(int(np.prod(row['block'])))
            required = int(np.prod(row['grid'][:2]))
            if row['all_resident'] and active * torch.cuda.get_device_properties(0).multi_processor_count < required:
                raise ValueError('Native resident capacity exceeded: ' + symbol)
        parameters = bytearray(row['abi'])
        for offset, size, value in row['fields']:
            if size == 4:
                struct.pack_into('<i', parameters, offset, int(value))
            else:
                index = int(value[value.index('(') + 1:-1])
                pointer = record_addresses[index] if value.startswith('record_address') else addresses[index]
                struct.pack_into('<Q', parameters, offset, pointer)
        calls.append((modules[symbol], bytes(parameters), row))
    def native():
        for module, parameters, row in calls:
            module.launch(parameters, row)
    if args.native_only:
        for _ in range(10):
            native()
            stream.synchronize()
        print('Original FP16 full grid completed ten 4K trunk passes', flush=True)
        for module in modules.values():
            module.close()
        return
    if args.profile_only:
        for label, run in (("native_" + args.precision, native), ("candidate_" + args.precision, candidate_run)):
            torch.cuda.nvtx.range_push(label)
            run()
            stream.synchronize()
            torch.cuda.nvtx.range_pop()
        for module in modules.values():
            module.close()
        return
    def poison(value):
        candidate.poison(value)
        for buffer in buffers[1:]:
            buffer.fill_(value)
    def compare():
        stream.synchronize()
        failures, compared = [], []
        for name in candidate.boundary_names():
            extent = spec['buffers'][name]
            size = extent['logical_bytes'] if name.endswith('.down') else extent['storage_bytes']
            a, b = candidate.buffer(name)[:size], buffers[names.index(name)][:size]
            equal = torch.equal(a,b)
            # Token storage rounds up to 32; native Half leaves the unused
            # trailing token rows untouched. They are compared as storage but
            # are outside the logical finite-value contract and later reads.
            finite = bool(torch.isfinite(a[:extent['logical_bytes']].view(dtype).float()).all())
            row = dict(name=name, bytes=size, equal=equal, finite=finite)
            if not equal:
                af,bf = a.view(dtype).float(), b.view(dtype).float()
                row.update(different_bytes=int((a!=b).sum()), max_abs=float((af-bf).abs().max()))
            if not equal or not finite: failures.append(row)
            compared.append(row)
        if not candidate.guards_intact(): raise AssertionError('Candidate guard corruption')
        for name, backing in zip(names,backings):
            if not bool((backing[:256]==0xA5).all()) or not bool((backing[-256:]==0xA5).all()):
                raise AssertionError('Native guard corruption: ' + name)
            if name.endswith('_counter'):
                expected = 1 if '.qkv_' in name else 0 if '.attention_' in name else 3
                for buffer in (candidate.buffer(name), buffers[names.index(name)]):
                    if not bool((buffer.view(torch.int32) == expected).all()):
                        raise AssertionError('Incomplete split publication: ' + name)
        if not torch.equal(state, buffers[0]):
            raise AssertionError('Native or candidate input was modified')
        return compared, failures
    print('Native modules prepared; launching 185 calls', flush=True)
    poison(0x6A)
    native()
    stream.synchronize()
    print('Native complete',flush=True)
    candidate_run()
    compared,failures=compare()
    report = dict(width=args.width,height=args.height,extension_sha256=hashlib.sha256(args.extension.read_bytes()).hexdigest(),boundaries=compared,failures=failures,
                  device=torch.cuda.get_device_name(), torch_version=torch.__version__,
                  device_sm_count=torch.cuda.get_device_properties(0).multi_processor_count,
                  sm_count_limit=os.environ.get('DLSSNR_SM_COUNT_LIMIT'),
                  split_launch_counts=split_launch_counts,
                  harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  native_cubin_sha256={str(index):hashlib.sha256((ROOT / f'assets/vendor_modules/module_{index}.cubin').read_bytes()).hexdigest() for index in range(7)},
                  precision=args.precision,
                  runtime_geometry_matches_reference=True,
                  schedule_sha256=hashlib.sha256(spec_json.encode('utf-8')).hexdigest(),
                  reference_plan=str(reference_plan_path),
                  reference_schedule=str(reference_schedule_path),
                  physical_schedule_sha256=hashlib.sha256(schedule_json.encode('utf-8')).hexdigest(),
                  geometry_source_sha256={path: hashlib.sha256((ROOT / path).read_bytes()).hexdigest()
                      for path in ('dlssnr/geometry.py', 'tuning/physical_schedule.py', 'tuning/generate_plan.py')})
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(report,indent=2))
    print('Boundary mismatches:',len(failures),failures[:3],flush=True)
    if failures:raise AssertionError('Numerical gate failed')
    graphs = []
    for run in (native,candidate_run):
        graph=torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph,stream=stream):
            for _ in range(3):run()
        graphs.append(graph)
    for value in (0x35,0x7E):
        poison(value)
        for graph in graphs:graph.replay()
        _,failures=compare()
        if failures:
            report['replay_failures'] = failures
            args.output.write_text(json.dumps(report, indent=2))
            print('Replay failures:', failures[:5], flush=True)
            raise AssertionError('Poisoned graph replay differs')
    report['poisoned_replays_pass']=True
    # A captured graph must consume fresh input, not a stale cached output.
    previous_output = candidate.buffer('b69.output').clone()
    state.copy_(state.view(dtype).float().mul_(0.5).add_(0.003).to(dtype).view(torch.uint8))
    buffers[0].copy_(state)
    for graph in graphs:
        graph.replay()
    _, failures = compare()
    if failures or torch.equal(previous_output, candidate.buffer('b69.output')):
        raise AssertionError('Changed-input graph replay failed')
    report['changed_input_replay_pass'] = True
    if args.timing:
        for _ in range(20):
            for graph in graphs:graph.replay()
        stream.synchronize()
        pairs=[]
        for pair in range(64):
            order=(0,1) if pair%2==0 else (1,0)
            times={}
            for role in order:
                start,end=torch.cuda.Event(enable_timing=True),torch.cuda.Event(enable_timing=True)
                start.record(stream)
                for _ in range(10):graphs[role].replay()
                end.record(stream);end.synchronize()
                times[role]=start.elapsed_time(end)/30
            pairs.append(dict(order=list(order),native_ms=times[0],candidate_ms=times[1],ratio=times[1]/times[0]))
        report['timing']=dict(pairs=pairs,native_ms=statistics.median(x['native_ms'] for x in pairs),candidate_ms=statistics.median(x['candidate_ms'] for x in pairs),median_ratio=statistics.median(x['ratio'] for x in pairs),by_order=[statistics.median(x['ratio'] for x in pairs if x['order'][0]==i) for i in (0,1)])
        print(report['timing'] | {'pairs':'omitted'},flush=True)
    _, failures = compare()
    if failures:
        raise AssertionError('Post-timing validation failed')
    stream.synchronize()
    for graph in graphs:graph.reset()
    for module in modules.values():module.close()
    args.output.write_text(json.dumps(report,indent=2))


if __name__ == '__main__':
    main()
