# Local validation

The installed v36 integration passed 6,612 full-suite cases and all 21 separately
enabled full-model cases. Seven second-GPU cases and one obsolete staging
comparison remain skipped. Focused checks passed 804 cases; these overlap the
full suite. Unfiltered memcheck passed 378 private-kernel and 132 C512 cases
with zero errors. Unfiltered racecheck passed 52 private-kernel and 18 C512 cases
with zero errors or warnings. The [v36 validation receipt](../outputs/v36-activation/validation-complete.json)
pins the binary, all seven runs and process-cleanup qualifications.

Fresh v36 native-kernel replay also passed all 74 trunk boundaries at 720p,
1080p and 4K. Performance remains below the native baseline; see the
[current audit](native_compute_flow_audit.md). The results below retain the
initial 2026-10-03 baseline and its original binary scope.

## Initial baseline

The initial baseline combined suite passed **281 tests and 7 subtests**, with one skip,
zero failures and zero errors. The skipped test needs two CUDA devices.
This includes the opt-in complete-network tests using the actual extracted
310.8.0 checkpoint. Pytest reported six Windows temporary-directory cleanup
warnings after test execution; they were not numerical or CUDA failures.

```powershell
$env:DLSSNR_FULL_MODEL_TEST = '1'
.\.venv\Scripts\python.exe run_tests.py -q --junitxml=outputs/final-tests.xml
```

Raw results: [JUnit](../outputs/final-tests.xml),
[console log](../outputs/final-tests.log). The run took 101.57 seconds.

## Tested behavior

- All 153 checkpoint records decode, with stage hashes and layout validated.
- The complete 71-entry graph runs in FP8 and FP16 through both backends and
  both FP16/FP32 working-storage configurations. All 77 recorded boundaries
  and input gradients are finite; captured forward replay equals eager output.
- Complete extension models in FP8, FP16, FP32 and BF16 give every used
  parameter a finite, nonzero gradient on the test probe. FP32/BF16 tests keep
  FP32 master parameters; the BF16 test also accepts BF16 input features.
- True FP32/BF16 training avoids FP16/FP8 publication. Dynamic primitive-level
  audits check matrix operand types, FP32 norm/probability reductions and
  gradients, including window and global attention. Explicit precision is
  protected from ambient autocast.
- Individual inference and training operators pass forward/backward CUDA Graph
  capture checks, including execution on a nondefault stream.
- Publication, cubic activation and attention arithmetic have independent
  numerical tests, including exhaustive FP16 encodings where applicable.
  MMA tests use the observed architecture-specific grouping, not a universal
  cross-GPU bit-parity assumption.
- Alignment, tails, empty shapes, large batch grids, broadcast seed gradients,
  malformed archives and generated tuning policy checks pass.

An earlier focused compute-sanitizer run checked twelve launch/alignment/reduction
cases and reported **0 errors**: [memcheck log](../outputs/memcheck.log).
It was not a whole-network sanitizer run.

## Build and hardware

Executed on NVIDIA RTX PRO 6000 Blackwell Workstation Edition (`sm_120`), driver
610.62, PyTorch 2.8.0+cu128, Python 3.11, CUDA toolkit 12.8.93, MSVC 14.44.
The extension contains sm80, sm86, sm89, sm90 and sm120 device code plus compute120
PTX. Only sm120 was exercised on physical hardware. FP16 requires sm80+ and
FP8 requires sm89+; unsupported FP8 tests skip on Ampere.

Initial baseline extension SHA-256:
`4fc1daac233dfd6c14cf59b5feca8949b277a8a4e5a8b8899cfb36ca48b80152`.
Initial compiled tuning policy version: `b41a246ba02daefa`.

Later deployment revisions have separate focused validation records: 217 tiled
GEMM tests and 1,010 exact candidate measurements, followed by 238 combined
GEMM/activation tests and 330 initial fused candidate measurements. The fused
window and prepared operator suite passed 45 tests with four opt-in full-model
cases excluded from that run. The floating training regression passed 46 tests,
including complete FP32/BF16 forward/backward and graph capture, after the
training graph was refactored to share the activation entry point.

These are successive focused runs, not a sum of distinct tests or a new combined
release validation. Current deployment changes continue to be measured below;
the initial binary hash and timings above remain historical evidence.

## Measured performance and outstanding work

The complete model, batch one and FP16 working storage, measured these median
CUDA Graph forward times over seven samples after warmup:

| Precision | Valid size | Padded field | Graph replay |
|---|---|---|---:|
| FP8 | 33 x 33 | 320 x 320 | 13.107 ms |
| FP8 | 512 x 512 | 576 x 512 | 16.701 ms |
| FP16 | 33 x 33 | 320 x 320 | 19.765 ms |
| FP16 | 512 x 512 | 576 x 512 | 24.215 ms |

All benchmark heads were finite and graph replay exactly matched this
implementation's eager output. [Raw samples](../outputs/model_sm120.json) retain
eager/host timings and allocation measurements. This is network-only timing,
excluding render-feature preparation and temporal reprojection.

NCU/SASS-guided vectorization improved the actual full-field FP8 packing operation
by 3.50x over the archived scalar implementation. The generated policy covers
70 operator/dtype/shape combinations and 210 passing candidates. See
[performance evidence](performance.md) for cache conditions, counters and source
snapshots. The final measured kernels remain below the requested 85% throughput
gate; GEMM and attention algorithm tuning is still needed.

Subsequent unchanged-native CUDA harnesses validate global blocks, window blocks
through C512, and fused encoder downsampling against original checkpoint weights.
Their intermediate captures, guards, shapes and numerical scope are recorded in
[vendor_runtime.md](vendor_runtime.md). These stage and block comparisons do not
include renderer feature preparation, the complete encoder/decoder chain, or the
NGX host runtime.

**Full native-DLL numerical parity, the 85% throughput requirement, and matching
official NVIDIA runtime speed are not established.** A complete native network
capture and a comparable same-device official-runtime benchmark remain missing.
FP32/BF16 training deliberately uses continuous arithmetic and is not a native
parity mode.
