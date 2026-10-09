# How positions exchange information

[Architecture overview](../ARCHITECTURE.md) · [FFN](FFN.md) · [Transitions](TRANSITIONS.md)

Attention starts from the FFN result **after its residual addition**. A learned projection produces Q, K and V. Q describes what a position looks for; K describes what each candidate offers; V carries the features to combine. Each head has 32 channels. Head outputs are joined into C channels before the block's output projection and second residual.

## Local window attention

![Q, K, V branches, score normalization and weighted values](../figures/architecture/window_attention.svg)

For each head, an 8 × 8 window becomes 64 query rows and 64 key/value rows. `Q Kᵀ` produces a **64 × 64 score matrix**: row i describes what query i reads from all 64 positions. A learned bias adjusts each query/key pair. A recovered exponential makes the scores positive, and division by the row sum normalizes their relative weights.

Multiplying those weights by V produces a 32-channel result for each query. Window assembly and cropping put results back at their image positions. The output projection then mixes heads, and the block adds its attention residual.

| Tensor, one window and one head | Shape | Meaning |
|---|---|---|
| Q | `[64, 32]` | Query vector at each position |
| K, V | `[64, 32]` each | Key and value at each candidate position |
| Scores, exponentials, weights | `[64, 64]` each | Query rows × key columns |
| Row denominator | `[64, 1]` | Total weight for each query |
| Weighted values | `[64, 32]` | Updated features for all queries |

Q and K are separately L2-normalized across 32 channels. Q then receives a learned scalar per head. This graph uses a [clamped exponential surrogate](NUMERICS.md#attention-exponential), rather than standard softmax/SDPA. Bias is indexed by head, query position and physical key position.

## How windows cover the image

![Window tiling, one query reading 64 keys, and shifted boundaries](../figures/architecture/window_partition.svg)

The field is padded on the left/top according to the phase, then on the right/bottom to complete 8 × 8 windows. Changing the phase changes which positions share a window. Successive blocks can therefore carry features across an earlier window boundary.

| Phase | Left pad | Top pad | Window origin relative to the field |
|---|---|---|---|
| 0 | 0 | 0 | `(0, 0)` |
| 1 | 4 | 4 | `(-4, -4)` |
| 2 | 4 | 0 | `(-4, 0)` |
| 3 | 0 | 4 | `(0, -4)` |

Unpartitioning reverses the reshape and crops away padding. This is **positive padding and cropping**, not a cyclic roll. Local padded positions participate in attention; this branch does not add a standard Swin attention mask. Phase counters advance per spatial level and continue when the decoder revisits that level.

K and V use the same recovered token permutation within each window; bias columns match that order. The permutation changes storage order, not which 64 positions a query can read. Q rows retain natural order.

## Global bottleneck attention

![Global flow with weighted-value numerator and corrected denominator](../figures/architecture/global_attention.svg)

C1024 flattens the field into `T = H × W` tokens and uses 32 heads. A query can read **all T positions**. Q and K are normalized as above; Q additionally receives `√32` before its learned scale. This branch has no local relative-bias table.

K and V are zero-padded to `P = ceil(T / 64) × 64`. Q keeps T rows, giving `[T, P]` scores per head. The exponential splits into a weighted-value numerator and row-sum denominator. The denominator subtracts `(P − T) × Eglobal(0)`: a zero-padded key still produces a nonzero exponential. Padded V is zero, so it contributes nothing to the numerator. Division restores one vector per real query.

At 4K the bottleneck is `[36, 60, 1024]`: **T = 2160**, **P = 2176**, removing 16 padded-key contributions per query. Reshaping restores `[36, 60, 1024]` before the output projection and residual.

These are logical shapes. Eager training materializes large score tensors; CUDA deployment tiles the work. A drawn `[T, P]` tensor does not imply a full deployment allocation.

Sources: [attend](../../dlssnr/model.py#L128), [_windows / _unwindows](../../dlssnr/model.py#L20), [window_shift](../../dlssnr/geometry.py#L65), [relative_bias](../../dlssnr/weights.py#L208).
