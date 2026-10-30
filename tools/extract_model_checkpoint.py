"""Extract the original Small31 records from a signed DLSS-NR DLL into one .pt.

Usage (from the repository root)::

    .venv/Scripts/python.exe -B tools/extract_model_checkpoint.py --dll profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll --model small31 --output ckpts/dlss5_nr_small31.pt

The DLL is opened read-only and parsed statically; it is never loaded or
executed.  Extraction uses the existing strict pinned CPU ``small31`` archive
extractor in a task-owned temporary directory, then stores all 77 original
packed records in a portable, self-contained format-version-3 checkpoint.  The
``.pt`` retains the original FP8-family record bytes; decoded state is derived
lazily by the checkpoint owner.  An adjacent JSON receipt records provenance
and verification only and is not a load dependency.

``--overwrite`` is false by default: an existing output ``.pt`` or its ``.json``
receipt is rejected before the DLL is parsed.  Legacy71 extraction/export
commands and files are unchanged.
"""
from __future__ import annotations

import argparse
from pathlib import Path
import sys

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--dll",
        type=Path,
        required=True,
        metavar="PATH",
        help="original signed DLSS-NR DLL (read-only, never loaded or executed)",
    )
    parser.add_argument(
        "--model",
        required=True,
        choices=("small31",),
        help="model identity to extract; only small31 is supported by this tool",
    )
    parser.add_argument(
        "--output",
        type=Path,
        required=True,
        metavar="PATH.pt",
        help="new self-contained Small31 checkpoint path; suffix must be .pt",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="atomically replace an existing output .pt and its .json receipt",
    )
    return parser


def _preflight(args: argparse.Namespace) -> tuple[Path, Path, Path]:
    """Cheap checks that run before the pinned archive extraction."""
    dll = args.dll.expanduser()
    if not dll.is_file():
        raise FileNotFoundError(f"DLL does not exist or is not a file: {dll}")

    output = args.output.expanduser()
    if output.suffix.lower() != ".pt" or output.name == ".pt":
        raise ValueError(f"output must name a .pt file, got: {output}")
    if output.exists() and output.is_dir():
        raise IsADirectoryError(f"output is a directory: {output}")
    if not output.parent.is_dir():
        raise FileNotFoundError(f"output parent directory does not exist: {output.parent}")

    sidecar = output.with_suffix(".json")
    if sidecar.exists() and sidecar.is_dir():
        raise IsADirectoryError(f"receipt path is a directory: {sidecar}")

    if not args.overwrite:
        if output.exists() or output.is_symlink():
            raise FileExistsError(
                f"output already exists: {output} (pass --overwrite to replace it)")
        if sidecar.exists() or sidecar.is_symlink():
            raise FileExistsError(
                f"receipt already exists: {sidecar} (pass --overwrite to replace it)")
    return dll, output, sidecar


def _assert_tensor(value, *, dtype, shape, label: str):
    import torch

    if not isinstance(value, torch.Tensor):
        raise TypeError(f"{label} must be a torch.Tensor")
    if value.device.type != "cpu":
        raise ValueError(f"{label} must be on CPU, got device {value.device}")
    if value.dtype != dtype:
        raise ValueError(f"{label} must be {dtype}, got {value.dtype}")
    if tuple(value.shape) != tuple(shape):
        raise ValueError(f"{label} shape {tuple(value.shape)} != expected {tuple(shape)}")
    if not value.is_contiguous():
        raise ValueError(f"{label} must be contiguous")
    return value


def _compare_keyed(actual, expected, label: str) -> None:
    import torch

    if not isinstance(actual, dict):
        raise TypeError(f"{label} must return a dict")
    if not isinstance(expected, dict):
        raise TypeError(f"{label} reference must be a dict")
    if set(actual) != set(expected):
        missing = sorted(set(expected) - set(actual))
        extra = sorted(set(actual) - set(expected))
        raise ValueError(f"{label} keys differ: missing={missing}, extra={extra}")
    for name in sorted(expected):
        left, right = actual[name], expected[name]
        if not isinstance(left, torch.Tensor) or not isinstance(right, torch.Tensor):
            raise TypeError(f"{label}[{name}] must be a torch.Tensor")
        if left.device.type != "cpu":
            raise ValueError(f"{label}[{name}] is not on CPU")
        if left.dtype != right.dtype:
            raise ValueError(f"{label}[{name}] dtype {left.dtype} != {right.dtype}")
        if tuple(left.shape) != tuple(right.shape):
            raise ValueError(
                f"{label}[{name}] shape {tuple(left.shape)} != {tuple(right.shape)}")
        if not torch.equal(left, right):
            raise ValueError(f"{label}[{name}] values differ from the archive decode")


def _blend_value(checkpoint):
    value = getattr(checkpoint, "blend_scale")
    return value() if callable(value) else value


def _verify_payload(payload, archive, spec, *, label: str) -> dict:
    """Verify one payload against the freshly extracted archive and its decoder."""
    import hashlib

    import torch

    from dlssnr.portable_checkpoint import SmallCheckpoint, canonical_small_identity
    from dlssnr.small_deployment import SmallNativeCheckpoint

    if not isinstance(payload, dict):
        raise TypeError(f"{label}: checkpoint payload must be a dict")
    expected = {
        "format_version": 3,
        "model": "small31",
        "model_class": "dlssnr.SmallDLSSNR",
        "weight_precision": "fp8",
        "storage": "native_records",
    }
    for key, value in expected.items():
        if payload.get(key) != value:
            raise ValueError(f"{label}: payload {key}={payload.get(key)!r} != {value!r}")
    if payload.get("state_dict") != {}:
        raise ValueError(f"{label}: original Small31 payload must not duplicate decoded state")
    if payload.get("model_identity") != canonical_small_identity():
        raise ValueError(f"{label}: payload model_identity differs from the canonical Small31 identity")

    metadata = payload.get("metadata")
    if not isinstance(metadata, dict):
        raise TypeError(f"{label}: payload metadata must be a dict")
    if metadata.get("origin") != "dll-extracted":
        raise ValueError(f"{label}: metadata origin is not 'dll-extracted'")
    if metadata.get("source_dll_sha256") != archive.dll_sha256:
        raise ValueError(f"{label}: metadata source DLL hash differs from the archive")
    if metadata.get("archive_manifest_sha256") != archive.manifest_sha256:
        raise ValueError(f"{label}: metadata manifest hash differs from the extracted archive")
    if not isinstance(metadata.get("archive_manifest"), dict):
        raise TypeError(f"{label}: metadata archive_manifest must be a dict")
    record_hashes = metadata.get("native_record_sha256")
    if not isinstance(record_hashes, dict):
        raise TypeError(f"{label}: metadata native_record_sha256 must be a dict")

    native = payload.get("native_records")
    if not isinstance(native, dict):
        raise TypeError(f"{label}: native_records must be a dict")
    roster = {record.name: record for record in spec.records}
    if set(native) != set(roster):
        missing = sorted(set(roster) - set(native))
        extra = sorted(set(native) - set(roster))
        raise ValueError(f"{label}: native_records roster differs: missing={missing}, extra={extra}")
    if len(native) != spec.record_count:
        raise ValueError(
            f"{label}: native_records has {len(native)} records, expected {spec.record_count}")

    total_bytes = 0
    computed_hashes = {}
    for name in sorted(roster):
        record = roster[name]
        value = _assert_tensor(
            native[name], dtype=torch.uint8, shape=(record.byte_length,),
            label=f"{label}: native_records[{name}]")
        data = value.numpy().tobytes()
        expected_bytes = bytes(archive.records[name].data)
        if data != expected_bytes:
            raise ValueError(f"{label}: native record bytes differ from the archive: {name}")
        digest = hashlib.sha256(data).hexdigest()
        if record_hashes.get(name) != digest:
            raise ValueError(f"{label}: metadata native_record_sha256 differs for {name}")
        computed_hashes[name] = digest
        total_bytes += record.byte_length
    if total_bytes != spec.payload_bytes:
        raise ValueError(
            f"{label}: record payload is {total_bytes} bytes, expected {spec.payload_bytes}")

    vit_roles = {role for stage in spec.stages if stage.kind == "vit" for role in stage.roles}
    pre = [record for record in spec.records if record.role == spec.pre_role]
    post = [record for record in spec.records
            if record.role == spec.post_role and record.parameter != "blend_scale"]
    blend = [record for record in spec.records if record.parameter == "blend_scale"]
    vit_layer3 = [record for record in spec.records
                  if record.role in vit_roles and record.layer == 3]
    if len(pre) != 1 or len(post) != 1 or len(blend) != 1:
        raise ValueError(f"{label}: expected one pre, one post and one blend record")
    if len(vit_layer3) != 8:
        raise ValueError(
            f"{label}: expected eight ViT layer-3 records, found {len(vit_layer3)}")
    if any(record.byte_length != 2 for record in vit_layer3):
        raise ValueError(f"{label}: every ViT layer-3 record must be 2 bytes")
    if blend[0].byte_length != 2:
        raise ValueError(f"{label}: the post blend scalar must be a 2-byte record")
    special = {
        "pre": {"name": pre[0].name, "byte_length": pre[0].byte_length},
        "post": {"name": post[0].name, "byte_length": post[0].byte_length},
        "blend_scale": {"name": blend[0].name, "byte_length": blend[0].byte_length},
        "vit_layer3": [
            {"name": record.name, "byte_length": record.byte_length}
            for record in vit_layer3
        ],
    }

    checkpoint = SmallCheckpoint(payload)
    state = checkpoint.state_dict(dtype=torch.float32)
    if not isinstance(state, dict) or not state:
        raise ValueError(f"{label}: checkpoint state_dict is empty")
    reference_state = SmallNativeCheckpoint(archive).state_dict(dtype=torch.float32)
    _compare_keyed(state, reference_state, f"{label}: state_dict")

    roles = set()
    for key, value in state.items():
        parts = key.split(".", 2)
        if len(parts) != 3 or parts[0] != "blocks":
            raise ValueError(f"{label}: unexpected state key {key!r}")
        try:
            roles.add(int(parts[1]))
        except ValueError as exc:
            raise ValueError(f"{label}: unexpected state key {key!r}") from exc
        if not isinstance(value, torch.Tensor):
            raise TypeError(f"{label}: state_dict[{key!r}] is not a tensor")
        if value.device.type != "cpu":
            raise ValueError(f"{label}: state_dict[{key!r}] is not on CPU")
        if value.dtype != torch.float32:
            raise ValueError(f"{label}: state_dict[{key!r}] is not float32")
        if not torch.isfinite(value).all().item():
            raise ValueError(f"{label}: state_dict[{key!r}] contains nonfinite values")
    if roles != set(spec.roles):
        raise ValueError(f"{label}: state_dict roles differ from the Small31 identity")

    decoded_blocks = 0
    decoded_tensors = 0
    for role in spec.roles:
        actual = checkpoint.decode_block(role)
        expected_block = archive.decode_block(role)
        _compare_keyed(actual, expected_block, f"{label}: decode_block({role})")
        if not actual:
            raise ValueError(f"{label}: decode_block({role}) returned no tensors")
        decoded_blocks += 1
        decoded_tensors += len(actual)

    actual_blend = _blend_value(checkpoint)
    expected_blend = SmallNativeCheckpoint(archive).blend_scale()
    if not isinstance(actual_blend, torch.Tensor) or not isinstance(expected_blend, torch.Tensor):
        raise TypeError(f"{label}: blend_scale must be a tensor")
    if actual_blend.dtype != expected_blend.dtype:
        raise ValueError(f"{label}: blend_scale dtype differs")
    if tuple(actual_blend.shape) != tuple(expected_blend.shape):
        raise ValueError(f"{label}: blend_scale shape differs")
    if not torch.equal(actual_blend, expected_blend):
        raise ValueError(f"{label}: blend_scale value differs from the archive")
    if actual_blend.numel() != 1 or not torch.isfinite(actual_blend).all().item():
        raise ValueError(f"{label}: blend_scale is not one finite scalar")

    dtype_counts: dict[str, int] = {}
    for value in state.values():
        key = str(value.dtype)
        dtype_counts[key] = dtype_counts.get(key, 0) + 1
    return {
        "record_count": len(native),
        "record_payload_bytes": total_bytes,
        "decoded_state_tensor_count": len(state),
        "decoded_state_dtypes": dtype_counts,
        "decoded_block_count": decoded_blocks,
        "decoded_block_tensor_count": decoded_tensors,
        "special_records": special,
        "native_record_sha256": computed_hashes,
    }


def _file_sha256(path: Path) -> str:
    import hashlib

    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _receipt_without_hashes(stats: dict) -> dict:
    return {key: value for key, value in stats.items() if key != "native_record_sha256"}


def _write_json_atomic(path: Path, value: dict) -> None:
    import json
    import os

    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    try:
        temporary.write_text(json.dumps(value, indent=2) + "\n", encoding="utf-8")
        os.replace(temporary, path)
    finally:
        temporary.unlink(missing_ok=True)


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        dll, output, sidecar = _preflight(args)

        import json
        import shutil
        import tempfile

        import torch

        from dlssnr.runtime_assets import extract_model
        from dlssnr import load_checkpoint
        from dlssnr.model_specs import SMALL31
        from dlssnr.portable_checkpoint import (
            SmallCheckpoint,
            save_checkpoint_payload,
            small31_checkpoint_payload,
        )
        from dlssnr.small_model import SmallWeightArchive
        command = [
            sys.executable,
            str(Path(__file__).resolve()),
            "--dll", str(dll),
            "--model", args.model,
            "--output", str(output),
        ]
        if args.overwrite:
            command.append("--overwrite")

        with tempfile.TemporaryDirectory(prefix="dlssnr-small31-extract-") as temporary:
            archive_dir = Path(temporary) / "archive"
            extraction = extract_model(dll, "small31", archive_dir)
            archive = SmallWeightArchive(archive_dir, verify_hashes=True)
            if not isinstance(extraction, dict):
                raise TypeError("extract_model did not return a summary dict")
            if extraction.get("manifestSha256") != archive.manifest_sha256:
                raise ValueError("freshly extracted archive manifest hash differs from the extractor summary")

            payload = small31_checkpoint_payload(archive)
            checked = _verify_payload(payload, archive, SMALL31, label="pre-save")

            saved = save_checkpoint_payload(payload, output, overwrite=args.overwrite)
            saved_path = Path(saved["path"]).expanduser()
            saved_sidecar = Path(saved["sidecar"]).expanduser()
            if saved_path.resolve() != output.resolve():
                raise ValueError(
                    f"checkpoint helper wrote {saved_path}, expected {output}")
            if saved_sidecar.resolve() != sidecar.resolve():
                raise ValueError(
                    f"checkpoint helper wrote receipt {saved_sidecar}, expected {sidecar}")
            if not saved_path.is_file() or saved_path.stat().st_size == 0:
                raise FileNotFoundError(f"checkpoint was not written: {saved_path}")
            actual_sha256 = _file_sha256(saved_path)
            if saved.get("sha256") != actual_sha256:
                raise ValueError("checkpoint helper SHA-256 does not match the saved file")
            if saved.get("byte_length") != saved_path.stat().st_size:
                raise ValueError("checkpoint helper byte length does not match the saved file")

            loaded_payload = torch.load(saved_path, map_location="cpu", weights_only=True)
            roundtrip = _verify_payload(loaded_payload, archive, SMALL31, label="roundtrip")
            saved_checkpoint = SmallCheckpoint(loaded_payload)
            saved_state = saved_checkpoint.state_dict(dtype=torch.float32)
            saved_blend = _blend_value(saved_checkpoint)

        if archive_dir.exists():
            raise RuntimeError("task temporary extraction directory was not removed")

        isolated_result = None
        with tempfile.TemporaryDirectory(prefix="dlssnr-small31-isolated-") as isolated:
            isolated_path = Path(isolated) / "isolated_small31.pt"
            shutil.copyfile(saved_path, isolated_path)
            if isolated_path.with_suffix(".json").exists():
                raise RuntimeError("isolated copy unexpectedly has a receipt")
            isolated_files = sorted(path.name for path in Path(isolated).iterdir())
            if isolated_files != [isolated_path.name]:
                raise RuntimeError(f"isolated directory is not .pt-only: {isolated_files}")
            isolated_checkpoint = load_checkpoint(isolated_path, model="small31")
            isolated_state = isolated_checkpoint.state_dict(dtype=torch.float32)
            _compare_keyed(isolated_state, saved_state, "isolated state_dict")
            isolated_blend = _blend_value(isolated_checkpoint)
            if not isinstance(isolated_blend, torch.Tensor) or not torch.equal(
                    isolated_blend, saved_blend):
                raise ValueError("isolated load blend_scale differs from the saved checkpoint")
            isolated_result = {
                "archive_directory_removed": True,
                "sidecar_present": False,
                "load": "load_checkpoint(path, model='small31')",
                "state_dict_equal": True,
                "blend_scale_equal": True,
                "state_tensor_count": len(isolated_state),
            }

        existing_receipt = json.loads(saved_sidecar.read_text(encoding="utf-8"))
        if not isinstance(existing_receipt, dict):
            raise TypeError("checkpoint receipt must be a JSON object")
        for key in ("sha256", "byte_length"):
            if key in existing_receipt and existing_receipt[key] != saved[key]:
                raise ValueError(f"checkpoint receipt {key} differs from the helper result")
            existing_receipt[key] = saved[key]
        for key in ("path", "sidecar", "model", "format_version", "weight_precision", "storage"):
            existing_receipt.setdefault(key, saved[key])
        existing_receipt["extraction"] = {
            "tool": "tools/extract_model_checkpoint.py",
            "command": command,
            "schema": "small31-native-records-v3",
            "source": {
                "dll": str(dll),
                "dll_sha256": archive.dll_sha256,
                "dll_byte_length": archive.manifest["source"]["dllByteLength"],
                "resource_path": SMALL31.resource.path,
                "resource_sha256": archive.resource_sha256,
                "resource_byte_length": SMALL31.resource.byte_length,
                "archive_manifest_sha256": archive.manifest_sha256,
                "runtime_executed": False,
                "dll_loaded": False,
                "network_used": False,
            },
            "record_count": checked["record_count"],
            "record_payload_bytes": checked["record_payload_bytes"],
            "special_records": checked["special_records"],
        }
        existing_receipt["verification"] = {
            "performed": [
                "native_records_bytes_vs_fresh_archive",
                "decoded_state_vs_archive_cpu_decode",
                "torch_load_weights_only_roundtrip",
                "isolated_pt_load_without_sidecar_or_archive",
            ],
            "pre_save": _receipt_without_hashes(checked),
            "roundtrip": _receipt_without_hashes(roundtrip),
            "isolated_load": isolated_result,
        }
        _write_json_atomic(saved_sidecar, existing_receipt)

        result = {
            "path": str(saved_path),
            "sidecar": str(saved_sidecar),
            "sha256": saved["sha256"],
            "byte_length": saved["byte_length"],
            "model": "small31",
            "format_version": saved["format_version"],
            "weight_precision": saved["weight_precision"],
            "storage": saved["storage"],
            "record_count": checked["record_count"],
            "record_payload_bytes": checked["record_payload_bytes"],
            "decoded_state_tensor_count": checked["decoded_state_tensor_count"],
            "special_records": checked["special_records"],
            "verification": {
                "roundtrip": True,
                "isolated_load_without_sidecar": True,
            },
        }
        print(json.dumps(result, indent=2))
        return 0
    except (OSError, TypeError, ValueError, RuntimeError, ImportError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
