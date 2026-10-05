# Performance methodology and current limits

The latest installed SM120 binary is
`c2d47cbe449495cfb544d763285775808e13cdf03ce6ecb768780dcd9e6e9e3f`,
adding the qualified direct-publication encoder fusion with policy
`141b6e8049c51a68`. It preserves the ordinary, C512 and decoder policies below.
Its same-binary qualification measures **9.433189 to 9.194939 ms**, a **2.53%
latency reduction**, for valid 3713×2049 inputs sharing the 4K padded field.
Both orders pass the strict 1% gate. The exact-valid 4K check passes all 74
native boundaries and two replays; [installed regression](../outputs/c32-encoder-transition-native-publication-postinstall/run-v1/job-receipt.json)
passes 55 tests plus eight subtests with no failures or skips. The final relink
changes policy metadata only and retains the qualified CUDA code exactly.
See the [installation closure](../outputs/c32-encoder-transition-native-publication-final-policy/activation/validation-complete.json).

The latest three-size native comparison uses this installed encoder binary,
with ordinary GEMM policy `19c64573272a45c8`, C512 policy `40557fe031d98701`,
and decoder policy `217be58b13099077`. It alternates native/candidate execution
order across 32 pairs per size, retaining 16 pairs per order. Each resident
graph contains three calls timed by captured external events. Fresh
blocks-1–69 comparisons use exact valid input sizes:

| Input | Our implementation | Original kernels | Our/native latency |
|---|---:|---:|---:|
| 1280×720 | 2.978 ms | 2.181 ms | 1.366× |
| 1920×1080 | 3.975 ms | 2.557 ms | 1.555× |
| 3840×2160 | 9.194 ms | 6.433 ms | 1.429× |

All 74 boundaries and two native boundary replays pass at each size, as do
poisoned graph endpoints and guard/immutability checks. All three speed gates
fail in both execution orders. At 4K, matching this baseline requires about
a **30.0% reduction** in our latency. The
[three fresh singleton runs](../outputs/c32-encoder-transition-native3/run-balanced-v2/receipt.json)
retain every sample, complete journals, quiet worker cleanup and final
source/binary identities. Expected worker exit code 2 records the speed gap.
This balanced protocol differs from the preceding decoder-only sequential
comparison; separate runs do not isolate a change's gain.

The comparison includes our direct physical-layout conversions and executes
unchanged extracted native kernels; it is not full DLL host timing. The complete
931-geometry native sweep remains the historical v24 build. The requested
85% throughput gate and complete NGX/renderer parity also remain open. See the
[current native evidence](native_compute_flow_audit.md#progress-against-the-requested-performance-goal)
and [optimization walkthrough](optimization_walkthrough.md) for exact scopes,
fixture checks and historical measurements.

The installed block66 candidate combines affine addressing and vector output
stores: 146.912 microseconds versus the prior best direct-publication kernel's
160.256 and the original's 128.976 in the same run. It clears the strict 3%
improvement gate against the prior best in all 24 orders. Against its unpromoted
affine-only parent (153.088 microseconds), the store increment clears that gate
in only 18 of 24 orders. These are distinct results: the combined candidate
qualifies against the incumbent, while the isolated store increment does not
clear its parent gate. All seven numerical/sanitizer runs pass. Native speed
still fails. Its subsequent same-binary network comparison reduced the shared
4K padded trunk field from 9.791520 to 9.437125 ms (3.62%), passing both execution
orders. That paired field uses valid 3713×2049 inputs; the exact-valid table above
is a separate fresh comparison. The
[paired evidence](../outputs/c32-affine-store-matched/run-paired-4k-v1/proof.json)
retains the complete boundary, all orders and qualification limits.

The [current Nsight Systems trace](../profile/trunk-nsys-encoder-id4-4k-private/analysis/kernel-attribution-v2.json)
maps every node in all 30 submissions: 185 native and 268 candidate kernels
per replay, plus four candidate device copies. Block 4 is now one selected
kernel at **150.018 µs versus 129.697 µs native**. Block 66 measures
137.377/120.610 µs. The largest remaining equivalent stage gap is **block 8
plus downsampling, at 229.315/99.393 µs**. Our block-8 path includes the
142.657 µs core, a separate pool, a copy, two publications and a projection.
These are sequential profiled diagnostics, with all samples retained; they
identify investigation targets and do not replace balanced resident timing.

The [fresh block-8 NCU collection](../profile/c64-down8-matched-v36/analysis/REPORT.md)
is complete. The original fused entry executes 56.230 million warp instructions
versus 103.204 million for the current core alone; both use 168 registers.
Elapsed tensor utilization is 73.534%/44.732%, original/current core, and all
four selected kernels fail the 85% OR gate. A literal reassembly of the
original PTX matches all 3,384 machine instructions and serves as a control
for reconstructing readable CUDA/C++ with the same fusion and layout.
The reconstructed CUDA pilot now passes both native physical outputs on finite
and exceptional fixtures. Replacing two Half2 split/rejoin helpers with
whole-word views removes 307 redundant chains; its balanced candidate/original
ratios improve from 1.12439/1.10263 to **1.01155/1.00952**, separated by execution
order. The remaining 0.95–1.16% slowdown does not pass the strict native-speed
gate. These are separate fresh-process experiments on B1, H544×W960, C64,
phase 3, with no layout conversion inside either timed graph. See the
[source and measurement account](optimization_walkthrough.md#91-measure-the-cost-of-a-representation-helper).
This private experiment has not replaced the installed implementation or
changed the whole-trunk results above.

The preceding decoder-only trace had block 4 at 401.252/129.409 µs. That
historical gap led to the now-installed encoder fusion. The completed
[matched block4 Nsight Compute analysis](../profile/c32-down4-matched-v36/REPORT.md)
finds 4× ideal sector traffic for the core's FP8 stores, 2× for its extra raw
Half stores, and nearly twice the native down-projection MMA count in the
separate N128 tile used for actual N64. All four selected kernels fail the
85% elapsed-pipe gate. The private down4 fusion now measures **167.456 versus
403.936 microseconds** for our composition, passing all six execution orders.
The original remains faster at **120.320 microseconds**. This is a component
measurement on one field from the earlier V2 candidate; it preceded the
corrected direct-publication version that is now installed.

[Fresh fused/original counters](../profile/c32-down4-fused-v36/REPORT.md)
confirm equal output payload, store sectors and executed QMMAs, with zero local
traffic. The remaining gap includes input gathering: 32 U16 sites use four
times the ideal source sectors. Tensor elapsed utilization is 50.320% fused
versus 72.474% original; both fail 85%. Finite native comparisons and the
scoped sanitizer checks pass, while the existing NaN publication mismatch
remains. [Private whole-trunk integration](../outputs/c32-encoder-transition-runtime/REPORT.md)
now measures **9.434368 to 9.203499 ms**, a **2.45% reduction**, passing both
execution orders. That paired run uses valid 3713 by 2049 dimensions sharing
the 4K padded field. The separate exact-valid 4K native check passes all 74
boundaries. The private regression passes 55 tests and eight subtests without
skips or failures, including training and prepared graphs. The subsequent
direct-publication version, described next, is the installed encoder route.

The subsequent [isolated wider-input-load trial](../outputs/c32-down4-input-vector-runtime/REPORT.md)
passes numerical and scoped sanitizer checks but fails its performance gate:
170.464 microseconds versus 172.752 for V2 and 126.080 original, with only one
of six orders meeting the strict 3% V2 improvement. It is not selected. The
[completed matched NCU analysis](../profile/c32-down4-input-vector-v36/REPORT.md)
confirms 75% fewer input sectors, but 1.28 million more warp instructions and
unchanged register-limited occupancy. Tensor elapsed utilization remains
50.689%; both candidate and original still fail the elapsed 85% gate.

The separate [direct FP8-publication trial](../outputs/c32-down4-native-publication-runtime/REPORT.md)
now passes all six component orders: **153.888 microseconds versus 171.584 V2**,
a **10.31% reduction**, with original at **126.032 microseconds**. It also fixes
all three tested NaN discrepancies: both outputs match native across all seven
exceptional fixtures and all finite fixtures. Exact-kernel memcheck/racecheck
pass. Its [private whole-trunk integration](../outputs/c32-encoder-transition-native-publication-runtime/REPORT.md)
passes all 19 wrapper contracts and 74 exact-valid 4K native boundaries. The
balanced shared-field comparison measures **9.433189 to 9.194939 ms**, a **2.53%
reduction**, with both execution orders and paired-ratio checks below 0.99.
Its regression passes 55 tests and eight subtests, with zero skips or failures;
the final metadata policy and binary are now installed. Its
[completed matched NCU report](../profile/c32-down4-native-publication-v36/analysis/REPORT.md)
confirms 26.60 million fewer warp instructions than V2 with unchanged tensor
work and global sectors. Elapsed tensor utilization is 57.413% versus 72.395%
native; both still fail every eligible 85% gate. The source-counter audit also
locates extra converted-pair joins and reciprocal refinement for separate
experiments, without treating instruction counts as predicted speedups.

The [converted-pair join experiment](../outputs/c32-down4-native-pair-join-runtime/REPORT.md)
removes all 204 explicit converted-pair joins in compiled SM120 code and passes
finite/exceptional and scoped sanitizer checks. It measures 150.016 versus
154.976 microseconds for direct publication and 127.168 native, but only three
of six orders clear its strict 3% incremental gate. It is not selected. Its
[completed matched counters](../profile/c32-down4-native-pair-join-v36/analysis/REPORT.md)
confirm 6.71 million fewer join PRMT executions, but unchanged memory sectors
and registers. Fresh elapsed tensor/L2-data/DRAM utilization is
59.086%/8.404%/32.396%, so the 85% gate still fails.

The subsequent first-skip preload passes all seven qualification runs but
fails the incumbent speed gate in all 24 orders: 146.880 microseconds versus
145.712 for affine-store and 129.216 native in that run. The earlier load is
verified in assembly, but it increases compiler spill payload and provides
no qualifying latency benefit. It is not promoted. See the
[comparison](../outputs/c32-skip-prefetch-matched/run-paired-4k-v1/proof.json).

Kernel dispatch runs entirely in C++. `tuning/sm_<architecture>.json` is an offline
measurement record; `run_tuning.py generate` translates its choices into
`csrc/kernel_launcher/tuning_policy.h`. Rebuild the extension after generating a
new header. Python imports do not parse JSON, query a tuning database, or select
kernels. Unmeasured `(SM, operator, dtype, numel, channels)` keys use 256 threads.
The shape is retained in JSON; shapes with the same compiled key cannot have
conflicting entries. A policy measured on one GPU model is not a performance
guarantee for every GPU of the same SM architecture.

## Reproducing tuning

```powershell
.\.venv\Scripts\python.exe run_tests.py -k tuning -q
.\.venv\Scripts\python.exe run_tuning.py workloads --output tuning/workloads.json
.\.venv\Scripts\python.exe run_tuning.py tune --workloads tuning/workloads.json --generate
# Then rebuild using the project's build command.
```

For a smaller explicit workload:

```powershell
.\.venv\Scripts\python.exe run_tuning.py tune --shape 1,256,288,32 --iterations 20 --repeats 5 --generate
```

The default shapes follow OpenDLSS-NR's `nr_graph.cpp` geometry for a 512x512
valid image: a padded 576x512 field and successive encoder resolutions, with
32/64/128/256 channels. Inputs are deterministic synthetic tensors with those
shapes, not native captured activations. Supply another manifest to tune actual
deployment geometry. BHWC is the spatial tensor layout.

Each 128/256/512-thread candidate must match an independent PyTorch expression
before timing. The references include FP16 rounding stages, DLSS's cubic SiLU
approximation, native fused half residual arithmetic, and ordered pooling sums. FP8
publication is FP32 -> FP16 -> saturating E4M3FN, NaN -> positive zero. FP8
publication requires sm89+; FP16 requires sm80+. Float16, float32 and bfloat16
refer to the working tensor storage; they do not change the network's specified
intermediate publication precision.

Timing uses CUDA events around CUDA graph replay after warmup. Each graph has
multiple operator calls with the same inputs and distinct live outputs. The
reported latency is the median of multiple batches, divided by calls per batch.
This amortizes Python launch overhead and records the exact protocol in JSON.
The working set includes all live captured outputs, which can exceed L2. Use
fewer `--iterations` when graph output storage is too large for the device.
Allocation during initial capture is excluded; the deployment API's launch and
device work remain in replay. Competing GPU work makes timings unreliable, so
reserve the GPU while tuning. Clocks are not silently changed by these scripts.

`torch.ops.dlssnr.set_tuning_threads(n)` is an offline, process-wide override.
The tuner restores the previous value even if a candidate fails. Do not tune
concurrently with application inference. Zero restores compiled C++ selection.
An existing captured graph retains the launch parameters selected at capture
time, so capture it again after changing policies.

## NCU counters and SASS

The profiling workflow follows NVIDIA KDA's `ncu-report-skill`. Every run creates
a new `profile/<operator>-<dtype>-<threads>-<timestamp>/` with `harness/`,
`reports/`, `analysis/`, and `REPORT.md`. It snapshots the CUDA source, workload,
commands, and binary hash. Profiling the compiled extension preserves the exact
deployment kernel and dispatch; the build supplies `-lineinfo`. A CUDA profiler
start/stop region isolates one warmed operator from Python/torch initialization.

```powershell
.\.venv\Scripts\python.exe run_tuning.py profile --op publish_fp8 --dtype float16 --shape 1,256,288,32 --threads 256
.\.venv\Scripts\python.exe run_tuning.py profile --op silu --dtype float16 --shape 1,256,288,32 --threads 256
```

Two reports are collected: `--set full` plus available PM sampling sections,
and `--set source --section SourceCounters`. Section names are queried from the
installed NCU because versions and GPUs differ. NCU 2026.3 emits `.ncu-repz`;
older `.ncu-rep` is also supported. Full metric tables are parsed with NVIDIA's
`ncu_report` module. The collector stores per-PC source/stall samples, available
PM timeline instances, rule-engine output, and `cuobjdump --dump-sass` output.
Read the raw details report before proposing an optimization. Source snapshots
and binary hashes permit comparisons between actual builds.

NCU uses kernel replay with cold caches (`--cache-control all`). This differs
from the CUDA graph timing protocol and must be stated when interpreting L2 vs
DRAM utilization. Profiling overhead is not benchmark latency. Missing counters,
profiling permission errors, unsupported PM sections, or missing source mappings
are recorded as limitations; they are never converted into successful results.
PM sampling has little diagnostic value for kernels shorter than its sampling
interval. A large representative shape should also be profiled before making
a bandwidth claim.

## Acceptance gates

No >=85% roofline or "at least as fast as NVIDIA" claim follows merely from a
successful build, correct output, or the presence of tensor-core instructions.
The gate requires all of:

1. Correctness for the measured operator and input.
2. At least 85% in a supported NCU elapsed-cycle sustained-throughput metric for
   L2 data bandwidth, DRAM, or the tensor pipe. Occupancy, hit rate and
   active-cycle-only metrics do not qualify. Since v31, aggregate L2 throughput
   and tag/request throughput are diagnostic only: a saturated request path
   cannot pass the data-bandwidth gate. L2 uses `lts__d_sectors` elapsed-peak
   metrics. Missing eligible counters yield `unverified`.
3. Median latency no greater than a comparable official NVIDIA implementation
   measurement on the same GPU UUID, driver, operator boundary, shape, dtype,
   precision and timing protocol, with the official binary SHA256 recorded.

Use `run_tuning.py gate --measurement ... --metrics ... --official-baseline ...`
to evaluate these conditions; exit status 2 means either failed or unverified.
The measurement JSON must include `correct`, `gpu_uuid`, `driver_version`, `op`,
`dtype`, `precision`, `shape`, `timing_protocol`, and `median_ms`. The baseline
has matching fields plus `implementation: "official_nvidia"` and
`artifact_sha256`. The metrics JSON maps exact NCU metric names to numeric
values. User-supplied baseline metadata must itself come from an authentic run;
the JSON schema alone cannot establish provenance.

OpenDLSS-NR's public Vulkan/PTX implementation is a useful correctness and
performance reference but is not the official NVIDIA baseline. Original cubins
extracted from the signed DLL are available under `assets/vendor_modules/`;
static SASS inspection establishes instruction choices only. Their fused stage
boundaries cannot be directly compared to the latency of one unfused operator.
The subsequent FFN harness in `tools/vendor_benchmark.py` now provides an
authentic, same-boundary native stage comparison; see the preserved JSON under
`outputs/vendor_ffn_baseline.json`. Per-stage results do not prove whole-network
parity or speed.

## Supported tuning surface

Thread candidates currently cover publication (FP16 and FP8), packed FP8 input conversion, cubic SiLU,
residual, 2x2 pooling, and nearest 2x upsampling. GEMM has a separate measured tile
policy: `gemm_sm_120.json`, compiled into `gemm_policy.h`, keyed by device,
precision, batch count, M/N/K and the original partition boundary. Unmeasured
keys use the original exact warp kernel. Changing an unrelated thread override
does not tune GEMM. Backward correctness and CUDA graph checks are tested separately.
Backward efficiency is not claimed to satisfy the inference roofline gate.

## Recorded sm120 measurements (2026-10-03 local time)

The first optimization replaced scalar unary loads/stores with aligned 16-byte
loads/stores, independent unrolled conversion chains, and a scalar fallback for
misaligned storage offsets or short tails. SASS confirms `LDG.E.128` and
`STG.E.128`. Sixty operator/dtype/shape combinations, each with three thread
candidates, were correctness-gated and timed on the RTX PRO 6000 Blackwell,
driver 610.62, PyTorch 2.8.0+cu128. The compiled policy is in `sm_120.json`.

At BHWC `[1,256,288,32]`, FP16 working storage:

| Operator | Initial graph latency | Vector graph latency | Cold NCU latency before/after | DRAM read throughput before/after |
|---|---:|---:|---:|---:|
| FP8 publication | 5.842 us | 2.453 us | 8.544 / 4.736 us | 32.60% / 58.66% |
| Cubic SiLU | 5.928 us | 2.424 us | 8.448 / 5.120 us | 33.08% / 54.74% |

The graph timing comparison used 20 captured calls per replay and 5 initial / 7
optimized repeats. Later all-shape tuning can select slightly different thread
counts owing to measurement noise; the raw candidate samples are retained.
FP32 working-storage timings did not materially improve at this shape. This is
a measured local improvement, not a blanket network speedup.

The larger full-field `[1,512,576,32]` FP8 publication case reached **83.9066%**
DRAM read throughput, 35.32% L2 throughput, and 13.216 us cold-cache NCU duration.
It **does not pass the 85% gate**. Its 4.09 waves/SM and 85.33% achieved occupancy
show that it fills the device better than the small case; NCU identifies DRAM
as the limiting resource. On the small case, long-scoreboard stalls still
dominate after vectorization, while the lower total instruction count reduces
runtime. PM sampling supplies too few samples for confident fine-grained
timeline conclusions. No register spills were observed in these kernels.

A second optimization uses pairs of half values directly for FP8 conversion
and vectorizes the packed-byte input conversion used by every FP8 GEMM. It
preserves NaN-to-zero and signed zeros, verified over all 65,536 FP16 bit
patterns. The final tuner covers **70 combinations / 210 passing candidates**.
At `[1,512,576,32]`, FP16 -> packed FP8 improves from **19.262 us to 5.502 us
(3.50x)** against the archived scalar implementation, each selecting its best
128/256/512-thread candidate under the same 20-call, 7-repeat graph protocol.
The scalar binary hash and all baseline samples are preserved alongside the
new profile. This measures the conversion actually used by the GEMM launcher.

The final packed-conversion NCU run reports 79.26% DRAM read throughput, 10.15%
write throughput, and 29.35% L2 throughput. The final paired publication run
reports 79.84% DRAM read and 33.69% L2 throughput. Read and write percentages are
not added to manufacture a passing score. The earlier 83.9066% observation is
retained as an earlier-build result, not the final build's performance claim.
All these measured cases remain below the 85% acceptance threshold.

Evidence:

- [FP8 publication comparison](../profile/publish_fp8-comparison-20261002T193547_784687Z/REPORT.md)
- [Cubic SiLU comparison](../profile/silu-comparison-20261002T193547_840056Z/REPORT.md)
- [Full-field FP8 publication report](../profile/publish_fp8-float16-t128-20261002T193601_068656Z/REPORT.md)
- [Final packed GEMM-input conversion report](../profile/pack_fp8-float16-t512-20261002T194155_441857Z/REPORT.md)
- [Scalar packed-conversion timings and binary hash](../profile/pack_fp8-float16-t512-20261002T194155_441857Z/analysis/scalar_pack_baseline.json)
- [Final paired FP8 publication report](../profile/publish_fp8-float16-t128-20261002T194235_670892Z/REPORT.md)

The overall performance requirement remains unverified: the recorded memory
operators do not pass the 85% gate, and a complete native network comparison has
not been obtained. The separately verified native FFN comparison does not cover
every network stage.

## GEMM operand delivery and register tiling

The original exact GEMM used one 16x8 fragment per warp, repeatedly fetching A
and W from global memory. NCU at M96/N4096/K1024 found 44.7% long-scoreboard
stalls, 51% excessive global sectors, and 3.68% tensor-pipe utilization. Its
22.62 us cold-cache duration is separate from the 17.19 us graph timing.

The first tiled implementation stages aligned 16-byte copies with `cp.async`,
double buffers padded shared-memory rows, keeps multiple independent MMA
accumulators, and coalesces output stores. Every output retains the original
FP16-accumulator MMA instruction, ascending K order and ordered half additions
between existing partitions. Variant 3 schedules those already-required
partitions independently and uses an ordered half reduction; it introduces no
new split boundaries. Misaligned input storage falls back safely.

The second tuning round recorded 101 precision/shape cases from the prepared
network and diagnostic expansion shapes, with 606 exact candidates. The
121-case CUDA test suite additionally checked seeds, odd tails and batches,
storage offsets, graphs and nondefault streams. Measurements are retained in
`outputs/gemm_candidates_v2.json` with binary hash and graph-event samples.

| FP8 GEMM M/N/K; original partition | Original warp kernel | Best second-round tile |
|---|---:|---:|
| 96 / 1024 / 4096; 1024 | 47.186 us | 9.587 us |
| 96 / 4096 / 1024; full K | 17.187 us | 8.269 us |
| 640 / 4096 / 1024; full K | 72.074 us | 16.254 us |
| 2160 / 4096 / 1024; full K | 231.738 us | 41.075 us |

The 128x128 tile at M640 records zero shared-memory bank conflicts and zero
spills. Its cold-cache NCU report measures 20.960 us, 42.22% L2 throughput,
27.17% tensor-pipe activity and 8.37% achieved occupancy. Fixed-latency waits
account for 49.8% of issue cycles, with sampled NOPs between MMA instructions;
160 four-warp CTAs do not fill 188 SMs well. These counters motivate the next
LDSM operand-load and eight-warp candidates. They do not pass the 85% gate.

Evidence: [baseline GEMM profile](../profile/gemm-fp8-96x4096x1024-p0-20261002T204708_545213Z/REPORT.md),
[128x128 tile profile](../profile/gemm-fp8-640x4096x1024-p0-v6-20261002T211216_641746Z/REPORT.md).

The next round added `ldmatrix.x4` delivery and an eight-warp 128x128 tile.
All 1,010 measurements across 101 shapes were bitwise exact. LDSM gave modest
gains on the small expansion, while the large expansion retained the original
LDS tile. The kernel policy therefore selects per shape instead of treating
LDSM or a larger block as universally faster.

The fourth round fused the half-accumulator output, native cubic activation and
FP8 publication in one kernel. Packed output is available at the native FFN
boundary; prepared models use decoded FP8 values in half storage. FP16 has a
matching fused cubic path. The 238 combined GEMM/activation tests cover tails,
odd batches, seeds in the unfused operators, alignment fallbacks, overflow
amplitudes, capture and nondefault streams. All **2,400** measurements pass
bitwise correctness: 101 raw-GEMM, 93 activated-half and 46 packed-E4 shape
records, each with ten candidates. The JSON and generated C++ policy include
the epilogue in their dispatch key. See `outputs/gemm_candidates_v4.json`.

An authentic same-device comparison using the original NVIDIA FFN kernel now
verifies the complete packed-input / cubic / packed-output boundary, including
all output bytes. Results cover two independently decoded blocks:

| Expansion M / N / K | Fused extension | Original NVIDIA |
|---|---:|---:|
| 96 / 4096 / 1024 | 8.44 us | 11.95 us |
| 640 / 4096 / 1024 | 15.62 us | 12.34 us |
| 2160 / 4096 / 1024 | 42.68 us | 27.13 us |

These are block 31 graph timings; raw samples and the second block are in
`outputs/vendor_ffn_fused_m96.json`, `vendor_ffn_fused_m640.json` and
`vendor_ffn_fused_m2160.json`. The smallest case passes the native-speed part of
the requirement. The larger two remain slower, so the requirement is not met
across the measured stages.

The original M640 kernel itself records 17.92 us under cold-cache NCU, 31.42%
tensor-pipe activity and 27.28% L2 throughput, with 139 registers and 24.6 KB of
shared memory. Its 160 four-warp CTAs are also limited by a small launch;
fixed-latency waits account for 39.9% of issue cycles. Native SASS uses direct
coalesced `LDG.E.128` weight fragments and stages A in shared memory. This
motivates persistent weight-layout packing and A-only buffering in the next
experiment. Even the original native kernel is below the requested 85% metric
on this small shape; no achieved roofline claim follows from matching its speed.
See [original FFN full/source/SASS evidence](../profile/vendor-ffn-expand-640-block31-20261002T212822_440250Z/REPORT.md).

The 1080p trace added 237 precision/shape/epilogue records, each with ten exact
candidates (`outputs/gemm_candidates_1080_v5.json`). M640 global QKV improved
from 59.49 to 15.28 us and the partitioned 4096→1024 contraction from 81.17 to
30.80 us. These shapes were absent from the earlier 512-only policy; measured
coverage is tracked separately from configuration transfer.

The next experiment uses persistent coalesced weight fragments, triple-buffered
A-only shared memory, and `ldmatrix` A fragments. Four variants retain the
same ordered half-accumulator arithmetic. The 14 prepacked CUDA regressions
passed, and 60 candidate observations were exact. Comparison measures the best
compiled row-major configuration with resident row-major weights; no inverse
layout conversion is included in that reference. In this run packed-E4 output
M640 measured 14.83 us versus 16.01 us resident row-major, and M2160 measured
31.99 versus 47.16 us (`outputs/gemm_prepacked_v6.json`). M96 favored row-major.
These measurements justify caching both formats and choosing by matrix rows;
they do not establish native speed or 85% roofline success for the new kernel.

[Continuous resolution tuning](resolution_tuning.md) now enumerates every
integer resolution across 720p–4K bounds, deduplicates padded geometry and
operator shapes, and distinguishes measured coverage from nearest-configuration
selection. CPU enumeration alone does not satisfy the performance gate.

The v9 grouped kernels read shared or interleaved branch inputs directly and
write interleaved outputs, removing broadcast and transpose copies. Their
97 focused CUDA regressions passed. All 600 candidate comparisons across 60
FP8/FP16 shape and epilogue keys were bit-exact. Compared with the resident
earlier GEMM policy including its original grouped layout copies, selected
variants were 1.80–4.82 times faster (median 2.58). For the 4K FP8 expert expansion
G2/M522240/N128/K64, packed output measured 93.32 us versus 449.83 us; its grouped
contraction measured 130.57 us versus 432.38 us. Evidence is retained in
`outputs/grouped_candidates_v9.json`; the new policy adds 60 distinct grouped
layout records, for 492 records total.

The grouped expansion's cold-cache NCU run measured 116.48 us, 41.67% L2,
19.19% tensor activity and 57.24% aggregate DRAM throughput. It used 79 registers
per thread and 40.96 KB shared memory, with no local-memory spills. Shared memory
limits occupancy to 33.33%; achieved occupancy was 32.06%. These counters support
reducing shared allocation for short-K groups as a next experiment. The
requested 85% gate remains unmet. Full/source reports and SASS are in
`profile/gemm-fp8-b2-522240x128x64-p0-v10-e2-l2-20261002T232351_145842Z`.

## Direct expert layouts and v9 deployment

The direct grouped GEMM consumes shared or interleaved expert inputs and writes
interleaved outputs, removing broadcast and transpose materializations. Binary
`7349c48eb3f5c6231fe6e2ee1304c163c94564c3df63fd71125ad8912e5c8ffb`
passed the full opt-in suite: 929 tests, seven subtests and one skip, including
floating training, quantized surrogate gradients, all 77 graph boundaries and
CUDA Graph replay after input mutation.

Complete network CUDA Graph medians on the local SM120 device, batch one,
three warmups and seven samples:

| Valid input | Padded field | FP8, half storage | FP16 | FP8, byte publications |
|---|---|---:|---:|---:|
| 512×512 | 576×512 | 3.760 ms | 4.207 ms | 3.770 ms |
| 1920×1080 | 1920×1152 | 12.575 ms | 14.455 ms | 13.255 ms |
| 3840×2160 | 3840×2176 | 49.676 ms | 55.982 ms | 49.346 ms |

These include the network adapter and four-lane output head, starting from
prepared BHWC features. Renderer feature generation and temporal reprojection
are external. Byte publications still need half bridges around C32 blocks and
residual seeds in v9 and do not consistently outperform half storage. The
experimental register C32 operator is not used in these measurements.
Evidence: `outputs/model_prepared_v9.json`, `outputs/model_packed_v9.json`,
and `outputs/v9-all-tests.xml`.

The first register C32 kernel passes 89 focused bitwise tests and uses no shared
workspace or spills. Its 512×576 packed-input/packed-only-output cold NCU run
measures 70.11 Âµs, 14.85% tensor activity and 12.98% L2 throughput, with 189
registers and 15.42% achieved occupancy. SASS shows many more logical,
predicate, shuffle and address instructions than the original; fixed-latency
dependencies account for 30.1% of sampled warp stalls. This motivates
branchless NaN handling and investigation of the native channel permutation.
Native-speed and 85% resource gates remain unmet. Profile:
`profile/block32-register-fp8-b1-512x576-phase1-block1-20261002T231450_678451Z`.

## Register dispatch and fused residual merges

The v10 register kernel replaces scalar NaN handling with a packed half predicate.
Its exhaustive conversion tests cover all 65,536 half encodings. On the same
512×576 packed-input/packed-output workload, cold-cache NCU time fell from
70.11 to 54.304 Âµs. Registers fell from 189 to 180 and executed instructions
from 36.05 to 25.92 million, with no spills. Tensor activity was 19.88% and L2
throughput 16.72%; neither reaches the requested 85% gate. Evidence:
`profile/block32-register-fp8-b1-512x576-phase1-block1-20261002T232859_988346Z`.

The compiled v11 C32 policy selects the register or shared kernel by device,
precision, input/output storage, raw-output requirement, explicit skip and
window phase. Its 192 measured records preserve exact output bytes. The nearest
measured window count supplies a configuration, with endpoints clamped and a
shared-kernel fallback for unmeasured families. Input dimensions remain intact.
The prepared graph suppresses unused C32 raw-output stores. Packed grouped
contractions now publish E4 bytes directly, and residual seeds and cropped
upsample/skip merges each use one CUDA operator.

Skip merges require a native half FMA. Original SASS contains `HFMA2`, including
decoder upsampling and the post block, although the extracted PTX displays
separate multiply/add operations. A float32 FMA followed by a half conversion
can double-round: `2^-24 + half(0.6669921875) * half(1.5)` must produce
`1.0009765625`, not `1.0`. Deployment now uses `__hfma`/`__hfma2`; the independent
reference uses exact double arithmetic and explicit half midpoint correction.
The post block's input scaling remains a separately rounded half multiply.
The fused merge covers cropped dimensions and independently packed or half
inputs without changing that arithmetic.

For binary `01f474cbbc8d1a502623f7a623ab964bd9bfce2359b63294a06de5b09e9e373d`,
272 focused tests passed; the full opt-in run passed 1,148 tests and seven
subtests, with 66 skips and one test-loader failure. That loader accidentally
read the C32 policy as a memory policy; using the same exact filename filter
as the generator fixes it, and its targeted rerun passes. The uncompiled rotated
candidate accounts for 65 skips; the other skip needs two devices. A separate
127-test dispatch/merge Compute Sanitizer run reports zero errors. Logs are
`outputs/v11-focused-tests.xml`, `v11-all-tests.xml`,
`v11-policy-runtime-tests.xml`, and `v11-new-kernels-memcheck.log`.

Complete-network medians with the same batch-one, three-warmup, seven-sample
protocol as v9:

| Valid input | FP8, half storage | FP16 | FP8, byte publications |
|---|---:|---:|---:|
| 512×512 | 3.374 ms | 3.963 ms | 3.280 ms |
| 1920×1080 | 10.478 ms | 13.400 ms | 9.980 ms |
| 3840×2160 | 41.775 ms | 52.319 ms | 36.424 ms |

These timings cover prepared features through the output head, without renderer
preprocessing. They are candidate-only timings, not evidence of original DLL
speed. Evidence: `outputs/model_prepared_v11.json` and `model_packed_v11.json`.
The packed 4K attribution profile still shows 4.80 ms in byte copies and 3.19 ms
in packing, including grouped contractions whose new packed-output family has
not yet been tuned. Those families need measured direct-layout policies before
assessing the next fusion against the best resident baseline. Attribution
includes profiler overhead: `profile/network-fp8-packed-20261003T000918_530649Z`.

## Packed contraction policy measured after v11

Using the v11 binary above, the offline tuner measured the four actual packed
contraction families at valid 512×512, 1280×720, 1920×1080, 2560×1440 and
3840×2160. All 200 candidate comparisons across 20 shape keys matched every
output byte. CUDA Graph timing used 30 resident invocations and seven samples.
Selected direct kernels were 2.57–3.94 times faster than the resident earlier
GEMM policy with its grouped layout copies and packed publication. For the
4K C64 contraction, G2/M522240/N32/K128, the selected kernel measured 115.03 Âµs
against 421.43 Âµs for that composed baseline. These are operator measurements;
they do not establish a complete-network or original-DLL speedup.

The resulting policy adds only the 20 verified EP3 keys, preserving all earlier
records: 512 total, generated GEMM policy version `ec70c084051c4c3e`. The new
header was compiled into v12. Other
row counts in each matching family transfer the nearest measured configuration,
including endpoint clamps; their performance has not been measured by this
run. Device and binary provenance, every candidate, and timing samples are in
`outputs/grouped_ep3_v11.json`. The first fused expert FFN experiment remains
a private candidate until its own exactness and timing gates pass.

## Rotated C32 and fused experts, measured with v12

Binary `495b3d037808d85aed8adac89381ae5aff6d93b7f8f9f21beeff073f662b08ef`
passes 296 focused tests. Its 164-test new-kernel Compute Sanitizer run reports
zero errors. Rotated C32 also matches 65,536 output bytes across 32 direct
unchanged-original-kernel cases, including four window phases and every finite
E4M3 encoding. This validates the tested block arithmetic, not the NGX host path.

The 192-case C32 sweep compares identical input storage, requested output
storage, raw-output requirements, explicit/implicit residuals and window phases.
123 rows beat both canonical register and shared baselines by at least 3%;
69 retain the canonical kernel. All 128×128 rows retain the canonical kernel.
The generated table version is `757f135b0e474f97`, prepared for the v13 build.
Dual weight caches retain their canonical view, so unmeasured-device and
uncached callers have allocation-free configuration fallbacks. The runtime
still uses nearest window-count selection and clamps beyond measured endpoints.

For phase one, packed input and packed-only output with implicit residual:

| Block field H×W | Rotated | Canonical | Shared, same I/O |
|---|---:|---:|---:|
| 128×128 | 9.502 Âµs | 9.078 Âµs | 14.052 Âµs |
| 512×576 | 29.478 Âµs | 35.544 Âµs | 103.491 Âµs |
| 1088×1920 | 175.328 Âµs | 222.928 Âµs | 896.624 Âµs |

These are CUDA Graph measurements. The corresponding 1088×1920 cold-cache NCU
run is 219.04 Âµs, with 147 registers, no spills, 24.08% achieved occupancy,
37.86% tensor activity and 29.18% L2 throughput. Store sectors and dependency
stalls motivate further epilogue coalescing. The 85% gate remains failed.
Evidence: `outputs/block32_rotation_v12_measurements.json`,
`outputs/block32_rotation_v12_verification.json`, and
`profile/block32-rotated-fp8-b1-1088x1920-phase1-block1-20261003T002313_889407Z`.

The private expert fusion combines W1, cubic activation/E4 publication and W2,
preserving ordered half MMA accumulation. All 18 candidates over nine shapes
are byte-exact. Best timings are 1.61–2.29× faster than the fastest measured
resident composed variant. At the 4K C64 level, fusion is 95.55 Âµs versus
219.23 Âµs. Its cold NCU run is 111.20 Âµs with 70 registers, no spills, 40,960
shared bytes, 31.82% occupancy, 32.91% L2 and 28.64% tensor activity. The wait
on asynchronous operand copies is the main measured stall. Nine measured
SM120/channel/row-count records generate policy `19a5029e2db1841e` for v13;
unknown devices use the composed operators. Evidence:
`outputs/group_ffn_candidates_v12.json` and
`profile/group-ffn-fp8-c64-m522240-v2-20261003T002126_904841Z`.

Full-trunk native comparisons remain provisional: allocation/order-sensitive
first-execution differences were isolated to unchanged original global
attention, with matching Q/K/V and stable candidate outputs. The retained
native-buffer snapshots rule out candidate mutation. See the original-kernel
replay/racecheck investigation in `docs/vendor_runtime.md`; historical passing
trunk cases do not establish an all-resolution or official-host-runtime gate.

## Combined v13 validation and network timing

Binary `d102d79faedd7d02881be3d5d1775bdc821d4c61e7738c271f4aa121e12d0a89`
passes the full opt-in suite: 1,553 tests and seven subtests, with one skip
requiring a second GPU. A separate 357-test Compute Sanitizer run for rotated
C32, cached dispatch, fused experts, residual GEMM and post70 reports zero
errors. This includes complete FP32/BF16 training, all 77 prepared publication
boundaries, and CUDA Graph replay after input mutation.

The deployed C32 and expert policies reduce complete-network FP8 packed-storage
graph medians to:

| Valid width×height | FP8 byte publications |
|---|---:|
| 512×512 | 2.799 ms |
| 1280×720 | 4.646 ms |
| 1920×1080 | 7.956 ms |
| 2560×1440 | 12.176 ms |
| 3840×2160 | 27.818 ms |

Same device, batch one, three warmups and seven samples. The 4K packed result
improves on v11's 36.424 ms by 23.6%. These timings start from prepared features
and include the final head; they are not an original-DLL comparison.
`outputs/model_packed_v13.json`, `outputs/model_prepared_v13.json`,
`outputs/v13-all-tests.xml`, and `outputs/v13-new-kernels-memcheck.log` retain
the samples and checks.

Two private candidates were also measured with v13. Fused post70 includes
cropped upsampling, the separately rounded input scale, true half-FMA adapter
merge, C32 block and FP16 output head in one kernel. All eight measured cases
match their composed FP32 head exactly. At full 4K field size, packed input
measures 0.689 ms versus 2.760 ms for the deployed composition. Its 1080p-field
cold profile reaches 45.22% tensor activity, below 85%.
`outputs/post70_v13.json` and its `profile/post70-*` report retain the evidence.

The residual GEMM experiment fuses the half-rounded residual seed before the
first ordered MMA and optional packed output publication. All 36 candidates
over six shapes in each precision are exact. Best packed-FP8 gains are
1.15–2.06× versus the resident composition; FP16 gains are 1.06–1.36×.
`outputs/residual_gemm_packed_v13.json` and `outputs/residual_gemm_fp16_v13.json`
record these operator-only results. Neither private fusion is included in the
v13 complete-network timings above; production integration needs a later build.

## Integrated v14 validation and timing

Binary `20341e11d0d7f1e117dd6642bd603eab0587035c41d9dd6c01342f3dc5c1fac4`
integrates the public residual-seeded GEMM and post70/head dispatchers and the
full 1,680-record expert policy `ef32bc0605560067`. It passes 809 focused tests
and a 255-test new-kernel memcheck with zero errors. The full opt-in run passes
1,797 tests and seven subtests, with 147 skips: 146 cases for the not-yet-installed
private wider-window experiment plus one requiring a second GPU.

Complete prepared-feature-to-head graph medians, batch one, three warmups and
seven samples on the same SM120 device:

| Valid width×height | FP8 bytes | FP8 half storage | FP16 |
|---|---:|---:|---:|
| 512×512 | 2.701 ms | 3.331 ms | 4.005 ms |
| 1280×720 | 4.414 ms | — | — |
| 1920×1080 | 7.327 ms | 9.463 ms | 13.355 ms |
| 2560×1440 | 11.067 ms | — | — |
| 3840×2160 | 24.994 ms | 37.662 ms | 51.684 ms |

Every captured output equals eager output and is finite. The packed 4K graph
is 10.2% faster than v13. This table excludes renderer preparation/composition;
it is not a complete original-runtime comparison. Samples and hashes:
`outputs/model_packed_v14.json`, `outputs/model_prepared_v14.json`,
`outputs/v14-all-tests.xml`, `outputs/v14-new-kernels-memcheck.log`.

Unchanged original chained-kernel trunk comparisons are exact at all 74
boundaries, two extra complete replays and graph replay for 720p, 1080p and 4K.
Candidate packed/native medians are 4.143/2.192 ms, 6.554/2.555 ms and
21.707/5.998 ms, respectively. Those ratios fail the original-speed gate.
Trunk scope excludes endpoints 0/70 and remains distinct from the complete
prepared graph above. Reports:
`outputs/vendor_trunk_chained_packed_{720,1080,4k}_v14.json`.

The [human-readable walkthrough](optimization_walkthrough.md) connects these
results to the arithmetic, layout and fusion changes, with the failed
experiments and remaining performance gates stated explicitly.

## Integrated v16 window policy

The 288-anchor C64/C128/C256 window policy and omitted unused raw outputs
reduce the prepared FP8 graph latency to 2.459/3.551/5.625/8.404/17.022 ms
at 512 square/720p/1080p/1440p/4K. These are batch-one resident graph medians,
three warmups and seven samples. The packed 4K result is 31.9% below v14.
FP16 at 4K is 50.109 ms; its ordered composition is a separate implementation.

Binary `f79e96c8c37698e5a6989cad8b62f62806262cbe4633ba65f58e79b144c11553`
passes 2,103 full-suite tests and seven subtests, with 67 skips, and the 38
window dispatch tests under memcheck with zero errors. The skips comprise
66 cases for an uninstalled experiment and one requiring a second GPU.

Matched resident packed-trunk/original medians are 3.282/2.185 ms at 720p,
4.885/2.550 ms at 1080p, and 13.847/5.999 ms at 4K. All 74 boundaries,
two additional full replays and captured output agree. These ratios still
fail the original-speed gate. Evidence: `outputs/model_packed_v16.json`,
`outputs/model_prepared_v16.json`, `outputs/v16-all-tests.xml`,
`outputs/v16-window-dispatch-memcheck.log`, and
`outputs/vendor_trunk_cached_anchors_v16.json`.

v17's scheduling/store experiments are documented in the walkthrough with
their 288-contract timing and four separate native proofs. Its combined
C128 272×480 profile reaches 41.87% tensor, 28.99% L2 and 7.38% DRAM
utilization. The private residual-vector profile reaches 69.39% DRAM.
Neither meets 85%. The selective policy is compiled and measured in v19 below.


## v19 validated private experiments and v20 integration

v19 `d28b19f8cb15e612d716ca6ebd721962c65772efe3b89780e5132156c3693acd`
passes 2,784 full-suite tests/seven subtests (one two-GPU skip), 288 focused
new-kernel tests and the same 288 under memcheck with zero errors. Twenty
selected mutated-capture cases pass bounded racecheck with zero errors/warnings.
`outputs/validation_v19.json` records report hashes and binary association.

Its production graph includes the selective window policy. Prepared FP8 graph
medians at 512 square/720p/1080p/1440p/4K are
2.647/3.723/5.782/8.600/16.684 ms. Compared with the earlier v16 run, only the 4K
measurement improves; this is not evidence of an across-shape improvement.

The private adapter fusion gains 1.887–3.027× across 32 matched contracts.
Global QKV preparation plus word-load attention gains 2.420–2.878× for FP8 and
2.294–2.619× for FP16 across four token anchors. Native FP8 QKV/attention bytes
are exact in 30 contracts, but random-input candidate/native latency remains
about 1.08–2.02×. Original FP16 ABI parity is unverified. C512 residual reuse
passes 24 real-weight contracts and contributes six measured policy anchors.
These private changes are not included in the v19 full-network timing.

The adapter's 4K NCU profile reaches 81.21% DRAM, 55.05% L2 and 38.66% tensor.
Global preparation reaches 54.57% DRAM; global attention reaches 23.90% tensor.
All remain below the requested 85%. Pair-prefetch window experiments fail the
3% promotion gate against the best existing variant and remain private.

v20 `da62d2d5d7f966e113b26c7e3eb322e39a34b9d845b0c850e1ce00ae08ecc73c`
builds all target architectures and passes CPU compiled-policy agreement tests.
It integrates adapter policy `60faa7bd26e563ad`, global policy
`b0d65b62b131a953`, and residual policy `61acd20342d20301`. It passes 3,056 full-suite tests/seven subtests (two second-GPU skips),
181 focused public tests and 179 GPU dispatch tests under memcheck with zero
errors. Prepared FP8 graph medians are 2.505/3.406/5.021/7.317/13.409 ms at
512 square/720p/1080p/1440p/4K. FP16 4K measures 48.628 ms.

Fresh native trunk checks pass all 74 boundaries and repeated/captured execution
at 720p/1080p/4K. Candidate/native medians are 3.428/2.184, 4.771/2.553 and
12.206/6.027 ms: the original-speed gate still fails. The continuous C32 sweep
ran separately on its pinned v16 binary and completed before v24. Evidence: outputs/validation_v20.json,
outputs/model_packed_v20.json, outputs/model_prepared_v20.json and
outputs/vendor_trunk_cached_anchors_v20.json.
See the [walkthrough](optimization_walkthrough.md) for implementation details,
matched timing tables, failed experiments and evidence scope.

## Integrated v24 and the continuous native comparison

v24 (`baab87033c6725bd298db2d42fb00a48f2d19290471574ade2dc3a6ff9c9cf98`)
integrates the complete C32/global-attention policies, fused adapter/pool and
packed C512 branch FFN. The full suite passes 3,968 tests and 42 subtests, with
two second-GPU skips. Public dispatch passes 342 focused tests; 339 non-full-model
cases pass memcheck with zero errors. Evidence: `outputs/validation_v24.json`.

| Valid width×height | Packed FP8 graph | FP8 Half storage | FP16 |
|---|---:|---:|---:|
| 512×512 | 2.490 ms | 2.499 ms | 3.907 ms |
| 1280×720 | 3.349 ms | — | — |
| 1920×1080 | 5.000 ms | 5.162 ms | 12.953 ms |
| 2560×1440 | 7.087 ms | — | — |
| 3840×2160 | 12.326 ms | 15.510 ms | 48.489 ms |

These complete prepared-feature-to-head results use three warmups and seven
event samples, with finite captured output equal to eager output. Packed 4K
latency is 8.1% below the earlier v20 run. The small differences at other
anchors do not establish improvements beyond measurement variation.
`outputs/model_packed_v24.json` and `outputs/model_prepared_v24.json` retain
samples and policy versions.

The stricter native trunk smoke run compares all 74 boundaries and poisons
both timed graphs' public outputs before two validation replays. Cached
candidate weights, original inputs/weights and guards remain intact. At
720p/1080p/4K, candidate/native medians are 3.298/2.187, 4.862/2.555 and
12.020/6.355 ms. All numerical gates pass; all three speed gates fail.
This is blocks 1–69 with endpoint physical-layout conversion included,
excluding block0, block70 and the NGX host. It is a different boundary from
the complete prepared graph above. `outputs/native-trunk-v24-smoke.json` and
its audit retain this bounded result. The full continuation now completes all
931 geometries, covering all 3,690,401 integer dimension pairs in the requested
rectangle. It passes 68,894 initial byte-exact boundary checks and 137,788 native
replay boundary checks, plus poisoned captured endpoints and integrity checks.
No-op resume preserves the entire journal digest. Every speed gate still fails:
candidate/native ratios are 1.484–2.057, with unweighted geometry median 1.910.
`outputs/native-trunk-v24.json` and `outputs/native-trunk-v24-audit.json` retain
the full result. This excludes renderer endpoints, native FP16 and the NGX host;
event timing does not establish 85% utilization. Reproduction and scope:
[native range runbook](native_trunk_range.md).
