"""Build architecture-specific CUDA libraries, or one multi-architecture library.

FP16 requires SM80+, FP8 requires SM89+. Libraries register Torch operators and
classes directly, without Python PyInit entry points.
"""
import os
import json
import sys
from pathlib import Path
from setuptools import setup, find_packages

ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from tuning.resolution_policy import combine, cpp_header, verify_receipts
from tuning.build_config import parse_targets, library_targets
# Match offline codegen: device tags validate each input file, then the merged
# policy supplies the stable version and C++ selection table.
policy=combine([verify_receipts(json.loads(path.read_text(encoding='utf8')),ROOT)
                for path in sorted((ROOT/'tuning').glob('sm_*.json'))])
generated=cpp_header(policy)
policy_header=ROOT/'csrc/kernel_launcher/compiled_resolution_policy.h'
if not policy_header.is_file() or policy_header.read_text(encoding='utf8')!=generated:
    policy_header.write_text(generated,encoding='utf8',newline='\n')
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

    def build_extension(self, ext):
        # Identical source paths must not reuse objects from another target or
        # host metadata definition when several libraries are built together.
        original_temp=self.build_temp
        self.build_temp=str(Path(original_temp)/ext.name.rsplit('.',1)[-1])
        try:
            super().build_extension(ext)
        finally:
            self.build_temp=original_temp

cuda=sorted((ROOT/'csrc/kernel_impl').rglob('*.cu'))
host=sorted((ROOT/'csrc/kernel_launcher').glob('*.cpp')) + sorted((ROOT/'csrc/torch_api').glob('*.cpp'))
templates=json.loads((ROOT/'csrc/kernel_impl/shared/common/kernel_templates.json').read_text(encoding='utf8'))['entries']
expected_units=81-len(templates)+len({entry['source'] for entry in templates})
if len(cuda)!=expected_units or not host or list((ROOT/'csrc/kernel_launcher').glob('*.cu')):
    raise RuntimeError(f'Expected {expected_units} global-body TUs for 81 logical kernels and host-only launchers.')

setup(name='dlssnr',version='0.1.0',description='Reconstructed CUDA deployment for SM80+ FP16 and SM89+ FP8',
    packages=find_packages(),
    # Relative source paths keep setuptools object/dependency paths within
    # Windows compiler limits when building from an isolated workspace.
    ext_modules=[CUDAExtension(name,sources=[p.relative_to(ROOT).as_posix() for p in [*cuda,*host]],
        include_dirs=[str(ROOT/'csrc')],
        library_dirs=cuda_library_dirs,
        extra_compile_args={'cxx':(['/O2','/std:c++17'] if os.name=='nt' else ['-O3','-std=c++17']) +
                                  ['-DDLSSNR_BUILD_ARCHITECTURES='+','.join(str(target.sm) for target in binary_targets)],
                            # PyTorch's flag scan treats any "arch" substring
                            # (including a toolkit path) as an explicit target.
                            # Supply every requested target explicitly.
                            'nvcc':[*assembler_flags,*(flag for target in binary_targets for flag in target.nvcc_flags),
                                    '-O3','-lineinfo','--expt-relaxed-constexpr','-Xptxas=-v']})
                 for name,binary_targets in libraries],
    cmdclass={'build_ext':RegistrationOnlyBuildExtension},zip_safe=False)
