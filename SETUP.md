# Setup and quickstart

The CUDA deployment extension supports **batch one on SM120**, with FP8 or FP16
packed features. FP32/BF16 training uses a separate ordinary PyTorch model.
See the [project overview](../README.md) and [network architecture](ARCHITECTURE.md)
for coverage and performance scope.

## Windows environment and build

The measured environment uses Python 3.11, PyTorch 2.8.0+cu128, CUDA 12.8
compiler/runtime and CUDA 13.4's PTX assembler. Install Git LFS, a CUDA-capable
NVIDIA driver, CUDA 12.8 and Visual Studio C++ build tools first; install CUDA
13.4 as well if selecting its assembler below. Run
these commands from the repository root in a terminal with the C++ toolchain
available. Adjust toolkit paths to your installation.

```powershell
py -3.11 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install torch==2.8.0 --index-url https://download.pytorch.org/whl/cu128
python -m pip install numpy setuptools wheel ninja
git lfs pull

$env:CUDA_HOME = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.8"
$env:TORCH_CUDA_ARCH_LIST = "12.0"
$env:DLSSNR_PTXAS_PATH = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.4\bin\ptxas.exe"
python setup.py build_ext --inplace
python -B run_tests.py cpu --optimized
```

`DLSSNR_PTXAS_PATH` is optional: omit that assignment to use CUDA 12.8's default
assembler. The published speed measurements use the newer assembler. Other
architecture targets are currently rejected. The CPU checks do not load the
CUDA extension; inspect skipped compiler-dependent checks separately.

The extension registers Torch operations rather than a Python module. Public
deployment calls load it automatically; for an explicit binary, use
`dlssnr.deployment.load_extension(path)`. Do not `import dlssnr._C`, and use a new
process when switching binaries. Training alone does not need this extension
or the CUDA compiler.

## Checkpoints

`git lfs pull` retrieves both [checkpoint files](../ckpts/README.md):

- `ckpts/dlss5_nr_fp8.pt`: original FP8 matrices, FP16 auxiliaries and FP32 scales;
  supports FP8/FP16 deployment and FP32/BF16 training.
- `ckpts/dlss5_nr_fp16.pt`: the same FP8 values widened exactly to FP16;
  supports FP16 deployment and FP32/BF16 training.

There is no separate higher-precision trained weight resource. Downward weight
conversion requires explicit quantization and is rejected; FP32 scales stay
FP32. Loading these checkpoints needs no extracted DLL asset directory.

## Deployment

The full C++ deployment call runs the **blocks 1–69 feature trunk**, not RGB
preprocessing or renderer composition. Its input is contiguous, one-dimensional
CUDA `uint8` storage in the native plane16 layout. FP8 and FP16 have their own
packing; reshaping BHWC features or reinterpreting bytes does not perform it.

```python
import torch
from dlssnr import Geometry, load_checkpoint, prepare_kernels

width, height = 1234, 777
geometry = Geometry.from_valid(width, height)
feature_width, feature_height = geometry.levels[0]

# Supply prepared_state from a matching FP16 physical-layout producer.
# It is not created by this example and is not an RGB/BHWC tensor.
assert prepared_state.is_cuda and prepared_state.dtype == torch.uint8
assert prepared_state.ndim == 1 and prepared_state.is_contiguous()
assert prepared_state.numel() == feature_width * feature_height * 32 * 2

checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
plan = checkpoint.create_plan_fp16(prepared_state, width=width, height=height)
output = plan.run_fp16()

sequence = prepare_kernels(plan)
output = sequence(*sequence.tensors)  # Individually visible Torch operations.
output = sequence.run_cpp()           # Bound chain dispatched entirely in C++.
```

FP8 uses the FP8 checkpoint, `create_plan_fp8`, `run_fp8`, and one byte per
feature element. Prepare plans outside CUDA Graph capture. Keep plans alive
through asynchronous work/capture, order shared-workspace executions, and clone
outputs that must survive another run. C++ derives supported padded resolutions
at runtime and chooses ordered split launches when resident capacity is too
small. New dimensions require a new plan; index, operand and memory limits
still apply. No physical RTX 5060 has been tested.

`torch.compile(sequence, fullgraph=True)` exposes the same individual operators;
default Inductor needs compatible Triton. The tested Windows environment uses
`triton-windows==3.4.0.post21`. Integrated C++ execution needs no Triton. See
[deployment.py](../dlssnr/deployment.py) for individual-kernel and frontend APIs.

## Training

```python
import torch
from dlssnr import Geometry, load_checkpoint

model = load_checkpoint("ckpts/dlss5_nr_fp16.pt").training_model(
    device="cuda", precision="bf16", checkpoint_blocks=True,
).train()
geometry = Geometry.from_valid(1280, 720)
features = torch.randn(1, geometry.full_height, geometry.full_width, 16,
                       device="cuda", dtype=torch.float32) * 0.02
model.zero_grad(set_to_none=True)
head = model.forward_train(features, geometry=geometry)
head.square().mean().backward()  # Diagnostic scalar, not a proposed task loss.
```

Use `precision="fp32"` for FP32 computation. Keep FP32 master parameters;
do not call `model.half()` or `model.bfloat16()`. Training includes all 71 blocks
and uses floating BHWC features, unlike deployment byte buffers. Checkpointing
trades recomputation for lower activation memory. **Actual DLSS5 transfer
learning, task losses, data preparation and training procedures remain TBD.**

GPU comparison fixtures additionally need cached original DLL/cubin assets;
the training benchmark worker needs `assets/nr`. There is no current top-level
asset-acquisition CLI. These prerequisites apply to the validation tools, not
checkpoint-based model use. See the live commands in [run_tests.py](../run_tests.py)
and the [prepared API test](../tests/test_prepared_kernel_api.py).
