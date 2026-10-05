# C256: one K32 step ahead with the existing weight cache

This is an isolated private experiment, compiled in the v25 candidate binary.
The weight-cache preparation API and public selection remain unchanged. The
original staged sources end in `.draft`. The compiled SASS audit below is
CPU-only; no GPU validation or speed claim accompanies it.

## The observed stall

The existing cache variant 3 was profiled on the real block 15 weights, phase 1,
with a 136×240 field and packed input/output, without a raw side output. Its
full/source reports are in
[`window-vector-weights-fp8-b15-136x240-p1-v3`](../profile/window-vector-weights-fp8-b15-136x240-p1-v3-20261003T050345_438229Z/REPORT.md).
The unchanged original kernel was profiled at the same block/field/phase in
[`vendor-window-c256-136x240-phase1-block15`](../profile/vendor-window-c256-136x240-phase1-block15-20261003T050414_453788Z/REPORT.md).

| NCU observation | Cached variant 3 | Original kernel |
|---|---:|---:|
| Profiled duration | 122.688 µs | 94.336 µs |
| Registers per thread | 168 | 166 |
| Active warp percentage | 16.60% | 16.73% |
| Tensor pipe elapsed utilization | 40.96% | 59.53% |
| L2 throughput | 35.39% | 46.51% |
| Global-load L1 hit rate | 17.07% | 1.56% |
| L2 read hit rate | 97.62% | 97.61% |

The cached kernel has **7,098 long-scoreboard samples** in the saved source
report. Its scalar metric, per-PC instance sum and hotspot sum agree. Several
large hotspots map to the first dependent MMA in `dense32_step`, source line
78. One example has 690 samples at PC `0x1201546910`:

```text
0x1201546860  LDG.E.128 R32, [weight B0]
0x1201546870  LDG.E.128 R36, [weight B1]
               four LDS.128 loads and address updates
0x1201546910  QMMA ... R40, R32, ...
```

This supports testing a longer interval between global B loads and their use.
It does not establish that the L1 hit rate is the problem: the faster original
has a much lower L1 hit rate, and both kernels already have similar L2 hit
rates. Shared loads are visible in this interval, but this experiment does
not change them. NCU stall attribution identifies the dependent instruction;
it does not by itself prove that a particular source rewrite will help.

## The single change

The candidate preserves the existing canonical cache layout:
`[K/32][N/16][lane32][four words]`. Each K32 B fragment needs two aligned
128-bit loads per lane. It is still consumed by four M16 groups and four N8
fragments, for 16 MMAs in the current K32 iteration.

```text
current_B = load_B(K0)
for kk = 0..7:                 # rolled outer loop
    if kk < 7:
        next_B = load_B(kk+1)  # eight words; separate registers
    for m = 0..3:
        A = shared_A(kk, m)    # same shared address and read order
        for col = 0..3:
            output[m,col] = MMA(A, current_B[col], output[m,col])
    if kk < 7:
        current_B = next_B
```

The first iteration has a prologue load; the last has no out-of-range prefetch.
Every later B fragment can be in flight during the preceding 16 MMAs. The
source holds at most 16 B words instead of eight. The A temporary remains four
words in source, although the compiler may hoist multiple A loads just as it
does today. Register names and copy elimination are compiler decisions. The
source order is an experiment request, not proof of final SASS scheduling.

Only `ROLLED_K` inside `dense32` changes. The candidate instantiates C256 with
the existing variant 3 rolled loop and coalesced packed stores. W1 expansion,
W3, each separate Q/K/V projection and output projection use the new schedule.
W2 contraction does not call `dense32` and is unchanged. There is no QKV fusion,
new shared storage, extra barrier, shared-A prefetch, K reassociation, change
in rounding, or new cache-preparation routine. Half and packed inputs and an
optional raw Half side output remain supported; output publication is packed.

## Why this is different from the rejected pair experiment

The earlier pair-prefetch implementation loaded two K32 fragments from the
ordinary row-major weights, then computed both, and restarted at the next
pair. It used 16 scalar B loads per pair. The compiler retained a bounded pair
loop and used 170 registers for C256, but also hoisted four shared A fragments.
Its best improvement over the fastest existing route was only 1.64%, below
the selection threshold. See
[`window-variant-experiments.md`](window-variant-experiments.md#measured-result-keep-pair-prefetch-private).

The new experiment uses four vector loads across two steps, rather than those
16 scalar loads. It advances a rolling one-step pipeline: K2 starts loading
while K1 computes, K3 while K2 computes, and so on. It therefore avoids the
old pair boundary's fresh load/load/compute/compute start. It also starts from
the current coalesced-store variant 3. These changes make it a distinct
hypothesis; they do not invalidate the earlier negative result or predict a win.

## CPU proof and isolated files

[`draft_window_vector_prefetch.py`](../tools/draft_window_vector_prefetch.py)
derives the draft from the current cache kernel and checks exact replacement
counts. Undoing the one loop rewrite and namespace rename leaves every
executable source token identical. All seven shared-memory epoch barriers and
the complete attention/publication suffix remain unchanged.

[`window_vector_prefetch_proof.py`](../tools/window_vector_prefetch_proof.py)
enumerates W1, W3, QKV and output-projection groups/rows/lanes. It verifies
589,824 cache bytes, 147,456 B words, 294,912 per-lane MMA events, and 73,728
aligned shared A reads. Each byte maps to the same original matrix coordinate;
all vector addresses are 16-byte aligned and in bounds. Every accumulator
retains ascending K order, each B step loads once, and the final iteration
cannot read K8. W2's 32,768 cache bytes are unchanged and excluded from these
modified-dense counts. The report also pins the existing NCU evidence hashes:
[`window_vector_prefetch_cpu_proof.json`](../outputs/window_vector_prefetch_cpu_proof.json).

The private files are:

- `csrc/kernel_impl/window_block_vector_prefetch.cuh.draft`
- `csrc/kernel_launcher/window_block_vector_prefetch.cu.draft`
- `csrc/torch_api/window_block_vector_prefetch.cpp.draft`
- `tests/test_window_vector_prefetch.py.draft`
- `tests/benchmark_window_vector_prefetch.py.draft`

The API is `_inference_window_block_vector_prefetch`, using the existing dual
cache inputs and `_prepare_window_vector_weight`. The baseline private APIs
are unchanged. The launcher copies their validated shapes, current stream and
device guard, alignment repair, empty-batch handling, and no-autograd contract.

## Gates before considering selection

The private v25 build passed the initial SASS inspection described below.
Correctness and timing gates remain before any public selection.

The draft tests compare with independent composition, all four old canonical
variants, all four cache variants, and the earlier pair prefetch. They cover
phase shifts, ragged fields, batch 2, Half/packed inputs, raw/no-raw outputs,
checkpoint weights, offset/noncontiguous caches, poisoned graph replay,
mutation of state/scales/QKV caches, immutable inputs, and invalid contracts.
Run correctness and sanitizer gates before timing.

The benchmark uses the same retained logical outputs and graph call count for
every competitor. Cache preparation is outside resident timing. Candidate order
is deterministically shuffled from the recorded seed, and `--reverse` reverses
that order for confirmation. Selection needs more than a 3% improvement over
the fastest **existing** route, including cache variant 3, not merely the
original canonical baseline. If it passes, collect fresh source/full NCU and
bounded original-kernel parity/timing evidence before public promotion. The
85% roofline requirement remains a separate gate.

## Compiled v25 SASS: the lookahead survives

[`analyze_window_vector_prefetch.py`](../tools/analyze_window_vector_prefetch.py)
inspects the exact SM120 C256 symbol with packed input, packed output and no
raw side output. Its reproducible CPU report pins both SASS files, the resource
dump and the candidate binary:
[`window_vector_prefetch_v25_analysis.json`](../outputs/window_vector_prefetch_v25_analysis.json).
The binary SHA256 is
`1d8e1385d1b53b5d4f6662150a8dfec17cbcc45802ef6047e86b6531e4a9ccfb`.

Every one of the nine modified dense loops has two predicated next-B vector
loads before the current 16 MMAs. Eight predicated register copies after the
MMAs carry those words into the current-B registers. The first loop makes the
separation visible:

```text
0x14a0 / 0x14b0  load K0 into R20..R23 / R16..R19 (prologue)
0x1650 / 0x1660  load next K into R56..R59 / R4..R7
0x16e0..0x18c0   16 QMMAs consume the current R20/R22/R16/R18 pairs
0x18d0..0x1940   copy next into current after those MMAs
0x1950           branch to the next iteration
```

The compiled loop count is eight, with both lookahead loads and carry copies
disabled on the final iteration. The baseline cache variant 3 instead loads
the current B values inside the loop immediately before shared-A loads and
their dependent MMAs. Both kernels hoist four `LDS.128` A fragments before
the first MMA; the source's four-word A temporary does not imply four live
A registers.

The candidate uses **162 registers, 17,408 bytes of shared memory and zero
local/stack bytes**. It has 5,992 static instructions versus 5,792 in the
baseline. Static vector loads increase from 26 to 44 because each dense loop
gains a prologue, but dynamic B traffic is unchanged: each loop performs two
prologue loads plus seven pairs of lookahead loads instead of eight pairs of
current loads. Both execute 152 B vector-load instructions and 1,280 MMAs per
warp/window over the whole kernel.

The cost is 504 enabled scalar carry moves across the nine dense loops, plus
larger code. These can offset the added latency overlap. Compiled scheduling
and no spills establish that the experiment is ready to measure; they do not
establish a performance improvement.
