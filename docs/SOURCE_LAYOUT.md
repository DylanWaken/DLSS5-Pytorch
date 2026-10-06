# CUDA source layout

The source exposes **81 logical deployment kernels through 56 CUDA compilation
units**. Forty logical entries share 15 full-body global templates; 41 retain
direct global definitions. Each global body shows storage, pipeline, loops,
synchronization and writebacks. There is no device wrapper forwarding the whole
algorithm to a hidden `Run*` function.

The roster comprises 76 mathematical/frontend entries, four repacks and one
counter clear. The first 80 form 40 precision pairs. These are configurations,
not unrelated algorithms or network positions; the trunk reuses them. The
latest template request supersedes one-file-per-logical-export ownership.

## Directory responsibilities

```text
csrc/
  kernel_impl/
    fp8/                      26 precision-specific global-body files
    fp16/                     27 precision-specific global-body files
    common/                   Shared primitives, profiles and ABI
      kernel_abi.h            Typed records, offsets, aliases and resolvers
      kernel_templates.json  Logical names and template ownership
      repack_token_to_spatial.cu
      repack_spatial_to_token.cu
      completion_counter_clear.cu
  kernel_launcher/            Host dispatch, plans, geometry and C++ selection
    kernel_symbols.*          Logical name to registered function mapping
  torch_api/                  Torch schemas, contracts and bindings
tests/                        CPU, CUDA, capture and training checks
tuning/                       Native profiles and measured policies
run_tests.py                  Test entry point
run_tuning.py                 Offline tuning entry point
```

Each `.cu` owns one complete global definition, either a template or a direct
entry. Shared repack templates emit both precisions from `common/`; other
templates retain FP8/FP16 files where schedules differ. Small
`Resolve_<logical_name>()` functions beside templates return registered host-stub
addresses. They perform no launch or tuning-policy selection. Launch dispatch
remains entirely in `kernel_launcher`.

## Find a logical kernel

[kernel_templates.json](../csrc/kernel_impl/common/kernel_templates.json) maps
40 names to source files, compile-time arguments and resolvers. The other 41
names still match their `.cu` filenames. [The reading guide](KERNEL_READING_GUIDE.md)
links each family. [kernel_abi.h](../csrc/kernel_impl/common/kernel_abi.h) owns
parameter layouts, checked offsets and host aliases/resolver declarations.

[kernel_symbols.cpp](../csrc/kernel_launcher/kernel_symbols.cpp) and its generated
table map stable logical names to registered functions. C++ `KernelSymbol(Name)`
and `torch.ops.dlssnr.kernel_symbol(name)` return the current binary's CUDA symbol
for diagnostics and Driver tools. Ordinary execution uses function pointers;
Python does not choose the arithmetic implementation.

Project declarations remain namespace-free. Direct globals use C linkage;
templates have mangled C++ symbols behind stable logical names and C-linkage
host resolvers. External `std::`, `at::`, `c10::` and the Torch `dlssnr` domain
are unchanged.

## Visible flow and shared helpers

Keep declarations, prefill/refill, loops, waits and publication in the owning
global body. A short local lambda may share a repeated pipeline step while
keeping address calculations visible. File-local helpers stay with their owner.
Shared headers contain actual reused mathematics, profiles and layout contracts.

| Shared source | Responsibility |
| --- | --- |
| `warp_window32.cuh`, `warp_window_wide.cuh` | Window profiles, fragments and linear/attention/normalization/expert math |
| `window_ffn.cuh`, `window_qkv.cuh`, `spatial_projection.cuh` | C512 profiles and fragment/address primitives |
| `window_pool.cuh`, `window_downsample.cuh`, `window_upsample.cuh` | Exact pooling, publication/padding and sampling contracts |
| `global_*.cuh`, `channel_projection.cuh`, `decoder.cuh` | Global/connector layouts and repeated math |
| `frontend_profiles.cuh`, `frontend_math.cuh`, `input_features.cuh` | Renderer types, numerical constants and feature/filter math |
| `intrinsics.cuh` | Force-inlined PTX with explicit rounding, address-space and synchronization behavior |
| `mma.cuh`, `tiled_mma.cuh` | `MMA`, fragments and accumulation; FP8 K32 versus FP16 K16 |
| `packed_math.cuh`, `numerical_constants.cuh`, `memoryops.cuh` | Packed arithmetic, named constants and shared barrier primitives |

Windows preserve three visible schedules: compact C32, two-warp C64 and shared
exchange for C128/C256. Compile-time layout branches keep reads/writes inline.
Downsample and upsample remain separate full bodies. C32 output-view entries
remain direct because their template pilots changed compiler output.

C512 and global stages preserve separate launches, split reductions and
completion counters. Generated plans retain logical names, geometry, buffers
and ABI bindings; template entries resolve through the manifest and checked
aliases. No device implementation is emitted by a launcher translation unit.
Four admitted SM120 plans do not establish arbitrary channels, continuous
resolution tuning or another GPU architecture.

## Inventory and evidence

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

Audit **81 logical names, 56 body owners and 40 template mappings** separately.
Source counts do not establish compilation, correctness or speed. The
[integration receipt](template_integration_validation.json) records the normal
extension's identities and completed checks. The preceding
[feasibility study](KERNEL_TEMPLATE_FEASIBILITY.md) qualifies isolated prototypes,
not host integration.

The [81-file source audit](global_entry_audit.json),
[validation](global_entry_validation.json) and
[paired timings](figures/global_entry_deployment_measurements.json) are historical.
That build had 50/81 unchanged instruction payloads and 72/81 unchanged resource
rows against its predecessor, and all eight native graph timing cases passed.
The later [directory migration](precision_layout_audit.json) preserved its 81
device implementations. These records retain their original binary identities.

Earlier [kernel-body](kernel_locality_validation.json),
[semantic](semantic_graph_qualification.json), [naming](NAMING_AUDIT.md),
[flat-symbol](FLAT_SYMBOLS.md) and [storage-prefix](STORAGE_PREFIX_AUDIT.md)
records also remain historical. Keep receipts and failed trials unchanged;
[code conventions](CODE_READABILITY.md) describe qualification requirements.
