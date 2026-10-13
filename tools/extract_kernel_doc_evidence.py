"""Extract per-entry NCU metrics, executed SASS, and source-correlated samples.

The NCU Python module is supplied by the installed profiler (--ncu-python).
Raw reports remain the authority; this auditable reduction feeds the HTML.
"""
import argparse
from collections import defaultdict, Counter
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
METRICS = '''gpu__time_duration.sum
sm__warps_active.avg.pct_of_peak_sustained_active
sm__throughput.avg.pct_of_peak_sustained_elapsed
sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_elapsed
smsp__issue_active.avg.per_cycle_active
smsp__warps_eligible.avg.per_cycle_active
smsp__warps_active.avg.per_cycle_active
sm__cycles_active.avg
sm__cycles_active.min
sm__cycles_active.max
dram__bytes_op_read.sum
dram__bytes_op_write.sum
gpu__dram_throughput.avg.pct_of_peak_sustained_elapsed
lts__t_sector_hit_rate.pct
l1tex__t_sector_hit_rate.pct
l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum
l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_st.sum
sass__inst_executed_global_loads
sass__inst_executed_global_stores
sass__inst_executed_local_loads
sass__inst_executed_local_stores
sass__inst_executed_shared_loads
sass__inst_executed_shared_stores
sass__inst_executed_register_spilling
memory_l1_wavefronts_shared
memory_l1_wavefronts_shared_ideal
memory_l1_wavefronts_shared_excessive
smsp__pcsamp_sample_count
smsp__pcsamp_aggregated_passes
device__attribute_multiprocessor_count
device__attribute_max_warps_per_multiprocessor
device__attribute_max_registers_per_multiprocessor
device__attribute_max_shared_memory_per_multiprocessor'''.splitlines()


def sass_mnemonic(sass):
    """Read the opcode, including modifiers, after an optional lane/uniform predicate."""
    match=re.match(r'^\s*(?:@!?(?:U?P\d+|U?PT)\s+)?([A-Z][A-Z0-9]*(?:\.[A-Za-z0-9_]+)*)(?=\s|$)',sass)
    return match[1] if match else None


def extract(action):
    names=action.metric_names()
    def val(name):
        m=action.metric_by_name(name)
        if m is None:return None
        try:return dict(value=m.value(),unit=m.unit())
        except (ValueError,RuntimeError):return None
    public=None
    for domain in action.nvtx_state().domains():
        ranges=action.nvtx_state().domain_by_id(domain).push_pop_ranges()
        if 'docs' in ranges:public=ranges[-1]
    if public is None:raise ValueError('Action has no public-entry NVTX label')
    metrics={n:val(n) for n in sorted(set(METRICS+[n for n in names if n.startswith('launch__') and not n.startswith(('launch__occupancy_per','launch__function_pcs'))]))}
    metrics={n:v for n,v in metrics.items() if v is not None and isinstance(v['value'],(float,int,str))}
    op=action.metric_by_name('sass__inst_executed_per_opcode')
    opcodes={op.correlation_ids().as_string(i):op.value(i) for i in range(op.num_instances())} if op else {}
    pcs={}; lines={}
    def pc_record(pc):
        if pc not in pcs:
            source=action.source_info(pc)
            path=source.file_name().replace('\\','/') if source else ''
            if '/csrc/' in path:path='csrc/'+path.split('/csrc/',1)[1]
            elif path:path=Path(path).name
            pcs[pc]=dict(path=path,line=source.line() if source else 0,sass=action.sass_by_pc(pc).strip())
        info=pcs[pc]; key=(info['path'],info['line'])
        if key not in lines:lines[key]=dict(path=key[0],line=key[1],executed=0,opcodes=Counter(),stalls=Counter(),sass=[])
        return info,lines[key]
    metric=action.metric_by_name('inst_executed')
    if metric and metric.has_correlation_ids():
        ids=metric.correlation_ids()
        for i in range(metric.num_instances()):
            count=metric.value(i)
            if not count:continue
            info,line=pc_record(ids.as_uint64(i))
            mnemonic=sass_mnemonic(info['sass'])
            opcode=mnemonic.split('.')[0] if mnemonic else '?'
            line['executed']+=count;line['opcodes'][opcode]+=count
            if len(line['sass'])<6 and info['sass'] not in line['sass']:line['sass'].append(info['sass'])
    stall_totals={}
    for name in names:
        if not name.startswith('smsp__pcsamp_warps_issue_stalled_') or name.endswith('_not_issued'):continue
        metric=action.metric_by_name(name)
        short=name.removeprefix('smsp__pcsamp_warps_issue_stalled_')
        stall_totals[short]=metric.value()
        if not metric.has_correlation_ids():continue
        ids=metric.correlation_ids()
        for i in range(metric.num_instances()):
            count=metric.value(i)
            if count:
                info,line=pc_record(ids.as_uint64(i));line['stalls'][short]+=count
    instructions={}
    for info in pcs.values():
        mnemonic=sass_mnemonic(info['sass'])
        if mnemonic:
            instructions.setdefault(mnemonic,info)
    timeline={}
    for name in ('pmsampling:sm__inst_executed_realtime.avg.pct_of_peak_sustained_elapsed',
                 'pmsampling:sm__inst_executed_pipe_tensor_subpipe_hmma_realtime.avg.pct_of_peak_sustained_elapsed',
                 'pmsampling:dram__bytes.avg.pct_of_peak_sustained_elapsed',
                 'pmsampling:sm__warps_active.avg.pct_of_peak_sustained_active'):
        m=action.metric_by_name(name)
        if m is None:continue
        values=[m.value(i) for i in range(m.num_instances())]
        # Preserve order; cap the published chart to 160 average buckets.
        stride=max(1,(len(values)+159)//160)
        timeline[name]=dict(instances=len(values),bucket_size=stride,
                            values=[sum(values[i:i+stride])/len(values[i:i+stride]) for i in range(0,len(values),stride)])
    return public,dict(function=action.name(action.NameBase_DEMANGLED),metrics=metrics,
                       opcodes=opcodes,instructions=list(instructions.values()),
                       lines=sorted(lines.values(),key=lambda x:(x['path'],x['line'])),
                       stall_totals=stall_totals,timeline=timeline,
                       rules=action.rule_results_as_dicts())


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run',type=Path)
    parser.add_argument('--ncu-python',type=Path,default=Path(r'C:\Program Files\NVIDIA Corporation\Nsight Compute 2026.3.0\extras\python'))
    args=parser.parse_args();sys.path.insert(0,str(args.ncu_python))
    import ncu_report
    result=dict(run=args.run.as_posix(),reports={},kernels={})
    for precision in ('fp16','fp8'):
        for kind in ('full','source'):
            name=f'{precision}-{kind}'
            path=args.run/'reports'/f'{name}.ncu-repz'
            if not path.is_file():continue
            receipt=json.loads((args.run/'harness'/f'{name}.json').read_text())
            fixtures={c['name']:c for c in receipt.pop('calls')}
            result['reports'][name]=dict(path=path.as_posix(),sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                         bytes=path.stat().st_size,receipt=receipt,fixtures=fixtures)
            report=ncu_report.load_report(str(path))
            for ri in range(report.num_ranges()):
                rg=report.range_by_idx(ri)
                for ai in range(rg.num_actions()):
                    public,data=extract(rg.action_by_idx(ai))
                    data.update(report=name,range_index=ri,action_index=ai)
                    result['kernels'].setdefault(public,[]).append(data)
            print(name,'parsed',flush=True)
    target=args.run/'analysis/evidence.json'
    target.write_text(json.dumps(result,indent=2)+'\n',encoding='utf8')
    print(f'{len(result["kernels"])} public entries -> {target}',flush=True)


if __name__=='__main__':main()
