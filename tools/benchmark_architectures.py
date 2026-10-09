"""Compare deployment libraries on one GPU with an in-process DLL reference.

Every case runs in a fresh, bounded child process because Torch registrations
cannot be replaced. Libraries may contain native cubins, older source paths
compiled offline for the actual GPU, or PTX for driver JIT. Labels alone do not
identify that route; all timings measure the reported physical GPU.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import statistics
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
SIZES = {"720p": (1280, 720), "1080p": (1920, 1080),
         "2k": (2560, 1440), "4k": (3840, 2160)}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def telemetry():
    command = ["nvidia-smi", "--query-gpu=name,uuid,driver_version,temperature.gpu,"
               "power.draw,clocks.sm,clocks.mem,utilization.gpu,memory.used", "--format=csv"]
    try:
        return subprocess.check_output(command, text=True, timeout=15).strip()
    except (OSError, subprocess.SubprocessError) as error:
        return str(error)


def terminate_process_tree(process):
    """Stop this case and its children before allowing another GPU case."""
    cleanup = {}
    try:
        if os.name == "nt":
            # Kill the tree while the parent still exists: killing the parent
            # first can orphan the interpreter launched by Windows venv Python.
            result = subprocess.run(
                ["taskkill", "/PID", str(process.pid), "/T", "/F"],
                capture_output=True, text=True, timeout=30)
            cleanup.update(method="taskkill /T /F", returncode=result.returncode,
                           stdout=result.stdout.strip(), stderr=result.stderr.strip(),
                           tree_termination_confirmed=result.returncode == 0)
        else:
            # The child starts its own session; its process group contains only
            # this benchmark and descendants, never the invoking shell.
            os.killpg(process.pid, signal.SIGKILL)
            cleanup.update(method="killpg SIGKILL", tree_termination_confirmed=True)
    except (OSError, subprocess.SubprocessError) as error:
        cleanup.update(error=str(error), tree_termination_confirmed=False)
    try:
        cleanup["parent_returncode"] = process.wait(timeout=15)
    except subprocess.TimeoutExpired:
        # This is a failed cleanup, not permission to continue the sweep.
        cleanup["parent_still_running"] = True
        cleanup["tree_termination_confirmed"] = False
    return cleanup


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--library", action="append", nargs=3, required=True,
                        metavar=("LABEL", "PRECISION", "PATH"))
    parser.add_argument("--sizes", nargs="+", choices=SIZES, default=list(SIZES))
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--baseline", default="sm120")
    parser.add_argument("--timeout", type=int, default=600)
    args = parser.parse_args()
    args.output = args.output.resolve()
    if args.timeout <= 0:
        parser.error("Timeout must be positive")
    libraries = []
    identities = set()
    for label, precision, filename in args.library:
        if not re.fullmatch(r"[a-zA-Z0-9_-]+", label) or precision not in ("fp16", "fp8"):
            parser.error("Use simple library labels and precision fp16 or fp8")
        if (label, precision) in identities:
            parser.error("Duplicate label/precision")
        identities.add((label, precision))
        path = Path(filename).resolve(strict=True)
        libraries.append((label, precision, path, digest(path)))
    if args.output.exists():
        parser.error("Output already exists; choose a fresh directory")
    args.output.mkdir(parents=True)
    worker = ROOT / "tools/benchmark_fp16.py"
    harness_hash = digest(worker)
    environment = os.environ.copy()
    # Exercise normal device occupancy and image selection. Force-JIT would also
    # affect Torch and the DLL, contaminating the paired reference comparison.
    excluded = ("DLSSNR_SM_COUNT_LIMIT", "CUDA_FORCE_PTX_JIT", "CUDA_DISABLE_PTX_JIT",
                "CUDA_FORCE_JIT", "CUDA_DISABLE_JIT", "CUDA_LAUNCH_BLOCKING")
    for name in excluded:
        environment.pop(name, None)
    summary = {
        "started_utc": datetime.now(timezone.utc).isoformat(),
        "scope": "Prepared-feature trunk (185 logical calls); steady-state CUDA graph replay",
        "interpretation": ("All timings are on the reported physical GPU. Library labels do not establish "
                           "native cubin, offline cross-target compilation, or PTX JIT; use build receipts "
                           "and binary inspection to identify the route."),
        "baseline": args.baseline,
        "cleared_environment": {name: os.environ[name] for name in excluded if name in os.environ},
        "cases": [],
    }

    def save_summary():
        cases = summary["cases"]
        baselines = {(row["precision"], row["size"]): row for row in cases
                     if row["label"] == args.baseline}
        for row in cases:
            baseline = baselines.get((row["precision"], row["size"]))
            if baseline:
                # Both operands are median paired ratios against the same DLL.
                row["dll_normalized_delta_vs_baseline_pct"] = 100 * (
                    row["median_paired_ratio"] / baseline["median_paired_ratio"] - 1)
        (args.output / "summary.json").write_text(json.dumps(summary, indent=2) + "\n", encoding="utf8")

    for size_index, size in enumerate(args.sizes):
        width, height = SIZES[size]
        # Rotate case order across sizes to spread process order and warmup bias.
        order = libraries[size_index % len(libraries):] + libraries[:size_index % len(libraries)]
        for label, precision, library, library_hash in order:
            stem = f"{label}_{precision}_{size}"
            result_path = args.output / f"{stem}.json"
            receipt_path = args.output / f"{stem}.run.json"
            command = [sys.executable, "-B", str(worker), "--precision", precision,
                       "--width", str(width), "--height", str(height), "--extension", str(library),
                       "--output", str(result_path), "--timing"]
            receipt = {"command": command, "before": telemetry(),
                       "started_utc": datetime.now(timezone.utc).isoformat()}
            print(f"Starting {stem}", flush=True)
            started = time.monotonic()
            with (args.output / f"{stem}.log").open("w", encoding="utf8") as log:
                try:
                    process = subprocess.Popen(command, cwd=ROOT, env=environment,
                                               stdout=log, stderr=subprocess.STDOUT,
                                               start_new_session=os.name != "nt")
                    receipt["pid"] = process.pid
                    try:
                        receipt["returncode"] = process.wait(timeout=args.timeout)
                    except subprocess.TimeoutExpired:
                        receipt["returncode"] = "timeout"
                        receipt["cleanup"] = terminate_process_tree(process)
                        log.write("\nBenchmark timed out; process-tree cleanup: " +
                                  json.dumps(receipt["cleanup"]) + "\n")
                except OSError as error:
                    receipt.update(returncode="launch_error", error=str(error))
                    log.write("\nBenchmark could not start: " + str(error) + "\n")
            receipt.update(elapsed_seconds=time.monotonic() - started, after=telemetry())
            receipt_path.write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf8")
            if receipt["returncode"] != 0:
                raise RuntimeError(f"{stem} failed; inspect its log and receipt")
            result = json.loads(result_path.read_text(encoding="utf8"))
            if (result["extension_sha256"] != library_hash or result["harness_sha256"] != harness_hash
                    or result["precision"] != precision or (result["width"], result["height"]) != (width, height)):
                raise RuntimeError(f"{stem} does not match the requested library, harness or shape")
            if result["failures"] or not result.get("poisoned_replays_pass") or not result.get("changed_input_replay_pass"):
                raise RuntimeError(f"{stem} failed correctness")
            timing = result["timing"]
            if len(timing["pairs"]) != 64:
                raise RuntimeError(f"{stem} has incomplete timing samples")
            ratios = [pair["ratio"] for pair in timing["pairs"]]
            deciles = statistics.quantiles(ratios, n=10)
            row = dict(label=label, precision=precision, size=size, width=width, height=height,
                       device=result["device"], device_sm=result["device_sm"],
                       compiled_architectures=result["compiled_architectures"],
                       extension_sha256=library_hash, library=str(library),
                       candidate_ms=timing["candidate_ms"], dll_ms=timing["native_ms"],
                       median_paired_ratio=timing["median_ratio"], by_order=timing["by_order"],
                       ratio_p10=deciles[0], ratio_p90=deciles[-1],
                       logical_calls=len(result["split_launch_counts"]),
                       actual_launches=sum(result["split_launch_counts"]),
                       boundaries=len(result["boundaries"]), result=str(result_path))
            summary["cases"].append(row)
            save_summary()
            print(f"Finished {stem}: {row['candidate_ms']:.4f} ms; "
                  f"DLL {row['dll_ms']:.4f} ms; paired ratio {row['median_paired_ratio']:.5f}", flush=True)
    summary["finished_utc"] = datetime.now(timezone.utc).isoformat()
    save_summary()


if __name__ == "__main__":
    main()
