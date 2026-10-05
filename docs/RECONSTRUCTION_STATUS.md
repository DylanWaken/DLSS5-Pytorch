# Reconstruction status

The readable CUDA deployment implementation passes the **≤1% native-speed gate** for FP8 and FP16 at 720p, 1080p, 1440p and 4K on SM120. Both execution-order medians pass in every case. All 74 published boundaries, poisoned graph replay and changed-input replay pass for every resolution/precision combination.

See [current timings and scope](BENCHMARKS.md), [raw measurement data](figures/semantic_deployment_measurements.json) and [graph receipts](semantic_graph_qualification.json). The baseline is the original extracted-kernel prepared-feature trunk, not the complete DLL host/renderer pipeline.

## Source coverage

Production source contains 81 exports: 40 FP8/FP16 pairs plus a counter clear. The trunk reuses 36 entries per precision across 152 compute/repack positions and 33 clears. It binds 142 weight records and exposes 74 published boundaries. Separate fixtures test preprocessing, postprocessing and the extra output-view entries.

The register-by-register transcriptions, per-entry implementation/ABI files and unused compatibility helpers have been removed. Sixteen operation/precision wrapper headers select 21 shared algorithm headers. Inline PTX is centralized in `intrinsics.cuh`; nontrivial numerical coefficients have named constexpr values and documented roles. [Source layout](SOURCE_LAYOUT.md) and [readability/qualification details](CODE_READABILITY.md) describe the final tree.

The normal PyTorch extension builds every entry from CUDA/C++ source. The measured compiler setup keeps CUDA 12.8's frontend/runtime and explicitly selects CUDA 13.4's assembler. No precompiled native kernel is injected into the extension. [The controlled compiler experiment](COMPILER_SCHEDULING.md) explains the scheduling benefit.

## Training and checkpoints

The separate PyTorch training implementation covers all 71 numbered records, autograd and optional block checkpointing in FP32/BF16. Existing checkpointed benchmarks completed all eight resolution/precision cases. Actual DLSS5 transfer-learning methodology, task losses, data preparation and training procedures still require investigation; see [training](training.md).

Both checkpoint files are available through Git LFS. The FP16 checkpoint losslessly widens the recovered mixed-precision resource; it is not a separately recovered FP16-trained model. Downward conversion requires explicit quantization. See [checkpoint usage](../ckpts/README.md).

## Limits and preserved history

The admitted deployment scope remains batch-one SM120 and four exact resolutions. Continuous-resolution tuning, other GPU architectures and renderer integration remain unfinished. Passing the latency gate does not establish an 85% hardware roofline or parity for every isolated kernel.

The [historical status report](RECONSTRUCTION_STATUS_HISTORY.md), [earlier readability report](CODE_READABILITY_HISTORY.md), [FP16 integration report](FP16_DEPLOYMENT.md) and optimization logs preserve preceding implementations, timings and failed trials. Their measurements are not substituted for the current semantic build.
