# C32: one private experiment in packed input delivery

This is the historical design proposal written before the input-vector build.
Its validation plans and unbuilt status below describe that earlier point.
The candidate has since been built, tested and profiled; see the
[completed counter report](../profile/c32-input-vector-matched-v36/REPORT.md)
and [subsequent fusion experiments](optimization_walkthrough.md#66-keep-the-decoder-merges-two-representations-inside-the-consumer)
for current evidence. The packed-store measurements here remain historical.

The proposed experiment replaces the existing four 16-bit BHWC input loads per lane and token with one 64-bit load, followed by a four-lane transpose. It retains the exact rotated C32 arithmetic, cached weights, residual handling, and ordinary output stores. At proposal time the draft was CPU-reviewed and coordinate-proven, but had **not been compiled, run, profiled, or timed**. No public dispatcher or policy changes were proposed at that point.

The motivation is unusually specific: an archived profile attributes most of its long-scoreboard samples to assembling packed input immediately after the four narrow loads. The current v35 machine code still contains those loads. This supports an experiment; it does not establish that the historical bottleneck dominates v35 or that the experiment is faster.

## Keep the three versions separate

| Evidence | What it establishes | What it does not establish |
|---|---|---|
| v12 rotated NCU profile, block1, B1/H1088/W1920/C32, phase1, packed input/output, no raw output | Measured stalls, counters and source PCs for the v12 binary | Current v35 timing or current stall percentages |
| Original `cc_tinlayout_fused_swin_1h_32_1_fp8` NCU profile, same field/phase | Original resident kernel uses vector input loads and sustains much more tensor activity in its archived run | Matched full-graph speed, adapter cost, or NGX end-to-end performance |
| Exact v35 SM120 SASS and archived source snapshot | The narrow input loads survive; resource and static instruction comparison is reproducible | New performance counters; no v35 isolated C32 NCU run was found |

Both historical profiles are separate cold-cache NCU collections. Their durations, 219.040 microseconds for v12 and 132.448 microseconds for the original, are useful identifiers, **not a fair paired speedup measurement**. The original reads its opaque tiled layout, while our operator reads logical BHWC. The historical native harness also predates the current matched-boundary comparison.

The later v29 full-trunk stage attribution assigns approximately 1.449 ms to the candidate C32 family. That identifies a substantial family to investigate, but the stage total cannot tell us how much of the time is input delivery. Partial v35 ordinary-GEMM scan results are not promotion evidence and are not used to estimate this experiment's benefit.

## What the archived counters actually say

These values come from each profile's **full worker**, using the same named metrics. Aggregate L2 throughput is diagnostic, not the project's verified L2 data-bandwidth gate.

| Full-worker metric | v12 rotated | Original C32 |
|---|---:|---:|
| Registers per thread | 147 | 168 |
| Achieved active-warp occupancy | 24.08% | 24.02% |
| Issue activity | 45.65% | 46.78% |
| Tensor-pipe activity, elapsed denominator | 37.86% | 73.73% |
| Aggregate L2 throughput | 29.18% | 15.31% |
| Aggregate DRAM throughput | 21.83% | 36.73% |
| Long-scoreboard samples / all samples | 2,907 / 10,738 | 785 / 10,945 |
| Wait samples | 3,179 | 2,447 |
| Math-pipe-throttle samples | 875 | 4,263 |
| Derived excessive global L2 sectors | 20,986,112 | 132,068 |

The **source worker** is a separate collection. Its v12 total is 21,410 samples, including 5,885 long-scoreboard samples. Eight PCs at archived `block32_rotated.cuh:142` account for **4,530 of those 5,885 samples, or 76.98%**. Never divide those source-worker counts by the full-worker total.

| Relative SASS PC | Long-scoreboard samples | Consumer |
|---|---:|---|
| `0x780` | 677 | `IMAD R24, R9, 0x10000, R2` |
| `0xc80` | 634 | `IMAD R25, R2, 0x10000, R25` |
| `0x10d0` | 569 | `IMAD R4, R5, 0x10000, R4` |
| `0x1530` | 461 | `IMAD R5, R12, 0x10000, R5` |
| `0x1980` | 499 | `IMAD R20, R17, 0x10000, R20` |
| `0x1dc0` | 569 | `IMAD R21, R12, 0x10000, R21` |
| `0x2210` | 611 | `IMAD R16, R15, 0x10000, R16` |
| `0x2650` | 510 | `IMAD R17, R2, 0x10000, R17` |

These instructions combine loaded halfwords into packed A fragments. Each follows four `LDG.E.U16` loads at offsets `0, 8, 16, 24` from the lane's input address. The dependency points to input arrival, not expensive integer multiplication itself. The original source worker has 885 long-scoreboard samples in total, with 607 at its first `QMMA` (`0x9c0`). Its input is delivered by four `LDG.E.128.STRONG.GPU` instructions at `0x5c0`, `0x690`, `0x8a0`, and `0x9d0`, from addresses derived from the input pointer in parameter slot `0x380`. The last load is already interleaved with computation. Our draft does not attempt to reproduce that opaque layout or its complete schedule.

The excessive-sector count includes other loads and stores; it is **not entirely attributable to input**. Neither the samples nor this counter is a percentage of runtime that can simply be subtracted.

## Did later packed stores already solve this?

No input delivery change is visible in the inspected v35 symbols. The exact source files also match the v35 archived source zip byte-for-byte.

| Exact SM120 symbol specialization | Registers / stack / shared bytes | Input U16 instructions before first MMA | Ordinary packed output stores |
|---|---:|---:|---:|
| v12 rotated `<true,true,false>` | 147 / 0 / 0 | 32 | 32 × U16 |
| v35 rotated `<true,true,false>` | 140 / 0 / 0 | 32 | 32 × U16 |
| v35 private packed-store `<true,false>` | 141 / 0 / 0 | 32 | 8 × 64-bit |

All three contain 256 static FP8 QMMAs. The v35 ordinary and packed-store symbols contain 4,631 and 4,634 static instructions respectively; those include alternate control paths and are not dynamic instruction counts. Packed-store adds 24 `SHFL.BFLY` instructions and changes final stores, while keeping the narrow input path. Current public `block32_dispatch.cpp` selects rotated variant3; it does not select the private packed-store kernel. Its existence in the binary is not evidence of public use.

The historical v14 packed-store benchmark (`outputs/block32_coalesced_v14.json`) reported 0.160008 ms versus rotated 0.164464 ms for this large packed/no-raw contract, a 1.02785 ratio. Raw-output mode reported 0.210176 versus 0.221888 ms. Those are historical local graph measurements, not current-policy or native proof. Packed-store remains a useful control, but the proposed ablation must first compare ordinary output against the same ordinary output, so improvements cannot be credited to an unrelated epilogue change.

## The exact byte transformation

Four lanes cooperate on one token. Let `t = lane % 4` and let `base` point to its 32 channels.

- Existing delivery reads pairs at `base + 2*t + {0,8,16,24}`.
- Proposed delivery reads eight consecutive bytes at `base + 8*t`.
- Treat each pair as one element of a 4×4 matrix. The existing three-shuffle/two-byte-permutation helper transposes that matrix. A transpose is its own inverse, so applying it to consecutive input words recovers the old lane fragments exactly.
- The first recovered word becomes `a[side]`; the second becomes `a[2+side]`. Residual unpacking extracts the same four pairs. An explicit Half skip retains its original load and multiplication path.

For an interior warp call, the old four instructions each request only eight useful bytes from each token's 32-byte sector. The proposed instruction requests the complete sector once. This reduces the geometric sector requests for that call from 32 to 8, and input-load instructions per window from 32 to 8. It does **not** imply four times fewer DRAM bytes: caches can satisfy repeated sector requests. The price is 24 added shuffle instructions and 16 byte permutations per complete window, plus any compiler scheduling/register effects. This tradeoff is the purpose of the experiment.

Invalid tokens supply zero words before the transpose. Token validity is uniform inside each four-lane group, and every lane executes every shuffle. No new shared memory, barriers, arithmetic, or output stores are introduced. Valid token bases are multiples of32; `base+8*t` is 8-byte aligned and its last byte remains inside that token. The launcher normalizes noncontiguous or misaligned offset views before launch, on the current stream.

## CPU proof and staged validation

`tools/block32_input_vector_proof.py.draft` executes the actual shuffle/byte-permutation formula with unique symbolic byte labels. It checks every byte and all256 combinations of valid/invalid four-lane groups, the inverse transformation, one input owner per byte, and the extracted raw residual pairs. Full geometry enumeration covers B0/1/2, every H/W from1 through17, and all four phases: **3,468 cases, 8,989,056 valid bytes, and 457,140 invalid-token groups**. Boundary CTAs at384×672,576×960 and1088×1920 cover the actual deployment anchors. This is a map proof, not numerical CUDA validation.

The staged test file defines156 GPU cases, including one conditional second-device case. It checks an independent shared C32 oracle and the retained rotated operator, real checkpoint blocks1/4/66/69, all output contracts, tiny/tail/shifted/batched fields, finite E4 codes, empty batches, offset/strided inputs and caches, invalid contracts, and no-grad enforcement. Its24 capture cases retain three disjoint output pairs, compare a pre-capture oracle, verify source/guard integrity before any overwrite, and use three actual changes `fixture0→1→2→0` with poisoned outputs. None of these GPU tests has run for the draft.

CPU reproduction:

```powershell
.venv\Scripts\python.exe tools/analyze_c32_operand_delivery.py.draft
.venv\Scripts\python.exe tools/block32_input_vector_proof.py.draft
.venv\Scripts\python.exe tests/test_block32_input_vector_cpu.py.draft
```

After root activates the three C++/CUDA drafts and GPU-test file in a new isolated build, use the existing build workflow and run:

```powershell
.venv\Scripts\python.exe -m pytest -q tests/test_block32_input_vector.py
compute-sanitizer --tool memcheck --launch-timeout 300 --error-exitcode 99 .venv\Scripts\python.exe -m pytest -q tests/test_block32_input_vector.py
compute-sanitizer --tool racecheck --launch-timeout 300 --kernel-name kns=block32_input_vector_kernel --error-exitcode 99 .venv\Scripts\python.exe -m pytest -q tests/test_block32_input_vector.py -k retained_poisoned
```

The race filter instruments the private candidate only; the oracle kernels still execute but are outside that filter. Record that distinction. Keep public policies and model routes unchanged.

The first fresh profile should use the same new binary for rotated and input-vector, actual block1 at B1/H1088/W1920/phase1, packed input/output, raw=false, skip=None. Require eager and changed/poisoned graph parity first. Save separate full/source reports and exact SM120 SASS. Check that the intended eight 64-bit loads actually survive compilation; inspect load-consumer stalls, sector requests, added shuffle stalls, registers/spills, tensor activity and standalone elapsed time. Then run balanced normal/reverse paired graph timing on all three field anchors, including explicit skip/raw contracts. Keep every captured output live and verified, and include all per-call normalization/copy work for irregular operands. A new candidate/native boundary comparison and complete policy evidence would still be required before any public promotion. The85% target remains unproven.

## Reproducible provenance

Machine-readable evidence and exact commands are in `outputs/c32-operand-delivery-v35/evidence.json.draft`; it pins both NCU reports, both metric extracts, source snapshots, cuobjdump arguments and exact SASS hashes. The extraction script uses no Torch import, CUDA context or GPU execution.

| Binary | SHA-256 |
|---|---|
| Archived v12 extension | `495b3d037808d85aed8adac89381ae5aff6d93b7f8f9f21beeff073f662b08ef` |
| Archived v35 extension | `44905141c7f400547e7cf44b9a45ca8852dc79af4565f6b5b6f12187bf6d2166` |
| Original C32 cubin | `feb368ff5279a7408b1e55554db6e468d7f114a24b18b2af8d7e6989a410c612` |

Exact symbols, all extracted with `--gpu-architecture sm_120`:

```text
_ZN6dlssnr15block32_rotated22block32_rotated_kernelILb1ELb1ELb0EEEvPKvPKN3c104HalfEPKhS9_S9_S9_S7_S7_S7_S7_PvPS5_iiiiii
_ZN6dlssnr20block32_packed_store27block32_packed_store_kernelILb1ELb0EEEvPKvPKN3c104HalfEPKhS9_S9_S9_S7_S7_S7_S7_PhPS5_iiiiii
cc_tinlayout_fused_swin_1h_32_1_fp8
```

The proposal concerns packed FP8 deployment only. It changes neither FP16 inference nor FP32/BF16 training and establishes no new support claim for untested devices.
