# Performance overview and benchmark scope

Seven of eight deployment cases meet the **at most 1% slowdown** criterion in both execution orders: all four FP16 cases and three FP8 cases. **FP8 at 1080p is 1.1944% slower in its worse order**, so it misses the target. Measurements use an RTX PRO 6000 Blackwell (SM120), batch one. "2K" means 2560 x 1440.

These measurements use the installed runtime-resolution and small-GPU scheduling build, `efdfded212d90042e5ba44d010e636a4a15b827f0091c34a060f06eb92f11a24`. The [validation receipt](small_gpu_validation.json) records the build, source hashes and raw measurements. The scheduling fix changes eight logical GPU entries; the other 73 retain their preceding instruction payloads, constants and resource counts. Moving the implementation into network-stage folders preserves all 81 payloads relative to the scheduling fix.

## FP8 deployment

![FP8 prepared-feature trunk](figures/deployment_fp8_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 x 720 | 2.199133 ms | 2.201705 ms | +0.012% | 0.999986 | 1.003662 |
| 1920 x 1080 | 2.571556 ms | 2.600779 ms | +1.181% | 1.011944 | 1.011466 |
| 2560 x 1440 | 3.553151 ms | 3.527954 ms | -0.784% | 0.991502 | 0.992162 |
| 3840 x 2160 | 6.650002 ms | 6.527930 ms | -1.727% | 0.982384 | 0.982879 |

## FP16 deployment

![FP16 prepared-feature trunk](figures/deployment_fp16_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 x 720 | 3.751551 ms | 3.693703 ms | -1.475% | 0.984603 | 0.985919 |
| 1920 x 1080 | 4.490328 ms | 4.398100 ms | -1.983% | 0.982797 | 0.978531 |
| 2560 x 1440 | 6.105769 ms | 5.971515 ms | -2.113% | 0.978684 | 0.979752 |
| 3840 x 2160 | 11.572173 ms | 11.306682 ms | -2.293% | 0.976600 | 0.977758 |

## Measurement contract

The prepared-feature trunk covers blocks 1-69: 152 compute/repack calls and 33 clears. It excludes input preparation, output processing and DLL/NGX/renderer host work. The baseline executes extracted original kernels with matched physical buffers. The candidate automatically uses ordered split launches when concurrent residency is insufficient. On this GPU, eight logical QKV calls use that fallback in the FP16 4K timing case; the other seven timing cases retain combined launches.

Each role receives 20 warmup graph replays. Timing uses 64 alternating pairs, 32 per order, with three trunk calls per graph and ten replays per CUDA-event interval. Tables show per-role latency medians and median paired changes/ratios; those statistics need not equal the ratio of the displayed medians. Acceptance requires both order medians to be at most 1.01. The FP8 1080p exception remains a failure of this performance target.

All 74 published boundaries compare byte-exactly in all eight timed cases and fourteen additional FP8/FP16 resolution checks. Poisoned replay, changed-input replay, guard/immutable-buffer checks and completion counters pass. Additional sizes include portrait, ultrawide, below 720p and above 4K inputs. A scheduling-cap override exercises every dependent split in ordered mode; it does not emulate a smaller GPU's speed. **No physical RTX 5060 was available for validation.**

At 1234 x 777, separate FP8 and FP16 checks pass individual Torch operators, eager execution, AOT eager, default Inductor and C++ execution, including rebinding and changed-input graph replay. CPU checks pass in normal and optimized modes, with runtime geometry compared against the independent reference for 116 supported precision/shape pairs and 16 invalid cases. See [dynamic resolutions](DYNAMIC_RESOLUTIONS.md), [small-GPU scheduling](SMALL_GPU_SCHEDULING.md) and the [current validation receipt](small_gpu_validation.json).

A separate balanced comparison at FP8 1080p uses the preceding accepted extension as its baseline. The new build is approximately 0.36% slower in the worse order (ratios 1.003551 and 1.002996). That experiment helps separate the scheduling change from the existing gap; it does not turn the comparison against NVIDIA into a pass.

The measured build uses the CUDA 12.8 frontend/runtime and CUDA 13.4 assembler. [Current timing summaries](figures/small_gpu_deployment_measurements.json), [raw pairs and binary identities](small_gpu_validation.json) and [the compiler comparison](COMPILER_SCHEDULING.md) define the scope. Functional support for arbitrary operand-compatible resolutions is separate from continuous-resolution tuning or speed qualification. These measurements do not establish other GPU architectures, universal per-kernel parity or an 85% roofline.

The [template-build measurements](figures/template_integration_deployment_measurements.json), [per-entry measurements](figures/global_entry_deployment_measurements.json), [earlier measurements](figures/kernel_locality_deployment_measurements.json) and [transcript-era overview](BENCHMARKS_HISTORY.md) remain historical records.

## Individual FP8 and FP16 kernels

![Six kernel families in both precisions](figures/deployment_kernel_precision_comparison.svg)

This preserved historical suite predates the semantic rewrite and does not describe the current binary. It covers six families per precision: C32/C64/C128/C256 ordinary windows, C512 FFN and C512 QKV/attention. Each is tested at four resolution-derived internal fields, for 48 cases. All numerical and guard checks pass. This does not establish a complete FP16 deployment graph.

Bars show pooled medians; whiskers span the two execution-order medians. **36 of 48 cases reverse ranking with execution order.** Three FP8 and eight FP16 cases are slower in both orders. The full-trunk acceptance therefore must not be read as a universal individual-kernel speed result. See the tracked [per-kernel and per-order chart data](figures/deployment_measurements.json).

## FP32 and BF16 training

![Checkpoint-enabled training at four resolutions](figures/training_resolutions.svg)

All eight checkpoint-enabled cases pass. The benchmark includes all 71 numbered records, autograd forward, and backward through `head.square().mean()`, at batch one with FP32 master parameters. It uses two warmups and seven samples, without an optimizer, compilation or CUDA graphs. Recomputed work is included in backward time. The two precisions ran sequentially, so the plot is descriptive rather than a balanced precision-speedup experiment.

See [training results and reproduction commands](training.md) for exact timings, settings and memory. The original uncheckpointed implementation's [chart](figures/training_resolutions_eager_v1.svg) and [raw data](figures/training_resolutions_eager_v1.json) preserve the FP32 2K/4K and BF16 4K OOM outcomes. The [memory investigation](TRAINING_MEMORY.md) explains their cause and the checkpointing correction.

Actual DLSS5 transfer-learning losses, data preparation and training procedures remain to be investigated. These timings do not establish trained output quality.

## Historical cleanup qualifications

The earlier semantic timing series remains unchanged in [its raw measurements](figures/semantic_deployment_measurements.json) and [eight graph receipts](semantic_graph_qualification.json). These records predate the current small-GPU scheduling measurements above.

An earlier release added an assembler cache key after its timing run. All 81 GPU kernels, resource records and constants, host machine code and imports were byte-identical to that timed build. Its installed 720p FP8/FP16 boundary and replay checks also passed. [Release identities and source hashes](semantic_release.json) and [compiled equivalence](semantic_build_equivalence.json) preserve that historical distinction.

The later [semantic naming audit](NAMING_AUDIT.md#validation), [flat-symbol migration](FLAT_SYMBOLS.md) and [storage-prefix cleanup](STORAGE_PREFIX_AUDIT.md) each preserved all 81 GPU instruction payloads and received separate correctness checks. They retained the earlier timing series without claiming fresh latency samples. The subsequent per-entry-body refactor changed some instruction streams and earned its own measurements. The later template build preserved that device code and received its own historical measurements. The current scheduling build changes eight logical entries and has the fresh measurements shown above.
