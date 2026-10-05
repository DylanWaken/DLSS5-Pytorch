---
name: dlssnr-reconstruction
description: Reconstruct, integrate, qualify and document this repository's DLSS-NR CUDA families against exact original PTX, physical layouts and saved evidence. Use for source/ABI work, consolidated qualification, profiling interpretation and training-memory diagnostics; preserve each result's measured scope.
---

# DLSS-NR reconstruction workflow

For the current build, read `docs/RECONSTRUCTION_STATUS.md`, `docs/NAMING_AUDIT.md` and `docs/FLAT_SYMBOLS.md`. The dated UEv2 snapshot below is historical; later semantic reconstruction and naming-audit receipts supersede its coverage and timing statements.

Read `docs/RECONSTRUCTION_STATUS.md` and the exact run receipts before acting. Reconciled snapshot: 2026-10-05. The latest qualified **UEv2 normal 81-entry source build**, binary `88b7a94a…`, passes the fixed SM120, batch-one, prepared-feature FP8 trunk at 720p, 1080p, 1440p and 2160p. Its final 4K paired result is **6.496523 ms versus 6.452048 ms original**, ratio **1.006893098**: approximately **0.689% slower**. Both execution-order medians meet the user's accepted **within-1%** slowdown limit; the other three measured resolutions are faster than the original. Further performance optimization stopped at the user's criterion. Installation is a separate root-owned receipt, not inferred from qualification.

The original comparison is an extracted native-kernel graph, not the DLL/NGX/renderer host. All four final paired runs check all 74 published physical boundaries, immutable input/142 records, guards, counters and same-input poisoned replay. `changed_input_graph_proof` and continuous-resolution qualification remain false. Full FP16-trunk, frontend/renderer and broader full-route exceptional/sanitizer coverage remain separate scopes.

All 81 final UEv2 ELF text payloads, raw resource metadata, constants and relocation/metadata sections match the earlier `0e57a8…` readability binary byte-for-byte. This is not an independent decoding of register/stack/spill attributes. The final binary additionally passes **48 matched-kernel cases**: six representative families, four resolution-derived physical shapes, FP8 and FP16. These separate fixtures do not qualify a full FP16 trunk or DLL Half-host record conversion. The prior installed 4K 0.324% result and the failed first UE constructor-shadow run remain preserved historical epochs, not the current timing. The first UE failure was repaired only by renaming the moved record-vector input so body reads resolve to its owning member.

## Scope and ownership

Use this skill for this repository's PTX-to-readable-CUDA reconstruction, family integration, physical ABI validation, matched profiling or evidence-backed optimization. Do not substitute it for documentation of a different GPU ISA or infer SM100 behavior on the current SM120 target.

1. Identify the actual requested result: source coverage, compile admission, fixed-pilot equality, full-route correctness, performance or renderer integration. Report each independently.
2. Inspect existing artifacts before creating a new generator, checker or harness. Reuse a bounded accepted parent and record the exact delta. Do not create a new lifecycle framework for every kernel.
3. Maintain one execution owner for builds, extraction and GPU jobs. Parallelize CPU source work on disjoint files. When clean timing is requested, close CPU subprocesses and stop all subtree work until release.
4. Preserve frozen sources, failed receipts and previous binaries. Write a separate candidate or runtime version. A harness correction is not permission to rewrite a failed run as a pass.
5. Prefer the consolidated source/build/qualification route now that the full family catalog exists. Do not restart isolated legacy-kernel optimization or reintroduce legacy fallback into the reconstructed candidate.

## Understand the repeated graph

The selected trunk contains 36 FP8 entries and 36 independent Half counterparts. The 4K FP8 schedule repeats 36 kernels at 152 compute/repack positions; 33 explicit counter-clear calls make **185 launches**. It retains 142 packed records and exposes 74 physical boundaries. Do not confuse unique functions, graph positions, logical blocks and profiling launches.

The source census totals 81: those 72 entries, counter clear, four plain pre/post entries, two pre-downsample entries and two C32 output-view entries. Equivalently, it is **40 precision pairs plus clear**, not 81 algorithms. These extras do not establish renderer-host equivalence. The historical fast development relink retained 73 entries, including the 37 scheduled functions, while omitting eight frontend/output extras. The qualified normal source build compiles all 81 from source through ten CUDA and two host translation units; the historical 73-entry relink is not the current deployment.

C512 has nine genuine families and 18 precision-specific entries, reused at 65 actual FP8 positions in blocks 23–30 and 40–47. Input view, output view, fused pool and the final adapter are distinct contracts. In particular, actual outview is **block 47**, not block 29. Do not create per-block copies of common compute. Do not erase a real layout/fusion distinction just because the matrix dimensions match.

Use the catalog and `plan-spec.json` for callable names and formulas. Preserve accepted source donors under `outputs`, because the old active tree may have been archived. Identical helper normalization may ignore namespaces/comments/whitespace only when exact type/constants/ISA/layout equivalence is proved. FP8 and Half source must derive from their own original entries.

## Reconstruct semantics before changing the schedule

Start with the exact original entry, preamble, parameter block, register/control flow, launch metadata and real record. Recover an equivalent readable implementation, not a claim about historical variable names or files. Register names and original statement anchors are acceptable in the first auditable body.

- Admit every opcode and modifier explicitly. Unknown instructions, rounding modes, address spaces, signed widths or synchronization forms must fail the lowering census. Preserve predication and all branch paths, including partial windows and padding.
- Use ordinary CUDA/C++ for indexing, loads/stores and control where its semantics match. Keep small inline ISA helpers for tensor cores, packed conversion, approximate operations and synchronization when necessary. A blob launcher or giant PTX string is a diagnostic control, not the final CUDA reconstruction.
- Make signed modular arithmetic explicit. The inherited `shr.s16` bug survived superficial helper tests: test the actual emitted selector sequence and sign extension, not just an abstract standalone arithmetic function (§98).
- Preserve Half operation order, tensor operand versions, FP8 conversion behavior and publication order. Trace raw forks before conversion. NaN payloads, signed zero and invalid-window publication are part of byte-exact comparisons; do not loosen tolerances to hide changes.
- Converted-zero self-pairs must retain their low-16-bit mask and replication. Restrict a converted-pair packing experiment to already-converted distinct operands that have a proved low/high order. Generic Half joins are a separate transformation (§94, §102).
- Preserve original barriers, async bank rotation, arrival counts, token versions, release/acquire and counter reset ordering. Chained attention consumes a freshly verified QKV predecessor; it is not a standalone reset-and-launch kernel.

Use an exact transformation inverse and a few meaningful negative controls. Source identity is not a compiled operand proof. A bounded recurrence proof that normalizes unknown seeds must explicitly retain that limitation instead of claiming the compiled skip/scale address route is closed.

## Bind physical ABI, storage and host calls

Record the exact by-value parameter size/alignment and every pointer/scalar/reserved field. C32 windows use a different ABI from C64/C128/C256; C512 families also differ. Never reuse an offset based only on a familiar family name.

For each admitted shape and phase, identify:

- Physical input/output/skip layout, element encoding, byte extent and alignment.
- Full packed record allocation, addressed prefix and any zero tail. If the native harness allocates only the addressed prefix, use a separate guarded full real record and prove its prefix; do not create an unsafe oversized view.
- Grid/block, original phase origin, partial-window behavior and downsample padding. Exact-half admission does not prove padded allocation safety. Half fixture geometry and record calibration are independent.
- Mutable scratch/counters, producer-consumer sequence, residual alias rules and all buffers that must remain alive.

Validate the adapter's actual positional call against the compiled Torch schema using distinct sentinel roles. An original Driver ABI test cannot detect a Python `(state, skip, record, high)` call into a `(state, record, skip, high)` wrapper (§123). Mutable out APIs need explicit mutation and return-alias schemas.

Preparation is outside graph capture. Launches use the caller's device and current PyTorch stream, retain/record all relevant storage, and perform no hidden cache preparation. Out buffers are caller- or plan-owned. Reset graphs before unloading Driver controls, and keep each plan/module alive until every graph referring to it is destroyed. A shared mutable plan requires caller-ordered executions; a host mutex alone is not cross-stream dependency management.

For original split reductions, recompute occupancy from the **actual compiled function** and current device before launch. Admit the required all-resident grid only if capacity is sufficient. Never bypass that guard or alter the synchronization to force a larger pilot to run.

## Reuse accepted objects and verify the linked product

The historical development relink used **19 accepted CUDA COFF objects plus two newly compiled common C++ host TUs**. It is a diagnostic acceleration recipe, separate from the current normal source build of ten CUDA and two host TUs. Retain device objects and required host stubs, exclude donor Torch registration/API objects, and preserve exact by-value `Parameters` declarations in the common host dispatcher when reproducing that historical route.

Before compiling, bind source manifests, objects, compiler/linker/toolchain executables, consumed environment/Ninja text and dependency-seal JSON. Confirm the command's actual object set, not merely a count. Keep the binary private and record the held process Job's exit, timeout, cleanup, active-member and final-identity evidence.

Postlink verification must compare the exact selected architecture and symbols. Preserve contiguous PCs, opcode/operands, both encoded/control words, header flags, resource fields and function multiplicity. Check all retained donor functions as well as the selected catalog and scheduled subset. Equal register counts or opcode histograms alone do not establish retained code identity. Resource metadata may include driver/shared allocation overhead; do not infer a source allocation from an unexplained tool total.

When compiled code changes, expand loop work and inspect operand ordering, zero paths, publication and synchronization. For Half math, normalize only witnessed component-equivalent cases: two broadcast-half square/FMA paths plus a proved low/high rejoin may equal one packed logical operation (§124). Do not waive an unexplained count mismatch.

## Qualify the whole route

Use one reconstructed candidate path throughout. Native cubins belong only to the comparison control; legacy compute fallback invalidates a claim of complete reconstruction.

1. Verify the actual prefix/record setup and all 74 physical boundaries against the original graph. Retain both outputs of downsample/pool stages. Distinguish internal intermediates from published FP8 or Half endpoints.
2. Run finite and exceptional cohorts independently, preserving exact bytes and counterexamples. Explicitly classify a pre-existing baseline gap versus a new candidate mismatch; new mismatches cannot be hidden by a baseline that is already different.
3. Use repeated complemented/poisoned output storage, guard regions, immutable inputs/records and changed-input captures/replays. A mutation may legitimately collapse to the same exceptional output; prove that a case changed from its own original oracle before requiring output inequality.
4. Check contracts with a named roster, not a stale arithmetic count. Include actual schema-order sentinels, alignment rejection, positive supported offsets, capture restrictions and unchanged-buffer checks on rejection.
5. Run memcheck/racecheck with explicit scope. Exact new-symbol filtering can avoid unrelated proven setup work; record the filter and inherited prerequisites. A filtered pass is not a broad full-route sanitizer pass.
6. Treat qualified tiny Half fixtures, fixed fields and isolated phases as exactly those scopes. Add runtime admission only from evidence. Policy-coordinate clamping must not alter tensors or turn an unmeasured resolution into an admitted one.

## Measure resident performance separately from profiling

Predeclare the interval, graph call count, warmup, output ownership, orders and criterion. Keep graph events precreated and primed outside capture, then record external events inside the captured interval. Include required layout bridges, resets and fallback work in any historical partial comparison. Label validation-only intermediate materialization separately from necessary dataflow.

For two roles, retain both execution orders. For candidate/control/native comparisons, use all six permutations and preserve per-order as well as paired-ratio summaries. Do not collapse a rank reversal into a pooled win. A longer repeated graph is a diagnostic with a changed working set; quantify independent output storage and cache footprint. Use an owned timeout/cleanup process, and quiesce concurrent work for clean timing.

The C512 FFN register-cap history must keep its comparisons straight. Cap168 crossed an allocated-register occupancy threshold; cap128 restored two-CTA residency without spills in the matched component evidence. Historical claims that cap128 remained slower were comparisons against the original, not proof that cap168 was preferable. A later whole-trunk cap128 trial measured a 0.417% gap, the separately qualified named/shared-helper build with cap128 measured 0.324%, and final UEv2 measured 0.689% at 4K. Cap128 is the installed choice for that entry; cap168 remains a preserved historical control. Do not infer a universal register-cap rule, a causal percentage from different epochs, or permission to resume optimization after the accepted within-1% gate.

The integration lesson is to preserve original physical layout/fusion and measure the complete repeated graph. All 152 compute/repack positions and 33 clears follow reconstructed dataflow without legacy compute fallback. Earlier partial-route and first complete-route gaps are historical, not current results. Binary, input/timing scope, bridges and selected FFN variant changed across epochs. Preserve the earlier receipts, but do not subtract their times to assign an exact causal speedup to one source edit.

## Read NCU and NSYS without overstating them

Use the installed tool's supported metrics and the accepted matched collector/reader as the schema source. Never invent unavailable metrics or silently substitute an active-cycle metric for an elapsed-cycle one. Start from a numerically verified actual fixture, with matched original and candidate full/source passes, exact symbol/launch filters, report identity and post-profile poisoned endpoint/guard checks.

For every selected report, retain raw values and units for:

- Executed tensor/Half/conversion/permutation/branch instruction work, with loop expansion where needed.
- Global load/store requests and sectors, local load/store sectors and bytes, and declared payload. An ideal output sector count does not explain unrelated input work.
- Elapsed tensor, L2-data and DRAM throughput; issue/active-warps, block waves, registers, shared configuration and occupancy limits.
- Measured clocks, cache/replay controls, stall samples and exact sampled PCs.

The user's 85% target is **any eligible elapsed pipe ≥85%**: tensor **or** L2-data **or** DRAM. Record a Boolean for each pipe and the OR result. An operation with no tensor work does not need tensor activity. Preserve missing metrics as unavailable; do not turn them into zero or a pass.

Join sampled consumer PCs to exact producer versions and operand roles. Account for implicit wide register writes, carry/accumulator ownership and control entries; a matching register name can refer to a different value. Separate geometry spills from tensor/raw payload spills. Quantify dynamic traffic before discussing cost. Neither static PRMT removal, local-site counts nor stall-sample fractions establish a causal latency fraction.

NCU replay durations, resident event timings and NSYS kernel-duration sums are different measurements. Compare each in its own scope. NSYS attribution must use process/graph-node/correlation relationships, not mere time containment. Separate kernel intervals, inter-kernel gaps and event-edge gaps; do not guess an OS/driver or cache-capacity cause from a leading gap. Profile clocks can differ despite a base-clock request (§112–113, §117).

## Report and preserve what was learned

Lead with the result and precise scope. Link the source/compiled/runtime/profile receipts. Explain the observed mechanism, the controlled measurement, remaining alternatives and the next smallest experiment. Do not call the original extracted-kernel graph the full DLL host.

The postmortem should explain observed fusion/layout work, representation overhead, compiler allocation, boundary semantics and timing scope using both successes and failures. Mark untested hypotheses explicitly. The accepted within-1% prepared-feature result is incorporated here; full renderer or FP16 parity must never be inferred from it or from the source census.

## Internal readability and stable interfaces

The historical UE naming specification is preserved in `outputs/all-reconstructed-deployment-prep/readability-ue-v2/CODE_READABILITY.md`. Current code follows `docs/CODE_READABILITY.md` and `docs/STORAGE_PREFIX_AUDIT.md`: meaningful CapitalCamelCase internals, `r_` for tensor/arithmetic register payload and fragment selectors, `s_` for physical shared-memory roles, and `g_` for proven global pointers/indices. Ordinary control flags use plain `b` names. Reserve `sl_` for logical pre-swizzle coordinates with actual def-use evidence; no such coverage is claimed merely by adding a prefix. Keep unresolved roles explicit rather than inventing tensor semantics. Preserve original PTX anchors and exact identifier inverses.

The historical UE naming pass kept CUDA namespaces and `Parameters`/`ClearParameters` type identities because they participated in C++ symbol mangling. That restriction applies when reproducing its archived binaries, not to the current source: the later complete flat-symbol migration uses bare `extern "C"` exports and descriptive global `F` types. Keep pointer-field/member/offsetof spellings aligned while retaining field order, sizes, alignment and reserved slots. Public Python/Torch names remain stable. Shared intrinsics retain literal ISA, operand constraints and clobbers; source rename equivalence does not imply instruction identity after compilation.

## Training memory is a separate measurement

The pure-PyTorch trainable graph is independent of the packed inference trunk. Preserve its arithmetic and distinguish FP32/BF16 training from FP8/FP16 inference. The initial eager training benchmark's OOMs occurred during forward; they did not demonstrate an intrinsic model-resolution limit. The saved-tensor audit attributes large retained activation and attention intermediates, including FP32 intermediates in the BF16 route. Meta storage accounting is not a measured GPU resident peak, and allocator reports on Windows must not be equated with physical VRAM.

Use block checkpointing with non-reentrant recomputation to trade compute for saved activations, retaining the same model arithmetic, parameters and diagnostic loss. Verify output and parameter-gradient agreement before reporting the new benchmark. Label checkpointed versus eager runs, include peaks and failures, and keep the original results. Do not claim a DLSS5 transfer-learning recipe from these diagnostic losses. See [the memory analysis](../../outputs/all-reconstructed-deployment-prep/training-benchmark/MEMORY-ANALYSIS.md) and its saved-tensor/retention evidence.

The saved checkpoint-parity run now passes for both FP32 and BF16. The subsequent checkpointed forward/backward benchmark completed all eight cases: FP32 and BF16 at 720p, 1080p, 1440p and 4K, with final identities preserved. This supersedes the original eager OOMs as the current benchmark outcome for that explicit checkpointed route; it does not erase them or establish task-specific training convergence. The current final UEv2 inference result is separately measured at four resolutions; its 4K gap is 0.689%. Training results neither explain that timing nor qualify a full FP16 inference trunk.

Evidence anchors, relative to the repository:

- `docs/RECONSTRUCTION_STATUS.md`, `docs/API_MIGRATION.md`, and `outputs/all-kernel-cuda-reconstruction/REPORT.md`.
- `docs/optimization_walkthrough.md` §88–94, §98, §101–113, §123–124, preserving all prior experiment scopes.
- `outputs/all-reconstructed-deployment-prep/{plan-spec.json,accepted-object-union.json,clean-source-check.json}` for the integration catalog and historical donor route.
- `outputs/all-reconstructed-deployment-prep/readability/{install-receipt.json,build-run-v1/build.json,compiled-comparison/analysis-v2/summary.json}` for the installed normal source build and retained compiled differences.
- `outputs/all-reconstructed-deployment-prep/gpu-runs/{readability-numerical-v1,readability-finite-codes-v1,readability-paired-v1}` for the accepted 4K prepared-feature result and its limits.
- `outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-{720p,1080p,1440p,2160p}-paired-v1` for final four-resolution 74-boundary checks and 32-pair timings; the strict native-speed flag and user 1% criterion remain distinct.
- `outputs/all-reconstructed-deployment-prep/readability-ue-v2/{constructor-fix.json,independent-member-scope-review.json,compiled-comparison/summary.json,CODE_READABILITY.md}` for the final host repair and all-81 compiled identity.
- `outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/{capture-ue-v2/receipt.json,run-ue-v2/receipt.json}` for final-binary binding and all 48 representative FP8/FP16 pilot cases.
- `outputs/all-reconstructed-deployment-prep/readability/{semantic-locals,unreal-names}` and `readability-ue` for staged naming/inverse evidence, not an automatic installed-binary claim.
- `outputs/all-reconstructed-deployment-prep/training-benchmark/{MEMORY-ANALYSIS.md,RETENTION-AUDIT.md,saved-tensors-audit.json,run-v1}` for the eager memory lesson and preserved original outcomes.
- `outputs/all-reconstructed-deployment-prep/training-checkpoint/run-v1/receipt.json` and `outputs/all-reconstructed-deployment-prep/training-checkpoint-benchmark/run-v1/receipt.json` for two-precision parity and all eight completed checkpointed benchmark cases.
- `outputs/c512-window-integration-runtime-v2/run-paired-v1` for a historical partial six-order comparison, not a controlled ablation against the final route.
- `outputs/legacy-code-archive-20261005/ARCHIVE.md`, `outputs/source-before-readability-20261005`, failed build/run receipts and private rejected trials for historical interpretation.


## Full FP16 integration: measured lessons (2026-10-06)

Use `docs/FP16_DEPLOYMENT.md` and `docs/figures/fp16_deployment_measurements.json` for the completed SM120 Half trunk. Do not infer Half record offsets by doubling FP8 offsets: K16 packing, upsample record placement, C512 thread counts, direct global reductions and decoder scratch ABI differ. Keep 32-row allocation padding separate from logical finiteness checks; native Half can leave unused token rows poisoned.

Profile the actual repeated workload before choosing a register cap. In C256 Half, Nsight found 238 reconstructed registers versus 188 native with equal occupancy; a 192 cap improved whole-trunk timing despite a small stack frame. Do not claim an occupancy gain. The non-volatile pure-MMA experiment compiled to identical machine code and was discarded. Static MMA/NOP count differences alone do not prove dead arithmetic or dynamic workload differences; compare full SASS, counters and balanced graph timings.

At 4K, native Half split grids exceed all-resident capacity. The retained SM120 path admits one complete XY plane and empirically validates native ordered Z progress under bounded workers. This is architecture-specific evidence, not a CUDA scheduling guarantee or admission for other devices. Preserve the rejected occupancy run and native-only progress probe. The final per-order <=1% gate is tight at 4K; retain raw pairs and do not round a failure into a pass.

## Semantic reconstruction: source must explain the algorithm

Use [the semantic reconstruction report](../../docs/SEMANTIC_RECONSTRUCTION.md),
[source map](../../docs/SOURCE_LAYOUT.md) and current
[code conventions](../../docs/CODE_READABILITY.md) for the new implementation.
Earlier instructions about retaining PTX-numbered identifiers apply only to
historical transcripts. Production code must use named tiles, fragment arrays,
short loops and shared operation/layout policies. Do not hide a transcript in a
helper or generate thousands of scalar assignments under nicer filenames.

Recover and document the invariant before simplifying arithmetic: which Half
lanes are equal after a reduction, which warp owns a denominator, which split
publishes an intermediate, and which rounded values are actually consumed.
Match ordered operands, not only commutative real-number expressions. Keep
nontrivial coefficients as named `CONST_*` constexpr values with bits, decoded
values and observed roles; distinguish algebraic deductions from unknown
coefficient-fitting rationale.

When compact C++ regresses, compare compiled instructions and measured work.
The semantic FP8 investigation found extra packing permutations, repeated
normalization work, inefficient pooling routing and duplicated uniform split
branches. A scoped conversion-and-pack primitive can let the compiler fold a
join into its conversion instruction. Moving a uniform split decision outside
an unrolled fragment loop can avoid repeated reconvergence. Paired softmax can
save shuffles but increase live registers and selection work: keep it only where
compiled correctness and measured timing justify it.

Do not call increased instruction count extra tensor work without checking
opcodes. In the C128 investigation, dynamic QMMA counts were identical while
NOP and packing counts differed. Stall samples, scheduling controls and isolated
timing are evidence with different scopes; none alone establishes a causal
percentage of whole-network latency.

For Half expressions, inspect FMA contraction explicitly. The postprocessing
rewrite required a rounded low-resolution product followed by the native FMA
with the adapter product. Two multiplies plus an add permitted the compiler to
fuse the wrong side and changed Half results. Preserve the native rounded
dependency using shared primitives, then rerun texture/surface fixtures.

Qualify the final normal extension separately from standalone candidate cubins.
Record its source/binary hashes, all-resolution boundary and replay checks, and
balanced native-speed results. Historical matching speed does not transfer to a
new semantic build. The user's 1% speed gate does not prove an 85% roofline.

Before changing a proven tile traversal to address extra NOPs, isolate the
compiler backend. The C128 profile executed the same 805,376 tensor instructions
in both roles; most excess issued work was NOPs. Identical CUDA 12.8 PTX assembled
with 13.4 retained register counts and tensor work while removing most explicit
NOPs and improving measured latency. Reassembling with 12.8 first reproduced the
baseline exactly. The cached reference cubin's 13.4.0 stamp identifies that
image's backend, not necessarily the original DLL source-build compiler.

Use the explicit `DLSSNR_PTXAS_PATH` build option to reproduce the qualified
assembler selection. It keeps the CUDA_HOME compiler, headers, libdevice, host
glue and runtime, verifies helper paths, and records the copied assembler's
hash. Do not replace installed toolkit files or bypass PyTorch version checks.
Keep architecture flags explicit: PyTorch's substring-based detection can
mistake a path containing `arch` for an existing architecture flag. See
[the compiler scheduling report](../../docs/COMPILER_SCHEDULING.md).

## Audit names through their consumers

A prefix/regex audit is not a semantic naming audit. Trace every launch field
from host population to its loads/stores, math and publication. Rename positional
fields such as Pointer0, Scalar32 and Aux80 to proven tensor or geometry roles.
Keep offsets in static assertions, not field names. Update host packing, wrappers,
algorithm consumers and the authoritative generators together.

Use typed renderer records instead of repeated Words[offset] decoding. Preserve
descriptive global `F` launch records, widths, alignment, unused zero padding and
every field offset; assert standard layout and trivial copy. Name unknown conditioning
controls by observed channel/dataflow rather than inventing renderer semantics.

Review local aliases too: identify MMA input/weight/accumulator fragments and
query/key/feature traversal axes. Standard UV or N8 names are reasonable when the
layout documents them; numeric suffixes are not a substitute for a value's role.
Keep low-level instruction operand-word ordering explicit.

After interface refactoring, compare actual parameter byte images and generated
launch contracts, rebuild normally, and compare device text/constants/resources.
Host code may change even when GPU code is identical. Test public host dispatch
as well as full plans: a full-plan graph can bypass a separately exposed operator
launcher. Preserve timing identities instead of relabeling old samples as fresh.

## Keep project C++ symbols flat

Do not add project namespaces, anonymous namespaces or `using namespace`
directives. Call operation helpers directly, such as `RunWindow32(...)`. Give
shared helpers and types enough operation context to be unique: global
`FWindow32Profile`, `FSpatialProjectionArguments`, `FResolutionSelection` and
`EC512KernelRole` are examples. Avoid replacing namespace hierarchy with an
equally long mechanical prefix on every local value.

All 81 CUDA entry points use bare `extern "C"` symbols. Retain their established
precision suffixes and native parameter layout; global ABI types have descriptive
`F` names and may share a record only when its layout and meaning are identical.
Keep generated FP8/FP16 tables distinct with precision suffixes. Update the ABI
header, generators, canonical entry map, host launchers and direct Driver tests
together when changing a symbol contract. External `std::`, `at::` and `c10::`
qualifications remain, and `TORCH_LIBRARY(dlssnr, ...)` still owns the public
Torch domain; it does not declare a project C++ namespace.

The source inventory rejects namespaces and requires explicit C linkage. An
archived namespaced source is readable only through the explicit historical
migration option, not a silent fallback in the active audit. Compare the compiled
entry roster, instruction payloads and launch records after rebuilding; exercise
full graphs and separately exposed host dispatch. See [the migration validation](../../docs/FLAT_SYMBOLS.md).
Preserve original source/binary identities in existing optimization receipts and
charts. A symbol migration with fresh correctness tests is not a fresh timing run.

## Prefix the storage role, not every variable

Trace each declaration to its consumers before retaining a storage prefix. A
parameter or coordinate descriptor is not a register fragment merely because it
is used in device code. Use plain `Parameters`, `Arguments`, `TileCoordinates`,
`Lane`, `Warp` and control predicates such as `bValid`. Keep `r_` on packed
arithmetic values, MMA fragments and their array/shuffle selectors. Keep `s_`,
`sl_` and `g_` on proven addresses, layouts and storage-specific quantities;
correct a mismatched prefix instead of discarding the storage information.

Host tensor handles, vectors of tensors/addresses and CPU table indices are plain
host objects. Actual scalar device addresses retain `g_`. Texture/surface handles,
transform descriptors, sampling configuration and opaque barrier tokens are plain
names. The fact that an intrinsic accepts a register constraint does not turn
ordinary configuration into a tensor payload. Preserve literal inline PTX and
its explicit `.reg` names during a C++ naming-only pass.

Record scope-specific rename maps: the same spelling can denote a host tensor in
one function and a real global pointer in another. Compare tokens and ABI fields,
rebuild and inspect compiled code before carrying forward performance evidence.

## Keep the kernel schedule in one readable body

Use `docs/KERNEL_READING_GUIDE.md` to locate the canonical implementation before
editing an exported ABI adapter. Each main function must expose its ownership,
storage, pipeline prefill, main loops, synchronization/recycling and writebacks.
Move one-use stage/epilogue helpers into that body. Local lambdas may share
repeated prefill/refill or publication logic; their definitions must be visible
inside the same function. Avoid a new layer of forwarding wrappers.

Keep external helpers only for intrinsics or substantial reused computation.
Common MMA/normalization and fused window blocks are valid examples. Record
their actual users and the storage/arithmetic contract they preserve. Shared
slabs reused by fused stages remain explicitly caller-owned; do not allocate
duplicate slabs solely to make a helper self-contained.

Source localization can change lifetime, FMA contraction, predicate scope or
compiler scheduling. Preserve native operation order and every rounding and
synchronization point. Rebuild and compare all exported GPU instructions,
constants and resources, then run the affected numerical/graph checks. If
compiled code changes, qualify its latency and inspect SASS/profiler evidence
before claiming the previous speed result still applies.
