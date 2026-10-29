"""Small, dependency-free publishing helpers for the kernel field guide.

Two source namespaces are deliberately kept separate:

* ``REVISION`` is the legacy pin for the historical 310.8 kernel lessons and the
  design-check manifest key.  It must not be used for files that did not exist
  at that commit.
* ``RUNTIME_REVISION`` is the explicit commit for new/modified 310.9.16 runtime
  sources.  When it is absent, those excerpts link to exact normalized LF copies
  under ``docs/kernel-guide/source/`` with the working-tree hash recorded, rather
  than to a Git URL that cannot resolve.
"""
from pathlib import Path
from html import escape
import hashlib
import re
import subprocess

from highlight import highlight_lines
from runtime_source_revision import configured_runtime_revision

ROOT = Path(__file__).resolve().parents[2]
#: Historical 310.8 / 81-lesson source pin.  Also the ``source_revision`` value
#: consumed by the existing design checks; keep this key unchanged.
REVISION = "fc3276497f866bdad639cd443e75743f5d19b749"
#: Commit that contains the new/modified runtime sources, or ``None`` until the
#: root committer supplies it (see runtime_source_revision.py).
RUNTIME_REVISION = configured_runtime_revision()
REPOSITORY = "https://github.com/DylanWaken/DLSS5-Pytorch"
SNIPPETS = []

_PROVENANCE: dict[str, dict] = {}


def _normalized_lf(text: str) -> str:
    """Return the canonical text form used for hashes and local copies."""
    return text.replace("\r\n", "\n").replace("\r", "\n")


def _git_blob(revision: str, path: str) -> str | None:
    """Read ``revision:path`` as text, or return ``None`` when it is absent."""
    result = subprocess.run(
        ["git", "show", f"{revision}:{path}"],
        cwd=ROOT, capture_output=True, text=True, encoding="utf-8",
        errors="replace",
    )
    if result.returncode != 0:
        return None
    return result.stdout


def file_provenance(path: str) -> dict:
    """Classify one repository source file and cache its exact provenance.

    The result is a plain dict so it can be serialized into the manifest:

    ``kind``
        ``legacy-commit`` when the working file is byte-identical (after
        newline normalization) to ``REVISION``; ``runtime-commit`` when an
        explicit runtime commit is configured, exists at that commit, and the
        working content matches it; ``working-tree`` otherwise.
    """
    if path in _PROVENANCE:
        return _PROVENANCE[path]
    target = ROOT / path
    if not target.is_file():
        raise FileNotFoundError(f"source file is missing: {path}")
    work = _normalized_lf(target.read_text(encoding="utf-8"))
    pinned = _git_blob(REVISION, path)
    if pinned is not None and _normalized_lf(pinned) == work:
        info = dict(kind="legacy-commit", revision=REVISION,
                    sha256=hashlib.sha256(work.encode()).hexdigest())
    elif RUNTIME_REVISION is not None:
        committed = _git_blob(RUNTIME_REVISION, path)
        if committed is None:
            raise ValueError(
                f"{path} is not present at runtime revision {RUNTIME_REVISION}; "
                "supply the commit that contains the implementation")
        if _normalized_lf(committed) != work:
            raise ValueError(
                f"{path} differs between the working tree and runtime revision "
                f"{RUNTIME_REVISION}; commit the exact documented source first")
        info = dict(kind="runtime-commit", revision=RUNTIME_REVISION,
                    sha256=hashlib.sha256(work.encode()).hexdigest())
    else:
        info = dict(kind="working-tree", revision=None,
                    sha256=hashlib.sha256(work.encode()).hexdigest())
    _PROVENANCE[path] = info
    return info


def _location(path: str, start: int | None = None, end: int | None = None) -> tuple[str, str]:
    """Return ``(href, label)`` for one source location."""
    suffix = f"#L{start}" if start else ""
    if end:
        suffix += f"-L{end}"
    info = file_provenance(path)
    if info["kind"] == "working-tree":
        return f"source/{path}{suffix}", "working tree · no implementation commit"
    revision = info["revision"]
    label = ("legacy pin " if info["kind"] == "legacy-commit" else "runtime commit ") + revision[:12]
    return f"{REPOSITORY}/blob/{revision}/{path}{suffix}", label


def source_url(path, start=None, end=None):
    """Return the honest link target for one source path.

    No file is ever linked to a commit that does not contain it.  Legacy files
    keep the historical GitHub link; uncommitted runtime files resolve to the
    exact local copy written by the build.
    """
    return _location(path, start, end)[0]


def code(path, start, end, caption=""):
    lines = (ROOT / path).read_text(encoding="utf-8").splitlines()
    if not 1 <= start <= end <= len(lines):
        raise ValueError(f"Invalid excerpt {path}:{start}-{end} ({len(lines)} lines)")
    excerpt = "\n".join(lines[start - 1:end])
    href, revision_label = _location(path, start, end)
    info = file_provenance(path)
    SNIPPETS.append(dict(
        path=path, start=start, end=end,
        sha256=hashlib.sha256(excerpt.encode()).hexdigest(),
        source_kind=info["kind"], revision=info["revision"],
        source_sha256=info["sha256"], url=href,
    ))
    language = 'python' if Path(path).suffix == '.py' else 'cpp'
    colored = highlight_lines('\n'.join(lines), language)
    numbered = "\n".join(f'<span class="code-line"><span class="ln" aria-hidden="true">{i}</span>{line}</span>'
                         for i, line in enumerate(colored[start - 1:end], start))
    return (f'<details class="source" open><summary>{escape(caption or Path(path).name)}'
            f' <span>lines {start}–{end}</span></summary><div class="source-toolbar">'
            f'<a href="{href}">{escape(path)} ↗</a>'
            f'<span class="source-revision" style="color:#99b9c8">{escape(revision_label)}</span>'
            '<button type="button" class="copy-code">Copy code</button></div>'
            f'<pre><code class="syntax-highlight language-{language}">{numbered}</code></pre></details>')


def provenance_note():
    """Return the runtime page's mixed-provenance disclosure."""
    if RUNTIME_REVISION is None:
        return (
            '<aside class="note"><strong>Source provenance is mixed.</strong> '
            f'Historical 310.8 kernel sources are pinned to <code>{REVISION[:12]}</code>. '
            'The new/modified 310.9.16 runtime sources quoted on this page are not '
            'present at that commit, so every such excerpt links to an exact normalized-LF '
            'copy under <code>source/</code> and records the working-tree SHA-256 in '
            '<code>source-manifest.json</code>. No implementation commit has been supplied '
            'yet; these excerpts are therefore working-tree provenance, not a GitHub pin. '
            'Once the implementation commit is provided, the build verifies each blob and '
            'changes those links to that exact revision.</aside>'
        )
    return (
        '<aside class="note"><strong>Source provenance is mixed.</strong> '
        f'Historical 310.8 kernel sources are pinned to <code>{REVISION[:12]}</code>. '
        f'New/modified 310.9.16 runtime sources are pinned to the supplied implementation '
        f'commit <code>{RUNTIME_REVISION[:12]}</code>; the build compared every working-tree '
        'excerpt with that committed blob. The manifest records both revisions per file. '
        'The legacy <code>source_revision</code> key and the 81 historical lessons are '
        'unchanged.</aside>'
    )


def svg(title, viewbox, inner, caption="", min_width=None):
    ident = "fig-" + hashlib.sha256((title + inner).encode()).hexdigest()[:12]
    # Make a common arrow available while allowing chapters to define their own.
    defs = '<defs><marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0 0 L10 5 L0 10 Z" fill="#576c83"/></marker></defs>'
    inner = defs + inner
    # SVG ids are document-global even in separate inline figures.
    ids = re.findall(r'\bid="([^"]+)"', inner)
    for old in sorted(set(ids), key=len, reverse=True):
        new = ident + "-" + old
        inner = inner.replace(f'id="{old}"', f'id="{new}"').replace(f'url(#{old})', f'url(#{new})').replace(f'href="#{old}"', f'href="#{new}"')
    inner = re.sub(r'class="([^"]*\bedge\b[^"]*)"', lambda m: f'class="{m[1]}" style="marker-end:url(#{ident}-arrow)"', inner)
    width = float(str(viewbox).split()[2])
    if min_width is None:
        min_width = min(width, 820)
    return (f'<figure class="diagram"><div class="diagram-scroll" tabindex="0" role="region" aria-label="{escape(title)}">'
            f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="{viewbox}" role="img" aria-labelledby="{ident}" style="min-width:{min_width:g}px">'
            f'<title id="{ident}">{escape(title)}</title>{inner}</svg></div>'
            f'<figcaption>{caption or escape(title)}</figcaption></figure>')


def note(text):
    return f'<aside class="note">{text}</aside>'
