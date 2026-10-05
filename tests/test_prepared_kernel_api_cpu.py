"""CPU checks for compiler-visible mutations and generated tensor dependencies.

The fixture implements tiny CPU operators with the exact public schema. GPU
numerical agreement is validated separately against the linked CUDA extension.
"""
import json
import re
from pathlib import Path
import sys
import types
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
import torch
from dlssnr import deployment

LIBRARY = torch.library.Library('dlssnr_composition_test', 'DEF')
for name in ('copy', 'accumulate'):
    LIBRARY.define(f'{name}(Tensor[] inputs, Tensor(a!)[] outputs, int handle) -> ()')


@torch.library.impl(LIBRARY, 'copy', 'CPU')
def copy(inputs, outputs, handle):
    outputs[0].copy_(inputs[0] * handle)


@torch.library.impl(LIBRARY, 'accumulate', 'CPU')
def accumulate(inputs, outputs, handle):
    outputs[0].add_(inputs[0] + handle)


@torch.library.impl(LIBRARY, 'copy', 'Meta')
@torch.library.impl(LIBRARY, 'accumulate', 'Meta')
def meta(inputs, outputs, handle):
    if len(inputs) != 1 or len(outputs) != 1:
        raise ValueError('fixture requires one input and one mutable tensor')
    if inputs[0].numel() != 2 or outputs[0].numel() != 2:
        raise ValueError('fixture prepared extent is fixed at two elements')


class Owner:
    def __init__(self, name, handle, inputs, outputs):
        self._name, self._handle = name, handle
        self._inputs, self._outputs = inputs, outputs

    def name(self): return self._name
    def id(self): return self._handle
    def inputs(self): return self._inputs
    def outputs(self): return self._outputs


class Plan:
    def __init__(self):
        self.tensors = (torch.tensor([2., 3.]), torch.zeros(2), torch.ones(2))

    def prepare_kernels(self):
        first, scratch, output = self.tensors
        return [Owner('copy', 2, [first], [scratch]),
                Owner('accumulate', 3, [scratch], [output])]

    def tensor_arguments(self): return self.tensors
    def kernel_tensor_indices(self): return [[0], [1], [1], [2]]
    def buffer_names(self): return ['input', 'scratch', 'output']


class Tests(unittest.TestCase):
    def api(self):
        # CPU fixtures only: mimic ownership setup, never claim CUDA validation.
        class CppChain:
            def __init__(self, owners): self.owners = owners
            def run(self):
                for owner in self.owners:
                    getattr(torch.ops.dlssnr_composition_test, owner.name())(
                        owner.inputs(), owner.outputs(), owner.id())
                return self.owners[-1].outputs()
        return types.SimpleNamespace(copy=torch.ops.dlssnr_composition_test.copy,
                                     accumulate=torch.ops.dlssnr_composition_test.accumulate,
                                     create_kernel_sequence=CppChain)

    def sequence(self):
        with patch.object(deployment, 'load_extension', return_value=self.api()):
            return deployment.prepare_kernels(Plan())

    def test_arbitrary_prepared_composition_shares_tensor_edges(self):
        sequence = self.sequence()
        with patch.object(deployment, 'load_extension', return_value=self.api()):
            composed = deployment.compose_kernels(sequence.kernels)
        self.assertEqual(len(composed.tensors), 3)
        expected = torch.tensor([8., 10.])
        compiled = torch.compile(composed, backend='aot_eager', fullgraph=True)
        self.assertTrue(torch.equal(compiled(*composed.tensors), expected))

    def test_fullgraph_eager_and_aot_preserve_mutations_and_rebind(self):
        for backend in ('eager', 'aot_eager'):
            with self.subTest(backend=backend):
                sequence = self.sequence()
                compiled = torch.compile(sequence, backend=backend, fullgraph=True)
                # Pass different storage from the tensors retained by the owners.
                tensors = (torch.tensor([4., 5.]), torch.zeros(2), torch.ones(2))
                self.assertTrue(torch.equal(compiled(*tensors), torch.tensor([12., 14.])))
                self.assertTrue(torch.equal(tensors[1], torch.tensor([8., 10.])))
                self.assertTrue(torch.equal(sequence.tensors[2], torch.ones(2)))
                self.assertTrue(torch.equal(compiled(*tensors), torch.tensor([23., 27.])))

    def test_graph_has_two_named_ops_with_tensor_edges(self):
        sequence = self.sequence()
        graphs = []

        def backend(graph, examples):
            graphs.append(graph)
            return graph.forward

        torch.compile(sequence, backend=backend, fullgraph=True)(*sequence.tensors)
        calls = [node for node in graphs[0].graph.nodes if node.op == 'call_function']
        self.assertEqual([str(node.target) for node in calls],
                         ['dlssnr_composition_test.copy.default',
                          'dlssnr_composition_test.accumulate.default'])
        self.assertIs(calls[0].args[1][0], calls[1].args[0][0])

    def test_individual_call_accepts_explicit_tensor_dependencies(self):
        kernel = self.sequence().kernels[0]
        output = torch.empty(2)
        compiled = torch.compile(kernel, backend='aot_eager', fullgraph=True)
        compiled([torch.tensor([7., 8.])], [output])
        self.assertTrue(torch.equal(output, torch.tensor([14., 16.])))

    def test_symbolic_trace_keeps_prepared_extent_guard(self):
        kernel = self.sequence().kernels[0]
        compiled = torch.compile(kernel, backend='aot_eager', fullgraph=True, dynamic=True)
        output = torch.empty(2)
        compiled([torch.tensor([1., 3.])], [output])
        self.assertTrue(torch.equal(output, torch.tensor([2., 6.])))
        with self.assertRaisesRegex(Exception, 'prepared extent is fixed'):
            compiled([torch.ones(3)], [torch.empty(3)])

    def test_generated_catalog_and_mutation_roles(self):
        canonical = json.loads((ROOT / 'tuning/canonical_kernel_names.json').read_text(encoding='utf-8'))
        catalog = (ROOT / 'csrc/kernel_launcher/prepared_kernel_names_generated.inl').read_text(encoding='utf-8')
        self.assertEqual(len(re.findall(r'"[a-z][a-z0-9_]*"', catalog)), 81)
        for entry in canonical.values(): self.assertIn(f'"{entry}"', catalog)
        union = set()
        for suffix in ('', '_fp16'):
            plan = json.loads((ROOT / f'tuning/plan{suffix}_1280_720.json').read_text(encoding='utf-8'))
            self.assertEqual(len(plan['calls']), 185)
            for call in plan['calls']:
                union.add(call['fn'])
                pointers = {offset: value for offset, size, value in call['fields'] if size == 8}
                self.assertEqual(len(pointers.values()), len(set(pointers.values())))
                self.assertTrue(call['mutable_offsets'])
                for offset in call['mutable_offsets']:
                    self.assertTrue(pointers[offset].startswith('address('))
                if call['fn'] == 'completion_counter_clear':
                    self.assertEqual(call['mutable_offsets'], [0])
                else:
                    self.assertNotIn(0, call['mutable_offsets'])
        self.assertEqual(len(union), 73)


if __name__ == '__main__':
    unittest.main()
