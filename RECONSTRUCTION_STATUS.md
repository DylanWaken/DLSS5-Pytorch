# Reconstruction status

Current source integrates **40 logical kernel configurations into 15 full-body
global templates**, retaining 41 direct globals: **81 logical kernels in 56 CUDA
compilation units**. Files are now grouped by network stage, then precision;
stage-owned helpers and intrinsics accompany the kernels they serve. Repeated
encoder/decoder levels are named explicitly and retain one shared body.

Installed build **`efdfded212d90042e5ba44d010e636a4a15b827f0091c34a060f06eb92f11a24`**
adds [capacity-aware split scheduling](SMALL_GPU_SCHEDULING.md) and
[runtime input geometry](DYNAMIC_RESOLUTIONS.md). The
[current validation receipt](small_gpu_validation.json) records 14 forced-fallback
non-anchor cases and eight automatic anchor cases, all passing all 74 numerical
boundaries. Individual eager, AOT eager, default Inductor and graph routes pass
at 1234 × 777. The CPU suites pass 96 tests in each Python mode; geometry checks
cover 116 valid shape/precision cases and 16 rejected cases.

Seven of eight native-baseline timing cases meet the 1% target. **FP8 1080p is
1.1944% slower**, so the final build does not pass that target at every size.
A separate balanced comparison at 1080p measured at most about 0.36% slowdown
against the preceding accepted extension. Testing used the RTX PRO 6000
Blackwell with a capacity override to exercise the fallback; **no physical
RTX 5060 run is claimed**. The override does not simulate its hardware speed.

The stage and intrinsic moves preserve all 81 GPU instruction payloads relative
to the scheduling-fix build. That comparison isolates source organization; the
scheduling change itself is covered by the fresh numerical and timing results.

## Previous benchmark snapshots

The preceding [integration validation receipt](template_integration_validation.json)
records build `aa628311…`, its source/binary identities, completed checks and
installation at that time. That build preserves all 81 GPU
instruction payloads, constants and resource counts. All eight FP8/FP16 native
graph comparisons pass at 720p through 4K, with a worst execution-order median
of **1.008408** (0.841% slower, FP8 1080p). All 74 boundaries, poisoned replay
and changed-input replay pass at every size. The individual Torch APIs,
default Inductor, AOT eager, captured C++ execution and 81 CPU checks per Python
mode also pass. [Measurements from that build](figures/template_integration_deployment_measurements.json)
retain the exact binary and run identities.

The preceding per-entry build passed the ≤1% native-speed gate for FP8 and FP16
at 720p, 1080p, 1440p and 4K on SM120, including all 74 boundaries and poisoned/
changed-input replay. Its [measurements](figures/global_entry_deployment_measurements.json)
and [receipt](global_entry_validation.json) remain historical; they compare the
extracted-kernel prepared-feature trunk, not the complete DLL host/renderer.

## Source coverage

Stage-local `fp8/` directories contain 26 global-body files in total, and
`fp16/` directories contain 27. Three precision-independent files hold two
bottleneck repacks and the shared counter clear. Every body shows its storage,
pipeline, loops and writes. Stage `common/` headers hold local profiles, math and
instructions; `shared/common/` holds genuinely cross-stage primitives. The [reading guide](KERNEL_READING_GUIDE.md) and
[source layout](SOURCE_LAYOUT.md) provide current navigation.

The trunk still reuses 36 entries per precision across 152 compute/repack
positions and 33 clears, binds 142 records and exposes 74 boundaries. The
template manifest preserves logical names and admitted configurations. Compact
C32, two-warp C64 and wide C128/C256 remain distinct schedules; C32 output-view
entries retain direct bodies. The [feasibility audit](KERNEL_TEMPLATE_FEASIBILITY.md)
records isolated pilots and their exceptions; it does not substitute for
integrated-extension qualification.

Typed ABI records, parameter aliases and same-TU resolver declarations remain
in `shared/common/kernel_abi.h`. Global templates have C++ mangled symbols; their C-linkage
host resolvers return registered addresses. `kernel_launcher/kernel_symbols`
maps stable names, with additive C++ `KernelSymbol` and Torch `kernel_symbol`
diagnostic lookups. Resolvers do not launch or select policies. Host launchers
remain host-only, project namespaces remain absent, and inline PTX remains in
`intrinsics.cuh`; the matrix primitive is `MMA`.

All 81 logical entries retain individual tensor-facing Torch operations and
compiler-visible sequences, alongside integrated C++ execution. Their physical
contracts and capture ownership are described in the [API guide](API_MIGRATION.md).
Results belong to the receipt naming the tested source and binary; previous
public API and compiler checks retain their original build identity.

The normal extension builds kernels from CUDA/C++ source with no injected
native cubin or legacy compute fallback. The measured baseline toolchain uses
CUDA 12.8's frontend/runtime with CUDA 13.4's assembler; see
[the compiler experiment](COMPILER_SCHEDULING.md). New-build identities and
qualification must be recorded independently.

The preceding [directory migration](precision_layout_audit.json),
[flat-symbol report](FLAT_SYMBOLS.md) and [storage-prefix audit](STORAGE_PREFIX_AUDIT.md)
retain their historical scope. The earlier 81-file refactor had 50/81 unchanged
instruction payloads, 72/81 unchanged resource rows and all 81 constant sections
equal to its predecessor. Its eight graph timing cases passed with a worst
0.657% slowdown; those samples are not relabeled as template-build timings.

## Training and checkpoints

The separate PyTorch training implementation covers all 71 numbered records, autograd and optional block checkpointing in FP32/BF16. Existing checkpointed benchmarks completed all eight resolution/precision cases. Actual DLSS5 transfer-learning methodology, task losses, data preparation and training procedures still require investigation; see [training](training.md).

Both checkpoint files are available through Git LFS. The FP16 checkpoint losslessly widens the recovered mixed-precision resource; it is not a separately recovered FP16-trained model. Downward conversion requires explicit quantization. See [checkpoint usage](../ckpts/README.md).

## Limits and preserved history

Deployment remains batch-one SM120. Small-SM scheduling and dynamic geometry are
separate from continuous-resolution performance tuning. Other GPU architectures
and renderer integration remain unfinished. Passing the preceding latency gate
does not establish an 85% hardware roofline or parity for every isolated kernel.

The [historical status report](RECONSTRUCTION_STATUS_HISTORY.md), [earlier readability report](CODE_READABILITY_HISTORY.md), [FP16 integration report](FP16_DEPLOYMENT.md) and optimization logs preserve preceding implementations, timings and failed trials. Their measurements are not substituted for the current build.
