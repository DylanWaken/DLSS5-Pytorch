# DLSSNR-PyTorch

**[Documentation](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/)** · [FlashLight library](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/flashlight.html) · [Cyberpunk comparison](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/cyberpunk-comparison.html) · [310.9.16 / Small31 update](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/runtime-310-9-16.html) · [Network architecture](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html) · [Kernel lessons](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/index.html#kernels) · [Glossary](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/glossary.html) · [Design process & experiments](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/measurement-method.html)

[![FP16 Cyberpunk V three-way comparison: original downloaded pixels, Legacy71 reconstruction and Small31 reconstruction](docs/kernel-guide/media/cyberpunk-20261030/still-fp16-face.png)](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/cyberpunk-comparison.html)

*Original downloaded pixels → Legacy71 reconstruction → Small31 reconstruction, FP16, RGB-only stateless research. Not an official DLL reference. Imagery © CD PROJEKT RED; unofficial comparison, not approved or endorsed by CD PROJEKT RED. [Comparison chapter](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/cyberpunk-comparison.html) · [FP16 overview video](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/media/cyberpunk-20261030/video-fp16-overview.mp4) · [FP8 overview video](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/media/cyberpunk-20261030/video-fp8-overview.mp4).*

Reconstructed DLSS-NR CUDA kernels for PyTorch, plus a differentiable network for training research. The project follows the recovered network and packed weights, with graph/layout work adapted from [OpenDLSS-NR](https://github.com/maanHimself/OpenDLSS-NR/tree/9d08f4184bbcb9d858e2fb7a7834ec0837a9d2f1).

## What works today

| Route | What you can use |
|---|---|
| **FP8 deployment** | Prepared-feature inference at arbitrary supported padded resolutions; builds for SM89+ (RTX 40 series and newer). |
| **FP16 deployment** | Complete CUDA/C++ trunk with runtime geometry and capacity-aware scheduling; builds for SM80+ (including RTX 30 series). |
| **FP32 / BF16 training** | The default 71-role graph and opt-in Small31 graph, ordinary autograd and optional activation checkpointing. |
| **RGB research pipeline** | Both models in FP16/FP8 on SM120, with native preprocess, prepared trunk and postprocess. RGB-only stateless mode; no renderer motion/depth/history integration. |

Deployment builds separate binaries per architecture, or one multi-architecture library. Native runtime measurements use an RTX PRO 6000 Blackwell (SM120). FlashLight compile checks cover SM80, SM86, SM89 and SM120; FP8 execution requires SM89 or later. Physical RTX 30/40 hardware remains untested. Prepared-feature APIs and an RGB-only research pipeline are available; engine renderer integration is not included. C++ prepares arbitrary supported resolutions and uses ordered split launches for smaller GPU capacity. See [architecture build options and validation limits](docs/SETUP.md#architecture-specific-binaries).

## FlashLight kernel library

All 58 CUDA translation units, exposing 83 kernel entries, now use **FlashLight**, our small, header-only CUDA/C++17 template library. It adopts CUTLASS's separation of responsibilities while keeping the existing packed layouts and instruction order explicit. It has no CUTLASS, ThunderKittens, PyTorch or DLSSNR dependency.

| Layer | Responsibility |
|---|---|
| [`core`](csrc/include/flashlight/core.cuh) | Precision tags, packed values and typed MMA operand/accumulator fragments. |
| [`arch`](csrc/include/flashlight/arch/) | Individual MMA, load/store, asynchronous copy, barrier and warp instructions with architecture-specific implementations. |
| [`memory`](csrc/include/flashlight/memory/) | Byte-addressed views, staged storage, copy groups, transaction-barrier rings and split-result publication. |
| [`layout`](csrc/include/flashlight/layout/) / [`warp`](csrc/include/flashlight/warp/) | Strides, tiled addressing and lane permutations. |
| [`numeric`](csrc/include/flashlight/numeric/) / [`tile`](csrc/include/flashlight/tile/) | Packed arithmetic and tiled MMA accumulation with explicit rounding and reduction order. |

DLSSNR's activations, tensor layouts, packing and operator composition live in [`csrc/common/`](csrc/common/); launch policy stays in `csrc/kernel_launcher/`. The library centralizes repeated address and synchronization mechanics, while each kernel still specifies producer ownership and the points where its CTA must synchronize. Resident split consumers now acquire a predecessor's published result after observing its completion counter.

The [FlashLight design lesson](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/flashlight.html) walks from the C1024 FFN problem through CTA/warp subdivision, resource budgeting, a three-stage pipeline and one token's exact addresses and register fragments. Historical kernel lessons retain their original source and profiling provenance.

### Measured costs

Original means the pre-FlashLight reconstructed implementation; the DLL-kernel comparison below is a separate historical measurement.

On an NVIDIA RTX PRO 6000 Blackwell Workstation Edition (SM120), the native experiment used 128 fresh processes: two fixed ABBA/BAAB blocks per case, four process medians per arm, and 30 samples per process. The 4K RGB experiment used four ABBA sessions and 50 samples per scope/session; the smaller RGB table below reports the complete GPU pipeline, including preprocessing, the trunk, postprocessing and device-to-device copies; host transfers and decoding are excluded.

| Model / precision / resolution | Original (ms) | FlashLight (ms) | Change (µs) | Change (%) | Paired median change (µs) |
|---|---:|---:|---:|---:|---:|
| Legacy71 FP16 / 720p | 3.6359 | 3.6468 | +10.89 | +0.30 | +9.41 |
| Legacy71 FP16 / 1080p | 4.3446 | 4.3513 | +6.70 | +0.15 | +10.99 |
| Legacy71 FP16 / 1440p | 5.8885 | 5.9445 | +56.02 | +0.95 | +56.02 |
| Legacy71 FP16 / 4K | 11.0535 | 11.1172 | +63.72 | +0.58 | +127.71 |
| Legacy71 FP8 / 720p | 2.1894 | 2.2025 | +13.09 | +0.60 | +13.09 |
| Legacy71 FP8 / 1080p | 2.5874 | 2.6009 | +13.51 | +0.52 | +13.39 |
| Legacy71 FP8 / 1440p | 3.5109 | 3.5230 | +12.12 | +0.35 | +12.12 |
| Legacy71 FP8 / 4K | 6.4922 | 6.5132 | +20.98 | +0.32 | +1.84 |
| Small31 FP16 / 720p | 1.8153 | 1.8237 | +8.45 | +0.47 | +9.56 |
| Small31 FP16 / 1080p | 2.1845 | 2.1930 | +8.56 | +0.39 | +8.46 |
| Small31 FP16 / 1440p | 2.8131 | 2.8681 | +55.01 | +1.96 | +54.19 |
| Small31 FP16 / 4K | 5.4005 | 5.4923 | +91.85 | +1.70 | +89.59 |
| Small31 FP8 / 720p | 1.1093 | 1.1229 | +13.59 | +1.23 | +13.43 |
| Small31 FP8 / 1080p | 1.3389 | 1.3535 | +14.60 | +1.09 | +14.96 |
| Small31 FP8 / 1440p | 1.7015 | 1.7175 | +15.93 | +0.94 | +15.84 |
| Small31 FP8 / 4K | 3.1901 | 3.1974 | +7.31 | +0.23 | +4.63 |

| 4K RGB full GPU pipeline | Original (ms) | FlashLight (ms) | Change (µs) | Change (%) |
|---|---:|---:|---:|---:|
| Legacy71 FP16 | 13.3942 | 13.4909 | +96.72 | +0.72 |
| Legacy71 FP8 | 8.4794 | 8.4830 | +3.58 | +0.04 |
| Small31 FP16 | 7.8951 | 7.9749 | +79.81 | +1.01 |
| Small31 FP8 | 5.1698 | 5.1756 | +5.86 | +0.11 |

Native headline increases range from +0.15% to +1.96%; Small31 FP16 adds 55.01 µs at 1440p and 91.85 µs at 4K. Headline differences subtract the medians of four process medians; paired differences compare adjacent original/FlashLight processes. They need not agree: Legacy71 FP16 at 4K is +63.72 µs headline versus +127.71 µs paired. The measured cost is accepted as a maintainability and correctness tradeoff. These whole-build comparisons have incomplete original toolchain provenance, so they do not isolate wrapper overhead. All four RGB model/precision outputs match the original. See [FlashLight design and measurements](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/flashlight.html) and [measurement evidence](docs/kernel-guide/evidence-flashlight/acceptance.json).

## Two model identities

The repository supports two explicit identities. `legacy71` stays the default for the existing 71-block 310.8/310.9.16 High-resource path. `small31` is opt-in and must be named explicitly; the loader never infers a model from a file name, directory or tensor shape. Unknown names raise.

| Identity | Resource | Status |
|---|---|---|
| `legacy71` (default) | `WEIGHTS_HT`, 153 records | Existing FP8/FP16 deployment and 71-block training path, unchanged. |
| `small31` (opt-in) | `WEIGHTS_CC_SMALL_FP8`, 77 records over raw ids 0–30 | Separate trained model with a source-derived 31-role schedule, a 32 → 4 head (128 weight coefficients: 96 for RGB and 32 for the history gate), and its own native plan/loader. |

Small31 is extracted only from the original signed 310.9.16 DLL; the community-patched DLL is rejected. The DLL is parsed statically and never executed. The portable checkpoint selector below is the training and deployment entry point; the [archive compatibility APIs](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/runtime-310-9-16.html) remain available for archive-based research.

## Checkpoints: one explicit selector

Call `load_checkpoint(path, model=...)` with `"legacy71"` or `"small31"` to select the model. `legacy71` remains the default; `small31` must be named explicitly, and a mismatched file or unknown model raises instead of being inferred from the file name, tensor shapes or size.

```python
from dlssnr import load_checkpoint

model_id = "small31"  # Change to "legacy71" to select the original graph.
checkpoint_path = {
    "legacy71": "ckpts/dlss5_nr_fp8.pt",
    "small31": "ckpts/dlss5_nr_small31.pt",
}[model_id]
checkpoint = load_checkpoint(checkpoint_path, model=model_id)
```

| Model selection | Original portable file | Stored weights and supported routes |
|---|---|---|
| `legacy71` (default) | `ckpts/dlss5_nr_fp8.pt` | Original mixed FP8/Half storage plus the 153 packed native records; FP8 or lossless FP16 native deployment and FP32/BF16 training. |
| `legacy71` | `ckpts/dlss5_nr_fp16.pt` | The same learned values widened exactly to Half; FP16 native deployment and FP32/BF16 training. |
| `small31` (explicit) | `ckpts/dlss5_nr_small31.pt` | All 77 original Small31 records; FP8 or lossless FP16 native deployment and FP32/BF16 training. |

Stored weight family and compute precision are separate decisions. `training_model(..., precision="fp32")` or `precision="bf16"` builds an ordinary PyTorch/autograd graph with FP32 masters. Native plans use original packed FP8 records or losslessly repacked FP16 records with the reconstructed CUDA kernels. Widening does not recover precision the source never stored.

The actual Small31 artifact is `ckpts/dlss5_nr_small31.pt` (113,943,356 bytes, SHA-256 `742c63cae96fb0d6f53f2de6e89e8175606ad51b8939e5e7d255a9167fbef154`), extracted statically from the signed 310.9.16 `WEIGHTS_CC_SMALL_FP8` resource. It is a self-contained `.pt`: once it is downloaded via Git LFS or extracted, **no original DLL or archive directory is required to load it**. Its optional [`.json` receipt](ckpts/dlss5_nr_small31.json) records provenance; when present, the loader verifies its checkpoint file hash by default. To extract another copy into a fresh output path:

```powershell
python -B tools/extract_model_checkpoint.py --dll profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll --model small31 --output ckpts/reextracted_small31.pt
```

Substitute the path to your copy of the same signed 310.9.16 DLL if it lives elsewhere, and choose an output whose `.pt` and `.json` do not already exist. See the [checkpoint guide](ckpts/README.md) for file identities, receipt fields and the stricter CPU checks. The extraction and isolated `.pt`-only load checks are CPU-only; GPU acceptance for the checkpoint flows is recorded in the [public checkpoint acceptance receipt](docs/kernel-guide/evidence-checkpoints/acceptance.json).

Both identities are supported by the built SM120 native extension. The historical Small31 acceptance covered eight still/frame cases across both models and both precisions, including 4K input; the RGB layout bridge was byte-exact against an independent permutation, typed output fields were finite, and all four 320² graph capture/replay checks passed. Most CUDA operators are shared. Small31's eight global-attention calls select **two additional kernels** with FP32 persistent P×V accumulation and full FP32 denominator reduction. The final RGB descriptor reuses the existing phase-3 C32 output-view kernel with no extra call. FlashLight subsequently migrated all 83 entries; the Legacy71 graph and plan semantics are preserved.

The PyTorch FP32/BF16 training path has separate forward/checkpointed-gradient self-consistency checks. Native fixture acceptance and training self-consistency do not establish vendor DLL parity. See the [310.9.16 / Small31 chapter](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/runtime-310-9-16.html) for source identity, layout contracts and the measured numerical scope.

## Network at a glance

A multiscale encoder–decoder combines local window attention, a global-attention bottleneck and six skip connections. The aligned diagrams show both supported models: **Legacy71**, with the High-resource weights, and **Small31**, with the separate Small weights extracted from 310.9.16.

![Legacy71 and Small31: aligned encoder, global-attention, decoder, skip and output stages](docs/kernel-guide/assets/architecture/network-variants.svg)

Small31 uses two blocks at each local encoder/decoder stage and retains all eight global-attention blocks. Both follow the same channel ladder, 32 → 64 → 128 → 256 → 512 → 1024 and back, and produce four head channels per location: RGB plus a history gate. Small31 has its own trained weights and window phases; it is not obtained by deleting blocks from the Legacy71 checkpoint. The diagram distinguishes the 71/31 operation roles from the 153/77 packed records.

The [architecture guide](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html) expands both model schedules, then compares [FFN variants](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html#channel-mixing-inside-a-block) and [attention variants](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html#how-positions-exchange-information), including tensor flows, shapes and normalization. It also covers [encoder/decoder transitions](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html#moving-between-resolutions) and [input/output blocks](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html#entering-and-leaving-the-network).

## Getting started

Use PyTorch with CUDA and a compatible C++ compiler. The measured Windows build uses PyTorch 2.8.0+cu128, the CUDA 12.8 compiler/runtime and CUDA 13.4's PTX assembler. See the [setup guide](docs/SETUP.md) for installation and build steps.

Original [PyTorch checkpoints](ckpts/README.md) for both models are provided through Git LFS. Run `git lfs pull` after cloning. Legacy71 has FP8 and losslessly widened FP16 files; Small31 has one standalone file containing its original packed records. All initialize training directly. The original FP8 records also support native FP8 deployment and lossless FP16 widening.

```powershell
$env:CUDA_HOME = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
$env:TORCH_CUDA_ARCH_LIST = "8.0;8.6;8.9;12.0"  # Or only your target.
$env:DLSSNR_PTXAS_PATH = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.4\bin\ptxas.exe"
python setup.py build_ext --inplace
python -B run_tests.py cpu --optimized
```

Adjust the installation paths above. Omitting `DLSSNR_PTXAS_PATH` uses the toolkit's default assembler; the published speed results require the measured build configuration.

For a diagnostic plumbing check, run one real AdamW update on fresh synthetic features, save and reload the FP32 masters, then export explicit FP16 deployment records. This is a finite-output fixture, not a DLSS fine-tuning recipe or a recommended task loss:

```python
import os
import torch
from dlssnr import Geometry, export_trained_checkpoint, load_checkpoint

model_id = "small31"  # Keep this identity explicit; use "legacy71" for the 71-block graph.
checkpoint_path = {
    "legacy71": "ckpts/dlss5_nr_fp8.pt",  # Or ckpts/dlss5_nr_fp16.pt.
    "small31": "ckpts/dlss5_nr_small31.pt",
}[model_id]
checkpoint = load_checkpoint(checkpoint_path, model=model_id)

geometry = Geometry.from_valid(320, 320)
generator = torch.Generator().manual_seed(320)  # CPU generator; features move to CUDA.
features = torch.randn(
    (1, geometry.full_height, geometry.full_width, 16),
    generator=generator, dtype=torch.float32,
) * 0.02
features = features.to("cuda:0")

model = checkpoint.training_model(
    device="cuda:0", precision="bf16", trainable=True, checkpoint_blocks=False,
)
model.train()
output = model.forward_train(features, geometry=geometry)
loss = output.float().square().mean()  # Diagnostic fixture only, not a task loss.
loss.backward()
optimizer = torch.optim.AdamW(
    model.parameters(), lr=1e-5, betas=(0.9, 0.999), eps=1e-8, weight_decay=0.01,
)
optimizer.step()
optimizer.zero_grad(set_to_none=True)

model.eval()
os.makedirs("outputs", exist_ok=True)
master_path = f"outputs/diagnostic-{model_id}-master.pt"
export_path = f"outputs/diagnostic-{model_id}-fp16.pt"
torch.save(model.state_dict(), master_path)
fresh = checkpoint.training_model(
    device="cuda:0", precision="bf16", trainable=True, checkpoint_blocks=False,
)
fresh.load_state_dict(torch.load(master_path, weights_only=True), strict=True)
fresh.eval()
receipt = export_trained_checkpoint(
    fresh, export_path, model=model_id, precision="fp16",
)
deployed = load_checkpoint(export_path, model=model_id)

# Independent synthetic physical storage for the native plane16 input. These
# values are written directly to native byte slots: this is not a BHWC -> native
# packer and not the training feature above. Real RGB/BHWC deployment needs a
# matching producer.
feature_width, feature_height = geometry.levels[0]
native_generator = torch.Generator().manual_seed(320)  # Separate CPU generator.
native_slots = torch.randn(
    feature_width * feature_height * 32,
    generator=native_generator, dtype=torch.float32,
) * 0.02
prepared_half_state = (
    native_slots.to(torch.float16).view(torch.uint8).to("cuda:0")
)
plan = deployed.create_plan_fp16(prepared_half_state, width=320, height=320)
output_native = plan.run_fp16()
```

Use `precision="fp32"` instead of `"bf16"` if required; both are ordinary autograd builds with FP32 masters. The other AdamW options are the installed PyTorch 2.8 defaults (`amsgrad=False`, `maximize=False`, `foreach=None`, `capturable=False`, `differentiable=False`, `fused=None`). This 320×320 seed/scale fixture is a bounded example; the native comparison runner builds its own seeded packed fixture rather than reinterpreting this BHWC tensor.

An earlier `lr=1e-3` step produced nonfinite native FP16 output even though the stored weights were finite and serialized correctly. No particular overflowing instruction or root cause is asserted. The accepted `lr=1e-5` diagnostic is not a general training recipe.

Save into `outputs/` or another existing directory and use fresh file names; never overwrite the shipped `ckpts/`. `precision="fp16"` is itself the explicit, deliberately lossy narrowing choice; there is no separate `allow_lossy` flag. The exported file is state-only, so it never reuses stale original records as trained weights. Learned FP8 export is rejected because no inverse learned-FP8 writer exists.

GPU acceptance passed on an RTX PRO 6000 Blackwell (SM120) at 320×320: four original native cases (Legacy71 and Small31, FP16 and FP8), four optimizer/training cases (both models, FP32 and BF16) at diagnostic `lr=1e-5`, byte-exact FP32 master save/reload and loaded-versus-independently-quantized native trunk output, and one zero-update control. Two learned FP32-trained, FP16-exported stateless RGB smoke cases also exercised learned preprocess, trunk and postprocess with finite RGBA and intact trunk guards. Temporal history, motion and blend were empty; the blend scalar was verified but unchanged and not executed, and frontend guards are not separately exposed. These checks do not establish vendor/surrogate parity, image-quality improvement or broad precision/resolution support. Commands and per-case results are in the [public checkpoint acceptance receipt](docs/kernel-guide/evidence-checkpoints/acceptance.json); the original 4K speed figures are separate measurements. See [training](docs/SETUP.md#training) for the full walkthrough.

The [setup guide](docs/SETUP.md) covers training and deployment entry points. Training does not require the custom CUDA extension.

Deployment supports a single C++ call or individually composable Torch kernels:

```python
from dlssnr import prepare_kernels

result = plan.run_fp16()  # Complete prepared-feature trunk in C++.
sequence = prepare_kernels(plan)
compiled = torch.compile(sequence, fullgraph=True)
result = compiled(*sequence.tensors)
kernel = sequence.kernels[0]
kernel(kernel.inputs, kernel.outputs)  # One named CUDA kernel.
```

All 83 entries have individual Torch operators. Earlier validation of the original 81 covered default Inductor and `aot_eager` on SM120, with `triton-windows==3.4.0.post21` for Inductor. The earlier architecture-portability checks covered eager and `aot_eager`; Inductor was unavailable in that environment. The two added attention entries have their own native numerical and RGB acceptance evidence. See [setup and deployment](docs/SETUP.md#deployment) for the packed-input contract and a runnable plan example.

**Actual DLSS5 transfer-learning methodology, task losses, data preparation and training procedures still require investigation.** This is a minimal trainable implementation.

## Speed overview

Run `python test_speed.py` to measure FP16 and, on supported GPUs, FP8 at all four
resolutions. It builds a missing extension for your GPU automatically and saves
latency, throughput and memory results as JSON/CSV. Add `--per-kernel` for a
separate diagnostic breakdown. Checkpoints are required; extracted DLLs are not.
`--model {legacy71,small31}` selects the identity (default `legacy71`) and
`--checkpoint PATH` selects one original portable file for every tested precision:

```powershell
python test_speed.py --model legacy71 --checkpoint ckpts/dlss5_nr_fp8.pt
python test_speed.py --model small31 --checkpoint ckpts/dlss5_nr_small31.pt
```

`--precision {auto,fp16,fp8}` and `--checkpoint-dir DIR` are also available; without
`--checkpoint`, Legacy71 uses `dlss5_nr_<precision>.pt` and Small31 uses
`dlss5_nr_small31.pt`. A Legacy71 file requires its JSON sidecar; the Small31
sidecar is optional. See [local speed testing](docs/SETUP.md#test-speed-on-your-gpu) for options.

**Historical comparison against DLL-extracted CUDA kernels.** The measurements below were collected on 2026-10-30, before the FlashLight migration, using the RTX PRO 6000 Blackwell (SM120), driver 610.62, and the then-accepted native extension. Legacy71 replays kernels extracted from **310.8.0.0**; Small31 replays kernels extracted from the signed **310.9.16.0** DLL. These are prepared-feature trunk timings using our reconstructed schedules. They exclude RGB preprocessing/postprocessing, transfers, decoding, and DLL/NGX host execution; the [Cyberpunk RGB timings](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/cyberpunk-comparison.html) measure a different scope.

| Model at 3840 × 2160 | Precision | DLL-kernel replay | Reconstruction |
|---|---|---:|---:|
| Legacy71 · 310.8.0.0 | FP16 | 12.058 ms | 11.756 ms |
| Legacy71 · 310.8.0.0 | FP8 | 7.030 ms | 6.879 ms |
| Small31 · 310.9.16.0 | FP16 | N/A: required Half exports absent | 5.748 ms |
| Small31 · 310.9.16.0 | FP8 | 3.416 ms | 3.411 ms |

**FP8, both models:** each panel shows 720p, 1080p, 1440p and 4K. Small31 comparisons are timing-only: our FP32 persistent P×V accumulation and denominator differ from the extracted vendor kernel's Half arithmetic. Both executions remain finite, but numerical equality is not claimed.

![Legacy71 and Small31 FP8 prepared-trunk latency versus their DLL-extracted kernels at four resolutions](docs/figures/deployment_fp8_resolutions.svg)

**FP16, both models:** Legacy71 has a paired DLL-kernel reference. Small31 shows reconstruction latency only: the extracted 310.9.16 CUDA modules lack the 33 Half symbols required by its replay schedule. This does not establish what other execution paths the full DLL might support.

![Legacy71 and Small31 FP16 prepared-trunk latency at four resolutions, with unavailable Small31 DLL references explicitly marked](docs/figures/deployment_fp16_resolutions.svg)

Each model uses its own packed weights and a fixed synthetic prepared-feature fixture (seed 3108, normal noise scaled by 0.02 and cast to the selected precision). Each paired case uses 64 alternating pairs, balanced across both execution orders, after 20 warmup graph replays. A captured graph contains three trunk passes; each timed sample replays it ten times, giving 30 passes per sample. Bars report median milliseconds per pass; percentage annotations use the median of paired reconstruction/reference ratios, which can differ from the ratio of the two latency medians. Small31 FP16 uses 64 reconstruction-only samples with the same graph and warmup settings.

All eight Legacy71 cases are byte-exact at all 74 checked boundaries. All four Small31 FP8 pairs pass finite-output, memory-guard, counter and fresh-input checks at 34 boundaries, but first diverge at `b31.output`. At 4K, the largest boundary relative L2 difference is 0.143 and the largest absolute difference is 4.0 in internal feature values. The receipt reports these numerical differences separately from latency; there is no speed pass threshold. See the [measurement summary](docs/figures/dual_model_deployment_measurements.json) and [raw scalar receipt and samples](docs/figures/dual_model_deployment_raw.json) for hardware, source/DLL/weight/binary hashes, per-case checks and paired variability.

The paired protocol is implemented in [benchmark_model_vendor.py](tools/benchmark_model_vendor.py), separate from the convenience `test_speed.py` runner. This replay tool currently targets Windows/SM120; its `--help` documents explicit model, precision, checkpoint/archive and extracted-module paths. [extract_vendor_kernels_310_9_16.py](tools/extract_vendor_kernels_310_9_16.py) statically extracts the pinned signed DLL's compressed CUDA modules using Python 3.14's `compression.zstd`. Supply the matching DLL and model assets to reproduce these measurements.

**Legacy71 training (earlier measurements):** full-network FP32/BF16 forward and backward, with checkpointing, batch one and no optimizer. At 4K, peak allocated memory is **52.4 / 43.3 GiB**, respectively. This chart does not measure Small31 or compare training against a DLL.

![FP32 and BF16 training speed and memory at four resolutions](docs/figures/training_resolutions.svg)

## Project layout and further reading

`csrc/kernel_impl/<network_stage>/{fp8,fp16,common}` contains **58 complete kernel bodies for 83 public configurations**: the original 56 bodies/81 configurations plus two Small31 attention entries. Each global function owns its storage, loops, pipeline schedule and writeback; repeated model blocks share implementations.

**FlashLight**, in [`csrc/include/flashlight`](csrc/include/flashlight), is the project's C++17 CUDA template library. It separates instruction primitives, packed numeric types, memory views and synchronization protocols, coordinate layouts, warp operations and tiled MMA. It has no CUTLASS, ThunderKittens, Torch or DLSSNR dependency. Recovered model layouts and activation/attention compositions live in `csrc/common/{layout,ops}`; native parameter records live in `csrc/include/dlssnr/abi`. Model-neutral host validation and execution helpers live in `csrc/common/host`, while `kernel_launcher` selects launches and `torch_api` registers the public interfaces.

The Python package separates weight/state ownership, checkpoint serialization, native frontend execution, media handling and diagnostics. `dlssnr/build` owns build and architecture-policy helpers; `tuning` retains offline tools and compatibility entry points. The historical kernel lessons continue to quote their original committed sources and profiler evidence.

- [Setup, deployment and training](docs/SETUP.md)
- [Network architecture and tensor flow](https://dylanwaken.github.io/DLSS5-Pytorch/kernel-guide/architecture.html) — both model schedules and 16 SVG diagrams; [local HTML](docs/kernel-guide/architecture.html).
- [83 standalone FP16/FP8 kernel lessons](https://DylanWaken.github.io/DLSS5-Pytorch/kernel-guide/) — one complete reconstruction tutorial per public kernel, with model equations, tensor/lane/address diagrams, source excerpts and [local HTML](docs/kernel-guide/index.html).
- [Kernel reconstruction workflow](skills/dlssnr-reconstruction/SKILL.md)
