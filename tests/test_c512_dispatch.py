"""Focused C512 public-dispatch packing validation in an isolated GPU worker.

Compares all18 C512 APIs against direct Driver launches of the *same compiled
candidate kernels*. This verifies host argument packing, not NVIDIA parity.
FP8 uses its admitted68x120 field (channel expansion36x60); FP16 uses the
separately admitted16x24 field. Both QKV entries exercise allfour origins.
"""
from pathlib import Path
import argparse
import hashlib
import json
import struct
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from tools.native_reference.lifetime import NativeGraphOwner, cli


def direct_parameters(entry, addresses, height, width, phase):
    """Use the pre-existing reconstruction manifest, independent of renamed ABI."""
    shift_x, shift_y = ((0, 0), (4, 4), (4, 0), (0, 4))[phase]
    pool_height, pool_width = ((height + 7) // 8) * 4, ((width + 7) // 8) * 4
    scalars = dict(height=height, width=width, origin_x=-shift_x, origin_y=-shift_y,
                   low_height=pool_height, low_width=pool_width,
                   pool_height=pool_height, pool_width=pool_width)
    blob = bytearray(entry['abi_bytes'])
    for role, offset in entry['pointer_fields'].items():
        struct.pack_into('<Q', blob, offset, addresses[role])
    for role, offset in entry['scalar_fields'].items():
        struct.pack_into('<i', blob, offset, scalars[role])
    tile_x, tile_y = (width + 7) // 8, (height + 7) // 8
    role = entry['role']
    if role == 4:
        grid = [(width + shift_x + 7) // 8, (height + shift_y + 7) // 8, 4]
    elif role in (0, 1):
        grid = [tile_x, tile_y, 2]
    elif role == 8:
        grid = [4 * tile_x, tile_y, 1]
    else:
        grid = [2 * tile_x, tile_y, 1]
    return bytes(blob), dict(grid=grid, block=entry['block'])


def execute(args, report):
    import torch
    from dlssnr.checkpoint import load_checkpoint
    from tools.native_reference.vendor_benchmark import VendorModule, GUARD_BYTES, GUARD_VALUE
    torch.set_num_threads(4)
    torch.cuda.set_device(args.device)
    major, minor = torch.cuda.get_device_capability(args.device)
    device_sm = 10 * major + minor
    if torch.cuda.get_device_capability(args.device) != (12, 0):
        raise RuntimeError('This compiled-dispatch qualification requires SM120')
    torch.ops.load_library(str(args.extension.resolve()))
    report['extension_sha256'] = hashlib.sha256(args.extension.read_bytes()).hexdigest()
    image_report = json.loads((args.cubins / 'comparison.json').read_text(encoding='utf8'))
    if report['extension_sha256'] != image_report['candidate_binary_sha256']:
        raise ValueError('Extension differs from the recorded extracted candidate image')
    # This test compares two launch paths for the candidate, not old/new code.
    # Bind each extracted module to the candidate manifest; a readability
    # refactor is allowed to change instructions from the preceding build.
    candidate_modules = {}
    for module in image_report['modules']:
        name = module['module']
        if name in candidate_modules:
            raise ValueError('Duplicate candidate module: ' + name)
        cubin = (args.cubins / name).read_bytes()
        if hashlib.sha256(cubin).hexdigest() != module['candidate_sha256']:
            raise ValueError('Extracted cubin differs from candidate manifest: ' + name)
        candidate_modules[name] = cubin
    entries = json.loads((ROOT / 'tuning/reconstruction/c512.json').read_text())['entries']
    canonical = json.loads((ROOT / 'tuning/canonical_kernel_names.json').read_text())
    checkpoints = {precision: load_checkpoint(ROOT / f'ckpts/dlss5_nr_{precision}.pt')
                   for precision in ('fp8', 'fp16')}
    stream = torch.cuda.Stream(device=args.device)
    stream.wait_stream(torch.cuda.current_stream(args.device))
    torch.cuda.set_stream(stream)

    for entry in entries:
        precision = 'fp8' if entry['element_bytes'] == 1 else 'fp16'
        entry_id, role = entry['id'], entry['role']
        height, width = (16, 24) if precision == 'fp16' else ((36, 60) if role == 8 else (68, 120))
        image_bytes = height * width * 512 * entry['element_bytes']
        pool_height, pool_width = ((height + 7) // 8) * 4, ((width + 7) // 8) * 4
        pool_bytes = pool_height * pool_width * 512 * entry['element_bytes']
        block_index = 23 if role in (1, 3) else 47 if role == 6 else 30 if role in (7, 8) else 24
        layer_index = {0: 0, 1: 0, 2: 1, 3: 1, 4: 2, 5: 3, 6: 3, 7: 3, 8: 4}[role]
        kind = {0: 'ffn', 1: 'ffn_projection', 2: 'qkv', 3: 'projection', 4: 'down'}[layer_index]
        checkpoint = checkpoints[precision]
        if precision == 'fp8':
            record = checkpoint._records[f'block{block_index}.layer{layer_index}.layer'].clone()
        else:
            record = checkpoint.kernel_record(block_index, kind=kind, precision=precision)
        if record.numel() != entry['record_bytes']:
            raise ValueError(f'Record extent differs for C512 entry{entry_id}')
        kernel_name = canonical[entry['original_symbol']].split('::')[-1]
        candidate_symbol = torch.ops.dlssnr.kernel_symbol(kernel_name)
        matches = [row for row in image_report['entries'] if row['symbol'] == candidate_symbol]
        if len(matches) != 1:
            raise ValueError('Missing unique compiled candidate symbol: ' + kernel_name)
        cubin = candidate_modules[matches[0]['module']]
        phases = range(4) if role == 4 else (0,)
        for phase in phases:
            with NativeGraphOwner(stream.synchronize, label=f'C512 public dispatcher {entry_id}/{phase}') as owner:
                driver = owner.own(VendorModule(cubin, stream.cuda_stream, candidate_symbol, entry['abi_bytes']))
                allocations = {}
                payloads = {}

                def allocate(name, byte_count, initial=None):
                    backing = owner.retain(torch.full((byte_count + 2 * GUARD_BYTES,), GUARD_VALUE,
                                                      dtype=torch.uint8, device=args.device))
                    payload = owner.retain(backing[GUARD_BYTES:-GUARD_BYTES])
                    if initial is None:
                        payload.fill_(0x6A)
                    else:
                        payload.copy_(initial.to(device=args.device).view(torch.uint8).flatten())
                    allocations[name], payloads[name] = backing, payload
                    return payload

                dtype = torch.float8_e4m3fn if precision == 'fp8' else torch.float16
                torch.manual_seed(1300 + entry_id * 11 + phase)
                finite_input = (torch.randn(height * width * 512, dtype=torch.float16,
                                             device=args.device) * .02).to(dtype).view(torch.uint8)
                allocate('state', image_bytes, finite_input)
                allocate('record', entry['record_bytes'], record)
                if 'skip' in entry['input_roles']:
                    residual = (torch.randn(height * width * 512, dtype=torch.float16,
                                            device=args.device) * .015).to(dtype).view(torch.uint8)
                    allocate('skip', image_bytes, residual)
                for route in ('driver', 'torch'):
                    allocate(route + '.high', image_bytes * (2 if role == 8 else 1))
                    if role == 7:
                        allocate(route + '.pool', pool_bytes)
                immutable_names = list(entry['input_roles'])
                snapshots = {name: owner.retain(allocations[name].clone()) for name in immutable_names}
                inputs = owner.retain([payloads[name] for name in entry['input_roles']])
                outputs = owner.retain([payloads['torch.' + name] for name in entry['output_roles']])
                prepare = getattr(torch.ops.dlssnr, 'prepare_c512_' + precision)
                launch = getattr(torch.ops.dlssnr, 'c512_out_' + precision)
                resources = list(prepare(payloads['state'], entry_id))
                expected_ids = [row['id'] for row in entries if row['element_bytes'] == entry['element_bytes']]
                assert len(resources) == 9 * 7
                assert resources[::7] == expected_ids
                assert resources[2::7] == [device_sm] * 9
                addresses = {name: payload.data_ptr() for name, payload in payloads.items() if '.' not in name}
                addresses.update({name: payloads['driver.' + name].data_ptr() for name in entry['output_roles']})
                parameters, launch_spec = direct_parameters(entry, addresses, height, width, phase)
                owner.retain((parameters, launch_spec))
                row = dict(entry=entry_id, kernel=kernel_name, precision=precision, height=height, width=width,
                           phase=phase, record=f'block{block_index}.layer{layer_index}.layer',
                           cubin_sha256=hashlib.sha256(cubin).hexdigest(), checks=[])
                report['cases'].append(row)

                def launch_torch():
                    returned = launch(entry_id, inputs, outputs, height, width, phase)
                    if len(returned) != len(outputs) or any(actual.data_ptr() != supplied.data_ptr()
                                                            for actual, supplied in zip(returned, outputs)):
                        raise AssertionError('Torch out API returned different output storage')

                def verify(stage):
                    stream.synchronize()
                    differences = {name: int(torch.count_nonzero(payloads['driver.' + name] !=
                                                                 payloads['torch.' + name]))
                                   for name in entry['output_roles']}
                    guards = all(bool(torch.all(tensor[:GUARD_BYTES] == GUARD_VALUE)) and
                                 bool(torch.all(tensor[-GUARD_BYTES:] == GUARD_VALUE))
                                 for tensor in allocations.values())
                    immutable = all(torch.equal(allocations[name], snapshots[name]) for name in immutable_names)
                    result = dict(stage=stage, different_bytes=differences, guards_intact=guards,
                                  inputs_and_weights_immutable=immutable,
                                  passed=not any(differences.values()) and guards and immutable)
                    row['checks'].append(result)
                    if not result['passed']:
                        raise AssertionError(f'C512 public dispatch mismatch: {entry_id}/{phase}/{stage}: {result}')

                driver.launch(parameters, launch_spec)
                launch_torch()
                verify('eager')
                graphs = []
                for route in ('driver', 'torch'):
                    graph = owner.graph(torch.cuda.CUDAGraph())
                    with owner.capture(graph, torch.cuda.graph(graph, stream=stream)):
                        if route == 'driver':
                            driver.launch(parameters, launch_spec)
                        else:
                            launch_torch()
                    graphs.append(graph)
                for replay in range(3):
                    if replay == 2:
                        changed_input = (torch.randn(height * width * 512, dtype=torch.float16,
                                                      device=args.device) * .025).to(dtype).view(torch.uint8)
                        payloads['state'].copy_(changed_input)
                        snapshots['state'].copy_(allocations['state'])
                    for route in ('driver', 'torch'):
                        for name in entry['output_roles']:
                            payloads[route + '.' + name].fill_(0x61 + replay)
                    for graph in graphs:
                        graph.replay()
                    verify('changed_input_replay' if replay == 2 else f'poisoned_replay_{replay}')
                row['passed'] = True
            # owner synchronizes, destroys graphs, then unloads Driver resources.
            print(json.dumps(dict(entry=entry_id, phase=phase, passed=True)), flush=True)
            args.output.write_text(json.dumps(report, indent=2) + '\n')
    report['entry_count'] = len({row['entry'] for row in report['cases']})
    report['case_count'] = len(report['cases'])
    report['passed'] = report['entry_count'] == 18 and report['case_count'] == 24 and all(row['passed'] for row in report['cases'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--extension', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--cubins', type=Path, required=True,
                        help='Candidate cuobjdump images with their comparison.json SHA/symbol manifest')
    parser.add_argument('--device', type=int, default=0)
    args = parser.parse_args()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    report = dict(scope='C512 public host dispatcher versus identical compiled candidate Driver kernel',
                  passed=False, cases=[])
    try:
        execute(args, report)
    except BaseException as error:
        report['error'] = type(error).__name__ + ': ' + str(error)
        raise
    finally:
        args.output.write_text(json.dumps(report, indent=2) + '\n')
    if not report['passed']:
        raise RuntimeError('Incomplete C512 public-dispatch qualification')
    print(json.dumps(dict(passed=True, entries=report['entry_count'], cases=report['case_count'])), flush=True)


if __name__ == '__main__':
    cli(main)
