"""Copy a completed 81-entry profiling run into the static documentation."""
import argparse
import json
from pathlib import Path
import shutil
import re

ROOT=Path(__file__).resolve().parents[1]


def timeline(name,action,target):
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    tracks=[(key,row) for key,row in action['timeline'].items() if row['values']][:3]
    if not tracks:return
    labels={
        'pmsampling:sm__inst_executed_realtime.avg.pct_of_peak_sustained_elapsed':'SM instruction activity',
        'pmsampling:sm__inst_executed_pipe_tensor_subpipe_hmma_realtime.avg.pct_of_peak_sustained_elapsed':'Floating-point tensor pipeline activity',
        'pmsampling:dram__bytes.avg.pct_of_peak_sustained_elapsed':'DRAM byte throughput',
        'pmsampling:sm__warps_active.avg.pct_of_peak_sustained_active':'Active warps'}
    with plt.rc_context({'svg.fonttype':'none','svg.hashsalt':name,'font.size':13,'axes.spines.top':False,'axes.spines.right':False}):
        fig,axes=plt.subplots(len(tracks),1,figsize=(12,1.7*len(tracks)+.65),squeeze=False,layout='constrained')
        for ax,(key,row),color in zip(axes[:,0],tracks,('#268c76','#bc692b','#436fb7')):
            vals=row['values'];ax.plot([i*row['bucket_size'] for i in range(len(vals))],vals,color=color,linewidth=1.5)
            ax.set_title(labels.get(key,key),loc='left',fontsize=14)
            ax.set_ylim(0,max(100,max(vals)*1.02));ax.set_ylabel('% of peak')
            ax.grid(alpha=.15);ax.set_xlabel(f'Sample order ({row["instances"]} samples; {row["bucket_size"]} per bucket)')
        fig.suptitle(name,fontsize=14,fontweight='bold')
        destination=target/'timelines'/(name+'.svg');destination.parent.mkdir(exist_ok=True)
        fig.savefig(destination,format='svg',metadata={'Date':None,'Description':'Independent replay sample-order tracks, not a cycle-exact warp trace.'})
        plt.close(fig)
        content=destination.read_text(encoding='utf8')
        content=re.sub(r'(<svg\b[^>]*>)',r'\1<title id="pm-chart-title">Measured PM sampling for '+name+'</title>',content,count=1)
        content=content.replace('<svg ', '<svg role="img" aria-labelledby="pm-chart-title" ',1)
        destination.write_text('\n'.join(line.rstrip() for line in content.splitlines())+'\n',encoding='utf8',newline='\n')


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run',type=Path)
    args=parser.parse_args()
    data=json.loads((args.run/'analysis/evidence.json').read_text(encoding='utf8'))
    assert len(data['kernels'])==81, 'Incomplete public-entry evidence coverage'
    target=ROOT/'docs/kernel-guide/evidence';target.mkdir(parents=True,exist_ok=True)
    def write(path,value):path.write_text(json.dumps(value,indent=2)+'\n',encoding='utf8',newline='\n')
    kernels=data.pop('kernels');data['kernels']={}
    for name,actions in kernels.items():
        assert any(a['report'].endswith('-full') for a in actions),name
        assert any(a['report'].endswith('-source') for a in actions),name
        write(target/(name+'.json'),actions);data['kernels'][name]=name+'.json'
        timeline(name,next(a for a in actions if a['report'].endswith('-full')),target)
    for key,report in data['reports'].items():
        source=ROOT/report['path']
        shutil.copyfile(source,target/(key+'.ncu-repz'))
    for filename in ('build-receipt.json','commands.json'):
        shutil.copyfile(args.run/'harness'/filename,target/filename)
    write(target/'index.json',data)
    print('Published extracted evidence and four raw reports for 81 entries')


if __name__=='__main__':main()
