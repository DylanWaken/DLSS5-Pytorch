# Whole-window expert block prototype

This document records the first v15 prototype and its original activation
gates. The default kernel subsequently passed GPU/native validation and is
available through the measured v16 C++ policy. The unchanged original comparison
passed 240 cases and 13,762,560 published bytes across C64/C128/C256, all phases,
input/output physical views and finite-code patterns. See
[`window_experts_native_verification_v16.json`](../outputs/window_experts_native_verification_v16.json)
for the pinned binary and evidence. Follow-up register-lifetime and packed-store
experiments are documented separately in
[window-variant-experiments.md](window-variant-experiments.md).

The description below preserves the first implementation's decisions. Claims
marked pending describe its initial v15 state rather than current validation.

## The traffic this removes

C64, C128 and C256 blocks run multiple small experts, concatenate their outputs,
apply W3, generate QKV, run window attention, and apply the final projection.
The existing deployment operators preserve the required rounding but write
intermediate tensors between these stages. The candidate keeps an entire 8x8
window in one CTA. Only the original input, immutable weights and final outputs
cross global memory; expert results, FFN, QKV and attention remain on chip.

The prototype is in four private implementation/test files:

- `csrc/kernel_impl/window_block_experts.cuh`
- `csrc/kernel_launcher/window_block_experts.cu`
- `csrc/torch_api/window_block_experts.cpp`
- `tests/test_window_block_experts.py`

The private API is `_inference_window_block_experts`. It accepts logical BHWC
half or packed E4M3 input; canonical row-major packed weights W1, W2, W3, QKV
and projection; half residual/head scales and relative bias; a phase; and
independent packed-output/raw-output flags. It returns `(published, raw)`, with
an empty half tensor when raw output is disabled. It supports FP8 on SM89+;
the existing FP16 path stays separate. No backward is provided for this frozen
deployment candidate; FP32/BF16 training continues through Torch operations.

## One warp owns one expert and one attention head

For C64, each of two warps evaluates one 64-to-128-to-32 expert over all64 tokens.
The same warp later computes one32-channel QKV head and one32-channel output
group. C128 and C256 use four and eight warps respectively. The launcher uses
flat `(C,1,1)` threads because the prototype derives its group from
`threadIdx.x >> 5`; the original uses `(32,C/32,1)`.

The central shared buffer holds canonical tensor-core A fragments, rather than
a conventional row-major matrix. Its layout is
`[channel_group][M16_tile][lane][four_uint32_registers]`.
Each warp stores its64x32 published E4 values with four aligned `uint4` stores
per lane. A consuming warp loads each K32 group directly into MMA operands.
This avoids a shared transpose and makes each vector transfer contiguous.

| Channels | Warps | Shared bytes | Expert W1 | Expert W2 |
|---:|---:|---:|---|---|
|64|2|4096|[2,128,64]|[2,32,128]|
|128|4|8192|[4,128,128]|[4,32,128]|
|256|8|16384|[8,128,256]|[8,32,128]|

This footprint matches the original C64's4096-byte shared allocation. The
SM120 v15 compiler uses186 registers/thread at C64 and248 at C128, with no
stack or spills. C256 reaches255 registers, a96-byte stack and92 bytes each
of spill stores/loads. All eight storage/raw-output specializations have these
same per-width resources. The original C64 uses168 registers. These figures
are in `outputs/window_experts_v15_resources.json`; bank conflicts, occupancy
and speed still need profiling. The first compiled candidate remains unchanged
for its correctness gate. It retains canonical fragment conversions and does
not use the separately tested rotated-channel weight cache.

## Arithmetic order and buffer lifetime

Every matrix product uses native `m16n8k32` E4M3 multiplication with half
accumulators. K32 instructions execute in ascending original order. A residual
seed enters the first MMA, not a final addition after matrix accumulation.

1. Each warp loads its32-channel input group, publishes it to E4 and writes
   shared A fragments. Barrier1 makes all input groups visible.
2. Each expert streams four hidden32-channel groups. For each group, W1 consumes
   all C channels in order, the native half cubic activation runs, and E4
   publication precedes that group's W2 contraction. Barrier2 ends all reads of
   the original shared input. Experts publish their32-channel outputs into the
   same buffer. Barrier3 makes the concatenated paths visible.
3. W3 starts with `half(input * ffn_scale)`, then accumulates all path groups.
   Each warp retains its published FFN values in packed C-fragment registers
   for the later projection residual. Barrier4 ends path reads; published FFN
   replaces the buffer; barrier5 makes it visible to all QKV heads.
4. Q, K and V remain in registers. Rows are `head*96 + {0,32,64}`. Q/K use the
   native half-square FMA reduction and squared-norm floor
   `6.198883056640625e-5`; Q then receives the half head scale. Relative bias is
   indexed by natural query position and physical key position. The native
   bit-affine exponential, fixed64-key half reduction, denominator floor,
   half reciprocal, E4 probability publication and ascending two-K32 PV chain
   match the existing validated C32 register helpers.
5. Barrier6 ensures every warp has finished reading FFN before attended values
   replace the buffer. Barrier7 makes all attended heads visible to projection.
6. Projection starts from `half(published_ffn * attn_scale)`, accumulates all C
   attended channels, and writes optional raw half plus published half/bytes.

The C>=64 residual rule differs from C32: projection uses the **published FFN**,
not the raw W3 half accumulator. The draft explicitly packs this saved seed
before attention, then unpacks it for projection. Invalid shifted-window tokens
load zero. Only valid tokens write outputs. Bias-free expert/QKV stages keep
padded FFN zero; attention values for padded query positions are never exported.

Seven barriers protect reuse, and no thread leaves early before a barrier.
The input/weights/scales/bias launcher repairs contiguous offset views whose
data pointers are not four-byte aligned. CUDA Graph capture uses the current
stream and ordinary capture-compatible Torch allocations; there is no mutable
runtime tuning state in this private API.

## What the original C64 tells us

The unchanged original is `cc_tinlayout_fused_swin_2h_64_2_fp8` in
`assets/vendor_modules/module_1.cubin`, SHA256
`a10a8083b9489622fe290d669f05f38db7308c3c10771d0f0d6f22718e3cb1ae`.
Its captured attributes are168 registers/thread,4096 shared bytes, two warps,
and an88-byte parameter blob. These are observations, not measurements of the
new draft.

The extracted sources are `assets/vendor_sources/window64.ptx` and
`window64.sass.txt`. Their SHA256 values are
`33a300cf63a274bd7dc7ded11404636a01e75c90fac17c7c097bb87befe40f14`
and `01deb5acf9e8c14e922d2643bd259c3ad398a3cf695b112393b48f996976740e`.
The ordinary symbol's SASS contains2432 static instructions:304 QMMA,
455 F2FP,320 HMUL2,224 HFMA2,48 SHFL,32 MOVM, eight STS,20 LDS and six barriers.
Static counts do not equal executed instruction counts: the loop at
PC0xd90–0x3240 contains112 QMMA and executes twice, giving416 warp-MMAs.
The draft independently has416 per warp at C64:

| Stage | Ordered warp-MMAs |
|---|---:|
|Expert expansion W1|128|
|Expert contraction W2|64|
|W3|32|
|QKV|96|
|QK|32|
|PV|32|
|Projection|32|

The original's first exchange uses `STS.128` at PC0x3470,0x34b0,0x34f0 and
0x3530 with offsets0,512,1024,1536, then a barrier at0x3550. This supports the
fragment-exchange approach. It does not prove our exact swizzle or register
assignment reproduces the original's scheduling.

## Evidence and activation gates

`tools/probe_window_experts_layout.py` produced
`outputs/window_experts_layout_cpu.json`. It checks512 canonical C-to-A words,
complete/disjoint shared-byte ownership for all three widths, and20 shifted
spatial/edge/batch configurations. The test source parses successfully and has
146 CUDA cases covering all phases, edges, storage modes, misaligned offset
views, tiny/zero/finite-code inputs, real checkpoint blocks, replay updates,
invalid contracts and empty batches. These cases have **not run yet**.

Before routing any production block:

1. The private all-architecture compile passed. Retain its resource evidence
   and inspect dynamic spill impact when profiling C256.
2. Run all146 exact comparisons against composed ordered deployment operators;
   run memcheck/racecheck, including C128/C256 and shifted batch2 edges.
3. Compare directly to unchanged original kernels with real checkpoint blocks
   and adversarial finite-code inputs. Existing tests of the composed path do
   not establish candidate parity.
4. Measure matching half/packed input and output contracts, raw-output needs,
   all four phases, and continuous-resolution endpoints. Capture repeated calls
   within a graph to avoid host submission gaps.
5. Collect NCU counters and SASS. Investigate register spills, barrier stalls,
   shared transactions, tensor utilization and remaining output-store waste.
6. Promote only measured device/shape/contract policy rows in C++; keep the
   existing implementation as fallback. No85% roofline or DLL speed claim is
   supported by the current draft.

The separate C32 channel-rotation experiment preserved K16 subgroup boundaries
inside each K32 instruction and kept the sequence of K32 instructions fixed.
Its58 adversarial instruction cases plus real original-block tests support
that specific implementation/device, not arbitrary reassociation or a universal
floating-point permutation theorem. This draft avoids that assumption entirely.

## Prepared timing harness

`tuning/window_block_workload.py` prepares immutable real weights and both
resident production storage paths outside measured graphs.
`tests/benchmark_window_block_experts.py` compares the candidate with both
half and packed production compositions under identical requested input,
published-output and raw-output contracts. Required pack/unpack conversions
remain inside each baseline's graph. It reports the faster measured production
route without changing production selection.

The optional `--native` path uses the existing guarded `NativeFused` adapter
and pinned unchanged original cubin. Native input/output are packed physical
buffers. Candidate gather/scatter layout adapters are included in that graph;
this separate result is not mixed with logical-BHWC timings. Before and after
timing, it requires exact output bytes, intact allocation guards, immutable
inputs and repeat-stable original output. Repeated calls share one captured
graph, with an explicit output allocation budget. No timing has run yet.

Example after installation and an exclusive GPU slot:

```powershell
.venv\Scripts\python.exe tests\benchmark_window_block_experts.py --block 5 --shape 128,128 --shape 288,256 --phase 1 --all-io-modes --native --output outputs/window_experts_v15.json
```
