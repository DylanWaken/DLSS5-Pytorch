"""CPU-only policy lookup/codegen and continuous-resolution work planning."""
from __future__ import annotations
import argparse
from dataclasses import asdict
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import sys

if __package__ in (None,''):
    sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from tuning import resolution_policy as P

HERE=Path(__file__).resolve().parent
GEOMETRY=HERE.parent/'dlssnr'/'geometry.py'

def read(path):
    return json.loads(Path(path).read_text(encoding='utf8'))

def write(path,value):
    path=Path(path);path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(value,indent=2,sort_keys=True,allow_nan=False)+'\n',encoding='utf8',newline='\n')

def policy_files(paths=None,evidence_root=None):
    """Default to explicit per-device files. Generic JSON is only a template."""
    paths=list(paths) if paths else sorted(HERE.glob('sm_*.json'))
    P.require(bool(paths),'no per-device policy files; specify --policy explicitly')
    policies=[]
    for path in paths:
        path=Path(path);policy=read(path)
        if path.name.startswith('sm_'):
            match=re.fullmatch(r'sm_([1-9][0-9]*)\.json',path.name)
            P.require(match is not None and type(policy.get('device_sm')) is int and policy['device_sm']==int(match[1]),'per-device filename/SM mismatch')
        policies.append(P.verify_receipts(policy,evidence_root or path.parent))
    return P.combine(policies),[str(p) for p in paths]

def load_geometry(path=GEOMETRY):
    """Load the one staged geometry file, without importing dlssnr.__init__."""
    path=Path(path).resolve()
    name='_offline_resolution_geometry_'+hashlib.sha256(str(path).encode()).hexdigest()[:12]
    spec=importlib.util.spec_from_file_location(name,path)
    module=importlib.util.module_from_spec(spec);previous=sys.modules.get(name)
    sys.modules[name]=module
    try:
        spec.loader.exec_module(module)
    finally:
        if previous is None:sys.modules.pop(name,None)
        else:sys.modules[name]=previous
    return module

def axis_runs(G,first,last):
    result=[]
    for value in range(first,last+1):
        alignment=G._field_alignment(value)
        full=max(320,G.align_up(value,alignment))
        state=(alignment,full,full%(4*alignment)==0)
        if result and result[-1][2]==state:result[-1]=(result[-1][0],value,state)
        else:result.append((value,value,state))
    return result

def enumerate_plan(sm,precision,geometry_path=GEOMETRY):
    P.integer(sm,'sm',1);P.require(precision in P.PRECISIONS,'precision')
    G=load_geometry(geometry_path)
    xr=axis_runs(G,1280,3840);yr=axis_runs(G,720,2160)
    groups={};regions=[];cases=[]
    for x0,x1,_ in xr:
        for y0,y1,_ in yr:
            g=G.Geometry.from_valid(x0,y0)
            k=(g.full_width,g.full_height,g.levels)
            if k not in groups:
                groups[k]=len(cases)
                cases.append(dict(geometry_id=len(cases),**asdict(g)))
            regions.append(dict(width=[x0,x1],height=[y0,y1],geometry_id=groups[k]))
    pairs=sum((r['width'][1]-r['width'][0]+1)*(r['height'][1]-r['height'][0]+1) for r in regions)
    P.require(pairs==2561*1441,'continuous domain coverage mismatch')
    plan=dict(schema_version=1,kind='resolution_measurement_plan',sm=sm,precision=precision,
              bounds=P.BOUNDS,geometry_source_sha256=hashlib.sha256(Path(geometry_path).read_bytes()).hexdigest(),
              integer_resolution_count=pairs,physical_geometry_count=len(cases),
              cases=cases,regions=regions,measurements=[],
              scope='Exhaustive geometry enumeration only. Representatives are unmeasured; grouping does not establish measurement, admission or runtime qualification for any resolution.')
    plan['plan_sha256']=hashlib.sha256(P.canonical(plan).encode()).hexdigest()
    return plan

def resume_plan(plan,completed,evidence_root,geometry_path=GEOMETRY):
    """Skip only exact planned representatives backed by verified receipt bytes."""
    expected=enumerate_plan(plan.get('sm'),plan.get('precision'),geometry_path)
    P.require(P.canonical(plan)==P.canonical(expected),'plan or geometry identity changed')
    P.require(type(completed) is list,'completed must be a list of measurement rows')
    policy=dict(schema_version=1,bounds=P.BOUNDS,distance=P.DISTANCE,unmeasured_config_id=-1,
                anchors=completed,admissions=[])
    rows=P.verify_receipts(policy,evidence_root)['anchors']
    representatives={(c['valid_width'],c['valid_height']):c['geometry_id'] for c in plan['cases']}
    done=[]
    for row in rows:
        P.require((row['sm'],row['precision'])==(plan['sm'],plan['precision']),'completed family mismatch')
        P.require((row['width'],row['height']) in representatives,'completion is not a planned representative')
        done.append(representatives[(row['width'],row['height'])])
    return dict(schema_version=1,kind='resolution_resume_plan',plan_sha256=plan['plan_sha256'],
                completed_geometry_ids=sorted(done),pending_geometry_ids=sorted(set(range(len(plan['cases'])))-set(done)),
                measured_representatives=len(done),all_representatives_measured=len(done)==len(plan['cases']),
                runtime_qualified=False,actual_shape_admissions=[],
                scope='A completed geometry has one verified measured configuration at its representative. No winner or measurement of other integer resolutions is inferred.')

def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    sub=parser.add_subparsers(dest='command',required=True)
    for name in ('lookup','codegen'):
        q=sub.add_parser(name);q.add_argument('--policy',type=Path,action='append',help='Repeat to combine explicit policies; defaults to tuning/sm_*.json')
        q.add_argument('--evidence-root',type=Path,help='Receipt root; defaults to the policy directory')
        if name=='lookup':
            for field in ('width','height','sm'):q.add_argument('--'+field,type=int,required=True)
            q.add_argument('--precision',choices=P.PRECISIONS,required=True)
        else:q.add_argument('--output',type=Path,required=True)
    q=sub.add_parser('enumerate');q.add_argument('--sm',type=int,required=True)
    q.add_argument('--precision',choices=P.PRECISIONS,required=True);q.add_argument('--output',type=Path,required=True)
    q=sub.add_parser('resume-plan');q.add_argument('--plan',type=Path,required=True)
    q.add_argument('--completed',type=Path,required=True);q.add_argument('--evidence-root',type=Path,required=True)
    q.add_argument('--output',type=Path,required=True)
    a=parser.parse_args(argv)
    if a.command in ('lookup','codegen'):
        p,paths=policy_files(a.policy,a.evidence_root)
        if a.command=='lookup':result=P.lookup(p,a.width,a.height,a.sm,a.precision)
        else:
            a.output.parent.mkdir(parents=True,exist_ok=True)
            a.output.write_text(P.cpp_header(p),encoding='utf8',newline='\n')
            result=dict(output=str(a.output),policy_version=P.version(p),policy_files=paths,measured_anchors=len(p['anchors']),admissions=len(p['admissions']))
    elif a.command=='enumerate':
        plan=enumerate_plan(a.sm,a.precision);write(a.output,plan)
        result={k:plan[k] for k in ('plan_sha256','physical_geometry_count','integer_resolution_count')}
        result['output']=str(a.output)
    else:
        result=resume_plan(read(a.plan),read(a.completed),a.evidence_root);write(a.output,result)
    print(json.dumps(result,sort_keys=True,allow_nan=False))

if __name__=='__main__':
    main()
