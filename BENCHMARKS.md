# Performance overview and benchmark scope

Both FP8 and FP16 pass the accepted **at most 1% slowdown** criterion in both execution orders at all four tested sizes. These measurements use an RTX PRO 6000 Blackwell (SM120), batch one. “2K” means 2560 × 1440.

These are fresh measurements of the per-entry CUDA source build described in the [kernel reading guide](KERNEL_READING_GUIDE.md), using candidate `aa207d3780ad82d68aa48686dff379974cca6f4ea3b1d99ebd663b2bd9d4337f`. **50 of 81 GPU instruction payloads** match the preceding canonical-function release; these results measure the rebuilt candidate directly. The [preceding measurements](figures/kernel_locality_deployment_measurements.json) and [transcript-era overview](BENCHMARKS_HISTORY.md) remain historical records.

## FP8 deployment

![FP8 prepared-feature trunk](figures/deployment_fp8_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 × 720 | 2.184109 ms | 2.175246 ms | -0.393% | 0.995512 | 0.996343 |
| 1920 × 1080 | 2.561961 ms | 2.577999 ms | +0.652% | 1.006574 | 1.006463 |
| 2560 × 1440 | 3.594359 ms | 3.555806 ms | -0.946% | 0.990574 | 0.990035 |
| 3840 × 2160 | 6.854526 ms | 6.731045 ms | -1.720% | 0.982803 | 0.982831 |

## FP16 deployment

![FP16 prepared-feature trunk](figures/deployment_fp16_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 × 720 | 3.697293 ms | 3.628291 ms | -1.649% | 0.983677 | 0.981397 |
| 1920 × 1080 | 4.436125 ms | 4.344159 ms | -2.101% | 0.981088 | 0.977986 |
| 2560 × 1440 | 6.099626 ms | 5.971635 ms | -2.059% | 0.979664 | 0.979364 |
| 3840 × 2160 | 11.746362 ms | 11.444514 ms | -2.555% | 0.975213 | 0.973663 |

## Measurement contract

The prepared-feature trunk covers blocks 1–69: 152 compute/repack calls and 33 clears. It excludes input preparation, output processing and DLL/NGX/renderer host work. The baseline executes extracted original kernels with matched scheduling and physical buffers.

Each role receives 20 warmup graph replays. Timing uses 64 alternating pairs, 32 per order, with three trunk calls per graph and ten replays per CUDA-event interval. The table shows per-role latency medians and median paired changes/ratios; those statistics need not equal the ratio of the displayed medians. Every per-order median is at most 1.01.

All 74 published boundaries compare byte-exactly in all eight cases. Poisoned replay, changed-input replay, guard/immutable-buffer checks and completion counters pass, including post-timing checks. Separate fresh fixtures pass 64 preprocessing, 48 postprocessing, 72 C32 output-view and 24 C512 dispatcher cases. Individual Torch API tests also compare FP8/FP16 C++ and compiler-visible trunk routes, plus 18 frontend fixtures. These adapter checks are outside trunk timing; see the [current validation receipt](global_entry_validation.json).

The measured build uses the CUDA 12.8 frontend/runtime and CUDA 13.4 assembler. [Current raw pairs, binary identities and correctness summaries](figures/global_entry_deployment_measurements.json) and [the compiler comparison](COMPILER_SCHEDULING.md) make the scope explicit. These results qualify the named GPU and four plans; they do not establish continuous-resolution tuning, other GPU architectures, universal per-kernel parity or an 85% roofline.

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
