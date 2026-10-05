"""Original-only extracted reference definitions; see native-reference-transform.json.draft."""
from __future__ import annotations
from .vendor_benchmark import sha256
from .native_fused import NativeFused
from .vendor_global_block import NativeBlock
from .vendor_window512_block import NativeWindow512
from .vendor_connectors import UP512_SHA256, NativeUp512, NativeRepack

class _GeometryModule:
    @staticmethod
    def graph_schedule(geometry):
        from dlssnr.geometry import graph_schedule
        return graph_schedule(geometry)

_GEOMETRY = _GeometryModule()


class NativeTrunk:
    def __init__(self, runner, geometry, input_codes):
        import numpy as np
        validate_trunk_geometry(geometry)
        self.runner, self.geometry = runner, geometry
        self.nodes, self.blocks, self.boundaries = [], {}, {}
        from .vendor_resources import CaseLayouts
        self.layouts=CaseLayouts()
        decoder_code = runner.decoder_module
        if sha256(decoder_code) != UP512_SHA256:
            raise ValueError("original decoder cubin hash mismatch")
        schedule = _GEOMETRY.graph_schedule(geometry)
        skips, previous = {}, None
        shape_codes=lambda shape:np.broadcast_to(np.zeros((),np.uint8),shape)
        def bindings(source=None,skip=None):
            return {name:producer[0].allocations[producer[1]] for name,producer in (("input",source),("skip",skip)) if producer is not None}
        def add(name, node, source=None, skip=None):
            if source is not None:
                if node.allocations["input"] is not source[0].allocations[source[1]]:
                    raise AssertionError("native input must be bound before node construction completes")
            if skip is not None:
                if node.allocations["skip"] is not skip[0].allocations[skip[1]]:
                    raise AssertionError("native skip must be bound before node construction completes")
            self.nodes.append((name,node))
            return (node,"output")
        try:
            for entry in schedule[1:70]:
                index,c,h,w = (entry[k] for k in ("block","channels","height","width"))
                phase=entry["phase"] or 0
                if index==31:
                    bh,bw=geometry.levels[5][1],geometry.levels[5][0]
                    repack=NativeRepack(runner.modules[1024],runner.stream,runner.device,shape_codes((bh,bw,1024)),"to1d",resources=runner.resources,layouts=self.layouts,borrowed=bindings(previous))
                    previous=add("repack-30-31",repack,previous)
                elif index==39:
                    bh,bw=geometry.levels[5][1],geometry.levels[5][0]
                    repack=NativeRepack(runner.modules[1024],runner.stream,runner.device,shape_codes((bh,bw,1024)),"to2d",resources=runner.resources,layouts=self.layouts,borrowed=bindings(previous))
                    previous=add("repack-38-39",repack,previous)
                skip=skips[4] if index==39 else skips[{256:3,128:2,64:1,32:0}[c]] if index in (48,56,62,66) else None
                borrowed=bindings(previous,skip)
                if c==1024:
                    node=NativeBlock(runner.modules[c],runner.stream,runner.device,shape_codes((h*w,c)),runner.weights(index,(0,1,2,4)),
                                     token_alignment=getattr(runner,"native_token_alignment",32),attention_variant=runner.native_attention,resources=runner.resources,borrowed=borrowed)
                    index_map=self.layouts.get("token",h,w,c)
                elif index==39:
                    bh,bw=geometry.levels[5][1],geometry.levels[5][0]
                    node=NativeUp512(decoder_code,runner.stream,runner.device,shape_codes((bh,bw,1024)),shape_codes((h,w,512)),runner.weights(index,(0,))[0],resources=runner.resources,layouts=self.layouts,borrowed=borrowed)
                    index_map=node.output_offsets["output"]
                elif c==512:
                    view="input" if index==23 else "output" if index==47 else "none"
                    node=NativeWindow512(runner.modules[c],runner.stream,runner.device,shape_codes((h,w,c)),runner.weights(index,range(5) if index==30 else range(4)),phase,view=view,down=index==30,resources=runner.resources,layouts=self.layouts,borrowed=borrowed)
                    index_map=node.output_offsets["output"]
                else:
                    family="down" if index in (4,8,14,22) else "up" if index in (48,56,62,66) else "window"
                    view="input" if index in (1,5,9,15) else "output" if index in (55,61,65) else "none"
                    case=dict(family=family,block=index,channels=c,height=h,width=w,phase=phase,view=view)
                    inputs={"input":input_codes if index==1 else shape_codes((h,w,c))}
                    if family=="up":
                        level={32:0,64:1,128:2,256:3}[c]
                        lw,lh=geometry.levels[level+1]
                        inputs={"input":shape_codes((lh,lw,2*c)),"skip":shape_codes((h,w,c))}
                    node=NativeFused(runner.modules[c],runner.stream,runner.device,case,inputs,runner.weights(index,(0,))[0],resources=runner.resources,layouts=self.layouts,borrowed=borrowed)
                    index_map=node.output_offsets["output"]
                self.blocks[index]=node
                previous=add(f"block-{index}",node,previous,skip)
                self.boundaries[f"block-{index}"]=(node,"output",index_map)
                if index in (4,8,14,22,30):
                    level={4:0,8:1,14:2,22:3,30:4}[index]
                    skips[level]=previous
                    previous=(node,"down")
                    self.boundaries[f"transition-{index}-{index+1}"]=(node,"down",node.output_offsets["down"])
        except BaseException:
            self.close()
            raise

    def __call__(self):
        for _,node in self.nodes:
            node()
        return self.blocks[69].allocations["output"][0]

    def close(self):
        for _,node in reversed(self.nodes):
            node.close()
        self.nodes.clear()
        self.layouts.clear()


def validate_trunk_geometry(geometry):
    """Reject unresolved padded transitions before allocating or launching."""
    # Padded C256/C512 down and reverse-crop connectors have independent
    # native proofs. Smaller fields are exact halves throughout our domain.
    for level in range(3):
        source, target = geometry.levels[level:level+2]
        if source != tuple(2 * value for value in target):
            raise ValueError(f"padded transition at level {level} is not yet validated for resident replay")
