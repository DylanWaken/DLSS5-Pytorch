"""CUDA Driver image fixture for native preprocessing/postprocessing tests.

Structures follow CUDA 13.4 cuda.h on 64-bit Windows. This module imports no
Torch and performs no CUDA calls until CudaImage is explicitly constructed.
Arrays are float32 RGBA with normalized clamp coordinates; tests select point or linear sampling.
No kernel is compiled or modified by this helper.
"""
from __future__ import annotations

import ctypes as C


class ArrayDescriptor(C.Structure):
    _fields_=[("Width",C.c_size_t),("Height",C.c_size_t),("Depth",C.c_size_t),
              ("Format",C.c_int),("NumChannels",C.c_uint),("Flags",C.c_uint)]


class ResourceUnion(C.Union):
    _fields_=[("array",C.c_void_p),("reserved",C.c_int*32)]


class ResourceDescriptor(C.Structure):
    _fields_=[("resType",C.c_int),("res",ResourceUnion),("flags",C.c_uint)]


class TextureDescriptor(C.Structure):
    _fields_=[("addressMode",C.c_int*3),("filterMode",C.c_int),("flags",C.c_uint),
              ("maxAnisotropy",C.c_uint),("mipmapFilterMode",C.c_int),
              ("mipmapLevelBias",C.c_float),("minMipmapLevelClamp",C.c_float),
              ("maxMipmapLevelClamp",C.c_float),("borderColor",C.c_float*4),
              ("reserved",C.c_int*12)]


class Copy2D(C.Structure):
    _fields_=[("srcXInBytes",C.c_size_t),("srcY",C.c_size_t),("srcMemoryType",C.c_int),
              ("srcHost",C.c_void_p),("srcDevice",C.c_uint64),("srcArray",C.c_void_p),
              ("srcPitch",C.c_size_t),("dstXInBytes",C.c_size_t),("dstY",C.c_size_t),
              ("dstMemoryType",C.c_int),("dstHost",C.c_void_p),("dstDevice",C.c_uint64),
              ("dstArray",C.c_void_p),("dstPitch",C.c_size_t),
              ("WidthInBytes",C.c_size_t),("Height",C.c_size_t)]


class CudaImage:
    """Own an RGBA32F CUDA array, surface and optional normalized texture.

    `driver` is an already verified VendorModule, providing the existing Torch
    context/stream and checked CUDA error handling. Image copies are queued on
    that same stream. Keep source/destination tensors alive until synchronization.
    """
    def __init__(self,driver,height,width,device,*,texture=True,linear=False):
        if C.sizeof(C.c_void_p)!=8:raise RuntimeError("64-bit CUDA Driver ABI required")
        if any(type(v) is not int or not 1<=v<=8192 for v in (height,width)):
            raise ValueError("bounded image extent must be1..8192")
        self.driver,self.height,self.width,self.device=driver,height,width,device
        self.array=C.c_void_p();self.surface=C.c_uint64();self.texture=C.c_uint64()
        declarations={
            "cuArray3DCreate_v2":[C.POINTER(C.c_void_p),C.POINTER(ArrayDescriptor)],
            "cuArrayDestroy":[C.c_void_p],
            "cuSurfObjectCreate":[C.POINTER(C.c_uint64),C.POINTER(ResourceDescriptor)],
            "cuSurfObjectDestroy":[C.c_uint64],
            "cuTexObjectCreate":[C.POINTER(C.c_uint64),C.POINTER(ResourceDescriptor),C.POINTER(TextureDescriptor),C.c_void_p],
            "cuTexObjectDestroy":[C.c_uint64],
            "cuMemcpy2DAsync_v2":[C.POINTER(Copy2D),C.c_void_p],
            "cuStreamSynchronize":[C.c_void_p],
        }
        for name,args in declarations.items():
            function=getattr(driver.lib,name)
            function.argtypes,function.restype=args,C.c_int
        try:
            # CU_AD_FORMAT_FLOAT,4channels,CUDA_ARRAY3D_SURFACE_LDST.
            descriptor=ArrayDescriptor(width,height,0,0x20,4,2)
            driver.call("cuArray3DCreate_v2",C.byref(self.array),C.byref(descriptor))
            resource=ResourceDescriptor();resource.res.array=self.array
            driver.call("cuSurfObjectCreate",C.byref(self.surface),C.byref(resource))
            if texture:
                td=TextureDescriptor()
                td.addressMode[:]=(1,1,1) # CU_TR_ADDRESS_MODE_CLAMP.
                td.filterMode=int(linear) # CU_TR_FILTER_MODE_POINT=0, LINEAR=1.
                td.flags=2 # CU_TRSF_NORMALIZED_COORDINATES.
                driver.call("cuTexObjectCreate",C.byref(self.texture),C.byref(resource),C.byref(td),None)
        except BaseException:
            self.close()
            raise

    def _check_tensor(self,tensor):
        import torch
        if (tensor.device!=torch.device("cuda",self.device) or tensor.dtype!=torch.float32
                or tuple(tensor.shape)!=(self.height,self.width,4) or not tensor.is_contiguous()):
            raise ValueError("image copy requires contiguous float32[H,W,4] on the selected CUDA device")

    def copy_from(self,tensor):
        self._check_tensor(tensor)
        copy=Copy2D();copy.srcMemoryType=2;copy.srcDevice=tensor.data_ptr();copy.srcPitch=self.width*16
        copy.dstMemoryType=3;copy.dstArray=self.array
        copy.WidthInBytes=self.width*16;copy.Height=self.height
        self.driver.call("cuMemcpy2DAsync_v2",C.byref(copy),self.driver.stream)

    def copy_to(self,tensor):
        self._check_tensor(tensor)
        copy=Copy2D();copy.srcMemoryType=3;copy.srcArray=self.array
        copy.dstMemoryType=2;copy.dstDevice=tensor.data_ptr();copy.dstPitch=self.width*16
        copy.WidthInBytes=self.width*16;copy.Height=self.height
        self.driver.call("cuMemcpy2DAsync_v2",C.byref(copy),self.driver.stream)

    def copy_top_left_from(self,tensor):
        """Copy a contiguous RGBA subrectangle without touching guard borders."""
        import torch
        if (tensor.device!=torch.device("cuda",self.device) or tensor.dtype!=torch.float32
                or tensor.dim()!=3 or tensor.size(2)!=4 or not tensor.is_contiguous()
                or not 0<tensor.size(0)<=self.height or not 0<tensor.size(1)<=self.width):
            raise ValueError("surface region must be contiguous float32[H,W,4] within its CUDA array")
        copy=Copy2D();copy.srcMemoryType=2;copy.srcDevice=tensor.data_ptr();copy.srcPitch=tensor.size(1)*16
        copy.dstMemoryType=3;copy.dstArray=self.array
        copy.WidthInBytes=tensor.size(1)*16;copy.Height=tensor.size(0)
        self.driver.call("cuMemcpy2DAsync_v2",C.byref(copy),self.driver.stream)

    def close(self):
        if self.array or self.surface or self.texture:
            self.driver.call("cuStreamSynchronize",self.driver.stream)
        if self.texture:
            self.driver.call("cuTexObjectDestroy",self.texture);self.texture=C.c_uint64()
        if self.surface:
            self.driver.call("cuSurfObjectDestroy",self.surface);self.surface=C.c_uint64()
        if self.array:
            self.driver.call("cuArrayDestroy",self.array);self.array=C.c_void_p()
