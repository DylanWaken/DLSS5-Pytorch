# Semantic naming audit

This pass replaces names that described parameter positions with names that explain the values. The previous readability audit checked spelling and storage prefixes but missed offset-only fields such as `g_Pointer24`, `Scalar32` and `Aux80`. This audit follows those fields from host packing through their actual CUDA consumers.

This report and its JSON receipts preserve the preceding semantic naming pass. The current source subsequently removed project namespaces and adopted bare C kernel exports; [FLAT_SYMBOLS.md](FLAT_SYMBOLS.md) records that separate migration. The example below uses the current global type name.

## What changed

The quoted attention projection now receives:

```cpp
const FSpatialProjectionArguments r_Arguments{
    r_Parameters.g_Input,
    r_Parameters.g_Residual,
    r_Parameters.g_Output,
    r_Parameters.g_PackedWeights,
    int(r_Parameters.Height),
    int(r_Parameters.Width)};
```

The ABI header documents dimensions in physical pixels and distinguishes ordinary geometry, channel-plane views, downsampled outputs and split-reduction scratch. Both precisions use the same names for the same roles.

| Earlier spelling | Name after tracing its use |
| --- | --- |
| Projection `g_Pointer0 / 8 / 16 / 24` | `g_Input / g_Residual / g_Output / g_PackedWeights` |
| Projection `Scalar32 / Scalar36` | `Height / Width` |
| View `Aux80 / Aux84` | `ViewHeight / ViewWidth` |
| Downsample pointer/dimensions | `g_DownsampledOutput`, `DownsampledHeight`, `DownsampledWidth` |
| Global reduction scratch/counters | `g_SplitAccumulator`, `g_SplitCounters` |
| Generic `g_State / g_High / g_Record` | `g_Input / g_Output / g_PackedWeights` |
| Frontend `Words[offset]` | Typed texture handles, transforms, conditioning controls and extents |
| Local MMA `r_A / r_B / r_C` | Input/weight fragments and output accumulators |
| Global-attention M/N/K loop aliases | Query/key/feature tile indices |
| C512 pointer/scalar arrays and numeric role codes | Named launch bindings and `EC512KernelRole` |

Offsets remain in `offsetof` assertions and reference manifests, where they establish the binary contract. Generated deployment plans use `offsetof(FParameters, FieldName)` rather than anonymous byte positions, and their authoritative generator was updated too. The C512 launcher assigns named members rather than inferring buffer roles from an ABI byte count.

Preprocessing and postprocessing share typed launch records. The naming pass preserved the then-existing C++ type identities and namespaces. The later flat-symbol migration replaces them with descriptive global `F` types while retaining alignment, extent, standard-layout, trivial-copy and field-offset assertions. Unused padding is explicitly reserved; it is not given an invented tensor meaning.

## Audit coverage and naming conventions

The naming pass reviewed all 70 files then under `csrc`, including 45 kernel headers, launchers, generated plans, emission units and the Torch registration layer. Its historical ABI review covered 76 parameter namespaces and 884 fields, plus the shared repack/counter records. The [machine-readable audit](naming_audit.json) records per-file reviews, field mappings and source hashes.

Storage prefixes remain `g_` for global-memory roles, `s_` for physical shared-memory roles, `sl_` for a proven logical pre-swizzle coordinate and `r_` for register/local values. Names explain the operation: input feature, residual, weight fragment, attention denominator, partial sum, publication destination or counter phase.

Standard tensor coordinates such as X/Y, texture UV, and N8/N16 fragment widths remain when their local layout explains them. Query/Key/Value retains its attention meaning. Numbered words at the low-level MMA boundary denote the instruction's packed operand order, with explicit A/B/C/D role comments; they are not anonymous parameter slots. CUDA built-ins, vector members and existing public Torch schema keywords retain their external spelling.

Conditioning controls are named after the observed sampled Green/Blue channels. Their original renderer-level interpretation is not established by the recovered instructions, so the source says so.

A regression check now rejects offset-named Pointer/Scalar/Aux/Parameter fields and raw frontend parameter-word decoding throughout `csrc`. That lexical check supplements the manual dataflow review; it cannot prove that an arbitrary descriptive name is correct.

## Validation

The results in this section belong to the naming-pass build and receipts, before namespace removal. Current flat-symbol validation is recorded separately in [FLAT_SYMBOLS.md](FLAT_SYMBOLS.md); old source hashes and timing identities are retained.

The normal extension rebuild passed every ABI assertion. All **81 CUDA instruction payloads**, their text metadata, and all ten modules' constant and resource sections are byte-identical to the preceding qualified release. Host machine code differs because argument construction now uses typed fields; it is not claimed identical.

An independent source comparison verifies all eight generated plans retain their 185 calls, parameter widths/offsets/values/write order, buffer sizes and launch geometry. It also checks 144 C512 parameter byte images, including unused zero padding.

All eight FP8/FP16 × 720p/1080p/1440p/4K graph checks pass their 74 physical boundaries, guards, counters, poisoned replay and changed-input replay against the extracted native graph. The public C512 dispatcher also passes 24 cases covering all 18 entries against independent Driver argument packing of the identical candidate kernels, including eager, poisoned and changed-input graph replays, guards and immutable inputs. This checks the changed host dispatcher; it is separate from native-kernel parity. CPU checks pass all 59 tests in each of ordinary and optimized Python modes. The [validation receipt](naming_validation.json) records the compiled comparison and runtime results.

The speed charts retain the earlier measured samples; this naming pass does not invent new latency measurements. Their scope remains the SM120 batch-one prepared-feature trunk. Identical device code and launch contracts preserve that workload; DLL host integration and other architectures remain outside the qualification.

The public dispatcher regression worker is [tests/test_c512_dispatch.py](../tests/test_c512_dispatch.py). It requires the explicit extension and extracted candidate-image directory with its SHA/symbol comparison manifest; run it in a bounded GPU worker, as with the existing native-reference tests.
