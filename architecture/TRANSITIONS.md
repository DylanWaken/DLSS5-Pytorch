# Moving between resolutions

[Architecture overview](../ARCHITECTURE.md) · [FFN](FFN.md) · [Attention](ATTENTION.md) · [Endpoints](ENDPOINTS.md)

Ordinary blocks keep their dimensions. Transitions change spatial size and channel count. Encoder skips retain features from before downsampling so the decoder can recover detail at the corresponding resolution.

## Encoder: save detail and reduce the field

![Encoder tail splitting into a saved skip and a pooled, projected next-level tensor](../figures/architecture/encoder.svg)

The last block at a level produces a raw attention result and its published form. The **published form is saved as the skip**. The raw result takes the downward path: average each 2 × 2 group, pad to the next level's field, then project `C → 2C` at each remaining position. The pool reduces spatial size; the projection mixes channels at each position.

At 4K, block 14 sees `[272, 480, 128]`. Its skip retains that shape. Pooling gives `[136, 240, 128]`, and the projection gives `[136, 240, 256]` for block 15.

| Tail block | Channels before → after | Skip is read by |
|---|---|---|
| 4 | 32 → 64 | Block 66 |
| 8 | 64 → 128 | Block 62 |
| 14 | 128 → 256 | Block 56 |
| 22 | 256 → 512 | Block 48 |
| 30 | 512 → 1024 | Transition 39 |

Block 0 also forks into a skip and pooled path, but **keeps 32 channels** without an additional down-projection. See the [input diagram](ENDPOINTS.md#input-block-0).

## Decoder: restore the field and add the skip

![Decoder projection, spatial expansion, encoder skip addition and ordinary block flow](../figures/architecture/decoder.svg)

The lower-resolution tensor is projected `2C → C` before upsampling. Each resulting position is repeated into a 2 × 2 patch; cropping matches the target field. The corresponding encoder skip is multiplied by a learned channelwise scale and added. This is **addition**, not concatenation. Ordinary FFN/attention processing follows the merge.

For block 56 at 4K, `[136, 240, 256]` is projected to 128 channels, expanded to `[272, 480, 128]`, and added to the block-14 skip of the same shape.

| Transition | Projection | Incoming skip | After merge |
|---|---|---|---|
| 39 | 1024 → 512 | 30 | Publish only; ordinary block 40 follows |
| 48 | 512 → 256 | 22 | Block 48 body, then 49–55 |
| 56 | 256 → 128 | 14 | Block 56 body, then 57–61 |
| 62 | 128 → 64 | 8 | Block 62 body, then 63–65 |
| 66 | 64 → 32 | 4 | Block 66 body, then 67–69 |

Block 39 is transition-only. For 48, 56, 62 and 66, transition weights belong to the first ordinary block of the destination level. Block 66 keeps the raw merge for its FFN residual while FFN computation reads the published merge. Block 70 has a separate full-resolution merge with two scales and no `2C → C` projection.

Sources: [_encoder_stage](../../dlssnr/model.py#L243), [_decoder_stage](../../dlssnr/model.py#L249), [_bottleneck_stage](../../dlssnr/model.py#L269), [pool / upsample](../../dlssnr/model.py#L94).
