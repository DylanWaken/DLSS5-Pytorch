# Reconstruction status

Snapshot: 2026-10-05. The final UEv2 build passes the SM120, batch-one FP8 prepared-feature trunk at **720p, 1080p, 2K and 4K**, with every run meeting the accepted **no more than 1% slower than original** criterion in both execution orders. At 4K it measures 6.496523 ms versus 6.452048 ms original, a 0.689% pooled gap. Further optimization is stopped under that criterion; full DLL parity and a complete FP16 route are not claimed.

The qualified binary is `88b7a94ab57c3da0291ef48797ed5f8f4e85c1ce6cb7692657c16906e65bd1a5`, recorded by the [normal source build](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/build-run-v1/build.json). The [installation receipt](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/install-receipt.json) records the installed active source and binary separately from qualification.

## Source coverage and compiled result

The census is **40 precision pairs plus clear**: 36 selected FP8 trunk entries, their 36 independent FP16 counterparts, eight frontend/output extras and one precision-independent reset. The FP8 trunk repeats 36 entries over 152 compute/repack positions and 33 clears, for 185 launches. It retains 142 packed records and exposes 74 published physical boundaries.

The build compiles all 81 entries through ten CUDA and two host translation units with no donor objects. Shared `intrinsics.cuh`, `mma.cuh`, integer, packed-arithmetic and memory helpers remove duplicate utilities while preserving layouts and synchronization. Repeated blocks share kernels/configurations. Unreal-style naming and proven storage-role prefixes improve readability; unresolved roles retain PTX provenance. See [CODE_READABILITY](CODE_READABILITY.md).

The [UEv2 saved ELF comparison](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/compiled-comparison/summary.json) is exact against the preceding qualified readability build for all 81 `.text` payloads (instruction/control bytes), raw resource metadata, constants, and metadata/relocations. The ELF-only checker does not independently decode register/stack/spill counts. This is neither original-native machine-code equality nor a claim that all 81 entries were exercised in the FP8 graph. The preceding 42-code/80-resource comparison and its FP16 contraction register difference remain in the historical log.

## Four complete-trunk measurements

| Valid resolution | Original median ms | Reconstructed median ms | Pooled ratio | Original-first ratio | Reconstructed-first ratio |
|---|---:|---:|---:|---:|---:|
| 1280 × 720 | 2.172192 | 2.123984 | 0.977806751 | 0.977365824 | 0.978877976 |
| 1920 × 1080 | 2.547851 | 2.521051 | 0.989481362 | 0.989776131 | 0.989470992 |
| 2560 × 1440 | 3.488731 | 3.465125 | 0.993233875 | 0.993151321 | 0.993282146 |
| 3840 × 2160 | 6.452048 | 6.496523 | 1.006893098 | 1.006959734 | 1.006532316 |

Ratios are reconstructed/original, using per-role medians within each order. Each run has three warmups, three complete calls per captured graph and 32 alternating pairs (16 per order), with resident CUDA events. Both roles execute 152 compute/repack calls and 33 explicit clears. The original role uses original `cc_cb_clear`, not Torch reset fills. Pre0/frontend, post70/output helpers, DLL/NGX and renderer host work are excluded.

Every order ratio is at most 1.01. The saved stricter `matches_native_in_both_orders` flag remains false at 4K because both ratios exceed 1.0; the accepted 1% slowdown criterion passes. Earlier 0.417% and 0.324% 4K trials retain their own builds/timings. Their differences do not isolate a naming or cleanup effect.

Saved results: [720p](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-720p-paired-v1/result.json), [1080p](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-1080p-paired-v1/result.json), [2K](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-1440p-paired-v1/result.json), [4K](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-2160p-paired-v1/result.json). All four owner receipts verify successful exits, no timeout, zero remaining processes, signaled observed handles and final source/binary identities.

## Numerical scope and padding

Every run checks all **74 published physical boundaries**, same-input complemented-output replays, immutable input/142 records, guards and completion counters before and after measurement. Global token padding is included in byte equality. Auxiliary downsample allocation tails are guarded but are not network publication outputs and are excluded from the oracle. In particular, block-22 backing tails at 720p and 2K are not presented as equal published bytes. Compared published byte totals per check are 159,989,760; 342,097,920; 583,106,560; and 1,290,125,312 respectively.

`changed_input_graph_proof` remains false. These finite prepared-feature fixtures and poison/replay checks do not establish exhaustive exceptional coverage or a new broad full-route sanitizer result.

## FP8/FP16 kernel coverage

The [final matched-kernel suite](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/run-ue-v2/receipt.json) passes numerical/guard checks in all **48 cases**: C32/C64/C128/C256 ordinary windows, C512 FFN and C512 QKV, each in FP8/FP16 at four resolution-derived physical shapes. Each uses finite-positive, finite-negative, signed-zero and restored fixtures, then 32 alternating timing pairs with one call per graph.

**36/48 cases reverse speed ranking by execution order; three FP8 and eight FP16 cases are slower in both orders.** Pooled medians must not be read as a universal individual-kernel ≤1% qualification. See [both-order results](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/RESULTS.md) and the [kernel chart](figures/deployment_kernel_precision_comparison.svg). FP16 records use independently calibrated K16 packing, not recovered DLL Half-host conversion. There is no complete FP16 trunk API or deployment measurement.

## Full-model training

The separate pure-PyTorch model includes all 71 blocks, input block 0 and head block 70. FP32/BF16 use trainable FP32 masters. All eight four-resolution cases pass with opt-in non-reentrant block checkpointing, two warmups and seven measured iterations. Forward has autograd enabled; the total includes a diagnostic squared-head scalar and backward, with no optimizer. Peak allocated memory at 4K is 52.43 GiB FP32 and 43.32 GiB BF16.

A bounded valid 33 × 33 full-model test verifies head, 77 training boundaries and 639 used gradients bit-exact between eager and checkpointed execution in both precisions. Larger runs check finite outputs/gradients, not full-resolution exact-gradient equality. Preserved eager OOMs reflect a memory-heavy implementation: the meta audit finds 119.06 GiB saved nonparameter storage at FP32 2K, including 47.27 GiB first saved by the piecewise FP32 activation path; no cross-iteration graph leak was found. They are not intrinsic model resolution limits. See [training usage/results](training.md), [memory analysis](../outputs/all-reconstructed-deployment-prep/training-benchmark/MEMORY-ANALYSIS.md), and [checkpoint suite](../outputs/all-reconstructed-deployment-prep/training-checkpoint-benchmark/run-v1/receipt.json).

**DLSS5 transfer-learning methodology, actual losses, data preparation and training procedures still require investigation.** The diagnostic scalar is not a proposed task loss.

## Remaining limits and preserved evidence

| Area | State |
|---|---|
| FP8 whole trunk | Four exact valid resolutions, batch one, SM120; ≤1% slowdown criterion met |
| FP16 whole trunk | Not implemented/qualified as a complete route; kernel fixtures remain a separate scope |
| Continuous resolutions / other GPU architectures | Not qualified by the four discrete fields |
| Frontend/output extras and renderer/DLL host | Source coverage does not imply integrated runtime qualification |
| Changed-input whole-graph / exhaustive exceptions / broad full-route sanitizers | Not established by these final four runs |
| Elapsed tensor/L2-data/DRAM utilization ≥85% | Not established |
| Per-device tuning policy | No measured anchors; `-1` remains explicit for unmeasured families |

Policy lookup preserves actual dimensions and clamps only matching-family query coordinates before deterministic nearest-anchor selection. It neither benchmarks nor admits a shape. The four C++ baseline admissions remain separate from policy measurements.

The [optimization log](optimization_log_2026-10-05.md), [API migration](API_MIGRATION.md), [project reconstruction skill](../skills/dlssnr-reconstruction/SKILL.md), [legacy archive](../outputs/legacy-code-archive-20261005/ARCHIVE.md), failed trials and historical [NSYS](../profile/all-reconstructed-4k-nsys-v1/REPORT.md)/[NCU](../profile/all-reconstructed-ffn512-ncu-v1/REPORT.md) reports remain intact. Profiler durations, cache/replay scopes and old binaries are not substituted for these quiet paired timings.
