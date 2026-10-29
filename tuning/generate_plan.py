"""Generate the fixed, original-layout FP8 trunk schedule for the clean C++ API.

This is offline code generation, not Python inference dispatch. Every repeated
network instance references one shared reconstructed kernel host stub.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PREP = Path(__file__).resolve().parent
OUT = ROOT / 'csrc' / 'kernel_launcher'
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))
from dlssnr.model_specs import LEGACY71, resolve_model

# Additive Small31-only exports. They reuse the unchanged canonical attention
# parameter structs; the kernels keep a persistent FP32 PV numerator and an FP32
# denominator internally, so the native ABI does not move. Legacy generation
# never emits these names and stays byte-identical.
SAFE_ATTENTION_ALIASES = {
    'small_global_attention_chained_c1024_fp8': 'global_attention_chained_c1024_fp8',
    'small_global_attention_chained_c1024_fp16': 'global_attention_chained_c1024_fp16',
}

def load(name):
    return json.loads((PREP / name).read_text(encoding='utf-8'))

def load_template_resolvers():
    """Resolve logical names to same-TU getters, independent of CUDA mangling."""
    source = (ROOT / 'csrc/kernel_impl/shared/common/kernel_abi.h').read_text(encoding='utf-8')
    return {
        entry: resolver for resolver, entry in re.findall(
            r'extern\s+"C"\s+const\s+void\s*\*\s*(Resolve_(\w+))\s*\(\s*\)\s*;', source)
    }


def kernel_address(entry, resolvers):
    return f'{resolvers[entry]}()' if entry in resolvers else f'reinterpret_cast<const void*>(&{entry})'


def load_abi_fields():
    """Read names from compiler-checked offsets, resolving shared ABI aliases.

    Generation fails when a written offset has no checked field. Neither the
    generated plans nor a second schema can silently redefine the native ABI.
    """
    source = (ROOT / 'csrc' / 'kernel_impl' / 'shared' / 'common' / 'kernel_abi.h').read_text(encoding='utf-8')
    fields_by_type = {}
    for parameter_type, field, offset in re.findall(
            r'offsetof\((\w+),\s*(\w+)\)\s*==\s*(\d+)', source):
        fields = fields_by_type.setdefault(parameter_type, {})
        offset = int(offset)
        if offset in fields and fields[offset] != field:
            raise ValueError(f'conflicting ABI names for {parameter_type} byte {offset}')
        fields[offset] = field
    aliases = dict(re.findall(r'using\s+(\w+)\s*=\s*(\w+)\s*;', source))
    while aliases:
        resolved = [alias for alias, target in aliases.items() if target in fields_by_type]
        if not resolved:
            raise ValueError(f'unresolved ABI aliases: {aliases}')
        for alias in resolved:
            fields_by_type[alias] = fields_by_type[aliases.pop(alias)]
    declarations = dict(re.findall(r'extern\s+"C"\s+void\s+(\w+)\s*\(\s*(\w+)\s+Parameters\s*\);', source))
    template_parameters = dict(re.findall(r'using\s+FKernelParameters_(\w+)\s*=\s*(\w+)\s*;', source))
    if set(template_parameters) != set(load_template_resolvers()):
        raise ValueError('each template resolver requires one compiler-checked parameter alias')
    if set(declarations) & set(template_parameters):
        raise ValueError('a logical kernel cannot declare both a bare entry and a template resolver')
    declarations.update(template_parameters)
    fields_by_entry = {}
    parameter_types = {}
    for entry in load('canonical_kernel_names.json').values():
        parameter_type = declarations[entry]
        fields_by_entry[entry] = fields_by_type[parameter_type]
        parameter_types[entry] = parameter_type
    if len(fields_by_entry) != 81:
        raise ValueError('expected all 81 compiler-checked ABI declarations')
    for export, canonical in SAFE_ATTENTION_ALIASES.items():
        if export in fields_by_entry:
            raise ValueError(f'{export}: safe alias must be additive')
        fields_by_entry[export] = fields_by_entry[canonical]
        parameter_types[export] = parameter_types[canonical]
    return fields_by_entry, parameter_types


def build_plan(schedule, spec=LEGACY71):
    if isinstance(spec, str):
        spec = resolve_model(spec)
    fp16 = schedule['precision'] == 'fp16'
    bottleneck_width, bottleneck_height = schedule['levels'][5]
    decoder_width, decoder_height = schedule['levels'][4]
    global_tokens = bottleneck_width * bottleneck_height
    canonical = load('canonical_kernel_names.json')
    if len(canonical) != 81 or len(set(canonical.values())) != 81:
        raise ValueError('canonical entry map must contain 81 unique entries')
    windows = {e['original_symbol']: e for e in load('reconstruction/windows.json')['entries']}
    c512 = {e['original_symbol']: e for e in load('reconstruction/c512.json')['entries']}
    glob = {e['original']['symbol']: e for e in load('reconstruction/global.json')['entries']}
    conn = {e['original']['entry']: e for e in load('reconstruction/connectors.json')['entries']}
    buffers = schedule['buffers']
    names = list(buffers)
    records = {}
    calls = []
    def ptr(name):
        if name not in buffers:
            raise ValueError('unknown schedule buffer ' + name)
        return 'address(%d)' % names.index(name)
    def add(symbol, fn, abi, grid, block, fields, all_resident=False, mutable_offsets=()):
        calls.append(dict(symbol=symbol, fn=fn, abi=abi, grid=grid, block=block,
                          fields=fields, all_resident=all_resident,
                          mutable_offsets=list(mutable_offsets)))
    previous = None
    for n in schedule['positions']:
        b, symbol = n['block'], n['original_symbol']
        if b != previous:
            for reset in schedule['reset_protocol']:
                if reset['before_block'] == b:
                    name = f"b{b}.{reset['counter']}_counter"
                    words = buffers[name]['storage_bytes'] // 4
                    add('cc_cb_clear', canonical['cc_cb_clear'], 16,
                        [(words+255)//256,1,1], [256,1,1],
                        [(0,8,ptr(name)),(8,4,str(words))], mutable_offsets=[0])
        previous = b
        ins, outs = n['input_buffers'], n['output_buffers']
        fields = []
        def p(offset, name): fields.append((offset,8,ptr(name)))
        def scalar(offset, value): fields.append((offset,4,str(value)))
        def record(offset, size):
            raw_block = n.get('raw_block', b)
            name = f"block{raw_block}.layer{n['record_layer']}.layer"
            expected = spec.record_spec(name).byte_length
            # The model spec pins the original FP8 resource; Half repacks have
            # their own validated record extents in the reconstruction catalogs.
            if not fp16 and size != expected:
                raise ValueError(f'{name} record extent {size} differs from model spec {expected}')
            if name in records and records[name] != size:
                raise ValueError('conflicting record extent')
            records[name] = size
            fields.append((offset,8,f'record_address({list(records).index(name)})'))
        resident = False
        if symbol in windows:
            e = windows[symbol]; fn = canonical[symbol]; c = e['channels']; kind = e['kind']
            h,w,_ = buffers[outs['high']]['shape_hwc']; phase = n['phase']
            sx,sy = ((0,0),(4,4),(4,0),(0,4))[phase]
            p(0,ins['state']);p(8,outs['high']);record(16,e['record_bytes'])
            off = 24 if c == 32 else 32
            for i,v in enumerate((h,w,-sx,-sy)): scalar(off+4*i,v)
            if kind in ('inpview','outview'):
                off = 72 if c == 32 else 80
                scalar(off,h);scalar(off+4,w)
            elif kind == 'ds':
                off = 64 if c == 32 else 72
                p(off,outs['down']);lh,lw,_=buffers[outs['down']]['shape_hwc']
                scalar(off+8,lh);scalar(off+12,lw)
            elif kind == 'upsample':
                p(80 if c == 32 else 24,ins['skip'])
                if c == 32: scalar(88,h);scalar(92,w)
            elif kind != 'ordinary':raise ValueError(kind)
        elif symbol in c512:
            e = c512[symbol]; fn=canonical[symbol]
            h,w,_=buffers[ins['state']]['shape_hwc']
            role_map={**ins,**outs}
            if 'residual' in ins: role_map['skip']=ins['residual']
            for key,off in e['pointer_fields'].items():
                if key=='record':record(off,e['record_bytes'])
                else:p(off,role_map[key])
            phase = n['phase'] or 0;sx,sy=((0,0),(4,4),(4,0),(0,4))[phase]
            vals=dict(height=h,width=w,origin_x=-sx,origin_y=-sy)
            if 'pool' in outs:
                lh,lw,_=buffers[outs['pool']]['shape_hwc']
                vals.update(low_height=lh,low_width=lw,pool_height=lh,pool_width=lw)
            for key,off in e['scalar_fields'].items():scalar(off,vals[key])
        elif symbol in glob:
            e=glob[symbol];fn=n.get('safe_export', canonical[symbol]);stage=n['stage']
            # Exact native by-value ABI, including ignored zero-initialized slots.
            if stage in ('expand','contract','projection'):
                p(0,ins['state'])
                if 'residual' in ins:p(8,ins['residual'])
                p(16,outs['high']);record(24,e['record']['bytes'])
                if stage!='expand':
                    p(32,outs['counter']);resident=True
                    if not fp16:p(40,outs['scratch'])
                scalar(64,1);scalar(68,global_tokens)
            elif stage=='qkv':
                for off,name in ((0,ins['state']),(8,outs['q']),(16,outs['k']),(24,outs['v'])):p(off,name)
                record(32,e['record']['bytes']);p(40,outs['counter'])
                if not fp16:p(48,outs['scratch'])
                scalar(72,1);scalar(76,global_tokens);resident=True
            elif stage=='attention_chained':
                for off,name in ((0,ins['q']),(8,ins['k']),(16,ins['v']),(24,outs['high']),
                                 (40,ins['predecessor_counter']),(48,outs['completion_counter'])):p(off,name)
                scalar(56,1);scalar(60,global_tokens)
            else:raise ValueError(stage)
        elif symbol in conn:
            e=conn[symbol];fn=canonical[symbol]
            if n['stage']=='repack':
                p(0,ins['input']);p(8,outs['output']);scalar(16,bottleneck_height);scalar(20,bottleneck_width)
            else:
                for off,name in ((0,ins['low']),(8,ins['skip']),(16,outs['high']),
                                 (32,outs['counter']),(24 if fp16 else 48,outs['scratch'])):p(off,name)
                record(56,e['record']['selected_bytes'])
                for off,v in zip((64,68,72,76),(bottleneck_height,bottleneck_width,decoder_height,decoder_width)):scalar(off,v)
                resident=True
        else:raise ValueError(symbol)
        output_addresses = {ptr(name) for name in outs.values()}
        mutable_offsets = [offset for offset, size, value in fields
                           if size == 8 and value in output_addresses]
        add(symbol,fn,n['abi_bytes'],n['grid'],n['block_dim'],fields,resident,mutable_offsets)
    census = schedule.get('census')
    if census is None:
        # Older schedule JSON has no explicit census; keep the validated legacy default.
        census = dict(compute_positions=152, counter_reset_positions=33, calls=185,
                      record_positions=142, unique_symbols=36)
    if (len(schedule['positions']) != census['compute_positions'] or
            len(schedule['reset_protocol']) != census['counter_reset_positions']):
        raise ValueError('schedule position census')
    if census['calls'] != census['compute_positions'] + census['counter_reset_positions']:
        raise ValueError('schedule call census')
    if len(calls) != census['calls']:
        raise ValueError('schedule call census')
    if len({n['original_symbol'] for n in schedule['positions']}) != census['unique_symbols']:
        raise ValueError('schedule operator census')
    if len(records) != census['record_positions']:
        raise ValueError('record census')
    return dict(buffers=buffers, records=records, calls=calls)

RESOLUTIONS = ((1280, 720), (1920, 1080), (2560, 1440), (3840, 2160))


def block_level(block):
    for first, last, level in ((1, 4, 0), (5, 8, 1), (9, 14, 2), (15, 22, 3),
                               (23, 30, 4), (31, 38, 5), (39, 47, 4), (48, 55, 3),
                               (56, 61, 2), (62, 65, 1), (66, 69, 0)):
        if first <= block <= last:
            return level
    raise ValueError(f'unknown network block: {block}')


def buffer_geometry_expression(name):
    """Emit layout formulas from buffer roles, never infer them from anchor values."""
    if name == 'input':
        return 'Shape.SpatialBytes(0, 32, ElementBytes)'
    if name == 'repack-30-31':
        return 'Shape.TokenBytes(1024, ElementBytes)'
    if name == 'repack-38-39':
        return 'Shape.SpatialBytes(5, 1024, ElementBytes)'
    match = re.fullmatch(r'b(\d+)\.(\w+)', name)
    if not match:
        raise ValueError(f'unknown physical buffer role: {name}')
    block, role = int(match[1]), match[2]
    level = block_level(block)
    channels = 32 << level
    if 31 <= block <= 38:
        if role.endswith('_counter'):
            counters = {'contract_counter': 8, 'qkv_counter': 16,
                        'attention_counter': 32, 'projection_counter': 8}[role]
            return f'Shape.CounterBytes({counters})'
        if role.endswith('_scratch'):
            if role not in ('contract_scratch', 'qkv_scratch', 'projection_scratch'):
                raise ValueError(f'unknown global scratch role: {name}')
            return f'Shape.TokenBytes(1024, 2, {3 if role == "qkv_scratch" else 1})'
        if role not in ('expanded', 'contracted', 'Q', 'K', 'V', 'attended', 'output'):
            raise ValueError(f'unknown global tensor role: {name}')
        return f'Shape.TokenBytes({4096 if role == "expanded" else 1024}, ElementBytes)'
    if block == 39 and role == 'up_counter':
        return 'Shape.DecoderCounterBytes()'
    if block == 39 and role == 'scratch':
        return 'Shape.SpatialBytes(5, 512, 2)'
    if block == 30 and role in ('pool', 'down'):
        return f'Shape.SpatialBytes(5, {512 if role == "pool" else 1024}, ElementBytes)'
    if role == 'down' and block in (4, 8, 14, 22):
        return f'Shape.DownsampleBytes({level}, {channels}, ElementBytes)'
    if role not in ('output', 'branches', 'ffn', 'attended'):
        raise ValueError(f'unknown spatial tensor role: {name}')
    return f'Shape.SpatialBytes({level}, {channels}, ElementBytes)'


def call_geometry_expressions(call, fields):
    """Return exact grid/scalar formulas for one invariant logical call."""
    name = call['fn']
    values = {fields[offset]: value for offset, size, value in call['fields'] if size == 4}
    level = None
    if name.startswith('window_block_'):
        channels = int(re.search(r'_c(32|64|128|256)_', name)[1])
        level = {32: 0, 64: 1, 128: 2, 256: 3}[channels]
    elif name.startswith(('window_ffn_', 'window_qkv_', 'window_attention_')):
        level = 4
    elif name.startswith(('channel_projection_', 'repack_')):
        level = 5

    scalars = {}
    for field in values:
        if field in ('OriginX', 'OriginY', 'BatchCount'):
            # Window phase belongs to the fixed network sequence; global batch
            # is explicitly one. Neither is chosen from measured dimensions.
            scalars[field] = values[field]
        elif field in ('Height', 'Width', 'ViewHeight', 'ViewWidth', 'ResidualHeight', 'ResidualWidth'):
            if level is None:
                raise ValueError(f'missing geometry level for {name}.{field}')
            axis = 'Height' if field.endswith('Height') else 'Width'
            scalars[field] = f'Shape.{axis}({level})'
        elif field in ('DownsampledHeight', 'DownsampledWidth'):
            axis = 'Height' if field.endswith('Height') else 'Width'
            scalars[field] = f'Shape.{axis}({level + 1})'
        elif field in ('InputHeight', 'InputWidth', 'OutputHeight', 'OutputWidth'):
            axis = 'Height' if field.endswith('Height') else 'Width'
            scalars[field] = f'Shape.{axis}({5 if field.startswith("Input") else 4})'
        elif field == 'TokensPerBatch':
            scalars[field] = 'Shape.Tokens()'
        elif field == 'CounterCount':
            counter = next(value for offset, size, value in call['fields'] if offset == 0 and size == 8)
            index = re.fullmatch(r'address\((\d+)\)', counter)[1]
            scalars[field] = f'(Geometry.BufferBytes[{index}] / 4)'
        else:
            raise ValueError(f'unknown geometry argument: {name}.{field}')

    def divide(value, divisor):
        return f'GeometryDivideUp({value}, {divisor})'

    if name == 'completion_counter_clear':
        grid = [divide(scalars['CounterCount'], 256), '1', '1']
    elif name.startswith('window_block_'):
        grid = [divide(f'Shape.Width({level}) + {-int(values["OriginX"])}', 8),
                divide(f'Shape.Height({level}) + {-int(values["OriginY"])}', 8), '1']
    elif name.startswith('window_qkv_'):
        grid = [divide(f'Shape.Width(4) + {-int(values["OriginX"])}', 8),
                divide(f'Shape.Height(4) + {-int(values["OriginY"])}', 8), '4']
    elif name.startswith(('window_ffn_projection_', 'window_attention_projection_')):
        grid = [f'2 * {divide("Shape.Width(4)", 8)}', divide('Shape.Height(4)', 8), '1']
    elif name.startswith('window_ffn_'):
        grid = [divide('Shape.Width(4)', 8), divide('Shape.Height(4)', 8), '2']
    elif name.startswith('channel_projection_'):
        grid = [f'4 * {divide("Shape.Width(5)", 8)}', divide('Shape.Height(5)', 8), '1']
    elif name.startswith('repack_'):
        grid = ['Shape.PaddedTokens() * ElementBytes', '1', '1']
    elif name.startswith(('global_attention_chained_', 'small_global_attention_chained_')):
        grid = ['32', divide('Shape.Tokens()', 256), '1']
    elif name.startswith(('global_ffn_', 'global_qkv_', 'global_projection_')):
        tiles, splits = ((32, 1) if name.startswith('global_ffn_expand_') else
                         (16, 2) if name.startswith('global_qkv_') else (8, 4))
        grid = [f'{tiles} * {divide("Shape.Tokens()", 128)}', '1', str(splits)]
    elif name.startswith('decoder_upsample_'):
        grid = [f'2 * {divide("Shape.Width(5)", 4)}', divide('Shape.Height(5)', 4), '4']
    else:
        raise ValueError(f'unknown launch geometry: {name}')
    return grid, [scalars[field] for field in values]


def runtime_geometry_source(precision, plan, abi_fields, *, function_prefix='SelectGeometryPlan'):
    lines = ['// Generated exact physical-layout formulas; dimensions are runtime values.',
             '// Measured resolutions select tuning policy only; they are not an execution whitelist.',
             f'static FGeometryPlanSpec {function_prefix}_{precision}(int64_t Width, int64_t Height)',
             '{', '    const auto Shape = CreateNetworkGeometry(Width, Height);',
             f'    constexpr int ElementBytes = {2 if precision == "fp16" else 1};',
             '    FGeometryPlanSpec Geometry{Width, Height, {}, {}, {}};',
             '    Geometry.BufferBytes = {']
    lines += [f'        {buffer_geometry_expression(name)}, // {name}' for name in plan['buffers']]
    lines += ['    };', '    Geometry.Grids = {']
    calls = [call_geometry_expressions(call, abi_fields[call['fn']]) for call in plan['calls']]
    lines += [f'        GeometryGrid({", ".join(grid)}), // {call["fn"]}'
              for call, (grid, _) in zip(plan['calls'], calls)]
    lines += ['    };', '    Geometry.GeometryArguments = {']
    lines += [f'        {", ".join("GeometryScalar(" + value + ")" for value in scalars)}, // {call["fn"]}'
              for call, (_, scalars) in zip(plan['calls'], calls)]
    lines += ['    };', '    return Geometry;', '}']
    return '\n'.join(lines) + '\n'


def plan_source(precision, plan, abi_fields, parameter_types, resolvers, *,
                class_name='FDeploymentPlan', table_prefix='', title=None,
                boundary_names=None):
    """Emit one call table for an explicit host class and symbol prefix."""
    call_count = len(plan['calls'])
    template_argument = 'true' if precision == 'fp16' else 'false'
    header = title or (f'// Generated shared native FP8 schedule. Every resolution uses the same '
                       f'{call_count} calls.')
    names = list(plan['buffers'])
    lines = [header,
             '// Buffer names are shared; the geometry table supplies their actual byte extents.',
             f'static const char* {table_prefix}BufferNameTable_{precision}[] = {{']
    lines += [f'    "{name}",' for name in names]
    lines += ['};', f'static const FBufferSpec {table_prefix}RecordSpecs_{precision}[] = {{']
    lines += [f'    {{"{name}", {size}LL}},' for name, size in plan['records'].items()]
    lines += ['};']
    if boundary_names is not None:
        lines += [f'static const char* {table_prefix}BoundaryNames_{precision}[] = {{']
        lines += [f'    "{name}",' for name in boundary_names]
        lines += ['};']
    lines += [f'template <> void {class_name}<{template_argument}>::BuildCalls() {{',
              f'    Calls.reserve({call_count});']
    scalar_index = 0
    for call_index, call in enumerate(plan['calls']):
        block = ', '.join(map(str, call['block']))
        parameter_type = parameter_types[call['fn']]
        entry_fields = abi_fields[call['fn']]
        lines += [f'    {{ // {call["symbol"]}',
                  f'        using FParameters = {parameter_type};',
                  '        FKernelCall KernelCall{%s, Geometry->Grids[%d], dim3(%s), %d, %s};'
                  % (kernel_address(call['fn'], resolvers), call_index, block, call['abi'], str(call['all_resident']).lower()),
                  f'        KernelCall.Name = "{call["fn"]}";']
        for offset, size, value in call['fields']:
            cpp_type = 'uint64_t' if size == 8 else 'int32_t'
            if size == 4:
                value = f'Geometry->GeometryArguments[{scalar_index}]'
                scalar_index += 1
            if size == 8:
                binding = re.fullmatch(r'(record_)?address\((\d+)\)', value)
                if not binding:
                    raise ValueError(f'unknown tensor pointer binding: {value}')
                mutable = offset in call['mutable_offsets']
                lines.append(f'        KernelCall.Bind(offsetof(FParameters, {entry_fields[offset]}), '
                             f'{binding[2]}, {str(bool(binding[1])).lower()}, {str(mutable).lower()});')
                value = value.replace('record_address(', 'GetRecordAddress(').replace('address(', 'GetBufferAddress(')
            field_name = entry_fields[offset]
            lines.append(f'        KernelCall.Set<{cpp_type}>(offsetof(FParameters, {field_name}), {value});')
        lines += ['        Calls.push_back(KernelCall);', '    }']
    lines += ['}']
    return '\n'.join(lines).replace('native FP8', 'native ' + precision.upper()) + '\n'


def build_precision_plans(precision, model='legacy71'):
    """Build and cross-validate one precision at every supported resolution."""
    try:
        from physical_schedule import make
    except ImportError:
        from .physical_schedule import make

    spec = resolve_model(model)
    schedules = [make(width, height, precision=precision, model=model) for width, height in RESOLUTIONS]
    plans = [build_plan(schedule, spec) for schedule in schedules]
    reference = plans[-1]
    names = list(reference['buffers'])
    for plan in plans:
        if list(plan['buffers']) != names or plan['records'] != reference['records']:
            raise ValueError('shape changed buffer/record roles')
        for actual, expected in zip(plan['calls'], reference['calls']):
            if any(actual[key] != expected[key] for key in ('symbol', 'fn', 'abi', 'block', 'all_resident')):
                raise ValueError('shape changed the shared kernel sequence')
            if len(actual['fields']) != len(expected['fields']):
                raise ValueError('shape changed the native parameter schema')
            for actual_field, expected_field in zip(actual['fields'], expected['fields']):
                if actual_field[:2] != expected_field[:2] or (actual_field[1] == 8 and actual_field != expected_field):
                    raise ValueError('shape changed a pointer binding')
    return spec, schedules, plans


def render(precision="fp8"):
    """Render the legacy generated assets in memory without touching any file."""
    abi_fields, parameter_types = load_abi_fields()
    resolvers = load_template_resolvers()
    spec, schedules, plans = build_precision_plans(precision, 'legacy71')
    reference = plans[-1]
    suffix = '' if precision == 'fp8' else '_fp16'
    return {
        f'plan_geometry{suffix}_generated.inl': runtime_geometry_source(precision, reference, abi_fields),
        f'plan{suffix}_generated.inl': plan_source(
            precision, reference, abi_fields, parameter_types, resolvers),
    }, schedules, plans


def generate(precision="fp8"):
    assets, schedules, plans = render(precision)
    reference = plans[-1]
    OUT.mkdir(parents=True, exist_ok=True)
    for filename, text in assets.items():
        (OUT / filename).write_text(text, encoding='utf-8', newline='\n')
    entries = ['// Generated from canonical_kernel_names.json; all individual public CUDA exports.',
               'static const char* PreparedKernelNames[] = {']
    entries += [f'    "{name}",' for name in sorted(load('canonical_kernel_names.json').values())]
    entries += ['};']
    (OUT / 'prepared_kernel_names_generated.inl').write_text('\n'.join(entries) + '\n', encoding='utf-8', newline='\n')
    symbol_resolvers = load_template_resolvers()
    symbols = ['// Generated logical-name to registered host-stub mapping.',
               '// Resolver calls take addresses only; no CUDA initialization or launches.',
               'static const std::array<FKernelSymbolEntry, 81>& GetKernelSymbolTable() {',
               '    static const std::array<FKernelSymbolEntry, 81> Table{{']
    symbols += [f'    {{"{name}", {kernel_address(name, symbol_resolvers)}}},'
                for name in sorted(load('canonical_kernel_names.json').values())]
    symbols += ['    }};', '    return Table;', '}']
    (OUT / 'kernel_symbols_generated.inl').write_text('\n'.join(symbols) + '\n', encoding='utf-8', newline='\n')
    suffix = '' if precision == 'fp8' else '_fp16'
    for (width, height), plan, schedule in zip(RESOLUTIONS, plans, schedules):
        (PREP / f'plan{suffix}_{width}_{height}.json').write_text(json.dumps(plan, indent=2) + '\n', encoding='utf-8')
        (PREP / f'network_schedule_{precision}_{width}_{height}.json').write_text(json.dumps(schedule, indent=2) + '\n', encoding='utf-8')
    scalar_fields = sum(1 for call in reference['calls'] for field in call['fields'] if field[1] == 4)
    print(json.dumps(dict(resolutions=RESOLUTIONS, calls=len(reference['calls']),
                          buffers=len(reference['buffers']), scalar_fields=scalar_fields,
                          kernel_sequence_shared=True)))


if __name__ == '__main__':
    generate()
    generate('fp16')
