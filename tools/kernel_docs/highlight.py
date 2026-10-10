"""Build-time lexical coloring for CUDA/C++, Python and teaching pseudocode.

No browser dependency: generated code remains readable offline and without JS.
Tokens only add spans; the original text and newlines are preserved verbatim.
"""
from functools import lru_cache
from html import escape, unescape
import re

KEYWORDS = set('''alignas alignof asm auto bool break case catch char class const
constexpr const_cast continue decltype default delete do double else enum explicit
export extern false float for friend goto if inline int long mutable namespace new
noexcept nullptr operator private protected public register reinterpret_cast return
short signed sizeof static static_assert static_cast struct switch template this
thread_local throw true try typedef typename union unsigned using virtual void
volatile while and as assert async await def del elif except finally from global
import in is lambda nonlocal not or pass raise with yield for_each each then end
otherwise repeat until'''.split())
TYPES = set('''bool char double float int long short void size_t ptrdiff_t uint8_t
uint16_t uint32_t uint64_t int8_t int16_t int32_t int64_t __half __half2 half half2
float2 float3 float4 uint2 uint3 uint4 int2 int3 int4 dim3 bool uint32 uint64 int32
int64 Half Half2 E4M3 Tensor Path Optional Tuple List Dict str bytes list tuple dict
set range'''.split())
CUDA = set('''__global__ __device__ __host__ __shared__ __constant__ __managed__
__restrict__ __forceinline__ __noinline__ __launch_bounds__ __maxnreg__ threadIdx
blockIdx blockDim gridDim warpSize'''.split())


@lru_cache(maxsize=3)
def lexer(language):
    comments = r'//[^\n]*|/\*[\s\S]*?(?:\*/|\Z)' if language == 'cpp' else r'\#[^\n]*'
    if language == 'pseudocode':
        comments += r'|^[ \t]*//[^\n]*'
    directive = (r'(?P<directive>^[ \t]*\#[ \t]*(?:include|define|undef|if|ifdef|ifndef|elif|else|endif|pragma|error)\b)|' if language == 'cpp' else '')
    return re.compile(
        directive + r'(?P<comment>' + comments + r')'
        + r'|(?P<string>R"(?P<delimiter>[^\s()\\]{0,16})\([\s\S]*?\)(?P=delimiter)"'
        + r'|"""[\s\S]*?(?:"""|\Z)|\x27\x27\x27[\s\S]*?(?:\x27\x27\x27|\Z)'
        + r'|"(?:\\[\s\S]|[^"\\])*"|\x27(?:\\[\s\S]|[^\x27\\\n])*\x27)'
        + r'|(?P<number>\b0[xX][\da-fA-F\x27]+(?:\.[\da-fA-F\x27]*)?(?:[pP][+-]?\d+)?[uUlLfF]*\b'
        + r'|\b0[bB][01\x27]+[uUlL]*\b|(?<![\w.])(?:\d[\d\x27]*(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?[uUlLfF]*\b)'
        + r'|(?P<identifier>\b[A-Za-z_]\w*\b)'
        + r'|(?P<operator>[+*/%=!<>&|^~?:-]+)', re.M)


@lru_cache(maxsize=256)
def highlight_lines(source, language='cpp'):
    output=[]
    end=0
    for match in lexer(language).finditer(source):
        output.append(escape(source[end:match.start()]))
        value=match[0]
        kind=match.lastgroup
        if kind=='identifier':
            if value in CUDA or value.startswith(('__syncthreads','__shfl','__ld','__st','__cvta')):
                kind='cuda'
            elif value in TYPES or re.fullmatch(r'F[A-Z]\w*',value):kind='type'
            elif value in KEYWORDS or value in ('True','False','None'):kind='keyword'
            elif re.fullmatch(r'[A-Z][A-Z_0-9]*',value):kind='constant'
            elif re.match(r'\s*(?:<[^;{}\n]*>)?\s*\(',source[match.end():]):kind='function'
            else:kind=None
        # Close each span at the newline so line-number wrappers remain valid.
        output.append('\n'.join(f'<span class="syntax-{kind}">{escape(part)}</span>' if part and kind else escape(part)
                                for part in value.split('\n')))
        end=match.end()
    output.append(escape(source[end:]))
    return ''.join(output).split('\n')


def highlight_blocks(body):
    """Color unnumbered teaching/reference blocks; numbered excerpts are done earlier."""
    def block(match):
        content=match[1]
        if '<span' in content:return match[0]
        colored='\n'.join(highlight_lines(unescape(content),'pseudocode'))
        return '<pre><code class="syntax-highlight">'+colored+'</code></pre>'
    return re.sub(r'<pre><code>(.*?)</code></pre>',block,body,flags=re.S)
