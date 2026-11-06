"""Render paired effects and RGB scopes from the published acceptance receipts."""
from __future__ import annotations

from html import escape
import json
from statistics import median


def paired_effects_html(record, table):
    rows = []
    for case in record.timing.cases:
        a, b = case.original_process_medians_ms, case.candidate_process_medians_ms
        pairs = [1000 * (y - x) for x, y in zip(a, b)]
        blocks = [1000 * (median(b[i:i + 2]) - median(a[i:i + 2])) for i in (0, 2)]
        drift = [1000 * (median(v[2:]) - median(v[:2])) for v in (a, b)]
        rows.append((escape(case.id),
                     f'{1000 * (median(b) - median(a)):+.2f}',
                     f'{100 * (median(b) / median(a) - 1):+.2f}',
                     f'{median(pairs):+.2f}',
                     ', '.join(f'{v:+.2f}' for v in pairs),
                     ' / '.join(f'{v:+.2f}' for v in blocks),
                     ' / '.join(f'{v:+.2f}' for v in drift)))
    return (
        '<h3 id="native-paired-effects">Compare headline, paired and block effects</h3>'
        '<p>The headline subtracts the medians of four process medians per arm. '
        'The paired column takes the median of four adjacent B−A differences, '
        'using the fixed ABBA/BAAB order. The four pairs and two block costs '
        'retain their signs; positive values mean FlashLight takes longer. '
        'Block drift is block2 minus block1 within each arm. These are observed '
        'process differences, not confidence intervals or 30 independent trials '
        'per process.</p>'
        + table(('Case', 'Headline B−A (µs)', 'Headline (%)',
                 'Median paired B−A (µs)', 'Four paired B−A (µs)',
                 'Block1 / block2 B−A (µs)', 'A / B block drift (µs)'), rows)
        + '<p>The measured cost is accepted as a maintainability and correctness '
        'tradeoff. These are whole-build comparisons with incomplete original '
        'toolchain provenance: they do not isolate wrapper overhead or establish '
        'a causal cost for registers, acquire operations or compiler changes. '
        'No zero-overhead claim follows. Process medians and ranges appear above; '
        'historical DLL measurements remain a separate experiment.</p>')


def rgb_measurements_html(record, table):
    check = next(check for check in record.checks if check.category == 'rgb')
    receipt = json.loads((record.bundle_root / check.receipt.path).read_text(encoding='utf-8'))
    summary = receipt.get('proof', {}).get('timing_summary')
    if summary is None:
        return ''  # Earlier receipts may establish correctness without RGB latency.
    rows, sessions = [], []
    for key, value in summary['arms_scopes'].items():
        model, precision, scope = key.split('/')
        measurements = value['sessions']
        a = median(v['median_ms'] for v in measurements if v['session_arm'] == 'A')
        b = median(v['median_ms'] for v in measurements if v['session_arm'] == 'B')
        pairs = [v['b_minus_a_ms'] * 1000 for v in summary['paired_sessions'] if v['key'] == key]
        label = escape(f'{model} {precision.upper()}')
        rows.append((label, escape(scope), f'{a:.4f}', f'{b:.4f}',
                     f'{1000 * (b - a):+.2f}', f'{100 * (b / a - 1):+.2f}',
                     ' / '.join(f'{v:+.2f}' for v in pairs)))
        sessions.append((label, escape(scope), *(f'{v["median_ms"]:.5f}' for v in measurements)))
    return (
        '<h3 id="rgb-timing-check">Validate the real image path and separate its timing scopes</h3>'
        '<p>The 3840×2160 Cyberpunk frame was replayed through four model/precision '
        'routes in four fresh ABBA sessions. Each scope used 10 warmups and 50 '
        'samples per session, giving 2,400 samples across 12 scopes. All four '
        'model/precision outputs match across the original and FlashLight sessions. '
        'Each displayed arm value is the median of its two session medians.</p>'
        '<p><code>trunk_only</code> measures the composed PLANE16 trunk on preprocessed '
        'real-image features. <code>full_gpu</code> includes preprocessing, trunk, '
        'postprocessing and device-to-device copies; it excludes host transfers. '
        '<code>cpu_wall</code> also includes host-to-device transfer, synchronization '
        'and valid RGB readback. One-time decoding, encoding and model loading are '
        'excluded. This is stateless reconstructed RGB replay, not a vendor DLL or '
        'full-game DLSS pipeline.</p>'
        + table(('Model / precision', 'Scope', 'Original (ms)', 'FlashLight (ms)',
                 'B−A (µs)', 'Change (%)', 'Pair1 / pair2 B−A (µs)'), rows)
        + '<details><summary>Four RGB session medians</summary>'
        + table(('Model / precision', 'Scope', 'Session1 A (ms)', 'Session2 B (ms)',
                 'Session3 B (ms)', 'Session4 A (ms)'), sessions)
        + '</details><p>Values come from the published '
        f'<a href="evidence-flashlight/{escape(check.receipt.path)}">RGB receipt</a>. '
        'Training evidence establishes four FP32/BF16 AdamW and save/reload checks, '
        'not training latency; both interrupted training timing attempts are excluded. '
        'Learned FP8 export remains unsupported. Measurements were made on physical '
        'SM120; four-architecture compilation and SM80-selected PTX executed on '
        'SM120 do not establish execution on physical SM80/86/89. No current NCU '
        'counter claim is made.</p>')
