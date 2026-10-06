# Reconstructed deployment API migration

FP8 and FP16 admit four exact prepared-feature fields on SM120: **1280 × 720, 1920 × 1080, 2560 × 1440 and 3840 × 2160**, batch one. The preceding per-entry build passed all 74 published boundaries and the within-1% native-speed gate at each size. Current template integration preserves the public API but requires its own [validation receipt](template_integration_validation.json); historical measurements retain their original binary identity. See [current status](RECONSTRUCTION_STATUS.md) for evidence and installation state.

## Explicit precision names

| Earlier consolidated API | Current API |
|---|---|
| `dlssnr.create_plan(state, records)` | `dlssnr.create_plan_fp8(state, records, width=..., height=...)` |
| `dlssnr.inference_forward(plan)` | `dlssnr.inference_forward_fp8(plan)` |
| `torch.ops.dlssnr.create_plan` | `create_plan_fp8` for fixed 4K; `create_plan_for_resolution_fp8` for explicit dimensions |
| `torch.classes.dlssnr.DeploymentPlan` | `torch.classes.dlssnr.DeploymentPlan_fp8` |
| `plan.run()` | `plan.run_fp8()` |
| `torch.ops.dlssnr.record_names()` / `record_bytes()` | `record_names_fp8()` / `record_bytes_fp8()` |

The old unsuffixed aliases are not provided. Python `create_plan_fp8` defaults to 3840 × 2160 and calls `create_plan_for_resolution_fp8`. FP16 has matching `create_plan_fp16`, `inference_forward_fp16`, `DeploymentPlan_fp16`, `run_fp16`, `record_names_fp16` and `record_bytes_fp16` entry points. See the [Half layout and profiling report](FP16_DEPLOYMENT.md). Low-level family calls use `prepare_window_fp8` / `prepare_window_fp16`, `window_out_fp8` / `window_out_fp16`, and corresponding `prepare_c512`, `c512_out` and `c512_block_out` suffix pairs. Entry IDs, physical tensor roles, mutable outputs and admitted geometries are family-specific; an FP16 suffix does not admit every shape or fuse a full model.

The plan methods remain `boundaries()`, `boundary_names()`, `buffer(name)`, `buffer_names()`, `resources()`, `guards_intact()` and `poison(byte)`. Prepare the plan and perform guard inspection/poisoning outside capture. `compiled_policy_version()` and `resolution_selection(...)` expose policy metadata, not Python inference dispatch. Unreal-style internal C++ renaming does not rename these Python/Torch operations.

## Load and prepare physical inputs

The portable checkpoints avoid an extracted asset dependency in deployment:

```python
from dlssnr import load_checkpoint
checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
plan = checkpoint.create_plan_fp16(prepared_half_state, width=1920, height=1080)
result = plan.run_fp16()
```

FP8 uses the corresponding checkpoint and `_fp8` method. Either file can prepare FP16; FP16-to-FP8 is rejected without explicit quantization. The Half input is raw bytes in its own plane16 layout, not FP8 storage reinterpreted as Half. Weight packing is outside capture.

For callers already owning packed records:

```python
from dlssnr.deployment import load_extension
from dlssnr import create_plan_fp8, inference_forward_fp8

ops = load_extension()  # Or an explicit, verified extension path.
names = list(ops.record_names_fp8())
sizes = list(ops.record_bytes_fp8())

# state: contiguous CUDA uint8 bytes in the admitted FP8 physical layout.
# records: contiguous CUDA uint8 buffers in exactly this names/sizes order.
plan = create_plan_fp8(state, records, width=1920, height=1080)
result = inference_forward_fp8(plan)
```

The caller supplies packed features and 142 physical records, not a BHWC image or decoded training parameters. Each precision and geometry uses a 185-launch schedule—152 compute/repack calls and 33 clears—with geometry-specific parameters and buffer extents. The entry checks byte extents, alignment, disjoint input/record storage, device and resident-capacity constraints. Unsupported dimensions or hardware are rejected; policy clamping does not create admission. Renderer preparation, pre0/frontend, post70/output helpers and DLL host work are outside this trunk.

## Individual kernels and `torch.compile`

Every one of the 81 logical kernels has a named Torch operator, for example
`torch.ops.dlssnr.window_block_c32_fp8`. They share this explicit contract:

```text
kernel(Tensor[] inputs, Tensor(a!)[] outputs, int handle) -> ()
```

The immutable handle supplies geometry, scalar ABI fields and the launch configuration.
Every tensor read and write is supplied to the operation. Mutable output lists include
read-modify-write scratch buffers and completion counters; input lists contain immutable
features, residuals, records and predecessor counters. C++ validates extents, device,
alignment, disjoint storage and the matching kernel name before launching. It rebinds
device pointers on every call, so compiler functionalization can provide new storage.
Released handles raise an error rather than referring to destroyed resources.

For the existing C++ trunk plan:

```python
import torch
from dlssnr import prepare_kernels

sequence = prepare_kernels(plan)       # Outside CUDA graph capture.
result = sequence(*sequence.tensors)  # 185 individually visible Torch operations.
compiled = torch.compile(sequence, fullgraph=True)  # Default Inductor backend.
result = compiled(*sequence.tensors)

kernel = sequence.kernels[0]
kernel(kernel.inputs, kernel.outputs)  # One operation, with explicit dependencies.
# New allocations are also accepted when all prepared physical contracts match.
```

The sequence and its argument-index lists come from the generated C++ schedule; Python
does not select kernels. Its 73 distinct exports cover both trunk precisions and counter
clear. `prepare_output_view_fp8` / `prepare_output_view_fp16` expose the two C32 output-view
exports outside that trunk, accepting state, record, output and explicit `height`, `width`,
and `phase` keyword arguments.

Prefer compiling the complete prepared sequence once and reusing it. Each descriptor fixes
its geometry and scalar configuration; replacement tensors must keep the same physical
extents. Symbolic tracing installs guards for those exact dimensions. Preparing a different
resolution requires another plan and sequence, rather than changing tensor sizes behind an
existing handle.

Global split reductions and chained attention also require their producer/counter protocol.
The generated sequence includes each necessary `completion_counter_clear` call. When
assembling a different sequence, preserve those dependencies and initialize counters with
the corresponding clear operation before their producers; a consumer is not an independent
matrix multiply merely because it has an individual Torch entry point.

CUDA and Meta implementations are registered for all 81 named operations. The following compiler results describe the preceding per-entry build pinned by `global_entry_validation.json`; integrated-template checks are recorded separately in `template_integration_validation.json`. On Windows,
PyTorch **2.8.0+cu128** with **triton-windows 3.4.0.post21** passes actual default-Inductor
GPU tests for the complete **720p FP8 and FP16 trunks**: byte-exact outputs and all published
boundaries against the integrated C++ route, changed-input execution, storage replacement,
guard checks, invalid-call rejection, and changed-input replay of the compiled CUDA graph.
Both C32 output-view exports also match the independent DLL fixture under default Inductor.
The FP8 and FP16 receipts are embedded under `default_inductor` in the committed
[validation report](global_entry_validation.json).

All six frontend exports pass default Inductor and `aot_eager` compilation. Their separate
32 × 40 suite also passes 18 independent native fixtures, storage replacement and live-input
CUDA graph replay. Compiler checks cover one fixture per export; the other fixtures exercise
history, motion, depth, conditioning and filtering behavior.
The frontend receipt is embedded under `default_inductor` in the same
[validation report](global_entry_validation.json). Its `preserved_failures` section retains
the earlier attempt that reached Dynamo's eight-compilation limit while reusing one test
closure across independent fixtures. The harness now resets compiler state between fixtures;
production calls retain their compiled sequence and fixed geometry.

These are compiler correctness and capture results, **not default-Inductor speed claims**.
The DLL timing gate remains a separate measurement of the integrated deployment path. AOT
functionalization may copy mutable workspaces. `plan.run_fp8()` / `plan.run_fp16()` remains
the direct C++ trunk route with prepacked calls. CPU contract tests additionally exercise
named graph nodes, tensor dependencies, mutation, symbolic shape guards and storage replacement.

### Optional Windows compiler dependency

The integrated C++ route does not require Triton. For default GPU `torch.compile` with this
project's tested Torch 2.8 environment, pin `triton-windows==3.4.0.post21`. The maintainer's
[compatibility table](https://github.com/triton-lang/triton-windows/blob/readme/README.md#3-pytorch)
pairs Torch 2.8 with Triton 3.4 and supports SM120 with CUDA 12.8 or newer. The
[pinned wheel](https://pypi.org/project/triton-windows/3.4.0.post21/) supports Python 3.9–3.13,
requires `setuptools>=40.8.0`, and bundles the CUDA toolchain and TinyCC. The Windows VC++
runtime and matching Python development headers/import libraries must also be available.

An isolated installation, matching the validation setup, is:

```powershell
.venv\Scripts\python.exe -m pip install --no-deps --only-binary=:all: --target outputs/semantic-rewrite/triton-3.4.0.post21/site triton-windows==3.4.0.post21
```

Check the setuptools requirement before using `--no-deps`. For the test child process only,
prepend that absolute `site` directory to `PYTHONPATH`; set `TRITON_CACHE_DIR` and
`TORCHINDUCTOR_CACHE_DIR` to separate scratch cache directories. Do not change the parent
process environment when applying those overrides. Our qualification used exactly this
isolated installation: the wheel hash was verified against PyPI, the existing package
inventory remained unchanged, and Triton remained absent from the normal environment.
The installation receipt, including child environment settings, is embedded under
`default_inductor` in the committed [validation report](global_entry_validation.json).
Without this optional dependency, explicit `backend="eager"` or `backend="aot_eager"`
remains available; the library does not silently replace the requested compiler backend.

## Renderer resources and C++ composition

The remaining six exports are preprocessing (with and without downsampling) and output
postprocessing, in both precisions. Their prepared descriptors own CUDA arrays, texture
objects and surfaces. Public tensor arguments remain explicit: a call copies texture
inputs into its arrays, launches the reconstructed kernel, and copies surface outputs
back into output tensors. These copies are part of this adapter's cost.

Use `frontend_configuration(name, height=..., width=..., ...)` to create a typed C++
configuration with identity sampling and zero pointer fields, then `prepare_frontend`:

```python
from dlssnr import frontend_configuration, prepare_frontend, compose_kernels

name = "input_preprocess_window_c32_fp16"
configuration = frontend_configuration(name, height=height, width=width)
record = checkpoint.kernel_record(0, kind="preprocess", precision="fp16", device="cuda")
frontend = prepare_frontend(
    name, configuration,
    [record, current, history, motion, depth, conditioning], [prepared_features],
)

# Adjacent stages must bind the same tensor objects, with matching physical layouts.
pipeline = compose_kernels([frontend, *sequence.kernels, postprocess])
result = pipeline.run_cpp()             # Entire supplied chain launches in C++.
compiled_pipeline = torch.compile(pipeline, fullgraph=True)
result = compiled_pipeline(*pipeline.tensors)
```

`postprocess` above is a separately prepared `output_window_postprocess_c32_fp16` operation.
Its record is `checkpoint.kernel_record(70, kind="postprocess", precision="fp16", device="cuda")`.
The caller must provide the renderer's actual motion/history/adapter data and connect the
appropriate physical buffers. Composition validates contracts and launches the supplied
order; it does not infer renderer history semantics or construct a complete DLSS host
pipeline automatically.

| Family | Input tensor order | Mutable outputs |
|---|---|---|
| Preprocess | record, current, history, motion, depth, conditioning | features |
| Preprocess + downsample | same | features, pooled features |
| Postprocess | low state, adapter, record, color, history, motion, blend scale | RGBA |

Textures are contiguous CUDA float32 HWC4 tensors. Physical features and records are
contiguous one-dimensional CUDA uint8 storage. Optional textures use empty float32 tensors;
optional blend scale uses empty uint8 storage or exactly two Half payload bytes. Prepared
dimensions and scalar configuration stay fixed. Preparation and composition happen outside
capture. Keep owners alive until all GPU work finishes and every captured graph is reset;
order invocations on the caller's CUDA stream. A compiled function still requires its
prepared sequence or kernel owner to remain alive.

`sequence.run_cpp()` also launches the 185 prepared trunk descriptors entirely in C++.
It uses the originally bound tensors; `sequence(*tensors)` is the explicit-argument route.
For arbitrary renderer/trunk composition, `torch.ops.dlssnr.create_kernel_sequence(owners)`
owns the supplied descriptors and validates the complete bound chain before its first
launch. This general route and the texture adapter are separately measured APIs, not
evidence that the full DLL renderer has matched the trunk's historical timing gate.

`load_extension` loads a Torch registration library, not an importable Python extension module. A process may load only one selected DLSSNR extension path; compare builds in fresh processes. Original cubins are confined to the reference tools. The reconstructed candidate launches CUDA/C++ bodies with no original-cubin or legacy-compute fallback.

## Capture, output ownership and oracle

Runs use the current PyTorch CUDA stream and overwrite plan-owned intermediate/output buffers. Returned tensors and boundary tensors alias that storage; clone an output if it must survive a later run. Keep the plan, input and records alive until every captured graph using them is reset. Order access to a plan: a host mutex does not make concurrent asynchronous use of shared buffers independent.

The four-size evidence compares **all published physical bytes**, including global token padding. Auxiliary downsample allocation tails remain guarded but are not published network outputs; they are not part of output equality. The historical FP8 suite validates same-input replay, input/record immutability, guards and counters. The new FP16 suite additionally checks changed-input captured replay; 720p has zero-error full-trunk memcheck coverage. FP16 unused global token padding can remain poisoned and is excluded from logical finiteness checks. Exhaustive exceptional inputs and full-resolution sanitizer coverage remain unclaimed.

The older 48 FP8/FP16 kernel cases are separate guarded fixtures; the new full FP16 trunk measurement is documented independently. Their execution-order caveat matters: 36 cases reverse speed ranking; three FP8 and eight FP16 cases are slower in both orders. Pooled kernel timings are not universal ≤1% qualification. See [both-order kernel results](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/RESULTS.md).

## Training migration

Training remains pure PyTorch: `DLSSNR(archive, precision="fp32" | "bf16", trainable=..., checkpoint_blocks=...)`. `Geometry` and decoded `WeightArchive` remain available. Keep trainable masters FP32. Opt-in `checkpoint_blocks=True` uses non-reentrant stage checkpointing only with autograd enabled; default eager behavior remains `False`. A bounded full-model comparison verifies bit-exact head, 77 boundaries and 639 used gradients in both precisions, and all eight checkpointed four-resolution benchmark cases pass. See [training usage and memory tradeoffs](training.md).

The model is minimally trainable. **DLSS5 transfer-learning methodology, actual losses and training procedures require further investigation.** Removed legacy extension callbacks, per-block deployment selectors, `PreparedInference` and FP8/FP16 training-reference modes have no silent compatibility fallback. Historical private `_inference_*` operators are not the clean public package API.

## Source and policy conventions

Current source has 81 stable logical names represented by 56 full-body CUDA files:
40 configurations share 15 global templates, and 41 retain direct definitions.
Each global shows its storage, loops, pipeline and writes. The manifest
`kernel_impl/common/kernel_templates.json` maps template configurations to source
and compile-time arguments; `kernel_abi.h` owns records, checked aliases and
resolver declarations. Same-TU host resolvers return specialization addresses;
launch dispatch and generated schedules remain in `kernel_launcher`.

Templated CUDA symbols have C++ mangled names; public Torch names do not change.
An additive diagnostic operation returns the registered symbol of the loaded build:

```python
ops = load_extension()
symbol = ops.kernel_symbol("window_block_c128_fp8")
```

C++ callers use `KernelSymbol(Name)` from `kernel_symbols.h`. Driver fixtures
should use this lookup rather than assume a logical name equals a CUDA symbol.
This query performs no kernel launch and is separate from normal preparation.
Project source stays namespace-free; external library qualifications and the
Torch `dlssnr` domain remain unchanged. See [source organization](SOURCE_LAYOUT.md),
[readability](CODE_READABILITY.md) and the
[workflow skill](../skills/dlssnr-reconstruction/SKILL.md).

Policy JSON/CLI precision tokens are `fp8` and `fp16`; new `half` inputs are rejected. Frozen historical receipts retain their original vocabulary. The per-device `sm_120.json` has no measured anchors. Unmeasured selection returns `config_id=-1`. Matching-family measured extrema and deterministic nearest-anchor selection apply only to query metadata and preserve actual dimensions; they never grant execution support. Four tested C++ baseline shapes are not continuous 720p–4K tuning coverage.

The historical [readability build](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/build-run-v1/build.json)
compiled ten CUDA and two host translation units. Its [saved ELF comparison](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/compiled-comparison/summary.json)
matched that release's predecessor for all 81 text/control payloads, raw resource metadata,
constants and relocations. Those receipts remain unchanged and do not certify the newer
individual translation units or Torch composition APIs. The [48-kernel suite](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/run-ue-v2/receipt.json)
likewise retains its original scope. Current qualification is tracked in [status](RECONSTRUCTION_STATUS.md).
Other architectures, full renderer integration and the 85% elapsed-utilization objective
remain open; historical failures and logs are preserved.
