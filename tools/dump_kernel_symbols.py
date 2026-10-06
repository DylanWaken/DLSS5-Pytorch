"""Resolve stable deployment names to this extension's compiled CUDA symbols.

This explicit diagnostic loads the chosen extension and uses the CUDA runtime.
It does not launch kernels. Source-template names must not be hand-mangled in
Driver fixtures or disassembly tooling.
"""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--extension', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    import torch
    torch.ops.load_library(str(args.extension.resolve()))
    names = sorted(json.loads((ROOT / 'tuning/canonical_kernel_names.json').read_text()).values())
    symbols = {name: torch.ops.dlssnr.kernel_symbol(name) for name in names}
    if len(symbols) != 81 or len(set(symbols.values())) != 81:
        raise RuntimeError('Expected 81 distinct compiled specializations')
    try:
        torch.ops.dlssnr.kernel_symbol('unknown_kernel')
    except RuntimeError:
        pass
    else:
        raise AssertionError('Unknown logical names must fail explicitly')
    report = dict(extension_sha256=hashlib.sha256(args.extension.read_bytes()).hexdigest(),
                  symbols=symbols, unknown_name_rejected=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n', encoding='utf8')
    print(f'Resolved {len(symbols)} CUDA symbols; unknown-name rejection passed.')


if __name__ == '__main__':
    main()
