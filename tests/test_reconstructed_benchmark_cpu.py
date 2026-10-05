"""Execute the actual graph protocol using CPU fakes and the real lifetime owner."""
import importlib.util
import math
from pathlib import Path
import sys
import types
import unittest

STAGED=Path(__file__).resolve().parents[1]

def load(name,path):
    spec=importlib.util.spec_from_file_location(name,path)
    module=importlib.util.module_from_spec(spec);sys.modules[name]=module
    spec.loader.exec_module(module);return module

B=load('_clean_benchmark_protocol',STAGED/'tools/benchmark_reconstructed.py')
L=load('_clean_benchmark_lifetime',STAGED/'tools/native_reference/lifetime.py')
C=load('_clean_benchmark_candidate',STAGED/'tools/reconstructed_candidate.py')

class Fake:
    def __init__(self):
        self.log=[];self.graphs=[];self.events=[];self.active=None;self.owner=None
        self.capture_error=False;self.capture_exit_error=False;self.reset_error=False
        self.corrupt_final_timed=False
        self.golden={name:(i*3)%256 for i,name in enumerate(B.BOUNDARIES)}
        self.outputs={role:dict(self.golden) for role in B.ROLES}
        self.torch=types.SimpleNamespace(cuda=types.SimpleNamespace(
            stream=lambda stream:self.StreamContext(self),CUDAGraph=lambda:self.Graph(self),
            Event=lambda **kw:self.Event(self,kw),graph=lambda graph,stream:self.Capture(self,graph)))

    def synchronize(self):
        if self.active is not None:raise AssertionError('synchronize inside capture')
        self.log.append(('sync',))

    class StreamContext:
        def __init__(self,f):self.f=f
        def __enter__(self):self.f.log.append(('stream_enter',));return self
        def __exit__(self,*args):self.f.log.append(('stream_exit',))

    class Graph:
        def __init__(self,f):
            self.f=f;self.role=B.ROLES[len(f.graphs)];self.commands=[];self.replays=0
            f.graphs.append(self);f.log.append(('graph_new',self.role))
        def replay(self):
            self.replays+=1;self.f.log.append(('replay',self.role,self.replays))
            for command in self.commands:
                if command[0]=='call':self.f.outputs[self.role].update(self.f.golden)
            if self.f.corrupt_final_timed and self.role=='candidate' and self.replays==37:
                self.f.outputs[self.role][B.BOUNDARIES[-1]]^=1
        def reset(self):
            self.f.log.append(('reset',self.role))
            if self.f.reset_error and self.role=='candidate':raise RuntimeError('injected reset failure')

    class Event:
        def __init__(self,f,kw):
            if kw!={'enable_timing':True,'external':True}:raise AssertionError('event mode changed')
            self.f=f;self.graph=f.graphs[-1];self.index=len(f.events)%2
            f.events.append(self);f.log.append(('event_new',self.graph.role,self.index))
        def record(self):
            where='capture' if self.f.active is not None else 'prime'
            self.f.log.append(('event_record',self.graph.role,self.index,where))
            if self.f.active is not None:self.f.active.commands.append(('event',self.index))
        def elapsed_time(self,end):
            if self.f.active is not None:raise AssertionError('elapsed read inside capture')
            if end.graph is not self.graph or self.index!=0 or end.index!=1:raise AssertionError('wrong event pair')
            self.f.log.append(('elapsed',self.graph.role,self.graph.replays))
            return 6.0 if self.graph.role=='native' else 3.0

    class Capture:
        def __init__(self,f,graph):self.f=f;self.graph=graph
        def __enter__(self):
            if self.graph not in self.f.owner.graphs:raise AssertionError('capture before ownership')
            self.f.active=self.graph;self.f.log.append(('capture_enter',self.graph.role))
        def __exit__(self,*args):
            self.f.log.append(('capture_exit',self.graph.role));self.f.active=None
            if self.f.capture_exit_error and self.graph.role=='candidate':raise RuntimeError('injected capture exit')

    def call(self,role):
        self.log.append(('call',role,'capture' if self.active is not None else 'eager'))
        if self.active is not None:
            if self.capture_error and role=='candidate':raise ValueError('injected call failure')
            self.active.commands.append(('call',role))
        else:self.outputs[role].update(self.golden)
        return self.outputs[role]

    def poison(self,role,repeat):
        if self.active is not None:raise AssertionError('poison inside capture')
        self.log.append(('poison',role,repeat))
        self.outputs[role].update({k:v^255 for k,v in self.golden.items()})
        if not all(self.outputs[role][k]!=v for k,v in self.golden.items()):raise AssertionError('not every endpoint poisoned')

    def verify(self,role):
        if self.active is not None:raise AssertionError('verify inside capture')
        self.log.append(('verify',role))
        if self.outputs[role]!=self.golden:raise AssertionError('retained boundary bytes differ: '+role)
        return dict(boundaries=len(self.outputs[role]),byte_exact=True)

    def run(self,paired=True):
        self.owner=L.NativeGraphOwner(self.synchronize,label='fake original modules')
        self.owner.retain(self.outputs)
        self.owner.own(object(),lambda:self.log.append(('native_unload',)))
        with self.owner:
            return B.graph_protocol(self.torch,self.owner,self,
                {role:(lambda role=role:self.call(role)) for role in B.ROLES},self.poison,self.verify,paired=paired)

class ProtocolTests(unittest.TestCase):
    def tearDown(self):
        L.QUARANTINED.clear()

    def test_balanced_real_protocol_event_and_owner_order(self):
        f=Fake();result=f.run()
        self.assertEqual(result['timing']['pooled_ms'],{'native':2.0,'candidate':1.0})
        self.assertEqual(len(result['samples']),32)
        measured=[x[1] for x in f.log if x[0]=='elapsed'][2:]
        self.assertEqual(measured,[role for i in range(32) for role in B.ORDERS[i%2]])
        self.assertEqual(len(f.events),4)
        for g in f.graphs:
            self.assertEqual(g.commands,[('event',0)]+[('call',g.role)]*3+[('event',1)])
            self.assertEqual(g.replays,39)
            prime=[i for i,x in enumerate(f.log) if x[:2]==('elapsed',g.role)][0]
            enter=f.log.index(('capture_enter',g.role))
            self.assertLess(prime,enter)
        self.assertEqual(f.log[-3:],[('reset','candidate'),('reset','native'),('native_unload',)])
        self.assertTrue(f.owner.closed);self.assertFalse(f.owner.quarantined)
        self.assertEqual(f.owner.retained,[]);self.assertEqual(f.owner.graphs,[])
        self.assertEqual([len(result['graph_proof'][p]) for p in ('before','after')],[4,4])
        self.assertTrue(all(c['proof']['boundaries']==74 for phase in ('before','after') for c in result['graph_proof'][phase]))
        self.assertEqual(set(result['graph_proof']['last_timed_outputs']),set(B.ROLES))
        self.assertTrue(all(x['boundaries']==74 for x in result['graph_proof']['last_timed_outputs'].values()))

    def test_last_measured_outputs_checked_before_poison(self):
        f=Fake();f.corrupt_final_timed=True
        with self.assertRaisesRegex(AssertionError,'retained boundary bytes differ'):f.run()
        self.assertTrue(f.owner.closed)
        self.assertEqual(len([x for x in f.log if x[0]=='poison']),4)

    def test_numerical_mode_no_timing_samples(self):
        f=Fake();result=f.run(paired=False)
        self.assertEqual(result['samples'],[]);self.assertIsNone(result['timing'])
        self.assertEqual([g.replays for g in f.graphs],[7,7])
        self.assertEqual(len([x for x in f.log if x[0]=='elapsed']),2)
        self.assertEqual(len([x for x in f.log if x[0]=='verify']),8)

    def test_capture_failure_quarantines_all_ownership_without_unload(self):
        f=Fake();f.capture_error=True;f.capture_exit_error=True
        with self.assertRaisesRegex(ValueError,'injected call failure') as caught:f.run()
        self.assertTrue(f.owner.capture_uncertain);self.assertTrue(f.owner.quarantined)
        self.assertFalse(f.owner.closed);self.assertEqual(len(f.owner.graphs),2)
        self.assertTrue(any(x is f.outputs for x in f.owner.retained))
        self.assertFalse(any(x[0] in ('reset','native_unload') for x in f.log))
        self.assertTrue(any('capture exit' in x for x in caught.exception.__notes__))

    def test_successful_capture_exit_failure_is_not_normal_cleanup(self):
        f=Fake();f.capture_exit_error=True
        with self.assertRaisesRegex(RuntimeError,'capture exit'):f.run()
        self.assertTrue(f.owner.quarantined)
        self.assertFalse(any(x[0] in ('reset','native_unload') for x in f.log))

    def test_reset_failure_does_not_unload_or_drop_refs(self):
        f=Fake();f.reset_error=True
        with self.assertRaisesRegex(RuntimeError,'reset failure'):f.run()
        self.assertTrue(f.owner.quarantined);self.assertFalse(f.owner.closed)
        self.assertTrue(f.owner.retained)
        self.assertNotIn(('native_unload',),f.log)

    def test_primary_verification_error_survives_reset_error(self):
        f=Fake();f.corrupt_final_timed=True;f.reset_error=True
        with self.assertRaisesRegex(AssertionError,'retained boundary') as caught:f.run()
        self.assertTrue(any('reset failure' in note for note in caught.exception.__notes__))
        self.assertTrue(f.owner.quarantined);self.assertNotIn(('native_unload',),f.log)

    def test_summarizer_rejects_wrong_order_count_and_invalid_times(self):
        rows=[dict(pair=i,order=list(B.ORDERS[i%2]),ms=dict(native=2.0,candidate=1.0)) for i in range(32)]
        self.assertEqual({x['samples'] for x in B.summarize(rows)['orders'].values()},{16})
        with self.assertRaises(ValueError):B.summarize(rows[:-1])
        for value in (float('nan'),float('inf'),0,-1,True):
            changed=[dict(r,ms=dict(r['ms'])) for r in rows];changed[-1]['ms']['native']=value
            with self.assertRaises(ValueError):B.summarize(changed)
        changed=[dict(r) for r in rows];changed[0]['order']=['candidate','native']
        with self.assertRaises(ValueError):B.summarize(changed)

    def test_exact_roster_and_bounded_candidate_returns(self):
        self.assertEqual(set(B.BOUNDARIES),{f'b{i}.output' for i in range(1,70)}|{f'b{i}.down' for i in (4,8,14,22,30)})
        self.assertEqual(len(B.BOUNDARIES),74)
        outputs={name:object() for name in B.BOUNDARIES}
        plan=types.SimpleNamespace(run_fp8=lambda:list(outputs.values()),boundary_names=lambda:list(outputs),boundaries=lambda:list(outputs.values()))
        c=C.Candidate(plan,object(),[],[])
        retained=c.boundaries()
        for _ in range(1000):c.run()
        self.assertEqual(len(c.retained_outputs),1)
        self.assertEqual(retained,c.boundaries())
        self.assertEqual(c.compare(retained,lambda a,b:a is b)['boundaries'],74)
        bad=dict(retained);bad[B.BOUNDARIES[-1]]=object()
        with self.assertRaises(AssertionError):c.compare(bad,lambda a,b:a is b)
        self.assertNotIn('torch',sys.modules)

if __name__=='__main__':
    unittest.main()
