# Reconstructed deployment API migration

FP8 and FP16 support four exact prepared-feature fields on SM120: **1280 × 720, 1920 × 1080, 2560 × 1440 and 3840 × 2160**, batch one. Original/candidate comparisons pass all 74 published boundaries at each size in both precisions and meet the accepted no-more-than-1% slowdown criterion in both execution orders. The final 4K pooled gap is 0.689%; the older 0.324% result remains a separate historical trial. See [current status](RECONSTRUCTION_STATUS.md) for timings, evidence and installation state.

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

`load_extension` loads a Torch registration library, not an importable Python extension module. A process may load only one selected DLSSNR extension path; compare builds in fresh processes. Original cubins are confined to the reference tools. The reconstructed candidate launches CUDA/C++ bodies with no original-cubin or legacy-compute fallback.

## Capture, output ownership and oracle

Runs use the current PyTorch CUDA stream and overwrite plan-owned intermediate/output buffers. Returned tensors and boundary tensors alias that storage; clone an output if it must survive a later run. Keep the plan, input and records alive until every captured graph using them is reset. Order access to a plan: a host mutex does not make concurrent asynchronous use of shared buffers independent.

The four-size evidence compares **all published physical bytes**, including global token padding. Auxiliary downsample allocation tails remain guarded but are not published network outputs; they are not part of output equality. The historical FP8 suite validates same-input replay, input/record immutability, guards and counters. The new FP16 suite additionally checks changed-input captured replay; 720p has zero-error full-trunk memcheck coverage. FP16 unused global token padding can remain poisoned and is excluded from logical finiteness checks. Exhaustive exceptional inputs and full-resolution sanitizer coverage remain unclaimed.

The older 48 FP8/FP16 kernel cases are separate guarded fixtures; the new full FP16 trunk measurement is documented independently. Their execution-order caveat matters: 36 cases reverse speed ranking; three FP8 and eight FP16 cases are slower in both orders. Pooled kernel timings are not universal ≤1% qualification. See [both-order kernel results](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/RESULTS.md).

## Training migration

Training remains pure PyTorch: `DLSSNR(archive, precision="fp32" | "bf16", trainable=..., checkpoint_blocks=...)`. `Geometry` and decoded `WeightArchive` remain available. Keep trainable masters FP32. Opt-in `checkpoint_blocks=True` uses non-reentrant stage checkpointing only with autograd enabled; default eager behavior remains `False`. A bounded full-model comparison verifies bit-exact head, 77 boundaries and 639 used gradients in both precisions, and all eight checkpointed four-resolution benchmark cases pass. See [training usage and memory tradeoffs](training.md).

The model is minimally trainable. **DLSS5 transfer-learning methodology, actual losses and training procedures require further investigation.** Removed legacy extension callbacks, per-block deployment selectors, `PreparedInference` and FP8/FP16 training-reference modes have no silent compatibility fallback. Historical private `_inference_*` operators are not the clean public package API.

## Source and policy conventions

Body files and family APIs end in `_fp8` or `_fp16`, for example `window_block_c128_fp8.cuh` and `global_attention_chained_c1024_fp16.cuh`. ABI headers remain separate. Shared force-inlined intrinsics and MMA/integer/packed-memory helpers preserve each family's layout, synchronization and precision-specific reduction dimension. The census is 40 precision pairs plus clear, not 81 algorithms. See [code readability](CODE_READABILITY.md) and the [project workflow skill](../skills/dlssnr-reconstruction/SKILL.md).

Policy JSON/CLI precision tokens are `fp8` and `fp16`; new `half` inputs are rejected. Frozen historical receipts retain their original vocabulary. The per-device `sm_120.json` has no measured anchors. Unmeasured selection returns `config_id=-1`. Matching-family measured extrema and deterministic nearest-anchor selection apply only to query metadata and preserve actual dimensions; they never grant execution support. Four tested C++ baseline shapes are not continuous 720p–4K tuning coverage.

The [final build](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/build-run-v1/build.json) compiles ten CUDA and two host translation units from source. Its [saved ELF comparison](../outputs/all-reconstructed-deployment-prep/readability-ue-v2/compiled-comparison/summary.json) matches the previous readability build for all 81 text/control payloads, raw resource metadata, constants and relocations. This is reconstructed-build equality, not native code equivalence. Fresh four-size runtime checks and the [48-kernel suite](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/run-ue-v2/receipt.json) supply their own numerical evidence. Full FP16 prepared-feature integration is now complete; other architectures, renderer integration and the 85% elapsed-utilization objective remain open. Historical failures and logs are preserved.
