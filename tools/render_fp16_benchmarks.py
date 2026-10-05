"""Render the measured FP16 trunk comparison as a standalone SVG."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    data = json.loads((ROOT / 'docs/figures/fp16_deployment_measurements.json').read_text())
    rows = data['samples']
    svg = ['<svg xmlns="http://www.w3.org/2000/svg" width="1120" height="560" viewBox="0 0 1120 560" role="img" aria-labelledby="title desc">',
           '<title id="title">FP16 deployment versus original extracted kernels</title>',
           '<desc id="desc">Four measured resolutions on RTX PRO 6000 Blackwell. All per-order median ratios are within the accepted one-percent slowdown limit.</desc>',
           '<rect width="1120" height="560" rx="20" fill="#f6f8fc"/>',
           '<style>text{font-family:Segoe UI,Arial,sans-serif;fill:#172a43}.muted{fill:#52647c}</style>',
           '<text x="42" y="48" font-size="26" font-weight="700">FP16 deployment: original vs reconstructed</text>',
           '<text x="42" y="77" font-size="15" class="muted">Prepared-feature trunk, blocks 1-69 | SM120 | batch 1 | lower latency is better</text>',
           '<rect x="42" y="99" width="16" height="16" fill="#7893b5"/><text x="67" y="113" font-size="14">Original extracted kernels</text>',
           '<rect x="295" y="99" width="16" height="16" fill="#127e89"/><text x="320" y="113" font-size="14">CUDA/C++ reconstruction</text>']
    scale = 54
    for index,row in enumerate(rows):
        y=155+index*85
        svg += [f'<text x="42" y="{y+16}" font-size="19" font-weight="600">{row["label"]}</text>',
                f'<text x="42" y="{y+37}" font-size="12" class="muted">{row["width"]} x {row["height"]}</text>']
        for offset,key,color in ((0,'native_ms','#7893b5'),(27,'candidate_ms','#127e89')):
            value=row[key];width=value*scale
            svg += [f'<rect x="188" y="{y+offset}" width="{width:.2f}" height="21" rx="4" fill="{color}"/>',
                    f'<text x="{198+width:.2f}" y="{y+offset+16}" font-size="14">{value:.3f} ms</text>']
        delta=(row['ratio']-1)*100
        svg += [f'<text x="1000" y="{y+29}" text-anchor="middle" font-size="18" font-weight="600">{delta:+.2f}%</text>']
    svg += ['<text x="42" y="512" font-size="14" class="muted">64 alternating pairs; medians from resident CUDA graphs. Both execution orders pass at every resolution.</text>',
            '<text x="42" y="537" font-size="13" class="muted">Excludes input/output stages and DLL host work. Source data: fp16_deployment_measurements.json.</text>', '</svg>']
    (ROOT / 'docs/figures/deployment_fp16_resolutions.svg').write_text('\n'.join(svg)+'\n',encoding='utf-8')


if __name__ == '__main__':
    main()
