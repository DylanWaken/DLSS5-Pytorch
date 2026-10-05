# Execution and remaining acceptance gates

1. Pin upstream graph/KDA and verify original DLL provenance; statically extract
   the 153-record model and original cubins/PTX. The assets are available locally.
2. Maintain the strict loader and actual 71-entry graph. FP32/BF16 training uses
   existing PyTorch/ATen operators and autograd with FP32 master parameters and
   sensitive reductions. It is separate from quantized deployment arithmetic.
3. Maintain independent CUDA operators, ordered FP8/FP16 MMA and current-stream
   launchers, with explicit architecture targets and C++ device/shape selection.
4. Prepared deployment freezes independent weight/cache buffers and retains FP8
   publications as bytes. Production includes tuned GEMM epilogues, rotated C32
   blocks, fused expert W1/W2, residual-seeded GEMM and fused post70/head. v14
   passes 809 focused tests including full-network boundaries/capture and a
   255-test new-kernel memcheck with zero errors. Its full opt-in suite passes
   1,797 tests/seven subtests; 146 uninstalled private cases and one two-GPU
   case skip. v15c adds the full residual policy, private wider-window/surface
   kernels and an attention bias-alignment fix; 384 focused tests pass. v16
   deploys the measured complete-window C64/C128/C256 policy and passes 2,103
   full-suite tests/seven subtests; its dispatch memcheck has zero errors.
5. Continue measured window store/prefetch/short-K experiments. v17 passes
   420 focused tests and 368 new-kernel memcheck tests with zero errors.
   Four separate 240-case native proofs cover the original fusion and three
   scheduling/store variants. The selective 288-anchor policy is compiled
   in v19, which passes 2,784 full-suite tests/seven subtests, 288 new-kernel
   memcheck tests and 20 bounded racecheck cases with zero errors. Its private
   adapter and prepared word-load global attention are exact and faster than
   local composition. v20 integrates these and six C512 residual anchors; its
   all-architecture build and CPU diagnostics pass. Its full suite passes 3,056
   tests/seven subtests, and 179 public GPU tests pass memcheck with zero errors.
   Prepared FP8 graph 4K improves to 13.409 ms, while matched native trunk 4K
   remains 12.206 ms versus 6.027 ms (speed gate fails). v24 integrates the
   adapter/pool and C512 branch fusions plus global prefetch and completed C32
   tuning. Its full suite passes 3,968 tests and 42 subtests, with two second-GPU
   skips; packed FP8 4K measures 12.326 ms. Require exact comparisons, sanitizers and
   same-contract timing before C++ production policy promotion. FP32/BF16
   training remains independent of frozen deployment kernels.
6. Continuous tuning covers W1280..3840 and H720..2160, deduplicated into 931
   padded geometries. The expert-FFN family completed all 1,677 dispatch keys:
   3,354 fused and 16,770 composed candidates exact, with no coverage gaps.
   Its 1,680-row policy (including three earlier smaller anchors) is compiled
   into v14. The residual family completes 3,626 keys/11,996 candidate checks
   with zero failures and a 3,632-row policy compiled into v15c. Post70 also
   completes 931 geometries in both precisions, 1,862 physical cases and
   1,640 keys with no failures; its merged 826-row header is compiled in v17.
   C32 completes all 18,620 physical cases and 11,898 dispatch keys on its
   pinned v16 binary, with zero failures. Global attention completes all 166
   range cases (106 keys) on v23, plus four supplemental smaller cases; all
   four candidate paths are exact. The merged C32 and global policies are
   included in v24, whose public dispatch tests pass 342 cases and whose
   dispatch memcheck passes 339 cases with zero errors. Other families
   require their own completed GPU sweeps. Nearest
   configuration and endpoint clamping never resize the requested tensors.
7. The v24 original chained-attention trunk smoke matches all 74 eager
   boundaries, two native replays and poisoned captured endpoints at the
   720p/1080p/4K geometries. Ratios are 1.508/1.903/1.892: all speed gates fail.
   Its complete 931-geometry continuation passes 68,894 initial byte-exact
   boundary checks, with zero failures and no-op resume preserving the journal.
   All 931 speed gates fail: candidate/native ratios range 1.484–2.057, with
   unweighted geometry median 1.910. This covers the supplied FP8 trunk boundary.
   The original plain-attention entry has
   a documented race in this harness on SM120; chained is the stable default.
8. Original post70 RGB surface probes pass small four-phase cases and actual
   1080p/4K fields. The fourth head logit and temporal composition remain
   outside that observable contract. Six bounded pre0 feature captures prove phase-zero published FP8 adapter
   output at 16×24. The v23 DS entry proof additionally passes 12 bounded
   fixtures, checking both full published skip and pooled output; general native
   feature/noise generation remains outside these proofs. A persistent post70 range runner passes three smoke geometries,
   including actual 4K, but the full 931-geometry native range is not run. Renderer endpoints and live NGX host timing are
   not established by the 74-boundary trunk match.
9. Finish all-family resolution sweeps, complete the comparable native range
   measurements, and continue NCU/SASS-guided optimization until measurements
   support the requested 85% throughput and original-speed gates. Physical
   testing on RTX30/40-series remains separate from successful compilation.
10. Maintain the human-readable optimization walkthrough with source links,
    arithmetic lessons, actual measurements, failed experiments and open gates.
11. After replicating the original implementation's measured performance,
    write a causal postmortem of why the earlier implementations fell short.
    Distinguish measured bottlenecks, controlled source changes and unresolved
    explanations. Derive a detailed reusable skill set under `skills/` from
    that report: trigger conditions, profiling and PTX/SASS workflow, packing
    and fusion decisions, numerical and performance gates, failed approaches,
    and architecture/shape limits. Every recommendation must link to its
    supporting experiment; keep unverified hypotheses separate. This is a
    requested final deliverable, not evidence that performance parity has
    already been achieved.

12. The user's expanded direction makes original PTX -> CUDA/C++ reconstruction
    the primary implementation workflow for every deployment kernel in
    `kernel_status.md`, including ordinary blocks, view/transition wrappers,
    global stages, layout helpers, pre/post adapters and FP16 counterparts.
    Use the exact original entry as the starting point for arithmetic, tensor
    layout, fusion and synchronization. Existing kernels remain comparison
    implementations and fallbacks while replacements are qualified. Do not
    treat a family-core reconstruction as completion of its wrappers or Half
    variants. Track all original entries, distinguishing selected deployment
    paths from alternate DLL modes, so unimplemented paths remain visible.
    For each replacement retain PTX/source mapping, compiled SASS/resource
    review, original-output and exceptional-value checks, graph/stream/alias
    contracts, sanitizers, balanced same-contract timing, matched NCU/NSYS
    analysis, shape/phase coverage and eventual network integration. Infer
    Half layouts and accumulation independently rather than doubling FP8
    offsets. Small ISA helpers are allowed; opaque whole-kernel PTX/cubin
    execution is a diagnostic control, not the final implementation.

The final acceptance gates remain open. Intermediate speedups, targeted native
stage matches and passing internal equality tests do not establish those gates.
