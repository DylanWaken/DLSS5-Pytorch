# Private follow-up experiments for the whole-window fusion

The default whole-window kernel is selected by the measured v16 C++ policy.
The two new template flags, `ROLLED_K` and `COALESCED_STORE`, default to false
and remain private. They do not change production selection. The v17 build
completed, and all 302 new exact-value cases passed in the
[420-case focused run](../outputs/v17-focused-tests.xml). Its compiler resources
and first bounded timings are available below; broader measured policy
selection remains a separate gate.

Fresh unchanged-original comparisons also passed for each of the
[rolled](../outputs/window_experts_native_verification_v17_variant1.json),
[packed-store](../outputs/window_experts_native_verification_v17_variant2.json),
and [combined](../outputs/window_experts_native_verification_v17_variant3.json)
variants: 240 cases and 13,762,560 bytes per variant, across all three channel
widths, four phases, physical views and recorded input patterns. These reports
pin the actual candidate binary; they validate those block scopes, not a full
renderer endpoint or universal arithmetic equivalence.

## Evidence behind the experiments

The profile analysis reads the actual SM120 reports and source-correlated stall
samples. It does not combine other kernels from the extension's SASS dump:

- [C64 profile](../profile/window-experts-fp8-b5-288x480-p1-20261003T020729_047224Z/analysis/full.txt)
- [C256 profile](../profile/window-experts-fp8-b15-136x240-p1-20261003T021019_206640Z/analysis/full.txt)
- [Extracted metrics, opcodes and stall consumers](../outputs/window_experts_v15_profile_analysis.json)

| Measurement | C64, 288 x 480 | C256, 136 x 240 |
|---|---:|---:|
| Cold duration | 57.184 us | 136.704 us |
| Registers/thread | 186 | 255 |
| Achieved occupancy | 16.50% | 16.71% |
| Tensor activity | 29.37% | 38.33% |
| L2 throughput | 12.17% | 66.63% |
| DRAM throughput | 9.33% | 4.05% |
| Scheduler cycles with no eligible warp | 70.73% | 84.28% |
| Register-spill instructions/requests reported | 0 | 205,344 |
| Static instructions | 5,848 | 8,048 |
| Static ordered warp-MMAs | 416 | 1,280 |
| Packed output store width / sector utilization | 2 bytes / 8 of 32 | 2 bytes / 8 of 32 |

C64 is limited by latency and residency rather than DRAM throughput. Its
long-scoreboard samples concentrate at MMA consumers and the first shared store
of loaded input fragments. C256 additionally spills: 23 static `STL` and 23
`LDL.LU` instructions produce 410,688 read sectors and the same number of write
sectors in local memory. These are measured traffic/request counts, not a claim
that all its L2 utilization comes from spills. The profile's selected shared/L1
configuration and register allocation both allow only one C256 CTA per SM.

The C256 SASS directly shows aggressive preloading. Near PCs `0xffa0` through
`0x10130`, it loads many future K offsets and shared A fragments before the
first MMA at `0x10140`; it spills a register at `0x100d0` in that interval.
This supports testing a shorter preload lifetime before trying a different
arithmetic schedule.

## Variant 1: keep the K loop rolled

The baseline fully unrolls `dense32` across `C/32` K groups. The experiment
places `#pragma unroll 1` on this loop and calls an inline one-K32 step. The
M16 and N8 fragment loops inside each step remain unrolled. Each half
accumulator sees the exact same ascending K32 MMA sequence; no products or
partial sums move across a reduction boundary.

The expected benefit is fewer simultaneously live A and weight fragments,
especially at C128/C256. It may remove spills or permit more resident warps.
The cost is loop/address-control instructions and less prefetch overlap, so
C64 may lose despite using fewer registers. Compiler resources, generated SASS,
and matching graph timings must decide separately for each width and contract.

The source-level live arrays explain why scope matters. The FFN expansion can
hold 32 path accumulator registers and 32 hidden accumulator registers while
the compiler preloads future dense operands. During attention, Q/K/V, retained
FFN residuals, and attended fragments coexist. Merely shortening an unrelated
variable's C++ scope does not guarantee a shorter compiler live range.

## Variant 2: transpose packed output pairs before storing

The original epilogue gives each lane a two-channel E4 pair at channels
`8*column + 2*lane_in_group`. Four separate store instructions therefore use
only eight bytes in each 32-byte sector per token group. The candidate reuses
the independently tested C32 four-lane byte transpose:

1. Pack four half accumulator pairs exactly as before.
2. Exchange words with three warp shuffles and two byte permutations per row.
3. Write eight consecutive bytes per lane using `uint2`.

Four lanes now cover a complete 32-byte channel group in one store instruction.
The per-warp epilogue drops from 32 scalar 16-bit stores to eight 64-bit stores.
This changes delivery only; the E4 conversion, channels, pixel ownership and
optional raw half stores are unchanged. Every lane executes the shuffles before
the valid-pixel predicate, so shifted edge windows remain warp-safe.

The extra shuffle/packing work can exceed the saved store cost for a small
window. The earlier C32 result was shape-dependent, so that result is not a
performance guarantee for wider blocks. This variant requires packed output;
half-output requests use variant 1 or the existing baseline.

Variant 3 combines both changes. Keeping the variants independent makes it
possible to distinguish a register-pressure improvement from a store-layout
improvement, and to reject either one when their combination regresses.

## Gates and tools

The private API is `_inference_window_block_experts_variant`, with the same
tensor/phase/output arguments as the existing private fusion plus a final
variant integer. The new launcher mirrors the validated shape/device/type,
four-byte input alignment repair, grid-bound and capture-compatible allocation
checks. It rejects autograd and invalid storage combinations before launch.

The independent CPU review found no defect in the K sequence, shuffle
participation, alignment or raw-output indices. The
[coordinate proof](../outputs/window_variant_layout_cpu.json) checks 36
batch/edge/phase/width cases, 1,177,344 output bytes, disjoint complete writes,
and the original ascending instruction order. This is not a GPU parity result.

- `tests/test_window_block_variants.py`: 302 exact-value, checkpoint,
  storage-offset, graph-replay, immutable-input and invalid-contract cases.
  Older installed binaries explicitly skip these private-API cases.
- `tests/benchmark_window_block_variants.py`: resident baseline whole fusion
  versus variants, identical input/output storage, repeated calls per graph,
  distinct retained outputs and a 256 MiB budget. It does not export policy.
- `tools/window_variant_resources.py`: extract every architecture/storage
  specialization's registers, shared bytes, stack and spill counts from a
  compiler log.
- `tools/analyze_window_expert_profiles.py`: reproduce the existing profile
  analysis and per-symbol SASS extraction without using the GPU.

Before any promotion, run the new exact-value tests and memory/race checks,
compare with unchanged original kernels, inspect compiled resources and SASS,
then measure the required phase/storage/raw-output families. Existing v16
native gates do not automatically validate a newly compiled variant.

## Initial v17 results

The [resource report](../outputs/window_variants_v17_resources.json) confirms
that rolling K shortens live ranges. For packed input/output without raw output,
C64/C128/C256 use 162/160/168 registers instead of 186/248/255. C256's 92-byte
spill stores and loads disappear. Combining the store transpose uses
162/164/168 registers. These are compiler results, not universal speed gains.

The first [matching-I/O timing run](../outputs/window_variants_packed_v17.json)
used phase 1, packed input/output and no raw side output. Its combined variant
improves the 192 x 336 C64 case by 1.398x and the 272 x 480 C128 case by 1.123x.
It regresses the 144 x 240 C128 case to 0.824x, and the 136 x 240 C256 case is
approximately unchanged at 0.996x. Thus neither a register reduction nor a
more coalesced store alone justifies device-wide selection.

C256 still fits only one 256-thread CTA per SM at 168 registers, so removing
spills does not itself create another resident CTA. The rolled loop also
forgoes the original preload overlap. The next experiment prefetches only
two K groups at a time to balance these costs. It now has isolated source and
tests, compiled privately in v19. Its 111 tests passed with memory checking;
the bounded timing results below do not justify policy selection.

## Next C256 hypothesis: bounded two-step weight prefetch

The first experiment preloads the two B fragments for `kk` and `kk+1`,
then consumes them in that order. The outer pair loop uses `#pragma unroll 1`;
the two steps and their four M16/four N8 fragment loops remain unrolled. A loads stay
inside each M16 tile rather than retaining all four A tiles for both K steps.
Conceptually:

```text
for pair in [0, 2, 4, 6]:        # rolled loop for C256
    B0 = load_four_N8_weights(pair)
    B1 = load_four_N8_weights(pair + 1)
    for step in [0, 1]:         # unrolled, exact ascending K32 order
        for m in [0, 1, 2, 3]:
            A = load_one_M16_fragment(exchange, pair + step, m)
            for col in [0, 1, 2, 3]:
                out[m][col] = MMA(A, B[step][col], out[m][col])
```

This preserves even the current global MMA instruction sequence, in addition
to the required per-accumulator K order. It changes only the point at which
weights become available. Sixteen B words are live per lane instead of eight
in the one-step source, an increase of eight words before compiler allocation.
The streamed A fragment needs four words. Loading every A tile for both steps
would instead retain 32 A words and undermine the intended lifetime bound.
These source-array counts do not predict the final register count: scheduling,
inlining, address state and surrounding accumulators also matter.

There are no new shared arrays, barriers, publications or partial reductions.
Both K steps read the same immutable `Exchange` epoch; prefetch must remain
inside `dense32`, never cross its surrounding barrier into an epoch overwrite.
C64/C128/C256 contain 2/4/8 K32 steps, so pair iteration requires no tail for the
current supported widths. The independent source review agreed that this
schedule preserves arithmetic and barrier requirements. It is not a GPU result.

The motivation has two parts: overlap some global weight latency with work on
the first K32 step, and halve the rolled loop's control iterations. Removing
spills alone did not improve the large C256 case, and 168 registers still
allow only one 256-thread CTA per SM on this device. A modest register increase
therefore may be worthwhile if it recovers overlap without reintroducing spills.
It is also possible that the compiler already pipelines the rolled loop well
enough, or that the remaining delays are elsewhere; no speedup is assumed.

Before a runtime experiment, inspect the exact new SM120 SASS for a bounded
load-to-use distance, register count, local-memory instructions and loop control.
Confirm the second B load precedes the first step's MMA and that the compiler
has not hoisted all eight K steps again. Measure first against both variants 0
and 1 with identical packed/raw output contracts, then against the fastest
measured existing implementation. Exact-value, offset, capture, sanitizer and
fresh original-kernel gates still apply. A separate coalesced-store combination
should come only after isolating the pair-prefetch effect.

The implementation is generated by
[draft_window_pair_prefetch.py](../tools/draft_window_pair_prefetch.py), which
checks each source replacement and writes only `.draft` files. The kernel has
its own namespace and includes the unchanged publication/fragment helpers.
Its private launcher instantiates only the baseline output store layout, and
the private `_inference_window_block_pair_prefetch` API mirrors the established
half/packed input, half/packed output and optional raw-half output contract.
The production kernels, dispatcher and policy remain untouched by this experiment.
The reviewed drafts were copied to active files and compiled in v19:

- [Kernel](../csrc/kernel_impl/window_block_pair_prefetch.cuh)
- [Launcher](../csrc/kernel_launcher/window_block_pair_prefetch.cu)
- [Torch API](../csrc/torch_api/window_block_pair_prefetch.cpp)
- [111 GPU test cases](../tests/test_window_pair_prefetch.py), passed in the
  [288-case v19 run](../outputs/v19-new-kernels-tests.xml) and again in the
  [288-case memory-checking run](../outputs/v19-new-kernels-memcheck.xml)
- [Matching-I/O benchmark](../tests/benchmark_window_pair_prefetch.py), which
  reports comparisons with the baseline, rolled loop, and fastest eligible
  existing whole-window variant

The [independent CPU coordinate proof](../outputs/window_pair_prefetch_cpu.json)
enumerates all lanes and row groups in the W1, W3, QKV and output projection
families at C64/C128/C256. It compares 193,536 weight words, 387,072 per-lane
MMA events and 96,768 aligned shared-fragment reads. Every matrix byte is read
exactly once per dense projection tile's B distribution, with no out-of-bounds
or misaligned word address, and every accumulator retains ascending K32 order.
All seven block barriers are unchanged. The source-level maximum is 16 B words
and four streamed A words per lane; the compiler may schedule them differently.
Independent source review found no blocker. These are CPU results only;
the subsequent GPU and timing evidence is recorded separately below.

### What the v19 compiler actually emitted

The [compiler/SASS analysis](../outputs/window_pair_prefetch_v19_analysis.json)
pins the v19 binary SHA256 beginning `d28b19f8cb15`. It contains all 144 compiler
resource rows plus the 15 exact SM120 packed-input/output, no-raw symbols used
for the baseline, rolled loop, store transpose, combined and pair-prefetch
comparisons. The extraction uses
[analyze_window_pair_prefetch.py](../tools/analyze_window_pair_prefetch.py)
and `cuobjdump`; it creates no GPU context.
SM80/86 compiler entries are empty architecture-guarded stubs; the launcher
requires SM89 or newer for FP8. SM90 has spills in eight storage specializations,
so the SM120 observations below must not be generalized to other GPUs.

| Channels | Baseline registers | Rolled registers | Pair-prefetch registers | Pair spill loads/stores |
|---|---:|---:|---:|---:|
| 64 | 186 | 162 | 206 | 0 / 0 bytes |
| 128 | 248 | 160 | 168 | 0 / 0 bytes |
| 256 | 255 | 168 | 170 | 0 / 0 bytes |

The C256 [pair-prefetch SASS](../outputs/window_pair_prefetch_v19_analysis_sass/c256_paired.sass.txt)
contains nine backward dense-loop branches. Each loop body has 16 weight word
loads and 32 QMMA instructions, compared with eight loads and 16 QMMA in the
one-step rolled variant. In the first loop, PCs `0x16d0` through `0x17c0` load
both B fragments into R92–R107 before the first QMMA at `0x1870`. The compiler
therefore retained the intended bounded pair loop instead of preloading all
eight K32 groups. Its 416 static QMMAs are instructions in rolled loop bodies,
not a reduction in the dynamic arithmetic; the baseline has 1,280 static QMMAs.

The compiler also moves four A-fragment loads before that first QMMA, retaining
16 A words at that point. The source-level four-word temporary is not a bound
on the compiler's actual register lifetime. Independent accumulator instructions
can also be interleaved differently by scheduling, so the CPU source-order proof
does not claim identical SASS instruction order. The required per-accumulator
K order and exact results must still pass the CUDA gates.

At C64 the pair loop has only one iteration and disappears. Its 206 registers
exceed both previous implementations; this could lose occupancy or latency.
C128/C256 remain spill-free with a modest register increase over the rolled
variant. These compiler observations establish that the experiment exists as
intended; resident graph timings must determine whether any shape benefits.

### Measured result: keep pair-prefetch private

All 111 pair-prefetch tests passed in v19, including the CUDA-graph mutation,
unaligned-view, exact-byte, independent-composition and checkpoint cases. The
same cases passed memory checking with zero errors in the combined 288-test
run. The [resident graph benchmark](../outputs/window_pair_prefetch_v19.json)
then tested nine phase-1, packed-input/output, no-raw contracts. Every path
retained identical input/output storage, distinct captured outputs, and the
same per-case output budget. All exact-output and input-immutability checks
passed. The table compares medians from seven samples:

| C | H x W | Pair prefetch | Selected public | Fastest existing route | Speedup vs fastest |
|---|---|---:|---:|---|---:|
| 64 | 192 x 336 | 24.138 us | 17.933 us | Combined, 17.894 us | 0.741x |
| 64 | 288 x 480 | 39.834 us | 41.043 us | Combined, 39.752 us | 0.998x |
| 64 | 544 x 960 | 135.440 us | 129.924 us | Combined, 129.672 us | 0.957x |
| 128 | 96 x 168 | 24.310 us | 23.077 us | Packed stores, 22.906 us | 0.942x |
| 128 | 144 x 240 | 42.565 us | 40.102 us | Packed stores, 39.000 us | 0.916x |
| 128 | 272 x 480 | 112.784 us | 104.254 us | Selected public, 104.254 us | 0.924x |
| 256 | 48 x 84 | 29.312 us | 29.803 us | Combined, 29.794 us | 1.016x |
| 256 | 72 x 120 | 38.198 us | 39.619 us | Combined, 37.979 us | 0.994x |
| 256 | 136 x 240 | 116.125 us | 118.474 us | Packed stores, 113.726 us | 0.979x |

The only win over the fastest existing route is 1.64%, below the 3% selection
margin. Comparing only with the selected public route would overstate the
case: at C256 72 x 120, pair prefetch beats public by 3.72% but loses to an
already available combined variant. These modest gaps may also depend on
clocks and sample order; they are not proof that an existing policy should be
overwritten from one timing pass.

The bounded prefetch hypothesis succeeded at controlling compiler lifetimes,
but did not produce a material speed improvement over existing choices. Pair
prefetch therefore remains private. A broad resolution sweep or a new original
kernel gate would spend GPU time without a candidate that currently clears the
performance margin. No native-DLL or 85%-roofline claim follows from this result.

## Next hypothesis: fuse the first input projection

The model accepts FP32 BHWC16 features. Block 0 first projects them with a
half `[32,16]` matrix, publishes the result to E4, and passes the unrounded-to-E4
half result as its FFN residual. These are two distinct values and must remain
distinct inside a fusion.

An input provider for the register C32 core could load Float2 values, round them
directly to Half2, form the four FP16 A registers, and issue four N8/K16 MMAs
per M16 tile. It would retain the raw half result for the FFN seed and use the
existing rotated C-to-A publication for FP8 input. There is only one K16 step,
so no adapter reduction order needs to change. Sixteen additional warp-MMAs
cover the entire 64-token window.

This can eliminate the temporary half features, raw adapter projection and
published adapter input: approximately 256 bytes of write/read traffic per
pixel in the currently composed route. It must still retain block 0's
**published output** for post70; that long-lived tensor is not the initial
16-to-32 projection. Block 0's raw output still feeds the first pool. Fusing
that pool is a separate possibility because all phase shifts are even, but
the first experiment should preserve the existing `(published, raw)` contract.
The input fusion was validated and measured privately in v19, then integrated
into the v20 public graph. Across 32 local contracts it gains 1.887–3.027×; its
4K NCU profile reaches 81.21% DRAM, still below 85%. See
[the design and validation notes](block0-adapter-draft.md) and
[the walkthrough](optimization_walkthrough.md) for native-proof scope and
complete-network measurements. A separate adapter-plus-pool draft now explores
omitting the full raw intermediate; it has no GPU performance result yet.
