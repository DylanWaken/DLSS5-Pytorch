# Reconstruction status

Current source integrates **40 logical kernel configurations into 15 full-body
global templates**, retaining 41 direct globals: **81 logical kernels in 56 CUDA
compilation units**. The [integration validation receipt](template_integration_validation.json)
records the normal extension's source/binary identities, completed checks and
installation state. The installed build `aa628311…` preserves all 81 GPU
instruction payloads, constants and resource counts. All eight FP8/FP16 native
graph comparisons pass at 720p through 4K, with a worst execution-order median
of **1.008408** (0.841% slower, FP8 1080p). All 74 boundaries, poisoned replay
and changed-input replay pass at every size. The individual Torch APIs,
default Inductor, AOT eager, captured C++ execution and 81 CPU checks per Python
mode also pass. [Current measurements](figures/template_integration_deployment_measurements.json)
retain the exact binary and run identities.

The preceding per-entry build passed the ≤1% native-speed gate for FP8 and FP16
at 720p, 1080p, 1440p and 4K on SM120, including all 74 boundaries and poisoned/
changed-input replay. Its [measurements](figures/global_entry_deployment_measurements.json)
and [receipt](global_entry_validation.json) remain historical; they compare the
extracted-kernel prepared-feature trunk, not the complete DLL host/renderer.

## Source coverage

`kernel_impl/fp8` has 26 global-body files, `fp16` has 27 and `common` has three
(two precision-shared repacks and counter clear). Every body shows its storage,
pipeline, loops and writes. Shared headers retain repeated math, profiles and
intrinsics. The [reading guide](KERNEL_READING_GUIDE.md) and
[source layout](SOURCE_LAYOUT.md) provide current navigation.

The trunk still reuses 36 entries per precision across 152 compute/repack
positions and 33 clears, binds 142 records and exposes 74 boundaries. The
template manifest preserves logical names and admitted configurations. Compact
C32, two-warp C64 and wide C128/C256 remain distinct schedules; C32 output-view
entries retain direct bodies. The [feasibility audit](KERNEL_TEMPLATE_FEASIBILITY.md)
records isolated pilots and their exceptions; it does not substitute for
integrated-extension qualification.

Typed ABI records, parameter aliases and same-TU resolver declarations remain
in `common/kernel_abi.h`. Global templates have C++ mangled symbols; their C-linkage
host resolvers return registered addresses. `kernel_launcher/kernel_symbols`
maps stable names, with additive C++ `KernelSymbol` and Torch `kernel_symbol`
diagnostic lookups. Resolvers do not launch or select policies. Host launchers
remain host-only, project namespaces remain absent, and inline PTX remains in
`intrinsics.cuh`; the matrix primitive is `MMA`.

All 81 logical entries retain individual tensor-facing Torch operations and
compiler-visible sequences, alongside integrated C++ execution. Their physical
contracts and capture ownership are described in the [API guide](API_MIGRATION.md).
Current-build results belong to the integration receipt; earlier public API and
compiler checks retain the per-entry build identity.

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

The admitted deployment scope remains batch-one SM120 and four exact resolutions. Continuous-resolution tuning, other GPU architectures and renderer integration remain unfinished. Passing the latency gate does not establish an 85% hardware roofline or parity for every isolated kernel.

The [historical status report](RECONSTRUCTION_STATUS_HISTORY.md), [earlier readability report](CODE_READABILITY_HISTORY.md), [FP16 integration report](FP16_DEPLOYMENT.md) and optimization logs preserve preceding implementations, timings and failed trials. Their measurements are not substituted for the current template build.
