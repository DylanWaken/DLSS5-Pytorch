# Small attention (FP32 accumulation) — measured SM120 report

**Status:** PASS — CPU-only analysis of the four verified real-workload reports.
**Root decision (final):** retain the current accepted binary for this release;
**no register-cap experiment**. A 224-register cap is documented only as an
**untested follow-up** with the same predicted 2-CTA/SM capacity and no promised
speed gain.
**Run directory:** `profile/small-attention-fp32acc-sm120-20261030/`
**Repository:** `D:/Research/DLSSNR-PyTorch`, `main` at
`266d69acf52dda413df3a874572f1156461f89ff`.
**Device measured:** NVIDIA RTX PRO 6000 Blackwell Workstation Edition (GB202,
SM120, CC 12.0, 188 SMs, 97,887 MiB, driver 610.62). Not B200; no `tcgen05`,
TMEM, or `sm_100` assumption.
**Workload:** Cyberpunk 2077 first frame, 3840x2160, real Small b31 fixture,
`T=2160`, batch 1, 32 heads, C1024 (head channels 32), grid `32x9x1`, block
`32x4x1` (128 threads). FP16 padded tokens 2160; FP8 padded tokens 2176.

This step did **not** touch the GPU: no CUDA, no torch device call, no
telemetry, no new profiling, no production/docs/manifest/NPZ/raw-report edit.

---

## 0. Evidence identity and non-conflation

All four actual `.ncu-repz` files load through `ncu_report` as exactly 1 range /
1 action with the requested kernel name. All four SHA-256 values were
recomputed on disk and match the collection record.

| precision | kind | actual report (unchanged filename) | raw SHA-256 | metric count |
|---|---|---|---|---:|
| fp16 | full | `reports/full_cyberpunk4k-b31_fp16.ncu-repz` | `d4d9c57968c169edb268db3606f65e214846d46ac437b14aad074f3bd567f383` | 2633 |
| fp16 | source | `reports/source_cyberpunk4k-b31_fp16.ncu-repz` | `5dc78067f5195425ca4d9421e371cc93135c52d05fee571c6e1025ea8bb5fa29` | 1272 |
| fp8 | full | `reports/full_cyberpunk4k-b31_fp8.ncu-repz` | `c9d1d1b55259e2edbe28588ffba5cdf226612bf583eaf4847e17c21adb8e163a` | 2633 |
| fp8 | source | `reports/source_cyberpunk4k-b31_fp8.ncu-repz` | `f83b10ef4202d70d87a138598376131bfa592a2bc70e6df791c686834619d0a7` | 1272 |

**Full and source are different profiling runs.** This report uses the source
reports only for PC-stall samples (`smsp__pcsamp_sample_count` = **7999 FP16 /
4956 FP8**) and the full reports for static/aggregate metrics. The full reports'
own PC counts (7924 FP16 / 4961 FP8) are not combined with the source totals.
The two source-pass run durations are 78,048 ns FP16 / 46,944 ns FP8; the full
pass durations used below are 77,024 ns / 46,720 ns.

The 77.024 us / 46.720 us figures are **instrumented isolated kernel-replay
durations**, not an end-to-end speed benchmark. ncu defaults
`--replay-mode kernel` and `--cache-control all` flush caches between passes;
the collector used `--clock-control none`.

---

## 1. Pins

| item | value / path |
|---|---|
| source commit | `266d69acf52dda413df3a874572f1156461f89ff` |
| accepted native module | `dlssnr/_C_sm120.cp311-win_amd64.pyd`, SHA-256 `f0d514043dda98bbe0043ac14d1d93a13e6620eae1c0338d1e3901c017528938` |
| native FP16 manifest | `profile/dlss-update-20261029/rgb-safe-attention-numerical/artifacts/fixture_manifest_small31_b31_4k_fp16.json`, SHA-256 `69b7223864f6ccd309633782569199a3942af33ee949555a660b9fa10a9a6f1f` |
| native FP8 manifest | `...fixture_manifest_small31_b31_4k_fp8.json`, SHA-256 `8ebee7b7f6909c82c111a5d52691836ca60b338ba87b8ebbbd580f4a2d34fd1d` |
| native FP16 listed-order tree hash | `c9b86a2d8c04fb5a47e7723b6fd1a1e3a2f0648ef31def9425982bfdea285730` |
| native FP8 listed-order tree hash | `75146a4a6219393ec451b86f06d8fffeb7e4d84516806f4cdc957c047a4954af` |
| **sorted** FP16 source closure | `analysis/source_manifest_sorted_fp16.json`, tree SHA-256 `42286f14c6693e4e7c2388d2cd54925d11f593d6e204f0c7a2ad82f3fc771012` |
| **sorted** FP8 source closure | `analysis/source_manifest_sorted_fp8.json`, tree SHA-256 `b9060a5938f0c08842bf024ff1a7e31fc70330371d332b2844092c6061c208e1` |

The native `sources.tree_sha256` metadata is preserved unchanged. It reproduces
only in **listed order**, not in the sorted order its label claims (FP16 listed
`c9b86a2d…5730`, FP8 listed `75146a4a…54af`; sorted order does not reproduce).
Citations therefore use the separate, correctly sorted 13-file closures above;
the native label is not edited and is not used as a sorted pin.

Per-file pins used by this report (all re-hashed on disk):

| file | SHA-256 |
|---|---|
| `csrc/kernel_impl/small_c1024_attention/fp16/small_global_attention_chained_c1024_fp16.cu` | `f202ae4bc19b8b9c6e5ffe5fb49cc4751f62a86d32e27cbe8dd6178eb1d38410` |
| `csrc/kernel_impl/small_c1024_attention/fp8/small_global_attention_chained_c1024_fp8.cu` | `c91253023dab7b30305cc6e30c0e4d69a32dad438a40c53742a2fb1cc2e2f11a` |
| `csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh` | `e3f672a7c9b7030156ec98fb6fdde15c8a984eee0ae0bd4d2ff84560359dd3ed` |
| `csrc/kernel_impl/shared/common/intrinsics.cuh` | `f2dd3e6110e0d5207be794ed995cf610c751ffd784276c479b2b00742a6db383` |
| `csrc/kernel_impl/bottleneck_c1024_attention/common/global_attention.cuh` | `b5061a54de3bc464b13ed9e77ad4755bbe6a1e8a2ec4345d3d2460d2dbdea7b9` |
| `csrc/kernel_impl/shared/common/warp_window32.cuh` | `18cac3b309a28d09b8207c0f6ab1bb0839b5d2e87cc3af3fe34ec5bb2710534e` |
| compiler log (ptxas resources) | `profile/dlss-update-20261029/rgb-safe-attention-build/build.log`, SHA-256 `2456fe4e5477f6714d2e8de8f0496adb5f91f3c00b8f0863847edc794f2c1c98` |

Compiler resources are not runtime traffic: `build.log:19-20` says FP16
**24 B stack frame, 44 B spill stores, 56 B spill loads, 208 registers**;
`build.log:10-11` says FP8 **0 / 0 / 0, 195 registers**. The ncu
`launch__stack_size = 1024 B` is a different launch field and is not the 24 B
ptxas stack frame.

---

## 2. Actual numeric table

All aggregate values below are from the **full** reports; PC counts are from the
**separate source** reports.

| metric (exact ncu name) | FP16 | FP8 | unit / note |
|---|---:|---:|---|
| `gpu__time_duration.sum` | 77,024 | 46,720 | ns, isolated replay |
| `launch__grid_size` / `launch__block_size` | 288 / 128 | 288 / 128 | 32x9x1 / 32x4x1 |
| `launch__waves_per_multiprocessor` | 0.765957 | 0.765957 | 288/(188x2) |
| `launch__registers_per_thread` | 208 | 195 | register/thread |
| `launch__shared_mem_per_block` | 17,424 | 9,232 | byte/block |
| `launch__shared_mem_per_block_static` | 16,400 | 8,208 | byte/block |
| `launch__shared_mem_per_block_driver` | 1,024 | 1,024 | reserved |
| `launch__occupancy_limit_registers` | 2 | 2 | blocks/SM (binding) |
| `launch__occupancy_limit_shared_mem` | 5 | 7 | blocks/SM |
| `launch__occupancy_limit_warps` | 12 | 12 | blocks/SM |
| `sm__maximum_warps_per_active_cycle_pct` | 16.6667 | 16.6667 | % (8 of 48 warps) |
| `sm__warps_active.avg.pct_of_peak_sustained_active` | **12.9285** | **12.9603** | % achieved occupancy |
| `smsp__warps_active.avg.per_cycle_active` | 1.55788 | 1.56842 | warps |
| `smsp__warps_eligible.avg.per_cycle_active` | 0.36827 | 0.54964 | eligible warps/cycle |
| `smsp__issue_active.avg.pct_of_peak_sustained_active` | 32.0264 | 46.7821 | % |
| `sm__throughput.avg.pct_of_peak_sustained_elapsed` | 51.9075 | 41.9505 | % |
| `sm__cycles_active.avg` / `.min` / `.max` | 173,461.07 / 143,549 / 207,960 | 108,550.48 / 93,637 / 124,730 | cycles |
| `sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_elapsed` | 51.9075 | 41.9505 | % |
| `sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_active` | 61.4952 | 49.1340 | % |
| `sm__inst_executed_pipe_tensor_subpipe_hmma.avg.pct_of_peak_sustained_elapsed` | 51.9075 | 41.9505 | % |
| `sm__inst_executed_pipe_tensor_subpipe_imma.avg.pct_of_peak_sustained_elapsed` | 0 | 0 | % |
| `gpu__dram_throughput.avg.pct_of_peak_sustained_elapsed` | 10.1172 | 8.4166 | % |
| `dram__bytes_op_read.sum` / `_write.sum` | 13,309,696 / 7,424 | 6,717,696 / 0 | byte |
| `l1tex__t_sector_hit_rate.pct` | 77.5706 | 1.0093 | % (see §3.4) |
| `lts__t_sector_hit_rate.pct` | 81.8556 | 80.5393 | % |
| `smsp__average_warps_issue_stalled_wait_per_issue_active.ratio` | 1.47715 | 0.67698 | ratio (ncu unit `inst`) |
| `smsp__average_warps_issue_stalled_barrier_per_issue_active.ratio` | 0.45892 | 0.47859 | ratio (ncu unit `inst`) |
| `smsp__average_warps_issue_stalled_long_scoreboard_per_issue_active.ratio` | 0.29646 | 0.21686 | ratio (ncu unit `inst`) |
| `smsp__average_warps_issue_stalled_math_pipe_throttle_per_issue_active.ratio` | 0.89638 | 0.29373 | ratio (ncu unit `inst`) |
| `smsp__sass_inst_executed_op_local_ld.sum` / `_local_st.sum` | 197,824 / 88,704 | 0 / 0 | inst |
| `l1tex__t_sectors_pipe_lsu_mem_local_op_ld.sum` | 788,800 | 0 | sector |
| `l1tex__t_sectors_pipe_lsu_mem_local_op_ld_lookup_hit.sum` | 779,479 | 0 | sector |
| `l1tex__t_sector_pipe_lsu_mem_local_op_ld_hit_rate.pct` | 98.8183 | 0 | % |
| `l1tex__t_sectors_pipe_lsu_mem_local_op_st.sum` / hit | 354,816 / 330,736 | 0 / 0 | sector |
| `l1tex__t_sector_pipe_lsu_mem_local_op_st_hit_rate.pct` | 93.2134 | 0 | % |
| `sass__inst_executed_register_spilling_mem_local` | 286,528 | 0 | inst (read 197,824 / write 88,704) |
| `l1tex__data_pipe_lsu_wavefronts_mem_shared_op_ld.sum` | 2,534,489 | 1,253,431 | wavefront |
| `smsp__sass_inst_executed_op_shared_ld.sum` | 626,688 | 313,344 | inst |
| shared load wavefronts / instruction (derived) | 4.0443 | 4.0002 | 512 B / 128 B |
| `memory_l1_wavefronts_shared` / `_ideal` | 2,511,360 / 2,511,360 | 1,253,376 / 1,253,376 | sector |
| `derived__memory_l1_wavefronts_shared_excessive` | 0 | 0 | excess |
| `l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum` | 29,169 | 63 | conflict |
| `l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum` / requests | 148,576 / 18,976 | 79,968 / 14,688 | sector / request |
| `l1tex__t_sectors_pipe_lsu_mem_global_op_st.sum` / requests | 138,784 / 9,184 | 72,224 / 5,024 | sector / request |
| `smsp__sass_average_data_bytes_per_sector_mem_global_op_ld.ratio` | 30.0521 | 28.3810 | byte/sector (max 32) |
| source `smsp__pcsamp_sample_count` | **7,999** | **4,956** | warp samples, separate runs |
| source `stalled_wait` | 2,507 (31.34%) | 1,055 (21.29%) | PC samples |
| source `stalled_barrier` | 897 (11.21%) | 747 (15.07%) | PC samples |
| source `stalled_math_pipe_throttle` | 1,237 (15.46%) | 356 (7.18%) | PC samples |
| source `stalled_long_scoreboard` | 523 (6.54%) | 325 (6.56%) | PC samples |
| source `stalled_selected` (issued) | 1,732 (21.65%) | 1,545 (31.17%) | PC samples |

Derived percentages: achieved occupancy is **77.57% FP16 / 77.76% FP8** of the
16.667% theoretical ceiling, and **101.27% / 101.52%** of the uniform-admission
arithmetic `288*4/(188*48)=12.766%`. Those arithmetic values are not a measured
admission trace and are not stall proof. Slowest-SM cycles are 19.9% (FP16) and
14.9% (FP8) above the per-SM average; fastest-SM cycles are 17.2% / 13.7% below
it. FP16 takes 1.649x the FP8 isolated duration; FP16 DRAM read is 1.981x FP8,
matching the 2x element size.

Reference ratios: shared-load wavefronts are 4.0443 vs the 4.0 ideal (101.1%);
FP16 global-load bytes/sector are 30.05 vs the 32 B/sector maximum (93.9%);
FP16 local-load sector hit is 98.8183% (1.18% miss); achieved occupancy is
77.57% FP16 / 77.76% FP8 of the theoretical 16.667% ceiling. No end-to-end
latency target was supplied; the isolated full-pass durations are the measured
reference for this evidence.

---

## 3. Diagnostics

### 3.1 FP16 — where the time goes

1. **Dependency latency and synchronization dominate the PC samples.**
   `stalled_wait` is 2,507/7,999 = **31.34%**, `stalled_barrier` 897 = **11.21%**
   (42.56% combined), and `stalled_math_pipe_throttle` 1,237 = 15.46%.
   `stalled_long_scoreboard` is only 523 = **6.54%**. The full report agrees in
   direction: average stalled warps per issue-active = 1.477 wait, 0.459 barrier,
   0.896 math-pipe throttle, 0.296 long-scoreboard. With DRAM at 10.12% of peak,
   the kernel is not DRAM-bandwidth bound.
2. **The top SASS-attributed sites are the two MMA bodies plus the stage copy.**
   The packed-Half score MMA `HMMA.16816.F16` at
   `shared/common/intrinsics.cuh:221` carries 1,320/7,999 = 16.50% of base
   samples (math 569, wait 563); the FP32-accumulating P×V MMA
   `HMMA.16816.F32` at `small_c1024_attention/common/intrinsics.cuh:17` carries
   925 = 11.56% (math 571, wait 197). The K/V stage-copy branch at
   `fp16/..._fp16.cu:53` carries 799 = 9.99%, almost all `barrier` (765).
   Predecessor-counter polling at `.cu:30` adds 251 samples, almost all
   `long_scoreboard` (239). Tensor-pipe activity is 51.91% of elapsed
   (61.50% of active); this is real tensor work that is not fully hidden. The
   three tensor/throughput metric names
   (`sm__throughput…`, `sm__pipe_tensor_cycles_active…elapsed`, and
   `sm__inst_executed_pipe_tensor_subpipe_hmma…elapsed`) are numerically
   identical in these reports, so treat them as one measured signal, not three
   independent confirmations.
3. **Spills are real but not established as the dominant cost.**
   197,824 local loads and 88,704 local stores exactly match the SASS spill
   read/write counts (286,528 total). The local load-sector hit rate is
   **98.8183%** (779,479 hits / 788,800 sectors; 9,321 misses; exact ncu metric
   `l1tex__t_sector_pipe_lsu_mem_local_op_ld_hit_rate.pct = 98.81833164300203`,
   i.e. ~98.82%), store hit 93.2134%. Only 12 direct `LDL`/`STL` PCs carry
   83/7,999 = **1.04%** of base
   PC samples. That tiny direct-PC share must **not** be read as the total spill
   runtime share: aggregate local metrics have no PC instances, and PC sampling
   only attributes sampled SASS sites. The root decision therefore does not
   trade a cap experiment for an unmeasured spill win.

### 3.2 FP8 — where the time goes

1. **Wait and barrier still lead; issue utilization is much higher than FP16.**
   `stalled_wait` is 1,055/4,956 = **21.29%**, `stalled_barrier` 747 = **15.07%**
   (36.36% combined), `stalled_selected` 1,545 = 31.17% (issued, not a stall),
   `stalled_math_pipe_throttle` 356 = 7.18%, `stalled_long_scoreboard` 325 =
   6.56%. Issue-active is 46.78% of peak versus 32.03% FP16; eligible warps are
   0.550/cycle versus 0.368. The same 2-CTA occupancy ceiling is present, but
   FP8 hides it better.
2. **Staging/barrier sites and QMMA issue pressure are the measured hotspots.**
   The stage-copy branch at `fp8/..._fp8.cu:50` carries 543 samples, almost all
   `barrier` (531, SASS `BSSY`); `.cu:51` adds 136 (barrier 101); barrier
   initialization at `.cu:102` adds 168 (barrier 100); the mbarrier phase wait
   at `.cu:98` adds 121 (`long_scoreboard` 101, SASS
   `SYNCS.PHASECHK...TRYWAIT`). Tensor sites: the FP32-accumulating P×V
   `QMMA.16832.F32.E4M3.E4M3` at `small_c1024_attention/common/intrinsics.cuh:31`
   carries 309 (math 140, wait 90); the packed-Half score
   `QMMA.16832.F16.E4M3.E4M3` at `shared/common/intrinsics.cuh:195` carries 186
   (math 83, wait 39). Tensor-pipe activity is 41.95% of elapsed (49.13% active).
3. **FP8 removes the spill traffic and halves the DRAM bytes.**
   Zero local load/store instructions, zero local sectors, and zero `LDL`/`STL`
   PCs; DRAM read is 6,717,696 B at 8.42% of peak (FP16: 13,309,696 B at
   10.12%). The FP8 L1 hit rate is only **1.009%**, but the L2 hit rate is
   **80.54%**; the FP16 L1 number (77.57%) is inflated by 1.14M local
   spill-sector accesses, so the two L1 hit rates are not comparable as
   cache-quality evidence.

### 3.3 Shared structure: the 512 B vector load is legitimate

SASS shows `LDS.128` for the K and V shared loads (`fp16 .cu:159`, `.cu:253`;
`fp8 .cu:153`, `.cu:248`) and `LDG.E.128` for the Q global load
(`fp16 .cu:129`; FP8 SASS at `sm_32_intrinsics.hpp:222`, call site
`fp8 .cu:123`). A 128-bit per-lane load over a 32-lane warp is 512 B, which
legitimately needs **4 × 128 B** shared wavefronts. Measured:
2,534,489/626,688 = **4.0443** wavefronts per shared-load instruction (FP16) and
1,253,431/313,344 = **4.0002** (FP8); `derived__memory_l1_wavefronts_shared_excessive`
is **0** for both, and `memory_l1_wavefronts_shared` equals its `_ideal` value
exactly. The separate hardware counters report 29,169 FP16 / 63 FP8 shared-load
bank conflicts against 2.53M / 1.25M load wavefronts. The source-derived ideal
comparison and hardware counters have different scopes; the zero derived excess
does not erase the measured hardware conflicts or establish their runtime cost.

For global loads, the generic “4 sectors per scalar load” ideal does not apply
to these 16 B/lane vectors: a full 512 B warp request spans 16 × 32 B sectors.
Measured `smsp__sass_average_data_bytes_per_sector_mem_global_op_ld.ratio` is
30.05 B/sector FP16 and 28.38 B/sector FP8 (max 32), and aggregate global-load
sectors/request are 7.83 / 5.44. That aggregate includes the single-lane
`LDG.E.NA` predecessor-counter polls at `.cu:30`, so it is not a per-instruction
decomposition and must not be read as a scalar 4-sector pattern.

The SASS rows above are 128-bit (`LDG.E.128` / `LDS.128`) and the launch block
is 4 warps of 32 lanes, giving a 512 B warp-level request. No per-instruction
active-lane mask metric is exposed by this report; the measured aggregate
sectors/request and bytes/sector are reported rather than an inferred lane mask.

### 3.4 The L1 hit-rate difference is spill traffic, not cache quality

FP16 total local sectors are 788,800 + 354,816 = 1,143,616, versus 287,360
global load+store sectors. FP8 has 0 local sectors versus 152,192 global
sectors. That is why FP16 L1 hit rate is 77.57% while FP8 is 1.01%, even though
FP8's L2 hit rate (80.54%) is essentially FP16's (81.86%). Do not compare the
two L1 rates without this composition.

---

## 4. Source / PC / SASS evidence

PC hotspots below are base stall categories only (the `*_not_issued` variants
are subsets and are excluded). Each line's samples are out of the source-run
denominator, 7,999 FP16 / 4,956 FP8. The pre-existing
`analysis/stall_hotspots_*.json` `totals_by_line` field sums each category **and**
its `_not_issued` subset (13,147 FP16 / 7,326 FP8 over all pcsamp metrics); do
not use those totals as a denominator. Only the base categories sum exactly to
7,999 / 4,956, and those are what `analysis/docs-evidence.json` records.

| precision | file:line | SASS at dominant sampled PC | base samples | dominant categories |
|---|---|---|---:|---|
| FP16 | `shared/common/intrinsics.cuh:221` | `HMMA.16816.F16` | 1,320 | math 569, wait 563 |
| FP16 | `small_c1024_attention/common/intrinsics.cuh:17` | `HMMA.16816.F32` | 925 | math 571, wait 197 |
| FP16 | `fp16/..._fp16.cu:53` | `@P2 BRA` (stage-copy control) | 799 | barrier 765 |
| FP16 | `small_c1024_attention/common/intrinsics.cuh:68` | `HADD2.F32` / `SHF` / `LOP3` cluster | 396 | selected 181, wait 167 |
| FP16 | `shared/common/intrinsics.cuh:298` | `@!P0 BRA` (mbarrier try-wait loop) | 307 | long 120, short 48, no-instr 45 |
| FP16 | `fp16/..._fp16.cu:30` | `ISETP.GT` consuming `LDG.E.NA` | 251 | long 239 |
| FP16 | `fp16/..._fp16.cu:106` | `LDCU.64` (barrier-init control path) | 142 | barrier 116 |
| FP8 | `fp8/..._fp8.cu:50` | `BSSY` | 543 | barrier 531 |
| FP8 | `small_c1024_attention/common/intrinsics.cuh:31` | `QMMA.16832.F32.E4M3.E4M3` | 309 | math 140, wait 90 |
| FP8 | `small_c1024_attention/common/intrinsics.cuh:68` | `SHF` / `HADD2.F32` cluster | 306 | selected 227 |
| FP8 | `fp8/..._fp8.cu:30` | `ISETP.GT` consuming `LDG.E.NA` | 193 | long 181 |
| FP8 | `shared/common/intrinsics.cuh:195` | `QMMA.16832.F16.E4M3.E4M3` | 186 | math 83, wait 39 |
| FP8 | `fp8/..._fp8.cu:102` | `UMOV` (barrier-init control path) | 168 | barrier 100 |
| FP8 | `fp8/..._fp8.cu:51` | `BSSY` | 136 | barrier 101 |
| FP8 | `fp8/..._fp8.cu:98` | `SYNCS.PHASECHK...TRYWAIT` | 121 | long 101 |

Line attribution for barrier categories often lands on the control-flow
instruction that guards the stage/barrier region (`BRA`, `BSSY`, `LDCU`), not on
a `BAR.SYNC` opcode; the category is the warp sample reason, not the SASS
opcode. The vector-load and MMA rows are direct instruction evidence.

The next-largest sampled lines are toolkit headers outside the 13-file repo
closure: `cuda_fp16.hpp:1731` (593 FP16 / 415 FP8) and `:2604` (355 / 201).
They are archived in `unpinned_toolkit_hotspots` with the actual header SHA-256
`8e472e719393c64be6a4e0a74b2489bb869431906b854be36a4c7a4703fc04aa`, but are
**not** used as repo source pins.

Exact per-line/per-metric samples, file SHA-256, PC examples, `sass_by_pc`
text, and the 12 FP16 `LDL`/`STL` PCs are in
`analysis/docs-evidence.json` (`source_hotspots`, `local_spill_pcs`,
`sass_evidence`). The old no-argument `sass_by_pc()` assumption is not used;
every SASS lookup is `action.sass_by_pc(address)` with the correlation-id PC.

Concrete source locations used above:

- `csrc/kernel_impl/small_c1024_attention/fp16/small_global_attention_chained_c1024_fp16.cu:10` (`__maxnreg__(208)`), `:16` (512-aligned shared storage), `:53/:57` (`CopyBulk`), `:129` (`__ldca` of `uint4`), `:159` (K `uint4` shared load), `:253` (V `uint4` shared load).
- `csrc/kernel_impl/small_c1024_attention/fp8/small_global_attention_chained_c1024_fp8.cu:10` (`__maxnreg__(208)`), `:50-55` (`CopyBulk`), `:98` (`ArriveAndWait`), `:102` (barrier init), `:123` (`__ldca` of `uint4`).
- `csrc/kernel_impl/shared/common/intrinsics.cuh:195` (`MmaE4`), `:221` (`MmaHalf`), `:244` (`cp.async.bulk`), `:296-298` (`mbarrier.arrive` asm and operand).
- `csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh:17` (`MmaHalfF32`), `:31` (`MmaE4F32`), `:68` (`WidenHalfPairFloat2`), `:76` (`AddFloat2Componentwise`).
- `csrc/kernel_impl/bottleneck_c1024_attention/common/global_attention.cuh:13-18` (element bytes / stage sizes), `csrc/kernel_impl/shared/common/warp_window32.cuh:10-13` (4-word `FWindowAFragment`).

---

## 5. Unsupported / unavailable (recorded, not fabricated)

- `dram__throughput.avg.pct_of_peak_sustained_elapsed` is **absent** on this
  SM120 report. The actual equivalent
  `gpu__dram_throughput.avg.pct_of_peak_sustained_elapsed` is used and named
  exactly (10.1172% / 8.4166%).
- `dram__bytes.sum` is absent; the actual
  `dram__bytes_op_read.sum` / `dram__bytes_op_write.sum` are used.
- `PmSampling_WarpStates` and the `source` set are **not installed** in Nsight
  Compute 2026.3.0. The source pass is `--set detailed --section SourceCounters`,
  as reviewed; no silent substitution.
- Absolute PM-sample timestamps are unavailable: `ncu_report` 2026.3.0 exposes
  no absolute per-sample timestamp accessor. The 278 PM series per full report
  (216 FP16 / 266 FP8 instances) are archived in collection order with
  `timestamps: null` and the concrete reason; some realtime series are all zero
  and are not used as activity evidence. See `analysis/pm_instances_*.json` and
  the compact example in `analysis/docs-evidence.json`.
- Aggregate local instruction counts are present in the source reports
  (197,824 loads / 88,704 stores FP16; zero FP8), but the local sector/wavefront
  metrics exist only in the full reports, and **none of these aggregates has PC
  instances**. They are never attributed to a source line; the sampled
  `LDL`/`STL` PCs are reported separately.
- `launch__local_size_bytes` is not an ncu metric. The 24 B stack / 44 B spill
  stores / 56 B spill loads are ptxas compiler resources (`build.log:19-20`),
  not runtime traffic.
- The vendor Sobel selftest report is **not** used as evidence for these
  kernels; only the four real-workload reports above are cited.
- No B200/TMEM/`tcgen05` section is present or assumed.

---

## 6. Root decision and next change

**Retain the current accepted binary for this release; do not run a register-cap
experiment.** The measured evidence does not justify trading a validated binary
for an unmeasured cap: spills are real (197,824 local loads / 88,704 local
stores, 286,528 total spill instructions) but hit L1 at 98.82%, and the dominant
base PC categories are `wait` (31.34% FP16 / 21.29% FP8), `math_pipe_throttle`
(15.46% / 7.18%), and `barrier` (11.21% / 15.07%), not long-scoreboard memory
latency (6.54% / 6.56%). A 224-register cap
is documented only as an **untested follow-up**: 208 registers already bind at
2 CTAs/SM, so a 224 cap predicts the **same 2-CTA capacity**; no speed gain is
promised and no experiment was run.

The dominant observed stall categories are wait, math-issue pressure, and barrier
around the MMA and staging path. These samples identify candidate dependencies
to investigate; no controlled intervention established a single causal bottleneck
or the benefit of changing the register cap. No production, collector, accepted
manifest, NPZ, docs, or raw NCU report file was changed here.

---

## 7. Reproduction (CPU only)

The four reports were parsed with the repo interpreter and the installed
`ncu_report` extras directory:

```powershell
.venv/Scripts/python.exe profile/small-attention-fp32acc-sm120-20261030/analysis/analyze_small_attention.py `
  --report profile/small-attention-fp32acc-sm120-20261030/reports/full_cyberpunk4k-b31_fp16.ncu-repz --tag fp16_full
.venv/Scripts/python.exe profile/small-attention-fp32acc-sm120-20261030/analysis/analyze_small_attention.py `
  --report profile/small-attention-fp32acc-sm120-20261030/reports/source_cyberpunk4k-b31_fp16.ncu-repz --tag fp16_source
.venv/Scripts/python.exe profile/small-attention-fp32acc-sm120-20261030/analysis/analyze_small_attention.py `
  --report profile/small-attention-fp32acc-sm120-20261030/reports/full_cyberpunk4k-b31_fp8.ncu-repz --tag fp8_full
.venv/Scripts/python.exe profile/small-attention-fp32acc-sm120-20261030/analysis/analyze_small_attention.py `
  --report profile/small-attention-fp32acc-sm120-20261030/reports/source_cyberpunk4k-b31_fp8.ncu-repz --tag fp8_source
```

The compact handoff is rebuilt from the same four files and source manifests:

```powershell
.venv/Scripts/python.exe profile/small-attention-fp32acc-sm120-20261030/analysis/build_docs_evidence.py
```

Neither command initializes CUDA, queries a device, or launches a kernel. The
`build_docs_evidence.py` script re-hashes all four reports and the 13 source
files per precision before writing `analysis/docs-evidence.json`.

---

## 8. Acceptance checks

- **Actual `ncu_report` metrics, source hotspots, and unavailable fields are
  archived:** yes. `analysis/docs-evidence.json` contains 98 exact-name metrics
  per kernel (80 full + 18 source), 43/40 repo-pinned source hotspot rows,
  `available` / `unavailable`, the 7999/4956 sampling denominator, and report
  identities. Full all-metric archives remain in `analysis/metrics_all_*.json`.
- **Both kernel lessons receive source-pinned measured evidence:** yes. FP16 and
  FP8 each have SASS-backed line hotspots with file SHA-256, separate full/source
  report SHA-256, and the sorted 13-file source closure (`42286f14…` /
  `b9060a59…`).

**CPU-only declaration:** this step ran CPU-only analysis and executed no GPU
commands. No CUDA, torch device call, telemetry, or new profiling was run.
