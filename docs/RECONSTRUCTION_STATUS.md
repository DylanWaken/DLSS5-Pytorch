# Reconstruction status

The readable CUDA deployment implementation passes the **≤1% native-speed gate** for FP8 and FP16 at 720p, 1080p, 1440p and 4K on SM120. Both execution-order medians pass in every case. All 74 published boundaries, poisoned graph replay and changed-input replay pass for every resolution/precision combination.

See [current timings and scope](BENCHMARKS.md), [raw measurement data](figures/kernel_locality_deployment_measurements.json) and [validation receipts](kernel_locality_validation.json). The baseline is the original extracted-kernel prepared-feature trunk, not the complete DLL host/renderer pipeline.

## Source coverage

Production source contains 81 exports: 40 FP8/FP16 pairs plus a counter clear. The trunk reuses 36 entries per precision across 152 compute/repack positions and 33 clears. It binds 142 weight records and exposes 74 published boundaries. Separate fixtures test preprocessing, postprocessing and the extra output-view entries.

The register-by-register transcriptions, per-entry implementation/ABI files and unused compatibility helpers have been removed. Sixteen operation/precision wrapper headers select 20 shared algorithm headers. Inline PTX is centralized in `intrinsics.cuh`; nontrivial numerical coefficients have named constexpr values and documented roles. [Source layout](SOURCE_LAYOUT.md), [readability/qualification details](CODE_READABILITY.md) and the [full semantic naming audit](NAMING_AUDIT.md) describe the current tree. The earlier naming rebuild preserves every device instruction payload and separately revalidates its typed host argument packing.

The current tree also removes all project C++ namespaces. Helpers are called directly, global ABI/profile types carry descriptive `F` names, and all 81 kernels export bare `extern "C"` symbols. External library namespaces and the public Torch `dlssnr` registration domain remain unchanged. The [flat-symbol migration report](FLAT_SYMBOLS.md) records its separate compiled and runtime checks, including all eight graph cases and the C512 dispatcher.

The [storage-prefix audit](STORAGE_PREFIX_AUDIT.md) removes misleading prefixes from launch records, host handles/containers and control metadata, while retaining actual storage and fragment roles. Its rebuild preserves all GPU instruction payloads, decoded resources and constants, and passes all eight graph checks and the public dispatcher checks.

The latest [kernel-body refactor](KERNEL_READING_GUIDE.md) puts operation-specific
storage, pipeline, loops and writebacks inside each canonical function. Shared
math and reused window computation remain helpers. Of 81 device instruction
payloads, 38 change from the preceding release. Fresh native comparisons and
timings qualify all eight graph cases within 1%; 24 public-dispatch and 48
postprocessing checks also pass. The speed charts now use this build's samples.

The normal PyTorch extension builds every entry from CUDA/C++ source. The measured compiler setup keeps CUDA 12.8's frontend/runtime and explicitly selects CUDA 13.4's assembler. No precompiled native kernel is injected into the extension. [The controlled compiler experiment](COMPILER_SCHEDULING.md) explains the scheduling benefit.

## Training and checkpoints

The separate PyTorch training implementation covers all 71 numbered records, autograd and optional block checkpointing in FP32/BF16. Existing checkpointed benchmarks completed all eight resolution/precision cases. Actual DLSS5 transfer-learning methodology, task losses, data preparation and training procedures still require investigation; see [training](training.md).

Both checkpoint files are available through Git LFS. The FP16 checkpoint losslessly widens the recovered mixed-precision resource; it is not a separately recovered FP16-trained model. Downward conversion requires explicit quantization. See [checkpoint usage](../ckpts/README.md).

## Limits and preserved history

The admitted deployment scope remains batch-one SM120 and four exact resolutions. Continuous-resolution tuning, other GPU architectures and renderer integration remain unfinished. Passing the latency gate does not establish an 85% hardware roofline or parity for every isolated kernel.

The [historical status report](RECONSTRUCTION_STATUS_HISTORY.md), [earlier readability report](CODE_READABILITY_HISTORY.md), [FP16 integration report](FP16_DEPLOYMENT.md) and optimization logs preserve preceding implementations, timings and failed trials. Their measurements are not substituted for the current semantic build.
