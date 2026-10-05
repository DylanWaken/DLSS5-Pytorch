# Reconstructed CUDA source conventions

The source tree contains 81 concrete CUDA entries: **40 paired FP8/FP16 family/configuration groups plus one counter-clear entry**. This is an entry census, not a claim of 81 independent algorithms. Implementations are grouped by operation and precision: `window_block`, `downsample`, `upsample`, `attention`, `ffn`, `projection`, `frontend` and `repack`. Repeated network calls share an entry and its parameterized geometry; distinct fusions and precision-specific layouts remain separate. See [source organization and template decisions](SOURCE_LAYOUT.md).

## Names and memory roles

Internal C++ names follow the requested Unreal-style conventions: CapitalCamelCase identifiers, PascalCase helper functions, `F` prefixes for internal fragment structs and an `E` prefix for the internal precision enum. Proven boolean locals use the `b` convention after their storage prefix.

| Prefix | Meaning | Examples |
|---|---|---|
| `r_` | Register-held value, local array, fragment or helper argument | `r_PackedHalf2AtPtx204R69`, `r_OutputWord0` |
| `r_b` | A local declared as a boolean predicate | `r_bPtxPredicate1` |
| `s_` | Proven physical shared allocation, address or ISA byte offset | `s_SharedStorage`, `s_BarrierOffset`, `s_ByteOffset` |
| `g_` | Proven global-memory pointer/address or explicitly derived global-layout index | `g_RecordByteAddressAtPtx357`, `g_CounterIndex` |
| `sl_` | Reserved for proven logical shared coordinates before swizzle/bank mapping | No such role was established by this pass. |

The prefix describes the proved role of a value, not merely the physical register holding it. A shared-memory address can itself reside in a register. Shared and global roles come from existing ABI-address provenance or the exact memory-helper contract; an integer is not classified as an address merely because it is used near a memory operation.

## Proven names and unresolved roles

The earlier dataflow pass names packed representations and MMA operand roles only when every classified definition/use agrees. It distinguishes A fragments, B fragments, accumulators, packed Half2 values, converted E4 pairs and packed E4 words. PTX line and register suffixes retain traceability to the recovered original instruction stream. Short phase comments describe witnessed primitive groups without inventing a higher-level derivation.

Many original registers are reused across meanings or participate in operations whose semantic role has not been recovered. They remain explicit: `r_PtxRegisterN`, `r_PtxU16RegisterN`, `r_PtxU64RegisterN`, `r_PtxFloatN` or `r_bPtxPredicateN`. These names improve consistency without pretending that an unknown value is a row, channel, attention score or logical shared coordinate. In particular, this pass does **not** claim recovery of pre-swizzle `sl_` semantics.

## ABI boundaries

Exported CUDA entry names and namespaces remain unchanged. Kernel argument types named `Parameters` and `ClearParameters` are intentional exceptions to the `F` type prefix: their type names participate in the C++ mangled kernel symbols. ABI scalar fields use CapitalCamelCase. Proven global pointer fields use `g_` plus CapitalCamelCase, such as `g_State`, `g_High` and `g_Record`; reserved integers and unused pointer-sized slots do not acquire an address claim. The separate `abi-pointer-prefix-map.json` records precision-specific pointer slots and the required host/device postpass. Host declarations, member uses and `offsetof` references must consume that same contextual map. Field order, widths, alignment and byte offsets remain unchanged.

Python and Torch operator names remain stable. Native DLL symbols and source-provenance records keep their original spelling. CUDA vector members such as `.x` and `.y` and built-in CUDA identifiers are not renamed.

## Shared utilities and exact operations

`intrinsics.cuh` holds the short ISA wrappers, including tensor instructions, FP8 conversions, shuffle controls and asynchronous-memory/barrier operations. Their inline assembly text, constraints, clobbers and ordering are preserved. `packed_math.cuh`, `integer_math.cuh`, `memoryops.cuh` and `mma.cuh` provide the shared arithmetic, address and fragment interfaces. `kernel_helpers.cuh` collects their device-side imports. Parameter contracts live in the launcher layer and are shared by host declarations and device definitions. Operation headers contain their precision-specific channel/configuration variants; ten CUDA emission translation units compile those groups. The entry names retain channel information for stable dispatch and profiler attribution, without imposing one file per channel.

`python -B tools/kernel_sources.py` derives a source inventory keyed by exported kernel name, checks local includes, and verifies that each entry has exactly one CUDA emission unit. Its optional `--baseline-csrc` argument checks the exported roster against a saved source tree. This structural check does not replace compiled-code comparison or runtime validation.

Naming is an identifier-only source transformation. Scoped collision checks, exact whole-source inverses and unchanged comment/string checks establish the bounded source-edit claim. They do not prove numerical correctness or identical emitted machine code. Compilation, boundary checks and performance measurements belong to the separate qualification records; per-entry FP16 coverage must not be read as a qualified full FP16 trunk.

The device transformation and host integration maps are saved in [device naming manifest](../outputs/all-reconstructed-deployment-prep/readability/unreal-names/manifest.json) and [host naming map](../outputs/all-reconstructed-deployment-prep/readability/unreal-names/host-rename-map.json). These frozen maps describe the final UEv2 convention, with unresolved roles explicitly retained.

## Separate runtime and training evidence

The following receipts preserve the earlier UEv2 readability qualification. The completed FP16 prepared-feature trunk and its later qualification are documented separately in [FP16 deployment](FP16_DEPLOYMENT.md); current source grouping is described in [source organization](SOURCE_LAYOUT.md).

The contextual `g_` ABI addendum is included in final UEv2. The source audit matches 70 concrete host/device ABI declarations and 73 shared-host stubs, with all 81 exported device names stable. The first UE build exposed a host constructor shadow: its moved `g_Records` argument hid the owned member. UEv2 changes the incoming argument to `g_InputRecords`; subsequent reads resolve to the member. The failed first run, exact repair and independent member-scope review are preserved. Device declarations alone could not detect this host lifetime bug.

Final UEv2 binary `88b7a94ab57c3da0291ef48797ed5f8f4e85c1ce6cb7692657c16906e65bd1a5` was built normally from all 81 entries. Its saved ELF comparison against the previously qualified `0e57a8…` binary is exact for all 81 `.text` payloads (including instruction/control bytes), raw ELF resource metadata, constants and relocation/metadata sections. The ELF-only checker does not independently decode register, stack or spill counts. See [the comparison summary](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/compiled-comparison/summary.json).

The SM120, batch-one, prepared-feature FP8 trunk passes all 74 published physical boundaries at each of the four measured resolutions, including native published token padding. The balanced run uses 32 alternating pairs and three whole-trunk calls per captured graph. Pooled times per call are:

| Resolution | Reconstructed ms | Original ms | Difference |
|---|---:|---:|---:|
| 720p | 2.123984 | 2.172192 | -2.219% |
| 1080p | 2.521051 | 2.547851 | -1.052% |
| 1440p | 3.465125 | 3.488731 | -0.677% |
| 2160p | 6.496523 | 6.452048 | +0.689% |

Both execution-order medians are within the user's allowed 1% slowdown at every resolution. At 4K the two order ratios are 1.006960 and 1.006532; the pooled gap is 0.689%. The saved strict `matches_native_in_both_orders` flag remains false at 4K because strict native speed was not reached. This does not contradict the separate user-defined 1% acceptance. The earlier 0.324% result belongs to its own preserved binary/run and is not substituted for the final timing.

These are four discrete admitted shapes, not continuous-resolution or end-to-end DLL/NGX/renderer qualification. Pre0/frontend and post70/output-host work are excluded. Same-input poisoned replay, immutable input/records, guards and counters pass; `changed_input_graph_proof` remains false for the whole trunk. The corresponding receipts are in `../outputs/all-reconstructed-deployment-prep/gpu-runs/ue-v2-{720p,1080p,1440p,2160p}-paired-v1`.

The final binary also passes all 48 matched-kernel cases: C32/C64/C128/C256 ordinary windows, C512 FFN and C512 QKV, each at four resolution-derived physical shapes in FP8 and FP16. These are separate guarded kernel fixtures, not a complete FP16 inference trunk. FP16 records use independently calibrated K16 packing rather than a claim of recovered DLL Half-host conversion. See [the suite receipt](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/run-ue-v2/receipt.json). Broader full-route exceptional/sanitizer and renderer scopes remain separate.

Training uses a separate pure-PyTorch FP32/BF16 graph. Checkpointed output/gradient parity has passed for both precisions, and all eight checkpointed forward/backward cases at 720p, 1080p, 1440p and 4K have completed. The earlier eager OOMs are preserved as implementation-specific results. See `../outputs/all-reconstructed-deployment-prep/training-benchmark/MEMORY-ANALYSIS.md`, `../outputs/all-reconstructed-deployment-prep/training-checkpoint/run-v1/receipt.json` and `../outputs/all-reconstructed-deployment-prep/training-checkpoint-benchmark/run-v1/receipt.json`. These results neither qualify a complete FP16 inference trunk nor supply a task-specific DLSS training methodology.

The kernel timing suite reverses ranking in 36/48 cases; three FP8 and eight FP16 cases are slower in both orders. See [per-order kernel results](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/RESULTS.md), [current qualification](RECONSTRUCTION_STATUS.md), [training usage](training.md), and the [project reconstruction skill](../skills/dlssnr-reconstruction/SKILL.md).
