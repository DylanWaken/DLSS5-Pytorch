# Entering and leaving the network

[Architecture overview](../ARCHITECTURE.md) · [Transitions](TRANSITIONS.md) · [Ordinary block](../ARCHITECTURE.md#follow-one-block)

## Input: block 0

![Input adapter, block-0 residual and separate encoder/skip outputs](../figures/architecture/input_stage.svg)

The caller supplies padded `[B, Hfull, Wfull, 16]` features. A learned per-position `16 → 32` adapter produces the block input. The C32 block reads the published adapter output while retaining the raw adapter output for its first residual.

Block 0's published result is saved for the block-70 skip. Its raw result is averaged over 2 × 2 positions and padded to the level-0 field, producing the C32 input to block 1. This path has no channel-doubling projection.

The adapter learns combinations of the supplied lanes. It does not construct renderer features, motion vectors or reprojected history. The measured deployment trunk begins at the pooled tensor entering block 1.

## Output: block 70

![Full-resolution skip merge, final block and four-channel head](../figures/architecture/output_stage.svg)

Block 69's C32 output is repeated 2× in height and width and cropped to the full padded field. A learned `input_scale` multiplies this path. A separate `adapter_scale` multiplies the saved block-0 tensor. Their sum enters block 70, with the raw merge retained for its first FFN residual.

The C32 block runs FFN and local attention. A `32 → 4` head reads its raw attention output and returns FP32. `crop=True` removes network padding. Channels 0–2 represent an RGB correction; channel 3 controls optional blending during composition.

## Optional composition after the head

Training forward ends at the four-channel head. `compose()` is separate:

```text
NeuralRGB = clamp(ProxyRGB + HeadRGB / 4, 0, 1)

Without history: return NeuralRGB

With caller-reprojected history:
    Blend = clamp(sigmoid(HeadAlpha) * blend_scale, 0, 1)
    return NeuralRGB + Blend * (HistoryRGB - NeuralRGB)
```

The proxy is in sRGB code space. Composition does not perform temporal reprojection. The training speed benchmark applies a diagnostic loss to the head; it does not establish a temporal loss or DLSS5 transfer-learning procedure.

Sources: [_input_block / _input_stage](../../dlssnr/model.py#L257), [_post_head](../../dlssnr/model.py#L234), [compose](../../dlssnr/model.py#L331).
