"""Executable arithmetic experiments for the teaching models, not CUDA benchmarks."""
from common import ROOT, REVISION
from kernel_map_profiles import profile
from lessons_small_attention import SMALL_NAMES
import json
import math


def physical(t, cw, words):
    return (t//16)*(16*words)+(cw//8)*128+(t%8)*16+(cw%4)*4+((cw%8)//4)*2+(t%16)//8


def decode_physical(address, words):
    # Independently recover coordinates by selecting the documented bit fields.
    outer,inner=divmod(address,16*words)
    panel,within=divmod(inner,128)
    return outer*16+((within>>4)&7)+8*(within&1),panel*8+((within>>2)&3)+4*((within>>1)&1)


def run(inventory,evidence):
    checks=[]
    for words in (256,512):
        for height,width in ((4,4),(8,12),(36,60)):
            tokens=height*width
            spatial=[]
            for t in range(tokens):
                y,x=divmod(t,width)
                s=16*((y//4)*(width//4)+x//4)+4*(y%4)+x%4
                spatial.append(s)
            assert sorted(spatial)==list(range(tokens))
            # Exhaustive round trip through the independent bit-field decoder.
            for t in range(tokens):
                for cw in range(words):
                    assert decode_physical(physical(t,cw,words),words)==(t,cw)
            align=32 if words==256 else 16
            padded=math.ceil(tokens/align)*align
            checks.append(dict(model='repack',words_per_token=words,height=height,width=width,
                               checked_payload_words=tokens*words,padded_tokens=padded,
                               result='Spatial bijection and packed-address encode/decode round trip passed.'))
    for count in (1,136,255,256,257,272,300,544):
        for threads in (128,256,512):
            grid=math.ceil(count/threads)
            writes=[b*threads+t for b in range(grid) for t in range(threads) if b*threads+t<count]
            assert writes==list(range(count))
            checks.append(dict(model='counter',count=count,threads=threads,grid=grid,
                               result='Exactly one writer per live word; no tail writer.'))
    kernels={}
    for name,entry in inventory['entries'].items():
        # The legacy design-check file stays exactly the 81 historical entries.
        # Additive Small31 entries write evidence-small/design-checks.json.
        if name in SMALL_NAMES:
            continue
        p=profile(name,entry)
        actions=evidence['kernels'][name]
        first=next(a for a in actions if a['report'].endswith('-full'))
        full=[a for a in actions if a['report']==first['report']]
        measured=first['metrics']['launch__shared_mem_per_block_static']['value']
        assert p['shared']==measured,(name,p['shared'],measured)
        record=dict(source_shared_bytes=p['shared'],measured_static_shared_bytes=measured,
                    resource_prediction='matched',kind=p['kind'])
        if p['kind']=='global-linear':
            # Four disjoint warp rectangles must partition the proposed CTA.
            owners=set()
            for w in range(p['warps']):
                for m in range(p['wm']):
                    for n in range(p['wn']):
                        coordinate=((w//2)*p['wm']+m,(w%2)*p['wn']+n)
                        assert coordinate not in owners
                        owners.add(coordinate)
            assert owners=={(m,n) for m in range(p['cm']) for n in range(p['cn'])}
            stages=p['k']//p['splits']//p['step']
            per_stage=(p['wm']//16)*(p['wn']//8)*(p['step']//p['ik'])
            counts=[]
            for action in full:
                blocks=math.prod(action['metrics']['launch__grid_dim_'+axis]['value'] for axis in 'xyz')
                predicted=int(blocks*p['warps']*stages*per_stage)
                observed=action['opcodes'].get('QMMA' if p['fp8'] else 'HMMA',0)
                assert predicted==observed,(name,predicted,observed)
                counts.append(dict(report=action['report'],action=action['action_index'],predicted=predicted,observed=observed))
            record.update(warp_output_partition='complete, no overlap',tensor_instruction_counts=counts)
        kernels[name]=record
    result=dict(source_revision=REVISION,scope='CPU arithmetic experiments and independent comparison with recorded NCU; no CUDA candidate execution or performance sweep.',
                checks=checks,kernels=kernels)
    path=ROOT/'docs/kernel-guide/evidence/design-checks.json'
    path.write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
    return result
