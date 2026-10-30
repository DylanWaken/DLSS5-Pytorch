# PyTorch checkpoints

The Legacy71 files contain all 640 tensors of the recovered DLSS-NR network. The Small31 file is a record-centric bundle of the 77 original Small31 records. All `.pt` files are tracked with **Git LFS** (`ckpts/*.pt`). Run `git lfs pull` after cloning.

| File | Stored weights | Deployment records |
|---|---|---|
| `dlss5_nr_fp8.pt` | Original mixed FP8 matrices, FP16 ancillary tensors and FP32 scales | Includes the original 153 packed records for FP8 deployment |
| `dlss5_nr_fp16.pt` | FP8 matrices widened exactly to FP16; original FP16 tensors and FP32 scales preserved | FP16 kernel records are packed on demand |
| `dlss5_nr_small31.pt` | 77 original Small31 raw records, ~114 MB of mixed FP8-family storage | Original packed FP8 records; FP16 native records are widened losslessly on demand |

The DLL contains one mixed-precision weight resource per model, not a separate higher-precision trained checkpoint. The Legacy71 FP16 file preserves exactly the same learned values; it does not recover precision absent from the source.

## Training

No extracted asset directory or CUDA extension is needed to construct the training model:

```python
from dlssnr import load_checkpoint

checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")  # Either Legacy71 file works.
model = checkpoint.training_model(
    device="cuda", precision="bf16", checkpoint_blocks=True,
)
```

The model keeps FP32 master parameters; `precision` explicitly selects FP32 or BF16 computation. See the [training guide](../docs/SETUP.md#training) for feature inputs and backward calls. Actual DLSS5 transfer-learning methodology, losses and training procedures remain TBD.

## Deployment

The native snippets in this section are **API fragments**, not standalone programs. They continue the complete, executable fixture in the [deployment guide](../docs/SETUP.md#deployment), which defines `prepared_fp8_state` and `prepared_half_state` for its accepted 320×320 geometry. Input fixtures must correspond to the selected model, precision and geometry: regenerate them for a different checkpoint, precision or `width`/`height` instead of reusing this fixture.

```python
checkpoint = load_checkpoint("ckpts/dlss5_nr_fp8.pt")
plan = checkpoint.create_plan_fp8(prepared_fp8_state, width=320, height=320)
output = plan.run_fp8()
```

The full FP16 prepared-feature trunk is available through either Legacy71 checkpoint. This fragment also continues the guide's fixture and geometry:

```python
checkpoint = load_checkpoint("ckpts/dlss5_nr_fp16.pt")
plan = checkpoint.create_plan_fp16(prepared_half_state, width=320, height=320)
output = plan.run_fp16()
```

Preparation and weight uploads happen outside CUDA graph capture. FP16 packs all 142 trunk records on demand, including transitions, C512 and global attention. The native FP8 file can also widen into this FP16 route.

Loading allows only equal precision or lossless widening. FP16-to-FP8, FP32-to-FP16 and FP16-to-BF16 weight conversion require explicit quantization and are rejected. FP16 checkpoints never silently fall back to the original FP8 records. FP32 scales remain FP32 in both files.

## Small31

`ckpts/dlss5_nr_small31.pt` is the direct, static extraction of the signed Small31 resource in the 310.9.16 runtime. It is a separate opt-in model, not a pruning of Legacy71. The file uses `format_version=3`, `model="small31"`, `model_class="dlssnr.SmallDLSSNR"`, `weight_precision="fp8"` and `storage="native_records"`: all 77 original records are retained as uint8 CPU tensors in `native_records`, and `state_dict` stays empty so decoded tensors are not duplicated. This one ~114 MB mixed-layout bundle of the original FP8-family records serves three purposes:

- **FP8 native deployment** from the original packed records.
- **FP16 native deployment** by widening the same learned values losslessly and packing records on demand.
- **FP32/BF16 training initialization** from decoded tensors. The model keeps FP32 masters; `precision` selects execution precision.

Execution precision is separate from the source storage family. Widening the original FP8-family records to FP16 does not recover precision absent from the DLL, and selecting BF16 or FP32 compute does not change the stored record family.

Select the model explicitly; Legacy71 remains the default:

```python
from dlssnr import load_checkpoint

checkpoint = load_checkpoint("ckpts/dlss5_nr_small31.pt", model="small31")
model = checkpoint.training_model(device="cuda", precision="bf16")
```

The native deployment snippet below is another **API fragment**, not a standalone program. It continues the same [deployment fixture](../docs/SETUP.md#deployment) at 320×320, with each prepared state matched to the precision it feeds:

```python
checkpoint = load_checkpoint("ckpts/dlss5_nr_small31.pt", model="small31")
plan = checkpoint.create_plan_fp8(prepared_fp8_state, width=320, height=320)
output = plan.run_fp8()

half_plan = checkpoint.create_plan_fp16(prepared_half_state, width=320, height=320)
half_output = half_plan.run_fp16()
```

`load_checkpoint(path)` and `load_native_model(path)` continue to mean `model="legacy71"`. Selecting a Small31 file under the default model must fail clearly; the model is never inferred from the filename, tensor shapes or archive size.

The `.pt` is self-contained. This artifact is `dlss5_nr_small31.pt`: 113,943,356 bytes, SHA-256 `742c63cae96fb0d6f53f2de6e89e8175606ad51b8939e5e7d255a9167fbef154`. Its optional adjacent [`.json` receipt](dlss5_nr_small31.json) records the extraction command/schema, source DLL/resource/archive-manifest hashes, record counts, special-record roster, and executed verification results. The receipt is provenance, not a load dependency: it is not required to load the `.pt`, but when it is present its checkpoint SHA-256 is verified by default (`verify_hash=True`). The checkpoint SHA-256 in the receipt was independently recomputed from the saved `.pt` and matches.

This artifact contains the original DLL weights. The separate [training and export workflow](../README.md) handles updated training weights and explicit FP16 deployment export. Generic trained FP8 packing is unsupported; updated weights must not silently reuse these original FP8 records.

Extract another copy directly from the existing signed DLL into a fresh output path (`--overwrite` is false by default):

```powershell
.venv/Scripts/python.exe -B tools/extract_model_checkpoint.py --dll profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll --model small31 --output ckpts/reextracted_small31.pt
```

Choose an output whose `.pt` and `.json` do not already exist. The CLI validates the `.pt` suffix and rejects an existing output or receipt before parsing the DLL. It parses the DLL read-only, never loads or executes it, and performs CPU-only verification: all 77 record bytes against the freshly extracted pinned archive, decoded state and special records (pre, post, blend scalar, eight 2-byte ViT layer-3 records), a `torch.load(..., weights_only=True)` roundtrip, and an isolated `.pt`-only load through `load_checkpoint(path, model="small31")` after the temporary extraction directory is gone. The receipt for the published artifact retains its actual original extraction command.

## Reproducibility

Adjacent JSON receipts/manifests record file hashes, source DLL/resource hashes and validation results. Loading uses `torch.load(..., weights_only=True)` and validates the checkpoint schema. Legacy71 requires its adjacent JSON file hash. Small31 validates its embedded identity and record hashes; its optional adjacent JSON sidecar is not required, but when present its checkpoint SHA-256 is verified by default. The Small31 extraction command performs the record, decoded-state and isolated-load checks listed above.

To reproduce the Legacy71 exports into a new directory from the extracted archive:

```powershell
python -B tools/export_checkpoint.py --assets assets/nr --out-dir ckpts/reexport --precision fp8 fp16
```

Small31 is reproduced with the direct DLL command in the [Small31](#small31) section; it does not depend on an extracted asset directory at load time. See [NOTICE](../NOTICE) for attribution and the adjacent checkpoint manifests for source hashes.
