# The operations behind the labels

[Architecture overview](../ARCHITECTURE.md) · [FFN](FFN.md) · [Attention](ATTENTION.md)

Tensor-flow diagrams use short names to keep the data paths visible. These formulas describe floating PyTorch training. Deployment additionally preserves its packed FP8/FP16 arithmetic and rounding contracts.

![Activation, normalization and attention exponential formulas](../figures/architecture/numerics.svg)

## Activation

The FFN label `φ` means this recovered pointwise function:

```text
b = clamp(x, -4, 4)
φ(x) = x * (b * (-0.055908203125 * abs(b) + 0.447265625) + 0.89453125)
```

It changes values without changing shape. The source method is named `silu`, but its formula differs from standard SiLU. Training evaluates it with FP32 intermediates and casts back to the working dtype.

## Q and K normalization

Each head has a 32-channel vector at every position. Q and K are normalized separately:

```text
L2Norm(v) = v / max(sqrt(sum(v * v, across 32 channels)), 1e-12)
```

The reduction is across channels, not tokens or heads. It does not subtract a mean and is not a LayerNorm. Q subsequently receives the learned head scale; global Q also receives `sqrt(32)`.

## Attention exponential

Both branches use the same form with different constants:

```text
z = clamp(a * score + b, lo, hi)
E(score) = E0 * exp((z - b) * s * ln(2))
```

Local attention divides E by its 64-key row sum before multiplying V. Global attention uses E in the numerator, sums in 64-key chunks, subtracts padded-key contributions, then divides the value vector by the corrected denominator. The [attention diagrams](ATTENTION.md) show these separate paths.

## Publication and precision

`Publish` means cast to the selected working precision in training: FP32 or BF16. It preserves shape. `Raw` marks the value before that explicit publication, **not a promise of wider storage**; many operators already return the working dtype. This distinction identifies the correct residual and pooling sources and connects them to deployment's separate numerical boundaries.

FP32 master parameters are recommended. BF16 changes matrix operands and working tensors, while norms, exponentials, reductions and residual arithmetic use FP32 intermediates. Checkpointing changes what backward stores or recomputes; it does not add a network operation. See [training](../training.md).

Source: [Numerics](../../dlssnr/model.py#L32).
