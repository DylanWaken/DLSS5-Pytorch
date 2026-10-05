# Implementation contract

Reconstruct the 310.8.0 71-block graph from pinned OpenDLSS-NR evidence, load the
153 original records, and expose forward plus explicit surrogate backward as
separate CUDA Graph-compatible torch operators. Support FP16 on sm80+ and FP8 on
sm89+. Keep device/shape kernel policy in C++, generated offline from measured
sm_<SM>.json. Use the three requested csrc layers and separate tests/tuning.

Correctness precedes optimization: validate file/shape contracts, independent
numerical fixtures, architecture-specific MMA probes, gradients, full graph,
and CUDA Graph replay. Native byte parity and same-device official timing are
independent gates and cannot be inferred from a synthetic smoke test.

KDA loop: collect NCU full/source reports with lineinfo and SASS; record the
actual bottleneck; implement one candidate; reject correctness failures;
remeasure, retain provenance, and report whether 85% elapsed sustained throughput
and official-runtime latency gates pass, fail, or remain unverified.
