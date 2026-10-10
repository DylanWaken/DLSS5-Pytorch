"""Small, dependency-free publishing helpers for the kernel field guide."""
from pathlib import Path
from html import escape
import hashlib
import re

ROOT = Path(__file__).resolve().parents[2]
REVISION = "fc3276497f866bdad639cd443e75743f5d19b749"
REPOSITORY = "https://github.com/DylanWaken/DLSS5-Pytorch"
SNIPPETS = []


def source_url(path, start=None, end=None):
    suffix = f"#L{start}" if start else ""
    if end:
        suffix += f"-L{end}"
    return f"{REPOSITORY}/blob/{REVISION}/{path}{suffix}"


def code(path, start, end, caption=""):
    lines = (ROOT / path).read_text(encoding="utf-8").splitlines()
    if not 1 <= start <= end <= len(lines):
        raise ValueError(f"Invalid excerpt {path}:{start}-{end} ({len(lines)} lines)")
    excerpt = "\n".join(lines[start - 1:end])
    SNIPPETS.append(dict(path=path, start=start, end=end,
                         sha256=hashlib.sha256(excerpt.encode()).hexdigest()))
    numbered = "\n".join(f'<span class="code-line"><span class="ln" aria-hidden="true">{i}</span>{escape(line)}</span>'
                         for i, line in enumerate(lines[start - 1:end], start))
    return (f'<details class="source" open><summary>{escape(caption or Path(path).name)}'
            f' <span>lines {start}–{end}</span></summary><div class="source-toolbar">'
            f'<a href="{source_url(path, start, end)}">{escape(path)} ↗</a>'
            '<button type="button" class="copy-code">Copy code</button></div>'
            f'<pre><code>{numbered}</code></pre></details>')


def svg(title, viewbox, inner, caption=""):
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
    return (f'<figure class="diagram"><div class="diagram-scroll" tabindex="0" role="region" aria-label="{escape(title)}">'
            f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="{viewbox}" role="img" aria-labelledby="{ident}" style="min-width:{min(width, 820):g}px">'
            f'<title id="{ident}">{escape(title)}</title>{inner}</svg></div>'
            f'<figcaption>{caption or escape(title)}</figcaption></figure>')


def note(text):
    return f'<aside class="note">{text}</aside>'
