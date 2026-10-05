# Flat CUDA and C++ interfaces

All project-defined namespaces have been removed from `csrc`, including device
helpers, ABI records, launchers, generated plans and Torch bindings. A window
block now calls `RunWindow32<...>(...)` directly. Shared helpers use descriptive
global names such as `FWindow32Profile`, `FMmaAccumulatorTile` and
`SelectResolutionPolicy`; they are not hidden in replacement wrapper classes.

The 81 CUDA entries use `extern "C"` linkage and bare operation names, such as
`window_block_c32_fp8`. Precision pairs retain `_fp8`/`_fp16`. ABI types have
distinct names such as `FWindowBlockC32Fp8Parameters`, with their original field
order, offsets, widths and alignment. Native reference symbols remain provenance
data. External library qualifications such as `std::`, `at::` and `c10::`, and
the public Torch operator domain `dlssnr`, retain their required API spelling.

The [symbol map](flat_symbols.json) records the migration from commit
`b0e0724faa47141ac3f4eb285e747d29f9aa3379`. It includes the algorithm, ABI, host
and compiled export mappings. The [validation receipt](flat_validation.json)
pins the source, test harness and installed extension hashes.

## Validation

| Check | Result |
| --- | --- |
| Normal CUDA/PyTorch extension build | Passed |
| Active source inventory | No project namespaces; 81 C exports, 17 entry headers, ten CUDA emission units |
| ABI layout | All 81 record definitions and 1,044 layout assertions preserved under type renaming |
| Generated plans | All eight plans identical except the flattened function names |
| GPU instruction payloads | Byte-identical for all 81 entries |
| Decoded register/shared/local/stack resource rows | Identical for all 81 entries |
| Constant payloads and extents | Identical across all ten modules |
| CPU tests | 62 passed normally, then 62 passed with Python optimization enabled |
| Native/candidate graph checks | FP8 and FP16 passed at 1280×720, 1920×1080, 2560×1440 and 3840×2160 |
| Public C512 dispatcher | All 24 cases across 18 entries passed |

Every graph case compares 74 physical boundaries and passes poisoned replay and
changed-input replay. The scope remains the prepared-feature trunk, blocks 1–69,
on the RTX PRO 6000 Blackwell (SM120). The separate dispatcher test compares the
public Torch launcher with a direct Driver launch of the same candidate kernel;
it checks packing/launch behavior, guards and input/weight immutability, rather
than serving as an independent native numerical oracle.

The installed extension SHA-256 is
`4e0b09c831b29f295916838df4567c6e534cf3a7d8b0fd353b8dc713b5ee2626`.
The build regenerated `compiled_resolution_policy.h` with whitespace-only line
wrapping differences; both file hashes are recorded. All other compiled source
files match the reviewed workspace snapshot exactly.

## Performance evidence and limits

This migration changes exported names, ELF metadata and host code. Whole binary
identity is not claimed. Constant-section link/info indices change, even though
their payload bytes, size, type and alignment remain identical. GPU instructions
and decoded resources are compared through an explicit old-to-new symbol map;
their bytes are never rewritten for comparison.

No new timing samples or profiler runs are attributed to this cleanup. The
[existing speed charts](BENCHMARKS.md) retain the original measured build and
scope. Identical GPU code, constants and launch contracts connect this build to
the preceding qualified release; fresh runtime checks validate the changed host
interfaces. This is not additional evidence for another GPU architecture,
continuous-resolution coverage, renderer integration or the 85% roofline target.

The source inventory rejects new namespace declarations/imports and CUDA exports
without C linkage. Run it with:

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

Use `--allow-namespace-migration` only when comparing an intentionally namespaced
historical tree through `--baseline-csrc`. Active source remains subject to the
flat-interface checks. Historical optimization reports and receipts are preserved.
