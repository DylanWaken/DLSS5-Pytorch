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
    <network_stage>/
      fp8/                    FP8 global bodies for this stage
      fp16/                   FP16 global bodies for this stage
      common/                 Shared stage profiles, helpers and intrinsics
    bottleneck_c1024_layout/common/  Precision-shared layout kernels
    shared_input_output_c32/common/  Feature preparation/compositing helpers
    shared/common/            Primitives used across network stages
      kernel_abi.h            Typed records, offsets, aliases and resolvers
      kernel_templates.json  Logical names and template ownership
      completion_counter_clear.cu
  kernel_launcher/            Host dispatch, plans, geometry and C++ selection
    kernel_symbols.*          Logical name to registered function mapping
  torch_api/                  Torch schemas, contracts and bindings
tests/                        CPU, CUDA, capture and training checks
tuning/                       Native profiles and measured policies
run_tests.py                  Test entry point
run_tuning.py                 Offline tuning entry point
```

The stage comes first and precision second. The names below explicitly identify
code reused by encoder and decoder levels; shared bodies are not copied into
each level. Record numbers follow the [architecture atlas](ARCHITECTURE.md).

| Network-stage directory | Graph scope |
| --- | --- |
| `input_c32`, `output_c32` | Input record 0 and output record 70 |
| `shared_encoder_decoder_c32_c64_c128_c256_fused_window` | Fused window blocks reused by encoder levels C32–C256 (1–22) and decoder levels C256–C32 (48–69); transitions have their own owners below |
| `encoder_c32_c64_c128_c256_downsample` | Window + downsample at records 4, 8, 14 and 22 |
| `encoder_c512_downsample` | C512 pooled projection and C512→C1024 projection at the 30→31 transition |
| `decoder_c32_c64_c128_c256_upsample` | Upsample + window at records 48, 56, 62 and 66 |
| `decoder_c1024_to_c512_upsample` | Bottleneck-to-decoder transition, record 39 |
| `shared_encoder_decoder_c512_ffn` | C512 FFN used by encoder 23–30 and decoder 40–47 |
| `shared_encoder_decoder_c512_attention` | C512 QKV/attention and attention output view at those same levels |
| `shared_encoder_decoder_c512_attention_ffn_projection` | C512 projection bodies shared by attention and FFN at those same levels |
| `bottleneck_c1024_attention` | Global QKV and attention, records 31–38 |
| `bottleneck_c1024_ffn` | Global FFN expansion, records 31–38 |
| `bottleneck_c1024_attention_ffn_projection` | Global attention projection and FFN contraction, records 31–38 |
| `bottleneck_c1024_layout` | Spatial/token layout bridges for the bottleneck |
| `shared_input_output_c32` | Feature/filter math, profiles and instructions reused by input and output |
| `shared` | Cross-stage primitives, ABI, manifest and completion-counter reset |

Each `.cu` owns one complete global definition, either a template or a direct
entry. Fused windows retain their full FFN/attention/transition flow in one
body. Shared repack templates emit both precisions from the layout stage's
`common/`; other templates retain FP8/FP16 files where schedules differ. Small
`Resolve_<logical_name>()` functions beside templates return registered host-stub
addresses. They perform no launch or tuning-policy selection. Launch dispatch
remains entirely in `kernel_launcher`.

## Find a logical kernel

[kernel_templates.json](../csrc/kernel_impl/shared/common/kernel_templates.json) maps
40 names to source files, compile-time arguments and resolvers. The other 41
names still match their `.cu` filenames. [The reading guide](KERNEL_READING_GUIDE.md)
links each family. [kernel_abi.h](../csrc/kernel_impl/shared/common/kernel_abi.h) owns
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
| `shared/common/warp_window32.cuh`, `warp_window_wide.cuh`, `window_pool.cuh` | Fragments, attention/normalization and pooling reused by fused windows, transitions, endpoints, C512 and global attention |
| C512 stage `common/` headers | FFN, QKV and spatial-projection profiles and fragment/address primitives |
| Encoder/decoder stage `common/` headers | Downsample publication, channel projection and upsample profiles |
| Bottleneck stage `common/` headers | Global attention, expansion/contraction and layout contracts |
| `shared_input_output_c32/common/` | Endpoint profiles, feature/filter math and endpoint-only instructions |
| Stage `common/intrinsics.cuh` | Instructions used only by that stage; declaration and PTX bodies are shared across precisions |
| `shared/common/intrinsics.cuh` | Cross-stage MMA, packing, warp, memory and synchronization instructions |
| `shared/common/mma.cuh`, `tiled_mma.cuh` | `MMA`, fragments and accumulation; FP8 K32 versus FP16 K16 |
| `shared/common/packed_math.cuh`, `numerical_constants.cuh`, `memoryops.cuh` | Packed arithmetic, named constants and shared barrier primitives |

Helper ownership follows actual callers. For example, both endpoints use feature
reconstruction, and global attention uses the same fragment math as local
windows. Such dependencies retain one definition. A stage may explicitly include
another stage's helper when it reuses that exact contract; directory ownership
does not introduce a second copy or change CUDA arithmetic.

Windows preserve three visible schedules: compact C32, two-warp C64 and shared
exchange for C128/C256. Compile-time layout branches keep reads/writes inline.
Downsample and upsample remain separate full bodies. C32 output-view entries
remain direct because their template pilots changed compiler output.

C512 and global stages preserve separate launches, split reductions and
completion counters. Generated plans retain logical names, geometry, buffers
and ABI bindings; template entries resolve through the manifest and checked
aliases. No device implementation is emitted by a launcher translation unit.
The four SM120 benchmark cases do not establish arbitrary channels, a measured
continuous-resolution tuning policy or another GPU architecture.

The [small-SM scheduling path](SMALL_GPU_SCHEDULING.md) selects stream-ordered
reduction splits when the full dependent grid does not fit.
[Runtime input geometry](DYNAMIC_RESOLUTIONS.md) computes allocations and grids
from actual image dimensions, independently of tuning. Each plan owns this
geometry; the four saved plans remain reference fixtures.

## Inventory and evidence

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

Audit **81 logical names, 56 body owners and 40 template mappings** separately.
Source counts do not establish compilation, correctness or speed. The
[current receipt](small_gpu_validation.json) records installed build `efdfded2…`,
the 16-stage layout, unchanged instruction payloads for all 81 kernels compared
with the scheduling-fix build, and fresh functional/performance checks.
Fourteen forced-fallback non-anchor cases and eight automatic anchor cases pass
all 74 published boundaries. Seven of eight anchor timing cases meet 1%; FP8
1080p is 1.1944% slower than the extracted original kernels. The physical test
device was an RTX PRO 6000 Blackwell; no RTX 5060 run is claimed.

The preceding [template integration receipt](template_integration_validation.json)
retains its original binary and eight passing timing cases. The preceding
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
