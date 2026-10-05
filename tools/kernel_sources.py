"""Inspect CUDA source ownership without assuming one kernel per file.

The canonical exported name is the inventory key; a grouped operation header may
define several entries and shared templated bodies. This is a structural audit,
not a C++ compiler or a numerical/performance qualification.

    python -B tools/kernel_sources.py --output outputs/kernel-sources.json
    python -B tools/kernel_sources.py --baseline-csrc path/to/saved/csrc

Only standard-library modules are used. No CUDA context or extension is loaded.
"""
import argparse
import json
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
SOURCE_SUFFIXES = {".cu", ".cuh", ".cpp", ".h", ".inl"}
INCLUDE = re.compile(r'^\s*#\s*include\s*"([^"\n]+)"', re.MULTILINE)
COMMENTS_AND_STRINGS = re.compile(
    r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'', re.DOTALL
)
NAMESPACE = re.compile(r"\bnamespace\s+([A-Za-z_]\w*(?:::\w+)*)\s*\{")
KERNEL = re.compile(
    r"\b__global__\s+(?:__\w+__\s*\([^{};]*?\)\s*)?void\s+"
    r"([A-Za-z_]\w*)\s*\(([^{};]*)\)\s*\{"
)
TEMPLATE_CALL = re.compile(r"\b([A-Za-z_]\w*(?:::\w+)*)\s*<([^{};]*?)>\s*\(")
CPP_CASTS = {"const_cast", "dynamic_cast", "reinterpret_cast", "static_cast"}


def _without_comments_and_strings(source):
    # Preserve positions and line numbers for diagnostics and body extraction.
    return COMMENTS_AND_STRINGS.sub(
        lambda match: "".join("\n" if char == "\n" else " " for char in match[0]), source
    )


def _body_end(source, opening):
    depth = 1
    for match in re.finditer(r"[{}]", source[opening + 1:]):
        depth += 1 if match[0] == "{" else -1
        if depth == 0:
            return opening + 1 + match.end()
    raise ValueError("unclosed kernel body")


def collect(csrc):
    """Return a JSON-compatible inventory keyed by canonical CUDA entry name."""
    csrc = Path(csrc).resolve()
    paths = sorted(path for path in csrc.rglob("*") if path.suffix in SOURCE_SUFFIXES)
    if not paths:
        raise ValueError(f"no C++/CUDA sources found in {csrc}")
    sources = {path: path.read_text(encoding="utf-8") for path in paths}
    includes = {}
    entries = {}
    for path, source in sources.items():
        relative = path.relative_to(csrc).as_posix()
        dependencies = []
        for include in INCLUDE.finditer(source):
            candidates = [path.parent / include[1], csrc / include[1]]
            resolved = next((candidate.resolve() for candidate in candidates if candidate.is_file()), None)
            if resolved is None:
                raise ValueError(f"{relative}: missing local include {include[1]}")
            if not resolved.is_relative_to(csrc):
                raise ValueError(f"{relative}: local include leaves csrc: {include[1]}")
            dependencies.append(resolved.relative_to(csrc).as_posix())
        includes[relative] = sorted(set(dependencies))

        cleaned = _without_comments_and_strings(source)
        namespaces = list(NAMESPACE.finditer(cleaned))
        for kernel in KERNEL.finditer(cleaned):
            name = kernel[1]
            if name in entries:
                raise ValueError(f"duplicate CUDA entry {name}: {entries[name]['header']} and {relative}")
            if path.parent != csrc / "kernel_impl":
                raise ValueError(f"CUDA entry {name} is outside kernel_impl: {relative}")
            namespace = next((match[1] for match in reversed(namespaces) if match.start() < kernel.start()), "")
            if namespace != "dlssnr::reconstructed::" + name:
                raise ValueError(f"{name}: unexpected exported namespace {namespace!r}")
            end = _body_end(cleaned, kernel.end() - 1)
            calls = sorted({
                " ".join(match[0][:-1].split()).rstrip()
                for match in TEMPLATE_CALL.finditer(cleaned[kernel.end():end])
                if match[1] not in CPP_CASTS
            })
            entries[name] = {
                "namespace": namespace,
                "header": relative,
                "line": source.count("\n", 0, kernel.start()) + 1,
                "parameters": " ".join(kernel[2].split()),
                "template_calls": calls,
            }

    def closure(path, seen):
        if path in seen:
            return
        seen.add(path)
        for dependency in includes[path]:
            closure(dependency, seen)

    emission_units = {}
    for path in paths:
        if path.suffix == ".cu":
            relative = path.relative_to(csrc).as_posix()
            seen = set()
            closure(relative, seen)
            emission_units[relative] = sorted(seen)
    for name, entry in entries.items():
        owners = [unit for unit, dependencies in emission_units.items() if entry["header"] in dependencies]
        if len(owners) != 1:
            raise ValueError(f"{name}: expected one CUDA emission unit, found {len(owners)}: {owners}")
        entry["emission_unit"] = owners[0]
    return {
        "schema_version": 1,
        "entry_count": len(entries),
        "body_header_count": len({entry["header"] for entry in entries.values()}),
        "emission_unit_count": len(emission_units),
        "entries": dict(sorted(entries.items())),
    }


def check_roster(inventory):
    """Check the qualified public roster without encoding body-file paths."""
    names = set(inventory["entries"])
    if len(names) != 81 or "completion_counter_clear" not in names:
        raise ValueError("expected 40 FP8/FP16 pairs and completion_counter_clear (81 entries)")
    fp8 = {name[:-4] for name in names if name.endswith("_fp8")}
    fp16 = {name[:-5] for name in names if name.endswith("_fp16")}
    if len(fp8) != 40 or fp8 != fp16:
        raise ValueError("FP8/FP16 canonical entry families differ")


def compare_exports(candidate, baseline):
    def exported(inventory):
        return {(name, entry["namespace"]) for name, entry in inventory["entries"].items()}
    missing = exported(baseline) - exported(candidate)
    added = exported(candidate) - exported(baseline)
    if missing or added:
        raise ValueError(f"exported entry roster changed: missing={sorted(missing)}, added={sorted(added)}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--csrc", type=Path, default=ROOT / "csrc")
    parser.add_argument("--baseline-csrc", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    inventory = collect(args.csrc)
    check_roster(inventory)
    if args.baseline_csrc:
        compare_exports(inventory, collect(args.baseline_csrc))
        inventory["baseline_exports_unchanged"] = True
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(inventory, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({key: value for key, value in inventory.items() if key != "entries"}, indent=2))


if __name__ == "__main__":
    main()
