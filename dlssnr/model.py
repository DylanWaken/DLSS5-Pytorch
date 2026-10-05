"""Differentiable 71-block DLSS-NR training graph using pure PyTorch.

FP32/BF16 training preserves the floating graph and surrogate attention used
by the research model. It is not a native-bit or deployment performance oracle.
Reconstructed CUDA deployment has a separate explicit API.

Graph/layout adaptation: OpenDLSS-NR, Copyright (c) 2026 maan, MIT;
see third_party/OpenDLSS-NR/LICENSE and NOTICE.
"""
import math
from pathlib import Path

import torch
from torch import nn
from torch.nn import functional as F

from .geometry import Geometry, align_up, block_channels, graph_schedule, window_shift
from .weights import WeightArchive, tiled_token

def _windows(x: torch.Tensor, sx: int, sy: int) -> torch.Tensor:
    b, h, w, heads, d = x.shape
    ph, pw = align_up(h + sy, 8), align_up(w + sx, 8)
    flat = x.reshape(b, h, w, heads * d)
    padded = F.pad(flat, (0, 0, sx, pw - w - sx, sy, ph - h - sy))
    return padded.reshape(b, ph // 8, 8, pw // 8, 8, heads, d).permute(0, 1, 3, 5, 2, 4, 6).reshape(b, ph // 8, pw // 8, heads, 64, d)

def _unwindows(x: torch.Tensor, height: int, width: int, sx: int, sy: int) -> torch.Tensor:
    b, ny, nx, heads, _, d = x.shape
    return x.reshape(b, ny, nx, heads, 8, 8, d).permute(0, 1, 4, 2, 5, 3, 6).reshape(b, ny * 8, nx * 8, heads * d)[:, sy:sy + height, sx:sx + width].contiguous()


class Numerics:
    """Pure Torch floating training arithmetic with FP32 reductions."""
    def __init__(self, precision="fp32"):
        if precision not in ("fp32", "bf16"):
            raise ValueError("training precision must be fp32 or bf16; use the reconstructed deployment API for inference")
        self.precision = precision
        self.training_forward = True
        self.working_dtype = torch.bfloat16 if precision == "bf16" else torch.float32

    def round(self, x):
        return x.to(self.working_dtype)

    def reduction_round(self, x):
        return x.float()

    def reciprocal(self, x):
        return x.float().reciprocal()

    def publish(self, x):
        return self.round(x)

    def silu(self, x):
        value = x.float()
        bounded = value.clamp(-4, 4)
        inner = -0.055908203125 * bounded.abs() + 0.447265625
        return (value * (bounded * inner + 0.89453125)).to(x.dtype)

    def activate(self, x):
        return self.publish(self.silu(x))

    def linear_activate(self, x, weight):
        return self.activate(self.linear(x, weight))

    def norm(self, x):
        value = x.float()
        return (value / torch.linalg.vector_norm(value, dim=-1, keepdim=True).clamp_min(1e-12)).to(x.dtype)

    def exp(self, x, global_mode=False):
        a, b, lo, hi, shift, exp_zero = ((0.08953857421875, 1.708984375, 1.439453125, 1.9775390625, 16, 0.083984375)
                                      if global_mode else (0.044921875, 1.30078125, 1.03125, 1.5693359375, 32, 0.025390625))
        affine = (x.float() * a + b).clamp(lo, hi)
        return exp_zero * torch.exp((affine - b) * (shift * math.log(2)))

    def sum64(self, x):
        if x.shape[-1] != 64:
            raise ValueError("sum64 requires exactly 64 keys")
        return x.float().sum(-1, keepdim=True)

    def residual(self, x, skip, scale):
        return (x.float() + skip.float() * scale.float()).to(x.dtype)

    def linear(self, x, weight, residual=None, scale=None, partition=0, *, f16_weights=False):
        """[N,K] weights; floating GEMM. Packed-kernel partition hints are ignored."""
        with torch.autocast(device_type=x.device.type, enabled=False):
            raw = F.linear(x.to(self.working_dtype), weight.to(self.working_dtype))
        return self.residual(raw, residual, scale) if residual is not None else raw

    def matmul(self, x, weight, seed=None):
        with torch.autocast(device_type=x.device.type, enabled=False):
            result = x.to(self.working_dtype) @ weight.to(self.working_dtype).transpose(-1, -2)
        return result if seed is None else (result.float() + seed.float()).to(self.working_dtype)

    def pool(self, x, target):
        width, height = target
        b, h, w, c = x.shape
        pooled = x.float().reshape(b, h // 2, 2, w // 2, 2, c).mean((2, 4)).to(x.dtype)
        pooled = F.pad(pooled, (0, 0, 0, width - pooled.shape[2], 0, height - pooled.shape[1]))
        return self.publish(pooled)

    def upsample(self, x, target):
        width, height = target
        up = x.repeat_interleave(2, 1).repeat_interleave(2, 2)
        return up[:, :height, :width].contiguous()

    def upsample_residual(self, x, skip, scale, target, input_scale=None):
        value = self.upsample(x, target)
        if input_scale is not None:
            value = self.round(value * self.round(input_scale))
        return self.residual(value, skip, scale)


class NRBlock(nn.Module):
    """One real graph block (39 carries only the bottleneck up-projection)."""
    def __init__(self, index: int, tensors: dict[str, torch.Tensor], numerics: Numerics, *, trainable=False):
        super().__init__()
        self.index, self.channels, self.numerics = index, block_channels(index), numerics
        matrix_keys = {"w1", "w2", "w3", "w4", "qkv", "projection", "input_adapter", "head", "up_projection", "down_projection"}
        for name, tensor in tensors.items():
            value = tensor.transpose(-1, -2).contiguous() if name in matrix_keys else tensor.contiguous()
            if trainable:
                self.register_parameter(name, nn.Parameter(value))
            else:
                self.register_buffer(name, value)
        order = sorted(range(64), key=tiled_token)
        self.register_buffer("physical_key_order", torch.tensor(order, dtype=torch.long), persistent=False)

    def attend(self, qkv, phase):
        n, c = self.numerics, self.channels
        q, k, v = qkv.reshape(*qkv.shape[:-1], c // 32, 3, 32).unbind(-2)
        q, k = n.norm(q), n.norm(k)
        if c == 1024:
            q = n.round(q * math.sqrt(32))
        q = n.publish(n.round(q * n.round(self.head_scale).unsqueeze(-1)))
        k, v = n.publish(k), n.publish(v)
        if c == 1024:
            b, h, w, heads, _ = q.shape
            tokens, padded = h * w, align_up(h * w, 64)
            q = q.reshape(b, tokens, heads, 32).transpose(1, 2)
            k = F.pad(k.reshape(b, tokens, heads, 32).transpose(1, 2), (0, 0, 0, padded - tokens))
            v = F.pad(v.reshape(b, tokens, heads, 32).transpose(1, 2), (0, 0, 0, padded - tokens))
            scores = n.matmul(q, k)
            exponentials = n.exp(scores, True)
            total = torch.zeros_like(exponentials[..., :1])
            for start in range(0, padded, 64):
                total = n.reduction_round(total + n.sum64(exponentials[..., start:start + 64]))
            if padded != tokens:
                correction = n.reduction_round(n.exp(torch.zeros_like(total), True) * (padded - tokens))
                total = n.reduction_round(total - correction)
            output = n.matmul(n.publish(exponentials), v.transpose(-1, -2))
            output = n.publish(n.round(output * n.reciprocal(total)))
            return output.transpose(1, 2).reshape(b, h, w, c)
        sx, sy = window_shift(phase)
        qw, kw, vw = _windows(q, sx, sy), _windows(k, sx, sy), _windows(v, sx, sy)
        kw, vw = kw.index_select(-2, self.physical_key_order), vw.index_select(-2, self.physical_key_order)
        scores = n.matmul(qw, kw, self.bias)
        e = n.exp(scores)
        p = n.publish(n.round(e * n.reciprocal(n.sum64(e))))
        attended = n.publish(n.matmul(p, vw.transpose(-1, -2)))
        return _unwindows(attended, qkv.shape[1], qkv.shape[2], sx, sy)

    def forward(self, state, phase=0, *, skip_override=None):
        if self.index == 39:
            raise ValueError("block 39 is a transition; use DLSSNR.forward")
        n, c = self.numerics, self.channels
        residual = state if skip_override is None else skip_override
        if c in (32, 1024):
            hidden = n.linear_activate(state, self.w1)
            raw = n.linear(hidden, self.w2, residual, self.ffn_scale, 1024 if c == 1024 else 0)
        elif c <= 256:
            paths = []
            for expert in range(c // 32):
                hidden = n.linear_activate(state, self.w1[expert])
                paths.append(n.publish(n.linear(hidden, self.w2[expert])))
            raw = n.linear(torch.cat(paths, -1), self.w3, residual, self.ffn_scale)
        else:
            branches = n.publish(n.linear(state, self.w1)).split(64, dim=-1)
            paths = []
            for branch in range(8):
                hidden = n.linear_activate(branches[branch], self.w2[branch])
                paths.append(n.publish(n.linear(hidden, self.w3[branch])))
            raw = n.linear(torch.cat(paths, -1), self.w4, residual, self.ffn_scale)
        ffn = n.publish(raw)
        qkv = n.linear(ffn, self.qkv, partition=512 if c == 1024 else 0)
        attended = self.attend(qkv, phase)
        raw_out = n.linear(attended, self.projection, raw if c == 32 else ffn,
                           self.attn_scale, 256 if c == 1024 else 0)
        return n.publish(raw_out), raw_out


class DLSSNR(nn.Module):
    """Pure Torch 71-block network for FP32 or BF16 training.

    Inputs are padded BHWC features with16 lanes. Parameters stay FP32 by
    default; BF16 selects matrix working precision with FP32 reductions.
    ``trainable=True`` registers checkpoint tensors as Parameters; otherwise
    they remain buffers. Input features and upstream renderer preparation are
    supplied by the caller. This class never loads or dispatches a CUDA extension.
    """
    def __init__(self, archive: WeightArchive, *, precision="fp32", trainable=False, checkpoint_blocks=False):
        super().__init__()
        if not isinstance(checkpoint_blocks, bool):
            raise TypeError("checkpoint_blocks must be a bool")
        archive.validate_complete()
        self.numerics = Numerics(precision)
        self.precision = precision
        self.checkpoint_blocks = checkpoint_blocks
        self.blocks = nn.ModuleList(NRBlock(i, archive.decode_block(i), self.numerics, trainable=trainable) for i in range(71))

    @classmethod
    def from_directory(cls, directory: str | Path, *, device=None, dtype=torch.float32, verify_hashes=True, **kwargs):
        if dtype not in (torch.float32, torch.bfloat16):
            raise ValueError("training storage must be float32 or bfloat16; FP32 master weights are recommended")
        model = cls(WeightArchive(directory, verify_hashes=verify_hashes), **kwargs)
        return model.to(device=device, dtype=dtype)

    def forward_train(self, features, **kwargs):
        """Floating training entry point with ordinary autograd."""
        return self.forward(features, **kwargs)

    def _run_stage(self, function, *args, **kwargs):
        """Optionally recompute one bound stage during backward to save activations.

        Pass the selected module/bound method and all phase/geometry arguments
        directly. A closure over a loop variable would replay the wrong block.
        Non-reentrant checkpointing also supports parameter gradients when the
        supplied input features do not require gradients.
        """
        if self.checkpoint_blocks and torch.is_grad_enabled():
            from torch.utils.checkpoint import checkpoint
            return checkpoint(function, *args, use_reentrant=False, **kwargs)
        return function(*args, **kwargs)

    def _post_head(self, state, adapter, geometry, phase, *, return_boundary=False):
        """Compute the final training head from the decoder state and input skip."""
        n, post = self.numerics, self.blocks[70]
        raw_merge = n.upsample_residual(state, adapter, n.round(post.adapter_scale),
                                       (geometry.full_width, geometry.full_height), post.input_scale)
        published, raw = post(n.publish(raw_merge), phase, skip_override=raw_merge)
        head = n.linear(raw, post.head, f16_weights=True).float()
        return head, published if return_boundary else None

    def _encoder_stage(self, state, index, phase, target):
        """Keep high publication and pool the raw encoder tail before projection."""
        n, transition = self.numerics, self.blocks[index]
        published, raw = transition(state, phase, skip_override=None)
        return published, n.publish(n.linear(n.pool(raw, target), transition.down_projection))

    def _decoder_stage(self, state, skip, index, phase, target):
        """Project, merge and execute the first decoder block without changing boundaries."""
        n, transition = self.numerics, self.blocks[index]
        projected = n.linear(state, transition.up_projection)
        raw_merge = n.upsample_residual(projected, skip, n.round(transition.transition_scale), target)
        return transition(n.publish(raw_merge), phase,
                          skip_override=raw_merge if index == 66 else None)

    def _input_block(self, features, phase):
        """Compute the input adapter and first training block."""
        n, first = self.numerics, self.blocks[0]
        working = features.to(n.working_dtype)
        raw_adapter = n.linear(n.round(working), first.input_adapter, f16_weights=True)
        return first(n.publish(raw_adapter), phase, skip_override=raw_adapter)

    def _input_stage(self, features, phase, target):
        """Return the full post70 skip and the pooled encoder state."""
        published, raw = self._input_block(features, phase)
        return published, self.numerics.pool(raw, target)

    def _bottleneck_stage(self, state, skip, target):
        """Block 39 transition, kept in one optional recomputation region."""
        n, transition = self.numerics, self.blocks[39]
        projected = n.linear(state, transition.up_projection, partition=256)
        raw = n.upsample_residual(projected, skip, n.round(transition.transition_scale), target)
        return n.publish(raw)

    def forward(self, features, *, valid_size=None, geometry=None, return_boundaries=False, crop=False):
        storage_dtype = self.blocks[0].input_adapter.dtype
        if storage_dtype not in (torch.float32, torch.bfloat16):
            raise ValueError("training model storage must be float32 or bfloat16; reload FP32 master weights")
        if features.ndim != 4 or features.shape[-1] != 16 or features.dtype not in (torch.float32, torch.bfloat16):
            raise ValueError("features must be [batch, padded_height, padded_width, 16] with float32 or bfloat16 dtype")
        if features.device != self.blocks[0].input_adapter.device:
            raise ValueError("features and model must be on the same device")
        if geometry is None:
            if valid_size is None:
                raise ValueError("provide valid_size=(width,height) or Geometry; padded size does not determine valid size")
            geometry = Geometry.from_valid(*valid_size)
        if features.shape[1:3] != (geometry.full_height, geometry.full_width):
            raise ValueError(f"features must cover padded field {geometry.full_width}x{geometry.full_height}")
        n, boundaries = self.numerics, {}
        phases = {item["block"]: item["phase"] for item in graph_schedule(geometry)}

        def block(index, state, skip=None):
            out, raw = self._run_stage(self.blocks[index], state, phases[index], skip_override=skip)
            if return_boundaries:
                boundaries[f"block-{index}"] = out
            return out, raw

        def capture(name, x):
            if return_boundaries:
                boundaries[name] = x
            return x

        adapter, state = self._run_stage(self._input_stage, features, phases[0], geometry.levels[0])
        capture("block-0", adapter)
        capture("transition-0-1", state)
        skips = {}
        for level, first, last in ((0, 1, 4), (1, 5, 8), (2, 9, 14), (3, 15, 22), (4, 23, 30)):
            for index in range(first, last):
                state, raw = block(index, state)
            high, state = self._run_stage(self._encoder_stage, state, last, phases[last], geometry.levels[level + 1])
            skips[level] = capture(f"block-{last}", high)
            capture(f"transition-{last}-{last + 1}", state)
        for index in range(31, 39):
            state, _ = block(index, state)
        state = capture("block-39", self._run_stage(self._bottleneck_stage, state, skips[4], geometry.levels[4]))
        for index in range(40, 48):
            state, _ = block(index, state)
        for level, first, last in ((3, 48, 55), (2, 56, 61), (1, 62, 65), (0, 66, 69)):
            state, _ = self._run_stage(self._decoder_stage, state, skips[level], first, phases[first], geometry.levels[level])
            capture(f"block-{first}", state)
            for index in range(first + 1, last + 1):
                state, _ = block(index, state)
        head, post_boundary = self._run_stage(self._post_head, state, adapter, geometry, phases[70], return_boundary=return_boundaries)
        if return_boundaries:
            boundaries["block-70"] = post_boundary
        if crop:
            head = head[:, :geometry.valid_height, :geometry.valid_width]
        return (head, boundaries) if return_boundaries else head

    def compose(self, head, proxy, reprojected_history=None):
        """Compose RGB in proxy sRGB code space; temporal reprojection is external."""
        if head.shape[:-1] != proxy.shape[:-1] or head.shape[-1] != 4 or proxy.shape[-1] != 3:
            raise ValueError("head [...,4] and proxy [...,3] must have matching spatial dimensions")
        neural = (proxy + head[..., :3] / 4).clamp(0, 1)
        if reprojected_history is None:
            return neural
        if reprojected_history.shape != proxy.shape:
            raise ValueError("reprojected history must match proxy")
        weight = (head[..., 3:4].sigmoid() * self.blocks[70].blend_scale).clamp(0, 1)
        return neural + weight * (reprojected_history - neural)
