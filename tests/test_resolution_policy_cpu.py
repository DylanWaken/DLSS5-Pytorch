"""Offline policy and geometry tests. No Torch, CUDA, compiler or old policies."""
import copy
import hashlib
import json
import re
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

STAGED=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(STAGED))
from tuning import resolution_policy as P
from tuning import resolution_cli as C

def empty():
    return json.loads((STAGED/'tuning/resolution_policy.json').read_text())

def anchor(width=1280,height=720,config=2,**kwargs):
    return dict(sm=120,precision='fp8',width=width,height=height,config_id=config,
                configuration_sha256=str(config%10)*64,interval='resident whole trunk; retained outputs',
                binary_sha256='a'*64,source_sha256='b'*64,median_ns=1000000,samples=16,
                verified=True,receipt='measure.json',receipt_sha256='c'*64,**kwargs)

def seal(root,row,kind='resolution_measurement',name='measure.json'):
    row=copy.deepcopy(row);row['receipt']=name
    content=dict(schema_version=1,kind=kind,record={k:v for k,v in row.items() if k not in ('receipt','receipt_sha256')})
    data=(json.dumps(content,sort_keys=True)+'\n').encode()
    (root/name).write_bytes(data);row['receipt_sha256']=hashlib.sha256(data).hexdigest()
    return row

class PolicyTests(unittest.TestCase):
    def test_empty_keeps_actual_shape_and_does_not_admit(self):
        result=P.lookup(empty(),1000,3000,120,'fp8')
        self.assertEqual((result['actual_width'],result['actual_height']),(1000,3000))
        self.assertEqual((result['query_width'],result['query_height']),(1280,2160))
        self.assertEqual((result['config_id'],result['status']),(-1,'unmeasured'))
        self.assertFalse(result['actual_shape_supported']);self.assertFalse(result['runtime_qualified'])
        self.assertIsNone(result['anchor'])

    def test_normalized_distance_and_ties(self):
        p=empty();p['anchors']=[anchor(2560,1440,4),anchor(1280,720,2)]
        self.assertEqual(P.lookup(p,1920,1080,120,'fp8')['config_id'],2)
        p['anchors']=[anchor(1280,1440,2),anchor(1920,720,4)]
        # Width is normalized by 2560 and height by 1440, not raw pixel distance.
        self.assertEqual(P.lookup(p,1280,720,120,'fp8')['config_id'],4)
        p['anchors']=[anchor(1920,1440,4),anchor(1920,720,2)]
        self.assertEqual(P.lookup(p,1920,1080,120,'fp8')['config_id'],2)

    def test_transfer_is_neither_measurement_nor_admission(self):
        p=empty();p['anchors']=[anchor(3840,2160)]
        r=P.lookup(p,9999,9999,120,'fp8')
        self.assertEqual(r['status'],'transferred');self.assertTrue(r['clamped'])
        self.assertFalse(r['actual_resolution_measured']);self.assertFalse(r['actual_shape_supported'])
        self.assertEqual(P.lookup(p,3840,2160,120,'fp8')['status'],'exact_measured')
        self.assertEqual(P.lookup(p,3840,2160,121,'fp8')['config_id'],-1)
        self.assertEqual(P.lookup(p,3840,2160,120,'fp16')['config_id'],-1)

    def test_exact_admission_separate_from_runtime_qualification(self):
        p=empty();p['admissions']=[dict(sm=120,precision='fp8',width=3840,height=2160,
                                      state='implementation_admitted',receipt='admission.json',receipt_sha256='d'*64)]
        r=P.lookup(p,3840,2160,120,'fp8')
        self.assertTrue(r['actual_shape_supported']);self.assertFalse(r['runtime_qualified'])
        self.assertEqual(r['status'],'unmeasured')
        self.assertFalse(P.lookup(p,3841,2160,120,'fp8')['actual_shape_supported'])
        p['admissions'][0]['state']='runtime_qualified'
        self.assertTrue(P.lookup(p,3840,2160,120,'fp8')['runtime_qualified'])

    def test_invalid_measurements_and_mixed_context_rejected(self):
        for field,value in [('median_ns',float('nan')),('median_ns',0),('samples',True),('verified',False),
                            ('config_id',-1),('width',1279),('receipt','../x.json'),('interval','bad\x00scope')]:
            with self.subTest(field=field,value=value):
                p=empty();a=anchor();a[field]=value;p['anchors']=[a]
                with self.assertRaises(ValueError):P.validate(p)
        for field,value in [('interval','different scope'),('binary_sha256','d'*64),('source_sha256','e'*64)]:
            p=empty();a=anchor(1920,1080,4);a[field]=value;p['anchors']=[anchor(),a]
            with self.assertRaises(ValueError):P.validate(p)
        p=empty();p['anchors']=[anchor(),anchor()]
        with self.assertRaises(ValueError):P.validate(p)
        p['anchors']=[anchor(),anchor(1920,1080,2)];p['anchors'][1]['configuration_sha256']='f'*64
        with self.assertRaises(ValueError):P.validate(p)

    def test_receipt_byte_and_record_identity(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);p=empty();p['anchors']=[seal(root,anchor())]
            P.verify_receipts(p,root)
            p['anchors'][0]['median_ns']+=1
            with self.assertRaises(ValueError):P.verify_receipts(p,root)
            p['anchors'][0]['median_ns']-=1
            (root/'measure.json').write_text('{}')
            with self.assertRaises(ValueError):P.verify_receipts(p,root)

    def test_codegen_has_real_selection_and_stable_empty_array(self):
        h=re.sub(r'\s+','',P.cpp_header(empty()))
        self.assertIn('std::array<FAnchor,0>',h);self.assertIn('std::array<FAdmission,0>',h)
        self.assertIn('intConfigId=-1',h);self.assertIn('bActualShapeSupported=false',h)
        self.assertIn('EvidenceRow.Width==Width&&EvidenceRow.Height==Height',h)
        self.assertIn('WidthDelta*WidthDelta*1440LL*1440LL+HeightDelta*HeightDelta*2560LL*2560LL',h)
        p=empty();p['anchors']=[anchor(2560,1440,4),anchor(1280,720,2)]
        first=P.cpp_header(p);p['anchors'].reverse()
        self.assertEqual(first,P.cpp_header(p))
        self.assertIn('std::array<FAnchor,2>',re.sub(r'\s+','',first))
        self.assertLess(first.index('{120,0,1280,720,2'),first.index('{120,0,2560,1440,4'))

    def test_invalid_lookup(self):
        for width,height in [(0,720),(1280,-1),(True,720),(1<<40,720)]:
            with self.assertRaises(ValueError):P.lookup(empty(),width,height,120,'fp8')

    def test_per_device_files_and_cross_device_rejection(self):
        p=empty();p['device_sm']=120
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);C.write(root/'sm_120.json',p)
            result,paths=C.policy_files([root/'sm_120.json'])
            self.assertEqual(result['anchors'],[])
            self.assertEqual(P.lookup(result,3840,2160,121,'fp8')['config_id'],-1)
            C.write(root/'sm_121.json',p)
            with self.assertRaises(ValueError):C.policy_files([root/'sm_121.json'])
            p['anchors']=[anchor()];p['device_sm']=121
            with self.assertRaises(ValueError):P.validate(p)
        with self.assertRaises(ValueError):P.combine([dict(empty(),device_sm=120)]*2)

    def test_root_entrypoint_is_cpu_planning_only(self):
        r=subprocess.run([sys.executable,'-B',str(STAGED/'run_tuning.py'),'lookup','--width','1280','--height','720','--sm','120','--precision','fp8'],capture_output=True,text=True)
        self.assertEqual(r.returncode,0,r.stderr)
        self.assertEqual(json.loads(r.stdout)['status'],'unmeasured')

class GeometryAndCliTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.plan=C.enumerate_plan(120,'fp8')

    def test_exact_continuous_geometry_domain(self):
        p=self.plan
        self.assertEqual(p['integer_resolution_count'],3690401)
        self.assertEqual(p['physical_geometry_count'],931)
        G=C.load_geometry()
        self.assertEqual(G.Geometry.from_valid(3840,2160).levels,((1920,1088),(960,544),(480,272),(240,136),(120,68),(60,36)))
        for region in p['regions']:
            row=p['cases'][region['geometry_id']]
            for width in region['width']:
                for height in region['height']:
                    g=G.Geometry.from_valid(width,height)
                    self.assertEqual((g.full_width,g.full_height,g.levels),(row['full_width'],row['full_height'],row['levels']))
        self.assertNotIn('torch',sys.modules)

    def test_resume_requires_exact_evidence_and_plan(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);case=self.plan['cases'][0]
            row=seal(root,anchor(case['valid_width'],case['valid_height']))
            r=C.resume_plan(self.plan,[row],root)
            self.assertEqual(r['completed_geometry_ids'],[0]);self.assertEqual(len(r['pending_geometry_ids']),930)
            self.assertFalse(r['runtime_qualified'])
            changed=copy.deepcopy(self.plan);changed['cases'][0]['full_width']+=1
            with self.assertRaises(ValueError):C.resume_plan(changed,[row],root)
            row['receipt_sha256']='0'*64
            with self.assertRaises(ValueError):C.resume_plan(self.plan,[row],root)

    def test_fresh_cli_lookup_codegen_enumerate_resume(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)
            def cli(*args):
                r=subprocess.run([sys.executable,'-B',str(STAGED/'tuning/resolution_cli.py'),*map(str,args)],capture_output=True,text=True)
                self.assertEqual(r.returncode,0,r.stderr);return json.loads(r.stdout)
            self.assertEqual(cli('lookup','--width',3840,'--height',2160,'--sm',120,'--precision','fp8')['config_id'],-1)
            cli('codegen','--output',root/'policy.h')
            self.assertEqual((root/'policy.h').read_text(),P.cpp_header(empty()))
            cli('enumerate','--sm',120,'--precision','fp8','--output',root/'plan.json')
            (root/'done.json').write_text('[]')
            result=cli('resume-plan','--plan',root/'plan.json','--completed',root/'done.json','--evidence-root',root,'--output',root/'resume.json')
            self.assertEqual(len(result['pending_geometry_ids']),931)

if __name__=='__main__':
    unittest.main()
