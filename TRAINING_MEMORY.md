# Training memory and checkpointing

Block checkpointing now lets all eight measured FP32/BF16 cases, from 720p through 4K, complete on the 95.59 GiB test device. Enable `checkpoint_blocks=True` when training at these resolutions; it trades backward recomputation for lower retained activation memory. The option remains **off by default**. See the [training guide](training.md) for runnable examples.

## Why the initial eager route exceeded 96 GB

The first benchmark measured an unnecessarily memory-hungry eager implementation. Its failures do not establish an inherent memory requirement of DLSS-NR.

The decoded FP32 parameters occupy 583,020,460 bytes (0.543 GiB, about 145.8 million scalar parameters). Batch size was one, with no optimizer state. All three failures happened inside the first forward, before backward or result validation. The five successful cases had the same allocated peak across all seven iterations; the benchmark did not accumulate graphs across iterations.

The saved-activation audit executes the original graph on PyTorch meta tensors. It deduplicates views by backing-storage identity, excludes original parameter storage, and attributes each saved storage to the first operation that saved it. This allocates no GPU memory. It is graph-storage accounting, **not a measured device peak**: temporary forward tensors, backward workspace and allocator overhead are additional.

| Saved nonparameter storage | 720p | 1080p | 2560 × 1440 | 4K |
|---|---:|---:|---:|---:|
| FP32 | 32.36 GiB | 69.58 GiB | 119.06 GiB | 270.67 GiB |
| BF16 | 27.70 GiB | 59.27 GiB | 101.22 GiB | 229.71 GiB |

The original FP32 720p GPU benchmark measured a 33.85 GiB allocated peak. At 2K, FP32 forward failed near the end of block 70 with 121.37 GiB reported allocated by PyTorch. Windows allocator accounting must not be confused with physically resident VRAM: the device reports 95.59 GiB capacity.

At 2K FP32, first-saving-operation attribution was:

| Operation | Saved unique storage |
|---|---:|
| Piecewise activation (`Numerics.silu`) | 47.27 GiB |
| Linear projections | 22.78 GiB |
| Attention matrix multiplications | 15.90 GiB |
| Surrogate attention exponentials | 13.71 GiB |
| Other layout and elementwise operations | 9.41 GiB |
| Vector normalization | 9.23 GiB |
| Residual and reciprocal operations | 0.76 GiB |

The eager activation promotes its input to FP32 and evaluates clamp, absolute value, multiply and add as separate differentiable operations. Autograd retains multiple feature-sized intermediates. Input and output blocks operate at full padded resolution; at padded 4K, one `[1,2176,3840,128]` FP32 activation occupies 3.984 GiB. Multiple saved copies make these blocks particularly expensive.

Attention explicitly materializes score, exponential and probability tensors. Its surrogate arithmetic differs from ordinary softmax attention, so replacing it would change the computation. BF16 changes matrix working precision, while activation, normalization, exponential and residual arithmetic still create FP32 intermediates. Consequently, the original BF16 route reduces saved memory by much less than 50%.

The [original audit](../outputs/all-reconstructed-deployment-prep/training-benchmark/MEMORY-ANALYSIS.md), [saved-storage evidence](../outputs/all-reconstructed-deployment-prep/training-benchmark/saved-tensors-audit.json) and [eager measurements](figures/training_resolutions_eager_v1.json) remain preserved.

## Completed checkpoint fix

The training model now uses non-reentrant PyTorch checkpointing when explicitly enabled and autograd is active. Backward recomputes stage internals instead of retaining every eager intermediate across the network. The arithmetic, FP32 parameter storage and diagnostic loss are unchanged; no-grad execution bypasses checkpointing.

```python
model = DLSSNR.from_directory(
    "assets/nr", device="cuda", dtype=torch.float32,
    precision="bf16",  # or "fp32"; keep FP32 master parameters
    trainable=True, checkpoint_blocks=True,
).train()
```

The separate [parity run](../outputs/all-reconstructed-deployment-prep/training-checkpoint/run-v1/receipt.json) passed for both precisions: the head, all **77 training boundaries and 639 used parameter gradients were bit-exact** against eager execution. It also checked the default-off setting, no-grad bypass and immutable input/parameter bytes. This was a B1 valid 33 × 33, padded 320 × 320 fixture; it does not establish eager/checkpoint gradient equality at every larger benchmark resolution.

All eight checkpoint-enabled cases passed on an NVIDIA RTX PRO 6000 Blackwell Workstation Edition (SM120), with PyTorch 2.8.0+cu128 and CUDA 12.8. Each case used two warmups and seven complete measured iterations. CUDA-event medians and peak allocated memory are:

| Valid resolution | Precision | Forward ms | Forward + scalar + backward ms | Peak allocated GiB |
|---|---|---:|---:|---:|
| 1280 × 720 | FP32 | 160.398 | 615.822 | 6.99 |
| 1280 × 720 | BF16 | 186.745 | 676.341 | 5.86 |
| 1920 × 1080 | FP32 | 243.452 | 989.002 | 14.32 |
| 1920 × 1080 | BF16 | 272.740 | 1,003.396 | 11.90 |
| 2560 × 1440 | FP32 | 377.271 | 1,567.885 | 23.97 |
| 2560 × 1440 | BF16 | 413.743 | 1,554.986 | 19.86 |
| 3840 × 2160 | FP32 | 833.493 | 3,740.222 | 52.43 |
| 3840 × 2160 | BF16 | 893.420 | 3,719.308 | 43.32 |

The [accepted benchmark receipt](../outputs/all-reconstructed-deployment-prep/training-checkpoint-benchmark/run-v1/receipt.json) and [chart data](figures/training_resolutions.json) preserve all samples, settings, geometry and hashes. Memory is peak PyTorch allocated accounting across the complete iteration, not forward-only usage or physical-residency proof.

These measurements cover all 71 training blocks at B1, with seeded synthetic FP32 features, FP32 masters and `head.square().mean()` followed by backward. There is no optimizer, input gradient, compilation or CUDA graph; TF32 is disabled. Larger cases check finite outputs and used gradients. Precisions ran sequentially, not in balanced paired order, so timings are descriptive rather than controlled speedup estimates. Eager and checkpoint-enabled results remain separate: the earlier OOMs are not supported-model resolution limits.

Checkpointing addresses activation retention. It does not establish training quality, renderer integration or DLSS5 transfer-learning methodology; task-specific losses, temporal data preparation and training procedures still require investigation.
