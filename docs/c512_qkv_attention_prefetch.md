# Private C512 QKV/attention weight prefetch experiment

This experiment changes only the scheduling of cached B loads inside the three QKV dense loops. The private implementation was compiled and measured in v34. It improves the resident 720p/1080p cases but loses to the original fusion at 4K, so it is a shape-dependent candidate rather than a universal replacement. No measured public policy has been promoted from these anchor experiments.

The motivation is the archived block23/4K profile at `profile/c512-qkv-attention-b23-m8160-20261003T093402_229016Z`. Its independent analysis attributes 1,977 of 2,395 long-scoreboard samples to the first MMA in Q, K and V. Exact SM120 SASS shows the current iteration's B loads shortly before that consumer. The kernel reaches 42.25% tensor activity, below the requested 85% criterion. This evidence identifies a candidate experiment; it does not establish that prefetching is faster.

## What changes

The new private entry point is:

```text
_inference_c512_qkv_attention_prefetch(input, weight, head_scale, bias,
                                     phase=0, packed_output=True, implementation=1)
```

Its contract matches `_inference_c512_qkv_attention`. Implementation1 uses the new fused schedule; implementation0 and a canonical rather than dual-cache weight use the existing composition. Both Half and packed FP8 activation storage are supported, with Half or packed output containing the same E4 publication. The operator remains FP8 arithmetic and SM89+; it does not introduce an FP16 network route or autograd.

The C++ kernel, launcher and registration are exact clones apart from private symbol names and the kernel's helper namespace. They reuse `window_block_vector_prefetch::Exchange` and `qkv<512,KIND,true>` so that the shared type and consuming functions belong to the same namespace. There are no casts between structurally similar types.

The helper loads K0 once. Before computing K, it loads K+1 into a separate eight-word B bank. After the same sixteen MMA instructions, it carries that bank forward. K15 has no next load. Every output accumulator still sees K0 through K15 in that order; shared A loads, normalization, head scale, bias, attention, probability reduction and publication remain unchanged. The kernel still launches128 threads, four heads per CTA and four CTAs per shifted window, with32KiB shared storage and one CTA barrier.

## Arithmetic, local tests and compiled evidence

`tools/c512_qkv_attention_prefetch_proof.py` independently enumerates49,152 aligned B vector addresses, all786,432 cache bytes,98,304 shared A loads and393,216 per-lane MMA events. The maximum B byte is786,431. It also reuses the existing byte-bijection, shared-writer, publication-transpose and cropped-output ownership proofs. Source reversal proves that the new kernel/launcher/API differ only in the named substitutions and that helper mapping and normalization code match the retained baseline.

Six CPU proof tests and18 benchmark selection/restoration tests pass. On v34 the dedicated GPU suite passes66 cases, with one second-GPU case skipped. The same66 cases pass under memcheck; eight mutated/captured cases pass racecheck with zero hazards. The retained original-fusion suite also passes66 cases plus its second-GPU skip, both normally and under memcheck. These counts come from `outputs/v34-private-tests.xml`, `outputs/v34-private-memcheck.xml` and `outputs/v34-prefetch-racecheck.xml`; the sanitizer logs report zero errors/hazards. The tests cover phases, tails, both input/output storage forms, real-weight upstream computation, graph mutation, capture-time cache preparation, fallback, alignment, validation and projection endpoints.

Exact-SM120 SASS inspection confirms the intended load placement in all four input/output storage variants. Each Q/K/V loop initializes K0, requests K+1 before the current16MMAs, carries the eight B words afterward, and disables the final K16 load and carry. No accumulation order, barrier or shared-A mapping changes. The strict CPU SASS audit passes11 tests and saves its evidence under `profile/c512-prefetch-sass-v32-v34-cpu-verified/`.

The original fusion uses128 registers/thread. Prefetch uses125 with Half input and126 with packed input; all variants have zero stack/local storage and one CTA barrier. Static shared memory remains32KiB, with a1KiB driver reservation. The resulting three-CTA/SM limit is unchanged, so the lower register count is not an occupancy improvement. The audit finds360 enabled carry MOVs per head warp; this is a real added cost to balance against hidden latency.

## Direct incumbent comparisons

Both paired benchmark drafts select paths explicitly. Defaults retain the existing composition-versus-fused behavior. The required new comparison is **current fusion versus prefetch**, with composition as a separate control:

```powershell
.venv/Scripts/python.exe tuning/benchmark_c512_qkv_attention.py --baseline-operator fused --candidate-operator prefetch --output outputs/c512-prefetch-component.json
.venv/Scripts/python.exe tuning/benchmark_c512_qkv_public.py --baseline-operator fused --candidate-operator prefetch --output outputs/c512-prefetch-fullblock.json
```

For a composition control, change `--baseline-operator` to `composition` and retain `--candidate-operator prefetch`. These are independent paired runs and must not be combined as simultaneous timings. Both direct paths read the same cache snapshot and actual FFN input. The component fixture constructs the FFN before either timed call; the full-block fixture executes the actual public FFN inside both timed graphs. Full-block interception uses a temporary API proxy, leaving public model routing unchanged. The public projection consumes each private packed endpoint normally.

Every existing retained-output, first-replay initialization, fresh before/after reference, input/weight immutability, changed-input poisoned replay, both-order timing and source/binary identity check remains text-identical. Reports identify both selected private operators explicitly. The timing protocol version changes so that the new selectable comparison is not relabeled as historical v32 evidence.

## Measured v34 crossover

Both direct paired reports complete all nine cases: blocks23,30,47 at720p,1080p and4K, with exact outputs and changed-input poisoned graph replays. The source reports are `outputs/c512_qkv_prefetch_component_v34.json` and `outputs/c512_qkv_prefetch_public_v34.json`. Each speedup below is original-fusion time divided by prefetch time; values below1 mean prefetch loses.

| Input anchor | C512 field / M | QKV-attention component speedup | Whole public block speedup |
| --- | --- | ---: | ---: |
| 1280×720 | 24×44 /1056 | 1.2355–1.2435× | 1.0907–1.0948× |
| 1920×1080 | 36×60 /2160 | 1.2119–1.2268× | 1.0653–1.0666× |
| 3840×2160 | 68×120 /8160 | 0.9128–0.9145× | 0.9758–0.9780× |

These are resident GPU comparisons in the same binary. Component timing excludes the upstream FFN; whole-block timing includes its unchanged public FFN and projection. They are not full-network measurements or native-DLL speed claims. Ratios from an earlier composition-versus-fusion report must not be multiplied into these ratios to manufacture a three-way policy.

## What NCU explains, and what it does not

Two new cache-flushed full/source profiles isolate the prefetch kernel: `profile/c512-qkv-attention-prefetch-b23-m8160-20261003T101425_578453Z/` and `profile/c512-qkv-attention-prefetch-b23-m2160-20261003T101509_439682Z/`. Their exact operator, symbol, device, binary, fixture and correctness proofs are pinned by the profiler; its CPU verifier passes71 tests. Each run has an `ANALYSIS.md` and a reproducible CPU extraction.

| Cold NCU counter | Prefetch4K | Prefetch1080p |
| --- | ---: | ---: |
| Duration |33.696µs |28.672µs |
| Tensor pipe, elapsed peak |48.955% |15.217% |
| L2 data bandwidth, elapsed peak |13.589% |8.381% |
| DRAM throughput, elapsed peak |9.060% |4.261% |
| CTAs / resource-limited waves |540 /0.957 |160 /0.284 |
| Long-scoreboard source samples |1,690 /49.65% |1,637 /60.76% |

Compared with the retained v32 cold4K profile, the three dominant waits move from first-MMA consumers to B-bank carry MOVs. Long-scoreboard share falls from60.69% to49.65%, and eligible warps/cycle rise from0.238 to0.312. Global load requests and sectors are unchanged, with nearly equal cache hit rates. Executed warp instructions rise8.69%. This supports latency overlap, not a traffic reduction.

The cold4K profile is faster than the old v32 profile despite lower measured SM frequency (2.318 versus2.440GHz), while the resident same-v34 comparison loses. Added carry work and reduced benefit under resident caches are a plausible tradeoff, but the current cold reports do not establish the cause of that crossover. A matched same-v34 resident-cache source comparison would be needed to make that diagnosis.

At1080p there are only160CTAs for188SMs, so at least28SMs receive no CTA. Low device-wide tensor utilization is therefore partly a launch-size limitation. The carry instructions still dominate long-scoreboard samples. There is no equal-shape original-fusion NCU report here, so its source-level improvement cannot be quantified from the4K reference.

Both typed85% hardware gates remain **FAIL**. The next policy step is a balanced composition/fusion/prefetch sweep over every actual C512 field, phase and weight member, retaining explicit composition guards at rejected sizes. The original4K fusion remains the measured incumbent. Native reproof and full-network comparisons remain separate gates before public promotion.
