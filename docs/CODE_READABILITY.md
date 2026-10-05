# Reconstructed CUDA code conventions

The deployment source should explain the algorithm recovered from the DLL: tensor tiles, physical layouts, accumulation order, staging and publication. A reader should be able to follow those concepts through compact loops and named fragment arrays. PTX remains the evidence for those choices; a long list of renamed PTX registers is not an acceptable final implementation.

The earlier register-transcript naming pass and its qualification records are preserved unchanged in [CODE_READABILITY_HISTORY.md](CODE_READABILITY_HISTORY.md). Its timings and source conventions apply to that historical implementation. [SOURCE_LAYOUT.md](SOURCE_LAYOUT.md) describes the current named `.cu` entries and their source ownership.

## Names describe values and storage roles

Use CapitalCamelCase identifiers, an `F` prefix for internal structs, an `E` prefix for enums and Unreal-style `b` names for booleans. CUDA built-ins, vector members and externally fixed API names retain their required spelling.

| Prefix | Role | Examples |
| --- | --- | --- |
| `r_` | Tensor/arithmetic register payload, fragment, or index selecting that register data | `r_Accumulator`, `r_Weights`, `r_KSubtile`, `r_SourceLane` |
| `s_` | Physical shared allocation, address, byte offset or shared-storage quantity | `s_Storage`, `s_StageBytes`, `s_BarrierOffset` |
| `sl_` | Logical shared coordinate before a documented swizzle/bank mapping | `sl_Row`, when that logical coordinate is actually present |
| `g_` | Global pointer, byte address or global-layout index | `g_PackedWeights`, `g_TokenGroup`, `g_OutputChannel` |
| No storage prefix | Launch/configuration records, execution coordinates, control flags, opaque handles and host bookkeeping | `Parameters`, `TileCoordinates`, `Lane`, `Warp`, `bValid`, `TextureHandle`, `Tensor`, `BufferIndex` |

The role takes precedence over where the compiler holds a value: a shared byte address gets `s_` even if the address itself is in a register. Do not add an invented logical-shared coordinate merely to use `sl_`; document the mapping where one exists.

Do not give every device local an `r_` prefix because the compiler might allocate it in a register. Keep the prefix for the actual computation payload and its fragment selectors. Mixed coordinate/parameter structs are descriptors; prefix their storage-specific members, not the whole object. General predicates use `b` without a storage prefix. Explicit `.reg` operands inside an intrinsic's PTX retain their register names.

A host `at::Tensor`, a `std::vector` of tensors or addresses, and an index selecting a host table are host objects, even when they describe CUDA storage. They have plain names. A scalar containing a CUDA device address still uses `g_`. Texture/surface objects and barrier phase tokens are opaque handles/tokens, not pointers into the prefixed address spaces. The [storage-prefix audit](STORAGE_PREFIX_AUDIT.md) records the reviewed roles and cleanup.

Name axes explicitly: M/spatial fragments, N/channel groups, K/reduction subtiles, row halves and physical word positions. For example, `r_Input[SpatialFragments][ReductionSubtiles]` and `r_Weights[ReductionSubtiles][ChannelGroups]` show how a tensor-core tile is consumed. Comments should explain the layout or scheduling reason, not paraphrase each assignment.

## Write the recovered algorithm

The actual `extern "C" __global__` entry must be readable from setup through
final stores. Each export has its own `kernel_impl/<exact_export_name>.cu`
file. Keep tile ownership, register/shared declarations, pipeline prefill,
reduction loops, waits/recycling and writebacks in that global function.
Fused down/up sampling and frontend stages belong in the same global body as
their window schedule. Do not hide the implementation behind a `Run*` call,
an include fragment, a macro or a whole-body lambda.

Inline one-use staging and epilogue code where it executes. A small local
lambda can share a repeated prefill/refill or publication sequence while its
body remains visible in the entry. A small helper unique to one kernel stays
in that kernel's file. External helpers are reserved for intrinsics and
substantial repeated logic such as fragment MMA, normalization, softmax,
expert GEMMs and packing. Name their actual users and preserved contracts.

FP8/FP16 entries and channel/view variants each show their own selected native
schedule. Keep shared profile constants and real storage/fragment types where
they serve multiple entries; use local constexpr selectors when useful. The
[kernel reading guide](KERNEL_READING_GUIDE.md) links the actual `.cu` globals,
not a second set of canonical owner functions. These requirements replace the
earlier small-export/shared-whole-body rule.

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

The [semantic naming audit](NAMING_AUDIT.md) traces every ABI field to its actual consumer and covers the algorithm and launcher variables. Offset-only names such as `g_Pointer0`, `Scalar32` and `Aux80` are prohibited in active interfaces; byte offsets belong in assertions.

## ABI and dispatch boundaries

Project CUDA/C++ source has no namespaces or `using namespace` directives. Call helpers directly, for example `LinearWindow32(...)` or `MMA(...)`. Give shared types and helpers operation-specific names so unrelated algorithms remain distinct in global scope: `FWindow32Profile`, `FSpatialProjectionArguments` and `FResolutionSelection` describe their roles without a namespace hierarchy.

All 81 exported kernels use bare `extern "C"` names. Precision-specific exports retain `_fp8` and `_fp16`; their C symbols no longer depend on C++ type mangling. Launch records use descriptive global `F` names, such as `FWindowBlockC32Fp8Parameters`, with a shared type where the layout and meaning are identical. Preserve field order, widths, alignment, byte offsets and matching host/device declarations in `kernel_impl/kernel_abi.h`.

External library qualification such as `std::`, `at::` and `c10::` remains necessary. `TORCH_LIBRARY(dlssnr, ...)` keeps the public Torch registration domain; it does not declare a project C++ namespace. [The flat-symbol migration](FLAT_SYMBOLS.md) records the separate rebuild and validation.

The stable roster is **76 mathematical/frontend entries + four shared repack entries + one counter clear = 81 exports**. It is not 81 independent algorithms. Channel suffixes identify an exported configuration. Each export now requires its own named `.cu` file and visible global body; substantial repeated arithmetic remains shared. Python/Torch entry names, native DLL symbols and historical provenance records keep their established spelling.

## Source quality and compiled performance are separate

Readable source, correct arithmetic and fast compiled code are independent gates. A template or loop can preserve every result while producing more address instructions, longer live ranges, spills or a different dependency schedule. Conversely, a previous binary's matching speed does not qualify a newly rewritten source.

Use this evidence sequence for each change:

1. **Source and ABI:** inspect the algorithm, layout, ownership and exported contracts; run the structural inventory.
2. **Semantic proof:** compare native PTX dependencies/addresses where practical, then execute the compiled candidate against the native kernel or graph boundaries.
3. **Runtime behavior:** verify guards, scratch/counters, padding, poisoned replay and changed-input graph replay for the claimed route.
4. **Performance:** use matched buffers, launch geometry, graph capture and repeated execution-order-balanced measurements. Attribute regressions with Nsight Compute/Systems and SASS before changing the schedule.

CPU symbolic traces do not establish tensor-core numerical execution or GPU speed. Compiling without spills does not establish performance parity. Only measurements of the tested compiled snapshot establish the 1% acceptance criterion. Historical graph qualifications below establish latency only for their named snapshots and scopes; current source changes require their own qualification and do not establish a hardware-roofline percentage.

## Original semantic qualification (historical)

The earlier integrated semantic extension passed the graph acceptance gate in both FP8 and FP16 at 720p, 1080p, 2K/1440p and 4K on the RTX PRO 6000 Blackwell (SM120). The [portable qualification receipt](semantic_graph_qualification.json) pins the extension, harness, native cubins and schedule hashes for all eight precision/resolution combinations.

Each combination passed all **74 physical graph boundaries** with exact native/candidate bytes, poisoned replay and changed-input replay, with no recorded failures. The measured scope is the **batch-one prepared-feature trunk, blocks 1–69**. Input/output renderer stages and DLL host overhead are excluded; the graph result does not claim complete renderer integration.

The [portable deployment measurements](figures/semantic_deployment_measurements.json) retain 64 alternating native/candidate pairs, 32 per execution order, after 20 warmup graph replays per role. Each timed interval uses ten graph replays with three calls per graph. Acceptance requires a median candidate/native ratio no greater than 1.01 in **each** execution order.

| Resolution | Worst order median, FP8 | Worst order median, FP16 | Acceptance |
| --- | ---: | ---: | --- |
| 1280 × 720 | 0.996671 | 0.985826 | Pass |
| 1920 × 1080 | 1.007315 | 0.982065 | Pass |
| 2560 × 1440 | 0.991146 | 0.985200 | Pass |
| 3840 × 2160 | 0.982127 | 0.977436 | Pass |

These are integrated graph ratios, not guarantees that every individual kernel is within 1% of native. The [portable optimization evidence](semantic_optimization_evidence.json) records the separate per-kernel NCU/SASS and timing comparisons that guided the source changes. Earlier staged and transcript-build receipts remain historical evidence, rather than the basis for this qualification.

The current source has 81 named `.cu` entry files, with host-only launchers and shared device primitives; see [the source layout](SOURCE_LAYOUT.md). The table above describes the earlier semantic binary. Four tested plans establish neither continuous-resolution tuning nor support on another GPU architecture.

Training remains a separate PyTorch FP32/BF16 implementation. Deployment source proofs and speed measurements say nothing about task-specific DLSS5 transfer learning, loss design or a complete training procedure. Those remain topics for further investigation; see [training usage](training.md).

## Review commands

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

Inspect the exported inventory rather than counting implementation files. Preserve failed trials, source/native hashes, profiler captures and exact qualification scope. Keep historical optimization reports unchanged; link a new result to the source and binary it actually tested.

The preceding release added an assembler cache key after the timing run. All 81 GPU kernels, resource records and constants, host machine code and imports are byte-identical to the timed build. Its installed 720p FP8/FP16 boundary and replay checks also pass. [Release identities and source hashes](semantic_release.json) and [compiled equivalence](semantic_build_equivalence.json) preserve this distinction; no new timing is attributed to the rebuilt file.

The preceding naming-audit rebuild retains identical device instructions, constants and resource metadata, with separately validated typed host packing and all eight graph correctness cases. See [the naming audit and its build receipt](NAMING_AUDIT.md#validation).

The preceding flat-symbol rebuild is a separate migration of C++ names and CUDA linkage. Its source/ABI, compiled comparison and runtime evidence are documented in [FLAT_SYMBOLS.md](FLAT_SYMBOLS.md). The semantic timing table above retains its original measured build identity.

The preceding [storage-prefix audit](STORAGE_PREFIX_AUDIT.md) applies the narrower storage-role convention above. It retains identical GPU instructions, decoded resources, constants and launch contracts, with fresh graph and public-dispatch validation.

## Current per-entry-file migration

The [kernel reading guide](KERNEL_READING_GUIDE.md) now maps directly to each
export's `.cu` file. Those global bodies own storage, staging, loops and
writebacks. `kernel_impl/kernel_abi.h` is the authoritative host/device ABI;
`kernel_launcher` contains host code. The shared fragment operation is named
`MMA`, replacing `MultiplyAccumulate`.

The portable [source audit](global_entry_audit.json) records **81 CUDA
compilation units and 25 shared headers**, the entry-body review and the actual
users of retained helpers. The [validation receipt](global_entry_validation.json)
pins candidate `aa207d37…` and its successful build. Compared with the preceding
build, **50/81 GPU instruction payloads, 72/81 decoded resource records and all
81 entry constant sections** are identical; source localization changed the
remaining compiled instructions/resources, so this candidate was measured again.

All eight FP8/FP16 graph cases at 720p, 1080p, 2K/1440p and 4K pass all 74
physical native-byte boundaries, poisoned and changed-input replay, and the
within-1% latency gate in both execution orders. The
[current paired measurements](figures/global_entry_deployment_measurements.json)
retain raw samples and identities for the SM120 batch-one prepared-feature
trunk, blocks 1–69. Separate checks pass 70 CPU tests in each Python mode,
18 tensor-facing native frontend fixtures, 36 C32 output-view cases per
precision and 24 C512 public-dispatch cases. These separate checks do not
extend the graph timing claim to renderer host work or other hardware.

The preceding canonical-function cleanup remains historical. Its
[source audit](kernel_locality_audit.json) and
[validation receipt](kernel_locality_validation.json) record 38 changed GPU
instruction payloads, fresh successful FP8/FP16 graph timings, C512 dispatch,
frontend and CPU checks for that earlier build. Its
[raw timings](figures/kernel_locality_deployment_measurements.json) retain their
original identity and must not be presented as measurements of this migration.
