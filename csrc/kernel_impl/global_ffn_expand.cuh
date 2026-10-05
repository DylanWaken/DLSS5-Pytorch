#pragma once
#include "kernel_impl/memoryops.cuh"
#include "kernel_impl/kernel_helpers.cuh"
#include "kernel_impl/tiled_mma.cuh"

namespace dlssnr::reconstructed::global_ffn
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using dlssnr::intrinsics::sm120::BarrierExpect;
using dlssnr::intrinsics::sm120::BarrierInit;
using dlssnr::intrinsics::sm120::CopyBulk;
using dlssnr::intrinsics::sm120::Elected;
using dlssnr::intrinsics::sm120::StoreNoAllocate;

// The native FFN expands 1024 channels to 4096. Four warps cover a
// 128-token x 128-channel CTA tile, arranged as two row groups by two columns.
// Both precisions stage 8192 bytes per K step: K64 FP8 or K32 Half.
template <bool bFp8> struct FExpandProfile
{
	static constexpr int ElementBytes = bFp8 ? 1 : 2;
	static constexpr int ReductionTile = bFp8 ? 64 : 32;
	static constexpr int ReductionSteps = 1024 / ReductionTile;
	static constexpr int TokenAlignment = bFp8 ? 32 : 16;
	static constexpr uint32_t s_StageBytes = 8192;
	static constexpr uint32_t s_StageCount = 3;
	static constexpr uint32_t s_BarrierBase = s_StageBytes * s_StageCount;
	static constexpr auto Precision =
		bFp8 ? mma::sm120::EInputPrecision::Fp8 : mma::sm120::EInputPrecision::Fp16;
};

// Packed token storage groups 16 tokens together. Each warp copies a complete
// 1024-byte K slab from two groups; out-of-range groups contribute exact zero.
template <bool bFp8>
__device__ __forceinline__ void StageInput(unsigned char* s_Storage, uint64_t g_Input,
										   uint32_t g_FirstTokenGroup, uint32_t g_GroupCount, uint32_t r_Step,
										   uint32_t r_Stage, bool r_bBroadcastSmallHalf)
{
	using FProfile = FExpandProfile<bFp8>;
	const uint32_t r_Warp = threadIdx.y;
	const uint32_t r_Lane = threadIdx.x;
	const uint32_t s_Barrier = FProfile::s_BarrierBase + r_Stage * 8;
#pragma unroll
	for (int r_Group = 0; r_Group < 2; ++r_Group)
	{
		const uint32_t g_TokenGroup = g_FirstTokenGroup + r_Warp + r_Group * 4;
		const uint32_t s_Destination = r_Stage * FProfile::s_StageBytes + r_Warp * 1024 + r_Group * 4096;
		if (g_TokenGroup < g_GroupCount || r_bBroadcastSmallHalf)
		{
			const uint32_t g_InputGroup = r_bBroadcastSmallHalf ? 0 : g_TokenGroup;
			const uint64_t g_Source =
				g_Input + uint64_t(g_InputGroup) * 16384 * FProfile::ElementBytes + r_Step * 1024;
			// The original warp election publishes one bulk-copy transaction.
			if (Elected(0xffffffffu))
			{
				CopyBulk(s_Storage, s_Destination, g_Source, 1024, s_Barrier);
				BarrierExpect(s_Storage, s_Barrier, 1024);
			}
		}
		else
		{
			*reinterpret_cast<uint4*>(s_Storage + s_Destination + r_Lane * 16) = make_uint4(0, 0, 0, 0);
			*reinterpret_cast<uint4*>(s_Storage + s_Destination + 512 + r_Lane * 16) = make_uint4(0, 0, 0, 0);
		}
	}
}

// All threads arrive once at the selected stage. Its token includes the parity
// needed when the three-slot ring wraps; a CTA-wide barrier is not substituted.
__device__ __forceinline__ void WaitForInput(unsigned char* s_Storage, uint32_t r_Stage)
{
	const uint32_t s_Barrier = 24576 + r_Stage * 8;
	dlssnr::memoryops::sm120::ArriveAndWait(s_Storage, s_Barrier);
}

// Each uint4 supplies two adjacent N8 B fragments. The two K subtiles use the
// original 128-KiB record stride in both storage precisions.
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weight)[2][4], uint64_t g_Record,
											uint32_t g_OutputBlock, uint32_t r_Step)
{
	const uint64_t g_Base = g_Record + g_OutputBlock * 4096 + (threadIdx.y & 1) * 2048 + threadIdx.x * 16;
#pragma unroll
	for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
			r_Weight[r_KTile][r_NTile] = __ldca(reinterpret_cast<const uint4*>(
				g_Base + uint64_t(r_Step * 2 + r_KTile) * 131072 + r_NTile * 512));
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void Expand(const TParameters& r_Parameters)
{
	using FProfile = FExpandProfile<bFp8>;
	__shared__ __align__(512) unsigned char s_Storage[FProfile::s_BarrierBase + 24];
	const uint32_t r_Lane = threadIdx.x;
	const uint32_t r_Warp = threadIdx.y;
	const uint32_t r_Tokens = r_Parameters.Batch * r_Parameters.Tokens;
	const uint32_t r_TokenTiles = (r_Tokens + 127) / 128;
	const uint32_t g_OutputBlock = blockIdx.x / r_TokenTiles;
	const uint32_t g_FirstTokenGroup = (blockIdx.x % r_TokenTiles) * 8;
	const uint32_t g_GroupCount = ((r_Tokens + FProfile::TokenAlignment - 1) / FProfile::TokenAlignment) *
								  (FProfile::TokenAlignment / 16);
	const bool r_bBroadcastSmallHalf = !bFp8 && r_Tokens <= 16;
	const uint64_t g_Input = r_Parameters.g_State + uint64_t(blockIdx.z) * 16384 * FProfile::ElementBytes;
	const uint64_t g_Record =
		r_Parameters.g_Record + uint64_t(blockIdx.z) * (1024 * 4096) * FProfile::ElementBytes;
	if ((r_Lane | r_Warp) == 0)
	{
#pragma unroll
		for (int r_Stage = 0; r_Stage < FProfile::s_StageCount; ++r_Stage)
			BarrierInit(s_Storage, FProfile::s_BarrierBase + r_Stage * 8, blockDim.x * blockDim.y);
	}
	__syncthreads();

	uint4 r_Weight[2][4];
	LoadWeights(r_Weight, g_Record, g_OutputBlock, 0);
#pragma unroll
	for (int r_Stage = 0; r_Stage < FProfile::s_StageCount; ++r_Stage)
		StageInput<bFp8>(s_Storage, g_Input, g_FirstTokenGroup, g_GroupCount, r_Stage, r_Stage,
						 r_bBroadcastSmallHalf);
	WaitForInput(s_Storage, 0);

	// One warp accumulates 64 tokens x 64 output channels in Half. Input values
	// are already stored in the native MMA A layout, so no transpose is needed.
	tiles::sm120::FAccumulatorTile<4, 4> r_Accumulator{};
#pragma unroll 1
	for (uint32_t r_Step = 0; r_Step < FProfile::ReductionSteps; ++r_Step)
	{
		const uint32_t r_Stage = r_Step % FProfile::s_StageCount;
		const uint32_t s_WarpInput = r_Stage * FProfile::s_StageBytes + (r_Warp / 2) * 4096 + r_Lane * 16;
		uint4 r_Input[4][2];
#pragma unroll
		for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
#pragma unroll
			for (int r_KTile = 0; r_KTile < 2; ++r_KTile)
				r_Input[r_MTile][r_KTile] =
					*reinterpret_cast<const uint4*>(s_Storage + s_WarpInput + r_MTile * 1024 + r_KTile * 512);
		tiles::sm120::AccumulateTile<FProfile::Precision>(r_Accumulator, r_Input, r_Weight);

		// Match the native software pipeline: preload B, wait for the next A
		// stage, then recycle the consumed stage for the tile three steps ahead.
		if (r_Step + 1 < FProfile::ReductionSteps)
		{
			LoadWeights(r_Weight, g_Record, g_OutputBlock, r_Step + 1);
			WaitForInput(s_Storage, (r_Step + 1) % FProfile::s_StageCount);
		}
		if (r_Step + FProfile::s_StageCount < FProfile::ReductionSteps)
			StageInput<bFp8>(s_Storage, g_Input, g_FirstTokenGroup, g_GroupCount,
							 r_Step + FProfile::s_StageCount, r_Stage, r_bBroadcastSmallHalf);
	}

	// Preserve the native clamped Half polynomial and all its rounding points.
#pragma unroll
	for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
#pragma unroll
		for (int r_NTile = 0; r_NTile < 4; ++r_NTile)
#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
				r_Accumulator.r_Words[r_MTile][r_NTile][r_Word] =
					packed_math::sm120::FfnActivation(r_Accumulator.r_Words[r_MTile][r_NTile][r_Word]);

	// Publish each valid 16-token group directly into the next layer's physical
	// tensor layout. FP8 pairs two N16 fragments into one 128-bit vector.
#pragma unroll
	for (int r_MTile = 0; r_MTile < 4; ++r_MTile)
	{
		const uint32_t g_TokenGroup = g_FirstTokenGroup + (r_Warp / 2) * 4 + r_MTile;
		if (g_TokenGroup >= g_GroupCount)
			continue;
		const uint64_t g_Output = r_Parameters.g_High +
								  uint64_t(g_TokenGroup) * 65536 * FProfile::ElementBytes +
								  g_OutputBlock * 2048 * FProfile::ElementBytes +
								  (r_Warp & 1) * 1024 * FProfile::ElementBytes + r_Lane * 16;
#pragma unroll
		for (int r_NTile = 0; r_NTile < (bFp8 ? 2 : 4); ++r_NTile)
		{
			uint4 r_Result;
			if constexpr (bFp8)
			{
				const auto& r_Low = r_Accumulator.r_Words[r_MTile][r_NTile * 2];
				const auto& r_High = r_Accumulator.r_Words[r_MTile][r_NTile * 2 + 1];
				r_Result = make_uint4(packed_math::sm120::PackHalfPairsE4(r_Low[0], r_Low[2]),
									  packed_math::sm120::PackHalfPairsE4(r_Low[1], r_Low[3]),
									  packed_math::sm120::PackHalfPairsE4(r_High[0], r_High[2]),
									  packed_math::sm120::PackHalfPairsE4(r_High[1], r_High[3]));
			}
			else
			{
				const auto& r_Values = r_Accumulator.r_Words[r_MTile][r_NTile];
				r_Result = make_uint4(r_Values[0], r_Values[1], r_Values[2], r_Values[3]);
			}
			StoreNoAllocate(g_Output + r_NTile * 512, r_Result);
		}
	}
}
#endif
} // namespace dlssnr::reconstructed::global_ffn
