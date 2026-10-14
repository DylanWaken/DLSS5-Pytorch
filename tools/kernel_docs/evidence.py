"""Render measured, source-correlated SM120 evidence beside each kernel lesson."""
from pathlib import Path
from html import escape
import json
import re
import math
from common import ROOT, REVISION, source_url, svg

BASE=ROOT/'docs/kernel-guide/evidence'


def load():
    data=json.loads((BASE/'index.json').read_text(encoding='utf8'))
    data['kernels']={name:json.loads((BASE/path).read_text(encoding='utf8')) for name,path in data['kernels'].items()}
    return data


def value(action,name,default=None):
    return action['metrics'].get(name,{}).get('value',default)


def number(value):
    if value is None:return 'not collected'
    if isinstance(value,str):return escape(value)
    return f'{value:,.0f}' if value==int(value) else f'{value:,.2f}'


def metric(action,name):
    item=action['metrics'].get(name)
    if item is None:return '<span class="evidence-missing">not collected</span>'
    return f'<strong>{number(item["value"])}</strong> {escape(item["unit"])}'


def table(headers,rows):
    return '<div class="table-scroll"><table><thead><tr>'+''.join('<th>'+h+'</th>' for h in headers)+'</tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+str(v)+'</td>' for v in row)+'</tr>' for row in rows)+'</tbody></table></div>'


def source_link(path,line,label=None):
    return f'<a href="{source_url(path,line)}">{escape(label or (Path(path).name+":"+str(line)))}</a>' if path.startswith('csrc/') else escape(label or path or 'unmapped')


def action_link(action):
    return f'<a href="evidence/{action["report"]}.ncu-repz" download>{action["report"]} report</a>, range {action["range_index"]}, action {action["action_index"]}'


def resource(action):
    items=[('Compiled registers / thread','launch__registers_per_thread'),
           ('Allocated registers / thread (allocation granularity)','launch__registers_per_thread_allocated'),
           ('Source static shared / CTA','launch__shared_mem_per_block_static'),
           ('Dynamic shared / CTA','launch__shared_mem_per_block_dynamic'),
           ('Driver shared reservation / CTA','launch__shared_mem_per_block_driver'),
           ('Allocated shared / CTA','launch__shared_mem_per_block_allocated'),
           ('Resident CTA ceiling: registers','launch__occupancy_limit_registers'),
           ('Resident CTA ceiling: shared','launch__occupancy_limit_shared_mem'),
           ('Resident CTA ceiling: warps','launch__occupancy_limit_warps'),
           ('Achieved active-warp occupancy','sm__warps_active.avg.pct_of_peak_sustained_active'),
           ('Executed local loads','sass__inst_executed_local_loads'),
           ('Executed local stores','sass__inst_executed_local_stores')]
    items += [('Instructions classified as register spilling','sass__inst_executed_register_spilling'),
              ('Resident CTA ceiling: hardware block limit','launch__occupancy_limit_blocks'),
              ('Device SM count','device__attribute_multiprocessor_count'),
              ('Launch waves / SM','launch__waves_per_multiprocessor')]
    result='<div class="measured-evidence" id="measured-resources"><h3>Measured allocation on SM120</h3><p>'+action_link(action)+'. These values come from the compiled launch; <code>__maxnreg__</code> and declared array sizes above are source constraints. Shared-memory allocation also includes alignment and a driver reservation.</p>'
    result+=table(['Resource','NCU value','Exact metric'],[(label,metric(action,key),'<code>'+key+'</code>') for label,key in items])
    regs=value(action,'launch__registers_per_thread');block=value(action,'launch__block_size')
    if regs and block:result+=f'<p>{int(block)} threads × {int(regs)} compiler registers = <strong>{int(block*regs):,} register words</strong> before hardware allocation rounding. This is a launch budget, not a count of simultaneously live C++ array elements. Zero observed local loads/stores, when reported, applies to this fixture and binary.</p>'
    result+='<p>Achieved occupancy uses active-cycle normalization; it does not say every SM was busy. A one-CTA counter clear leaves nearly the whole device unused even if its active-SM occupancy percentage looks substantial. Grid waves and resident-CTA limits describe capacity, not exact scheduling order.</p>'
    local_load=value(action,'sass__inst_executed_local_loads',0);local_store=value(action,'sass__inst_executed_local_stores',0)
    if local_load or local_store:
        spills=value(action,'sass__inst_executed_register_spilling',0)
        result+=f'<p><strong>This compiled kernel also uses thread-private local memory:</strong> {number(local_load)} local load instructions and {number(local_store)} local store instructions. NCU classifies {number(spills)} instructions as register spilling. Explicit local arrays can also produce LDL/STL; local traffic must not automatically be called a spill. The register-level teaching graph above is a logical ownership map, not a promise that every temporary stays in physical registers.</p>'
        result+=svg('Measured compiler local-memory side path','0 0 1040 250',f'''<rect class="tensor" x="20" y="50" width="220" height="100" rx="8"/><text class="label" x="35" y="82">Lane register values</text><text class="small" x="35" y="114">source-owned temporaries</text><path class="edge" d="M245 99 H290"/><rect class="storage" x="300" y="50" width="270" height="100" rx="8"/><text class="label" x="315" y="82">Thread-private local address</text><text class="small" x="315" y="114">STL → local object / spill slot</text><path class="edge" d="M575 99 H620"/><rect class="storage" x="630" y="50" width="385" height="100" rx="8"/><text class="label" x="645" y="82">Hardware memory hierarchy</text><text class="small" x="645" y="114">L1 / L2; device memory if required</text><path class="edge" d="M780 155 V181 H125 V155"/><text class="small" x="320" y="206">LDL returns the value to registers; no shared-memory bank is involved.</text>''','This extra path is supported by measured LDL/STL instructions. Its slot is compiler-selected and does not change the tensor’s logical token coordinate. See mapped SASS for the exact local address expression.')
    return result+'</div>'


def launch(action,fixture):
    grid=[value(action,'launch__grid_dim_'+k) for k in 'xyz'];block=[value(action,'launch__block_dim_'+k) for k in 'xyz']
    result='<aside class="measured-evidence"><h3>Observed launch for this lesson</h3><p><strong>Grid '+escape(' × '.join(map(str,grid)))+'; block '+escape(' × '.join(map(str,block)))+'</strong>. '+action_link(action)+'. Workload: '+escape(fixture['kind'])+'.'
    if fixture.get('height'):result+=f' Field {fixture["height"]}×{fixture["width"]}; valid height {fixture.get("valid_height",fixture["height"])}.'
    result+=' The report confirms launch dimensions; token/channel responsibility follows from the source index equations.</p>'
    if fixture.get('dispatches',1)>1:result+='<p>This logical call uses multiple ordered launches. The table identifies one physical launch; use the per-entry evidence JSON for every captured split. A logical grid is not necessarily one resident GPU grid.</p>'
    return result+'</aside>'


def timeline_svg(action,name):
    path=BASE/'timelines'/(name+'.svg')
    if not path.is_file():return '<p>PM sampling did not produce a usable timeline for this launch; a short kernel may have too few samples to resolve its phases.</p>'
    xml=path.read_text(encoding='utf8')
    xml=xml[xml.index('<svg'):].replace('<svg ', '<svg style="min-width:1000px" ',1)
    return '<figure class="diagram measured-timeline"><div class="diagram-scroll" tabindex="0">'+xml+'</div><figcaption>Measured aggregate activity; each track uses its own replay and sample order. This is not an exact CTA/warp issue timeline. <a href="evidence/timelines/'+name+'.svg" download>Download chart SVG</a>.</figcaption></figure>'


def trace(action,source_action,name,all_full,all_source,p):
    result='<section class="measured-evidence" id="ncu-evidence"><h3>Check the walkthrough against executed instructions and counters</h3>'
    result+='<p>'+action_link(action)+f'. <a href="evidence/{name}.json">Download this entry’s extracted measurements</a>. <a href="measurement-method.html">Read the fixture, replay and evidence limits</a>. NCU observes this workload in aggregate; the colored token’s exact addresses are derived from source, not reconstructed from sampled memory transactions.</p>'
    if len(all_full)>1:
        result+='<p><strong>Multiple physical launches implement this logical call.</strong> The resource and counter table uses the first launch as its identified case. Instruction rows and excerpt annotations below also inspect later launches, where the final normalization or output store can occur.</p>'
        result+=table(['Physical launch','Grid X × Y × Z','Duration','Executed tensor instructions'],[(action_link(a),' × '.join(number(value(a,'launch__grid_dim_'+k)) for k in 'xyz'),metric(a,'gpu__time_duration.sum'),number(a['opcodes'].get('HMMA',0)+a['opcodes'].get('QMMA',0))) for a in all_full])
    stats=[('Instrumented kernel duration','gpu__time_duration.sum'),('Tensor-pipeline activity','sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_elapsed'),('DRAM throughput / peak','gpu__dram_throughput.avg.pct_of_peak_sustained_elapsed'),('DRAM read bytes','dram__bytes_op_read.sum'),('DRAM write bytes','dram__bytes_op_write.sum'),('L1 sector hit rate','l1tex__t_sector_hit_rate.pct'),('L2 sector hit rate','lts__t_sector_hit_rate.pct'),('Shared load bank-conflict counter','l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_ld.sum'),('Shared store bank-conflict counter','l1tex__data_bank_conflicts_pipe_lsu_mem_shared_op_st.sum'),('Source-correlated shared wavefronts','memory_l1_wavefronts_shared'),('Ideal shared wavefronts for those accesses','memory_l1_wavefronts_shared_ideal')]
    result+=table(['Observation','Measured value','Metric'],[(label,metric(action,key),'<code>'+key+'</code>') for label,key in stats])
    actual=value(action,'memory_l1_wavefronts_shared');ideal=value(action,'memory_l1_wavefronts_shared_ideal')
    if actual is not None and ideal is not None:
        result+=f'<p>The SourceCounters actual/ideal shared-service metrics report {number(actual)} against {number(ideal)} ideal: <strong>{number(actual-ideal)} excess</strong>. NCU names these metrics <code>memory_l1_wavefronts_shared*</code> but the Python API reports their unit as <code>sectors</code>; that reported unit is preserved in the table. '
        result+=('This supports the shared-access layout for the profiled requests. ' if actual==ideal else 'There is measurable excess shared service; do not label every access conflict-free. ')
        result+='Whole-kernel hardware bank counters cover a different collection scope and can be nonzero even when this instrumented subset matches ideal. Neither metric proves a particular unmeasured source line is conflict-free.</p>'
    groups=[('Global load instructions','LDG'),('Global store instructions','STG'),('Shared load instructions','LDS'),('Shared store instructions','STS'),('Local load instructions','LDL'),('Local store instructions','STL'),('Async bulk transfer','UBLKCP'),('Async lane copy','LDGSTS'),('Half tensor-core multiply','HMMA'),('FP8 tensor-core multiply','QMMA'),('Warp exchange','SHFL'),('Matrix-fragment rearrangement','MOVM'),('Fused Half arithmetic','HFMA2'),('Half multiply','HMUL2'),('Half add','HADD2'),('Global reduction instruction','REDG'),('Half packing/conversion','F2FP'),('Texture sampling','TEX'),('Surface output','SUST'),('Memory ordering / barriers','SYNCS'),('CTA barrier','BAR'),('Elected issuer','ELECT'),('Integer bit/address map','LOP3')]
    rows=[]
    for measured in all_full:
        for meaning,opcode in groups:
            count=measured['opcodes'].get(opcode,0)
            if not count:continue
            item=next((x for x in measured['instructions'] if re.search(r'\b'+opcode+r'[.\s]',x['sass'])),None)
            location=source_link(item['path'],item['line']) if item else 'No representative mapping'
            instruction='<code>'+escape(item['sass'])+'</code>' if item else '<code>'+opcode+'</code>'
            rows.append((meaning,f'{measured["range_index"]}/{measured["action_index"]}',number(count),instruction,location))
    result+='<h4>Dynamic SASS evidence for the mechanisms above</h4><p>Counts below use <code>sass__inst_executed_per_opcode</code>: issued/executed warp instructions, including instructions with predicated-off lanes. They are not successful memory transactions, scalar operations, threads, or PTX statements. A PTX operation may lower to several SASS instructions. Representative source locations identify one use; the count includes all uses of that opcode in the identified action.</p>'+table(['Mechanism','Range/action','Warp instructions','Representative SASS','Mapped source'],rows)
    if p['kind']=='global-linear':
        ktile=32 if p['fp8'] else 16
        stages=p['k']//p['splits']//p['step']
        mma_per_stage=(p['wm']//16)*(p['wn']//8)*(p['step']//ktile)
        reconcile=[]
        for measured in all_full:
            blocks=math.prod(value(measured,'launch__grid_dim_'+axis) for axis in 'xyz')
            expected=blocks*p['warps']*stages*mma_per_stage
            observed=measured['opcodes'].get('QMMA' if p['fp8'] else 'HMMA',0)
            assert expected==observed,(name,expected,observed)
            reconcile.append((action_link(measured),f'{blocks} × {p["warps"]} × {stages} × {mma_per_stage}',number(expected),number(observed)))
        result+='<h4>Reconcile the reduction loop with the measured instruction count</h4>'
        result+=f'<p>One warp owns M{p["wm"]}×N{p["wn"]}. For each K{p["step"]} stage it issues ({p["wm"]}/16) × ({p["wn"]}/8) × ({p["step"]}/{ktile}) = <strong>{mma_per_stage} matrix instructions</strong>. Each split consumes {stages} stages. Multiplying by measured physical CTAs and {p["warps"]} warps per CTA predicts the opcode total below. The exact match checks the compiled loop work for this binary; it does not imply that every lane carries a valid tail token.</p>'
        result+=table(['Physical launch','CTAs × warps × stages × MMA/stage','Source prediction','Measured HMMA/QMMA'],reconcile)
    tensor=value(action,'sm__pipe_tensor_cycles_active.avg.pct_of_peak_sustained_elapsed')
    dram=value(action,'gpu__dram_throughput.avg.pct_of_peak_sustained_elapsed')
    result+=f'<p>For this launch, tensor activity is {number(tensor) + chr(37) if tensor is not None else "not collected"} and DRAM throughput is {number(dram) + chr(37) if dram is not None else "not collected"}. When available, these use different peak denominators and must not be added. '
    if any(a['opcodes'].get('HMMA',0) or a['opcodes'].get('QMMA',0) for a in all_full):result+='Executed HMMA/QMMA confirms tensor-core lowering; activity alone does not establish that the kernel is compute-bound. '
    else:result+='No executed HMMA or QMMA appears in this fixture; integer/layout/control work should not be credited with tensor-core computation. '
    result+='The pipeline and layout explain how reuse is intended to help. Proving a speedup needs an A/B implementation under the same fixture and timing protocol; these measurements do not supply that experiment.</p>'
    sample=value(source_action,'smsp__pcsamp_sample_count',0)
    result+='<h4>Sampled warp states and source attribution</h4><p>'+action_link(source_action)+f'. Total <code>smsp__pcsamp_sample_count</code>: {number(sample)}. Samples are statistical observations, not cycle-exact traces. <code>selected</code> means issued; <code>not_selected</code> means eligible but another warp was chosen. Neither is a dependency stall. Inline helpers may receive attribution for several callers.</p>'
    totals=sorted(source_action['stall_totals'].items(),key=lambda x:x[1],reverse=True)[:5]
    result+=table(['Sample state','Count','Fraction of total samples'],[(escape(k),number(v),number(100*v/sample)+'%' if sample else 'insufficient samples') for k,v in totals])
    hotspots=sorted(source_action['lines'],key=lambda x:sum(x['stalls'].values()),reverse=True)[:5]
    result+=table(['Source line','Samples by state','Executed instruction example'],[(source_link(x['path'],x['line']),'; '.join(escape(k)+': '+number(v) for k,v in sorted(x['stalls'].items(),key=lambda kv:kv[1],reverse=True)[:3]),'<code>'+escape(x['sass'][0] if x['sass'] else 'No instruction counter at sampled PC')+'</code>') for x in hotspots if x['stalls']])
    if len(all_source)>1:
        result+=table(['Other source-report launch','Total samples','Most sampled states'],[(action_link(a),number(value(a,'smsp__pcsamp_sample_count')),', '.join(escape(k)+': '+number(v) for k,v in sorted(a['stall_totals'].items(),key=lambda x:x[1],reverse=True)[:3])) for a in all_source if a is not source_action])
    result+=timeline_svg(action,name)
    return result+'</section>'


def annotate_excerpts(body,actions):
    def augment(match):
        html=match[0]
        found=re.search(r'/blob/'+REVISION+r'/(csrc/[^"#]+)#L(\d+)-L(\d+)',html)
        if not found:return html
        path,start,end=found[1],int(found[2]),int(found[3])
        matches=[(a,[r for r in a['lines'] if r['path']==path and start<=r['line']<=end and r['executed']]) for a in actions]
        matches=[(a,rows) for a,rows in matches if rows]
        if not matches:
            return html+'<p class="source-evidence muted">NCU mapping: no executed SASS was attributed directly to these lines in this build. Inlining can attribute work to an included helper. The source excerpt establishes the algorithm; this mapping gap is not proof that the step was skipped.</p>'
        result=html+'<details class="source-evidence"><summary>NCU evidence mapped to this excerpt</summary>'
        for action,lines in matches:
            ops={}
            for row in lines:
                for key,n in row['opcodes'].items():ops[key]=ops.get(key,0)+n
            top=sorted(ops.items(),key=lambda x:x[1],reverse=True)[:6]
            result+='<p>'+action_link(action)+'. Warp instructions attributed to this source range: '+', '.join('<code>'+escape(k)+'</code> '+number(v) for k,v in top)+'. Counts include repeated loop iterations, participating CTAs and predicated instructions; they are not per-token counts.</p>'+table(['Source line','Representative executed SASS'],[(source_link(path,r['line']),'<code>'+escape(r['sass'][0])+'</code>') for r in sorted(lines,key=lambda x:x['executed'],reverse=True)[:3] if r['sass']])
        return result+'</details>'
    return re.sub(r'<details class="source"[^>]*>.*?</details>',augment,body,flags=re.S)


def design_review(full, all_full, p):
    """Close the design loop without manufacturing a historical tuning sweep."""
    shared=value(full,'launch__shared_mem_per_block_static')
    opcodes={}
    for action in all_full:
        for op,n in action['opcodes'].items():opcodes[op]=opcodes.get(op,0)+n
    tensor=sum(opcodes.get(k,0) for k in ('HMMA','QMMA'))
    local=sum(opcodes.get(k,0) for k in ('LDL','STL'))
    actual=value(full,'memory_l1_wavefronts_shared')
    ideal=value(full,'memory_l1_wavefronts_shared_ideal')
    rows=[('Does the storage plan fit its declared budget?',
           f'{p["shared"]:,} application shared bytes per CTA; compiler allocation is a later constraint.',
           f'LaunchStats reports {number(shared)} static shared bytes. Compiled registers: {number(value(full,"launch__registers_per_thread"))} per thread.',
           'The source shared-byte prediction matches. Use the allocation table below to account for rounding and driver bytes; then revisit tile size if residency is insufficient.')]
    if p['kind'] in ('repack','counter'):
        rows.append(('Is the minimal algorithm still minimal after compilation?',
                     'Independent word stores/copies need no tensor instructions or application shared staging.',
                     f'{number(tensor)} HMMA/QMMA instructions; {number(shared)} static shared bytes.',
                     'Retain the direct path as the baseline. A wider copy or fused reset still requires correctness and controlled timing against it.'))
    else:
        rows.append(('Did the matrix formulation reach the intended execution engine?',
                     'Lower the matrix contractions to warp-level tensor instructions while keeping the numerical boundary operations explicit.',
                     f'{number(opcodes.get("HMMA",0))} HMMA and {number(opcodes.get("QMMA",0))} QMMA instructions across the captured physical launches.',
                     'The engine is observed. Check source-mapped instructions and reduction counts below; a tensor opcode alone does not establish accuracy or speed.'))
    rows.append(('Did the live-value plan stay entirely in registers?',
                 'Try to keep the hot fragments in registers; do not assume C++ locals or a register cap guarantee this.',
                 f'{number(local)} LDL/STL instructions across captured launches; first launch has {number(value(full,"sass__inst_executed_register_spilling",0))} instructions classified as spilling.',
                 'Local traffic was observed: inspect explicit arrays and spill classification before reducing tile size or changing lifetimes.' if local else 'No executed local traffic was recorded for this fixture. Keep the compiler check when changing fusion, width or unrolling.'))
    if actual is not None and ideal is not None and actual:
        excess=actual-ideal
        rows.append(('Did the shared addressing achieve ideal service?',
                     'A candidate bank/lane mapping should avoid excess service; enumerate addresses before introducing a swizzle.',
                     f'Instrumented shared service: actual {number(actual)}, ideal {number(ideal)}, excess {number(excess)}.',
                     'This candidate does not achieve ideal service over the instrumented accesses. Attribute the excess to source before testing a different layout.' if excess else 'The instrumented accesses match ideal in this fixture. This supports the mapping without proving every access in every workload conflict-free.'))
    rows.append(('Is the more complicated candidate faster?',
                 'The proposed reuse, fusion or overlap should reduce total elapsed time without changing the operator contract.',
                 'Only the final implementation was profiled here. Intermediate candidates in the lesson have no measured A/B timings.',
                 'Open experiment: retain a correctness-checked baseline, change one mechanism, benchmark outside NCU, then profile the pair to explain the result.'))
    return '<div class="design-review" id="design-review"><h3>Close the design loop: predictions, tests, decisions</h3><p>We have now assembled a candidate implementation. The following recorded experiments test its resource and instruction predictions. They validate parts of the design; they do not establish that the chosen tile or pipeline is optimal. Read a failed prediction as a reason to revise the candidate.</p>'+table(['Design question','Prediction before profiling','Recorded test / result','Engineering decision'],rows)+'</div>'


def enrich(lesson,data):
    actions=data['kernels'][lesson['name']]
    full=next(a for a in actions if a['report'].endswith('-full'))
    src=next(a for a in actions if a['report']==full['report'].replace('-full','-source') and a['range_index']==full['range_index'] and a['action_index']==full['action_index'])
    all_full=[a for a in actions if a['report']==full['report']]
    all_source=[a for a in actions if a['report']==src['report']]
    fixture=data['reports'][full['report']]['fixtures'][lesson['name']]
    body=lesson['body']
    split=body.index('<h2 id="trace">')
    body=body[:split]+annotate_excerpts(body[split:],all_full)
    budget='<p class="design-checkpoint"><strong>Budget checkpoint.</strong> Treat the bytes and live values above as a design estimate. Compile the candidate before accepting it: registers, local traffic, allocation rounding and residency can overturn this choice. We will <a href="#measured-resources">compare the budget with the compiled allocation</a> after constructing the implementation.</p>'
    validation=design_review(full,all_full,lesson['map_profile'])+launch(full,fixture)+resource(full)+trace(full,src,lesson['name'],all_full,all_source,lesson['map_profile'])
    # The address/atlas enrichers can append teaching material after the marker.
    # Finish that construction before the final prediction-versus-observation review.
    if body.count('<!-- NCU_EVIDENCE -->')!=1:raise ValueError('Expected one validation marker: '+lesson['name'])
    body=body.replace('<!-- RESOURCE_EVIDENCE -->',budget).replace('<!-- NCU_EVIDENCE -->','')+validation
    lesson['body']=body


def method_page(data):
    rows=[]
    for name,actions in data['kernels'].items():
        full=next(a for a in actions if a['report'].endswith('-full'))
        rows.append((f'<a href="{name}.html#ncu-evidence"><code>{name}</code></a>',metric(full,'launch__registers_per_thread'),metric(full,'launch__shared_mem_per_block_static'),metric(full,'gpu__time_duration.sum'),f'<a href="evidence/{name}.json">JSON</a>'))
    body=(ROOT/'tools/kernel_docs/design-method.html').read_text(encoding='utf8')+'''
<h2 id="method">What was actually measured</h2><p>Collected 13 October 2026 on NVIDIA RTX PRO 6000 Blackwell Workstation Edition, SM120, using Nsight Compute 2026.3.0 and CUDA 12.8.93. A fresh native SM120 library was built with <code>-O3 -lineinfo</code>. Every public entry has both a full report (including PM sampling) and a separate SourceCounters report. The full/source pair has a different replay pass set, so sample totals and instrumented timings need not agree between reports.</p><p>The trunk uses 3840×2160 requested image geometry, checkpoint weights, seeded random packed inputs scaled by .02, and five warmups. The model pads intermediate fields: level 0 is 1088×1920 and the C1024 bottleneck is 36×60 (2160 tokens). Only the first logical call of each public entry is selected by NVTX; dependencies still execute in schedule order. Any multi-launch split dispatch is retained in the raw report and per-entry JSON. Renderer entries are supplemental 2176×3840 fields, valid height 2160, with constant .25 current/color textures, no history/motion/depth/conditioning, point sampling, and seeded postprocess feature inputs. The supplemental C32 output-view uses 1088×1920 and phase 1. These fixtures exercise entries, not every optional branch or real-scene distribution.</p>
<h2 id="limits">Which claims each kind of evidence supports</h2>'''
    body+=table(['Claim','Evidence','Limit'],[
        ('Tensor/lane/address equations','Pinned CUDA source plus worked arithmetic','NCU does not record one semantic model token moving through memory.'),
        ('Actual launch, registers, shared allocation','LaunchStats from this native binary','A register cap is not allocated registers; source shared bytes exclude driver reservation.'),
        ('An instruction was executed','Dynamic SASS opcode counts and per-source mapping','One opcode total combines all its uses. PTX and SASS do not have one-to-one counts.'),
        ('Shared accesses need excess service','Instrumented actual and ideal shared wavefronts; bank counters','Whole-kernel counters do not identify one source access. Different collection methods have different scopes.'),
        ('Warp stalls / tail behavior','SourceCounters samples and PM-sampling activity','Statistical, replay-dependent, and sometimes sparse. Not an exact warp scheduling log.'),
        ('Cache behavior','L1/L2 hit rates and DRAM bytes for the launch','Replay/cache control changes reuse. No cache residency guarantee for the illustrated token.'),
        ('An optimization is faster','Requires controlled A/B kernel timing','Not established by this documentation profiling run.'),
        ('Numerical correctness','Source reasoning and separate correctness tests','NCU is not a correctness proof or an exhaustive branch test.')])
    body+='''<h2 id="reproduce">Reproduce and inspect the evidence</h2><p><a href="evidence/build-receipt.json">Build receipt and source hashes</a> · <a href="evidence/commands.json">Exact collection commands</a> · <a href="evidence/index.json">Evidence index</a>. The library SHA-256 is recorded in every report receipt. The build regenerated a host policy header with whitespace-only formatting changes; token-equivalence was checked and the source checkout restored. CUDA kernel sources match the pinned revision. The harness and parser are checked into <code>tools/profile_kernel_docs.py</code> and <code>tools/extract_kernel_doc_evidence.py</code>.</p><pre><code>ncu --nvtx --nvtx-include docs/ --set full --import-source yes \\
  -o fp16-full python tools/profile_kernel_docs.py \\
  --extension PATH_TO_NATIVE_SM120_LIBRARY --precision fp16 --output fp16-full.json
# Repeat with --section SourceCounters --section LaunchStats; then FP8.
python tools/extract_kernel_doc_evidence.py profile/YOUR_NEW_RUN</code></pre><p>Use a new run directory containing <code>harness/</code>, <code>reports/</code>, <code>analysis/</code> and <code>REPORT.md</code>. The installed NCU version has no <code>source</code> set, so the source collection requests its sections explicitly. Open .ncu-repz files in Nsight Compute to inspect full metrics, source and SASS. The extraction uses <code>ncu_report</code>, not rounded CLI tables.</p>'''
    body+=table(['Raw report','Bytes','SHA-256'],[(f'<a download href="evidence/{key}.ncu-repz">{key}</a>',number(r['bytes']),'<code>'+r['sha256']+'</code>') for key,r in data['reports'].items()])
    body+='<h2 id="coverage">Measured coverage: all 81 public entries</h2><p>Register/shared budgets and instrumented duration for one identified physical launch per entry. Read each lesson for its workload, source mapping and interpretation. Durations are not a ranking of kernel quality: tensor sizes and work differ.</p>'+table(['Kernel lesson','Registers/thread','Static shared/CTA','Duration','Evidence'],rows)
    return dict(slug='measurement-method',title='Design, implement, test, revise',summary='The six-section design process, a controlled experiment ledger, reproducible SM120 profiles, and the evidence behind each decision.',body=body)
