"""Export original-precision FP8 and losslessly promoted FP16 PyTorch checkpoints."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--assets", type=Path, default=ROOT / "assets/nr")
    parser.add_argument("--out-dir", type=Path, default=ROOT / "ckpts")
    parser.add_argument("--precision", nargs="+", choices=("fp8", "fp16"), default=["fp8", "fp16"])
    args = parser.parse_args()
    if len(set(args.precision)) != len(args.precision):
        parser.error("Choose each precision once")
    for precision in args.precision:
        for suffix in (".pt", ".json"):
            if (args.out_dir / ("dlss5_nr_" + precision + suffix)).exists():
                parser.error("Output already exists; choose a fresh directory")

    import numpy as np
    import torch
    from dlssnr.checkpoint import Checkpoint, FP8, NativeWeightArchive, file_sha256, native_state_dict, promote_tensor
    from dlssnr import DLSSNR

    torch.set_num_threads(min(8, torch.get_num_threads()))
    print("Verifying source stages and unpacking native bits on CPU...", flush=True)
    archive = NativeWeightArchive(args.assets)
    native = native_state_dict(archive)
    records = {name: torch.from_numpy(np.frombuffer(record.data, dtype=np.uint8).copy())
               for name, record in archive.records.items()}
    reference = DLSSNR.from_directory(args.assets, precision="fp32", trainable=True).state_dict()
    if set(reference) != set(native):
        raise ValueError("Original model tensor roster differs")
    for name, value in native.items():
        promoted = promote_tensor(value, torch.float32)
        if not torch.equal(promoted.view(torch.uint8), reference[name].view(torch.uint8)):
            raise ValueError("Native unpacking differs from original model loader: " + name)
    del reference
    metadata = {
        "architecture": "DLSSNR; 71 numbered records; blocks 0-70",
        "state_layout": "PyTorch state_dict; linear matrices use [out_features, in_features]",
        "source_runtime": "nvngx_dlssnr 310.8.0",
        "source": archive.manifest["source"],
        "origin": "Original mixed E4M3/Half/Float deployment values; FP16 export only promotes E4M3",
        "extracted_manifest_sha256": file_sha256(args.assets / "manifest.json"),
        "native_record_sha256": {name: hashlib.sha256(value.numpy().tobytes()).hexdigest() for name, value in records.items()},
        "implementation_sha256": {name: file_sha256(ROOT / name) for name in
                                  ("dlssnr/model.py", "dlssnr/geometry.py", "dlssnr/weights.py", "dlssnr/checkpoint.py")},
    }
    args.out_dir.mkdir(parents=True, exist_ok=True)
    for precision in args.precision:
        state = {name: promote_tensor(value, torch.float16) if precision == "fp16" and value.dtype == FP8 else value
                 for name, value in native.items()}
        payload = {"format_version": 2, "weight_precision": precision, "model_class": "dlssnr.DLSSNR",
                   "state_dict": state, "native_records": records if precision == "fp8" else {}, "metadata": metadata}
        Checkpoint(payload)
        path = args.out_dir / ("dlss5_nr_" + precision + ".pt")
        print("Saving and verifying " + path.name, flush=True)
        torch.save(payload, path)
        loaded = torch.load(path, map_location="cpu", weights_only=True)
        for section in ("state_dict", "native_records"):
            if set(loaded[section]) != set(payload[section]):
                raise ValueError("Round-trip tensor roster mismatch")
            for name, expected in payload[section].items():
                actual = loaded[section][name]
                if (actual.dtype != expected.dtype or actual.shape != expected.shape or
                        not torch.equal(actual.view(torch.uint8), expected.view(torch.uint8))):
                    raise ValueError("Round-trip byte mismatch: " + name)
        model = Checkpoint(loaded).training_model()
        for name, actual in model.state_dict().items():
            expected = promote_tensor(native[name], torch.float32)
            if not torch.equal(actual.view(torch.uint8), expected.view(torch.uint8)):
                raise ValueError("Training model differs: " + name)
        result = {
            "file": path.name, "sha256": file_sha256(path), "bytes": path.stat().st_size,
            "format_version": 2, "weight_precision": precision, "tensor_count": len(state),
            "parameter_elements": sum(value.numel() for value in state.values()),
            "tensor_payload_bytes": sum(value.numel() * value.element_size() for value in state.values()),
            "tensor_dtypes": dict(Counter(str(value.dtype) for value in state.values())),
            "native_record_count": len(payload["native_records"]),
            "verification": "Original decoder parity; safe round-trip exact bytes; standalone FP32 model parity",
            "metadata": metadata,
        }
        path.with_suffix(".json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
        print(json.dumps({key: value for key, value in result.items() if key != "metadata"}, indent=2), flush=True)
        del model, loaded, payload, state


if __name__ == "__main__":
    main()
