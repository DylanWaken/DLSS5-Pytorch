# Performance overview and benchmark scope

Both FP8 and FP16 pass the accepted **at most 1% slowdown** criterion in both execution orders at all four tested sizes. These measurements use an RTX PRO 6000 Blackwell (SM120), batch one. “2K” means 2560 × 1440.

These are fresh measurements of the kernel-body cleanup described in the [kernel reading guide](KERNEL_READING_GUIDE.md), using candidate `2b64f1f5067b36264702d7393c3bbbd558fd77538ddd5b3b5618eb36adbddd06`. Only **43 of 81 GPU instruction payloads** are identical to the preceding release; the results below measure this rebuilt candidate directly. Earlier [semantic measurements](figures/semantic_deployment_measurements.json) and the [transcript-era overview](BENCHMARKS_HISTORY.md) remain historical records.

## FP8 deployment

![FP8 prepared-feature trunk](figures/deployment_fp8_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 × 720 | 2.175077 ms | 2.177183 ms | +0.099% | 1.000885 | 1.001131 |
| 1920 × 1080 | 2.557637 ms | 2.575935 ms | +0.732% | 1.007183 | 1.007498 |
| 2560 × 1440 | 3.542062 ms | 3.507313 ms | -1.007% | 0.990683 | 0.989043 |
| 3840 × 2160 | 6.698433 ms | 6.584309 ms | -1.702% | 0.983219 | 0.981969 |

## FP16 deployment

![FP16 prepared-feature trunk](figures/deployment_fp16_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 × 720 | 3.714467 ms | 3.643450 ms | -1.989% | 0.980110 | 0.980102 |
| 1920 × 1080 | 4.459135 ms | 4.377658 ms | -1.831% | 0.983200 | 0.980533 |
| 2560 × 1440 | 6.116197 ms | 6.015182 ms | -1.623% | 0.980327 | 0.984184 |
| 3840 × 2160 | 11.720230 ms | 11.462408 ms | -2.223% | 0.977773 | 0.977869 |

## Measurement contract

The prepared-feature trunk covers blocks 1–69: 152 compute/repack calls and 33 clears. It excludes input preparation, output processing and DLL/NGX/renderer host work. The baseline executes extracted original kernels with matched scheduling and physical buffers.

Each role receives 20 warmup graph replays. Timing uses 64 alternating pairs, 32 per order, with three trunk calls per graph and ten replays per CUDA-event interval. The table shows per-role latency medians and median paired changes/ratios; those statistics need not equal the ratio of the displayed medians. Every per-order median is at most 1.01.

All 74 published boundaries compare byte-exactly in all eight cases. Poisoned replay, changed-input replay, guard/immutable-buffer checks and completion counters pass, including post-timing checks. Fresh separate postprocessing and C512 public-dispatch checks also pass. Preprocessing retains identical GPU instructions from the preceding qualified build; earlier frontend and extra output-view fixtures remain recorded. These separate checks are not included in trunk timings. The [current validation receipt](kernel_locality_validation.json) records their individual scope.

The measured build uses the CUDA 12.8 frontend/runtime and CUDA 13.4 assembler. [Current raw pairs, binary identities and correctness summaries](figures/kernel_locality_deployment_measurements.json) and [the compiler comparison](COMPILER_SCHEDULING.md) make the scope explicit. These results qualify the named GPU and four plans; they do not establish continuous-resolution tuning, other GPU architectures, universal per-kernel parity or an 85% roofline.

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

The earlier semantic timing series remains unchanged in [its raw measurements](figures/semantic_deployment_measurements.json) and [eight graph receipts](semantic_graph_qualification.json). These records predate the fresh kernel-body measurements above.

An earlier release added an assembler cache key after its timing run. All 81 GPU kernels, resource records and constants, host machine code and imports were byte-identical to that timed build. Its installed 720p FP8/FP16 boundary and replay checks also passed. [Release identities and source hashes](semantic_release.json) and [compiled equivalence](semantic_build_equivalence.json) preserve that historical distinction.

The later [semantic naming audit](NAMING_AUDIT.md#validation), [flat-symbol migration](FLAT_SYMBOLS.md) and [storage-prefix cleanup](STORAGE_PREFIX_AUDIT.md) each preserved all 81 GPU instruction payloads and received separate correctness checks. They retained the earlier timing series without claiming fresh latency samples. Those historical equivalence claims do not apply to every entry in the current kernel-body cleanup; the current charts use its new measurements.
