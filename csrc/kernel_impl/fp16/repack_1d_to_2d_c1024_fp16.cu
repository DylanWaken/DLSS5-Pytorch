// The exported entry owns its storage, pipeline, computation and publication.
// Shared headers contain only profiles, layout maps and reused tensor primitives.
#include "../common/kernel_helpers.cuh"
#include "../common/global_repack_layout.cuh"

extern "C" __global__ void repack_1d_to_2d_c1024_fp16(FGlobalRepackParameters Parameters)
{
	constexpr bool bFp8 = false;
	constexpr bool bToTokenLayout = false;
	constexpr uint32_t CONST_WORDS_PER_TOKEN = bFp8 ? 256u : 512u;
	constexpr uint32_t CONST_TOKEN_ALIGNMENT = bFp8 ? 32u : 16u;
	const uint32_t g_TokenCount = uint32_t(Parameters.Height) * uint32_t(Parameters.Width);
	const uint32_t g_PaddedTokenCount =
		(g_TokenCount + CONST_TOKEN_ALIGNMENT - 1u) / CONST_TOKEN_ALIGNMENT * CONST_TOKEN_ALIGNMENT;
	const uint32_t g_WordCount = (bToTokenLayout ? g_PaddedTokenCount : g_TokenCount) * CONST_WORDS_PER_TOKEN;
	const auto* g_Input = reinterpret_cast<const uint32_t*>(Parameters.g_Input);
	auto* g_Output = reinterpret_cast<uint32_t*>(Parameters.g_Output);
	const uint32_t g_WordStride = gridDim.x * blockDim.x;

	// Remap packed words between spatial tiles and global-token storage without changing precision.
	for (uint32_t g_WordIndex = blockIdx.x * blockDim.x + threadIdx.x; g_WordIndex < g_WordCount;
		 g_WordIndex += g_WordStride)
	{
		const uint32_t g_TokenIndex = g_WordIndex / CONST_WORDS_PER_TOKEN,
					   g_ChannelWord = g_WordIndex % CONST_WORDS_PER_TOKEN;
		const uint32_t g_TokenWord =
			GlobalRepackPhysicalWord<CONST_WORDS_PER_TOKEN>(g_TokenIndex, g_ChannelWord);
		{
			// Inverse launched tail threads perform neither load nor store.
			const uint32_t g_SpatialToken =
				GlobalRepackSpatialToken(g_TokenIndex, uint32_t(Parameters.Width));
			g_Output[GlobalRepackPhysicalWord<CONST_WORDS_PER_TOKEN>(g_SpatialToken, g_ChannelWord)] =
				g_Input[g_TokenWord];
		}
	}
}
