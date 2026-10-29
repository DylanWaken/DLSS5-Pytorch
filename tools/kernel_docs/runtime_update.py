"""Forward-design chapter for the DLSS-NR 310.9.16 / Small31 research update.

The chapter documents two different things and keeps them visibly separate:

* direct byte verification of the original 310.9.16 DLL and its two packed
  resources, and
* source-derived scheduling claims that have not been observed in a running
  vendor host, plus executed CPU/PyTorch checks, the built and imported SM120
  extension, and the real RGB fixtures executed by both models.

It deliberately does not assign the historical 310.8 NCU reports to Small31,
does not claim vendor parity, and does not present call counts as timings.  Four
current full/source reports measure an isolated replay of the two additive
attention calls; that is not a network timing.  Measured eager network timings and
the character comparison are published separately.  The remaining gap is the vendor
host descriptor and numerical parity, not a missing native build or device run.
"""
from html import escape
from pathlib import Path
import sys

from common import code, provenance_note, svg

# Read the frozen identity from the implementation instead of duplicating its
# stage partition in prose. The docs generator runs from the repository root.
try:
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
    from dlssnr.model_specs import SMALL31
except Exception:  # pragma: no cover - the normal build has the repository root
    SMALL31 = None

AS_OF = '2026-10-29'


def _stage_table_rows():
    if SMALL31 is None:
        return ''
    rows = []
    for stage in SMALL31.stages:
        roles = list(stage.roles)
        raw = sorted(SMALL31.raw_for_role(role) for role in roles)
        records = [record for record in SMALL31.records if record.stage == stage.id]
        payload = sum(record.byte_length for record in records)
        if stage.kind == 'encoder' and SMALL31.pre_role in roles:
            segment = 'pre 0 + encoder pair'
        elif stage.kind == 'decoder' and SMALL31.transition_role in roles:
            segment = 'transition 39 + decoder pair'
        elif stage.kind == 'decoder' and SMALL31.post_role in roles:
            segment = 'decoder pair + post 70'
        elif stage.kind == 'vit':
            segment = 'eight global blocks'
        elif stage.kind == 'encoder':
            segment = 'encoder pair'
        elif stage.kind == 'decoder':
            segment = 'decoder pair'
        else:
            segment = stage.kind
        rows.append(
            f'<tr><td><code>{escape(stage.id)}</code></td><td>{escape(segment)}</td>'
            f'<td>{", ".join(str(role) for role in roles)}</td>'
            f'<td>{", ".join(str(block) for block in raw)}</td>'
            f'<td>{len(records)}</td><td>{payload:,}</td></tr>'
        )
    return ''.join(rows)


def _stage_count():
    return len(SMALL31.stages) if SMALL31 is not None else 11


def _boundary_grouping():
    if SMALL31 is None:
        return 'pre shares encoder32; transition 39 shares decoder512; post 70 shares decoder32'
    parts = []
    for label, role in (('pre', SMALL31.pre_role), ('transition', SMALL31.transition_role),
                        ('post', SMALL31.post_role)):
        if role is None:
            continue
        stage = SMALL31.stage_for_role(role)
        if len(stage.roles) == 1:
            parts.append(f'{label} {role} has its own stage')
        else:
            parts.append(f'{label} {role} shares <code>{escape(stage.id)}</code>')
    return '; '.join(parts)


STAGE_TABLE_ROWS = _stage_table_rows()
STAGE_COUNT = _stage_count()
STAGE_GROUPING = _boundary_grouping()

# ---------------------------------------------------------------------------
# Shared diagram helpers.


def diagram(title, desc, viewbox, inner, caption=''):
    """Build the shared <figure>/<svg> shell and add an accessible description."""
    # Runtime diagrams carry dense 11–14 px labels in 1400–1500 px viewBoxes.
    # Keep their natural width instead of shrinking to the 820 px common floor;
    # the existing .diagram-scroll wrapper provides horizontal scrolling.
    figure = svg(title, viewbox, inner, caption,
                 min_width=float(str(viewbox).split()[2]))
    return figure.replace('</title>', f'</title><desc>{escape(desc)}</desc>', 1)


def _box(x, y, w, h, line1, line2, line3, klass='tensor', line2_size=15):
    cx = x + w / 2
    return (
        f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="7" class="{klass}"/>'
        f'<text x="{cx}" y="{y + 19}" text-anchor="middle" class="small" style="font-size:11px">{line1}</text>'
        f'<text x="{cx}" y="{y + 44}" text-anchor="middle" class="label" style="font-size:{line2_size}px">{line2}</text>'
        f'<text x="{cx}" y="{y + 65}" text-anchor="middle" class="small" style="font-size:12px">{line3}</text>'
    )


def _grid_panel(x, y, mask, phase, sx, sy, note_text):
    """One 16 x 16 token field with shifted 8 x 8 window boundaries."""
    cell = 9
    field = 16 * cell
    token_x, token_y = 5, 5
    window = ((token_x + sx) // 8, (token_y + sy) // 8)
    local = ((token_x + sx) % 8, (token_y + sy) % 8)
    parts = [
        f'<text x="{x + field / 2}" y="{y - 12}" text-anchor="middle" class="label" style="font-size:15px">mask {mask} · phase {phase}</text>'
    ]
    for row in range(16):
        for col in range(16):
            fill = '#fff3e2' if (row, col) == (token_y, token_x) else '#eef6f1'
            parts.append(
                f'<rect x="{x + col * cell}" y="{y + row * cell}" width="{cell}" height="{cell}" '
                f'fill="{fill}" stroke="#d7e5df" stroke-width="0.5"/>'
            )
    start_x = (-sx) % 8
    start_y = (-sy) % 8
    for boundary in range(start_x, 17, 8):
        parts.append(
            f'<path d="M{x + boundary * cell} {y} V{y + field}" stroke="#147d78" stroke-width="3" fill="none"/>'
        )
    for boundary in range(start_y, 17, 8):
        parts.append(
            f'<path d="M{x} {y + boundary * cell} H{x + field}" stroke="#147d78" stroke-width="3" fill="none"/>'
        )
    cx = x + token_x * cell + cell / 2
    cy = y + token_y * cell + cell / 2
    parts.append(f'<circle cx="{cx}" cy="{cy}" r="6" fill="#a55128" stroke="#fff" stroke-width="2"/>')
    if isinstance(note_text, str):
        note_text = (note_text,)
    notes = ''.join(
        f'<text x="{x + field / 2}" y="{y + field + 66 + index * 16}" text-anchor="middle" '
        f'class="small" style="font-size:12px">{line}</text>'
        for index, line in enumerate(note_text)
    )
    parts.append(
        f'<text x="{x + field / 2}" y="{y + field + 24}" text-anchor="middle" class="small">shift +{sx} x, +{sy} y</text>'
        f'<text x="{x + field / 2}" y="{y + field + 46}" text-anchor="middle" class="small">window {window} · local {local}</text>'
        f'{notes}'
    )
    return ''.join(parts)


# ---------------------------------------------------------------------------
# Diagram 1: shape-aware three-band role map.

_TOP_ROLES = [
    (0, 's0 / r0', 'C32', 'pre'),
    (1, 's1 / r1', 'C32', 'body'),
    (4, 's2 / r4', 'C32', 'tail · down'),
    (5, 's3 / r5', 'C64', 'body'),
    (8, 's4 / r8', 'C64', 'tail · down'),
    (9, 's5 / r9', 'C128', 'body'),
    (14, 's6 / r14', 'C128', 'tail · down'),
    (15, 's7 / r15', 'C256', 'body'),
    (22, 's8 / r22', 'C256', 'tail · down'),
    (23, 's9 / r23', 'C512', 'body'),
    (30, 's10 / r30', 'C512', 'tail · down'),
]
_GLOBAL_ROLES = [
    (31, 's11 / r31', 'C1024', 'global'),
    (32, 's12 / r32', 'C1024', 'global'),
    (33, 's13 / r33', 'C1024', 'global'),
    (34, 's14 / r34', 'C1024', 'global'),
    (35, 's15 / r35', 'C1024', 'global'),
    (36, 's16 / r36', 'C1024', 'global'),
    (37, 's17 / r37', 'C1024', 'global'),
    (38, 's18 / r38', 'C1024', 'global'),
    (39, 's19 / r39', '1024→512', 'transition'),
]
_BOTTOM_ROLES = [
    (40, 's20 / r40', 'C512', 'first'),
    (47, 's21 / r47', 'C512', 'last'),
    (48, 's22 / r48', 'C256', 'first'),
    (55, 's23 / r55', 'C256', 'last'),
    (56, 's24 / r56', 'C128', 'first'),
    (61, 's25 / r61', 'C128', 'last'),
    (62, 's26 / r62', 'C64', 'first'),
    (65, 's27 / r65', 'C64', 'last'),
    (66, 's28 / r66', 'C32', 'first'),
    (69, 's29 / r69', 'C32', 'last'),
    (70, 's30 / r70', 'post', 'head + blend'),
]


def _two_row_svg():
    """Stage-group map: three bands keep every label inside a readable box."""
    parts = [
        '<text x="30" y="32" class="label">Encoder + pre · reading order left → right</text>',
        '<text x="30" y="200" class="label">Global bottleneck · eight C1024 blocks + transition</text>',
        '<text x="30" y="370" class="label">Decoder + post · reading order left → right</text>',
    ]
    centers = {}

    def row(entries, y, width, step, height=82):
        row_centers = []
        for index, (role, head, label, sub) in enumerate(entries):
            x = 30 + index * step
            klass = 'storage' if 31 <= role <= 38 else 'compute' if role in (39, 70) else 'tensor'
            parts.append(_box(x, y, width, height, head, label, sub, klass,
                              14 if len(label) > 6 else 15))
            row_centers.append(x + width / 2)
            centers[role] = row_centers[-1]
            if index + 1 < len(entries):
                parts.append(f'<path d="M{x + width} {y + height / 2} H{x + step - 2}" class="edge"/>')
        return row_centers

    row(_TOP_ROLES, 58, 118, 132)
    row(_GLOBAL_ROLES, 222, 150, 162)
    row(_BOTTOM_ROLES, 392, 118, 132)
    skip_targets = {4: 'skip → r66', 8: 'skip → r62', 14: 'skip → r56', 22: 'skip → r48', 30: 'skip → r39'}
    for role, label in skip_targets.items():
        parts.append(
            f'<text x="{centers[role]}" y="162" text-anchor="middle" class="small" style="font-size:11px">{label}</text>'
        )
    parts.append(
        f'<path d="M{centers[30] + 40} 140 V182 H12 V263 H30" class="edge"/>'
        f'<path d="M{centers[39]} 304 V348 H12 V433 H30" class="edge"/>'
    )
    parts.append(
        '<rect x="30" y="516" width="18" height="18" rx="3" class="tensor"/>'
        '<text x="58" y="531" class="small">encoder / decoder window block</text>'
        '<rect x="330" y="516" width="18" height="18" rx="3" class="storage"/>'
        '<text x="358" y="531" class="small">C1024 global block</text>'
        '<rect x="545" y="516" width="18" height="18" rx="3" class="compute"/>'
        '<text x="573" y="531" class="small">transition</text>'
        '<text x="760" y="531" class="small">sN = raw Small record id; rN = legacy operation role.</text>'
        '<text x="30" y="558" class="small">Each band is a reading order, not a simultaneous pass. Encoder tails publish the skip; the transition consumes the C512 tail.</text>'
    )
    return (
        '0 0 1500 580',
        ''.join(parts),
        'Stage-group map of the 31 Small roles in three readable bands, all reading left to right: pre and five encoder pairs (11 boxes), eight C1024 global blocks plus transition 39 (9 boxes), then five decoder pairs and post 70 (11 boxes). Raw Small ids and legacy operation roles are shown together, and skip targets leave the encoder band.',
        'The bands are a reading order, not three simultaneous passes. The wider viewBox keeps every label inside its box; boxes are not drawn to scale and the map makes no timing claim.',
    )


# ---------------------------------------------------------------------------
# Diagram 2: raw record id to operation role.

def _identity_svg():
    parts = [
        '<rect x="24" y="26" width="330" height="118" rx="9" class="storage"/>',
        '<text x="43" y="57" class="label">WEIGHTS_CC_SMALL_FP8</text>',
        '<text x="43" y="83" class="small">113,893,343 B resource · 77 records</text>',
        '<text x="43" y="106" class="small">payload 113,887,490 B</text>',
        '<text x="43" y="129" class="small">SHA-256 f743e8…ef7962</text>',
        '<text x="384" y="93" class="small">parse</text>',
        '<path d="M354 85 H418" class="edge"/>',
        '<rect x="428" y="26" width="310" height="118" rx="9" class="tensor"/>',
        '<text x="447" y="57" class="label">raw DLL namespace</text>',
        '<text x="447" y="83" class="small">block0 … block30, contiguous</text>',
        '<text x="447" y="106" class="small">77 records, role carried by mapping</text>',
        '<text x="447" y="129" class="small">never index the legacy roster by raw id</text>',
        '<text x="748" y="93" class="small">map</text>',
        '<path d="M738 85 H782" class="edge"/>',
        '<rect x="792" y="26" width="330" height="118" rx="9" class="compute"/>',
        '<text x="811" y="57" class="label">operation-role namespace</text>',
        '<text x="811" y="83" class="small">31 selected roles from 0 … 70</text>',
        '<text x="811" y="106" class="small">role 4, role 30, role 39, role 70</text>',
        '<text x="811" y="129" class="small">stage, phase and skip semantics follow role</text>',
    ]
    rows = [
        ('raw block2.layer0.layer', '22,720 B', 'role 4 · C32 tail', 'expected_size(role 4) = 22,720 B'),
        ('raw block10.layer4.layer', '524,304 B', 'role 30 · C512 down', '512 × 1024 down projection'),
        ('raw block19.layer0.layer', '525,312 B', 'role 39 · transition', '1024 → 512 up projection'),
        ('raw block30.layer0.layer', '21,808 B', 'role 70 · post', '+ separate blend_scale 2 B'),
    ]
    y = 177
    for index, (raw, size, role, check) in enumerate(rows):
        klass = 'tensor' if index % 2 == 0 else 'storage'
        parts.extend([
            f'<rect x="36" y="{y}" width="322" height="48" rx="7" class="{klass}"/>',
            f'<text x="52" y="{y + 20}" class="small">{raw}</text>',
            f'<text x="52" y="{y + 38}" class="small">{size}</text>',
            f'<path d="M358 {y + 24} H404" class="edge"/>',
            f'<rect x="414" y="{y}" width="292" height="48" rx="7" class="compute"/>',
            f'<text x="430" y="{y + 29}" class="label" style="font-size:15px">{role}</text>',
            f'<path d="M706 {y + 24} H752" class="edge"/>',
            f'<rect x="762" y="{y}" width="600" height="48" rx="7" class="tensor"/>',
            f'<text x="778" y="{y + 29}" class="small">{check}</text>',
        ])
        y += 58
    parts.extend([
        '<rect x="36" y="420" width="1326" height="42" rx="7" class="compute"/>',
        '<text x="52" y="446" class="small">Wrong legacy ordinal: HT block2 is 20,672 B, while Small block2 is 22,720 B and belongs to role 4. Equal byte lengths after mapping are a size check, not proof of equal trained values.</text>',
    ])
    return (
        '0 0 1400 486',
        ''.join(parts),
        'Raw Small record ids map to legacy operation roles before any size, stage or tensor lookup. Four examples show block2 to role4, block10.layer4 to role30, block19 to role39, and block30 plus its separate blend scalar to role70.',
        'The resource envelope, raw id and role are three different namespaces. The legacy block2 size is shown only to make the wrong ordinal mapping visible; it is not the Small record.',
    )


# ---------------------------------------------------------------------------
# Diagram 3: shifted window masks and one tracked token.

def _window_svg():
    panels = [
        _grid_panel(34, 64, 0, 0, 0, 0, ('input 0 + encoder', 'firsts 1, 5, 9, 15, 23')),
        _grid_panel(330, 64, 3, 1, 4, 4, ('encoder tails', '4, 8, 14, 22, 30')),
        _grid_panel(626, 64, 1, 2, 4, 0, ('decoder firsts', '40, 48, 56, 62, 66')),
        _grid_panel(922, 64, 2, 3, 0, 4, ('decoder lasts', '47, 55, 61, 65, 69')),
    ]
    parts = [
        '<text x="34" y="30" class="label">One token at (5, 5) in a 16 × 16 field; heavy lines are 8 × 8 window boundaries</text>',
        *panels,
        '<text x="34" y="338" class="small">Mask bits: bit0 = x, bit1 = y. Phase conversion: {0→0, 3→1, 1→2, 2→3}. The mask is the HIP host value; the phase is this project’s index.</text>',
        '<text x="34" y="362" class="small">Encoder tails 4, 8, 22, 30 move from legacy phase 3 / mask 2 to Small phase 1 / mask 3. Role 14 already used mask 3 / phase 1.</text>',
        '<text x="34" y="386" class="small">Decoder firsts 40, 48, 62, 66 move from legacy phase 0 / mask 0 to Small phase 2 / mask 1.</text>',
        '<text x="34" y="406" class="small">Role 56 already used mask 1 / phase 2 and must not be grouped with the legacy phase-0 decoder row.</text>',
        '<text x="34" y="430" class="small">Decoder lasts 47, 55, 61, 65, 69 keep mask 2 / phase 3. The post shift is host-controlled and is not proven by this rule.</text>',
    ]
    return (
        '0 0 1180 452',
        ''.join(parts),
        'Four shifted-window examples for one token: mask 0 and phase 0, mask 3 and phase 1, mask 1 and phase 2, mask 2 and phase 3. The tracked token moves to a different window and local coordinate as the mask changes. Each panel names the Small roles that actually use that mask and phase.',
        'The windows are a scaled logical example for phase reasoning; the model uses 8 × 8 windows. The masks are source-derived from the pinned HIP port, not observed in DLL host dispatch. Role 56 is already phase 2 in the legacy graph_schedule.',
    )


# ---------------------------------------------------------------------------
# Diagram 4: one token skip / downsample / upsample path.

def _token_path_svg():
    parts = [
        '<text x="30" y="30" class="label">Skip lane reads the published value; the compute lane reads the raw value</text>',
        '<rect x="30" y="58" width="250" height="78" rx="8" class="tensor"/>',
        '<text x="48" y="84" class="small">role 14 published</text>',
        '<text x="48" y="106" class="label" style="font-size:15px">[h, w, 128]</text>',
        '<text x="48" y="126" class="small">saved as the encoder skip</text>',
        '<path d="M280 97 H344" class="edge"/>',
        '<rect x="354" y="58" width="190" height="78" rx="8" class="storage"/>',
        '<text x="372" y="84" class="small">retained skip</text>',
        '<text x="372" y="106" class="label" style="font-size:15px">published</text>',
        '<text x="372" y="126" class="small">not the raw attention result</text>',
        '<path d="M544 97 H608" class="edge"/>',
        '<rect x="618" y="58" width="190" height="78" rx="8" class="compute"/>',
        '<text x="636" y="84" class="small">skip scale</text>',
        '<text x="636" y="106" class="label" style="font-size:15px">channelwise</text>',
        '<text x="636" y="126" class="small">learned multiplier</text>',
        '<rect x="30" y="258" width="250" height="90" rx="8" class="compute"/>',
        '<text x="48" y="284" class="small">role 14 raw</text>',
        '<text x="48" y="306" class="label" style="font-size:15px">[h, w, 128]</text>',
        '<text x="48" y="330" class="small">downsample path</text>',
        '<path d="M280 303 H344" class="edge"/>',
        '<rect x="354" y="258" width="190" height="90" rx="8" class="tensor"/>',
        '<text x="372" y="284" class="small">2 × 2 average</text>',
        '<text x="372" y="306" class="label" style="font-size:15px">[h/2, w/2, 128]</text>',
        '<text x="372" y="330" class="small">four source positions → one</text>',
        '<path d="M544 303 H608" class="edge"/>',
        '<rect x="618" y="258" width="190" height="90" rx="8" class="storage"/>',
        '<text x="636" y="284" class="small">role 15 projection</text>',
        '<text x="636" y="306" class="label" style="font-size:15px">C128 → C256</text>',
        '<text x="636" y="330" class="small">at each coarse position</text>',
        '<path d="M808 303 H872" class="edge"/>',
        '<rect x="882" y="258" width="250" height="90" rx="8" class="tensor"/>',
        '<text x="900" y="284" class="small">ViT 31–38 · transition 39</text>',
        '<text x="900" y="306" class="label" style="font-size:15px">decoder 40 … 55</text>',
        '<text x="900" y="330" class="small">coarse field and global context</text>',
        '<path d="M1132 303 H1196" class="edge"/>',
        '<rect x="1206" y="258" width="250" height="90" rx="8" class="compute"/>',
        '<text x="1224" y="284" class="small">role 56 up projection</text>',
        '<text x="1224" y="306" class="label" style="font-size:15px">C256 → C128</text>',
        '<text x="1224" y="330" class="small">2 × 2 repeat + crop</text>',
        '<path d="M1331 258 V230 H1000 V178" class="edge"/>',
        '<text x="1012" y="221" class="small" style="font-size:13px">upsampled C128 token</text>',
        '<rect x="890" y="100" width="220" height="78" rx="8" class="compute"/>',
        '<text x="908" y="126" class="small">merge at role 56</text>',
        '<text x="908" y="148" class="label" style="font-size:17px">+</text>',
        '<text x="908" y="168" class="small">scaled skip + upsampled</text>',
        '<path d="M808 97 H840 V139 H890" class="edge"/>',
        '<rect x="1120" y="100" width="250" height="78" rx="8" class="tensor"/>',
        '<text x="1138" y="126" class="small">role 56 body</text>',
        '<text x="1138" y="148" class="label" style="font-size:15px">FFN → attention</text>',
        '<text x="1138" y="168" class="small">merged tensor enters the block</text>',
        '<path d="M1110 139 H1120" class="edge"/>',
        '<text x="30" y="404" class="small">The skip is added, not concatenated. The coarse path is projected before repetition; cropping restores the target field.</text>',
        '<text x="30" y="428" class="small">This is a logical one-token path. It does not imply one kernel, one launch or a measured latency.</text>',
    ]
    return (
        '0 0 1500 448',
        ''.join(parts),
        'One tracked token forks at an encoder tail into a published skip lane and a raw compute lane. The compute lane averages 2 by 2 positions, projects C128 to C256, passes through the global bottleneck and decoder, then projects C256 to C128, repeats spatially and feeds the merge at role 56. The scaled skip is added to that upsampled path at role 56 before the block body.',
        'The diagram shows tensor-flow obligations only. Kernel fusion, storage placement and launch counts are separate decisions; the following binding and plan diagrams give the implemented Small record/plan census.',
    )


# ---------------------------------------------------------------------------
# Diagram 5: implemented Small trunk plan, pre/post, and record binding.

def _plan_svg():
    parts = [
        '<text x="28" y="28" class="label">One verified archive feeds a separate native trunk plan; pre and post stay outside it</text>',
        # archive
        '<rect x="24" y="46" width="318" height="150" rx="9" class="storage"/>',
        '<text x="43" y="76" class="label">WEIGHTS_CC_SMALL_FP8</text>',
        '<text x="43" y="101" class="small">77 records · 11 archive stages</text>',
        '<text x="43" y="123" class="small">113,887,490 payload bytes</text>',
        '<text x="43" y="145" class="small">raw ids 0 … 30 (role is mapped)</text>',
        '<text x="43" y="167" class="small">FP8 bytes are the original bytes</text>',
        '<text x="43" y="185" class="small">FP16 is repacked, never re-quantized</text>',
        # loader
        '<path d="M342 121 H382" class="edge"/>',
        '<rect x="392" y="46" width="300" height="150" rx="9" class="tensor"/>',
        '<text x="411" y="76" class="label">role-keyed loader</text>',
        '<text x="411" y="101" class="small">SmallNativeCheckpoint</text>',
        '<text x="411" y="123" class="small">66 compiled trunk records</text>',
        '<text x="411" y="145" class="small">FP8 original bytes / FP16 pack</text>',
        '<text x="411" y="167" class="small">pre + post records also available</text>',
        '<text x="411" y="185" class="small">explicit model selector</text>',
        # trunk
        '<path d="M692 121 H732" class="edge"/>',
        '<rect x="742" y="46" width="392" height="150" rx="9" class="compute"/>',
        '<text x="761" y="76" class="label">Small trunk plan (separate)</text>',
        '<text x="761" y="101" class="small">66 deployed records · 109 logical calls</text>',
        '<text x="761" y="123" class="small">76 compute/repack + 33 counter clears</text>',
        '<text x="761" y="145" class="small">34 boundaries · 34 unique kernels</text>',
        '<text x="761" y="167" class="small">156 FP8 buffers / 132 FP16 buffers</text>',
        '<text x="761" y="185" class="small">b1 … b69 · output buffer b69.output</text>',
        # pre/post
        '<path d="M1134 121 H1174" class="edge"/>',
        '<rect x="1184" y="46" width="292" height="150" rx="9" class="storage"/>',
        '<text x="1203" y="76" class="label">outside the trunk census</text>',
        '<text x="1203" y="101" class="small">pre raw0: 21,696 / 33,984 B</text>',
        '<text x="1203" y="123" class="small">post raw30: 21,808 / 34,096 B</text>',
        '<text x="1203" y="145" class="small">+ separate blend_scale (2 B)</text>',
        '<text x="1203" y="167" class="small">4 × 32 = 96 RGB + 32 gate</text>',
        '<text x="1203" y="185" class="small">frontend dispatch, not this plan</text>',
        # host ownership
        '<rect x="24" y="236" width="690" height="150" rx="9" class="tensor"/>',
        '<text x="43" y="266" class="label">Host ownership and guards</text>',
        '<text x="43" y="291" class="small">plan owns the input and every packed record</text>',
        '<text x="43" y="313" class="small">155 FP8 / 131 FP16 guarded workspace backings</text>',
        '<text x="43" y="335" class="small">256-byte 0xA5 guards before and after each workspace</text>',
        '<text x="43" y="357" class="small">input/record storage must be disjoint and 16-byte aligned</text>',
        '<text x="43" y="377" class="small">current stream captured, graph-capture creation rejected</text>',
        # census / split
        '<rect x="742" y="236" width="734" height="150" rx="9" class="compute"/>',
        '<text x="761" y="266" class="label">Logical calls are not physical launch counts</text>',
        '<text x="761" y="291" class="small">SplitLaunchCount may turn one logical call into N physical launches</text>',
        '<text x="761" y="313" class="small">ordered split offset is validated against the ABI parameter block</text>',
        '<text x="761" y="335" class="small">the plan caches device/grid admission before capture</text>',
        '<text x="761" y="357" class="small">109 / 66 / 34 / 156 / 132 are schedule facts, not speed claims</text>',
        '<text x="761" y="377" class="small">legacy stays 185 calls / 142 records / 74 boundaries</text>',
        # record binding
        '<rect x="24" y="416" width="1452" height="70" rx="9" class="storage"/>',
        '<text x="43" y="444" class="label">Record binding is positional</text>',
        '<text x="43" y="466" class="small">The caller passes the 66 packed records in the generated SmallRecordSpecs order; buffer index 0 is the trunk input, and every subsequent index is a generated role-named buffer.</text>',
        '<text x="43" y="484" class="small">A missing, duplicate, reordered, legacy-roster or wrong-sized record is rejected before plan creation. The generated tables never include pre raw0 or post raw30.</text>',
    ]
    return (
        '0 0 1500 506',
        ''.join(parts),
        'Implemented Small31 native plan flow: one verified 77-record archive is read by a role-keyed loader that passes 66 compiled trunk records to a separate plan of 109 logical calls, 34 boundaries and 156 FP8 or 132 FP16 buffers. Pre raw0 and post raw30 plus its blend scalar stay outside the trunk. The host owns the input and guarded workspaces; a logical call may split into multiple physical launches.',
        'Counts come from the generated plan and the independent static audit, not a GPU timing run. The SM120 extension was built, linked and imported in a fresh process, and both models executed real RGB fixtures; the counts remain schedule facts, not performance results.',
    )


# ---------------------------------------------------------------------------
# Diagram 6: one tracked token across record binding and precision boundaries.

def _binding_svg():
    parts = [
        '<text x="24" y="28" class="label">One tracked token: raw ids, operation roles, record positions, buffers and precision boundaries</text>',
        # pre source
        '<rect x="24" y="56" width="360" height="120" rx="9" class="storage"/>',
        '<text x="43" y="84" class="label">pre · raw0 / role0</text>',
        '<text x="43" y="107" class="small">block0.layer0.layer · outside trunk</text>',
        '<text x="43" y="128" class="small">FP8 21,696 B / FP16 33,984 B</text>',
        '<text x="43" y="149" class="small">existing frontend preprocess</text>',
        '<text x="43" y="168" class="small">→ caller feature state</text>',
        '<path d="M384 116 H416" class="edge"/>',
        # trunk input
        '<rect x="416" y="56" width="700" height="70" rx="9" class="tensor"/>',
        '<text x="435" y="82" class="label">trunk input · buffer index 0</text>',
        '<text x="435" y="104" class="small">caller-prepared feature state; FP8 or FP16 plan input, never a weight record</text>',
        # binding rows
        '<text x="416" y="145" class="small">positional record binding (generated SmallRecordSpecs order)</text>',
    ]
    rows = [
        ('record[0]', 'raw1 / role1', 'block1.layer0.layer', 'b1.output'),
        ('record[12]', 'raw10 / role30', 'block10.layer0.layer', 'b30.*'),
        ('record[49]', 'raw19 / role39', 'block19.layer0.layer', 'b39.* · residual b30.output'),
        ('record[65]', 'raw29 / role69', 'block29.layer0.layer', 'b69.output'),
    ]
    y = 158
    token_points = []
    for index, (record, role, name, buffers) in enumerate(rows):
        klass = 'tensor' if index % 2 == 0 else 'storage'
        parts.extend([
            f'<rect x="416" y="{y}" width="700" height="48" rx="7" class="{klass}"/>',
            f'<text x="432" y="{y + 20}" class="small" style="font-size:12px">{record}</text>',
            f'<text x="520" y="{y + 20}" class="small" style="font-size:12px">{role}</text>',
            f'<text x="650" y="{y + 20}" class="small" style="font-size:12px">{name}</text>',
            f'<text x="848" y="{y + 20}" class="small" style="font-size:12px">→ {buffers}</text>',
            f'<text x="432" y="{y + 39}" class="small" style="font-size:11px">role-mapped size checked; buffer is role-named</text>',
        ])
        token_points.append((1096, y + 24))
        y += 56
    # one tracked token through the binding rows
    parts.append(f'<path d="M1096 126 V{token_points[-1][1]}" class="edge"/>')
    for cx, cy in token_points:
        parts.append(f'<circle cx="{cx}" cy="{cy}" r="5" fill="#a55128" stroke="#fff" stroke-width="2"/>')
    parts.append('<text x="1084" y="120" text-anchor="end" class="small" style="font-size:11px">tracked token</text>')
    # boundaries / output
    parts.extend([
        '<rect x="416" y="390" width="700" height="54" rx="9" class="compute"/>',
        '<text x="435" y="414" class="label">34 boundaries · final output b69.output</text>',
        '<text x="435" y="434" class="small">high output of every retained role plus the five downsample tails</text>',
        f'<path d="M1096 {token_points[-1][1]} V390" class="edge"/>',
        '<path d="M416 417 H384" class="edge"/>',
        # post source
        '<rect x="24" y="382" width="360" height="120" rx="9" class="storage"/>',
        '<text x="43" y="410" class="label">post · raw30 / role70</text>',
        '<text x="43" y="433" class="small">block30.layer0.layer + blend_scale 2 B</text>',
        '<text x="43" y="454" class="small">FP8 21,808 B / FP16 34,096 B</text>',
        '<text x="43" y="475" class="small">existing postprocess → 4 × 32 head</text>',
        '<text x="43" y="494" class="small">96 RGB + 32-high history gate</text>',
    ])
    # precision ladder
    ladder = [
        ('archive storage', 'FP8 = original E4M3 bytes', 'FP16 = lossless repack; no re-quantize', 'storage'),
        ('native plan · FP8/FP16', 'most kernels reused; 2 Small attention variants', 'one logical call may split into N launches', 'compute'),
        ('PyTorch surrogate · FP32/BF16', 'FP32 master weights', 'FP32 or BF16 working arithmetic', 'tensor'),
        ('post head · float', 'float 4 × 32 = 128 logical values', 'RGB residual + history gate', 'compute'),
    ]
    y = 56
    for title, line1, line2, klass in ladder:
        parts.extend([
            f'<rect x="1140" y="{y}" width="336" height="100" rx="9" class="{klass}"/>',
            f'<text x="1158" y="{y + 28}" class="label" style="font-size:15px">{title}</text>',
            f'<text x="1158" y="{y + 54}" class="small" style="font-size:12px">{line1}</text>',
            f'<text x="1158" y="{y + 76}" class="small" style="font-size:12px">{line2}</text>',
        ])
        y += 112
    parts.extend([
        '<text x="1140" y="512" class="small" style="font-size:12px">Native vs PyTorch: alternatives, not stages</text>',
        '<text x="24" y="536" class="small">raw id ≠ operation role ≠ record position. A raw id names a DLL record, a role names the operation, and record[i] is a generated 66-entry position.</text>',
        '<text x="24" y="558" class="small">Pre and post are outside the 109 trunk calls. A logical value is not a kernel or a measured latency; native and PyTorch are alternatives, not stages.</text>',
    ])
    return (
        '0 0 1500 580',
        ''.join(parts),
        'One tracked token crosses the Small31 pipeline: pre raw0/role0 is outside the trunk; the trunk input is buffer index 0; four positional record bindings show raw1/role1 to b1.output, raw10/role30 to b30 buffers, raw19/role39 to b39 with the b30 residual, and raw29/role69 to b69.output; post raw30/role70 plus its blend scalar is outside the trunk and produces the four-channel 4x32 head. A right-hand ladder labels archive FP8/FP16 storage, the native FP8/FP16 and PyTorch FP32/BF16 alternative execution routes, and the float post head; native and PyTorch are alternatives, not sequential stages.',
        'Raw ids, operation roles and record positions are three different namespaces. A logical call may become multiple physical split launches; the diagram makes no timing or speed claim, and pre/post are outside the 109-call trunk census.',
    )


# ---------------------------------------------------------------------------
# Diagram 7: evidence provenance and the boundary of this chapter.

def _validation_svg():
    parts = [
        '<text x="30" y="26" class="label">Direct byte verification</text>',
        '<rect x="24" y="42" width="330" height="112" rx="9" class="storage"/>',
        '<text x="43" y="72" class="label">original 310.9.16 DLL</text>',
        '<text x="43" y="98" class="small">SHA-256 2bc19bc0…d28789f</text>',
        '<text x="43" y="120" class="small">266,424,944 B · hashed, not loaded</text>',
        '<text x="43" y="142" class="small">community patched DLL is not accepted</text>',
        '<path d="M354 98 H388" class="edge"/>',
        '<rect x="398" y="42" width="300" height="112" rx="9" class="tensor"/>',
        '<text x="417" y="72" class="label">WEIGHTS_HT</text>',
        '<text x="417" y="98" class="small">147,695,410 B · 153 records</text>',
        '<text x="417" y="120" class="small">836f445d…d548f4</text>',
        '<text x="417" y="142" class="small">153/153 byte-identical to 310.8</text>',
        '<rect x="730" y="42" width="330" height="112" rx="9" class="tensor"/>',
        '<text x="749" y="72" class="label">WEIGHTS_CC_SMALL_FP8</text>',
        '<text x="749" y="98" class="small">113,893,343 B · 77 records</text>',
        '<text x="749" y="120" class="small">f743e8eb…ef7962</text>',
        '<text x="749" y="142" class="small">0/77 payloads match mapped old</text>',
        '<path d="M895 154 V186" class="edge"/>',
        '<rect x="730" y="196" width="330" height="86" rx="9" class="compute"/>',
        '<text x="749" y="226" class="label">role map + archive stages</text>',
        '<text x="749" y="250" class="small">raw id → role → stage → byte length</text>',
        '<text x="749" y="270" class="small">19/31 role ids shape/order-derived</text>',
        '<path d="M895 282 V312" class="edge"/>',
        '<rect x="730" y="322" width="330" height="92" rx="9" class="tensor"/>',
        '<text x="749" y="350" class="label">executed reconstruction checks</text>',
        '<text x="749" y="374" class="small">PyTorch SM120 self-consistency</text>',
        '<text x="749" y="394" class="small">CPU identity/extraction/offset tests</text>',
        '<path d="M1060 368 H1094" class="edge"/>',
        '<rect x="1104" y="322" width="270" height="92" rx="9" class="storage"/>',
        '<text x="1123" y="350" class="label">native implementation</text>',
        '<text x="1123" y="374" class="small">built + imported · fresh process</text>',
        '<text x="1123" y="394" class="small">real RGB 8/8 · capture 4/4</text>',
        '<text x="30" y="196" class="label">Source inference, not host dispatch</text>',
        '<rect x="24" y="212" width="330" height="112" rx="9" class="storage"/>',
        '<text x="43" y="242" class="label">HIP port fe3f91a2</text>',
        '<text x="43" y="268" class="small">shift masks · decoder rule</text>',
        '<text x="43" y="290" class="small">geometry / ViT dispatch · post head</text>',
        '<text x="43" y="312" class="small">no vendor host descriptor observed</text>',
        '<path d="M354 268 H730" class="edge" stroke-dasharray="7 5"/>',
        '<text x="448" y="258" class="small">source-derived claims</text>',
        '<text x="30" y="452" class="label">Historical evidence, kept separate</text>',
        '<rect x="24" y="468" width="390" height="90" rx="9" class="storage"/>',
        '<text x="43" y="498" class="label">310.8 NCU run 8dc554</text>',
        '<text x="43" y="522" class="small">81 entries · 56 bodies · 40 templates</text>',
        '<text x="43" y="544" class="small">81 pinned reports; Small replay separate</text>',
        '<path d="M414 513 H448" class="edge"/>',
        '<rect x="458" y="468" width="330" height="90" rx="9" class="tensor"/>',
        '<text x="477" y="498" class="label">legacy 81 lessons unchanged</text>',
        '<text x="477" y="522" class="small">operator layout may be reused</text>',
        '<text x="477" y="544" class="small">performance is not transferred</text>',
        '<rect x="818" y="468" width="556" height="90" rx="9" class="compute"/>',
        '<text x="837" y="498" class="label">Remaining vendor gaps</text>',
        '<text x="837" y="522" class="small">DLL host descriptor · numerical parity · FP16 FFN oracle</text>',
        '<text x="837" y="544" class="small">isolated replay separate · eager timing: comparison chapter</text>',
    ]
    return (
        '0 0 1400 580',
        ''.join(parts),
        'Evidence provenance graph: byte-verified DLL and resource identities feed the role-mapped Small graph; executed PyTorch and CPU checks are separate from HIP source inference; the native plan was statically audited, built, imported, registered and executed on real RGB fixtures; historical 310.8 NCU evidence stays separate, as does the isolated Small replay for the two attention calls; the remaining vendor host descriptor, numerical parity and FP16 FFN oracle gaps are listed explicitly, with accepted eager timing in the separate comparison chapter.',
        'The graph assigns evidence classes rather than blending them. A byte identity does not validate a phase, a CPU test does not validate a vendor result, and a successful native RGB run does not establish DLL numerical parity or a network timing.',
    )


# ---------------------------------------------------------------------------
# Forward-design contract 1: the TILE4 producer and PLANE16 postconsumer are
# two different address functions for the same token and the same byte extent.

def _layout_contract_svg():
    parts = [
        '<text x="30" y="30" class="label">Same token, dtype, byte extent and guards — two different address functions</text>',
        '<text x="30" y="58" class="small" style="font-size:13px">A_TILE4(p,y,x,q,s) = tile*1024 + chunk*512 + lane*16 + 4*word + s</text>',
        '<text x="30" y="80" class="small" style="font-size:13px">A_PLANE16(p,y,x,q,s) = ((p*H0 + y)*W0 + x)*16 + 4*q + s</text>',
        # producer
        '<rect x="30" y="104" width="600" height="238" rx="9" class="storage"/>',
        '<text x="50" y="134" class="label" style="font-size:16px">Producer · TILE4 · FP16 plane 0</text>',
        '<text x="50" y="158" class="small">x=1, y=0 → tx=0, ty=0, ix=1, iy=0</text>',
        '<text x="50" y="180" class="small">tile 0 · chunk 0 · lane=q+4 · word 0</text>',
        '<text x="50" y="216" class="small" style="font-size:12px">one 1,024-byte tile holds 4×4 pixels;</text>',
        '<text x="50" y="236" class="small" style="font-size:12px">the four words sit in four lane slots</text>',
    ]
    tile_offsets = [64, 80, 96, 112]
    plane_offsets = [16, 20, 24, 28]
    for index, (tile_byte, plane_byte) in enumerate(zip(tile_offsets, plane_offsets)):
        px = 50 + index * 140
        parts.extend([
            f'<rect x="{px}" y="258" width="124" height="54" rx="6" class="compute"/>',
            f'<text x="{px + 62}" y="278" text-anchor="middle" class="small">q={index} · lane {4 + index}</text>',
            f'<text x="{px + 62}" y="300" text-anchor="middle" class="label" style="font-size:16px">byte {tile_byte}</text>',
        ])
    # consumer
    parts.extend([
        '<rect x="690" y="104" width="600" height="238" rx="9" class="tensor"/>',
        '<text x="710" y="134" class="label" style="font-size:16px">Postconsumer · PLANE16 · FP16 plane 0</text>',
        '<text x="710" y="158" class="small">plane 0 · pixel (1,0) → group byte 16</text>',
        '<text x="710" y="180" class="small">group 16..31 · four consecutive words</text>',
        '<text x="710" y="216" class="small" style="font-size:12px">one 16-byte group per (plane, pixel);</text>',
        '<text x="710" y="236" class="small" style="font-size:12px">the four words are +0, +4, +8, +12</text>',
    ])
    for index, plane_byte in enumerate(plane_offsets):
        px = 710 + index * 140
        parts.extend([
            f'<rect x="{px}" y="258" width="124" height="54" rx="6" class="compute"/>',
            f'<text x="{px + 62}" y="278" text-anchor="middle" class="small">q={index} · word {index}</text>',
            f'<text x="{px + 62}" y="300" text-anchor="middle" class="label" style="font-size:16px">byte {plane_byte}</text>',
        ])
        # Producer slot index i maps to consumer word index i (same logical word q).
        sx = 50 + index * 140 + 62
        dx = 710 + index * 140 + 62
        color = ('#247666', '#5a6fa4', '#a57425', '#a95847')[index]
        bend = 342 + 9 * index
        parts.append(
            f'<path d="M{sx} 312 V{bend} H{dx} V312" fill="none" stroke="{color}" stroke-width="2"/>'
            f'<polygon points="{dx},312 {dx-5},322 {dx+5},322" fill="{color}"/>'
        )
    parts.extend([
        '<text x="360" y="384" text-anchor="middle" class="small" style="font-size:12px">q0→q0 · q1→q1 · q2→q2 · q3→q3</text>',
        '<text x="900" y="384" text-anchor="middle" class="small" style="font-size:12px">four separate word paths, four different byte offsets</text>',
        # guard band
        '<rect x="30" y="392" width="1260" height="52" rx="7" class="storage"/>',
        '<rect x="30" y="392" width="56" height="52" rx="7" fill="#d9a441" stroke="#8a6520" stroke-width="1"/>',
        '<rect x="1234" y="392" width="56" height="52" rx="7" fill="#d9a441" stroke="#8a6520" stroke-width="1"/>',
        '<text x="58" y="423" text-anchor="middle" class="small" style="font-size:11px">0xA5</text>',
        '<text x="1262" y="423" text-anchor="middle" class="small" style="font-size:11px">0xA5</text>',
        '<text x="660" y="414" text-anchor="middle" class="small">same FP16 dtype · same logical tensor · same allocation byte extent · guards intact</text>',
        '<text x="660" y="434" text-anchor="middle" class="small">A size or guard check cannot prove that the post reads the token the producer wrote.</text>',
        # accepted fix
        '<rect x="30" y="466" width="1260" height="86" rx="9" class="compute"/>',
        '<text x="50" y="494" class="label" style="font-size:16px">Accepted RGB path: final phase-3 C32 descriptor → EXISTING output view</text>',
        '<text x="50" y="518" class="small">same b69 allocation · 0 added calls · 0 repack · no smoothing/filter/math change · plan.run_* stays TILE4</text>',
        '<text x="50" y="540" class="small">8/8 accepted cases byte-exact against the independent TILE4→PLANE16 permutation; zero differing bytes.</text>',
        # footer
        '<text x="30" y="586" class="small">Worked trace and formulas: docs-rgb-design/layout/results.json (<tspan style="font-family:ui-monospace,Consolas,monospace">worked_fp16_token_p0_y0_x1</tspan>) and layout/draft.md §2.3–3.2.</text>',
        '<text x="30" y="608" class="small">The phase-3 (0,−4) origin shifts CTA coverage/guard tiles; it does not change the logical address function.</text>',
    ])
    return (
        '0 0 1320 626',
        ''.join(parts),
        'Address-contract diagram: the TILE4 producer places the four FP16 words of logical token x=1, y=0, plane 0 at bytes 64, 80, 96 and 112, while the PLANE16 postconsumer reads the same four words at bytes 16, 20, 24 and 28. Rows show the two exact address formulas, the same guarded 1,024-byte extent, and the accepted phase-3 final-descriptor replacement that reuses the existing output view and b69 allocation without a repack or extra call.',
        'Same dtype, size and guards are insufficient because the two sides implement different address functions. The accepted fix changes only the final RGB publication descriptor; the ordinary plan.run path remains TILE4, and the phase-3 substitution was byte-exact in 8 of 8 accepted cases.',
    )


# ---------------------------------------------------------------------------
# Forward-design contract 2: the normalized output may be finite while an
# unnormalized numerator prefix is not Half-representable.  FP32 accumulation
# is the contract; one Half round (and the native FP8 publication) follow it.

def _numerics_svg():
    parts = [
        '<text x="30" y="30" class="label">Warp-distributed state: 64 FP32 numerators and 2 FP32 denominator sums per lane</text>',
        # numerator lane
        '<rect x="30" y="58" width="380" height="250" rx="9" class="storage"/>',
        '<text x="50" y="86" class="label" style="font-size:16px">Numerator · persistent FP32</text>',
        '<rect x="50" y="104" width="340" height="48" rx="6" class="tensor"/>',
        '<text x="220" y="124" text-anchor="middle" class="small">E = native Half exponent surrogate</text>',
        '<text x="220" y="144" text-anchor="middle" class="small" style="font-size:12px">FP16: P=E · FP8: P=E4M3(E)</text>',
        '<path d="M220 152 V176" class="edge"/>',
        '<rect x="50" y="176" width="340" height="48" rx="6" class="compute"/>',
        '<text x="220" y="198" text-anchor="middle" class="small">PV MMA · MmaHalfF32 / MmaE4F32</text>',
        '<text x="220" y="216" text-anchor="middle" class="small" style="font-size:11px">D registers are FP32</text>',
        '<path d="M220 224 V248" class="edge"/>',
        '<rect x="50" y="248" width="340" height="48" rx="6" class="compute"/>',
        '<text x="220" y="270" text-anchor="middle" class="small">r_Output[4][4][4] = 64 FP32 / lane</text>',
        '<text x="220" y="288" text-anchor="middle" class="small" style="font-size:11px">64 FP32 values persist across key tiles</text>',
        # denominator lane
        '<rect x="470" y="58" width="380" height="250" rx="9" class="storage"/>',
        '<text x="490" y="86" class="label" style="font-size:16px">Denominator · persistent FP32</text>',
        '<rect x="490" y="104" width="340" height="48" rx="6" class="tensor"/>',
        '<text x="660" y="134" text-anchor="middle" class="small">original packed Half E terms</text>',
        '<path d="M660 152 V176" class="edge"/>',
        '<rect x="490" y="176" width="340" height="48" rx="6" class="compute"/>',
        '<text x="660" y="198" text-anchor="middle" class="small">WidenHalfPairFloat2 → 2 × FP32</text>',
        '<text x="660" y="216" text-anchor="middle" class="small" style="font-size:11px">no Half addition before the row sum</text>',
        '<path d="M660 224 V248" class="edge"/>',
        '<rect x="490" y="248" width="340" height="48" rx="6" class="compute"/>',
        '<text x="660" y="270" text-anchor="middle" class="small">local tree → warp transpose → carry</text>',
        '<text x="660" y="288" text-anchor="middle" class="small" style="font-size:11px">r_Denominator[2] = 2 FP32 / lane</text>',
        # normalize / publish
        '<rect x="910" y="58" width="380" height="250" rx="9" class="compute"/>',
        '<text x="930" y="86" class="label" style="font-size:16px">One FP32 normalization, one Half round</text>',
        '<text x="930" y="116" class="small">1 · ClampDenominatorFloat</text>',
        '<text x="930" y="140" class="small">2 · ApproxRcp in FP32</text>',
        '<text x="930" y="164" class="small">3 · 64 × FP32 normalize</text>',
        '<text x="930" y="188" class="small">4 · PackFloatColumnsHalf2</text>',
        '<text x="930" y="212" class="small" style="font-size:11px">the single Half rounding of the result</text>',
        '<text x="930" y="242" class="small">5 · FP16 publish</text>',
        '<text x="930" y="266" class="small">6 · FP8: unchanged Half→E4M3 contract</text>',
        '<text x="930" y="290" class="small" style="font-size:11px">no second accumulation, no smoothing</text>',
        # bound band
        '<rect x="30" y="330" width="1260" height="58" rx="8" class="storage"/>',
        '<text x="50" y="354" class="label" style="font-size:15px">Why the prefix bound is not N · max|V|</text>',
        '<text x="50" y="376" class="small">|u| ≤ N · Emax · max|V|, Emax = 1.640625 &gt; 1; 2160 × 1.640625 × 223.625 = 792,471.09375 (conservative, not observed).</text>',
        # fixture band
        '<rect x="30" y="402" width="1260" height="58" rx="8" class="tensor"/>',
        '<text x="50" y="426" class="label" style="font-size:15px">Accepted synthetic cancellation fixture (FP16, 2,160 keys)</text>',
        '<text x="50" y="448" class="small">reference prefix 396,900 &gt; 65,504; final published 0; FP32 holds; 32,768/32,768 sampled publications exact; 2,228,224-element census finite.</text>',
        # compiler band
        '<rect x="30" y="474" width="614" height="88" rx="8" class="compute"/>',
        '<text x="50" y="500" class="label" style="font-size:15px">FP16 compiler row</text>',
        '<text x="50" y="524" class="small">208 registers · 16,400 B shared · 24 B stack</text>',
        '<text x="50" y="546" class="small">44 B spill stores · 56 B spill loads</text>',
        '<rect x="676" y="474" width="614" height="88" rx="8" class="compute"/>',
        '<text x="696" y="500" class="label" style="font-size:15px">FP8 compiler row</text>',
        '<text x="696" y="524" class="small">195 registers · 8,208 B shared · 0 B stack</text>',
        '<text x="696" y="546" class="small">0 B spill stores · 0 B spill loads</text>',
        # caveats
        '<text x="30" y="588" class="small">CUDA occupancy API: capacity 2 CTAs/SM, not achieved occupancy. Actual launch: 128 threads; function maximum: 256.</text>',
        '<text x="30" y="610" class="small">These are resource facts, not timings. QK stays Half; the native exponent surrogate, masks, quantization, graph and weights are preserved.</text>',
        '<text x="30" y="632" class="small">The plan selects these two variants at the eight Small global blocks; the original kernel implementations and legacy plan remain unchanged.</text>',
    ]
    return (
        '0 0 1320 650',
        ''.join(parts),
        'Numerics-contract diagram: per lane, the PV MMA accumulates 64 FP32 numerators and the packed Half probabilities widen to two FP32 row sums before every addition; both persist across key tiles in FP32. After the last key tile, one FP32 clamp/reciprocal and normalization is rounded once to Half, followed by the native E4M3 contract for FP8. The diagram also shows the Emax bound, the accepted cancellation fixture, the FP16/FP8 compiler resource rows, and the distinction between 2-CTA capacity and achieved occupancy.',
        'The contract is on the unnormalized prefix, not the normalized output. QK, the exponent surrogate, masks, quantization and weights stay native; only P·V and the row denominator widen to FP32. Resource capacity is not presented as occupancy or as a timing.',
    )


# ---------------------------------------------------------------------------
# Code excerpts. Ranges are exact for the current working tree; the build
# verifies every excerpt and every file attribution.

C_ROLE_MAP = code('dlssnr/model_specs.py', 165, 180,
                  'Raw DLL ids and operation roles are explicit bijections, never positional guesses')
C_RAW_ROSTER = code('dlssnr/model_specs.py', 478, 496,
                    'The 31 raw ids and 11 archive stages are a separate namespace from roles')
C_PHASE_SOURCE = code('dlssnr/model_specs.py', 498, 502,
                      'Phase provenance names the HIP source and marks host dispatch unverified')
C_PHASES = code('dlssnr/model_specs.py', 520, 536,
                'Phase mapping is source-derived and carries provenance per role')
C_CANONICAL_OFFSETS = code('dlssnr/model_specs.py', 215, 233,
                           'Canonical record offsets are derived from the immutable roster')
C_MANIFEST_OFFSETS = code('dlssnr/runtime_assets.py', 604, 619,
                          'A complete manifest must match every canonical packed offset')
C_SCHEDULE = code('dlssnr/small_model.py', 571, 649,
                  'The explicit schedule visits every operation role once')
C_NATIVE_HEAD = code('dlssnr/small_model.py', 48, 84,
                     'The native 16×32 scatter decodes to the logical 4×32 head')
C_POST_SPEC = code('dlssnr/model_specs.py', 560, 579,
                   'PostHeadSpec records four logical rows including the history gate')
C_COMPAT = code('dlssnr/small_model.py', 654, 675,
                'Checkpoint identity is canonical; local manifest provenance is excluded')
C_COMPOSE = code('dlssnr/model.py', 331, 341,
                 'Composition uses the RGB residual plus the history gate and blend scalar')
C_EXTRACT = code('tools/extract_runtime_assets.py', 27, 46,
                 'Extraction requires an explicit model identity and a fresh output path')
C_RECORD_PROVIDER = code('dlssnr/small_deployment.py', 291, 321,
                         'FP8 returns original archive bytes; FP16 repacks through the shared packer')
C_PLAN_RECORDS = code('dlssnr/small_deployment.py', 349, 376,
                      'Each precision validates every compiled record name, order and size')
C_NATIVE_SELECTOR = code('dlssnr/small_deployment.py', 393, 433,
                         'The explicit selector defaults to legacy71 and never infers a model')
C_HOST_OWNERSHIP = code('csrc/kernel_launcher/small_deployment.cpp', 128, 175,
                        'Host ownership, guarded workspaces, the 109-call census and split admission')
C_PLAN_TABLE = code('csrc/kernel_launcher/small_plan_generated.inl', 161, 178,
                    'Generated FP8 trunk record table (start of the positional 66-record roster)')
C_REGISTRATION = code('csrc/torch_api/small_extension.cpp', 7, 24,
                      'Separate Small31 ops and creators are registered explicitly')
C_RGB_FINAL = code('dlssnr/video.py', 493, 545,
                   'The RGB path replaces only the final phase-3 C32 descriptor with the existing output view')
C_ATTN_ACC = code('csrc/kernel_impl/small_c1024_attention/fp16/small_global_attention_chained_c1024_fp16.cu', 143, 147,
                  'Persistent FP32 numerator and two FP32 row denominators per lane')
C_ATTN_INTRINSICS = code('csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh', 11, 41,
                         'The PV MMA accumulates into four FP32 D registers for both precisions')
C_ATTN_WIDEN = code('csrc/kernel_impl/small_c1024_attention/common/intrinsics.cuh', 63, 70,
                    'Every packed Half probability term widens before its first FP32 addition')
C_ATTN_NORM = code('csrc/kernel_impl/small_c1024_attention/fp16/small_global_attention_chained_c1024_fp16.cu', 318, 337,
                   'FP32 normalization, then one packed-Half rounding, then native publication')
C_ATTN_FP8_PUB = code('csrc/kernel_impl/small_c1024_attention/fp8/small_global_attention_chained_c1024_fp8.cu', 313, 331,
                      'FP8 normalizes in FP32, rounds once to Half, then uses the unchanged Half-to-E4M3 contract')


def _figure(parts):
    viewbox, inner, title, desc = parts
    return diagram(title, desc, viewbox, inner)


FIGURE_ROLES = _figure(_two_row_svg())
FIGURE_IDENTITY = _figure(_identity_svg())
FIGURE_WINDOW = _figure(_window_svg())
FIGURE_TOKEN = _figure(_token_path_svg())
FIGURE_BINDING = _figure(_binding_svg())
FIGURE_PLAN = _figure(_plan_svg())
FIGURE_VALIDATION = _figure(_validation_svg())
FIGURE_LAYOUT_CONTRACT = _figure(_layout_contract_svg())
FIGURE_NUMERICS = _figure(_numerics_svg())


BODY = f"""
<aside class="note"><strong>Snapshot: {AS_OF}.</strong> This chapter separates four evidence classes. <strong>Direct byte verification</strong> means a hash, length or payload comparison was recomputed from the original 310.9.16 DLL. <strong>Source inference</strong> means behavior was reconstructed from the pinned HIP port and has not been observed in a running vendor host. <strong>Executed reconstruction check</strong> means a CPU or PyTorch test actually ran, including a PyTorch GPU self-consistency run. <strong>Native accepted</strong> means the SM120 extension was built, linked, imported, registered and executed on real RGB fixtures for both models and both precisions. The vendor host descriptor/numerical parity remains open and is not established by NCU or by the measured timings. Eager network timings in three separate scopes and the character comparison are published in the <a href="cyberpunk-comparison.html">accepted Cyberpunk comparison chapter</a>; the two attention lessons carry a separate isolated NCU replay of one call each. No call count on this page is a timing claim.</aside>
{provenance_note()}
<h2 id="what-changed">1. What the 310.9.16 update actually changed</h2>
<p>The update is not in upstream <a href="https://github.com/Blinue/Magpie/releases/tag/v0.13.0">Blinue/Magpie v0.13.0</a> (released 2026-10-17, commit <a href="https://github.com/Blinue/Magpie/tree/1a6f6c60cbd448b0e303e704f1225f0a4f3254ce"><code>1a6f6c60</code></a>). At that pinned tree there is no DLSS path and no <code>nvngx</code> asset. The runtime work is in the experimental fork <a href="https://github.com/SAOG0721/Magpie/releases/tag/v0.6.11-experimental">SAOG0721/Magpie v0.6.11-experimental</a> (2026-10-23, commit <a href="https://github.com/SAOG0721/Magpie/commit/4fc74a196993c883ce2f01e96e8ed8d81f1490e6"><code>4fc74a19</code></a>). The fork's v0.6.10 package was updated on 2026-10-16 to carry 310.9.16; v0.6.11 is a prerelease snapshot as of {AS_OF}, not a claim about later releases.</p>
<p>Two different DLLs matter. The <strong>original signed</strong> runtime is what a static resource parse can identify and what this project accepts as a provenance pin. The <strong>community-patched</strong> runtime is what the fork bundles for RTX 20/30/40; its code has been lowered, and it is not the original artifact. The local execution pin for the existing 71-block path remains the 310.8.0.0 original <code>e16bcf15…6e1fc8e</code> (165,840,496 B).</p>
<div class="table-scroll"><table><thead><tr><th>Artifact</th><th>Bytes</th><th>SHA-256</th><th>Role in this documentation</th></tr></thead><tbody>
<tr><td>Original signed 310.9.16.0 <code>nvngx_dlssnr.dll</code></td><td>266,424,944</td><td><code>2bc19bc09a7b89dd44f73e2ac0108fcc586e2154bdd0830f242f4f040e28789f</code></td><td>Accepted provenance pin; statically parsed, never loaded or executed.</td></tr>
<tr><td>SAOG community-patched 310.9.16.0 DLL</td><td>276,162,560</td><td><code>A8A237A967469C455A84654932B513AB656FBAA1E0C44504B1E1BF0890F902B8</code></td><td>Bundled by the fork for RTX 20/30/40; not accepted by the extractor and not runtime-logged here.</td></tr>
<tr><td><code>DLSSNR-DLL-Options.zip</code> v0.6.10/v0.6.11</td><td>379,128,973</td><td><code>1f900df1063e3ffca632220e7f1830ab0b22ea56aac629ad9e858c3a13115ec1</code></td><td>Published container for both DLL choices; not a standalone original-DLL asset.</td></tr>
<tr><td>Original 310.8.0.0 <code>nvngx_dlssnr.dll</code></td><td>165,840,496</td><td><code>e16bcf15e16e13f527491cdf7845b2fe6521a738d8f7c9c721866a8496e1fc8e</code></td><td>Local execution pin for the 71-block path; not replaced by this update.</td></tr>
</tbody></table></div>
<p>The original 310.9.16 DLL contains two packed weight resources. Both identities were recomputed from the downloaded original file; the numbers below are direct byte verification, not prefixes copied from an issue comment.</p>
<div class="table-scroll"><table><thead><tr><th>Resource</th><th>Bytes</th><th>Records</th><th>Payload</th><th>SHA-256</th><th>Classification</th></tr></thead><tbody>
<tr><td><code>10/WEIGHTS_HT/1033</code></td><td>147,695,410</td><td>153</td><td>147,683,778</td><td><code>836f445d06ecd2e59bb9f17b84b91c143396fd76ccda1c9dc7fe81d5edd548f4</code></td><td>Whole envelope byte-identical to the local 310.8.0.0 resource; all 153/153 records match.</td></tr>
<tr><td><code>10/WEIGHTS_CC_SMALL_FP8/1033</code></td><td>113,893,343</td><td>77</td><td>113,887,490</td><td><code>f743e8eb320f42bc9bdc992ee2bf51f7bb7c8688ced4ecf5ce6807ec4eef7962</code></td><td>New in 310.9.16; separately trained values over 31 contiguous raw block ids 0–30.</td></tr>
</tbody></table></div>
<p>The Small envelope is <code>8 + 113,887,490 + 77×56 + 1,533 = 113,893,343</code> bytes. The HT envelope is <code>4 + 76×153 = 11,632</code> overhead bytes, exactly the legacy framing. The HT identity is the strongest single continuity fact: the <code>WEIGHTS_HT</code> resource did not receive a weight refresh. It does <strong>not</strong> imply that Small is a subset, pruning or re-encoding of those weights. The independent artifact review compared every mapped payload: <strong>0 of 77</strong> are identical and all 77 differ, while HT is 153/153 identical to 310.8. The same review re-hashed the cached bundle, original DLL, both resources, 230 extracted record files and 22 stage packs.</p>
<p>The artifact review also narrows the role-identity claim. All 31 Small blocks have a legacy shape match, but <strong>19 of 31</strong> have more than one legacy candidate with the same shape signature; only 12 are uniquely identified by shape. The specific raw-id → role assignment therefore remains a source/order-derived hypothesis supported by the HIP port, not a byte-proven identity. The 77-record roster, raw ids and lengths are byte-verified; the role labels, stage grouping and window phases are not vendor-declared metadata.</p>
<p><strong>What remains host-side:</strong> the preset table and the fallback to preset 2 are an analysis of the original DLL, not a runtime observation. The fork still requests preset 0; the reported fallback is inferred from disassembly. No log on the exact community <code>A8A237…</code> file is available here. Treat “the fork effectively runs Small31” as unverified, and do not present it as this project's runtime behavior.</p>
<div class="table-scroll"><table><thead><tr><th>Pinned primary source (as of {AS_OF})</th><th>What it supports</th></tr></thead><tbody>
<tr><td><a href="https://github.com/Blinue/Magpie/tree/1a6f6c60cbd448b0e303e704f1225f0a4f3254ce">Blinue/Magpie <code>1a6f6c60</code></a></td><td>Upstream has no DLSS path in the pinned release.</td></tr>
<tr><td><a href="https://github.com/SAOG0721/Magpie/commit/4fc74a196993c883ce2f01e96e8ed8d81f1490e6">SAOG0721/Magpie <code>4fc74a19</code></a></td><td>Fork release that packages 310.9.16 and requests preset 0.</td></tr>
<tr><td><a href="https://github.com/lmxxf/DLSS5-RTX-3080-laptop/tree/fe3f91a2b0e02259b8beed80ae023da3e3ef09be">lmxxf/DLSS5-RTX-3080-laptop <code>fe3f91a2</code></a></td><td>Pinned PTX-patcher and HIP-port snapshot: record roster, role order, phase masks, post head, geometry and history blend.</td></tr>
<tr><td><a href="https://github.com/lmxxf/DLSS5-RTX-3080-laptop/blob/fe3f91a2b0e02259b8beed80ae023da3e3ef09be/Development/ptx-patcher/v2/weights.json">v2/weights.json</a> · <a href="https://github.com/lmxxf/DLSS5-RTX-3080-laptop/blob/fe3f91a2b0e02259b8beed80ae023da3e3ef09be/Development/ptx-patcher/v2/weight-records.json">v2/weight-records.json</a></td><td>Full resource identities and the 77-record parse used to cross-check the extraction.</td></tr>
<tr><td><a href="https://github.com/SAOG0721/Magpie/issues/73">Issue #73</a> · <a href="https://github.com/SAOG0721/Magpie/issues/72">Issue #72</a></td><td>Preset-table/fallback analysis of the original DLL; the dark-scene regression report. Both are user analysis, not vendor documentation.</td></tr>
<tr><td><a href="https://github.com/dev-camo/dlssnr-patcher/tree/98dac112990e5cea30ab03d74625fc848bce5c92">dev-camo/dlssnr-patcher <code>98dac112</code></a></td><td>Independent community patcher that lowers the FP8 fatbins for older GPUs.</td></tr>
</tbody></table></div>
<h2 id="model-choice">2. Two explicit identities: legacy71 (default) and small31 (opt-in)</h2>
<p><code>dlssnr/model_specs.py</code> exposes exactly two supported names. <code>resolve_model</code> is a strict lookup: <code>legacy71</code> stays the default execution path, <code>small31</code> must be selected explicitly, and any other name raises instead of falling back. The two resource identities are different artifacts, so a loader cannot infer the model from a file name, directory content or tensor shape.</p>
<div class="table-scroll"><table><thead><tr><th>Identity</th><th>Default</th><th>Resource</th><th>Records</th><th>Roles</th><th>Status</th></tr></thead><tbody>
<tr><td><code>legacy71</code></td><td>Yes</td><td><code>WEIGHTS_HT</code> · 147,695,410 B</td><td>153 stored; 142 deployed</td><td>0–70 identity map</td><td>Existing 310.8 reconstruction; generated legacy plan and kernels unchanged.</td></tr>
<tr><td><code>small31</code></td><td>No</td><td><code>WEIGHTS_CC_SMALL_FP8</code> · 113,893,343 B</td><td>77 stored; 66 in the native trunk</td><td>31 roles via source-derived map</td><td>Separate native schedule, host plan/registration and loader; built, imported and executed on real RGB fixtures for FP16 and FP8. Vendor DLL parity remains open; measured eager timing in three separate scopes is published in the <a href="cyberpunk-comparison.html">comparison chapter</a>, and the two attention entries carry an isolated full/source NCU replay.</td></tr>
</tbody></table></div>
<p>The 71-block reconstruction reuses <strong>operation roles</strong> 0–70: widths, stage boundaries, skip endpoints, window phase conventions and record layouts. Small31 contains <strong>77 records over raw block ids 0–30</strong>. The raw id is a record namespace; the role is the operation namespace. They are related by an explicit bijection, not by equality.</p>
<div class="table-scroll"><table><thead><tr><th>Raw Small id</th><th>Operation role</th><th>Why the distinction matters</th></tr></thead><tbody>
<tr><td>0–10</td><td>0, 1, 4, 5, 8, 9, 14, 15, 22, 23, 30</td><td>Pre, five encoder bodies and five encoder tails. A tail saves a skip and downsamples.</td></tr>
<tr><td>11–18</td><td>31–38</td><td>The eight C1024 global-attention blocks, four live records each plus an unused native layer-3 slot.</td></tr>
<tr><td>19</td><td>39</td><td>Transition-only 1024 → 512 up-projection.</td></tr>
<tr><td>20–29</td><td>40, 47, 48, 55, 56, 61, 62, 65, 66, 69</td><td>Five decoder pairs; the first of each pair merges the matching encoder skip.</td></tr>
<tr><td>30</td><td>70</td><td>Post head record plus a separate two-byte <code>blend_scale</code>.</td></tr>
</tbody></table></div>
<p>Filtering the 71-block weights by “keep 31 layers” is incorrect for four independent reasons.</p>
<ol>
<li><strong>The weights are separately trained.</strong> The pinned fork documentation describes Small as a different trained model with separate Oracle and Gold targets. The artifact review compared mapped payloads directly: <strong>0 of 77</strong> are identical and all 77 differ; the post-head values differ as well (max difference 1.32). Matching byte lengths at the mapped role is necessary for layout compatibility, but it is not value equality and does not make the model a pruning.</li>
<li><strong>The record ids are renumbered.</strong> Small <code>block2</code> is 22,720 B and maps to role 4; HT <code>block2</code> is 20,672 B. A <code>blockCount in {{31, 71}}</code> switch would accept the archive and then compare or decode the wrong record. Size equality after role mapping is the check, not ordinal equality.</li>
<li><strong>The schedule is not the legacy depth.</strong> The retained 31 roles form five encoder pairs, eight global blocks, a transition, five decoder pairs and post. The native trunk excludes pre, post and the eight unused ViT layer-3 slots: 66 records. The legacy plan's 142 deployed records, 185 calls, 74 boundaries, 232/208 buffers and 152 + 33 census are 71-block facts and must not be reused as Small counts.</li>
<li><strong>Window phases changed.</strong> Several retained encoder tails and decoder firsts receive a different phase/neighborhood. Copying the legacy phase table produces a graph with the right shapes and the wrong token neighborhoods.</li>
</ol>
<p>The correct description is: <em>a 31-role renumbered subgraph with its own trained weights, its own phase schedule, its own extraction manifest and its own native plan.</em> Role correspondence does not imply shared weights; it only says which operation contract a raw record must satisfy.</p>
<h2 id="schedule">3. Build the 31-role schedule from shape and skip obligations</h2>
<p>Read the three-band map before the tables. All three bands run left to right: the first is pre and the encoder pairs; the second is the global bottleneck and transition; the third is the decoder and post. <code>sN</code> is the raw Small record id; <code>rN</code> is the legacy operation role. Each band is a reading order, not a claim that all bands execute simultaneously.</p>
{FIGURE_ROLES}
<p class="small">Runtime diagrams keep their natural label size. On narrow screens the figure scrolls horizontally inside its diagram region rather than shrinking the text.</p>
{C_ROLE_MAP}
<h3 id="depth-table">Depth table: what is retained, implemented, and not claimed</h3>
<div class="table-scroll"><table><thead><tr><th>Contract</th><th>Legacy 71-block path</th><th>Small31 path</th></tr></thead><tbody>
<tr><td>Operation roles</td><td>0–70, identity with raw ids</td><td>31 roles: 0, 1, 4, 5, 8, 9, 14, 15, 22, 23, 30, 31–39, 40, 47, 48, 55, 56, 61, 62, 65, 66, 69, 70</td></tr>
<tr><td>Raw record namespace</td><td>0–70</td><td>0–30, contiguous</td></tr>
<tr><td>Records</td><td>153 stored; 142 deployed</td><td>77 stored; 66 deployed in the native trunk</td></tr>
<tr><td>Payload</td><td>147,683,778 B</td><td>113,887,490 B</td></tr>
<tr><td>Packed archive stages</td><td>11</td><td>{STAGE_COUNT} archive files; {STAGE_GROUPING}</td></tr>
<tr><td>Forward schedule segments</td><td>11 stage groups, pre/post special-cased</td><td>14 logical segments: pre, five encoder pairs, ViT, transition, five decoder pairs, post; 31 visited roles</td></tr>
<tr><td>Native trunk calls</td><td>152 compute + 33 clear = 185</td><td><strong>76 compute/repack + 33 clear = 109</strong> logical calls</td></tr>
<tr><td>Deployed records / boundaries / unique kernels</td><td>142 / 74 / 36</td><td><strong>66 / 34 / 34</strong></td></tr>
<tr><td>Native buffers</td><td>232 FP8 / 208 FP16</td><td><strong>156 FP8 / 132 FP16</strong></td></tr>
<tr><td>Window phases</td><td>legacy <code>graph_schedule</code></td><td>explicit per-role masks below</td></tr>
<tr><td>Post head</td><td>32 × 4 training head; 2-byte blend scalar 0.73974609375</td><td>native four logical channels: 96 RGB values + 32-half history gate in 4 × 32; Small blend scalar 0.76708984375</td></tr>
</tbody></table></div>
<p>The {STAGE_COUNT} archive stages below are sums over the verified 77-record roster. They are not copied from legacy stage ranges; grouping by raw range would mix ViT and decoder records into the wrong files. In the current spec, {STAGE_GROUPING}. The forward schedule still separates those boundary roles into 14 logical segments; both descriptions are correct at their own layer.</p>
<div class="table-scroll"><table><thead><tr><th>Archive stage</th><th>Logical segment(s)</th><th>Roles</th><th>Raw ids</th><th>Records</th><th>Payload bytes</th></tr></thead><tbody>
{STAGE_TABLE_ROWS}
</tbody></table></div>
<p>The shape obligations are the same as the legacy graph at each mapped role. Within an encoder pair the first block is the body and the second is the tail: the tail's published result is the skip, while its raw result is pooled and projected into the next width. Within a decoder pair the first block projects down, repeats spatially, crops and adds the saved skip; the last block continues the level. Role 39 is a transition-only 1024 → 512 projection. Post 70 merges the full-resolution path, runs the C32 body and applies the native 4 × 32 head (96 RGB + 32 gate); the opt-in model reuses that four-channel head and the legacy composition, with the RGB residual in channels 0–2 and the source-backed gate in channel 3.</p>
<h3 id="phase-table">Phase table: depth and window shift are separate decisions</h3>
<p>The HIP host passes <em>shift masks</em> (bit 0 = x, bit 1 = y), not this project's phase indices. The conversion used by the reconstruction is <code>{{0: 0, 3: 1, 1: 2, 2: 3}}</code>. The masks below are source-derived from the pinned HIP port; they have not been observed in DLL dispatch. <strong>Exactly eight roles change phase index versus the legacy <code>graph_schedule</code>: 4, 8, 22, 30, 40, 48, 62 and 66.</strong></p>
<div class="table-scroll"><table><thead><tr><th>Role group</th><th>Legacy phase</th><th>Small mask</th><th>Small phase</th><th>Changed?</th></tr></thead><tbody>
<tr><td>Input 0</td><td>0</td><td>0</td><td>0</td><td>No; host descriptor unobserved</td></tr>
<tr><td>Encoder firsts 1, 5, 9, 15, 23</td><td>0</td><td>0</td><td>0</td><td>No</td></tr>
<tr><td>Encoder tails 4, 8, 22, 30</td><td>3</td><td>3</td><td>1</td><td><strong>Yes; legacy phase 3 / mask 2 → Small phase 1 / mask 3</strong></td></tr>
<tr><td>Encoder tail 14</td><td>1</td><td>3</td><td>1</td><td>No; already phase 1</td></tr>
<tr><td>ViT 31–38</td><td>none</td><td>none</td><td>none</td><td>Global attention; no window phase</td></tr>
<tr><td>Transition 39</td><td>none</td><td>none</td><td>none</td><td>No self block</td></tr>
<tr><td>Decoder firsts 40, 48, 62, 66</td><td>0</td><td>1</td><td>2</td><td><strong>Yes; legacy phase 0 / mask 0 → Small phase 2 / mask 1</strong></td></tr>
<tr><td>Decoder first 56</td><td><strong>2</strong></td><td>1</td><td>2</td><td>No; <code>graph_schedule</code> already gives role 56 phase 2 / mask 1</td></tr>
<tr><td>Decoder lasts 47, 55, 61, 65, 69</td><td>3</td><td>2</td><td>3</td><td>No</td></tr>
<tr><td>Post 70</td><td>1 in legacy graph schedule</td><td>host <code>post_shift</code>, default 0</td><td>0 default</td><td>Source-derived host option; not proven as a Small delta</td></tr>
</tbody></table></div>
{FIGURE_WINDOW}
<p>The tracked token shows the point of the table: changing the mask changes both the window index and the local coordinate inside the window. The window size and the 64-slot attention contract do not change. The same 8 × 8 window operation is reused; its phase schedule is not.</p>
{C_RAW_ROSTER}
{C_PHASE_SOURCE}
{C_PHASES}
<p>The implementation records the provenance string next to every phase, so a later DLL-dispatch observation can replace the source-derived rule without silently rewriting the graph. The post shift remains a descriptor/host value; the legacy <code>graph_schedule</code> phase 1 is not asserted for Small.</p>
<h2 id="mapping">4. From resource bytes to operation roles and native records</h2>
<p>There are four boundaries that must not be collapsed: the <strong>storage boundary</strong> (resource envelope → stage payload), the <strong>name boundary</strong> (raw DLL id → operation role), the <strong>compute boundary</strong> (decoded parameters → PyTorch tensors or packed native records) and the <strong>plan boundary</strong> (logical calls → physical split launches). A correct byte count at one boundary says nothing about the next one.</p>
{FIGURE_IDENTITY}
<div class="table-scroll"><table><thead><tr><th>Level</th><th>Exact Small31 example</th><th>What is checked</th></tr></thead><tbody>
<tr><td>Resource envelope</td><td><code>113,893,343 = 8 + 113,887,490 + 77×56 + 1,533</code></td><td>File length, full SHA-256, envelope self-size, 77 records, payload sum.</td></tr>
<tr><td>Stage payload</td><td><code>encoder512</code>: 9 records, 4,460,688 B</td><td>Stage comes from the role, not the raw id; each record is concatenated once.</td></tr>
<tr><td>Raw id → role</td><td><code>block2 → role 4</code>; <code>block10.layer4 → role 30</code>; <code>block19 → role 39</code>; <code>block30 → role 70</code></td><td>Explicit bijection, record name/layer/parameter, role-mapped byte length; 19/31 role ids remain source/order-derived.</td></tr>
<tr><td>Decoded tensors</td><td>role 4 C32 down; role 30 512 × 1024 down; role 39 1024 → 512; post head 4 × 32 = 96 RGB + 32 gate</td><td>Shapes, finite values, decoded dtype and the source-derived post permutation; the 4 × 32 layout is artifact/kernel checked.</td></tr>
<tr><td>PyTorch operations</td><td><code>SMALL31</code> model: five encoder pairs, 8 global blocks, transition, five decoder pairs, four-channel head (RGB + source-backed gate)</td><td>Executed CPU/GPU self-consistency; this training reconstruction stays FP32/BF16. The separate native deployment path is supported for both models and passes real RGB fixtures.</td></tr>
<tr><td>Native FP8 / FP16 records</td><td>FP8 keeps the original archive bytes; FP16 repacks the decoded state with <code>pack_kernel_fp16</code></td><td>Every compiled record name, order and byte size checked; no Half-to-FP8 conversion.</td></tr>
<tr><td>Native plan binding</td><td>66 positional records, 109 logical calls, 34 boundaries, 156 FP8 / 132 FP16 buffers</td><td>Generated-table/static audit; one logical call may become multiple physical split launches.</td></tr>
</tbody></table></div>
{FIGURE_BINDING}
<p>Raw ids, operation roles and record positions are three separate namespaces. The native table binds a record by position, not by raw id or role equality: for example <code>record[0]</code> is raw1/role1, <code>record[12]</code> is raw10/role30, <code>record[49]</code> is raw19/role39 and <code>record[65]</code> is raw29/role69. The pre and post records are supplied through the existing frontend path and do not appear in the 66-entry trunk table.</p>
<p><strong>Serialized FP8 is not the execution dtype of the training surrogate.</strong> A record is a packed byte payload with a role-specific layout; decoding produces FP32 or auxiliary tensors by slicing, reshaping and assigning values. The training surrogate uses FP32 masters and FP32/BF16 floating arithmetic. The native deployment path consumes the original FP8 bytes or the losslessly repacked FP16 records and reuses almost every existing CUDA math kernel unchanged; the two additive Small31 attention variants are the deliberate exception described in section 5.</p>
{FIGURE_TOKEN}
<p>The token path also fixes the skip semantics: the published attention result is saved; the raw result takes the 2 × 2 average and channel projection. At the decoder entry the lower-resolution path is projected before spatial repetition, then cropped and added to the scaled skip. The merge is addition, not concatenation. This is the same obligation at every mapped pair; the changed phases do not change it.</p>
<h3 id="post-head">The post head is four logical channels</h3>
<p>The native 1,024-byte head region is <code>[20784, 21808)</code> of <code>block30.layer0.layer</code>: 512 halves, of which exactly 128 are non-zero and 384 are zero padding. The HIP <code>16×32</code> scatter selects rows <code>0, 2, 4, 6</code>; rows 0, 2 and 4 carry the 96 RGB values and row 6 carries the 32-half history gate, so <code>96 + 32 = 128 = 4 × 32</code>. The layout review verified that all 128 values are the same values as the local <code>head[32,4]</code> decode under a consistent packing permutation. The declared head is therefore <strong>four logical channels</strong>, not a three-channel RGB head. The separate Small blend scalar is <code>0.76708984375</code> (<code>0x3a23</code>); the legacy HT value is <code>0.73974609375</code>.</p>
{C_NATIVE_HEAD}
{C_POST_SPEC}
{C_COMPOSE}
<p>The native FP16 postprocess record (34,096 B) ran bit-exactly against the original extracted FP16 cubin at 32 × 40, and perturbing each real <code>head[k,1]</code> changed only the G channel, which confirms the packing permutation for the tested path. That is a post-kernel check, not DLL host dispatch and not a full-model native run.</p>
<h2 id="implementation">5. Implementation: separate native plan and portable identity</h2>
<p><code>dlssnr/model_specs.py</code> is the single source of truth for the two identities. It stores the raw-to-role bijection, the archive stages, the per-record roster, the phase table, the post-head descriptor and the trusted stage pins. The legacy spec remains the default; <code>resolve_model</code> raises for an unknown name and never falls back.</p>
{C_CANONICAL_OFFSETS}
{C_MANIFEST_OFFSETS}
<p>Canonical offsets close a concrete identity hole. A manifest could previously keep the stage file and its trusted SHA-256 unchanged while swapping two equal-sized record offsets and recomputing only the two entry hashes. The real-archive review swapped <code>block20.layer0.layer</code> and <code>block21.layer0.layer</code> (both 524,288 B in <code>decoder512</code>); the default complete archive load and model construction both now raise <code>ManifestError</code> on the non-canonical offset. Complete loading also re-runs the trusted stage pins, the gapless coverage check and the full 77-record identity even when a fixture-mode archive was opened with <code>require_complete=False</code>, so production model construction cannot bypass them.</p>
{C_EXTRACT}
<p>The extractor is deliberately offline and bounded. It hashes the DLL, requires an exact accepted original pin, walks only the PE resource tree, parses the envelope with explicit bounds and rejects any record whose raw id, role, stage, byte length or metadata disagrees with the spec. Community-patched DLLs are rejected because their bytes are not the accepted original pin. An existing output directory is also rejected, so old extracted assets cannot be overwritten.</p>
<div class="table-scroll"><table><thead><tr><th>Public action</th><th>Exact command or API</th><th>Evidence class</th></tr></thead><tbody>
<tr><td>Extract legacy 71</td><td><code>python -B tools/extract_runtime_assets.py --dll assets/original/nvngx_dlssnr.dll --model legacy71 --output &lt;new-dir&gt;</code></td><td>Local CPU extraction; does not execute the DLL.</td></tr>
<tr><td>Extract Small31</td><td><code>python -B tools/extract_runtime_assets.py --dll &lt;original 310.9.16 DLL&gt; --model small31 --output &lt;new-dir&gt;</code></td><td>Original DLL only; produces a fresh 77-record archive and manifest.</td></tr>
<tr><td>Resolve a spec</td><td><code>resolve_model("legacy71")</code> or <code>resolve_model("small31")</code></td><td>Raises on any other name; no silent default.</td></tr>
<tr><td>Native selector</td><td><code>load_native_model(path)</code> → legacy; <code>load_native_model(dir, model="small31")</code> → Small</td><td>Explicit adapter; cross-model selection raises.</td></tr>
</tbody></table></div>
{C_SCHEDULE}
<p>The schedule walks five encoder pairs, the eight global blocks, transition 39, five decoder pairs and post. Encoder tails are roles 4, 8, 14, 22 and 30; the decoder entries are 66, 62, 56 and 48 (with 40 continuing after transition 39). A raw-index schedule would visit 2, 4, 6, 8 and 10 and is wrong.</p>
<h3 id="native-plan">A separate native trunk, not a relabelled legacy plan</h3>
<p>The generator now derives its census from the retained Small roster instead of hardcoding 152/33. The Small deployment host class is separate from <code>FDeploymentPlan</code>: it owns 156 FP8 / 132 FP16 total buffers including the borrowed caller input, guard-allocates 155 / 131 workspace backings, and asserts the Small census at construction. The generated plan contains only the trunk; pre role 0 and post role 70 (record plus blend scalar) stay outside it and are consumed by the existing frontend dispatch.</p>
{FIGURE_PLAN}
{C_HOST_OWNERSHIP}
{C_PLAN_TABLE}
{C_REGISTRATION}
<p>The loader maps each raw record to its operation role, validates the compiled 66-record name/order/size roster before any plan call, and for FP16 repacks through the shared <code>pack_kernel_fp16</code> path. A logical call may become multiple physical split launches under the existing admission rules; the 109/66/34/156/132 counts are schedule and buffer facts, never speed claims. Legacy remains 185 calls, 142 deployed records, 74 boundaries and 232/208 buffers.</p>
{C_RECORD_PROVIDER}
{C_PLAN_RECORDS}
{C_NATIVE_SELECTOR}
<h3 id="checkpoint-identity">Checkpoint identity and portability</h3>
{C_COMPAT}
<p>Checkpoint compatibility uses the canonical model, source DLL, resource path/SHA/length, roles, raw-to-role map, block count, post phase, head shape and head layout. The absolute local archive path and the manifest SHA-256 are provenance metadata only, so two equally verified extractions of the same source restore each other's tensors. The identity review assigned sentinel tensor values (<code>w1 = 12.5</code>, <code>head = -3.0</code>) and restored them bitwise into a differently provenanced copy; it did not train the model. Cross-model, wrong-resource, permuted-role and wrong-post-phase loads raised before copying any tensor, including with <code>strict=False</code>.</p>
<p>A CPU round-trip uses the extracted archive and the public model entry point. The snippet below is an API shape example, not a numerical-parity claim:</p>
<pre><code>from dlssnr import Geometry
from dlssnr.small_model import SmallDLSSNR

model = SmallDLSSNR.from_directory(
    "path/to/extracted/small31",
    device="cpu", dtype=torch.float32, precision="fp32",
)
geometry = Geometry.from_valid(1280, 720)
features = torch.randn(1, geometry.full_height, geometry.full_width, 16)
head = model.forward_train(features, geometry=geometry)  # [1, H, W, 4]
neural = model.compose(head, proxy_rgb)  # proxy_rgb is [1, H, W, 3]
</code></pre>
<p>The native adapter is separate from the PyTorch training graph. It can provide the pre/post records in both precisions, read the raw30 blend scalar and create a separate FP8 or FP16 plan:</p>
<pre><code>from dlssnr.small_deployment import load_native_model

small = load_native_model("D:/fresh/small31", model="small31")
plan8 = small.create_plan_fp8(feature_state_fp8, width=1920, height=1080)
pre8 = small.kernel_record(0, kind="preprocess", precision="fp8")
post16 = small.kernel_record(70, kind="postprocess", precision="fp16")

legacy = load_native_model("ckpts/dlss5_nr_fp16.pt")  # still the default
</code></pre>
<p><strong>Implementation status:</strong> the Small generator, C++ host plan/registration and loader are implemented and reviewed. The independent static audit parsed every generated call and reported <code>PASS fp8: 109 calls / 76 compute / 33 clear / 66 records / 156 buffers / 34 boundaries / 34 unique kernels</code> and the same counts with 132 FP16 buffers. The SM120 extension was then built and linked (binary <code>f0d51404…528938</code>, 18,366,464 B) and imported in a fresh process, which registered both <code>small_global_attention_chained_c1024_fp16/fp8</code> operators; the roster is <strong>83 exports, 41 FP16/FP8 pairs and 58 owning bodies</strong>, with the historical 81-entry evidence retained. The two attention exports are additive: the original 81 entries, their 56 owning bodies, their ABI and the legacy plan files are unchanged. Both models and both precisions executed real RGB stills and 4K frames: eight cases, 3024×1890 padded to 3072×1920 and 3840×2160 padded to 3840×2176, with typed <code>b69</code> finite in all arms and <code>b31.attended</code> finite in the Small arms and the Small FP8 <code>b31</code> ±448 count 0. A 320² capture/replay check passed 4/4 arms bitwise with intact guards. The two attention exports also have four current full/source NCU reports for an isolated replay of one call each; those records are not network timing. This is native RGB acceptance of the reconstructed path, not vendor DLL numerical parity.</p>
<h3 id="layout-contract">Forward design 1: a typed field includes its address function</h3>
<p>The final Small31 producer and the display postconsumer use the same FP16 dtype, the same 1,024-byte tile extent and the same guarded allocation, yet they read and write different byte addresses for the same logical token. <strong>Equal dtype, equal byte size and intact guards are therefore necessary but not sufficient.</strong> The producer writes a <strong>TILE4</strong> field: 4×4 pixels share a 1,024-byte tile, and the four words of one token live in four different 16-byte lane slots. The postconsumer reads a <strong>PLANE16</strong> field: one 16-byte group per (plane, pixel), with its four words consecutive. The layout contract is the pair of address functions, not the size of the buffer.</p>
<p>For FP16 plane 0, token <code>x=1, y=0</code> gives <code>tx=0</code>, <code>ix=1</code>, <code>iy=0</code>, <code>lane=q+4</code>, <code>word=0</code>, <code>chunk=0</code> and <code>tile=0</code>. The TILE4 producer therefore places the four words at bytes <strong>64, 80, 96, 112</strong> (<code>lane*16</code> with <code>lane=4..7</code>), while the PLANE16 postconsumer reads them at bytes <strong>16, 20, 24, 28</strong> (<code>pixel*16 + 4q</code>). The same token, dtype and 1,024-byte tile; different address functions. The producer formula is the exact §2.3 formula and the consumer formula is the exact §3.2 formula in <code>profile/dlss-update-20261029/docs-rgb-design/layout/draft.md</code>; the worked trace is <code>worked_fp16_token_p0_y0_x1</code> in the same directory's <code>results.json</code>.</p>
<p>The accepted RGB implementation is deliberately narrow. <code>build_rgb_trunk</code> reads the prepared plan metadata, keeps every base-plan descriptor and <strong>replaces only the final phase-3 C32 descriptor</strong> with the existing <code>window_block_c32_output_view_&lt;precision&gt;</code> entry. It reuses the same <code>b69</code> allocation and the same physical split counts, adds no repack kernel and no extra allocation, and leaves the base <code>plan.run_fp16()</code> / <code>plan.run_fp8()</code> path publishing the ordinary TILE4 field. The phase-3 substitution is byte-exact against the independent TILE4→PLANE16 permutation in <strong>8 of 8</strong> accepted cases, with zero differing bytes; the phase-3 <code>(0,−4)</code> origin shifts CTA coverage, not the logical address. No smoothing, filtering, clipping or math change is involved.</p>
{FIGURE_LAYOUT_CONTRACT}
{C_RGB_FINAL}
<h3 id="numerics-contract">Forward design 2: every unnormalized numerator prefix must fit its accumulator</h3>
<p>A finite normalized output does not prove that the unnormalized numerator was representable at every step. The native Small31 attention multiplied P by V into a packed-Half accumulator; a partial row sum could exceed <strong>65,504</strong> and become ±inf even when the final value after division was small and finite. The accepted synthetic <code>cancel</code> fixture makes the distinction concrete: the reference numerator prefix reaches <strong>396,900</strong>, well above Half max, while the final published value is <strong>0</strong> and exactly reproduced by the FP32 accumulator. That is why the contract is stated on the <em>prefix</em>, not on the output.</p>
<p>The surrogate's clamped exponential is <code>Emax = 1.640625</code>, which is greater than 1, so an input-row bound based on <code>max|V|</code> alone is invalid. For a row with <code>N</code> keys, every prefix satisfies <code>|u| ≤ N · Emax · max|V|</code>. For the 4K frame, <code>N=2160</code> and the fixture's <code>max|V|=223.625</code> give the conservative design bound <code>2160 × 1.640625 × 223.625 = 792,471.09375</code>. This is a bound, not an observed prefix maximum. The sampled oracle reports observed numerator maxima of 94,402.390625 (FP16) and 87,855.625 (FP8), with 723 FP16 and 640 FP8 selected entries above 65,504; the full 2,228,224-element finite census is a separate check.</p>
<p>Do not apply the same bound algebra to FP8 as if both operands shared one value set: the FP8 numerator uses the E4M3 conversion of the Half probability (<code>E4M3(E)</code>), while the denominator sums the native Half <code>E</code>. The operand sets differ, so an exact convex-hull claim for FP8 is not made. QK stays Half, and the native exponent surrogate, masks, quantization, graph, weights and eight Small global-block selections are preserved.</p>
<p>The two additive Small31 variants change only the P·V accumulation and the row denominator: the new PV MMA writes FP32 D registers, every local, warp-transpose and persistent-D addition stays FP32, and the two row sums stay FP32 across all key tiles. After the last key tile there is one FP32 clamp/reciprocal and one FP32 normalization per output; the result is rounded once to packed Half and then passes through the unchanged Half→E4M3 contract for FP8. The transient state is the per-key-tile probability tile and staged K/V; the persistent state is <code>r_Output[4][4][4]</code> (64 FP32 numerators per lane) plus <code>r_Denominator[2]</code> (two FP32 row sums per lane).</p>
<p>Compiler/resource validation for the exact built binary: FP16 <strong>208 registers, 16,400 B static shared, 24 B stack, 44 B spill stores, 56 B spill loads</strong>; FP8 <strong>195 registers, 8,208 B static shared, 0 B stack, 0 B spills</strong>. The runtime row also reports a maximum of 2 CTAs/SM and 256 threads/block; the launch itself uses <strong>128 threads</strong> (<code>dim3(32,4,1)</code>). Two CTAs/SM is the CUDA occupancy API capacity, <strong>not achieved occupancy</strong>, and 128 threads is the selected launch shape, <strong>not</strong> <code>maxThreadsPerBlock</code>. Neither number is a timing. The two exact lessons are <a href="small_global_attention_chained_c1024_fp16.html"><code>small_global_attention_chained_c1024_fp16.html</code></a> and <a href="small_global_attention_chained_c1024_fp8.html"><code>small_global_attention_chained_c1024_fp8.html</code></a>.</p>
{FIGURE_NUMERICS}
{C_ATTN_ACC}
{C_ATTN_INTRINSICS}
{C_ATTN_WIDEN}
{C_ATTN_NORM}
{C_ATTN_FP8_PUB}
<h2 id="validation">6. Validation ledger: direct bytes, source inference, executed tests, native RGB acceptance, remaining vendor gaps</h2>
<p>The ledger below separates a recomputed byte identity from a source-derived schedule, from checks that actually executed, and from the vendor-host work that remains open. Measured eager network timing and the character comparison are published separately in <a href="cyberpunk-comparison.html">the accepted Cyberpunk comparison chapter</a>; they are not established by NCU alone. The isolated Small attention replay is listed separately. The historical NCU reports stay attached to their original 310.8 snapshot and workload.</p>
{FIGURE_VALIDATION}
<div class="table-scroll"><table><thead><tr><th>Check</th><th>Exact evidence</th><th>Evidence class and result</th></tr></thead><tbody>
<tr><td>Original DLL identity</td><td>SHA-256 and byte length of the 310.9.16 original</td><td><strong>Direct bytes:</strong> <code>2bc19bc0…d28789f</code>, 266,424,944 B.</td></tr>
<tr><td><code>WEIGHTS_HT</code> identity</td><td>Resource SHA-256 and length from the original DLL; whole-envelope comparison with 310.8</td><td><strong>Direct bytes:</strong> <code>836f445d…d548f4</code>, 147,695,410 B, 153 records; 153/153 identical to 310.8.</td></tr>
<tr><td><code>WEIGHTS_CC_SMALL_FP8</code> identity</td><td>Resource SHA-256 and length from the original DLL</td><td><strong>Direct bytes:</strong> <code>f743e8eb…ef7962</code>, 113,893,343 B, 77 records, payload 113,887,490 B.</td></tr>
<tr><td>Record roster and role map</td><td>Raw ids 0–30, 77 names, role-mapped byte lengths; artifact role-candidate analysis</td><td><strong>Mixed:</strong> roster/names/sizes are byte-verified; role labels are source/order-derived because 19 of 31 blocks have more than one legacy shape candidate. Not a byte-proven role identity or value equivalence.</td></tr>
<tr><td>Independent artifact review</td><td>Cached bundle, original DLL, both resources, 230 record files, 22 stage packs</td><td><strong>Direct bytes:</strong> all re-hashed; HT 153/153 identical, Small 0/77 identical and 77/77 changed. Host dispatch, phases, geometry, post layout and numerical parity are not established by bytes.</td></tr>
<tr><td>Stage payloads</td><td>{STAGE_COUNT} archive-stage sums over the 77-record roster</td><td><strong>Direct bytes:</strong> total equals 113,887,490 B; stage grouping is by role, not legacy raw ranges.</td></tr>
<tr><td>Source-derived phase schedule</td><td>HIP masks and decoder rule at pinned <code>fe3f91a2</code></td><td><strong>Source inference:</strong> recorded with provenance; not observed in DLL host dispatch. Changed roles are exactly 4, 8, 22, 30, 40, 48, 62, 66; role 56 is already phase 2 in the legacy <code>graph_schedule</code>.</td></tr>
<tr><td>Post head</td><td>Layout review + primary-kernel/FP16 probe; <code>PostHeadSpec</code> and the opt-in model</td><td><strong>Artifact/kernel check:</strong> native 4 × 32 = 96 RGB + 32 gate; the 16×32 scatter rows 0,2,4,6 give the same 128 values as local <code>32×4</code>. DLL host descriptor still unobserved.</td></tr>
<tr><td>Canonical offsets and portable identity</td><td>Focused CPU tests at final source: real equal-size offset swap, provenance variants, checkpoint portability</td><td><strong>Executed:</strong> swapped <code>decoder512</code> offsets are rejected at load and at fixture-mode model construction; checkpoint restore is portable across verified provenance variants; cross-identity loads are rejected before tensor copies. 33 passed / 1 skipped plus 11 deployment tests.</td></tr>
<tr><td>Archive extraction</td><td><code>tools/extract_runtime_assets.py --dll &lt;original 310.9.16 DLL&gt; --model small31 --output &lt;new-dir&gt;</code></td><td><strong>Executed:</strong> fresh extraction produced 31 blocks, 77 records, 11 archive stages, payload 113,887,490 B and manifest SHA-256 <code>8471411a…e9f6fc</code>. The DLL was parsed, not executed.</td></tr>
<tr><td>Small native plan census</td><td>Generated FP8/FP16 assets + independent static parser</td><td><strong>Executed CPU/static:</strong> 109 calls (76 compute/repack + 33 clear), 66 records, 34 boundaries, 156 FP8 / 132 FP16 buffers, 34 unique kernels, output <code>b69.output</code>. One logical call may split into multiple physical launches; these are not timings.</td></tr>
<tr><td>Small host plan and registration</td><td>Two new translation units; <code>TORCH_LIBRARY_FRAGMENT</code>; ownership/guard/stream/split code</td><td><strong>Built + imported + executed:</strong> the SM120 extension linked and copied to <code>dlssnr/_C_sm120.cp311-win_amd64.pyd</code> (SHA-256 <code>f0d51404…528938</code>); a fresh process registered both Small attention operators and the Small/legacy plan classes; generated tables still assert 109 calls, 34 unique kernels and guarded split admission. Device execution follows in the RGB rows below.</td></tr>
<tr><td>PyTorch CPU round-trip</td><td><code>SmallDLSSNR.from_directory(...)</code> then <code>forward_train</code></td><td><strong>Executed CPU:</strong> 31 schedule steps, one per operation role; FP32/BF16 outputs finite and four-channel; <code>compose</code> returns three-channel neural RGB. This is the training reconstruction, separate from the native accepted path.</td></tr>
<tr><td>Native real-RGB acceptance</td><td>SM120 binary <code>f0d51404…528938</code>; actual still JPEG 3024×1890 → 3072×1920 and frame PNG 3840×2160 → 3840×2176</td><td><strong>Executed GPU:</strong> 8/8 cases across <code>legacy71/small31 × fp16/fp8</code>; typed <code>b69</code> finite in all arms and <code>b31.attended</code> finite in the Small arms, Small FP8 <code>b31</code> ±448 count 0, non-black valid-extent RGB, guards intact before/after capture and replay. The phase-3 TILE4→PLANE16 substitution was byte-exact in 8/8 cases (0 differing bytes). 320² capture/replay passed 4/4 arms bitwise with no host calls. Evidence: <code>rgb-safe-attention-rgb/report.md</code> and <code>results.json</code>; build/resources in <code>rgb-safe-attention-build/report.md</code>.</td></tr>
<tr><td>Exact-attention numerical oracle</td><td>Sampled 96 queries × 32 heads × 32 channels = 98,304 values per precision; full 2,228,224-element finite census separate</td><td><strong>Executed GPU:</strong> FP8 publication 100% exact; FP16 99.2228% exact, max abs 0.125, max 14 Half ULPs, p99 error 0, no value outside the predeclared FP32 bound. Denominator max error 0.0001220703; 723 FP16 / 640 FP8 selected numerator entries were above 65,504 before normalization. Diagnostic dump on/off is production-bitwise. This is a sampled oracle, not an all-query or FP16-bitwise claim. Evidence: <code>rgb-safe-attention-validation/artifacts/probability_frame_fp16.json</code> and <code>…_fp8.json</code>; synthetic <code>cancel</code> case in <code>synthetic_fp16.json</code>.</td></tr>
<tr><td>Final public CPU runner</td><td><code>.venv/Scripts/python.exe -B run_tests.py cpu</code></td><td><strong>Executed:</strong> exit 0, <code>CPU summary: 17/17 checks passed</code>; pytest group 102 passed / 1 skipped / 31 subtests. The skip is the explicit opt-in large-extraction test, not a failure; earlier real extraction evidence is separate. Evidence: <code>final-cpu/report.md</code>, <code>stdout-stderr.log</code>, <code>kernel-sources.json</code>.</td></tr>
<tr><td>PyTorch GPU self-consistency</td><td>RTX PRO 6000 Blackwell Workstation (SM120, capability 12.0), PyTorch 2.8.0+cu128/CUDA 12.8, FP32 and BF16 master-FP32</td><td><strong>Executed GPU:</strong> valid 97×65 → 320×320 and 1280×720 → 1344×768 produce <code>[1,H,W,4]</code>; all 37 expected boundaries present and finite; repeat forward bitwise; crop exact; fourth channel is the history gate. Checkpointed forward/backward at 64×64 is bitwise over both iteration outputs, both input gradients and all 271 participating parameter gradients (62 checkpoint calls, 0 mismatches). This is PyTorch self-consistency, not DLL parity and not native GPU proof.</td></tr>
<tr><td>Documentation build</td><td><code>.venv/Scripts/python.exe -B tools/build_kernel_docs.py</code></td><td><strong>Executed:</strong> regenerates this page, the legacy 81 lessons and the two additive Small attention lessons; per-file provenance and local runtime copies are written; the 122-path historical drift guard runs.</td></tr>
<tr><td>Documentation validation</td><td><code>.venv/Scripts/python.exe -B tools/validate_kernel_docs.py</code></td><td><strong>Executed:</strong> exact source excerpts, per-file revision/hash checks, SVG hashes, link checks and historical NCU report hashes remain enforced.</td></tr>
<tr><td>Historical NCU evidence</td><td>81 entries, 56 definitions, 40 template entries; reports pinned to the 310.8/8dc554 run</td><td><strong>Historical implementation evidence only.</strong> No Small timing or speedup is inferred from reused operator layouts. The two attention entries carry their own current full/source replay, not a reused legacy number.</td></tr>
</tbody></table></div>
<p><strong>Remaining, not passed:</strong> a runtime preset/fallback log on the exact community DLL; a DLL host-descriptor observation for phases, geometry and post shift; and a numerical comparison of this reconstructed native path against the vendor DLL (including the C64–C256 FP16 FFN native oracle). The isolated replay of one attention call is recorded on the two additive lessons; it is not a network timing. Those gaps do not reopen native build/import or the real-RGB acceptance above. No image-quality equivalence to the vendor is claimed. The accepted eager timings are measured independently in their declared scopes and are not inferred from NCU or from call counts.</p>
<p>The existing 81 NCU reports remain valid for their own snapshot, workload, binary and precision. Reusing an operator family or a record layout does not transfer a timing number to Small31. The current isolated replay is separately scoped to one attention call and the captured fixture; it does not become a network timing. The PyTorch GPU run proves internal numerical consistency and checkpointing at a declared tolerance; the native RGB run proves the reconstructed SM120 path executes and stays finite on the accepted fixtures. Neither is vendor DLL numerical parity. Network eager timings live in the separate comparison chapter, where the three measured scopes are reported without subtracting one from another.</p>
"""

CHAPTER = dict(
    slug='runtime-310-9-16',
    title='DLSS 310.9.16 / Small31: two models, one forward design',
    summary='What 310.9.16 changed, why Small31 is a separately trained 31-role subgraph, how raw ids map to roles, and which claims are byte-verified, source-derived, executed, native-RGB accepted, or still open in vendor host-descriptor/numerical parity, with measured eager timing in the separate comparison chapter and an isolated NCU replay for the two attention entries.',
    body=BODY,
)

CHAPTERS = [CHAPTER]
