"""Statically extract signed 310.9.16 NR CUDA modules; never loads or executes the DLL.

Tracked reproduction CLI adapted from the accepted profile extractor.  Only
path configuration and command-line portability differ; the signed source pin,
structural bounds checks, NR namespace/seven-module selection, Zstandard PTX +
cubin extraction and byte hash validation are unchanged.

Requires Python 3.14 for the standard-library ``compression.zstd`` module.
Optional legacy comparison reads ``--legacy-modules`` (default
``assets/vendor_modules``); if those 310.8 artifacts are absent, extraction of
the correctly pinned new DLL still succeeds and records that comparison was
skipped.

Key differences from the legacy extractor:
  * pinned to the signed 310.9.16 image (SHA-256 below);
  * inventories every structurally valid fatbinary bundle before filtering;
  * selects NR bundles by 120-byte entry headers plus vendor kernel namespaces
    instead of assuming exactly seven bundles with no provenance;
  * records per-bundle/per-entry bounds, hashes and PTX kernel rosters;
  * compares against the legacy 310.8 manifest and module files.

Our Small-specific export names (`small_global_attention_*`) are NOT vendor
symbols and are deliberately not used for selection.  Vendor symbol identity is
the schedule `original_symbol` roster.
"""
from compression import zstd
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import sys

ROOT = Path(__file__).resolve().parents[1]
PROFILE_DIR = ROOT / "profile/readme-dual-model-20261030/dll-speed"
OUT = PROFILE_DIR / "vendor_modules_310_9_16"
DLL = ROOT / "profile/dlss-update-20261029/artifacts/dll/nvngx_dlssnr_310.9.16.dll"
PIN = "2bc19bc09a7b89dd44f73e2ac0108fcc586e2154bdd0830f242f4f040e28789f"
OLD_MODULES = ROOT / "assets/vendor_modules"
MAX_BUNDLE = 256 * 1024 * 1024
MAX_PTX = 64 * 1024 * 1024

# Vendor namespaces observed in both signed DLLs.  Utility bundles (cuda_*/cg2r_*)
# are excluded from the NR roster but remain in the full inventory.
NR_KERNEL = re.compile(
    r"^(cc_(?:tinlayout|split_swin|vit|dec|cb_)[A-Za-z0-9_]*)$")
ENTRY_RE = re.compile(r"\.visible\s+\.entry\s+(\w+)\s*\(")
HEADER_RE = re.compile(r"(?m)^\.version\s+\S+$")


def sha(data):
    return hashlib.sha256(data).hexdigest()


def display_path(path):
    """Render a path relative to the repository when possible, else absolute."""
    path = Path(path).resolve()
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)


def parse_bundles(raw):
    """Inventory all valid fatbin headers first, with full bounds validation."""
    magic = struct.pack("<I", 0xBA55ED50)
    bundles, cursor = [], 0
    while (cursor := raw.find(magic, cursor)) >= 0:
        if cursor + 16 > len(raw):
            break
        _, version, header_length, body_length = struct.unpack_from("<IHHQ", raw, cursor)
        total = header_length + body_length
        valid = (version == 1 and header_length == 16 and 16 < total <= MAX_BUNDLE
                 and cursor + total <= len(raw))
        if not valid:
            cursor += 4
            continue
        bundle = raw[cursor:cursor + total]
        entries, position = [], 16
        while position + 16 <= total:
            kind, entry_version, entry_header, payload_length = struct.unpack_from("<HHIQ", bundle, position)
            if entry_header not in (96, 120) or entry_version != 0x101:
                raise ValueError(f"unexpected entry header at bundle {cursor}+{position}: "
                                 f"{kind}/{entry_version:#x}/{entry_header}")
            payload_start = position + entry_header
            end = payload_start + payload_length
            if end > total or end <= payload_start:
                raise ValueError(f"entry payload outside bundle bounds at {cursor}+{position}")
            payload = bundle[payload_start:end]
            # Both compressed entry kinds carry the compressed extent at +16
            # and the uncompressed extent at +56.  Raw utility ELF entries
            # (96-byte headers) leave those fields zero and store the ELF
            # directly, so they are inventoried without decompression.
            compressed = payload[:4] == b"\x28\xb5\x2f\xfd"
            if compressed:
                compressed_length = struct.unpack_from("<I", bundle, position + 16)[0]
                uncompressed_length = struct.unpack_from("<Q", bundle, position + 56)[0]
                if not 0 < compressed_length <= payload_length or not 0 < uncompressed_length <= MAX_PTX:
                    raise ValueError(f"invalid entry extent at {cursor}+{position}")
                extracted = zstd.decompress(payload[:compressed_length])
            else:
                compressed_length = uncompressed_length = payload_length
                extracted = payload
            if len(extracted) != uncompressed_length:
                raise ValueError(f"entry length mismatch at {cursor}+{position}")
            if kind == 1:
                if not compressed:
                    raise ValueError(f"uncompressed PTX entry at {cursor}+{position}")
                source = extracted.decode("utf-8")
                header = source[:256]
                if ".target sm_120" not in header or ".version 9.4" not in header:
                    raise ValueError(f"unexpected PTX target/version at {cursor}+{position}")
                kernels = ENTRY_RE.findall(source)
            elif kind == 2:
                if extracted[:4] != b"\x7fELF":
                    raise ValueError(f"expected CUDA ELF at {cursor}+{position}")
                kernels = []
            else:
                raise ValueError(f"unsupported CUDA entry kind {kind}")
            entries.append(dict(kind=kind, header_length=entry_header,
                                payload_length=payload_length,
                                compressed_length=compressed_length,
                                uncompressed_length=uncompressed_length,
                                payload_compression="zstd" if compressed else "raw",
                                dll_payload_offset=cursor + payload_start,
                                extracted_bytes=len(extracted), sha256=sha(extracted),
                                kernels=kernels))
            position = end
        bundles.append(dict(dll_offset=cursor, bytes=total, sha256=sha(bundle),
                            first_header=struct.unpack_from("<I", bundle, 20)[0],
                            entries=entries))
        cursor += 4
    return bundles


def kernel_bodies(ptx_text):
    """Extract `.visible .entry NAME` bodies for per-symbol PTX comparison."""
    bodies, matches = {}, list(ENTRY_RE.finditer(ptx_text))
    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(ptx_text)
        body = ptx_text[match.start():end]
        bodies[match.group(1)] = sha(body.encode("utf-8"))
    return bodies


def compare_legacy(new_modules, out_dir, legacy_modules):
    old_manifest = Path(legacy_modules) / "manifest.json"
    legacy = json.loads(old_manifest.read_text(encoding="utf-8"))
    rows = []
    for new in new_modules:
        index = new["id"]
        old = next((m for m in legacy["modules"] if m["id"] == index), None)
        if old is None:
            rows.append({"id": index, "legacy_found": False})
            continue
        old_cubin = next(e for e in old["entries"] if e["kind"] == 2)
        old_ptx = next(e for e in old["entries"] if e["kind"] == 1)
        old_cubin_bytes = (Path(legacy_modules) / old_cubin["file"]).read_bytes()
        old_ptx_text = (Path(legacy_modules) / old_ptx["file"]).read_text(encoding="utf-8")
        new_ptx_bytes = (Path(out_dir) / new["ptx"]).read_bytes()
        new_ptx_text = new_ptx_bytes.decode("utf-8")
        old_bodies, new_bodies = kernel_bodies(old_ptx_text), kernel_bodies(new_ptx_text)
        new_cubin_bytes = (Path(out_dir) / new["cubin"]).read_bytes()
        common = sorted(set(old_bodies) & set(new_bodies))
        rows.append({
            "id": index,
            "legacy_fatbin_sha256": old["fatbinSha256"],
            "new_fatbin_sha256": new["fatbinSha256"],
            "fatbin_identical": old["fatbinSha256"] == new["fatbinSha256"],
            "legacy_cubin_sha256": old_cubin["sha256"],
            "new_cubin_sha256": sha(new_cubin_bytes),
            "cubin_identical": old_cubin["sha256"] == sha(new_cubin_bytes),
            "legacy_ptx_sha256": old_ptx["sha256"],
            "new_ptx_sha256": sha(new_ptx_bytes),
            "ptx_identical": old_ptx["sha256"] == sha(new_ptx_bytes),
            "legacy_kernel_count": len(old_bodies),
            "new_kernel_count": len(new_bodies),
            "common_kernel_count": len(common),
            "kernels_only_legacy": sorted(set(old_bodies) - set(new_bodies)),
            "kernels_only_new": sorted(set(new_bodies) - set(old_bodies)),
            "common_kernel_bodies_identical": sum(old_bodies[k] == new_bodies[k] for k in common),
            "common_kernel_bodies_changed": [k for k in common if old_bodies[k] != new_bodies[k]],
            "legacy_kernels": sorted(old_bodies),
            "new_kernels": sorted(new_bodies),
        })
    return {"legacy_manifest": display_path(old_manifest),
            "legacy_sourceDllSha256": legacy["sourceDllSha256"],
            "rows": rows}


def build_parser():
    parser = argparse.ArgumentParser(
        description="Statically extract signed 310.9.16 NR CUDA modules without "
                    "loading the DLL. Requires Python 3.14 (stdlib compression.zstd).")
    parser.add_argument("--dll", type=Path, default=DLL,
                        help="signed 310.9.16 DLL (read-only, never loaded)")
    parser.add_argument("--output", type=Path, default=OUT,
                        help="extraction output directory; may be outside the repo")
    parser.add_argument("--legacy-modules", type=Path, default=OLD_MODULES,
                        help="optional 310.8 module directory for comparison; "
                             "absence does not block extraction")
    return parser


def main(argv=None):
    args = build_parser().parse_args(argv)
    dll = args.dll.resolve()
    out = args.output.resolve()
    raw = dll.read_bytes()
    actual = sha(raw)
    if actual != PIN:
        raise ValueError(f"DLL hash mismatch: {actual}")
    inventory = parse_bundles(raw)
    nr = []
    for bundle in inventory:
        if not bundle["entries"] or bundle["first_header"] != 120:
            continue
        kernels = [k for e in bundle["entries"] if e["kind"] == 1 for k in e["kernels"]]
        if kernels and all(NR_KERNEL.match(k) for k in kernels):
            nr.append(bundle)
    if len(nr) != 7:
        raise ValueError(f"expected seven 310.9.16 NR bundles, found {len(nr)}")
    out.mkdir(parents=True, exist_ok=True)
    modules = []
    for module_id, bundle in enumerate(nr):
        fatbin = raw[bundle["dll_offset"]:bundle["dll_offset"] + bundle["bytes"]]
        (out / f"module_{module_id}.fatbin").write_bytes(fatbin)
        entries = []
        for entry in bundle["entries"]:
            extension = "ptx" if entry["kind"] == 1 else "cubin"
            name = f"module_{module_id}.{extension}"
            if entry["kind"] == 1:
                start = entry["dll_payload_offset"] - bundle["dll_offset"]
                data = zstd.decompress(fatbin[start:start + entry["compressed_length"]])
            else:
                start = entry["dll_payload_offset"] - bundle["dll_offset"]
                data = fatbin[start:start + entry["compressed_length"]]
                if entry["payload_compression"] == "zstd":
                    data = zstd.decompress(data)
                if len(data) != entry["uncompressed_length"]:
                    raise ValueError(f"re-extracted length mismatch for {name}")
            if sha(data) != entry["sha256"]:
                raise ValueError(f"re-extracted hash mismatch for {name}")
            (out / name).write_bytes(data)
            entries.append(dict(kind=entry["kind"], file=name, bytes=len(data),
                                sha256=entry["sha256"], kernels=entry["kernels"],
                                dllPayloadOffset=entry["dll_payload_offset"]))
        modules.append(dict(id=module_id, dllOffset=bundle["dll_offset"],
                            bytes=bundle["bytes"], fatbinSha256=bundle["sha256"],
                            ptx=entries[0]["file"], cubin=entries[1]["file"],
                            entries=entries))
    manifest = {
        "sourceDllPath": display_path(dll),
        "sourceDllSha256": PIN,
        "sourceDllBytes": len(raw),
        "method": "Static fatbinary header inventory, bounds validation, Zstandard PTX "
                  "decompression and ELF copy; no cuModuleLoad, no DLL call, no GPU.",
        "executedDllOrGpuCode": False,
        "inventory": dict(bundles=len(inventory), nr_bundles=len(nr), bundles_detail=inventory),
        "selection_rule": "120-byte first entry header and every PTX kernel matching the "
                          "cc_{tinlayout,split_swin,vit,dec,cb_} vendor namespaces",
        "modules": modules,
    }
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    try:
        comparison = compare_legacy(modules, out, args.legacy_modules)
    except FileNotFoundError as exc:
        comparison = {"legacy_manifest": display_path(Path(args.legacy_modules) / "manifest.json"),
                      "legacy_comparison_available": False,
                      "reason": str(exc),
                      "rows": []}
    (out / "comparison_310_8_vs_310_9_16.json").write_text(
        json.dumps(comparison, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "dll_sha256": actual, "bundles": len(inventory), "nr_modules": len(modules),
        "kernels": sum(len(e["kernels"]) for m in modules for e in m["entries"]),
        "manifest_sha256": sha((out / "manifest.json").read_bytes()),
        "output": display_path(out),
        "identical_modules": [r["id"] for r in comparison["rows"] if r.get("cubin_identical")],
    }))
    return 0


if __name__ == "__main__":
    sys.exit(main())
