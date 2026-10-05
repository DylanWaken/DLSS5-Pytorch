#pragma once
#include "kernel_launcher/kernel_abi.h"
#include "global_contract.cuh"

// Two K512 slices form Q/K/V for two 32-channel heads. Each four-warp CTA
// owns M128 x N192; normalization and V transposition fuse into the final slice.
namespace dlssnr::kernels::global_qkv
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
using namespace dlssnr::intrinsics::sm120;
using namespace dlssnr::packed_math::sm120;
using FAccumulator = dlssnr::tiles::sm120::FAccumulatorTile<4, 6>;
using FTileCoordinates = global_contract::FTileCoordinates;

template <bool bFp8> struct FProfile : global_contract::FProfile<bFp8, true>
{
	static constexpr int SplitChannels = 512;
	static constexpr int ReductionTiles = 16;
};

template <typename Profile>
__device__ __forceinline__ void LoadWeights(uint4 (&r_Weights)[Profile::ReductionSubtiles][6],
											uint64_t g_Record, int r_ReductionTile,
											const FTileCoordinates& Tile)
{
	// The 128-byte header contains one FP32 scale per attention head. The
	// matrix following it interleaves Q32, K32, V32 within each head.
	const uint64_t g_Base =
		g_Record + 128 + uint64_t(Tile.r_Split * 512 + r_ReductionTile * 32) * 3072 * Profile::ElementBytes +
		Tile.g_OutputChannel * 32 + Tile.r_Lane * 16;
#pragma unroll
	for (int r_KSubtile = 0; r_KSubtile < Profile::ReductionSubtiles; ++r_KSubtile)
#pragma unroll
		for (int r_ChannelGroup = 0; r_ChannelGroup < 6; ++r_ChannelGroup)
			r_Weights[r_KSubtile][r_ChannelGroup] =
				__ldca(reinterpret_cast<const uint4*>(g_Base + r_KSubtile * 98304 + r_ChannelGroup * 512));
}

__device__ __forceinline__ uint32_t SumHeadChannels(uint32_t r_Sum)
{
	// Four lane groups cover the 32 head channels. Keep the Half sum order,
	// including the final exchange of the low and high packed Half values.
	r_Sum = HalfAdd(r_Sum, ShuffleBfly(r_Sum, 2, 31, 0xffffffffu));
	r_Sum = HalfAdd(r_Sum, ShuffleBfly(r_Sum, 1, 31, 0xffffffffu));
	return HalfAdd(r_Sum, (r_Sum >> 16) | (r_Sum << 16));
}

template <bool bFp8> __device__ __forceinline__ uint32_t InvertHeadSum(uint32_t r_Sum)
{
	if constexpr (bFp8)
	{
		// SumHeadChannels adds a pair to its swapped pair. After the epsilon
		// max, both Half lanes are identical, including NaN -> epsilon.
		// One conversion/SFU path therefore supplies both normalization lanes.
		const float r_Value = __half2float(__ushort_as_half(uint16_t(r_Sum)));
		const uint16_t r_Inverse = __half_as_ushort(__float2half_rn(ApproxRsqrt(r_Value)));
		return JoinHalfwords(r_Inverse, r_Inverse);
	}
	else
		return RsqrtHalf2(r_Sum);
}

template <bool bFp8, int Component>
__device__ __forceinline__ void NormalizeHead(FAccumulator& r_Accumulator, uint64_t g_Record, int g_Head)
{
	const uint32_t r_Epsilon = numerical_constants::CONST_NORMALIZATION_EPSILON_HALF2;
	const uint32_t r_HeadRoot =
		FloatToHalf2(FloatSqrtApproxFtzBits(numerical_constants::CONST_ATTENTION_HEAD_DIM_FP32_BITS));
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		auto& r_Left = r_Accumulator.r_Words[r_Spatial][Component * 2];
		auto& r_Right = r_Accumulator.r_Words[r_Spatial][Component * 2 + 1];
		uint32_t r_SquaredPairs[4];
#pragma unroll
		for (int r_Word = 0; r_Word < 4; ++r_Word)
			r_SquaredPairs[r_Word] =
				HalfAdd(HalfMul(r_Left[r_Word], r_Left[r_Word]), HalfMul(r_Right[r_Word], r_Right[r_Word]));
		const uint32_t r_Norm[2] = {
			InvertHeadSum<bFp8>(
				HalfMax(SumHeadChannels(HalfAdd(r_SquaredPairs[2], r_SquaredPairs[0])), r_Epsilon)),
			InvertHeadSum<bFp8>(
				HalfMax(SumHeadChannels(HalfAdd(r_SquaredPairs[3], r_SquaredPairs[1])), r_Epsilon))};
#pragma unroll
		for (int r_N16 = 0; r_N16 < 2; ++r_N16)
#pragma unroll
			for (int r_Word = 0; r_Word < 4; ++r_Word)
			{
				auto& r_Value = r_Accumulator.r_Words[r_Spatial][Component * 2 + r_N16][r_Word];
				r_Value = HalfMul(r_Value, r_Norm[r_Word & 1]);
				if constexpr (Component == 0)
				{
					const uint32_t r_HeadScale =
						FloatToHalf2(*reinterpret_cast<const uint32_t*>(g_Record + g_Head * 4));
					r_Value = HalfMul(HalfMul(r_Value, r_HeadRoot), r_HeadScale);
				}
			}
	}
}

enum class ESplitPublication
{
	Runtime,
	First,
	Final
};

template <bool bFp8, int Component, ESplitPublication Publication, typename TParameters>
__device__ __forceinline__ void PublishComponent(FAccumulator& r_Accumulator, const TParameters& Parameters,
												 const FTileCoordinates& Tile)
{
	using Profile = FProfile<bFp8>;
	const int g_Head = Tile.g_ChannelBlock * 2 + (Tile.r_Warp & 1);
	const uint64_t g_Output = Component == 0   ? Parameters.g_Q
							  : Component == 1 ? Parameters.g_K
											   : Parameters.g_V;
	const uint64_t g_Partial =
		bFp8 ? Parameters.g_Scratch + uint64_t(Component) * Tile.g_PaddedGroups * 32768 : g_Output;
	const bool r_bFirstSplit = Publication == ESplitPublication::Runtime
								   ? Tile.r_Split == 0
								   : Publication == ESplitPublication::First;

	// The first slice stores ordinary Half fragments. The second slice reads
	// and adds them before any normalization or storage-layout conversion.
#pragma unroll
	for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
	{
		const int g_LogicalGroup = Tile.g_TokenGroupBase + (Tile.r_Warp >> 1) * 4 + r_Spatial;
		const int g_ReadGroup = Tile.bBroadcastInput ? 0 : g_LogicalGroup;
#pragma unroll
		for (int r_N16 = 0; r_N16 < 2; ++r_N16)
		{
			auto& r_C = r_Accumulator.r_Words[r_Spatial][Component * 2 + r_N16];
			if (r_bFirstSplit)
			{
				if (g_LogicalGroup < Tile.g_PaddedGroups)
					StoreNoAllocate(g_Partial + uint64_t(g_LogicalGroup) * 32768 + g_Head * 1024 +
										r_N16 * 512 + Tile.r_Lane * 16,
									make_uint4(r_C[0], r_C[1], r_C[2], r_C[3]));
			}
			else
			{
				const uint64_t g_PartialAddress = g_Partial + uint64_t(g_ReadGroup) * 32768 + g_Head * 1024 +
												  r_N16 * 512 + Tile.r_Lane * 16;
				uint4 r_Previous;
				if constexpr (bFp8)
					r_Previous = LoadGlobalCaOrZero(g_PartialAddress, g_ReadGroup < Tile.g_PaddedGroups);
				else
					r_Previous = g_ReadGroup < Tile.g_PaddedGroups
									 ? __ldca(reinterpret_cast<const uint4*>(g_PartialAddress))
									 : make_uint4(0, 0, 0, 0);
				r_C[0] = HalfAdd(r_Previous.x, r_C[0]);
				r_C[1] = HalfAdd(r_Previous.y, r_C[1]);
				r_C[2] = HalfAdd(r_Previous.z, r_C[2]);
				r_C[3] = HalfAdd(r_Previous.w, r_C[3]);
			}
		}
	}
	if (r_bFirstSplit)
		return;
	if constexpr (Component < 2)
		NormalizeHead<bFp8, Component>(r_Accumulator, Parameters.g_Record, g_Head);
	else
	{
		// Transpose all V fragments before combining neighboring M16 tiles
		// into the FP8 consumer's M32 storage groups.
#pragma unroll
		for (int r_Spatial = 0; r_Spatial < 4; ++r_Spatial)
#pragma unroll
			for (int r_N16 = 0; r_N16 < 2; ++r_N16)
#pragma unroll
				for (int r_Word = 0; r_Word < 4; ++r_Word)
				{
					auto& r_Value = r_Accumulator.r_Words[r_Spatial][4 + r_N16][r_Word];
					r_Value = TransposeM8n8(r_Value);
				}
	}

#pragma unroll
	for (int r_Publish = 0; r_Publish < (!bFp8 && Component == 1 ? 8 : 4); ++r_Publish)
	{
		const int r_Spatial = r_Publish % 4;
		const int g_Group = Tile.g_TokenGroupBase + (Tile.r_Warp >> 1) * 4 + r_Spatial;
		if (g_Group < Tile.g_PaddedGroups)
		{
			if constexpr (bFp8 && Component == 2)
			{
				const uint64_t g_Address = g_Output + uint64_t(g_Group / 2) * 32768 + g_Head * 1024 +
										   (g_Group & 1) * 512 + Tile.r_Lane * 16;
				const auto& r_First = r_Accumulator.r_Words[(r_Spatial / 2) * 2][4 + (r_Spatial & 1)];
				const auto& r_Second = r_Accumulator.r_Words[(r_Spatial / 2) * 2 + 1][4 + (r_Spatial & 1)];
				StoreNoAllocate(g_Address, make_uint4(PackHalfPairsE4(r_First[0], r_First[1]),
													  PackHalfPairsE4(r_Second[0], r_Second[1]),
													  PackHalfPairsE4(r_First[2], r_First[3]),
													  PackHalfPairsE4(r_Second[2], r_Second[3])));
			}
			else if constexpr (bFp8)
			{
				const auto& r_Left = r_Accumulator.r_Words[r_Spatial][Component * 2];
				const auto& r_Right = r_Accumulator.r_Words[r_Spatial][Component * 2 + 1];
				const uint32_t r_HeadWords[4] = {
					PackHalfPairsE4(r_Left[0], r_Left[2]), PackHalfPairsE4(r_Left[1], r_Left[3]),
					PackHalfPairsE4(r_Right[0], r_Right[2]), PackHalfPairsE4(r_Right[1], r_Right[3])};
				StoreNoAllocate(g_Output + uint64_t(g_Group) * 16384 + g_Head * 512 + Tile.r_Lane * 16,
								make_uint4(r_HeadWords[0], r_HeadWords[Component == 1 ? 2 : 1],
										   r_HeadWords[Component == 1 ? 1 : 2], r_HeadWords[3]));
			}
			else
			{
				const uint64_t g_Address =
					g_Output + uint64_t(g_Group) * 32768 + g_Head * 1024 + Tile.r_Lane * 16;
				if constexpr (Component == 1)
				{
					// Half K interleaves N8s and publishes all M tiles of N0
					// before N1, retaining the native fragment-store schedule.
					const auto& r_Selected = r_Accumulator.r_Words[r_Spatial][2 + r_Publish / 4];
					StoreNoAllocate(g_Address + (r_Publish / 4) * 512,
									make_uint4(r_Selected[0], r_Selected[2], r_Selected[1], r_Selected[3]));
				}
				else
				{
					const auto& r_Left = r_Accumulator.r_Words[r_Spatial][Component * 2];
					const auto& r_Right = r_Accumulator.r_Words[r_Spatial][Component * 2 + 1];
					StoreNoAllocate(g_Address, make_uint4(r_Left[0], r_Left[1], r_Left[2], r_Left[3]));
					StoreNoAllocate(g_Address + 512,
									make_uint4(r_Right[0], r_Right[1], r_Right[2], r_Right[3]));
				}
			}
		}
	}
}

template <bool bFp8, ESplitPublication Publication, typename TParameters>
__device__ __forceinline__ void PublishQkv(FAccumulator& r_Accumulator, const TParameters& Parameters,
										   const FTileCoordinates& Tile)
{
	PublishComponent<bFp8, 0, Publication>(r_Accumulator, Parameters, Tile);
	PublishComponent<bFp8, 1, Publication>(r_Accumulator, Parameters, Tile);
	PublishComponent<bFp8, 2, Publication>(r_Accumulator, Parameters, Tile);
}

template <bool bFp8, typename TParameters>
__device__ __forceinline__ void RunGlobalQkv(TParameters Parameters, unsigned char* s_Storage)
{
	using Profile = FProfile<bFp8>;
	const int g_Tokens = Parameters.Batch * Parameters.Tokens;
	const int g_TokenTiles = (g_Tokens + 127) / 128;
	const int g_HeadPair = int(blockIdx.x) / g_TokenTiles;
	const int r_Lane = threadIdx.x, r_Warp = threadIdx.y;
	const FTileCoordinates Tile{(int(blockIdx.x) % g_TokenTiles) * 8,
								g_HeadPair * 192 + (r_Warp & 1) * 96,
								bFp8 ? ((g_Tokens + 31) / 32) * 2 : (g_Tokens + 15) / 16,
								g_HeadPair,
								r_Lane,
								r_Warp,
								int(blockIdx.z),
								!bFp8 && uint32_t(g_Tokens + 14) < 31};
	if (r_Lane == 0 && r_Warp == 0)
#pragma unroll
		for (int s_Stage = 0; s_Stage < 2; ++s_Stage)
			BarrierInit(s_Storage, Profile::s_BarrierOffset + s_Stage * 8, blockDim.x * blockDim.y);
	__syncthreads();

	uint4 r_Weights[Profile::ReductionSubtiles][6];
	LoadWeights<Profile>(r_Weights, Parameters.g_Record, 0, Tile);
	global_contract::IssueInputStage<Profile>(s_Storage, Parameters.g_State, 0, Tile);
	global_contract::WaitInputStage<Profile>(s_Storage, 0);
	FAccumulator r_Accumulator{};
#pragma unroll 1
	for (int r_Step = 0; r_Step < 15; ++r_Step)
	{
		global_contract::ConsumeInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, r_Step, Tile);
		global_contract::IssueInputStage<Profile>(s_Storage, Parameters.g_State, r_Step + 1, Tile);
		LoadWeights<Profile>(r_Weights, Parameters.g_Record, r_Step + 1, Tile);
		global_contract::WaitInputStage<Profile>(s_Storage, r_Step + 1);
	}
	// The native loop leaves its last ready tile for an explicit pipeline drain.
	global_contract::ConsumeInputStage<Profile>(r_Accumulator, r_Weights, s_Storage, 15, Tile);
	const uint64_t g_Counter = Parameters.g_Counter + ((Tile.g_TokenGroupBase / 8) * 16 + g_HeadPair) * 4;
	if (Tile.r_Split != 0)
	{
		if (r_Lane == 0 && r_Warp == 0)
			while (int32_t(CounterLoadRelaxed(g_Counter)) < Tile.r_Split - 1)
				PollSleep(64);
		__syncthreads();
	}
	if constexpr (bFp8)
	{
		// Native FP8 selects its first-split stores once before publication.
		// Keep that uniform choice outside all unrolled fragment operations.
		if (Tile.r_Split == 0)
			PublishQkv<true, ESplitPublication::First>(r_Accumulator, Parameters, Tile);
		else
			PublishQkv<true, ESplitPublication::Final>(r_Accumulator, Parameters, Tile);
	}
	else
		PublishQkv<false, ESplitPublication::Runtime>(r_Accumulator, Parameters, Tile);
	__syncthreads();
	if (r_Lane == 0 && r_Warp == 0)
		CounterStoreRelease(g_Counter, Tile.r_Split);
}
#endif
} // namespace dlssnr::kernels::global_qkv
