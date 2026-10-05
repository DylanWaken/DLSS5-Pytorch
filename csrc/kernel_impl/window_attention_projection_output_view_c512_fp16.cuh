// Readable equivalent of cc_split_swin_16h_proj_512_outview; not historical source.
#pragma once
#include "window_attention_projection_output_view_c512_abi_fp16.cuh"

namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16
{
__global__ __maxnreg__(128) void window_attention_projection_output_view_c512_fp16(Parameters r_Parameters)
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
		r_bPtxPredicate282, r_bPtxPredicate283, r_bPtxPredicate284, r_bPtxPredicate285, r_bPtxPredicate286,
		r_bPtxPredicate287, r_bPtxPredicate288;
	bool r_bPtxPredicate289, r_bPtxPredicate290, r_bPtxPredicate291, r_bPtxPredicate292, r_bPtxPredicate293,
		r_bPtxPredicate294, r_bPtxPredicate295, r_bPtxPredicate296, r_bPtxPredicate297, r_bPtxPredicate298,
		r_bPtxPredicate299, r_bPtxPredicate300;
	bool r_bPtxPredicate301, r_bPtxPredicate302, r_bPtxPredicate303, r_bPtxPredicate304, r_bPtxPredicate305,
		r_bPtxPredicate306, r_bPtxPredicate307, r_bPtxPredicate308, r_bPtxPredicate309, r_bPtxPredicate310,
		r_bPtxPredicate311, r_bPtxPredicate312;
	bool r_bPtxPredicate313, r_bPtxPredicate314, r_bPtxPredicate315, r_bPtxPredicate316, r_bPtxPredicate317,
		r_bPtxPredicate318, r_bPtxPredicate319, r_bPtxPredicate320, r_bPtxPredicate321, r_bPtxPredicate322,
		r_bPtxPredicate323, r_bPtxPredicate324;
	bool r_bPtxPredicate325, r_bPtxPredicate326, r_bPtxPredicate327, r_bPtxPredicate328, r_bPtxPredicate329,
		r_bPtxPredicate330, r_bPtxPredicate331, r_bPtxPredicate332, r_bPtxPredicate333, r_bPtxPredicate334,
		r_bPtxPredicate335, r_bPtxPredicate336;
	bool r_bPtxPredicate337, r_bPtxPredicate338, r_bPtxPredicate339, r_bPtxPredicate340, r_bPtxPredicate341,
		r_bPtxPredicate342, r_bPtxPredicate343, r_bPtxPredicate344, r_bPtxPredicate345, r_bPtxPredicate346,
		r_bPtxPredicate347, r_bPtxPredicate348;
	bool r_bPtxPredicate349, r_bPtxPredicate350, r_bPtxPredicate351, r_bPtxPredicate352, r_bPtxPredicate353,
		r_bPtxPredicate354, r_bPtxPredicate355, r_bPtxPredicate356, r_bPtxPredicate357, r_bPtxPredicate358,
		r_bPtxPredicate359, r_bPtxPredicate360;
	bool r_bPtxPredicate361, r_bPtxPredicate362, r_bPtxPredicate363, r_bPtxPredicate364, r_bPtxPredicate365,
		r_bPtxPredicate366, r_bPtxPredicate367, r_bPtxPredicate368, r_bPtxPredicate369, r_bPtxPredicate370,
		r_bPtxPredicate371, r_bPtxPredicate372;
	bool r_bPtxPredicate373, r_bPtxPredicate374, r_bPtxPredicate375, r_bPtxPredicate376, r_bPtxPredicate377,
		r_bPtxPredicate378, r_bPtxPredicate379, r_bPtxPredicate380, r_bPtxPredicate381, r_bPtxPredicate382,
		r_bPtxPredicate383, r_bPtxPredicate384;
	bool r_bPtxPredicate385, r_bPtxPredicate386, r_bPtxPredicate387, r_bPtxPredicate388, r_bPtxPredicate389,
		r_bPtxPredicate390, r_bPtxPredicate391, r_bPtxPredicate392, r_bPtxPredicate393, r_bPtxPredicate394,
		r_bPtxPredicate395, r_bPtxPredicate396;
	bool r_bPtxPredicate397, r_bPtxPredicate398, r_bPtxPredicate399, r_bPtxPredicate400, r_bPtxPredicate401,
		r_bPtxPredicate402, r_bPtxPredicate403, r_bPtxPredicate404, r_bPtxPredicate405, r_bPtxPredicate406,
		r_bPtxPredicate407, r_bPtxPredicate408;
	bool r_bPtxPredicate409, r_bPtxPredicate410, r_bPtxPredicate411, r_bPtxPredicate412, r_bPtxPredicate413,
		r_bPtxPredicate414, r_bPtxPredicate415, r_bPtxPredicate416, r_bPtxPredicate417, r_bPtxPredicate418,
		r_bPtxPredicate419, r_bPtxPredicate420;
	bool r_bPtxPredicate421, r_bPtxPredicate422, r_bPtxPredicate423, r_bPtxPredicate424, r_bPtxPredicate425,
		r_bPtxPredicate426, r_bPtxPredicate427, r_bPtxPredicate428, r_bPtxPredicate429, r_bPtxPredicate430,
		r_bPtxPredicate431, r_bPtxPredicate432;
	bool r_bPtxPredicate433, r_bPtxPredicate434, r_bPtxPredicate435, r_bPtxPredicate436, r_bPtxPredicate437,
		r_bPtxPredicate438, r_bPtxPredicate439, r_bPtxPredicate440, r_bPtxPredicate441, r_bPtxPredicate442,
		r_bPtxPredicate443, r_bPtxPredicate444;
	bool r_bPtxPredicate445, r_bPtxPredicate446, r_bPtxPredicate447, r_bPtxPredicate448, r_bPtxPredicate449,
		r_bPtxPredicate450, r_bPtxPredicate451, r_bPtxPredicate452, r_bPtxPredicate453, r_bPtxPredicate454,
		r_bPtxPredicate455, r_bPtxPredicate456;
	bool r_bPtxPredicate457, r_bPtxPredicate458, r_bPtxPredicate459, r_bPtxPredicate460, r_bPtxPredicate461,
		r_bPtxPredicate462, r_bPtxPredicate463, r_bPtxPredicate464, r_bPtxPredicate465, r_bPtxPredicate466,
		r_bPtxPredicate467, r_bPtxPredicate468;
	bool r_bPtxPredicate469, r_bPtxPredicate470, r_bPtxPredicate471, r_bPtxPredicate472, r_bPtxPredicate473,
		r_bPtxPredicate474, r_bPtxPredicate475, r_bPtxPredicate476, r_bPtxPredicate477, r_bPtxPredicate478,
		r_bPtxPredicate479, r_bPtxPredicate480;
	bool r_bPtxPredicate481;
	uint16_t r_PtxU16Register1, r_PtxU16Register2, r_PtxU16Register3, r_PtxU16Register4, r_PtxU16Register5,
		r_PtxU16Register6, r_PtxU16Register7, r_PtxU16Register8, r_PtxU16Register9, r_PtxU16Register10,
		r_PtxU16Register11, r_PtxU16Register12;
	uint32_t r_CtaZAtPtx21, r_PtxRegister2, r_PtxRegister3, r_PtxRegister4, r_PtxRegister5, r_PtxRegister6,
		r_PtxRegister7, r_ThreadYAtPtx43, r_PtxRegister9, r_PtxRegister10, r_PtxRegister11, r_PtxRegister12;
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
		r_PtxRegister107, r_PtxRegister108;
	uint32_t r_PtxRegister109, r_PtxRegister110, r_PtxRegister111, r_PtxRegister112, r_PtxRegister113,
		r_PtxRegister114, r_PtxRegister115, r_PtxRegister116, r_PtxRegister117, r_PtxRegister118,
		r_PtxRegister119, r_PtxRegister120;
	uint32_t r_PtxRegister121, r_PtxRegister122, r_PtxRegister123, r_PtxRegister124, r_PtxRegister125,
		r_PtxRegister126, r_PtxRegister127, r_PtxRegister128, r_PtxRegister129, r_PtxRegister130,
		r_PtxRegister131, r_PtxRegister132;
	uint32_t r_PtxRegister133, r_PtxRegister134, r_PtxRegister135, r_PtxRegister136, r_PtxRegister137,
		r_PtxRegister138, r_PtxRegister139, r_PtxRegister140, r_PtxRegister141, r_PtxRegister142,
		r_PtxRegister143, r_PtxRegister144;
	uint32_t r_PtxRegister145, r_PtxRegister146, r_PtxRegister147, r_PtxRegister148, r_PtxRegister149,
		r_PtxRegister150, r_PtxRegister151, r_PtxRegister152, r_PtxRegister153, r_PtxRegister154,
		r_PtxRegister155, r_PtxRegister156;
	uint32_t r_PtxRegister157, r_PtxRegister158, r_PtxRegister159, r_PtxRegister160, r_PtxRegister161,
		r_PtxRegister162, r_PtxRegister163, r_PtxRegister164, r_PtxRegister165, r_PtxRegister166,
		r_PtxRegister167, r_PtxRegister168;
	uint32_t r_PtxRegister169, r_PtxRegister170, r_PtxRegister171, r_PtxRegister172, r_PtxRegister173,
		r_PtxRegister174, r_PtxRegister175, r_PtxRegister176, r_Scalar32Bits, r_Scalar36Bits, r_CtaX, r_CtaY;
	uint32_t r_PtxRegister181, r_PtxRegister182, r_PtxRegister183, r_PtxRegister184, r_PtxRegister185,
		r_PtxRegister186, r_PtxRegister187, r_PtxRegister188, r_PtxRegister189, r_PtxRegister190,
		r_PtxRegister191, r_PtxRegister192;
	uint32_t r_PtxRegister193, r_PtxRegister194, r_ThreadX, r_PtxRegister196, r_PtxRegister197,
		r_PtxRegister198, r_PtxRegister199, r_PtxRegister200, r_BlockSizeX, r_BlockSizeY,
		r_Float32BitsAtPtx64R203, r_LaneIndexAtPtx80;
	uint32_t r_LaneIndexAtPtx89, r_LaneIndexAtPtx99, r_LaneIndexAtPtx109, r_LaneIndexAtPtx118,
		r_LaneIndexAtPtx127, r_LaneIndexAtPtx136, r_LaneIndexAtPtx145, r_PtxRegister212, r_PtxRegister213,
		r_PtxRegister214, r_PtxRegister215, r_PtxRegister216;
	uint32_t r_PtxRegister217, r_PtxRegister218, r_PtxRegister219, r_PtxRegister220, r_PtxRegister221,
		r_PtxRegister222, r_PtxRegister223, r_PtxRegister224, r_PtxRegister225, r_PtxRegister226,
		r_PtxRegister227, r_PtxRegister228;
	uint32_t r_PtxRegister229, r_PtxRegister230, r_PtxRegister231, r_LaneIndexAtPtx223, r_PtxRegister233,
		r_PtxRegister234, r_PtxRegister235, r_PtxRegister236, r_PtxRegister237, r_PtxRegister238,
		r_PtxRegister239, r_PtxRegister240;
	uint32_t r_PtxRegister241, r_PtxRegister242, r_PtxRegister243, r_PtxRegister244, r_PtxRegister245,
		r_PtxRegister246, r_PtxRegister247, r_PtxRegister248, r_PtxRegister249, r_PtxRegister250,
		r_PtxRegister251, r_LaneIndexAtPtx294;
	uint32_t r_PtxRegister253, r_PtxRegister254, r_PtxRegister255, r_PtxRegister256, r_PtxRegister257,
		r_PtxRegister258, r_PtxRegister259, r_PtxRegister260, r_PtxRegister261, r_PtxRegister262,
		r_PtxRegister263, r_PtxRegister264;
	uint32_t r_PtxRegister265, r_PtxRegister266, r_LaneIndexAtPtx356, r_PtxRegister268, r_PtxRegister269,
		r_PtxRegister270, r_PtxRegister271, r_PtxRegister272, r_PtxRegister273, r_PtxRegister274,
		r_PtxRegister275, r_PtxRegister276;
	uint32_t r_PtxRegister277, r_PtxRegister278, r_PtxRegister279, r_PtxRegister280, r_PtxRegister281,
		r_PtxRegister282, r_PtxRegister283, r_LaneIndexAtPtx417, r_PtxRegister285, r_PtxRegister286,
		r_PtxRegister287, r_PtxRegister288;
	uint32_t r_PtxRegister289, r_PtxRegister290, r_PtxRegister291, r_PtxRegister292, r_PtxRegister293,
		r_PtxRegister294, r_PtxRegister295, r_PtxRegister296, r_PtxRegister297, r_PtxRegister298,
		r_PtxRegister299, r_PtxRegister300;
	uint32_t r_LaneIndexAtPtx479, r_PtxRegister302, r_PtxRegister303, r_PtxRegister304, r_PtxRegister305,
		r_PtxRegister306, r_PtxRegister307, r_PtxRegister308, r_PtxRegister309, r_PtxRegister310,
		r_PtxRegister311, r_PtxRegister312;
	uint32_t r_PtxRegister313, r_PtxRegister314, r_PtxRegister315, r_PtxRegister316, r_PtxRegister317,
		r_LaneIndexAtPtx540, r_PtxRegister319, r_PackedHalf2AtPtx66R320, r_PtxRegister321, r_PtxRegister322,
		r_PtxRegister323, r_PtxRegister324;
	uint32_t r_PtxRegister325, r_PtxRegister326, r_PtxRegister327, r_PtxRegister328, r_PtxRegister329,
		r_PtxRegister330, r_PtxRegister331, r_PtxRegister332, r_LaneIndexAtPtx594, r_PtxRegister334,
		r_PtxRegister335, r_PtxRegister336;
	uint32_t r_LaneIndexAtPtx613, r_PtxRegister338, r_PtxRegister339, r_PtxRegister340, r_LaneIndexAtPtx632,
		r_PtxRegister342, r_PtxRegister343, r_PtxRegister344, r_LaneIndexAtPtx651, r_PtxRegister346,
		r_PtxRegister347, r_PtxRegister348;
	uint32_t r_LaneIndexAtPtx676, r_PtxRegister350, r_PtxRegister351, r_PtxRegister352, r_LaneIndexAtPtx695,
		r_PtxRegister354, r_PtxRegister355, r_PtxRegister356, r_LaneIndexAtPtx714, r_PtxRegister358,
		r_PtxRegister359, r_PtxRegister360;
	uint32_t r_LaneIndexAtPtx733, r_PtxRegister362, r_PtxRegister363, r_PtxRegister364, r_PtxRegister365,
		r_PtxRegister366, r_LaneIndexAtPtx769, r_PtxRegister368, r_PtxRegister369, r_PtxRegister370,
		r_LaneIndexAtPtx788, r_PtxRegister372;
	uint32_t r_PtxRegister373, r_PtxRegister374, r_LaneIndexAtPtx807, r_PtxRegister376, r_PtxRegister377,
		r_PtxRegister378, r_LaneIndexAtPtx826, r_PtxRegister380, r_PtxRegister381, r_PtxRegister382,
		r_LaneIndexAtPtx850, r_PtxRegister384;
	uint32_t r_PtxRegister385, r_PtxRegister386, r_LaneIndexAtPtx869, r_PtxRegister388, r_PtxRegister389,
		r_PtxRegister390, r_LaneIndexAtPtx888, r_PtxRegister392, r_PtxRegister393, r_PtxRegister394,
		r_LaneIndexAtPtx907, r_PtxRegister396;
	uint32_t r_PtxRegister397, r_PtxRegister398, r_LaneIndexAtPtx919, r_LaneIndexAtPtx933,
		r_LaneIndexAtPtx947, r_LaneIndexAtPtx961, r_LaneIndexAtPtx975, r_LaneIndexAtPtx989,
		r_LaneIndexAtPtx1003, r_LaneIndexAtPtx1018, r_LaneIndexAtPtx1032, r_LaneIndexAtPtx1047;
	uint32_t r_LaneIndexAtPtx1061, r_LaneIndexAtPtx1076, r_LaneIndexAtPtx1090, r_LaneIndexAtPtx1105,
		r_LaneIndexAtPtx1119, r_LaneIndexAtPtx1134, r_LaneIndexAtPtx1148, r_LaneIndexAtPtx1162,
		r_LaneIndexAtPtx1176, r_LaneIndexAtPtx1190, r_LaneIndexAtPtx1204, r_LaneIndexAtPtx1218;
	uint32_t r_LaneIndexAtPtx1232, r_LaneIndexAtPtx1246, r_LaneIndexAtPtx1260, r_LaneIndexAtPtx1274,
		r_LaneIndexAtPtx1288, r_LaneIndexAtPtx1302, r_LaneIndexAtPtx1316, r_LaneIndexAtPtx1330,
		r_LaneIndexAtPtx1344, r_LaneIndexAtPtx1358, r_LaneIndexAtPtx1372, r_LaneIndexAtPtx1386;
	uint32_t r_LaneIndexAtPtx1400, r_LaneIndexAtPtx1414, r_LaneIndexAtPtx1428, r_LaneIndexAtPtx1442,
		r_LaneIndexAtPtx1456, r_LaneIndexAtPtx1470, r_LaneIndexAtPtx1484, r_LaneIndexAtPtx1498,
		r_LaneIndexAtPtx1512, r_LaneIndexAtPtx1526, r_LaneIndexAtPtx1540, r_LaneIndexAtPtx1554;
	uint32_t r_LaneIndexAtPtx1568, r_LaneIndexAtPtx1582, r_LaneIndexAtPtx1596, r_LaneIndexAtPtx1610,
		r_LaneIndexAtPtx1624, r_LaneIndexAtPtx1638, r_LaneIndexAtPtx1652, r_LaneIndexAtPtx1666,
		r_LaneIndexAtPtx1680, r_LaneIndexAtPtx1694, r_LaneIndexAtPtx1708, r_LaneIndexAtPtx1722;
	uint32_t r_LaneIndexAtPtx1736, r_LaneIndexAtPtx1750, r_LaneIndexAtPtx1764, r_LaneIndexAtPtx1778,
		r_LaneIndexAtPtx1792, r_LaneIndexAtPtx1806, r_LaneIndexAtPtx1820, r_PtxRegister464,
		r_LaneIndexAtPtx1827, r_PtxRegister466, r_LaneIndexAtPtx1834, r_PtxRegister468;
	uint32_t r_LaneIndexAtPtx1841, r_PtxRegister470, r_LaneIndexAtPtx1848, r_PtxRegister472,
		r_LaneIndexAtPtx1855, r_PtxRegister474, r_LaneIndexAtPtx1862, r_PtxRegister476, r_LaneIndexAtPtx1869,
		r_PtxRegister478, r_LaneIndexAtPtx1876, r_PtxRegister480;
	uint32_t r_LaneIndexAtPtx1883, r_PtxRegister482, r_LaneIndexAtPtx1890, r_PtxRegister484,
		r_LaneIndexAtPtx1897, r_PtxRegister486, r_LaneIndexAtPtx1904, r_PtxRegister488, r_LaneIndexAtPtx1911,
		r_PtxRegister490, r_LaneIndexAtPtx1918, r_PtxRegister492;
	uint32_t r_LaneIndexAtPtx1925, r_PtxRegister494, r_LaneIndexAtPtx1932, r_PtxRegister496,
		r_LaneIndexAtPtx1939, r_PtxRegister498, r_LaneIndexAtPtx1946, r_PtxRegister500, r_LaneIndexAtPtx1953,
		r_PtxRegister502, r_LaneIndexAtPtx1960, r_PtxRegister504;
	uint32_t r_LaneIndexAtPtx1967, r_PtxRegister506, r_LaneIndexAtPtx1974, r_PtxRegister508,
		r_LaneIndexAtPtx1981, r_PtxRegister510, r_LaneIndexAtPtx1988, r_PtxRegister512, r_LaneIndexAtPtx1995,
		r_PtxRegister514, r_LaneIndexAtPtx2002, r_PtxRegister516;
	uint32_t r_LaneIndexAtPtx2009, r_PtxRegister518, r_LaneIndexAtPtx2016, r_PtxRegister520,
		r_LaneIndexAtPtx2023, r_PtxRegister522, r_LaneIndexAtPtx2030, r_PtxRegister524, r_LaneIndexAtPtx2037,
		r_PtxRegister526, r_LaneIndexAtPtx2044, r_PtxRegister528;
	uint32_t r_LaneIndexAtPtx2051, r_PtxRegister530, r_LaneIndexAtPtx2058, r_PtxRegister532,
		r_LaneIndexAtPtx2065, r_PtxRegister534, r_LaneIndexAtPtx2072, r_PtxRegister536, r_LaneIndexAtPtx2079,
		r_PtxRegister538, r_LaneIndexAtPtx2086, r_PtxRegister540;
	uint32_t r_LaneIndexAtPtx2093, r_PtxRegister542, r_LaneIndexAtPtx2100, r_PtxRegister544,
		r_LaneIndexAtPtx2107, r_PtxRegister546, r_LaneIndexAtPtx2114, r_PtxRegister548, r_LaneIndexAtPtx2121,
		r_PtxRegister550, r_LaneIndexAtPtx2128, r_PtxRegister552;
	uint32_t r_LaneIndexAtPtx2135, r_PtxRegister554, r_LaneIndexAtPtx2142, r_PtxRegister556,
		r_LaneIndexAtPtx2149, r_PtxRegister558, r_LaneIndexAtPtx2156, r_PtxRegister560, r_LaneIndexAtPtx2163,
		r_PtxRegister562, r_LaneIndexAtPtx2170, r_PtxRegister564;
	uint32_t r_LaneIndexAtPtx2177, r_PtxRegister566, r_LaneIndexAtPtx2184, r_PtxRegister568,
		r_LaneIndexAtPtx2191, r_PtxRegister570, r_LaneIndexAtPtx2198, r_PtxRegister572, r_LaneIndexAtPtx2205,
		r_PtxRegister574, r_LaneIndexAtPtx2212, r_PtxRegister576;
	uint32_t r_LaneIndexAtPtx2219, r_PtxRegister578, r_LaneIndexAtPtx2226, r_PtxRegister580,
		r_LaneIndexAtPtx2233, r_PtxRegister582, r_LaneIndexAtPtx2240, r_PtxRegister584, r_LaneIndexAtPtx2247,
		r_PtxRegister586, r_LaneIndexAtPtx2254, r_PtxRegister588;
	uint32_t r_LaneIndexAtPtx2261, r_PtxRegister590, r_PtxRegister591, r_PtxRegister592, r_PtxRegister593,
		r_PtxRegister594, r_PtxRegister595, r_PtxRegister596, r_PtxRegister597, r_PtxRegister598,
		r_PtxRegister599, r_PtxRegister600;
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
		r_LaneIndexAtPtx2280, r_PtxRegister1111, r_LaneIndexAtPtx2290, r_PtxRegister1113,
		r_LaneIndexAtPtx2299, r_PtxRegister1115, r_LaneIndexAtPtx2308;
	uint32_t r_PtxRegister1117, r_LaneIndexAtPtx2317, r_PtxRegister1119, r_LaneIndexAtPtx2326,
		r_PtxRegister1121, r_LaneIndexAtPtx2335, r_PtxRegister1123, r_LaneIndexAtPtx2344, r_PtxRegister1125,
		r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128;
	uint32_t r_MmaAHalf2WordAtPtx2287R1129, r_MmaAHalf2WordAtPtx2296R1130, r_MmaAHalf2WordAtPtx2296R1131,
		r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133, r_MmaAccumulatorHalf2WordAtPtx2353R1134,
		r_MmaAccumulatorHalf2WordAtPtx2353R1135, r_MmaAccumulatorHalf2WordAtPtx2360R1136,
		r_MmaAccumulatorHalf2WordAtPtx2360R1137, r_MmaAccumulatorHalf2WordAtPtx2381R1138,
		r_MmaAccumulatorHalf2WordAtPtx2381R1139, r_MmaAccumulatorHalf2WordAtPtx2388R1140;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2388R1141, r_MmaAccumulatorHalf2WordAtPtx2409R1142,
		r_MmaAccumulatorHalf2WordAtPtx2409R1143, r_MmaAccumulatorHalf2WordAtPtx2416R1144,
		r_MmaAccumulatorHalf2WordAtPtx2416R1145, r_MmaAccumulatorHalf2WordAtPtx2437R1146,
		r_MmaAccumulatorHalf2WordAtPtx2437R1147, r_MmaAccumulatorHalf2WordAtPtx2444R1148,
		r_MmaAccumulatorHalf2WordAtPtx2444R1149, r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151,
		r_MmaAHalf2WordAtPtx2305R1152;
	uint32_t r_MmaAHalf2WordAtPtx2305R1153, r_MmaAHalf2WordAtPtx2314R1154, r_MmaAHalf2WordAtPtx2314R1155,
		r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157, r_MmaAccumulatorHalf2WordAtPtx2465R1158,
		r_MmaAccumulatorHalf2WordAtPtx2465R1159, r_MmaAccumulatorHalf2WordAtPtx2472R1160,
		r_MmaAccumulatorHalf2WordAtPtx2472R1161, r_MmaAccumulatorHalf2WordAtPtx2493R1162,
		r_MmaAccumulatorHalf2WordAtPtx2493R1163, r_MmaAccumulatorHalf2WordAtPtx2500R1164;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2500R1165, r_MmaAccumulatorHalf2WordAtPtx2521R1166,
		r_MmaAccumulatorHalf2WordAtPtx2521R1167, r_MmaAccumulatorHalf2WordAtPtx2528R1168,
		r_MmaAccumulatorHalf2WordAtPtx2528R1169, r_MmaAccumulatorHalf2WordAtPtx2549R1170,
		r_MmaAccumulatorHalf2WordAtPtx2549R1171, r_MmaAccumulatorHalf2WordAtPtx2556R1172,
		r_MmaAccumulatorHalf2WordAtPtx2556R1173, r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175,
		r_MmaAHalf2WordAtPtx2323R1176;
	uint32_t r_MmaAHalf2WordAtPtx2323R1177, r_MmaAHalf2WordAtPtx2332R1178, r_MmaAHalf2WordAtPtx2332R1179,
		r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181, r_MmaAccumulatorHalf2WordAtPtx2577R1182,
		r_MmaAccumulatorHalf2WordAtPtx2577R1183, r_MmaAccumulatorHalf2WordAtPtx2584R1184,
		r_MmaAccumulatorHalf2WordAtPtx2584R1185, r_MmaAccumulatorHalf2WordAtPtx2605R1186,
		r_MmaAccumulatorHalf2WordAtPtx2605R1187, r_MmaAccumulatorHalf2WordAtPtx2612R1188;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2612R1189, r_MmaAccumulatorHalf2WordAtPtx2633R1190,
		r_MmaAccumulatorHalf2WordAtPtx2633R1191, r_MmaAccumulatorHalf2WordAtPtx2640R1192,
		r_MmaAccumulatorHalf2WordAtPtx2640R1193, r_MmaAccumulatorHalf2WordAtPtx2661R1194,
		r_MmaAccumulatorHalf2WordAtPtx2661R1195, r_MmaAccumulatorHalf2WordAtPtx2668R1196,
		r_MmaAccumulatorHalf2WordAtPtx2668R1197, r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199,
		r_MmaAHalf2WordAtPtx2341R1200;
	uint32_t r_MmaAHalf2WordAtPtx2341R1201, r_MmaAHalf2WordAtPtx2350R1202, r_MmaAHalf2WordAtPtx2350R1203,
		r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205, r_MmaAccumulatorHalf2WordAtPtx2689R1206,
		r_MmaAccumulatorHalf2WordAtPtx2689R1207, r_MmaAccumulatorHalf2WordAtPtx2696R1208,
		r_MmaAccumulatorHalf2WordAtPtx2696R1209, r_MmaAccumulatorHalf2WordAtPtx2717R1210,
		r_MmaAccumulatorHalf2WordAtPtx2717R1211, r_MmaAccumulatorHalf2WordAtPtx2724R1212;
	uint32_t r_MmaAccumulatorHalf2WordAtPtx2724R1213, r_MmaAccumulatorHalf2WordAtPtx2745R1214,
		r_MmaAccumulatorHalf2WordAtPtx2745R1215, r_MmaAccumulatorHalf2WordAtPtx2752R1216,
		r_MmaAccumulatorHalf2WordAtPtx2752R1217, r_MmaAccumulatorHalf2WordAtPtx2773R1218,
		r_MmaAccumulatorHalf2WordAtPtx2773R1219, r_MmaAccumulatorHalf2WordAtPtx2780R1220,
		r_MmaAccumulatorHalf2WordAtPtx2780R1221, r_PtxRegister1222, r_PtxRegister1223, r_PtxRegister1224;
	uint32_t r_PtxRegister1225, r_PtxRegister1226, r_PtxRegister1227, r_PtxRegister1228, r_PtxRegister1229,
		r_PtxRegister1230, r_PtxRegister1231, r_PtxRegister1232, r_PtxRegister1233, r_PtxRegister1234,
		r_PtxRegister1235, r_PtxRegister1236;
	uint32_t r_PtxRegister1237, r_PtxRegister1238, r_PtxRegister1239, r_PtxRegister1240, r_LaneIndexAtPtx2815,
		r_LaneIndexAtPtx2823, r_LaneIndexAtPtx2832, r_LaneIndexAtPtx2841, r_LaneIndexAtPtx2850,
		r_LaneIndexAtPtx2859, r_LaneIndexAtPtx2868, r_LaneIndexAtPtx2877;
	uint32_t r_PtxRegister1249, r_PtxRegister1250, r_CtaZAtPtx2803, r_PtxRegister1252, r_PtxRegister1253,
		r_PtxRegister1254, r_PtxRegister1255, r_PtxRegister1256, r_PtxRegister1257, r_PtxRegister1258,
		r_PtxRegister1259, r_PtxRegister1260;
	uint32_t r_PtxRegister1261, r_PtxRegister1262, r_PtxRegister1263, r_PtxRegister1264, r_PtxRegister1265,
		r_PtxRegister1266, r_PtxRegister1267, r_PtxRegister1268, r_PtxRegister1269, r_PtxRegister1270,
		r_CtaZAtPtx2932, r_PtxRegister1272;
	uint32_t r_PtxRegister1273, r_PtxRegister1274, r_PtxRegister1275, r_PtxRegister1276, r_PtxRegister1277,
		r_PtxRegister1278, r_PtxRegister1279, r_PtxRegister1280, r_PtxRegister1281, r_PtxRegister1282,
		r_LaneIndexAtPtx2977, r_PtxRegister1284;
	uint32_t r_PtxRegister1285, r_PtxRegister1286, r_PtxRegister1287, r_PtxRegister1288, r_PtxRegister1289,
		r_PtxRegister1290, r_PtxRegister1291, r_ThreadYAtPtx2963, r_PtxRegister1293, r_PtxRegister1294,
		r_PtxRegister1295, r_PtxRegister1296;
	uint32_t r_PtxRegister1297, r_PtxRegister1298, r_PtxRegister1299, r_CtaZAtPtx3007, r_PtxRegister1301,
		r_PtxRegister1302, r_PtxRegister1303, r_PtxRegister1304, r_PtxRegister1305, r_PtxRegister1306,
		r_PtxRegister1307, r_PtxRegister1308;
	uint32_t r_PtxRegister1309, r_LaneIndexAtPtx3054, r_PtxRegister1311, r_PtxRegister1312, r_PtxRegister1313,
		r_PtxRegister1314, r_PtxRegister1315, r_PtxRegister1316, r_PtxRegister1317, r_PtxRegister1318,
		r_PtxRegister1319, r_PtxRegister1320;
	uint32_t r_PtxRegister1321, r_PtxRegister1322, r_PtxRegister1323, r_PtxRegister1324, r_PtxRegister1325,
		r_PtxRegister1326, r_PtxRegister1327, r_PtxRegister1328, r_PtxRegister1329, r_PtxRegister1330,
		r_PtxRegister1331, r_PtxRegister1332;
	uint32_t r_LaneIndexAtPtx3078, r_PtxRegister1334, r_PtxRegister1335, r_PtxRegister1336, r_PtxRegister1337,
		r_PtxRegister1338, r_PtxRegister1339, r_PtxRegister1340, r_PtxRegister1341, r_PtxRegister1342,
		r_PtxRegister1343, r_PtxRegister1344;
	uint32_t r_PtxRegister1345, r_PtxRegister1346, r_PtxRegister1347, r_PtxRegister1348, r_PtxRegister1349,
		r_PtxRegister1350, r_PtxRegister1351, r_PtxRegister1352, r_LaneIndexAtPtx3114, r_PtxRegister1354,
		r_PtxRegister1355, r_PtxRegister1356;
	uint32_t r_PtxRegister1357, r_PtxRegister1358, r_PtxRegister1359, r_PtxRegister1360, r_PtxRegister1361,
		r_PtxRegister1362, r_PtxRegister1363, r_PtxRegister1364, r_PtxRegister1365, r_PtxRegister1366,
		r_PtxRegister1367, r_PtxRegister1368;
	uint32_t r_PtxRegister1369, r_PtxRegister1370, r_PtxRegister1371, r_LaneIndexAtPtx3149, r_PtxRegister1373,
		r_PtxRegister1374, r_PtxRegister1375, r_PtxRegister1376, r_PtxRegister1377, r_PtxRegister1378,
		r_PtxRegister1379, r_PtxRegister1380;
	uint32_t r_PtxRegister1381, r_PtxRegister1382, r_PtxRegister1383, r_PtxRegister1384, r_PtxRegister1385,
		r_PtxRegister1386, r_PtxRegister1387, r_PtxRegister1388, r_PtxRegister1389, r_LaneIndexAtPtx3184,
		r_PtxRegister1391, r_PtxRegister1392;
	uint32_t r_PtxRegister1393, r_PtxRegister1394, r_PtxRegister1395, r_PtxRegister1396, r_PtxRegister1397,
		r_PtxRegister1398, r_PtxRegister1399, r_PtxRegister1400, r_PtxRegister1401, r_PtxRegister1402,
		r_PtxRegister1403, r_PtxRegister1404;
	uint32_t r_PtxRegister1405, r_PtxRegister1406, r_PtxRegister1407, r_PtxRegister1408, r_LaneIndexAtPtx3219,
		r_PtxRegister1410, r_PtxRegister1411, r_PtxRegister1412, r_PtxRegister1413, r_PtxRegister1414,
		r_PtxRegister1415, r_PtxRegister1416;
	uint32_t r_PtxRegister1417, r_PtxRegister1418, r_PtxRegister1419, r_PtxRegister1420, r_PtxRegister1421,
		r_PtxRegister1422, r_PtxRegister1423, r_PtxRegister1424, r_PtxRegister1425, r_PtxRegister1426,
		r_LaneIndexAtPtx3254, r_PtxRegister1428;
	uint32_t r_PtxRegister1429, r_PtxRegister1430, r_PtxRegister1431, r_PtxRegister1432, r_PtxRegister1433,
		r_PtxRegister1434, r_PtxRegister1435, r_PtxRegister1436, r_PtxRegister1437, r_PtxRegister1438,
		r_PtxRegister1439, r_PtxRegister1440;
	uint32_t r_PtxRegister1441, r_PtxRegister1442, r_PtxRegister1443, r_PtxRegister1444, r_PtxRegister1445,
		r_LaneIndexAtPtx3289, r_PtxRegister1447, r_PtxRegister1448, r_PtxRegister1449, r_PtxRegister1450,
		r_PtxRegister1451, r_PtxRegister1452;
	uint32_t r_PtxRegister1453, r_PtxRegister1454, r_PtxRegister1455, r_PtxRegister1456, r_PtxRegister1457,
		r_PtxRegister1458, r_PtxRegister1459, r_PtxRegister1460, r_PtxRegister1461, r_PtxRegister1462,
		r_PtxRegister1463, r_LaneIndexAtPtx3324;
	uint32_t r_PtxRegister1465, r_PtxRegister1466, r_PtxRegister1467, r_PtxRegister1468, r_PtxRegister1469,
		r_PtxRegister1470, r_PtxRegister1471, r_PtxRegister1472, r_PtxRegister1473, r_PtxRegister1474,
		r_PtxRegister1475, r_PtxRegister1476;
	uint32_t r_PtxRegister1477, r_PtxRegister1478, r_PtxRegister1479, r_PtxRegister1480, r_PtxRegister1481,
		r_PtxRegister1482, r_LaneIndexAtPtx3359, r_PtxRegister1484, r_PtxRegister1485, r_PtxRegister1486,
		r_PtxRegister1487, r_PtxRegister1488;
	uint32_t r_PtxRegister1489, r_PtxRegister1490, r_PtxRegister1491, r_PtxRegister1492, r_PtxRegister1493,
		r_PtxRegister1494, r_PtxRegister1495, r_PtxRegister1496, r_PtxRegister1497, r_PtxRegister1498,
		r_PtxRegister1499, r_PtxRegister1500;
	uint32_t r_LaneIndexAtPtx3394, r_PtxRegister1502, r_PtxRegister1503, r_PtxRegister1504, r_PtxRegister1505,
		r_PtxRegister1506, r_PtxRegister1507, r_PtxRegister1508, r_PtxRegister1509, r_PtxRegister1510,
		r_PtxRegister1511, r_PtxRegister1512;
	uint32_t r_PtxRegister1513, r_PtxRegister1514, r_PtxRegister1515, r_PtxRegister1516, r_PtxRegister1517,
		r_PtxRegister1518, r_PtxRegister1519, r_LaneIndexAtPtx3429, r_PtxRegister1521, r_PtxRegister1522,
		r_PtxRegister1523, r_PtxRegister1524;
	uint32_t r_PtxRegister1525, r_PtxRegister1526, r_PtxRegister1527, r_PtxRegister1528, r_PtxRegister1529,
		r_PtxRegister1530, r_PtxRegister1531, r_PtxRegister1532, r_PtxRegister1533, r_PtxRegister1534,
		r_PtxRegister1535, r_PtxRegister1536;
	uint32_t r_PtxRegister1537, r_LaneIndexAtPtx3464, r_PtxRegister1539, r_PtxRegister1540, r_PtxRegister1541,
		r_PtxRegister1542, r_PtxRegister1543, r_PtxRegister1544, r_PtxRegister1545, r_PtxRegister1546,
		r_PtxRegister1547, r_PtxRegister1548;
	uint32_t r_PtxRegister1549, r_PtxRegister1550, r_PtxRegister1551, r_PtxRegister1552, r_PtxRegister1553,
		r_PtxRegister1554, r_PtxRegister1555, r_PtxRegister1556, r_LaneIndexAtPtx3499, r_PtxRegister1558,
		r_PtxRegister1559, r_PtxRegister1560;
	uint32_t r_PtxRegister1561, r_PtxRegister1562, r_PtxRegister1563, r_PtxRegister1564, r_PtxRegister1565,
		r_PtxRegister1566, r_PtxRegister1567, r_PtxRegister1568, r_PtxRegister1569, r_PtxRegister1570,
		r_PtxRegister1571, r_PtxRegister1572;
	uint32_t r_PtxRegister1573, r_PtxRegister1574, r_LaneIndexAtPtx3534, r_PtxRegister1576, r_PtxRegister1577,
		r_PtxRegister1578, r_PtxRegister1579, r_PtxRegister1580, r_PtxRegister1581, r_PtxRegister1582,
		r_PtxRegister1583, r_PtxRegister1584;
	uint32_t r_PtxRegister1585, r_PtxRegister1586, r_PtxRegister1587, r_PtxRegister1588, r_PtxRegister1589,
		r_PtxRegister1590, r_PtxRegister1591, r_PtxRegister1592, r_PtxRegister1593, r_LaneIndexAtPtx3569,
		r_PtxRegister1595, r_PtxRegister1596;
	uint32_t r_PtxRegister1597, r_PtxRegister1598, r_PtxRegister1599, r_PtxRegister1600, r_PtxRegister1601,
		r_PtxRegister1602, r_PtxRegister1603, r_PtxRegister1604, r_PtxRegister1605, r_PtxRegister1606,
		r_PtxRegister1607, r_PtxRegister1608;
	uint32_t r_PtxRegister1609, r_PtxRegister1610, r_PtxRegister1611, r_LaneIndexAtPtx3604, r_PtxRegister1613,
		r_PtxRegister1614, r_PtxRegister1615, r_PtxRegister1616, r_PtxRegister1617, r_PtxRegister1618,
		r_PtxRegister1619, r_PtxRegister1620;
	uint32_t r_PtxRegister1621, r_PtxRegister1622, r_PtxRegister1623, r_PtxRegister1624, r_PtxRegister1625,
		r_PtxRegister1626, r_PtxRegister1627, r_PtxRegister1628, r_PtxRegister1629, r_PtxRegister1630,
		r_LaneIndexAtPtx3639, r_PtxRegister1632;
	uint32_t r_PtxRegister1633, r_PtxRegister1634, r_PtxRegister1635, r_PtxRegister1636, r_PtxRegister1637,
		r_PtxRegister1638, r_PtxRegister1639, r_PtxRegister1640, r_PtxRegister1641, r_PtxRegister1642,
		r_PtxRegister1643, r_PtxRegister1644;
	uint32_t r_PtxRegister1645, r_PtxRegister1646, r_PtxRegister1647, r_PtxRegister1648, r_PtxRegister1649,
		r_LaneIndexAtPtx3672, r_PtxRegister1651, r_PtxRegister1652, r_PtxRegister1653, r_PtxRegister1654,
		r_PtxRegister1655, r_PtxRegister1656;
	uint32_t r_PtxRegister1657, r_PtxRegister1658, r_PtxRegister1659, r_PtxRegister1660, r_PtxRegister1661,
		r_PtxRegister1662, r_PtxRegister1663, r_PtxRegister1664, r_PtxRegister1665, r_PtxRegister1666,
		r_PtxRegister1667, r_PtxRegister1668;
	uint32_t r_PtxRegister1669, r_LaneIndexAtPtx3706, r_PtxRegister1671, r_PtxRegister1672, r_PtxRegister1673,
		r_PtxRegister1674, r_PtxRegister1675, r_PtxRegister1676, r_PtxRegister1677, r_PtxRegister1678,
		r_PtxRegister1679, r_PtxRegister1680;
	uint32_t r_PtxRegister1681, r_PtxRegister1682, r_PtxRegister1683, r_PtxRegister1684, r_PtxRegister1685,
		r_PtxRegister1686, r_PtxRegister1687, r_PtxRegister1688, r_LaneIndexAtPtx3739, r_PtxRegister1690,
		r_PtxRegister1691, r_PtxRegister1692;
	uint32_t r_PtxRegister1693, r_PtxRegister1694, r_PtxRegister1695, r_PtxRegister1696, r_PtxRegister1697,
		r_PtxRegister1698, r_PtxRegister1699, r_PtxRegister1700, r_PtxRegister1701, r_PtxRegister1702,
		r_PtxRegister1703, r_PtxRegister1704;
	uint32_t r_PtxRegister1705, r_PtxRegister1706, r_PtxRegister1707, r_PtxRegister1708, r_LaneIndexAtPtx3773,
		r_PtxRegister1710, r_PtxRegister1711, r_PtxRegister1712, r_PtxRegister1713, r_PtxRegister1714,
		r_PtxRegister1715, r_PtxRegister1716;
	uint32_t r_PtxRegister1717, r_PtxRegister1718, r_PtxRegister1719, r_PtxRegister1720, r_PtxRegister1721,
		r_PtxRegister1722, r_PtxRegister1723, r_PtxRegister1724, r_PtxRegister1725, r_PtxRegister1726,
		r_PtxRegister1727, r_LaneIndexAtPtx3806;
	uint32_t r_PtxRegister1729, r_PtxRegister1730, r_PtxRegister1731, r_PtxRegister1732, r_PtxRegister1733,
		r_PtxRegister1734, r_PtxRegister1735, r_PtxRegister1736, r_PtxRegister1737, r_PtxRegister1738,
		r_PtxRegister1739, r_PtxRegister1740;
	uint32_t r_PtxRegister1741, r_PtxRegister1742, r_PtxRegister1743, r_PtxRegister1744, r_PtxRegister1745,
		r_PtxRegister1746, r_PtxRegister1747, r_LaneIndexAtPtx3840, r_PtxRegister1749, r_PtxRegister1750,
		r_PtxRegister1751, r_PtxRegister1752;
	uint32_t r_PtxRegister1753, r_PtxRegister1754, r_PtxRegister1755, r_PtxRegister1756, r_PtxRegister1757,
		r_PtxRegister1758, r_PtxRegister1759, r_PtxRegister1760, r_PtxRegister1761, r_PtxRegister1762,
		r_PtxRegister1763, r_PtxRegister1764;
	uint32_t r_PtxRegister1765, r_PtxRegister1766, r_LaneIndexAtPtx3873, r_PtxRegister1768, r_PtxRegister1769,
		r_PtxRegister1770, r_PtxRegister1771, r_PtxRegister1772, r_PtxRegister1773, r_PtxRegister1774,
		r_PtxRegister1775, r_PtxRegister1776;
	uint32_t r_PtxRegister1777, r_PtxRegister1778, r_PtxRegister1779, r_PtxRegister1780, r_PtxRegister1781,
		r_PtxRegister1782, r_PtxRegister1783, r_PtxRegister1784, r_PtxRegister1785, r_PtxRegister1786,
		r_LaneIndexAtPtx3907, r_PtxRegister1788;
	uint32_t r_PtxRegister1789, r_PtxRegister1790, r_PtxRegister1791, r_PtxRegister1792, r_PtxRegister1793,
		r_PtxRegister1794, r_PtxRegister1795, r_PtxRegister1796, r_PtxRegister1797, r_PtxRegister1798,
		r_PtxRegister1799, r_PtxRegister1800;
	uint32_t r_PtxRegister1801, r_PtxRegister1802, r_PtxRegister1803, r_PtxRegister1804, r_PtxRegister1805,
		r_LaneIndexAtPtx3940, r_PtxRegister1807, r_PtxRegister1808, r_PtxRegister1809, r_PtxRegister1810,
		r_PtxRegister1811, r_PtxRegister1812;
	uint32_t r_PtxRegister1813, r_PtxRegister1814, r_PtxRegister1815, r_PtxRegister1816, r_PtxRegister1817,
		r_PtxRegister1818, r_PtxRegister1819, r_PtxRegister1820, r_PtxRegister1821, r_PtxRegister1822,
		r_PtxRegister1823, r_PtxRegister1824;
	uint32_t r_PtxRegister1825, r_LaneIndexAtPtx3974, r_PtxRegister1827, r_PtxRegister1828, r_PtxRegister1829,
		r_PtxRegister1830, r_PtxRegister1831, r_PtxRegister1832, r_PtxRegister1833, r_PtxRegister1834,
		r_PtxRegister1835, r_PtxRegister1836;
	uint32_t r_PtxRegister1837, r_PtxRegister1838, r_PtxRegister1839, r_PtxRegister1840, r_PtxRegister1841,
		r_PtxRegister1842, r_PtxRegister1843, r_PtxRegister1844, r_LaneIndexAtPtx4007, r_PtxRegister1846,
		r_PtxRegister1847, r_PtxRegister1848;
	uint32_t r_PtxRegister1849, r_PtxRegister1850, r_PtxRegister1851, r_PtxRegister1852, r_PtxRegister1853,
		r_PtxRegister1854, r_PtxRegister1855, r_PtxRegister1856, r_PtxRegister1857, r_PtxRegister1858,
		r_PtxRegister1859, r_PtxRegister1860;
	uint32_t r_PtxRegister1861, r_PtxRegister1862, r_PtxRegister1863, r_PtxRegister1864, r_LaneIndexAtPtx4041,
		r_PtxRegister1866, r_PtxRegister1867, r_PtxRegister1868, r_PtxRegister1869, r_PtxRegister1870,
		r_PtxRegister1871, r_PtxRegister1872;
	uint32_t r_PtxRegister1873, r_PtxRegister1874, r_PtxRegister1875, r_PtxRegister1876, r_PtxRegister1877,
		r_PtxRegister1878, r_PtxRegister1879, r_PtxRegister1880, r_PtxRegister1881, r_PtxRegister1882,
		r_PtxRegister1883, r_LaneIndexAtPtx4074;
	uint32_t r_PtxRegister1885, r_PtxRegister1886, r_PtxRegister1887, r_PtxRegister1888, r_PtxRegister1889,
		r_PtxRegister1890, r_PtxRegister1891, r_PtxRegister1892, r_PtxRegister1893, r_PtxRegister1894,
		r_PtxRegister1895, r_PtxRegister1896;
	uint32_t r_PtxRegister1897, r_PtxRegister1898, r_PtxRegister1899, r_PtxRegister1900, r_PtxRegister1901,
		r_PtxRegister1902, r_PtxRegister1903, r_LaneIndexAtPtx4108, r_PtxRegister1905, r_PtxRegister1906,
		r_PtxRegister1907, r_PtxRegister1908;
	uint32_t r_PtxRegister1909, r_PtxRegister1910, r_PtxRegister1911, r_PtxRegister1912, r_PtxRegister1913,
		r_PtxRegister1914, r_PtxRegister1915, r_PtxRegister1916, r_PtxRegister1917, r_PtxRegister1918,
		r_PtxRegister1919, r_PtxRegister1920;
	uint32_t r_PtxRegister1921, r_PtxRegister1922, r_LaneIndexAtPtx4141, r_PtxRegister1924, r_PtxRegister1925,
		r_PtxRegister1926, r_PtxRegister1927, r_PtxRegister1928, r_PtxRegister1929, r_PtxRegister1930,
		r_PtxRegister1931, r_PtxRegister1932;
	uint32_t r_PtxRegister1933, r_PtxRegister1934, r_PtxRegister1935, r_PtxRegister1936, r_PtxRegister1937,
		r_PtxRegister1938, r_PtxRegister1939, r_PtxRegister1940, r_PtxRegister1941, r_PtxRegister1942,
		r_LaneIndexAtPtx4175, r_PtxRegister1944;
	uint32_t r_PtxRegister1945, r_PtxRegister1946, r_PtxRegister1947, r_PtxRegister1948, r_PtxRegister1949,
		r_PtxRegister1950, r_PtxRegister1951, r_PtxRegister1952, r_PtxRegister1953, r_PtxRegister1954,
		r_PtxRegister1955, r_PtxRegister1956;
	uint32_t r_PtxRegister1957, r_PtxRegister1958, r_PtxRegister1959, r_PtxRegister1960, r_PtxRegister1961,
		r_LaneIndexAtPtx4210, r_PtxRegister1963, r_PtxRegister1964, r_PtxRegister1965, r_PtxRegister1966,
		r_PtxRegister1967, r_PtxRegister1968;
	uint32_t r_PtxRegister1969, r_PtxRegister1970, r_PtxRegister1971, r_PtxRegister1972, r_PtxRegister1973,
		r_PtxRegister1974, r_PtxRegister1975, r_PtxRegister1976, r_PtxRegister1977, r_PtxRegister1978,
		r_PtxRegister1979, r_PtxRegister1980;
	uint32_t r_LaneIndexAtPtx4245, r_PtxRegister1982, r_PtxRegister1983, r_PtxRegister1984, r_PtxRegister1985,
		r_PtxRegister1986, r_PtxRegister1987, r_PtxRegister1988, r_PtxRegister1989, r_PtxRegister1990,
		r_PtxRegister1991, r_PtxRegister1992;
	uint32_t r_PtxRegister1993, r_PtxRegister1994, r_PtxRegister1995, r_PtxRegister1996, r_PtxRegister1997,
		r_PtxRegister1998, r_PtxRegister1999, r_LaneIndexAtPtx4280, r_PtxRegister2001, r_PtxRegister2002,
		r_PtxRegister2003, r_PtxRegister2004;
	uint32_t r_PtxRegister2005, r_PtxRegister2006, r_PtxRegister2007, r_PtxRegister2008, r_PtxRegister2009,
		r_PtxRegister2010, r_PtxRegister2011, r_PtxRegister2012, r_PtxRegister2013, r_PtxRegister2014,
		r_PtxRegister2015, r_PtxRegister2016;
	uint32_t r_PtxRegister2017, r_PtxRegister2018, r_LaneIndexAtPtx4315, r_PtxRegister2020, r_PtxRegister2021,
		r_PtxRegister2022, r_PtxRegister2023, r_PtxRegister2024, r_PtxRegister2025, r_PtxRegister2026,
		r_PtxRegister2027, r_PtxRegister2028;
	uint32_t r_PtxRegister2029, r_PtxRegister2030, r_PtxRegister2031, r_PtxRegister2032, r_PtxRegister2033,
		r_PtxRegister2034, r_PtxRegister2035, r_PtxRegister2036, r_PtxRegister2037, r_LaneIndexAtPtx4350,
		r_PtxRegister2039, r_PtxRegister2040;
	uint32_t r_PtxRegister2041, r_PtxRegister2042, r_PtxRegister2043, r_PtxRegister2044, r_PtxRegister2045,
		r_PtxRegister2046, r_PtxRegister2047, r_PtxRegister2048, r_PtxRegister2049, r_PtxRegister2050,
		r_PtxRegister2051, r_PtxRegister2052;
	uint32_t r_PtxRegister2053, r_PtxRegister2054, r_PtxRegister2055, r_PtxRegister2056, r_LaneIndexAtPtx4385,
		r_PtxRegister2058, r_PtxRegister2059, r_PtxRegister2060, r_PtxRegister2061, r_PtxRegister2062,
		r_PtxRegister2063, r_PtxRegister2064;
	uint32_t r_PtxRegister2065, r_PtxRegister2066, r_PtxRegister2067, r_PtxRegister2068, r_PtxRegister2069,
		r_PtxRegister2070, r_PtxRegister2071, r_PtxRegister2072, r_PtxRegister2073, r_PtxRegister2074,
		r_PtxRegister2075, r_LaneIndexAtPtx4420;
	uint32_t r_PtxRegister2077, r_PtxRegister2078, r_PtxRegister2079, r_PtxRegister2080, r_PtxRegister2081,
		r_PtxRegister2082, r_PtxRegister2083, r_PtxRegister2084, r_PtxRegister2085, r_PtxRegister2086,
		r_PtxRegister2087, r_PtxRegister2088;
	uint32_t r_PtxRegister2089, r_PtxRegister2090, r_PtxRegister2091, r_PtxRegister2092, r_PtxRegister2093,
		r_PtxRegister2094, r_LaneIndexAtPtx4455, r_PtxRegister2096, r_PtxRegister2097, r_PtxRegister2098,
		r_PtxRegister2099, r_PtxRegister2100;
	uint32_t r_PtxRegister2101, r_PtxRegister2102, r_PtxRegister2103, r_PtxRegister2104, r_PtxRegister2105,
		r_PtxRegister2106, r_PtxRegister2107, r_PtxRegister2108, r_PtxRegister2109, r_PtxRegister2110,
		r_PtxRegister2111, r_PtxRegister2112;
	uint32_t r_PtxRegister2113, r_LaneIndexAtPtx4490, r_PtxRegister2115, r_PtxRegister2116, r_PtxRegister2117,
		r_PtxRegister2118, r_PtxRegister2119, r_PtxRegister2120, r_PtxRegister2121, r_PtxRegister2122,
		r_PtxRegister2123, r_PtxRegister2124;
	uint32_t r_PtxRegister2125, r_PtxRegister2126, r_PtxRegister2127, r_PtxRegister2128, r_PtxRegister2129,
		r_PtxRegister2130, r_PtxRegister2131, r_PtxRegister2132, r_LaneIndexAtPtx4525, r_PtxRegister2134,
		r_PtxRegister2135, r_PtxRegister2136;
	uint32_t r_PtxRegister2137, r_PtxRegister2138, r_PtxRegister2139, r_PtxRegister2140, r_PtxRegister2141,
		r_PtxRegister2142, r_PtxRegister2143, r_PtxRegister2144, r_PtxRegister2145, r_PtxRegister2146,
		r_PtxRegister2147, r_PtxRegister2148;
	uint32_t r_PtxRegister2149, r_PtxRegister2150, r_PtxRegister2151, r_LaneIndexAtPtx4560, r_PtxRegister2153,
		r_PtxRegister2154, r_PtxRegister2155, r_PtxRegister2156, r_PtxRegister2157, r_PtxRegister2158,
		r_PtxRegister2159, r_PtxRegister2160;
	uint32_t r_PtxRegister2161, r_PtxRegister2162, r_PtxRegister2163, r_PtxRegister2164, r_PtxRegister2165,
		r_PtxRegister2166, r_PtxRegister2167, r_PtxRegister2168, r_PtxRegister2169, r_PtxRegister2170,
		r_LaneIndexAtPtx4595, r_PtxRegister2172;
	uint32_t r_PtxRegister2173, r_PtxRegister2174, r_PtxRegister2175, r_PtxRegister2176, r_PtxRegister2177,
		r_PtxRegister2178, r_PtxRegister2179, r_PtxRegister2180, r_PtxRegister2181, r_PtxRegister2182,
		r_PtxRegister2183, r_PtxRegister2184;
	uint32_t r_PtxRegister2185, r_PtxRegister2186, r_PtxRegister2187, r_PtxRegister2188, r_PtxRegister2189,
		r_LaneIndexAtPtx4630, r_PtxRegister2191, r_PtxRegister2192, r_PtxRegister2193, r_PtxRegister2194,
		r_PtxRegister2195, r_PtxRegister2196;
	uint32_t r_PtxRegister2197, r_PtxRegister2198, r_PtxRegister2199, r_PtxRegister2200, r_PtxRegister2201,
		r_PtxRegister2202, r_PtxRegister2203, r_PtxRegister2204, r_PtxRegister2205, r_PtxRegister2206,
		r_PtxRegister2207, r_PtxRegister2208;
	uint32_t r_LaneIndexAtPtx4665, r_PtxRegister2210, r_PtxRegister2211, r_PtxRegister2212, r_PtxRegister2213,
		r_PtxRegister2214, r_PtxRegister2215, r_PtxRegister2216, r_PtxRegister2217, r_PtxRegister2218,
		r_PtxRegister2219, r_PtxRegister2220;
	uint32_t r_PtxRegister2221, r_PtxRegister2222, r_PtxRegister2223, r_PtxRegister2224, r_PtxRegister2225,
		r_PtxRegister2226, r_PtxRegister2227, r_LaneIndexAtPtx4700, r_PtxRegister2229, r_PtxRegister2230,
		r_PtxRegister2231, r_PtxRegister2232;
	uint32_t r_PtxRegister2233, r_PtxRegister2234, r_PtxRegister2235, r_PtxRegister2236, r_PtxRegister2237,
		r_PtxRegister2238, r_PtxRegister2239, r_PtxRegister2240, r_PtxRegister2241, r_PtxRegister2242,
		r_PtxRegister2243, r_PtxRegister2244;
	uint32_t r_PtxRegister2245, r_PtxRegister2246, r_LaneIndexAtPtx4735, r_PtxRegister2248, r_PtxRegister2249,
		r_PtxRegister2250, r_PtxRegister2251, r_PtxRegister2252, r_PtxRegister2253, r_PtxRegister2254,
		r_PtxRegister2255, r_PtxRegister2256;
	uint32_t r_PtxRegister2257, r_PtxRegister2258, r_PtxRegister2259, r_PtxRegister2260, r_PtxRegister2261,
		r_PtxRegister2262, r_PtxRegister2263, r_PtxRegister2264, r_PtxRegister2265, r_PtxRegister2266,
		r_LaneIndexAtPtx4769, r_PtxRegister2268;
	uint32_t r_PtxRegister2269, r_PtxRegister2270, r_PtxRegister2271, r_PtxRegister2272, r_PtxRegister2273,
		r_PtxRegister2274, r_PtxRegister2275, r_PtxRegister2276, r_PtxRegister2277, r_PtxRegister2278,
		r_PtxRegister2279, r_PtxRegister2280;
	uint32_t r_PtxRegister2281, r_PtxRegister2282, r_PtxRegister2283, r_PtxRegister2284, r_PtxRegister2285,
		r_PtxRegister2286, r_LaneIndexAtPtx4803, r_PtxRegister2288, r_PtxRegister2289, r_PtxRegister2290,
		r_PtxRegister2291, r_PtxRegister2292;
	uint32_t r_PtxRegister2293, r_PtxRegister2294, r_PtxRegister2295, r_PtxRegister2296, r_PtxRegister2297,
		r_PtxRegister2298, r_PtxRegister2299, r_PtxRegister2300, r_PtxRegister2301, r_PtxRegister2302,
		r_PtxRegister2303, r_PtxRegister2304;
	uint32_t r_PtxRegister2305, r_PtxRegister2306, r_LaneIndexAtPtx4837, r_PtxRegister2308, r_PtxRegister2309,
		r_PtxRegister2310, r_PtxRegister2311, r_PtxRegister2312, r_PtxRegister2313, r_PtxRegister2314,
		r_PtxRegister2315, r_PtxRegister2316;
	uint32_t r_PtxRegister2317, r_PtxRegister2318, r_PtxRegister2319, r_PtxRegister2320, r_PtxRegister2321,
		r_PtxRegister2322, r_PtxRegister2323, r_PtxRegister2324, r_PtxRegister2325, r_PtxRegister2326,
		r_LaneIndexAtPtx4871, r_PtxRegister2328;
	uint32_t r_PtxRegister2329, r_PtxRegister2330, r_PtxRegister2331, r_PtxRegister2332, r_PtxRegister2333,
		r_PtxRegister2334, r_PtxRegister2335, r_PtxRegister2336, r_PtxRegister2337, r_PtxRegister2338,
		r_PtxRegister2339, r_PtxRegister2340;
	uint32_t r_PtxRegister2341, r_PtxRegister2342, r_PtxRegister2343, r_PtxRegister2344, r_PtxRegister2345,
		r_PtxRegister2346, r_LaneIndexAtPtx4905, r_PtxRegister2348, r_PtxRegister2349, r_PtxRegister2350,
		r_PtxRegister2351, r_PtxRegister2352;
	uint32_t r_PtxRegister2353, r_PtxRegister2354, r_PtxRegister2355, r_PtxRegister2356, r_PtxRegister2357,
		r_PtxRegister2358, r_PtxRegister2359, r_PtxRegister2360, r_PtxRegister2361, r_PtxRegister2362,
		r_PtxRegister2363, r_PtxRegister2364;
	uint32_t r_PtxRegister2365, r_PtxRegister2366, r_LaneIndexAtPtx4939, r_PtxRegister2368, r_PtxRegister2369,
		r_PtxRegister2370, r_PtxRegister2371, r_PtxRegister2372, r_PtxRegister2373, r_PtxRegister2374,
		r_PtxRegister2375, r_PtxRegister2376;
	uint32_t r_PtxRegister2377, r_PtxRegister2378, r_PtxRegister2379, r_PtxRegister2380, r_PtxRegister2381,
		r_PtxRegister2382, r_PtxRegister2383, r_PtxRegister2384, r_PtxRegister2385, r_PtxRegister2386,
		r_LaneIndexAtPtx4973, r_PtxRegister2388;
	uint32_t r_PtxRegister2389, r_PtxRegister2390, r_PtxRegister2391, r_PtxRegister2392, r_PtxRegister2393,
		r_PtxRegister2394, r_PtxRegister2395, r_PtxRegister2396, r_PtxRegister2397, r_PtxRegister2398,
		r_PtxRegister2399, r_PtxRegister2400;
	uint32_t r_PtxRegister2401, r_PtxRegister2402, r_PtxRegister2403, r_PtxRegister2404, r_PtxRegister2405,
		r_PtxRegister2406, r_LaneIndexAtPtx5007, r_PtxRegister2408, r_PtxRegister2409, r_PtxRegister2410,
		r_PtxRegister2411, r_PtxRegister2412;
	uint32_t r_PtxRegister2413, r_PtxRegister2414, r_PtxRegister2415, r_PtxRegister2416, r_PtxRegister2417,
		r_PtxRegister2418, r_PtxRegister2419, r_PtxRegister2420, r_PtxRegister2421, r_PtxRegister2422,
		r_PtxRegister2423, r_PtxRegister2424;
	uint32_t r_PtxRegister2425, r_PtxRegister2426, r_LaneIndexAtPtx5041, r_PtxRegister2428, r_PtxRegister2429,
		r_PtxRegister2430, r_PtxRegister2431, r_PtxRegister2432, r_PtxRegister2433, r_PtxRegister2434,
		r_PtxRegister2435, r_PtxRegister2436;
	uint32_t r_PtxRegister2437, r_PtxRegister2438, r_PtxRegister2439, r_PtxRegister2440, r_PtxRegister2441,
		r_PtxRegister2442, r_PtxRegister2443, r_PtxRegister2444, r_PtxRegister2445, r_PtxRegister2446,
		r_LaneIndexAtPtx5075, r_PtxRegister2448;
	uint32_t r_PtxRegister2449, r_PtxRegister2450, r_PtxRegister2451, r_PtxRegister2452, r_PtxRegister2453,
		r_PtxRegister2454, r_PtxRegister2455, r_PtxRegister2456, r_PtxRegister2457, r_PtxRegister2458,
		r_PtxRegister2459, r_PtxRegister2460;
	uint32_t r_PtxRegister2461, r_PtxRegister2462, r_PtxRegister2463, r_PtxRegister2464, r_PtxRegister2465,
		r_PtxRegister2466, r_LaneIndexAtPtx5109, r_PtxRegister2468, r_PtxRegister2469, r_PtxRegister2470,
		r_PtxRegister2471, r_PtxRegister2472;
	uint32_t r_PtxRegister2473, r_PtxRegister2474, r_PtxRegister2475, r_PtxRegister2476, r_PtxRegister2477,
		r_PtxRegister2478, r_PtxRegister2479, r_PtxRegister2480, r_PtxRegister2481, r_PtxRegister2482,
		r_PtxRegister2483, r_PtxRegister2484;
	uint32_t r_PtxRegister2485, r_PtxRegister2486, r_LaneIndexAtPtx5143, r_PtxRegister2488, r_PtxRegister2489,
		r_PtxRegister2490, r_PtxRegister2491, r_PtxRegister2492, r_PtxRegister2493, r_PtxRegister2494,
		r_PtxRegister2495, r_PtxRegister2496;
	uint32_t r_PtxRegister2497, r_PtxRegister2498, r_PtxRegister2499, r_PtxRegister2500, r_PtxRegister2501,
		r_PtxRegister2502, r_PtxRegister2503, r_PtxRegister2504, r_PtxRegister2505, r_PtxRegister2506,
		r_LaneIndexAtPtx5177, r_PtxRegister2508;
	uint32_t r_PtxRegister2509, r_PtxRegister2510, r_PtxRegister2511, r_PtxRegister2512, r_PtxRegister2513,
		r_PtxRegister2514, r_PtxRegister2515, r_PtxRegister2516, r_PtxRegister2517, r_PtxRegister2518,
		r_PtxRegister2519, r_PtxRegister2520;
	uint32_t r_PtxRegister2521, r_PtxRegister2522, r_PtxRegister2523, r_PtxRegister2524, r_PtxRegister2525,
		r_PtxRegister2526, r_LaneIndexAtPtx5211, r_PtxRegister2528, r_PtxRegister2529, r_PtxRegister2530,
		r_PtxRegister2531, r_PtxRegister2532;
	uint32_t r_PtxRegister2533, r_PtxRegister2534, r_PtxRegister2535, r_PtxRegister2536, r_PtxRegister2537,
		r_PtxRegister2538, r_PtxRegister2539, r_PtxRegister2540, r_PtxRegister2541, r_PtxRegister2542,
		r_PtxRegister2543, r_PtxRegister2544;
	uint32_t r_PtxRegister2545, r_PtxRegister2546, r_LaneIndexAtPtx5245, r_PtxRegister2548, r_PtxRegister2549,
		r_PtxRegister2550, r_PtxRegister2551, r_PtxRegister2552, r_PtxRegister2553, r_PtxRegister2554,
		r_PtxRegister2555, r_PtxRegister2556;
	uint32_t r_PtxRegister2557, r_PtxRegister2558, r_PtxRegister2559, r_PtxRegister2560, r_PtxRegister2561,
		r_PtxRegister2562, r_PtxRegister2563, r_PtxRegister2564, r_PtxRegister2565, r_PtxRegister2566,
		r_PtxRegister2567, r_PtxRegister2568;
	uint32_t r_PtxRegister2569, r_PtxRegister2570, r_PtxRegister2571, r_PtxRegister2572,
		r_PackedHalf2AtPtx583R2573, r_PackedHalf2AtPtx584R2574, r_PackedHalf2AtPtx585R2575,
		r_PackedHalf2AtPtx586R2576, r_PackedHalf2AtPtx602R2577, r_PackedHalf2AtPtx603R2578,
		r_PackedHalf2AtPtx604R2579, r_PackedHalf2AtPtx605R2580;
	uint32_t r_PackedHalf2AtPtx621R2581, r_PackedHalf2AtPtx622R2582, r_PackedHalf2AtPtx623R2583,
		r_PackedHalf2AtPtx624R2584, r_PackedHalf2AtPtx640R2585, r_PackedHalf2AtPtx641R2586,
		r_PackedHalf2AtPtx642R2587, r_PackedHalf2AtPtx643R2588, r_PackedHalf2AtPtx665R2589,
		r_PackedHalf2AtPtx666R2590, r_PackedHalf2AtPtx667R2591, r_PackedHalf2AtPtx668R2592;
	uint32_t r_PackedHalf2AtPtx684R2593, r_PackedHalf2AtPtx685R2594, r_PackedHalf2AtPtx686R2595,
		r_PackedHalf2AtPtx687R2596, r_PackedHalf2AtPtx703R2597, r_PackedHalf2AtPtx704R2598,
		r_PackedHalf2AtPtx705R2599, r_PackedHalf2AtPtx706R2600, r_PackedHalf2AtPtx722R2601,
		r_PackedHalf2AtPtx723R2602, r_PackedHalf2AtPtx724R2603, r_PackedHalf2AtPtx725R2604;
	uint32_t r_PackedHalf2AtPtx758R2605, r_PackedHalf2AtPtx759R2606, r_PackedHalf2AtPtx760R2607,
		r_PackedHalf2AtPtx761R2608, r_PackedHalf2AtPtx777R2609, r_PackedHalf2AtPtx778R2610,
		r_PackedHalf2AtPtx779R2611, r_PackedHalf2AtPtx780R2612, r_PackedHalf2AtPtx796R2613,
		r_PackedHalf2AtPtx797R2614, r_PackedHalf2AtPtx798R2615, r_PackedHalf2AtPtx799R2616;
	uint32_t r_PackedHalf2AtPtx815R2617, r_PackedHalf2AtPtx816R2618, r_PackedHalf2AtPtx817R2619,
		r_PackedHalf2AtPtx818R2620, r_PackedHalf2AtPtx839R2621, r_PackedHalf2AtPtx840R2622,
		r_PackedHalf2AtPtx841R2623, r_PackedHalf2AtPtx842R2624, r_PackedHalf2AtPtx858R2625,
		r_PackedHalf2AtPtx859R2626, r_PackedHalf2AtPtx860R2627, r_PackedHalf2AtPtx861R2628;
	uint32_t r_PackedHalf2AtPtx877R2629, r_PackedHalf2AtPtx878R2630, r_PackedHalf2AtPtx879R2631,
		r_PackedHalf2AtPtx880R2632, r_PackedHalf2AtPtx896R2633, r_PackedHalf2AtPtx897R2634,
		r_PackedHalf2AtPtx898R2635, r_PackedHalf2AtPtx899R2636, r_PackedHalf2AtPtx2264R2637,
		r_PackedHalf2AtPtx2257R2638, r_PackedHalf2AtPtx2250R2639, r_PackedHalf2AtPtx2243R2640;
	uint32_t r_PackedHalf2AtPtx2236R2641, r_PackedHalf2AtPtx2229R2642, r_PackedHalf2AtPtx2222R2643,
		r_PackedHalf2AtPtx2215R2644, r_PackedHalf2AtPtx2208R2645, r_PackedHalf2AtPtx2201R2646,
		r_PackedHalf2AtPtx2194R2647, r_PackedHalf2AtPtx2187R2648, r_PackedHalf2AtPtx2180R2649,
		r_PackedHalf2AtPtx2173R2650, r_PackedHalf2AtPtx2166R2651, r_PackedHalf2AtPtx2159R2652;
	uint32_t r_PackedHalf2AtPtx2152R2653, r_PackedHalf2AtPtx2145R2654, r_PackedHalf2AtPtx2138R2655,
		r_PackedHalf2AtPtx2131R2656, r_PackedHalf2AtPtx2124R2657, r_PackedHalf2AtPtx2117R2658,
		r_PackedHalf2AtPtx2110R2659, r_PackedHalf2AtPtx2103R2660, r_PackedHalf2AtPtx2096R2661,
		r_PackedHalf2AtPtx2089R2662, r_PackedHalf2AtPtx2082R2663, r_PackedHalf2AtPtx2075R2664;
	uint32_t r_PackedHalf2AtPtx2068R2665, r_PackedHalf2AtPtx2061R2666, r_PackedHalf2AtPtx2054R2667,
		r_PackedHalf2AtPtx2047R2668, r_PackedHalf2AtPtx2040R2669, r_PackedHalf2AtPtx2033R2670,
		r_PackedHalf2AtPtx2026R2671, r_PackedHalf2AtPtx2019R2672, r_PackedHalf2AtPtx2012R2673,
		r_PackedHalf2AtPtx2005R2674, r_PackedHalf2AtPtx1998R2675, r_PackedHalf2AtPtx1991R2676;
	uint32_t r_PackedHalf2AtPtx1984R2677, r_PackedHalf2AtPtx1977R2678, r_PackedHalf2AtPtx1970R2679,
		r_PackedHalf2AtPtx1963R2680, r_PackedHalf2AtPtx1956R2681, r_PackedHalf2AtPtx1949R2682,
		r_PackedHalf2AtPtx1942R2683, r_PackedHalf2AtPtx1935R2684, r_PackedHalf2AtPtx1928R2685,
		r_PackedHalf2AtPtx1921R2686, r_PackedHalf2AtPtx1914R2687, r_PackedHalf2AtPtx1907R2688;
	uint32_t r_PackedHalf2AtPtx1900R2689, r_PackedHalf2AtPtx1893R2690, r_PackedHalf2AtPtx1886R2691,
		r_PackedHalf2AtPtx1879R2692, r_PackedHalf2AtPtx1872R2693, r_PackedHalf2AtPtx1865R2694,
		r_PackedHalf2AtPtx1858R2695, r_PackedHalf2AtPtx1851R2696, r_PackedHalf2AtPtx1844R2697,
		r_PackedHalf2AtPtx1837R2698, r_PackedHalf2AtPtx1830R2699, r_PackedHalf2AtPtx1823R2700;
	uint32_t r_PtxRegister2701, r_MmaBHalf2WordAtPtx151R2702, r_MmaBHalf2WordAtPtx151R2703,
		r_MmaBHalf2WordAtPtx151R2704, r_MmaBHalf2WordAtPtx151R2705, r_MmaBHalf2WordAtPtx142R2706,
		r_MmaBHalf2WordAtPtx142R2707, r_MmaBHalf2WordAtPtx142R2708, r_MmaBHalf2WordAtPtx142R2709,
		r_MmaBHalf2WordAtPtx133R2710, r_MmaBHalf2WordAtPtx133R2711, r_MmaBHalf2WordAtPtx133R2712;
	uint32_t r_MmaBHalf2WordAtPtx133R2713, r_MmaBHalf2WordAtPtx124R2714, r_MmaBHalf2WordAtPtx124R2715,
		r_MmaBHalf2WordAtPtx124R2716, r_MmaBHalf2WordAtPtx124R2717, r_MmaBHalf2WordAtPtx115R2718,
		r_MmaBHalf2WordAtPtx115R2719, r_MmaBHalf2WordAtPtx115R2720, r_MmaBHalf2WordAtPtx115R2721,
		r_MmaBHalf2WordAtPtx105R2722, r_MmaBHalf2WordAtPtx105R2723, r_MmaBHalf2WordAtPtx105R2724;
	uint32_t r_MmaBHalf2WordAtPtx105R2725, r_MmaBHalf2WordAtPtx95R2726, r_MmaBHalf2WordAtPtx95R2727,
		r_MmaBHalf2WordAtPtx95R2728, r_MmaBHalf2WordAtPtx95R2729, r_MmaBHalf2WordAtPtx85R2730,
		r_MmaBHalf2WordAtPtx85R2731, r_MmaBHalf2WordAtPtx85R2732, r_MmaBHalf2WordAtPtx85R2733;
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
	uint64_t r_PtxU64Register313, r_PtxU64Register314, r_PtxU64Register315, r_PtxU64Register316,
		r_PtxU64Register317, r_PtxU64Register318, r_PtxU64Register319, r_PtxU64Register320,
		r_PtxU64Register321, r_PtxU64Register322, r_PtxU64Register323, r_PtxU64Register324;
	uint64_t r_PtxU64Register325, r_PtxU64Register326, r_PtxU64Register327, r_PtxU64Register328,
		r_PtxU64Register329, r_PtxU64Register330, r_PtxU64Register331, r_PtxU64Register332,
		r_PtxU64Register333, r_PtxU64Register334, r_PtxU64Register335, r_PtxU64Register336;
	uint64_t r_PtxU64Register337, r_PtxU64Register338, r_PtxU64Register339, r_PtxU64Register340,
		r_PtxU64Register341, r_PtxU64Register342, r_PtxU64Register343, r_PtxU64Register344,
		r_PtxU64Register345, r_PtxU64Register346, r_PtxU64Register347, r_PtxU64Register348;
	uint64_t r_PtxU64Register349, r_PtxU64Register350, r_PtxU64Register351, r_PtxU64Register352,
		r_PtxU64Register353, r_PtxU64Register354, r_PtxU64Register355, r_PtxU64Register356,
		r_PtxU64Register357, r_PtxU64Register358, r_PtxU64Register359, r_PtxU64Register360;
	uint64_t r_PtxU64Register361, r_PtxU64Register362, r_PtxU64Register363, r_PtxU64Register364,
		r_PtxU64Register365, r_PtxU64Register366, r_PtxU64Register367, r_PtxU64Register368,
		r_PtxU64Register369, r_PtxU64Register370, r_PtxU64Register371, r_PtxU64Register372;
	uint64_t r_PtxU64Register373, r_PtxU64Register374, r_PtxU64Register375, r_PtxU64Register376,
		r_PtxU64Register377, r_PtxU64Register378, r_PtxU64Register379, r_PtxU64Register380,
		r_PtxU64Register381, r_PtxU64Register382, r_PtxU64Register383, r_PtxU64Register384;
	uint64_t r_PtxU64Register385, r_PtxU64Register386, r_PtxU64Register387, r_PtxU64Register388,
		r_PtxU64Register389, r_PtxU64Register390, r_PtxU64Register391, r_PtxU64Register392,
		r_PtxU64Register393, r_PtxU64Register394, r_PtxU64Register395, r_PtxU64Register396;
	uint64_t r_PtxU64Register397, r_PtxU64Register398, r_PtxU64Register399, r_PtxU64Register400,
		r_PtxU64Register401, r_PtxU64Register402, r_PtxU64Register403, r_PtxU64Register404,
		r_PtxU64Register405, r_PtxU64Register406, r_PtxU64Register407, r_PtxU64Register408;
	uint64_t r_PtxU64Register409, r_PtxU64Register410;
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
	r_PtxRegister181 = uint32_t(r_Scalar36Bits) + uint32_t(-1);					  // PTX L22
	r_PtxRegister182 = ShiftRightSigned(int32_t(r_PtxRegister181), uint32_t(31)); // PTX L23
	r_PtxRegister183 = ShiftRight(uint32_t(r_PtxRegister182), uint32_t(29));	  // PTX L24
	r_PtxRegister184 = uint32_t(r_PtxRegister181) + uint32_t(r_PtxRegister183);	  // PTX L25
	r_PtxRegister185 = ShiftRightSigned(int32_t(r_PtxRegister184), uint32_t(3));  // PTX L26
	r_PtxRegister186 = uint32_t(r_PtxRegister185) + uint32_t(1);				  // PTX L27
	r_PtxRegister2 = uint32_t(int32_t(r_CtaX) / int32_t(r_PtxRegister186));		  // PTX L28
	r_PtxRegister187 =
		uint32_t(r_PtxRegister2) * uint32_t(r_PtxRegister185) + uint32_t(r_PtxRegister2); // PTX L29
	r_PtxRegister188 = uint32_t(r_CtaX) - uint32_t(r_PtxRegister187);					  // PTX L30
	r_PtxRegister3 = ShiftLeft(uint32_t(r_CtaY), uint32_t(1));							  // PTX L31
	r_PtxRegister4 = ShiftLeft(uint32_t(r_PtxRegister188), uint32_t(3));				  // PTX L32
	r_PtxRegister5 = ShiftLeft(uint32_t(r_PtxRegister188), uint32_t(1));				  // PTX L33
	r_PtxRegister189 = ShiftRightSigned(int32_t(r_Scalar32Bits), uint32_t(31));			  // PTX L34
	r_PtxRegister190 = ShiftRight(uint32_t(r_PtxRegister189), uint32_t(30));			  // PTX L35
	r_PtxRegister191 = uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister190);			  // PTX L36
	r_PtxRegister6 = ShiftRightSigned(int32_t(r_PtxRegister191), uint32_t(2));			  // PTX L37
	r_PtxRegister192 = ShiftRightSigned(int32_t(r_Scalar36Bits), uint32_t(31));			  // PTX L38
	r_PtxRegister193 = ShiftRight(uint32_t(r_PtxRegister192), uint32_t(30));			  // PTX L39
	r_PtxRegister194 = uint32_t(r_Scalar36Bits) + uint32_t(r_PtxRegister193);			  // PTX L40
	r_PtxRegister7 = ShiftRightSigned(int32_t(r_PtxRegister194), uint32_t(2));			  // PTX L41
	r_ThreadX = uint32_t(threadIdx.x);													  // PTX L42
	r_ThreadYAtPtx43 = uint32_t(threadIdx.y);											  // PTX L43
	r_PtxRegister196 = r_ThreadX | r_ThreadYAtPtx43;									  // PTX L44
	r_bPtxPredicate16 = uint32_t(r_PtxRegister196) != uint32_t(0);						  // PTX L45
	if (r_bPtxPredicate16)
	{
		goto L__BB34_2;
	} // PTX L46
	r_BlockSizeX = uint32_t(blockDim.x);										 // PTX L47
	r_BlockSizeY = uint32_t(blockDim.y);										 // PTX L48
	r_PtxRegister198 = uint32_t(r_BlockSizeX) * uint32_t(r_BlockSizeY);			 // PTX L49
	r_PtxRegister197 = uint32_t(12288u /* exact native shared-region offset */); // PTX L50
	// Phase: shared_pipeline_setup. Initialize the original CTA-shared barrier state. Arrival counts and synchronization remain unchanged.
	BarrierInit(s_SharedStorage, r_PtxRegister197, r_PtxRegister198); // PTX L52
	r_PtxRegister199 = uint32_t(r_PtxRegister197) + uint32_t(8);	  // PTX L54
	BarrierInit(s_SharedStorage, r_PtxRegister199, r_PtxRegister198); // PTX L56
	r_PtxRegister200 = uint32_t(r_PtxRegister197) + uint32_t(16);	  // PTX L58
	BarrierInit(s_SharedStorage, r_PtxRegister200, r_PtxRegister198); // PTX L60
L__BB34_2:															  // PTX L62
	// Phase: cta_rendezvous. CTA rendezvous retained at the original control-flow boundary before subsequent shared-memory work.
	__syncthreads();																			// PTX L63
	r_Float32BitsAtPtx64R203 = uint32_t(0);														// PTX L64
	r_PackedHalf2AtPtx66R320 = FloatToHalf2(r_Float32BitsAtPtx64R203);							// PTX L66
	r_PtxRegister212 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(6));						// PTX L71
	r_PtxRegister213 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));						// PTX L72
	r_PtxRegister214 = uint32_t(r_PtxRegister212) + uint32_t(r_PtxRegister213);					// PTX L73
	r_PtxRegister215 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(17));						// PTX L74
	r_PtxRegister9 = ShiftLeft(uint32_t(r_PtxRegister214), uint32_t(3));						// PTX L75
	r_PtxRegister216 = uint32_t(r_PtxRegister215) + uint32_t(r_PtxRegister9);					// PTX L76
	r_PtxU64Register14 = uint64_t(int64_t(int32_t(r_PtxRegister216)) * int64_t(int32_t(4)));	// PTX L77
	r_PtxU64Register15 = uint64_t(r_Pointer24Bits) + uint64_t(r_PtxU64Register14);				// PTX L78
	r_LaneIndexAtPtx80 = uint32_t((threadIdx.x & 31u));											// PTX L80
	r_PtxU64Register16 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx80)) * int64_t(int32_t(16))); // PTX L82
	r_PtxU64Register6 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register16);			// PTX L83
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register6));
		r_MmaBHalf2WordAtPtx85R2733 = r_Value.x;
		r_MmaBHalf2WordAtPtx85R2732 = r_Value.y;
		r_MmaBHalf2WordAtPtx85R2731 = r_Value.z;
		r_MmaBHalf2WordAtPtx85R2730 = r_Value.w;
	} // PTX L85
	r_PtxRegister10 = r_PtxRegister9 | 128;														// PTX L87
	r_LaneIndexAtPtx89 = uint32_t((threadIdx.x & 31u));											// PTX L89
	r_PtxU64Register17 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx89)) * int64_t(int32_t(16))); // PTX L91
	r_PtxU64Register18 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register17);			// PTX L92
	r_PtxU64Register7 = uint64_t(r_PtxU64Register18) + uint64_t(512);							// PTX L93
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register7));
		r_MmaBHalf2WordAtPtx95R2729 = r_Value.x;
		r_MmaBHalf2WordAtPtx95R2728 = r_Value.y;
		r_MmaBHalf2WordAtPtx95R2727 = r_Value.z;
		r_MmaBHalf2WordAtPtx95R2726 = r_Value.w;
	} // PTX L95
	r_PtxRegister11 = r_PtxRegister9 | 256;														// PTX L97
	r_LaneIndexAtPtx99 = uint32_t((threadIdx.x & 31u));											// PTX L99
	r_PtxU64Register19 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx99)) * int64_t(int32_t(16))); // PTX L101
	r_PtxU64Register20 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register19);			// PTX L102
	r_PtxU64Register8 = uint64_t(r_PtxU64Register20) + uint64_t(1024);							// PTX L103
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register8));
		r_MmaBHalf2WordAtPtx105R2725 = r_Value.x;
		r_MmaBHalf2WordAtPtx105R2724 = r_Value.y;
		r_MmaBHalf2WordAtPtx105R2723 = r_Value.z;
		r_MmaBHalf2WordAtPtx105R2722 = r_Value.w;
	} // PTX L105
	r_PtxRegister12 = r_PtxRegister9 | 384;														 // PTX L107
	r_LaneIndexAtPtx109 = uint32_t((threadIdx.x & 31u));										 // PTX L109
	r_PtxU64Register21 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx109)) * int64_t(int32_t(16))); // PTX L111
	r_PtxU64Register22 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register21);			 // PTX L112
	r_PtxU64Register9 = uint64_t(r_PtxU64Register22) + uint64_t(1536);							 // PTX L113
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register9));
		r_MmaBHalf2WordAtPtx115R2721 = r_Value.x;
		r_MmaBHalf2WordAtPtx115R2720 = r_Value.y;
		r_MmaBHalf2WordAtPtx115R2719 = r_Value.z;
		r_MmaBHalf2WordAtPtx115R2718 = r_Value.w;
	} // PTX L115
	r_LaneIndexAtPtx118 = uint32_t((threadIdx.x & 31u));										 // PTX L118
	r_PtxU64Register23 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx118)) * int64_t(int32_t(16))); // PTX L120
	r_PtxU64Register24 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register23);			 // PTX L121
	r_PtxU64Register10 = uint64_t(r_PtxU64Register24) + uint64_t(16384);						 // PTX L122
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register10));
		r_MmaBHalf2WordAtPtx124R2717 = r_Value.x;
		r_MmaBHalf2WordAtPtx124R2716 = r_Value.y;
		r_MmaBHalf2WordAtPtx124R2715 = r_Value.z;
		r_MmaBHalf2WordAtPtx124R2714 = r_Value.w;
	} // PTX L124
	r_LaneIndexAtPtx127 = uint32_t((threadIdx.x & 31u));										 // PTX L127
	r_PtxU64Register25 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx127)) * int64_t(int32_t(16))); // PTX L129
	r_PtxU64Register26 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register25);			 // PTX L130
	r_PtxU64Register11 = uint64_t(r_PtxU64Register26) + uint64_t(16896);						 // PTX L131
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register11));
		r_MmaBHalf2WordAtPtx133R2713 = r_Value.x;
		r_MmaBHalf2WordAtPtx133R2712 = r_Value.y;
		r_MmaBHalf2WordAtPtx133R2711 = r_Value.z;
		r_MmaBHalf2WordAtPtx133R2710 = r_Value.w;
	} // PTX L133
	r_LaneIndexAtPtx136 = uint32_t((threadIdx.x & 31u));										 // PTX L136
	r_PtxU64Register27 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx136)) * int64_t(int32_t(16))); // PTX L138
	r_PtxU64Register28 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register27);			 // PTX L139
	r_PtxU64Register12 = uint64_t(r_PtxU64Register28) + uint64_t(17408);						 // PTX L140
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register12));
		r_MmaBHalf2WordAtPtx142R2709 = r_Value.x;
		r_MmaBHalf2WordAtPtx142R2708 = r_Value.y;
		r_MmaBHalf2WordAtPtx142R2707 = r_Value.z;
		r_MmaBHalf2WordAtPtx142R2706 = r_Value.w;
	} // PTX L142
	r_LaneIndexAtPtx145 = uint32_t((threadIdx.x & 31u));										 // PTX L145
	r_PtxU64Register29 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx145)) * int64_t(int32_t(16))); // PTX L147
	r_PtxU64Register30 = uint64_t(r_PtxU64Register15) + uint64_t(r_PtxU64Register29);			 // PTX L148
	r_PtxU64Register13 = uint64_t(r_PtxU64Register30) + uint64_t(17920);						 // PTX L149
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register13));
		r_MmaBHalf2WordAtPtx151R2705 = r_Value.x;
		r_MmaBHalf2WordAtPtx151R2704 = r_Value.y;
		r_MmaBHalf2WordAtPtx151R2703 = r_Value.z;
		r_MmaBHalf2WordAtPtx151R2702 = r_Value.w;
	} // PTX L151
	r_PtxRegister13 = r_ThreadYAtPtx43 & 1;									  // PTX L153
	r_PtxRegister217 = ShiftRight(uint32_t(r_ThreadYAtPtx43), uint32_t(1));	  // PTX L154
	r_PtxRegister218 = r_PtxRegister217 & 1;								  // PTX L155
	r_PtxRegister219 = ShiftRight(uint32_t(r_ThreadYAtPtx43), uint32_t(2));	  // PTX L156
	r_PtxRegister220 = ShiftLeft(uint32_t(r_PtxRegister219), uint32_t(9));	  // PTX L157
	r_PtxRegister221 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(7));	  // PTX L158
	r_PtxRegister14 = r_PtxRegister221 & 256;								  // PTX L159
	r_PtxRegister222 = r_PtxRegister220 | r_PtxRegister14;					  // PTX L160
	r_PtxRegister15 = r_PtxRegister221 & 128;								  // PTX L161
	r_PtxRegister16 = r_PtxRegister222 | r_PtxRegister15;					  // PTX L162
	r_PtxRegister223 = uint32_t(r_PtxRegister219) + uint32_t(r_PtxRegister3); // PTX L163
	r_PtxRegister17 = uint32_t(r_PtxRegister218) + uint32_t(r_PtxRegister5);  // PTX L164
	r_PtxRegister18 = r_Scalar32Bits & -4;									  // PTX L165
	r_bPtxPredicate17 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L166
	r_bPtxPredicate18 = int32_t(r_PtxRegister223) < int32_t(r_PtxRegister6);  // PTX L167
	r_PtxRegister224 = uint32_t(r_PtxRegister223) * uint32_t(r_PtxRegister7); // PTX L168
	r_PtxRegister19 = r_bPtxPredicate17 ? 0 : r_PtxRegister224;				  // PTX L169
	r_bPtxPredicate1 = r_bPtxPredicate17 | r_bPtxPredicate18;				  // PTX L170
	r_bPtxPredicate476 = bool(0);											  // PTX L171
	r_bPtxPredicate19 = !r_bPtxPredicate1;									  // PTX L172
	r_PtxRegister2567 = uint32_t(r_PtxRegister17);							  // PTX L173
	if (r_bPtxPredicate19)
	{
		goto L__BB34_5;
	} // PTX L174
	r_PtxRegister225 = r_Scalar36Bits & -4;						   // PTX L175
	r_bPtxPredicate20 = uint32_t(r_PtxRegister225) == uint32_t(4); // PTX L176
	r_bPtxPredicate476 = bool(-1);								   // PTX L177
	r_PtxRegister2567 = uint32_t(0);							   // PTX L178
	if (r_bPtxPredicate20)
	{
		goto L__BB34_5;
	} // PTX L179
	r_bPtxPredicate476 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L180
	r_PtxRegister2567 = uint32_t(r_PtxRegister17);							 // PTX L181
L__BB34_5:																	 // PTX L182
	r_PtxU64Register395 = uint64_t(0);										 // PTX L183
	r_bPtxPredicate21 = !r_bPtxPredicate476;								 // PTX L184
	if (r_bPtxPredicate21)
	{
		goto L__BB34_7;
	} // PTX L185
	r_PtxRegister226 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister2567); // PTX L186
	r_PtxRegister227 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister226);	// PTX L187
	r_PtxRegister228 = ShiftLeft(uint32_t(r_PtxRegister227), uint32_t(12));		// PTX L188
	r_PtxRegister229 = r_PtxRegister228 | r_PtxRegister15;						// PTX L189
	r_PtxU64Register395 = SignExtendWordBits(r_PtxRegister229);					// PTX L190
L__BB34_7:																		// PTX L191
	r_PtxU64Register396 = uint64_t(0);											// PTX L192
	if (r_bPtxPredicate21)
	{
		goto L__BB34_9;
	} // PTX L193
	r_PtxU64Register31 = ShiftLeft(uint64_t(r_PtxU64Register395), uint32_t(2));	   // PTX L194
	r_PtxU64Register396 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register31); // PTX L195
L__BB34_9:																		   // PTX L196
	r_PtxRegister230 = ShiftLeft(uint32_t(r_PtxRegister16), uint32_t(2));		   // PTX L197
	r_PtxRegister231 = uint32_t(0u /* exact native shared-region offset */);	   // PTX L198
	r_PtxRegister20 = uint32_t(r_PtxRegister231) + uint32_t(r_PtxRegister230);	   // PTX L199
	if (r_bPtxPredicate21)
	{
		goto L__BB34_12;
	} // PTX L200
	r_PtxRegister236 = uint32_t(-1);							   // PTX L201
	r_PtxRegister235 = Elected(r_PtxRegister236);				   // PTX L203
	r_bPtxPredicate22 = uint32_t(r_PtxRegister235) == uint32_t(0); // PTX L209
	if (r_bPtxPredicate22)
	{
		goto L__BB34_13;
	} // PTX L210
	r_PtxU64Register32 = r_PtxU64Register396;									 // PTX L211
	r_PtxRegister238 = uint32_t(12288u /* exact native shared-region offset */); // PTX L212
	r_PtxRegister237 = uint32_t(512);											 // PTX L213
	// Phase: asynchronous_staging. Begin asynchronous global-to-shared staging. Keep the surrounding predicates, fill path and wait protocol together.
	CopyBulk(s_SharedStorage, r_PtxRegister20, r_PtxU64Register32, r_PtxRegister237,
			 r_PtxRegister238);												   // PTX L215
	BarrierExpect(s_SharedStorage, r_PtxRegister238, r_PtxRegister237);		   // PTX L218
	goto L__BB34_13;														   // PTX L220
L__BB34_12:																	   // PTX L221
	r_LaneIndexAtPtx223 = uint32_t((threadIdx.x & 31u));					   // PTX L223
	r_PtxRegister234 = ShiftLeft(uint32_t(r_LaneIndexAtPtx223), uint32_t(4));  // PTX L225
	r_PtxRegister233 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister234); // PTX L226
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister233)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);								  // PTX L228
L__BB34_13:																	  // PTX L230
	r_bPtxPredicate23 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L231
	r_PtxRegister239 = uint32_t(r_ThreadYAtPtx43) + uint32_t(4);			  // PTX L232
	r_PtxRegister240 = ShiftRight(uint32_t(r_PtxRegister239), uint32_t(2));	  // PTX L233
	r_PtxRegister241 = ShiftLeft(uint32_t(r_PtxRegister240), uint32_t(9));	  // PTX L234
	r_PtxRegister242 = r_PtxRegister241 | r_PtxRegister14;					  // PTX L235
	r_PtxRegister21 = uint32_t(r_PtxRegister242) + uint32_t(r_PtxRegister15); // PTX L236
	r_PtxRegister243 = uint32_t(r_PtxRegister240) + uint32_t(r_PtxRegister3); // PTX L237
	r_bPtxPredicate24 = int32_t(r_PtxRegister243) < int32_t(r_PtxRegister6);  // PTX L238
	r_PtxRegister244 = uint32_t(r_PtxRegister243) * uint32_t(r_PtxRegister7); // PTX L239
	r_PtxRegister22 = r_bPtxPredicate23 ? 0 : r_PtxRegister244;				  // PTX L240
	r_bPtxPredicate2 = r_bPtxPredicate23 | r_bPtxPredicate24;				  // PTX L241
	r_bPtxPredicate477 = bool(0);											  // PTX L242
	r_bPtxPredicate25 = !r_bPtxPredicate2;									  // PTX L243
	r_PtxRegister2568 = uint32_t(r_PtxRegister17);							  // PTX L244
	if (r_bPtxPredicate25)
	{
		goto L__BB34_16;
	} // PTX L245
	r_PtxRegister245 = r_Scalar36Bits & -4;						   // PTX L246
	r_bPtxPredicate26 = uint32_t(r_PtxRegister245) == uint32_t(4); // PTX L247
	r_bPtxPredicate477 = bool(-1);								   // PTX L248
	r_PtxRegister2568 = uint32_t(0);							   // PTX L249
	if (r_bPtxPredicate26)
	{
		goto L__BB34_16;
	} // PTX L250
	r_bPtxPredicate477 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L251
	r_PtxRegister2568 = uint32_t(r_PtxRegister17);							 // PTX L252
L__BB34_16:																	 // PTX L253
	r_PtxU64Register397 = uint64_t(0);										 // PTX L254
	r_bPtxPredicate27 = !r_bPtxPredicate477;								 // PTX L255
	if (r_bPtxPredicate27)
	{
		goto L__BB34_18;
	} // PTX L256
	r_PtxRegister246 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister2568); // PTX L257
	r_PtxRegister247 = uint32_t(r_CtaZAtPtx21) + uint32_t(r_PtxRegister246);	// PTX L258
	r_PtxRegister248 = ShiftLeft(uint32_t(r_PtxRegister247), uint32_t(12));		// PTX L259
	r_PtxRegister249 = r_PtxRegister248 | r_PtxRegister15;						// PTX L260
	r_PtxU64Register397 = SignExtendWordBits(r_PtxRegister249);					// PTX L261
L__BB34_18:																		// PTX L262
	r_PtxU64Register398 = uint64_t(0);											// PTX L263
	if (r_bPtxPredicate27)
	{
		goto L__BB34_20;
	} // PTX L264
	r_PtxU64Register33 = ShiftLeft(uint64_t(r_PtxU64Register397), uint32_t(2));	   // PTX L265
	r_PtxU64Register398 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register33); // PTX L266
L__BB34_20:																		   // PTX L267
	r_PtxRegister250 = ShiftLeft(uint32_t(r_PtxRegister21), uint32_t(2));		   // PTX L268
	r_PtxRegister251 = uint32_t(0u /* exact native shared-region offset */);	   // PTX L269
	r_PtxRegister23 = uint32_t(r_PtxRegister251) + uint32_t(r_PtxRegister250);	   // PTX L270
	if (r_bPtxPredicate27)
	{
		goto L__BB34_23;
	} // PTX L271
	r_PtxRegister256 = uint32_t(-1);							   // PTX L272
	r_PtxRegister255 = Elected(r_PtxRegister256);				   // PTX L274
	r_bPtxPredicate28 = uint32_t(r_PtxRegister255) == uint32_t(0); // PTX L280
	if (r_bPtxPredicate28)
	{
		goto L__BB34_24;
	} // PTX L281
	r_PtxU64Register34 = r_PtxU64Register398;									 // PTX L282
	r_PtxRegister258 = uint32_t(12288u /* exact native shared-region offset */); // PTX L283
	r_PtxRegister257 = uint32_t(512);											 // PTX L284
	CopyBulk(s_SharedStorage, r_PtxRegister23, r_PtxU64Register34, r_PtxRegister257,
			 r_PtxRegister258);												   // PTX L286
	BarrierExpect(s_SharedStorage, r_PtxRegister258, r_PtxRegister257);		   // PTX L289
	goto L__BB34_24;														   // PTX L291
L__BB34_23:																	   // PTX L292
	r_LaneIndexAtPtx294 = uint32_t((threadIdx.x & 31u));					   // PTX L294
	r_PtxRegister254 = ShiftLeft(uint32_t(r_LaneIndexAtPtx294), uint32_t(4));  // PTX L296
	r_PtxRegister253 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister254); // PTX L297
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister253)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);							// PTX L299
L__BB34_24:																// PTX L301
	r_PtxRegister259 = ShiftLeft(uint32_t(r_CtaZAtPtx21), uint32_t(9)); // PTX L302
	r_PtxRegister24 = r_PtxRegister259 | 32;							// PTX L303
	r_bPtxPredicate478 = bool(0);										// PTX L304
	r_PtxRegister2569 = uint32_t(r_PtxRegister17);						// PTX L305
	if (r_bPtxPredicate19)
	{
		goto L__BB34_27;
	} // PTX L306
	r_PtxRegister260 = r_Scalar36Bits & -4;						   // PTX L307
	r_bPtxPredicate29 = uint32_t(r_PtxRegister260) == uint32_t(4); // PTX L308
	r_bPtxPredicate478 = bool(-1);								   // PTX L309
	r_PtxRegister2569 = uint32_t(0);							   // PTX L310
	if (r_bPtxPredicate29)
	{
		goto L__BB34_27;
	} // PTX L311
	r_bPtxPredicate478 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L312
	r_PtxRegister2569 = uint32_t(r_PtxRegister17);							 // PTX L313
L__BB34_27:																	 // PTX L314
	r_PtxU64Register399 = uint64_t(0);										 // PTX L315
	r_bPtxPredicate30 = !r_bPtxPredicate478;								 // PTX L316
	if (r_bPtxPredicate30)
	{
		goto L__BB34_29;
	} // PTX L317
	r_PtxRegister261 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister2569); // PTX L318
	r_PtxRegister262 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(4));		// PTX L319
	r_PtxRegister263 = uint32_t(r_PtxRegister262) + uint32_t(r_PtxRegister13);	// PTX L320
	r_PtxRegister264 = ShiftLeft(uint32_t(r_PtxRegister261), uint32_t(12));		// PTX L321
	r_PtxRegister265 = ShiftLeft(uint32_t(r_PtxRegister263), uint32_t(7));		// PTX L322
	r_PtxRegister266 = uint32_t(r_PtxRegister264) + uint32_t(r_PtxRegister265); // PTX L323
	r_PtxU64Register399 = SignExtendWordBits(r_PtxRegister266);					// PTX L324
L__BB34_29:																		// PTX L325
	r_PtxU64Register400 = uint64_t(0);											// PTX L326
	if (r_bPtxPredicate30)
	{
		goto L__BB34_31;
	} // PTX L327
	r_PtxU64Register35 = ShiftLeft(uint64_t(r_PtxU64Register399), uint32_t(2));	   // PTX L328
	r_PtxU64Register400 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register35); // PTX L329
L__BB34_31:																		   // PTX L330
	if (r_bPtxPredicate30)
	{
		goto L__BB34_34;
	} // PTX L331
	r_PtxRegister272 = uint32_t(-1);							   // PTX L332
	r_PtxRegister271 = Elected(r_PtxRegister272);				   // PTX L334
	r_bPtxPredicate31 = uint32_t(r_PtxRegister271) == uint32_t(0); // PTX L340
	if (r_bPtxPredicate31)
	{
		goto L__BB34_35;
	} // PTX L341
	r_PtxRegister273 = uint32_t(r_PtxRegister20) + uint32_t(4096);				 // PTX L342
	r_PtxU64Register36 = r_PtxU64Register400;									 // PTX L343
	r_PtxRegister276 = uint32_t(12288u /* exact native shared-region offset */); // PTX L344
	r_PtxRegister275 = uint32_t(r_PtxRegister276) + uint32_t(8);				 // PTX L345
	r_PtxRegister274 = uint32_t(512);											 // PTX L346
	CopyBulk(s_SharedStorage, r_PtxRegister273, r_PtxU64Register36, r_PtxRegister274,
			 r_PtxRegister275);												   // PTX L348
	BarrierExpect(s_SharedStorage, r_PtxRegister275, r_PtxRegister274);		   // PTX L351
	goto L__BB34_35;														   // PTX L353
L__BB34_34:																	   // PTX L354
	r_LaneIndexAtPtx356 = uint32_t((threadIdx.x & 31u));					   // PTX L356
	r_PtxRegister269 = ShiftLeft(uint32_t(r_LaneIndexAtPtx356), uint32_t(4));  // PTX L358
	r_PtxRegister270 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister269); // PTX L359
	r_PtxRegister268 = uint32_t(r_PtxRegister270) + uint32_t(4096);			   // PTX L360
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister268)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);	   // PTX L362
L__BB34_35:										   // PTX L364
	r_bPtxPredicate479 = bool(0);				   // PTX L365
	r_PtxRegister2570 = uint32_t(r_PtxRegister17); // PTX L366
	if (r_bPtxPredicate25)
	{
		goto L__BB34_38;
	} // PTX L367
	r_PtxRegister277 = r_Scalar36Bits & -4;						   // PTX L368
	r_bPtxPredicate32 = uint32_t(r_PtxRegister277) == uint32_t(4); // PTX L369
	r_bPtxPredicate479 = bool(-1);								   // PTX L370
	r_PtxRegister2570 = uint32_t(0);							   // PTX L371
	if (r_bPtxPredicate32)
	{
		goto L__BB34_38;
	} // PTX L372
	r_bPtxPredicate479 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L373
	r_PtxRegister2570 = uint32_t(r_PtxRegister17);							 // PTX L374
L__BB34_38:																	 // PTX L375
	r_PtxU64Register401 = uint64_t(0);										 // PTX L376
	r_bPtxPredicate33 = !r_bPtxPredicate479;								 // PTX L377
	if (r_bPtxPredicate33)
	{
		goto L__BB34_40;
	} // PTX L378
	r_PtxRegister278 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister2570); // PTX L379
	r_PtxRegister279 = ShiftRight(uint32_t(r_PtxRegister24), uint32_t(4));		// PTX L380
	r_PtxRegister280 = uint32_t(r_PtxRegister279) + uint32_t(r_PtxRegister13);	// PTX L381
	r_PtxRegister281 = ShiftLeft(uint32_t(r_PtxRegister278), uint32_t(12));		// PTX L382
	r_PtxRegister282 = ShiftLeft(uint32_t(r_PtxRegister280), uint32_t(7));		// PTX L383
	r_PtxRegister283 = uint32_t(r_PtxRegister281) + uint32_t(r_PtxRegister282); // PTX L384
	r_PtxU64Register401 = SignExtendWordBits(r_PtxRegister283);					// PTX L385
L__BB34_40:																		// PTX L386
	r_PtxU64Register402 = uint64_t(0);											// PTX L387
	if (r_bPtxPredicate33)
	{
		goto L__BB34_42;
	} // PTX L388
	r_PtxU64Register37 = ShiftLeft(uint64_t(r_PtxU64Register401), uint32_t(2));	   // PTX L389
	r_PtxU64Register402 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register37); // PTX L390
L__BB34_42:																		   // PTX L391
	if (r_bPtxPredicate33)
	{
		goto L__BB34_45;
	} // PTX L392
	r_PtxRegister289 = uint32_t(-1);							   // PTX L393
	r_PtxRegister288 = Elected(r_PtxRegister289);				   // PTX L395
	r_bPtxPredicate34 = uint32_t(r_PtxRegister288) == uint32_t(0); // PTX L401
	if (r_bPtxPredicate34)
	{
		goto L__BB34_46;
	} // PTX L402
	r_PtxRegister290 = uint32_t(r_PtxRegister23) + uint32_t(4096);				 // PTX L403
	r_PtxU64Register38 = r_PtxU64Register402;									 // PTX L404
	r_PtxRegister293 = uint32_t(12288u /* exact native shared-region offset */); // PTX L405
	r_PtxRegister292 = uint32_t(r_PtxRegister293) + uint32_t(8);				 // PTX L406
	r_PtxRegister291 = uint32_t(512);											 // PTX L407
	CopyBulk(s_SharedStorage, r_PtxRegister290, r_PtxU64Register38, r_PtxRegister291,
			 r_PtxRegister292);												   // PTX L409
	BarrierExpect(s_SharedStorage, r_PtxRegister292, r_PtxRegister291);		   // PTX L412
	goto L__BB34_46;														   // PTX L414
L__BB34_45:																	   // PTX L415
	r_LaneIndexAtPtx417 = uint32_t((threadIdx.x & 31u));					   // PTX L417
	r_PtxRegister286 = ShiftLeft(uint32_t(r_LaneIndexAtPtx417), uint32_t(4));  // PTX L419
	r_PtxRegister287 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister286); // PTX L420
	r_PtxRegister285 = uint32_t(r_PtxRegister287) + uint32_t(4096);			   // PTX L421
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister285)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);					// PTX L423
L__BB34_46:														// PTX L425
	r_PtxRegister25 = uint32_t(r_PtxRegister24) + uint32_t(32); // PTX L426
	r_bPtxPredicate480 = bool(0);								// PTX L427
	r_PtxRegister2571 = uint32_t(r_PtxRegister17);				// PTX L428
	if (r_bPtxPredicate19)
	{
		goto L__BB34_49;
	} // PTX L429
	r_PtxRegister294 = r_Scalar36Bits & -4;						   // PTX L430
	r_bPtxPredicate35 = uint32_t(r_PtxRegister294) == uint32_t(4); // PTX L431
	r_bPtxPredicate480 = bool(-1);								   // PTX L432
	r_PtxRegister2571 = uint32_t(0);							   // PTX L433
	if (r_bPtxPredicate35)
	{
		goto L__BB34_49;
	} // PTX L434
	r_bPtxPredicate480 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L435
	r_PtxRegister2571 = uint32_t(r_PtxRegister17);							 // PTX L436
L__BB34_49:																	 // PTX L437
	r_PtxU64Register403 = uint64_t(0);										 // PTX L438
	r_bPtxPredicate36 = !r_bPtxPredicate480;								 // PTX L439
	if (r_bPtxPredicate36)
	{
		goto L__BB34_51;
	} // PTX L440
	r_PtxRegister295 = uint32_t(r_PtxRegister19) + uint32_t(r_PtxRegister2571); // PTX L441
	r_PtxRegister296 = ShiftRight(uint32_t(r_PtxRegister25), uint32_t(4));		// PTX L442
	r_PtxRegister297 = uint32_t(r_PtxRegister296) + uint32_t(r_PtxRegister13);	// PTX L443
	r_PtxRegister298 = ShiftLeft(uint32_t(r_PtxRegister295), uint32_t(12));		// PTX L444
	r_PtxRegister299 = ShiftLeft(uint32_t(r_PtxRegister297), uint32_t(7));		// PTX L445
	r_PtxRegister300 = uint32_t(r_PtxRegister298) + uint32_t(r_PtxRegister299); // PTX L446
	r_PtxU64Register403 = SignExtendWordBits(r_PtxRegister300);					// PTX L447
L__BB34_51:																		// PTX L448
	r_PtxU64Register404 = uint64_t(0);											// PTX L449
	if (r_bPtxPredicate36)
	{
		goto L__BB34_53;
	} // PTX L450
	r_PtxU64Register39 = ShiftLeft(uint64_t(r_PtxU64Register403), uint32_t(2));	   // PTX L451
	r_PtxU64Register404 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register39); // PTX L452
L__BB34_53:																		   // PTX L453
	if (r_bPtxPredicate36)
	{
		goto L__BB34_56;
	} // PTX L454
	r_PtxRegister306 = uint32_t(-1);							   // PTX L455
	r_PtxRegister305 = Elected(r_PtxRegister306);				   // PTX L457
	r_bPtxPredicate37 = uint32_t(r_PtxRegister305) == uint32_t(0); // PTX L463
	if (r_bPtxPredicate37)
	{
		goto L__BB34_57;
	} // PTX L464
	r_PtxRegister307 = uint32_t(r_PtxRegister20) + uint32_t(8192);				 // PTX L465
	r_PtxU64Register40 = r_PtxU64Register404;									 // PTX L466
	r_PtxRegister310 = uint32_t(12288u /* exact native shared-region offset */); // PTX L467
	r_PtxRegister309 = uint32_t(r_PtxRegister310) + uint32_t(16);				 // PTX L468
	r_PtxRegister308 = uint32_t(512);											 // PTX L469
	CopyBulk(s_SharedStorage, r_PtxRegister307, r_PtxU64Register40, r_PtxRegister308,
			 r_PtxRegister309);												   // PTX L471
	BarrierExpect(s_SharedStorage, r_PtxRegister309, r_PtxRegister308);		   // PTX L474
	goto L__BB34_57;														   // PTX L476
L__BB34_56:																	   // PTX L477
	r_LaneIndexAtPtx479 = uint32_t((threadIdx.x & 31u));					   // PTX L479
	r_PtxRegister303 = ShiftLeft(uint32_t(r_LaneIndexAtPtx479), uint32_t(4));  // PTX L481
	r_PtxRegister304 = uint32_t(r_PtxRegister20) + uint32_t(r_PtxRegister303); // PTX L482
	r_PtxRegister302 = uint32_t(r_PtxRegister304) + uint32_t(8192);			   // PTX L483
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister302)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);	   // PTX L485
L__BB34_57:										   // PTX L487
	r_bPtxPredicate481 = bool(0);				   // PTX L488
	r_PtxRegister2572 = uint32_t(r_PtxRegister17); // PTX L489
	if (r_bPtxPredicate25)
	{
		goto L__BB34_60;
	} // PTX L490
	r_PtxRegister311 = r_Scalar36Bits & -4;						   // PTX L491
	r_bPtxPredicate38 = uint32_t(r_PtxRegister311) == uint32_t(4); // PTX L492
	r_bPtxPredicate481 = bool(-1);								   // PTX L493
	r_PtxRegister2572 = uint32_t(0);							   // PTX L494
	if (r_bPtxPredicate38)
	{
		goto L__BB34_60;
	} // PTX L495
	r_bPtxPredicate481 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7); // PTX L496
	r_PtxRegister2572 = uint32_t(r_PtxRegister17);							 // PTX L497
L__BB34_60:																	 // PTX L498
	r_PtxU64Register405 = uint64_t(0);										 // PTX L499
	r_bPtxPredicate39 = !r_bPtxPredicate481;								 // PTX L500
	if (r_bPtxPredicate39)
	{
		goto L__BB34_62;
	} // PTX L501
	r_PtxRegister312 = uint32_t(r_PtxRegister22) + uint32_t(r_PtxRegister2572); // PTX L502
	r_PtxRegister313 = ShiftRight(uint32_t(r_PtxRegister25), uint32_t(4));		// PTX L503
	r_PtxRegister314 = uint32_t(r_PtxRegister313) + uint32_t(r_PtxRegister13);	// PTX L504
	r_PtxRegister315 = ShiftLeft(uint32_t(r_PtxRegister312), uint32_t(12));		// PTX L505
	r_PtxRegister316 = ShiftLeft(uint32_t(r_PtxRegister314), uint32_t(7));		// PTX L506
	r_PtxRegister317 = uint32_t(r_PtxRegister315) + uint32_t(r_PtxRegister316); // PTX L507
	r_PtxU64Register405 = SignExtendWordBits(r_PtxRegister317);					// PTX L508
L__BB34_62:																		// PTX L509
	r_PtxU64Register406 = uint64_t(0);											// PTX L510
	if (r_bPtxPredicate39)
	{
		goto L__BB34_64;
	} // PTX L511
	r_PtxU64Register41 = ShiftLeft(uint64_t(r_PtxU64Register405), uint32_t(2));	   // PTX L512
	r_PtxU64Register406 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register41); // PTX L513
L__BB34_64:																		   // PTX L514
	if (r_bPtxPredicate39)
	{
		goto L__BB34_67;
	} // PTX L515
	r_PtxRegister324 = uint32_t(-1);							   // PTX L516
	r_PtxRegister323 = Elected(r_PtxRegister324);				   // PTX L518
	r_bPtxPredicate40 = uint32_t(r_PtxRegister323) == uint32_t(0); // PTX L524
	if (r_bPtxPredicate40)
	{
		goto L__BB34_68;
	} // PTX L525
	r_PtxRegister325 = uint32_t(r_PtxRegister23) + uint32_t(8192);				 // PTX L526
	r_PtxU64Register42 = r_PtxU64Register406;									 // PTX L527
	r_PtxRegister328 = uint32_t(12288u /* exact native shared-region offset */); // PTX L528
	r_PtxRegister327 = uint32_t(r_PtxRegister328) + uint32_t(16);				 // PTX L529
	r_PtxRegister326 = uint32_t(512);											 // PTX L530
	CopyBulk(s_SharedStorage, r_PtxRegister325, r_PtxU64Register42, r_PtxRegister326,
			 r_PtxRegister327);												   // PTX L532
	BarrierExpect(s_SharedStorage, r_PtxRegister327, r_PtxRegister326);		   // PTX L535
	goto L__BB34_68;														   // PTX L537
L__BB34_67:																	   // PTX L538
	r_LaneIndexAtPtx540 = uint32_t((threadIdx.x & 31u));					   // PTX L540
	r_PtxRegister321 = ShiftLeft(uint32_t(r_LaneIndexAtPtx540), uint32_t(4));  // PTX L542
	r_PtxRegister322 = uint32_t(r_PtxRegister23) + uint32_t(r_PtxRegister321); // PTX L543
	r_PtxRegister319 = uint32_t(r_PtxRegister322) + uint32_t(8192);			   // PTX L544
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister319)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);									 // PTX L546
L__BB34_68:																		 // PTX L548
	r_PtxRegister329 = uint32_t(12288u /* exact native shared-region offset */); // PTX L549
	r_PtxRegister330 = uint32_t(1);												 // PTX L550
	// Phase: shared_stage_readiness. Shared-stage readiness protocol: preserve the original arrival token, polling condition and consumer order.
	r_PtxU64Register43 = BarrierArrive(s_SharedStorage, r_PtxRegister329, r_PtxRegister330); // PTX L552
L__BB34_69:																					 // PTX L554
	r_PtxRegister332 = uint32_t(12288u /* exact native shared-region offset */);			 // PTX L555
	r_PtxRegister331 = BarrierReady(s_SharedStorage, r_PtxRegister332, r_PtxU64Register43);	 // PTX L557
	r_bPtxPredicate41 = uint32_t(r_PtxRegister331) == uint32_t(0);							 // PTX L563
	if (r_bPtxPredicate41)
	{
		goto L__BB34_69;
	} // PTX L564
	r_bPtxPredicate3 = uint32_t(r_PtxRegister18) != uint32_t(4);			// PTX L565
	r_bPtxPredicate42 = uint32_t(r_PtxRegister18) == uint32_t(4);			// PTX L566
	r_PtxRegister26 = r_Scalar36Bits & -4;									// PTX L567
	r_bPtxPredicate43 = uint32_t(r_PtxRegister26) == uint32_t(4);			// PTX L568
	r_bPtxPredicate44 = int32_t(r_PtxRegister3) < int32_t(r_PtxRegister6);	// PTX L569
	r_bPtxPredicate45 = int32_t(r_PtxRegister3) >= int32_t(r_PtxRegister6); // PTX L570
	r_PtxRegister27 = uint32_t(r_PtxRegister3) * uint32_t(r_PtxRegister7);	// PTX L571
	r_PtxRegister28 = r_bPtxPredicate42 ? 0 : r_PtxRegister27;				// PTX L572
	r_bPtxPredicate46 = r_bPtxPredicate3 & r_bPtxPredicate45;				// PTX L573
	r_bPtxPredicate4 = r_bPtxPredicate42 | r_bPtxPredicate44;				// PTX L574
	r_bPtxPredicate5 = r_bPtxPredicate46 | r_bPtxPredicate43;				// PTX L575
	r_bPtxPredicate47 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);	// PTX L576
	r_bPtxPredicate48 = !r_bPtxPredicate46;									// PTX L577
	r_bPtxPredicate6 = r_bPtxPredicate43 & r_bPtxPredicate48;				// PTX L578
	r_PtxRegister29 = r_bPtxPredicate6 ? 0 : r_PtxRegister5;				// PTX L579
	r_bPtxPredicate49 = r_bPtxPredicate5 | r_bPtxPredicate47;				// PTX L580
	r_bPtxPredicate7 = r_bPtxPredicate49 & r_bPtxPredicate4;				// PTX L581
	r_bPtxPredicate50 = !r_bPtxPredicate7;									// PTX L582
	r_PackedHalf2AtPtx583R2573 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L583
	r_PackedHalf2AtPtx584R2574 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L584
	r_PackedHalf2AtPtx585R2575 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L585
	r_PackedHalf2AtPtx586R2576 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L586
	if (r_bPtxPredicate50)
	{
		goto L__BB34_72;
	} // PTX L587
	r_PtxRegister334 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);					 // PTX L588
	r_PtxRegister335 = ShiftLeft(uint32_t(r_PtxRegister334), uint32_t(12));						 // PTX L589
	r_PtxRegister336 = uint32_t(r_PtxRegister335) + uint32_t(r_PtxRegister9);					 // PTX L590
	r_PtxU64Register45 = uint64_t(int64_t(int32_t(r_PtxRegister336)) * int64_t(int32_t(4)));	 // PTX L591
	r_PtxU64Register46 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register45);				 // PTX L592
	r_LaneIndexAtPtx594 = uint32_t((threadIdx.x & 31u));										 // PTX L594
	r_PtxU64Register47 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx594)) * int64_t(int32_t(16))); // PTX L596
	r_PtxU64Register44 = uint64_t(r_PtxU64Register46) + uint64_t(r_PtxU64Register47);			 // PTX L597
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register44));
		r_PackedHalf2AtPtx583R2573 = r_Value.x;
		r_PackedHalf2AtPtx584R2574 = r_Value.y;
		r_PackedHalf2AtPtx585R2575 = r_Value.z;
		r_PackedHalf2AtPtx586R2576 = r_Value.w;
	} // PTX L599
L__BB34_72:															 // PTX L601
	r_PackedHalf2AtPtx602R2577 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L602
	r_PackedHalf2AtPtx603R2578 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L603
	r_PackedHalf2AtPtx604R2579 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L604
	r_PackedHalf2AtPtx605R2580 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L605
	if (r_bPtxPredicate50)
	{
		goto L__BB34_74;
	} // PTX L606
	r_PtxRegister338 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);					 // PTX L607
	r_PtxRegister339 = ShiftLeft(uint32_t(r_PtxRegister338), uint32_t(12));						 // PTX L608
	r_PtxRegister340 = uint32_t(r_PtxRegister339) + uint32_t(r_PtxRegister10);					 // PTX L609
	r_PtxU64Register49 = uint64_t(int64_t(int32_t(r_PtxRegister340)) * int64_t(int32_t(4)));	 // PTX L610
	r_PtxU64Register50 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register49);				 // PTX L611
	r_LaneIndexAtPtx613 = uint32_t((threadIdx.x & 31u));										 // PTX L613
	r_PtxU64Register51 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx613)) * int64_t(int32_t(16))); // PTX L615
	r_PtxU64Register48 = uint64_t(r_PtxU64Register50) + uint64_t(r_PtxU64Register51);			 // PTX L616
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register48));
		r_PackedHalf2AtPtx602R2577 = r_Value.x;
		r_PackedHalf2AtPtx603R2578 = r_Value.y;
		r_PackedHalf2AtPtx604R2579 = r_Value.z;
		r_PackedHalf2AtPtx605R2580 = r_Value.w;
	} // PTX L618
L__BB34_74:															 // PTX L620
	r_PackedHalf2AtPtx621R2581 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L621
	r_PackedHalf2AtPtx622R2582 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L622
	r_PackedHalf2AtPtx623R2583 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L623
	r_PackedHalf2AtPtx624R2584 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L624
	if (r_bPtxPredicate50)
	{
		goto L__BB34_76;
	} // PTX L625
	r_PtxRegister342 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);					 // PTX L626
	r_PtxRegister343 = ShiftLeft(uint32_t(r_PtxRegister342), uint32_t(12));						 // PTX L627
	r_PtxRegister344 = uint32_t(r_PtxRegister343) + uint32_t(r_PtxRegister11);					 // PTX L628
	r_PtxU64Register53 = uint64_t(int64_t(int32_t(r_PtxRegister344)) * int64_t(int32_t(4)));	 // PTX L629
	r_PtxU64Register54 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register53);				 // PTX L630
	r_LaneIndexAtPtx632 = uint32_t((threadIdx.x & 31u));										 // PTX L632
	r_PtxU64Register55 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx632)) * int64_t(int32_t(16))); // PTX L634
	r_PtxU64Register52 = uint64_t(r_PtxU64Register54) + uint64_t(r_PtxU64Register55);			 // PTX L635
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register52));
		r_PackedHalf2AtPtx621R2581 = r_Value.x;
		r_PackedHalf2AtPtx622R2582 = r_Value.y;
		r_PackedHalf2AtPtx623R2583 = r_Value.z;
		r_PackedHalf2AtPtx624R2584 = r_Value.w;
	} // PTX L637
L__BB34_76:															 // PTX L639
	r_PackedHalf2AtPtx640R2585 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L640
	r_PackedHalf2AtPtx641R2586 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L641
	r_PackedHalf2AtPtx642R2587 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L642
	r_PackedHalf2AtPtx643R2588 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L643
	if (r_bPtxPredicate50)
	{
		goto L__BB34_78;
	} // PTX L644
	r_PtxRegister346 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister29);					 // PTX L645
	r_PtxRegister347 = ShiftLeft(uint32_t(r_PtxRegister346), uint32_t(12));						 // PTX L646
	r_PtxRegister348 = uint32_t(r_PtxRegister347) + uint32_t(r_PtxRegister12);					 // PTX L647
	r_PtxU64Register57 = uint64_t(int64_t(int32_t(r_PtxRegister348)) * int64_t(int32_t(4)));	 // PTX L648
	r_PtxU64Register58 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register57);				 // PTX L649
	r_LaneIndexAtPtx651 = uint32_t((threadIdx.x & 31u));										 // PTX L651
	r_PtxU64Register59 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx651)) * int64_t(int32_t(16))); // PTX L653
	r_PtxU64Register56 = uint64_t(r_PtxU64Register58) + uint64_t(r_PtxU64Register59);			 // PTX L654
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register56));
		r_PackedHalf2AtPtx640R2585 = r_Value.x;
		r_PackedHalf2AtPtx641R2586 = r_Value.y;
		r_PackedHalf2AtPtx642R2587 = r_Value.z;
		r_PackedHalf2AtPtx643R2588 = r_Value.w;
	} // PTX L656
L__BB34_78:																	// PTX L658
	r_PtxRegister30 = uint32_t(r_PtxRegister5) + uint32_t(1);				// PTX L659
	r_bPtxPredicate51 = int32_t(r_PtxRegister30) < int32_t(r_PtxRegister7); // PTX L660
	r_PtxRegister31 = r_bPtxPredicate6 ? 0 : r_PtxRegister30;				// PTX L661
	r_bPtxPredicate52 = r_bPtxPredicate5 | r_bPtxPredicate51;				// PTX L662
	r_bPtxPredicate8 = r_bPtxPredicate52 & r_bPtxPredicate4;				// PTX L663
	r_bPtxPredicate53 = !r_bPtxPredicate8;									// PTX L664
	r_PackedHalf2AtPtx665R2589 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L665
	r_PackedHalf2AtPtx666R2590 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L666
	r_PackedHalf2AtPtx667R2591 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L667
	r_PackedHalf2AtPtx668R2592 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L668
	if (r_bPtxPredicate53)
	{
		goto L__BB34_80;
	} // PTX L669
	r_PtxRegister350 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);					 // PTX L670
	r_PtxRegister351 = ShiftLeft(uint32_t(r_PtxRegister350), uint32_t(12));						 // PTX L671
	r_PtxRegister352 = uint32_t(r_PtxRegister351) + uint32_t(r_PtxRegister9);					 // PTX L672
	r_PtxU64Register61 = uint64_t(int64_t(int32_t(r_PtxRegister352)) * int64_t(int32_t(4)));	 // PTX L673
	r_PtxU64Register62 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register61);				 // PTX L674
	r_LaneIndexAtPtx676 = uint32_t((threadIdx.x & 31u));										 // PTX L676
	r_PtxU64Register63 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx676)) * int64_t(int32_t(16))); // PTX L678
	r_PtxU64Register60 = uint64_t(r_PtxU64Register62) + uint64_t(r_PtxU64Register63);			 // PTX L679
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register60));
		r_PackedHalf2AtPtx665R2589 = r_Value.x;
		r_PackedHalf2AtPtx666R2590 = r_Value.y;
		r_PackedHalf2AtPtx667R2591 = r_Value.z;
		r_PackedHalf2AtPtx668R2592 = r_Value.w;
	} // PTX L681
L__BB34_80:															 // PTX L683
	r_PackedHalf2AtPtx684R2593 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L684
	r_PackedHalf2AtPtx685R2594 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L685
	r_PackedHalf2AtPtx686R2595 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L686
	r_PackedHalf2AtPtx687R2596 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L687
	if (r_bPtxPredicate53)
	{
		goto L__BB34_82;
	} // PTX L688
	r_PtxRegister354 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);					 // PTX L689
	r_PtxRegister355 = ShiftLeft(uint32_t(r_PtxRegister354), uint32_t(12));						 // PTX L690
	r_PtxRegister356 = uint32_t(r_PtxRegister355) + uint32_t(r_PtxRegister10);					 // PTX L691
	r_PtxU64Register65 = uint64_t(int64_t(int32_t(r_PtxRegister356)) * int64_t(int32_t(4)));	 // PTX L692
	r_PtxU64Register66 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register65);				 // PTX L693
	r_LaneIndexAtPtx695 = uint32_t((threadIdx.x & 31u));										 // PTX L695
	r_PtxU64Register67 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx695)) * int64_t(int32_t(16))); // PTX L697
	r_PtxU64Register64 = uint64_t(r_PtxU64Register66) + uint64_t(r_PtxU64Register67);			 // PTX L698
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register64));
		r_PackedHalf2AtPtx684R2593 = r_Value.x;
		r_PackedHalf2AtPtx685R2594 = r_Value.y;
		r_PackedHalf2AtPtx686R2595 = r_Value.z;
		r_PackedHalf2AtPtx687R2596 = r_Value.w;
	} // PTX L700
L__BB34_82:															 // PTX L702
	r_PackedHalf2AtPtx703R2597 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L703
	r_PackedHalf2AtPtx704R2598 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L704
	r_PackedHalf2AtPtx705R2599 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L705
	r_PackedHalf2AtPtx706R2600 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L706
	if (r_bPtxPredicate53)
	{
		goto L__BB34_84;
	} // PTX L707
	r_PtxRegister358 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);					 // PTX L708
	r_PtxRegister359 = ShiftLeft(uint32_t(r_PtxRegister358), uint32_t(12));						 // PTX L709
	r_PtxRegister360 = uint32_t(r_PtxRegister359) + uint32_t(r_PtxRegister11);					 // PTX L710
	r_PtxU64Register69 = uint64_t(int64_t(int32_t(r_PtxRegister360)) * int64_t(int32_t(4)));	 // PTX L711
	r_PtxU64Register70 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register69);				 // PTX L712
	r_LaneIndexAtPtx714 = uint32_t((threadIdx.x & 31u));										 // PTX L714
	r_PtxU64Register71 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx714)) * int64_t(int32_t(16))); // PTX L716
	r_PtxU64Register68 = uint64_t(r_PtxU64Register70) + uint64_t(r_PtxU64Register71);			 // PTX L717
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register68));
		r_PackedHalf2AtPtx703R2597 = r_Value.x;
		r_PackedHalf2AtPtx704R2598 = r_Value.y;
		r_PackedHalf2AtPtx705R2599 = r_Value.z;
		r_PackedHalf2AtPtx706R2600 = r_Value.w;
	} // PTX L719
L__BB34_84:															 // PTX L721
	r_PackedHalf2AtPtx722R2601 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L722
	r_PackedHalf2AtPtx723R2602 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L723
	r_PackedHalf2AtPtx724R2603 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L724
	r_PackedHalf2AtPtx725R2604 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L725
	if (r_bPtxPredicate53)
	{
		goto L__BB34_86;
	} // PTX L726
	r_PtxRegister362 = uint32_t(r_PtxRegister28) + uint32_t(r_PtxRegister31);					 // PTX L727
	r_PtxRegister363 = ShiftLeft(uint32_t(r_PtxRegister362), uint32_t(12));						 // PTX L728
	r_PtxRegister364 = uint32_t(r_PtxRegister363) + uint32_t(r_PtxRegister12);					 // PTX L729
	r_PtxU64Register73 = uint64_t(int64_t(int32_t(r_PtxRegister364)) * int64_t(int32_t(4)));	 // PTX L730
	r_PtxU64Register74 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register73);				 // PTX L731
	r_LaneIndexAtPtx733 = uint32_t((threadIdx.x & 31u));										 // PTX L733
	r_PtxU64Register75 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx733)) * int64_t(int32_t(16))); // PTX L735
	r_PtxU64Register72 = uint64_t(r_PtxU64Register74) + uint64_t(r_PtxU64Register75);			 // PTX L736
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register72));
		r_PackedHalf2AtPtx722R2601 = r_Value.x;
		r_PackedHalf2AtPtx723R2602 = r_Value.y;
		r_PackedHalf2AtPtx724R2603 = r_Value.z;
		r_PackedHalf2AtPtx725R2604 = r_Value.w;
	} // PTX L738
L__BB34_86:																	  // PTX L740
	r_bPtxPredicate54 = int32_t(r_PtxRegister5) < int32_t(r_PtxRegister7);	  // PTX L741
	r_bPtxPredicate55 = uint32_t(r_PtxRegister26) == uint32_t(4);			  // PTX L742
	r_bPtxPredicate56 = uint32_t(r_PtxRegister18) == uint32_t(4);			  // PTX L743
	r_PtxRegister365 = uint32_t(r_PtxRegister3) + uint32_t(1);				  // PTX L744
	r_bPtxPredicate57 = int32_t(r_PtxRegister365) < int32_t(r_PtxRegister6);  // PTX L745
	r_bPtxPredicate58 = int32_t(r_PtxRegister365) >= int32_t(r_PtxRegister6); // PTX L746
	r_PtxRegister366 = uint32_t(r_PtxRegister27) + uint32_t(r_PtxRegister7);  // PTX L747
	r_PtxRegister32 = r_bPtxPredicate56 ? 0 : r_PtxRegister366;				  // PTX L748
	r_bPtxPredicate59 = r_bPtxPredicate3 & r_bPtxPredicate58;				  // PTX L749
	r_bPtxPredicate9 = r_bPtxPredicate56 | r_bPtxPredicate57;				  // PTX L750
	r_bPtxPredicate10 = r_bPtxPredicate59 | r_bPtxPredicate55;				  // PTX L751
	r_bPtxPredicate60 = !r_bPtxPredicate59;									  // PTX L752
	r_bPtxPredicate11 = r_bPtxPredicate55 & r_bPtxPredicate60;				  // PTX L753
	r_PtxRegister33 = r_bPtxPredicate11 ? 0 : r_PtxRegister5;				  // PTX L754
	r_bPtxPredicate61 = r_bPtxPredicate10 | r_bPtxPredicate54;				  // PTX L755
	r_bPtxPredicate12 = r_bPtxPredicate61 & r_bPtxPredicate9;				  // PTX L756
	r_bPtxPredicate62 = !r_bPtxPredicate12;									  // PTX L757
	r_PackedHalf2AtPtx758R2605 = uint32_t(r_PackedHalf2AtPtx66R320);		  // PTX L758
	r_PackedHalf2AtPtx759R2606 = uint32_t(r_PackedHalf2AtPtx66R320);		  // PTX L759
	r_PackedHalf2AtPtx760R2607 = uint32_t(r_PackedHalf2AtPtx66R320);		  // PTX L760
	r_PackedHalf2AtPtx761R2608 = uint32_t(r_PackedHalf2AtPtx66R320);		  // PTX L761
	if (r_bPtxPredicate62)
	{
		goto L__BB34_88;
	} // PTX L762
	r_PtxRegister368 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);					 // PTX L763
	r_PtxRegister369 = ShiftLeft(uint32_t(r_PtxRegister368), uint32_t(12));						 // PTX L764
	r_PtxRegister370 = uint32_t(r_PtxRegister369) + uint32_t(r_PtxRegister9);					 // PTX L765
	r_PtxU64Register77 = uint64_t(int64_t(int32_t(r_PtxRegister370)) * int64_t(int32_t(4)));	 // PTX L766
	r_PtxU64Register78 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register77);				 // PTX L767
	r_LaneIndexAtPtx769 = uint32_t((threadIdx.x & 31u));										 // PTX L769
	r_PtxU64Register79 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx769)) * int64_t(int32_t(16))); // PTX L771
	r_PtxU64Register76 = uint64_t(r_PtxU64Register78) + uint64_t(r_PtxU64Register79);			 // PTX L772
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register76));
		r_PackedHalf2AtPtx758R2605 = r_Value.x;
		r_PackedHalf2AtPtx759R2606 = r_Value.y;
		r_PackedHalf2AtPtx760R2607 = r_Value.z;
		r_PackedHalf2AtPtx761R2608 = r_Value.w;
	} // PTX L774
L__BB34_88:															 // PTX L776
	r_PackedHalf2AtPtx777R2609 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L777
	r_PackedHalf2AtPtx778R2610 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L778
	r_PackedHalf2AtPtx779R2611 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L779
	r_PackedHalf2AtPtx780R2612 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L780
	if (r_bPtxPredicate62)
	{
		goto L__BB34_90;
	} // PTX L781
	r_PtxRegister372 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);					 // PTX L782
	r_PtxRegister373 = ShiftLeft(uint32_t(r_PtxRegister372), uint32_t(12));						 // PTX L783
	r_PtxRegister374 = uint32_t(r_PtxRegister373) + uint32_t(r_PtxRegister10);					 // PTX L784
	r_PtxU64Register81 = uint64_t(int64_t(int32_t(r_PtxRegister374)) * int64_t(int32_t(4)));	 // PTX L785
	r_PtxU64Register82 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register81);				 // PTX L786
	r_LaneIndexAtPtx788 = uint32_t((threadIdx.x & 31u));										 // PTX L788
	r_PtxU64Register83 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx788)) * int64_t(int32_t(16))); // PTX L790
	r_PtxU64Register80 = uint64_t(r_PtxU64Register82) + uint64_t(r_PtxU64Register83);			 // PTX L791
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register80));
		r_PackedHalf2AtPtx777R2609 = r_Value.x;
		r_PackedHalf2AtPtx778R2610 = r_Value.y;
		r_PackedHalf2AtPtx779R2611 = r_Value.z;
		r_PackedHalf2AtPtx780R2612 = r_Value.w;
	} // PTX L793
L__BB34_90:															 // PTX L795
	r_PackedHalf2AtPtx796R2613 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L796
	r_PackedHalf2AtPtx797R2614 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L797
	r_PackedHalf2AtPtx798R2615 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L798
	r_PackedHalf2AtPtx799R2616 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L799
	if (r_bPtxPredicate62)
	{
		goto L__BB34_92;
	} // PTX L800
	r_PtxRegister376 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);					 // PTX L801
	r_PtxRegister377 = ShiftLeft(uint32_t(r_PtxRegister376), uint32_t(12));						 // PTX L802
	r_PtxRegister378 = uint32_t(r_PtxRegister377) + uint32_t(r_PtxRegister11);					 // PTX L803
	r_PtxU64Register85 = uint64_t(int64_t(int32_t(r_PtxRegister378)) * int64_t(int32_t(4)));	 // PTX L804
	r_PtxU64Register86 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register85);				 // PTX L805
	r_LaneIndexAtPtx807 = uint32_t((threadIdx.x & 31u));										 // PTX L807
	r_PtxU64Register87 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx807)) * int64_t(int32_t(16))); // PTX L809
	r_PtxU64Register84 = uint64_t(r_PtxU64Register86) + uint64_t(r_PtxU64Register87);			 // PTX L810
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register84));
		r_PackedHalf2AtPtx796R2613 = r_Value.x;
		r_PackedHalf2AtPtx797R2614 = r_Value.y;
		r_PackedHalf2AtPtx798R2615 = r_Value.z;
		r_PackedHalf2AtPtx799R2616 = r_Value.w;
	} // PTX L812
L__BB34_92:															 // PTX L814
	r_PackedHalf2AtPtx815R2617 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L815
	r_PackedHalf2AtPtx816R2618 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L816
	r_PackedHalf2AtPtx817R2619 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L817
	r_PackedHalf2AtPtx818R2620 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L818
	if (r_bPtxPredicate62)
	{
		goto L__BB34_94;
	} // PTX L819
	r_PtxRegister380 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister33);					 // PTX L820
	r_PtxRegister381 = ShiftLeft(uint32_t(r_PtxRegister380), uint32_t(12));						 // PTX L821
	r_PtxRegister382 = uint32_t(r_PtxRegister381) + uint32_t(r_PtxRegister12);					 // PTX L822
	r_PtxU64Register89 = uint64_t(int64_t(int32_t(r_PtxRegister382)) * int64_t(int32_t(4)));	 // PTX L823
	r_PtxU64Register90 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register89);				 // PTX L824
	r_LaneIndexAtPtx826 = uint32_t((threadIdx.x & 31u));										 // PTX L826
	r_PtxU64Register91 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx826)) * int64_t(int32_t(16))); // PTX L828
	r_PtxU64Register88 = uint64_t(r_PtxU64Register90) + uint64_t(r_PtxU64Register91);			 // PTX L829
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register88));
		r_PackedHalf2AtPtx815R2617 = r_Value.x;
		r_PackedHalf2AtPtx816R2618 = r_Value.y;
		r_PackedHalf2AtPtx817R2619 = r_Value.z;
		r_PackedHalf2AtPtx818R2620 = r_Value.w;
	} // PTX L831
L__BB34_94:																	// PTX L833
	r_bPtxPredicate63 = int32_t(r_PtxRegister30) < int32_t(r_PtxRegister7); // PTX L834
	r_PtxRegister34 = r_bPtxPredicate11 ? 0 : r_PtxRegister30;				// PTX L835
	r_bPtxPredicate64 = r_bPtxPredicate10 | r_bPtxPredicate63;				// PTX L836
	r_bPtxPredicate13 = r_bPtxPredicate64 & r_bPtxPredicate9;				// PTX L837
	r_bPtxPredicate65 = !r_bPtxPredicate13;									// PTX L838
	r_PackedHalf2AtPtx839R2621 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L839
	r_PackedHalf2AtPtx840R2622 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L840
	r_PackedHalf2AtPtx841R2623 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L841
	r_PackedHalf2AtPtx842R2624 = uint32_t(r_PackedHalf2AtPtx66R320);		// PTX L842
	if (r_bPtxPredicate65)
	{
		goto L__BB34_96;
	} // PTX L843
	r_PtxRegister384 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);					 // PTX L844
	r_PtxRegister385 = ShiftLeft(uint32_t(r_PtxRegister384), uint32_t(12));						 // PTX L845
	r_PtxRegister386 = uint32_t(r_PtxRegister385) + uint32_t(r_PtxRegister9);					 // PTX L846
	r_PtxU64Register93 = uint64_t(int64_t(int32_t(r_PtxRegister386)) * int64_t(int32_t(4)));	 // PTX L847
	r_PtxU64Register94 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register93);				 // PTX L848
	r_LaneIndexAtPtx850 = uint32_t((threadIdx.x & 31u));										 // PTX L850
	r_PtxU64Register95 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx850)) * int64_t(int32_t(16))); // PTX L852
	r_PtxU64Register92 = uint64_t(r_PtxU64Register94) + uint64_t(r_PtxU64Register95);			 // PTX L853
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register92));
		r_PackedHalf2AtPtx839R2621 = r_Value.x;
		r_PackedHalf2AtPtx840R2622 = r_Value.y;
		r_PackedHalf2AtPtx841R2623 = r_Value.z;
		r_PackedHalf2AtPtx842R2624 = r_Value.w;
	} // PTX L855
L__BB34_96:															 // PTX L857
	r_PackedHalf2AtPtx858R2625 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L858
	r_PackedHalf2AtPtx859R2626 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L859
	r_PackedHalf2AtPtx860R2627 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L860
	r_PackedHalf2AtPtx861R2628 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L861
	if (r_bPtxPredicate65)
	{
		goto L__BB34_98;
	} // PTX L862
	r_PtxRegister388 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);					 // PTX L863
	r_PtxRegister389 = ShiftLeft(uint32_t(r_PtxRegister388), uint32_t(12));						 // PTX L864
	r_PtxRegister390 = uint32_t(r_PtxRegister389) + uint32_t(r_PtxRegister10);					 // PTX L865
	r_PtxU64Register97 = uint64_t(int64_t(int32_t(r_PtxRegister390)) * int64_t(int32_t(4)));	 // PTX L866
	r_PtxU64Register98 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register97);				 // PTX L867
	r_LaneIndexAtPtx869 = uint32_t((threadIdx.x & 31u));										 // PTX L869
	r_PtxU64Register99 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx869)) * int64_t(int32_t(16))); // PTX L871
	r_PtxU64Register96 = uint64_t(r_PtxU64Register98) + uint64_t(r_PtxU64Register99);			 // PTX L872
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register96));
		r_PackedHalf2AtPtx858R2625 = r_Value.x;
		r_PackedHalf2AtPtx859R2626 = r_Value.y;
		r_PackedHalf2AtPtx860R2627 = r_Value.z;
		r_PackedHalf2AtPtx861R2628 = r_Value.w;
	} // PTX L874
L__BB34_98:															 // PTX L876
	r_PackedHalf2AtPtx877R2629 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L877
	r_PackedHalf2AtPtx878R2630 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L878
	r_PackedHalf2AtPtx879R2631 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L879
	r_PackedHalf2AtPtx880R2632 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L880
	if (r_bPtxPredicate65)
	{
		goto L__BB34_100;
	} // PTX L881
	r_PtxRegister392 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);					  // PTX L882
	r_PtxRegister393 = ShiftLeft(uint32_t(r_PtxRegister392), uint32_t(12));						  // PTX L883
	r_PtxRegister394 = uint32_t(r_PtxRegister393) + uint32_t(r_PtxRegister11);					  // PTX L884
	r_PtxU64Register101 = uint64_t(int64_t(int32_t(r_PtxRegister394)) * int64_t(int32_t(4)));	  // PTX L885
	r_PtxU64Register102 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register101);				  // PTX L886
	r_LaneIndexAtPtx888 = uint32_t((threadIdx.x & 31u));										  // PTX L888
	r_PtxU64Register103 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx888)) * int64_t(int32_t(16))); // PTX L890
	r_PtxU64Register100 = uint64_t(r_PtxU64Register102) + uint64_t(r_PtxU64Register103);		  // PTX L891
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register100));
		r_PackedHalf2AtPtx877R2629 = r_Value.x;
		r_PackedHalf2AtPtx878R2630 = r_Value.y;
		r_PackedHalf2AtPtx879R2631 = r_Value.z;
		r_PackedHalf2AtPtx880R2632 = r_Value.w;
	} // PTX L893
L__BB34_100:														 // PTX L895
	r_PackedHalf2AtPtx896R2633 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L896
	r_PackedHalf2AtPtx897R2634 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L897
	r_PackedHalf2AtPtx898R2635 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L898
	r_PackedHalf2AtPtx899R2636 = uint32_t(r_PackedHalf2AtPtx66R320); // PTX L899
	if (r_bPtxPredicate65)
	{
		goto L__BB34_102;
	} // PTX L900
	r_PtxRegister396 = uint32_t(r_PtxRegister32) + uint32_t(r_PtxRegister34);					  // PTX L901
	r_PtxRegister397 = ShiftLeft(uint32_t(r_PtxRegister396), uint32_t(12));						  // PTX L902
	r_PtxRegister398 = uint32_t(r_PtxRegister397) + uint32_t(r_PtxRegister12);					  // PTX L903
	r_PtxU64Register105 = uint64_t(int64_t(int32_t(r_PtxRegister398)) * int64_t(int32_t(4)));	  // PTX L904
	r_PtxU64Register106 = uint64_t(r_Pointer8Bits) + uint64_t(r_PtxU64Register105);				  // PTX L905
	r_LaneIndexAtPtx907 = uint32_t((threadIdx.x & 31u));										  // PTX L907
	r_PtxU64Register107 = uint64_t(int64_t(int32_t(r_LaneIndexAtPtx907)) * int64_t(int32_t(16))); // PTX L909
	r_PtxU64Register104 = uint64_t(r_PtxU64Register106) + uint64_t(r_PtxU64Register107);		  // PTX L910
	{
		const uint4 r_Value = __ldcg(reinterpret_cast<const uint4*>(r_PtxU64Register104));
		r_PackedHalf2AtPtx896R2633 = r_Value.x;
		r_PackedHalf2AtPtx897R2634 = r_Value.y;
		r_PackedHalf2AtPtx898R2635 = r_Value.z;
		r_PackedHalf2AtPtx899R2636 = r_Value.w;
	} // PTX L912
L__BB34_102:																				   // PTX L914
	r_PtxU64Register108 = r_Pointer24Bits;													   // PTX L915
	r_PtxRegister591 = r_PtxRegister214 | 16;												   // PTX L916
	r_PtxRegister592 = r_PtxRegister214 | 8;												   // PTX L917
	r_LaneIndexAtPtx919 = uint32_t((threadIdx.x & 31u));									   // PTX L919
	r_PtxRegister593 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx919), uint32_t(31));		   // PTX L921
	r_PtxRegister594 = ShiftRight(uint32_t(r_PtxRegister593), uint32_t(30));				   // PTX L922
	r_PtxRegister595 = uint32_t(r_LaneIndexAtPtx919) + uint32_t(r_PtxRegister594);			   // PTX L923
	r_PtxRegister596 = r_PtxRegister595 & 2147483644;										   // PTX L924
	r_PtxRegister597 = uint32_t(r_LaneIndexAtPtx919) - uint32_t(r_PtxRegister596);			   // PTX L925
	r_PtxRegister598 = ShiftLeft(uint32_t(r_PtxRegister597), uint32_t(1));					   // PTX L926
	r_PtxRegister599 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister598);				   // PTX L927
	r_PtxRegister600 = ShiftRightSigned(int32_t(r_PtxRegister599), uint32_t(1));			   // PTX L928
	r_PtxU64Register109 = uint64_t(int64_t(int32_t(r_PtxRegister600)) * int64_t(int32_t(4)));  // PTX L929
	r_PtxU64Register110 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register109);	   // PTX L930
	r_PtxRegister464 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register110 + 524288ull);	   // PTX L931
	r_LaneIndexAtPtx933 = uint32_t((threadIdx.x & 31u));									   // PTX L933
	r_PtxRegister601 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx933), uint32_t(31));		   // PTX L935
	r_PtxRegister602 = ShiftRight(uint32_t(r_PtxRegister601), uint32_t(30));				   // PTX L936
	r_PtxRegister603 = uint32_t(r_LaneIndexAtPtx933) + uint32_t(r_PtxRegister602);			   // PTX L937
	r_PtxRegister604 = r_PtxRegister603 & 2147483644;										   // PTX L938
	r_PtxRegister605 = uint32_t(r_LaneIndexAtPtx933) - uint32_t(r_PtxRegister604);			   // PTX L939
	r_PtxRegister606 = ShiftLeft(uint32_t(r_PtxRegister605), uint32_t(1));					   // PTX L940
	r_PtxRegister607 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister606);				   // PTX L941
	r_PtxRegister608 = ShiftRightSigned(int32_t(r_PtxRegister607), uint32_t(1));			   // PTX L942
	r_PtxU64Register111 = uint64_t(int64_t(int32_t(r_PtxRegister608)) * int64_t(int32_t(4)));  // PTX L943
	r_PtxU64Register112 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register111);	   // PTX L944
	r_PtxRegister466 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register112 + 524288ull);	   // PTX L945
	r_LaneIndexAtPtx947 = uint32_t((threadIdx.x & 31u));									   // PTX L947
	r_PtxRegister609 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx947), uint32_t(31));		   // PTX L949
	r_PtxRegister610 = ShiftRight(uint32_t(r_PtxRegister609), uint32_t(30));				   // PTX L950
	r_PtxRegister611 = uint32_t(r_LaneIndexAtPtx947) + uint32_t(r_PtxRegister610);			   // PTX L951
	r_PtxRegister612 = r_PtxRegister611 & 2147483644;										   // PTX L952
	r_PtxRegister613 = uint32_t(r_LaneIndexAtPtx947) - uint32_t(r_PtxRegister612);			   // PTX L953
	r_PtxRegister614 = ShiftLeft(uint32_t(r_PtxRegister613), uint32_t(1));					   // PTX L954
	r_PtxRegister615 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister614);				   // PTX L955
	r_PtxRegister616 = ShiftRightSigned(int32_t(r_PtxRegister615), uint32_t(1));			   // PTX L956
	r_PtxU64Register113 = uint64_t(int64_t(int32_t(r_PtxRegister616)) * int64_t(int32_t(4)));  // PTX L957
	r_PtxU64Register114 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register113);	   // PTX L958
	r_PtxRegister468 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register114 + 524288ull);	   // PTX L959
	r_LaneIndexAtPtx961 = uint32_t((threadIdx.x & 31u));									   // PTX L961
	r_PtxRegister617 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx961), uint32_t(31));		   // PTX L963
	r_PtxRegister618 = ShiftRight(uint32_t(r_PtxRegister617), uint32_t(30));				   // PTX L964
	r_PtxRegister619 = uint32_t(r_LaneIndexAtPtx961) + uint32_t(r_PtxRegister618);			   // PTX L965
	r_PtxRegister620 = r_PtxRegister619 & 2147483644;										   // PTX L966
	r_PtxRegister621 = uint32_t(r_LaneIndexAtPtx961) - uint32_t(r_PtxRegister620);			   // PTX L967
	r_PtxRegister622 = ShiftLeft(uint32_t(r_PtxRegister621), uint32_t(1));					   // PTX L968
	r_PtxRegister623 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister622);				   // PTX L969
	r_PtxRegister624 = ShiftRightSigned(int32_t(r_PtxRegister623), uint32_t(1));			   // PTX L970
	r_PtxU64Register115 = uint64_t(int64_t(int32_t(r_PtxRegister624)) * int64_t(int32_t(4)));  // PTX L971
	r_PtxU64Register116 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register115);	   // PTX L972
	r_PtxRegister470 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register116 + 524288ull);	   // PTX L973
	r_LaneIndexAtPtx975 = uint32_t((threadIdx.x & 31u));									   // PTX L975
	r_PtxRegister625 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx975), uint32_t(31));		   // PTX L977
	r_PtxRegister626 = ShiftRight(uint32_t(r_PtxRegister625), uint32_t(30));				   // PTX L978
	r_PtxRegister627 = uint32_t(r_LaneIndexAtPtx975) + uint32_t(r_PtxRegister626);			   // PTX L979
	r_PtxRegister628 = r_PtxRegister627 & 2147483644;										   // PTX L980
	r_PtxRegister629 = uint32_t(r_LaneIndexAtPtx975) - uint32_t(r_PtxRegister628);			   // PTX L981
	r_PtxRegister630 = ShiftLeft(uint32_t(r_PtxRegister629), uint32_t(1));					   // PTX L982
	r_PtxRegister631 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister630);				   // PTX L983
	r_PtxRegister632 = ShiftRightSigned(int32_t(r_PtxRegister631), uint32_t(1));			   // PTX L984
	r_PtxU64Register117 = uint64_t(int64_t(int32_t(r_PtxRegister632)) * int64_t(int32_t(4)));  // PTX L985
	r_PtxU64Register118 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register117);	   // PTX L986
	r_PtxRegister472 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register118 + 524288ull);	   // PTX L987
	r_LaneIndexAtPtx989 = uint32_t((threadIdx.x & 31u));									   // PTX L989
	r_PtxRegister633 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx989), uint32_t(31));		   // PTX L991
	r_PtxRegister634 = ShiftRight(uint32_t(r_PtxRegister633), uint32_t(30));				   // PTX L992
	r_PtxRegister635 = uint32_t(r_LaneIndexAtPtx989) + uint32_t(r_PtxRegister634);			   // PTX L993
	r_PtxRegister636 = r_PtxRegister635 & 2147483644;										   // PTX L994
	r_PtxRegister637 = uint32_t(r_LaneIndexAtPtx989) - uint32_t(r_PtxRegister636);			   // PTX L995
	r_PtxRegister638 = ShiftLeft(uint32_t(r_PtxRegister637), uint32_t(1));					   // PTX L996
	r_PtxRegister639 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister638);				   // PTX L997
	r_PtxRegister640 = ShiftRightSigned(int32_t(r_PtxRegister639), uint32_t(1));			   // PTX L998
	r_PtxU64Register119 = uint64_t(int64_t(int32_t(r_PtxRegister640)) * int64_t(int32_t(4)));  // PTX L999
	r_PtxU64Register120 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register119);	   // PTX L1000
	r_PtxRegister474 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register120 + 524288ull);	   // PTX L1001
	r_LaneIndexAtPtx1003 = uint32_t((threadIdx.x & 31u));									   // PTX L1003
	r_PtxRegister641 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1003), uint32_t(31));		   // PTX L1005
	r_PtxRegister642 = ShiftRight(uint32_t(r_PtxRegister641), uint32_t(30));				   // PTX L1006
	r_PtxRegister643 = uint32_t(r_LaneIndexAtPtx1003) + uint32_t(r_PtxRegister642);			   // PTX L1007
	r_PtxRegister644 = r_PtxRegister643 & 2147483644;										   // PTX L1008
	r_PtxRegister645 = uint32_t(r_LaneIndexAtPtx1003) - uint32_t(r_PtxRegister644);			   // PTX L1009
	r_PtxRegister646 = ShiftLeft(uint32_t(r_PtxRegister645), uint32_t(1));					   // PTX L1010
	r_PtxRegister647 = r_PtxRegister214 | 24;												   // PTX L1011
	r_PtxRegister648 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister646);				   // PTX L1012
	r_PtxRegister649 = ShiftRightSigned(int32_t(r_PtxRegister648), uint32_t(1));			   // PTX L1013
	r_PtxU64Register121 = uint64_t(int64_t(int32_t(r_PtxRegister649)) * int64_t(int32_t(4)));  // PTX L1014
	r_PtxU64Register122 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register121);	   // PTX L1015
	r_PtxRegister476 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register122 + 524288ull);	   // PTX L1016
	r_LaneIndexAtPtx1018 = uint32_t((threadIdx.x & 31u));									   // PTX L1018
	r_PtxRegister650 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1018), uint32_t(31));		   // PTX L1020
	r_PtxRegister651 = ShiftRight(uint32_t(r_PtxRegister650), uint32_t(30));				   // PTX L1021
	r_PtxRegister652 = uint32_t(r_LaneIndexAtPtx1018) + uint32_t(r_PtxRegister651);			   // PTX L1022
	r_PtxRegister653 = r_PtxRegister652 & 2147483644;										   // PTX L1023
	r_PtxRegister654 = uint32_t(r_LaneIndexAtPtx1018) - uint32_t(r_PtxRegister653);			   // PTX L1024
	r_PtxRegister655 = ShiftLeft(uint32_t(r_PtxRegister654), uint32_t(1));					   // PTX L1025
	r_PtxRegister656 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister655);				   // PTX L1026
	r_PtxRegister657 = ShiftRightSigned(int32_t(r_PtxRegister656), uint32_t(1));			   // PTX L1027
	r_PtxU64Register123 = uint64_t(int64_t(int32_t(r_PtxRegister657)) * int64_t(int32_t(4)));  // PTX L1028
	r_PtxU64Register124 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register123);	   // PTX L1029
	r_PtxRegister478 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register124 + 524288ull);	   // PTX L1030
	r_LaneIndexAtPtx1032 = uint32_t((threadIdx.x & 31u));									   // PTX L1032
	r_PtxRegister658 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1032), uint32_t(31));		   // PTX L1034
	r_PtxRegister659 = ShiftRight(uint32_t(r_PtxRegister658), uint32_t(30));				   // PTX L1035
	r_PtxRegister660 = uint32_t(r_LaneIndexAtPtx1032) + uint32_t(r_PtxRegister659);			   // PTX L1036
	r_PtxRegister661 = r_PtxRegister660 & 2147483644;										   // PTX L1037
	r_PtxRegister662 = uint32_t(r_LaneIndexAtPtx1032) - uint32_t(r_PtxRegister661);			   // PTX L1038
	r_PtxRegister663 = ShiftLeft(uint32_t(r_PtxRegister662), uint32_t(1));					   // PTX L1039
	r_PtxRegister664 = r_PtxRegister214 | 32;												   // PTX L1040
	r_PtxRegister665 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister663);				   // PTX L1041
	r_PtxRegister666 = ShiftRightSigned(int32_t(r_PtxRegister665), uint32_t(1));			   // PTX L1042
	r_PtxU64Register125 = uint64_t(int64_t(int32_t(r_PtxRegister666)) * int64_t(int32_t(4)));  // PTX L1043
	r_PtxU64Register126 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register125);	   // PTX L1044
	r_PtxRegister480 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register126 + 524288ull);	   // PTX L1045
	r_LaneIndexAtPtx1047 = uint32_t((threadIdx.x & 31u));									   // PTX L1047
	r_PtxRegister667 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1047), uint32_t(31));		   // PTX L1049
	r_PtxRegister668 = ShiftRight(uint32_t(r_PtxRegister667), uint32_t(30));				   // PTX L1050
	r_PtxRegister669 = uint32_t(r_LaneIndexAtPtx1047) + uint32_t(r_PtxRegister668);			   // PTX L1051
	r_PtxRegister670 = r_PtxRegister669 & 2147483644;										   // PTX L1052
	r_PtxRegister671 = uint32_t(r_LaneIndexAtPtx1047) - uint32_t(r_PtxRegister670);			   // PTX L1053
	r_PtxRegister672 = ShiftLeft(uint32_t(r_PtxRegister671), uint32_t(1));					   // PTX L1054
	r_PtxRegister673 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister672);				   // PTX L1055
	r_PtxRegister674 = ShiftRightSigned(int32_t(r_PtxRegister673), uint32_t(1));			   // PTX L1056
	r_PtxU64Register127 = uint64_t(int64_t(int32_t(r_PtxRegister674)) * int64_t(int32_t(4)));  // PTX L1057
	r_PtxU64Register128 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register127);	   // PTX L1058
	r_PtxRegister482 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register128 + 524288ull);	   // PTX L1059
	r_LaneIndexAtPtx1061 = uint32_t((threadIdx.x & 31u));									   // PTX L1061
	r_PtxRegister675 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1061), uint32_t(31));		   // PTX L1063
	r_PtxRegister676 = ShiftRight(uint32_t(r_PtxRegister675), uint32_t(30));				   // PTX L1064
	r_PtxRegister677 = uint32_t(r_LaneIndexAtPtx1061) + uint32_t(r_PtxRegister676);			   // PTX L1065
	r_PtxRegister678 = r_PtxRegister677 & 2147483644;										   // PTX L1066
	r_PtxRegister679 = uint32_t(r_LaneIndexAtPtx1061) - uint32_t(r_PtxRegister678);			   // PTX L1067
	r_PtxRegister680 = ShiftLeft(uint32_t(r_PtxRegister679), uint32_t(1));					   // PTX L1068
	r_PtxRegister681 = r_PtxRegister214 | 40;												   // PTX L1069
	r_PtxRegister682 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister680);				   // PTX L1070
	r_PtxRegister683 = ShiftRightSigned(int32_t(r_PtxRegister682), uint32_t(1));			   // PTX L1071
	r_PtxU64Register129 = uint64_t(int64_t(int32_t(r_PtxRegister683)) * int64_t(int32_t(4)));  // PTX L1072
	r_PtxU64Register130 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register129);	   // PTX L1073
	r_PtxRegister484 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register130 + 524288ull);	   // PTX L1074
	r_LaneIndexAtPtx1076 = uint32_t((threadIdx.x & 31u));									   // PTX L1076
	r_PtxRegister684 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1076), uint32_t(31));		   // PTX L1078
	r_PtxRegister685 = ShiftRight(uint32_t(r_PtxRegister684), uint32_t(30));				   // PTX L1079
	r_PtxRegister686 = uint32_t(r_LaneIndexAtPtx1076) + uint32_t(r_PtxRegister685);			   // PTX L1080
	r_PtxRegister687 = r_PtxRegister686 & 2147483644;										   // PTX L1081
	r_PtxRegister688 = uint32_t(r_LaneIndexAtPtx1076) - uint32_t(r_PtxRegister687);			   // PTX L1082
	r_PtxRegister689 = ShiftLeft(uint32_t(r_PtxRegister688), uint32_t(1));					   // PTX L1083
	r_PtxRegister690 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister689);				   // PTX L1084
	r_PtxRegister691 = ShiftRightSigned(int32_t(r_PtxRegister690), uint32_t(1));			   // PTX L1085
	r_PtxU64Register131 = uint64_t(int64_t(int32_t(r_PtxRegister691)) * int64_t(int32_t(4)));  // PTX L1086
	r_PtxU64Register132 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register131);	   // PTX L1087
	r_PtxRegister486 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register132 + 524288ull);	   // PTX L1088
	r_LaneIndexAtPtx1090 = uint32_t((threadIdx.x & 31u));									   // PTX L1090
	r_PtxRegister692 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1090), uint32_t(31));		   // PTX L1092
	r_PtxRegister693 = ShiftRight(uint32_t(r_PtxRegister692), uint32_t(30));				   // PTX L1093
	r_PtxRegister694 = uint32_t(r_LaneIndexAtPtx1090) + uint32_t(r_PtxRegister693);			   // PTX L1094
	r_PtxRegister695 = r_PtxRegister694 & 2147483644;										   // PTX L1095
	r_PtxRegister696 = uint32_t(r_LaneIndexAtPtx1090) - uint32_t(r_PtxRegister695);			   // PTX L1096
	r_PtxRegister697 = ShiftLeft(uint32_t(r_PtxRegister696), uint32_t(1));					   // PTX L1097
	r_PtxRegister698 = r_PtxRegister214 | 48;												   // PTX L1098
	r_PtxRegister699 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister697);				   // PTX L1099
	r_PtxRegister700 = ShiftRightSigned(int32_t(r_PtxRegister699), uint32_t(1));			   // PTX L1100
	r_PtxU64Register133 = uint64_t(int64_t(int32_t(r_PtxRegister700)) * int64_t(int32_t(4)));  // PTX L1101
	r_PtxU64Register134 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register133);	   // PTX L1102
	r_PtxRegister488 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register134 + 524288ull);	   // PTX L1103
	r_LaneIndexAtPtx1105 = uint32_t((threadIdx.x & 31u));									   // PTX L1105
	r_PtxRegister701 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1105), uint32_t(31));		   // PTX L1107
	r_PtxRegister702 = ShiftRight(uint32_t(r_PtxRegister701), uint32_t(30));				   // PTX L1108
	r_PtxRegister703 = uint32_t(r_LaneIndexAtPtx1105) + uint32_t(r_PtxRegister702);			   // PTX L1109
	r_PtxRegister704 = r_PtxRegister703 & 2147483644;										   // PTX L1110
	r_PtxRegister705 = uint32_t(r_LaneIndexAtPtx1105) - uint32_t(r_PtxRegister704);			   // PTX L1111
	r_PtxRegister706 = ShiftLeft(uint32_t(r_PtxRegister705), uint32_t(1));					   // PTX L1112
	r_PtxRegister707 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister706);				   // PTX L1113
	r_PtxRegister708 = ShiftRightSigned(int32_t(r_PtxRegister707), uint32_t(1));			   // PTX L1114
	r_PtxU64Register135 = uint64_t(int64_t(int32_t(r_PtxRegister708)) * int64_t(int32_t(4)));  // PTX L1115
	r_PtxU64Register136 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register135);	   // PTX L1116
	r_PtxRegister490 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register136 + 524288ull);	   // PTX L1117
	r_LaneIndexAtPtx1119 = uint32_t((threadIdx.x & 31u));									   // PTX L1119
	r_PtxRegister709 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1119), uint32_t(31));		   // PTX L1121
	r_PtxRegister710 = ShiftRight(uint32_t(r_PtxRegister709), uint32_t(30));				   // PTX L1122
	r_PtxRegister711 = uint32_t(r_LaneIndexAtPtx1119) + uint32_t(r_PtxRegister710);			   // PTX L1123
	r_PtxRegister712 = r_PtxRegister711 & 2147483644;										   // PTX L1124
	r_PtxRegister713 = uint32_t(r_LaneIndexAtPtx1119) - uint32_t(r_PtxRegister712);			   // PTX L1125
	r_PtxRegister714 = ShiftLeft(uint32_t(r_PtxRegister713), uint32_t(1));					   // PTX L1126
	r_PtxRegister715 = r_PtxRegister214 | 56;												   // PTX L1127
	r_PtxRegister716 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister714);				   // PTX L1128
	r_PtxRegister717 = ShiftRightSigned(int32_t(r_PtxRegister716), uint32_t(1));			   // PTX L1129
	r_PtxU64Register137 = uint64_t(int64_t(int32_t(r_PtxRegister717)) * int64_t(int32_t(4)));  // PTX L1130
	r_PtxU64Register138 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register137);	   // PTX L1131
	r_PtxRegister492 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register138 + 524288ull);	   // PTX L1132
	r_LaneIndexAtPtx1134 = uint32_t((threadIdx.x & 31u));									   // PTX L1134
	r_PtxRegister718 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1134), uint32_t(31));		   // PTX L1136
	r_PtxRegister719 = ShiftRight(uint32_t(r_PtxRegister718), uint32_t(30));				   // PTX L1137
	r_PtxRegister720 = uint32_t(r_LaneIndexAtPtx1134) + uint32_t(r_PtxRegister719);			   // PTX L1138
	r_PtxRegister721 = r_PtxRegister720 & 2147483644;										   // PTX L1139
	r_PtxRegister722 = uint32_t(r_LaneIndexAtPtx1134) - uint32_t(r_PtxRegister721);			   // PTX L1140
	r_PtxRegister723 = ShiftLeft(uint32_t(r_PtxRegister722), uint32_t(1));					   // PTX L1141
	r_PtxRegister724 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister723);				   // PTX L1142
	r_PtxRegister725 = ShiftRightSigned(int32_t(r_PtxRegister724), uint32_t(1));			   // PTX L1143
	r_PtxU64Register139 = uint64_t(int64_t(int32_t(r_PtxRegister725)) * int64_t(int32_t(4)));  // PTX L1144
	r_PtxU64Register140 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register139);	   // PTX L1145
	r_PtxRegister494 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register140 + 524288ull);	   // PTX L1146
	r_LaneIndexAtPtx1148 = uint32_t((threadIdx.x & 31u));									   // PTX L1148
	r_PtxRegister726 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1148), uint32_t(31));		   // PTX L1150
	r_PtxRegister727 = ShiftRight(uint32_t(r_PtxRegister726), uint32_t(30));				   // PTX L1151
	r_PtxRegister728 = uint32_t(r_LaneIndexAtPtx1148) + uint32_t(r_PtxRegister727);			   // PTX L1152
	r_PtxRegister729 = r_PtxRegister728 & 2147483644;										   // PTX L1153
	r_PtxRegister730 = uint32_t(r_LaneIndexAtPtx1148) - uint32_t(r_PtxRegister729);			   // PTX L1154
	r_PtxRegister731 = ShiftLeft(uint32_t(r_PtxRegister730), uint32_t(1));					   // PTX L1155
	r_PtxRegister732 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister731);				   // PTX L1156
	r_PtxRegister733 = ShiftRightSigned(int32_t(r_PtxRegister732), uint32_t(1));			   // PTX L1157
	r_PtxU64Register141 = uint64_t(int64_t(int32_t(r_PtxRegister733)) * int64_t(int32_t(4)));  // PTX L1158
	r_PtxU64Register142 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register141);	   // PTX L1159
	r_PtxRegister496 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register142 + 524288ull);	   // PTX L1160
	r_LaneIndexAtPtx1162 = uint32_t((threadIdx.x & 31u));									   // PTX L1162
	r_PtxRegister734 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1162), uint32_t(31));		   // PTX L1164
	r_PtxRegister735 = ShiftRight(uint32_t(r_PtxRegister734), uint32_t(30));				   // PTX L1165
	r_PtxRegister736 = uint32_t(r_LaneIndexAtPtx1162) + uint32_t(r_PtxRegister735);			   // PTX L1166
	r_PtxRegister737 = r_PtxRegister736 & 2147483644;										   // PTX L1167
	r_PtxRegister738 = uint32_t(r_LaneIndexAtPtx1162) - uint32_t(r_PtxRegister737);			   // PTX L1168
	r_PtxRegister739 = ShiftLeft(uint32_t(r_PtxRegister738), uint32_t(1));					   // PTX L1169
	r_PtxRegister740 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister739);				   // PTX L1170
	r_PtxRegister741 = ShiftRightSigned(int32_t(r_PtxRegister740), uint32_t(1));			   // PTX L1171
	r_PtxU64Register143 = uint64_t(int64_t(int32_t(r_PtxRegister741)) * int64_t(int32_t(4)));  // PTX L1172
	r_PtxU64Register144 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register143);	   // PTX L1173
	r_PtxRegister498 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register144 + 524288ull);	   // PTX L1174
	r_LaneIndexAtPtx1176 = uint32_t((threadIdx.x & 31u));									   // PTX L1176
	r_PtxRegister742 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1176), uint32_t(31));		   // PTX L1178
	r_PtxRegister743 = ShiftRight(uint32_t(r_PtxRegister742), uint32_t(30));				   // PTX L1179
	r_PtxRegister744 = uint32_t(r_LaneIndexAtPtx1176) + uint32_t(r_PtxRegister743);			   // PTX L1180
	r_PtxRegister745 = r_PtxRegister744 & 2147483644;										   // PTX L1181
	r_PtxRegister746 = uint32_t(r_LaneIndexAtPtx1176) - uint32_t(r_PtxRegister745);			   // PTX L1182
	r_PtxRegister747 = ShiftLeft(uint32_t(r_PtxRegister746), uint32_t(1));					   // PTX L1183
	r_PtxRegister748 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister747);				   // PTX L1184
	r_PtxRegister749 = ShiftRightSigned(int32_t(r_PtxRegister748), uint32_t(1));			   // PTX L1185
	r_PtxU64Register145 = uint64_t(int64_t(int32_t(r_PtxRegister749)) * int64_t(int32_t(4)));  // PTX L1186
	r_PtxU64Register146 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register145);	   // PTX L1187
	r_PtxRegister500 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register146 + 524288ull);	   // PTX L1188
	r_LaneIndexAtPtx1190 = uint32_t((threadIdx.x & 31u));									   // PTX L1190
	r_PtxRegister750 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1190), uint32_t(31));		   // PTX L1192
	r_PtxRegister751 = ShiftRight(uint32_t(r_PtxRegister750), uint32_t(30));				   // PTX L1193
	r_PtxRegister752 = uint32_t(r_LaneIndexAtPtx1190) + uint32_t(r_PtxRegister751);			   // PTX L1194
	r_PtxRegister753 = r_PtxRegister752 & 2147483644;										   // PTX L1195
	r_PtxRegister754 = uint32_t(r_LaneIndexAtPtx1190) - uint32_t(r_PtxRegister753);			   // PTX L1196
	r_PtxRegister755 = ShiftLeft(uint32_t(r_PtxRegister754), uint32_t(1));					   // PTX L1197
	r_PtxRegister756 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister755);				   // PTX L1198
	r_PtxRegister757 = ShiftRightSigned(int32_t(r_PtxRegister756), uint32_t(1));			   // PTX L1199
	r_PtxU64Register147 = uint64_t(int64_t(int32_t(r_PtxRegister757)) * int64_t(int32_t(4)));  // PTX L1200
	r_PtxU64Register148 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register147);	   // PTX L1201
	r_PtxRegister502 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register148 + 524288ull);	   // PTX L1202
	r_LaneIndexAtPtx1204 = uint32_t((threadIdx.x & 31u));									   // PTX L1204
	r_PtxRegister758 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1204), uint32_t(31));		   // PTX L1206
	r_PtxRegister759 = ShiftRight(uint32_t(r_PtxRegister758), uint32_t(30));				   // PTX L1207
	r_PtxRegister760 = uint32_t(r_LaneIndexAtPtx1204) + uint32_t(r_PtxRegister759);			   // PTX L1208
	r_PtxRegister761 = r_PtxRegister760 & 2147483644;										   // PTX L1209
	r_PtxRegister762 = uint32_t(r_LaneIndexAtPtx1204) - uint32_t(r_PtxRegister761);			   // PTX L1210
	r_PtxRegister763 = ShiftLeft(uint32_t(r_PtxRegister762), uint32_t(1));					   // PTX L1211
	r_PtxRegister764 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister763);				   // PTX L1212
	r_PtxRegister765 = ShiftRightSigned(int32_t(r_PtxRegister764), uint32_t(1));			   // PTX L1213
	r_PtxU64Register149 = uint64_t(int64_t(int32_t(r_PtxRegister765)) * int64_t(int32_t(4)));  // PTX L1214
	r_PtxU64Register150 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register149);	   // PTX L1215
	r_PtxRegister504 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register150 + 524288ull);	   // PTX L1216
	r_LaneIndexAtPtx1218 = uint32_t((threadIdx.x & 31u));									   // PTX L1218
	r_PtxRegister766 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1218), uint32_t(31));		   // PTX L1220
	r_PtxRegister767 = ShiftRight(uint32_t(r_PtxRegister766), uint32_t(30));				   // PTX L1221
	r_PtxRegister768 = uint32_t(r_LaneIndexAtPtx1218) + uint32_t(r_PtxRegister767);			   // PTX L1222
	r_PtxRegister769 = r_PtxRegister768 & 2147483644;										   // PTX L1223
	r_PtxRegister770 = uint32_t(r_LaneIndexAtPtx1218) - uint32_t(r_PtxRegister769);			   // PTX L1224
	r_PtxRegister771 = ShiftLeft(uint32_t(r_PtxRegister770), uint32_t(1));					   // PTX L1225
	r_PtxRegister772 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister771);				   // PTX L1226
	r_PtxRegister773 = ShiftRightSigned(int32_t(r_PtxRegister772), uint32_t(1));			   // PTX L1227
	r_PtxU64Register151 = uint64_t(int64_t(int32_t(r_PtxRegister773)) * int64_t(int32_t(4)));  // PTX L1228
	r_PtxU64Register152 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register151);	   // PTX L1229
	r_PtxRegister506 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register152 + 524288ull);	   // PTX L1230
	r_LaneIndexAtPtx1232 = uint32_t((threadIdx.x & 31u));									   // PTX L1232
	r_PtxRegister774 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1232), uint32_t(31));		   // PTX L1234
	r_PtxRegister775 = ShiftRight(uint32_t(r_PtxRegister774), uint32_t(30));				   // PTX L1235
	r_PtxRegister776 = uint32_t(r_LaneIndexAtPtx1232) + uint32_t(r_PtxRegister775);			   // PTX L1236
	r_PtxRegister777 = r_PtxRegister776 & 2147483644;										   // PTX L1237
	r_PtxRegister778 = uint32_t(r_LaneIndexAtPtx1232) - uint32_t(r_PtxRegister777);			   // PTX L1238
	r_PtxRegister779 = ShiftLeft(uint32_t(r_PtxRegister778), uint32_t(1));					   // PTX L1239
	r_PtxRegister780 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister779);				   // PTX L1240
	r_PtxRegister781 = ShiftRightSigned(int32_t(r_PtxRegister780), uint32_t(1));			   // PTX L1241
	r_PtxU64Register153 = uint64_t(int64_t(int32_t(r_PtxRegister781)) * int64_t(int32_t(4)));  // PTX L1242
	r_PtxU64Register154 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register153);	   // PTX L1243
	r_PtxRegister508 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register154 + 524288ull);	   // PTX L1244
	r_LaneIndexAtPtx1246 = uint32_t((threadIdx.x & 31u));									   // PTX L1246
	r_PtxRegister782 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1246), uint32_t(31));		   // PTX L1248
	r_PtxRegister783 = ShiftRight(uint32_t(r_PtxRegister782), uint32_t(30));				   // PTX L1249
	r_PtxRegister784 = uint32_t(r_LaneIndexAtPtx1246) + uint32_t(r_PtxRegister783);			   // PTX L1250
	r_PtxRegister785 = r_PtxRegister784 & 2147483644;										   // PTX L1251
	r_PtxRegister786 = uint32_t(r_LaneIndexAtPtx1246) - uint32_t(r_PtxRegister785);			   // PTX L1252
	r_PtxRegister787 = ShiftLeft(uint32_t(r_PtxRegister786), uint32_t(1));					   // PTX L1253
	r_PtxRegister788 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister787);				   // PTX L1254
	r_PtxRegister789 = ShiftRightSigned(int32_t(r_PtxRegister788), uint32_t(1));			   // PTX L1255
	r_PtxU64Register155 = uint64_t(int64_t(int32_t(r_PtxRegister789)) * int64_t(int32_t(4)));  // PTX L1256
	r_PtxU64Register156 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register155);	   // PTX L1257
	r_PtxRegister510 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register156 + 524288ull);	   // PTX L1258
	r_LaneIndexAtPtx1260 = uint32_t((threadIdx.x & 31u));									   // PTX L1260
	r_PtxRegister790 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1260), uint32_t(31));		   // PTX L1262
	r_PtxRegister791 = ShiftRight(uint32_t(r_PtxRegister790), uint32_t(30));				   // PTX L1263
	r_PtxRegister792 = uint32_t(r_LaneIndexAtPtx1260) + uint32_t(r_PtxRegister791);			   // PTX L1264
	r_PtxRegister793 = r_PtxRegister792 & 2147483644;										   // PTX L1265
	r_PtxRegister794 = uint32_t(r_LaneIndexAtPtx1260) - uint32_t(r_PtxRegister793);			   // PTX L1266
	r_PtxRegister795 = ShiftLeft(uint32_t(r_PtxRegister794), uint32_t(1));					   // PTX L1267
	r_PtxRegister796 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister795);				   // PTX L1268
	r_PtxRegister797 = ShiftRightSigned(int32_t(r_PtxRegister796), uint32_t(1));			   // PTX L1269
	r_PtxU64Register157 = uint64_t(int64_t(int32_t(r_PtxRegister797)) * int64_t(int32_t(4)));  // PTX L1270
	r_PtxU64Register158 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register157);	   // PTX L1271
	r_PtxRegister512 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register158 + 524288ull);	   // PTX L1272
	r_LaneIndexAtPtx1274 = uint32_t((threadIdx.x & 31u));									   // PTX L1274
	r_PtxRegister798 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1274), uint32_t(31));		   // PTX L1276
	r_PtxRegister799 = ShiftRight(uint32_t(r_PtxRegister798), uint32_t(30));				   // PTX L1277
	r_PtxRegister800 = uint32_t(r_LaneIndexAtPtx1274) + uint32_t(r_PtxRegister799);			   // PTX L1278
	r_PtxRegister801 = r_PtxRegister800 & 2147483644;										   // PTX L1279
	r_PtxRegister802 = uint32_t(r_LaneIndexAtPtx1274) - uint32_t(r_PtxRegister801);			   // PTX L1280
	r_PtxRegister803 = ShiftLeft(uint32_t(r_PtxRegister802), uint32_t(1));					   // PTX L1281
	r_PtxRegister804 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister803);				   // PTX L1282
	r_PtxRegister805 = ShiftRightSigned(int32_t(r_PtxRegister804), uint32_t(1));			   // PTX L1283
	r_PtxU64Register159 = uint64_t(int64_t(int32_t(r_PtxRegister805)) * int64_t(int32_t(4)));  // PTX L1284
	r_PtxU64Register160 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register159);	   // PTX L1285
	r_PtxRegister514 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register160 + 524288ull);	   // PTX L1286
	r_LaneIndexAtPtx1288 = uint32_t((threadIdx.x & 31u));									   // PTX L1288
	r_PtxRegister806 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1288), uint32_t(31));		   // PTX L1290
	r_PtxRegister807 = ShiftRight(uint32_t(r_PtxRegister806), uint32_t(30));				   // PTX L1291
	r_PtxRegister808 = uint32_t(r_LaneIndexAtPtx1288) + uint32_t(r_PtxRegister807);			   // PTX L1292
	r_PtxRegister809 = r_PtxRegister808 & 2147483644;										   // PTX L1293
	r_PtxRegister810 = uint32_t(r_LaneIndexAtPtx1288) - uint32_t(r_PtxRegister809);			   // PTX L1294
	r_PtxRegister811 = ShiftLeft(uint32_t(r_PtxRegister810), uint32_t(1));					   // PTX L1295
	r_PtxRegister812 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister811);				   // PTX L1296
	r_PtxRegister813 = ShiftRightSigned(int32_t(r_PtxRegister812), uint32_t(1));			   // PTX L1297
	r_PtxU64Register161 = uint64_t(int64_t(int32_t(r_PtxRegister813)) * int64_t(int32_t(4)));  // PTX L1298
	r_PtxU64Register162 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register161);	   // PTX L1299
	r_PtxRegister516 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register162 + 524288ull);	   // PTX L1300
	r_LaneIndexAtPtx1302 = uint32_t((threadIdx.x & 31u));									   // PTX L1302
	r_PtxRegister814 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1302), uint32_t(31));		   // PTX L1304
	r_PtxRegister815 = ShiftRight(uint32_t(r_PtxRegister814), uint32_t(30));				   // PTX L1305
	r_PtxRegister816 = uint32_t(r_LaneIndexAtPtx1302) + uint32_t(r_PtxRegister815);			   // PTX L1306
	r_PtxRegister817 = r_PtxRegister816 & 2147483644;										   // PTX L1307
	r_PtxRegister818 = uint32_t(r_LaneIndexAtPtx1302) - uint32_t(r_PtxRegister817);			   // PTX L1308
	r_PtxRegister819 = ShiftLeft(uint32_t(r_PtxRegister818), uint32_t(1));					   // PTX L1309
	r_PtxRegister820 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister819);				   // PTX L1310
	r_PtxRegister821 = ShiftRightSigned(int32_t(r_PtxRegister820), uint32_t(1));			   // PTX L1311
	r_PtxU64Register163 = uint64_t(int64_t(int32_t(r_PtxRegister821)) * int64_t(int32_t(4)));  // PTX L1312
	r_PtxU64Register164 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register163);	   // PTX L1313
	r_PtxRegister518 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register164 + 524288ull);	   // PTX L1314
	r_LaneIndexAtPtx1316 = uint32_t((threadIdx.x & 31u));									   // PTX L1316
	r_PtxRegister822 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1316), uint32_t(31));		   // PTX L1318
	r_PtxRegister823 = ShiftRight(uint32_t(r_PtxRegister822), uint32_t(30));				   // PTX L1319
	r_PtxRegister824 = uint32_t(r_LaneIndexAtPtx1316) + uint32_t(r_PtxRegister823);			   // PTX L1320
	r_PtxRegister825 = r_PtxRegister824 & 2147483644;										   // PTX L1321
	r_PtxRegister826 = uint32_t(r_LaneIndexAtPtx1316) - uint32_t(r_PtxRegister825);			   // PTX L1322
	r_PtxRegister827 = ShiftLeft(uint32_t(r_PtxRegister826), uint32_t(1));					   // PTX L1323
	r_PtxRegister828 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister827);				   // PTX L1324
	r_PtxRegister829 = ShiftRightSigned(int32_t(r_PtxRegister828), uint32_t(1));			   // PTX L1325
	r_PtxU64Register165 = uint64_t(int64_t(int32_t(r_PtxRegister829)) * int64_t(int32_t(4)));  // PTX L1326
	r_PtxU64Register166 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register165);	   // PTX L1327
	r_PtxRegister520 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register166 + 524288ull);	   // PTX L1328
	r_LaneIndexAtPtx1330 = uint32_t((threadIdx.x & 31u));									   // PTX L1330
	r_PtxRegister830 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1330), uint32_t(31));		   // PTX L1332
	r_PtxRegister831 = ShiftRight(uint32_t(r_PtxRegister830), uint32_t(30));				   // PTX L1333
	r_PtxRegister832 = uint32_t(r_LaneIndexAtPtx1330) + uint32_t(r_PtxRegister831);			   // PTX L1334
	r_PtxRegister833 = r_PtxRegister832 & 2147483644;										   // PTX L1335
	r_PtxRegister834 = uint32_t(r_LaneIndexAtPtx1330) - uint32_t(r_PtxRegister833);			   // PTX L1336
	r_PtxRegister835 = ShiftLeft(uint32_t(r_PtxRegister834), uint32_t(1));					   // PTX L1337
	r_PtxRegister836 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister835);				   // PTX L1338
	r_PtxRegister837 = ShiftRightSigned(int32_t(r_PtxRegister836), uint32_t(1));			   // PTX L1339
	r_PtxU64Register167 = uint64_t(int64_t(int32_t(r_PtxRegister837)) * int64_t(int32_t(4)));  // PTX L1340
	r_PtxU64Register168 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register167);	   // PTX L1341
	r_PtxRegister522 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register168 + 524288ull);	   // PTX L1342
	r_LaneIndexAtPtx1344 = uint32_t((threadIdx.x & 31u));									   // PTX L1344
	r_PtxRegister838 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1344), uint32_t(31));		   // PTX L1346
	r_PtxRegister839 = ShiftRight(uint32_t(r_PtxRegister838), uint32_t(30));				   // PTX L1347
	r_PtxRegister840 = uint32_t(r_LaneIndexAtPtx1344) + uint32_t(r_PtxRegister839);			   // PTX L1348
	r_PtxRegister841 = r_PtxRegister840 & 2147483644;										   // PTX L1349
	r_PtxRegister842 = uint32_t(r_LaneIndexAtPtx1344) - uint32_t(r_PtxRegister841);			   // PTX L1350
	r_PtxRegister843 = ShiftLeft(uint32_t(r_PtxRegister842), uint32_t(1));					   // PTX L1351
	r_PtxRegister844 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister843);				   // PTX L1352
	r_PtxRegister845 = ShiftRightSigned(int32_t(r_PtxRegister844), uint32_t(1));			   // PTX L1353
	r_PtxU64Register169 = uint64_t(int64_t(int32_t(r_PtxRegister845)) * int64_t(int32_t(4)));  // PTX L1354
	r_PtxU64Register170 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register169);	   // PTX L1355
	r_PtxRegister524 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register170 + 524288ull);	   // PTX L1356
	r_LaneIndexAtPtx1358 = uint32_t((threadIdx.x & 31u));									   // PTX L1358
	r_PtxRegister846 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1358), uint32_t(31));		   // PTX L1360
	r_PtxRegister847 = ShiftRight(uint32_t(r_PtxRegister846), uint32_t(30));				   // PTX L1361
	r_PtxRegister848 = uint32_t(r_LaneIndexAtPtx1358) + uint32_t(r_PtxRegister847);			   // PTX L1362
	r_PtxRegister849 = r_PtxRegister848 & 2147483644;										   // PTX L1363
	r_PtxRegister850 = uint32_t(r_LaneIndexAtPtx1358) - uint32_t(r_PtxRegister849);			   // PTX L1364
	r_PtxRegister851 = ShiftLeft(uint32_t(r_PtxRegister850), uint32_t(1));					   // PTX L1365
	r_PtxRegister852 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister851);				   // PTX L1366
	r_PtxRegister853 = ShiftRightSigned(int32_t(r_PtxRegister852), uint32_t(1));			   // PTX L1367
	r_PtxU64Register171 = uint64_t(int64_t(int32_t(r_PtxRegister853)) * int64_t(int32_t(4)));  // PTX L1368
	r_PtxU64Register172 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register171);	   // PTX L1369
	r_PtxRegister526 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register172 + 524288ull);	   // PTX L1370
	r_LaneIndexAtPtx1372 = uint32_t((threadIdx.x & 31u));									   // PTX L1372
	r_PtxRegister854 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1372), uint32_t(31));		   // PTX L1374
	r_PtxRegister855 = ShiftRight(uint32_t(r_PtxRegister854), uint32_t(30));				   // PTX L1375
	r_PtxRegister856 = uint32_t(r_LaneIndexAtPtx1372) + uint32_t(r_PtxRegister855);			   // PTX L1376
	r_PtxRegister857 = r_PtxRegister856 & 2147483644;										   // PTX L1377
	r_PtxRegister858 = uint32_t(r_LaneIndexAtPtx1372) - uint32_t(r_PtxRegister857);			   // PTX L1378
	r_PtxRegister859 = ShiftLeft(uint32_t(r_PtxRegister858), uint32_t(1));					   // PTX L1379
	r_PtxRegister860 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister859);				   // PTX L1380
	r_PtxRegister861 = ShiftRightSigned(int32_t(r_PtxRegister860), uint32_t(1));			   // PTX L1381
	r_PtxU64Register173 = uint64_t(int64_t(int32_t(r_PtxRegister861)) * int64_t(int32_t(4)));  // PTX L1382
	r_PtxU64Register174 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register173);	   // PTX L1383
	r_PtxRegister528 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register174 + 524288ull);	   // PTX L1384
	r_LaneIndexAtPtx1386 = uint32_t((threadIdx.x & 31u));									   // PTX L1386
	r_PtxRegister862 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1386), uint32_t(31));		   // PTX L1388
	r_PtxRegister863 = ShiftRight(uint32_t(r_PtxRegister862), uint32_t(30));				   // PTX L1389
	r_PtxRegister864 = uint32_t(r_LaneIndexAtPtx1386) + uint32_t(r_PtxRegister863);			   // PTX L1390
	r_PtxRegister865 = r_PtxRegister864 & 2147483644;										   // PTX L1391
	r_PtxRegister866 = uint32_t(r_LaneIndexAtPtx1386) - uint32_t(r_PtxRegister865);			   // PTX L1392
	r_PtxRegister867 = ShiftLeft(uint32_t(r_PtxRegister866), uint32_t(1));					   // PTX L1393
	r_PtxRegister868 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister867);				   // PTX L1394
	r_PtxRegister869 = ShiftRightSigned(int32_t(r_PtxRegister868), uint32_t(1));			   // PTX L1395
	r_PtxU64Register175 = uint64_t(int64_t(int32_t(r_PtxRegister869)) * int64_t(int32_t(4)));  // PTX L1396
	r_PtxU64Register176 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register175);	   // PTX L1397
	r_PtxRegister530 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register176 + 524288ull);	   // PTX L1398
	r_LaneIndexAtPtx1400 = uint32_t((threadIdx.x & 31u));									   // PTX L1400
	r_PtxRegister870 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1400), uint32_t(31));		   // PTX L1402
	r_PtxRegister871 = ShiftRight(uint32_t(r_PtxRegister870), uint32_t(30));				   // PTX L1403
	r_PtxRegister872 = uint32_t(r_LaneIndexAtPtx1400) + uint32_t(r_PtxRegister871);			   // PTX L1404
	r_PtxRegister873 = r_PtxRegister872 & 2147483644;										   // PTX L1405
	r_PtxRegister874 = uint32_t(r_LaneIndexAtPtx1400) - uint32_t(r_PtxRegister873);			   // PTX L1406
	r_PtxRegister875 = ShiftLeft(uint32_t(r_PtxRegister874), uint32_t(1));					   // PTX L1407
	r_PtxRegister876 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister875);				   // PTX L1408
	r_PtxRegister877 = ShiftRightSigned(int32_t(r_PtxRegister876), uint32_t(1));			   // PTX L1409
	r_PtxU64Register177 = uint64_t(int64_t(int32_t(r_PtxRegister877)) * int64_t(int32_t(4)));  // PTX L1410
	r_PtxU64Register178 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register177);	   // PTX L1411
	r_PtxRegister532 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register178 + 524288ull);	   // PTX L1412
	r_LaneIndexAtPtx1414 = uint32_t((threadIdx.x & 31u));									   // PTX L1414
	r_PtxRegister878 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1414), uint32_t(31));		   // PTX L1416
	r_PtxRegister879 = ShiftRight(uint32_t(r_PtxRegister878), uint32_t(30));				   // PTX L1417
	r_PtxRegister880 = uint32_t(r_LaneIndexAtPtx1414) + uint32_t(r_PtxRegister879);			   // PTX L1418
	r_PtxRegister881 = r_PtxRegister880 & 2147483644;										   // PTX L1419
	r_PtxRegister882 = uint32_t(r_LaneIndexAtPtx1414) - uint32_t(r_PtxRegister881);			   // PTX L1420
	r_PtxRegister883 = ShiftLeft(uint32_t(r_PtxRegister882), uint32_t(1));					   // PTX L1421
	r_PtxRegister884 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister883);				   // PTX L1422
	r_PtxRegister885 = ShiftRightSigned(int32_t(r_PtxRegister884), uint32_t(1));			   // PTX L1423
	r_PtxU64Register179 = uint64_t(int64_t(int32_t(r_PtxRegister885)) * int64_t(int32_t(4)));  // PTX L1424
	r_PtxU64Register180 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register179);	   // PTX L1425
	r_PtxRegister534 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register180 + 524288ull);	   // PTX L1426
	r_LaneIndexAtPtx1428 = uint32_t((threadIdx.x & 31u));									   // PTX L1428
	r_PtxRegister886 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1428), uint32_t(31));		   // PTX L1430
	r_PtxRegister887 = ShiftRight(uint32_t(r_PtxRegister886), uint32_t(30));				   // PTX L1431
	r_PtxRegister888 = uint32_t(r_LaneIndexAtPtx1428) + uint32_t(r_PtxRegister887);			   // PTX L1432
	r_PtxRegister889 = r_PtxRegister888 & 2147483644;										   // PTX L1433
	r_PtxRegister890 = uint32_t(r_LaneIndexAtPtx1428) - uint32_t(r_PtxRegister889);			   // PTX L1434
	r_PtxRegister891 = ShiftLeft(uint32_t(r_PtxRegister890), uint32_t(1));					   // PTX L1435
	r_PtxRegister892 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister891);				   // PTX L1436
	r_PtxRegister893 = ShiftRightSigned(int32_t(r_PtxRegister892), uint32_t(1));			   // PTX L1437
	r_PtxU64Register181 = uint64_t(int64_t(int32_t(r_PtxRegister893)) * int64_t(int32_t(4)));  // PTX L1438
	r_PtxU64Register182 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register181);	   // PTX L1439
	r_PtxRegister536 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register182 + 524288ull);	   // PTX L1440
	r_LaneIndexAtPtx1442 = uint32_t((threadIdx.x & 31u));									   // PTX L1442
	r_PtxRegister894 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1442), uint32_t(31));		   // PTX L1444
	r_PtxRegister895 = ShiftRight(uint32_t(r_PtxRegister894), uint32_t(30));				   // PTX L1445
	r_PtxRegister896 = uint32_t(r_LaneIndexAtPtx1442) + uint32_t(r_PtxRegister895);			   // PTX L1446
	r_PtxRegister897 = r_PtxRegister896 & 2147483644;										   // PTX L1447
	r_PtxRegister898 = uint32_t(r_LaneIndexAtPtx1442) - uint32_t(r_PtxRegister897);			   // PTX L1448
	r_PtxRegister899 = ShiftLeft(uint32_t(r_PtxRegister898), uint32_t(1));					   // PTX L1449
	r_PtxRegister900 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister899);				   // PTX L1450
	r_PtxRegister901 = ShiftRightSigned(int32_t(r_PtxRegister900), uint32_t(1));			   // PTX L1451
	r_PtxU64Register183 = uint64_t(int64_t(int32_t(r_PtxRegister901)) * int64_t(int32_t(4)));  // PTX L1452
	r_PtxU64Register184 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register183);	   // PTX L1453
	r_PtxRegister538 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register184 + 524288ull);	   // PTX L1454
	r_LaneIndexAtPtx1456 = uint32_t((threadIdx.x & 31u));									   // PTX L1456
	r_PtxRegister902 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1456), uint32_t(31));		   // PTX L1458
	r_PtxRegister903 = ShiftRight(uint32_t(r_PtxRegister902), uint32_t(30));				   // PTX L1459
	r_PtxRegister904 = uint32_t(r_LaneIndexAtPtx1456) + uint32_t(r_PtxRegister903);			   // PTX L1460
	r_PtxRegister905 = r_PtxRegister904 & 2147483644;										   // PTX L1461
	r_PtxRegister906 = uint32_t(r_LaneIndexAtPtx1456) - uint32_t(r_PtxRegister905);			   // PTX L1462
	r_PtxRegister907 = ShiftLeft(uint32_t(r_PtxRegister906), uint32_t(1));					   // PTX L1463
	r_PtxRegister908 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister907);				   // PTX L1464
	r_PtxRegister909 = ShiftRightSigned(int32_t(r_PtxRegister908), uint32_t(1));			   // PTX L1465
	r_PtxU64Register185 = uint64_t(int64_t(int32_t(r_PtxRegister909)) * int64_t(int32_t(4)));  // PTX L1466
	r_PtxU64Register186 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register185);	   // PTX L1467
	r_PtxRegister540 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register186 + 524288ull);	   // PTX L1468
	r_LaneIndexAtPtx1470 = uint32_t((threadIdx.x & 31u));									   // PTX L1470
	r_PtxRegister910 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1470), uint32_t(31));		   // PTX L1472
	r_PtxRegister911 = ShiftRight(uint32_t(r_PtxRegister910), uint32_t(30));				   // PTX L1473
	r_PtxRegister912 = uint32_t(r_LaneIndexAtPtx1470) + uint32_t(r_PtxRegister911);			   // PTX L1474
	r_PtxRegister913 = r_PtxRegister912 & 2147483644;										   // PTX L1475
	r_PtxRegister914 = uint32_t(r_LaneIndexAtPtx1470) - uint32_t(r_PtxRegister913);			   // PTX L1476
	r_PtxRegister915 = ShiftLeft(uint32_t(r_PtxRegister914), uint32_t(1));					   // PTX L1477
	r_PtxRegister916 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister915);				   // PTX L1478
	r_PtxRegister917 = ShiftRightSigned(int32_t(r_PtxRegister916), uint32_t(1));			   // PTX L1479
	r_PtxU64Register187 = uint64_t(int64_t(int32_t(r_PtxRegister917)) * int64_t(int32_t(4)));  // PTX L1480
	r_PtxU64Register188 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register187);	   // PTX L1481
	r_PtxRegister542 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register188 + 524288ull);	   // PTX L1482
	r_LaneIndexAtPtx1484 = uint32_t((threadIdx.x & 31u));									   // PTX L1484
	r_PtxRegister918 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1484), uint32_t(31));		   // PTX L1486
	r_PtxRegister919 = ShiftRight(uint32_t(r_PtxRegister918), uint32_t(30));				   // PTX L1487
	r_PtxRegister920 = uint32_t(r_LaneIndexAtPtx1484) + uint32_t(r_PtxRegister919);			   // PTX L1488
	r_PtxRegister921 = r_PtxRegister920 & 2147483644;										   // PTX L1489
	r_PtxRegister922 = uint32_t(r_LaneIndexAtPtx1484) - uint32_t(r_PtxRegister921);			   // PTX L1490
	r_PtxRegister923 = ShiftLeft(uint32_t(r_PtxRegister922), uint32_t(1));					   // PTX L1491
	r_PtxRegister924 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister923);				   // PTX L1492
	r_PtxRegister925 = ShiftRightSigned(int32_t(r_PtxRegister924), uint32_t(1));			   // PTX L1493
	r_PtxU64Register189 = uint64_t(int64_t(int32_t(r_PtxRegister925)) * int64_t(int32_t(4)));  // PTX L1494
	r_PtxU64Register190 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register189);	   // PTX L1495
	r_PtxRegister544 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register190 + 524288ull);	   // PTX L1496
	r_LaneIndexAtPtx1498 = uint32_t((threadIdx.x & 31u));									   // PTX L1498
	r_PtxRegister926 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1498), uint32_t(31));		   // PTX L1500
	r_PtxRegister927 = ShiftRight(uint32_t(r_PtxRegister926), uint32_t(30));				   // PTX L1501
	r_PtxRegister928 = uint32_t(r_LaneIndexAtPtx1498) + uint32_t(r_PtxRegister927);			   // PTX L1502
	r_PtxRegister929 = r_PtxRegister928 & 2147483644;										   // PTX L1503
	r_PtxRegister930 = uint32_t(r_LaneIndexAtPtx1498) - uint32_t(r_PtxRegister929);			   // PTX L1504
	r_PtxRegister931 = ShiftLeft(uint32_t(r_PtxRegister930), uint32_t(1));					   // PTX L1505
	r_PtxRegister932 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister931);				   // PTX L1506
	r_PtxRegister933 = ShiftRightSigned(int32_t(r_PtxRegister932), uint32_t(1));			   // PTX L1507
	r_PtxU64Register191 = uint64_t(int64_t(int32_t(r_PtxRegister933)) * int64_t(int32_t(4)));  // PTX L1508
	r_PtxU64Register192 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register191);	   // PTX L1509
	r_PtxRegister546 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register192 + 524288ull);	   // PTX L1510
	r_LaneIndexAtPtx1512 = uint32_t((threadIdx.x & 31u));									   // PTX L1512
	r_PtxRegister934 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1512), uint32_t(31));		   // PTX L1514
	r_PtxRegister935 = ShiftRight(uint32_t(r_PtxRegister934), uint32_t(30));				   // PTX L1515
	r_PtxRegister936 = uint32_t(r_LaneIndexAtPtx1512) + uint32_t(r_PtxRegister935);			   // PTX L1516
	r_PtxRegister937 = r_PtxRegister936 & 2147483644;										   // PTX L1517
	r_PtxRegister938 = uint32_t(r_LaneIndexAtPtx1512) - uint32_t(r_PtxRegister937);			   // PTX L1518
	r_PtxRegister939 = ShiftLeft(uint32_t(r_PtxRegister938), uint32_t(1));					   // PTX L1519
	r_PtxRegister940 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister939);				   // PTX L1520
	r_PtxRegister941 = ShiftRightSigned(int32_t(r_PtxRegister940), uint32_t(1));			   // PTX L1521
	r_PtxU64Register193 = uint64_t(int64_t(int32_t(r_PtxRegister941)) * int64_t(int32_t(4)));  // PTX L1522
	r_PtxU64Register194 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register193);	   // PTX L1523
	r_PtxRegister548 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register194 + 524288ull);	   // PTX L1524
	r_LaneIndexAtPtx1526 = uint32_t((threadIdx.x & 31u));									   // PTX L1526
	r_PtxRegister942 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1526), uint32_t(31));		   // PTX L1528
	r_PtxRegister943 = ShiftRight(uint32_t(r_PtxRegister942), uint32_t(30));				   // PTX L1529
	r_PtxRegister944 = uint32_t(r_LaneIndexAtPtx1526) + uint32_t(r_PtxRegister943);			   // PTX L1530
	r_PtxRegister945 = r_PtxRegister944 & 2147483644;										   // PTX L1531
	r_PtxRegister946 = uint32_t(r_LaneIndexAtPtx1526) - uint32_t(r_PtxRegister945);			   // PTX L1532
	r_PtxRegister947 = ShiftLeft(uint32_t(r_PtxRegister946), uint32_t(1));					   // PTX L1533
	r_PtxRegister948 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister947);				   // PTX L1534
	r_PtxRegister949 = ShiftRightSigned(int32_t(r_PtxRegister948), uint32_t(1));			   // PTX L1535
	r_PtxU64Register195 = uint64_t(int64_t(int32_t(r_PtxRegister949)) * int64_t(int32_t(4)));  // PTX L1536
	r_PtxU64Register196 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register195);	   // PTX L1537
	r_PtxRegister550 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register196 + 524288ull);	   // PTX L1538
	r_LaneIndexAtPtx1540 = uint32_t((threadIdx.x & 31u));									   // PTX L1540
	r_PtxRegister950 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1540), uint32_t(31));		   // PTX L1542
	r_PtxRegister951 = ShiftRight(uint32_t(r_PtxRegister950), uint32_t(30));				   // PTX L1543
	r_PtxRegister952 = uint32_t(r_LaneIndexAtPtx1540) + uint32_t(r_PtxRegister951);			   // PTX L1544
	r_PtxRegister953 = r_PtxRegister952 & 2147483644;										   // PTX L1545
	r_PtxRegister954 = uint32_t(r_LaneIndexAtPtx1540) - uint32_t(r_PtxRegister953);			   // PTX L1546
	r_PtxRegister955 = ShiftLeft(uint32_t(r_PtxRegister954), uint32_t(1));					   // PTX L1547
	r_PtxRegister956 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister955);				   // PTX L1548
	r_PtxRegister957 = ShiftRightSigned(int32_t(r_PtxRegister956), uint32_t(1));			   // PTX L1549
	r_PtxU64Register197 = uint64_t(int64_t(int32_t(r_PtxRegister957)) * int64_t(int32_t(4)));  // PTX L1550
	r_PtxU64Register198 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register197);	   // PTX L1551
	r_PtxRegister552 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register198 + 524288ull);	   // PTX L1552
	r_LaneIndexAtPtx1554 = uint32_t((threadIdx.x & 31u));									   // PTX L1554
	r_PtxRegister958 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1554), uint32_t(31));		   // PTX L1556
	r_PtxRegister959 = ShiftRight(uint32_t(r_PtxRegister958), uint32_t(30));				   // PTX L1557
	r_PtxRegister960 = uint32_t(r_LaneIndexAtPtx1554) + uint32_t(r_PtxRegister959);			   // PTX L1558
	r_PtxRegister961 = r_PtxRegister960 & 2147483644;										   // PTX L1559
	r_PtxRegister962 = uint32_t(r_LaneIndexAtPtx1554) - uint32_t(r_PtxRegister961);			   // PTX L1560
	r_PtxRegister963 = ShiftLeft(uint32_t(r_PtxRegister962), uint32_t(1));					   // PTX L1561
	r_PtxRegister964 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister963);				   // PTX L1562
	r_PtxRegister965 = ShiftRightSigned(int32_t(r_PtxRegister964), uint32_t(1));			   // PTX L1563
	r_PtxU64Register199 = uint64_t(int64_t(int32_t(r_PtxRegister965)) * int64_t(int32_t(4)));  // PTX L1564
	r_PtxU64Register200 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register199);	   // PTX L1565
	r_PtxRegister554 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register200 + 524288ull);	   // PTX L1566
	r_LaneIndexAtPtx1568 = uint32_t((threadIdx.x & 31u));									   // PTX L1568
	r_PtxRegister966 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1568), uint32_t(31));		   // PTX L1570
	r_PtxRegister967 = ShiftRight(uint32_t(r_PtxRegister966), uint32_t(30));				   // PTX L1571
	r_PtxRegister968 = uint32_t(r_LaneIndexAtPtx1568) + uint32_t(r_PtxRegister967);			   // PTX L1572
	r_PtxRegister969 = r_PtxRegister968 & 2147483644;										   // PTX L1573
	r_PtxRegister970 = uint32_t(r_LaneIndexAtPtx1568) - uint32_t(r_PtxRegister969);			   // PTX L1574
	r_PtxRegister971 = ShiftLeft(uint32_t(r_PtxRegister970), uint32_t(1));					   // PTX L1575
	r_PtxRegister972 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister971);				   // PTX L1576
	r_PtxRegister973 = ShiftRightSigned(int32_t(r_PtxRegister972), uint32_t(1));			   // PTX L1577
	r_PtxU64Register201 = uint64_t(int64_t(int32_t(r_PtxRegister973)) * int64_t(int32_t(4)));  // PTX L1578
	r_PtxU64Register202 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register201);	   // PTX L1579
	r_PtxRegister556 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register202 + 524288ull);	   // PTX L1580
	r_LaneIndexAtPtx1582 = uint32_t((threadIdx.x & 31u));									   // PTX L1582
	r_PtxRegister974 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1582), uint32_t(31));		   // PTX L1584
	r_PtxRegister975 = ShiftRight(uint32_t(r_PtxRegister974), uint32_t(30));				   // PTX L1585
	r_PtxRegister976 = uint32_t(r_LaneIndexAtPtx1582) + uint32_t(r_PtxRegister975);			   // PTX L1586
	r_PtxRegister977 = r_PtxRegister976 & 2147483644;										   // PTX L1587
	r_PtxRegister978 = uint32_t(r_LaneIndexAtPtx1582) - uint32_t(r_PtxRegister977);			   // PTX L1588
	r_PtxRegister979 = ShiftLeft(uint32_t(r_PtxRegister978), uint32_t(1));					   // PTX L1589
	r_PtxRegister980 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister979);				   // PTX L1590
	r_PtxRegister981 = ShiftRightSigned(int32_t(r_PtxRegister980), uint32_t(1));			   // PTX L1591
	r_PtxU64Register203 = uint64_t(int64_t(int32_t(r_PtxRegister981)) * int64_t(int32_t(4)));  // PTX L1592
	r_PtxU64Register204 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register203);	   // PTX L1593
	r_PtxRegister558 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register204 + 524288ull);	   // PTX L1594
	r_LaneIndexAtPtx1596 = uint32_t((threadIdx.x & 31u));									   // PTX L1596
	r_PtxRegister982 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1596), uint32_t(31));		   // PTX L1598
	r_PtxRegister983 = ShiftRight(uint32_t(r_PtxRegister982), uint32_t(30));				   // PTX L1599
	r_PtxRegister984 = uint32_t(r_LaneIndexAtPtx1596) + uint32_t(r_PtxRegister983);			   // PTX L1600
	r_PtxRegister985 = r_PtxRegister984 & 2147483644;										   // PTX L1601
	r_PtxRegister986 = uint32_t(r_LaneIndexAtPtx1596) - uint32_t(r_PtxRegister985);			   // PTX L1602
	r_PtxRegister987 = ShiftLeft(uint32_t(r_PtxRegister986), uint32_t(1));					   // PTX L1603
	r_PtxRegister988 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister987);				   // PTX L1604
	r_PtxRegister989 = ShiftRightSigned(int32_t(r_PtxRegister988), uint32_t(1));			   // PTX L1605
	r_PtxU64Register205 = uint64_t(int64_t(int32_t(r_PtxRegister989)) * int64_t(int32_t(4)));  // PTX L1606
	r_PtxU64Register206 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register205);	   // PTX L1607
	r_PtxRegister560 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register206 + 524288ull);	   // PTX L1608
	r_LaneIndexAtPtx1610 = uint32_t((threadIdx.x & 31u));									   // PTX L1610
	r_PtxRegister990 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1610), uint32_t(31));		   // PTX L1612
	r_PtxRegister991 = ShiftRight(uint32_t(r_PtxRegister990), uint32_t(30));				   // PTX L1613
	r_PtxRegister992 = uint32_t(r_LaneIndexAtPtx1610) + uint32_t(r_PtxRegister991);			   // PTX L1614
	r_PtxRegister993 = r_PtxRegister992 & 2147483644;										   // PTX L1615
	r_PtxRegister994 = uint32_t(r_LaneIndexAtPtx1610) - uint32_t(r_PtxRegister993);			   // PTX L1616
	r_PtxRegister995 = ShiftLeft(uint32_t(r_PtxRegister994), uint32_t(1));					   // PTX L1617
	r_PtxRegister996 = uint32_t(r_PtxRegister214) + uint32_t(r_PtxRegister995);				   // PTX L1618
	r_PtxRegister997 = ShiftRightSigned(int32_t(r_PtxRegister996), uint32_t(1));			   // PTX L1619
	r_PtxU64Register207 = uint64_t(int64_t(int32_t(r_PtxRegister997)) * int64_t(int32_t(4)));  // PTX L1620
	r_PtxU64Register208 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register207);	   // PTX L1621
	r_PtxRegister562 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register208 + 524288ull);	   // PTX L1622
	r_LaneIndexAtPtx1624 = uint32_t((threadIdx.x & 31u));									   // PTX L1624
	r_PtxRegister998 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1624), uint32_t(31));		   // PTX L1626
	r_PtxRegister999 = ShiftRight(uint32_t(r_PtxRegister998), uint32_t(30));				   // PTX L1627
	r_PtxRegister1000 = uint32_t(r_LaneIndexAtPtx1624) + uint32_t(r_PtxRegister999);		   // PTX L1628
	r_PtxRegister1001 = r_PtxRegister1000 & 2147483644;										   // PTX L1629
	r_PtxRegister1002 = uint32_t(r_LaneIndexAtPtx1624) - uint32_t(r_PtxRegister1001);		   // PTX L1630
	r_PtxRegister1003 = ShiftLeft(uint32_t(r_PtxRegister1002), uint32_t(1));				   // PTX L1631
	r_PtxRegister1004 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister1003);			   // PTX L1632
	r_PtxRegister1005 = ShiftRightSigned(int32_t(r_PtxRegister1004), uint32_t(1));			   // PTX L1633
	r_PtxU64Register209 = uint64_t(int64_t(int32_t(r_PtxRegister1005)) * int64_t(int32_t(4))); // PTX L1634
	r_PtxU64Register210 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register209);	   // PTX L1635
	r_PtxRegister564 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register210 + 524288ull);	   // PTX L1636
	r_LaneIndexAtPtx1638 = uint32_t((threadIdx.x & 31u));									   // PTX L1638
	r_PtxRegister1006 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1638), uint32_t(31));		   // PTX L1640
	r_PtxRegister1007 = ShiftRight(uint32_t(r_PtxRegister1006), uint32_t(30));				   // PTX L1641
	r_PtxRegister1008 = uint32_t(r_LaneIndexAtPtx1638) + uint32_t(r_PtxRegister1007);		   // PTX L1642
	r_PtxRegister1009 = r_PtxRegister1008 & 2147483644;										   // PTX L1643
	r_PtxRegister1010 = uint32_t(r_LaneIndexAtPtx1638) - uint32_t(r_PtxRegister1009);		   // PTX L1644
	r_PtxRegister1011 = ShiftLeft(uint32_t(r_PtxRegister1010), uint32_t(1));				   // PTX L1645
	r_PtxRegister1012 = uint32_t(r_PtxRegister592) + uint32_t(r_PtxRegister1011);			   // PTX L1646
	r_PtxRegister1013 = ShiftRightSigned(int32_t(r_PtxRegister1012), uint32_t(1));			   // PTX L1647
	r_PtxU64Register211 = uint64_t(int64_t(int32_t(r_PtxRegister1013)) * int64_t(int32_t(4))); // PTX L1648
	r_PtxU64Register212 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register211);	   // PTX L1649
	r_PtxRegister566 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register212 + 524288ull);	   // PTX L1650
	r_LaneIndexAtPtx1652 = uint32_t((threadIdx.x & 31u));									   // PTX L1652
	r_PtxRegister1014 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1652), uint32_t(31));		   // PTX L1654
	r_PtxRegister1015 = ShiftRight(uint32_t(r_PtxRegister1014), uint32_t(30));				   // PTX L1655
	r_PtxRegister1016 = uint32_t(r_LaneIndexAtPtx1652) + uint32_t(r_PtxRegister1015);		   // PTX L1656
	r_PtxRegister1017 = r_PtxRegister1016 & 2147483644;										   // PTX L1657
	r_PtxRegister1018 = uint32_t(r_LaneIndexAtPtx1652) - uint32_t(r_PtxRegister1017);		   // PTX L1658
	r_PtxRegister1019 = ShiftLeft(uint32_t(r_PtxRegister1018), uint32_t(1));				   // PTX L1659
	r_PtxRegister1020 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister1019);			   // PTX L1660
	r_PtxRegister1021 = ShiftRightSigned(int32_t(r_PtxRegister1020), uint32_t(1));			   // PTX L1661
	r_PtxU64Register213 = uint64_t(int64_t(int32_t(r_PtxRegister1021)) * int64_t(int32_t(4))); // PTX L1662
	r_PtxU64Register214 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register213);	   // PTX L1663
	r_PtxRegister568 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register214 + 524288ull);	   // PTX L1664
	r_LaneIndexAtPtx1666 = uint32_t((threadIdx.x & 31u));									   // PTX L1666
	r_PtxRegister1022 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1666), uint32_t(31));		   // PTX L1668
	r_PtxRegister1023 = ShiftRight(uint32_t(r_PtxRegister1022), uint32_t(30));				   // PTX L1669
	r_PtxRegister1024 = uint32_t(r_LaneIndexAtPtx1666) + uint32_t(r_PtxRegister1023);		   // PTX L1670
	r_PtxRegister1025 = r_PtxRegister1024 & 2147483644;										   // PTX L1671
	r_PtxRegister1026 = uint32_t(r_LaneIndexAtPtx1666) - uint32_t(r_PtxRegister1025);		   // PTX L1672
	r_PtxRegister1027 = ShiftLeft(uint32_t(r_PtxRegister1026), uint32_t(1));				   // PTX L1673
	r_PtxRegister1028 = uint32_t(r_PtxRegister591) + uint32_t(r_PtxRegister1027);			   // PTX L1674
	r_PtxRegister1029 = ShiftRightSigned(int32_t(r_PtxRegister1028), uint32_t(1));			   // PTX L1675
	r_PtxU64Register215 = uint64_t(int64_t(int32_t(r_PtxRegister1029)) * int64_t(int32_t(4))); // PTX L1676
	r_PtxU64Register216 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register215);	   // PTX L1677
	r_PtxRegister570 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register216 + 524288ull);	   // PTX L1678
	r_LaneIndexAtPtx1680 = uint32_t((threadIdx.x & 31u));									   // PTX L1680
	r_PtxRegister1030 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1680), uint32_t(31));		   // PTX L1682
	r_PtxRegister1031 = ShiftRight(uint32_t(r_PtxRegister1030), uint32_t(30));				   // PTX L1683
	r_PtxRegister1032 = uint32_t(r_LaneIndexAtPtx1680) + uint32_t(r_PtxRegister1031);		   // PTX L1684
	r_PtxRegister1033 = r_PtxRegister1032 & 2147483644;										   // PTX L1685
	r_PtxRegister1034 = uint32_t(r_LaneIndexAtPtx1680) - uint32_t(r_PtxRegister1033);		   // PTX L1686
	r_PtxRegister1035 = ShiftLeft(uint32_t(r_PtxRegister1034), uint32_t(1));				   // PTX L1687
	r_PtxRegister1036 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister1035);			   // PTX L1688
	r_PtxRegister1037 = ShiftRightSigned(int32_t(r_PtxRegister1036), uint32_t(1));			   // PTX L1689
	r_PtxU64Register217 = uint64_t(int64_t(int32_t(r_PtxRegister1037)) * int64_t(int32_t(4))); // PTX L1690
	r_PtxU64Register218 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register217);	   // PTX L1691
	r_PtxRegister572 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register218 + 524288ull);	   // PTX L1692
	r_LaneIndexAtPtx1694 = uint32_t((threadIdx.x & 31u));									   // PTX L1694
	r_PtxRegister1038 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1694), uint32_t(31));		   // PTX L1696
	r_PtxRegister1039 = ShiftRight(uint32_t(r_PtxRegister1038), uint32_t(30));				   // PTX L1697
	r_PtxRegister1040 = uint32_t(r_LaneIndexAtPtx1694) + uint32_t(r_PtxRegister1039);		   // PTX L1698
	r_PtxRegister1041 = r_PtxRegister1040 & 2147483644;										   // PTX L1699
	r_PtxRegister1042 = uint32_t(r_LaneIndexAtPtx1694) - uint32_t(r_PtxRegister1041);		   // PTX L1700
	r_PtxRegister1043 = ShiftLeft(uint32_t(r_PtxRegister1042), uint32_t(1));				   // PTX L1701
	r_PtxRegister1044 = uint32_t(r_PtxRegister647) + uint32_t(r_PtxRegister1043);			   // PTX L1702
	r_PtxRegister1045 = ShiftRightSigned(int32_t(r_PtxRegister1044), uint32_t(1));			   // PTX L1703
	r_PtxU64Register219 = uint64_t(int64_t(int32_t(r_PtxRegister1045)) * int64_t(int32_t(4))); // PTX L1704
	r_PtxU64Register220 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register219);	   // PTX L1705
	r_PtxRegister574 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register220 + 524288ull);	   // PTX L1706
	r_LaneIndexAtPtx1708 = uint32_t((threadIdx.x & 31u));									   // PTX L1708
	r_PtxRegister1046 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1708), uint32_t(31));		   // PTX L1710
	r_PtxRegister1047 = ShiftRight(uint32_t(r_PtxRegister1046), uint32_t(30));				   // PTX L1711
	r_PtxRegister1048 = uint32_t(r_LaneIndexAtPtx1708) + uint32_t(r_PtxRegister1047);		   // PTX L1712
	r_PtxRegister1049 = r_PtxRegister1048 & 2147483644;										   // PTX L1713
	r_PtxRegister1050 = uint32_t(r_LaneIndexAtPtx1708) - uint32_t(r_PtxRegister1049);		   // PTX L1714
	r_PtxRegister1051 = ShiftLeft(uint32_t(r_PtxRegister1050), uint32_t(1));				   // PTX L1715
	r_PtxRegister1052 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister1051);			   // PTX L1716
	r_PtxRegister1053 = ShiftRightSigned(int32_t(r_PtxRegister1052), uint32_t(1));			   // PTX L1717
	r_PtxU64Register221 = uint64_t(int64_t(int32_t(r_PtxRegister1053)) * int64_t(int32_t(4))); // PTX L1718
	r_PtxU64Register222 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register221);	   // PTX L1719
	r_PtxRegister576 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register222 + 524288ull);	   // PTX L1720
	r_LaneIndexAtPtx1722 = uint32_t((threadIdx.x & 31u));									   // PTX L1722
	r_PtxRegister1054 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1722), uint32_t(31));		   // PTX L1724
	r_PtxRegister1055 = ShiftRight(uint32_t(r_PtxRegister1054), uint32_t(30));				   // PTX L1725
	r_PtxRegister1056 = uint32_t(r_LaneIndexAtPtx1722) + uint32_t(r_PtxRegister1055);		   // PTX L1726
	r_PtxRegister1057 = r_PtxRegister1056 & 2147483644;										   // PTX L1727
	r_PtxRegister1058 = uint32_t(r_LaneIndexAtPtx1722) - uint32_t(r_PtxRegister1057);		   // PTX L1728
	r_PtxRegister1059 = ShiftLeft(uint32_t(r_PtxRegister1058), uint32_t(1));				   // PTX L1729
	r_PtxRegister1060 = uint32_t(r_PtxRegister664) + uint32_t(r_PtxRegister1059);			   // PTX L1730
	r_PtxRegister1061 = ShiftRightSigned(int32_t(r_PtxRegister1060), uint32_t(1));			   // PTX L1731
	r_PtxU64Register223 = uint64_t(int64_t(int32_t(r_PtxRegister1061)) * int64_t(int32_t(4))); // PTX L1732
	r_PtxU64Register224 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register223);	   // PTX L1733
	r_PtxRegister578 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register224 + 524288ull);	   // PTX L1734
	r_LaneIndexAtPtx1736 = uint32_t((threadIdx.x & 31u));									   // PTX L1736
	r_PtxRegister1062 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1736), uint32_t(31));		   // PTX L1738
	r_PtxRegister1063 = ShiftRight(uint32_t(r_PtxRegister1062), uint32_t(30));				   // PTX L1739
	r_PtxRegister1064 = uint32_t(r_LaneIndexAtPtx1736) + uint32_t(r_PtxRegister1063);		   // PTX L1740
	r_PtxRegister1065 = r_PtxRegister1064 & 2147483644;										   // PTX L1741
	r_PtxRegister1066 = uint32_t(r_LaneIndexAtPtx1736) - uint32_t(r_PtxRegister1065);		   // PTX L1742
	r_PtxRegister1067 = ShiftLeft(uint32_t(r_PtxRegister1066), uint32_t(1));				   // PTX L1743
	r_PtxRegister1068 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister1067);			   // PTX L1744
	r_PtxRegister1069 = ShiftRightSigned(int32_t(r_PtxRegister1068), uint32_t(1));			   // PTX L1745
	r_PtxU64Register225 = uint64_t(int64_t(int32_t(r_PtxRegister1069)) * int64_t(int32_t(4))); // PTX L1746
	r_PtxU64Register226 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register225);	   // PTX L1747
	r_PtxRegister580 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register226 + 524288ull);	   // PTX L1748
	r_LaneIndexAtPtx1750 = uint32_t((threadIdx.x & 31u));									   // PTX L1750
	r_PtxRegister1070 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1750), uint32_t(31));		   // PTX L1752
	r_PtxRegister1071 = ShiftRight(uint32_t(r_PtxRegister1070), uint32_t(30));				   // PTX L1753
	r_PtxRegister1072 = uint32_t(r_LaneIndexAtPtx1750) + uint32_t(r_PtxRegister1071);		   // PTX L1754
	r_PtxRegister1073 = r_PtxRegister1072 & 2147483644;										   // PTX L1755
	r_PtxRegister1074 = uint32_t(r_LaneIndexAtPtx1750) - uint32_t(r_PtxRegister1073);		   // PTX L1756
	r_PtxRegister1075 = ShiftLeft(uint32_t(r_PtxRegister1074), uint32_t(1));				   // PTX L1757
	r_PtxRegister1076 = uint32_t(r_PtxRegister681) + uint32_t(r_PtxRegister1075);			   // PTX L1758
	r_PtxRegister1077 = ShiftRightSigned(int32_t(r_PtxRegister1076), uint32_t(1));			   // PTX L1759
	r_PtxU64Register227 = uint64_t(int64_t(int32_t(r_PtxRegister1077)) * int64_t(int32_t(4))); // PTX L1760
	r_PtxU64Register228 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register227);	   // PTX L1761
	r_PtxRegister582 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register228 + 524288ull);	   // PTX L1762
	r_LaneIndexAtPtx1764 = uint32_t((threadIdx.x & 31u));									   // PTX L1764
	r_PtxRegister1078 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1764), uint32_t(31));		   // PTX L1766
	r_PtxRegister1079 = ShiftRight(uint32_t(r_PtxRegister1078), uint32_t(30));				   // PTX L1767
	r_PtxRegister1080 = uint32_t(r_LaneIndexAtPtx1764) + uint32_t(r_PtxRegister1079);		   // PTX L1768
	r_PtxRegister1081 = r_PtxRegister1080 & 2147483644;										   // PTX L1769
	r_PtxRegister1082 = uint32_t(r_LaneIndexAtPtx1764) - uint32_t(r_PtxRegister1081);		   // PTX L1770
	r_PtxRegister1083 = ShiftLeft(uint32_t(r_PtxRegister1082), uint32_t(1));				   // PTX L1771
	r_PtxRegister1084 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister1083);			   // PTX L1772
	r_PtxRegister1085 = ShiftRightSigned(int32_t(r_PtxRegister1084), uint32_t(1));			   // PTX L1773
	r_PtxU64Register229 = uint64_t(int64_t(int32_t(r_PtxRegister1085)) * int64_t(int32_t(4))); // PTX L1774
	r_PtxU64Register230 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register229);	   // PTX L1775
	r_PtxRegister584 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register230 + 524288ull);	   // PTX L1776
	r_LaneIndexAtPtx1778 = uint32_t((threadIdx.x & 31u));									   // PTX L1778
	r_PtxRegister1086 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1778), uint32_t(31));		   // PTX L1780
	r_PtxRegister1087 = ShiftRight(uint32_t(r_PtxRegister1086), uint32_t(30));				   // PTX L1781
	r_PtxRegister1088 = uint32_t(r_LaneIndexAtPtx1778) + uint32_t(r_PtxRegister1087);		   // PTX L1782
	r_PtxRegister1089 = r_PtxRegister1088 & 2147483644;										   // PTX L1783
	r_PtxRegister1090 = uint32_t(r_LaneIndexAtPtx1778) - uint32_t(r_PtxRegister1089);		   // PTX L1784
	r_PtxRegister1091 = ShiftLeft(uint32_t(r_PtxRegister1090), uint32_t(1));				   // PTX L1785
	r_PtxRegister1092 = uint32_t(r_PtxRegister698) + uint32_t(r_PtxRegister1091);			   // PTX L1786
	r_PtxRegister1093 = ShiftRightSigned(int32_t(r_PtxRegister1092), uint32_t(1));			   // PTX L1787
	r_PtxU64Register231 = uint64_t(int64_t(int32_t(r_PtxRegister1093)) * int64_t(int32_t(4))); // PTX L1788
	r_PtxU64Register232 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register231);	   // PTX L1789
	r_PtxRegister586 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register232 + 524288ull);	   // PTX L1790
	r_LaneIndexAtPtx1792 = uint32_t((threadIdx.x & 31u));									   // PTX L1792
	r_PtxRegister1094 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1792), uint32_t(31));		   // PTX L1794
	r_PtxRegister1095 = ShiftRight(uint32_t(r_PtxRegister1094), uint32_t(30));				   // PTX L1795
	r_PtxRegister1096 = uint32_t(r_LaneIndexAtPtx1792) + uint32_t(r_PtxRegister1095);		   // PTX L1796
	r_PtxRegister1097 = r_PtxRegister1096 & 2147483644;										   // PTX L1797
	r_PtxRegister1098 = uint32_t(r_LaneIndexAtPtx1792) - uint32_t(r_PtxRegister1097);		   // PTX L1798
	r_PtxRegister1099 = ShiftLeft(uint32_t(r_PtxRegister1098), uint32_t(1));				   // PTX L1799
	r_PtxRegister1100 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister1099);			   // PTX L1800
	r_PtxRegister1101 = ShiftRightSigned(int32_t(r_PtxRegister1100), uint32_t(1));			   // PTX L1801
	r_PtxU64Register233 = uint64_t(int64_t(int32_t(r_PtxRegister1101)) * int64_t(int32_t(4))); // PTX L1802
	r_PtxU64Register234 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register233);	   // PTX L1803
	r_PtxRegister588 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register234 + 524288ull);	   // PTX L1804
	r_LaneIndexAtPtx1806 = uint32_t((threadIdx.x & 31u));									   // PTX L1806
	r_PtxRegister1102 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx1806), uint32_t(31));		   // PTX L1808
	r_PtxRegister1103 = ShiftRight(uint32_t(r_PtxRegister1102), uint32_t(30));				   // PTX L1809
	r_PtxRegister1104 = uint32_t(r_LaneIndexAtPtx1806) + uint32_t(r_PtxRegister1103);		   // PTX L1810
	r_PtxRegister1105 = r_PtxRegister1104 & 2147483644;										   // PTX L1811
	r_PtxRegister1106 = uint32_t(r_LaneIndexAtPtx1806) - uint32_t(r_PtxRegister1105);		   // PTX L1812
	r_PtxRegister1107 = ShiftLeft(uint32_t(r_PtxRegister1106), uint32_t(1));				   // PTX L1813
	r_PtxRegister1108 = uint32_t(r_PtxRegister715) + uint32_t(r_PtxRegister1107);			   // PTX L1814
	r_PtxRegister1109 = ShiftRightSigned(int32_t(r_PtxRegister1108), uint32_t(1));			   // PTX L1815
	r_PtxU64Register235 = uint64_t(int64_t(int32_t(r_PtxRegister1109)) * int64_t(int32_t(4))); // PTX L1816
	r_PtxU64Register236 = uint64_t(r_PtxU64Register108) + uint64_t(r_PtxU64Register235);	   // PTX L1817
	r_PtxRegister590 = *reinterpret_cast<const uint32_t*>(r_PtxU64Register236 + 524288ull);	   // PTX L1818
	r_LaneIndexAtPtx1820 = uint32_t((threadIdx.x & 31u));									   // PTX L1820
	r_PackedHalf2AtPtx1823R2700 = HalfMul(r_PackedHalf2AtPtx583R2573, r_PtxRegister464);	   // PTX L1823
	r_LaneIndexAtPtx1827 = uint32_t((threadIdx.x & 31u));									   // PTX L1827
	r_PackedHalf2AtPtx1830R2699 = HalfMul(r_PackedHalf2AtPtx584R2574, r_PtxRegister466);	   // PTX L1830
	r_LaneIndexAtPtx1834 = uint32_t((threadIdx.x & 31u));									   // PTX L1834
	r_PackedHalf2AtPtx1837R2698 = HalfMul(r_PackedHalf2AtPtx585R2575, r_PtxRegister468);	   // PTX L1837
	r_LaneIndexAtPtx1841 = uint32_t((threadIdx.x & 31u));									   // PTX L1841
	r_PackedHalf2AtPtx1844R2697 = HalfMul(r_PackedHalf2AtPtx586R2576, r_PtxRegister470);	   // PTX L1844
	r_LaneIndexAtPtx1848 = uint32_t((threadIdx.x & 31u));									   // PTX L1848
	r_PackedHalf2AtPtx1851R2696 = HalfMul(r_PackedHalf2AtPtx602R2577, r_PtxRegister472);	   // PTX L1851
	r_LaneIndexAtPtx1855 = uint32_t((threadIdx.x & 31u));									   // PTX L1855
	r_PackedHalf2AtPtx1858R2695 = HalfMul(r_PackedHalf2AtPtx603R2578, r_PtxRegister474);	   // PTX L1858
	r_LaneIndexAtPtx1862 = uint32_t((threadIdx.x & 31u));									   // PTX L1862
	r_PackedHalf2AtPtx1865R2694 = HalfMul(r_PackedHalf2AtPtx604R2579, r_PtxRegister476);	   // PTX L1865
	r_LaneIndexAtPtx1869 = uint32_t((threadIdx.x & 31u));									   // PTX L1869
	r_PackedHalf2AtPtx1872R2693 = HalfMul(r_PackedHalf2AtPtx605R2580, r_PtxRegister478);	   // PTX L1872
	r_LaneIndexAtPtx1876 = uint32_t((threadIdx.x & 31u));									   // PTX L1876
	r_PackedHalf2AtPtx1879R2692 = HalfMul(r_PackedHalf2AtPtx621R2581, r_PtxRegister480);	   // PTX L1879
	r_LaneIndexAtPtx1883 = uint32_t((threadIdx.x & 31u));									   // PTX L1883
	r_PackedHalf2AtPtx1886R2691 = HalfMul(r_PackedHalf2AtPtx622R2582, r_PtxRegister482);	   // PTX L1886
	r_LaneIndexAtPtx1890 = uint32_t((threadIdx.x & 31u));									   // PTX L1890
	r_PackedHalf2AtPtx1893R2690 = HalfMul(r_PackedHalf2AtPtx623R2583, r_PtxRegister484);	   // PTX L1893
	r_LaneIndexAtPtx1897 = uint32_t((threadIdx.x & 31u));									   // PTX L1897
	r_PackedHalf2AtPtx1900R2689 = HalfMul(r_PackedHalf2AtPtx624R2584, r_PtxRegister486);	   // PTX L1900
	r_LaneIndexAtPtx1904 = uint32_t((threadIdx.x & 31u));									   // PTX L1904
	r_PackedHalf2AtPtx1907R2688 = HalfMul(r_PackedHalf2AtPtx640R2585, r_PtxRegister488);	   // PTX L1907
	r_LaneIndexAtPtx1911 = uint32_t((threadIdx.x & 31u));									   // PTX L1911
	r_PackedHalf2AtPtx1914R2687 = HalfMul(r_PackedHalf2AtPtx641R2586, r_PtxRegister490);	   // PTX L1914
	r_LaneIndexAtPtx1918 = uint32_t((threadIdx.x & 31u));									   // PTX L1918
	r_PackedHalf2AtPtx1921R2686 = HalfMul(r_PackedHalf2AtPtx642R2587, r_PtxRegister492);	   // PTX L1921
	r_LaneIndexAtPtx1925 = uint32_t((threadIdx.x & 31u));									   // PTX L1925
	r_PackedHalf2AtPtx1928R2685 = HalfMul(r_PackedHalf2AtPtx643R2588, r_PtxRegister494);	   // PTX L1928
	r_LaneIndexAtPtx1932 = uint32_t((threadIdx.x & 31u));									   // PTX L1932
	r_PackedHalf2AtPtx1935R2684 = HalfMul(r_PackedHalf2AtPtx665R2589, r_PtxRegister496);	   // PTX L1935
	r_LaneIndexAtPtx1939 = uint32_t((threadIdx.x & 31u));									   // PTX L1939
	r_PackedHalf2AtPtx1942R2683 = HalfMul(r_PackedHalf2AtPtx666R2590, r_PtxRegister498);	   // PTX L1942
	r_LaneIndexAtPtx1946 = uint32_t((threadIdx.x & 31u));									   // PTX L1946
	r_PackedHalf2AtPtx1949R2682 = HalfMul(r_PackedHalf2AtPtx667R2591, r_PtxRegister500);	   // PTX L1949
	r_LaneIndexAtPtx1953 = uint32_t((threadIdx.x & 31u));									   // PTX L1953
	r_PackedHalf2AtPtx1956R2681 = HalfMul(r_PackedHalf2AtPtx668R2592, r_PtxRegister502);	   // PTX L1956
	r_LaneIndexAtPtx1960 = uint32_t((threadIdx.x & 31u));									   // PTX L1960
	r_PackedHalf2AtPtx1963R2680 = HalfMul(r_PackedHalf2AtPtx684R2593, r_PtxRegister504);	   // PTX L1963
	r_LaneIndexAtPtx1967 = uint32_t((threadIdx.x & 31u));									   // PTX L1967
	r_PackedHalf2AtPtx1970R2679 = HalfMul(r_PackedHalf2AtPtx685R2594, r_PtxRegister506);	   // PTX L1970
	r_LaneIndexAtPtx1974 = uint32_t((threadIdx.x & 31u));									   // PTX L1974
	r_PackedHalf2AtPtx1977R2678 = HalfMul(r_PackedHalf2AtPtx686R2595, r_PtxRegister508);	   // PTX L1977
	r_LaneIndexAtPtx1981 = uint32_t((threadIdx.x & 31u));									   // PTX L1981
	r_PackedHalf2AtPtx1984R2677 = HalfMul(r_PackedHalf2AtPtx687R2596, r_PtxRegister510);	   // PTX L1984
	r_LaneIndexAtPtx1988 = uint32_t((threadIdx.x & 31u));									   // PTX L1988
	r_PackedHalf2AtPtx1991R2676 = HalfMul(r_PackedHalf2AtPtx703R2597, r_PtxRegister512);	   // PTX L1991
	r_LaneIndexAtPtx1995 = uint32_t((threadIdx.x & 31u));									   // PTX L1995
	r_PackedHalf2AtPtx1998R2675 = HalfMul(r_PackedHalf2AtPtx704R2598, r_PtxRegister514);	   // PTX L1998
	r_LaneIndexAtPtx2002 = uint32_t((threadIdx.x & 31u));									   // PTX L2002
	r_PackedHalf2AtPtx2005R2674 = HalfMul(r_PackedHalf2AtPtx705R2599, r_PtxRegister516);	   // PTX L2005
	r_LaneIndexAtPtx2009 = uint32_t((threadIdx.x & 31u));									   // PTX L2009
	r_PackedHalf2AtPtx2012R2673 = HalfMul(r_PackedHalf2AtPtx706R2600, r_PtxRegister518);	   // PTX L2012
	r_LaneIndexAtPtx2016 = uint32_t((threadIdx.x & 31u));									   // PTX L2016
	r_PackedHalf2AtPtx2019R2672 = HalfMul(r_PackedHalf2AtPtx722R2601, r_PtxRegister520);	   // PTX L2019
	r_LaneIndexAtPtx2023 = uint32_t((threadIdx.x & 31u));									   // PTX L2023
	r_PackedHalf2AtPtx2026R2671 = HalfMul(r_PackedHalf2AtPtx723R2602, r_PtxRegister522);	   // PTX L2026
	r_LaneIndexAtPtx2030 = uint32_t((threadIdx.x & 31u));									   // PTX L2030
	r_PackedHalf2AtPtx2033R2670 = HalfMul(r_PackedHalf2AtPtx724R2603, r_PtxRegister524);	   // PTX L2033
	r_LaneIndexAtPtx2037 = uint32_t((threadIdx.x & 31u));									   // PTX L2037
	r_PackedHalf2AtPtx2040R2669 = HalfMul(r_PackedHalf2AtPtx725R2604, r_PtxRegister526);	   // PTX L2040
	r_LaneIndexAtPtx2044 = uint32_t((threadIdx.x & 31u));									   // PTX L2044
	r_PackedHalf2AtPtx2047R2668 = HalfMul(r_PackedHalf2AtPtx758R2605, r_PtxRegister528);	   // PTX L2047
	r_LaneIndexAtPtx2051 = uint32_t((threadIdx.x & 31u));									   // PTX L2051
	r_PackedHalf2AtPtx2054R2667 = HalfMul(r_PackedHalf2AtPtx759R2606, r_PtxRegister530);	   // PTX L2054
	r_LaneIndexAtPtx2058 = uint32_t((threadIdx.x & 31u));									   // PTX L2058
	r_PackedHalf2AtPtx2061R2666 = HalfMul(r_PackedHalf2AtPtx760R2607, r_PtxRegister532);	   // PTX L2061
	r_LaneIndexAtPtx2065 = uint32_t((threadIdx.x & 31u));									   // PTX L2065
	r_PackedHalf2AtPtx2068R2665 = HalfMul(r_PackedHalf2AtPtx761R2608, r_PtxRegister534);	   // PTX L2068
	r_LaneIndexAtPtx2072 = uint32_t((threadIdx.x & 31u));									   // PTX L2072
	r_PackedHalf2AtPtx2075R2664 = HalfMul(r_PackedHalf2AtPtx777R2609, r_PtxRegister536);	   // PTX L2075
	r_LaneIndexAtPtx2079 = uint32_t((threadIdx.x & 31u));									   // PTX L2079
	r_PackedHalf2AtPtx2082R2663 = HalfMul(r_PackedHalf2AtPtx778R2610, r_PtxRegister538);	   // PTX L2082
	r_LaneIndexAtPtx2086 = uint32_t((threadIdx.x & 31u));									   // PTX L2086
	r_PackedHalf2AtPtx2089R2662 = HalfMul(r_PackedHalf2AtPtx779R2611, r_PtxRegister540);	   // PTX L2089
	r_LaneIndexAtPtx2093 = uint32_t((threadIdx.x & 31u));									   // PTX L2093
	r_PackedHalf2AtPtx2096R2661 = HalfMul(r_PackedHalf2AtPtx780R2612, r_PtxRegister542);	   // PTX L2096
	r_LaneIndexAtPtx2100 = uint32_t((threadIdx.x & 31u));									   // PTX L2100
	r_PackedHalf2AtPtx2103R2660 = HalfMul(r_PackedHalf2AtPtx796R2613, r_PtxRegister544);	   // PTX L2103
	r_LaneIndexAtPtx2107 = uint32_t((threadIdx.x & 31u));									   // PTX L2107
	r_PackedHalf2AtPtx2110R2659 = HalfMul(r_PackedHalf2AtPtx797R2614, r_PtxRegister546);	   // PTX L2110
	r_LaneIndexAtPtx2114 = uint32_t((threadIdx.x & 31u));									   // PTX L2114
	r_PackedHalf2AtPtx2117R2658 = HalfMul(r_PackedHalf2AtPtx798R2615, r_PtxRegister548);	   // PTX L2117
	r_LaneIndexAtPtx2121 = uint32_t((threadIdx.x & 31u));									   // PTX L2121
	r_PackedHalf2AtPtx2124R2657 = HalfMul(r_PackedHalf2AtPtx799R2616, r_PtxRegister550);	   // PTX L2124
	r_LaneIndexAtPtx2128 = uint32_t((threadIdx.x & 31u));									   // PTX L2128
	r_PackedHalf2AtPtx2131R2656 = HalfMul(r_PackedHalf2AtPtx815R2617, r_PtxRegister552);	   // PTX L2131
	r_LaneIndexAtPtx2135 = uint32_t((threadIdx.x & 31u));									   // PTX L2135
	r_PackedHalf2AtPtx2138R2655 = HalfMul(r_PackedHalf2AtPtx816R2618, r_PtxRegister554);	   // PTX L2138
	r_LaneIndexAtPtx2142 = uint32_t((threadIdx.x & 31u));									   // PTX L2142
	r_PackedHalf2AtPtx2145R2654 = HalfMul(r_PackedHalf2AtPtx817R2619, r_PtxRegister556);	   // PTX L2145
	r_LaneIndexAtPtx2149 = uint32_t((threadIdx.x & 31u));									   // PTX L2149
	r_PackedHalf2AtPtx2152R2653 = HalfMul(r_PackedHalf2AtPtx818R2620, r_PtxRegister558);	   // PTX L2152
	r_LaneIndexAtPtx2156 = uint32_t((threadIdx.x & 31u));									   // PTX L2156
	r_PackedHalf2AtPtx2159R2652 = HalfMul(r_PackedHalf2AtPtx839R2621, r_PtxRegister560);	   // PTX L2159
	r_LaneIndexAtPtx2163 = uint32_t((threadIdx.x & 31u));									   // PTX L2163
	r_PackedHalf2AtPtx2166R2651 = HalfMul(r_PackedHalf2AtPtx840R2622, r_PtxRegister562);	   // PTX L2166
	r_LaneIndexAtPtx2170 = uint32_t((threadIdx.x & 31u));									   // PTX L2170
	r_PackedHalf2AtPtx2173R2650 = HalfMul(r_PackedHalf2AtPtx841R2623, r_PtxRegister564);	   // PTX L2173
	r_LaneIndexAtPtx2177 = uint32_t((threadIdx.x & 31u));									   // PTX L2177
	r_PackedHalf2AtPtx2180R2649 = HalfMul(r_PackedHalf2AtPtx842R2624, r_PtxRegister566);	   // PTX L2180
	r_LaneIndexAtPtx2184 = uint32_t((threadIdx.x & 31u));									   // PTX L2184
	r_PackedHalf2AtPtx2187R2648 = HalfMul(r_PackedHalf2AtPtx858R2625, r_PtxRegister568);	   // PTX L2187
	r_LaneIndexAtPtx2191 = uint32_t((threadIdx.x & 31u));									   // PTX L2191
	r_PackedHalf2AtPtx2194R2647 = HalfMul(r_PackedHalf2AtPtx859R2626, r_PtxRegister570);	   // PTX L2194
	r_LaneIndexAtPtx2198 = uint32_t((threadIdx.x & 31u));									   // PTX L2198
	r_PackedHalf2AtPtx2201R2646 = HalfMul(r_PackedHalf2AtPtx860R2627, r_PtxRegister572);	   // PTX L2201
	r_LaneIndexAtPtx2205 = uint32_t((threadIdx.x & 31u));									   // PTX L2205
	r_PackedHalf2AtPtx2208R2645 = HalfMul(r_PackedHalf2AtPtx861R2628, r_PtxRegister574);	   // PTX L2208
	r_LaneIndexAtPtx2212 = uint32_t((threadIdx.x & 31u));									   // PTX L2212
	r_PackedHalf2AtPtx2215R2644 = HalfMul(r_PackedHalf2AtPtx877R2629, r_PtxRegister576);	   // PTX L2215
	r_LaneIndexAtPtx2219 = uint32_t((threadIdx.x & 31u));									   // PTX L2219
	r_PackedHalf2AtPtx2222R2643 = HalfMul(r_PackedHalf2AtPtx878R2630, r_PtxRegister578);	   // PTX L2222
	r_LaneIndexAtPtx2226 = uint32_t((threadIdx.x & 31u));									   // PTX L2226
	r_PackedHalf2AtPtx2229R2642 = HalfMul(r_PackedHalf2AtPtx879R2631, r_PtxRegister580);	   // PTX L2229
	r_LaneIndexAtPtx2233 = uint32_t((threadIdx.x & 31u));									   // PTX L2233
	r_PackedHalf2AtPtx2236R2641 = HalfMul(r_PackedHalf2AtPtx880R2632, r_PtxRegister582);	   // PTX L2236
	r_LaneIndexAtPtx2240 = uint32_t((threadIdx.x & 31u));									   // PTX L2240
	r_PackedHalf2AtPtx2243R2640 = HalfMul(r_PackedHalf2AtPtx896R2633, r_PtxRegister584);	   // PTX L2243
	r_LaneIndexAtPtx2247 = uint32_t((threadIdx.x & 31u));									   // PTX L2247
	r_PackedHalf2AtPtx2250R2639 = HalfMul(r_PackedHalf2AtPtx897R2634, r_PtxRegister586);	   // PTX L2250
	r_LaneIndexAtPtx2254 = uint32_t((threadIdx.x & 31u));									   // PTX L2254
	r_PackedHalf2AtPtx2257R2638 = HalfMul(r_PackedHalf2AtPtx898R2635, r_PtxRegister588);	   // PTX L2257
	r_LaneIndexAtPtx2261 = uint32_t((threadIdx.x & 31u));									   // PTX L2261
	r_PackedHalf2AtPtx2264R2637 = HalfMul(r_PackedHalf2AtPtx899R2636, r_PtxRegister590);	   // PTX L2264
	r_PtxRegister2701 = uint32_t(0);														   // PTX L2267
L__BB34_103:																				   // PTX L2268
	r_PtxRegister1222 = ShiftRight(uint32_t(r_PtxRegister2701), uint32_t(5));				   // PTX L2269
	r_PtxU16Register1 = uint16_t(r_PtxRegister1222);										   // PTX L2270
	r_PtxU16Register2 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register1)) * uint32_t(uint16_t(171)));				 // PTX L2271
	r_PtxU16Register3 = ShiftRight(uint16_t(r_PtxU16Register2), uint32_t(9));					 // PTX L2272
	r_PtxU16Register4 = uint16_t(uint32_t(uint16_t(r_PtxU16Register3)) * uint32_t(uint16_t(3))); // PTX L2273
	r_PtxU16Register5 = uint16_t(r_PtxU16Register1) - uint16_t(r_PtxU16Register4);				 // PTX L2274
	r_PtxRegister1223 = uint32_t(uint16_t(r_PtxU16Register5));									 // PTX L2275
	r_PtxRegister35 = r_PtxRegister1223 & 255;													 // PTX L2276
	r_PtxU16Register6 = r_PtxU16Register5 & 255;												 // PTX L2277
	r_PtxRegister1224 = uint32_t(uint16_t(r_PtxU16Register6)) * uint32_t(uint16_t(4096));		 // PTX L2278
	r_LaneIndexAtPtx2280 = uint32_t((threadIdx.x & 31u));										 // PTX L2280
	r_PtxRegister1225 = uint32_t(0u /* exact native shared-region offset */);					 // PTX L2282
	r_PtxRegister36 = uint32_t(r_PtxRegister1225) + uint32_t(r_PtxRegister1224);				 // PTX L2283
	r_PtxRegister1226 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2280), uint32_t(4));					 // PTX L2284
	r_PtxRegister1111 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1226);				 // PTX L2285
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1111));
		r_MmaAHalf2WordAtPtx2287R1126 = r_Value.x;
		r_MmaAHalf2WordAtPtx2287R1127 = r_Value.y;
		r_MmaAHalf2WordAtPtx2287R1128 = r_Value.z;
		r_MmaAHalf2WordAtPtx2287R1129 = r_Value.w;
	} // PTX L2287
	r_LaneIndexAtPtx2290 = uint32_t((threadIdx.x & 31u));						 // PTX L2290
	r_PtxRegister1227 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2290), uint32_t(4));	 // PTX L2292
	r_PtxRegister1228 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1227); // PTX L2293
	r_PtxRegister1113 = uint32_t(r_PtxRegister1228) + uint32_t(512);			 // PTX L2294
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1113));
		r_MmaAHalf2WordAtPtx2296R1130 = r_Value.x;
		r_MmaAHalf2WordAtPtx2296R1131 = r_Value.y;
		r_MmaAHalf2WordAtPtx2296R1132 = r_Value.z;
		r_MmaAHalf2WordAtPtx2296R1133 = r_Value.w;
	} // PTX L2296
	r_LaneIndexAtPtx2299 = uint32_t((threadIdx.x & 31u));						 // PTX L2299
	r_PtxRegister1229 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2299), uint32_t(4));	 // PTX L2301
	r_PtxRegister1230 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1229); // PTX L2302
	r_PtxRegister1115 = uint32_t(r_PtxRegister1230) + uint32_t(1024);			 // PTX L2303
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1115));
		r_MmaAHalf2WordAtPtx2305R1150 = r_Value.x;
		r_MmaAHalf2WordAtPtx2305R1151 = r_Value.y;
		r_MmaAHalf2WordAtPtx2305R1152 = r_Value.z;
		r_MmaAHalf2WordAtPtx2305R1153 = r_Value.w;
	} // PTX L2305
	r_LaneIndexAtPtx2308 = uint32_t((threadIdx.x & 31u));						 // PTX L2308
	r_PtxRegister1231 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2308), uint32_t(4));	 // PTX L2310
	r_PtxRegister1232 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1231); // PTX L2311
	r_PtxRegister1117 = uint32_t(r_PtxRegister1232) + uint32_t(1536);			 // PTX L2312
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1117));
		r_MmaAHalf2WordAtPtx2314R1154 = r_Value.x;
		r_MmaAHalf2WordAtPtx2314R1155 = r_Value.y;
		r_MmaAHalf2WordAtPtx2314R1156 = r_Value.z;
		r_MmaAHalf2WordAtPtx2314R1157 = r_Value.w;
	} // PTX L2314
	r_LaneIndexAtPtx2317 = uint32_t((threadIdx.x & 31u));						 // PTX L2317
	r_PtxRegister1233 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2317), uint32_t(4));	 // PTX L2319
	r_PtxRegister1234 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1233); // PTX L2320
	r_PtxRegister1119 = uint32_t(r_PtxRegister1234) + uint32_t(2048);			 // PTX L2321
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1119));
		r_MmaAHalf2WordAtPtx2323R1174 = r_Value.x;
		r_MmaAHalf2WordAtPtx2323R1175 = r_Value.y;
		r_MmaAHalf2WordAtPtx2323R1176 = r_Value.z;
		r_MmaAHalf2WordAtPtx2323R1177 = r_Value.w;
	} // PTX L2323
	r_LaneIndexAtPtx2326 = uint32_t((threadIdx.x & 31u));						 // PTX L2326
	r_PtxRegister1235 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2326), uint32_t(4));	 // PTX L2328
	r_PtxRegister1236 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1235); // PTX L2329
	r_PtxRegister1121 = uint32_t(r_PtxRegister1236) + uint32_t(2560);			 // PTX L2330
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1121));
		r_MmaAHalf2WordAtPtx2332R1178 = r_Value.x;
		r_MmaAHalf2WordAtPtx2332R1179 = r_Value.y;
		r_MmaAHalf2WordAtPtx2332R1180 = r_Value.z;
		r_MmaAHalf2WordAtPtx2332R1181 = r_Value.w;
	} // PTX L2332
	r_LaneIndexAtPtx2335 = uint32_t((threadIdx.x & 31u));						 // PTX L2335
	r_PtxRegister1237 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2335), uint32_t(4));	 // PTX L2337
	r_PtxRegister1238 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1237); // PTX L2338
	r_PtxRegister1123 = uint32_t(r_PtxRegister1238) + uint32_t(3072);			 // PTX L2339
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1123));
		r_MmaAHalf2WordAtPtx2341R1198 = r_Value.x;
		r_MmaAHalf2WordAtPtx2341R1199 = r_Value.y;
		r_MmaAHalf2WordAtPtx2341R1200 = r_Value.z;
		r_MmaAHalf2WordAtPtx2341R1201 = r_Value.w;
	} // PTX L2341
	r_LaneIndexAtPtx2344 = uint32_t((threadIdx.x & 31u));						 // PTX L2344
	r_PtxRegister1239 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2344), uint32_t(4));	 // PTX L2346
	r_PtxRegister1240 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1239); // PTX L2347
	r_PtxRegister1125 = uint32_t(r_PtxRegister1240) + uint32_t(3584);			 // PTX L2348
	{
		const uint4 r_Value = *reinterpret_cast<const uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1125));
		r_MmaAHalf2WordAtPtx2350R1202 = r_Value.x;
		r_MmaAHalf2WordAtPtx2350R1203 = r_Value.y;
		r_MmaAHalf2WordAtPtx2350R1204 = r_Value.z;
		r_MmaAHalf2WordAtPtx2350R1205 = r_Value.w;
	} // PTX L2350
	// Phase: tensor_accumulation. Tensor-fragment accumulation starts here. The selected helper retains the independent K32 FP8 or K16 FP16 operand contract.
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2353R1134, r_MmaAccumulatorHalf2WordAtPtx2353R1135,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx85R2733, r_MmaBHalf2WordAtPtx85R2732,
			r_PackedHalf2AtPtx1823R2700, r_PackedHalf2AtPtx1830R2699); // PTX L2353
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2360R1136, r_MmaAccumulatorHalf2WordAtPtx2360R1137,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx85R2731, r_MmaBHalf2WordAtPtx85R2730,
			r_PackedHalf2AtPtx1837R2698, r_PackedHalf2AtPtx1844R2697); // PTX L2360
	MmaHalf(r_PackedHalf2AtPtx1823R2700, r_PackedHalf2AtPtx1830R2699, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx124R2717, r_MmaBHalf2WordAtPtx124R2716,
			r_MmaAccumulatorHalf2WordAtPtx2353R1134,
			r_MmaAccumulatorHalf2WordAtPtx2353R1135); // PTX L2367
	MmaHalf(r_PackedHalf2AtPtx1837R2698, r_PackedHalf2AtPtx1844R2697, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx124R2715, r_MmaBHalf2WordAtPtx124R2714,
			r_MmaAccumulatorHalf2WordAtPtx2360R1136,
			r_MmaAccumulatorHalf2WordAtPtx2360R1137); // PTX L2374
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2381R1138, r_MmaAccumulatorHalf2WordAtPtx2381R1139,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx95R2729, r_MmaBHalf2WordAtPtx95R2728,
			r_PackedHalf2AtPtx1851R2696, r_PackedHalf2AtPtx1858R2695); // PTX L2381
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2388R1140, r_MmaAccumulatorHalf2WordAtPtx2388R1141,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx95R2727, r_MmaBHalf2WordAtPtx95R2726,
			r_PackedHalf2AtPtx1865R2694, r_PackedHalf2AtPtx1872R2693); // PTX L2388
	MmaHalf(r_PackedHalf2AtPtx1851R2696, r_PackedHalf2AtPtx1858R2695, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx133R2713, r_MmaBHalf2WordAtPtx133R2712,
			r_MmaAccumulatorHalf2WordAtPtx2381R1138,
			r_MmaAccumulatorHalf2WordAtPtx2381R1139); // PTX L2395
	MmaHalf(r_PackedHalf2AtPtx1865R2694, r_PackedHalf2AtPtx1872R2693, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx133R2711, r_MmaBHalf2WordAtPtx133R2710,
			r_MmaAccumulatorHalf2WordAtPtx2388R1140,
			r_MmaAccumulatorHalf2WordAtPtx2388R1141); // PTX L2402
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2409R1142, r_MmaAccumulatorHalf2WordAtPtx2409R1143,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx105R2725, r_MmaBHalf2WordAtPtx105R2724,
			r_PackedHalf2AtPtx1879R2692, r_PackedHalf2AtPtx1886R2691); // PTX L2409
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2416R1144, r_MmaAccumulatorHalf2WordAtPtx2416R1145,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx105R2723, r_MmaBHalf2WordAtPtx105R2722,
			r_PackedHalf2AtPtx1893R2690, r_PackedHalf2AtPtx1900R2689); // PTX L2416
	MmaHalf(r_PackedHalf2AtPtx1879R2692, r_PackedHalf2AtPtx1886R2691, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx142R2709, r_MmaBHalf2WordAtPtx142R2708,
			r_MmaAccumulatorHalf2WordAtPtx2409R1142,
			r_MmaAccumulatorHalf2WordAtPtx2409R1143); // PTX L2423
	MmaHalf(r_PackedHalf2AtPtx1893R2690, r_PackedHalf2AtPtx1900R2689, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx142R2707, r_MmaBHalf2WordAtPtx142R2706,
			r_MmaAccumulatorHalf2WordAtPtx2416R1144,
			r_MmaAccumulatorHalf2WordAtPtx2416R1145); // PTX L2430
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2437R1146, r_MmaAccumulatorHalf2WordAtPtx2437R1147,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx115R2721, r_MmaBHalf2WordAtPtx115R2720,
			r_PackedHalf2AtPtx1907R2688, r_PackedHalf2AtPtx1914R2687); // PTX L2437
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2444R1148, r_MmaAccumulatorHalf2WordAtPtx2444R1149,
			r_MmaAHalf2WordAtPtx2287R1126, r_MmaAHalf2WordAtPtx2287R1127, r_MmaAHalf2WordAtPtx2287R1128,
			r_MmaAHalf2WordAtPtx2287R1129, r_MmaBHalf2WordAtPtx115R2719, r_MmaBHalf2WordAtPtx115R2718,
			r_PackedHalf2AtPtx1921R2686, r_PackedHalf2AtPtx1928R2685); // PTX L2444
	MmaHalf(r_PackedHalf2AtPtx1907R2688, r_PackedHalf2AtPtx1914R2687, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx151R2705, r_MmaBHalf2WordAtPtx151R2704,
			r_MmaAccumulatorHalf2WordAtPtx2437R1146,
			r_MmaAccumulatorHalf2WordAtPtx2437R1147); // PTX L2451
	MmaHalf(r_PackedHalf2AtPtx1921R2686, r_PackedHalf2AtPtx1928R2685, r_MmaAHalf2WordAtPtx2296R1130,
			r_MmaAHalf2WordAtPtx2296R1131, r_MmaAHalf2WordAtPtx2296R1132, r_MmaAHalf2WordAtPtx2296R1133,
			r_MmaBHalf2WordAtPtx151R2703, r_MmaBHalf2WordAtPtx151R2702,
			r_MmaAccumulatorHalf2WordAtPtx2444R1148,
			r_MmaAccumulatorHalf2WordAtPtx2444R1149); // PTX L2458
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2465R1158, r_MmaAccumulatorHalf2WordAtPtx2465R1159,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx85R2733, r_MmaBHalf2WordAtPtx85R2732,
			r_PackedHalf2AtPtx1935R2684, r_PackedHalf2AtPtx1942R2683); // PTX L2465
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2472R1160, r_MmaAccumulatorHalf2WordAtPtx2472R1161,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx85R2731, r_MmaBHalf2WordAtPtx85R2730,
			r_PackedHalf2AtPtx1949R2682, r_PackedHalf2AtPtx1956R2681); // PTX L2472
	MmaHalf(r_PackedHalf2AtPtx1935R2684, r_PackedHalf2AtPtx1942R2683, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx124R2717, r_MmaBHalf2WordAtPtx124R2716,
			r_MmaAccumulatorHalf2WordAtPtx2465R1158,
			r_MmaAccumulatorHalf2WordAtPtx2465R1159); // PTX L2479
	MmaHalf(r_PackedHalf2AtPtx1949R2682, r_PackedHalf2AtPtx1956R2681, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx124R2715, r_MmaBHalf2WordAtPtx124R2714,
			r_MmaAccumulatorHalf2WordAtPtx2472R1160,
			r_MmaAccumulatorHalf2WordAtPtx2472R1161); // PTX L2486
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2493R1162, r_MmaAccumulatorHalf2WordAtPtx2493R1163,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx95R2729, r_MmaBHalf2WordAtPtx95R2728,
			r_PackedHalf2AtPtx1963R2680, r_PackedHalf2AtPtx1970R2679); // PTX L2493
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2500R1164, r_MmaAccumulatorHalf2WordAtPtx2500R1165,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx95R2727, r_MmaBHalf2WordAtPtx95R2726,
			r_PackedHalf2AtPtx1977R2678, r_PackedHalf2AtPtx1984R2677); // PTX L2500
	MmaHalf(r_PackedHalf2AtPtx1963R2680, r_PackedHalf2AtPtx1970R2679, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx133R2713, r_MmaBHalf2WordAtPtx133R2712,
			r_MmaAccumulatorHalf2WordAtPtx2493R1162,
			r_MmaAccumulatorHalf2WordAtPtx2493R1163); // PTX L2507
	MmaHalf(r_PackedHalf2AtPtx1977R2678, r_PackedHalf2AtPtx1984R2677, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx133R2711, r_MmaBHalf2WordAtPtx133R2710,
			r_MmaAccumulatorHalf2WordAtPtx2500R1164,
			r_MmaAccumulatorHalf2WordAtPtx2500R1165); // PTX L2514
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2521R1166, r_MmaAccumulatorHalf2WordAtPtx2521R1167,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx105R2725, r_MmaBHalf2WordAtPtx105R2724,
			r_PackedHalf2AtPtx1991R2676, r_PackedHalf2AtPtx1998R2675); // PTX L2521
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2528R1168, r_MmaAccumulatorHalf2WordAtPtx2528R1169,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx105R2723, r_MmaBHalf2WordAtPtx105R2722,
			r_PackedHalf2AtPtx2005R2674, r_PackedHalf2AtPtx2012R2673); // PTX L2528
	MmaHalf(r_PackedHalf2AtPtx1991R2676, r_PackedHalf2AtPtx1998R2675, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx142R2709, r_MmaBHalf2WordAtPtx142R2708,
			r_MmaAccumulatorHalf2WordAtPtx2521R1166,
			r_MmaAccumulatorHalf2WordAtPtx2521R1167); // PTX L2535
	MmaHalf(r_PackedHalf2AtPtx2005R2674, r_PackedHalf2AtPtx2012R2673, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx142R2707, r_MmaBHalf2WordAtPtx142R2706,
			r_MmaAccumulatorHalf2WordAtPtx2528R1168,
			r_MmaAccumulatorHalf2WordAtPtx2528R1169); // PTX L2542
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2549R1170, r_MmaAccumulatorHalf2WordAtPtx2549R1171,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx115R2721, r_MmaBHalf2WordAtPtx115R2720,
			r_PackedHalf2AtPtx2019R2672, r_PackedHalf2AtPtx2026R2671); // PTX L2549
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2556R1172, r_MmaAccumulatorHalf2WordAtPtx2556R1173,
			r_MmaAHalf2WordAtPtx2305R1150, r_MmaAHalf2WordAtPtx2305R1151, r_MmaAHalf2WordAtPtx2305R1152,
			r_MmaAHalf2WordAtPtx2305R1153, r_MmaBHalf2WordAtPtx115R2719, r_MmaBHalf2WordAtPtx115R2718,
			r_PackedHalf2AtPtx2033R2670, r_PackedHalf2AtPtx2040R2669); // PTX L2556
	MmaHalf(r_PackedHalf2AtPtx2019R2672, r_PackedHalf2AtPtx2026R2671, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx151R2705, r_MmaBHalf2WordAtPtx151R2704,
			r_MmaAccumulatorHalf2WordAtPtx2549R1170,
			r_MmaAccumulatorHalf2WordAtPtx2549R1171); // PTX L2563
	MmaHalf(r_PackedHalf2AtPtx2033R2670, r_PackedHalf2AtPtx2040R2669, r_MmaAHalf2WordAtPtx2314R1154,
			r_MmaAHalf2WordAtPtx2314R1155, r_MmaAHalf2WordAtPtx2314R1156, r_MmaAHalf2WordAtPtx2314R1157,
			r_MmaBHalf2WordAtPtx151R2703, r_MmaBHalf2WordAtPtx151R2702,
			r_MmaAccumulatorHalf2WordAtPtx2556R1172,
			r_MmaAccumulatorHalf2WordAtPtx2556R1173); // PTX L2570
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2577R1182, r_MmaAccumulatorHalf2WordAtPtx2577R1183,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx85R2733, r_MmaBHalf2WordAtPtx85R2732,
			r_PackedHalf2AtPtx2047R2668, r_PackedHalf2AtPtx2054R2667); // PTX L2577
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2584R1184, r_MmaAccumulatorHalf2WordAtPtx2584R1185,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx85R2731, r_MmaBHalf2WordAtPtx85R2730,
			r_PackedHalf2AtPtx2061R2666, r_PackedHalf2AtPtx2068R2665); // PTX L2584
	MmaHalf(r_PackedHalf2AtPtx2047R2668, r_PackedHalf2AtPtx2054R2667, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx124R2717, r_MmaBHalf2WordAtPtx124R2716,
			r_MmaAccumulatorHalf2WordAtPtx2577R1182,
			r_MmaAccumulatorHalf2WordAtPtx2577R1183); // PTX L2591
	MmaHalf(r_PackedHalf2AtPtx2061R2666, r_PackedHalf2AtPtx2068R2665, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx124R2715, r_MmaBHalf2WordAtPtx124R2714,
			r_MmaAccumulatorHalf2WordAtPtx2584R1184,
			r_MmaAccumulatorHalf2WordAtPtx2584R1185); // PTX L2598
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2605R1186, r_MmaAccumulatorHalf2WordAtPtx2605R1187,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx95R2729, r_MmaBHalf2WordAtPtx95R2728,
			r_PackedHalf2AtPtx2075R2664, r_PackedHalf2AtPtx2082R2663); // PTX L2605
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2612R1188, r_MmaAccumulatorHalf2WordAtPtx2612R1189,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx95R2727, r_MmaBHalf2WordAtPtx95R2726,
			r_PackedHalf2AtPtx2089R2662, r_PackedHalf2AtPtx2096R2661); // PTX L2612
	MmaHalf(r_PackedHalf2AtPtx2075R2664, r_PackedHalf2AtPtx2082R2663, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx133R2713, r_MmaBHalf2WordAtPtx133R2712,
			r_MmaAccumulatorHalf2WordAtPtx2605R1186,
			r_MmaAccumulatorHalf2WordAtPtx2605R1187); // PTX L2619
	MmaHalf(r_PackedHalf2AtPtx2089R2662, r_PackedHalf2AtPtx2096R2661, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx133R2711, r_MmaBHalf2WordAtPtx133R2710,
			r_MmaAccumulatorHalf2WordAtPtx2612R1188,
			r_MmaAccumulatorHalf2WordAtPtx2612R1189); // PTX L2626
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2633R1190, r_MmaAccumulatorHalf2WordAtPtx2633R1191,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx105R2725, r_MmaBHalf2WordAtPtx105R2724,
			r_PackedHalf2AtPtx2103R2660, r_PackedHalf2AtPtx2110R2659); // PTX L2633
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2640R1192, r_MmaAccumulatorHalf2WordAtPtx2640R1193,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx105R2723, r_MmaBHalf2WordAtPtx105R2722,
			r_PackedHalf2AtPtx2117R2658, r_PackedHalf2AtPtx2124R2657); // PTX L2640
	MmaHalf(r_PackedHalf2AtPtx2103R2660, r_PackedHalf2AtPtx2110R2659, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx142R2709, r_MmaBHalf2WordAtPtx142R2708,
			r_MmaAccumulatorHalf2WordAtPtx2633R1190,
			r_MmaAccumulatorHalf2WordAtPtx2633R1191); // PTX L2647
	MmaHalf(r_PackedHalf2AtPtx2117R2658, r_PackedHalf2AtPtx2124R2657, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx142R2707, r_MmaBHalf2WordAtPtx142R2706,
			r_MmaAccumulatorHalf2WordAtPtx2640R1192,
			r_MmaAccumulatorHalf2WordAtPtx2640R1193); // PTX L2654
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2661R1194, r_MmaAccumulatorHalf2WordAtPtx2661R1195,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx115R2721, r_MmaBHalf2WordAtPtx115R2720,
			r_PackedHalf2AtPtx2131R2656, r_PackedHalf2AtPtx2138R2655); // PTX L2661
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2668R1196, r_MmaAccumulatorHalf2WordAtPtx2668R1197,
			r_MmaAHalf2WordAtPtx2323R1174, r_MmaAHalf2WordAtPtx2323R1175, r_MmaAHalf2WordAtPtx2323R1176,
			r_MmaAHalf2WordAtPtx2323R1177, r_MmaBHalf2WordAtPtx115R2719, r_MmaBHalf2WordAtPtx115R2718,
			r_PackedHalf2AtPtx2145R2654, r_PackedHalf2AtPtx2152R2653); // PTX L2668
	MmaHalf(r_PackedHalf2AtPtx2131R2656, r_PackedHalf2AtPtx2138R2655, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx151R2705, r_MmaBHalf2WordAtPtx151R2704,
			r_MmaAccumulatorHalf2WordAtPtx2661R1194,
			r_MmaAccumulatorHalf2WordAtPtx2661R1195); // PTX L2675
	MmaHalf(r_PackedHalf2AtPtx2145R2654, r_PackedHalf2AtPtx2152R2653, r_MmaAHalf2WordAtPtx2332R1178,
			r_MmaAHalf2WordAtPtx2332R1179, r_MmaAHalf2WordAtPtx2332R1180, r_MmaAHalf2WordAtPtx2332R1181,
			r_MmaBHalf2WordAtPtx151R2703, r_MmaBHalf2WordAtPtx151R2702,
			r_MmaAccumulatorHalf2WordAtPtx2668R1196,
			r_MmaAccumulatorHalf2WordAtPtx2668R1197); // PTX L2682
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2689R1206, r_MmaAccumulatorHalf2WordAtPtx2689R1207,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx85R2733, r_MmaBHalf2WordAtPtx85R2732,
			r_PackedHalf2AtPtx2159R2652, r_PackedHalf2AtPtx2166R2651); // PTX L2689
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2696R1208, r_MmaAccumulatorHalf2WordAtPtx2696R1209,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx85R2731, r_MmaBHalf2WordAtPtx85R2730,
			r_PackedHalf2AtPtx2173R2650, r_PackedHalf2AtPtx2180R2649); // PTX L2696
	MmaHalf(r_PackedHalf2AtPtx2159R2652, r_PackedHalf2AtPtx2166R2651, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx124R2717, r_MmaBHalf2WordAtPtx124R2716,
			r_MmaAccumulatorHalf2WordAtPtx2689R1206,
			r_MmaAccumulatorHalf2WordAtPtx2689R1207); // PTX L2703
	MmaHalf(r_PackedHalf2AtPtx2173R2650, r_PackedHalf2AtPtx2180R2649, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx124R2715, r_MmaBHalf2WordAtPtx124R2714,
			r_MmaAccumulatorHalf2WordAtPtx2696R1208,
			r_MmaAccumulatorHalf2WordAtPtx2696R1209); // PTX L2710
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2717R1210, r_MmaAccumulatorHalf2WordAtPtx2717R1211,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx95R2729, r_MmaBHalf2WordAtPtx95R2728,
			r_PackedHalf2AtPtx2187R2648, r_PackedHalf2AtPtx2194R2647); // PTX L2717
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2724R1212, r_MmaAccumulatorHalf2WordAtPtx2724R1213,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx95R2727, r_MmaBHalf2WordAtPtx95R2726,
			r_PackedHalf2AtPtx2201R2646, r_PackedHalf2AtPtx2208R2645); // PTX L2724
	MmaHalf(r_PackedHalf2AtPtx2187R2648, r_PackedHalf2AtPtx2194R2647, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx133R2713, r_MmaBHalf2WordAtPtx133R2712,
			r_MmaAccumulatorHalf2WordAtPtx2717R1210,
			r_MmaAccumulatorHalf2WordAtPtx2717R1211); // PTX L2731
	MmaHalf(r_PackedHalf2AtPtx2201R2646, r_PackedHalf2AtPtx2208R2645, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx133R2711, r_MmaBHalf2WordAtPtx133R2710,
			r_MmaAccumulatorHalf2WordAtPtx2724R1212,
			r_MmaAccumulatorHalf2WordAtPtx2724R1213); // PTX L2738
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2745R1214, r_MmaAccumulatorHalf2WordAtPtx2745R1215,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx105R2725, r_MmaBHalf2WordAtPtx105R2724,
			r_PackedHalf2AtPtx2215R2644, r_PackedHalf2AtPtx2222R2643); // PTX L2745
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2752R1216, r_MmaAccumulatorHalf2WordAtPtx2752R1217,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx105R2723, r_MmaBHalf2WordAtPtx105R2722,
			r_PackedHalf2AtPtx2229R2642, r_PackedHalf2AtPtx2236R2641); // PTX L2752
	MmaHalf(r_PackedHalf2AtPtx2215R2644, r_PackedHalf2AtPtx2222R2643, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx142R2709, r_MmaBHalf2WordAtPtx142R2708,
			r_MmaAccumulatorHalf2WordAtPtx2745R1214,
			r_MmaAccumulatorHalf2WordAtPtx2745R1215); // PTX L2759
	MmaHalf(r_PackedHalf2AtPtx2229R2642, r_PackedHalf2AtPtx2236R2641, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx142R2707, r_MmaBHalf2WordAtPtx142R2706,
			r_MmaAccumulatorHalf2WordAtPtx2752R1216,
			r_MmaAccumulatorHalf2WordAtPtx2752R1217); // PTX L2766
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2773R1218, r_MmaAccumulatorHalf2WordAtPtx2773R1219,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx115R2721, r_MmaBHalf2WordAtPtx115R2720,
			r_PackedHalf2AtPtx2243R2640, r_PackedHalf2AtPtx2250R2639); // PTX L2773
	MmaHalf(r_MmaAccumulatorHalf2WordAtPtx2780R1220, r_MmaAccumulatorHalf2WordAtPtx2780R1221,
			r_MmaAHalf2WordAtPtx2341R1198, r_MmaAHalf2WordAtPtx2341R1199, r_MmaAHalf2WordAtPtx2341R1200,
			r_MmaAHalf2WordAtPtx2341R1201, r_MmaBHalf2WordAtPtx115R2719, r_MmaBHalf2WordAtPtx115R2718,
			r_PackedHalf2AtPtx2257R2638, r_PackedHalf2AtPtx2264R2637); // PTX L2780
	MmaHalf(r_PackedHalf2AtPtx2243R2640, r_PackedHalf2AtPtx2250R2639, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx151R2705, r_MmaBHalf2WordAtPtx151R2704,
			r_MmaAccumulatorHalf2WordAtPtx2773R1218,
			r_MmaAccumulatorHalf2WordAtPtx2773R1219); // PTX L2787
	MmaHalf(r_PackedHalf2AtPtx2257R2638, r_PackedHalf2AtPtx2264R2637, r_MmaAHalf2WordAtPtx2350R1202,
			r_MmaAHalf2WordAtPtx2350R1203, r_MmaAHalf2WordAtPtx2350R1204, r_MmaAHalf2WordAtPtx2350R1205,
			r_MmaBHalf2WordAtPtx151R2703, r_MmaBHalf2WordAtPtx151R2702,
			r_MmaAccumulatorHalf2WordAtPtx2780R1220,
			r_MmaAccumulatorHalf2WordAtPtx2780R1221);				 // PTX L2794
	r_bPtxPredicate66 = uint32_t(r_PtxRegister2701) > uint32_t(479); // PTX L2800
	if (r_bPtxPredicate66)
	{
		goto L__BB34_106;
	} // PTX L2801
	r_PtxRegister1250 = uint32_t(r_PtxRegister2701) + uint32_t(32);							   // PTX L2802
	r_CtaZAtPtx2803 = uint32_t(blockIdx.z);													   // PTX L2803
	r_PtxRegister1252 = ShiftLeft(uint32_t(r_CtaZAtPtx2803), uint32_t(9));					   // PTX L2804
	r_PtxRegister1253 = uint32_t(r_PtxRegister1250) + uint32_t(r_PtxRegister1252);			   // PTX L2805
	r_PtxRegister1254 = ShiftLeft(uint32_t(r_PtxRegister1253), uint32_t(8));				   // PTX L2806
	r_PtxRegister1255 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(6));					   // PTX L2807
	r_PtxRegister1256 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(8));					   // PTX L2808
	r_PtxRegister1257 = uint32_t(r_PtxRegister1255) + uint32_t(r_PtxRegister1256);			   // PTX L2809
	r_PtxRegister1258 = ShiftLeft(uint32_t(r_PtxRegister1257), uint32_t(3));				   // PTX L2810
	r_PtxRegister1259 = uint32_t(r_PtxRegister1254) + uint32_t(r_PtxRegister1258);			   // PTX L2811
	r_PtxU64Register245 = uint64_t(int64_t(int32_t(r_PtxRegister1259)) * int64_t(int32_t(4))); // PTX L2812
	r_PtxU64Register246 = uint64_t(r_Pointer24Bits) + uint64_t(r_PtxU64Register245);		   // PTX L2813
	r_LaneIndexAtPtx2815 = uint32_t((threadIdx.x & 31u));									   // PTX L2815
	r_PtxU64Register247 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2815)) * int64_t(int32_t(16)));		 // PTX L2817
	r_PtxU64Register237 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register247); // PTX L2818
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register237));
		r_MmaBHalf2WordAtPtx85R2733 = r_Value.x;
		r_MmaBHalf2WordAtPtx85R2732 = r_Value.y;
		r_MmaBHalf2WordAtPtx85R2731 = r_Value.z;
		r_MmaBHalf2WordAtPtx85R2730 = r_Value.w;
	} // PTX L2820
	r_LaneIndexAtPtx2823 = uint32_t((threadIdx.x & 31u)); // PTX L2823
	r_PtxU64Register248 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2823)) * int64_t(int32_t(16)));		 // PTX L2825
	r_PtxU64Register249 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register248); // PTX L2826
	r_PtxU64Register238 = uint64_t(r_PtxU64Register249) + uint64_t(512);				 // PTX L2827
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register238));
		r_MmaBHalf2WordAtPtx95R2729 = r_Value.x;
		r_MmaBHalf2WordAtPtx95R2728 = r_Value.y;
		r_MmaBHalf2WordAtPtx95R2727 = r_Value.z;
		r_MmaBHalf2WordAtPtx95R2726 = r_Value.w;
	} // PTX L2829
	r_LaneIndexAtPtx2832 = uint32_t((threadIdx.x & 31u)); // PTX L2832
	r_PtxU64Register250 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2832)) * int64_t(int32_t(16)));		 // PTX L2834
	r_PtxU64Register251 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register250); // PTX L2835
	r_PtxU64Register239 = uint64_t(r_PtxU64Register251) + uint64_t(1024);				 // PTX L2836
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register239));
		r_MmaBHalf2WordAtPtx105R2725 = r_Value.x;
		r_MmaBHalf2WordAtPtx105R2724 = r_Value.y;
		r_MmaBHalf2WordAtPtx105R2723 = r_Value.z;
		r_MmaBHalf2WordAtPtx105R2722 = r_Value.w;
	} // PTX L2838
	r_LaneIndexAtPtx2841 = uint32_t((threadIdx.x & 31u)); // PTX L2841
	r_PtxU64Register252 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2841)) * int64_t(int32_t(16)));		 // PTX L2843
	r_PtxU64Register253 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register252); // PTX L2844
	r_PtxU64Register240 = uint64_t(r_PtxU64Register253) + uint64_t(1536);				 // PTX L2845
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register240));
		r_MmaBHalf2WordAtPtx115R2721 = r_Value.x;
		r_MmaBHalf2WordAtPtx115R2720 = r_Value.y;
		r_MmaBHalf2WordAtPtx115R2719 = r_Value.z;
		r_MmaBHalf2WordAtPtx115R2718 = r_Value.w;
	} // PTX L2847
	r_LaneIndexAtPtx2850 = uint32_t((threadIdx.x & 31u)); // PTX L2850
	r_PtxU64Register254 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2850)) * int64_t(int32_t(16)));		 // PTX L2852
	r_PtxU64Register255 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register254); // PTX L2853
	r_PtxU64Register241 = uint64_t(r_PtxU64Register255) + uint64_t(16384);				 // PTX L2854
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register241));
		r_MmaBHalf2WordAtPtx124R2717 = r_Value.x;
		r_MmaBHalf2WordAtPtx124R2716 = r_Value.y;
		r_MmaBHalf2WordAtPtx124R2715 = r_Value.z;
		r_MmaBHalf2WordAtPtx124R2714 = r_Value.w;
	} // PTX L2856
	r_LaneIndexAtPtx2859 = uint32_t((threadIdx.x & 31u)); // PTX L2859
	r_PtxU64Register256 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2859)) * int64_t(int32_t(16)));		 // PTX L2861
	r_PtxU64Register257 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register256); // PTX L2862
	r_PtxU64Register242 = uint64_t(r_PtxU64Register257) + uint64_t(16896);				 // PTX L2863
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register242));
		r_MmaBHalf2WordAtPtx133R2713 = r_Value.x;
		r_MmaBHalf2WordAtPtx133R2712 = r_Value.y;
		r_MmaBHalf2WordAtPtx133R2711 = r_Value.z;
		r_MmaBHalf2WordAtPtx133R2710 = r_Value.w;
	} // PTX L2865
	r_LaneIndexAtPtx2868 = uint32_t((threadIdx.x & 31u)); // PTX L2868
	r_PtxU64Register258 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2868)) * int64_t(int32_t(16)));		 // PTX L2870
	r_PtxU64Register259 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register258); // PTX L2871
	r_PtxU64Register243 = uint64_t(r_PtxU64Register259) + uint64_t(17408);				 // PTX L2872
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register243));
		r_MmaBHalf2WordAtPtx142R2709 = r_Value.x;
		r_MmaBHalf2WordAtPtx142R2708 = r_Value.y;
		r_MmaBHalf2WordAtPtx142R2707 = r_Value.z;
		r_MmaBHalf2WordAtPtx142R2706 = r_Value.w;
	} // PTX L2874
	r_LaneIndexAtPtx2877 = uint32_t((threadIdx.x & 31u)); // PTX L2877
	r_PtxU64Register260 =
		uint64_t(int64_t(int32_t(r_LaneIndexAtPtx2877)) * int64_t(int32_t(16)));		 // PTX L2879
	r_PtxU64Register261 = uint64_t(r_PtxU64Register246) + uint64_t(r_PtxU64Register260); // PTX L2880
	r_PtxU64Register244 = uint64_t(r_PtxU64Register261) + uint64_t(17920);				 // PTX L2881
	{
		const uint4 r_Value = __ldca(reinterpret_cast<const uint4*>(r_PtxU64Register244));
		r_MmaBHalf2WordAtPtx151R2705 = r_Value.x;
		r_MmaBHalf2WordAtPtx151R2704 = r_Value.y;
		r_MmaBHalf2WordAtPtx151R2703 = r_Value.z;
		r_MmaBHalf2WordAtPtx151R2702 = r_Value.w;
	} // PTX L2883
	r_PtxRegister1260 = ShiftRight(uint32_t(r_PtxRegister1250), uint32_t(5)); // PTX L2885
	r_PtxU16Register7 = uint16_t(r_PtxRegister1260);						  // PTX L2886
	r_PtxU16Register8 =
		uint16_t(uint32_t(uint16_t(r_PtxU16Register7)) * uint32_t(uint16_t(171)));				  // PTX L2887
	r_PtxU16Register9 = ShiftRight(uint16_t(r_PtxU16Register8), uint32_t(9));					  // PTX L2888
	r_PtxU16Register10 = uint16_t(uint32_t(uint16_t(r_PtxU16Register9)) * uint32_t(uint16_t(3))); // PTX L2889
	r_PtxU16Register11 = uint16_t(r_PtxU16Register7) - uint16_t(r_PtxU16Register10);			  // PTX L2890
	r_PtxU16Register12 = r_PtxU16Register11 & 255;												  // PTX L2891
	r_PtxRegister1261 = uint32_t(uint16_t(r_PtxU16Register12)) * uint32_t(uint16_t(8));			  // PTX L2892
	r_PtxRegister1262 = uint32_t(12288u /* exact native shared-region offset */);				  // PTX L2893
	r_PtxRegister1264 = uint32_t(r_PtxRegister1262) + uint32_t(r_PtxRegister1261);				  // PTX L2894
	r_PtxRegister1249 = uint32_t(1);															  // PTX L2895
	r_PtxU64Register262 = BarrierArrive(s_SharedStorage, r_PtxRegister1264, r_PtxRegister1249);	  // PTX L2897
L__BB34_105:																					  // PTX L2899
	r_PtxRegister1263 = BarrierReady(s_SharedStorage, r_PtxRegister1264, r_PtxU64Register262);	  // PTX L2901
	r_bPtxPredicate67 = uint32_t(r_PtxRegister1263) == uint32_t(0);								  // PTX L2907
	if (r_bPtxPredicate67)
	{
		goto L__BB34_105;
	} // PTX L2908
L__BB34_106:														 // PTX L2909
	r_bPtxPredicate68 = uint32_t(r_PtxRegister2701) > uint32_t(415); // PTX L2910
	if (r_bPtxPredicate68)
	{
		goto L__BB34_123;
	} // PTX L2911
	r_bPtxPredicate69 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7);	   // PTX L2912
	r_PtxRegister1265 = uint32_t(r_PtxRegister219) + uint32_t(r_PtxRegister3); // PTX L2913
	r_bPtxPredicate70 = int32_t(r_PtxRegister1265) < int32_t(r_PtxRegister6);  // PTX L2914
	r_bPtxPredicate71 = int32_t(r_PtxRegister1265) >= int32_t(r_PtxRegister6); // PTX L2915
	r_PtxRegister1266 = r_Scalar36Bits & -4;								   // PTX L2916
	r_bPtxPredicate72 = uint32_t(r_PtxRegister1266) == uint32_t(4);			   // PTX L2917
	r_PtxRegister1267 = r_Scalar32Bits & -4;								   // PTX L2918
	r_bPtxPredicate73 = uint32_t(r_PtxRegister1267) == uint32_t(4);			   // PTX L2919
	r_bPtxPredicate74 = r_bPtxPredicate3 & r_bPtxPredicate71;				   // PTX L2920
	r_bPtxPredicate75 = r_bPtxPredicate73 | r_bPtxPredicate70;				   // PTX L2921
	r_bPtxPredicate76 = r_bPtxPredicate74 | r_bPtxPredicate72;				   // PTX L2922
	r_PtxRegister1268 = r_bPtxPredicate74 ? r_PtxRegister17 : 0;			   // PTX L2923
	r_PtxRegister37 = r_bPtxPredicate72 ? r_PtxRegister1268 : r_PtxRegister17; // PTX L2924
	r_bPtxPredicate77 = r_bPtxPredicate76 | r_bPtxPredicate69;				   // PTX L2925
	r_bPtxPredicate14 = r_bPtxPredicate77 & r_bPtxPredicate75;				   // PTX L2926
	r_PtxU64Register407 = uint64_t(0);										   // PTX L2927
	r_bPtxPredicate78 = !r_bPtxPredicate14;									   // PTX L2928
	if (r_bPtxPredicate78)
	{
		goto L__BB34_109;
	} // PTX L2929
	r_PtxRegister1269 =
		uint32_t(r_PtxRegister1265) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister37); // PTX L2930
	r_PtxRegister1270 = r_bPtxPredicate73 ? r_PtxRegister37 : r_PtxRegister1269;			// PTX L2931
	r_CtaZAtPtx2932 = uint32_t(blockIdx.z);													// PTX L2932
	r_PtxRegister1272 = ShiftLeft(uint32_t(r_CtaZAtPtx2932), uint32_t(9));					// PTX L2933
	r_PtxRegister1273 = uint32_t(r_PtxRegister1272) + uint32_t(r_PtxRegister2701);			// PTX L2934
	r_PtxRegister1274 = uint32_t(r_PtxRegister1273) + uint32_t(96);							// PTX L2935
	r_PtxRegister1275 = ShiftRight(uint32_t(r_PtxRegister1274), uint32_t(4));				// PTX L2936
	r_PtxRegister1276 = r_ThreadYAtPtx43 & 1;												// PTX L2937
	r_PtxRegister1277 = uint32_t(r_PtxRegister1275) + uint32_t(r_PtxRegister1276);			// PTX L2938
	r_PtxRegister1278 = ShiftLeft(uint32_t(r_PtxRegister1270), uint32_t(12));				// PTX L2939
	r_PtxRegister1279 = ShiftLeft(uint32_t(r_PtxRegister1277), uint32_t(7));				// PTX L2940
	r_PtxRegister1280 = uint32_t(r_PtxRegister1278) + uint32_t(r_PtxRegister1279);			// PTX L2941
	r_PtxU64Register407 = SignExtendWordBits(r_PtxRegister1280);							// PTX L2942
L__BB34_109:																				// PTX L2943
	r_PtxU64Register408 = uint64_t(0);														// PTX L2944
	if (r_bPtxPredicate78)
	{
		goto L__BB34_111;
	} // PTX L2945
	r_PtxU64Register263 = ShiftLeft(uint64_t(r_PtxU64Register407), uint32_t(2));	// PTX L2946
	r_PtxU64Register408 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register263); // PTX L2947
L__BB34_111:																		// PTX L2948
	r_PtxRegister1281 = ShiftLeft(uint32_t(r_PtxRegister35), uint32_t(3));			// PTX L2949
	r_PtxRegister1282 = uint32_t(12288u /* exact native shared-region offset */);	// PTX L2950
	r_PtxRegister1325 = uint32_t(r_PtxRegister1282) + uint32_t(r_PtxRegister1281);	// PTX L2951
	if (r_bPtxPredicate78)
	{
		goto L__BB34_114;
	} // PTX L2952
	r_PtxRegister1289 = uint32_t(-1);								// PTX L2953
	r_PtxRegister1288 = Elected(r_PtxRegister1289);					// PTX L2955
	r_bPtxPredicate79 = uint32_t(r_PtxRegister1288) == uint32_t(0); // PTX L2961
	if (r_bPtxPredicate79)
	{
		goto L__BB34_115;
	} // PTX L2962
	r_ThreadYAtPtx2963 = uint32_t(threadIdx.y);									 // PTX L2963
	r_PtxRegister1293 = ShiftLeft(uint32_t(r_ThreadYAtPtx2963), uint32_t(9));	 // PTX L2964
	r_PtxRegister1290 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1293); // PTX L2965
	r_PtxU64Register264 = r_PtxU64Register408;									 // PTX L2966
	r_PtxRegister1291 = uint32_t(512);											 // PTX L2967
	CopyBulk(s_SharedStorage, r_PtxRegister1290, r_PtxU64Register264, r_PtxRegister1291,
			 r_PtxRegister1325);												   // PTX L2969
	BarrierExpect(s_SharedStorage, r_PtxRegister1325, r_PtxRegister1291);		   // PTX L2972
	goto L__BB34_115;															   // PTX L2974
L__BB34_114:																	   // PTX L2975
	r_LaneIndexAtPtx2977 = uint32_t((threadIdx.x & 31u));						   // PTX L2977
	r_PtxRegister1285 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(9));		   // PTX L2979
	r_PtxRegister1286 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1285);   // PTX L2980
	r_PtxRegister1287 = ShiftLeft(uint32_t(r_LaneIndexAtPtx2977), uint32_t(4));	   // PTX L2981
	r_PtxRegister1284 = uint32_t(r_PtxRegister1286) + uint32_t(r_PtxRegister1287); // PTX L2982
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1284)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);									// PTX L2984
L__BB34_115:																	// PTX L2986
	r_PtxRegister1294 = uint32_t(r_ThreadYAtPtx43) + uint32_t(4);				// PTX L2987
	r_PtxRegister1295 = ShiftRight(uint32_t(r_PtxRegister1294), uint32_t(2));	// PTX L2988
	r_PtxRegister1296 = uint32_t(r_PtxRegister1295) + uint32_t(r_PtxRegister3); // PTX L2989
	r_bPtxPredicate80 = int32_t(r_PtxRegister1296) < int32_t(r_PtxRegister6);	// PTX L2990
	r_bPtxPredicate81 = int32_t(r_PtxRegister1296) >= int32_t(r_PtxRegister6);	// PTX L2991
	r_bPtxPredicate82 = int32_t(r_PtxRegister17) < int32_t(r_PtxRegister7);		// PTX L2992
	r_bPtxPredicate83 = uint32_t(r_PtxRegister1266) == uint32_t(4);				// PTX L2993
	r_bPtxPredicate84 = uint32_t(r_PtxRegister1267) == uint32_t(4);				// PTX L2994
	r_bPtxPredicate85 = r_bPtxPredicate3 & r_bPtxPredicate81;					// PTX L2995
	r_bPtxPredicate86 = r_bPtxPredicate84 | r_bPtxPredicate80;					// PTX L2996
	r_bPtxPredicate87 = r_bPtxPredicate85 | r_bPtxPredicate83;					// PTX L2997
	r_PtxRegister1297 = r_bPtxPredicate85 ? r_PtxRegister17 : 0;				// PTX L2998
	r_PtxRegister38 = r_bPtxPredicate83 ? r_PtxRegister1297 : r_PtxRegister17;	// PTX L2999
	r_bPtxPredicate88 = r_bPtxPredicate87 | r_bPtxPredicate82;					// PTX L3000
	r_bPtxPredicate15 = r_bPtxPredicate88 & r_bPtxPredicate86;					// PTX L3001
	r_PtxU64Register409 = uint64_t(0);											// PTX L3002
	r_bPtxPredicate89 = !r_bPtxPredicate15;										// PTX L3003
	if (r_bPtxPredicate89)
	{
		goto L__BB34_117;
	} // PTX L3004
	r_PtxRegister1298 =
		uint32_t(r_PtxRegister1296) * uint32_t(r_PtxRegister7) + uint32_t(r_PtxRegister38); // PTX L3005
	r_PtxRegister1299 = r_bPtxPredicate84 ? r_PtxRegister38 : r_PtxRegister1298;			// PTX L3006
	r_CtaZAtPtx3007 = uint32_t(blockIdx.z);													// PTX L3007
	r_PtxRegister1301 = ShiftLeft(uint32_t(r_CtaZAtPtx3007), uint32_t(9));					// PTX L3008
	r_PtxRegister1302 = uint32_t(r_PtxRegister1301) + uint32_t(r_PtxRegister2701);			// PTX L3009
	r_PtxRegister1303 = uint32_t(r_PtxRegister1302) + uint32_t(96);							// PTX L3010
	r_PtxRegister1304 = ShiftRight(uint32_t(r_PtxRegister1303), uint32_t(4));				// PTX L3011
	r_PtxRegister1305 = r_ThreadYAtPtx43 & 1;												// PTX L3012
	r_PtxRegister1306 = uint32_t(r_PtxRegister1304) + uint32_t(r_PtxRegister1305);			// PTX L3013
	r_PtxRegister1307 = ShiftLeft(uint32_t(r_PtxRegister1299), uint32_t(12));				// PTX L3014
	r_PtxRegister1308 = ShiftLeft(uint32_t(r_PtxRegister1306), uint32_t(7));				// PTX L3015
	r_PtxRegister1309 = uint32_t(r_PtxRegister1307) + uint32_t(r_PtxRegister1308);			// PTX L3016
	r_PtxU64Register409 = SignExtendWordBits(r_PtxRegister1309);							// PTX L3017
L__BB34_117:																				// PTX L3018
	r_PtxU64Register410 = uint64_t(0);														// PTX L3019
	if (r_bPtxPredicate89)
	{
		goto L__BB34_119;
	} // PTX L3020
	r_PtxU64Register265 = ShiftLeft(uint64_t(r_PtxU64Register409), uint32_t(2));	// PTX L3021
	r_PtxU64Register410 = uint64_t(r_Pointer0Bits) + uint64_t(r_PtxU64Register265); // PTX L3022
L__BB34_119:																		// PTX L3023
	if (r_bPtxPredicate89)
	{
		goto L__BB34_122;
	} // PTX L3024
	r_PtxRegister1322 = uint32_t(-1);								// PTX L3025
	r_PtxRegister1321 = Elected(r_PtxRegister1322);					// PTX L3027
	r_bPtxPredicate90 = uint32_t(r_PtxRegister1321) == uint32_t(0); // PTX L3033
	if (r_bPtxPredicate90)
	{
		goto L__BB34_123;
	} // PTX L3034
	r_PtxRegister1326 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(9));		 // PTX L3035
	r_PtxRegister1327 = r_PtxRegister1326 & 1024;								 // PTX L3036
	r_PtxRegister1328 = uint32_t(r_PtxRegister1326) + uint32_t(2048);			 // PTX L3037
	r_PtxRegister1329 = r_PtxRegister1328 & 1046528;							 // PTX L3038
	r_PtxRegister1330 = r_PtxRegister1329 | r_PtxRegister1327;					 // PTX L3039
	r_PtxRegister1331 = r_PtxRegister1326 & 512;								 // PTX L3040
	r_PtxRegister1332 = r_PtxRegister1331 | r_PtxRegister1330;					 // PTX L3041
	r_PtxRegister1323 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1332); // PTX L3042
	r_PtxU64Register266 = r_PtxU64Register410;									 // PTX L3043
	r_PtxRegister1324 = uint32_t(512);											 // PTX L3044
	CopyBulk(s_SharedStorage, r_PtxRegister1323, r_PtxU64Register266, r_PtxRegister1324,
			 r_PtxRegister1325);												   // PTX L3046
	BarrierExpect(s_SharedStorage, r_PtxRegister1325, r_PtxRegister1324);		   // PTX L3049
	goto L__BB34_123;															   // PTX L3051
L__BB34_122:																	   // PTX L3052
	r_LaneIndexAtPtx3054 = uint32_t((threadIdx.x & 31u));						   // PTX L3054
	r_PtxRegister1312 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(9));		   // PTX L3056
	r_PtxRegister1313 = r_PtxRegister1312 & 1024;								   // PTX L3057
	r_PtxRegister1314 = uint32_t(r_PtxRegister1312) + uint32_t(2048);			   // PTX L3058
	r_PtxRegister1315 = r_PtxRegister1314 & 1046528;							   // PTX L3059
	r_PtxRegister1316 = r_PtxRegister1315 | r_PtxRegister1313;					   // PTX L3060
	r_PtxRegister1317 = r_PtxRegister1312 & 512;								   // PTX L3061
	r_PtxRegister1318 = r_PtxRegister1317 | r_PtxRegister1316;					   // PTX L3062
	r_PtxRegister1319 = uint32_t(r_PtxRegister36) + uint32_t(r_PtxRegister1318);   // PTX L3063
	r_PtxRegister1320 = ShiftLeft(uint32_t(r_LaneIndexAtPtx3054), uint32_t(4));	   // PTX L3064
	r_PtxRegister1311 = uint32_t(r_PtxRegister1319) + uint32_t(r_PtxRegister1320); // PTX L3065
	*reinterpret_cast<uint4*>(s_SharedStorage + uint32_t(r_PtxRegister1311)) =
		make_uint4(r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320, r_PackedHalf2AtPtx66R320,
				   r_PackedHalf2AtPtx66R320);						 // PTX L3067
L__BB34_123:														 // PTX L3069
	r_bPtxPredicate91 = uint32_t(r_PtxRegister2701) < uint32_t(480); // PTX L3070
	r_PtxRegister2701 = uint32_t(r_PtxRegister2701) + uint32_t(32);	 // PTX L3071
	if (r_bPtxPredicate91)
	{
		goto L__BB34_103;
	} // PTX L3072
	r_PtxU64Register3 = r_Pointer16Bits;											   // PTX L3073
	r_PtxRegister1334 = ShiftLeft(uint32_t(r_PtxRegister2), uint32_t(5));			   // PTX L3074
	r_PtxRegister1335 = ShiftLeft(uint32_t(r_ThreadYAtPtx43), uint32_t(3));			   // PTX L3075
	r_PtxRegister39 = ShiftLeft(uint32_t(r_Scalar36Bits), uint32_t(2));				   // PTX L3076
	r_LaneIndexAtPtx3078 = uint32_t((threadIdx.x & 31u));							   // PTX L3078
	r_PtxRegister1336 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3078), uint32_t(31)); // PTX L3080
	r_PtxRegister1337 = ShiftRight(uint32_t(r_PtxRegister1336), uint32_t(30));		   // PTX L3081
	r_PtxRegister1338 = uint32_t(r_LaneIndexAtPtx3078) + uint32_t(r_PtxRegister1337);  // PTX L3082
	r_PtxRegister1339 = ShiftRightSigned(int32_t(r_PtxRegister1338), uint32_t(2));	   // PTX L3083
	r_PtxRegister1340 = ShiftRight(uint32_t(r_PtxRegister1339), uint32_t(30));		   // PTX L3084
	r_PtxRegister1341 = uint32_t(r_PtxRegister1339) + uint32_t(r_PtxRegister1340);	   // PTX L3085
	r_PtxRegister1342 = r_PtxRegister1341 & -4;										   // PTX L3086
	r_PtxRegister1343 = uint32_t(r_PtxRegister1339) - uint32_t(r_PtxRegister1342);	   // PTX L3087
	r_PtxRegister1344 = ShiftRight(uint32_t(r_PtxRegister1336), uint32_t(28));		   // PTX L3088
	r_PtxRegister1345 = uint32_t(r_LaneIndexAtPtx3078) + uint32_t(r_PtxRegister1344);  // PTX L3089
	r_PtxRegister1346 = ShiftRightSigned(int32_t(r_PtxRegister1345), uint32_t(4));	   // PTX L3090
	r_PtxRegister40 = uint32_t(r_PtxRegister1334) + uint32_t(r_PtxRegister1335);	   // PTX L3091
	r_PtxRegister41 = ShiftLeft(uint32_t(r_CtaY), uint32_t(3));						   // PTX L3092
	r_PtxRegister42 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1346);		   // PTX L3093
	r_PtxRegister43 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1343);		   // PTX L3094
	r_bPtxPredicate92 = int32_t(r_PtxRegister42) < int32_t(0);						   // PTX L3095
	r_bPtxPredicate93 = int32_t(r_PtxRegister42) >= int32_t(r_Scalar32Bits);		   // PTX L3096
	r_bPtxPredicate94 = r_bPtxPredicate92 | r_bPtxPredicate93;						   // PTX L3097
	r_bPtxPredicate95 = int32_t(r_PtxRegister43) < int32_t(0);						   // PTX L3098
	r_bPtxPredicate96 = int32_t(r_PtxRegister43) >= int32_t(r_Scalar36Bits);		   // PTX L3099
	r_bPtxPredicate97 = r_bPtxPredicate95 | r_bPtxPredicate96;						   // PTX L3100
	r_bPtxPredicate98 = r_bPtxPredicate94 | r_bPtxPredicate97;						   // PTX L3101
	if (r_bPtxPredicate98)
	{
		goto L__BB34_126;
	} // PTX L3102
	r_PtxRegister1347 = r_PtxRegister1338 & -4;										  // PTX L3103
	r_PtxRegister1348 = uint32_t(r_LaneIndexAtPtx3078) - uint32_t(r_PtxRegister1347); // PTX L3104
	r_PtxRegister1349 = ShiftLeft(uint32_t(r_PtxRegister43), uint32_t(2));			  // PTX L3105
	r_PtxRegister1350 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister42); // PTX L3106
	r_PtxRegister1351 =
		uint32_t(r_PtxRegister1350) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1349); // PTX L3107
	r_PtxRegister1352 = uint32_t(r_PtxRegister1351) + uint32_t(r_PtxRegister1348);			   // PTX L3108
	r_PtxU64Register267 = uint64_t(int64_t(int32_t(r_PtxRegister1352)) * int64_t(int32_t(4))); // PTX L3109
	r_PtxU64Register268 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register267);		   // PTX L3110
	*reinterpret_cast<uint32_t*>(r_PtxU64Register268) = r_PackedHalf2AtPtx1823R2700;		   // PTX L3111
L__BB34_126:																				   // PTX L3112
	r_LaneIndexAtPtx3114 = uint32_t((threadIdx.x & 31u));									   // PTX L3114
	r_PtxRegister1354 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3114), uint32_t(31));		   // PTX L3116
	r_PtxRegister1355 = ShiftRight(uint32_t(r_PtxRegister1354), uint32_t(30));				   // PTX L3117
	r_PtxRegister1356 = uint32_t(r_LaneIndexAtPtx3114) + uint32_t(r_PtxRegister1355);		   // PTX L3118
	r_PtxRegister1357 = ShiftRightSigned(int32_t(r_PtxRegister1356), uint32_t(2));			   // PTX L3119
	r_PtxRegister1358 = ShiftRight(uint32_t(r_PtxRegister1357), uint32_t(30));				   // PTX L3120
	r_PtxRegister1359 = uint32_t(r_PtxRegister1357) + uint32_t(r_PtxRegister1358);			   // PTX L3121
	r_PtxRegister1360 = r_PtxRegister1359 & -4;												   // PTX L3122
	r_PtxRegister1361 = uint32_t(r_PtxRegister1357) - uint32_t(r_PtxRegister1360);			   // PTX L3123
	r_PtxRegister1362 = ShiftRight(uint32_t(r_PtxRegister1354), uint32_t(28));				   // PTX L3124
	r_PtxRegister1363 = uint32_t(r_LaneIndexAtPtx3114) + uint32_t(r_PtxRegister1362);		   // PTX L3125
	r_PtxRegister1364 = ShiftRightSigned(int32_t(r_PtxRegister1363), uint32_t(4));			   // PTX L3126
	r_PtxRegister1365 = uint32_t(r_PtxRegister1364) + uint32_t(r_PtxRegister41);			   // PTX L3127
	r_PtxRegister44 = uint32_t(r_PtxRegister1365) + uint32_t(2);							   // PTX L3128
	r_PtxRegister45 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1361);				   // PTX L3129
	r_bPtxPredicate99 = int32_t(r_PtxRegister44) < int32_t(0);								   // PTX L3130
	r_bPtxPredicate100 = int32_t(r_PtxRegister44) >= int32_t(r_Scalar32Bits);				   // PTX L3131
	r_bPtxPredicate101 = r_bPtxPredicate99 | r_bPtxPredicate100;							   // PTX L3132
	r_bPtxPredicate102 = int32_t(r_PtxRegister45) < int32_t(0);								   // PTX L3133
	r_bPtxPredicate103 = int32_t(r_PtxRegister45) >= int32_t(r_Scalar36Bits);				   // PTX L3134
	r_bPtxPredicate104 = r_bPtxPredicate102 | r_bPtxPredicate103;							   // PTX L3135
	r_bPtxPredicate105 = r_bPtxPredicate101 | r_bPtxPredicate104;							   // PTX L3136
	if (r_bPtxPredicate105)
	{
		goto L__BB34_128;
	} // PTX L3137
	r_PtxRegister1366 = r_PtxRegister1356 & -4;										  // PTX L3138
	r_PtxRegister1367 = uint32_t(r_LaneIndexAtPtx3114) - uint32_t(r_PtxRegister1366); // PTX L3139
	r_PtxRegister1368 = ShiftLeft(uint32_t(r_PtxRegister45), uint32_t(2));			  // PTX L3140
	r_PtxRegister1369 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister44); // PTX L3141
	r_PtxRegister1370 =
		uint32_t(r_PtxRegister1369) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1368); // PTX L3142
	r_PtxRegister1371 = uint32_t(r_PtxRegister1370) + uint32_t(r_PtxRegister1367);			   // PTX L3143
	r_PtxU64Register269 = uint64_t(int64_t(int32_t(r_PtxRegister1371)) * int64_t(int32_t(4))); // PTX L3144
	r_PtxU64Register270 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register269);		   // PTX L3145
	*reinterpret_cast<uint32_t*>(r_PtxU64Register270) = r_PackedHalf2AtPtx1830R2699;		   // PTX L3146
L__BB34_128:																				   // PTX L3147
	r_LaneIndexAtPtx3149 = uint32_t((threadIdx.x & 31u));									   // PTX L3149
	r_PtxRegister1373 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3149), uint32_t(31));		   // PTX L3151
	r_PtxRegister1374 = ShiftRight(uint32_t(r_PtxRegister1373), uint32_t(30));				   // PTX L3152
	r_PtxRegister1375 = uint32_t(r_LaneIndexAtPtx3149) + uint32_t(r_PtxRegister1374);		   // PTX L3153
	r_PtxRegister1376 = ShiftRightSigned(int32_t(r_PtxRegister1375), uint32_t(2));			   // PTX L3154
	r_PtxRegister1377 = ShiftRight(uint32_t(r_PtxRegister1376), uint32_t(30));				   // PTX L3155
	r_PtxRegister1378 = uint32_t(r_PtxRegister1376) + uint32_t(r_PtxRegister1377);			   // PTX L3156
	r_PtxRegister1379 = r_PtxRegister1378 & -4;												   // PTX L3157
	r_PtxRegister1380 = uint32_t(r_PtxRegister1376) - uint32_t(r_PtxRegister1379);			   // PTX L3158
	r_PtxRegister1381 = ShiftRight(uint32_t(r_PtxRegister1373), uint32_t(28));				   // PTX L3159
	r_PtxRegister1382 = uint32_t(r_LaneIndexAtPtx3149) + uint32_t(r_PtxRegister1381);		   // PTX L3160
	r_PtxRegister1383 = ShiftRightSigned(int32_t(r_PtxRegister1382), uint32_t(4));			   // PTX L3161
	r_PtxRegister46 = uint32_t(r_PtxRegister40) + uint32_t(1);								   // PTX L3162
	r_PtxRegister47 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1383);				   // PTX L3163
	r_PtxRegister48 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1380);				   // PTX L3164
	r_bPtxPredicate106 = int32_t(r_PtxRegister47) < int32_t(0);								   // PTX L3165
	r_bPtxPredicate107 = int32_t(r_PtxRegister47) >= int32_t(r_Scalar32Bits);				   // PTX L3166
	r_bPtxPredicate108 = r_bPtxPredicate106 | r_bPtxPredicate107;							   // PTX L3167
	r_bPtxPredicate109 = int32_t(r_PtxRegister48) < int32_t(0);								   // PTX L3168
	r_bPtxPredicate110 = int32_t(r_PtxRegister48) >= int32_t(r_Scalar36Bits);				   // PTX L3169
	r_bPtxPredicate111 = r_bPtxPredicate109 | r_bPtxPredicate110;							   // PTX L3170
	r_bPtxPredicate112 = r_bPtxPredicate108 | r_bPtxPredicate111;							   // PTX L3171
	if (r_bPtxPredicate112)
	{
		goto L__BB34_130;
	} // PTX L3172
	r_PtxRegister1384 = r_PtxRegister1375 & -4;										  // PTX L3173
	r_PtxRegister1385 = uint32_t(r_LaneIndexAtPtx3149) - uint32_t(r_PtxRegister1384); // PTX L3174
	r_PtxRegister1386 = ShiftLeft(uint32_t(r_PtxRegister48), uint32_t(2));			  // PTX L3175
	r_PtxRegister1387 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister47); // PTX L3176
	r_PtxRegister1388 =
		uint32_t(r_PtxRegister1387) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1386); // PTX L3177
	r_PtxRegister1389 = uint32_t(r_PtxRegister1388) + uint32_t(r_PtxRegister1385);			   // PTX L3178
	r_PtxU64Register271 = uint64_t(int64_t(int32_t(r_PtxRegister1389)) * int64_t(int32_t(4))); // PTX L3179
	r_PtxU64Register272 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register271);		   // PTX L3180
	*reinterpret_cast<uint32_t*>(r_PtxU64Register272) = r_PackedHalf2AtPtx1837R2698;		   // PTX L3181
L__BB34_130:																				   // PTX L3182
	r_LaneIndexAtPtx3184 = uint32_t((threadIdx.x & 31u));									   // PTX L3184
	r_PtxRegister1391 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3184), uint32_t(31));		   // PTX L3186
	r_PtxRegister1392 = ShiftRight(uint32_t(r_PtxRegister1391), uint32_t(30));				   // PTX L3187
	r_PtxRegister1393 = uint32_t(r_LaneIndexAtPtx3184) + uint32_t(r_PtxRegister1392);		   // PTX L3188
	r_PtxRegister1394 = ShiftRightSigned(int32_t(r_PtxRegister1393), uint32_t(2));			   // PTX L3189
	r_PtxRegister1395 = ShiftRight(uint32_t(r_PtxRegister1394), uint32_t(30));				   // PTX L3190
	r_PtxRegister1396 = uint32_t(r_PtxRegister1394) + uint32_t(r_PtxRegister1395);			   // PTX L3191
	r_PtxRegister1397 = r_PtxRegister1396 & -4;												   // PTX L3192
	r_PtxRegister1398 = uint32_t(r_PtxRegister1394) - uint32_t(r_PtxRegister1397);			   // PTX L3193
	r_PtxRegister1399 = ShiftRight(uint32_t(r_PtxRegister1391), uint32_t(28));				   // PTX L3194
	r_PtxRegister1400 = uint32_t(r_LaneIndexAtPtx3184) + uint32_t(r_PtxRegister1399);		   // PTX L3195
	r_PtxRegister1401 = ShiftRightSigned(int32_t(r_PtxRegister1400), uint32_t(4));			   // PTX L3196
	r_PtxRegister1402 = uint32_t(r_PtxRegister1401) + uint32_t(r_PtxRegister41);			   // PTX L3197
	r_PtxRegister49 = uint32_t(r_PtxRegister1402) + uint32_t(2);							   // PTX L3198
	r_PtxRegister50 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1398);				   // PTX L3199
	r_bPtxPredicate113 = int32_t(r_PtxRegister49) < int32_t(0);								   // PTX L3200
	r_bPtxPredicate114 = int32_t(r_PtxRegister49) >= int32_t(r_Scalar32Bits);				   // PTX L3201
	r_bPtxPredicate115 = r_bPtxPredicate113 | r_bPtxPredicate114;							   // PTX L3202
	r_bPtxPredicate116 = int32_t(r_PtxRegister50) < int32_t(0);								   // PTX L3203
	r_bPtxPredicate117 = int32_t(r_PtxRegister50) >= int32_t(r_Scalar36Bits);				   // PTX L3204
	r_bPtxPredicate118 = r_bPtxPredicate116 | r_bPtxPredicate117;							   // PTX L3205
	r_bPtxPredicate119 = r_bPtxPredicate115 | r_bPtxPredicate118;							   // PTX L3206
	if (r_bPtxPredicate119)
	{
		goto L__BB34_132;
	} // PTX L3207
	r_PtxRegister1403 = r_PtxRegister1393 & -4;										  // PTX L3208
	r_PtxRegister1404 = uint32_t(r_LaneIndexAtPtx3184) - uint32_t(r_PtxRegister1403); // PTX L3209
	r_PtxRegister1405 = ShiftLeft(uint32_t(r_PtxRegister50), uint32_t(2));			  // PTX L3210
	r_PtxRegister1406 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister49); // PTX L3211
	r_PtxRegister1407 =
		uint32_t(r_PtxRegister1406) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1405); // PTX L3212
	r_PtxRegister1408 = uint32_t(r_PtxRegister1407) + uint32_t(r_PtxRegister1404);			   // PTX L3213
	r_PtxU64Register273 = uint64_t(int64_t(int32_t(r_PtxRegister1408)) * int64_t(int32_t(4))); // PTX L3214
	r_PtxU64Register274 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register273);		   // PTX L3215
	*reinterpret_cast<uint32_t*>(r_PtxU64Register274) = r_PackedHalf2AtPtx1844R2697;		   // PTX L3216
L__BB34_132:																				   // PTX L3217
	r_LaneIndexAtPtx3219 = uint32_t((threadIdx.x & 31u));									   // PTX L3219
	r_PtxRegister1410 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3219), uint32_t(31));		   // PTX L3221
	r_PtxRegister1411 = ShiftRight(uint32_t(r_PtxRegister1410), uint32_t(30));				   // PTX L3222
	r_PtxRegister1412 = uint32_t(r_LaneIndexAtPtx3219) + uint32_t(r_PtxRegister1411);		   // PTX L3223
	r_PtxRegister1413 = ShiftRightSigned(int32_t(r_PtxRegister1412), uint32_t(2));			   // PTX L3224
	r_PtxRegister1414 = ShiftRight(uint32_t(r_PtxRegister1413), uint32_t(30));				   // PTX L3225
	r_PtxRegister1415 = uint32_t(r_PtxRegister1413) + uint32_t(r_PtxRegister1414);			   // PTX L3226
	r_PtxRegister1416 = r_PtxRegister1415 & -4;												   // PTX L3227
	r_PtxRegister1417 = uint32_t(r_PtxRegister1413) - uint32_t(r_PtxRegister1416);			   // PTX L3228
	r_PtxRegister1418 = ShiftRight(uint32_t(r_PtxRegister1410), uint32_t(28));				   // PTX L3229
	r_PtxRegister1419 = uint32_t(r_LaneIndexAtPtx3219) + uint32_t(r_PtxRegister1418);		   // PTX L3230
	r_PtxRegister1420 = ShiftRightSigned(int32_t(r_PtxRegister1419), uint32_t(4));			   // PTX L3231
	r_PtxRegister51 = uint32_t(r_PtxRegister40) + uint32_t(2);								   // PTX L3232
	r_PtxRegister52 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1420);				   // PTX L3233
	r_PtxRegister53 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1417);				   // PTX L3234
	r_bPtxPredicate120 = int32_t(r_PtxRegister52) < int32_t(0);								   // PTX L3235
	r_bPtxPredicate121 = int32_t(r_PtxRegister52) >= int32_t(r_Scalar32Bits);				   // PTX L3236
	r_bPtxPredicate122 = r_bPtxPredicate120 | r_bPtxPredicate121;							   // PTX L3237
	r_bPtxPredicate123 = int32_t(r_PtxRegister53) < int32_t(0);								   // PTX L3238
	r_bPtxPredicate124 = int32_t(r_PtxRegister53) >= int32_t(r_Scalar36Bits);				   // PTX L3239
	r_bPtxPredicate125 = r_bPtxPredicate123 | r_bPtxPredicate124;							   // PTX L3240
	r_bPtxPredicate126 = r_bPtxPredicate122 | r_bPtxPredicate125;							   // PTX L3241
	if (r_bPtxPredicate126)
	{
		goto L__BB34_134;
	} // PTX L3242
	r_PtxRegister1421 = r_PtxRegister1412 & -4;										  // PTX L3243
	r_PtxRegister1422 = uint32_t(r_LaneIndexAtPtx3219) - uint32_t(r_PtxRegister1421); // PTX L3244
	r_PtxRegister1423 = ShiftLeft(uint32_t(r_PtxRegister53), uint32_t(2));			  // PTX L3245
	r_PtxRegister1424 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister52); // PTX L3246
	r_PtxRegister1425 =
		uint32_t(r_PtxRegister1424) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1423); // PTX L3247
	r_PtxRegister1426 = uint32_t(r_PtxRegister1425) + uint32_t(r_PtxRegister1422);			   // PTX L3248
	r_PtxU64Register275 = uint64_t(int64_t(int32_t(r_PtxRegister1426)) * int64_t(int32_t(4))); // PTX L3249
	r_PtxU64Register276 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register275);		   // PTX L3250
	*reinterpret_cast<uint32_t*>(r_PtxU64Register276) = r_PackedHalf2AtPtx1851R2696;		   // PTX L3251
L__BB34_134:																				   // PTX L3252
	r_LaneIndexAtPtx3254 = uint32_t((threadIdx.x & 31u));									   // PTX L3254
	r_PtxRegister1428 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3254), uint32_t(31));		   // PTX L3256
	r_PtxRegister1429 = ShiftRight(uint32_t(r_PtxRegister1428), uint32_t(30));				   // PTX L3257
	r_PtxRegister1430 = uint32_t(r_LaneIndexAtPtx3254) + uint32_t(r_PtxRegister1429);		   // PTX L3258
	r_PtxRegister1431 = ShiftRightSigned(int32_t(r_PtxRegister1430), uint32_t(2));			   // PTX L3259
	r_PtxRegister1432 = ShiftRight(uint32_t(r_PtxRegister1431), uint32_t(30));				   // PTX L3260
	r_PtxRegister1433 = uint32_t(r_PtxRegister1431) + uint32_t(r_PtxRegister1432);			   // PTX L3261
	r_PtxRegister1434 = r_PtxRegister1433 & -4;												   // PTX L3262
	r_PtxRegister1435 = uint32_t(r_PtxRegister1431) - uint32_t(r_PtxRegister1434);			   // PTX L3263
	r_PtxRegister1436 = ShiftRight(uint32_t(r_PtxRegister1428), uint32_t(28));				   // PTX L3264
	r_PtxRegister1437 = uint32_t(r_LaneIndexAtPtx3254) + uint32_t(r_PtxRegister1436);		   // PTX L3265
	r_PtxRegister1438 = ShiftRightSigned(int32_t(r_PtxRegister1437), uint32_t(4));			   // PTX L3266
	r_PtxRegister1439 = uint32_t(r_PtxRegister1438) + uint32_t(r_PtxRegister41);			   // PTX L3267
	r_PtxRegister54 = uint32_t(r_PtxRegister1439) + uint32_t(2);							   // PTX L3268
	r_PtxRegister55 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1435);				   // PTX L3269
	r_bPtxPredicate127 = int32_t(r_PtxRegister54) < int32_t(0);								   // PTX L3270
	r_bPtxPredicate128 = int32_t(r_PtxRegister54) >= int32_t(r_Scalar32Bits);				   // PTX L3271
	r_bPtxPredicate129 = r_bPtxPredicate127 | r_bPtxPredicate128;							   // PTX L3272
	r_bPtxPredicate130 = int32_t(r_PtxRegister55) < int32_t(0);								   // PTX L3273
	r_bPtxPredicate131 = int32_t(r_PtxRegister55) >= int32_t(r_Scalar36Bits);				   // PTX L3274
	r_bPtxPredicate132 = r_bPtxPredicate130 | r_bPtxPredicate131;							   // PTX L3275
	r_bPtxPredicate133 = r_bPtxPredicate129 | r_bPtxPredicate132;							   // PTX L3276
	if (r_bPtxPredicate133)
	{
		goto L__BB34_136;
	} // PTX L3277
	r_PtxRegister1440 = r_PtxRegister1430 & -4;										  // PTX L3278
	r_PtxRegister1441 = uint32_t(r_LaneIndexAtPtx3254) - uint32_t(r_PtxRegister1440); // PTX L3279
	r_PtxRegister1442 = ShiftLeft(uint32_t(r_PtxRegister55), uint32_t(2));			  // PTX L3280
	r_PtxRegister1443 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister54); // PTX L3281
	r_PtxRegister1444 =
		uint32_t(r_PtxRegister1443) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1442); // PTX L3282
	r_PtxRegister1445 = uint32_t(r_PtxRegister1444) + uint32_t(r_PtxRegister1441);			   // PTX L3283
	r_PtxU64Register277 = uint64_t(int64_t(int32_t(r_PtxRegister1445)) * int64_t(int32_t(4))); // PTX L3284
	r_PtxU64Register278 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register277);		   // PTX L3285
	*reinterpret_cast<uint32_t*>(r_PtxU64Register278) = r_PackedHalf2AtPtx1858R2695;		   // PTX L3286
L__BB34_136:																				   // PTX L3287
	r_LaneIndexAtPtx3289 = uint32_t((threadIdx.x & 31u));									   // PTX L3289
	r_PtxRegister1447 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3289), uint32_t(31));		   // PTX L3291
	r_PtxRegister1448 = ShiftRight(uint32_t(r_PtxRegister1447), uint32_t(30));				   // PTX L3292
	r_PtxRegister1449 = uint32_t(r_LaneIndexAtPtx3289) + uint32_t(r_PtxRegister1448);		   // PTX L3293
	r_PtxRegister1450 = ShiftRightSigned(int32_t(r_PtxRegister1449), uint32_t(2));			   // PTX L3294
	r_PtxRegister1451 = ShiftRight(uint32_t(r_PtxRegister1450), uint32_t(30));				   // PTX L3295
	r_PtxRegister1452 = uint32_t(r_PtxRegister1450) + uint32_t(r_PtxRegister1451);			   // PTX L3296
	r_PtxRegister1453 = r_PtxRegister1452 & -4;												   // PTX L3297
	r_PtxRegister1454 = uint32_t(r_PtxRegister1450) - uint32_t(r_PtxRegister1453);			   // PTX L3298
	r_PtxRegister1455 = ShiftRight(uint32_t(r_PtxRegister1447), uint32_t(28));				   // PTX L3299
	r_PtxRegister1456 = uint32_t(r_LaneIndexAtPtx3289) + uint32_t(r_PtxRegister1455);		   // PTX L3300
	r_PtxRegister1457 = ShiftRightSigned(int32_t(r_PtxRegister1456), uint32_t(4));			   // PTX L3301
	r_PtxRegister56 = uint32_t(r_PtxRegister40) + uint32_t(3);								   // PTX L3302
	r_PtxRegister57 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1457);				   // PTX L3303
	r_PtxRegister58 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1454);				   // PTX L3304
	r_bPtxPredicate134 = int32_t(r_PtxRegister57) < int32_t(0);								   // PTX L3305
	r_bPtxPredicate135 = int32_t(r_PtxRegister57) >= int32_t(r_Scalar32Bits);				   // PTX L3306
	r_bPtxPredicate136 = r_bPtxPredicate134 | r_bPtxPredicate135;							   // PTX L3307
	r_bPtxPredicate137 = int32_t(r_PtxRegister58) < int32_t(0);								   // PTX L3308
	r_bPtxPredicate138 = int32_t(r_PtxRegister58) >= int32_t(r_Scalar36Bits);				   // PTX L3309
	r_bPtxPredicate139 = r_bPtxPredicate137 | r_bPtxPredicate138;							   // PTX L3310
	r_bPtxPredicate140 = r_bPtxPredicate136 | r_bPtxPredicate139;							   // PTX L3311
	if (r_bPtxPredicate140)
	{
		goto L__BB34_138;
	} // PTX L3312
	r_PtxRegister1458 = r_PtxRegister1449 & -4;										  // PTX L3313
	r_PtxRegister1459 = uint32_t(r_LaneIndexAtPtx3289) - uint32_t(r_PtxRegister1458); // PTX L3314
	r_PtxRegister1460 = ShiftLeft(uint32_t(r_PtxRegister58), uint32_t(2));			  // PTX L3315
	r_PtxRegister1461 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister57); // PTX L3316
	r_PtxRegister1462 =
		uint32_t(r_PtxRegister1461) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1460); // PTX L3317
	r_PtxRegister1463 = uint32_t(r_PtxRegister1462) + uint32_t(r_PtxRegister1459);			   // PTX L3318
	r_PtxU64Register279 = uint64_t(int64_t(int32_t(r_PtxRegister1463)) * int64_t(int32_t(4))); // PTX L3319
	r_PtxU64Register280 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register279);		   // PTX L3320
	*reinterpret_cast<uint32_t*>(r_PtxU64Register280) = r_PackedHalf2AtPtx1865R2694;		   // PTX L3321
L__BB34_138:																				   // PTX L3322
	r_LaneIndexAtPtx3324 = uint32_t((threadIdx.x & 31u));									   // PTX L3324
	r_PtxRegister1465 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3324), uint32_t(31));		   // PTX L3326
	r_PtxRegister1466 = ShiftRight(uint32_t(r_PtxRegister1465), uint32_t(30));				   // PTX L3327
	r_PtxRegister1467 = uint32_t(r_LaneIndexAtPtx3324) + uint32_t(r_PtxRegister1466);		   // PTX L3328
	r_PtxRegister1468 = ShiftRightSigned(int32_t(r_PtxRegister1467), uint32_t(2));			   // PTX L3329
	r_PtxRegister1469 = ShiftRight(uint32_t(r_PtxRegister1468), uint32_t(30));				   // PTX L3330
	r_PtxRegister1470 = uint32_t(r_PtxRegister1468) + uint32_t(r_PtxRegister1469);			   // PTX L3331
	r_PtxRegister1471 = r_PtxRegister1470 & -4;												   // PTX L3332
	r_PtxRegister1472 = uint32_t(r_PtxRegister1468) - uint32_t(r_PtxRegister1471);			   // PTX L3333
	r_PtxRegister1473 = ShiftRight(uint32_t(r_PtxRegister1465), uint32_t(28));				   // PTX L3334
	r_PtxRegister1474 = uint32_t(r_LaneIndexAtPtx3324) + uint32_t(r_PtxRegister1473);		   // PTX L3335
	r_PtxRegister1475 = ShiftRightSigned(int32_t(r_PtxRegister1474), uint32_t(4));			   // PTX L3336
	r_PtxRegister1476 = uint32_t(r_PtxRegister1475) + uint32_t(r_PtxRegister41);			   // PTX L3337
	r_PtxRegister59 = uint32_t(r_PtxRegister1476) + uint32_t(2);							   // PTX L3338
	r_PtxRegister60 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1472);				   // PTX L3339
	r_bPtxPredicate141 = int32_t(r_PtxRegister59) < int32_t(0);								   // PTX L3340
	r_bPtxPredicate142 = int32_t(r_PtxRegister59) >= int32_t(r_Scalar32Bits);				   // PTX L3341
	r_bPtxPredicate143 = r_bPtxPredicate141 | r_bPtxPredicate142;							   // PTX L3342
	r_bPtxPredicate144 = int32_t(r_PtxRegister60) < int32_t(0);								   // PTX L3343
	r_bPtxPredicate145 = int32_t(r_PtxRegister60) >= int32_t(r_Scalar36Bits);				   // PTX L3344
	r_bPtxPredicate146 = r_bPtxPredicate144 | r_bPtxPredicate145;							   // PTX L3345
	r_bPtxPredicate147 = r_bPtxPredicate143 | r_bPtxPredicate146;							   // PTX L3346
	if (r_bPtxPredicate147)
	{
		goto L__BB34_140;
	} // PTX L3347
	r_PtxRegister1477 = r_PtxRegister1467 & -4;										  // PTX L3348
	r_PtxRegister1478 = uint32_t(r_LaneIndexAtPtx3324) - uint32_t(r_PtxRegister1477); // PTX L3349
	r_PtxRegister1479 = ShiftLeft(uint32_t(r_PtxRegister60), uint32_t(2));			  // PTX L3350
	r_PtxRegister1480 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister59); // PTX L3351
	r_PtxRegister1481 =
		uint32_t(r_PtxRegister1480) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1479); // PTX L3352
	r_PtxRegister1482 = uint32_t(r_PtxRegister1481) + uint32_t(r_PtxRegister1478);			   // PTX L3353
	r_PtxU64Register281 = uint64_t(int64_t(int32_t(r_PtxRegister1482)) * int64_t(int32_t(4))); // PTX L3354
	r_PtxU64Register282 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register281);		   // PTX L3355
	*reinterpret_cast<uint32_t*>(r_PtxU64Register282) = r_PackedHalf2AtPtx1872R2693;		   // PTX L3356
L__BB34_140:																				   // PTX L3357
	r_LaneIndexAtPtx3359 = uint32_t((threadIdx.x & 31u));									   // PTX L3359
	r_PtxRegister1484 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3359), uint32_t(31));		   // PTX L3361
	r_PtxRegister1485 = ShiftRight(uint32_t(r_PtxRegister1484), uint32_t(30));				   // PTX L3362
	r_PtxRegister1486 = uint32_t(r_LaneIndexAtPtx3359) + uint32_t(r_PtxRegister1485);		   // PTX L3363
	r_PtxRegister1487 = ShiftRightSigned(int32_t(r_PtxRegister1486), uint32_t(2));			   // PTX L3364
	r_PtxRegister1488 = ShiftRight(uint32_t(r_PtxRegister1487), uint32_t(30));				   // PTX L3365
	r_PtxRegister1489 = uint32_t(r_PtxRegister1487) + uint32_t(r_PtxRegister1488);			   // PTX L3366
	r_PtxRegister1490 = r_PtxRegister1489 & -4;												   // PTX L3367
	r_PtxRegister1491 = uint32_t(r_PtxRegister1487) - uint32_t(r_PtxRegister1490);			   // PTX L3368
	r_PtxRegister1492 = ShiftRight(uint32_t(r_PtxRegister1484), uint32_t(28));				   // PTX L3369
	r_PtxRegister1493 = uint32_t(r_LaneIndexAtPtx3359) + uint32_t(r_PtxRegister1492);		   // PTX L3370
	r_PtxRegister1494 = ShiftRightSigned(int32_t(r_PtxRegister1493), uint32_t(4));			   // PTX L3371
	r_PtxRegister61 = uint32_t(r_PtxRegister40) + uint32_t(4);								   // PTX L3372
	r_PtxRegister62 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1494);				   // PTX L3373
	r_PtxRegister63 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1491);				   // PTX L3374
	r_bPtxPredicate148 = int32_t(r_PtxRegister62) < int32_t(0);								   // PTX L3375
	r_bPtxPredicate149 = int32_t(r_PtxRegister62) >= int32_t(r_Scalar32Bits);				   // PTX L3376
	r_bPtxPredicate150 = r_bPtxPredicate148 | r_bPtxPredicate149;							   // PTX L3377
	r_bPtxPredicate151 = int32_t(r_PtxRegister63) < int32_t(0);								   // PTX L3378
	r_bPtxPredicate152 = int32_t(r_PtxRegister63) >= int32_t(r_Scalar36Bits);				   // PTX L3379
	r_bPtxPredicate153 = r_bPtxPredicate151 | r_bPtxPredicate152;							   // PTX L3380
	r_bPtxPredicate154 = r_bPtxPredicate150 | r_bPtxPredicate153;							   // PTX L3381
	if (r_bPtxPredicate154)
	{
		goto L__BB34_142;
	} // PTX L3382
	r_PtxRegister1495 = r_PtxRegister1486 & -4;										  // PTX L3383
	r_PtxRegister1496 = uint32_t(r_LaneIndexAtPtx3359) - uint32_t(r_PtxRegister1495); // PTX L3384
	r_PtxRegister1497 = ShiftLeft(uint32_t(r_PtxRegister63), uint32_t(2));			  // PTX L3385
	r_PtxRegister1498 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister62); // PTX L3386
	r_PtxRegister1499 =
		uint32_t(r_PtxRegister1498) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1497); // PTX L3387
	r_PtxRegister1500 = uint32_t(r_PtxRegister1499) + uint32_t(r_PtxRegister1496);			   // PTX L3388
	r_PtxU64Register283 = uint64_t(int64_t(int32_t(r_PtxRegister1500)) * int64_t(int32_t(4))); // PTX L3389
	r_PtxU64Register284 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register283);		   // PTX L3390
	*reinterpret_cast<uint32_t*>(r_PtxU64Register284) = r_PackedHalf2AtPtx1879R2692;		   // PTX L3391
L__BB34_142:																				   // PTX L3392
	r_LaneIndexAtPtx3394 = uint32_t((threadIdx.x & 31u));									   // PTX L3394
	r_PtxRegister1502 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3394), uint32_t(31));		   // PTX L3396
	r_PtxRegister1503 = ShiftRight(uint32_t(r_PtxRegister1502), uint32_t(30));				   // PTX L3397
	r_PtxRegister1504 = uint32_t(r_LaneIndexAtPtx3394) + uint32_t(r_PtxRegister1503);		   // PTX L3398
	r_PtxRegister1505 = ShiftRightSigned(int32_t(r_PtxRegister1504), uint32_t(2));			   // PTX L3399
	r_PtxRegister1506 = ShiftRight(uint32_t(r_PtxRegister1505), uint32_t(30));				   // PTX L3400
	r_PtxRegister1507 = uint32_t(r_PtxRegister1505) + uint32_t(r_PtxRegister1506);			   // PTX L3401
	r_PtxRegister1508 = r_PtxRegister1507 & -4;												   // PTX L3402
	r_PtxRegister1509 = uint32_t(r_PtxRegister1505) - uint32_t(r_PtxRegister1508);			   // PTX L3403
	r_PtxRegister1510 = ShiftRight(uint32_t(r_PtxRegister1502), uint32_t(28));				   // PTX L3404
	r_PtxRegister1511 = uint32_t(r_LaneIndexAtPtx3394) + uint32_t(r_PtxRegister1510);		   // PTX L3405
	r_PtxRegister1512 = ShiftRightSigned(int32_t(r_PtxRegister1511), uint32_t(4));			   // PTX L3406
	r_PtxRegister1513 = uint32_t(r_PtxRegister1512) + uint32_t(r_PtxRegister41);			   // PTX L3407
	r_PtxRegister64 = uint32_t(r_PtxRegister1513) + uint32_t(2);							   // PTX L3408
	r_PtxRegister65 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1509);				   // PTX L3409
	r_bPtxPredicate155 = int32_t(r_PtxRegister64) < int32_t(0);								   // PTX L3410
	r_bPtxPredicate156 = int32_t(r_PtxRegister64) >= int32_t(r_Scalar32Bits);				   // PTX L3411
	r_bPtxPredicate157 = r_bPtxPredicate155 | r_bPtxPredicate156;							   // PTX L3412
	r_bPtxPredicate158 = int32_t(r_PtxRegister65) < int32_t(0);								   // PTX L3413
	r_bPtxPredicate159 = int32_t(r_PtxRegister65) >= int32_t(r_Scalar36Bits);				   // PTX L3414
	r_bPtxPredicate160 = r_bPtxPredicate158 | r_bPtxPredicate159;							   // PTX L3415
	r_bPtxPredicate161 = r_bPtxPredicate157 | r_bPtxPredicate160;							   // PTX L3416
	if (r_bPtxPredicate161)
	{
		goto L__BB34_144;
	} // PTX L3417
	r_PtxRegister1514 = r_PtxRegister1504 & -4;										  // PTX L3418
	r_PtxRegister1515 = uint32_t(r_LaneIndexAtPtx3394) - uint32_t(r_PtxRegister1514); // PTX L3419
	r_PtxRegister1516 = ShiftLeft(uint32_t(r_PtxRegister65), uint32_t(2));			  // PTX L3420
	r_PtxRegister1517 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister64); // PTX L3421
	r_PtxRegister1518 =
		uint32_t(r_PtxRegister1517) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1516); // PTX L3422
	r_PtxRegister1519 = uint32_t(r_PtxRegister1518) + uint32_t(r_PtxRegister1515);			   // PTX L3423
	r_PtxU64Register285 = uint64_t(int64_t(int32_t(r_PtxRegister1519)) * int64_t(int32_t(4))); // PTX L3424
	r_PtxU64Register286 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register285);		   // PTX L3425
	*reinterpret_cast<uint32_t*>(r_PtxU64Register286) = r_PackedHalf2AtPtx1886R2691;		   // PTX L3426
L__BB34_144:																				   // PTX L3427
	r_LaneIndexAtPtx3429 = uint32_t((threadIdx.x & 31u));									   // PTX L3429
	r_PtxRegister1521 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3429), uint32_t(31));		   // PTX L3431
	r_PtxRegister1522 = ShiftRight(uint32_t(r_PtxRegister1521), uint32_t(30));				   // PTX L3432
	r_PtxRegister1523 = uint32_t(r_LaneIndexAtPtx3429) + uint32_t(r_PtxRegister1522);		   // PTX L3433
	r_PtxRegister1524 = ShiftRightSigned(int32_t(r_PtxRegister1523), uint32_t(2));			   // PTX L3434
	r_PtxRegister1525 = ShiftRight(uint32_t(r_PtxRegister1524), uint32_t(30));				   // PTX L3435
	r_PtxRegister1526 = uint32_t(r_PtxRegister1524) + uint32_t(r_PtxRegister1525);			   // PTX L3436
	r_PtxRegister1527 = r_PtxRegister1526 & -4;												   // PTX L3437
	r_PtxRegister1528 = uint32_t(r_PtxRegister1524) - uint32_t(r_PtxRegister1527);			   // PTX L3438
	r_PtxRegister1529 = ShiftRight(uint32_t(r_PtxRegister1521), uint32_t(28));				   // PTX L3439
	r_PtxRegister1530 = uint32_t(r_LaneIndexAtPtx3429) + uint32_t(r_PtxRegister1529);		   // PTX L3440
	r_PtxRegister1531 = ShiftRightSigned(int32_t(r_PtxRegister1530), uint32_t(4));			   // PTX L3441
	r_PtxRegister66 = uint32_t(r_PtxRegister40) + uint32_t(5);								   // PTX L3442
	r_PtxRegister67 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1531);				   // PTX L3443
	r_PtxRegister68 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1528);				   // PTX L3444
	r_bPtxPredicate162 = int32_t(r_PtxRegister67) < int32_t(0);								   // PTX L3445
	r_bPtxPredicate163 = int32_t(r_PtxRegister67) >= int32_t(r_Scalar32Bits);				   // PTX L3446
	r_bPtxPredicate164 = r_bPtxPredicate162 | r_bPtxPredicate163;							   // PTX L3447
	r_bPtxPredicate165 = int32_t(r_PtxRegister68) < int32_t(0);								   // PTX L3448
	r_bPtxPredicate166 = int32_t(r_PtxRegister68) >= int32_t(r_Scalar36Bits);				   // PTX L3449
	r_bPtxPredicate167 = r_bPtxPredicate165 | r_bPtxPredicate166;							   // PTX L3450
	r_bPtxPredicate168 = r_bPtxPredicate164 | r_bPtxPredicate167;							   // PTX L3451
	if (r_bPtxPredicate168)
	{
		goto L__BB34_146;
	} // PTX L3452
	r_PtxRegister1532 = r_PtxRegister1523 & -4;										  // PTX L3453
	r_PtxRegister1533 = uint32_t(r_LaneIndexAtPtx3429) - uint32_t(r_PtxRegister1532); // PTX L3454
	r_PtxRegister1534 = ShiftLeft(uint32_t(r_PtxRegister68), uint32_t(2));			  // PTX L3455
	r_PtxRegister1535 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister67); // PTX L3456
	r_PtxRegister1536 =
		uint32_t(r_PtxRegister1535) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1534); // PTX L3457
	r_PtxRegister1537 = uint32_t(r_PtxRegister1536) + uint32_t(r_PtxRegister1533);			   // PTX L3458
	r_PtxU64Register287 = uint64_t(int64_t(int32_t(r_PtxRegister1537)) * int64_t(int32_t(4))); // PTX L3459
	r_PtxU64Register288 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register287);		   // PTX L3460
	*reinterpret_cast<uint32_t*>(r_PtxU64Register288) = r_PackedHalf2AtPtx1893R2690;		   // PTX L3461
L__BB34_146:																				   // PTX L3462
	r_LaneIndexAtPtx3464 = uint32_t((threadIdx.x & 31u));									   // PTX L3464
	r_PtxRegister1539 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3464), uint32_t(31));		   // PTX L3466
	r_PtxRegister1540 = ShiftRight(uint32_t(r_PtxRegister1539), uint32_t(30));				   // PTX L3467
	r_PtxRegister1541 = uint32_t(r_LaneIndexAtPtx3464) + uint32_t(r_PtxRegister1540);		   // PTX L3468
	r_PtxRegister1542 = ShiftRightSigned(int32_t(r_PtxRegister1541), uint32_t(2));			   // PTX L3469
	r_PtxRegister1543 = ShiftRight(uint32_t(r_PtxRegister1542), uint32_t(30));				   // PTX L3470
	r_PtxRegister1544 = uint32_t(r_PtxRegister1542) + uint32_t(r_PtxRegister1543);			   // PTX L3471
	r_PtxRegister1545 = r_PtxRegister1544 & -4;												   // PTX L3472
	r_PtxRegister1546 = uint32_t(r_PtxRegister1542) - uint32_t(r_PtxRegister1545);			   // PTX L3473
	r_PtxRegister1547 = ShiftRight(uint32_t(r_PtxRegister1539), uint32_t(28));				   // PTX L3474
	r_PtxRegister1548 = uint32_t(r_LaneIndexAtPtx3464) + uint32_t(r_PtxRegister1547);		   // PTX L3475
	r_PtxRegister1549 = ShiftRightSigned(int32_t(r_PtxRegister1548), uint32_t(4));			   // PTX L3476
	r_PtxRegister1550 = uint32_t(r_PtxRegister1549) + uint32_t(r_PtxRegister41);			   // PTX L3477
	r_PtxRegister69 = uint32_t(r_PtxRegister1550) + uint32_t(2);							   // PTX L3478
	r_PtxRegister70 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1546);				   // PTX L3479
	r_bPtxPredicate169 = int32_t(r_PtxRegister69) < int32_t(0);								   // PTX L3480
	r_bPtxPredicate170 = int32_t(r_PtxRegister69) >= int32_t(r_Scalar32Bits);				   // PTX L3481
	r_bPtxPredicate171 = r_bPtxPredicate169 | r_bPtxPredicate170;							   // PTX L3482
	r_bPtxPredicate172 = int32_t(r_PtxRegister70) < int32_t(0);								   // PTX L3483
	r_bPtxPredicate173 = int32_t(r_PtxRegister70) >= int32_t(r_Scalar36Bits);				   // PTX L3484
	r_bPtxPredicate174 = r_bPtxPredicate172 | r_bPtxPredicate173;							   // PTX L3485
	r_bPtxPredicate175 = r_bPtxPredicate171 | r_bPtxPredicate174;							   // PTX L3486
	if (r_bPtxPredicate175)
	{
		goto L__BB34_148;
	} // PTX L3487
	r_PtxRegister1551 = r_PtxRegister1541 & -4;										  // PTX L3488
	r_PtxRegister1552 = uint32_t(r_LaneIndexAtPtx3464) - uint32_t(r_PtxRegister1551); // PTX L3489
	r_PtxRegister1553 = ShiftLeft(uint32_t(r_PtxRegister70), uint32_t(2));			  // PTX L3490
	r_PtxRegister1554 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister69); // PTX L3491
	r_PtxRegister1555 =
		uint32_t(r_PtxRegister1554) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1553); // PTX L3492
	r_PtxRegister1556 = uint32_t(r_PtxRegister1555) + uint32_t(r_PtxRegister1552);			   // PTX L3493
	r_PtxU64Register289 = uint64_t(int64_t(int32_t(r_PtxRegister1556)) * int64_t(int32_t(4))); // PTX L3494
	r_PtxU64Register290 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register289);		   // PTX L3495
	*reinterpret_cast<uint32_t*>(r_PtxU64Register290) = r_PackedHalf2AtPtx1900R2689;		   // PTX L3496
L__BB34_148:																				   // PTX L3497
	r_LaneIndexAtPtx3499 = uint32_t((threadIdx.x & 31u));									   // PTX L3499
	r_PtxRegister1558 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3499), uint32_t(31));		   // PTX L3501
	r_PtxRegister1559 = ShiftRight(uint32_t(r_PtxRegister1558), uint32_t(30));				   // PTX L3502
	r_PtxRegister1560 = uint32_t(r_LaneIndexAtPtx3499) + uint32_t(r_PtxRegister1559);		   // PTX L3503
	r_PtxRegister1561 = ShiftRightSigned(int32_t(r_PtxRegister1560), uint32_t(2));			   // PTX L3504
	r_PtxRegister1562 = ShiftRight(uint32_t(r_PtxRegister1561), uint32_t(30));				   // PTX L3505
	r_PtxRegister1563 = uint32_t(r_PtxRegister1561) + uint32_t(r_PtxRegister1562);			   // PTX L3506
	r_PtxRegister1564 = r_PtxRegister1563 & -4;												   // PTX L3507
	r_PtxRegister1565 = uint32_t(r_PtxRegister1561) - uint32_t(r_PtxRegister1564);			   // PTX L3508
	r_PtxRegister1566 = ShiftRight(uint32_t(r_PtxRegister1558), uint32_t(28));				   // PTX L3509
	r_PtxRegister1567 = uint32_t(r_LaneIndexAtPtx3499) + uint32_t(r_PtxRegister1566);		   // PTX L3510
	r_PtxRegister1568 = ShiftRightSigned(int32_t(r_PtxRegister1567), uint32_t(4));			   // PTX L3511
	r_PtxRegister71 = uint32_t(r_PtxRegister40) + uint32_t(6);								   // PTX L3512
	r_PtxRegister72 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1568);				   // PTX L3513
	r_PtxRegister73 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1565);				   // PTX L3514
	r_bPtxPredicate176 = int32_t(r_PtxRegister72) < int32_t(0);								   // PTX L3515
	r_bPtxPredicate177 = int32_t(r_PtxRegister72) >= int32_t(r_Scalar32Bits);				   // PTX L3516
	r_bPtxPredicate178 = r_bPtxPredicate176 | r_bPtxPredicate177;							   // PTX L3517
	r_bPtxPredicate179 = int32_t(r_PtxRegister73) < int32_t(0);								   // PTX L3518
	r_bPtxPredicate180 = int32_t(r_PtxRegister73) >= int32_t(r_Scalar36Bits);				   // PTX L3519
	r_bPtxPredicate181 = r_bPtxPredicate179 | r_bPtxPredicate180;							   // PTX L3520
	r_bPtxPredicate182 = r_bPtxPredicate178 | r_bPtxPredicate181;							   // PTX L3521
	if (r_bPtxPredicate182)
	{
		goto L__BB34_150;
	} // PTX L3522
	r_PtxRegister1569 = r_PtxRegister1560 & -4;										  // PTX L3523
	r_PtxRegister1570 = uint32_t(r_LaneIndexAtPtx3499) - uint32_t(r_PtxRegister1569); // PTX L3524
	r_PtxRegister1571 = ShiftLeft(uint32_t(r_PtxRegister73), uint32_t(2));			  // PTX L3525
	r_PtxRegister1572 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister72); // PTX L3526
	r_PtxRegister1573 =
		uint32_t(r_PtxRegister1572) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1571); // PTX L3527
	r_PtxRegister1574 = uint32_t(r_PtxRegister1573) + uint32_t(r_PtxRegister1570);			   // PTX L3528
	r_PtxU64Register291 = uint64_t(int64_t(int32_t(r_PtxRegister1574)) * int64_t(int32_t(4))); // PTX L3529
	r_PtxU64Register292 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register291);		   // PTX L3530
	*reinterpret_cast<uint32_t*>(r_PtxU64Register292) = r_PackedHalf2AtPtx1907R2688;		   // PTX L3531
L__BB34_150:																				   // PTX L3532
	r_LaneIndexAtPtx3534 = uint32_t((threadIdx.x & 31u));									   // PTX L3534
	r_PtxRegister1576 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3534), uint32_t(31));		   // PTX L3536
	r_PtxRegister1577 = ShiftRight(uint32_t(r_PtxRegister1576), uint32_t(30));				   // PTX L3537
	r_PtxRegister1578 = uint32_t(r_LaneIndexAtPtx3534) + uint32_t(r_PtxRegister1577);		   // PTX L3538
	r_PtxRegister1579 = ShiftRightSigned(int32_t(r_PtxRegister1578), uint32_t(2));			   // PTX L3539
	r_PtxRegister1580 = ShiftRight(uint32_t(r_PtxRegister1579), uint32_t(30));				   // PTX L3540
	r_PtxRegister1581 = uint32_t(r_PtxRegister1579) + uint32_t(r_PtxRegister1580);			   // PTX L3541
	r_PtxRegister1582 = r_PtxRegister1581 & -4;												   // PTX L3542
	r_PtxRegister1583 = uint32_t(r_PtxRegister1579) - uint32_t(r_PtxRegister1582);			   // PTX L3543
	r_PtxRegister1584 = ShiftRight(uint32_t(r_PtxRegister1576), uint32_t(28));				   // PTX L3544
	r_PtxRegister1585 = uint32_t(r_LaneIndexAtPtx3534) + uint32_t(r_PtxRegister1584);		   // PTX L3545
	r_PtxRegister1586 = ShiftRightSigned(int32_t(r_PtxRegister1585), uint32_t(4));			   // PTX L3546
	r_PtxRegister1587 = uint32_t(r_PtxRegister1586) + uint32_t(r_PtxRegister41);			   // PTX L3547
	r_PtxRegister74 = uint32_t(r_PtxRegister1587) + uint32_t(2);							   // PTX L3548
	r_PtxRegister75 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1583);				   // PTX L3549
	r_bPtxPredicate183 = int32_t(r_PtxRegister74) < int32_t(0);								   // PTX L3550
	r_bPtxPredicate184 = int32_t(r_PtxRegister74) >= int32_t(r_Scalar32Bits);				   // PTX L3551
	r_bPtxPredicate185 = r_bPtxPredicate183 | r_bPtxPredicate184;							   // PTX L3552
	r_bPtxPredicate186 = int32_t(r_PtxRegister75) < int32_t(0);								   // PTX L3553
	r_bPtxPredicate187 = int32_t(r_PtxRegister75) >= int32_t(r_Scalar36Bits);				   // PTX L3554
	r_bPtxPredicate188 = r_bPtxPredicate186 | r_bPtxPredicate187;							   // PTX L3555
	r_bPtxPredicate189 = r_bPtxPredicate185 | r_bPtxPredicate188;							   // PTX L3556
	if (r_bPtxPredicate189)
	{
		goto L__BB34_152;
	} // PTX L3557
	r_PtxRegister1588 = r_PtxRegister1578 & -4;										  // PTX L3558
	r_PtxRegister1589 = uint32_t(r_LaneIndexAtPtx3534) - uint32_t(r_PtxRegister1588); // PTX L3559
	r_PtxRegister1590 = ShiftLeft(uint32_t(r_PtxRegister75), uint32_t(2));			  // PTX L3560
	r_PtxRegister1591 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister74); // PTX L3561
	r_PtxRegister1592 =
		uint32_t(r_PtxRegister1591) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1590); // PTX L3562
	r_PtxRegister1593 = uint32_t(r_PtxRegister1592) + uint32_t(r_PtxRegister1589);			   // PTX L3563
	r_PtxU64Register293 = uint64_t(int64_t(int32_t(r_PtxRegister1593)) * int64_t(int32_t(4))); // PTX L3564
	r_PtxU64Register294 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register293);		   // PTX L3565
	*reinterpret_cast<uint32_t*>(r_PtxU64Register294) = r_PackedHalf2AtPtx1914R2687;		   // PTX L3566
L__BB34_152:																				   // PTX L3567
	r_LaneIndexAtPtx3569 = uint32_t((threadIdx.x & 31u));									   // PTX L3569
	r_PtxRegister1595 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3569), uint32_t(31));		   // PTX L3571
	r_PtxRegister1596 = ShiftRight(uint32_t(r_PtxRegister1595), uint32_t(30));				   // PTX L3572
	r_PtxRegister1597 = uint32_t(r_LaneIndexAtPtx3569) + uint32_t(r_PtxRegister1596);		   // PTX L3573
	r_PtxRegister1598 = ShiftRightSigned(int32_t(r_PtxRegister1597), uint32_t(2));			   // PTX L3574
	r_PtxRegister1599 = ShiftRight(uint32_t(r_PtxRegister1598), uint32_t(30));				   // PTX L3575
	r_PtxRegister1600 = uint32_t(r_PtxRegister1598) + uint32_t(r_PtxRegister1599);			   // PTX L3576
	r_PtxRegister1601 = r_PtxRegister1600 & -4;												   // PTX L3577
	r_PtxRegister1602 = uint32_t(r_PtxRegister1598) - uint32_t(r_PtxRegister1601);			   // PTX L3578
	r_PtxRegister1603 = ShiftRight(uint32_t(r_PtxRegister1595), uint32_t(28));				   // PTX L3579
	r_PtxRegister1604 = uint32_t(r_LaneIndexAtPtx3569) + uint32_t(r_PtxRegister1603);		   // PTX L3580
	r_PtxRegister1605 = ShiftRightSigned(int32_t(r_PtxRegister1604), uint32_t(4));			   // PTX L3581
	r_PtxRegister76 = uint32_t(r_PtxRegister40) + uint32_t(7);								   // PTX L3582
	r_PtxRegister77 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1605);				   // PTX L3583
	r_PtxRegister78 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1602);				   // PTX L3584
	r_bPtxPredicate190 = int32_t(r_PtxRegister77) < int32_t(0);								   // PTX L3585
	r_bPtxPredicate191 = int32_t(r_PtxRegister77) >= int32_t(r_Scalar32Bits);				   // PTX L3586
	r_bPtxPredicate192 = r_bPtxPredicate190 | r_bPtxPredicate191;							   // PTX L3587
	r_bPtxPredicate193 = int32_t(r_PtxRegister78) < int32_t(0);								   // PTX L3588
	r_bPtxPredicate194 = int32_t(r_PtxRegister78) >= int32_t(r_Scalar36Bits);				   // PTX L3589
	r_bPtxPredicate195 = r_bPtxPredicate193 | r_bPtxPredicate194;							   // PTX L3590
	r_bPtxPredicate196 = r_bPtxPredicate192 | r_bPtxPredicate195;							   // PTX L3591
	if (r_bPtxPredicate196)
	{
		goto L__BB34_154;
	} // PTX L3592
	r_PtxRegister1606 = r_PtxRegister1597 & -4;										  // PTX L3593
	r_PtxRegister1607 = uint32_t(r_LaneIndexAtPtx3569) - uint32_t(r_PtxRegister1606); // PTX L3594
	r_PtxRegister1608 = ShiftLeft(uint32_t(r_PtxRegister78), uint32_t(2));			  // PTX L3595
	r_PtxRegister1609 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister77); // PTX L3596
	r_PtxRegister1610 =
		uint32_t(r_PtxRegister1609) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1608); // PTX L3597
	r_PtxRegister1611 = uint32_t(r_PtxRegister1610) + uint32_t(r_PtxRegister1607);			   // PTX L3598
	r_PtxU64Register295 = uint64_t(int64_t(int32_t(r_PtxRegister1611)) * int64_t(int32_t(4))); // PTX L3599
	r_PtxU64Register296 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register295);		   // PTX L3600
	*reinterpret_cast<uint32_t*>(r_PtxU64Register296) = r_PackedHalf2AtPtx1921R2686;		   // PTX L3601
L__BB34_154:																				   // PTX L3602
	r_LaneIndexAtPtx3604 = uint32_t((threadIdx.x & 31u));									   // PTX L3604
	r_PtxRegister1613 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3604), uint32_t(31));		   // PTX L3606
	r_PtxRegister1614 = ShiftRight(uint32_t(r_PtxRegister1613), uint32_t(30));				   // PTX L3607
	r_PtxRegister1615 = uint32_t(r_LaneIndexAtPtx3604) + uint32_t(r_PtxRegister1614);		   // PTX L3608
	r_PtxRegister1616 = ShiftRightSigned(int32_t(r_PtxRegister1615), uint32_t(2));			   // PTX L3609
	r_PtxRegister1617 = ShiftRight(uint32_t(r_PtxRegister1616), uint32_t(30));				   // PTX L3610
	r_PtxRegister1618 = uint32_t(r_PtxRegister1616) + uint32_t(r_PtxRegister1617);			   // PTX L3611
	r_PtxRegister1619 = r_PtxRegister1618 & -4;												   // PTX L3612
	r_PtxRegister1620 = uint32_t(r_PtxRegister1616) - uint32_t(r_PtxRegister1619);			   // PTX L3613
	r_PtxRegister1621 = ShiftRight(uint32_t(r_PtxRegister1613), uint32_t(28));				   // PTX L3614
	r_PtxRegister1622 = uint32_t(r_LaneIndexAtPtx3604) + uint32_t(r_PtxRegister1621);		   // PTX L3615
	r_PtxRegister1623 = ShiftRightSigned(int32_t(r_PtxRegister1622), uint32_t(4));			   // PTX L3616
	r_PtxRegister1624 = uint32_t(r_PtxRegister1623) + uint32_t(r_PtxRegister41);			   // PTX L3617
	r_PtxRegister79 = uint32_t(r_PtxRegister1624) + uint32_t(2);							   // PTX L3618
	r_PtxRegister80 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1620);				   // PTX L3619
	r_bPtxPredicate197 = int32_t(r_PtxRegister79) < int32_t(0);								   // PTX L3620
	r_bPtxPredicate198 = int32_t(r_PtxRegister79) >= int32_t(r_Scalar32Bits);				   // PTX L3621
	r_bPtxPredicate199 = r_bPtxPredicate197 | r_bPtxPredicate198;							   // PTX L3622
	r_bPtxPredicate200 = int32_t(r_PtxRegister80) < int32_t(0);								   // PTX L3623
	r_bPtxPredicate201 = int32_t(r_PtxRegister80) >= int32_t(r_Scalar36Bits);				   // PTX L3624
	r_bPtxPredicate202 = r_bPtxPredicate200 | r_bPtxPredicate201;							   // PTX L3625
	r_bPtxPredicate203 = r_bPtxPredicate199 | r_bPtxPredicate202;							   // PTX L3626
	if (r_bPtxPredicate203)
	{
		goto L__BB34_156;
	} // PTX L3627
	r_PtxRegister1625 = r_PtxRegister1615 & -4;										  // PTX L3628
	r_PtxRegister1626 = uint32_t(r_LaneIndexAtPtx3604) - uint32_t(r_PtxRegister1625); // PTX L3629
	r_PtxRegister1627 = ShiftLeft(uint32_t(r_PtxRegister80), uint32_t(2));			  // PTX L3630
	r_PtxRegister1628 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister79); // PTX L3631
	r_PtxRegister1629 =
		uint32_t(r_PtxRegister1628) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1627); // PTX L3632
	r_PtxRegister1630 = uint32_t(r_PtxRegister1629) + uint32_t(r_PtxRegister1626);			   // PTX L3633
	r_PtxU64Register297 = uint64_t(int64_t(int32_t(r_PtxRegister1630)) * int64_t(int32_t(4))); // PTX L3634
	r_PtxU64Register298 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register297);		   // PTX L3635
	*reinterpret_cast<uint32_t*>(r_PtxU64Register298) = r_PackedHalf2AtPtx1928R2685;		   // PTX L3636
L__BB34_156:																				   // PTX L3637
	r_LaneIndexAtPtx3639 = uint32_t((threadIdx.x & 31u));									   // PTX L3639
	r_PtxRegister1632 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3639), uint32_t(31));		   // PTX L3641
	r_PtxRegister1633 = ShiftRight(uint32_t(r_PtxRegister1632), uint32_t(30));				   // PTX L3642
	r_PtxRegister1634 = uint32_t(r_LaneIndexAtPtx3639) + uint32_t(r_PtxRegister1633);		   // PTX L3643
	r_PtxRegister1635 = ShiftRightSigned(int32_t(r_PtxRegister1634), uint32_t(2));			   // PTX L3644
	r_PtxRegister1636 = ShiftRight(uint32_t(r_PtxRegister1635), uint32_t(30));				   // PTX L3645
	r_PtxRegister1637 = uint32_t(r_PtxRegister1635) + uint32_t(r_PtxRegister1636);			   // PTX L3646
	r_PtxRegister1638 = r_PtxRegister1637 & -4;												   // PTX L3647
	r_PtxRegister1639 = uint32_t(r_PtxRegister1635) - uint32_t(r_PtxRegister1638);			   // PTX L3648
	r_PtxRegister1640 = ShiftRight(uint32_t(r_PtxRegister1632), uint32_t(28));				   // PTX L3649
	r_PtxRegister1641 = uint32_t(r_LaneIndexAtPtx3639) + uint32_t(r_PtxRegister1640);		   // PTX L3650
	r_PtxRegister1642 = ShiftRightSigned(int32_t(r_PtxRegister1641), uint32_t(4));			   // PTX L3651
	r_PtxRegister1643 = uint32_t(r_PtxRegister1639) + uint32_t(r_PtxRegister4);				   // PTX L3652
	r_PtxRegister81 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1642);				   // PTX L3653
	r_PtxRegister82 = uint32_t(r_PtxRegister1643) + uint32_t(4);							   // PTX L3654
	r_bPtxPredicate204 = int32_t(r_PtxRegister81) < int32_t(0);								   // PTX L3655
	r_bPtxPredicate205 = int32_t(r_PtxRegister81) >= int32_t(r_Scalar32Bits);				   // PTX L3656
	r_bPtxPredicate206 = int32_t(r_PtxRegister82) >= int32_t(r_Scalar36Bits);				   // PTX L3657
	r_bPtxPredicate207 = r_bPtxPredicate205 | r_bPtxPredicate206;							   // PTX L3658
	r_bPtxPredicate208 = r_bPtxPredicate207 | r_bPtxPredicate204;							   // PTX L3659
	if (r_bPtxPredicate208)
	{
		goto L__BB34_158;
	} // PTX L3660
	r_PtxRegister1644 = r_PtxRegister1634 & -4;										  // PTX L3661
	r_PtxRegister1645 = uint32_t(r_LaneIndexAtPtx3639) - uint32_t(r_PtxRegister1644); // PTX L3662
	r_PtxRegister1646 = ShiftLeft(uint32_t(r_PtxRegister82), uint32_t(2));			  // PTX L3663
	r_PtxRegister1647 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister81); // PTX L3664
	r_PtxRegister1648 =
		uint32_t(r_PtxRegister1647) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1646); // PTX L3665
	r_PtxRegister1649 = uint32_t(r_PtxRegister1648) + uint32_t(r_PtxRegister1645);			   // PTX L3666
	r_PtxU64Register299 = uint64_t(int64_t(int32_t(r_PtxRegister1649)) * int64_t(int32_t(4))); // PTX L3667
	r_PtxU64Register300 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register299);		   // PTX L3668
	*reinterpret_cast<uint32_t*>(r_PtxU64Register300) = r_PackedHalf2AtPtx1935R2684;		   // PTX L3669
L__BB34_158:																				   // PTX L3670
	r_LaneIndexAtPtx3672 = uint32_t((threadIdx.x & 31u));									   // PTX L3672
	r_PtxRegister1651 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3672), uint32_t(31));		   // PTX L3674
	r_PtxRegister1652 = ShiftRight(uint32_t(r_PtxRegister1651), uint32_t(30));				   // PTX L3675
	r_PtxRegister1653 = uint32_t(r_LaneIndexAtPtx3672) + uint32_t(r_PtxRegister1652);		   // PTX L3676
	r_PtxRegister1654 = ShiftRightSigned(int32_t(r_PtxRegister1653), uint32_t(2));			   // PTX L3677
	r_PtxRegister1655 = ShiftRight(uint32_t(r_PtxRegister1654), uint32_t(30));				   // PTX L3678
	r_PtxRegister1656 = uint32_t(r_PtxRegister1654) + uint32_t(r_PtxRegister1655);			   // PTX L3679
	r_PtxRegister1657 = r_PtxRegister1656 & -4;												   // PTX L3680
	r_PtxRegister1658 = uint32_t(r_PtxRegister1654) - uint32_t(r_PtxRegister1657);			   // PTX L3681
	r_PtxRegister1659 = ShiftRight(uint32_t(r_PtxRegister1651), uint32_t(28));				   // PTX L3682
	r_PtxRegister1660 = uint32_t(r_LaneIndexAtPtx3672) + uint32_t(r_PtxRegister1659);		   // PTX L3683
	r_PtxRegister1661 = ShiftRightSigned(int32_t(r_PtxRegister1660), uint32_t(4));			   // PTX L3684
	r_PtxRegister1662 = uint32_t(r_PtxRegister1661) + uint32_t(r_PtxRegister41);			   // PTX L3685
	r_PtxRegister1663 = uint32_t(r_PtxRegister1658) + uint32_t(r_PtxRegister4);				   // PTX L3686
	r_PtxRegister83 = uint32_t(r_PtxRegister1662) + uint32_t(2);							   // PTX L3687
	r_PtxRegister84 = uint32_t(r_PtxRegister1663) + uint32_t(4);							   // PTX L3688
	r_bPtxPredicate209 = int32_t(r_PtxRegister83) < int32_t(0);								   // PTX L3689
	r_bPtxPredicate210 = int32_t(r_PtxRegister83) >= int32_t(r_Scalar32Bits);				   // PTX L3690
	r_bPtxPredicate211 = int32_t(r_PtxRegister84) >= int32_t(r_Scalar36Bits);				   // PTX L3691
	r_bPtxPredicate212 = r_bPtxPredicate210 | r_bPtxPredicate211;							   // PTX L3692
	r_bPtxPredicate213 = r_bPtxPredicate212 | r_bPtxPredicate209;							   // PTX L3693
	if (r_bPtxPredicate213)
	{
		goto L__BB34_160;
	} // PTX L3694
	r_PtxRegister1664 = r_PtxRegister1653 & -4;										  // PTX L3695
	r_PtxRegister1665 = uint32_t(r_LaneIndexAtPtx3672) - uint32_t(r_PtxRegister1664); // PTX L3696
	r_PtxRegister1666 = ShiftLeft(uint32_t(r_PtxRegister84), uint32_t(2));			  // PTX L3697
	r_PtxRegister1667 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister83); // PTX L3698
	r_PtxRegister1668 =
		uint32_t(r_PtxRegister1667) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1666); // PTX L3699
	r_PtxRegister1669 = uint32_t(r_PtxRegister1668) + uint32_t(r_PtxRegister1665);			   // PTX L3700
	r_PtxU64Register301 = uint64_t(int64_t(int32_t(r_PtxRegister1669)) * int64_t(int32_t(4))); // PTX L3701
	r_PtxU64Register302 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register301);		   // PTX L3702
	*reinterpret_cast<uint32_t*>(r_PtxU64Register302) = r_PackedHalf2AtPtx1942R2683;		   // PTX L3703
L__BB34_160:																				   // PTX L3704
	r_LaneIndexAtPtx3706 = uint32_t((threadIdx.x & 31u));									   // PTX L3706
	r_PtxRegister1671 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3706), uint32_t(31));		   // PTX L3708
	r_PtxRegister1672 = ShiftRight(uint32_t(r_PtxRegister1671), uint32_t(30));				   // PTX L3709
	r_PtxRegister1673 = uint32_t(r_LaneIndexAtPtx3706) + uint32_t(r_PtxRegister1672);		   // PTX L3710
	r_PtxRegister1674 = ShiftRightSigned(int32_t(r_PtxRegister1673), uint32_t(2));			   // PTX L3711
	r_PtxRegister1675 = ShiftRight(uint32_t(r_PtxRegister1674), uint32_t(30));				   // PTX L3712
	r_PtxRegister1676 = uint32_t(r_PtxRegister1674) + uint32_t(r_PtxRegister1675);			   // PTX L3713
	r_PtxRegister1677 = r_PtxRegister1676 & -4;												   // PTX L3714
	r_PtxRegister1678 = uint32_t(r_PtxRegister1674) - uint32_t(r_PtxRegister1677);			   // PTX L3715
	r_PtxRegister1679 = ShiftRight(uint32_t(r_PtxRegister1671), uint32_t(28));				   // PTX L3716
	r_PtxRegister1680 = uint32_t(r_LaneIndexAtPtx3706) + uint32_t(r_PtxRegister1679);		   // PTX L3717
	r_PtxRegister1681 = ShiftRightSigned(int32_t(r_PtxRegister1680), uint32_t(4));			   // PTX L3718
	r_PtxRegister1682 = uint32_t(r_PtxRegister1678) + uint32_t(r_PtxRegister4);				   // PTX L3719
	r_PtxRegister85 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1681);				   // PTX L3720
	r_PtxRegister86 = uint32_t(r_PtxRegister1682) + uint32_t(4);							   // PTX L3721
	r_bPtxPredicate214 = int32_t(r_PtxRegister85) < int32_t(0);								   // PTX L3722
	r_bPtxPredicate215 = int32_t(r_PtxRegister85) >= int32_t(r_Scalar32Bits);				   // PTX L3723
	r_bPtxPredicate216 = int32_t(r_PtxRegister86) >= int32_t(r_Scalar36Bits);				   // PTX L3724
	r_bPtxPredicate217 = r_bPtxPredicate215 | r_bPtxPredicate216;							   // PTX L3725
	r_bPtxPredicate218 = r_bPtxPredicate217 | r_bPtxPredicate214;							   // PTX L3726
	if (r_bPtxPredicate218)
	{
		goto L__BB34_162;
	} // PTX L3727
	r_PtxRegister1683 = r_PtxRegister1673 & -4;										  // PTX L3728
	r_PtxRegister1684 = uint32_t(r_LaneIndexAtPtx3706) - uint32_t(r_PtxRegister1683); // PTX L3729
	r_PtxRegister1685 = ShiftLeft(uint32_t(r_PtxRegister86), uint32_t(2));			  // PTX L3730
	r_PtxRegister1686 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister85); // PTX L3731
	r_PtxRegister1687 =
		uint32_t(r_PtxRegister1686) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1685); // PTX L3732
	r_PtxRegister1688 = uint32_t(r_PtxRegister1687) + uint32_t(r_PtxRegister1684);			   // PTX L3733
	r_PtxU64Register303 = uint64_t(int64_t(int32_t(r_PtxRegister1688)) * int64_t(int32_t(4))); // PTX L3734
	r_PtxU64Register304 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register303);		   // PTX L3735
	*reinterpret_cast<uint32_t*>(r_PtxU64Register304) = r_PackedHalf2AtPtx1949R2682;		   // PTX L3736
L__BB34_162:																				   // PTX L3737
	r_LaneIndexAtPtx3739 = uint32_t((threadIdx.x & 31u));									   // PTX L3739
	r_PtxRegister1690 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3739), uint32_t(31));		   // PTX L3741
	r_PtxRegister1691 = ShiftRight(uint32_t(r_PtxRegister1690), uint32_t(30));				   // PTX L3742
	r_PtxRegister1692 = uint32_t(r_LaneIndexAtPtx3739) + uint32_t(r_PtxRegister1691);		   // PTX L3743
	r_PtxRegister1693 = ShiftRightSigned(int32_t(r_PtxRegister1692), uint32_t(2));			   // PTX L3744
	r_PtxRegister1694 = ShiftRight(uint32_t(r_PtxRegister1693), uint32_t(30));				   // PTX L3745
	r_PtxRegister1695 = uint32_t(r_PtxRegister1693) + uint32_t(r_PtxRegister1694);			   // PTX L3746
	r_PtxRegister1696 = r_PtxRegister1695 & -4;												   // PTX L3747
	r_PtxRegister1697 = uint32_t(r_PtxRegister1693) - uint32_t(r_PtxRegister1696);			   // PTX L3748
	r_PtxRegister1698 = ShiftRight(uint32_t(r_PtxRegister1690), uint32_t(28));				   // PTX L3749
	r_PtxRegister1699 = uint32_t(r_LaneIndexAtPtx3739) + uint32_t(r_PtxRegister1698);		   // PTX L3750
	r_PtxRegister1700 = ShiftRightSigned(int32_t(r_PtxRegister1699), uint32_t(4));			   // PTX L3751
	r_PtxRegister1701 = uint32_t(r_PtxRegister1700) + uint32_t(r_PtxRegister41);			   // PTX L3752
	r_PtxRegister1702 = uint32_t(r_PtxRegister1697) + uint32_t(r_PtxRegister4);				   // PTX L3753
	r_PtxRegister87 = uint32_t(r_PtxRegister1701) + uint32_t(2);							   // PTX L3754
	r_PtxRegister88 = uint32_t(r_PtxRegister1702) + uint32_t(4);							   // PTX L3755
	r_bPtxPredicate219 = int32_t(r_PtxRegister87) < int32_t(0);								   // PTX L3756
	r_bPtxPredicate220 = int32_t(r_PtxRegister87) >= int32_t(r_Scalar32Bits);				   // PTX L3757
	r_bPtxPredicate221 = int32_t(r_PtxRegister88) >= int32_t(r_Scalar36Bits);				   // PTX L3758
	r_bPtxPredicate222 = r_bPtxPredicate220 | r_bPtxPredicate221;							   // PTX L3759
	r_bPtxPredicate223 = r_bPtxPredicate222 | r_bPtxPredicate219;							   // PTX L3760
	if (r_bPtxPredicate223)
	{
		goto L__BB34_164;
	} // PTX L3761
	r_PtxRegister1703 = r_PtxRegister1692 & -4;										  // PTX L3762
	r_PtxRegister1704 = uint32_t(r_LaneIndexAtPtx3739) - uint32_t(r_PtxRegister1703); // PTX L3763
	r_PtxRegister1705 = ShiftLeft(uint32_t(r_PtxRegister88), uint32_t(2));			  // PTX L3764
	r_PtxRegister1706 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister87); // PTX L3765
	r_PtxRegister1707 =
		uint32_t(r_PtxRegister1706) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1705); // PTX L3766
	r_PtxRegister1708 = uint32_t(r_PtxRegister1707) + uint32_t(r_PtxRegister1704);			   // PTX L3767
	r_PtxU64Register305 = uint64_t(int64_t(int32_t(r_PtxRegister1708)) * int64_t(int32_t(4))); // PTX L3768
	r_PtxU64Register306 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register305);		   // PTX L3769
	*reinterpret_cast<uint32_t*>(r_PtxU64Register306) = r_PackedHalf2AtPtx1956R2681;		   // PTX L3770
L__BB34_164:																				   // PTX L3771
	r_LaneIndexAtPtx3773 = uint32_t((threadIdx.x & 31u));									   // PTX L3773
	r_PtxRegister1710 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3773), uint32_t(31));		   // PTX L3775
	r_PtxRegister1711 = ShiftRight(uint32_t(r_PtxRegister1710), uint32_t(30));				   // PTX L3776
	r_PtxRegister1712 = uint32_t(r_LaneIndexAtPtx3773) + uint32_t(r_PtxRegister1711);		   // PTX L3777
	r_PtxRegister1713 = ShiftRightSigned(int32_t(r_PtxRegister1712), uint32_t(2));			   // PTX L3778
	r_PtxRegister1714 = ShiftRight(uint32_t(r_PtxRegister1713), uint32_t(30));				   // PTX L3779
	r_PtxRegister1715 = uint32_t(r_PtxRegister1713) + uint32_t(r_PtxRegister1714);			   // PTX L3780
	r_PtxRegister1716 = r_PtxRegister1715 & -4;												   // PTX L3781
	r_PtxRegister1717 = uint32_t(r_PtxRegister1713) - uint32_t(r_PtxRegister1716);			   // PTX L3782
	r_PtxRegister1718 = ShiftRight(uint32_t(r_PtxRegister1710), uint32_t(28));				   // PTX L3783
	r_PtxRegister1719 = uint32_t(r_LaneIndexAtPtx3773) + uint32_t(r_PtxRegister1718);		   // PTX L3784
	r_PtxRegister1720 = ShiftRightSigned(int32_t(r_PtxRegister1719), uint32_t(4));			   // PTX L3785
	r_PtxRegister1721 = uint32_t(r_PtxRegister1717) + uint32_t(r_PtxRegister4);				   // PTX L3786
	r_PtxRegister89 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1720);				   // PTX L3787
	r_PtxRegister90 = uint32_t(r_PtxRegister1721) + uint32_t(4);							   // PTX L3788
	r_bPtxPredicate224 = int32_t(r_PtxRegister89) < int32_t(0);								   // PTX L3789
	r_bPtxPredicate225 = int32_t(r_PtxRegister89) >= int32_t(r_Scalar32Bits);				   // PTX L3790
	r_bPtxPredicate226 = int32_t(r_PtxRegister90) >= int32_t(r_Scalar36Bits);				   // PTX L3791
	r_bPtxPredicate227 = r_bPtxPredicate225 | r_bPtxPredicate226;							   // PTX L3792
	r_bPtxPredicate228 = r_bPtxPredicate227 | r_bPtxPredicate224;							   // PTX L3793
	if (r_bPtxPredicate228)
	{
		goto L__BB34_166;
	} // PTX L3794
	r_PtxRegister1722 = r_PtxRegister1712 & -4;										  // PTX L3795
	r_PtxRegister1723 = uint32_t(r_LaneIndexAtPtx3773) - uint32_t(r_PtxRegister1722); // PTX L3796
	r_PtxRegister1724 = ShiftLeft(uint32_t(r_PtxRegister90), uint32_t(2));			  // PTX L3797
	r_PtxRegister1725 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister89); // PTX L3798
	r_PtxRegister1726 =
		uint32_t(r_PtxRegister1725) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1724); // PTX L3799
	r_PtxRegister1727 = uint32_t(r_PtxRegister1726) + uint32_t(r_PtxRegister1723);			   // PTX L3800
	r_PtxU64Register307 = uint64_t(int64_t(int32_t(r_PtxRegister1727)) * int64_t(int32_t(4))); // PTX L3801
	r_PtxU64Register308 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register307);		   // PTX L3802
	*reinterpret_cast<uint32_t*>(r_PtxU64Register308) = r_PackedHalf2AtPtx1963R2680;		   // PTX L3803
L__BB34_166:																				   // PTX L3804
	r_LaneIndexAtPtx3806 = uint32_t((threadIdx.x & 31u));									   // PTX L3806
	r_PtxRegister1729 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3806), uint32_t(31));		   // PTX L3808
	r_PtxRegister1730 = ShiftRight(uint32_t(r_PtxRegister1729), uint32_t(30));				   // PTX L3809
	r_PtxRegister1731 = uint32_t(r_LaneIndexAtPtx3806) + uint32_t(r_PtxRegister1730);		   // PTX L3810
	r_PtxRegister1732 = ShiftRightSigned(int32_t(r_PtxRegister1731), uint32_t(2));			   // PTX L3811
	r_PtxRegister1733 = ShiftRight(uint32_t(r_PtxRegister1732), uint32_t(30));				   // PTX L3812
	r_PtxRegister1734 = uint32_t(r_PtxRegister1732) + uint32_t(r_PtxRegister1733);			   // PTX L3813
	r_PtxRegister1735 = r_PtxRegister1734 & -4;												   // PTX L3814
	r_PtxRegister1736 = uint32_t(r_PtxRegister1732) - uint32_t(r_PtxRegister1735);			   // PTX L3815
	r_PtxRegister1737 = ShiftRight(uint32_t(r_PtxRegister1729), uint32_t(28));				   // PTX L3816
	r_PtxRegister1738 = uint32_t(r_LaneIndexAtPtx3806) + uint32_t(r_PtxRegister1737);		   // PTX L3817
	r_PtxRegister1739 = ShiftRightSigned(int32_t(r_PtxRegister1738), uint32_t(4));			   // PTX L3818
	r_PtxRegister1740 = uint32_t(r_PtxRegister1739) + uint32_t(r_PtxRegister41);			   // PTX L3819
	r_PtxRegister1741 = uint32_t(r_PtxRegister1736) + uint32_t(r_PtxRegister4);				   // PTX L3820
	r_PtxRegister91 = uint32_t(r_PtxRegister1740) + uint32_t(2);							   // PTX L3821
	r_PtxRegister92 = uint32_t(r_PtxRegister1741) + uint32_t(4);							   // PTX L3822
	r_bPtxPredicate229 = int32_t(r_PtxRegister91) < int32_t(0);								   // PTX L3823
	r_bPtxPredicate230 = int32_t(r_PtxRegister91) >= int32_t(r_Scalar32Bits);				   // PTX L3824
	r_bPtxPredicate231 = int32_t(r_PtxRegister92) >= int32_t(r_Scalar36Bits);				   // PTX L3825
	r_bPtxPredicate232 = r_bPtxPredicate230 | r_bPtxPredicate231;							   // PTX L3826
	r_bPtxPredicate233 = r_bPtxPredicate232 | r_bPtxPredicate229;							   // PTX L3827
	if (r_bPtxPredicate233)
	{
		goto L__BB34_168;
	} // PTX L3828
	r_PtxRegister1742 = r_PtxRegister1731 & -4;										  // PTX L3829
	r_PtxRegister1743 = uint32_t(r_LaneIndexAtPtx3806) - uint32_t(r_PtxRegister1742); // PTX L3830
	r_PtxRegister1744 = ShiftLeft(uint32_t(r_PtxRegister92), uint32_t(2));			  // PTX L3831
	r_PtxRegister1745 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister91); // PTX L3832
	r_PtxRegister1746 =
		uint32_t(r_PtxRegister1745) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1744); // PTX L3833
	r_PtxRegister1747 = uint32_t(r_PtxRegister1746) + uint32_t(r_PtxRegister1743);			   // PTX L3834
	r_PtxU64Register309 = uint64_t(int64_t(int32_t(r_PtxRegister1747)) * int64_t(int32_t(4))); // PTX L3835
	r_PtxU64Register310 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register309);		   // PTX L3836
	*reinterpret_cast<uint32_t*>(r_PtxU64Register310) = r_PackedHalf2AtPtx1970R2679;		   // PTX L3837
L__BB34_168:																				   // PTX L3838
	r_LaneIndexAtPtx3840 = uint32_t((threadIdx.x & 31u));									   // PTX L3840
	r_PtxRegister1749 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3840), uint32_t(31));		   // PTX L3842
	r_PtxRegister1750 = ShiftRight(uint32_t(r_PtxRegister1749), uint32_t(30));				   // PTX L3843
	r_PtxRegister1751 = uint32_t(r_LaneIndexAtPtx3840) + uint32_t(r_PtxRegister1750);		   // PTX L3844
	r_PtxRegister1752 = ShiftRightSigned(int32_t(r_PtxRegister1751), uint32_t(2));			   // PTX L3845
	r_PtxRegister1753 = ShiftRight(uint32_t(r_PtxRegister1752), uint32_t(30));				   // PTX L3846
	r_PtxRegister1754 = uint32_t(r_PtxRegister1752) + uint32_t(r_PtxRegister1753);			   // PTX L3847
	r_PtxRegister1755 = r_PtxRegister1754 & -4;												   // PTX L3848
	r_PtxRegister1756 = uint32_t(r_PtxRegister1752) - uint32_t(r_PtxRegister1755);			   // PTX L3849
	r_PtxRegister1757 = ShiftRight(uint32_t(r_PtxRegister1749), uint32_t(28));				   // PTX L3850
	r_PtxRegister1758 = uint32_t(r_LaneIndexAtPtx3840) + uint32_t(r_PtxRegister1757);		   // PTX L3851
	r_PtxRegister1759 = ShiftRightSigned(int32_t(r_PtxRegister1758), uint32_t(4));			   // PTX L3852
	r_PtxRegister1760 = uint32_t(r_PtxRegister1756) + uint32_t(r_PtxRegister4);				   // PTX L3853
	r_PtxRegister93 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1759);				   // PTX L3854
	r_PtxRegister94 = uint32_t(r_PtxRegister1760) + uint32_t(4);							   // PTX L3855
	r_bPtxPredicate234 = int32_t(r_PtxRegister93) < int32_t(0);								   // PTX L3856
	r_bPtxPredicate235 = int32_t(r_PtxRegister93) >= int32_t(r_Scalar32Bits);				   // PTX L3857
	r_bPtxPredicate236 = int32_t(r_PtxRegister94) >= int32_t(r_Scalar36Bits);				   // PTX L3858
	r_bPtxPredicate237 = r_bPtxPredicate235 | r_bPtxPredicate236;							   // PTX L3859
	r_bPtxPredicate238 = r_bPtxPredicate237 | r_bPtxPredicate234;							   // PTX L3860
	if (r_bPtxPredicate238)
	{
		goto L__BB34_170;
	} // PTX L3861
	r_PtxRegister1761 = r_PtxRegister1751 & -4;										  // PTX L3862
	r_PtxRegister1762 = uint32_t(r_LaneIndexAtPtx3840) - uint32_t(r_PtxRegister1761); // PTX L3863
	r_PtxRegister1763 = ShiftLeft(uint32_t(r_PtxRegister94), uint32_t(2));			  // PTX L3864
	r_PtxRegister1764 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister93); // PTX L3865
	r_PtxRegister1765 =
		uint32_t(r_PtxRegister1764) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1763); // PTX L3866
	r_PtxRegister1766 = uint32_t(r_PtxRegister1765) + uint32_t(r_PtxRegister1762);			   // PTX L3867
	r_PtxU64Register311 = uint64_t(int64_t(int32_t(r_PtxRegister1766)) * int64_t(int32_t(4))); // PTX L3868
	r_PtxU64Register312 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register311);		   // PTX L3869
	*reinterpret_cast<uint32_t*>(r_PtxU64Register312) = r_PackedHalf2AtPtx1977R2678;		   // PTX L3870
L__BB34_170:																				   // PTX L3871
	r_LaneIndexAtPtx3873 = uint32_t((threadIdx.x & 31u));									   // PTX L3873
	r_PtxRegister1768 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3873), uint32_t(31));		   // PTX L3875
	r_PtxRegister1769 = ShiftRight(uint32_t(r_PtxRegister1768), uint32_t(30));				   // PTX L3876
	r_PtxRegister1770 = uint32_t(r_LaneIndexAtPtx3873) + uint32_t(r_PtxRegister1769);		   // PTX L3877
	r_PtxRegister1771 = ShiftRightSigned(int32_t(r_PtxRegister1770), uint32_t(2));			   // PTX L3878
	r_PtxRegister1772 = ShiftRight(uint32_t(r_PtxRegister1771), uint32_t(30));				   // PTX L3879
	r_PtxRegister1773 = uint32_t(r_PtxRegister1771) + uint32_t(r_PtxRegister1772);			   // PTX L3880
	r_PtxRegister1774 = r_PtxRegister1773 & -4;												   // PTX L3881
	r_PtxRegister1775 = uint32_t(r_PtxRegister1771) - uint32_t(r_PtxRegister1774);			   // PTX L3882
	r_PtxRegister1776 = ShiftRight(uint32_t(r_PtxRegister1768), uint32_t(28));				   // PTX L3883
	r_PtxRegister1777 = uint32_t(r_LaneIndexAtPtx3873) + uint32_t(r_PtxRegister1776);		   // PTX L3884
	r_PtxRegister1778 = ShiftRightSigned(int32_t(r_PtxRegister1777), uint32_t(4));			   // PTX L3885
	r_PtxRegister1779 = uint32_t(r_PtxRegister1778) + uint32_t(r_PtxRegister41);			   // PTX L3886
	r_PtxRegister1780 = uint32_t(r_PtxRegister1775) + uint32_t(r_PtxRegister4);				   // PTX L3887
	r_PtxRegister95 = uint32_t(r_PtxRegister1779) + uint32_t(2);							   // PTX L3888
	r_PtxRegister96 = uint32_t(r_PtxRegister1780) + uint32_t(4);							   // PTX L3889
	r_bPtxPredicate239 = int32_t(r_PtxRegister95) < int32_t(0);								   // PTX L3890
	r_bPtxPredicate240 = int32_t(r_PtxRegister95) >= int32_t(r_Scalar32Bits);				   // PTX L3891
	r_bPtxPredicate241 = int32_t(r_PtxRegister96) >= int32_t(r_Scalar36Bits);				   // PTX L3892
	r_bPtxPredicate242 = r_bPtxPredicate240 | r_bPtxPredicate241;							   // PTX L3893
	r_bPtxPredicate243 = r_bPtxPredicate242 | r_bPtxPredicate239;							   // PTX L3894
	if (r_bPtxPredicate243)
	{
		goto L__BB34_172;
	} // PTX L3895
	r_PtxRegister1781 = r_PtxRegister1770 & -4;										  // PTX L3896
	r_PtxRegister1782 = uint32_t(r_LaneIndexAtPtx3873) - uint32_t(r_PtxRegister1781); // PTX L3897
	r_PtxRegister1783 = ShiftLeft(uint32_t(r_PtxRegister96), uint32_t(2));			  // PTX L3898
	r_PtxRegister1784 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister95); // PTX L3899
	r_PtxRegister1785 =
		uint32_t(r_PtxRegister1784) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1783); // PTX L3900
	r_PtxRegister1786 = uint32_t(r_PtxRegister1785) + uint32_t(r_PtxRegister1782);			   // PTX L3901
	r_PtxU64Register313 = uint64_t(int64_t(int32_t(r_PtxRegister1786)) * int64_t(int32_t(4))); // PTX L3902
	r_PtxU64Register314 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register313);		   // PTX L3903
	*reinterpret_cast<uint32_t*>(r_PtxU64Register314) = r_PackedHalf2AtPtx1984R2677;		   // PTX L3904
L__BB34_172:																				   // PTX L3905
	r_LaneIndexAtPtx3907 = uint32_t((threadIdx.x & 31u));									   // PTX L3907
	r_PtxRegister1788 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3907), uint32_t(31));		   // PTX L3909
	r_PtxRegister1789 = ShiftRight(uint32_t(r_PtxRegister1788), uint32_t(30));				   // PTX L3910
	r_PtxRegister1790 = uint32_t(r_LaneIndexAtPtx3907) + uint32_t(r_PtxRegister1789);		   // PTX L3911
	r_PtxRegister1791 = ShiftRightSigned(int32_t(r_PtxRegister1790), uint32_t(2));			   // PTX L3912
	r_PtxRegister1792 = ShiftRight(uint32_t(r_PtxRegister1791), uint32_t(30));				   // PTX L3913
	r_PtxRegister1793 = uint32_t(r_PtxRegister1791) + uint32_t(r_PtxRegister1792);			   // PTX L3914
	r_PtxRegister1794 = r_PtxRegister1793 & -4;												   // PTX L3915
	r_PtxRegister1795 = uint32_t(r_PtxRegister1791) - uint32_t(r_PtxRegister1794);			   // PTX L3916
	r_PtxRegister1796 = ShiftRight(uint32_t(r_PtxRegister1788), uint32_t(28));				   // PTX L3917
	r_PtxRegister1797 = uint32_t(r_LaneIndexAtPtx3907) + uint32_t(r_PtxRegister1796);		   // PTX L3918
	r_PtxRegister1798 = ShiftRightSigned(int32_t(r_PtxRegister1797), uint32_t(4));			   // PTX L3919
	r_PtxRegister1799 = uint32_t(r_PtxRegister1795) + uint32_t(r_PtxRegister4);				   // PTX L3920
	r_PtxRegister97 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1798);				   // PTX L3921
	r_PtxRegister98 = uint32_t(r_PtxRegister1799) + uint32_t(4);							   // PTX L3922
	r_bPtxPredicate244 = int32_t(r_PtxRegister97) < int32_t(0);								   // PTX L3923
	r_bPtxPredicate245 = int32_t(r_PtxRegister97) >= int32_t(r_Scalar32Bits);				   // PTX L3924
	r_bPtxPredicate246 = int32_t(r_PtxRegister98) >= int32_t(r_Scalar36Bits);				   // PTX L3925
	r_bPtxPredicate247 = r_bPtxPredicate245 | r_bPtxPredicate246;							   // PTX L3926
	r_bPtxPredicate248 = r_bPtxPredicate247 | r_bPtxPredicate244;							   // PTX L3927
	if (r_bPtxPredicate248)
	{
		goto L__BB34_174;
	} // PTX L3928
	r_PtxRegister1800 = r_PtxRegister1790 & -4;										  // PTX L3929
	r_PtxRegister1801 = uint32_t(r_LaneIndexAtPtx3907) - uint32_t(r_PtxRegister1800); // PTX L3930
	r_PtxRegister1802 = ShiftLeft(uint32_t(r_PtxRegister98), uint32_t(2));			  // PTX L3931
	r_PtxRegister1803 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister97); // PTX L3932
	r_PtxRegister1804 =
		uint32_t(r_PtxRegister1803) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1802); // PTX L3933
	r_PtxRegister1805 = uint32_t(r_PtxRegister1804) + uint32_t(r_PtxRegister1801);			   // PTX L3934
	r_PtxU64Register315 = uint64_t(int64_t(int32_t(r_PtxRegister1805)) * int64_t(int32_t(4))); // PTX L3935
	r_PtxU64Register316 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register315);		   // PTX L3936
	*reinterpret_cast<uint32_t*>(r_PtxU64Register316) = r_PackedHalf2AtPtx1991R2676;		   // PTX L3937
L__BB34_174:																				   // PTX L3938
	r_LaneIndexAtPtx3940 = uint32_t((threadIdx.x & 31u));									   // PTX L3940
	r_PtxRegister1807 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3940), uint32_t(31));		   // PTX L3942
	r_PtxRegister1808 = ShiftRight(uint32_t(r_PtxRegister1807), uint32_t(30));				   // PTX L3943
	r_PtxRegister1809 = uint32_t(r_LaneIndexAtPtx3940) + uint32_t(r_PtxRegister1808);		   // PTX L3944
	r_PtxRegister1810 = ShiftRightSigned(int32_t(r_PtxRegister1809), uint32_t(2));			   // PTX L3945
	r_PtxRegister1811 = ShiftRight(uint32_t(r_PtxRegister1810), uint32_t(30));				   // PTX L3946
	r_PtxRegister1812 = uint32_t(r_PtxRegister1810) + uint32_t(r_PtxRegister1811);			   // PTX L3947
	r_PtxRegister1813 = r_PtxRegister1812 & -4;												   // PTX L3948
	r_PtxRegister1814 = uint32_t(r_PtxRegister1810) - uint32_t(r_PtxRegister1813);			   // PTX L3949
	r_PtxRegister1815 = ShiftRight(uint32_t(r_PtxRegister1807), uint32_t(28));				   // PTX L3950
	r_PtxRegister1816 = uint32_t(r_LaneIndexAtPtx3940) + uint32_t(r_PtxRegister1815);		   // PTX L3951
	r_PtxRegister1817 = ShiftRightSigned(int32_t(r_PtxRegister1816), uint32_t(4));			   // PTX L3952
	r_PtxRegister1818 = uint32_t(r_PtxRegister1817) + uint32_t(r_PtxRegister41);			   // PTX L3953
	r_PtxRegister1819 = uint32_t(r_PtxRegister1814) + uint32_t(r_PtxRegister4);				   // PTX L3954
	r_PtxRegister99 = uint32_t(r_PtxRegister1818) + uint32_t(2);							   // PTX L3955
	r_PtxRegister100 = uint32_t(r_PtxRegister1819) + uint32_t(4);							   // PTX L3956
	r_bPtxPredicate249 = int32_t(r_PtxRegister99) < int32_t(0);								   // PTX L3957
	r_bPtxPredicate250 = int32_t(r_PtxRegister99) >= int32_t(r_Scalar32Bits);				   // PTX L3958
	r_bPtxPredicate251 = int32_t(r_PtxRegister100) >= int32_t(r_Scalar36Bits);				   // PTX L3959
	r_bPtxPredicate252 = r_bPtxPredicate250 | r_bPtxPredicate251;							   // PTX L3960
	r_bPtxPredicate253 = r_bPtxPredicate252 | r_bPtxPredicate249;							   // PTX L3961
	if (r_bPtxPredicate253)
	{
		goto L__BB34_176;
	} // PTX L3962
	r_PtxRegister1820 = r_PtxRegister1809 & -4;										  // PTX L3963
	r_PtxRegister1821 = uint32_t(r_LaneIndexAtPtx3940) - uint32_t(r_PtxRegister1820); // PTX L3964
	r_PtxRegister1822 = ShiftLeft(uint32_t(r_PtxRegister100), uint32_t(2));			  // PTX L3965
	r_PtxRegister1823 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister99); // PTX L3966
	r_PtxRegister1824 =
		uint32_t(r_PtxRegister1823) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1822); // PTX L3967
	r_PtxRegister1825 = uint32_t(r_PtxRegister1824) + uint32_t(r_PtxRegister1821);			   // PTX L3968
	r_PtxU64Register317 = uint64_t(int64_t(int32_t(r_PtxRegister1825)) * int64_t(int32_t(4))); // PTX L3969
	r_PtxU64Register318 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register317);		   // PTX L3970
	*reinterpret_cast<uint32_t*>(r_PtxU64Register318) = r_PackedHalf2AtPtx1998R2675;		   // PTX L3971
L__BB34_176:																				   // PTX L3972
	r_LaneIndexAtPtx3974 = uint32_t((threadIdx.x & 31u));									   // PTX L3974
	r_PtxRegister1827 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx3974), uint32_t(31));		   // PTX L3976
	r_PtxRegister1828 = ShiftRight(uint32_t(r_PtxRegister1827), uint32_t(30));				   // PTX L3977
	r_PtxRegister1829 = uint32_t(r_LaneIndexAtPtx3974) + uint32_t(r_PtxRegister1828);		   // PTX L3978
	r_PtxRegister1830 = ShiftRightSigned(int32_t(r_PtxRegister1829), uint32_t(2));			   // PTX L3979
	r_PtxRegister1831 = ShiftRight(uint32_t(r_PtxRegister1830), uint32_t(30));				   // PTX L3980
	r_PtxRegister1832 = uint32_t(r_PtxRegister1830) + uint32_t(r_PtxRegister1831);			   // PTX L3981
	r_PtxRegister1833 = r_PtxRegister1832 & -4;												   // PTX L3982
	r_PtxRegister1834 = uint32_t(r_PtxRegister1830) - uint32_t(r_PtxRegister1833);			   // PTX L3983
	r_PtxRegister1835 = ShiftRight(uint32_t(r_PtxRegister1827), uint32_t(28));				   // PTX L3984
	r_PtxRegister1836 = uint32_t(r_LaneIndexAtPtx3974) + uint32_t(r_PtxRegister1835);		   // PTX L3985
	r_PtxRegister1837 = ShiftRightSigned(int32_t(r_PtxRegister1836), uint32_t(4));			   // PTX L3986
	r_PtxRegister1838 = uint32_t(r_PtxRegister1834) + uint32_t(r_PtxRegister4);				   // PTX L3987
	r_PtxRegister101 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1837);				   // PTX L3988
	r_PtxRegister102 = uint32_t(r_PtxRegister1838) + uint32_t(4);							   // PTX L3989
	r_bPtxPredicate254 = int32_t(r_PtxRegister101) < int32_t(0);							   // PTX L3990
	r_bPtxPredicate255 = int32_t(r_PtxRegister101) >= int32_t(r_Scalar32Bits);				   // PTX L3991
	r_bPtxPredicate256 = int32_t(r_PtxRegister102) >= int32_t(r_Scalar36Bits);				   // PTX L3992
	r_bPtxPredicate257 = r_bPtxPredicate255 | r_bPtxPredicate256;							   // PTX L3993
	r_bPtxPredicate258 = r_bPtxPredicate257 | r_bPtxPredicate254;							   // PTX L3994
	if (r_bPtxPredicate258)
	{
		goto L__BB34_178;
	} // PTX L3995
	r_PtxRegister1839 = r_PtxRegister1829 & -4;										  // PTX L3996
	r_PtxRegister1840 = uint32_t(r_LaneIndexAtPtx3974) - uint32_t(r_PtxRegister1839); // PTX L3997
	r_PtxRegister1841 = ShiftLeft(uint32_t(r_PtxRegister102), uint32_t(2));			  // PTX L3998
	r_PtxRegister1842 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister101); // PTX L3999
	r_PtxRegister1843 =
		uint32_t(r_PtxRegister1842) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1841); // PTX L4000
	r_PtxRegister1844 = uint32_t(r_PtxRegister1843) + uint32_t(r_PtxRegister1840);			   // PTX L4001
	r_PtxU64Register319 = uint64_t(int64_t(int32_t(r_PtxRegister1844)) * int64_t(int32_t(4))); // PTX L4002
	r_PtxU64Register320 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register319);		   // PTX L4003
	*reinterpret_cast<uint32_t*>(r_PtxU64Register320) = r_PackedHalf2AtPtx2005R2674;		   // PTX L4004
L__BB34_178:																				   // PTX L4005
	r_LaneIndexAtPtx4007 = uint32_t((threadIdx.x & 31u));									   // PTX L4007
	r_PtxRegister1846 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4007), uint32_t(31));		   // PTX L4009
	r_PtxRegister1847 = ShiftRight(uint32_t(r_PtxRegister1846), uint32_t(30));				   // PTX L4010
	r_PtxRegister1848 = uint32_t(r_LaneIndexAtPtx4007) + uint32_t(r_PtxRegister1847);		   // PTX L4011
	r_PtxRegister1849 = ShiftRightSigned(int32_t(r_PtxRegister1848), uint32_t(2));			   // PTX L4012
	r_PtxRegister1850 = ShiftRight(uint32_t(r_PtxRegister1849), uint32_t(30));				   // PTX L4013
	r_PtxRegister1851 = uint32_t(r_PtxRegister1849) + uint32_t(r_PtxRegister1850);			   // PTX L4014
	r_PtxRegister1852 = r_PtxRegister1851 & -4;												   // PTX L4015
	r_PtxRegister1853 = uint32_t(r_PtxRegister1849) - uint32_t(r_PtxRegister1852);			   // PTX L4016
	r_PtxRegister1854 = ShiftRight(uint32_t(r_PtxRegister1846), uint32_t(28));				   // PTX L4017
	r_PtxRegister1855 = uint32_t(r_LaneIndexAtPtx4007) + uint32_t(r_PtxRegister1854);		   // PTX L4018
	r_PtxRegister1856 = ShiftRightSigned(int32_t(r_PtxRegister1855), uint32_t(4));			   // PTX L4019
	r_PtxRegister1857 = uint32_t(r_PtxRegister1856) + uint32_t(r_PtxRegister41);			   // PTX L4020
	r_PtxRegister1858 = uint32_t(r_PtxRegister1853) + uint32_t(r_PtxRegister4);				   // PTX L4021
	r_PtxRegister103 = uint32_t(r_PtxRegister1857) + uint32_t(2);							   // PTX L4022
	r_PtxRegister104 = uint32_t(r_PtxRegister1858) + uint32_t(4);							   // PTX L4023
	r_bPtxPredicate259 = int32_t(r_PtxRegister103) < int32_t(0);							   // PTX L4024
	r_bPtxPredicate260 = int32_t(r_PtxRegister103) >= int32_t(r_Scalar32Bits);				   // PTX L4025
	r_bPtxPredicate261 = int32_t(r_PtxRegister104) >= int32_t(r_Scalar36Bits);				   // PTX L4026
	r_bPtxPredicate262 = r_bPtxPredicate260 | r_bPtxPredicate261;							   // PTX L4027
	r_bPtxPredicate263 = r_bPtxPredicate262 | r_bPtxPredicate259;							   // PTX L4028
	if (r_bPtxPredicate263)
	{
		goto L__BB34_180;
	} // PTX L4029
	r_PtxRegister1859 = r_PtxRegister1848 & -4;										  // PTX L4030
	r_PtxRegister1860 = uint32_t(r_LaneIndexAtPtx4007) - uint32_t(r_PtxRegister1859); // PTX L4031
	r_PtxRegister1861 = ShiftLeft(uint32_t(r_PtxRegister104), uint32_t(2));			  // PTX L4032
	r_PtxRegister1862 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister103); // PTX L4033
	r_PtxRegister1863 =
		uint32_t(r_PtxRegister1862) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1861); // PTX L4034
	r_PtxRegister1864 = uint32_t(r_PtxRegister1863) + uint32_t(r_PtxRegister1860);			   // PTX L4035
	r_PtxU64Register321 = uint64_t(int64_t(int32_t(r_PtxRegister1864)) * int64_t(int32_t(4))); // PTX L4036
	r_PtxU64Register322 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register321);		   // PTX L4037
	*reinterpret_cast<uint32_t*>(r_PtxU64Register322) = r_PackedHalf2AtPtx2012R2673;		   // PTX L4038
L__BB34_180:																				   // PTX L4039
	r_LaneIndexAtPtx4041 = uint32_t((threadIdx.x & 31u));									   // PTX L4041
	r_PtxRegister1866 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4041), uint32_t(31));		   // PTX L4043
	r_PtxRegister1867 = ShiftRight(uint32_t(r_PtxRegister1866), uint32_t(30));				   // PTX L4044
	r_PtxRegister1868 = uint32_t(r_LaneIndexAtPtx4041) + uint32_t(r_PtxRegister1867);		   // PTX L4045
	r_PtxRegister1869 = ShiftRightSigned(int32_t(r_PtxRegister1868), uint32_t(2));			   // PTX L4046
	r_PtxRegister1870 = ShiftRight(uint32_t(r_PtxRegister1869), uint32_t(30));				   // PTX L4047
	r_PtxRegister1871 = uint32_t(r_PtxRegister1869) + uint32_t(r_PtxRegister1870);			   // PTX L4048
	r_PtxRegister1872 = r_PtxRegister1871 & -4;												   // PTX L4049
	r_PtxRegister1873 = uint32_t(r_PtxRegister1869) - uint32_t(r_PtxRegister1872);			   // PTX L4050
	r_PtxRegister1874 = ShiftRight(uint32_t(r_PtxRegister1866), uint32_t(28));				   // PTX L4051
	r_PtxRegister1875 = uint32_t(r_LaneIndexAtPtx4041) + uint32_t(r_PtxRegister1874);		   // PTX L4052
	r_PtxRegister1876 = ShiftRightSigned(int32_t(r_PtxRegister1875), uint32_t(4));			   // PTX L4053
	r_PtxRegister1877 = uint32_t(r_PtxRegister1873) + uint32_t(r_PtxRegister4);				   // PTX L4054
	r_PtxRegister105 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1876);				   // PTX L4055
	r_PtxRegister106 = uint32_t(r_PtxRegister1877) + uint32_t(4);							   // PTX L4056
	r_bPtxPredicate264 = int32_t(r_PtxRegister105) < int32_t(0);							   // PTX L4057
	r_bPtxPredicate265 = int32_t(r_PtxRegister105) >= int32_t(r_Scalar32Bits);				   // PTX L4058
	r_bPtxPredicate266 = int32_t(r_PtxRegister106) >= int32_t(r_Scalar36Bits);				   // PTX L4059
	r_bPtxPredicate267 = r_bPtxPredicate265 | r_bPtxPredicate266;							   // PTX L4060
	r_bPtxPredicate268 = r_bPtxPredicate267 | r_bPtxPredicate264;							   // PTX L4061
	if (r_bPtxPredicate268)
	{
		goto L__BB34_182;
	} // PTX L4062
	r_PtxRegister1878 = r_PtxRegister1868 & -4;										  // PTX L4063
	r_PtxRegister1879 = uint32_t(r_LaneIndexAtPtx4041) - uint32_t(r_PtxRegister1878); // PTX L4064
	r_PtxRegister1880 = ShiftLeft(uint32_t(r_PtxRegister106), uint32_t(2));			  // PTX L4065
	r_PtxRegister1881 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister105); // PTX L4066
	r_PtxRegister1882 =
		uint32_t(r_PtxRegister1881) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1880); // PTX L4067
	r_PtxRegister1883 = uint32_t(r_PtxRegister1882) + uint32_t(r_PtxRegister1879);			   // PTX L4068
	r_PtxU64Register323 = uint64_t(int64_t(int32_t(r_PtxRegister1883)) * int64_t(int32_t(4))); // PTX L4069
	r_PtxU64Register324 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register323);		   // PTX L4070
	*reinterpret_cast<uint32_t*>(r_PtxU64Register324) = r_PackedHalf2AtPtx2019R2672;		   // PTX L4071
L__BB34_182:																				   // PTX L4072
	r_LaneIndexAtPtx4074 = uint32_t((threadIdx.x & 31u));									   // PTX L4074
	r_PtxRegister1885 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4074), uint32_t(31));		   // PTX L4076
	r_PtxRegister1886 = ShiftRight(uint32_t(r_PtxRegister1885), uint32_t(30));				   // PTX L4077
	r_PtxRegister1887 = uint32_t(r_LaneIndexAtPtx4074) + uint32_t(r_PtxRegister1886);		   // PTX L4078
	r_PtxRegister1888 = ShiftRightSigned(int32_t(r_PtxRegister1887), uint32_t(2));			   // PTX L4079
	r_PtxRegister1889 = ShiftRight(uint32_t(r_PtxRegister1888), uint32_t(30));				   // PTX L4080
	r_PtxRegister1890 = uint32_t(r_PtxRegister1888) + uint32_t(r_PtxRegister1889);			   // PTX L4081
	r_PtxRegister1891 = r_PtxRegister1890 & -4;												   // PTX L4082
	r_PtxRegister1892 = uint32_t(r_PtxRegister1888) - uint32_t(r_PtxRegister1891);			   // PTX L4083
	r_PtxRegister1893 = ShiftRight(uint32_t(r_PtxRegister1885), uint32_t(28));				   // PTX L4084
	r_PtxRegister1894 = uint32_t(r_LaneIndexAtPtx4074) + uint32_t(r_PtxRegister1893);		   // PTX L4085
	r_PtxRegister1895 = ShiftRightSigned(int32_t(r_PtxRegister1894), uint32_t(4));			   // PTX L4086
	r_PtxRegister1896 = uint32_t(r_PtxRegister1895) + uint32_t(r_PtxRegister41);			   // PTX L4087
	r_PtxRegister1897 = uint32_t(r_PtxRegister1892) + uint32_t(r_PtxRegister4);				   // PTX L4088
	r_PtxRegister107 = uint32_t(r_PtxRegister1896) + uint32_t(2);							   // PTX L4089
	r_PtxRegister108 = uint32_t(r_PtxRegister1897) + uint32_t(4);							   // PTX L4090
	r_bPtxPredicate269 = int32_t(r_PtxRegister107) < int32_t(0);							   // PTX L4091
	r_bPtxPredicate270 = int32_t(r_PtxRegister107) >= int32_t(r_Scalar32Bits);				   // PTX L4092
	r_bPtxPredicate271 = int32_t(r_PtxRegister108) >= int32_t(r_Scalar36Bits);				   // PTX L4093
	r_bPtxPredicate272 = r_bPtxPredicate270 | r_bPtxPredicate271;							   // PTX L4094
	r_bPtxPredicate273 = r_bPtxPredicate272 | r_bPtxPredicate269;							   // PTX L4095
	if (r_bPtxPredicate273)
	{
		goto L__BB34_184;
	} // PTX L4096
	r_PtxRegister1898 = r_PtxRegister1887 & -4;										  // PTX L4097
	r_PtxRegister1899 = uint32_t(r_LaneIndexAtPtx4074) - uint32_t(r_PtxRegister1898); // PTX L4098
	r_PtxRegister1900 = ShiftLeft(uint32_t(r_PtxRegister108), uint32_t(2));			  // PTX L4099
	r_PtxRegister1901 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister107); // PTX L4100
	r_PtxRegister1902 =
		uint32_t(r_PtxRegister1901) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1900); // PTX L4101
	r_PtxRegister1903 = uint32_t(r_PtxRegister1902) + uint32_t(r_PtxRegister1899);			   // PTX L4102
	r_PtxU64Register325 = uint64_t(int64_t(int32_t(r_PtxRegister1903)) * int64_t(int32_t(4))); // PTX L4103
	r_PtxU64Register326 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register325);		   // PTX L4104
	*reinterpret_cast<uint32_t*>(r_PtxU64Register326) = r_PackedHalf2AtPtx2026R2671;		   // PTX L4105
L__BB34_184:																				   // PTX L4106
	r_LaneIndexAtPtx4108 = uint32_t((threadIdx.x & 31u));									   // PTX L4108
	r_PtxRegister1905 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4108), uint32_t(31));		   // PTX L4110
	r_PtxRegister1906 = ShiftRight(uint32_t(r_PtxRegister1905), uint32_t(30));				   // PTX L4111
	r_PtxRegister1907 = uint32_t(r_LaneIndexAtPtx4108) + uint32_t(r_PtxRegister1906);		   // PTX L4112
	r_PtxRegister1908 = ShiftRightSigned(int32_t(r_PtxRegister1907), uint32_t(2));			   // PTX L4113
	r_PtxRegister1909 = ShiftRight(uint32_t(r_PtxRegister1908), uint32_t(30));				   // PTX L4114
	r_PtxRegister1910 = uint32_t(r_PtxRegister1908) + uint32_t(r_PtxRegister1909);			   // PTX L4115
	r_PtxRegister1911 = r_PtxRegister1910 & -4;												   // PTX L4116
	r_PtxRegister1912 = uint32_t(r_PtxRegister1908) - uint32_t(r_PtxRegister1911);			   // PTX L4117
	r_PtxRegister1913 = ShiftRight(uint32_t(r_PtxRegister1905), uint32_t(28));				   // PTX L4118
	r_PtxRegister1914 = uint32_t(r_LaneIndexAtPtx4108) + uint32_t(r_PtxRegister1913);		   // PTX L4119
	r_PtxRegister1915 = ShiftRightSigned(int32_t(r_PtxRegister1914), uint32_t(4));			   // PTX L4120
	r_PtxRegister1916 = uint32_t(r_PtxRegister1912) + uint32_t(r_PtxRegister4);				   // PTX L4121
	r_PtxRegister109 = uint32_t(r_PtxRegister41) + uint32_t(r_PtxRegister1915);				   // PTX L4122
	r_PtxRegister110 = uint32_t(r_PtxRegister1916) + uint32_t(4);							   // PTX L4123
	r_bPtxPredicate274 = int32_t(r_PtxRegister109) < int32_t(0);							   // PTX L4124
	r_bPtxPredicate275 = int32_t(r_PtxRegister109) >= int32_t(r_Scalar32Bits);				   // PTX L4125
	r_bPtxPredicate276 = int32_t(r_PtxRegister110) >= int32_t(r_Scalar36Bits);				   // PTX L4126
	r_bPtxPredicate277 = r_bPtxPredicate275 | r_bPtxPredicate276;							   // PTX L4127
	r_bPtxPredicate278 = r_bPtxPredicate277 | r_bPtxPredicate274;							   // PTX L4128
	if (r_bPtxPredicate278)
	{
		goto L__BB34_186;
	} // PTX L4129
	r_PtxRegister1917 = r_PtxRegister1907 & -4;										  // PTX L4130
	r_PtxRegister1918 = uint32_t(r_LaneIndexAtPtx4108) - uint32_t(r_PtxRegister1917); // PTX L4131
	r_PtxRegister1919 = ShiftLeft(uint32_t(r_PtxRegister110), uint32_t(2));			  // PTX L4132
	r_PtxRegister1920 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister109); // PTX L4133
	r_PtxRegister1921 =
		uint32_t(r_PtxRegister1920) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1919); // PTX L4134
	r_PtxRegister1922 = uint32_t(r_PtxRegister1921) + uint32_t(r_PtxRegister1918);			   // PTX L4135
	r_PtxU64Register327 = uint64_t(int64_t(int32_t(r_PtxRegister1922)) * int64_t(int32_t(4))); // PTX L4136
	r_PtxU64Register328 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register327);		   // PTX L4137
	*reinterpret_cast<uint32_t*>(r_PtxU64Register328) = r_PackedHalf2AtPtx2033R2670;		   // PTX L4138
L__BB34_186:																				   // PTX L4139
	r_LaneIndexAtPtx4141 = uint32_t((threadIdx.x & 31u));									   // PTX L4141
	r_PtxRegister1924 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4141), uint32_t(31));		   // PTX L4143
	r_PtxRegister1925 = ShiftRight(uint32_t(r_PtxRegister1924), uint32_t(30));				   // PTX L4144
	r_PtxRegister1926 = uint32_t(r_LaneIndexAtPtx4141) + uint32_t(r_PtxRegister1925);		   // PTX L4145
	r_PtxRegister1927 = ShiftRightSigned(int32_t(r_PtxRegister1926), uint32_t(2));			   // PTX L4146
	r_PtxRegister1928 = ShiftRight(uint32_t(r_PtxRegister1927), uint32_t(30));				   // PTX L4147
	r_PtxRegister1929 = uint32_t(r_PtxRegister1927) + uint32_t(r_PtxRegister1928);			   // PTX L4148
	r_PtxRegister1930 = r_PtxRegister1929 & -4;												   // PTX L4149
	r_PtxRegister1931 = uint32_t(r_PtxRegister1927) - uint32_t(r_PtxRegister1930);			   // PTX L4150
	r_PtxRegister1932 = ShiftRight(uint32_t(r_PtxRegister1924), uint32_t(28));				   // PTX L4151
	r_PtxRegister1933 = uint32_t(r_LaneIndexAtPtx4141) + uint32_t(r_PtxRegister1932);		   // PTX L4152
	r_PtxRegister1934 = ShiftRightSigned(int32_t(r_PtxRegister1933), uint32_t(4));			   // PTX L4153
	r_PtxRegister1935 = uint32_t(r_PtxRegister1934) + uint32_t(r_PtxRegister41);			   // PTX L4154
	r_PtxRegister1936 = uint32_t(r_PtxRegister1931) + uint32_t(r_PtxRegister4);				   // PTX L4155
	r_PtxRegister111 = uint32_t(r_PtxRegister1935) + uint32_t(2);							   // PTX L4156
	r_PtxRegister112 = uint32_t(r_PtxRegister1936) + uint32_t(4);							   // PTX L4157
	r_bPtxPredicate279 = int32_t(r_PtxRegister111) < int32_t(0);							   // PTX L4158
	r_bPtxPredicate280 = int32_t(r_PtxRegister111) >= int32_t(r_Scalar32Bits);				   // PTX L4159
	r_bPtxPredicate281 = int32_t(r_PtxRegister112) >= int32_t(r_Scalar36Bits);				   // PTX L4160
	r_bPtxPredicate282 = r_bPtxPredicate280 | r_bPtxPredicate281;							   // PTX L4161
	r_bPtxPredicate283 = r_bPtxPredicate282 | r_bPtxPredicate279;							   // PTX L4162
	if (r_bPtxPredicate283)
	{
		goto L__BB34_188;
	} // PTX L4163
	r_PtxRegister1937 = r_PtxRegister1926 & -4;										  // PTX L4164
	r_PtxRegister1938 = uint32_t(r_LaneIndexAtPtx4141) - uint32_t(r_PtxRegister1937); // PTX L4165
	r_PtxRegister1939 = ShiftLeft(uint32_t(r_PtxRegister112), uint32_t(2));			  // PTX L4166
	r_PtxRegister1940 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister111); // PTX L4167
	r_PtxRegister1941 =
		uint32_t(r_PtxRegister1940) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1939); // PTX L4168
	r_PtxRegister1942 = uint32_t(r_PtxRegister1941) + uint32_t(r_PtxRegister1938);			   // PTX L4169
	r_PtxU64Register329 = uint64_t(int64_t(int32_t(r_PtxRegister1942)) * int64_t(int32_t(4))); // PTX L4170
	r_PtxU64Register330 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register329);		   // PTX L4171
	*reinterpret_cast<uint32_t*>(r_PtxU64Register330) = r_PackedHalf2AtPtx2040R2669;		   // PTX L4172
L__BB34_188:																				   // PTX L4173
	r_LaneIndexAtPtx4175 = uint32_t((threadIdx.x & 31u));									   // PTX L4175
	r_PtxRegister1944 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4175), uint32_t(31));		   // PTX L4177
	r_PtxRegister1945 = ShiftRight(uint32_t(r_PtxRegister1944), uint32_t(30));				   // PTX L4178
	r_PtxRegister1946 = uint32_t(r_LaneIndexAtPtx4175) + uint32_t(r_PtxRegister1945);		   // PTX L4179
	r_PtxRegister1947 = ShiftRightSigned(int32_t(r_PtxRegister1946), uint32_t(2));			   // PTX L4180
	r_PtxRegister1948 = ShiftRight(uint32_t(r_PtxRegister1947), uint32_t(30));				   // PTX L4181
	r_PtxRegister1949 = uint32_t(r_PtxRegister1947) + uint32_t(r_PtxRegister1948);			   // PTX L4182
	r_PtxRegister1950 = r_PtxRegister1949 & -4;												   // PTX L4183
	r_PtxRegister1951 = uint32_t(r_PtxRegister1947) - uint32_t(r_PtxRegister1950);			   // PTX L4184
	r_PtxRegister1952 = ShiftRight(uint32_t(r_PtxRegister1944), uint32_t(28));				   // PTX L4185
	r_PtxRegister1953 = uint32_t(r_LaneIndexAtPtx4175) + uint32_t(r_PtxRegister1952);		   // PTX L4186
	r_PtxRegister1954 = ShiftRightSigned(int32_t(r_PtxRegister1953), uint32_t(4));			   // PTX L4187
	r_PtxRegister1955 = uint32_t(r_PtxRegister1954) + uint32_t(r_PtxRegister41);			   // PTX L4188
	r_PtxRegister113 = uint32_t(r_PtxRegister1955) + uint32_t(4);							   // PTX L4189
	r_PtxRegister114 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1951);				   // PTX L4190
	r_bPtxPredicate284 = int32_t(r_PtxRegister113) < int32_t(0);							   // PTX L4191
	r_bPtxPredicate285 = int32_t(r_PtxRegister113) >= int32_t(r_Scalar32Bits);				   // PTX L4192
	r_bPtxPredicate286 = r_bPtxPredicate284 | r_bPtxPredicate285;							   // PTX L4193
	r_bPtxPredicate287 = int32_t(r_PtxRegister114) < int32_t(0);							   // PTX L4194
	r_bPtxPredicate288 = int32_t(r_PtxRegister114) >= int32_t(r_Scalar36Bits);				   // PTX L4195
	r_bPtxPredicate289 = r_bPtxPredicate287 | r_bPtxPredicate288;							   // PTX L4196
	r_bPtxPredicate290 = r_bPtxPredicate286 | r_bPtxPredicate289;							   // PTX L4197
	if (r_bPtxPredicate290)
	{
		goto L__BB34_190;
	} // PTX L4198
	r_PtxRegister1956 = r_PtxRegister1946 & -4;										  // PTX L4199
	r_PtxRegister1957 = uint32_t(r_LaneIndexAtPtx4175) - uint32_t(r_PtxRegister1956); // PTX L4200
	r_PtxRegister1958 = ShiftLeft(uint32_t(r_PtxRegister114), uint32_t(2));			  // PTX L4201
	r_PtxRegister1959 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister113); // PTX L4202
	r_PtxRegister1960 =
		uint32_t(r_PtxRegister1959) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1958); // PTX L4203
	r_PtxRegister1961 = uint32_t(r_PtxRegister1960) + uint32_t(r_PtxRegister1957);			   // PTX L4204
	r_PtxU64Register331 = uint64_t(int64_t(int32_t(r_PtxRegister1961)) * int64_t(int32_t(4))); // PTX L4205
	r_PtxU64Register332 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register331);		   // PTX L4206
	*reinterpret_cast<uint32_t*>(r_PtxU64Register332) = r_PackedHalf2AtPtx2047R2668;		   // PTX L4207
L__BB34_190:																				   // PTX L4208
	r_LaneIndexAtPtx4210 = uint32_t((threadIdx.x & 31u));									   // PTX L4210
	r_PtxRegister1963 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4210), uint32_t(31));		   // PTX L4212
	r_PtxRegister1964 = ShiftRight(uint32_t(r_PtxRegister1963), uint32_t(30));				   // PTX L4213
	r_PtxRegister1965 = uint32_t(r_LaneIndexAtPtx4210) + uint32_t(r_PtxRegister1964);		   // PTX L4214
	r_PtxRegister1966 = ShiftRightSigned(int32_t(r_PtxRegister1965), uint32_t(2));			   // PTX L4215
	r_PtxRegister1967 = ShiftRight(uint32_t(r_PtxRegister1966), uint32_t(30));				   // PTX L4216
	r_PtxRegister1968 = uint32_t(r_PtxRegister1966) + uint32_t(r_PtxRegister1967);			   // PTX L4217
	r_PtxRegister1969 = r_PtxRegister1968 & -4;												   // PTX L4218
	r_PtxRegister1970 = uint32_t(r_PtxRegister1966) - uint32_t(r_PtxRegister1969);			   // PTX L4219
	r_PtxRegister1971 = ShiftRight(uint32_t(r_PtxRegister1963), uint32_t(28));				   // PTX L4220
	r_PtxRegister1972 = uint32_t(r_LaneIndexAtPtx4210) + uint32_t(r_PtxRegister1971);		   // PTX L4221
	r_PtxRegister1973 = ShiftRightSigned(int32_t(r_PtxRegister1972), uint32_t(4));			   // PTX L4222
	r_PtxRegister1974 = uint32_t(r_PtxRegister1973) + uint32_t(r_PtxRegister41);			   // PTX L4223
	r_PtxRegister115 = uint32_t(r_PtxRegister1974) + uint32_t(6);							   // PTX L4224
	r_PtxRegister116 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1970);				   // PTX L4225
	r_bPtxPredicate291 = int32_t(r_PtxRegister115) < int32_t(0);							   // PTX L4226
	r_bPtxPredicate292 = int32_t(r_PtxRegister115) >= int32_t(r_Scalar32Bits);				   // PTX L4227
	r_bPtxPredicate293 = r_bPtxPredicate291 | r_bPtxPredicate292;							   // PTX L4228
	r_bPtxPredicate294 = int32_t(r_PtxRegister116) < int32_t(0);							   // PTX L4229
	r_bPtxPredicate295 = int32_t(r_PtxRegister116) >= int32_t(r_Scalar36Bits);				   // PTX L4230
	r_bPtxPredicate296 = r_bPtxPredicate294 | r_bPtxPredicate295;							   // PTX L4231
	r_bPtxPredicate297 = r_bPtxPredicate293 | r_bPtxPredicate296;							   // PTX L4232
	if (r_bPtxPredicate297)
	{
		goto L__BB34_192;
	} // PTX L4233
	r_PtxRegister1975 = r_PtxRegister1965 & -4;										  // PTX L4234
	r_PtxRegister1976 = uint32_t(r_LaneIndexAtPtx4210) - uint32_t(r_PtxRegister1975); // PTX L4235
	r_PtxRegister1977 = ShiftLeft(uint32_t(r_PtxRegister116), uint32_t(2));			  // PTX L4236
	r_PtxRegister1978 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister115); // PTX L4237
	r_PtxRegister1979 =
		uint32_t(r_PtxRegister1978) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1977); // PTX L4238
	r_PtxRegister1980 = uint32_t(r_PtxRegister1979) + uint32_t(r_PtxRegister1976);			   // PTX L4239
	r_PtxU64Register333 = uint64_t(int64_t(int32_t(r_PtxRegister1980)) * int64_t(int32_t(4))); // PTX L4240
	r_PtxU64Register334 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register333);		   // PTX L4241
	*reinterpret_cast<uint32_t*>(r_PtxU64Register334) = r_PackedHalf2AtPtx2054R2667;		   // PTX L4242
L__BB34_192:																				   // PTX L4243
	r_LaneIndexAtPtx4245 = uint32_t((threadIdx.x & 31u));									   // PTX L4245
	r_PtxRegister1982 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4245), uint32_t(31));		   // PTX L4247
	r_PtxRegister1983 = ShiftRight(uint32_t(r_PtxRegister1982), uint32_t(30));				   // PTX L4248
	r_PtxRegister1984 = uint32_t(r_LaneIndexAtPtx4245) + uint32_t(r_PtxRegister1983);		   // PTX L4249
	r_PtxRegister1985 = ShiftRightSigned(int32_t(r_PtxRegister1984), uint32_t(2));			   // PTX L4250
	r_PtxRegister1986 = ShiftRight(uint32_t(r_PtxRegister1985), uint32_t(30));				   // PTX L4251
	r_PtxRegister1987 = uint32_t(r_PtxRegister1985) + uint32_t(r_PtxRegister1986);			   // PTX L4252
	r_PtxRegister1988 = r_PtxRegister1987 & -4;												   // PTX L4253
	r_PtxRegister1989 = uint32_t(r_PtxRegister1985) - uint32_t(r_PtxRegister1988);			   // PTX L4254
	r_PtxRegister1990 = ShiftRight(uint32_t(r_PtxRegister1982), uint32_t(28));				   // PTX L4255
	r_PtxRegister1991 = uint32_t(r_LaneIndexAtPtx4245) + uint32_t(r_PtxRegister1990);		   // PTX L4256
	r_PtxRegister1992 = ShiftRightSigned(int32_t(r_PtxRegister1991), uint32_t(4));			   // PTX L4257
	r_PtxRegister1993 = uint32_t(r_PtxRegister1992) + uint32_t(r_PtxRegister41);			   // PTX L4258
	r_PtxRegister117 = uint32_t(r_PtxRegister1993) + uint32_t(4);							   // PTX L4259
	r_PtxRegister118 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister1989);				   // PTX L4260
	r_bPtxPredicate298 = int32_t(r_PtxRegister117) < int32_t(0);							   // PTX L4261
	r_bPtxPredicate299 = int32_t(r_PtxRegister117) >= int32_t(r_Scalar32Bits);				   // PTX L4262
	r_bPtxPredicate300 = r_bPtxPredicate298 | r_bPtxPredicate299;							   // PTX L4263
	r_bPtxPredicate301 = int32_t(r_PtxRegister118) < int32_t(0);							   // PTX L4264
	r_bPtxPredicate302 = int32_t(r_PtxRegister118) >= int32_t(r_Scalar36Bits);				   // PTX L4265
	r_bPtxPredicate303 = r_bPtxPredicate301 | r_bPtxPredicate302;							   // PTX L4266
	r_bPtxPredicate304 = r_bPtxPredicate300 | r_bPtxPredicate303;							   // PTX L4267
	if (r_bPtxPredicate304)
	{
		goto L__BB34_194;
	} // PTX L4268
	r_PtxRegister1994 = r_PtxRegister1984 & -4;										  // PTX L4269
	r_PtxRegister1995 = uint32_t(r_LaneIndexAtPtx4245) - uint32_t(r_PtxRegister1994); // PTX L4270
	r_PtxRegister1996 = ShiftLeft(uint32_t(r_PtxRegister118), uint32_t(2));			  // PTX L4271
	r_PtxRegister1997 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister117); // PTX L4272
	r_PtxRegister1998 =
		uint32_t(r_PtxRegister1997) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister1996); // PTX L4273
	r_PtxRegister1999 = uint32_t(r_PtxRegister1998) + uint32_t(r_PtxRegister1995);			   // PTX L4274
	r_PtxU64Register335 = uint64_t(int64_t(int32_t(r_PtxRegister1999)) * int64_t(int32_t(4))); // PTX L4275
	r_PtxU64Register336 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register335);		   // PTX L4276
	*reinterpret_cast<uint32_t*>(r_PtxU64Register336) = r_PackedHalf2AtPtx2061R2666;		   // PTX L4277
L__BB34_194:																				   // PTX L4278
	r_LaneIndexAtPtx4280 = uint32_t((threadIdx.x & 31u));									   // PTX L4280
	r_PtxRegister2001 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4280), uint32_t(31));		   // PTX L4282
	r_PtxRegister2002 = ShiftRight(uint32_t(r_PtxRegister2001), uint32_t(30));				   // PTX L4283
	r_PtxRegister2003 = uint32_t(r_LaneIndexAtPtx4280) + uint32_t(r_PtxRegister2002);		   // PTX L4284
	r_PtxRegister2004 = ShiftRightSigned(int32_t(r_PtxRegister2003), uint32_t(2));			   // PTX L4285
	r_PtxRegister2005 = ShiftRight(uint32_t(r_PtxRegister2004), uint32_t(30));				   // PTX L4286
	r_PtxRegister2006 = uint32_t(r_PtxRegister2004) + uint32_t(r_PtxRegister2005);			   // PTX L4287
	r_PtxRegister2007 = r_PtxRegister2006 & -4;												   // PTX L4288
	r_PtxRegister2008 = uint32_t(r_PtxRegister2004) - uint32_t(r_PtxRegister2007);			   // PTX L4289
	r_PtxRegister2009 = ShiftRight(uint32_t(r_PtxRegister2001), uint32_t(28));				   // PTX L4290
	r_PtxRegister2010 = uint32_t(r_LaneIndexAtPtx4280) + uint32_t(r_PtxRegister2009);		   // PTX L4291
	r_PtxRegister2011 = ShiftRightSigned(int32_t(r_PtxRegister2010), uint32_t(4));			   // PTX L4292
	r_PtxRegister2012 = uint32_t(r_PtxRegister2011) + uint32_t(r_PtxRegister41);			   // PTX L4293
	r_PtxRegister119 = uint32_t(r_PtxRegister2012) + uint32_t(6);							   // PTX L4294
	r_PtxRegister120 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2008);				   // PTX L4295
	r_bPtxPredicate305 = int32_t(r_PtxRegister119) < int32_t(0);							   // PTX L4296
	r_bPtxPredicate306 = int32_t(r_PtxRegister119) >= int32_t(r_Scalar32Bits);				   // PTX L4297
	r_bPtxPredicate307 = r_bPtxPredicate305 | r_bPtxPredicate306;							   // PTX L4298
	r_bPtxPredicate308 = int32_t(r_PtxRegister120) < int32_t(0);							   // PTX L4299
	r_bPtxPredicate309 = int32_t(r_PtxRegister120) >= int32_t(r_Scalar36Bits);				   // PTX L4300
	r_bPtxPredicate310 = r_bPtxPredicate308 | r_bPtxPredicate309;							   // PTX L4301
	r_bPtxPredicate311 = r_bPtxPredicate307 | r_bPtxPredicate310;							   // PTX L4302
	if (r_bPtxPredicate311)
	{
		goto L__BB34_196;
	} // PTX L4303
	r_PtxRegister2013 = r_PtxRegister2003 & -4;										  // PTX L4304
	r_PtxRegister2014 = uint32_t(r_LaneIndexAtPtx4280) - uint32_t(r_PtxRegister2013); // PTX L4305
	r_PtxRegister2015 = ShiftLeft(uint32_t(r_PtxRegister120), uint32_t(2));			  // PTX L4306
	r_PtxRegister2016 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister119); // PTX L4307
	r_PtxRegister2017 =
		uint32_t(r_PtxRegister2016) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2015); // PTX L4308
	r_PtxRegister2018 = uint32_t(r_PtxRegister2017) + uint32_t(r_PtxRegister2014);			   // PTX L4309
	r_PtxU64Register337 = uint64_t(int64_t(int32_t(r_PtxRegister2018)) * int64_t(int32_t(4))); // PTX L4310
	r_PtxU64Register338 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register337);		   // PTX L4311
	*reinterpret_cast<uint32_t*>(r_PtxU64Register338) = r_PackedHalf2AtPtx2068R2665;		   // PTX L4312
L__BB34_196:																				   // PTX L4313
	r_LaneIndexAtPtx4315 = uint32_t((threadIdx.x & 31u));									   // PTX L4315
	r_PtxRegister2020 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4315), uint32_t(31));		   // PTX L4317
	r_PtxRegister2021 = ShiftRight(uint32_t(r_PtxRegister2020), uint32_t(30));				   // PTX L4318
	r_PtxRegister2022 = uint32_t(r_LaneIndexAtPtx4315) + uint32_t(r_PtxRegister2021);		   // PTX L4319
	r_PtxRegister2023 = ShiftRightSigned(int32_t(r_PtxRegister2022), uint32_t(2));			   // PTX L4320
	r_PtxRegister2024 = ShiftRight(uint32_t(r_PtxRegister2023), uint32_t(30));				   // PTX L4321
	r_PtxRegister2025 = uint32_t(r_PtxRegister2023) + uint32_t(r_PtxRegister2024);			   // PTX L4322
	r_PtxRegister2026 = r_PtxRegister2025 & -4;												   // PTX L4323
	r_PtxRegister2027 = uint32_t(r_PtxRegister2023) - uint32_t(r_PtxRegister2026);			   // PTX L4324
	r_PtxRegister2028 = ShiftRight(uint32_t(r_PtxRegister2020), uint32_t(28));				   // PTX L4325
	r_PtxRegister2029 = uint32_t(r_LaneIndexAtPtx4315) + uint32_t(r_PtxRegister2028);		   // PTX L4326
	r_PtxRegister2030 = ShiftRightSigned(int32_t(r_PtxRegister2029), uint32_t(4));			   // PTX L4327
	r_PtxRegister2031 = uint32_t(r_PtxRegister2030) + uint32_t(r_PtxRegister41);			   // PTX L4328
	r_PtxRegister121 = uint32_t(r_PtxRegister2031) + uint32_t(4);							   // PTX L4329
	r_PtxRegister122 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2027);				   // PTX L4330
	r_bPtxPredicate312 = int32_t(r_PtxRegister121) < int32_t(0);							   // PTX L4331
	r_bPtxPredicate313 = int32_t(r_PtxRegister121) >= int32_t(r_Scalar32Bits);				   // PTX L4332
	r_bPtxPredicate314 = r_bPtxPredicate312 | r_bPtxPredicate313;							   // PTX L4333
	r_bPtxPredicate315 = int32_t(r_PtxRegister122) < int32_t(0);							   // PTX L4334
	r_bPtxPredicate316 = int32_t(r_PtxRegister122) >= int32_t(r_Scalar36Bits);				   // PTX L4335
	r_bPtxPredicate317 = r_bPtxPredicate315 | r_bPtxPredicate316;							   // PTX L4336
	r_bPtxPredicate318 = r_bPtxPredicate314 | r_bPtxPredicate317;							   // PTX L4337
	if (r_bPtxPredicate318)
	{
		goto L__BB34_198;
	} // PTX L4338
	r_PtxRegister2032 = r_PtxRegister2022 & -4;										  // PTX L4339
	r_PtxRegister2033 = uint32_t(r_LaneIndexAtPtx4315) - uint32_t(r_PtxRegister2032); // PTX L4340
	r_PtxRegister2034 = ShiftLeft(uint32_t(r_PtxRegister122), uint32_t(2));			  // PTX L4341
	r_PtxRegister2035 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister121); // PTX L4342
	r_PtxRegister2036 =
		uint32_t(r_PtxRegister2035) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2034); // PTX L4343
	r_PtxRegister2037 = uint32_t(r_PtxRegister2036) + uint32_t(r_PtxRegister2033);			   // PTX L4344
	r_PtxU64Register339 = uint64_t(int64_t(int32_t(r_PtxRegister2037)) * int64_t(int32_t(4))); // PTX L4345
	r_PtxU64Register340 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register339);		   // PTX L4346
	*reinterpret_cast<uint32_t*>(r_PtxU64Register340) = r_PackedHalf2AtPtx2075R2664;		   // PTX L4347
L__BB34_198:																				   // PTX L4348
	r_LaneIndexAtPtx4350 = uint32_t((threadIdx.x & 31u));									   // PTX L4350
	r_PtxRegister2039 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4350), uint32_t(31));		   // PTX L4352
	r_PtxRegister2040 = ShiftRight(uint32_t(r_PtxRegister2039), uint32_t(30));				   // PTX L4353
	r_PtxRegister2041 = uint32_t(r_LaneIndexAtPtx4350) + uint32_t(r_PtxRegister2040);		   // PTX L4354
	r_PtxRegister2042 = ShiftRightSigned(int32_t(r_PtxRegister2041), uint32_t(2));			   // PTX L4355
	r_PtxRegister2043 = ShiftRight(uint32_t(r_PtxRegister2042), uint32_t(30));				   // PTX L4356
	r_PtxRegister2044 = uint32_t(r_PtxRegister2042) + uint32_t(r_PtxRegister2043);			   // PTX L4357
	r_PtxRegister2045 = r_PtxRegister2044 & -4;												   // PTX L4358
	r_PtxRegister2046 = uint32_t(r_PtxRegister2042) - uint32_t(r_PtxRegister2045);			   // PTX L4359
	r_PtxRegister2047 = ShiftRight(uint32_t(r_PtxRegister2039), uint32_t(28));				   // PTX L4360
	r_PtxRegister2048 = uint32_t(r_LaneIndexAtPtx4350) + uint32_t(r_PtxRegister2047);		   // PTX L4361
	r_PtxRegister2049 = ShiftRightSigned(int32_t(r_PtxRegister2048), uint32_t(4));			   // PTX L4362
	r_PtxRegister2050 = uint32_t(r_PtxRegister2049) + uint32_t(r_PtxRegister41);			   // PTX L4363
	r_PtxRegister123 = uint32_t(r_PtxRegister2050) + uint32_t(6);							   // PTX L4364
	r_PtxRegister124 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2046);				   // PTX L4365
	r_bPtxPredicate319 = int32_t(r_PtxRegister123) < int32_t(0);							   // PTX L4366
	r_bPtxPredicate320 = int32_t(r_PtxRegister123) >= int32_t(r_Scalar32Bits);				   // PTX L4367
	r_bPtxPredicate321 = r_bPtxPredicate319 | r_bPtxPredicate320;							   // PTX L4368
	r_bPtxPredicate322 = int32_t(r_PtxRegister124) < int32_t(0);							   // PTX L4369
	r_bPtxPredicate323 = int32_t(r_PtxRegister124) >= int32_t(r_Scalar36Bits);				   // PTX L4370
	r_bPtxPredicate324 = r_bPtxPredicate322 | r_bPtxPredicate323;							   // PTX L4371
	r_bPtxPredicate325 = r_bPtxPredicate321 | r_bPtxPredicate324;							   // PTX L4372
	if (r_bPtxPredicate325)
	{
		goto L__BB34_200;
	} // PTX L4373
	r_PtxRegister2051 = r_PtxRegister2041 & -4;										  // PTX L4374
	r_PtxRegister2052 = uint32_t(r_LaneIndexAtPtx4350) - uint32_t(r_PtxRegister2051); // PTX L4375
	r_PtxRegister2053 = ShiftLeft(uint32_t(r_PtxRegister124), uint32_t(2));			  // PTX L4376
	r_PtxRegister2054 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister123); // PTX L4377
	r_PtxRegister2055 =
		uint32_t(r_PtxRegister2054) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2053); // PTX L4378
	r_PtxRegister2056 = uint32_t(r_PtxRegister2055) + uint32_t(r_PtxRegister2052);			   // PTX L4379
	r_PtxU64Register341 = uint64_t(int64_t(int32_t(r_PtxRegister2056)) * int64_t(int32_t(4))); // PTX L4380
	r_PtxU64Register342 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register341);		   // PTX L4381
	*reinterpret_cast<uint32_t*>(r_PtxU64Register342) = r_PackedHalf2AtPtx2082R2663;		   // PTX L4382
L__BB34_200:																				   // PTX L4383
	r_LaneIndexAtPtx4385 = uint32_t((threadIdx.x & 31u));									   // PTX L4385
	r_PtxRegister2058 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4385), uint32_t(31));		   // PTX L4387
	r_PtxRegister2059 = ShiftRight(uint32_t(r_PtxRegister2058), uint32_t(30));				   // PTX L4388
	r_PtxRegister2060 = uint32_t(r_LaneIndexAtPtx4385) + uint32_t(r_PtxRegister2059);		   // PTX L4389
	r_PtxRegister2061 = ShiftRightSigned(int32_t(r_PtxRegister2060), uint32_t(2));			   // PTX L4390
	r_PtxRegister2062 = ShiftRight(uint32_t(r_PtxRegister2061), uint32_t(30));				   // PTX L4391
	r_PtxRegister2063 = uint32_t(r_PtxRegister2061) + uint32_t(r_PtxRegister2062);			   // PTX L4392
	r_PtxRegister2064 = r_PtxRegister2063 & -4;												   // PTX L4393
	r_PtxRegister2065 = uint32_t(r_PtxRegister2061) - uint32_t(r_PtxRegister2064);			   // PTX L4394
	r_PtxRegister2066 = ShiftRight(uint32_t(r_PtxRegister2058), uint32_t(28));				   // PTX L4395
	r_PtxRegister2067 = uint32_t(r_LaneIndexAtPtx4385) + uint32_t(r_PtxRegister2066);		   // PTX L4396
	r_PtxRegister2068 = ShiftRightSigned(int32_t(r_PtxRegister2067), uint32_t(4));			   // PTX L4397
	r_PtxRegister2069 = uint32_t(r_PtxRegister2068) + uint32_t(r_PtxRegister41);			   // PTX L4398
	r_PtxRegister125 = uint32_t(r_PtxRegister2069) + uint32_t(4);							   // PTX L4399
	r_PtxRegister126 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2065);				   // PTX L4400
	r_bPtxPredicate326 = int32_t(r_PtxRegister125) < int32_t(0);							   // PTX L4401
	r_bPtxPredicate327 = int32_t(r_PtxRegister125) >= int32_t(r_Scalar32Bits);				   // PTX L4402
	r_bPtxPredicate328 = r_bPtxPredicate326 | r_bPtxPredicate327;							   // PTX L4403
	r_bPtxPredicate329 = int32_t(r_PtxRegister126) < int32_t(0);							   // PTX L4404
	r_bPtxPredicate330 = int32_t(r_PtxRegister126) >= int32_t(r_Scalar36Bits);				   // PTX L4405
	r_bPtxPredicate331 = r_bPtxPredicate329 | r_bPtxPredicate330;							   // PTX L4406
	r_bPtxPredicate332 = r_bPtxPredicate328 | r_bPtxPredicate331;							   // PTX L4407
	if (r_bPtxPredicate332)
	{
		goto L__BB34_202;
	} // PTX L4408
	r_PtxRegister2070 = r_PtxRegister2060 & -4;										  // PTX L4409
	r_PtxRegister2071 = uint32_t(r_LaneIndexAtPtx4385) - uint32_t(r_PtxRegister2070); // PTX L4410
	r_PtxRegister2072 = ShiftLeft(uint32_t(r_PtxRegister126), uint32_t(2));			  // PTX L4411
	r_PtxRegister2073 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister125); // PTX L4412
	r_PtxRegister2074 =
		uint32_t(r_PtxRegister2073) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2072); // PTX L4413
	r_PtxRegister2075 = uint32_t(r_PtxRegister2074) + uint32_t(r_PtxRegister2071);			   // PTX L4414
	r_PtxU64Register343 = uint64_t(int64_t(int32_t(r_PtxRegister2075)) * int64_t(int32_t(4))); // PTX L4415
	r_PtxU64Register344 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register343);		   // PTX L4416
	*reinterpret_cast<uint32_t*>(r_PtxU64Register344) = r_PackedHalf2AtPtx2089R2662;		   // PTX L4417
L__BB34_202:																				   // PTX L4418
	r_LaneIndexAtPtx4420 = uint32_t((threadIdx.x & 31u));									   // PTX L4420
	r_PtxRegister2077 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4420), uint32_t(31));		   // PTX L4422
	r_PtxRegister2078 = ShiftRight(uint32_t(r_PtxRegister2077), uint32_t(30));				   // PTX L4423
	r_PtxRegister2079 = uint32_t(r_LaneIndexAtPtx4420) + uint32_t(r_PtxRegister2078);		   // PTX L4424
	r_PtxRegister2080 = ShiftRightSigned(int32_t(r_PtxRegister2079), uint32_t(2));			   // PTX L4425
	r_PtxRegister2081 = ShiftRight(uint32_t(r_PtxRegister2080), uint32_t(30));				   // PTX L4426
	r_PtxRegister2082 = uint32_t(r_PtxRegister2080) + uint32_t(r_PtxRegister2081);			   // PTX L4427
	r_PtxRegister2083 = r_PtxRegister2082 & -4;												   // PTX L4428
	r_PtxRegister2084 = uint32_t(r_PtxRegister2080) - uint32_t(r_PtxRegister2083);			   // PTX L4429
	r_PtxRegister2085 = ShiftRight(uint32_t(r_PtxRegister2077), uint32_t(28));				   // PTX L4430
	r_PtxRegister2086 = uint32_t(r_LaneIndexAtPtx4420) + uint32_t(r_PtxRegister2085);		   // PTX L4431
	r_PtxRegister2087 = ShiftRightSigned(int32_t(r_PtxRegister2086), uint32_t(4));			   // PTX L4432
	r_PtxRegister2088 = uint32_t(r_PtxRegister2087) + uint32_t(r_PtxRegister41);			   // PTX L4433
	r_PtxRegister127 = uint32_t(r_PtxRegister2088) + uint32_t(6);							   // PTX L4434
	r_PtxRegister128 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2084);				   // PTX L4435
	r_bPtxPredicate333 = int32_t(r_PtxRegister127) < int32_t(0);							   // PTX L4436
	r_bPtxPredicate334 = int32_t(r_PtxRegister127) >= int32_t(r_Scalar32Bits);				   // PTX L4437
	r_bPtxPredicate335 = r_bPtxPredicate333 | r_bPtxPredicate334;							   // PTX L4438
	r_bPtxPredicate336 = int32_t(r_PtxRegister128) < int32_t(0);							   // PTX L4439
	r_bPtxPredicate337 = int32_t(r_PtxRegister128) >= int32_t(r_Scalar36Bits);				   // PTX L4440
	r_bPtxPredicate338 = r_bPtxPredicate336 | r_bPtxPredicate337;							   // PTX L4441
	r_bPtxPredicate339 = r_bPtxPredicate335 | r_bPtxPredicate338;							   // PTX L4442
	if (r_bPtxPredicate339)
	{
		goto L__BB34_204;
	} // PTX L4443
	r_PtxRegister2089 = r_PtxRegister2079 & -4;										  // PTX L4444
	r_PtxRegister2090 = uint32_t(r_LaneIndexAtPtx4420) - uint32_t(r_PtxRegister2089); // PTX L4445
	r_PtxRegister2091 = ShiftLeft(uint32_t(r_PtxRegister128), uint32_t(2));			  // PTX L4446
	r_PtxRegister2092 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister127); // PTX L4447
	r_PtxRegister2093 =
		uint32_t(r_PtxRegister2092) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2091); // PTX L4448
	r_PtxRegister2094 = uint32_t(r_PtxRegister2093) + uint32_t(r_PtxRegister2090);			   // PTX L4449
	r_PtxU64Register345 = uint64_t(int64_t(int32_t(r_PtxRegister2094)) * int64_t(int32_t(4))); // PTX L4450
	r_PtxU64Register346 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register345);		   // PTX L4451
	*reinterpret_cast<uint32_t*>(r_PtxU64Register346) = r_PackedHalf2AtPtx2096R2661;		   // PTX L4452
L__BB34_204:																				   // PTX L4453
	r_LaneIndexAtPtx4455 = uint32_t((threadIdx.x & 31u));									   // PTX L4455
	r_PtxRegister2096 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4455), uint32_t(31));		   // PTX L4457
	r_PtxRegister2097 = ShiftRight(uint32_t(r_PtxRegister2096), uint32_t(30));				   // PTX L4458
	r_PtxRegister2098 = uint32_t(r_LaneIndexAtPtx4455) + uint32_t(r_PtxRegister2097);		   // PTX L4459
	r_PtxRegister2099 = ShiftRightSigned(int32_t(r_PtxRegister2098), uint32_t(2));			   // PTX L4460
	r_PtxRegister2100 = ShiftRight(uint32_t(r_PtxRegister2099), uint32_t(30));				   // PTX L4461
	r_PtxRegister2101 = uint32_t(r_PtxRegister2099) + uint32_t(r_PtxRegister2100);			   // PTX L4462
	r_PtxRegister2102 = r_PtxRegister2101 & -4;												   // PTX L4463
	r_PtxRegister2103 = uint32_t(r_PtxRegister2099) - uint32_t(r_PtxRegister2102);			   // PTX L4464
	r_PtxRegister2104 = ShiftRight(uint32_t(r_PtxRegister2096), uint32_t(28));				   // PTX L4465
	r_PtxRegister2105 = uint32_t(r_LaneIndexAtPtx4455) + uint32_t(r_PtxRegister2104);		   // PTX L4466
	r_PtxRegister2106 = ShiftRightSigned(int32_t(r_PtxRegister2105), uint32_t(4));			   // PTX L4467
	r_PtxRegister2107 = uint32_t(r_PtxRegister2106) + uint32_t(r_PtxRegister41);			   // PTX L4468
	r_PtxRegister129 = uint32_t(r_PtxRegister2107) + uint32_t(4);							   // PTX L4469
	r_PtxRegister130 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2103);				   // PTX L4470
	r_bPtxPredicate340 = int32_t(r_PtxRegister129) < int32_t(0);							   // PTX L4471
	r_bPtxPredicate341 = int32_t(r_PtxRegister129) >= int32_t(r_Scalar32Bits);				   // PTX L4472
	r_bPtxPredicate342 = r_bPtxPredicate340 | r_bPtxPredicate341;							   // PTX L4473
	r_bPtxPredicate343 = int32_t(r_PtxRegister130) < int32_t(0);							   // PTX L4474
	r_bPtxPredicate344 = int32_t(r_PtxRegister130) >= int32_t(r_Scalar36Bits);				   // PTX L4475
	r_bPtxPredicate345 = r_bPtxPredicate343 | r_bPtxPredicate344;							   // PTX L4476
	r_bPtxPredicate346 = r_bPtxPredicate342 | r_bPtxPredicate345;							   // PTX L4477
	if (r_bPtxPredicate346)
	{
		goto L__BB34_206;
	} // PTX L4478
	r_PtxRegister2108 = r_PtxRegister2098 & -4;										  // PTX L4479
	r_PtxRegister2109 = uint32_t(r_LaneIndexAtPtx4455) - uint32_t(r_PtxRegister2108); // PTX L4480
	r_PtxRegister2110 = ShiftLeft(uint32_t(r_PtxRegister130), uint32_t(2));			  // PTX L4481
	r_PtxRegister2111 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister129); // PTX L4482
	r_PtxRegister2112 =
		uint32_t(r_PtxRegister2111) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2110); // PTX L4483
	r_PtxRegister2113 = uint32_t(r_PtxRegister2112) + uint32_t(r_PtxRegister2109);			   // PTX L4484
	r_PtxU64Register347 = uint64_t(int64_t(int32_t(r_PtxRegister2113)) * int64_t(int32_t(4))); // PTX L4485
	r_PtxU64Register348 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register347);		   // PTX L4486
	*reinterpret_cast<uint32_t*>(r_PtxU64Register348) = r_PackedHalf2AtPtx2103R2660;		   // PTX L4487
L__BB34_206:																				   // PTX L4488
	r_LaneIndexAtPtx4490 = uint32_t((threadIdx.x & 31u));									   // PTX L4490
	r_PtxRegister2115 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4490), uint32_t(31));		   // PTX L4492
	r_PtxRegister2116 = ShiftRight(uint32_t(r_PtxRegister2115), uint32_t(30));				   // PTX L4493
	r_PtxRegister2117 = uint32_t(r_LaneIndexAtPtx4490) + uint32_t(r_PtxRegister2116);		   // PTX L4494
	r_PtxRegister2118 = ShiftRightSigned(int32_t(r_PtxRegister2117), uint32_t(2));			   // PTX L4495
	r_PtxRegister2119 = ShiftRight(uint32_t(r_PtxRegister2118), uint32_t(30));				   // PTX L4496
	r_PtxRegister2120 = uint32_t(r_PtxRegister2118) + uint32_t(r_PtxRegister2119);			   // PTX L4497
	r_PtxRegister2121 = r_PtxRegister2120 & -4;												   // PTX L4498
	r_PtxRegister2122 = uint32_t(r_PtxRegister2118) - uint32_t(r_PtxRegister2121);			   // PTX L4499
	r_PtxRegister2123 = ShiftRight(uint32_t(r_PtxRegister2115), uint32_t(28));				   // PTX L4500
	r_PtxRegister2124 = uint32_t(r_LaneIndexAtPtx4490) + uint32_t(r_PtxRegister2123);		   // PTX L4501
	r_PtxRegister2125 = ShiftRightSigned(int32_t(r_PtxRegister2124), uint32_t(4));			   // PTX L4502
	r_PtxRegister2126 = uint32_t(r_PtxRegister2125) + uint32_t(r_PtxRegister41);			   // PTX L4503
	r_PtxRegister131 = uint32_t(r_PtxRegister2126) + uint32_t(6);							   // PTX L4504
	r_PtxRegister132 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2122);				   // PTX L4505
	r_bPtxPredicate347 = int32_t(r_PtxRegister131) < int32_t(0);							   // PTX L4506
	r_bPtxPredicate348 = int32_t(r_PtxRegister131) >= int32_t(r_Scalar32Bits);				   // PTX L4507
	r_bPtxPredicate349 = r_bPtxPredicate347 | r_bPtxPredicate348;							   // PTX L4508
	r_bPtxPredicate350 = int32_t(r_PtxRegister132) < int32_t(0);							   // PTX L4509
	r_bPtxPredicate351 = int32_t(r_PtxRegister132) >= int32_t(r_Scalar36Bits);				   // PTX L4510
	r_bPtxPredicate352 = r_bPtxPredicate350 | r_bPtxPredicate351;							   // PTX L4511
	r_bPtxPredicate353 = r_bPtxPredicate349 | r_bPtxPredicate352;							   // PTX L4512
	if (r_bPtxPredicate353)
	{
		goto L__BB34_208;
	} // PTX L4513
	r_PtxRegister2127 = r_PtxRegister2117 & -4;										  // PTX L4514
	r_PtxRegister2128 = uint32_t(r_LaneIndexAtPtx4490) - uint32_t(r_PtxRegister2127); // PTX L4515
	r_PtxRegister2129 = ShiftLeft(uint32_t(r_PtxRegister132), uint32_t(2));			  // PTX L4516
	r_PtxRegister2130 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister131); // PTX L4517
	r_PtxRegister2131 =
		uint32_t(r_PtxRegister2130) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2129); // PTX L4518
	r_PtxRegister2132 = uint32_t(r_PtxRegister2131) + uint32_t(r_PtxRegister2128);			   // PTX L4519
	r_PtxU64Register349 = uint64_t(int64_t(int32_t(r_PtxRegister2132)) * int64_t(int32_t(4))); // PTX L4520
	r_PtxU64Register350 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register349);		   // PTX L4521
	*reinterpret_cast<uint32_t*>(r_PtxU64Register350) = r_PackedHalf2AtPtx2110R2659;		   // PTX L4522
L__BB34_208:																				   // PTX L4523
	r_LaneIndexAtPtx4525 = uint32_t((threadIdx.x & 31u));									   // PTX L4525
	r_PtxRegister2134 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4525), uint32_t(31));		   // PTX L4527
	r_PtxRegister2135 = ShiftRight(uint32_t(r_PtxRegister2134), uint32_t(30));				   // PTX L4528
	r_PtxRegister2136 = uint32_t(r_LaneIndexAtPtx4525) + uint32_t(r_PtxRegister2135);		   // PTX L4529
	r_PtxRegister2137 = ShiftRightSigned(int32_t(r_PtxRegister2136), uint32_t(2));			   // PTX L4530
	r_PtxRegister2138 = ShiftRight(uint32_t(r_PtxRegister2137), uint32_t(30));				   // PTX L4531
	r_PtxRegister2139 = uint32_t(r_PtxRegister2137) + uint32_t(r_PtxRegister2138);			   // PTX L4532
	r_PtxRegister2140 = r_PtxRegister2139 & -4;												   // PTX L4533
	r_PtxRegister2141 = uint32_t(r_PtxRegister2137) - uint32_t(r_PtxRegister2140);			   // PTX L4534
	r_PtxRegister2142 = ShiftRight(uint32_t(r_PtxRegister2134), uint32_t(28));				   // PTX L4535
	r_PtxRegister2143 = uint32_t(r_LaneIndexAtPtx4525) + uint32_t(r_PtxRegister2142);		   // PTX L4536
	r_PtxRegister2144 = ShiftRightSigned(int32_t(r_PtxRegister2143), uint32_t(4));			   // PTX L4537
	r_PtxRegister2145 = uint32_t(r_PtxRegister2144) + uint32_t(r_PtxRegister41);			   // PTX L4538
	r_PtxRegister133 = uint32_t(r_PtxRegister2145) + uint32_t(4);							   // PTX L4539
	r_PtxRegister134 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2141);				   // PTX L4540
	r_bPtxPredicate354 = int32_t(r_PtxRegister133) < int32_t(0);							   // PTX L4541
	r_bPtxPredicate355 = int32_t(r_PtxRegister133) >= int32_t(r_Scalar32Bits);				   // PTX L4542
	r_bPtxPredicate356 = r_bPtxPredicate354 | r_bPtxPredicate355;							   // PTX L4543
	r_bPtxPredicate357 = int32_t(r_PtxRegister134) < int32_t(0);							   // PTX L4544
	r_bPtxPredicate358 = int32_t(r_PtxRegister134) >= int32_t(r_Scalar36Bits);				   // PTX L4545
	r_bPtxPredicate359 = r_bPtxPredicate357 | r_bPtxPredicate358;							   // PTX L4546
	r_bPtxPredicate360 = r_bPtxPredicate356 | r_bPtxPredicate359;							   // PTX L4547
	if (r_bPtxPredicate360)
	{
		goto L__BB34_210;
	} // PTX L4548
	r_PtxRegister2146 = r_PtxRegister2136 & -4;										  // PTX L4549
	r_PtxRegister2147 = uint32_t(r_LaneIndexAtPtx4525) - uint32_t(r_PtxRegister2146); // PTX L4550
	r_PtxRegister2148 = ShiftLeft(uint32_t(r_PtxRegister134), uint32_t(2));			  // PTX L4551
	r_PtxRegister2149 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister133); // PTX L4552
	r_PtxRegister2150 =
		uint32_t(r_PtxRegister2149) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2148); // PTX L4553
	r_PtxRegister2151 = uint32_t(r_PtxRegister2150) + uint32_t(r_PtxRegister2147);			   // PTX L4554
	r_PtxU64Register351 = uint64_t(int64_t(int32_t(r_PtxRegister2151)) * int64_t(int32_t(4))); // PTX L4555
	r_PtxU64Register352 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register351);		   // PTX L4556
	*reinterpret_cast<uint32_t*>(r_PtxU64Register352) = r_PackedHalf2AtPtx2117R2658;		   // PTX L4557
L__BB34_210:																				   // PTX L4558
	r_LaneIndexAtPtx4560 = uint32_t((threadIdx.x & 31u));									   // PTX L4560
	r_PtxRegister2153 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4560), uint32_t(31));		   // PTX L4562
	r_PtxRegister2154 = ShiftRight(uint32_t(r_PtxRegister2153), uint32_t(30));				   // PTX L4563
	r_PtxRegister2155 = uint32_t(r_LaneIndexAtPtx4560) + uint32_t(r_PtxRegister2154);		   // PTX L4564
	r_PtxRegister2156 = ShiftRightSigned(int32_t(r_PtxRegister2155), uint32_t(2));			   // PTX L4565
	r_PtxRegister2157 = ShiftRight(uint32_t(r_PtxRegister2156), uint32_t(30));				   // PTX L4566
	r_PtxRegister2158 = uint32_t(r_PtxRegister2156) + uint32_t(r_PtxRegister2157);			   // PTX L4567
	r_PtxRegister2159 = r_PtxRegister2158 & -4;												   // PTX L4568
	r_PtxRegister2160 = uint32_t(r_PtxRegister2156) - uint32_t(r_PtxRegister2159);			   // PTX L4569
	r_PtxRegister2161 = ShiftRight(uint32_t(r_PtxRegister2153), uint32_t(28));				   // PTX L4570
	r_PtxRegister2162 = uint32_t(r_LaneIndexAtPtx4560) + uint32_t(r_PtxRegister2161);		   // PTX L4571
	r_PtxRegister2163 = ShiftRightSigned(int32_t(r_PtxRegister2162), uint32_t(4));			   // PTX L4572
	r_PtxRegister2164 = uint32_t(r_PtxRegister2163) + uint32_t(r_PtxRegister41);			   // PTX L4573
	r_PtxRegister135 = uint32_t(r_PtxRegister2164) + uint32_t(6);							   // PTX L4574
	r_PtxRegister136 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2160);				   // PTX L4575
	r_bPtxPredicate361 = int32_t(r_PtxRegister135) < int32_t(0);							   // PTX L4576
	r_bPtxPredicate362 = int32_t(r_PtxRegister135) >= int32_t(r_Scalar32Bits);				   // PTX L4577
	r_bPtxPredicate363 = r_bPtxPredicate361 | r_bPtxPredicate362;							   // PTX L4578
	r_bPtxPredicate364 = int32_t(r_PtxRegister136) < int32_t(0);							   // PTX L4579
	r_bPtxPredicate365 = int32_t(r_PtxRegister136) >= int32_t(r_Scalar36Bits);				   // PTX L4580
	r_bPtxPredicate366 = r_bPtxPredicate364 | r_bPtxPredicate365;							   // PTX L4581
	r_bPtxPredicate367 = r_bPtxPredicate363 | r_bPtxPredicate366;							   // PTX L4582
	if (r_bPtxPredicate367)
	{
		goto L__BB34_212;
	} // PTX L4583
	r_PtxRegister2165 = r_PtxRegister2155 & -4;										  // PTX L4584
	r_PtxRegister2166 = uint32_t(r_LaneIndexAtPtx4560) - uint32_t(r_PtxRegister2165); // PTX L4585
	r_PtxRegister2167 = ShiftLeft(uint32_t(r_PtxRegister136), uint32_t(2));			  // PTX L4586
	r_PtxRegister2168 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister135); // PTX L4587
	r_PtxRegister2169 =
		uint32_t(r_PtxRegister2168) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2167); // PTX L4588
	r_PtxRegister2170 = uint32_t(r_PtxRegister2169) + uint32_t(r_PtxRegister2166);			   // PTX L4589
	r_PtxU64Register353 = uint64_t(int64_t(int32_t(r_PtxRegister2170)) * int64_t(int32_t(4))); // PTX L4590
	r_PtxU64Register354 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register353);		   // PTX L4591
	*reinterpret_cast<uint32_t*>(r_PtxU64Register354) = r_PackedHalf2AtPtx2124R2657;		   // PTX L4592
L__BB34_212:																				   // PTX L4593
	r_LaneIndexAtPtx4595 = uint32_t((threadIdx.x & 31u));									   // PTX L4595
	r_PtxRegister2172 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4595), uint32_t(31));		   // PTX L4597
	r_PtxRegister2173 = ShiftRight(uint32_t(r_PtxRegister2172), uint32_t(30));				   // PTX L4598
	r_PtxRegister2174 = uint32_t(r_LaneIndexAtPtx4595) + uint32_t(r_PtxRegister2173);		   // PTX L4599
	r_PtxRegister2175 = ShiftRightSigned(int32_t(r_PtxRegister2174), uint32_t(2));			   // PTX L4600
	r_PtxRegister2176 = ShiftRight(uint32_t(r_PtxRegister2175), uint32_t(30));				   // PTX L4601
	r_PtxRegister2177 = uint32_t(r_PtxRegister2175) + uint32_t(r_PtxRegister2176);			   // PTX L4602
	r_PtxRegister2178 = r_PtxRegister2177 & -4;												   // PTX L4603
	r_PtxRegister2179 = uint32_t(r_PtxRegister2175) - uint32_t(r_PtxRegister2178);			   // PTX L4604
	r_PtxRegister2180 = ShiftRight(uint32_t(r_PtxRegister2172), uint32_t(28));				   // PTX L4605
	r_PtxRegister2181 = uint32_t(r_LaneIndexAtPtx4595) + uint32_t(r_PtxRegister2180);		   // PTX L4606
	r_PtxRegister2182 = ShiftRightSigned(int32_t(r_PtxRegister2181), uint32_t(4));			   // PTX L4607
	r_PtxRegister2183 = uint32_t(r_PtxRegister2182) + uint32_t(r_PtxRegister41);			   // PTX L4608
	r_PtxRegister137 = uint32_t(r_PtxRegister2183) + uint32_t(4);							   // PTX L4609
	r_PtxRegister138 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2179);				   // PTX L4610
	r_bPtxPredicate368 = int32_t(r_PtxRegister137) < int32_t(0);							   // PTX L4611
	r_bPtxPredicate369 = int32_t(r_PtxRegister137) >= int32_t(r_Scalar32Bits);				   // PTX L4612
	r_bPtxPredicate370 = r_bPtxPredicate368 | r_bPtxPredicate369;							   // PTX L4613
	r_bPtxPredicate371 = int32_t(r_PtxRegister138) < int32_t(0);							   // PTX L4614
	r_bPtxPredicate372 = int32_t(r_PtxRegister138) >= int32_t(r_Scalar36Bits);				   // PTX L4615
	r_bPtxPredicate373 = r_bPtxPredicate371 | r_bPtxPredicate372;							   // PTX L4616
	r_bPtxPredicate374 = r_bPtxPredicate370 | r_bPtxPredicate373;							   // PTX L4617
	if (r_bPtxPredicate374)
	{
		goto L__BB34_214;
	} // PTX L4618
	r_PtxRegister2184 = r_PtxRegister2174 & -4;										  // PTX L4619
	r_PtxRegister2185 = uint32_t(r_LaneIndexAtPtx4595) - uint32_t(r_PtxRegister2184); // PTX L4620
	r_PtxRegister2186 = ShiftLeft(uint32_t(r_PtxRegister138), uint32_t(2));			  // PTX L4621
	r_PtxRegister2187 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister137); // PTX L4622
	r_PtxRegister2188 =
		uint32_t(r_PtxRegister2187) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2186); // PTX L4623
	r_PtxRegister2189 = uint32_t(r_PtxRegister2188) + uint32_t(r_PtxRegister2185);			   // PTX L4624
	r_PtxU64Register355 = uint64_t(int64_t(int32_t(r_PtxRegister2189)) * int64_t(int32_t(4))); // PTX L4625
	r_PtxU64Register356 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register355);		   // PTX L4626
	*reinterpret_cast<uint32_t*>(r_PtxU64Register356) = r_PackedHalf2AtPtx2131R2656;		   // PTX L4627
L__BB34_214:																				   // PTX L4628
	r_LaneIndexAtPtx4630 = uint32_t((threadIdx.x & 31u));									   // PTX L4630
	r_PtxRegister2191 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4630), uint32_t(31));		   // PTX L4632
	r_PtxRegister2192 = ShiftRight(uint32_t(r_PtxRegister2191), uint32_t(30));				   // PTX L4633
	r_PtxRegister2193 = uint32_t(r_LaneIndexAtPtx4630) + uint32_t(r_PtxRegister2192);		   // PTX L4634
	r_PtxRegister2194 = ShiftRightSigned(int32_t(r_PtxRegister2193), uint32_t(2));			   // PTX L4635
	r_PtxRegister2195 = ShiftRight(uint32_t(r_PtxRegister2194), uint32_t(30));				   // PTX L4636
	r_PtxRegister2196 = uint32_t(r_PtxRegister2194) + uint32_t(r_PtxRegister2195);			   // PTX L4637
	r_PtxRegister2197 = r_PtxRegister2196 & -4;												   // PTX L4638
	r_PtxRegister2198 = uint32_t(r_PtxRegister2194) - uint32_t(r_PtxRegister2197);			   // PTX L4639
	r_PtxRegister2199 = ShiftRight(uint32_t(r_PtxRegister2191), uint32_t(28));				   // PTX L4640
	r_PtxRegister2200 = uint32_t(r_LaneIndexAtPtx4630) + uint32_t(r_PtxRegister2199);		   // PTX L4641
	r_PtxRegister2201 = ShiftRightSigned(int32_t(r_PtxRegister2200), uint32_t(4));			   // PTX L4642
	r_PtxRegister2202 = uint32_t(r_PtxRegister2201) + uint32_t(r_PtxRegister41);			   // PTX L4643
	r_PtxRegister139 = uint32_t(r_PtxRegister2202) + uint32_t(6);							   // PTX L4644
	r_PtxRegister140 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2198);				   // PTX L4645
	r_bPtxPredicate375 = int32_t(r_PtxRegister139) < int32_t(0);							   // PTX L4646
	r_bPtxPredicate376 = int32_t(r_PtxRegister139) >= int32_t(r_Scalar32Bits);				   // PTX L4647
	r_bPtxPredicate377 = r_bPtxPredicate375 | r_bPtxPredicate376;							   // PTX L4648
	r_bPtxPredicate378 = int32_t(r_PtxRegister140) < int32_t(0);							   // PTX L4649
	r_bPtxPredicate379 = int32_t(r_PtxRegister140) >= int32_t(r_Scalar36Bits);				   // PTX L4650
	r_bPtxPredicate380 = r_bPtxPredicate378 | r_bPtxPredicate379;							   // PTX L4651
	r_bPtxPredicate381 = r_bPtxPredicate377 | r_bPtxPredicate380;							   // PTX L4652
	if (r_bPtxPredicate381)
	{
		goto L__BB34_216;
	} // PTX L4653
	r_PtxRegister2203 = r_PtxRegister2193 & -4;										  // PTX L4654
	r_PtxRegister2204 = uint32_t(r_LaneIndexAtPtx4630) - uint32_t(r_PtxRegister2203); // PTX L4655
	r_PtxRegister2205 = ShiftLeft(uint32_t(r_PtxRegister140), uint32_t(2));			  // PTX L4656
	r_PtxRegister2206 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister139); // PTX L4657
	r_PtxRegister2207 =
		uint32_t(r_PtxRegister2206) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2205); // PTX L4658
	r_PtxRegister2208 = uint32_t(r_PtxRegister2207) + uint32_t(r_PtxRegister2204);			   // PTX L4659
	r_PtxU64Register357 = uint64_t(int64_t(int32_t(r_PtxRegister2208)) * int64_t(int32_t(4))); // PTX L4660
	r_PtxU64Register358 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register357);		   // PTX L4661
	*reinterpret_cast<uint32_t*>(r_PtxU64Register358) = r_PackedHalf2AtPtx2138R2655;		   // PTX L4662
L__BB34_216:																				   // PTX L4663
	r_LaneIndexAtPtx4665 = uint32_t((threadIdx.x & 31u));									   // PTX L4665
	r_PtxRegister2210 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4665), uint32_t(31));		   // PTX L4667
	r_PtxRegister2211 = ShiftRight(uint32_t(r_PtxRegister2210), uint32_t(30));				   // PTX L4668
	r_PtxRegister2212 = uint32_t(r_LaneIndexAtPtx4665) + uint32_t(r_PtxRegister2211);		   // PTX L4669
	r_PtxRegister2213 = ShiftRightSigned(int32_t(r_PtxRegister2212), uint32_t(2));			   // PTX L4670
	r_PtxRegister2214 = ShiftRight(uint32_t(r_PtxRegister2213), uint32_t(30));				   // PTX L4671
	r_PtxRegister2215 = uint32_t(r_PtxRegister2213) + uint32_t(r_PtxRegister2214);			   // PTX L4672
	r_PtxRegister2216 = r_PtxRegister2215 & -4;												   // PTX L4673
	r_PtxRegister2217 = uint32_t(r_PtxRegister2213) - uint32_t(r_PtxRegister2216);			   // PTX L4674
	r_PtxRegister2218 = ShiftRight(uint32_t(r_PtxRegister2210), uint32_t(28));				   // PTX L4675
	r_PtxRegister2219 = uint32_t(r_LaneIndexAtPtx4665) + uint32_t(r_PtxRegister2218);		   // PTX L4676
	r_PtxRegister2220 = ShiftRightSigned(int32_t(r_PtxRegister2219), uint32_t(4));			   // PTX L4677
	r_PtxRegister2221 = uint32_t(r_PtxRegister2220) + uint32_t(r_PtxRegister41);			   // PTX L4678
	r_PtxRegister141 = uint32_t(r_PtxRegister2221) + uint32_t(4);							   // PTX L4679
	r_PtxRegister142 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2217);				   // PTX L4680
	r_bPtxPredicate382 = int32_t(r_PtxRegister141) < int32_t(0);							   // PTX L4681
	r_bPtxPredicate383 = int32_t(r_PtxRegister141) >= int32_t(r_Scalar32Bits);				   // PTX L4682
	r_bPtxPredicate384 = r_bPtxPredicate382 | r_bPtxPredicate383;							   // PTX L4683
	r_bPtxPredicate385 = int32_t(r_PtxRegister142) < int32_t(0);							   // PTX L4684
	r_bPtxPredicate386 = int32_t(r_PtxRegister142) >= int32_t(r_Scalar36Bits);				   // PTX L4685
	r_bPtxPredicate387 = r_bPtxPredicate385 | r_bPtxPredicate386;							   // PTX L4686
	r_bPtxPredicate388 = r_bPtxPredicate384 | r_bPtxPredicate387;							   // PTX L4687
	if (r_bPtxPredicate388)
	{
		goto L__BB34_218;
	} // PTX L4688
	r_PtxRegister2222 = r_PtxRegister2212 & -4;										  // PTX L4689
	r_PtxRegister2223 = uint32_t(r_LaneIndexAtPtx4665) - uint32_t(r_PtxRegister2222); // PTX L4690
	r_PtxRegister2224 = ShiftLeft(uint32_t(r_PtxRegister142), uint32_t(2));			  // PTX L4691
	r_PtxRegister2225 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister141); // PTX L4692
	r_PtxRegister2226 =
		uint32_t(r_PtxRegister2225) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2224); // PTX L4693
	r_PtxRegister2227 = uint32_t(r_PtxRegister2226) + uint32_t(r_PtxRegister2223);			   // PTX L4694
	r_PtxU64Register359 = uint64_t(int64_t(int32_t(r_PtxRegister2227)) * int64_t(int32_t(4))); // PTX L4695
	r_PtxU64Register360 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register359);		   // PTX L4696
	*reinterpret_cast<uint32_t*>(r_PtxU64Register360) = r_PackedHalf2AtPtx2145R2654;		   // PTX L4697
L__BB34_218:																				   // PTX L4698
	r_LaneIndexAtPtx4700 = uint32_t((threadIdx.x & 31u));									   // PTX L4700
	r_PtxRegister2229 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4700), uint32_t(31));		   // PTX L4702
	r_PtxRegister2230 = ShiftRight(uint32_t(r_PtxRegister2229), uint32_t(30));				   // PTX L4703
	r_PtxRegister2231 = uint32_t(r_LaneIndexAtPtx4700) + uint32_t(r_PtxRegister2230);		   // PTX L4704
	r_PtxRegister2232 = ShiftRightSigned(int32_t(r_PtxRegister2231), uint32_t(2));			   // PTX L4705
	r_PtxRegister2233 = ShiftRight(uint32_t(r_PtxRegister2232), uint32_t(30));				   // PTX L4706
	r_PtxRegister2234 = uint32_t(r_PtxRegister2232) + uint32_t(r_PtxRegister2233);			   // PTX L4707
	r_PtxRegister2235 = r_PtxRegister2234 & -4;												   // PTX L4708
	r_PtxRegister2236 = uint32_t(r_PtxRegister2232) - uint32_t(r_PtxRegister2235);			   // PTX L4709
	r_PtxRegister2237 = ShiftRight(uint32_t(r_PtxRegister2229), uint32_t(28));				   // PTX L4710
	r_PtxRegister2238 = uint32_t(r_LaneIndexAtPtx4700) + uint32_t(r_PtxRegister2237);		   // PTX L4711
	r_PtxRegister2239 = ShiftRightSigned(int32_t(r_PtxRegister2238), uint32_t(4));			   // PTX L4712
	r_PtxRegister2240 = uint32_t(r_PtxRegister2239) + uint32_t(r_PtxRegister41);			   // PTX L4713
	r_PtxRegister143 = uint32_t(r_PtxRegister2240) + uint32_t(6);							   // PTX L4714
	r_PtxRegister144 = uint32_t(r_PtxRegister4) + uint32_t(r_PtxRegister2236);				   // PTX L4715
	r_bPtxPredicate389 = int32_t(r_PtxRegister143) < int32_t(0);							   // PTX L4716
	r_bPtxPredicate390 = int32_t(r_PtxRegister143) >= int32_t(r_Scalar32Bits);				   // PTX L4717
	r_bPtxPredicate391 = r_bPtxPredicate389 | r_bPtxPredicate390;							   // PTX L4718
	r_bPtxPredicate392 = int32_t(r_PtxRegister144) < int32_t(0);							   // PTX L4719
	r_bPtxPredicate393 = int32_t(r_PtxRegister144) >= int32_t(r_Scalar36Bits);				   // PTX L4720
	r_bPtxPredicate394 = r_bPtxPredicate392 | r_bPtxPredicate393;							   // PTX L4721
	r_bPtxPredicate395 = r_bPtxPredicate391 | r_bPtxPredicate394;							   // PTX L4722
	if (r_bPtxPredicate395)
	{
		goto L__BB34_220;
	} // PTX L4723
	r_PtxRegister2241 = r_PtxRegister2231 & -4;										  // PTX L4724
	r_PtxRegister2242 = uint32_t(r_LaneIndexAtPtx4700) - uint32_t(r_PtxRegister2241); // PTX L4725
	r_PtxRegister2243 = ShiftLeft(uint32_t(r_PtxRegister144), uint32_t(2));			  // PTX L4726
	r_PtxRegister2244 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister143); // PTX L4727
	r_PtxRegister2245 =
		uint32_t(r_PtxRegister2244) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2243); // PTX L4728
	r_PtxRegister2246 = uint32_t(r_PtxRegister2245) + uint32_t(r_PtxRegister2242);			   // PTX L4729
	r_PtxU64Register361 = uint64_t(int64_t(int32_t(r_PtxRegister2246)) * int64_t(int32_t(4))); // PTX L4730
	r_PtxU64Register362 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register361);		   // PTX L4731
	*reinterpret_cast<uint32_t*>(r_PtxU64Register362) = r_PackedHalf2AtPtx2152R2653;		   // PTX L4732
L__BB34_220:																				   // PTX L4733
	r_LaneIndexAtPtx4735 = uint32_t((threadIdx.x & 31u));									   // PTX L4735
	r_PtxRegister2248 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4735), uint32_t(31));		   // PTX L4737
	r_PtxRegister2249 = ShiftRight(uint32_t(r_PtxRegister2248), uint32_t(30));				   // PTX L4738
	r_PtxRegister2250 = uint32_t(r_LaneIndexAtPtx4735) + uint32_t(r_PtxRegister2249);		   // PTX L4739
	r_PtxRegister2251 = ShiftRightSigned(int32_t(r_PtxRegister2250), uint32_t(2));			   // PTX L4740
	r_PtxRegister2252 = ShiftRight(uint32_t(r_PtxRegister2251), uint32_t(30));				   // PTX L4741
	r_PtxRegister2253 = uint32_t(r_PtxRegister2251) + uint32_t(r_PtxRegister2252);			   // PTX L4742
	r_PtxRegister2254 = r_PtxRegister2253 & -4;												   // PTX L4743
	r_PtxRegister2255 = uint32_t(r_PtxRegister2251) - uint32_t(r_PtxRegister2254);			   // PTX L4744
	r_PtxRegister2256 = ShiftRight(uint32_t(r_PtxRegister2248), uint32_t(28));				   // PTX L4745
	r_PtxRegister2257 = uint32_t(r_LaneIndexAtPtx4735) + uint32_t(r_PtxRegister2256);		   // PTX L4746
	r_PtxRegister2258 = ShiftRightSigned(int32_t(r_PtxRegister2257), uint32_t(4));			   // PTX L4747
	r_PtxRegister2259 = uint32_t(r_PtxRegister2258) + uint32_t(r_PtxRegister41);			   // PTX L4748
	r_PtxRegister2260 = uint32_t(r_PtxRegister2255) + uint32_t(r_PtxRegister4);				   // PTX L4749
	r_PtxRegister145 = uint32_t(r_PtxRegister2259) + uint32_t(4);							   // PTX L4750
	r_PtxRegister146 = uint32_t(r_PtxRegister2260) + uint32_t(4);							   // PTX L4751
	r_bPtxPredicate396 = int32_t(r_PtxRegister145) < int32_t(0);							   // PTX L4752
	r_bPtxPredicate397 = int32_t(r_PtxRegister145) >= int32_t(r_Scalar32Bits);				   // PTX L4753
	r_bPtxPredicate398 = int32_t(r_PtxRegister146) >= int32_t(r_Scalar36Bits);				   // PTX L4754
	r_bPtxPredicate399 = r_bPtxPredicate397 | r_bPtxPredicate398;							   // PTX L4755
	r_bPtxPredicate400 = r_bPtxPredicate399 | r_bPtxPredicate396;							   // PTX L4756
	if (r_bPtxPredicate400)
	{
		goto L__BB34_222;
	} // PTX L4757
	r_PtxRegister2261 = r_PtxRegister2250 & -4;										  // PTX L4758
	r_PtxRegister2262 = uint32_t(r_LaneIndexAtPtx4735) - uint32_t(r_PtxRegister2261); // PTX L4759
	r_PtxRegister2263 = ShiftLeft(uint32_t(r_PtxRegister146), uint32_t(2));			  // PTX L4760
	r_PtxRegister2264 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister145); // PTX L4761
	r_PtxRegister2265 =
		uint32_t(r_PtxRegister2264) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2263); // PTX L4762
	r_PtxRegister2266 = uint32_t(r_PtxRegister2265) + uint32_t(r_PtxRegister2262);			   // PTX L4763
	r_PtxU64Register363 = uint64_t(int64_t(int32_t(r_PtxRegister2266)) * int64_t(int32_t(4))); // PTX L4764
	r_PtxU64Register364 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register363);		   // PTX L4765
	*reinterpret_cast<uint32_t*>(r_PtxU64Register364) = r_PackedHalf2AtPtx2159R2652;		   // PTX L4766
L__BB34_222:																				   // PTX L4767
	r_LaneIndexAtPtx4769 = uint32_t((threadIdx.x & 31u));									   // PTX L4769
	r_PtxRegister2268 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4769), uint32_t(31));		   // PTX L4771
	r_PtxRegister2269 = ShiftRight(uint32_t(r_PtxRegister2268), uint32_t(30));				   // PTX L4772
	r_PtxRegister2270 = uint32_t(r_LaneIndexAtPtx4769) + uint32_t(r_PtxRegister2269);		   // PTX L4773
	r_PtxRegister2271 = ShiftRightSigned(int32_t(r_PtxRegister2270), uint32_t(2));			   // PTX L4774
	r_PtxRegister2272 = ShiftRight(uint32_t(r_PtxRegister2271), uint32_t(30));				   // PTX L4775
	r_PtxRegister2273 = uint32_t(r_PtxRegister2271) + uint32_t(r_PtxRegister2272);			   // PTX L4776
	r_PtxRegister2274 = r_PtxRegister2273 & -4;												   // PTX L4777
	r_PtxRegister2275 = uint32_t(r_PtxRegister2271) - uint32_t(r_PtxRegister2274);			   // PTX L4778
	r_PtxRegister2276 = ShiftRight(uint32_t(r_PtxRegister2268), uint32_t(28));				   // PTX L4779
	r_PtxRegister2277 = uint32_t(r_LaneIndexAtPtx4769) + uint32_t(r_PtxRegister2276);		   // PTX L4780
	r_PtxRegister2278 = ShiftRightSigned(int32_t(r_PtxRegister2277), uint32_t(4));			   // PTX L4781
	r_PtxRegister2279 = uint32_t(r_PtxRegister2278) + uint32_t(r_PtxRegister41);			   // PTX L4782
	r_PtxRegister2280 = uint32_t(r_PtxRegister2275) + uint32_t(r_PtxRegister4);				   // PTX L4783
	r_PtxRegister147 = uint32_t(r_PtxRegister2279) + uint32_t(6);							   // PTX L4784
	r_PtxRegister148 = uint32_t(r_PtxRegister2280) + uint32_t(4);							   // PTX L4785
	r_bPtxPredicate401 = int32_t(r_PtxRegister147) < int32_t(0);							   // PTX L4786
	r_bPtxPredicate402 = int32_t(r_PtxRegister147) >= int32_t(r_Scalar32Bits);				   // PTX L4787
	r_bPtxPredicate403 = int32_t(r_PtxRegister148) >= int32_t(r_Scalar36Bits);				   // PTX L4788
	r_bPtxPredicate404 = r_bPtxPredicate402 | r_bPtxPredicate403;							   // PTX L4789
	r_bPtxPredicate405 = r_bPtxPredicate404 | r_bPtxPredicate401;							   // PTX L4790
	if (r_bPtxPredicate405)
	{
		goto L__BB34_224;
	} // PTX L4791
	r_PtxRegister2281 = r_PtxRegister2270 & -4;										  // PTX L4792
	r_PtxRegister2282 = uint32_t(r_LaneIndexAtPtx4769) - uint32_t(r_PtxRegister2281); // PTX L4793
	r_PtxRegister2283 = ShiftLeft(uint32_t(r_PtxRegister148), uint32_t(2));			  // PTX L4794
	r_PtxRegister2284 =
		uint32_t(r_PtxRegister40) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister147); // PTX L4795
	r_PtxRegister2285 =
		uint32_t(r_PtxRegister2284) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2283); // PTX L4796
	r_PtxRegister2286 = uint32_t(r_PtxRegister2285) + uint32_t(r_PtxRegister2282);			   // PTX L4797
	r_PtxU64Register365 = uint64_t(int64_t(int32_t(r_PtxRegister2286)) * int64_t(int32_t(4))); // PTX L4798
	r_PtxU64Register366 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register365);		   // PTX L4799
	*reinterpret_cast<uint32_t*>(r_PtxU64Register366) = r_PackedHalf2AtPtx2166R2651;		   // PTX L4800
L__BB34_224:																				   // PTX L4801
	r_LaneIndexAtPtx4803 = uint32_t((threadIdx.x & 31u));									   // PTX L4803
	r_PtxRegister2288 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4803), uint32_t(31));		   // PTX L4805
	r_PtxRegister2289 = ShiftRight(uint32_t(r_PtxRegister2288), uint32_t(30));				   // PTX L4806
	r_PtxRegister2290 = uint32_t(r_LaneIndexAtPtx4803) + uint32_t(r_PtxRegister2289);		   // PTX L4807
	r_PtxRegister2291 = ShiftRightSigned(int32_t(r_PtxRegister2290), uint32_t(2));			   // PTX L4808
	r_PtxRegister2292 = ShiftRight(uint32_t(r_PtxRegister2291), uint32_t(30));				   // PTX L4809
	r_PtxRegister2293 = uint32_t(r_PtxRegister2291) + uint32_t(r_PtxRegister2292);			   // PTX L4810
	r_PtxRegister2294 = r_PtxRegister2293 & -4;												   // PTX L4811
	r_PtxRegister2295 = uint32_t(r_PtxRegister2291) - uint32_t(r_PtxRegister2294);			   // PTX L4812
	r_PtxRegister2296 = ShiftRight(uint32_t(r_PtxRegister2288), uint32_t(28));				   // PTX L4813
	r_PtxRegister2297 = uint32_t(r_LaneIndexAtPtx4803) + uint32_t(r_PtxRegister2296);		   // PTX L4814
	r_PtxRegister2298 = ShiftRightSigned(int32_t(r_PtxRegister2297), uint32_t(4));			   // PTX L4815
	r_PtxRegister2299 = uint32_t(r_PtxRegister2298) + uint32_t(r_PtxRegister41);			   // PTX L4816
	r_PtxRegister2300 = uint32_t(r_PtxRegister2295) + uint32_t(r_PtxRegister4);				   // PTX L4817
	r_PtxRegister149 = uint32_t(r_PtxRegister2299) + uint32_t(4);							   // PTX L4818
	r_PtxRegister150 = uint32_t(r_PtxRegister2300) + uint32_t(4);							   // PTX L4819
	r_bPtxPredicate406 = int32_t(r_PtxRegister149) < int32_t(0);							   // PTX L4820
	r_bPtxPredicate407 = int32_t(r_PtxRegister149) >= int32_t(r_Scalar32Bits);				   // PTX L4821
	r_bPtxPredicate408 = int32_t(r_PtxRegister150) >= int32_t(r_Scalar36Bits);				   // PTX L4822
	r_bPtxPredicate409 = r_bPtxPredicate407 | r_bPtxPredicate408;							   // PTX L4823
	r_bPtxPredicate410 = r_bPtxPredicate409 | r_bPtxPredicate406;							   // PTX L4824
	if (r_bPtxPredicate410)
	{
		goto L__BB34_226;
	} // PTX L4825
	r_PtxRegister2301 = r_PtxRegister2290 & -4;										  // PTX L4826
	r_PtxRegister2302 = uint32_t(r_LaneIndexAtPtx4803) - uint32_t(r_PtxRegister2301); // PTX L4827
	r_PtxRegister2303 = ShiftLeft(uint32_t(r_PtxRegister150), uint32_t(2));			  // PTX L4828
	r_PtxRegister2304 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister149); // PTX L4829
	r_PtxRegister2305 =
		uint32_t(r_PtxRegister2304) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2303); // PTX L4830
	r_PtxRegister2306 = uint32_t(r_PtxRegister2305) + uint32_t(r_PtxRegister2302);			   // PTX L4831
	r_PtxU64Register367 = uint64_t(int64_t(int32_t(r_PtxRegister2306)) * int64_t(int32_t(4))); // PTX L4832
	r_PtxU64Register368 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register367);		   // PTX L4833
	*reinterpret_cast<uint32_t*>(r_PtxU64Register368) = r_PackedHalf2AtPtx2173R2650;		   // PTX L4834
L__BB34_226:																				   // PTX L4835
	r_LaneIndexAtPtx4837 = uint32_t((threadIdx.x & 31u));									   // PTX L4837
	r_PtxRegister2308 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4837), uint32_t(31));		   // PTX L4839
	r_PtxRegister2309 = ShiftRight(uint32_t(r_PtxRegister2308), uint32_t(30));				   // PTX L4840
	r_PtxRegister2310 = uint32_t(r_LaneIndexAtPtx4837) + uint32_t(r_PtxRegister2309);		   // PTX L4841
	r_PtxRegister2311 = ShiftRightSigned(int32_t(r_PtxRegister2310), uint32_t(2));			   // PTX L4842
	r_PtxRegister2312 = ShiftRight(uint32_t(r_PtxRegister2311), uint32_t(30));				   // PTX L4843
	r_PtxRegister2313 = uint32_t(r_PtxRegister2311) + uint32_t(r_PtxRegister2312);			   // PTX L4844
	r_PtxRegister2314 = r_PtxRegister2313 & -4;												   // PTX L4845
	r_PtxRegister2315 = uint32_t(r_PtxRegister2311) - uint32_t(r_PtxRegister2314);			   // PTX L4846
	r_PtxRegister2316 = ShiftRight(uint32_t(r_PtxRegister2308), uint32_t(28));				   // PTX L4847
	r_PtxRegister2317 = uint32_t(r_LaneIndexAtPtx4837) + uint32_t(r_PtxRegister2316);		   // PTX L4848
	r_PtxRegister2318 = ShiftRightSigned(int32_t(r_PtxRegister2317), uint32_t(4));			   // PTX L4849
	r_PtxRegister2319 = uint32_t(r_PtxRegister2318) + uint32_t(r_PtxRegister41);			   // PTX L4850
	r_PtxRegister2320 = uint32_t(r_PtxRegister2315) + uint32_t(r_PtxRegister4);				   // PTX L4851
	r_PtxRegister151 = uint32_t(r_PtxRegister2319) + uint32_t(6);							   // PTX L4852
	r_PtxRegister152 = uint32_t(r_PtxRegister2320) + uint32_t(4);							   // PTX L4853
	r_bPtxPredicate411 = int32_t(r_PtxRegister151) < int32_t(0);							   // PTX L4854
	r_bPtxPredicate412 = int32_t(r_PtxRegister151) >= int32_t(r_Scalar32Bits);				   // PTX L4855
	r_bPtxPredicate413 = int32_t(r_PtxRegister152) >= int32_t(r_Scalar36Bits);				   // PTX L4856
	r_bPtxPredicate414 = r_bPtxPredicate412 | r_bPtxPredicate413;							   // PTX L4857
	r_bPtxPredicate415 = r_bPtxPredicate414 | r_bPtxPredicate411;							   // PTX L4858
	if (r_bPtxPredicate415)
	{
		goto L__BB34_228;
	} // PTX L4859
	r_PtxRegister2321 = r_PtxRegister2310 & -4;										  // PTX L4860
	r_PtxRegister2322 = uint32_t(r_LaneIndexAtPtx4837) - uint32_t(r_PtxRegister2321); // PTX L4861
	r_PtxRegister2323 = ShiftLeft(uint32_t(r_PtxRegister152), uint32_t(2));			  // PTX L4862
	r_PtxRegister2324 =
		uint32_t(r_PtxRegister46) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister151); // PTX L4863
	r_PtxRegister2325 =
		uint32_t(r_PtxRegister2324) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2323); // PTX L4864
	r_PtxRegister2326 = uint32_t(r_PtxRegister2325) + uint32_t(r_PtxRegister2322);			   // PTX L4865
	r_PtxU64Register369 = uint64_t(int64_t(int32_t(r_PtxRegister2326)) * int64_t(int32_t(4))); // PTX L4866
	r_PtxU64Register370 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register369);		   // PTX L4867
	*reinterpret_cast<uint32_t*>(r_PtxU64Register370) = r_PackedHalf2AtPtx2180R2649;		   // PTX L4868
L__BB34_228:																				   // PTX L4869
	r_LaneIndexAtPtx4871 = uint32_t((threadIdx.x & 31u));									   // PTX L4871
	r_PtxRegister2328 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4871), uint32_t(31));		   // PTX L4873
	r_PtxRegister2329 = ShiftRight(uint32_t(r_PtxRegister2328), uint32_t(30));				   // PTX L4874
	r_PtxRegister2330 = uint32_t(r_LaneIndexAtPtx4871) + uint32_t(r_PtxRegister2329);		   // PTX L4875
	r_PtxRegister2331 = ShiftRightSigned(int32_t(r_PtxRegister2330), uint32_t(2));			   // PTX L4876
	r_PtxRegister2332 = ShiftRight(uint32_t(r_PtxRegister2331), uint32_t(30));				   // PTX L4877
	r_PtxRegister2333 = uint32_t(r_PtxRegister2331) + uint32_t(r_PtxRegister2332);			   // PTX L4878
	r_PtxRegister2334 = r_PtxRegister2333 & -4;												   // PTX L4879
	r_PtxRegister2335 = uint32_t(r_PtxRegister2331) - uint32_t(r_PtxRegister2334);			   // PTX L4880
	r_PtxRegister2336 = ShiftRight(uint32_t(r_PtxRegister2328), uint32_t(28));				   // PTX L4881
	r_PtxRegister2337 = uint32_t(r_LaneIndexAtPtx4871) + uint32_t(r_PtxRegister2336);		   // PTX L4882
	r_PtxRegister2338 = ShiftRightSigned(int32_t(r_PtxRegister2337), uint32_t(4));			   // PTX L4883
	r_PtxRegister2339 = uint32_t(r_PtxRegister2338) + uint32_t(r_PtxRegister41);			   // PTX L4884
	r_PtxRegister2340 = uint32_t(r_PtxRegister2335) + uint32_t(r_PtxRegister4);				   // PTX L4885
	r_PtxRegister153 = uint32_t(r_PtxRegister2339) + uint32_t(4);							   // PTX L4886
	r_PtxRegister154 = uint32_t(r_PtxRegister2340) + uint32_t(4);							   // PTX L4887
	r_bPtxPredicate416 = int32_t(r_PtxRegister153) < int32_t(0);							   // PTX L4888
	r_bPtxPredicate417 = int32_t(r_PtxRegister153) >= int32_t(r_Scalar32Bits);				   // PTX L4889
	r_bPtxPredicate418 = int32_t(r_PtxRegister154) >= int32_t(r_Scalar36Bits);				   // PTX L4890
	r_bPtxPredicate419 = r_bPtxPredicate417 | r_bPtxPredicate418;							   // PTX L4891
	r_bPtxPredicate420 = r_bPtxPredicate419 | r_bPtxPredicate416;							   // PTX L4892
	if (r_bPtxPredicate420)
	{
		goto L__BB34_230;
	} // PTX L4893
	r_PtxRegister2341 = r_PtxRegister2330 & -4;										  // PTX L4894
	r_PtxRegister2342 = uint32_t(r_LaneIndexAtPtx4871) - uint32_t(r_PtxRegister2341); // PTX L4895
	r_PtxRegister2343 = ShiftLeft(uint32_t(r_PtxRegister154), uint32_t(2));			  // PTX L4896
	r_PtxRegister2344 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister153); // PTX L4897
	r_PtxRegister2345 =
		uint32_t(r_PtxRegister2344) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2343); // PTX L4898
	r_PtxRegister2346 = uint32_t(r_PtxRegister2345) + uint32_t(r_PtxRegister2342);			   // PTX L4899
	r_PtxU64Register371 = uint64_t(int64_t(int32_t(r_PtxRegister2346)) * int64_t(int32_t(4))); // PTX L4900
	r_PtxU64Register372 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register371);		   // PTX L4901
	*reinterpret_cast<uint32_t*>(r_PtxU64Register372) = r_PackedHalf2AtPtx2187R2648;		   // PTX L4902
L__BB34_230:																				   // PTX L4903
	r_LaneIndexAtPtx4905 = uint32_t((threadIdx.x & 31u));									   // PTX L4905
	r_PtxRegister2348 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4905), uint32_t(31));		   // PTX L4907
	r_PtxRegister2349 = ShiftRight(uint32_t(r_PtxRegister2348), uint32_t(30));				   // PTX L4908
	r_PtxRegister2350 = uint32_t(r_LaneIndexAtPtx4905) + uint32_t(r_PtxRegister2349);		   // PTX L4909
	r_PtxRegister2351 = ShiftRightSigned(int32_t(r_PtxRegister2350), uint32_t(2));			   // PTX L4910
	r_PtxRegister2352 = ShiftRight(uint32_t(r_PtxRegister2351), uint32_t(30));				   // PTX L4911
	r_PtxRegister2353 = uint32_t(r_PtxRegister2351) + uint32_t(r_PtxRegister2352);			   // PTX L4912
	r_PtxRegister2354 = r_PtxRegister2353 & -4;												   // PTX L4913
	r_PtxRegister2355 = uint32_t(r_PtxRegister2351) - uint32_t(r_PtxRegister2354);			   // PTX L4914
	r_PtxRegister2356 = ShiftRight(uint32_t(r_PtxRegister2348), uint32_t(28));				   // PTX L4915
	r_PtxRegister2357 = uint32_t(r_LaneIndexAtPtx4905) + uint32_t(r_PtxRegister2356);		   // PTX L4916
	r_PtxRegister2358 = ShiftRightSigned(int32_t(r_PtxRegister2357), uint32_t(4));			   // PTX L4917
	r_PtxRegister2359 = uint32_t(r_PtxRegister2358) + uint32_t(r_PtxRegister41);			   // PTX L4918
	r_PtxRegister2360 = uint32_t(r_PtxRegister2355) + uint32_t(r_PtxRegister4);				   // PTX L4919
	r_PtxRegister155 = uint32_t(r_PtxRegister2359) + uint32_t(6);							   // PTX L4920
	r_PtxRegister156 = uint32_t(r_PtxRegister2360) + uint32_t(4);							   // PTX L4921
	r_bPtxPredicate421 = int32_t(r_PtxRegister155) < int32_t(0);							   // PTX L4922
	r_bPtxPredicate422 = int32_t(r_PtxRegister155) >= int32_t(r_Scalar32Bits);				   // PTX L4923
	r_bPtxPredicate423 = int32_t(r_PtxRegister156) >= int32_t(r_Scalar36Bits);				   // PTX L4924
	r_bPtxPredicate424 = r_bPtxPredicate422 | r_bPtxPredicate423;							   // PTX L4925
	r_bPtxPredicate425 = r_bPtxPredicate424 | r_bPtxPredicate421;							   // PTX L4926
	if (r_bPtxPredicate425)
	{
		goto L__BB34_232;
	} // PTX L4927
	r_PtxRegister2361 = r_PtxRegister2350 & -4;										  // PTX L4928
	r_PtxRegister2362 = uint32_t(r_LaneIndexAtPtx4905) - uint32_t(r_PtxRegister2361); // PTX L4929
	r_PtxRegister2363 = ShiftLeft(uint32_t(r_PtxRegister156), uint32_t(2));			  // PTX L4930
	r_PtxRegister2364 =
		uint32_t(r_PtxRegister51) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister155); // PTX L4931
	r_PtxRegister2365 =
		uint32_t(r_PtxRegister2364) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2363); // PTX L4932
	r_PtxRegister2366 = uint32_t(r_PtxRegister2365) + uint32_t(r_PtxRegister2362);			   // PTX L4933
	r_PtxU64Register373 = uint64_t(int64_t(int32_t(r_PtxRegister2366)) * int64_t(int32_t(4))); // PTX L4934
	r_PtxU64Register374 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register373);		   // PTX L4935
	*reinterpret_cast<uint32_t*>(r_PtxU64Register374) = r_PackedHalf2AtPtx2194R2647;		   // PTX L4936
L__BB34_232:																				   // PTX L4937
	r_LaneIndexAtPtx4939 = uint32_t((threadIdx.x & 31u));									   // PTX L4939
	r_PtxRegister2368 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4939), uint32_t(31));		   // PTX L4941
	r_PtxRegister2369 = ShiftRight(uint32_t(r_PtxRegister2368), uint32_t(30));				   // PTX L4942
	r_PtxRegister2370 = uint32_t(r_LaneIndexAtPtx4939) + uint32_t(r_PtxRegister2369);		   // PTX L4943
	r_PtxRegister2371 = ShiftRightSigned(int32_t(r_PtxRegister2370), uint32_t(2));			   // PTX L4944
	r_PtxRegister2372 = ShiftRight(uint32_t(r_PtxRegister2371), uint32_t(30));				   // PTX L4945
	r_PtxRegister2373 = uint32_t(r_PtxRegister2371) + uint32_t(r_PtxRegister2372);			   // PTX L4946
	r_PtxRegister2374 = r_PtxRegister2373 & -4;												   // PTX L4947
	r_PtxRegister2375 = uint32_t(r_PtxRegister2371) - uint32_t(r_PtxRegister2374);			   // PTX L4948
	r_PtxRegister2376 = ShiftRight(uint32_t(r_PtxRegister2368), uint32_t(28));				   // PTX L4949
	r_PtxRegister2377 = uint32_t(r_LaneIndexAtPtx4939) + uint32_t(r_PtxRegister2376);		   // PTX L4950
	r_PtxRegister2378 = ShiftRightSigned(int32_t(r_PtxRegister2377), uint32_t(4));			   // PTX L4951
	r_PtxRegister2379 = uint32_t(r_PtxRegister2378) + uint32_t(r_PtxRegister41);			   // PTX L4952
	r_PtxRegister2380 = uint32_t(r_PtxRegister2375) + uint32_t(r_PtxRegister4);				   // PTX L4953
	r_PtxRegister157 = uint32_t(r_PtxRegister2379) + uint32_t(4);							   // PTX L4954
	r_PtxRegister158 = uint32_t(r_PtxRegister2380) + uint32_t(4);							   // PTX L4955
	r_bPtxPredicate426 = int32_t(r_PtxRegister157) < int32_t(0);							   // PTX L4956
	r_bPtxPredicate427 = int32_t(r_PtxRegister157) >= int32_t(r_Scalar32Bits);				   // PTX L4957
	r_bPtxPredicate428 = int32_t(r_PtxRegister158) >= int32_t(r_Scalar36Bits);				   // PTX L4958
	r_bPtxPredicate429 = r_bPtxPredicate427 | r_bPtxPredicate428;							   // PTX L4959
	r_bPtxPredicate430 = r_bPtxPredicate429 | r_bPtxPredicate426;							   // PTX L4960
	if (r_bPtxPredicate430)
	{
		goto L__BB34_234;
	} // PTX L4961
	r_PtxRegister2381 = r_PtxRegister2370 & -4;										  // PTX L4962
	r_PtxRegister2382 = uint32_t(r_LaneIndexAtPtx4939) - uint32_t(r_PtxRegister2381); // PTX L4963
	r_PtxRegister2383 = ShiftLeft(uint32_t(r_PtxRegister158), uint32_t(2));			  // PTX L4964
	r_PtxRegister2384 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister157); // PTX L4965
	r_PtxRegister2385 =
		uint32_t(r_PtxRegister2384) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2383); // PTX L4966
	r_PtxRegister2386 = uint32_t(r_PtxRegister2385) + uint32_t(r_PtxRegister2382);			   // PTX L4967
	r_PtxU64Register375 = uint64_t(int64_t(int32_t(r_PtxRegister2386)) * int64_t(int32_t(4))); // PTX L4968
	r_PtxU64Register376 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register375);		   // PTX L4969
	*reinterpret_cast<uint32_t*>(r_PtxU64Register376) = r_PackedHalf2AtPtx2201R2646;		   // PTX L4970
L__BB34_234:																				   // PTX L4971
	r_LaneIndexAtPtx4973 = uint32_t((threadIdx.x & 31u));									   // PTX L4973
	r_PtxRegister2388 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx4973), uint32_t(31));		   // PTX L4975
	r_PtxRegister2389 = ShiftRight(uint32_t(r_PtxRegister2388), uint32_t(30));				   // PTX L4976
	r_PtxRegister2390 = uint32_t(r_LaneIndexAtPtx4973) + uint32_t(r_PtxRegister2389);		   // PTX L4977
	r_PtxRegister2391 = ShiftRightSigned(int32_t(r_PtxRegister2390), uint32_t(2));			   // PTX L4978
	r_PtxRegister2392 = ShiftRight(uint32_t(r_PtxRegister2391), uint32_t(30));				   // PTX L4979
	r_PtxRegister2393 = uint32_t(r_PtxRegister2391) + uint32_t(r_PtxRegister2392);			   // PTX L4980
	r_PtxRegister2394 = r_PtxRegister2393 & -4;												   // PTX L4981
	r_PtxRegister2395 = uint32_t(r_PtxRegister2391) - uint32_t(r_PtxRegister2394);			   // PTX L4982
	r_PtxRegister2396 = ShiftRight(uint32_t(r_PtxRegister2388), uint32_t(28));				   // PTX L4983
	r_PtxRegister2397 = uint32_t(r_LaneIndexAtPtx4973) + uint32_t(r_PtxRegister2396);		   // PTX L4984
	r_PtxRegister2398 = ShiftRightSigned(int32_t(r_PtxRegister2397), uint32_t(4));			   // PTX L4985
	r_PtxRegister2399 = uint32_t(r_PtxRegister2398) + uint32_t(r_PtxRegister41);			   // PTX L4986
	r_PtxRegister2400 = uint32_t(r_PtxRegister2395) + uint32_t(r_PtxRegister4);				   // PTX L4987
	r_PtxRegister159 = uint32_t(r_PtxRegister2399) + uint32_t(6);							   // PTX L4988
	r_PtxRegister160 = uint32_t(r_PtxRegister2400) + uint32_t(4);							   // PTX L4989
	r_bPtxPredicate431 = int32_t(r_PtxRegister159) < int32_t(0);							   // PTX L4990
	r_bPtxPredicate432 = int32_t(r_PtxRegister159) >= int32_t(r_Scalar32Bits);				   // PTX L4991
	r_bPtxPredicate433 = int32_t(r_PtxRegister160) >= int32_t(r_Scalar36Bits);				   // PTX L4992
	r_bPtxPredicate434 = r_bPtxPredicate432 | r_bPtxPredicate433;							   // PTX L4993
	r_bPtxPredicate435 = r_bPtxPredicate434 | r_bPtxPredicate431;							   // PTX L4994
	if (r_bPtxPredicate435)
	{
		goto L__BB34_236;
	} // PTX L4995
	r_PtxRegister2401 = r_PtxRegister2390 & -4;										  // PTX L4996
	r_PtxRegister2402 = uint32_t(r_LaneIndexAtPtx4973) - uint32_t(r_PtxRegister2401); // PTX L4997
	r_PtxRegister2403 = ShiftLeft(uint32_t(r_PtxRegister160), uint32_t(2));			  // PTX L4998
	r_PtxRegister2404 =
		uint32_t(r_PtxRegister56) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister159); // PTX L4999
	r_PtxRegister2405 =
		uint32_t(r_PtxRegister2404) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2403); // PTX L5000
	r_PtxRegister2406 = uint32_t(r_PtxRegister2405) + uint32_t(r_PtxRegister2402);			   // PTX L5001
	r_PtxU64Register377 = uint64_t(int64_t(int32_t(r_PtxRegister2406)) * int64_t(int32_t(4))); // PTX L5002
	r_PtxU64Register378 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register377);		   // PTX L5003
	*reinterpret_cast<uint32_t*>(r_PtxU64Register378) = r_PackedHalf2AtPtx2208R2645;		   // PTX L5004
L__BB34_236:																				   // PTX L5005
	r_LaneIndexAtPtx5007 = uint32_t((threadIdx.x & 31u));									   // PTX L5007
	r_PtxRegister2408 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5007), uint32_t(31));		   // PTX L5009
	r_PtxRegister2409 = ShiftRight(uint32_t(r_PtxRegister2408), uint32_t(30));				   // PTX L5010
	r_PtxRegister2410 = uint32_t(r_LaneIndexAtPtx5007) + uint32_t(r_PtxRegister2409);		   // PTX L5011
	r_PtxRegister2411 = ShiftRightSigned(int32_t(r_PtxRegister2410), uint32_t(2));			   // PTX L5012
	r_PtxRegister2412 = ShiftRight(uint32_t(r_PtxRegister2411), uint32_t(30));				   // PTX L5013
	r_PtxRegister2413 = uint32_t(r_PtxRegister2411) + uint32_t(r_PtxRegister2412);			   // PTX L5014
	r_PtxRegister2414 = r_PtxRegister2413 & -4;												   // PTX L5015
	r_PtxRegister2415 = uint32_t(r_PtxRegister2411) - uint32_t(r_PtxRegister2414);			   // PTX L5016
	r_PtxRegister2416 = ShiftRight(uint32_t(r_PtxRegister2408), uint32_t(28));				   // PTX L5017
	r_PtxRegister2417 = uint32_t(r_LaneIndexAtPtx5007) + uint32_t(r_PtxRegister2416);		   // PTX L5018
	r_PtxRegister2418 = ShiftRightSigned(int32_t(r_PtxRegister2417), uint32_t(4));			   // PTX L5019
	r_PtxRegister2419 = uint32_t(r_PtxRegister2418) + uint32_t(r_PtxRegister41);			   // PTX L5020
	r_PtxRegister2420 = uint32_t(r_PtxRegister2415) + uint32_t(r_PtxRegister4);				   // PTX L5021
	r_PtxRegister161 = uint32_t(r_PtxRegister2419) + uint32_t(4);							   // PTX L5022
	r_PtxRegister162 = uint32_t(r_PtxRegister2420) + uint32_t(4);							   // PTX L5023
	r_bPtxPredicate436 = int32_t(r_PtxRegister161) < int32_t(0);							   // PTX L5024
	r_bPtxPredicate437 = int32_t(r_PtxRegister161) >= int32_t(r_Scalar32Bits);				   // PTX L5025
	r_bPtxPredicate438 = int32_t(r_PtxRegister162) >= int32_t(r_Scalar36Bits);				   // PTX L5026
	r_bPtxPredicate439 = r_bPtxPredicate437 | r_bPtxPredicate438;							   // PTX L5027
	r_bPtxPredicate440 = r_bPtxPredicate439 | r_bPtxPredicate436;							   // PTX L5028
	if (r_bPtxPredicate440)
	{
		goto L__BB34_238;
	} // PTX L5029
	r_PtxRegister2421 = r_PtxRegister2410 & -4;										  // PTX L5030
	r_PtxRegister2422 = uint32_t(r_LaneIndexAtPtx5007) - uint32_t(r_PtxRegister2421); // PTX L5031
	r_PtxRegister2423 = ShiftLeft(uint32_t(r_PtxRegister162), uint32_t(2));			  // PTX L5032
	r_PtxRegister2424 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister161); // PTX L5033
	r_PtxRegister2425 =
		uint32_t(r_PtxRegister2424) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2423); // PTX L5034
	r_PtxRegister2426 = uint32_t(r_PtxRegister2425) + uint32_t(r_PtxRegister2422);			   // PTX L5035
	r_PtxU64Register379 = uint64_t(int64_t(int32_t(r_PtxRegister2426)) * int64_t(int32_t(4))); // PTX L5036
	r_PtxU64Register380 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register379);		   // PTX L5037
	*reinterpret_cast<uint32_t*>(r_PtxU64Register380) = r_PackedHalf2AtPtx2215R2644;		   // PTX L5038
L__BB34_238:																				   // PTX L5039
	r_LaneIndexAtPtx5041 = uint32_t((threadIdx.x & 31u));									   // PTX L5041
	r_PtxRegister2428 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5041), uint32_t(31));		   // PTX L5043
	r_PtxRegister2429 = ShiftRight(uint32_t(r_PtxRegister2428), uint32_t(30));				   // PTX L5044
	r_PtxRegister2430 = uint32_t(r_LaneIndexAtPtx5041) + uint32_t(r_PtxRegister2429);		   // PTX L5045
	r_PtxRegister2431 = ShiftRightSigned(int32_t(r_PtxRegister2430), uint32_t(2));			   // PTX L5046
	r_PtxRegister2432 = ShiftRight(uint32_t(r_PtxRegister2431), uint32_t(30));				   // PTX L5047
	r_PtxRegister2433 = uint32_t(r_PtxRegister2431) + uint32_t(r_PtxRegister2432);			   // PTX L5048
	r_PtxRegister2434 = r_PtxRegister2433 & -4;												   // PTX L5049
	r_PtxRegister2435 = uint32_t(r_PtxRegister2431) - uint32_t(r_PtxRegister2434);			   // PTX L5050
	r_PtxRegister2436 = ShiftRight(uint32_t(r_PtxRegister2428), uint32_t(28));				   // PTX L5051
	r_PtxRegister2437 = uint32_t(r_LaneIndexAtPtx5041) + uint32_t(r_PtxRegister2436);		   // PTX L5052
	r_PtxRegister2438 = ShiftRightSigned(int32_t(r_PtxRegister2437), uint32_t(4));			   // PTX L5053
	r_PtxRegister2439 = uint32_t(r_PtxRegister2438) + uint32_t(r_PtxRegister41);			   // PTX L5054
	r_PtxRegister2440 = uint32_t(r_PtxRegister2435) + uint32_t(r_PtxRegister4);				   // PTX L5055
	r_PtxRegister163 = uint32_t(r_PtxRegister2439) + uint32_t(6);							   // PTX L5056
	r_PtxRegister164 = uint32_t(r_PtxRegister2440) + uint32_t(4);							   // PTX L5057
	r_bPtxPredicate441 = int32_t(r_PtxRegister163) < int32_t(0);							   // PTX L5058
	r_bPtxPredicate442 = int32_t(r_PtxRegister163) >= int32_t(r_Scalar32Bits);				   // PTX L5059
	r_bPtxPredicate443 = int32_t(r_PtxRegister164) >= int32_t(r_Scalar36Bits);				   // PTX L5060
	r_bPtxPredicate444 = r_bPtxPredicate442 | r_bPtxPredicate443;							   // PTX L5061
	r_bPtxPredicate445 = r_bPtxPredicate444 | r_bPtxPredicate441;							   // PTX L5062
	if (r_bPtxPredicate445)
	{
		goto L__BB34_240;
	} // PTX L5063
	r_PtxRegister2441 = r_PtxRegister2430 & -4;										  // PTX L5064
	r_PtxRegister2442 = uint32_t(r_LaneIndexAtPtx5041) - uint32_t(r_PtxRegister2441); // PTX L5065
	r_PtxRegister2443 = ShiftLeft(uint32_t(r_PtxRegister164), uint32_t(2));			  // PTX L5066
	r_PtxRegister2444 =
		uint32_t(r_PtxRegister61) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister163); // PTX L5067
	r_PtxRegister2445 =
		uint32_t(r_PtxRegister2444) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2443); // PTX L5068
	r_PtxRegister2446 = uint32_t(r_PtxRegister2445) + uint32_t(r_PtxRegister2442);			   // PTX L5069
	r_PtxU64Register381 = uint64_t(int64_t(int32_t(r_PtxRegister2446)) * int64_t(int32_t(4))); // PTX L5070
	r_PtxU64Register382 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register381);		   // PTX L5071
	*reinterpret_cast<uint32_t*>(r_PtxU64Register382) = r_PackedHalf2AtPtx2222R2643;		   // PTX L5072
L__BB34_240:																				   // PTX L5073
	r_LaneIndexAtPtx5075 = uint32_t((threadIdx.x & 31u));									   // PTX L5075
	r_PtxRegister2448 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5075), uint32_t(31));		   // PTX L5077
	r_PtxRegister2449 = ShiftRight(uint32_t(r_PtxRegister2448), uint32_t(30));				   // PTX L5078
	r_PtxRegister2450 = uint32_t(r_LaneIndexAtPtx5075) + uint32_t(r_PtxRegister2449);		   // PTX L5079
	r_PtxRegister2451 = ShiftRightSigned(int32_t(r_PtxRegister2450), uint32_t(2));			   // PTX L5080
	r_PtxRegister2452 = ShiftRight(uint32_t(r_PtxRegister2451), uint32_t(30));				   // PTX L5081
	r_PtxRegister2453 = uint32_t(r_PtxRegister2451) + uint32_t(r_PtxRegister2452);			   // PTX L5082
	r_PtxRegister2454 = r_PtxRegister2453 & -4;												   // PTX L5083
	r_PtxRegister2455 = uint32_t(r_PtxRegister2451) - uint32_t(r_PtxRegister2454);			   // PTX L5084
	r_PtxRegister2456 = ShiftRight(uint32_t(r_PtxRegister2448), uint32_t(28));				   // PTX L5085
	r_PtxRegister2457 = uint32_t(r_LaneIndexAtPtx5075) + uint32_t(r_PtxRegister2456);		   // PTX L5086
	r_PtxRegister2458 = ShiftRightSigned(int32_t(r_PtxRegister2457), uint32_t(4));			   // PTX L5087
	r_PtxRegister2459 = uint32_t(r_PtxRegister2458) + uint32_t(r_PtxRegister41);			   // PTX L5088
	r_PtxRegister2460 = uint32_t(r_PtxRegister2455) + uint32_t(r_PtxRegister4);				   // PTX L5089
	r_PtxRegister165 = uint32_t(r_PtxRegister2459) + uint32_t(4);							   // PTX L5090
	r_PtxRegister166 = uint32_t(r_PtxRegister2460) + uint32_t(4);							   // PTX L5091
	r_bPtxPredicate446 = int32_t(r_PtxRegister165) < int32_t(0);							   // PTX L5092
	r_bPtxPredicate447 = int32_t(r_PtxRegister165) >= int32_t(r_Scalar32Bits);				   // PTX L5093
	r_bPtxPredicate448 = int32_t(r_PtxRegister166) >= int32_t(r_Scalar36Bits);				   // PTX L5094
	r_bPtxPredicate449 = r_bPtxPredicate447 | r_bPtxPredicate448;							   // PTX L5095
	r_bPtxPredicate450 = r_bPtxPredicate449 | r_bPtxPredicate446;							   // PTX L5096
	if (r_bPtxPredicate450)
	{
		goto L__BB34_242;
	} // PTX L5097
	r_PtxRegister2461 = r_PtxRegister2450 & -4;										  // PTX L5098
	r_PtxRegister2462 = uint32_t(r_LaneIndexAtPtx5075) - uint32_t(r_PtxRegister2461); // PTX L5099
	r_PtxRegister2463 = ShiftLeft(uint32_t(r_PtxRegister166), uint32_t(2));			  // PTX L5100
	r_PtxRegister2464 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister165); // PTX L5101
	r_PtxRegister2465 =
		uint32_t(r_PtxRegister2464) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2463); // PTX L5102
	r_PtxRegister2466 = uint32_t(r_PtxRegister2465) + uint32_t(r_PtxRegister2462);			   // PTX L5103
	r_PtxU64Register383 = uint64_t(int64_t(int32_t(r_PtxRegister2466)) * int64_t(int32_t(4))); // PTX L5104
	r_PtxU64Register384 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register383);		   // PTX L5105
	*reinterpret_cast<uint32_t*>(r_PtxU64Register384) = r_PackedHalf2AtPtx2229R2642;		   // PTX L5106
L__BB34_242:																				   // PTX L5107
	r_LaneIndexAtPtx5109 = uint32_t((threadIdx.x & 31u));									   // PTX L5109
	r_PtxRegister2468 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5109), uint32_t(31));		   // PTX L5111
	r_PtxRegister2469 = ShiftRight(uint32_t(r_PtxRegister2468), uint32_t(30));				   // PTX L5112
	r_PtxRegister2470 = uint32_t(r_LaneIndexAtPtx5109) + uint32_t(r_PtxRegister2469);		   // PTX L5113
	r_PtxRegister2471 = ShiftRightSigned(int32_t(r_PtxRegister2470), uint32_t(2));			   // PTX L5114
	r_PtxRegister2472 = ShiftRight(uint32_t(r_PtxRegister2471), uint32_t(30));				   // PTX L5115
	r_PtxRegister2473 = uint32_t(r_PtxRegister2471) + uint32_t(r_PtxRegister2472);			   // PTX L5116
	r_PtxRegister2474 = r_PtxRegister2473 & -4;												   // PTX L5117
	r_PtxRegister2475 = uint32_t(r_PtxRegister2471) - uint32_t(r_PtxRegister2474);			   // PTX L5118
	r_PtxRegister2476 = ShiftRight(uint32_t(r_PtxRegister2468), uint32_t(28));				   // PTX L5119
	r_PtxRegister2477 = uint32_t(r_LaneIndexAtPtx5109) + uint32_t(r_PtxRegister2476);		   // PTX L5120
	r_PtxRegister2478 = ShiftRightSigned(int32_t(r_PtxRegister2477), uint32_t(4));			   // PTX L5121
	r_PtxRegister2479 = uint32_t(r_PtxRegister2478) + uint32_t(r_PtxRegister41);			   // PTX L5122
	r_PtxRegister2480 = uint32_t(r_PtxRegister2475) + uint32_t(r_PtxRegister4);				   // PTX L5123
	r_PtxRegister167 = uint32_t(r_PtxRegister2479) + uint32_t(6);							   // PTX L5124
	r_PtxRegister168 = uint32_t(r_PtxRegister2480) + uint32_t(4);							   // PTX L5125
	r_bPtxPredicate451 = int32_t(r_PtxRegister167) < int32_t(0);							   // PTX L5126
	r_bPtxPredicate452 = int32_t(r_PtxRegister167) >= int32_t(r_Scalar32Bits);				   // PTX L5127
	r_bPtxPredicate453 = int32_t(r_PtxRegister168) >= int32_t(r_Scalar36Bits);				   // PTX L5128
	r_bPtxPredicate454 = r_bPtxPredicate452 | r_bPtxPredicate453;							   // PTX L5129
	r_bPtxPredicate455 = r_bPtxPredicate454 | r_bPtxPredicate451;							   // PTX L5130
	if (r_bPtxPredicate455)
	{
		goto L__BB34_244;
	} // PTX L5131
	r_PtxRegister2481 = r_PtxRegister2470 & -4;										  // PTX L5132
	r_PtxRegister2482 = uint32_t(r_LaneIndexAtPtx5109) - uint32_t(r_PtxRegister2481); // PTX L5133
	r_PtxRegister2483 = ShiftLeft(uint32_t(r_PtxRegister168), uint32_t(2));			  // PTX L5134
	r_PtxRegister2484 =
		uint32_t(r_PtxRegister66) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister167); // PTX L5135
	r_PtxRegister2485 =
		uint32_t(r_PtxRegister2484) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2483); // PTX L5136
	r_PtxRegister2486 = uint32_t(r_PtxRegister2485) + uint32_t(r_PtxRegister2482);			   // PTX L5137
	r_PtxU64Register385 = uint64_t(int64_t(int32_t(r_PtxRegister2486)) * int64_t(int32_t(4))); // PTX L5138
	r_PtxU64Register386 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register385);		   // PTX L5139
	*reinterpret_cast<uint32_t*>(r_PtxU64Register386) = r_PackedHalf2AtPtx2236R2641;		   // PTX L5140
L__BB34_244:																				   // PTX L5141
	r_LaneIndexAtPtx5143 = uint32_t((threadIdx.x & 31u));									   // PTX L5143
	r_PtxRegister2488 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5143), uint32_t(31));		   // PTX L5145
	r_PtxRegister2489 = ShiftRight(uint32_t(r_PtxRegister2488), uint32_t(30));				   // PTX L5146
	r_PtxRegister2490 = uint32_t(r_LaneIndexAtPtx5143) + uint32_t(r_PtxRegister2489);		   // PTX L5147
	r_PtxRegister2491 = ShiftRightSigned(int32_t(r_PtxRegister2490), uint32_t(2));			   // PTX L5148
	r_PtxRegister2492 = ShiftRight(uint32_t(r_PtxRegister2491), uint32_t(30));				   // PTX L5149
	r_PtxRegister2493 = uint32_t(r_PtxRegister2491) + uint32_t(r_PtxRegister2492);			   // PTX L5150
	r_PtxRegister2494 = r_PtxRegister2493 & -4;												   // PTX L5151
	r_PtxRegister2495 = uint32_t(r_PtxRegister2491) - uint32_t(r_PtxRegister2494);			   // PTX L5152
	r_PtxRegister2496 = ShiftRight(uint32_t(r_PtxRegister2488), uint32_t(28));				   // PTX L5153
	r_PtxRegister2497 = uint32_t(r_LaneIndexAtPtx5143) + uint32_t(r_PtxRegister2496);		   // PTX L5154
	r_PtxRegister2498 = ShiftRightSigned(int32_t(r_PtxRegister2497), uint32_t(4));			   // PTX L5155
	r_PtxRegister2499 = uint32_t(r_PtxRegister2498) + uint32_t(r_PtxRegister41);			   // PTX L5156
	r_PtxRegister2500 = uint32_t(r_PtxRegister2495) + uint32_t(r_PtxRegister4);				   // PTX L5157
	r_PtxRegister169 = uint32_t(r_PtxRegister2499) + uint32_t(4);							   // PTX L5158
	r_PtxRegister170 = uint32_t(r_PtxRegister2500) + uint32_t(4);							   // PTX L5159
	r_bPtxPredicate456 = int32_t(r_PtxRegister169) < int32_t(0);							   // PTX L5160
	r_bPtxPredicate457 = int32_t(r_PtxRegister169) >= int32_t(r_Scalar32Bits);				   // PTX L5161
	r_bPtxPredicate458 = int32_t(r_PtxRegister170) >= int32_t(r_Scalar36Bits);				   // PTX L5162
	r_bPtxPredicate459 = r_bPtxPredicate457 | r_bPtxPredicate458;							   // PTX L5163
	r_bPtxPredicate460 = r_bPtxPredicate459 | r_bPtxPredicate456;							   // PTX L5164
	if (r_bPtxPredicate460)
	{
		goto L__BB34_246;
	} // PTX L5165
	r_PtxRegister2501 = r_PtxRegister2490 & -4;										  // PTX L5166
	r_PtxRegister2502 = uint32_t(r_LaneIndexAtPtx5143) - uint32_t(r_PtxRegister2501); // PTX L5167
	r_PtxRegister2503 = ShiftLeft(uint32_t(r_PtxRegister170), uint32_t(2));			  // PTX L5168
	r_PtxRegister2504 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister169); // PTX L5169
	r_PtxRegister2505 =
		uint32_t(r_PtxRegister2504) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2503); // PTX L5170
	r_PtxRegister2506 = uint32_t(r_PtxRegister2505) + uint32_t(r_PtxRegister2502);			   // PTX L5171
	r_PtxU64Register387 = uint64_t(int64_t(int32_t(r_PtxRegister2506)) * int64_t(int32_t(4))); // PTX L5172
	r_PtxU64Register388 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register387);		   // PTX L5173
	*reinterpret_cast<uint32_t*>(r_PtxU64Register388) = r_PackedHalf2AtPtx2243R2640;		   // PTX L5174
L__BB34_246:																				   // PTX L5175
	r_LaneIndexAtPtx5177 = uint32_t((threadIdx.x & 31u));									   // PTX L5177
	r_PtxRegister2508 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5177), uint32_t(31));		   // PTX L5179
	r_PtxRegister2509 = ShiftRight(uint32_t(r_PtxRegister2508), uint32_t(30));				   // PTX L5180
	r_PtxRegister2510 = uint32_t(r_LaneIndexAtPtx5177) + uint32_t(r_PtxRegister2509);		   // PTX L5181
	r_PtxRegister2511 = ShiftRightSigned(int32_t(r_PtxRegister2510), uint32_t(2));			   // PTX L5182
	r_PtxRegister2512 = ShiftRight(uint32_t(r_PtxRegister2511), uint32_t(30));				   // PTX L5183
	r_PtxRegister2513 = uint32_t(r_PtxRegister2511) + uint32_t(r_PtxRegister2512);			   // PTX L5184
	r_PtxRegister2514 = r_PtxRegister2513 & -4;												   // PTX L5185
	r_PtxRegister2515 = uint32_t(r_PtxRegister2511) - uint32_t(r_PtxRegister2514);			   // PTX L5186
	r_PtxRegister2516 = ShiftRight(uint32_t(r_PtxRegister2508), uint32_t(28));				   // PTX L5187
	r_PtxRegister2517 = uint32_t(r_LaneIndexAtPtx5177) + uint32_t(r_PtxRegister2516);		   // PTX L5188
	r_PtxRegister2518 = ShiftRightSigned(int32_t(r_PtxRegister2517), uint32_t(4));			   // PTX L5189
	r_PtxRegister2519 = uint32_t(r_PtxRegister2518) + uint32_t(r_PtxRegister41);			   // PTX L5190
	r_PtxRegister2520 = uint32_t(r_PtxRegister2515) + uint32_t(r_PtxRegister4);				   // PTX L5191
	r_PtxRegister171 = uint32_t(r_PtxRegister2519) + uint32_t(6);							   // PTX L5192
	r_PtxRegister172 = uint32_t(r_PtxRegister2520) + uint32_t(4);							   // PTX L5193
	r_bPtxPredicate461 = int32_t(r_PtxRegister171) < int32_t(0);							   // PTX L5194
	r_bPtxPredicate462 = int32_t(r_PtxRegister171) >= int32_t(r_Scalar32Bits);				   // PTX L5195
	r_bPtxPredicate463 = int32_t(r_PtxRegister172) >= int32_t(r_Scalar36Bits);				   // PTX L5196
	r_bPtxPredicate464 = r_bPtxPredicate462 | r_bPtxPredicate463;							   // PTX L5197
	r_bPtxPredicate465 = r_bPtxPredicate464 | r_bPtxPredicate461;							   // PTX L5198
	if (r_bPtxPredicate465)
	{
		goto L__BB34_248;
	} // PTX L5199
	r_PtxRegister2521 = r_PtxRegister2510 & -4;										  // PTX L5200
	r_PtxRegister2522 = uint32_t(r_LaneIndexAtPtx5177) - uint32_t(r_PtxRegister2521); // PTX L5201
	r_PtxRegister2523 = ShiftLeft(uint32_t(r_PtxRegister172), uint32_t(2));			  // PTX L5202
	r_PtxRegister2524 =
		uint32_t(r_PtxRegister71) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister171); // PTX L5203
	r_PtxRegister2525 =
		uint32_t(r_PtxRegister2524) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2523); // PTX L5204
	r_PtxRegister2526 = uint32_t(r_PtxRegister2525) + uint32_t(r_PtxRegister2522);			   // PTX L5205
	r_PtxU64Register389 = uint64_t(int64_t(int32_t(r_PtxRegister2526)) * int64_t(int32_t(4))); // PTX L5206
	r_PtxU64Register390 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register389);		   // PTX L5207
	*reinterpret_cast<uint32_t*>(r_PtxU64Register390) = r_PackedHalf2AtPtx2250R2639;		   // PTX L5208
L__BB34_248:																				   // PTX L5209
	r_LaneIndexAtPtx5211 = uint32_t((threadIdx.x & 31u));									   // PTX L5211
	r_PtxRegister2528 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5211), uint32_t(31));		   // PTX L5213
	r_PtxRegister2529 = ShiftRight(uint32_t(r_PtxRegister2528), uint32_t(30));				   // PTX L5214
	r_PtxRegister2530 = uint32_t(r_LaneIndexAtPtx5211) + uint32_t(r_PtxRegister2529);		   // PTX L5215
	r_PtxRegister2531 = ShiftRightSigned(int32_t(r_PtxRegister2530), uint32_t(2));			   // PTX L5216
	r_PtxRegister2532 = ShiftRight(uint32_t(r_PtxRegister2531), uint32_t(30));				   // PTX L5217
	r_PtxRegister2533 = uint32_t(r_PtxRegister2531) + uint32_t(r_PtxRegister2532);			   // PTX L5218
	r_PtxRegister2534 = r_PtxRegister2533 & -4;												   // PTX L5219
	r_PtxRegister2535 = uint32_t(r_PtxRegister2531) - uint32_t(r_PtxRegister2534);			   // PTX L5220
	r_PtxRegister2536 = ShiftRight(uint32_t(r_PtxRegister2528), uint32_t(28));				   // PTX L5221
	r_PtxRegister2537 = uint32_t(r_LaneIndexAtPtx5211) + uint32_t(r_PtxRegister2536);		   // PTX L5222
	r_PtxRegister2538 = ShiftRightSigned(int32_t(r_PtxRegister2537), uint32_t(4));			   // PTX L5223
	r_PtxRegister2539 = uint32_t(r_PtxRegister2538) + uint32_t(r_PtxRegister41);			   // PTX L5224
	r_PtxRegister2540 = uint32_t(r_PtxRegister2535) + uint32_t(r_PtxRegister4);				   // PTX L5225
	r_PtxRegister173 = uint32_t(r_PtxRegister2539) + uint32_t(4);							   // PTX L5226
	r_PtxRegister174 = uint32_t(r_PtxRegister2540) + uint32_t(4);							   // PTX L5227
	r_bPtxPredicate466 = int32_t(r_PtxRegister173) < int32_t(0);							   // PTX L5228
	r_bPtxPredicate467 = int32_t(r_PtxRegister173) >= int32_t(r_Scalar32Bits);				   // PTX L5229
	r_bPtxPredicate468 = int32_t(r_PtxRegister174) >= int32_t(r_Scalar36Bits);				   // PTX L5230
	r_bPtxPredicate469 = r_bPtxPredicate467 | r_bPtxPredicate468;							   // PTX L5231
	r_bPtxPredicate470 = r_bPtxPredicate469 | r_bPtxPredicate466;							   // PTX L5232
	if (r_bPtxPredicate470)
	{
		goto L__BB34_250;
	} // PTX L5233
	r_PtxRegister2541 = r_PtxRegister2530 & -4;										  // PTX L5234
	r_PtxRegister2542 = uint32_t(r_LaneIndexAtPtx5211) - uint32_t(r_PtxRegister2541); // PTX L5235
	r_PtxRegister2543 = ShiftLeft(uint32_t(r_PtxRegister174), uint32_t(2));			  // PTX L5236
	r_PtxRegister2544 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister173); // PTX L5237
	r_PtxRegister2545 =
		uint32_t(r_PtxRegister2544) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2543); // PTX L5238
	r_PtxRegister2546 = uint32_t(r_PtxRegister2545) + uint32_t(r_PtxRegister2542);			   // PTX L5239
	r_PtxU64Register391 = uint64_t(int64_t(int32_t(r_PtxRegister2546)) * int64_t(int32_t(4))); // PTX L5240
	r_PtxU64Register392 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register391);		   // PTX L5241
	*reinterpret_cast<uint32_t*>(r_PtxU64Register392) = r_PackedHalf2AtPtx2257R2638;		   // PTX L5242
L__BB34_250:																				   // PTX L5243
	r_LaneIndexAtPtx5245 = uint32_t((threadIdx.x & 31u));									   // PTX L5245
	r_PtxRegister2548 = ShiftRightSigned(int32_t(r_LaneIndexAtPtx5245), uint32_t(31));		   // PTX L5247
	r_PtxRegister2549 = ShiftRight(uint32_t(r_PtxRegister2548), uint32_t(30));				   // PTX L5248
	r_PtxRegister2550 = uint32_t(r_LaneIndexAtPtx5245) + uint32_t(r_PtxRegister2549);		   // PTX L5249
	r_PtxRegister2551 = ShiftRightSigned(int32_t(r_PtxRegister2550), uint32_t(2));			   // PTX L5250
	r_PtxRegister2552 = ShiftRight(uint32_t(r_PtxRegister2551), uint32_t(30));				   // PTX L5251
	r_PtxRegister2553 = uint32_t(r_PtxRegister2551) + uint32_t(r_PtxRegister2552);			   // PTX L5252
	r_PtxRegister2554 = r_PtxRegister2553 & -4;												   // PTX L5253
	r_PtxRegister2555 = uint32_t(r_PtxRegister2551) - uint32_t(r_PtxRegister2554);			   // PTX L5254
	r_PtxRegister2556 = ShiftRight(uint32_t(r_PtxRegister2548), uint32_t(28));				   // PTX L5255
	r_PtxRegister2557 = uint32_t(r_LaneIndexAtPtx5245) + uint32_t(r_PtxRegister2556);		   // PTX L5256
	r_PtxRegister2558 = ShiftRightSigned(int32_t(r_PtxRegister2557), uint32_t(4));			   // PTX L5257
	r_PtxRegister2559 = uint32_t(r_PtxRegister2558) + uint32_t(r_PtxRegister41);			   // PTX L5258
	r_PtxRegister2560 = uint32_t(r_PtxRegister2555) + uint32_t(r_PtxRegister4);				   // PTX L5259
	r_PtxRegister175 = uint32_t(r_PtxRegister2559) + uint32_t(6);							   // PTX L5260
	r_PtxRegister176 = uint32_t(r_PtxRegister2560) + uint32_t(4);							   // PTX L5261
	r_bPtxPredicate471 = int32_t(r_PtxRegister175) < int32_t(0);							   // PTX L5262
	r_bPtxPredicate472 = int32_t(r_PtxRegister175) >= int32_t(r_Scalar32Bits);				   // PTX L5263
	r_bPtxPredicate473 = int32_t(r_PtxRegister176) >= int32_t(r_Scalar36Bits);				   // PTX L5264
	r_bPtxPredicate474 = r_bPtxPredicate472 | r_bPtxPredicate473;							   // PTX L5265
	r_bPtxPredicate475 = r_bPtxPredicate474 | r_bPtxPredicate471;							   // PTX L5266
	if (r_bPtxPredicate475)
	{
		goto L__BB34_252;
	} // PTX L5267
	r_PtxRegister2561 = r_PtxRegister2550 & -4;										  // PTX L5268
	r_PtxRegister2562 = uint32_t(r_LaneIndexAtPtx5245) - uint32_t(r_PtxRegister2561); // PTX L5269
	r_PtxRegister2563 = ShiftLeft(uint32_t(r_PtxRegister176), uint32_t(2));			  // PTX L5270
	r_PtxRegister2564 =
		uint32_t(r_PtxRegister76) * uint32_t(r_Scalar32Bits) + uint32_t(r_PtxRegister175); // PTX L5271
	r_PtxRegister2565 =
		uint32_t(r_PtxRegister2564) * uint32_t(r_PtxRegister39) + uint32_t(r_PtxRegister2563); // PTX L5272
	r_PtxRegister2566 = uint32_t(r_PtxRegister2565) + uint32_t(r_PtxRegister2562);			   // PTX L5273
	r_PtxU64Register393 = uint64_t(int64_t(int32_t(r_PtxRegister2566)) * int64_t(int32_t(4))); // PTX L5274
	r_PtxU64Register394 = uint64_t(r_PtxU64Register3) + uint64_t(r_PtxU64Register393);		   // PTX L5275
	*reinterpret_cast<uint32_t*>(r_PtxU64Register394) = r_PackedHalf2AtPtx2264R2637;		   // PTX L5276
L__BB34_252:																				   // PTX L5277
	return;																					   // PTX L5278
#endif
}
} // namespace dlssnr::reconstructed::window_attention_projection_output_view_c512_fp16
