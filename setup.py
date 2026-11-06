"""Build architecture-specific CUDA libraries, or one multi-architecture library.

FP16 requires SM80+, FP8 requires SM89+. Libraries register Torch operators and
classes directly, without Python PyInit entry points.
"""
import os
import sys
from pathlib import Path
from setuptools import setup, find_packages

ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from dlssnr.build.native import (cuda_sources, cxx_standard_flags,
                                 expected_cuda_units, host_sources,
                                 include_directories, native_dependencies,
                                 nvcc_standard_flags)
from dlssnr.build.resolution import prepare_policy_header
from dlssnr.build.targets import parse_targets, library_targets
# Match offline codegen: validate each device policy and its referenced receipt
# bytes, merge them, and refresh the C++ header before any build work. Unchanged
# bytes keep the header's timestamp, so a caller's earlier fingerprint remains
# valid when setup runs inside the same build.
prepare_policy_header(ROOT)
local_cuda=ROOT/'.cuda/Library'
if not os.environ.get('CUDA_HOME') and local_cuda.is_dir():
    os.environ['CUDA_HOME']=str(local_cuda)
if not os.environ.get('TORCH_CUDA_ARCH_LIST'):
    import torch
    if not torch.cuda.is_available():
        raise RuntimeError('Set TORCH_CUDA_ARCH_LIST for a build without a visible CUDA device (e.g. 8.0;8.6;8.9;12.0).')
    os.environ['TORCH_CUDA_ARCH_LIST']=';'.join(sorted({
        '.'.join(map(str,torch.cuda.get_device_capability(index))) for index in range(torch.cuda.device_count())}))
targets=parse_targets(os.environ['TORCH_CUDA_ARCH_LIST'])
libraries=library_targets(targets,os.environ.get('DLSSNR_BUILD_MODE','split'))
from torch.utils.cpp_extension import BuildExtension, CUDAExtension
from dlssnr.build.toolchain import prepare_cuda_assembler

# Optional newer assembler for SM120 instruction scheduling. The compiler,
# headers, libdevice and runtime stay with CUDA_HOME; no PyTorch version check
# is bypassed. The private backend cache records executable identities.
assembler_flags=[]
if os.environ.get('DLSSNR_PTXAS_PATH'):
    if not os.environ.get('CUDA_HOME'):
        raise RuntimeError('Set CUDA_HOME when selecting DLSSNR_PTXAS_PATH.')
    assembler=prepare_cuda_assembler(os.environ['CUDA_HOME'],ROOT/'build/ptxas_backend')
    os.environ['PATH']=assembler.environment()['PATH']
    assembler_flags=list(assembler.nvcc_flags)

# Conda CUDA places import libraries in lib; the Windows CUDA installer uses
# lib/x64, which CUDAExtension already adds. Support either installed layout.
cuda_library_dirs=[]
cuda_home=Path(os.environ['CUDA_HOME']) if os.environ.get('CUDA_HOME') else None
if os.name=='nt' and cuda_home and (cuda_home/'lib/cudart.lib').is_file():
    cuda_library_dirs.append(str(cuda_home/'lib'))

class RegistrationOnlyBuildExtension(BuildExtension):
    def get_export_symbols(self, ext):
        # setuptools otherwise synthesizes /EXPORT:PyInit__C on Windows.
        return []

    def build_extension(self, ext):
        # Identical source paths must not reuse objects from another target or
        # host metadata definition when several libraries are built together.
        original_temp=self.build_temp
        self.build_temp=str(Path(original_temp)/ext.name.rsplit('.',1)[-1])
        try:
            super().build_extension(ext)
        finally:
            self.build_temp=original_temp

cuda=list(cuda_sources(ROOT))
host=list(host_sources(ROOT))
expected_units=expected_cuda_units(ROOT)
if len(cuda)!=expected_units or not host or list((ROOT/'csrc/kernel_launcher').glob('*.cu')):
    raise RuntimeError(f'Expected {expected_units} global-body TUs for 83 logical kernels and host-only launchers.')
# Nested FlashLight/ABI/common headers and generated launch tables participate
# in setuptools' up-to-date check in addition to compiler depfiles.
depends=[path.relative_to(ROOT).as_posix() for path in native_dependencies(ROOT)]

setup(name='dlssnr-pytorch',version='0.1.0',description='Reconstructed CUDA deployment for SM80+ FP16 and SM89+ FP8',
    packages=find_packages(include=['dlssnr','dlssnr.*']),
    include_package_data=True,
    # Relative source paths keep setuptools object/dependency paths within
    # Windows compiler limits when building from an isolated workspace.
    ext_modules=[CUDAExtension(name,sources=[p.relative_to(ROOT).as_posix() for p in [*cuda,*host]],
        include_dirs=list(include_directories(ROOT)),
        depends=depends,
        library_dirs=cuda_library_dirs,
        extra_compile_args={'cxx':((['/O2'] if os.name=='nt' else ['-O3']) +
                                  cxx_standard_flags(os.name) +
                                  ['-DDLSSNR_BUILD_ARCHITECTURES='+','.join(str(target.sm) for target in binary_targets)]),
                            # PyTorch's flag scan treats any "arch" substring
                            # (including a toolkit path) as an explicit target.
                            # Supply every requested target explicitly.
                            'nvcc':[*assembler_flags,*(flag for target in binary_targets for flag in target.nvcc_flags),
                                    '-O3','-lineinfo','--expt-relaxed-constexpr','-Xptxas=-v',
                                    *nvcc_standard_flags()]})
                 for name,binary_targets in libraries],
    cmdclass={'build_ext':RegistrationOnlyBuildExtension},zip_safe=False)
