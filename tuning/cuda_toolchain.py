"""Opt-in PTX assembler selection for an otherwise unchanged CUDA toolkit.

The CUDA compiler, headers, libdevice, host glue and runtime remain supplied by
CUDA_HOME. Only ptxas is selected through DLSSNR_PTXAS_PATH. This uses nvcc's
documented --dont-use-profile option and an isolated PATH entry; it never edits
an installed toolkit and does not bypass PyTorch's CUDA version check.
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess


@dataclass(frozen=True)
class CudaAssemblerSelection:
    nvcc_flags: tuple[str, ...]
    path_prefix: tuple[str, ...]
    receipt: dict

    def environment(self, base: dict[str, str] | None = None) -> dict[str, str]:
        environment = dict(os.environ if base is None else base)
        environment["PATH"] = os.pathsep.join((*self.path_prefix, environment.get("PATH", "")))
        return environment


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def prepare_cuda_assembler(cuda_home: str | Path, cache_directory: str | Path,
                           assembler_path: str | Path | None = None) -> CudaAssemblerSelection | None:
    """Return explicit build flags and environment; unset opt-in changes nothing.

    cache_directory is a project build directory, not a toolkit directory. The
    selected executable is copied into a digest-named private directory so its
    toolkit's other helpers cannot accidentally replace CUDA_HOME's helpers.
    """
    requested = assembler_path if assembler_path is not None else os.environ.get("DLSSNR_PTXAS_PATH")
    if not requested:
        return None
    toolkit = Path(cuda_home).expanduser().resolve(strict=True)
    assembler = Path(requested).expanduser().resolve(strict=True)
    executable_suffix = ".exe" if os.name == "nt" else ""
    if not assembler.is_file():
        raise ValueError(f"PTX assembler must be a file: {assembler}")
    required = [toolkit / "bin" / ("nvcc" + executable_suffix),
                toolkit / "nvvm/bin" / ("cicc" + executable_suffix),
                toolkit / "include/cuda_runtime.h", toolkit / "nvvm/libdevice"]
    missing = [str(path) for path in required if not path.exists()]
    if missing:
        raise FileNotFoundError("CUDA_HOME is incomplete: " + ", ".join(missing))
    version = subprocess.run([str(assembler), "--version"], capture_output=True, text=True, check=True)
    version_text = (version.stdout + version.stderr).strip()
    if "Ptx optimizing assembler" not in version_text or "Cuda compilation tools" not in version_text:
        raise ValueError(f"Executable did not identify as NVIDIA ptxas: {assembler}")
    digest = _sha256(assembler)
    cache = Path(cache_directory).expanduser().resolve()
    private = cache / digest
    private.mkdir(parents=True, exist_ok=True)
    copied = private / ("ptxas" + executable_suffix)
    if copied.exists():
        if _sha256(copied) != digest:
            raise RuntimeError(f"Cached PTX assembler was modified: {copied}")
    else:
        shutil.copy2(assembler, copied)
    if _sha256(copied) != digest:
        raise RuntimeError("Copied PTX assembler failed its identity check")
    prefix = (str(private), str(toolkit / "nvvm/bin"), str(toolkit / "bin"))
    include_directories = [toolkit / "include"]
    # Conda's Windows CUDA layout puts CCCL headers below this second include
    # root. It is the same x64 directory added by that toolkit's nvcc.profile.
    windows_target = toolkit / "include/targets/x64"
    if os.name == "nt" and windows_target.is_dir():
        include_directories.append(windows_target)
    # Ninja hashes command lines, not PATH. Include the backend identity so an
    # explicit assembler change invalidates cached objects even at the same path.
    flags = ("--dont-use-profile", "--libdevice-directory=" + str(toolkit / "nvvm/libdevice"),
             *("-I" + str(path) for path in include_directories),
             "-DDLSSNR_PTXAS_CACHE_KEY_" + digest + "=1")
    receipt = {"cuda_home": str(toolkit), "ptxas_source": str(assembler), "ptxas_private": str(copied),
               "ptxas_sha256": digest, "ptxas_version": version_text,
               "nvcc_flags": list(flags), "path_prefix": list(prefix)}
    selection = CudaAssemblerSelection(flags, prefix, receipt)
    search_path = selection.environment()["PATH"]
    resolved = {}
    for name in ("ptxas", "cicc", "cudafe++", "fatbinary", "nvlink"):
        selected = shutil.which(name + executable_suffix, path=search_path)
        if not selected:
            raise FileNotFoundError(f"CUDA build helper is missing: {name}")
        selected_path = Path(selected).resolve()
        expected = copied if name == "ptxas" else toolkit / ("nvvm/bin" if name == "cicc" else "bin") / (name + executable_suffix)
        if selected_path != expected.resolve():
            raise RuntimeError(f"Unexpected CUDA helper selected: {name}: {selected_path}")
        resolved[name] = str(selected_path)
    receipt["resolved_helpers"] = resolved
    (private / "selection.json").write_text(json.dumps(receipt, indent=2) + "\n", encoding="utf-8")
    return selection
