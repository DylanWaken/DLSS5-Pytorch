# Original DLSS-NR compute flow versus our CUDA implementation

This audit confirms substantial differences in **how data reaches the tensor
cores and moves between matrix operations**, even where the learned arithmetic
matches the tested native outputs. The clearest costs are fragment rearrangement
in wide windows, intermediate QKV tensors, separate ordered reducers, and layout
adapters between our BHWC API and NVIDIA's packed states.

The DLL-speed goal is still open. The latest balanced FP8 trunk measurements
on the installed encoder build take 1.366×, 1.555× and 1.429× native latency
at exact 720p, 1080p and 4K valid sizes. The encoder's separate same-binary
shared-field comparison reduces latency by 2.53%. This
document explains what the original kernels do, what our active implementation
does, and which changes the evidence supports. It does not claim that an
instruction-count reduction is a speedup.

## Evidence and scope

The reference is the actual DLL 310.8.0, SHA-256
`e16bcf15e16e13f527491cdf7845b2fe6521a738d8f7c9c721866a8496e1fc8e`.
We inspect its decompressed **original PTX**, original cubins and compiled SASS.
Our generated PTX is kept separate. The initial audit snapshot was v35, extension
SHA-256 `44905141c7f400547e7cf44b9a45ca8852dc79af4565f6b5b6f12187bf6d2166`.
Source, policies and that binary remained frozen during that initial audit and
the concurrent ordinary-GEMM scan.

After that scan closed, v36 was installed with the measured ordinary-GEMM policy
and reviewed private candidates. Its binary is
`3bccf2639dfe799bc1d32dcbd8043ff3b50ee0924c2a01e811c76901fa69dca9`.
The historical audit pins remain v35 evidence. The all-architecture comparison
and runtime validation below record this later integration separately.

The subsequent C512 policy integration used binary
`617e0bfa8bcb3075ba04b82fc4637b59eda0dcf31c5af046d66e0a1127d792af`,
C512 policy `40557fe031d98701`, and ordinary policy `19c64573272a45c8`.
Its [validation closure](../outputs/c512-policy-build-plan/activation-draft/validation-complete-after-native3.json)
records passing functional checks and failing native speed gates separately.
The original per-kernel audit snapshots remain historical evidence; this
integration changes the C512 cache, dispatch and model preparation described below.

The preceding installed decoder-fusion binary was
`6378602b5f55236889701fa353ad8e6eaf2150292b9b9376e2664fa799a41667`.
It retains those two policies and adds decoder policy `217be58b13099077`, selecting
the qualified affine-store block66 fusion at the measured 4K padded field.
[Installation](../outputs/c32-decoder-transition-integration/affine-store-v2/activation/run-activate-v1/receipt.json.draft)
and [42 post-install tests plus eight subtests](../outputs/c32-decoder-transition-postinstall/run-v2/job-receipt.json)
are complete. Fresh exact-valid native comparisons are in the timing table below.

The current installed binary is
`c2d47cbe449495cfb544d763285775808e13cdf03ce6ecb768780dcd9e6e9e3f`,
adding encoder policy `141b6e8049c51a68` while retaining all three earlier
policies. The [installation closure](../outputs/c32-encoder-transition-native-publication-final-policy/activation/validation-complete.json)
records 55 passing post-install tests and eight subtests. Qualification checks
all 74 exact-valid 4K native boundaries; its balanced selected/composed shared-field
comparison improves 9.433189 to 9.194939 ms. Final policy relinking retains the
qualified CUDA instructions and changes only metadata. The subsequent
[fresh balanced three-size comparison](../outputs/c32-encoder-transition-native3/run-balanced-v2/receipt.json)
passes numerical checks at every size but fails both orders' native speed gates.

The [current 4K trace](../profile/trunk-nsys-encoder-id4-4k-private/analysis/kernel-attribution-v2.json)
attributes 185 native and 268 candidate kernels per replay, with four candidate
D2D copies. Median activity sums are 6.039/8.808 ms. Both selected C32
transitions are now single kernels: block 4 measures 129.697/150.018 µs and
block 66 measures 120.610/137.377 µs, native/candidate. The largest remaining
equivalent span difference is block 8 plus downsampling, at
99.393/229.315 µs. This identifies the next matched counter and original-PTX
audit target; it does not establish the cause of the entire difference.
All 30 submissions are mapped and every sample is retained. These are
sequential profiled diagnostics, not balanced speed acceptance.

The preceding [decoder-only trace](../profile/trunk-nsys-decoder-4k-private/analysis/kernel-attribution-v2.json)
had 272 candidate kernels and five D2D copies. Its block-4 span of
129.409/401.252 µs motivated the installed encoder fusion. The following
older trace remains historical evidence of the earlier decomposition.

The earlier [4K Nsight Systems comparison](../profile/trunk-nsys-v36-4k-owned/REPORT-v2.md)
attributes all 185 native and 275 candidate CUDA kernels per replay, plus
five candidate D2D copies. Across 15 replays per path, median kernel sums are
6.020 ms native and 9.426 ms candidate; including copies gives 6.020/9.445 ms.
The largest equivalent spans are decoder upsample/block 66 (120.513/521.189 µs)
and encoder block/downsample 4 (128.801/403.715 µs). The latter includes the
captured pool-output copy. This is historical per-node diagnostic evidence, with
fusion and adapters included in equivalent comparisons. It is sequential,
profiled timing, not a new clean speed qualification or full-DLL host trace.

The [NCU coverage inventory](../outputs/native-kernel-profile-inventory-v36/REPORT.md.draft)
independently rereads the saved reports and identifies only three distinct
original FP8 entries. Earlier original/custom reports do not establish a
strict same-fixture pair for every family. A new
[matched C256 collection](../profile/c256-matched-trunk-block16-v36-v2/receipt.json)
now passes all four original/current full/source workers with identical
input, output, weight, layout-map and scalar-ABI evidence. Original/current
cold-replay durations are 127.936/141.600 µs, elapsed tensor activity
64.65/57.02%, L2 data throughput 19.19/17.40%, and DRAM throughput 4.27/3.78%.
This closes the paired-counter gap for actual block 16 at its 4K trunk field,
not for the other families. The [fresh source-counter analysis](../profile/c256-matched-trunk-block16-v36-v2/REPORT.md)
finds equal executed QMMA counts, but 41.293 million total warp instructions
in the public kernel versus 20.037 million in the original. Both allocate
168 registers per thread and remain at one CTA per SM. The actual public
B-prefetch survives across 16 MMAs; its carry moves and extra supporting
instructions are measurable targets, not evidence that prefetch was removed.
The execution algorithms, layouts and schedules are not
identical to NVIDIA's; tested numerical boundaries do not prove that claim.

The [fresh C32 block66 profile](../profile/c32-up66-matched-v36/REPORT.md)
adds original upsample-entry evidence on the actual preceding-block inputs.
The public consumer alone takes 315.488 µs in its full-counter replay, while
the original fused projection/upsample/merge/consumer takes 183.392 µs.
These are unequal scopes, so their difference is not a measured fusion gain.
Our initial packed-input joins and raw-residual seeds account for 82.43% of
long-scoreboard samples before the first QMMA. Memory counters also show
18.86 useful load bytes and eight store bytes per sector, compared with
31.59 and 32 in the original. Both remain below the 85% gate. The existing
private input-vector operator leaves the separately loaded raw residual and
output path intact. Its [clean matched timing](../outputs/c32-input-vector-matched-plan/results-review/REPORT.md)
now reduces the consumer median from 237.840 to 208.576 µs, with all six
execution orders passing the 3% screen and all published bytes matching.
The original complete transition measures 120.320 µs in that run. This is a
bounded consumer improvement; fresh counters and wider shape measurements
are still needed before public dispatch changes.

The [C256 direct-publication resident comparison](../outputs/c256-native-publication-matched-plan/PAIRED-RESULT-v2.md.draft)
measures 77.600 µs for rolling, 76.064 µs for the private publication change,
and 74.208 µs for the original. The small improvement fails the conservative
3% screen across all six execution orders and does not establish parity.
Its separate exceptional-value qualification is retained; the speed result
does not replace that numerical evidence.

The asset inventory finds **223 network entry points in seven modules**, plus
**eight utility entry points** in eight additional bundles. Every bundle has
both PTX and ELF code; all recovered cubins target SM120, and the original PTX
is version 9.4. This is not native-binary coverage for RTX30/40. Our separate
architecture builds and tests must establish those deployment targets.

Inventory is different from dataflow verification. The guarded FP8 trunk replay
selects 36 original symbols. This audit traces the principal operator families
and their selected arithmetic/packing paths. Alternate wait/chained/tile-sync,
control-mask, renderer and utility paths are not all independently traced.
Per-entry evidence and remaining gaps are retained alongside the reports below.
Of the 36 selected trunk entries, this first pass has 15 entry-specific compute
discussions, 19 family-level discussions whose wrappers still need individual
tracing, and two layout helpers awaiting a direct native comparison. These
categories are not complete equivalence proofs. The [frozen first-pass report](../outputs/native-compute-flow-audit/first-pass-human-report.md)
preserves those historical counts. The subsequent chained-attention/repack and
transformer-view addenda below extend that evidence. Transition-wrapper tracing
is continuing separately.

| Detailed audit | What it contains |
|---|---|
| [Transformer and fragment flow](../outputs/native-compute-flow-audit/transformer/SOURCE_AUDIT.md.draft) | C32/C64/C128/C256/C512; original entry names, exact source anchors, P packing, QK/PV permutations, residual domains, barriers and active dispatch |
| [GEMM and global attention](../outputs/native-compute-flow-audit/gemm-and-conv/REPORT.md.draft) | FP8/Half instruction contracts, grouped matrices, split-K ordering, QKV normalization, global exponent/PV flow and padding correction |
| [Endpoints and spatial operations](../outputs/native-compute-flow-audit/endpoints/REPORT.md) | pre0, post70, publication, pool, upsample/skip, physical layouts and renderer boundary gaps |
| [Original network inventory](../outputs/native-compute-flow-audit/provenance-child.json.draft) | Original payload hashes, symbols, PTX/ELF/SASS correspondence |
| [Original utility inventory](../outputs/native-compute-flow-audit/provenance-utilities.txt.draft) | Eight exact utility symbols and explicit untraced host roles |
| [Selected graph mapping](../outputs/native-compute-flow-audit/provenance-mapping.json.draft) | Numbered graph entries and the original symbols selected by our guarded replay |
| [Per-entry coverage and gaps](../outputs/native-compute-flow-audit/provenance-coverage.md.draft) | All 36 selected trunk symbols, with compute-family, exact-wrapper/ABI and runtime evidence kept separate |
| [Chained global attention and FP8 repacks](../outputs/native-compute-flow-audit/global-chained-repack/REPORT.md.draft) | Exact chained-versus-plain arithmetic comparison, counter protocol, and both native repack address maps across all 83 global fields |
| [Transformer view and transition wrappers](../outputs/native-compute-flow-audit/transformer-wrappers/REPORT.md.draft) | Eight FP8 view wrappers compared with four ordinary controls, bounded global/shared address traces, added projection weights and selected pool/upsample source clauses |
| [C32 exact-half downsample](../outputs/native-compute-flow-audit/c32-downsample-exact-half/REPORT.md.draft) | Raw Half pool trees, lane-dependent operand order, published A fragments, K32-to-N64 matrix bytes, and both output address maps |
| [C64 exact-half downsample](../outputs/native-compute-flow-audit/c64-downsample-exact-half/REPORT.md.draft) | Shared pool publication and barrier epochs, both ordered K32 steps, original K64-to-N128 weights, and both output address maps |
| [C256 weight-load scheduling](../profile/c256-b-load-schedule-v36-cpu/REPORT.md.draft) | Original and current SASS producer/consumer chains, stage-specific prefetch depth, accumulator order and measured stall sites |
| [Block 30's 512-to-1024 adapter](../outputs/native-compute-flow-audit/head512-entry/REPORT.md.draft) | Three-stage A buffering, register-fed B, all selected accumulator chains, recovered matrix bytes, direct publication and original SASS |
| [C256 publication contract](../outputs/native-compute-flow-audit/c256-publication-contract/REPORT.md.draft) | All 324 static original FP8 conversions, corresponding active helpers and the unresolved NaN propagation difference |
| [Current transition trace and original PTX/SASS](../outputs/trunk-nsys-v36-transition-audit/REPORT.md.draft) | Exact measured components at spans 4/8/62/66, fused Half residual/pooling flow, matrix operands, physical layouts and copies; hardware causes remain for matched NCU |

The view-wrapper follow-up matches complete ordered MMA, conversion and shuffle
operands under typed register renaming for C32/C64/C128/C256. A separate original
integer-PTX interpreter checked 144 cases across three fields and four phases,
including shared-memory epochs, bounds and exactly one writer per output byte.
It covered 97,920 thread traces and 3,962,880 input/output bytes. All eight added
transition matrices also match 348,160 original bytes. This is bounded view
coverage; it does not prove every transition branch or connect every address
tag to a numerical MMA operand. In particular, padded C32 downsample remains
rejected by the native helper, and the wider padded clear path needs its larger
guarded allocation. Those limitations remain explicit in the detailed report.

The C32 downsample addendum follows the actual values across the transition:
raw Half projection results feed ordered 2×2 pooling, the pool is converted to
E4M3, and a single K32-to-N64 contraction produces the lower-resolution output.
Four symbolic interior traces connect the raw values to all A/B operands and
output stores. A separate whole-field address trace covers twelve exact-half
cases, 7,008 threads and both outputs. Lane bits swap the two horizontal
operands and the two row sums; that matters when discussing arbitrary NaN
payloads. These bounded CPU proofs neither validate padded C32 targets nor
establish numerical or synchronization equivalence for wider transitions.

The separate C64 proof checks that wider transition directly. Its two warps
publish 1,024 pooled FP8 bytes to shared memory, cross a CTA barrier, then each
read both channel halves for the ordered K64 projection. Twelve whole-field
address cases cover 14,016 threads and both outputs; four interior symbolic
traces follow all 8,192 added weight bytes and the accumulator chain. These
source checks retain the original barrier sequence and do not justify removing
barriers or admitting padded targets. The root review independently reran the
16 CPU tests, while the complete twelve-case enumeration remains owner evidence.

The block-30 adapter addendum follows the original `final_head_512` entry,
which projects 512 channels to 1,024 at the global bottleneck. It checks the
complete selected MMA operand lists, sixteen ascending K32 steps from zero,
and direct FP8 publication. Repacking restores all 524,288 original matrix
bytes. A separate review enumerates the B-load coordinates and rejects
additional accumulator-clobber and loop-order mutations. Original SASS retains
32 static E4M3/Half tensor sites and 32 register publication sites, with no
Half NaN-test sites. These are source and static executable facts; neither
the three-buffer asynchronous protocol nor arbitrary spatial-tail behavior
is fully proved. Our current ordinary matrix route still materializes a Half
result before a separate packing kernel. The [independent review](../outputs/native-compute-flow-audit/head512-entry/INDEPENDENT-REVIEW.md.draft)
records nine CPU tests in both normal and optimized Python and the remaining
limits.

The chained global entry preserves 490 ordered arithmetic/conversion/MMA
instructions under a consistent typed register renaming. Its added producer
waits, shared-memory reuse barrier and completion stores are separate from that
arithmetic equivalence. The two selected FP8 repacks pass literal integer-PTX
address/data-tag execution across 166 direction/field cases: 42,369,024 dword
threads, including forward tail zeroing and reverse padding exclusion. These
are CPU source/address proofs, not new GPU timing or general Half proofs.

Our native replay issues ordinary `cuLaunchKernel` calls on one supplied stream;
its captured stages are sequential. It does not set programmatic dependent
launch attributes or graph dependencies. Consequently, replaying unchanged
cubins does not reproduce the DLL host schedule, and counter instructions alone
do not prove host overlap. The full DLL scheduling and timing comparison remains
open. The separate plain global-attention path also retains its recorded
large-field race limitation; chained evidence does not retroactively validate it.

The graph contains pointwise learned matrices, a cubic activation, residuals,
window/global attention, box pooling and nearest-neighbor upsampling. It does
not contain spatial convolutions, layer normalization, GELU or expert-routing
gates. Native names containing `Conv1d1x1Layer` describe a matrix applied to each
token. All branches execute.

## One view of the complete learned computation

| Graph region | Original computation | Our active path and material difference |
|---|---|---|
| Entry 0 | Texture/feature prefix → Half 16→32 adapter → C32 block; downsample entry also pools raw results | Public model consumes prepared 16-lane features; learned adapter/block/pool can fuse. Renderer feature generation remains external. |
| C32, 1–4 and 66–69 | One-warp FFN → local attention → projection; native fragment packing remains in registers | Selected rotated register path closely follows this flow; fallback schedules remain. The final projection seeds from **raw Half FFN**. |
| C64/C128/C256, 5–22 and 48–65 | C/32 dense branches → mixing matrix → local attention → projection; native packed state exchanged between heads | Fused FP8 expert kernels preserve the graph, but wide caches retain canonical K coordinates and add cross-lane fragment rearrangement. Their final projection seeds from **published FFN**. Decoder projection/merge remains outside the fused block. |
| C512, 23–30 and 40–47 | Four main stages: branched FFN, FFN projection, fused QKV/attention, attention projection | Prepared blocks now select fused QKV/attention from a dual weight cache. Guarded or unsupported contracts retain the separate path. Paired whole-trunk timing shows regressions at the two smaller tested fields; native staging still differs and the policy needs revision. |
| C1024, 31–38 | Five stages: expansion, ordered contraction, fused QKV/norm/publication, global attention, ordered projection | Same mathematical split boundaries; current route adds raw Half QKV plus preparation and can use separate partial-sum reduction kernels. |
| Entry 39 | Ordered 1024→512 projection → upsample/scaled skip | Ordered matrix and merge composition; rounding order must survive any future fusion. |
| Encoder/decoder transitions | Raw Half pool or projection/upsample/skip integrated with adjacent native kernels | Some boundaries fuse; others materialize raw/published tensors and invoke separate operators. Pooling published FP8 instead of raw Half would be wrong. |
| Entry 70 | Two-scale merge → C32 block → Half 32→4 head → output/temporal compositor | Prepared inference produces the four learned head channels. Private native-layout surface probe covers raw RGB/alpha0, not the full compositor. |

FP32/BF16 training intentionally uses a separate differentiable arithmetic
contract and reuses PyTorch operations. It should not inherit every quantized
publication or native execution schedule. This audit targets deployment.

## Tensor-core arithmetic that cannot be changed casually

FP8 uses `mma.sync.aligned.m16n8k32.row.col.f16.e4m3.e4m3.f16`.
Half uses `mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16`.
Both have Half accumulator/result fragments at each instruction boundary.
For E4M3, NVIDIA specifies at least single-precision **internal** accumulation;
Half-input MMA with Half C/D only promises at least Half precision. Internal
summation order is unspecified. Preserving the instruction and its Half result
boundary matters; ordinary FP32 GEMM followed by one cast is not an equivalent
substitute. See [NVIDIA's MMA semantics](https://docs.nvidia.com/cuda/archive/12.8.0/parallel-thread-execution/index.html#warp-level-matrix-instructions-mma).

The residual is a seed before the first matrix instruction. Global contraction
uses four K1024 partitions, QKV uses two K512 partitions, and global projection
and entry39 use four K256 partitions. Only partition zero receives the residual
seed. Half partials are combined in ascending partition order. Combining them
with an arbitrary reduction tree changes the function.

The activation is a Half-rounded cubic approximation to SiLU. Q/K normalization
uses a specific Half sum tree and norm floor. Window attention seeds QK with
the prior, evaluates the bit-transform exponential, sums in physical key order,
normalizes and publishes probability **before PV**. Global attention instead
publishes **unnormalized exponent mass** for PV, subtracts the padded-key
denominator correction, then normalizes the final value accumulator. Neither
path can be replaced by generic softmax without changing the network.

Compiled SASS takes precedence over a literal PTX interpretation of contraction.
The original norm's separate-looking Half square/add PTX becomes HMUL2 plus
HFMA2. Our true-Half-FMA helper follows that executable tree. An earlier
PTX-only contrary hypothesis was rejected before activation; the
[register trace and bounded test](native-fp16-arithmetic-audit.md.draft) retain
the evidence.

## The packing difference is concrete

For `lane = 4*g+t`, the canonical A fragment holds channels
`16*h + 4*t + byte`. A C fragment instead holds neighboring output-channel pairs.
Our canonical `c_to_a` conversion therefore needs indexed shuffles and a byte
permutation after publishing the Half results.

NVIDIA arranges matching operands around the within-K16 permutation:

```
P = [0, 1, 8, 9, 2, 3, 10, 11, 4, 5, 12, 13, 6, 7, 14, 15]
```

This permits direct pair joins into the next A fragment. The weights and the
PV value transpose must use the corresponding coordinates. Removing only our
shuffles would compute the wrong matrix product.

The audit decoded and repacked **12,386,304 original weight bytes** across 44
ordinary C32–C256 blocks and 212 matrix roles. The P-packed representation
restores every original byte; the canonical representation does not. Active
C32 already supports this layout. Active wide-window vector caches preserve
canonical K order. The private C256 rotation changes input fragments, all five
weight roles, intermediate publication and PV transpose together.

That byte proof establishes coordinates. It is not a theorem that every
floating-point reduction permits this permutation. Instruction boundaries,
reduction trees, exceptional values and cross-device results still need their
own checks.

The measured C256 instruction gap shows why this matters:

| Issued warp instructions, B1/C256/136×240/phase1 | Active rolling path | Original kernel |
|---|---:|---:|
| FP8 tensor instructions | 5,713,920 | 5,713,920 |
| Total instructions | 41,293,056 | 20,037,072 |
| Indexed shuffles | 1,928,448 | 71,424 |
| Byte permutations | 1,857,024 | 321,264 |
| Half NaN checks | 1,857,024 | 0 |

These are existing dynamic SourceCounters tied to matching v35 SASS, not new
measurements from this source audit. The physical I/O layouts differ. Fewer
instructions do not predict proportional latency: dependencies, register
pressure, uniform-register work and compiler scheduling all matter. The
[complete instruction accounting](../profile/c256-instruction-gap-v35-cpu/REPORT.md.draft)
includes those qualifications and all opcodes.

## What the source audit flags

| Finding | Consequence | Required action |
|---|---|---|
| Wide canonical fragments repeatedly rebuild A operands | Extra shuffles, permutations and live registers surround the same tensor work | Evaluate coordinated P packing across the complete fused block; retain numerical gates. |
| Native C512 uses bulk-copy/mbarrier staging; the integrated policy now selects our fused QKV/attention | Fusion removes a raw QKV boundary, but paired network timing regresses at M=1,056 and M=2,160 | Trace the actual kernels in network context and revise the policy; isolated local wins are insufficient. |
| Global QKV projection and preparation are separate | Raw Half QKV is written and reread before attention | Fuse projection, normalization and publication while preserving split/tail semantics. |
| Parallel ordered GEMM can launch a separate reducer | Partial tensors and launch overhead | Fuse only with a proven ordered completion protocol; do not introduce unordered atomics. |
| Native packed state and BHWC boundaries differ | Explicit format adapters consume bandwidth | Keep a compatible internal layout across adjacent producers/consumers; measure both ends together. |
| Several publication helpers clear NaNs; native conversion and some candidate probability helpers are direct | Arbitrary-domain equivalence is not established | Keep the finite-checkpoint certificate separate from the public operator contract. |
| Scalar FP8 decode clears NaN byte codes, while direct vector intrinsics preserve NaNs | Public arbitrary-uint8 inputs have inconsistent exceptional-value semantics | Define and enforce a consistent finite-byte or general-byte contract. |
| Public features/head interfaces exclude renderer work | Learned-network parity does not establish complete NGX/DLL behavior | Audit preprocessing, history sampling, controls and compositor separately. |

Candidate numerical kernels remain isolated until their own checks pass.
Completed scans retain their frozen source and binary identities; the C512
integration has separate build, activation and validation receipts.

## Experiments already constrain the next move

Direct pair joining looked attractive in a minimal compiler experiment, but
the first full-block build failed exact output comparison. Selective source
control and a newer compiler produced correct candidates; neither passed the
six-field performance screen. Their lower instruction or register counts were
not enough.

The coordinated C256 rotation passed its bounded arithmetic, phase/storage and
memcheck tests. Its six-field gains are modest, roughly 1–4.6% against the
installed rolling path, and do not support blanket promotion. The 128-register
cap likewise passed bounded correctness/memcheck but failed the six-field
latency screen under both requested shared-memory settings. A theoretical
occupancy increase is not measured residency or speed.

The finite-input C256 candidate removes 416 Half-NaN checks and 416 associated
mask instructions from the static compiled body while preserving the tensor
loops. It has CPU proof and isolated compiler evidence only; runtime correctness,
latency and profile gates remain open. Its certificate is tied to exact immutable
weights/scales and finite E4M3 input. No public dispatch currently applies it.

Fresh matched NCU profiles of the C256 rotation and its control measured
138.688 versus 142.752 microseconds with cache flushing and base clocks. Tensor
activity rose from 56.789% to 58.415%; elapsed L2 data throughput was 17.779%
and DRAM throughput 3.854% for the candidate. Registers fell from 162 to 159,
but both still admitted one CTA per SM with a 32 KiB actual shared-memory
configuration. Removing instructions did not resolve the residency limit or
reach the 85% gate. These are cold isolated profiles, separate from resident
graph timing and the older native comparison. See the saved
[control metrics](../profile/c256-driver-rotated-control-default-b15-136x240-p1-20261003T183621_025125Z/analysis/full_metrics.json)
and [candidate metrics](../profile/c256-driver-rotated-candidate-default-b15-136x240-p1-20261003T183829_283757Z/analysis/full_metrics.json).
The [matched profile report](../profile/c256-driver-rotated-comparison-cpu-20261004/REPORT.md)
maps the dominant stalls to exact SASS consumers and explains why instantaneous
90% PM peaks and NCU's generic partial-wave estimate do not pass the elapsed
resource gate or establish a large tail problem.

These results favor targeted, end-to-end changes over mechanical instruction
deletion. Publication dependency stalls, coordinated layout and QKV fusion
remain the next structural targets.

The subsequent C256 SASS audit narrows the scheduling difference. Native W1
unrolls its eight K32 steps inside a four-iteration hidden-chunk loop. It loads
11 of 16 weight vectors before the first MMA and keeps up to 48 logical B words
live. Our rolling implementation keeps 16 B words live and copies the next
fragment into a carry bank after the current 16 MMAs. The audit traces each
loaded word through register reuse and verifies ascending K order separately
for every native accumulator. These instruction distances establish scheduling
opportunity, not memory latency or a predicted speedup.

Native W3 and output projection use short loops without that deeper prefetch;
native Q/K/V share one loop and its A loads. A blanket prefetch change would
therefore miss the stage-specific design. The private experiment changed
only W1: unroll its K loop, roll the hidden chunks, and preserve all later
dense operations, publication points and rounding order. The
[experiment handoff](../outputs/c256-w1-schedule-draft/HANDOFF.md.draft)
records its source scope. The subsequent
[completed screen](../outputs/c256-w1-runtime/COMPLETED-v2.md.draft) passed its
numerical and sanitizer checks but lost all twelve directional timing medians;
the candidate remains disabled.

The C512 QKV/attention fusion has now been integrated after its complete scan.
At its 4K field of 8,160 tokens, the retained raw Half QKV path incurs about
50.1 MB of logical writes plus reads per block, or 802.2 MB across sixteen
blocks. For the global stage's 2,160 tokens, combining the ordered QKV reducer
with normalization and prepared FP8 publication could remove another 26.5 MB
of logical raw-QKV writes plus reads per block. These are byte counts, not
measured DRAM traffic or predicted time savings. The attention matrix work
remains; the detailed GEMM audit separates it from preparation overhead.

The first private global reducer/preparation fusion now has exact output and
sanitizer evidence, but it has not passed its real-weight performance screen.
The vector reducer plus separate preparation remains faster on the eight
measured complete QKV/attention cases. Some component timings are unstable;
the [measurement review](../outputs/global-qkv-reduce-prepare-build-review/TIMING-REVIEW-v3.md.draft)
keeps that limitation separate from the numerical results. No global fusion
has been enabled. The [experiment walkthrough](optimization_walkthrough.md#49-reject-a-fusion-when-the-complete-path-does-not-improve)
also records a joint-QKV candidate parked after compilation because its
generated loop did not materially improve on an earlier losing schedule.

## Progress against the requested performance goal

### Nonfinite packed inputs remain an open numerical contract

A targeted [C256 input-boundary probe](../outputs/c256-w1-runtime/ADJUDICATION-RESULT.md.draft)
found a difference outside the finite fixtures used for the trunk comparison.
It uses original checkpoint blocks 15 and 49 at a verified 8×12 field, all four
phases, and two separate input patterns. The eight finite counterparts match
native published bytes on all compared paths. When the inputs include FP8
NaN codes, all eight native outputs consist of `0x7f`; our retained rolling
kernel, W1 scheduling candidate and both compositions differ from native.
The W1 candidate still matches the retained rolling implementation exactly.

The [original PTX trace](../outputs/c256-w1-runtime/ADJUDICATION.md.draft)
shows two distinct issues. The historical composition clears byte NaNs during
unpacking before W1, while native and the fused paths feed the original bytes
to the matrix instruction. Correcting that diagnostic input boundary does not
close the native gap. Native W1 activation publishes with a direct FP8
conversion, whereas our packed-pair helper masks Half NaNs first. This is a
source-level candidate for the first divergence; native intermediate values
were not intercepted. Native raw Half output is also not observed here.

The first diagnostic preserved all sixteen outputs and completed its graph and
guard checks, then failed a final host identity check because a compile-only
helper rejected an already imported Torch module. Its parent identity checks
passed and its Job quiesced, but the run remains recorded as failed. These are
qualified diagnostic observations, not a newly accepted full validation run.
The [receipt](../outputs/c256-w1-runtime/adjudication-first/job-receipt.json)
and counterexamples are preserved. No tolerance was relaxed, no candidate
inputs were silently sanitized, and no W1 candidate has been activated.

The identity-only revision subsequently repeated all sixteen cases and passed
both worker and parent identity checks, with normal exit and an empty Job.
Its [accepted diagnostic receipt](../outputs/c256-w1-runtime/adjudication-v2/job-receipt.json)
and [retained endpoint results](../outputs/c256-w1-runtime/adjudication-v2/worker-result.json)
confirm the same split: all eight finite cases match native, and all eight
NaN-code cases retain the native/local difference. Acceptance here means the
diagnostic completed correctly; it does not mean those mismatching outputs
pass native equivalence. The failed first attempt remains preserved.

### Matched resident trunk timing

The following table uses the current installed encoder binary, with balanced execution order.

| Exact valid FP8 trunk input size | Our current implementation | Original kernels | Our/native latency |
|---|---:|---:|---:|
| 1280×720 | 2.978 ms | 2.181 ms | 1.366× |
| 1920×1080 | 3.975 ms | 2.557 ms | 1.555× |
| 3840×2160 | 9.194 ms | 6.433 ms | 1.429× |

The [three fresh singleton reports](../outputs/c32-encoder-transition-native3/run-balanced-v2/receipt.json) check all 74
boundaries at each size, including retained poisoned graph replays, allocation
guards and immutable inputs/weights. All pass byte-exactly. Its
[aggregate receipt](../outputs/c32-encoder-transition-native3/run-balanced-v2/receipt.json) confirms
normal process cleanup, unchanged sources/binary and one committed journal
row in each exact-size run. Exit code 2 denotes the measured speed gaps, not a numerical failure.
These are resident trunk graphs with three calls per capture, three warmups
and 32 alternating pairs, 16 per order; captured external events time each graph.
Candidate layout conversions are included. Both orders fail their speed gates.

This is a three-size trunk comparison, not full-DLL host timing or a new
full-range result. A historical v24 run covered all 931 padded geometries
exactly and was slower at all of them. The new run measures three of those
geometries. The [older v29 comparison](../outputs/native-trunk-v29-direct.json)
is retained; comparing separate release runs does not isolate an individual
policy's gain. At the measured 4K trunk boundary, closing the current ratio
needs about a 30.0% latency reduction. The
[previous v36 run](../outputs/native-trunk-v36-direct.json) took 2.845, 3.896
and 10.086 ms at its representative workload geometries. The preceding C512
integration measured 2.964/3.976/9.738 ms candidate and 2.177/2.554/6.352 ms
native at geometry representatives **1280×720, 1793×1025 and 3713×2049**.
Earlier prose labeled the last two by their workload buckets; those are not
their exact valid dimensions. The new table uses explicit singleton bounds to
measure the stated valid dimensions. Separate release runs do not isolate the
cause of a timing change.
The subsequent [same-binary paired ablation](../outputs/c512-trunk-ablation/run-paired-native3/REPORT.md)
confirms that the selected policy is about 4.3% slower at the 720p-equivalent
geometry and 2.3% slower at the 1080p-equivalent geometry. It is about 3.0%
faster at the 4K-equivalent geometry, but narrowly misses the strict
three-percent speedup margin in both orders. All boundaries and changed-input
graph replays pass. Both cache halves stay resident on both paths, so this
isolates exposing the cache and selecting the fused route. The integration
requires policy revision; its isolated-operator wins are not a general network
speedup. This ablation does not execute native kernels and uses independent
retained endpoints per call, a different protocol from the native3 table.

A separate [4K stage attribution](../profile/trunk-stage-events-v36-4k-owned/REPORT.md)
identifies where the current implementation spends time. Sixteen C512 blocks
contribute 2.014 ms together, followed by eight C1024 blocks at 1.780 ms.
C256, C128 and C64 contribute 1.521, 1.154 and 1.019 ms respectively; C32
contributes 1.448 ms. The largest single interval is the decoder transition
65→66 at 0.275 ms. Those are instrumented stage intervals, not individual
kernel timings. Native entries also fuse transitions that are separate in our
graph, so subtracting corresponding family totals would give misleading gaps.

That diagnostic uses one call per captured graph and brackets instrumentation
with clean measurements. Clean-after candidate/native medians are 9.691/5.983 ms;
event overhead is about 2.03%/3.24%, with less than 0.09% clean-baseline drift.
Its different graph working set prevents treating the lower absolute times as
an improvement over the three-call comparison above. All 74 boundaries remain
byte-exact. No NCU resource counters were collected in this diagnostic.

The two optimized boundary converters exceeded 85% elapsed DRAM throughput in
their isolated profiles. The main C256 rolling kernel remains around 48.56%
elapsed tensor-pipe activity, 20.30% L2 data throughput and 4.83% DRAM throughput
in its saved cold profile. The network-wide 85%/DLL-speed goals are unmet.

The ordinary scan completed all 10,376 real-weight contracts with zero recorded
failures across 4,283 dispatch keys and 931 padded geometries. Full, no-op resume
and export checks passed. Its staged policy contains 878 winning anchors and
3,405 guard anchors. All 3,084 device-code/resource comparisons across six
architectures passed, as did 140 schema comparisons and 21,121 compiled selector
queries. The policy version `19c64573272a45c8` is now installed in v36. Focused
runtime validation passed 804 tests with four skips; full regression passed
6,612 tests with 29 skips. The 21 opt-in full-model cases subsequently passed
in a separate run, including prepared/packed capture, backward propagation and
trainable-parameter gradients. Seven second-GPU cases and one obsolete staging
comparison remain skipped. Unfiltered memcheck passed 378 private-kernel and
132 C512 cases with zero errors; unfiltered racecheck passed 52 private-kernel
and 18 C512 cases with zero errors or warnings. These sets overlap ordinary
tests and are not additional independent functional cases. Two test-harness issues were corrected:
singleton-strided byte comparison and CPU import checks that need a fresh
interpreter. Those corrections did not change the compiled numerical kernels.

The endpoint-clamped policy transfers configurations outside the measured range;
it does not resize tensors or claim unmeasured performance coverage. Host
validation/hashing explained the scan's low GPU duty cycle. This scan covers
ordinary packed FP8 GEMMs, not every operator, FP16 shape or native renderer mode.
The [staging manifest](../outputs/v36-ordinary-policy-staging-serialized/activation.json)
and [isolated build manifest](../outputs/v36-policy-build/run-20261003T184033_265370Z/manifest.json)
retain the measured evidence. The [CPU post-build report](../outputs/v36-policy-postbuild/REPORT.md.draft),
[activation receipt](../outputs/v36-activation/activation.json) and
[focused runtime receipt](../outputs/v36-activation/run-focused-v3/result.json)
record the subsequent validation and activation. Full renderer/model timing
and the network-wide DLL-speed/85% gates remain open.
The [explicit full-model receipt](../outputs/v36-activation/run-full-model/result.json)
records all 21 opt-in cases with no skips and confirmed process cleanup.
The [completed validation receipt](../outputs/v36-activation/validation-complete.json)
pins all seven successful runs, sanitizer summaries and cleanup qualifications.

The later C512 integration adds its own bounded regression evidence: 69 hook
cases, 171 focused cases with three second-GPU skips, and all 21 opt-in model
cases passed. Memcheck passed 235 cases with three second-GPU skips and zero
errors; racecheck passed 23 cases with zero errors or warnings. These sets
overlap. All six owned runs, including native3's numerical pass and speed
failure, ended with no active Job processes and all observed process handles
signaled. The [separate closure](../outputs/c512-policy-build-plan/activation-draft/validation-complete-after-native3.json)
preserves exact receipts without rewriting the original activation record.

The [full-suite receipt](../outputs/v36-activation/run-full/result.json) confirms
normal exit and an empty worker Job. Pytest completed in about 237 seconds,
but an owned MSVC telemetry descendant kept the Job alive for about 951 seconds
in total. No process was manually terminated. The private-kernel memory check
passed 378 cases with zero reported errors while that CPU telemetry cleanup
was still pending; it was not a performance measurement. The
[cleanup diagnosis](../outputs/v36-activation/full-wait-diagnosis.md) preserves
the observed ownership and this overlap qualification.

A later private fusion computes projection and skip merge inside the C32
consumer and limits its register allocation. The earlier
[complete block66 comparison](../outputs/c32-native-publication-matched/run-paired-4k-v1/proof.json)
also matches the original direct FP8 conversion: 159.136 microseconds versus
173.536 for the masked version at the same register limit, 194.016 for uncapped
masked fusion, and 127.488 for the original extracted up66 kernel.
All published bytes agree on that fixture, but the candidate remains about
1.25 times slower and is not installed. The conversion change also passes
separate original-kernel tests with NaN inputs, where the masked controls differ.
This is a local operator result; it does not update the full-trunk timing above.

The [merge-only NCU report](../profile/c32-merge-input-matched-v36/REPORT.md) confirms
removed raw-array reads and lower memory traffic, with unchanged theoretical
residency. Elapsed tensor, L2 data and DRAM utilization still fail 85%.
The [projection ownership audit](../outputs/native-up66-projection-flow/REPORT.md.draft)
traces the original eight projection MMAs and fourfold register replication
into the skip merge. The new projection-fused candidate reproduces that
ownership while retaining logical BHWC input/output and the existing core.
The [uncapped profile](../profile/c32-projection-merge-matched-v36/REPORT.md)
shows that 179 registers limit residency to eight CTAs per SM. The later
168-register trial introduces 24 bytes of spills and passes its resident
improvement screen. Its [fresh counter analysis](../profile/c32-projection-r168-matched-v36/REPORT.md)
confirms twelve register-limited CTAs per SM and 24.122% achieved occupancy,
with 25,067,520 L1 local bytes in each direction. Tensor elapsed utilization
is 49.134%; tensor, L2 data and DRAM all remain below the 85% target.
Its scheduling and physical layout cannot be described as identical to the DLL.

The private direct-conversion trial has now completed its
[fresh full/source counter analysis](../profile/c32-native-publication-matched-v36/REPORT.md).
It removes 416 equality tests and reduces executed instructions from 4,651 to
3,867 per CTA, retaining 264 tensor instructions and 416 E4 pair conversions.
Allocated registers remain 168 with twelve register-limited CTAs per SM.
Its elapsed tensor utilization is 54.223%, L2 data 15.129% and DRAM 32.531%:
all still fail 85%. The earlier 49.134% figure belongs to masked R168.
These replay measurements do not replace the balanced resident timing above,
and neither private kernel changes the installed full-trunk result.

Spill stores and reloads double from six to twelve each per CTA, or 48 bytes
per thread and 50,135,040 L1 local bytes in each direction for this field.
L2 TEX writes rise by the extra local-store byte count while DRAM writes fall;
the hierarchy counters do not establish an exclusive spill-cost attribution.
All 192 converted-pair joins execute as separate permutations, 6,266,880 warp
instructions across the launch. The
[pair-join audit](../outputs/c32-native-pair-join-review/REPORT.md.draft)
traces earlier converted pairs used as native F2FP merge operands. A
[separate join candidate](../outputs/c32-projection-join-r168-draft/HANDOFF.md.draft)
preserves the conversions and raw Half residuals. Its
[compiled review](../outputs/c32-projection-join-r168-draft/INDEPENDENT-SASS-REVIEW.md.draft)
verifies all 192 converted merge operands, unchanged 168 registers and a
32-byte stack with 28 bytes of spills. The
[qualification record](../outputs/c32-projection-join-r168-build/qualification.json)
passes bounded native nonfinite and actual-4K published comparisons, exact raw
bits against current direct publication, and the required sanitizer checks.
However, the [resident comparison](../outputs/c32-join-matched/run-paired-4k-v1/proof.json)
measures 157.184 microseconds for join versus 159.968 for current direct
publication, with per-order ratios from 0.954741 to 1.030427. The incremental
strict 3% gate fails; the gain over the older masked control does not qualify
this additional change. The [fresh join profile](../profile/c32-join-matched-v36/REPORT.md)
confirms 200 fewer executed instructions per CTA and 29,245,440 local spill
bytes in each direction, with unchanged global requests and sectors. Elapsed
tensor utilization is 55.079%, L2 data 14.253%, and DRAM 31.025%; all fail 85%.
Input-transpose load dependencies remain prominent in source samples. Neither
installed code nor the best qualified private direct-publication path is
replaced by this trial.

The subsequent [affine-address trial](../outputs/c32-affine-matched/run-paired-4k-v1/REPORT.md)
uses the existing full-tile contract to remove redundant coordinate checks and
shorten address lifetimes. Its compiled inference variant has 400 fewer static
instructions, unchanged numerical/global-memory instruction counts and a
24-byte stack. All seven qualification runs pass, including the broader native
race check. Resident medians are 151.856 microseconds versus current direct
159.872 and native 128.480. Only 21 of 24 orders clear the strict 3% incremental
threshold, so this trial also remains unpromoted. Fresh profiling measures
20,889,600 local bytes in each direction, despite the mixed 16/32-bit reload
payload, and unchanged global output sectors. Elapsed tensor utilization is
57.032%, L2 data 14.548% and DRAM 32.598%; all remain below 85%.

Two further audits make the remaining differences concrete. The
[core ownership audit](../outputs/c32-core-flow-audit/REPORT.md.draft) accounts
for all 164 versus 80 executed shuffles per CTA, including input preparation,
normalization, denominator distribution and V transposition. Some extra
shuffles accompany fewer reciprocal-square-root or matrix-transpose
instructions, so deleting the count difference is not a valid optimization.
The [output-store audit](../outputs/c32-output-store-audit/REPORT.md.draft)
identifies fourfold L1 store-sector overhead for the same payload and proves
a BHWC vector mapping. Its extra exchanges and buffering still require a
new compiled and timed experiment.

That combined affine-address/vector-store experiment now measures 146.912
microseconds, versus 160.256 for the prior best direct path, 153.088 for the
affine-only parent and 128.976 native in the same run. Its strict 3% gate passes
in all 24 orders against the prior best, but only 18 against the unpromoted
affine parent. It is the best private candidate for this measured component;
the isolated store increment retains its failed parent gate. The seven
qualification runs pass, including unconditional published/raw comparisons
against both Torch controls. The [paired evidence](../outputs/c32-affine-store-matched/run-paired-4k-v1/proof.json)
does not establish native parity, an installed-policy gain or wider-range speed.
Fresh NCU confirms the output sectors fall to 2,088,960, matching native, while
local traffic rises to 29,245,440 bytes in each direction. Elapsed tensor,
L2-data and DRAM utilization are 59.089%, 9.497% and 33.123%; all remain below
85%. The first low/skip loaded-value dependencies remain visible and are being
examined against the original schedule.

The first-skip preload trial moves one identical replacement read before
projection in both compiled raw modes, preserving the checked raw forks and
published bytes. All seven numerical/sanitizer runs pass, but resident latency
is 146.880 microseconds versus 145.712 for affine-store and 129.216 native.
It clears none of the 24 incumbent improvement gates and is not promoted.
The [compiled review](../outputs/c32-projection-skip-prefetch-r168-draft/INDEPENDENT-SASS-REVIEW.md.draft)
records the surviving early load and added spill payload; the
[paired proof](../outputs/c32-skip-prefetch-matched/run-paired-4k-v1/proof.json)
records the failed speed result. [Fresh NCU](../profile/c32-skip-prefetch-matched-v36/REPORT.md)
records zero long-scoreboard samples at both first-skip consumers, while low
input and later-skip dependencies remain. Local traffic rises to 33,423,360
sector bytes in each direction. Elapsed tensor/L2-data/DRAM utilization is
59.080%/10.061%/33.956%, so all 85% gates still fail. These counters explain
the costs and remaining dependencies; they do not turn the failed resident
comparison into an improvement.

The subsequent block-4 audit follows the fresh whole-trunk Systems trace to
its largest individual gap. The original fused transformer, Half pool and
K32-to-N64 projection preserve both the high skip and low publication. Our
old path additionally materialized raw Half, reread it in a scalar pool,
copied padding, and used an N128 projection tile. The
[matched old-path counters](../profile/c32-down4-matched-v36/REPORT.md)
verify these differences rather than inferring them from kernel names.

A private down4 fusion now retains the raw fragments in registers and writes
both outputs with coalesced vector stores. Its
[matched original/fused report](../profile/c32-down4-fused-v36/REPORT.md)
records equal useful payload (100,270,080 bytes), store sectors (3,133,440) and
executed QMMAs (8,680,320), with no local-memory traffic. The
[resident experiment](../outputs/c32-down4-fused-runtime/REPORT.md) reduces
403.936 to 167.456 microseconds in all six execution orders; original remains
faster at 120.320 microseconds. It is not yet installed.

This does not make scheduling and layout identical. The new kernel still
uses BHWC input/output instead of the original tiled allocation. Thirty-two
U16 input sites generate four times their ideal source-sector count; four
intact input-load-to-join chains account for 912 of 1,462 long-scoreboard
samples. Its 149.10 million warp instructions exceed the original's 92.62
million despite identical QMMA counts. The 408 Half-NaN tests per CTA also
remain, whereas the original directly converts to FP8. Finite fixtures are
byte-exact, but the inherited NaN-containing counterexamples remain. Elapsed
tensor utilization is 50.320% versus 72.474%; neither meets 85%. Wider input
loading and direct publication are separate next experiments, each requiring
its own numerical and measured-speed evidence.

The subsequent [direct-publication profile](../profile/c32-down4-native-publication-v36/analysis/REPORT.md)
closes the NaN cleanup difference for the four finite and seven exceptional
component fixtures. Removing that cleanup reduces resident latency from
171.584 to 153.888 microseconds in the matched run; native remains faster at
126.032. All six incumbent improvement gates pass. Executed warp instructions
fall to 122.50 million, while QMMAs and memory sectors stay unchanged. Tensor
elapsed utilization is 57.413% versus 72.395% native, still below the requested
85% threshold. The rejected vector-input trial reduces source sectors but
does not pass its resident improvement gate.

The remaining difference is now traced more precisely. Native uses an earlier
converted pair as merge-C in 184 ordinary FP8 conversions; the current direct
kernel instead explicitly joins pairs, executing 6,049,920 additional such
PRMT instructions. The original PTX uses two saturating pair conversions and
`mov.b32 {low, high}`. Current division also executes eight corrected reciprocal
fast paths per CTA; all slow-helper calls execute zero. These are distinct
instruction differences, not evidence that complete scheduling or layouts
match. The scalar BHWC input still has four times its ideal source sectors.

The [new private whole-trunk integration](../outputs/c32-encoder-transition-native-publication-runtime/REPORT.md)
passes 19 contracts, 74 exact-valid 4K native boundaries, and 55 tests plus
eight subtests covering training and prepared graphs. Its balanced shared-4K-field
comparison improves 9.433189 to 9.194939 ms, with both orders below the strict
0.99 ratio. This is a same-binary selected/composed comparison; no new original
DLL host timing or full-range speed claim follows from it.

For the optimization history, exact performance reports, failed experiments
and reproduction commands, see the [optimization walkthrough](optimization_walkthrough.md).
