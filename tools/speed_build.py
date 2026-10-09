"""Find or build a native deployment library for the speed-test device.

Registration libraries are inspected in disposable subprocesses. This module
never loads one into the benchmark coordinator, so an incompatible library can
be replaced before any benchmark process starts.
"""
from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime, timezone
import importlib
import json
import math
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import time
from typing import Callable

from dlssnr import _binary


ROOT = Path(__file__).resolve().parents[1]
PROBE_PREFIX = 'DLSSNR_SPEED_BINARY='
PROBE_CODE = '''import json, sys
from dlssnr.deployment import load_extension
ops = load_extension(sys.argv[1])
print("DLSSNR_SPEED_BINARY=" + json.dumps(list(ops.deployment_build_architectures())))
'''


@dataclass(frozen=True)
class ExtensionBuild:
    binary_path: str
    built: bool
    receipt: dict
    log_path: str | None = None
    receipt_path: str | None = None


class ProbeCleanupError(RuntimeError):
    """A probe may still hold the library; replacement must not proceed."""


def _probe_extension(path: str, root: Path, device_sm: int,
                     timeout_seconds: float = 120) -> list[int]:
    """Read build metadata without poisoning the caller's operator registry."""
    try:
        process = subprocess.Popen(
            [sys.executable, '-c', PROBE_CODE, path], cwd=root,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            text=True, encoding='utf-8', errors='replace',
            start_new_session=os.name != 'nt',
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == 'nt' else 0)
    except OSError as error:
        raise RuntimeError(f'Deployment library probe failed: {error}') from error
    try:
        stdout, stderr = process.communicate(timeout=timeout_seconds)
    except BaseException as error:
        # Windows virtualenv python.exe can launch a second interpreter. A
        # plain subprocess.run timeout kills only the launcher, leaving that
        # interpreter's registration library locked during the ensuing build.
        try:
            _stop_build(process)
            process.communicate(timeout=30)
        except BaseException as cleanup_error:
            raise ProbeCleanupError(
                'Could not confirm that the deployment library probe stopped; '
                'automatic replacement was cancelled.') from cleanup_error
        if isinstance(error, subprocess.TimeoutExpired):
            raise RuntimeError(f'Deployment library probe exceeded {timeout_seconds:g} seconds') from error
        raise
    # communicate closes its pipes after EOF. Do not force-close them after a
    # failed cleanup: a Windows reader thread may still hold the stream lock.
    if process.returncode:
        detail = (stderr or stdout).strip()[-4000:]
        raise RuntimeError(f'Deployment library could not be loaded: {detail}')
    rows = [line[len(PROBE_PREFIX):] for line in stdout.splitlines()
            if line.startswith(PROBE_PREFIX)]
    try:
        architectures = json.loads(rows[-1]) if rows else None
    except (ValueError, TypeError) as error:
        raise RuntimeError('Deployment library returned invalid architecture metadata') from error
    if not isinstance(architectures, list) or not architectures or any(
            type(sm) is not int or sm < 80 for sm in architectures):
        raise RuntimeError('Deployment library has no valid architecture metadata')
    native = [sm for sm in architectures if device_sm < 89 or sm >= 89]
    if not _binary.compatible_targets(device_sm, native):
        raise RuntimeError(
            f'Deployment library targets {architectures}, incompatible with SM{device_sm}')
    return architectures


def _find_vcvarsall(environment: dict[str, str]) -> Path | None:
    """Locate Visual Studio through its installer or setuptools discovery."""
    candidates = []
    on_path = shutil.which('vswhere.exe', path=environment.get('PATH', ''))
    if on_path:
        candidates.append(Path(on_path))
    for key in ('PROGRAMFILES(X86)', 'PROGRAMFILES'):
        if environment.get(key):
            candidates.append(Path(environment[key]) / 'Microsoft Visual Studio/Installer/vswhere.exe')
    for locator in dict.fromkeys(candidates):
        if not locator.is_file():
            continue
        try:
            result = subprocess.run(
                [str(locator), '-latest', '-products', '*', '-requires',
                 'Microsoft.VisualStudio.Component.VC.Tools.x86.x64',
                 '-property', 'installationPath'], env=environment,
                capture_output=True, text=True, timeout=30, check=True)
        except (OSError, subprocess.SubprocessError):
            continue
        location = result.stdout.strip()
        if location:
            script = Path(location) / 'VC/Auxiliary/Build/vcvarsall.bat'
            if script.is_file():
                return script
    # Setuptools supports registry discovery on machines without vswhere in
    # its standard installer location. Accommodate its old and new layout.
    for name in ('setuptools._distutils.compilers.C.msvc',
                 'setuptools._distutils._msvccompiler'):
        try:
            module = importlib.import_module(name)
            finder = getattr(module, '_find_vcvarsall', None)
            if finder is not None:
                location, _ = finder('x64')
                if location and Path(location).is_file():
                    return Path(location)
        except (ImportError, OSError, RuntimeError):
            continue
    return None


def _windows_build_environment(environment: dict[str, str]) -> dict[str, str]:
    # Environment names are case-insensitive on Windows, including those
    # returned by vcvarsall (which mixes PATH, Path and other spellings).
    environment = {key.upper(): value for key, value in environment.items()}
    configured = shutil.which('cl.exe', path=environment.get('PATH', ''))
    if not (configured and environment.get('INCLUDE') and environment.get('LIB')):
        script = _find_vcvarsall(environment)
        if script is None:
            raise RuntimeError(
                'MSVC C++ compiler was not found. Install Visual Studio Build Tools '
                'with Desktop development with C++, or run from an x64 Developer Command Prompt.')
        # Use cmd's Unicode output so non-ASCII installation paths survive.
        # The command contains only the discovered, quoted batch-file path.
        command = f'"{environment.get("COMSPEC", "cmd.exe")}" /d /u /s /c ""{script}" x64 >nul && set"'
        try:
            result = subprocess.run(command, env=environment, capture_output=True,
                                    timeout=60, check=True)
        except (OSError, subprocess.SubprocessError) as error:
            raise RuntimeError(f'Could not initialize the MSVC x64 environment using {script}') from error
        discovered = {}
        for line in result.stdout.decode('utf-16le', errors='replace').splitlines():
            key, separator, value = line.partition('=')
            if key and separator:
                discovered[key.upper()] = value
        environment.update(discovered)
        if not shutil.which('cl.exe', path=environment.get('PATH', '')):
            raise RuntimeError(f'MSVC environment did not provide cl.exe: {script}')
    # PyTorch otherwise asks distutils to activate a second VS environment.
    environment['DISTUTILS_USE_SDK'] = '1'
    environment['MSSDK'] = '1'
    return environment


def _build_environment(root: Path, architecture: str) -> tuple[dict[str, str], dict]:
    environment = dict(os.environ)
    if os.name == 'nt':
        environment = {key.upper(): value for key, value in environment.items()}
    cuda_home = environment.get('CUDA_HOME')
    if not cuda_home and (root / '.cuda/Library').is_dir():
        cuda_home = str(root / '.cuda/Library')
    if not cuda_home:
        cuda_home = environment.get('CUDA_PATH')
    if not cuda_home:
        nvcc = shutil.which('nvcc', path=environment.get('PATH', ''))
        if nvcc:
            cuda_home = str(Path(nvcc).parent.parent)
    if not cuda_home:
        raise RuntimeError('CUDA toolkit was not found. Set CUDA_HOME to a toolkit with nvcc, '
                           'or install the project toolkit in .cuda/Library.')
    toolkit = Path(cuda_home).expanduser().resolve()
    nvcc = toolkit / 'bin' / ('nvcc.exe' if os.name == 'nt' else 'nvcc')
    if not nvcc.is_file() or not (toolkit / 'include/cuda_runtime.h').is_file():
        raise RuntimeError(f'CUDA_HOME is incomplete: {toolkit}; nvcc and include/cuda_runtime.h are required.')
    environment['CUDA_HOME'] = str(toolkit)
    if os.name == 'nt':
        environment = _windows_build_environment(environment)
    elif not shutil.which(environment.get('CXX', 'c++'), path=environment.get('PATH', '')):
        raise RuntimeError('A C++ compiler was not found. Install a C++17 compiler or set CXX.')
    # Do this after toolchain activation: inherited fat, +PTX or other-GPU
    # settings must never broaden the explicitly selected native target.
    environment['TORCH_CUDA_ARCH_LIST'] = architecture
    environment['DLSSNR_BUILD_MODE'] = 'split'
    environment.setdefault('MAX_JOBS', '2')
    if environment.get('DLSSNR_PTXAS_PATH'):
        assembler = Path(environment['DLSSNR_PTXAS_PATH']).expanduser().resolve()
        if not assembler.is_file():
            raise RuntimeError(f'DLSSNR_PTXAS_PATH does not exist: {assembler}')
        environment['DLSSNR_PTXAS_PATH'] = str(assembler)
    selected = {key: environment[key] for key in (
        'CUDA_HOME', 'DLSSNR_PTXAS_PATH', 'MAX_JOBS', 'TORCH_CUDA_ARCH_LIST', 'DLSSNR_BUILD_MODE')
        if key in environment}
    selected['nvcc'] = str(nvcc)
    return environment, selected


def _stop_build(process: subprocess.Popen) -> None:
    """Stop child interpreters or compilers too, including on timeout or Ctrl-C."""
    if process.poll() is not None:
        return
    if os.name == 'nt':
        try:
            subprocess.run(['taskkill', '/PID', str(process.pid), '/T', '/F'],
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=30, check=True)
        finally:
            if process.poll() is None:
                process.kill()
    else:
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
    if process.poll() is None:
        process.kill()
    process.wait(timeout=30)


def _run_build(command: list[str], root: Path, environment: dict[str, str],
               log_path: Path, timeout_seconds: float,
               progress: Callable[[str], None] | None) -> int:
    started = time.monotonic()
    with log_path.open('a', encoding='utf-8') as log:
        process = subprocess.Popen(
            command, cwd=root, env=environment, stdout=log, stderr=subprocess.STDOUT,
            start_new_session=os.name != 'nt',
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == 'nt' else 0)
        try:
            while True:
                remaining = timeout_seconds - (time.monotonic() - started)
                if remaining <= 0:
                    raise TimeoutError(f'CUDA build exceeded {timeout_seconds:g} seconds')
                try:
                    return process.wait(timeout=min(30, remaining))
                except subprocess.TimeoutExpired:
                    if progress:
                        progress(f'Building CUDA extension: {time.monotonic() - started:.0f}s elapsed; log: {log_path}')
        except BaseException:
            _stop_build(process)
            raise


def _print_progress(message: str) -> None:
    print(message, flush=True)


def ensure_extension(device=None, *, root: Path | None = None, rebuild: bool = False,
                     progress: Callable[[str], None] | None = _print_progress,
                     timeout_seconds: float = 3600) -> ExtensionBuild:
    """Reuse a compatible library or build only the selected device's native SM.

    CUDA_HOME, DLSSNR_PTXAS_PATH and MAX_JOBS retain caller selections. The
    architecture and split build mode deliberately override inherited values.
    Build output and a JSON receipt remain in build/speed, including on failure.
    """
    if not math.isfinite(timeout_seconds) or timeout_seconds <= 0:
        raise ValueError('Build timeout must be a positive finite number')
    import torch
    if not torch.cuda.is_available():
        raise RuntimeError('Speed testing requires a CUDA-enabled PyTorch installation and a visible NVIDIA GPU.')
    major, minor = torch.cuda.get_device_capability(device)
    device_sm = major * 10 + minor
    if device_sm < 80:
        raise RuntimeError(f'SM{device_sm} is unsupported: deployment FP16 requires SM80+, FP8 requires SM89+.')
    root = ROOT if root is None else Path(root).expanduser().resolve()
    architecture = f'{major}.{minor}'
    receipt = dict(device_sm=device_sm, architecture=architecture,
                   python=sys.executable, built=False)
    if not rebuild:
        try:
            binary = _binary.extension_path(device)
            architectures = _probe_extension(binary, root, device_sm)
        except ProbeCleanupError:
            raise
        except (RuntimeError, OSError, ImportError) as error:
            receipt['reuse_failure'] = str(error)
            if progress:
                progress(f'No usable deployment binary for SM{device_sm}; preparing a native build.')
        else:
            receipt.update(status='reused', binary_path=binary,
                           compiled_architectures=architectures)
            if progress:
                progress(f'Using deployment binary: {binary}')
            return ExtensionBuild(binary, False, receipt)
    stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
    directory = root / 'build/speed' / f'sm{device_sm}-{stamp}-{os.getpid()}'
    directory.mkdir(parents=True, exist_ok=False)
    log_path = directory / 'build.log'
    receipt_path = directory / 'receipt.json'
    # A fresh object directory also makes --rebuild meaningful with Ninja,
    # whose incremental cache does not observe setuptools' --force flag.
    command = [sys.executable, 'setup.py', 'build_ext', '--inplace', '--force',
               '--build-temp', str(directory / 'objects')]
    receipt.update(status='building', command=command, log_path=str(log_path),
                   receipt_path=str(receipt_path), started_at=stamp)
    log_path.write_text('Command: ' + subprocess.list2cmdline(command) + '\n', encoding='utf-8')

    def save_receipt():
        receipt_path.write_text(json.dumps(receipt, indent=2) + '\n', encoding='utf-8')

    started = time.monotonic()
    try:
        environment, selected = _build_environment(root, architecture)
        receipt['build_environment'] = selected
        save_receipt()
        if progress:
            progress(f'Building native SM{device_sm} extension with {sys.executable}; log: {log_path}')
        returncode = _run_build(command, root, environment, log_path, timeout_seconds, progress)
        receipt['returncode'] = returncode
        if returncode:
            raise RuntimeError(f'CUDA extension build exited with status {returncode}')
        importlib.invalidate_caches()
        binary = _binary.extension_path(device)
        if not Path(binary).name.startswith(f'_C_sm{device_sm}.'):
            raise RuntimeError(f'Build did not produce the requested SM{device_sm} split library: {binary}')
        architectures = _probe_extension(binary, root, device_sm)
        if architectures != [device_sm]:
            raise RuntimeError(f'Build metadata {architectures} differs from the requested native SM{device_sm}')
        receipt.update(status='built', built=True, binary_path=binary,
                       compiled_architectures=architectures)
    except BaseException as error:
        receipt.update(status='failed', error=str(error), elapsed_seconds=time.monotonic() - started)
        with log_path.open('a', encoding='utf-8') as log:
            log.write('\nBuild failed: ' + str(error) + '\n')
        save_receipt()
        if isinstance(error, (KeyboardInterrupt, SystemExit)):
            raise
        raise RuntimeError(f'{error}. Build log: {log_path}; receipt: {receipt_path}') from error
    receipt['elapsed_seconds'] = time.monotonic() - started
    save_receipt()
    if progress:
        progress(f'CUDA extension ready: {binary}')
    return ExtensionBuild(binary, True, receipt, str(log_path), str(receipt_path))
