# Original pre/post endpoint investigation

The pinned module 0 contains original pre/post kernels; the NGX DLL host has
not been executed. These wrappers include image sampling and composition in
addition to learned layers. A successful resident blocks 1–69 comparison does
not validate those endpoints.

## Bounded post70 RGB probe

`tools/vendor_post_probe.py` directly launches the unchanged original
`cc_tinlayout_fused_post_block_swin_1h_32_fp8`. GPU validation passes all 12
cases at 16×16, plus full 1920×1152 and 3840×2176 fields. The probe compares the actual
production `inference_post70` result against original RGB output for zero,
random and larger inputs, across all four window phases.

Original host registration at RVA `0x76155`–`0x76189` passes block `(32,1,1)`.
PTX declares a 184-byte by-value parameter block. The bounded null-texture
contract is:

| Offset | Value | Evidence and use |
| --- | --- | --- |
| 0 | Half-resolution packed C32 state pointer | Read as 16-channel planes, nearest upsample inside the original kernel |
| 8 | Full-resolution packed C32 block0 output pointer | Read in the established 4×4 tile layout; this is the adapter skip |
| 16 | RGBA32F CUDA surface handle | Two `sust.p.2d.v4.b32.zero` stores per thread cover the 8×8 window |
| 24 | Original block70 layer0 weights | Pinned 21,808-byte payload includes scales, FFN, QKV, attention projection and FP16 head |
| 32,36 | Full height, width | Bounds and plane extents |
| 40,44 | Window X,Y origin | `(0,0)`, `(-4,-4)`, `(-4,0)`, `(0,-4)` |
| 48 | Float32 RGB output scale = 1 | Multiplies the three raw half head results after conversion to float32 |
| 52 | RGB conversion flag = 0 | Bypasses `clamp(8*value+0.5,0,1)`; alpha remains zero |
| 56 | Proxy texture = null | Skips addition of the centered proxy |
| 88,96 | History and motion textures = null | Skips temporal sampling/blending |
| 104 | Optional half blend-scale pointer = null | Safe explicit branch skips its load |
| 172,176 | Valid width, height | Must be positive because normalized coordinates are computed even when textures are absent |

The remaining unused texture transform fields are zero. This contract exposes
the **three raw RGB head values and constant alpha 0**, not the fourth neural
blend logit. It therefore cannot establish complete four-lane head or renderer
composition parity. Surface storage has an extra sentinel border, and all
input/weight allocations have guards and immutable-byte checks. CUDA surface
out-of-range writes have the original `.zero` behavior; a border test does not
replace Compute Sanitizer.

`tools/vendor_cuda_image.py` implements only the CUDA Driver array, surface,
texture and copy operations needed by this probe. Structure sizes/offsets are
checked against the local CUDA 13.4 `cuda.h`; it imports no Torch or CUDA until
explicit construction. No replacement CUDA source or modified PTX is used.

```powershell
.venv/Scripts/python.exe tools/vendor_post_probe.py
# Reserved GPU slot only, after candidate tests/build:
.venv/Scripts/python.exe tools/vendor_post_probe.py --execute --height 16 --width 16 --output outputs/vendor_post_probe_v14.json
```

With `--timing`, both paths consume the same original packed physical input
buffers and produce RGBA32F CUDA surfaces. Candidate layout gathers, alpha-zero
construction, and tensor-to-surface copy are inside its graph. Initialization
and verification copies are outside both timings. The graph results and surface
sentinel borders remain exact.

| Field | Original | Candidate | Candidate / original |
| --- | ---: | ---: | ---: |
| 1920×1152 (1080p padded field) | 0.117072 ms | 0.831440 ms | 7.10195× |
| 3840×2176 (4K padded field) | 0.484656 ms | 3.458192 ms | 7.13535× |

These two phase-1 cases use the pinned v14 extension. Reports are
`outputs/vendor_post_timing_1080_v14.json` and
`outputs/vendor_post_timing_4k_v14.json`; the 12-case small-field report is
`outputs/vendor_post_probe_v14.json`. Both timing gates fail. This observable
RGB endpoint contract still excludes the fourth neural logit and temporal
composition. Layout conversion is a real cost of this standalone contract;
it must not be misreported as the candidate's core-kernel time.

### Direct physical I/O candidate

The private `csrc/kernel_impl/post70_physical_io.cuh` reuses the tested rotated C32
arithmetic body and four-lane half head accumulator, replacing only its input
and output policies. Both inputs are **packed uint8 E4M3**. The low-resolution
input uses 16-channel planes; the full-resolution adapter uses 4×4 pixel tiles.
For channel `c`, scalar byte offsets are:

```text
low(y,x,c) = (((c/16)*H+y)*W+x)*16
             + ((c&7)/2)*4 + ((c&15)/8)*2 + (c&1)
t = ((y/4)*(W/4)+x/4)*16 + (y&3)*4 + (x&3)
adapter(y,x,c) = (t/16)*512 + (t&7)*64 + ((c&7)/2)*16
                  + ((c&31)/16)*8 + ((t&15)/8)*4
                  + ((c&15)/8)*2 + (c&1)
```

All divisions above are integer divisions. The low input is sampled at
`(y/2,x/2)` using its own half-resolution `H,W`. Adjacent even/odd logical
channel pairs occupy adjacent, aligned bytes. Each pair is decoded, multiplied
by the low-input scale with half rounding, and merged with the adapter using
a true half FMA before publication, matching the existing post70 arithmetic.

In each four-lane query group, lane0 holds the R/G half pair and lane1 holds
the B/blend-logit half pair. Lane0 obtains the latter with a warp shuffle and
writes `(float(R),float(G),float(B),0)` directly to the surface. CUDA C++
`surf2Dwrite` takes a **byte X coordinate**, so the address is `16*x` for RGBA32F.
The fourth neural logit remains excluded from this original observable contract.

`tools/post70_physical_layout.py` exhaustively checks both maps against the
original harness at 16×24, 32×40 and 64×80, verifies aligned pair loads, and
proves each valid surface pixel has exactly one writer in all four phases.
The record is `outputs/post70_physical_layout_cpu.json`. These are CPU address
proofs, separate from the CUDA results below. The private launcher
enforces batch1, exact 2× geometry, dimensions divisible by8, buffer lengths
and pointer alignment. The CUDA surface is borrowed: its owning array/surface
object and all tensors must remain alive until every captured graph replay
has completed. Destruction must synchronize first. The existing public BHWC
interface is unchanged.

With v15c, `--direct-physical --timing` passes exact RGB surface comparison
against both the unchanged original kernel and the public candidate head at
the two full fields. Graph replay, immutable inputs and all sentinel borders
remain exact. Reports are `outputs/vendor_post_direct_1080_v15c.json` and
`outputs/vendor_post_direct_4k_v15c.json`.

| Field | Original | Direct candidate | Candidate / original |
| --- | ---: | ---: | ---: |
| 1920×1152 | 0.114128 ms | 0.190944 ms | 1.67307× |
| 3840×2176 | 0.477824 ms | 0.866720 ms | 1.81389× |

Both paths now read the same packed physical buffers and write RGBA32F surfaces
directly. No candidate gather, alpha-fill, or tensor-to-surface copy kernel is
timed. This removes most of the earlier adaptation cost, but both speed gates
still fail. These runs compare phase1/random fixtures; the parent validation
suite separately covers all phases, edge fields, graph updates and alignment.
Candidate binary SHA256 is
`ce4884e136b2520321c1a4def12444ef65284a4d97f2880e08d560dc3999d80d`.

The endpoint probe now accepts a valid input resolution directly:

```powershell
.venv/Scripts/python.exe tools/vendor_post_probe.py --execute --direct-physical --timing --valid-width 3840 --valid-height 2160 --case random --output outputs/vendor_post_valid4k.json
```

It derives the actual 3840×2176 field and graph phase1; an explicit `--phases`
can still request additional phase diagnostics. `geometry_case` and
`geometry_cases` expose the same conversion for a future persistent range
driver. The CPU-only command `--plan-range` generated
`outputs/native_post70_range_plan.json`, containing all 931 unique fields from
the shared inclusive 1280–3840 by 720–2160 manifest, SHA256
`815376f179aa8b31543f71fb0c61420a4edd21377eac81adf9415c61eccf32ec`.
Every case is explicitly unmeasured. This parameterization has CPU coverage for
all 931 shapes; it has not launched a range sweep, measured their performance,
or expanded the observable RGB-plus-zero-alpha contract.

`tools/vendor_post_range.py` now provides the persistent range driver. It owns
one original module and immutable weight record across cases, creates each
case's surfaces and guarded buffers separately, and journals every completed
measurement with the binary, source, weights and timing identity. It compares
the full RGBA surface on the GPU on the first execution and two repeats; only
scalar counts and bounded mismatch samples leave the GPU. A separate graph
verification captures both calls, resets both surfaces **after capture**, and
then replays them, so retained eager pixels cannot mask missing graph writes.
The surface reset and verification are excluded from both timing loops.

The driver is CPU-tested. Its original plan output is
`outputs/native_post70_persistent_plan.json`; that historical plan contains
only unmeasured entries. A bounded qualification command is:

```powershell
.venv/Scripts/python.exe tools/vendor_post_range.py --execute --geometry-ids 0 --max-cases 1 --output outputs/native_post70_smoke.json
```

The complete-DLL gate remains unverified even when a selected endpoint case
passes. A ratio above one is retained as a speed gap, not discarded.

The v19 persistent smoke validates geometry0 (1344×768) and geometry930
(3904×2048) in one runner. These IDs follow the deduplicated manifest order;
geometry930 is not the valid3840×2160 anchor. Both cases pass first-plus-two
repeats, complete RGBA/alpha/border checks, guards, immutable inputs and the
separately poisoned graph replay. Report
`outputs/native_post70_persistent_smoke_v19.json` has SHA256
`aae7b5d09e36bb4befa69cfb79ab2163338fb2dff579b546b77ad15e0af70b17`.
Their candidate/original ratios are1.68195× and1.82142×. The separate
`outputs/native_post70_persistent_actual4k_v19.json` confirms the actual
3840×2176 field derived from valid3840×2160, with the same complete correctness
checks and a1.81235× speed gap. Only these three geometries have been measured
by this persistent endpoint driver; the full931 sweep remains pending.

## Original pre0 route

The direct pre entry is `cc_tinlayout_fused_pre_block_swin_1h_32_1_ds_fp8`.
Its 264-byte parameter block and original host registration at RVA
`0x61641`–`0x6169A` establish a one-warp launch. The `_ds` variant also pools
the raw block0 result for transition 0→1. The non-`_ds` entry shares the same
264-byte ABI.

Confirmed fields from static PTX:

| Offset | Role |
| --- | --- |
| 0 | Current proxy texture, required |
| 8,16,24 | History, motion and depth textures; a null history or motion handle bypasses all history sampling |
| 32 | Optional conditioning/control texture |
| 136,144,152 | Current proxy float2 offset, scale and inverse texture extent |
| 200 | Per-frame noise seed |
| 208,212 | Valid image height, width used for mirror coordinates |
| 216 | Full-resolution packed block0 output pointer |
| 224 | Original block0 weights |
| 240,244 | Full padded height, width |
| 248 | Pooled transition 0→1 output pointer in `_ds` |
| 256,260 | Pooled output extents in `_ds` |

For a bounded no-history/no-control fixture, static instruction flow gives
local tone at 172, structure at 176, normalized style at 180, forced structure
overrides at 184/188 (set both to -1), conditioning mode at 192 (set to 1),
and color scale at 196 (set to 0.0625, doubled before the half color multiply).
These interpretations still need execution validation. Its noise uses
PTX approximate log2/sqrt/sin/cos, so a CPU or ordinary Torch transcendental
substitute must not be assumed bit exact. Next steps are a constant-proxy,
no-history fixture, a separately verified 16-lane feature generator, then the
unchanged original fused pre0 comparison with the actual checkpoint. A modified
debug PTX feature capture is now prepared by `tools/vendor_pre_feature_capture.py`.
It is labeled instrumentation and excluded from every original timing baseline.
The script pins the original PTX SHA256, retains the exact texture/noise prefix,
then copies its 2,048-byte shared feature tile and returns before the network.
Its output-layout decoder has an exhaustive CPU pixel/lane mapping test.
Generated text is `assets/vendor_sources/instrumented_pre0_feature_capture.ptx`;
the adjacent JSON marks `compiled:false`, `executed:false`, and
`original_timing_baseline:false`. That historical generation manifest records
the original CPU-only stage; the execution report below records the later run.

`tools/vendor_pre_probe.py` now prepares that bounded experiment: three
constant proxy colors, two noise seeds, null history/control textures, and
first execution plus two repeats. It will launch the unchanged pre0 cubin
separately, feed the instrumented prefix's captured half features to the
private fused block0 candidate, and compare published bytes through the
original output map. The candidate raw-half result has no exposed original
counterpart. The harness collects no performance baseline and does not
establish arbitrary renderer preprocessing.

On v19 the bounded pre0 comparison passes all six16×24 phase0 packed-output
cases: three constant proxy colors and seeds0/20261003, totaling73,728 original
published bytes per pass. First execution and two repeats are exact; allocation
guards, original/candidate weights and reconstructed feature-input bytes remain
unchanged. Report `outputs/vendor_pre0_capture_assembled2_v19.json` has SHA256
`22a53b90ee210ac38f1a8251189cded69ec153d91c2795ea32eb0942392795f4`.
The unchanged original pre0 cubin is compared independently. The driver rejected
direct PTX9.4 JIT loading, so the explicit diagnostic feature prefix was
assembled using ptxas13.4; its cubin SHA256 is
`53b76596d1d52ddcadb893de7523451777c5a26fc27f209d4548c8588f823fad`.
Instrumentation remains excluded from every original timing baseline. This
adds bounded original published-output evidence for the fused adapter/block0;
it does not expose the original raw-half result or validate general renderer
textures, temporal history or the complete NGX runtime.
