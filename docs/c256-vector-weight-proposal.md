# C256 vector-weight cache experiment

The first experiment changes how persistent weights are stored, so each dense
step can read its eight MMA B words with two 16-byte loads. It keeps the
existing channel order, floating-point operations, publication points, barriers,
and four scheduling/store variants. It is initially private and C256-only.

**Status:** integer mapping proof, two independent CPU reviews, and the v23
build passed. Exact SM120 SASS confirms vector weight loads. The 161 GPU tests
are collected; GPU numerical/capture/sanitizer results, timings, and roofline
measurements remain separate gates. Nothing in this proposal establishes a speedup.

## Why this is the next experiment

The v20 packed 4K network profile attributes **1,847.638 microseconds across
16 calls** to C256 whole-window blocks. Its common logical state shape is
`[1,136,240,256]`. This is operator attribution from a profiler, not a resident
CUDA-graph benchmark. The nested kernel rows must not be added to it.

The older v15 isolated C256 NCU collection reports a 136.704-microsecond cold
kernel, 38.33% tensor activity, 66.63% L2 throughput, 4.05% DRAM activity,
16.71% achieved occupancy, and 205,344 register-spill instructions.
L2 hit rate was 92.56%. These counters support examining cached-load and
instruction cost; they do not prove that this new cache will remove the
dominant stall.

The pair-prefetch experiment already tried widening the scheduling window.
Its C256 results were +1.6%, -0.6%, and -2.1% against the fastest old variant
at the three anchor shapes, failing the 3% adoption gate. The new experiment
does not add another prefetch stage or fuse Q/K/V.

## What the original and custom kernels actually do

Both assign eight warps to a 64-token C256 window. A warp owns a 32-channel
expert, head, or output group. The original PTX declares a 16 KiB exchange
buffer; its pinned SM120 cubin reports 17,408 shared bytes. Our exchange buffer
is 16,384 bytes. This difference is recorded rather than assumed to be the
same allocation.

| Packed input/output, no raw output | Registers/thread | Shared bytes | Stack bytes | Spill store/load bytes |
|---|---:|---:|---:|---:|
| Original ordinary C256 FP8 cubin | 166 | 17,408 | 0 | 0 / 0 |
| Custom variant 0, baseline | 255 | 16,384 | 96 | 92 / 92 |
| Custom variant 1, rolled K | 168 | 16,384 | 0 | 0 / 0 |
| Custom variant 2, coalesced stores | 255 | 16,384 | 72 | 88 / 88 |
| Custom variant 3, rolled K and stores | 168 | 16,384 | 0 | 0 / 0 |

The custom compiler rows are from v17. Exact custom SASS was extracted from the
v19 binary, whose unchanged window implementations retain the four variants.
The source paths, exact symbols, and hashes are recorded below and in the JSON
report. A reduction from 255 to roughly 168 registers still does not give two
256-thread CTAs in a 65,536-register SM; vectorization should first be evaluated
as less load/address work, not promised as an occupancy improvement.

The original's residual dense loop at **0x2b10–0x2d00** contains 32 instructions:
two vector global loads, four shared loads, and 16 QMMAs. Our rolled counterpart
at **0xa290–0xa5a0** contains 50 instructions: eight scalar global loads, four
shared loads, and the same 16 QMMAs. The original's projection loop has the same
32-instruction form; our rolled projection is again 50 instructions.

The original expansion loops over four hidden chunks while unrolling the
eight K32 groups. Its compiled loop has 18 vector weight loads and 144 QMMAs
per hidden chunk, including contraction. It begins fetching several future
weight fragments before the first QMMA. Its W3 and projection use short K loops.
This mixture explains why simply rolling every dense operation was not the
whole answer.

The original also traverses Q/K/V together: one K32 loop has six vector weight
loads, **four shared A loads**, and 48 QMMAs. Our three independent traversals
need twelve shared A loads for the same K32 group. This is a second possible
experiment, with a different accumulator/register cost. It is deliberately
excluded from the first cache experiment so measured gains remain attributable.

Our canonical row-major storage requires eight separate addresses for one
K32 by N32 weight group. Each scalar instruction reads sixteen useful bytes
from each of eight rows, revisiting the same 32-byte sectors in later
instructions. The cache makes each lane's four adjacent B words contiguous.
This also simplifies address generation: a common base plus two offsets
replaces the scattered row/column addresses.

## The exact cache mapping

A canonical matrix is `W[N,K]`. The prepared object has two equal-size slices:

- Slice 0 is a byte-for-byte canonical snapshot for diagnostics and fallback.
- Slice 1 stores `[K/32][N/16][lane32][four uint32 words]`.
- A grouped W1 or W2 applies this mapping separately to every matrix.

For byte position `i` inside one packed matrix:

```text
lane = (i / 16) % 32
word = (i / 4) % 4
byte = i % 4
tile = i / 512

n = (tile % (N/16))*16 + lane/4 + (word/2)*8
k = (tile / (N/16))*32 + (lane%4)*4 + (word%2)*16 + byte

cache[i] = W[n,k]
```

A dense step reads two `uint4` values. Their words are exactly
`B(N0,K0), B(N0,K16), B(N8,K0), B(N8,K16)`, matching the eight original scalar
words across the two vectors. Every vector begins at an aligned 16-byte
address.

**There is no K-channel permutation.** The existing C32 rotated cache uses
a related physical format but also permutes K inside a K16 group. The wide
kernel's shared A is canonical, so applying that extra permutation would
silently change the products. The new cache explicitly omits it.

The CPU proof enumerates 389,120 source bytes, 97,280 B words, and 24,320 vector
addresses over the distinct C64/C128/C256 matrix shapes. This wider proof is
supporting evidence; the first launcher only accepts C256. An independent
review enumerated the complete actual C256 call-site set, including all eight
W1/W2 experts and the separate W3/projection operands: **622,592 bytes and
155,648 exact B words**, with a bijection, valid bounds, and 16-byte alignment.

The generator checks that the attention/publication suffix is identical after
normalizing the projection's extra N-stride template argument. The CUDA diff
changes the B loads and cache addresses, while K32 accumulation still ascends
in the same order. It adds no barrier and changes no barrier placement.

## Expected savings and their limits

For each warp's K32 by N32 group, the source-level load count is **8 to 2**.
Enumerating the lane addresses gives **64 to 32 sector requests**, counting
a sector again when a later instruction revisits it. These are request counts,
not measured L2 or DRAM bytes.

One complete C256 window has 76 such groups per warp:

| Stage | Groups per warp |
|---|---:|
| Four W1 hidden chunks | 32 |
| W2 contraction | 4 |
| W3 merge | 8 |
| Q, K, V | 24 |
| Final projection | 8 |
| Total | 76 |

The weight-load instruction model therefore falls from **608 to 152 per warp**,
or 456 fewer per warp and 3,648 fewer per eight-warp CTA. The useful weight bytes
are still 622,592 per CTA. Cache hit behavior, the compiler schedule, spills,
and non-dense work determine the actual time saved.

The dual cache occupies 1,245,184 bytes per C256 block. Compared with retaining
only canonical weights, this adds 622,592 bytes per block, or 9.5 MiB over
sixteen blocks if the prepared representation replaces the original allocation.
The benchmark retains both representations to compare them fairly. The cache
is a snapshot; later changes to source weights require preparing it again.
Training remains on the existing training entry point.

## Private interface and correctness gates

The draft adds these private operators:

```text
_prepare_window_vector_weight(weight) -> dual_cache
_inference_window_block_vector_weight(
    state, w1_cache, w2_cache, w3_cache, qkv_cache, projection_cache,
    ffn_scale, attention_scale, head_scale, bias,
    phase=0, packed_output=True, raw_output=False, variant=0
) -> (published, raw)
```

Variants 0/1/2/3 preserve baseline scheduling, rolled K, coalesced output stores,
and both, respectively. The first launcher accepts C256 and FP8 computation on
SM89+, with either half or packed activation storage. All five weights must
use the documented dual shape. It validates shapes/devices/dtypes, clones
misaligned inputs on the current stream, and returns the existing output
contracts. A half activation input here still uses FP8 computation; this does
not replace the FP16 network path.

The 161 focused tests cover all four phases, shifted tails, batch two,
all supported output modes, canonical and packed inputs, real blocks 15/49,
signed/very small/finite-code inputs, residual-only paths, all byte codes in
the weight cache, grouped boundaries, misaligned and noncontiguous inputs,
immutable inputs, preparation snapshots, preparation captured with mutable
sources, and inference capture replay with mutated state/scales/weight caches.
The original separately composed operations and retained canonical kernel
are independent oracles. A public dispatcher is not used as the only oracle.

Pending GPU gates are exact tests, memcheck/racecheck/synccheck where applicable,
compiler-resource/SASS inspection, and resident graph timing at all requested
contracts. The SASS check must confirm two 128-bit B loads actually survive
compilation; source `uint4` alone is insufficient evidence.

## Benchmark and adoption rule

`tests/benchmark_window_vector_weight.py.draft` prepares weights before
resident timing and reports the preparation event sample and persistent cache
bytes separately. It compares each cache candidate against **all four**
canonical variants and reports gain against the fastest one. The preparation
sample is one setup measurement, not a statistically robust latency estimate.

Default cases are real blocks 15/49 at 48x84, 72x120, and 136x240. CLI flags
cover half input/output, raw output, phase, and batch. Each resident comparison
uses matching logical I/O, distinct retained outputs, repeated graph timing,
bitwise checks, and input immutability checks. The candidate must exceed the
best canonical alternative by at least 3% before broader tuning is justified.
The original native cubin comparison is an additional gate, not implied by
beating the canonical implementation.

The original-kernel helper now exposes an explicit private cache comparison:

```powershell
.venv\Scripts\python.exe tools/vendor_window_benchmark.py --execute --channels 256 --expert-window --vector-weights --expert-variant 3 --matched-physical-io --height 136 --width 240 --phases 0 1 2 3 --timing --output outputs/vendor_window_vector_weights.json
```

This is an available command, not a recorded result. Cache preparation occurs
once per block before every case and timing. The report records the private
operator, variant, preparation operator, and active source hashes. It compares
all original published bytes, preserves original allocation guards and immutable
payload checks, verifies the prepared caches remain unchanged, and checks three
retained candidate graph replays. With matched physical I/O, the candidate's
gather/scatter adapters stay inside its timing. Without the new flag, the old
native helper behavior and report schema are unchanged. CPU checks passed:
23 tests plus seven subtests; no GPU execution was performed for this helper
change.

If this isolated cache wins, the next work is fresh original-kernel proof,
C64/C128 validation, and continuous-resolution policy evidence. Production
dispatch and automatic weight preparation should change only after those
contracts are measured and their policy keys are recorded.


## v23 compiled result: vector loads confirmed

The isolated candidate compiled successfully in v23. The stable binary is
`outputs/binaries/v23/_C.cp311-win_amd64.pyd`, SHA256
`06c3ad6f0c7f297dd7685d58d902a6b628fb3fa3df20f4383026ad51cabb4923`.
This is compile/SASS evidence only; it is not a timing result.

| SM120 packed input/output, no raw output | Registers/thread | Shared bytes | Stack bytes | Spill store/load bytes |
|---|---:|---:|---:|---:|
| Cache variant 0, unrolled | 255 | 16,384 | 136 | 132 / 132 |
| Cache variant 1, rolled K | 168 | 16,384 | 0 | 0 / 0 |
| Cache variant 2, unrolled plus stores | 255 | 16,384 | 144 | 140 / 140 |
| Cache variant 3, rolled K plus stores | 168 | 16,384 | 0 | 0 / 0 |

The rolled candidates retain the old 168-register, no-spill resource shape.
The unrolled candidates worsen spilling: variant 0 rises from 92 to 132 bytes
each way, and variant 2 from 88 to 140. Fewer global weight instructions
therefore do not guarantee that either unrolled candidate will win.

Exact SM120 SASS confirms that each of the nine rolled dense loops now contains
**two `LDG.E.128`**, four `LDS.128`, and 16 QMMAs. Each loop shrinks from
49–50 instructions to 43–44. Rolled variant 1's first loop is
`0x1610–0x18b0`; combined variant 3 has the same range and instruction mix.

Its first two instructions load R8–R11 and R12–R15 using addresses separated
by 0x200 bytes. These are the adjacent N16 packed tiles. W1 advances its weight
base by **0x1000** per K32 step (`128*32`); W3/projection use **0x2000**
(`256*32`); Q/K/V use **0x6000** (`768*32`). The shared A address advances
by **0x800**, preserving the existing exchange layout. Q/K/V retain two
separate pointer advances per step; the compiler has not combined all address
work into a single pointer.

| Exact whole-symbol static count | Old rolled 1 | Cache rolled 1 | Old combined 3 | Cache combined 3 |
|---|---:|---:|---:|---:|
| All instructions | 5,824 | 5,712 | 5,904 | 5,792 |
| Scalar 32-bit global loads | 192 | 88 | 192 | 88 |
| 128-bit global loads | 0 | 26 | 0 | 26 |
| 128-bit shared loads | 36 | 36 | 36 | 36 |
| QMMAs | 272 | 272 | 272 | 272 |
| Local loads/stores | 0 / 0 | 0 / 0 | 0 / 0 | 0 / 0 |

These are static counts. Nine K loops execute eight times each; the four
contraction chunks are outside those loops. The resulting weight-load count
matches the source model: 608 scalar instructions become 152 vector
instructions per warp. The unrolled symbols directly contain all 152
`LDG.E.128` instructions and retain their 1,280 static QMMAs.

The scheduling limitations remain visible: every rolled dense loop still
contains sixteen explicit NOPs, one after each QMMA. This was already present
in the old canonical rolled implementation. The original cubin's 32-instruction
residual/projection loops contain no explicit NOPs and carry different
scheduling controls. Static instruction counts cannot establish issue timing
or stall duration; fresh NCU evidence is needed before changing scheduling.

The reproducible CPU disassembler is
`tools/analyze_window_vector_weight_v23.py`. It validates the stable binary
hash before extracting the four exact symbols. Its report,
`outputs/window_vector_weight_v23_sass_analysis.json`, includes old/new
disassembly hashes, complete dense-loop instruction lists, and the corresponding
v23 resource records. No GPU context or kernel is launched.

Rolled and combined symbols:

```text
_ZN6dlssnr26window_block_vector_weight33window_block_vector_weight_kernelILi256ELb1ELb1ELb0ELb1ELb0EEEvPKvPKhS5_S5_S5_S5_PKN3c104HalfES9_S9_S9_PvPS7_iiiiii
_ZN6dlssnr26window_block_vector_weight33window_block_vector_weight_kernelILi256ELb1ELb1ELb0ELb1ELb1EEEvPKvPKhS5_S5_S5_S5_PKN3c104HalfES9_S9_S9_PvPS7_iiiiii
```

Their files and SHA256 identities are:

```text
outputs/window_vector_weight_v23_sass/c256_cache_1.sass.txt
44321bd3bd5ae85cb44bbccf2d13a17254594d2de7c104662d16f0628f9ddb71
outputs/window_vector_weight_v23_sass/c256_cache_3.sass.txt
2d79a14ea27c9a5d2057715650cdcef7810ae02e4a3bae06c5c386256149d871
```

## Evidence identity

The detailed machine-readable report is
[`outputs/c256_vector_weight_analysis.json`](../outputs/c256_vector_weight_analysis.json).
The reproducer is
[`tools/analyze_c256_vector_weight.py`](../tools/analyze_c256_vector_weight.py);
it performs no GPU work.

Original entry:

```text
cc_tinlayout_fused_swin_8h_256_8_fp8
module_3.cubin SHA256:
46ad7753bfb3a70a92a3524a5e638bb2fe93edb37cf3389ad1fa524e4e19b084
window256.ptx SHA256:
90579f51add42a8ecc06a494ad2dfdac369095a7714a5160a103bcdbe4694eff
outputs/c256_native_original.sass.txt SHA256:
6a98a69ffbd12a7478e28d4b7cc33fb0c33b497ea63e65c0615184aef61911df
outputs/c256_native_original.resources.txt SHA256:
db8f6aadfa201dd6bd33a85e413abb00a2ec0d76a95f88cea753dd3e708abbb0
```

Custom SASS binary SHA256:
`d28b19f8cb15e612d716ca6ebd721962c65772efe3b89780e5132156c3693acd`.

Exact custom packed/no-raw symbols:

```text
variant 0:
_ZN6dlssnr20window_block_experts27window_block_experts_kernelILi256ELb1ELb1ELb0ELb0ELb0EEEvPKvPKhS5_S5_S5_S5_PKN3c104HalfES9_S9_S9_PvPS7_iiiiii
variant 1:
_ZN6dlssnr20window_block_experts27window_block_experts_kernelILi256ELb1ELb1ELb0ELb1ELb0EEEvPKvPKhS5_S5_S5_S5_PKN3c104HalfES9_S9_S9_PvPS7_iiiiii
variant 2:
_ZN6dlssnr20window_block_experts27window_block_experts_kernelILi256ELb1ELb1ELb0ELb0ELb1EEEvPKvPKhS5_S5_S5_S5_PKN3c104HalfES9_S9_S9_PvPS7_iiiiii
variant 3:
_ZN6dlssnr20window_block_experts27window_block_experts_kernelILi256ELb1ELb1ELb0ELb1ELb1EEEvPKvPKhS5_S5_S5_S5_PKN3c104HalfES9_S9_S9_PvPS7_iiiiii
```

Their SASS SHA256 values, respectively:

```text
e4b29b5fd8d1ab78a9746c3f3c7b307ba580af0b457e306543e5e361a7cc6c53
b41ea6a68a5d7b7ea8188c74c5ef823d614c38fb8ba0276d4405b0f6af76f593
5623a177035cbc086ab74ec7b9a1884e63b00f87e62fe897cec9ab6a3395d2c4
abe3da7c1e67755b0ba638aad3425b0060a68c4f350a22aadf6c2647c1aa5b74
```

The four files are in
`outputs/window_pair_prefetch_v19_analysis_sass/c256_{0,1,2,3}.sass.txt`.
The v17 compiler resource report is
`outputs/window_variants_v17_resources.json`; its pinned build-log SHA256 is
`bae64d6f04a114e0247cb5a971834184be52884de1d75390b7f3e74dd4515564`.

The v20 network profile is
`profile/network-fp8-packed-20261003T040126_448805Z/analysis/operators.json`,
from extension SHA256
`da62d2d5d7f966e113b26c7e3eb322e39a34b9d845b0c850e1ce00ae08ecc73c`.

Draft generation and suffix identity are recorded in
`outputs/window_vector_weight_draft.json`. The generator writes only
`.draft` files and must not be rerun while a reviewed build is in progress.
