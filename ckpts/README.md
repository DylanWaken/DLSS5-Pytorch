# PyTorch checkpoints

Both files contain all 640 tensors of the recovered DLSS-NR network and are tracked with **Git LFS**. Run `git lfs pull` after cloning.

| File | Stored weights | Deployment records |
|---|---|---|
| `dlss5_nr_fp8.pt` | Original mixed FP8 matrices, FP16 ancillary tensors and FP32 scales | Includes the original 153 packed records for FP8 deployment |
| `dlss5_nr_fp16.pt` | FP8 matrices widened exactly to FP16; original FP16 tensors and FP32 scales preserved | FP16 kernel records are packed on demand |

The DLL contains one mixed-precision weight resource, not a separate higher-precision trained checkpoint. The FP16 file preserves exactly the same learned values. It does not recover precision absent from the source.

## Training

No extracted asset directory or CUDA extension is needed to construct the training model:

```python
from dlssnr import load_checkpoint

checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")  # Either file works.
model = checkpoint.training_model(
    device="cuda", precision="bf16", checkpoint_blocks=True,
)
```

The model keeps FP32 master parameters; `precision` explicitly selects FP32 or BF16 computation. See the [training guide](../docs/SETUP.md#training) for feature inputs and backward calls. Actual DLSS5 transfer-learning methodology, losses and training procedures remain TBD.

## Deployment

```python
checkpoint = load_checkpoint("ckpts/dlss5_nr_fp8.pt")
plan = checkpoint.create_plan_fp8(prepared_state, width=1280, height=720)
output = plan.run_fp8()
```

Use the packed feature contract in the [deployment guide](../docs/SETUP.md#deployment). Preparation and weight uploads happen outside CUDA graph capture. The full FP16 prepared-feature trunk is available through either checkpoint:

```python
checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
plan = checkpoint.create_plan_fp16(prepared_half_state, width=1280, height=720)
output = plan.run_fp16()
```

FP16 packs all 142 trunk records on demand, including transitions, C512 and global attention. The native FP8 file can also widen into this FP16 route.

Loading allows only equal precision or lossless widening. FP16-to-FP8, FP32-to-FP16 and FP16-to-BF16 weight conversion require explicit quantization and are rejected. FP16 checkpoints never silently fall back to the original FP8 records. FP32 scales remain FP32 in both files.

## Reproducibility

Adjacent JSON manifests pin file hashes, source DLL/resource hashes, tensor counts and export implementation hashes. Loading uses `torch.load(..., weights_only=True)` and validates the schema and file SHA-256. Exports compare every decoded FP32 value against the independent training loader, reload every saved tensor byte, and construct the standalone training model.

To reproduce into a new directory from the extracted archive:

```powershell
python -B tools/export_checkpoint.py --assets assets/nr --out-dir ckpts/reexport --precision fp8 fp16
```

See [NOTICE](../NOTICE) for attribution and the adjacent checkpoint manifests for source hashes.
