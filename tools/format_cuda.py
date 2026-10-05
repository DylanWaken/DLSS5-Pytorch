"""Restore CUDA loop-directive layout after clang-format (including version 19).

Run without arguments to format kernel implementations and shared headers, or
with --check to report files needing this pass. This changes whitespace only;
stage explanations are authored in the kernel source, not generated here.
"""
import argparse
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
UNROLL = re.compile(r"\s*#\s*pragma\s+unroll(?:\s+.*)?$")


def format_source(source):
    lines = source.splitlines()
    for index, line in enumerate(lines):
        if not UNROLL.fullmatch(line):
            continue
        following = index + 1
        while following < len(lines) and (
            not lines[following].strip() or lines[following].lstrip().startswith("//")
        ):
            following += 1
        if following == len(lines) or not re.match(r"\s*for\s*\(", lines[following]):
            raise ValueError(f"Unroll directive without its loop at line {index + 1}")
        indent = re.match(r"\s*", lines[following]).group()
        lines[index] = indent + line.lstrip()
        # clang-format also moves comments immediately preceding a pragma.
        comment = index - 1
        while comment >= 0 and lines[comment].lstrip().startswith("//"):
            lines[comment] = indent + lines[comment].lstrip()
            comment -= 1

    result = []
    for line in lines:
        stripped = line.strip()
        previous = result[-1].strip() if result else ""
        # A stage explanation starts a new paragraph, except at the opening of
        # its scope or directly after a control statement governing that scope.
        if stripped.startswith("//") and previous and not previous.startswith(("//", "#")):
            if previous.endswith((";", "}")):
                result.append("")
        # Separate completed outer stages, while keeping else/do-while clauses
        # attached and nested fragment loops compact.
        indent = re.match(r"[ \t]*", line).group()
        if (previous in ("}", "};") and result[-1].strip() and len(indent.expandtabs(4)) <= 8 and stripped
                and not stripped.startswith(("}", "else", "while", "#endif"))
                and result[-1][:len(indent)] == indent):
            result.append("")
        if not stripped and (not result or not result[-1].strip()):
            continue
        result.append(line.rstrip())
    return "\n".join(result).rstrip() + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    changed = []
    for path in sorted((ROOT / "csrc/kernel_impl").rglob("*")):
        if path.suffix not in (".cu", ".cuh"):
            continue
        raw = path.read_bytes()
        source = raw.decode("utf8").replace("\r\n", "\n")
        formatted = format_source(source)
        if formatted != source:
            changed.append(path.relative_to(ROOT).as_posix())
            if not args.check:
                newline = "\r\n" if b"\r\n" in raw else "\n"
                path.write_bytes(formatted.replace("\n", newline).encode("utf8"))
    print(f"{'Needs formatting' if args.check else 'Formatted'}: {len(changed)} files")
    if args.check and changed:
        print("\n".join(changed))
        raise SystemExit(1)


if __name__ == "__main__":
    main()
