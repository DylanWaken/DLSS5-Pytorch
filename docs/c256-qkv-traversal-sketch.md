# Separate C256 Q/K/V traversal hypothesis

This is a CPU-only design sketch, parked until the vector-weight cache is
measured. It makes no source changes and carries no performance claim.

The proposed change is to read one shared FFN A fragment and use it for Q,
K, and V before moving to the next K32 group. Every output accumulator keeps
the existing K32 order. Normalization, E4 publication, V transpose, attention,
and all CTA barriers remain unchanged.

## What the original kernel does

The original PTX loop `$L__BB1_25`, lines 4160–4590 in
`assets/vendor_sources/window256.ptx`, loads four A fragments and six
16-byte B vectors per K32 group. Its SASS loop at **0x32b0–0x36e0** has:

- 48 QMMAs: four M16 tiles × three matrices × four N8 groups.
- Four `LDS.128` operations, one for each M16 tile.
- Six `LDG.E.128.STRONG.SM` operations, two for each of Q/K/V.
- One loop-control stream advancing K by 32.

The four A registers begin at R84/R88/R92/R96 in this compiled loop. Each is
used for all three matrices. Forty-eight half2 accumulator pairs remain live
across the K loop: **96 raw accumulator words**. This is an M64 traversal,
not an M16-at-a-time traversal. Normalization follows the full loop.

This is the exact ordinary FP8 symbol
`cc_tinlayout_fused_swin_8h_256_8_fp8` in pinned SM120
`module_3.cubin` SHA256
`46ad7753bfb3a70a92a3524a5e638bb2fe93edb37cf3389ad1fa524e4e19b084`.
Its resource usage is 166 registers/thread, 17,408 shared bytes, no stack/local
storage. The matching SASS and PTX identities are recorded in
[the vector-cache proposal](c256-vector-weight-proposal.md).

## Three possible tile sizes

Our current Q, K, and V routines each process M64 independently. This keeps
32 raw accumulator words live for one matrix, but rereads the A fragments
three times. Once all three routines finish, their published outputs occupy
48 words per thread.

Fusing all three matrices while processing fewer M16 tiles lowers the raw
accumulator requirement. It also reduces the amount of reuse available for
weights. With no extra staging, every new M tile reloads its Q/K/V weights.

The following source-level counts are **per warp for the complete C256 QKV
stage**, assuming the new vector B layout and eight K32 groups. Counts exclude
normalization/publication and are not measured traffic:

| Strategy | Raw accumulator words | Previously published QKV words at last tile | Vector weight loads | Shared A loads | QMMAs |
|---|---:|---:|---:|---:|---:|
| Existing separate Q/K/V, M64 each | 32 | Up to 32 from earlier matrices | 48 | 96 | 384 |
| Fused M16 | 24 | 36 | 192 | 32 | 384 |
| Fused M32 | 48 | 24 | 96 | 32 | 384 |
| Fused M64, like original | 96 | 0 before publication | 48 | 32 | 384 |

The published column is not a register-allocation prediction. For example,
M16 needs 24 current raw words plus 36 words from the three finished M16 tiles.
It therefore cannot be described as a 24-register QKV stage. The last tile's
publication gradually replaces raw accumulators with its output words.

All three fused choices remove 64 shared-load instructions per warp, or
262,144 logical shared-read bytes per CTA. M16 adds **589,824 global weight
bytes per CTA**; M32 adds 196,608; M64 adds none. For the entire block the M16
version raises useful weight reads from 622,592 to 1,212,416 bytes per CTA.
A warm L1 may absorb some repetitions, but it still has extra load instructions,
addressing, and register dependencies. In this workload, extra cached weight
traffic is a material risk, not a free way to lower accumulators.

## Sketch preserving exact arithmetic

For a chosen tile count `T=1,2,4`:

```text
for m_base in 0, T, ... < 4:
    half2 raw[T][3][4][2] = zero
    for kk in 0..7, ascending:
        for mm in 0..T-1:
            a = exchange[kk][m_base+mm][lane]
            apply four Q N8 MMAs to raw[mm][Q] with this a
            apply four K N8 MMAs to raw[mm][K] with this a
            apply four V N8 MMAs to raw[mm][V] with this a
        # B fragments are reused across the T M16 tiles.
    for mm in 0..T-1:
        normalize_c(raw[mm][Q], head_scale)
        c_to_a(raw[mm][Q], q[m_base+mm])
        normalize_c(raw[mm][K], 1)
        c_to_a(raw[mm][K], k[m_base+mm])
        for col in 0..3:
            pair = pack_pair(raw[mm][V][col][0])
                 | (pack_pair(raw[mm][V][col][1]) << 16)
            v[m_base+mm][col] = transpose_v(pair)
```

Actual implementation must load each of the three B groups once per K32 and
reuse it across all T M tiles. A careless source loop nest can duplicate those
loads. Compiled SASS is the check.

For each Q/K/V accumulator this executes the same ordered K32 instructions
with identical A/B bytes and an identical zero seed. Only independent
accumulators are interleaved. `normalize_c`, `c_to_a`, and `transpose_v`
already operate on one M16 tile, so completing one tile before the next does
not require a new reduction or cross-tile synchronization. All 32 lanes still
participate in the shuffles. Shared FFN storage remains intact until the
existing B6/B7 transition.

## Register-lifetime risks

The raw accumulators are only part of the working set. The kernel also retains
16 FFN skip words across QKV and attention, three weight pointer bases, shared
addresses, output locations/scalars, and the previously published QKV tiles.
A straightforward fused implementation may keep 24 B words plus several A
fragments live together. Unrolling all eight K steps can further prefetch
future A/B fragments and trigger spills.

M64 is closest to the original's reuse pattern, but the original also has
different physical input, rotated channel layout, and loop scheduling.
Its 166-register result is evidence of feasibility for its own implementation,
not proof our canonical implementation will compile to that number.

M16 looks attractive if considering only its 24 raw words, but its full live set
and fourfold QKV weight reload are less attractive. M32 is an intermediate
tradeoff. None automatically crosses the roughly 128-register threshold for
two 256-thread CTAs on a 65,536-register SM, once allocation granularity and
the rest of the kernel are considered.

## Suggested decision after cache measurements

First measure the isolated vector cache and inspect its QKV SASS and NCU
source stalls. If reducing weight/address instructions already makes QKV
negligible, stop there.

If shared rereads or repeated loop work remain material, compare M64 and M32
private variants while retaining ascending K32 order and the exact publication
helpers. M16 can be a diagnostic lower-accumulator control, but should not be
the default solely on the 24-word raw count. Start with bounded K loops; inspect
register/spill use and B reuse before GPU timings.

Each variant must pass exact comparison to both the separate canonical Q/K/V
path and the composed block, real weights, all phases, offset/tail/capture
tests, sanitizer checks, and resident latency against the best vector-cache
candidate. This hypothesis does not justify changing production dispatch now.
