# Block 0: coalesce both output buffers

This private experiment builds for all target architectures in v21 and has a CPU coordinate proof. GPU correctness, sanitizers and speed remain unmeasured. The public operator and its compiled policy are unchanged. On SM120 it uses 135 registers for packed output and 136 for half storage, with no spills. SASS contains eight 128-bit raw stores and eight 64-bit packed stores, or sixteen 128-bit stores for half publication, replacing the scalar stores as intended. See `outputs/v21_sass_summary.json` and `outputs/v21-sass/`.

## What the saved profile actually measures

The report is `profile/block32-adapter-fp8-b1-2176x3840-phase0-block0-20261003T033540_960320Z`. It profiles the existing adapter fusion with batch 1, a padded 2176 × 3840 field, phase 0, packed FP8 publication, and a separate raw FP16 output. The profiled extension SHA256 is `d28b19f8cb15e612d716ca6ebd721962c65772efe3b89780e5132156c3693acd`.

| Saved counter | Result |
| --- | ---: |
| Cold-cache NCU duration | 916.864 µs |
| DRAM throughput | 81.2111% |
| L2 throughput | 55.0549% |
| Tensor throughput | 38.6556% |
| Registers per thread | 134 |
| Local spill requests | 0 |
| Achieved / theoretical occupancy | 24.46% / 25% |
| Global-store useful bytes per 32-byte sector | 12.0 |
| Global-store sectors | 66,846,720 |
| DRAM bytes read / written | 536,370,688 / 736,199,424 |

The reported store inefficiency is real, but it describes requests entering the cache hierarchy. It does **not** mean DRAM writes can fall by the same fraction. The two outputs contain 802,160,640 useful bytes, already more than the DRAM-write count measured during this launch because cache residency and writeback timing affect that count.

The source report attributes 16,711,680 excessive sectors to the raw-half store and 25,067,520 to the packed store. Together they account for 41,779,200 of the report's 79,380,480 excessive global sectors. The remaining inefficiency is in loads; this experiment does not fix it.

## Where the source becomes the measured instructions

In the archived `block32_rotated.cuh`, `OrdinaryOutputTile::store` lines 177 and 178 emit the raw and packed stores. Each four-lane group owns one token. Lane `t` stores channels `8*col + 2*t` and the next channel, so one column iteration only fills part of each token's sector.

The actual SM120 disassembly has 32 raw `STG.E` sites and 32 packed `STG.E.U16` sites. For example:

```text
/*c550*/ STG.E     desc[UR4][R98.64], R102;
/*c560*/ STG.E.U16 desc[UR4][R70.64], R101;
```

These match source-report PCs `0x120154d550` and `0x120154d560`, respectively. Each raw site requests 1,044,480 theoretical sectors versus 522,240 ideal sectors over the full grid. Each packed site requests 1,044,480 versus 261,120 ideal sectors. This is the expected 16 useful bytes per raw sector and 8 per packed sector, giving the observed combined average of 12.

The exact per-PC audit is saved as `analysis/store_access_audit.json`; the extracted SM120 packed-output function is `analysis/block0_sm120_packed.sass.txt` in that profile directory. These were extracted from saved reports using `ncu_report`, without a new GPU run.

## The proposed change

Keep every adapter, FFN, attention, residual, and projection operation unchanged. Buffer the four final half2 projection words in each lane, then transpose those words inside each four-lane group. Afterwards lane `t` owns eight consecutive channels starting at `8*t`.

For each token, the four lanes then write:

- One 16-byte `uint4` raw-half vector each, filling the token's 64 raw bytes.
- One 8-byte `uint2` packed vector each, filling the token's 32 published bytes.

The raw transpose needs four warp shuffles per token side. The packed bytes are computed from the transposed raw words using the existing `pack_pair`; there is no second transpose. A half-storage publication uses the same words and the existing pack/unpack publication rule, followed by a 16-byte vector store.

The two output contracts remain separate. The raw block0 result feeds pooling. The published block0 result is retained for the later post70 merge. Neither may be dropped or substituted for the other to obtain a speedup.

For one complete 8 × 8 window, the ideal address model changes as follows:

| Output work | Existing | Proposed |
| --- | ---: | ---: |
| Raw-half store sectors | 256 | 128 |
| Packed store sectors | 256 | 64 |
| Combined sectors | 512 | 192 |
| Store instruction sites | 64 | 16 |

That is a 62.5% reduction in output sector requests, with exactly the same 6,144 output bytes per window. It is a request-pressure hypothesis, not a predicted latency or DRAM-byte reduction.

The existing `block32_packed_store` helper only coalesces publication. Its raw-half stores remain unchanged. This experiment instead shares one raw-word transpose between both outputs, so it addresses both measured store sites.

## Why the numerical change is narrow

The transpose only permutes 32-bit words. It neither adds nor rounds values. Each original half2 word reaches the same token and channel pair, and the same publication conversion is applied to those bits. Signed zeros, raw NaN payloads, and infinity bits receive no special new treatment.

Every warp executes every shuffle before any bounds predicate. XOR distances 1 and 2 stay inside the four lanes that own a token. Padding can suppress stores after the transpose without leaving a lane missing from a shuffle. No shared memory or block barrier is introduced.

The launchers allocate both outputs, so the raw base is aligned for 16-byte stores and the packed base for 8-byte stores. Token bases are multiples of 32 elements and the new channel offset is a multiple of eight. Input alignment handling is copied unchanged from the original private launcher.

`tools/block0_coalesced_store_proof.py.draft` proves all 128 lane/word coordinates of the transpose and checks 798,208 output element addresses across seven geometries, all phases, and two batches. Tiny fields are exhaustive; large fields check edge and center windows. It also derives the 512 → 192 sector count. The result is `outputs/block0_coalesced_store_cpu_proof.json`. This proof does not replace GPU tests.

## What to check before selecting it

The proposed files are all `.draft`: the kernel, private launcher, private Torch API, 69-case test module, and benchmark. The API is `_inference_block0_adapter_coalesced`, with the same inputs and output pair as `_inference_block0_adapter`.

1. Build the private experiment and inspect SM120 SASS for `STG.E.128` raw stores and `STG.E.64` packed stores, with no local spills. The array must scalarize into registers. Register allocation and occupancy must be measured; the buffered output words and shuffle temporaries can increase live state.
2. Run all 69 tests, then memcheck and racecheck. Tests include all phases, both publication storage types, partial windows, batches, offset pointers, the real block0 weights, midpoint-adjacent FP32 features, distinct raw residuals, both-output equality against the prior fusion, and input mutation during graph replay.
3. Benchmark original fusion, new fusion, and the full resident composition with the same live output pair. Check 512, 720p, 1080p, and 4K padded fields, then all phase/storage contracts. Smaller shapes may lose from shuffle overhead.
4. Repeat the identical cold-cache profile and compare elapsed time, bytes, sectors, registers, and the DRAM counter together. Do not infer a throughput improvement from fewer sectors alone.

At unchanged DRAM traffic and clocks, reducing this profile from 916.864 µs to approximately 875.995 µs would move 81.2111% to 85%. That requires about a 4.46% latency reduction. This is a useful target for the experiment, not a guarantee: cache-writeback traffic and frequencies can also change. Resident CUDA-event timing remains a separate required measurement.
