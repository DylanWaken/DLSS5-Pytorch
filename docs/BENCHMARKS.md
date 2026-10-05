# Performance overview and benchmark scope

Both FP8 and FP16 pass the accepted **at most 1% slowdown** criterion in both execution orders at all four tested sizes. These measurements use an RTX PRO 6000 Blackwell (SM120), batch one. “2K” means 2560 × 1440.

The current source is the readable CUDA reconstruction. The earlier transcript implementation and its measurements are preserved in [the historical overview](BENCHMARKS_HISTORY.md).

## FP8 deployment

![FP8 prepared-feature trunk](figures/deployment_fp8_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 × 720 | 2.175819 ms | 2.168228 ms | -0.340% | 0.996671 | 0.996517 |
| 1920 × 1080 | 2.542965 ms | 2.561985 ms | +0.722% | 1.007315 | 1.007102 |
| 2560 × 1440 | 3.538047 ms | 3.496283 ms | -1.109% | 0.991146 | 0.987308 |
| 3840 × 2160 | 6.698066 ms | 6.557170 ms | -1.976% | 0.982127 | 0.976993 |

## FP16 deployment

![FP16 prepared-feature trunk](figures/deployment_fp16_resolutions.svg)

| Resolution | Original kernels | Reconstructed CUDA | Paired change | Original-first ratio | Candidate-first ratio |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1280 × 720 | 3.710057 ms | 3.659409 ms | -1.457% | 0.985826 | 0.985307 |
| 1920 × 1080 | 4.439766 ms | 4.355398 ms | -1.813% | 0.982065 | 0.981580 |
| 2560 × 1440 | 6.039404 ms | 5.937089 ms | -1.623% | 0.985200 | 0.983370 |
| 3840 × 2160 | 11.589800 ms | 11.335992 ms | -2.292% | 0.977436 | 0.976797 |

## Measurement contract

The prepared-feature trunk covers blocks 1–69: 152 compute/repack calls and 33 clears. It excludes input preparation, output processing and DLL/NGX/renderer host work. The baseline executes extracted original kernels with matched scheduling and physical buffers.

Each role receives 20 warmup graph replays. Timing uses 64 alternating pairs, 32 per order, with three trunk calls per graph and ten replays per CUDA-event interval. The table shows per-role latency medians and median paired changes/ratios; those statistics need not equal the ratio of the displayed medians. Every per-order median is at most 1.01.

All 74 published boundaries compare byte-exactly in all eight cases. Poisoned replay, changed-input replay, guard/immutable-buffer checks and completion counters pass, including post-timing checks. Separate preprocessing, postprocessing and extra output-view fixtures cover the exports outside the trunk; they are not included in these timings.

The measured build uses the CUDA 12.8 frontend/runtime and CUDA 13.4 assembler. [Raw pairs and binary identities](figures/semantic_deployment_measurements.json), [all eight graph receipts](semantic_graph_qualification.json), and [the compiler comparison](COMPILER_SCHEDULING.md) make the scope explicit. These results qualify the named GPU and four plans; they do not establish continuous-resolution tuning, other GPU architectures, universal per-kernel parity or an 85% roofline.

## Individual FP8 and FP16 kernels

![Six kernel families in both precisions](figures/deployment_kernel_precision_comparison.svg)

This preserved historical suite predates the semantic rewrite and does not describe the current binary. It covers six families per precision: C32/C64/C128/C256 ordinary windows, C512 FFN and C512 QKV/attention. Each is tested at four resolution-derived internal fields, for 48 cases. All numerical and guard checks pass. This does not establish a complete FP16 deployment graph.

Bars show pooled medians; whiskers span the two execution-order medians. **36 of 48 cases reverse ranking with execution order.** Three FP8 and eight FP16 cases are slower in both orders. The full-trunk acceptance therefore must not be read as a universal individual-kernel speed result. See the tracked [per-kernel and per-order chart data](figures/deployment_measurements.json).

## FP32 and BF16 training

![Checkpoint-enabled training at four resolutions](figures/training_resolutions.svg)

All eight checkpoint-enabled cases pass. The benchmark includes all 71 numbered records, autograd forward, and backward through `head.square().mean()`, at batch one with FP32 master parameters. It uses two warmups and seven samples, without an optimizer, compilation or CUDA graphs. Recomputed work is included in backward time. The two precisions ran sequentially, so the plot is descriptive rather than a balanced precision-speedup experiment.

See [training results and reproduction commands](training.md) for exact timings, settings and memory. The original uncheckpointed implementation's [chart](figures/training_resolutions_eager_v1.svg) and [raw data](figures/training_resolutions_eager_v1.json) preserve the FP32 2K/4K and BF16 4K OOM outcomes. The [memory investigation](TRAINING_MEMORY.md) explains their cause and the checkpointing correction.

Actual DLSS5 transfer-learning losses, data preparation and training procedures remain to be investigated. These timings do not establish trained output quality.

The preceding release added an assembler cache key after the timing run. All 81 GPU kernels, resource records and constants, host machine code and imports are byte-identical to the timed build. Its installed 720p FP8/FP16 boundary and replay checks also pass. [Release identities and source hashes](semantic_release.json) and [compiled equivalence](semantic_build_equivalence.json) preserve this distinction; no new timing is attributed to the rebuilt file.

The subsequent [semantic naming audit](NAMING_AUDIT.md#validation) retains all 81 device instruction payloads, constants and resources. Its changed host packing passes separate full-graph and public-dispatch validation. The charts keep the original timing samples; no fresh latency measurements are claimed for the naming rebuild.

The current [flat-symbol migration](FLAT_SYMBOLS.md) removes project namespaces, uses descriptive global ABI/profile types and exports all kernels through bare `extern "C"` symbols. Its normal rebuild, eight full-graph checks and public C512 dispatcher validation are separate from the timing runs shown here. External library qualifications and the public Torch registration domain are unchanged. No new latency samples are attributed to this migration.
