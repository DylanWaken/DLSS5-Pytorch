"""Source-specific geometry for every public entry, not a generic GEMM schedule.

M/N below describe the named focus operation, not necessarily the kernel output.
The executable source remains authoritative; these records drive teaching SVGs.
"""
import re


def stage(label, m, k, n, storage, detail, scope=None):
    result = dict(label=label, m=m, k=k, n=n, storage=storage, detail=detail)
    if scope is not None:
        result['scope'] = scope
    return result


def profile(name, entry):
    fp8=name.endswith('fp8'); e=1 if fp8 else 2; ik=32 if fp8 else 16
    p=dict(name=name, source='csrc/'+entry['header'], args=entry.get('template_arguments',''),
           fp8=fp8, e=e, ik=ik, fmt='E4M3' if fp8 else 'Half', kind='', c=0,
           stages=[], splits=1, slots=0, slotbytes=0, step=ik, shared=0,
           input='native packed tiles', output='native packed tiles', shared_kind='none',
           matrix='learned W', m_axis='tokens', n_axis='channels', notes=[])
    local=re.match(r'window_block_c(32|64|128|256)(.*)_fp(?:8|16)$',name)
    front=name.startswith(('input_preprocess','output_window'))
    if local or front:
        c=int(local[1]) if local else 32
        mode=local[2].strip('_') or 'ordinary' if local else 'input' if name.startswith('input_') else 'output'
        h=c//32
        p.update(kind='window', c=c, mode=mode, heads=h, m=64, n=4*c, k=c,
                 cm=64, cn=4*c, wm=32 if c==64 else 64, wn=4*c if c==64 else 128,
                 warps=h, focus='FFN expansion', matrix='Wexpand' if c==32 else 'concatenated branch Wexpand',
                 shared=64*c*e if c>32 else 0, shared_kind='exchange' if c>32 else 'none')
        if mode=='input_view':p['input']='channel planes → native A gather'
        if mode=='output_view':p['output']='native D → channel planes'
        if mode=='upsample':
            p['input']=f'low C{2*c} + high C{c} skip'
            p['stages'] += [stage('Project low features',16,2*c,c,'registers',f'one low 4×4 tile; {2*c}→{c}'),stage('Repeat + skip merge',64,0,c,'registers','low (y/2,x/2) → four high pixels')]
        if mode=='input':
            p.update(input='renderer textures → Half features',shared=2048,shared_kind='features')
            p['stages'] += [stage('Construct features',64,0,16,'shared','two Half C8 planes; 64 pixels each'),stage('Half adapter',64,16,32,'registers','FP16 MMA even in the FP8 entry')]
        if mode=='output':
            p.update(input='low C32 + full-resolution skip', output='four-channel head / display surface')
            p['stages'] += [stage('Repeat + learned merge',64,0,32,'registers','low features + record-0 skip')]
        p['stages'] += [stage('Expand + activation',64,c,128 if c>32 else 128,'registers',f'{h} full-input branches' if c>32 else 'one dense 32→128 matrix'),
                        stage('Contract',64,128,32,'registers',f'{h} branch C32 panels' if c>32 else '128→32; scaled X residual')]
        if c>32:p['stages'] += [stage('Mix + residual',64,c,c,'registers' if c==64 else 'shared','C64: branch publications + mix in registers; final Z → shared' if c==64 else 'shared branch panels → dense mix → published Z')]
        p['stages'] += [stage('Q / K / V',64,c,96,'registers',f'{h} heads; each reads all C{c}; Q/K norm'),
                        stage('Q × Kᵀ',64,32,64,'registers','one score row per query; learned bias'),
                        stage('Normalize; P × V',64,64,32,'registers','row sum over 64 keys; publish P'),
                        stage('Head mix + residual',64,c,c,'registers',f'{"shared " if c>32 else "register "}attended heads → C{c}; scaled residual')]
        if mode=='downsample':
            p['output']=f'high C{c} skip + pooled C{2*c} planes'
            p['stages'] += [stage('Pool raw output',16,0,c,'registers','four high pixels → one low token'),stage('Channel transition',16,c,2*c,'global','publish channel-plane destination')]
        elif name.startswith('input_preprocess_window_downsample'):
            p['output']='full C32 skip + pooled C32'
            p['stages'] += [stage('Save high; pool raw',16,0,32,'global','2×2 mean; no channel expansion')]
        elif mode=='output':p['stages'] += [stage('Half head + composition',64,32,4,'global','FP16 head; optional history blend')]
        else:p['stages'] += [stage('Publish output',64,0,c,'global',p['output'])]
        p['notes']=[f'{h} warp'+('' if h==1 else 's')+' per 8×8 window; '+('unshifted physical-image grid.' if mode=='input' else 'origin selects shifted phase.'),
                    'C64: each warp expands every branch on its two token tiles.' if c==64 else f'Warp h owns branch h and then attention head h.' if c>64 else 'All four M16 token tiles stay in one warp.',
                    'C256 retains four query tiles; C64/C128 exchange attended panels in two-tile batches.' if c>32 else 'No shared slab for the C32 transformer body; shuffles move register values.']
        return p
    if name.startswith('repack_'):
        p.update(kind='repack',c=1024,warps=8,words=256 if fp8 else 512,forward='2d_to_1d' in name)
        p['input']='spatial tiles' if p['forward'] else 'token sequence'
        p['output']='token sequence + zero tail' if p['forward'] else 'spatial tiles (valid tokens only)'
        return p
    if name=='completion_counter_clear':
        p.update(kind='counter',warps=8,input='CounterCount',output='int32 sentinel −1')
        return p
    if name.startswith('global_attention'):
        p.update(kind='global-attention',c=1024,heads=32,m=2160,n=2160,k=32,
                 cm=256,cn=64,wm=64,wn=64,warps=4,focus='Q × Kᵀ for one streamed key tile',
                 matrix='Kᵀ (not learned weights)',slots=2,slotbytes=2048*e,shared=8192*e+16,
                 shared_kind='kv',step=32,input='Q / K / transposed V',output='attended C1024 token layout',n_axis='keys')
        p['stages']=[stage('Retain Q once',256,0,32,'registers','four M16 query tiles / warp','one CTA / one head'),stage('Stage K and V',64,0,32,'shared','ping-pong slots; reuse across 256 queries','one CTA / one key tile'),stage('Q × Kᵀ',256,32,64,'registers','scores for the current 64-key tile','one CTA / one key tile'),stage('Surrogate E + row sum',256,0,64,'registers','denominator uses Half E, before operand packing','one CTA / one key tile'),stage('Publish E; E × V',256,64,32,'registers','accumulate numerator across all key tiles','one CTA / one key tile'),stage('Tail correction + divide',256,0,32,'global','subtract padded-key mass; publish this query slice','one CTA / final output')]
        p['notes']=['Grid X selects one of 32 heads; Y selects a 256-query block.','At 4K: T=2160; the key traversal has 34 tiles = 2176 positions.','Q, numerator and denominator survive the entire key loop; scores do not.']
        return p
    if name.startswith('global_'):
        expand=name.startswith('global_ffn_expand'); qkv=name.startswith('global_qkv'); proj=name.startswith('global_projection')
        k=1024 if expand or qkv or proj else 4096
        n=4096 if expand else 3072 if qkv else 1024
        step=64 if fp8 and (expand or not(qkv or proj)) else 32
        slots=3 if expand or (not fp8 and not(qkv or proj)) else 2
        sb=128*step*e
        p.update(kind='global-linear',c=1024,m=2160,n=n,k=k,cm=128,cn=192 if qkv else 128,
                 wm=64,wn=96 if qkv else 64,warps=4,step=step,slots=slots,slotbytes=sb,
                 shared=slots*(sb+8),shared_kind='ring',splits=1 if expand else 2 if qkv else 4,
                 focus='QKV projection' if qkv else 'FFN expansion' if expand else 'Attention output projection' if proj else 'FFN contraction')
        # The overview contains whole-model math and one explicitly labeled
        # staging/partial example. Never give a CTA all model N columns or K splits.
        p['stages']=[stage('Stage input K slice',128,0,step,'shared',f'{slots} slots; {sb} B / slot','one CTA / one K step'),stage(p['focus'],p['m'],k,n,'registers',f'Distributed over CTAs: each computes 128×{p["cn"]} over K{k//p["splits"]}.','whole model / distributed')]
        if p['splits']>1:p['stages'] += [stage('Ordered split handoff',128,0,p['cn'],'global',f'{p["splits"]} K{k//p["splits"]} splits; scratch remains Half','one CTA output slice')]
        if expand:p['stages'] += [stage('Recovered activation',p['m'],0,n,'registers','Half polynomial per output; values remain with their owning lanes','whole model / distributed')]
        if qkv:
            p.update(output='Q / K native; V transposed', matrix='Wqkv after 128-byte head-scale prefix')
            p['stages'] += [stage('Normalize Q and K',p['m'],0,32,'registers','Repeat independently for 32 heads; Q-only scale × √32','one head / one component'),stage('Publish Q, K; transpose V',p['m'],0,3072,'global','Three separate [T,1024] buffers with consumer layouts','whole model / three buffers')]
        else:
            p['stages'] += [stage('Publish '+('U' if expand else 'Y' if proj else 'Z'),p['m'],0,n,'global','activation output' if expand else 'scaled residual is seeded once; final split publishes','whole model / final tensor')]
        p['notes']=[f'Warp row = w//2; warp column = w%2. Each warp owns 4×{p["wn"]//16} M16×N16 accumulator tiles.',f'K{k} / {p["splits"]} split(s) / K{step} per stage = {k//p["splits"]//step} stage consumptions per CTA.', 'A tiles are staged; packed B weights load directly into registers and are reused over four M16 tiles.']
        return p
    grouped=name.startswith(('window_ffn_c512','window_ffn_input_view'))
    qkv=name.startswith('window_qkv'); decoder=name.startswith('decoder_upsample'); channel=name.startswith('channel_projection')
    pool=name.startswith('window_attention_projection_pool')
    attn=name.startswith('window_attention_projection_c512')
    view='input_view' in name and grouped
    warps=(4 if view or not fp8 else 8) if grouped else 2 if decoder else 8 if channel or attn else 4
    k=1024 if decoder else 512; n=512 if decoder else 1536 if qkv else 1024 if channel else 512
    step=(64 if fp8 else 16) if qkv else (64 if fp8 else 32)
    slots=2 if grouped or qkv or decoder or pool else 3
    sb=1024 if decoder else (4096 if fp8 else 2048) if qkv else 4096
    wm=16 if decoder else 32 if warps==8 else 64
    wn=128 if decoder else 96 if qkv else 64
    p.update(kind='c512',c=512,m=2160 if channel or decoder else 8160,n=n,k=k,cm=16 if decoder else 64,
             cn=384 if qkv else 256,wm=wm,wn=wn,warps=warps,step=step,slots=slots,slotbytes=sb,
             shared=slots*(sb+8),shared_kind='gather' if view else 'ring',splits=4 if decoder else 1,
             focus='Dense premix' if grouped else 'QKV projection' if qkv else 'Low-resolution projection' if decoder else 'Channel expansion' if channel else 'Dense postmix' if 'ffn' in name else 'Attention head mix')
    if view:p['input']='channel-plane gather (4-byte copies)'
    if 'projection_input_view' in name:p['input']='native B + channel-plane residual X'
    if 'output_view' in name:p['output']='channel-plane output'
    if pool:p['output']='high native skip + pooled native C512'
    if decoder:p.update(input='low native C1024 + high C512 skip',output='cropped high native C512')
    p['stages']=[stage('Stage input',p['cm'],0,step,'shared',f'{slots} slots × {sb} B; '+('word gather' if view else 'packed native stripes')),
                 stage(p['focus'],p['cm'],k,96 if qkv else 256,'registers',f'{warps} warps; each {wm} tokens × {wn} outputs')]
    if grouped:
        p['stages'] += [stage('Expand group + activate',wm,64,32,'registers','eight successive hidden C32 panels per group'),stage('Contract hidden panel',wm,32,64,'registers','accumulate all eight panels; no hidden image'),stage('Publish branches B',64,0,256,'global','four of eight groups / CTA; postmix is a later kernel')]
    elif qkv:
        p['stages'] += [stage('Normalize; publish Q/K/V',64,0,96,'registers','head = 4·block.z + warp; V becomes B'),stage('Q × Kᵀ + bias',64,32,64,'registers','FP8 pairs query tiles; FP16 processes one at a time'),stage('Normalize; P × V',64,64,32,'registers','64-key row sum before value multiplication'),stage('Publish attended heads',64,0,128,'global','four heads / CTA; output projection is separate')]
    elif decoder:
        p['stages'] += [stage('Ordered split merge',16,0,256,'global','four K256 contributions; Half scratch'),stage('Repeat and scaled skip',64,0,256,'registers','one low token → 2×2 high pixels'),stage('Crop and publish',64,0,256,'global','72×120 repeated field cropped to 68×120 at 4K')]
    else:
        if not channel:p['stages'] += [stage('Scaled residual',64,0,256,'registers','input-view applies to residual only' if 'input_view' in name else 'raw Half result is retained until final store')]
        p['stages'] += [stage('Publish result',64,0,256,'global',p['output'])]
        if pool:p['stages'] += [stage('Pool raw result',16,0,256,'global','2×2 mean; no channel doubling in this entry')]
    p['notes']=[f'{warps} warps × {wm} tokens × {wn} outputs = {p["cm"]}×{p["cn"]} CTA outputs for the focus projection.',
                'Grid Z selects four FFN groups; group = warp%4 + 4·block.z.' if grouped else 'Grid Z selects four heads; head = warp + 4·block.z.' if qkv else 'Grid XY selects spatial tiles and a channel slab; decoder Z selects K split.',
                f'K{k//p["splits"]} / K{step} = {k//p["splits"]//step} staged reduction iterations; {step//ik} MMA K panels each.']
    return p
