"""Explicit CPU support checks or isolated GPU benchmark worker entry point.

CPU checks do not load the CUDA extension; checkpoint checks use Torch on CPU.
Numerical/paired modes require benchmark identity arguments. Training accepts
the explicit public training benchmark options, including checkpointing.
"""
import argparse
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
CPU_TESTS = (
    "test_architecture_support_cpu.py",
    "test_dynamic_geometry_cpu.py",
    "test_kernel_sources_cpu.py",
    "test_split_launch_policy_cpu.py",
    "test_frontend_preprocess.py",
    "test_window_output_view.py",
    "test_checkpoint_cpu.py",
    "test_fp16_plan_cpu.py",
    "test_clean_records.py",
    "test_training_checkpoint_cpu.py",
    "test_resolution_policy_cpu.py",
    "test_resolution_policy_extrema_cpu.py",
    "test_reconstructed_benchmark_cpu.py",
    "test_prepared_kernel_api_cpu.py",
)

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode", choices=("cpu", "numerical", "paired", "training"))
    p.add_argument("--optimized", action="store_true", help="also run CPU checks with python -O")
    args, rest = p.parse_known_args()
    if args.mode == "cpu":
        if rest:
            p.error("CPU mode does not accept GPU worker arguments")
        for optimized in ((False, True) if args.optimized else (False,)):
            for name in CPU_TESTS:
                source = ROOT / "tests" / name
                if not source.is_file():
                    raise FileNotFoundError(source)
                command = [sys.executable, "-B"] + (["-O"] if optimized else []) + [str(source)]
                print("CPU check: " + name + (" (-O)" if optimized else ""), flush=True)
                subprocess.run(command, check=True, cwd=ROOT)
    elif args.mode == "training":
        if args.optimized:
            p.error("--optimized applies only to CPU checks")
        import runpy
        worker_path = ROOT / "tools/benchmark_training.py"
        sys.argv = [str(worker_path), *rest]
        runpy.run_path(str(worker_path), run_name="__main__")
    else:
        if args.optimized:
            p.error("--optimized applies only to CPU checks")
        sys.path.insert(0, str(ROOT))
        from tools.benchmark_reconstructed import main as worker
        sys.argv = [str(ROOT / "tools/benchmark_reconstructed.py"), "--mode", args.mode, *rest]
        worker()

if __name__ == "__main__":
    main()
