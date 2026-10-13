"""Collect reproducible documentation evidence for all 81 public entries.

Run under NCU with --nvtx --nvtx-include docs/ --set full. Only the first
logical use of each public entry enters the docs range. Dependencies still
execute in their original order. Split launches remain intact. Supplemental
C32 exports use explicit, documented deployment-sized fixtures.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--extension', type=Path, required=True)
    parser.add_argument('--precision', choices=('fp16', 'fp8'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--only', default='')
    args = parser.parse_args()
    import torch
    from dlssnr import deployment
    from dlssnr.checkpoint import load_checkpoint
    from tuning.generate_plan import build_plan
    from tuning.physical_schedule import make

    torch.set_num_threads(8)
    torch.manual_seed(3108)
    stream = torch.cuda.Stream()
    torch.cuda.set_stream(stream)
    ops = deployment.load_extension(args.extension)
    fp16 = args.precision == 'fp16'
    e = 2 if fp16 else 1
    dtype = torch.float16 if fp16 else torch.float8_e4m3fn
    def field(n):
        return (torch.randn(n, device='cuda', dtype=torch.float16) * .02).to(dtype).view(torch.uint8)
    archive = load_checkpoint(ROOT / f'ckpts/dlss5_nr_{args.precision}.pt')
    shape = build_plan(make(3840, 2160, precision=args.precision))
    state = field(shape['buffers']['input']['storage_bytes'] // e)
    plan = getattr(archive, 'create_plan_' + args.precision)(state, width=3840, height=2160)
    run = getattr(plan, 'run_' + args.precision)
    for _ in range(5):
        run()
    stream.synchronize()
    sequence = deployment.prepare_kernels(plan)
    receipt = dict(precision=args.precision, width=3840, height=2160, seed=3108,
                   device=torch.cuda.get_device_name(), device_sm=10*torch.cuda.get_device_capability()[0]+torch.cuda.get_device_capability()[1],
                   compiled_architectures=list(ops.deployment_build_architectures()),
                   extension_sha256=hashlib.sha256(args.extension.read_bytes()).hexdigest(),
                   checkpoint_sha256=hashlib.sha256((ROOT/f'ckpts/dlss5_nr_{args.precision}.pt').read_bytes()).hexdigest(),
                   torch_version=torch.__version__, calls=[],
                   workload='4K deployment trunk; random packed input scaled by .02; checkpoint weights; five warmups. Supplemental renderer fixtures use raw/no-history point-sampled inputs, not a real frame.')
    seen = set()
    def measure(kernel, metadata):
        selected = kernel.name not in seen and (not args.only or kernel.name == args.only)
        seen.add(kernel.name)
        if selected:
            receipt['calls'].append(dict(name=kernel.name, **metadata))
            torch.cuda.nvtx.range_push('docs')
            torch.cuda.nvtx.range_push(kernel.name)
        kernel(kernel.inputs, kernel.outputs)
        if selected:
            stream.synchronize()
            torch.cuda.nvtx.range_pop()
            torch.cuda.nvtx.range_pop()
    for i, (kernel, call, launches) in enumerate(zip(sequence.kernels, shape['calls'], plan.split_launch_counts())):
        measure(kernel, dict(kind='trunk', logical_index=i, grid=call['grid'], block=call['block'],
                             dispatches=launches, abi_fields=call['fields'], all_resident=call['all_resident']))
    stream.synchronize()
    if not args.only or 'output_view' in args.only:
        h, w = 1088, 1920
        source = field(h*w*32)
        record = archive.kernel_record(1, kind='window', precision=args.precision, device='cuda')
        kernel = getattr(deployment, 'prepare_output_view_' + args.precision)(
            source, record, torch.empty_like(source), height=h, width=w, phase=1)
        for _ in range(5):kernel(kernel.inputs, kernel.outputs)
        stream.synchronize()
        measure(kernel, dict(kind='supplemental C32 output-view', height=h, width=w, phase=1,
                             dispatches=1, input='random native packed values; record 1; padded level-0 geometry'))
    for role in ('input_preprocess_window', 'input_preprocess_window_downsample', 'output_window_postprocess'):
        name = role + '_c32_' + args.precision
        if args.only and name != args.only:continue
        h, w = 2176, 3840
        post = role.startswith('output')
        record = archive.kernel_record(70 if post else 0, kind='postprocess' if post else 'preprocess',
                                      precision=args.precision, device='cuda')
        texture = torch.full((h,w,4), .25, dtype=torch.float32, device='cuda')
        empty = torch.empty(0, dtype=torch.float32, device='cuda')
        if post:
            inputs = [field(h*w*8), field(h*w*32), record, texture, empty, empty,
                      torch.empty(0, dtype=torch.uint8, device='cuda')]
            outputs = [torch.empty_like(texture)]
        else:
            inputs = [record, texture, empty, empty, empty, empty]
            outputs = [torch.empty(h*w*32*e, dtype=torch.uint8, device='cuda')]
            if role.endswith('downsample'):outputs.append(torch.empty(h*w*8*e, dtype=torch.uint8, device='cuda'))
        configuration = deployment.frontend_configuration(name, height=h, width=w, valid_height=2160,
                                                          valid_width=3840, phase=3 if post else 0, seed=3108)
        kernel = deployment.prepare_frontend(name, configuration, inputs, outputs)
        for _ in range(5):kernel(kernel.inputs, kernel.outputs)
        stream.synchronize()
        measure(kernel, dict(kind='supplemental renderer', height=h, width=w, valid_height=2160,
                             dispatches=1, input='constant .25 current/color HWC4; history/motion/depth/conditioning absent; point sampling; random packed postprocess inputs'))
        stream.synchronize()
        del kernel, inputs, outputs, texture
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(receipt, indent=2)+'\n', encoding='utf8')
    print(f'Completed {len(receipt["calls"])} selected public entries', flush=True)


if __name__ == '__main__':
    main()
