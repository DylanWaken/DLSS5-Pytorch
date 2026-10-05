# Private batch-one, four-partition Half reducer

This is an uncompiled, unmeasured private experiment. It specializes the existing vector8 reducer for the actual global FFN output `[B=1,P=4,M,N=1024]`, retaining the generic reducer for every other supported contract. There is no public variant ID, policy change or model hookup.

## Why this particular change

The retained v34 profile at `profile/gemm-large-split-vector-fp8-b31-m2160-20261003T102031_055272Z/` measures the real block31 FFN contraction with M2160, N1024, K4096 and four architectural K1024 partitions. Its vector reducer reaches81.4327% elapsed DRAM throughput, below85%. All691,200 theoretical sectors are ideal. Improving the output map again is therefore not the target.

The existing reducer computes a per-thread64-bit batch quotient/remainder and handles a variable number of partitions. Batch one removes that division; fixed P4 removes the generic partition loop. The profile also attributes1,232 of1,324 source samples to long-scoreboard consumers of loaded partials. The new source requests all four vectors before its first arithmetic operation, but only compiled SASS can show whether that ordering creates useful load-to-consumer distance.

The launch remains256 threads. V34 vector8 uses40 registers and has100% theoretical occupancy,84.61% achieved occupancy and0.139 eligible warps per scheduler. More resident warps or a smaller block is not automatically beneficial. This experiment keeps block size, vector width and useful traffic fixed so that its indexing/scheduling change can be measured separately.

## Exact contract and arithmetic

Private entry points:

```text
_ordered_partition_reduce_b1p4(partial: Half[B,P,M,N]) -> Half[B,M,N]
_gemm_large_split_b1p4(a, w, seed=None, partition=1024) -> Half output
```

The reducer requires the same CUDA/SM80+, contiguous Half,1…32 partitions and no-backward contract as the retained private reducer. Its specialized path additionally requires B1, P4, nonempty storage,16-byte alignment, M×N divisible by8, and at most `INT_MAX/4` vectors per partition. Empty, batched, different-partition, misaligned, odd-plane or larger-index cases fall back to `_ordered_partition_reduce(...,2)` in C++. There is no Python selection logic.

Thread i loads eight Half values from vector i in each plane. It initializes from the **exact partition0 bits**, then performs `Half(p0+p1)`, `Half(sum+p2)`, `Half(sum+p3)` independently in each lane through the retained `__hadd2` intrinsic and operand order. It does not add positive zero, promote to float or use a reduction tree. Signed-zero and NaN-payload equivalence are required GPU checks; source algebra alone does not establish their compiled behavior.

For V vectors per plane, the four vector addresses are `i`, `i+V`, `i+2V`, `i+3V`. The host bound ensures the largest valid integer index is at most `4V-1 < INT_MAX`; padded launch threads return before any access. Each vector is16 bytes aligned, each output vector has one writer, and the mixed-radix mapping `(partition,i,lane)` covers every input Half exactly once. No shared memory, barriers or atomics are added.

The complete-contraction entry point calls the **same existing** `gemm_large_split_partials_cuda` as `_gemm_large_split_vector`. FP8/FP16 partial arithmetic, architectural partition boundaries, source normalization and the rule that only partition0 contains the initial seed remain in that retained function. P1 uses its existing direct output view. The experiment changes only the final reducer.

## Draft verification

The pure-CPU proof enumerates every active/tail thread for V1,255,256,257 and the actual M288,640,2160 global fields. It also checks the int32 boundary symbolically at selected edge threads. Eight proof cases pass;12 CPU tests cover routing, address/order, actual geometry and benchmark evidence gates. The report is `outputs/ordered_reduce_b1p4_cpu_proof.json.draft`.

The staged GPU suite has55 parameterized cases. It includes finite ordered oracles; all65,536 Half encodings at every partition position; all-negative-zero and rounding-sensitive cancellation; aligned and misaligned guarded views; captured three-output poisoned replays on a nondefault stream; empty and invalid contracts; FP8/FP16 seeded/unseeded complete contractions; and batched/empty generic fallbacks. These GPU cases have **not** been executed.

## Paired measurement

`tuning/benchmark_ordered_reduce_b1p4.py.draft` retains the existing real-weight fixture and benchmark checks. It creates three actual partial tensors from real block31/38 W1/W2 weights and synthetic published skips, independently checks each architectural partition, and compares:

* Reducer only: existing scalar, existing vector8 and B1/P4, on the same actual resident partials.
* Complete contraction: legacy split, the same-helper scalar path, the same-helper vector8 path, B1/P4, current auto selection and optional explicit public peers.

The default timing scope excludes W1/seed preparation and CPU allocation/capture. Complete-contraction replay includes both partial generation and reduction. Optional FP8 publication stays inside every compared call. Partial scratch is included in each graph's retention budget. All captured outputs are checked; both timing orders, fresh post-timing references, actual1→2→0 input changes, poisoned replays and immutable operands remain mandatory. Source, binary, driver/runtime and checkpoint identity are checked before and after every measured case.

After root activation/build, the suggested first comparison is:

```powershell
.venv/Scripts/python.exe tuning/benchmark_ordered_reduce_b1p4.py --execute --precision both --variant 11 --variant 12 --output outputs/ordered_reduce_b1p4.json
```

Repeat with `--reverse` in a new output file; use `--publish` for the raw-plus-packed FP8 contract. CPU enumeration omits `--execute`. The new candidate must beat the fastest measured incumbent by more than3% overall and in both timing directions to pass the local timing gate. A reducer-only win does not establish complete-contraction, whole-network or native-DLL speed.

Before timing, inspect exact SM120 SASS for four128-bit loads, one128-bit store, exactly three ascending Half additions per lane, no division/remainder/generic loop, no spills, and the actual distance between load producers and first consumers. The number of live loaded words may affect registers or occupancy. Neither useful overlap nor an85% result is claimed until compiled and measured.
