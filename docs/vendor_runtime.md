# Original NVIDIA kernel comparison

The v16 packed candidate passes the stable chained resident trunk at all three
representative resolutions below. Each compares every byte at all 74 boundaries
on the first launch and two additional full replays; CUDA Graph outputs, guards,
immutable buffers and completion counters also pass. The original and candidate
consume/produce the same packed physical endpoints, including candidate layout
conversions and original counter resets in their respective graph timings.

| Valid resolution | Compared bytes per full check | Original | Candidate | Ratio |
| --- | ---: | ---: | ---: | ---: |
| 1280×720 | 159,989,760 | 2.184816 ms | 3.281568 ms | 1.50199× |
| 1920×1080 | 342,097,920 | 2.549904 ms | 4.885200 ms | 1.91584× |
| 3840×2160 | 1,289,994,240 | 5.998784 ms | 13.846736 ms | 2.30826× |

The report is `outputs/vendor_trunk_cached_anchors_v16.json`, SHA256
`72590dae0afbe59ed50ac3da3efcd3d0a7d7a39df7f1d178ec52316b34ab99b3`, pinned
to candidate SHA256 `f79e96c8c37698e5a6989cad8b62f62806262cbe4633ba65f58e79b144c11553`
and window policy `ea4a2ddb5f19542d`. The table uses the second, warm 720p case.
Historical v14 reports remain at
`outputs/vendor_trunk_chained_packed_{720,1080,4k}_v14.json`.
All three native-speed gates fail; the remaining 928 geometries are unmeasured.
The complete NGX host and texture-dependent pre0 remain unverified. A separate
original post70 RGB-only probe now passes at small and full fields, with its
own matched surface-output timing gate: see [endpoint results](vendor_endpoints.md).

The C64/C128/C256 whole-block implementation has a matched original
benchmark in `tests/benchmark_window_block_experts.py --native`. It includes
candidate gather/scatter layout conversions and compares the unchanged original
kernel on the same packed physical input/output. An independent pattern/view
gate is available as `tools/vendor_window_benchmark.py --expert-window`; add
`--matched-physical-io` to include those adapters in timing. The private path
uses canonical packed weights, packed output and no unused raw-half output.
Without that flag, its logical-BHWC timing is explicitly an unmatched storage
contract and cannot establish a native-speed win.

The independent private whole-window gate now passes **240 cases and
13,762,560 bytes** on v16, using six checkpoint blocks at C64/C128/C256,
all four phases, normal/input-plane/output-plane views, zero/random/high
amplitude inputs, and every finite E4 code. The original cubins are unchanged.
Reports are `outputs/vendor_window_expert_{none,input,output,finite}_v16.json`.
The field is 16×24; this result proves published output bytes, not raw-half
outputs or all-resolution speed. Guards, immutable input/weights and retained
original output are rechecked after candidate execution.
The policy-consumable aggregate is
`outputs/window_experts_native_verification_v16.json`, SHA256
`bf4dbf0400ad2d4960789c7cc404751fffea8de1147f5ea21f283fe019e89481`.
It retains every source report's path/hash and the exact scope above.
The prior v15c aggregate remains unchanged with SHA256
`a88865689def47aa027e6f0967d9bed2858a9a5eb3f6d3164c4f3f0762ee0f69`.

The v17 experimental probe accepts `--expert-window --expert-variant 1`, `2`
or `3` for rolled K32 loops, coalesced packed output stores, or both. Variant0
and an omitted variant preserve the baseline above. Use a distinct report
suffix such as `v17_variant1`; `aggregate_window_verification.py --tag
v17_variant1` combines the four corresponding reports. Variant aggregates pin
the explicit variant, extension, device, seed and compiled policy context,
require matched physical input/output and both native integrity checks, and
reject mixed or duplicate cases. Existing baseline aggregates remain unchanged.

On v17, **all four implementations pass the same 240-case/13,762,560-byte
catalog independently**, including both integrity checks. The binary is
`0790676a673a9e36c88139ef804f2f7dc12504bb175fc63c5cad78fa04c9d385`.
Every aggregate below uses schema2 and pins `candidate_variant` explicitly;
the baseline was generated with `--pin-context`. These are numerical gates
for published packed outputs; no timing or raw-half claim is attached.

| Private variant | Aggregate in `outputs/` | SHA256 |
| --- | --- | --- |
| 0, baseline | `window_experts_native_verification_v17.json` | `d5a52b690b0e618f4807c49a260dcf2dab308075334d8307b6c87a00c892666a` |
| 1, rolled K | `window_experts_native_verification_v17_variant1.json` | `12656de45f2270c533648d1e40d27a1c08b8a7e5d7e8658940e460e81d486002` |
| 2, coalesced stores | `window_experts_native_verification_v17_variant2.json` | `e093a4c8dd8ba2bc94be096484abe728e5a62bea53317b1b0bed3ff1834bf7d9` |
| 3, combined | `window_experts_native_verification_v17_variant3.json` | `4b7ab5d0aebcdc19146a5ea406c9b8850cdd1c385eb81252ffb47d78c643f2a5` |

### Range execution cost, separate from kernel latency

`NativeBenchmark` already reuses the verified DLL/resource bytes, cubin bytes,
and checkpoint archive for all cases. The trunk runner additionally retains
all 69 prepared candidate blocks after its first case. Before the resource
cache change, per-geometry construction created 152 driver module objects over
seven cubins, uploaded 142 immutable weight records, and uploaded each of the
74 layout index maps again during both verification replays. These were
CPU/setup costs outside event timings.

`tools/vendor_resources.py` now owns one loaded module per cubin, cached function
bindings, guarded immutable weights and their original golden snapshots.
Case-local index maps are uploaded once and reused for every comparison.
Case cleanup closes borrowed function leases; runner cleanup synchronizes
before unloading code or releasing shared tensors. CUDA context identity is
checked when sharing a module. Outputs, scratch and completion counters remain
fresh allocations for every case and retain their original reset behavior.
Input/output allocations, initialization, all 74 first-pass comparisons, two
complete boundary replays, guards, immutable weights, and counters must retain
the same verification coverage. Five CPU lifetime/alias regressions cover
module ownership, failed binding cleanup, immutable-versus-mutable storage,
retained golden bytes after mutation, and per-case map reuse.

A second setup change now shares read-only NumPy maps by `(layout,H,W,C)`
within one case. Nodes borrow existing guarded input/skip producer allocations
at construction, before any native launch, instead of filling unused inputs
and later rewriting pointers. Each borrowed binding retains the entire owner
tensor; device, dtype, contiguity, payload pointer and minimum guarded byte
extent are checked. Outputs, counters and scratch remain independent. Five
additional CPU tests cover immutable map identity, retained producer ownership,
invalid extents/devices/borrowed outputs, encoded pointer order before launch,
and complete 71-node construction with all 75 borrowed input/skip bindings.
Both cache changes pass CUDA verification in the v16 four-case report above:
720p twice, 1080p and 4K, each retaining 74 first-pass boundaries and two full
replays. Every case reports 75 borrowed input/skip bindings and 13 immutable
maps. No guards, weights, input fixtures or completion counters changed.

The runner now records `wall_breakdown` for fixture setup, native setup,
candidate snapshot preparation, boundary verification, graph timing/recheck,
and cleanup, plus `candidate_snapshot_cache_hit`.

`outputs/vendor_trunk_warm_loop_v15c.json` validates the cache on two successive
720p cases in one runner. Both retain all 74 exact boundaries (159,989,760 bytes
per check), two full replays, guards, counters and stable graph output. Actual
cache occupancy is seven cubins, 36 function bindings and 142 guarded immutable
weight records. Runner initialization took 1.339 seconds; the first case took
9.205 seconds, including 6.476 seconds preparing candidate snapshots. The
second case took **2.454 seconds**: 1.813 seconds native setup, 0.360 seconds
verification, and 0.251 seconds graph timing/recheck. This is a measured warm
720p cost, not an all-size extrapolation. Native median remained 2.181936 ms;
candidate 4.076624 ms leaves a 1.86835× speed gap. Candidate binary SHA256 is
`ce4884e136b2520321c1a4def12444ef65284a4d97f2880e08d560dc3999d80d`.
The previously observed standalone times (approximately 9.5, 12.1 and 26.2
seconds for the three v14 anchors) include cold setup and are not warm-loop rates.

The v16 persistent runner took 1.313 seconds to initialize. Its cold 720p case
took 7.417 seconds, including 6.460 seconds preparing candidate snapshots.
The measured warm costs with both cache changes are:

| Valid resolution | Total case wall time | Native setup | Boundary verification | Graph timing/recheck |
| --- | ---: | ---: | ---: | ---: |
| 1280×720 | 0.727 s | 0.290 s | 0.190 s | 0.216 s |
| 1920×1080 | 1.116 s | 0.574 s | 0.221 s | 0.255 s |
| 3840×2160 | 3.394 s | 2.165 s | 0.482 s | 0.490 s |

All four cases, including initialization and final cleanup, took 14.092 seconds.
The same seven cubins, 36 function bindings and 142 immutable weight records
serve every case; GPU layout indices remain case-local. At 4K the 13 CPU maps
occupy 1,598,423,040 bytes and are released after that case. These are host
verification/setup costs, not candidate or original kernel event latency.
A linear planning fit against map bytes across the 931 known geometries
estimates 26.8 minutes at this run's 2 warmups, 7 repeats and batch2 settings.
That is an extrapolation from three warm anchors, not measured domain coverage.
The range command's larger default timing sample count warrants a 35–45 minute
planning budget; the full run remains on hold pending the next optimization.

The latest stable resident reference uses the DLL's unchanged **chained**
attention entry, whose internal CTA barrier prevents the observed plain-entry
buffer reuse hazard. Static DLL host disassembly confirms the selected entry's
launch dimensions and64-byte ABI. The NGX host itself is not executed.

With v13, the720p and1080p resident trunks each match all74boundaries on the
first launch and two complete verification replays. Graph replays also remain
stable. At720p,159,989,760bytes match; original2.187072ms versus candidate
5.447680ms leaves a2.49086× gap. At1080p,342,097,920bytes match; original
2.544256ms versus candidate8.614176ms leaves a3.38573× gap. These matched
physical-I/O timings include candidate conversions and native completion-buffer
resets. Candidate storage was half; texture endpoints0/70 remain excluded.
Reports: `outputs/vendor_trunk_chained_720_v13.json` and
`outputs/vendor_trunk_chained_1080_v13.json`.

The range/trunk adapter now defaults to chained attention. The original plain
entry remains available with `--native-attention plain`, retaining its explicit
inconclusive numerical gate. A frozen formerly failing fixture also passes32
chained replays, and a completed single-CTA chained racecheck reports0hazards.
See [ABI, scope, and evidence](vendor_attention_race.md). All931 geometries
have not yet been measured. The earlier results below retain their original
plain-attention scope.

The largest independent comparison now replays original resident blocks1–69.
At valid644×768, **all74 boundaries and90,980,352 bytes match exactly**.
Native median is2.05549ms versus candidate4.38525ms (2.13343×), using the same
packed physical input/output boundary and timed candidate conversions.
Guards, immutable input/weights, counters, and repeated graph output pass.
`outputs/vendor_trunk_644x768_v9.json` records the exact binary and samples.
The input is a seeded published boundary fixture; texture-dependent blocks0/70
and NGX host evaluation are excluded. Other geometries remain unverified.

A second replay at valid1280×720 includes padded C256/C512 transitions and
again matches all74 boundaries. Original2.16899ms versus candidate5.77651ms
(2.66322×) is recorded in `outputs/vendor_trunk_1280x720_v10.json`. Neither
tested geometry meets the native-speed gate.

Subsequent v11 reruns exposed an intermittent global-block mismatch. Some
fresh processes match every boundary; others first differ at global31–33.
The discrepancy is now isolated to original attention: preceding Q/K/V match,
candidate execution changes no original buffer, and replaying only original
attention gives the candidate-exact result. Racecheck reports shared-memory WAR
hazards at the native double-buffer reuse. These successful runs therefore do
not establish stable parity across all931 geometries. Larger global allocations
changed the observed behavior but are not a proven fix. Independent PTX/SASS
address enumeration for tokens1–1024 finds every attention transfer bounded
by `ceil(tokens/32)*32*1024` bytes. The original32-token allocation also passes
an uncached full-trunk Compute Sanitizer run at1280×720 with0errors and all74
boundaries/159,989,760 bytes exact (`outputs/vendor_trunk_memcheck_pad32_v11.json`
and its `.log`). The harness therefore retains32-token padding. The separate
`tools/vendor_global_stability.py` diagnostic freezes the original global31
input and completes five native replays before any candidate replay, recording
which path, if either, changes between runs. The first v12 isolated run at288
tokens passes: all seven native stage outputs for blocks31–38 remain stable
across five replays, and all eight candidate outputs match the native outputs
across five separate replays. The frozen input is unchanged. See
`outputs/vendor_global_stability_pad32_v12.json` and its explicit `.npz`
capture. This isolates one successful fixture.
`vendor_trunk.py --native-mutation-probe --no-timing`
additionally snapshots original global buffers before and after candidate
execution to test interference in the original full-trunk ordering. The later
bad first-pass capture and matching isolated replays are retained in
`outputs/vendor_trunk_mutation_repeat_v12.json`/`.npz`.
See [the native attention race evidence](vendor_attention_race.md) for exact
PCs, hashes, launch-contract limits and diagnostic reproduction. Affected range
records remain inconclusive even if a warmup passes; optional
`--diagnostic-native-timing` retains raw samples and original mismatch counts.

`tools/vendor_benchmark.py` executes the unchanged original ViT FFN expansion
kernel through the installed NVIDIA CUDA Driver API on this machine. It loads
the extracted, hash-verified `module_5.cubin`; the NGX DLL's host code is never
loaded. The candidate is our prepacked row-major
`fp8_gemm -> silu -> pack_fp8` stage.

The newer `--fused` candidate combines GEMM, activation, and FP8 publication.
All six checkpoint cases at 96, 640, and 2160 tokens matched the original byte
for byte. Block 31 CUDA-graph medians on the same device were:

| Tokens | Candidate variant | Original, µs | Fused candidate, µs | Candidate/original |
| ---: | ---: | ---: | ---: | ---: |
| 96 | 9 | 11.946 | 8.438 | 0.706 |
| 640 | 10 | 12.342 | 15.616 | 1.265 |
| 2160 | 6 | 27.133 | 42.675 | 1.573 |

Reports `outputs/vendor_ffn_fused_m96.json`, `vendor_ffn_fused_m640.json`, and
`vendor_ffn_fused_m2160.json` record the exact extension hash, explicit variant,
and samples. The fused candidate is faster for this 96-token stage; larger
stages still trail the original. The historical table below remains the
unfused starting point, not the current best implementation.

The first baseline passed **31,129,600 FP8 output bytes across 32 cases** exactly.
Cases cover original weight blocks 31 and 38, 32/33/96/128/129/640/2160 tokens,
zero inputs, signed channel impulses, and seeded random inputs at amplitudes
0.5 and 4. Input and weight buffers remained unchanged, allocation guards stayed
intact, and repeated native launches produced identical output. These results
establish this FFN stage's tested numerical equivalence on SM120. Full-network
and full NGX runtime equivalence remain separate checks.

The baseline ran on NVIDIA RTX PRO 6000 Blackwell Workstation Edition,
GPU `GPU-4f3e5e0b-5405-012c-ee8d-2c9a8126d693`, driver 610.62,
PyTorch 2.8.0+cu128. Candidate extension SHA-256 was
`4fc1daac233dfd6c14cf59b5feca8949b277a8a4e5a8b8899cfb36ca48b80152`;
compiled tuning policy was `b41a246ba02daefa`.

| Block 31 tokens | Original stage, µs | Candidate stage, µs | Candidate/original |
| ---: | ---: | ---: | ---: |
| 32 | 12.368 | 15.117 | 1.22 |
| 33 | 12.147 | 15.302 | 1.26 |
| 96 | 11.923 | 19.578 | 1.64 |
| 128 | 11.891 | 19.968 | 1.68 |
| 129 | 12.362 | 21.318 | 1.72 |
| 640 | 12.320 | 75.613 | 6.14 |
| 2160 | 26.810 | 240.189 | 8.96 |

Timing uses CUDA events around a graph containing ten stage invocations, with
20 warmups and 25 measurements for the main baseline. Both implementations
start with resident, prepacked FP8 inputs and weights and produce FP8 output.
Host transfers, packing adapters, weight extraction, and module loading are
outside the measured region. Layouts differ because each implementation uses
its own deployment layout. The candidate stage has three kernels; NVIDIA fuses
the matrix multiply, activation, and publication into one. This comparison
provides a concrete same-device stage baseline and does not measure the complete
official runtime. No roofline claim follows from these latency measurements.

Raw reports are in `outputs/vendor_ffn_baseline.json`,
`outputs/vendor_ffn_zero.json`, `outputs/vendor_ffn_impulse.json`, and
`outputs/vendor_ffn_high_amplitude.json`. Reports preserve every timing sample,
input/output hashes, binary hashes, device identity, launch shape, and integrity
checks. Future reruns record a uniquely named `.npz` capture for each output
report and case when `--save-captures` is requested.

## Reproduce

The first command performs only static asset/hash and launch-contract inspection.
The second executes the original GPU kernel and the current extension. The
existing cubin requires an SM120 GPU; run this comparison while the GPU is idle.

```powershell
.venv/Scripts/python.exe tools/vendor_benchmark.py --tokens 32 --blocks 31 --output outputs/vendor_inspection.json
.venv/Scripts/python.exe tools/vendor_benchmark.py --execute --tokens 32,33,96,128,129,640,2160 --blocks 31,38 --warmups 20 --repeats 25 --batch 10 --save-captures --output outputs/vendor_ffn_baseline.json
```

Use `--case zero`, `--case impulse`, or `--case random --amplitude 4` for the
additional probes. The seeded CPU generator advances in the requested block
and token order; preserve both lists when reproducing a report. Input/weight
uploads and vendor launches use the same Torch CUDA stream. CUDA graph timing
uses that dedicated nondefault stream, and every CUDA Driver API result is
checked. The harness verifies the original DLL and weight-resource hashes,
the cubin hash, the driver's 72-byte parameter ABI, and equality between the
model loader's packed record and the original DLL payload before launch.

CPU-only ABI/layout regression checks:

```powershell
.venv/Scripts/python.exe -m unittest discover -s tests -p test_vendor_benchmark.py -v
```

## Reviewed launch contract

The entry point is `cc_vit_1d_ffn_expand_fp8`. It accepts **one by-value 72-byte
argument**, represented by `<8Q2i`; it does not accept eight pointer arguments.

| Byte offset | Type | Value |
| ---: | --- | --- |
| 0 | u64 | Packed input pointer |
| 8 | u64 | Zero, unused in this entry |
| 16 | u64 | Packed output pointer |
| 24 | u64 | Original `block{31..38}.layer0.layer` payload pointer |
| 32–63 | four u64 | Zero, unused in this entry |
| 64 | i32 | Height, set to 1 by this stage harness |
| 68 | i32 | Width, set to token count |

Launch block is `(32,4,1)`, grid is `(32*ceil(tokens/128),1,1)`, and dynamic
shared memory is zero. Input and output allocations round token count up to
32; input uses 1024 channels and output 4096. The weight record is 4,194,320
bytes: a 4,194,304-byte packed E4M3 matrix and 16 trailing bytes. Device queries
report 139 registers/thread and 24,600 bytes of static shared storage.
`cuobjdump` reports 25,624 shared bytes for the same entry; these two reporting
values are retained separately rather than assuming their accounting matches.

The input and output fragment layouts differ. The reviewed public adapter uses
raw MMA K lane order; OpenDLSS-NR's graph channels additionally use
`packedInputIndex(K)`. Our adapter applies this permutation before placing
input bytes in the vendor layout. Omitting it compares a different matrix
product despite using the correct weight bytes. The actual WeightArchive
decoder and original weights participate in every comparison.

Launch recovery is based on the pinned primary-source
[PTX-derived FFN adapter](https://huggingface.co/inarikami/dlss5-nr-reverse-engineering/blob/2f3db2562d18f750169c85ed947dc15bffca5a3b/tools/nr_ffn_reference.py)
and checked against the locally extracted PTX parameter loads. The independent
[native comparison report](https://huggingface.co/inarikami/dlss5-nr-reverse-engineering/blob/2f3db2562d18f750169c85ed947dc15bffca5a3b/docs/nr-numerical-validation.md)
provided the initial bounded execution plan; the measurements above are new
local measurements against our extension.

## Path toward full-runtime comparison

The original QKV kernel now has an executed, guarded normalization probe and
complete-buffer checkpoint comparison:

```powershell
.venv/Scripts/python.exe tools/vendor_qkv_probe.py --execute
.venv/Scripts/python.exe tools/vendor_qkv_benchmark.py --execute
.venv/Scripts/python.exe tools/vendor_qkv_benchmark.py --execute --tokens 96 --output outputs/vendor_qkv_m96.json
.venv/Scripts/python.exe tools/vendor_qkv_benchmark.py --execute --tokens 640 --output outputs/vendor_qkv_m640.json
.venv/Scripts/python.exe tools/vendor_attention_benchmark.py --execute --qkv-report outputs/vendor_qkv_m96.json --output outputs/vendor_attention_m96.json
.venv/Scripts/python.exe tools/vendor_attention_benchmark.py --execute --qkv-report outputs/vendor_qkv_m640.json --output outputs/vendor_attention_m640.json
```

`outputs/vendor_qkv_norm_probe.json` records five synthetic onehot Q/K cases
using raw values 1/512, 1/256, 1/128, 1/64, and 1. All Q, K, and V output
histograms matched the half arithmetic oracle, all seven allocation guards
remained intact, and input/weight bytes were unchanged. Corrected deployment
`normalize32` matched every K publication. The smallest case produces K=0.25
(FP8 code 0x28), whereas normalization without the floor would produce 1.0.
This verifies the normalization floor directly; a histogram comparison does
not establish every output channel permutation or checkpoint graph parity.

The second harness independently recovered all output addresses using 15,
17, and 20 synthetic binary-coded matrices for 32, 96, and 640 tokens: each
output's nonzero pattern encodes its logical token/head/channel index. All
three output maps at each size are bijections. It then tested actual checkpoint
QKV weights for blocks 31 and 38 using zero, random amplitude 0.5, and random
amplitude 4 inputs. **All 14,155,776 Q/K/V output bytes matched** the extension's
split-512 GEMM, normalization, half query-scale, and FP8 publication pipeline.
Complete-buffer captures and layout maps are saved beside
`outputs/vendor_qkv_sm120.json`, `vendor_qkv_m96.json`, and `vendor_qkv_m640.json`.

Those exact original QKV buffers also feed a guarded original global attention
kernel. At the supported graph sizes of 96 and 640 tokens, **all 4,521,984
attention output bytes matched** the extension's score GEMM, custom exponential,
ordered half denominator reduction, FP8 weighted GEMM, and reciprocal pipeline.
Reports and captures are `outputs/vendor_attention_m96.json` and
`vendor_attention_m640.json`. This validates these boundaries and shapes;
the complete 71-block network and full NGX runtime remain unchecked.

At 32 tokens the original attention kernel deliberately loads its first
32-token V tile a second time while zero-padding K. Its denominator still
subtracts padded `exp(0)` values. The standalone diagnostic flag
`--repeat-value-tail` reproduces this path byte exactly in all six test cases
(196,608 bytes); see `outputs/vendor_attention_m32_repeat.json`. The ordinary
model starts at 96 global tokens, so this exceptional 32-token behavior remains
isolated in the diagnostic harness.

The recovered address maps are bit permutations. For physical address bit
positions 0 through 14, the destination bit positions of flattened logical
`token*1024 + head*32 + channel` are:

| Buffer | Destination bits |
| --- | --- |
| Q | 0,3,13,4,1,2,10,11,12,5,6,7,8,9,14 |
| K | 0,3,4,13,1,2,10,11,12,5,6,7,8,9,14 |
| V | 10,13,14,3,11,12,0,1,2,4,5,6,7,8,9 |

Higher address bits retain their positions for subsequent 32-token tiles;
the 96- and 640-token calibration independently verified this extension.

Original attention accepts one 64-byte `<7Q2i>` argument: Q/K/V/output pointers
at offsets 0/8/16/24, unused words at 32/40/48, and height/width at 56/60. Its
block is `(32,4,1)` and grid is `(32,ceil(tokens/256),1)`. The three inputs use
the maps above; output uses the canonical Q/input layout. No split counter or
scratch allocation is needed by this entry.

The native half squared-norm floor is **6.198883056640625e-5**, obtained by
rounding the F32 constant 6.2e-5 to half before `max.f16x2` and reciprocal square
root. The public OpenDLSS reconstruction omitted this clamp. The pinned
module 5 QKV entry has the constant at entry-relative PTX line 2279, clamps at
2290–2393 and 4386–4489, and reciprocal square roots beginning at 2423 and 4519.
The separately extracted entry has SHA-256
`3f7d95da9ff0e4e418260f65822c95dea5c1b26f90e364eca449f617da291062`.
Module 0 window attention uses the same constant at relative line 7595 and
clamps at 7606–7709; its extracted entry SHA-256 is
`521f0be8580b36987ebc824c4bed4aaefdaa169203ec262ffee9eb30645d685d`.
These are hashes of the local extracted PTX entry files, not whole modules.

The reviewed QKV ABI is one 80-byte `<9Q2i>` argument. Its pointer fields are
input, Q, K, V, weights, split counter, and scratch at offsets 0 through 48;
offsets 56 and 64 are unused in this entry; height and width are at 72 and 76.
For 32 tokens the launch is grid `(16,1,2)`, block `(32,4,1)`: 16 head pairs,
one spatial tile, and two 512-channel K splits. Each Q/K/V allocation is
32,768 bytes; scratch is 196,608 bytes, three half matrices; 16 signed counters
start at -1 before each launch. The 3,145,856-byte synthetic weight record has
32 F32 head scales followed by the packed 3072-by-1024 FP8 matrix. The driver
reports 163 registers/thread and 8,208 static shared bytes. The bounded probe
requires at least 32 SMs so every CTA can reside while the split dependency
waits, and does not generalize the launch to arbitrary workloads yet.

All five unchained global-block stage types now have reviewed adapters and
native numerical comparisons. Window block coverage is recorded below;
transition and head stages still require original launch adapters.

The executed contraction contract uses one 72-byte
`<8Q2i>` argument with input4096, skip1024, output1024, packed weight,
split-counter, and half scratch pointers at offsets 0, 8, 16, 24, 32, and 40.
Height/width remain at 64/68. The validated grid is
`(8*ceil(tokens/128),1,4)` with `(32,4,1)` threads. Four 1024-K splits perform
ordered half partial accumulation; only split zero seeds the accumulator with
the scaled residual. Counter index is `token_tile*8 + channel_tile`, starts
at -1, and must reset before each graph replay. Scratch needs
`round_up(tokens,32)*1024*2` bytes. Projection uses the same pointer structure,
output geometry, four-way split, counters, and scratch size, with 1024 input
channels and four 256-K partials. It uses layer 4 weights and its per-channel
residual multipliers; contraction uses layer 1 and four 1024-K partials.

`tools/vendor_linear_benchmark.py` executes both original stages. At 96 and
640 tokens, blocks 31 and 38, with zero, random amplitude 0.5, random amplitude
4, and residual-only cases, **all 12,058,624 output bytes matched** the
deployment GEMM/seed/publication pipeline. All six allocation guards remained
intact, input/skip/weight bytes were unchanged, and every counter completed
at partition 3. Reports and captures are `outputs/vendor_linear_m96.json`
and `outputs/vendor_linear_m640.json`.

```powershell
.venv/Scripts/python.exe tools/vendor_linear_benchmark.py --execute --tokens 96 --output outputs/vendor_linear_m96.json
.venv/Scripts/python.exe tools/vendor_linear_benchmark.py --execute --tokens 640 --output outputs/vendor_linear_m640.json
.venv/Scripts/python.exe tools/vendor_benchmark.py --execute --fused --variant 9 --tokens 96 --blocks 31,38 --output outputs/vendor_ffn_fused_m96.json
```

For Nsight Compute use `--profile-native` with `--profile-from-start off`.
The harness first checks output/guards, warms the original stage, starts CUDA
profiling, executes one original launch, synchronizes, and stops profiling.
That mode skips graph latency measurements; `--profile-native` does not change
the original kernel, arguments, or candidate parity check.

## Resident original global-block replay

`tools/vendor_global_block.py` chains the original expansion, contraction,
QKV, attention, and projection kernels entirely on the GPU, using their
original packed intermediate layouts. Each replay resets the three split-K
counter buffers before launching the five kernels. It compares the seven
published intermediate buffers and the production prepared `InferenceBlock`
entry point, checks all guards and immutable buffers, and verifies stable
repeated outputs before reporting CUDA-graph timing.

Blocks 31 and 38 at 96 and 640 tokens matched **all 15,073,280 intermediate
bytes**, including the final block output. Reports, every timing sample,
extension/policy hashes, and captures are in
`outputs/vendor_global_block_m96.json` and `vendor_global_block_m640.json`.

| Tokens | Block | Original replay, µs | Prepared block, µs | Candidate/original |
| ---: | ---: | ---: | ---: | ---: |
| 96 | 31 | 56.477 | 53.584 | 0.949 |
| 96 | 38 | 56.291 | 53.238 | 0.946 |
| 640 | 31 | 67.034 | 239.843 | 3.578 |
| 640 | 38 | 66.922 | 239.805 | 3.583 |

Both sides start with resident input and weights. The original timing includes
three counter resets and five original kernel launches; the candidate timing
calls the production prepared block and includes its intermediate operators.
The v7 repeat at 640 tokens retained all 13,107,200 exact intermediate bytes
across the same two blocks. Prepared block latency improved to **132.77 µs**;
the original replay remained **66.93 µs**, approximately a 1.98× gap. Report
`outputs/vendor_global_block_v7_m640.json` records this newer extension/policy
and all samples; the table above preserves the earlier baseline.

Input/output layout adapters, uploads, decoding, and module loading are outside
the timing region. This is an original-kernel block replay, not a timing of
the NGX DLL host/runtime. The full 71-block network is still unverified against
the original runtime, and the 640-token speed gap remains substantial.

```powershell
.venv/Scripts/python.exe tools/vendor_global_block.py --execute --tokens 96 --output outputs/vendor_global_block_m96.json
.venv/Scripts/python.exe tools/vendor_global_block.py --execute --tokens 640 --output outputs/vendor_global_block_m640.json
```

## Original window blocks

`tools/vendor_window_benchmark.py` launches the unchanged original cubins for
the complete C32, C64, C128, and C256 fused blocks. These include the FFN,
relative-position window attention, projection, and both residual paths.
For C512 this particular kernel covers QKV projection, normalization, and
window attention; the full four-stage C512 replay is recorded separately below.

Blocks 1/67, 5/63, 9/57, 15/49, and 23/40 respectively were checked with zero,
random amplitude 0.5, and random amplitude 4 inputs, all four shift phases,
and 8×8, 16×16, and 8×12 geometries. **All 360 cases and 9,904,128 output bytes
matched exactly.** Every input, weight, and output guard remained intact;
the original kernels left input and weight allocations unchanged. Reports
and raw input/output captures are `outputs/vendor_window_8.json`,
`vendor_window_16.json`, and `vendor_window_8x12.json`. They record cubin,
weight, input, extension, and tuning-policy hashes. These reports are numerical
comparisons. The harness now also accepts `--timing` to compare resident native
and prepared random-input cases through CUDA Graphs; layout adapters, uploads,
and weight preparation are excluded from those timing regions.

| Channels | Original entry suffix | Argument bytes | Threads | Grid |
| ---: | --- | ---: | --- | --- |
| 32 | `fused_swin_1h_32_1_fp8` | 96 | `(32,1,1)` | `(ceil((W+sx)/8),ceil((H+sy)/8),1)` |
| 64 | `fused_swin_2h_64_2_fp8` | 88 | `(32,2,1)` | same |
| 128 | `fused_swin_4h_128_4_fp8` | 88 | `(32,4,1)` | same |
| 256 | `fused_swin_8h_256_8_fp8` | 88 | `(32,8,1)` | same |
| 512 | `split_swin_16h_qkv_512_fp8` | 56 | `(32,4,1)` | `(ceil((W+sx)/8),ceil((H+sy)/8),4)` |

The first four entry names have prefix `cc_tinlayout_`; C512 has prefix `cc_`.
Every entry has one by-value parameter struct. Input, output, and weight
pointers occupy offsets 0, 8, and 16. For C32/C512, H, W, originX, originY
occupy offsets 24/28/32/36. For C64/C128/C256 an unused pointer at 24 moves
these four integers to 32/36/40/44. All unused bytes are zero. Shift phases
0/1/2/3 use `(sx,sy)` values `(0,0)/(4,4)/(4,0)/(0,4)` and the kernel receives
origins `(-sx,-sy)`. The C512 grid's Z axis selects four groups of four heads.

Packed images consist of consecutive 4×4 pixel tiles, in row-major tile order.
Each tile uses the independently verified 16-token/channel layout from the
global-stage adapters. `tests/test_vendor_window.py` checks parameter sizes,
reserved bytes, shifted launch coverage, layout bijections, and rejection of
unreviewed geometries without loading CUDA. The execution harness bounds
dimensions to multiples of four from 8 through 128.

```powershell
.venv/Scripts/python.exe tools/vendor_window_benchmark.py --execute --channels 32 64 128 256 512 --phases 0 1 2 3 --output outputs/vendor_window_8.json
.venv/Scripts/python.exe tools/vendor_window_benchmark.py --execute --channels 32 64 128 256 512 --phases 0 1 2 3 --height 16 --width 16 --output outputs/vendor_window_16.json
```

The v7 complete C32 fusion was additionally compared at 128×128, blocks 1/67,
phases 0/1, and the three input patterns. **All 12 cases and 6,291,456 bytes
matched** the original. Random-input resident CUDA Graph medians were:

| Block | Phase | Original, µs | Fused prepared block, µs |
| ---: | ---: | ---: | ---: |
| 1 | 0 | 5.152 | 13.539 |
| 1 | 1 | 4.790 | 12.976 |
| 67 | 0 | 4.774 | 14.390 |
| 67 | 1 | 4.522 | 13.357 |

The mathematical published output is byte-exact for these captures, but the
storage contracts differ. The native entry reads a packed FP8 image and writes
one packed FP8 output. The prepared entry reads a half working tensor and
returns both a half tensor containing published values and a raw half tensor.
At this geometry native output storage is 0.5 MiB; candidate output storage is
two 1 MiB tensors. The tested skip aliases the working input. Both begin with
their respective layouts resident; conversion is excluded. Consequently the
2.6–3.0× timing gap measures these actual entry contracts, not identical byte
traffic. The report `outputs/vendor_window_c32_v7_128.json` contains version
hashes and samples; these measurements establish neither full-network speed
nor an 85% roofline target.

## Complete C512 window replay

`tools/vendor_window512_block.py` chains four unchanged original entries from
module 4: `cc_split_swin_16h_ffwd_512_fp8`,
`cc_split_swin_16h_ffwd_proj_512_fp8`,
`cc_split_swin_16h_qkv_512_fp8`, and `cc_split_swin_16h_proj_512_fp8`.
This covers the initial projection, eight FFN branches, contraction with
residual, QKV/window attention, and final projection with residual.

At 16×16, blocks 23 and 40, all four phases, and zero/random amplitude 0.5/
random amplitude 4 inputs, **all 24 cases and 12,582,912 intermediate bytes
matched exactly**. The four boundaries are the concatenated FFN branches,
published FFN result, published attention result, and final block result.
The production prepared block entry matched its separately evaluated stages.
Identical native replays produced identical intermediates, all guards stayed
intact, and every input/weight byte remained unchanged. The report and captures
are `outputs/vendor_window512_block_16.json`. An additional initial 8×8
block-23 phase-zero probe is `outputs/vendor_window512_block_probe.json`.

| Stage | Argument bytes | Threads | Grid |
| --- | ---: | --- | --- |
| FFN branches | 56 | `(32,8,1)` | `(ceil(W/8),ceil(H/8),2)` |
| FFN projection | 72 | `(32,4,1)` | `(2*ceil(W/8),ceil(H/8),1)` |
| QKV/attention | 56 | `(32,4,1)` | shifted window grid above, Z=4 |
| Output projection | 72 | `(32,8,1)` | `(2*ceil(W/8),ceil(H/8),1)` |

The 56-byte FFN branch struct contains input/output/weight pointers at 0/8/16
and H/W at 24/28; unused bytes are zero. Both 72-byte projection structs contain
input/skip/output/weight pointers at 0/8/16/24 and H/W at 32/36. They do not
use global split counters. Every intermediate image uses the same packed
4×4 spatial-tile layout. The original kernels consume layers 0/1/2/3 in order.

```powershell
.venv/Scripts/python.exe tools/vendor_window512_block.py --execute --phases 0 1 2 3 --height 16 --width 16 --output outputs/vendor_window512_block_16.json
```

## Original encoder transitions

`tools/vendor_downsample_probe.py` invokes the `_ds_fp8` variants of the C32,
C64, C128, and C256 fused window entries. They publish the ordinary block
output, then pool its **raw half result** with the native 2×2 addition tree,
publish that pooled result to FP8, and apply the learned down-projection.
Comparing against pooling the already-published block result would be invalid.

At 16×16 input and 8×8 output, blocks 4/8/14/22, all four phases and the three
input patterns above, **all 48 cases and 2,211,840 output bytes matched exactly**.
Both the ordinary output and the down-projected output were checked. All
allocation guards and immutable input/weight checks passed. The report and
captures are `outputs/vendor_downsample_16.json`; the initial C32 probe is
`outputs/vendor_downsample_c32_probe.json`.

Launch geometry, threads, and the initial window-argument fields match the
ordinary entries. C32 adds a down-output pointer at byte 64 and target H/W at
72/76. C64/C128/C256 use pointer 72 and target H/W 80/84. The second output is
a different view: consecutive planes of 16 channels, with pixels in raster
order and channel bytes within each plane ordered
`0,1,8,9,2,3,10,11,4,5,12,13,6,7,14,15`.
The mapper is checked as a bijection by CPU tests and validated numerically
against original outputs. These probes intentionally cover exact halving;
additional target padding and geometries below eight output pixels remain
unverified.

```powershell
.venv/Scripts/python.exe tools/vendor_downsample_probe.py --execute --channels 32 64 128 256 --phases 0 1 2 3 --output outputs/vendor_downsample_16.json
```

## Original decoder transitions and bottleneck projection

`tools/vendor_upsample_probe.py` executes the corresponding `_upsample_fp8`
entries. It uses the plane layout for the lower-resolution input, ordinary
packed tiles for the skip, and compares projection, nearest upsampling,
residual merge, and the subsequent window block together. At 8×8→16×16,
blocks 66/62/56/48, all four phases, and zero/random/high-amplitude/skip-only
cases, **all 64 cases and 1,966,080 output bytes matched exactly**. All guards
and immutable allocations passed. The report is `outputs/vendor_upsample_16.json`.

C32 places the skip pointer at byte 80 and optional skip H/W at 88/92 in its
96-byte struct. C64/C128/C256 use byte24 for the skip pointer in their 88-byte
struct; other fields and launch shapes match the normal window kernel. C32
retains the raw merged value for its FFN residual, matching the native result.

`tools/vendor_head512_probe.py` verifies the separate original block30
512→1024 projection, named `cc_split_swin_16h_final_head_512_fp8`. The template
and weight record establish that this is the bottleneck input projection,
not the final RGBA head. At 8×8 with zero/random/high-amplitude inputs,
**all 196,608 output bytes matched**. Input and output both use spatially
tiled native storage. Its one 40-byte struct contains pointers at 0/8/16,
unused zero bytes24–31, and H/W32/36. Launch grid is
`(4*ceil(W/8),ceil(H/8),1)` with `(32,8,1)` threads. The report is
`outputs/vendor_head512_8.json`.

```powershell
.venv/Scripts/python.exe tools/vendor_upsample_probe.py --execute --channels 32 64 128 256 --phases 0 1 2 3 --output outputs/vendor_upsample_16.json
.venv/Scripts/python.exe tools/vendor_head512_probe.py --execute --output outputs/vendor_head512_8.json
```

The planned resident chain, including still-unverified padded transitions and
layout adapters, is in [vendor_trunk_plan.md](vendor_trunk_plan.md).

## Original preprocessing and final composition

The original C32 preprocessing entry is a distinct 264-byte wrapper which
reads five CUDA texture objects at offsets 0/8/16/24/32. Its postprocessing
counterpart has a 184-byte argument struct, reads additional textures, and
writes a CUDA surface through the handle at offset 16. These also perform
scene preprocessing/compositing; substituting ordinary tensor pointers is
invalid. They have been inspected statically but have not been launched by
these adapters. Full-network and rendered-image parity remain unverified.

The public
[NGX verification report](https://github.com/mochizuki0323/DLSSNR-AMD/blob/82560c4fbfaac347fc5e22c22025191402ae916b/docs/ngx-verification/NGX-VERIFICATION.md)
documents a complete DLL evaluation path using D3D12/NGX initialization, NR
feature creation, resource upload, evaluate, and output readback. It also
reports that older NGX cores rejected this newer feature. The small original
host programs are described but were not found in that pinned repository tree.
A full-runtime Windows host therefore still needs implementation and validation
against the installed NGX core; no compatibility checks are bypassed.

That host must time GPU evaluation with D3D12 timestamps after warmup, preserve
reset/history and all conditioning parameters, and capture unquantized outputs
before PNG conversion. Internal boundary comparison additionally needs a
reviewed capture mechanism or a complete original-kernel replay. The public
8-bit image captures alone cannot verify intermediate arithmetic.

## Original view connectors and C32 profiling

Original `_inpview_fp8` and `_outview_fp8` entries now match at 12×20,
including shifted partial windows: C32/C64/C128/C256, two checkpoint blocks,
four phases, and three patterns give **192 exact cases and5,529,600 bytes**.
Input-view reads16-channel planes and writes ordinary tiles; output-view does
the reverse. View H/W occupy72/76 in C32's96-byte struct and80/84 in the other
88-byte structs. Reports: `outputs/vendor_window_inpview_12x20.json` and
`outputs/vendor_window_outview_12x20.json`.

`tuning/profile_vendor_window.py` retains full/source NCU, available PM sampling,
SASS, unchanged pinned cubin, and parity validation. Block1, phase1 on SM120:

|Field H×W|Cold NCU µs|Tensor %|L2 %|Overall DRAM %|
|---|---:|---:|---:|---:|
|128×128|6.85|9.00|9.05|5.43|
|512×576|20.99|53.80|14.05|28.28|
|1088×1920, actual3840×2160 input|132.45|73.73|15.31|36.73|
|1088×1952 diagnostic|135.10|73.71|15.29|36.34|

The last shape combines independent axis maxima and **does not occur** in the
931-geometry domain. Actual3840×2160 input has C32 field1920×1088, now profiled
separately. These cold-cache durations differ from warmed graph timings.
The diagnostic candidate reads half input and emits raw/published half outputs;
native reads/writes packed bytes, so old stage timings have different traffic.

Reports reside at `profile/vendor-window-c32-128x128-phase1-block1-20261002T225037_496495Z`,
`profile/vendor-window-c32-512x576-phase1-block1-20261002T230020_135855Z`,
`profile/vendor-window-c32-1088x1920-phase1-block1-20261002T232210_017845Z`, and
`profile/vendor-window-c32-1088x1952-phase1-block1-20261002T230128_936953Z`.
All four validate exact published values. The original uses168 registers,
no static shared memory, one warp/window, and12 spilled bytes/thread.

At128×128,289 CTAs give0.13 waves/SM: the small grid is latency limited.
At512×576,4745 CTAs give2.10 waves/SM; registers cap occupancy at25%, with
22.16% achieved. SM active cycles span39,007–46,013 around42,053 average.
Stalled-warps-per-issue ratios are2.195 math-pipeline,1.477 long-scoreboard,
and1.367 fixed-latency wait. PM tensor activity has seven nonzero samples:
4.56,49.80,79.72,71.41,80.29,70.25,19.23%;3µs sampling limits tail precision.
L1/L2 hit rates are82.01/21.67%, with18,980 local spill requests. No shared
loads/stores or CTA barriers appear in SASS. These six dimensions support
reproducing the register dataflow and packed storage first, then measuring
scheduling/spill improvements. None establishes the85% target.

## Resolution-domain native comparison adapter

`tools/native_benchmark.py` exposes `NativeBenchmark.benchmark_case(case)` and
`main(argv=None)`, using the same inclusive manifest as the resolution tuner.
The initial default domain has931 geometries and48,134 unique block/transition
cases plus931 complete resident-trunk cases; renderer endpoints remain explicit.

Both timed functions consume and produce the **same resident original physical
packed-byte interface**. Candidate layout, half conversion, and final packing
are timed. Every logical output byte is compared on GPU; guards, immutable
inputs/weights, split counters, and repeated outputs are checked. Only256-byte
output samples are copied for clearly labeled sample hashes; full images are
not captured by default. Original hashes, candidate binary/policies, tensor
shapes, timing samples, and candidate/native ratios are recorded.

Ratio>1 fails the selected speed gate. Missing cases remain unverified; the
whole-DLL gate stays unverified even if selected families pass. SQLite commits
each result and JSON exports are atomic. Resume pins GPU, binary, original
artifacts, candidate archive contents, helper sources, and timing settings.
Widening bounds updates current membership while retaining measurement provenance.

```powershell
.venv/Scripts/python.exe tools/native_benchmark.py --output outputs/native_range_manifest.json
.venv/Scripts/python.exe tools/native_benchmark.py --execute --families window --max-cases 10 --output outputs/native_window_range.json
.venv/Scripts/python.exe tools/native_benchmark.py --execute --families trunk --max-cases 10 --output outputs/native_trunk_range.json
```

The full trunk plan is `outputs/native_trunk_range_v16_plan.json`, generated
without GPU execution. It contains all 931 geometries for inclusive widths
1280–3840 and heights 720–2160, manifest SHA256
`815376f179aa8b31543f71fb0c61420a4edd21377eac81adf9415c61eccf32ec`.
The promoted v16 binary and cached harness are now qualified on the three
anchors above. When the full run is authorized, a bounded start and exact
resume use the same output/journal and measurement settings:

```powershell
.venv/Scripts/python.exe run_tuning.py native-range --execute --families trunk --packed-activations --max-cases 3 --output outputs/native_trunk_range_v16.json
.venv/Scripts/python.exe run_tuning.py native-range --execute --families trunk --packed-activations --output outputs/native_trunk_range_v16.json
```

The full run has not started. Do not reuse a journal after changing the
candidate binary, weights, helper source or timing settings; identity validation
rejects that combination. Each completed case survives interruption in SQLite.
All speed gaps remain in the report, and a parity/guard exception is retained
as a failure before execution stops. The 931-case selection still excludes
texture-dependent endpoints0/70 and never passes the complete-DLL gate.

Initial adapter smoke checks window/input-view, downsample, upsample, complete
C512, and global96. All five pass exact GPU comparison and all five have speed
gaps. This validates the interface, not coverage of931 geometries. Padded
transitions and global tails still restrict the adapter's executable coverage.
New connector probes establish C512 input/output views (2,949,120 bytes each),
C512 padded downsample20×36→12×20 (11,059,200 bytes), bidirectional spatial/token
repack12×12 (884,736 bytes), global144 (1,474,560 bytes), and exact decoder
1024→512 (393,216 bytes). These enable the first resident trunk replay above;
they do not automatically validate every geometry. Details and remaining padded
contracts are in [vendor_trunk_plan.md](vendor_trunk_plan.md).

## Preparation-inclusive private global comparison

The preparation-inclusive private global comparison is implemented in
`tools/vendor_global_prepacked.py`. It pairs unchanged original QKV projection
and chained attention with the candidate QKV GEMM, normalization/publication,
prepacked attention and physical-layout adapters. Both consume the same
resident packed FFN boundary and produce the same original packed attended
boundary. `--candidate scalar` and `--candidate vector` select explicit private
implementations and participate in the source identity. This is an FP8
two-stage comparison; original FP16 and complete-block/NGX behavior are outside
its scope.

The helper requires first execution plus two stable repeats for published
Q/K/V and attended bytes. A separate correctness graph poisons original
logical Q/K/V bytes, the attended output, and all named candidate intermediate
buffers after capture. Replay must reconstruct the eager result and satisfy
guards, immutable weights and completion counters. Candidate raw-half replay
consistency is recorded separately and is not called an original raw-half
comparison. Poisoning and checks remain outside the resident graph timings.

The v19 vector helper passes all 30 original comparisons: blocks31/38 at
96/144/288/640/2160 tokens, with zero, random and high-amplitude inputs.
Each complete pass compares 81,985,536 published Q/K/V and attended bytes;
the initial execution, two repeats and separate poisoned graph all pass.
This includes both32-token native and64-token candidate padding extents.
Report `outputs/vendor_global_prepacked_vector_v19.json` has SHA256
`c24d1793e35f28a9711631a53015b38cff26f950611a100e124f5a54edf694a4`.
The candidate binary is
`d28b19f8cb15e612d716ca6ebd721962c65772efe3b89780e5132156c3693acd`.

Matched QKV-plus-attention performance remains below the original. Across
random inputs the candidate/original latency ratio ranges from1.078× to2.023×;
block31 at2160 tokens measures0.137387ms versus0.067915ms. Those timings include
candidate physical input/output adapters, QKV projection and preparation, and
original completion-buffer resets. This speed gap remains separate from the
candidate-only acceleration over the previous attention implementation.

## Residual arithmetic: actual SASS takes precedence

The extracted PTX writes decoder residuals as unqualified `mul.f16x2` followed
by `add.f16x2`. Those operations are contracted in the original cubins: the
1024→512 decoder has128 `HFMA2` and no `HMUL2`; C32 upsample begins its residual
merge with `HFMA2` atPC0x1990. The deployed residual therefore requires one
half-precision fused multiply-add, not an independently rounded half product.
FP32 FMA followed by half conversion also differs at rare rounding midpoints.

Post70 first loads input_scale at0x2050 and adapter_scale at0x2090. Its
PC0x1950 `HMUL2 R50,R50,R9` rounds the scaled upsampled state; PC0x1af0
`HFMA2 R85,R85,R103,R50` then adds the adapter with one half FMA. This establishes
`half_fma(adapter,adapter_scale,half_mul(state,input_scale))`. The checkpoint
scales vary substantially and are not restricted to powers of two.

Reproduce disassembly with `cuobjdump --dump-sass --function <symbol>` on the
unchanged pinned cubin. Local decoder/C32up/post70 SASS files in
`assets/vendor_sources` have SHA-256 respectively
`db06e50cc59dfff9af2158157b61eca084ab6a135ca2b11462d1f497c71f373b`,
`12cd22d4af0e898ed8432bf8e4279a601ae556849afa54f45272fef4fcf51285`, and
`35f3a670a62917b4b24369b25cca7cfb564b1f1f4a03dfbc64d5fa700f238139`.
`tools/vendor_residual_probe.py` constructs synthetic weights that amplify the
rounding difference into distinct FP8 output bytes. All four original C32
upsample phases match the corrected v11 candidate over32,768 bytes. With
projected value2^-18, skip3.5, transition scale18.4375 and final scale1.0546875,
the original and true-half-FMA candidate publish code105 (72); the former
FP32-FMA-then-half implementation publishes code104 (64). Every legacy byte
differs. Guards and immutable inputs pass; the result is recorded in
`outputs/vendor_residual_half_fma_v11.json`.
