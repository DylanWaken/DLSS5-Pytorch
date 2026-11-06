"""Small, dependency-free publishing helpers for the kernel field guide.

Source text comes from an explicit immutable provider, never from the working
tree.  Three ownership namespaces are deliberately kept separate:

* ``REVISION`` is the legacy pin for the historical 310.8 kernel lessons and the
  design-check manifest key.  It must not be used for files that did not exist
  at that commit.
* ``RUNTIME_REVISION`` is the explicit commit for new/modified 310.9.16 runtime
  sources.  The snapshot bytes are verified against that committed blob.
* ``CHECKPOINT_API_REVISION`` owns only the checkpoint-API sources.  It takes
  precedence for those paths and has no fallback to either historical pin.

All three are read from the immutable snapshot materialized by
``source_providers.ORIGINAL``.  ``current_provider()`` is the separate,
optional namespace for a later real FlashLight implementation commit.
"""
from pathlib import Path
from html import escape
import hashlib
import re

from highlight import highlight_lines
from runtime_source_revision import (
    configured_checkpoint_api_revision,
    configured_runtime_revision,
)
from source_providers import ORIGINAL, Provider

ROOT = Path(__file__).resolve().parents[2]
#: Historical 310.8 / 81-lesson source pin.  Also the ``source_revision`` value
#: consumed by the existing design checks; keep this key unchanged.
REVISION = "fc3276497f866bdad639cd443e75743f5d19b749"
#: Commit that contains the new/modified runtime sources, or ``None`` until the
#: root committer supplies it (see runtime_source_revision.py).
RUNTIME_REVISION = configured_runtime_revision()
#: Commit that owns the changed checkpoint API sources.  ``None`` means
#: unconfigured: the build must fail rather than borrow another revision.
CHECKPOINT_API_REVISION = configured_checkpoint_api_revision()
REPOSITORY = "https://github.com/DylanWaken/DLSS5-Pytorch"
#: Historical (original-provider) excerpts.  Kept exactly 1,570 for the frozen
#: 99-page guide; current-chapter excerpts use a separate registry so two
#: revisions of the same path can never collide or inflate the old counts.
SNIPPETS = []
#: Optional FlashLight/current-provider excerpts, serialized in their own
#: manifest namespace.
CURRENT_SNIPPETS = []

_PROVENANCE: dict[tuple[str, str, str], dict] = {}


def file_provenance(path: str, provider: Provider = ORIGINAL) -> dict:
    """Classify one source path explicitly for ``provider`` and cache it.

    The original provider applies the frozen precedence: checkpoint API first,
    runtime second, legacy remaining, and an unowned/missing blob is an error.
    The current provider returns ``refactor-commit`` for its own commit.
    """
    key = (provider.name, provider.revision, path)
    if key not in _PROVENANCE:
        _PROVENANCE[key] = provider.provenance(path)
    return _PROVENANCE[key]


def _location(path: str, start: int | None = None, end: int | None = None,
              provider: Provider = ORIGINAL) -> tuple[str, str]:
    """Return ``(href, label)`` for one source location."""
    suffix = f"#L{start}" if start else ""
    if end:
        suffix += f"-L{end}"
    info = file_provenance(path, provider)
    revision = info["revision"]
    if info["kind"] == "legacy-commit":
        label = "legacy pin " + revision[:12]
    elif info["kind"] == "checkpoint-api-commit":
        label = "checkpoint API commit " + revision[:12]
    elif info["kind"] == "runtime-commit":
        label = "runtime commit " + revision[:12]
    else:
        label = "refactor commit " + revision[:12]
    return f"{REPOSITORY}/blob/{revision}/{path}{suffix}", label


def source_url(path, start=None, end=None, provider: Provider = ORIGINAL):
    """Return the honest link target for one source path at ``provider``.

    No file is ever linked to a commit that does not contain it, and the
    working tree is never consulted.
    """
    return _location(path, start, end, provider)[0]


def code(path, start, end, caption="", provider: Provider = ORIGINAL,
         registry=None):
    """Emit one exact provider excerpt and record its provider attribution.

    Historical callers keep the one-argument default.  A current chapter must
    pass ``provider=current_provider()`` explicitly and defaults to the separate
    ``CURRENT_SNIPPETS`` registry.
    """
    lines = provider.text(path).splitlines()
    if not 1 <= start <= end <= len(lines):
        raise ValueError(f"Invalid excerpt {path}:{start}-{end} ({len(lines)} lines)")
    excerpt = "\n".join(lines[start - 1:end])
    href, revision_label = _location(path, start, end, provider)
    info = file_provenance(path, provider)
    if registry is None:
        registry = SNIPPETS if provider.name == "original" else CURRENT_SNIPPETS
    registry.append(dict(
        path=path, start=start, end=end,
        sha256=hashlib.sha256(excerpt.encode()).hexdigest(),
        source_kind=info["kind"], revision=info["revision"],
        source_sha256=info["sha256"], url=href,
        source_provider=provider.name,
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
    checkpoint = (
        f'Checkpoint API sources are pinned to the separately supplied implementation '
        f'commit <code>{CHECKPOINT_API_REVISION[:12]}</code>.'
        if CHECKPOINT_API_REVISION is not None else
        'Checkpoint API sources have no configured implementation commit: the changed '
        'loader and its three source excerpts cannot be published, and every other '
        'runtime/native source keeps its existing pin.'
    )
    if RUNTIME_REVISION is None:
        return (
            '<aside class="note"><strong>Source provenance is mixed.</strong> '
            f'Historical 310.8 kernel sources are pinned to <code>{REVISION[:12]}</code>. '
            'The new/modified 310.9.16 runtime sources have no configured implementation '
            'commit, so the build refuses to attribute them to the immutable historical '
            f'snapshot at <code>{ORIGINAL.revision[:12]}</code>. '
            f'{checkpoint} '
            'The 81 historical lessons and the legacy <code>source_revision</code> key are '
            'unchanged.</aside>'
        )
    return (
        '<aside class="note"><strong>Source provenance is mixed.</strong> '
        f'Historical 310.8 kernel sources are pinned to <code>{REVISION[:12]}</code>. '
        f'New/modified 310.9.16 runtime sources are pinned to the supplied implementation '
        f'commit <code>{RUNTIME_REVISION[:12]}</code>; every excerpt is read from the '
        f'immutable original snapshot at <code>{ORIGINAL.revision[:12]}</code> and checked '
        'against that committed blob, never against the working tree. '
        f'{checkpoint} '
        'The manifest records both revisions per file. '
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
