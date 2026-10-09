"""Profile a warmed deployment trunk through an explicitly selected library.

Trace mode surrounds CUDA graph replays with cudaProfilerStart/Stop for Nsight
Systems. NCU mode executes one direct trunk invocation in the NVTX push/pop
range "candidate"; select it with ncu --nvtx --nvtx-include candidate/.
Preparation, checkpoint loading and warmup occur outside either measured range.
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
    parser.add_argument('--width', type=int, default=2560)
    parser.add_argument('--height', type=int, default=1440)
    parser.add_argument('--mode', choices=('trace', 'ncu'), required=True)
    parser.add_argument('--replays', type=int, default=10,
                        help='Graph replays in trace mode; NCU mode always executes one invocation')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.width < 1 or args.height < 1:
        parser.error('--width and --height must be positive')
    if args.replays < 1:
        parser.error('--replays must be positive')
    args.extension = args.extension.expanduser().resolve()
    args.output = args.output.expanduser().resolve()
    if not args.extension.is_file():
        parser.error('--extension must name an existing deployment library')
    if args.output == args.extension:
        parser.error('--output must differ from the deployment library')
    if args.output.is_dir():
        parser.error('--output must name a JSON file, not a directory')

    import torch
    from dlssnr.checkpoint import load_checkpoint
    from dlssnr.deployment import load_extension
    from tuning.generate_plan import build_plan
    from tuning.physical_schedule import make

    torch.set_num_threads(8)
    torch.manual_seed(3108)
    stream = torch.cuda.Stream()
    torch.cuda.set_stream(stream)
    ops = load_extension(args.extension)
    spec = build_plan(make(args.width, args.height, precision=args.precision))
    dtype = torch.float16 if args.precision == 'fp16' else torch.float8_e4m3fn
    elements = spec['buffers']['input']['storage_bytes'] // (2 if args.precision == 'fp16' else 1)
    state = (torch.randn(elements, device='cuda', dtype=torch.float16) * .02).to(dtype).view(torch.uint8)
    checkpoint = load_checkpoint(ROOT / f'ckpts/dlss5_nr_{args.precision}.pt')
    plan = getattr(checkpoint, 'create_plan_' + args.precision)(state, width=args.width, height=args.height)
    run = getattr(plan, 'run_' + args.precision)
    for _ in range(5):
        run()
    stream.synchronize()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    major, minor = torch.cuda.get_device_capability()
    receipt = dict(precision=args.precision, width=args.width, height=args.height,
                   extension=str(args.extension),
                   extension_sha256=hashlib.sha256(args.extension.read_bytes()).hexdigest(),
                   device=torch.cuda.get_device_name(), device_sm=major * 10 + minor,
                   mode=args.mode, replays=args.replays if args.mode == 'trace' else 1,
                   compiled_architectures=list(ops.deployment_build_architectures()),
                   split_launch_counts=list(plan.split_launch_counts()),
                   calls=[dict(index=i, name=call['fn'], grid=call['grid'], block=call['block'])
                          for i, call in enumerate(spec['calls'])])
    args.output.write_text(json.dumps(receipt, indent=2) + '\n', encoding='utf8')
    print('Prepared and warmed', flush=True)
    if args.mode == 'trace':
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            run()
        for _ in range(20):
            graph.replay()
        stream.synchronize()
        torch.cuda.cudart().cudaProfilerStart()
        try:
            for _ in range(args.replays):
                graph.replay()
            stream.synchronize()
        finally:
            torch.cuda.cudart().cudaProfilerStop()
            graph.reset()
    else:
        # NCU filters this range; the preceding full schedule establishes all
        # producer buffers and counter state before the selected invocation.
        torch.cuda.nvtx.range_push('candidate')
        try:
            run()
            stream.synchronize()
        finally:
            torch.cuda.nvtx.range_pop()
    print('Profile workload complete', flush=True)


if __name__ == '__main__':
    main()
