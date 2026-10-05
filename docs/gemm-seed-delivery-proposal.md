# Seed delivery for the large ordered split GEMM

The next small experiment should change how the existing Half seed reaches its first MMA accumulator. It should not change the seed's numerical conversion, partition assignment or addition order. This is a proposal only: no new kernel was built or timed, and no policy is changed.

## Evidence from the saved binary

The [v34 4K profile](../profile/gemm-large-split-vector-fp8-b31-m2160-20261003T102031_055272Z/ANALYSIS.md) uses real block31 weights at M=2160, N=1024, K=4096 with four fixed K=1024 partitions. Its archived binary SHA256 is `213910ee7ad5a786064594b69109ab030f2284c47db0938142c41db9e7af9dc6`. The partial GEMM has 544 CTAs, 64 registers/thread, 40,960 bytes of user shared memory and no local-memory spills. Only partition zero reads the seed; the other partitions start from zero.

Before the first asynchronous A/W copy, the exact SM120 partial-kernel body contains **64 `LDG.E.U16` seed loads, 64 `HADD2.F32` conversion instructions and 32 `F2FP.F16.F32.PACK_AB` packs**. These are static instruction sites, predicated by the seed, split and boundary conditions. An interior seeded thread executes the 64 scalar loads to initialize its 32 packed Half2 accumulator words.

The first scalar load is at relative PC `0x990`; a corresponding first consumer is at `0xa00`. The first `LDGSTS` is much later, at `0x3e80`, and the first MMA is at `0x4430`. The source report attributes **630 of 880 long-scoreboard samples** to `Half-inl.h:62`, where these Half-to-float consumers wait for their seed loads. There are 4,270 samples across all recorded stall categories: 630 is not a percentage of execution time, and removing these loads would not imply a 71.6% speedup. Fixed waits, shared dependencies and math-pipe pressure remain substantial.

The archived partial-kernel elapsed tensor counter is 46.735%, with L2 data throughput 27.452% and DRAM 25.279%. All are below the requested 85% criterion. This cold NCU observation must not be added to or compared directly with resident complete-contraction timings.

Reproduce the instruction counts, sampled consumer PCs and address proof with:

```powershell
.venv\Scripts\python.exe -B outputs/v35-seed-load-cpu-review/analyze.py
```

The script verifies the archived binary/SASS hashes and writes [evidence.json](../outputs/v35-seed-load-cpu-review/evidence.json). It does not load Torch or execute GPU work.

## First experiment: load each Half pair together

Use one aligned 32-bit load for the two adjacent Half seed elements, then apply the **same existing Half-to-float-to-Half2 conversion** to its two components. Keep the old scalar helper for an unaligned pair, an odd row stride, or a right-edge single-Half tail. Check the actual pointer after the batch offset: an otherwise contiguous tensor may have a two-byte storage offset. The first private implementation should change only pair delivery; hoisting the uniform `split == 0 && seed != nullptr` condition is a possible subsequent ablation, because combining it with the first test would prevent attributing the result to pairing alone.

The CPU address proof verifies that the current eight warps cover all 16,384 Half values of an interior 128×128 seed tile exactly once. At N=1024, the current scalar instructions request 4,096 warp-level 32-byte sectors per interior CTA; an aligned pair-load mapping requests 2,048, for the same 32 KiB of useful seed values. This is an instruction-level address calculation. Cache reuse across instructions means it is **not** a prediction of halved DRAM traffic.

Do not directly inject the loaded bits into MMA in this first experiment. The existing helper converts Half to float and back; changing that sequence can change signaling-NaN handling or payloads even if every finite input is unchanged. Signed zero, infinities and subnormals also deserve explicit bit checks. Avoid a new finite-value scan or launch: that would confound a small delivery experiment.

Compilation is part of the test. A C++ packed load may be scalarized again, so the isolated draft uses a narrowly scoped `ld.global.b32` instruction with the default global cache policy. The candidate is useful only if exact-symbol SASS confirms the intended 32-bit loads on the aligned path, unchanged conversion/accumulator semantics and no added spills. NCU should confirm fewer dynamically executed seed loads. Static instruction count may increase because scalar fallback code remains present; check branch and code-size costs too. The assembly constrains delivery; it does not establish a timing win.

## Second, separate experiment: start the first operand copy earlier

The current compiled prologue completes seed delivery before issuing the first asynchronous A/W tile copy. For the private large `SPLIT=true, CHAIN=false` specialization, calculate the partition bounds and move that **same first `gemm_stage` copy and commit together before seed initialization**. Retain the original wait and shared-memory barrier afterward, and leave every subsequent stage unchanged. Execute this staging for every valid partition, outside the split-zero seed guard, exactly once; remove the old duplicate first-stage call. Seed values must still be fully initialized before the first MMA, and only split zero may read them.

This may overlap A/W movement with seed-load latency without adding shared storage or changing arithmetic. It may also increase live address registers, compete for memory queues, or be reordered by the compiler. Treat it as a separate ablation against the pair-load-only candidate. SASS must prove an earlier first `LDGSTS`, exactly the same dynamic copy count and waits, and unchanged ascending K MMA order. It is not an asynchronous-availability claim until compiled ordering is verified.

## Qualification before any promotion

Compare the new helper's result with the old helper across all 65,536 Half encodings in each pair position, including combinations of exceptional values. Then compare complete FP8 and FP16 seeded contractions against the unchanged ordered baseline: null seeds, all split positions, M/N tails, odd N, two-byte offsets, multiple batches, partition tails and graph replay with three actual input changes and poisoned retained outputs. Preserve immutable inputs/weights and guard checks. A CPU address proof alone cannot establish GPU conversion equivalence.

Measure baseline, pair-load-only and pair-load-plus-early-stage in balanced orders at actual M=288/640/2160 contracts. Include unseeded cases to expose any fast-path overhead. Check the partial kernel and complete contraction separately; retain the existing scalar or vector reducer unchanged within each comparison. Reprofile only measured winners. Keep all results private unless exactness, capture/sanitizer checks and the existing performance gate pass. None of this establishes native-DLL speed or the 85% target.
