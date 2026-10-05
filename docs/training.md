# FP32 and BF16 training

`DLSSNR` is a minimal, trainable, pure-PyTorch model, separate from reconstructed CUDA deployment. **DLSS5 transfer-learning methodology, task losses, data preparation and optimization procedures still require investigation.** The scalar below is a benchmark diagnostic, not a proposed training objective.

```python
import torch
from dlssnr import DLSSNR, Geometry

model = DLSSNR.from_directory(
    "assets/nr", device="cuda", dtype=torch.float32,
    precision="bf16",           # or "fp32"
    trainable=True,
    checkpoint_blocks=True,     # explicit memory/recomputation tradeoff
).train()
geometry = Geometry.from_valid(1280, 720)
features = torch.randn(
    1, geometry.full_height, geometry.full_width, 16,
    device="cuda", dtype=torch.float32,
) * 0.02
model.zero_grad(set_to_none=True)
head = model.forward_train(features, geometry=geometry)
diagnostic_scalar = head.square().mean()  # Not a task loss.
diagnostic_scalar.backward()
```

Inputs are BHWC floating tensors with 16 features over the full padded field. All 71 blocks are included, from input block 0 through head block 70. The output is an FP32 four-channel head; renderer inputs and image composition are outside this example. This boundary is larger than the deployment feature trunk.

The saved checkpoint contains FP8/FP16 values. Decoding it initializes FP32 masters but cannot recover absent precision. `trainable=True` registers decoded weights, scales and biases as parameters. Keep master storage FP32 rather than calling `model.half()` or `model.bfloat16()`.

| Precision | Matrix operands | Other arithmetic |
|---|---|---|
| `fp32` | FP32 | FP32 floating training operations |
| `bf16` | BF16 casts of FP32 masters | FP32 normalization, probability reductions and residual intermediates, with BF16 matrix/working activations |

Autograd returns gradients through BF16 casts to FP32 masters. Explicit matrix precision is preserved within ambient autocast. Floating training attention and activation are differentiable operations; they are not native FP8/FP16 publication or quantization-aware training claims. There is no `backend` argument in the current training API.

## Checkpointing and memory

`checkpoint_blocks=False` remains the default. With the option enabled and autograd enabled, ordinary blocks and input, encoder, bottleneck, decoder and head stages use non-reentrant PyTorch checkpointing. Backward recomputes stage internals instead of retaining every eager intermediate. No-grad execution bypasses it. Selected modules/bound methods and phase/geometry arguments are fixed for each call, preserving floating operations and returned boundaries.

A separate [bounded parity run](../outputs/all-reconstructed-deployment-prep/training-checkpoint/run-v1/receipt.json) passed in FP32 and BF16 on valid 33 × 33/padded 320 × 320 input: the head, **all 77 training boundaries and all 639 used parameter gradients are bit-exact** between eager and checkpointed execution. It also verifies no-grad bypass, all 71 ordered stage calls, immutable input/parameter bytes, and clean shutdown. This does not claim that every gradient was compared at every chart resolution.

The initial eager implementation was unnecessarily memory-heavy, not intrinsically limited to lower resolutions. The CPU [saved-storage audit](../outputs/all-reconstructed-deployment-prep/training-benchmark/saved-tensors-audit.json) counted **119.06 GiB** of distinct saved nonparameter storage at FP32 2K; **47.27 GiB** was first saved by the expanded piecewise FP32 activation path. Master parameters occupy only 0.543 GiB. Attention scores/exponentials, layout copies and normalization add saved state. This deduplicated meta-tensor accounting is not a measured device peak or backward workspace. The [lifetime audit](../outputs/all-reconstructed-deployment-prep/training-benchmark/RETENTION-AUDIT.md) found no cross-iteration graph retention. See the preserved [memory analysis](../outputs/all-reconstructed-deployment-prep/training-benchmark/MEMORY-ANALYSIS.md).

## Measured checkpoint-enabled results

All eight cases passed on an NVIDIA RTX PRO 6000 Blackwell Workstation Edition (SM120, reported capacity 95.59 GiB), with PyTorch 2.8.0+cu128 and CUDA 12.8. Each precision/resolution ran in a fresh held process with two warmups and seven complete measured iterations. All Jobs closed cleanly and final source/checkpoint identities passed.

![Checkpoint-enabled full-model training measurements](figures/training_resolutions.svg)

CUDA-event medians are in milliseconds. Forward is autograd-enabled and measured within the same iteration as the diagnostic scalar plus backward. The total is measured directly; separate medians are not added together. Whiskers show observed minimum and maximum, not confidence intervals.

| Valid resolution | Precision | Forward ms | Forward + scalar + backward ms | Peak allocated GiB | Peak reserved GiB |
|---|---|---:|---:|---:|---:|
| 1280 × 720 | FP32 | 160.398 | 615.822 | 6.99 | 8.25 |
| 1280 × 720 | BF16 | 186.745 | 676.341 | 5.86 | 7.66 |
| 1920 × 1080 | FP32 | 243.452 | 989.002 | 14.32 | 16.78 |
| 1920 × 1080 | BF16 | 272.740 | 1,003.396 | 11.90 | 15.65 |
| 2560 × 1440 | FP32 | 377.271 | 1,567.885 | 23.97 | 28.06 |
| 2560 × 1440 | BF16 | 413.743 | 1,554.986 | 19.86 | 26.14 |
| 3840 × 2160 | FP32 | 833.493 | 3,740.222 | 52.43 | 64.29 |
| 3840 × 2160 | BF16 | 893.420 | 3,719.308 | 43.32 | 57.04 |

Memory is peak PyTorch allocated/reserved accounting across a complete iteration, not forward-only memory or proof of physical residency. All checkpoint-enabled peaks are below reported capacity. Inputs/checkpoint/settings match across precisions, but cases ran sequentially rather than in balanced paired order; these are descriptive measurements, not noise-free speedup estimates.

Both precisions use trainable FP32 masters and identical seeded FP32 synthetic features per geometry. TF32 and BF16 reduced-precision matrix reductions are disabled. There is **no optimizer, input gradient, compilation or CUDA graph**. Checkpointing is enabled. Checkpoint decoding/upload, input allocation/upload, `zero_grad` and validation are outside event intervals. The model has 145,755,115 parameter elements. Each case checks finite head/scalar/used gradients after the first warmup and final sample, and unchanged parameter versions. Only compose-only `blocks.70.blend_scale` has no gradient for the head-only scalar.

| Valid field | Measured full padded training field |
|---|---|
| 1280 × 720 | 1344 × 768 |
| 1920 × 1080 | 1920 × 1152 |
| 2560 × 1440 | 2560 × 1472 |
| 3840 × 2160 | 3840 × 2176 |

The [raw chart JSON](figures/training_resolutions.json) preserves samples, receipt/result hashes, geometry, input hashes, settings and memory. [Checkpoint suite](../outputs/all-reconstructed-deployment-prep/training-checkpoint-benchmark/run-v1/receipt.json) SHA256: `5c921b9dd2a71d820bf14dff7d05f5acad3e5c621fa929324fdbefc18b2ab753`. Parity receipt SHA256: `f449d7609599a8ec94549caa95e559c48f0bdb88b920024d036b0e57a8da1758`.

The original [eager chart](figures/training_resolutions_eager_v1.svg), [preview](figures/training_resolutions_eager_v1.png), [raw data](figures/training_resolutions_eager_v1.json) and run-v1 remain unchanged. Five eager cases passed; FP32 2K/4K and BF16 4K OOMed in the first forward. No partial timings were invented. BF16 2K allocator accounting exceeded reported device memory and is not proof of wholly resident VRAM. Checkpointing changes memory and recomputation work; the two measurement sets remain separate.

## Reproduce a case

```powershell
New-Item -ItemType Directory -Force outputs/training | Out-Null
python -B tools/benchmark_training.py --precision bf16 --width 3840 --height 2160 --checkpoint-blocks --warmups 2 --samples 7 --out outputs/training/bf16-4k-checkpoint.json
```

Use a fresh output filename and one process per case. `--no-checkpoint-blocks` selects eager execution explicitly; the tool defaults to eager like the model. It records current source/checkpoint hashes, settings, timings and actual OOM outcomes without importing historical benchmark scripts. It currently admits the four measured dimensions on SM120. The published suite also used a held Windows Job with a per-case timeout and verified shutdown.

For manual strict-FP32 experiments, set `torch.set_float32_matmul_precision("highest")`, `torch.backends.cuda.matmul.allow_tf32 = False`, and `torch.backends.cudnn.allow_tf32 = False`. These implementation checks do not establish the quality of a trained model. Actual DLSS5 transfer-learning losses and procedures remain to be developed.
