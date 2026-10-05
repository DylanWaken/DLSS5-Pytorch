# C512 deployment: bounded fusion opportunities

This investigation now includes bounded real-weight GPU measurements for the
existing residual kernels. The measured residual choices are now integrated in
the v20 source; compilation and integrated GPU/native-trunk gates are still
pending. Blocks 23–30 and 40–47 contain the C512 branch network. Block 39 is a
transition and is excluded.

## The actual contract

The packed deployment path in `PackedInferenceBlock.forward` is:

1. Full dense 512→512, then E4 publication.
2. Split into eight independent 64-channel branches.
3. Per branch, 64→256, native cubic half arithmetic, E4 publication, then
   256→64 and another E4 publication.
4. Concatenate the branches; dense 512→512 (W4), seeded with the half-rounded
   product of the original input and its FFN scale; publish to E4.
5. Dense 512→1536 QKV; 16 independent heads, each with 64-token shifted window
   attention and width 32.
6. Dense 512→512 projection, seeded with the published FFN times the attention
   scale. Publish to E4 and retain raw half output only when the graph needs it.

All these C512 GEMMs accumulate one ascending, unsplit K chain. The global
C1024 partition rules do not apply. In the current graph, block 30's raw output
feeds pooling. The other C512 raw outputs are not consumed.

## Evidence and limits

The [v16 4K network profile](../profile/network-fp8-packed-20261003T023000_460309Z/analysis/operators.json)
attributes the following time to C512 at `M=8160`, or `68 x 120`. These are
profiler attribution values, not standalone timing measurements. Only operator
rows are included; their corresponding kernel rows must not be added again.

| Scope across 16 C512 blocks | Calls | Profiled device time |
|---|---:|---:|
| W4 and output projection, with separate residual seeds | 32 | 807.307 us |
| QKV projection | 16 | 500.387 us |
| Initial 512→512 projection | 16 | 376.965 us |
| Window attention | 16 | 306.113 us |
| Branch 256→64 contraction | 16 | 240.352 us |
| Branch 64→256 expansion plus activation/publication | 16 | 221.313 us |
| C512 output/input packing, including two transition calls | 66 | 156.161 us |
| Residual seed multiplication | 32 | 103.297 us |

The branch kernels use the existing `BM128/BN128/BK64/WM32/WN64` grouped GEMM
specialization. Expansion needs two N tiles for 256 outputs. Contraction has
64 valid output columns inside a 128-column tile. Those specifics matter when
comparing a warp-sized fusion with the existing tile.

There is no C512-specific NCU report yet. The neighboring
[C64 expert FFN report](../profile/group-ffn-fp8-c64-m522240-v2-20261003T002126_904841Z/analysis/full.txt)
has 32.91% L2 throughput, 17.89% DRAM throughput, 28.6% tensor activity and
62.44% scheduler cycles with no eligible warp. Its source samples identify
waits at the first operand stage and later W2 stage. The later
[prefetched C64 experiment](../profile/group-ffn-k64-fp8-c64-m138240-v2-20261003T012838_002649Z/REPORT.md)
removes the latter hotspot, but still reaches only 32.25% L2, 17.72% DRAM and
25.36% tensor activity. These are different dimensions and branch shapes;
they motivate examining stage waits, but cannot diagnose C512 by themselves.

## First: measure the existing residual kernels

The former FP8 C512 path called `inference_residual_seed`, `fp8_gemm`, then
`pack_fp8` separately. The existing `_gemm_residual` variants 2–4 already
accept N=K=512 and can fuse those operations. Candidate 1 remains the resident
composition. Before this integration the generated residual header had **no
FP8 C512 policy rows**; its 166 C512 rows were FP16. Calling the public residual
API without measured rows correctly retains composition for that family.

[benchmark_c512_residual.py](../tests/benchmark_c512_residual.py) prepares actual
block 23/30/40 weights and real upstream branch/attention operands from seeded
synthetic state. It compares the old model route with candidates 1–4 at
`M=1056/2160/8160`. Every case starts from the same resident operands, has packed
skip/output, and retains identical output storage. Projection starts from half
attention output, so **half→E4 packing is inside every timed projection route**.
Block 30 additionally tests raw output; its W4 raw-output case is explicitly a
diagnostic contract, since only projection's raw output is needed by the graph.

The CPU [plan](../outputs/c512_residual_plan.json) has 24 cases, 96 candidate
timings, and 192 mutated-graph replay checks. Timing uses repeated CUDA Graph
calls with distinct retained outputs and a 256 MiB output budget. Exact bytes,
input/weight immutability and captured replays are required before accepting a
result. It writes measurements, never policy or runtime changes.

```powershell
.venv\Scripts\python.exe tests/benchmark_c512_residual.py --output outputs/c512_residual_v19.json
```

A measured gain would still require the appropriate packed/raw policy keys,
real block and full-model checks, and fresh original-kernel comparisons before
deployment. The FP16 policy is not evidence for a corresponding FP8 choice.

### The bounded residual result

The [v19 measurement](../outputs/c512_residual_v19.json) completed all 24 cases.
All 96 candidate checks and 192 mutated captured replays matched the old model
route exactly and preserved the resident inputs/weights. Variant 2 wins every
M1056/M2160 case; variant 4 wins every M8160 case. Using the faster of old
composition and candidate 1 as the baseline gives these minimum gains across
all real-block/role cases sharing each dispatch key:

| M | Raw side output | Cases | Selected candidate | Minimum speedup |
|---:|---|---:|---:|---:|
| 1056 | No | 6 | 2 | 1.225x |
| 2160 | No | 6 | 2 | 1.197x |
| 8160 | No | 6 | 4 | 1.629x |
| 1056 | Yes | 2 | 2 | 1.279x |
| 2160 | Yes | 2 | 2 | 1.200x |
| 8160 | Yes | 2 | 4 | 1.630x |

For example, block 23's 4K W4 changes from 30.606 to 17.781 us, and its
projection changes from 32.144 to 19.736 us, including half-attention packing.
These are scoped operator timings with real weights and synthetic state, not a
full network or native DLL comparison.

[c512_residual_policy_candidate.py](../tools/c512_residual_policy_candidate.py)
wrote an isolated [six-key additive candidate](../outputs/residual_sm_120_c512_candidate_v19.json).
It requires the exact complete case set and successful equality, immutability
and replay gates. It chooses a common candidate that beats the faster old
composition/candidate-1 timing by more than 3% on **every** peer contract. The
stored baseline/candidate times come from the actual worst-gain representative
case; it does not manufacture an averaged latency. Source report, binary,
device UUID and weight-manifest hashes are pinned alongside all peer checks.

The [23 CPU gate/clamp checks](../outputs/c512_residual_policy_cpu_checks.json)
include missing or failed evidence, a regression in a single peer, unknown
family fallback, endpoint clamps and the nearest-M tie. These anchors
choose variant 2 through M5160 and variant 4 from M5161,
clamping below/above the endpoints. That is configuration transfer, not
performance coverage of intervening resolutions.

### Source integration for v20

The [integration record](../outputs/c512_residual_integration_v20.json) confirms
that all 3,632 previous residual records were preserved exactly and six FP8 C512
anchors were added. The resulting 3,638-row header has policy version
`61acd20342d20301`. The record includes the old records' complete content hash,
the additive candidate hash, and the generated JSON/header hashes.

`PackedInferenceBlock.forward` now calls `inference_linear_residual` for W4
and projection. W4 produces only the published E4 tensor. Projection produces
E4 plus raw half only when the graph consumes it: block 30, or a standalone
block whose output contract explicitly requests raw values. C++ selects the
variant from the device, ordered partition, storage flags and M. Half attention
packing remains inside the projection operator. The other channel widths,
FP16 path and global partition rules are unchanged.

The [focused integration tests](../tests/test_c512_residual_integration.py)
cover the original branches, hidden activation, contracted paths, FFN, QKV,
attention and final publication boundaries at the three anchor geometries for
blocks 23/30/40 and all four window phases. They also exercise batch-two tails,
CUDA Graph replay after changing the state and residual scales, explicit
half/packed skips, default raw-output behavior and compiled policy clamps.
These 55 GPU/compiled tests have been collected but **not run on v20 yet**.
The residual policy/enumeration CPU suite passed 40 tests.

The continuous enumerator now includes both actual C512 dispatch contracts:
packed-only W4/projection and packed-plus-raw projection. The
[updated range plan](../outputs/c512_residual_range_plan_v20.json) contains
332 C512 FP8 keys across 931 geometries, of which six have the bounded
real-weight measurement above and 326 remain unmeasured. The previous complete
residual sweep covered its former 3,626-key scope; it does not establish
performance coverage for these newly routed C512 contracts. The general range
timer measures the resident packed residual GEMM; the real-block anchor timer
also includes the projection's half-to-E4 conversion.

## Second: fuse only each 64→256→64 branch

A bounded private candidate can leave W1, W4 and all attention operations as
they are. Its input is packed `[M,8,64]`, with weights `[8,256,64]` and
`[8,64,256]`; output is packed `[M,8,64]`. It eliminates the global packed
`[M,8,256]` hidden tensor while preserving both publications and all arithmetic.
At M=8160, removing one write and one read of that hidden tensor removes
33,423,360 logical bytes per block. This is an ideal traffic count, not an NCU
measurement; extra weight requests can offset it.

One warp owns 16 consecutive rows of one branch. A CTA can group one, two or
four independent warps; no 512-thread block is necessary. For each warp:

```text
load the two K32 input fragments once
initialize eight N8 output fragments (16 half-pair words)
for hidden_chunk in ascending [0, 32, ..., 224]:
    compute 16x32 hidden values using K32 steps 0 then 32
    apply the native cubic half arithmetic and E4 publication
    transform the published C fragments directly into one A fragment
    accumulate its W3 contribution into all 64 output columns
publish the final output to E4 and store the valid rows
```

The hidden C-to-A transform already exists in the tested C32 register helpers.
This branch has ordinary consecutive row indices; it must **not** apply the
shifted-window `natural_token` permutation. The hidden chunk loop gives each
W3 accumulator exactly the original eight ascending K32 instructions. There is
no split-K, intermediate sum, altered cubic rounding or delayed publication.

The register-only form holds eight input words, eight hidden accumulator words,
and 16 output accumulator words per lane, plus weight/address temporaries.
Those are source arrays, not a compiler register promise. It avoids shared
barriers, but loads branch weights for every 16 rows instead of the current
128-row tile. In a simple uncached model, weight requests can grow by up to
eightfold. A smaller intermediate tensor alone therefore does not prove a win.

A second form can share weights across four warps. Stage one hidden stripe:
W2 `[32,64]` with an 80-byte row stride, plus W3 `[64,32]` with a 48-byte row
stride. Two alternating stages use `2*(32*80 + 64*48) = 11,264` shared bytes.
Load the next stripe asynchronously while the current stripe is consumed;
keep input and all half accumulators in registers. This reduces repeated weight
loads across the four row tiles while avoiding a full 256-channel shared hidden
matrix. The extra CTA waits and barriers may erase the gain, so it must be a
separate measured candidate, with carefully reviewed stage reuse.

Before drafting either form, collect the two actual C512 grouped baselines:

```powershell
.venv\Scripts\python.exe run_tuning.py gemm-profile --m 8160 --n 256 --k 64 --batches 8 --precision fp8 --epilogue 2 --layout 3
.venv\Scripts\python.exe run_tuning.py gemm-profile --m 8160 --n 64 --k 256 --batches 8 --precision fp8 --epilogue 3 --layout 3
```

Use their measured request counts, long-scoreboard consumers, tensor activity
and stage waits to choose whether weight sharing is warranted. Reuse the
existing capture/sanitizer/bit-exact checks and compare with the **combined**
two-call baseline. A new fusion has to beat the existing measured route by the
selection margin, not merely save a launch.

## Later: fuse QKV projection with window attention

A larger candidate can assign four heads to a 128-thread CTA, with four CTAs
per window. Each CTA publishes the 64x512 input into a 32 KiB exchange buffer;
each warp computes its own Q/K/V projections and attention with the existing
ordered helpers. It does not retain FFN paths or residual state. This avoids
the 192 KiB raw-half QKV tensor per window and permits a packed attention
output for projection.

The tradeoff is four reads of the shared 512-channel input across head groups,
and long K512 weight chains. Rolled K is essential to test register pressure;
the pair-prefetch results do not justify assuming any universal schedule.
The previous C256 fusion's 255-register spill behavior is a direct warning
against simply expanding it to 16 warps and C512. This candidate should follow
the smaller residual/branch experiments and an exact C512 QKV/attention NCU
baseline. No source activation or performance claim is made here.
