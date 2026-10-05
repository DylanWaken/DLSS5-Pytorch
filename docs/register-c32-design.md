# One-warp FP8 C32 candidate

This records the register C32 implementation and its successive experiments.
`inference_block32_register` passed all 89 v9 focused parity tests, including
real weights, shifted edges, raw skips, packed I/O and graph replay. SM120 compilation
reports 188–190 registers, zero static shared memory and zero spills. The existing C32
implementation and FP16 path were the deployment baseline at that stage.
The v11 compiled policy now chooses the canonical register path for measured
SM120 FP8 families. The rotated candidate below remains private and unselected.

The v10 follow-up replaces packed-byte NaN branches with an ordered half2
equality mask before conversion. All 93 register tests pass, including an
exhaustive 65,536-half-code test with four partner-lane arrangements and odd
unaligned views. The profiled FP16-input/two-output instance uses 180 registers.
At 512x576, cold NCU duration decreased from 70.11 to 54.304 microseconds and
executed instructions from 36.05 million to 25.92 million; tensor utilization
is still only 19.88%. The original kernel at that field measured 20.99
microseconds cold. Original and candidate storage/output contracts differ,
so this is a bottleneck comparison rather than a promotion measurement.

`outputs/block32_register_v10.json` preserves bounded multi-call graph timings
(up to 50 calls, 256MiB requested-output budget). Values below are microseconds
per block call; real checkpoint block1, phase1, batch1:

| Field H x W | Current shared, FP16 input/two outputs | Register, FP16 input/two outputs | Register, packed input/output, raw omitted |
| --- | ---: | ---: | ---: |
| 128 x 128 | 11.013 | 9.872 | 9.039 |
| 512 x 576 | 80.864 | 43.986 | 35.478 |
| 1088 x 1920 | 644.352 | 326.208 | 223.360 |

These measurements do not include a matching packed shared fallback. Register
calls derive the ordinary block1 skip from their input; shared calls receive
that identical value explicitly. Policy promotion requires the stricter
same-contract measurements described below; this table predates promotion.

The operator takes logical BHWC state as either FP16 values or packed uint8
E4M3 codes, with persistent row-major uint8 weights. `skip=None` derives the raw
residual from that original state; adapter, decoder-transition and output blocks
must supply their separate raw FP16 skip. `packed_output=True` retains packed
state for the next block. `raw_output=False` returns an empty FP16 `[0]` tensor
as the second tuple member and avoids raw stores. Defaults preserve both FP16
outputs. These flags do not select a production model route.

## Evidence from the original kernel

The unchanged original `cc_tinlayout_fused_swin_1h_32_1_fp8` kernel launches one
32-thread warp per shifted 8x8 window. Its original cubin declares 168 registers
per thread and no static shared memory. The filtered PTX and SASS are retained
in `assets/vendor_sources/window32.ptx` and `window32.sass.txt`; the source cubin
is `assets/vendor_modules/module_0.cubin`, SHA-256
`feb368ff5279a7408b1e55554db6e468d7f114a24b18b2af8d7e6989a410c612`.

The static instruction inventory is 256 FP8/half-accumulator MMAs: 64 expansion,
64 contraction, 48 QKV, 32 QK, 32 PV and 16 projection; 32 MOVM, 43 PRMT, 32
butterfly SHFL and 16 indexed SHFL. There are no shared loads/stores or CTA
barriers. It is not completely spill-free: a 64-bit and a 32-bit local store are
reloaded later, totaling 12 bytes per thread across a long live range. These
counts establish dataflow properties. Captured native NCU reports show the
128x128 field is dominated by a small grid and latency (289 one-warp CTAs,
6.85 microseconds cold, 9% tensor utilization). Larger fields reach 53.80%
tensor utilization at 512x576 (20.99 microseconds) and 73.71% at the diagnostic
1088x1952 field (135.10 microseconds). The last field is a diagnostic shape,
not a full-network resolution mapping. Source reports are retained under
`profile/vendor-window-c32-*`; these are individual original-kernel measurements,
not original full-network timings.

PTX lines 979–1084 show sixteen expansion MMAs using four A fragments and just
eight B registers. Thus the schedule expands **32 hidden channels for all 64
tokens**, applies the cubic and publication, then contracts that K32 chunk into
the persistent output accumulators. It repeats this for hidden channels 32–63,
64–95 and 96–127. It does not need all 128 hidden channels live simultaneously.

## Canonical fragment layout

Let `lane=4*g+t`, with `g=0..7`, `t=0..3`. One warp owns four M16 row tiles.
Use physical 4x4-tiled token order for these rows. Tokenwise FFN/QKV computation
is unchanged; score bias rows and final BHWC coordinates use the inverse token
permutation. Key columns already have the required physical order.

For row tile `m`, A register `a[2*h+s]`, `h,s=0..1`, contains four FP8 bytes:

```text
row    = 16*m + g + 8*s
column = 16*h + 4*t + byte_index
```

An M16xN8 accumulator pair `c[j][s]` is a half2 register at the same row,
with columns `8*j+2*t` and `8*j+2*t+1`. Keep raw FFN values in this C layout:
four row tiles × four column tiles × two registers = 32 registers per thread.
The raw value must survive until projection; its E4M3 publication is not an
equivalent residual seed.

### C publication to A

For each `h,s`, combine the two published C pairs for columns `2*h` and
`2*h+1` into a local 32-bit word `u`. Then:

```text
source = 4*g + 2*(t&1)
lo = shfl(u, source)
hi = shfl(u, source+1)
a[2*h+s] = byte_perm(lo, hi, (t&2) ? 0x7632 : 0x5410)
```

The PRMT selectors take either the low or high byte pair from each shuffled
word. This is two indexed shuffles plus one PRMT per A word, with no dynamic
register-array indexing. Apply the same mapping to each K32 portion of a K64
probability tensor or K128 FFN tensor. Cubic activation and publication precede
this movement; movement does not reorder arithmetic within an MMA.

### Q/K normalization in C layout

One four-lane group owns a row's 32 channels as four half2 registers per lane.
For each row side, compute `hfma(c0,c0,hmul(c2,c2))` and
`hfma(c1,c1,hmul(c3,c3))`, then add those half2 values. These are respectively
the original low/high square pairing and stride-8 half addition. Shuffle/add
with lane offsets 2 then 1 inside the four-lane group, add the final low/high
halves, and broadcast the sum. This reproduces strides 4, 2 and 1 in order.
Clamp the squared sum to the native floor, round rsqrt to half and multiply.
The existing Q scale and FP8 publications remain in their original order.

The CPU proof compares the full symbolic half-FMA/half-add expression tree to
the established scalar tree, including operand order. It does not substitute
a generic warp reduction.

### K and V for attention

K's A layout already supplies QK's B registers without a transpose. For key
column tile `n`, use `K[n/2].a[n%2]` and `K[n/2].a[2+n%2]`. These hold key row
`8*n+g` and channel groups `4*t` and `4*t+16`.

V starts in a compact C layout. For one M16 token tile and one N8 channel tile,
combine its two published row-side pairs into `v`, four bytes per lane. Transpose
the corresponding 8x8 matrix of 16-bit elements with
`movmatrix.sync.aligned.m8n8.trans.b16`. This instruction transposes register
fragments across the warp; all lanes must execute it together.
[NVIDIA PTX instruction contract](https://docs.nvidia.com/cuda/parallel-thread-execution/#warp-level-matrix-instructions-movmatrix)

After the MOVM, use:

```text
source_group = (g&~1) | (t>>1)
source = 4*source_group + 2*(t&1)
lo = shfl(transposed_v, source)
hi = shfl(transposed_v, source+1)
vb = byte_perm(lo, hi, (g&1) ? 0x7531 : 0x6420)
```

The resulting word contains V at four consecutive physical token positions
`4*t..4*t+3` for output channel `8*n+g`. This transformation references only one
source register, so each V tile can be transformed in place. Four token tiles ×
four channel tiles need 16 registers. For PV K32 chunk `k`, its B pair is
`vb[2*k][n]`, `vb[2*k+1][n]`.

## Execution schedule and register lifetimes

1. Gather and publish all 64 state rows into 16 A registers. Initialize 32 raw
   FFN half accumulators from the separate raw skip and half residual scale.
2. For hidden K32 chunks 0, 1, 2, 3: load eight W1 B registers, expand all four
   M16 tiles, apply cubic/publication, convert the chunk into 16 A registers,
   load eight W2 B registers, and update the persistent contraction accumulators.
   Preserve ascending K32 order and the seed in the first instruction.
3. Replace the dead input-state registers with published FFN A registers.
   Retain the raw FFN C accumulators separately.
4. Produce Q, K and V in separate groups of 32 output channels. Normalize and
   publish Q/K as each complete M16x32 tile becomes available. Keep 16 Q, 16 K
   and 16 transposed V registers; release published FFN and temporary QKV words.
5. For each query M16 tile, load the original prior using natural query row and
   physical key column. Compute eight QK N8 tiles, apply the native exponential,
   and use the established fixed denominator tree. Publish normalized P and
   convert its two K32 chunks to A. Execute PV in K32 order, publish its result,
   convert to A and project, seeded by the saved raw FFN times attention scale.
6. Store published and raw half outputs, guarding shifted edge coordinates.
   Release that query tile's Q and raw FFN registers before the next tile.

Persistent attention state is 80 32-bit registers: raw FFN 32, Q 16, K 16, V 16.
Score temporaries add 16; other matrix fragments, scalar pointers, addressing
and compiler scheduling add more. These counts are a liveness estimate, not a
compiler register promise. Use compile-time tile indices and explicit scopes
to avoid dynamically indexed arrays becoming local memory. Retaining the
original one-warp schedule can reduce shared-memory traffic and barriers even
when register pressure limits occupancy; it does not guarantee higher occupancy.

## Native-layout follow-up

The original kernel has no FFN shuffle instructions before its normalization
region. Its checkpoint/input channel rotation lets C publications feed later A
fragments by local packing. The canonical design above adds approximately 320
movement shuffles across FFN, Q/K and probability publications. This is a clear
optimization opportunity if a native-layout variant is implemented.

That variant must rotate matching weight K coordinates and preserve all K32
instruction boundaries. A within-K32 permutation should not be assumed harmless
for every GPU's internal accumulation. Test half-midpoint and cancellation cases,
large dynamic ranges, actual weights and native cubins before changing the
established deployment layout. Cache any alternative static weight layout during
preparation; never repack weights per forward. The experimental packed-state
interface removes half input/output conversion overhead while retaining the
raw skips and raw outputs needed at graph transitions.

The exact direct-publication permutation is
`P=[0,1,8,9,2,3,10,11,4,5,12,13,6,7,14,15]`, repeated independently inside
each K16 group. It is the checkpoint's `packed_input_index`. The decoded matrix
has `W[n,j]=archive[inverseP(j),n]`, so `W[n,P(k)]` recovers the original raw
fragment order. CPU checks cover all 122,880 C32 weight bytes across blocks
0–4 and 66–70. This proves indexing, not hardware accumulation invariance.

`tools/probe_fp8_rotation.py` isolates that remaining numeric question. It
compares original and permuted ordered MMA results bitwise for all finite E4
codes, every finite FP16 seed, cancellation with extreme exponents, half
midpoints and their tiny neighbors, K32/K64/K128 chains and actual weights.
It saves full first counterexamples on failure. Its CPU proof also derives the
matching V transform: one `MOVM`, one lane-XOR-4 shuffle and a byte permutation
(`0x6420` for even row groups, `0x3175` for odd) produce P-rotated physical
key coordinates. The SM120 GPU rotation gate passed. The separate full-block
prototype in `block32_rotated.cuh` was compiled in v12 and passed all 86 focused
tests. Its preparation operator retains
canonical weights alongside a persistent vector-load layout, and its forward
uses direct register publications. The existing edge addressing is unchanged
so the first comparison isolates layout and instruction movement.

## Proof and acceptance plan

`python tools/block32_register_layout.py` currently verifies **6,144 unique
symbolic byte coordinates** for C-to-A K32/K64/K128 movement, K-to-QK B mapping,
MOVM/shuffle/PRMT V transpose, plus the exact normalization expression tree.
It also checks 52,288 half2 stores for unique and complete shifted-window
coverage, including batch two, non-multiple edge dimensions and tiny images.
This is CPU-only research and imports neither Torch nor the extension.

Before routing a CUDA candidate: inspect compiled registers/local spills and
absence of unintended shared memory; run the 89 register-operator tests and
the existing 50 fused-operator tests plus
native C32 comparisons; capture graphs and compare all 77 complete-model
boundaries; time representative padded fields; collect full/source/PM NCU and
SASS. Keep the current FP16 kernel and measured C32 implementation available
until the candidate is both exact and faster. A successful block optimization
does not establish all-dimension official-runtime speed or the 85% gate.

## Compiled selection policy

Production selection belongs in C++, behind a generic C32 operator. The legacy
FP16-state/two-output call must retain its public contract. A packed-state entry
should likewise select a kernel in C++; Python should specify the desired
storage/output contract rather than a kernel implementation.

Measure candidates under matching input, skip and output contracts. Packing
static weights and initial packed state happens before timing. A conservative
fallback for packed state can compose unpack, the current fused block and pack
inside C++; include those conversions in its measured graph. The register path
cannot be credited for omitted raw stores when the competing path's caller
requires raw output.

The policy family is `(SM, arithmetic precision, input dtype,
packed output, raw output, explicit skip, phase modulo 4)`. Within a family,
index measurements by the actual shifted-window count
`B * ceil((W + sx) / 8) * ceil((H + sy) / 8)`. Choose the nearest measured
count, clamp outside both endpoints, and break exact ties toward the smaller
count. Keep original B/H/W and the valid-token ratio in the measurements so
edge-heavy shapes can be audited. Unmeasured families and devices retain the
existing fallback. Validate the choice on irregular edge geometries before
allowing size interpolation to select register fusion there.

Serialize correctness-gated measurements and binary/device identities in the
per-device JSON policy, then generate immutable C++ tables and a version hash.
Runtime forward calls must not read JSON, benchmark kernels, mutate policy or
select kernels in Python.

The v10 same-contract sweep now covers all four phases, explicit and derived
skips, all eight input/output/raw-output combinations, and three fields
(128x128, 512x576, 1088x1920): 192 measurements, all byte exact. Each register
variant beats its matching fallback by more than the 3% promotion margin.
`tuning/sm_120.block32.json` retains the evidence and generates policy version
`7f61d1cb8a95b3b0`. Its dispatcher and generic packed I/O schema were compiled
in v11. Other SM versions retain the existing fallback.

The separate rotation gate also passed on SM120: 275,456 half results across
58 cases were bit identical, including cancellation, half midpoints, the full
finite half seed range and real weights. This supports implementing a rotated
candidate; it does not promote the prototype or replace native full
block comparison. The rotated suite passed 86 cases covering independent
cache-byte checks, actual checkpoint blocks, shifted edges, raw skips, packed
I/O, capture and invalid-input contracts. After that suite passes,
`tests/benchmark_block32_register.py --implementation rotated
--matching-baselines --all-io-modes` measures shared and canonical register
references with identical requested I/O. All four cached matrices are prepared
before timing. Rotated policy export requires pinned independent numerical,
unchanged-original block and ordered-MMA evidence.

V12 compilation uses 147–148 SM120 registers, with no shared memory or spills.
`outputs/block32_rotated_v12.json` contains 24 exact same-I/O comparisons for
checkpoint block1, phase1, derived skip and three fields. Packed input/output
with raw output omitted gives the following graph replay times in microseconds:

| Field H x W | Canonical register | Rotated register |
| --- | ---: | ---: |
| 128 x 128 | 9.063 | 9.507 |
| 512 x 576 | 35.544 | 29.390 |
| 1088 x 1920 | 222.440 | 175.408 |

The small case remains faster with the canonical kernel. These initial timing
results did not change selection. The later complete 192-case v12 sweep and
32-case unchanged-original gate support the v13 integration described in
`docs/block32-rotation-promotion.md`: 123 rotated choices and 69 canonical
choices, with a 3% margin required against both matching baselines. This does
not establish original-kernel speed or full-network parity.
