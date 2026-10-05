"""Normal source build: one CUDA translation unit per exported kernel.

This is an SM120-only deployment extension. It registers Torch operators and
classes; it deliberately has no Python PyInit entry point.
"""
import os
import json
import sys
from pathlib import Path
from setuptools import setup, find_packages

ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from tuning.resolution_policy import combine, cpp_header, verify_receipts
# Match offline codegen: device tags validate each input file, then the merged
# policy supplies the stable version and C++ selection table.
policy=combine([verify_receipts(json.loads((ROOT/'tuning/sm_120.json').read_text()),ROOT)])
generated=cpp_header(policy)
policy_header=ROOT/'csrc/kernel_launcher/compiled_resolution_policy.h'
if not policy_header.is_file() or policy_header.read_text()!=generated:
    policy_header.write_text(generated,encoding='utf8',newline='\n')
local_cuda=ROOT/'.cuda/Library'
if not os.environ.get('CUDA_HOME') and local_cuda.is_dir():
    os.environ['CUDA_HOME']=str(local_cuda)
os.environ.setdefault('TORCH_CUDA_ARCH_LIST','12.0')
if os.environ['TORCH_CUDA_ARCH_LIST'].strip()!='12.0':
    raise RuntimeError('Reconstructed device bodies currently require TORCH_CUDA_ARCH_LIST=12.0 (SM120).')
from torch.utils.cpp_extension import BuildExtension, CUDAExtension
from tuning.cuda_toolchain import prepare_cuda_assembler

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

cuda=sorted((ROOT/'csrc/kernel_impl').glob('*.cu'))
host=sorted((ROOT/'csrc/kernel_launcher').glob('*.cpp')) + sorted((ROOT/'csrc/torch_api').glob('*.cpp'))
if len(cuda)!=81 or not host or list((ROOT/'csrc/kernel_launcher').glob('*.cu')):
    raise RuntimeError('Expected 81 named kernel implementation TUs and host-only launchers.')

setup(name='dlssnr',version='0.1.0',description='Reconstructed SM120 CUDA deployment',
    packages=find_packages(),
    # Relative source paths keep setuptools object/dependency paths within
    # Windows compiler limits when building from an isolated workspace.
    ext_modules=[CUDAExtension('dlssnr._C',sources=[p.relative_to(ROOT).as_posix() for p in [*cuda,*host]],
        include_dirs=[str(ROOT/'csrc')],
        library_dirs=cuda_library_dirs,
        extra_compile_args={'cxx':['/O2','/std:c++17'] if os.name=='nt' else ['-O3','-std=c++17'],
                            # PyTorch's flag scan treats any "arch" substring
                            # (including a toolkit path) as an explicit target.
                            # State our already-validated SM120 target directly.
                            'nvcc':[*assembler_flags,'-gencode=arch=compute_120,code=sm_120',
                                    '-O3','-lineinfo','--expt-relaxed-constexpr','-Xptxas=-v']})],
    cmdclass={'build_ext':RegistrationOnlyBuildExtension},zip_safe=False)
