# Split reductions on smaller GPUs

The deployment plan now selects an ordered launch fallback when a dependent
kernel grid exceeds the current GPU's resident-block capacity. This fixes the
`ordered split reduction exceeds compiled resident capacity` error on smaller
SM120 GPUs, without dropping work or removing synchronization checks.

The affected operations, in both FP8 and FP16, are:

| Operation | K splits | Calls in the prepared-feature trunk |
|---|---:|---:|
| Bottleneck QKV projection | 2 | 8 |
| Bottleneck attention output projection | 4 | 8 |
| Bottleneck FFN contraction | 4 | 8 |
| C1024 → C512 decoder upsample | 4 | 1 |

The original kernels compute partial sums in separate Z blocks and use counters
to publish them in order. If waiting blocks occupy the available SMs before
their predecessors run, those predecessors cannot make progress. The former
FP16 admission check also relied on an observed ordering of Z waves; checking
only one XY plane was insufficient for portable scheduling.

Preparation queries occupancy for the actual compiled function and device.
When the complete dependent grid fits, the original combined launch remains
available. Otherwise, C++ submits one XY plane per split, in ascending order on
the caller's stream. Each plane can run in multiple waves and contains no
cross-block polling. CUDA stream ordering completes the previous split before
the next consumes its output, including during CUDA Graph replay.
[NVIDIA's stream ordering documentation](https://docs.nvidia.com/cuda/cuda-programming-guide/02-basics/asynchronous-execution.html)
describes this guarantee.

The fallback keeps the original MMA work, Half rounding, scratch layout,
residual addition and final completion-counter values. It reuses a previously
unused ABI word for `OrderedSplit`: zero selects the combined grid, while
`split + 1` selects one ordered phase. Parameter sizes and existing pointer
offsets remain unchanged. Counter clearing occurs once before the logical
operation, rather than between phases.

Both full-network C++ execution and prepared individual Torch operators use
the same host launcher. Thus `torch.compile`, bound C++ sequences and CUDA
Graphs inherit the selected policy. There remain 185 logical operations; when
all 25 dependent operations use the fallback, they produce 244 physical launches.
No extra scratch allocation or host/device synchronization is needed during
execution. Shared mutable workspaces must still be executed in stream order.

## Inspect or reproduce the fallback

`plan.split_launch_counts()` returns one count per logical operation: one for a
combined launch, or two/four for ordered splits. Preparation selects this
automatically; applications do not need an environment override.

For regression testing, set `DLSSNR_SM_COUNT_LIMIT=1` before constructing a
plan. This lowers the capacity used by the policy; it does **not** restrict
execution to one physical SM or simulate another GPU's speed. A requested
limit above the device's SM count is clamped to the actual count. Invalid
limits are rejected. The choice is cached at preparation and does not change
an existing plan or captured graph.

The [validation receipt](small_gpu_validation.json) records the final build,
numerical checks, replay checks and measurement scope. The available test
device is an RTX PRO 6000 Blackwell. A physical RTX 5060 run is not part of that
evidence. This change retains the SM120 architecture requirement; it does not
add support for other compute capabilities.
