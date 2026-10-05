"""Synthetic metadata-only extrema tests; no Torch, CUDA or compiler."""
import hashlib
import importlib.util
import re
from pathlib import Path
import sys
import unittest

STAGED = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('_resolution_extrema', STAGED / 'tuning/resolution_policy.py')
P = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = P
spec.loader.exec_module(P)

def empty():
    return dict(schema_version=1,bounds=dict(P.BOUNDS),distance=P.DISTANCE,
                unmeasured_config_id=-1,anchors=[],admissions=[])

def row(w,h,config=1,sm=120,precision='fp8'):
    return dict(sm=sm,precision=precision,width=w,height=h,config_id=config,
        configuration_sha256=str(config % 10)*64,interval='synthetic same-interval fixture',
        binary_sha256='a'*64,source_sha256='b'*64,median_ns=100,samples=16,
        verified=True,receipt='synthetic.json',receipt_sha256='c'*64)

class ExtremaTests(unittest.TestCase):
    def test_subset_extrema_changes_selection_without_changing_actual_shape(self):
        p=empty();p['anchors']=[row(1280,1440,1),row(1920,720,2)]
        r=P.lookup(p,3840,1440,120,'fp8')
        self.assertEqual((r['query_width'],r['query_height']),(1920,1440))
        self.assertEqual((r['actual_width'],r['actual_height']),(3840,1440))
        self.assertEqual((r['config_id'],r['status']),(1,'transferred'))
        # Original fixed-domain-only distance selected the other anchor.
        old=min(p['anchors'],key=lambda a:(3840-a['width'])**2*1440**2+(1440-a['height'])**2*2560**2)
        self.assertEqual(old['config_id'],2)
        self.assertFalse(r['actual_resolution_measured'])
        self.assertFalse(r['actual_shape_supported'])

    def test_clamps_each_dimension_to_matching_family_only(self):
        p=empty();p['anchors']=[row(1920,1080,1),row(2560,1440,2),
            row(1280,720,3,121),row(3840,2160,4,121),
            row(1280,720,5,120,'fp16'),row(3840,2160,6,120,'fp16')]
        for actual,query in [((1280,2160),(1920,1440)),((3840,720),(2560,1080)),
                             ((1,9999),(1920,1440)),((2200,1200),(2200,1200))]:
            with self.subTest(actual=actual):
                r=P.lookup(p,*actual,120,'fp8')
                self.assertEqual((r['query_width'],r['query_height']),query)
                self.assertEqual((r['actual_width'],r['actual_height']),actual)
        self.assertEqual(P.lookup(p,3840,2160,121,'fp8')['config_id'],4)
        self.assertEqual(P.lookup(p,3840,2160,120,'fp16')['config_id'],6)

    def test_empty_family_and_actual_only_admission(self):
        p=empty();p['anchors']=[row(1920,1080)]
        p['admissions']=[dict(sm=120,precision='fp8',width=1920,height=1080,
            state='runtime_qualified',receipt='admission.json',receipt_sha256='d'*64)]
        r=P.lookup(p,3840,2160,120,'fp8')
        self.assertEqual((r['query_width'],r['query_height']),(1920,1080))
        self.assertFalse(r['actual_shape_supported']);self.assertFalse(r['runtime_qualified'])
        self.assertTrue(P.lookup(p,1920,1080,120,'fp8')['runtime_qualified'])
        for sm,precision in ((121,'fp8'),(120,'fp16')):
            r=P.lookup(p,1,9999,sm,precision)
            self.assertEqual((r['query_width'],r['query_height']),(1280,2160))
            self.assertEqual((r['config_id'],r['status']),(-1,'unmeasured'))
            self.assertFalse(r['actual_shape_supported'])

    def test_normalized_distance_and_lower_ties_are_unchanged(self):
        p=empty();p['anchors']=[row(2560,1440,2),row(1280,720,1)]
        r=P.lookup(p,1920,1080,120,'fp8')
        self.assertEqual(r['config_id'],1)
        self.assertFalse(r['clamped'])
        p['anchors']=[row(1280,1440,1),row(1920,720,2)]
        self.assertEqual(P.lookup(p,1280,720,120,'fp8')['config_id'],2)
        p['anchors']=[row(1920,1440,2),row(1920,720,1)]
        self.assertEqual(P.lookup(p,1920,1080,120,'fp8')['config_id'],1)

    def test_codegen_empty_policy_and_semantic_version(self):
        p=empty();header=P.cpp_header(p)
        saved=(STAGED/'csrc/kernel_launcher/compiled_resolution_policy.h').read_text()
        cpp_tokens=lambda text: re.findall(r'"(?:\\.|[^"\\])*"|[A-Za-z_]\w*|\d+|[^\s]',text)
        self.assertEqual(cpp_tokens(header),cpp_tokens(saved))
        compact=re.sub(r'\s+','',header)
        self.assertIn('std::array<FResolutionAnchor,0>',compact)
        self.assertIn('std::array<FResolutionAdmission,0>',compact)
        self.assertIn(P.RESOLVER_VERSION,header)
        self.assertIn('if(EvidenceRow.Sm!=Sm||EvidenceRow.PrecisionValue!=PrecisionIndex)continue;',compact)
        self.assertLess(compact.index('if(bMeasuredFamily)'),compact.index('constint64_tWidthDelta='))
        self.assertIn('EvidenceRow.Width==Width&&EvidenceRow.Height==Height',compact)
        old=hashlib.sha256(P.canonical(P.validate(p)).encode()).hexdigest()
        self.assertNotEqual(P.version(p),old)
        self.assertNotIn('torch',sys.modules)

if __name__=='__main__':
    unittest.main()
