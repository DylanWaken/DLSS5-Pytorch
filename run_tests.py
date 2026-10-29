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
# Legacy modules are executed as scripts (module-level asserts under
# ``if __name__ == "__main__"``); they are kept exactly as before so the
# existing -O behavior is preserved.
CPU_SCRIPT_TESTS = (
    "test_speed_cpu.py",
    "test_speed_build_cpu.py",
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
# pytest-function modules.  Running them as scripts would import the file and
# silently skip every assertion, so they are handed to pytest explicitly.
CPU_PYTEST_TESTS = (
    "test_runtime_assets_cpu.py",
    "test_small_model_cpu.py",
    "test_small_plan_cpu.py",
    "test_small_deployment_cpu.py",
    "test_small_attention_cpu.py",
    "test_video_cpu.py",
)


def _run_cpu_scripts(optimized: bool) -> list[tuple[str, int]]:
    """Run every legacy script check and return ``(label, exit_code)`` results.

    Execution continues after a failure so a broken legacy check cannot hide the
    pytest modules; the aggregate exit status is still non-zero.
    """
    results = []
    for name in CPU_SCRIPT_TESTS:
        source = ROOT / "tests" / name
        if not source.is_file():
            raise FileNotFoundError(source)
        label = name + (" (-O)" if optimized else "")
        command = [sys.executable, "-B"] + (["-O"] if optimized else []) + [str(source)]
        print("CPU check: " + label, flush=True)
        results.append((label, subprocess.run(command, cwd=ROOT).returncode))
    return results


def _run_cpu_pytest(optimized: bool) -> tuple[str, int]:
    sources = [ROOT / "tests" / name for name in CPU_PYTEST_TESTS]
    for source in sources:
        if not source.is_file():
            raise FileNotFoundError(source)
    command = ([sys.executable, "-B"] + (["-O"] if optimized else [])
               + ["-m", "pytest", "-q", "-p", "no:cacheprovider"]
               + [str(source) for source in sources])
    label = "pytest " + ", ".join(CPU_PYTEST_TESTS) + (" (-O)" if optimized else "")
    print("CPU pytest: " + label, flush=True)
    return label, subprocess.run(command, cwd=ROOT).returncode


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode", choices=("cpu", "numerical", "paired", "training"))
    p.add_argument("--optimized", action="store_true", help="also run CPU checks with python -O")
    args, rest = p.parse_known_args()
    if args.mode == "cpu":
        if rest:
            p.error("CPU mode does not accept GPU worker arguments")
        results = []
        for optimized in ((False, True) if args.optimized else (False,)):
            results.extend(_run_cpu_scripts(optimized))
            results.append(_run_cpu_pytest(optimized))
        failed = [(label, code) for label, code in results if code != 0]
        print(
            f"CPU summary: {len(results) - len(failed)}/{len(results)} checks passed",
            flush=True)
        if failed:
            for label, code in failed:
                print(f"CPU FAILED: {label} (exit {code})", flush=True)
            raise SystemExit(1)
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
