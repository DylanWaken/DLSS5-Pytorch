# Reconstructed CUDA code conventions

The deployment source should explain the algorithm recovered from the DLL: tensor tiles, physical layouts, accumulation order, staging and publication. A reader should be able to follow those concepts through compact loops and named fragment arrays. PTX remains the evidence for those choices; a long list of renamed PTX registers is not an acceptable final implementation.

The earlier register-transcript naming pass and its qualification records are preserved unchanged in [CODE_READABILITY_HISTORY.md](CODE_READABILITY_HISTORY.md). Its timings and source conventions apply to that historical implementation. [SOURCE_LAYOUT.md](SOURCE_LAYOUT.md) describes the shared semantic implementation and its source ownership.

## Names describe values and storage roles

Use CapitalCamelCase identifiers, an `F` prefix for internal structs, an `E` prefix for enums and Unreal-style `b` names for booleans. CUDA built-ins, vector members and externally fixed API names retain their required spelling.

| Prefix | Role | Examples |
| --- | --- | --- |
| `r_` | Register value, fragment, local array or local arithmetic index | `r_Accumulator`, `r_Weights`, `r_KSubtile`, `r_SourceLane` |
| `r_b` | Register-held boolean predicate | `r_bValid` |
| `s_` | Physical shared allocation, address, byte offset or shared-storage quantity | `s_Storage`, `s_StageBytes`, `s_BarrierOffset` |
| `sl_` | Logical shared coordinate before a documented swizzle/bank mapping | `sl_Row`, when that logical coordinate is actually present |
| `g_` | Global pointer, byte address or global-layout index | `g_Record`, `g_TokenGroup`, `g_OutputChannel` |

The role takes precedence over where the compiler holds a value: a shared byte address gets `s_` even if the address itself is in a register. Do not add an invented logical-shared coordinate merely to use `sl_`; document the mapping where one exists.

Name axes explicitly: M/spatial fragments, N/channel groups, K/reduction subtiles, row halves and physical word positions. For example, `r_Input[SpatialFragments][ReductionSubtiles]` and `r_Weights[ReductionSubtiles][ChannelGroups]` show how a tensor-core tile is consumed. Comments should explain the layout or scheduling reason, not paraphrase each assignment.

## Write the recovered algorithm

Use short force-inlined helpers, compile-time profiles and loops over named axes. Keep distinct native schedules explicit when their warp ownership, fusion, tensor-core K dimension or synchronization differs. Share the body where only dimensions or data-access/publication policies differ.

A shared helper must preserve the contract that matters:

- Half arithmetic order and each rounding point, including native FMA versus separate multiply/add.
- FP8 conversion and packing order; the denominator can consume Half values before FP8 publication.
- Cache modifier, physical address, alignment and out-of-bounds behavior of a load.
- Warp participation, barrier arrivals, expected copy bytes and counter acquire/release behavior.
- Residual scaling, split-reduction order, output layout and padded-row publication.

Do not replace a native exponential surrogate with `exp()`, widen an intermediate for convenience, or substitute a generic GEMM layout without new correctness evidence. Equivalent real-number formulas need not produce the same Half/FP8 results.

All inline PTX belongs in [intrinsics.cuh](../csrc/kernel_impl/intrinsics.cuh). Each wrapper should state what the instruction does and any rounding, FTZ, synchronization or address-space behavior it preserves. Operation files should call those primitives through meaningful arithmetic/memory helpers, not reproduce assembly blocks or register-number instruction streams. Unused transcript-era helpers have been removed; keep the shared utility layer limited to primitives used by the current algorithms.

## Numerical constants and known versus inferred meaning

Name nontrivial numerical constants `CONST_*` and make them `constexpr`. Shared activation, normalization and attention constants live in [numerical_constants.cuh](../csrc/kernel_impl/numerical_constants.cuh). Frontend hash and color/filter constants stay in their common frontend helpers when their scope is specific to those operations.

For encoded floating values, document the exact bits, decoded value and observed arithmetic role. Record a formula where it explains a stride or coefficient relationship. For example, normalization epsilon is a packed Half bit pattern, not the integer value of that pattern; a matrix stride should show its channel product or a named profile constant.

Separate three kinds of statement:

- **Observed:** the PTX clamps an affine Half value, shifts the packed encoding and adds a constant.
- **Derived:** the recorded bounds constrain the encoded exponent range, or the matrix stride equals the product of its physical dimensions.
- **Unknown/inferred:** the original coefficient-fitting rationale, training objective or intended filter name when no source establishes it.

Do not invent a rationale for a recovered constant. Keep ordinary loop bounds and obvious zero/one initializers readable; reserve detailed explanation for values whose meaning is otherwise hidden.

## ABI and dispatch boundaries

Exported kernel names retain their `_fp8` and `_fp16` suffixes and existing namespaces. ABI types named `Parameters` or `ClearParameters` are deliberate exceptions to the internal `F` convention because their names participate in mangled CUDA symbols. Preserve field order, widths, alignment, byte offsets and the host/device declarations in `kernel_launcher/kernel_abi.h`.

The stable roster is **76 mathematical/frontend entries + four shared repack entries + one counter clear = 81 exports**. It is not 81 independent algorithms. Channel suffixes identify an exported configuration; they do not require a separate implementation file or copied body. Python/Torch entry names, native DLL symbols and historical provenance records keep their established spelling.

## Source quality and compiled performance are separate

Readable source, correct arithmetic and fast compiled code are independent gates. A template or loop can preserve every result while producing more address instructions, longer live ranges, spills or a different dependency schedule. Conversely, a previous binary's matching speed does not qualify a newly rewritten source.

Use this evidence sequence for each change:

1. **Source and ABI:** inspect the algorithm, layout, ownership and exported contracts; run the structural inventory.
2. **Semantic proof:** compare native PTX dependencies/addresses where practical, then execute the compiled candidate against the native kernel or graph boundaries.
3. **Runtime behavior:** verify guards, scratch/counters, padding, poisoned replay and changed-input graph replay for the claimed route.
4. **Performance:** use matched buffers, launch geometry, graph capture and repeated execution-order-balanced measurements. Attribute regressions with Nsight Compute/Systems and SASS before changing the schedule.

CPU symbolic traces do not establish tensor-core numerical execution or GPU speed. Compiling without spills does not establish performance parity. Only measurements of the tested compiled snapshot establish the 1% acceptance criterion. The final graph qualification below establishes that latency result for its stated scope; it does not establish a hardware-roofline percentage.

## Final semantic qualification

The integrated semantic extension passes the graph acceptance gate in both FP8 and FP16 at 720p, 1080p, 2K/1440p and 4K on the RTX PRO 6000 Blackwell (SM120). The [portable qualification receipt](semantic_graph_qualification.json) pins the extension, harness, native cubins and schedule hashes for all eight precision/resolution combinations.

Each combination passes all **74 physical graph boundaries** with exact native/candidate bytes, poisoned replay and changed-input replay, with no recorded failures. The measured scope is the **batch-one prepared-feature trunk, blocks 1–69**. Input/output renderer stages and DLL host overhead are excluded; the graph result does not claim complete renderer integration.

The [portable deployment measurements](figures/semantic_deployment_measurements.json) retain 64 alternating native/candidate pairs, 32 per execution order, after 20 warmup graph replays per role. Each timed interval uses ten graph replays with three calls per graph. Acceptance requires a median candidate/native ratio no greater than 1.01 in **each** execution order.

| Resolution | Worst order median, FP8 | Worst order median, FP16 | Acceptance |
| --- | ---: | ---: | --- |
| 1280 × 720 | 0.996671 | 0.985826 | Pass |
| 1920 × 1080 | 1.007315 | 0.982065 | Pass |
| 2560 × 1440 | 0.991146 | 0.985200 | Pass |
| 3840 × 2160 | 0.982127 | 0.977436 | Pass |

These are integrated graph ratios, not guarantees that every individual kernel is within 1% of native. The [portable optimization evidence](semantic_optimization_evidence.json) records the separate per-kernel NCU/SASS and timing comparisons that guided the source changes. Earlier staged and transcript-build receipts remain historical evidence, rather than the basis for this qualification.

The current implementation has 81 exports in 17 entry headers, backed by shared semantic algorithms and ten CUDA emission units. Its 45 implementation headers total 7,755 physical source lines, including comments and blank lines; see [the source inventory breakdown](SOURCE_LAYOUT.md#current-source-inventory). Four tested plans establish neither continuous-resolution tuning nor support on another GPU architecture.

Training remains a separate PyTorch FP32/BF16 implementation. Deployment source proofs and speed measurements say nothing about task-specific DLSS5 transfer learning, loss design or a complete training procedure. Those remain topics for further investigation; see [training usage](training.md).

## Review commands

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

Inspect the exported inventory rather than counting implementation files. Preserve failed trials, source/native hashes, profiler captures and exact qualification scope. Keep historical optimization reports unchanged; link a new result to the source and binary it actually tested.

The released build adds an assembler cache key after the timing run. All 81 GPU kernels, resource records and constants, host machine code and imports are byte-identical to the timed build. Installed 720p FP8/FP16 boundary and replay checks also pass. [Release identities and source hashes](semantic_release.json) and [compiled equivalence](semantic_build_equivalence.json) preserve this distinction; no new timing is attributed to the rebuilt file.
