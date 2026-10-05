"""CPU checks for checkpoint dispatch, not full-network numerical parity.

These tests use the public model class with a lightweight module shell. They
do not load a checkpoint archive, allocate CUDA tensors, or construct 71 blocks.
"""
import inspect
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

import torch
from torch import nn
import torch.utils.checkpoint as checkpoint_module

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from dlssnr.model import DLSSNR


def model_shell(enabled):
    model = DLSSNR.__new__(DLSSNR)
    nn.Module.__init__(model)
    model.checkpoint_blocks = enabled
    return model


class SmallStage(nn.Module):
    def __init__(self, weight):
        super().__init__()
        self.weight = nn.Parameter(torch.tensor(float(weight)))
        self.phases = []

    def forward(self, value, phase, *, scale):
        self.phases.append(phase)
        return (value * self.weight + phase).square() * scale


class TrainingCheckpointCPUTest(unittest.TestCase):
    def test_constructor_defaults_to_eager(self):
        default = inspect.signature(DLSSNR.__init__).parameters["checkpoint_blocks"].default
        self.assertIs(default, False)

    def test_disabled_checkpoint_keeps_ordinary_autograd(self):
        model = model_shell(False)
        stage = SmallStage(2)
        value = torch.tensor(3.0, requires_grad=True)
        with torch.enable_grad(), patch.object(checkpoint_module, "checkpoint") as checkpoint:
            output = model._run_stage(stage, value, 1, scale=2)
            output.backward()
        checkpoint.assert_not_called()
        self.assertEqual(output.item(), 98.0)
        self.assertEqual(value.grad.item(), 56.0)
        self.assertEqual(stage.weight.grad.item(), 84.0)

    def test_no_grad_bypasses_enabled_checkpoint(self):
        model = model_shell(True)
        stage = SmallStage(2)
        value = torch.tensor(3.0)
        with torch.no_grad(), patch.object(checkpoint_module, "checkpoint") as checkpoint:
            output = model._run_stage(stage, value, 1, scale=2)
        checkpoint.assert_not_called()
        self.assertFalse(output.requires_grad)
        self.assertIsNone(stage.weight.grad)
        self.assertEqual(output.item(), 98.0)

    def test_nonreentrant_checkpoint_retains_each_module_and_phase(self):
        model = model_shell(True)
        stages = [SmallStage(i) for i in (1, 2, 3)]
        value = torch.tensor(2.0)  # Parameter gradients must work without input gradients.
        original = checkpoint_module.checkpoint
        with torch.enable_grad(), patch.object(checkpoint_module, "checkpoint", wraps=original) as checkpoint:
            outputs = [model._run_stage(stage, value, phase, scale=2)
                       for stage, phase in zip(stages, (1, 2, 3))]
            sum(outputs).backward()
        self.assertEqual(checkpoint.call_count, 3)
        for index, (stage, call) in enumerate(zip(stages, checkpoint.call_args_list), start=1):
            self.assertIs(call.args[0], stage)
            self.assertIs(call.args[1], value)
            self.assertEqual(call.args[2], index)
            self.assertIs(call.kwargs["use_reentrant"], False)
            self.assertEqual(call.kwargs["scale"], 2)
            self.assertEqual(outputs[index - 1].item(), 18.0 * index * index)
            self.assertEqual(stage.weight.grad.item(), 24.0 * index)
            self.assertGreaterEqual(len(stage.phases), 2)  # Forward plus actual backward recomputation.
            self.assertEqual(set(stage.phases), {index})
        self.assertIsNone(value.grad)

    def test_bound_method_and_keyword_phase_are_forwarded(self):
        model = model_shell(True)
        stage = SmallStage(2)
        function = stage.forward
        value = torch.tensor(3.0)
        original = checkpoint_module.checkpoint
        with torch.enable_grad(), patch.object(checkpoint_module, "checkpoint", wraps=original) as checkpoint:
            output = model._run_stage(function, value, phase=1, scale=2)
            output.backward()
        call = checkpoint.call_args
        self.assertIs(call.args[0], function)
        self.assertIs(call.args[1], value)
        self.assertEqual(call.kwargs, {"use_reentrant": False, "phase": 1, "scale": 2})
        self.assertEqual(stage.weight.grad.item(), 84.0)
        self.assertGreaterEqual(len(stage.phases), 2)
        self.assertEqual(set(stage.phases), {1})


if __name__ == "__main__":
    unittest.main()
