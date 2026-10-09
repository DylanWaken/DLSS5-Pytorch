"""Shared C++17 fixture compiler for CPU tests of production headers."""
import os
from pathlib import Path
import shutil
import subprocess
import unittest


def compile_cpp(source, executable, *, include_dirs=()):
    directory = source.parent
    # Prefer a compiler already configured by the caller. A fresh Windows
    # terminal can locate Visual Studio without requiring CUDA or Torch.
    compiler = next((shutil.which(name) for name in ("c++", "g++", "clang++")
                     if shutil.which(name)), None)
    if compiler:
        command = [compiler, "-std=c++17", "-O2", "-DNDEBUG", *["-I"+str(path) for path in include_dirs], str(source), "-o", str(executable)]
    else:
        compiler = shutil.which("cl")
        if compiler:
            command = [compiler, "/nologo", "/std:c++17", "/O2", "/DNDEBUG", "/EHsc", "/MT",
                       *["/I"+str(path) for path in include_dirs], str(source), f"/Fe:{executable}"]
        elif os.name == "nt":
            installer = Path(os.environ.get("ProgramFiles(x86)", "C:/Program Files (x86)"))
            locator = installer / "Microsoft Visual Studio/Installer/vswhere.exe"
            if not locator.is_file():
                raise unittest.SkipTest("C++17 compiler unavailable; production policy was not compiled")
            found = subprocess.run(
                [str(locator), "-latest", "-products", "*", "-requires",
                 "Microsoft.VisualStudio.Component.VC.Tools.x86.x64", "-property", "installationPath"],
                check=True, capture_output=True, text=True, timeout=30).stdout.strip()
            setup = Path(found) / "VC/Auxiliary/Build/vcvars64.bat"
            if not found or not setup.is_file():
                raise unittest.SkipTest("Visual Studio C++ toolchain unavailable")
            batch = directory / "compile.cmd"
            includes = " ".join(f'/I"{path}"' for path in include_dirs)
            batch.write_text(
                '@echo off\n'
                f'call "{setup}" >nul\n'
                'if errorlevel 1 exit /b 1\n'
                f'cl /nologo /std:c++17 /O2 /DNDEBUG /EHsc /MT {includes} "{source}" /Fe:"{executable}"\n'
                'exit /b %errorlevel%\n', encoding="utf-8")
            command = [os.environ.get("COMSPEC", "cmd.exe"), "/d", "/c", str(batch)]
        else:
            raise unittest.SkipTest("C++17 compiler unavailable; production policy was not compiled")

    result = subprocess.run(command, cwd=directory, capture_output=True, text=True, timeout=90)
    if result.returncode:
        raise RuntimeError("Production C++ fixture did not compile:\n" + result.stdout + result.stderr)
    return executable
