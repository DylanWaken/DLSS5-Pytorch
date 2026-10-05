This package is an offline policy validator, C++ code generator and work planner. It contains no GPU routines or Python inference dispatch. It imports no legacy policy or `dlssnr` package initialization. Geometry enumeration loads the canonical sibling `dlssnr/geometry.py` by file path.

The shipped per-device `sm_120.json` has no measured anchors and no shape admissions. `resolution_policy.json` is a generic schema template. Future `sm_xxx.json` files must declare the matching `device_sm`; no row may cross that device boundary. Lookup/codegen default to these per-device files, or accept repeated explicit `--policy` paths. The generated C++ namespace is `dlssnr::resolution_policy`; `select(width,height,sm,Precision)` returns `Selection`. Its default is `config_id=-1`, `Status::Unmeasured`, `actual_shape_supported=false` and `runtime_qualified=false`. The common launcher retains responsibility for its explicit reconstructed baseline route and shape admission. This package defines no algorithm knobs or fallback implementation.

Only the policy query is clamped independently to widths 1280–3840 and heights 720–2160, then to the minimum/maximum measured width and height within the matching SM/precision family when anchors exist. Empty families remain explicitly unmeasured with configuration -1. Actual dimensions are preserved; neither clamp grants execution admission. Within the same precision and SM family, selection minimizes `dx²*1440² + dy²*2560²`, equivalent to squared distance normalized by the two domain spans. Ties select the lower anchor width, then height, then configuration ID. Transferring a measured anchor supplies neither a measurement at the requested resolution nor runtime qualification. An anchor's `median_ns` is evidence for that anchor only; the selector does not estimate latency or invent a winner.

Execution admission is an exact match on the original width, height, precision and SM. Its separate state is `implementation_admitted` or `runtime_qualified`. Clamped coordinates never grant admission. An implementation-only row does not imply completed runtime qualification.

From the staged package root, the CPU commands are:

```text
python -B run_tuning.py lookup --width 1920 --height 1080 --sm 120 --precision fp8
python -B run_tuning.py codegen --output csrc/kernel_launcher/compiled_resolution_policy.h
python -B run_tuning.py enumerate --sm 120 --precision fp8 --output work/plan.json
python -B run_tuning.py resume-plan --plan work/plan.json --completed work/completed.json --evidence-root work --output work/pending.json
```

Use `[]` for an initially empty `completed.json`. Enumeration preserves the six levels and coupled full-width padding of the canonical Geometry implementation. It describes every integer resolution using disjoint axis-state rectangles and 931 physical geometry representatives. This is geometry coverage, not measured or executable coverage. Resume accepts only unchanged plans and exact representative measurements; one verified configuration completes a representative, without claiming an optimal configuration or measurements for other resolutions sharing that geometry.

A measured anchor contains `sm`, `precision` (`fp8` or `fp16`), `width`, `height`, opaque nonnegative `config_id`, `configuration_sha256`, printable `interval`, `binary_sha256`, `source_sha256`, positive integer `median_ns`, positive integer `samples`, `verified=true`, relative `receipt` and `receipt_sha256`. Every anchor in one SM/precision family must share the interval, binary and source identity. A configuration ID must retain one configuration digest within its family. There is one selected measured configuration per anchor coordinate; selection among competing benchmark configurations is an external evidenced action.

An admission row contains the same resolution/family and receipt fields plus `state`; it contains no measurement or configuration fields. Before CLI lookup/codegen/resume, receipt file bytes must match their SHA256. Each JSON receipt has `schema_version=1`, `kind=resolution_measurement` or `resolution_admission`, and `record` exactly equal to the corresponding row with `receipt` and `receipt_sha256` removed. Receipts are resolved below the specified evidence root. The exporter validates saved evidence identity; it does not independently rerun its numerical or performance proof.

The generated header uses only C++17 standard headers and has stable versioned rows, including valid zero-length `std::array` tables. Focused CPU tests exercise the Python reference, receipt failures, actual CLI commands and geometry coverage. This preparation does not compile or link the C++ selector; the root build must perform that check when integrating it.
