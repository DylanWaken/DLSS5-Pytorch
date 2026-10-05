# C256 cache hints: correct placement, slower execution

Neither cache hint improves the winning rolling-prefetch C256 kernel. L1 is
**10.48–17.86% slower** and L2 is **10.57–17.76% slower** across the twelve
measurement records. These are six distinct block/shape contracts, each run
in two measurement orders. Both variants remain private experiments; none
passes the 3% improvement screen against rolling.

The [first-order report](../outputs/window_cache_hint_v29.json) and
[reversed-order report](../outputs/window_cache_hint_v29_reverse.json) measure
blocks 15 and 49, batch 1, phase 1, packed FP8 input/output and no raw half
side output. Weights and their prepared cache are resident. Each record uses
eleven rounds, thirty distinct-output calls per captured graph and three
warmups. The second report reverses each round's seeded path order. This
compares resident logical kernels; cache preparation, physical-layout
conversion and the original DLL are outside this timing contract.

Median time per call, in microseconds:

| Order | Block | Field H×W | Rolling | L1 hint | L2 hint | L1 slower | L2 slower |
|---|---:|---:|---:|---:|---:|---:|---:|
| First | 15 | 48×84 | 23.154 | 27.191 | 27.178 | 17.44% | 17.38% |
| First | 15 | 72×120 | 27.311 | 30.653 | 30.601 | 12.24% | 12.04% |
| First | 15 | 136×240 | 80.132 | 88.528 | 88.603 | 10.48% | 10.57% |
| First | 49 | 48×84 | 23.216 | 27.362 | 27.318 | 17.86% | 17.67% |
| First | 49 | 72×120 | 27.345 | 30.785 | 30.864 | 12.58% | 12.87% |
| First | 49 | 136×240 | 81.077 | 89.902 | 89.809 | 10.88% | 10.77% |
| Reversed | 15 | 48×84 | 23.180 | 27.242 | 27.201 | 17.52% | 17.35% |
| Reversed | 15 | 72×120 | 26.354 | 29.863 | 29.911 | 13.32% | 13.50% |
| Reversed | 15 | 136×240 | 78.373 | 87.778 | 87.785 | 12.00% | 12.01% |
| Reversed | 49 | 48×84 | 23.140 | 27.251 | 27.249 | 17.77% | 17.76% |
| Reversed | 49 | 72×120 | 26.217 | 29.291 | 29.297 | 11.73% | 11.75% |
| Reversed | 49 | 136×240 | 78.386 | 86.996 | 86.989 | 10.98% | 10.97% |

All 36 path/record results are bit-exact with immutable inputs, and all 108
poisoned-output replay checks pass. Each hint loses 131 of 132 paired samples;
one slow rolling sample in the first block-49 medium-shape run gives both
hints an individual win. That sample is retained. Recomputed medians and
paired ratios agree with the saved reports. Other incumbents were not timed
in this screen, so the all-incumbent gate remains `null`, not passed.

The [compiled-code audit](../profile/cache-hint-sass-v29-cpu/REPORT.md) rules
out a simple compiler-elimination explanation. L1 retains `CCTL.E.PF1` and
L2 retains `CCTL.E.PF2`. In all nine dense loops, a hint addresses the next
iteration's demand load, with sixteen current-iteration QMMAs between them.
K6/K7 issue no hints, and the final iteration issues no out-of-bounds demand.
The compiler preserved the intended earlier request. This does not establish
when the data reaches either cache.

There is also a concrete cost. Both hint kernels use 168 registers versus
rolling's 162, and grow from 5,992 to 6,128 static instructions. Only eighteen
of those additional sites are hints; the rest is a net increase in address
and control work. V's loop grows from 54 to 98 instruction slots. Executed
hint traffic adds 108 CCTL instructions per warp/window. Demand-load count,
QMMA count, barriers and B carry operations remain unchanged; no stack,
local-memory traffic or spills appear. All 6,128 L1/L2 instruction texts are
identical except their eighteen PF1/PF2 substitutions. Registers alone do
not establish an occupancy change.

The likely explanation is that the added address/control work and cache
requests cost more than any latency they save. L1 and L2 medians differ by
at most 0.256%, consistent with their common instruction overhead dominating
the result. That is an interpretation, not a measured attribution. The
[earlier rolling profile](../profile/window-vector-prefetch-fp8-b15-136x240-p1-v3-20261003T062752_050764Z/ANALYSIS.md)
already had 97.61% L2 read hits and long dependencies at the first B carry
consumer. L2 hits still have latency, and a cache hint neither removes that
consumer nor guarantees a completed fill. There are no NCU profiles of these
hint variants, so this result cannot establish unchanged hit rates, cache
pollution or a specific stall reduction. It establishes a repeatable net
regression with correctly retained hints.

A small next experiment is to peel the final K32 step from rolling: run K0–K6
with an unconditional next-B load and carry, then compute K7 separately with
neither. The saved rolling loop at PCs `0x1610–0x1950` has three predicate
tests, two counter updates and predicated next loads/carries in its body.
Peeling could simplify that control while preserving the successful one-step
lookahead, ascending MMA order and all data traffic. It would not remove the
measured B latency. Rolling already advances A/B pointers incrementally, so
generic address hoisting is not a new opportunity here. Additional static
MMA code, scheduling changes or register growth could outweigh any savings.
This is a proposal only: first require simpler compiled control, unchanged
load counts and no spills, then numerical, sanitizer and paired timing gates.

The CPU-derived [summary](../outputs/window_cache_hint_v29_summary.json)
records every table value and identity check. Both measurements use SM120
RTX PRO 6000 Blackwell GPU `GPU-4f3e5e0b-5405-012c-ee8d-2c9a8126d693`, binary
SHA256 `54efa3f7bfe3410d3c2320b6494f50262cbb0dd60ae0a5579dabeaf0a2ea8e49`
and weight-manifest SHA256
`29642ee8acceb50e5f5506ff9168ccb9932677474e06f73a33be7a87877f7c32`.
The reports share all 144 recorded source identities. Their SHA256 hashes are
`a2200a6c97bc916cb82101156ab837c693e2e5cf60e9300981b7be255077d08d` and
`df6a4db3755682c31c432b3bbd9e59ae528df6e5541d512f78527f675efd1d2d`;
the SASS audit is
`05263b9c5984139025ea390bc94e71e91f3232b1e25ca6d7ab36477352e67616`.
No new GPU measurements were performed for this note. These rejected hints
establish neither original-DLL speed acceptance nor the 85% resource gate.
