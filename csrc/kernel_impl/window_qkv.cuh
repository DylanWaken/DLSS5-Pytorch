#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "tiled_mma.cuh"
#include "warp_window_wide.cuh"

// Split C512 QKV and attention. Four warps each own one 32-channel head;
// grid.z partitions all sixteen heads. The separate projection kernel follows.
namespace dlssnr::kernels::window_qkv
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
namespace Attention = dlssnr::kernels::window32;
using FDenseTile = dlssnr::tiles::sm120::FAccumulatorTile<4, 6>;

template <bool bFp8> struct FProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionStep = bFp8 ? 64 : 16;
	static constexpr int ReductionTiles = 512 / ReductionStep;
	static constexpr int KSubtiles = bFp8 ? 2 : 1;
	static constexpr int s_StageBytes = bFp8 ? 4096 : 2048;
	static constexpr int s_BarrierBase = 2 * s_StageBytes;
	static constexpr int BiasOffset = 3 * 512 * 512 * ElementBytes;
	static constexpr int HeadScaleOffset = BiasOffset + 16 * 8192;
	static constexpr auto Precision =
		bFp8 ? dlssnr::mma::sm120::EInputPrecision::Fp8 : dlssnr::mma::sm120::EInputPrecision::Fp16;
};

struct FCoordinates
{
	int g_TilesHigh, g_TilesWide, g_TileY, g_TileX, g_Head;
	int r_Lane, r_Warp;
};

template <bool bFp8>
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[FProfile<bFp8>::KSubtiles][6],
											uint64_t g_PackedWeights, int r_ReductionTile,
											const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const uint64_t g_WeightTileBase =
		g_PackedWeights + uint64_t(r_ReductionTile * Profile::ReductionStep) * 1536 * Profile::ElementBytes +
		r_TileCoordinates.g_Head * 3072 + r_TileCoordinates.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < Profile::KSubtiles; ++r_KSubtile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 6; ++r_NTile)
			r_Weights[r_KSubtile][r_NTile] =
				__ldca(reinterpret_cast<const uint4*>(g_WeightTileBase + r_KSubtile * 49152 + r_NTile * 512));
}

template <bool bFp8>
__device__ __forceinline__ void IssueStage(unsigned char* s_Storage, uint64_t g_Input, int r_ReductionTile,
										   const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	const int s_Barrier = Profile::s_BarrierBase + (r_ReductionTile % 2) * 8;
#pragma unroll
	for (int r_Copy = 0; r_Copy < (bFp8 ? 2 : 1); ++r_Copy)
	{
		const int g_LocalY = bFp8 ? r_Copy : r_TileCoordinates.r_Warp / 2;
		const int g_LocalX = bFp8 ? r_TileCoordinates.r_Warp / 2 : r_TileCoordinates.r_Warp % 2;
		const int r_KSubtile = bFp8 ? r_TileCoordinates.r_Warp % 2 : 0;
		const int g_Y = r_TileCoordinates.g_TilesHigh == 1 ? 0 : r_TileCoordinates.g_TileY + g_LocalY;
		const int g_X = r_TileCoordinates.g_TilesWide == 1 ? 0 : r_TileCoordinates.g_TileX + g_LocalX;
		const int s_Destination = (r_ReductionTile % 2) * Profile::s_StageBytes +
								  ((g_LocalY * 2 + g_LocalX) * Profile::KSubtiles + r_KSubtile) * 512;
		if (g_Y >= 0 && g_Y < r_TileCoordinates.g_TilesHigh && g_X >= 0 &&
			g_X < r_TileCoordinates.g_TilesWide)
		{
			const uint64_t g_Source =
				g_Input + uint64_t(g_Y * r_TileCoordinates.g_TilesWide + g_X) * 8192 * Profile::ElementBytes +
				(r_ReductionTile * Profile::KSubtiles + r_KSubtile) * 512;
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_Destination, g_Source, 512, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, 512);
			}
		}
		else
			*reinterpret_cast<uint4*>(s_Storage + s_Destination + r_TileCoordinates.r_Lane * 16) =
				make_uint4(0, 0, 0, 0);
	}
}

template <bool bFp8> __device__ __forceinline__ void WaitStage(unsigned char* s_Storage, int r_ReductionTile)
{
	const int s_Barrier = FProfile<bFp8>::s_BarrierBase + (r_ReductionTile % 2) * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

template <bool bFp8>
__device__ __forceinline__ void Project(FDenseTile& r_Projected, unsigned char* s_Storage, uint64_t g_Input,
										uint64_t g_PackedWeights, const FCoordinates& r_TileCoordinates)
{
	using Profile = FProfile<bFp8>;
	uint4 r_Weights[Profile::KSubtiles][6];
	LoadWeights<bFp8>(r_Weights, g_PackedWeights, 0, r_TileCoordinates);
	IssueStage<bFp8>(s_Storage, g_Input, 0, r_TileCoordinates);
	WaitStage<bFp8>(s_Storage, 0);

	// Native Half uses K16 and a 2 KiB stage. FP8 uses two K32 instructions
	// and a 4 KiB stage. Both schedules ping-pong between two input stages.
#pragma unroll 1
	for (int r_ReductionTile = 0; r_ReductionTile < Profile::ReductionTiles; ++r_ReductionTile)
	{
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
			IssueStage<bFp8>(s_Storage, g_Input, r_ReductionTile + 1, r_TileCoordinates);
		uint4 r_Input[4][Profile::KSubtiles];
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
#pragma unroll
			for (int r_KSubtile = 0; r_KSubtile < Profile::KSubtiles; ++r_KSubtile)
				r_Input[r_Spatial][r_KSubtile] = *reinterpret_cast<const uint4*>(
					s_Storage + (r_ReductionTile % 2) * Profile::s_StageBytes +
					(r_Spatial * Profile::KSubtiles + r_KSubtile) * 512 + r_TileCoordinates.r_Lane * 16);
		if constexpr (bFp8)
			dlssnr::tiles::sm120::AccumulateTile<Profile::Precision>(r_Projected, r_Input, r_Weights);
		else
		{
#pragma unroll
			for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
#pragma unroll
				for (int r_NTile = 0; r_NTile < 6; ++r_NTile)
				{
					auto& r_AccumulatorWords = r_Projected.r_AccumulatorWords[r_Spatial][r_NTile];
					const uint4 r_InputFragment = r_Input[r_Spatial][0],
								r_WeightFragment = r_Weights[0][r_NTile];
					dlssnr::mma::sm120::MultiplyAccumulate<Profile::Precision>(
						{r_AccumulatorWords[0], r_AccumulatorWords[1]},
						{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
						{r_WeightFragment.x, r_WeightFragment.y},
						{r_AccumulatorWords[0], r_AccumulatorWords[1]});
					dlssnr::mma::sm120::MultiplyAccumulate<Profile::Precision>(
						{r_AccumulatorWords[2], r_AccumulatorWords[3]},
						{r_InputFragment.x, r_InputFragment.y, r_InputFragment.z, r_InputFragment.w},
						{r_WeightFragment.z, r_WeightFragment.w},
						{r_AccumulatorWords[2], r_AccumulatorWords[3]});
				}
		}
		if (r_ReductionTile + 1 < Profile::ReductionTiles)
		{
			LoadWeights<bFp8>(r_Weights, g_PackedWeights, r_ReductionTile + 1, r_TileCoordinates);
			WaitStage<bFp8>(s_Storage, r_ReductionTile + 1);
		}
	}
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void Forward(const TParameters& r_Parameters, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8>;
	const FCoordinates r_TileCoordinates{r_Parameters.Height / 4,
										 r_Parameters.Width / 4,
										 (int(blockIdx.y) * 8 + r_Parameters.OriginY) / 4,
										 (int(blockIdx.x) * 8 + r_Parameters.OriginX) / 4,
										 int(blockIdx.z) * 4 + int(threadIdx.y),
										 int(threadIdx.x),
										 int(threadIdx.y)};
	if (r_TileCoordinates.r_Lane == 0 && r_TileCoordinates.r_Warp == 0)
	{
		BarrierInit(s_Storage, Profile::s_BarrierBase, 128);
		BarrierInit(s_Storage, Profile::s_BarrierBase + 8, 128);
	}
	__syncthreads();
	FDenseTile r_Projected{};
	Project<bFp8>(r_Projected, s_Storage, r_Parameters.g_Input, r_Parameters.g_PackedWeights,
				  r_TileCoordinates);

	Attention::FActivationTile<bFp8> r_Query[4], r_Key[4];
	Attention::FValueTile<bFp8> r_Value[4];
	const uint32_t r_HeadScale = dlssnr::packed_math::sm120::FloatToHalf2(*reinterpret_cast<const uint32_t*>(
		r_Parameters.g_PackedWeights + Profile::HeadScaleOffset + r_TileCoordinates.g_Head * 4));
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		Attention::FAccumulatorTile<32> r_Qkv[3];
#pragma unroll
		for (int r_QkvComponent = 0; r_QkvComponent < 3; ++r_QkvComponent)
#pragma unroll
			for (int r_Column = 0; r_Column < 4; ++r_Column)
#pragma unroll
				for (int r_RowHalf = 0; r_RowHalf < 2; ++r_RowHalf)
					r_Qkv[r_QkvComponent].r_Pair[r_Column][r_RowHalf] =
						r_Projected.r_AccumulatorWords[r_Spatial][r_QkvComponent * 2 + r_Column / 2]
													  [(r_Column % 2) * 2 + r_RowHalf];
		Attention::Normalize<true>(r_Qkv[0], r_HeadScale);
		Attention::Normalize<false>(r_Qkv[1], dlssnr::numerical_constants::CONST_HALF2_ONE);
		r_Query[r_Spatial] = Attention::Publish<bFp8>(r_Qkv[0]);
		r_Key[r_Spatial] = Attention::Publish<bFp8>(r_Qkv[1]);
#pragma unroll
		for (int r_Column = 0; r_Column < 4; ++r_Column)
		{
			const uint32_t r_LowerValueRows = TransposeM8n8(r_Qkv[2].r_Pair[r_Column][0]);
			const uint32_t r_UpperValueRows = TransposeM8n8(r_Qkv[2].r_Pair[r_Column][1]);
			if constexpr (bFp8)
				r_Value[r_Spatial].r_Column[r_Column][0] =
					dlssnr::packed_math::sm120::PackHalfPairsE4(r_LowerValueRows, r_UpperValueRows);
			else
			{
				r_Value[r_Spatial].r_Column[r_Column][0] = r_LowerValueRows;
				r_Value[r_Spatial].r_Column[r_Column][1] = r_UpperValueRows;
			}
		}
	}

	// Q/K normalization and the affine-exponent softmax use the same exact
	// packed-Half operations as the smaller window blocks. Attention stays in registers.
	const auto* g_HeadBias = reinterpret_cast<const unsigned char*>(
		r_Parameters.g_PackedWeights + Profile::BiasOffset + r_TileCoordinates.g_Head * 8192);
	if constexpr (bFp8)
	{
		// The native softmax transposes two adjacent query tiles together:
		// one inverse per logical row replaces four identical lane copies.
#pragma unroll
		for (int r_FirstTile = 0; r_FirstTile < 4; r_FirstTile += 2)
		{
			Attention::FActivationTile<true> r_Attended[2];
			dlssnr::kernels::window_wide::AttendPairWithBias<true>(r_FirstTile, g_HeadBias, r_Query, r_Key,
																   r_Value, r_Attended);
#pragma unroll
			for (int r_LocalTile = 0; r_LocalTile < 2; ++r_LocalTile)
			{
				const int r_Spatial = r_FirstTile + r_LocalTile;
				const int g_Y = r_TileCoordinates.g_TileY + r_Spatial / 2,
						  g_X = r_TileCoordinates.g_TileX + r_Spatial % 2;
				if (g_Y < 0 || g_Y >= r_TileCoordinates.g_TilesHigh || g_X < 0 ||
					g_X >= r_TileCoordinates.g_TilesWide)
					continue;
				const auto& r_AttendedFragment = r_Attended[r_LocalTile].r_Reduction[0];
				const uint64_t g_OutputFragmentAddress =
					r_Parameters.g_Output + uint64_t(g_Y * r_TileCoordinates.g_TilesWide + g_X) * 8192 +
					r_TileCoordinates.g_Head * 512 + r_TileCoordinates.r_Lane * 16;
				StoreNoAllocate(g_OutputFragmentAddress,
								make_uint4(r_AttendedFragment.r_Word[0], r_AttendedFragment.r_Word[1],
										   r_AttendedFragment.r_Word[2], r_AttendedFragment.r_Word[3]));
			}
		}
	}
	else
	{
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
		{
			const auto r_AttendedTile = dlssnr::kernels::window_wide::AttendWithBias<bFp8>(
				r_Spatial, g_HeadBias, r_Query, r_Key, r_Value);
			const int g_Y = r_TileCoordinates.g_TileY + r_Spatial / 2,
					  g_X = r_TileCoordinates.g_TileX + r_Spatial % 2;
			if (g_Y < 0 || g_Y >= r_TileCoordinates.g_TilesHigh || g_X < 0 ||
				g_X >= r_TileCoordinates.g_TilesWide)
				continue;
#pragma unroll
			for (int r_Chunk = 0; r_Chunk < (bFp8 ? 1 : 2); ++r_Chunk)
			{
				const auto& r_AttendedFragment = r_AttendedTile.r_Reduction[r_Chunk];
				const uint64_t g_OutputFragmentAddress =
					r_Parameters.g_Output +
					uint64_t(g_Y * r_TileCoordinates.g_TilesWide + g_X) * 8192 * Profile::ElementBytes +
					r_TileCoordinates.g_Head * 512 * Profile::ElementBytes + r_Chunk * 512 +
					r_TileCoordinates.r_Lane * 16;
				StoreNoAllocate(g_OutputFragmentAddress,
								make_uint4(r_AttendedFragment.r_Word[0], r_AttendedFragment.r_Word[1],
										   r_AttendedFragment.r_Word[2], r_AttendedFragment.r_Word[3]));
			}
		}
	}
}
#endif
} // namespace dlssnr::kernels::window_qkv
