# From PTX transcripts to readable CUDA

The deployment implementation now expresses tensor tiles, fragment arrays, pipelines and publication rules as shared CUDA algorithms, and passes the user's 1% native-speed gate in FP8 and FP16 at all four tested resolutions. The former register-by-register C++ transcriptions have been removed from the production tree. Exported kernel names and parameter layouts are retained so that the same native launch plans remain usable.

There are 81 exported entries, not 81 independent algorithms: 40 FP8/FP16 pairs and a counter reset. Operation files select shared bodies with precision, dimensions and layout policies. C32 is warp-local; C64/C128/C256 share a wider-window implementation; C512 has separate FFN, QKV and projection stages; the global bottleneck uses streaming attention and split reductions. See [the source map](SOURCE_LAYOUT.md).

## What had to survive the rewrite

Reproducing a real-number equation was insufficient. The reference publishes packed values between stages, rounds Half operations in a particular order, and uses specific layouts for tensor-core fragments. The implementation preserves:

- FP8 K32 versus FP16 K16 tensor operations and Half accumulator order.
- Packed publication and unpacking, including intermediate values that remain Half until normalization finishes.
- The native activation and exponential approximations, with their original clamps and rounding points.
- Swizzles, row ownership, padding, residual scales and view mappings.
- Async-copy stage ownership, barrier arrival counts and ordered global split publication.

The constants are documented in [numerical_constants.cuh](../csrc/kernel_impl/common/numerical_constants.cuh). For example, the FFN gate uses a clamped quadratic expression with exact Half coefficients. Their decoded values and algebraic relationships explain what the code computes. The original coefficient-fitting procedure is unknown; a plausible approximation name is not evidence of how NVIDIA selected the coefficients.

## Validation before optimization

The native extracted-kernel graph supplies real intermediate inputs for each comparison. The candidate receives independently cloned writable buffers with guards. Comparisons include output bytes, additional scratch/counters, immutable inputs and padded storage where the native contract publishes it.

The first complete semantic candidate passed 150 selected compute calls per precision at 720p. The normal extension then passed all 74 published trunk boundaries at 720p, 1080p, 1440p and 4K in both precisions, including poisoned CUDA-graph replay and changed-input replay. Separate fixtures cover preprocessing, texture/surface postprocessing and the extra C32 output-view exports.

These checks qualify the tested fixtures and prepared-feature trunk. They do not constitute renderer integration, full DLL host timing, continuous-resolution support or qualification on another GPU architecture. FP32/BF16 training remains a separate PyTorch implementation.

## Why concise source initially compiled slower

Sharing an algorithm does not guarantee that the compiler selects the native instruction schedule. The first fully integrated semantic build, `extension-v2`, remained 4.17%, 4.66%, 2.85% and 1.83% slower in FP8 at the four sizes. FP16 passed the user's 1% gate in both execution orders at all four sizes. The FP8 regression was investigated with matched Nsight Compute full/source captures and native/candidate SASS.

Those measurements distinguish several costs rather than attributing the entire gap to tensor-core throughput:

| Observation | Source-level response | What the evidence establishes |
| --- | --- | --- |
| C32 repeated reciprocal/reciprocal-square-root operations on two identical Half lanes after reduction. | Compute the scalar inverse once and replicate its Half result. | The reduction establishes the lane-equality invariant; byte comparisons verify the compiled result. |
| C512 pooling used sixteen shuffle/select candidates where native PTX routes four neighbors directly. | Share the four-shuffle pooling helper with downsample. | The native lane map and exact Half summation tree were reproduced; the isolated pool comparison improved. |
| FP8 conversion pairs were joined with extra `PRMT` instructions. Native SASS folds the second conversion into a packed destination. | Place the two unchanged conversions and word assembly in one small intrinsic. | All 150 FP8 call comparisons pass. Static instruction reduction is not, by itself, a measured latency attribution. |
| Separate softmax calls repeat cross-lane denominator work for adjacent query tiles. | Recover native paired-query ownership and share its reduction. | CPU interpretation compares the ordered operands and denominator consumers; GPU validation is still required for each compiled candidate. |
| Global QKV repeats the uniform first/final split selection inside unrolled publication loops. | Select the split publication mode once, then instantiate the shared publication body. | Eight native/candidate QKV calls remained byte-exact. The isolated summed latency fell from about 139 to 116 microseconds, versus about 115 microseconds native; whole-trunk acceptance remains a separate test. |

The global QKV profile also showed substantial barrier polling and long-scoreboard stalls. The branch-count difference was a concrete source issue, not proof that branch stalls dominated the profile. This distinction matters: an optimization can shorten live ranges and alter scheduling even when its visible source operation is not the largest sampled stall category.

The following matched NCU results show the effect of the QKV publication change. These are replay measurements of one kernel, not graph latency. The native column is from the same run as the optimized candidate.

| Metric | Initial semantic v16 | Optimized v19 | Native in v19 run |
| --- | ---: | ---: | ---: |
| NCU duration (µs) | 22.048 | 18.592 | 18.752 |
| Executed instructions | 1,419,040 | 1,376,569 | 1,358,346 |
| Registers per thread | 164 | 158 | 163 |
| L2 throughput (% sustained elapsed) | 9.46 | 11.10 | 10.99 |
| Tensor activity (% sustained elapsed) | 11.10 | 13.14 | 12.98 |

The isolated branch-hoist experiment changes static `BRA` sites from 114 to 37 and reconvergent `BSSY`/`BSYNC` pairs from 39 to 11. All 96 static QKV tensor instructions remain. The separate packing change subsequently removes 48 `PRMT` sites. A later explicit predicated-load helper leaves those branch counts unchanged; its individual latency contribution has not been established. [Portable metrics, SASS counts and raw family timings](semantic_optimization_evidence.json) retain the capture identities.

Paired softmax illustrates why fewer instructions is not a sufficient selection rule. It reduced indexed shuffles from 32 to 16 and scalar reciprocals from eight to two, but raised register usage and selection work. The measured candidate keeps pairing for C32 and C512; C64/C128/C256 retain independent tiles. Both paths share the same arithmetic primitives and have explicit scheduling reasons for remaining distinct.

## A numerical lesson from postprocessing

The initial concise postprocess source differed by Half ULPs. SASS exposed the cause: two multiplications followed by an addition allowed the compiler to fuse the opposite product from the native sequence. The native sequence first rounds `low * input_scale`, then evaluates `fma(adapter, adapter_scale, rounded_low)`.

The implementation now expresses that exact contraction using the shared Half primitives. All 24 postprocess fixtures per precision subsequently passed, including phases, color/history paths, clipped valid regions and poisoned surface checks. Merely writing the same algebraic sum would not have fixed the issue.

## The final scheduling gap was in the assembler

After the source changes, the 1080p FP8 graph still missed the gate by about six microseconds. The C128 NCU trace showed identical tensor work but hundreds of thousands of additional NOP executions. Native PTX confirmed that the readable source already used the same tile/column traversal.

The controlled experiment emitted PTX once with CUDA 12.8, then assembled those identical bytes with 12.8 and 13.4. The 12.8 result reproduced the baseline exactly. The 13.4 result retained tensor counts and register allocation while removing most explicit scheduling NOPs. Eight C128 calls at 1080p measured approximately 175 µs with the newer assembler versus 186 µs with the older one and 179 µs native. This justified a build change rather than another unproven algorithm rewrite.

The final setup explicitly selects the assembler without replacing toolkit files or bypassing PyTorch's CUDA version check. Its digest participates in the compile command so Ninja cannot silently reuse objects from a different assembler. [The compiler report](COMPILER_SCHEDULING.md) records exact versions, the reference-image compiler-stamp limitation, instruction counts and reproducible flags.

Not every plausible scheduling change helped. An isolated C512 FFN prefetch experiment preserved all results but increased registers from 109 to 119 and worsened the measured 1080p family sum from about 147 to 149 µs. It was rejected. A separate native-style loop-drain proposal was not promoted once the accepted gate was reached.

## How to read the performance evidence

Final acceptance uses resident CUDA graphs, balanced execution order, warmup and per-order ratios against the original extracted kernels. NCU replay durations and isolated kernel sums explain mechanisms; they are not interchangeable with the repeated trunk timing. Profiling is serialized on one GPU owner, and final timing runs quiesce compilation and other worker activity.

The current working receipts live under `outputs/semantic-rewrite`. Source snapshots, binary hashes, failed attempts, per-call results and graph results are retained there. Raw profiler captures are under `profile/semantic-*`, with exact harness snapshots and parsed PC/source metrics. Historical optimization reports remain unchanged, including [the earlier readability pass](CODE_READABILITY_HISTORY.md).

The final semantic build passes all eight graph correctness and timing cases, with a worst per-order median slowdown of about **0.73%**. [Current charts, raw pairs and scope](BENCHMARKS.md) replace the earlier transcript timings as the current qualification. [The release record](semantic_release.json) binds the timed build to the final cache-key rebuild through exact GPU/host code equivalence and installed smoke checks. No 85% hardware-roofline claim follows from passing the user's 1% native-speed criterion.
