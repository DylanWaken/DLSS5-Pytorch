# Channel mixing inside a block

[Architecture overview](../ARCHITECTURE.md) · [Attention](ATTENTION.md) · [Transitions](TRANSITIONS.md)

An FFN reads one position's channel vector and returns another vector of the same width. It applies the same learned matrices at every position. **It does not read neighboring pixels.** Attention performs that spatial exchange afterward.

`…` stands for the unchanged batch and spatial axes. `Linear A → B` mixes A channels into B channels. `φ` is the [recovered piecewise activation](NUMERICS.md#activation). FFN outputs below are **before** the enclosing block adds its residual.

## Dense FFN: C32 and C1024

![Dense feed-forward tensor flow](../figures/architecture/ffn_dense.svg)

The first matrix expands the channel vector by four. The activation changes each expanded value independently. The second matrix combines those values back into the original width.

| Family | Input | Expanded tensor | Output | Records |
|---|---|---|---|---|
| C32 | `[…, 32]` | `[…, 128]` | `[…, 32]` | 0–4, 66–70 |
| C1024 | `[…, 1024]` | `[…, 4096]` | `[…, 1024]` | 31–38 |

## Full-input branches: C64, C128 and C256

![Full-input fan-out through parallel branches and concatenation](../figures/architecture/ffn_branched.svg)

The **entire C-channel vector goes to every branch**. Each branch has its own `C → 128 → 32` matrices. The resulting 32-channel vectors are concatenated, then a final `C → C` projection mixes all branches.

For C128, four branches each read the same 128 channels and each produce 32 channels. Concatenation restores 128 channels; it does not sum four vectors.

| Channels C | Branches E | Each branch reads | Each emits | Concatenated width |
|---|---|---|---|---|
| 64 | 2 | All 64 channels | 32 | 64 |
| 128 | 4 | All 128 channels | 32 | 128 |
| 256 | 8 | All 256 channels | 32 | 256 |

Every branch executes for every position. Some source variables say `expert`, but there is no router, top-k selection or sparse expert dispatch.

## Grouped FFN: C512

![C512 premix, channel split, eight branches and postmix](../figures/architecture/ffn_grouped.svg)

A `512 → 512` projection first mixes the full input. Its output is split into **eight different 64-channel slices**. Each branch transforms its slice through `64 → 256 → 64`. Concatenation restores 512 channels, and a second `512 → 512` projection mixes the branches again.

Here branches receive different slices of a premixed tensor. In the C64–C256 family they receive copies of the full input. The matrices before and after the C512 branches provide communication between slices.

## Where the residual joins

The block computes `Zraw = FFN(X) + ffn_scale ⊙ R`, then publishes `Z`. The scale has one learned value per channel, broadcast over positions. Usually `R = X`; blocks 0, 66 and 70 retain a raw adapter/merge for this path. QKV reads `Z`, after the addition. See the [full block diagram](../ARCHITECTURE.md#follow-one-block).

Sources: [NRBlock.forward](../../dlssnr/model.py#L162), [linear_activate](../../dlssnr/model.py#L62), [decode_block](../../dlssnr/weights.py#L218).
