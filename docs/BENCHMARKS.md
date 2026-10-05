# Performance overview and benchmark scope

These measurements use an RTX PRO 6000 Blackwell (SM120). “2K” means 2560 × 1440. Deployment and training cover different boundaries and should not be compared as equivalent workloads.

## FP8 deployment

![FP8 prepared-feature trunk at four resolutions](figures/deployment_fp8_resolutions.svg)

| Valid resolution | Original kernels | Reconstructed | Difference |
|---|---:|---:|---:|
| 1280 × 720 | 2.172192 ms | 2.123984 ms | −2.219% |
| 1920 × 1080 | 2.547851 ms | 2.521051 ms | −1.052% |
| 2560 × 1440 | 3.488731 ms | 3.465125 ms | −0.677% |
| 3840 × 2160 | 6.452048 ms | 6.496523 ms | +0.689% |

The prepared-feature trunk covers blocks 1–69, with 152 compute/repack calls and 33 clears. It excludes block-0 input preparation, block-70 output processing, and DLL/NGX/renderer host work. The baseline runs extracted original kernels with matched scheduling, not the complete DLL host pipeline.

Each run uses three warmups and 32 alternating pairs, 16 per order, with three whole-trunk calls per captured graph. Timings are CUDA-event medians. The accepted no-more-than-1% slowdown criterion passes in both execution orders at all four sizes. Numerical comparison covers all 74 published boundaries. Full protocol, per-order results and evidence are in [reconstruction status](RECONSTRUCTION_STATUS.md).

## Individual FP8 and FP16 kernels

![Six kernel families in both precisions](figures/deployment_kernel_precision_comparison.svg)

This suite covers six families per precision: C32/C64/C128/C256 ordinary windows, C512 FFN and C512 QKV/attention. Each is tested at four resolution-derived internal fields, for 48 cases. All numerical and guard checks pass. This does not establish a complete FP16 deployment graph.

Bars show pooled medians; whiskers span the two execution-order medians. **36 of 48 cases reverse ranking with execution order.** Three FP8 and eight FP16 cases are slower in both orders. The full-trunk acceptance therefore must not be read as a universal individual-kernel speed result. See the [complete per-kernel and per-order table](../outputs/all-reconstructed-deployment-prep/fp16-kernel-benchmark/RESULTS.md) and [raw chart data](figures/deployment_measurements.json).

## FP32 and BF16 training

![Checkpoint-enabled training at four resolutions](figures/training_resolutions.svg)

All eight checkpoint-enabled cases pass. The benchmark includes all 71 numbered records, autograd forward, and backward through `head.square().mean()`, at batch one with FP32 master parameters. It uses two warmups and seven samples, without an optimizer, compilation or CUDA graphs. Recomputed work is included in backward time. The two precisions ran sequentially, so the plot is descriptive rather than a balanced precision-speedup experiment.

See [training results and reproduction commands](training.md) for exact timings, settings and memory. The original uncheckpointed implementation's [chart](figures/training_resolutions_eager_v1.svg) and [raw data](figures/training_resolutions_eager_v1.json) preserve the FP32 2K/4K and BF16 4K OOM outcomes. The [memory investigation](TRAINING_MEMORY.md) explains their cause and the checkpointing correction.

Actual DLSS5 transfer-learning losses, data preparation and training procedures remain to be investigated. These timings do not establish trained output quality.
