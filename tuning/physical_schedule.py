"""CPU-only native physical schedule; no Torch, extension, or CUDA import."""
from pathlib import Path
import hashlib, importlib.util, json, sys
H = Path(__file__).resolve().parent
R = H.parent
if str(R) not in sys.path:
    sys.path.insert(0, str(R))
from dlssnr.model_specs import resolve_model

def load_geometry():
    p = R / 'dlssnr/geometry.py'
    s = importlib.util.spec_from_file_location('_all_reconstructed_geometry', p)
    m = importlib.util.module_from_spec(s)
    sys.modules[s.name] = m
    s.loader.exec_module(m)
    return m

# Independent symbol-roster pins, not the schedule row census.
_EXPECTED_UNIQUE_SYMBOLS = {'legacy71': 36, 'small31': 33}


def _retained_roles(spec):
    """Native trunk roles; the pre/post roots stay separate plan edges."""
    return tuple(role for role in spec.roles if role not in (spec.pre_role, spec.post_role))


def _role_level(role, gmod):
    channels = gmod.block_channels(role)
    if channels == 1024:
        return 5
    try:
        return {32: 0, 64: 1, 128: 2, 256: 3, 512: 4}[channels]
    except KeyError as exc:
        raise ValueError(f'role {role} has no spatial level') from exc


def _expected_compute_positions(spec, roles, gmod):
    """Independent row census from the retained role roster, including repacks."""
    count = 0
    for role in roles:
        if role in (31, 39):
            count += 1  # 2D <-> 1D repack connector
        if 31 <= role <= 38:
            count += 5  # expand, contract, qkv, chained attention, projection
        elif role == 39:
            count += 1  # transition-only upsample
        elif gmod.block_channels(role) == 512:
            count += 4 + (1 if role == 30 else 0)  # optional downsample final head
        else:
            count += 1
    return count


def _expected_record_positions(spec, roles, gmod):
    """Independent record roster; repacks carry no packed weight record."""
    count = 0
    for role in roles:
        if 31 <= role <= 38:
            count += 4  # the native layer-3 slot is not dispatched
        elif role == 39:
            count += 1
        elif gmod.block_channels(role) == 512:
            count += 4 + (1 if role == 30 else 0)
        else:
            count += 1
    return count


def _expected_reset_positions(roles):
    return 4 * sum(1 for role in roles if 31 <= role <= 38) + (1 if 39 in roles else 0)


def make(width=3840, height=2160, *, precision="fp8", model='legacy71'):
    if precision not in ('fp8', 'fp16'):
        raise ValueError('unsupported deployment precision')
    spec = resolve_model(model)
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

    roles = _retained_roles(spec)
    raw_for_role = {role: spec.raw_for_role(role) for role in roles}
    if spec.id == 'legacy71':
        phase_for_role = {entry['block']: entry['phase'] for entry in gmod.graph_schedule(g)}
    else:
        phase_for_role = {role: spec.phase_for_role(role) for role in roles}

    def add(block, stage, symbol, module, inputs, outputs, record, grid, threads, abi, phase=None):
        rows.append(dict(position=len(rows), native_node=f'block-{block}', block=block,
                         role=block if isinstance(block, int) else None,
                         raw_block=raw_for_role.get(block) if isinstance(block, int) else None,
                         stage=stage, original_symbol=symbol, module=module, precision='fp8',
                         input_buffers=inputs, output_buffers=outputs, record_layer=record,
                         grid=grid, block_dim=threads, abi_bytes=abi, phase=phase))
    for b in roles:
        c = gmod.block_channels(b)
        h, w = (g.levels[_role_level(b, gmod)][1], g.levels[_role_level(b, gmod)][0])
        phase = phase_for_role[b] or 0
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
                if spec.id == 'small31' and stage == 'attention_chained':
                    # Additive Small31-only safe export; legacy rows carry no safe_export.
                    rows[-1]['safe_export'] = 'small_global_attention_chained_c1024_fp8'
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
    if precision == 'fp16':
        # Half uses independent K16/plane16 layouts, direct global reductions,
        # and a different decoder scratch slot. No activation-byte reinterpretation.
        c512 = {e['original_symbol']: e for e in json.loads((H / 'reconstruction/c512.json').read_text())['entries']}
        for name in list(buffers):
            value = buffers[name]
            if name.endswith('_scratch'):
                del buffers[name]
            elif value['precision'] == 'fp8':
                value['precision'] = 'fp16'
                value['logical_bytes'] *= 2
                value['storage_bytes'] *= 2
        for row in rows:
            row['precision'] = 'fp16'
            row['original_symbol'] = row['original_symbol'].removesuffix('_fp8')
            if 'safe_export' in row:
                row['safe_export'] = row['safe_export'].removesuffix('_fp8') + '_fp16'
            if row['module'] == 5:
                row['output_buffers'].pop('scratch', None)
                if row['stage'] == 'repack': row['grid'][0] *= 2
            if row['original_symbol'] in c512:
                row['block_dim'] = c512[row['original_symbol']]['block']
    inputs = {v for x in rows for v in x['input_buffers'].values()}
    produced = {v for x in rows for v in x['output_buffers'].values()}
    expected_compute = _expected_compute_positions(spec, roles, gmod)
    expected_resets = _expected_reset_positions(roles)
    expected_records = _expected_record_positions(spec, roles, gmod)
    unique_symbols = len({row['original_symbol'] for row in rows})
    emitted_records = len({(row['raw_block'], row['record_layer']) for row in rows
                           if row['record_layer'] is not None})
    if (len(rows), len(resets), emitted_records) != (expected_compute, expected_resets, expected_records):
        raise ValueError(f'{spec.id} physical schedule census: computed '
                         f'{(len(rows), len(resets), emitted_records)}, expected '
                         f'{(expected_compute, expected_resets, expected_records)}')
    if unique_symbols != _EXPECTED_UNIQUE_SYMBOLS[spec.id]:
        raise ValueError(f'{spec.id} unique operator census: computed {unique_symbols}, '
                         f'expected {_EXPECTED_UNIQUE_SYMBOLS[spec.id]}')
    if inputs - produced != {'input'}:
        raise ValueError(f'{spec.id} physical schedule has unresolved inputs: {sorted(inputs - produced)}')
    if previous != 'b69.output':
        raise ValueError(f'{spec.id} trunk result must be b69.output, got {previous}')
    return dict(status='CPU_NATIVE_PHYSICAL_SCHEDULE_NOT_RUNTIME_QUALIFIED', model=spec.id,
                valid=[width, height], levels=g.levels, precision=precision,
                compute_positions=len(rows), counter_reset_positions=len(resets),
                positions=rows, buffers=buffers, reset_protocol=resets,
                output_buffer=previous, skip_buffers=skips,
                census=dict(compute_positions=len(rows), counter_reset_positions=len(resets),
                            calls=len(rows) + len(resets), record_positions=expected_records,
                            unique_symbols=unique_symbols),
                alias_rule='Successor consumes the producer allocation at offset 0 with its exact logical extent; retain the entire guarded backing allocation, including any padding-clear workspace.', no_per_block_layout_kernels=True, mandatory_repack_positions=['repack-30-31', 'repack-38-39'], scope=('Small31 raw records 0..30 mapped onto legacy operation roles; pre/post roots remain separate.' if spec.id == 'small31' else 'Original resident blocks1..69. Frontend0/output70 are separate root-owned gaps. Half symbol/layout catalogs do not imply full-resolution Half host admission.'), source_pins={p: hashlib.sha256((R / p).read_bytes()).hexdigest() for p in ('dlssnr/geometry.py', 'tools/native_reference/trunk.py', 'tools/native_reference/vendor_global_block.py', 'tools/native_reference/vendor_window512_block.py', 'tools/native_reference/native_fused.py', 'tools/native_reference/vendor_connectors.py', 'tools/native_reference/vendor_window_benchmark.py', 'tools/native_reference/vendor_downsample_probe.py')})
