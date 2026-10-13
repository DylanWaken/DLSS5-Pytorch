"""Shared glossary and conservative, source-preserving prose annotations."""
from html import escape
from html.parser import HTMLParser
import re

# id, label, aliases, short hover definition, additional reading context.
GROUPS = {
    'Measurement and evidence': [
        ('ncu', 'NCU', 'Nsight Compute', 'NVIDIA’s CUDA kernel profiler. It measures compiled launch resources, hardware counters, sampled warp states and source-correlated instructions.', 'A report describes a particular GPU, binary, workload and replay protocol. It does not prove numerical correctness or track a semantic model token.'),
        ('sass', 'SASS', '', 'The machine instructions executed by NVIDIA GPU hardware after PTX compilation.', 'One PTX operation may lower to multiple SASS instructions. Dynamic opcode totals count executed warp instructions across the measured launch.'),
        ('wavefront', 'Wavefront', 'wavefronts', 'A unit of shared-memory service used by profiler counters. An instruction can require multiple service wavefronts.', 'Compare actual and ideal wavefronts for the same instrumented accesses; repeated bank numbers alone do not prove excessive service.'),
        ('replay', 'Replay', 'replays', 'Profiler re-execution used to collect metric groups that cannot all be measured in one pass.', 'Replay and cache control influence traffic and timing. Source sampling and full reports can contain different counts.'),
        ('source-correlation', 'Source correlation', 'source-correlated', 'Mapping compiled instruction addresses back to source lines using compiler line information.', 'Inlining and optimization can attribute work to a helper instead of the call site. Missing direct attribution does not prove a source step was skipped.'),
        ('pm-sampling', 'PM sampling', '', 'Periodic sampling of GPU performance counters during a kernel.', 'A timeline shows aggregate activity over sample order. It does not reveal an exact per-warp issue schedule.'),
    ],
    'Model operations and tensor coordinates': [
        ('tensor', 'Tensor', 'tensors', 'A multidimensional array. Its shape describes logical axes; its layout describes where those elements live.', 'Keep logical coordinates such as token and channel separate from physical byte addresses.'),
        ('token', 'Token', 'tokens', 'One position in the model sequence, carrying a vector of channels. In spatial stages it usually represents one feature-map pixel.', 'A window reorders spatial positions into local token indices; a repack can change their addresses without changing their values.'),
        ('channel', 'Channel', 'channels', 'One feature component of a token. C32 means that each token has 32 channels.', 'A channel is a model dimension, not a CUDA thread or memory bank.'),
        ('attention-head', 'Attention head', 'attention heads', 'A separate attention computation over a subset of feature channels, with its own query, key and value vectors.', 'Head ownership can differ from FFN ownership, which is why fused blocks exchange fragments through shared memory.'),
        ('qkv', 'QKV', '', 'Query, key and value projections: Q and K produce attention scores; the resulting weights combine V.', 'Follow the lesson equations and precision boundaries to distinguish projection, normalization, score computation and value aggregation.'),
        ('window-attention', 'Window attention', 'local attention', 'Attention restricted to tokens within one spatial window.', 'The window bounds the key/value set. Global attention instead traverses the wider token sequence.'),
        ('global-attention', 'Global attention', '', 'Attention in which a query can use keys and values across the full bottleneck token sequence.', 'The implementation streams key/value tiles and maintains accumulators across those tiles.'),
        ('ffn', 'FFN', 'feed-forward network', 'The per-token feed-forward part of a transformer: linear projections with an intervening nonlinearity.', 'Tokens do not mix through an ordinary per-token FFN. The dense, grouped and branched variants have different channel connectivity.'),
        ('dense', 'Dense', '', 'For a channel projection, every output channel can depend on every input channel.', 'Dense describes connectivity, not a guarantee about physical memory contiguity.'),
        ('grouped-ffn', 'Grouped FFN', '', 'An FFN partitioned into channel groups, each with its own smaller projection and activation path.', 'For the C512 lessons, distinguish the grouped MLPs from the dense mixing operations around them. Full-input branches in other widths have a different connectivity pattern.'),
        ('residual', 'Residual', 'residuals|residual connection|residual connections', 'A bypass value added to a transformed value, sometimes with a scale factor.', 'Trace the residual input separately: input-view variants may gather this value from a different physical layout.'),
        ('downsampling', 'Downsampling', 'downsample', 'Reducing spatial resolution so that fewer tokens represent the feature map.', 'Pooling and channel projection are separate operations even when fused. Not every downsampling-related kernel changes channel count.'),
        ('upsampling', 'Upsampling', 'upsample', 'Increasing spatial resolution, creating more output token positions from a coarser feature map.', 'The decoder lessons explain projection, spatial repetition and skip-feature merging in their actual execution order.'),
        ('normalization', 'Normalization', '', 'A transformation that rescales values using statistics or a norm over a specified axis.', 'Read the equation in each lesson: channel normalization and attention-row normalization do not use the same reduction or denominator.'),
        ('reduction', 'Reduction', 'reductions', 'Combining many values into fewer values, for example summing across channels or keys.', 'The logical reduction axis determines which lanes must exchange partial results.'),
    ],
    'Launch, ownership and matrix instructions': [
        ('kernel', 'Kernel', 'kernels', 'A GPU entry point launched over a grid of thread blocks.', 'A public template specialization may share its underlying CUDA function body with other documented entries.'),
        ('grid', 'Grid', '', 'All thread blocks belonging to one kernel launch.', 'Grid coordinates usually select independent spatial regions, windows or work packets; the exact mapping is kernel-specific.'),
        ('thread-block', 'Thread block', 'thread blocks|CTA|CTAs|CUDA block|CUDA blocks', 'A group of CUDA threads that share block-local shared memory and can synchronize with block barriers.', 'CTA means cooperative thread array. Block coordinates and thread coordinates are different parts of the launch contract.'),
        ('warp', 'Warp', 'warps', 'A group of 32 CUDA threads. Warp-level instructions coordinate participating lanes within that group.', 'A warp diagram specifies ownership and dependencies; it does not promise a particular hardware execution timeline.'),
        ('lane', 'Lane', 'lanes', 'A thread’s index from 0 to 31 within its warp.', 'Lane bits select the elements owned by that thread. One lane commonly owns several values from different logical rows or columns.'),
        ('warp-scheduling', 'Warp scheduling', '', 'Hardware selection of eligible warps to issue instructions, subject to dependencies and resource availability.', 'Assigning a warp a producer or consumer role does not force the hardware to run warps in numeric order.'),
        ('tile', 'Tile', 'tiles', 'A bounded piece of a tensor or matrix processed as a unit.', 'Distinguish a logical model window, a shared-memory tile, an MMA instruction tile and a lane-owned fragment.'),
        ('fragment', 'Fragment', 'fragments', 'The subset of a matrix tile held in a thread’s registers for a collective matrix instruction.', 'An MMA operand is distributed across the warp; no individual lane holds the whole operand matrix.'),
        ('mma', 'MMA', 'mma.sync', 'Matrix multiply-accumulate: a warp collectively computes D = A × B + C from distributed register fragments.', 'These kernels use mma.sync. Instruction shape and operand precision define the lane/register mapping; the lessons show the FP16 and FP8 mappings separately.'),
        ('tensor-core', 'Tensor Core', 'Tensor Cores', 'Specialized GPU arithmetic hardware used by matrix instructions such as MMA.', 'The kernel must first supply the required register operands. An MMA instruction does not itself gather arbitrary model tensors from global memory.'),
        ('accumulator', 'Accumulator', 'accumulators', 'A running result updated by repeated additions or multiply-accumulate instructions.', 'Its precision and ownership are part of the algorithm. These documented MMA paths use Half accumulator fragments; do not assume FP32 accumulation.'),
        ('shuffle', 'Shuffle', 'shuffles|warp shuffle|warp shuffles', 'A warp instruction that transfers a register value between participating lanes.', 'An XOR shuffle chooses the partner lane by XORing its index with a mask. It does not stage data in shared memory.'),
        ('occupancy', 'Occupancy', '', 'The fraction of a GPU multiprocessor’s maximum warp capacity occupied by resident warps.', 'Registers, shared-memory allocation and block limits can restrict residency. Higher occupancy alone does not guarantee a faster kernel.'),
    ],
    'Storage, layout and addressing': [
        ('global-memory', 'Global memory', 'global allocation|global allocations', 'Device memory addressable across thread blocks and kernel launches, commonly backed by GPU DRAM and accessed through caches.', 'A pointer identifies an allocation, not a guarantee that each access reaches DRAM rather than a cache.'),
        ('shared-memory', 'Shared memory', '', 'Explicitly addressed on-chip storage shared by threads in one block.', 'Use it to exchange values between warps or reuse a tile. Allocation, address mapping and synchronization are separate design decisions.'),
        ('register', 'Register', 'registers', 'Thread-local storage for scalar values and instruction operands, including matrix fragments.', 'A register variable is owned by a thread. Actual register allocation and any spills must be checked in compiled code or profiling.'),
        ('l1-cache', 'L1 cache', 'L1', 'A hardware-managed cache near a GPU multiprocessor that can serve eligible memory accesses.', 'L1 cache behavior is not the same as explicitly indexing shared memory, even where hardware resources are related.'),
        ('l2-cache', 'L2 cache', 'L2', 'A hardware-managed cache shared across GPU multiprocessors, between many device accesses and DRAM.', 'Source code alone does not establish that a particular access hits this cache.'),
        ('bank', 'Bank', 'banks|shared-memory bank|shared-memory banks', 'An independently serviced part of shared memory. The documented address diagrams use 32 banks and 4-byte bank words.', 'For those diagrams, bank = floor(byte address / 4) mod 32. Analyze the instruction’s actual transactions before concluding that repeated bank IDs conflict.'),
        ('bank-conflict', 'Bank conflict', 'bank conflicts', 'Contention when distinct shared-memory addresses in one serviced transaction require the same bank.', 'Repeated bank numbers in a whole-warp diagram are not by themselves proof of a conflict; transaction grouping and same-address broadcast matter.'),
        ('swizzle', 'Swizzle', 'swizzles|swizzled|swizzling', 'A deliberate permutation of logical indices into physical positions, often to improve memory access patterns.', 'An XOR bank swizzle is one possible permutation. The native fragment slabs shown in these lessons have no additional XOR bank swizzle; follow their actual address formulas.'),
        ('stride', 'Stride', 'strides', 'The address increment for advancing one element along an axis, measured in elements or bytes as specified.', 'Always track the unit: multiplying an element offset by the element size produces a byte offset.'),
        ('alignment', 'Alignment', 'aligned', 'The requirement that an address be a multiple of a particular byte boundary.', 'Packed and vector accesses have alignment requirements. A 16-byte payload size does not on its own prove that its starting address is 16-byte aligned.'),
        ('coalescing', 'Coalescing', 'coalesced', 'Combining a warp’s nearby global-memory accesses into memory transactions.', 'Analyze the addresses requested by lanes together. Logical tensor adjacency does not guarantee adjacency in a packed layout.'),
        ('gather', 'Gather', 'gathers', 'Loading elements from addresses selected by an index mapping rather than a single contiguous logical slice.', 'Input-view kernels derive spatial addresses and place values into the layout expected by later compute.'),
        ('repack', 'Repack', 'repacking|repacks', 'Rearranging stored values into a different physical layout.', 'A pure repack changes addresses and ownership, not the model operation or numerical values. Precision conversion is a separate operation unless explicitly fused.'),
        ('spill', 'Spill', 'spills|spilling', 'Moving a thread value out of registers into local memory when register allocation cannot keep it resident.', 'CUDA local memory is thread-private address space backed by the device memory hierarchy; it is not shared memory.'),
    ],
    'Precision, handoffs and pipelines': [
        ('fp16', 'FP16', 'Half', 'A 16-bit floating-point representation. Half is the corresponding scalar type used in these kernel explanations.', 'The exact accumulator and conversion boundaries matter: intermediate Half rounding is part of the reconstructed computation.'),
        ('fp8', 'FP8', '', 'An 8-bit floating-point representation; these deployment paths use E4M3 activation and weight operands.', 'Do not infer that every intermediate is 8-bit. The kernels retain Half accumulators and convert at specified boundaries.'),
        ('e4m3', 'E4M3', '', 'The FP8 format with one sign bit, four exponent bits and three stored fraction bits.', 'The source conversion helpers specify rounding and finite-saturation behavior. Operand packing also has to satisfy the MMA lane layout.'),
        ('quantization', 'Quantization', 'quantize|quantized|quantizing', 'Mapping values to a limited set of representable values, introducing rounding and possibly saturation.', 'Track where conversion occurs. Delaying or moving an FP8 conversion can change the model’s numerical result.'),
        ('publish', 'Publish', 'publishes|published|publishing|publication', 'Prepare a result in the representation and location expected by its next consumer. This is a teaching term, not a CUDA instruction.', 'PublishWindowChunk and PublishWindow32 prepare register operand fragments: FP8 converts and packs Half results into E4M3 words; FP16 rearranges Half words. Publication can stay entirely in registers. A handoff through shared or global memory additionally needs the appropriate store and synchronization. Publishing this website is a separate use of the word.'),
        ('barrier', 'Barrier', 'barriers', 'A synchronization point that coordinates a defined set of participants and orders the relevant memory operations.', 'Its scope matters. A block barrier is not a grid barrier, and an asynchronous copy must use the completion protocol required by that copy mechanism.'),
        ('producer', 'Producer', 'producers', 'The thread, warp or stage that creates or loads a value for another stage to consume.', 'A producer must not overwrite a shared buffer while a consumer still depends on its previous contents.'),
        ('consumer', 'Consumer', 'consumers', 'The thread, warp or stage that reads a value prepared by an earlier stage.', 'The consumer needs both the expected representation and a valid dependency that establishes readiness.'),
        ('async-copy', 'Asynchronous copy', 'asynchronous copies|async copy|async copies|cp.async', 'A memory-copy operation whose completion can be coordinated separately from issuing it.', 'The SM80/89 per-lane path and the SM90 bulk path have different issue and completion mechanisms. Follow the source path selected for the target architecture.'),
        ('ring-buffer', 'Ring buffer', 'shared ring|shared-memory ring', 'A fixed set of storage slots reused cyclically as a stream of tiles advances.', 'Each slot has a lifetime: fill, make ready, consume, then reuse. Two or three stages describe buffer capacity, not guaranteed simultaneous execution.'),
        ('pipeline', 'Pipeline', 'pipelines|pipelined|pipelining', 'A sequence of stages arranged so that work on different tiles can overlap when dependencies and resources permit.', 'More stages may hide latency but require more storage. Read the slot-reuse and wait rules before assuming overlap.'),
        ('fusion', 'Fusion', 'fused', 'Combining model operations into one kernel so intermediate values can often remain in registers or shared memory.', 'Fusion can save launches and global-memory traffic, but it also increases live state and may require ownership exchanges between stages.'),
    ],
}

ENTRIES = {row[0]: row for rows in GROUPS.values() for row in rows}
ALIASES = {word.casefold(): row for row in ENTRIES.values()
           for word in [row[1], *filter(None, row[2].split('|'))]}
PATTERN = re.compile(r'(?<![\w.-])(?:' + '|'.join(re.escape(a) for a in sorted(ALIASES, key=len, reverse=True)) + r')(?![\w.-])', re.I)


class Annotator(HTMLParser):
    """Only wrap text nodes; never modify code, links, SVG, or attributes."""
    SKIP = {'a', 'code', 'pre', 'svg', 'script', 'style', 'button', 'summary', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'}
    VOID = {'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'}

    def __init__(self):
        super().__init__(convert_charrefs=False)
        self.out, self.stack, self.seen = [], [], set()

    def handle_starttag(self, tag, attrs):
        if tag == 'h2': self.seen.clear()
        self.out.append(self.get_starttag_text())
        if tag not in self.VOID: self.stack.append(tag)

    def handle_startendtag(self, tag, attrs): self.out.append(self.get_starttag_text())

    def handle_endtag(self, tag):
        self.out.append(f'</{tag}>')
        if tag in self.stack:
            del self.stack[len(self.stack) - 1 - self.stack[::-1].index(tag):]

    def handle_data(self, data):
        if not self.SKIP.intersection(self.stack):
            def wrap(match):
                ident, label, _, short, _ = ALIASES[match[0].casefold()]
                if ident in self.seen: return match[0]
                self.seen.add(ident)
                return (f'<a class="glossary-term" href="glossary.html#{ident}" '
                        f'data-term="{escape(label, quote=True)}" data-definition="{escape(short, quote=True)}">{match[0]}</a>')
            data = PATTERN.sub(wrap, data)
        self.out.append(data)

    def handle_entityref(self, name): self.out.append(f'&{name};')
    def handle_charref(self, name): self.out.append(f'&#{name};')
    def handle_comment(self, data): self.out.append(f'<!--{data}-->')


def annotate(body):
    # HTMLParser lowercases end tags, which corrupts case-sensitive SVG/XML
    # names such as clipPath and rdf:RDF. Preserve whole graphics byte-for-byte.
    graphics=[]
    def protect(match):
        graphics.append(match[0])
        return f'<!--protected-graphic-{len(graphics)-1}-->'
    body=re.sub(r'<svg\b.*?</svg>',protect,body,flags=re.S)
    parser = Annotator()
    parser.feed(body)
    parser.close()
    body=''.join(parser.out)
    for i,graphic in enumerate(graphics):body=body.replace(f'<!--protected-graphic-{i}-->',graphic)
    return body


def glossary_page():
    body = '''<h2 id="using">A vocabulary for following one token through a kernel</h2>
<p>Use this page while reading any lesson. Dotted, tinted terms in the lessons show a short explanation on mouse hover or keyboard focus. Press Escape to dismiss it; follow the link (or tap on a touch screen) for the full entry here. The first eligible occurrence of each term in each section is highlighted, keeping repeated prose readable. Source code and diagram labels retain their original text.</p>
<p>Start with the model coordinates, then execution ownership, physical storage, and the handoffs between stages. The definitions below describe this guide’s usage; the exact equations, addresses and synchronization rules remain in each kernel lesson.</p>'''
    body += '<nav class="glossary-jumps" aria-label="Glossary categories">' + ''.join(f'<a href="#group-{i}">{escape(group)}</a>' for i, group in enumerate(GROUPS)) + '</nav>'
    for i, (group, rows) in enumerate(GROUPS.items()):
        body += f'<h2 id="group-{i}">{escape(group)}</h2><dl class="glossary-list">'
        for ident, label, aliases, short, detail in rows:
            body += f'<dt id="{ident}">{escape(label)} <a class="term-permalink" href="#{ident}" aria-label="Link to {escape(label, quote=True)}">#</a></dt><dd><p>{escape(short)}</p><p>{escape(detail)}</p></dd>'
        body += '</dl>'
    body += '''<h2 id="worked-example">Read a handoff without confusing its layers</h2>
<p>A token is a model position. Its channels are divided among lanes as register fragments. A warp collectively issues MMA instructions and retains accumulator fragments. To <a href="#publish">publish</a> the result, it prepares the next operand format. If the consumer is another warp, the kernel may store a tile in shared memory and coordinate the handoff with a barrier. These are separate decisions: logical value, lane ownership, representation, storage address, and readiness.</p>
<p>Continue with the <a href="foundations.html">tensor/lane reference</a>, <a href="window_block_c32_fp16.html">FP16 C32 window lesson</a>, <a href="window_ffn_input_view_c512_fp8.html">FP8 C512 gather and grouped FFN lesson</a>, or <a href="runtime.html">host scheduling reference</a>. For the precise register publication implementation, read <a href="source/csrc/kernel_impl/shared/common/warp_window32.cuh">warp_window32.cuh</a>, particularly PublishWindowChunk and PublishWindow32.</p>'''
    return dict(slug='glossary', title='Kernel vocabulary, explained', summary=f'{len(ENTRIES)} terms connecting model operations, token ownership, memory layout and CUDA execution. Short definitions stay within reach throughout every lesson.', body=body)
