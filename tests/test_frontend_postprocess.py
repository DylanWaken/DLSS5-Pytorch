"""Direct Driver qualification for semantic post FP8/Half; no extension imports.
Default is a CPU fixture/provenance plan. Pass --execute to run the explicit GPU comparison.
CUDA arrays, tensor backings, modules and graph objects outlive every replay.
"""
from pathlib import Path
import argparse,hashlib,json,struct,sys,statistics
ROOT=Path(__file__).resolve().parents[1]
BASE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))

def sha(data):return hashlib.sha256(data).hexdigest()
def native_assets(precision):
 from dlssnr.checkpoint import load_checkpoint, _natural, promote_tensor, _half_bias
 from dlssnr.weights import packed_f16_weight_index
 import numpy as np
 import torch
 archive=load_checkpoint(ROOT/f'ckpts/dlss5_nr_{precision}.pt')
 code=(ROOT/'assets/vendor_modules/module_0.cubin').read_bytes()
 manifest=json.loads((ROOT/'assets/vendor_modules/manifest.json').read_text())
 entry=next(e for e in manifest['modules'][0]['entries'] if e['file']=='module_0.cubin')
 expected=entry.get('sha256')
 assert expected==sha(code),'Native cubin differs from pinned extraction manifest'
 if precision=='fp8':return code,archive._records['block70.layer0.layer'].numpy().tobytes()
 # Frontend records are not yet exposed by checkpoint.kernel_record. Pack the
 # independently recovered Half offsets, preserving all ancillary tensor bits.
 layout={'w1':0,'w2':8192,'ffn_scale':16400,'input_scale':16464,'adapter_scale':16528,
         'qkv':16592,'bias':22736,'head_scale':30928,'projection':30944,'attn_scale':32992,'head':33072}
 output=bytearray(34096)
 for name,k,n in (('w1',32,128),('w2',128,32),('qkv',32,96),('projection',32,32),('head',32,4)):
  value=promote_tensor(_natural(archive._state,70,name),torch.float16).reshape(k,n).numpy()
  raw=np.zeros(k*((n+15)//16*16),dtype='<f2')
  rows=np.arange(k,dtype=np.int64)[:,None];cols=np.arange(n,dtype=np.int64)[None,:]
  raw[packed_f16_weight_index(rows,cols,n)]=value
  data=raw.tobytes();output[layout[name]:layout[name]+len(data)]=data
 for name in ('ffn_scale','input_scale','adapter_scale','head_scale','attn_scale'):
  dtype=torch.float32 if name=='head_scale' else torch.float16
  data=promote_tensor(_natural(archive._state,70,name),dtype).numpy().tobytes()
  output[layout[name]:layout[name]+len(data)]=data
 data=_half_bias(_natural(archive._state,70,'bias'));output[layout['bias']:layout['bias']+len(data)]=data
 return code,bytes(output)

def parameters(state,adapter,surface,weight,height,width,phase,case,images,blend,valid):
 sx,sy=((0,0),(4,4),(4,0),(0,4))[phase]
 blob=bytearray(184)
 struct.pack_into('<4Q4ifi',blob,0,state,adapter,surface,weight,height,width,-sx,-sy,.03125 if case!='raw' else 1.,int(case!='raw'))
 struct.pack_into('<2i',blob,172,*valid)
 if case!='raw':
  struct.pack_into('<Q',blob,56,images['color'].texture.value)
  struct.pack_into('<6f',blob,64,0,0,1,1,1,1)
 if case in ('history','motion','history_nan_scale','history_padded'):
  struct.pack_into('<3Q',blob,88,images['history'].texture.value,images['motion'].texture.value,blend)
  struct.pack_into('<i',blob,112,int(case=='motion'))
  struct.pack_into('<6f',blob,116,.0125,-.00625,.925,1.03125,1,1)
  struct.pack_into('<6f',blob,140,.00625,.0125,1.025,.975,1,1)
  struct.pack_into('<2f',blob,164,.0125,-.025)
 return bytes(blob),{'block':[32,1,1],'grid':[(width+sx+7)//8,(height+sy+7)//8,1]}

def execute(args,native_code,weight,report):
 import numpy as np
 import torch
 from tools.native_reference.vendor_benchmark import VendorModule,guarded_tensor,GUARD_BYTES,GUARD_VALUE
 from tests.native_cuda_image import CudaImage
 torch.cuda.set_device(0);torch.cuda.init()
 if torch.cuda.get_device_capability()!=(12,0):raise RuntimeError('Pinned native cubin requires SM120')
 stream=torch.cuda.Stream();stream.wait_stream(torch.cuda.current_stream())
 native=None;candidate=None;surfaces=[];textures=[];graphs=[]
 dtype=torch.float8_e4m3fn if args.precision=='fp8' else torch.float16
 symbol='cc_tinlayout_fused_post_block_swin_1h_32'+('_fp8' if args.precision=='fp8' else '')
 name='output_window_postprocess_c32_'+args.precision
 mangled=f'_ZN6dlssnr13reconstructed{len(name)}{name}{len(name)}{name}ENS1_10ParametersE'
 h,w=args.height,args.width
 try:
  with torch.cuda.stream(stream),torch.inference_mode():
   native=VendorModule(native_code,stream.cuda_stream,symbol,184)
   candidate=VendorModule(args.cubin.read_bytes(),stream.cuda_stream,mangled,184)
   report['native_resources']=native.attributes;report['candidate_resources']=candidate.attributes
   surfaces.append(CudaImage(native,h+8,w+8,0,texture=False))
   surfaces.append(CudaImage(native,h+8,w+8,0,texture=False))
   sentinel=torch.full((h+8,w+8,4),-123.25,device='cuda',dtype=torch.float32)
   captures=[torch.empty_like(sentinel),torch.empty_like(sentinel)]
   # Finite independent values directly in physical storage: both entries see
   # identical bytes; no candidate-only packing/gather kernels are timed.
   generator=torch.Generator(device='cpu').manual_seed(20261006)
   state=(torch.randn(h//2*w//2*32,generator=generator,dtype=torch.float32)*args.amplitude).to(dtype).view(torch.uint8).numpy().tobytes()
   adapter=(torch.randn(h*w*32,generator=generator,dtype=torch.float32)*args.amplitude).to(dtype).view(torch.uint8).numpy().tobytes()
   initial={'state':state,'adapter':adapter,'weight':weight,'blend':struct.pack('<e',.625),'nan_blend':struct.pack('<H',0x7e00)}
   allocations={n:guarded_tensor(data,0) for n,data in initial.items()}
   yy,xx=torch.meshgrid(torch.arange(h,device='cuda',dtype=torch.float32),torch.arange(w,device='cuda',dtype=torch.float32),indexing='ij')
   texture_data={
    'color':torch.stack(((xx%17)/17,(yy%19)/19,((xx+yy)%23)/23,torch.ones_like(xx)),dim=-1).contiguous(),
    'history':torch.stack((((xx*3+yy)%29)/29,((yy*7+xx)%31)/31,((xx*2+yy*5)%37)/37,torch.ones_like(xx)),dim=-1).contiguous(),
    'motion':torch.stack(((xx%11-5)/7,(yy%13-6)/9,torch.zeros_like(xx),torch.ones_like(xx)),dim=-1).contiguous()}
   images={}
   for key,data in texture_data.items():
    image=CudaImage(native,h,w,0,texture=True,linear=args.linear);textures.append(image);image.copy_from(data);images[key]=image
   stream.synchronize()
   report['cases']=[]
   for case in args.cases:
    valid=(w-3,h-5) if case=='history_padded' else (w,h)
    blend=allocations['nan_blend' if case=='history_nan_scale' else 'blend'][1]
    for phase in args.phases:
     params=[]
     for surface in surfaces:
      blob,spec=parameters(allocations['state'][1],allocations['adapter'][1],surface.surface.value,allocations['weight'][1],h,w,phase,case,images,blend,valid)
      params.append(blob);surface.copy_from(sentinel)
     native.launch(params[0],spec);candidate.launch(params[1],spec)
     for surface,capture in zip(surfaces,captures):surface.copy_to(capture)
     stream.synchronize()
     equal=torch.equal(captures[0].view(torch.int32),captures[1].view(torch.int32))
     borders=all(torch.equal(c[h:],sentinel[h:]) and torch.equal(c[:h,w:],sentinel[:h,w:]) for c in captures)
     row={'case':case,'phase':phase,'equal':equal,'surface_borders':borders,'launch':spec,'valid':valid}
     for i,capture in enumerate(captures):row['native_sha256' if i==0 else 'candidate_sha256']=sha(capture.cpu().numpy().tobytes())
     if not equal:
      different=torch.nonzero(captures[0].view(torch.int32)!=captures[1].view(torch.int32));row['different_f32_values']=different.shape[0]
      row['first_differences']=[{'index':idx.tolist(),'native':float(captures[0][tuple(idx)]),'candidate':float(captures[1][tuple(idx)])} for idx in different[:8]]
     for key,(allocation,_) in allocations.items():
      raw=allocation.cpu().numpy();assert np.all(raw[:GUARD_BYTES]==GUARD_VALUE) and np.all(raw[-GUARD_BYTES:]==GUARD_VALUE),f'{key} guard'
      assert raw[GUARD_BYTES:-GUARD_BYTES].tobytes()==initial[key],f'{key} mutated'
     row['immutable_guards']=True
     if args.timing and equal and borders:
      graphs=[]
      for module,blob in ((native,params[0]),(candidate,params[1])):
       graph=torch.cuda.CUDAGraph()
       with torch.cuda.graph(graph,stream=stream):
        for _ in range(32):module.launch(blob,spec)
       graphs.append(graph)
      for _ in range(4):
       for graph in graphs:graph.replay()
      stream.synchronize();times=[[],[]]
      for repeat in range(args.repeats):
       for role in ((0,1) if repeat%2==0 else (1,0)):
        begin,end=torch.cuda.Event(enable_timing=True),torch.cuda.Event(enable_timing=True)
        begin.record(stream);graphs[role].replay();end.record(stream);end.synchronize()
        times[role].append(begin.elapsed_time(end)*1000/32)
      row['native_us'],row['candidate_us']=[statistics.median(t) for t in times]
      row['ratio']=row['candidate_us']/row['native_us']
      for surface,capture in zip(surfaces,captures):surface.copy_to(capture)
      stream.synchronize()
      row['graph_replay_exact']=torch.equal(captures[0].view(torch.int32),captures[1].view(torch.int32)) and all(torch.equal(c[h:],sentinel[h:]) and torch.equal(c[:h,w:],sentinel[:h,w:]) for c in captures)
      for key,(allocation,_) in allocations.items():
       raw=allocation.cpu().numpy()
       assert np.all(raw[:GUARD_BYTES]==GUARD_VALUE) and np.all(raw[-GUARD_BYTES:]==GUARD_VALUE),f'{key} graph guard'
       assert raw[GUARD_BYTES:-GUARD_BYTES].tobytes()==initial[key],f'{key} graph mutation'
      for graph in graphs:graph.reset()
      graphs=[]
     report['cases'].append(row);args.output.write_text(json.dumps(report,indent=2));print(json.dumps(row),flush=True)
   # Texture sources, destinations, arrays and modules remain live until here.
   report['pass']=all(v['equal'] and v['surface_borders'] and v['immutable_guards'] and v.get('graph_replay_exact',True) for v in report['cases'])
 finally:
  stream.synchronize()
  for graph in graphs:graph.reset()
  for image in reversed(textures+surfaces):image.close()
  if candidate is not None:candidate.close()
  if native is not None:native.close()

def main():
 p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--cubin',type=Path,required=True);p.add_argument('--precision',choices=('fp8','fp16'),required=True)
 p.add_argument('--width',type=int,default=1280);p.add_argument('--height',type=int,default=720)
 p.add_argument('--phases',type=int,nargs='+',default=[0,1,2,3]);p.add_argument('--amplitude',type=float,default=.02)
 p.add_argument('--cases',nargs='+',choices=('raw','color','history','motion','history_nan_scale','history_padded'),default=['raw','color','history','motion','history_nan_scale','history_padded'])
 p.add_argument('--linear',action='store_true');p.add_argument('--execute',action='store_true');p.add_argument('--timing',action='store_true');p.add_argument('--repeats',type=int,default=12)
 p.add_argument('--output',type=Path,required=True);a=p.parse_args()
 if a.height<16 or a.width<16 or a.height%8 or a.width%8 or a.height>4096 or a.width>4096:raise ValueError('16..4096 dimensions divisible by8 required')
 if any(x not in range(4) for x in a.phases):raise ValueError('phase0..3')
 code,weight=native_assets(a.precision)
 report={'executed':a.execute,'precision':a.precision,'height':a.height,'width':a.width,'native_cubin_sha256':sha(code),'candidate_cubin_sha256':sha(a.cubin.read_bytes()),'record_sha256':sha(weight),'record_bytes':len(weight),'texture_filter':'linear' if a.linear else 'point','pass':False}
 a.output.parent.mkdir(parents=True,exist_ok=True)
 try:
  if a.execute:execute(a,code,weight,report)
 except BaseException as error:report['error']=repr(error);raise
 finally:a.output.write_text(json.dumps(report,indent=2))
 print(a.output.resolve())
 return 0 if not a.execute or report['pass'] else 1
if __name__=='__main__':raise SystemExit(main())
