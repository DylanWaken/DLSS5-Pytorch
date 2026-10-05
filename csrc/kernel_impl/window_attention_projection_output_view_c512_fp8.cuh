// Readable equivalent of cc_split_swin_16h_proj_512_outview_fp8; not historical source.
#pragma once
#include "window_attention_projection_output_view_c512_abi_fp8.cuh"

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8
{
__global__ __maxnreg__(128) void window_attention_projection_output_view_c512_fp8(Parameters r_Parameters)
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
	bool r_bPtxPredicate37, r_bPtxPredicate38, r_bPtxPredicate39, r_bPtxPredicate40, r_bPtxPredicate41,
		r_bPtxPredicate42, r_bPtxPredicate43, r_bPtxPredicate44, r_bPtxPredicate45, r_bPtxPredicate46,
		r_bPtxPredicate47, r_bPtxPredicate48;
	bool r_bPtxPredicate49, r_bPtxPredicate50, r_bPtxPredicate51, r_bPtxPredicate52, r_bPtxPredicate53,
		r_bPtxPredicate54, r_bPtxPredicate55, r_bPtxPredicate56, r_bPtxPredicate57, r_bPtxPredicate58,
		r_bPtxPredicate59, r_bPtxPredicate60;
	bool r_bPtxPredicate61, r_bPtxPredicate62, r_bPtxPredicate63, r_bPtxPredicate64, r_bPtxPredicate65,
		r_bPtxPredicate66, r_bPtxPredicate67, r_bPtxPredicate68, r_bPtxPredicate69, r_bPtxPredicate70,
		r_bPtxPredicate71, r_bPtxPredicate72;
	bool r_bPtxPredicate73, r_bPtxPredicate74, r_bPtxPredicate75, r_bPtxPredicate76, r_bPtxPredicate77,
		r_bPtxPredicate78, r_bPtxPredicate79, r_bPtxPredicate80, r_bPtxPredicate81, r_bPtxPredicate82,
		r_bPtxPredicate83, r_bPtxPredicate84;
	bool r_bPtxPredicate85, r_bPtxPredicate86, r_bPtxPredicate87, r_bPtxPredicate88, r_bPtxPredicate89,
		r_bPtxPredicate90, r_bPtxPredicate91, r_bPtxPredicate92, r_bPtxPredicate93, r_bPtxPredicate94,
		r_bPtxPredicate95, r_bPtxPredicate96;
	bool r_bPtxPredicate97, r_bPtxPredicate98, r_bPtxPredicate99, r_bPtxPredicate100, r_bPtxPredicate101,
		r_bPtxPredicate102, r_bPtxPredicate103, r_bPtxPredicate104, r_bPtxPredicate105, r_bPtxPredicate106,
		r_bPtxPredicate107, r_bPtxPredicate108;
	bool r_bPtxPredicate109, r_bPtxPredicate110, r_bPtxPredicate111, r_bPtxPredicate112, r_bPtxPredicate113,
		r_bPtxPredicate114, r_bPtxPredicate115, r_bPtxPredicate116, r_bPtxPredicate117, r_bPtxPredicate118,
		r_bPtxPredicate119, r_bPtxPredicate120;
	bool r_bPtxPredicate121, r_bPtxPredicate122, r_bPtxPredicate123, r_bPtxPredicate124, r_bPtxPredicate125,
		r_bPtxPredicate126, r_bPtxPredicate127, r_bPtxPredicate128, r_bPtxPredicate129, r_bPtxPredicate130,
		r_bPtxPredicate131, r_bPtxPredicate132;
	bool r_bPtxPredicate133, r_bPtxPredicate134, r_bPtxPredicate135, r_bPtxPredicate136, r_bPtxPredicate137,
		r_bPtxPredicate138, r_bPtxPredicate139, r_bPtxPredicate140, r_bPtxPredicate141, r_bPtxPredicate142,
		r_bPtxPredicate143, r_bPtxPredicate144;
	bool r_bPtxPredicate145, r_bPtxPredicate146, r_bPtxPredicate147, r_bPtxPredicate148, r_bPtxPredicate149,
		r_bPtxPredicate150, r_bPtxPredicate151, r_bPtxPredicate152, r_bPtxPredicate153, r_bPtxPredicate154,
		r_bPtxPredicate155, r_bPtxPredicate156;
	bool r_bPtxPredicate157, r_bPtxPredicate158, r_bPtxPredicate159, r_bPtxPredicate160, r_bPtxPredicate161,
		r_bPtxPredicate162, r_bPtxPredicate163, r_bPtxPredicate164, r_bPtxPredicate165, r_bPtxPredicate166,
		r_bPtxPredicate167, r_bPtxPredicate168;
	bool r_bPtxPredicate169, r_bPtxPredicate170, r_bPtxPredicate171, r_bPtxPredicate172, r_bPtxPredicate173,
		r_bPtxPredicate174, r_bPtxPredicate175, r_bPtxPredicate176, r_bPtxPredicate177, r_bPtxPredicate178,
		r_bPtxPredicate179, r_bPtxPredicate180;
	bool r_bPtxPredicate181, r_bPtxPredicate182, r_bPtxPredicate183, r_bPtxPredicate184, r_bPtxPredicate185,
		r_bPtxPredicate186, r_bPtxPredicate187, r_bPtxPredicate188, r_bPtxPredicate189, r_bPtxPredicate190,
		r_bPtxPredicate191, r_bPtxPredicate192;
	bool r_bPtxPredicate193, r_bPtxPredicate194, r_bPtxPredicate195, r_bPtxPredicate196, r_bPtxPredicate197,
		r_bPtxPredicate198, r_bPtxPredicate199, r_bPtxPredicate200, r_bPtxPredicate201, r_bPtxPredicate202,
		r_bPtxPredicate203, r_bPtxPredicate204;
	bool r_bPtxPredicate205, r_bPtxPredicate206, r_bPtxPredicate207, r_bPtxPredicate208, r_bPtxPredicate209,
		r_bPtxPredicate210, r_bPtxPredicate211, r_bPtxPredicate212, r_bPtxPredicate213, r_bPtxPredicate214,
		r_bPtxPredicate215, r_bPtxPredicate216;
	bool r_bPtxPredicate217, r_bPtxPredicate218, r_bPtxPredicate219, r_bPtxPredicate220, r_bPtxPredicate221,
		r_bPtxPredicate222, r_bPtxPredicate223, r_bPtxPredicate224, r_bPtxPredicate225, r_bPtxPredicate226,
		r_bPtxPredicate227, r_bPtxPredicate228;
	bool r_bPtxPredicate229, r_bPtxPredicate230, r_bPtxPredicate231, r_bPtxPredicate232, r_bPtxPredicate233,
		r_bPtxPredicate234, r_bPtxPredicate235, r_bPtxPredicate236, r_bPtxPredicate237, r_bPtxPredicate238,
		r_bPtxPredicate239, r_bPtxPredicate240;
	bool r_bPtxPredicate241, r_bPtxPredicate242, r_bPtxPredicate243, r_bPtxPredicate244, r_bPtxPredicate245,
		r_bPtxPredicate246, r_bPtxPredicate247, r_bPtxPredicate248, r_bPtxPredicate249, r_bPtxPredicate250,
		r_bPtxPredicate251, r_bPtxPredicate252;
	bool r_bPtxPredicate253, r_bPtxPredicate254, r_bPtxPredicate255, r_bPtxPredicate256, r_bPtxPredicate257,
		r_bPtxPredicate258, r_bPtxPredicate259, r_bPtxPredicate260, r_bPtxPredicate261, r_bPtxPredicate262,
		r_bPtxPredicate263, r_bPtxPredicate264;
	bool r_bPtxPredicate265, r_bPtxPredicate266, r_bPtxPredicate267, r_bPtxPredicate268, r_bPtxPredicate269,
		r_bPtxPredicate270, r_bPtxPredicate271, r_bPtxPredicate272, r_bPtxPredicate273, r_bPtxPredicate274,
		r_bPtxPredicate275, r_bPtxPredicate276;
	bool r_bPtxPredicate277, r_bPtxPredicate278, r_bPtxPredicate279, r_bPtxPredicate280, r_bPtxPredicate281,
		r_bPtxPredicate282, r_bPtxPredicate283, r_bPtxPredicate284, r_bPtxPredicate285;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint16_t r_PtxU16Register13, r_PtxU16Register14, r_PtxU16Register15, r_PtxU16Register16,
		r_PtxU16Register17, r_PtxU16Register18, r_PtxU16Register19, r_PtxU16Register20, r_PtxU16Register21,
		r_PtxU16Register22, r_PtxU16Register23, r_PtxU16Register24;
	uint16_t r_PtxU16Register25, r_PtxU16Register26, r_PtxU16Register27, r_PtxU16Register28,
		r_PtxU16Register29, r_PtxU16Register30, r_PtxU16Register31, r_PtxU16Register32, r_PtxU16Register33,
		r_PtxU16Register34, r_PtxU16Register35, r_PtxU16Register36;
	uint16_t r_PtxU16Register37, r_PtxU16Register38, r_PtxU16Register39, r_PtxU16Register40,
		r_PtxU16Register41, r_PtxU16Register42, r_PtxU16Register43, r_PtxU16Register44, r_PtxU16Register45,
		r_PtxU16Register46, r_PtxU16Register47, r_PtxU16Register48;
	uint16_t r_PtxU16Register49, r_PtxU16Register50, r_PtxU16Register51, r_PtxU16Register52,
		r_PtxU16Register53, r_PtxU16Register54, r_PtxU16Register55, r_PtxU16Register56, r_PtxU16Register57,
		r_PtxU16Register58, r_PtxU16Register59, r_PtxU16Register60;
	uint16_t r_PtxU16Register61, r_PtxU16Register62, r_PtxU16Register63, r_PtxU16Register64,
		r_PtxU16Register65, r_ConvertedE4PairAtPtx220Rs66, r_PtxU16Register67, r_ConvertedE4PairAtPtx301Rs68,
		r_PtxU16Register69, r_ConvertedE4PairAtPtx373Rs70, r_PtxU16Register71, r_ConvertedE4PairAtPtx444Rs72;
	uint16_t r_PtxU16Register73, r_ConvertedE4PairAtPtx516Rs74, r_PtxU16Register75,
		r_ConvertedE4PairAtPtx587Rs76, r_PtxU16Register77, r_ConvertedE4PairAtPtx659Rs78, r_PtxU16Register79,
		r_ConvertedE4PairAtPtx696Rs80, r_PtxU16Register81, r_ConvertedE4PairAtPtx738Rs82, r_PtxU16Register83,
		r_ConvertedE4PairAtPtx775Rs84;
	uint16_t r_PtxU16Register85, r_ConvertedE4PairAtPtx828Rs86, r_PtxU16Register87,
		r_ConvertedE4PairAtPtx865Rs88, r_PtxU16Register89, r_ConvertedE4PairAtPtx906Rs90, r_PtxU16Register91,
		r_ConvertedE4PairAtPtx943Rs92, r_PtxU16Register93, r_PtxU16Register94, r_PtxU16Register95,
		r_PtxU16Register96;
	uint16_t r_PtxU16Register97, r_PtxU16Register98, r_PtxU16Register99, r_PtxU16Register100,
		r_PtxU16Register101, r_PtxU16Register102, r_PtxU16Register103, r_PtxU16Register104,
		r_PtxU16Register105, r_PtxU16Register106, r_PtxU16Register107, r_PtxU16Register108;
	uint16_t r_PtxU16Register109, r_PtxU16Register110, r_PtxU16Register111, r_PtxU16Register112,
		r_PtxU16Register113, r_PtxU16Register114, r_PtxU16Register115, r_PtxU16Register116,
		r_PtxU16Register117, r_PtxU16Register118, r_PtxU16Register119, r_PtxU16Register120;
	uint16_t r_PtxU16Register121, r_PtxU16Register122, r_PtxU16Register123, r_PtxU16Register124,
		r_PtxU16Register125, r_PtxU16Register126, r_PtxU16Register127, r_PtxU16Register128,
		r_PtxU16Register129, r_PtxU16Register130, r_PtxU16Register131, r_PtxU16Register132;
	uint16_t r_PtxU16Register133, r_PtxU16Register134, r_PtxU16Register135, r_PtxU16Register136,
		r_PtxU16Register137, r_PtxU16Register138, r_PtxU16Register139, r_PtxU16Register140,
		r_PtxU16Register141, r_PtxU16Register142, r_PtxU16Register143, r_PtxU16Register144;
	uint16_t r_PtxU16Register145, r_PtxU16Register146, r_PtxU16Register147, r_PtxU16Register148,
		r_PtxU16Register149, r_PtxU16Register150, r_PtxU16Register151, r_PtxU16Register152,
		r_PtxU16Register153, r_PtxU16Register154, r_PtxU16Register155, r_PtxU16Register156;
	uint16_t r_PtxU16Register157, r_PtxU16Register158, r_PtxU16Register159, r_PtxU16Register160,
		r_PtxU16Register161, r_PtxU16Register162, r_PtxU16Register163, r_PtxU16Register164,
		r_PtxU16Register165, r_PtxU16Register166, r_PtxU16Register167, r_PtxU16Register168;
	uint16_t r_PtxU16Register169, r_ConvertedE4PairAtPtx3203Rs170, r_PtxU16Register171,
		r_ConvertedE4PairAtPtx3290Rs172;
	uint32_t r_CtaZAtPtx21, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_PtxRegister6,
		r_PtxRegister7, r_ThreadY, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
	uint32_t r_PtxRegister13, r_PtxRegister14, r_PtxRegister15, r_PtxRegister16, r_PtxRegister17,
		r_PtxRegister18, r_PtxRegister19, r_PtxRegister20, r_PtxRegister21, r_PtxRegister22, r_PtxRegister23,
		r_PtxRegister24;
	uint32_t r_PtxRegister25, r_PtxRegister26, r_PtxRegister27, r_PtxRegister28, r_PtxRegister29,
		r_PtxRegister30, r_PtxRegister31, r_PtxRegister32, r_PtxRegister33, r_PtxRegister34, r_PtxRegister35,
		r_PtxRegister36;
	uint32_t r_PtxRegister37, r_PtxRegister38, r_PtxRegister39, r_PtxRegister40, r_PtxRegister41,
		r_PtxRegister42, r_PtxRegister43, r_PtxRegister44, r_PtxRegister45, r_PtxRegister46, r_PtxRegister47,
		r_PtxRegister48;
	uint32_t r_PtxRegister49, r_PtxRegister50, r_PtxRegister51, r_PtxRegister52, r_PtxRegister53,
		r_PtxRegister54, r_PtxRegister55, r_PtxRegister56, r_PtxRegister57, r_PtxRegister58, r_PtxRegister59,
		r_PtxRegister60;
	uint32_t r_PtxRegister61, r_PtxRegister62, r_PtxRegister63, r_PtxRegister64, r_PtxRegister65,
		r_PtxRegister66, r_PtxRegister67, r_PtxRegister68, r_PtxRegister69, r_PtxRegister70, r_PtxRegister71,
		r_PtxRegister72;
	uint32_t r_PtxRegister73, r_PtxRegister74, r_PtxRegister75, r_PtxRegister76, r_PtxRegister77,
		r_PtxRegister78, r_PtxRegister79, r_PtxRegister80, r_PtxRegister81, r_PtxRegister82, r_PtxRegister83,
		r_PtxRegister84;
	uint32_t r_PtxRegister85, r_PtxRegister86, r_PtxRegister87, r_PtxRegister88, r_PtxRegister89,
		r_PtxRegister90, r_PtxRegister91, r_PtxRegister92, r_PtxRegister93, r_PtxRegister94, r_PtxRegister95,
		r_PtxRegister96;
	uint32_t r_PtxRegister97, r_PtxRegister98, r_PtxRegister99, r_PtxRegister100, r_PtxRegister101,
		r_PtxRegister102, r_PtxRegister103, r_PtxRegister104, r_PtxRegister105, r_PtxRegister106,
		r_Scalar32Bits, r_Scalar36Bits;
	uint32_t r_CtaX, r_CtaY, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113, r_PtxRegister114,
		r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118, r_PtxRegister119,
		r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_ThreadX,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_BlockSizeX, r_BlockSizeY;
	uint32_t r_LaneIndexAtPtx73, r_LaneIndexAtPtx81, r_LaneIndexAtPtx91, r_LaneIndexAtPtx100,
		r_LaneIndexAtPtx109, r_LaneIndexAtPtx118, r_LaneIndexAtPtx127, r_LaneIndexAtPtx136, r_PtxRegister141,
		r_PtxRegister142, r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PackedHalf2AtPtx218R162, r_LaneIndexAtPtx224, r_PtxRegister164, r_PackedE4WordAtPtx222R165,
		r_PtxRegister166, r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_PtxRegister177, r_PtxRegister178,
		r_PtxRegister179, r_PtxRegister180;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184,
		r_PackedHalf2AtPtx299R185, r_LaneIndexAtPtx305, r_PtxRegister187, r_PackedE4WordAtPtx303R188,
		r_PtxRegister189, r_PtxRegister190, r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_PtxRegister195, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_PtxRegister201, r_PtxRegister202,
		r_PackedHalf2AtPtx371R203, r_LaneIndexAtPtx377;
	uint32_t r_PtxRegister205, r_PackedE4WordAtPtx375R206, r_PtxRegister207, r_PtxRegister208,
		r_PtxRegister209, r_PtxRegister210, r_PtxRegister211, r_PtxRegister212, r_PtxRegister213,
		r_PtxRegister214, r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PackedHalf2AtPtx442R223, r_LaneIndexAtPtx448, r_PtxRegister225,
		r_PackedE4WordAtPtx446R226, r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_PtxRegister232, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PackedHalf2AtPtx514R243, r_LaneIndexAtPtx520,
		r_PtxRegister245, r_PackedE4WordAtPtx518R246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249,
		r_PtxRegister250, r_PtxRegister251, r_PtxRegister252;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PackedHalf2AtPtx585R263, r_LaneIndexAtPtx591;
	uint32_t r_PtxRegister265, r_PackedE4WordAtPtx589R266, r_PtxRegister267, r_PtxRegister268,
		r_PtxRegister269, r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273,
		r_PtxRegister274, r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PackedHalf2AtPtx657R280,
		r_LaneIndexAtPtx643, r_PtxRegister282, r_PtxRegister283, r_PtxRegister284, r_PtxRegister285,
		r_PtxRegister286, r_PackedHalf2AtPtx694R287, r_LaneIndexAtPtx680;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_PackedHalf2AtPtx736R294, r_LaneIndexAtPtx722, r_PtxRegister296, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
	uint32_t r_PackedHalf2AtPtx773R301, r_LaneIndexAtPtx759, r_PtxRegister303, r_PtxRegister304,
		r_PtxRegister305, r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309,
		r_PackedHalf2AtPtx826R310, r_LaneIndexAtPtx812, r_PtxRegister312;
	uint32_t r_PtxRegister313, r_PtxRegister314, r_PtxRegister315, r_PtxRegister316,
		r_PackedHalf2AtPtx863R317, r_LaneIndexAtPtx849, r_PtxRegister319, r_PtxRegister320, r_PtxRegister321,
		r_PtxRegister322, r_PtxRegister323, r_PackedHalf2AtPtx904R324;
	uint32_t r_LaneIndexAtPtx890, r_PtxRegister326, r_PtxRegister327, r_PtxRegister328, r_PtxRegister329,
		r_PtxRegister330, r_PackedHalf2AtPtx941R331, r_LaneIndexAtPtx927, r_PtxRegister333, r_PtxRegister334,
		r_PtxRegister335, r_PtxRegister336;
	uint32_t r_LaneIndexAtPtx1150, r_LaneIndexAtPtx1164, r_LaneIndexAtPtx1178, r_LaneIndexAtPtx1192,
		r_LaneIndexAtPtx1206, r_LaneIndexAtPtx1220, r_LaneIndexAtPtx1234, r_LaneIndexAtPtx1249,
		r_LaneIndexAtPtx1263, r_LaneIndexAtPtx1277, r_LaneIndexAtPtx1291, r_LaneIndexAtPtx1306;
	uint32_t r_LaneIndexAtPtx1320, r_LaneIndexAtPtx1335, r_LaneIndexAtPtx1349, r_LaneIndexAtPtx1364,
		r_LaneIndexAtPtx1378, r_LaneIndexAtPtx1392, r_LaneIndexAtPtx1406, r_LaneIndexAtPtx1420,
		r_LaneIndexAtPtx1434, r_LaneIndexAtPtx1448, r_LaneIndexAtPtx1462, r_LaneIndexAtPtx1476;
	uint32_t r_LaneIndexAtPtx1490, r_LaneIndexAtPtx1504, r_LaneIndexAtPtx1518, r_LaneIndexAtPtx1532,
		r_LaneIndexAtPtx1546, r_LaneIndexAtPtx1560, r_LaneIndexAtPtx1574, r_LaneIndexAtPtx1588,
		r_LaneIndexAtPtx1602, r_LaneIndexAtPtx1616, r_LaneIndexAtPtx1630, r_LaneIndexAtPtx1644;
	uint32_t r_LaneIndexAtPtx1658, r_LaneIndexAtPtx1672, r_LaneIndexAtPtx1686, r_LaneIndexAtPtx1700,
		r_LaneIndexAtPtx1714, r_LaneIndexAtPtx1728, r_LaneIndexAtPtx1742, r_LaneIndexAtPtx1756,
		r_LaneIndexAtPtx1770, r_LaneIndexAtPtx1784, r_LaneIndexAtPtx1798, r_LaneIndexAtPtx1812;
	uint32_t r_LaneIndexAtPtx1826, r_LaneIndexAtPtx1840, r_LaneIndexAtPtx1854, r_LaneIndexAtPtx1868,
		r_LaneIndexAtPtx1882, r_LaneIndexAtPtx1896, r_LaneIndexAtPtx1910, r_LaneIndexAtPtx1924,
		r_LaneIndexAtPtx1938, r_LaneIndexAtPtx1952, r_LaneIndexAtPtx1966, r_LaneIndexAtPtx1980;
	uint32_t r_LaneIndexAtPtx1994, r_LaneIndexAtPtx2008, r_LaneIndexAtPtx2022, r_LaneIndexAtPtx2036,
		r_LaneIndexAtPtx2050, r_PackedHalf2AtPtx951R402, r_PtxRegister403, r_LaneIndexAtPtx2057,
		r_PackedHalf2AtPtx957R405, r_PtxRegister406, r_LaneIndexAtPtx2064, r_PackedHalf2AtPtx954R408;
	uint32_t r_PtxRegister409, r_LaneIndexAtPtx2071, r_PackedHalf2AtPtx960R411, r_PtxRegister412,
		r_LaneIndexAtPtx2078, r_PackedHalf2AtPtx963R414, r_PtxRegister415, r_LaneIndexAtPtx2085,
		r_PackedHalf2AtPtx969R417, r_PtxRegister418, r_LaneIndexAtPtx2092, r_PackedHalf2AtPtx966R420;
	uint32_t r_PtxRegister421, r_LaneIndexAtPtx2099, r_PackedHalf2AtPtx972R423, r_PtxRegister424,
		r_LaneIndexAtPtx2106, r_PackedHalf2AtPtx975R426, r_PtxRegister427, r_LaneIndexAtPtx2113,
		r_PackedHalf2AtPtx981R429, r_PtxRegister430, r_LaneIndexAtPtx2120, r_PackedHalf2AtPtx978R432;
	uint32_t r_PtxRegister433, r_LaneIndexAtPtx2127, r_PackedHalf2AtPtx984R435, r_PtxRegister436,
		r_LaneIndexAtPtx2134, r_PackedHalf2AtPtx987R438, r_PtxRegister439, r_LaneIndexAtPtx2141,
		r_PackedHalf2AtPtx993R441, r_PtxRegister442, r_LaneIndexAtPtx2148, r_PackedHalf2AtPtx990R444;
	uint32_t r_PtxRegister445, r_LaneIndexAtPtx2155, r_PackedHalf2AtPtx996R447, r_PtxRegister448,
		r_LaneIndexAtPtx2162, r_PackedHalf2AtPtx999R450, r_PtxRegister451, r_LaneIndexAtPtx2169,
		r_PackedHalf2AtPtx1005R453, r_PtxRegister454, r_LaneIndexAtPtx2176, r_PackedHalf2AtPtx1002R456;
	uint32_t r_PtxRegister457, r_LaneIndexAtPtx2183, r_PackedHalf2AtPtx1008R459, r_PtxRegister460,
		r_LaneIndexAtPtx2190, r_PackedHalf2AtPtx1011R462, r_PtxRegister463, r_LaneIndexAtPtx2197,
		r_PackedHalf2AtPtx1017R465, r_PtxRegister466, r_LaneIndexAtPtx2204, r_PackedHalf2AtPtx1014R468;
	uint32_t r_PtxRegister469, r_LaneIndexAtPtx2211, r_PackedHalf2AtPtx1020R471, r_PtxRegister472,
		r_LaneIndexAtPtx2218, r_PackedHalf2AtPtx1023R474, r_PtxRegister475, r_LaneIndexAtPtx2225,
		r_PackedHalf2AtPtx1029R477, r_PtxRegister478, r_LaneIndexAtPtx2232, r_PackedHalf2AtPtx1026R480;
	uint32_t r_PtxRegister481, r_LaneIndexAtPtx2239, r_PackedHalf2AtPtx1032R483, r_PtxRegister484,
		r_LaneIndexAtPtx2246, r_PackedHalf2AtPtx1035R486, r_PtxRegister487, r_LaneIndexAtPtx2253,
		r_PackedHalf2AtPtx1041R489, r_PtxRegister490, r_LaneIndexAtPtx2260, r_PackedHalf2AtPtx1038R492;
	uint32_t r_PtxRegister493, r_LaneIndexAtPtx2267, r_PackedHalf2AtPtx1044R495, r_PtxRegister496,
		r_LaneIndexAtPtx2274, r_PackedHalf2AtPtx1047R498, r_PtxRegister499, r_LaneIndexAtPtx2281,
		r_PackedHalf2AtPtx1053R501, r_PtxRegister502, r_LaneIndexAtPtx2288, r_PackedHalf2AtPtx1050R504;
	uint32_t r_PtxRegister505, r_LaneIndexAtPtx2295, r_PackedHalf2AtPtx1056R507, r_PtxRegister508,
		r_LaneIndexAtPtx2302, r_PackedHalf2AtPtx1059R510, r_PtxRegister511, r_LaneIndexAtPtx2309,
		r_PackedHalf2AtPtx1065R513, r_PtxRegister514, r_LaneIndexAtPtx2316, r_PackedHalf2AtPtx1062R516;
	uint32_t r_PtxRegister517, r_LaneIndexAtPtx2323, r_PackedHalf2AtPtx1068R519, r_PtxRegister520,
		r_LaneIndexAtPtx2330, r_PackedHalf2AtPtx1071R522, r_PtxRegister523, r_LaneIndexAtPtx2337,
		r_PackedHalf2AtPtx1077R525, r_PtxRegister526, r_LaneIndexAtPtx2344, r_PackedHalf2AtPtx1074R528;
	uint32_t r_PtxRegister529, r_LaneIndexAtPtx2351, r_PackedHalf2AtPtx1080R531, r_PtxRegister532,
		r_LaneIndexAtPtx2358, r_PackedHalf2AtPtx1083R534, r_PtxRegister535, r_LaneIndexAtPtx2365,
		r_PackedHalf2AtPtx1089R537, r_PtxRegister538, r_LaneIndexAtPtx2372, r_PackedHalf2AtPtx1086R540;
	uint32_t r_PtxRegister541, r_LaneIndexAtPtx2379, r_PackedHalf2AtPtx1092R543, r_PtxRegister544,
		r_LaneIndexAtPtx2386, r_PackedHalf2AtPtx1095R546, r_PtxRegister547, r_LaneIndexAtPtx2393,
		r_PackedHalf2AtPtx1101R549, r_PtxRegister550, r_LaneIndexAtPtx2400, r_PackedHalf2AtPtx1098R552;
	uint32_t r_PtxRegister553, r_LaneIndexAtPtx2407, r_PackedHalf2AtPtx1104R555, r_PtxRegister556,
		r_LaneIndexAtPtx2414, r_PackedHalf2AtPtx1107R558, r_PtxRegister559, r_LaneIndexAtPtx2421,
		r_PackedHalf2AtPtx1113R561, r_PtxRegister562, r_LaneIndexAtPtx2428, r_PackedHalf2AtPtx1110R564;
	uint32_t r_PtxRegister565, r_LaneIndexAtPtx2435, r_PackedHalf2AtPtx1116R567, r_PtxRegister568,
		r_LaneIndexAtPtx2442, r_PackedHalf2AtPtx1120R570, r_PtxRegister571, r_LaneIndexAtPtx2449,
		r_PackedHalf2AtPtx1127R573, r_PtxRegister574, r_LaneIndexAtPtx2456, r_PackedHalf2AtPtx1123R576;
	uint32_t r_PtxRegister577, r_LaneIndexAtPtx2463, r_PackedHalf2AtPtx1130R579, r_PtxRegister580,
		r_LaneIndexAtPtx2470, r_PackedHalf2AtPtx1134R582, r_PtxRegister583, r_LaneIndexAtPtx2477,
		r_PackedHalf2AtPtx1141R585, r_PtxRegister586, r_LaneIndexAtPtx2484, r_PackedHalf2AtPtx1137R588;
	uint32_t r_PtxRegister589, r_LaneIndexAtPtx2491, r_PackedHalf2AtPtx1144R591, r_PtxRegister592,
		r_PtxRegister593, r_PtxRegister594, r_PtxRegister595, r_PtxRegister596, r_PtxRegister597,
		r_PtxRegister598, r_PtxRegister599, r_PtxRegister600;
	uint32_t r_PtxRegister601, r_PtxRegister602, r_PtxRegister603, r_PtxRegister604, r_PtxRegister605,
		r_PtxRegister606, r_PtxRegister607, r_PtxRegister608, r_PtxRegister609, r_PtxRegister610,
		r_PtxRegister611, r_PtxRegister612;
	uint32_t r_PtxRegister613, r_PtxRegister614, r_PtxRegister615, r_PtxRegister616, r_PtxRegister617,
		r_PtxRegister618, r_PtxRegister619, r_PtxRegister620, r_PtxRegister621, r_PtxRegister622,
		r_PtxRegister623, r_PtxRegister624;
	uint32_t r_PtxRegister625, r_PtxRegister626, r_PtxRegister627, r_PtxRegister628, r_PtxRegister629,
		r_PtxRegister630, r_PtxRegister631, r_PtxRegister632, r_PtxRegister633, r_PtxRegister634,
		r_PtxRegister635, r_PtxRegister636;
	uint32_t r_PtxRegister637, r_PtxRegister638, r_PtxRegister639, r_PtxRegister640, r_PtxRegister641,
		r_PtxRegister642, r_PtxRegister643, r_PtxRegister644, r_PtxRegister645, r_PtxRegister646,
		r_PtxRegister647, r_PtxRegister648;
	uint32_t r_PtxRegister649, r_PtxRegister650, r_PtxRegister651, r_PtxRegister652, r_PtxRegister653,
		r_PtxRegister654, r_PtxRegister655, r_PtxRegister656, r_PtxRegister657, r_PtxRegister658,
		r_PtxRegister659, r_PtxRegister660;
	uint32_t r_PtxRegister661, r_PtxRegister662, r_PtxRegister663, r_PtxRegister664, r_PtxRegister665,
		r_PtxRegister666, r_PtxRegister667, r_PtxRegister668, r_PtxRegister669, r_PtxRegister670,
		r_PtxRegister671, r_PtxRegister672;
	uint32_t r_PtxRegister673, r_PtxRegister674, r_PtxRegister675, r_PtxRegister676, r_PtxRegister677,
		r_PtxRegister678, r_PtxRegister679, r_PtxRegister680, r_PtxRegister681, r_PtxRegister682,
		r_PtxRegister683, r_PtxRegister684;
	uint32_t r_PtxRegister685, r_PtxRegister686, r_PtxRegister687, r_PtxRegister688, r_PtxRegister689,
		r_PtxRegister690, r_PtxRegister691, r_PtxRegister692, r_PtxRegister693, r_PtxRegister694,
		r_PtxRegister695, r_PtxRegister696;
	uint32_t r_PtxRegister697, r_PtxRegister698, r_PtxRegister699, r_PtxRegister700, r_PtxRegister701,
		r_PtxRegister702, r_PtxRegister703, r_PtxRegister704, r_PtxRegister705, r_PtxRegister706,
		r_PtxRegister707, r_PtxRegister708;
	uint32_t r_PtxRegister709, r_PtxRegister710, r_PtxRegister711, r_PtxRegister712, r_PtxRegister713,
		r_PtxRegister714, r_PtxRegister715, r_PtxRegister716, r_PtxRegister717, r_PtxRegister718,
		r_PtxRegister719, r_PtxRegister720;
	uint32_t r_PtxRegister721, r_PtxRegister722, r_PtxRegister723, r_PtxRegister724, r_PtxRegister725,
		r_PtxRegister726, r_PtxRegister727, r_PtxRegister728, r_PtxRegister729, r_PtxRegister730,
		r_PtxRegister731, r_PtxRegister732;
	uint32_t r_PtxRegister733, r_PtxRegister734, r_PtxRegister735, r_PtxRegister736, r_PtxRegister737,
		r_PtxRegister738, r_PtxRegister739, r_PtxRegister740, r_PtxRegister741, r_PtxRegister742,
		r_PtxRegister743, r_PtxRegister744;
	uint32_t r_PtxRegister745, r_PtxRegister746, r_PtxRegister747, r_PtxRegister748, r_PtxRegister749,
		r_PtxRegister750, r_PtxRegister751, r_PtxRegister752, r_PtxRegister753, r_PtxRegister754,
		r_PtxRegister755, r_PtxRegister756;
	uint32_t r_PtxRegister757, r_PtxRegister758, r_PtxRegister759, r_PtxRegister760, r_PtxRegister761,
		r_PtxRegister762, r_PtxRegister763, r_PtxRegister764, r_PtxRegister765, r_PtxRegister766,
		r_PtxRegister767, r_PtxRegister768;
	uint32_t r_PtxRegister769, r_PtxRegister770, r_PtxRegister771, r_PtxRegister772, r_PtxRegister773,
		r_PtxRegister774, r_PtxRegister775, r_PtxRegister776, r_PtxRegister777, r_PtxRegister778,
		r_PtxRegister779, r_PtxRegister780;
	uint32_t r_PtxRegister781, r_PtxRegister782, r_PtxRegister783, r_PtxRegister784, r_PtxRegister785,
		r_PtxRegister786, r_PtxRegister787, r_PtxRegister788, r_PtxRegister789, r_PtxRegister790,
		r_PtxRegister791, r_PtxRegister792;
	uint32_t r_PtxRegister793, r_PtxRegister794, r_PtxRegister795, r_PtxRegister796, r_PtxRegister797,
		r_PtxRegister798, r_PtxRegister799, r_PtxRegister800, r_PtxRegister801, r_PtxRegister802,
		r_PtxRegister803, r_PtxRegister804;
	uint32_t r_PtxRegister805, r_PtxRegister806, r_PtxRegister807, r_PtxRegister808, r_PtxRegister809,
		r_PtxRegister810, r_PtxRegister811, r_PtxRegister812, r_PtxRegister813, r_PtxRegister814,
		r_PtxRegister815, r_PtxRegister816;
	uint32_t r_PtxRegister817, r_PtxRegister818, r_PtxRegister819, r_PtxRegister820, r_PtxRegister821,
		r_PtxRegister822, r_PtxRegister823, r_PtxRegister824, r_PtxRegister825, r_PtxRegister826,
		r_PtxRegister827, r_PtxRegister828;
	uint32_t r_PtxRegister829, r_PtxRegister830, r_PtxRegister831, r_PtxRegister832, r_PtxRegister833,
		r_PtxRegister834, r_PtxRegister835, r_PtxRegister836, r_PtxRegister837, r_PtxRegister838,
		r_PtxRegister839, r_PtxRegister840;
	uint32_t r_PtxRegister841, r_PtxRegister842, r_PtxRegister843, r_PtxRegister844, r_PtxRegister845,
		r_PtxRegister846, r_PtxRegister847, r_PtxRegister848, r_PtxRegister849, r_PtxRegister850,
		r_PtxRegister851, r_PtxRegister852;
	uint32_t r_PtxRegister853, r_PtxRegister854, r_PtxRegister855, r_PtxRegister856, r_PtxRegister857,
		r_PtxRegister858, r_PtxRegister859, r_PtxRegister860, r_PtxRegister861, r_PtxRegister862,
		r_PtxRegister863, r_PtxRegister864;
	uint32_t r_PtxRegister865, r_PtxRegister866, r_PtxRegister867, r_PtxRegister868, r_PtxRegister869,
		r_PtxRegister870, r_PtxRegister871, r_PtxRegister872, r_PtxRegister873, r_PtxRegister874,
		r_PtxRegister875, r_PtxRegister876;
	uint32_t r_PtxRegister877, r_PtxRegister878, r_PtxRegister879, r_PtxRegister880, r_PtxRegister881,
		r_PtxRegister882, r_PtxRegister883, r_PtxRegister884, r_PtxRegister885, r_PtxRegister886,
		r_PtxRegister887, r_PtxRegister888;
	uint32_t r_PtxRegister889, r_PtxRegister890, r_PtxRegister891, r_PtxRegister892, r_PtxRegister893,
		r_PtxRegister894, r_PtxRegister895, r_PtxRegister896, r_PtxRegister897, r_PtxRegister898,
		r_PtxRegister899, r_PtxRegister900;
	uint32_t r_PtxRegister901, r_PtxRegister902, r_PtxRegister903, r_PtxRegister904, r_PtxRegister905,
		r_PtxRegister906, r_PtxRegister907, r_PtxRegister908, r_PtxRegister909, r_PtxRegister910,
		r_PtxRegister911, r_PtxRegister912;
	uint32_t r_PtxRegister913, r_PtxRegister914, r_PtxRegister915, r_PtxRegister916, r_PtxRegister917,
		r_PtxRegister918, r_PtxRegister919, r_PtxRegister920, r_PtxRegister921, r_PtxRegister922,
		r_PtxRegister923, r_PtxRegister924;
	uint32_t r_PtxRegister925, r_PtxRegister926, r_PtxRegister927, r_PtxRegister928, r_PtxRegister929,
		r_PtxRegister930, r_PtxRegister931, r_PtxRegister932, r_PtxRegister933, r_PtxRegister934,
		r_PtxRegister935, r_PtxRegister936;
	uint32_t r_PtxRegister937, r_PtxRegister938, r_PtxRegister939, r_PtxRegister940, r_PtxRegister941,
		r_PtxRegister942, r_PtxRegister943, r_PtxRegister944, r_PtxRegister945, r_PtxRegister946,
		r_PtxRegister947, r_PtxRegister948;
	uint32_t r_PtxRegister949, r_PtxRegister950, r_PtxRegister951, r_PtxRegister952, r_PtxRegister953,
		r_PtxRegister954, r_PtxRegister955, r_PtxRegister956, r_PtxRegister957, r_PtxRegister958,
		r_PtxRegister959, r_PtxRegister960;
	uint32_t r_PtxRegister961, r_PtxRegister962, r_PtxRegister963, r_PtxRegister964, r_PtxRegister965,
		r_PtxRegister966, r_PtxRegister967, r_PtxRegister968, r_PtxRegister969, r_PtxRegister970,
		r_PtxRegister971, r_PtxRegister972;
	uint32_t r_PtxRegister973, r_PtxRegister974, r_PtxRegister975, r_PtxRegister976, r_PtxRegister977,
		r_PtxRegister978, r_PtxRegister979, r_PtxRegister980, r_PtxRegister981, r_PtxRegister982,
		r_PtxRegister983, r_PtxRegister984;
	uint32_t r_PtxRegister985, r_PtxRegister986, r_PtxRegister987, r_PtxRegister988, r_PtxRegister989,
		r_PtxRegister990, r_PtxRegister991, r_PtxRegister992, r_PtxRegister993, r_PtxRegister994,
		r_PtxRegister995, r_PtxRegister996;
	uint32_t r_PtxRegister997, r_PtxRegister998, r_PtxRegister999, r_PtxRegister1000, r_PtxRegister1001,
		r_PtxRegister1002, r_PtxRegister1003, r_PtxRegister1004, r_PtxRegister1005, r_PtxRegister1006,
		r_PtxRegister1007, r_PtxRegister1008;
	uint32_t r_PtxRegister1009, r_PtxRegister1010, r_PtxRegister1011, r_PtxRegister1012, r_PtxRegister1013,
		r_PtxRegister1014, r_PtxRegister1015, r_PtxRegister1016, r_PtxRegister1017, r_PtxRegister1018,
		r_PtxRegister1019, r_PtxRegister1020;
	uint32_t r_PtxRegister1021, r_PtxRegister1022, r_PtxRegister1023, r_PtxRegister1024, r_PtxRegister1025,
		r_PtxRegister1026, r_PtxRegister1027, r_PtxRegister1028, r_PtxRegister1029, r_PtxRegister1030,
		r_PtxRegister1031, r_PtxRegister1032;
	uint32_t r_PtxRegister1033, r_PtxRegister1034, r_PtxRegister1035, r_PtxRegister1036, r_PtxRegister1037,
		r_PtxRegister1038, r_PtxRegister1039, r_PtxRegister1040, r_PtxRegister1041, r_PtxRegister1042,
		r_PtxRegister1043, r_PtxRegister1044;
	uint32_t r_PtxRegister1045, r_PtxRegister1046, r_PtxRegister1047, r_PtxRegister1048, r_PtxRegister1049,
		r_PtxRegister1050, r_PtxRegister1051, r_PtxRegister1052, r_PtxRegister1053, r_PtxRegister1054,
		r_PtxRegister1055, r_PtxRegister1056;
	uint32_t r_PtxRegister1057, r_PtxRegister1058, r_PtxRegister1059, r_PtxRegister1060, r_PtxRegister1061,
		r_PtxRegister1062, r_PtxRegister1063, r_PtxRegister1064, r_PtxRegister1065, r_PtxRegister1066,
		r_PtxRegister1067, r_PtxRegister1068;
	uint32_t r_PtxRegister1069, r_PtxRegister1070, r_PtxRegister1071, r_PtxRegister1072, r_PtxRegister1073,
		r_PtxRegister1074, r_PtxRegister1075, r_PtxRegister1076, r_PtxRegister1077, r_PtxRegister1078,
		r_PtxRegister1079, r_PtxRegister1080;
	uint32_t r_PtxRegister1081, r_PtxRegister1082, r_PtxRegister1083, r_PtxRegister1084, r_PtxRegister1085,
		r_PtxRegister1086, r_PtxRegister1087, r_PtxRegister1088, r_PtxRegister1089, r_PtxRegister1090,
		r_PtxRegister1091, r_PtxRegister1092;
	uint32_t r_PtxRegister1093, r_PtxRegister1094, r_PtxRegister1095, r_PtxRegister1096, r_PtxRegister1097,
		r_PtxRegister1098, r_PtxRegister1099, r_PtxRegister1100, r_PtxRegister1101, r_PtxRegister1102,
		r_PtxRegister1103, r_PtxRegister1104;
	uint32_t r_PtxRegister1105, r_PtxRegister1106, r_PtxRegister1107, r_PtxRegister1108, r_PtxRegister1109,
		r_PtxRegister1110, r_LaneIndexAtPtx2510, r_PtxRegister1112, r_LaneIndexAtPtx2520, r_PtxRegister1114,
		r_LaneIndexAtPtx2529, r_PtxRegister1116;
	uint32_t r_LaneIndexAtPtx2538, r_PtxRegister1118, r_LaneIndexAtPtx2547, r_PtxRegister1120,
		r_LaneIndexAtPtx2556, r_PtxRegister1122, r_LaneIndexAtPtx2565, r_PtxRegister1124,
		r_LaneIndexAtPtx2574, r_PtxRegister1126, r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128;
	uint32_t r_MmaAE4x4WordAtPtx2517R1129, r_MmaAE4x4WordAtPtx2517R1130, r_MmaAE4x4WordAtPtx2526R1131,
		r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		r_MmaAccumulatorHalf2WordAtPtx2583R1135, r_MmaAccumulatorHalf2WordAtPtx2583R1136,
		r_MmaAccumulatorHalf2WordAtPtx2590R1137, r_MmaAccumulatorHalf2WordAtPtx2590R1138,
		r_MmaAccumulatorHalf2WordAtPtx2611R1139, r_MmaAccumulatorHalf2WordAtPtx2611R1140;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2618R1141, r_MmaAccumulatorHalf2WordAtPtx2618R1142,
		r_MmaAccumulatorHalf2WordAtPtx2639R1143, r_MmaAccumulatorHalf2WordAtPtx2639R1144,
		r_MmaAccumulatorHalf2WordAtPtx2646R1145, r_MmaAccumulatorHalf2WordAtPtx2646R1146,
		r_MmaAccumulatorHalf2WordAtPtx2667R1147, r_MmaAccumulatorHalf2WordAtPtx2667R1148,
		r_MmaAccumulatorHalf2WordAtPtx2674R1149, r_MmaAccumulatorHalf2WordAtPtx2674R1150,
		r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152;
	uint32_t r_MmaAE4x4WordAtPtx2535R1153, r_MmaAE4x4WordAtPtx2535R1154, r_MmaAE4x4WordAtPtx2544R1155,
		r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		r_MmaAccumulatorHalf2WordAtPtx2695R1159, r_MmaAccumulatorHalf2WordAtPtx2695R1160,
		r_MmaAccumulatorHalf2WordAtPtx2702R1161, r_MmaAccumulatorHalf2WordAtPtx2702R1162,
		r_MmaAccumulatorHalf2WordAtPtx2723R1163, r_MmaAccumulatorHalf2WordAtPtx2723R1164;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2730R1165, r_MmaAccumulatorHalf2WordAtPtx2730R1166,
		r_MmaAccumulatorHalf2WordAtPtx2751R1167, r_MmaAccumulatorHalf2WordAtPtx2751R1168,
		r_MmaAccumulatorHalf2WordAtPtx2758R1169, r_MmaAccumulatorHalf2WordAtPtx2758R1170,
		r_MmaAccumulatorHalf2WordAtPtx2779R1171, r_MmaAccumulatorHalf2WordAtPtx2779R1172,
		r_MmaAccumulatorHalf2WordAtPtx2786R1173, r_MmaAccumulatorHalf2WordAtPtx2786R1174,
		r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176;
	uint32_t r_MmaAE4x4WordAtPtx2553R1177, r_MmaAE4x4WordAtPtx2553R1178, r_MmaAE4x4WordAtPtx2562R1179,
		r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		r_MmaAccumulatorHalf2WordAtPtx2807R1183, r_MmaAccumulatorHalf2WordAtPtx2807R1184,
		r_MmaAccumulatorHalf2WordAtPtx2814R1185, r_MmaAccumulatorHalf2WordAtPtx2814R1186,
		r_MmaAccumulatorHalf2WordAtPtx2835R1187, r_MmaAccumulatorHalf2WordAtPtx2835R1188;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2842R1189, r_MmaAccumulatorHalf2WordAtPtx2842R1190,
		r_MmaAccumulatorHalf2WordAtPtx2863R1191, r_MmaAccumulatorHalf2WordAtPtx2863R1192,
		r_MmaAccumulatorHalf2WordAtPtx2870R1193, r_MmaAccumulatorHalf2WordAtPtx2870R1194,
		r_MmaAccumulatorHalf2WordAtPtx2891R1195, r_MmaAccumulatorHalf2WordAtPtx2891R1196,
		r_MmaAccumulatorHalf2WordAtPtx2898R1197, r_MmaAccumulatorHalf2WordAtPtx2898R1198,
		r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200;
	uint32_t r_MmaAE4x4WordAtPtx2571R1201, r_MmaAE4x4WordAtPtx2571R1202, r_MmaAE4x4WordAtPtx2580R1203,
		r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		r_MmaAccumulatorHalf2WordAtPtx2919R1207, r_MmaAccumulatorHalf2WordAtPtx2919R1208,
		r_MmaAccumulatorHalf2WordAtPtx2926R1209, r_MmaAccumulatorHalf2WordAtPtx2926R1210,
		r_MmaAccumulatorHalf2WordAtPtx2947R1211, r_MmaAccumulatorHalf2WordAtPtx2947R1212;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2954R1213, r_MmaAccumulatorHalf2WordAtPtx2954R1214,
		r_MmaAccumulatorHalf2WordAtPtx2975R1215, r_MmaAccumulatorHalf2WordAtPtx2975R1216,
		r_MmaAccumulatorHalf2WordAtPtx2982R1217, r_MmaAccumulatorHalf2WordAtPtx2982R1218,
		r_MmaAccumulatorHalf2WordAtPtx3003R1219, r_MmaAccumulatorHalf2WordAtPtx3003R1220,
		r_MmaAccumulatorHalf2WordAtPtx3010R1221, r_MmaAccumulatorHalf2WordAtPtx3010R1222, r_PtxRegister1223,
		r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_PtxRegister1231, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_PtxRegister1240, r_PtxRegister1241,
		r_LaneIndexAtPtx3042, r_LaneIndexAtPtx3050, r_LaneIndexAtPtx3059, r_LaneIndexAtPtx3068,
		r_LaneIndexAtPtx3077, r_LaneIndexAtPtx3086, r_LaneIndexAtPtx3095;
	uint32_t r_LaneIndexAtPtx3104, r_PtxRegister1250, r_PtxRegister1251, r_PtxRegister1252, r_PtxRegister1253,
		r_PtxRegister1254, r_PtxRegister1255, r_PtxRegister1256, r_PtxRegister1257, r_PtxRegister1258,
		r_PtxRegister1259, r_PtxRegister1260;
	uint32_t r_PtxRegister1261, r_PtxRegister1262, r_PtxRegister1263, r_PtxRegister1264, r_PtxRegister1265,
		r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269, r_PtxRegister1270,
		r_PtxRegister1271, r_PtxRegister1272;
	uint32_t r_PtxRegister1273, r_PtxRegister1274, r_PtxRegister1275, r_PackedHalf2AtPtx3201R1276,
		r_LaneIndexAtPtx3207, r_PtxRegister1278, r_PackedE4WordAtPtx3205R1279, r_PtxRegister1280,
		r_PtxRegister1281, r_PtxRegister1282, r_PtxRegister1283, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_PtxRegister1286, r_PtxRegister1287, r_PtxRegister1288, r_PtxRegister1289,
		r_PtxRegister1290, r_PtxRegister1291, r_PtxRegister1292, r_PtxRegister1293, r_PtxRegister1294,
		r_CtaZAtPtx3238, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_PtxRegister1298, r_PtxRegister1299, r_PtxRegister1300, r_PtxRegister1301,
		r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PackedHalf2AtPtx3288R1305,
		r_LaneIndexAtPtx3294, r_PtxRegister1307, r_PackedE4WordAtPtx3292R1308;
	uint32_t r_PtxRegister1309, r_PtxRegister1310, r_PtxRegister1311, r_PtxRegister1312, r_PtxRegister1313,
		r_PtxRegister1314, r_PtxRegister1315, r_PtxRegister1316, r_PtxRegister1317, r_PtxRegister1318,
		r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_LaneIndexAtPtx3510,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_PtxRegister1333, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_LaneIndexAtPtx3546, r_PtxRegister1351, r_PtxRegister1352, r_PtxRegister1353, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_LaneIndexAtPtx3581, r_PtxRegister1370, r_PtxRegister1371, r_PtxRegister1372, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_LaneIndexAtPtx3616, r_PtxRegister1388, r_PtxRegister1389, r_PtxRegister1390,
		r_PtxRegister1391, r_PtxRegister1392;
	uint32_t r_PtxRegister1393, r_PtxRegister1394, r_PtxRegister1395, r_PtxRegister1396, r_PtxRegister1397,
		r_PtxRegister1398, r_PtxRegister1399, r_PtxRegister1400, r_PtxRegister1401, r_PtxRegister1402,
		r_PtxRegister1403, r_PtxRegister1404;
	uint32_t r_PtxRegister1405, r_LaneIndexAtPtx3651, r_PtxRegister1407, r_PtxRegister1408, r_PtxRegister1409,
		r_PtxRegister1410, r_PtxRegister1411, r_PtxRegister1412, r_PtxRegister1413, r_PtxRegister1414,
		r_PtxRegister1415, r_PtxRegister1416;
	uint32_t r_PtxRegister1417, r_PtxRegister1418, r_PtxRegister1419, r_PtxRegister1420, r_PtxRegister1421,
		r_PtxRegister1422, r_PtxRegister1423, r_LaneIndexAtPtx3686, r_PtxRegister1425, r_PtxRegister1426,
		r_PtxRegister1427, r_PtxRegister1428;
	uint32_t r_PtxRegister1429, r_PtxRegister1430, r_PtxRegister1431, r_PtxRegister1432, r_PtxRegister1433,
		r_PtxRegister1434, r_PtxRegister1435, r_PtxRegister1436, r_PtxRegister1437, r_PtxRegister1438,
		r_PtxRegister1439, r_PtxRegister1440;
	uint32_t r_PtxRegister1441, r_PtxRegister1442, r_LaneIndexAtPtx3721, r_PtxRegister1444, r_PtxRegister1445,
		r_PtxRegister1446, r_PtxRegister1447, r_PtxRegister1448, r_PtxRegister1449, r_PtxRegister1450,
		r_PtxRegister1451, r_PtxRegister1452;
	uint32_t r_PtxRegister1453, r_PtxRegister1454, r_PtxRegister1455, r_PtxRegister1456, r_PtxRegister1457,
		r_PtxRegister1458, r_PtxRegister1459, r_PtxRegister1460, r_LaneIndexAtPtx3756, r_PtxRegister1462,
		r_PtxRegister1463, r_PtxRegister1464;
	uint32_t r_PtxRegister1465, r_PtxRegister1466, r_PtxRegister1467, r_PtxRegister1468, r_PtxRegister1469,
		r_PtxRegister1470, r_PtxRegister1471, r_PtxRegister1472, r_PtxRegister1473, r_PtxRegister1474,
		r_PtxRegister1475, r_PtxRegister1476;
	uint32_t r_PtxRegister1477, r_PtxRegister1478, r_PtxRegister1479, r_LaneIndexAtPtx3791, r_PtxRegister1481,
		r_PtxRegister1482, r_PtxRegister1483, r_PtxRegister1484, r_PtxRegister1485, r_PtxRegister1486,
		r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_PtxRegister1489, r_PtxRegister1490, r_PtxRegister1491, r_PtxRegister1492, r_PtxRegister1493,
		r_PtxRegister1494, r_PtxRegister1495, r_PtxRegister1496, r_PtxRegister1497, r_PtxRegister1498,
		r_LaneIndexAtPtx3824, r_PtxRegister1500;
	uint32_t r_PtxRegister1501, r_PtxRegister1502, r_PtxRegister1503, r_PtxRegister1504, r_PtxRegister1505,
		r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508, r_PtxRegister1509, r_PtxRegister1510,
		r_PtxRegister1511, r_PtxRegister1512;
	uint32_t r_PtxRegister1513, r_PtxRegister1514, r_PtxRegister1515, r_PtxRegister1516, r_PtxRegister1517,
		r_PtxRegister1518, r_LaneIndexAtPtx3858, r_PtxRegister1520, r_PtxRegister1521, r_PtxRegister1522,
		r_PtxRegister1523, r_PtxRegister1524;
	uint32_t r_PtxRegister1525, r_PtxRegister1526, r_PtxRegister1527, r_PtxRegister1528, r_PtxRegister1529,
		r_PtxRegister1530, r_PtxRegister1531, r_PtxRegister1532, r_PtxRegister1533, r_PtxRegister1534,
		r_PtxRegister1535, r_PtxRegister1536;
	uint32_t r_PtxRegister1537, r_LaneIndexAtPtx3891, r_PtxRegister1539, r_PtxRegister1540, r_PtxRegister1541,
		r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_PtxRegister1545, r_PtxRegister1546,
		r_PtxRegister1547, r_PtxRegister1548;
	uint32_t r_PtxRegister1549, r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552, r_PtxRegister1553,
		r_PtxRegister1554, r_PtxRegister1555, r_PtxRegister1556, r_PtxRegister1557, r_LaneIndexAtPtx3925,
		r_PtxRegister1559, r_PtxRegister1560;
	uint32_t r_PtxRegister1561, r_PtxRegister1562, r_PtxRegister1563, r_PtxRegister1564, r_PtxRegister1565,
		r_PtxRegister1566, r_PtxRegister1567, r_PtxRegister1568, r_PtxRegister1569, r_PtxRegister1570,
		r_PtxRegister1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_PtxRegister1574, r_PtxRegister1575, r_PtxRegister1576, r_LaneIndexAtPtx3958,
		r_PtxRegister1578, r_PtxRegister1579, r_PtxRegister1580, r_PtxRegister1581, r_PtxRegister1582,
		r_PtxRegister1583, r_PtxRegister1584;
	uint32_t r_PtxRegister1585, r_PtxRegister1586, r_PtxRegister1587, r_PtxRegister1588, r_PtxRegister1589,
		r_PtxRegister1590, r_PtxRegister1591, r_PtxRegister1592, r_PtxRegister1593, r_PtxRegister1594,
		r_PtxRegister1595, r_PtxRegister1596;
	uint32_t r_LaneIndexAtPtx3992, r_PtxRegister1598, r_PtxRegister1599, r_PtxRegister1600, r_PtxRegister1601,
		r_PtxRegister1602, r_PtxRegister1603, r_PtxRegister1604, r_PtxRegister1605, r_PtxRegister1606,
		r_PtxRegister1607, r_PtxRegister1608;
	uint32_t r_PtxRegister1609, r_PtxRegister1610, r_PtxRegister1611, r_PtxRegister1612, r_PtxRegister1613,
		r_PtxRegister1614, r_PtxRegister1615, r_LaneIndexAtPtx4025, r_PtxRegister1617, r_PtxRegister1618,
		r_PtxRegister1619, r_PtxRegister1620;
	uint32_t r_PtxRegister1621, r_PtxRegister1622, r_PtxRegister1623, r_PtxRegister1624, r_PtxRegister1625,
		r_PtxRegister1626, r_PtxRegister1627, r_PtxRegister1628, r_PtxRegister1629, r_PtxRegister1630,
		r_PtxRegister1631, r_PtxRegister1632;
	uint32_t r_PtxRegister1633, r_PtxRegister1634, r_PtxRegister1635, r_LaneIndexAtPtx4059, r_PtxRegister1637,
		r_PtxRegister1638, r_PtxRegister1639, r_PtxRegister1640, r_PtxRegister1641, r_PtxRegister1642,
		r_PtxRegister1643, r_PtxRegister1644;
	uint32_t r_PtxRegister1645, r_PtxRegister1646, r_PtxRegister1647, r_PtxRegister1648, r_PtxRegister1649,
		r_PtxRegister1650, r_PtxRegister1651, r_PtxRegister1652, r_PtxRegister1653, r_PtxRegister1654,
		r_LaneIndexAtPtx4094, r_PtxRegister1656;
	uint32_t r_PtxRegister1657, r_PtxRegister1658, r_PtxRegister1659, r_PtxRegister1660, r_PtxRegister1661,
		r_PtxRegister1662, r_PtxRegister1663, r_PtxRegister1664, r_PtxRegister1665, r_PtxRegister1666,
		r_PtxRegister1667, r_PtxRegister1668;
	uint32_t r_PtxRegister1669, r_PtxRegister1670, r_PtxRegister1671, r_PtxRegister1672, r_PtxRegister1673,
		r_LaneIndexAtPtx4129, r_PtxRegister1675, r_PtxRegister1676, r_PtxRegister1677, r_PtxRegister1678,
		r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PtxRegister1688, r_PtxRegister1689, r_PtxRegister1690,
		r_PtxRegister1691, r_PtxRegister1692;
	uint32_t r_LaneIndexAtPtx4164, r_PtxRegister1694, r_PtxRegister1695, r_PtxRegister1696, r_PtxRegister1697,
		r_PtxRegister1698, r_PtxRegister1699, r_PtxRegister1700, r_PtxRegister1701, r_PtxRegister1702,
		r_PtxRegister1703, r_PtxRegister1704;
	uint32_t r_PtxRegister1705, r_PtxRegister1706, r_PtxRegister1707, r_PtxRegister1708, r_PtxRegister1709,
		r_PtxRegister1710, r_PtxRegister1711, r_LaneIndexAtPtx4199, r_PtxRegister1713, r_PtxRegister1714,
		r_PtxRegister1715, r_PtxRegister1716;
	uint32_t r_PtxRegister1717, r_PtxRegister1718, r_PtxRegister1719, r_PtxRegister1720, r_PtxRegister1721,
		r_PtxRegister1722, r_PtxRegister1723, r_PtxRegister1724, r_PtxRegister1725, r_PtxRegister1726,
		r_PtxRegister1727, r_PtxRegister1728;
	uint32_t r_PtxRegister1729, r_PtxRegister1730, r_LaneIndexAtPtx4234, r_PtxRegister1732, r_PtxRegister1733,
		r_PtxRegister1734, r_PtxRegister1735, r_PtxRegister1736, r_PtxRegister1737, r_PtxRegister1738,
		r_PtxRegister1739, r_PtxRegister1740;
	uint32_t r_PtxRegister1741, r_PtxRegister1742, r_PtxRegister1743, r_PtxRegister1744, r_PtxRegister1745,
		r_PtxRegister1746, r_PtxRegister1747, r_PtxRegister1748, r_PtxRegister1749, r_LaneIndexAtPtx4269,
		r_PtxRegister1751, r_PtxRegister1752;
	uint32_t r_PtxRegister1753, r_PtxRegister1754, r_PtxRegister1755, r_PtxRegister1756, r_PtxRegister1757,
		r_PtxRegister1758, r_PtxRegister1759, r_PtxRegister1760, r_PtxRegister1761, r_PtxRegister1762,
		r_PtxRegister1763, r_PtxRegister1764;
	uint32_t r_PtxRegister1765, r_PtxRegister1766, r_PtxRegister1767, r_PtxRegister1768, r_LaneIndexAtPtx4304,
		r_PtxRegister1770, r_PtxRegister1771, r_PtxRegister1772, r_PtxRegister1773, r_PtxRegister1774,
		r_PtxRegister1775, r_PtxRegister1776;
	uint32_t r_PtxRegister1777, r_PtxRegister1778, r_PtxRegister1779, r_PtxRegister1780, r_PtxRegister1781,
		r_PtxRegister1782, r_PtxRegister1783, r_PtxRegister1784, r_PtxRegister1785, r_PtxRegister1786,
		r_PtxRegister1787, r_LaneIndexAtPtx4339;
	uint32_t r_PtxRegister1789, r_PtxRegister1790, r_PtxRegister1791, r_PtxRegister1792, r_PtxRegister1793,
		r_PtxRegister1794, r_PtxRegister1795, r_PtxRegister1796, r_PtxRegister1797, r_PtxRegister1798,
		r_PtxRegister1799, r_PtxRegister1800;
	uint32_t r_PtxRegister1801, r_PtxRegister1802, r_PtxRegister1803, r_PtxRegister1804, r_PtxRegister1805,
		r_PtxRegister1806, r_PtxRegister1807, r_LaneIndexAtPtx4373, r_PtxRegister1809, r_PtxRegister1810,
		r_PtxRegister1811, r_PtxRegister1812;
	uint32_t r_PtxRegister1813, r_PtxRegister1814, r_PtxRegister1815, r_PtxRegister1816, r_PtxRegister1817,
		r_PtxRegister1818, r_PtxRegister1819, r_PtxRegister1820, r_PtxRegister1821, r_PtxRegister1822,
		r_PtxRegister1823, r_PtxRegister1824;
	uint32_t r_PtxRegister1825, r_PtxRegister1826, r_PtxRegister1827, r_LaneIndexAtPtx4407, r_PtxRegister1829,
		r_PtxRegister1830, r_PtxRegister1831, r_PtxRegister1832, r_PtxRegister1833, r_PtxRegister1834,
		r_PtxRegister1835, r_PtxRegister1836;
	uint32_t r_PtxRegister1837, r_PtxRegister1838, r_PtxRegister1839, r_PtxRegister1840, r_PtxRegister1841,
		r_PtxRegister1842, r_PtxRegister1843, r_PtxRegister1844, r_PtxRegister1845, r_PtxRegister1846,
		r_PtxRegister1847, r_LaneIndexAtPtx4441;
	uint32_t r_PtxRegister1849, r_PtxRegister1850, r_PtxRegister1851, r_PtxRegister1852, r_PtxRegister1853,
		r_PtxRegister1854, r_PtxRegister1855, r_PtxRegister1856, r_PtxRegister1857, r_PtxRegister1858,
		r_PtxRegister1859, r_PtxRegister1860;
	uint32_t r_PtxRegister1861, r_PtxRegister1862, r_PtxRegister1863, r_PtxRegister1864, r_PtxRegister1865,
		r_PtxRegister1866, r_PtxRegister1867, r_LaneIndexAtPtx4475, r_PtxRegister1869, r_PtxRegister1870,
		r_PtxRegister1871, r_PtxRegister1872;
	uint32_t r_PtxRegister1873, r_PtxRegister1874, r_PtxRegister1875, r_PtxRegister1876, r_PtxRegister1877,
		r_PtxRegister1878, r_PtxRegister1879, r_PtxRegister1880, r_PtxRegister1881, r_PtxRegister1882,
		r_PtxRegister1883, r_PtxRegister1884;
	uint32_t r_PtxRegister1885, r_PtxRegister1886, r_PtxRegister1887, r_LaneIndexAtPtx4509, r_PtxRegister1889,
		r_PtxRegister1890, r_PtxRegister1891, r_PtxRegister1892, r_PtxRegister1893, r_PtxRegister1894,
		r_PtxRegister1895, r_PtxRegister1896;
	uint32_t r_PtxRegister1897, r_PtxRegister1898, r_PtxRegister1899, r_PtxRegister1900, r_PtxRegister1901,
		r_PtxRegister1902, r_PtxRegister1903, r_PtxRegister1904, r_PtxRegister1905, r_PtxRegister1906,
		r_PtxRegister1907, r_LaneIndexAtPtx4543;
	uint32_t r_PtxRegister1909, r_PtxRegister1910, r_PtxRegister1911, r_PtxRegister1912, r_PtxRegister1913,
		r_PtxRegister1914, r_PtxRegister1915, r_PtxRegister1916, r_PtxRegister1917, r_PtxRegister1918,
		r_PtxRegister1919, r_PtxRegister1920;
	uint32_t r_PtxRegister1921, r_PtxRegister1922, r_PtxRegister1923, r_PtxRegister1924, r_PtxRegister1925,
		r_PtxRegister1926, r_PtxRegister1927, r_LaneIndexAtPtx4577, r_PtxRegister1929, r_PtxRegister1930,
		r_PtxRegister1931, r_PtxRegister1932;
	uint32_t r_PtxRegister1933, r_PtxRegister1934, r_PtxRegister1935, r_PtxRegister1936, r_PtxRegister1937,
		r_PtxRegister1938, r_PtxRegister1939, r_PtxRegister1940, r_PtxRegister1941, r_PtxRegister1942,
		r_PtxRegister1943, r_PtxRegister1944;
	uint32_t r_PtxRegister1945, r_PtxRegister1946, r_PtxRegister1947, r_PtxRegister1948, r_PtxRegister1949,
		r_PtxRegister1950, r_PtxRegister1951, r_PtxRegister1952, r_PtxRegister1953, r_PtxRegister1954,
		r_PtxRegister1955, r_PtxRegister1956;
	uint32_t r_PtxRegister1957, r_PtxRegister1958, r_PtxRegister1959, r_PtxRegister1960, r_PtxRegister1961,
		r_PtxRegister1962, r_PtxRegister1963, r_PtxRegister1964, r_PtxRegister1965, r_PtxRegister1966,
		r_PtxRegister1967, r_PtxRegister1968;
	uint32_t r_PtxRegister1969, r_PtxRegister1970, r_PtxRegister1971, r_PtxRegister1972, r_PtxRegister1973,
		r_PtxRegister1974, r_PtxRegister1975, r_PtxRegister1976, r_PtxRegister1977, r_PtxRegister1978,
		r_PtxRegister1979, r_PtxRegister1980;
	uint32_t r_PtxRegister1981, r_PtxRegister1982, r_PtxRegister1983, r_PtxRegister1984, r_PtxRegister1985,
		r_PackedHalf2AtPtx2494R1986, r_PackedHalf2AtPtx2487R1987, r_PackedHalf2AtPtx2480R1988,
		r_PackedHalf2AtPtx2473R1989, r_PackedHalf2AtPtx2466R1990, r_PackedHalf2AtPtx2459R1991,
		r_PackedHalf2AtPtx2452R1992;
	uint32_t r_PackedHalf2AtPtx2445R1993, r_PackedHalf2AtPtx2438R1994, r_PackedHalf2AtPtx2431R1995,
		r_PackedHalf2AtPtx2424R1996, r_PackedHalf2AtPtx2417R1997, r_PackedHalf2AtPtx2410R1998,
		r_PackedHalf2AtPtx2403R1999, r_PackedHalf2AtPtx2396R2000, r_PackedHalf2AtPtx2389R2001,
		r_PackedHalf2AtPtx2382R2002, r_PackedHalf2AtPtx2375R2003, r_PackedHalf2AtPtx2368R2004;
	uint32_t r_PackedHalf2AtPtx2361R2005, r_PackedHalf2AtPtx2354R2006, r_PackedHalf2AtPtx2347R2007,
		r_PackedHalf2AtPtx2340R2008, r_PackedHalf2AtPtx2333R2009, r_PackedHalf2AtPtx2326R2010,
		r_PackedHalf2AtPtx2319R2011, r_PackedHalf2AtPtx2312R2012, r_PackedHalf2AtPtx2305R2013,
		r_PackedHalf2AtPtx2298R2014, r_PackedHalf2AtPtx2291R2015, r_PackedHalf2AtPtx2284R2016;
	uint32_t r_PackedHalf2AtPtx2277R2017, r_PackedHalf2AtPtx2270R2018, r_PackedHalf2AtPtx2263R2019,
		r_PackedHalf2AtPtx2256R2020, r_PackedHalf2AtPtx2249R2021, r_PackedHalf2AtPtx2242R2022,
		r_PackedHalf2AtPtx2235R2023, r_PackedHalf2AtPtx2228R2024, r_PackedHalf2AtPtx2221R2025,
		r_PackedHalf2AtPtx2214R2026, r_PackedHalf2AtPtx2207R2027, r_PackedHalf2AtPtx2200R2028;
	uint32_t r_PackedHalf2AtPtx2193R2029, r_PackedHalf2AtPtx2186R2030, r_PackedHalf2AtPtx2179R2031,
		r_PackedHalf2AtPtx2172R2032, r_PackedHalf2AtPtx2165R2033, r_PackedHalf2AtPtx2158R2034,
		r_PackedHalf2AtPtx2151R2035, r_PackedHalf2AtPtx2144R2036, r_PackedHalf2AtPtx2137R2037,
		r_PackedHalf2AtPtx2130R2038, r_PackedHalf2AtPtx2123R2039, r_PackedHalf2AtPtx2116R2040;
	uint32_t r_PackedHalf2AtPtx2109R2041, r_PackedHalf2AtPtx2102R2042, r_PackedHalf2AtPtx2095R2043,
		r_PackedHalf2AtPtx2088R2044, r_PackedHalf2AtPtx2081R2045, r_PackedHalf2AtPtx2074R2046,
		r_PackedHalf2AtPtx2067R2047, r_PackedHalf2AtPtx2060R2048, r_PackedHalf2AtPtx2053R2049,
		r_PtxRegister2050, r_MmaBE4x4WordAtPtx142R2051, r_MmaBE4x4WordAtPtx142R2052;
	uint32_t r_MmaBE4x4WordAtPtx142R2053, r_MmaBE4x4WordAtPtx142R2054, r_MmaBE4x4WordAtPtx133R2055,
		r_MmaBE4x4WordAtPtx133R2056, r_MmaBE4x4WordAtPtx133R2057, r_MmaBE4x4WordAtPtx133R2058,
		r_MmaBE4x4WordAtPtx124R2059, r_MmaBE4x4WordAtPtx124R2060, r_MmaBE4x4WordAtPtx124R2061,
		r_MmaBE4x4WordAtPtx124R2062, r_MmaBE4x4WordAtPtx115R2063, r_MmaBE4x4WordAtPtx115R2064;
	uint32_t r_MmaBE4x4WordAtPtx115R2065, r_MmaBE4x4WordAtPtx115R2066, r_MmaBE4x4WordAtPtx106R2067,
		r_MmaBE4x4WordAtPtx106R2068, r_MmaBE4x4WordAtPtx106R2069, r_MmaBE4x4WordAtPtx106R2070,
		r_MmaBE4x4WordAtPtx97R2071, r_MmaBE4x4WordAtPtx97R2072, r_MmaBE4x4WordAtPtx97R2073,
		r_MmaBE4x4WordAtPtx97R2074, r_MmaBE4x4WordAtPtx87R2075, r_MmaBE4x4WordAtPtx87R2076;
	uint32_t r_MmaBE4x4WordAtPtx87R2077, r_MmaBE4x4WordAtPtx87R2078, r_MmaBE4x4WordAtPtx78R2079,
		r_MmaBE4x4WordAtPtx78R2080, r_MmaBE4x4WordAtPtx78R2081, r_MmaBE4x4WordAtPtx78R2082;
	uint64_t r_Pointer0Bits, r_Pointer8Bits, r_PtxU64Register3, r_Pointer16Bits, r_Pointer24Bits,
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
	uint64_t r_PtxU64Register97, r_PtxU64Register98, r_PtxU64Register99, r_PtxU64Register100,
		r_PtxU64Register101, r_PtxU64Register102, r_PtxU64Register103, r_PtxU64Register104,
		r_PtxU64Register105, r_PtxU64Register106, r_PtxU64Register107, r_PtxU64Register108;
	uint64_t r_PtxU64Register109, r_PtxU64Register110, r_PtxU64Register111, r_PtxU64Register112,
		r_PtxU64Register113, r_PtxU64Register114, r_PtxU64Register115, r_PtxU64Register116,
		r_PtxU64Register117, r_PtxU64Register118, r_PtxU64Register119, r_PtxU64Register120;
	uint64_t r_PtxU64Register121, r_PtxU64Register122, r_PtxU64Register123, r_PtxU64Register124,
		r_PtxU64Register125, r_PtxU64Register126, r_PtxU64Register127, r_PtxU64Register128,
		r_PtxU64Register129, r_PtxU64Register130, r_PtxU64Register131, r_PtxU64Register132;
	uint64_t r_PtxU64Register133, r_PtxU64Register134, r_PtxU64Register135, r_PtxU64Register136,
		r_PtxU64Register137, r_PtxU64Register138, r_PtxU64Register139, r_PtxU64Register140,
		r_PtxU64Register141, r_PtxU64Register142, r_PtxU64Register143, r_PtxU64Register144;
	uint64_t r_PtxU64Register145, r_PtxU64Register146, r_PtxU64Register147, r_PtxU64Register148,
		r_PtxU64Register149, r_PtxU64Register150, r_PtxU64Register151, r_PtxU64Register152,
		r_PtxU64Register153, r_PtxU64Register154, r_PtxU64Register155, r_PtxU64Register156;
	uint64_t r_PtxU64Register157, r_PtxU64Register158, r_PtxU64Register159, r_PtxU64Register160,
		r_PtxU64Register161, r_PtxU64Register162, r_PtxU64Register163, r_PtxU64Register164,
		r_PtxU64Register165, r_PtxU64Register166, r_PtxU64Register167, r_PtxU64Register168;
	uint64_t r_PtxU64Register169, r_PtxU64Register170, r_PtxU64Register171, r_PtxU64Register172,
		r_PtxU64Register173, r_PtxU64Register174, r_PtxU64Register175, r_PtxU64Register176,
		r_PtxU64Register177, r_PtxU64Register178, r_PtxU64Register179, r_PtxU64Register180;
	uint64_t r_PtxU64Register181, r_PtxU64Register182, r_PtxU64Register183, r_PtxU64Register184,
		r_PtxU64Register185, r_PtxU64Register186, r_PtxU64Register187, r_PtxU64Register188,
		r_PtxU64Register189, r_PtxU64Register190, r_PtxU64Register191, r_PtxU64Register192;
	uint64_t r_PtxU64Register193, r_PtxU64Register194, r_PtxU64Register195, r_PtxU64Register196,
		r_PtxU64Register197, r_PtxU64Register198, r_PtxU64Register199, r_PtxU64Register200,
		r_PtxU64Register201, r_PtxU64Register202, r_PtxU64Register203, r_PtxU64Register204;
	uint64_t r_PtxU64Register205, r_PtxU64Register206, r_PtxU64Register207, r_PtxU64Register208,
		r_PtxU64Register209, r_PtxU64Register210, r_PtxU64Register211, r_PtxU64Register212,
		r_PtxU64Register213, r_PtxU64Register214, r_PtxU64Register215, r_PtxU64Register216;
	uint64_t r_PtxU64Register217, r_PtxU64Register218, r_PtxU64Register219, r_PtxU64Register220,
		r_PtxU64Register221, r_PtxU64Register222, r_PtxU64Register223, r_PtxU64Register224,
		r_PtxU64Register225, r_PtxU64Register226, r_PtxU64Register227, r_PtxU64Register228;
	uint64_t r_PtxU64Register229, r_PtxU64Register230, r_PtxU64Register231, r_PtxU64Register232,
		r_PtxU64Register233, r_PtxU64Register234, r_PtxU64Register235, r_PtxU64Register236,
		r_PtxU64Register237, r_PtxU64Register238, r_PtxU64Register239, r_PtxU64Register240;
	uint64_t r_PtxU64Register241, r_PtxU64Register242, r_PtxU64Register243, r_PtxU64Register244,
		r_PtxU64Register245, r_PtxU64Register246, r_PtxU64Register247, r_PtxU64Register248,
		r_PtxU64Register249, r_PtxU64Register250, r_PtxU64Register251, r_PtxU64Register252;
	uint64_t r_PtxU64Register253, r_PtxU64Register254, r_PtxU64Register255, r_PtxU64Register256,
		r_PtxU64Register257, r_PtxU64Register258, r_PtxU64Register259, r_PtxU64Register260,
		r_PtxU64Register261, r_PtxU64Register262, r_PtxU64Register263, r_PtxU64Register264;
	uint64_t r_PtxU64Register265, r_PtxU64Register266, r_PtxU64Register267, r_PtxU64Register268,
		r_PtxU64Register269, r_PtxU64Register270, r_PtxU64Register271, r_PtxU64Register272,
		r_PtxU64Register273, r_PtxU64Register274, r_PtxU64Register275, r_PtxU64Register276;
	uint64_t r_PtxU64Register277, r_PtxU64Register278, r_PtxU64Register279, r_PtxU64Register280,
		r_PtxU64Register281, r_PtxU64Register282, r_PtxU64Register283, r_PtxU64Register284,
		r_PtxU64Register285, r_PtxU64Register286, r_PtxU64Register287, r_PtxU64Register288;
	uint64_t r_PtxU64Register289, r_PtxU64Register290, r_PtxU64Register291, r_PtxU64Register292,
		r_PtxU64Register293, r_PtxU64Register294, r_PtxU64Register295, r_PtxU64Register296,
		r_PtxU64Register297, r_PtxU64Register298, r_PtxU64Register299, r_PtxU64Register300;
	uint64_t r_PtxU64Register301, r_PtxU64Register302, r_PtxU64Register303, r_PtxU64Register304,
		r_PtxU64Register305, r_PtxU64Register306, r_PtxU64Register307, r_PtxU64Register308,
		r_PtxU64Register309, r_PtxU64Register310, r_PtxU64Register311, r_PtxU64Register312;
	uint64_t r_PtxU64Register313, r_PtxU64Register314;
	// Phase: physical_abi_setup. Bind caller-owned physical buffers and geometry from the original ABI. Address words are not logical BHWC tensors.
	r_Pointer24Bits = uint64_t(r_Parameters.g_Pointer24); // PTX L14
	r_Pointer16Bits = uint64_t(r_Parameters.g_Pointer16); // PTX L15
	r_Pointer8Bits = uint64_t(r_Parameters.g_Pointer8);	  // PTX L16
	r_Pointer0Bits = uint64_t(r_Parameters.g_Pointer0);	  // PTX L17
	r_Scalar32Bits = uint32_t(r_Parameters.Scalar32);
	r_Scalar36Bits = uint32_t(r_Parameters.Scalar36);							  // PTX L18
	r_CtaX = uint32_t(blockIdx.x);												  // PTX L19
	r_CtaY = uint32_t(blockIdx.y);												  // PTX L20
	r_CtaZAtPtx21 = uint32_t(blockIdx.z);										  // PTX L21
	r_PtxRegister111 = uint32_t(r_Scalar36Bits) + uint32_t(-1);					  // PTX L22
	r_PtxRegister112 = ShiftRightSigned(int32_t(r_PtxRegister111), uint32_t(31)); // PTX L23
	r_PtxRegister113 = ShiftRight(uint32_t(r_PtxRegister112), uint32_t(29));	  // PTX L24
	r_PtxRegister114 = uint32_t(r_PtxRegister111) + uint32_t(r_PtxRegister113);	  // PTX L25
	r_PtxRegister115 = ShiftRightSigned(int32_t(r_PtxRegister114), uint32_t(3));  // PTX L26
	r_PtxRegister116 = uint32_t(r_PtxRegister115) + uint32_t(1);				  // PTX L27
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister116));		  // PTX L28
	r_PtxRegister117 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister115) + uint32_t(r_PtxRegister2); // PTX L29
	r_PtxRegister118 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister117);					  // PTX L30
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));							  // PTX L31
	r_PtxRegister4 = ShiftLeft(uint32_t(r_PtxRegister118), uint32_t(3));				  // PTX L32
	r_PtxRegister5 = ShiftLeft(uint32_t(r_PtxRegister118), uint32_t(1));				  // PTX L33
	r_PtxRegister119 = ShiftRightSigned(int32_t(r_Scalar32Bits), uint32_t(31));			  // PTX L34
	r_PtxRegister120 = ShiftRight(uint32_t(r_PtxRegister119), uint32_t(30));			  // PTX L35
	r_PtxRegister121 = uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister120);			  // PTX L36
	r_PtxRegister6 = ShiftRightSigned(int32_t(r_PtxRegister121), uint32_t(2));			  // PTX L37
	r_PtxRegister122 = ShiftRightSigned(int32_t(r_Scalar36Bits), uint32_t(31));			  // PTX L38
	r_PtxRegister123 = ShiftRight(uint32_t(r_PtxRegister122), uint32_t(30));			  // PTX L39
	r_PtxRegister124 = uint32_t(r_Scalar36Bits) + uint32_t(r_PtxRegister123);			  // PTX L40
	r_PtxRegister7 = ShiftRightSigned(int32_t(r_PtxRegister124), uint32_t(2));			  // PTX L41
	r_ThreadX = uint32_t(threadIdx.x);													  // PTX L42
	r_ThreadY = uint32_t(threadIdx.y);													  // PTX L43
	r_PtxRegister126 = r_ThreadX | r_ThreadY;											  // PTX L44
	r_bPtxPredicate16 = uint32_t(r_PtxRegister126) != uint32_t(0);						  // PTX L45
	if (r_bPtxPredicate16)
	{
		goto L__BB35_2;
	} // PTX L46
	r_BlockSizeX = uint32_t(blockDim.x);										 // PTX L47
	r_BlockSizeY = uint32_t(blockDim.y);										 // PTX L48
	r_PtxRegister128 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			 // PTX L49
	r_PtxRegister127 = uint32_t(12288u /* exact native shared-region offset */); // PTX L50
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister127, r_PtxRegister128); // PTX L52
	r_PtxRegister129 = uint32_t(r_PtxRegister127) + uint32_t(8);	  // PTX L54
	BarrierInit(s_SharedStorage, r_PtxRegister129, r_PtxRegister128); // PTX L56
	r_PtxRegister130 = uint32_t(r_PtxRegister127) + uint32_t(16);	  // PTX L58
	BarrierInit(s_SharedStorage, r_PtxRegister130, r_PtxRegister128); // PTX L60
L__BB35_2:															  // PTX L62
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L63
	r_PtxRegister141 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(6));								// PTX L64
	r_PtxRegister142 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));						// PTX L65
	r_PtxRegister9 = uint32_t(r_PtxRegister141) + uint32_t(r_PtxRegister142);					// PTX L66
	r_PtxRegister143 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(16));						// PTX L67
	r_PtxRegister144 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(3));						// PTX L68
	r_PtxRegister145 = uint32_t(r_PtxRegister143) + uint32_t(r_PtxRegister144);					// PTX L69
	r_PtxU64Register14 = uint64_t(int64_t(int32_t(r_PtxRegister145)) * int64_t(int32_t(4)));	// PTX L70
	r_PtxU64Register15 = uint64_t(r_Pointer24Bits) + uint64_t(r_PtxU64Register14);				// PTX L71
	r_LaneIndexAtPtx73 = uint32_t((threadIdx.x & 31u));											// PTX L73
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx73)) * int64_t(int32_t(16))); // PTX L75
	r_PtxU64Register6 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register16);			// PTX L76
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register6));
		r_MmaBE4x4WordAtPtx78R2082 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R2081 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R2080 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R2079 = r_Value.w;
	} // PTX L78
	r_LaneIndexAtPtx81 = uint32_t((threadIdx.x & 31u));											// PTX L81
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx81)) * int64_t(int32_t(16))); // PTX L83
	r_PtxU64Register18 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register17);			// PTX L84
	r_PtxU64Register7 = uint64_t(r_PtxU64Register18) + uint64_t(512);							// PTX L85
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register7));
		r_MmaBE4x4WordAtPtx87R2078 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R2077 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R2076 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R2075 = r_Value.w;
	} // PTX L87
	r_PtxRegister10 = r_PtxRegister9 | 32;														// PTX L89
	r_LaneIndexAtPtx91 = uint32_t((threadIdx.x & 31u));											// PTX L91
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx91)) * int64_t(int32_t(16))); // PTX L93
	r_PtxU64Register20 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register19);			// PTX L94
	r_PtxU64Register8 = uint64_t(r_PtxU64Register20) + uint64_t(1024);							// PTX L95
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register8));
		r_MmaBE4x4WordAtPtx97R2074 = r_Value.x;
		r_MmaBE4x4WordAtPtx97R2073 = r_Value.y;
		r_MmaBE4x4WordAtPtx97R2072 = r_Value.z;
		r_MmaBE4x4WordAtPtx97R2071 = r_Value.w;
	} // PTX L97
	r_LaneIndexAtPtx100 = uint32_t((threadIdx.x & 31u));										 // PTX L100
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx100)) * int64_t(int32_t(16))); // PTX L102
	r_PtxU64Register22 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register21);			 // PTX L103
	r_PtxU64Register9 = uint64_t(r_PtxU64Register22) + uint64_t(1536);							 // PTX L104
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register9));
		r_MmaBE4x4WordAtPtx106R2070 = r_Value.x;
		r_MmaBE4x4WordAtPtx106R2069 = r_Value.y;
		r_MmaBE4x4WordAtPtx106R2068 = r_Value.z;
		r_MmaBE4x4WordAtPtx106R2067 = r_Value.w;
	} // PTX L106
	r_LaneIndexAtPtx109 = uint32_t((threadIdx.x & 31u));										 // PTX L109
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx109)) * int64_t(int32_t(16))); // PTX L111
	r_PtxU64Register24 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register23);			 // PTX L112
	r_PtxU64Register10 = uint64_t(r_PtxU64Register24) + uint64_t(16384);						 // PTX L113
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register10));
		r_MmaBE4x4WordAtPtx115R2066 = r_Value.x;
		r_MmaBE4x4WordAtPtx115R2065 = r_Value.y;
		r_MmaBE4x4WordAtPtx115R2064 = r_Value.z;
		r_MmaBE4x4WordAtPtx115R2063 = r_Value.w;
	} // PTX L115
	r_LaneIndexAtPtx118 = uint32_t((threadIdx.x & 31u));										 // PTX L118
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx118)) * int64_t(int32_t(16))); // PTX L120
	r_PtxU64Register26 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register25);			 // PTX L121
	r_PtxU64Register11 = uint64_t(r_PtxU64Register26) + uint64_t(16896);						 // PTX L122
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register11));
		r_MmaBE4x4WordAtPtx124R2062 = r_Value.x;
		r_MmaBE4x4WordAtPtx124R2061 = r_Value.y;
		r_MmaBE4x4WordAtPtx124R2060 = r_Value.z;
		r_MmaBE4x4WordAtPtx124R2059 = r_Value.w;
	} // PTX L124
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	r_PtxU64Register28 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register27);			 // PTX L130
	r_PtxU64Register12 = uint64_t(r_PtxU64Register28) + uint64_t(17408);						 // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register12));
		r_MmaBE4x4WordAtPtx133R2058 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R2057 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R2056 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R2055 = r_Value.w;
	} // PTX L133
	r_LaneIndexAtPtx136 = uint32_t((threadIdx.x & 31u));										 // PTX L136
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx136)) * int64_t(int32_t(16))); // PTX L138
	r_PtxU64Register30 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register29);			 // PTX L139
	r_PtxU64Register13 = uint64_t(r_PtxU64Register30) + uint64_t(17920);						 // PTX L140
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register13));
		r_MmaBE4x4WordAtPtx142R2054 = r_Value.x;
		r_MmaBE4x4WordAtPtx142R2053 = r_Value.y;
		r_MmaBE4x4WordAtPtx142R2052 = r_Value.z;
		r_MmaBE4x4WordAtPtx142R2051 = r_Value.w;
	} // PTX L142
	r_PtxRegister11 = r_ThreadY & 1;										  // PTX L144
	r_PtxRegister146 = ShiftRight(uint32_t(r_ThreadY), uint32_t(1));		  // PTX L145
	r_PtxRegister147 = r_PtxRegister146 & 1;								  // PTX L146
	r_PtxRegister148 = ShiftRight(uint32_t(r_ThreadY), uint32_t(2));		  // PTX L147
	r_PtxRegister149 = ShiftLeft(uint32_t(r_PtxRegister148), uint32_t(9));	  // PTX L148
	r_PtxRegister150 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(7));			  // PTX L149
	r_PtxRegister12 = r_PtxRegister150 & 256;								  // PTX L150
	r_PtxRegister151 = r_PtxRegister149 | r_PtxRegister12;					  // PTX L151
	r_PtxRegister13 = r_PtxRegister150 & 128;								  // PTX L152
	r_PtxRegister14 = r_PtxRegister151 | r_PtxRegister13;					  // PTX L153
	r_PtxRegister152 = uint32_t(r_PtxRegister148) + uint32_t(r_PtxRegister3); // PTX L154
	r_PtxRegister15 = uint32_t(r_PtxRegister147) + uint32_t(r_PtxRegister5);  // PTX L155
	r_PtxRegister16 = r_Scalar32Bits & -4;									  // PTX L156
	r_bPtxPredicate17 = uint32_t(r_PtxRegister16) == uint32_t(4);			  // PTX L157
	r_bPtxPredicate18 = int32_t(r_PtxRegister152) < int32_t(r_PtxRegister6);  // PTX L158
	r_PtxRegister153 = uint32_t(r_PtxRegister152) * uint32_t(r_PtxRegister7); // PTX L159
	r_PtxRegister17 = r_bPtxPredicate17 ? 0 : r_PtxRegister153;				  // PTX L160
	r_bPtxPredicate1 = r_bPtxPredicate17 | r_bPtxPredicate18;				  // PTX L161
	r_bPtxPredicate280 = bool(0);											  // PTX L162
	r_bPtxPredicate19 = !r_bPtxPredicate1;									  // PTX L163
	r_PtxRegister1948 = uint32_t(r_PtxRegister15);							  // PTX L164
	if (r_bPtxPredicate19)
	{
		goto L__BB35_5;
	} // PTX L165
	r_PtxRegister154 = r_Scalar36Bits & -4;						   // PTX L166
	r_bPtxPredicate20 = uint32_t(r_PtxRegister154) == uint32_t(4); // PTX L167
	r_bPtxPredicate280 = bool(-1);								   // PTX L168
	r_PtxRegister1948 = uint32_t(0);							   // PTX L169
	if (r_bPtxPredicate20)
	{
		goto L__BB35_5;
	} // PTX L170
	r_bPtxPredicate280 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7); // PTX L171
	r_PtxRegister1948 = uint32_t(r_PtxRegister15);							 // PTX L172
L__BB35_5:																	 // PTX L173
	r_PtxU64Register299 = uint64_t(0);										 // PTX L174
	r_bPtxPredicate21 = !r_bPtxPredicate280;								 // PTX L175
	if (r_bPtxPredicate21)
	{
		goto L__BB35_7;
	} // PTX L176
	r_PtxRegister155 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister1948); // PTX L177
	r_PtxRegister156 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister155);	// PTX L178
	r_PtxRegister157 = ShiftLeft(uint32_t(r_PtxRegister156), uint32_t(11));		// PTX L179
	r_PtxRegister158 = r_PtxRegister157 | r_PtxRegister13;						// PTX L180
	r_PtxU64Register299 = SignExtendWordBits(r_PtxRegister158);					// PTX L181
L__BB35_7:																		// PTX L182
	r_PtxU64Register300 = uint64_t(0);											// PTX L183
	if (r_bPtxPredicate21)
	{
		goto L__BB35_9;
	} // PTX L184
	r_PtxU64Register31 = ShiftLeft(uint64_t(r_PtxU64Register299), uint32_t(2));	   // PTX L185
	r_PtxU64Register300 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register31); // PTX L186
L__BB35_9:																		   // PTX L187
	r_PtxRegister159 = ShiftLeft(uint32_t(r_PtxRegister14), uint32_t(2));		   // PTX L188
	r_PtxRegister160 = uint32_t(0u /* exact native shared-region offset */);	   // PTX L189
	r_PtxRegister18 = uint32_t(r_PtxRegister160) + uint32_t(r_PtxRegister159);	   // PTX L190
	if (r_bPtxPredicate21)
	{
		goto L__BB35_12;
	} // PTX L191
	r_PtxRegister168 = uint32_t(-1);							   // PTX L192
	r_PtxRegister167 = Elected(r_PtxRegister168);				   // PTX L194
	r_bPtxPredicate22 = uint32_t(r_PtxRegister167) == uint32_t(0); // PTX L200
	if (r_bPtxPredicate22)
	{
		goto L__BB35_13;
	} // PTX L201
	r_PtxU64Register32 = r_PtxU64Register300;									 // PTX L202
	r_PtxRegister170 = uint32_t(12288u /* exact native shared-region offset */); // PTX L203
	r_PtxRegister169 = uint32_t(512);											 // PTX L204
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister18, r_PtxU64Register32, r_PtxRegister169,
			 r_PtxRegister170);																   // PTX L206
	BarrierExpect(s_SharedStorage, r_PtxRegister170, r_PtxRegister169);						   // PTX L209
	goto L__BB35_13;																		   // PTX L211
L__BB35_12:																					   // PTX L212
	r_PtxRegister161 = uint32_t(0);															   // PTX L213
	r_PtxU16Register65 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister161))); // PTX L215
	r_PackedHalf2AtPtx218R162 = JoinHalfwords(r_PtxU16Register65, r_PtxU16Register65);		   // PTX L218
	r_ConvertedE4PairAtPtx220Rs66 = PublishE4(r_PackedHalf2AtPtx218R162);					   // PTX L220
	r_PackedE4WordAtPtx222R165 =
		JoinHalfwords(r_ConvertedE4PairAtPtx220Rs66, r_ConvertedE4PairAtPtx220Rs66); // PTX L222
	r_LaneIndexAtPtx224 = uint32_t((threadIdx.x & 31u));							 // PTX L224
	r_PtxRegister166 = ShiftLeft(uint32_t(r_LaneIndexAtPtx224), uint32_t(4));		 // PTX L226
	r_PtxRegister164 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister166);		 // PTX L227
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister164)) =
		make_uint4(r_PackedE4WordAtPtx222R165, r_PackedE4WordAtPtx222R165, r_PackedE4WordAtPtx222R165,
				   r_PackedE4WordAtPtx222R165);								  // PTX L229
L__BB35_13:																	  // PTX L231
	r_bPtxPredicate23 = uint32_t(r_PtxRegister16) == uint32_t(4);			  // PTX L232
	r_PtxRegister171 = uint32_t(r_ThreadY) + uint32_t(4);					  // PTX L233
	r_PtxRegister172 = ShiftRight(uint32_t(r_PtxRegister171), uint32_t(2));	  // PTX L234
	r_PtxRegister173 = ShiftLeft(uint32_t(r_PtxRegister172), uint32_t(9));	  // PTX L235
	r_PtxRegister174 = r_PtxRegister173 | r_PtxRegister12;					  // PTX L236
	r_PtxRegister19 = uint32_t(r_PtxRegister174) + uint32_t(r_PtxRegister13); // PTX L237
	r_PtxRegister175 = uint32_t(r_PtxRegister172) + uint32_t(r_PtxRegister3); // PTX L238
	r_bPtxPredicate24 = int32_t(r_PtxRegister175) < int32_t(r_PtxRegister6);  // PTX L239
	r_PtxRegister176 = uint32_t(r_PtxRegister175) * uint32_t(r_PtxRegister7); // PTX L240
	r_PtxRegister20 = r_bPtxPredicate23 ? 0 : r_PtxRegister176;				  // PTX L241
	r_bPtxPredicate2 = r_bPtxPredicate23 | r_bPtxPredicate24;				  // PTX L242
	r_bPtxPredicate281 = bool(0);											  // PTX L243
	r_bPtxPredicate25 = !r_bPtxPredicate2;									  // PTX L244
	r_PtxRegister1949 = uint32_t(r_PtxRegister15);							  // PTX L245
	if (r_bPtxPredicate25)
	{
		goto L__BB35_16;
	} // PTX L246
	r_PtxRegister177 = r_Scalar36Bits & -4;						   // PTX L247
	r_bPtxPredicate26 = uint32_t(r_PtxRegister177) == uint32_t(4); // PTX L248
	r_bPtxPredicate281 = bool(-1);								   // PTX L249
	r_PtxRegister1949 = uint32_t(0);							   // PTX L250
	if (r_bPtxPredicate26)
	{
		goto L__BB35_16;
	} // PTX L251
	r_bPtxPredicate281 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7); // PTX L252
	r_PtxRegister1949 = uint32_t(r_PtxRegister15);							 // PTX L253
L__BB35_16:																	 // PTX L254
	r_PtxU64Register301 = uint64_t(0);										 // PTX L255
	r_bPtxPredicate27 = !r_bPtxPredicate281;								 // PTX L256
	if (r_bPtxPredicate27)
	{
		goto L__BB35_18;
	} // PTX L257
	r_PtxRegister178 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister1949); // PTX L258
	r_PtxRegister179 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister178);	// PTX L259
	r_PtxRegister180 = ShiftLeft(uint32_t(r_PtxRegister179), uint32_t(11));		// PTX L260
	r_PtxRegister181 = r_PtxRegister180 | r_PtxRegister13;						// PTX L261
	r_PtxU64Register301 = SignExtendWordBits(r_PtxRegister181);					// PTX L262
L__BB35_18:																		// PTX L263
	r_PtxU64Register302 = uint64_t(0);											// PTX L264
	if (r_bPtxPredicate27)
	{
		goto L__BB35_20;
	} // PTX L265
	r_PtxU64Register33 = ShiftLeft(uint64_t(r_PtxU64Register301), uint32_t(2));	   // PTX L266
	r_PtxU64Register302 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register33); // PTX L267
L__BB35_20:																		   // PTX L268
	r_PtxRegister182 = ShiftLeft(uint32_t(r_PtxRegister19), uint32_t(2));		   // PTX L269
	r_PtxRegister183 = uint32_t(0u /* exact native shared-region offset */);	   // PTX L270
	r_PtxRegister21 = uint32_t(r_PtxRegister183) + uint32_t(r_PtxRegister182);	   // PTX L271
	if (r_bPtxPredicate27)
	{
		goto L__BB35_23;
	} // PTX L272
	r_PtxRegister191 = uint32_t(-1);							   // PTX L273
	r_PtxRegister190 = Elected(r_PtxRegister191);				   // PTX L275
	r_bPtxPredicate28 = uint32_t(r_PtxRegister190) == uint32_t(0); // PTX L281
	if (r_bPtxPredicate28)
	{
		goto L__BB35_24;
	} // PTX L282
	r_PtxU64Register34 = r_PtxU64Register302;									 // PTX L283
	r_PtxRegister193 = uint32_t(12288u /* exact native shared-region offset */); // PTX L284
	r_PtxRegister192 = uint32_t(512);											 // PTX L285
	CopyBulk(s_SharedStorage, r_PtxRegister21, r_PtxU64Register34, r_PtxRegister192,
			 r_PtxRegister193);																   // PTX L287
	BarrierExpect(s_SharedStorage, r_PtxRegister193, r_PtxRegister192);						   // PTX L290
	goto L__BB35_24;																		   // PTX L292
L__BB35_23:																					   // PTX L293
	r_PtxRegister184 = uint32_t(0);															   // PTX L294
	r_PtxU16Register67 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister184))); // PTX L296
	r_PackedHalf2AtPtx299R185 = JoinHalfwords(r_PtxU16Register67, r_PtxU16Register67);		   // PTX L299
	r_ConvertedE4PairAtPtx301Rs68 = PublishE4(r_PackedHalf2AtPtx299R185);					   // PTX L301
	r_PackedE4WordAtPtx303R188 =
		JoinHalfwords(r_ConvertedE4PairAtPtx301Rs68, r_ConvertedE4PairAtPtx301Rs68); // PTX L303
	r_LaneIndexAtPtx305 = uint32_t((threadIdx.x & 31u));							 // PTX L305
	r_PtxRegister189 = ShiftLeft(uint32_t(r_LaneIndexAtPtx305), uint32_t(4));		 // PTX L307
	r_PtxRegister187 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister189);		 // PTX L308
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister187)) =
		make_uint4(r_PackedE4WordAtPtx303R188, r_PackedE4WordAtPtx303R188, r_PackedE4WordAtPtx303R188,
				   r_PackedE4WordAtPtx303R188);							// PTX L310
L__BB35_24:																// PTX L312
	r_PtxRegister194 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(9)); // PTX L313
	r_PtxRegister22 = r_PtxRegister194 | 64;							// PTX L314
	r_bPtxPredicate282 = bool(0);										// PTX L315
	r_PtxRegister1950 = uint32_t(r_PtxRegister15);						// PTX L316
	if (r_bPtxPredicate19)
	{
		goto L__BB35_27;
	} // PTX L317
	r_PtxRegister195 = r_Scalar36Bits & -4;						   // PTX L318
	r_bPtxPredicate29 = uint32_t(r_PtxRegister195) == uint32_t(4); // PTX L319
	r_bPtxPredicate282 = bool(-1);								   // PTX L320
	r_PtxRegister1950 = uint32_t(0);							   // PTX L321
	if (r_bPtxPredicate29)
	{
		goto L__BB35_27;
	} // PTX L322
	r_bPtxPredicate282 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7); // PTX L323
	r_PtxRegister1950 = uint32_t(r_PtxRegister15);							 // PTX L324
L__BB35_27:																	 // PTX L325
	r_PtxU64Register303 = uint64_t(0);										 // PTX L326
	r_bPtxPredicate30 = !r_bPtxPredicate282;								 // PTX L327
	if (r_bPtxPredicate30)
	{
		goto L__BB35_29;
	} // PTX L328
	r_PtxRegister196 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister1950); // PTX L329
	r_PtxRegister197 = ShiftRight(uint32_t(r_PtxRegister22), uint32_t(5));		// PTX L330
	r_PtxRegister198 = uint32_t(r_PtxRegister197) + uint32_t(r_PtxRegister11);	// PTX L331
	r_PtxRegister199 = ShiftLeft(uint32_t(r_PtxRegister196), uint32_t(11));		// PTX L332
	r_PtxRegister200 = ShiftLeft(uint32_t(r_PtxRegister198), uint32_t(7));		// PTX L333
	r_PtxRegister201 = uint32_t(r_PtxRegister199) + uint32_t(r_PtxRegister200); // PTX L334
	r_PtxU64Register303 = SignExtendWordBits(r_PtxRegister201);					// PTX L335
L__BB35_29:																		// PTX L336
	r_PtxU64Register304 = uint64_t(0);											// PTX L337
	if (r_bPtxPredicate30)
	{
		goto L__BB35_31;
	} // PTX L338
	r_PtxU64Register35 = ShiftLeft(uint64_t(r_PtxU64Register303), uint32_t(2));	   // PTX L339
	r_PtxU64Register304 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register35); // PTX L340
L__BB35_31:																		   // PTX L341
	if (r_bPtxPredicate30)
	{
		goto L__BB35_34;
	} // PTX L342
	r_PtxRegister210 = uint32_t(-1);							   // PTX L343
	r_PtxRegister209 = Elected(r_PtxRegister210);				   // PTX L345
	r_bPtxPredicate31 = uint32_t(r_PtxRegister209) == uint32_t(0); // PTX L351
	if (r_bPtxPredicate31)
	{
		goto L__BB35_35;
	} // PTX L352
	r_PtxRegister211 = uint32_t(r_PtxRegister18) + uint32_t(4096);				 // PTX L353
	r_PtxU64Register36 = r_PtxU64Register304;									 // PTX L354
	r_PtxRegister214 = uint32_t(12288u /* exact native shared-region offset */); // PTX L355
	r_PtxRegister213 = uint32_t(r_PtxRegister214) + uint32_t(8);				 // PTX L356
	r_PtxRegister212 = uint32_t(512);											 // PTX L357
	CopyBulk(s_SharedStorage, r_PtxRegister211, r_PtxU64Register36, r_PtxRegister212,
			 r_PtxRegister213);																   // PTX L359
	BarrierExpect(s_SharedStorage, r_PtxRegister213, r_PtxRegister212);						   // PTX L362
	goto L__BB35_35;																		   // PTX L364
L__BB35_34:																					   // PTX L365
	r_PtxRegister202 = uint32_t(0);															   // PTX L366
	r_PtxU16Register69 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister202))); // PTX L368
	r_PackedHalf2AtPtx371R203 = JoinHalfwords(r_PtxU16Register69, r_PtxU16Register69);		   // PTX L371
	r_ConvertedE4PairAtPtx373Rs70 = PublishE4(r_PackedHalf2AtPtx371R203);					   // PTX L373
	r_PackedE4WordAtPtx375R206 =
		JoinHalfwords(r_ConvertedE4PairAtPtx373Rs70, r_ConvertedE4PairAtPtx373Rs70); // PTX L375
	r_LaneIndexAtPtx377 = uint32_t((threadIdx.x & 31u));							 // PTX L377
	r_PtxRegister207 = ShiftLeft(uint32_t(r_LaneIndexAtPtx377), uint32_t(4));		 // PTX L379
	r_PtxRegister208 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister207);		 // PTX L380
	r_PtxRegister205 = uint32_t(r_PtxRegister208) + uint32_t(4096);					 // PTX L381
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister205)) =
		make_uint4(r_PackedE4WordAtPtx375R206, r_PackedE4WordAtPtx375R206, r_PackedE4WordAtPtx375R206,
				   r_PackedE4WordAtPtx375R206);	   // PTX L383
L__BB35_35:										   // PTX L385
	r_bPtxPredicate283 = bool(0);				   // PTX L386
	r_PtxRegister1951 = uint32_t(r_PtxRegister15); // PTX L387
	if (r_bPtxPredicate25)
	{
		goto L__BB35_38;
	} // PTX L388
	r_PtxRegister215 = r_Scalar36Bits & -4;						   // PTX L389
	r_bPtxPredicate32 = uint32_t(r_PtxRegister215) == uint32_t(4); // PTX L390
	r_bPtxPredicate283 = bool(-1);								   // PTX L391
	r_PtxRegister1951 = uint32_t(0);							   // PTX L392
	if (r_bPtxPredicate32)
	{
		goto L__BB35_38;
	} // PTX L393
	r_bPtxPredicate283 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7); // PTX L394
	r_PtxRegister1951 = uint32_t(r_PtxRegister15);							 // PTX L395
L__BB35_38:																	 // PTX L396
	r_PtxU64Register305 = uint64_t(0);										 // PTX L397
	r_bPtxPredicate33 = !r_bPtxPredicate283;								 // PTX L398
	if (r_bPtxPredicate33)
	{
		goto L__BB35_40;
	} // PTX L399
	r_PtxRegister216 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister1951); // PTX L400
	r_PtxRegister217 = ShiftRight(uint32_t(r_PtxRegister22), uint32_t(5));		// PTX L401
	r_PtxRegister218 = uint32_t(r_PtxRegister217) + uint32_t(r_PtxRegister11);	// PTX L402
	r_PtxRegister219 = ShiftLeft(uint32_t(r_PtxRegister216), uint32_t(11));		// PTX L403
	r_PtxRegister220 = ShiftLeft(uint32_t(r_PtxRegister218), uint32_t(7));		// PTX L404
	r_PtxRegister221 = uint32_t(r_PtxRegister219) + uint32_t(r_PtxRegister220); // PTX L405
	r_PtxU64Register305 = SignExtendWordBits(r_PtxRegister221);					// PTX L406
L__BB35_40:																		// PTX L407
	r_PtxU64Register306 = uint64_t(0);											// PTX L408
	if (r_bPtxPredicate33)
	{
		goto L__BB35_42;
	} // PTX L409
	r_PtxU64Register37 = ShiftLeft(uint64_t(r_PtxU64Register305), uint32_t(2));	   // PTX L410
	r_PtxU64Register306 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register37); // PTX L411
L__BB35_42:																		   // PTX L412
	if (r_bPtxPredicate33)
	{
		goto L__BB35_45;
	} // PTX L413
	r_PtxRegister230 = uint32_t(-1);							   // PTX L414
	r_PtxRegister229 = Elected(r_PtxRegister230);				   // PTX L416
	r_bPtxPredicate34 = uint32_t(r_PtxRegister229) == uint32_t(0); // PTX L422
	if (r_bPtxPredicate34)
	{
		goto L__BB35_46;
	} // PTX L423
	r_PtxRegister231 = uint32_t(r_PtxRegister21) + uint32_t(4096);				 // PTX L424
	r_PtxU64Register38 = r_PtxU64Register306;									 // PTX L425
	r_PtxRegister234 = uint32_t(12288u /* exact native shared-region offset */); // PTX L426
	r_PtxRegister233 = uint32_t(r_PtxRegister234) + uint32_t(8);				 // PTX L427
	r_PtxRegister232 = uint32_t(512);											 // PTX L428
	CopyBulk(s_SharedStorage, r_PtxRegister231, r_PtxU64Register38, r_PtxRegister232,
			 r_PtxRegister233);																   // PTX L430
	BarrierExpect(s_SharedStorage, r_PtxRegister233, r_PtxRegister232);						   // PTX L433
	goto L__BB35_46;																		   // PTX L435
L__BB35_45:																					   // PTX L436
	r_PtxRegister222 = uint32_t(0);															   // PTX L437
	r_PtxU16Register71 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister222))); // PTX L439
	r_PackedHalf2AtPtx442R223 = JoinHalfwords(r_PtxU16Register71, r_PtxU16Register71);		   // PTX L442
	r_ConvertedE4PairAtPtx444Rs72 = PublishE4(r_PackedHalf2AtPtx442R223);					   // PTX L444
	r_PackedE4WordAtPtx446R226 =
		JoinHalfwords(r_ConvertedE4PairAtPtx444Rs72, r_ConvertedE4PairAtPtx444Rs72); // PTX L446
	r_LaneIndexAtPtx448 = uint32_t((threadIdx.x & 31u));							 // PTX L448
	r_PtxRegister227 = ShiftLeft(uint32_t(r_LaneIndexAtPtx448), uint32_t(4));		 // PTX L450
	r_PtxRegister228 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister227);		 // PTX L451
	r_PtxRegister225 = uint32_t(r_PtxRegister228) + uint32_t(4096);					 // PTX L452
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister225)) =
		make_uint4(r_PackedE4WordAtPtx446R226, r_PackedE4WordAtPtx446R226, r_PackedE4WordAtPtx446R226,
				   r_PackedE4WordAtPtx446R226);					// PTX L454
L__BB35_46:														// PTX L456
	r_PtxRegister23 = uint32_t(r_PtxRegister22) + uint32_t(64); // PTX L457
	r_bPtxPredicate284 = bool(0);								// PTX L458
	r_PtxRegister1952 = uint32_t(r_PtxRegister15);				// PTX L459
	if (r_bPtxPredicate19)
	{
		goto L__BB35_49;
	} // PTX L460
	r_PtxRegister235 = r_Scalar36Bits & -4;						   // PTX L461
	r_bPtxPredicate35 = uint32_t(r_PtxRegister235) == uint32_t(4); // PTX L462
	r_bPtxPredicate284 = bool(-1);								   // PTX L463
	r_PtxRegister1952 = uint32_t(0);							   // PTX L464
	if (r_bPtxPredicate35)
	{
		goto L__BB35_49;
	} // PTX L465
	r_bPtxPredicate284 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7); // PTX L466
	r_PtxRegister1952 = uint32_t(r_PtxRegister15);							 // PTX L467
L__BB35_49:																	 // PTX L468
	r_PtxU64Register307 = uint64_t(0);										 // PTX L469
	r_bPtxPredicate36 = !r_bPtxPredicate284;								 // PTX L470
	if (r_bPtxPredicate36)
	{
		goto L__BB35_51;
	} // PTX L471
	r_PtxRegister236 = uint32_t(r_PtxRegister17) + uint32_t(r_PtxRegister1952); // PTX L472
	r_PtxRegister237 = ShiftRight(uint32_t(r_PtxRegister23), uint32_t(5));		// PTX L473
	r_PtxRegister238 = uint32_t(r_PtxRegister237) + uint32_t(r_PtxRegister11);	// PTX L474
	r_PtxRegister239 = ShiftLeft(uint32_t(r_PtxRegister236), uint32_t(11));		// PTX L475
	r_PtxRegister240 = ShiftLeft(uint32_t(r_PtxRegister238), uint32_t(7));		// PTX L476
	r_PtxRegister241 = uint32_t(r_PtxRegister239) + uint32_t(r_PtxRegister240); // PTX L477
	r_PtxU64Register307 = SignExtendWordBits(r_PtxRegister241);					// PTX L478
L__BB35_51:																		// PTX L479
	r_PtxU64Register308 = uint64_t(0);											// PTX L480
	if (r_bPtxPredicate36)
	{
		goto L__BB35_53;
	} // PTX L481
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register307), uint32_t(2));	   // PTX L482
	r_PtxU64Register308 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register39); // PTX L483
L__BB35_53:																		   // PTX L484
	if (r_bPtxPredicate36)
	{
		goto L__BB35_56;
	} // PTX L485
	r_PtxRegister250 = uint32_t(-1);							   // PTX L486
	r_PtxRegister249 = Elected(r_PtxRegister250);				   // PTX L488
	r_bPtxPredicate37 = uint32_t(r_PtxRegister249) == uint32_t(0); // PTX L494
	if (r_bPtxPredicate37)
	{
		goto L__BB35_57;
	} // PTX L495
	r_PtxRegister251 = uint32_t(r_PtxRegister18) + uint32_t(8192);				 // PTX L496
	r_PtxU64Register40 = r_PtxU64Register308;									 // PTX L497
	r_PtxRegister254 = uint32_t(12288u /* exact native shared-region offset */); // PTX L498
	r_PtxRegister253 = uint32_t(r_PtxRegister254) + uint32_t(16);				 // PTX L499
	r_PtxRegister252 = uint32_t(512);											 // PTX L500
	CopyBulk(s_SharedStorage, r_PtxRegister251, r_PtxU64Register40, r_PtxRegister252,
			 r_PtxRegister253);																   // PTX L502
	BarrierExpect(s_SharedStorage, r_PtxRegister253, r_PtxRegister252);						   // PTX L505
	goto L__BB35_57;																		   // PTX L507
L__BB35_56:																					   // PTX L508
	r_PtxRegister242 = uint32_t(0);															   // PTX L509
	r_PtxU16Register73 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister242))); // PTX L511
	r_PackedHalf2AtPtx514R243 = JoinHalfwords(r_PtxU16Register73, r_PtxU16Register73);		   // PTX L514
	r_ConvertedE4PairAtPtx516Rs74 = PublishE4(r_PackedHalf2AtPtx514R243);					   // PTX L516
	r_PackedE4WordAtPtx518R246 =
		JoinHalfwords(r_ConvertedE4PairAtPtx516Rs74, r_ConvertedE4PairAtPtx516Rs74); // PTX L518
	r_LaneIndexAtPtx520 = uint32_t((threadIdx.x & 31u));							 // PTX L520
	r_PtxRegister247 = ShiftLeft(uint32_t(r_LaneIndexAtPtx520), uint32_t(4));		 // PTX L522
	r_PtxRegister248 = uint32_t(r_PtxRegister18) + uint32_t(r_PtxRegister247);		 // PTX L523
	r_PtxRegister245 = uint32_t(r_PtxRegister248) + uint32_t(8192);					 // PTX L524
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister245)) =
		make_uint4(r_PackedE4WordAtPtx518R246, r_PackedE4WordAtPtx518R246, r_PackedE4WordAtPtx518R246,
				   r_PackedE4WordAtPtx518R246);	   // PTX L526
L__BB35_57:										   // PTX L528
	r_bPtxPredicate285 = bool(0);				   // PTX L529
	r_PtxRegister1953 = uint32_t(r_PtxRegister15); // PTX L530
	if (r_bPtxPredicate25)
	{
		goto L__BB35_60;
	} // PTX L531
	r_PtxRegister255 = r_Scalar36Bits & -4;						   // PTX L532
	r_bPtxPredicate38 = uint32_t(r_PtxRegister255) == uint32_t(4); // PTX L533
	r_bPtxPredicate285 = bool(-1);								   // PTX L534
	r_PtxRegister1953 = uint32_t(0);							   // PTX L535
	if (r_bPtxPredicate38)
	{
		goto L__BB35_60;
	} // PTX L536
	r_bPtxPredicate285 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7); // PTX L537
	r_PtxRegister1953 = uint32_t(r_PtxRegister15);							 // PTX L538
L__BB35_60:																	 // PTX L539
	r_PtxU64Register309 = uint64_t(0);										 // PTX L540
	r_bPtxPredicate39 = !r_bPtxPredicate285;								 // PTX L541
	if (r_bPtxPredicate39)
	{
		goto L__BB35_62;
	} // PTX L542
	r_PtxRegister256 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister1953); // PTX L543
	r_PtxRegister257 = ShiftRight(uint32_t(r_PtxRegister23), uint32_t(5));		// PTX L544
	r_PtxRegister258 = uint32_t(r_PtxRegister257) + uint32_t(r_PtxRegister11);	// PTX L545
	r_PtxRegister259 = ShiftLeft(uint32_t(r_PtxRegister256), uint32_t(11));		// PTX L546
	r_PtxRegister260 = ShiftLeft(uint32_t(r_PtxRegister258), uint32_t(7));		// PTX L547
	r_PtxRegister261 = uint32_t(r_PtxRegister259) + uint32_t(r_PtxRegister260); // PTX L548
	r_PtxU64Register309 = SignExtendWordBits(r_PtxRegister261);					// PTX L549
L__BB35_62:																		// PTX L550
	r_PtxU64Register310 = uint64_t(0);											// PTX L551
	if (r_bPtxPredicate39)
	{
		goto L__BB35_64;
	} // PTX L552
	r_PtxU64Register41 = ShiftLeft(uint64_t(r_PtxU64Register309), uint32_t(2));	   // PTX L553
	r_PtxU64Register310 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register41); // PTX L554
L__BB35_64:																		   // PTX L555
	if (r_bPtxPredicate39)
	{
		goto L__BB35_67;
	} // PTX L556
	r_PtxRegister270 = uint32_t(-1);							   // PTX L557
	r_PtxRegister269 = Elected(r_PtxRegister270);				   // PTX L559
	r_bPtxPredicate40 = uint32_t(r_PtxRegister269) == uint32_t(0); // PTX L565
	if (r_bPtxPredicate40)
	{
		goto L__BB35_68;
	} // PTX L566
	r_PtxRegister271 = uint32_t(r_PtxRegister21) + uint32_t(8192);				 // PTX L567
	r_PtxU64Register42 = r_PtxU64Register310;									 // PTX L568
	r_PtxRegister274 = uint32_t(12288u /* exact native shared-region offset */); // PTX L569
	r_PtxRegister273 = uint32_t(r_PtxRegister274) + uint32_t(16);				 // PTX L570
	r_PtxRegister272 = uint32_t(512);											 // PTX L571
	CopyBulk(s_SharedStorage, r_PtxRegister271, r_PtxU64Register42, r_PtxRegister272,
			 r_PtxRegister273);																   // PTX L573
	BarrierExpect(s_SharedStorage, r_PtxRegister273, r_PtxRegister272);						   // PTX L576
	goto L__BB35_68;																		   // PTX L578
L__BB35_67:																					   // PTX L579
	r_PtxRegister262 = uint32_t(0);															   // PTX L580
	r_PtxU16Register75 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister262))); // PTX L582
	r_PackedHalf2AtPtx585R263 = JoinHalfwords(r_PtxU16Register75, r_PtxU16Register75);		   // PTX L585
	r_ConvertedE4PairAtPtx587Rs76 = PublishE4(r_PackedHalf2AtPtx585R263);					   // PTX L587
	r_PackedE4WordAtPtx589R266 =
		JoinHalfwords(r_ConvertedE4PairAtPtx587Rs76, r_ConvertedE4PairAtPtx587Rs76); // PTX L589
	r_LaneIndexAtPtx591 = uint32_t((threadIdx.x & 31u));							 // PTX L591
	r_PtxRegister267 = ShiftLeft(uint32_t(r_LaneIndexAtPtx591), uint32_t(4));		 // PTX L593
	r_PtxRegister268 = uint32_t(r_PtxRegister21) + uint32_t(r_PtxRegister267);		 // PTX L594
	r_PtxRegister265 = uint32_t(r_PtxRegister268) + uint32_t(8192);					 // PTX L595
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister265)) =
		make_uint4(r_PackedE4WordAtPtx589R266, r_PackedE4WordAtPtx589R266, r_PackedE4WordAtPtx589R266,
				   r_PackedE4WordAtPtx589R266);									 // PTX L597
L__BB35_68:																		 // PTX L599
	r_PtxRegister275 = uint32_t(12288u /* exact native shared-region offset */); // PTX L600
	r_PtxRegister276 = uint32_t(1);												 // PTX L601
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register43 = BarrierArrive(s_SharedStorage, r_PtxRegister275, r_PtxRegister276); // PTX L603
L__BB35_69:																					 // PTX L605
	r_PtxRegister278 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L606
	r_PtxRegister277 = BarrierReady(s_SharedStorage, r_PtxRegister278, r_PtxU64Register43);	 // PTX L608
	r_bPtxPredicate41 = uint32_t(r_PtxRegister277) == uint32_t(0);							 // PTX L614
	if (r_bPtxPredicate41)
	{
		goto L__BB35_69;
	} // PTX L615
	r_bPtxPredicate3 = uint32_t(r_PtxRegister16) != uint32_t(4);			// PTX L616
	r_bPtxPredicate42 = uint32_t(r_PtxRegister16) == uint32_t(4);			// PTX L617
	r_PtxRegister24 = r_Scalar36Bits & -4;									// PTX L618
	r_bPtxPredicate43 = uint32_t(r_PtxRegister24) == uint32_t(4);			// PTX L619
	r_bPtxPredicate44 = int32_t(r_PtxRegister3) < int32_t(r_PtxRegister6);	// PTX L620
	r_bPtxPredicate45 = int32_t(r_PtxRegister3) >= int32_t(r_PtxRegister6); // PTX L621
	r_PtxRegister25 = uint32_t(r_PtxRegister3) * uint32_t(r_PtxRegister7);	// PTX L622
	r_PtxRegister26 = r_bPtxPredicate42 ? 0 : r_PtxRegister25;				// PTX L623
	r_bPtxPredicate46 = r_bPtxPredicate3 & r_bPtxPredicate45;				// PTX L624
	r_bPtxPredicate4 = r_bPtxPredicate42 | r_bPtxPredicate44;				// PTX L625
	r_bPtxPredicate5 = r_bPtxPredicate46 | r_bPtxPredicate43;				// PTX L626
	r_bPtxPredicate47 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);	// PTX L627
	r_bPtxPredicate48 = !r_bPtxPredicate46;									// PTX L628
	r_bPtxPredicate6 = r_bPtxPredicate43 & r_bPtxPredicate48;				// PTX L629
	r_PtxRegister27 = r_bPtxPredicate6 ? 0 : r_PtxRegister5;				// PTX L630
	r_bPtxPredicate49 = r_bPtxPredicate5 | r_bPtxPredicate47;				// PTX L631
	r_bPtxPredicate7 = r_bPtxPredicate49 & r_bPtxPredicate4;				// PTX L632
	if (r_bPtxPredicate7)
	{
		goto L__BB35_72;
	} // PTX L633
	goto L__BB35_71;																			 // PTX L634
L__BB35_72:																						 // PTX L635
	r_PtxRegister282 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister27);					 // PTX L636
	r_PtxRegister283 = ShiftLeft(uint32_t(r_PtxRegister282), uint32_t(11));						 // PTX L637
	r_PtxRegister284 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L638
	r_PtxRegister285 = uint32_t(r_PtxRegister283) + uint32_t(r_PtxRegister284);					 // PTX L639
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_PtxRegister285)) * int64_t(int32_t(4)));	 // PTX L640
	r_PtxU64Register46 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register45);				 // PTX L641
	r_LaneIndexAtPtx643 = uint32_t((threadIdx.x & 31u));										 // PTX L643
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx643)) * int64_t(int32_t(16))); // PTX L645
	r_PtxU64Register44 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register47);			 // PTX L646
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register44));
		r_PtxRegister1954 = r_Value.x;
		r_PtxRegister1955 = r_Value.y;
		r_PtxRegister1956 = r_Value.z;
		r_PtxRegister1957 = r_Value.w;
	} // PTX L648
	goto L__BB35_73;																		   // PTX L650
L__BB35_71:																					   // PTX L651
	r_PtxRegister279 = uint32_t(0);															   // PTX L652
	r_PtxU16Register77 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister279))); // PTX L654
	r_PackedHalf2AtPtx657R280 = JoinHalfwords(r_PtxU16Register77, r_PtxU16Register77);		   // PTX L657
	r_ConvertedE4PairAtPtx659Rs78 = PublishE4(r_PackedHalf2AtPtx657R280);					   // PTX L659
	r_PtxRegister1954 =
		JoinHalfwords(r_ConvertedE4PairAtPtx659Rs78, r_ConvertedE4PairAtPtx659Rs78); // PTX L661
	r_PtxRegister1955 = uint32_t(r_PtxRegister1954);								 // PTX L662
	r_PtxRegister1956 = uint32_t(r_PtxRegister1954);								 // PTX L663
	r_PtxRegister1957 = uint32_t(r_PtxRegister1954);								 // PTX L664
L__BB35_73:																			 // PTX L665
	r_PtxU16Register93 = uint16_t(r_PtxRegister1954);
	r_PtxU16Register94 = uint16_t(r_PtxRegister1954 >> 16); // PTX L666
	r_PtxU16Register99 = uint16_t(r_PtxRegister1957);
	r_PtxU16Register100 = uint16_t(r_PtxRegister1957 >> 16); // PTX L667
	r_PtxU16Register97 = uint16_t(r_PtxRegister1956);
	r_PtxU16Register98 = uint16_t(r_PtxRegister1956 >> 16); // PTX L668
	r_PtxU16Register95 = uint16_t(r_PtxRegister1955);
	r_PtxU16Register96 = uint16_t(r_PtxRegister1955 >> 16); // PTX L669
	if (r_bPtxPredicate7)
	{
		goto L__BB35_75;
	} // PTX L670
	goto L__BB35_74;																			 // PTX L671
L__BB35_75:																						 // PTX L672
	r_PtxRegister289 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister27);					 // PTX L673
	r_PtxRegister290 = ShiftLeft(uint32_t(r_PtxRegister289), uint32_t(11));						 // PTX L674
	r_PtxRegister291 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L675
	r_PtxRegister292 = uint32_t(r_PtxRegister290) + uint32_t(r_PtxRegister291);					 // PTX L676
	r_PtxU64Register49 = uint64_t(int64_t(int32_t(r_PtxRegister292)) * int64_t(int32_t(4)));	 // PTX L677
	r_PtxU64Register50 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register49);				 // PTX L678
	r_LaneIndexAtPtx680 = uint32_t((threadIdx.x & 31u));										 // PTX L680
	r_PtxU64Register51 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx680)) * int64_t(int32_t(16))); // PTX L682
	r_PtxU64Register48 = uint64_t(r_PtxU64Register50) + uint64_t(r_PtxU64Register51);			 // PTX L683
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register48));
		r_PtxRegister1958 = r_Value.x;
		r_PtxRegister1959 = r_Value.y;
		r_PtxRegister1960 = r_Value.z;
		r_PtxRegister1961 = r_Value.w;
	} // PTX L685
	goto L__BB35_76;																		   // PTX L687
L__BB35_74:																					   // PTX L688
	r_PtxRegister286 = uint32_t(0);															   // PTX L689
	r_PtxU16Register79 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister286))); // PTX L691
	r_PackedHalf2AtPtx694R287 = JoinHalfwords(r_PtxU16Register79, r_PtxU16Register79);		   // PTX L694
	r_ConvertedE4PairAtPtx696Rs80 = PublishE4(r_PackedHalf2AtPtx694R287);					   // PTX L696
	r_PtxRegister1958 =
		JoinHalfwords(r_ConvertedE4PairAtPtx696Rs80, r_ConvertedE4PairAtPtx696Rs80); // PTX L698
	r_PtxRegister1959 = uint32_t(r_PtxRegister1958);								 // PTX L699
	r_PtxRegister1960 = uint32_t(r_PtxRegister1958);								 // PTX L700
	r_PtxRegister1961 = uint32_t(r_PtxRegister1958);								 // PTX L701
L__BB35_76:																			 // PTX L702
	r_PtxRegister28 = uint32_t(r_PtxRegister5) + uint32_t(1);						 // PTX L703
	r_PtxU16Register107 = uint16_t(r_PtxRegister1961);
	r_PtxU16Register108 = uint16_t(r_PtxRegister1961 >> 16); // PTX L704
	r_PtxU16Register105 = uint16_t(r_PtxRegister1960);
	r_PtxU16Register106 = uint16_t(r_PtxRegister1960 >> 16); // PTX L705
	r_PtxU16Register103 = uint16_t(r_PtxRegister1959);
	r_PtxU16Register104 = uint16_t(r_PtxRegister1959 >> 16); // PTX L706
	r_PtxU16Register101 = uint16_t(r_PtxRegister1958);
	r_PtxU16Register102 = uint16_t(r_PtxRegister1958 >> 16);				// PTX L707
	r_bPtxPredicate50 = int32_t(r_PtxRegister28) < int32_t(r_PtxRegister7); // PTX L708
	r_PtxRegister29 = r_bPtxPredicate6 ? 0 : r_PtxRegister28;				// PTX L709
	r_bPtxPredicate51 = r_bPtxPredicate5 | r_bPtxPredicate50;				// PTX L710
	r_bPtxPredicate8 = r_bPtxPredicate51 & r_bPtxPredicate4;				// PTX L711
	if (r_bPtxPredicate8)
	{
		goto L__BB35_78;
	} // PTX L712
	goto L__BB35_77;																			 // PTX L713
L__BB35_78:																						 // PTX L714
	r_PtxRegister296 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister29);					 // PTX L715
	r_PtxRegister297 = ShiftLeft(uint32_t(r_PtxRegister296), uint32_t(11));						 // PTX L716
	r_PtxRegister298 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L717
	r_PtxRegister299 = uint32_t(r_PtxRegister297) + uint32_t(r_PtxRegister298);					 // PTX L718
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_PtxRegister299)) * int64_t(int32_t(4)));	 // PTX L719
	r_PtxU64Register54 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register53);				 // PTX L720
	r_LaneIndexAtPtx722 = uint32_t((threadIdx.x & 31u));										 // PTX L722
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx722)) * int64_t(int32_t(16))); // PTX L724
	r_PtxU64Register52 = uint64_t(r_PtxU64Register54) + uint64_t(r_PtxU64Register55);			 // PTX L725
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register52));
		r_PtxRegister1962 = r_Value.x;
		r_PtxRegister1963 = r_Value.y;
		r_PtxRegister1964 = r_Value.z;
		r_PtxRegister1965 = r_Value.w;
	} // PTX L727
	goto L__BB35_79;																		   // PTX L729
L__BB35_77:																					   // PTX L730
	r_PtxRegister293 = uint32_t(0);															   // PTX L731
	r_PtxU16Register81 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister293))); // PTX L733
	r_PackedHalf2AtPtx736R294 = JoinHalfwords(r_PtxU16Register81, r_PtxU16Register81);		   // PTX L736
	r_ConvertedE4PairAtPtx738Rs82 = PublishE4(r_PackedHalf2AtPtx736R294);					   // PTX L738
	r_PtxRegister1962 =
		JoinHalfwords(r_ConvertedE4PairAtPtx738Rs82, r_ConvertedE4PairAtPtx738Rs82); // PTX L740
	r_PtxRegister1963 = uint32_t(r_PtxRegister1962);								 // PTX L741
	r_PtxRegister1964 = uint32_t(r_PtxRegister1962);								 // PTX L742
	r_PtxRegister1965 = uint32_t(r_PtxRegister1962);								 // PTX L743
L__BB35_79:																			 // PTX L744
	r_PtxU16Register109 = uint16_t(r_PtxRegister1962);
	r_PtxU16Register110 = uint16_t(r_PtxRegister1962 >> 16); // PTX L745
	r_PtxU16Register115 = uint16_t(r_PtxRegister1965);
	r_PtxU16Register116 = uint16_t(r_PtxRegister1965 >> 16); // PTX L746
	r_PtxU16Register113 = uint16_t(r_PtxRegister1964);
	r_PtxU16Register114 = uint16_t(r_PtxRegister1964 >> 16); // PTX L747
	r_PtxU16Register111 = uint16_t(r_PtxRegister1963);
	r_PtxU16Register112 = uint16_t(r_PtxRegister1963 >> 16); // PTX L748
	if (r_bPtxPredicate8)
	{
		goto L__BB35_81;
	} // PTX L749
	goto L__BB35_80;																			 // PTX L750
L__BB35_81:																						 // PTX L751
	r_PtxRegister303 = uint32_t(r_PtxRegister26) + uint32_t(r_PtxRegister29);					 // PTX L752
	r_PtxRegister304 = ShiftLeft(uint32_t(r_PtxRegister303), uint32_t(11));						 // PTX L753
	r_PtxRegister305 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L754
	r_PtxRegister306 = uint32_t(r_PtxRegister304) + uint32_t(r_PtxRegister305);					 // PTX L755
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_PtxRegister306)) * int64_t(int32_t(4)));	 // PTX L756
	r_PtxU64Register58 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register57);				 // PTX L757
	r_LaneIndexAtPtx759 = uint32_t((threadIdx.x & 31u));										 // PTX L759
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx759)) * int64_t(int32_t(16))); // PTX L761
	r_PtxU64Register56 = uint64_t(r_PtxU64Register58) + uint64_t(r_PtxU64Register59);			 // PTX L762
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register56));
		r_PtxRegister1966 = r_Value.x;
		r_PtxRegister1967 = r_Value.y;
		r_PtxRegister1968 = r_Value.z;
		r_PtxRegister1969 = r_Value.w;
	} // PTX L764
	goto L__BB35_82;																		   // PTX L766
L__BB35_80:																					   // PTX L767
	r_PtxRegister300 = uint32_t(0);															   // PTX L768
	r_PtxU16Register83 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister300))); // PTX L770
	r_PackedHalf2AtPtx773R301 = JoinHalfwords(r_PtxU16Register83, r_PtxU16Register83);		   // PTX L773
	r_ConvertedE4PairAtPtx775Rs84 = PublishE4(r_PackedHalf2AtPtx773R301);					   // PTX L775
	r_PtxRegister1966 =
		JoinHalfwords(r_ConvertedE4PairAtPtx775Rs84, r_ConvertedE4PairAtPtx775Rs84); // PTX L777
	r_PtxRegister1967 = uint32_t(r_PtxRegister1966);								 // PTX L778
	r_PtxRegister1968 = uint32_t(r_PtxRegister1966);								 // PTX L779
	r_PtxRegister1969 = uint32_t(r_PtxRegister1966);								 // PTX L780
L__BB35_82:																			 // PTX L781
	r_bPtxPredicate52 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);			 // PTX L782
	r_PtxU16Register123 = uint16_t(r_PtxRegister1969);
	r_PtxU16Register124 = uint16_t(r_PtxRegister1969 >> 16); // PTX L783
	r_PtxU16Register121 = uint16_t(r_PtxRegister1968);
	r_PtxU16Register122 = uint16_t(r_PtxRegister1968 >> 16); // PTX L784
	r_PtxU16Register119 = uint16_t(r_PtxRegister1967);
	r_PtxU16Register120 = uint16_t(r_PtxRegister1967 >> 16); // PTX L785
	r_PtxU16Register117 = uint16_t(r_PtxRegister1966);
	r_PtxU16Register118 = uint16_t(r_PtxRegister1966 >> 16);				  // PTX L786
	r_bPtxPredicate53 = uint32_t(r_PtxRegister24) == uint32_t(4);			  // PTX L787
	r_bPtxPredicate54 = uint32_t(r_PtxRegister16) == uint32_t(4);			  // PTX L788
	r_PtxRegister307 = uint32_t(r_PtxRegister3) + uint32_t(1);				  // PTX L789
	r_bPtxPredicate55 = int32_t(r_PtxRegister307) < int32_t(r_PtxRegister6);  // PTX L790
	r_bPtxPredicate56 = int32_t(r_PtxRegister307) >= int32_t(r_PtxRegister6); // PTX L791
	r_PtxRegister308 = uint32_t(r_PtxRegister25) + uint32_t(r_PtxRegister7);  // PTX L792
	r_PtxRegister30 = r_bPtxPredicate54 ? 0 : r_PtxRegister308;				  // PTX L793
	r_bPtxPredicate57 = r_bPtxPredicate3 & r_bPtxPredicate56;				  // PTX L794
	r_bPtxPredicate9 = r_bPtxPredicate54 | r_bPtxPredicate55;				  // PTX L795
	r_bPtxPredicate10 = r_bPtxPredicate57 | r_bPtxPredicate53;				  // PTX L796
	r_bPtxPredicate58 = !r_bPtxPredicate57;									  // PTX L797
	r_bPtxPredicate11 = r_bPtxPredicate53 & r_bPtxPredicate58;				  // PTX L798
	r_PtxRegister31 = r_bPtxPredicate11 ? 0 : r_PtxRegister5;				  // PTX L799
	r_bPtxPredicate59 = r_bPtxPredicate10 | r_bPtxPredicate52;				  // PTX L800
	r_bPtxPredicate12 = r_bPtxPredicate59 & r_bPtxPredicate9;				  // PTX L801
	if (r_bPtxPredicate12)
	{
		goto L__BB35_84;
	} // PTX L802
	goto L__BB35_83;																			 // PTX L803
L__BB35_84:																						 // PTX L804
	r_PtxRegister312 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister31);					 // PTX L805
	r_PtxRegister313 = ShiftLeft(uint32_t(r_PtxRegister312), uint32_t(11));						 // PTX L806
	r_PtxRegister314 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L807
	r_PtxRegister315 = uint32_t(r_PtxRegister313) + uint32_t(r_PtxRegister314);					 // PTX L808
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_PtxRegister315)) * int64_t(int32_t(4)));	 // PTX L809
	r_PtxU64Register62 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register61);				 // PTX L810
	r_LaneIndexAtPtx812 = uint32_t((threadIdx.x & 31u));										 // PTX L812
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx812)) * int64_t(int32_t(16))); // PTX L814
	r_PtxU64Register60 = uint64_t(r_PtxU64Register62) + uint64_t(r_PtxU64Register63);			 // PTX L815
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register60));
		r_PtxRegister1970 = r_Value.x;
		r_PtxRegister1971 = r_Value.y;
		r_PtxRegister1972 = r_Value.z;
		r_PtxRegister1973 = r_Value.w;
	} // PTX L817
	goto L__BB35_85;																		   // PTX L819
L__BB35_83:																					   // PTX L820
	r_PtxRegister309 = uint32_t(0);															   // PTX L821
	r_PtxU16Register85 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister309))); // PTX L823
	r_PackedHalf2AtPtx826R310 = JoinHalfwords(r_PtxU16Register85, r_PtxU16Register85);		   // PTX L826
	r_ConvertedE4PairAtPtx828Rs86 = PublishE4(r_PackedHalf2AtPtx826R310);					   // PTX L828
	r_PtxRegister1970 =
		JoinHalfwords(r_ConvertedE4PairAtPtx828Rs86, r_ConvertedE4PairAtPtx828Rs86); // PTX L830
	r_PtxRegister1971 = uint32_t(r_PtxRegister1970);								 // PTX L831
	r_PtxRegister1972 = uint32_t(r_PtxRegister1970);								 // PTX L832
	r_PtxRegister1973 = uint32_t(r_PtxRegister1970);								 // PTX L833
L__BB35_85:																			 // PTX L834
	r_PtxU16Register125 = uint16_t(r_PtxRegister1970);
	r_PtxU16Register126 = uint16_t(r_PtxRegister1970 >> 16); // PTX L835
	r_PtxU16Register131 = uint16_t(r_PtxRegister1973);
	r_PtxU16Register132 = uint16_t(r_PtxRegister1973 >> 16); // PTX L836
	r_PtxU16Register129 = uint16_t(r_PtxRegister1972);
	r_PtxU16Register130 = uint16_t(r_PtxRegister1972 >> 16); // PTX L837
	r_PtxU16Register127 = uint16_t(r_PtxRegister1971);
	r_PtxU16Register128 = uint16_t(r_PtxRegister1971 >> 16); // PTX L838
	if (r_bPtxPredicate12)
	{
		goto L__BB35_87;
	} // PTX L839
	goto L__BB35_86;																			 // PTX L840
L__BB35_87:																						 // PTX L841
	r_PtxRegister319 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister31);					 // PTX L842
	r_PtxRegister320 = ShiftLeft(uint32_t(r_PtxRegister319), uint32_t(11));						 // PTX L843
	r_PtxRegister321 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L844
	r_PtxRegister322 = uint32_t(r_PtxRegister320) + uint32_t(r_PtxRegister321);					 // PTX L845
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_PtxRegister322)) * int64_t(int32_t(4)));	 // PTX L846
	r_PtxU64Register66 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register65);				 // PTX L847
	r_LaneIndexAtPtx849 = uint32_t((threadIdx.x & 31u));										 // PTX L849
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx849)) * int64_t(int32_t(16))); // PTX L851
	r_PtxU64Register64 = uint64_t(r_PtxU64Register66) + uint64_t(r_PtxU64Register67);			 // PTX L852
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register64));
		r_PtxRegister1974 = r_Value.x;
		r_PtxRegister1975 = r_Value.y;
		r_PtxRegister1976 = r_Value.z;
		r_PtxRegister1977 = r_Value.w;
	} // PTX L854
	goto L__BB35_88;																		   // PTX L856
L__BB35_86:																					   // PTX L857
	r_PtxRegister316 = uint32_t(0);															   // PTX L858
	r_PtxU16Register87 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister316))); // PTX L860
	r_PackedHalf2AtPtx863R317 = JoinHalfwords(r_PtxU16Register87, r_PtxU16Register87);		   // PTX L863
	r_ConvertedE4PairAtPtx865Rs88 = PublishE4(r_PackedHalf2AtPtx863R317);					   // PTX L865
	r_PtxRegister1974 =
		JoinHalfwords(r_ConvertedE4PairAtPtx865Rs88, r_ConvertedE4PairAtPtx865Rs88); // PTX L867
	r_PtxRegister1975 = uint32_t(r_PtxRegister1974);								 // PTX L868
	r_PtxRegister1976 = uint32_t(r_PtxRegister1974);								 // PTX L869
	r_PtxRegister1977 = uint32_t(r_PtxRegister1974);								 // PTX L870
L__BB35_88:																			 // PTX L871
	r_bPtxPredicate60 = int32_t(r_PtxRegister28) < int32_t(r_PtxRegister7);			 // PTX L872
	r_PtxU16Register139 = uint16_t(r_PtxRegister1977);
	r_PtxU16Register140 = uint16_t(r_PtxRegister1977 >> 16); // PTX L873
	r_PtxU16Register137 = uint16_t(r_PtxRegister1976);
	r_PtxU16Register138 = uint16_t(r_PtxRegister1976 >> 16); // PTX L874
	r_PtxU16Register135 = uint16_t(r_PtxRegister1975);
	r_PtxU16Register136 = uint16_t(r_PtxRegister1975 >> 16); // PTX L875
	r_PtxU16Register133 = uint16_t(r_PtxRegister1974);
	r_PtxU16Register134 = uint16_t(r_PtxRegister1974 >> 16);   // PTX L876
	r_PtxRegister32 = r_bPtxPredicate11 ? 0 : r_PtxRegister28; // PTX L877
	r_bPtxPredicate61 = r_bPtxPredicate10 | r_bPtxPredicate60; // PTX L878
	r_bPtxPredicate13 = r_bPtxPredicate61 & r_bPtxPredicate9;  // PTX L879
	if (r_bPtxPredicate13)
	{
		goto L__BB35_90;
	} // PTX L880
	goto L__BB35_89;																			 // PTX L881
L__BB35_90:																						 // PTX L882
	r_PtxRegister326 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);					 // PTX L883
	r_PtxRegister327 = ShiftLeft(uint32_t(r_PtxRegister326), uint32_t(11));						 // PTX L884
	r_PtxRegister328 = ShiftLeft(uint32_t(r_PtxRegister9), uint32_t(2));						 // PTX L885
	r_PtxRegister329 = uint32_t(r_PtxRegister327) + uint32_t(r_PtxRegister328);					 // PTX L886
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister329)) * int64_t(int32_t(4)));	 // PTX L887
	r_PtxU64Register70 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register69);				 // PTX L888
	r_LaneIndexAtPtx890 = uint32_t((threadIdx.x & 31u));										 // PTX L890
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx890)) * int64_t(int32_t(16))); // PTX L892
	r_PtxU64Register68 = uint64_t(r_PtxU64Register70) + uint64_t(r_PtxU64Register71);			 // PTX L893
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register68));
		r_PtxRegister1978 = r_Value.x;
		r_PtxRegister1979 = r_Value.y;
		r_PtxRegister1980 = r_Value.z;
		r_PtxRegister1981 = r_Value.w;
	} // PTX L895
	goto L__BB35_91;																		   // PTX L897
L__BB35_89:																					   // PTX L898
	r_PtxRegister323 = uint32_t(0);															   // PTX L899
	r_PtxU16Register89 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister323))); // PTX L901
	r_PackedHalf2AtPtx904R324 = JoinHalfwords(r_PtxU16Register89, r_PtxU16Register89);		   // PTX L904
	r_ConvertedE4PairAtPtx906Rs90 = PublishE4(r_PackedHalf2AtPtx904R324);					   // PTX L906
	r_PtxRegister1978 =
		JoinHalfwords(r_ConvertedE4PairAtPtx906Rs90, r_ConvertedE4PairAtPtx906Rs90); // PTX L908
	r_PtxRegister1979 = uint32_t(r_PtxRegister1978);								 // PTX L909
	r_PtxRegister1980 = uint32_t(r_PtxRegister1978);								 // PTX L910
	r_PtxRegister1981 = uint32_t(r_PtxRegister1978);								 // PTX L911
L__BB35_91:																			 // PTX L912
	r_PtxU16Register141 = uint16_t(r_PtxRegister1978);
	r_PtxU16Register142 = uint16_t(r_PtxRegister1978 >> 16); // PTX L913
	r_PtxU16Register147 = uint16_t(r_PtxRegister1981);
	r_PtxU16Register148 = uint16_t(r_PtxRegister1981 >> 16); // PTX L914
	r_PtxU16Register145 = uint16_t(r_PtxRegister1980);
	r_PtxU16Register146 = uint16_t(r_PtxRegister1980 >> 16); // PTX L915
	r_PtxU16Register143 = uint16_t(r_PtxRegister1979);
	r_PtxU16Register144 = uint16_t(r_PtxRegister1979 >> 16); // PTX L916
	if (r_bPtxPredicate13)
	{
		goto L__BB35_93;
	} // PTX L917
	goto L__BB35_92;																			 // PTX L918
L__BB35_93:																						 // PTX L919
	r_PtxRegister333 = uint32_t(r_PtxRegister30) + uint32_t(r_PtxRegister32);					 // PTX L920
	r_PtxRegister334 = ShiftLeft(uint32_t(r_PtxRegister333), uint32_t(11));						 // PTX L921
	r_PtxRegister335 = ShiftLeft(uint32_t(r_PtxRegister10), uint32_t(2));						 // PTX L922
	r_PtxRegister336 = uint32_t(r_PtxRegister334) + uint32_t(r_PtxRegister335);					 // PTX L923
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_PtxRegister336)) * int64_t(int32_t(4)));	 // PTX L924
	r_PtxU64Register74 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register73);				 // PTX L925
	r_LaneIndexAtPtx927 = uint32_t((threadIdx.x & 31u));										 // PTX L927
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx927)) * int64_t(int32_t(16))); // PTX L929
	r_PtxU64Register72 = uint64_t(r_PtxU64Register74) + uint64_t(r_PtxU64Register75);			 // PTX L930
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register72));
		r_PtxRegister1982 = r_Value.x;
		r_PtxRegister1983 = r_Value.y;
		r_PtxRegister1984 = r_Value.z;
		r_PtxRegister1985 = r_Value.w;
	} // PTX L932
	goto L__BB35_94;																		   // PTX L934
L__BB35_92:																					   // PTX L935
	r_PtxRegister330 = uint32_t(0);															   // PTX L936
	r_PtxU16Register91 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister330))); // PTX L938
	r_PackedHalf2AtPtx941R331 = JoinHalfwords(r_PtxU16Register91, r_PtxU16Register91);		   // PTX L941
	r_ConvertedE4PairAtPtx943Rs92 = PublishE4(r_PackedHalf2AtPtx941R331);					   // PTX L943
	r_PtxRegister1982 =
		JoinHalfwords(r_ConvertedE4PairAtPtx943Rs92, r_ConvertedE4PairAtPtx943Rs92); // PTX L945
	r_PtxRegister1983 = uint32_t(r_PtxRegister1982);								 // PTX L946
	r_PtxRegister1984 = uint32_t(r_PtxRegister1982);								 // PTX L947
	r_PtxRegister1985 = uint32_t(r_PtxRegister1982);								 // PTX L948
L__BB35_94:																			 // PTX L949
	r_PackedHalf2AtPtx951R402 = DecodeE4(r_PtxU16Register93);						 // PTX L951
	r_PackedHalf2AtPtx954R408 = DecodeE4(r_PtxU16Register94);						 // PTX L954
	r_PackedHalf2AtPtx957R405 = DecodeE4(r_PtxU16Register95);						 // PTX L957
	r_PackedHalf2AtPtx960R411 = DecodeE4(r_PtxU16Register96);						 // PTX L960
	r_PackedHalf2AtPtx963R414 = DecodeE4(r_PtxU16Register97);						 // PTX L963
	r_PackedHalf2AtPtx966R420 = DecodeE4(r_PtxU16Register98);						 // PTX L966
	r_PackedHalf2AtPtx969R417 = DecodeE4(r_PtxU16Register99);						 // PTX L969
	r_PackedHalf2AtPtx972R423 = DecodeE4(r_PtxU16Register100);						 // PTX L972
	r_PackedHalf2AtPtx975R426 = DecodeE4(r_PtxU16Register101);						 // PTX L975
	r_PackedHalf2AtPtx978R432 = DecodeE4(r_PtxU16Register102);						 // PTX L978
	r_PackedHalf2AtPtx981R429 = DecodeE4(r_PtxU16Register103);						 // PTX L981
	r_PackedHalf2AtPtx984R435 = DecodeE4(r_PtxU16Register104);						 // PTX L984
	r_PackedHalf2AtPtx987R438 = DecodeE4(r_PtxU16Register105);						 // PTX L987
	r_PackedHalf2AtPtx990R444 = DecodeE4(r_PtxU16Register106);						 // PTX L990
	r_PackedHalf2AtPtx993R441 = DecodeE4(r_PtxU16Register107);						 // PTX L993
	r_PackedHalf2AtPtx996R447 = DecodeE4(r_PtxU16Register108);						 // PTX L996
	r_PackedHalf2AtPtx999R450 = DecodeE4(r_PtxU16Register109);						 // PTX L999
	r_PackedHalf2AtPtx1002R456 = DecodeE4(r_PtxU16Register110);						 // PTX L1002
	r_PackedHalf2AtPtx1005R453 = DecodeE4(r_PtxU16Register111);						 // PTX L1005
	r_PackedHalf2AtPtx1008R459 = DecodeE4(r_PtxU16Register112);						 // PTX L1008
	r_PackedHalf2AtPtx1011R462 = DecodeE4(r_PtxU16Register113);						 // PTX L1011
	r_PackedHalf2AtPtx1014R468 = DecodeE4(r_PtxU16Register114);						 // PTX L1014
	r_PackedHalf2AtPtx1017R465 = DecodeE4(r_PtxU16Register115);						 // PTX L1017
	r_PackedHalf2AtPtx1020R471 = DecodeE4(r_PtxU16Register116);						 // PTX L1020
	r_PackedHalf2AtPtx1023R474 = DecodeE4(r_PtxU16Register117);						 // PTX L1023
	r_PackedHalf2AtPtx1026R480 = DecodeE4(r_PtxU16Register118);						 // PTX L1026
	r_PackedHalf2AtPtx1029R477 = DecodeE4(r_PtxU16Register119);						 // PTX L1029
	r_PackedHalf2AtPtx1032R483 = DecodeE4(r_PtxU16Register120);						 // PTX L1032
	r_PackedHalf2AtPtx1035R486 = DecodeE4(r_PtxU16Register121);						 // PTX L1035
	r_PackedHalf2AtPtx1038R492 = DecodeE4(r_PtxU16Register122);						 // PTX L1038
	r_PackedHalf2AtPtx1041R489 = DecodeE4(r_PtxU16Register123);						 // PTX L1041
	r_PackedHalf2AtPtx1044R495 = DecodeE4(r_PtxU16Register124);						 // PTX L1044
	r_PackedHalf2AtPtx1047R498 = DecodeE4(r_PtxU16Register125);						 // PTX L1047
	r_PackedHalf2AtPtx1050R504 = DecodeE4(r_PtxU16Register126);						 // PTX L1050
	r_PackedHalf2AtPtx1053R501 = DecodeE4(r_PtxU16Register127);						 // PTX L1053
	r_PackedHalf2AtPtx1056R507 = DecodeE4(r_PtxU16Register128);						 // PTX L1056
	r_PackedHalf2AtPtx1059R510 = DecodeE4(r_PtxU16Register129);						 // PTX L1059
	r_PackedHalf2AtPtx1062R516 = DecodeE4(r_PtxU16Register130);						 // PTX L1062
	r_PackedHalf2AtPtx1065R513 = DecodeE4(r_PtxU16Register131);						 // PTX L1065
	r_PackedHalf2AtPtx1068R519 = DecodeE4(r_PtxU16Register132);						 // PTX L1068
	r_PackedHalf2AtPtx1071R522 = DecodeE4(r_PtxU16Register133);						 // PTX L1071
	r_PackedHalf2AtPtx1074R528 = DecodeE4(r_PtxU16Register134);						 // PTX L1074
	r_PackedHalf2AtPtx1077R525 = DecodeE4(r_PtxU16Register135);						 // PTX L1077
	r_PackedHalf2AtPtx1080R531 = DecodeE4(r_PtxU16Register136);						 // PTX L1080
	r_PackedHalf2AtPtx1083R534 = DecodeE4(r_PtxU16Register137);						 // PTX L1083
	r_PackedHalf2AtPtx1086R540 = DecodeE4(r_PtxU16Register138);						 // PTX L1086
	r_PackedHalf2AtPtx1089R537 = DecodeE4(r_PtxU16Register139);						 // PTX L1089
	r_PackedHalf2AtPtx1092R543 = DecodeE4(r_PtxU16Register140);						 // PTX L1092
	r_PackedHalf2AtPtx1095R546 = DecodeE4(r_PtxU16Register141);						 // PTX L1095
	r_PackedHalf2AtPtx1098R552 = DecodeE4(r_PtxU16Register142);						 // PTX L1098
	r_PackedHalf2AtPtx1101R549 = DecodeE4(r_PtxU16Register143);						 // PTX L1101
	r_PackedHalf2AtPtx1104R555 = DecodeE4(r_PtxU16Register144);						 // PTX L1104
	r_PackedHalf2AtPtx1107R558 = DecodeE4(r_PtxU16Register145);						 // PTX L1107
	r_PackedHalf2AtPtx1110R564 = DecodeE4(r_PtxU16Register146);						 // PTX L1110
	r_PackedHalf2AtPtx1113R561 = DecodeE4(r_PtxU16Register147);						 // PTX L1113
	r_PackedHalf2AtPtx1116R567 = DecodeE4(r_PtxU16Register148);						 // PTX L1116
	r_PtxU16Register149 = uint16_t(r_PtxRegister1982);
	r_PtxU16Register150 = uint16_t(r_PtxRegister1982 >> 16);	// PTX L1118
	r_PackedHalf2AtPtx1120R570 = DecodeE4(r_PtxU16Register149); // PTX L1120
	r_PackedHalf2AtPtx1123R576 = DecodeE4(r_PtxU16Register150); // PTX L1123
	r_PtxU16Register151 = uint16_t(r_PtxRegister1983);
	r_PtxU16Register152 = uint16_t(r_PtxRegister1983 >> 16);	// PTX L1125
	r_PackedHalf2AtPtx1127R573 = DecodeE4(r_PtxU16Register151); // PTX L1127
	r_PackedHalf2AtPtx1130R579 = DecodeE4(r_PtxU16Register152); // PTX L1130
	r_PtxU16Register153 = uint16_t(r_PtxRegister1984);
	r_PtxU16Register154 = uint16_t(r_PtxRegister1984 >> 16);	// PTX L1132
	r_PackedHalf2AtPtx1134R582 = DecodeE4(r_PtxU16Register153); // PTX L1134
	r_PackedHalf2AtPtx1137R588 = DecodeE4(r_PtxU16Register154); // PTX L1137
	r_PtxU16Register155 = uint16_t(r_PtxRegister1985);
	r_PtxU16Register156 = uint16_t(r_PtxRegister1985 >> 16);								   // PTX L1139
	r_PackedHalf2AtPtx1141R585 = DecodeE4(r_PtxU16Register155);								   // PTX L1141
	r_PackedHalf2AtPtx1144R591 = DecodeE4(r_PtxU16Register156);								   // PTX L1144
	r_PtxU64Register76 = r_Pointer24Bits;													   // PTX L1146
	r_PtxRegister593 = r_PtxRegister9 | 16;													   // PTX L1147
	r_PtxRegister594 = r_PtxRegister9 | 8;													   // PTX L1148
	r_LaneIndexAtPtx1150 = uint32_t((threadIdx.x & 31u));									   // PTX L1150
	r_PtxRegister595 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1150), uint32_t(31));		   // PTX L1152
	r_PtxRegister596 = ShiftRight(uint32_t(r_PtxRegister595), uint32_t(30));				   // PTX L1153
	r_PtxRegister597 = uint32_t(r_LaneIndexAtPtx1150) + uint32_t(r_PtxRegister596);			   // PTX L1154
	r_PtxRegister598 = r_PtxRegister597 & 2147483644;										   // PTX L1155
	r_PtxRegister599 = uint32_t(r_LaneIndexAtPtx1150) - uint32_t(r_PtxRegister598);			   // PTX L1156
	r_PtxRegister600 = ShiftLeft(uint32_t(r_PtxRegister599), uint32_t(1));					   // PTX L1157
	r_PtxRegister601 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister600);				   // PTX L1158
	r_PtxRegister602 = ShiftRightSigned(int32_t(r_PtxRegister601), uint32_t(1));			   // PTX L1159
	r_PtxU64Register77 = uint64_t(int64_t(int32_t(r_PtxRegister602)) * int64_t(int32_t(4)));   // PTX L1160
	r_PtxU64Register78 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register77);		   // PTX L1161
	r_PtxRegister403 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register78 + 262144ull);	   // PTX L1162
	r_LaneIndexAtPtx1164 = uint32_t((threadIdx.x & 31u));									   // PTX L1164
	r_PtxRegister603 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1164), uint32_t(31));		   // PTX L1166
	r_PtxRegister604 = ShiftRight(uint32_t(r_PtxRegister603), uint32_t(30));				   // PTX L1167
	r_PtxRegister605 = uint32_t(r_LaneIndexAtPtx1164) + uint32_t(r_PtxRegister604);			   // PTX L1168
	r_PtxRegister606 = r_PtxRegister605 & 2147483644;										   // PTX L1169
	r_PtxRegister607 = uint32_t(r_LaneIndexAtPtx1164) - uint32_t(r_PtxRegister606);			   // PTX L1170
	r_PtxRegister608 = ShiftLeft(uint32_t(r_PtxRegister607), uint32_t(1));					   // PTX L1171
	r_PtxRegister609 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister608);				   // PTX L1172
	r_PtxRegister610 = ShiftRightSigned(int32_t(r_PtxRegister609), uint32_t(1));			   // PTX L1173
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_PtxRegister610)) * int64_t(int32_t(4)));   // PTX L1174
	r_PtxU64Register80 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register79);		   // PTX L1175
	r_PtxRegister406 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register80 + 262144ull);	   // PTX L1176
	r_LaneIndexAtPtx1178 = uint32_t((threadIdx.x & 31u));									   // PTX L1178
	r_PtxRegister611 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1178), uint32_t(31));		   // PTX L1180
	r_PtxRegister612 = ShiftRight(uint32_t(r_PtxRegister611), uint32_t(30));				   // PTX L1181
	r_PtxRegister613 = uint32_t(r_LaneIndexAtPtx1178) + uint32_t(r_PtxRegister612);			   // PTX L1182
	r_PtxRegister614 = r_PtxRegister613 & 2147483644;										   // PTX L1183
	r_PtxRegister615 = uint32_t(r_LaneIndexAtPtx1178) - uint32_t(r_PtxRegister614);			   // PTX L1184
	r_PtxRegister616 = ShiftLeft(uint32_t(r_PtxRegister615), uint32_t(1));					   // PTX L1185
	r_PtxRegister617 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister616);				   // PTX L1186
	r_PtxRegister618 = ShiftRightSigned(int32_t(r_PtxRegister617), uint32_t(1));			   // PTX L1187
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_PtxRegister618)) * int64_t(int32_t(4)));   // PTX L1188
	r_PtxU64Register82 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register81);		   // PTX L1189
	r_PtxRegister409 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register82 + 262144ull);	   // PTX L1190
	r_LaneIndexAtPtx1192 = uint32_t((threadIdx.x & 31u));									   // PTX L1192
	r_PtxRegister619 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1192), uint32_t(31));		   // PTX L1194
	r_PtxRegister620 = ShiftRight(uint32_t(r_PtxRegister619), uint32_t(30));				   // PTX L1195
	r_PtxRegister621 = uint32_t(r_LaneIndexAtPtx1192) + uint32_t(r_PtxRegister620);			   // PTX L1196
	r_PtxRegister622 = r_PtxRegister621 & 2147483644;										   // PTX L1197
	r_PtxRegister623 = uint32_t(r_LaneIndexAtPtx1192) - uint32_t(r_PtxRegister622);			   // PTX L1198
	r_PtxRegister624 = ShiftLeft(uint32_t(r_PtxRegister623), uint32_t(1));					   // PTX L1199
	r_PtxRegister625 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister624);				   // PTX L1200
	r_PtxRegister626 = ShiftRightSigned(int32_t(r_PtxRegister625), uint32_t(1));			   // PTX L1201
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_PtxRegister626)) * int64_t(int32_t(4)));   // PTX L1202
	r_PtxU64Register84 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register83);		   // PTX L1203
	r_PtxRegister412 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register84 + 262144ull);	   // PTX L1204
	r_LaneIndexAtPtx1206 = uint32_t((threadIdx.x & 31u));									   // PTX L1206
	r_PtxRegister627 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1206), uint32_t(31));		   // PTX L1208
	r_PtxRegister628 = ShiftRight(uint32_t(r_PtxRegister627), uint32_t(30));				   // PTX L1209
	r_PtxRegister629 = uint32_t(r_LaneIndexAtPtx1206) + uint32_t(r_PtxRegister628);			   // PTX L1210
	r_PtxRegister630 = r_PtxRegister629 & 2147483644;										   // PTX L1211
	r_PtxRegister631 = uint32_t(r_LaneIndexAtPtx1206) - uint32_t(r_PtxRegister630);			   // PTX L1212
	r_PtxRegister632 = ShiftLeft(uint32_t(r_PtxRegister631), uint32_t(1));					   // PTX L1213
	r_PtxRegister633 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister632);				   // PTX L1214
	r_PtxRegister634 = ShiftRightSigned(int32_t(r_PtxRegister633), uint32_t(1));			   // PTX L1215
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_PtxRegister634)) * int64_t(int32_t(4)));   // PTX L1216
	r_PtxU64Register86 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register85);		   // PTX L1217
	r_PtxRegister415 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register86 + 262144ull);	   // PTX L1218
	r_LaneIndexAtPtx1220 = uint32_t((threadIdx.x & 31u));									   // PTX L1220
	r_PtxRegister635 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1220), uint32_t(31));		   // PTX L1222
	r_PtxRegister636 = ShiftRight(uint32_t(r_PtxRegister635), uint32_t(30));				   // PTX L1223
	r_PtxRegister637 = uint32_t(r_LaneIndexAtPtx1220) + uint32_t(r_PtxRegister636);			   // PTX L1224
	r_PtxRegister638 = r_PtxRegister637 & 2147483644;										   // PTX L1225
	r_PtxRegister639 = uint32_t(r_LaneIndexAtPtx1220) - uint32_t(r_PtxRegister638);			   // PTX L1226
	r_PtxRegister640 = ShiftLeft(uint32_t(r_PtxRegister639), uint32_t(1));					   // PTX L1227
	r_PtxRegister641 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister640);				   // PTX L1228
	r_PtxRegister642 = ShiftRightSigned(int32_t(r_PtxRegister641), uint32_t(1));			   // PTX L1229
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_PtxRegister642)) * int64_t(int32_t(4)));   // PTX L1230
	r_PtxU64Register88 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register87);		   // PTX L1231
	r_PtxRegister418 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register88 + 262144ull);	   // PTX L1232
	r_LaneIndexAtPtx1234 = uint32_t((threadIdx.x & 31u));									   // PTX L1234
	r_PtxRegister643 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1234), uint32_t(31));		   // PTX L1236
	r_PtxRegister644 = ShiftRight(uint32_t(r_PtxRegister643), uint32_t(30));				   // PTX L1237
	r_PtxRegister645 = uint32_t(r_LaneIndexAtPtx1234) + uint32_t(r_PtxRegister644);			   // PTX L1238
	r_PtxRegister646 = r_PtxRegister645 & 2147483644;										   // PTX L1239
	r_PtxRegister647 = uint32_t(r_LaneIndexAtPtx1234) - uint32_t(r_PtxRegister646);			   // PTX L1240
	r_PtxRegister648 = ShiftLeft(uint32_t(r_PtxRegister647), uint32_t(1));					   // PTX L1241
	r_PtxRegister649 = r_PtxRegister9 | 24;													   // PTX L1242
	r_PtxRegister650 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister648);				   // PTX L1243
	r_PtxRegister651 = ShiftRightSigned(int32_t(r_PtxRegister650), uint32_t(1));			   // PTX L1244
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_PtxRegister651)) * int64_t(int32_t(4)));   // PTX L1245
	r_PtxU64Register90 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register89);		   // PTX L1246
	r_PtxRegister421 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register90 + 262144ull);	   // PTX L1247
	r_LaneIndexAtPtx1249 = uint32_t((threadIdx.x & 31u));									   // PTX L1249
	r_PtxRegister652 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1249), uint32_t(31));		   // PTX L1251
	r_PtxRegister653 = ShiftRight(uint32_t(r_PtxRegister652), uint32_t(30));				   // PTX L1252
	r_PtxRegister654 = uint32_t(r_LaneIndexAtPtx1249) + uint32_t(r_PtxRegister653);			   // PTX L1253
	r_PtxRegister655 = r_PtxRegister654 & 2147483644;										   // PTX L1254
	r_PtxRegister656 = uint32_t(r_LaneIndexAtPtx1249) - uint32_t(r_PtxRegister655);			   // PTX L1255
	r_PtxRegister657 = ShiftLeft(uint32_t(r_PtxRegister656), uint32_t(1));					   // PTX L1256
	r_PtxRegister658 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister657);				   // PTX L1257
	r_PtxRegister659 = ShiftRightSigned(int32_t(r_PtxRegister658), uint32_t(1));			   // PTX L1258
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_PtxRegister659)) * int64_t(int32_t(4)));   // PTX L1259
	r_PtxU64Register92 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register91);		   // PTX L1260
	r_PtxRegister424 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register92 + 262144ull);	   // PTX L1261
	r_LaneIndexAtPtx1263 = uint32_t((threadIdx.x & 31u));									   // PTX L1263
	r_PtxRegister660 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1263), uint32_t(31));		   // PTX L1265
	r_PtxRegister661 = ShiftRight(uint32_t(r_PtxRegister660), uint32_t(30));				   // PTX L1266
	r_PtxRegister662 = uint32_t(r_LaneIndexAtPtx1263) + uint32_t(r_PtxRegister661);			   // PTX L1267
	r_PtxRegister663 = r_PtxRegister662 & 2147483644;										   // PTX L1268
	r_PtxRegister664 = uint32_t(r_LaneIndexAtPtx1263) - uint32_t(r_PtxRegister663);			   // PTX L1269
	r_PtxRegister665 = ShiftLeft(uint32_t(r_PtxRegister664), uint32_t(1));					   // PTX L1270
	r_PtxRegister666 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister665);				   // PTX L1271
	r_PtxRegister667 = ShiftRightSigned(int32_t(r_PtxRegister666), uint32_t(1));			   // PTX L1272
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_PtxRegister667)) * int64_t(int32_t(4)));   // PTX L1273
	r_PtxU64Register94 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register93);		   // PTX L1274
	r_PtxRegister427 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register94 + 262144ull);	   // PTX L1275
	r_LaneIndexAtPtx1277 = uint32_t((threadIdx.x & 31u));									   // PTX L1277
	r_PtxRegister668 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1277), uint32_t(31));		   // PTX L1279
	r_PtxRegister669 = ShiftRight(uint32_t(r_PtxRegister668), uint32_t(30));				   // PTX L1280
	r_PtxRegister670 = uint32_t(r_LaneIndexAtPtx1277) + uint32_t(r_PtxRegister669);			   // PTX L1281
	r_PtxRegister671 = r_PtxRegister670 & 2147483644;										   // PTX L1282
	r_PtxRegister672 = uint32_t(r_LaneIndexAtPtx1277) - uint32_t(r_PtxRegister671);			   // PTX L1283
	r_PtxRegister673 = ShiftLeft(uint32_t(r_PtxRegister672), uint32_t(1));					   // PTX L1284
	r_PtxRegister674 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister673);				   // PTX L1285
	r_PtxRegister675 = ShiftRightSigned(int32_t(r_PtxRegister674), uint32_t(1));			   // PTX L1286
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_PtxRegister675)) * int64_t(int32_t(4)));   // PTX L1287
	r_PtxU64Register96 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register95);		   // PTX L1288
	r_PtxRegister430 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register96 + 262144ull);	   // PTX L1289
	r_LaneIndexAtPtx1291 = uint32_t((threadIdx.x & 31u));									   // PTX L1291
	r_PtxRegister676 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1291), uint32_t(31));		   // PTX L1293
	r_PtxRegister677 = ShiftRight(uint32_t(r_PtxRegister676), uint32_t(30));				   // PTX L1294
	r_PtxRegister678 = uint32_t(r_LaneIndexAtPtx1291) + uint32_t(r_PtxRegister677);			   // PTX L1295
	r_PtxRegister679 = r_PtxRegister678 & 2147483644;										   // PTX L1296
	r_PtxRegister680 = uint32_t(r_LaneIndexAtPtx1291) - uint32_t(r_PtxRegister679);			   // PTX L1297
	r_PtxRegister681 = ShiftLeft(uint32_t(r_PtxRegister680), uint32_t(1));					   // PTX L1298
	r_PtxRegister682 = r_PtxRegister9 | 40;													   // PTX L1299
	r_PtxRegister683 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister681);				   // PTX L1300
	r_PtxRegister684 = ShiftRightSigned(int32_t(r_PtxRegister683), uint32_t(1));			   // PTX L1301
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_PtxRegister684)) * int64_t(int32_t(4)));   // PTX L1302
	r_PtxU64Register98 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register97);		   // PTX L1303
	r_PtxRegister433 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register98 + 262144ull);	   // PTX L1304
	r_LaneIndexAtPtx1306 = uint32_t((threadIdx.x & 31u));									   // PTX L1306
	r_PtxRegister685 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1306), uint32_t(31));		   // PTX L1308
	r_PtxRegister686 = ShiftRight(uint32_t(r_PtxRegister685), uint32_t(30));				   // PTX L1309
	r_PtxRegister687 = uint32_t(r_LaneIndexAtPtx1306) + uint32_t(r_PtxRegister686);			   // PTX L1310
	r_PtxRegister688 = r_PtxRegister687 & 2147483644;										   // PTX L1311
	r_PtxRegister689 = uint32_t(r_LaneIndexAtPtx1306) - uint32_t(r_PtxRegister688);			   // PTX L1312
	r_PtxRegister690 = ShiftLeft(uint32_t(r_PtxRegister689), uint32_t(1));					   // PTX L1313
	r_PtxRegister691 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister690);				   // PTX L1314
	r_PtxRegister692 = ShiftRightSigned(int32_t(r_PtxRegister691), uint32_t(1));			   // PTX L1315
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_PtxRegister692)) * int64_t(int32_t(4)));   // PTX L1316
	r_PtxU64Register100 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register99);		   // PTX L1317
	r_PtxRegister436 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register100 + 262144ull);	   // PTX L1318
	r_LaneIndexAtPtx1320 = uint32_t((threadIdx.x & 31u));									   // PTX L1320
	r_PtxRegister693 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1320), uint32_t(31));		   // PTX L1322
	r_PtxRegister694 = ShiftRight(uint32_t(r_PtxRegister693), uint32_t(30));				   // PTX L1323
	r_PtxRegister695 = uint32_t(r_LaneIndexAtPtx1320) + uint32_t(r_PtxRegister694);			   // PTX L1324
	r_PtxRegister696 = r_PtxRegister695 & 2147483644;										   // PTX L1325
	r_PtxRegister697 = uint32_t(r_LaneIndexAtPtx1320) - uint32_t(r_PtxRegister696);			   // PTX L1326
	r_PtxRegister698 = ShiftLeft(uint32_t(r_PtxRegister697), uint32_t(1));					   // PTX L1327
	r_PtxRegister699 = r_PtxRegister9 | 48;													   // PTX L1328
	r_PtxRegister700 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister698);				   // PTX L1329
	r_PtxRegister701 = ShiftRightSigned(int32_t(r_PtxRegister700), uint32_t(1));			   // PTX L1330
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_PtxRegister701)) * int64_t(int32_t(4)));  // PTX L1331
	r_PtxU64Register102 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register101);		   // PTX L1332
	r_PtxRegister439 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register102 + 262144ull);	   // PTX L1333
	r_LaneIndexAtPtx1335 = uint32_t((threadIdx.x & 31u));									   // PTX L1335
	r_PtxRegister702 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1335), uint32_t(31));		   // PTX L1337
	r_PtxRegister703 = ShiftRight(uint32_t(r_PtxRegister702), uint32_t(30));				   // PTX L1338
	r_PtxRegister704 = uint32_t(r_LaneIndexAtPtx1335) + uint32_t(r_PtxRegister703);			   // PTX L1339
	r_PtxRegister705 = r_PtxRegister704 & 2147483644;										   // PTX L1340
	r_PtxRegister706 = uint32_t(r_LaneIndexAtPtx1335) - uint32_t(r_PtxRegister705);			   // PTX L1341
	r_PtxRegister707 = ShiftLeft(uint32_t(r_PtxRegister706), uint32_t(1));					   // PTX L1342
	r_PtxRegister708 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister707);				   // PTX L1343
	r_PtxRegister709 = ShiftRightSigned(int32_t(r_PtxRegister708), uint32_t(1));			   // PTX L1344
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_PtxRegister709)) * int64_t(int32_t(4)));  // PTX L1345
	r_PtxU64Register104 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register103);		   // PTX L1346
	r_PtxRegister442 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register104 + 262144ull);	   // PTX L1347
	r_LaneIndexAtPtx1349 = uint32_t((threadIdx.x & 31u));									   // PTX L1349
	r_PtxRegister710 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1349), uint32_t(31));		   // PTX L1351
	r_PtxRegister711 = ShiftRight(uint32_t(r_PtxRegister710), uint32_t(30));				   // PTX L1352
	r_PtxRegister712 = uint32_t(r_LaneIndexAtPtx1349) + uint32_t(r_PtxRegister711);			   // PTX L1353
	r_PtxRegister713 = r_PtxRegister712 & 2147483644;										   // PTX L1354
	r_PtxRegister714 = uint32_t(r_LaneIndexAtPtx1349) - uint32_t(r_PtxRegister713);			   // PTX L1355
	r_PtxRegister715 = ShiftLeft(uint32_t(r_PtxRegister714), uint32_t(1));					   // PTX L1356
	r_PtxRegister716 = r_PtxRegister9 | 56;													   // PTX L1357
	r_PtxRegister717 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister715);				   // PTX L1358
	r_PtxRegister718 = ShiftRightSigned(int32_t(r_PtxRegister717), uint32_t(1));			   // PTX L1359
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_PtxRegister718)) * int64_t(int32_t(4)));  // PTX L1360
	r_PtxU64Register106 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register105);		   // PTX L1361
	r_PtxRegister445 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register106 + 262144ull);	   // PTX L1362
	r_LaneIndexAtPtx1364 = uint32_t((threadIdx.x & 31u));									   // PTX L1364
	r_PtxRegister719 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1364), uint32_t(31));		   // PTX L1366
	r_PtxRegister720 = ShiftRight(uint32_t(r_PtxRegister719), uint32_t(30));				   // PTX L1367
	r_PtxRegister721 = uint32_t(r_LaneIndexAtPtx1364) + uint32_t(r_PtxRegister720);			   // PTX L1368
	r_PtxRegister722 = r_PtxRegister721 & 2147483644;										   // PTX L1369
	r_PtxRegister723 = uint32_t(r_LaneIndexAtPtx1364) - uint32_t(r_PtxRegister722);			   // PTX L1370
	r_PtxRegister724 = ShiftLeft(uint32_t(r_PtxRegister723), uint32_t(1));					   // PTX L1371
	r_PtxRegister725 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister724);				   // PTX L1372
	r_PtxRegister726 = ShiftRightSigned(int32_t(r_PtxRegister725), uint32_t(1));			   // PTX L1373
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_PtxRegister726)) * int64_t(int32_t(4)));  // PTX L1374
	r_PtxU64Register108 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register107);		   // PTX L1375
	r_PtxRegister448 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register108 + 262144ull);	   // PTX L1376
	r_LaneIndexAtPtx1378 = uint32_t((threadIdx.x & 31u));									   // PTX L1378
	r_PtxRegister727 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1378), uint32_t(31));		   // PTX L1380
	r_PtxRegister728 = ShiftRight(uint32_t(r_PtxRegister727), uint32_t(30));				   // PTX L1381
	r_PtxRegister729 = uint32_t(r_LaneIndexAtPtx1378) + uint32_t(r_PtxRegister728);			   // PTX L1382
	r_PtxRegister730 = r_PtxRegister729 & 2147483644;										   // PTX L1383
	r_PtxRegister731 = uint32_t(r_LaneIndexAtPtx1378) - uint32_t(r_PtxRegister730);			   // PTX L1384
	r_PtxRegister732 = ShiftLeft(uint32_t(r_PtxRegister731), uint32_t(1));					   // PTX L1385
	r_PtxRegister733 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister732);				   // PTX L1386
	r_PtxRegister734 = ShiftRightSigned(int32_t(r_PtxRegister733), uint32_t(1));			   // PTX L1387
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_PtxRegister734)) * int64_t(int32_t(4)));  // PTX L1388
	r_PtxU64Register110 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register109);		   // PTX L1389
	r_PtxRegister451 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register110 + 262144ull);	   // PTX L1390
	r_LaneIndexAtPtx1392 = uint32_t((threadIdx.x & 31u));									   // PTX L1392
	r_PtxRegister735 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1392), uint32_t(31));		   // PTX L1394
	r_PtxRegister736 = ShiftRight(uint32_t(r_PtxRegister735), uint32_t(30));				   // PTX L1395
	r_PtxRegister737 = uint32_t(r_LaneIndexAtPtx1392) + uint32_t(r_PtxRegister736);			   // PTX L1396
	r_PtxRegister738 = r_PtxRegister737 & 2147483644;										   // PTX L1397
	r_PtxRegister739 = uint32_t(r_LaneIndexAtPtx1392) - uint32_t(r_PtxRegister738);			   // PTX L1398
	r_PtxRegister740 = ShiftLeft(uint32_t(r_PtxRegister739), uint32_t(1));					   // PTX L1399
	r_PtxRegister741 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister740);				   // PTX L1400
	r_PtxRegister742 = ShiftRightSigned(int32_t(r_PtxRegister741), uint32_t(1));			   // PTX L1401
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister742)) * int64_t(int32_t(4)));  // PTX L1402
	r_PtxU64Register112 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register111);		   // PTX L1403
	r_PtxRegister454 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register112 + 262144ull);	   // PTX L1404
	r_LaneIndexAtPtx1406 = uint32_t((threadIdx.x & 31u));									   // PTX L1406
	r_PtxRegister743 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1406), uint32_t(31));		   // PTX L1408
	r_PtxRegister744 = ShiftRight(uint32_t(r_PtxRegister743), uint32_t(30));				   // PTX L1409
	r_PtxRegister745 = uint32_t(r_LaneIndexAtPtx1406) + uint32_t(r_PtxRegister744);			   // PTX L1410
	r_PtxRegister746 = r_PtxRegister745 & 2147483644;										   // PTX L1411
	r_PtxRegister747 = uint32_t(r_LaneIndexAtPtx1406) - uint32_t(r_PtxRegister746);			   // PTX L1412
	r_PtxRegister748 = ShiftLeft(uint32_t(r_PtxRegister747), uint32_t(1));					   // PTX L1413
	r_PtxRegister749 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister748);				   // PTX L1414
	r_PtxRegister750 = ShiftRightSigned(int32_t(r_PtxRegister749), uint32_t(1));			   // PTX L1415
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister750)) * int64_t(int32_t(4)));  // PTX L1416
	r_PtxU64Register114 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register113);		   // PTX L1417
	r_PtxRegister457 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register114 + 262144ull);	   // PTX L1418
	r_LaneIndexAtPtx1420 = uint32_t((threadIdx.x & 31u));									   // PTX L1420
	r_PtxRegister751 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1420), uint32_t(31));		   // PTX L1422
	r_PtxRegister752 = ShiftRight(uint32_t(r_PtxRegister751), uint32_t(30));				   // PTX L1423
	r_PtxRegister753 = uint32_t(r_LaneIndexAtPtx1420) + uint32_t(r_PtxRegister752);			   // PTX L1424
	r_PtxRegister754 = r_PtxRegister753 & 2147483644;										   // PTX L1425
	r_PtxRegister755 = uint32_t(r_LaneIndexAtPtx1420) - uint32_t(r_PtxRegister754);			   // PTX L1426
	r_PtxRegister756 = ShiftLeft(uint32_t(r_PtxRegister755), uint32_t(1));					   // PTX L1427
	r_PtxRegister757 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister756);				   // PTX L1428
	r_PtxRegister758 = ShiftRightSigned(int32_t(r_PtxRegister757), uint32_t(1));			   // PTX L1429
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister758)) * int64_t(int32_t(4)));  // PTX L1430
	r_PtxU64Register116 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register115);		   // PTX L1431
	r_PtxRegister460 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register116 + 262144ull);	   // PTX L1432
	r_LaneIndexAtPtx1434 = uint32_t((threadIdx.x & 31u));									   // PTX L1434
	r_PtxRegister759 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1434), uint32_t(31));		   // PTX L1436
	r_PtxRegister760 = ShiftRight(uint32_t(r_PtxRegister759), uint32_t(30));				   // PTX L1437
	r_PtxRegister761 = uint32_t(r_LaneIndexAtPtx1434) + uint32_t(r_PtxRegister760);			   // PTX L1438
	r_PtxRegister762 = r_PtxRegister761 & 2147483644;										   // PTX L1439
	r_PtxRegister763 = uint32_t(r_LaneIndexAtPtx1434) - uint32_t(r_PtxRegister762);			   // PTX L1440
	r_PtxRegister764 = ShiftLeft(uint32_t(r_PtxRegister763), uint32_t(1));					   // PTX L1441
	r_PtxRegister765 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister764);				   // PTX L1442
	r_PtxRegister766 = ShiftRightSigned(int32_t(r_PtxRegister765), uint32_t(1));			   // PTX L1443
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister766)) * int64_t(int32_t(4)));  // PTX L1444
	r_PtxU64Register118 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register117);		   // PTX L1445
	r_PtxRegister463 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register118 + 262144ull);	   // PTX L1446
	r_LaneIndexAtPtx1448 = uint32_t((threadIdx.x & 31u));									   // PTX L1448
	r_PtxRegister767 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1448), uint32_t(31));		   // PTX L1450
	r_PtxRegister768 = ShiftRight(uint32_t(r_PtxRegister767), uint32_t(30));				   // PTX L1451
	r_PtxRegister769 = uint32_t(r_LaneIndexAtPtx1448) + uint32_t(r_PtxRegister768);			   // PTX L1452
	r_PtxRegister770 = r_PtxRegister769 & 2147483644;										   // PTX L1453
	r_PtxRegister771 = uint32_t(r_LaneIndexAtPtx1448) - uint32_t(r_PtxRegister770);			   // PTX L1454
	r_PtxRegister772 = ShiftLeft(uint32_t(r_PtxRegister771), uint32_t(1));					   // PTX L1455
	r_PtxRegister773 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister772);				   // PTX L1456
	r_PtxRegister774 = ShiftRightSigned(int32_t(r_PtxRegister773), uint32_t(1));			   // PTX L1457
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister774)) * int64_t(int32_t(4)));  // PTX L1458
	r_PtxU64Register120 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register119);		   // PTX L1459
	r_PtxRegister466 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register120 + 262144ull);	   // PTX L1460
	r_LaneIndexAtPtx1462 = uint32_t((threadIdx.x & 31u));									   // PTX L1462
	r_PtxRegister775 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1462), uint32_t(31));		   // PTX L1464
	r_PtxRegister776 = ShiftRight(uint32_t(r_PtxRegister775), uint32_t(30));				   // PTX L1465
	r_PtxRegister777 = uint32_t(r_LaneIndexAtPtx1462) + uint32_t(r_PtxRegister776);			   // PTX L1466
	r_PtxRegister778 = r_PtxRegister777 & 2147483644;										   // PTX L1467
	r_PtxRegister779 = uint32_t(r_LaneIndexAtPtx1462) - uint32_t(r_PtxRegister778);			   // PTX L1468
	r_PtxRegister780 = ShiftLeft(uint32_t(r_PtxRegister779), uint32_t(1));					   // PTX L1469
	r_PtxRegister781 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister780);				   // PTX L1470
	r_PtxRegister782 = ShiftRightSigned(int32_t(r_PtxRegister781), uint32_t(1));			   // PTX L1471
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister782)) * int64_t(int32_t(4)));  // PTX L1472
	r_PtxU64Register122 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register121);		   // PTX L1473
	r_PtxRegister469 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register122 + 262144ull);	   // PTX L1474
	r_LaneIndexAtPtx1476 = uint32_t((threadIdx.x & 31u));									   // PTX L1476
	r_PtxRegister783 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1476), uint32_t(31));		   // PTX L1478
	r_PtxRegister784 = ShiftRight(uint32_t(r_PtxRegister783), uint32_t(30));				   // PTX L1479
	r_PtxRegister785 = uint32_t(r_LaneIndexAtPtx1476) + uint32_t(r_PtxRegister784);			   // PTX L1480
	r_PtxRegister786 = r_PtxRegister785 & 2147483644;										   // PTX L1481
	r_PtxRegister787 = uint32_t(r_LaneIndexAtPtx1476) - uint32_t(r_PtxRegister786);			   // PTX L1482
	r_PtxRegister788 = ShiftLeft(uint32_t(r_PtxRegister787), uint32_t(1));					   // PTX L1483
	r_PtxRegister789 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister788);				   // PTX L1484
	r_PtxRegister790 = ShiftRightSigned(int32_t(r_PtxRegister789), uint32_t(1));			   // PTX L1485
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister790)) * int64_t(int32_t(4)));  // PTX L1486
	r_PtxU64Register124 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register123);		   // PTX L1487
	r_PtxRegister472 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register124 + 262144ull);	   // PTX L1488
	r_LaneIndexAtPtx1490 = uint32_t((threadIdx.x & 31u));									   // PTX L1490
	r_PtxRegister791 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1490), uint32_t(31));		   // PTX L1492
	r_PtxRegister792 = ShiftRight(uint32_t(r_PtxRegister791), uint32_t(30));				   // PTX L1493
	r_PtxRegister793 = uint32_t(r_LaneIndexAtPtx1490) + uint32_t(r_PtxRegister792);			   // PTX L1494
	r_PtxRegister794 = r_PtxRegister793 & 2147483644;										   // PTX L1495
	r_PtxRegister795 = uint32_t(r_LaneIndexAtPtx1490) - uint32_t(r_PtxRegister794);			   // PTX L1496
	r_PtxRegister796 = ShiftLeft(uint32_t(r_PtxRegister795), uint32_t(1));					   // PTX L1497
	r_PtxRegister797 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister796);				   // PTX L1498
	r_PtxRegister798 = ShiftRightSigned(int32_t(r_PtxRegister797), uint32_t(1));			   // PTX L1499
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister798)) * int64_t(int32_t(4)));  // PTX L1500
	r_PtxU64Register126 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register125);		   // PTX L1501
	r_PtxRegister475 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register126 + 262144ull);	   // PTX L1502
	r_LaneIndexAtPtx1504 = uint32_t((threadIdx.x & 31u));									   // PTX L1504
	r_PtxRegister799 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1504), uint32_t(31));		   // PTX L1506
	r_PtxRegister800 = ShiftRight(uint32_t(r_PtxRegister799), uint32_t(30));				   // PTX L1507
	r_PtxRegister801 = uint32_t(r_LaneIndexAtPtx1504) + uint32_t(r_PtxRegister800);			   // PTX L1508
	r_PtxRegister802 = r_PtxRegister801 & 2147483644;										   // PTX L1509
	r_PtxRegister803 = uint32_t(r_LaneIndexAtPtx1504) - uint32_t(r_PtxRegister802);			   // PTX L1510
	r_PtxRegister804 = ShiftLeft(uint32_t(r_PtxRegister803), uint32_t(1));					   // PTX L1511
	r_PtxRegister805 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister804);				   // PTX L1512
	r_PtxRegister806 = ShiftRightSigned(int32_t(r_PtxRegister805), uint32_t(1));			   // PTX L1513
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister806)) * int64_t(int32_t(4)));  // PTX L1514
	r_PtxU64Register128 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register127);		   // PTX L1515
	r_PtxRegister478 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register128 + 262144ull);	   // PTX L1516
	r_LaneIndexAtPtx1518 = uint32_t((threadIdx.x & 31u));									   // PTX L1518
	r_PtxRegister807 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1518), uint32_t(31));		   // PTX L1520
	r_PtxRegister808 = ShiftRight(uint32_t(r_PtxRegister807), uint32_t(30));				   // PTX L1521
	r_PtxRegister809 = uint32_t(r_LaneIndexAtPtx1518) + uint32_t(r_PtxRegister808);			   // PTX L1522
	r_PtxRegister810 = r_PtxRegister809 & 2147483644;										   // PTX L1523
	r_PtxRegister811 = uint32_t(r_LaneIndexAtPtx1518) - uint32_t(r_PtxRegister810);			   // PTX L1524
	r_PtxRegister812 = ShiftLeft(uint32_t(r_PtxRegister811), uint32_t(1));					   // PTX L1525
	r_PtxRegister813 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister812);				   // PTX L1526
	r_PtxRegister814 = ShiftRightSigned(int32_t(r_PtxRegister813), uint32_t(1));			   // PTX L1527
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister814)) * int64_t(int32_t(4)));  // PTX L1528
	r_PtxU64Register130 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register129);		   // PTX L1529
	r_PtxRegister481 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register130 + 262144ull);	   // PTX L1530
	r_LaneIndexAtPtx1532 = uint32_t((threadIdx.x & 31u));									   // PTX L1532
	r_PtxRegister815 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1532), uint32_t(31));		   // PTX L1534
	r_PtxRegister816 = ShiftRight(uint32_t(r_PtxRegister815), uint32_t(30));				   // PTX L1535
	r_PtxRegister817 = uint32_t(r_LaneIndexAtPtx1532) + uint32_t(r_PtxRegister816);			   // PTX L1536
	r_PtxRegister818 = r_PtxRegister817 & 2147483644;										   // PTX L1537
	r_PtxRegister819 = uint32_t(r_LaneIndexAtPtx1532) - uint32_t(r_PtxRegister818);			   // PTX L1538
	r_PtxRegister820 = ShiftLeft(uint32_t(r_PtxRegister819), uint32_t(1));					   // PTX L1539
	r_PtxRegister821 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister820);				   // PTX L1540
	r_PtxRegister822 = ShiftRightSigned(int32_t(r_PtxRegister821), uint32_t(1));			   // PTX L1541
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister822)) * int64_t(int32_t(4)));  // PTX L1542
	r_PtxU64Register132 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register131);		   // PTX L1543
	r_PtxRegister484 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register132 + 262144ull);	   // PTX L1544
	r_LaneIndexAtPtx1546 = uint32_t((threadIdx.x & 31u));									   // PTX L1546
	r_PtxRegister823 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1546), uint32_t(31));		   // PTX L1548
	r_PtxRegister824 = ShiftRight(uint32_t(r_PtxRegister823), uint32_t(30));				   // PTX L1549
	r_PtxRegister825 = uint32_t(r_LaneIndexAtPtx1546) + uint32_t(r_PtxRegister824);			   // PTX L1550
	r_PtxRegister826 = r_PtxRegister825 & 2147483644;										   // PTX L1551
	r_PtxRegister827 = uint32_t(r_LaneIndexAtPtx1546) - uint32_t(r_PtxRegister826);			   // PTX L1552
	r_PtxRegister828 = ShiftLeft(uint32_t(r_PtxRegister827), uint32_t(1));					   // PTX L1553
	r_PtxRegister829 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister828);				   // PTX L1554
	r_PtxRegister830 = ShiftRightSigned(int32_t(r_PtxRegister829), uint32_t(1));			   // PTX L1555
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister830)) * int64_t(int32_t(4)));  // PTX L1556
	r_PtxU64Register134 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register133);		   // PTX L1557
	r_PtxRegister487 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register134 + 262144ull);	   // PTX L1558
	r_LaneIndexAtPtx1560 = uint32_t((threadIdx.x & 31u));									   // PTX L1560
	r_PtxRegister831 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1560), uint32_t(31));		   // PTX L1562
	r_PtxRegister832 = ShiftRight(uint32_t(r_PtxRegister831), uint32_t(30));				   // PTX L1563
	r_PtxRegister833 = uint32_t(r_LaneIndexAtPtx1560) + uint32_t(r_PtxRegister832);			   // PTX L1564
	r_PtxRegister834 = r_PtxRegister833 & 2147483644;										   // PTX L1565
	r_PtxRegister835 = uint32_t(r_LaneIndexAtPtx1560) - uint32_t(r_PtxRegister834);			   // PTX L1566
	r_PtxRegister836 = ShiftLeft(uint32_t(r_PtxRegister835), uint32_t(1));					   // PTX L1567
	r_PtxRegister837 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister836);				   // PTX L1568
	r_PtxRegister838 = ShiftRightSigned(int32_t(r_PtxRegister837), uint32_t(1));			   // PTX L1569
	r_PtxU64Register135 = uint64_t(int64_t(int32_t(r_PtxRegister838)) * int64_t(int32_t(4)));  // PTX L1570
	r_PtxU64Register136 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register135);		   // PTX L1571
	r_PtxRegister490 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register136 + 262144ull);	   // PTX L1572
	r_LaneIndexAtPtx1574 = uint32_t((threadIdx.x & 31u));									   // PTX L1574
	r_PtxRegister839 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1574), uint32_t(31));		   // PTX L1576
	r_PtxRegister840 = ShiftRight(uint32_t(r_PtxRegister839), uint32_t(30));				   // PTX L1577
	r_PtxRegister841 = uint32_t(r_LaneIndexAtPtx1574) + uint32_t(r_PtxRegister840);			   // PTX L1578
	r_PtxRegister842 = r_PtxRegister841 & 2147483644;										   // PTX L1579
	r_PtxRegister843 = uint32_t(r_LaneIndexAtPtx1574) - uint32_t(r_PtxRegister842);			   // PTX L1580
	r_PtxRegister844 = ShiftLeft(uint32_t(r_PtxRegister843), uint32_t(1));					   // PTX L1581
	r_PtxRegister845 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister844);				   // PTX L1582
	r_PtxRegister846 = ShiftRightSigned(int32_t(r_PtxRegister845), uint32_t(1));			   // PTX L1583
	r_PtxU64Register137 = uint64_t(int64_t(int32_t(r_PtxRegister846)) * int64_t(int32_t(4)));  // PTX L1584
	r_PtxU64Register138 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register137);		   // PTX L1585
	r_PtxRegister493 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register138 + 262144ull);	   // PTX L1586
	r_LaneIndexAtPtx1588 = uint32_t((threadIdx.x & 31u));									   // PTX L1588
	r_PtxRegister847 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1588), uint32_t(31));		   // PTX L1590
	r_PtxRegister848 = ShiftRight(uint32_t(r_PtxRegister847), uint32_t(30));				   // PTX L1591
	r_PtxRegister849 = uint32_t(r_LaneIndexAtPtx1588) + uint32_t(r_PtxRegister848);			   // PTX L1592
	r_PtxRegister850 = r_PtxRegister849 & 2147483644;										   // PTX L1593
	r_PtxRegister851 = uint32_t(r_LaneIndexAtPtx1588) - uint32_t(r_PtxRegister850);			   // PTX L1594
	r_PtxRegister852 = ShiftLeft(uint32_t(r_PtxRegister851), uint32_t(1));					   // PTX L1595
	r_PtxRegister853 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister852);				   // PTX L1596
	r_PtxRegister854 = ShiftRightSigned(int32_t(r_PtxRegister853), uint32_t(1));			   // PTX L1597
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister854)) * int64_t(int32_t(4)));  // PTX L1598
	r_PtxU64Register140 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register139);		   // PTX L1599
	r_PtxRegister496 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register140 + 262144ull);	   // PTX L1600
	r_LaneIndexAtPtx1602 = uint32_t((threadIdx.x & 31u));									   // PTX L1602
	r_PtxRegister855 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1602), uint32_t(31));		   // PTX L1604
	r_PtxRegister856 = ShiftRight(uint32_t(r_PtxRegister855), uint32_t(30));				   // PTX L1605
	r_PtxRegister857 = uint32_t(r_LaneIndexAtPtx1602) + uint32_t(r_PtxRegister856);			   // PTX L1606
	r_PtxRegister858 = r_PtxRegister857 & 2147483644;										   // PTX L1607
	r_PtxRegister859 = uint32_t(r_LaneIndexAtPtx1602) - uint32_t(r_PtxRegister858);			   // PTX L1608
	r_PtxRegister860 = ShiftLeft(uint32_t(r_PtxRegister859), uint32_t(1));					   // PTX L1609
	r_PtxRegister861 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister860);				   // PTX L1610
	r_PtxRegister862 = ShiftRightSigned(int32_t(r_PtxRegister861), uint32_t(1));			   // PTX L1611
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister862)) * int64_t(int32_t(4)));  // PTX L1612
	r_PtxU64Register142 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register141);		   // PTX L1613
	r_PtxRegister499 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register142 + 262144ull);	   // PTX L1614
	r_LaneIndexAtPtx1616 = uint32_t((threadIdx.x & 31u));									   // PTX L1616
	r_PtxRegister863 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1616), uint32_t(31));		   // PTX L1618
	r_PtxRegister864 = ShiftRight(uint32_t(r_PtxRegister863), uint32_t(30));				   // PTX L1619
	r_PtxRegister865 = uint32_t(r_LaneIndexAtPtx1616) + uint32_t(r_PtxRegister864);			   // PTX L1620
	r_PtxRegister866 = r_PtxRegister865 & 2147483644;										   // PTX L1621
	r_PtxRegister867 = uint32_t(r_LaneIndexAtPtx1616) - uint32_t(r_PtxRegister866);			   // PTX L1622
	r_PtxRegister868 = ShiftLeft(uint32_t(r_PtxRegister867), uint32_t(1));					   // PTX L1623
	r_PtxRegister869 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister868);				   // PTX L1624
	r_PtxRegister870 = ShiftRightSigned(int32_t(r_PtxRegister869), uint32_t(1));			   // PTX L1625
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister870)) * int64_t(int32_t(4)));  // PTX L1626
	r_PtxU64Register144 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register143);		   // PTX L1627
	r_PtxRegister502 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register144 + 262144ull);	   // PTX L1628
	r_LaneIndexAtPtx1630 = uint32_t((threadIdx.x & 31u));									   // PTX L1630
	r_PtxRegister871 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1630), uint32_t(31));		   // PTX L1632
	r_PtxRegister872 = ShiftRight(uint32_t(r_PtxRegister871), uint32_t(30));				   // PTX L1633
	r_PtxRegister873 = uint32_t(r_LaneIndexAtPtx1630) + uint32_t(r_PtxRegister872);			   // PTX L1634
	r_PtxRegister874 = r_PtxRegister873 & 2147483644;										   // PTX L1635
	r_PtxRegister875 = uint32_t(r_LaneIndexAtPtx1630) - uint32_t(r_PtxRegister874);			   // PTX L1636
	r_PtxRegister876 = ShiftLeft(uint32_t(r_PtxRegister875), uint32_t(1));					   // PTX L1637
	r_PtxRegister877 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister876);				   // PTX L1638
	r_PtxRegister878 = ShiftRightSigned(int32_t(r_PtxRegister877), uint32_t(1));			   // PTX L1639
	r_PtxU64Register145 = uint64_t(int64_t(int32_t(r_PtxRegister878)) * int64_t(int32_t(4)));  // PTX L1640
	r_PtxU64Register146 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register145);		   // PTX L1641
	r_PtxRegister505 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register146 + 262144ull);	   // PTX L1642
	r_LaneIndexAtPtx1644 = uint32_t((threadIdx.x & 31u));									   // PTX L1644
	r_PtxRegister879 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1644), uint32_t(31));		   // PTX L1646
	r_PtxRegister880 = ShiftRight(uint32_t(r_PtxRegister879), uint32_t(30));				   // PTX L1647
	r_PtxRegister881 = uint32_t(r_LaneIndexAtPtx1644) + uint32_t(r_PtxRegister880);			   // PTX L1648
	r_PtxRegister882 = r_PtxRegister881 & 2147483644;										   // PTX L1649
	r_PtxRegister883 = uint32_t(r_LaneIndexAtPtx1644) - uint32_t(r_PtxRegister882);			   // PTX L1650
	r_PtxRegister884 = ShiftLeft(uint32_t(r_PtxRegister883), uint32_t(1));					   // PTX L1651
	r_PtxRegister885 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister884);				   // PTX L1652
	r_PtxRegister886 = ShiftRightSigned(int32_t(r_PtxRegister885), uint32_t(1));			   // PTX L1653
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister886)) * int64_t(int32_t(4)));  // PTX L1654
	r_PtxU64Register148 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register147);		   // PTX L1655
	r_PtxRegister508 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register148 + 262144ull);	   // PTX L1656
	r_LaneIndexAtPtx1658 = uint32_t((threadIdx.x & 31u));									   // PTX L1658
	r_PtxRegister887 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1658), uint32_t(31));		   // PTX L1660
	r_PtxRegister888 = ShiftRight(uint32_t(r_PtxRegister887), uint32_t(30));				   // PTX L1661
	r_PtxRegister889 = uint32_t(r_LaneIndexAtPtx1658) + uint32_t(r_PtxRegister888);			   // PTX L1662
	r_PtxRegister890 = r_PtxRegister889 & 2147483644;										   // PTX L1663
	r_PtxRegister891 = uint32_t(r_LaneIndexAtPtx1658) - uint32_t(r_PtxRegister890);			   // PTX L1664
	r_PtxRegister892 = ShiftLeft(uint32_t(r_PtxRegister891), uint32_t(1));					   // PTX L1665
	r_PtxRegister893 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister892);				   // PTX L1666
	r_PtxRegister894 = ShiftRightSigned(int32_t(r_PtxRegister893), uint32_t(1));			   // PTX L1667
	r_PtxU64Register149 = uint64_t(int64_t(int32_t(r_PtxRegister894)) * int64_t(int32_t(4)));  // PTX L1668
	r_PtxU64Register150 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register149);		   // PTX L1669
	r_PtxRegister511 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register150 + 262144ull);	   // PTX L1670
	r_LaneIndexAtPtx1672 = uint32_t((threadIdx.x & 31u));									   // PTX L1672
	r_PtxRegister895 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1672), uint32_t(31));		   // PTX L1674
	r_PtxRegister896 = ShiftRight(uint32_t(r_PtxRegister895), uint32_t(30));				   // PTX L1675
	r_PtxRegister897 = uint32_t(r_LaneIndexAtPtx1672) + uint32_t(r_PtxRegister896);			   // PTX L1676
	r_PtxRegister898 = r_PtxRegister897 & 2147483644;										   // PTX L1677
	r_PtxRegister899 = uint32_t(r_LaneIndexAtPtx1672) - uint32_t(r_PtxRegister898);			   // PTX L1678
	r_PtxRegister900 = ShiftLeft(uint32_t(r_PtxRegister899), uint32_t(1));					   // PTX L1679
	r_PtxRegister901 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister900);				   // PTX L1680
	r_PtxRegister902 = ShiftRightSigned(int32_t(r_PtxRegister901), uint32_t(1));			   // PTX L1681
	r_PtxU64Register151 = uint64_t(int64_t(int32_t(r_PtxRegister902)) * int64_t(int32_t(4)));  // PTX L1682
	r_PtxU64Register152 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register151);		   // PTX L1683
	r_PtxRegister514 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register152 + 262144ull);	   // PTX L1684
	r_LaneIndexAtPtx1686 = uint32_t((threadIdx.x & 31u));									   // PTX L1686
	r_PtxRegister903 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1686), uint32_t(31));		   // PTX L1688
	r_PtxRegister904 = ShiftRight(uint32_t(r_PtxRegister903), uint32_t(30));				   // PTX L1689
	r_PtxRegister905 = uint32_t(r_LaneIndexAtPtx1686) + uint32_t(r_PtxRegister904);			   // PTX L1690
	r_PtxRegister906 = r_PtxRegister905 & 2147483644;										   // PTX L1691
	r_PtxRegister907 = uint32_t(r_LaneIndexAtPtx1686) - uint32_t(r_PtxRegister906);			   // PTX L1692
	r_PtxRegister908 = ShiftLeft(uint32_t(r_PtxRegister907), uint32_t(1));					   // PTX L1693
	r_PtxRegister909 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister908);				   // PTX L1694
	r_PtxRegister910 = ShiftRightSigned(int32_t(r_PtxRegister909), uint32_t(1));			   // PTX L1695
	r_PtxU64Register153 = uint64_t(int64_t(int32_t(r_PtxRegister910)) * int64_t(int32_t(4)));  // PTX L1696
	r_PtxU64Register154 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register153);		   // PTX L1697
	r_PtxRegister517 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register154 + 262144ull);	   // PTX L1698
	r_LaneIndexAtPtx1700 = uint32_t((threadIdx.x & 31u));									   // PTX L1700
	r_PtxRegister911 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1700), uint32_t(31));		   // PTX L1702
	r_PtxRegister912 = ShiftRight(uint32_t(r_PtxRegister911), uint32_t(30));				   // PTX L1703
	r_PtxRegister913 = uint32_t(r_LaneIndexAtPtx1700) + uint32_t(r_PtxRegister912);			   // PTX L1704
	r_PtxRegister914 = r_PtxRegister913 & 2147483644;										   // PTX L1705
	r_PtxRegister915 = uint32_t(r_LaneIndexAtPtx1700) - uint32_t(r_PtxRegister914);			   // PTX L1706
	r_PtxRegister916 = ShiftLeft(uint32_t(r_PtxRegister915), uint32_t(1));					   // PTX L1707
	r_PtxRegister917 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister916);				   // PTX L1708
	r_PtxRegister918 = ShiftRightSigned(int32_t(r_PtxRegister917), uint32_t(1));			   // PTX L1709
	r_PtxU64Register155 = uint64_t(int64_t(int32_t(r_PtxRegister918)) * int64_t(int32_t(4)));  // PTX L1710
	r_PtxU64Register156 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register155);		   // PTX L1711
	r_PtxRegister520 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register156 + 262144ull);	   // PTX L1712
	r_LaneIndexAtPtx1714 = uint32_t((threadIdx.x & 31u));									   // PTX L1714
	r_PtxRegister919 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1714), uint32_t(31));		   // PTX L1716
	r_PtxRegister920 = ShiftRight(uint32_t(r_PtxRegister919), uint32_t(30));				   // PTX L1717
	r_PtxRegister921 = uint32_t(r_LaneIndexAtPtx1714) + uint32_t(r_PtxRegister920);			   // PTX L1718
	r_PtxRegister922 = r_PtxRegister921 & 2147483644;										   // PTX L1719
	r_PtxRegister923 = uint32_t(r_LaneIndexAtPtx1714) - uint32_t(r_PtxRegister922);			   // PTX L1720
	r_PtxRegister924 = ShiftLeft(uint32_t(r_PtxRegister923), uint32_t(1));					   // PTX L1721
	r_PtxRegister925 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister924);				   // PTX L1722
	r_PtxRegister926 = ShiftRightSigned(int32_t(r_PtxRegister925), uint32_t(1));			   // PTX L1723
	r_PtxU64Register157 = uint64_t(int64_t(int32_t(r_PtxRegister926)) * int64_t(int32_t(4)));  // PTX L1724
	r_PtxU64Register158 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register157);		   // PTX L1725
	r_PtxRegister523 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register158 + 262144ull);	   // PTX L1726
	r_LaneIndexAtPtx1728 = uint32_t((threadIdx.x & 31u));									   // PTX L1728
	r_PtxRegister927 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1728), uint32_t(31));		   // PTX L1730
	r_PtxRegister928 = ShiftRight(uint32_t(r_PtxRegister927), uint32_t(30));				   // PTX L1731
	r_PtxRegister929 = uint32_t(r_LaneIndexAtPtx1728) + uint32_t(r_PtxRegister928);			   // PTX L1732
	r_PtxRegister930 = r_PtxRegister929 & 2147483644;										   // PTX L1733
	r_PtxRegister931 = uint32_t(r_LaneIndexAtPtx1728) - uint32_t(r_PtxRegister930);			   // PTX L1734
	r_PtxRegister932 = ShiftLeft(uint32_t(r_PtxRegister931), uint32_t(1));					   // PTX L1735
	r_PtxRegister933 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister932);				   // PTX L1736
	r_PtxRegister934 = ShiftRightSigned(int32_t(r_PtxRegister933), uint32_t(1));			   // PTX L1737
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister934)) * int64_t(int32_t(4)));  // PTX L1738
	r_PtxU64Register160 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register159);		   // PTX L1739
	r_PtxRegister526 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register160 + 262144ull);	   // PTX L1740
	r_LaneIndexAtPtx1742 = uint32_t((threadIdx.x & 31u));									   // PTX L1742
	r_PtxRegister935 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1742), uint32_t(31));		   // PTX L1744
	r_PtxRegister936 = ShiftRight(uint32_t(r_PtxRegister935), uint32_t(30));				   // PTX L1745
	r_PtxRegister937 = uint32_t(r_LaneIndexAtPtx1742) + uint32_t(r_PtxRegister936);			   // PTX L1746
	r_PtxRegister938 = r_PtxRegister937 & 2147483644;										   // PTX L1747
	r_PtxRegister939 = uint32_t(r_LaneIndexAtPtx1742) - uint32_t(r_PtxRegister938);			   // PTX L1748
	r_PtxRegister940 = ShiftLeft(uint32_t(r_PtxRegister939), uint32_t(1));					   // PTX L1749
	r_PtxRegister941 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister940);				   // PTX L1750
	r_PtxRegister942 = ShiftRightSigned(int32_t(r_PtxRegister941), uint32_t(1));			   // PTX L1751
	r_PtxU64Register161 = uint64_t(int64_t(int32_t(r_PtxRegister942)) * int64_t(int32_t(4)));  // PTX L1752
	r_PtxU64Register162 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register161);		   // PTX L1753
	r_PtxRegister529 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register162 + 262144ull);	   // PTX L1754
	r_LaneIndexAtPtx1756 = uint32_t((threadIdx.x & 31u));									   // PTX L1756
	r_PtxRegister943 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1756), uint32_t(31));		   // PTX L1758
	r_PtxRegister944 = ShiftRight(uint32_t(r_PtxRegister943), uint32_t(30));				   // PTX L1759
	r_PtxRegister945 = uint32_t(r_LaneIndexAtPtx1756) + uint32_t(r_PtxRegister944);			   // PTX L1760
	r_PtxRegister946 = r_PtxRegister945 & 2147483644;										   // PTX L1761
	r_PtxRegister947 = uint32_t(r_LaneIndexAtPtx1756) - uint32_t(r_PtxRegister946);			   // PTX L1762
	r_PtxRegister948 = ShiftLeft(uint32_t(r_PtxRegister947), uint32_t(1));					   // PTX L1763
	r_PtxRegister949 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister948);				   // PTX L1764
	r_PtxRegister950 = ShiftRightSigned(int32_t(r_PtxRegister949), uint32_t(1));			   // PTX L1765
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister950)) * int64_t(int32_t(4)));  // PTX L1766
	r_PtxU64Register164 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register163);		   // PTX L1767
	r_PtxRegister532 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register164 + 262144ull);	   // PTX L1768
	r_LaneIndexAtPtx1770 = uint32_t((threadIdx.x & 31u));									   // PTX L1770
	r_PtxRegister951 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1770), uint32_t(31));		   // PTX L1772
	r_PtxRegister952 = ShiftRight(uint32_t(r_PtxRegister951), uint32_t(30));				   // PTX L1773
	r_PtxRegister953 = uint32_t(r_LaneIndexAtPtx1770) + uint32_t(r_PtxRegister952);			   // PTX L1774
	r_PtxRegister954 = r_PtxRegister953 & 2147483644;										   // PTX L1775
	r_PtxRegister955 = uint32_t(r_LaneIndexAtPtx1770) - uint32_t(r_PtxRegister954);			   // PTX L1776
	r_PtxRegister956 = ShiftLeft(uint32_t(r_PtxRegister955), uint32_t(1));					   // PTX L1777
	r_PtxRegister957 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister956);				   // PTX L1778
	r_PtxRegister958 = ShiftRightSigned(int32_t(r_PtxRegister957), uint32_t(1));			   // PTX L1779
	r_PtxU64Register165 = uint64_t(int64_t(int32_t(r_PtxRegister958)) * int64_t(int32_t(4)));  // PTX L1780
	r_PtxU64Register166 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register165);		   // PTX L1781
	r_PtxRegister535 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register166 + 262144ull);	   // PTX L1782
	r_LaneIndexAtPtx1784 = uint32_t((threadIdx.x & 31u));									   // PTX L1784
	r_PtxRegister959 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1784), uint32_t(31));		   // PTX L1786
	r_PtxRegister960 = ShiftRight(uint32_t(r_PtxRegister959), uint32_t(30));				   // PTX L1787
	r_PtxRegister961 = uint32_t(r_LaneIndexAtPtx1784) + uint32_t(r_PtxRegister960);			   // PTX L1788
	r_PtxRegister962 = r_PtxRegister961 & 2147483644;										   // PTX L1789
	r_PtxRegister963 = uint32_t(r_LaneIndexAtPtx1784) - uint32_t(r_PtxRegister962);			   // PTX L1790
	r_PtxRegister964 = ShiftLeft(uint32_t(r_PtxRegister963), uint32_t(1));					   // PTX L1791
	r_PtxRegister965 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister964);				   // PTX L1792
	r_PtxRegister966 = ShiftRightSigned(int32_t(r_PtxRegister965), uint32_t(1));			   // PTX L1793
	r_PtxU64Register167 = uint64_t(int64_t(int32_t(r_PtxRegister966)) * int64_t(int32_t(4)));  // PTX L1794
	r_PtxU64Register168 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register167);		   // PTX L1795
	r_PtxRegister538 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register168 + 262144ull);	   // PTX L1796
	r_LaneIndexAtPtx1798 = uint32_t((threadIdx.x & 31u));									   // PTX L1798
	r_PtxRegister967 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1798), uint32_t(31));		   // PTX L1800
	r_PtxRegister968 = ShiftRight(uint32_t(r_PtxRegister967), uint32_t(30));				   // PTX L1801
	r_PtxRegister969 = uint32_t(r_LaneIndexAtPtx1798) + uint32_t(r_PtxRegister968);			   // PTX L1802
	r_PtxRegister970 = r_PtxRegister969 & 2147483644;										   // PTX L1803
	r_PtxRegister971 = uint32_t(r_LaneIndexAtPtx1798) - uint32_t(r_PtxRegister970);			   // PTX L1804
	r_PtxRegister972 = ShiftLeft(uint32_t(r_PtxRegister971), uint32_t(1));					   // PTX L1805
	r_PtxRegister973 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister972);				   // PTX L1806
	r_PtxRegister974 = ShiftRightSigned(int32_t(r_PtxRegister973), uint32_t(1));			   // PTX L1807
	r_PtxU64Register169 = uint64_t(int64_t(int32_t(r_PtxRegister974)) * int64_t(int32_t(4)));  // PTX L1808
	r_PtxU64Register170 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register169);		   // PTX L1809
	r_PtxRegister541 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register170 + 262144ull);	   // PTX L1810
	r_LaneIndexAtPtx1812 = uint32_t((threadIdx.x & 31u));									   // PTX L1812
	r_PtxRegister975 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1812), uint32_t(31));		   // PTX L1814
	r_PtxRegister976 = ShiftRight(uint32_t(r_PtxRegister975), uint32_t(30));				   // PTX L1815
	r_PtxRegister977 = uint32_t(r_LaneIndexAtPtx1812) + uint32_t(r_PtxRegister976);			   // PTX L1816
	r_PtxRegister978 = r_PtxRegister977 & 2147483644;										   // PTX L1817
	r_PtxRegister979 = uint32_t(r_LaneIndexAtPtx1812) - uint32_t(r_PtxRegister978);			   // PTX L1818
	r_PtxRegister980 = ShiftLeft(uint32_t(r_PtxRegister979), uint32_t(1));					   // PTX L1819
	r_PtxRegister981 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister980);				   // PTX L1820
	r_PtxRegister982 = ShiftRightSigned(int32_t(r_PtxRegister981), uint32_t(1));			   // PTX L1821
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister982)) * int64_t(int32_t(4)));  // PTX L1822
	r_PtxU64Register172 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register171);		   // PTX L1823
	r_PtxRegister544 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register172 + 262144ull);	   // PTX L1824
	r_LaneIndexAtPtx1826 = uint32_t((threadIdx.x & 31u));									   // PTX L1826
	r_PtxRegister983 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1826), uint32_t(31));		   // PTX L1828
	r_PtxRegister984 = ShiftRight(uint32_t(r_PtxRegister983), uint32_t(30));				   // PTX L1829
	r_PtxRegister985 = uint32_t(r_LaneIndexAtPtx1826) + uint32_t(r_PtxRegister984);			   // PTX L1830
	r_PtxRegister986 = r_PtxRegister985 & 2147483644;										   // PTX L1831
	r_PtxRegister987 = uint32_t(r_LaneIndexAtPtx1826) - uint32_t(r_PtxRegister986);			   // PTX L1832
	r_PtxRegister988 = ShiftLeft(uint32_t(r_PtxRegister987), uint32_t(1));					   // PTX L1833
	r_PtxRegister989 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister988);				   // PTX L1834
	r_PtxRegister990 = ShiftRightSigned(int32_t(r_PtxRegister989), uint32_t(1));			   // PTX L1835
	r_PtxU64Register173 = uint64_t(int64_t(int32_t(r_PtxRegister990)) * int64_t(int32_t(4)));  // PTX L1836
	r_PtxU64Register174 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register173);		   // PTX L1837
	r_PtxRegister547 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register174 + 262144ull);	   // PTX L1838
	r_LaneIndexAtPtx1840 = uint32_t((threadIdx.x & 31u));									   // PTX L1840
	r_PtxRegister991 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1840), uint32_t(31));		   // PTX L1842
	r_PtxRegister992 = ShiftRight(uint32_t(r_PtxRegister991), uint32_t(30));				   // PTX L1843
	r_PtxRegister993 = uint32_t(r_LaneIndexAtPtx1840) + uint32_t(r_PtxRegister992);			   // PTX L1844
	r_PtxRegister994 = r_PtxRegister993 & 2147483644;										   // PTX L1845
	r_PtxRegister995 = uint32_t(r_LaneIndexAtPtx1840) - uint32_t(r_PtxRegister994);			   // PTX L1846
	r_PtxRegister996 = ShiftLeft(uint32_t(r_PtxRegister995), uint32_t(1));					   // PTX L1847
	r_PtxRegister997 = uint32_t(r_PtxRegister9) + uint32_t(r_PtxRegister996);				   // PTX L1848
	r_PtxRegister998 = ShiftRightSigned(int32_t(r_PtxRegister997), uint32_t(1));			   // PTX L1849
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister998)) * int64_t(int32_t(4)));  // PTX L1850
	r_PtxU64Register176 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register175);		   // PTX L1851
	r_PtxRegister550 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register176 + 262144ull);	   // PTX L1852
	r_LaneIndexAtPtx1854 = uint32_t((threadIdx.x & 31u));									   // PTX L1854
	r_PtxRegister999 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1854), uint32_t(31));		   // PTX L1856
	r_PtxRegister1000 = ShiftRight(uint32_t(r_PtxRegister999), uint32_t(30));				   // PTX L1857
	r_PtxRegister1001 = uint32_t(r_LaneIndexAtPtx1854) + uint32_t(r_PtxRegister1000);		   // PTX L1858
	r_PtxRegister1002 = r_PtxRegister1001 & 2147483644;										   // PTX L1859
	r_PtxRegister1003 = uint32_t(r_LaneIndexAtPtx1854) - uint32_t(r_PtxRegister1002);		   // PTX L1860
	r_PtxRegister1004 = ShiftLeft(uint32_t(r_PtxRegister1003), uint32_t(1));				   // PTX L1861
	r_PtxRegister1005 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister1004);			   // PTX L1862
	r_PtxRegister1006 = ShiftRightSigned(int32_t(r_PtxRegister1005), uint32_t(1));			   // PTX L1863
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister1006)) * int64_t(int32_t(4))); // PTX L1864
	r_PtxU64Register178 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register177);		   // PTX L1865
	r_PtxRegister553 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register178 + 262144ull);	   // PTX L1866
	r_LaneIndexAtPtx1868 = uint32_t((threadIdx.x & 31u));									   // PTX L1868
	r_PtxRegister1007 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1868), uint32_t(31));		   // PTX L1870
	r_PtxRegister1008 = ShiftRight(uint32_t(r_PtxRegister1007), uint32_t(30));				   // PTX L1871
	r_PtxRegister1009 = uint32_t(r_LaneIndexAtPtx1868) + uint32_t(r_PtxRegister1008);		   // PTX L1872
	r_PtxRegister1010 = r_PtxRegister1009 & 2147483644;										   // PTX L1873
	r_PtxRegister1011 = uint32_t(r_LaneIndexAtPtx1868) - uint32_t(r_PtxRegister1010);		   // PTX L1874
	r_PtxRegister1012 = ShiftLeft(uint32_t(r_PtxRegister1011), uint32_t(1));				   // PTX L1875
	r_PtxRegister1013 = uint32_t(r_PtxRegister594) + uint32_t(r_PtxRegister1012);			   // PTX L1876
	r_PtxRegister1014 = ShiftRightSigned(int32_t(r_PtxRegister1013), uint32_t(1));			   // PTX L1877
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister1014)) * int64_t(int32_t(4))); // PTX L1878
	r_PtxU64Register180 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register179);		   // PTX L1879
	r_PtxRegister556 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register180 + 262144ull);	   // PTX L1880
	r_LaneIndexAtPtx1882 = uint32_t((threadIdx.x & 31u));									   // PTX L1882
	r_PtxRegister1015 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1882), uint32_t(31));		   // PTX L1884
	r_PtxRegister1016 = ShiftRight(uint32_t(r_PtxRegister1015), uint32_t(30));				   // PTX L1885
	r_PtxRegister1017 = uint32_t(r_LaneIndexAtPtx1882) + uint32_t(r_PtxRegister1016);		   // PTX L1886
	r_PtxRegister1018 = r_PtxRegister1017 & 2147483644;										   // PTX L1887
	r_PtxRegister1019 = uint32_t(r_LaneIndexAtPtx1882) - uint32_t(r_PtxRegister1018);		   // PTX L1888
	r_PtxRegister1020 = ShiftLeft(uint32_t(r_PtxRegister1019), uint32_t(1));				   // PTX L1889
	r_PtxRegister1021 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister1020);			   // PTX L1890
	r_PtxRegister1022 = ShiftRightSigned(int32_t(r_PtxRegister1021), uint32_t(1));			   // PTX L1891
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister1022)) * int64_t(int32_t(4))); // PTX L1892
	r_PtxU64Register182 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register181);		   // PTX L1893
	r_PtxRegister559 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register182 + 262144ull);	   // PTX L1894
	r_LaneIndexAtPtx1896 = uint32_t((threadIdx.x & 31u));									   // PTX L1896
	r_PtxRegister1023 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1896), uint32_t(31));		   // PTX L1898
	r_PtxRegister1024 = ShiftRight(uint32_t(r_PtxRegister1023), uint32_t(30));				   // PTX L1899
	r_PtxRegister1025 = uint32_t(r_LaneIndexAtPtx1896) + uint32_t(r_PtxRegister1024);		   // PTX L1900
	r_PtxRegister1026 = r_PtxRegister1025 & 2147483644;										   // PTX L1901
	r_PtxRegister1027 = uint32_t(r_LaneIndexAtPtx1896) - uint32_t(r_PtxRegister1026);		   // PTX L1902
	r_PtxRegister1028 = ShiftLeft(uint32_t(r_PtxRegister1027), uint32_t(1));				   // PTX L1903
	r_PtxRegister1029 = uint32_t(r_PtxRegister593) + uint32_t(r_PtxRegister1028);			   // PTX L1904
	r_PtxRegister1030 = ShiftRightSigned(int32_t(r_PtxRegister1029), uint32_t(1));			   // PTX L1905
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister1030)) * int64_t(int32_t(4))); // PTX L1906
	r_PtxU64Register184 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register183);		   // PTX L1907
	r_PtxRegister562 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register184 + 262144ull);	   // PTX L1908
	r_LaneIndexAtPtx1910 = uint32_t((threadIdx.x & 31u));									   // PTX L1910
	r_PtxRegister1031 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1910), uint32_t(31));		   // PTX L1912
	r_PtxRegister1032 = ShiftRight(uint32_t(r_PtxRegister1031), uint32_t(30));				   // PTX L1913
	r_PtxRegister1033 = uint32_t(r_LaneIndexAtPtx1910) + uint32_t(r_PtxRegister1032);		   // PTX L1914
	r_PtxRegister1034 = r_PtxRegister1033 & 2147483644;										   // PTX L1915
	r_PtxRegister1035 = uint32_t(r_LaneIndexAtPtx1910) - uint32_t(r_PtxRegister1034);		   // PTX L1916
	r_PtxRegister1036 = ShiftLeft(uint32_t(r_PtxRegister1035), uint32_t(1));				   // PTX L1917
	r_PtxRegister1037 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister1036);			   // PTX L1918
	r_PtxRegister1038 = ShiftRightSigned(int32_t(r_PtxRegister1037), uint32_t(1));			   // PTX L1919
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister1038)) * int64_t(int32_t(4))); // PTX L1920
	r_PtxU64Register186 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register185);		   // PTX L1921
	r_PtxRegister565 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register186 + 262144ull);	   // PTX L1922
	r_LaneIndexAtPtx1924 = uint32_t((threadIdx.x & 31u));									   // PTX L1924
	r_PtxRegister1039 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1924), uint32_t(31));		   // PTX L1926
	r_PtxRegister1040 = ShiftRight(uint32_t(r_PtxRegister1039), uint32_t(30));				   // PTX L1927
	r_PtxRegister1041 = uint32_t(r_LaneIndexAtPtx1924) + uint32_t(r_PtxRegister1040);		   // PTX L1928
	r_PtxRegister1042 = r_PtxRegister1041 & 2147483644;										   // PTX L1929
	r_PtxRegister1043 = uint32_t(r_LaneIndexAtPtx1924) - uint32_t(r_PtxRegister1042);		   // PTX L1930
	r_PtxRegister1044 = ShiftLeft(uint32_t(r_PtxRegister1043), uint32_t(1));				   // PTX L1931
	r_PtxRegister1045 = uint32_t(r_PtxRegister649) + uint32_t(r_PtxRegister1044);			   // PTX L1932
	r_PtxRegister1046 = ShiftRightSigned(int32_t(r_PtxRegister1045), uint32_t(1));			   // PTX L1933
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister1046)) * int64_t(int32_t(4))); // PTX L1934
	r_PtxU64Register188 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register187);		   // PTX L1935
	r_PtxRegister568 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register188 + 262144ull);	   // PTX L1936
	r_LaneIndexAtPtx1938 = uint32_t((threadIdx.x & 31u));									   // PTX L1938
	r_PtxRegister1047 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1938), uint32_t(31));		   // PTX L1940
	r_PtxRegister1048 = ShiftRight(uint32_t(r_PtxRegister1047), uint32_t(30));				   // PTX L1941
	r_PtxRegister1049 = uint32_t(r_LaneIndexAtPtx1938) + uint32_t(r_PtxRegister1048);		   // PTX L1942
	r_PtxRegister1050 = r_PtxRegister1049 & 2147483644;										   // PTX L1943
	r_PtxRegister1051 = uint32_t(r_LaneIndexAtPtx1938) - uint32_t(r_PtxRegister1050);		   // PTX L1944
	r_PtxRegister1052 = ShiftLeft(uint32_t(r_PtxRegister1051), uint32_t(1));				   // PTX L1945
	r_PtxRegister1053 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1052);			   // PTX L1946
	r_PtxRegister1054 = ShiftRightSigned(int32_t(r_PtxRegister1053), uint32_t(1));			   // PTX L1947
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister1054)) * int64_t(int32_t(4))); // PTX L1948
	r_PtxU64Register190 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register189);		   // PTX L1949
	r_PtxRegister571 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register190 + 262144ull);	   // PTX L1950
	r_LaneIndexAtPtx1952 = uint32_t((threadIdx.x & 31u));									   // PTX L1952
	r_PtxRegister1055 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1952), uint32_t(31));		   // PTX L1954
	r_PtxRegister1056 = ShiftRight(uint32_t(r_PtxRegister1055), uint32_t(30));				   // PTX L1955
	r_PtxRegister1057 = uint32_t(r_LaneIndexAtPtx1952) + uint32_t(r_PtxRegister1056);		   // PTX L1956
	r_PtxRegister1058 = r_PtxRegister1057 & 2147483644;										   // PTX L1957
	r_PtxRegister1059 = uint32_t(r_LaneIndexAtPtx1952) - uint32_t(r_PtxRegister1058);		   // PTX L1958
	r_PtxRegister1060 = ShiftLeft(uint32_t(r_PtxRegister1059), uint32_t(1));				   // PTX L1959
	r_PtxRegister1061 = uint32_t(r_PtxRegister10) + uint32_t(r_PtxRegister1060);			   // PTX L1960
	r_PtxRegister1062 = ShiftRightSigned(int32_t(r_PtxRegister1061), uint32_t(1));			   // PTX L1961
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister1062)) * int64_t(int32_t(4))); // PTX L1962
	r_PtxU64Register192 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register191);		   // PTX L1963
	r_PtxRegister574 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register192 + 262144ull);	   // PTX L1964
	r_LaneIndexAtPtx1966 = uint32_t((threadIdx.x & 31u));									   // PTX L1966
	r_PtxRegister1063 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1966), uint32_t(31));		   // PTX L1968
	r_PtxRegister1064 = ShiftRight(uint32_t(r_PtxRegister1063), uint32_t(30));				   // PTX L1969
	r_PtxRegister1065 = uint32_t(r_LaneIndexAtPtx1966) + uint32_t(r_PtxRegister1064);		   // PTX L1970
	r_PtxRegister1066 = r_PtxRegister1065 & 2147483644;										   // PTX L1971
	r_PtxRegister1067 = uint32_t(r_LaneIndexAtPtx1966) - uint32_t(r_PtxRegister1066);		   // PTX L1972
	r_PtxRegister1068 = ShiftLeft(uint32_t(r_PtxRegister1067), uint32_t(1));				   // PTX L1973
	r_PtxRegister1069 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister1068);			   // PTX L1974
	r_PtxRegister1070 = ShiftRightSigned(int32_t(r_PtxRegister1069), uint32_t(1));			   // PTX L1975
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister1070)) * int64_t(int32_t(4))); // PTX L1976
	r_PtxU64Register194 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register193);		   // PTX L1977
	r_PtxRegister577 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register194 + 262144ull);	   // PTX L1978
	r_LaneIndexAtPtx1980 = uint32_t((threadIdx.x & 31u));									   // PTX L1980
	r_PtxRegister1071 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1980), uint32_t(31));		   // PTX L1982
	r_PtxRegister1072 = ShiftRight(uint32_t(r_PtxRegister1071), uint32_t(30));				   // PTX L1983
	r_PtxRegister1073 = uint32_t(r_LaneIndexAtPtx1980) + uint32_t(r_PtxRegister1072);		   // PTX L1984
	r_PtxRegister1074 = r_PtxRegister1073 & 2147483644;										   // PTX L1985
	r_PtxRegister1075 = uint32_t(r_LaneIndexAtPtx1980) - uint32_t(r_PtxRegister1074);		   // PTX L1986
	r_PtxRegister1076 = ShiftLeft(uint32_t(r_PtxRegister1075), uint32_t(1));				   // PTX L1987
	r_PtxRegister1077 = uint32_t(r_PtxRegister682) + uint32_t(r_PtxRegister1076);			   // PTX L1988
	r_PtxRegister1078 = ShiftRightSigned(int32_t(r_PtxRegister1077), uint32_t(1));			   // PTX L1989
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister1078)) * int64_t(int32_t(4))); // PTX L1990
	r_PtxU64Register196 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register195);		   // PTX L1991
	r_PtxRegister580 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register196 + 262144ull);	   // PTX L1992
	r_LaneIndexAtPtx1994 = uint32_t((threadIdx.x & 31u));									   // PTX L1994
	r_PtxRegister1079 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1994), uint32_t(31));		   // PTX L1996
	r_PtxRegister1080 = ShiftRight(uint32_t(r_PtxRegister1079), uint32_t(30));				   // PTX L1997
	r_PtxRegister1081 = uint32_t(r_LaneIndexAtPtx1994) + uint32_t(r_PtxRegister1080);		   // PTX L1998
	r_PtxRegister1082 = r_PtxRegister1081 & 2147483644;										   // PTX L1999
	r_PtxRegister1083 = uint32_t(r_LaneIndexAtPtx1994) - uint32_t(r_PtxRegister1082);		   // PTX L2000
	r_PtxRegister1084 = ShiftLeft(uint32_t(r_PtxRegister1083), uint32_t(1));				   // PTX L2001
	r_PtxRegister1085 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister1084);			   // PTX L2002
	r_PtxRegister1086 = ShiftRightSigned(int32_t(r_PtxRegister1085), uint32_t(1));			   // PTX L2003
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister1086)) * int64_t(int32_t(4))); // PTX L2004
	r_PtxU64Register198 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register197);		   // PTX L2005
	r_PtxRegister583 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register198 + 262144ull);	   // PTX L2006
	r_LaneIndexAtPtx2008 = uint32_t((threadIdx.x & 31u));									   // PTX L2008
	r_PtxRegister1087 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2008), uint32_t(31));		   // PTX L2010
	r_PtxRegister1088 = ShiftRight(uint32_t(r_PtxRegister1087), uint32_t(30));				   // PTX L2011
	r_PtxRegister1089 = uint32_t(r_LaneIndexAtPtx2008) + uint32_t(r_PtxRegister1088);		   // PTX L2012
	r_PtxRegister1090 = r_PtxRegister1089 & 2147483644;										   // PTX L2013
	r_PtxRegister1091 = uint32_t(r_LaneIndexAtPtx2008) - uint32_t(r_PtxRegister1090);		   // PTX L2014
	r_PtxRegister1092 = ShiftLeft(uint32_t(r_PtxRegister1091), uint32_t(1));				   // PTX L2015
	r_PtxRegister1093 = uint32_t(r_PtxRegister699) + uint32_t(r_PtxRegister1092);			   // PTX L2016
	r_PtxRegister1094 = ShiftRightSigned(int32_t(r_PtxRegister1093), uint32_t(1));			   // PTX L2017
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister1094)) * int64_t(int32_t(4))); // PTX L2018
	r_PtxU64Register200 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register199);		   // PTX L2019
	r_PtxRegister586 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register200 + 262144ull);	   // PTX L2020
	r_LaneIndexAtPtx2022 = uint32_t((threadIdx.x & 31u));									   // PTX L2022
	r_PtxRegister1095 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2022), uint32_t(31));		   // PTX L2024
	r_PtxRegister1096 = ShiftRight(uint32_t(r_PtxRegister1095), uint32_t(30));				   // PTX L2025
	r_PtxRegister1097 = uint32_t(r_LaneIndexAtPtx2022) + uint32_t(r_PtxRegister1096);		   // PTX L2026
	r_PtxRegister1098 = r_PtxRegister1097 & 2147483644;										   // PTX L2027
	r_PtxRegister1099 = uint32_t(r_LaneIndexAtPtx2022) - uint32_t(r_PtxRegister1098);		   // PTX L2028
	r_PtxRegister1100 = ShiftLeft(uint32_t(r_PtxRegister1099), uint32_t(1));				   // PTX L2029
	r_PtxRegister1101 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister1100);			   // PTX L2030
	r_PtxRegister1102 = ShiftRightSigned(int32_t(r_PtxRegister1101), uint32_t(1));			   // PTX L2031
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister1102)) * int64_t(int32_t(4))); // PTX L2032
	r_PtxU64Register202 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register201);		   // PTX L2033
	r_PtxRegister589 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register202 + 262144ull);	   // PTX L2034
	r_LaneIndexAtPtx2036 = uint32_t((threadIdx.x & 31u));									   // PTX L2036
	r_PtxRegister1103 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx2036), uint32_t(31));		   // PTX L2038
	r_PtxRegister1104 = ShiftRight(uint32_t(r_PtxRegister1103), uint32_t(30));				   // PTX L2039
	r_PtxRegister1105 = uint32_t(r_LaneIndexAtPtx2036) + uint32_t(r_PtxRegister1104);		   // PTX L2040
	r_PtxRegister1106 = r_PtxRegister1105 & 2147483644;										   // PTX L2041
	r_PtxRegister1107 = uint32_t(r_LaneIndexAtPtx2036) - uint32_t(r_PtxRegister1106);		   // PTX L2042
	r_PtxRegister1108 = ShiftLeft(uint32_t(r_PtxRegister1107), uint32_t(1));				   // PTX L2043
	r_PtxRegister1109 = uint32_t(r_PtxRegister716) + uint32_t(r_PtxRegister1108);			   // PTX L2044
	r_PtxRegister1110 = ShiftRightSigned(int32_t(r_PtxRegister1109), uint32_t(1));			   // PTX L2045
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister1110)) * int64_t(int32_t(4))); // PTX L2046
	r_PtxU64Register204 = uint64_t(r_PtxU64Register76) + uint64_t(r_PtxU64Register203);		   // PTX L2047
	r_PtxRegister592 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register204 + 262144ull);	   // PTX L2048
	r_LaneIndexAtPtx2050 = uint32_t((threadIdx.x & 31u));									   // PTX L2050
	r_PackedHalf2AtPtx2053R2049 = HalfMul(r_PackedHalf2AtPtx951R402, r_PtxRegister403);		   // PTX L2053
	r_LaneIndexAtPtx2057 = uint32_t((threadIdx.x & 31u));									   // PTX L2057
	r_PackedHalf2AtPtx2060R2048 = HalfMul(r_PackedHalf2AtPtx957R405, r_PtxRegister406);		   // PTX L2060
	r_LaneIndexAtPtx2064 = uint32_t((threadIdx.x & 31u));									   // PTX L2064
	r_PackedHalf2AtPtx2067R2047 = HalfMul(r_PackedHalf2AtPtx954R408, r_PtxRegister409);		   // PTX L2067
	r_LaneIndexAtPtx2071 = uint32_t((threadIdx.x & 31u));									   // PTX L2071
	r_PackedHalf2AtPtx2074R2046 = HalfMul(r_PackedHalf2AtPtx960R411, r_PtxRegister412);		   // PTX L2074
	r_LaneIndexAtPtx2078 = uint32_t((threadIdx.x & 31u));									   // PTX L2078
	r_PackedHalf2AtPtx2081R2045 = HalfMul(r_PackedHalf2AtPtx963R414, r_PtxRegister415);		   // PTX L2081
	r_LaneIndexAtPtx2085 = uint32_t((threadIdx.x & 31u));									   // PTX L2085
	r_PackedHalf2AtPtx2088R2044 = HalfMul(r_PackedHalf2AtPtx969R417, r_PtxRegister418);		   // PTX L2088
	r_LaneIndexAtPtx2092 = uint32_t((threadIdx.x & 31u));									   // PTX L2092
	r_PackedHalf2AtPtx2095R2043 = HalfMul(r_PackedHalf2AtPtx966R420, r_PtxRegister421);		   // PTX L2095
	r_LaneIndexAtPtx2099 = uint32_t((threadIdx.x & 31u));									   // PTX L2099
	r_PackedHalf2AtPtx2102R2042 = HalfMul(r_PackedHalf2AtPtx972R423, r_PtxRegister424);		   // PTX L2102
	r_LaneIndexAtPtx2106 = uint32_t((threadIdx.x & 31u));									   // PTX L2106
	r_PackedHalf2AtPtx2109R2041 = HalfMul(r_PackedHalf2AtPtx975R426, r_PtxRegister427);		   // PTX L2109
	r_LaneIndexAtPtx2113 = uint32_t((threadIdx.x & 31u));									   // PTX L2113
	r_PackedHalf2AtPtx2116R2040 = HalfMul(r_PackedHalf2AtPtx981R429, r_PtxRegister430);		   // PTX L2116
	r_LaneIndexAtPtx2120 = uint32_t((threadIdx.x & 31u));									   // PTX L2120
	r_PackedHalf2AtPtx2123R2039 = HalfMul(r_PackedHalf2AtPtx978R432, r_PtxRegister433);		   // PTX L2123
	r_LaneIndexAtPtx2127 = uint32_t((threadIdx.x & 31u));									   // PTX L2127
	r_PackedHalf2AtPtx2130R2038 = HalfMul(r_PackedHalf2AtPtx984R435, r_PtxRegister436);		   // PTX L2130
	r_LaneIndexAtPtx2134 = uint32_t((threadIdx.x & 31u));									   // PTX L2134
	r_PackedHalf2AtPtx2137R2037 = HalfMul(r_PackedHalf2AtPtx987R438, r_PtxRegister439);		   // PTX L2137
	r_LaneIndexAtPtx2141 = uint32_t((threadIdx.x & 31u));									   // PTX L2141
	r_PackedHalf2AtPtx2144R2036 = HalfMul(r_PackedHalf2AtPtx993R441, r_PtxRegister442);		   // PTX L2144
	r_LaneIndexAtPtx2148 = uint32_t((threadIdx.x & 31u));									   // PTX L2148
	r_PackedHalf2AtPtx2151R2035 = HalfMul(r_PackedHalf2AtPtx990R444, r_PtxRegister445);		   // PTX L2151
	r_LaneIndexAtPtx2155 = uint32_t((threadIdx.x & 31u));									   // PTX L2155
	r_PackedHalf2AtPtx2158R2034 = HalfMul(r_PackedHalf2AtPtx996R447, r_PtxRegister448);		   // PTX L2158
	r_LaneIndexAtPtx2162 = uint32_t((threadIdx.x & 31u));									   // PTX L2162
	r_PackedHalf2AtPtx2165R2033 = HalfMul(r_PackedHalf2AtPtx999R450, r_PtxRegister451);		   // PTX L2165
	r_LaneIndexAtPtx2169 = uint32_t((threadIdx.x & 31u));									   // PTX L2169
	r_PackedHalf2AtPtx2172R2032 = HalfMul(r_PackedHalf2AtPtx1005R453, r_PtxRegister454);	   // PTX L2172
	r_LaneIndexAtPtx2176 = uint32_t((threadIdx.x & 31u));									   // PTX L2176
	r_PackedHalf2AtPtx2179R2031 = HalfMul(r_PackedHalf2AtPtx1002R456, r_PtxRegister457);	   // PTX L2179
	r_LaneIndexAtPtx2183 = uint32_t((threadIdx.x & 31u));									   // PTX L2183
	r_PackedHalf2AtPtx2186R2030 = HalfMul(r_PackedHalf2AtPtx1008R459, r_PtxRegister460);	   // PTX L2186
	r_LaneIndexAtPtx2190 = uint32_t((threadIdx.x & 31u));									   // PTX L2190
	r_PackedHalf2AtPtx2193R2029 = HalfMul(r_PackedHalf2AtPtx1011R462, r_PtxRegister463);	   // PTX L2193
	r_LaneIndexAtPtx2197 = uint32_t((threadIdx.x & 31u));									   // PTX L2197
	r_PackedHalf2AtPtx2200R2028 = HalfMul(r_PackedHalf2AtPtx1017R465, r_PtxRegister466);	   // PTX L2200
	r_LaneIndexAtPtx2204 = uint32_t((threadIdx.x & 31u));									   // PTX L2204
	r_PackedHalf2AtPtx2207R2027 = HalfMul(r_PackedHalf2AtPtx1014R468, r_PtxRegister469);	   // PTX L2207
	r_LaneIndexAtPtx2211 = uint32_t((threadIdx.x & 31u));									   // PTX L2211
	r_PackedHalf2AtPtx2214R2026 = HalfMul(r_PackedHalf2AtPtx1020R471, r_PtxRegister472);	   // PTX L2214
	r_LaneIndexAtPtx2218 = uint32_t((threadIdx.x & 31u));									   // PTX L2218
	r_PackedHalf2AtPtx2221R2025 = HalfMul(r_PackedHalf2AtPtx1023R474, r_PtxRegister475);	   // PTX L2221
	r_LaneIndexAtPtx2225 = uint32_t((threadIdx.x & 31u));									   // PTX L2225
	r_PackedHalf2AtPtx2228R2024 = HalfMul(r_PackedHalf2AtPtx1029R477, r_PtxRegister478);	   // PTX L2228
	r_LaneIndexAtPtx2232 = uint32_t((threadIdx.x & 31u));									   // PTX L2232
	r_PackedHalf2AtPtx2235R2023 = HalfMul(r_PackedHalf2AtPtx1026R480, r_PtxRegister481);	   // PTX L2235
	r_LaneIndexAtPtx2239 = uint32_t((threadIdx.x & 31u));									   // PTX L2239
	r_PackedHalf2AtPtx2242R2022 = HalfMul(r_PackedHalf2AtPtx1032R483, r_PtxRegister484);	   // PTX L2242
	r_LaneIndexAtPtx2246 = uint32_t((threadIdx.x & 31u));									   // PTX L2246
	r_PackedHalf2AtPtx2249R2021 = HalfMul(r_PackedHalf2AtPtx1035R486, r_PtxRegister487);	   // PTX L2249
	r_LaneIndexAtPtx2253 = uint32_t((threadIdx.x & 31u));									   // PTX L2253
	r_PackedHalf2AtPtx2256R2020 = HalfMul(r_PackedHalf2AtPtx1041R489, r_PtxRegister490);	   // PTX L2256
	r_LaneIndexAtPtx2260 = uint32_t((threadIdx.x & 31u));									   // PTX L2260
	r_PackedHalf2AtPtx2263R2019 = HalfMul(r_PackedHalf2AtPtx1038R492, r_PtxRegister493);	   // PTX L2263
	r_LaneIndexAtPtx2267 = uint32_t((threadIdx.x & 31u));									   // PTX L2267
	r_PackedHalf2AtPtx2270R2018 = HalfMul(r_PackedHalf2AtPtx1044R495, r_PtxRegister496);	   // PTX L2270
	r_LaneIndexAtPtx2274 = uint32_t((threadIdx.x & 31u));									   // PTX L2274
	r_PackedHalf2AtPtx2277R2017 = HalfMul(r_PackedHalf2AtPtx1047R498, r_PtxRegister499);	   // PTX L2277
	r_LaneIndexAtPtx2281 = uint32_t((threadIdx.x & 31u));									   // PTX L2281
	r_PackedHalf2AtPtx2284R2016 = HalfMul(r_PackedHalf2AtPtx1053R501, r_PtxRegister502);	   // PTX L2284
	r_LaneIndexAtPtx2288 = uint32_t((threadIdx.x & 31u));									   // PTX L2288
	r_PackedHalf2AtPtx2291R2015 = HalfMul(r_PackedHalf2AtPtx1050R504, r_PtxRegister505);	   // PTX L2291
	r_LaneIndexAtPtx2295 = uint32_t((threadIdx.x & 31u));									   // PTX L2295
	r_PackedHalf2AtPtx2298R2014 = HalfMul(r_PackedHalf2AtPtx1056R507, r_PtxRegister508);	   // PTX L2298
	r_LaneIndexAtPtx2302 = uint32_t((threadIdx.x & 31u));									   // PTX L2302
	r_PackedHalf2AtPtx2305R2013 = HalfMul(r_PackedHalf2AtPtx1059R510, r_PtxRegister511);	   // PTX L2305
	r_LaneIndexAtPtx2309 = uint32_t((threadIdx.x & 31u));									   // PTX L2309
	r_PackedHalf2AtPtx2312R2012 = HalfMul(r_PackedHalf2AtPtx1065R513, r_PtxRegister514);	   // PTX L2312
	r_LaneIndexAtPtx2316 = uint32_t((threadIdx.x & 31u));									   // PTX L2316
	r_PackedHalf2AtPtx2319R2011 = HalfMul(r_PackedHalf2AtPtx1062R516, r_PtxRegister517);	   // PTX L2319
	r_LaneIndexAtPtx2323 = uint32_t((threadIdx.x & 31u));									   // PTX L2323
	r_PackedHalf2AtPtx2326R2010 = HalfMul(r_PackedHalf2AtPtx1068R519, r_PtxRegister520);	   // PTX L2326
	r_LaneIndexAtPtx2330 = uint32_t((threadIdx.x & 31u));									   // PTX L2330
	r_PackedHalf2AtPtx2333R2009 = HalfMul(r_PackedHalf2AtPtx1071R522, r_PtxRegister523);	   // PTX L2333
	r_LaneIndexAtPtx2337 = uint32_t((threadIdx.x & 31u));									   // PTX L2337
	r_PackedHalf2AtPtx2340R2008 = HalfMul(r_PackedHalf2AtPtx1077R525, r_PtxRegister526);	   // PTX L2340
	r_LaneIndexAtPtx2344 = uint32_t((threadIdx.x & 31u));									   // PTX L2344
	r_PackedHalf2AtPtx2347R2007 = HalfMul(r_PackedHalf2AtPtx1074R528, r_PtxRegister529);	   // PTX L2347
	r_LaneIndexAtPtx2351 = uint32_t((threadIdx.x & 31u));									   // PTX L2351
	r_PackedHalf2AtPtx2354R2006 = HalfMul(r_PackedHalf2AtPtx1080R531, r_PtxRegister532);	   // PTX L2354
	r_LaneIndexAtPtx2358 = uint32_t((threadIdx.x & 31u));									   // PTX L2358
	r_PackedHalf2AtPtx2361R2005 = HalfMul(r_PackedHalf2AtPtx1083R534, r_PtxRegister535);	   // PTX L2361
	r_LaneIndexAtPtx2365 = uint32_t((threadIdx.x & 31u));									   // PTX L2365
	r_PackedHalf2AtPtx2368R2004 = HalfMul(r_PackedHalf2AtPtx1089R537, r_PtxRegister538);	   // PTX L2368
	r_LaneIndexAtPtx2372 = uint32_t((threadIdx.x & 31u));									   // PTX L2372
	r_PackedHalf2AtPtx2375R2003 = HalfMul(r_PackedHalf2AtPtx1086R540, r_PtxRegister541);	   // PTX L2375
	r_LaneIndexAtPtx2379 = uint32_t((threadIdx.x & 31u));									   // PTX L2379
	r_PackedHalf2AtPtx2382R2002 = HalfMul(r_PackedHalf2AtPtx1092R543, r_PtxRegister544);	   // PTX L2382
	r_LaneIndexAtPtx2386 = uint32_t((threadIdx.x & 31u));									   // PTX L2386
	r_PackedHalf2AtPtx2389R2001 = HalfMul(r_PackedHalf2AtPtx1095R546, r_PtxRegister547);	   // PTX L2389
	r_LaneIndexAtPtx2393 = uint32_t((threadIdx.x & 31u));									   // PTX L2393
	r_PackedHalf2AtPtx2396R2000 = HalfMul(r_PackedHalf2AtPtx1101R549, r_PtxRegister550);	   // PTX L2396
	r_LaneIndexAtPtx2400 = uint32_t((threadIdx.x & 31u));									   // PTX L2400
	r_PackedHalf2AtPtx2403R1999 = HalfMul(r_PackedHalf2AtPtx1098R552, r_PtxRegister553);	   // PTX L2403
	r_LaneIndexAtPtx2407 = uint32_t((threadIdx.x & 31u));									   // PTX L2407
	r_PackedHalf2AtPtx2410R1998 = HalfMul(r_PackedHalf2AtPtx1104R555, r_PtxRegister556);	   // PTX L2410
	r_LaneIndexAtPtx2414 = uint32_t((threadIdx.x & 31u));									   // PTX L2414
	r_PackedHalf2AtPtx2417R1997 = HalfMul(r_PackedHalf2AtPtx1107R558, r_PtxRegister559);	   // PTX L2417
	r_LaneIndexAtPtx2421 = uint32_t((threadIdx.x & 31u));									   // PTX L2421
	r_PackedHalf2AtPtx2424R1996 = HalfMul(r_PackedHalf2AtPtx1113R561, r_PtxRegister562);	   // PTX L2424
	r_LaneIndexAtPtx2428 = uint32_t((threadIdx.x & 31u));									   // PTX L2428
	r_PackedHalf2AtPtx2431R1995 = HalfMul(r_PackedHalf2AtPtx1110R564, r_PtxRegister565);	   // PTX L2431
	r_LaneIndexAtPtx2435 = uint32_t((threadIdx.x & 31u));									   // PTX L2435
	r_PackedHalf2AtPtx2438R1994 = HalfMul(r_PackedHalf2AtPtx1116R567, r_PtxRegister568);	   // PTX L2438
	r_LaneIndexAtPtx2442 = uint32_t((threadIdx.x & 31u));									   // PTX L2442
	r_PackedHalf2AtPtx2445R1993 = HalfMul(r_PackedHalf2AtPtx1120R570, r_PtxRegister571);	   // PTX L2445
	r_LaneIndexAtPtx2449 = uint32_t((threadIdx.x & 31u));									   // PTX L2449
	r_PackedHalf2AtPtx2452R1992 = HalfMul(r_PackedHalf2AtPtx1127R573, r_PtxRegister574);	   // PTX L2452
	r_LaneIndexAtPtx2456 = uint32_t((threadIdx.x & 31u));									   // PTX L2456
	r_PackedHalf2AtPtx2459R1991 = HalfMul(r_PackedHalf2AtPtx1123R576, r_PtxRegister577);	   // PTX L2459
	r_LaneIndexAtPtx2463 = uint32_t((threadIdx.x & 31u));									   // PTX L2463
	r_PackedHalf2AtPtx2466R1990 = HalfMul(r_PackedHalf2AtPtx1130R579, r_PtxRegister580);	   // PTX L2466
	r_LaneIndexAtPtx2470 = uint32_t((threadIdx.x & 31u));									   // PTX L2470
	r_PackedHalf2AtPtx2473R1989 = HalfMul(r_PackedHalf2AtPtx1134R582, r_PtxRegister583);	   // PTX L2473
	r_LaneIndexAtPtx2477 = uint32_t((threadIdx.x & 31u));									   // PTX L2477
	r_PackedHalf2AtPtx2480R1988 = HalfMul(r_PackedHalf2AtPtx1141R585, r_PtxRegister586);	   // PTX L2480
	r_LaneIndexAtPtx2484 = uint32_t((threadIdx.x & 31u));									   // PTX L2484
	r_PackedHalf2AtPtx2487R1987 = HalfMul(r_PackedHalf2AtPtx1137R588, r_PtxRegister589);	   // PTX L2487
	r_LaneIndexAtPtx2491 = uint32_t((threadIdx.x & 31u));									   // PTX L2491
	r_PackedHalf2AtPtx2494R1986 = HalfMul(r_PackedHalf2AtPtx1144R591, r_PtxRegister592);	   // PTX L2494
	r_PtxRegister2050 = uint32_t(0);														   // PTX L2497
L__BB35_95:																					   // PTX L2498
	r_PtxRegister1223 = ShiftRight(uint32_t(r_PtxRegister2050), uint32_t(6));				   // PTX L2499
	r_PtxU16Register157 = uint16_t(r_PtxRegister1223);										   // PTX L2500
	r_PtxU16Register158 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register157)) * uint32_t(uint16_t(171))); // PTX L2501
	r_PtxU16Register159 = ShiftRight(uint16_t(r_PtxU16Register158), uint32_t(9));	 // PTX L2502
	r_PtxU16Register160 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register159)) * uint32_t(uint16_t(3)));			// PTX L2503
	r_PtxU16Register161 = uint16_t(r_PtxU16Register157) - uint16_t(r_PtxU16Register160);	// PTX L2504
	r_PtxRegister1224 = uint32_t(uint16_t(r_PtxU16Register161));							// PTX L2505
	r_PtxRegister33 = r_PtxRegister1224 & 255;												// PTX L2506
	r_PtxU16Register162 = r_PtxU16Register161 & 255;										// PTX L2507
	r_PtxRegister1225 = uint32_t(uint16_t(r_PtxU16Register162)) * uint32_t(uint16_t(4096)); // PTX L2508
	r_LaneIndexAtPtx2510 = uint32_t((threadIdx.x & 31u));									// PTX L2510
	r_PtxRegister1226 = uint32_t(0u /* exact native shared-region offset */);				// PTX L2512
	r_PtxRegister34 = uint32_t(r_PtxRegister1226) + uint32_t(r_PtxRegister1225);			// PTX L2513
	r_PtxRegister1227 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2510), uint32_t(4));				// PTX L2514
	r_PtxRegister1112 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1227);			// PTX L2515
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1112));
		r_MmaAE4x4WordAtPtx2517R1127 = r_Value.x;
		r_MmaAE4x4WordAtPtx2517R1128 = r_Value.y;
		r_MmaAE4x4WordAtPtx2517R1129 = r_Value.z;
		r_MmaAE4x4WordAtPtx2517R1130 = r_Value.w;
	} // PTX L2517
	r_LaneIndexAtPtx2520 = uint32_t((threadIdx.x & 31u));						 // PTX L2520
	r_PtxRegister1228 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2520), uint32_t(4));	 // PTX L2522
	r_PtxRegister1229 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1228); // PTX L2523
	r_PtxRegister1114 = uint32_t(r_PtxRegister1229) + uint32_t(512);			 // PTX L2524
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1114));
		r_MmaAE4x4WordAtPtx2526R1131 = r_Value.x;
		r_MmaAE4x4WordAtPtx2526R1132 = r_Value.y;
		r_MmaAE4x4WordAtPtx2526R1133 = r_Value.z;
		r_MmaAE4x4WordAtPtx2526R1134 = r_Value.w;
	} // PTX L2526
	r_LaneIndexAtPtx2529 = uint32_t((threadIdx.x & 31u));						 // PTX L2529
	r_PtxRegister1230 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2529), uint32_t(4));	 // PTX L2531
	r_PtxRegister1231 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1230); // PTX L2532
	r_PtxRegister1116 = uint32_t(r_PtxRegister1231) + uint32_t(1024);			 // PTX L2533
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1116));
		r_MmaAE4x4WordAtPtx2535R1151 = r_Value.x;
		r_MmaAE4x4WordAtPtx2535R1152 = r_Value.y;
		r_MmaAE4x4WordAtPtx2535R1153 = r_Value.z;
		r_MmaAE4x4WordAtPtx2535R1154 = r_Value.w;
	} // PTX L2535
	r_LaneIndexAtPtx2538 = uint32_t((threadIdx.x & 31u));						 // PTX L2538
	r_PtxRegister1232 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2538), uint32_t(4));	 // PTX L2540
	r_PtxRegister1233 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1232); // PTX L2541
	r_PtxRegister1118 = uint32_t(r_PtxRegister1233) + uint32_t(1536);			 // PTX L2542
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1118));
		r_MmaAE4x4WordAtPtx2544R1155 = r_Value.x;
		r_MmaAE4x4WordAtPtx2544R1156 = r_Value.y;
		r_MmaAE4x4WordAtPtx2544R1157 = r_Value.z;
		r_MmaAE4x4WordAtPtx2544R1158 = r_Value.w;
	} // PTX L2544
	r_LaneIndexAtPtx2547 = uint32_t((threadIdx.x & 31u));						 // PTX L2547
	r_PtxRegister1234 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2547), uint32_t(4));	 // PTX L2549
	r_PtxRegister1235 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1234); // PTX L2550
	r_PtxRegister1120 = uint32_t(r_PtxRegister1235) + uint32_t(2048);			 // PTX L2551
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1120));
		r_MmaAE4x4WordAtPtx2553R1175 = r_Value.x;
		r_MmaAE4x4WordAtPtx2553R1176 = r_Value.y;
		r_MmaAE4x4WordAtPtx2553R1177 = r_Value.z;
		r_MmaAE4x4WordAtPtx2553R1178 = r_Value.w;
	} // PTX L2553
	r_LaneIndexAtPtx2556 = uint32_t((threadIdx.x & 31u));						 // PTX L2556
	r_PtxRegister1236 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2556), uint32_t(4));	 // PTX L2558
	r_PtxRegister1237 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1236); // PTX L2559
	r_PtxRegister1122 = uint32_t(r_PtxRegister1237) + uint32_t(2560);			 // PTX L2560
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1122));
		r_MmaAE4x4WordAtPtx2562R1179 = r_Value.x;
		r_MmaAE4x4WordAtPtx2562R1180 = r_Value.y;
		r_MmaAE4x4WordAtPtx2562R1181 = r_Value.z;
		r_MmaAE4x4WordAtPtx2562R1182 = r_Value.w;
	} // PTX L2562
	r_LaneIndexAtPtx2565 = uint32_t((threadIdx.x & 31u));						 // PTX L2565
	r_PtxRegister1238 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2565), uint32_t(4));	 // PTX L2567
	r_PtxRegister1239 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1238); // PTX L2568
	r_PtxRegister1124 = uint32_t(r_PtxRegister1239) + uint32_t(3072);			 // PTX L2569
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1124));
		r_MmaAE4x4WordAtPtx2571R1199 = r_Value.x;
		r_MmaAE4x4WordAtPtx2571R1200 = r_Value.y;
		r_MmaAE4x4WordAtPtx2571R1201 = r_Value.z;
		r_MmaAE4x4WordAtPtx2571R1202 = r_Value.w;
	} // PTX L2571
	r_LaneIndexAtPtx2574 = uint32_t((threadIdx.x & 31u));						 // PTX L2574
	r_PtxRegister1240 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2574), uint32_t(4));	 // PTX L2576
	r_PtxRegister1241 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1240); // PTX L2577
	r_PtxRegister1126 = uint32_t(r_PtxRegister1241) + uint32_t(3584);			 // PTX L2578
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1126));
		r_MmaAE4x4WordAtPtx2580R1203 = r_Value.x;
		r_MmaAE4x4WordAtPtx2580R1204 = r_Value.y;
		r_MmaAE4x4WordAtPtx2580R1205 = r_Value.z;
		r_MmaAE4x4WordAtPtx2580R1206 = r_Value.w;
	} // PTX L2580
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2583R1135, r_MmaAccumulatorHalf2WordAtPtx2583R1136,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx78R2082, r_MmaBE4x4WordAtPtx78R2081,
		  r_PackedHalf2AtPtx2053R2049,
		  r_PackedHalf2AtPtx2060R2048); // PTX L2583
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2590R1137, r_MmaAccumulatorHalf2WordAtPtx2590R1138,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx78R2080, r_MmaBE4x4WordAtPtx78R2079,
		  r_PackedHalf2AtPtx2067R2047,
		  r_PackedHalf2AtPtx2074R2046); // PTX L2590
	MmaE4(r_PackedHalf2AtPtx2053R2049, r_PackedHalf2AtPtx2060R2048, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx115R2066, r_MmaBE4x4WordAtPtx115R2065, r_MmaAccumulatorHalf2WordAtPtx2583R1135,
		  r_MmaAccumulatorHalf2WordAtPtx2583R1136); // PTX L2597
	MmaE4(r_PackedHalf2AtPtx2067R2047, r_PackedHalf2AtPtx2074R2046, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx115R2064, r_MmaBE4x4WordAtPtx115R2063, r_MmaAccumulatorHalf2WordAtPtx2590R1137,
		  r_MmaAccumulatorHalf2WordAtPtx2590R1138); // PTX L2604
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2611R1139, r_MmaAccumulatorHalf2WordAtPtx2611R1140,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx87R2078, r_MmaBE4x4WordAtPtx87R2077,
		  r_PackedHalf2AtPtx2081R2045,
		  r_PackedHalf2AtPtx2088R2044); // PTX L2611
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2618R1141, r_MmaAccumulatorHalf2WordAtPtx2618R1142,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx87R2076, r_MmaBE4x4WordAtPtx87R2075,
		  r_PackedHalf2AtPtx2095R2043,
		  r_PackedHalf2AtPtx2102R2042); // PTX L2618
	MmaE4(r_PackedHalf2AtPtx2081R2045, r_PackedHalf2AtPtx2088R2044, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx124R2062, r_MmaBE4x4WordAtPtx124R2061, r_MmaAccumulatorHalf2WordAtPtx2611R1139,
		  r_MmaAccumulatorHalf2WordAtPtx2611R1140); // PTX L2625
	MmaE4(r_PackedHalf2AtPtx2095R2043, r_PackedHalf2AtPtx2102R2042, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx124R2060, r_MmaBE4x4WordAtPtx124R2059, r_MmaAccumulatorHalf2WordAtPtx2618R1141,
		  r_MmaAccumulatorHalf2WordAtPtx2618R1142); // PTX L2632
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2639R1143, r_MmaAccumulatorHalf2WordAtPtx2639R1144,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx97R2074, r_MmaBE4x4WordAtPtx97R2073,
		  r_PackedHalf2AtPtx2109R2041,
		  r_PackedHalf2AtPtx2116R2040); // PTX L2639
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2646R1145, r_MmaAccumulatorHalf2WordAtPtx2646R1146,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx97R2072, r_MmaBE4x4WordAtPtx97R2071,
		  r_PackedHalf2AtPtx2123R2039,
		  r_PackedHalf2AtPtx2130R2038); // PTX L2646
	MmaE4(r_PackedHalf2AtPtx2109R2041, r_PackedHalf2AtPtx2116R2040, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx133R2058, r_MmaBE4x4WordAtPtx133R2057, r_MmaAccumulatorHalf2WordAtPtx2639R1143,
		  r_MmaAccumulatorHalf2WordAtPtx2639R1144); // PTX L2653
	MmaE4(r_PackedHalf2AtPtx2123R2039, r_PackedHalf2AtPtx2130R2038, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx133R2056, r_MmaBE4x4WordAtPtx133R2055, r_MmaAccumulatorHalf2WordAtPtx2646R1145,
		  r_MmaAccumulatorHalf2WordAtPtx2646R1146); // PTX L2660
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2667R1147, r_MmaAccumulatorHalf2WordAtPtx2667R1148,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx106R2070, r_MmaBE4x4WordAtPtx106R2069,
		  r_PackedHalf2AtPtx2137R2037,
		  r_PackedHalf2AtPtx2144R2036); // PTX L2667
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2674R1149, r_MmaAccumulatorHalf2WordAtPtx2674R1150,
		  r_MmaAE4x4WordAtPtx2517R1127, r_MmaAE4x4WordAtPtx2517R1128, r_MmaAE4x4WordAtPtx2517R1129,
		  r_MmaAE4x4WordAtPtx2517R1130, r_MmaBE4x4WordAtPtx106R2068, r_MmaBE4x4WordAtPtx106R2067,
		  r_PackedHalf2AtPtx2151R2035,
		  r_PackedHalf2AtPtx2158R2034); // PTX L2674
	MmaE4(r_PackedHalf2AtPtx2137R2037, r_PackedHalf2AtPtx2144R2036, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx142R2054, r_MmaBE4x4WordAtPtx142R2053, r_MmaAccumulatorHalf2WordAtPtx2667R1147,
		  r_MmaAccumulatorHalf2WordAtPtx2667R1148); // PTX L2681
	MmaE4(r_PackedHalf2AtPtx2151R2035, r_PackedHalf2AtPtx2158R2034, r_MmaAE4x4WordAtPtx2526R1131,
		  r_MmaAE4x4WordAtPtx2526R1132, r_MmaAE4x4WordAtPtx2526R1133, r_MmaAE4x4WordAtPtx2526R1134,
		  r_MmaBE4x4WordAtPtx142R2052, r_MmaBE4x4WordAtPtx142R2051, r_MmaAccumulatorHalf2WordAtPtx2674R1149,
		  r_MmaAccumulatorHalf2WordAtPtx2674R1150); // PTX L2688
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2695R1159, r_MmaAccumulatorHalf2WordAtPtx2695R1160,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx78R2082, r_MmaBE4x4WordAtPtx78R2081,
		  r_PackedHalf2AtPtx2165R2033,
		  r_PackedHalf2AtPtx2172R2032); // PTX L2695
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2702R1161, r_MmaAccumulatorHalf2WordAtPtx2702R1162,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx78R2080, r_MmaBE4x4WordAtPtx78R2079,
		  r_PackedHalf2AtPtx2179R2031,
		  r_PackedHalf2AtPtx2186R2030); // PTX L2702
	MmaE4(r_PackedHalf2AtPtx2165R2033, r_PackedHalf2AtPtx2172R2032, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx115R2066, r_MmaBE4x4WordAtPtx115R2065, r_MmaAccumulatorHalf2WordAtPtx2695R1159,
		  r_MmaAccumulatorHalf2WordAtPtx2695R1160); // PTX L2709
	MmaE4(r_PackedHalf2AtPtx2179R2031, r_PackedHalf2AtPtx2186R2030, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx115R2064, r_MmaBE4x4WordAtPtx115R2063, r_MmaAccumulatorHalf2WordAtPtx2702R1161,
		  r_MmaAccumulatorHalf2WordAtPtx2702R1162); // PTX L2716
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2723R1163, r_MmaAccumulatorHalf2WordAtPtx2723R1164,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx87R2078, r_MmaBE4x4WordAtPtx87R2077,
		  r_PackedHalf2AtPtx2193R2029,
		  r_PackedHalf2AtPtx2200R2028); // PTX L2723
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2730R1165, r_MmaAccumulatorHalf2WordAtPtx2730R1166,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx87R2076, r_MmaBE4x4WordAtPtx87R2075,
		  r_PackedHalf2AtPtx2207R2027,
		  r_PackedHalf2AtPtx2214R2026); // PTX L2730
	MmaE4(r_PackedHalf2AtPtx2193R2029, r_PackedHalf2AtPtx2200R2028, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx124R2062, r_MmaBE4x4WordAtPtx124R2061, r_MmaAccumulatorHalf2WordAtPtx2723R1163,
		  r_MmaAccumulatorHalf2WordAtPtx2723R1164); // PTX L2737
	MmaE4(r_PackedHalf2AtPtx2207R2027, r_PackedHalf2AtPtx2214R2026, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx124R2060, r_MmaBE4x4WordAtPtx124R2059, r_MmaAccumulatorHalf2WordAtPtx2730R1165,
		  r_MmaAccumulatorHalf2WordAtPtx2730R1166); // PTX L2744
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2751R1167, r_MmaAccumulatorHalf2WordAtPtx2751R1168,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx97R2074, r_MmaBE4x4WordAtPtx97R2073,
		  r_PackedHalf2AtPtx2221R2025,
		  r_PackedHalf2AtPtx2228R2024); // PTX L2751
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2758R1169, r_MmaAccumulatorHalf2WordAtPtx2758R1170,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx97R2072, r_MmaBE4x4WordAtPtx97R2071,
		  r_PackedHalf2AtPtx2235R2023,
		  r_PackedHalf2AtPtx2242R2022); // PTX L2758
	MmaE4(r_PackedHalf2AtPtx2221R2025, r_PackedHalf2AtPtx2228R2024, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx133R2058, r_MmaBE4x4WordAtPtx133R2057, r_MmaAccumulatorHalf2WordAtPtx2751R1167,
		  r_MmaAccumulatorHalf2WordAtPtx2751R1168); // PTX L2765
	MmaE4(r_PackedHalf2AtPtx2235R2023, r_PackedHalf2AtPtx2242R2022, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx133R2056, r_MmaBE4x4WordAtPtx133R2055, r_MmaAccumulatorHalf2WordAtPtx2758R1169,
		  r_MmaAccumulatorHalf2WordAtPtx2758R1170); // PTX L2772
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2779R1171, r_MmaAccumulatorHalf2WordAtPtx2779R1172,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx106R2070, r_MmaBE4x4WordAtPtx106R2069,
		  r_PackedHalf2AtPtx2249R2021,
		  r_PackedHalf2AtPtx2256R2020); // PTX L2779
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2786R1173, r_MmaAccumulatorHalf2WordAtPtx2786R1174,
		  r_MmaAE4x4WordAtPtx2535R1151, r_MmaAE4x4WordAtPtx2535R1152, r_MmaAE4x4WordAtPtx2535R1153,
		  r_MmaAE4x4WordAtPtx2535R1154, r_MmaBE4x4WordAtPtx106R2068, r_MmaBE4x4WordAtPtx106R2067,
		  r_PackedHalf2AtPtx2263R2019,
		  r_PackedHalf2AtPtx2270R2018); // PTX L2786
	MmaE4(r_PackedHalf2AtPtx2249R2021, r_PackedHalf2AtPtx2256R2020, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx142R2054, r_MmaBE4x4WordAtPtx142R2053, r_MmaAccumulatorHalf2WordAtPtx2779R1171,
		  r_MmaAccumulatorHalf2WordAtPtx2779R1172); // PTX L2793
	MmaE4(r_PackedHalf2AtPtx2263R2019, r_PackedHalf2AtPtx2270R2018, r_MmaAE4x4WordAtPtx2544R1155,
		  r_MmaAE4x4WordAtPtx2544R1156, r_MmaAE4x4WordAtPtx2544R1157, r_MmaAE4x4WordAtPtx2544R1158,
		  r_MmaBE4x4WordAtPtx142R2052, r_MmaBE4x4WordAtPtx142R2051, r_MmaAccumulatorHalf2WordAtPtx2786R1173,
		  r_MmaAccumulatorHalf2WordAtPtx2786R1174); // PTX L2800
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2807R1183, r_MmaAccumulatorHalf2WordAtPtx2807R1184,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx78R2082, r_MmaBE4x4WordAtPtx78R2081,
		  r_PackedHalf2AtPtx2277R2017,
		  r_PackedHalf2AtPtx2284R2016); // PTX L2807
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2814R1185, r_MmaAccumulatorHalf2WordAtPtx2814R1186,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx78R2080, r_MmaBE4x4WordAtPtx78R2079,
		  r_PackedHalf2AtPtx2291R2015,
		  r_PackedHalf2AtPtx2298R2014); // PTX L2814
	MmaE4(r_PackedHalf2AtPtx2277R2017, r_PackedHalf2AtPtx2284R2016, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx115R2066, r_MmaBE4x4WordAtPtx115R2065, r_MmaAccumulatorHalf2WordAtPtx2807R1183,
		  r_MmaAccumulatorHalf2WordAtPtx2807R1184); // PTX L2821
	MmaE4(r_PackedHalf2AtPtx2291R2015, r_PackedHalf2AtPtx2298R2014, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx115R2064, r_MmaBE4x4WordAtPtx115R2063, r_MmaAccumulatorHalf2WordAtPtx2814R1185,
		  r_MmaAccumulatorHalf2WordAtPtx2814R1186); // PTX L2828
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2835R1187, r_MmaAccumulatorHalf2WordAtPtx2835R1188,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx87R2078, r_MmaBE4x4WordAtPtx87R2077,
		  r_PackedHalf2AtPtx2305R2013,
		  r_PackedHalf2AtPtx2312R2012); // PTX L2835
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2842R1189, r_MmaAccumulatorHalf2WordAtPtx2842R1190,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx87R2076, r_MmaBE4x4WordAtPtx87R2075,
		  r_PackedHalf2AtPtx2319R2011,
		  r_PackedHalf2AtPtx2326R2010); // PTX L2842
	MmaE4(r_PackedHalf2AtPtx2305R2013, r_PackedHalf2AtPtx2312R2012, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx124R2062, r_MmaBE4x4WordAtPtx124R2061, r_MmaAccumulatorHalf2WordAtPtx2835R1187,
		  r_MmaAccumulatorHalf2WordAtPtx2835R1188); // PTX L2849
	MmaE4(r_PackedHalf2AtPtx2319R2011, r_PackedHalf2AtPtx2326R2010, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx124R2060, r_MmaBE4x4WordAtPtx124R2059, r_MmaAccumulatorHalf2WordAtPtx2842R1189,
		  r_MmaAccumulatorHalf2WordAtPtx2842R1190); // PTX L2856
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2863R1191, r_MmaAccumulatorHalf2WordAtPtx2863R1192,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx97R2074, r_MmaBE4x4WordAtPtx97R2073,
		  r_PackedHalf2AtPtx2333R2009,
		  r_PackedHalf2AtPtx2340R2008); // PTX L2863
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2870R1193, r_MmaAccumulatorHalf2WordAtPtx2870R1194,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx97R2072, r_MmaBE4x4WordAtPtx97R2071,
		  r_PackedHalf2AtPtx2347R2007,
		  r_PackedHalf2AtPtx2354R2006); // PTX L2870
	MmaE4(r_PackedHalf2AtPtx2333R2009, r_PackedHalf2AtPtx2340R2008, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx133R2058, r_MmaBE4x4WordAtPtx133R2057, r_MmaAccumulatorHalf2WordAtPtx2863R1191,
		  r_MmaAccumulatorHalf2WordAtPtx2863R1192); // PTX L2877
	MmaE4(r_PackedHalf2AtPtx2347R2007, r_PackedHalf2AtPtx2354R2006, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx133R2056, r_MmaBE4x4WordAtPtx133R2055, r_MmaAccumulatorHalf2WordAtPtx2870R1193,
		  r_MmaAccumulatorHalf2WordAtPtx2870R1194); // PTX L2884
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2891R1195, r_MmaAccumulatorHalf2WordAtPtx2891R1196,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx106R2070, r_MmaBE4x4WordAtPtx106R2069,
		  r_PackedHalf2AtPtx2361R2005,
		  r_PackedHalf2AtPtx2368R2004); // PTX L2891
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2898R1197, r_MmaAccumulatorHalf2WordAtPtx2898R1198,
		  r_MmaAE4x4WordAtPtx2553R1175, r_MmaAE4x4WordAtPtx2553R1176, r_MmaAE4x4WordAtPtx2553R1177,
		  r_MmaAE4x4WordAtPtx2553R1178, r_MmaBE4x4WordAtPtx106R2068, r_MmaBE4x4WordAtPtx106R2067,
		  r_PackedHalf2AtPtx2375R2003,
		  r_PackedHalf2AtPtx2382R2002); // PTX L2898
	MmaE4(r_PackedHalf2AtPtx2361R2005, r_PackedHalf2AtPtx2368R2004, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx142R2054, r_MmaBE4x4WordAtPtx142R2053, r_MmaAccumulatorHalf2WordAtPtx2891R1195,
		  r_MmaAccumulatorHalf2WordAtPtx2891R1196); // PTX L2905
	MmaE4(r_PackedHalf2AtPtx2375R2003, r_PackedHalf2AtPtx2382R2002, r_MmaAE4x4WordAtPtx2562R1179,
		  r_MmaAE4x4WordAtPtx2562R1180, r_MmaAE4x4WordAtPtx2562R1181, r_MmaAE4x4WordAtPtx2562R1182,
		  r_MmaBE4x4WordAtPtx142R2052, r_MmaBE4x4WordAtPtx142R2051, r_MmaAccumulatorHalf2WordAtPtx2898R1197,
		  r_MmaAccumulatorHalf2WordAtPtx2898R1198); // PTX L2912
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2919R1207, r_MmaAccumulatorHalf2WordAtPtx2919R1208,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx78R2082, r_MmaBE4x4WordAtPtx78R2081,
		  r_PackedHalf2AtPtx2389R2001,
		  r_PackedHalf2AtPtx2396R2000); // PTX L2919
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2926R1209, r_MmaAccumulatorHalf2WordAtPtx2926R1210,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx78R2080, r_MmaBE4x4WordAtPtx78R2079,
		  r_PackedHalf2AtPtx2403R1999,
		  r_PackedHalf2AtPtx2410R1998); // PTX L2926
	MmaE4(r_PackedHalf2AtPtx2389R2001, r_PackedHalf2AtPtx2396R2000, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx115R2066, r_MmaBE4x4WordAtPtx115R2065, r_MmaAccumulatorHalf2WordAtPtx2919R1207,
		  r_MmaAccumulatorHalf2WordAtPtx2919R1208); // PTX L2933
	MmaE4(r_PackedHalf2AtPtx2403R1999, r_PackedHalf2AtPtx2410R1998, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx115R2064, r_MmaBE4x4WordAtPtx115R2063, r_MmaAccumulatorHalf2WordAtPtx2926R1209,
		  r_MmaAccumulatorHalf2WordAtPtx2926R1210); // PTX L2940
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2947R1211, r_MmaAccumulatorHalf2WordAtPtx2947R1212,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx87R2078, r_MmaBE4x4WordAtPtx87R2077,
		  r_PackedHalf2AtPtx2417R1997,
		  r_PackedHalf2AtPtx2424R1996); // PTX L2947
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2954R1213, r_MmaAccumulatorHalf2WordAtPtx2954R1214,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx87R2076, r_MmaBE4x4WordAtPtx87R2075,
		  r_PackedHalf2AtPtx2431R1995,
		  r_PackedHalf2AtPtx2438R1994); // PTX L2954
	MmaE4(r_PackedHalf2AtPtx2417R1997, r_PackedHalf2AtPtx2424R1996, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx124R2062, r_MmaBE4x4WordAtPtx124R2061, r_MmaAccumulatorHalf2WordAtPtx2947R1211,
		  r_MmaAccumulatorHalf2WordAtPtx2947R1212); // PTX L2961
	MmaE4(r_PackedHalf2AtPtx2431R1995, r_PackedHalf2AtPtx2438R1994, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx124R2060, r_MmaBE4x4WordAtPtx124R2059, r_MmaAccumulatorHalf2WordAtPtx2954R1213,
		  r_MmaAccumulatorHalf2WordAtPtx2954R1214); // PTX L2968
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2975R1215, r_MmaAccumulatorHalf2WordAtPtx2975R1216,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx97R2074, r_MmaBE4x4WordAtPtx97R2073,
		  r_PackedHalf2AtPtx2445R1993,
		  r_PackedHalf2AtPtx2452R1992); // PTX L2975
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx2982R1217, r_MmaAccumulatorHalf2WordAtPtx2982R1218,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx97R2072, r_MmaBE4x4WordAtPtx97R2071,
		  r_PackedHalf2AtPtx2459R1991,
		  r_PackedHalf2AtPtx2466R1990); // PTX L2982
	MmaE4(r_PackedHalf2AtPtx2445R1993, r_PackedHalf2AtPtx2452R1992, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx133R2058, r_MmaBE4x4WordAtPtx133R2057, r_MmaAccumulatorHalf2WordAtPtx2975R1215,
		  r_MmaAccumulatorHalf2WordAtPtx2975R1216); // PTX L2989
	MmaE4(r_PackedHalf2AtPtx2459R1991, r_PackedHalf2AtPtx2466R1990, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx133R2056, r_MmaBE4x4WordAtPtx133R2055, r_MmaAccumulatorHalf2WordAtPtx2982R1217,
		  r_MmaAccumulatorHalf2WordAtPtx2982R1218); // PTX L2996
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3003R1219, r_MmaAccumulatorHalf2WordAtPtx3003R1220,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx106R2070, r_MmaBE4x4WordAtPtx106R2069,
		  r_PackedHalf2AtPtx2473R1989,
		  r_PackedHalf2AtPtx2480R1988); // PTX L3003
	MmaE4(r_MmaAccumulatorHalf2WordAtPtx3010R1221, r_MmaAccumulatorHalf2WordAtPtx3010R1222,
		  r_MmaAE4x4WordAtPtx2571R1199, r_MmaAE4x4WordAtPtx2571R1200, r_MmaAE4x4WordAtPtx2571R1201,
		  r_MmaAE4x4WordAtPtx2571R1202, r_MmaBE4x4WordAtPtx106R2068, r_MmaBE4x4WordAtPtx106R2067,
		  r_PackedHalf2AtPtx2487R1987,
		  r_PackedHalf2AtPtx2494R1986); // PTX L3010
	MmaE4(r_PackedHalf2AtPtx2473R1989, r_PackedHalf2AtPtx2480R1988, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx142R2054, r_MmaBE4x4WordAtPtx142R2053, r_MmaAccumulatorHalf2WordAtPtx3003R1219,
		  r_MmaAccumulatorHalf2WordAtPtx3003R1220); // PTX L3017
	MmaE4(r_PackedHalf2AtPtx2487R1987, r_PackedHalf2AtPtx2494R1986, r_MmaAE4x4WordAtPtx2580R1203,
		  r_MmaAE4x4WordAtPtx2580R1204, r_MmaAE4x4WordAtPtx2580R1205, r_MmaAE4x4WordAtPtx2580R1206,
		  r_MmaBE4x4WordAtPtx142R2052, r_MmaBE4x4WordAtPtx142R2051, r_MmaAccumulatorHalf2WordAtPtx3010R1221,
		  r_MmaAccumulatorHalf2WordAtPtx3010R1222);					 // PTX L3024
	r_bPtxPredicate62 = uint32_t(r_PtxRegister2050) > uint32_t(447); // PTX L3030
	if (r_bPtxPredicate62)
	{
		goto L__BB35_98;
	} // PTX L3031
	r_PtxRegister1251 = uint32_t(r_PtxRegister2050) + uint32_t(64);							   // PTX L3032
	r_PtxRegister1252 = uint32_t(r_PtxRegister1251) + uint32_t(r_PtxRegister194);			   // PTX L3033
	r_PtxRegister1253 = ShiftLeft(uint32_t(r_PtxRegister1252), uint32_t(7));				   // PTX L3034
	r_PtxRegister1254 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));					   // PTX L3035
	r_PtxRegister1255 = uint32_t(r_PtxRegister141) + uint32_t(r_PtxRegister1254);			   // PTX L3036
	r_PtxRegister1256 = ShiftLeft(uint32_t(r_PtxRegister1255), uint32_t(3));				   // PTX L3037
	r_PtxRegister1257 = uint32_t(r_PtxRegister1253) + uint32_t(r_PtxRegister1256);			   // PTX L3038
	r_PtxU64Register213 = uint64_t(int64_t(int32_t(r_PtxRegister1257)) * int64_t(int32_t(4))); // PTX L3039
	r_PtxU64Register214 = uint64_t(r_Pointer24Bits) + uint64_t(r_PtxU64Register213);		   // PTX L3040
	r_LaneIndexAtPtx3042 = uint32_t((threadIdx.x & 31u));									   // PTX L3042
	r_PtxU64Register215 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3042)) * int64_t(int32_t(16)));		 // PTX L3044
	r_PtxU64Register205 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register215); // PTX L3045
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register205));
		r_MmaBE4x4WordAtPtx78R2082 = r_Value.x;
		r_MmaBE4x4WordAtPtx78R2081 = r_Value.y;
		r_MmaBE4x4WordAtPtx78R2080 = r_Value.z;
		r_MmaBE4x4WordAtPtx78R2079 = r_Value.w;
	} // PTX L3047
	r_LaneIndexAtPtx3050 = uint32_t((threadIdx.x & 31u)); // PTX L3050
	r_PtxU64Register216 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3050)) * int64_t(int32_t(16)));		 // PTX L3052
	r_PtxU64Register217 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register216); // PTX L3053
	r_PtxU64Register206 = uint64_t(r_PtxU64Register217) + uint64_t(512);				 // PTX L3054
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register206));
		r_MmaBE4x4WordAtPtx87R2078 = r_Value.x;
		r_MmaBE4x4WordAtPtx87R2077 = r_Value.y;
		r_MmaBE4x4WordAtPtx87R2076 = r_Value.z;
		r_MmaBE4x4WordAtPtx87R2075 = r_Value.w;
	} // PTX L3056
	r_LaneIndexAtPtx3059 = uint32_t((threadIdx.x & 31u)); // PTX L3059
	r_PtxU64Register218 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3059)) * int64_t(int32_t(16)));		 // PTX L3061
	r_PtxU64Register219 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register218); // PTX L3062
	r_PtxU64Register207 = uint64_t(r_PtxU64Register219) + uint64_t(1024);				 // PTX L3063
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register207));
		r_MmaBE4x4WordAtPtx97R2074 = r_Value.x;
		r_MmaBE4x4WordAtPtx97R2073 = r_Value.y;
		r_MmaBE4x4WordAtPtx97R2072 = r_Value.z;
		r_MmaBE4x4WordAtPtx97R2071 = r_Value.w;
	} // PTX L3065
	r_LaneIndexAtPtx3068 = uint32_t((threadIdx.x & 31u)); // PTX L3068
	r_PtxU64Register220 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3068)) * int64_t(int32_t(16)));		 // PTX L3070
	r_PtxU64Register221 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register220); // PTX L3071
	r_PtxU64Register208 = uint64_t(r_PtxU64Register221) + uint64_t(1536);				 // PTX L3072
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register208));
		r_MmaBE4x4WordAtPtx106R2070 = r_Value.x;
		r_MmaBE4x4WordAtPtx106R2069 = r_Value.y;
		r_MmaBE4x4WordAtPtx106R2068 = r_Value.z;
		r_MmaBE4x4WordAtPtx106R2067 = r_Value.w;
	} // PTX L3074
	r_LaneIndexAtPtx3077 = uint32_t((threadIdx.x & 31u)); // PTX L3077
	r_PtxU64Register222 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3077)) * int64_t(int32_t(16)));		 // PTX L3079
	r_PtxU64Register223 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register222); // PTX L3080
	r_PtxU64Register209 = uint64_t(r_PtxU64Register223) + uint64_t(16384);				 // PTX L3081
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register209));
		r_MmaBE4x4WordAtPtx115R2066 = r_Value.x;
		r_MmaBE4x4WordAtPtx115R2065 = r_Value.y;
		r_MmaBE4x4WordAtPtx115R2064 = r_Value.z;
		r_MmaBE4x4WordAtPtx115R2063 = r_Value.w;
	} // PTX L3083
	r_LaneIndexAtPtx3086 = uint32_t((threadIdx.x & 31u)); // PTX L3086
	r_PtxU64Register224 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3086)) * int64_t(int32_t(16)));		 // PTX L3088
	r_PtxU64Register225 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register224); // PTX L3089
	r_PtxU64Register210 = uint64_t(r_PtxU64Register225) + uint64_t(16896);				 // PTX L3090
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register210));
		r_MmaBE4x4WordAtPtx124R2062 = r_Value.x;
		r_MmaBE4x4WordAtPtx124R2061 = r_Value.y;
		r_MmaBE4x4WordAtPtx124R2060 = r_Value.z;
		r_MmaBE4x4WordAtPtx124R2059 = r_Value.w;
	} // PTX L3092
	r_LaneIndexAtPtx3095 = uint32_t((threadIdx.x & 31u)); // PTX L3095
	r_PtxU64Register226 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3095)) * int64_t(int32_t(16)));		 // PTX L3097
	r_PtxU64Register227 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register226); // PTX L3098
	r_PtxU64Register211 = uint64_t(r_PtxU64Register227) + uint64_t(17408);				 // PTX L3099
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register211));
		r_MmaBE4x4WordAtPtx133R2058 = r_Value.x;
		r_MmaBE4x4WordAtPtx133R2057 = r_Value.y;
		r_MmaBE4x4WordAtPtx133R2056 = r_Value.z;
		r_MmaBE4x4WordAtPtx133R2055 = r_Value.w;
	} // PTX L3101
	r_LaneIndexAtPtx3104 = uint32_t((threadIdx.x & 31u)); // PTX L3104
	r_PtxU64Register228 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx3104)) * int64_t(int32_t(16)));		 // PTX L3106
	r_PtxU64Register229 = uint64_t(r_PtxU64Register214) + uint64_t(r_PtxU64Register228); // PTX L3107
	r_PtxU64Register212 = uint64_t(r_PtxU64Register229) + uint64_t(17920);				 // PTX L3108
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register212));
		r_MmaBE4x4WordAtPtx142R2054 = r_Value.x;
		r_MmaBE4x4WordAtPtx142R2053 = r_Value.y;
		r_MmaBE4x4WordAtPtx142R2052 = r_Value.z;
		r_MmaBE4x4WordAtPtx142R2051 = r_Value.w;
	} // PTX L3110
	r_PtxRegister1258 = ShiftRight(uint32_t(r_PtxRegister1251), uint32_t(6)); // PTX L3112
	r_PtxU16Register163 = uint16_t(r_PtxRegister1258);						  // PTX L3113
	r_PtxU16Register164 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register163)) * uint32_t(uint16_t(171))); // PTX L3114
	r_PtxU16Register165 = ShiftRight(uint16_t(r_PtxU16Register164), uint32_t(9));	 // PTX L3115
	r_PtxU16Register166 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register165)) * uint32_t(uint16_t(3)));				// PTX L3116
	r_PtxU16Register167 = uint16_t(r_PtxU16Register163) - uint16_t(r_PtxU16Register166);		// PTX L3117
	r_PtxU16Register168 = r_PtxU16Register167 & 255;											// PTX L3118
	r_PtxRegister1259 = uint32_t(uint16_t(r_PtxU16Register168)) * uint32_t(uint16_t(8));		// PTX L3119
	r_PtxRegister1260 = uint32_t(12288u /* exact native shared-region offset */);				// PTX L3120
	r_PtxRegister1262 = uint32_t(r_PtxRegister1260) + uint32_t(r_PtxRegister1259);				// PTX L3121
	r_PtxRegister1250 = uint32_t(1);															// PTX L3122
	r_PtxU64Register230 = BarrierArrive(s_SharedStorage, r_PtxRegister1262, r_PtxRegister1250); // PTX L3124
L__BB35_97:																						// PTX L3126
	r_PtxRegister1261 = BarrierReady(s_SharedStorage, r_PtxRegister1262, r_PtxU64Register230);	// PTX L3128
	r_bPtxPredicate63 = uint32_t(r_PtxRegister1261) == uint32_t(0);								// PTX L3134
	if (r_bPtxPredicate63)
	{
		goto L__BB35_97;
	} // PTX L3135
L__BB35_98:															 // PTX L3136
	r_bPtxPredicate64 = uint32_t(r_PtxRegister2050) > uint32_t(319); // PTX L3137
	if (r_bPtxPredicate64)
	{
		goto L__BB35_115;
	} // PTX L3138
	r_bPtxPredicate65 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7);	   // PTX L3139
	r_bPtxPredicate66 = int32_t(r_PtxRegister152) < int32_t(r_PtxRegister6);   // PTX L3140
	r_bPtxPredicate67 = int32_t(r_PtxRegister152) >= int32_t(r_PtxRegister6);  // PTX L3141
	r_bPtxPredicate68 = uint32_t(r_PtxRegister24) == uint32_t(4);			   // PTX L3142
	r_bPtxPredicate69 = uint32_t(r_PtxRegister16) == uint32_t(4);			   // PTX L3143
	r_bPtxPredicate70 = r_bPtxPredicate3 & r_bPtxPredicate67;				   // PTX L3144
	r_bPtxPredicate71 = r_bPtxPredicate69 | r_bPtxPredicate66;				   // PTX L3145
	r_bPtxPredicate72 = r_bPtxPredicate70 | r_bPtxPredicate68;				   // PTX L3146
	r_PtxRegister1263 = r_bPtxPredicate70 ? r_PtxRegister15 : 0;			   // PTX L3147
	r_PtxRegister35 = r_bPtxPredicate68 ? r_PtxRegister1263 : r_PtxRegister15; // PTX L3148
	r_bPtxPredicate73 = r_bPtxPredicate72 | r_bPtxPredicate65;				   // PTX L3149
	r_bPtxPredicate14 = r_bPtxPredicate73 & r_bPtxPredicate71;				   // PTX L3150
	r_PtxU64Register311 = uint64_t(0);										   // PTX L3151
	r_bPtxPredicate74 = !r_bPtxPredicate14;									   // PTX L3152
	if (r_bPtxPredicate74)
	{
		goto L__BB35_101;
	} // PTX L3153
	r_PtxRegister1264 =
		uint32_t(r_PtxRegister152) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister35); // PTX L3154
	r_PtxRegister1265 = r_bPtxPredicate69 ? r_PtxRegister35 : r_PtxRegister1264;		   // PTX L3155
	r_PtxRegister1266 = uint32_t(r_PtxRegister194) + uint32_t(r_PtxRegister2050);		   // PTX L3156
	r_PtxRegister1267 = uint32_t(r_PtxRegister1266) + uint32_t(192);					   // PTX L3157
	r_PtxRegister1268 = ShiftRight(uint32_t(r_PtxRegister1267), uint32_t(5));			   // PTX L3158
	r_PtxRegister1269 = uint32_t(r_PtxRegister1268) + uint32_t(r_PtxRegister11);		   // PTX L3159
	r_PtxRegister1270 = ShiftLeft(uint32_t(r_PtxRegister1265), uint32_t(11));			   // PTX L3160
	r_PtxRegister1271 = ShiftLeft(uint32_t(r_PtxRegister1269), uint32_t(7));			   // PTX L3161
	r_PtxRegister1272 = uint32_t(r_PtxRegister1270) + uint32_t(r_PtxRegister1271);		   // PTX L3162
	r_PtxU64Register311 = SignExtendWordBits(r_PtxRegister1272);						   // PTX L3163
L__BB35_101:																			   // PTX L3164
	r_PtxU64Register312 = uint64_t(0);													   // PTX L3165
	if (r_bPtxPredicate74)
	{
		goto L__BB35_103;
	} // PTX L3166
	r_PtxU64Register231 = ShiftLeft(uint64_t(r_PtxU64Register311), uint32_t(2));	// PTX L3167
	r_PtxU64Register312 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register231); // PTX L3168
L__BB35_103:																		// PTX L3169
	r_PtxRegister1273 = ShiftLeft(uint32_t(r_PtxRegister33), uint32_t(3));			// PTX L3170
	r_PtxRegister1274 = uint32_t(12288u /* exact native shared-region offset */);	// PTX L3171
	r_PtxRegister1322 = uint32_t(r_PtxRegister1274) + uint32_t(r_PtxRegister1273);	// PTX L3172
	if (r_bPtxPredicate74)
	{
		goto L__BB35_106;
	} // PTX L3173
	r_PtxRegister1287 = uint32_t(-1);								// PTX L3174
	r_PtxRegister1286 = Elected(r_PtxRegister1287);					// PTX L3176
	r_bPtxPredicate75 = uint32_t(r_PtxRegister1286) == uint32_t(0); // PTX L3182
	if (r_bPtxPredicate75)
	{
		goto L__BB35_107;
	} // PTX L3183
	r_PtxRegister1290 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));			 // PTX L3184
	r_PtxRegister1288 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1290); // PTX L3185
	r_PtxU64Register232 = r_PtxU64Register312;									 // PTX L3186
	r_PtxRegister1289 = uint32_t(512);											 // PTX L3187
	CopyBulk(s_SharedStorage, r_PtxRegister1288, r_PtxU64Register232, r_PtxRegister1289,
			 r_PtxRegister1322);																 // PTX L3189
	BarrierExpect(s_SharedStorage, r_PtxRegister1322, r_PtxRegister1289);						 // PTX L3192
	goto L__BB35_107;																			 // PTX L3194
L__BB35_106:																					 // PTX L3195
	r_PtxRegister1275 = uint32_t(0);															 // PTX L3196
	r_PtxU16Register169 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1275))); // PTX L3198
	r_PackedHalf2AtPtx3201R1276 = JoinHalfwords(r_PtxU16Register169, r_PtxU16Register169);		 // PTX L3201
	r_ConvertedE4PairAtPtx3203Rs170 = PublishE4(r_PackedHalf2AtPtx3201R1276);					 // PTX L3203
	r_PackedE4WordAtPtx3205R1279 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3203Rs170, r_ConvertedE4PairAtPtx3203Rs170); // PTX L3205
	r_LaneIndexAtPtx3207 = uint32_t((threadIdx.x & 31u));								 // PTX L3207
	r_PtxRegister1280 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(9));				 // PTX L3209
	r_PtxRegister1281 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));					 // PTX L3210
	r_PtxRegister1282 = r_PtxRegister1281 & 523264;										 // PTX L3211
	r_PtxRegister1283 = r_PtxRegister1280 | r_PtxRegister1282;							 // PTX L3212
	r_PtxRegister1284 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1283);		 // PTX L3213
	r_PtxRegister1285 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3207), uint32_t(4));			 // PTX L3214
	r_PtxRegister1278 = uint32_t(r_PtxRegister1284) + uint32_t(r_PtxRegister1285);		 // PTX L3215
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1278)) =
		make_uint4(r_PackedE4WordAtPtx3205R1279, r_PackedE4WordAtPtx3205R1279, r_PackedE4WordAtPtx3205R1279,
				   r_PackedE4WordAtPtx3205R1279);							   // PTX L3217
L__BB35_107:																   // PTX L3219
	r_PtxRegister1291 = uint32_t(r_PtxRegister172) + uint32_t(r_PtxRegister3); // PTX L3220
	r_bPtxPredicate76 = int32_t(r_PtxRegister1291) < int32_t(r_PtxRegister6);  // PTX L3221
	r_bPtxPredicate77 = int32_t(r_PtxRegister1291) >= int32_t(r_PtxRegister6); // PTX L3222
	r_bPtxPredicate78 = int32_t(r_PtxRegister15) < int32_t(r_PtxRegister7);	   // PTX L3223
	r_bPtxPredicate79 = uint32_t(r_PtxRegister24) == uint32_t(4);			   // PTX L3224
	r_bPtxPredicate80 = uint32_t(r_PtxRegister16) == uint32_t(4);			   // PTX L3225
	r_bPtxPredicate81 = r_bPtxPredicate3 & r_bPtxPredicate77;				   // PTX L3226
	r_bPtxPredicate82 = r_bPtxPredicate80 | r_bPtxPredicate76;				   // PTX L3227
	r_bPtxPredicate83 = r_bPtxPredicate81 | r_bPtxPredicate79;				   // PTX L3228
	r_PtxRegister1292 = r_bPtxPredicate81 ? r_PtxRegister15 : 0;			   // PTX L3229
	r_PtxRegister36 = r_bPtxPredicate79 ? r_PtxRegister1292 : r_PtxRegister15; // PTX L3230
	r_bPtxPredicate84 = r_bPtxPredicate83 | r_bPtxPredicate78;				   // PTX L3231
	r_bPtxPredicate15 = r_bPtxPredicate84 & r_bPtxPredicate82;				   // PTX L3232
	r_PtxU64Register313 = uint64_t(0);										   // PTX L3233
	r_bPtxPredicate85 = !r_bPtxPredicate15;									   // PTX L3234
	if (r_bPtxPredicate85)
	{
		goto L__BB35_109;
	} // PTX L3235
	r_PtxRegister1293 =
		uint32_t(r_PtxRegister1291) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister36); // PTX L3236
	r_PtxRegister1294 = r_bPtxPredicate80 ? r_PtxRegister36 : r_PtxRegister1293;			// PTX L3237
	r_CtaZAtPtx3238 = uint32_t(blockIdx.z);													// PTX L3238
	r_PtxRegister1296 = ShiftLeft(uint32_t(r_CtaZAtPtx3238), uint32_t(9));					// PTX L3239
	r_PtxRegister1297 = uint32_t(r_PtxRegister1296) + uint32_t(r_PtxRegister2050);			// PTX L3240
	r_PtxRegister1298 = uint32_t(r_PtxRegister1297) + uint32_t(192);						// PTX L3241
	r_PtxRegister1299 = ShiftRight(uint32_t(r_PtxRegister1298), uint32_t(5));				// PTX L3242
	r_PtxRegister1300 = uint32_t(r_PtxRegister1299) + uint32_t(r_PtxRegister11);			// PTX L3243
	r_PtxRegister1301 = ShiftLeft(uint32_t(r_PtxRegister1294), uint32_t(11));				// PTX L3244
	r_PtxRegister1302 = ShiftLeft(uint32_t(r_PtxRegister1300), uint32_t(7));				// PTX L3245
	r_PtxRegister1303 = uint32_t(r_PtxRegister1301) + uint32_t(r_PtxRegister1302);			// PTX L3246
	r_PtxU64Register313 = SignExtendWordBits(r_PtxRegister1303);							// PTX L3247
L__BB35_109:																				// PTX L3248
	r_PtxU64Register314 = uint64_t(0);														// PTX L3249
	if (r_bPtxPredicate85)
	{
		goto L__BB35_111;
	} // PTX L3250
	r_PtxU64Register233 = ShiftLeft(uint64_t(r_PtxU64Register313), uint32_t(2));	// PTX L3251
	r_PtxU64Register314 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register233); // PTX L3252
L__BB35_111:																		// PTX L3253
	if (r_bPtxPredicate85)
	{
		goto L__BB35_114;
	} // PTX L3254
	r_PtxRegister1319 = uint32_t(-1);								// PTX L3255
	r_PtxRegister1318 = Elected(r_PtxRegister1319);					// PTX L3257
	r_bPtxPredicate86 = uint32_t(r_PtxRegister1318) == uint32_t(0); // PTX L3263
	if (r_bPtxPredicate86)
	{
		goto L__BB35_115;
	} // PTX L3264
	r_PtxRegister1323 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));			 // PTX L3265
	r_PtxRegister1324 = r_PtxRegister1323 & 1024;								 // PTX L3266
	r_PtxRegister1325 = uint32_t(r_PtxRegister1323) + uint32_t(2048);			 // PTX L3267
	r_PtxRegister1326 = r_PtxRegister1325 & 1046528;							 // PTX L3268
	r_PtxRegister1327 = r_PtxRegister1326 | r_PtxRegister1324;					 // PTX L3269
	r_PtxRegister1328 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(9));		 // PTX L3270
	r_PtxRegister1329 = r_PtxRegister1328 | r_PtxRegister1327;					 // PTX L3271
	r_PtxRegister1320 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1329); // PTX L3272
	r_PtxU64Register234 = r_PtxU64Register314;									 // PTX L3273
	r_PtxRegister1321 = uint32_t(512);											 // PTX L3274
	CopyBulk(s_SharedStorage, r_PtxRegister1320, r_PtxU64Register234, r_PtxRegister1321,
			 r_PtxRegister1322);																 // PTX L3276
	BarrierExpect(s_SharedStorage, r_PtxRegister1322, r_PtxRegister1321);						 // PTX L3279
	goto L__BB35_115;																			 // PTX L3281
L__BB35_114:																					 // PTX L3282
	r_PtxRegister1304 = uint32_t(0);															 // PTX L3283
	r_PtxU16Register171 = __half_as_ushort(__float2half_rn(__uint_as_float(r_PtxRegister1304))); // PTX L3285
	r_PackedHalf2AtPtx3288R1305 = JoinHalfwords(r_PtxU16Register171, r_PtxU16Register171);		 // PTX L3288
	r_ConvertedE4PairAtPtx3290Rs172 = PublishE4(r_PackedHalf2AtPtx3288R1305);					 // PTX L3290
	r_PackedE4WordAtPtx3292R1308 =
		JoinHalfwords(r_ConvertedE4PairAtPtx3290Rs172, r_ConvertedE4PairAtPtx3290Rs172); // PTX L3292
	r_LaneIndexAtPtx3294 = uint32_t((threadIdx.x & 31u));								 // PTX L3294
	r_PtxRegister1309 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(9));					 // PTX L3296
	r_PtxRegister1310 = r_PtxRegister1309 & 1024;										 // PTX L3297
	r_PtxRegister1311 = uint32_t(r_PtxRegister1309) + uint32_t(2048);					 // PTX L3298
	r_PtxRegister1312 = r_PtxRegister1311 & 1046528;									 // PTX L3299
	r_PtxRegister1313 = r_PtxRegister1312 | r_PtxRegister1310;							 // PTX L3300
	r_PtxRegister1314 = ShiftLeft(uint32_t(r_PtxRegister11), uint32_t(9));				 // PTX L3301
	r_PtxRegister1315 = r_PtxRegister1314 | r_PtxRegister1313;							 // PTX L3302
	r_PtxRegister1316 = uint32_t(r_PtxRegister34) + uint32_t(r_PtxRegister1315);		 // PTX L3303
	r_PtxRegister1317 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3294), uint32_t(4));			 // PTX L3304
	r_PtxRegister1307 = uint32_t(r_PtxRegister1316) + uint32_t(r_PtxRegister1317);		 // PTX L3305
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1307)) =
		make_uint4(r_PackedE4WordAtPtx3292R1308, r_PackedE4WordAtPtx3292R1308, r_PackedE4WordAtPtx3292R1308,
				   r_PackedE4WordAtPtx3292R1308);					 // PTX L3307
L__BB35_115:														 // PTX L3309
	r_bPtxPredicate87 = uint32_t(r_PtxRegister2050) < uint32_t(448); // PTX L3310
	r_PtxRegister2050 = uint32_t(r_PtxRegister2050) + uint32_t(64);	 // PTX L3311
	if (r_bPtxPredicate87)
	{
		goto L__BB35_95;
	} // PTX L3312
	r_PtxU64Register3 = r_Pointer16Bits;											   // PTX L3313
	r_PtxRegister1331 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(4));			   // PTX L3314
	r_PtxU16Register1 = PublishE4(r_PackedHalf2AtPtx2053R2049);						   // PTX L3316
	r_PtxU16Register2 = PublishE4(r_PackedHalf2AtPtx2067R2047);						   // PTX L3319
	r_PtxU16Register3 = PublishE4(r_PackedHalf2AtPtx2060R2048);						   // PTX L3322
	r_PtxU16Register4 = PublishE4(r_PackedHalf2AtPtx2074R2046);						   // PTX L3325
	r_PtxU16Register5 = PublishE4(r_PackedHalf2AtPtx2081R2045);						   // PTX L3328
	r_PtxU16Register6 = PublishE4(r_PackedHalf2AtPtx2095R2043);						   // PTX L3331
	r_PtxU16Register7 = PublishE4(r_PackedHalf2AtPtx2088R2044);						   // PTX L3334
	r_PtxU16Register8 = PublishE4(r_PackedHalf2AtPtx2102R2042);						   // PTX L3337
	r_PtxU16Register9 = PublishE4(r_PackedHalf2AtPtx2109R2041);						   // PTX L3340
	r_PtxU16Register10 = PublishE4(r_PackedHalf2AtPtx2123R2039);					   // PTX L3343
	r_PtxU16Register11 = PublishE4(r_PackedHalf2AtPtx2116R2040);					   // PTX L3346
	r_PtxU16Register12 = PublishE4(r_PackedHalf2AtPtx2130R2038);					   // PTX L3349
	r_PtxU16Register13 = PublishE4(r_PackedHalf2AtPtx2137R2037);					   // PTX L3352
	r_PtxU16Register14 = PublishE4(r_PackedHalf2AtPtx2151R2035);					   // PTX L3355
	r_PtxU16Register15 = PublishE4(r_PackedHalf2AtPtx2144R2036);					   // PTX L3358
	r_PtxU16Register16 = PublishE4(r_PackedHalf2AtPtx2158R2034);					   // PTX L3361
	r_PtxU16Register17 = PublishE4(r_PackedHalf2AtPtx2165R2033);					   // PTX L3364
	r_PtxU16Register18 = PublishE4(r_PackedHalf2AtPtx2179R2031);					   // PTX L3367
	r_PtxU16Register19 = PublishE4(r_PackedHalf2AtPtx2172R2032);					   // PTX L3370
	r_PtxU16Register20 = PublishE4(r_PackedHalf2AtPtx2186R2030);					   // PTX L3373
	r_PtxU16Register21 = PublishE4(r_PackedHalf2AtPtx2193R2029);					   // PTX L3376
	r_PtxU16Register22 = PublishE4(r_PackedHalf2AtPtx2207R2027);					   // PTX L3379
	r_PtxU16Register23 = PublishE4(r_PackedHalf2AtPtx2200R2028);					   // PTX L3382
	r_PtxU16Register24 = PublishE4(r_PackedHalf2AtPtx2214R2026);					   // PTX L3385
	r_PtxU16Register25 = PublishE4(r_PackedHalf2AtPtx2221R2025);					   // PTX L3388
	r_PtxU16Register26 = PublishE4(r_PackedHalf2AtPtx2235R2023);					   // PTX L3391
	r_PtxU16Register27 = PublishE4(r_PackedHalf2AtPtx2228R2024);					   // PTX L3394
	r_PtxU16Register28 = PublishE4(r_PackedHalf2AtPtx2242R2022);					   // PTX L3397
	r_PtxU16Register29 = PublishE4(r_PackedHalf2AtPtx2249R2021);					   // PTX L3400
	r_PtxU16Register30 = PublishE4(r_PackedHalf2AtPtx2263R2019);					   // PTX L3403
	r_PtxU16Register31 = PublishE4(r_PackedHalf2AtPtx2256R2020);					   // PTX L3406
	r_PtxU16Register32 = PublishE4(r_PackedHalf2AtPtx2270R2018);					   // PTX L3409
	r_PtxU16Register33 = PublishE4(r_PackedHalf2AtPtx2277R2017);					   // PTX L3412
	r_PtxU16Register34 = PublishE4(r_PackedHalf2AtPtx2291R2015);					   // PTX L3415
	r_PtxU16Register35 = PublishE4(r_PackedHalf2AtPtx2284R2016);					   // PTX L3418
	r_PtxU16Register36 = PublishE4(r_PackedHalf2AtPtx2298R2014);					   // PTX L3421
	r_PtxU16Register37 = PublishE4(r_PackedHalf2AtPtx2305R2013);					   // PTX L3424
	r_PtxU16Register38 = PublishE4(r_PackedHalf2AtPtx2319R2011);					   // PTX L3427
	r_PtxU16Register39 = PublishE4(r_PackedHalf2AtPtx2312R2012);					   // PTX L3430
	r_PtxU16Register40 = PublishE4(r_PackedHalf2AtPtx2326R2010);					   // PTX L3433
	r_PtxU16Register41 = PublishE4(r_PackedHalf2AtPtx2333R2009);					   // PTX L3436
	r_PtxU16Register42 = PublishE4(r_PackedHalf2AtPtx2347R2007);					   // PTX L3439
	r_PtxU16Register43 = PublishE4(r_PackedHalf2AtPtx2340R2008);					   // PTX L3442
	r_PtxU16Register44 = PublishE4(r_PackedHalf2AtPtx2354R2006);					   // PTX L3445
	r_PtxU16Register45 = PublishE4(r_PackedHalf2AtPtx2361R2005);					   // PTX L3448
	r_PtxU16Register46 = PublishE4(r_PackedHalf2AtPtx2375R2003);					   // PTX L3451
	r_PtxU16Register47 = PublishE4(r_PackedHalf2AtPtx2368R2004);					   // PTX L3454
	r_PtxU16Register48 = PublishE4(r_PackedHalf2AtPtx2382R2002);					   // PTX L3457
	r_PtxU16Register49 = PublishE4(r_PackedHalf2AtPtx2389R2001);					   // PTX L3460
	r_PtxU16Register50 = PublishE4(r_PackedHalf2AtPtx2403R1999);					   // PTX L3463
	r_PtxU16Register51 = PublishE4(r_PackedHalf2AtPtx2396R2000);					   // PTX L3466
	r_PtxU16Register52 = PublishE4(r_PackedHalf2AtPtx2410R1998);					   // PTX L3469
	r_PtxU16Register53 = PublishE4(r_PackedHalf2AtPtx2417R1997);					   // PTX L3472
	r_PtxU16Register54 = PublishE4(r_PackedHalf2AtPtx2431R1995);					   // PTX L3475
	r_PtxU16Register55 = PublishE4(r_PackedHalf2AtPtx2424R1996);					   // PTX L3478
	r_PtxU16Register56 = PublishE4(r_PackedHalf2AtPtx2438R1994);					   // PTX L3481
	r_PtxU16Register57 = PublishE4(r_PackedHalf2AtPtx2445R1993);					   // PTX L3484
	r_PtxU16Register58 = PublishE4(r_PackedHalf2AtPtx2459R1991);					   // PTX L3487
	r_PtxU16Register59 = PublishE4(r_PackedHalf2AtPtx2452R1992);					   // PTX L3490
	r_PtxU16Register60 = PublishE4(r_PackedHalf2AtPtx2466R1990);					   // PTX L3493
	r_PtxU16Register61 = PublishE4(r_PackedHalf2AtPtx2473R1989);					   // PTX L3496
	r_PtxU16Register62 = PublishE4(r_PackedHalf2AtPtx2487R1987);					   // PTX L3499
	r_PtxU16Register63 = PublishE4(r_PackedHalf2AtPtx2480R1988);					   // PTX L3502
	r_PtxU16Register64 = PublishE4(r_PackedHalf2AtPtx2494R1986);					   // PTX L3505
	r_PtxRegister1332 = ShiftLeft(uint32_t(r_ThreadY), uint32_t(2));				   // PTX L3507
	r_PtxRegister37 = ShiftLeft(uint32_t(r_Scalar36Bits), uint32_t(2));				   // PTX L3508
	r_LaneIndexAtPtx3510 = uint32_t((threadIdx.x & 31u));							   // PTX L3510
	r_PtxRegister1333 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3510), uint32_t(31)); // PTX L3512
	r_PtxRegister1334 = ShiftRight(uint32_t(r_PtxRegister1333), uint32_t(30));		   // PTX L3513
	r_PtxRegister1335 = uint32_t(r_LaneIndexAtPtx3510) + uint32_t(r_PtxRegister1334);  // PTX L3514
	r_PtxRegister1336 = ShiftRightSigned(int32_t(r_PtxRegister1335), uint32_t(2));	   // PTX L3515
	r_PtxRegister1337 = ShiftRight(uint32_t(r_PtxRegister1336), uint32_t(30));		   // PTX L3516
	r_PtxRegister1338 = uint32_t(r_PtxRegister1336) + uint32_t(r_PtxRegister1337);	   // PTX L3517
	r_PtxRegister1339 = r_PtxRegister1338 & -4;										   // PTX L3518
	r_PtxRegister1340 = uint32_t(r_PtxRegister1336) - uint32_t(r_PtxRegister1339);	   // PTX L3519
	r_PtxRegister1341 = ShiftRight(uint32_t(r_PtxRegister1333), uint32_t(28));		   // PTX L3520
	r_PtxRegister1342 = uint32_t(r_LaneIndexAtPtx3510) + uint32_t(r_PtxRegister1341);  // PTX L3521
	r_PtxRegister1343 = ShiftRightSigned(int32_t(r_PtxRegister1342), uint32_t(4));	   // PTX L3522
	r_PtxRegister38 = uint32_t(r_PtxRegister1331) + uint32_t(r_PtxRegister1332);	   // PTX L3523
	r_PtxRegister39 = ShiftLeft(uint32_t(r_CtaY), uint32_t(3));						   // PTX L3524
	r_PtxRegister40 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1343);		   // PTX L3525
	r_PtxRegister41 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1340);		   // PTX L3526
	r_bPtxPredicate88 = int32_t(r_PtxRegister40) < int32_t(0);						   // PTX L3527
	r_bPtxPredicate89 = int32_t(r_PtxRegister40) >= int32_t(r_Scalar32Bits);		   // PTX L3528
	r_bPtxPredicate90 = r_bPtxPredicate88 | r_bPtxPredicate89;						   // PTX L3529
	r_bPtxPredicate91 = int32_t(r_PtxRegister41) < int32_t(0);						   // PTX L3530
	r_bPtxPredicate92 = int32_t(r_PtxRegister41) >= int32_t(r_Scalar36Bits);		   // PTX L3531
	r_bPtxPredicate93 = r_bPtxPredicate91 | r_bPtxPredicate92;						   // PTX L3532
	r_bPtxPredicate94 = r_bPtxPredicate90 | r_bPtxPredicate93;						   // PTX L3533
	if (r_bPtxPredicate94)
	{
		goto L__BB35_118;
	} // PTX L3534
	r_PtxRegister1344 = r_PtxRegister1335 & -4;										  // PTX L3535
	r_PtxRegister1345 = uint32_t(r_LaneIndexAtPtx3510) - uint32_t(r_PtxRegister1344); // PTX L3536
	r_PtxRegister1346 = ShiftLeft(uint32_t(r_PtxRegister41), uint32_t(2));			  // PTX L3537
	r_PtxRegister1347 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister40); // PTX L3538
	r_PtxRegister1348 =
		uint32_t(r_PtxRegister1347) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1346); // PTX L3539
	r_PtxRegister1349 = uint32_t(r_PtxRegister1348) + uint32_t(r_PtxRegister1345);			   // PTX L3540
	r_PtxU64Register235 = uint64_t(int64_t(int32_t(r_PtxRegister1349)) * int64_t(int32_t(4))); // PTX L3541
	r_PtxU64Register236 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register235);		   // PTX L3542
	*reinterpret_cast<ushort2*>(r_PtxU64Register236) =
		make_ushort2(r_PtxU16Register1, r_PtxU16Register2);							   // PTX L3543
L__BB35_118:																		   // PTX L3544
	r_LaneIndexAtPtx3546 = uint32_t((threadIdx.x & 31u));							   // PTX L3546
	r_PtxRegister1351 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3546), uint32_t(31)); // PTX L3548
	r_PtxRegister1352 = ShiftRight(uint32_t(r_PtxRegister1351), uint32_t(30));		   // PTX L3549
	r_PtxRegister1353 = uint32_t(r_LaneIndexAtPtx3546) + uint32_t(r_PtxRegister1352);  // PTX L3550
	r_PtxRegister1354 = ShiftRightSigned(int32_t(r_PtxRegister1353), uint32_t(2));	   // PTX L3551
	r_PtxRegister1355 = ShiftRight(uint32_t(r_PtxRegister1354), uint32_t(30));		   // PTX L3552
	r_PtxRegister1356 = uint32_t(r_PtxRegister1354) + uint32_t(r_PtxRegister1355);	   // PTX L3553
	r_PtxRegister1357 = r_PtxRegister1356 & -4;										   // PTX L3554
	r_PtxRegister1358 = uint32_t(r_PtxRegister1354) - uint32_t(r_PtxRegister1357);	   // PTX L3555
	r_PtxRegister1359 = ShiftRight(uint32_t(r_PtxRegister1351), uint32_t(28));		   // PTX L3556
	r_PtxRegister1360 = uint32_t(r_LaneIndexAtPtx3546) + uint32_t(r_PtxRegister1359);  // PTX L3557
	r_PtxRegister1361 = ShiftRightSigned(int32_t(r_PtxRegister1360), uint32_t(4));	   // PTX L3558
	r_PtxRegister1362 = uint32_t(r_PtxRegister1361) + uint32_t(r_PtxRegister39);	   // PTX L3559
	r_PtxRegister42 = uint32_t(r_PtxRegister1362) + uint32_t(2);					   // PTX L3560
	r_PtxRegister43 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1358);		   // PTX L3561
	r_bPtxPredicate95 = int32_t(r_PtxRegister42) < int32_t(0);						   // PTX L3562
	r_bPtxPredicate96 = int32_t(r_PtxRegister42) >= int32_t(r_Scalar32Bits);		   // PTX L3563
	r_bPtxPredicate97 = r_bPtxPredicate95 | r_bPtxPredicate96;						   // PTX L3564
	r_bPtxPredicate98 = int32_t(r_PtxRegister43) < int32_t(0);						   // PTX L3565
	r_bPtxPredicate99 = int32_t(r_PtxRegister43) >= int32_t(r_Scalar36Bits);		   // PTX L3566
	r_bPtxPredicate100 = r_bPtxPredicate98 | r_bPtxPredicate99;						   // PTX L3567
	r_bPtxPredicate101 = r_bPtxPredicate97 | r_bPtxPredicate100;					   // PTX L3568
	if (r_bPtxPredicate101)
	{
		goto L__BB35_120;
	} // PTX L3569
	r_PtxRegister1363 = r_PtxRegister1353 & -4;										  // PTX L3570
	r_PtxRegister1364 = uint32_t(r_LaneIndexAtPtx3546) - uint32_t(r_PtxRegister1363); // PTX L3571
	r_PtxRegister1365 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(2));			  // PTX L3572
	r_PtxRegister1366 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister42); // PTX L3573
	r_PtxRegister1367 =
		uint32_t(r_PtxRegister1366) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1365); // PTX L3574
	r_PtxRegister1368 = uint32_t(r_PtxRegister1367) + uint32_t(r_PtxRegister1364);			   // PTX L3575
	r_PtxU64Register237 = uint64_t(int64_t(int32_t(r_PtxRegister1368)) * int64_t(int32_t(4))); // PTX L3576
	r_PtxU64Register238 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register237);		   // PTX L3577
	*reinterpret_cast<ushort2*>(r_PtxU64Register238) =
		make_ushort2(r_PtxU16Register3, r_PtxU16Register4);							   // PTX L3578
L__BB35_120:																		   // PTX L3579
	r_LaneIndexAtPtx3581 = uint32_t((threadIdx.x & 31u));							   // PTX L3581
	r_PtxRegister1370 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3581), uint32_t(31)); // PTX L3583
	r_PtxRegister1371 = ShiftRight(uint32_t(r_PtxRegister1370), uint32_t(30));		   // PTX L3584
	r_PtxRegister1372 = uint32_t(r_LaneIndexAtPtx3581) + uint32_t(r_PtxRegister1371);  // PTX L3585
	r_PtxRegister1373 = ShiftRightSigned(int32_t(r_PtxRegister1372), uint32_t(2));	   // PTX L3586
	r_PtxRegister1374 = ShiftRight(uint32_t(r_PtxRegister1373), uint32_t(30));		   // PTX L3587
	r_PtxRegister1375 = uint32_t(r_PtxRegister1373) + uint32_t(r_PtxRegister1374);	   // PTX L3588
	r_PtxRegister1376 = r_PtxRegister1375 & -4;										   // PTX L3589
	r_PtxRegister1377 = uint32_t(r_PtxRegister1373) - uint32_t(r_PtxRegister1376);	   // PTX L3590
	r_PtxRegister1378 = ShiftRight(uint32_t(r_PtxRegister1370), uint32_t(28));		   // PTX L3591
	r_PtxRegister1379 = uint32_t(r_LaneIndexAtPtx3581) + uint32_t(r_PtxRegister1378);  // PTX L3592
	r_PtxRegister1380 = ShiftRightSigned(int32_t(r_PtxRegister1379), uint32_t(4));	   // PTX L3593
	r_PtxRegister44 = uint32_t(r_PtxRegister38) + uint32_t(1);						   // PTX L3594
	r_PtxRegister45 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1380);		   // PTX L3595
	r_PtxRegister46 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1377);		   // PTX L3596
	r_bPtxPredicate102 = int32_t(r_PtxRegister45) < int32_t(0);						   // PTX L3597
	r_bPtxPredicate103 = int32_t(r_PtxRegister45) >= int32_t(r_Scalar32Bits);		   // PTX L3598
	r_bPtxPredicate104 = r_bPtxPredicate102 | r_bPtxPredicate103;					   // PTX L3599
	r_bPtxPredicate105 = int32_t(r_PtxRegister46) < int32_t(0);						   // PTX L3600
	r_bPtxPredicate106 = int32_t(r_PtxRegister46) >= int32_t(r_Scalar36Bits);		   // PTX L3601
	r_bPtxPredicate107 = r_bPtxPredicate105 | r_bPtxPredicate106;					   // PTX L3602
	r_bPtxPredicate108 = r_bPtxPredicate104 | r_bPtxPredicate107;					   // PTX L3603
	if (r_bPtxPredicate108)
	{
		goto L__BB35_122;
	} // PTX L3604
	r_PtxRegister1381 = r_PtxRegister1372 & -4;										  // PTX L3605
	r_PtxRegister1382 = uint32_t(r_LaneIndexAtPtx3581) - uint32_t(r_PtxRegister1381); // PTX L3606
	r_PtxRegister1383 = ShiftLeft(uint32_t(r_PtxRegister46), uint32_t(2));			  // PTX L3607
	r_PtxRegister1384 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister45); // PTX L3608
	r_PtxRegister1385 =
		uint32_t(r_PtxRegister1384) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1383); // PTX L3609
	r_PtxRegister1386 = uint32_t(r_PtxRegister1385) + uint32_t(r_PtxRegister1382);			   // PTX L3610
	r_PtxU64Register239 = uint64_t(int64_t(int32_t(r_PtxRegister1386)) * int64_t(int32_t(4))); // PTX L3611
	r_PtxU64Register240 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register239);		   // PTX L3612
	*reinterpret_cast<ushort2*>(r_PtxU64Register240) =
		make_ushort2(r_PtxU16Register5, r_PtxU16Register6);							   // PTX L3613
L__BB35_122:																		   // PTX L3614
	r_LaneIndexAtPtx3616 = uint32_t((threadIdx.x & 31u));							   // PTX L3616
	r_PtxRegister1388 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3616), uint32_t(31)); // PTX L3618
	r_PtxRegister1389 = ShiftRight(uint32_t(r_PtxRegister1388), uint32_t(30));		   // PTX L3619
	r_PtxRegister1390 = uint32_t(r_LaneIndexAtPtx3616) + uint32_t(r_PtxRegister1389);  // PTX L3620
	r_PtxRegister1391 = ShiftRightSigned(int32_t(r_PtxRegister1390), uint32_t(2));	   // PTX L3621
	r_PtxRegister1392 = ShiftRight(uint32_t(r_PtxRegister1391), uint32_t(30));		   // PTX L3622
	r_PtxRegister1393 = uint32_t(r_PtxRegister1391) + uint32_t(r_PtxRegister1392);	   // PTX L3623
	r_PtxRegister1394 = r_PtxRegister1393 & -4;										   // PTX L3624
	r_PtxRegister1395 = uint32_t(r_PtxRegister1391) - uint32_t(r_PtxRegister1394);	   // PTX L3625
	r_PtxRegister1396 = ShiftRight(uint32_t(r_PtxRegister1388), uint32_t(28));		   // PTX L3626
	r_PtxRegister1397 = uint32_t(r_LaneIndexAtPtx3616) + uint32_t(r_PtxRegister1396);  // PTX L3627
	r_PtxRegister1398 = ShiftRightSigned(int32_t(r_PtxRegister1397), uint32_t(4));	   // PTX L3628
	r_PtxRegister1399 = uint32_t(r_PtxRegister1398) + uint32_t(r_PtxRegister39);	   // PTX L3629
	r_PtxRegister47 = uint32_t(r_PtxRegister1399) + uint32_t(2);					   // PTX L3630
	r_PtxRegister48 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1395);		   // PTX L3631
	r_bPtxPredicate109 = int32_t(r_PtxRegister47) < int32_t(0);						   // PTX L3632
	r_bPtxPredicate110 = int32_t(r_PtxRegister47) >= int32_t(r_Scalar32Bits);		   // PTX L3633
	r_bPtxPredicate111 = r_bPtxPredicate109 | r_bPtxPredicate110;					   // PTX L3634
	r_bPtxPredicate112 = int32_t(r_PtxRegister48) < int32_t(0);						   // PTX L3635
	r_bPtxPredicate113 = int32_t(r_PtxRegister48) >= int32_t(r_Scalar36Bits);		   // PTX L3636
	r_bPtxPredicate114 = r_bPtxPredicate112 | r_bPtxPredicate113;					   // PTX L3637
	r_bPtxPredicate115 = r_bPtxPredicate111 | r_bPtxPredicate114;					   // PTX L3638
	if (r_bPtxPredicate115)
	{
		goto L__BB35_124;
	} // PTX L3639
	r_PtxRegister1400 = r_PtxRegister1390 & -4;										  // PTX L3640
	r_PtxRegister1401 = uint32_t(r_LaneIndexAtPtx3616) - uint32_t(r_PtxRegister1400); // PTX L3641
	r_PtxRegister1402 = ShiftLeft(uint32_t(r_PtxRegister48), uint32_t(2));			  // PTX L3642
	r_PtxRegister1403 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister47); // PTX L3643
	r_PtxRegister1404 =
		uint32_t(r_PtxRegister1403) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1402); // PTX L3644
	r_PtxRegister1405 = uint32_t(r_PtxRegister1404) + uint32_t(r_PtxRegister1401);			   // PTX L3645
	r_PtxU64Register241 = uint64_t(int64_t(int32_t(r_PtxRegister1405)) * int64_t(int32_t(4))); // PTX L3646
	r_PtxU64Register242 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register241);		   // PTX L3647
	*reinterpret_cast<ushort2*>(r_PtxU64Register242) =
		make_ushort2(r_PtxU16Register7, r_PtxU16Register8);							   // PTX L3648
L__BB35_124:																		   // PTX L3649
	r_LaneIndexAtPtx3651 = uint32_t((threadIdx.x & 31u));							   // PTX L3651
	r_PtxRegister1407 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3651), uint32_t(31)); // PTX L3653
	r_PtxRegister1408 = ShiftRight(uint32_t(r_PtxRegister1407), uint32_t(30));		   // PTX L3654
	r_PtxRegister1409 = uint32_t(r_LaneIndexAtPtx3651) + uint32_t(r_PtxRegister1408);  // PTX L3655
	r_PtxRegister1410 = ShiftRightSigned(int32_t(r_PtxRegister1409), uint32_t(2));	   // PTX L3656
	r_PtxRegister1411 = ShiftRight(uint32_t(r_PtxRegister1410), uint32_t(30));		   // PTX L3657
	r_PtxRegister1412 = uint32_t(r_PtxRegister1410) + uint32_t(r_PtxRegister1411);	   // PTX L3658
	r_PtxRegister1413 = r_PtxRegister1412 & -4;										   // PTX L3659
	r_PtxRegister1414 = uint32_t(r_PtxRegister1410) - uint32_t(r_PtxRegister1413);	   // PTX L3660
	r_PtxRegister1415 = ShiftRight(uint32_t(r_PtxRegister1407), uint32_t(28));		   // PTX L3661
	r_PtxRegister1416 = uint32_t(r_LaneIndexAtPtx3651) + uint32_t(r_PtxRegister1415);  // PTX L3662
	r_PtxRegister1417 = ShiftRightSigned(int32_t(r_PtxRegister1416), uint32_t(4));	   // PTX L3663
	r_PtxRegister49 = uint32_t(r_PtxRegister38) + uint32_t(2);						   // PTX L3664
	r_PtxRegister50 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1417);		   // PTX L3665
	r_PtxRegister51 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1414);		   // PTX L3666
	r_bPtxPredicate116 = int32_t(r_PtxRegister50) < int32_t(0);						   // PTX L3667
	r_bPtxPredicate117 = int32_t(r_PtxRegister50) >= int32_t(r_Scalar32Bits);		   // PTX L3668
	r_bPtxPredicate118 = r_bPtxPredicate116 | r_bPtxPredicate117;					   // PTX L3669
	r_bPtxPredicate119 = int32_t(r_PtxRegister51) < int32_t(0);						   // PTX L3670
	r_bPtxPredicate120 = int32_t(r_PtxRegister51) >= int32_t(r_Scalar36Bits);		   // PTX L3671
	r_bPtxPredicate121 = r_bPtxPredicate119 | r_bPtxPredicate120;					   // PTX L3672
	r_bPtxPredicate122 = r_bPtxPredicate118 | r_bPtxPredicate121;					   // PTX L3673
	if (r_bPtxPredicate122)
	{
		goto L__BB35_126;
	} // PTX L3674
	r_PtxRegister1418 = r_PtxRegister1409 & -4;										  // PTX L3675
	r_PtxRegister1419 = uint32_t(r_LaneIndexAtPtx3651) - uint32_t(r_PtxRegister1418); // PTX L3676
	r_PtxRegister1420 = ShiftLeft(uint32_t(r_PtxRegister51), uint32_t(2));			  // PTX L3677
	r_PtxRegister1421 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister50); // PTX L3678
	r_PtxRegister1422 =
		uint32_t(r_PtxRegister1421) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1420); // PTX L3679
	r_PtxRegister1423 = uint32_t(r_PtxRegister1422) + uint32_t(r_PtxRegister1419);			   // PTX L3680
	r_PtxU64Register243 = uint64_t(int64_t(int32_t(r_PtxRegister1423)) * int64_t(int32_t(4))); // PTX L3681
	r_PtxU64Register244 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register243);		   // PTX L3682
	*reinterpret_cast<ushort2*>(r_PtxU64Register244) =
		make_ushort2(r_PtxU16Register9, r_PtxU16Register10);						   // PTX L3683
L__BB35_126:																		   // PTX L3684
	r_LaneIndexAtPtx3686 = uint32_t((threadIdx.x & 31u));							   // PTX L3686
	r_PtxRegister1425 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3686), uint32_t(31)); // PTX L3688
	r_PtxRegister1426 = ShiftRight(uint32_t(r_PtxRegister1425), uint32_t(30));		   // PTX L3689
	r_PtxRegister1427 = uint32_t(r_LaneIndexAtPtx3686) + uint32_t(r_PtxRegister1426);  // PTX L3690
	r_PtxRegister1428 = ShiftRightSigned(int32_t(r_PtxRegister1427), uint32_t(2));	   // PTX L3691
	r_PtxRegister1429 = ShiftRight(uint32_t(r_PtxRegister1428), uint32_t(30));		   // PTX L3692
	r_PtxRegister1430 = uint32_t(r_PtxRegister1428) + uint32_t(r_PtxRegister1429);	   // PTX L3693
	r_PtxRegister1431 = r_PtxRegister1430 & -4;										   // PTX L3694
	r_PtxRegister1432 = uint32_t(r_PtxRegister1428) - uint32_t(r_PtxRegister1431);	   // PTX L3695
	r_PtxRegister1433 = ShiftRight(uint32_t(r_PtxRegister1425), uint32_t(28));		   // PTX L3696
	r_PtxRegister1434 = uint32_t(r_LaneIndexAtPtx3686) + uint32_t(r_PtxRegister1433);  // PTX L3697
	r_PtxRegister1435 = ShiftRightSigned(int32_t(r_PtxRegister1434), uint32_t(4));	   // PTX L3698
	r_PtxRegister1436 = uint32_t(r_PtxRegister1435) + uint32_t(r_PtxRegister39);	   // PTX L3699
	r_PtxRegister52 = uint32_t(r_PtxRegister1436) + uint32_t(2);					   // PTX L3700
	r_PtxRegister53 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1432);		   // PTX L3701
	r_bPtxPredicate123 = int32_t(r_PtxRegister52) < int32_t(0);						   // PTX L3702
	r_bPtxPredicate124 = int32_t(r_PtxRegister52) >= int32_t(r_Scalar32Bits);		   // PTX L3703
	r_bPtxPredicate125 = r_bPtxPredicate123 | r_bPtxPredicate124;					   // PTX L3704
	r_bPtxPredicate126 = int32_t(r_PtxRegister53) < int32_t(0);						   // PTX L3705
	r_bPtxPredicate127 = int32_t(r_PtxRegister53) >= int32_t(r_Scalar36Bits);		   // PTX L3706
	r_bPtxPredicate128 = r_bPtxPredicate126 | r_bPtxPredicate127;					   // PTX L3707
	r_bPtxPredicate129 = r_bPtxPredicate125 | r_bPtxPredicate128;					   // PTX L3708
	if (r_bPtxPredicate129)
	{
		goto L__BB35_128;
	} // PTX L3709
	r_PtxRegister1437 = r_PtxRegister1427 & -4;										  // PTX L3710
	r_PtxRegister1438 = uint32_t(r_LaneIndexAtPtx3686) - uint32_t(r_PtxRegister1437); // PTX L3711
	r_PtxRegister1439 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(2));			  // PTX L3712
	r_PtxRegister1440 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister52); // PTX L3713
	r_PtxRegister1441 =
		uint32_t(r_PtxRegister1440) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1439); // PTX L3714
	r_PtxRegister1442 = uint32_t(r_PtxRegister1441) + uint32_t(r_PtxRegister1438);			   // PTX L3715
	r_PtxU64Register245 = uint64_t(int64_t(int32_t(r_PtxRegister1442)) * int64_t(int32_t(4))); // PTX L3716
	r_PtxU64Register246 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register245);		   // PTX L3717
	*reinterpret_cast<ushort2*>(r_PtxU64Register246) =
		make_ushort2(r_PtxU16Register11, r_PtxU16Register12);						   // PTX L3718
L__BB35_128:																		   // PTX L3719
	r_LaneIndexAtPtx3721 = uint32_t((threadIdx.x & 31u));							   // PTX L3721
	r_PtxRegister1444 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3721), uint32_t(31)); // PTX L3723
	r_PtxRegister1445 = ShiftRight(uint32_t(r_PtxRegister1444), uint32_t(30));		   // PTX L3724
	r_PtxRegister1446 = uint32_t(r_LaneIndexAtPtx3721) + uint32_t(r_PtxRegister1445);  // PTX L3725
	r_PtxRegister1447 = ShiftRightSigned(int32_t(r_PtxRegister1446), uint32_t(2));	   // PTX L3726
	r_PtxRegister1448 = ShiftRight(uint32_t(r_PtxRegister1447), uint32_t(30));		   // PTX L3727
	r_PtxRegister1449 = uint32_t(r_PtxRegister1447) + uint32_t(r_PtxRegister1448);	   // PTX L3728
	r_PtxRegister1450 = r_PtxRegister1449 & -4;										   // PTX L3729
	r_PtxRegister1451 = uint32_t(r_PtxRegister1447) - uint32_t(r_PtxRegister1450);	   // PTX L3730
	r_PtxRegister1452 = ShiftRight(uint32_t(r_PtxRegister1444), uint32_t(28));		   // PTX L3731
	r_PtxRegister1453 = uint32_t(r_LaneIndexAtPtx3721) + uint32_t(r_PtxRegister1452);  // PTX L3732
	r_PtxRegister1454 = ShiftRightSigned(int32_t(r_PtxRegister1453), uint32_t(4));	   // PTX L3733
	r_PtxRegister54 = uint32_t(r_PtxRegister38) + uint32_t(3);						   // PTX L3734
	r_PtxRegister55 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1454);		   // PTX L3735
	r_PtxRegister56 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1451);		   // PTX L3736
	r_bPtxPredicate130 = int32_t(r_PtxRegister55) < int32_t(0);						   // PTX L3737
	r_bPtxPredicate131 = int32_t(r_PtxRegister55) >= int32_t(r_Scalar32Bits);		   // PTX L3738
	r_bPtxPredicate132 = r_bPtxPredicate130 | r_bPtxPredicate131;					   // PTX L3739
	r_bPtxPredicate133 = int32_t(r_PtxRegister56) < int32_t(0);						   // PTX L3740
	r_bPtxPredicate134 = int32_t(r_PtxRegister56) >= int32_t(r_Scalar36Bits);		   // PTX L3741
	r_bPtxPredicate135 = r_bPtxPredicate133 | r_bPtxPredicate134;					   // PTX L3742
	r_bPtxPredicate136 = r_bPtxPredicate132 | r_bPtxPredicate135;					   // PTX L3743
	if (r_bPtxPredicate136)
	{
		goto L__BB35_130;
	} // PTX L3744
	r_PtxRegister1455 = r_PtxRegister1446 & -4;										  // PTX L3745
	r_PtxRegister1456 = uint32_t(r_LaneIndexAtPtx3721) - uint32_t(r_PtxRegister1455); // PTX L3746
	r_PtxRegister1457 = ShiftLeft(uint32_t(r_PtxRegister56), uint32_t(2));			  // PTX L3747
	r_PtxRegister1458 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister55); // PTX L3748
	r_PtxRegister1459 =
		uint32_t(r_PtxRegister1458) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1457); // PTX L3749
	r_PtxRegister1460 = uint32_t(r_PtxRegister1459) + uint32_t(r_PtxRegister1456);			   // PTX L3750
	r_PtxU64Register247 = uint64_t(int64_t(int32_t(r_PtxRegister1460)) * int64_t(int32_t(4))); // PTX L3751
	r_PtxU64Register248 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register247);		   // PTX L3752
	*reinterpret_cast<ushort2*>(r_PtxU64Register248) =
		make_ushort2(r_PtxU16Register13, r_PtxU16Register14);						   // PTX L3753
L__BB35_130:																		   // PTX L3754
	r_LaneIndexAtPtx3756 = uint32_t((threadIdx.x & 31u));							   // PTX L3756
	r_PtxRegister1462 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3756), uint32_t(31)); // PTX L3758
	r_PtxRegister1463 = ShiftRight(uint32_t(r_PtxRegister1462), uint32_t(30));		   // PTX L3759
	r_PtxRegister1464 = uint32_t(r_LaneIndexAtPtx3756) + uint32_t(r_PtxRegister1463);  // PTX L3760
	r_PtxRegister1465 = ShiftRightSigned(int32_t(r_PtxRegister1464), uint32_t(2));	   // PTX L3761
	r_PtxRegister1466 = ShiftRight(uint32_t(r_PtxRegister1465), uint32_t(30));		   // PTX L3762
	r_PtxRegister1467 = uint32_t(r_PtxRegister1465) + uint32_t(r_PtxRegister1466);	   // PTX L3763
	r_PtxRegister1468 = r_PtxRegister1467 & -4;										   // PTX L3764
	r_PtxRegister1469 = uint32_t(r_PtxRegister1465) - uint32_t(r_PtxRegister1468);	   // PTX L3765
	r_PtxRegister1470 = ShiftRight(uint32_t(r_PtxRegister1462), uint32_t(28));		   // PTX L3766
	r_PtxRegister1471 = uint32_t(r_LaneIndexAtPtx3756) + uint32_t(r_PtxRegister1470);  // PTX L3767
	r_PtxRegister1472 = ShiftRightSigned(int32_t(r_PtxRegister1471), uint32_t(4));	   // PTX L3768
	r_PtxRegister1473 = uint32_t(r_PtxRegister1472) + uint32_t(r_PtxRegister39);	   // PTX L3769
	r_PtxRegister57 = uint32_t(r_PtxRegister1473) + uint32_t(2);					   // PTX L3770
	r_PtxRegister58 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1469);		   // PTX L3771
	r_bPtxPredicate137 = int32_t(r_PtxRegister57) < int32_t(0);						   // PTX L3772
	r_bPtxPredicate138 = int32_t(r_PtxRegister57) >= int32_t(r_Scalar32Bits);		   // PTX L3773
	r_bPtxPredicate139 = r_bPtxPredicate137 | r_bPtxPredicate138;					   // PTX L3774
	r_bPtxPredicate140 = int32_t(r_PtxRegister58) < int32_t(0);						   // PTX L3775
	r_bPtxPredicate141 = int32_t(r_PtxRegister58) >= int32_t(r_Scalar36Bits);		   // PTX L3776
	r_bPtxPredicate142 = r_bPtxPredicate140 | r_bPtxPredicate141;					   // PTX L3777
	r_bPtxPredicate143 = r_bPtxPredicate139 | r_bPtxPredicate142;					   // PTX L3778
	if (r_bPtxPredicate143)
	{
		goto L__BB35_132;
	} // PTX L3779
	r_PtxRegister1474 = r_PtxRegister1464 & -4;										  // PTX L3780
	r_PtxRegister1475 = uint32_t(r_LaneIndexAtPtx3756) - uint32_t(r_PtxRegister1474); // PTX L3781
	r_PtxRegister1476 = ShiftLeft(uint32_t(r_PtxRegister58), uint32_t(2));			  // PTX L3782
	r_PtxRegister1477 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister57); // PTX L3783
	r_PtxRegister1478 =
		uint32_t(r_PtxRegister1477) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1476); // PTX L3784
	r_PtxRegister1479 = uint32_t(r_PtxRegister1478) + uint32_t(r_PtxRegister1475);			   // PTX L3785
	r_PtxU64Register249 = uint64_t(int64_t(int32_t(r_PtxRegister1479)) * int64_t(int32_t(4))); // PTX L3786
	r_PtxU64Register250 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register249);		   // PTX L3787
	*reinterpret_cast<ushort2*>(r_PtxU64Register250) =
		make_ushort2(r_PtxU16Register15, r_PtxU16Register16);						   // PTX L3788
L__BB35_132:																		   // PTX L3789
	r_LaneIndexAtPtx3791 = uint32_t((threadIdx.x & 31u));							   // PTX L3791
	r_PtxRegister1481 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3791), uint32_t(31)); // PTX L3793
	r_PtxRegister1482 = ShiftRight(uint32_t(r_PtxRegister1481), uint32_t(30));		   // PTX L3794
	r_PtxRegister1483 = uint32_t(r_LaneIndexAtPtx3791) + uint32_t(r_PtxRegister1482);  // PTX L3795
	r_PtxRegister1484 = ShiftRightSigned(int32_t(r_PtxRegister1483), uint32_t(2));	   // PTX L3796
	r_PtxRegister1485 = ShiftRight(uint32_t(r_PtxRegister1484), uint32_t(30));		   // PTX L3797
	r_PtxRegister1486 = uint32_t(r_PtxRegister1484) + uint32_t(r_PtxRegister1485);	   // PTX L3798
	r_PtxRegister1487 = r_PtxRegister1486 & -4;										   // PTX L3799
	r_PtxRegister1488 = uint32_t(r_PtxRegister1484) - uint32_t(r_PtxRegister1487);	   // PTX L3800
	r_PtxRegister1489 = ShiftRight(uint32_t(r_PtxRegister1481), uint32_t(28));		   // PTX L3801
	r_PtxRegister1490 = uint32_t(r_LaneIndexAtPtx3791) + uint32_t(r_PtxRegister1489);  // PTX L3802
	r_PtxRegister1491 = ShiftRightSigned(int32_t(r_PtxRegister1490), uint32_t(4));	   // PTX L3803
	r_PtxRegister1492 = uint32_t(r_PtxRegister1488) + uint32_t(r_PtxRegister4);		   // PTX L3804
	r_PtxRegister59 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1491);		   // PTX L3805
	r_PtxRegister60 = uint32_t(r_PtxRegister1492) + uint32_t(4);					   // PTX L3806
	r_bPtxPredicate144 = int32_t(r_PtxRegister59) < int32_t(0);						   // PTX L3807
	r_bPtxPredicate145 = int32_t(r_PtxRegister59) >= int32_t(r_Scalar32Bits);		   // PTX L3808
	r_bPtxPredicate146 = int32_t(r_PtxRegister60) >= int32_t(r_Scalar36Bits);		   // PTX L3809
	r_bPtxPredicate147 = r_bPtxPredicate145 | r_bPtxPredicate146;					   // PTX L3810
	r_bPtxPredicate148 = r_bPtxPredicate147 | r_bPtxPredicate144;					   // PTX L3811
	if (r_bPtxPredicate148)
	{
		goto L__BB35_134;
	} // PTX L3812
	r_PtxRegister1493 = r_PtxRegister1483 & -4;										  // PTX L3813
	r_PtxRegister1494 = uint32_t(r_LaneIndexAtPtx3791) - uint32_t(r_PtxRegister1493); // PTX L3814
	r_PtxRegister1495 = ShiftLeft(uint32_t(r_PtxRegister60), uint32_t(2));			  // PTX L3815
	r_PtxRegister1496 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister59); // PTX L3816
	r_PtxRegister1497 =
		uint32_t(r_PtxRegister1496) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1495); // PTX L3817
	r_PtxRegister1498 = uint32_t(r_PtxRegister1497) + uint32_t(r_PtxRegister1494);			   // PTX L3818
	r_PtxU64Register251 = uint64_t(int64_t(int32_t(r_PtxRegister1498)) * int64_t(int32_t(4))); // PTX L3819
	r_PtxU64Register252 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register251);		   // PTX L3820
	*reinterpret_cast<ushort2*>(r_PtxU64Register252) =
		make_ushort2(r_PtxU16Register17, r_PtxU16Register18);						   // PTX L3821
L__BB35_134:																		   // PTX L3822
	r_LaneIndexAtPtx3824 = uint32_t((threadIdx.x & 31u));							   // PTX L3824
	r_PtxRegister1500 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3824), uint32_t(31)); // PTX L3826
	r_PtxRegister1501 = ShiftRight(uint32_t(r_PtxRegister1500), uint32_t(30));		   // PTX L3827
	r_PtxRegister1502 = uint32_t(r_LaneIndexAtPtx3824) + uint32_t(r_PtxRegister1501);  // PTX L3828
	r_PtxRegister1503 = ShiftRightSigned(int32_t(r_PtxRegister1502), uint32_t(2));	   // PTX L3829
	r_PtxRegister1504 = ShiftRight(uint32_t(r_PtxRegister1503), uint32_t(30));		   // PTX L3830
	r_PtxRegister1505 = uint32_t(r_PtxRegister1503) + uint32_t(r_PtxRegister1504);	   // PTX L3831
	r_PtxRegister1506 = r_PtxRegister1505 & -4;										   // PTX L3832
	r_PtxRegister1507 = uint32_t(r_PtxRegister1503) - uint32_t(r_PtxRegister1506);	   // PTX L3833
	r_PtxRegister1508 = ShiftRight(uint32_t(r_PtxRegister1500), uint32_t(28));		   // PTX L3834
	r_PtxRegister1509 = uint32_t(r_LaneIndexAtPtx3824) + uint32_t(r_PtxRegister1508);  // PTX L3835
	r_PtxRegister1510 = ShiftRightSigned(int32_t(r_PtxRegister1509), uint32_t(4));	   // PTX L3836
	r_PtxRegister1511 = uint32_t(r_PtxRegister1510) + uint32_t(r_PtxRegister39);	   // PTX L3837
	r_PtxRegister1512 = uint32_t(r_PtxRegister1507) + uint32_t(r_PtxRegister4);		   // PTX L3838
	r_PtxRegister61 = uint32_t(r_PtxRegister1511) + uint32_t(2);					   // PTX L3839
	r_PtxRegister62 = uint32_t(r_PtxRegister1512) + uint32_t(4);					   // PTX L3840
	r_bPtxPredicate149 = int32_t(r_PtxRegister61) < int32_t(0);						   // PTX L3841
	r_bPtxPredicate150 = int32_t(r_PtxRegister61) >= int32_t(r_Scalar32Bits);		   // PTX L3842
	r_bPtxPredicate151 = int32_t(r_PtxRegister62) >= int32_t(r_Scalar36Bits);		   // PTX L3843
	r_bPtxPredicate152 = r_bPtxPredicate150 | r_bPtxPredicate151;					   // PTX L3844
	r_bPtxPredicate153 = r_bPtxPredicate152 | r_bPtxPredicate149;					   // PTX L3845
	if (r_bPtxPredicate153)
	{
		goto L__BB35_136;
	} // PTX L3846
	r_PtxRegister1513 = r_PtxRegister1502 & -4;										  // PTX L3847
	r_PtxRegister1514 = uint32_t(r_LaneIndexAtPtx3824) - uint32_t(r_PtxRegister1513); // PTX L3848
	r_PtxRegister1515 = ShiftLeft(uint32_t(r_PtxRegister62), uint32_t(2));			  // PTX L3849
	r_PtxRegister1516 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister61); // PTX L3850
	r_PtxRegister1517 =
		uint32_t(r_PtxRegister1516) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1515); // PTX L3851
	r_PtxRegister1518 = uint32_t(r_PtxRegister1517) + uint32_t(r_PtxRegister1514);			   // PTX L3852
	r_PtxU64Register253 = uint64_t(int64_t(int32_t(r_PtxRegister1518)) * int64_t(int32_t(4))); // PTX L3853
	r_PtxU64Register254 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register253);		   // PTX L3854
	*reinterpret_cast<ushort2*>(r_PtxU64Register254) =
		make_ushort2(r_PtxU16Register19, r_PtxU16Register20);						   // PTX L3855
L__BB35_136:																		   // PTX L3856
	r_LaneIndexAtPtx3858 = uint32_t((threadIdx.x & 31u));							   // PTX L3858
	r_PtxRegister1520 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3858), uint32_t(31)); // PTX L3860
	r_PtxRegister1521 = ShiftRight(uint32_t(r_PtxRegister1520), uint32_t(30));		   // PTX L3861
	r_PtxRegister1522 = uint32_t(r_LaneIndexAtPtx3858) + uint32_t(r_PtxRegister1521);  // PTX L3862
	r_PtxRegister1523 = ShiftRightSigned(int32_t(r_PtxRegister1522), uint32_t(2));	   // PTX L3863
	r_PtxRegister1524 = ShiftRight(uint32_t(r_PtxRegister1523), uint32_t(30));		   // PTX L3864
	r_PtxRegister1525 = uint32_t(r_PtxRegister1523) + uint32_t(r_PtxRegister1524);	   // PTX L3865
	r_PtxRegister1526 = r_PtxRegister1525 & -4;										   // PTX L3866
	r_PtxRegister1527 = uint32_t(r_PtxRegister1523) - uint32_t(r_PtxRegister1526);	   // PTX L3867
	r_PtxRegister1528 = ShiftRight(uint32_t(r_PtxRegister1520), uint32_t(28));		   // PTX L3868
	r_PtxRegister1529 = uint32_t(r_LaneIndexAtPtx3858) + uint32_t(r_PtxRegister1528);  // PTX L3869
	r_PtxRegister1530 = ShiftRightSigned(int32_t(r_PtxRegister1529), uint32_t(4));	   // PTX L3870
	r_PtxRegister1531 = uint32_t(r_PtxRegister1527) + uint32_t(r_PtxRegister4);		   // PTX L3871
	r_PtxRegister63 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1530);		   // PTX L3872
	r_PtxRegister64 = uint32_t(r_PtxRegister1531) + uint32_t(4);					   // PTX L3873
	r_bPtxPredicate154 = int32_t(r_PtxRegister63) < int32_t(0);						   // PTX L3874
	r_bPtxPredicate155 = int32_t(r_PtxRegister63) >= int32_t(r_Scalar32Bits);		   // PTX L3875
	r_bPtxPredicate156 = int32_t(r_PtxRegister64) >= int32_t(r_Scalar36Bits);		   // PTX L3876
	r_bPtxPredicate157 = r_bPtxPredicate155 | r_bPtxPredicate156;					   // PTX L3877
	r_bPtxPredicate158 = r_bPtxPredicate157 | r_bPtxPredicate154;					   // PTX L3878
	if (r_bPtxPredicate158)
	{
		goto L__BB35_138;
	} // PTX L3879
	r_PtxRegister1532 = r_PtxRegister1522 & -4;										  // PTX L3880
	r_PtxRegister1533 = uint32_t(r_LaneIndexAtPtx3858) - uint32_t(r_PtxRegister1532); // PTX L3881
	r_PtxRegister1534 = ShiftLeft(uint32_t(r_PtxRegister64), uint32_t(2));			  // PTX L3882
	r_PtxRegister1535 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister63); // PTX L3883
	r_PtxRegister1536 =
		uint32_t(r_PtxRegister1535) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1534); // PTX L3884
	r_PtxRegister1537 = uint32_t(r_PtxRegister1536) + uint32_t(r_PtxRegister1533);			   // PTX L3885
	r_PtxU64Register255 = uint64_t(int64_t(int32_t(r_PtxRegister1537)) * int64_t(int32_t(4))); // PTX L3886
	r_PtxU64Register256 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register255);		   // PTX L3887
	*reinterpret_cast<ushort2*>(r_PtxU64Register256) =
		make_ushort2(r_PtxU16Register21, r_PtxU16Register22);						   // PTX L3888
L__BB35_138:																		   // PTX L3889
	r_LaneIndexAtPtx3891 = uint32_t((threadIdx.x & 31u));							   // PTX L3891
	r_PtxRegister1539 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3891), uint32_t(31)); // PTX L3893
	r_PtxRegister1540 = ShiftRight(uint32_t(r_PtxRegister1539), uint32_t(30));		   // PTX L3894
	r_PtxRegister1541 = uint32_t(r_LaneIndexAtPtx3891) + uint32_t(r_PtxRegister1540);  // PTX L3895
	r_PtxRegister1542 = ShiftRightSigned(int32_t(r_PtxRegister1541), uint32_t(2));	   // PTX L3896
	r_PtxRegister1543 = ShiftRight(uint32_t(r_PtxRegister1542), uint32_t(30));		   // PTX L3897
	r_PtxRegister1544 = uint32_t(r_PtxRegister1542) + uint32_t(r_PtxRegister1543);	   // PTX L3898
	r_PtxRegister1545 = r_PtxRegister1544 & -4;										   // PTX L3899
	r_PtxRegister1546 = uint32_t(r_PtxRegister1542) - uint32_t(r_PtxRegister1545);	   // PTX L3900
	r_PtxRegister1547 = ShiftRight(uint32_t(r_PtxRegister1539), uint32_t(28));		   // PTX L3901
	r_PtxRegister1548 = uint32_t(r_LaneIndexAtPtx3891) + uint32_t(r_PtxRegister1547);  // PTX L3902
	r_PtxRegister1549 = ShiftRightSigned(int32_t(r_PtxRegister1548), uint32_t(4));	   // PTX L3903
	r_PtxRegister1550 = uint32_t(r_PtxRegister1549) + uint32_t(r_PtxRegister39);	   // PTX L3904
	r_PtxRegister1551 = uint32_t(r_PtxRegister1546) + uint32_t(r_PtxRegister4);		   // PTX L3905
	r_PtxRegister65 = uint32_t(r_PtxRegister1550) + uint32_t(2);					   // PTX L3906
	r_PtxRegister66 = uint32_t(r_PtxRegister1551) + uint32_t(4);					   // PTX L3907
	r_bPtxPredicate159 = int32_t(r_PtxRegister65) < int32_t(0);						   // PTX L3908
	r_bPtxPredicate160 = int32_t(r_PtxRegister65) >= int32_t(r_Scalar32Bits);		   // PTX L3909
	r_bPtxPredicate161 = int32_t(r_PtxRegister66) >= int32_t(r_Scalar36Bits);		   // PTX L3910
	r_bPtxPredicate162 = r_bPtxPredicate160 | r_bPtxPredicate161;					   // PTX L3911
	r_bPtxPredicate163 = r_bPtxPredicate162 | r_bPtxPredicate159;					   // PTX L3912
	if (r_bPtxPredicate163)
	{
		goto L__BB35_140;
	} // PTX L3913
	r_PtxRegister1552 = r_PtxRegister1541 & -4;										  // PTX L3914
	r_PtxRegister1553 = uint32_t(r_LaneIndexAtPtx3891) - uint32_t(r_PtxRegister1552); // PTX L3915
	r_PtxRegister1554 = ShiftLeft(uint32_t(r_PtxRegister66), uint32_t(2));			  // PTX L3916
	r_PtxRegister1555 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister65); // PTX L3917
	r_PtxRegister1556 =
		uint32_t(r_PtxRegister1555) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1554); // PTX L3918
	r_PtxRegister1557 = uint32_t(r_PtxRegister1556) + uint32_t(r_PtxRegister1553);			   // PTX L3919
	r_PtxU64Register257 = uint64_t(int64_t(int32_t(r_PtxRegister1557)) * int64_t(int32_t(4))); // PTX L3920
	r_PtxU64Register258 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register257);		   // PTX L3921
	*reinterpret_cast<ushort2*>(r_PtxU64Register258) =
		make_ushort2(r_PtxU16Register23, r_PtxU16Register24);						   // PTX L3922
L__BB35_140:																		   // PTX L3923
	r_LaneIndexAtPtx3925 = uint32_t((threadIdx.x & 31u));							   // PTX L3925
	r_PtxRegister1559 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3925), uint32_t(31)); // PTX L3927
	r_PtxRegister1560 = ShiftRight(uint32_t(r_PtxRegister1559), uint32_t(30));		   // PTX L3928
	r_PtxRegister1561 = uint32_t(r_LaneIndexAtPtx3925) + uint32_t(r_PtxRegister1560);  // PTX L3929
	r_PtxRegister1562 = ShiftRightSigned(int32_t(r_PtxRegister1561), uint32_t(2));	   // PTX L3930
	r_PtxRegister1563 = ShiftRight(uint32_t(r_PtxRegister1562), uint32_t(30));		   // PTX L3931
	r_PtxRegister1564 = uint32_t(r_PtxRegister1562) + uint32_t(r_PtxRegister1563);	   // PTX L3932
	r_PtxRegister1565 = r_PtxRegister1564 & -4;										   // PTX L3933
	r_PtxRegister1566 = uint32_t(r_PtxRegister1562) - uint32_t(r_PtxRegister1565);	   // PTX L3934
	r_PtxRegister1567 = ShiftRight(uint32_t(r_PtxRegister1559), uint32_t(28));		   // PTX L3935
	r_PtxRegister1568 = uint32_t(r_LaneIndexAtPtx3925) + uint32_t(r_PtxRegister1567);  // PTX L3936
	r_PtxRegister1569 = ShiftRightSigned(int32_t(r_PtxRegister1568), uint32_t(4));	   // PTX L3937
	r_PtxRegister1570 = uint32_t(r_PtxRegister1566) + uint32_t(r_PtxRegister4);		   // PTX L3938
	r_PtxRegister67 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1569);		   // PTX L3939
	r_PtxRegister68 = uint32_t(r_PtxRegister1570) + uint32_t(4);					   // PTX L3940
	r_bPtxPredicate164 = int32_t(r_PtxRegister67) < int32_t(0);						   // PTX L3941
	r_bPtxPredicate165 = int32_t(r_PtxRegister67) >= int32_t(r_Scalar32Bits);		   // PTX L3942
	r_bPtxPredicate166 = int32_t(r_PtxRegister68) >= int32_t(r_Scalar36Bits);		   // PTX L3943
	r_bPtxPredicate167 = r_bPtxPredicate165 | r_bPtxPredicate166;					   // PTX L3944
	r_bPtxPredicate168 = r_bPtxPredicate167 | r_bPtxPredicate164;					   // PTX L3945
	if (r_bPtxPredicate168)
	{
		goto L__BB35_142;
	} // PTX L3946
	r_PtxRegister1571 = r_PtxRegister1561 & -4;										  // PTX L3947
	r_PtxRegister1572 = uint32_t(r_LaneIndexAtPtx3925) - uint32_t(r_PtxRegister1571); // PTX L3948
	r_PtxRegister1573 = ShiftLeft(uint32_t(r_PtxRegister68), uint32_t(2));			  // PTX L3949
	r_PtxRegister1574 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister67); // PTX L3950
	r_PtxRegister1575 =
		uint32_t(r_PtxRegister1574) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1573); // PTX L3951
	r_PtxRegister1576 = uint32_t(r_PtxRegister1575) + uint32_t(r_PtxRegister1572);			   // PTX L3952
	r_PtxU64Register259 = uint64_t(int64_t(int32_t(r_PtxRegister1576)) * int64_t(int32_t(4))); // PTX L3953
	r_PtxU64Register260 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register259);		   // PTX L3954
	*reinterpret_cast<ushort2*>(r_PtxU64Register260) =
		make_ushort2(r_PtxU16Register25, r_PtxU16Register26);						   // PTX L3955
L__BB35_142:																		   // PTX L3956
	r_LaneIndexAtPtx3958 = uint32_t((threadIdx.x & 31u));							   // PTX L3958
	r_PtxRegister1578 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3958), uint32_t(31)); // PTX L3960
	r_PtxRegister1579 = ShiftRight(uint32_t(r_PtxRegister1578), uint32_t(30));		   // PTX L3961
	r_PtxRegister1580 = uint32_t(r_LaneIndexAtPtx3958) + uint32_t(r_PtxRegister1579);  // PTX L3962
	r_PtxRegister1581 = ShiftRightSigned(int32_t(r_PtxRegister1580), uint32_t(2));	   // PTX L3963
	r_PtxRegister1582 = ShiftRight(uint32_t(r_PtxRegister1581), uint32_t(30));		   // PTX L3964
	r_PtxRegister1583 = uint32_t(r_PtxRegister1581) + uint32_t(r_PtxRegister1582);	   // PTX L3965
	r_PtxRegister1584 = r_PtxRegister1583 & -4;										   // PTX L3966
	r_PtxRegister1585 = uint32_t(r_PtxRegister1581) - uint32_t(r_PtxRegister1584);	   // PTX L3967
	r_PtxRegister1586 = ShiftRight(uint32_t(r_PtxRegister1578), uint32_t(28));		   // PTX L3968
	r_PtxRegister1587 = uint32_t(r_LaneIndexAtPtx3958) + uint32_t(r_PtxRegister1586);  // PTX L3969
	r_PtxRegister1588 = ShiftRightSigned(int32_t(r_PtxRegister1587), uint32_t(4));	   // PTX L3970
	r_PtxRegister1589 = uint32_t(r_PtxRegister1588) + uint32_t(r_PtxRegister39);	   // PTX L3971
	r_PtxRegister1590 = uint32_t(r_PtxRegister1585) + uint32_t(r_PtxRegister4);		   // PTX L3972
	r_PtxRegister69 = uint32_t(r_PtxRegister1589) + uint32_t(2);					   // PTX L3973
	r_PtxRegister70 = uint32_t(r_PtxRegister1590) + uint32_t(4);					   // PTX L3974
	r_bPtxPredicate169 = int32_t(r_PtxRegister69) < int32_t(0);						   // PTX L3975
	r_bPtxPredicate170 = int32_t(r_PtxRegister69) >= int32_t(r_Scalar32Bits);		   // PTX L3976
	r_bPtxPredicate171 = int32_t(r_PtxRegister70) >= int32_t(r_Scalar36Bits);		   // PTX L3977
	r_bPtxPredicate172 = r_bPtxPredicate170 | r_bPtxPredicate171;					   // PTX L3978
	r_bPtxPredicate173 = r_bPtxPredicate172 | r_bPtxPredicate169;					   // PTX L3979
	if (r_bPtxPredicate173)
	{
		goto L__BB35_144;
	} // PTX L3980
	r_PtxRegister1591 = r_PtxRegister1580 & -4;										  // PTX L3981
	r_PtxRegister1592 = uint32_t(r_LaneIndexAtPtx3958) - uint32_t(r_PtxRegister1591); // PTX L3982
	r_PtxRegister1593 = ShiftLeft(uint32_t(r_PtxRegister70), uint32_t(2));			  // PTX L3983
	r_PtxRegister1594 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister69); // PTX L3984
	r_PtxRegister1595 =
		uint32_t(r_PtxRegister1594) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1593); // PTX L3985
	r_PtxRegister1596 = uint32_t(r_PtxRegister1595) + uint32_t(r_PtxRegister1592);			   // PTX L3986
	r_PtxU64Register261 = uint64_t(int64_t(int32_t(r_PtxRegister1596)) * int64_t(int32_t(4))); // PTX L3987
	r_PtxU64Register262 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register261);		   // PTX L3988
	*reinterpret_cast<ushort2*>(r_PtxU64Register262) =
		make_ushort2(r_PtxU16Register27, r_PtxU16Register28);						   // PTX L3989
L__BB35_144:																		   // PTX L3990
	r_LaneIndexAtPtx3992 = uint32_t((threadIdx.x & 31u));							   // PTX L3992
	r_PtxRegister1598 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3992), uint32_t(31)); // PTX L3994
	r_PtxRegister1599 = ShiftRight(uint32_t(r_PtxRegister1598), uint32_t(30));		   // PTX L3995
	r_PtxRegister1600 = uint32_t(r_LaneIndexAtPtx3992) + uint32_t(r_PtxRegister1599);  // PTX L3996
	r_PtxRegister1601 = ShiftRightSigned(int32_t(r_PtxRegister1600), uint32_t(2));	   // PTX L3997
	r_PtxRegister1602 = ShiftRight(uint32_t(r_PtxRegister1601), uint32_t(30));		   // PTX L3998
	r_PtxRegister1603 = uint32_t(r_PtxRegister1601) + uint32_t(r_PtxRegister1602);	   // PTX L3999
	r_PtxRegister1604 = r_PtxRegister1603 & -4;										   // PTX L4000
	r_PtxRegister1605 = uint32_t(r_PtxRegister1601) - uint32_t(r_PtxRegister1604);	   // PTX L4001
	r_PtxRegister1606 = ShiftRight(uint32_t(r_PtxRegister1598), uint32_t(28));		   // PTX L4002
	r_PtxRegister1607 = uint32_t(r_LaneIndexAtPtx3992) + uint32_t(r_PtxRegister1606);  // PTX L4003
	r_PtxRegister1608 = ShiftRightSigned(int32_t(r_PtxRegister1607), uint32_t(4));	   // PTX L4004
	r_PtxRegister1609 = uint32_t(r_PtxRegister1605) + uint32_t(r_PtxRegister4);		   // PTX L4005
	r_PtxRegister71 = uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1608);		   // PTX L4006
	r_PtxRegister72 = uint32_t(r_PtxRegister1609) + uint32_t(4);					   // PTX L4007
	r_bPtxPredicate174 = int32_t(r_PtxRegister71) < int32_t(0);						   // PTX L4008
	r_bPtxPredicate175 = int32_t(r_PtxRegister71) >= int32_t(r_Scalar32Bits);		   // PTX L4009
	r_bPtxPredicate176 = int32_t(r_PtxRegister72) >= int32_t(r_Scalar36Bits);		   // PTX L4010
	r_bPtxPredicate177 = r_bPtxPredicate175 | r_bPtxPredicate176;					   // PTX L4011
	r_bPtxPredicate178 = r_bPtxPredicate177 | r_bPtxPredicate174;					   // PTX L4012
	if (r_bPtxPredicate178)
	{
		goto L__BB35_146;
	} // PTX L4013
	r_PtxRegister1610 = r_PtxRegister1600 & -4;										  // PTX L4014
	r_PtxRegister1611 = uint32_t(r_LaneIndexAtPtx3992) - uint32_t(r_PtxRegister1610); // PTX L4015
	r_PtxRegister1612 = ShiftLeft(uint32_t(r_PtxRegister72), uint32_t(2));			  // PTX L4016
	r_PtxRegister1613 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister71); // PTX L4017
	r_PtxRegister1614 =
		uint32_t(r_PtxRegister1613) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1612); // PTX L4018
	r_PtxRegister1615 = uint32_t(r_PtxRegister1614) + uint32_t(r_PtxRegister1611);			   // PTX L4019
	r_PtxU64Register263 = uint64_t(int64_t(int32_t(r_PtxRegister1615)) * int64_t(int32_t(4))); // PTX L4020
	r_PtxU64Register264 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register263);		   // PTX L4021
	*reinterpret_cast<ushort2*>(r_PtxU64Register264) =
		make_ushort2(r_PtxU16Register29, r_PtxU16Register30);						   // PTX L4022
L__BB35_146:																		   // PTX L4023
	r_LaneIndexAtPtx4025 = uint32_t((threadIdx.x & 31u));							   // PTX L4025
	r_PtxRegister1617 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4025), uint32_t(31)); // PTX L4027
	r_PtxRegister1618 = ShiftRight(uint32_t(r_PtxRegister1617), uint32_t(30));		   // PTX L4028
	r_PtxRegister1619 = uint32_t(r_LaneIndexAtPtx4025) + uint32_t(r_PtxRegister1618);  // PTX L4029
	r_PtxRegister1620 = ShiftRightSigned(int32_t(r_PtxRegister1619), uint32_t(2));	   // PTX L4030
	r_PtxRegister1621 = ShiftRight(uint32_t(r_PtxRegister1620), uint32_t(30));		   // PTX L4031
	r_PtxRegister1622 = uint32_t(r_PtxRegister1620) + uint32_t(r_PtxRegister1621);	   // PTX L4032
	r_PtxRegister1623 = r_PtxRegister1622 & -4;										   // PTX L4033
	r_PtxRegister1624 = uint32_t(r_PtxRegister1620) - uint32_t(r_PtxRegister1623);	   // PTX L4034
	r_PtxRegister1625 = ShiftRight(uint32_t(r_PtxRegister1617), uint32_t(28));		   // PTX L4035
	r_PtxRegister1626 = uint32_t(r_LaneIndexAtPtx4025) + uint32_t(r_PtxRegister1625);  // PTX L4036
	r_PtxRegister1627 = ShiftRightSigned(int32_t(r_PtxRegister1626), uint32_t(4));	   // PTX L4037
	r_PtxRegister1628 = uint32_t(r_PtxRegister1627) + uint32_t(r_PtxRegister39);	   // PTX L4038
	r_PtxRegister1629 = uint32_t(r_PtxRegister1624) + uint32_t(r_PtxRegister4);		   // PTX L4039
	r_PtxRegister73 = uint32_t(r_PtxRegister1628) + uint32_t(2);					   // PTX L4040
	r_PtxRegister74 = uint32_t(r_PtxRegister1629) + uint32_t(4);					   // PTX L4041
	r_bPtxPredicate179 = int32_t(r_PtxRegister73) < int32_t(0);						   // PTX L4042
	r_bPtxPredicate180 = int32_t(r_PtxRegister73) >= int32_t(r_Scalar32Bits);		   // PTX L4043
	r_bPtxPredicate181 = int32_t(r_PtxRegister74) >= int32_t(r_Scalar36Bits);		   // PTX L4044
	r_bPtxPredicate182 = r_bPtxPredicate180 | r_bPtxPredicate181;					   // PTX L4045
	r_bPtxPredicate183 = r_bPtxPredicate182 | r_bPtxPredicate179;					   // PTX L4046
	if (r_bPtxPredicate183)
	{
		goto L__BB35_148;
	} // PTX L4047
	r_PtxRegister1630 = r_PtxRegister1619 & -4;										  // PTX L4048
	r_PtxRegister1631 = uint32_t(r_LaneIndexAtPtx4025) - uint32_t(r_PtxRegister1630); // PTX L4049
	r_PtxRegister1632 = ShiftLeft(uint32_t(r_PtxRegister74), uint32_t(2));			  // PTX L4050
	r_PtxRegister1633 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister73); // PTX L4051
	r_PtxRegister1634 =
		uint32_t(r_PtxRegister1633) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1632); // PTX L4052
	r_PtxRegister1635 = uint32_t(r_PtxRegister1634) + uint32_t(r_PtxRegister1631);			   // PTX L4053
	r_PtxU64Register265 = uint64_t(int64_t(int32_t(r_PtxRegister1635)) * int64_t(int32_t(4))); // PTX L4054
	r_PtxU64Register266 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register265);		   // PTX L4055
	*reinterpret_cast<ushort2*>(r_PtxU64Register266) =
		make_ushort2(r_PtxU16Register31, r_PtxU16Register32);						   // PTX L4056
L__BB35_148:																		   // PTX L4057
	r_LaneIndexAtPtx4059 = uint32_t((threadIdx.x & 31u));							   // PTX L4059
	r_PtxRegister1637 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4059), uint32_t(31)); // PTX L4061
	r_PtxRegister1638 = ShiftRight(uint32_t(r_PtxRegister1637), uint32_t(30));		   // PTX L4062
	r_PtxRegister1639 = uint32_t(r_LaneIndexAtPtx4059) + uint32_t(r_PtxRegister1638);  // PTX L4063
	r_PtxRegister1640 = ShiftRightSigned(int32_t(r_PtxRegister1639), uint32_t(2));	   // PTX L4064
	r_PtxRegister1641 = ShiftRight(uint32_t(r_PtxRegister1640), uint32_t(30));		   // PTX L4065
	r_PtxRegister1642 = uint32_t(r_PtxRegister1640) + uint32_t(r_PtxRegister1641);	   // PTX L4066
	r_PtxRegister1643 = r_PtxRegister1642 & -4;										   // PTX L4067
	r_PtxRegister1644 = uint32_t(r_PtxRegister1640) - uint32_t(r_PtxRegister1643);	   // PTX L4068
	r_PtxRegister1645 = ShiftRight(uint32_t(r_PtxRegister1637), uint32_t(28));		   // PTX L4069
	r_PtxRegister1646 = uint32_t(r_LaneIndexAtPtx4059) + uint32_t(r_PtxRegister1645);  // PTX L4070
	r_PtxRegister1647 = ShiftRightSigned(int32_t(r_PtxRegister1646), uint32_t(4));	   // PTX L4071
	r_PtxRegister1648 = uint32_t(r_PtxRegister1647) + uint32_t(r_PtxRegister39);	   // PTX L4072
	r_PtxRegister75 = uint32_t(r_PtxRegister1648) + uint32_t(4);					   // PTX L4073
	r_PtxRegister76 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1644);		   // PTX L4074
	r_bPtxPredicate184 = int32_t(r_PtxRegister75) < int32_t(0);						   // PTX L4075
	r_bPtxPredicate185 = int32_t(r_PtxRegister75) >= int32_t(r_Scalar32Bits);		   // PTX L4076
	r_bPtxPredicate186 = r_bPtxPredicate184 | r_bPtxPredicate185;					   // PTX L4077
	r_bPtxPredicate187 = int32_t(r_PtxRegister76) < int32_t(0);						   // PTX L4078
	r_bPtxPredicate188 = int32_t(r_PtxRegister76) >= int32_t(r_Scalar36Bits);		   // PTX L4079
	r_bPtxPredicate189 = r_bPtxPredicate187 | r_bPtxPredicate188;					   // PTX L4080
	r_bPtxPredicate190 = r_bPtxPredicate186 | r_bPtxPredicate189;					   // PTX L4081
	if (r_bPtxPredicate190)
	{
		goto L__BB35_150;
	} // PTX L4082
	r_PtxRegister1649 = r_PtxRegister1639 & -4;										  // PTX L4083
	r_PtxRegister1650 = uint32_t(r_LaneIndexAtPtx4059) - uint32_t(r_PtxRegister1649); // PTX L4084
	r_PtxRegister1651 = ShiftLeft(uint32_t(r_PtxRegister76), uint32_t(2));			  // PTX L4085
	r_PtxRegister1652 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister75); // PTX L4086
	r_PtxRegister1653 =
		uint32_t(r_PtxRegister1652) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1651); // PTX L4087
	r_PtxRegister1654 = uint32_t(r_PtxRegister1653) + uint32_t(r_PtxRegister1650);			   // PTX L4088
	r_PtxU64Register267 = uint64_t(int64_t(int32_t(r_PtxRegister1654)) * int64_t(int32_t(4))); // PTX L4089
	r_PtxU64Register268 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register267);		   // PTX L4090
	*reinterpret_cast<ushort2*>(r_PtxU64Register268) =
		make_ushort2(r_PtxU16Register33, r_PtxU16Register34);						   // PTX L4091
L__BB35_150:																		   // PTX L4092
	r_LaneIndexAtPtx4094 = uint32_t((threadIdx.x & 31u));							   // PTX L4094
	r_PtxRegister1656 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4094), uint32_t(31)); // PTX L4096
	r_PtxRegister1657 = ShiftRight(uint32_t(r_PtxRegister1656), uint32_t(30));		   // PTX L4097
	r_PtxRegister1658 = uint32_t(r_LaneIndexAtPtx4094) + uint32_t(r_PtxRegister1657);  // PTX L4098
	r_PtxRegister1659 = ShiftRightSigned(int32_t(r_PtxRegister1658), uint32_t(2));	   // PTX L4099
	r_PtxRegister1660 = ShiftRight(uint32_t(r_PtxRegister1659), uint32_t(30));		   // PTX L4100
	r_PtxRegister1661 = uint32_t(r_PtxRegister1659) + uint32_t(r_PtxRegister1660);	   // PTX L4101
	r_PtxRegister1662 = r_PtxRegister1661 & -4;										   // PTX L4102
	r_PtxRegister1663 = uint32_t(r_PtxRegister1659) - uint32_t(r_PtxRegister1662);	   // PTX L4103
	r_PtxRegister1664 = ShiftRight(uint32_t(r_PtxRegister1656), uint32_t(28));		   // PTX L4104
	r_PtxRegister1665 = uint32_t(r_LaneIndexAtPtx4094) + uint32_t(r_PtxRegister1664);  // PTX L4105
	r_PtxRegister1666 = ShiftRightSigned(int32_t(r_PtxRegister1665), uint32_t(4));	   // PTX L4106
	r_PtxRegister1667 = uint32_t(r_PtxRegister1666) + uint32_t(r_PtxRegister39);	   // PTX L4107
	r_PtxRegister77 = uint32_t(r_PtxRegister1667) + uint32_t(6);					   // PTX L4108
	r_PtxRegister78 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1663);		   // PTX L4109
	r_bPtxPredicate191 = int32_t(r_PtxRegister77) < int32_t(0);						   // PTX L4110
	r_bPtxPredicate192 = int32_t(r_PtxRegister77) >= int32_t(r_Scalar32Bits);		   // PTX L4111
	r_bPtxPredicate193 = r_bPtxPredicate191 | r_bPtxPredicate192;					   // PTX L4112
	r_bPtxPredicate194 = int32_t(r_PtxRegister78) < int32_t(0);						   // PTX L4113
	r_bPtxPredicate195 = int32_t(r_PtxRegister78) >= int32_t(r_Scalar36Bits);		   // PTX L4114
	r_bPtxPredicate196 = r_bPtxPredicate194 | r_bPtxPredicate195;					   // PTX L4115
	r_bPtxPredicate197 = r_bPtxPredicate193 | r_bPtxPredicate196;					   // PTX L4116
	if (r_bPtxPredicate197)
	{
		goto L__BB35_152;
	} // PTX L4117
	r_PtxRegister1668 = r_PtxRegister1658 & -4;										  // PTX L4118
	r_PtxRegister1669 = uint32_t(r_LaneIndexAtPtx4094) - uint32_t(r_PtxRegister1668); // PTX L4119
	r_PtxRegister1670 = ShiftLeft(uint32_t(r_PtxRegister78), uint32_t(2));			  // PTX L4120
	r_PtxRegister1671 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister77); // PTX L4121
	r_PtxRegister1672 =
		uint32_t(r_PtxRegister1671) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1670); // PTX L4122
	r_PtxRegister1673 = uint32_t(r_PtxRegister1672) + uint32_t(r_PtxRegister1669);			   // PTX L4123
	r_PtxU64Register269 = uint64_t(int64_t(int32_t(r_PtxRegister1673)) * int64_t(int32_t(4))); // PTX L4124
	r_PtxU64Register270 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register269);		   // PTX L4125
	*reinterpret_cast<ushort2*>(r_PtxU64Register270) =
		make_ushort2(r_PtxU16Register35, r_PtxU16Register36);						   // PTX L4126
L__BB35_152:																		   // PTX L4127
	r_LaneIndexAtPtx4129 = uint32_t((threadIdx.x & 31u));							   // PTX L4129
	r_PtxRegister1675 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4129), uint32_t(31)); // PTX L4131
	r_PtxRegister1676 = ShiftRight(uint32_t(r_PtxRegister1675), uint32_t(30));		   // PTX L4132
	r_PtxRegister1677 = uint32_t(r_LaneIndexAtPtx4129) + uint32_t(r_PtxRegister1676);  // PTX L4133
	r_PtxRegister1678 = ShiftRightSigned(int32_t(r_PtxRegister1677), uint32_t(2));	   // PTX L4134
	r_PtxRegister1679 = ShiftRight(uint32_t(r_PtxRegister1678), uint32_t(30));		   // PTX L4135
	r_PtxRegister1680 = uint32_t(r_PtxRegister1678) + uint32_t(r_PtxRegister1679);	   // PTX L4136
	r_PtxRegister1681 = r_PtxRegister1680 & -4;										   // PTX L4137
	r_PtxRegister1682 = uint32_t(r_PtxRegister1678) - uint32_t(r_PtxRegister1681);	   // PTX L4138
	r_PtxRegister1683 = ShiftRight(uint32_t(r_PtxRegister1675), uint32_t(28));		   // PTX L4139
	r_PtxRegister1684 = uint32_t(r_LaneIndexAtPtx4129) + uint32_t(r_PtxRegister1683);  // PTX L4140
	r_PtxRegister1685 = ShiftRightSigned(int32_t(r_PtxRegister1684), uint32_t(4));	   // PTX L4141
	r_PtxRegister1686 = uint32_t(r_PtxRegister1685) + uint32_t(r_PtxRegister39);	   // PTX L4142
	r_PtxRegister79 = uint32_t(r_PtxRegister1686) + uint32_t(4);					   // PTX L4143
	r_PtxRegister80 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1682);		   // PTX L4144
	r_bPtxPredicate198 = int32_t(r_PtxRegister79) < int32_t(0);						   // PTX L4145
	r_bPtxPredicate199 = int32_t(r_PtxRegister79) >= int32_t(r_Scalar32Bits);		   // PTX L4146
	r_bPtxPredicate200 = r_bPtxPredicate198 | r_bPtxPredicate199;					   // PTX L4147
	r_bPtxPredicate201 = int32_t(r_PtxRegister80) < int32_t(0);						   // PTX L4148
	r_bPtxPredicate202 = int32_t(r_PtxRegister80) >= int32_t(r_Scalar36Bits);		   // PTX L4149
	r_bPtxPredicate203 = r_bPtxPredicate201 | r_bPtxPredicate202;					   // PTX L4150
	r_bPtxPredicate204 = r_bPtxPredicate200 | r_bPtxPredicate203;					   // PTX L4151
	if (r_bPtxPredicate204)
	{
		goto L__BB35_154;
	} // PTX L4152
	r_PtxRegister1687 = r_PtxRegister1677 & -4;										  // PTX L4153
	r_PtxRegister1688 = uint32_t(r_LaneIndexAtPtx4129) - uint32_t(r_PtxRegister1687); // PTX L4154
	r_PtxRegister1689 = ShiftLeft(uint32_t(r_PtxRegister80), uint32_t(2));			  // PTX L4155
	r_PtxRegister1690 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister79); // PTX L4156
	r_PtxRegister1691 =
		uint32_t(r_PtxRegister1690) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1689); // PTX L4157
	r_PtxRegister1692 = uint32_t(r_PtxRegister1691) + uint32_t(r_PtxRegister1688);			   // PTX L4158
	r_PtxU64Register271 = uint64_t(int64_t(int32_t(r_PtxRegister1692)) * int64_t(int32_t(4))); // PTX L4159
	r_PtxU64Register272 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register271);		   // PTX L4160
	*reinterpret_cast<ushort2*>(r_PtxU64Register272) =
		make_ushort2(r_PtxU16Register37, r_PtxU16Register38);						   // PTX L4161
L__BB35_154:																		   // PTX L4162
	r_LaneIndexAtPtx4164 = uint32_t((threadIdx.x & 31u));							   // PTX L4164
	r_PtxRegister1694 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4164), uint32_t(31)); // PTX L4166
	r_PtxRegister1695 = ShiftRight(uint32_t(r_PtxRegister1694), uint32_t(30));		   // PTX L4167
	r_PtxRegister1696 = uint32_t(r_LaneIndexAtPtx4164) + uint32_t(r_PtxRegister1695);  // PTX L4168
	r_PtxRegister1697 = ShiftRightSigned(int32_t(r_PtxRegister1696), uint32_t(2));	   // PTX L4169
	r_PtxRegister1698 = ShiftRight(uint32_t(r_PtxRegister1697), uint32_t(30));		   // PTX L4170
	r_PtxRegister1699 = uint32_t(r_PtxRegister1697) + uint32_t(r_PtxRegister1698);	   // PTX L4171
	r_PtxRegister1700 = r_PtxRegister1699 & -4;										   // PTX L4172
	r_PtxRegister1701 = uint32_t(r_PtxRegister1697) - uint32_t(r_PtxRegister1700);	   // PTX L4173
	r_PtxRegister1702 = ShiftRight(uint32_t(r_PtxRegister1694), uint32_t(28));		   // PTX L4174
	r_PtxRegister1703 = uint32_t(r_LaneIndexAtPtx4164) + uint32_t(r_PtxRegister1702);  // PTX L4175
	r_PtxRegister1704 = ShiftRightSigned(int32_t(r_PtxRegister1703), uint32_t(4));	   // PTX L4176
	r_PtxRegister1705 = uint32_t(r_PtxRegister1704) + uint32_t(r_PtxRegister39);	   // PTX L4177
	r_PtxRegister81 = uint32_t(r_PtxRegister1705) + uint32_t(6);					   // PTX L4178
	r_PtxRegister82 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1701);		   // PTX L4179
	r_bPtxPredicate205 = int32_t(r_PtxRegister81) < int32_t(0);						   // PTX L4180
	r_bPtxPredicate206 = int32_t(r_PtxRegister81) >= int32_t(r_Scalar32Bits);		   // PTX L4181
	r_bPtxPredicate207 = r_bPtxPredicate205 | r_bPtxPredicate206;					   // PTX L4182
	r_bPtxPredicate208 = int32_t(r_PtxRegister82) < int32_t(0);						   // PTX L4183
	r_bPtxPredicate209 = int32_t(r_PtxRegister82) >= int32_t(r_Scalar36Bits);		   // PTX L4184
	r_bPtxPredicate210 = r_bPtxPredicate208 | r_bPtxPredicate209;					   // PTX L4185
	r_bPtxPredicate211 = r_bPtxPredicate207 | r_bPtxPredicate210;					   // PTX L4186
	if (r_bPtxPredicate211)
	{
		goto L__BB35_156;
	} // PTX L4187
	r_PtxRegister1706 = r_PtxRegister1696 & -4;										  // PTX L4188
	r_PtxRegister1707 = uint32_t(r_LaneIndexAtPtx4164) - uint32_t(r_PtxRegister1706); // PTX L4189
	r_PtxRegister1708 = ShiftLeft(uint32_t(r_PtxRegister82), uint32_t(2));			  // PTX L4190
	r_PtxRegister1709 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister81); // PTX L4191
	r_PtxRegister1710 =
		uint32_t(r_PtxRegister1709) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1708); // PTX L4192
	r_PtxRegister1711 = uint32_t(r_PtxRegister1710) + uint32_t(r_PtxRegister1707);			   // PTX L4193
	r_PtxU64Register273 = uint64_t(int64_t(int32_t(r_PtxRegister1711)) * int64_t(int32_t(4))); // PTX L4194
	r_PtxU64Register274 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register273);		   // PTX L4195
	*reinterpret_cast<ushort2*>(r_PtxU64Register274) =
		make_ushort2(r_PtxU16Register39, r_PtxU16Register40);						   // PTX L4196
L__BB35_156:																		   // PTX L4197
	r_LaneIndexAtPtx4199 = uint32_t((threadIdx.x & 31u));							   // PTX L4199
	r_PtxRegister1713 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4199), uint32_t(31)); // PTX L4201
	r_PtxRegister1714 = ShiftRight(uint32_t(r_PtxRegister1713), uint32_t(30));		   // PTX L4202
	r_PtxRegister1715 = uint32_t(r_LaneIndexAtPtx4199) + uint32_t(r_PtxRegister1714);  // PTX L4203
	r_PtxRegister1716 = ShiftRightSigned(int32_t(r_PtxRegister1715), uint32_t(2));	   // PTX L4204
	r_PtxRegister1717 = ShiftRight(uint32_t(r_PtxRegister1716), uint32_t(30));		   // PTX L4205
	r_PtxRegister1718 = uint32_t(r_PtxRegister1716) + uint32_t(r_PtxRegister1717);	   // PTX L4206
	r_PtxRegister1719 = r_PtxRegister1718 & -4;										   // PTX L4207
	r_PtxRegister1720 = uint32_t(r_PtxRegister1716) - uint32_t(r_PtxRegister1719);	   // PTX L4208
	r_PtxRegister1721 = ShiftRight(uint32_t(r_PtxRegister1713), uint32_t(28));		   // PTX L4209
	r_PtxRegister1722 = uint32_t(r_LaneIndexAtPtx4199) + uint32_t(r_PtxRegister1721);  // PTX L4210
	r_PtxRegister1723 = ShiftRightSigned(int32_t(r_PtxRegister1722), uint32_t(4));	   // PTX L4211
	r_PtxRegister1724 = uint32_t(r_PtxRegister1723) + uint32_t(r_PtxRegister39);	   // PTX L4212
	r_PtxRegister83 = uint32_t(r_PtxRegister1724) + uint32_t(4);					   // PTX L4213
	r_PtxRegister84 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1720);		   // PTX L4214
	r_bPtxPredicate212 = int32_t(r_PtxRegister83) < int32_t(0);						   // PTX L4215
	r_bPtxPredicate213 = int32_t(r_PtxRegister83) >= int32_t(r_Scalar32Bits);		   // PTX L4216
	r_bPtxPredicate214 = r_bPtxPredicate212 | r_bPtxPredicate213;					   // PTX L4217
	r_bPtxPredicate215 = int32_t(r_PtxRegister84) < int32_t(0);						   // PTX L4218
	r_bPtxPredicate216 = int32_t(r_PtxRegister84) >= int32_t(r_Scalar36Bits);		   // PTX L4219
	r_bPtxPredicate217 = r_bPtxPredicate215 | r_bPtxPredicate216;					   // PTX L4220
	r_bPtxPredicate218 = r_bPtxPredicate214 | r_bPtxPredicate217;					   // PTX L4221
	if (r_bPtxPredicate218)
	{
		goto L__BB35_158;
	} // PTX L4222
	r_PtxRegister1725 = r_PtxRegister1715 & -4;										  // PTX L4223
	r_PtxRegister1726 = uint32_t(r_LaneIndexAtPtx4199) - uint32_t(r_PtxRegister1725); // PTX L4224
	r_PtxRegister1727 = ShiftLeft(uint32_t(r_PtxRegister84), uint32_t(2));			  // PTX L4225
	r_PtxRegister1728 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister83); // PTX L4226
	r_PtxRegister1729 =
		uint32_t(r_PtxRegister1728) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1727); // PTX L4227
	r_PtxRegister1730 = uint32_t(r_PtxRegister1729) + uint32_t(r_PtxRegister1726);			   // PTX L4228
	r_PtxU64Register275 = uint64_t(int64_t(int32_t(r_PtxRegister1730)) * int64_t(int32_t(4))); // PTX L4229
	r_PtxU64Register276 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register275);		   // PTX L4230
	*reinterpret_cast<ushort2*>(r_PtxU64Register276) =
		make_ushort2(r_PtxU16Register41, r_PtxU16Register42);						   // PTX L4231
L__BB35_158:																		   // PTX L4232
	r_LaneIndexAtPtx4234 = uint32_t((threadIdx.x & 31u));							   // PTX L4234
	r_PtxRegister1732 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4234), uint32_t(31)); // PTX L4236
	r_PtxRegister1733 = ShiftRight(uint32_t(r_PtxRegister1732), uint32_t(30));		   // PTX L4237
	r_PtxRegister1734 = uint32_t(r_LaneIndexAtPtx4234) + uint32_t(r_PtxRegister1733);  // PTX L4238
	r_PtxRegister1735 = ShiftRightSigned(int32_t(r_PtxRegister1734), uint32_t(2));	   // PTX L4239
	r_PtxRegister1736 = ShiftRight(uint32_t(r_PtxRegister1735), uint32_t(30));		   // PTX L4240
	r_PtxRegister1737 = uint32_t(r_PtxRegister1735) + uint32_t(r_PtxRegister1736);	   // PTX L4241
	r_PtxRegister1738 = r_PtxRegister1737 & -4;										   // PTX L4242
	r_PtxRegister1739 = uint32_t(r_PtxRegister1735) - uint32_t(r_PtxRegister1738);	   // PTX L4243
	r_PtxRegister1740 = ShiftRight(uint32_t(r_PtxRegister1732), uint32_t(28));		   // PTX L4244
	r_PtxRegister1741 = uint32_t(r_LaneIndexAtPtx4234) + uint32_t(r_PtxRegister1740);  // PTX L4245
	r_PtxRegister1742 = ShiftRightSigned(int32_t(r_PtxRegister1741), uint32_t(4));	   // PTX L4246
	r_PtxRegister1743 = uint32_t(r_PtxRegister1742) + uint32_t(r_PtxRegister39);	   // PTX L4247
	r_PtxRegister85 = uint32_t(r_PtxRegister1743) + uint32_t(6);					   // PTX L4248
	r_PtxRegister86 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1739);		   // PTX L4249
	r_bPtxPredicate219 = int32_t(r_PtxRegister85) < int32_t(0);						   // PTX L4250
	r_bPtxPredicate220 = int32_t(r_PtxRegister85) >= int32_t(r_Scalar32Bits);		   // PTX L4251
	r_bPtxPredicate221 = r_bPtxPredicate219 | r_bPtxPredicate220;					   // PTX L4252
	r_bPtxPredicate222 = int32_t(r_PtxRegister86) < int32_t(0);						   // PTX L4253
	r_bPtxPredicate223 = int32_t(r_PtxRegister86) >= int32_t(r_Scalar36Bits);		   // PTX L4254
	r_bPtxPredicate224 = r_bPtxPredicate222 | r_bPtxPredicate223;					   // PTX L4255
	r_bPtxPredicate225 = r_bPtxPredicate221 | r_bPtxPredicate224;					   // PTX L4256
	if (r_bPtxPredicate225)
	{
		goto L__BB35_160;
	} // PTX L4257
	r_PtxRegister1744 = r_PtxRegister1734 & -4;										  // PTX L4258
	r_PtxRegister1745 = uint32_t(r_LaneIndexAtPtx4234) - uint32_t(r_PtxRegister1744); // PTX L4259
	r_PtxRegister1746 = ShiftLeft(uint32_t(r_PtxRegister86), uint32_t(2));			  // PTX L4260
	r_PtxRegister1747 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister85); // PTX L4261
	r_PtxRegister1748 =
		uint32_t(r_PtxRegister1747) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1746); // PTX L4262
	r_PtxRegister1749 = uint32_t(r_PtxRegister1748) + uint32_t(r_PtxRegister1745);			   // PTX L4263
	r_PtxU64Register277 = uint64_t(int64_t(int32_t(r_PtxRegister1749)) * int64_t(int32_t(4))); // PTX L4264
	r_PtxU64Register278 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register277);		   // PTX L4265
	*reinterpret_cast<ushort2*>(r_PtxU64Register278) =
		make_ushort2(r_PtxU16Register43, r_PtxU16Register44);						   // PTX L4266
L__BB35_160:																		   // PTX L4267
	r_LaneIndexAtPtx4269 = uint32_t((threadIdx.x & 31u));							   // PTX L4269
	r_PtxRegister1751 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4269), uint32_t(31)); // PTX L4271
	r_PtxRegister1752 = ShiftRight(uint32_t(r_PtxRegister1751), uint32_t(30));		   // PTX L4272
	r_PtxRegister1753 = uint32_t(r_LaneIndexAtPtx4269) + uint32_t(r_PtxRegister1752);  // PTX L4273
	r_PtxRegister1754 = ShiftRightSigned(int32_t(r_PtxRegister1753), uint32_t(2));	   // PTX L4274
	r_PtxRegister1755 = ShiftRight(uint32_t(r_PtxRegister1754), uint32_t(30));		   // PTX L4275
	r_PtxRegister1756 = uint32_t(r_PtxRegister1754) + uint32_t(r_PtxRegister1755);	   // PTX L4276
	r_PtxRegister1757 = r_PtxRegister1756 & -4;										   // PTX L4277
	r_PtxRegister1758 = uint32_t(r_PtxRegister1754) - uint32_t(r_PtxRegister1757);	   // PTX L4278
	r_PtxRegister1759 = ShiftRight(uint32_t(r_PtxRegister1751), uint32_t(28));		   // PTX L4279
	r_PtxRegister1760 = uint32_t(r_LaneIndexAtPtx4269) + uint32_t(r_PtxRegister1759);  // PTX L4280
	r_PtxRegister1761 = ShiftRightSigned(int32_t(r_PtxRegister1760), uint32_t(4));	   // PTX L4281
	r_PtxRegister1762 = uint32_t(r_PtxRegister1761) + uint32_t(r_PtxRegister39);	   // PTX L4282
	r_PtxRegister87 = uint32_t(r_PtxRegister1762) + uint32_t(4);					   // PTX L4283
	r_PtxRegister88 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1758);		   // PTX L4284
	r_bPtxPredicate226 = int32_t(r_PtxRegister87) < int32_t(0);						   // PTX L4285
	r_bPtxPredicate227 = int32_t(r_PtxRegister87) >= int32_t(r_Scalar32Bits);		   // PTX L4286
	r_bPtxPredicate228 = r_bPtxPredicate226 | r_bPtxPredicate227;					   // PTX L4287
	r_bPtxPredicate229 = int32_t(r_PtxRegister88) < int32_t(0);						   // PTX L4288
	r_bPtxPredicate230 = int32_t(r_PtxRegister88) >= int32_t(r_Scalar36Bits);		   // PTX L4289
	r_bPtxPredicate231 = r_bPtxPredicate229 | r_bPtxPredicate230;					   // PTX L4290
	r_bPtxPredicate232 = r_bPtxPredicate228 | r_bPtxPredicate231;					   // PTX L4291
	if (r_bPtxPredicate232)
	{
		goto L__BB35_162;
	} // PTX L4292
	r_PtxRegister1763 = r_PtxRegister1753 & -4;										  // PTX L4293
	r_PtxRegister1764 = uint32_t(r_LaneIndexAtPtx4269) - uint32_t(r_PtxRegister1763); // PTX L4294
	r_PtxRegister1765 = ShiftLeft(uint32_t(r_PtxRegister88), uint32_t(2));			  // PTX L4295
	r_PtxRegister1766 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister87); // PTX L4296
	r_PtxRegister1767 =
		uint32_t(r_PtxRegister1766) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1765); // PTX L4297
	r_PtxRegister1768 = uint32_t(r_PtxRegister1767) + uint32_t(r_PtxRegister1764);			   // PTX L4298
	r_PtxU64Register279 = uint64_t(int64_t(int32_t(r_PtxRegister1768)) * int64_t(int32_t(4))); // PTX L4299
	r_PtxU64Register280 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register279);		   // PTX L4300
	*reinterpret_cast<ushort2*>(r_PtxU64Register280) =
		make_ushort2(r_PtxU16Register45, r_PtxU16Register46);						   // PTX L4301
L__BB35_162:																		   // PTX L4302
	r_LaneIndexAtPtx4304 = uint32_t((threadIdx.x & 31u));							   // PTX L4304
	r_PtxRegister1770 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4304), uint32_t(31)); // PTX L4306
	r_PtxRegister1771 = ShiftRight(uint32_t(r_PtxRegister1770), uint32_t(30));		   // PTX L4307
	r_PtxRegister1772 = uint32_t(r_LaneIndexAtPtx4304) + uint32_t(r_PtxRegister1771);  // PTX L4308
	r_PtxRegister1773 = ShiftRightSigned(int32_t(r_PtxRegister1772), uint32_t(2));	   // PTX L4309
	r_PtxRegister1774 = ShiftRight(uint32_t(r_PtxRegister1773), uint32_t(30));		   // PTX L4310
	r_PtxRegister1775 = uint32_t(r_PtxRegister1773) + uint32_t(r_PtxRegister1774);	   // PTX L4311
	r_PtxRegister1776 = r_PtxRegister1775 & -4;										   // PTX L4312
	r_PtxRegister1777 = uint32_t(r_PtxRegister1773) - uint32_t(r_PtxRegister1776);	   // PTX L4313
	r_PtxRegister1778 = ShiftRight(uint32_t(r_PtxRegister1770), uint32_t(28));		   // PTX L4314
	r_PtxRegister1779 = uint32_t(r_LaneIndexAtPtx4304) + uint32_t(r_PtxRegister1778);  // PTX L4315
	r_PtxRegister1780 = ShiftRightSigned(int32_t(r_PtxRegister1779), uint32_t(4));	   // PTX L4316
	r_PtxRegister1781 = uint32_t(r_PtxRegister1780) + uint32_t(r_PtxRegister39);	   // PTX L4317
	r_PtxRegister89 = uint32_t(r_PtxRegister1781) + uint32_t(6);					   // PTX L4318
	r_PtxRegister90 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1777);		   // PTX L4319
	r_bPtxPredicate233 = int32_t(r_PtxRegister89) < int32_t(0);						   // PTX L4320
	r_bPtxPredicate234 = int32_t(r_PtxRegister89) >= int32_t(r_Scalar32Bits);		   // PTX L4321
	r_bPtxPredicate235 = r_bPtxPredicate233 | r_bPtxPredicate234;					   // PTX L4322
	r_bPtxPredicate236 = int32_t(r_PtxRegister90) < int32_t(0);						   // PTX L4323
	r_bPtxPredicate237 = int32_t(r_PtxRegister90) >= int32_t(r_Scalar36Bits);		   // PTX L4324
	r_bPtxPredicate238 = r_bPtxPredicate236 | r_bPtxPredicate237;					   // PTX L4325
	r_bPtxPredicate239 = r_bPtxPredicate235 | r_bPtxPredicate238;					   // PTX L4326
	if (r_bPtxPredicate239)
	{
		goto L__BB35_164;
	} // PTX L4327
	r_PtxRegister1782 = r_PtxRegister1772 & -4;										  // PTX L4328
	r_PtxRegister1783 = uint32_t(r_LaneIndexAtPtx4304) - uint32_t(r_PtxRegister1782); // PTX L4329
	r_PtxRegister1784 = ShiftLeft(uint32_t(r_PtxRegister90), uint32_t(2));			  // PTX L4330
	r_PtxRegister1785 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister89); // PTX L4331
	r_PtxRegister1786 =
		uint32_t(r_PtxRegister1785) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1784); // PTX L4332
	r_PtxRegister1787 = uint32_t(r_PtxRegister1786) + uint32_t(r_PtxRegister1783);			   // PTX L4333
	r_PtxU64Register281 = uint64_t(int64_t(int32_t(r_PtxRegister1787)) * int64_t(int32_t(4))); // PTX L4334
	r_PtxU64Register282 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register281);		   // PTX L4335
	*reinterpret_cast<ushort2*>(r_PtxU64Register282) =
		make_ushort2(r_PtxU16Register47, r_PtxU16Register48);						   // PTX L4336
L__BB35_164:																		   // PTX L4337
	r_LaneIndexAtPtx4339 = uint32_t((threadIdx.x & 31u));							   // PTX L4339
	r_PtxRegister1789 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4339), uint32_t(31)); // PTX L4341
	r_PtxRegister1790 = ShiftRight(uint32_t(r_PtxRegister1789), uint32_t(30));		   // PTX L4342
	r_PtxRegister1791 = uint32_t(r_LaneIndexAtPtx4339) + uint32_t(r_PtxRegister1790);  // PTX L4343
	r_PtxRegister1792 = ShiftRightSigned(int32_t(r_PtxRegister1791), uint32_t(2));	   // PTX L4344
	r_PtxRegister1793 = ShiftRight(uint32_t(r_PtxRegister1792), uint32_t(30));		   // PTX L4345
	r_PtxRegister1794 = uint32_t(r_PtxRegister1792) + uint32_t(r_PtxRegister1793);	   // PTX L4346
	r_PtxRegister1795 = r_PtxRegister1794 & -4;										   // PTX L4347
	r_PtxRegister1796 = uint32_t(r_PtxRegister1792) - uint32_t(r_PtxRegister1795);	   // PTX L4348
	r_PtxRegister1797 = ShiftRight(uint32_t(r_PtxRegister1789), uint32_t(28));		   // PTX L4349
	r_PtxRegister1798 = uint32_t(r_LaneIndexAtPtx4339) + uint32_t(r_PtxRegister1797);  // PTX L4350
	r_PtxRegister1799 = ShiftRightSigned(int32_t(r_PtxRegister1798), uint32_t(4));	   // PTX L4351
	r_PtxRegister1800 = uint32_t(r_PtxRegister1799) + uint32_t(r_PtxRegister39);	   // PTX L4352
	r_PtxRegister1801 = uint32_t(r_PtxRegister1796) + uint32_t(r_PtxRegister4);		   // PTX L4353
	r_PtxRegister91 = uint32_t(r_PtxRegister1800) + uint32_t(4);					   // PTX L4354
	r_PtxRegister92 = uint32_t(r_PtxRegister1801) + uint32_t(4);					   // PTX L4355
	r_bPtxPredicate240 = int32_t(r_PtxRegister91) < int32_t(0);						   // PTX L4356
	r_bPtxPredicate241 = int32_t(r_PtxRegister91) >= int32_t(r_Scalar32Bits);		   // PTX L4357
	r_bPtxPredicate242 = int32_t(r_PtxRegister92) >= int32_t(r_Scalar36Bits);		   // PTX L4358
	r_bPtxPredicate243 = r_bPtxPredicate241 | r_bPtxPredicate242;					   // PTX L4359
	r_bPtxPredicate244 = r_bPtxPredicate243 | r_bPtxPredicate240;					   // PTX L4360
	if (r_bPtxPredicate244)
	{
		goto L__BB35_166;
	} // PTX L4361
	r_PtxRegister1802 = r_PtxRegister1791 & -4;										  // PTX L4362
	r_PtxRegister1803 = uint32_t(r_LaneIndexAtPtx4339) - uint32_t(r_PtxRegister1802); // PTX L4363
	r_PtxRegister1804 = ShiftLeft(uint32_t(r_PtxRegister92), uint32_t(2));			  // PTX L4364
	r_PtxRegister1805 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister91); // PTX L4365
	r_PtxRegister1806 =
		uint32_t(r_PtxRegister1805) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1804); // PTX L4366
	r_PtxRegister1807 = uint32_t(r_PtxRegister1806) + uint32_t(r_PtxRegister1803);			   // PTX L4367
	r_PtxU64Register283 = uint64_t(int64_t(int32_t(r_PtxRegister1807)) * int64_t(int32_t(4))); // PTX L4368
	r_PtxU64Register284 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register283);		   // PTX L4369
	*reinterpret_cast<ushort2*>(r_PtxU64Register284) =
		make_ushort2(r_PtxU16Register49, r_PtxU16Register50);						   // PTX L4370
L__BB35_166:																		   // PTX L4371
	r_LaneIndexAtPtx4373 = uint32_t((threadIdx.x & 31u));							   // PTX L4373
	r_PtxRegister1809 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4373), uint32_t(31)); // PTX L4375
	r_PtxRegister1810 = ShiftRight(uint32_t(r_PtxRegister1809), uint32_t(30));		   // PTX L4376
	r_PtxRegister1811 = uint32_t(r_LaneIndexAtPtx4373) + uint32_t(r_PtxRegister1810);  // PTX L4377
	r_PtxRegister1812 = ShiftRightSigned(int32_t(r_PtxRegister1811), uint32_t(2));	   // PTX L4378
	r_PtxRegister1813 = ShiftRight(uint32_t(r_PtxRegister1812), uint32_t(30));		   // PTX L4379
	r_PtxRegister1814 = uint32_t(r_PtxRegister1812) + uint32_t(r_PtxRegister1813);	   // PTX L4380
	r_PtxRegister1815 = r_PtxRegister1814 & -4;										   // PTX L4381
	r_PtxRegister1816 = uint32_t(r_PtxRegister1812) - uint32_t(r_PtxRegister1815);	   // PTX L4382
	r_PtxRegister1817 = ShiftRight(uint32_t(r_PtxRegister1809), uint32_t(28));		   // PTX L4383
	r_PtxRegister1818 = uint32_t(r_LaneIndexAtPtx4373) + uint32_t(r_PtxRegister1817);  // PTX L4384
	r_PtxRegister1819 = ShiftRightSigned(int32_t(r_PtxRegister1818), uint32_t(4));	   // PTX L4385
	r_PtxRegister1820 = uint32_t(r_PtxRegister1819) + uint32_t(r_PtxRegister39);	   // PTX L4386
	r_PtxRegister1821 = uint32_t(r_PtxRegister1816) + uint32_t(r_PtxRegister4);		   // PTX L4387
	r_PtxRegister93 = uint32_t(r_PtxRegister1820) + uint32_t(6);					   // PTX L4388
	r_PtxRegister94 = uint32_t(r_PtxRegister1821) + uint32_t(4);					   // PTX L4389
	r_bPtxPredicate245 = int32_t(r_PtxRegister93) < int32_t(0);						   // PTX L4390
	r_bPtxPredicate246 = int32_t(r_PtxRegister93) >= int32_t(r_Scalar32Bits);		   // PTX L4391
	r_bPtxPredicate247 = int32_t(r_PtxRegister94) >= int32_t(r_Scalar36Bits);		   // PTX L4392
	r_bPtxPredicate248 = r_bPtxPredicate246 | r_bPtxPredicate247;					   // PTX L4393
	r_bPtxPredicate249 = r_bPtxPredicate248 | r_bPtxPredicate245;					   // PTX L4394
	if (r_bPtxPredicate249)
	{
		goto L__BB35_168;
	} // PTX L4395
	r_PtxRegister1822 = r_PtxRegister1811 & -4;										  // PTX L4396
	r_PtxRegister1823 = uint32_t(r_LaneIndexAtPtx4373) - uint32_t(r_PtxRegister1822); // PTX L4397
	r_PtxRegister1824 = ShiftLeft(uint32_t(r_PtxRegister94), uint32_t(2));			  // PTX L4398
	r_PtxRegister1825 =
		uint32_t(r_PtxRegister38) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister93); // PTX L4399
	r_PtxRegister1826 =
		uint32_t(r_PtxRegister1825) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1824); // PTX L4400
	r_PtxRegister1827 = uint32_t(r_PtxRegister1826) + uint32_t(r_PtxRegister1823);			   // PTX L4401
	r_PtxU64Register285 = uint64_t(int64_t(int32_t(r_PtxRegister1827)) * int64_t(int32_t(4))); // PTX L4402
	r_PtxU64Register286 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register285);		   // PTX L4403
	*reinterpret_cast<ushort2*>(r_PtxU64Register286) =
		make_ushort2(r_PtxU16Register51, r_PtxU16Register52);						   // PTX L4404
L__BB35_168:																		   // PTX L4405
	r_LaneIndexAtPtx4407 = uint32_t((threadIdx.x & 31u));							   // PTX L4407
	r_PtxRegister1829 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4407), uint32_t(31)); // PTX L4409
	r_PtxRegister1830 = ShiftRight(uint32_t(r_PtxRegister1829), uint32_t(30));		   // PTX L4410
	r_PtxRegister1831 = uint32_t(r_LaneIndexAtPtx4407) + uint32_t(r_PtxRegister1830);  // PTX L4411
	r_PtxRegister1832 = ShiftRightSigned(int32_t(r_PtxRegister1831), uint32_t(2));	   // PTX L4412
	r_PtxRegister1833 = ShiftRight(uint32_t(r_PtxRegister1832), uint32_t(30));		   // PTX L4413
	r_PtxRegister1834 = uint32_t(r_PtxRegister1832) + uint32_t(r_PtxRegister1833);	   // PTX L4414
	r_PtxRegister1835 = r_PtxRegister1834 & -4;										   // PTX L4415
	r_PtxRegister1836 = uint32_t(r_PtxRegister1832) - uint32_t(r_PtxRegister1835);	   // PTX L4416
	r_PtxRegister1837 = ShiftRight(uint32_t(r_PtxRegister1829), uint32_t(28));		   // PTX L4417
	r_PtxRegister1838 = uint32_t(r_LaneIndexAtPtx4407) + uint32_t(r_PtxRegister1837);  // PTX L4418
	r_PtxRegister1839 = ShiftRightSigned(int32_t(r_PtxRegister1838), uint32_t(4));	   // PTX L4419
	r_PtxRegister1840 = uint32_t(r_PtxRegister1839) + uint32_t(r_PtxRegister39);	   // PTX L4420
	r_PtxRegister1841 = uint32_t(r_PtxRegister1836) + uint32_t(r_PtxRegister4);		   // PTX L4421
	r_PtxRegister95 = uint32_t(r_PtxRegister1840) + uint32_t(4);					   // PTX L4422
	r_PtxRegister96 = uint32_t(r_PtxRegister1841) + uint32_t(4);					   // PTX L4423
	r_bPtxPredicate250 = int32_t(r_PtxRegister95) < int32_t(0);						   // PTX L4424
	r_bPtxPredicate251 = int32_t(r_PtxRegister95) >= int32_t(r_Scalar32Bits);		   // PTX L4425
	r_bPtxPredicate252 = int32_t(r_PtxRegister96) >= int32_t(r_Scalar36Bits);		   // PTX L4426
	r_bPtxPredicate253 = r_bPtxPredicate251 | r_bPtxPredicate252;					   // PTX L4427
	r_bPtxPredicate254 = r_bPtxPredicate253 | r_bPtxPredicate250;					   // PTX L4428
	if (r_bPtxPredicate254)
	{
		goto L__BB35_170;
	} // PTX L4429
	r_PtxRegister1842 = r_PtxRegister1831 & -4;										  // PTX L4430
	r_PtxRegister1843 = uint32_t(r_LaneIndexAtPtx4407) - uint32_t(r_PtxRegister1842); // PTX L4431
	r_PtxRegister1844 = ShiftLeft(uint32_t(r_PtxRegister96), uint32_t(2));			  // PTX L4432
	r_PtxRegister1845 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister95); // PTX L4433
	r_PtxRegister1846 =
		uint32_t(r_PtxRegister1845) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1844); // PTX L4434
	r_PtxRegister1847 = uint32_t(r_PtxRegister1846) + uint32_t(r_PtxRegister1843);			   // PTX L4435
	r_PtxU64Register287 = uint64_t(int64_t(int32_t(r_PtxRegister1847)) * int64_t(int32_t(4))); // PTX L4436
	r_PtxU64Register288 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register287);		   // PTX L4437
	*reinterpret_cast<ushort2*>(r_PtxU64Register288) =
		make_ushort2(r_PtxU16Register53, r_PtxU16Register54);						   // PTX L4438
L__BB35_170:																		   // PTX L4439
	r_LaneIndexAtPtx4441 = uint32_t((threadIdx.x & 31u));							   // PTX L4441
	r_PtxRegister1849 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4441), uint32_t(31)); // PTX L4443
	r_PtxRegister1850 = ShiftRight(uint32_t(r_PtxRegister1849), uint32_t(30));		   // PTX L4444
	r_PtxRegister1851 = uint32_t(r_LaneIndexAtPtx4441) + uint32_t(r_PtxRegister1850);  // PTX L4445
	r_PtxRegister1852 = ShiftRightSigned(int32_t(r_PtxRegister1851), uint32_t(2));	   // PTX L4446
	r_PtxRegister1853 = ShiftRight(uint32_t(r_PtxRegister1852), uint32_t(30));		   // PTX L4447
	r_PtxRegister1854 = uint32_t(r_PtxRegister1852) + uint32_t(r_PtxRegister1853);	   // PTX L4448
	r_PtxRegister1855 = r_PtxRegister1854 & -4;										   // PTX L4449
	r_PtxRegister1856 = uint32_t(r_PtxRegister1852) - uint32_t(r_PtxRegister1855);	   // PTX L4450
	r_PtxRegister1857 = ShiftRight(uint32_t(r_PtxRegister1849), uint32_t(28));		   // PTX L4451
	r_PtxRegister1858 = uint32_t(r_LaneIndexAtPtx4441) + uint32_t(r_PtxRegister1857);  // PTX L4452
	r_PtxRegister1859 = ShiftRightSigned(int32_t(r_PtxRegister1858), uint32_t(4));	   // PTX L4453
	r_PtxRegister1860 = uint32_t(r_PtxRegister1859) + uint32_t(r_PtxRegister39);	   // PTX L4454
	r_PtxRegister1861 = uint32_t(r_PtxRegister1856) + uint32_t(r_PtxRegister4);		   // PTX L4455
	r_PtxRegister97 = uint32_t(r_PtxRegister1860) + uint32_t(6);					   // PTX L4456
	r_PtxRegister98 = uint32_t(r_PtxRegister1861) + uint32_t(4);					   // PTX L4457
	r_bPtxPredicate255 = int32_t(r_PtxRegister97) < int32_t(0);						   // PTX L4458
	r_bPtxPredicate256 = int32_t(r_PtxRegister97) >= int32_t(r_Scalar32Bits);		   // PTX L4459
	r_bPtxPredicate257 = int32_t(r_PtxRegister98) >= int32_t(r_Scalar36Bits);		   // PTX L4460
	r_bPtxPredicate258 = r_bPtxPredicate256 | r_bPtxPredicate257;					   // PTX L4461
	r_bPtxPredicate259 = r_bPtxPredicate258 | r_bPtxPredicate255;					   // PTX L4462
	if (r_bPtxPredicate259)
	{
		goto L__BB35_172;
	} // PTX L4463
	r_PtxRegister1862 = r_PtxRegister1851 & -4;										  // PTX L4464
	r_PtxRegister1863 = uint32_t(r_LaneIndexAtPtx4441) - uint32_t(r_PtxRegister1862); // PTX L4465
	r_PtxRegister1864 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(2));			  // PTX L4466
	r_PtxRegister1865 =
		uint32_t(r_PtxRegister44) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister97); // PTX L4467
	r_PtxRegister1866 =
		uint32_t(r_PtxRegister1865) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1864); // PTX L4468
	r_PtxRegister1867 = uint32_t(r_PtxRegister1866) + uint32_t(r_PtxRegister1863);			   // PTX L4469
	r_PtxU64Register289 = uint64_t(int64_t(int32_t(r_PtxRegister1867)) * int64_t(int32_t(4))); // PTX L4470
	r_PtxU64Register290 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register289);		   // PTX L4471
	*reinterpret_cast<ushort2*>(r_PtxU64Register290) =
		make_ushort2(r_PtxU16Register55, r_PtxU16Register56);						   // PTX L4472
L__BB35_172:																		   // PTX L4473
	r_LaneIndexAtPtx4475 = uint32_t((threadIdx.x & 31u));							   // PTX L4475
	r_PtxRegister1869 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4475), uint32_t(31)); // PTX L4477
	r_PtxRegister1870 = ShiftRight(uint32_t(r_PtxRegister1869), uint32_t(30));		   // PTX L4478
	r_PtxRegister1871 = uint32_t(r_LaneIndexAtPtx4475) + uint32_t(r_PtxRegister1870);  // PTX L4479
	r_PtxRegister1872 = ShiftRightSigned(int32_t(r_PtxRegister1871), uint32_t(2));	   // PTX L4480
	r_PtxRegister1873 = ShiftRight(uint32_t(r_PtxRegister1872), uint32_t(30));		   // PTX L4481
	r_PtxRegister1874 = uint32_t(r_PtxRegister1872) + uint32_t(r_PtxRegister1873);	   // PTX L4482
	r_PtxRegister1875 = r_PtxRegister1874 & -4;										   // PTX L4483
	r_PtxRegister1876 = uint32_t(r_PtxRegister1872) - uint32_t(r_PtxRegister1875);	   // PTX L4484
	r_PtxRegister1877 = ShiftRight(uint32_t(r_PtxRegister1869), uint32_t(28));		   // PTX L4485
	r_PtxRegister1878 = uint32_t(r_LaneIndexAtPtx4475) + uint32_t(r_PtxRegister1877);  // PTX L4486
	r_PtxRegister1879 = ShiftRightSigned(int32_t(r_PtxRegister1878), uint32_t(4));	   // PTX L4487
	r_PtxRegister1880 = uint32_t(r_PtxRegister1879) + uint32_t(r_PtxRegister39);	   // PTX L4488
	r_PtxRegister1881 = uint32_t(r_PtxRegister1876) + uint32_t(r_PtxRegister4);		   // PTX L4489
	r_PtxRegister99 = uint32_t(r_PtxRegister1880) + uint32_t(4);					   // PTX L4490
	r_PtxRegister100 = uint32_t(r_PtxRegister1881) + uint32_t(4);					   // PTX L4491
	r_bPtxPredicate260 = int32_t(r_PtxRegister99) < int32_t(0);						   // PTX L4492
	r_bPtxPredicate261 = int32_t(r_PtxRegister99) >= int32_t(r_Scalar32Bits);		   // PTX L4493
	r_bPtxPredicate262 = int32_t(r_PtxRegister100) >= int32_t(r_Scalar36Bits);		   // PTX L4494
	r_bPtxPredicate263 = r_bPtxPredicate261 | r_bPtxPredicate262;					   // PTX L4495
	r_bPtxPredicate264 = r_bPtxPredicate263 | r_bPtxPredicate260;					   // PTX L4496
	if (r_bPtxPredicate264)
	{
		goto L__BB35_174;
	} // PTX L4497
	r_PtxRegister1882 = r_PtxRegister1871 & -4;										  // PTX L4498
	r_PtxRegister1883 = uint32_t(r_LaneIndexAtPtx4475) - uint32_t(r_PtxRegister1882); // PTX L4499
	r_PtxRegister1884 = ShiftLeft(uint32_t(r_PtxRegister100), uint32_t(2));			  // PTX L4500
	r_PtxRegister1885 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister99); // PTX L4501
	r_PtxRegister1886 =
		uint32_t(r_PtxRegister1885) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1884); // PTX L4502
	r_PtxRegister1887 = uint32_t(r_PtxRegister1886) + uint32_t(r_PtxRegister1883);			   // PTX L4503
	r_PtxU64Register291 = uint64_t(int64_t(int32_t(r_PtxRegister1887)) * int64_t(int32_t(4))); // PTX L4504
	r_PtxU64Register292 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register291);		   // PTX L4505
	*reinterpret_cast<ushort2*>(r_PtxU64Register292) =
		make_ushort2(r_PtxU16Register57, r_PtxU16Register58);						   // PTX L4506
L__BB35_174:																		   // PTX L4507
	r_LaneIndexAtPtx4509 = uint32_t((threadIdx.x & 31u));							   // PTX L4509
	r_PtxRegister1889 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4509), uint32_t(31)); // PTX L4511
	r_PtxRegister1890 = ShiftRight(uint32_t(r_PtxRegister1889), uint32_t(30));		   // PTX L4512
	r_PtxRegister1891 = uint32_t(r_LaneIndexAtPtx4509) + uint32_t(r_PtxRegister1890);  // PTX L4513
	r_PtxRegister1892 = ShiftRightSigned(int32_t(r_PtxRegister1891), uint32_t(2));	   // PTX L4514
	r_PtxRegister1893 = ShiftRight(uint32_t(r_PtxRegister1892), uint32_t(30));		   // PTX L4515
	r_PtxRegister1894 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister1893);	   // PTX L4516
	r_PtxRegister1895 = r_PtxRegister1894 & -4;										   // PTX L4517
	r_PtxRegister1896 = uint32_t(r_PtxRegister1892) - uint32_t(r_PtxRegister1895);	   // PTX L4518
	r_PtxRegister1897 = ShiftRight(uint32_t(r_PtxRegister1889), uint32_t(28));		   // PTX L4519
	r_PtxRegister1898 = uint32_t(r_LaneIndexAtPtx4509) + uint32_t(r_PtxRegister1897);  // PTX L4520
	r_PtxRegister1899 = ShiftRightSigned(int32_t(r_PtxRegister1898), uint32_t(4));	   // PTX L4521
	r_PtxRegister1900 = uint32_t(r_PtxRegister1899) + uint32_t(r_PtxRegister39);	   // PTX L4522
	r_PtxRegister1901 = uint32_t(r_PtxRegister1896) + uint32_t(r_PtxRegister4);		   // PTX L4523
	r_PtxRegister101 = uint32_t(r_PtxRegister1900) + uint32_t(6);					   // PTX L4524
	r_PtxRegister102 = uint32_t(r_PtxRegister1901) + uint32_t(4);					   // PTX L4525
	r_bPtxPredicate265 = int32_t(r_PtxRegister101) < int32_t(0);					   // PTX L4526
	r_bPtxPredicate266 = int32_t(r_PtxRegister101) >= int32_t(r_Scalar32Bits);		   // PTX L4527
	r_bPtxPredicate267 = int32_t(r_PtxRegister102) >= int32_t(r_Scalar36Bits);		   // PTX L4528
	r_bPtxPredicate268 = r_bPtxPredicate266 | r_bPtxPredicate267;					   // PTX L4529
	r_bPtxPredicate269 = r_bPtxPredicate268 | r_bPtxPredicate265;					   // PTX L4530
	if (r_bPtxPredicate269)
	{
		goto L__BB35_176;
	} // PTX L4531
	r_PtxRegister1902 = r_PtxRegister1891 & -4;										  // PTX L4532
	r_PtxRegister1903 = uint32_t(r_LaneIndexAtPtx4509) - uint32_t(r_PtxRegister1902); // PTX L4533
	r_PtxRegister1904 = ShiftLeft(uint32_t(r_PtxRegister102), uint32_t(2));			  // PTX L4534
	r_PtxRegister1905 =
		uint32_t(r_PtxRegister49) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister101); // PTX L4535
	r_PtxRegister1906 =
		uint32_t(r_PtxRegister1905) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1904); // PTX L4536
	r_PtxRegister1907 = uint32_t(r_PtxRegister1906) + uint32_t(r_PtxRegister1903);			   // PTX L4537
	r_PtxU64Register293 = uint64_t(int64_t(int32_t(r_PtxRegister1907)) * int64_t(int32_t(4))); // PTX L4538
	r_PtxU64Register294 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register293);		   // PTX L4539
	*reinterpret_cast<ushort2*>(r_PtxU64Register294) =
		make_ushort2(r_PtxU16Register59, r_PtxU16Register60);						   // PTX L4540
L__BB35_176:																		   // PTX L4541
	r_LaneIndexAtPtx4543 = uint32_t((threadIdx.x & 31u));							   // PTX L4543
	r_PtxRegister1909 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4543), uint32_t(31)); // PTX L4545
	r_PtxRegister1910 = ShiftRight(uint32_t(r_PtxRegister1909), uint32_t(30));		   // PTX L4546
	r_PtxRegister1911 = uint32_t(r_LaneIndexAtPtx4543) + uint32_t(r_PtxRegister1910);  // PTX L4547
	r_PtxRegister1912 = ShiftRightSigned(int32_t(r_PtxRegister1911), uint32_t(2));	   // PTX L4548
	r_PtxRegister1913 = ShiftRight(uint32_t(r_PtxRegister1912), uint32_t(30));		   // PTX L4549
	r_PtxRegister1914 = uint32_t(r_PtxRegister1912) + uint32_t(r_PtxRegister1913);	   // PTX L4550
	r_PtxRegister1915 = r_PtxRegister1914 & -4;										   // PTX L4551
	r_PtxRegister1916 = uint32_t(r_PtxRegister1912) - uint32_t(r_PtxRegister1915);	   // PTX L4552
	r_PtxRegister1917 = ShiftRight(uint32_t(r_PtxRegister1909), uint32_t(28));		   // PTX L4553
	r_PtxRegister1918 = uint32_t(r_LaneIndexAtPtx4543) + uint32_t(r_PtxRegister1917);  // PTX L4554
	r_PtxRegister1919 = ShiftRightSigned(int32_t(r_PtxRegister1918), uint32_t(4));	   // PTX L4555
	r_PtxRegister1920 = uint32_t(r_PtxRegister1919) + uint32_t(r_PtxRegister39);	   // PTX L4556
	r_PtxRegister1921 = uint32_t(r_PtxRegister1916) + uint32_t(r_PtxRegister4);		   // PTX L4557
	r_PtxRegister103 = uint32_t(r_PtxRegister1920) + uint32_t(4);					   // PTX L4558
	r_PtxRegister104 = uint32_t(r_PtxRegister1921) + uint32_t(4);					   // PTX L4559
	r_bPtxPredicate270 = int32_t(r_PtxRegister103) < int32_t(0);					   // PTX L4560
	r_bPtxPredicate271 = int32_t(r_PtxRegister103) >= int32_t(r_Scalar32Bits);		   // PTX L4561
	r_bPtxPredicate272 = int32_t(r_PtxRegister104) >= int32_t(r_Scalar36Bits);		   // PTX L4562
	r_bPtxPredicate273 = r_bPtxPredicate271 | r_bPtxPredicate272;					   // PTX L4563
	r_bPtxPredicate274 = r_bPtxPredicate273 | r_bPtxPredicate270;					   // PTX L4564
	if (r_bPtxPredicate274)
	{
		goto L__BB35_178;
	} // PTX L4565
	r_PtxRegister1922 = r_PtxRegister1911 & -4;										  // PTX L4566
	r_PtxRegister1923 = uint32_t(r_LaneIndexAtPtx4543) - uint32_t(r_PtxRegister1922); // PTX L4567
	r_PtxRegister1924 = ShiftLeft(uint32_t(r_PtxRegister104), uint32_t(2));			  // PTX L4568
	r_PtxRegister1925 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister103); // PTX L4569
	r_PtxRegister1926 =
		uint32_t(r_PtxRegister1925) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1924); // PTX L4570
	r_PtxRegister1927 = uint32_t(r_PtxRegister1926) + uint32_t(r_PtxRegister1923);			   // PTX L4571
	r_PtxU64Register295 = uint64_t(int64_t(int32_t(r_PtxRegister1927)) * int64_t(int32_t(4))); // PTX L4572
	r_PtxU64Register296 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register295);		   // PTX L4573
	*reinterpret_cast<ushort2*>(r_PtxU64Register296) =
		make_ushort2(r_PtxU16Register61, r_PtxU16Register62);						   // PTX L4574
L__BB35_178:																		   // PTX L4575
	r_LaneIndexAtPtx4577 = uint32_t((threadIdx.x & 31u));							   // PTX L4577
	r_PtxRegister1929 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4577), uint32_t(31)); // PTX L4579
	r_PtxRegister1930 = ShiftRight(uint32_t(r_PtxRegister1929), uint32_t(30));		   // PTX L4580
	r_PtxRegister1931 = uint32_t(r_LaneIndexAtPtx4577) + uint32_t(r_PtxRegister1930);  // PTX L4581
	r_PtxRegister1932 = ShiftRightSigned(int32_t(r_PtxRegister1931), uint32_t(2));	   // PTX L4582
	r_PtxRegister1933 = ShiftRight(uint32_t(r_PtxRegister1932), uint32_t(30));		   // PTX L4583
	r_PtxRegister1934 = uint32_t(r_PtxRegister1932) + uint32_t(r_PtxRegister1933);	   // PTX L4584
	r_PtxRegister1935 = r_PtxRegister1934 & -4;										   // PTX L4585
	r_PtxRegister1936 = uint32_t(r_PtxRegister1932) - uint32_t(r_PtxRegister1935);	   // PTX L4586
	r_PtxRegister1937 = ShiftRight(uint32_t(r_PtxRegister1929), uint32_t(28));		   // PTX L4587
	r_PtxRegister1938 = uint32_t(r_LaneIndexAtPtx4577) + uint32_t(r_PtxRegister1937);  // PTX L4588
	r_PtxRegister1939 = ShiftRightSigned(int32_t(r_PtxRegister1938), uint32_t(4));	   // PTX L4589
	r_PtxRegister1940 = uint32_t(r_PtxRegister1939) + uint32_t(r_PtxRegister39);	   // PTX L4590
	r_PtxRegister1941 = uint32_t(r_PtxRegister1936) + uint32_t(r_PtxRegister4);		   // PTX L4591
	r_PtxRegister105 = uint32_t(r_PtxRegister1940) + uint32_t(6);					   // PTX L4592
	r_PtxRegister106 = uint32_t(r_PtxRegister1941) + uint32_t(4);					   // PTX L4593
	r_bPtxPredicate275 = int32_t(r_PtxRegister105) < int32_t(0);					   // PTX L4594
	r_bPtxPredicate276 = int32_t(r_PtxRegister105) >= int32_t(r_Scalar32Bits);		   // PTX L4595
	r_bPtxPredicate277 = int32_t(r_PtxRegister106) >= int32_t(r_Scalar36Bits);		   // PTX L4596
	r_bPtxPredicate278 = r_bPtxPredicate276 | r_bPtxPredicate277;					   // PTX L4597
	r_bPtxPredicate279 = r_bPtxPredicate278 | r_bPtxPredicate275;					   // PTX L4598
	if (r_bPtxPredicate279)
	{
		goto L__BB35_180;
	} // PTX L4599
	r_PtxRegister1942 = r_PtxRegister1931 & -4;										  // PTX L4600
	r_PtxRegister1943 = uint32_t(r_LaneIndexAtPtx4577) - uint32_t(r_PtxRegister1942); // PTX L4601
	r_PtxRegister1944 = ShiftLeft(uint32_t(r_PtxRegister106), uint32_t(2));			  // PTX L4602
	r_PtxRegister1945 =
		uint32_t(r_PtxRegister54) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister105); // PTX L4603
	r_PtxRegister1946 =
		uint32_t(r_PtxRegister1945) * uint32_t(r_PtxRegister37) + uint32_t(r_PtxRegister1944); // PTX L4604
	r_PtxRegister1947 = uint32_t(r_PtxRegister1946) + uint32_t(r_PtxRegister1943);			   // PTX L4605
	r_PtxU64Register297 = uint64_t(int64_t(int32_t(r_PtxRegister1947)) * int64_t(int32_t(4))); // PTX L4606
	r_PtxU64Register298 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register297);		   // PTX L4607
	*reinterpret_cast<ushort2*>(r_PtxU64Register298) =
		make_ushort2(r_PtxU16Register63, r_PtxU16Register64); // PTX L4608
L__BB35_180:												  // PTX L4609
	return;													  // PTX L4610
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp8
