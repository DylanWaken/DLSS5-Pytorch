"""CPU-only native physical schedule; no Torch, extension, or CUDA import."""
from pathlib import Path
import hashlib, importlib.util, json, sys
H = Path(__file__).resolve().parent
R = H.parent

def load_geometry():
    p = R / 'dlssnr/geometry.py'
    s = importlib.util.spec_from_file_location('_all_reconstructed_geometry', p)
    m = importlib.util.module_from_spec(s)
    sys.modules[s.name] = m
    s.loader.exec_module(m)
    return m

def make(width=3840, height=2160):
    gmod = load_geometry()
    g = gmod.Geometry.from_valid(width, height)
    rows = []
    buffers = {}
    skips = {}
    previous = 'input'
    resets = []

    def alloc(name, h, w, c, layout, storage=None):
        logical = h * w * c
        buffers[name] = dict(shape_hwc=[h, w, c], precision='fp8', layout=layout, logical_bytes=logical, storage_bytes=logical if storage is None else storage, retain=True)
        return name
    h, w = (g.levels[0][1], g.levels[0][0])
    alloc('input', h, w, 32, 'plane16')

    def add(block, stage, symbol, module, inputs, outputs, record, grid, threads, abi, phase=None):
        rows.append(dict(position=len(rows), native_node=f'block-{block}' if isinstance(block, int) else block, block=block, stage=stage, original_symbol=symbol, module=module, precision='fp8', input_buffers=inputs, output_buffers=outputs, record_layer=record, grid=grid, block_dim=threads, abi_bytes=abi, phase=phase))
    for e in gmod.graph_schedule(g)[1:70]:
        b, c, h, w, phase = (e[k] for k in ('block', 'channels', 'height', 'width', 'phase'))
        phase = phase or 0
        if b in (31, 39):
            gh, gw = (g.levels[5][1], g.levels[5][0])
            m = gh * gw
            p = (m + 31) // 32 * 32
            to1d = b == 31
            name = 'repack-30-31' if to1d else 'repack-38-39'
            out = alloc(name, gh, gw, 1024, 'token16' if to1d else 'tile4', p * 1024 if to1d else m * 1024)
            add(name, 'repack', 'cc_vit_1d_repack_' + ('2d_to_1d' if to1d else '1d_to_2d') + '_fp8', 5, {'input': previous}, {'output': out}, None, [p, 1, 1], [256, 1, 1], 24)
            previous = out
        if c == 1024:
            m = h * w
            p = (m + 31) // 32 * 32
            slots = {n: alloc(f'b{b}.{n}', h, w, 4096 if n == 'expanded' else c, 'global_' + n.lower() if n in ('Q', 'K', 'V') else 'token16', p * (4096 if n == 'expanded' else c)) for n in ('expanded', 'contracted', 'Q', 'K', 'V', 'attended', 'output')}
            stages = [('expand', {'state': previous}, {'high': slots['expanded']}, 0, [32 * ((m + 127) // 128), 1, 1], 72), ('contract', {'state': slots['expanded'], 'residual': previous}, {'high': slots['contracted']}, 1, [8 * ((m + 127) // 128), 1, 4], 72), ('qkv', {'state': slots['contracted']}, {k.lower(): slots[k] for k in ('Q', 'K', 'V')}, 2, [16 * ((m + 127) // 128), 1, 2], 80), ('attention_chained', {k.lower(): slots[k] for k in ('Q', 'K', 'V')}, {'high': slots['attended']}, None, [32, (m + 255) // 256, 1], 64), ('projection', {'state': slots['attended'], 'residual': slots['contracted']}, {'high': slots['output']}, 4, [8 * ((m + 127) // 128), 1, 4], 72)]
            for stage, ins, outs, layer, grid, abi in stages:
                if stage in ('contract', 'qkv', 'projection', 'attention_chained'):
                    tag = 'attention' if stage == 'attention_chained' else stage
                    words = (16 if stage == 'qkv' else 32 if stage == 'attention_chained' else 8) * ((m + 127) // 128)
                    counter = f'b{b}.{tag}_counter'
                    buffers[counter] = dict(shape_hwc=None, precision='int32', layout='ordered_partition_counter', logical_bytes=words * 4, storage_bytes=words * 4, retain=True)
                    outs['completion_counter' if stage == 'attention_chained' else 'counter'] = counter
                    if stage == 'attention_chained':
                        ins['predecessor_counter'] = f'b{b}.qkv_counter'
                    else:
                        scratch = f'b{b}.{stage}_scratch'
                        n = p * 1024 * 2 * (3 if stage == 'qkv' else 1)
                        buffers[scratch] = dict(shape_hwc=None, precision='half', layout='ordered_split_scratch', logical_bytes=n, storage_bytes=n, retain=True)
                        outs['scratch'] = scratch
                suffix = stage if stage in ('qkv', 'attention_chained', 'projection') else 'ffn_' + stage
                add(b, stage, 'cc_vit_1d_' + suffix + '_fp8', 5, ins, outs, layer, grid, [32, 4, 1], abi)
            for stage, final in [('contract', 3), ('qkv', 1), ('attention', 0), ('projection', 3)]:
                resets.append(dict(before_block=b, counter=stage, initial=-1, final=final, callable='global_counter_clear_reconstructed_out', note='Reset QKV before producer only; chained attention consumes its published predecessor unchanged.'))
            previous = slots['output']
            continue
        if b == 39:
            gh, gw = (g.levels[5][1], g.levels[5][0])
            out = alloc('b39.output', h, w, c, 'tile4')
            for name, n, kind in [('b39.up_counter', 2 * ((gw + 3) // 4) * ((gh + 3) // 4) * 4, 'int32_counter'), ('b39.scratch', gh * gw * 512 * 2, 'half_split_scratch')]:
                buffers[name] = dict(shape_hwc=None, precision='physical_bytes', layout=kind, logical_bytes=n, storage_bytes=n, retain=True)
            add(b, 'output', 'cc_dec_input_upsample_1024_512_fp8', 6, {'low': previous, 'skip': skips[30]}, {'high': out, 'counter': 'b39.up_counter', 'scratch': 'b39.scratch'}, 0, [2 * ((gw + 3) // 4), (gh + 3) // 4, 4], [32, 2, 1], 80)
            resets.append(dict(before_block=39, counter='up', initial=-1, final=3, callable='global_counter_clear_reconstructed_out'))
            previous = out
            continue
        sx, sy = gmod.window_shift(phase)
        grid = [(w + sx + 7) // 8, (h + sy + 7) // 8, 1]
        if c == 512:
            slots = {n: alloc(f'b{b}.{n}', h, w, c, 'plane16' if b == 47 and n == 'output' else 'tile4') for n in ('branches', 'ffn', 'attended', 'output')}
            nx, ny = ((w + 7) // 8, (h + 7) // 8)
            inp = b == 23
            down = b == 30
            add(b, 'branches', 'cc_split_swin_16h_ffwd' + ('_inpview' if inp else '') + '_512_fp8', 4, {'state': previous}, {'high': slots['branches']}, 0, [nx, ny, 2], [32, 4 if inp else 8, 1], 56)
            add(b, 'ffn', 'cc_split_swin_16h_ffwd_proj' + ('_inpview' if inp else '') + '_512_fp8', 4, {'state': slots['branches'], 'residual': previous}, {'high': slots['ffn']}, 1, [2 * nx, ny, 1], [32, 4, 1], 72)
            add(b, 'attended', 'cc_split_swin_16h_qkv_512_fp8', 4, {'state': slots['ffn']}, {'high': slots['attended']}, 2, [*grid[:2], 4], [32, 4, 1], 56, phase)
            symbol = 'cc_split_swin_16h_proj_pool_512_fp8' if down else 'cc_split_swin_16h_proj_512_outview_fp8' if b == 47 else 'cc_split_swin_16h_proj_512_fp8'
            outputs = {'high': slots['output']}
            if down:
                dh, dw = (((h + 1) // 2 + 3) // 4 * 4, ((w + 1) // 2 + 3) // 4 * 4)
                outputs['pool'] = alloc('b30.pool', dh, dw, c, 'tile4')
            add(b, 'output', symbol, 4, {'state': slots['attended'], 'residual': slots['ffn']}, outputs, 3, [2 * nx, ny, 1], [32, 4 if down or b == 47 else 8, 1], 80 if down else 72)
            previous = slots['output']
            if down:
                skips[b] = previous
                out = alloc('b30.down', dh, dw, 1024, 'tile4')
                add(b, 'down', 'cc_split_swin_16h_final_head_512_fp8', 4, {'state': outputs['pool']}, {'high': out}, 4, [4 * ((dw + 7) // 8), (dh + 7) // 8, 1], [32, 8, 1], 40)
                previous = out
            continue
        down = b in (4, 8, 14, 22)
        up = b in (48, 56, 62, 66)
        view = 'input' if b in (1, 5, 9, 15) else 'output' if b in (55, 61, 65) else 'none'
        suffix = '_ds' if down else '_upsample' if up else '_inpview' if view == 'input' else '_outview' if view == 'output' else ''
        symbol = f'cc_tinlayout_fused_swin_{c // 32}h_{c}_{c // 32}' + suffix + '_fp8'
        out = alloc(f'b{b}.output', h, w, c, 'plane16' if view == 'output' else 'tile4')
        inputs = {'state': previous}
        outputs = {'high': out}
        if up:
            inputs['skip'] = skips[{48: 22, 56: 14, 62: 8, 66: 4}[b]]
        if down:
            dh, dw = (((h + 1) // 2 + 3) // 4 * 4, ((w + 1) // 2 + 3) // 4 * 4)
            padded = h != 2 * dh or w != 2 * dw
            outputs['down'] = alloc(f'b{b}.down', dh, dw, 2 * c, 'plane16', dh * dw * 2 * c * (2 if padded else 1))
            skips[b] = out
        add(b, 'fused', symbol, {32: 0, 64: 1, 128: 2, 256: 3}[c], inputs, outputs, 0, grid, [32, c // 32, 1], 96 if c == 32 else 88, phase)
        previous = outputs['down'] if down else out
    inputs = {v for x in rows for v in x['input_buffers'].values()}
    produced = {v for x in rows for v in x['output_buffers'].values()}
    if not (len(rows) == 152 and len(resets) == 33 and (inputs - produced == {'input'})):
        raise ValueError('physical schedule census')
    return dict(status='CPU_NATIVE_PHYSICAL_SCHEDULE_NOT_RUNTIME_QUALIFIED', valid=[width, height], levels=g.levels, precision='fp8', compute_positions=152, counter_reset_positions=33, positions=rows, buffers=buffers, reset_protocol=resets, output_buffer=previous, skip_buffers=skips, alias_rule='Successor consumes the producer allocation at offset 0 with its exact logical extent; retain the entire guarded backing allocation, including any padding-clear workspace.', no_per_block_layout_kernels=True, mandatory_repack_positions=['repack-30-31', 'repack-38-39'], scope='Original resident blocks1..69. Frontend0/output70 are separate root-owned gaps. Half symbol/layout catalogs do not imply full-resolution Half host admission.', source_pins={p: hashlib.sha256((R / p).read_bytes()).hexdigest() for p in ('dlssnr/geometry.py', 'tools/native_reference/trunk.py', 'tools/native_reference/vendor_global_block.py', 'tools/native_reference/vendor_window512_block.py', 'tools/native_reference/native_fused.py', 'tools/native_reference/vendor_connectors.py', 'tools/native_reference/vendor_window_benchmark.py', 'tools/native_reference/vendor_downsample_probe.py')})
