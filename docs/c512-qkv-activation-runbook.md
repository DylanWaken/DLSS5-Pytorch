# C512 public API and continuous scan activation runbook

All commands below are for the main task's exclusive GPU slot. This draft has not run GPU work. Activate only the reviewed bundle listed in `outputs/c512_qkv_activation_manifest.json.draft`; it includes the `run_tuning.py` registration named `c512-qkv-range`. The separate staged root entry file is `run_tuning.c512-qkv.py.draft`, so another agent's `run_tuning.py.draft` is not overwritten.

The public header remains an empty table (version `36ff8ced9bc972db`). Do not activate a Python model or native-helper route change before this scan. The scan's offline interception requires the existing public QKV-linear/attention sequence and deliberately rejects a different route.

## Activation and CPU checks

Verify every source hash and every existing destination hash from the manifest before copying. If a destination changed since the manifest was produced, rebase that individual change first; do not overwrite concurrent work. In particular, the root entry change is just this added dictionary member:

```python
"c512-qkv-range": "tuning.resolution_c512_qkv",
```

After copying the drafts to the corresponding active paths, run:

```powershell
Set-Location D:\Research\DLSSNR-PyTorch
& .\.venv\Scripts\python.exe -m pytest tests/test_c512_qkv_policy_cpu.py tests/test_c512_qkv_attention_cpu.py tests/test_c512_qkv_attention_prefetch_cpu.py -q --junitxml=outputs/v35-c512-cpu.xml
if ($LASTEXITCODE) { throw 'C512 CPU checks failed' }
& .\.venv\Scripts\python.exe run_tuning.py c512-qkv-range --output-dir outputs/c512-qkv-v35
if ($LASTEXITCODE) { throw 'C512 manifest failed' }
```

The first suite includes fourteen new policy/controller CPU tests. The historical timing-report check alone skips when its ignored report is absent; the main fixtures are self-contained. The manifest command is CPU-only and should report 4,128 physical contracts, 258 fields, 166 M values and all sixteen blocks/phases. Root may combine the three public C++ files with its other reviewed v35 changes and run `./build_windows.ps1 -NoInplace -Jobs 4`, then use the established build snapshot/install procedure. Freeze active code before running the following proof and scan commands.

## Local GPU and sanitizer proof on the installed binary

Use a fresh release tag and fresh output files after every rebuild. The following v35 paths are examples of one fixed release identity, not permission to reuse old evidence. Do not run these commands concurrently with another GPU task.

```powershell
& .\.venv\Scripts\python.exe -m pytest tests/test_c512_qkv_attention.py tests/test_c512_qkv_attention_prefetch.py tests/test_c512_qkv_public_dispatch.py -q --junitxml=outputs/v35-c512-tests.xml
if ($LASTEXITCODE) { throw 'C512 GPU tests failed' }
$c512Sanitizer = (Get-Command compute-sanitizer).Source
& $c512Sanitizer --tool memcheck --target-processes all --launch-timeout 300 --error-exitcode 86 --log-file outputs/v35-c512-memcheck.log .\.venv\Scripts\python.exe -m pytest tests/test_c512_qkv_attention.py tests/test_c512_qkv_attention_prefetch.py tests/test_c512_qkv_public_dispatch.py -q --junitxml=outputs/v35-c512-memcheck.xml
if ($LASTEXITCODE) { throw 'C512 memcheck failed' }
& $c512Sanitizer --tool racecheck --target-processes all --launch-timeout 300 --error-exitcode 87 --log-file outputs/v35-c512-racecheck.log .\.venv\Scripts\python.exe -m pytest tests/test_c512_qkv_attention.py::test_mutable_capture_alignment_current_stream tests/test_c512_qkv_attention_prefetch.py::test_mutable_capture_alignment_current_stream tests/test_c512_qkv_public_dispatch.py::test_mutable_graph_current_stream_and_snapshot -q --junitxml=outputs/v35-c512-racecheck.xml
if ($LASTEXITCODE) { throw 'C512 racecheck failed' }
```

Both private candidates need at least 66 passing ordinary cases, 66 memcheck cases and eight racecheck cases on this same installed binary. The public wrapper adds forty GPU test cases, one requiring a second GPU. The bounded racecheck command includes eight mutable-capture cases per private candidate and four public cases. The launch timeout prevents slow initialization/preflight from consuming the sanitizer's default attachment timeout.

Create the local proof manifest only after those commands pass, without changing the installed extension or the source between them. The shared validator rejects every nonzero sanitizer summary, including one occurring after an earlier zero summary. The candidate-specific validator counts unique test names, so repeating a JUnit artifact cannot inflate the evidence.

```powershell
@'
import hashlib, importlib.util, json
from pathlib import Path
from tuning.component_policy import validate_local_proof
from tuning.resolution_c512_qkv import local_proof
root=Path.cwd()
binary=Path(importlib.util.find_spec('dlssnr._C').origin)
digest=lambda path:hashlib.sha256(Path(path).read_bytes()).hexdigest()
files=[('junit','outputs/v35-c512-tests.xml'),('junit','outputs/v35-c512-memcheck.xml'),('junit','outputs/v35-c512-racecheck.xml'),('memcheck_log','outputs/v35-c512-memcheck.log'),('racecheck_log','outputs/v35-c512-racecheck.log')]
proof={'sm':120,'extension_sha256':digest(binary),'extension_path':str(binary),'scope':'same installed binary, exclusive sequential local tests and sanitizer runs; no native or roofline assertion','artifacts':[{'kind':kind,'path':name,'sha256':digest(root/name)} for kind,name in files]}
validate_local_proof(proof,root,proof['extension_sha256'],120)
path=root/'outputs/c512_qkv_local_proof_v35.json'
path.write_text(json.dumps(proof,indent=2)+'\n')
print(local_proof(path,{'device':{'extension_sha256':proof['extension_sha256']},'resume_identity':{'settings':{'variants':[1,2]}}}))
'@ | & .\.venv\Scripts\python.exe -
if ($LASTEXITCODE) { throw 'C512 local proof manifest failed' }
```

The association between a sanitizer log and the installed binary is the root runner's attestation; hashing cannot retroactively establish what a stale test process loaded. Preserve the release binary and the root's source/build snapshot alongside these artifacts.

## Exclusive preflight, complete scan, export and no-op resume

Use the same options and source/binary identity for every command. The first command measures three real 4K contracts while retaining the full requested domain in its journal. The next resumes the remaining contracts and exports only complete phase families. All alternatives share the same public block, input, cache, baseline trial and combined output budget. The preflight intentionally does not export an incomplete family.

```powershell
& .\.venv\Scripts\python.exe run_tuning.py c512-qkv-range --execute --variants 1 2 --max-cases 3 --output-dir outputs/c512-qkv-v35
if ($LASTEXITCODE) { throw 'C512 three-case preflight failed' }
& .\.venv\Scripts\python.exe run_tuning.py c512-qkv-range --execute --variants 1 2 --output-dir outputs/c512-qkv-v35 --export-policy --local-proof outputs/c512_qkv_local_proof_v35.json
if ($LASTEXITCODE) { throw 'C512 full scan/export failed' }
$c512JournalBefore = (Get-FileHash -LiteralPath outputs/c512-qkv-v35/measurements.sqlite3 -Algorithm SHA256).Hash
& .\.venv\Scripts\python.exe run_tuning.py c512-qkv-range --execute --variants 1 2 --output-dir outputs/c512-qkv-v35 --export-policy --local-proof outputs/c512_qkv_local_proof_v35.json
if ($LASTEXITCODE) { throw 'C512 no-op resume audit failed' }
if ((Get-FileHash -LiteralPath outputs/c512-qkv-v35/measurements.sqlite3 -Algorithm SHA256).Hash -ne $c512JournalBefore) { throw 'No-op resume modified the case journal' }
```

Defaults are eight requested calls per graph, eleven normal/reverse full-permutation rounds, three warmups, a combined 128MiB retained-output budget and a strict >3% full-block gate. Raw-output cases may reduce the common calls-per-graph count to respect that budget; every path in a case still uses the same count. The controller commits each case to SQLite and exports JSON every 32 cases or 60 seconds. Source/runtime/checkpoint hashes are rechecked before and after every case and at export. An interrupted run resumes committed rows only.

The final files are `measurements.json`, `measurements.sqlite3`, `sm_120_c512_qkv.json.draft` and `c512_qkv_policy.h.draft`. Four complete phase families contain 664 anchors, including composition guards; performance eligibility determines their variants. Do not copy those generated policy files into active sources until the scan and proof have been reviewed. The eventual policy/model/helper build needs fresh public graph and native DLL proofs; this local scanner does not pass the native speed or 85% hardware gate.
