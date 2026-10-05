# FP16 deployment: recovered graph and performance

The FP16 route implements the same prepared-feature trunk as FP8: blocks 1-69, 36 reusable compute/repack kernels, 152 compute/repack calls and 33 counter clears. Kernel selection, launch parameters and intermediate ownership live in C++; Python only prepares weights and calls the plan.

The final four-size measurements and raw timing pairs are in [the speed overview](BENCHMARKS.md). The qualified binary SHA-256 is `121ac8d04229deb97e8700f8943e882766f70c70df0cd3f4c7ad9ca69f8073f8`.

The benchmark target is SM120 on an RTX PRO 6000 Blackwell, batch one, at 720p, 1080p, 2560x1440 and 4K. The reference loads the original extracted FP16 cubins directly. It does not recompile the reference PTX or time the complete DLL/NGX renderer pipeline. Blocks 0 and 70 remain outside both deployment trunks.

## Use the portable checkpoint

```python
import torch
from dlssnr import load_checkpoint, inference_forward_fp16

checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
# prepared_state is contiguous CUDA uint8 storage in the native Half
# plane16 input layout, with 32 channels at Geometry.levels[0].
plan = checkpoint.create_plan_fp16(prepared_state, width=1920, height=1080)
output = inference_forward_fp16(plan)

# Prepare/capture on an appropriate PyTorch stream outside concurrent use.
graph = torch.cuda.CUDAGraph()
with torch.cuda.graph(graph):
    output = inference_forward_fp16(plan)
graph.replay()
```

Plan outputs alias reusable workspace. Keep the plan alive through graph lifetime and clone outputs that must survive the next call. Each plan is a mutable stream-ordered workspace. Weight loading, allocation, guard inspection and poisoning happen outside capture.

Either checkpoint can supply FP16 records: FP8 values widen exactly. The FP16 checkpoint cannot silently run the FP8 path. FP32 scale tensors remain FP32. Training uses the same checkpoint's `training_model(...)`, FP32 masters and an explicit FP32/BF16 compute choice. Downward weight conversion requires explicit quantization.

## Recover the contracts before connecting kernels

Half matrix records use the recovered K16/N16 fragment map. Multiplying FP8 byte offsets by two would mispack the matrices: FP8 also permutes input channels, while Half uses natural logical K. The packer reverses that permutation through the decoded checkpoint and independently scatters each Half matrix into the K16 record.

Ancillary Half scales, attention priors and Float head scales are preserved. Upsampling records place their projection between FFN matrices and residual scales; downsampling appends its projection after the attention scales. C512 uses separate FFN, FFN projection, QKV and attention projection records. The global QKV record retains its 128-byte Float-scale prefix. All 142 generated record lengths match their compiled contracts; the global records match previously derived native proof hashes.

The plan uses each native FP16 kernel's thread configuration. In particular, ordinary C512 Half FFN uses four warps, while its FP8 counterpart uses eight. Repack work also changes with element width. Tensor byte sizes alone cannot select either layout or launch geometry.

## Synchronization and workspace

Global Half contraction, QKV and projection publish through their Half output arrays and completion counters. They do not consume the FP8 intermediate scratch pointers. The FP16 plan therefore removes 24 FP8 scratch allocations. Decoder upsampling does use scratch, but its pointer is at ABI byte 24; FP8 uses byte 48. Every parameter structure is otherwise zero-initialized before the explicitly recovered fields are set.

At 4K, native QKV and decoder upsampling have more CTAs than can be resident at once. Their counters order Z partitions. The original functions complete with this launch on the tested SM120 device. Half admission requires a complete XY partition plane to fit, followed by bounded whole-graph and captured-replay validation. This is an empirically qualified native scheduling protocol, not a general CUDA guarantee about block order. Other architectures remain excluded.

Global allocation sizes round token rows up to 32. Original Half leaves unused trailing token rows untouched at 4K. Comparisons include these storage bytes, but finite-value checks apply to logical rows; poisoned padding is not a numerical output. Downsample auxiliary backing tails are guarded but excluded from published-boundary equality.

## Verification and profiling evidence

`tools/benchmark_fp16.py` compares all 74 published boundaries byte for byte, checks finite logical outputs, allocation guards and completed counters, and exercises poisoned capture/replay plus changed-input replay. Timing uses resident CUDA graphs containing three trunk calls, 20 warmup replays, and 64 alternating pairs. Each event interval contains ten graph replays. Preserve both execution orders and the raw pairs; do not select the faster order.

The Nsight Systems trace identifies repeated C256 windows as the largest aggregate kernel cost at 2K. Nsight Compute full and source-counter profiles compare the corresponding original and reconstructed kernel at 4K. Before tuning, native uses 188 registers versus 238 reconstructed, with no local-memory traffic in either. Tensor-pipe elapsed utilization is 72.60% versus 69.52%; kernel durations under profiling are 149.568 versus 154.688 microseconds. These profiler durations are diagnostic, not the whole-trunk timing gate.

The source-counter profile attributes the largest reconstructed hotspot to the shared Half MMA intrinsic, followed by global-load dependencies. Native cubins lack C++ line information, so their sampled PCs cannot be presented as original source-line attribution. SASS comparison provides the instruction-level evidence instead.

A 192-register cap follows the native allocation quantum. It introduces a small 24-byte stack frame and improves the measured whole-trunk result. The final profile measures 152.032 microseconds and 71.25% tensor-pipe elapsed utilization, with 321,408 local-load sectors introduced by register pressure. Occupancy remains unchanged: the gain must not be described as an occupancy increase. [Parsed metrics and report hashes](figures/fp16_profile_summary.json) preserve both the improvement and its spill cost. The preserved uncapped 4K trial missed the per-order gate by 0.035 percentage points; the capped trial passes. An additional non-volatile pure-MMA trial produced byte-identical C256 machine code and was discarded; fewer static instructions were not claimed from that change.

All build, failed-launch, profile and timing evidence remains under `outputs/fp16-fullgraph` and `profile/fp16-*`. Small portable measurements and the final SVG chart are committed under `docs/figures`. The old FP8 and training reports remain separate. Neither native matching nor a tensor-utilization sample establishes 85% hardware roofline attainment, rendering quality, or DLSS5 transfer-learning methodology.

A 720p Compute Sanitizer memcheck covers native/candidate whole-trunk execution and captured replays with **zero errors**. A fresh FP8 720p whole-trunk regression also passes. ELF extraction confirms **80 of 81** kernel instruction/control payloads remain unchanged; only C256 FP16 differs. This is not full-resolution sanitizer coverage.
