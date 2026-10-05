// Readable equivalent of cc_split_swin_16h_final_head_512_fp8; not historical source.
#pragma once
#include "channel_projection_c512_to_c1024_abi_fp8.cuh"

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8
{
__global__ __maxnreg__(168) void channel_projection_c512_to_c1024_fp8(Parameters r_Parameters)
{
#if defined(__CUDA_ARCH__) && __CUDA_ARCH__ == 1200
	__shared__ __align__(512) unsigned char s_SharedStorage[12312];
	bool r_bPtxPredicate1, r_bPtxPredicate2, r_bPtxPredicate3, r_bPtxPredicate4, r_bPtxPredicate5,
		r_bPtxPredicate6, r_bPtxPredicate7, r_bPtxPredicate8, r_bPtxPredicate9, r_bPtxPredicate10,
		r_bPtxPredicate11, r_bPtxPredicate12;
	bool r_bPtxPredicate13, r_bPtxPredicate14, r_bPtxPredicate15, r_bPtxPredicate16, r_bPtxPredicate17,
		r_bPtxPredicate18, r_bPtxPredicate19, r_bPtxPredicate20, r_bPtxPredicate21, r_bPtxPredicate22,
		r_bPtxPredicate23, r_bPtxPredicate24;
	bool r_bPtxPredicate25, r_bPtxPredicate26, r_bPtxPredicate27, r_bPtxPredicate28, r_bPtxPredicate29,
		r_bPtxPredicate30, r_bPtxPredicate31, r_bPtxPredicate32, r_bPtxPredicate33, r_bPtxPredicate34,
		r_bPtxPredicate35, r_bPtxPredicate36;
	bool r_bPtxPredicate37, r_bPtxPredicate38, r_bPtxPredicate39, r_bPtxPredicate40;
	uint16_t r_PtxU16Register1, r_ConvertedE4PairAtPtx228Rs2, r_PtxU16Register3, r_ConvertedE4PairAtPtx297Rs4,
		r_PtxU16Register5, r_ConvertedE4PairAtPtx367Rs6, r_PtxU16Register7, r_PtxU16Register8,
		r_PtxU16Register9, r_PtxU16Register10, r_PtxU16Register11, r_PtxU16Register12;
	uint16_t r_PtxU16Register13, r_PtxU16Register14, r_PtxU16Register15, r_PtxU16Register16,
		r_PtxU16Register17, r_PtxU16Register18, r_PtxU16Register19, r_ConvertedE4PairAtPtx870Rs20,
		r_ConvertedE4PairAtPtx888Rs21, r_ConvertedE4PairAtPtx891Rs22, r_ConvertedE4PairAtPtx894Rs23,
		r_ConvertedE4PairAtPtx897Rs24;
	uint16_t r_ConvertedE4PairAtPtx900Rs25, r_ConvertedE4PairAtPtx903Rs26, r_ConvertedE4PairAtPtx906Rs27,
		r_ConvertedE4PairAtPtx909Rs28, r_ConvertedE4PairAtPtx912Rs29, r_ConvertedE4PairAtPtx915Rs30,
		r_ConvertedE4PairAtPtx918Rs31, r_ConvertedE4PairAtPtx921Rs32, r_ConvertedE4PairAtPtx924Rs33,
		r_ConvertedE4PairAtPtx927Rs34, r_ConvertedE4PairAtPtx930Rs35, r_ConvertedE4PairAtPtx933Rs36;
	uint16_t r_ConvertedE4PairAtPtx936Rs37, r_ConvertedE4PairAtPtx939Rs38, r_ConvertedE4PairAtPtx942Rs39,
		r_ConvertedE4PairAtPtx945Rs40, r_ConvertedE4PairAtPtx948Rs41, r_ConvertedE4PairAtPtx951Rs42,
		r_ConvertedE4PairAtPtx954Rs43, r_ConvertedE4PairAtPtx957Rs44, r_ConvertedE4PairAtPtx960Rs45,
		r_ConvertedE4PairAtPtx963Rs46, r_ConvertedE4PairAtPtx966Rs47, r_ConvertedE4PairAtPtx969Rs48;
	uint16_t r_ConvertedE4PairAtPtx972Rs49, r_ConvertedE4PairAtPtx975Rs50, r_ConvertedE4PairAtPtx978Rs51,
		r_ConvertedE4PairAtPtx981Rs52;
	uint32_t r_Scalar32Bits, r_Scalar36Bits, r_CtaY, r_CtaZ, r_PtxRegister5, r_PtxRegister6, r_PtxRegister7,
		r_PtxRegister8, r_PtxRegister9, r_ThreadY, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_CtaX, r_PtxRegister29, r_PtxRegister30,
		r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35, r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_ThreadX, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47,
		r_PtxRegister48;
	uint32_t r_BlockSizeX, r_BlockSizeY, r_Float32BitsAtPtx62R51, r_LaneIndexAtPtx79, r_LaneIndexAtPtx87,
		r_LaneIndexAtPtx96, r_LaneIndexAtPtx105, r_LaneIndexAtPtx114, r_LaneIndexAtPtx123,
		r_LaneIndexAtPtx132, r_LaneIndexAtPtx141, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PackedHalf2AtPtx226R84;
	uint32_t r_LaneIndexAtPtx232, r_PtxRegister86, r_PackedE4WordAtPtx230R87, r_PtxRegister88,
		r_PtxRegister89, r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94,
		r_PtxRegister95, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PackedHalf2AtPtx295R100,
		r_LaneIndexAtPtx301, r_PtxRegister102, r_PackedE4WordAtPtx299R103, r_PtxRegister104, r_PtxRegister105,
		r_PtxRegister106, r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_PackedHalf2AtPtx365R119, r_LaneIndexAtPtx371;
	uint32_t r_PtxRegister121, r_PackedE4WordAtPtx369R122, r_PtxRegister123, r_PtxRegister124,
		r_PtxRegister125, r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129,
		r_PtxRegister130, r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_LaneIndexAtPtx444, r_PtxRegister136, r_LaneIndexAtPtx455,
		r_PtxRegister138, r_LaneIndexAtPtx464, r_PtxRegister140, r_LaneIndexAtPtx473, r_PtxRegister142,
		r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144;
	uint32_t r_MmaAE4x4WordAtPtx452R145, r_MmaAE4x4WordAtPtx452R146, r_MmaAE4x4WordAtPtx461R147,
		r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149, r_MmaAE4x4WordAtPtx461R150,
		r_MmaAccumulatorHalf2WordAtPtx482R151, r_MmaAccumulatorHalf2WordAtPtx482R152,
		r_MmaAccumulatorHalf2WordAtPtx489R153, r_MmaAccumulatorHalf2WordAtPtx489R154,
		r_MmaAccumulatorHalf2WordAtPtx510R155, r_MmaAccumulatorHalf2WordAtPtx510R156;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx517R157, r_MmaAccumulatorHalf2WordAtPtx517R158,
		r_MmaAccumulatorHalf2WordAtPtx538R159, r_MmaAccumulatorHalf2WordAtPtx538R160,
		r_MmaAccumulatorHalf2WordAtPtx545R161, r_MmaAccumulatorHalf2WordAtPtx545R162,
		r_MmaAccumulatorHalf2WordAtPtx566R163, r_MmaAccumulatorHalf2WordAtPtx566R164,
		r_MmaAccumulatorHalf2WordAtPtx573R165, r_MmaAccumulatorHalf2WordAtPtx573R166,
		r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168;
	uint32_t r_MmaAE4x4WordAtPtx470R169, r_MmaAE4x4WordAtPtx470R170, r_MmaAE4x4WordAtPtx479R171,
		r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173, r_MmaAE4x4WordAtPtx479R174,
		r_MmaAccumulatorHalf2WordAtPtx594R175, r_MmaAccumulatorHalf2WordAtPtx594R176,
		r_MmaAccumulatorHalf2WordAtPtx601R177, r_MmaAccumulatorHalf2WordAtPtx601R178,
		r_MmaAccumulatorHalf2WordAtPtx622R179, r_MmaAccumulatorHalf2WordAtPtx622R180;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx629R181, r_MmaAccumulatorHalf2WordAtPtx629R182,
		r_MmaAccumulatorHalf2WordAtPtx650R183, r_MmaAccumulatorHalf2WordAtPtx650R184,
		r_MmaAccumulatorHalf2WordAtPtx657R185, r_MmaAccumulatorHalf2WordAtPtx657R186,
		r_MmaAccumulatorHalf2WordAtPtx678R187, r_MmaAccumulatorHalf2WordAtPtx678R188,
		r_MmaAccumulatorHalf2WordAtPtx685R189, r_MmaAccumulatorHalf2WordAtPtx685R190, r_PtxRegister191,
		r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PtxRegister202,
		r_LaneIndexAtPtx714, r_LaneIndexAtPtx722;
	uint32_t r_LaneIndexAtPtx731, r_LaneIndexAtPtx740, r_LaneIndexAtPtx749, r_LaneIndexAtPtx758,
		r_LaneIndexAtPtx767, r_LaneIndexAtPtx776, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213,
		r_PtxRegister214, r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PackedHalf2AtPtx868R227, r_LaneIndexAtPtx874;
	uint32_t r_PtxRegister229, r_PackedE4WordAtPtx872R230, r_PtxRegister231, r_PtxRegister232,
		r_PtxRegister233, r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237,
		r_PtxRegister238, r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_LaneIndexAtPtx1001,
		r_PackedE4WordAtPtx999R245, r_PackedE4WordAtPtx998R246, r_PackedE4WordAtPtx997R247,
		r_PackedE4WordAtPtx996R248, r_LaneIndexAtPtx1009, r_PackedE4WordAtPtx995R250,
		r_PackedE4WordAtPtx994R251, r_PackedE4WordAtPtx993R252;
	uint32_t r_PackedE4WordAtPtx992R253, r_PtxRegister254, r_LaneIndexAtPtx1023, r_PackedE4WordAtPtx1031R256,
		r_PackedE4WordAtPtx1030R257, r_PackedE4WordAtPtx1029R258, r_PackedE4WordAtPtx1028R259,
		r_LaneIndexAtPtx1036, r_PackedE4WordAtPtx1044R261, r_PackedE4WordAtPtx1043R262,
		r_PackedE4WordAtPtx1042R263, r_PackedE4WordAtPtx1041R264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_PtxRegister267, r_PackedHalf2AtPtx64R268,
		r_MmaAccumulatorHalf2WordAtPtx401R269, r_MmaAccumulatorHalf2WordAtPtx402R270,
		r_MmaAccumulatorHalf2WordAtPtx403R271, r_MmaAccumulatorHalf2WordAtPtx404R272,
		r_MmaAccumulatorHalf2WordAtPtx405R273, r_MmaAccumulatorHalf2WordAtPtx406R274,
		r_MmaAccumulatorHalf2WordAtPtx407R275, r_MmaAccumulatorHalf2WordAtPtx408R276;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx409R277, r_MmaAccumulatorHalf2WordAtPtx410R278,
		r_MmaAccumulatorHalf2WordAtPtx411R279, r_MmaAccumulatorHalf2WordAtPtx412R280,
		r_MmaAccumulatorHalf2WordAtPtx413R281, r_MmaAccumulatorHalf2WordAtPtx414R282,
		r_MmaAccumulatorHalf2WordAtPtx415R283, r_MmaAccumulatorHalf2WordAtPtx416R284,
		r_MmaAccumulatorHalf2WordAtPtx417R285, r_MmaAccumulatorHalf2WordAtPtx418R286,
		r_MmaAccumulatorHalf2WordAtPtx419R287, r_MmaAccumulatorHalf2WordAtPtx420R288;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx421R289, r_MmaAccumulatorHalf2WordAtPtx422R290,
		r_MmaAccumulatorHalf2WordAtPtx423R291, r_MmaAccumulatorHalf2WordAtPtx424R292,
		r_MmaAccumulatorHalf2WordAtPtx425R293, r_MmaAccumulatorHalf2WordAtPtx426R294,
		r_MmaAccumulatorHalf2WordAtPtx427R295, r_MmaAccumulatorHalf2WordAtPtx428R296,
		r_MmaAccumulatorHalf2WordAtPtx429R297, r_MmaAccumulatorHalf2WordAtPtx430R298,
		r_MmaAccumulatorHalf2WordAtPtx431R299, r_PtxRegister300;
	uint32_t r_MmaBE4x4WordAtPtx147R301, r_MmaBE4x4WordAtPtx147R302, r_MmaBE4x4WordAtPtx147R303,
		r_MmaBE4x4WordAtPtx147R304, r_MmaBE4x4WordAtPtx138R305, r_MmaBE4x4WordAtPtx138R306,
		r_MmaBE4x4WordAtPtx138R307, r_MmaBE4x4WordAtPtx138R308, r_MmaBE4x4WordAtPtx129R309,
		r_MmaBE4x4WordAtPtx129R310, r_MmaBE4x4WordAtPtx129R311, r_MmaBE4x4WordAtPtx129R312;
	uint32_t r_MmaBE4x4WordAtPtx120R313, r_MmaBE4x4WordAtPtx120R314, r_MmaBE4x4WordAtPtx120R315,
		r_MmaBE4x4WordAtPtx120R316, r_MmaBE4x4WordAtPtx111R317, r_MmaBE4x4WordAtPtx111R318,
		r_MmaBE4x4WordAtPtx111R319, r_MmaBE4x4WordAtPtx111R320, r_MmaBE4x4WordAtPtx102R321,
		r_MmaBE4x4WordAtPtx102R322, r_MmaBE4x4WordAtPtx102R323, r_MmaBE4x4WordAtPtx102R324;
	uint32_t r_MmaBE4x4WordAtPtx93R325, r_MmaBE4x4WordAtPtx93R326, r_MmaBE4x4WordAtPtx93R327,
		r_MmaBE4x4WordAtPtx93R328, r_MmaBE4x4WordAtPtx84R329, r_MmaBE4x4WordAtPtx84R330,
		r_MmaBE4x4WordAtPtx84R331, r_MmaBE4x4WordAtPtx84R332;
	uint64_t r_Pointer0Bits, r_Pointer8Bits, r_Pointer16Bits, r_PtxU64Register4, r_PtxU64Register5,
		r_PtxU64Register6, r_PtxU64Register7, r_PtxU64Register8, r_PtxU64Register9, r_PtxU64Register10,
		r_PtxU64Register11, r_PtxU64Register12;
	uint64_t r_PtxU64Register13, r_PtxU64Register14, r_PtxU64Register15, r_PtxU64Register16,
		r_PtxU64Register17, r_PtxU64Register18, r_PtxU64Register19, r_PtxU64Register20, r_PtxU64Register21,
		r_PtxU64Register22, r_PtxU64Register23, r_PtxU64Register24;
	uint64_t r_PtxU64Register25, r_PtxU64Register26, r_PtxU64Register27, r_PtxU64Register28,
		r_PtxU64Register29, r_PtxU64Register30, r_PtxU64Register31, r_PtxU64Register32, r_PtxU64Register33,
		r_PtxU64Register34, r_PtxU64Register35, r_PtxU64Register36;
	uint64_t r_PtxU64Register37, r_PtxU64Register38, r_PtxU64Register39, r_PtxU64Register40,
		r_PtxU64Register41, r_PtxU64Register42, r_PtxU64Register43, r_PtxU64Register44, r_PtxU64Register45,
		r_PtxU64Register46, r_PtxU64Register47, r_PtxU64Register48;
	uint64_t r_PtxU64Register49, r_PtxU64Register50, r_PtxU64Register51, r_PtxU64Register52,
		r_PtxU64Register53, r_PtxU64Register54, r_PtxU64Register55, r_PtxU64Register56, r_PtxU64Register57,
		r_PtxU64Register58, r_PtxU64Register59, r_PtxU64Register60;
	uint64_t r_PtxU64Register61, r_PtxU64Register62, r_PtxU64Register63, r_PtxU64Register64,
		r_PtxU64Register65, r_PtxU64Register66, r_PtxU64Register67, r_PtxU64Register68, r_PtxU64Register69,
		r_PtxU64Register70, r_PtxU64Register71, r_PtxU64Register72;
	uint64_t r_PtxU64Register73, r_PtxU64Register74, r_PtxU64Register75, r_PtxU64Register76,
		r_PtxU64Register77, r_PtxU64Register78, r_PtxU64Register79, r_PtxU64Register80, r_PtxU64Register81,
		r_PtxU64Register82, r_PtxU64Register83, r_PtxU64Register84;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_Pointer0Bits = uint64_t(r_Parameters.g_Pointer0);	  // PTX L14
	r_Pointer8Bits = uint64_t(r_Parameters.g_Pointer8);	  // PTX L15
	r_Pointer16Bits = uint64_t(r_Parameters.g_Pointer16); // PTX L16
	r_Scalar32Bits = uint32_t(r_Parameters.Scalar32);
	r_Scalar36Bits = uint32_t(r_Parameters.Scalar36);							// PTX L17
	r_CtaX = uint32_t(blockIdx.x);												// PTX L18
	r_CtaY = uint32_t(blockIdx.y);												// PTX L19
	r_CtaZ = uint32_t(blockIdx.z);												// PTX L20
	r_PtxRegister29 = uint32_t(r_Scalar36Bits) + uint32_t(-1);					// PTX L21
	r_PtxRegister30 = ShiftRightSigned(int32_t(r_PtxRegister29), uint32_t(31)); // PTX L22
	r_PtxRegister31 = ShiftRight(uint32_t(r_PtxRegister30), uint32_t(29));		// PTX L23
	r_PtxRegister32 = uint32_t(r_PtxRegister29) + uint32_t(r_PtxRegister31);	// PTX L24
	r_PtxRegister33 = ShiftRightSigned(int32_t(r_PtxRegister32), uint32_t(3));	// PTX L25
	r_PtxRegister34 = uint32_t(r_PtxRegister33) + uint32_t(1);					// PTX L26
	r_PtxRegister5 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister34));		// PTX L27
	r_PtxRegister35 =
		uint32_t(r_PtxRegister5) * uint32_t(r_PtxRegister33) + uint32_t(r_PtxRegister5); // PTX L28
	r_PtxRegister36 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister35);						 // PTX L29
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister36), uint32_t(1));					 // PTX L30
	r_PtxRegister7 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9));							 // PTX L31
	r_PtxRegister37 = ShiftRightSigned(int32_t(r_Scalar32Bits), uint32_t(31));			 // PTX L32
	r_PtxRegister38 = ShiftRight(uint32_t(r_PtxRegister37), uint32_t(30));				 // PTX L33
	r_PtxRegister39 = uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister38);				 // PTX L34
	r_PtxRegister8 = ShiftRightSigned(int32_t(r_PtxRegister39), uint32_t(2));			 // PTX L35
	r_PtxRegister40 = ShiftRightSigned(int32_t(r_Scalar36Bits), uint32_t(31));			 // PTX L36
	r_PtxRegister41 = ShiftRight(uint32_t(r_PtxRegister40), uint32_t(30));				 // PTX L37
	r_PtxRegister42 = uint32_t(r_Scalar36Bits) + uint32_t(r_PtxRegister41);				 // PTX L38
	r_PtxRegister9 = ShiftRightSigned(int32_t(r_PtxRegister42), uint32_t(2));			 // PTX L39
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L40
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L41
	r_PtxRegister44 = r_ThreadX | r_ThreadY;											 // PTX L42
	r_bPtxPredicate4 = uint32_t(r_PtxRegister44) != uint32_t(0);						 // PTX L43
	if (r_bPtxPredicate4)
	{
		goto L__BB43_2;
	} // PTX L44
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L45
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L46
	r_PtxRegister46 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L47
	r_PtxRegister45 = uint32_t(12288u /* exact native shared-region offset */); // PTX L48
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister45, r_PtxRegister46); // PTX L50
	r_PtxRegister47 = uint32_t(r_PtxRegister45) + uint32_t(8);		// PTX L52
	BarrierInit(s_SharedStorage, r_PtxRegister47, r_PtxRegister46); // PTX L54
	r_PtxRegister48 = uint32_t(r_PtxRegister45) + uint32_t(16);		// PTX L56
	BarrierInit(s_SharedStorage, r_PtxRegister48, r_PtxRegister46); // PTX L58
L__BB43_2:															// PTX L60
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L61
	r_Float32BitsAtPtx62R51 = uint32_t(0);														// PTX L62
	r_PackedHalf2AtPtx64R268 = FloatToHalf2(r_Float32BitsAtPtx62R51);							// PTX L64
	r_PtxRegister60 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L69
	r_PtxRegister61 = r_PtxRegister60 & 192;													// PTX L70
	r_PtxRegister62 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(8));							// PTX L71
	r_PtxRegister11 = r_PtxRegister61 | r_PtxRegister62;										// PTX L72
	r_PtxRegister63 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(17));								// PTX L73
	r_PtxRegister12 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(3));						// PTX L74
	r_PtxRegister64 = uint32_t(r_PtxRegister63) + uint32_t(r_PtxRegister12);					// PTX L75
	r_PtxU64Register13 = uint64_t(int64_t(int32_t(r_PtxRegister64)) * int64_t(int32_t(4)));		// PTX L76
	r_PtxU64Register14 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register13);				// PTX L77
	r_LaneIndexAtPtx79 = uint32_t((threadIdx.x & 31u));											// PTX L79
	r_PtxU64Register15 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx79)) * int64_t(int32_t(16))); // PTX L81
	r_PtxU64Register5 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register15);			// PTX L82
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register5));
		r_MmaBE4x4WordAtPtx84R332 = r_Value.x;
		r_MmaBE4x4WordAtPtx84R331 = r_Value.y;
		r_MmaBE4x4WordAtPtx84R330 = r_Value.z;
		r_MmaBE4x4WordAtPtx84R329 = r_Value.w;
	} // PTX L84
	r_LaneIndexAtPtx87 = uint32_t((threadIdx.x & 31u));											// PTX L87
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx87)) * int64_t(int32_t(16))); // PTX L89
	r_PtxU64Register17 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register16);			// PTX L90
	r_PtxU64Register6 = uint64_t(r_PtxU64Register17) + uint64_t(512);							// PTX L91
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register6));
		r_MmaBE4x4WordAtPtx93R328 = r_Value.x;
		r_MmaBE4x4WordAtPtx93R327 = r_Value.y;
		r_MmaBE4x4WordAtPtx93R326 = r_Value.z;
		r_MmaBE4x4WordAtPtx93R325 = r_Value.w;
	} // PTX L93
	r_LaneIndexAtPtx96 = uint32_t((threadIdx.x & 31u));											// PTX L96
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx96)) * int64_t(int32_t(16))); // PTX L98
	r_PtxU64Register19 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register18);			// PTX L99
	r_PtxU64Register7 = uint64_t(r_PtxU64Register19) + uint64_t(1024);							// PTX L100
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register7));
		r_MmaBE4x4WordAtPtx102R324 = r_Value.x;
		r_MmaBE4x4WordAtPtx102R323 = r_Value.y;
		r_MmaBE4x4WordAtPtx102R322 = r_Value.z;
		r_MmaBE4x4WordAtPtx102R321 = r_Value.w;
	} // PTX L102
	r_LaneIndexAtPtx105 = uint32_t((threadIdx.x & 31u));										 // PTX L105
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx105)) * int64_t(int32_t(16))); // PTX L107
	r_PtxU64Register21 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register20);			 // PTX L108
	r_PtxU64Register8 = uint64_t(r_PtxU64Register21) + uint64_t(1536);							 // PTX L109
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register8));
		r_MmaBE4x4WordAtPtx111R320 = r_Value.x;
		r_MmaBE4x4WordAtPtx111R319 = r_Value.y;
		r_MmaBE4x4WordAtPtx111R318 = r_Value.z;
		r_MmaBE4x4WordAtPtx111R317 = r_Value.w;
	} // PTX L111
	r_LaneIndexAtPtx114 = uint32_t((threadIdx.x & 31u));										 // PTX L114
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx114)) * int64_t(int32_t(16))); // PTX L116
	r_PtxU64Register23 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register22);			 // PTX L117
	r_PtxU64Register9 = uint64_t(r_PtxU64Register23) + uint64_t(32768);							 // PTX L118
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register9));
		r_MmaBE4x4WordAtPtx120R316 = r_Value.x;
		r_MmaBE4x4WordAtPtx120R315 = r_Value.y;
		r_MmaBE4x4WordAtPtx120R314 = r_Value.z;
		r_MmaBE4x4WordAtPtx120R313 = r_Value.w;
	} // PTX L120
	r_LaneIndexAtPtx123 = uint32_t((threadIdx.x & 31u));										 // PTX L123
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx123)) * int64_t(int32_t(16))); // PTX L125
	r_PtxU64Register25 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register24);			 // PTX L126
	r_PtxU64Register10 = uint64_t(r_PtxU64Register25) + uint64_t(33280);						 // PTX L127
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register10));
		r_MmaBE4x4WordAtPtx129R312 = r_Value.x;
		r_MmaBE4x4WordAtPtx129R311 = r_Value.y;
		r_MmaBE4x4WordAtPtx129R310 = r_Value.z;
		r_MmaBE4x4WordAtPtx129R309 = r_Value.w;
	} // PTX L129
	r_LaneIndexAtPtx132 = uint32_t((threadIdx.x & 31u));										 // PTX L132
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx132)) * int64_t(int32_t(16))); // PTX L134
	r_PtxU64Register27 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register26);			 // PTX L135
	r_PtxU64Register11 = uint64_t(r_PtxU64Register27) + uint64_t(33792);						 // PTX L136
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register11));
		r_MmaBE4x4WordAtPtx138R308 = r_Value.x;
		r_MmaBE4x4WordAtPtx138R307 = r_Value.y;
		r_MmaBE4x4WordAtPtx138R306 = r_Value.z;
		r_MmaBE4x4WordAtPtx138R305 = r_Value.w;
	} // PTX L138
	r_LaneIndexAtPtx141 = uint32_t((threadIdx.x & 31u));										 // PTX L141
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx141)) * int64_t(int32_t(16))); // PTX L143
	r_PtxU64Register29 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register28);			 // PTX L144
	r_PtxU64Register12 = uint64_t(r_PtxU64Register29) + uint64_t(34304);						 // PTX L145
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register12));
		r_MmaBE4x4WordAtPtx147R304 = r_Value.x;
		r_MmaBE4x4WordAtPtx147R303 = r_Value.y;
		r_MmaBE4x4WordAtPtx147R302 = r_Value.z;
		r_MmaBE4x4WordAtPtx147R301 = r_Value.w;
	} // PTX L147
	r_PtxRegister65 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));			 // PTX L149
	r_PtxRegister66 = r_PtxRegister65 & 1;									 // PTX L150
	r_PtxRegister13 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));			 // PTX L151
	r_PtxRegister67 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(5));			 // PTX L152
	r_PtxRegister68 = r_PtxRegister67 & 32;									 // PTX L153
	r_PtxRegister69 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(9));	 // PTX L154
	r_PtxRegister70 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			 // PTX L155
	r_PtxRegister71 = r_PtxRegister70 & 256;								 // PTX L156
	r_PtxRegister72 = r_PtxRegister69 | r_PtxRegister71;					 // PTX L157
	r_PtxRegister73 = r_PtxRegister70 & 128;								 // PTX L158
	r_PtxRegister14 = r_PtxRegister72 | r_PtxRegister73;					 // PTX L159
	r_PtxRegister74 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));				 // PTX L160
	r_PtxRegister75 = uint32_t(r_PtxRegister13) + uint32_t(r_PtxRegister74); // PTX L161
	r_PtxRegister15 = uint32_t(r_PtxRegister66) + uint32_t(r_PtxRegister6);	 // PTX L162
	r_PtxRegister16 = uint32_t(r_PtxRegister68) + uint32_t(r_PtxRegister7);	 // PTX L163
	r_PtxRegister17 = r_Scalar32Bits & -4;									 // PTX L164
	r_bPtxPredicate5 = uint32_t(r_PtxRegister17) == uint32_t(4);			 // PTX L165
	r_bPtxPredicate6 = int32_t(r_PtxRegister75) < int32_t(r_PtxRegister8);	 // PTX L166
	r_PtxRegister18 = uint32_t(r_PtxRegister75) * uint32_t(r_PtxRegister9);	 // PTX L167
	r_PtxRegister19 = r_bPtxPredicate5 ? 0 : r_PtxRegister18;				 // PTX L168
	r_bPtxPredicate1 = r_bPtxPredicate5 | r_bPtxPredicate6;					 // PTX L169
	r_bPtxPredicate38 = bool(0);											 // PTX L170
	r_bPtxPredicate7 = !r_bPtxPredicate1;									 // PTX L171
	r_PtxRegister265 = uint32_t(r_PtxRegister15);							 // PTX L172
	if (r_bPtxPredicate7)
	{
		goto L__BB43_5;
	} // PTX L173
	r_PtxRegister76 = r_Scalar36Bits & -4;						 // PTX L174
	r_bPtxPredicate8 = uint32_t(r_PtxRegister76) == uint32_t(4); // PTX L175
	r_bPtxPredicate38 = bool(-1);								 // PTX L176
	r_PtxRegister265 = uint32_t(0);								 // PTX L177
	if (r_bPtxPredicate8)
	{
		goto L__BB43_5;
	} // PTX L178
	r_bPtxPredicate38 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister9); // PTX L179
	r_PtxRegister265 = uint32_t(r_PtxRegister15);							// PTX L180
L__BB43_5:																	// PTX L181
	r_PtxU64Register77 = uint64_t(0);										// PTX L182
	r_bPtxPredicate9 = !r_bPtxPredicate38;									// PTX L183
	if (r_bPtxPredicate9)
	{
		goto L__BB43_7;
	} // PTX L184
	r_PtxRegister77 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister265); // PTX L185
	r_PtxRegister78 = ShiftLeft(uint32_t(r_PtxRegister77), uint32_t(11));	  // PTX L186
	r_PtxRegister79 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));	  // PTX L187
	r_PtxRegister80 = uint32_t(r_PtxRegister78) + uint32_t(r_PtxRegister79);  // PTX L188
	r_PtxU64Register77 = SignExtendWordBits(r_PtxRegister80);				  // PTX L189
L__BB43_7:																	  // PTX L190
	r_PtxU64Register78 = uint64_t(0);										  // PTX L191
	if (r_bPtxPredicate9)
	{
		goto L__BB43_9;
	} // PTX L192
	r_PtxU64Register30 = ShiftLeft(uint64_t(r_PtxU64Register77), uint32_t(2));	  // PTX L193
	r_PtxU64Register78 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register30); // PTX L194
L__BB43_9:																		  // PTX L195
	r_PtxRegister81 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));		  // PTX L196
	r_PtxRegister82 = uint32_t(0u /* exact native shared-region offset */);		  // PTX L197
	r_PtxRegister91 = uint32_t(r_PtxRegister82) + uint32_t(r_PtxRegister81);	  // PTX L198
	if (r_bPtxPredicate9)
	{
		goto L__BB43_12;
	} // PTX L199
	r_PtxRegister90 = uint32_t(-1);								  // PTX L200
	r_PtxRegister89 = Elected(r_PtxRegister90);					  // PTX L202
	r_bPtxPredicate10 = uint32_t(r_PtxRegister89) == uint32_t(0); // PTX L208
	if (r_bPtxPredicate10)
	{
		goto L__BB43_13;
	} // PTX L209
	r_PtxU64Register31 = r_PtxU64Register78;									// PTX L210
	r_PtxRegister93 = uint32_t(12288u /* exact native shared-region offset */); // PTX L211
	r_PtxRegister92 = uint32_t(512);											// PTX L212
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister91, r_PtxU64Register31, r_PtxRegister92,
			 r_PtxRegister93);																 // PTX L214
	BarrierExpect(s_SharedStorage, r_PtxRegister93, r_PtxRegister92);						 // PTX L217
	goto L__BB43_13;																		 // PTX L219
L__BB43_12:																					 // PTX L220
	r_PtxRegister83 = uint32_t(0);															 // PTX L221
	r_PtxU16Register1 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister83))); // PTX L223
	r_PackedHalf2AtPtx226R84 = JoinHalfwords(r_PtxU16Register1, r_PtxU16Register1);			 // PTX L226
	r_ConvertedE4PairAtPtx228Rs2 = PublishE4(r_PackedHalf2AtPtx226R84);						 // PTX L228
	r_PackedE4WordAtPtx230R87 =
		JoinHalfwords(r_ConvertedE4PairAtPtx228Rs2, r_ConvertedE4PairAtPtx228Rs2); // PTX L230
	r_LaneIndexAtPtx232 = uint32_t((threadIdx.x & 31u));						   // PTX L232
	r_PtxRegister88 = ShiftLeft(uint32_t(r_LaneIndexAtPtx232), uint32_t(4));	   // PTX L234
	r_PtxRegister86 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister88);	   // PTX L235
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister86)) =
		make_uint4(r_PackedE4WordAtPtx230R87, r_PackedE4WordAtPtx230R87, r_PackedE4WordAtPtx230R87,
				   r_PackedE4WordAtPtx230R87);					// PTX L237
L__BB43_13:														// PTX L239
	r_PtxRegister20 = uint32_t(r_PtxRegister16) + uint32_t(64); // PTX L240
	r_bPtxPredicate39 = bool(0);								// PTX L241
	r_PtxRegister266 = uint32_t(r_PtxRegister15);				// PTX L242
	if (r_bPtxPredicate7)
	{
		goto L__BB43_16;
	} // PTX L243
	r_PtxRegister94 = r_Scalar36Bits & -4;						  // PTX L244
	r_bPtxPredicate11 = uint32_t(r_PtxRegister94) == uint32_t(4); // PTX L245
	r_bPtxPredicate39 = bool(-1);								  // PTX L246
	r_PtxRegister266 = uint32_t(0);								  // PTX L247
	if (r_bPtxPredicate11)
	{
		goto L__BB43_16;
	} // PTX L248
	r_bPtxPredicate39 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister9); // PTX L249
	r_PtxRegister266 = uint32_t(r_PtxRegister15);							// PTX L250
L__BB43_16:																	// PTX L251
	r_PtxU64Register79 = uint64_t(0);										// PTX L252
	r_bPtxPredicate12 = !r_bPtxPredicate39;									// PTX L253
	if (r_bPtxPredicate12)
	{
		goto L__BB43_18;
	} // PTX L254
	r_PtxRegister95 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister266); // PTX L255
	r_PtxRegister96 = ShiftLeft(uint32_t(r_PtxRegister95), uint32_t(11));	  // PTX L256
	r_PtxRegister97 = ShiftLeft(uint32_t(r_PtxRegister20), uint32_t(2));	  // PTX L257
	r_PtxRegister98 = uint32_t(r_PtxRegister96) + uint32_t(r_PtxRegister97);  // PTX L258
	r_PtxU64Register79 = SignExtendWordBits(r_PtxRegister98);				  // PTX L259
L__BB43_18:																	  // PTX L260
	r_PtxU64Register80 = uint64_t(0);										  // PTX L261
	if (r_bPtxPredicate12)
	{
		goto L__BB43_20;
	} // PTX L262
	r_PtxU64Register32 = ShiftLeft(uint64_t(r_PtxU64Register79), uint32_t(2));	  // PTX L263
	r_PtxU64Register80 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register32); // PTX L264
L__BB43_20:																		  // PTX L265
	if (r_bPtxPredicate12)
	{
		goto L__BB43_23;
	} // PTX L266
	r_PtxRegister107 = uint32_t(-1);							   // PTX L267
	r_PtxRegister106 = Elected(r_PtxRegister107);				   // PTX L269
	r_bPtxPredicate13 = uint32_t(r_PtxRegister106) == uint32_t(0); // PTX L275
	if (r_bPtxPredicate13)
	{
		goto L__BB43_24;
	} // PTX L276
	r_PtxRegister108 = uint32_t(r_PtxRegister91) + uint32_t(4096);				 // PTX L277
	r_PtxU64Register33 = r_PtxU64Register80;									 // PTX L278
	r_PtxRegister111 = uint32_t(12288u /* exact native shared-region offset */); // PTX L279
	r_PtxRegister110 = uint32_t(r_PtxRegister111) + uint32_t(8);				 // PTX L280
	r_PtxRegister109 = uint32_t(512);											 // PTX L281
	CopyBulk(s_SharedStorage, r_PtxRegister108, r_PtxU64Register33, r_PtxRegister109,
			 r_PtxRegister110);																 // PTX L283
	BarrierExpect(s_SharedStorage, r_PtxRegister110, r_PtxRegister109);						 // PTX L286
	goto L__BB43_24;																		 // PTX L288
L__BB43_23:																					 // PTX L289
	r_PtxRegister99 = uint32_t(0);															 // PTX L290
	r_PtxU16Register3 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister99))); // PTX L292
	r_PackedHalf2AtPtx295R100 = JoinHalfwords(r_PtxU16Register3, r_PtxU16Register3);		 // PTX L295
	r_ConvertedE4PairAtPtx297Rs4 = PublishE4(r_PackedHalf2AtPtx295R100);					 // PTX L297
	r_PackedE4WordAtPtx299R103 =
		JoinHalfwords(r_ConvertedE4PairAtPtx297Rs4, r_ConvertedE4PairAtPtx297Rs4); // PTX L299
	r_LaneIndexAtPtx301 = uint32_t((threadIdx.x & 31u));						   // PTX L301
	r_PtxRegister104 = ShiftLeft(uint32_t(r_LaneIndexAtPtx301), uint32_t(4));	   // PTX L303
	r_PtxRegister105 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister104);	   // PTX L304
	r_PtxRegister102 = uint32_t(r_PtxRegister105) + uint32_t(4096);				   // PTX L305
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister102)) =
		make_uint4(r_PackedE4WordAtPtx299R103, r_PackedE4WordAtPtx299R103, r_PackedE4WordAtPtx299R103,
				   r_PackedE4WordAtPtx299R103);	  // PTX L307
L__BB43_24:										  // PTX L309
	r_bPtxPredicate40 = bool(0);				  // PTX L310
	r_PtxRegister267 = uint32_t(r_PtxRegister15); // PTX L311
	if (r_bPtxPredicate7)
	{
		goto L__BB43_27;
	} // PTX L312
	r_PtxRegister112 = r_Scalar36Bits & -4;						   // PTX L313
	r_bPtxPredicate14 = uint32_t(r_PtxRegister112) == uint32_t(4); // PTX L314
	r_bPtxPredicate40 = bool(-1);								   // PTX L315
	r_PtxRegister267 = uint32_t(0);								   // PTX L316
	if (r_bPtxPredicate14)
	{
		goto L__BB43_27;
	} // PTX L317
	r_bPtxPredicate40 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister9); // PTX L318
	r_PtxRegister267 = uint32_t(r_PtxRegister15);							// PTX L319
L__BB43_27:																	// PTX L320
	r_PtxU64Register81 = uint64_t(0);										// PTX L321
	r_bPtxPredicate15 = !r_bPtxPredicate40;									// PTX L322
	if (r_bPtxPredicate15)
	{
		goto L__BB43_29;
	} // PTX L323
	r_PtxRegister113 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister267);	// PTX L324
	r_PtxRegister114 = ShiftLeft(uint32_t(r_PtxRegister113), uint32_t(11));		// PTX L325
	r_PtxRegister115 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));		// PTX L326
	r_PtxRegister116 = uint32_t(r_PtxRegister115) + uint32_t(r_PtxRegister114); // PTX L327
	r_PtxRegister117 = uint32_t(r_PtxRegister116) + uint32_t(512);				// PTX L328
	r_PtxU64Register81 = SignExtendWordBits(r_PtxRegister117);					// PTX L329
L__BB43_29:																		// PTX L330
	r_PtxU64Register82 = uint64_t(0);											// PTX L331
	if (r_bPtxPredicate15)
	{
		goto L__BB43_31;
	} // PTX L332
	r_PtxU64Register34 = ShiftLeft(uint64_t(r_PtxU64Register81), uint32_t(2));	  // PTX L333
	r_PtxU64Register82 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register34); // PTX L334
L__BB43_31:																		  // PTX L335
	if (r_bPtxPredicate15)
	{
		goto L__BB43_34;
	} // PTX L336
	r_PtxRegister126 = uint32_t(-1);							   // PTX L337
	r_PtxRegister125 = Elected(r_PtxRegister126);				   // PTX L339
	r_bPtxPredicate16 = uint32_t(r_PtxRegister125) == uint32_t(0); // PTX L345
	if (r_bPtxPredicate16)
	{
		goto L__BB43_35;
	} // PTX L346
	r_PtxRegister127 = uint32_t(r_PtxRegister91) + uint32_t(8192);				 // PTX L347
	r_PtxU64Register35 = r_PtxU64Register82;									 // PTX L348
	r_PtxRegister130 = uint32_t(12288u /* exact native shared-region offset */); // PTX L349
	r_PtxRegister129 = uint32_t(r_PtxRegister130) + uint32_t(16);				 // PTX L350
	r_PtxRegister128 = uint32_t(512);											 // PTX L351
	CopyBulk(s_SharedStorage, r_PtxRegister127, r_PtxU64Register35, r_PtxRegister128,
			 r_PtxRegister129);																  // PTX L353
	BarrierExpect(s_SharedStorage, r_PtxRegister129, r_PtxRegister128);						  // PTX L356
	goto L__BB43_35;																		  // PTX L358
L__BB43_34:																					  // PTX L359
	r_PtxRegister118 = uint32_t(0);															  // PTX L360
	r_PtxU16Register5 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister118))); // PTX L362
	r_PackedHalf2AtPtx365R119 = JoinHalfwords(r_PtxU16Register5, r_PtxU16Register5);		  // PTX L365
	r_ConvertedE4PairAtPtx367Rs6 = PublishE4(r_PackedHalf2AtPtx365R119);					  // PTX L367
	r_PackedE4WordAtPtx369R122 =
		JoinHalfwords(r_ConvertedE4PairAtPtx367Rs6, r_ConvertedE4PairAtPtx367Rs6); // PTX L369
	r_LaneIndexAtPtx371 = uint32_t((threadIdx.x & 31u));						   // PTX L371
	r_PtxRegister123 = ShiftLeft(uint32_t(r_LaneIndexAtPtx371), uint32_t(4));	   // PTX L373
	r_PtxRegister124 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister123);	   // PTX L374
	r_PtxRegister121 = uint32_t(r_PtxRegister124) + uint32_t(8192);				   // PTX L375
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister121)) =
		make_uint4(r_PackedE4WordAtPtx369R122, r_PackedE4WordAtPtx369R122, r_PackedE4WordAtPtx369R122,
				   r_PackedE4WordAtPtx369R122);									 // PTX L377
L__BB43_35:																		 // PTX L379
	r_PtxRegister131 = uint32_t(12288u /* exact native shared-region offset */); // PTX L380
	r_PtxRegister132 = uint32_t(1);												 // PTX L381
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register36 = BarrierArrive(s_SharedStorage, r_PtxRegister131, r_PtxRegister132); // PTX L383
L__BB43_36:																					 // PTX L385
	r_PtxRegister134 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L386
	r_PtxRegister133 = BarrierReady(s_SharedStorage, r_PtxRegister134, r_PtxU64Register36);	 // PTX L388
	r_bPtxPredicate17 = uint32_t(r_PtxRegister133) == uint32_t(0);							 // PTX L394
	if (r_bPtxPredicate17)
	{
		goto L__BB43_36;
	} // PTX L395
	r_PtxRegister21 = r_Scalar36Bits & -4;														   // PTX L396
	r_PtxRegister22 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(11));						   // PTX L397
	r_PtxRegister23 = uint32_t(r_PtxRegister20) + uint32_t(128);								   // PTX L398
	r_bPtxPredicate2 = int32_t(r_PtxRegister75) < int32_t(r_PtxRegister8);						   // PTX L399
	r_PtxRegister300 = uint32_t(0);																   // PTX L400
	r_MmaAccumulatorHalf2WordAtPtx401R269 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L401
	r_MmaAccumulatorHalf2WordAtPtx402R270 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L402
	r_MmaAccumulatorHalf2WordAtPtx403R271 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L403
	r_MmaAccumulatorHalf2WordAtPtx404R272 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L404
	r_MmaAccumulatorHalf2WordAtPtx405R273 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L405
	r_MmaAccumulatorHalf2WordAtPtx406R274 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L406
	r_MmaAccumulatorHalf2WordAtPtx407R275 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L407
	r_MmaAccumulatorHalf2WordAtPtx408R276 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L408
	r_MmaAccumulatorHalf2WordAtPtx409R277 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L409
	r_MmaAccumulatorHalf2WordAtPtx410R278 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L410
	r_MmaAccumulatorHalf2WordAtPtx411R279 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L411
	r_MmaAccumulatorHalf2WordAtPtx412R280 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L412
	r_MmaAccumulatorHalf2WordAtPtx413R281 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L413
	r_MmaAccumulatorHalf2WordAtPtx414R282 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L414
	r_MmaAccumulatorHalf2WordAtPtx415R283 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L415
	r_MmaAccumulatorHalf2WordAtPtx416R284 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L416
	r_MmaAccumulatorHalf2WordAtPtx417R285 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L417
	r_MmaAccumulatorHalf2WordAtPtx418R286 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L418
	r_MmaAccumulatorHalf2WordAtPtx419R287 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L419
	r_MmaAccumulatorHalf2WordAtPtx420R288 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L420
	r_MmaAccumulatorHalf2WordAtPtx421R289 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L421
	r_MmaAccumulatorHalf2WordAtPtx422R290 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L422
	r_MmaAccumulatorHalf2WordAtPtx423R291 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L423
	r_MmaAccumulatorHalf2WordAtPtx424R292 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L424
	r_MmaAccumulatorHalf2WordAtPtx425R293 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L425
	r_MmaAccumulatorHalf2WordAtPtx426R294 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L426
	r_MmaAccumulatorHalf2WordAtPtx427R295 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L427
	r_MmaAccumulatorHalf2WordAtPtx428R296 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L428
	r_MmaAccumulatorHalf2WordAtPtx429R297 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L429
	r_MmaAccumulatorHalf2WordAtPtx430R298 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L430
	r_MmaAccumulatorHalf2WordAtPtx431R299 = uint32_t(r_PackedHalf2AtPtx64R268);					   // PTX L431
L__BB43_38:																						   // PTX L432
	r_PtxRegister191 = ShiftRight(uint32_t(r_PtxRegister300), uint32_t(6));						   // PTX L433
	r_PtxU16Register7 = uint16_t(r_PtxRegister191);												   // PTX L434
	r_PtxU16Register8 = uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171))); // PTX L435
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					   // PTX L436
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3)));  // PTX L437
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			   // PTX L438
	r_PtxRegister192 = uint32_t(uint16_t(r_PtxU16Register11));									   // PTX L439
	r_PtxRegister24 = r_PtxRegister192 & 255;													   // PTX L440
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												   // PTX L441
	r_PtxRegister25 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(4096));		   // PTX L442
	r_LaneIndexAtPtx444 = uint32_t((threadIdx.x & 31u));										   // PTX L444
	r_PtxRegister193 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister22);					   // PTX L446
	r_PtxRegister194 = uint32_t(0u /* exact native shared-region offset */);					   // PTX L447
	r_PtxRegister195 = uint32_t(r_PtxRegister194) + uint32_t(r_PtxRegister193);					   // PTX L448
	r_PtxRegister196 = ShiftLeft(uint32_t(r_LaneIndexAtPtx444), uint32_t(4));					   // PTX L449
	r_PtxRegister136 = uint32_t(r_PtxRegister195) + uint32_t(r_PtxRegister196);					   // PTX L450
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister136));
		r_MmaAE4x4WordAtPtx452R143 = r_Value.x;
		r_MmaAE4x4WordAtPtx452R144 = r_Value.y;
		r_MmaAE4x4WordAtPtx452R145 = r_Value.z;
		r_MmaAE4x4WordAtPtx452R146 = r_Value.w;
	} // PTX L452
	r_LaneIndexAtPtx455 = uint32_t((threadIdx.x & 31u));						// PTX L455
	r_PtxRegister197 = ShiftLeft(uint32_t(r_LaneIndexAtPtx455), uint32_t(4));	// PTX L457
	r_PtxRegister198 = uint32_t(r_PtxRegister195) + uint32_t(r_PtxRegister197); // PTX L458
	r_PtxRegister138 = uint32_t(r_PtxRegister198) + uint32_t(512);				// PTX L459
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister138));
		r_MmaAE4x4WordAtPtx461R147 = r_Value.x;
		r_MmaAE4x4WordAtPtx461R148 = r_Value.y;
		r_MmaAE4x4WordAtPtx461R149 = r_Value.z;
		r_MmaAE4x4WordAtPtx461R150 = r_Value.w;
	} // PTX L461
	r_LaneIndexAtPtx464 = uint32_t((threadIdx.x & 31u));						// PTX L464
	r_PtxRegister199 = ShiftLeft(uint32_t(r_LaneIndexAtPtx464), uint32_t(4));	// PTX L466
	r_PtxRegister200 = uint32_t(r_PtxRegister195) + uint32_t(r_PtxRegister199); // PTX L467
	r_PtxRegister140 = uint32_t(r_PtxRegister200) + uint32_t(1024);				// PTX L468
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister140));
		r_MmaAE4x4WordAtPtx470R167 = r_Value.x;
		r_MmaAE4x4WordAtPtx470R168 = r_Value.y;
		r_MmaAE4x4WordAtPtx470R169 = r_Value.z;
		r_MmaAE4x4WordAtPtx470R170 = r_Value.w;
	} // PTX L470
	r_LaneIndexAtPtx473 = uint32_t((threadIdx.x & 31u));						// PTX L473
	r_PtxRegister201 = ShiftLeft(uint32_t(r_LaneIndexAtPtx473), uint32_t(4));	// PTX L475
	r_PtxRegister202 = uint32_t(r_PtxRegister195) + uint32_t(r_PtxRegister201); // PTX L476
	r_PtxRegister142 = uint32_t(r_PtxRegister202) + uint32_t(1536);				// PTX L477
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister142));
		r_MmaAE4x4WordAtPtx479R171 = r_Value.x;
		r_MmaAE4x4WordAtPtx479R172 = r_Value.y;
		r_MmaAE4x4WordAtPtx479R173 = r_Value.z;
		r_MmaAE4x4WordAtPtx479R174 = r_Value.w;
	} // PTX L479
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx482R151, r_MmaAccumulatorHalf2WordAtPtx482R152,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx84R332, r_MmaBE4x4WordAtPtx84R331,
		  r_MmaAccumulatorHalf2WordAtPtx421R289,
		  r_MmaAccumulatorHalf2WordAtPtx420R288); // PTX L482
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx489R153, r_MmaAccumulatorHalf2WordAtPtx489R154,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx84R330, r_MmaBE4x4WordAtPtx84R329,
		  r_MmaAccumulatorHalf2WordAtPtx419R287,
		  r_MmaAccumulatorHalf2WordAtPtx418R286); // PTX L489
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx421R289, r_MmaAccumulatorHalf2WordAtPtx420R288,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx120R316, r_MmaBE4x4WordAtPtx120R315,
		  r_MmaAccumulatorHalf2WordAtPtx482R151,
		  r_MmaAccumulatorHalf2WordAtPtx482R152); // PTX L496
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx419R287, r_MmaAccumulatorHalf2WordAtPtx418R286,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx120R314, r_MmaBE4x4WordAtPtx120R313,
		  r_MmaAccumulatorHalf2WordAtPtx489R153,
		  r_MmaAccumulatorHalf2WordAtPtx489R154); // PTX L503
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx510R155, r_MmaAccumulatorHalf2WordAtPtx510R156,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx93R328, r_MmaBE4x4WordAtPtx93R327,
		  r_MmaAccumulatorHalf2WordAtPtx417R285,
		  r_MmaAccumulatorHalf2WordAtPtx416R284); // PTX L510
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx517R157, r_MmaAccumulatorHalf2WordAtPtx517R158,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx93R326, r_MmaBE4x4WordAtPtx93R325,
		  r_MmaAccumulatorHalf2WordAtPtx415R283,
		  r_MmaAccumulatorHalf2WordAtPtx414R282); // PTX L517
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx417R285, r_MmaAccumulatorHalf2WordAtPtx416R284,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx129R312, r_MmaBE4x4WordAtPtx129R311,
		  r_MmaAccumulatorHalf2WordAtPtx510R155,
		  r_MmaAccumulatorHalf2WordAtPtx510R156); // PTX L524
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx415R283, r_MmaAccumulatorHalf2WordAtPtx414R282,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx129R310, r_MmaBE4x4WordAtPtx129R309,
		  r_MmaAccumulatorHalf2WordAtPtx517R157,
		  r_MmaAccumulatorHalf2WordAtPtx517R158); // PTX L531
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx538R159, r_MmaAccumulatorHalf2WordAtPtx538R160,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx102R324, r_MmaBE4x4WordAtPtx102R323,
		  r_MmaAccumulatorHalf2WordAtPtx413R281,
		  r_MmaAccumulatorHalf2WordAtPtx412R280); // PTX L538
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx545R161, r_MmaAccumulatorHalf2WordAtPtx545R162,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx102R322, r_MmaBE4x4WordAtPtx102R321,
		  r_MmaAccumulatorHalf2WordAtPtx411R279,
		  r_MmaAccumulatorHalf2WordAtPtx410R278); // PTX L545
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx413R281, r_MmaAccumulatorHalf2WordAtPtx412R280,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx138R308, r_MmaBE4x4WordAtPtx138R307,
		  r_MmaAccumulatorHalf2WordAtPtx538R159,
		  r_MmaAccumulatorHalf2WordAtPtx538R160); // PTX L552
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx411R279, r_MmaAccumulatorHalf2WordAtPtx410R278,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx138R306, r_MmaBE4x4WordAtPtx138R305,
		  r_MmaAccumulatorHalf2WordAtPtx545R161,
		  r_MmaAccumulatorHalf2WordAtPtx545R162); // PTX L559
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx566R163, r_MmaAccumulatorHalf2WordAtPtx566R164,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx111R320, r_MmaBE4x4WordAtPtx111R319,
		  r_MmaAccumulatorHalf2WordAtPtx409R277,
		  r_MmaAccumulatorHalf2WordAtPtx408R276); // PTX L566
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx573R165, r_MmaAccumulatorHalf2WordAtPtx573R166,
		  r_MmaAE4x4WordAtPtx452R143, r_MmaAE4x4WordAtPtx452R144, r_MmaAE4x4WordAtPtx452R145,
		  r_MmaAE4x4WordAtPtx452R146, r_MmaBE4x4WordAtPtx111R318, r_MmaBE4x4WordAtPtx111R317,
		  r_MmaAccumulatorHalf2WordAtPtx407R275,
		  r_MmaAccumulatorHalf2WordAtPtx406R274); // PTX L573
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx409R277, r_MmaAccumulatorHalf2WordAtPtx408R276,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx147R304, r_MmaBE4x4WordAtPtx147R303,
		  r_MmaAccumulatorHalf2WordAtPtx566R163,
		  r_MmaAccumulatorHalf2WordAtPtx566R164); // PTX L580
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx407R275, r_MmaAccumulatorHalf2WordAtPtx406R274,
		  r_MmaAE4x4WordAtPtx461R147, r_MmaAE4x4WordAtPtx461R148, r_MmaAE4x4WordAtPtx461R149,
		  r_MmaAE4x4WordAtPtx461R150, r_MmaBE4x4WordAtPtx147R302, r_MmaBE4x4WordAtPtx147R301,
		  r_MmaAccumulatorHalf2WordAtPtx573R165,
		  r_MmaAccumulatorHalf2WordAtPtx573R166); // PTX L587
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx594R175, r_MmaAccumulatorHalf2WordAtPtx594R176,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx84R332, r_MmaBE4x4WordAtPtx84R331,
		  r_MmaAccumulatorHalf2WordAtPtx405R273,
		  r_MmaAccumulatorHalf2WordAtPtx404R272); // PTX L594
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx601R177, r_MmaAccumulatorHalf2WordAtPtx601R178,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx84R330, r_MmaBE4x4WordAtPtx84R329,
		  r_MmaAccumulatorHalf2WordAtPtx403R271,
		  r_MmaAccumulatorHalf2WordAtPtx402R270); // PTX L601
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx405R273, r_MmaAccumulatorHalf2WordAtPtx404R272,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx120R316, r_MmaBE4x4WordAtPtx120R315,
		  r_MmaAccumulatorHalf2WordAtPtx594R175,
		  r_MmaAccumulatorHalf2WordAtPtx594R176); // PTX L608
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx403R271, r_MmaAccumulatorHalf2WordAtPtx402R270,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx120R314, r_MmaBE4x4WordAtPtx120R313,
		  r_MmaAccumulatorHalf2WordAtPtx601R177,
		  r_MmaAccumulatorHalf2WordAtPtx601R178); // PTX L615
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx622R179, r_MmaAccumulatorHalf2WordAtPtx622R180,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx93R328, r_MmaBE4x4WordAtPtx93R327,
		  r_MmaAccumulatorHalf2WordAtPtx401R269, r_PackedHalf2AtPtx64R268); // PTX L622
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx629R181, r_MmaAccumulatorHalf2WordAtPtx629R182,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx93R326, r_MmaBE4x4WordAtPtx93R325,
		  r_MmaAccumulatorHalf2WordAtPtx422R290,
		  r_MmaAccumulatorHalf2WordAtPtx423R291); // PTX L629
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx401R269, r_PackedHalf2AtPtx64R268, r_MmaAE4x4WordAtPtx479R171,
		  r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173, r_MmaAE4x4WordAtPtx479R174,
		  r_MmaBE4x4WordAtPtx129R312, r_MmaBE4x4WordAtPtx129R311, r_MmaAccumulatorHalf2WordAtPtx622R179,
		  r_MmaAccumulatorHalf2WordAtPtx622R180); // PTX L636
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx422R290, r_MmaAccumulatorHalf2WordAtPtx423R291,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx129R310, r_MmaBE4x4WordAtPtx129R309,
		  r_MmaAccumulatorHalf2WordAtPtx629R181,
		  r_MmaAccumulatorHalf2WordAtPtx629R182); // PTX L643
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx650R183, r_MmaAccumulatorHalf2WordAtPtx650R184,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx102R324, r_MmaBE4x4WordAtPtx102R323,
		  r_MmaAccumulatorHalf2WordAtPtx424R292,
		  r_MmaAccumulatorHalf2WordAtPtx425R293); // PTX L650
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx657R185, r_MmaAccumulatorHalf2WordAtPtx657R186,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx102R322, r_MmaBE4x4WordAtPtx102R321,
		  r_MmaAccumulatorHalf2WordAtPtx426R294,
		  r_MmaAccumulatorHalf2WordAtPtx427R295); // PTX L657
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx424R292, r_MmaAccumulatorHalf2WordAtPtx425R293,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx138R308, r_MmaBE4x4WordAtPtx138R307,
		  r_MmaAccumulatorHalf2WordAtPtx650R183,
		  r_MmaAccumulatorHalf2WordAtPtx650R184); // PTX L664
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx426R294, r_MmaAccumulatorHalf2WordAtPtx427R295,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx138R306, r_MmaBE4x4WordAtPtx138R305,
		  r_MmaAccumulatorHalf2WordAtPtx657R185,
		  r_MmaAccumulatorHalf2WordAtPtx657R186); // PTX L671
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx678R187, r_MmaAccumulatorHalf2WordAtPtx678R188,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx111R320, r_MmaBE4x4WordAtPtx111R319,
		  r_MmaAccumulatorHalf2WordAtPtx428R296,
		  r_MmaAccumulatorHalf2WordAtPtx429R297); // PTX L678
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx685R189, r_MmaAccumulatorHalf2WordAtPtx685R190,
		  r_MmaAE4x4WordAtPtx470R167, r_MmaAE4x4WordAtPtx470R168, r_MmaAE4x4WordAtPtx470R169,
		  r_MmaAE4x4WordAtPtx470R170, r_MmaBE4x4WordAtPtx111R318, r_MmaBE4x4WordAtPtx111R317,
		  r_MmaAccumulatorHalf2WordAtPtx430R298,
		  r_MmaAccumulatorHalf2WordAtPtx431R299); // PTX L685
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx428R296, r_MmaAccumulatorHalf2WordAtPtx429R297,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx147R304, r_MmaBE4x4WordAtPtx147R303,
		  r_MmaAccumulatorHalf2WordAtPtx678R187,
		  r_MmaAccumulatorHalf2WordAtPtx678R188); // PTX L692
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx430R298, r_MmaAccumulatorHalf2WordAtPtx431R299,
		  r_MmaAE4x4WordAtPtx479R171, r_MmaAE4x4WordAtPtx479R172, r_MmaAE4x4WordAtPtx479R173,
		  r_MmaAE4x4WordAtPtx479R174, r_MmaBE4x4WordAtPtx147R302, r_MmaBE4x4WordAtPtx147R301,
		  r_MmaAccumulatorHalf2WordAtPtx685R189,
		  r_MmaAccumulatorHalf2WordAtPtx685R190);					// PTX L699
	r_bPtxPredicate18 = uint32_t(r_PtxRegister300) > uint32_t(447); // PTX L705
	if (r_bPtxPredicate18)
	{
		goto L__BB43_41;
	} // PTX L706
	r_PtxRegister212 = uint32_t(r_PtxRegister300) + uint32_t(64);								 // PTX L707
	r_PtxRegister213 = uint32_t(r_PtxRegister212) + uint32_t(r_PtxRegister7);					 // PTX L708
	r_PtxRegister214 = ShiftLeft(uint32_t(r_PtxRegister213), uint32_t(8));						 // PTX L709
	r_PtxRegister215 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister12);					 // PTX L710
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_PtxRegister215)) * int64_t(int32_t(4)));	 // PTX L711
	r_PtxU64Register46 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register45);				 // PTX L712
	r_LaneIndexAtPtx714 = uint32_t((threadIdx.x & 31u));										 // PTX L714
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx714)) * int64_t(int32_t(16))); // PTX L716
	r_PtxU64Register37 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register47);			 // PTX L717
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register37));
		r_MmaBE4x4WordAtPtx84R332 = r_Value.x;
		r_MmaBE4x4WordAtPtx84R331 = r_Value.y;
		r_MmaBE4x4WordAtPtx84R330 = r_Value.z;
		r_MmaBE4x4WordAtPtx84R329 = r_Value.w;
	} // PTX L719
	r_LaneIndexAtPtx722 = uint32_t((threadIdx.x & 31u));										 // PTX L722
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx722)) * int64_t(int32_t(16))); // PTX L724
	r_PtxU64Register49 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register48);			 // PTX L725
	r_PtxU64Register38 = uint64_t(r_PtxU64Register49) + uint64_t(512);							 // PTX L726
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register38));
		r_MmaBE4x4WordAtPtx93R328 = r_Value.x;
		r_MmaBE4x4WordAtPtx93R327 = r_Value.y;
		r_MmaBE4x4WordAtPtx93R326 = r_Value.z;
		r_MmaBE4x4WordAtPtx93R325 = r_Value.w;
	} // PTX L728
	r_LaneIndexAtPtx731 = uint32_t((threadIdx.x & 31u));										 // PTX L731
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx731)) * int64_t(int32_t(16))); // PTX L733
	r_PtxU64Register51 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register50);			 // PTX L734
	r_PtxU64Register39 = uint64_t(r_PtxU64Register51) + uint64_t(1024);							 // PTX L735
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register39));
		r_MmaBE4x4WordAtPtx102R324 = r_Value.x;
		r_MmaBE4x4WordAtPtx102R323 = r_Value.y;
		r_MmaBE4x4WordAtPtx102R322 = r_Value.z;
		r_MmaBE4x4WordAtPtx102R321 = r_Value.w;
	} // PTX L737
	r_LaneIndexAtPtx740 = uint32_t((threadIdx.x & 31u));										 // PTX L740
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx740)) * int64_t(int32_t(16))); // PTX L742
	r_PtxU64Register53 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register52);			 // PTX L743
	r_PtxU64Register40 = uint64_t(r_PtxU64Register53) + uint64_t(1536);							 // PTX L744
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register40));
		r_MmaBE4x4WordAtPtx111R320 = r_Value.x;
		r_MmaBE4x4WordAtPtx111R319 = r_Value.y;
		r_MmaBE4x4WordAtPtx111R318 = r_Value.z;
		r_MmaBE4x4WordAtPtx111R317 = r_Value.w;
	} // PTX L746
	r_LaneIndexAtPtx749 = uint32_t((threadIdx.x & 31u));										 // PTX L749
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx749)) * int64_t(int32_t(16))); // PTX L751
	r_PtxU64Register55 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register54);			 // PTX L752
	r_PtxU64Register41 = uint64_t(r_PtxU64Register55) + uint64_t(32768);						 // PTX L753
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register41));
		r_MmaBE4x4WordAtPtx120R316 = r_Value.x;
		r_MmaBE4x4WordAtPtx120R315 = r_Value.y;
		r_MmaBE4x4WordAtPtx120R314 = r_Value.z;
		r_MmaBE4x4WordAtPtx120R313 = r_Value.w;
	} // PTX L755
	r_LaneIndexAtPtx758 = uint32_t((threadIdx.x & 31u));										 // PTX L758
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx758)) * int64_t(int32_t(16))); // PTX L760
	r_PtxU64Register57 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register56);			 // PTX L761
	r_PtxU64Register42 = uint64_t(r_PtxU64Register57) + uint64_t(33280);						 // PTX L762
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register42));
		r_MmaBE4x4WordAtPtx129R312 = r_Value.x;
		r_MmaBE4x4WordAtPtx129R311 = r_Value.y;
		r_MmaBE4x4WordAtPtx129R310 = r_Value.z;
		r_MmaBE4x4WordAtPtx129R309 = r_Value.w;
	} // PTX L764
	r_LaneIndexAtPtx767 = uint32_t((threadIdx.x & 31u));										 // PTX L767
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx767)) * int64_t(int32_t(16))); // PTX L769
	r_PtxU64Register59 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register58);			 // PTX L770
	r_PtxU64Register43 = uint64_t(r_PtxU64Register59) + uint64_t(33792);						 // PTX L771
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register43));
		r_MmaBE4x4WordAtPtx138R308 = r_Value.x;
		r_MmaBE4x4WordAtPtx138R307 = r_Value.y;
		r_MmaBE4x4WordAtPtx138R306 = r_Value.z;
		r_MmaBE4x4WordAtPtx138R305 = r_Value.w;
	} // PTX L773
	r_LaneIndexAtPtx776 = uint32_t((threadIdx.x & 31u));										 // PTX L776
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx776)) * int64_t(int32_t(16))); // PTX L778
	r_PtxU64Register61 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register60);			 // PTX L779
	r_PtxU64Register44 = uint64_t(r_PtxU64Register61) + uint64_t(34304);						 // PTX L780
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register44));
		r_MmaBE4x4WordAtPtx147R304 = r_Value.x;
		r_MmaBE4x4WordAtPtx147R303 = r_Value.y;
		r_MmaBE4x4WordAtPtx147R302 = r_Value.z;
		r_MmaBE4x4WordAtPtx147R301 = r_Value.w;
	} // PTX L782
	r_PtxRegister216 = ShiftRight(uint32_t(r_PtxRegister212), uint32_t(6)); // PTX L784
	r_PtxU16Register13 = uint16_t(r_PtxRegister216);						// PTX L785
	r_PtxU16Register14 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register13)) * uint32_t(uint16_t(171)));				   // PTX L786
	r_PtxU16Register15 = ShiftRight(uint16_t(r_PtxU16Register14), uint32_t(9));					   // PTX L787
	r_PtxU16Register16 = uint16_t(uint32_t(uint16_t(r_PtxU16Register15)) * uint32_t(uint16_t(3))); // PTX L788
	r_PtxU16Register17 = uint16_t(r_PtxU16Register13) - uint16_t(r_PtxU16Register16);			   // PTX L789
	r_PtxU16Register18 = r_PtxU16Register17 & 255;												   // PTX L790
	r_PtxRegister217 = uint32_t(uint16_t(r_PtxU16Register18)) * uint32_t(uint16_t(8));			   // PTX L791
	r_PtxRegister218 = uint32_t(12288u /* exact native shared-region offset */);				   // PTX L792
	r_PtxRegister220 = uint32_t(r_PtxRegister218) + uint32_t(r_PtxRegister217);					   // PTX L793
	r_PtxRegister211 = uint32_t(1);																   // PTX L794
	r_PtxU64Register62 = BarrierArrive(s_SharedStorage, r_PtxRegister220, r_PtxRegister211);	   // PTX L796
L__BB43_40:																						   // PTX L798
	r_PtxRegister219 = BarrierReady(s_SharedStorage, r_PtxRegister220, r_PtxU64Register62);		   // PTX L800
	r_bPtxPredicate19 = uint32_t(r_PtxRegister219) == uint32_t(0);								   // PTX L806
	if (r_bPtxPredicate19)
	{
		goto L__BB43_40;
	} // PTX L807
L__BB43_41:															// PTX L808
	r_bPtxPredicate20 = uint32_t(r_PtxRegister300) > uint32_t(319); // PTX L809
	if (r_bPtxPredicate20)
	{
		goto L__BB43_50;
	} // PTX L810
	r_bPtxPredicate21 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister9);	  // PTX L811
	r_bPtxPredicate22 = int32_t(r_PtxRegister75) >= int32_t(r_PtxRegister8);  // PTX L812
	r_bPtxPredicate23 = uint32_t(r_PtxRegister21) == uint32_t(4);			  // PTX L813
	r_bPtxPredicate24 = uint32_t(r_PtxRegister17) == uint32_t(4);			  // PTX L814
	r_bPtxPredicate25 = uint32_t(r_PtxRegister17) != uint32_t(4);			  // PTX L815
	r_PtxRegister26 = uint32_t(r_PtxRegister300) + uint32_t(r_PtxRegister23); // PTX L816
	r_bPtxPredicate26 = r_bPtxPredicate25 & r_bPtxPredicate22;				  // PTX L817
	r_bPtxPredicate27 = r_bPtxPredicate24 | r_bPtxPredicate2;				  // PTX L818
	r_bPtxPredicate28 = r_bPtxPredicate26 | r_bPtxPredicate23;				  // PTX L819
	r_PtxRegister221 = r_bPtxPredicate26 ? r_PtxRegister15 : 0;				  // PTX L820
	r_PtxRegister27 = r_bPtxPredicate23 ? r_PtxRegister221 : r_PtxRegister15; // PTX L821
	r_bPtxPredicate29 = r_bPtxPredicate28 | r_bPtxPredicate21;				  // PTX L822
	r_bPtxPredicate3 = r_bPtxPredicate29 & r_bPtxPredicate27;				  // PTX L823
	r_PtxU64Register83 = uint64_t(0);										  // PTX L824
	r_bPtxPredicate30 = !r_bPtxPredicate3;									  // PTX L825
	if (r_bPtxPredicate30)
	{
		goto L__BB43_44;
	} // PTX L826
	r_PtxRegister222 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister27);	// PTX L827
	r_PtxRegister223 = ShiftLeft(uint32_t(r_PtxRegister222), uint32_t(11));		// PTX L828
	r_PtxRegister224 = ShiftLeft(uint32_t(r_PtxRegister26), uint32_t(2));		// PTX L829
	r_PtxRegister225 = uint32_t(r_PtxRegister223) + uint32_t(r_PtxRegister224); // PTX L830
	r_PtxU64Register83 = SignExtendWordBits(r_PtxRegister225);					// PTX L831
L__BB43_44:																		// PTX L832
	r_PtxU64Register84 = uint64_t(0);											// PTX L833
	if (r_bPtxPredicate30)
	{
		goto L__BB43_46;
	} // PTX L834
	r_PtxU64Register63 = ShiftLeft(uint64_t(r_PtxU64Register83), uint32_t(2));	  // PTX L835
	r_PtxU64Register84 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register63); // PTX L836
L__BB43_46:																		  // PTX L837
	if (r_bPtxPredicate30)
	{
		goto L__BB43_49;
	} // PTX L838
	r_PtxRegister234 = uint32_t(-1);							   // PTX L839
	r_PtxRegister233 = Elected(r_PtxRegister234);				   // PTX L841
	r_bPtxPredicate31 = uint32_t(r_PtxRegister233) == uint32_t(0); // PTX L847
	if (r_bPtxPredicate31)
	{
		goto L__BB43_50;
	} // PTX L848
	r_PtxRegister235 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister25);	 // PTX L849
	r_PtxU64Register64 = r_PtxU64Register84;									 // PTX L850
	r_PtxRegister238 = ShiftLeft(uint32_t(r_PtxRegister24), uint32_t(3));		 // PTX L851
	r_PtxRegister239 = uint32_t(12288u /* exact native shared-region offset */); // PTX L852
	r_PtxRegister237 = uint32_t(r_PtxRegister239) + uint32_t(r_PtxRegister238);	 // PTX L853
	r_PtxRegister236 = uint32_t(512);											 // PTX L854
	CopyBulk(s_SharedStorage, r_PtxRegister235, r_PtxU64Register64, r_PtxRegister236,
			 r_PtxRegister237);																   // PTX L856
	BarrierExpect(s_SharedStorage, r_PtxRegister237, r_PtxRegister236);						   // PTX L859
	goto L__BB43_50;																		   // PTX L861
L__BB43_49:																					   // PTX L862
	r_PtxRegister226 = uint32_t(0);															   // PTX L863
	r_PtxU16Register19 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister226))); // PTX L865
	r_PackedHalf2AtPtx868R227 = JoinHalfwords(r_PtxU16Register19, r_PtxU16Register19);		   // PTX L868
	r_ConvertedE4PairAtPtx870Rs20 = PublishE4(r_PackedHalf2AtPtx868R227);					   // PTX L870
	r_PackedE4WordAtPtx872R230 =
		JoinHalfwords(r_ConvertedE4PairAtPtx870Rs20, r_ConvertedE4PairAtPtx870Rs20); // PTX L872
	r_LaneIndexAtPtx874 = uint32_t((threadIdx.x & 31u));							 // PTX L874
	r_PtxRegister231 = uint32_t(r_PtxRegister91) + uint32_t(r_PtxRegister25);		 // PTX L876
	r_PtxRegister232 = ShiftLeft(uint32_t(r_LaneIndexAtPtx874), uint32_t(4));		 // PTX L877
	r_PtxRegister229 = uint32_t(r_PtxRegister231) + uint32_t(r_PtxRegister232);		 // PTX L878
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister229)) =
		make_uint4(r_PackedE4WordAtPtx872R230, r_PackedE4WordAtPtx872R230, r_PackedE4WordAtPtx872R230,
				   r_PackedE4WordAtPtx872R230);						// PTX L880
L__BB43_50:															// PTX L882
	r_bPtxPredicate32 = uint32_t(r_PtxRegister300) < uint32_t(448); // PTX L883
	r_PtxRegister300 = uint32_t(r_PtxRegister300) + uint32_t(64);	// PTX L884
	if (r_bPtxPredicate32)
	{
		goto L__BB43_38;
	} // PTX L885
	r_bPtxPredicate33 = int32_t(r_PtxRegister75) >= int32_t(r_PtxRegister8);				 // PTX L886
	r_ConvertedE4PairAtPtx888Rs21 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx421R289);		 // PTX L888
	r_ConvertedE4PairAtPtx891Rs22 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx419R287);		 // PTX L891
	r_ConvertedE4PairAtPtx894Rs23 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx420R288);		 // PTX L894
	r_ConvertedE4PairAtPtx897Rs24 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx418R286);		 // PTX L897
	r_ConvertedE4PairAtPtx900Rs25 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx417R285);		 // PTX L900
	r_ConvertedE4PairAtPtx903Rs26 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx415R283);		 // PTX L903
	r_ConvertedE4PairAtPtx906Rs27 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx416R284);		 // PTX L906
	r_ConvertedE4PairAtPtx909Rs28 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx414R282);		 // PTX L909
	r_ConvertedE4PairAtPtx912Rs29 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx413R281);		 // PTX L912
	r_ConvertedE4PairAtPtx915Rs30 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx411R279);		 // PTX L915
	r_ConvertedE4PairAtPtx918Rs31 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx412R280);		 // PTX L918
	r_ConvertedE4PairAtPtx921Rs32 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx410R278);		 // PTX L921
	r_ConvertedE4PairAtPtx924Rs33 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx409R277);		 // PTX L924
	r_ConvertedE4PairAtPtx927Rs34 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx407R275);		 // PTX L927
	r_ConvertedE4PairAtPtx930Rs35 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx408R276);		 // PTX L930
	r_ConvertedE4PairAtPtx933Rs36 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx406R274);		 // PTX L933
	r_ConvertedE4PairAtPtx936Rs37 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx405R273);		 // PTX L936
	r_ConvertedE4PairAtPtx939Rs38 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx403R271);		 // PTX L939
	r_ConvertedE4PairAtPtx942Rs39 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx404R272);		 // PTX L942
	r_ConvertedE4PairAtPtx945Rs40 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx402R270);		 // PTX L945
	r_ConvertedE4PairAtPtx948Rs41 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx401R269);		 // PTX L948
	r_ConvertedE4PairAtPtx951Rs42 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx422R290);		 // PTX L951
	r_ConvertedE4PairAtPtx954Rs43 = PublishE4(r_PackedHalf2AtPtx64R268);					 // PTX L954
	r_ConvertedE4PairAtPtx957Rs44 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx423R291);		 // PTX L957
	r_ConvertedE4PairAtPtx960Rs45 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx424R292);		 // PTX L960
	r_ConvertedE4PairAtPtx963Rs46 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx426R294);		 // PTX L963
	r_ConvertedE4PairAtPtx966Rs47 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx425R293);		 // PTX L966
	r_ConvertedE4PairAtPtx969Rs48 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx427R295);		 // PTX L969
	r_ConvertedE4PairAtPtx972Rs49 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx428R296);		 // PTX L972
	r_ConvertedE4PairAtPtx975Rs50 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx430R298);		 // PTX L975
	r_ConvertedE4PairAtPtx978Rs51 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx429R297);		 // PTX L978
	r_ConvertedE4PairAtPtx981Rs52 = PublishE4(r_MmaAccumulatorHalf2WordAtPtx431R299);		 // PTX L981
	r_bPtxPredicate34 = int32_t(r_PtxRegister6) >= int32_t(r_PtxRegister9);					 // PTX L983
	r_PtxRegister240 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister6);				 // PTX L984
	r_PtxRegister241 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(2));					 // PTX L985
	r_PtxRegister242 = ShiftLeft(uint32_t(r_PtxRegister240), uint32_t(12));					 // PTX L986
	r_PtxRegister243 = uint32_t(r_PtxRegister242) + uint32_t(r_PtxRegister241);				 // PTX L987
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_PtxRegister243)) * int64_t(int32_t(4))); // PTX L988
	r_PtxU64Register4 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register65);			 // PTX L989
	r_bPtxPredicate35 = r_bPtxPredicate33 | r_bPtxPredicate34;								 // PTX L990
	if (r_bPtxPredicate35)
	{
		goto L__BB43_53;
	} // PTX L991
	r_PackedE4WordAtPtx992R253 =
		JoinHalfwords(r_ConvertedE4PairAtPtx930Rs35, r_ConvertedE4PairAtPtx933Rs36); // PTX L992
	r_PackedE4WordAtPtx993R252 =
		JoinHalfwords(r_ConvertedE4PairAtPtx924Rs33, r_ConvertedE4PairAtPtx927Rs34); // PTX L993
	r_PackedE4WordAtPtx994R251 =
		JoinHalfwords(r_ConvertedE4PairAtPtx918Rs31, r_ConvertedE4PairAtPtx921Rs32); // PTX L994
	r_PackedE4WordAtPtx995R250 =
		JoinHalfwords(r_ConvertedE4PairAtPtx912Rs29, r_ConvertedE4PairAtPtx915Rs30); // PTX L995
	r_PackedE4WordAtPtx996R248 =
		JoinHalfwords(r_ConvertedE4PairAtPtx906Rs27, r_ConvertedE4PairAtPtx909Rs28); // PTX L996
	r_PackedE4WordAtPtx997R247 =
		JoinHalfwords(r_ConvertedE4PairAtPtx900Rs25, r_ConvertedE4PairAtPtx903Rs26); // PTX L997
	r_PackedE4WordAtPtx998R246 =
		JoinHalfwords(r_ConvertedE4PairAtPtx894Rs23, r_ConvertedE4PairAtPtx897Rs24); // PTX L998
	r_PackedE4WordAtPtx999R245 =
		JoinHalfwords(r_ConvertedE4PairAtPtx888Rs21, r_ConvertedE4PairAtPtx891Rs22);			  // PTX L999
	r_LaneIndexAtPtx1001 = uint32_t((threadIdx.x & 31u));										  // PTX L1001
	r_PtxU64Register68 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1001)) * int64_t(int32_t(16))); // PTX L1003
	r_PtxU64Register66 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register68);			  // PTX L1004
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(r_PtxU64Register66, make_uint4(r_PackedE4WordAtPtx999R245, r_PackedE4WordAtPtx998R246,
												   r_PackedE4WordAtPtx997R247,
												   r_PackedE4WordAtPtx996R248));				  // PTX L1006
	r_LaneIndexAtPtx1009 = uint32_t((threadIdx.x & 31u));										  // PTX L1009
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1009)) * int64_t(int32_t(16))); // PTX L1011
	r_PtxU64Register70 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register69);			  // PTX L1012
	r_PtxU64Register67 = uint64_t(r_PtxU64Register70) + uint64_t(512);							  // PTX L1013
	StoreNoAllocate(r_PtxU64Register67, make_uint4(r_PackedE4WordAtPtx995R250, r_PackedE4WordAtPtx994R251,
												   r_PackedE4WordAtPtx993R252,
												   r_PackedE4WordAtPtx992R253)); // PTX L1015
L__BB43_53:																		 // PTX L1017
	r_PtxRegister254 = uint32_t(r_PtxRegister6) + uint32_t(1);					 // PTX L1018
	r_bPtxPredicate36 = int32_t(r_PtxRegister254) >= int32_t(r_PtxRegister9);	 // PTX L1019
	r_bPtxPredicate37 = r_bPtxPredicate33 | r_bPtxPredicate36;					 // PTX L1020
	if (r_bPtxPredicate37)
	{
		goto L__BB43_55;
	} // PTX L1021
	r_LaneIndexAtPtx1023 = uint32_t((threadIdx.x & 31u));										  // PTX L1023
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1023)) * int64_t(int32_t(16))); // PTX L1025
	r_PtxU64Register74 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register73);			  // PTX L1026
	r_PtxU64Register71 = uint64_t(r_PtxU64Register74) + uint64_t(16384);						  // PTX L1027
	r_PackedE4WordAtPtx1028R259 =
		JoinHalfwords(r_ConvertedE4PairAtPtx954Rs43, r_ConvertedE4PairAtPtx957Rs44); // PTX L1028
	r_PackedE4WordAtPtx1029R258 =
		JoinHalfwords(r_ConvertedE4PairAtPtx948Rs41, r_ConvertedE4PairAtPtx951Rs42); // PTX L1029
	r_PackedE4WordAtPtx1030R257 =
		JoinHalfwords(r_ConvertedE4PairAtPtx942Rs39, r_ConvertedE4PairAtPtx945Rs40); // PTX L1030
	r_PackedE4WordAtPtx1031R256 =
		JoinHalfwords(r_ConvertedE4PairAtPtx936Rs37, r_ConvertedE4PairAtPtx939Rs38); // PTX L1031
	StoreNoAllocate(r_PtxU64Register71, make_uint4(r_PackedE4WordAtPtx1031R256, r_PackedE4WordAtPtx1030R257,
												   r_PackedE4WordAtPtx1029R258,
												   r_PackedE4WordAtPtx1028R259));				  // PTX L1033
	r_LaneIndexAtPtx1036 = uint32_t((threadIdx.x & 31u));										  // PTX L1036
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx1036)) * int64_t(int32_t(16))); // PTX L1038
	r_PtxU64Register76 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register75);			  // PTX L1039
	r_PtxU64Register72 = uint64_t(r_PtxU64Register76) + uint64_t(16896);						  // PTX L1040
	r_PackedE4WordAtPtx1041R264 =
		JoinHalfwords(r_ConvertedE4PairAtPtx978Rs51, r_ConvertedE4PairAtPtx981Rs52); // PTX L1041
	r_PackedE4WordAtPtx1042R263 =
		JoinHalfwords(r_ConvertedE4PairAtPtx972Rs49, r_ConvertedE4PairAtPtx975Rs50); // PTX L1042
	r_PackedE4WordAtPtx1043R262 =
		JoinHalfwords(r_ConvertedE4PairAtPtx966Rs47, r_ConvertedE4PairAtPtx969Rs48); // PTX L1043
	r_PackedE4WordAtPtx1044R261 =
		JoinHalfwords(r_ConvertedE4PairAtPtx960Rs45, r_ConvertedE4PairAtPtx963Rs46); // PTX L1044
	StoreNoAllocate(r_PtxU64Register72, make_uint4(r_PackedE4WordAtPtx1044R261, r_PackedE4WordAtPtx1043R262,
												   r_PackedE4WordAtPtx1042R263,
												   r_PackedE4WordAtPtx1041R264)); // PTX L1046
L__BB43_55:																		  // PTX L1048
	return;																		  // PTX L1049
#endif
}
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp8
