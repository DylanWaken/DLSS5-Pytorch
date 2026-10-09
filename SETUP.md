# Setup and quickstart

The CUDA deployment extension supports **batch one with FP16 on SM80+**
(including RTX 30 series / SM86) and **FP8 on SM89+** (RTX 40 series and newer).
FP32/BF16 training uses a separate ordinary PyTorch model.
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
$env:TORCH_CUDA_ARCH_LIST = "8.0;8.6;8.9;12.0"
$env:DLSSNR_BUILD_MODE = "split"
$env:DLSSNR_PTXAS_PATH = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v13.4\bin\ptxas.exe"
python setup.py build_ext --inplace
python -B run_tests.py cpu --optimized
```

`DLSSNR_PTXAS_PATH` is optional: omit that assignment to use CUDA 12.8's default
assembler. The published SM120 speed measurements use the newer assembler.
The CPU checks do not load the CUDA extension; inspect skipped
compiler-dependent checks separately.

### Architecture-specific binaries

Set `TORCH_CUDA_ARCH_LIST` to the targets needed for your deployment. With the
default `DLSSNR_BUILD_MODE=split`, the example builds four independent libraries:

| Target | Library stem | Deployment precisions |
|---|---|---|
| `8.0` · Ampere | `_C_sm80` | FP16 |
| `8.6` · RTX 30 series | `_C_sm86` | FP16 |
| `8.9` · RTX 40 series | `_C_sm89` | FP16 and FP8 |
| `12.0` · RTX 50 series / workstation Blackwell | `_C_sm120` | FP16 and FP8 |

The platform and Python ABI add the `.pyd` or `.so` suffix. Object directories
are also separate, so changing architectures cannot reuse the wrong objects.
For one GPU, specify just its target; if unset, the build uses visible devices.
A build server without a GPU must set the list explicitly. Other numeric targets
(for example `9.0`) work when the selected CUDA compiler supports them.

The loader selects the library using the input tensor's device. It prefers the
matching split library, then a compatible earlier minor target within the same
major architecture, then `_C`. It does not select an Ampere FP16-only library
for Ada FP8. `+PTX`, such as `8.9+PTX`, also embeds virtual code for forward JIT;
select an older library explicitly when testing that path.

When constructing a frontend configuration before allocating its tensors, pass
`frontend_configuration(..., device="cuda:1")` to select the intended GPU's
library. Omitting `device` uses the current CUDA device.

For a process using GPUs from different architectures, build with
`DLSSNR_BUILD_MODE=fat`: this emits one `_C` library containing all requested
CUDA images. If split libraries are also installed, explicitly load that fat
library before preparing plans. CUDA then chooses the image per device; do not
load two registration libraries into the same process.

```python
from dlssnr.deployment import load_extension

ops = load_extension()  # Or pass a specific .pyd/.so path.
print(ops.deployment_build_architectures())  # Compiled targets, not performance qualification.
```

Per-device tuning files are merged from `tuning/sm_*.json`. Runtime selection
uses the actual device SM: SM120 measurements are not presented as Ampere or
Ada measurements. An untuned architecture uses the default kernel configuration
with actual occupancy checks and the existing ordered split-launch fallback.

### What changed for older architectures

The audit found SM120-only body guards and host checks, plus instructions that
need newer hardware. The device code now preserves the same tensor packing and
MMA flow while selecting these instruction paths at compile time:

| Operation | SM80 / SM86 / SM89 path | SM90+ path |
|---|---|---|
| Elect a copy producer | Converged ballot and first participating lane | `elect.sync` |
| Global-to-shared bulk copy | 16-byte `cp.async` operations attached to the same mbarrier | `cp.async.bulk` |
| Copy completion | Arrival tracking and `mbarrier.test_wait` | Transaction-byte tracking and `mbarrier.try_wait` |
| Four Half2 atomic reductions | Four scalar Half2 reductions | Vector Half2 reduction |
| FP16 tensor product | Native Half `mma.sync` | Same |
| FP8 tensor product/conversion | Native E4M3 instructions on SM89; rejected below SM89 | Native E4M3 instructions |

Host preparation verifies both the loaded binary and virtual target, block and
shared-memory limits, and active blocks per SM. This also prevents an SM80 FP8
trap entry from being admitted after JIT on a newer GPU. The instruction target
requirements follow NVIDIA's [PTX ISA documentation](https://docs.nvidia.com/cuda/parallel-thread-execution/).

Compilation and SASS inspection cover Ampere/Ada targets, but physical RTX 30/40
hardware was unavailable. Runtime checks on the available RTX PRO 6000 test the
native SM120 path and the lower-target PTX paths JIT-compiled on SM120. Those
checks do not establish performance or full hardware qualification on Ampere/Ada;
the README speed charts remain SM120 measurements.

The portability validation matched the DLL's retained trunk boundaries byte for
byte at 720p and 4K, including forced split launches, poisoned CUDA graph
replays and changed inputs. A 1300 × 732 FP16 case checked runtime geometry.
The input/output kernels also matched their DLL fixtures through the lower-target
paths. Eager and `aot_eager` composition passed; default Inductor was unavailable
in this validation environment because Triton was missing.

To reproduce the copy/barrier test without DLL assets, compile the small test
module with your CUDA compiler and then run it explicitly:

```powershell
nvcc --ptx -std=c++17 -arch=compute_80 tests/cuda/portable_intrinsics.cu -o portable_intrinsics.ptx
python -B tests/test_portable_intrinsics.py --ptx portable_intrinsics.ptx --report portable_intrinsics.json
```

Use a compiler whose emitted PTX version the installed driver supports. The
recorded test used CUDA 12.8 PTX 8.7 on the SM120 device. The test reports both
the virtual target and physical GPU and checks repeated copy phases, Half2
reductions, buffer guards and immutable inputs.

The extension registers Torch operations rather than a Python module. Public
deployment calls load it automatically; for an explicit binary, use
`dlssnr.deployment.load_extension(path)`. Do not import `_C` or `_C_smXX`, and use a new
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
default Inductor needs compatible Triton. The earlier SM120 validation used
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
