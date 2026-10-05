# Complete reconstructed trunk and source cleanup

The best measured candidate in this work session is **0.42% slower than the extracted original kernels** at the fixed 4K FP8 prepared-feature trunk. It is not yet a performance-parity result. The measurements exclude renderer input preparation, pre0/post70, and the DLL's host interface.

## Kernel counts and reuse

The selected trunk uses **36 distinct FP8 entry points** at 152 compute/repack positions. Their 36 independently reconstructed FP16 counterparts are additional precision variants, not additional network layers. Four frontend/output families each have FP8 and FP16 variants. A precision-independent counter-clear entry brings the compiled total to **81 entry points: 40 precision pairs plus one control entry**.

The FP8 graph contains 152 compute/repack calls and 33 counter clears. Repeated blocks reuse entry points with their own packed records and launch configuration. Pairing precision variants does not establish that their fragment layout, reduction dimension, or fusion control can be replaced with one identical implementation.

## Measured complete-trunk trials

Each trial uses 32 alternating native/candidate pairs, 16 in each order, with three complete trunk calls per captured graph. Both roles use the same prepared input and physical packed weights. The table contains medians from separate trials; differences between rows do not isolate a precise causal speedup.

| Build | Original median | Reconstructed median | Reconstructed / original |
|---|---:|---:|---:|
| Initial consolidated development build | 6.429723 ms | 6.539008 ms | 1.016997 |
| Clean source build, original register cap | 6.443125 ms | 6.532160 ms | 1.013819 |
| Clean source build, plain C512 FP8 FFN capped at 128 registers | 6.453862 ms | 6.480768 ms | 1.004169 |

The 128-register candidate remains 0.461% and 0.405% slower by the two order-specific ratios of medians. Its fresh eager and captured replay tests pass all 74 physical boundaries, guards, immutable inputs/records, and completion counters. These are finite synthetic prepared-feature fixtures and same-input graph replays, not a complete renderer or changed-input capture qualification.

Trial records: [development](../outputs/all-reconstructed-deployment-prep/gpu-runs/paired-v1/result.json), [clean source](../outputs/all-reconstructed-deployment-prep/gpu-runs/normal81-paired-v1/result.json), [128-register candidate](../outputs/all-reconstructed-deployment-prep/gpu-runs/cap128-paired-v1/result.json).

## Why the register change was tested

[Nsight Systems matched every position](../profile/all-reconstructed-4k-nsys-v1/REPORT.md) in all 15 traced replays per role. The repeated plain C512 FFN was the largest measured kernel-duration regression: its per-replay family median increased by 107.331 microseconds. C128 ordinary windows added 35.553 microseconds and C32 ordinary windows added 16.350 microseconds. Other families offset part of these costs. Traced durations are diagnostic and do not replace the quiet paired trials.

[Fresh Nsight Compute captures](../profile/all-reconstructed-ffn512-ncu-v1/REPORT.md) explain a concrete resource difference in the original-cap FFN. The original kernel uses 128 actual and allocated registers per thread; the reconstruction uses 130 actual registers, allocated as 136. The register-limited resident block count drops from two to one. The configured shared-memory capacity also differs, from 64 KiB to 16 KiB, so registers are not isolated as the sole cause. Elapsed tensor utilization falls from 51.397% to 41.548%, while global load/store sector counts are identical and local traffic is zero.

Changing only the source register cap to 128 removes the resource threshold violation. All 80 other entry points retain identical instruction/control rows and per-function resources. The changed entry's 672 instruction/control rows and function resources match the previously tested 128-register version; a raw dump-header difference is recorded separately. Fresh full-trunk correctness and timing determine the integrated result above.

The 85% elapsed utilization target is still unmet in these FFN profiles for both the original and reconstructed kernels. Base clock control was requested, but measured clocks differ between captures; profiler replay durations must not be interpreted as resident deployment timings.

## Cleanup and remaining work

The former active implementation was preserved in `outputs/legacy-code-archive-20261005`; optimization logs, profiler captures, and failed trials remain available. Active `csrc` has only `kernel_impl`, `kernel_launcher`, and `torch_api`.

The next source refactor is staged separately: all 1,077 assembly sites reduce to 61 shared documented sites in `intrinsics.cuh`; packed arithmetic, integer helpers, memory helpers, and typed MMA selection move into shared utility headers. Each entry has a separate body file. Canonical precision names end in `_fp8` or `_fp16` throughout device entries, launchers, and public APIs. Compilation, code comparison, and runtime checks are required before that staged refactor becomes the active implementation.

Semantic kernel-body names and phase comments remain incomplete. The full FP16 route, frontend/output runtime qualification, continuous resolution measurements, support for additional GPU generations, and end-to-end DLL parity also remain open. The offline policy currently has no measured anchors; resolution enumeration must not be presented as completed GPU tuning.


## Cleanup upgrade installed: fresh result and preserved code differences

This follow-up supersedes the earlier current-status wording above while retaining that historical text and all trial records unchanged. The named/shared-helper build is now installed as binary `0e57a8a2f61dc5f8a1cf8df61878adafc184a12fb73b28f0bcaa53e4705e5226`. The [install receipt](../outputs/all-reconstructed-deployment-prep/readability/install-receipt.json) preserves the prior source in `outputs/source-before-readability-20261005` and binds the build, comparison and three GPU runs.

The [build](../outputs/all-reconstructed-deployment-prep/readability/build-run-v1/build.json) compiles all 81 entries through 10 CUDA and two host translation units without donor objects. Public operations and body filenames use explicit `_fp8` / `_fp16` suffixes. Shared force-inlined intrinsics and typed MMA/integer/packed-memory utilities remove repeated helper definitions; repeated model positions still reuse the same family entry and declarative launch configuration. This is source organization and reuse, not 81 newly invented algorithms or universal precision equivalence.

The [analysis-v2 compiled comparison](../outputs/all-reconstructed-deployment-prep/readability/compiled-comparison/analysis-v2/summary.json) is complete and keeps its differences visible: 42/81 entries have exact instruction/control code and ELF text; 80/81 have identical per-function resources; all 81 headers and constant sections match after the specified symbol renaming. Metadata/relocations match for 55 entries. The only resource change is global FP16 FFN contraction, REG148 to REG152, with STACK0, SHARED25624 and LOCAL0 unchanged. The summary remains `DIFFERENCES_REQUIRE_REVIEW`; 39 changed machine-code entries are not silently called equivalent. No kept PTX exists for proving emitted QKV pragma placement. Full FP16 runtime qualification remains pending.

Both new [finite-normal](../outputs/all-reconstructed-deployment-prep/gpu-runs/readability-numerical-v1/result.json) and [finite-code](../outputs/all-reconstructed-deployment-prep/gpu-runs/readability-finite-codes-v1/result.json) cohorts pass every one of the 74 FP8 physical boundaries. Same-input poisoned graph replay, guard checks, completion counters and input/142-record immutability also pass. This does not add changed-input graph, full-route sanitizer, complete FP16 or renderer claims.

The [fresh paired trial](../outputs/all-reconstructed-deployment-prep/gpu-runs/readability-paired-v1/result.json) uses the same complete 185-call prepared-feature interval, 32 alternating pairs, 16 per order, three calls per graph and three warmups:

| Order | Original median, ms | Reconstructed median, ms | Ratio of medians | Median paired ratio |
|---|---:|---:|---:|---:|
| Original first | 6.431760 | 6.451488 | 1.003067282 | 1.003926261 |
| Reconstructed first | 6.435872 | 6.457888 | 1.003420809 | 1.002308885 |
| Pooled | 6.432928 | 6.453749 | 1.003236668 | — |

The new candidate is **0.3236668% slower pooled**, and both order-specific ratios remain above one. Its saved parity gate is false. The earlier cap-128 result was 0.4169% slower in a separate trial; that small cross-trial difference is not a controlled causal speedup from this cleanup. The build, numerical and paired receipts all close with successful exits and final identities. The installed route remains limited to batch-one SM120 4K FP8 prepared features, excluding pre0/post70 and the DLL host. Continuous-resolution tuning, other architectures, a complete FP16 route, 85% elapsed utilization and native-speed parity remain unfinished.

The source/API cleanup requested for this release is installed. Current usage and scope are summarized in [README](../README.md), [API migration](API_MIGRATION.md) and [reconstruction status](RECONSTRUCTION_STATUS.md). The precision/clamp wording in tuning documentation is corrected separately; empty measured-anchor families remain explicit and no performance anchors are fabricated.


## Acceptance criterion update

After the cleanup trial, the accepted performance criterion was set to **no more than 1% slower than the extracted original kernels**. The installed 4K FP8 trunk meets it: pooled gap 0.3236668%, with order-specific gaps 0.3067282% and 0.3420809%. Further optimization is stopped. The historical saved strict-parity flag remains false; no receipt or earlier log wording is rewritten.

This acceptance is restricted to the qualified batch-one SM120 4K FP8 prepared-feature trunk. It does not complete the full FP16 route, other resolutions/devices, renderer/DLL host integration or the 85% elapsed utilization objective. The current PyTorch model is minimally trainable; DLSS 5 transfer-learning methodology, actual losses and training procedures require further investigation. Planned BF16/FP32 speed measurements will be labeled as forward and forward-plus-backward benchmarks, not an established training recipe.


## Final UEv2 release: four FP8 fields, kernel coverage and checkpointed training

This entry supersedes earlier current-status wording without changing any historical trial, failure or log text. The final UEv2 [normal source build](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/build-run-v1/build.json) compiles all 81 entries through ten CUDA and two host translation units. Its binary is `88b7a94ab57c3da0291ef48797ed5f8f4e85c1ce6cb7692657c16906e65bd1a5`. The [installation receipt](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/install-receipt.json) separately records active cutover.

Unreal-style internal names, proven register/shared/global role prefixes, shared force-inlined ISA helpers, typed MMA helpers and family-local ABIs are documented in [CODE_READABILITY](CODE_READABILITY.md). Repeated positions reuse families/configurations: 40 precision pairs plus clear, not 81 algorithms. Unresolved roles retain PTX provenance. The first UE constructor shadowed its moved record member; the failed run and narrow `g_InputRecords` repair remain preserved. UEv2's [ELF comparison](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/compiled-comparison/summary.json) matches all 81 text/control payloads, raw resource metadata, constants and relocations against the preceding readability build. This does not rewrite the older 42-code/80-resource comparison or claim native machine-code equality.

| Valid field | Original ms | Reconstructed ms | Pooled ratio | Original-first ratio | Reconstructed-first ratio |
|---|---:|---:|---:|---:|---:|
| 1280 × 720 | 2.172192 | 2.123984 | 0.977806751 | 0.977365824 | 0.978877976 |
| 1920 × 1080 | 2.547851 | 2.521051 | 0.989481362 | 0.989776131 | 0.989470992 |
| 2560 × 1440 | 3.488731 | 3.465125 | 0.993233875 | 0.993151321 | 0.993282146 |
| 3840 × 2160 | 6.452048 | 6.496523 | 1.006893098 | 1.006959734 | 1.006532316 |

Each run uses three calls per graph, three warmups and 32 alternating pairs, 16 per order. Both roles include 152 compute/repack calls plus 33 native/reconstructed clears. **All four meet the accepted no-more-than-1% slowdown criterion in both orders.** At 4K the candidate remains 0.689% slower pooled; its saved strict native-speed flag stays false. Earlier 0.417%/0.324% figures remain separate trials, not final results or controlled cleanup speedups. Further optimization is stopped under the accepted criterion.

Every run passes 74 published boundaries, input/142-record immutability, counters, guards and same-input poisoned replay. Global token padding remains in the oracle. Auxiliary downsample allocation tails are guarded but unpublished and excluded from output equality; equality of every backing byte is not claimed. Changed-input whole-graph proof remains false. Results and receipts: [720p](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-720p-paired-v1/result.json), [1080p](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-1080p-paired-v1/result.json), [2K](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-1440p-paired-v1/result.json), [4K](../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-2160p-paired-v1/result.json). All held Jobs close successfully with quiet process state and final identities.

The final binary passes numerical/guard checks in all [48 kernel cases](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/run-ue-v2/receipt.json): C32/C64/C128/C256 ordinary windows, C512 FFN and C512 QKV, each in FP8/FP16 at four resolution-derived shapes. **36/48 reverse speed ranking by order; three FP8 and eight FP16 cases are slower in both orders.** The [per-order results](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/RESULTS.md) prevent pooled medians from becoming a universal ≤1% kernel claim. Independent FP16 K16 packing does not establish a complete FP16 trunk or DLL Half-host conversion.

Training has a separately verified memory route. The initial eager suite passed five cases and OOMed in FP32 2K/4K and BF16 4K; its charts/results remain unchanged. The [memory audit](../outputs/all-reconstructed-deployment-prep/training-benchmark/MEMORY-ANALYSIS.md) finds 119.06 GiB saved nonparameter storage at FP32 2K, including 47.27 GiB first saved by the piecewise FP32 activation path, with no cross-iteration graph leak. These are implementation costs, not intrinsic resolution limits.

Opt-in non-reentrant checkpointing preserves the head, 77 training boundaries and 639 used parameter gradients bit-exact in a bounded FP32/BF16 full-model test. All [eight checkpointed training cases](../outputs/all-reconstructed-deployment-prep/training-checkpoint-benchmark/run-v1/receipt.json) now pass at 720p/1080p/2K/4K. At 4K, forward/forward-plus-backward medians are 833.493/3,740.222 ms FP32 and 893.420/3,719.308 ms BF16; peak allocated memory is 52.43/43.32 GiB. The full 71-block benchmark includes input/head, autograd-enabled forward and a diagnostic squared-head scalar with backward, no optimizer, FP32 masters, TF32 disabled and explicit checkpointing. Large runs check finite outputs/gradients, not full-resolution exact-gradient equality. [Training documentation](training.md) retains the protocol and eager comparison.

The four-size C++ API, charts and conventions are described in [README](../README.md), [API migration](API_MIGRATION.md), [status](RECONSTRUCTION_STATUS.md) and the [project skill](../skills/dlssnr-reconstruction/SKILL.md). **DLSS5 transfer-learning methodology, actual losses, data preparation and procedures remain to be investigated.** Full FP16 deployment, continuous resolutions, other architectures, renderer/DLL integration and the 85% elapsed-utilization objective remain open. No prior log record or measured artifact is overwritten by this entry.
