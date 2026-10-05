// Readable equivalent of cc_split_swin_16h_final_head_512; not historical source.
#pragma once
#include "channel_projection_c512_to_c1024_abi_fp16.cuh"

namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
{
__global__ __maxnreg__(168) void channel_projection_c512_to_c1024_fp16(Parameters r_Parameters)
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
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint32_t r_Scalar32Bits, r_Scalar36Bits, r_CtaY, r_CtaZ, r_PtxRegister5, r_PtxRegister6, r_PtxRegister7,
		r_PtxRegister8, r_PtxRegister9, r_ThreadY, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_CtaX, r_PtxRegister28, r_PtxRegister29, r_PtxRegister30,
		r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35, r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41, r_ThreadX,
		r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47, r_BlockSizeX;
	uint32_t r_BlockSizeY, r_Float32BitsAtPtx62R50, r_LaneIndexAtPtx78, r_LaneIndexAtPtx86,
		r_LaneIndexAtPtx95, r_LaneIndexAtPtx104, r_LaneIndexAtPtx113, r_LaneIndexAtPtx122,
		r_LaneIndexAtPtx131, r_LaneIndexAtPtx140, r_PtxRegister59, r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_LaneIndexAtPtx221,
		r_PtxRegister83, r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94,
		r_LaneIndexAtPtx280, r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_LaneIndexAtPtx340, r_PtxRegister112,
		r_PackedHalf2AtPtx64R113, r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117,
		r_PtxRegister118, r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_LaneIndexAtPtx414, r_PtxRegister127, r_LaneIndexAtPtx425, r_PtxRegister129, r_LaneIndexAtPtx434,
		r_PtxRegister131, r_LaneIndexAtPtx443;
	uint32_t r_PtxRegister133, r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135,
		r_MmaAHalf2WordAtPtx422R136, r_MmaAHalf2WordAtPtx422R137, r_MmaAHalf2WordAtPtx431R138,
		r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140, r_MmaAHalf2WordAtPtx431R141,
		r_MmaAccumulatorHalf2WordAtPtx452R142, r_MmaAccumulatorHalf2WordAtPtx452R143,
		r_MmaAccumulatorHalf2WordAtPtx459R144;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx459R145, r_MmaAccumulatorHalf2WordAtPtx480R146,
		r_MmaAccumulatorHalf2WordAtPtx480R147, r_MmaAccumulatorHalf2WordAtPtx487R148,
		r_MmaAccumulatorHalf2WordAtPtx487R149, r_MmaAccumulatorHalf2WordAtPtx508R150,
		r_MmaAccumulatorHalf2WordAtPtx508R151, r_MmaAccumulatorHalf2WordAtPtx515R152,
		r_MmaAccumulatorHalf2WordAtPtx515R153, r_MmaAccumulatorHalf2WordAtPtx536R154,
		r_MmaAccumulatorHalf2WordAtPtx536R155, r_MmaAccumulatorHalf2WordAtPtx543R156;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx543R157, r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159,
		r_MmaAHalf2WordAtPtx440R160, r_MmaAHalf2WordAtPtx440R161, r_MmaAHalf2WordAtPtx449R162,
		r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164, r_MmaAHalf2WordAtPtx449R165,
		r_MmaAccumulatorHalf2WordAtPtx564R166, r_MmaAccumulatorHalf2WordAtPtx564R167,
		r_MmaAccumulatorHalf2WordAtPtx571R168;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx571R169, r_MmaAccumulatorHalf2WordAtPtx592R170,
		r_MmaAccumulatorHalf2WordAtPtx592R171, r_MmaAccumulatorHalf2WordAtPtx599R172,
		r_MmaAccumulatorHalf2WordAtPtx599R173, r_MmaAccumulatorHalf2WordAtPtx620R174,
		r_MmaAccumulatorHalf2WordAtPtx620R175, r_MmaAccumulatorHalf2WordAtPtx627R176,
		r_MmaAccumulatorHalf2WordAtPtx627R177, r_MmaAccumulatorHalf2WordAtPtx648R178,
		r_MmaAccumulatorHalf2WordAtPtx648R179, r_MmaAccumulatorHalf2WordAtPtx655R180;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx655R181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184,
		r_PtxRegister185, r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189,
		r_PtxRegister190, r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_LaneIndexAtPtx684, r_LaneIndexAtPtx692, r_LaneIndexAtPtx701,
		r_LaneIndexAtPtx710, r_LaneIndexAtPtx719, r_LaneIndexAtPtx728, r_LaneIndexAtPtx737,
		r_LaneIndexAtPtx746, r_PtxRegister202, r_PtxRegister203, r_PtxRegister204;
	uint32_t r_PtxRegister205, r_PtxRegister206, r_PtxRegister207, r_PtxRegister208, r_PtxRegister209,
		r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213, r_PtxRegister214,
		r_PtxRegister215, r_PtxRegister216;
	uint32_t r_LaneIndexAtPtx834, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_LaneIndexAtPtx856, r_LaneIndexAtPtx864,
		r_LaneIndexAtPtx873, r_LaneIndexAtPtx882, r_PtxRegister235, r_LaneIndexAtPtx896, r_LaneIndexAtPtx905,
		r_LaneIndexAtPtx914, r_LaneIndexAtPtx923, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_MmaAccumulatorHalf2WordAtPtx370R243,
		r_MmaAccumulatorHalf2WordAtPtx371R244, r_MmaAccumulatorHalf2WordAtPtx372R245,
		r_MmaAccumulatorHalf2WordAtPtx373R246, r_MmaAccumulatorHalf2WordAtPtx374R247,
		r_MmaAccumulatorHalf2WordAtPtx375R248, r_MmaAccumulatorHalf2WordAtPtx376R249,
		r_MmaAccumulatorHalf2WordAtPtx377R250, r_MmaAccumulatorHalf2WordAtPtx378R251,
		r_MmaAccumulatorHalf2WordAtPtx379R252;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx380R253, r_MmaAccumulatorHalf2WordAtPtx381R254,
		r_MmaAccumulatorHalf2WordAtPtx382R255, r_MmaAccumulatorHalf2WordAtPtx383R256,
		r_MmaAccumulatorHalf2WordAtPtx384R257, r_MmaAccumulatorHalf2WordAtPtx385R258,
		r_MmaAccumulatorHalf2WordAtPtx386R259, r_MmaAccumulatorHalf2WordAtPtx387R260,
		r_MmaAccumulatorHalf2WordAtPtx388R261, r_MmaAccumulatorHalf2WordAtPtx389R262,
		r_MmaAccumulatorHalf2WordAtPtx390R263, r_MmaAccumulatorHalf2WordAtPtx391R264;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx392R265, r_MmaAccumulatorHalf2WordAtPtx393R266,
		r_MmaAccumulatorHalf2WordAtPtx394R267, r_MmaAccumulatorHalf2WordAtPtx395R268,
		r_MmaAccumulatorHalf2WordAtPtx396R269, r_MmaAccumulatorHalf2WordAtPtx397R270,
		r_MmaAccumulatorHalf2WordAtPtx398R271, r_MmaAccumulatorHalf2WordAtPtx399R272,
		r_MmaAccumulatorHalf2WordAtPtx400R273, r_MmaAccumulatorHalf2WordAtPtx401R274, r_PtxRegister275,
		r_MmaBHalf2WordAtPtx146R276;
	uint32_t r_MmaBHalf2WordAtPtx146R277, r_MmaBHalf2WordAtPtx146R278, r_MmaBHalf2WordAtPtx146R279,
		r_MmaBHalf2WordAtPtx137R280, r_MmaBHalf2WordAtPtx137R281, r_MmaBHalf2WordAtPtx137R282,
		r_MmaBHalf2WordAtPtx137R283, r_MmaBHalf2WordAtPtx128R284, r_MmaBHalf2WordAtPtx128R285,
		r_MmaBHalf2WordAtPtx128R286, r_MmaBHalf2WordAtPtx128R287, r_MmaBHalf2WordAtPtx119R288;
	uint32_t r_MmaBHalf2WordAtPtx119R289, r_MmaBHalf2WordAtPtx119R290, r_MmaBHalf2WordAtPtx119R291,
		r_MmaBHalf2WordAtPtx110R292, r_MmaBHalf2WordAtPtx110R293, r_MmaBHalf2WordAtPtx110R294,
		r_MmaBHalf2WordAtPtx110R295, r_MmaBHalf2WordAtPtx101R296, r_MmaBHalf2WordAtPtx101R297,
		r_MmaBHalf2WordAtPtx101R298, r_MmaBHalf2WordAtPtx101R299, r_MmaBHalf2WordAtPtx92R300;
	uint32_t r_MmaBHalf2WordAtPtx92R301, r_MmaBHalf2WordAtPtx92R302, r_MmaBHalf2WordAtPtx92R303,
		r_MmaBHalf2WordAtPtx83R304, r_MmaBHalf2WordAtPtx83R305, r_MmaBHalf2WordAtPtx83R306,
		r_MmaBHalf2WordAtPtx83R307;
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
	uint64_t r_PtxU64Register85, r_PtxU64Register86, r_PtxU64Register87, r_PtxU64Register88,
		r_PtxU64Register89, r_PtxU64Register90, r_PtxU64Register91, r_PtxU64Register92, r_PtxU64Register93,
		r_PtxU64Register94, r_PtxU64Register95, r_PtxU64Register96;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_Pointer0Bits = uint64_t(r_Parameters.g_Pointer0);	  // PTX L14
	r_Pointer8Bits = uint64_t(r_Parameters.g_Pointer8);	  // PTX L15
	r_Pointer16Bits = uint64_t(r_Parameters.g_Pointer16); // PTX L16
	r_Scalar32Bits = uint32_t(r_Parameters.Scalar32);
	r_Scalar36Bits = uint32_t(r_Parameters.Scalar36);							// PTX L17
	r_CtaX = uint32_t(blockIdx.x);												// PTX L18
	r_CtaY = uint32_t(blockIdx.y);												// PTX L19
	r_CtaZ = uint32_t(blockIdx.z);												// PTX L20
	r_PtxRegister28 = uint32_t(r_Scalar36Bits) + uint32_t(-1);					// PTX L21
	r_PtxRegister29 = ShiftRightSigned(int32_t(r_PtxRegister28), uint32_t(31)); // PTX L22
	r_PtxRegister30 = ShiftRight(uint32_t(r_PtxRegister29), uint32_t(29));		// PTX L23
	r_PtxRegister31 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister30);	// PTX L24
	r_PtxRegister32 = ShiftRightSigned(int32_t(r_PtxRegister31), uint32_t(3));	// PTX L25
	r_PtxRegister33 = uint32_t(r_PtxRegister32) + uint32_t(1);					// PTX L26
	r_PtxRegister5 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister33));		// PTX L27
	r_PtxRegister34 =
		uint32_t(r_PtxRegister5) * uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister5); // PTX L28
	r_PtxRegister35 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister34);						 // PTX L29
	r_PtxRegister6 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(1));					 // PTX L30
	r_PtxRegister7 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(9));							 // PTX L31
	r_PtxRegister36 = ShiftRightSigned(int32_t(r_Scalar32Bits), uint32_t(31));			 // PTX L32
	r_PtxRegister37 = ShiftRight(uint32_t(r_PtxRegister36), uint32_t(30));				 // PTX L33
	r_PtxRegister38 = uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister37);				 // PTX L34
	r_PtxRegister8 = ShiftRightSigned(int32_t(r_PtxRegister38), uint32_t(2));			 // PTX L35
	r_PtxRegister39 = ShiftRightSigned(int32_t(r_Scalar36Bits), uint32_t(31));			 // PTX L36
	r_PtxRegister40 = ShiftRight(uint32_t(r_PtxRegister39), uint32_t(30));				 // PTX L37
	r_PtxRegister41 = uint32_t(r_Scalar36Bits) + uint32_t(r_PtxRegister40);				 // PTX L38
	r_PtxRegister9 = ShiftRightSigned(int32_t(r_PtxRegister41), uint32_t(2));			 // PTX L39
	r_ThreadX = uint32_t(threadIdx.x);													 // PTX L40
	r_ThreadY = uint32_t(threadIdx.y);													 // PTX L41
	r_PtxRegister43 = r_ThreadX | r_ThreadY;											 // PTX L42
	r_bPtxPredicate4 = uint32_t(r_PtxRegister43) != uint32_t(0);						 // PTX L43
	if (r_bPtxPredicate4)
	{
		goto L__BB42_2;
	} // PTX L44
	r_BlockSizeX = uint32_t(blockDim.x);										// PTX L45
	r_BlockSizeY = uint32_t(blockDim.y);										// PTX L46
	r_PtxRegister45 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			// PTX L47
	r_PtxRegister44 = uint32_t(12288u /* exact native shared-region offset */); // PTX L48
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister44, r_PtxRegister45); // PTX L50
	r_PtxRegister46 = uint32_t(r_PtxRegister44) + uint32_t(8);		// PTX L52
	BarrierInit(s_SharedStorage, r_PtxRegister46, r_PtxRegister45); // PTX L54
	r_PtxRegister47 = uint32_t(r_PtxRegister44) + uint32_t(16);		// PTX L56
	BarrierInit(s_SharedStorage, r_PtxRegister47, r_PtxRegister45); // PTX L58
L__BB42_2:															// PTX L60
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L61
	r_Float32BitsAtPtx62R50 = uint32_t(0);														// PTX L62
	r_PackedHalf2AtPtx64R113 = FloatToHalf2(r_Float32BitsAtPtx62R50);							// PTX L64
	r_PtxRegister59 = ShiftLeft(uint32_t(r_CtaZ), uint32_t(18));								// PTX L69
	r_PtxRegister60 = ShiftLeft(uint32_t(r_PtxRegister5), uint32_t(11));						// PTX L70
	r_PtxRegister61 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));								// PTX L71
	r_PtxRegister62 = r_PtxRegister61 & 1536;													// PTX L72
	r_PtxRegister11 = r_PtxRegister60 | r_PtxRegister62;										// PTX L73
	r_PtxRegister63 = uint32_t(r_PtxRegister59) + uint32_t(r_PtxRegister11);					// PTX L74
	r_PtxU64Register13 = uint64_t(int64_t(int32_t(r_PtxRegister63)) * int64_t(int32_t(4)));		// PTX L75
	r_PtxU64Register14 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register13);				// PTX L76
	r_LaneIndexAtPtx78 = uint32_t((threadIdx.x & 31u));											// PTX L78
	r_PtxU64Register15 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx78)) * int64_t(int32_t(16))); // PTX L80
	r_PtxU64Register5 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register15);			// PTX L81
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register5));
		r_MmaBHalf2WordAtPtx83R307 = r_Value.x;
		r_MmaBHalf2WordAtPtx83R306 = r_Value.y;
		r_MmaBHalf2WordAtPtx83R305 = r_Value.z;
		r_MmaBHalf2WordAtPtx83R304 = r_Value.w;
	} // PTX L83
	r_LaneIndexAtPtx86 = uint32_t((threadIdx.x & 31u));											// PTX L86
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx86)) * int64_t(int32_t(16))); // PTX L88
	r_PtxU64Register17 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register16);			// PTX L89
	r_PtxU64Register6 = uint64_t(r_PtxU64Register17) + uint64_t(512);							// PTX L90
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register6));
		r_MmaBHalf2WordAtPtx92R303 = r_Value.x;
		r_MmaBHalf2WordAtPtx92R302 = r_Value.y;
		r_MmaBHalf2WordAtPtx92R301 = r_Value.z;
		r_MmaBHalf2WordAtPtx92R300 = r_Value.w;
	} // PTX L92
	r_LaneIndexAtPtx95 = uint32_t((threadIdx.x & 31u));											// PTX L95
	r_PtxU64Register18 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx95)) * int64_t(int32_t(16))); // PTX L97
	r_PtxU64Register19 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register18);			// PTX L98
	r_PtxU64Register7 = uint64_t(r_PtxU64Register19) + uint64_t(1024);							// PTX L99
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register7));
		r_MmaBHalf2WordAtPtx101R299 = r_Value.x;
		r_MmaBHalf2WordAtPtx101R298 = r_Value.y;
		r_MmaBHalf2WordAtPtx101R297 = r_Value.z;
		r_MmaBHalf2WordAtPtx101R296 = r_Value.w;
	} // PTX L101
	r_LaneIndexAtPtx104 = uint32_t((threadIdx.x & 31u));										 // PTX L104
	r_PtxU64Register20 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx104)) * int64_t(int32_t(16))); // PTX L106
	r_PtxU64Register21 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register20);			 // PTX L107
	r_PtxU64Register8 = uint64_t(r_PtxU64Register21) + uint64_t(1536);							 // PTX L108
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register8));
		r_MmaBHalf2WordAtPtx110R295 = r_Value.x;
		r_MmaBHalf2WordAtPtx110R294 = r_Value.y;
		r_MmaBHalf2WordAtPtx110R293 = r_Value.z;
		r_MmaBHalf2WordAtPtx110R292 = r_Value.w;
	} // PTX L110
	r_LaneIndexAtPtx113 = uint32_t((threadIdx.x & 31u));										 // PTX L113
	r_PtxU64Register22 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx113)) * int64_t(int32_t(16))); // PTX L115
	r_PtxU64Register23 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register22);			 // PTX L116
	r_PtxU64Register9 = uint64_t(r_PtxU64Register23) + uint64_t(32768);							 // PTX L117
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register9));
		r_MmaBHalf2WordAtPtx119R291 = r_Value.x;
		r_MmaBHalf2WordAtPtx119R290 = r_Value.y;
		r_MmaBHalf2WordAtPtx119R289 = r_Value.z;
		r_MmaBHalf2WordAtPtx119R288 = r_Value.w;
	} // PTX L119
	r_LaneIndexAtPtx122 = uint32_t((threadIdx.x & 31u));										 // PTX L122
	r_PtxU64Register24 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx122)) * int64_t(int32_t(16))); // PTX L124
	r_PtxU64Register25 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register24);			 // PTX L125
	r_PtxU64Register10 = uint64_t(r_PtxU64Register25) + uint64_t(33280);						 // PTX L126
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register10));
		r_MmaBHalf2WordAtPtx128R287 = r_Value.x;
		r_MmaBHalf2WordAtPtx128R286 = r_Value.y;
		r_MmaBHalf2WordAtPtx128R285 = r_Value.z;
		r_MmaBHalf2WordAtPtx128R284 = r_Value.w;
	} // PTX L128
	r_LaneIndexAtPtx131 = uint32_t((threadIdx.x & 31u));										 // PTX L131
	r_PtxU64Register26 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx131)) * int64_t(int32_t(16))); // PTX L133
	r_PtxU64Register27 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register26);			 // PTX L134
	r_PtxU64Register11 = uint64_t(r_PtxU64Register27) + uint64_t(33792);						 // PTX L135
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register11));
		r_MmaBHalf2WordAtPtx137R283 = r_Value.x;
		r_MmaBHalf2WordAtPtx137R282 = r_Value.y;
		r_MmaBHalf2WordAtPtx137R281 = r_Value.z;
		r_MmaBHalf2WordAtPtx137R280 = r_Value.w;
	} // PTX L137
	r_LaneIndexAtPtx140 = uint32_t((threadIdx.x & 31u));										 // PTX L140
	r_PtxU64Register28 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx140)) * int64_t(int32_t(16))); // PTX L142
	r_PtxU64Register29 = uint64_t(r_PtxU64Register14) + uint64_t(r_PtxU64Register28);			 // PTX L143
	r_PtxU64Register12 = uint64_t(r_PtxU64Register29) + uint64_t(34304);						 // PTX L144
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register12));
		r_MmaBHalf2WordAtPtx146R279 = r_Value.x;
		r_MmaBHalf2WordAtPtx146R278 = r_Value.y;
		r_MmaBHalf2WordAtPtx146R277 = r_Value.z;
		r_MmaBHalf2WordAtPtx146R276 = r_Value.w;
	} // PTX L146
	r_PtxRegister64 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));			 // PTX L148
	r_PtxRegister65 = r_PtxRegister64 & 1;									 // PTX L149
	r_PtxRegister12 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));			 // PTX L150
	r_PtxRegister66 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(4));			 // PTX L151
	r_PtxRegister67 = r_PtxRegister66 & 16;									 // PTX L152
	r_PtxRegister68 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(9));	 // PTX L153
	r_PtxRegister69 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			 // PTX L154
	r_PtxRegister70 = r_PtxRegister69 & 256;								 // PTX L155
	r_PtxRegister71 = r_PtxRegister68 | r_PtxRegister70;					 // PTX L156
	r_PtxRegister72 = r_PtxRegister69 & 128;								 // PTX L157
	r_PtxRegister13 = r_PtxRegister71 | r_PtxRegister72;					 // PTX L158
	r_PtxRegister73 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));				 // PTX L159
	r_PtxRegister74 = uint32_t(r_PtxRegister12) + uint32_t(r_PtxRegister73); // PTX L160
	r_PtxRegister14 = uint32_t(r_PtxRegister65) + uint32_t(r_PtxRegister6);	 // PTX L161
	r_PtxRegister15 = uint32_t(r_PtxRegister67) + uint32_t(r_PtxRegister7);	 // PTX L162
	r_PtxRegister16 = r_Scalar32Bits & -4;									 // PTX L163
	r_bPtxPredicate5 = uint32_t(r_PtxRegister16) == uint32_t(4);			 // PTX L164
	r_bPtxPredicate6 = int32_t(r_PtxRegister74) < int32_t(r_PtxRegister8);	 // PTX L165
	r_PtxRegister17 = uint32_t(r_PtxRegister74) * uint32_t(r_PtxRegister9);	 // PTX L166
	r_PtxRegister18 = r_bPtxPredicate5 ? 0 : r_PtxRegister17;				 // PTX L167
	r_bPtxPredicate1 = r_bPtxPredicate5 | r_bPtxPredicate6;					 // PTX L168
	r_bPtxPredicate38 = bool(0);											 // PTX L169
	r_bPtxPredicate7 = !r_bPtxPredicate1;									 // PTX L170
	r_PtxRegister240 = uint32_t(r_PtxRegister14);							 // PTX L171
	if (r_bPtxPredicate7)
	{
		goto L__BB42_5;
	} // PTX L172
	r_PtxRegister75 = r_Scalar36Bits & -4;						 // PTX L173
	r_bPtxPredicate8 = uint32_t(r_PtxRegister75) == uint32_t(4); // PTX L174
	r_bPtxPredicate38 = bool(-1);								 // PTX L175
	r_PtxRegister240 = uint32_t(0);								 // PTX L176
	if (r_bPtxPredicate8)
	{
		goto L__BB42_5;
	} // PTX L177
	r_bPtxPredicate38 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister9); // PTX L178
	r_PtxRegister240 = uint32_t(r_PtxRegister14);							// PTX L179
L__BB42_5:																	// PTX L180
	r_PtxU64Register89 = uint64_t(0);										// PTX L181
	r_bPtxPredicate9 = !r_bPtxPredicate38;									// PTX L182
	if (r_bPtxPredicate9)
	{
		goto L__BB42_7;
	} // PTX L183
	r_PtxRegister76 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister240); // PTX L184
	r_PtxRegister77 = ShiftLeft(uint32_t(r_PtxRegister76), uint32_t(12));	  // PTX L185
	r_PtxRegister78 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(3));	  // PTX L186
	r_PtxRegister79 = uint32_t(r_PtxRegister77) + uint32_t(r_PtxRegister78);  // PTX L187
	r_PtxU64Register89 = SignExtendWordBits(r_PtxRegister79);				  // PTX L188
L__BB42_7:																	  // PTX L189
	r_PtxU64Register90 = uint64_t(0);										  // PTX L190
	if (r_bPtxPredicate9)
	{
		goto L__BB42_9;
	} // PTX L191
	r_PtxU64Register30 = ShiftLeft(uint64_t(r_PtxU64Register89), uint32_t(2));	  // PTX L192
	r_PtxU64Register90 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register30); // PTX L193
L__BB42_9:																		  // PTX L194
	r_PtxRegister80 = ShiftLeft(uint32_t(r_PtxRegister13), uint32_t(2));		  // PTX L195
	r_PtxRegister81 = uint32_t(0u /* exact native shared-region offset */);		  // PTX L196
	r_PtxRegister87 = uint32_t(r_PtxRegister81) + uint32_t(r_PtxRegister80);	  // PTX L197
	if (r_bPtxPredicate9)
	{
		goto L__BB42_12;
	} // PTX L198
	r_PtxRegister86 = uint32_t(-1);								  // PTX L199
	r_PtxRegister85 = Elected(r_PtxRegister86);					  // PTX L201
	r_bPtxPredicate10 = uint32_t(r_PtxRegister85) == uint32_t(0); // PTX L207
	if (r_bPtxPredicate10)
	{
		goto L__BB42_13;
	} // PTX L208
	r_PtxU64Register31 = r_PtxU64Register90;									// PTX L209
	r_PtxRegister89 = uint32_t(12288u /* exact native shared-region offset */); // PTX L210
	r_PtxRegister88 = uint32_t(512);											// PTX L211
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister87, r_PtxU64Register31, r_PtxRegister88,
			 r_PtxRegister89);												 // PTX L213
	BarrierExpect(s_SharedStorage, r_PtxRegister89, r_PtxRegister88);		 // PTX L216
	goto L__BB42_13;														 // PTX L218
L__BB42_12:																	 // PTX L219
	r_LaneIndexAtPtx221 = uint32_t((threadIdx.x & 31u));					 // PTX L221
	r_PtxRegister84 = ShiftLeft(uint32_t(r_LaneIndexAtPtx221), uint32_t(4)); // PTX L223
	r_PtxRegister83 = uint32_t(r_PtxRegister87) + uint32_t(r_PtxRegister84); // PTX L224
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister83)) =
		make_uint4(r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113,
				   r_PackedHalf2AtPtx64R113);					// PTX L226
L__BB42_13:														// PTX L228
	r_PtxRegister19 = uint32_t(r_PtxRegister15) + uint32_t(32); // PTX L229
	r_bPtxPredicate39 = bool(0);								// PTX L230
	r_PtxRegister241 = uint32_t(r_PtxRegister14);				// PTX L231
	if (r_bPtxPredicate7)
	{
		goto L__BB42_16;
	} // PTX L232
	r_PtxRegister90 = r_Scalar36Bits & -4;						  // PTX L233
	r_bPtxPredicate11 = uint32_t(r_PtxRegister90) == uint32_t(4); // PTX L234
	r_bPtxPredicate39 = bool(-1);								  // PTX L235
	r_PtxRegister241 = uint32_t(0);								  // PTX L236
	if (r_bPtxPredicate11)
	{
		goto L__BB42_16;
	} // PTX L237
	r_bPtxPredicate39 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister9); // PTX L238
	r_PtxRegister241 = uint32_t(r_PtxRegister14);							// PTX L239
L__BB42_16:																	// PTX L240
	r_PtxU64Register91 = uint64_t(0);										// PTX L241
	r_bPtxPredicate12 = !r_bPtxPredicate39;									// PTX L242
	if (r_bPtxPredicate12)
	{
		goto L__BB42_18;
	} // PTX L243
	r_PtxRegister91 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister241); // PTX L244
	r_PtxRegister92 = ShiftLeft(uint32_t(r_PtxRegister91), uint32_t(12));	  // PTX L245
	r_PtxRegister93 = ShiftLeft(uint32_t(r_PtxRegister19), uint32_t(3));	  // PTX L246
	r_PtxRegister94 = uint32_t(r_PtxRegister92) + uint32_t(r_PtxRegister93);  // PTX L247
	r_PtxU64Register91 = SignExtendWordBits(r_PtxRegister94);				  // PTX L248
L__BB42_18:																	  // PTX L249
	r_PtxU64Register92 = uint64_t(0);										  // PTX L250
	if (r_bPtxPredicate12)
	{
		goto L__BB42_20;
	} // PTX L251
	r_PtxU64Register32 = ShiftLeft(uint64_t(r_PtxU64Register91), uint32_t(2));	  // PTX L252
	r_PtxU64Register92 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register32); // PTX L253
L__BB42_20:																		  // PTX L254
	if (r_bPtxPredicate12)
	{
		goto L__BB42_23;
	} // PTX L255
	r_PtxRegister100 = uint32_t(-1);							  // PTX L256
	r_PtxRegister99 = Elected(r_PtxRegister100);				  // PTX L258
	r_bPtxPredicate13 = uint32_t(r_PtxRegister99) == uint32_t(0); // PTX L264
	if (r_bPtxPredicate13)
	{
		goto L__BB42_24;
	} // PTX L265
	r_PtxRegister101 = uint32_t(r_PtxRegister87) + uint32_t(4096);				 // PTX L266
	r_PtxU64Register33 = r_PtxU64Register92;									 // PTX L267
	r_PtxRegister104 = uint32_t(12288u /* exact native shared-region offset */); // PTX L268
	r_PtxRegister103 = uint32_t(r_PtxRegister104) + uint32_t(8);				 // PTX L269
	r_PtxRegister102 = uint32_t(512);											 // PTX L270
	CopyBulk(s_SharedStorage, r_PtxRegister101, r_PtxU64Register33, r_PtxRegister102,
			 r_PtxRegister103);												 // PTX L272
	BarrierExpect(s_SharedStorage, r_PtxRegister103, r_PtxRegister102);		 // PTX L275
	goto L__BB42_24;														 // PTX L277
L__BB42_23:																	 // PTX L278
	r_LaneIndexAtPtx280 = uint32_t((threadIdx.x & 31u));					 // PTX L280
	r_PtxRegister97 = ShiftLeft(uint32_t(r_LaneIndexAtPtx280), uint32_t(4)); // PTX L282
	r_PtxRegister98 = uint32_t(r_PtxRegister87) + uint32_t(r_PtxRegister97); // PTX L283
	r_PtxRegister96 = uint32_t(r_PtxRegister98) + uint32_t(4096);			 // PTX L284
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister96)) =
		make_uint4(r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113,
				   r_PackedHalf2AtPtx64R113);	  // PTX L286
L__BB42_24:										  // PTX L288
	r_bPtxPredicate40 = bool(0);				  // PTX L289
	r_PtxRegister242 = uint32_t(r_PtxRegister14); // PTX L290
	if (r_bPtxPredicate7)
	{
		goto L__BB42_27;
	} // PTX L291
	r_PtxRegister105 = r_Scalar36Bits & -4;						   // PTX L292
	r_bPtxPredicate14 = uint32_t(r_PtxRegister105) == uint32_t(4); // PTX L293
	r_bPtxPredicate40 = bool(-1);								   // PTX L294
	r_PtxRegister242 = uint32_t(0);								   // PTX L295
	if (r_bPtxPredicate14)
	{
		goto L__BB42_27;
	} // PTX L296
	r_bPtxPredicate40 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister9); // PTX L297
	r_PtxRegister242 = uint32_t(r_PtxRegister14);							// PTX L298
L__BB42_27:																	// PTX L299
	r_PtxU64Register93 = uint64_t(0);										// PTX L300
	r_bPtxPredicate15 = !r_bPtxPredicate40;									// PTX L301
	if (r_bPtxPredicate15)
	{
		goto L__BB42_29;
	} // PTX L302
	r_PtxRegister106 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister242);	// PTX L303
	r_PtxRegister107 = ShiftLeft(uint32_t(r_PtxRegister106), uint32_t(12));		// PTX L304
	r_PtxRegister108 = ShiftLeft(uint32_t(r_PtxRegister15), uint32_t(3));		// PTX L305
	r_PtxRegister109 = uint32_t(r_PtxRegister108) + uint32_t(r_PtxRegister107); // PTX L306
	r_PtxRegister110 = uint32_t(r_PtxRegister109) + uint32_t(512);				// PTX L307
	r_PtxU64Register93 = SignExtendWordBits(r_PtxRegister110);					// PTX L308
L__BB42_29:																		// PTX L309
	r_PtxU64Register94 = uint64_t(0);											// PTX L310
	if (r_bPtxPredicate15)
	{
		goto L__BB42_31;
	} // PTX L311
	r_PtxU64Register34 = ShiftLeft(uint64_t(r_PtxU64Register93), uint32_t(2));	  // PTX L312
	r_PtxU64Register94 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register34); // PTX L313
L__BB42_31:																		  // PTX L314
	if (r_bPtxPredicate15)
	{
		goto L__BB42_34;
	} // PTX L315
	r_PtxRegister117 = uint32_t(-1);							   // PTX L316
	r_PtxRegister116 = Elected(r_PtxRegister117);				   // PTX L318
	r_bPtxPredicate16 = uint32_t(r_PtxRegister116) == uint32_t(0); // PTX L324
	if (r_bPtxPredicate16)
	{
		goto L__BB42_35;
	} // PTX L325
	r_PtxRegister118 = uint32_t(r_PtxRegister87) + uint32_t(8192);				 // PTX L326
	r_PtxU64Register35 = r_PtxU64Register94;									 // PTX L327
	r_PtxRegister121 = uint32_t(12288u /* exact native shared-region offset */); // PTX L328
	r_PtxRegister120 = uint32_t(r_PtxRegister121) + uint32_t(16);				 // PTX L329
	r_PtxRegister119 = uint32_t(512);											 // PTX L330
	CopyBulk(s_SharedStorage, r_PtxRegister118, r_PtxU64Register35, r_PtxRegister119,
			 r_PtxRegister120);												   // PTX L332
	BarrierExpect(s_SharedStorage, r_PtxRegister120, r_PtxRegister119);		   // PTX L335
	goto L__BB42_35;														   // PTX L337
L__BB42_34:																	   // PTX L338
	r_LaneIndexAtPtx340 = uint32_t((threadIdx.x & 31u));					   // PTX L340
	r_PtxRegister114 = ShiftLeft(uint32_t(r_LaneIndexAtPtx340), uint32_t(4));  // PTX L342
	r_PtxRegister115 = uint32_t(r_PtxRegister87) + uint32_t(r_PtxRegister114); // PTX L343
	r_PtxRegister112 = uint32_t(r_PtxRegister115) + uint32_t(8192);			   // PTX L344
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister112)) =
		make_uint4(r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113,
				   r_PackedHalf2AtPtx64R113);									 // PTX L346
L__BB42_35:																		 // PTX L348
	r_PtxRegister122 = uint32_t(12288u /* exact native shared-region offset */); // PTX L349
	r_PtxRegister123 = uint32_t(1);												 // PTX L350
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register36 = BarrierArrive(s_SharedStorage, r_PtxRegister122, r_PtxRegister123); // PTX L352
L__BB42_36:																					 // PTX L354
	r_PtxRegister125 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L355
	r_PtxRegister124 = BarrierReady(s_SharedStorage, r_PtxRegister125, r_PtxU64Register36);	 // PTX L357
	r_bPtxPredicate17 = uint32_t(r_PtxRegister124) == uint32_t(0);							 // PTX L363
	if (r_bPtxPredicate17)
	{
		goto L__BB42_36;
	} // PTX L364
	r_PtxRegister20 = r_Scalar36Bits & -4;														   // PTX L365
	r_PtxRegister21 = ShiftLeft(uint32_t(r_PtxRegister12), uint32_t(11));						   // PTX L366
	r_PtxRegister22 = uint32_t(r_PtxRegister19) + uint32_t(64);									   // PTX L367
	r_bPtxPredicate2 = int32_t(r_PtxRegister74) < int32_t(r_PtxRegister8);						   // PTX L368
	r_PtxRegister275 = uint32_t(0);																   // PTX L369
	r_MmaAccumulatorHalf2WordAtPtx370R243 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L370
	r_MmaAccumulatorHalf2WordAtPtx371R244 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L371
	r_MmaAccumulatorHalf2WordAtPtx372R245 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L372
	r_MmaAccumulatorHalf2WordAtPtx373R246 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L373
	r_MmaAccumulatorHalf2WordAtPtx374R247 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L374
	r_MmaAccumulatorHalf2WordAtPtx375R248 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L375
	r_MmaAccumulatorHalf2WordAtPtx376R249 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L376
	r_MmaAccumulatorHalf2WordAtPtx377R250 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L377
	r_MmaAccumulatorHalf2WordAtPtx378R251 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L378
	r_MmaAccumulatorHalf2WordAtPtx379R252 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L379
	r_MmaAccumulatorHalf2WordAtPtx380R253 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L380
	r_MmaAccumulatorHalf2WordAtPtx381R254 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L381
	r_MmaAccumulatorHalf2WordAtPtx382R255 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L382
	r_MmaAccumulatorHalf2WordAtPtx383R256 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L383
	r_MmaAccumulatorHalf2WordAtPtx384R257 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L384
	r_MmaAccumulatorHalf2WordAtPtx385R258 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L385
	r_MmaAccumulatorHalf2WordAtPtx386R259 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L386
	r_MmaAccumulatorHalf2WordAtPtx387R260 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L387
	r_MmaAccumulatorHalf2WordAtPtx388R261 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L388
	r_MmaAccumulatorHalf2WordAtPtx389R262 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L389
	r_MmaAccumulatorHalf2WordAtPtx390R263 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L390
	r_MmaAccumulatorHalf2WordAtPtx391R264 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L391
	r_MmaAccumulatorHalf2WordAtPtx392R265 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L392
	r_MmaAccumulatorHalf2WordAtPtx393R266 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L393
	r_MmaAccumulatorHalf2WordAtPtx394R267 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L394
	r_MmaAccumulatorHalf2WordAtPtx395R268 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L395
	r_MmaAccumulatorHalf2WordAtPtx396R269 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L396
	r_MmaAccumulatorHalf2WordAtPtx397R270 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L397
	r_MmaAccumulatorHalf2WordAtPtx398R271 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L398
	r_MmaAccumulatorHalf2WordAtPtx399R272 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L399
	r_MmaAccumulatorHalf2WordAtPtx400R273 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L400
	r_MmaAccumulatorHalf2WordAtPtx401R274 = uint32_t(r_PackedHalf2AtPtx64R113);					   // PTX L401
L__BB42_38:																						   // PTX L402
	r_PtxRegister182 = ShiftRight(uint32_t(r_PtxRegister275), uint32_t(5));						   // PTX L403
	r_PtxU16Register1 = uint16_t(r_PtxRegister182);												   // PTX L404
	r_PtxU16Register2 = uint16_t(uint32_t(uint16_t(r_PtxU16Register1)) * uint32_t(uint16_t(171))); // PTX L405
	r_PtxU16Register3 = ShiftRight(uint16_t(r_PtxU16Register2), uint32_t(9));					   // PTX L406
	r_PtxU16Register4 = uint16_t(uint32_t(uint16_t(r_PtxU16Register3)) * uint32_t(uint16_t(3)));   // PTX L407
	r_PtxU16Register5 = uint16_t(r_PtxU16Register1) - uint16_t(r_PtxU16Register4);				   // PTX L408
	r_PtxRegister183 = uint32_t(uint16_t(r_PtxU16Register5));									   // PTX L409
	r_PtxRegister23 = r_PtxRegister183 & 255;													   // PTX L410
	r_PtxU16Register6 = r_PtxU16Register5 & 255;												   // PTX L411
	r_PtxRegister24 = uint32_t(uint16_t(r_PtxU16Register6)) * uint32_t(uint16_t(4096));			   // PTX L412
	r_LaneIndexAtPtx414 = uint32_t((threadIdx.x & 31u));										   // PTX L414
	r_PtxRegister184 = uint32_t(r_PtxRegister24) + uint32_t(r_PtxRegister21);					   // PTX L416
	r_PtxRegister185 = uint32_t(0u /* exact native shared-region offset */);					   // PTX L417
	r_PtxRegister186 = uint32_t(r_PtxRegister185) + uint32_t(r_PtxRegister184);					   // PTX L418
	r_PtxRegister187 = ShiftLeft(uint32_t(r_LaneIndexAtPtx414), uint32_t(4));					   // PTX L419
	r_PtxRegister127 = uint32_t(r_PtxRegister186) + uint32_t(r_PtxRegister187);					   // PTX L420
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister127));
		r_MmaAHalf2WordAtPtx422R134 = r_Value.x;
		r_MmaAHalf2WordAtPtx422R135 = r_Value.y;
		r_MmaAHalf2WordAtPtx422R136 = r_Value.z;
		r_MmaAHalf2WordAtPtx422R137 = r_Value.w;
	} // PTX L422
	r_LaneIndexAtPtx425 = uint32_t((threadIdx.x & 31u));						// PTX L425
	r_PtxRegister188 = ShiftLeft(uint32_t(r_LaneIndexAtPtx425), uint32_t(4));	// PTX L427
	r_PtxRegister189 = uint32_t(r_PtxRegister186) + uint32_t(r_PtxRegister188); // PTX L428
	r_PtxRegister129 = uint32_t(r_PtxRegister189) + uint32_t(512);				// PTX L429
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister129));
		r_MmaAHalf2WordAtPtx431R138 = r_Value.x;
		r_MmaAHalf2WordAtPtx431R139 = r_Value.y;
		r_MmaAHalf2WordAtPtx431R140 = r_Value.z;
		r_MmaAHalf2WordAtPtx431R141 = r_Value.w;
	} // PTX L431
	r_LaneIndexAtPtx434 = uint32_t((threadIdx.x & 31u));						// PTX L434
	r_PtxRegister190 = ShiftLeft(uint32_t(r_LaneIndexAtPtx434), uint32_t(4));	// PTX L436
	r_PtxRegister191 = uint32_t(r_PtxRegister186) + uint32_t(r_PtxRegister190); // PTX L437
	r_PtxRegister131 = uint32_t(r_PtxRegister191) + uint32_t(1024);				// PTX L438
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister131));
		r_MmaAHalf2WordAtPtx440R158 = r_Value.x;
		r_MmaAHalf2WordAtPtx440R159 = r_Value.y;
		r_MmaAHalf2WordAtPtx440R160 = r_Value.z;
		r_MmaAHalf2WordAtPtx440R161 = r_Value.w;
	} // PTX L440
	r_LaneIndexAtPtx443 = uint32_t((threadIdx.x & 31u));						// PTX L443
	r_PtxRegister192 = ShiftLeft(uint32_t(r_LaneIndexAtPtx443), uint32_t(4));	// PTX L445
	r_PtxRegister193 = uint32_t(r_PtxRegister186) + uint32_t(r_PtxRegister192); // PTX L446
	r_PtxRegister133 = uint32_t(r_PtxRegister193) + uint32_t(1536);				// PTX L447
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister133));
		r_MmaAHalf2WordAtPtx449R162 = r_Value.x;
		r_MmaAHalf2WordAtPtx449R163 = r_Value.y;
		r_MmaAHalf2WordAtPtx449R164 = r_Value.z;
		r_MmaAHalf2WordAtPtx449R165 = r_Value.w;
	} // PTX L449
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx452R142, r_MmaAccumulatorHalf2WordAtPtx452R143,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx83R307, r_MmaBHalf2WordAtPtx83R306,
			r_MmaAccumulatorHalf2WordAtPtx391R264, r_MmaAccumulatorHalf2WordAtPtx390R263); // PTX L452
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx459R144, r_MmaAccumulatorHalf2WordAtPtx459R145,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx83R305, r_MmaBHalf2WordAtPtx83R304,
			r_MmaAccumulatorHalf2WordAtPtx389R262, r_MmaAccumulatorHalf2WordAtPtx388R261); // PTX L459
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx391R264, r_MmaAccumulatorHalf2WordAtPtx390R263,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx119R291, r_MmaBHalf2WordAtPtx119R290,
			r_MmaAccumulatorHalf2WordAtPtx452R142, r_MmaAccumulatorHalf2WordAtPtx452R143); // PTX L466
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx389R262, r_MmaAccumulatorHalf2WordAtPtx388R261,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx119R289, r_MmaBHalf2WordAtPtx119R288,
			r_MmaAccumulatorHalf2WordAtPtx459R144, r_MmaAccumulatorHalf2WordAtPtx459R145); // PTX L473
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx480R146, r_MmaAccumulatorHalf2WordAtPtx480R147,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx92R303, r_MmaBHalf2WordAtPtx92R302,
			r_MmaAccumulatorHalf2WordAtPtx387R260, r_MmaAccumulatorHalf2WordAtPtx386R259); // PTX L480
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx487R148, r_MmaAccumulatorHalf2WordAtPtx487R149,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx92R301, r_MmaBHalf2WordAtPtx92R300,
			r_MmaAccumulatorHalf2WordAtPtx385R258, r_MmaAccumulatorHalf2WordAtPtx384R257); // PTX L487
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx387R260, r_MmaAccumulatorHalf2WordAtPtx386R259,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx128R287, r_MmaBHalf2WordAtPtx128R286,
			r_MmaAccumulatorHalf2WordAtPtx480R146, r_MmaAccumulatorHalf2WordAtPtx480R147); // PTX L494
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx385R258, r_MmaAccumulatorHalf2WordAtPtx384R257,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx128R285, r_MmaBHalf2WordAtPtx128R284,
			r_MmaAccumulatorHalf2WordAtPtx487R148, r_MmaAccumulatorHalf2WordAtPtx487R149); // PTX L501
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx508R150, r_MmaAccumulatorHalf2WordAtPtx508R151,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx101R299, r_MmaBHalf2WordAtPtx101R298,
			r_MmaAccumulatorHalf2WordAtPtx383R256, r_MmaAccumulatorHalf2WordAtPtx382R255); // PTX L508
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx515R152, r_MmaAccumulatorHalf2WordAtPtx515R153,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx101R297, r_MmaBHalf2WordAtPtx101R296,
			r_MmaAccumulatorHalf2WordAtPtx381R254, r_MmaAccumulatorHalf2WordAtPtx380R253); // PTX L515
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx383R256, r_MmaAccumulatorHalf2WordAtPtx382R255,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx137R283, r_MmaBHalf2WordAtPtx137R282,
			r_MmaAccumulatorHalf2WordAtPtx508R150, r_MmaAccumulatorHalf2WordAtPtx508R151); // PTX L522
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx381R254, r_MmaAccumulatorHalf2WordAtPtx380R253,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx137R281, r_MmaBHalf2WordAtPtx137R280,
			r_MmaAccumulatorHalf2WordAtPtx515R152, r_MmaAccumulatorHalf2WordAtPtx515R153); // PTX L529
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx536R154, r_MmaAccumulatorHalf2WordAtPtx536R155,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx110R295, r_MmaBHalf2WordAtPtx110R294,
			r_MmaAccumulatorHalf2WordAtPtx379R252, r_MmaAccumulatorHalf2WordAtPtx378R251); // PTX L536
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx543R156, r_MmaAccumulatorHalf2WordAtPtx543R157,
			r_MmaAHalf2WordAtPtx422R134, r_MmaAHalf2WordAtPtx422R135, r_MmaAHalf2WordAtPtx422R136,
			r_MmaAHalf2WordAtPtx422R137, r_MmaBHalf2WordAtPtx110R293, r_MmaBHalf2WordAtPtx110R292,
			r_MmaAccumulatorHalf2WordAtPtx377R250, r_MmaAccumulatorHalf2WordAtPtx376R249); // PTX L543
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx379R252, r_MmaAccumulatorHalf2WordAtPtx378R251,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx146R279, r_MmaBHalf2WordAtPtx146R278,
			r_MmaAccumulatorHalf2WordAtPtx536R154, r_MmaAccumulatorHalf2WordAtPtx536R155); // PTX L550
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx377R250, r_MmaAccumulatorHalf2WordAtPtx376R249,
			r_MmaAHalf2WordAtPtx431R138, r_MmaAHalf2WordAtPtx431R139, r_MmaAHalf2WordAtPtx431R140,
			r_MmaAHalf2WordAtPtx431R141, r_MmaBHalf2WordAtPtx146R277, r_MmaBHalf2WordAtPtx146R276,
			r_MmaAccumulatorHalf2WordAtPtx543R156, r_MmaAccumulatorHalf2WordAtPtx543R157); // PTX L557
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx564R166, r_MmaAccumulatorHalf2WordAtPtx564R167,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx83R307, r_MmaBHalf2WordAtPtx83R306,
			r_MmaAccumulatorHalf2WordAtPtx375R248, r_MmaAccumulatorHalf2WordAtPtx374R247); // PTX L564
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx571R168, r_MmaAccumulatorHalf2WordAtPtx571R169,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx83R305, r_MmaBHalf2WordAtPtx83R304,
			r_MmaAccumulatorHalf2WordAtPtx373R246, r_MmaAccumulatorHalf2WordAtPtx372R245); // PTX L571
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx375R248, r_MmaAccumulatorHalf2WordAtPtx374R247,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx119R291, r_MmaBHalf2WordAtPtx119R290,
			r_MmaAccumulatorHalf2WordAtPtx564R166, r_MmaAccumulatorHalf2WordAtPtx564R167); // PTX L578
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx373R246, r_MmaAccumulatorHalf2WordAtPtx372R245,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx119R289, r_MmaBHalf2WordAtPtx119R288,
			r_MmaAccumulatorHalf2WordAtPtx571R168, r_MmaAccumulatorHalf2WordAtPtx571R169); // PTX L585
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx592R170, r_MmaAccumulatorHalf2WordAtPtx592R171,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx92R303, r_MmaBHalf2WordAtPtx92R302,
			r_MmaAccumulatorHalf2WordAtPtx371R244, r_MmaAccumulatorHalf2WordAtPtx370R243); // PTX L592
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx599R172, r_MmaAccumulatorHalf2WordAtPtx599R173,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx92R301, r_MmaBHalf2WordAtPtx92R300,
			r_MmaAccumulatorHalf2WordAtPtx392R265, r_MmaAccumulatorHalf2WordAtPtx393R266); // PTX L599
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx371R244, r_MmaAccumulatorHalf2WordAtPtx370R243,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx128R287, r_MmaBHalf2WordAtPtx128R286,
			r_MmaAccumulatorHalf2WordAtPtx592R170, r_MmaAccumulatorHalf2WordAtPtx592R171); // PTX L606
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx392R265, r_MmaAccumulatorHalf2WordAtPtx393R266,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx128R285, r_MmaBHalf2WordAtPtx128R284,
			r_MmaAccumulatorHalf2WordAtPtx599R172, r_MmaAccumulatorHalf2WordAtPtx599R173); // PTX L613
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx620R174, r_MmaAccumulatorHalf2WordAtPtx620R175,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx101R299, r_MmaBHalf2WordAtPtx101R298,
			r_MmaAccumulatorHalf2WordAtPtx394R267, r_MmaAccumulatorHalf2WordAtPtx395R268); // PTX L620
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx627R176, r_MmaAccumulatorHalf2WordAtPtx627R177,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx101R297, r_MmaBHalf2WordAtPtx101R296,
			r_MmaAccumulatorHalf2WordAtPtx396R269, r_MmaAccumulatorHalf2WordAtPtx397R270); // PTX L627
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx394R267, r_MmaAccumulatorHalf2WordAtPtx395R268,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx137R283, r_MmaBHalf2WordAtPtx137R282,
			r_MmaAccumulatorHalf2WordAtPtx620R174, r_MmaAccumulatorHalf2WordAtPtx620R175); // PTX L634
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx396R269, r_MmaAccumulatorHalf2WordAtPtx397R270,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx137R281, r_MmaBHalf2WordAtPtx137R280,
			r_MmaAccumulatorHalf2WordAtPtx627R176, r_MmaAccumulatorHalf2WordAtPtx627R177); // PTX L641
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx648R178, r_MmaAccumulatorHalf2WordAtPtx648R179,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx110R295, r_MmaBHalf2WordAtPtx110R294,
			r_MmaAccumulatorHalf2WordAtPtx398R271, r_MmaAccumulatorHalf2WordAtPtx399R272); // PTX L648
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx655R180, r_MmaAccumulatorHalf2WordAtPtx655R181,
			r_MmaAHalf2WordAtPtx440R158, r_MmaAHalf2WordAtPtx440R159, r_MmaAHalf2WordAtPtx440R160,
			r_MmaAHalf2WordAtPtx440R161, r_MmaBHalf2WordAtPtx110R293, r_MmaBHalf2WordAtPtx110R292,
			r_MmaAccumulatorHalf2WordAtPtx400R273, r_MmaAccumulatorHalf2WordAtPtx401R274); // PTX L655
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx398R271, r_MmaAccumulatorHalf2WordAtPtx399R272,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx146R279, r_MmaBHalf2WordAtPtx146R278,
			r_MmaAccumulatorHalf2WordAtPtx648R178, r_MmaAccumulatorHalf2WordAtPtx648R179); // PTX L662
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx400R273, r_MmaAccumulatorHalf2WordAtPtx401R274,
			r_MmaAHalf2WordAtPtx449R162, r_MmaAHalf2WordAtPtx449R163, r_MmaAHalf2WordAtPtx449R164,
			r_MmaAHalf2WordAtPtx449R165, r_MmaBHalf2WordAtPtx146R277, r_MmaBHalf2WordAtPtx146R276,
			r_MmaAccumulatorHalf2WordAtPtx655R180, r_MmaAccumulatorHalf2WordAtPtx655R181); // PTX L669
	r_bPtxPredicate18 = uint32_t(r_PtxRegister275) > uint32_t(479);						   // PTX L675
	if (r_bPtxPredicate18)
	{
		goto L__BB42_41;
	} // PTX L676
	r_PtxRegister203 = uint32_t(r_PtxRegister275) + uint32_t(32);								 // PTX L677
	r_PtxRegister204 = uint32_t(r_PtxRegister203) + uint32_t(r_PtxRegister7);					 // PTX L678
	r_PtxRegister205 = ShiftLeft(uint32_t(r_PtxRegister204), uint32_t(9));						 // PTX L679
	r_PtxRegister206 = uint32_t(r_PtxRegister205) + uint32_t(r_PtxRegister11);					 // PTX L680
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_PtxRegister206)) * int64_t(int32_t(4)));	 // PTX L681
	r_PtxU64Register46 = uint64_t(r_Pointer16Bits) + uint64_t(r_PtxU64Register45);				 // PTX L682
	r_LaneIndexAtPtx684 = uint32_t((threadIdx.x & 31u));										 // PTX L684
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx684)) * int64_t(int32_t(16))); // PTX L686
	r_PtxU64Register37 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register47);			 // PTX L687
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register37));
		r_MmaBHalf2WordAtPtx83R307 = r_Value.x;
		r_MmaBHalf2WordAtPtx83R306 = r_Value.y;
		r_MmaBHalf2WordAtPtx83R305 = r_Value.z;
		r_MmaBHalf2WordAtPtx83R304 = r_Value.w;
	} // PTX L689
	r_LaneIndexAtPtx692 = uint32_t((threadIdx.x & 31u));										 // PTX L692
	r_PtxU64Register48 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx692)) * int64_t(int32_t(16))); // PTX L694
	r_PtxU64Register49 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register48);			 // PTX L695
	r_PtxU64Register38 = uint64_t(r_PtxU64Register49) + uint64_t(512);							 // PTX L696
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register38));
		r_MmaBHalf2WordAtPtx92R303 = r_Value.x;
		r_MmaBHalf2WordAtPtx92R302 = r_Value.y;
		r_MmaBHalf2WordAtPtx92R301 = r_Value.z;
		r_MmaBHalf2WordAtPtx92R300 = r_Value.w;
	} // PTX L698
	r_LaneIndexAtPtx701 = uint32_t((threadIdx.x & 31u));										 // PTX L701
	r_PtxU64Register50 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx701)) * int64_t(int32_t(16))); // PTX L703
	r_PtxU64Register51 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register50);			 // PTX L704
	r_PtxU64Register39 = uint64_t(r_PtxU64Register51) + uint64_t(1024);							 // PTX L705
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register39));
		r_MmaBHalf2WordAtPtx101R299 = r_Value.x;
		r_MmaBHalf2WordAtPtx101R298 = r_Value.y;
		r_MmaBHalf2WordAtPtx101R297 = r_Value.z;
		r_MmaBHalf2WordAtPtx101R296 = r_Value.w;
	} // PTX L707
	r_LaneIndexAtPtx710 = uint32_t((threadIdx.x & 31u));										 // PTX L710
	r_PtxU64Register52 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx710)) * int64_t(int32_t(16))); // PTX L712
	r_PtxU64Register53 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register52);			 // PTX L713
	r_PtxU64Register40 = uint64_t(r_PtxU64Register53) + uint64_t(1536);							 // PTX L714
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register40));
		r_MmaBHalf2WordAtPtx110R295 = r_Value.x;
		r_MmaBHalf2WordAtPtx110R294 = r_Value.y;
		r_MmaBHalf2WordAtPtx110R293 = r_Value.z;
		r_MmaBHalf2WordAtPtx110R292 = r_Value.w;
	} // PTX L716
	r_LaneIndexAtPtx719 = uint32_t((threadIdx.x & 31u));										 // PTX L719
	r_PtxU64Register54 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx719)) * int64_t(int32_t(16))); // PTX L721
	r_PtxU64Register55 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register54);			 // PTX L722
	r_PtxU64Register41 = uint64_t(r_PtxU64Register55) + uint64_t(32768);						 // PTX L723
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register41));
		r_MmaBHalf2WordAtPtx119R291 = r_Value.x;
		r_MmaBHalf2WordAtPtx119R290 = r_Value.y;
		r_MmaBHalf2WordAtPtx119R289 = r_Value.z;
		r_MmaBHalf2WordAtPtx119R288 = r_Value.w;
	} // PTX L725
	r_LaneIndexAtPtx728 = uint32_t((threadIdx.x & 31u));										 // PTX L728
	r_PtxU64Register56 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx728)) * int64_t(int32_t(16))); // PTX L730
	r_PtxU64Register57 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register56);			 // PTX L731
	r_PtxU64Register42 = uint64_t(r_PtxU64Register57) + uint64_t(33280);						 // PTX L732
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register42));
		r_MmaBHalf2WordAtPtx128R287 = r_Value.x;
		r_MmaBHalf2WordAtPtx128R286 = r_Value.y;
		r_MmaBHalf2WordAtPtx128R285 = r_Value.z;
		r_MmaBHalf2WordAtPtx128R284 = r_Value.w;
	} // PTX L734
	r_LaneIndexAtPtx737 = uint32_t((threadIdx.x & 31u));										 // PTX L737
	r_PtxU64Register58 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx737)) * int64_t(int32_t(16))); // PTX L739
	r_PtxU64Register59 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register58);			 // PTX L740
	r_PtxU64Register43 = uint64_t(r_PtxU64Register59) + uint64_t(33792);						 // PTX L741
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register43));
		r_MmaBHalf2WordAtPtx137R283 = r_Value.x;
		r_MmaBHalf2WordAtPtx137R282 = r_Value.y;
		r_MmaBHalf2WordAtPtx137R281 = r_Value.z;
		r_MmaBHalf2WordAtPtx137R280 = r_Value.w;
	} // PTX L743
	r_LaneIndexAtPtx746 = uint32_t((threadIdx.x & 31u));										 // PTX L746
	r_PtxU64Register60 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx746)) * int64_t(int32_t(16))); // PTX L748
	r_PtxU64Register61 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register60);			 // PTX L749
	r_PtxU64Register44 = uint64_t(r_PtxU64Register61) + uint64_t(34304);						 // PTX L750
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register44));
		r_MmaBHalf2WordAtPtx146R279 = r_Value.x;
		r_MmaBHalf2WordAtPtx146R278 = r_Value.y;
		r_MmaBHalf2WordAtPtx146R277 = r_Value.z;
		r_MmaBHalf2WordAtPtx146R276 = r_Value.w;
	} // PTX L752
	r_PtxRegister207 = ShiftRight(uint32_t(r_PtxRegister203), uint32_t(5));						   // PTX L754
	r_PtxU16Register7 = uint16_t(r_PtxRegister207);												   // PTX L755
	r_PtxU16Register8 = uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171))); // PTX L756
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					   // PTX L757
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3)));  // PTX L758
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			   // PTX L759
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												   // PTX L760
	r_PtxRegister208 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8));			   // PTX L761
	r_PtxRegister209 = uint32_t(12288u /* exact native shared-region offset */);				   // PTX L762
	r_PtxRegister211 = uint32_t(r_PtxRegister209) + uint32_t(r_PtxRegister208);					   // PTX L763
	r_PtxRegister202 = uint32_t(1);																   // PTX L764
	r_PtxU64Register62 = BarrierArrive(s_SharedStorage, r_PtxRegister211, r_PtxRegister202);	   // PTX L766
L__BB42_40:																						   // PTX L768
	r_PtxRegister210 = BarrierReady(s_SharedStorage, r_PtxRegister211, r_PtxU64Register62);		   // PTX L770
	r_bPtxPredicate19 = uint32_t(r_PtxRegister210) == uint32_t(0);								   // PTX L776
	if (r_bPtxPredicate19)
	{
		goto L__BB42_40;
	} // PTX L777
L__BB42_41:															// PTX L778
	r_bPtxPredicate20 = uint32_t(r_PtxRegister275) > uint32_t(415); // PTX L779
	if (r_bPtxPredicate20)
	{
		goto L__BB42_50;
	} // PTX L780
	r_bPtxPredicate21 = int32_t(r_PtxRegister14) < int32_t(r_PtxRegister9);	  // PTX L781
	r_bPtxPredicate22 = int32_t(r_PtxRegister74) >= int32_t(r_PtxRegister8);  // PTX L782
	r_bPtxPredicate23 = uint32_t(r_PtxRegister20) == uint32_t(4);			  // PTX L783
	r_bPtxPredicate24 = uint32_t(r_PtxRegister16) == uint32_t(4);			  // PTX L784
	r_bPtxPredicate25 = uint32_t(r_PtxRegister16) != uint32_t(4);			  // PTX L785
	r_PtxRegister25 = uint32_t(r_PtxRegister275) + uint32_t(r_PtxRegister22); // PTX L786
	r_bPtxPredicate26 = r_bPtxPredicate25 & r_bPtxPredicate22;				  // PTX L787
	r_bPtxPredicate27 = r_bPtxPredicate24 | r_bPtxPredicate2;				  // PTX L788
	r_bPtxPredicate28 = r_bPtxPredicate26 | r_bPtxPredicate23;				  // PTX L789
	r_PtxRegister212 = r_bPtxPredicate26 ? r_PtxRegister14 : 0;				  // PTX L790
	r_PtxRegister26 = r_bPtxPredicate23 ? r_PtxRegister212 : r_PtxRegister14; // PTX L791
	r_bPtxPredicate29 = r_bPtxPredicate28 | r_bPtxPredicate21;				  // PTX L792
	r_bPtxPredicate3 = r_bPtxPredicate29 & r_bPtxPredicate27;				  // PTX L793
	r_PtxU64Register95 = uint64_t(0);										  // PTX L794
	r_bPtxPredicate30 = !r_bPtxPredicate3;									  // PTX L795
	if (r_bPtxPredicate30)
	{
		goto L__BB42_44;
	} // PTX L796
	r_PtxRegister213 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister26);	// PTX L797
	r_PtxRegister214 = ShiftLeft(uint32_t(r_PtxRegister213), uint32_t(12));		// PTX L798
	r_PtxRegister215 = ShiftLeft(uint32_t(r_PtxRegister25), uint32_t(3));		// PTX L799
	r_PtxRegister216 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister215); // PTX L800
	r_PtxU64Register95 = SignExtendWordBits(r_PtxRegister216);					// PTX L801
L__BB42_44:																		// PTX L802
	r_PtxU64Register96 = uint64_t(0);											// PTX L803
	if (r_bPtxPredicate30)
	{
		goto L__BB42_46;
	} // PTX L804
	r_PtxU64Register63 = ShiftLeft(uint64_t(r_PtxU64Register95), uint32_t(2));	  // PTX L805
	r_PtxU64Register96 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register63); // PTX L806
L__BB42_46:																		  // PTX L807
	if (r_bPtxPredicate30)
	{
		goto L__BB42_49;
	} // PTX L808
	r_PtxRegister222 = uint32_t(-1);							   // PTX L809
	r_PtxRegister221 = Elected(r_PtxRegister222);				   // PTX L811
	r_bPtxPredicate31 = uint32_t(r_PtxRegister221) == uint32_t(0); // PTX L817
	if (r_bPtxPredicate31)
	{
		goto L__BB42_50;
	} // PTX L818
	r_PtxRegister223 = uint32_t(r_PtxRegister87) + uint32_t(r_PtxRegister24);	 // PTX L819
	r_PtxU64Register64 = r_PtxU64Register96;									 // PTX L820
	r_PtxRegister226 = ShiftLeft(uint32_t(r_PtxRegister23), uint32_t(3));		 // PTX L821
	r_PtxRegister227 = uint32_t(12288u /* exact native shared-region offset */); // PTX L822
	r_PtxRegister225 = uint32_t(r_PtxRegister227) + uint32_t(r_PtxRegister226);	 // PTX L823
	r_PtxRegister224 = uint32_t(512);											 // PTX L824
	CopyBulk(s_SharedStorage, r_PtxRegister223, r_PtxU64Register64, r_PtxRegister224,
			 r_PtxRegister225);													// PTX L826
	BarrierExpect(s_SharedStorage, r_PtxRegister225, r_PtxRegister224);			// PTX L829
	goto L__BB42_50;															// PTX L831
L__BB42_49:																		// PTX L832
	r_LaneIndexAtPtx834 = uint32_t((threadIdx.x & 31u));						// PTX L834
	r_PtxRegister219 = uint32_t(r_PtxRegister87) + uint32_t(r_PtxRegister24);	// PTX L836
	r_PtxRegister220 = ShiftLeft(uint32_t(r_LaneIndexAtPtx834), uint32_t(4));	// PTX L837
	r_PtxRegister218 = uint32_t(r_PtxRegister219) + uint32_t(r_PtxRegister220); // PTX L838
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister218)) =
		make_uint4(r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113, r_PackedHalf2AtPtx64R113,
				   r_PackedHalf2AtPtx64R113);						// PTX L840
L__BB42_50:															// PTX L842
	r_bPtxPredicate32 = uint32_t(r_PtxRegister275) < uint32_t(480); // PTX L843
	r_PtxRegister275 = uint32_t(r_PtxRegister275) + uint32_t(32);	// PTX L844
	if (r_bPtxPredicate32)
	{
		goto L__BB42_38;
	} // PTX L845
	r_bPtxPredicate33 = int32_t(r_PtxRegister74) >= int32_t(r_PtxRegister8);				 // PTX L846
	r_bPtxPredicate34 = int32_t(r_PtxRegister6) >= int32_t(r_PtxRegister9);					 // PTX L847
	r_PtxRegister228 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister6);				 // PTX L848
	r_PtxRegister229 = ShiftLeft(uint32_t(r_PtxRegister228), uint32_t(13));					 // PTX L849
	r_PtxRegister230 = uint32_t(r_PtxRegister229) + uint32_t(r_PtxRegister11);				 // PTX L850
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_PtxRegister230)) * int64_t(int32_t(4))); // PTX L851
	r_PtxU64Register4 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register65);			 // PTX L852
	r_bPtxPredicate35 = r_bPtxPredicate33 | r_bPtxPredicate34;								 // PTX L853
	if (r_bPtxPredicate35)
	{
		goto L__BB42_53;
	} // PTX L854
	r_LaneIndexAtPtx856 = uint32_t((threadIdx.x & 31u));										 // PTX L856
	r_PtxU64Register70 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx856)) * int64_t(int32_t(16))); // PTX L858
	r_PtxU64Register66 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register70);			 // PTX L859
	// Phase: global_publication. Publish packed words through the original global-store path; edge predicates and physical output addressing remain in force.
	StoreNoAllocate(r_PtxU64Register66,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx391R264, r_MmaAccumulatorHalf2WordAtPtx390R263,
							   r_MmaAccumulatorHalf2WordAtPtx389R262,
							   r_MmaAccumulatorHalf2WordAtPtx388R261));							 // PTX L861
	r_LaneIndexAtPtx864 = uint32_t((threadIdx.x & 31u));										 // PTX L864
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx864)) * int64_t(int32_t(16))); // PTX L866
	r_PtxU64Register72 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register71);			 // PTX L867
	r_PtxU64Register67 = uint64_t(r_PtxU64Register72) + uint64_t(512);							 // PTX L868
	StoreNoAllocate(r_PtxU64Register67,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx387R260, r_MmaAccumulatorHalf2WordAtPtx386R259,
							   r_MmaAccumulatorHalf2WordAtPtx385R258,
							   r_MmaAccumulatorHalf2WordAtPtx384R257));							 // PTX L870
	r_LaneIndexAtPtx873 = uint32_t((threadIdx.x & 31u));										 // PTX L873
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx873)) * int64_t(int32_t(16))); // PTX L875
	r_PtxU64Register74 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register73);			 // PTX L876
	r_PtxU64Register68 = uint64_t(r_PtxU64Register74) + uint64_t(1024);							 // PTX L877
	StoreNoAllocate(r_PtxU64Register68,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx383R256, r_MmaAccumulatorHalf2WordAtPtx382R255,
							   r_MmaAccumulatorHalf2WordAtPtx381R254,
							   r_MmaAccumulatorHalf2WordAtPtx380R253));							 // PTX L879
	r_LaneIndexAtPtx882 = uint32_t((threadIdx.x & 31u));										 // PTX L882
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx882)) * int64_t(int32_t(16))); // PTX L884
	r_PtxU64Register76 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register75);			 // PTX L885
	r_PtxU64Register69 = uint64_t(r_PtxU64Register76) + uint64_t(1536);							 // PTX L886
	StoreNoAllocate(r_PtxU64Register69,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx379R252, r_MmaAccumulatorHalf2WordAtPtx378R251,
							   r_MmaAccumulatorHalf2WordAtPtx377R250,
							   r_MmaAccumulatorHalf2WordAtPtx376R249));		  // PTX L888
L__BB42_53:																	  // PTX L890
	r_PtxRegister235 = uint32_t(r_PtxRegister6) + uint32_t(1);				  // PTX L891
	r_bPtxPredicate36 = int32_t(r_PtxRegister235) >= int32_t(r_PtxRegister9); // PTX L892
	r_bPtxPredicate37 = r_bPtxPredicate33 | r_bPtxPredicate36;				  // PTX L893
	if (r_bPtxPredicate37)
	{
		goto L__BB42_55;
	} // PTX L894
	r_LaneIndexAtPtx896 = uint32_t((threadIdx.x & 31u));										 // PTX L896
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx896)) * int64_t(int32_t(16))); // PTX L898
	r_PtxU64Register82 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register81);			 // PTX L899
	r_PtxU64Register77 = uint64_t(r_PtxU64Register82) + uint64_t(32768);						 // PTX L900
	StoreNoAllocate(r_PtxU64Register77,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx375R248, r_MmaAccumulatorHalf2WordAtPtx374R247,
							   r_MmaAccumulatorHalf2WordAtPtx373R246,
							   r_MmaAccumulatorHalf2WordAtPtx372R245));							 // PTX L902
	r_LaneIndexAtPtx905 = uint32_t((threadIdx.x & 31u));										 // PTX L905
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx905)) * int64_t(int32_t(16))); // PTX L907
	r_PtxU64Register84 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register83);			 // PTX L908
	r_PtxU64Register78 = uint64_t(r_PtxU64Register84) + uint64_t(33280);						 // PTX L909
	StoreNoAllocate(r_PtxU64Register78,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx371R244, r_MmaAccumulatorHalf2WordAtPtx370R243,
							   r_MmaAccumulatorHalf2WordAtPtx392R265,
							   r_MmaAccumulatorHalf2WordAtPtx393R266));							 // PTX L911
	r_LaneIndexAtPtx914 = uint32_t((threadIdx.x & 31u));										 // PTX L914
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx914)) * int64_t(int32_t(16))); // PTX L916
	r_PtxU64Register86 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register85);			 // PTX L917
	r_PtxU64Register79 = uint64_t(r_PtxU64Register86) + uint64_t(33792);						 // PTX L918
	StoreNoAllocate(r_PtxU64Register79,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx394R267, r_MmaAccumulatorHalf2WordAtPtx395R268,
							   r_MmaAccumulatorHalf2WordAtPtx396R269,
							   r_MmaAccumulatorHalf2WordAtPtx397R270));							 // PTX L920
	r_LaneIndexAtPtx923 = uint32_t((threadIdx.x & 31u));										 // PTX L923
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx923)) * int64_t(int32_t(16))); // PTX L925
	r_PtxU64Register88 = uint64_t(r_PtxU64Register4) + uint64_t(r_PtxU64Register87);			 // PTX L926
	r_PtxU64Register80 = uint64_t(r_PtxU64Register88) + uint64_t(34304);						 // PTX L927
	StoreNoAllocate(r_PtxU64Register80,
					make_uint4(r_MmaAccumulatorHalf2WordAtPtx398R271, r_MmaAccumulatorHalf2WordAtPtx399R272,
							   r_MmaAccumulatorHalf2WordAtPtx400R273,
							   r_MmaAccumulatorHalf2WordAtPtx401R274)); // PTX L929
L__BB42_55:																// PTX L931
	return;																// PTX L932
#endif
}
} // namespace dlssnr::reconstructed::channel_projection_c512_to_c1024_fp16
