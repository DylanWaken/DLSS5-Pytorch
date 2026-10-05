# C512 QKV and attention: proposed public integration

This is a staged design and implementation, not an activated deployment policy. The three C++ drafts expose a prepared-weight operation, a public QKV/attention operation and compiled policy diagnostics. The initial generated header has no measured rows and selects the existing composition everywhere. No training path changes.

## Why measure the entire block

The first fused kernel replaces the C512 QKV GEMM, attention and the publication consumed by the projection. It retains every K32 accumulation step, Q/K normalization, head-scale rounding, attention denominator and output publication. Its dual weight cache is prepared once, outside inference, with the original row-major weight in slice 0 and the vector-load layout in slice 1.

The v32 nine-case component benchmark showed a gain even at 720p, but the corresponding complete public blocks improved only 2.4–2.9%, below the required 3% gate. At 1080p they improved 7.2–7.7%, and at 4K 27.3–29.0%. These are local byte-exact composition comparisons, not native DLL parity or a roofline result. The source and binary identities are retained in `outputs/c512_qkv_public_paired_v32.json`.

The v34 prefetch candidate is useful but not universally better: paired against the original fusion, it improved the 720p/1080p complete blocks by about 6.5–9.5% and regressed the 4K blocks by about 2.2–2.4%. These independently timed anchor experiments motivate a three-way sweep; their ratios must not be multiplied or their raw medians compared across runs to manufacture a policy.

## Public interface and fallback

| Entry point | Contract |
| --- | --- |
| `prepare_c512_qkv_weight(weight)` | Snapshot a `[1536,512]` weight. Return a dual uint8 cache only when the compiled device policy contains a fused choice; otherwise return an owned canonical tensor. |
| `inference_c512_qkv_attention(input, weight, head_scale, bias, phase, packed_output)` | CUDA BHWC C512; canonical or prepared FP8 weights, or the existing FP16 composition. All allocation and dispatch use the current CUDA device/stream. |
| `selected_c512_qkv_variant(sm, fp8, packed_input, packed_output, batch, phase, m)` | Diagnostic selector prediction. It does not trace kernel execution. |
| `compiled_c512_qkv_policy_version()` | Digest of the generated selection table and catalogue contract. |

The catalogue is 0 = ordered public composition, 1 = the original private fusion, 2 = the separately measured B-prefetch fusion. The first policy domain is SM120, packed FP8 input/output, B1 and the actual normalized phase. Half input storage, Half output, FP16 weights, other devices or missing families select composition. FP16 remains supported on SM80+, FP8 on SM89+; measured acceleration is initially restricted to SM120. FP16 canonical preparation and inference remain separately validated fallbacks.

Selection is entirely C++. Each exact family uses nearest measured M, choosing the lower M on a tie and clamping below/above its measured endpoints. Every measured M remains in the table, including explicit composition guards. A new fast anchor cannot silently overwrite a measured rejected anchor. A supplied canonical weight always uses composition, regardless of selector prediction.

The draft validates shape, dtype, device, no-grad and bounded indexing before launching. Existing private launchers handle contiguous/aligned copies for FP8. Outputs are newly allocated; no aliasing or mutable output schema is introduced. Empty B returns an empty result and the selector reports composition.

## Prepared model integration plan

The eventual Python edit is a fixed operator hookup, not a selector. Only `PackedInferenceBlock.forward` at C512 changes: after its unchanged FFN, call the new public QKV/attention operation and pass its packed result to the existing residual projection. W1, branch FFN, W4, projection and the raw endpoint needed by block 30 remain unchanged.

During C512 FP8 preparation, call `prepare_c512_qkv_weight` for the qkv operand. When it returns a dual cache, register `_window_qkv_cache` and retain `qkv = cache[0]`. This reuses the existing `InferenceBlock._apply` alias restoration for module/device moves. The canonical qkv shape and state-dict operand remain available, and the prepared model still owns a frozen snapshot unaffected by subsequent source-weight mutation. Cache metadata should identify this QKV-only layout separately from the wider whole-window caches.

The native benchmark's `prepared_block` helper must acquire the identical cache and canonical alias, with helper-vs-model regression tests. This is part of activation, not an inference-speed shortcut. No active model/helper file is changed by this draft.

The continuous scanner deliberately targets the current pre-integration public block. Its strict interception must fail if a future model hook bypasses the expected QKV-linear/attention sequence. Complete this pinned scan first; after public integration, use fresh identities and the public API/native end-to-end proofs rather than resuming the old interception journal.

## Continuous measurement domain

The existing 720p–4K geometry enumeration contains 931 network geometries. Their C512 layer has **258 distinct H×W fields but only 166 distinct M values**. Attention depends on the field and phase, so M alone cannot identify a correctness or timing sample.

The manifest therefore enumerates **4,128 physical contracts**: every distinct B/H/W field and all sixteen actual C512 block weights/phases, including block 30's raw output. It records every source geometry represented by each physical contract. A policy anchor aggregates every field with that M and all four weight members of its phase. Only a fully measured phase family may export, even when a partial journal already contains some promising anchors. Custom CLI bounds may create smaller experimental manifests, but production policy export requires the complete default 720p–4K physical domain.

Each physical case uses one prepared public block, one dual cache and one mutable input shared by all three graphs. FFN computation remains inside every timed full-block call. The graphs retain all per-call outputs simultaneously, under one combined byte budget. The baseline output and both candidate outputs must have disjoint nonempty storage.

The scanner records randomized full permutations of `[composition, fusion, prefetch]`, each paired with its exact reverse. All three paths use the same baseline event sample in each trial. Candidate eligibility requires more than 3% complete-block improvement overall and in both relative pair orders for every represented field and weight. Passing peers need no 3% margin over one another: the chosen peer maximizes the worst baseline-normalized improvement, with mean normalized ratio and variant ID as deterministic tie breakers. Raw medians from separate runs never rank peers.

Before and after timing, an independent ordered whole-block composition checks every captured endpoint. Attention retains the established separate oracle and shared scalar helpers; this limitation is explicit. Three input changes in order 1, 2, 0 poison all retained outputs, replay all graphs and recheck every output, input, weight and cache. Recorded host-call audits ensure the offline proxy redirects only the single private fusion operation; W1/branch/W4/projection selector predictions remain identical.

## Resume and export trust

The SQLite journal commits each physical contract. JSON exports are periodic and on exit. Every pre-case, post-case and export identity check pins the installed binary, GPU/driver/runtime, compiled policy versions, active sources, scanner sources, candidate catalogue, full requested domain, timing settings, checkpoint manifest and controller settings. The bounded decoded-weight cache uses immutable CPU masters and clone-on-request behavior; it does not relax these identity checks.

Resume verifies each journal key against its saved physical contract and reruns nested proof checks. An interrupted case is never committed. A no-op completed resume still checks identity. Export requires an intact local proof manifest tied to the same binary and SM, plus at least 66 local GPU tests, 66 memcheck cases and eight racecheck cases for each included candidate. Shared sanitizer validation rejects a log containing any later nonzero summary. These are local prerequisites, not native evidence.

Export produces only `sm_120_c512_qkv.json.draft` and `c512_qkv_policy.h.draft`. Native parity, native speed and the 85% roofline gate remain false in this report. Activation, a rebuild and fresh native comparisons are separate steps owned by the main task.

## Staged files and validation

* Public C++: `csrc/kernel_launcher/c512_qkv_dispatch.cpp.draft`, `csrc/torch_api/c512_qkv_dispatch.cpp.draft`, `csrc/kernel_launcher/c512_qkv_policy.h.draft`.
* Scanner: `tuning/c512_qkv_policy.py.draft`, `tuning/c512_qkv_measure.py.draft`, `tuning/resolution_c512_qkv.py.draft`.
* Tests: `tests/test_c512_qkv_policy_cpu.py.draft` and `tests/test_c512_qkv_public_dispatch.py.draft`.

The CPU suite covers the complete geometry counts, same-M field aggregation, shared-baseline timing, guard anchors, corrupted nested proof, proxy scope and commit/resume identity drift. The staged GPU tests cover canonical/prepared/cache FP8, actual FFN/weights at the three anchors, FP16 composition, mutable capture, alignment, source snapshots, empty/invalid input, no-grad and multiple-device rejection. They have not been executed for this public wrapper.

After activation, the CPU-only default command is `python -m tuning.resolution_c512_qkv`. Root may run an exclusive-GPU preflight with `--execute --max-cases 3` and the eventual complete scan by omitting the limit. The default catalogue includes both fused alternatives; use a new journal if the catalogue or any pinned source changes. Keep the public model hook inactive until this interception scan is complete.
