# Private fused expert FFN candidate

The initial implementation was measured through a private operator. Production
dispatch is now included in v13, with complete-model validation in progress.
Its scope is packed FP8
on SM89+, with C64, C128 and C256 expert families. FP16 and training are separate
paths and are not implemented by this candidate.

The private API accepts `A[M,C]`, `W1[C/32,128,C]` and
`W2[C/32,32,128]`, all resident uint8 tensors, and returns packed
`[M,C/32,32]`. Candidate 1 composes the existing grouped expansion with cubic
activation and E4 publication (EP2) and the grouped contraction with E4
publication (EP3). Candidates 2 and 3 fuse these operations in one CTA per
expert and row tile, with 128 and 64 rows respectively. The public
`inference_group_ffn` accepts arbitrary leading input dimensions and restores
them before the expert and output-channel axes. W3 and its residual
remain outside the fused operation.

Each W1 output accumulates through the existing K32 FP8 MMA instruction in
unchanged K order with a half accumulator. The native cubic half arithmetic
and saturating E4 publication then write the hidden tile to shared memory.
W2 consumes that tile in unchanged K32 order, again with a half accumulator,
and publishes directly to packed E4 output. No split-K, reassociation, or
floating-point atomic is introduced. The two phases reuse shared storage
after block-wide barriers. Expected shared storage is 40,960 bytes for
candidate 2 and 30,720 bytes for candidate 3. SM120 PTXAS reports 70 and 82
registers respectively, with no spills. SM90 has different register counts;
the SM120 timings below do not establish performance on other targets.

The saved 4K C64 expansion profile at
`profile/gemm-fp8-b2-522240x128x64-p0-v10-e2-l2-20261002T232351_145842Z`
measured 57.24% aggregate DRAM throughput, 41.67% L2 throughput, 19.19% tensor
activity, and shared-memory-limited 33.33% theoretical occupancy. Its hidden
output is 127.5 MiB. Removing the hidden write and subsequent read saves
255 MiB of global traffic for that invocation. This is the evidence behind
the fusion hypothesis; it is not a measured speedup or an 85% roofline pass.

All 78 focused CUDA tests passed on SM120. The suite covers every channel family, row tails across both tile
sizes, original checkpoint weights, publication edge cases, input immutability,
misaligned fallback, noncontiguous inputs, empty rows, validation, and CUDA
Graph replay on a nondefault stream. Its numerical reference forces the
original warp accumulator to avoid using the same shared-memory loading code
on both sides of the comparison. The benchmark uses identical resident
packed input/output contracts and checks multiple composed GEMM variants so
an unmeasured EP3 fallback cannot manufacture a fusion win. It writes evidence
only and does not promote any model route or kernel policy.

With binary `495b3d037808d85aed8adac89381ae5aff6d93b7f8f9f21beeff073f662b08ef`,
all 18 candidate results at nine actual 512/1080p/4K geometry shapes were
byte-exact. The best candidate was 1.61–2.29 times faster than the fastest
of the compiled policy or nine forced composed configurations. CUDA Graph
timing used 30 resident invocations and seven samples. For 4K, C64 measured
95.55 µs against 219.23 µs composed; C128 measured 54.35 against 112.11 µs;
C256 measured 45.67 against 73.38 µs. BM64 wins only the smallest tested C256
shape, M1152; BM128 wins the other eight. Full evidence:
`outputs/group_ffn_candidates_v12.json`.

The C64/M522240/BM128 full/source NCU run measured 111.20 µs with cold-cache
replay, 32.91% L2 throughput, 17.89% aggregate DRAM throughput, and 28.64%
tensor activity. The 85% gate fails. Actual occupancy was 31.82%, limited to
two CTAs by shared storage. The leading long-scoreboard samples occur at
the barriers immediately after `DEPBAR.LE SB0, 0`: 1,670 samples at the
first operand wait and 1,245 at the W2 staging wait. This supports testing
a K64 single-stage layout with a separate prefetched W2 region; it does not
justify a register cap on SM120. Original reports, source mappings, all
metrics, rule advice and SASS are retained in
`profile/group-ffn-fp8-c64-m522240-v2-20261003T002126_904841Z`.

The initial generated policy has nine SM120 entries, version
`19a5029e2db1841e`, keyed by architecture, channels, and flattened row count.
All kernel choice executes in C++. Unknown architectures and pointer
misalignment use the composed operators. Matching families use nearest
measured M, with endpoint clamp; tensor sizes and MMA order remain unchanged.
Only packed C64/C128/C256 prepared blocks use the fused route. FP16 and
half-storage graphs retain their previous paths.

The continuous range runner is operational:

```powershell
python run_tuning.py resolution-tune --operators group-ffn --packed-activations --precision fp8
```

Defaults enumerate every integer width 1280–3840 and height 720–2160: 931
padded geometries, deduplicated to 1,677 expert FFN shape keys. The runner
measures pending cases, checks exact output bytes and immutable inputs,
tests multiple resident composed baselines, and records CUDA Graph timings.
SQLite commits each case; `--max-cases` bounds an invocation and rerunning
resumes. GPU UUID, extension hash, runtime versions, timing settings, seed,
and benchmark-source hashes must match. Changed binaries or settings require
a new output directory. OOM and execution failures remain explicit coverage
gaps. Generated headers preserve other SM policies.

A real v13 bounded sweep over inclusive 1280–1281 by 720–721 completed all
nine shape keys from three geometries. All 18 fused candidates and 90 composed
baselines were byte-exact. One-case interruption, resume of the remaining
eight, and a subsequent no-op resume succeeded with isolated policies and
headers. Evidence is in `outputs/resolution-group-ffn-v13-smoke` using binary
`d102d79faedd7d02881be3d5d1775bdc821d4c61e7738c271f4aa121e12d0a89`.
This first run validated interruption and resume before the full sweep below.

The full v13 sweep subsequently completed all **1,677 shape keys across all
931 geometries**, covering every width 1280–3840 and height 720–2160 (3,690,401
integer input dimensions). All 3,354 fused candidate measurements and 16,770
resident composed configurations were byte-exact with immutable inputs. There
were no failed or unsupported cases. Ten calls per captured graph and five
samples per configuration selected fused BM128 for every case in this domain;
its speedup over the fastest composed configuration was 1.579–2.269 times.
The three smaller existing anchors remain, including the BM64 M1152/C256
winner. The merged C++ policy has 1,680 rows, version `ef32bc0605560067`.
Evidence, individual samples, exact coverage and resume identities are saved
in `outputs/resolution-group-ffn-v13-full/group-ffn-checkpoint.json` and its
SQLite journal, using the v13 binary hash above. This verifies the resident
expert pair throughout the requested domain; it does not establish original
DLL latency, full-network coverage, or the 85% roofline gate.

For bounded validation, use a narrow inclusive range, `--max-cases 1`, and
isolated `--output-dir`, `--policy-dir` and `--header-dir` directories, then
rerun without the case limit. `--operators all` includes expert FFN tuning
when packed FP8 is selected. Conditional composed EP2/EP3 fallbacks remain
listed separately from the fused family.

Remaining validation includes complete-model boundaries and measurements
against the affected native block and resident trunk. A speedup in this pair
alone does not establish DLL parity or range-wide performance.

## K64 single-stage experiment (v14)

The private `--k64` experiment stages one W1 K64 tile and prefetches W2 into a
disjoint shared region before W1 arithmetic. It preserves every MMA and half/E4
publication. All 33 focused tests and the combined new-kernel sanitizer run
passed; production dispatch remains unchanged.

`outputs/group_ffn_k64_v14.json` compares the new BM128/BM64 implementations
against the fastest existing fused tile with identical resident byte inputs
and outputs. All ten candidate results match the independent ordered-warp
reference and preserve inputs. BM128 speedups are 0.979× at 512, 1.041× at
720p, 1.067× at 1080p, 1.045× at 1440p, and 1.022× at 4K. BM64 is slower at
every tested size. These mixed results do not justify global promotion.

At C64/M138240, the cold-cache NCU profile measures 29.66 microseconds,
54 registers, 25,088 bytes shared memory, no spills, and 44.68% occupancy
against a 50% limit (three CTAs). L2 throughput is 32.25%, aggregate DRAM
17.72%, and tensor activity 25.36%; the 85% gate fails. The W2 completion
barrier has no long-scoreboard samples. The first W1 wait remains dominant:
737 long-scoreboard samples (538 not issued) at source line 45,
`BAR.SYNC.DEFER_BLOCKING` following `DEPBAR.LE SB0, 1`. Only 0.72 warps per
scheduler are eligible on average despite the higher occupancy. NCU also
reports 29% excessive global sectors and shared wavefronts. This suggests
first-operand latency and data movement remain limiting; higher occupancy
alone did not remove them. The next experiment needs to target those source
locations rather than assume additional buffering is beneficial.

Full/source reports, instruction-correlated samples, all metrics, SASS and
binary/source snapshots are retained at
`profile/group-ffn-k64-fp8-c64-m138240-v2-20261003T012838_002649Z`.
Binary SHA256: `20341e11d0d7f1e117dd6642bd603eab0587035c41d9dd6c01342f3dc5c1fac4`.
