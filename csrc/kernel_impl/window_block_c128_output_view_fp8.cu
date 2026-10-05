// Reconstructed native window_block_c128_output_view_fp8 schedule.
// The exported entry owns its storage, tensor stages and final publication.
#include "kernel_helpers.cuh"
#include "warp_window_wide.cuh"

extern "C" __global__ __maxnreg__(168) void window_block_c128_output_view_fp8(
	FWindowBlockC128OutputViewFp8Parameters Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	constexpr bool bFp8 = true;
	constexpr int Channels = 128;
	__shared__ FSharedWindow<Channels, bFp8> s_Window;
	using FConfig = FWideWindowProfile<Channels, bFp8>;
	const auto* g_PackedWeights = reinterpret_cast<const unsigned char*>(Parameters.g_PackedWeights);
	// FFN: private C64 tiles, or cross-warp expert panels for C128/C256.
	const int Warp = threadIdx.y;
	{
#pragma unroll
		for (int TileIndex = 0; TileIndex < 4; ++TileIndex)
		{
			// Read the physical input tile without a separate layout staging pass.
			using FConfig = FWideWindowProfile<Channels, bFp8>;
			const int g_TileColumns = Parameters.Width / 4, g_TileRows = Parameters.Height / 4;
			const int g_TileX =
				g_TileColumns == 1 ? 0 : (int(blockIdx.x) * 8 + Parameters.OriginX) / 4 + ((TileIndex) & 1);
			const int g_TileY =
				g_TileRows == 1 ? 0 : (int(blockIdx.y) * 8 + Parameters.OriginY) / 4 + ((TileIndex) >> 1);
			const bool bValid =
				g_TileX >= 0 && g_TileX < g_TileColumns && g_TileY >= 0 && g_TileY < g_TileRows;
			FWindowActivationTile<bFp8> r_InputTile;
#pragma unroll
			for (int r_Chunk = 0; r_Chunk < FConfig::Chunks; ++r_Chunk)
			{
				const uint64_t g_InputFragmentAddress =
					Parameters.g_Input + uint64_t(g_TileY * g_TileColumns + g_TileX) * FConfig::TileBytes +
					(Warp)*FConfig::PanelBytes + r_Chunk * 512 + int(threadIdx.x) * 16;
				r_InputTile.r_Reduction[r_Chunk] =
					MakeWindowFragment(bValid ? __ldcg(reinterpret_cast<const uint4*>(g_InputFragmentAddress))
											  : make_uint4(0, 0, 0, 0));
			}
			s_Window.Store(TileIndex, Warp, r_InputTile);
		}
		__syncthreads();
		FWindowAccumulatorTile<32> r_Contracted[4]{};
		ComputeWindowExpert<Channels, bFp8>(s_Window, g_PackedWeights, Warp, r_Contracted);
		FWindowAccumulatorTile<32> r_Output[4];
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			r_Output[r_Tile] = ScaledWindowResidual(s_Window.Load(r_Tile, Warp),
													g_PackedWeights + FConfig::FfnScaleOffset, 32 * Warp);
		// All experts must finish reading X before their published outputs reuse
		// the same slab. This is a tensor lifetime barrier, not a warp shuffle.
		__syncthreads();
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, Warp, PublishWindow32<bFp8>(r_Contracted[r_Tile]));
		__syncthreads();
#pragma unroll 1
		for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
		{
			const auto r_Weights = LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::MixOffset, 32 * Warp,
														   32 * PanelIndex, Channels);
#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
				LinearWindow32(s_Window.Load(r_Tile, PanelIndex), r_Weights, r_Output[r_Tile]);
		}
		__syncthreads();
#pragma unroll
		for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
			s_Window.Store(r_Tile, Warp, PublishWindow32<bFp8>(r_Output[r_Tile]));
		__syncthreads();
	}
	FWindowActivationTile<bFp8> r_Query[4], r_Key[4];
	FWindowValueTile<bFp8> r_Value[4];
	// Q/K/V projection and normalization keep the native shared-panel ownership.
	FWindowAccumulatorTile<32> r_Projected[3][4]{};
#pragma unroll 1
	for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
#pragma unroll
		for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
		{
			// The record interleaves Q/K/V within each head: [Head][Q,K,V][32].
			const auto r_Weights = LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::QkvOffset,
														   96 * int(threadIdx.y) + 32 * r_QkvComponent,
														   32 * PanelIndex, 3 * Channels);
#pragma unroll
			for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
				LinearWindow32(s_Window.Load(r_Tile, PanelIndex), r_Weights,
							   r_Projected[r_QkvComponent][r_Tile]);
		}
	const uint32_t r_HeadScale = FloatToHalf2(
		*reinterpret_cast<const uint32_t*>(g_PackedWeights + FConfig::HeadScaleOffset + 4 * threadIdx.y));
#pragma unroll
	for (int r_Tile = 0; r_Tile < 4; ++r_Tile)
	{
		NormalizeWindow<true>(r_Projected[0][r_Tile], r_HeadScale);
		NormalizeWindow<false>(r_Projected[1][r_Tile], CONST_HALF2_ONE);
		r_Query[r_Tile] = PublishWindow32<bFp8>(r_Projected[0][r_Tile]);
		r_Key[r_Tile] = PublishWindow32<bFp8>(r_Projected[1][r_Tile]);
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			// Transpose Half accumulators before E4 publication, exactly as the
			// DLL does, to obtain B fragments for probability times value.
			const uint32_t r_LowerValueRows = TransposeM8n8(r_Projected[2][r_Tile].r_Pair[r_Column][0]);
			const uint32_t r_UpperValueRows = TransposeM8n8(r_Projected[2][r_Tile].r_Pair[r_Column][1]);
			r_Value[r_Tile].r_Column[r_Column][0] = PackHalfPairsE4(r_LowerValueRows, r_UpperValueRows);
		}
	}
	__syncthreads();
#pragma unroll
	for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += FConfig::AttentionBatch)
	{
		FWindowActivationTile<bFp8> r_Attended[FConfig::AttentionBatch];
		FWindowAccumulatorTile<32> r_Output[FConfig::AttentionBatch];
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
		{
			const int r_Tile = r_FirstTile + r_LocalTile;
			r_Attended[r_LocalTile] = AttendWithBias<bFp8>(
				r_Tile, g_PackedWeights + FConfig::BiasOffset + 8192 * threadIdx.y, r_Query, r_Key, r_Value);
			r_Output[r_LocalTile] =
				ScaledWindowResidual(s_Window.Load(r_Tile, threadIdx.y),
									 g_PackedWeights + FConfig::AttentionScaleOffset, 32 * threadIdx.y);
		}
// Each warp has consumed its own published FFN residual; attention
// output now occupies the same head panel for the cross-head projection.
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
			s_Window.Store(r_FirstTile + r_LocalTile, threadIdx.y, r_Attended[r_LocalTile]);
		__syncthreads();
#pragma unroll 1
		for (int PanelIndex = 0; PanelIndex < FConfig::Heads; ++PanelIndex)
		{
			const auto r_Weights = LoadWindowWeights<bFp8>(g_PackedWeights + FConfig::ProjectionOffset,
														   32 * threadIdx.y, 32 * PanelIndex, Channels);
#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
				LinearWindow32(s_Window.Load(r_FirstTile + r_LocalTile, PanelIndex), r_Weights,
							   r_Output[r_LocalTile]);
		}
#pragma unroll
		for (int r_LocalTile = 0; r_LocalTile < FConfig::AttentionBatch; ++r_LocalTile)
		{

			{
				// Publish final packed fragments directly to their physical output layout.
				constexpr int Chunks = FWindow32Profile<bFp8>::InputChunks;
				const int g_Height = Parameters.ViewHeight > 0 ? Parameters.ViewHeight : Parameters.Height;
				const int g_Width = Parameters.ViewWidth > 0 ? Parameters.ViewWidth : Parameters.Width;
				const int g_OriginX =
					int(blockIdx.x) * 8 + Parameters.OriginX + ((r_FirstTile + r_LocalTile) & 1) * 4;
				const int g_OriginY =
					int(blockIdx.y) * 8 + Parameters.OriginY + ((r_FirstTile + r_LocalTile) >> 1) * 4;
#pragma unroll
				for (int r_Chunk = 0; r_Chunk < Chunks; ++r_Chunk)
				{
					const auto r_Fragment = PublishWindowChunk<bFp8>(r_Output[r_LocalTile], r_Chunk);
#pragma unroll
					for (int r_Word = 0; r_Word < 4; ++r_Word)
					{
						const int g_X = g_OriginX + ((threadIdx.x / 4) & 3);
						const int g_Y = g_OriginY + threadIdx.x / 16 + 2 * (r_Word & 1);
						if (g_X >= 0 && g_X < g_Width && g_Y >= 0 && g_Y < g_Height)
						{
							const int g_Plane = (threadIdx.y) * 2 * Chunks + 2 * r_Chunk + r_Word / 2;
							const uint64_t g_OutputWordAddress =
								Parameters.g_Output +
								((uint64_t(g_Plane * g_Height + g_Y) * g_Width + g_X) * 16) +
								4 * (threadIdx.x & 3);
							*reinterpret_cast<uint32_t*>(g_OutputWordAddress) = r_Fragment.r_Word[r_Word];
						}
					}
				}
			}
		}
		__syncthreads();
	}
#endif
}
