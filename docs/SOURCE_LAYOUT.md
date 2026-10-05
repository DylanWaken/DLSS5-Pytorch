# CUDA source layout

Each exported deployment kernel is implemented in
`csrc/kernel_impl/<fp8|fp16|common>/<exact_export_name>.cu`. The file contains one
`extern "C" __global__` definition whose body shows its storage, pipeline,
computation loops, synchronization and writebacks. Open the named `.cu` file
to read the algorithm; there is no separate canonical `Run*` body behind an
ABI adapter. The [kernel reading guide](KERNEL_READING_GUIDE.md) gives concrete
entry files for every operation family.

The roster has **81 entries: 76 mathematical/frontend entries, four repack
entries and one completion-counter clear**. The first 80 form 40 FP8/FP16 pairs.
These are exported configurations, not 81 unrelated algorithms or 81 network
positions. Repeated graph positions can launch the same entry.

The [directory-migration audit](precision_layout_audit.json) records the move of
107 files into `fp8`, `fp16` and `common`. The reorganized build preserves all
81 GPU instruction payloads, constants and decoded resource rows from the
measured build. Existing benchmark samples retain their original binary identity.

## Directory responsibilities

```text
csrc/
  kernel_impl/
    fp8/                      40 named FP8 kernel entries
    fp16/                     40 named FP16 kernel entries
    common/                   Shared math, profiles, storage and intrinsics
      kernel_abi.h            Typed launch records, offsets and declarations
      completion_counter_clear.cu   Precision-independent counter reset
  kernel_launcher/            Host launchers, geometry, plans and C++ selection
  torch_api/                  PyTorch bindings and tensor-facing contracts
tests/                        CPU, CUDA, graph and training checks
tuning/                       Native profiles and measured selection policies
__init__.py                   Minimal public Python entry points
run_tests.py                  Test entry point
run_tuning.py                 Offline tuning entry point
```

`kernel_launcher` is host-only. Kernel bodies, device helpers and the authoritative
parameter ABI reside in `kernel_impl`. A parameter record is declared once in
[kernel_abi.h](../csrc/kernel_impl/common/kernel_abi.h), with size, alignment and offset
assertions; host and device code consume the same record. Python does not choose
a different arithmetic implementation on each call.

Project declarations and helpers are global, with descriptive names instead of
namespaces. ABI/profile types use the `F` prefix. Bare C export names retain
`_fp8` and `_fp16`; the counter clear is precision-independent. External
`std::`, `at::` and `c10::` qualifications and the public
`TORCH_LIBRARY(dlssnr, ...)` domain remain unchanged.

## Entry bodies and shared helpers

The entry owns its work from setup to publication, including any fused sampling
or frontend stage. A small local lambda may express a repeated prefill/refill
sequence while keeping its address calculations and waits in view. A helper
used only by one kernel stays in that kernel's file. Do not move the complete
schedule into a shared function, a macro or an included body fragment.

Shared headers retain substantial repeated mathematics and real data/layout
contracts. They can serve FP8/FP16 pairs or several channel configurations;
sharing a profile does not require sharing the whole global function.

| Shared source | Retained responsibility |
| --- | --- |
| `warp_window32.cuh`, `warp_window_wide.cuh` | Window profiles, register/shared fragments, linear/attention/normalization/expert arithmetic |
| `window_ffn.cuh`, `window_qkv.cuh`, `spatial_projection.cuh` | C512 profiles, coordinate types and reused fragment/address primitives |
| `window_pool.cuh`, `window_downsample.cuh`, `window_upsample.cuh` | Exact pooling arithmetic, common publication/padding contracts and sampling profiles |
| `global_*.cuh`, `channel_projection.cuh`, `decoder.cuh` | Global/connector profiles, layout types and reused mathematical primitives |
| `frontend_profiles.cuh`, `frontend_math.cuh`, `input_features.cuh` | Shared renderer-stage types, numerical constants and reused feature/filter math |
| `global_repack_layout.cuh` | Pure physical-layout maps used by both repack directions and precisions |

Examples of local flow are the asynchronous copy/wait/reduction sequence in
[global_qkv_c1024_fp8.cu](../csrc/kernel_impl/fp8/global_qkv_c1024_fp8.cu), the grouped
MLP in [window_ffn_c512_fp8.cu](../csrc/kernel_impl/fp8/window_ffn_c512_fp8.cu), and
the sampling plus full window schedule in
[window_block_c64_upsample_fp16.cu](../csrc/kernel_impl/fp16/window_block_c64_upsample_fp16.cu).
The old operation/precision wrapper headers and `Run*` owners are superseded.

## Device primitives

| Header | Contract |
| --- | --- |
| `intrinsics.cuh` | Force-inlined PTX instructions with explicit operand, rounding, address-space and synchronization behavior |
| `mma.cuh`, `tiled_mma.cuh` | `MMA(...)`, named tensor fragments and reused tile accumulation; FP8 K32 and FP16 K16 selection |
| `packed_math.cuh` | Packed Half arithmetic, conversion, publication and activation |
| `numerical_constants.cuh` | Named `CONST_*` bit patterns, decoded values and observed arithmetic roles |
| `memoryops.cuh` | Shared barrier arrival and phase-wait primitives |
| `kernel_helpers.cuh` | Common ABI and device-utility includes |

`MMA` is the current fragment interface name; it replaces `MultiplyAccumulate`.
Shared helpers must not merge distinct Half reduction trees, cache policies,
packing boundaries or synchronization contracts merely to shorten source.

## Native profiles and resolution plans

C32 windows are warp-local. C64 uses token parallelism in the FFN, while
C128/C256 exchange channel panels through shared memory. Their entry files show
those schedules explicitly. Input/output views and fused sampling retain the
native bounds, singleton broadcasts, fragment ordering and barriers.

C512 FFN, QKV and projections remain separately launched stages. FP8 and FP16
can differ in warp count, tensor-core K step and copy transactions. C1024
stages use their recovered global layout, split reductions and completion
counters. Profile types express those real differences; they do not introduce
a new runtime algorithm-selection path.

Host launch tables and generated deployment/geometry plans retain the admitted
configurations. `tuning/plan[_fp16]_W_H.json` records native symbols, geometry,
buffers and ABI bindings. The plan generator resolves each bare entry to its
checked parameter fields. The source build compiles the named kernel `.cu`
files; device implementations are not emitted by launcher translation units.

Four admitted SM120 plans do not establish continuous-resolution tuning,
arbitrary channel counts or another GPU architecture. Template coverage and
source organization add no performance or correctness qualification.

## Inventory and qualification

```powershell
python -B tools/kernel_sources.py --output outputs/kernel-sources.json
python run_tests.py cpu --optimized
```

The [current source audit](global_entry_audit.json) records **81 CUDA
compilation units and 25 shared headers**, with no CUDA translation units in
the host-only launcher directory. Inspect the exact exported roster, C linkage,
local include resolution and unique `.cu` owner for each entry. Structural
checks remain separate from compilation, native numerical comparison and timing.

The [current validation receipt](global_entry_validation.json) qualifies the
built per-entry implementation. Compared with the preceding build, **50/81 GPU
instruction payloads, 72/81 decoded resource records and all 81 entry constant
sections** are identical. All eight FP8/FP16 graph cases at 720p, 1080p,
2K/1440p and 4K pass native boundary/replay checks and the within-1% latency
gate in each execution order; the
[current paired timings](figures/global_entry_deployment_measurements.json)
pin this candidate's binary and harness. The receipt also records 70 CPU tests
in each Python mode, separate native frontend/output-view fixtures and 24
C512 dispatcher cases.

The preceding [kernel-body validation](kernel_locality_validation.json) and its
[timing data](figures/kernel_locality_deployment_measurements.json) are
historical: they tested the earlier layout with canonical functions and small
exports. Their 43/81 unchanged GPU payloads and successful timing gates must
not be relabeled as results for this migration.

Earlier [semantic graph receipts](semantic_graph_qualification.json),
[semantic timing data](figures/semantic_deployment_measurements.json),
[naming](NAMING_AUDIT.md), [flat-symbol](FLAT_SYMBOLS.md) and
[storage-prefix](STORAGE_PREFIX_AUDIT.md) qualifications keep their original
source and binary identities. The [historical schedule census](kernel_schedule_census.json)
describes earlier transcript counts, not dynamic instruction work in these
loop-based kernels. See [code conventions](CODE_READABILITY.md) for the evidence
required before carrying a speed claim to a rebuilt source.
