"""Generate the fixed, original-layout FP8 trunk schedule for the clean C++ API.

This is offline code generation, not Python inference dispatch. Every repeated
network instance references one shared reconstructed kernel host stub.
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PREP = Path(__file__).resolve().parent
OUT = ROOT / 'csrc' / 'kernel_launcher'

def load(name):
    return json.loads((PREP / name).read_text())

def load_abi_fields():
    """Read names from compiler-checked offsets, resolving shared ABI aliases.

    Generation fails when a written offset has no checked field. Neither the
    generated plans nor a second schema can silently redefine the native ABI.
    """
    source = (OUT / 'kernel_abi.h').read_text()
    fields_by_type = {}
    for parameter_type, field, offset in re.findall(
            r'offsetof\((\w+),\s*(\w+)\)\s*==\s*(\d+)', source):
        fields = fields_by_type.setdefault(parameter_type, {})
        offset = int(offset)
        if offset in fields and fields[offset] != field:
            raise ValueError(f'conflicting ABI names for {parameter_type} byte {offset}')
        fields[offset] = field
    aliases = dict(re.findall(r'using (\w+) = (\w+);', source))
    while aliases:
        resolved = [alias for alias, target in aliases.items() if target in fields_by_type]
        if not resolved:
            raise ValueError(f'unresolved ABI aliases: {aliases}')
        for alias in resolved:
            fields_by_type[alias] = fields_by_type[aliases.pop(alias)]
    declarations = dict(re.findall(r'extern\s+"C"\s+void\s+(\w+)\s*\(\s*(\w+)\s+Parameters\s*\);', source))
    fields_by_entry = {}
    parameter_types = {}
    for entry in load('canonical_kernel_names.json').values():
        parameter_type = declarations[entry]
        fields_by_entry[entry] = fields_by_type[parameter_type]
        parameter_types[entry] = parameter_type
    if len(fields_by_entry) != 81:
        raise ValueError('expected all 81 compiler-checked ABI declarations')
    return fields_by_entry, parameter_types


def build_plan(schedule):
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
    def add(symbol, fn, abi, grid, block, fields, all_resident=False):
        calls.append(dict(symbol=symbol, fn=fn, abi=abi, grid=grid, block=block,
                          fields=fields, all_resident=all_resident))
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
                        [(0,8,ptr(name)),(8,4,str(words))])
        previous = b
        ins, outs = n['input_buffers'], n['output_buffers']
        fields = []
        def p(offset, name): fields.append((offset,8,ptr(name)))
        def scalar(offset, value): fields.append((offset,4,str(value)))
        def record(offset, size):
            name = f"block{b}.layer{n['record_layer']}.layer"
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
            e=glob[symbol];fn=canonical[symbol];stage=n['stage']
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
        add(symbol,fn,n['abi_bytes'],n['grid'],n['block_dim'],fields,resident)
    if len(calls)!=185 or len({n['original_symbol'] for n in schedule['positions']})!=36:
        raise ValueError('schedule census')
    if len(records)!=142:raise ValueError('record census')
    return dict(buffers=buffers, records=records, calls=calls)

RESOLUTIONS = ((1280, 720), (1920, 1080), (2560, 1440), (3840, 2160))


def generate(precision="fp8"):
    from physical_schedule import make

    abi_fields, parameter_types = load_abi_fields()

    schedules = [make(width, height, precision=precision) for width, height in RESOLUTIONS]
    plans = [build_plan(schedule) for schedule in schedules]
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

    header = '''// Generated by tuning/generate_plan.py. Launch preparation only.
#pragma once
#include <cuda_runtime_api.h>
#include <cstdint>
struct FGeometryPlanSpec {
    int64_t ValidWidth;
    int64_t ValidHeight;
    const int64_t* BufferBytes;
    const dim3* Grids;
    const int32_t* GeometryArguments;
};
'''
    tables = ['// Generated geometry data; all shapes reuse one physical call sequence.']
    descriptors = []
    for (width, height), plan in zip(RESOLUTIONS, plans):
        suffix = f'{width}_{height}_{precision}'
        tables.append(f'static const int64_t BufferBytes_{suffix}[] = {{')
        tables.extend(f'    {buffer["storage_bytes"]}LL, // {name}' for name, buffer in plan['buffers'].items())
        tables.append('};')
        tables.append(f'static const dim3 Grids_{suffix}[] = {{')
        tables.extend('    dim3(%s), // %s' % (', '.join(map(str, call['grid'])), call['symbol']) for call in plan['calls'])
        tables.append('};')
        tables.append(f'static const int32_t GeometryArguments_{suffix}[] = {{')
        for call in plan['calls']:
            entry_fields = abi_fields[call['fn']]
            integer_fields = [(entry_fields[offset], value)
                              for offset, size, value in call['fields'] if size == 4]
            field_names = ', '.join(field for field, _ in integer_fields)
            field_values = ', '.join(value for _, value in integer_fields)
            tables.append(f'    {field_values}, // {call["fn"]}: {field_names}')
        tables.append('};')
        descriptors.append(f'    {{{width}, {height}, BufferBytes_{suffix}, Grids_{suffix}, GeometryArguments_{suffix}}},')
    tables += [f'static const FGeometryPlanSpec GeometryPlans_{precision}[] = {{', *descriptors, '};',
               f'static const FGeometryPlanSpec& SelectGeometryPlan_{precision}(int64_t Width, int64_t Height) {{',
               f'    for (const auto& Geometry : GeometryPlans_{precision}) {{',
               '        if (Geometry.ValidWidth == Width && Geometry.ValidHeight == Height)',
               '            return Geometry;', '    }',
               '    TORCH_CHECK(false, "FP8 trunk supports 1280x720, 1920x1080, 2560x1440, or 3840x2160");',
               '}']

    lines = ['// Generated shared native FP8 schedule. Every resolution uses the same 185 calls.',
             '// Buffer names are shared; the geometry table supplies their actual byte extents.',
             f'static const char* BufferNameTable_{precision}[] = {{']
    lines += [f'    "{name}",' for name in names]
    lines += ['};', f'static const FBufferSpec RecordSpecs_{precision}[] = {{']
    lines += [f'    {{"{name}", {size}LL}},' for name, size in reference['records'].items()]
    lines += ['};', 'void FDeploymentPlan_fp8::BuildCalls() {', '    Calls.reserve(185);']
    scalar_index = 0
    for call_index, call in enumerate(reference['calls']):
        block = ', '.join(map(str, call['block']))
        parameter_type = parameter_types[call['fn']]
        entry_fields = abi_fields[call['fn']]
        lines += [f'    {{ // {call["symbol"]}',
                  f'        using FParameters = {parameter_type};',
                  '        FKernelCall KernelCall{reinterpret_cast<const void*>(&%s), Geometry->Grids[%d], dim3(%s), %d, %s};'
                  % (call['fn'], call_index, block, call['abi'], str(call['all_resident']).lower())]
        for offset, size, value in call['fields']:
            cpp_type = 'uint64_t' if size == 8 else 'int32_t'
            if size == 4:
                value = f'Geometry->GeometryArguments[{scalar_index}]'
                scalar_index += 1
            if size == 8:
                value = value.replace('record_address(', 'GetRecordAddress(').replace('address(', 'GetBufferAddress(')
            field_name = entry_fields[offset]
            lines.append(f'        KernelCall.Set<{cpp_type}>(offsetof(FParameters, {field_name}), {value});')
        lines += ['        Calls.push_back(KernelCall);', '    }']
    lines += ['}']
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / 'plan_geometry.h').write_text(header, newline='\n')
    suffix = '' if precision == 'fp8' else '_fp16'
    (OUT / f'plan_geometry{suffix}_generated.inl').write_text('\n'.join(tables).replace('FP8 trunk', precision.upper() + ' trunk') + '\n', newline='\n')
    (OUT / f'plan{suffix}_generated.inl').write_text('\n'.join(lines).replace('FDeploymentPlan_fp8::BuildCalls()', f'FDeploymentPlan<{str(precision == "fp16").lower()}>::BuildCalls()').replace('void FDeploymentPlan<', 'template <> void FDeploymentPlan<').replace('native FP8', 'native ' + precision.upper()) + '\n', newline='\n')
    for (width, height), plan, schedule in zip(RESOLUTIONS, plans, schedules):
        (PREP / f'plan{suffix}_{width}_{height}.json').write_text(json.dumps(plan, indent=2) + '\n')
        (PREP / f'network_schedule_{precision}_{width}_{height}.json').write_text(json.dumps(schedule, indent=2) + '\n')
    print(json.dumps(dict(resolutions=RESOLUTIONS, calls=185, buffers=len(names),
                          scalar_fields=scalar_index, kernel_sequence_shared=True)))


if __name__ == '__main__':
    generate()
    generate('fp16')
