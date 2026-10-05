# DLSSNR-PyTorch

Reconstructed DLSS-NR CUDA kernels for PyTorch, plus a differentiable network for training research. The project follows the recovered network and packed weights, with graph/layout work adapted from [OpenDLSS-NR](https://github.com/maanHimself/OpenDLSS-NR/tree/9d08f4184bbcb9d858e2fb7a7834ec0837a9d2f1).

## What works today

| Route | What you can use |
|---|---|
| **FP8 deployment** | CUDA-graph-compatible prepared-feature inference at 720p, 1080p, 2K and 4K; tested on SM120. |
| **FP16 kernels** | Reconstructed counterparts with six kernel families benchmarked at all four resolutions. Full FP16 network integration is unfinished. |
| **FP32 / BF16 training** | All 71 numbered network records, ordinary autograd and optional activation checkpointing. All eight resolution/precision benchmark cases pass. |

The current deployment target is **SM120**, tested on an RTX PRO 6000 Blackwell. Other GPUs and continuous-resolution deployment remain future work. Inputs are prepared features; renderer integration is not included.

## Network at a glance

A multiscale encoder–decoder combines local window attention, a global-attention bottleneck and skip connections. Different channel widths use different feed-forward blocks.

![Network architecture, stage ranges and skip connections](docs/figures/architecture/network.svg)

Explore the [architecture guide](docs/ARCHITECTURE.md) for expanded SVGs of every stage, FFN family, attention path, input/output component and numerical primitive.

## Getting started

Use PyTorch with CUDA and a compatible C++ compiler. The validated build uses Windows, PyTorch 2.8.0+cu128 and CUDA 12.8. An extracted checkpoint in `assets/nr` is required; see [checkpoint format and provenance](docs/assets.md).

```powershell
python setup.py build_ext --inplace
python -B run_tests.py cpu --optimized
```

For training research, keep FP32 master parameters and enable checkpointing to reduce activation memory:

```python
import torch
from dlssnr import DLSSNR, Geometry

model = DLSSNR.from_directory(
    "assets/nr", device="cuda", dtype=torch.float32,
    precision="bf16", trainable=True, checkpoint_blocks=True,
)
geometry = Geometry.from_valid(1280, 720)
features = torch.randn(1, geometry.full_height, geometry.full_width, 16,
                       device="cuda") * 0.02
head = model.forward_train(features, geometry=geometry)
head.square().mean().backward()  # Diagnostic only; not a task loss.
```

See the [training guide](docs/training.md) for input contracts and benchmarking, or the [deployment guide](docs/API_MIGRATION.md) for `create_plan_fp8` / `inference_forward_fp8` and packed-buffer preparation. Training does not require the custom CUDA extension.

**Actual DLSS5 transfer-learning methodology, task losses, data preparation and training procedures still require investigation.** This is a minimal trainable implementation.

## Speed overview

**FP8 inference:** the prepared-feature trunk is within the accepted 1% slowdown limit versus extracted original kernels at all four tested resolutions. At 4K: **6.497 ms reconstructed / 6.452 ms original**. This excludes input/output stages and DLL host processing.

![FP8 deployment latency at 720p, 1080p, 2K and 4K](docs/figures/deployment_fp8_resolutions.svg)

**Training:** full-network FP32/BF16 forward and backward, with checkpointing, batch one and no optimizer. At 4K, peak allocated memory is **52.4 / 43.3 GiB**, respectively.

![FP32 and BF16 training speed and memory at four resolutions](docs/figures/training_resolutions.svg)

<details>
<summary><strong>FP8 / FP16 kernel speed comparison</strong> — expand the six-family overview</summary>

![Six matched kernel families in FP8 and FP16](docs/figures/deployment_kernel_precision_comparison.svg)

These are individual-kernel comparisons, not a full FP16 network benchmark. Execution order affects many rankings; some kernels remain slower than their original counterparts.

</details>

See [benchmark scope and detailed results](docs/BENCHMARKS.md) for methodology, per-kernel comparisons and the preserved original OOM results.

## Project layout and further reading

`csrc/kernel_impl` contains kernel bodies and shared intrinsics; `kernel_launcher` handles launches and selection; `torch_api` exposes PyTorch operators. `dlssnr` contains the Python entry points and training model. `tests` and `tuning` hold validation and offline policy tools.

- [Architecture atlas](docs/ARCHITECTURE.md) · [Current coverage and limitations](docs/RECONSTRUCTION_STATUS.md)
- [Code conventions](docs/CODE_READABILITY.md) · [Optimization log](docs/optimization_log_2026-10-05.md)
- [Training memory diagnosis](docs/TRAINING_MEMORY.md) · [Kernel reconstruction workflow](skills/dlssnr-reconstruction/SKILL.md)
