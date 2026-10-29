"""Operator → implementation variant → channel width, covering each entry once."""
from html import escape
import re

OPERATORS = [
    ('ffn', 'FFN', 'Feed-forward channel mixing: grouped MLPs, dense bottleneck matrices, and postmix projections.'),
    ('attention', 'Attention', 'Window and global attention, plus their separately launched QKV and output projections.'),
    ('fused', 'Fused FFN + attention', 'Complete local transformer blocks. Their FFN and attention stages share one kernel.'),
    ('downsample', 'Downsampling', 'Encoder transitions: fused blocks, pooling, and the following channel expansion.'),
    ('upsample', 'Upsampling', 'Decoder transitions: channel projection, spatial repetition, and skip merging.'),
    ('frontend', 'Input / output processing', 'Renderer-feature preparation and final image composition around the C32 transformer.'),
    ('layout', 'Layout conversion', 'Packed-word permutations between spatial tiles and the global token sequence.'),
    ('scheduling', 'Scheduling', 'Control-state initialization for dependent split-reduction launches.'),
]


def classify(base):
    """Return operator, variant, input width, channel label and boundary role."""
    local=re.fullmatch(r'window_block_c(32|64|128|256)(.*)',base)
    if local:
        c=int(local[1]);mode=local[2]
        if mode=='_downsample':return 'downsample','Window block + 2×2 pooling + channel projection',c,f'C{c} → C{2*c}','Save skip and downsample'
        if mode=='_upsample':return 'upsample','Projection + skip merge + window block',2*c,f'C{2*c} → C{c}','Upsample and transform'
        variant='Dense FFN + window attention' if c==32 else 'Full-input branched FFN + window attention'
        return 'fused',variant,c,f'C{c}',{'':'Native tiled input / output','_input_view':'Channel-plane input','_output_view':'Channel-plane output'}[mode]
    mapping={
        'window_ffn_c512':('ffn','Grouped FFN: dense premix + eight 64→256→64 MLPs',512,'C512','Native tiled input'),
        'window_ffn_input_view_c512':('ffn','Grouped FFN: dense premix + eight 64→256→64 MLPs',512,'C512','Channel-plane input'),
        'window_ffn_projection_c512':('ffn','Dense postmix + scaled residual',512,'C512','Native tiled residual'),
        'window_ffn_projection_input_view_c512':('ffn','Dense postmix + scaled residual',512,'C512','Channel-plane residual'),
        'global_ffn_expand_c1024':('ffn','Dense bottleneck FFN',1024,'C1024 → C4096 → C1024','Expansion: C1024 → C4096 + activation'),
        'global_ffn_contract_c1024':('ffn','Dense bottleneck FFN',1024,'C1024 → C4096 → C1024','Contraction: C4096 → C1024 + residual'),
        'window_qkv_c512':('attention','Window attention: fused QKV + attention',512,'C512 · 16 heads × 32 channels','QKV, normalization, window scores and weighted values'),
        'global_attention_chained_c1024':('attention','Global attention: streamed queries / keys / values',1024,'C1024 · 32 heads × 32 channels','Streamed global attention'),
        'small_global_attention_chained_c1024':('attention','Small31 global attention: persistent FP32 accumulation',1024,'C1024 · 32 heads × 32 channels','Streamed attention with FP32 numerator and denominator'),
        'global_qkv_c1024':('attention','Global attention: QKV projection',1024,'C1024 · 32 heads × 32 channels','QKV projection, normalization and V transpose'),
        'window_attention_projection_c512':('attention','Window attention: output projection + residual',512,'C512','Native tiled output'),
        'window_attention_projection_output_view_c512':('attention','Window attention: output projection + residual',512,'C512','Channel-plane output'),
        'global_projection_c1024':('attention','Global attention: output projection + residual',1024,'C1024','Dense output projection'),
        'input_preprocess_window_downsample_c32':('downsample','Input preprocessing + window block + pooling',32,'C32 → pooled C32','Prepare features, save full-resolution output and pool'),
        'window_attention_projection_pool_c512':('downsample','Window attention projection + 2×2 pooling',512,'C512 → pooled C512','Save skip and pool raw projection output'),
        'channel_projection_c512_to_c1024':('downsample','Channel expansion after pooling',512,'C512 → C1024','Pointwise channel projection; spatial pooling is the preceding kernel'),
        'decoder_upsample_c1024_to_c512':('upsample','Dense projection + nearest repetition + skip merge',1024,'C1024 → C512','Bottleneck-to-decoder transition'),
        'input_preprocess_window_c32':('frontend','Input features + fused window block',32,'C32','Renderer input adapter and transformer'),
        'output_window_postprocess_c32':('frontend','Output merge + fused window block + image composition',32,'C32','Final head, history blend and surface output'),
        'repack_2d_to_1d_c1024':('layout','Spatial tiles → token sequence',1024,'C1024','Forward repack, including token padding'),
        'repack_1d_to_2d_c1024':('layout','Token sequence → spatial tiles',1024,'C1024','Inverse repack'),
        'completion_counter_clear':('scheduling','Completion-counter initialization',0,'Channel-independent · int32 counters','Clear split-progress counters'),
    }
    return mapping[base]


def render_catalog(lessons):
    pairs={}
    for p in lessons:
        base=re.sub(r'_fp(?:8|16)$','',p['name'])
        precision='FP8' if p['name'].endswith('fp8') else 'FP16' if p['name'].endswith('fp16') else 'Common'
        pairs.setdefault(base,{})[precision]=p
    tree={key:{} for key,_,_ in OPERATORS}
    for base,precisions in pairs.items():
        op,variant,width,channels,role=classify(base)
        tree[op].setdefault(variant,{}).setdefault((width,channels),[]).append((base,role,precisions))
    nav='<nav class="operator-jumps" aria-label="Operator types">'+''.join(f'<a href="#operator-{key}">{label}</a>' for key,label,_ in OPERATORS)+'</nav>'
    html=[nav,'<div class="kernel-catalog">']
    for key,label,description in OPERATORS:
        variants=tree[key]
        count=sum(len(p) for channels in variants.values() for rows in channels.values() for _,_,p in rows)
        unit = 'lesson' if count == 1 else 'lessons'
        html.append(f'<section class="operator-group" data-catalog-group><h2 id="operator-{key}">{label} <span class="catalog-count">{count} {unit}</span></h2><p class="operator-description">{description}</p>')
        for variant,channels in variants.items():
            html.append(f'<section class="variant-group" data-catalog-group><h3>{escape(variant)}</h3>')
            for (_,channel),rows in sorted(channels.items()):
                html.append(f'<section class="channel-group" data-catalog-group><h4>{escape(channel)}</h4><ul class="kernel-roles">')
                for base,role,precisions in rows:
                    search=' '.join([label,variant,channel,base,role,'attn' if key=='attention' else '', 'down sample' if key=='downsample' else 'up sample' if key=='upsample' else ''])
                    links=' '.join(f'<a class="lesson-link" href="{precisions[p]["slug"]}.html">{p} lesson →</a>' for p in ('FP16','FP8','Common') if p in precisions)
                    html.append(f'<li class="kernel-role" data-search="{escape(search,quote=True)}" data-lessons="{len(precisions)}"><div><strong>{escape(role)}</strong><code>{escape(base)}</code></div><div class="precision-links">{links}</div></li>')
                html.append('</ul></section>')
            html.append('</section>')
        html.append('</section>')
    html.append('</div><p id="catalog-empty" hidden>No matching kernels. Try an operator, variant, channel width, or public entry name.</p>')
    return ''.join(html)
