"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
from .vendor_benchmark import VendorModule, guarded_tensor, sha256, GUARD_BYTES


class FunctionLease:
    def __init__(self, resources, function):
        self._resources,self._function=resources,function

    @property
    def attributes(self):
        self._resources.require_open()
        return self._function.attributes

    @property
    def lib(self):
        self._resources.require_open()
        return self._function.lib

    @property
    def stream(self):
        self._resources.require_open()
        return self._function.stream

    def call(self,name,*args):
        self._resources.require_open()
        return self._function.call(name,*args)

    def launch(self,parameters,spec):
        self._resources.require_open()
        return self._function.launch(parameters,spec)

    def active_blocks_per_sm(self,*args):
        self._resources.require_open()
        return self._function.active_blocks_per_sm(*args)

    def close(self):
        # The borrowed function remains usable by another case/graph.
        pass


class CaseIndexCache:
    """Keep each logical-to-physical map alive and upload it once per case."""
    def __init__(self,upload):
        self.upload=upload
        self._indices={}

    def get(self,index):
        entry=self._indices.get(id(index))
        if entry is None:
            entry=(index,self.upload(index))
            self._indices[id(index)]=entry
        return entry[1]

    def clear(self):
        self._indices.clear()


class CaseLayouts:
    """Immutable spatial maps shared by nodes of one geometry, never globally."""
    def __init__(self):self._maps={}

    def get(self,layout,height,width,channels):
        key=(layout,height,width,channels)
        if key not in self._maps:
            if layout=="tile":
                from .vendor_window_benchmark import image_offsets
                value=image_offsets(height,width,channels)
            elif layout=="plane":
                from .vendor_downsample_probe import down_offsets
                value=down_offsets(height,width,channels)
            elif layout=="token":
                from .vendor_benchmark import output_offsets
                value=output_offsets(height*width,channels).reshape(height,width,channels)
            else:raise ValueError("unreviewed native layout")
            value.setflags(write=False)
            self._maps[key]=value
        return self._maps[key]

    def stats(self):
        return {"maps":len(self._maps),"cpu_index_bytes":sum(value.nbytes for value in self._maps.values())}

    def clear(self):self._maps.clear()


def initialize_buffers(initial,device,*,resources=None,borrowed=None,expected_bytes=None):
    """Bind existing guarded producers before a node's first native launch.

    Borrowed tuples retain the entire producer tensor, including its guards.
    The producer must already exist and outlive all consumer graph replays.
    Only input/skip may be borrowed; mutable outputs/scratch/counters stay owned.
    """
    borrowed={} if borrowed is None else dict(borrowed)
    expected_bytes={} if expected_bytes is None else expected_bytes
    if not set(borrowed)<=set(initial) or not set(borrowed)<={"input","skip"}:
        raise ValueError("only declared native input/skip buffers may be borrowed")
    device_index=device if isinstance(device,int) else device.index
    for name,(tensor,pointer) in borrowed.items():
        minimum=expected_bytes.get(name)
        if type(minimum) is not int or minimum<1 or initial[name] is not None:
            raise ValueError("borrowed input needs an explicit positive byte extent and no initializer")
        if (not tensor.is_cuda or tensor.device.index!=device_index or str(tensor.dtype)!="torch.uint8"
                or tensor.ndim!=1 or not tensor.is_contiguous() or tensor.element_size()!=1):
            raise ValueError("borrowed native input must be a contiguous guarded CUDA byte allocation on this device")
        if tensor.numel()<minimum+2*GUARD_BYTES or pointer!=tensor.data_ptr()+GUARD_BYTES:
            raise ValueError("borrowed native input does not cover the guarded extent")
    fresh={name:data for name,data in initial.items() if name not in borrowed}
    if any(data is None for data in fresh.values()):raise ValueError("missing borrowed native input binding")
    owned=resources.allocations(fresh) if resources is not None else {name:guarded_tensor(data,device) for name,data in fresh.items()}
    return {name:borrowed[name] if name in borrowed else owned[name] for name in initial}


class NativeResources:
    def __init__(self,device,stream,*,module_factory=VendorModule,allocate=guarded_tensor):
        self.device,self.stream=device,stream
        self._module_factory,self._allocate=module_factory,allocate
        self._owners,self._functions,self._weights={},{},{}
        self._bytes_identity={}
        self._golden={}
        self.closed=False

    def require_open(self):
        if self.closed:raise RuntimeError("native runner resources are closed")

    def digest(self,data):
        if not isinstance(data,bytes):raise TypeError("cached original artifacts must be immutable bytes")
        entry=self._bytes_identity.get(id(data))
        if entry is None:
            entry=(data,sha256(data))
            self._bytes_identity[id(data)]=entry
        return entry[1]

    def module(self,cubin,kernel,parameter_bytes):
        self.require_open()
        digest=self.digest(cubin)
        key=(digest,kernel,parameter_bytes)
        if key not in self._functions:
            owner=self._owners.get(digest)
            arguments={} if owner is None else {"shared_module":owner}
            function=self._module_factory(cubin,self.stream.cuda_stream,kernel,parameter_bytes,**arguments)
            if owner is None:self._owners[digest]=function
            self._functions[key]=function
        return FunctionLease(self,self._functions[key])

    def allocations(self,initial):
        self.require_open()
        result={}
        for name,data in initial.items():
            if name.startswith("weight"):
                digest=self.digest(data)
                if digest not in self._weights:
                    allocation=self._allocate(data,self.device)
                    self._weights[digest]=allocation
                    tensor=allocation[0]
                    self._golden[id(tensor)]=tensor[GUARD_BYTES:-GUARD_BYTES].clone()
                result[name]=self._weights[digest]
            else:
                result[name]=self._allocate(data,self.device)
        return result

    def immutable_reference(self,tensor):
        self.require_open()
        return self._golden[id(tensor)] if id(tensor) in self._golden else tensor[GUARD_BYTES:-GUARD_BYTES].clone()

    def stats(self):
        return {"loaded_cubins":len(self._owners),"bound_functions":len(self._functions),"guarded_weight_records":len(self._weights)}

    def close(self):
        if self.closed:return
        # Synchronize before unloading code or releasing tensor references.
        self.stream.synchronize()
        owners={id(function) for function in self._owners.values()}
        for function in self._functions.values():
            if id(function) not in owners:function.close()
        for owner in self._owners.values():owner.close()
        self._functions.clear();self._owners.clear();self._weights.clear()
        self._golden.clear();self._bytes_identity.clear()
        self.closed=True
