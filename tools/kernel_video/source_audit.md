# FP16 C1024 FFN expansion: animation source audit

Audited 2026-10-13 against source revision `fc3276497f866bdad639cd443e75743f5d19b749` (the source revision pinned by the kernel guide). This file is an authoring reference, not a GPU timing measurement. All offsets below are **bytes relative to the named allocation**, and all indices are zero based.

## Source map

| Subject | Repository source and lines |
|---|---|
| Entry, coordinates, packed bases | `csrc/kernel_impl/bottleneck_c1024_ffn/fp16/global_ffn_expand_c1024_fp16.cu:7–24` |
| Producer groups, staging and zero fill | same entry, `26–57` |
| Barrier setup and wait | same entry, `59–74` |
| Cached B loads | same entry, `76–90` |
| Prefill, consume and refill schedule | same entry, `92–125` |
| Activation and packed output stores | same entry, `128–160` |
| FP16 constants | `csrc/kernel_impl/bottleneck_c1024_ffn/common/global_ffn_expand.cuh:11–20` |
| Accumulator shape and exact issue order | `csrc/kernel_impl/shared/common/tiled_mma.cuh:9–43` |
| Exact MMA PTX | `csrc/kernel_impl/shared/common/intrinsics.cuh:215–225` |
| Elect/copy architecture branches | same intrinsics, `17–47`, `237–287` |
| Barrier instructions | same intrinsics, `227–235`, `290–340`; `memoryops.cuh:9–19` |
| Store instruction | same intrinsics, `204–213` |
| Half operations and gate | `csrc/kernel_impl/shared/common/packed_math.cuh:85–115`, `141–164` |
| Gate coefficient bit patterns | `csrc/kernel_impl/shared/common/numerical_constants.cuh:12–23` |
| Actual host block dimensions / bindings | `csrc/kernel_launcher/plan_fp16_generated.inl:1304–1317` |
| Host grid dimensions | `csrc/kernel_launcher/plan_geometry_fp16_generated.inl:279` |
| Independent B packing confirmation | `dlssnr/weights.py:71–76`, `200–205` |

The fragment layout is independently checked against NVIDIA's [PTX `mma.m16n8k16` floating-point fragment specification](https://docs.nvidia.com/cuda/parallel-thread-execution/index.html#matrix-fragments-for-mma-m16n8k16-with-floating-point-type). Draw the shapes from our index formulas; do not paste the manual's figure into the video.

## 1. Model operation and launch

`X[T,1024] × W[1024,4096] → Half accumulators → recovered FFN gate → U[T,4096]`. There is no bias or residual addition in this entry. It is the expansion half of the dense bottleneck FFN; contraction follows in a different entry. Token identity is independent of output channel: token 83's values affect every `U[83,n]`, but not another token's output.

The entry uses `T = BatchCount * TokensPerBatch`. The prepared host sets batch one. The documented 4K shape has `T=36*60=2160`.

- CUDA block: `(32,4,1)`, 128 threads, four complete warps. `lane=threadIdx.x`, `warp=threadIdx.y`.
- Grid: `(32*ceil(T/128),1,1)`; at 2160 tokens, `(544,1,1)`.
- `Mtiles=ceil(T/128)=17`; `nBlock=blockIdx.x//Mtiles`; `firstGroup=8*(blockIdx.x%Mtiles)`.
- CTA output is 128 tokens × 128 channels; four warps form a 2×2 grid of 64×64 tiles.
- Warp `w` starts at token `16*(firstGroup+4*(w//2))` and output channel `128*nBlock+64*(w%2)`.
- A warp holds four M16 tiles and four N16 tiles. Each N16 is two separate N8 MMAs.
- A CTA is scheduled onto an SM by hardware; there is no fixed mapping from block number to SM or defined execution order between warps/CTAs.
- The actual host grid has `z=1`. The body additionally supports adjusted bases `Xbase=input+blockIdx.z*32768`, `Wbase=weights+blockIdx.z*8388608`; all worked examples use `z=0`.

For the trace, CTA 0 has token range 0–127 and output range 0–127. Warp 2 owns tokens 64–127, channels 0–63. Its M16 tile 1 is group 5, tokens 80–95. Its N16 tile 2 is channels 32–47. **Token 83 / output 34 is owned by warp 2, lane 13, accumulator `[1][2][0]` low Half.** Across the full grid, token 83 belongs to 32 output-channel CTAs, not just CTA 0.

## 2. Native lane fragments

For a lane `L`, let `g=L//4`, `q=L%4`, and `h=0 or 1` select the low/high Half of a 32-bit word.

| Fragment | Word | Logical row | Logical column |
|---|---:|---:|---:|
| A, M16×K16 | `j=0..3` | `g+8*(j%2)` | `2*q+8*(j//2)+h` |
| B, K16×N8 | `j=0..1` | `2*q+8*j+h` | `g` |
| C/D, M16×N8 | `j=0..1` | `g+8*j` | `2*q+h` |

This is register ownership, not a lane-local dot product. The instruction is collective across all 32 lanes:

`mma.sync.aligned.m16n8k16.row.col.f16.f16.f16.f16`

It consumes four 32-bit A words/lane, two B words/lane, two C words/lane, and writes two D words/lane. All are packed Half pairs; accumulators are not FP32. The row/column qualifiers specify operand interpretation, not ordinary row-major/column-major global allocation layouts.

At reduction step `i=3`, K subtile `k=1`, the K16 range is **112–127**. In group 5 and N16 tile 2:

| Lane / register vector | word 0 low/high | word 1 low/high | word 2 low/high | word 3 low/high |
|---|---|---|---|---|
| A lane 13 | `X[83,114/115]` | `X[91,114/115]` | `X[83,122/123]` | `X[91,122/123]` |
| B lane 9 | `W[114/115,34]` | `W[122/123,34]` | `W[114/115,42]` | `W[122/123,42]` |
| D lane 13 | `D[83,34/35]` | `D[91,34/35]` | `D[83,42/43]` | `D[91,42/43]` |

The selected contribution `X[83,114]*W[114,34]` crosses **A lane 13 → collective MMA ← B lane 9**, then contributes to **D lane 13**. Token 83's complete A row within a K16 panel is spread across lanes 12–15. B column 34 within the low N8 tile is spread across lanes 8–11. Show those four-lane groups when expanding from one product to the full 16-term MMA update. The adjacent token 91 can remain gray; it shares the vector but is not the traced token.

## 3. Packed global → shared → register addressing

Each input token group is 16×1024×2 = 32768 bytes. A K32 slab is 16×32×2 = 1024 bytes. Its two K16 panels are 512 bytes each; each panel is 32 lane vectors of 16 bytes in native A-fragment order.

For an A lane vector belonging to group `G`, step `i`, K subtile `k`:

`A_global = Xbase + G*32768 + i*1024 + k*512 + L*16`.

The producer warp copies group `firstGroup+w+4*c`, with `c=0,1`, into

`A_shared = (i%3)*8192 + w*1024 + c*4096 + k*512 + L*16`.

The consumer computes the same address as

`A_shared = (i%3)*8192 + (consumerWarp//2)*4096 + m*1024 + k*512 + L*16`.

For our selected value (`G5,i3,k1,L13,consumerWarp2,m1`):

- Global vector offset: `5*32768 + 3*1024 + 512 + 13*16 = 167632`.
- Shared vector offset: `0*8192 + 4096 + 1024 + 512 + 208 = 5840`.
- On SM80/89 the producer is **warp 1, lane 13, CopyGroup 1, second 512-byte stripe**. It copies the 16-byte vector unchanged. Consumers are lane 13 of warps 2 and 3, which share A but cover different N halves.
- On SM90+ an elected lane of producer warp 1 issues the entire 1024-byte copy; do not label that elected lane as lane 0 or lane 13 because `elect.sync` does not promise either.

B bypasses shared memory. Its vector is loaded with `__ldca` from

`Wbase + nBlock*4096 + (w%2)*2048 + (2*i+k)*131072 + n16*512 + L*16`.

The stride 131072 is one K16 panel across all 4096 channels: `16*4096*2`. For `W[114,34]`, use **B lane 9**, giving

`7*131072 + 2*512 + 9*16 = 918672`.

The selected scalar is word 0's low Half, so its scalar address equals this vector address. The existing lesson's B **lane 13 vector** example `918736` is also correct, but that lane owns columns 35/43, not the selected weight column 34. Do not mix these two examples.

L2 and eligible L1 caching are hardware managed. Label the B route as a cache-policy load, not a guarantee of a particular cache hit. The A `cp.async.cg` route on SM80/89 uses `.cg`; the SM90+ bulk route has its distinct instruction. No extra global-to-register A staging is present in this source-level asynchronous-copy path.

## 4. Shared layout and banks: no XOR swizzle

Shared allocation: `3*8192 + 3*8 = 24600` bytes, with 512-byte alignment. Stage 0 is bytes 0–8191, stage 1 is 8192–16383, stage 2 is 16384–24575. The three 8-byte barriers start at 24576, 24584 and 24592.

There is **no additional shared-memory XOR swizzle** here. The upstream packed tensor already holds MMA-ready A vectors. Producer and consumer both use additive offsets; no transpose, `ldmatrix`, `movmatrix` or lane shuffle occurs in this entry.

For the standard 32-bank, 4-byte bank-address map, the bank of word `j` in lane `L`'s vector is `(4*L+j)%32`, since every stage/group/panel base is a multiple of 128 bytes. Lane 13's vector at byte 5840 has word addresses 5840, 5844, 5848, 5852 and bank indices **20,21,22,23**. All four Half pairs can be drawn as two adjacent 16-bit cells in each 32-bit bank word.

Show one contiguous 128-byte span of eight lane vectors to explain the address pattern, then show the next span. Do not infer bank conflicts merely because lanes separated by 8 have equal bank indices: conflict accounting depends on the emitted instruction and hardware transaction decomposition. Source alone is not a bank-conflict measurement. No new swizzle should be invented to satisfy the user's request to explain swizzles; explicitly teach why this kernel needs no new permutation at this stage.

## 5. Copy/synchronization instructions and three-slot scheduling

All four warps both stage and compute; there are no dedicated producer-only/consumer-only warp roles. Source defines a software order, while hardware overlaps eligible work when dependencies permit.

Initialization: lane 0 of warp 0 calls `mbarrier.init.shared.b64` for each barrier with **128 expected thread arrivals**, then `__syncthreads()` makes initialization visible. This is the one explicit CTA barrier in the body.

| Branch | Copy producers and exact instruction family | Completion bookkeeping |
|---|---|---|
| SM80/89 | All 32 lanes; two 16B `cp.async.cg.shared.global` copies/lane per 1024B group, at `16*L` and `512+16*L` | Each participating lane issues `cp.async.mbarrier.arrive.shared.b64`; `BarrierExpect` is a no-op |
| SM90+ | One `elect.sync` selected lane per producer warp; one `cp.async.bulk.shared::cta.global.mbarrier::complete_tx::bytes` per 1024B group | That issuer adds 1024 expected bytes using `mbarrier.expect_tx.relaxed.cta.shared::cta.b64` |

A fully valid stage is eight 1024B groups = 8192B. Invalid groups use ordinary shared uint4 zero stores by all lanes; no copy is issued for those groups and no expected bytes are added for them. Every thread still participates in the stage wait.

`WaitStage(s)` calls `ArriveAndWait`: every thread arrives with count 1, retains its returned phase token, and polls that phase. On SM80 this is `mbarrier.arrive.shared.b64` plus `mbarrier.test_wait.shared.b64`. On SM90+ it is `mbarrier.arrive.shared::cta.b64` plus `mbarrier.try_wait.shared::cta.b64`. Completion accounts for both thread arrivals and the attached asynchronous copies. Tokens distinguish reused phases when the ring wraps. There is no extra sleep, `cp.async.wait_group`, `commit_group`, or CTA barrier inserted in this helper.

Exact source schedule:

1. Load B0 into registers.
2. Issue A0→slot0, A1→slot1, A2→slot2.
3. Arrive/wait slot0; initialize C to zero.
4. For `i=0..31`, load A from slot `i%3` into lane registers, then perform all of that step's MMAs using B_i.
5. If `i<31`, load B_(i+1), then arrive/wait slot `(i+1)%3`.
6. If `i+3<32`, issue A_(i+3) into the old slot `i%3`.

The wait for the next stage also ensures all CTA threads have advanced past the preceding read phase before the consumed slot is recycled. At i0 this yields B1 → wait A1 → refill slot0 with A3; the pattern repeats. The last refill is at i28, issuing A31. Iterations29,30,31 drain remaining tiles; i31 performs neither next-B load nor next-stage wait. Draw dependency arrows and overlapping lanes, not invented cycle counts or a guaranteed instruction-by-instruction issue interleave between warps.

## 6. Register math, reuse, instruction counts

Each lane declares `C[4][4][4]`: 64 32-bit words = 128 Half outputs. A warp collectively owns 4096 scalar outputs =64×64. Each reduction step declares A[4][2] uint4 =32 words/lane and B[2][4] uint4 =32 words/lane. These declaration counts are not the compiled register allocation.

Exact `AccumulateTile` traversal: `m=0..3`, then `n16=0..3`, then `k=0..1`; at each k, issue the low N8 MMA followed by the high N8 MMA. The next K subtile updates the same packed accumulator words. A fragment is reused over eight N8 tiles, while B is reused across four M16 tiles. Warps0/1 share A rows; warps2/3 share A rows. Warps0/2 load the same B tile for different token halves; warps1/3 likewise.

- 4 M tiles ×4 N16 tiles ×2 K subtiles ×2 N8 halves = **64 warp-wide MMAs per step**.
- 32 steps = **2048 MMAs per warp**, or **8192 per CTA**.
- A particular output scalar receives **64 K16 MMA updates**, covering all 1024 K values; it does not receive 2048 independent scalar MMA updates.
- Each MMA represents 16×8×16 multiply-adds. Whole-CTA work is consistent with 128×128×1024 multiply-adds.
- `__maxnreg__(168)` is a compile-time maximum request, not evidence that precisely 168 registers are allocated or that there are no spills/particular occupancy.

## 7. Gate and store

Let `x` be the completed Half accumulator value. Per Half lane, with the stated min/max semantics, the source performs:

1. `u = min(x, Half(4))` (`__hmin2`).
2. `b = max(u, Half(-4))` (`__hmax2`).
3. `a = abs(b)` (`__habs2`).
4. `p = hfma2(Half(-0.055908203125), a, Half(0.447265625))`.
5. `gate = hfma2(b, p, Half(0.89453125))`.
6. `y = hmul2(x, gate)`.

Show the **original x** bypassing the clamp into the final multiply. The two FMAs and final multiply preserve Half rounding; clamp/abs preserve/select existing representable values rather than inventing wider arithmetic. Do not describe this as SiLU, GeLU, an FP32 polynomial, or six newly introduced numerical rounding errors. Coefficients are recovered bit patterns; the source does not establish their original fitting method. Numeric curve/sample values, if drawn, must be labeled as illustrative rather than an observed activation of token83.

The kernel applies this operation to all 64 Half2 words/lane. It assembles four updated words directly into a uint4; there is no format conversion or global preactivation buffer.

For output group G, block nBlock, warp w and N16 tile n16:

`U_vector = output + G*131072 + nBlock*4096 + (w%2)*2048 + n16*512 + L*16`.

Our vector is `5*131072 + 0 + 0 + 2*512 + 13*16 = 656592`. Its four words contain token/channel pairs `(83,34/35)`, `(91,34/35)`, `(83,42/43)`, `(91,42/43)`. Thus the selected scalar `U[83,34]` is byte656592, its paired channel35 is byte656594, and token83's channel42 begins at byte656600. This is **packed fragment storage**, not eight consecutive channels of one row.

The exact store is `st.global.L1::no_allocate.b128`, a 16-byte aligned store with an L1 allocation hint. It is not a release counter, memory fence, atomic add, or a guarantee of bypassing every cache. The host's normal stream/dependency ordering makes completed output available to subsequent launches; this entry has no split-K counters or cross-CTA rendezvous.

Tail groups are rounded to 16 tokens: `Gcount=ceil(T/16)`. At T2160 this is135. Last token tile has7 valid groups and one zero-filled/skipped group. If T is not divisible by16, the final existing group contains storage padding; the kernel guard is per group, not per individual token. At T≤16 the FP16 branch replicates input group0 into virtual group positions, while only the bounded output groups are stored.

## Claims to avoid in the animation

- “Lane13 independently multiplies its A and B to get D13”: B lane9 owns the selected weight; MMA is collective.
- “A token lives in one lane”: its 1024 coordinates and4096 results span many lane fragments/CTAs.
- “Shared swizzle XOR”: there is none in this entry; prepacking is the optimization.
- “B is staged into shared/TMA tensor descriptors/TMEM/WGMMA”: none is present.
- “Producer warps are separate from compute warps”: the same four warps perform both jobs.
- “All CTAs launch/run simultaneously”, fixed SM mappings, exact overlap or occupancy: unsupported by source.
- Equating the lane13 B vector offset918736 with the selected scalar W[114,34], whose offset is918672.
- Treating a repeated bank number across a full512B warp footprint as automatic bank conflict.
- Calling no-allocation stores an ordering/fence mechanism or output publication a new precision conversion.
- Adding split-K, bias, residual, or normalization to this expansion entry.
