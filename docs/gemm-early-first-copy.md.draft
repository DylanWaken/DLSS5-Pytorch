# Early first operand copy: isolated private experiment

This draft changes **only the placement of the first asynchronous operand stage** in the existing large ordered split GEMM. Scalar `seed2` delivery is unchanged. It is independent of the separately staged seed-pair experiment: neither its header, operators nor benchmark is required by this candidate.

No active source, public variant ID, policy or binary has changed. No compilation, GPU test, timing or NCU run has been performed.

## Exact change

`gemm_early_copy.cuh.draft` includes the existing `gemm_tiled.cuh` under `DLSSNR_GEMM_HELPERS_ONLY`, so it reuses the original helpers without defining the non-template reducer again. It contains a copied template named `early_copy_partial_kernel` with a compile-time restriction to the existing specialization:

- `SPLIT=true`, `CHAIN=false`, `BM=BN=128`, `WM=32`, `WN=64`, `LDM=true`.
- FP8 uses `BK=64`; FP16 uses `BK=32`; 256 threads and 40,960 bytes of explicit shared storage are unchanged.
- No epilogue fusion, grouping, residual fusion, raw side output, single-stage mode or vector residual path is enabled.

The partition bounds move above seed initialization. The original first `gemm_stage` call moves with them, using `first,last` in place of `start,end`. That helper issues the same copies and the same commit. The old first-stage call is removed. Every subsequent stage, wait, CTA barrier, ascending K MMA, Half accumulator operation and output store remains unchanged.

The launcher guarantees `0 <= first < last <= K`: it uses `ceil(K/partition)` partitions, a nonzero aligned K and partition, and returns before launching an empty result. Under the restricted specialization, `MULTI=false`, the outer partition loop runs exactly once, and its original `start,end` equal `first,last`. Therefore the moved call has the same addresses and predicates as before and cannot introduce a duplicate first stage.

Before the first unchanged `wait_group 0` and CTA barrier, the intervening work initializes scalar seed accumulators and copies register accumulators. It does not access the asynchronously written shared tile. The copy runs for every valid partition, including unseeded calls and partitions other than zero; only the unchanged seed initializer reads a seed for partition zero. No new synchronization or additional shared allocation is introduced.

The compiler may move work differently from the source. An earlier source call is a hypothesis about latency overlap, not evidence that the resulting SASS issues copies earlier or runs faster. Longer live address/register ranges or additional memory-queue pressure may offset a benefit.

## Private contract

The new registrations are:

- `_gemm_early_copy_partials(a, w, seed=None, partition=1024)` → Half `[B,P,M,N]`.
- `_gemm_early_copy(a, w, seed=None, partition=1024, reducer_variant=2)` → the existing 2D/batched output shape.

Their launcher namespace body is copied from `gemm_large_split_vector.cu`, with only private names and diagnostic strings changed. It retains precision/device validation, alignment copies, storage-offset handling, partition and grid bounds, current-stream launch, no-grad checks, allocation order and seed-only-partition-zero behavior. The complete contraction calls the existing scalar/vector reducer selected by its argument. P=1 retains the existing view of its own partial allocation. There is no new reducer implementation or automatic policy selection.

## Source and CPU evidence

`tools/draft_gemm_early_copy.py.draft` generates the three C++ drafts from pinned active sources. `tools/gemm_early_copy_proof.py.draft` applies the inverse transformation and requires the original kernel text to match exactly. It also compares the entire launcher namespace body after undoing the documented renames. The saved recipe and result are in `outputs/v35-early-copy-draft/`.

The bounded exhaustive schedule proof covers all `K/step` values from 1 through 64 and every legal partition in that interval with at most 32 parts, plus the real 4096/1024 contractions and additional odd-stage tails. It checks **4,100 contracts, 33,436 partition/seed cases and 184,536 stage events**. Removing only the seed/register-initialization markers yields identical copy/commit/wait/barrier/MMA/store event streams. All first stages appear once, all K steps remain ascending, and every initialized seed precedes the first wait/MMA.

The address proof checks **3,192 stage geometries**, including small/tail M/N, both precisions, every aligned K/partition combination through eight steps, both ping-pong buffers and zero-filled partial stages. Every 16-byte destination has one owner, is aligned, and stays within shared storage. Valid global copies stay inside the input matrix and partition; invalid vectors retain zero-fill behavior. The proof is exhaustive within these stated finite domains, not across every possible int32 shape. Separate closed-form tests cover near-int32 partition bounds.

Eight source/schedule/address tests and sixteen benchmark CPU tests pass. Negative cases reject duplicate/missing first copies, changed waits/barriers, incorrect end bounds, changed scalar seed delivery and reordered MMA events. CPU proofs do not establish floating-point equality or hardware race freedom.

The C512 agent independently ran all 24 CPU tests and reviewed the exact inverse transformation, fixed specialization, unchanged scalar seed helper, registration, and retained-output benchmark protocol. It found no source blocker. That review does not replace compilation or GPU validation.

## GPU tests and paired measurement plan

The GPU draft contains 90 planned cases. It retains independent per-partition baseline comparisons, both reducers, FP8/FP16, null and present seeds, M/N tails, storage offsets, strided inputs, empty output, invalid contracts and three changed poisoned graph replays with all captured outputs retained. Additional cases exercise one-step stages, odd-length final stages and every Half seed encoding through complete partial kernels, including exceptional values and two-byte offsets. These cases have been parsed but not executed.

`tuning/benchmark_gemm_early_copy.py.draft` is a separate copy of the corrected seed-pair benchmark protocol with candidate names changed. Its default six cases use real blocks 31/38 at actual global M=288/640/2160. `--precision both --include-unseeded` expands to 24. Real W1 and cubic activation produce the contraction input outside the event timing interval; the Half seed is prepared from the published skip and real scale. Both candidate and incumbent consume the same resident inputs and weights.

Partial-only timing compares the original and early-copy partial kernels. Complete-contraction timing uses the same existing reducer for both private paths and includes public variants 0, 1, 11 and 12 as additional controls. Other variants are explicitly unmeasured. Every path is measured in balanced forward/reverse orders. All timed outputs are retained, checked before/after timing against fresh ordered oracles, poisoned and replayed. Separate mutation graphs check independent input/seed byte changes in order 1,2,0. Each mutation graph and its outputs are released before another capture or timing group, preserving the stated one-graph memory scope.

The harness pins source, binary, catalogue, runtime/device and checkpoint identity before/after cases. It never exports a policy, claims DLL parity or passes the 85% roofline gate.

After the current pinned scan ends, a later build can activate the isolated files. Then run correctness and sanitizer checks before timing. Extract the exact new specialization SASS and compare it with the retained scalar-seed partial kernel: confirm the first `LDGSTS`/commit actually precedes seed initialization, no duplicate first copy exists, all subsequent copy/wait/MMA counts and order remain valid, and registers/spills/shared usage are acceptable. Only measured evidence can justify a later combined early-copy-plus-pair-load experiment.
