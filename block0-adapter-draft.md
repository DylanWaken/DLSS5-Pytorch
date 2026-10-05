# Fusing the input adapter with block 0

Status: validated and measured as a private v19 operator; integrated into the
v20 public dispatcher. The all-architecture build and CPU policy diagnostics
pass, and all 102 executable public adapter tests pass, including memcheck
with zero errors; one second-GPU check skips. The existing register C32 core
remains unchanged.

The v16 4K profile assigns about 0.907 ms to the half input projection, 0.463 ms
to the FP32-to-half conversion, and 0.504 ms to full-field FP8 packing. These
are separate operations before block 0. Their sum is an optimization target,
not the predicted speedup: fusion adds projection instructions and feature
loads to a kernel whose register occupancy must be measured.

The private candidate accepts FP32 `features[B,H,W,16]`, half
`input_adapter[32,16]`, the existing four dual canonical/rotated FP8 C32 caches,
half scales and bias, and a phase. It returns the same block 0 published tensor
(packed bytes by default, optional half storage) and raw half tensor. It does
not fuse pooling or change the renderer's feature-preparation contract.

## Exact intermediate values

The composed operation is:

1. Round the FP32 feature lanes to half.
2. Evaluate the 16-to-32 adapter with one ordered FP16 K16 MMA step.
3. Publish the raw adapter result to E4 for the FFN input.
4. Preserve the raw half adapter result as the FFN residual seed.
5. Evaluate the existing C32 block, returning published and raw outputs.

The raw adapter must not be reconstructed from the E4 input. Tests explicitly
use values between E4 levels to distinguish the two. The long-lived adapter
skip consumed by post70 is **block 0's published output**, which this candidate
still writes. The raw block output still feeds the first pool.

## Reusing the existing core

The rotated C32 core calls an input provider twice for each M16 tile: side 0,
then side 1. The physical-token mapping places rows `g` and `g+8` at the same
natural x and y coordinates separated by two pixels. The new provider uses
that property without changing the core:

- On side 0, load both rows' FP32 feature pairs, convert them with round-to-nearest
  Half2 conversion, and form the standard four-register FP16 MMA A fragment.
- Run four N8/K16 MMAs, one for each group of eight adapter output channels.
- Feed the raw half C fragments directly to the existing rotated C-to-A FP8
  publication. Return side 0's raw values and retain four side 1 registers.
- On the immediately following side 1 call, return those cached raw values.

All lanes issue every MMA. Out-of-image rows are explicitly reset to literal
zero after the adapter, matching the existing input provider's padding even
for unusual nonfinite adapter weights. Only valid pixels write outputs.
No intermediate feature or adapter tensor is allocated inside the kernel.
It executes 16 additional FP16 warp-MMAs per 64-token window.

The launcher validates exact shapes/devices/types, SM89+, int32 grid limits,
and no autograd. It repairs offset views to eight-byte alignment for Float2
loads, four bytes for half pairs/scales/bias, and 16 bytes for rotated weight
vectors. Capture uses the current stream and normal capture-compatible clones.
No per-launch surface, device-property or context query is introduced.

## Current checks and remaining gates

The [CPU proof](../outputs/block0_adapter_layout_cpu.json) exhaustively checks
the 256 feature coordinates, 512 weight coordinates and 512 raw output
coordinates per M16 tile, the rotated published-word mapping, and shifted edge
row pairs. It proves ownership and indexing, not floating-point equivalence.

The tests cover all phases, a batch of two, odd/tiny edges, both output
storage formats, offset views, immutable inputs, graph replay with changed
features/weights/scales, the actual block 0 checkpoint, invalid contracts and an
empty batch. A residual-only identity adapter exercises all 63,486 signed
adjacent finite-half intervals, testing each midpoint and its two neighboring
FP32 values: 190,458 values, plus positive and negative zero. NaN/Inf encodings
are explicitly excluded from that finite-interval test.

Files:

- `csrc/kernel_impl/block0_adapter.cuh`
- `csrc/kernel_launcher/block0_adapter.cu`
- `csrc/torch_api/block0_adapter.cpp`
- `tests/test_block0_adapter.py`
- `tests/benchmark_block0_adapter.py`
- `tools/probe_block0_adapter_layout.py`

Independent source review of the stateful side-0/side-1 provider found no
blocker. v19 builds all target architectures and passes all 53 private adapter
tests, including under memcheck with zero errors. Its SM120 kernel uses 134
registers, no spills and one warp per CTA. The broader new-kernel suite has
288 passing tests and the full suite has 2,784 passing tests/seven subtests.
The adapter has not yet received a dedicated racecheck run; bounded racecheck
covered global attention and the separate window-prefetch experiment.

All 32 matched resident contracts (four fields, four phases, packed/half
published storage) are exact, with gains of 1.887–3.027×. Phase-zero packed 4K
field timing falls from 2.729 ms to 0.938 ms. Its cold NCU profile reaches
81.21% DRAM, 55.05% L2 and 38.66% tensor utilization: still below 85%.

A bounded native proof uses six original-pre0 feature captures at 16×24,
phase zero, published FP8 output. All 73,728 bytes per pass match on the first
launch and two additional replays, with guards and immutability checks. This
does not establish renderer preparation, raw native half output, other phases,
or native pre0 speed. See `outputs/vendor_pre0_capture_assembled2_v19.json`.

The v20 public policy `60faa7bd26e563ad` requires existing dual FP8 caches and
a measured device/batch family. Other contracts use the original composition.
The composed entry remains available to prevent self-comparison in benchmarks.
See [the walkthrough](optimization_walkthrough.md#19-fuse-the-input-adapter-without-losing-its-raw-residual)
for the full timing table and the distinction between adapter and block outputs.

The benchmark includes the FP32-to-half cast, adapter projection and
publication inside the composed baseline's captured graph. It retains both
final outputs for both implementations and compares with the current C++ C32
dispatcher. It does not treat a precomputed adapter tensor as a free input.
Large fields require an explicit output budget large enough to retain one
published/raw pair; repeated calls are capped by that budget.
