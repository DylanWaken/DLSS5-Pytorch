"""Opt-in host admission test, including FP8 rejection from compute80 PTX JIT."""
import argparse
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--extension', type=Path, required=True)
    parser.add_argument('--targets', nargs='+', type=int, required=True)
    parser.add_argument('--fp8', choices=('available', 'rejected'), required=True)
    parser.add_argument('--report', type=Path, required=True)
    args = parser.parse_args()
    import torch
    from dlssnr.deployment import load_extension

    ops = load_extension(args.extension)
    assert list(ops.deployment_build_architectures()) == args.targets
    anchor = torch.zeros(1, device='cuda', dtype=torch.uint8)
    device_sm = 10 * torch.cuda.get_device_capability()[0] + torch.cuda.get_device_capability()[1]
    manifest = json.loads((ROOT / 'tuning/reconstruction/c512.json').read_text(encoding='utf8'))['entries']
    rows = list(ops.prepare_c512_fp16(anchor, 1))
    expected_ids = [entry['id'] for entry in manifest if entry['element_bytes'] == 2]
    assert len(rows) == 63 and rows[::7] == expected_ids
    assert rows[2::7] == [device_sm] * 9
    errors = []
    for function, index in ((ops.prepare_c512_fp8, 0), (ops.prepare_window_fp8, 3)):
        if args.fp8 == 'available':
            assert function(anchor, index)
        else:
            try:
                function(anchor, index)
            except RuntimeError as error:
                assert 'FP8' in str(error) and ('virtual SM' in str(error) or 'requires SM89' in str(error))
                errors.append(str(error))
            else:
                raise AssertionError('Unsupported FP8 image was admitted')
    # A rejected prepare must not launch a trap or poison the CUDA context.
    anchor.add_(1)
    torch.cuda.synchronize()
    assert anchor.item() == 1
    report = dict(pass_=True, compiled_targets=args.targets, device_sm=device_sm,
                  fp16_prepared_entries=len(rows)//7, fp8=args.fp8, rejection_errors=errors)
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2)+'\n', encoding='utf8')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
