# Setup and quickstart

The CUDA deployment extension supports **batch one with FP16 on SM80+**
(including RTX 30 series / SM86) and **FP8 on SM89+** (RTX 40 series and newer).
FP32/BF16 training uses a separate ordinary PyTorch model.
See the [project overview](../README.md) and [network architecture](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html)
for coverage and performance scope.

## Windows environment and build

The measured environment uses Python 3.11, PyTorch 2.8.0+cu128, CUDA 12.8
compiler/runtime and CUDA 13.4's PTX assembler. Install Git LFS, a CUDA-capable
NVIDIA driver, CUDA 12.8 and Visual Studio C++ build tools first; install CUDA
13.4 as well if selecting its assembler below. Run
these commands from the repository root in a terminal with the C++ toolchain
available. Adjust toolkit paths to your installation.

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install torch==2.8.0 --index-url https://download.pytorch.org/whl/cu128
python -m pip install numpy setuptools wheel ninja
git lfs pull

$env:CUDA_HOME = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
$env:TORCH_CUDA_ARCH_LIST = "8.0;8.6;8.9;12.0"
$env:DLSSNR_BUILD_MODE = "split"
$env:DLSSNR_PTXAS_PATH = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.4\bin\ptxas.exe"
python setup.py build_ext --inplace
python -B run_tests.py cpu --optimized
```

`DLSSNR_PTXAS_PATH` is optional: omit that assignment to use CUDA 12.8's default
assembler. The published SM120 speed measurements use the newer assembler.
The CPU checks do not load the CUDA extension; inspect skipped
compiler-dependent checks separately.

### Architecture-specific binaries

Set `TORCH_CUDA_ARCH_LIST` to the targets needed for your deployment. With the
default `DLSSNR_BUILD_MODE=split`, the example builds four independent libraries:

| Target | Library stem | Deployment precisions |
|---|---|---|
| `8.0` · Ampere | `_C_sm80` | FP16 |
| `8.6` · RTX 30 series | `_C_sm86` | FP16 |
| `8.9` · RTX 40 series | `_C_sm89` | FP16 and FP8 |
| `12.0` · RTX 50 series / workstation Blackwell | `_C_sm120` | FP16 and FP8 |

The platform and Python ABI add the `.pyd` or `.so` suffix. Object directories
are also separate, so changing architectures cannot reuse the wrong objects.
For one GPU, specify just its target; if unset, the build uses visible devices.
A build server without a GPU must set the list explicitly. Other numeric targets
(for example `9.0`) work when the selected CUDA compiler supports them.

**The default deployment build compiles the CUDA/C++ sources into native cubins
ahead of time.** For example, `8.9` uses
`-gencode=arch=compute_89,code=sm_89`; the installed driver loads the machine
code directly. There is no runtime PTX compilation in the build above.

The loader selects the library using the input tensor's device. It prefers the
matching split library, then a compatible earlier minor target within the same
major architecture, then `_C`. It does not select an Ampere FP16-only library
for Ada FP8. Optional `+PTX`, such as `8.9+PTX`, also embeds virtual code for
forward JIT; it is only enabled when explicitly requested. Native SM89 cubins
cannot run on SM120, which is a different major architecture.

When constructing a frontend configuration before allocating its tensors, pass
`frontend_configuration(..., device="cuda:1")` to select the intended GPU's
library. Omitting `device` uses the current CUDA device.

For a process using GPUs from different architectures, build with
`DLSSNR_BUILD_MODE=fat`: this emits one `_C` library containing all requested
CUDA images. If split libraries are also installed, explicitly load that fat
library before preparing plans. CUDA then chooses the image per device; do not
load two registration libraries into the same process.

```python
from dlssnr.deployment import load_extension

ops = load_extension()  # Or pass a specific .pyd/.so path.
print(ops.deployment_build_architectures())  # Compiled targets, not performance qualification.
```

Per-device tuning files are merged from `tuning/sm_*.json`. Runtime selection
uses the actual device SM: SM120 measurements are not presented as Ampere or
Ada measurements. An untuned architecture uses the default kernel configuration
with actual occupancy checks and the existing ordered split-launch fallback.

### What changed for older architectures

The audit found SM120-only body guards and host checks, plus instructions that
need newer hardware. The device code now preserves the same tensor packing and
MMA flow while selecting these instruction paths at compile time:

| Operation | SM80 / SM86 / SM89 path | SM90+ path |
|---|---|---|
| Select bulk-copy producers | All 32 lanes of the participating warp | One issuer selected by `elect.sync` |
| Global-to-shared bulk copy | Adjacent lanes issue adjacent 16-byte `cp.async` copies; one or two copies per lane for 512/1024-byte tiles | One `cp.async.bulk` for the tile |
| Copy completion | Each producer attaches its own copies with `cp.async.mbarrier.arrive`; readers use `mbarrier.test_wait` | Transaction-byte tracking and `mbarrier.try_wait` |
| Four Half2 atomic reductions | Four scalar Half2 reductions | Vector Half2 reduction |
| Exclusive FP8 bottleneck split accumulation | One vector load, four Half2 additions and one vector store after the predecessor publishes | Original vector Half2 reduction |
| FP16 tensor product | Native Half `mma.sync` | Same |
| FP8 tensor product/conversion | Native E4M3 instructions on SM89; rejected below SM89 | Native E4M3 instructions |

The older-architecture copy path now stripes work across the whole warp. The
initial fallback instead issued every 16-byte copy from one elected lane,
serializing 32 or 64 instructions for each tile. The cooperative version keeps
the same shared layout, stages and consumer barriers while coalescing the copy
requests. General one-lane election still uses a converged ballot below SM90.

Each `cp.async.mbarrier.arrive` implicitly adds and later completes a pending
arrival for that producer's preceding copies. It deliberately omits `.noinc`.
Ordinary CTA arrivals remain necessary; completing those arrivals alone does
not prove the copies finished. `BarrierExpect` is a no-op on SM80/86/89 because
the fallback tracks arrivals rather than transaction bytes. Readers consume the
tile only after successful `mbarrier.test_wait`, and the existing pipeline
protects each shared stage from reuse until its readers finish.

The FP8 bottleneck projection/contraction and FP16 bottleneck projection start
their next input copy before the current MMA on targets below SM90. They retain
two shared slots: completing the current stage's collective barrier proves that
all warps finished reading the previous slot before it is reused. Weight
registers are replaced only after the current MMA finishes.

The FP8 bottleneck's intermediate split updates have one writer per address
within a split. After the predecessor's release counter is observed, a GPU
acquire fence and a CTA barrier publish its scratch values to all readers.
L2-cached vector loads avoid stale L1 lines; each addition still rounds to Half.
This removes four scalar atomics below SM90 without changing split order.
Other reduction sites retain their atomic implementation: applying this change
to FP16 or the decoder did not improve measured runtime.

Host preparation verifies both the loaded binary and virtual target, block and
shared-memory limits, and active blocks per SM. This also prevents an SM80 FP8
trap entry from being admitted after JIT on a newer GPU. The instruction target
requirements follow NVIDIA's [PTX ISA documentation](https://docs.nvidia.com/cuda/parallel-thread-execution/).

Compilation and SASS inspection cover Ampere/Ada targets, but physical RTX 30/40
hardware was unavailable. Current validation also compiles the lower source
branch directly into SM120 cubins for execution on the available RTX PRO 6000.
Earlier portability checks used PTX JIT on that same GPU. Neither method
emulates an Ampere/Ada GPU or establishes its performance or full hardware
qualification; the README speed charts remain SM120 measurements.

The portability validation matched the DLL's retained trunk boundaries byte for
byte at 720p and 4K, including forced split launches, poisoned CUDA graph
replays and changed inputs. A 1300 × 732 FP16 case checked runtime geometry.
The input/output kernels also matched their DLL fixtures through the lower-target
paths. Eager and `aot_eager` composition passed; default Inductor was unavailable
in this validation environment because Triton was missing.

To reproduce the copy/barrier test without DLL assets, compile the small test
module with your CUDA compiler and then run it explicitly:

```powershell
nvcc --cubin -std=c++17 -gencode=arch=compute_80,code=sm_120 `
  tests/cuda/portable_intrinsics.cu -o portable_intrinsics.cubin
python -B tests/test_portable_intrinsics.py --module portable_intrinsics.cubin `
  --report portable_intrinsics.json
```

This example exercises the SM80 source branch in an offline SM120 cubin. On
actual SM80 hardware, change `code=sm_120` to `code=sm_80`; use a compiler that
supports the selected target. The test records source/virtual and binary targets
alongside the physical GPU. It checks multiple producer warps, a two-stage ring,
multiple copies per producer, mixed zero-filled tiles, repeated barrier phases,
Half2 reductions, buffer guards and immutable inputs. `--ptx` remains available
only for explicit JIT experiments.

The same test also compares exclusive additions with the atomic oracle across
all 65,536 Half encodings and 16 edge operands in both operand orders, and checks
resident split publication over repeated scratch reuse.

The extension registers Torch operations rather than a Python module. Public
deployment calls load it automatically; for an explicit binary, use
`dlssnr.deployment.load_extension(path)`. Do not import `_C` or `_C_smXX`, and use a new
process when switching binaries. Training alone does not need this extension
or the CUDA compiler.

### Test speed on your GPU

```powershell
python test_speed.py
python test_speed.py --device 0 --per-kernel --output outputs/my-speed-run
```

The script tests 1280x720, 1920x1080, 2560x1440 (2K), and 3840x2160. It selects
FP16 on SM80+ and adds FP8 on SM89+. It reuses a compatible installed extension;
when none is usable it compiles a native split binary for the selected GPU only.
An installed CUDA toolkit, compatible PyTorch and C++ compiler are needed for
building. On Windows it discovers and activates Visual Studio's x64 tools.
`CUDA_HOME`, `DLSSNR_PTXAS_PATH` and `MAX_JOBS` retain your settings; inherited
architecture lists and fat-build mode do not change the selected build target.
`--rebuild` forces a fresh compile. Build logs remain in `build/speed/`.

Run `git lfs pull` to retrieve the checkpoints first. No extracted DLL assets
are used, and this command does not compare against the DLL. The benchmark
prepares deterministic synthetic packed features and times the integrated C++
blocks 1-69 trunk using CUDA events around warmed CUDA graph replays. Loading,
packing, preparation, input preprocessing and renderer composition are excluded.
Throughput is **trunk passes per second**, not rendered-game FPS.

Results are printed and saved to `results.json` and `results.csv` in a new
`outputs/speed/<timestamp>` directory, or your `--output` directory. They include
median/p10/p90 latency, throughput, peak PyTorch allocated memory, padding, launch
counts and device/binary/checkpoint identities. Each case runs in a fresh
process; OOMs and failures are reported explicitly while remaining cases run.
Any failed case makes the command return a nonzero exit code. An unsupported
precision is skipped. Outputs must be finite, graph replay must match eager
execution, and buffer guards must remain intact; these are smoke checks, not
DLL-equivalence validation.

Defaults are 20 warmup graph replays and 30 timed samples, with 10 replays of
three network passes per sample. Adjust `--warmup`, `--samples`, `--iterations`,
or the per-case `--timeout` for your machine. `--precision fp16` or `fp8` selects
one supported precision; `--checkpoint-dir` overrides the checkpoint location.

`--model {legacy71,small31}` selects the identity (default `legacy71`) and
`--checkpoint PATH` supplies one original portable checkpoint for every tested
precision. Explicit original-file examples:

```powershell
python test_speed.py --model legacy71 --checkpoint ckpts/dlss5_nr_fp8.pt
python test_speed.py --model small31 --checkpoint ckpts/dlss5_nr_small31.pt
```

Without `--checkpoint`, Legacy71 uses the precision-specific
`ckpts/dlss5_nr_<precision>.pt`; Small31 uses `ckpts/dlss5_nr_small31.pt`.
Legacy71 requires its adjacent JSON sidecar for hash verification; the Small31
sidecar is optional. `--model` is never inferred from the file, and a checkpoint
whose payload declares another model is rejected. Add `--precision fp16` (or
`fp8` on SM89+) to test only one supported precision.

`--per-kernel` additionally saves `kernels.csv` and per-call JSON timings from a
separate graph. It preserves the complete schedule, including counter resets
and any ordered split launches. Timing events perturb those short kernels, so
these diagnostics should not be summed or substituted for the headline latency.

### Benchmark architecture paths on one GPU

There are two distinct comparisons. Production binaries use matching source and
machine targets, such as `compute_89` → `sm_89`, and must be measured on compatible
hardware. A controlled source-path experiment can instead compile
`-gencode=arch=compute_89,code=sm_120`: `__CUDA_ARCH__` selects the older fallback,
but the offline assembler produces native SM120 machine code. This is how the
current optimization is compared on the available GPU, with the same compiler
and assembler for both versions and no driver JIT.

Keep these experimental libraries separate from installed deployment binaries.
Verify their actual ELF targets and absence of PTX with `cuobjdump --list-elf`
and `cuobjdump --list-ptx`. A source-target label in library metadata is not proof
of its binary ISA. The earlier `+PTX` comparison remains useful historical
evidence, but it also mixed driver-JIT and offline-assembler code generation.
Leave `CUDA_FORCE_PTX_JIT` unset so the DLL reference uses its native image.

The [architecture benchmark](../tools/benchmark_architectures.py) runs libraries
sequentially in separate processes at 720p, 1080p, 1440p and 4K. Supply the actual
library filenames from your build; this example compares two FP16 paths:

```powershell
python -B tools/benchmark_architectures.py --output outputs/architecture-speed `
  --library sm120 fp16 dlssnr/_C_sm120.cp311-win_amd64.pyd `
  --library compute89_offline_sm120 fp16 path/to/offline-control.pyd
```

Replace the control path with the separate experimental build; do not pass a
native-only SM89 library on SM120. Add more `--library LABEL PRECISION PATH`
arguments to include FP8 or other builds. Each output directory must be new.
Every case validates DLL outputs and
CUDA graph replay before collecting 64 alternating DLL/candidate timing pairs.
Each sample averages 30 network passes. Results include binary hashes, timing
dispersion, and GPU/driver metadata; cross-process comparisons use the median
paired ratio against the DLL to reduce clock drift.

These are steady-state timings of the prepared-feature trunk's 185 logical
calls; automatic split launches can increase the physical launch count. They
exclude checkpoint loading, packing, preparation, first-time JIT and renderer
input/output processing. These offline source-path controls measure SM120,
not the speed of an RTX 30/40 GPU. Only the earlier PTX-JIT experiments also
mixed differences between the driver JIT and offline PTX assembler.

The **pre-optimization** 2026-10-09 regression sweep on RTX PRO 6000 SM120 covered all four sizes:
the new native SM120 build stayed within 1% of the pre-portability build, with
all 81 kernels' instruction encodings and resources unchanged. The largest
initial difference was +0.70% (FP8, 720p); a reversed-order repeat measured
+0.05%. The fat binary also stayed within 1%. On this same GPU, compute80/86/89
PTX paths were 14–19% slower than native SM120 for FP16; compute89 FP8 was
12–17% slower. These percentages use paired-DLL normalization. All 40 matrix
cases and three repeat cases passed the 74 retained-boundary and graph replay
checks. This does not qualify speed on physical Ampere/Ada GPUs.

The subsequent offline-cubin comparison keeps the older source path and
physical SM120 target fixed while changing only the copy implementation.
All 24 cases pass all 74 retained-boundary and CUDA Graph replay checks.
The table shows median paired latency differences against the DLL; positive
values mean slower. These are older source paths **on SM120**, not measured
Ampere/Ada performance.

| Resolution | FP16 before → after | FP8 before → after |
|---|---:|---:|
| 720p | +13.20% → +2.36% | +12.63% → +3.59% |
| 1080p | +11.98% → +1.75% | +14.04% → +4.57% |
| 1440p (2K) | +16.38% → +1.85% | +15.54% → +2.48% |
| 4K | +15.71% → +0.22% | +13.63% → +0.67% |

NCU traced the regression to single-lane copy issue pressure. The cooperative
fallback reduces FFN expansion from 131.68 to 58.50 µs and contraction from
137.12 to 73.82 µs under controlled profiler replay. Those kernel timings
are diagnostic, not the graph timings above. All 81 native SM120 kernels
retain identical machine instructions and resource usage after this change.

The follow-up adds earlier bottleneck prefetch and exclusive FP8 split updates.
A fresh 20-case sweep includes separate compute80 and compute89 source paths,
both assembled offline to SM120, and native SM120 controls. The table gives
their **latency difference against native SM120**, normalized through each
run's paired DLL ratio; positive means slower. These are cross-run comparisons,
not direct paired A/B timings.

| Resolution | SM80 source, FP16 | SM89 source, FP16 | SM89 source, FP8 |
|---|---:|---:|---:|
| 720p | +3.61% | +3.40% | +1.25% |
| 1080p | +3.08% | +3.29% | +1.50% |
| 1440p (2K) | +4.04% | +4.24% | +2.09% |
| 4K | +2.79% | +2.72% | +1.50% |

All 20 cases pass 74 byte-equal boundaries and poisoned/changed-input graph
replays. Both older source paths produce identical instructions, encodings and
resources for all 40 FP16 entries on SM120; their small timing differences do
not represent different FP16 device code. Relative to the DLL itself, the
SM89-source 4K results are +0.29% for FP16 and -0.24% for FP8, but lower
resolutions still exceed the 1% goal. Native SM120's 81 kernels remain unchanged.
These results establish neither parity across all sizes nor physical SM80/SM89
performance. Forced stream-ordered splits also pass at 4K for both precisions.

### Profile a warm deployment workload

[profile_deployment.py](../tools/profile_deployment.py) loads the explicit
library, prepares checkpoint weights and warms the complete trunk before
profiling. `trace` mode captures and warms a CUDA Graph, then brackets its
replays with the CUDA profiler API. `ncu` mode places one warmed, fully prepared
schedule inside the NVTX range `candidate`; filter a specific kernel to inspect
its counters and source/SASS. For example, with Nsight tools on `PATH`:

```powershell
nsys profile --trace=cuda,nvtx --cuda-graph-trace=node `
  --capture-range=cudaProfilerApi --capture-range-end=stop -o outputs/trunk-trace `
  python -B tools/profile_deployment.py --mode trace --precision fp16 `
  --extension dlssnr/_C_sm120.cp311-win_amd64.pyd --width 2560 --height 1440 `
  --output outputs/trunk-trace.json

ncu --target-processes all --nvtx --nvtx-include "candidate/" --kernel-name-base function `
  -k "regex:^global_ffn_expand_c1024_fp16$" --launch-count 1 `
  --replay-mode kernel --clock-control base --cache-control all --set full `
  --import-source yes -o outputs/ffn-profile `
  python -B tools/profile_deployment.py --mode ncu --precision fp16 `
  --extension dlssnr/_C_sm120.cp311-win_amd64.pyd --width 2560 --height 1440 `
  --output outputs/ffn-profile.json
```

Use the same profiler options and dimensions for both libraries. NSys ranks
kernel contributions in the warmed graph; NCU explains instruction, memory and
pipeline behavior. Profiler replay/cache settings change execution conditions,
so confirm improvements with the separate unprofiled, paired DLL benchmark.

## Checkpoints

`git lfs pull` retrieves the [checkpoint files](../ckpts/README.md). One explicit selector chooses the identity; `legacy71` remains the default and `small31` must be named:

```python
from dlssnr import load_checkpoint

legacy = load_checkpoint("ckpts/dlss5_nr_fp8.pt")                      # legacy71 default
legacy_half = load_checkpoint("ckpts/dlss5_nr_fp16.pt")                # legacy71 default
small = load_checkpoint("ckpts/dlss5_nr_small31.pt", model="small31")
```

| Model selection | Original portable file | Stored weights and supported routes |
|---|---|---|
| `legacy71` (default) | `ckpts/dlss5_nr_fp8.pt` | Original mixed FP8/Half storage plus the 153 packed native records; FP8 or lossless FP16 native deployment and FP32/BF16 training. |
| `legacy71` | `ckpts/dlss5_nr_fp16.pt` | The same learned values widened exactly to Half; FP16 native deployment and FP32/BF16 training. |
| `small31` (explicit) | `ckpts/dlss5_nr_small31.pt` | All 77 original Small31 records; FP8 or lossless FP16 native deployment and FP32/BF16 training. |

A mismatched file or unknown model name raises; the model is never inferred from a file name, tensor shape or size. There is no separate higher-precision trained weight resource. Stored weight family and compute precision are separate: `training_model(..., precision="fp32")` or `precision="bf16"` uses ordinary PyTorch/autograd with FP32 masters. Native plans use original packed FP8 records or losslessly repacked FP16 records with the reconstructed CUDA kernels. Widening does not recover precision absent from the source. Ordinary loading rejects downward conversion; the explicit trained FP16 export described below performs the deliberate narrowing. FP32 scales stay FP32.

The actual Small31 artifact is `ckpts/dlss5_nr_small31.pt`, 113,943,356 bytes with SHA-256 `742c63cae96fb0d6f53f2de6e89e8175606ad51b8939e5e7d255a9167fbef154`. It is extracted statically from the signed 310.9.16 `WEIGHTS_CC_SMALL_FP8` resource:

```powershell
python -B tools/extract_model_checkpoint.py --dll profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll --model small31 --output ckpts/reextracted_small31.pt
```

Substitute the path to your copy of the same signed 310.9.16 DLL if it lives elsewhere, and choose a fresh output path: neither its `.pt` nor its `.json` may already exist. The `.pt` is self-contained. After `git lfs pull` or that extraction, **no original DLL or extracted archive directory is required to load it**. The optional adjacent `.json` records provenance and its checkpoint file hash is verified by default when present; model identity is enforced from the payload. The 77 raw records, 272 decoded state tensors across 31 blocks, source-based roundtrip and isolated `.pt`-only loading passed CPU checks. The bounded GPU acceptance for these checkpoint flows is recorded in the [public checkpoint acceptance receipt](kernel-guide/evidence-checkpoints/acceptance.json). See the [checkpoint guide](../ckpts/README.md) for the receipt and full identity details.

## Deployment

The full C++ deployment call runs the **blocks 1–69 feature trunk**, not RGB
preprocessing or renderer composition. Its input is contiguous, one-dimensional
CUDA `uint8` storage in the native plane16 layout. FP8 and FP16 have their own
packing; reshaping BHWC features or reinterpreting bytes does not perform it.

```python
import torch
from dlssnr import Geometry, load_checkpoint, prepare_kernels

width, height = 320, 320
geometry = Geometry.from_valid(width, height)
feature_width, feature_height = geometry.levels[0]

# Independent synthetic values written directly to native physical slots.
# This is not a BHWC -> native packing conversion; real RGB/BHWC deployment
# needs a matching producer.
native_generator = torch.Generator().manual_seed(320)  # Separate CPU generator.
physical_slots = torch.randn(
    feature_width * feature_height * 32,
    generator=native_generator, dtype=torch.float32,
) * 0.02
prepared_half_state = (
    physical_slots.to(torch.float16).view(torch.uint8).to("cuda:0")
)
prepared_fp8_state = (
    physical_slots.clamp(-448.0, 448.0)
    .to(torch.float8_e4m3fn).view(torch.uint8).to("cuda:0")
)
assert prepared_half_state.dtype == torch.uint8
assert prepared_half_state.numel() == feature_width * feature_height * 32 * 2
assert prepared_fp8_state.numel() == feature_width * feature_height * 32

checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
plan = checkpoint.create_plan_fp16(prepared_half_state, width=width, height=height)
output = plan.run_fp16()

sequence = prepare_kernels(plan)
output = sequence(*sequence.tensors)  # Individually visible Torch operations.
output = sequence.run_cpp()           # Bound chain dispatched entirely in C++.
```

The fixture above is generated directly in native storage and is not converted
from an RGB or BHWC tensor. For this 320×320 geometry, `geometry.levels[0]` is
160×160, so the flat fixture holds 160 × 160 × 32 = 819,200 values (1,638,400
bytes as FP16). The plan's `width`/`height` are the 320×320 valid dimensions.

Small31 uses the same prepared-feature contract but its own 31-role plan and record roster. It must be selected explicitly:

```python
# Reuses width, height and both prepared states from the example above.
small = load_checkpoint("ckpts/dlss5_nr_small31.pt", model="small31")
small_plan8 = small.create_plan_fp8(prepared_fp8_state, width=width, height=height)
small_output8 = small_plan8.run_fp8()

small_plan16 = small.create_plan_fp16(prepared_half_state, width=width, height=height)
small_output16 = small_plan16.run_fp16()
```

`ckpts/dlss5_nr_small31.pt` is complete: no original DLL or archive directory is consulted at load or plan time, and its optional JSON receipt is not required. The same file supports the original FP8 records and the lossless FP16 widening path. No plan is inferred from a file name; pass `model="small31"` explicitly.

FP8 uses the FP8 checkpoint, `create_plan_fp8`, `run_fp8`, and one byte per
feature element. Prepare plans outside CUDA Graph capture. Keep plans alive
through asynchronous work/capture, order shared-workspace executions, and clone
outputs that must survive another run. C++ derives supported padded resolutions
at runtime and chooses ordered split launches when resident capacity is too
small. New dimensions require a new plan; index, operand and memory limits
still apply. No physical RTX 5060 has been tested.

`torch.compile(sequence, fullgraph=True)` exposes the same individual operators;
default Inductor needs compatible Triton. The earlier SM120 validation used
`triton-windows==3.4.0.post21`. Integrated C++ execution needs no Triton. See
[deployment.py](../dlssnr/deployment.py) for individual-kernel and frontend APIs.

## Training

The training graph is ordinary PyTorch/autograd. The example below is a diagnostic plumbing and finite-output fixture: one real AdamW update on synthetic features, an FP32 master save/reload, an explicit FP16 export, and a native FP16 plan load. It is not a DLSS fine-tuning recipe, and its scalar is not a task loss. Keep FP32 master parameters; do not call `model.half()` or `model.bfloat16()`. Training includes all 71 Legacy blocks (or the 31 Small31 roles) and uses floating BHWC features, unlike deployment byte buffers.

```python
import os
import torch
from dlssnr import Geometry, export_trained_checkpoint, load_checkpoint

model_id = "small31"  # Use "legacy71" for the original 71-block graph.
checkpoint_paths = {
    "legacy71": "ckpts/dlss5_nr_fp8.pt",  # Or ckpts/dlss5_nr_fp16.pt.
    "small31": "ckpts/dlss5_nr_small31.pt",
}
output_paths = {
    "master": f"outputs/diagnostic-{model_id}-master.pt",
    "fp16": f"outputs/diagnostic-{model_id}-fp16.pt",
}
checkpoint = load_checkpoint(checkpoint_paths[model_id], model=model_id)

geometry = Geometry.from_valid(320, 320)
generator = torch.Generator().manual_seed(320)  # CPU generator.
features = torch.randn(
    (1, geometry.full_height, geometry.full_width, 16),
    generator=generator, dtype=torch.float32,
) * 0.02
features = features.to("cuda:0")

model = checkpoint.training_model(
    device="cuda:0", precision="bf16", trainable=True, checkpoint_blocks=False,
)
model.train()
output = model.forward_train(features, geometry=geometry)
loss = output.float().square().mean()  # Diagnostic fixture only, not a task loss.
loss.backward()
optimizer = torch.optim.AdamW(
    model.parameters(), lr=1e-5, betas=(0.9, 0.999), eps=1e-8, weight_decay=0.01,
)
optimizer.step()
optimizer.zero_grad(set_to_none=True)

model.eval()
os.makedirs("outputs", exist_ok=True)
torch.save(model.state_dict(), output_paths["master"])
fresh = checkpoint.training_model(
    device="cuda:0", precision="bf16", trainable=True, checkpoint_blocks=False,
)
fresh.load_state_dict(
    torch.load(output_paths["master"], weights_only=True), strict=True,
)
fresh.eval()
receipt = export_trained_checkpoint(
    fresh, output_paths["fp16"], model=model_id, precision="fp16",
)
trained = load_checkpoint(output_paths["fp16"], model=model_id)

# Independent synthetic native physical storage for the trained FP16 export.
# These values are written directly to native byte slots: this is not a
# BHWC -> native packer and not the training feature above.
feature_width, feature_height = geometry.levels[0]
native_generator = torch.Generator().manual_seed(320)  # Separate CPU generator.
native_slots = torch.randn(
    feature_width * feature_height * 32,
    generator=native_generator, dtype=torch.float32,
) * 0.02
prepared_half_state = (
    native_slots.to(torch.float16).view(torch.uint8).to("cuda:0")
)
trained_plan = trained.create_plan_fp16(prepared_half_state, width=320, height=320)
trained_output = trained_plan.run_fp16()
```

`precision="bf16"` can instead be `"fp32"`; both are ordinary autograd builds with FP32 masters. Other AdamW options remain installed PyTorch 2.8 defaults (`amsgrad=False`, `maximize=False`, `foreach=None`, `capturable=False`, `differentiable=False`, `fused=None`). `checkpoint_blocks=True` is supported for lower activation memory but was not part of this diagnostic setting. The 320×320 seed/scale case is a bounded example; it does not generalize to arbitrary inputs or resolutions. An earlier explicit `lr=1e-3` update produced nonfinite native FP16 outputs even though the stored weights were finite and serialized correctly; no specific overflowing instruction or root cause is asserted. `precision="fp16"` is the explicit, deliberately lossy narrowing opt-in; the export accepts only `fp16` and exposes no separate implicit-conversion flag. That master state is not a native deployment file: updated learned values reach the native CUDA records only through the explicit export, which is state-only, carries no original records, and cannot be used as an FP8 deployment source. Learned FP8 export is rejected because no inverse learned-FP8 writer exists; stale original records never stand in for trained weights. GPU acceptance is complete on an RTX PRO 6000 Blackwell (SM120) at 320×320: four original native cases (Legacy71 and Small31, FP16 and FP8), four actual optimizer/training cases (both models, FP32 and BF16) at the explicit diagnostic `lr=1e-5`, byte-exact FP32 master save/reload, loaded-vs-independently-quantized native trunk output, one zero-update control, and two learned FP32-trained, FP16-exported full-RGB stateless smoke cases that exercise learned preprocess, trunk and postprocess with finite RGBA and intact native trunk guards. Limits: temporal history, motion and blend are empty; the blend scalar is verified but unchanged and not executed; no vendor/surrogate parity, image-quality improvement or broad precision/resolution guarantee is claimed; frontend output guards are not separately exposed. The bounded commands and per-case receipts are in the [public checkpoint acceptance receipt](kernel-guide/evidence-checkpoints/acceptance.json); the earlier 4K runtime figures elsewhere in the documentation are separate measurements and are unchanged. See [Deployment](#deployment) for the packed input contract.

**Actual DLSS5 transfer learning, task losses, data preparation and training procedures remain TBD.**

GPU comparison fixtures additionally need cached original DLL/cubin assets;
the training benchmark worker needs `assets/nr`. There is no current top-level
asset-acquisition CLI. These prerequisites apply to the validation tools, not
checkpoint-based model use. See the live commands in [run_tests.py](../run_tests.py)
and the [prepared API test](../tests/test_prepared_kernel_api.py).
